"""Euclid: the 24 x 9 rectangle tiled by successively removed largest squares.

Single-panel, transparent-background vector illustration, landscape 8:3.
A grey-framed 24 x 9 rectangle is fully tiled by five squares obtained by
repeatedly cutting off the largest square (the Euclidean algorithm for
gcd(24, 9) = 3):

    block 1  9x9  x in [0, 9]        y in [0, 9]   light blue
    block 2  9x9  x in [9, 18]       y in [0, 9]   light cyan
    block 3  6x6  x in [18, 24]      y in [0, 6]   light green
    block 4  3x3  x in [18, 21]      y in [6, 9]   light orange
    block 5  3x3  x in [21, 24]      y in [6, 9]   light purple

A white numbered disc in the middle of each square marks the cutting order;
the remaining uncovered strip 6 x 3 becomes the two 3x3 squares.

Run with: uv run python src/math_paper/euclid_rectangle.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(10.0, 3.9))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

FRAME = "#1a1a1a"
INK = "#1a1a1a"
DARK = "#333333"
MID = "#555555"

# square fills, light pastels (order = cutting order)
FILLS = ["#AED3F0", "#A6DFE2", "#BFE2A5", "#F7C98F", "#CDB5E9"]

# (x0, y0, side) of the five squares
SQUARES = [(0.0, 0.0, 9.0), (9.0, 0.0, 9.0), (18.0, 0.0, 6.0),
           (18.0, 6.0, 3.0), (21.0, 6.0, 3.0)]

# (cx, cy, radius, digit font size) of the white order discs
BADGES = [(4.5, 4.5, 1.30, 15), (13.5, 4.5, 1.30, 15), (21.0, 3.0, 0.95, 13),
          (19.5, 7.5, 0.62, 11), (22.5, 7.5, 0.62, 11)]


def panel(ax):
    # coloured squares
    for (x0, y0, s), fill in zip(SQUARES, FILLS):
        ax.add_patch(Rectangle((x0, y0), s, s, facecolor=fill,
                               edgecolor="none", zorder=1))

    # hairline white seams along the inner cut lines
    seams = [(9, 0, 9, 9), (18, 0, 18, 9), (18, 6, 24, 6), (21, 6, 21, 9)]
    for x1, y1, x2, y2 in seams:
        ax.plot([x1, x2], [y1, y2], color="white", lw=1.3, zorder=2,
                solid_capstyle="butt")

    # outer rectangle frame
    ax.add_patch(Rectangle((0, 0), 24, 9, facecolor="none",
                           edgecolor=FRAME, lw=1.6, zorder=3))

    # order discs + digit
    for i, (cx, cy, r, fs) in enumerate(BADGES, start=1):
        ax.add_patch(plt.Circle((cx, cy), r, facecolor="white",
                                edgecolor="none", zorder=4))
        ax.text(cx, cy, str(i), ha="center", va="center", fontsize=fs,
                fontweight="bold", color=INK, zorder=5)

    # inner size labels of the 9x9 and 6x6 squares
    for cx in (4.5, 13.5):
        ax.text(cx, 2.55, "9\u00d79", ha="center", va="center",
                fontsize=12, color=DARK, zorder=5)
    ax.text(21.0, 1.35, "6\u00d76", ha="center", va="center",
            fontsize=12, color=DARK, zorder=5)

    # 3x3 label of the top-right strip, with an arrow
    ax.annotate("3\u00d73", xy=(24.32, 7.5), xytext=(25.9, 7.5),
                ha="center", va="center", fontsize=12, color=DARK,
                arrowprops=dict(arrowstyle="-|>", color=DARK, lw=1.0,
                                shrinkA=0, shrinkB=0, mutation_scale=10),
                zorder=5)

    # overall size labels
    ax.text(12.0, -0.60, "24", ha="center", va="center",
            fontsize=12, color=DARK, zorder=5)
    ax.text(-0.55, 4.5, "9", ha="center", va="center",
            fontsize=12, color=DARK, zorder=5)

    # leader to gcd(24, 9) = 3
    ax.plot([24, 24.68], [6, 4.6], color=INK, lw=1.0, zorder=4)
    ax.text(24.78, 4.6, "gcd(24, 9) = 3", ha="left", va="center",
            fontsize=12, color=INK, zorder=5)

    # caption under the figure
    ax.text(12.0, -1.85,
            "Side lengths of the removed largest squares: "
            "9 \u2192 9 \u2192 6 \u2192 3 \u2192 3",
            ha="center", va="center", fontsize=10.5, color=MID, zorder=5)

    ax.set_xlim(-1.9, 29.3)
    ax.set_ylim(-2.4, 9.4)
    ax.set_aspect("equal")
    ax.axis("off")


def build_figure():
    fig = SPEC.figure()
    panel(fig.add_subplot(111))
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "euclid-rectangle")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
