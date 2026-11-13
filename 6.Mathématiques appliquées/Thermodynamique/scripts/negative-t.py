"""Negative temperature: entropy vs energy for a spin-1/2 system.

S(E)/(kB N ln 2) = -(1+x)/2 ln[(1+x)/2] - (1-x)/2 ln[(1-x)/2]
where x = E/(N mu B).

The curve is an inverted-U peaking at E = 0 (maximum entropy).
Left branch (E < 0): dS/dE > 0 => positive temperature.
Right branch (E > 0): dS/dE < 0 => negative temperature.

Run with: uv run python src/math_paper/negative_t.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, transparent=False)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#2196F3"
LBLU = "#d4e6f1"
RED = "#E53935"
LRED = "#fde0dc"
GRY = "#999999"
AXC = "#333333"


def S_of_x(x):
    """Dimensionless entropy  S / (kB N ln 2)."""
    s = np.zeros_like(x)
    m = (x > -1) & (x < 1)
    xp = (1 + x[m]) / 2
    xm = (1 - x[m]) / 2
    s[m] = -xp * np.log(xp + 1e-300) - xm * np.log(xm + 1e-300)
    return s


def dSdx_of_x(x):
    """dS/dx = (1/2) ln[(1-x)/(1+x)]."""
    return 0.5 * np.log((1 - x) / (1 + x))


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)

    x = np.linspace(-0.998, 0.998, 600)
    S = S_of_x(x)

    # -- branch shading -------------------------------------------------- #
    x_neg = x[x <= 0]
    x_pos = x[x >= 0]
    ax.fill_between(x_neg, 0, S_of_x(x_neg),
                    color=LBLU, alpha=0.35, zorder=0)
    ax.fill_between(x_pos, 0, S_of_x(x_pos),
                    color=LRED, alpha=0.35, zorder=0)

    ax.text(-0.60, 0.12, "positive-T branch", fontsize=9, color=BLU,
            ha="center", style="italic")
    ax.text(0.60, 0.12, "negative-T branch", fontsize=9, color=RED,
            ha="center", style="italic")

    # -- entropy curve --------------------------------------------------- #
    ax.plot(x, S, color=BLU, lw=2.5, zorder=3)

    # -- key points ------------------------------------------------------ #
    # E = -N mu B  (T = 0+, coldest)
    ax.plot(-1, 0, "ko", ms=6, zorder=5)
    ax.text(-0.85, 0.06, r"$T = 0^+$ (coldest)", fontsize=9, color=AXC)

    # E = 0  (T = +/- infinity)
    ax.plot(0, 1, "ko", ms=6, zorder=5)
    ax.annotate("", xy=(0.32, 1.0), xytext=(-0.32, 1.0),
                arrowprops=dict(arrowstyle="-", color=GRY, lw=1.2),
                zorder=2)
    ax.text(0.12, 1.04, r"$T = +\infty = -\infty$", fontsize=9,
            color=GRY)

    # E = +N mu B  (T = 0-, hottest)
    ax.plot(1, 0, "ko", ms=6, zorder=5)
    ax.text(0.45, 0.06, r"$T = 0^-$ (hottest)", fontsize=9, color=AXC)

    # -- tangent lines on the S(E) curve --------------------------------- #
    dd = 0.10  # half-extent in x
    for x0, label, color in [
        (-0.5, r"slope = $1/T > 0$", BLU),
        (+0.5, r"slope = $1/T < 0$", RED),
    ]:
        s0 = S_of_x(np.array([x0])).item()
        slope = dSdx_of_x(np.array([x0])).item()
        # tangent line on the S(E) curve:  x-axis = E, y-axis = S
        ax.plot([x0 - dd, x0 + dd],
                [s0 - slope * dd, s0 + slope * dd],
                color=GRY, lw=1.2, ls="--", zorder=4)
        ax.text(x0 + 0.15, s0 + 0.07, label,
                fontsize=8.5, color=color)

    # -- x-axis ticks ---------------------------------------------------- #
    ax.set_xticks([-1, 0, 1])
    ax.set_xticklabels([r"$-N\mu B$", "0", r"$+N\mu B$"])

    # -- axes ------------------------------------------------------------ #
    ax.set_xlim(-1.1, 1.1)
    ax.set_ylim(0, 1.15)
    ax.set_xlabel(r"$E$", fontsize=13)
    ax.set_ylabel(r"$S \,/\, (k_B N \ln 2)$", fontsize=12)

    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    for spine in ax.spines.values():
        spine.set_color(AXC)
        spine.set_linewidth(0.8)
    ax.tick_params(colors=AXC, labelsize=9)

    fig.subplots_adjust(left=0.12, right=0.96, bottom=0.10, top=0.96)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "negative-t")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
