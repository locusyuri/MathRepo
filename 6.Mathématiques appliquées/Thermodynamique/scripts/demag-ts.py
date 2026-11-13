"""Adiabatic demagnetization on a T-S diagram.

Two entropy curves (B=0 high-entropy, B=B1 low-entropy) merge at
S(0) = 0.2 as T -> 0 (Nernst theorem).  The two-step cooling cycle:
  1. Isothermal magnetization  (horizontal arrow at T1 = 0.8)
  2. Adiabatic demagnetization (vertical arrow down to T2 ~ 0.25)

Run with: uv run python src/math_paper/demag_ts.py
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
ORG = "#e67e22"
RED = "#E53935"
GRY = "#999999"
AXC = "#333333"


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)

    T = np.linspace(0, 1.0, 400)

    # -- entropy curves  S(T) = S0 + A sqrt(T) -------------------------- #
    S_b0 = 0.2 + 0.8 * np.sqrt(T)           # B = 0  (high entropy)
    S_b1 = 0.2 + 0.48 * np.sqrt(T)          # B = B1 (low entropy)

    ax.plot(S_b0, T, color=BLU, lw=2.2, zorder=3)
    ax.plot(S_b1, T, color=ORG, lw=2.2, zorder=3)

    # curve labels at top
    ax.text(1.01, 1.0, "B = 0", fontsize=11, color=BLU, fontweight="bold")
    ax.text(0.69, 1.0, r"B = $B_1$", fontsize=11, color=ORG,
            fontweight="bold")

    # -- grey dashed isotherms ------------------------------------------- #
    T1, T2 = 0.8, 0.25
    ax.axhline(T1, color=GRY, lw=0.7, ls="--", zorder=1)
    ax.axhline(T2, color=GRY, lw=0.7, ls="--", zorder=1)
    ax.text(-0.07, T1, r"$T_1$", fontsize=10, color=GRY, ha="right",
            va="center")
    ax.text(-0.07, T2, r"$T_2$", fontsize=10, color=GRY, ha="right",
            va="center")

    # -- cycle arrows ---------------------------------------------------- #
    akw = dict(arrowstyle="-|>", mutation_scale=20, lw=2.5)

    # 1: isothermal magnetization  (red, horizontal, leftward at T1)
    ax.annotate("", xy=(0.62, T1), xytext=(0.95, T1),
                arrowprops=dict(akw, color=RED), zorder=4)
    ax.text(0.60, 0.87, "1: isothermal magnetization\n(heat out)",
            fontsize=8.5, color=RED, ha="right", fontweight="bold")

    # 2: adiabatic demagnetization  (blue, vertical, downward)
    ax.annotate("", xy=(0.62, T2), xytext=(0.62, T1),
                arrowprops=dict(akw, color=BLU), zorder=4)
    ax.text(0.66, 0.52, "2: adiabatic\ndemagnetization",
            fontsize=8.5, color=BLU, fontweight="bold")

    # T2 label at the landing point
    ax.plot(0.62, T2, "ko", ms=5, zorder=5)
    ax.text(0.55, T2 - 0.06, r"$T_2$", fontsize=10, color=AXC,
            ha="center", fontweight="bold")

    # -- axes ------------------------------------------------------------ #
    ax.set_xlim(0, 1.1)
    ax.set_ylim(0, 1.05)
    ax.set_xlabel(r"$S$  (normalized)", fontsize=12)
    ax.set_ylabel(r"$T$  (normalized)", fontsize=12)

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
    path = SPEC.save(fig, OUT_DIR / "demag-ts")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
