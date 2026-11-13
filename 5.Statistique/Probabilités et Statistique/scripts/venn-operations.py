"""Venn diagram operations: union, intersection, difference, complement.

2x2 grid of panels. Circles A and B are drawn as outlines only; the
result region of each set operation is filled with a single colour.

Run with: uv run python src/math_paper/venn_operations.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
from matplotlib.path import Path as MPath
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(10, 8), transparent=False)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

cx_a, cy_a, r_a = -0.7, 0, 1.0
cx_b, cy_b, r_b = 0.7, 0, 1.0

d = cx_b - cx_a
y_int = np.sqrt(r_a**2 - (d / 2) ** 2)

theta_a_top = np.degrees(np.arctan2(y_int, -cx_a))
theta_a_bot = -theta_a_top
theta_b_top = np.degrees(np.arctan2(y_int, -cx_b))
theta_b_bot = -theta_b_top

FILL = "#4a90d9"
DARK = "#222222"
BLU = "#1f4e9b"
ORG = "#c0392b"
FRAME = "#aaaaaa"


def arc_vertices(cx, cy, r, theta1, theta2, n=120):
    thetas = np.linspace(np.deg2rad(theta1), np.deg2rad(theta2), n)
    return np.column_stack([cx + r * np.cos(thetas), cy + r * np.sin(thetas)])


def draw_panel(ax, label, shade_func):
    ax.set_xlim(-2, 2)
    ax.set_ylim(-1.5, 1.5)
    ax.set_aspect("equal")
    ax.set_xticks([])
    ax.set_yticks([])
    for s in ax.spines.values():
        s.set_visible(False)

    rect = mpatches.Rectangle((-2, -1.5), 4, 3, fill=False,
                               edgecolor=FRAME, lw=0.8, ls="-", zorder=1)
    ax.add_patch(rect)

    shade_func(ax)

    circle_a = mpatches.Circle((cx_a, cy_a), r_a, fill=False,
                                edgecolor=BLU, lw=1.6, zorder=3)
    circle_b = mpatches.Circle((cx_b, cy_b), r_b, fill=False,
                                edgecolor=ORG, lw=1.6, zorder=3)
    ax.add_patch(circle_a)
    ax.add_patch(circle_b)

    ax.text(cx_a - 0.85, cy_a + 0.85, "A", fontsize=14, color=BLU,
            ha="center", fontweight="bold")
    ax.text(cx_b + 0.85, cy_b + 0.85, "B", fontsize=14, color=ORG,
            ha="center", fontweight="bold")
    ax.text(1.85, 1.35, r"$\Omega$", fontsize=14, color=DARK,
            ha="right", fontweight="bold")
    ax.text(0, -1.72, label, fontsize=15, color=DARK, ha="center",
            transform=ax.transData)


def shade_union(ax):
    a = mpatches.Circle((cx_a, cy_a), r_a, facecolor=FILL, alpha=0.55,
                         edgecolor="none", zorder=2)
    b = mpatches.Circle((cx_b, cy_b), r_b, facecolor=FILL, alpha=0.55,
                         edgecolor="none", zorder=2)
    ax.add_patch(a)
    ax.add_patch(b)


def shade_intersection(ax):
    arc1 = arc_vertices(cx_b, cy_b, r_b, theta_b_top, theta_b_top + 91.2)
    arc2 = arc_vertices(cx_a, cy_a, r_a, theta_a_bot, theta_a_top)
    verts = np.vstack([arc1, arc2])
    patch = mpatches.PathPatch(MPath(verts, closed=True),
                                facecolor=FILL, alpha=0.55, edgecolor="none",
                                zorder=2)
    ax.add_patch(patch)


def shade_a_minus_b(ax):
    arc1 = arc_vertices(cx_a, cy_a, r_a, theta_a_top, theta_a_top + 268.8)
    arc2 = arc_vertices(cx_b, cy_b, r_b, theta_b_bot + 360, theta_b_top)
    verts = np.vstack([arc1, arc2])
    patch = mpatches.PathPatch(MPath(verts, closed=True),
                                facecolor=FILL, alpha=0.55, edgecolor="none",
                                zorder=2)
    ax.add_patch(patch)


def shade_complement_a(ax):
    rect = np.array([[-2, -1.5], [2, -1.5], [2, 1.5], [-2, 1.5], [-2, -1.5]])
    circle = arc_vertices(cx_a, cy_a, r_a, 360, 0)
    compound = MPath.make_compound_path(MPath(rect), MPath(circle))
    patch = mpatches.PathPatch(compound, facecolor=FILL, alpha=0.55,
                                edgecolor="none", zorder=2)
    ax.add_patch(patch)


def build_figure():
    fig = SPEC.figure()
    panels = [
        (r"$A \cup B$", shade_union),
        (r"$A \cap B$", shade_intersection),
        (r"$A \setminus B$", shade_a_minus_b),
        (r"$\overline{A}$", shade_complement_a),
    ]
    for i, (label, shade_func) in enumerate(panels):
        ax = fig.add_subplot(2, 2, i + 1)
        draw_panel(ax, label, shade_func)
    fig.subplots_adjust(hspace=0.45, wspace=0.15)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "venn-operations")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
