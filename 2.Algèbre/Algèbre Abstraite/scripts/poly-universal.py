"""The universal property of the polynomial ring, as a commutative triangle.

Generates img/poly-universal.svg.  Run from the repository root:

    uv run "2.Algèbre/Algèbre Abstraite/scripts/poly-universal.py"

The inclusion of constants iota and an arbitrary homomorphism phi are given;
the dashed arrow Phi is the unique extension sending x to a, and it exists
exactly when a commutes with the image of phi.
"""
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import FancyArrowPatch, FancyBboxPatch

OUT = Path(__file__).resolve().parent.parent / "img" / "poly-universal.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "poly-universal-preview.png"

INK = "#22262e"
BLUE = "#3b6fb6"
RED = "#c74440"
GREEN = "#3f7d4f"
GRAY = "#6b7280"

R_POS = (1.30, 1.00)
RX_POS = (7.10, 1.00)
A_POS = (4.20, 3.70)
W, H = 1.30, 0.62


def node(ax, pos, label, fill):
    x, y = pos
    ax.add_patch(
        FancyBboxPatch((x - W / 2, y - H / 2), W, H,
                       boxstyle="round,pad=0.02,rounding_size=0.10",
                       facecolor=fill, edgecolor=INK, linewidth=1.3, zorder=3)
    )
    ax.text(x, y, label, ha="center", va="center", fontsize=17, color=INK, zorder=4)


def arrow(ax, start, end, color, dashed=False, rad=0.0):
    ax.add_patch(
        FancyArrowPatch(start, end, connectionstyle=f"arc3,rad={rad}",
                        arrowstyle="-|>", mutation_scale=13, linewidth=1.5,
                        color=color, linestyle=(0, (5, 3)) if dashed else "solid",
                        zorder=2)
    )


def main():
    fig, ax = plt.subplots(figsize=(6.4, 4.0))
    ax.set_xlim(0, 8.4)
    ax.set_ylim(0.2, 4.9)
    ax.axis("off")
    ax.set_aspect("equal")

    node(ax, R_POS, "$R$", "white")
    node(ax, RX_POS, "$R[x]$", "white")
    node(ax, A_POS, "$A$", "white")

    arrow(ax, (R_POS[0] + W / 2 + 0.06, R_POS[1]), (RX_POS[0] - W / 2 - 0.06, RX_POS[1]), BLUE)
    ax.text((R_POS[0] + RX_POS[0]) / 2, R_POS[1] + 0.30, "$\\iota$", fontsize=16, color=BLUE,
            ha="center", va="center")

    arrow(ax, (R_POS[0] + 0.55, R_POS[1] + H / 2 + 0.05),
          (A_POS[0] - 0.55, A_POS[1] - H / 2 - 0.05), GREEN)
    ax.text(2.10, 2.55, "$\\phi$", fontsize=16, color=GREEN, ha="center", va="center")

    arrow(ax, (RX_POS[0] - 0.55, RX_POS[1] + H / 2 + 0.05),
          (A_POS[0] + 0.55, A_POS[1] - H / 2 - 0.05), RED, dashed=True)
    ax.text(6.35, 2.55, "$\\Phi$", fontsize=16, color=RED, ha="center", va="center")
    ax.text(6.45, 1.86, "$x \\mapsto a$", fontsize=13, color=RED, ha="left", va="center")

    ax.text(4.20, 0.35,
            "the dashed arrow exists, and is unique, exactly when "
            "$a\\,\\phi(r) = \\phi(r)\\,a$ for all $r \\in R$",
            fontsize=11, color=GRAY, ha="center", va="center")

    fig.tight_layout(pad=0.4)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
