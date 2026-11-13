"""Matching M in a bipartite graph G=(X,Y,E) with an M-augmenting path.

Single-panel, transparent-background vector illustration (sans-serif,
black-ink style with red/blue accents).

Left column X:  x1 (unmatched, open red disc), x2, x3, x4 (matched, filled).
Right column Y: y1, y2, y3 (matched, filled), y4 (unmatched, open red disc).
Matching edges M (red solid): x2-y1, x3-y2, x4-y3.
Non-matching edges (thin black): x1-y1, x2-y2, x3-y4.
The blue dashed M-augmenting path x1-y1-x2-y2-x3-y4 overlays those edges,
with the red matching edges kept underneath where the path passes through.

Run with: uv run python src/math_paper/augmenting_path.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(12.8, 6.9))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1a1a1a"
GRAY = "#333333"
RED = "#c0392b"
BLUE = "#2980b9"

XC = 6.0   # x-coordinate of column X
YC = 21.0  # x-coordinate of column Y
YS = [7.5, 4.5, 1.5, -1.5]  # row y for x_i / y_i (i = 1..4)

# M: red solid matching edges x2-y1, x3-y2, x4-y3
MATCHING = [
    ((XC, YS[1]), (YC, YS[0])),
    ((XC, YS[2]), (YC, YS[1])),
    ((XC, YS[3]), (YC, YS[2])),
]

# thin black non-matching edges used by the augmenting path
NONMATCH = [
    ((XC, YS[0]), (YC, YS[0])),   # x1-y1
    ((XC, YS[1]), (YC, YS[1])),   # x2-y2
    ((XC, YS[2]), (YC, YS[3])),   # x3-y4
]

# blue dashed augmenting path x1-y1-x2-y2-x3-y4 (corner points)
AUGPATH = [
    (XC, YS[0]), (YC, YS[0]), (XC, YS[1]),
    (YC, YS[1]), (XC, YS[2]), (YC, YS[3]),
]

R = 0.60  # vertex radius


def panel(ax):
    # non-matching edges (thin black, underneath)
    for (x1, y1), (x2, y2) in NONMATCH:
        ax.plot([x1, x2], [y1, y2], color=GRAY, lw=1.0, zorder=1)

    # matching edges (red solid)
    for (x1, y1), (x2, y2) in MATCHING:
        ax.plot([x1, x2], [y1, y2], color=RED, lw=2.0, zorder=2)

    # blue dashed M-augmenting path overlays the relevant edges
    xs = [p[0] for p in AUGPATH]
    ys = [p[1] for p in AUGPATH]
    for i in range(len(AUGPATH) - 1):
        ax.plot([xs[i], xs[i + 1]], [ys[i], ys[i + 1]], color=BLUE, lw=2.4,
                ls=(0, (6, 3)), zorder=3, solid_capstyle="butt")

    # vertices: matched are filled black, unmatched are open red discs
    for k, y in enumerate(YS):
        unmatched = k == 0          # x1
        ax.add_patch(plt.Circle((XC, y), R, facecolor="white"
                                if unmatched else INK,
                                edgecolor=RED if unmatched else "none",
                                lw=2.2 if unmatched else 0, zorder=5))
    for k, y in enumerate(YS):
        unmatched = k == 3          # y4
        ax.add_patch(plt.Circle((YC, y), R, facecolor="white"
                                if unmatched else INK,
                                edgecolor=RED if unmatched else "none",
                                lw=2.2 if unmatched else 0, zorder=5))

    # vertex labels (subscripts), offset so nothing collides
    ax.text(XC, YS[0] + 1.9, r"$x_1$", ha="center", va="center",
            fontsize=16, color=INK, zorder=6)
    for k in (1, 2, 3):
        ax.text(XC - 1.6, YS[k], rf"$x_{k + 1}$", ha="right", va="center",
                fontsize=16, color=INK, zorder=6)
    for k in (0, 1, 2):
        ax.text(YC + 1.0, YS[k], rf"$y_{k + 1}$", ha="left", va="center",
                fontsize=16, color=INK, zorder=6)
    ax.text(YC, YS[3] - 2.2, r"$y_4$", ha="center", va="center",
            fontsize=16, color=INK, zorder=6)

    # red "unmatched vertex" annotations pointing at both open discs
    ax.annotate("unmatched vertex", xy=(XC - R - 0.05, YS[0]),
                xytext=(-1.9, YS[0]), ha="center", va="center",
                fontsize=10.5, color=RED,
                arrowprops=dict(arrowstyle="-|>", color=RED, lw=1.1,
                                mutation_scale=12), zorder=6)
    ax.annotate("unmatched vertex", xy=(YC + R + 0.05, YS[3]),
                xytext=(25.2, YS[3]), ha="center", va="center",
                fontsize=10.5, color=RED,
                arrowprops=dict(arrowstyle="-|>", color=RED, lw=1.1,
                                mutation_scale=12), zorder=6)

    # blue label above the path
    ax.text(13.5, 11.0, "M-augmenting path", ha="center", va="center",
            fontsize=13, color=BLUE, zorder=6)

    # bottom caption
    ax.text(13.0, -6.0,
            "Flipping along the path: non-matching edges become matching, "
            "and vice versa, increasing |M| by 1.",
            ha="center", va="center", fontsize=10, color=GRAY, zorder=6)

    ax.set_xlim(-8.0, 29.8)
    ax.set_ylim(-8.2, 13.2)
    ax.set_aspect("equal")
    ax.axis("off")


def build_figure():
    fig = SPEC.figure()
    panel(fig.add_subplot(111))
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "augmenting-path")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
