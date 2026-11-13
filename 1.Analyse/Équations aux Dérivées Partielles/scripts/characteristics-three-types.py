"""Three types of PDE characteristics: elliptic, parabolic, hyperbolic.

Three-panel SVG comparing characteristic-curve geometry for second-order
linear PDEs in 2-D:

  Left   Elliptic   (Laplace)   : no real characteristics
  Middle Parabolic  (Heat)      : one degenerate family  t = const
  Right  Hyperbolic (Wave)      : two transverse families  x +/- ct = const

Run with: uv run python src/math_paper/characteristics_three_types.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(
    Presets.SVG_MATH_PANEL,
    figsize=(14.0, 5.8),
    transparent=False,
)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

AXC = "#333333"
GRY = "#888888"
BLU = "#2980b9"
RED = "#e74c3c"
GRN = "#27ae60"
CIRC = "#cccccc"
FILL = "#d4e6f1"


# ========================================================================= #
#  Left panel  Elliptic  (Laplace equation)                                 #
# ========================================================================= #
def panel_elliptic(ax):
    # light-blue domain fill
    ax.add_patch(plt.Rectangle((-2, -2), 4, 4,
                               facecolor=FILL, alpha=0.1,
                               edgecolor="none", zorder=0))

    # faint dashed circle hinting at complex characteristics
    ax.add_patch(mpatches.Circle((0, 0), 1.2,
                                 facecolor="none", edgecolor=CIRC,
                                 lw=1.0, ls="--", alpha=0.4, zorder=1))

    # annotation
    ax.text(0, 0.3, "No real\ncharacteristics",
            fontsize=12, color=GRY, ha="center", va="center",
            style="italic")

    # equation + discriminant
    ax.text(0, -2.45, r"$u_{xx} + u_{yy} = 0$",
            fontsize=11, color=AXC, ha="center")
    ax.text(0, -2.85, r"$\Delta = -1 < 0$",
            fontsize=9, color=GRY, ha="center")

    ax.set_xlim(-2, 2)
    ax.set_ylim(-2.95, 2)
    ax.set_xlabel(r"$x$", fontsize=11)
    ax.set_ylabel(r"$y$", fontsize=11)
    ax.set_title("Elliptic", fontsize=16, fontweight="bold",
                 color=AXC, pad=10)
    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    for spine in ax.spines.values():
        spine.set_color(AXC)
        spine.set_linewidth(0.8)
    ax.tick_params(colors=AXC, labelsize=9)


# ========================================================================= #
#  Middle panel  Parabolic  (Heat equation)                                 #
# ========================================================================= #
def panel_parabolic(ax):
    # characteristic lines  t = const
    for t0 in [0.5, 1.0, 1.5, 2.0, 2.5, 3.0]:
        ax.axhline(t0, color=BLU, lw=1.5, zorder=2)

    # label a few lines
    ax.text(2.08, 1.0, r"$t = 1.0$", fontsize=10, color=BLU,
            va="center")
    ax.text(2.08, 2.0, r"$t = 2.0$", fontsize=10, color=BLU,
            va="center")
    ax.text(2.08, 3.0, r"$t = 3.0$", fontsize=10, color=BLU,
            va="center")

    # annotation
    ax.text(0, 2.6, "One degenerate family",
            fontsize=12, color=GRY, ha="center", style="italic")

    # "time" arrow along t-axis
    ax.annotate("", xy=(0.05, 2.85), xytext=(0.05, 2.45),
                arrowprops=dict(arrowstyle="-|>", color="#666666",
                                lw=1.2, mutation_scale=14))
    ax.text(0.18, 2.65, "time", fontsize=9, color="#666666",
            style="italic")

    # equation + discriminant
    ax.text(0, -0.55, r"$u_t - \kappa\, u_{xx} = 0$",
            fontsize=11, color=AXC, ha="center")
    ax.text(0, -0.85, r"$\Delta = 0$",
            fontsize=9, color=GRY, ha="center")

    ax.set_xlim(-2, 2)
    ax.set_ylim(-0.95, 3)
    ax.set_xlabel(r"$x$", fontsize=11)
    ax.set_ylabel(r"$t$", fontsize=11)
    ax.set_title("Parabolic", fontsize=16, fontweight="bold",
                 color=AXC, pad=10)
    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    for spine in ax.spines.values():
        spine.set_color(AXC)
        spine.set_linewidth(0.8)
    ax.tick_params(colors=AXC, labelsize=9)


# ========================================================================= #
#  Right panel  Hyperbolic  (Wave equation)                                 #
# ========================================================================= #
def panel_hyperbolic(ax):
    c = 1.0
    x = np.linspace(-2, 2, 200)

    # two families of characteristics
    for k in [-2, -1, 0, 1, 2]:
        ax.plot(x, (x - k) / c, color=RED, lw=1.5,
                zorder=2)                       # x - ct = const
        ax.plot(x, (k - x) / c, color=GRN, lw=1.5,
                zorder=2)                       # x + ct = const

    # label one line from each family
    # red line  x - t = 1  =>  t = x - 1,  at (1.5, 0.5)
    ax.text(1.55, 0.15, r"$x - ct = \mathrm{const}$",
            fontsize=9, color=RED, rotation=42)
    # green line  x + t = -1  =>  t = -x - 1,  at (-1.5, 0.5)
    ax.text(-1.95, 0.6, r"$x + ct = \mathrm{const}$",
            fontsize=9, color=GRN, rotation=-42)

    # annotation
    ax.text(0, 2.65, "Two transverse families",
            fontsize=12, color=GRY, ha="center", style="italic")

    # equation + discriminant
    ax.text(0, -0.55, r"$u_{tt} - c^2 u_{xx} = 0$",
            fontsize=11, color=AXC, ha="center")
    ax.text(0, -0.85, r"$\Delta = c^2 > 0$",
            fontsize=9, color=GRY, ha="center")

    ax.set_xlim(-2, 2)
    ax.set_ylim(-0.95, 3)
    ax.set_xlabel(r"$x$", fontsize=11)
    ax.set_ylabel(r"$t$", fontsize=11)
    ax.set_title("Hyperbolic", fontsize=16, fontweight="bold",
                 color=AXC, pad=10)
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
    panel_elliptic(fig.add_subplot(1, 3, 1))
    panel_parabolic(fig.add_subplot(1, 3, 2))
    panel_hyperbolic(fig.add_subplot(1, 3, 3))
    fig.subplots_adjust(wspace=0.38, bottom=0.16, top=0.90,
                        left=0.06, right=0.97)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "characteristics-three-types")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
