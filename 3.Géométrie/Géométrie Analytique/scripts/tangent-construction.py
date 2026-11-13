"""Tangent line to the ellipse x^2/4 + y^2/9 = 1 at the point P0.

- blue ellipse with its two foci on the y-axis;
- tangent point P0 = (1, 3 sqrt(3)/2) in red;
- tangent line 3 x + 2 sqrt(3) y - 12 = 0 in red, labelled ell;
- origin O, axes labelled x, y.

Single panel, x, y in [-4, 4]. White background, SVG output.

Run with: uv run python src/math_paper/tangent_construction.py
"""

from __future__ import annotations

import math
from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_TEXTBOOK, figsize=(8.0, 8.0), transparent=False)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLUE = "#2563EB"
RED = "#DC2626"
BLACK = "#000000"


def panel(ax):
    ax.set_xlim(-4, 4)
    ax.set_ylim(-4, 4)
    ax.set_aspect("equal")
    ax.axis("off")

    # -- coordinate axes ---------------------------------------------------
    ax.annotate("", xy=(4, 0), xytext=(-4, 0),
                arrowprops=dict(arrowstyle="-|>", color=BLACK, lw=0.6,
                                mutation_scale=8))
    ax.annotate("", xy=(0, 4), xytext=(0, -4),
                arrowprops=dict(arrowstyle="-|>", color=BLACK, lw=0.6,
                                mutation_scale=8))
    ax.text(3.85, -0.25, "$x$", fontsize=11, color=BLACK, ha="right", va="top")
    ax.text(0.15, 3.85, "$y$", fontsize=11, color=BLACK, ha="left", va="top")
    ax.text(-0.15, -0.15, "$O$", fontsize=11, color=BLACK, ha="right", va="top")

    # -- ellipse + foci ----------------------------------------------------
    th = np.linspace(0, 2 * math.pi, 400)
    ax.plot(2 * np.cos(th), 3 * np.sin(th), color=BLUE, lw=2.0, zorder=3)
    f = math.sqrt(5)
    ax.plot([0, 0], [f, -f], "o", color=BLUE, ms=5, zorder=4)

    # -- tangent point P0 = (1, 3 sqrt(3) / 2) -----------------------------
    px, py = 1.0, 3 * math.sqrt(3) / 2
    ax.plot([px], [py], "o", color=RED, ms=7, zorder=5)
    ax.text(px + 0.15, py + 0.12, r"$P_0$", fontsize=12, color=BLACK,
            ha="left", va="bottom", zorder=6)

    # -- tangent line 3 x + 2 sqrt(3) y - 12 = 0  (x from 0.5 to 4) --------
    xl = np.linspace(0.5, 4.0, 100)
    yl = (12 - 3 * xl) / (2 * math.sqrt(3))
    ax.plot(xl, yl, color=RED, lw=1.5, zorder=4)
    ax.text(3.05, 0.55, r"$\ell$", fontsize=15, color=BLACK,
            ha="left", va="top", zorder=6)


def build_figure():
    fig = SPEC.figure()
    panel(fig.add_axes([0.04, 0.04, 0.94, 0.94]))
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "tangent-construction")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()