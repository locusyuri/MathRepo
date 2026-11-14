"""Geometry of the implicit function theorem (the case n = 1).

Inside the rectangle I x J contained in the open set U, the level set
F(x, y) = 0 meets every vertical line exactly once, hence defines a function
y = f(x) there.  Outside the rectangle the curve hooks back, showing that the
conclusion is only local: on a larger set the vertical-line test can fail.

Output: img/implicit-function.svg
"""

from __future__ import annotations

import os
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import Ellipse, Rectangle

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "implicit-function.svg")

INK = "#1f2933"
GHOST = "#9aa5b1"
SHADE = "#f0f3f6"
HATCH = "#b8c0c9"

X0, Y0 = 3.50, 2.15           # the solution (x^0, y^0)
X_LEFT, X_RIGHT = 1.70, 5.30  # the interval I
Y_LOW, Y_HIGH = 1.35, 2.75    # the interval J
X_GENERIC = 2.70              # a generic point of I


def curve_y(x):
    """The part of F = 0 inside the rectangle: strictly decreasing."""
    d = x - X0
    return Y0 - 0.20 * d - 0.030 * d ** 2 - 0.035 * d ** 3


def bezier(p0, p1, p2, p3, n=140):
    t = np.linspace(0, 1, n)[:, None]
    pts = np.array([p0, p1, p2, p3], dtype=float)
    return ((1 - t) ** 3 * pts[0] + 3 * (1 - t) ** 2 * t * pts[1]
            + 3 * (1 - t) * t ** 2 * pts[2] + t ** 3 * pts[3])


def underbrace(ax, x0, x1, y, tooth=0.16):
    """Horizontal brace with a downward tooth in the middle."""
    mid = 0.5 * (x0 + x1)
    d = 0.08
    ax.plot([x0, x0, x0 + d, mid - d, mid, mid + d, x1 - d, x1, x1],
            [y + 0.10, y, y, y, y - tooth, y, y, y, y + 0.10],
            color=INK, lw=1.0, solid_capstyle="round", zorder=5)


def left_brace(ax, x, y0, y1, tooth=0.18):
    """Vertical brace: both ends hook right, the middle tooth points left."""
    mid = 0.5 * (y0 + y1)
    d = 0.10
    ax.plot([x + 0.10, x, x, x - tooth, x, x, x + 0.10],
            [y1, y1, mid + d, mid, mid - d, y0, y0],
            color=INK, lw=1.0, solid_capstyle="round", zorder=5)


def main():
    fig = plt.figure(figsize=(7.6, 5.4))
    ax = fig.add_axes([0, 0, 1, 1])
    ax.set_xlim(-0.55, 7.15)
    ax.set_ylim(-0.95, 4.55)
    ax.set_aspect("equal")
    ax.axis("off")

    # Coordinate axes.
    ax.annotate("", xy=(7.00, 0), xytext=(0, 0), annotation_clip=False,
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.1,
                                shrinkA=0, shrinkB=0, mutation_scale=12))
    ax.annotate("", xy=(0, 4.40), xytext=(0, 0), annotation_clip=False,
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.1,
                                shrinkA=0, shrinkB=0, mutation_scale=12))
    ax.text(7.05, -0.10, r"$x$", fontsize=13, color=INK, ha="left", va="top")
    ax.text(-0.16, 4.42, r"$y$", fontsize=13, color=INK, ha="right", va="top")
    ax.text(-0.16, -0.13, r"$O$", fontsize=12, color=INK, ha="right",
            va="top")

    # The open set U.
    ax.add_patch(Ellipse((3.60, 2.28), 6.60, 3.90, fill=False,
                         edgecolor=INK, lw=1.1, ls=(0, (6, 4)), zorder=1))
    ax.text(5.35, 3.35, r"$U$", fontsize=14, color=INK)

    # The shaded rectangle I x J.
    ax.add_patch(Rectangle((X_LEFT, Y_LOW), X_RIGHT - X_LEFT,
                           Y_HIGH - Y_LOW, facecolor=SHADE, edgecolor="none",
                           zorder=1))
    ax.add_patch(Rectangle((X_LEFT, Y_LOW), X_RIGHT - X_LEFT,
                           Y_HIGH - Y_LOW, facecolor="none",
                           edgecolor=HATCH, lw=0.0, hatch="....", zorder=2))
    for xx in (X_LEFT, X_RIGHT):
        ax.plot([xx, xx], [Y_LOW, Y_HIGH], color=GHOST, lw=0.9,
                ls=(0, (3, 3)), zorder=3)
    for yy in (Y_LOW, Y_HIGH):
        ax.plot([X_LEFT, X_RIGHT], [yy, yy], color=GHOST, lw=0.9,
                ls=(0, (3, 3)), zorder=3)

    # Guide lines: projections of the rectangle and of the marked points.
    for xx in (X_LEFT, X_GENERIC, X0, X_RIGHT):
        ax.plot([xx, xx], [0, Y_HIGH], color=GHOST, lw=0.9,
                ls=(0, (3, 3)), zorder=2)
    ax.plot([0, X0], [Y0, Y0], color=GHOST, lw=0.9, ls=(0, (3, 3)),
            zorder=2)

    # The level set F(x, y) = 0: a decreasing graph on I x J, hooking back
    # to the right of I so that the vertical-line test fails outside the box.
    x = np.linspace(X_LEFT, X_RIGHT, 300)
    ax.plot(x, curve_y(x), color=INK, lw=1.9, solid_capstyle="round",
            zorder=6)
    hook = bezier((X_RIGHT, curve_y(X_RIGHT)), (6.35, 1.32),
                  (6.15, 0.45), (4.58, 0.70))
    ax.plot(hook[:, 0], hook[:, 1], color=INK, lw=1.9,
            solid_capstyle="round", zorder=6)

    # The known solution and the labels on the curve.
    ax.plot([X0], [Y0], "o", color=INK, ms=6, zorder=7)
    ax.text(X0 + 0.14, Y0 + 0.20, r"$(\mathbf{x}^0, \mathbf{y}^0)$",
            fontsize=12, color=INK, ha="left", va="bottom", zorder=7)
    ax.text(0.14, Y0 + 0.10, r"$\mathbf{y}^0$", fontsize=12, color=INK,
            ha="left", va="bottom", zorder=7,
            bbox=dict(boxstyle="round,pad=0.10", fc="white", ec="none",
                      alpha=0.90))
    ax.text(5.70, 1.78, r"$F(x,y)=0$", fontsize=13, color=INK,
            ha="left", va="center", zorder=7)

    # Braces for I and J, plus the labels on the axes.
    underbrace(ax, X_LEFT, X_RIGHT, -0.42)
    ax.text(0.5 * (X_LEFT + X_RIGHT), -0.74, r"$I$", fontsize=13,
            color=INK, ha="center", va="top")
    left_brace(ax, 1.46, Y_LOW, Y_HIGH)
    ax.text(1.10, 0.5 * (Y_LOW + Y_HIGH), r"$J$", fontsize=13, color=INK,
            ha="center", va="center")
    ax.text(X_GENERIC, -0.22, r"$\mathbf{x}$", fontsize=12, color=INK,
            ha="center", va="top")
    ax.text(X0, -0.22, r"$\mathbf{x}^0$", fontsize=12, color=INK,
            ha="center", va="top")

    fig.savefig(OUT, transparent=True, bbox_inches="tight", pad_inches=0.02)
    print(f"Saved: {OUT}")

    if os.environ.get("PREVIEW"):
        preview = OUT.with_name("implicit-function-preview.png")
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.02)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
