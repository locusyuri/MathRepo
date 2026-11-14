"""The permutahedron inside the standard simplex, after the classical picture.

The three coordinate axes x1, x2, x3 are drawn from the origin O; the segment
joining their unit points bounds a triangle, and the permutahedron H(beta) of a
vector cuts the hexagon inside it.  A point alpha lying in H(beta) is marked, as
is another point y of the same plane, outside the hexagon.

Output: ../img/convex-hull.svg
"""

from __future__ import annotations

import os
import sys
from dataclasses import replace
from itertools import permutations
from math import atan2, cos, pi, sin
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import Polygon

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(6.0, 5.6))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1f2933"
HULL = "#1f4e9b"
DOT = "#1f2933"

COS30, SIN30 = cos(pi / 6), sin(pi / 6)
Z_WEIGHT, XY_WEIGHT = 0.85, 0.26   # vertical foreshortening of the projection

AXIS_LEN = 4.4
ALPHA = (3, 2, 1)                  # the vector whose permutahedron is drawn
ALPHA_POINT = (2.0, 2.2, 1.8)      # alpha, inside H(beta)
Y_POINT = (2.4, 0.6, 3.0)          # y = (beta_1, beta_2, beta_3), outside


def project(point):
    """Oblique projection of R^3: x grows to the right, z upwards."""
    x, y, z = point
    return ((x - y) * COS30, Z_WEIGHT * z - XY_WEIGHT * (x + y))


def main():
    verts = [p for p in sorted(set(permutations(ALPHA)))]

    fig = SPEC.figure()
    ax = fig.add_subplot(111)
    ax.set_aspect("equal")
    ax.axis("off")

    origin = project((0, 0, 0))
    tips = [project((AXIS_LEN, 0, 0)), project((0, AXIS_LEN, 0)),
            project((0, 0, AXIS_LEN))]

    # Bounding triangle of the simplex.
    ax.add_patch(Polygon(tips, closed=True, facecolor="none", edgecolor=INK,
                         lw=1.2, joinstyle="round", zorder=2))

    # Coordinate axes, from O outwards.
    for tip in tips:
        ax.plot([origin[0], tip[0]], [origin[1], tip[1]], color=INK, lw=1.0,
                zorder=3)

    # The permutahedron: image of the six rearrangements of alpha.
    centre = tuple(sum(v[i] for v in verts) / len(verts) for i in range(3))
    order = sorted(verts, key=lambda p: atan2(
        project(p)[1] - project(centre)[1], project(p)[0] - project(centre)[0]))
    hexagon = [project(p) for p in order]
    ax.add_patch(Polygon(hexagon, closed=True, facecolor="none",
                         edgecolor=INK, lw=1.4, joinstyle="round", zorder=5))
    for sx, sy in hexagon:
        ax.plot([sx], [sy], "o", color=INK, ms=4.0, zorder=6)

    # Marked points.
    ax.plot(*project((0, 0, 0)), "o", color=DOT, ms=3.0, zorder=7)
    ax.text(origin[0] - 0.14, origin[1] + 0.02, r"$O$", fontsize=12, color=INK,
            ha="right", va="center", zorder=7)

    px, py = project(ALPHA_POINT)
    ax.plot([px], [py], "o", color=INK, ms=4.5, zorder=7)
    ax.annotate(r"$\alpha \in H(\beta)$", xy=(px, py), xytext=(-2.95, 2.25),
                fontsize=11, color=INK, ha="left", va="center",
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=0.9,
                                shrinkA=2, shrinkB=1, mutation_scale=11))

    qx, qy = project(Y_POINT)
    ax.plot([qx], [qy], "o", color=INK, ms=4.5, zorder=7)
    ax.annotate(r"$y = (\beta_1, \beta_2, \beta_3)$", xy=(qx, qy),
                xytext=(3.55, 3.10), fontsize=11, color=INK, ha="right",
                va="center",
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=0.9,
                                shrinkA=2, shrinkB=3, mutation_scale=11))

    # Axis labels.
    ax.text(tips[0][0] + 0.10, tips[0][1] - 0.28, r"$x_1$", fontsize=12,
            color=INK, ha="left", va="top")
    ax.text(tips[1][0] - 0.10, tips[1][1] - 0.28, r"$x_2$", fontsize=12,
            color=INK, ha="right", va="top")
    ax.text(tips[2][0], tips[2][1] + 0.12, r"$x_3$", fontsize=12, color=INK,
            ha="center", va="bottom")

    ax.set_xlim(-4.5, 4.3)
    ax.set_ylim(-1.9, 4.5)

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
