"""Parse tree of the first-order formula ∀x(R(x, f(x)) → P(y)).
Generates img/formula-parse-tree.svg (single panel).  Run from the repository root:
uv run "4.Mathématiques discrètes/Logique Mathématique/scripts/formula-parse-tree.py"
"""
from pathlib import Path
import matplotlib.pyplot as plt

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "formula-parse-tree.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "formula-parse-tree-preview.png"


def node(ax, x, y, label, color, boxstyle="round,pad=0.4"):
    ax.text(
        x, y, label, ha="center", va="center", fontsize=15,
        bbox=dict(boxstyle=boxstyle, fc="white", ec=color, lw=1.6),
    )


def edge(ax, x1, y1, x2, y2, color=GRAY):
    ax.plot([x1, x2], [y1, y2], color=color, lw=1.4, zorder=0)


def main():
    fig, ax = plt.subplots(figsize=(6.4, 5.4))
    ax.set_xlim(-3.0, 3.0)
    ax.set_ylim(0.0, 7.4)
    ax.set_aspect("equal")
    ax.axis("off")

    # node coordinates: (x, y, label, color)
    nodes = {
        "forall": ( 0.0, 6.6, r"$\forall x$", BLUE),
        "impl":   ( 0.0, 5.2, r"$\rightarrow$", BLUE),
        "R":      (-1.6, 3.8, r"$R$", GRAY),
        "P":      ( 1.6, 3.8, r"$P$", GRAY),
        "x1":     (-2.2, 2.4, r"$x$", GRAY),
        "f":      (-0.9, 2.4, r"$f$", GRAY),
        "y":      ( 1.6, 2.4, r"$y$", GRAY),
        "x2":     (-0.9, 0.9, r"$x$", GRAY),
    }

    # edges: parent -> child
    edges = [
        ("forall", "impl"),
        ("impl", "R"), ("impl", "P"),
        ("R", "x1"), ("R", "f"),
        ("P", "y"),
        ("f", "x2"),
    ]
    for p, c in edges:
        edge(ax, nodes[p][0], nodes[p][1], nodes[c][0], nodes[c][1])

    for n in nodes.values():
        node(ax, n[0], n[1], n[2], n[3])

    fig.tight_layout(pad=0.4)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
