"""Cardinality spectrum of models under the Löwenheim–Skolem theorems.
Generates img/ls-cardinality.svg (single panel).  Run from the repository root:
uv run "4.Mathématiques discrètes/Logique Mathématique/scripts/ls-cardinality.py"

Mathematics: for a consistent countable theory, downward LS gives a model of
cardinality at most aleph_0; upward LS gives models of every cardinality
beyond the language whenever one infinite model exists.  DLO has models of
every infinite cardinality (it is complete and has an infinite model); PA has
the standard model of size aleph_0 plus nonstandard models (compactness) and
arbitrarily large ones; a consistent ZFC has a countable model although it
proves the existence of uncountable sets (Skolem's paradox: countability is
relative inside the model).
"""
from pathlib import Path
import matplotlib.pyplot as plt

BLUE, TEAL, RED, GRAY = "#3b6fb6", "#2f8f7d", "#c74440", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "ls-cardinality.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "ls-cardinality-preview.png"


def main():
    fig, ax = plt.subplots(figsize=(10.0, 4.6))
    ax.set_xlim(0.0, 10.0)
    ax.set_ylim(0.0, 4.6)
    ax.axis("off")

    # cardinality axis from aleph_0 to aleph_2 (positions 1.6 .. 9.0)
    axis_y = 0.55
    ax.annotate("", xy=(9.0, axis_y), xytext=(1.0, axis_y),
                arrowprops=dict(arrowstyle="-|>", color=GRAY, lw=1.6))
    ax.text(0.95, axis_y - 0.42, "cardinality", fontsize=10, color=GRAY, ha="left", va="top")
    ticks = [("ℵ₀", 1.6), ("ℵ₁", 5.3), ("ℵ₂", 9.0)]
    for label, x in ticks:
        ax.plot([x, x], [axis_y - 0.14, axis_y + 0.14], color=GRAY, lw=1.2)
        ax.text(x, axis_y - 0.34, label, fontsize=11.5, ha="center", va="top", color="#333333")

    # three lanes
    lanes = [
        ("DLO", 3.6, BLUE, "models of every infinite cardinality"),
        ("PA",  2.4, TEAL, "standard ℵ₀ + nonstandard (compactness)"),
        ("ZFC", 1.2, RED, "countable model; countability relative"),
    ]
    for name, y, color, note in lanes:
        ax.text(1.0, y + 0.62, name, fontsize=13, fontweight="bold", color=color,
                ha="left", va="center")
        ax.plot([1.6, 9.0], [y, y], color=color, lw=6.0, alpha=0.55,
                solid_capstyle="round")
        # aleph_0 endpoint: standard / countable model
        ax.plot(1.6, y, marker="o", markersize=9, color=color)
        ax.text(1.6, y - 0.55, note, fontsize=9.5, color="#555555",
                ha="left", va="top")

    # annotation: downward / upward arrows
    ax.annotate("downward LS", xy=(2.6, 3.9), xytext=(2.6, 4.35),
                fontsize=10, color=GRAY, ha="center", va="bottom")
    ax.annotate("", xy=(2.6, 3.15), xytext=(2.6, 4.10),
                arrowprops=dict(arrowstyle="-|>", color=GRAY, lw=1.2))
    ax.annotate("upward LS", xy=(7.6, 4.2), xytext=(7.6, 4.35),
                fontsize=10, color=GRAY, ha="center", va="bottom")
    ax.annotate("", xy=(7.6, 3.75), xytext=(7.6, 4.15),
                arrowprops=dict(arrowstyle="-|>", color=GRAY, lw=1.2))

    fig.tight_layout(pad=0.4)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
