"""The permutahedron: convex hull of the permutation orbit of a vector in R^3.

For alpha = (3, 2, 1) the six rearrangements are the vertices of a regular
hexagon lying in the plane x + y + z = 6.  The figure is drawn in isometric
projection, without the clutter of a 3D axis box: the three coordinate axes,
a patch of the plane and the hexagon itself.

Output: ../img/convex-hull.svg
"""

from __future__ import annotations

import os
import sys
from dataclasses import replace
from itertools import permutations
from math import cos, pi, sin
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import Polygon

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(6.2, 6.2))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1f2933"
AXIS = "#8b949e"
GHOST = "#c3cbd4"
BLUE = "#1f4e9b"
FILL = "#e3ecf7"
DOT = "#c0392b"

ALPHA = (3, 2, 1)
COS30, SIN30 = cos(pi / 6), sin(pi / 6)


def project(point):
    """Isometric projection of R^3 onto the drawing plane."""
    x, y, z = point
    return (x - y) * COS30, z - (x + y) * SIN30


def main():
    verts = np.array(sorted(set(permutations(ALPHA))), dtype=float)
    centre = verts.mean(axis=0)

    # Orthonormal basis of the plane x + y + z = const.
    u = np.array([1.0, -1.0, 0.0]) / np.sqrt(2)
    v = np.array([1.0, 1.0, -2.0]) / np.sqrt(6)
    order = sorted(verts, key=lambda p: np.arctan2((p - centre) @ v,
                                                   (p - centre) @ u))

    fig = SPEC.figure()
    ax = fig.add_subplot(111)
    ax.set_aspect("equal")
    ax.axis("off")

    # Patch of the plane containing the hexagon.
    span = 1.45
    corners = [project(centre + span * (su * u + sv * v))
               for su, sv in ((1, 1), (-1, 1), (-1, -1), (1, -1))]
    ax.add_patch(Polygon(corners, closed=True, facecolor=FILL,
                         edgecolor="none", zorder=1))
    ax.add_patch(Polygon(corners, closed=True, facecolor="none",
                         edgecolor=GHOST, lw=0.8, ls=(0, (3, 3)), zorder=2))
    ax.text(2.35, 4.35, r"plane $x + y + z = 6$", ha="left", va="center",
            fontsize=9, color="#7b8794")

    # Coordinate axes.
    for end, label, offset, align in (
        ((4.35, 0, 0), r"$x$", (0.10, -0.22), "left"),
        ((0, 4.35, 0), r"$y$", (-0.10, -0.22), "right"),
        ((0, 0, 4.55), r"$z$", (-0.14, 0.10), "right"),
    ):
        tail = project((0, 0, 0))
        head = project(end)
        ax.annotate("", xy=head, xytext=tail,
                    arrowprops=dict(arrowstyle="-|>", color=AXIS, lw=1.0,
                                    shrinkA=0, shrinkB=0, mutation_scale=11))
        ax.text(head[0] + offset[0], head[1] + offset[1], label, ha=align,
                va="center", fontsize=11, color=INK)
    ax.text(*project((0, 0, 0)), " ", fontsize=1)

    # The hexagon.
    hexagon = [project(p) for p in order]
    ax.add_patch(Polygon(hexagon, closed=True, facecolor="none",
                         edgecolor=BLUE, lw=1.7, joinstyle="round", zorder=4))

    # Vertices, with the rearrangements written next to them.
    for p in verts:
        sx, sy = project(p)
        ax.plot([sx], [sy], "o", color=DOT, ms=5.0, zorder=5)
        out = p - centre
        out = out / np.linalg.norm(out)
        lx, ly = project(p + 0.42 * out)
        ax.text(lx, ly, "(%d,%d,%d)" % tuple(int(t) for t in p), ha="center",
                va="center", fontsize=8.5, color=INK, zorder=6,
                bbox=dict(boxstyle="round,pad=0.12", fc="white", ec="none",
                          alpha=0.85))

    ax.set_xlim(-4.6, 4.4)
    ax.set_ylim(-4.5, 5.0)

    path = SPEC.save(fig, OUT_DIR / "convex-hull")
    print(f"Saved: {path}")

    if os.environ.get("PREVIEW"):
        preview = OUT_DIR / "convex-hull-preview.png"
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.05)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
