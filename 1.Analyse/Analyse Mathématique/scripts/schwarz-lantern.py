"""Construction of Schwarz's lantern on a cylinder of height 1 and radius 1/2.

Left: the smooth cylinder with its lateral area pi.  Middle: four equally
spaced circles carrying seven red dots each.  Right: the inscribed polyhedral
surface obtained by joining the dots, whose area does not tend to pi.

Output: img/schwarz-lantern.svg
"""

from __future__ import annotations

import os
import sys
from math import cos, pi, sin
from pathlib import Path

import matplotlib.pyplot as plt

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _lantern import (INK, cylinder_faces, dots, finished, paint, project,
                      ring, smooth_cylinder)

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "schwarz-lantern.svg")

BANDS, POINTS = 4, 7
HEIGHT, RADIUS = 1.0, 0.5


def label_height(ax):
    """Vertical dimension line on the left, marked 1."""
    x = -RADIUS - 0.06
    for seg in ([(x, 0.0, 0.0), (x, 0.0, HEIGHT)],
                [(-RADIUS, 0.0, 0.0), (x, 0.0, 0.0)],
                [(-RADIUS, 0.0, HEIGHT), (x, 0.0, HEIGHT)]):
        pts = project(seg)
        ax.plot(pts[:, 0], pts[:, 1], color=INK, lw=1.4, zorder=8)
    pts = project([(x - 0.10, 0.0, HEIGHT / 2)])
    ax.text(pts[0, 0], pts[0, 1], "1", fontsize=12, color=INK, ha="right",
            va="center", zorder=9)


def label_radius(ax):
    """Radius of the top disc, marked 1."""
    pts = project([[0.0, 0.0, HEIGHT], [RADIUS, 0.0, HEIGHT]])
    ax.plot(pts[:, 0], pts[:, 1], color=INK, lw=1.6, zorder=8)
    mid = pts.mean(axis=0)
    ax.text(mid[0], mid[1] + 0.07, "1", fontsize=12, color=INK, ha="center",
            va="bottom", zorder=9)


def main():
    fig = plt.figure(figsize=(10.2, 3.6))
    axes = [fig.add_subplot(1, 3, i + 1) for i in range(3)]
    for ax in axes:
        finished(ax)

    # Left: the smooth cylinder plus its two dimensions.
    paint(axes[0], smooth_cylinder(n=160), linewidth=0.0)
    label_radius(axes[0])
    label_height(axes[0])

    # Middle: four bands, seven dots per circle.
    paint(axes[1], smooth_cylinder(n=160), linewidth=0.0)
    markers = []
    for i in range(BANDS + 1):
        z = HEIGHT * i / BANDS
        ring(axes[1], z, radius=RADIUS, lw=1.0, full=(i == BANDS))
        for j in range(POINTS):
            angle = 2 * pi * j / POINTS
            markers.append([RADIUS * cos(angle), RADIUS * sin(angle), z])
    dots(axes[1], markers, top_z=HEIGHT)

    # Right: the inscribed polyhedral surface.
    faces = cylinder_faces(BANDS, POINTS, radius=RADIUS, height=HEIGHT)
    paint(axes[2], faces, linewidth=0.55)
    vertices = [v for face, kind in faces if kind == "side" for v in face]
    dots(axes[2], vertices, size=4.2)

    fig.subplots_adjust(left=0.01, right=0.99, top=0.99, bottom=0.01,
                        wspace=0.02)
    fig.savefig(OUT, transparent=True, bbox_inches="tight", pad_inches=0.02)
    print(f"Saved: {OUT}")

    if os.environ.get("PREVIEW"):
        preview = OUT.with_name("schwarz-lantern-preview.png")
        fig.savefig(preview, dpi=150, facecolor="white", bbox_inches="tight",
                    pad_inches=0.02)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
