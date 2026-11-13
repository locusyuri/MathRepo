#!/usr/bin/env python3
"""Figure: the four quadrants of (index set x state space).

Layout
------
A 2 x 2 grid of rounded boxes.

- rows: discrete / continuous index set (time)
- columns: discrete / continuous state space

Each cell names one canonical process and the place where this note treats it.

Output: img/process-classification.svg
"""

from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch

INK = "#1f2933"
MUTED = "#52606d"
EDGE = "#9aa5b1"
FILLS = ["#e8f1f8", "#e9f6ee", "#fdf1e3", "#f3e9f7"]

# (column, row, title, description, location, fill)
CELLS = [
    (0, 1, "Random walk, Markov chains", "countable states, one step at a time", "Ch 3-5", FILLS[0]),
    (1, 1, "White noise", "independent real values", "Sec. 1.1", FILLS[1]),
    (0, 0, "Poisson process", "random jumps at random times", "Ch 6", FILLS[2]),
    (1, 0, "Brownian motion", "continuous paths, Gaussian increments", "Ch 8", FILLS[3]),
]

fig, ax = plt.subplots(figsize=(9.2, 6.0))
ax.set_xlim(-0.35, 2.02)
ax.set_ylim(-0.08, 2.24)
ax.axis("off")

for col, row, title, desc, where, fill in CELLS:
    ax.add_patch(
        FancyBboxPatch(
            (col + 0.05, row + 0.05),
            0.90,
            0.90,
            boxstyle="round,pad=0.0,rounding_size=0.05",
            linewidth=1.0,
            edgecolor=EDGE,
            facecolor=fill,
        )
    )
    cx = col + 0.50
    ax.text(cx, row + 0.66, title, ha="center", va="center", fontsize=11.0,
            fontweight="bold", color=INK)
    ax.text(cx, row + 0.47, desc, ha="center", va="center", fontsize=8.6,
            color=MUTED)
    ax.text(cx, row + 0.27, where, ha="center", va="center", fontsize=8.6,
            color=MUTED, style="italic")

ax.text(0.50, 2.11, "state space discrete", ha="center", va="center",
        fontsize=10.0, color=INK)
ax.text(1.50, 2.11, "state space continuous", ha="center", va="center",
        fontsize=10.0, color=INK)
ax.text(-0.16, 1.50, "index set discrete", ha="center", va="center",
        rotation=90, fontsize=10.0, color=INK)
ax.text(-0.16, 0.50, "index set continuous", ha="center", va="center",
        rotation=90, fontsize=10.0, color=INK)

fig.subplots_adjust(left=0.10, right=0.99, top=0.94, bottom=0.06)

out = Path(__file__).resolve().parent.parent / "img" / "process-classification.svg"
fig.savefig(out, format="svg")
fig.savefig(out.with_suffix(".png"), format="png", dpi=140)
print("written:", out)
