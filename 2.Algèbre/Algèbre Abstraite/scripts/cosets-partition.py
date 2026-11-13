"""Coset partition of a finite group G.

4 x 3 dot array representing 12 group elements, tiled by four cosets
of a subgroup H (each coset = one row = one "tile").

Run with: uv run python src/math_paper/cosets_partition.py
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

SPEC = replace(Presets.SVG_MATH, figsize=(6.5, 5.5), transparent=False)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

LBLU = "#d4e6f1"
LGRY = "#f0f0f0"
AXC = "#333333"

# -- layout -------------------------------------------------------------- #
RX = 1.2          # rectangle left edge
RW = 3.4          # rectangle width
RH = 0.9          # rectangle height
SP = 1.3          # vertical spacing between row centres
DOT_R = 0.1       # dot radius

# row data: (group_label, [element_labels], background_color)
ROWS = [
    ("H",  ["e",  "h\u2081", "h\u2082"], LBLU),
    ("aH", ["a",  "ah\u2081", "ah\u2082"], LGRY),
    ("bH", ["b",  "bh\u2081", "bh\u2082"], LGRY),
    ("cH", ["c",  "ch\u2081", "ch\u2082"], LGRY),
]


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)

    n_rows = len(ROWS)
    y_top = (n_rows - 1) * SP / 2            # 1.95

    for i, (glabel, elabels, bg) in enumerate(ROWS):
        yc = y_top - i * SP

        # -- rounded rectangle ------------------------------------------- #
        ax.add_patch(mpatches.FancyBboxPatch(
            (RX, yc - RH / 2), RW, RH,
            boxstyle="round,pad=0.06",
            facecolor=bg, edgecolor=AXC, lw=1.0, zorder=1))

        # -- group label (left of rectangle) ----------------------------- #
        ax.text(RX - 0.35, yc, glabel, fontsize=14,
                ha="right", va="center", fontweight="bold",
                color=AXC, zorder=3)

        # -- dots and element labels ------------------------------------- #
        for j, elabel in enumerate(elabels):
            xdot = RX + 0.7 + j * 1.15
            circle = plt.Circle((xdot, yc), DOT_R,
                                color="k", zorder=3)
            ax.add_patch(circle)
            ax.text(xdot, yc - 0.28, elabel, fontsize=9,
                    ha="center", va="top", color=AXC, zorder=3)

    # -- bottom count ---------------------------------------------------- #
    ax.text(RX + RW / 2, -y_top - 1.1,
            r"$|G| = 4 \times 3 = 12$",
            fontsize=14, ha="center", va="center",
            fontweight="bold", color=AXC)

    # -- axes ------------------------------------------------------------ #
    ax.set_xlim(-0.5, 5.5)
    ax.set_ylim(-3.5, 3.2)
    ax.set_aspect("equal")
    ax.axis("off")

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "cosets-partition")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
