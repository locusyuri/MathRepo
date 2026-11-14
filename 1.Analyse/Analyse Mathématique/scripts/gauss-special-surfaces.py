"""The special oriented closed surfaces used in the proof of Gauß's formula.

Left: the first surface, made of the lower sheet Sigma_1: z = phi_1(x,y), the
upper sheet Sigma_2: z = phi_2(x,y) and the vertical cylindrical wall Sigma_3
erected on the boundary of Delta_1.  Right: the second surface, where the wall
degenerates and the two sheets meet along the boundary curve.

The drawing is a hand-made isometric projection so that every label can be put
exactly where it belongs.

Output: img/gauss-special-surfaces.svg
"""

from __future__ import annotations

import os
from math import cos, pi, sin
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import FancyArrowPatch, Polygon

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "gauss-special-surfaces.svg")

INK = "#1f2933"
GRID = "#8b949e"
FILL_DISC = "#dde3ea"
FILL_CAP = "#f4f7fa"

COS30, SIN30 = cos(pi / 6), sin(pi / 6)

CX, CY = 0.60, 1.30
A, B = 1.05, 0.78
Z_BOT, Z_TOP = 0.42, 1.00


def proj(points):
    """Isometric projection: x to the lower left, y to the lower right."""
    points = np.asarray(points, dtype=float)
    x, y, z = points[..., 0], points[..., 1], points[..., 2]
    return np.stack([(y - x) * COS30, z - (x + y) * SIN30], axis=-1)


def ring(z, n=220):
    t = np.linspace(0, 2 * pi, n)
    return np.column_stack([CX + A * np.cos(t), CY + B * np.sin(t),
                            np.full_like(t, z)])


def phi_lower(x, y):
    return Z_BOT + 0.10 * (1 - ((x - CX) / A) ** 2 - ((y - CY) / B) ** 2)


def phi_upper(x, y):
    return 1.45 - 0.45 * (((x - CX) / A) ** 2 + ((y - CY) / B) ** 2)


def phi_upper_flat(x, y):
    return Z_BOT + 1.00 * (1 - ((x - CX) / A) ** 2 - ((y - CY) / B) ** 2)


def axes(ax):
    ax.set_xlim(-2.15, 2.05)
    ax.set_ylim(-1.95, 1.80)
    ax.set_aspect("equal")
    ax.axis("off")
    origin = proj([[0, 0, 0]])[0]
    for vec, label, off in (((1.85, 0, 0), r"$x$", (-0.06, -0.14)),
                            ((0, 1.90, 0), r"$y$", (0.14, -0.12)),
                            ((0, 0, 1.62), r"$z$", (-0.16, 0.04))):
        tip = proj([vec])[0]
        ax.annotate("", xy=tip, xytext=origin, annotation_clip=False,
                    arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.1,
                                    shrinkA=0, shrinkB=0, mutation_scale=11,
                                    zorder=2),
                    zorder=2)
        ax.text(tip[0] + off[0], tip[1] + off[1], label, fontsize=11,
                color=INK, ha="center", va="center", zorder=13)
    ax.text(origin[0] - 0.10, origin[1] - 0.14, r"$O$", fontsize=11,
            color=INK, ha="right", va="top", zorder=13)


def fill_ring(ax, z, colour, zorder=2):
    pts = proj(ring(z))
    ax.add_patch(Polygon(pts, closed=True, facecolor=colour, edgecolor=INK,
                         lw=1.1, zorder=zorder))


def front_arc(ax, z, lw=1.1, zorder=6):
    t = np.linspace(0, 2 * pi, 480)
    x, y = CX + A * np.cos(t), CY + B * np.sin(t)
    pts = proj(np.column_stack([x, y, np.full_like(t, z)]))
    keep = (x + y) >= (CX + CY) - 0.02
    idx = np.where(keep)[0]
    if len(idx) == 0:
        return
    breaks = np.where(np.diff(idx) != 1)[0] + 1
    for seg in np.split(idx, breaks):
        if len(seg) > 1:
            ax.plot(pts[seg, 0], pts[seg, 1], color=INK, lw=lw, zorder=zorder)


def side_wall(ax):
    t = np.linspace(0, pi, 200)
    xs = CX + A * np.cos(t)
    ys = CY + B * np.sin(t)
    bottom = proj(np.column_stack([xs, ys, np.full_like(t, Z_BOT)]))
    top = proj(np.column_stack([xs, ys, np.full_like(t, Z_TOP)]))
    ax.add_patch(Polygon(np.vstack([bottom, top[::-1]]), closed=True,
                         facecolor=FILL_CAP, edgecolor="none", zorder=3,
                         alpha=0.95))
    for tt in np.linspace(0.05, pi - 0.05, 11):
        x0, y0 = CX + A * cos(tt), CY + B * sin(tt)
        seg = proj([[x0, y0, Z_BOT], [x0, y0, Z_TOP]])
        ax.plot(seg[:, 0], seg[:, 1], color=GRID, lw=0.6, zorder=4)
    front_arc(ax, Z_BOT, lw=1.1, zorder=7)
    front_arc(ax, Z_TOP, lw=1.2, zorder=7)


