"""Kripke counterexample for the failure of the law of excluded middle.
Generates img/kripke-counterexample.svg (single panel).  Run from the repository root:
uv run "4.Mathématiques discrètes/Logique Mathématique/scripts/kripke-counterexample.py"

Two worlds w1 <= w2; atom p forced only at w2.  Then w1 forces neither p
nor not p, so p or not p fails at w1.
"""
from pathlib import Path
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

OUT = Path(__file__).resolve().parent.parent / "img" / "kripke-counterexample.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "kripke-counterexample-preview.png"

INK = "#22262e"
BLUE = "#3b6fb6"
RED = "#c74440"
GREEN = "#2f8f7d"
GRAY = "#6b7280"
LIGHT = "#eef2f8"

NOTIN = "\u22ad"   # not model / not forces
OR = "\u2228"
NOT = "\u00ac"
LE = "\u2264"


def main():
    fig, ax = plt.subplots(figsize=(8.6, 4.6))
    ax.axis("off")

    # worlds
    w1 = (2.2, 2.2)
    w2 = (6.4, 2.2)
    r = 0.52
    for (x, y) in (w1, w2):
        ax.add_patch(plt.Circle((x, y), r, facecolor=LIGHT, edgecolor=INK, lw=1.6, zorder=2))
    ax.text(*w1, "$w_1$", ha="center", va="center", fontsize=15, color=INK, zorder=3)
    ax.text(*w2, "$w_2$", ha="center", va="center", fontsize=15, color=INK, zorder=3)

    # accessibility arrow w1 -> w2
    ax.annotate("", xy=(w2[0] - r - 0.12, w2[1]), xytext=(w1[0] + r + 0.12, w1[1]),
                arrowprops=dict(arrowstyle="-|>", color=BLUE, lw=2.0))

    # truth annotations under worlds
    ax.text(w1[0], w1[1] - r - 0.42, f"$p$ {NOTIN} (undecided)", ha="center", va="top",
            fontsize=13, color=RED)
    ax.text(w2[0], w2[1] - r - 0.42, "$p$ forced", ha="center", va="top",
            fontsize=13, color=GREEN)

    # world order label
    ax.text(4.3, 1.02, f"$w_1 {LE} w_2$: the future stage decides $p$", ha="center",
            va="top", fontsize=12.5, color=GRAY, style="italic")

    # failure statement
    ax.text(4.3, 4.42, f"$w_1 {NOTIN} p {OR} {NOT} p$", ha="center", va="center",
            fontsize=17, color=RED, fontweight="bold")
    ax.text(4.3, 3.86, "neither disjunct is forced at $w_1$", ha="center", va="center",
            fontsize=12, color=GRAY)

    ax.set_xlim(0.4, 8.2)
    ax.set_ylim(0.2, 5.0)
    fig.tight_layout(pad=0.3)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
