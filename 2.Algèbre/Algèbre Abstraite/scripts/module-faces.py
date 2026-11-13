"""Three familiar structures as specialisations of one module definition.

Generates img/module-faces.svg.  Run from the repository root:

    uv run "2.Algèbre/Algèbre Abstraite/scripts/module-faces.py"

A left R-module is an abelian group with a unital ring homomorphism
R -> End(M).  Taking R = Z, R = F a field, and M = R itself produces abelian
groups, vector spaces, and left ideals.  The band at the bottom separates what
is inherited from group theory from what needs a new argument.
"""
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import FancyArrowPatch, FancyBboxPatch

OUT = Path(__file__).resolve().parent.parent / "img" / "module-faces.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "module-faces-preview.png"

INK = "#22262e"
BLUE = "#3b6fb6"
GREEN = "#3f7d4f"
RED = "#c74440"
GRAY = "#6b7280"
FILL_TOP = "#eef4fb"
FILL_SIDE = "#f7f9fc"

CENTRES = (1.75, 5.00, 8.25)
PANELS = [
    ("Abelian group", "$R = \\mathbb{Z}$", "subgroup = submodule"),
    ("Vector space", "$R = F$ a field", "subspace = submodule"),
    ("Left ideal", "$M = R$", "ideal = submodule"),
]


def rounded(ax, x0, y0, w, h, fill, edge, lw=1.4):
    ax.add_patch(
        FancyBboxPatch((x0, y0), w, h,
                       boxstyle="round,pad=0.02,rounding_size=0.12",
                       facecolor=fill, edgecolor=edge, linewidth=lw, zorder=2)
    )


def main():
    fig, ax = plt.subplots(figsize=(7.8, 5.4))
    ax.set_xlim(0, 10)
    ax.set_ylim(0, 7.2)
    ax.set_aspect("equal")
    ax.axis("off")

    # the central definition
    rounded(ax, 2.10, 5.35, 5.80, 1.25, FILL_TOP, BLUE, lw=1.7)
    ax.text(5.00, 6.22, "left $R$-module $M$", fontsize=15, color=INK,
            fontweight="bold", ha="center", va="center")
    ax.text(5.00, 5.72, "$\\rho: R \\to \\mathrm{End}(M)$", fontsize=12,
            color=BLUE, ha="center", va="center")

    # three specialisations
    for x, (title, scalar, note) in zip(CENTRES, PANELS):
        ax.add_patch(
            FancyArrowPatch((5.00, 5.35), (x, 4.25),
                            connectionstyle="arc3,rad=0.0",
                            arrowstyle="-|>", mutation_scale=13,
                            linewidth=1.4, color=GRAY, zorder=1)
        )
        rounded(ax, x - 1.45, 2.55, 2.90, 1.70, FILL_SIDE, GRAY)
        ax.text(x, 3.78, title, fontsize=12.5, color=INK,
                fontweight="bold", ha="center", va="center")
        ax.text(x, 3.36, scalar, fontsize=11.5, color=BLUE,
                ha="center", va="center")
        ax.text(x, 2.88, note, fontsize=9.8, color=GRAY,
                ha="center", va="center")

    # the two halves of the theory
    rounded(ax, 0.30, 0.95, 9.40, 0.62, "#f0f8f1", GREEN, lw=1.1)
    ax.text(0.55, 1.26, "inherited", fontsize=11, color=GREEN,
            fontweight="bold", ha="left", va="center")
    ax.text(2.25, 1.26,
            "quotient of abelian groups, four homomorphism theorems (Ch 4-5, §17.3)",
            fontsize=10.2, color=INK, ha="left", va="center")

    rounded(ax, 0.30, 0.20, 9.40, 0.62, "#fdf1f0", RED, lw=1.1)
    ax.text(0.55, 0.51, "new", fontsize=11, color=RED,
            fontweight="bold", ha="left", va="center")
    ax.text(2.25, 0.51,
            "scalar action on cosets must be well defined (§17.2)",
            fontsize=10.2, color=INK, ha="left", va="center")

    fig.tight_layout(pad=0.5)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
