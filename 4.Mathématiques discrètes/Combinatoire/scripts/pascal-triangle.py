"""Pascal's triangle.

Rows n = 0, ..., 7 with the binomial coefficients C(n, k) centred; one entry is
highlighted together with the two entries above it that produce it by the
recurrence C(n, k) = C(n-1, k-1) + C(n-1, k).

Output: ../img/pascal-triangle.svg
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

SPEC = replace(Presets.SVG_MATH, figsize=(6.8, 4.8))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1f2933"
MUTED = "#8894a0"
KEY = "#1f4e9b"

ROWS = 8
HIGHLIGHT = (5, 2)   # C(5, 2) = C(4, 1) + C(4, 2)


def main():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)
    ax.set_aspect("equal")
    ax.axis("off")

    row_gap = 0.85
    for n in range(ROWS):
        for k in range(n + 1):
            value = comb(n, k)
            x, y = k - n / 2, -n * row_gap
            is_key = (n, k) == HIGHLIGHT
            is_parent = (n, k) in ((HIGHLIGHT[0] - 1, HIGHLIGHT[1] - 1),
                                   (HIGHLIGHT[0] - 1, HIGHLIGHT[1]))
            colour = KEY if (is_key or is_parent) else INK
            weight = "bold" if is_key else "normal"
            ax.text(x, y, str(value), ha="center", va="center", fontsize=13,
                    color=colour, fontweight=weight, zorder=3)

    # Connect the highlighted entry to the two entries above it.
    n, k = HIGHLIGHT
    for parent_k in (k - 1, k):
        ax.plot([parent_k - (n - 1) / 2, k - n / 2],
                [-(n - 1) * row_gap + 0.26, -n * row_gap + 0.26],
                color=MUTED, lw=1.0, ls=(0, (3, 2)), zorder=1)

    ax.set_xlim(-3.6, 3.6)
    ax.set_ylim(-(ROWS - 1) * row_gap - 0.55, 0.65)

    path = SPEC.save(fig, OUT_DIR / "pascal-triangle")
    print(f"Saved: {path}")

    if os.environ.get("PREVIEW"):
        preview = OUT_DIR / "pascal-triangle-preview.png"
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.05)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
