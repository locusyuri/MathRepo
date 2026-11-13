"""Comparison of common continuous densities (1x5 row).

  1: Uniform U(0, 2)      blue, f = 1/(b-a) on [0, 2]
  2: Exponential Exp(1)   red, e^{-x}
  3: Normal N(0, 1)       blue bell + sigma lines / 3-sigma band
  4: Gamma Ga(2, 1)       green, x e^{-x}, mode at x = 1
  5: Beta Be(2, 3)        orange, x(1-x)^2 / B(2,3) = 12 x (1-x)^2

Run with: uv run python src/math_paper/common_continuous_densities.py
"""

from __future__ import annotations

from dataclasses import replace
from math import sqrt
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_TEXTBOOK, figsize=(16.0, 3.4))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#1f4e9b"
RED = "#c0392b"
GRN = "#27ae60"
ORG = "#e67e22"
INK = "#333333"
GRID = "#dddddd"
BAND = "#aed3f0"
SIGMA = "#999999"


def style_ax(ax, title, xlabel_xticks, ylim, yticks):
    ax.set_title(title, fontsize=12, pad=8)
    ax.set_xlabel(r"$x$", fontsize=11, color=INK)
    ax.set_ylabel(r"$f(x)$", fontsize=11, color=INK)
    ax.set_ylim(*ylim)
    ax.set_yticks(yticks)
    ax.axhline(0, color=INK, lw=0.8, zorder=2)
    ax.grid(True, color=GRID, lw=0.6, zorder=0)
    ax.set_axisbelow(True)
    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    for s in ("left", "bottom"):
        ax.spines[s].set_color(INK)
        ax.spines[s].set_linewidth(0.9)
    ax.tick_params(labelsize=9.5, colors=INK)


def formula(ax, txt, x, y, color):
    ax.text(x, y, txt, fontsize=13, color=color)


# -- 1: Uniform ---------------------------------------------------------------
def panel_uniform(ax):
    ax.hlines(0.5, 0, 2, color=BLU, lw=2.2, zorder=3)
    ax.vlines([0, 2], 0, 0.5, color=BLU, lw=1.0, zorder=2)
    ax.plot([0, 2], [0.5, 0.5], "o", color=BLU, ms=5.5, zorder=4)
    ax.set_xlim(-0.5, 2.5)
    ax.set_xticks([0, 1, 2])
    style_ax(ax, r"Uniform $U(0,\,2)$", None, (0, 0.6), np.arange(0, 0.61, 0.2))
    formula(ax, r"$\dfrac{1}{b-a}$", 0.75, 0.52, BLU)


# -- 2: Exponential -----------------------------------------------------------
def panel_exponential(ax):
    x = np.linspace(0, 5, 300)
    ax.plot(x, np.exp(-x), color=RED, lw=2.2, zorder=3)
    ax.plot(0, 1, "o", color=RED, ms=5.5, zorder=4)
    ax.set_xlim(0, 5)
    ax.set_xticks(np.arange(0, 6, 1))
    style_ax(ax, r"Exponential $\mathrm{Exp}(1)$", None,
             (0, 1.1), np.arange(0, 1.11, 0.25))
    formula(ax, r"$e^{-x}$", 1.35, 0.62, RED)


# -- 3: Normal ----------------------------------------------------------------
def panel_normal(ax):
    x = np.linspace(-4, 4, 400)
    pdf = np.exp(-0.5 * x**2) / sqrt(2 * np.pi)
    # outermost 3-sigma band
    band = np.linspace(-3, 3, 200)
    ax.fill_between(band, 0, np.exp(-0.5 * band**2) / sqrt(2 * np.pi),
                    color=BAND, alpha=0.35, zorder=1)
    for s in (1, 2, 3):
        ax.axvline(s, color=SIGMA, lw=0.8, ls="--", zorder=2)
        ax.axvline(-s, color=SIGMA, lw=0.8, ls="--", zorder=2)
    ax.plot(x, pdf, color=BLU, lw=2.2, zorder=3)
    ax.set_xlim(-4, 4)
    ax.set_xticks(np.arange(-4, 5, 1))
    style_ax(ax, r"Normal $N(0,\,1)$", None,
             (0, 0.45), np.arange(0, 0.46, 0.1))
    for s, lab, yy in ((1, "68%", 0.40), (2, "95%", 0.35), (3, "99.7%", 0.30)):
        ax.text(0, yy, lab, ha="center", fontsize=8.5, color="#555555",
                zorder=5)
    formula(ax, r"$\dfrac{1}{\sqrt{2\pi}}e^{-x^{2}/2}$",
            -3.85, 0.405, BLU)


# -- 4: Gamma -----------------------------------------------------------------
def panel_gamma(ax):
    x = np.linspace(0, 6, 400)
    y = x * np.exp(-x)
    assert abs(y.max() - np.exp(-1)) < 1e-3  # mode (1, 1/e ~ 0.3679)
    ax.plot(x, y, color=GRN, lw=2.2, zorder=3)
    ax.plot(1, np.exp(-1), "o", color=GRN, ms=5, zorder=4)
    ax.set_xlim(0, 6)
    ax.set_xticks(np.arange(0, 7, 1))
    style_ax(ax, r"Gamma $\mathrm{Ga}(2,\,1)$", None,
             (0, 0.45), np.arange(0, 0.46, 0.1))
    formula(ax, r"$x\,e^{-x}$", 2.1, 0.395, GRN)


# -- 5: Beta ------------------------------------------------------------------
def panel_beta(ax):
    x = np.linspace(0, 1, 400)
    # B(2, 3) = 1/12  ->  f(x) = 12 x (1-x)^2
    y = 12.0 * x * (1 - x) ** 2
    mode_x = 1.0 / 3.0
    mode_y = 12.0 * mode_x * (2.0 / 3.0) ** 2
    assert abs(y.max() - mode_y) < 1e-3 and abs(mode_y - 16 / 9) < 1e-9
    ax.plot(x, y, color=ORG, lw=2.2, zorder=3)
    ax.plot(mode_x, mode_y, "o", color=ORG, ms=5, zorder=4)
    ax.set_xlim(0, 1)
    ax.set_xticks(np.arange(0, 1.01, 0.25))
    style_ax(ax, r"Beta $\mathrm{Be}(2,\,3)$", None,
             (0, 1.8), np.arange(0, 1.81, 0.3))
    formula(ax, r"$12\,x(1-x)^{2}$", 0.42, 1.55, ORG)


def build_figure():
    fig = SPEC.figure()
    panel_uniform(fig.add_subplot(1, 5, 1))
    panel_exponential(fig.add_subplot(1, 5, 2))
    panel_normal(fig.add_subplot(1, 5, 3))
    panel_gamma(fig.add_subplot(1, 5, 4))
    panel_beta(fig.add_subplot(1, 5, 5))
    fig.subplots_adjust(wspace=0.42, left=0.05, right=0.99,
                        top=0.88, bottom=0.16)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "common-continuous-densities")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
