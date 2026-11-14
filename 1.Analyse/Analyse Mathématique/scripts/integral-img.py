"""Reduction of a double integral to an iterated integral on a bounded set.

Left: a general region Omega inside [a,b] x [c,d].  Some vertical and
horizontal lines meet it in two pieces, so Omega_x / Omega_y are not always
intervals: the region must first be cut into y-simple pieces.  The two heavy
dashed lines are the cuts, and Omega' is one of the resulting subregions.

Right: the y-simple (X-type) case Omega = {(x,y): a<=x<=b, y_1(x)<=y<=y_2(x)},
where every slice Omega_x is the single interval [y_1(x), y_2(x)].

Output: img/integral-img.svg
"""

from __future__ import annotations

import os
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.path import Path as MPath
from matplotlib.patches import PathPatch

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "integral-img.svg")

INK = "#1f2933"
GRID = "#b3bcc6"
SHADE = "#e8edf2"
HATCH = "#9aa5b1"
CUT = "#3f4a56"

A, B, C, D = 0.85, 4.85, 0.75, 3.55


def draw_axes(ax):
    ax.set_xlim(-0.65, 5.55)
    ax.set_ylim(-0.95, 4.35)
    ax.set_aspect("equal")
    ax.axis("off")
    ax.annotate("", xy=(5.40, 0), xytext=(0, 0), annotation_clip=False,
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.1,
                                shrinkA=0, shrinkB=0, mutation_scale=11))
    ax.annotate("", xy=(0, 4.20), xytext=(0, 0), annotation_clip=False,
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.1,
                                shrinkA=0, shrinkB=0, mutation_scale=11))
    ax.text(5.45, -0.10, r"$x$", fontsize=12, color=INK, ha="left", va="top")
    ax.text(-0.14, 4.22, r"$y$", fontsize=12, color=INK, ha="right", va="top")
    ax.text(-0.14, -0.12, r"$O$", fontsize=11, color=INK, ha="right",
            va="top")


def dashed(ax, xs, ys, colour=GRID, lw=0.8, ls=(0, (4, 3)), zorder=1):
    ax.plot(xs, ys, color=colour, lw=lw, ls=ls, zorder=zorder)


def underbrace(ax, x0, x1, y, tooth=0.16):
    mid = 0.5 * (x0 + x1)
    d = 0.08
    ax.plot([x0, x0, x0 + d, mid - d, mid, mid + d, x1 - d, x1, x1],
            [y + 0.10, y, y, y, y - tooth, y, y, y, y + 0.10],
            color=INK, lw=1.0, solid_capstyle="round", zorder=6)


def left_brace(ax, x, y0, y1, tooth=0.16):
    """Both ends hook right, the middle tooth points left (towards the axis)."""
    mid = 0.5 * (y0 + y1)
    d = 0.10
    ax.plot([x + 0.10, x, x, x - tooth, x, x, x + 0.10],
            [y1, y1, mid + d, mid, mid - d, y0, y0],
            color=INK, lw=1.0, solid_capstyle="round", zorder=6)


def omega_path():
    """The irregular region: a bulge on top and a forked tail on the right."""
    verts = [
        (1.20, 2.00),
        (1.35, 2.62), (1.85, 2.95), (2.35, 2.85),
        (2.80, 2.77), (3.00, 2.62), (3.15, 2.50),
        (3.40, 2.38), (3.62, 2.38), (3.78, 2.47),
        (3.88, 2.51), (3.93, 2.54), (3.95, 2.58),
        (3.95, 1.42),
        (3.92, 1.45), (3.85, 1.50), (3.74, 1.56),
        (3.55, 1.63), (3.35, 1.60), (3.18, 1.47),
        (2.95, 1.30), (2.75, 1.12), (2.45, 1.06),
        (2.10, 1.02), (1.70, 1.30), (1.20, 2.00),
        (1.20, 2.00),
    ]
    codes = [
        MPath.MOVETO,
        MPath.CURVE4, MPath.CURVE4, MPath.CURVE4,
        MPath.CURVE4, MPath.CURVE4, MPath.CURVE4,
        MPath.CURVE4, MPath.CURVE4, MPath.CURVE4,
        MPath.CURVE4, MPath.CURVE4, MPath.CURVE4,
        MPath.LINETO,
        MPath.CURVE4, MPath.CURVE4, MPath.CURVE4,
        MPath.CURVE4, MPath.CURVE4, MPath.CURVE4,
        MPath.CURVE4, MPath.CURVE4, MPath.CURVE4,
        MPath.CURVE4, MPath.CURVE4, MPath.CURVE4,
        MPath.CLOSEPOLY,
    ]
    return MPath(verts, codes)


