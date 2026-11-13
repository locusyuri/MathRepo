"""Factor correspondence grid: invariant factors vs elementary divisors.

Single-panel diagram showing how invariant factors d_i decompose into
prime-power elementary divisors, arranged in a 3x2 grid (rows = d_i,
columns = primes p = 2, 3).

Run with: uv run python src/math_paper/factor_correspondence.py
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

SERIF_RC = {
    "font.family": "serif",
    "font.serif": ["DejaVu Serif", "STIX Two Math", "Times New Roman", "serif"],
    "mathtext.fontset": "dejavuserif",
}
SPEC = replace(Presets.SVG_MATH, figsize=(8.0, 5.5),
               transparent=False, rc_overrides=SERIF_RC)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU2 = "#1f4e79"   # prime 2
RED3 = "#b03021"   # prime 3
INK  = "#1a1a1a"   # invariant factors
GRY  = "#6b6b6b"   # arrows, auxiliary
LGRY = "#888888"   # filler "=1"

# -- grid geometry --------------------------------------------------------- #
CELL_W, CELL_H = 1.4, 0.75
COL_X = [2.5, 4.1]       # centre x of each column
ROW_Y = [3.6, 2.7, 1.8]  # centre y of each row (top to bottom)


def _cell_box(ax, cx, cy, color, alpha=0.10):
    """Draw a rounded-rectangle cell with light fill."""
    ax.add_patch(mpatches.FancyBboxPatch(
        (cx - CELL_W / 2, cy - CELL_H / 2), CELL_W, CELL_H,
        boxstyle="round,pad=0.05",
        facecolor=color, edgecolor=GRY, lw=0.8,
        alpha=alpha, zorder=1))


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)

    # ================================================================ #
    # Column headers                                                   #
    # ================================================================ #
    ax.text(COL_X[0], 4.35, r"$p = 2$", fontsize=14, ha="center",
            va="center", color=BLU2, style="italic")
    ax.text(COL_X[1], 4.35, r"$p = 3$", fontsize=14, ha="center",
            va="center", color=RED3, style="italic")

    # ================================================================ #
    # Row labels                                                       #
    # ================================================================ #
    for i, y in enumerate(ROW_Y):
        ax.text(1.7, y, f"$d_{i+1}$", fontsize=14, ha="right",
                va="center", color=INK, style="italic")

    # ================================================================ #
    # Grid cells                                                       #
    # ================================================================ #
    # (row, col) -> (content, color)
    cells = [
        # Row 0: d_1 = 2
        (0, 0, r"$2^1$", BLU2),
        (0, 1, r"$3^0 = 1$", RED3),
        # Row 1: d_2 = 6
        (1, 0, r"$2^1$", BLU2),
        (1, 1, r"$3^1$", RED3),
        # Row 2: d_3 = 12
        (2, 0, r"$2^2$", BLU2),
        (2, 1, r"$3^1$", RED3),
    ]
    for r, c, txt, color in cells:
        cx, cy = COL_X[c], ROW_Y[r]
        _cell_box(ax, cx, cy, color)
        ax.text(cx, cy, txt, fontsize=14, ha="center", va="center",
                color=color, style="italic", zorder=2)

    # ================================================================ #
    # Right arrows + product labels                                    #
    # ================================================================ #
    products = [r"$= 2$", r"$= 6$", r"$= 12$"]
    arrow_x_start = COL_X[-1] + CELL_W / 2 + 0.15
    arrow_x_end = arrow_x_start + 0.5
    for i, y in enumerate(ROW_Y):
        ax.annotate(
            "", xy=(arrow_x_end, y), xytext=(arrow_x_start, y),
            arrowprops=dict(arrowstyle="-|>", color=GRY, lw=1.2,
                            mutation_scale=12),
            zorder=1)
        ax.text(arrow_x_end + 0.15, y, products[i], fontsize=14,
                ha="left", va="center", color=INK, style="italic")

    # ================================================================ #
    # Bottom: elementary divisors                                      #
    # ================================================================ #
    div_y = 0.9
    # dashed line
    ax.plot([COL_X[0] - CELL_W / 2, COL_X[-1] + CELL_W / 2],
            [div_y + 0.25, div_y + 0.25],
            color=GRY, lw=0.8, ls=(0, (4, 2)), zorder=0)
    # coloured text
    ax.text(COL_X[0] - 0.1, div_y - 0.1,
            "Elementary divisors:  ",
            fontsize=12, ha="left", va="center", color=INK)
    # Build the coloured list manually for mixed colours
    x0 = 3.0
    parts = [
        (r"$2^1$", BLU2),
        (", ", INK),
        (r"$2^1$", BLU2),
        (", ", INK),
        (r"$2^2$", BLU2),
        (", ", INK),
        (r"$3^1$", RED3),
        (", ", INK),
        (r"$3^1$", RED3),
    ]
    for txt, col in parts:
        ax.text(x0, div_y - 0.1, txt, fontsize=12, ha="left",
                va="center", color=col, style="italic")
        # approximate advance (good enough for monospaced layout)
        x0 += len(txt) * 0.09 + 0.05

    # -- canvas ---------------------------------------------------------- #
    ax.set_xlim(0.8, 7.5)
    ax.set_ylim(0.2, 5.0)
    ax.set_aspect("equal")
    ax.axis("off")

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "factor-correspondence")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
