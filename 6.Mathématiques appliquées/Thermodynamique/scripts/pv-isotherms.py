"""p-V diagram: ideal gas and van der Waals isotherms.

Single-panel SVG comparing:
  - Ideal gas isotherms  p = T/V  (blue, T = 0.5, 1.0, 1.5)
  - van der Waals isotherms (orange):
      supercritical  T = 1.5 T_c  (smooth, monotone)
      subcritical    T = 0.85 T_c (van der Waals loop + Maxwell line)
  - Critical point marked with red star
  - Maxwell equal-area construction shown as horizontal dashed line

All quantities in dimensionless units (V = V_hat, p = p_hat) where
the critical point sits at (V_c, p_c) = (3, 1/27).

vdW equation:  p = T/(V - 1) - 27/(16 V^2)
  (derived from  p = a/V^2 - nb/(V-nb)  with a = 27b^2 p_c,
   b = V_c/3,  T_c = 8a/(27b),  and setting n = 1.)

Run with: uv run python src/math_paper/pv_isotherms.py
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

# Critical point in dimensionless units
V_C = 3.0
P_C = 1.0 / 27.0


# -- van der Waals EOS in dimensionless form ----------------------------- #
def p_vdw(V, T_tilde):
    """p = T/(V-1) - 27/(16 V^2)   (b_eff = 1,  a_eff = 27/16)."""
    return T_tilde / (V - 1.0) - 27.0 / (16.0 * V ** 2)


# -- Maxwell equal-area construction ------------------------------------- #
def maxwell_construction(T_tilde, V_min=1.05, V_max=20.0, n_v=5000):
    """Find coexistence pressure and volumes via equal-area rule.

    Returns (V_liq, V_gas, p_coex).
    """
    V_arr = np.linspace(V_min, V_max, n_v)
    p_arr = p_vdw(V_arr, T_tilde)

    p_lo = float(np.min(p_arr)) + 1e-8
    p_hi = float(np.max(p_arr)) - 1e-8

    for _ in range(120):
        p_mid = 0.5 * (p_lo + p_hi)
        mask = p_arr >= p_mid
        if not np.any(mask):
            p_lo = p_mid
            continue
        idx = np.where(mask)[0]
        V1, V2 = V_arr[idx[0]], V_arr[idx[-1]]
        # equal-area integral: int_{V1}^{V2} (p - p_mid) dV = 0
        segment_p = p_arr[idx[0]:idx[-1] + 1]
        segment_V = V_arr[idx[0]:idx[-1] + 1]
        area = np.trapezoid(segment_p - p_mid, segment_V)
        if area > 0:
            p_lo = p_mid
        else:
            p_hi = p_mid

    p_coex = 0.5 * (p_lo + p_hi)
    mask = p_arr >= p_coex
    idx = np.where(mask)[0]
    return V_arr[idx[0]], V_arr[idx[-1]], p_coex


# ========================================================================= #
#  Build figure                                                             #
# ========================================================================= #
def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)

    V = np.linspace(0.4, 4.0, 800)

    # -- ideal gas isotherms  p = T/V  (blue) ----------------------------
    for T_ig, ls in [(0.5, "-"), (1.0, "-"), (1.5, "-")]:
        ax.plot(V, T_ig / V, color=BLU, lw=1.5, ls=ls, zorder=2)

    # -- van der Waals: supercritical T = 1.5 T_c  (orange) --------------
    ax.plot(V, p_vdw(V, 1.5), color=ORG, lw=2.0, zorder=3)

    # -- van der Waals: subcritical T = 0.85 T_c  (orange dashed) --------
    T_sub = 0.85
    ax.plot(V, p_vdw(V, T_sub), color=ORG, lw=2.0, ls="--", zorder=3)

    # -- Maxwell construction for subcritical isotherm ------------------- #
    V_liq, V_gas, p_coex = maxwell_construction(T_sub)
    ax.hlines(p_coex, V_liq, V_gas, color=GRY, lw=1.2,
              ls="-.", zorder=4)

    # -- critical point (red star) --------------------------------------- #
    ax.plot(V_C, P_C, "*", color=RED, ms=12, zorder=5)

    # dashed lines from critical point to axes
    ax.axvline(V_C, ymin=P_C / 2.5 * 0, ymax=P_C / 2.5,
               color=GRY, lw=0.7, ls="--", zorder=1)
    ax.plot([V_C, V_C], [0, P_C], color=GRY, lw=0.7, ls="--", zorder=1)
    ax.plot([0, V_C], [P_C, P_C], color=GRY, lw=0.7, ls="--", zorder=1)

    # axis labels for critical values
    ax.text(V_C + 0.05, 0.02, r"$V_c$", fontsize=10, color=AXC,
            ha="left", va="bottom")
    ax.text(0.42, P_C + 0.01, r"$p_c$", fontsize=10, color=AXC,
            ha="left", va="bottom")

    # -- curve labels (at right edge) ------------------------------------ #
    # ideal gas
    for T_ig, y_edge in [(0.5, 0.5 / 4.0), (1.0, 1.0 / 4.0),
                          (1.5, 1.5 / 4.0)]:
        ax.text(4.02, y_edge, f"ideal  $T={T_ig}$",
                fontsize=8, color=BLU, va="center")

    # supercritical vdW
    ax.text(4.02, p_vdw(np.array([4.0]), 1.5)[0],
            "vdW  $T=1.5\\,T_c$",
            fontsize=8, color=ORG, va="center")

    # subcritical vdW
    ax.text(4.02, p_vdw(np.array([4.0]), T_sub)[0],
            "vdW  $T=0.85\\,T_c$",
            fontsize=8, color=ORG, va="center")

    # -- axes ------------------------------------------------------------ #
    ax.set_xlim(0.4, 4.3)
    ax.set_ylim(0, 2.5)
    ax.set_xlabel(r"$V$  (dimensionless)", fontsize=12)
    ax.set_ylabel(r"$p$  (dimensionless)", fontsize=12)

    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    for spine in ax.spines.values():
        spine.set_color(AXC)
        spine.set_linewidth(0.8)
    ax.tick_params(colors=AXC, labelsize=9)

    fig.subplots_adjust(left=0.12, right=0.82, bottom=0.12, top=0.95)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "pv-isotherms")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
