"""Ferrers diagram of a partition and its conjugate.

Left panel: partition 6+4+4+2+1 as left-aligned rows of rounded squares.
Right panel: conjugate partition 5+4+3+3+1+1 (the transpose, columns -> rows).
A double-headed arrow between the panels is labelled "conjugation".

Run with: uv run python src/math_paper/ferrers_diagram.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(13.0, 6.0), transparent=False)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#1f4e9b"
LBLU = "#cfe3f7"
DARK = "#222222"

LEFT = [6, 4, 4, 2, 1]
RIGHT = [5, 4, 3, 3, 1, 1]

PITCH = 1.0          # cell spacing
SIZE = 0.84          # square side length (< PITCH leaves a gap)
BOX = 6.0            # common data window (units of PITCH)


def draw_partition(ax, parts):
    w = max(parts)
    h = len(parts)
    x0 = (BOX - w) * PITCH / 2
    y0 = (BOX - h) * PITCH / 2
    for ri, k in enumerate(parts):
        y = y0 + (h - 1 - ri) * PITCH
        for ci in range(k):
            x = x0 + ci * PITCH
            ax.add_patch(mpatches.FancyBboxPatch(
                (x + (PITCH - SIZE) / 2, y + (PITCH - SIZE) / 2),
                SIZE, SIZE,
                boxstyle="round,pad=0.03,rounding_size=0.12",
                facecolor=LBLU, edgecolor=BLU, linewidth=1.4, zorder=2))


def style_axis(ax):
    ax.set_xlim(-0.6, BOX + 0.6)
    ax.set_ylim(-0.6, BOX + 0.6)
    ax.set_aspect("equal")
    ax.set_xticks([])
    ax.set_yticks([])
    for s in ax.spines.values():
        s.set_visible(False)


def build_figure():
    fig = SPEC.figure()

    # Two equal-size axes so the squares render at identical physical scale.
    axL = fig.add_axes([0.055, 0.10, 0.369, 0.80])
    axR = fig.add_axes([0.576, 0.10, 0.369, 0.80])

    draw_partition(axL, LEFT)
    draw_partition(axR, RIGHT)
    style_axis(axL)
    style_axis(axR)

    # Partition labels under each panel.
    fig.text(0.055 + 0.369 / 2, 0.055, "$6+4+4+2+1$",
             fontsize=14, color=DARK, ha="center")
    fig.text(0.576 + 0.369 / 2, 0.055, "$5+4+3+3+1+1$",
             fontsize=14, color=DARK, ha="center")

    # Full-figure overlay for the conjugation arrow.
    axm = fig.add_axes([0, 0, 1, 1])
    axm.set_axis_off()
    axm.annotate("", xy=(0.556, 0.50), xytext=(0.444, 0.50),
                 xycoords="figure fraction", textcoords="figure fraction",
                 arrowprops=dict(arrowstyle="<|-|>", color=DARK, lw=1.8,
                                 mutation_scale=16, shrinkA=0, shrinkB=0,
                                 clip_on=False))
    fig.text(0.500, 0.565, "conjugation", fontsize=13, color=DARK,
             ha="center", fontweight="bold")

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "ferrers-diagram")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
