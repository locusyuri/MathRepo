"""König's lemma: an infinite finitely branching tree has an infinite branch.
Generates img/konig-lemma.svg.  Run from the repository root:
uv run "4.Mathématiques discrètes/Logique Mathématique/scripts/konig-lemma.py"

Binary tree drawn to depth 5 with the greedy infinite branch highlighted;
the tree continues below the shown window.
"""
from pathlib import Path
import matplotlib.pyplot as plt

OUT = Path(__file__).resolve().parent.parent / "img" / "konig-lemma.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "konig-lemma-preview.png"

INK = "#22262e"
RED = "#c74440"
GREEN = "#2f8f7d"
GRAY = "#c9d1dc"
LIGHT = "#eef2f8"
DARK = "#d8dee9"


def main():
    fig, ax = plt.subplots(figsize=(7.6, 5.4))
    ax.axis("off")

    depth = 5
    # coordinates: level d, index i -> x, y
    def pos(d, i):
        span = 1.9
        if d == 0:
            return 3.8, 4.6
        width = span * 2.0 ** (d - 1)
        x = 3.8 - width / 2 + (i + 0.5) * (width / 2.0 ** (d - 1))
        return x, 4.6 - d * 0.82

    # vertices per level; branch goes always to the right child index 2i+1
    levels = []
    levels.append([(0,)])
    for d in range(1, depth + 1):
        n = 2 ** d
        levels.append([(d, i) for i in range(n)])

    # edges
    for d in range(depth):
        for i in range(2 ** d):
            for c in (2 * i, 2 * i + 1):
                x1, y1 = pos(d, i)
                x2, y2 = pos(d + 1, c)
                on_branch = (d == 0) or (c == 2 * i + 1 and (d, i) in
                                         [(0, 0)] + [(d, 2 ** d - 1) for d in range(0, depth)])
                # simpler: branch = rightmost path (i = 2^d - 1 at each level)
                on_branch = (i == 2 ** d - 1) and (c == 2 * (2 ** d - 1) + 1)
                if d == 0:
                    on_branch = c == 1
                ax.plot([x1, x2], [y1, y2], color=(RED if on_branch else GRAY), lw=1.8)

    # nodes
    for d in range(depth + 1):
        n = 2 ** d
        for i in range(n):
            x, y = pos(d, i)
            on_branch = (d == 0) or (i == 2 ** d - 1)
            ax.add_patch(plt.Circle((x, y), 0.075, facecolor=(GREEN if on_branch else DARK),
                                    edgecolor="none", zorder=3))

    # annotations
    ax.text(3.8, 5.0, "root", ha="center", va="center", fontsize=11, color=INK)
    ax.text(7.15, 4.6, "infinite branch\n(greedy choice)", ha="center", va="center",
            fontsize=10.5, color=RED, style="italic")
    ax.text(0.9, 0.9, "finitely many\nsuccessors per node", ha="center", va="center",
            fontsize=10.5, color=GRAY, style="italic")
    ax.text(3.8, 0.15, "the tree continues below", ha="center", va="center",
            fontsize=10, color=GRAY, style="italic")

    ax.set_xlim(0, 7.6)
    ax.set_ylim(0, 5.4)
    fig.tight_layout(pad=0.3)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
