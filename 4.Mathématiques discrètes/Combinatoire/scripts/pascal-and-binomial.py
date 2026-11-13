"""Pascal's triangle and the binomial theorem side by side.

Each row of the triangle gives the coefficients of the expansion of (a + b)^n;
the row n = 3 is highlighted together with its expansion to show the
correspondence.

Output: ../img/pascal-and-binomial.svg
"""

from __future__ import annotations

import os
import sys
from dataclasses import replace
from math import comb
from pathlib import Path

import matplotlib.pyplot as plt

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH_PANEL, figsize=(9.6, 3.9))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1f2933"
KEY = "#1f4e9b"

ROWS = 5
HIGHLIGHT = 3
EXPANSIONS = [
    r"$(a+b)^0 = 1$",
    r"$(a+b)^1 = a + b$",
    r"$(a+b)^2 = a^2 + 2ab + b^2$",
    r"$(a+b)^3 = a^3 + 3a^2b + 3ab^2 + b^3$",
    r"$(a+b)^4 = a^4 + 4a^3b + 6a^2b^2 + 4ab^3 + b^4$",
]
TEXT_X = 2.85     # left edge of the expansion column
ROW_GAP = 1.0


def main():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)
    ax.set_aspect("equal")
    ax.axis("off")

    for n in range(ROWS):
        y = -n * ROW_GAP
        is_row = n == HIGHLIGHT
        if is_row:
            ax.plot([TEXT_X - 0.20, 9.2], [y + 0.42, y + 0.42], color=KEY,
                    lw=0.8, alpha=0.45, zorder=1)
            ax.plot([TEXT_X - 0.20, 9.2], [y - 0.42, y - 0.42], color=KEY,
                    lw=0.8, alpha=0.45, zorder=1)
        for k in range(n + 1):
            ax.text(k - n / 2, y, str(comb(n, k)), ha="center", va="center",
                    fontsize=13, color=KEY if is_row else INK,
                    fontweight="bold" if is_row else "normal", zorder=3)

        ax.text(TEXT_X, y, EXPANSIONS[n], ha="left", va="center", fontsize=12,
                color=KEY if is_row else INK)

    ax.set_xlim(-2.4, 9.4)
    ax.set_ylim(-(ROWS - 1) * ROW_GAP - 0.6, 0.7)

    path = SPEC.save(fig, OUT_DIR / "pascal-and-binomial")
    print(f"Saved: {path}")

    if os.environ.get("PREVIEW"):
        preview = OUT_DIR / "pascal-and-binomial-preview.png"
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.05)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
