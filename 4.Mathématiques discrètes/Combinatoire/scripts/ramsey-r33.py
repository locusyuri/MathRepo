"""Ramsey number R(3,3): vertex v with 5 neighbours and the two-colouring argument.

Top    : vertex v joined to the 5 pentagon neighbours; 3 red edges (va,vb,vc)
         and 2 blue edges (vd,ve) — pigeonhole step.
Bottom : the two cases among the red neighbours {a,b,c}:
         Case 1 — some edge among a,b,c (here ab) is red  -> red K3 = vab
         Case 2 — all edges among a,b,c are blue          -> blue K3 = abc

Run with: uv run python src/math_paper/ramsey_r33.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch, Polygon
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH_PANEL, figsize=(12.0, 9.0))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#111111"
RED = "#c0392b"
BLUE = "#2c3e50"


def _node(ax, xy, label, dx=0.0, dy=0.0, ha="center", va="bottom"):
    ax.plot(*xy, "o", ms=6, color=INK, zorder=6)
    ax.text(xy[0] + dx, xy[1] + dy, label, fontsize=13, color=INK,
            ha=ha, va=va, zorder=7)


def _edge(ax, p, q, color, lw=2.0, ls="-", z=4):
    ax.plot([p[0], q[0]], [p[1], q[1]], color=color, lw=lw, ls=ls,
            zorder=z)


# ========================================================================= #
#  Top panel — vertex v with its 5 incident edges                           #
# ========================================================================= #
def panel_top(ax):
    ang = np.deg2rad([90, 18, -54, -126, -198])   # a,b,c,d,e clockwise
    pos = {name: np.array([np.cos(t), np.sin(t)]) for name, t in
           zip("abcde", ang)}
    v = np.array([0.0, 0.0])

    # 5 edges: va,vb,vc red solid ; vd,ve blue dashed
    for name in "abc":
        _edge(ax, v, pos[name], RED)
    for name in "de":
        _edge(ax, v, pos[name], BLUE, ls="--")

    # rounded box circling the 3 red edges + caption
    box = FancyBboxPatch((-0.18, -1.02), 1.92, 2.14,
                         boxstyle="round,pad=0.06,rounding_size=0.22",
                         facecolor=RED, alpha=0.06, edgecolor=RED,
                         lw=1.1, ls=(0, (3, 3)), zorder=1)
    ax.add_patch(box)
    ax.text(0.95, 0.78, "\u2265 3 same color", fontsize=12,
            color=INK, ha="center", va="center", zorder=8)
    ax.text(0.95, 0.60, "(red)", fontsize=12, color=RED,
            ha="center", va="center", zorder=8)

    # nodes + labels
    for name, p in pos.items():
        u = p / np.linalg.norm(p)
        _node(ax, p, name, dx=0.16 * u[0], dy=0.16 * u[1])
    ax.plot(*v, "o", ms=7, color=INK, zorder=6)
    ax.text(-0.26, 0.13, "v", fontsize=13, color=INK,
            ha="right", va="center", zorder=7)

    ax.set_xlim(-1.5, 2.0)
    ax.set_ylim(-1.25, 1.4)
    ax.set_aspect("equal")
    ax.axis("off")
    ax.set_title("Vertex v and its 5 incident edges", fontsize=16, pad=12)


# ========================================================================= #
#  Bottom-left — Case 1: some edge among {a,b,c} is red  (vab is red K3)    #
# ========================================================================= #
def panel_case1(ax):
    v = np.array([0.0, -0.55])
    a = np.array([-1.0, 0.6])
    b = np.array([1.0, 0.6])
    c = np.array([0.0, -1.08])

    for name, p in [("a", a), ("b", b), ("c", c)]:
        _edge(ax, v, p, RED)
    _edge(ax, a, b, RED)
    ax.add_patch(Polygon([v, a, b], closed=True, facecolor=RED,
                         alpha=0.22, edgecolor="none", zorder=1))

    for p in (v, a, b, c):
        ax.plot(*p, "o", ms=6, color=INK, zorder=6)
    ax.text(*a, "a", fontsize=13, color=INK, ha="right", va="bottom",
            zorder=7)
    ax.text(*b, "b", fontsize=13, color=INK, ha="left", va="bottom",
            zorder=7)
    ax.text(*c, "c", fontsize=13, color=INK, ha="center", va="top",
            zorder=7)
    ax.text(-0.26, -0.55, "v", fontsize=13, color=INK,
            ha="left", va="center", zorder=7)

    ax.text(0.0, 0.10, "red $K_3$", fontsize=14, color=RED,
            ha="center", va="center", zorder=8)

    ax.set_xlim(-1.45, 1.45)
    ax.set_ylim(-1.5, 1.05)
    ax.set_aspect("equal")
    ax.axis("off")
    ax.set_title("Case 1: edge among {a,b,c} is red", fontsize=15, pad=10)


# ========================================================================= #
#  Bottom-right — Case 2: all edges among {a,b,c} are blue  (abc is blue K3)#
# ========================================================================= #
def panel_case2(ax):
    a = np.array([0.0, -1.0])     # bottom vertex of triangle abc
    b = np.array([-1.0, 0.72])
    c = np.array([1.0, 0.72])
    v = np.array([0.0, -1.75])

    # blue triangle abc
    for p, q in [(a, b), (b, c), (c, a)]:
        _edge(ax, p, q, BLUE, ls="--")
    ax.add_patch(Polygon([a, b, c], closed=True, facecolor=BLUE,
                         alpha=0.22, edgecolor="none", zorder=1))
    # red fan from v to the three neighbours
    for p in (a, b, c):
        _edge(ax, v, p, RED)

    for p in (a, b, c, v):
        ax.plot(*p, "o", ms=6, color=INK, zorder=6)
    ax.text(-0.22, -1.06, "a", fontsize=13, color=INK,
            ha="center", va="center", zorder=7)
    ax.text(-1.2, 0.85, "b", fontsize=13, color=INK, zorder=7)
    ax.text(1.2, 0.85, "c", fontsize=13, color=INK, zorder=7)
    ax.text(0.0, -1.96, "v", fontsize=13, color=INK,
            ha="center", va="center", zorder=7)

    ax.text(0.0, 0.12, "blue $K_3$", fontsize=14, color=BLUE,
            ha="center", va="center", zorder=8)

    ax.set_xlim(-1.45, 1.45)
    ax.set_ylim(-2.25, 1.15)
    ax.set_aspect("equal")
    ax.axis("off")
    ax.set_title("Case 2: all edges among {a,b,c} are blue", fontsize=15,
                 pad=10)


def build_figure():
    fig = SPEC.figure()
    gs = fig.add_gridspec(2, 2, height_ratios=[1.0, 1.06], hspace=0.34,
                          wspace=0.28, left=0.02, right=0.98, bottom=0.04,
                          top=0.94)
    panel_top(fig.add_subplot(gs[0, :]))
    panel_case1(fig.add_subplot(gs[1, 0]))
    panel_case2(fig.add_subplot(gs[1, 1]))
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "ramsey-r33")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
