"""Three logics, five properties: comparison matrix.
Generates img/second-order-vs-first-order.svg (single panel).  Run from the repository root:
uv run "4.Mathématiques discrètes/Logique Mathématique/scripts/second-order-vs-first-order.py"

Rows: first-order logic, second-order with Henkin semantics, second-order
with standard semantics.  Columns: completeness, compactness,
Loewenheim-Skolem, categoricity (of arithmetic), decidability of validity.
"""
from pathlib import Path
import matplotlib.pyplot as plt

OUT = Path(__file__).resolve().parent.parent / "img" / "second-order-vs-first-order.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "second-order-vs-first-order-preview.png"

GREEN, RED, GRAY = "#2f8f7d", "#c74440", "#e8ebef"
YES, NO, NA = "\u2713", "\u2717", "\u2013"


def main():
    fig, ax = plt.subplots(figsize=(10.0, 4.2))
    ax.axis("off")

    rows = ["First-order logic", "SO, Henkin semantics", "SO, standard semantics"]
    cols = ["Completeness", "Compactness", "L\u00f6wenheim\u2013Skolem", "Categoricity of PA\u2082", "Validity decidable"]
    data = [
        [YES, YES, YES, NO, NO],
        [YES, YES, YES, NO, NO],
        [NO, NO, NO, YES, NO],
    ]

    cell_w, cell_h = 1.0, 0.62
    label_w = 2.6
    x0, y0 = 0.4, 0.4
    n_rows, n_cols = len(rows), len(cols)

    # column headers
    for j, c in enumerate(cols):
        ax.text(x0 + label_w + j * cell_w + cell_w / 2, y0 + n_rows * cell_h + 0.18,
                c, fontsize=10.5, ha="center", va="center", color="#22262e",
                fontweight="bold")
    # row labels
    for i, r in enumerate(rows):
        ax.text(x0, y0 + (n_rows - 1 - i) * cell_h + cell_h / 2, r, fontsize=10.5,
                ha="right", va="center", color="#22262e")

    # cells
    for i in range(n_rows):
        for j in range(n_cols):
            val = data[i][j]
            face = GREEN if val == YES else (RED if val == NO else GRAY)
            x = x0 + label_w + j * cell_w
            y = y0 + (n_rows - 1 - i) * cell_h
            ax.add_patch(plt.Rectangle((x, y), cell_w, cell_h, facecolor=face,
                                       edgecolor="white", lw=1.5, alpha=0.88))
            ax.text(x + cell_w / 2, y + cell_h / 2, val, fontsize=13, color="white",
                    ha="center", va="center", fontweight="bold")

    ax.set_xlim(0, x0 + label_w + n_cols * cell_w + 0.4)
    ax.set_ylim(0, y0 + n_rows * cell_h + 0.55)
    fig.tight_layout(pad=0.3)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
