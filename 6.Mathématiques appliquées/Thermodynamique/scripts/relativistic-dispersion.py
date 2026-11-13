"""Relativistic energy-momentum dispersion relation.

Single-panel E-p diagram comparing:
  - Exact relativistic:  E/(mc^2) = sqrt((p/mc)^2 + 1)
  - Non-relativistic:    E/(mc^2) = 1 + (p/mc)^2 / 2   (valid for p << mc)
  - Ultra-relativistic:  E/(mc^2) = p/(mc)              (asymptote for p >> mc)

Run with: uv run python src/math_paper/relativistic_dispersion.py
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

BLU = "#2962FF"
ORG = "#FF6D00"
GRY = "#999999"
AXC = "#333333"
LBLU = "#d4e6f1"
LORG = "#fff3e0"


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)

    p = np.linspace(0, 5, 500)

    # -- region shading -------------------------------------------------- #
    # non-relativistic region (lower-left)
    ax.fill([0, 1.5, 1.5, 0], [0, 0, 2.125, 2.125],
            color=LBLU, alpha=0.4, zorder=0)
    # ultra-relativistic region (upper-right)
    ax.fill([2.5, 5, 5, 2.5], [2.0, 2.0, 5.5, 5.5],
            color=LORG, alpha=0.4, zorder=0)

    # -- ultra-relativistic asymptote  E = p  (orange dashed) ----------- #
    ax.plot(p, p, color=ORG, lw=1.8, ls="--", zorder=2)

    # -- non-relativistic approx  E = 1 + p^2/2  (grey dashed) ---------- #
    p_nr = np.linspace(0, 2, 200)
    ax.plot(p_nr, 1 + 0.5 * p_nr ** 2, color=GRY, lw=1.8,
            ls="--", zorder=2)

    # -- exact relativistic  E = sqrt(p^2 + 1)  (blue solid) ----------- #
    ax.plot(p, np.sqrt(p ** 2 + 1), color=BLU, lw=2.5, zorder=3)

    # -- crossover vertical line at p = mc ------------------------------- #
    ax.axvline(1.0, color=GRY, lw=0.8, ls=":", zorder=1)
    ax.text(1.05, 4.8, "crossover  $p = mc$", fontsize=9, color=GRY,
            rotation=90, va="top")

    # -- region labels --------------------------------------------------- #
    ax.text(0.15, 0.35,
            "non-relativistic:\n$E \\approx mc^2 + p^2/2m$",
            fontsize=9, color=BLU, style="italic")
    ax.text(3.6, 4.8,
            "ultra-relativistic:\n$E \\approx pc$",
            fontsize=9, color=ORG, style="italic", ha="center")

    # -- curve labels ---------------------------------------------------- #
    ax.text(4.2, np.sqrt(4.2 ** 2 + 1) + 0.15,
            r"$\sqrt{p^2 c^2 + m^2 c^4}$", fontsize=10, color=BLU,
            fontweight="bold")
    ax.text(2.05, 1 + 0.5 * 2.0 ** 2 + 0.15,
            "NR approx", fontsize=8.5, color=GRY)
    ax.text(4.2, 4.2 - 0.35, "E = pc", fontsize=9, color=ORG)

    # -- axes ------------------------------------------------------------ #
    ax.set_xlim(0, 5)
    ax.set_ylim(0, 5.5)
    ax.set_xlabel(r"$p \,/\, mc$", fontsize=12)
    ax.set_ylabel(r"$E \,/\, mc^2$", fontsize=12)

    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    for spine in ax.spines.values():
        spine.set_color(AXC)
        spine.set_linewidth(0.8)
    ax.tick_params(colors=AXC, labelsize=9)

    fig.subplots_adjust(left=0.10, right=0.96, bottom=0.10, top=0.96)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "relativistic-dispersion")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
