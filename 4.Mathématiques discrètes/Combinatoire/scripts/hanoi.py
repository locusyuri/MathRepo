"""The Tower of Hanoi.

Four disks stacked on peg A, with pegs B and C empty; the smallest disk is
labelled 1.  The dashed arrow shows the first move of the optimal strategy,
the smallest disk from A to C.

Output: ../img/hanoi.svg
"""

from __future__ import annotations

import os
import sys
from dataclasses import replace
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import FancyArrowPatch, FancyBboxPatch

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH_PANEL, figsize=(8.4, 4.2))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1f2933"
MUTED = "#8894a0"
PEG = "#52606d"
DISK_EDGE = "#1f4e9b"
DISK_FILL = ["#dbe8f7", "#b9d4ee", "#dbe8f7", "#b9d4ee"]
RED = "#c0392b"

PEG_X = [0.8, 4.2, 7.6]
PEG_TOP = 3.5
BASE_Y = 0.0
DISK_H = 0.42
DISK_W = [2.5, 2.1, 1.7, 1.3]   # bottom disk first
N_DISKS = 4


def draw_peg(ax, x, label):
    ax.plot([x, x], [BASE_Y, PEG_TOP], color=PEG, lw=3.2,
            solid_capstyle="round", zorder=2)
    ax.text(x, -0.34, label, ha="center", va="top", fontsize=13, color=INK)


def main():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)
    ax.set_aspect("equal")
    ax.axis("off")

    # Base.
    ax.plot([PEG_X[0] - 1.6, PEG_X[-1] + 1.6], [BASE_Y, BASE_Y], color=PEG,
            lw=4.0, solid_capstyle="round", zorder=2)

    for x, label in zip(PEG_X, ("A", "B", "C")):
        draw_peg(ax, x, label)

    # Disks on peg A, numbered from the top (1 = smallest).
    for i, width in enumerate(DISK_W):
        y = BASE_Y + 0.03 + i * DISK_H
        ax.add_patch(FancyBboxPatch(
            (PEG_X[0] - width / 2, y), width, DISK_H * 0.9,
            boxstyle="round,pad=0.0,rounding_size=0.10",
            facecolor=DISK_FILL[i], edgecolor=DISK_EDGE, lw=1.2, zorder=4))
        ax.text(PEG_X[0], y + DISK_H * 0.45, str(N_DISKS - i), ha="center",
                va="center", fontsize=11, color=INK, zorder=5)

    # First move: smallest disk from A to C.
    start = (PEG_X[0] + 0.35, PEG_TOP + 0.45)
    end = (PEG_X[2] - 0.55, PEG_TOP + 0.45)
    ax.add_patch(FancyArrowPatch(
        start, end,
        connectionstyle="arc3,rad=-0.22", arrowstyle="-|>", mutation_scale=14,
        color=RED, lw=1.2, ls=(0, (4, 3)), zorder=6))
    ax.text((start[0] + end[0]) / 2, PEG_TOP + 1.30, "first move: disk 1, A → C",
            ha="center", va="bottom", fontsize=10, color=RED)

    ax.set_xlim(PEG_X[0] - 2.1, PEG_X[-1] + 2.1)
    ax.set_ylim(-0.95, PEG_TOP + 1.85)

    path = SPEC.save(fig, OUT_DIR / "hanoi")
    print(f"Saved: {path}")

    if os.environ.get("PREVIEW"):
        preview = OUT_DIR / "hanoi-preview.png"
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.05)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