def left_panel(fig):
    ax = fig.add_subplot(1, 2, 1)
    draw_axes(ax)

    # Bounding rectangle [a,b] x [c,d] and the slice grid.
    for xx in (A, 1.85, 2.85, 3.85, B):
        dashed(ax, [xx, xx], [C, D], zorder=4)
    for yy in (C, 1.60, 2.25, D):
        dashed(ax, [A, B], [yy, yy], zorder=4)

    # The region Omega (shaded with a fine dot hatch).
    ax.add_patch(PathPatch(omega_path(), facecolor=SHADE, edgecolor=INK,
                           lw=1.6, zorder=2))
    ax.add_patch(PathPatch(omega_path(), facecolor="none", edgecolor=HATCH,
                           lw=0.0, hatch="....", zorder=3))

    # Heavy cuts: Omega must be split before every slice is an interval.
    dashed(ax, [1.42, 3.05], [2.52, 2.52], colour=CUT, lw=1.6,
           ls=(0, (6, 3)), zorder=6)
    dashed(ax, [3.40, 3.40], [1.02, 2.85], colour=CUT, lw=1.6,
           ls=(0, (6, 3)), zorder=6)

    # A horizontal line and a vertical line used for the slices.
    dashed(ax, [0, 3.90], [2.00, 2.00], colour="#8b949e", lw=0.9, zorder=5)
    dashed(ax, [2.30, 2.30], [0, D], colour="#8b949e", lw=0.9, zorder=5)

    # Braces: projection I of Omega onto x, projection J onto y.
    underbrace(ax, 1.20, 3.95, -0.48)
    left_brace(ax, 1.00, 1.02, 2.85)
    ax.text(2.57, -0.80, r"$I$", fontsize=12, color=INK, ha="center",
            va="top")
    ax.text(0.72, 1.94, r"$J$", fontsize=12, color=INK, ha="center",
            va="center")
    ax.text(0.10, 2.10, r"$y$", fontsize=11, color=INK, ha="left",
            va="bottom")
    ax.text(2.30, -0.22, r"$x$", fontsize=11, color=INK, ha="center",
            va="top")

    # Axis ticks and region labels.
    for xx, lab in ((A, "a"), (B, "b")):
        ax.text(xx, -0.22, rf"${lab}$", fontsize=11, color=INK, ha="center",
                va="top")
    for yy, lab in ((C, "c"), (D, "d")):
        ax.text(-0.18, yy, rf"${lab}$", fontsize=11, color=INK, ha="right",
                va="center")
    ax.text(2.18, 2.72, r"$\Omega'$", fontsize=12, color=INK, ha="center",
            va="center", zorder=7)
    ax.text(2.35, 2.18, r"$\Omega$", fontsize=12, color=INK, ha="center",
            va="center", zorder=7)
    ax.text(2.30, 1.48, r"$\Omega_x$", fontsize=12, color=INK, ha="center",
            va="center", zorder=7,
            bbox=dict(boxstyle="round,pad=0.10", fc="white", ec="none",
                      alpha=0.85))


def y_lower(x):
    return 1.18 + 0.26 * np.sin(1.65 * (x - A)) + 0.08 * np.sin(3.0 * (x - A))


def y_upper(x):
    return 2.95 + 0.20 * np.cos(1.45 * (x - A)) + 0.07 * np.sin(2.5 * (x - A))


def right_panel(fig):
    ax = fig.add_subplot(1, 2, 2)
    draw_axes(ax)

    dashed(ax, [A, A], [C, D], zorder=4)
    dashed(ax, [B, B], [C, D], zorder=4)
    dashed(ax, [A, B], [C, C], zorder=4)
    dashed(ax, [A, B], [D, D], zorder=4)

    x = np.linspace(A, B, 300)
    lo, hi = y_lower(x), y_upper(x)
    ax.fill_between(x, lo, hi, facecolor=SHADE, edgecolor=HATCH,
                    hatch="....", linewidth=0.0, zorder=2)
    ax.plot(x, lo, color=INK, lw=1.7, zorder=4)
    ax.plot(x, hi, color=INK, lw=1.7, zorder=4)
    ax.plot([A, A], [lo[0], hi[0]], color=INK, lw=1.7, zorder=4)
    ax.plot([B, B], [lo[-1], hi[-1]], color=INK, lw=1.7, zorder=4)

    # A vertical slice with its label Omega_x.
    xs = 2.30
    dashed(ax, [xs, xs], [0, D], colour="#8b949e", lw=0.9, zorder=5)
    ax.text(xs + 0.10, 2.05, r"$\Omega_x$", fontsize=12, color=INK,
            ha="left", va="center", zorder=6)
    ax.text(xs, -0.22, r"$x$", fontsize=11, color=INK, ha="center", va="top")

    for xx, lab in ((A, "a"), (B, "b")):
        ax.text(xx, -0.22, rf"${lab}$", fontsize=11, color=INK, ha="center",
                va="top")
    for yy, lab in ((C, "c"), (D, "d")):
        ax.text(-0.18, yy, rf"${lab}$", fontsize=11, color=INK, ha="right",
                va="center")
    ax.text(3.55, 3.30, r"$y=y_2(x)$", fontsize=12, color=INK, ha="center",
            va="bottom")
    ax.text(3.30, 0.94, r"$y=y_1(x)$", fontsize=11, color=INK, ha="center",
            va="top")
    ax.text(3.55, 2.55, r"$\Omega$", fontsize=13, color=INK, ha="center",
            va="center")


def main():
    fig = plt.figure(figsize=(11.6, 4.6))
    left_panel(fig)
    right_panel(fig)
    fig.subplots_adjust(left=0.01, right=0.99, top=0.99, bottom=0.02,
                        wspace=0.06)
    fig.savefig(OUT, transparent=True, bbox_inches="tight", pad_inches=0.02)
    print(f"Saved: {OUT}")

    if os.environ.get("PREVIEW"):
        preview = OUT.with_name("integral-img-preview.png")
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.02)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
