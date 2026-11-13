"""Three types of CDFs: discrete, continuous, mixed.

Three side-by-side panels sharing y in [0, 1]:
  - Discrete: step CDF for P(X=0)=1/3, P(X=1)=2/3
  - Continuous: smooth sigmoid S-curve
  - Mixed: jump at x=0 then continuous rise

Run with: uv run python src/math_paper/cdf_types.py
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

SPEC = replace(Presets.SVG_MATH, figsize=(13, 4.2), transparent=False)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#4a90d9"
DARK = "#222222"


def style(ax, title):
    ax.set_ylim(-0.05, 1.12)
    ax.axhline(0, color=DARK, lw=0.6, zorder=0)
    ax.axhline(1, color=DARK, lw=0.6, ls=":", zorder=0)
    ax.set_yticks([0, 1])
    ax.set_yticklabels(["0", "1"], fontsize=10)
    ax.set_title(title, fontsize=12, fontweight="bold", pad=8)
    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    ax.tick_params(labelsize=9)


def discrete(ax):
    ax.set_xlim(-1.5, 3)
    ax.hlines(0, -1.5, 0, BLU, lw=2, zorder=3)
    ax.hlines(1 / 3, 0, 1, BLU, lw=2, zorder=3)
    ax.hlines(1, 1, 3, BLU, lw=2, zorder=3)
    ax.vlines(0, 0, 1 / 3, BLU, lw=1.5, zorder=3)
    ax.vlines(1, 1 / 3, 1, BLU, lw=1.5, zorder=3)
    ax.plot(0, 0, "o", color="white", markeredgecolor=BLU,
            markeredgewidth=1.5, ms=7, zorder=5)
    ax.plot(0, 1 / 3, "o", color=BLU, ms=6, zorder=5)
    ax.plot(1, 1 / 3, "o", color="white", markeredgecolor=BLU,
            markeredgewidth=1.5, ms=7, zorder=5)
    ax.plot(1, 1, "o", color=BLU, ms=6, zorder=5)
    ax.set_xticks([0, 1])
    style(ax, "Discrete")


def continuous(ax):
    x = np.linspace(-4, 4, 300)
    y = 1 / (1 + np.exp(-1.5 * x))
    ax.plot(x, y, BLU, lw=2.2, zorder=3)
    ax.set_xticks([-4, 0, 4])
    style(ax, "Continuous")


def mixed(ax):
    ax.set_xlim(-2, 4)
    ax.hlines(0, -2, 0, BLU, lw=2, zorder=3)
    x_c = np.linspace(0, 4, 200)
    y_c = 1 - 0.7 * np.exp(-0.8 * x_c)
    ax.plot(x_c, y_c, BLU, lw=2.2, zorder=3)
    ax.plot(0, 0, "o", color="white", markeredgecolor=BLU,
            markeredgewidth=1.5, ms=7, zorder=5)
    ax.plot(0, 0.3, "o", color=BLU, ms=6, zorder=5)
    ax.set_xticks([0])
    style(ax, "Mixed")


def build_figure():
    fig = SPEC.figure()
    discrete(fig.add_subplot(1, 3, 1))
    continuous(fig.add_subplot(1, 3, 2))
    mixed(fig.add_subplot(1, 3, 3))
    fig.text(0.5, 0.01, "discrete  /  continuous  /  mixed",
             fontsize=12, ha="center", color=DARK, style="italic")
    fig.subplots_adjust(wspace=0.38, bottom=0.12, top=0.90,
                        left=0.06, right=0.97)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "cdf-types")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
