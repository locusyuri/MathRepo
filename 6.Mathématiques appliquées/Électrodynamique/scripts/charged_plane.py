"""Electric field and potential of an infinite uniformly charged plane.

Two-panel physics-textbook illustration (serif, line-art style), side by side:
  * Left:  3D view of an infinite charged plane with uniform-length E arrows
           pointing away from the surface on both sides.
  * Right: E(z) (constant with jump at z=0) and V(z) (V-shaped, linear
           decrease) curves vs. distance, dual y-axes.

Run with:    uv run python src/electric_field/charged_plane.py
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

FACTOR = SIGMA / (2 * EPS0)   # σ/(2ε₀) ≈ 56.47

BLU = "#1f4e9b"
RED = "#c0392b"
GRN = "#2e8b57"
GREY = "#888888"

SPEC = Presets.PNG_TEXTBOOK
OUT_DIR = Path(__file__).resolve().parent.parent / "img"


# --------------------------------------------------------------------------- #
# Left panel — 3D model of infinite charged plane with uniform E arrows
# --------------------------------------------------------------------------- #
def draw_model(ax):
    ax.set_axis_off()
    ax.set_xlim(-3, 3)
    ax.set_ylim(-3, 3)
    ax.set_zlim(-3, 3)
    ax.set_box_aspect((1, 1, 1))
    ax.view_init(elev=22, azim=-55)

    ax.set_title("Model of Infinite Charged Plane",
                 fontsize=12, pad=8)

    # Charged plane in xy-plane — pink-filled parallelogram (3D perspective).
    corners = np.array([
        [-2.8, -0.6, 0], [2.8, -0.6, 0],
        [2.8, 0.6, 0], [-2.8, 0.6, 0],
    ])
    ax.add_collection3d(
        Poly3DCollection(
            [corners], facecolors="#fadbd8", edgecolors=RED,
            linewidths=1.6, alpha=0.85,
        )
    )

    # Grid lines on plane to suggest infinite extent.
    for x in np.linspace(-2.4, 2.4, 7):
        ax.plot([x, x], [-0.6, 0.6], [0, 0],
                color=RED, lw=0.4, alpha=0.35, zorder=1)
    for y in np.linspace(-0.5, 0.5, 3):
        ax.plot([-2.8, 2.8], [y, y], [0, 0],
                color=RED, lw=0.4, alpha=0.35, zorder=1)

    # "..." at edges to indicate the plane extends infinitely.
    for x_ext, dx in [(-2.6, -0.15), (2.6, 0.15)]:
        for dy in [-0.15, 0, 0.15]:
            ax.scatter([x_ext + dx], [dy], [0], s=8, color=RED, zorder=3)

    # σ label.
    ax.text(1.2, 0, 0.12, r"$\sigma$", fontsize=14, color=RED,
            fontweight="bold")

    # z-axis line.
    ax.plot([0, 0], [0, 0], [-2.8, 2.8], color="k", lw=0.8, ls="-")
    ax.text(0.1, 0.1, 2.9, r"$z$", fontsize=13, color="k")

    # Normal vector n̂ arrow (distinct from E arrows — thicker, labelled).
    ax.add_artist(Arrow3D(
        (0, 0, 0.05), (0, 0, 1.0),
        arrowstyle="-|>", mutation_scale=14,
        color="k", lw=2.0,
    ))
    ax.text(0.18, 0.05, 0.9, r"$\hat{n}$", fontsize=12, color="k")

    # Uniform-length E arrows above the plane (all pointing +z).
    arrow_len = 0.9
    z_pos = [0.3, 0.8, 1.3, 1.8]
    for x_off in [-1.2, 0.7]:
        for z in z_pos:
            ax.add_artist(Arrow3D(
                (x_off, 0, z), (0, 0, arrow_len),
                arrowstyle="-|>", mutation_scale=10,
                color=BLU, lw=1.6,
            ))

    # Uniform-length E arrows below the plane (all pointing -z).
    for x_off in [-1.2, 0.7]:
        for z in [-z for z in z_pos]:
            ax.add_artist(Arrow3D(
                (x_off, 0, z), (0, 0, -arrow_len),
                arrowstyle="-|>", mutation_scale=10,
                color=BLU, lw=1.6,
            ))

    # Legend.
    handles = [
        Line2D([0], [0], color=RED, lw=2.4,
               label="Infinite charged plane"),
        Line2D([0], [0], color=BLU, lw=2.0, marker=">",
               markersize=7, label="E (uniform)"),
    ]
    ax.legend(handles=handles, loc="lower right", fontsize=8,
              frameon=True, edgecolor="#cccccc", facecolor="white",
              framealpha=0.9)


# --------------------------------------------------------------------------- #
# Right panel — E(z) and V(z) with dual y-axes
# --------------------------------------------------------------------------- #
def draw_curves(ax_e, ax_v):
    ax_e.set_title("Field and Potential of Infinite Charged Plane",
                   fontsize=11, pad=8)

    # E(z): constant on each side, jump at z = 0.
    z_pos = np.array([0.001, 4.0])
    z_neg = np.array([-4.0, -0.001])
    E_pos = np.full_like(z_pos, FACTOR)
    E_neg = np.full_like(z_neg, -FACTOR)

    ax_e.plot(z_pos, E_pos, color=BLU, lw=2.8, label=r"$E(z)$")
    ax_e.plot(z_neg, E_neg, color=BLU, lw=2.8)

    # V(z) = -(σ/(2ε₀))|z|  — V-shaped, linear decrease.
    z_full = np.linspace(-4, 4, 800)
    V = -FACTOR * np.abs(z_full)
    ax_v.plot(z_full, V, color=GRN, lw=2.8, label=r"$V(z)$")

    # --- Shared x-axis ---
    ax_e.set_xlim(-4, 4)
    ax_e.set_xlabel("Distance z (m)", fontsize=10)
    ax_e.set_xticks(np.arange(-4, 5, 1))

    # --- Left y-axis: E ---
    ax_e.set_ylim(-75, 75)
    ax_e.set_ylabel("E (N/C)", fontsize=10, color=BLU)
    ax_e.set_yticks(np.arange(-60, 61, 30))
    ax_e.tick_params(axis="y", labelcolor=BLU, labelsize=8)

    # --- Right y-axis: V ---
    ax_v.set_ylim(-250, 30)
    ax_v.set_ylabel("V (V)", fontsize=10, color=GRN)
    ax_v.set_yticks(np.arange(-250, 31, 50))
    ax_v.tick_params(axis="y", labelcolor=GRN, labelsize=8)
    ax_v.spines["right"].set_color(GRN)
    ax_v.spines["left"].set_color(BLU)

    # --- Vertical dashed line at z = 0 ---
    ax_e.axvline(0, color=GREY, ls="--", lw=1.0, zorder=0)
    ax_e.text(0.08, 72, r"$z = 0$", fontsize=9, color="k", va="top")

    # --- Horizontal dashed lines at E = ±σ/(2ε₀) ---
    ax_e.axhline(FACTOR, color=GREY, ls="--", lw=0.8, zorder=0)
    ax_e.axhline(-FACTOR, color=GREY, ls="--", lw=0.8, zorder=0)

    # --- Grid ---
    ax_e.grid(True, which="both", color="#dddddd", lw=0.6)
    ax_e.tick_params(axis="x", labelsize=8)

    # --- Marked points ---
    # E(0⁺) = σ/(2ε₀)
    ax_e.scatter([0.02], [FACTOR], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)
    ax_e.annotate(
        r"$E = \dfrac{\sigma}{2\varepsilon_0}$" + f" = {FACTOR:.1f}",
        xy=(0.02, FACTOR), xytext=(30, -10),
        textcoords="offset points", fontsize=10, color=BLU,
    )

    # E(0⁻) = -σ/(2ε₀)
    ax_e.scatter([-0.02], [-FACTOR], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)
    ax_e.annotate(
        f"{-FACTOR:.1f}",
        xy=(-0.02, -FACTOR), xytext=(-35, 12),
        textcoords="offset points", fontsize=9, color=BLU,
    )

    # E at z = ±1 (constant value check)
    ax_e.scatter([1], [FACTOR], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)
    ax_e.annotate(f"E = {FACTOR:.1f}", xy=(1, FACTOR),
                  xytext=(8, 8), textcoords="offset points",
                  fontsize=9, color=BLU)
    ax_e.scatter([-1], [-FACTOR], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)

    # V(0) = 0
    ax_v.scatter([0], [0], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)
    ax_v.annotate(r"$V(0) = 0$", xy=(0, 0),
                  xytext=(10, 8), textcoords="offset points",
                  fontsize=10, color=GRN)

    # V at z = ±2
    v_at_2 = -FACTOR * 2
    ax_v.scatter([2], [v_at_2], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)
    ax_v.annotate(f"V = {v_at_2:.1f}", xy=(2, v_at_2),
                  xytext=(8, -14), textcoords="offset points",
                  fontsize=9, color=GRN)
    ax_v.scatter([-2], [v_at_2], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)

    # --- Formula boxes ---
    ax_e.text(
        0.97, 0.97,
        r"$\mathbf{E(z):}$" "\n"
        r"$\quad z > 0:\; E = +\dfrac{\sigma}{2\varepsilon_0}$"
        "\n\n"
        r"$\quad z < 0:\; E = -\dfrac{\sigma}{2\varepsilon_0}$",
        transform=ax_e.transAxes, ha="right", va="top",
        fontsize=10, color=BLU, fontweight="bold", linespacing=2.0,
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )
    ax_v.text(
        0.97, 0.58,
        r"$\mathbf{V(z) = -\dfrac{\sigma}{2\varepsilon_0}|z|}$",
        transform=ax_v.transAxes, ha="right", va="top",
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
    path = SPEC.save(fig, OUT_DIR / "charged_plane")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
