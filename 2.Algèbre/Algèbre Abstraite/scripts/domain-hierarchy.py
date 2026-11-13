"""The ladder of divisibility rings: ED inside PID inside UFD inside domain.

Generates img/domain-hierarchy.svg.  Run from the repository root:

    uv run "2.Algèbre/Algèbre Abstraite/scripts/domain-hierarchy.py"

Each class is obtained from the one outside it by one hypothesis.  The band
between two boxes names a ring satisfying the outer hypothesis but not the
inner one, so every inclusion is visibly strict.
"""
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch

OUT = Path(__file__).resolve().parent.parent / "img" / "domain-hierarchy.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "domain-hierarchy-preview.png"

INK = "#22262e"
BLUE = "#3b6fb6"
GRAY = "#6b7280"
RED = "#c74440"
FILL = "#f4f7fb"

# (x0, y0, x1, y1, class name, witness of strictness)
BOXES = [
    (0.20, 1.30, 8.80, 7.80, "Integral domain",
     "not a UFD:  $\\mathbb{Z}[\\sqrt{-5}]$"),
    (0.90, 2.40, 8.10, 7.10, "UFD",
     "not a PID:  $\\mathbb{Z}[x]$"),
    (1.60, 3.50, 7.40, 6.40, "PID",
     "not Euclidean:  none here"),
    (2.30, 4.60, 6.70, 5.70, None, None),
]


def main():
    fig, ax = plt.subplots(figsize=(7.6, 6.6))
    ax.set_xlim(0, 9)
    ax.set_ylim(0, 8.2)
    ax.axis("off")
    ax.set_aspect("equal")

    for x0, y0, x1, y1, label, witness in BOXES:
        ax.add_patch(
            FancyBboxPatch((x0, y0), x1 - x0, y1 - y0,
                           boxstyle="round,pad=0.02,rounding_size=0.16",
                           facecolor=FILL, edgecolor=INK, linewidth=1.4, zorder=2)
        )
        if label:
            ax.text(x0 + 0.26, y1 - 0.34, label, fontsize=11.5, color=INK,
                    fontweight="bold", ha="left", va="center", zorder=3)
            ax.text(x1 - 0.26, y1 - 0.34, witness, fontsize=10, color=RED,
                    ha="right", va="center", zorder=3)

    ax.text(4.50, 5.36, "Euclidean  (division with remainder)",
            fontsize=11.5, color=INK, fontweight="bold", ha="center", va="center")
    ax.text(4.50, 4.86, "$\\mathbb{Z}$,   $\\mathbb{Z}[i]$,   $k[x]$",
            fontsize=12, color=BLUE, ha="center", va="center")

    ax.text(4.50, 0.72,
            "Every inclusion is strict, and each band names the ring that separates two rungs.",
            fontsize=9.8, color=GRAY, ha="center", va="center")

    fig.tight_layout(pad=0.5)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
