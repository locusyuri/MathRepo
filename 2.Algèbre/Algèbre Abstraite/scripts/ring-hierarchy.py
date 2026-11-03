"""The ladder of ring axioms: ring -> commutative -> domain -> field.

Generates img/ring-hierarchy.svg.  Run from the repository root:

    uv run "2.Algèbre/Algèbre Abstraite/scripts/ring-hierarchy.py"

Left column: the commutative ladder (solid arrows), each step adjoining one
multiplicative condition.  Right column: the non-commutative branch (unital
ring, division ring), connected by dashed arrows.  The two lines at the bottom
list witnesses showing that no implication reverses.
"""
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import FancyArrowPatch, FancyBboxPatch

OUT = Path(__file__).resolve().parent.parent / "img" / "ring-hierarchy.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "ring-hierarchy-preview.png"

INK = "#22262e"
BLUE = "#3b6fb6"
RED = "#c74440"
GREEN = "#3f7d4f"
GRAY = "#6b7280"
FILL_MAIN = "#f4f7fb"
FILL_SIDE = "#fbf3f2"

# geometry in data units on a 10 x 6.4 canvas
LEFT_X0, LEFT_W = 0.25, 5.60
LEFT_XC = LEFT_X0 + LEFT_W / 2
RIGHT_X0, RIGHT_W = 6.35, 3.40
BOX_H = 0.95

# rows, bottom to top
Y_FIELD, Y_DOMAIN, Y_COMM, Y_RING = 4.85, 3.50, 2.15, 0.80

LADDER = [
    ("Ring", "R1, R2, R3", r"$2\mathbb{Z}$ (no identity)", Y_RING),
    ("Commutative ring", "also $ab = ba$", r"$\mathbb{Z}_6$,  $\mathbb{Z} \times \mathbb{Z}$", Y_COMM),
    ("Integral domain", "no zero divisors", r"$\mathbb{Z}$,  $\mathbb{Z}[i]$", Y_DOMAIN),
    ("Field", "nonzero elements invertible",
     r"$\mathbb{Q}$, $\mathbb{R}$, $\mathbb{C}$, $\mathbb{F}_p$", Y_FIELD),
]

STEPS = [
    (Y_RING + BOX_H + 0.02, Y_COMM - 0.02, "adjoin commutativity"),
    (Y_COMM + BOX_H + 0.02, Y_DOMAIN - 0.02, "adjoin absence of zero divisors"),
    (Y_DOMAIN + BOX_H + 0.02, Y_FIELD - 0.02, "adjoin inverses"),
]


def box(ax, x0, y0, w, h, fill, edge, dashed=False):
    ax.add_patch(
        FancyBboxPatch(
            (x0, y0), w, h,
            boxstyle="round,pad=0.02,rounding_size=0.10",
            facecolor=fill, edgecolor=edge, linewidth=1.5,
            linestyle=(0, (5, 3)) if dashed else "solid",
            zorder=2,
        )
    )


def arrow(ax, start, end, color, dashed=False, rad=0.0):
    ax.add_patch(
        FancyArrowPatch(
            start, end,
            connectionstyle=f"arc3,rad={rad}",
            arrowstyle="-|>", mutation_scale=14, linewidth=1.5,
            color=color, linestyle=(0, (5, 3)) if dashed else "solid",
            zorder=3,
        )
    )


def main():
    fig, ax = plt.subplots(figsize=(7.4, 4.9))
    ax.set_xlim(0, 10)
    ax.set_ylim(0, 6.4)
    ax.axis("off")
    ax.set_aspect("equal")

    for name, condition, example, y0 in LADDER:
        box(ax, LEFT_X0, y0, LEFT_W, BOX_H, FILL_MAIN, INK)
        ax.text(LEFT_X0 + 0.20, y0 + 0.68, name, fontsize=13, color=INK,
                fontweight="bold", va="center", ha="left")
        ax.text(LEFT_X0 + 0.20, y0 + 0.37, condition, fontsize=11, color=GRAY,
                va="center", ha="left")
        ax.text(LEFT_X0 + 0.20, y0 + 0.15, example, fontsize=11, color=BLUE,
                va="center", ha="left")

    for y_start, y_end, label in STEPS:
        arrow(ax, (LEFT_XC, y_start), (LEFT_XC, y_end), GREEN)
        ax.text(LEFT_XC + 0.12, (y_start + y_end) / 2, label, fontsize=10,
                color=GREEN, va="center", ha="left")

    box(ax, RIGHT_X0, Y_COMM, RIGHT_W, BOX_H, FILL_SIDE, RED, dashed=True)
    ax.text(RIGHT_X0 + 0.16, Y_COMM + 0.68, "Unital ring", fontsize=13,
            color=INK, fontweight="bold", va="center", ha="left")
    ax.text(RIGHT_X0 + 0.16, Y_COMM + 0.37, "a multiplicative identity",
            fontsize=10.5, color=GRAY, va="center", ha="left")
    ax.text(RIGHT_X0 + 0.16, Y_COMM + 0.15, r"$\mathbb{Z}$, $\mathbb{Q}$, $M_n(F)$",
            fontsize=11, color=BLUE, va="center", ha="left")

    box(ax, RIGHT_X0, Y_FIELD, RIGHT_W, BOX_H, FILL_SIDE, RED, dashed=True)
    ax.text(RIGHT_X0 + 0.16, Y_FIELD + 0.68, "Division ring", fontsize=13,
            color=INK, fontweight="bold", va="center", ha="left")
    ax.text(RIGHT_X0 + 0.16, Y_FIELD + 0.37, "not commutative",
            fontsize=10.5, color=GRAY, va="center", ha="left")
    ax.text(RIGHT_X0 + 0.16, Y_FIELD + 0.15, "the quaternions",
            fontsize=11, color=RED, va="center", ha="left")

    arrow(ax, (LEFT_X0 + LEFT_W, Y_RING + BOX_H / 2),
          (RIGHT_X0, Y_COMM + BOX_H / 2), RED, dashed=True, rad=-0.26)
    ax.text(6.42, 1.10, "adjoin $1$", fontsize=10, color=RED,
            va="center", ha="center")

    arrow(ax, (RIGHT_X0 + RIGHT_W / 2, Y_COMM + BOX_H + 0.02),
          (RIGHT_X0 + RIGHT_W / 2, Y_FIELD - 0.02), RED, dashed=True)
    ax.text(RIGHT_X0 + RIGHT_W / 2 + 0.12, (Y_COMM + BOX_H + Y_FIELD) / 2,
            "adjoin inverses", fontsize=10, color=RED,
            va="center", ha="left")

    ax.text(LEFT_X0 + 0.20, 0.45,
            "$2\\mathbb{Z}$ is not unital;  $\\mathbb{Z}_6$ has zero divisors;",
            fontsize=10, color=INK, va="center", ha="left")
    ax.text(LEFT_X0 + 0.20, 0.18,
            "$\\mathbb{Z}$ is not a field;  the quaternions are not commutative.",
            fontsize=10, color=INK, va="center", ha="left")

    fig.tight_layout(pad=0.5)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
