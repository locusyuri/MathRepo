"""Joint density — L-shaped three-panel layout.

Main panel shows the bivariate normal density f(x,y) as filled contours
(blue gradient, dark = high density).  Top panel projects the marginal
f_X(x) upward; right panel projects f_Y(y) rightward.  All three panels
share axes.

Run with: uv run python src/math_paper/joint_density.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(9, 8), transparent=False)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#1f4e9b"
LBLU = "#cfe3f7"
DARK = "#222222"
GRAY = "#666666"

SIGMA = 1.0
RHO = 0.0


def bivariate_normal(x, y, sigma=SIGMA, rho=RHO):
    denom = 2 * np.pi * sigma**2 * np.sqrt(1 - rho**2)
    z = (x**2 + y**2 - 2 * rho * x * y) / (sigma**2 * (1 - rho**2))
    return np.exp(-z / 2) / denom


def marginal(t, sigma=SIGMA):
    return np.exp(-t**2 / (2 * sigma**2)) / (sigma * np.sqrt(2 * np.pi))


def build_figure():
    fig = SPEC.figure()
    gs = fig.add_gridspec(2, 2, width_ratios=[4, 1.1],
                          height_ratios=[1.1, 4],
                          hspace=0.07, wspace=0.07)

    ax_main = fig.add_subplot(gs[1, 0])
    ax_top = fig.add_subplot(gs[0, 0], sharex=ax_main)
    ax_right = fig.add_subplot(gs[1, 1], sharey=ax_main)

    extent = (-3.5, 3.5)
    t = np.linspace(extent[0], extent[1], 300)
    X, Y = np.meshgrid(t, t)
    Z = bivariate_normal(X, Y)

    fill_levels = np.linspace(0.005, Z.max() * 0.98, 20)
    cmap = plt.cm.Blues
    ax_main.contourf(X, Y, Z, levels=fill_levels, cmap=cmap, alpha=0.85,
                     extend="max")

    line_levels = [0.02, 0.04, 0.06, 0.08, 0.10, 0.12, 0.14]
    line_levels = [lv for lv in line_levels if lv < Z.max()]
    cs = ax_main.contour(X, Y, Z, levels=line_levels, colors=BLU,
                         linewidths=0.7, alpha=0.7)
    ax_main.clabel(cs, inline=True, fontsize=7.5, fmt="%.2f")

    ax_main.set_xlabel(r"$x$", fontsize=13, color=DARK)
    ax_main.set_ylabel(r"$y$", fontsize=13, color=DARK)
    ax_main.tick_params(labelsize=9, colors=GRAY)
    for s in ax_main.spines.values():
        s.set_color("#bbbbbb")

    fx = marginal(t)
    ax_top.fill_between(t, fx, alpha=0.25, color=BLU)
    ax_top.plot(t, fx, color=BLU, lw=1.6)
    ax_top.set_ylabel(r"$f_X(x)$", fontsize=11, color=BLU)
    ax_top.tick_params(labelsize=8, colors=GRAY)
    plt.setp(ax_top.get_xticklabels(), visible=False)
    ax_top.spines["top"].set_visible(False)
    ax_top.spines["right"].set_visible(False)
    for s in ["left", "bottom"]:
        ax_top.spines[s].set_color("#bbbbbb")

    fy = marginal(t)
    ax_right.fill_betweenx(t, fy, alpha=0.25, color=BLU)
    ax_right.plot(fy, t, color=BLU, lw=1.6)
    ax_right.set_xlabel(r"$f_Y(y)$", fontsize=11, color=BLU)
    ax_right.tick_params(labelsize=8, colors=GRAY)
    plt.setp(ax_right.get_yticklabels(), visible=False)
    ax_right.spines["top"].set_visible(False)
    ax_right.spines["right"].set_visible(False)
    for s in ["left", "bottom"]:
        ax_right.spines[s].set_color("#bbbbbb")

    ax_main.text(-3.3, 3.3,
                 r"$f(x,y)=\frac{1}{2\pi\sigma^2}"
                 r"\exp\!\left(-\frac{x^2+y^2}{2\sigma^2}\right)$",
                 fontsize=9, color=DARK, ha="left", va="top",
                 bbox=dict(boxstyle="round,pad=0.2", fc="white",
                           ec="#cccccc", lw=0.5, alpha=0.85))

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "joint-density")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
