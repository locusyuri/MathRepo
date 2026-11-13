"""Partition and quotient set illustration.

Two-panel schematic:
  Left  -- A set S partitioned into three equivalence classes [a],[b],[c]
  Right -- The quotient set S/R (each class collapsed to one point)
  Grey curved arrows connect each region to its representative point.

Run with: uv run python src/math_paper/partition_quotient.py
"""

from __future__ import annotations

from pathlib import Path
import sys

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = Presets.SVG_MATH_PANEL
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

LBLU = "#d4e6f1"
LORG = "#fdebd0"
LGRN = "#d5f5e3"
AXC = "#333333"
GRY = "#999999"


def blob_xy(t):
    """Smooth irregular closed curve."""
    return 2.2 * np.cos(t) + 0.12 * np.cos(2 * t), \
           1.7 * np.sin(t) + 0.08 * np.sin(3 * t)


def qbez(p0, cp, p1, n=25):
    """Quadratic Bezier points from p0 via cp to p1."""
    s = np.linspace(0, 1, n)[:, None]
    return ((1 - s) ** 2 * p0 + 2 * (1 - s) * s * cp + s ** 2 * p1)


def build_figure():
    fig = SPEC.figure()
    ax1 = fig.add_axes([0.04, 0.08, 0.38, 0.82])
    ax2 = fig.add_axes([0.60, 0.08, 0.36, 0.82])

    # ================================================================== #
    #  LEFT PANEL  --  partition of S                                     #
    # ================================================================== #
    # blob boundary
    t_b = np.linspace(0, 2 * np.pi, 400)
    bx, by = blob_xy(t_b)

    # junction point (inside blob)
    J = np.array([-0.1, -0.15])

    # three dividing curves meet blob boundary at these angles
    a0, a1, a2 = 7 * np.pi / 6, np.pi / 2, 11 * np.pi / 6
    B0 = np.array(blob_xy(np.array([a0]))).ravel()   # lower-left
    B1 = np.array(blob_xy(np.array([a1]))).ravel()   # top
    B2 = np.array(blob_xy(np.array([a2]))).ravel()   # lower-right

    # Bezier control points for the three dividing curves
    c0 = np.array([-1.3, 0.4])    # J -> B0
    c1 = np.array([0.0, 1.2])     # J -> B1
    c2 = np.array([1.3, 0.3])     # J -> B2

    # curve point arrays  (J -> boundary)
    d0 = qbez(J, c0, B0)          # J -> B0
    d1 = qbez(J, c1, B1)          # J -> B1
    d2 = qbez(J, c2, B2)          # J -> B2

    # -- find indices on blob boundary closest to B0, B1, B2 ------------ #
    def blob_idx(pt):
        dists = (bx - pt[0]) ** 2 + (by - pt[1]) ** 2
        return int(np.argmin(dists))

    i0, i1, i2 = blob_idx(B0), blob_idx(B1), blob_idx(B2)

    # -- build region polygons ------------------------------------------ #
    # Region A (blue, bottom): blob[i0 -> i2] then d2 reversed, J, d0 reversed
    seg_bot_x = bx[i0:i2]
    seg_bot_y = by[i0:i2]
    rAx = np.r_[seg_bot_x, d2[::-1, 0], J[0], d0[::-1, 0]]
    rAy = np.r_[seg_bot_y, d2[::-1, 1], J[1], d0[::-1, 1]]

    # Region B (orange, upper-left): blob[i2 -> i1 (wrap)] then d1 reversed, J, d0
    seg_left_x = np.r_[bx[i2:], bx[:i1 + 1]]
    seg_left_y = np.r_[by[i2:], by[:i1 + 1]]
    rBx = np.r_[seg_left_x, d1[::-1, 0], J[0], d0[:, 0]]
    rBy = np.r_[seg_left_y, d1[::-1, 1], J[1], d0[:, 1]]

    # Region C (green, upper-right): blob[i1 -> i0] then d2 reversed, J, d1
    seg_right_x = bx[i1:i0 + 1]
    seg_right_y = by[i1:i0 + 1]
    rCx = np.r_[seg_right_x, d2[::-1, 0], J[0], d1[:, 0]]
    rCy = np.r_[seg_right_y, d2[::-1, 1], J[1], d1[:, 1]]

    # -- fill regions ---------------------------------------------------- #
    ax1.fill(rAx, rAy, color=LBLU, zorder=1)
    ax1.fill(rBx, rBy, color=LORG, zorder=1)
    ax1.fill(rCx, rCy, color=LGRN, zorder=1)

    # -- blob outline + dividing curves ---------------------------------- #
    ax1.plot(bx, by, color=AXC, lw=1.5, zorder=3)
    for d in (d0, d1, d2):
        ax1.plot(d[:, 0], d[:, 1], color=AXC, lw=1.0, zorder=3)

    # -- element dots ---------------------------------------------------- #
    for dx, dy in [(-1.2, -1.0), (-0.4, -1.3), (0.4, -1.1), (1.1, -0.7)]:
        ax1.plot(dx, dy, "ko", ms=4, zorder=4)
    for dx, dy in [(-1.5, 0.3), (-0.8, 0.9), (-0.2, 1.2), (-1.1, 1.3)]:
        ax1.plot(dx, dy, "ko", ms=4, zorder=4)
    for dx, dy in [(0.6, 0.5), (1.2, 0.9), (1.6, 0.3), (0.9, 1.3)]:
        ax1.plot(dx, dy, "ko", ms=4, zorder=4)

    # -- region labels --------------------------------------------------- #
    ax1.text(-0.3, -1.15, "[a]", fontsize=12, ha="center",
             fontweight="bold", zorder=5)
    ax1.text(-0.9, 0.85, "[b]", fontsize=12, ha="center",
             fontweight="bold", zorder=5)
    ax1.text(1.1, 0.75, "[c]", fontsize=12, ha="center",
             fontweight="bold", zorder=5)

    ax1.text(2.0, 1.8, "S", fontsize=16, fontweight="bold", color=AXC)
    ax1.set_title("partition of S", fontsize=13, fontweight="bold",
                  color=AXC, pad=8)
    ax1.set_xlim(-3, 3)
    ax1.set_ylim(-2.5, 2.5)
    ax1.set_aspect("equal")
    ax1.axis("off")

    # ================================================================== #
    #  RIGHT PANEL  --  quotient set S/R                                  #
    # ================================================================== #
    th = np.linspace(0, 2 * np.pi, 200)
    ax2.plot(1.6 * np.cos(th), 1.3 * np.sin(th),
             color=AXC, lw=1.5, ls="--", zorder=3)

    for px, py, lbl in [(-0.5, 0.65, "[a]"), (0.0, -0.55, "[b]"),
                         (0.65, 0.35, "[c]")]:
        ax2.plot(px, py, "ko", ms=9, zorder=4)
        ax2.text(px + 0.18, py + 0.15, lbl, fontsize=11,
                 fontweight="bold", zorder=5)

    ax2.text(1.3, -1.0, "S/R", fontsize=14, fontweight="bold", color=AXC)
    ax2.set_title("quotient set", fontsize=13, fontweight="bold",
                  color=AXC, pad=8)
    ax2.set_xlim(-2.5, 2.5)
    ax2.set_ylim(-2, 2)
    ax2.set_aspect("equal")
    ax2.axis("off")

    # ================================================================== #
    #  ARROWS  (computed in figure-fraction coordinates)                  #
    # ================================================================== #
    fig.canvas.draw()
    inv = fig.transFigure.inverted()

    def fig_frac(ax, x, y):
        pt = inv.transform(ax.transData.transform((x, y)))
        return float(pt[0]), float(pt[1])

    akw = dict(arrowstyle="-|>", color=GRY, lw=1.5,
               connectionstyle="arc3,rad=-0.25", mutation_scale=18)

    pairs = [
        ((-0.3, -1.15), (-0.5, 0.65)),    # [a] blue  -> dot [a]
        ((-0.9, 0.85),  (0.0, -0.55)),     # [b] orange -> dot [b]
        ((1.1, 0.75),   (0.65, 0.35)),     # [c] green -> dot [c]
    ]
    for (sx, sy), (ex, ey) in pairs:
        p0 = fig_frac(ax1, sx, sy)
        p1 = fig_frac(ax2, ex, ey)
        fig.add_artist(mpatches.FancyArrowPatch(p0, p1, **akw))

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "partition-quotient")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
