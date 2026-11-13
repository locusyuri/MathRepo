"""The extended complex plane as the Riemann sphere.

The complex plane is drawn as the equatorial plane of a sphere; the point at
infinity is the north pole N.  A point z of the plane projects onto the sphere
at P along the line through N (stereographic projection).

Output: ../img/extended-complex-plane.svg
"""

from __future__ import annotations

import os
import sys
from dataclasses import replace
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import Arc, Circle, Ellipse

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(5.4, 4.4))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1f2933"
AXIS = "#8b949e"
RED = "#c0392b"
PLANE_FILL = "#e8f1f8"

PLANE_W, PLANE_H = 5.2, 0.62      # apparent shape of the equatorial plane
Z = (1.95, -0.06)                 # a point of the complex plane


def sphere_hit(start, end):
    """First intersection of the segment start->end with the unit circle."""
    dx, dy = end[0] - start[0], end[1] - start[1]
    a = dx * dx + dy * dy
    b = 2 * (start[0] * dx + start[1] * dy)
    c = start[0] ** 2 + start[1] ** 2 - 1.0
    disc = b * b - 4 * a * c
    t = (-b - disc ** 0.5) / (2 * a)
    return start[0] + t * dx, start[1] + t * dy


def main():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)
    ax.set_aspect("equal")
    ax.set_xlim(-3.05, 3.05)
    ax.set_ylim(-1.42, 1.42)
    ax.axis("off")

    # Equatorial plane of the sphere = the complex plane.
    ax.add_patch(Ellipse((0, 0), PLANE_W, PLANE_H, facecolor=PLANE_FILL,
                         edgecolor=AXIS, lw=0.9, zorder=1))
    ax.text(-1.95, -0.10, "complex plane", ha="center", va="center", fontsize=8.5,
            color="#52606d")

    # Sphere (drawn in front of the plane so the back of the equator is hidden).
    ax.add_patch(Circle((0, 0), 1.0, facecolor="white", edgecolor=INK,
                        lw=1.0, alpha=0.92, zorder=2))

    # Equator: front half solid, back half dashed.
    eq_h = PLANE_H * 2 / PLANE_W * 2  # same foreshortening as the plane
    ax.add_patch(Arc((0, 0), 2, eq_h, theta1=180, theta2=360, color=INK,
                     lw=1.0, zorder=3))
    ax.add_patch(Arc((0, 0), 2, eq_h, theta1=0, theta2=180, color=AXIS,
                     lw=0.9, ls=(0, (3, 3)), zorder=3))

    # Stereographic projection: N -> z meets the sphere at P.
    # The segment N-P runs inside the ball (dashed), P-z outside (solid).
    north = (0.0, 1.0)
    hit = sphere_hit(north, Z)
    ax.plot([north[0], hit[0]], [north[1], hit[1]], color=RED, lw=1.1,
            ls=(0, (3, 2)), zorder=5)
    ax.plot([hit[0], Z[0]], [hit[1], Z[1]], color=RED, lw=1.1, zorder=5)
    ax.plot([hit[0]], [hit[1]], "o", color=RED, ms=4.5, zorder=6)
    ax.plot([Z[0]], [Z[1]], "o", color=RED, ms=4.5, zorder=6)
    ax.plot([north[0]], [north[1]], "o", color=INK, ms=4.5, zorder=6)

    ax.text(-0.12, 1.02, r"$N\;(\infty)$", ha="right", va="bottom", fontsize=11,
            color=INK)
    ax.text(-0.12, -1.02, r"$S$", ha="right", va="top", fontsize=11, color=INK)
    ax.text(hit[0] + 0.10, hit[1] - 0.12, r"$P$", ha="left", va="top",
            fontsize=11, color=RED)
    ax.text(Z[0] + 0.08, Z[1] + 0.02, r"$z$", ha="left", va="center",
            fontsize=11, color=RED)
    ax.plot([0], [0], "o", color=INK, ms=2.5, zorder=5)

    path = SPEC.save(fig, OUT_DIR / "extended-complex-plane")
    print(f"Saved: {path}")

    if os.environ.get("PREVIEW"):
        preview = OUT_DIR / "extended-complex-plane-preview.png"
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.05)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
