"""Heat engine and refrigerator schematics.

Two-panel block diagram:
  Left  — Heat engine:     Q_h from hot, Q_c to cold, W = Q_h - Q_c out
  Right — Refrigerator:    Q_c from cold, Q_h to hot, W input

Run with: uv run python src/math_paper/reservoir_schematic.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(
    Presets.SVG_MATH_PANEL,
    figsize=(12.0, 5.5),
    transparent=False,
)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

RED = "#E53935"
BLU = "#2196F3"
GRY_BOX = "#bdc3c7"
AXC = "#333333"


def _box(ax, xc, yc, w, h, label, color, fontsize=11):
    """Draw a rounded rectangle with centred label."""
    ax.add_patch(mpatches.FancyBboxPatch(
        (xc - w / 2, yc - h / 2), w, h,
        boxstyle="round,pad=0.08",
        facecolor=color, edgecolor=AXC, lw=1.2, alpha=0.85, zorder=2))
    ax.text(xc, yc, label, fontsize=fontsize, ha="center",
            va="center", color=AXC, fontweight="bold", zorder=3)


def _arrow(ax, x1, y1, x2, y2, color, lw=2.5):
    """Thick arrow between two points."""
    ax.annotate("", xy=(x2, y2), xytext=(x1, y1),
                arrowprops=dict(
                    arrowstyle="-|>", color=color, lw=lw,
                    mutation_scale=22, shrinkA=2, shrinkB=2),
                zorder=4)


# ========================================================================= #
#  Left panel  —  Heat engine                                               #
# ========================================================================= #
def panel_engine(ax):
    # boxes
    _box(ax, 1.5, 3.2, 2.4, 0.55, "Hot reservoir  $T_h$",
         "#e74c3c", fontsize=10)
    _box(ax, 1.5, 0.4, 2.4, 0.55, "Cold reservoir  $T_c$",
         "#3498db", fontsize=10)
    _box(ax, 1.5, 1.8, 1.3, 0.65, "Engine", "#2980b9", fontsize=10)

    # small cycle symbol inside engine
    ax.add_patch(mpatches.Circle((1.5, 1.8), 0.12,
                                 facecolor="none", edgecolor="white",
                                 lw=1.5, zorder=3))

    # Q_h  (hot -> engine)
    _arrow(ax, 1.5, 2.9, 1.5, 2.15, RED)
    ax.text(1.72, 2.52, r"$Q_h$", fontsize=12, color=RED,
            fontweight="bold")

    # Q_c  (engine -> cold)
    _arrow(ax, 1.5, 1.45, 1.5, 0.7, BLU)
    ax.text(1.72, 1.08, r"$Q_c$", fontsize=12, color=BLU,
            fontweight="bold")

    # W  (engine -> useful work)
    _arrow(ax, 2.15, 1.8, 3.05, 1.8, AXC)
    _box(ax, 3.55, 1.8, 0.85, 0.45, "useful\nwork", "#ecf0f1",
         fontsize=7)
    ax.text(2.6, 1.95, r"$W$", fontsize=12, color=AXC,
            fontweight="bold")

    # title
    ax.text(1.5, -0.25, "Heat engine", fontsize=13,
            fontweight="bold", color=AXC, ha="center")

    ax.set_xlim(-0.2, 4.3)
    ax.set_ylim(-0.6, 3.8)
    ax.set_aspect("equal")
    ax.axis("off")


# ========================================================================= #
#  Right panel  —  Refrigerator                                             #
# ========================================================================= #
def panel_fridge(ax):
    cx = 1.5  # centre x of the schematic

    # boxes
    _box(ax, cx, 3.2, 2.4, 0.55, "Hot reservoir  $T_h$",
         "#e74c3c", fontsize=10)
    _box(ax, cx, 0.4, 2.4, 0.55, "Cold reservoir  $T_c$",
         "#3498db", fontsize=10)
    _box(ax, cx, 1.8, 1.5, 0.65, "Refrigerator", "#e67e22",
         fontsize=10)

    # Q_c  (cold -> fridge, upward)
    _arrow(ax, cx - 0.3, 0.7, cx - 0.3, 1.45, BLU)
    ax.text(cx - 0.65, 1.08, r"$Q_c$", fontsize=12, color=BLU,
            fontweight="bold")

    # Q_h  (fridge -> hot, upward)
    _arrow(ax, cx + 0.3, 2.15, cx + 0.3, 2.9, RED)
    ax.text(cx + 0.52, 2.52, r"$Q_h = Q_c + W$", fontsize=10,
            color=RED, fontweight="bold")

    # W  (work input -> fridge, from right)
    _arrow(ax, 3.15, 1.8, 2.25, 1.8, AXC)
    _box(ax, 3.55, 1.8, 0.85, 0.45, "work\ninput", "#ecf0f1",
         fontsize=7)
    ax.text(2.7, 1.95, r"$W$", fontsize=12, color=AXC,
            fontweight="bold")

    # title
    ax.text(cx, -0.25, "Refrigerator", fontsize=13,
            fontweight="bold", color=AXC, ha="center")

    ax.set_xlim(-0.2, 4.3)
    ax.set_ylim(-0.6, 3.8)
    ax.set_aspect("equal")
    ax.axis("off")


# ========================================================================= #
#  Assemble & save                                                          #
# ========================================================================= #
def build_figure():
    fig = SPEC.figure()
    panel_engine(fig.add_subplot(1, 2, 1))
    panel_fridge(fig.add_subplot(1, 2, 2))
    fig.subplots_adjust(wspace=0.05, left=0.02, right=0.98,
                        bottom=0.05, top=0.97)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "reservoir-schematic")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
