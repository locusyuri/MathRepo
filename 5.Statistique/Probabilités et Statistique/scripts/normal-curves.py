"""Normal distribution curves with 3-sigma band.

Three normal PDFs on one panel:
  N(0,1)  blue solid   — standard normal
  N(0,2)  orange dash  — wider, shorter
  N(1,1)  green dash-dot — shifted right
Shaded 3-sigma band [-3, 3] under N(0,1).

Run with: uv run python src/math_paper/normal_curves.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(9, 5.5), transparent=False)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#4a90d9"
LBLU = "#a8dadc"
ORG = "#e67e22"
GRN = "#2ca02c"
DARK = "#222222"
GRY = "#888888"


def normal_pdf(x, mu, sigma):
    return (1 / (sigma * np.sqrt(2 * np.pi))
            * np.exp(-0.5 * ((x - mu) / sigma) ** 2))


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)

    x = np.linspace(-5, 6, 500)

    # 3-sigma shading under N(0,1)
    x_fill = np.linspace(-3, 3, 300)
    ax.fill_between(x_fill, 0, normal_pdf(x_fill, 0, 1),
                    color=LBLU, alpha=0.45, zorder=1)

    # Three curves
    ax.plot(x, normal_pdf(x, 0, 1), BLU, lw=2.2,
            label=r"$\mathcal{N}(0,\,1)$", zorder=3)
    ax.plot(x, normal_pdf(x, 0, 2), ORG, lw=1.8, ls="--",
            label=r"$\mathcal{N}(0,\,2^2)$", zorder=3)
    ax.plot(x, normal_pdf(x, 1, 1), GRN, lw=1.8, ls="-.",
            label=r"$\mathcal{N}(1,\,1)$", zorder=3)

    # 3-sigma boundary lines
    ax.vlines([-3, 3], 0, normal_pdf(np.array([-3, 3]), 0, 1),
              color=BLU, lw=1.0, ls="--", alpha=0.7, zorder=2)

    ax.text(0, 0.04, r"$\approx 99.7\%$", fontsize=12, color=BLU,
            ha="center", va="bottom", fontweight="bold", zorder=5)

    ax.legend(fontsize=11, frameon=False, loc="upper right")
    ax.set_xlabel(r"$x$", fontsize=12)
    ax.set_ylabel(r"$f(x)$", fontsize=12)
    ax.set_title(r"Normal distribution $\mathcal{N}(\mu,\,\sigma^2)$",
                 fontsize=13, fontweight="bold", pad=10)
    ax.set_xlim(-5, 6)
    ax.set_ylim(0, 0.5)

    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    ax.tick_params(labelsize=9)

    fig.subplots_adjust(left=0.10, right=0.95, bottom=0.12, top=0.90)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "normal-curves")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
