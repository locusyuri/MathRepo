"""Comparison of common discrete distributions (2x3 grid, last cell empty).

  A: Binomial B(6, 0.3)                 blue stems, mode k=2
  B: Binom(20, 0.05) vs Poisson(1)      overlapping blue/red stems
  C: Geometric Geo(0.3), support k>=1   red, decreasing
  D: Negative Binomial NB(3, 0.4)       green, mode k=5
  E: Hypergeometric Hyp(30, 12, 6)      orange, mode near k=2

Run with: uv run python src/math_paper/common_discrete_distributions.py
"""

from __future__ import annotations

from dataclasses import replace
from math import comb, exp, factorial
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_TEXTBOOK, figsize=(13.0, 8.0))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#1f4e9b"
RED = "#c0392b"
GRN = "#27ae60"
ORG = "#e67e22"
INK = "#333333"
GRID = "#dddddd"


def binom_pmf(n: int, p: float, k: int) -> float:
    return comb(n, k) * p**k * (1 - p) ** (n - k)


def poisson_pmf(lam: float, k: int) -> float:
    return exp(-lam) * lam**k / factorial(k)


def geom_pmf(p: float, k: int) -> float:
    """Support k = 1, 2, ..."""
    return (1 - p) ** (k - 1) * p


def nbinom_pmf(r: int, p: float, k: int) -> float:
    """Number of trials until r successes: k = r, r+1, ..."""
    return comb(k - 1, r - 1) * p**r * (1 - p) ** (k - r)


def hyper_pmf(N: int, K: int, n: int, k: int) -> float:
    return comb(K, k) * comb(N - K, n - k) / comb(N, n)


def style_ax(ax, title, ylim, yticks):
    ax.set_title(title, fontsize=12, pad=8)
    ax.set_xlabel(r"$k$", fontsize=11, color=INK)
    ax.set_ylabel(r"$p(k)$", fontsize=11, color=INK)
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


def stems(ax, ks, ps, color, lw=2.0, ms=6, x_shift=0.0):
    ks = np.asarray(ks, dtype=float) + x_shift
    ax.vlines(ks, 0, ps, color=color, lw=lw, zorder=3)
    ax.plot(ks, ps, "o", color=color, ms=ms, zorder=4)


# -- A: Binomial --------------------------------------------------------------
def panel_binom(ax):
    ks = np.arange(0, 7)
    ps = np.array([binom_pmf(6, 0.3, int(k)) for k in ks])
    assert int(ks[np.argmax(ps)]) == 2
    stems(ax, ks, ps, BLU)
    ax.set_xlim(-0.6, 6.6)
    ax.set_xticks(ks)
    style_ax(ax, r"Binomial $B(6,\,0.3)$", (0, 0.35), np.arange(0, 0.36, 0.1))


# -- B: Poisson limit ---------------------------------------------------------
def panel_poisson_limit(ax):
    ks = np.arange(0, 9)
    pb = np.array([binom_pmf(20, 0.05, int(k)) for k in ks])
    pp = np.array([poisson_pmf(1.0, int(k)) for k in ks])
    stems(ax, ks, pb, BLU, x_shift=-0.12, lw=1.7, ms=5)
    stems(ax, ks, pp, RED, x_shift=0.12, lw=1.7, ms=5)
    ax.set_xlim(-0.7, 8.7)
    ax.set_xticks(ks)
    style_ax(ax, r"Poisson Limit ($n$ large, $p$ small)",
             (0, 0.40), np.arange(0, 0.41, 0.1))
    from matplotlib.lines import Line2D
    ax.legend(
        handles=[
            Line2D([0], [0], color=BLU, lw=1.7, marker="o", ms=5,
                   label=r"$\mathrm{Bin}(20, 0.05)$"),
            Line2D([0], [0], color=RED, lw=1.7, marker="o", ms=5,
                   label=r"$\mathrm{Pois}(1)$"),
        ],
        loc="upper right", fontsize=9, frameon=True,
        facecolor="white", edgecolor="#cccccc",
    )


# -- C: Geometric -------------------------------------------------------------
def panel_geom(ax):
    ks = np.arange(1, 9)
    ps = np.array([geom_pmf(0.3, int(k)) for k in ks])
    assert abs(ps[0] - 0.3) < 1e-12
    stems(ax, ks, ps, RED)
    ax.set_xlim(0.4, 8.6)
    ax.set_xticks(ks)
    style_ax(ax, r"Geometric $\mathrm{Geo}(0.3)$",
             (0, 0.35), np.arange(0, 0.36, 0.1))


# -- D: Negative binomial -----------------------------------------------------
def panel_nbinom(ax):
    ks = np.arange(3, 13)
    ps = np.array([nbinom_pmf(3, 0.4, int(k)) for k in ks])
    mode = int(ks[np.argmax(ps)])
    assert mode in (5, 6), mode
    stems(ax, ks, ps, GRN)
    ax.set_xlim(2.4, 12.6)
    ax.set_xticks(ks)
    style_ax(ax, r"Negative Binomial $\mathrm{NB}(3,\,0.4)$",
             (0, 0.16), np.arange(0, 0.17, 0.04))


# -- E: Hypergeometric --------------------------------------------------------
def panel_hyper(ax):
    ks = np.arange(0, 7)
    ps = np.array([hyper_pmf(30, 12, 6, int(k)) for k in ks])
    mode = int(ks[np.argmax(ps)])
    assert mode == 2, mode
    stems(ax, ks, ps, ORG)
    ax.set_xlim(-0.6, 6.6)
    ax.set_xticks(ks)
    style_ax(ax, r"Hypergeometric $\mathrm{Hyp}(30,\,12,\,6)$",
             (0, 0.35), np.arange(0, 0.36, 0.1))


def build_figure():
    fig = SPEC.figure()
    panel_binom(fig.add_subplot(2, 3, 1))
    panel_poisson_limit(fig.add_subplot(2, 3, 2))
    panel_geom(fig.add_subplot(2, 3, 3))
    panel_nbinom(fig.add_subplot(2, 3, 4))
    panel_hyper(fig.add_subplot(2, 3, 5))
    ax_empty = fig.add_subplot(2, 3, 6)
    ax_empty.axis("off")
    fig.subplots_adjust(wspace=0.32, hspace=0.48,
                        left=0.06, right=0.97, top=0.92, bottom=0.07)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "common-discrete-distributions")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
