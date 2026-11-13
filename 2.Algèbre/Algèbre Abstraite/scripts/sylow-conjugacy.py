"""Sylow p-subgroup conjugacy inside a finite group G.

Single-panel diagram showing:
  - Group G (large rounded rectangle)
  - Four Sylow p-subgroups P, g1 P g1^-1, g2 P g2^-1, g3 P g3^-1
  - Curved conjugation arrows between them
  - Constraints n_p = [G : N_G(P)], n_p | m, n_p = 1 (mod p)

Run with: uv run python src/math_paper/sylow_conjugacy.py
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
    "font.sans-serif": ["DejaVu Sans", "Helvetica", "Arial", "sans-serif"],
    "mathtext.fontset": "dejavusans",
}
SPEC = replace(Presets.SVG_MATH, figsize=(10.0, 7.0),
               transparent=False, rc_overrides=SANS_RC)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1C1C1C"
BLU = "#2C5F7C"
COR = "#E07B54"
AMB = "#E8C547"
GRY = "#5A5A5A"

SW, SH = 1.8, 1.0   # Sylow sub-group box size


def _subgroup_box(ax, cx, cy, label, fontsize=13):
    """Draw a small rounded rectangle for a Sylow p-subgroup."""
    ax.add_patch(mpatches.FancyBboxPatch(
        (cx - SW / 2, cy - SH / 2), SW, SH,
        boxstyle="round,pad=0.1",
        facecolor=COR, edgecolor=COR, lw=0.8,
        alpha=0.15, zorder=2))
    ax.text(cx, cy, label, fontsize=fontsize, ha="center", va="center",
            color=COR, style="italic", zorder=3)


def _curved_arrow(ax, start, end, rad, color, label=None, label_offset=(0, 0),
                  fontsize=10, lw=1.0):
    """Draw a curved arrow between two points with optional label."""
    ax.annotate(
        "", xy=end, xytext=start,
        arrowprops=dict(
            arrowstyle="-|>", color=color, lw=lw,
            connectionstyle=f"arc3,rad={rad}",
            mutation_scale=12,
        ),
        zorder=1)
    if label:
        mx = (start[0] + end[0]) / 2
        my = (start[1] + end[1]) / 2
        # push label away from the arc
        mx += label_offset[0]
        my += label_offset[1]
        ax.text(mx, my, label, fontsize=fontsize, ha="center",
                va="center", color=color, style="italic")


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)

    # ================================================================ #
    # Group G boundary                                                 #
    # ================================================================ #
    ax.add_patch(mpatches.FancyBboxPatch(
        (1.5, 1.0), 7.0, 4.5,
        boxstyle="round,pad=0.2",
        facecolor=BLU, edgecolor=BLU, lw=1.2,
        alpha=0.08, zorder=0))
    ax.text(1.2, 5.7, r"$G$", fontsize=16, ha="center", va="center",
            color=BLU, style="italic")

    # ================================================================ #
    # Sylow p-subgroups                                                #
    # ================================================================ #
    P_pos = (3.0, 3.5)
    g1_pos = (6.0, 4.2)
    g2_pos = (6.5, 2.5)
    g3_pos = (3.5, 1.8)

    _subgroup_box(ax, *P_pos, r"$P$", fontsize=13)
    _subgroup_box(ax, *g1_pos, r"$g_1 P g_1^{-1}$", fontsize=11)
    _subgroup_box(ax, *g2_pos, r"$g_2 P g_2^{-1}$", fontsize=11)
    _subgroup_box(ax, *g3_pos, r"$g_3 P g_3^{-1}$", fontsize=11)

    # ================================================================ #
    # Conjugation arrows                                               #
    # ================================================================ #
    # P -> g1 P g1^-1
    _curved_arrow(ax, (P_pos[0] + 0.9, P_pos[1] + 0.2),
                  (g1_pos[0] - 0.9, g1_pos[1] - 0.1),
                  rad=0.25, color=AMB,
                  label=r"$g_1$", label_offset=(0.0, 0.25))

    # P -> g2 P g2^-1
    _curved_arrow(ax, (P_pos[0] + 0.9, P_pos[1] - 0.2),
                  (g2_pos[0] - 0.9, g2_pos[1] + 0.1),
                  rad=-0.25, color=AMB,
                  label=r"$g_2$", label_offset=(0.0, -0.25))

    # P -> g3 P g3^-1
    _curved_arrow(ax, (P_pos[0] + 0.2, P_pos[1] - 0.5),
                  (g3_pos[0] - 0.2, g3_pos[1] + 0.5),
                  rad=0.3, color=AMB,
                  label=r"$g_3$", label_offset=(-0.35, 0.0))

    # g1 -> g2
    _curved_arrow(ax, (g1_pos[0] - 0.3, g1_pos[1] - 0.5),
                  (g2_pos[0] - 0.3, g2_pos[1] + 0.5),
                  rad=0.3, color=AMB,
                  label=r"$g$", label_offset=(-0.3, 0.0), fontsize=10)

    # g2 -> g3
    _curved_arrow(ax, (g2_pos[0] - 0.9, g2_pos[1] - 0.15),
                  (g3_pos[0] + 0.9, g3_pos[1] - 0.15),
                  rad=-0.3, color=AMB,
                  label=r"$g'$", label_offset=(0.0, -0.3), fontsize=10)

    # g3 -> g1
    _curved_arrow(ax, (g3_pos[0] + 0.5, g3_pos[1] + 0.4),
                  (g1_pos[0] - 0.5, g1_pos[1] - 0.4),
                  rad=-0.35, color=AMB,
                  label=r"$g''$", label_offset=(0.0, 0.3), fontsize=10)

    # ================================================================ #
    # Normaliser annotation                                            #
    # ================================================================ #
    ax.text(4.2, 3.0, r"$N_G(P)$", fontsize=10, ha="center", va="center",
            color=BLU, style="italic")
    ax.annotate(
        "", xy=(P_pos[0] + 0.9, P_pos[1] - 0.1),
        xytext=(4.0, 3.0),
        arrowprops=dict(arrowstyle="-", color=BLU, lw=0.5,
                        ls=(0, (2, 1))),
        zorder=1)

    # ================================================================ #
    # Bottom formulae                                                  #
    # ================================================================ #
    ax.text(5.0, 0.55,
            r"$n_p = |\mathrm{Syl}_p(G)| = [G : N_G(P)]$",
            fontsize=12, ha="center", va="center", color=INK)
    ax.text(5.0, 0.15,
            r"$n_p \mid m \quad\mathrm{and}\quad n_p \equiv 1 \;\mathrm{mod}\; p$",
            fontsize=12, ha="center", va="center", color=INK)
    ax.text(5.0, -0.25,
            r"where $|G| = p^k m,\; p \nmid m$",
            fontsize=11, ha="center", va="center", color=GRY)

    # -- canvas ---------------------------------------------------------- #
    ax.set_xlim(0.5, 9.5)
    ax.set_ylim(-0.6, 6.5)
    ax.set_aspect("equal")
    ax.axis("off")

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "sylow-conjugacy")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
