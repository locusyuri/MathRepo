"""Ramsey recursion R(4,4) <= R(3,4) + R(4,3): neighbours of vertex v.

Single-panel, transparent-background vector illustration (sans-serif,
black-ink style with red/blue accents).

Vertex v in the centre sends out 17 edges: 9 red (solid) to the red
neighbours on the left arc and 8 blue (dashed) to the blue neighbours on
the right arc.  Inside the red neighbourhood either a red K3 appears
(which together with v gives a red K4) or the whole set is blue K4-free
forcing a blue K4 — hence R(4,4) <= R(3,4)+R(4,3) = 2R(3,4) <= 18.

Run with: uv run python src/math_paper/ramsey_r44.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(10.0, 9.6))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#111111"
GREY = "#444444"
RED = "#c0392b"
BLUE = "#2c3e50"

V = np.array([0.0, 0.0])
R = 3.9        # radius of the neighbour ring
DR = 0.30      # neighbour dot radius


def _node(ax, xy, r, color, z=3):
    ax.add_patch(plt.Circle(xy, r, facecolor=color, edgecolor="none", zorder=z))


def panel(ax):
    # neighbour positions: 9 red on the left arc, 8 blue on the right arc
    red_ang = np.deg2rad(np.linspace(100.0, 260.0, 9))
    blue_ang = np.deg2rad(np.linspace(-80.0, 80.0, 8))
    red_pts = [R * np.array([np.cos(a), np.sin(a)]) for a in red_ang]
    blue_pts = [R * np.array([np.cos(a), np.sin(a)]) for a in blue_ang]

    # edges from v (red solid, blue dashed)
    for p in red_pts:
        ax.plot([V[0], p[0]], [V[1], p[1]], color=RED, lw=1.5, zorder=1)
    for p in blue_pts:
        ax.plot([V[0], p[0]], [V[1], p[1]], color=BLUE, lw=1.5,
                ls=(0, (5, 3)), zorder=1)

    # neighbour dots
    for p in red_pts:
        _node(ax, p, DR, RED)
    for p in blue_pts:
        _node(ax, p, DR, BLUE)

    # vertex v
    _node(ax, V, 0.34, INK, z=4)
    ax.text(0.0, -1.02, "v", ha="center", va="center", fontsize=13,
            color=INK, zorder=5)

    # group labels at the sides of the two arcs
    ax.text(-6.5, 0.32, "red neighbors,", ha="center", va="center",
            fontsize=12.5, color=RED, zorder=5)
    ax.text(-6.5, -0.24, "\u2265 9", ha="center", va="center",
            fontsize=12.5, color=RED, zorder=5)
    ax.text(6.5, 0.0, "blue neighbors", ha="center", va="center",
            fontsize=12.5, color=BLUE, zorder=5)

    # spread bracket over the 17 neighbours + its caption
    w, yb, h = 4.9, 4.45, 0.6
    xs = np.linspace(-w, w, 200)
    ys = yb + h * (1.0 - (xs / w) ** 2)
    ax.plot(xs, ys, color=GREY, lw=1.2, zorder=2)
    ax.plot([-w, -w], [yb - 0.30, yb], color=GREY, lw=1.2, zorder=2)
    ax.plot([w, w], [yb - 0.30, yb], color=GREY, lw=1.2, zorder=2)
    ax.text(0.0, 5.78, "17 neighbors", ha="center", va="center",
            fontsize=13.5, color=INK, zorder=5)

    # note under the red (left) arc
    ax.text(-2.7, -4.95, "among the 9 red neighbours:",
            ha="center", va="center", fontsize=10.5, color=INK, zorder=5)
    ax.text(-2.7, -5.5, r"either red $K_3$ (with $v$: red $K_4$)",
            ha="center", va="center", fontsize=10.5, color=INK, zorder=5)
    ax.text(-2.7, -6.05, "or blue $K_4$",
            ha="center", va="center", fontsize=10.5, color=INK, zorder=5)

    # top title
    ax.text(0.0, 7.15,
            "Recursion  R(4,4) \u2264 R(3,4) + R(4,3) = 2R(3,4) \u2264 18",
            ha="center", va="center", fontsize=15, color=INK, zorder=5)

    # bottom caption
    ax.text(0.0, -7.15,
            "At least \u230817/2\u2309 = 9 neighbors share a color "
            "(pigeonhole).",
            ha="center", va="center", fontsize=11, color=GREY, zorder=5)

    ax.set_xlim(-8.4, 8.4)
    ax.set_ylim(-8.0, 7.7)
    ax.set_aspect("equal")
    ax.axis("off")


def build_figure():
    fig = SPEC.figure()
    panel(fig.add_subplot(111))
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "ramsey-r44")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
