"""Burgers equation characteristics crossing in the xt-plane.

For u_t + u u_x = 0 the characteristics are straight lines
  x(t) = u0(s) t + s.
When u0 is decreasing the characteristics converge and intersect,
signalling gradient catastrophe (shock formation).

Six characteristics with u0(s) = -s / t_break so that all lines
meet exactly at (x, t) = (0, 5/3) ~ (0, 1.7).

Run with: uv run python src/math_paper/characteristics_crossing.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

# ~500x400 px at screen DPI 96 -> inches
SPEC = replace(
    Presets.SVG_MATH,
    figsize=(5.2, 4.2),
    transparent=False,
)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#2196F3"
RED = "#E53935"
AXC = "#333333"
GRY = "#999999"


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)

    # -- characteristic parameters --------------------------------------- #
    s_vals = np.array([-2.5, -1.5, -0.5, 0.5, 1.5, 2.5])
    t_break = 5.0 / 3.0
    u_vals = -s_vals / t_break  # decreasing profile

    t = np.linspace(0, 3.5, 300)

    # -- draw six characteristic lines ----------------------------------- #
    for s, u in zip(s_vals, u_vals):
        ax.plot(s + u * t, t, color=BLU, lw=1.5, zorder=2)

    # -- crossing point -------------------------------------------------- #
    ax.plot(0, t_break, "o", color=RED, ms=6, zorder=5)

    # -- shock (red dashed upward from crossing) ------------------------- #
    ax.plot([0, 0], [t_break, 3.5], color=RED, lw=1.5,
            ls=(0, (4, 3)), zorder=4)

    # -- t^break horizontal guide ---------------------------------------- #
    ax.axhline(t_break, color=GRY, lw=0.8, ls="--", zorder=1)
    ax.text(0.12, t_break + 0.08, r"$t^{\mathrm{break}}$",
            fontsize=10, color=GRY, va="bottom")

    # -- annotation ------------------------------------------------------ #
    ax.text(1.4, 1.15, "Characteristics\nconverge",
            fontsize=10, color=AXC, ha="center")

    # -- axes styling ---------------------------------------------------- #
    ax.set_xlim(-3, 3)
    ax.set_ylim(0, 3.5)
    ax.set_xlabel(r"$x$", fontsize=12)
    ax.set_ylabel(r"$t$", fontsize=12)

    for spine in ax.spines.values():
        spine.set_color(AXC)
        spine.set_linewidth(0.8)
    ax.tick_params(colors=AXC, labelsize=9)
    for s in ("top", "right"):
        ax.spines[s].set_visible(False)

    fig.subplots_adjust(left=0.14, right=0.96, bottom=0.14, top=0.96)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "characteristics-crossing")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
