"""Computability / decidability spectrum.
Generates img/computability-spectrum.svg (single panel).  Run from the repository root:
uv run "4.Mathématiques discrètes/Logique Mathématique/scripts/computability-spectrum.py"

Mathematics: partial recursive functions (r.e. domains) strictly contain the
total computable functions, which contain the decidable relations (decidable
= characteristic function computable).  Decidable implies recursively
enumerable, strictly.  The set of valid first-order formulas is recursively
enumerable but not decidable (completeness gives enumerability, Church's
theorem gives undecidability) — it lies in the r.e.-but-not-decidable zone.
"""
from pathlib import Path
import matplotlib.pyplot as plt
from matplotlib.patches import Ellipse

BLUE, TEAL, GRAY, RED, PURPLE = "#3b6fb6", "#2f8f7d", "#c8cdd4", "#c74440", "#7a4fa8"
OUT = Path(__file__).resolve().parent.parent / "img" / "computability-spectrum.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "computability-spectrum-preview.png"


def main():
    fig, ax = plt.subplots(figsize=(10.0, 5.0))
    ax.set_xlim(0.0, 10.0)
    ax.set_ylim(0.0, 5.0)
    ax.axis("off")

    cx, cy = 4.6, 2.5
    # nested ellipses: partial recursive > computable > decidable
    outer = Ellipse((cx, cy), 7.4, 3.6, facecolor="#eef1f5", edgecolor=GRAY, lw=1.4)
    mid = Ellipse((cx, cy), 5.0, 2.2, facecolor="#e3ecf6", edgecolor=BLUE, lw=1.4)
    inner = Ellipse((cx, cy), 2.6, 1.1, facecolor="#e4f2ee", edgecolor=TEAL, lw=1.4)
    for e in (outer, mid, inner):
        ax.add_patch(e)

    ax.text(cx, 4.32, "partial recursive functions", fontsize=12, color="#444444",
            ha="center", va="center")
    ax.text(cx, 3.72, "computable (total) functions", fontsize=11, color=BLUE,
            ha="center", va="center")
    ax.text(cx, 2.9, "decidable relations", fontsize=11, color=TEAL,
            ha="center", va="center")

    # r.e. label band between outer and mid
    ax.text(8.9, 3.35, "recursively\nenumerable", fontsize=9.5, color=GRAY,
            ha="center", va="center")

    # valid formulas: r.e. but not decidable — a marked point in the r.e. zone
    vx, vy = 8.15, 1.55
    ax.plot(vx, vy, "o", color=RED, markersize=9)
    ax.text(vx + 0.25, vy + 0.32, "valid formulas:\nr.e., not decidable", fontsize=9.5,
            color=RED, ha="left", va="center")

    # arrows: decidability flows inward
    ax.annotate("", xy=(6.0, 3.05), xytext=(7.2, 3.55),
                arrowprops=dict(arrowstyle="-|>", color=GRAY, lw=1.2))
    ax.annotate("", xy=(5.6, 2.42), xytext=(6.4, 2.75),
                arrowprops=dict(arrowstyle="-|>", color=GRAY, lw=1.2))

    fig.tight_layout(pad=0.4)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
