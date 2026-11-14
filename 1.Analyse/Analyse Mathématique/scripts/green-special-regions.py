"""The two special oriented regions used in the proof of Green's formula.

Left: the region seen as y-simple, bounded by C_1 (y = phi_1(x)) and
C_3 (y = phi_2(x)), with C_2, C_4 the vertical sides (possibly reduced to a
point).  Right: the same region seen as x-simple, bounded by x = psi_1(y) and
x = psi_2(y).  Both boundaries are traversed counter-clockwise.

Output: img/green-special-regions.svg
"""

from __future__ import annotations

import os
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import FancyArrowPatch, Polygon

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "green-special-regions.svg")

INK = "#1f2933"
GHOST = "#9aa5b1"
FILL = "#dfe6ee"
DOTS = "#b3bcc6"

XC, YC, AX, BY = 2.55, 2.00, 1.80, 1.35
X_MAX, Y_MAX = 5.30, 3.95


def point(t):
    """One point of the convex egg-shaped outline."""
    return (float(XC + AX * np.cos(t)),
            float(YC + BY * np.sin(t) * (1 + 0.05 * np.cos(t))))


def outline(t):
    return (XC + AX * np.cos(t),
            YC + BY * np.sin(t) * (1 + 0.05 * np.cos(t)))


def draw_axes(ax):
    ax.set_xlim(-0.55, 5.75)
    ax.set_ylim(-0.60, 4.35)
    ax.set_aspect("equal")
    ax.axis("off")
    ax.annotate("", xy=(X_MAX, 0), xytext=(0, 0), annotation_clip=False,
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.1,
                                shrinkA=0, shrinkB=0, mutation_scale=11))
    ax.annotate("", xy=(0, Y_MAX), xytext=(0, 0), annotation_clip=False,
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.1,
                                shrinkA=0, shrinkB=0, mutation_scale=11))
    ax.text(X_MAX + 0.06, -0.10, r"$x$", fontsize=12, color=INK, ha="left",
            va="top")
    ax.text(-0.14, Y_MAX + 0.04, r"$y$", fontsize=12, color=INK, ha="right",
            va="top")
    ax.text(-0.14, -0.12, r"$O$", fontsize=11, color=INK, ha="right",
            va="top")


def region(ax):
    t = np.linspace(0, 2 * np.pi, 500)
    x, y = outline(t)
    ax.add_patch(Polygon(np.column_stack([x, y]), closed=True,
                         facecolor=FILL, edgecolor=INK, lw=1.6, zorder=2))
    ax.add_patch(Polygon(np.column_stack([x, y]), closed=True,
                         facecolor="none", edgecolor=DOTS, lw=0.0,
                         hatch="...", zorder=3))


def arrow_on_arc(ax, t0, t1, label, offset=(0.0, 0.0)):
    tm = 0.5 * (t0 + t1)
    x0, y0 = point(tm - 0.07)
    x1, y1 = point(tm + 0.07)
    ax.add_patch(FancyArrowPatch(
        (x0, y0), (x1, y1), arrowstyle="-|>", mutation_scale=13, color=INK,
        lw=1.6, shrinkA=0, shrinkB=0, zorder=6))
    lx, ly = point(tm)
    ax.text(lx + offset[0], ly + offset[1], label, fontsize=12, color=INK,
            ha="center", va="center", zorder=7)


def centre_mark(ax):
    """The point M with a small circulation arrow around it."""
    ax.plot([XC], [YC], "o", color=INK, ms=3.5, zorder=7)
    ax.text(XC, YC + 0.22, r"$M$", fontsize=12, color=INK, ha="center",
            va="bottom", zorder=7)
    theta = np.radians(np.linspace(-75, 195, 120))
    ax.plot(XC + 0.42 * np.cos(theta), YC + 0.38 * np.sin(theta), color=INK,
            lw=1.3, zorder=6)
    ax.add_patch(FancyArrowPatch(
        (XC + 0.42 * np.cos(theta[-6]), YC + 0.38 * np.sin(theta[-6])),
        (XC + 0.42 * np.cos(theta[-1]), YC + 0.38 * np.sin(theta[-1])),
        arrowstyle="-|>", mutation_scale=14, color=INK, lw=1.3, zorder=7))


def boundary_labels(ax):
    arrow_on_arc(ax, np.pi, 2 * np.pi, r"$\vec{C}_1$", (-0.55, -0.32))
    arrow_on_arc(ax, 0.0, np.pi / 2, r"$\vec{C}_2$", (0.34, 0.06))
    arrow_on_arc(ax, np.pi / 2, np.pi, r"$\vec{C}_3$", (0.0, 0.32))
    ax.text(XC - AX - 0.28, YC, r"$\vec{C}_4$", fontsize=12, color=INK,
            ha="right", va="center")


def left_panel(ax):
    draw_axes(ax)
    region(ax)

    x, y = outline(np.linspace(0, 2 * np.pi, 500))
    a, b = x.min(), x.max()
    y_low, y_high = y.min(), y.max()

    for xx in (a, b):
        ax.plot([xx, xx], [0, YC], color=GHOST, lw=0.9, ls=(0, (4, 3)),
                zorder=1)

    boundary_labels(ax)
    centre_mark(ax)

    ax.text(XC + 0.25, y_high + 0.14, r"$y=\varphi_2(x)$", fontsize=12,
            color=INK, ha="center", va="bottom")
    ax.text(XC + 0.55, y_low - 0.16, r"$y=\varphi_1(x)$", fontsize=12,
            color=INK, ha="center", va="top")
    ax.text(a, -0.22, r"$a$", fontsize=12, color=INK, ha="center", va="top")
    ax.text(b, -0.22, r"$b$", fontsize=12, color=INK, ha="center", va="top")


def right_panel(ax):
    draw_axes(ax)
    region(ax)

    x, y = outline(np.linspace(0, 2 * np.pi, 500))
    c, d = y.min(), y.max()
    x_left, x_right = x.min(), x.max()

    for yy in (c, d):
        ax.plot([0, XC], [yy, yy], color=GHOST, lw=0.9, ls=(0, (4, 3)),
                zorder=1)

    boundary_labels(ax)
    centre_mark(ax)

    ax.text(x_right + 0.14, YC + 0.55, r"$x=\psi_2(y)$", fontsize=12,
            color=INK, ha="left", va="center")
    ax.text(x_left - 0.16, YC - 0.40, r"$x=\psi_1(y)$", fontsize=11,
            color=INK, ha="right", va="center")
    ax.text(-0.16, c, r"$c$", fontsize=12, color=INK, ha="right", va="center")
    ax.text(-0.16, d, r"$d$", fontsize=12, color=INK, ha="right", va="center")


def main():
    fig = plt.figure(figsize=(11.2, 4.6))
    left_panel(fig.add_subplot(1, 2, 1))
    right_panel(fig.add_subplot(1, 2, 2))
    fig.subplots_adjust(left=0.01, right=0.99, top=0.99, bottom=0.01,
                        wspace=0.02)
    fig.savefig(OUT, transparent=True, bbox_inches="tight", pad_inches=0.02)
    print(f"Saved: {OUT}")

    if os.environ.get("PREVIEW"):
        preview = OUT.with_name("green-special-regions-preview.png")
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.02)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
