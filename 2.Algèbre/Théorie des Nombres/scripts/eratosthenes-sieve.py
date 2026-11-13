"""Sieve of Eratosthenes: 10x10 grid of 1-100 with the composite marks.

Single square panel, opaque white background, clean academic typesetting
(serif figures, thin light-grey cell rules, no title, no decorations).

- 1 is greyed out with a light-grey strikethrough.
- The 25 primes survive as white-background bold dark digits.
- The 74 composites get a diagonal strike (lower-left to upper-right) whose
  colour records the prime round that first removes them:
    red    - first round, p = 2   (49 even numbers)
    orange - second round, p = 3  (16 odd multiples of 3)
    blue   - third round, p = 5   (6 multiples untouched by 2 and 3)
    green  - fourth round, p = 7  (3 multiples untouched by 2, 3 and 5)
A small legend block sits in the bottom-right corner.

Run with: uv run python src/math_paper/eratosthenes_sieve.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

# Opaque white background, serif (textbook) fonts, portrait-ish panel.
SPEC = replace(Presets.SVG_TEXTBOOK, figsize=(9.6, 12.0), pad_inches=0.06,
               transparent=False, facecolor="white")
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#333333"
PRIME = "#111111"
LIGHT = "#9a9a9a"
ONE_BG = "#e2e2e2"
GRID_C = "#d5d5d5"
CELL_C = "#b8b8b8"

RED = "#c0392b"
ORANGE = "#e67e22"
BLUE = "#2980b9"
GREEN = "#27ae60"

FACTOR_COLOR = {2: RED, 3: ORANGE, 5: BLUE, 7: GREEN}


def min_prime_factor(n: int) -> int:
    """Smallest prime divisor of the composite n (n <= 100 here)."""
    for p in (2, 3, 5, 7):
        if n % p == 0:
            return p
    raise ValueError(f"unexpected composite: {n}")


def _slash_cell(ax, c: int, r: int, color: str, inset: float = 0.09):
    """Diagonal (visual lower-left to upper-right) strike inside a cell."""
    x0, x1 = c + inset, c + 1 - inset
    # data y grows downward, so visual lower-left is the larger y
    y0, y1 = r + 1 - inset, r + inset
    ax.plot([x0, x1], [y0, y1], color=color, lw=1.4, solid_capstyle="butt",
            zorder=3)


def _swatch(ax, cx, cy, slash_color, digit=None, bold=False):
    """Small white square used inside the legend block."""
    s = 0.42
    ax.add_patch(plt.Rectangle((cx - s / 2, cy - s / 2), s, s,
                               facecolor="white", edgecolor=CELL_C,
                               lw=0.8, zorder=2))
    if slash_color is not None:
        ax.plot([cx - 0.15, cx + 0.15], [cy + 0.15, cy - 0.15],
                color=slash_color, lw=1.4, zorder=3)
    if digit is not None:
        ax.text(cx, cy, digit, ha="center", va="center", fontsize=9.5,
                color=PRIME, fontweight="bold" if bold else "normal",
                zorder=4)


def panel(ax):
    # ---- 10x10 cell rules -------------------------------------------------
    for x in range(11):
        ax.plot([x, x], [0.0, 10.0], color=GRID_C, lw=0.8, zorder=1)
    for y in range(11):
        ax.plot([0.0, 10.0], [y, y], color=GRID_C, lw=0.8, zorder=1)

    primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47,
              53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
    prime_set = set(primes)

    counts = {2: 0, 3: 0, 5: 0, 7: 0}
    slash_queue = []  # draw strikes after the digits so they cross them

    for r in range(10):            # r = 0 is the top row
        for c in range(10):
            n = r * 10 + c + 1
            cx, cy = c + 0.5, r + 0.5
            if n == 1:
                ax.add_patch(plt.Rectangle((c, r), 1.0, 1.0,
                                           facecolor=ONE_BG, edgecolor="none",
                                           zorder=0.5))
                ax.text(cx, cy, "1", ha="center", va="center", fontsize=13,
                        color=LIGHT, zorder=2)
                ax.plot([cx - 0.16, cx + 0.16], [cy, cy], color="#c0c0c0",
                        lw=0.9, zorder=3)
            elif n in prime_set:
                ax.text(cx, cy, str(n), ha="center", va="center", fontsize=13,
                        color=PRIME, fontweight="bold", zorder=2)
            else:
                p = min_prime_factor(n)
                counts[p] += 1
                ax.text(cx, cy, str(n), ha="center", va="center", fontsize=13,
                        color=INK, zorder=2)
                slash_queue.append((c, r, FACTOR_COLOR[p]))

    for c, r, color in slash_queue:
        _slash_cell(ax, c, r, color)

    assert counts == {2: 49, 3: 16, 5: 6, 7: 3}, counts
    assert 1 + len(prime_set) + sum(counts.values()) == 100

    # ---- legend block (bottom-right corner) ------------------------------
    rows = [
        (10.42, RED, "crossed out by 2"),
        (10.96, ORANGE, "crossed out by 3"),
        (11.50, BLUE, "crossed out by 5"),
        (12.04, GREEN, "crossed out by 7"),
        (12.58, None, "prime (survivor)"),
    ]
    cx = 5.85
    for y, color, label in rows:
        if color is None:
            _swatch(ax, cx + 0.32, y, None, digit="97", bold=True)
        else:
            _swatch(ax, cx, y, color)
        ax.text(cx + 0.75, y, label, ha="left", va="center", fontsize=10.5,
                color=INK, zorder=4)

    ax.set_xlim(-0.5, 10.5)
    ax.set_ylim(13.45, -0.5)   # top row first, legend space at the bottom
    ax.set_aspect("equal")
    ax.axis("off")


def build_figure():
    fig = SPEC.figure()
    panel(fig.add_subplot(111))
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "eratosthenes-sieve")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
