"""Electric field and potential of a parallel-plate capacitor.

Two-panel physics-textbook illustration (serif, line-art style), side by side:
  * Left:  3D view of two parallel plates (+Q top, -Q bottom) with uniform E
           arrows between the plates and zero field outside.
  * Right: piecewise E(z) and V(z) curves vs. distance, dual y-axes.

Run with:    uv run python src/electric_field/parallel_plate_capacitor.py
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.lines import Line2D
from matplotlib.patches import FancyArrowPatch
from mpl_toolkits.mplot3d.art3d import Poly3DCollection
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
EPS0 = 8.854e-12
SIGMA = 1.0e-9         # surface charge density, C/m²
D = 1.0                # plate separation, m

FACTOR = SIGMA / EPS0  # σ/ε₀ ≈ 112.9

BLU = "#1f4e9b"
RED = "#c0392b"
GRN = "#2e8b57"
GREY = "#888888"

SPEC = Presets.PNG_TEXTBOOK
OUT_DIR = Path(__file__).resolve().parent.parent / "img"


def _plate_poly(z, hw=2.5, hh=0.6):
    """Return the four corners of a horizontal plate at height *z*."""
    return np.array([
        [-hw, -hh, z], [hw, -hh, z],
        [hw, hh, z], [-hw, hh, z],
    ])


# --------------------------------------------------------------------------- #
# Left panel — 3D model of parallel-plate capacitor
# --------------------------------------------------------------------------- #
def draw_model(ax):
    ax.set_axis_off()
    ax.set_xlim(-3, 3)
    ax.set_ylim(-3, 3)
    ax.set_zlim(-2, 3)
    ax.set_box_aspect((1, 1, 1))
    ax.view_init(elev=22, azim=-55)

    ax.set_title("Model of Parallel-Plate Capacitor",
                 fontsize=12, pad=8)

    # Bottom plate (-Q) — light blue.
    ax.add_collection3d(
        Poly3DCollection(
            [_plate_poly(0)], facecolors="#d6eaf8", edgecolors=BLU,
            linewidths=1.6, alpha=0.85,
        )
    )

    # Top plate (+Q) — light red.
    ax.add_collection3d(
        Poly3DCollection(
            [_plate_poly(D)], facecolors="#fadbd8", edgecolors=RED,
            linewidths=1.6, alpha=0.85,
        )
    )

    # Charge labels on plates.
    ax.text(0, 0, D + 0.08, "+Q", ha="center", va="bottom",
            fontsize=13, color=RED, fontweight="bold", zorder=5)
    ax.text(0, 0, -0.08, "−Q", ha="center", va="top",
            fontsize=13, color=BLU, fontweight="bold", zorder=5)

    # "+" / "−" symbols on each plate surface.
    for x in np.linspace(-2.0, 2.0, 5):
        ax.text(x, 0, D, "+", ha="center", va="center",
                fontsize=10, color=RED, fontweight="bold", zorder=4)
        ax.text(x, 0, 0, "−", ha="center", va="center",
                fontsize=10, color=BLU, fontweight="bold", zorder=4)

    # Plate separation label "d".
    ax.plot([2.8, 2.8], [0, 0], [0, D], color="k", lw=1.0)
    ax.text(2.95, 0, D / 2, "d", fontsize=13, style="italic",
            va="center", ha="left")

    # z-axis.
    ax.plot([0, 0], [0, 0], [-1.8, 2.8], color="k", lw=0.8, ls="-")
    ax.text(0.1, 0.1, 2.9, r"$z$", fontsize=13, color="k")

    # Uniform E arrows between plates (pointing downward: +Q → −Q).
    arrow_len = 0.35
    x_positions = np.linspace(-1.8, 1.8, 7)
    z_starts = np.linspace(0.15, D - 0.15, 3)
    for x in x_positions:
        for z_s in z_starts:
            ax.add_artist(Arrow3D(
                (x, 0, z_s + arrow_len), (0, 0, -arrow_len),
                arrowstyle="-|>", mutation_scale=10,
                color=BLU, lw=1.6,
            ))

    # Legend.
    handles = [
        Line2D([0], [0], color=RED, lw=2.4,
               label="Positive plate (+Q)"),
        Line2D([0], [0], color=BLU, lw=2.4,
               label="Negative plate (−Q)"),
        Line2D([0], [0], color=BLU, lw=2.0, marker=">",
               markersize=7, label="E (uniform)"),
    ]
    ax.legend(handles=handles, loc="lower right", fontsize=8,
              frameon=True, edgecolor="#cccccc", facecolor="white",
              framealpha=0.9)


# --------------------------------------------------------------------------- #
# Right panel — piecewise E(z) and V(z) with dual y-axes
# --------------------------------------------------------------------------- #
def draw_curves(ax_e, ax_v):
    ax_e.set_title("Field and Potential of Parallel-Plate Capacitor",
                   fontsize=11, pad=8)

    # E(z): 0 outside, σ/ε₀ between plates.
    z_e = [-D, 0, 0, D, D, 2 * D]
    E_e = [0, 0, FACTOR, FACTOR, 0, 0]
    ax_e.plot(z_e, E_e, color=BLU, lw=2.8, label=r"$E(z)$")

    # V(z): 0 below, linear rise between, constant above.
    z_v = [-D, 0, 0, D, D, 2 * D]
    V_v = [0, 0, 0, FACTOR * D, FACTOR * D, FACTOR * D]
    ax_v.plot(z_v, V_v, color=GRN, lw=2.8, label=r"$V(z)$")

    # --- Shared x-axis ---
    ax_e.set_xlim(-D, 2 * D)
    ax_e.set_xlabel("Distance z (m)", fontsize=10)
    ax_e.set_xticks([-D, 0, D, 2 * D])
    ax_e.set_xticklabels([r"$-d$", "0", r"$d$", r"$2d$"])

    # --- Left y-axis: E ---
    ax_e.set_ylim(-15, 150)
    ax_e.set_ylabel("E (N/C)", fontsize=10, color=BLU)
    ax_e.set_yticks([0, 30, 60, 90, 120])
    ax_e.tick_params(axis="y", labelcolor=BLU, labelsize=8)

    # --- Right y-axis: V ---
    ax_v.set_ylim(-15, 150)
    ax_v.set_ylabel("V (V)", fontsize=10, color=GRN)
    ax_v.set_yticks([0, 30, 60, 90, 120])
    ax_v.tick_params(axis="y", labelcolor=GRN, labelsize=8)
    ax_v.spines["right"].set_color(GRN)
    ax_v.spines["left"].set_color(BLU)

    # --- Vertical dashed lines at z = 0 and z = d ---
    ax_e.axvline(0, color=GREY, ls="--", lw=1.0, zorder=0)
    ax_e.axvline(D, color=GREY, ls="--", lw=1.0, zorder=0)
    ax_e.text(0.03, 145, r"$z = 0$", fontsize=9, color="k", va="top")
    ax_e.text(D + 0.03, 145, r"$z = d$", fontsize=9, color="k", va="top")

    # --- Horizontal dashed line at E = σ/ε₀ ---
    ax_e.axhline(FACTOR, color=GREY, ls="--", lw=0.8, zorder=0)
    ax_e.text(2 * D - 0.05, FACTOR + 2,
              r"$E = \sigma/\varepsilon_0$",
              fontsize=9, color=GREY, ha="right", va="bottom")

    # --- Grid ---
    ax_e.grid(True, which="both", color="#dddddd", lw=0.6)
    ax_e.tick_params(axis="x", labelsize=8)

    # --- Asymptotes (E = 0 outside) ---
    ax_e.text(-D + 0.05, 3, r"$E = 0$", fontsize=9, color=GREY,
              style="italic", va="bottom")
    ax_e.text(2 * D - 0.05, 3, r"$E = 0$", fontsize=9, color=GREY,
              style="italic", va="bottom", ha="right")

    # --- Marked points ---
    # E at z = 0⁺ and z = d⁻ (inside)
    ax_e.scatter([0.01], [FACTOR], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)
    ax_e.annotate(
        r"$\sigma/\varepsilon_0$" + f" = {FACTOR:.1f}",
        xy=(0.01, FACTOR), xytext=(20, -14),
        textcoords="offset points", fontsize=10, color=BLU,
    )
    ax_e.scatter([D - 0.01], [FACTOR], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)

    # E = 0 outside (marked at z = -0.5d and z = 1.5d)
    ax_e.scatter([-0.5 * D], [0], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)
    ax_e.scatter([1.5 * D], [0], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)

    # V(0) = 0
    ax_v.scatter([0], [0], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)
    ax_v.annotate(r"$V(0) = 0$", xy=(0, 0),
                  xytext=(10, -14), textcoords="offset points",
                  fontsize=10, color=GRN)

    # V(d) = σd/ε₀
    v_d = FACTOR * D
    ax_v.scatter([D], [v_d], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)
    ax_v.annotate(
        r"$V(d) = \dfrac{\sigma d}{\varepsilon_0}$" + f" = {v_d:.1f}",
        xy=(D, v_d), xytext=(-80, -14),
        textcoords="offset points", fontsize=10, color=GRN,
    )

    # ΔV annotation
    ax_v.annotate(
        "", xy=(D + 0.15, v_d), xytext=(D + 0.15, 0),
        arrowprops=dict(arrowstyle="<->", color=GRN, lw=1.2),
    )
    ax_v.text(D + 0.25, v_d / 2,
              r"$\Delta V = \dfrac{\sigma d}{\varepsilon_0}$",
              fontsize=10, color=GRN, va="center")

    # --- Formula boxes ---
    ax_e.text(
        0.97, 0.97,
        r"$\mathbf{E(z):}$" "\n"
        r"$\quad z < 0:\; E = 0$" "\n"
        r"$\quad 0 \leq z \leq d:\; E = \dfrac{\sigma}{\varepsilon_0}$"
        "\n\n"
        r"$\quad z > d:\; E = 0$",
        transform=ax_e.transAxes, ha="right", va="top",
        fontsize=10, color=BLU, fontweight="bold", linespacing=2.0,
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )
    ax_v.text(
        0.03, 0.55,
        r"$\mathbf{V(z):}$" "\n"
        r"$\quad z < 0:\; V = 0$" "\n"
        r"$\quad 0 \leq z \leq d:\; V = \dfrac{\sigma}{\varepsilon_0}z$"
        "\n\n"
        r"$\quad z > d:\; V = \dfrac{\sigma d}{\varepsilon_0}$",
        transform=ax_v.transAxes, ha="left", va="top",
        fontsize=10, color=GRN, fontweight="bold", linespacing=2.0,
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
    path = SPEC.save(fig, OUT_DIR / "parallel_plate_capacitor")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
