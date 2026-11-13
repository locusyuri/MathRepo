"""The correspondence theorem for rings, drawn as one lattice with paired nodes.

Generates img/ideal-correspondence.svg.  Run from the repository root:

    uv run "2.Algèbre/Algèbre Abstraite/scripts/ideal-correspondence.py"

Every node carries two labels: above the ideal J of R containing I (blue), below
its image J/I in the quotient (red).  The map J -> J/I is a bijection preserving
inclusion, so one picture serves both lattices; the remark at the bottom records
what maximality of I looks like in this picture.
"""
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch

OUT = Path(__file__).resolve().parent.parent / "img" / "ideal-correspondence.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "ideal-correspondence-preview.png"

INK = "#22262e"
BLUE = "#3b6fb6"
RED = "#c74440"
GRAY = "#8a8f98"

W, H = 2.70, 1.05

# (x, y, label of the ideal, label of its image)
NODES = [
    (4.00, 6.05, "$R$", "$R \\/ I$"),
    (4.00, 4.45, "$J_1 + J_2$", "$(J_1 + J_2) \\/ I$"),
    (2.05, 2.85, "$J_1$", "$J_1 \\/ I$"),
    (5.95, 2.85, "$J_2$", "$J_2 \\/ I$"),
    (4.00, 1.25, "$I$", "$0$"),
]

EDGES = [(0, 1), (1, 2), (1, 3), (2, 4), (3, 4)]


def node(ax, x, y, top, bottom):
    ax.add_patch(
        FancyBboxPatch((x - W / 2, y - H / 2), W, H,
                       boxstyle="round,pad=0.02,rounding_size=0.12",
                       facecolor="white", edgecolor=GRAY, linewidth=1.3, zorder=3)
    )
    ax.plot([x - W / 2 + 0.12, x + W / 2 - 0.12], [y, y],
            color=GRAY, linewidth=0.7, linestyle=(0, (2, 3)), zorder=4)
    ax.text(x, y + 0.23, top, ha="center", va="center", fontsize=11, color=BLUE, zorder=5)
    ax.text(x, y - 0.24, bottom, ha="center", va="center", fontsize=10, color=RED, zorder=5)


def main():
    fig, ax = plt.subplots(figsize=(6.6, 5.2))
    ax.set_xlim(0, 8)
    ax.set_ylim(-0.25, 7.2)
    ax.axis("off")
    ax.set_aspect("equal")

    for a, b in EDGES:
        ax.plot([NODES[a][0], NODES[b][0]], [NODES[a][1], NODES[b][1]],
                color=INK, linewidth=1.2, zorder=2)

    for x, y, top, bottom in NODES:
        node(ax, x, y, top, bottom)

    ax.text(4.0, 6.95,
            "upper line: an ideal $J$ of $R$ containing $I$;   "
            "lower line: its image $J \\/ I$ in the quotient",
            ha="center", va="center", fontsize=9.5, color=INK)

    ax.text(4.0, 0.18,
            "Chains correspond to chains, and the two-element lattice of $R \\/ I$ "
            "corresponds to the pair $(I, R)$.\n"
            "So $I$ is maximal exactly when $R \\/ I$ is a field.",
            ha="center", va="center", fontsize=9.5, color=INK, linespacing=1.7)

    fig.tight_layout(pad=0.6)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
