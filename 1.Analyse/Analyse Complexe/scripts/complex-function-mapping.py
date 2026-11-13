"""A complex function as a transformation between the z-plane and the w-plane.

Two copies of the complex plane are drawn side by side: a domain D in the
z-plane and its image f(D) in the w-plane.  The map shown is the complex
conjugation w = conj(z), which reflects the plane across the real axis; the
points z1, z2, z3 of D are carried to w1, w2, w3.

Output: ../img/complex-function-mapping.svg
"""

from __future__ import annotations

import os
import sys
from dataclasses import replace
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import Circle, FancyArrowPatch

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH_PANEL, figsize=(7.6, 3.6))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1f2933"
AXIS = "#9aa5b1"
BLUE = "#4a90d9"
FILL = "#d6e9f8"
RED = "#c0392b"

CENTER = (0.0, 0.80)   # centre of the disc D in the z-plane
RADIUS = 0.70
LIMIT = 2.0
POINTS = [(-0.34, 0.55), (0.12, 1.15), (0.42, 0.45)]  # z1, z2, z3


def draw_plane(ax, title):
    """Draw one copy of the complex plane with plain Re/Im axes."""
    ax.set_aspect("equal")
    ax.set_xlim(-LIMIT, LIMIT)
    ax.set_ylim(-LIMIT, LIMIT)
    ax.set_xticks([])
    ax.set_yticks([])
    for spine in ax.spines.values():
        spine.set_visible(False)

    for start, end in (((-LIMIT, 0), (LIMIT, 0)), ((0, -LIMIT), (0, LIMIT))):
        ax.annotate("", xy=end, xytext=start,
                    arrowprops=dict(arrowstyle="-|>", color=AXIS, lw=1.0,
                                    shrinkA=0, shrinkB=0, mutation_scale=11))
    ax.text(LIMIT - 0.06, 0.10, r"$\mathrm{Re}$", ha="right", va="bottom",
            fontsize=11.5, color=INK)
    ax.text(0.10, LIMIT - 0.06, r"$\mathrm{Im}$", ha="left", va="top",
            fontsize=11.5, color=INK)
    ax.set_title(title, fontsize=12.5, color=INK, pad=8)


def draw_disc(ax, centre, labels, region_label, label_side):
    """Disc of radius RADIUS at `centre`, with the mapped points and a label."""
    ax.add_patch(Circle(centre, RADIUS, facecolor=FILL, edgecolor=BLUE, lw=1.1,
                        alpha=0.85, zorder=1))
    sign = 1 if centre[1] > 0 else -1
    for (px, py), label in zip(POINTS, labels):
        y = centre[1] + sign * (py - CENTER[1])
        ax.plot([px], [y], "o", color=INK, ms=5, zorder=3)
        ax.text(px + 0.08, y + 0.08, label, fontsize=11, color=INK, zorder=3)
    dist = RADIUS + 0.10
    x = centre[0] - dist if label_side == "left" else centre[0] + dist
    ax.text(x, centre[1], region_label,
            ha="right" if label_side == "left" else "left", va="center",
            fontsize=12, color=INK, zorder=3)


def main():
    fig = SPEC.figure()
    ax_z = fig.add_axes([0.05, 0.08, 0.37, 0.76])
    ax_w = fig.add_axes([0.58, 0.08, 0.37, 0.76])

    draw_plane(ax_z, "z-plane")
    draw_plane(ax_w, "w-plane")

    draw_disc(ax_z, CENTER, [r"$z_1$", r"$z_2$", r"$z_3$"], r"$D$", "left")
    draw_disc(ax_w, (CENTER[0], -CENTER[1]), [r"$w_1$", r"$w_2$", r"$w_3$"],
              r"$f(D)$", "left")

    fig.add_artist(FancyArrowPatch((0.46, 0.50), (0.54, 0.50),
                                   transform=fig.transFigure, arrowstyle="-|>",
                                   mutation_scale=20, color=RED, lw=1.5,
                                   shrinkA=0, shrinkB=0))
    fig.text(0.50, 0.56, r"$w = \overline{z}$", ha="center", va="bottom",
             fontsize=12, color=RED)

    path = SPEC.save(fig, OUT_DIR / "complex-function-mapping")
    print(f"Saved: {path}")

    if os.environ.get("PREVIEW"):
        preview = OUT_DIR / "complex-function-mapping-preview.png"
        fig.savefig(preview, dpi=150, facecolor="white", bbox_inches="tight",
                    pad_inches=0.05)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
