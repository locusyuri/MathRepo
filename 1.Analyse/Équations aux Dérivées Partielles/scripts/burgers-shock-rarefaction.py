"""Burgers equation: shock vs rarefaction in side-by-side panels.

Two-panel SVG comparing the two canonical Riemann problems for
  u_t + u u_x = 0
with piecewise-constant initial data u(x,0) = u_L (x<0), u_R (x>0).

  Left  — Shock:       u_L > u_R  ->  characteristics collide, shock forms
  Right — Rarefaction: u_L < u_R  ->  characteristics separate, fan fills gap

Run with: uv run python src/math_paper/burgers_shock_rarefaction.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

# ~800x400 px at 96 DPI -> inches; 40 pt gap ~ 0.42 in
SPEC = replace(
    Presets.SVG_MATH_PANEL,
    figsize=(8.3, 4.2),
    transparent=False,
)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#2196F3"
RED = "#E53935"
GRN = "#4CAF50"
AXC = "#333333"


# ========================================================================= #
#  Shock panel                                                              #
# ========================================================================= #
def panel_shock(ax):
    uL, uR = 1.5, 0.3
    shock_speed = (uL + uR) / 2.0          # 0.9
    t = np.linspace(0, 3.5, 300)

    # -- left characteristics (u_L, x < 0) --------------------------------
    for s in [-0.5, -1.5, -2.5]:
        ax.plot(s + uL * t, t, color=BLU, lw=1.5, zorder=2)

    # -- right characteristics (u_R, x > 0) -------------------------------
    for s in [0.5, 1.5, 2.5]:
        ax.plot(s + uR * t, t, color=BLU, lw=1.5, zorder=2)

    # -- shock line (red, thick) ------------------------------------------
    ax.plot(shock_speed * t, t, color=RED, lw=2.5, zorder=3)

    # -- labels -----------------------------------------------------------
    ax.text(-2.3, 2.2, r"$u_L$", fontsize=12, color=BLU, fontweight="bold")
    ax.text(2.8, 1.0, r"$u_R$", fontsize=12, color=BLU, fontweight="bold")
    ax.text(shock_speed * 2.2 + 0.15, 2.4,
            r"$s = \frac{u_L + u_R}{2}\,t$",
            fontsize=9, color=RED)

    # -- axes -------------------------------------------------------------
    ax.set_xlim(-3, 4)
    ax.set_ylim(0, 3.5)
    ax.set_xlabel(r"$x$", fontsize=11)
    ax.set_ylabel(r"$t$", fontsize=11)
    ax.set_title(r"Shock  ($u_L > u_R$)", fontsize=11,
                 fontweight="bold", color=AXC, pad=8)
    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    for spine in ax.spines.values():
        spine.set_color(AXC)
        spine.set_linewidth(0.8)
    ax.tick_params(colors=AXC, labelsize=9)


# ========================================================================= #
#  Rarefaction panel                                                        #
# ========================================================================= #
def panel_rarefaction(ax):
    uL, uR = 1.5, 0.3
    t = np.linspace(0, 3.5, 300)

    # -- left characteristics (u_L, x < 0) --------------------------------
    for s in [-0.5, -1.5, -2.5]:
        ax.plot(s + uL * t, t, color=BLU, lw=1.5, zorder=2)

    # -- right characteristics (u_R, x > 0) -------------------------------
    for s in [0.5, 1.5, 2.5]:
        ax.plot(s + uR * t, t, color=BLU, lw=1.5, zorder=2)

    # -- rarefaction fan (green rays from origin) -------------------------
    slopes = np.linspace(1.0 / uL, 1.0 / uR, 5)   # 0.67 .. 3.33
    for m in slopes:
        ax.plot(m * t, t, color=GRN, lw=1.2, zorder=2)

    # -- labels -----------------------------------------------------------
    ax.text(-2.3, 2.2, r"$u_L$", fontsize=12, color=BLU, fontweight="bold")
    ax.text(2.8, 1.0, r"$u_R$", fontsize=12, color=BLU, fontweight="bold")
    ax.text(1.3, 2.0, "Rarefaction fan",
            fontsize=10, color=GRN, fontweight="bold")

    # -- axes -------------------------------------------------------------
    ax.set_xlim(-3, 3)
    ax.set_ylim(0, 3.5)
    ax.set_xlabel(r"$x$", fontsize=11)
    ax.set_ylabel(r"$t$", fontsize=11)
    ax.set_title(r"Rarefaction  ($u_L < u_R$)", fontsize=11,
                 fontweight="bold", color=AXC, pad=8)
    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    for spine in ax.spines.values():
        spine.set_color(AXC)
        spine.set_linewidth(0.8)
    ax.tick_params(colors=AXC, labelsize=9)


# ========================================================================= #
#  Assemble & save                                                          #
# ========================================================================= #
def build_figure():
    fig = SPEC.figure()
    panel_shock(fig.add_subplot(1, 2, 1))
    panel_rarefaction(fig.add_subplot(1, 2, 2))
    fig.subplots_adjust(wspace=0.40, bottom=0.14, top=0.90,
                        left=0.08, right=0.96)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "burgers-shock-rarefaction")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
