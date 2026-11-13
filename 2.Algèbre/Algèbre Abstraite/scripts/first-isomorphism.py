"""First Isomorphism Theorem commutative diagram.

G --pi--> G/ker f --f_bar--> im f --i--> H

Decomposition: f = i . f_bar . pi

Run with: uv run python src/math_paper/first_isomorphism.py
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

SANS_RC = {
    "font.family": "sans-serif",
    "font.sans-serif": ["DejaVu Sans", "Helvetica", "Arial",
                         "sans-serif"],
    "mathtext.fontset": "dejavusans",
}
SPEC = replace(Presets.SVG_MATH_PANEL, figsize=(14.0, 4.5),
               transparent=False, rc_overrides=SANS_RC)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1C1C1C"
BLU = "#2C5F7C"
COR = "#E07B54"
GRY = "#5A5A5A"

BW, BH = 1.6, 0.9


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)

    # -- node centres ---------------------------------------------------- #
    nodes = [
        (1.5,  2.25, r"$G$"),
        (5.5,  2.25, r"$G/\!\ker f$"),
        (9.5,  2.25, r"$\mathrm{im}\, f$"),
        (13.0, 2.25, r"$H$"),
    ]

    # -- draw rounded-rectangle nodes ------------------------------------ #
    for cx, cy, label in nodes:
        ax.add_patch(mpatches.FancyBboxPatch(
            (cx - BW / 2, cy - BH / 2), BW, BH,
            boxstyle="round,pad=0.1",
            facecolor="white", edgecolor=INK, lw=0.8,
            alpha=1.0, zorder=2))
        ax.text(cx, cy, label, fontsize=14, ha="center", va="center",
                color=INK, zorder=3)

    # -- arrow 1: G -> G/ker f  (pi, surjection) ------------------------- #
    ax.annotate(
        "", xy=(4.7, 2.25), xytext=(2.3, 2.25),
        arrowprops=dict(arrowstyle="-|>", color=BLU, lw=1.0,
                        mutation_scale=15),
        zorder=1)
    ax.text(3.5, 2.60, r"$\pi$", fontsize=12, ha="center",
            va="bottom", color=BLU, style="italic")

    # -- arrow 2: G/ker f -> im f  (f_bar, ISOMORPHISM) ------------------ #
    ax.annotate(
        "", xy=(8.7, 2.25), xytext=(6.3, 2.25),
        arrowprops=dict(arrowstyle="-|>", color=COR, lw=1.8,
                        mutation_scale=18),
        zorder=1)
    ax.text(7.5, 2.60, r"$\overline{f}$", fontsize=13, ha="center",
            va="bottom", color=COR, style="italic")
    ax.text(7.5, 1.70, "isomorphism", fontsize=11, ha="center",
            va="top", color=GRY)

    # -- arrow 3: im f -> H  (iota, injection) --------------------------- #
    ax.annotate(
        "", xy=(12.2, 2.25), xytext=(10.3, 2.25),
        arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.0,
                        mutation_scale=15),
        zorder=1)
    ax.text(11.25, 2.60, r"$\iota$", fontsize=12, ha="center",
            va="bottom", color=INK, style="italic")

    # -- bottom theorem statement ----------------------------------------- #
    ax.text(7.0, 0.6,
            r"First Isomorphism Theorem:  $G/\!\ker f \cong \mathrm{im}\, f$",
            fontsize=11, ha="center", va="center", color=GRY)

    # -- canvas ---------------------------------------------------------- #
    ax.set_xlim(-0.5, 15.0)
    ax.set_ylim(0, 4.5)
    ax.set_aspect("equal")
    ax.axis("off")

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "first-isomorphism")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
