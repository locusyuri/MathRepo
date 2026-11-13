"""Quotient group projection pi : G -> G/N.

Visualisation with G = S_3, N = A_3.
The natural projection collapses each coset of N to a single point
in the quotient group G/N = {N, (12)N} ~ Z_2.

Run with: uv run python src/math_paper/quotient_projection.py
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

SERIF_RC = {
    "font.family": "serif",
    "font.serif": ["DejaVu Serif", "STIX Two Math",
                    "Times New Roman", "serif"],
    "mathtext.fontset": "dejavuserif",
}
SPEC = replace(Presets.SVG_MATH, figsize=(10, 5.8),
               transparent=False, rc_overrides=SERIF_RC)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#1a3a6b"
ORG = "#e07b54"
LBLU = "#d4e6f1"
LORG = "#fde2d4"
AXC = "#333333"


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)

    # -- left-panel element positions ------------------------------------ #
    left = [
        (-1.5, 1.0, "e",       BLU),
        (-0.5, 1.0, "(123)",   BLU),
        ( 0.5, 1.0, "(132)",   BLU),
        (-1.5,-1.0, "(12)",    ORG),
        (-0.5,-1.0, "(13)",    ORG),
        ( 0.5,-1.0, "(23)",    ORG),
    ]

    # -- right-panel quotient points ------------------------------------- #
    right = [
        (4.0,  1.0, "N",       BLU),
        (4.0, -1.0, "(12)N",   ORG),
    ]

    # -- ellipses around each coset -------------------------------------- #
    ax.add_patch(mpatches.Ellipse(
        (-0.5, 1.0), 2.6, 0.85,
        facecolor=LBLU, alpha=0.4, edgecolor=BLU, lw=1.5, zorder=1))
    ax.add_patch(mpatches.Ellipse(
        (-0.5, -1.0), 2.6, 0.85,
        facecolor=LORG, alpha=0.4, edgecolor=ORG, lw=1.5, zorder=1))

    # -- curly braces (left side) ---------------------------------------- #
    for yc in (1.0, -1.0):
        ax.plot([-2.2, -2.5, -2.2], [yc + 0.35, yc, yc - 0.35],
                color=AXC, lw=1.5, solid_capstyle="round", zorder=2)

    # -- curved arrows (6 total) ----------------------------------------- #
    targets_top = [(4.0, 1.0)] * 3
    targets_bot = [(4.0, -1.0)] * 3
    rads_top = [0.25, 0.0, -0.25]
    rads_bot = [-0.25, 0.0, 0.25]

    for i in range(3):
        sx, sy = left[i][0], left[i][1]
        tx, ty = targets_top[i]
        ax.add_artist(mpatches.FancyArrowPatch(
            (sx, sy), (tx, ty),
            arrowstyle="-|>", mutation_scale=12,
            color=BLU, lw=1.0,
            connectionstyle=f"arc3,rad={rads_top[i]}",
            zorder=2))

    for i in range(3):
        sx, sy = left[3 + i][0], left[3 + i][1]
        tx, ty = targets_bot[i]
        ax.add_artist(mpatches.FancyArrowPatch(
            (sx, sy), (tx, ty),
            arrowstyle="-|>", mutation_scale=12,
            color=ORG, lw=1.0,
            connectionstyle=f"arc3,rad={rads_bot[i]}",
            zorder=2))

    # -- left dots & labels ---------------------------------------------- #
    for x, y, lbl, c in left:
        ax.plot(x, y, "o", color=c, ms=8, zorder=4)
        ax.text(x, y - 0.22, lbl, fontsize=8, ha="center",
                va="top", color=AXC, zorder=5)

    # -- right dots & labels --------------------------------------------- #
    for x, y, lbl, c in right:
        ax.plot(x, y, "o", color=c, ms=16, zorder=4)
        ax.text(x + 0.25, y, lbl, fontsize=11, ha="left",
                va="center", color=AXC, fontweight="bold", zorder=5)

    # -- coset labels (near ellipses) ------------------------------------ #
    ax.text(-0.5, 1.72, r"$N = A_3$", fontsize=11, ha="center",
            va="bottom", color=BLU, fontweight="bold")
    ax.text(-0.5, -1.72, r"$(12)N$", fontsize=11, ha="center",
            va="top", color=ORG, fontweight="bold")

    # -- panel titles ---------------------------------------------------- #
    ax.text(-0.5, 2.35, r"$G = S_3$", fontsize=14, ha="center",
            va="bottom", color=AXC, fontweight="bold")
    ax.text(4.0, 2.35, r"$G/N \cong \mathbb{Z}_2$", fontsize=14,
            ha="center", va="bottom", color=AXC, fontweight="bold")

    # -- pi label (centre) ----------------------------------------------- #
    ax.text(1.75, 0.05, r"$\pi: G \to G/N$", fontsize=14,
            ha="center", va="center", color=AXC, style="italic")

    # -- canvas ---------------------------------------------------------- #
    ax.set_xlim(-3.5, 6.0)
    ax.set_ylim(-2.5, 2.8)
    ax.set_aspect("equal")
    ax.axis("off")

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "quotient-projection")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