def cap(ax, phi):
    fill_ring(ax, phi(CX + A, CY), FILL_CAP, zorder=5)
    g = np.linspace(-1, 1, 5)
    for u in g:
        xs = CX + A * u * np.ones_like(g)
        ys = CY + B * g
        pts = proj(np.column_stack([xs, ys, phi(xs, ys)]))
        ax.plot(pts[:, 0], pts[:, 1], color=GRID, lw=0.55, zorder=6)
    for v in g:
        ys = CY + B * v * np.ones_like(g)
        xs = CX + A * g
        pts = proj(np.column_stack([xs, ys, phi(xs, ys)]))
        ax.plot(pts[:, 0], pts[:, 1], color=GRID, lw=0.55, zorder=6)


def arrow(ax, start, end):
    p0, p1 = proj([start])[0], proj([end])[0]
    ax.add_patch(FancyArrowPatch(p0, p1, arrowstyle="-|>", mutation_scale=11,
                                 color=INK, lw=1.4, shrinkA=0, shrinkB=0,
                                 zorder=10))


def first_surface(ax):
    axes(ax)
    fill_ring(ax, 0.0, FILL_DISC, zorder=1)
    side_wall(ax)
    cap(ax, phi_upper)

    arrow(ax, (CX + 0.25, CY + 0.05, 1.32), (CX + 0.40, CY + 0.15, 1.44))
    arrow(ax, (CX - 0.40, CY - 0.22, 0.46), (CX - 0.55, CY - 0.32, 0.30))
    arrow(ax, (CX + A * 0.98, CY + 0.10, 0.72), (CX + A * 1.22, CY + 0.18,
                                                 0.72))

    ax.text(0.62, 1.52, r"$z=\varphi_2(x,y)$", fontsize=11, color=INK,
            ha="center", va="bottom", zorder=13)
    ax.text(-1.70, -0.28, r"$z=\varphi_1(x,y)$", fontsize=11, color=INK,
            ha="center", va="center", zorder=13)
    ax.text(-0.45, -1.72, r"$\Delta_1$", fontsize=11, color=INK, ha="center",
            va="top", zorder=13)
    ax.text(1.02, 0.98, r"$\vec{\Sigma}_2$", fontsize=12, color=INK,
            ha="left", va="center", zorder=13)
    ax.text(1.38, -0.30, r"$\vec{\Sigma}_3$", fontsize=12, color=INK,
            ha="left", va="center", zorder=13)
    ax.text(-1.28, -1.02, r"$\vec{\Sigma}_1$", fontsize=12, color=INK,
            ha="right", va="center", zorder=13)


def second_surface(ax):
    axes(ax)
    fill_ring(ax, 0.0, FILL_DISC, zorder=1)
    cap(ax, phi_upper_flat)
    front_arc(ax, Z_BOT, lw=1.2, zorder=6)

    arrow(ax, (CX + 0.25, CY + 0.05, 1.10), (CX + 0.38, CY + 0.15, 1.22))
    arrow(ax, (CX - 0.40, CY - 0.22, 0.52), (CX - 0.54, CY - 0.32, 0.36))

    ax.text(0.55, 1.34, r"$z=\varphi_2(x,y)$", fontsize=11, color=INK,
            ha="center", va="bottom", zorder=13)
    ax.text(-1.70, -0.28, r"$z=\varphi_1(x,y)$", fontsize=11, color=INK,
            ha="center", va="center", zorder=13)
    ax.text(-0.45, -1.72, r"$\Delta_1$", fontsize=11, color=INK, ha="center",
            va="top", zorder=13)
    ax.text(0.98, 0.92, r"$\vec{\Sigma}_2$", fontsize=12, color=INK,
            ha="left", va="center", zorder=13)
    ax.text(-1.24, -0.98, r"$\vec{\Sigma}_1$", fontsize=12, color=INK,
            ha="right", va="center", zorder=13)


def main():
    fig = plt.figure(figsize=(11.0, 4.8))
    first_surface(fig.add_subplot(1, 2, 1))
    second_surface(fig.add_subplot(1, 2, 2))
    fig.subplots_adjust(left=0.01, right=0.99, top=0.99, bottom=0.01,
                        wspace=0.02)
    fig.savefig(OUT, transparent=True, bbox_inches="tight", pad_inches=0.02)
    print(f"Saved: {OUT}")

    if os.environ.get("PREVIEW"):
        preview = OUT.with_name("gauss-special-surfaces-preview.png")
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.02)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
