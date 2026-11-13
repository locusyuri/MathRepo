"""Three non-degenerate conics in standard form, side by side.

Left:  ellipse   x^2/4 + y^2/9 = 1   (blue, foci on the y-axis)
Mid:   hyperbola x^2/4 - y^2/9 = 1   (red, asymptotes y = +/- 3x/2)
Right: parabola  y^2 = 4x            (green, focus (1,0), directrix x = -1)

Each panel spans x, y in [-4, 4] with its own black axes; panels are
separated by thin grey dividers and carry a title on top and the
equation at the bottom. White background, SVG output.

Run with: uv run python src/math_paper/conic_standard_forms.py
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

SPEC = replace(Presets.SVG_TEXTBOOK, figsize=(13.5, 5.6), transparent=False)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLUE = "#2563EB"
RED = "#DC2626"
GREEN = "#16A34A"
BLACK = "#000000"
GREY = "#D1D5DB"
LIMITS = (-4.0, 4.0)


def draw_axes(ax):
    xl, xr = LIMITS
    yl, yh = LIMITS
    ax.annotate("", xy=(xr, 0), xytext=(xl, 0),
                arrowprops=dict(arrowstyle="-|>", color=BLACK, lw=0.6,
                                mutation_scale=8))
    ax.annotate("", xy=(0, yh), xytext=(0, yl),
                arrowprops=dict(arrowstyle="-|>", color=BLACK, lw=0.6,
                                mutation_scale=8))
    ax.text(xr - 0.15, -0.25, "$x$", fontsize=11, color=BLACK,
            ha="right", va="top")
    ax.text(0.15, yh - 0.15, "$y$", fontsize=11, color=BLACK,
            ha="left", va="top")


def setup_panel(ax):
    ax.set_xlim(*LIMITS)
    ax.set_ylim(*LIMITS)
    ax.set_aspect("equal")
    ax.axis("off")
    draw_axes(ax)


def panel_ellipse(ax):
    th = np.linspace(0, 2 * math.pi, 400)
    ax.plot(2 * np.cos(th), 3 * np.sin(th), color=BLUE, lw=2.0, zorder=3)
    f = math.sqrt(5)
    ax.plot([0, 0], [f, -f], "o", color=BLUE, ms=5, zorder=4)


def panel_hyperbola(ax):
    t = np.linspace(-math.acosh(2), math.acosh(2), 200)
    ax.plot(2 * np.cosh(t), 3 * np.sinh(t), color=RED, lw=2.0, zorder=3)
    ax.plot(-2 * np.cosh(t), 3 * np.sinh(t), color=RED, lw=2.0, zorder=3)
    xs = np.linspace(-4, 4, 2)
    ax.plot(xs, 1.5 * xs, color=RED, lw=1.0, ls=(0, (4, 3)), zorder=2)
    ax.plot(xs, -1.5 * xs, color=RED, lw=1.0, ls=(0, (4, 3)), zorder=2)
    f = math.sqrt(13)
    ax.plot([f, -f], [0, 0], "o", color=RED, ms=5, zorder=4)


def panel_parabola(ax):
    t = np.linspace(-2, 2, 200)
    ax.plot(t ** 2, 2 * t, color=GREEN, lw=2.0, zorder=3)
    ax.plot([1], [0], "o", color=GREEN, ms=5, zorder=4)
    ax.plot([-1, -1], [-4, 4], color=GREEN, lw=1.0, ls=(0, (4, 3)), zorder=2)


def build_figure():
    fig = SPEC.figure()
    panels = (
        (fig.add_axes([0.04, 0.12, 0.30, 0.72]), panel_ellipse,
         "Ellipse", r"$\dfrac{x^2}{4}+\dfrac{y^2}{9}=1$", 0.19),
        (fig.add_axes([0.36, 0.12, 0.30, 0.72]), panel_hyperbola,
         "Hyperbola", r"$\dfrac{x^2}{4}-\dfrac{y^2}{9}=1$", 0.51),
        (fig.add_axes([0.68, 0.12, 0.30, 0.72]), panel_parabola,
         "Parabola", r"$y^2=4x$", 0.83),
    )
    for ax, draw, title, eq, cx in panels:
        setup_panel(ax)
        draw(ax)
        fig.text(cx, 0.90, title, ha="center", fontsize=13, color=BLACK)
        fig.text(cx, 0.045, eq, ha="center", fontsize=12, color=BLACK)

    axm = fig.add_axes([0, 0, 1, 1])
    axm.set_axis_off()
    for x in (0.345, 0.665):
        axm.plot([x, x], [0.08, 0.88], color=GREY, lw=0.8,
                 transform=axm.transAxes, clip_on=False)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "conic-standard-forms")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()