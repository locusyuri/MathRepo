"""Skewness and kurtosis illustrated with density curves.

Two-panel white-background SVG figure:
  Left  — Skewness: three density curves sharing one axes.
    Blue solid   : positive skew (Exp shape, peak left, long right tail)
    Orange dashed: negative skew (reflected Exp, peak right, long left tail)
    Gray dash-dot: symmetric (standard normal, bell-shaped reference)
    Arrows annotate tail direction with gamma_1 sign.

  Right — Kurtosis: three standardized densities (mu=0, var=1).
    Blue solid   : mesokurtic  — Normal(0,1),        gamma_2 = 0
    Orange dashed: leptokurtic — Laplace(0,1/sqrt2), gamma_2 > 0
    Green dash-dot:platykurtic — Uniform(-sqrt3,sqrt3), gamma_2 < 0
    Shaded right-tail bands highlight tail-thickness differences.

Run with: uv run python src/math_paper/skewness_kurtosis.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

# -- custom spec: white-background, two-panel sans-serif ----------------- #
SPEC = replace(Presets.SVG_MATH_PANEL, transparent=False)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

# -- palette ------------------------------------------------------------- #
BLU = "#1f77b4"
ORG = "#e67e22"
GRN = "#2ca02c"
GRY = "#888888"
DK = "#222222"
FILL = "#d6d6d6"


# -- PDFs ---------------------------------------------------------------- #
def normal_pdf(x):
    """Standard normal N(0, 1)."""
    return np.exp(-0.5 * x ** 2) / np.sqrt(2 * np.pi)


def laplace_pdf(x):
    """Laplace(0, 1/sqrt(2))  —  zero mean, unit variance."""
    b = 1.0 / np.sqrt(2)
    return np.exp(-np.abs(x) / b) / (2 * b)


def uniform_pdf(x):
    """Uniform(-sqrt(3), sqrt(3))  —  zero mean, unit variance."""
    a = np.sqrt(3)
    return np.where(np.abs(x) <= a, 1.0 / (2 * a), 0.0)


# ========================================================================= #
#  Left panel — Skewness                                                    #
# ========================================================================= #
def panel_skewness(ax):
    x = np.linspace(-4.5, 5.5, 600)

    # symmetric reference (standard normal)
    ax.plot(x, normal_pdf(x), color=GRY, lw=1.6, ls="-.",
            label=r"Symmetric  $\gamma_1 = 0$", zorder=3)

    # positive skew  —  Exp(lambda=1),  f(x) = e^{-x},  x >= 0
    xp = x[x >= 0]
    ax.plot(xp, np.exp(-xp), color=BLU, lw=2.2,
            label=r"Positive skew  $\gamma_1 > 0$", zorder=4)

    # negative skew  —  reflected Exp,  f(x) = e^{x},  x <= 0
    xn = x[x <= 0]
    ax.plot(xn, np.exp(xn), color=ORG, lw=2.2, ls="--",
            label=r"Negative skew  $\gamma_1 < 0$", zorder=4)

    # --- arrows annotating tail direction --------------------------------
    # positive skew: arrow in right tail region
    ax.annotate(
        "", xy=(3.8, 0.10), xytext=(2.2, 0.10),
        arrowprops=dict(arrowstyle="-|>", color=BLU, lw=1.8,
                        mutation_scale=18),
        zorder=5,
    )
    ax.text(3.0, 0.16, r"$\gamma_1 > 0$", fontsize=10, color=BLU,
            ha="center", fontweight="bold")

    # negative skew: arrow in left tail region
    ax.annotate(
        "", xy=(-3.8, 0.10), xytext=(-2.2, 0.10),
        arrowprops=dict(arrowstyle="-|>", color=ORG, lw=1.8,
                        mutation_scale=18),
        zorder=5,
    )
    ax.text(-3.0, 0.16, r"$\gamma_1 < 0$", fontsize=10, color=ORG,
            ha="center", fontweight="bold")

    # symmetric: centred label
    ax.text(0, 0.46, r"$\gamma_1 = 0$", fontsize=10, color=GRY,
            ha="center", fontweight="bold")

    # --- axes styling ----------------------------------------------------
    ax.set_xlim(-4.5, 5.5)
    ax.set_ylim(-0.02, 1.10)
    ax.set_xlabel("x", fontsize=11)
    ax.set_ylabel("Density", fontsize=11)
    ax.set_title("Skewness", fontsize=13, fontweight="bold", pad=10)
    ax.legend(fontsize=8.5, frameon=False, loc="upper right")
    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    ax.tick_params(labelsize=9)


# ========================================================================= #
#  Right panel — Kurtosis                                                   #
# ========================================================================= #
def panel_kurtosis(ax):
    x = np.linspace(-4, 4, 600)

    pdf_n = normal_pdf(x)
    pdf_l = laplace_pdf(x)
    pdf_u = uniform_pdf(x)

    # --- shaded right-tail bands (beyond x = 2) --------------------------
    tail = x >= 2
    ax.fill_between(x[tail], 0, pdf_n[tail],
                    color=BLU, alpha=0.18, zorder=1)
    ax.fill_between(x[tail], 0, pdf_l[tail],
                    color=ORG, alpha=0.18, zorder=1)
    ax.fill_between(x[tail], 0, pdf_u[tail],
                    color=GRN, alpha=0.18, zorder=1)

    # vertical dashed line marking the tail region boundary
    ax.axvline(2, color=DK, lw=0.6, ls=":", alpha=0.5, zorder=0)
    ax.text(2.08, 0.38, "tail", fontsize=8, color=DK, alpha=0.6,
            style="italic")

    # --- three curves ----------------------------------------------------
    ax.plot(x, pdf_n, color=BLU, lw=2.2,
            label=r"Mesokurtic  $\gamma_2 = 0$", zorder=3)
    ax.plot(x, pdf_l, color=ORG, lw=2.0, ls="--",
            label=r"Leptokurtic  $\gamma_2 > 0$", zorder=3)
    ax.plot(x, pdf_u, color=GRN, lw=2.0, ls="-.",
            label=r"Platykurtic  $\gamma_2 < 0$", zorder=3)

    # --- axes styling ----------------------------------------------------
    ax.set_xlim(-4, 4)
    ax.set_ylim(-0.01, 0.65)
    ax.set_xlabel("x  (standardised)", fontsize=11)
    ax.set_ylabel("Density", fontsize=11)
    ax.set_title("Kurtosis", fontsize=13, fontweight="bold", pad=10)
    ax.legend(fontsize=8.5, frameon=False, loc="upper right")
    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    ax.tick_params(labelsize=9)


# ========================================================================= #
#  Assemble & save                                                          #
# ========================================================================= #
def build_figure():
    fig = SPEC.figure()
    panel_skewness(fig.add_subplot(1, 2, 1))
    panel_kurtosis(fig.add_subplot(1, 2, 2))
    fig.subplots_adjust(wspace=0.32, bottom=0.14, top=0.90,
                        left=0.07, right=0.97)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "skewness-kurtosis")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
