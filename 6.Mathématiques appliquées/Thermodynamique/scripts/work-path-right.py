"""Adiabatic vs isothermal compression on a p-V diagram.

Right panel of <fig:work-path>.  An isotherm (pV = 1) and an adiabat
(pV^{5/3} = 1) both pass through state 1 = (1, 1).  Compression from
V = 1 to V = 0.6 reaches a higher final pressure along the adiabat
(p ~ 2.15) than along the isotherm (p ~ 1.67), and the adiabat is
steeper at the intersection because |dp/dV|_ad = gamma/V = 5/3
versus |dp/dV|_iso = 1/V = 1.

Run with: uv run python src/math_paper/work_path_right.py
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

GAMMA = 5.0 / 3.0


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)

    # -- full curves (light) --------------------------------------------- #
    V_bg = np.linspace(0.45, 3.5, 500)
    ax.plot(V_bg, 1.0 / V_bg, color=BLU, lw=1.0, alpha=0.4, zorder=1)
    ax.plot(V_bg, V_bg ** (-GAMMA), color=ORG, lw=1.0, alpha=0.4, zorder=1)

    # -- highlighted compression segments -------------------------------- #
    V_seg = np.linspace(0.6, 1.0, 200)

    # isotherm segment  1 -> 2
    p_iso = 1.0 / V_seg
    ax.plot(V_seg, p_iso, color=BLU, lw=2.5, zorder=3)
    # arrowhead at compression end (V = 0.6)
    ax.annotate("", xy=(0.6, p_iso[0]),
                xytext=(0.72, 1.0 / 0.72),
                arrowprops=dict(arrowstyle="-|>", color=BLU, lw=2.0,
                                mutation_scale=18),
                zorder=4)

    # adiabat segment  1 -> 2'
    p_adi = V_seg ** (-GAMMA)
    ax.plot(V_seg, p_adi, color=ORG, lw=2.5, zorder=3)
    ax.annotate("", xy=(0.6, p_adi[0]),
                xytext=(0.72, 0.72 ** (-GAMMA)),
                arrowprops=dict(arrowstyle="-|>", color=ORG, lw=2.0,
                                mutation_scale=18),
                zorder=4)

    # -- state points ---------------------------------------------------- #
    ax.plot([1.0], [1.0], "ko", ms=6, zorder=5)
    ax.text(1.06, 1.0 + 0.10, "1", fontsize=12, fontweight="bold",
            color=AXC)

    V2 = 0.6
    p2_iso = 1.0 / V2          # ~ 1.667
    p2_adi = V2 ** (-GAMMA)    # ~ 2.153

    ax.plot([V2], [p2_iso], "ko", ms=6, zorder=5)
    ax.text(V2 - 0.22, p2_iso + 0.08, "2", fontsize=12,
            fontweight="bold", color=AXC)

    ax.plot([V2], [p2_adi], "ko", ms=6, zorder=5)
    ax.text(V2 - 0.30, p2_adi + 0.08, "2'", fontsize=12,
            fontweight="bold", color=AXC)

    # -- vertical dashed line connecting 2 and 2' ------------------------ #
    ax.plot([V2, V2], [p2_iso, p2_adi], color=GRY, lw=1.0, ls="--",
            zorder=2)
    ax.text(V2 + 0.06, (p2_iso + p2_adi) / 2.0,
            r"$p_{2'} > p_2$", fontsize=9, color=AXC, va="center")

    # -- legend ---------------------------------------------------------- #
    ax.plot([], [], color=ORG, lw=2.0,
            label=r"$pV^\gamma = \mathrm{const}$  (adiabat, steep)")
    ax.plot([], [], color=BLU, lw=2.0,
            label=r"$pV = \mathrm{const}$  (isotherm)")
    ax.legend(fontsize=8.5, frameon=False, loc="upper right")

    # -- axes ------------------------------------------------------------ #
    ax.set_xlim(0, 3.5)
    ax.set_ylim(0, 3.5)
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
    path = SPEC.save(fig, OUT_DIR / "work-path-right")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
