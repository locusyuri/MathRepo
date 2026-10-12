"""Gödel self-reference loop.
Generates img/godel-self-reference.svg (single panel).  Run from the repository root:
uv run "4.Mathématiques discrètes/Logique Mathématique/scripts/godel-self-reference.py"

Mathematics: formulas are coded by Gödel numbers; the provability
predicate Bew applies to codes; diagonalization feeds a formula its own
code, yielding G := not Bew(angle G angle), true in N but unprovable.
"""
from pathlib import Path
import matplotlib.pyplot as plt
from matplotlib.patches import FancyArrowPatch

BLUE, GREEN, RED, GRAY, INK = "#3b6fb6", "#2f8f7d", "#c74440", "#8a919c", "#22262e"
OUT = Path(__file__).resolve().parent.parent / "img" / "godel-self-reference.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "godel-self-reference-preview.png"


def node(ax, x, y, title, sub, face, edge):
    ax.add_patch(plt.Rectangle((x - 1.05, y - 0.55), 2.1, 1.1, facecolor=face,
                               edgecolor=edge, lw=1.6, zorder=2, alpha=0.95))
    ax.text(x, y + 0.14, title, fontsize=11.5, fontweight="bold", color=INK,
            ha="center", va="center", zorder=3)
    ax.text(x, y - 0.24, sub, fontsize=9.5, color="#4a5260", ha="center",
            va="center", zorder=3)


def arrow(ax, x1, y1, x2, y2, label, color=GRAY, lx=0.0, ly=0.0, size=11.5):
    ax.add_patch(FancyArrowPatch((x1, y1), (x2, y2), arrowstyle="-|>",
                                 mutation_scale=16, lw=1.8, color=color, zorder=4))
    ax.text((x1 + x2) / 2 + lx, (y1 + y2) / 2 + ly, label, fontsize=size,
            color=INK, ha="center", va="center", zorder=5,
            bbox=dict(boxstyle="round,pad=0.25", facecolor="white", edgecolor="none"))


def main():
    fig, ax = plt.subplots(figsize=(9.6, 4.6))
    ax.set_xlim(0.0, 10.0)
    ax.set_ylim(0.0, 5.0)
    ax.axis("off")

    # four nodes on a diamond
    node(ax, 1.7, 2.5, "formula \u03c6", "syntactic object", "#eef3fa", BLUE)
    node(ax, 4.2, 3.8, "code \u231c\u03c6\u231d", "arithmetic number", "#e8f4f0", GREEN)
    node(ax, 7.0, 3.8, "Bew(x)", "provability predicate", "#e8f4f0", GREEN)
    node(ax, 8.6, 2.2, "G \u21d4 \u00acBew(\u231cG\u231d)", "self-referential sentence", "#fdeeee", RED)

    # loop arrows
    arrow(ax, 2.85, 2.9, 3.6, 3.55, "Gödel numbering", BLUE, lx=0.0, ly=0.35)
    arrow(ax, 5.3, 3.85, 5.95, 3.85, "applies to codes", GREEN)
    arrow(ax, 7.75, 3.4, 8.2, 2.75, "negate + diagonalize", RED, lx=0.55, ly=0.35, size=10)
    arrow(ax, 7.7, 1.95, 3.1, 2.2, "the sentence refers to its own code", GRAY, lx=0.0, ly=-0.42, size=10)

    # status annotation
    ax.text(1.7, 0.55, r"true in $\mathbb{N}$  ·  unprovable in $\mathrm{PA}$", fontsize=10.5,
            color=RED, ha="center", va="center")

    fig.tight_layout(pad=0.4)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
