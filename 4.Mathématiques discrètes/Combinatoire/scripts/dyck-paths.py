"""Dyck paths of semilength 3 and the reflection principle.

Left panel: all five Dyck paths for n=3 (C_3 = 5) drawn as small multiples.
Right panel: the reflection principle — a bad path that first touches y=-1,
whose tail is reflected (steps flipped) into a green mirror path ending at
(6,-2).  Both coordinate systems share the same x-axis (aligned y=0 baseline).

Run with: uv run python src/math_paper/dyck_paths.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(16.0, 4.9), transparent=False)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#1f4e9b"
RED = "#c0392b"
GRN = "#2e8b57"
GRY = "#888888"
LGRY = "#bbbbbb"
ORNG = "#f0a03c"

# All five Dyck words of semilength 3.
DYCK_WORDS = ["UUUDDD", "UUDUDD", "UUDDUD", "UDUUDD", "UDUDUD"]

# Shared figure-fraction height of the y = 0 baseline.
Y0 = 0.42


def path_coords(word):
    xs, ys = [0], [0]
    for ch in word:
        xs.append(xs[-1] + 1)
        ys.append(ys[-1] + (1 if ch == "U" else -1))
    return np.array(xs), np.array(ys)


def style_small(ax):
    ax.set_xlim(-0.35, 6.35)
    ax.set_ylim(-0.5, 3.5)
    ax.set_xticks([])
    ax.set_yticks([])
    for s in ax.spines.values():
        s.set_visible(False)
    ax.axhline(0.0, color=LGRY, lw=0.8, zorder=1)


def build_figure():
    fig = SPEC.figure()

    # ---- Left: five small-multiple Dyck paths ---------------------------- #
    hL = 0.52
    bL = Y0 - 0.125 * hL              # ylim (-0.5, 3.5) -> y0 at 12.5%
    w = 0.0956
    gap = 0.018
    x0 = 0.035
    for i, word in enumerate(DYCK_WORDS):
        ax = fig.add_axes([x0 + i * (w + gap), bL, w, hL])
        style_small(ax)
        xs, ys = path_coords(word)
        ax.plot(xs, ys, color=BLU, lw=1.7, solid_capstyle="round", zorder=3)
        ax.plot(xs, ys, "o", color=GRY, ms=3.0, zorder=4)

    fig.text(x0 + (5 * w + 4 * gap) / 2, bL - 0.075,
             r"$C_3 = 5$", fontsize=14, color="#222222", ha="center")

    # ---- Right: reflection principle ------------------------------------- #
    hR = 0.52
    bR = Y0 - (2.7 / 4.4) * hR        # ylim (-2.7, 1.7)
    ax = fig.add_axes([0.650, bR, 0.325, hR])
    ax.set_xlim(-0.35, 6.35)
    ax.set_ylim(-2.7, 1.7)
    ax.set_xticks([])
    ax.set_yticks([])
    for s in ax.spines.values():
        s.set_visible(False)

    # Forbidden zone y < 0.
    ax.axhspan(-2.7, 0.0, color=ORNG, alpha=0.16, zorder=0)
    ax.text(5.85, -2.42, "$y<0$", fontsize=12, color=ORNG,
            ha="right", style="italic")

    # x-axis baseline and the barrier y = -1.
    ax.axhline(0.0, color=LGRY, lw=0.8, zorder=1)
    ax.axhline(-1.0, color=GRY, ls=(0, (4, 3)), lw=1.0, zorder=1)
    ax.text(-0.28, -1.0, "$y=-1$", fontsize=11, color=GRY,
            ha="right", va="center")

    # Bad path UDDUDU: touches y=-1 first at (3,-1).
    bx, by = path_coords("UDDUDU")
    first = 3                              # index of first-touch point (3,-1)

    ax.plot(bx[:first], by[:first], color=BLU, lw=1.8,
            solid_capstyle="round", zorder=4)          # prefix
    ax.plot(bx[first - 1:first + 1], by[first - 1:first + 1],
            color=RED, lw=1.8, ls="--", zorder=5)      # first-touch step
    ax.plot(bx[first:], by[first:], color=GRY, lw=1.2, ls=":",
            alpha=0.7, zorder=3)                       # original tail

    # Reflected tail: flip the remaining steps -> ends at (6,-2).
    rx, ry = [bx[first]], [by[first]]
    for dx, dy in zip(np.diff(bx[first:]), np.diff(by[first:])):
        rx.append(rx[-1] + dx)
        ry.append(ry[-1] - dy)             # flip up/down
    ax.plot(rx, ry, color=GRN, lw=2.0, solid_capstyle="round", zorder=6)

    # Key points.
    ax.plot(bx, by, "o", color=GRY, ms=3.0, zorder=7)
    ax.plot(0, 0, "o", color=BLU, ms=5, zorder=8)
    ax.plot(6, 0, "o", color=GRY, ms=5, zorder=8)
    ax.plot(bx[first], by[first], "o", color=RED, ms=5.5, zorder=9)
    ax.plot(rx[-1], ry[-1], "o", color=GRN, ms=5.5, zorder=9)

    ax.text(bx[first] + 0.18, by[first] + 0.12, "first touch",
            fontsize=10, color=RED)
    ax.text(rx[-1] + 0.18, ry[-1] + 0.05, "$(6,-2)$",
            fontsize=11, color=GRN)
    ax.text(rx[1] + 0.10, ry[1] - 0.35, "reflected tail",
            fontsize=10, color=GRN)

    return fig


def main():
    fig = build_figure()
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    path = SPEC.save(fig, OUT_DIR / "dyck-paths")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
