"""The n-th roots of unity on the unit circle.

For n = 8 the roots exp(2 k pi i / n), k = 0, ..., 7, drawn on the unit circle
of the complex plane; neighbours are separated by the angle 2 pi / n, marked on
the arc between the first two roots.

Output: ../img/roots-visualisation.svg
"""

from __future__ import annotations

import os
import sys
from dataclasses import replace
from math import cos, pi, sin
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import Arc, Circle

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(5.4, 5.0))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1f2933"
AXIS = "#8b949e"
BLUE = "#1f4e9b"
DOT = "#c0392b"

N = 8


def main():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)
    ax.set_aspect("equal")
    ax.set_xlim(-1.45, 1.45)
    ax.set_ylim(-1.42, 1.42)
    ax.axis("off")

    ax.add_patch(Circle((0, 0), 1.0, facecolor="none", edgecolor=INK, lw=1.1,
                        zorder=1))

    # Axes.
    for start, end in (((-1.30, 0), (1.36, 0)), ((0, -1.30), (0, 1.32))):
        ax.annotate("", xy=end, xytext=start,
                    arrowprops=dict(arrowstyle="-|>", color=AXIS, lw=0.9,
                                    shrinkA=0, shrinkB=0, mutation_scale=10))
    ax.text(1.40, 0.02, r"$\mathrm{Re}$", ha="left", va="center", fontsize=10,
            color=INK)
    ax.text(0.06, 1.36, r"$\mathrm{Im}$", ha="left", va="bottom", fontsize=10,
            color=INK)

    angles = [2 * pi * k / N for k in range(N)]
    for k, angle in enumerate(angles):
        x, y = cos(angle), sin(angle)
        ax.plot([0, x], [0, y], color=BLUE, lw=0.9, alpha=0.75, zorder=2)
        ax.plot([x], [y], "o", color=DOT, ms=5, zorder=4)
        # Labels on the axes are pushed off them so the axis lines stay clear.
        if k == 0:
            dx, dy, ha = 0.0, 0.13, "center"
        elif k == N // 2:
            dx, dy, ha = 0.0, -0.13, "center"
        elif k == N // 4:
            dx, dy, ha = 0.12, 0.0, "left"
        elif k == 3 * N // 4:
            dx, dy, ha = 0.12, 0.0, "left"
        else:
            dx, dy, ha = 0.0, 0.0, "center"
        ax.text(1.15 * x + dx, 1.15 * y + dy, rf"$\omega_{k}$", ha=ha,
                va="center", fontsize=10.5, color=INK, zorder=5)

    # Angular gap 2 pi / n between neighbouring roots.
    ax.add_patch(Arc((0, 0), 0.62, 0.62, theta1=0, theta2=360 / N,
                     color=DOT, lw=1.1, zorder=3))
    ax.text(0.40 * cos(pi / N), 0.40 * sin(pi / N), r"$\frac{2\pi}{n}$",
            ha="left", va="center", fontsize=10, color=DOT, zorder=5)

    ax.text(0.04, -0.09, r"$0$", ha="left", va="top", fontsize=10, color=INK)

    path = SPEC.save(fig, OUT_DIR / "roots-visualisation")
    print(f"Saved: {path}")

    if os.environ.get("PREVIEW"):
        preview = OUT_DIR / "roots-visualisation-preview.png"
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.05)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
