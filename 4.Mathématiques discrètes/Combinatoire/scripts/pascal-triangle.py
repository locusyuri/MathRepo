"""Pascal's triangle drawn as a honeycomb of hexagonal cells.

Left: rows n = 0, ..., 4 with the values C(n, k).  Right: the same cells labelled
with the binomial coefficients in the notation of the text.  The arrow recalls
that both displays carry the same information.

Output: ../img/pascal-triangle.svg
"""

from __future__ import annotations

import os
import sys
from dataclasses import replace
from math import comb, pi, sqrt
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import FancyArrowPatch, RegularPolygon

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH_PANEL, figsize=(7.4, 3.3))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1f2933"
CELL = "#ffffff"
EDGE = "#1f2933"
ARROW = "#1f2933"

ROWS = 5
S = 0.52                      # circumradius of one hexagon
DX = 2 * S                    # horizontal pitch inside a row
DY = sqrt(3) * S              # vertical pitch between rows
PANEL_OFFSET = 2.95           # horizontal offset of the two panels


def draw_triangle(ax, offset, labels):
    """Draw the hexagonal cells of Pascal's triangle centred at `offset`."""
    for n in range(ROWS):
        y = -n * DY
        for k in range(n + 1):
            cx = offset + (k - n / 2) * DX
            ax.add_patch(RegularPolygon(
                (cx, y), numVertices=6, radius=S, orientation=pi / 6,
                facecolor=CELL, edgecolor=EDGE, lw=0.8, zorder=3))
            ax.text(cx, y, labels(n, k), ha="center", va="center",
                    fontsize=12 if labels is values else 9.5, color=INK,
                    zorder=4)


def values(n, k):
    return str(comb(n, k))


def symbols(n, k):
    return rf"${{}}^{{{n}}}C_{{{k}}}$"


def main():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)
    ax.set_aspect("equal")
    ax.axis("off")

    draw_triangle(ax, -PANEL_OFFSET, values)
    draw_triangle(ax, +PANEL_OFFSET, symbols)

    ax.add_patch(FancyArrowPatch((-0.95, -1.55), (0.95, -1.55),
                                 arrowstyle="-|>,head_length=8,head_width=4",
                                 mutation_scale=1.0, color=ARROW, lw=2.2,
                                 shrinkA=0, shrinkB=0, zorder=5))

    half_width = PANEL_OFFSET + 2 * S * ROWS / 2 + 0.15
    ax.set_xlim(-half_width, half_width)
    ax.set_ylim(-(ROWS - 1) * DY - 1.05, 0.62)

    path = SPEC.save(fig, OUT_DIR / "pascal-triangle")
    print(f"Saved: {path}")

    if os.environ.get("PREVIEW"):
        preview = OUT_DIR / "pascal-triangle-preview.png"
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.05)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
