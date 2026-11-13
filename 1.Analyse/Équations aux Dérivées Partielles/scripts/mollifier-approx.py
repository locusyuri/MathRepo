"""Mollifier approximation to the Heaviside step function.

Two-panel SVG illustrating convolution smoothing:
  Left  -- H(x) (blue step) and mollifier rho_eps(x) (red bell)
  Right -- H * rho_eps (green S-curve) with H(x) as dashed reference

Standard mollifier:  rho(u) = C exp(-1/(1-u^2))  for |u| < 1
Scaled:              rho_eps(x) = (1/eps) rho(x/eps),   eps = 0.5
Convolution:         (H * rho_eps)(x) = integral_{-1}^{(x+eps)/eps} rho(u) du

Run with: uv run python src/math_paper/mollifier_approx.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(
    Presets.SVG_MATH_PANEL,
    figsize=(13.5, 4.2),
    transparent=False,
)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#2962FF"
RED = "#D50000"
GRN = "#00C853"
AXC = "#000000"
GRY = "#E0E0E0"

EPS = 0.5


# -- mollifier ----------------------------------------------------------- #
def rho(u):
    """Standard mollifier on [-1, 1]."""
    out = np.zeros_like(u, dtype=float)
    m = np.abs(u) < 1.0
    out[m] = np.exp(-1.0 / (1.0 - u[m] ** 2))
    C_inv = np.trapezoid(out, u)      # normalisation
    return out / C_inv


def rho_eps(x):
    """Scaled mollifier (1/eps) rho(x/eps)."""
    return rho(x / EPS) / EPS


# -- Heaviside ----------------------------------------------------------- #
def H(x):
    return np.where(x >= 0, 1.0, 0.0)


# -- convolution via CDF of mollifier ------------------------------------ #
def H_conv(x):
    """(H * rho_eps)(x) = F((x+eps)/eps) where F is CDF of rho."""
    u_fine = np.linspace(-1.5, 1.5, 2000)
    r = rho(u_fine)
    F = np.zeros_like(u_fine)
    F[1:] = np.cumsum(0.5 * (r[:-1] + r[1:]) * np.diff(u_fine))
    return np.interp((x + EPS) / EPS, u_fine, F)


# ========================================================================= #
#  Left panel                                                               #
# ========================================================================= #
def panel_left(ax):
    x = np.linspace(-3, 3, 800)

    # Heaviside  (split to avoid vertical line at jump)
    ax.plot(x[x < 0], H(x[x < 0]), color=BLU, lw=2, zorder=3)
    ax.plot(x[x > 0], H(x[x > 0]), color=BLU, lw=2, zorder=3)
    # jump markers
    ax.plot(0, 0, "o", color="white", markeredgecolor=BLU,
            markeredgewidth=1.5, ms=6, zorder=5)
    ax.plot(0, 1, "o", color=BLU, ms=5, zorder=5)

    # mollifier
    ax.plot(x, rho_eps(x), color=RED, lw=2, ls="--", zorder=3)

    # labels
    ax.text(2.6, 0.55, r"$\rho_\epsilon(x)$", fontsize=11,
            color=RED, fontweight="bold")
    ax.text(2.6, 1.15, r"$H(x)$", fontsize=11, color=BLU,
            fontweight="bold")

    ax.set_xlim(-3, 3)
    ax.set_ylim(-0.5, 2.5)
    ax.set_xticks([-2, -1, 0, 1, 2])
    ax.set_yticks([0, 1, 2])
    ax.set_xlabel(r"$x$", fontsize=12, loc="right")
    ax.set_ylabel(r"$y$", fontsize=12, loc="top", rotation=0)
    ax.set_title("Original + mollifier", fontsize=12,
                 fontweight="bold", color=AXC, pad=8)
    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    ax.tick_params(labelsize=9)


# ========================================================================= #
#  Right panel                                                              #
# ========================================================================= #
def panel_right(ax):
    x = np.linspace(-3, 3, 500)
    hc = H_conv(x)

    # H(x) as light dashed reference
    ax.plot(x[x < 0], H(x[x < 0]), color=BLU, lw=1.2, ls="--",
            alpha=0.45, zorder=2)
    ax.plot(x[x > 0], H(x[x > 0]), color=BLU, lw=1.2, ls="--",
            alpha=0.45, zorder=2)

    # smoothed approximation
    ax.plot(x, hc, color=GRN, lw=2.5, zorder=3)

    # labels
    ax.text(1.6, 0.85, r"$H * \rho_\epsilon$", fontsize=11,
            color=GRN, fontweight="bold")
    ax.text(2.5, 0.15, r"$H(x)$", fontsize=10, color=BLU,
            alpha=0.6, style="italic")

    ax.set_xlim(-3, 3)
    ax.set_ylim(-0.2, 1.2)
    ax.set_xticks([-2, -1, 0, 1, 2])
    ax.set_yticks([0, 0.5, 1])
    ax.set_xlabel(r"$x$", fontsize=12, loc="right")
    ax.set_ylabel(r"$y$", fontsize=12, loc="top", rotation=0)
    ax.set_title("Convolution  $H * \\rho_\\epsilon$", fontsize=12,
                 fontweight="bold", color=AXC, pad=8)
    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    ax.tick_params(labelsize=9)


# ========================================================================= #
#  Assemble & save                                                          #
# ========================================================================= #
def build_figure():
    fig = SPEC.figure()
    panel_left(fig.add_subplot(1, 2, 1))
    panel_right(fig.add_subplot(1, 2, 2))
    fig.subplots_adjust(wspace=0.35, bottom=0.13, top=0.88,
                        left=0.07, right=0.97)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "mollifier-approx")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
