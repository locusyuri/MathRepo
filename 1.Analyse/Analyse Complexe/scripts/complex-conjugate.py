"""Complex number z and its conjugate in the complex plane.

The point z = x + i y and its mirror image conj(z) = x - i y across the real
axis, with the modulus r, the arguments ±φ and the projections x, y, -y.

Output: ../img/complex-conjugate.svg
"""

from __future__ import annotations

import os
import sys
from dataclasses import replace
from math import atan2, cos, degrees, radians, sin
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import Arc

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(4.6, 4.6))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1f2933"
AXIS = "#8b949e"
BLUE = "#4a90d9"

X, Y = 2.0, 1.35          # z = X + iY
PHI = degrees(atan2(Y, X))  # argument of z, in degrees


def polar(radius, angle_deg):
    """Point at `radius` along direction `angle_deg` (degrees)."""
    return radius * cos(radians(angle_deg)), radius * sin(radians(angle_deg))


def main():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)
    ax.set_aspect("equal")
    ax.set_xlim(-1.35, 3.45)
    ax.set_ylim(-2.55, 2.55)
    ax.axis("off")

    # Axes with arrow heads.
    ax.annotate("", xy=(3.35, 0), xytext=(-1.25, 0),
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.3,
                                shrinkA=0, shrinkB=0, mutation_scale=14))
    ax.annotate("", xy=(0, 2.45), xytext=(0, -2.45),
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.3,
                                shrinkA=0, shrinkB=0, mutation_scale=14))
    ax.text(3.42, 0.02, r"$\mathrm{Re}$", ha="left", va="center", fontsize=12, color=INK)
    ax.text(0.08, 2.38, r"$\mathrm{Im}$", ha="left", va="bottom", fontsize=12, color=INK)
    ax.text(-0.10, -0.16, r"$0$", ha="right", va="top", fontsize=11, color=INK)

    # z and its conjugate as vectors from the origin.
    for sign in (1, -1):
        ax.plot([0, X], [0, sign * Y], color=BLUE, lw=2.2, zorder=3,
                solid_capstyle="round")
        ax.plot([X], [sign * Y], "o", color=BLUE, ms=6, zorder=4)

    # Projections onto the axes.
    ax.plot([X, X], [Y, -Y], color=AXIS, lw=0.9, ls=(0, (4, 3)), zorder=1)
    ax.plot([0, X], [Y, Y], color=AXIS, lw=0.9, ls=(0, (4, 3)), zorder=1)
    ax.plot([0, X], [-Y, -Y], color=AXIS, lw=0.9, ls=(0, (4, 3)), zorder=1)

    ax.text(X, -0.13, r"$x$", ha="center", va="top", fontsize=11, color=INK)
    ax.text(-0.12, Y, r"$y$", ha="right", va="center", fontsize=11, color=INK)
    ax.text(-0.12, -Y, r"$-y$", ha="right", va="center", fontsize=11, color=INK)

    # Arguments ±φ.
    for theta1, theta2 in ((0, PHI), (-PHI, 0)):
        ax.add_patch(Arc((0, 0), 1.15, 1.15, theta1=theta1, theta2=theta2,
                         color=INK, lw=0.9))
    ax.text(*polar(0.78, PHI / 2), r"$\varphi$", ha="left", va="center",
            fontsize=11, color=INK)
    ax.text(*polar(0.78, -PHI / 2), r"$-\varphi$", ha="left", va="center",
            fontsize=11, color=INK)

    # Modulus labels, offset perpendicular to each vector.
    ax.text(0.52 * X - 0.16, 0.52 * Y, r"$r$", ha="center", va="center",
            fontsize=11, color=INK)
    ax.text(0.52 * X - 0.16, -0.52 * Y, r"$r$", ha="center", va="center",
            fontsize=11, color=INK)

    ax.text(X + 0.12, Y + 0.10, r"$z = x + iy$", ha="left", va="bottom",
            fontsize=12, color=INK)
    ax.text(X + 0.12, -Y - 0.10, r"$\overline{z} = x - iy$", ha="left", va="top",
            fontsize=12, color=INK)

    path = SPEC.save(fig, OUT_DIR / "complex-conjugate")
    print(f"Saved: {path}")

    if os.environ.get("PREVIEW"):
        preview = OUT_DIR / "complex-conjugate-preview.png"
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.05)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
