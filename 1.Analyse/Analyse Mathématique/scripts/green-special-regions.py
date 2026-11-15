"""The two special oriented regions used in the proof of Green's formula.

The left region is y-simple: its boundary consists of the lower graph
y = phi_1(x), the vertical side x = b, the upper graph y = phi_2(x) and the
vertical side x = a.  This is exactly what allows the iterated integral
int_a^b ( ... ) dx.  The right region is x-simple, so its horizontal sides
y = c and y = d are straight and the two remaining sides are graphs
x = psi_1(y), x = psi_2(y).  Both boundaries are traversed counter-clockwise.

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

# y-simple region: a <= x <= b, phi_1(x) <= y <= phi_2(x)
A, B, XC, HALF = 0.95, 4.15, 2.55, 1.60
# x-simple region: c <= y <= d, psi_1(y) <= x <= psi_2(y)
C, D, YC, HALF_Y = 0.85, 3.65, 2.25, 1.40

X_MAX, Y_MAX = 5.30, 4.15


def phi_lower(x):
    return 1.15 + 0.55 * ((np.asarray(x) - XC) / HALF) ** 2


def phi_upper(x):
    return 2.95 - 0.55 * ((np.asarray(x) - XC) / HALF) ** 2


def psi_left(y):
    return 1.05 + 0.55 * ((np.asarray(y) - YC) / HALF_Y) ** 2


def psi_right(y):
    return 4.05 - 0.55 * ((np.asarray(y) - YC) / HALF_Y) ** 2


def left_segments(n=240):
    xs = np.linspace(A, B, n)
    bottom = np.column_stack([xs, phi_lower(xs)])
    ys = np.linspace(phi_lower(B), phi_upper(B), 80)
    right = np.column_stack([np.full_like(ys, B), ys])
    top = np.column_stack([xs[::-1], phi_upper(xs)[::-1]])
    ys = np.linspace(phi_upper(A), phi_lower(A), 80)
    left = np.column_stack([np.full_like(ys, A), ys])
    return [bottom, right, top, left]


def right_segments(n=240):
    ys = np.linspace(C, D, n)
    xs = np.linspace(psi_left(C), psi_right(C), 80)
    bottom = np.column_stack([xs, np.full_like(xs, C)])
    right = np.column_stack([psi_right(ys), ys])
    xs = np.linspace(psi_right(D), psi_left(D), 80)
    top = np.column_stack([xs, np.full_like(xs, D)])
    left = np.column_stack([psi_left(ys)[::-1], ys[::-1]])
    return [bottom, right, top, left]


def draw_axes(ax):
    ax.set_xlim(-0.55, 5.75)
    ax.set_ylim(-0.65, 4.40)
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


def region(ax, segments):
    loop = np.vstack(segments)
    ax.add_patch(Polygon(loop, closed=True, facecolor=FILL, edgecolor=INK,
                         lw=1.6, joinstyle="round", zorder=2))
    ax.add_patch(Polygon(loop, closed=True, facecolor="none", edgecolor=DOTS,
                         lw=0.0, hatch="...", zorder=3))


def arrow_on(ax, pts, label, offset=(0.0, 0.0)):
    i = len(pts) // 2
    a = pts[max(i - 2, 0)]
    b = pts[min(i + 2, len(pts) - 1)]
    ax.add_patch(FancyArrowPatch(
        tuple(a), tuple(b), arrowstyle="-|>", mutation_scale=13, color=INK,
        lw=1.6, shrinkA=0, shrinkB=0, zorder=6))
    mid = pts[i]
    ax.text(mid[0] + offset[0], mid[1] + offset[1], label, fontsize=12,
            color=INK, ha="center", va="center", zorder=7)


def centre_mark(ax, centre):
    ax.plot([centre[0]], [centre[1]], "o", color=INK, ms=3.5, zorder=7)
    ax.text(centre[0], centre[1] + 0.22, r"$M$", fontsize=12, color=INK,
            ha="center", va="bottom", zorder=7)
    theta = np.radians(np.linspace(-75, 195, 120))
    ax.plot(centre[0] + 0.42 * np.cos(theta),
            centre[1] + 0.38 * np.sin(theta), color=INK, lw=1.3, zorder=6)
    ax.add_patch(FancyArrowPatch(
        (centre[0] + 0.42 * np.cos(theta[-6]),
         centre[1] + 0.38 * np.sin(theta[-6])),
        (centre[0] + 0.42 * np.cos(theta[-1]),
         centre[1] + 0.38 * np.sin(theta[-1])),
        arrowstyle="-|>", mutation_scale=14, color=INK, lw=1.3, zorder=7))


def left_panel(ax):
    draw_axes(ax)
    segments = left_segments()
    region(ax, segments)

    # Vertical sides are exactly the segments x = a and x = b.
    for xx in (A, B):
        ax.plot([xx, xx], [0, float(phi_lower(xx))], color=GHOST, lw=0.9,
                ls=(0, (4, 3)), zorder=1)

    offset_c1, offset_c2, offset_c3, offset_c4 = (-0.75, -0.26), (0.30, 0.0), \
        (-0.60, 0.26), (-0.30, 0.0)
    for pts, label, off in zip(segments,
                               (r"$\vec{C}_1$", r"$\vec{C}_2$", r"$\vec{C}_3$",
                                r"$\vec{C}_4$"),
                               (offset_c1, offset_c2, offset_c3, offset_c4)):
        arrow_on(ax, pts, label, off)

    centre_mark(ax, (XC, 2.05))

    ax.text(XC + 0.10, float(phi_lower(XC)) - 0.16,
            r"$y=\varphi_1(x)$", fontsize=12, color=INK, ha="left", va="top")
    ax.text(XC + 0.10, float(phi_upper(XC)) + 0.16,
            r"$y=\varphi_2(x)$", fontsize=12, color=INK, ha="left",
            va="bottom")
    ax.text(A, -0.22, r"$a$", fontsize=12, color=INK, ha="center", va="top")
    ax.text(B, -0.22, r"$b$", fontsize=12, color=INK, ha="center", va="top")


def right_panel(ax):
    draw_axes(ax)
    segments = right_segments()
    region(ax, segments)

    for yy in (C, D):
        ax.plot([0, float(psi_left(yy))], [yy, yy], color=GHOST, lw=0.9,
                ls=(0, (4, 3)), zorder=1)

    for pts, label, off in zip(segments,
                               (r"$\vec{C}_1$", r"$\vec{C}_2$", r"$\vec{C}_3$",
                                r"$\vec{C}_4$"),
                               ((-0.55, -0.28), (0.30, 0.0), (-0.55, 0.28),
                                (-0.30, 0.0))):
        arrow_on(ax, pts, label, off)

    centre_mark(ax, (XC, YC))

    ax.text(0.92, 1.00, r"$x=\psi_1(y)$", fontsize=11, color=INK,
            ha="right", va="center")
    ax.text(4.14, 3.30, r"$x=\psi_2(y)$", fontsize=11, color=INK,
            ha="left", va="center")
    ax.text(-0.16, C, r"$c$", fontsize=12, color=INK, ha="right", va="center")
    ax.text(-0.16, D, r"$d$", fontsize=12, color=INK, ha="right", va="center")


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
