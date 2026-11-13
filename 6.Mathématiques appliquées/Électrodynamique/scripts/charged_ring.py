"""Electric field and potential of a uniformly charged ring.

Two-panel physics-textbook illustration (serif, line-art style), side by side:
  * Left:  3D view of a charged ring in the xy-plane with E arrows along the
           z-axis (magnitude first increases then decreases with |z|).
  * Right: E(z) and V(z) curves vs. axial distance, dual y-axes.

Run with:    uv run python src/electric_field/charged_ring.py
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.lines import Line2D
from matplotlib.patches import FancyArrowPatch
from mpl_toolkits.mplot3d.proj3d import proj_transform

from _viz import Presets


class Arrow3D(FancyArrowPatch):
    """FancyArrowPatch that projects correctly in 3D axes."""

    def __init__(self, start, vec, *args, **kwargs):
        super().__init__((0, 0), (0, 0), *args, **kwargs)
        self._xyz = tuple(start)
        self._dxdydz = tuple(vec)

    def do_3d_projection(self, renderer=None):
        x1, y1, z1 = self._xyz
        dx, dy, dz = self._dxdydz
        x2, y2, z2 = x1 + dx, y1 + dy, z1 + dz
        xs, ys, zs = proj_transform(
            (x1, x2), (y1, y2), (z1, z2), self.axes.M
        )
        self.set_positions((xs[0], ys[0]), (xs[1], ys[1]))
        return float(np.min(zs))


# --------------------------------------------------------------------------- #
# Physical constants & scene
# --------------------------------------------------------------------------- #
K = 8.988e9            # Coulomb constant, N·m²/C²
Q = 1.0e-9             # total ring charge, C
R = 1.0                # ring radius, m

BLU = "#1f4e9b"
RED = "#c0392b"
GRN = "#2e8b57"
GREY = "#888888"

SPEC = Presets.PNG_TEXTBOOK
OUT_DIR = Path(__file__).resolve().parent.parent / "img"


# --------------------------------------------------------------------------- #
# Left panel — 3D model of charged ring with axial E arrows
# --------------------------------------------------------------------------- #
def draw_model(ax):
    ax.set_axis_off()
    ax.set_xlim(-3, 3)
    ax.set_ylim(-3, 3)
    ax.set_zlim(-3, 3)
    ax.set_box_aspect((1, 1, 1))
    ax.view_init(elev=20, azim=-55)

    ax.set_title("Model of Uniformly Charged Ring",
                 fontsize=12, pad=8)

    # Ring in xy-plane.
    theta = np.linspace(0, 2 * np.pi, 200)
    ax.plot(R * np.cos(theta), R * np.sin(theta), np.zeros_like(theta),
            color=BLU, lw=2.4, zorder=2)

    # "+" charge symbols around the ring.
    for i in range(8):
        a = 2 * np.pi * i / 8
        ax.text(R * np.cos(a), R * np.sin(a), 0, "+",
                ha="center", va="center", fontsize=11,
                color=RED, fontweight="bold", zorder=3)

    # Centre marker.
    ax.scatter([0], [0], [0], s=14, color="k", zorder=5)
    ax.text(0.15, 0.15, 0, "O", fontsize=10, zorder=5)

    # z-axis line.
    ax.plot([0, 0], [0, 0], [-2.8, 2.8], color="k", lw=0.8, ls="-")
    ax.text(0.1, 0.1, 2.9, r"$z$", fontsize=13, color="k")

    # Radius label.
    ax.plot([0, R], [0.12, 0.12], [0, 0], color="k", lw=1.0)
    ax.text(R / 2, -0.25, 0, "R", ha="center", va="top",
            fontsize=13, style="italic")

    # E arrows along z-axis — length ∝ |E(z)| = kQ|z|/(z²+R²)^{3/2}.
    def _e_mag(z):
        return abs(z) / (z * z + R * R) ** 1.5

    arrow_scale = 1.8
    z_positions = [0.15, 0.45, 1.0 / np.sqrt(2), 1.3, 2.0]
    for z in z_positions:
        mag = _e_mag(z)
        length = arrow_scale * mag
        ax.add_artist(Arrow3D(
            (0, 0, z), (0, 0, length),
            arrowstyle="-|>", mutation_scale=10,
            color=BLU, lw=1.6,
        ))
        ax.add_artist(Arrow3D(
            (0, 0, -z), (0, 0, -length),
            arrowstyle="-|>", mutation_scale=10,
            color=BLU, lw=1.6,
        ))

    # z = R/√2 marker label.
    z_peak = R / np.sqrt(2)
    ax.text(0.2, 0, z_peak + 0.15, r"$z=R/\sqrt{2}$",
            fontsize=9, color=GREY)

    # Legend.
    handles = [
        Line2D([0], [0], color=BLU, lw=2.4,
               label="Charged ring (radius R)"),
        Line2D([0], [0], marker="+", color=RED, markersize=10,
               markeredgewidth=1.5, linestyle="none",
               label="Positive charge Q"),
        Line2D([0], [0], color=BLU, lw=2.0, marker=">",
               markersize=7, label=r"$E(z)$"),
    ]
    ax.legend(handles=handles, loc="lower right", fontsize=8,
              frameon=True, edgecolor="#cccccc", facecolor="white",
              framealpha=0.9)


# --------------------------------------------------------------------------- #
# Right panel — E(z) and V(z) with dual y-axes
# --------------------------------------------------------------------------- #
def draw_curves(ax_e, ax_v):
    ax_e.set_title("Field and Potential of Uniformly Charged Ring",
                   fontsize=11, pad=8)

    z = np.linspace(-4 * R, 4 * R, 800)

    # E(z) = kQz / (z²+R²)^{3/2}  — antisymmetric, peaks at z = ±R/√2
    E = K * Q * z / (z ** 2 + R ** 2) ** 1.5

    # V(z) = kQ / √(z²+R²)  — symmetric, max at z = 0
    V = K * Q / np.sqrt(z ** 2 + R ** 2)

    ax_e.plot(z, E, color=BLU, lw=2.8, label=r"$E(z)$")
    ax_v.plot(z, V, color=GRN, lw=2.8, label=r"$V(z)$")

    # --- Shared x-axis ---
    ax_e.set_xlim(-4 * R, 4 * R)
    ax_e.set_xlabel("Distance z (m)", fontsize=10)
    ax_e.set_xticks(np.arange(-4 * R, 4 * R + 0.01, 1.0))

    # --- Left y-axis: E ---
    e_peak = 2 * K * Q / (3 * np.sqrt(3) * R ** 2)
    ax_e.set_ylim(-1.4 * e_peak, 1.4 * e_peak)
    ax_e.set_ylabel("E (N/C)", fontsize=10, color=BLU)
    ax_e.tick_params(axis="y", labelcolor=BLU, labelsize=8)

    # --- Right y-axis: V ---
    v0 = K * Q / R
    ax_v.set_ylim(-0.15 * v0, 1.35 * v0)
    ax_v.set_ylabel("V (V)", fontsize=10, color=GRN)
    ax_v.tick_params(axis="y", labelcolor=GRN, labelsize=8)
    ax_v.spines["right"].set_color(GRN)
    ax_v.spines["left"].set_color(BLU)

    # --- Vertical dashed lines ---
    z_peak = R / np.sqrt(2)
    ax_e.axvline(0, color=GREY, ls="--", lw=1.0, zorder=0)
    ax_e.axvline(z_peak, color=GREY, ls="--", lw=1.0, zorder=0)
    ax_e.axvline(-z_peak, color=GREY, ls="--", lw=1.0, zorder=0)
    ax_e.text(0.08, 1.35 * e_peak, r"$z = 0$", fontsize=9,
              color="k", va="top")
    ax_e.text(z_peak + 0.08, 1.35 * e_peak, r"$z = R/\sqrt{2}$",
              fontsize=9, color="k", va="top")
    ax_e.text(-z_peak - 0.08, 1.35 * e_peak, r"$z = -R/\sqrt{2}$",
              fontsize=9, color="k", va="top", ha="right")

    # --- Grid ---
    ax_e.grid(True, which="both", color="#dddddd", lw=0.6)
    ax_e.tick_params(axis="x", labelsize=8)

    # --- Asymptotes ---
    ax_e.axhline(0, color=GREY, ls="--", lw=0.6)
    ax_e.text(4 * R - 0.1, 0.10, r"$E \rightarrow 0$",
              ha="right", va="bottom", fontsize=9, color=GREY, style="italic")
    ax_v.text(4 * R - 0.1, 0.08 * v0, r"$V \rightarrow 0$",
              ha="right", va="bottom", fontsize=9, color=GREY, style="italic")

    # --- Marked points ---
    # E peaks at z = ±R/√2
    ax_e.scatter([z_peak], [e_peak], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)
    ax_e.annotate(
        f"$E_{{max}}$ = {e_peak:.2f}",
        xy=(z_peak, e_peak), xytext=(8, 14),
        textcoords="offset points", fontsize=9, color=BLU,
    )
    ax_e.scatter([-z_peak], [-e_peak], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)
    ax_e.annotate(
        f"{-e_peak:.2f}",
        xy=(-z_peak, -e_peak), xytext=(-40, -14),
        textcoords="offset points", fontsize=9, color=BLU,
    )

    # E = 0 at z = 0
    ax_e.scatter([0], [0], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)

    # V peak at z = 0
    ax_v.scatter([0], [v0], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)
    ax_v.annotate(
        r"$V_0 = \frac{kQ}{R}$" + f" = {v0:.2f}",
        xy=(0, v0), xytext=(12, -4),
        textcoords="offset points", fontsize=9, color=GRN,
    )

    # V at z = ±R/√2
    v_at_peak = K * Q / np.sqrt(z_peak ** 2 + R ** 2)
    ax_v.scatter([z_peak], [v_at_peak], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)
    ax_v.annotate(f"V = {v_at_peak:.2f}", xy=(z_peak, v_at_peak),
                  xytext=(8, -14), textcoords="offset points",
                  fontsize=9, color=GRN)
    ax_v.scatter([-z_peak], [v_at_peak], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)

    # --- Formula boxes ---
    ax_e.text(
        0.03, 0.97,
        r"$\mathbf{E(z) = \dfrac{kQz}{(z^2 + R^2)^{3/2}}}$",
        transform=ax_e.transAxes, ha="left", va="top",
        fontsize=12, color=BLU, fontweight="bold",
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )
    ax_v.text(
        0.03, 0.55,
        r"$\mathbf{V(z) = \dfrac{kQ}{\sqrt{z^2 + R^2}}}$",
        transform=ax_v.transAxes, ha="left", va="top",
        fontsize=12, color=GRN, fontweight="bold",
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )

    # --- Legend ---
    handles = [
        Line2D([0], [0], color=BLU, lw=2.8, label=r"$E(z)$"),
        Line2D([0], [0], color=GRN, lw=2.8, label=r"$V(z)$"),
    ]
    ax_e.legend(handles=handles, loc="lower right", fontsize=9,
                frameon=True, edgecolor="#cccccc", facecolor="white")


# --------------------------------------------------------------------------- #
# Build the figure
# --------------------------------------------------------------------------- #
def build_figure():
    fig = SPEC.figure()
    ax_model = fig.add_subplot(121, projection="3d")
    ax_e = fig.add_subplot(122)
    ax_v = ax_e.twinx()

    fig.subplots_adjust(left=0.06, right=0.94, top=0.92, bottom=0.10,
                        wspace=0.30)

    draw_model(ax_model)
    draw_curves(ax_e, ax_v)

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "charged_ring")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
