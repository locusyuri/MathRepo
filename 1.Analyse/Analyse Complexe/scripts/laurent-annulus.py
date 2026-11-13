"""Laurent expansion — annulus of convergence and contour deformation.

Center z0, inner radius r, outer radius R. Two intermediate circles
ρ₁ (dashed) and ρ₂ (solid) bound the deformation used in the Cauchy
kernel expansions.

Run with: uv run python src/math_paper/laurent_annulus.py
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

SPEC = replace(Presets.SVG_MATH, transparent=False)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#1f4e9b"
LBLU = "#4a90d9"
RED = "#c0392b"
GRY = "#888888"
DARK = "#222222"

# Center of expansion, slightly off the origin so both "O" and "z0" read.
Z0 = np.array([0.45, 0.32])
R_OUT = 2.25
R_IN = 0.85
RHO1 = 1.32
RHO2 = 1.80
TH = np.linspace(0, 2 * np.pi, 400)


def polar(radius, deg):
    a = np.deg2rad(deg)
    return Z0 + radius * np.array([np.cos(a), np.sin(a)])


def circle(ax, radius, **kw):
    ax.plot(Z0[0] + radius * np.cos(TH), Z0[1] + radius * np.sin(TH), **kw)


def curved_arrow(ax, p_from, p_to, color, lw, rad, zorder=8):
    ax.add_patch(mpatches.FancyArrowPatch(
        tuple(p_from), tuple(p_to),
        connectionstyle=f"arc3,rad={rad}",
        arrowstyle="-|>", mutation_scale=14,
        color=color, lw=lw, zorder=zorder))


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)
    ax.set_aspect("equal")

    # ---- grid ---- #
    ax.set_xticks(np.arange(-2, 3.1, 0.5))
    ax.set_yticks(np.arange(-2, 3.1, 0.5))
    ax.grid(True, color="#efefef", lw=0.6, zorder=0)
    ax.tick_params(labelbottom=False, labelleft=False, length=0)

    # ---- no outer frame ---- #
    for s in ax.spines.values():
        s.set_visible(False)

    ax.set_xlim(-2.5, 3.2)
    ax.set_ylim(-2.4, 3.1)

    # ---- coordinate axes with arrowheads ---- #
    ax.annotate("", xy=(3.15, 0), xytext=(-2.45, 0),
                arrowprops=dict(arrowstyle="-|>", color=DARK, lw=1.0,
                                mutation_scale=12))
    ax.annotate("", xy=(0, 3.05), xytext=(0, -2.35),
                arrowprops=dict(arrowstyle="-|>", color=DARK, lw=1.0,
                                mutation_scale=12))
    ax.text(3.10, -0.24, "Re z", fontsize=11, color=DARK, ha="right")
    ax.text(0.14, 2.98, "Im z", fontsize=11, color=DARK, va="top")
    ax.plot(0, 0, "o", color=DARK, ms=3.2, zorder=9)
    ax.text(-0.20, -0.24, "O", fontsize=11, color=DARK)

    # ---- annulus band (between r and R) ---- #
    ax.add_patch(mpatches.Wedge(Z0, R_OUT, 0, 360, width=R_OUT - R_IN,
                                facecolor=LBLU, alpha=0.16,
                                edgecolor="none", zorder=1))
    circle(ax, R_OUT, color=BLU, lw=1.2, zorder=2)
    circle(ax, R_IN, color=BLU, lw=1.2, zorder=2)

    # ---- radial segment carrying the r / R labels ---- #
    ax.plot([Z0[0] + R_IN, Z0[0] + R_OUT], [Z0[1], Z0[1]],
            color=DARK, lw=1.1, zorder=6)
    ax.plot([Z0[0], Z0[0] + R_IN], [Z0[1], Z0[1]],
            color=DARK, lw=0.8, ls=":", zorder=5)
    ax.text(Z0[0] + R_IN + 0.03, Z0[1] + 0.11, "r", fontsize=12,
            color=DARK, style="italic")
    ax.text(Z0[0] + R_OUT - 0.02, Z0[1] + 0.11, "R", fontsize=12,
            color=DARK, style="italic")

    # ---- center z0 ---- #
    ax.plot(*Z0, "o", color=DARK, ms=6.5, zorder=10)
    ax.text(Z0[0] - 0.10, Z0[1] - 0.30, "$z_0$", fontsize=12, color=DARK,
            fontweight="bold")

    # ---- the two deformation circles ---- #
    circle(ax, RHO2, color=RED, lw=1.5, zorder=4)
    circle(ax, RHO1, color=RED, lw=1.5, ls="--", zorder=4)
    p1 = polar(RHO1, 258)
    p2 = polar(RHO2, 282)
    ax.text(p1[0] - 0.16, p1[1] - 0.24, "$\\rho_1$", fontsize=12,
            color=RED, fontweight="bold", ha="center")
    ax.text(p2[0] + 0.16, p2[1] - 0.24, "$\\rho_2$", fontsize=12,
            color=RED, fontweight="bold", ha="center")

    # ---- sample point z between the two circles ---- #
    pz = polar(1.56, 56)
    ax.plot(*pz, "o", color=DARK, ms=6.0, zorder=10)
    ax.text(pz[0] + 0.14, pz[1] + 0.10, "$z$", fontsize=13, color=DARK,
            fontweight="bold")

    # Two short curved arrows: kernel expands on each circle separately
    curved_arrow(ax, pz, polar(RHO2, 26), DARK, 1.0, 0.28)
    curved_arrow(ax, pz, polar(RHO1, 96), DARK, 1.0, -0.28)

    # ---- thick deformation arrow between the circles ---- #
    curved_arrow(ax, polar(RHO1, 196), polar(RHO2, 150), RED, 2.8, -0.45,
                 zorder=7)
    pd = polar(1.58, 178)
    ax.text(pd[0] - 0.30, pd[1] + 0.28, "deformation", fontsize=11,
            color=DARK, ha="right")

    ax.set_title("Annulus of convergence", fontsize=13, fontweight="bold",
                 pad=12)

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "laurent-annulus")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
