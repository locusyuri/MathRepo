"""Work is path-dependent: three quasi-static paths on a p-V diagram.

Left panel of <fig:work-path>.  Three paths connect state 1 (1,1) to
state 2 (3, 1/3) on the isotherm p = 1/V (nRT = 1).

  Path A (blue solid)  : along the isotherm p = 1/V
  Path B (orange solid): isobar p = 1 then isochor V = 3
  Path C (green dashed): arbitrary smooth curve bowing upward

Shaded regions under each path illustrate W_A < W_C < W_B.

Run with: uv run python src/math_paper/work_path_left.py
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
LBLU = "#2196F3"
ORG = "#e67e22"
LORG = "#e67e22"
GRN = "#2ca02c"
LGRN = "#2ca02c"
AXC = "#333333"


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)

    V1, p1 = 1.0, 1.0
    V2, p2 = 3.0, 1.0 / 3.0

    # -- background isotherm (thin grey) --------------------------------- #
    V_iso = np.linspace(0.35, 4.2, 400)
    ax.plot(V_iso, 1.0 / V_iso, color="#cccccc", lw=0.8, zorder=1)

    # -- Path A: isotherm p = 1/V  (blue) -------------------------------- #
    V_a = np.linspace(V1, V2, 200)
    p_a = 1.0 / V_a
    ax.fill_between(V_a, 0, p_a, color=LBLU, alpha=0.25, zorder=0)
    ax.plot(V_a, p_a, color=BLU, lw=2.0, zorder=3)

    # -- Path B: isobar p=1 then isochor V=3  (orange) ------------------- #
    V_b = np.array([V1, V2, V2])
    p_b = np.array([p1, p1, p2])
    ax.fill_between(V_b, 0, p_b, step="post", color=LORG, alpha=0.25,
                    zorder=0)
    ax.plot(V_b, p_b, color=ORG, lw=2.0, zorder=3)

    # -- Path C: arbitrary curve  p = (1/V) * (V/3)^0.3  (green dashed) -- #
    V_c = np.linspace(V1, V2, 200)
    p_c = (1.0 / V_c) * (V_c / 3.0) ** 0.3
    ax.fill_between(V_c, 0, p_c, color=LGRN, alpha=0.25, zorder=0)
    ax.plot(V_c, p_c, color=GRN, lw=2.0, ls="--", zorder=3)

    # -- states 1 & 2 ---------------------------------------------------- #
    ax.plot([V1, V2], [p1, p2], "ko", ms=6, zorder=5)
    ax.text(V1 - 0.05, p1 + 0.10, "1", fontsize=12, fontweight="bold",
            color=AXC, ha="center")
    ax.text(V2 + 0.15, p2 + 0.06, "2", fontsize=12, fontweight="bold",
            color=AXC, ha="left")

    # -- path labels ----------------------------------------------------- #
    ax.text(1.6, 0.55, "A", fontsize=13, fontweight="bold", color=BLU)
    ax.text(2.1, 1.12, "B", fontsize=13, fontweight="bold", color=ORG)
    ax.text(1.7, 0.28, "C", fontsize=13, fontweight="bold", color=GRN)

    # -- axes ------------------------------------------------------------ #
    ax.set_xlim(0, 4.2)
    ax.set_ylim(0, 4.2)
    ax.set_xlabel(r"$V$", fontsize=13)
    ax.set_ylabel(r"$p$", fontsize=13)

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
    path = SPEC.save(fig, OUT_DIR / "work-path-left")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
