"""Resolution refutation tree for the example set
{p∨q, ¬p∨q, p∨¬q, ¬p∨¬q}.  Generates img/resolution-tree.svg.
Run from the repository root:
uv run "4.Mathématiques discrètes/Logique Mathématique/scripts/resolution-tree.py"

Leaves: the four clauses; first level: q and ¬q; root: the empty clause ⊥.
"""
from pathlib import Path
import matplotlib.pyplot as plt

OUT = Path(__file__).resolve().parent.parent / "img" / "resolution-tree.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "resolution-tree-preview.png"

INK = "#22262e"
BLUE = "#3b6fb6"
RED = "#c74440"
GREEN = "#2f8f7d"
LIGHT = "#eef2f8"

NOT = "\u00ac"
BOT = "\u22a5"


def node(ax, x, y, text, color=INK, boxcolor=LIGHT):
    ax.text(x, y, text, ha="center", va="center", fontsize=13, color=color,
            bbox=dict(boxstyle="round,pad=0.42", facecolor=boxcolor,
                      edgecolor=INK, lw=1.2), zorder=3)


def edge(ax, x1, y1, x2, y2, color=INK, lw=1.5):
    ax.plot([x1, x2], [y1, y2], color=color, lw=lw, zorder=1)


def main():
    fig, ax = plt.subplots(figsize=(8.8, 5.6))
    ax.axis("off")

    # leaves (level 0), y = 0.8
    leaves = [
        (1.0, f"$p {OR} q$"),
        (3.0, f"${NOT}p {OR} q$"),
        (5.0, f"$p {OR} {NOT}q$"),
        (7.0, f"${NOT}p {OR} {NOT}q$"),
    ]
    for x, t in leaves:
        node(ax, x, 0.8, t)

    # level 1
    node(ax, 2.0, 2.6, "$q$", color=INK)
    node(ax, 6.0, 2.6, f"${NOT}q$", color=INK)

    # root
    node(ax, 4.0, 4.4, f"${BOT}$", color="white", boxcolor=RED)

    # edges
    edge(ax, 1.0, 0.8, 2.0, 2.6, color=BLUE)
    edge(ax, 3.0, 0.8, 2.0, 2.6, color=BLUE)
    edge(ax, 5.0, 0.8, 6.0, 2.6, color=BLUE)
    edge(ax, 7.0, 0.8, 6.0, 2.6, color=BLUE)
    edge(ax, 2.0, 2.6, 4.0, 4.4, color=RED, lw=2.0)
    edge(ax, 6.0, 2.6, 4.0, 4.4, color=RED, lw=2.0)

    # step labels
    ax.text(4.0, 1.9, "resolve", ha="center", va="center", fontsize=10.5,
            color=GREEN, style="italic")
    ax.text(4.0, 3.75, "contradiction", ha="center", va="center", fontsize=10.5,
            color=RED, style="italic")

    ax.set_xlim(0, 8)
    ax.set_ylim(0, 5.2)
    fig.tight_layout(pad=0.3)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


OR = "\u2228"
if __name__ == "__main__":
    main()
