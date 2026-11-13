"""Electric field and potential of an infinite line charge.

Two-panel physics-textbook illustration (serif, line-art style), side by side:
  * Left:  vertical line charge with radial E arrows (length ∝ 1/ρ).
  * Right: E(ρ) and V(ρ) curves vs. radial distance, with dual y-axes.

Run with:    uv run python src/infinite_line_charge.py
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.lines import Line2D
from matplotlib.patches import FancyArrowPatch
from mpl_toolkits.mplot3d.art3d import Line3DCollection
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
EPS0 = 8.854e-12       # vacuum permittivity, F/m
LAMBDA = 1.0e-9        # linear charge density, C/m
RHO0 = 1.0             # reference distance, m

FACTOR = LAMBDA / (2 * np.pi * EPS0)   # ≈ 17.98

BLU = "#1f4e9b"
RED = "#c0392b"
GRN = "#2e8b57"
GREY = "#888888"

SPEC = Presets.PNG_TEXTBOOK
OUT_DIR = Path(__file__).resolve().parent.parent / "img"


# --------------------------------------------------------------------------- #
# Left panel — infinite line charge model
# --------------------------------------------------------------------------- #
def draw_model(ax):
    ax.set_axis_off()
    ax.set_xlim(-2.5, 2.5)
    ax.set_ylim(-2.5, 2.5)
    ax.set_zlim(-3.5, 3.5)
    ax.set_box_aspect((1, 1, 1.4))
    ax.view_init(elev=18, azim=-60)

    ax.set_title("Model of Infinite Line Charge",
                 fontsize=12, pad=8)

    # Vertical line charge along z-axis.
    ax.plot([0, 0], [0, 0], [-3.3, 3.3], color=BLU, lw=2.4, zorder=2)
    ax.text(0.05, 0.05, 3.4, r"$z$-axis", fontsize=10, color=BLU)

    # "+" symbols along the line.
    for z in np.linspace(-2.8, 2.8, 12):
        ax.text(0.12, 0, z, "+", ha="center", va="center",
                fontsize=11, color=RED, fontweight="bold", zorder=3)

    # λ label.
    ax.text(0.25, 0.12, 0, r"$\lambda$", fontsize=13, color=RED,
            fontweight="bold", zorder=4)

    # Dashed reference circle at z = 0, ρ = 1.5 (perpendicular to line).
    rho_vis = 1.5
    theta = np.linspace(0, 2 * np.pi, 200)
    cx = rho_vis * np.cos(theta)
    cy = rho_vis * np.sin(theta)
    cz = np.zeros_like(theta)
    # Front/back split for dashed/solid.
    front = cy > -0.05
    segs_front, segs_back = [], []
    for i in range(len(theta) - 1):
        seg = [(cx[i], cy[i], cz[i]), (cx[i + 1], cy[i + 1], cz[i + 1])]
        (segs_back if not front[i] else segs_front).append(seg)
    if segs_front:
        ax.add_collection3d(Line3DCollection(
            segs_front, colors=BLU, linewidths=1.2, alpha=0.85))
    if segs_back:
        ax.add_collection3d(Line3DCollection(
            segs_back, colors=BLU, linewidths=1.0, linestyles="--", alpha=0.5))

    # ρ label on the circle.
    ax.text(rho_vis + 0.08, 0.05, 0.1, r"$\rho$", fontsize=12,
            color=BLU, style="italic")

    # Radial E arrows in the z = 0 plane (horizontal, ⊥ to z-axis).
    # Lengths decrease to show E ∝ 1/ρ.
    arrow_layer = 0.0    # z-height for the arrow ring
    rho_starts = [0.3, 0.6, 0.9]
    for rho_s in rho_starts:
        n_arrows = 10
        arrow_len = 0.22 / rho_s   # ∝ 1/ρ
        for i in range(n_arrows):
            a = 2 * np.pi * i / n_arrows
            dx, dy = np.cos(a), np.sin(a)
            ax.add_artist(Arrow3D(
                (rho_s * dx, rho_s * dy, arrow_layer),
                (arrow_len * dx, arrow_len * dy, 0),
                arrowstyle="-|>", mutation_scale=10,
                color=BLU, lw=1.6,
            ))

    # Legend (projected into 3D via ax.legend with 2D handles).
    handles = [
        Line2D([0], [0], color=BLU, lw=2.4,
               label="Line charge ($z$-axis)"),
        Line2D([0], [0], marker="+", color=RED, markersize=10,
               markeredgewidth=1.5, linestyle="none",
               label="Positive charge (+)"),
        Line2D([0], [0], color=BLU, lw=2.0, marker=">",
               markersize=7, label="E (Field Vector)"),
    ]
    ax.legend(handles=handles, loc="lower right", fontsize=8,
              frameon=True, edgecolor="#cccccc", facecolor="white",
              framealpha=0.9)


# --------------------------------------------------------------------------- #
# Right panel — E(ρ) and V(ρ) with dual y-axes
# --------------------------------------------------------------------------- #
def draw_curves(ax_e, ax_v):
    ax_e.set_title("Field and Potential of Infinite Line Charge",
                   fontsize=11, pad=8)

    rho = np.linspace(0.1, 4.0, 500)
    E = FACTOR / rho
    V = FACTOR * np.log(RHO0 / rho)     # V=0 at ρ=ρ₀, negative for ρ>ρ₀

    ax_e.plot(rho, E, color=BLU, lw=2.8, label=r"$E(\rho)$")
    ax_v.plot(rho, V, color=GRN, lw=2.8, label=r"$V(\rho)$")

    # --- Shared x-axis ---
    ax_e.set_xlim(0.1, 4.0)
    ax_e.set_xlabel(r"Distance $\rho$ (m)", fontsize=10)
    ax_e.set_xticks(np.arange(0.5, 4.01, 0.5))

    # --- Left y-axis: E ---
    ax_e.set_ylim(0, 40)
    ax_e.set_ylabel("E (N/C)", fontsize=10, color=BLU)
    ax_e.set_yticks(np.arange(0, 41, 5))
    ax_e.tick_params(axis="y", labelcolor=BLU, labelsize=8)

    # --- Right y-axis: V (includes negative range) ---
    ax_v.set_ylim(-30, 20)
    ax_v.set_ylabel("V (V)", fontsize=10, color=GRN)
    ax_v.set_yticks(np.arange(-30, 21, 10))
    ax_v.tick_params(axis="y", labelcolor=GRN, labelsize=8)
    ax_v.spines["right"].set_color(GRN)
    ax_v.spines["left"].set_color(BLU)

    # --- Zero line on V axis ---
    ax_v.axhline(0, color=GREY, ls="-", lw=0.5, zorder=0)

    # --- Vertical dashed line at ρ = ρ₀ ---
    ax_e.axvline(RHO0, color=GREY, ls="--", lw=1.0, zorder=0)
    ax_e.text(RHO0 + 0.05, 37, r"$\rho = \rho_0$", fontsize=9, color="k")

    # --- Light grey grid ---
    ax_e.grid(True, which="both", color="#dddddd", lw=0.6)
    ax_e.tick_params(axis="x", labelsize=8)

    # --- Asymptotes ---
    ax_e.text(3.9, 0.8, r"$E \rightarrow 0$", ha="right", va="bottom",
              fontsize=9, color=GREY, style="italic")
    ax_v.text(3.9, -28, r"$V \rightarrow -\infty$", ha="right", va="bottom",
              fontsize=9, color=GREY, style="italic")

    # --- Marked points ---
    # E at ρ₀
    e0 = FACTOR / RHO0
    ax_e.scatter([RHO0], [e0], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)
    ax_e.annotate(f"E = {e0:.1f}", xy=(RHO0, e0),
                  xytext=(10, 6), textcoords="offset points",
                  fontsize=9, color=BLU)

    # E at ρ = 2ρ₀
    rho2 = 2.0
    e2 = FACTOR / rho2
    ax_e.scatter([rho2], [e2], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)
    ax_e.annotate(f"E = {e2:.1f}", xy=(rho2, e2),
                  xytext=(10, 6), textcoords="offset points",
                  fontsize=9, color=BLU)

    # V = 0 at ρ₀
    ax_v.scatter([RHO0], [0], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)
    ax_v.annotate("V = 0", xy=(RHO0, 0),
                  xytext=(10, 8), textcoords="offset points",
                  fontsize=9, color=GRN)

    # V at ρ = 2ρ₀
    v2 = FACTOR * np.log(RHO0 / rho2)
    ax_v.scatter([rho2], [v2], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)
    ax_v.annotate(f"V = {v2:.1f}", xy=(rho2, v2),
                  xytext=(10, -10), textcoords="offset points",
                  fontsize=9, color=GRN)

    # --- Formula boxes ---
    ax_e.text(
        0.97, 0.72,
        r"$\mathbf{E(\rho) = "
        r"\dfrac{\lambda}{2\pi\varepsilon_0\,\rho}}$",
        transform=ax_e.transAxes, ha="right", va="top",
        fontsize=13, color=BLU, fontweight="bold",
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )
    ax_v.text(
        0.97, 0.97,
        r"$\mathbf{V(\rho) = "
        r"\dfrac{\lambda}{2\pi\varepsilon_0}"
        r"\ln\dfrac{\rho_0}{\rho}}$",
        transform=ax_v.transAxes, ha="right", va="top",
        fontsize=13, color=GRN, fontweight="bold",
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )

    # --- Legend ---
    handles = [
        Line2D([0], [0], color=BLU, lw=2.8, label=r"$E(\rho)$"),
        Line2D([0], [0], color=GRN, lw=2.8, label=r"$V(\rho)$"),
    ]
    ax_e.legend(handles=handles, loc="center right", fontsize=9,
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
    path = SPEC.save(fig, OUT_DIR / "infinite_line_charge")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
