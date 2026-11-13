"""Electric field and potential of a point charge.

Two-panel physics-textbook illustration (serif, line-art style), side by side:
  * Left:  point charge +q with radial field lines + test points P1, P2.
  * Right: E = kq/r^2 and V = kq/r on a single axis (y: 0-50).

Run with:    uv run python src/point_charge_field.py
"""

from __future__ import annotations

import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.lines import Line2D
from matplotlib.patches import Circle, FancyArrowPatch

sys.path.insert(0, str(Path(__file__).resolve().parent))

from _viz import Presets

# --------------------------------------------------------------------------- #
# Physical constants
# --------------------------------------------------------------------------- #
K = 9.0e9          # Coulomb constant, N·m^2/C^2
Q = 1.0e-9         # charge, C  ->  E(r)=9/r^2 N/C,  V(r)=9/r V

RED = "#c0392b"
BLU = "#1f4e9b"
GRN = "#2e8b57"
GREY = "#888888"

SPEC = Presets.PNG_TEXTBOOK
OUT_DIR = Path(__file__).resolve().parent.parent / "img"


# --------------------------------------------------------------------------- #
# Left panel — point charge and field lines
# --------------------------------------------------------------------------- #
def draw_model(ax):
    ax.set_aspect("equal")
    ax.set_axis_off()
    ax.set_xlim(-1.5, 1.5)
    ax.set_ylim(-1.6, 1.6)

    ax.set_title("Point Charge +q and its Electric Field Lines",
                 fontsize=12, pad=8)

    cx = cy = 0.0
    r_max = 1.25

    # 12 radial field lines, each with a directional arrow at ~60%.
    for i in range(12):
        a = 2 * np.pi * i / 12
        dx, dy = np.cos(a), np.sin(a)
        ax.plot([cx, cx + r_max * dx], [cy, cy + r_max * dy],
                color=RED, lw=1.2, zorder=2)
        t = 0.6
        ax.add_patch(FancyArrowPatch(
            (cx + (t - 0.07) * r_max * dx, cy + (t - 0.07) * r_max * dy),
            (cx + t * r_max * dx, cy + t * r_max * dy),
            arrowstyle="-|>", mutation_scale=9, color=RED, lw=1.2, zorder=3,
        ))

    # The charge.
    ax.add_patch(Circle((cx, cy), 0.07, color=RED, zorder=5))
    ax.text(cx, cy - 0.22, "+q", ha="center", va="top",
            fontsize=13, color=RED, fontweight="bold", zorder=5)

    # Test points P1 (1/3) and P2 (2/3) on +x, each with a blue E arrow.
    for name, frac in (("P1", 1 / 3), ("P2", 2 / 3)):
        px = cx + frac * r_max
        py = cy
        ax.scatter([px], [py], s=22, facecolor="white",
                   edgecolor="k", zorder=6)
        ax.text(px, py - 0.16, name, ha="center", va="top",
                fontsize=9, zorder=6)
        ax.add_patch(FancyArrowPatch(
            (px + 0.04, py), (px + 0.34, py),
            arrowstyle="-|>", mutation_scale=14, color=BLU, lw=2.4, zorder=7,
        ))
        ax.text(px + 0.20, py + 0.10, "E", ha="center", va="bottom",
                fontsize=12, color=BLU, fontweight="bold", zorder=7)

    # "r" distance indicator along the bottom.
    ax.annotate("", xy=(0.95, -1.30), xytext=(0.05, -1.30),
                arrowprops=dict(arrowstyle="-|>", color="k", lw=1.0))
    ax.text(0.5, -1.43, "r", ha="center", va="top",
            fontsize=12, style="italic")

    # Legend (bottom-right).
    legend_handles = [
        Line2D([0], [0], marker="o", color="none", markerfacecolor=RED,
               markersize=9, label="+q (Positive Point Charge)"),
        Line2D([0], [0], color=RED, lw=1.4, label="Electric Field Lines"),
        Line2D([0], [0], color=BLU, lw=2.4, label="Electric Field E"),
    ]
    ax.legend(handles=legend_handles, loc="lower right",
              fontsize=8, frameon=True, edgecolor="#cccccc",
              facecolor="white", framealpha=0.9)


# --------------------------------------------------------------------------- #
# Right panel — E and V vs. r on one axis
# --------------------------------------------------------------------------- #
def draw_curves(ax):
    ax.set_title("Electric Field and Potential vs. Distance",
                 fontsize=12, pad=8)

    r = np.linspace(0.1, 3.0, 400)
    E = K * Q / r ** 2
    V = K * Q / r

    ax.plot(r, E, color=BLU, lw=1.8, label=r"$E = kq\,/\,r^2$")
    ax.plot(r, V, color=GRN, lw=1.8, label=r"$V = kq\,/\,r$")

    ax.set_xlim(0.1, 3.0)
    ax.set_ylim(0, 50)
    ax.set_xlabel("Distance r (m)", fontsize=10)
    ax.set_ylabel("E (N/C)   /   V (V)", fontsize=10)
    ax.set_xticks(np.arange(0.1, 3.01, 0.5))
    ax.set_yticks(np.arange(0, 51, 10))
    ax.grid(True, which="both", color="#dddddd", lw=0.6)
    ax.tick_params(labelsize=8)

    # Marked points on each curve.
    for rr, val, color, lbl in (
        (1.0, 9.0, BLU, "E"), (2.0, 2.25, BLU, "E"),
        (1.0, 9.0, GRN, "V"), (2.0, 4.5, GRN, "V"),
    ):
        y = (K * Q / rr ** 2) if lbl == "E" else (K * Q / rr)
        ax.scatter([rr], [y], s=24, facecolor="white",
                   edgecolor=color, zorder=5)
        ax.annotate(f"{lbl} = {val:g}", xy=(rr, y),
                    xytext=(8, 8), textcoords="offset points",
                    fontsize=9, color=color)

    # Legend (lower-right) — functions only, no k/q values.
    ax.legend(loc="lower right", fontsize=9, frameon=True,
              edgecolor="#cccccc", facecolor="white")


# --------------------------------------------------------------------------- #
# Build the figure
# --------------------------------------------------------------------------- #
def build_figure():
    fig = SPEC.figure()
    ax1, ax2 = fig.subplots(1, 2)
    fig.subplots_adjust(left=0.07, right=0.98, top=0.92, bottom=0.10, wspace=0.18)

    draw_model(ax1)
    draw_curves(ax2)

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "point_charge_field")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
