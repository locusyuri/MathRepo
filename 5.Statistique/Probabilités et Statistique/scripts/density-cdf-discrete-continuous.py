"""CDF as cumulative mass/density: discrete vs continuous (2x2 panels).

  - top-left:    PMF of Binomial B(8, 0.3), blue stems
  - top-right:   right-continuous step CDF of B(8, 0.3), red
  - bottom-left: standard normal PDF phi(x), blue, area filled
  - bottom-right: standard normal CDF Phi(x), red S-curve

Run with: uv run python src/math_paper/density_cdf_discrete_continuous.py
"""

from __future__ import annotations

from dataclasses import replace
from math import comb, erf, sqrt
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_TEXTBOOK, figsize=(10.0, 8.4))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#1f4e9b"
RED = "#c0392b"
FILL = "#aed3f0"
INK = "#333333"
GRID = "#dddddd"

N, P = 8, 0.3


def binom_pmf(n: int, p: float, k: int) -> float:
    return comb(n, k) * p**k * (1 - p) ** (n - k)


def style_ax(ax, title, xlabel, ylabel, ylim):
    ax.set_title(title, fontsize=13, pad=8)
    ax.set_xlabel(xlabel, fontsize=12, color=INK)
    ax.set_ylabel(ylabel, fontsize=12, color=INK)
    ax.set_ylim(*ylim)
    ax.axhline(0, color=INK, lw=0.8, zorder=1)
    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    for s in ("left", "bottom"):
        ax.spines[s].set_color(INK)
        ax.spines[s].set_linewidth(0.9)
    ax.tick_params(labelsize=10, colors=INK)


# -- panel 1: discrete PMF ----------------------------------------------------
def panel_pmf(ax):
    ks = np.arange(0, N + 1)
    ps = np.array([binom_pmf(N, P, int(k)) for k in ks])
    assert abs(ps.max() - binom_pmf(N, P, 2)) < 1e-12  # mode at k = 2
    ax.vlines(ks, 0, ps, color=BLU, lw=2.0, zorder=3)
    ax.plot(ks, ps, "o", color=BLU, ms=6, zorder=4)
    ax.set_xlim(-0.6, N + 0.6)
    ax.set_xticks(ks)
    ax.set_yticks(np.arange(0, 0.36, 0.1))
    style_ax(ax, "Discrete PMF", r"$k$", r"$p(k)$", (0, 0.35))


# -- panel 2: discrete CDF ----------------------------------------------------
def panel_cdf_discrete(ax):
    ks = np.arange(0, N + 1)
    ps = np.array([binom_pmf(N, P, int(k)) for k in ks])
    cdf = np.cumsum(ps)
    assert abs(cdf[-1] - 1.0) < 1e-12

    x0, x1 = -0.6, N + 0.6
    # horizontal segments, right-continuous
    ax.hlines(0, x0, ks[0], color=RED, lw=2.0, zorder=3)
    for i, k in enumerate(ks):
        right = ks[i + 1] if i + 1 < len(ks) else x1
        ax.hlines(cdf[i], k, right, color=RED, lw=2.0, zorder=3)
    # closed dot at right end of each step, open dot at left end (jump points)
    for i, k in enumerate(ks):
        ax.plot(k, cdf[i], "o", color=RED, ms=6, zorder=5)
        left_val = 0.0 if i == 0 else cdf[i - 1]
        ax.plot(k, left_val, "o", mfc="white", mec=RED, mew=1.4,
                ms=6.5, zorder=5)
    ax.set_xlim(x0, x1)
    ax.set_xticks(ks)
    ax.set_yticks(np.arange(0, 1.01, 0.2))
    style_ax(ax, "Discrete CDF", r"$k$", r"$F(k)$", (0, 1.02))
    ax.text(0.94, 0.12, r"$F(x)$", transform=ax.transAxes, ha="right",
            fontsize=14, color=RED)


# -- panel 3: continuous PDF --------------------------------------------------
def panel_pdf(ax):
    x = np.linspace(-4, 4, 401)
    pdf = np.exp(-0.5 * x**2) / sqrt(2 * np.pi)
    assert abs(pdf.max() - 1 / sqrt(2 * np.pi)) < 1e-12  # peak ~0.399 at x=0
    ax.fill_between(x, 0, pdf, color=FILL, alpha=0.45, zorder=1)
    ax.plot(x, pdf, color=BLU, lw=2.2, zorder=3)
    ax.set_xlim(-4, 4)
    ax.set_xticks([-2, -1, 0, 1, 2])
    ax.set_yticks(np.arange(0, 0.41, 0.1))
    style_ax(ax, "Continuous PDF", r"$x$", r"$f(x)$", (0, 0.44))
    ax.text(1.15, 0.20, r"$\int f(x)\,\mathrm{d}x$", fontsize=13,
            color=BLU)


# -- panel 4: continuous CDF --------------------------------------------------
def panel_cdf_continuous(ax):
    x = np.linspace(-4, 4, 401)
    cdf = 0.5 * (1.0 + np.array([erf(v / sqrt(2)) for v in x]))
    assert abs(cdf[np.argmin(abs(x))] - 0.5) < 1e-12
    ax.plot(x, cdf, color=RED, lw=2.2, zorder=3)
    ax.plot(0, 0.5, "o", color=RED, ms=5, zorder=4)
    ax.axhline(0, color=INK, lw=0.6, ls=":", zorder=1)
    ax.axhline(1, color=INK, lw=0.6, ls=":", zorder=1)
    ax.set_xlim(-4, 4)
    ax.set_xticks([-2, -1, 0, 1, 2])
    ax.set_yticks(np.arange(0, 1.01, 0.2))
    style_ax(ax, "Continuous CDF", r"$x$", r"$F(x)$", (0, 1.02))
    ax.text(0.94, 0.12, r"$\Phi(x)$", transform=ax.transAxes, ha="right",
            fontsize=14, color=RED)


def build_figure():
    fig = SPEC.figure()
    panel_pmf(fig.add_subplot(2, 2, 1))
    panel_cdf_discrete(fig.add_subplot(2, 2, 2))
    panel_pdf(fig.add_subplot(2, 2, 3))
    panel_cdf_continuous(fig.add_subplot(2, 2, 4))
    fig.subplots_adjust(wspace=0.30, hspace=0.42,
                        left=0.08, right=0.97, top=0.92, bottom=0.08)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "density-cdf-discrete-continuous")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
