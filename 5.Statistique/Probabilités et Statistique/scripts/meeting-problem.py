"""Meeting problem: probability that two people meet within 1/4 time unit.

Unit square [0,1]² with x = arrival time of A, y = arrival time of B.
The band |x - y| ≤ 1/4 is shaded (meeting region). The two white triangles
represent the cases where they don't meet, with total area (3/4)².

Run with: uv run python src/math_paper/meeting_problem.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(7, 7), transparent=False)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#1f4e9b"
LBLU = "#a8dadc"
GRY = "#888888"
DARK = "#222222"


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)

    # Unit square
    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1)
    ax.set_aspect("equal")

    # Shaded region: |x - y| <= 1/4
    # Hexagon vertices (counterclockwise)
    hex_verts = np.array([
        [0, 0],
        [0.25, 0],
        [1, 0.75],
        [1, 1],
        [0.75, 1],
        [0, 0.25],
    ])
    hex_patch = mpatches.Polygon(hex_verts, closed=True, facecolor=LBLU,
                                  alpha=0.6, edgecolor="none", zorder=2)
    ax.add_patch(hex_patch)

    # Diagonal y = x (gray dashed)
    ax.plot([0, 1], [0, 1], color=GRY, ls="--", lw=1.2, zorder=3)

    # Boundaries y = x ± 1/4 (blue solid)
    x_vals = np.linspace(0, 1, 100)
    ax.plot(x_vals, x_vals + 0.25, color=BLU, lw=1.5, zorder=4)
    ax.plot(x_vals, x_vals - 0.25, color=BLU, lw=1.5, zorder=4)

    # Square boundary
    ax.plot([0, 1, 1, 0, 0], [0, 0, 1, 1, 0], color=DARK, lw=1.5, zorder=5)

    # Labels
    ax.set_xlabel("arrival time of A", fontsize=12, labelpad=8)
    ax.set_ylabel("arrival time of B", fontsize=12, labelpad=8)
    ax.set_xticks([0, 1])
    ax.set_yticks([0, 1])
    ax.set_xticklabels(["0", "1"], fontsize=11)
    ax.set_yticklabels(["0", "1"], fontsize=11)

    # Label (3/4)² in the upper-left triangle
    ax.text(0.18, 0.82, r"$(3/4)^2$", fontsize=15, color=DARK,
            ha="center", fontweight="bold")

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "meeting-problem")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
