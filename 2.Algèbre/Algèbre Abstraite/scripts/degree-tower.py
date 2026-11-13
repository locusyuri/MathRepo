"""The tower law for degrees of field extensions.

Generates img/degree-tower.svg.  Run from the repository root:

    uv run "2.Algèbre/Algèbre Abstraite/scripts/degree-tower.py"

Three nested fields F inside K inside E, drawn as a tower whose widths grow
upwards.  The two links carry the intermediate degrees, and the identity at
the bottom records that degrees multiply.
"""
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch

OUT = Path(__file__).resolve().parent.parent / "img" / "degree-tower.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "degree-tower-preview.png"

INK = "#22262e"
BLUE = "#3b6fb6"
GREEN = "#3f7d4f"
GRAY = "#6b7280"
FILLS = ("#e7effa", "#f0f5fc", "#f8fbff")

# (centre x, y of lower edge, width, height, label)
LEVELS = [
    (5.0, 5.60, 8.20, 1.25, "$E$"),
    (5.0, 3.35, 5.40, 1.25, "$K$"),
    (5.0, 1.10, 2.60, 1.25, "$F$"),
]


def main():
    fig, ax = plt.subplots(figsize=(6.4, 5.4))
    ax.set_xlim(0, 10)
    ax.set_ylim(-0.55, 7.45)
    ax.set_aspect("equal")
    ax.axis("off")

    for (cx, y0, w, h, label), fill in zip(LEVELS, FILLS):
        ax.add_patch(
            FancyBboxPatch((cx - w / 2, y0), w, h,
                           boxstyle="round,pad=0.02,rounding_size=0.14",
                           facecolor=fill, edgecolor=INK, linewidth=1.5, zorder=2)
        )
        ax.text(cx - w / 2 + 0.42, y0 + h / 2, label, fontsize=15,
                color=INK, ha="left", va="center", zorder=3)

    # links between consecutive levels with their degrees
    ax.plot([5.0, 5.0], [5.60, 4.60], color=GREEN, linewidth=1.8, zorder=1)
    ax.plot([5.0, 5.0], [3.35, 2.35], color=GREEN, linewidth=1.8, zorder=1)
    ax.text(5.30, 5.10, "$[E:K]$", fontsize=12, color=GREEN,
            ha="left", va="center")
    ax.text(5.30, 2.85, "$[K:F]$", fontsize=12, color=GREEN,
            ha="left", va="center")

    # side annotations
    ax.text(8.95, 6.23, "a vector space over $K$", fontsize=10, color=BLUE,
            ha="right", va="center")
    ax.text(7.45, 3.98, "a vector space over $F$", fontsize=10, color=BLUE,
            ha="right", va="center")
    ax.text(6.05, 1.72, "base field", fontsize=10, color=GRAY,
            ha="right", va="center")

    ax.text(5.0, -0.16,
            "$[E:F] = [E:K]\\,[K:F]$     (finite exactly when both factors are)",
            fontsize=11, color=INK, ha="center", va="center")

    fig.tight_layout(pad=0.5)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
