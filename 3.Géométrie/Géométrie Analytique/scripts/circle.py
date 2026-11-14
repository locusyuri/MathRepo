"""The torus obtained by rotating a circle about the z-axis.

Left: the generating circle Gamma: (y - b)^2 + z^2 = a^2 in the plane x = 0,
with the radius a and the offset b.  Right: the resulting torus.

Output: ../img/circle.svg
"""

from __future__ import annotations

import sys
from math import cos, radians, sin
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import Circle

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import axes, ellipse3d, save, setup, show, torus

OUT = Path(__file__).resolve().parent.parent / "img" / "circle.svg"

INK = "#1f2933"
AXIS = "#8b949e"
BLUE = "#1f4e9b"

B, A = 1.35, 0.52


def left_panel(fig):
    ax = fig.add_subplot(1, 2, 1)
    ax.set_aspect("equal")
    ax.axis("off")
    ax.set_xlim(-0.95, 2.35)
    ax.set_ylim(-1.25, 1.45)

    for end in ((2.25, 0), (0, 1.35), (-0.75, -0.75)):
        ax.annotate("", xy=end, xytext=(0, 0),
                    arrowprops=dict(arrowstyle="-|>", color=AXIS, lw=1.0,
                                    shrinkA=0, shrinkB=0, mutation_scale=11))
    ax.text(2.28, -0.10, r"$y$", fontsize=11, color=INK)
    ax.text(-0.08, 1.38, r"$z$", fontsize=11, color=INK)
    ax.text(-0.82, -0.82, r"$x$", fontsize=11, color=INK)
    ax.text(-0.09, -0.16, r"$O$", fontsize=11, color=INK)

    ax.add_patch(Circle((B, 0), A, facecolor="#eef3fa", edgecolor=BLUE, lw=1.4))
    ax.plot([B], [0], "o", color=INK, ms=3)
    ang = radians(42)
    ax.plot([B, B + A * cos(ang)], [0, A * sin(ang)], color=INK, lw=1.0)
    ax.text(B + 0.22 * cos(ang), 0.22 * sin(ang) + 0.06, r"$a$", fontsize=11,
            color=INK)

    # Bracket marking b, the distance from O to the closest point of Gamma.
    x0 = B - A
    ax.plot([0, x0, x0], [-0.58, -0.58, -0.46], color=INK, lw=0.9)
    ax.plot([0, 0], [-0.66, -0.50], color=INK, lw=0.9)
    ax.text(x0 / 2, -0.74, r"$b$", ha="center", va="top", fontsize=11,
            color=INK)


def main():
    fig = plt.figure(figsize=(8.6, 3.7))
    left_panel(fig)

    ax = fig.add_subplot(1, 2, 2, projection="3d")
    setup(ax, lim=1.35, elev=22, azim=-60, zoom=1.35)
    show(ax, *torus(R=0.86, r=0.34), n_lat=5, n_lon=12)
    ellipse3d(ax, 1.20, 1.20, 0.0, lw=1.1)
    ellipse3d(ax, 0.52, 0.52, 0.0, lw=1.1)
    axes(ax, length=(1.15, 1.15, 0.85))

    fig.subplots_adjust(left=0.0, right=1.0, top=1.0, bottom=0.0, wspace=0.0)
    save(fig, OUT)


if __name__ == "__main__":
    main()
