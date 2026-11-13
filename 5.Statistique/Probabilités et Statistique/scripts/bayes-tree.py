"""Bayes tree — two-layer binary tree of joint probabilities.

Root 'Random individual' splits into D (diseased) and D̄ (healthy);
each splits into test outcome +/−.  Leaf boxes show the joint
probability; the D ∩ + leaf is highlighted.  A bottom annotation
gives the posterior P(D|+).

Run with: uv run python src/math_paper/bayes_tree.py
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

SPEC = replace(Presets.SVG_MATH, figsize=(13, 7), transparent=False)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#1f4e9b"
LBLU = "#cfe3f7"
HIGHLIGHT = "#a8dadc"
DARK = "#222222"
GRAY = "#666666"
LIGHT = "#f0f0f0"

ROOT = (1.5, 3.5)
D_NODE = (5.5, 5.2)
DB_NODE = (5.5, 1.8)
LEAVES = {
    "dp": (10.5, 6.4),
    "dm": (10.5, 4.0),
    "bp": (10.5, 3.0),
    "bm": (10.5, 0.6),
}

EDGES = [
    (ROOT, D_NODE,  "P(D) = 0.001",       "upper"),
    (ROOT, DB_NODE, r"P($\bar{D}$) = 0.999", "lower"),
    (D_NODE, LEAVES["dp"], "P(+|D) = 0.99",  "upper"),
    (D_NODE, LEAVES["dm"], r"P($-$|D) = 0.01", "lower"),
    (DB_NODE, LEAVES["bp"], r"P(+|$\bar{D}$) = 0.01", "upper"),
    (DB_NODE, LEAVES["bm"], r"P($-$|$\bar{D}$) = 0.99", "lower"),
]


def draw_node(ax, xy, text, fc, ec, fontsize=11, fw="bold", w=1.7, h=0.64,
              **text_kw):
    ax.add_patch(mpatches.FancyBboxPatch(
        (xy[0] - w / 2, xy[1] - h / 2), w, h,
        boxstyle="round,pad=0.05,rounding_size=0.12",
        facecolor=fc, edgecolor=ec, lw=1.3, zorder=3))
    ax.text(xy[0], xy[1], text, fontsize=fontsize, color=DARK,
            ha="center", va="center", fontweight=fw, zorder=4, **text_kw)


def draw_leaf(ax, xy, outcome, joint, highlight=False):
    fc = HIGHLIGHT if highlight else LIGHT
    ec = BLU if highlight else GRAY
    lw = 1.8 if highlight else 1.0
    ax.add_patch(mpatches.FancyBboxPatch(
        (xy[0] - 0.72, xy[1] - 0.38), 1.44, 0.76,
        boxstyle="round,pad=0.04,rounding_size=0.10",
        facecolor=fc, edgecolor=ec, lw=lw, zorder=3))
    ax.text(xy[0], xy[1] + 0.12, outcome, fontsize=12, color=DARK,
            ha="center", va="center", fontweight="bold", zorder=4)
    ax.text(xy[0], xy[1] - 0.18, joint, fontsize=9, color=GRAY,
            ha="center", va="center", zorder=4)


def draw_edge(ax, p1, p2, label, side):
    ax.plot([p1[0], p2[0]], [p1[1], p2[1]], color=DARK, lw=1.0,
            zorder=1, solid_capstyle="round")
    mx = p1[0] + 0.42 * (p2[0] - p1[0])
    my = p1[1] + 0.42 * (p2[1] - p1[1])
    dy = p2[1] - p1[1]
    dx = p2[0] - p1[0]
    length = np.hypot(dx, dy)
    px, py = -dy / length, dx / length
    sign = 1 if side == "upper" else -1
    offset = 0.32
    ax.text(mx + sign * px * offset, my + sign * py * offset, label,
            fontsize=9, color=BLU, ha="center", va="center", zorder=5)


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)
    ax.set_xlim(-0.5, 13)
    ax.set_ylim(-1.2, 7.5)
    ax.set_aspect("equal")
    ax.axis("off")

    for (p1, p2, label, side) in EDGES:
        draw_edge(ax, p1, p2, label, side)

    draw_node(ax, ROOT, "Random individual", LIGHT, GRAY, fontsize=11, w=2.6)
    draw_node(ax, D_NODE, "D (diseased)", LBLU, BLU)
    draw_node(ax, DB_NODE, "D\u0304 (healthy)", LBLU, BLU)

    draw_leaf(ax, LEAVES["dp"], "+",  "0.00099", highlight=True)
    draw_leaf(ax, LEAVES["dm"], "\u2212", "0.00001")
    draw_leaf(ax, LEAVES["bp"], "+",  "0.00999")
    draw_leaf(ax, LEAVES["bm"], "\u2212", "0.98901")

    ax.text(10.5, -0.65,
            r"$P(D\,|\,+) = \dfrac{0.00099}{0.00099 + 0.00999}"
            r"\approx 9\%$",
            fontsize=12, color=DARK, ha="center", va="center",
            style="italic",
            bbox=dict(boxstyle="round,pad=0.3", fc="#fafafa", ec="#cccccc",
                      lw=0.7))

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "bayes-tree")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
