"""Electric field and potential of a uniformly charged disk.

Two-panel physics-textbook illustration (serif, line-art style), side by side:
  * Left:  3D view of a charged disk in the xy-plane with axial E arrows
           (monotonically decreasing with |z|) and fringe-field curves.
  * Right: E(z) and V(z) curves vs. axial distance, dual y-axes.
           E(z) has a jump discontinuity at z = 0 (surface charge).

Run with:    uv run python src/electric_field/charged_disk.py
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
EPS0 = 8.854e-12
SIGMA = 1.0e-9         # surface charge density, C/m²
R = 1.0                # disk radius, m

FACTOR = SIGMA / (2 * EPS0)   # σ/(2ε₀) ≈ 56.47

BLU = "#1f4e9b"
RED = "#c0392b"
GRN = "#2e8b57"
GREY = "#888888"

SPEC = Presets.PNG_TEXTBOOK
OUT_DIR = Path(__file__).resolve().parent.parent / "img"


# --------------------------------------------------------------------------- #
# Left panel — 3D model of charged disk with axial E arrows + fringe field
# --------------------------------------------------------------------------- #
def draw_model(ax):
    ax.set_axis_off()
    ax.set_xlim(-3, 3)
    ax.set_ylim(-3, 3)
    ax.set_zlim(-3, 3)
    ax.set_box_aspect((1, 1, 1))
    ax.view_init(elev=20, azim=-55)

    ax.set_title("Model of Uniformly Charged Disk",
                 fontsize=12, pad=8)

    # Disk in xy-plane — pink fill + blue outline (front/back split for 3D).
    theta = np.linspace(0, 2 * np.pi, 200)
    cx = R * np.cos(theta)
    cy = R * np.sin(theta)
    cz = np.zeros_like(theta)
    front = cy > 0
    ax.plot(cx[front], cy[front], cz[front], color=BLU, lw=2.4, zorder=3)
    ax.plot(cx[~front], cy[~front], cz[~front], color=BLU, lw=1.0,
            ls="--", zorder=2)

    # "+" charge symbols scattered on disk surface.
    rng = np.random.default_rng(42)
    pts = []
    while len(pts) < 14:
        x, y = rng.uniform(-R * 0.85, R * 0.85), rng.uniform(-R * 0.85, R * 0.85)
        if x * x + y * y < (R * 0.85) ** 2:
            pts.append((x, y))
    for x, y in pts:
        ax.text(x, y, 0, "+", ha="center", va="center",
                fontsize=10, color=RED, fontweight="bold", zorder=4)

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

    # σ label on disk.
    ax.text(0.35, 0.35, 0.05, r"$\sigma$", fontsize=12, color=RED,
            fontweight="bold")

    # E arrows along z-axis — length ∝ |E(z)|, decreasing with |z|.
    def _e_mag(z):
        az = abs(z)
        return FACTOR * (1 - az / np.sqrt(az ** 2 + R ** 2))

    arrow_scale = 1.2 / FACTOR
    for z in [0.12, 0.4, 0.9, 1.6]:
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

    # Fringe-field curves from disk edge (curving away from z-axis).
    fringe_t = np.linspace(0, 1, 40)
    for phi in [0, np.pi / 2, np.pi, 3 * np.pi / 2]:
        cp, sp = np.cos(phi), np.sin(phi)
        rho_f = R + 0.9 * fringe_t ** 1.5
        z_f = 0.15 + 1.4 * fringe_t
        ax.plot(rho_f * cp, rho_f * sp, z_f,
                color=BLU, lw=1.0, ls=":", alpha=0.6, zorder=2)

    # Legend.
    handles = [
        Line2D([0], [0], color=BLU, lw=2.4,
               label="Charged disk (radius R)"),
        Line2D([0], [0], marker="+", color=RED, markersize=10,
               markeredgewidth=1.5, linestyle="none",
               label=r"Surface charge $\sigma$"),
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
    ax_e.set_title("Field and Potential of Uniformly Charged Disk",
                   fontsize=11, pad=8)

    # E(z) has a jump at z = 0 → plot two separate segments.
    z_pos = np.linspace(0.005, 4 * R, 400)
    z_neg = np.linspace(-4 * R, -0.005, 400)

    E_pos = FACTOR * (1 - z_pos / np.sqrt(z_pos ** 2 + R ** 2))
    E_neg = -FACTOR * (1 + z_neg / np.sqrt(z_neg ** 2 + R ** 2))

    ax_e.plot(z_pos, E_pos, color=BLU, lw=2.8, label=r"$E(z)$")
    ax_e.plot(z_neg, E_neg, color=BLU, lw=2.8)

    # V(z) — continuous, even.
    z_full = np.linspace(-4 * R, 4 * R, 800)
    V = FACTOR * (np.sqrt(z_full ** 2 + R ** 2) - np.abs(z_full))
    ax_v.plot(z_full, V, color=GRN, lw=2.8, label=r"$V(z)$")

    # --- Shared x-axis ---
    ax_e.set_xlim(-4 * R, 4 * R)
    ax_e.set_xlabel("Distance z (m)", fontsize=10)
    ax_e.set_xticks(np.arange(-4 * R, 4 * R + 0.01, 1.0))

    # --- Left y-axis: E ---
    ax_e.set_ylim(-70, 70)
    ax_e.set_ylabel("E (N/C)", fontsize=10, color=BLU)
    ax_e.set_yticks(np.arange(-60, 61, 20))
    ax_e.tick_params(axis="y", labelcolor=BLU, labelsize=8)

    # --- Right y-axis: V ---
    v0 = FACTOR * R
    ax_v.set_ylim(-2, 35)
    ax_v.set_ylabel("V (V)", fontsize=10, color=GRN)
    ax_v.set_yticks(np.arange(0, 36, 5))
    ax_v.tick_params(axis="y", labelcolor=GRN, labelsize=8)
    ax_v.spines["right"].set_color(GRN)
    ax_v.spines["left"].set_color(BLU)

    # --- Vertical dashed line at z = 0 (jump location) ---
    ax_e.axvline(0, color=GREY, ls="--", lw=1.0, zorder=0)
    ax_e.text(0.08, 67, r"$z = 0$", fontsize=9, color="k", va="top")

    # --- Grid ---
    ax_e.grid(True, which="both", color="#dddddd", lw=0.6)
    ax_e.tick_params(axis="x", labelsize=8)

    # --- Horizontal dashed line at E = ±σ/(2ε₀) (infinite-plane limit) ---
    ax_e.axhline(FACTOR, color=GREY, ls="--", lw=0.8, zorder=0)
    ax_e.axhline(-FACTOR, color=GREY, ls="--", lw=0.8, zorder=0)
    ax_e.text(-3.8, FACTOR + 1.5,
              r"$E = \sigma/(2\varepsilon_0)$ (infinite plane)",
              fontsize=8, color=GREY, va="bottom")

    # --- Asymptotes ---
    ax_e.axhline(0, color=GREY, ls="--", lw=0.6)
    ax_e.text(4 * R - 0.1, 1.0, r"$E \rightarrow 0$",
              ha="right", va="bottom", fontsize=9, color=GREY, style="italic")
    ax_v.text(4 * R - 0.1, 0.8, r"$V \rightarrow 0$",
              ha="right", va="bottom", fontsize=9, color=GREY, style="italic")

    # Point-charge asymptote annotation.
    ax_e.text(4 * R - 0.1, -8, r"$E \approx kQ/z^2$ for $z \gg R$",
              ha="right", va="top", fontsize=8, color=GREY, style="italic")

    # --- Marked points ---
    # E(0⁺) = σ/(2ε₀)
    ax_e.scatter([0.02], [FACTOR], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)
    ax_e.annotate(
        r"$\sigma/(2\varepsilon_0)$" + f" = {FACTOR:.1f}",
        xy=(0.02, FACTOR), xytext=(15, -16),
        textcoords="offset points", fontsize=9, color=BLU,
    )

    # E(0⁻) = -σ/(2ε₀)
    ax_e.scatter([-0.02], [-FACTOR], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)
    ax_e.annotate(
        f"{-FACTOR:.1f}",
        xy=(-0.02, -FACTOR), xytext=(-40, 12),
        textcoords="offset points", fontsize=9, color=BLU,
    )

    # V peak at z = 0
    ax_v.scatter([0], [v0], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)
    ax_v.annotate(
        r"$V_0 = \frac{\sigma R}{2\varepsilon_0}$" + f" = {v0:.1f}",
        xy=(0, v0), xytext=(12, -4),
        textcoords="offset points", fontsize=9, color=GRN,
    )

    # --- Formula boxes ---
    ax_e.text(
        0.97, 0.97,
        r"$\mathbf{E(z):}$" "\n"
        r"$\quad z > 0:\; E = \dfrac{\sigma}{2\varepsilon_0}"
        r"\left(1 - \dfrac{z}{\sqrt{z^2 + R^2}}\right)$"
        "\n\n"
        r"$\quad z < 0:\; E = -\dfrac{\sigma}{2\varepsilon_0}"
        r"\left(1 + \dfrac{z}{\sqrt{z^2 + R^2}}\right)$",
        transform=ax_e.transAxes, ha="right", va="top",
        fontsize=10, color=BLU, fontweight="bold", linespacing=2.0,
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )
    ax_v.text(
        0.97, 0.62,
        r"$\mathbf{V(z) = \dfrac{\sigma}{2\varepsilon_0}"
        r"(\sqrt{z^2 + R^2} - |z|)}$",
        transform=ax_v.transAxes, ha="right", va="top",
        fontsize=11, color=GRN, fontweight="bold",
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
    path = SPEC.save(fig, OUT_DIR / "charged_disk")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
