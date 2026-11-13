"""The Chinese Remainder Theorem as a grid.

Generates img/crt-grid.svg.  Run from the repository root:

    uv run "2.Algèbre/Algèbre Abstraite/scripts/crt-grid.py"

Left panel: n = 15 with the coprime pair (3, 5).  Cell (i, j) holds the unique
n in Z_15 with n = i (mod 3) and n = j (mod 5); every cell is hit exactly once,
which is the bijection Z_15 -> Z_3 x Z_5.

Right panel: n = 12 with the pair (4, 6), whose gcd is 2.  The system
n = i (mod 4), n = j (mod 6) is solvable exactly when i - j is even, so only
half of the 24 cells receive a value: the map is injective but not surjective.
"""
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle

OUT = Path(__file__).resolve().parent.parent / "img" / "crt-grid.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "crt-grid-preview.png"

INK = "#22262e"
BLUE = "#3b6fb6"
RED = "#c74440"
GRAY = "#6b7280"
FILL = "#f2f6fb"
EMPTY = "#fafafa"


def draw_grid(ax, n_cols, n_rows, mod_col, mod_row, n_values, title, subtitle, color):
    """Rows are indexed by mod_row, columns by mod_col, values run over range(n_values)."""
    for j in range(n_cols):
        for i in range(n_rows):
            y = n_rows - 1 - i
            hit = [n for n in range(n_values) if n % mod_col == j and n % mod_row == i]
            ax.add_patch(
                Rectangle((j, y), 1.0, 1.0, facecolor=FILL if hit else EMPTY,
                          edgecolor=INK if hit else GRAY, linewidth=1.2 if hit else 0.7,
                          linestyle="solid" if hit else (0, (2, 2)), zorder=2)
            )
            if hit:
                ax.text(j + 0.5, y + 0.5, str(hit[0]), ha="center", va="center",
                        fontsize=11, color=INK, zorder=3)

    for j in range(n_cols):
        ax.text(j + 0.5, n_rows + 0.30, f"{j}", ha="center", va="center",
                fontsize=10, color=color)
    for i in range(n_rows):
        ax.text(-0.30, n_rows - 1 - i + 0.5, f"{i}", ha="center", va="center",
                fontsize=10, color=color)

    ax.text(n_cols / 2, n_rows + 0.85, subtitle, ha="center", va="center",
            fontsize=10.5, color=color)
    ax.set_title(title, fontsize=12.5, color=INK, pad=10)
    ax.set_xlim(-1.0, n_cols + 0.35)
    ax.set_ylim(-0.55, n_rows + 1.2)
    ax.set_aspect("equal")
    ax.axis("off")


def main():
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(7.6, 3.9))

    draw_grid(ax1, 5, 3, 5, 3, 15,
              "15 = 3 $\\cdot$ 5, coprime",
              "columns: mod 5      rows: mod 3", BLUE)
    ax1.text(2.5, -0.45, "$\\mathbb{Z}_{15} \\;\\cong\\; \\mathbb{Z}_3 \\times \\mathbb{Z}_5$",
             ha="center", va="center", fontsize=11.5, color=BLUE)

    draw_grid(ax2, 6, 4, 6, 4, 12,
              "12 with moduli 4 and 6, gcd 2",
              "columns: mod 6      rows: mod 4", RED)
    ax2.text(3.0, -0.45, "only 12 of the 24 cells are reached",
             ha="center", va="center", fontsize=10.5, color=RED)

    fig.tight_layout(pad=0.8)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
