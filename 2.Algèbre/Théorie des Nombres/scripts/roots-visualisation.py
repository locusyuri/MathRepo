"""The n-th roots of a complex number, for n = 1, ..., 6.

Each panel solves X^n = Z for Z = r e^{i phi}: the n solutions sit on the circle
of radius r^{1/n} at the angles (phi + 2 pi k)/n, so they are equally spaced and
the argument shrinks to phi/n.  The dashed circle is the circle of radius r on
which Z itself lies, the grey sector is the angle phi/n, and the black radius is
the principal root (k = 0).

Output: ../img/roots-visualisation.svg
"""

from __future__ import annotations

import os
import sys
from dataclasses import replace
from math import cos, pi, radians, sin
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import Wedge

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(8.8, 10.4))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1f2933"
AXIS = "#9aa5b1"
GHOST = "#c3cbd4"
FILL = "#e6ebf0"

COLOURS = ["#1f2933", "#c0392b", "#1e8449", "#1f4e9b", "#b9770e", "#7d3c98"]

MODULUS = 1.55          # |Z| = r
PHI_DEG = 52.0          # argument of Z
LIMIT = MODULUS * 1.34


def draw_panel(ax, n):
    """One panel: the n solutions of X^n = Z."""
    ax.set_aspect("equal")
    ax.set_xlim(-LIMIT, LIMIT)
    ax.set_ylim(-LIMIT * 1.04, LIMIT * 1.04)
    ax.axis("off")

    r_root = MODULUS ** (1 / n)

    # Axis cross with small arrow heads.
    for dx, dy in ((1.0, 0.0), (0.0, 1.0)):
        ax.annotate("", xy=(LIMIT * dx, LIMIT * dy),
                    xytext=(-LIMIT * dx, -LIMIT * dy),
                    arrowprops=dict(arrowstyle="-|>", color=AXIS, lw=0.8,
                                    shrinkA=0, shrinkB=0, mutation_scale=9))
    ax.text(-LIMIT * 0.99, LIMIT * 0.88, r"$\mathrm{Im}$", ha="left",
            va="center", fontsize=8, color=AXIS)
    ax.text(LIMIT * 0.99, -LIMIT * 0.06, r"$\mathrm{Re}$", ha="right",
            va="top", fontsize=8, color=AXIS)

    # Circle of radius r (where Z lies).
    if n > 1:
        ax.add_patch(plt.Circle((0, 0), MODULUS, facecolor="none",
                                edgecolor=GHOST, lw=0.8, ls=(0, (2, 2)),
                                zorder=1))
        zx, zy = MODULUS * cos(radians(PHI_DEG)), MODULUS * sin(radians(PHI_DEG))
        ax.plot([zx], [zy], "o", color=GHOST, ms=3.2, zorder=5)
        ax.text(LIMIT * 0.97, LIMIT * 0.90, r"$z = r e^{i\varphi}$", ha="right",
                va="center", fontsize=7.5, color=GHOST)

    # Circle carrying the n roots.
    ax.add_patch(plt.Circle((0, 0), r_root, facecolor="none", edgecolor=INK,
                            lw=1.0, zorder=2))

    # The angle phi/n, shaded.
    sector_r = r_root * (0.62 if n == 1 else 0.42)
    ax.add_patch(Wedge((0, 0), sector_r, 0, PHI_DEG / n, facecolor=FILL,
                       edgecolor=GHOST, lw=0.6, zorder=3))
    # The label sits just below the shaded sector, clear of the k = 0 radius.
    mid = radians(-0.22 * PHI_DEG / n)
    ax.text(1.55 * sector_r * cos(mid), 1.55 * sector_r * sin(mid),
            r"$\varphi$" if n == 1 else rf"$\varphi/{n}$",
            ha="left", va="top", fontsize=8.5, color=INK, zorder=7,
            bbox=dict(boxstyle="round,pad=0.10", fc="white", ec="none",
                      alpha=0.75))

    # Modulus of the roots, marked below the origin.
    ax.text(-r_root * 0.45, -0.20, rf"$\sqrt[{n}]{{r}}$"
            if n > 1 else r"$r$", ha="center", va="top", fontsize=8,
            color=AXIS, zorder=6)

    # The n roots, with their arguments.
    for k in range(n):
        angle = radians((PHI_DEG + 360.0 * k) / n)
        x, y = r_root * cos(angle), r_root * sin(angle)
        colour = COLOURS[k % 6]
        ax.plot([0, x], [0, y], color=colour, lw=1.8 if k == 0 else 1.3,
                solid_capstyle="round", zorder=4)
        ax.plot([x], [y], "o", color=colour, ms=4.0, zorder=5)

        label_r = r_root * 1.14
        lx, ly = label_r * cos(angle), label_r * sin(angle)
        ha = ("center" if abs(cos(angle)) < 0.2
              else ("left" if cos(angle) > 0 else "right"))
        text = (r"$r\,e^{i\varphi}$" if n == 1
                else rf"$e^{{i(\varphi+2\pi\cdot{k})/{n}}}$")
        ax.text(lx, ly, text, ha=ha, va="center", fontsize=7.5, color=colour,
                zorder=6)

    ax.text(0, -LIMIT * 1.00, r"$X = Z$" if n == 1 else rf"$X^{n} = Z$",
            ha="center", va="top", fontsize=13, color=INK)


def main():
    fig = SPEC.figure()
    for index in range(6):
        ax = fig.add_subplot(3, 2, index + 1)
        draw_panel(ax, index + 1)
    fig.subplots_adjust(left=0.02, right=0.98, top=0.995, bottom=0.02,
                        wspace=0.04, hspace=0.12)

    path = SPEC.save(fig, OUT_DIR / "roots-visualisation")
    print(f"Saved: {path}")

    if os.environ.get("PREVIEW"):
        preview = OUT_DIR / "roots-visualisation-preview.png"
        fig.savefig(preview, dpi=150, facecolor="white", bbox_inches="tight",
                    pad_inches=0.05)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
