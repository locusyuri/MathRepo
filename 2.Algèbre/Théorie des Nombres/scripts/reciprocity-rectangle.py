"""Gauss reciprocity on an m x n lattice point rectangle.

White-background, sans-serif, single-panel teaching diagram.

For p = 11 and q = 13 (coprime odd), m = (p-1)/2 = 5 columns (i = 1..m) and
n = (q-1)/2 = 6 rows (j = 1..n).  The 30 lattice points (i, j) are split by
the diagonal j = (q/p) i (slope 13/11) through the origin:

    below the line (royal blue, 15 points):  sum_i floor(q i / p) = 15
    above the line (dark orange, 15 points): sum_j floor(p j / q) = 15
    identity:  15 + 15 = 30 = m * n

No lattice point lies on the diagonal (gcd(11, 13) = 1 and i <= 5 < 11,
j <= 6 < 13).

Run with: uv run python src/math_paper/reciprocity_rectangle.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import math
import sys

import matplotlib.pyplot as plt
from matplotlib.patches import Circle, FancyArrowPatch, Polygon

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(9.0, 10.2), transparent=False)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

# --------------------------------------------------------------------------- #
# Data / rules (verified by asserts below)
# --------------------------------------------------------------------------- #
P, Q = 11, 13            # diagonal slope q/p = 13/11
M = (P - 1) // 2         # horizontal extent m = 5
N = (Q - 1) // 2         # vertical extent n = 6

POINTS = [(i, j) for i in range(1, M + 1) for j in range(1, N + 1)]
BELOW = [(i, j) for i, j in POINTS if j * P < i * Q]   # under the line, blue
ABOVE = [(i, j) for i, j in POINTS if j * P > i * Q]   # over the line, orange

# --------------------------------------------------------------------------- #
# Colours
# --------------------------------------------------------------------------- #
INK = "#000000"
GRID = "#D6D6D6"
ROYAL = "#4169E1"
ORANGE = "#FF8C00"
DOT_R = 0.125            # dot radius (diameter ~ 1/4 of the unit cell)

# --------------------------------------------------------------------------- #
# Verification of the counting rules
# --------------------------------------------------------------------------- #
assert len(POINTS) == M * N == 30
assert len(BELOW) == sum(math.floor(Q * i / P) for i in range(1, M + 1)) == 15
assert len(ABOVE) == sum(math.floor(P * j / Q) for j in range(1, N + 1)) == 15

# Diagonal reaches the right side just below the top row; the last cell of the
# upper-right corner point (M, N) is so close to the line that we stop the
# stroke just short of x = M so it never touches that dot.
X_END = 4.85
Y_END = Q / P * X_END

# --------------------------------------------------------------------------- #
# Panels
# --------------------------------------------------------------------------- #
def style_axis(ax):
    ax.set_xlim(-1.15, 6.15)
    ax.set_ylim(-1.80, 7.05)
    ax.set_aspect("equal")
    ax.set_xticks([])
    ax.set_yticks([])
    for s in ax.spines.values():
        s.set_visible(False)


def panel(ax):
    # -- tinted regions (bottom layer) ----------------------------------- #
    ax.add_patch(Polygon([(0, 0), (M, 0), (M, Q * M / P)],
                         closed=True, facecolor=ROYAL, alpha=0.16,
                         edgecolor="none", zorder=0.4))
    ax.add_patch(Polygon([(0, 0), (M, Q * M / P), (M, N), (0, N)],
                         closed=True, facecolor=ORANGE, alpha=0.16,
                         edgecolor="none", zorder=0.4))

    # -- light gray grid lines ------------------------------------------- #
    for x in range(1, M + 1):
        ax.plot([x, x], [0, N], color=GRID, lw=0.6, zorder=1)
    for y in range(1, N + 1):
        ax.plot([0, M], [y, y], color=GRID, lw=0.6, zorder=1)

    # -- black axes with small arrow heads -------------------------------- #
    akw = dict(arrowstyle="-|>", color=INK, lw=1.0, mutation_scale=10)
    ax.add_patch(FancyArrowPatch((0, 0), (5.55, 0), **akw, zorder=4))
    ax.add_patch(FancyArrowPatch((0, 0), (0, 6.45), **akw, zorder=4))

    # -- black diagonal ---------------------------------------------------- #
    ax.plot([0, X_END], [0, Y_END], color=INK, lw=1.2, zorder=4.5)

    # -- lattice points ---------------------------------------------------- #
    for i, j in BELOW:
        ax.add_patch(Circle((i, j), DOT_R, facecolor=ROYAL,
                            edgecolor="none", zorder=5))
    for i, j in ABOVE:
        ax.add_patch(Circle((i, j), DOT_R, facecolor=ORANGE,
                            edgecolor="none", zorder=5))

    # -- leader lines from the diagonal midpoint to the labels ------------ #
    MX, MY = 2.5, Q / P * 2.5          # point on the diagonal, mid width
    ax.plot([MX, MX], [MY, 1.65], color=INK, lw=0.7, zorder=4)
    ax.plot([MX, MX], [MY, 4.35], color=INK, lw=0.7, zorder=4)

    # -- labels inside the two regions ------------------------------------ #
    ax.text(MX, 1.50, r"$\sum \mathrm{floor}\left(q\cdot i/p\right)=15$",
            ha="center", va="center", fontsize=13, color=INK, zorder=6)
    ax.text(MX, 4.50, r"$\sum \mathrm{floor}\left(p\cdot j/q\right)=15$",
            ha="center", va="center", fontsize=13, color=INK, zorder=6)

    # -- axis end labels ---------------------------------------------------- #
    ax.text(5.85, -0.28, r"$i$", ha="left", va="center",
            fontsize=13, color=INK, zorder=6)
    ax.text(-0.35, 6.55, r"$j$", ha="right", va="center",
            fontsize=13, color=INK, zorder=6)

    # -- origin ------------------------------------------------------------- #
    ax.text(-0.52, -0.28, "O", ha="center", va="center",
            fontsize=11, color=INK, zorder=6)

    # -- small explanatory note near the origin ---------------------------- #
    ax.text(1.30, -0.55,
            "lattice points $(i,j)$, $1 \u2264 i \u2264 m$, "
            "$1 \u2264 j \u2264 n$",
            ha="center", va="top", fontsize=10, color=INK, zorder=6)

    # -- identity line below the rectangle --------------------------------- #
    ax.text(M / 2, -1.35,
            r"$15+15=30=m\cdot n$  where  "
            r"$m=(p-1)/2,\ n=(q-1)/2$",
            ha="center", va="center", fontsize=13, color=INK, zorder=6)


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)
    style_axis(ax)
    panel(ax)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "reciprocity-rectangle")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
