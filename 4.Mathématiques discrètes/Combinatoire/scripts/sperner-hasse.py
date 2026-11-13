"""Sperner: Hasse diagram of the Boolean lattice 2^[4].

Single-panel figure. Subsets of {1,2,3,4} are arranged in 5 ranks by their
cardinality |A| = 0..4, from top (empty set) to bottom ({1,2,3,4}).
An edge joins A (above) to B (below) whenever A is a proper subset of B.

Visual conventions:
  * grey thin lines (#bbb) for the rank-0..1 and rank-3..4 edges,
  * the middle rank |A| = 2 (6 elements) is highlighted in red (#c0392b):
    bigger dots, slightly larger labels and thicker red edges.

Run with: uv run python src/math_paper/sperner_hasse.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(8.8, 9.8))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1a1a1a"
RED = "#c0392b"
GREY = "#bbbbbb"

# ranks 0..4, subsets given in the (left -> right) display order
RANKS: list[list[tuple[int, ...]]] = [
    [()],
    [(1,), (2,), (3,), (4,)],
    [(1, 2), (1, 3), (1, 4), (2, 3), (2, 4), (3, 4)],
    [(1, 2, 3), (1, 2, 4), (1, 3, 4), (2, 3, 4)],
    [(1, 2, 3, 4)],
]

SX = 1.7    # horizontal spacing between two neighbouring nodes of one rank
SY = 2.0    # vertical spacing between two consecutive ranks


def _label(s: tuple[int, ...]) -> str:
    if not s:
        return "\u2205"            # empty set
    return ",".join(str(x) for x in s)


def panel(ax):
    # node coordinates
    pos = []                       # pos[r][i] = (x, y)
    for r, members in enumerate(RANKS):
        y = -SY * r
        row = [( (i - (len(members) - 1) / 2) * SX, y )
               for i in range(len(members))]
        pos.append(row)

    # cover relations A < B between consecutive ranks
    for r in range(4):
        red = r in (1, 2)          # edges incident to the highlighted rank 2
        color, lw = (RED, 2.1) if red else (GREY, 1.1)
        for ia, a in enumerate(RANKS[r]):
            sa = set(a)
            for ib, b in enumerate(RANKS[r + 1]):
                if sa.issubset(b):
                    (x1, y1), (x2, y2) = pos[r][ia], pos[r + 1][ib]
                    ax.plot([x1, x2], [y1, y2], color=color, lw=lw,
                            zorder=1)

    # nodes + labels
    for r, members in enumerate(RANKS):
        highlight = (r == 2)
        dot_color = RED if highlight else INK
        ms = 6.2 if highlight else 4.2
        fs = 13.5 if highlight else 11.5
        for (x, y), s in zip(pos[r], members):
            ax.plot(x, y, "o", ms=ms, color=dot_color, zorder=4)
            ax.text(x, y - 0.72, _label(s), fontsize=fs, color=dot_color,
                    ha="center", va="center", zorder=5,
                    bbox=dict(boxstyle="square,pad=0.12", fc="white",
                              ec="none"))

    ax.set_xlim(-5.0, 5.0)
    ax.set_ylim(-9.5, 0.9)
    ax.set_aspect("equal")
    ax.axis("off")


def build_figure():
    fig = SPEC.figure()
    panel(fig.add_subplot(111))
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "sperner-hasse")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
