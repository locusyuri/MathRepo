"""The binary entropy function h(p) = -p log p - (1-p) log(1-p).

Concave, vanishing at both degenerate ends and maximal at the fair coin
(p = 1/2, h = 1 bit).  The chord joining (0, 0) to (1, 0) is drawn to make the
strict concavity visible: the graph stays strictly above it.

Output: ../img/binary-entropy-curve.svg
"""

from __future__ import annotations

import os
import sys
from dataclasses import replace
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(6.0, 4.0))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1f2933"
MUTED = "#8b949e"
BLUE = "#1f4e9b"
FILL = "#dbe8f7"


def binary_entropy(p):
    p = np.clip(p, 1e-12, 1 - 1e-12)
    return -p * np.log2(p) - (1 - p) * np.log2(1 - p)


def main():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)

    p = np.linspace(0.0, 1.0, 801)
    h = binary_entropy(p)
    ax.fill_between(p, h, 0, color=FILL, alpha=0.35, zorder=1)
    ax.plot(p, h, color=BLUE, lw=2.0, zorder=3)

    # Chord from p = 0 to p = 1 (the real axis), illustrating concavity.
    ax.plot([0, 1], [0, 0], color=MUTED, lw=1.4, ls=(0, (6, 3)), zorder=4)
    ax.text(0.5, 0.045, "chord", fontsize=9, color=MUTED, ha="center",
            va="bottom",
            bbox=dict(boxstyle="round,pad=0.18", fc="white", ec="none",
                      alpha=0.85))

    # Maximum at the fair coin.
    ax.plot([0.5], [1.0], "o", color=BLUE, ms=5, zorder=4)
    ax.plot([0.5, 0.5], [0, 1.0], color=MUTED, lw=0.8, ls=(0, (3, 3)), zorder=2)
    ax.annotate(r"$h(1/2) = 1$", xy=(0.5, 1.0), xytext=(0.53, 0.70),
                fontsize=10, color=BLUE, ha="left",
                arrowprops=dict(arrowstyle="-", color=BLUE, lw=0.8))

    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1.12)
    ax.set_xticks([0, 0.25, 0.5, 0.75, 1])
    ax.set_xticklabels(["0", r"$1/4$", r"$1/2$", r"$3/4$", r"$1$"],
                       fontsize=10)
    ax.set_yticks([0, 0.5, 1])
    ax.set_yticklabels(["0", r"$0.5$", r"$1$"], fontsize=10)
    ax.set_xlabel(r"$p$", fontsize=11, color=INK)
    ax.set_ylabel(r"$h(p)$", fontsize=11, color=INK)
    ax.tick_params(colors=INK, length=3)
    for side in ("top", "right"):
        ax.spines[side].set_visible(False)
    for side in ("left", "bottom"):
        ax.spines[side].set_color(MUTED)

    path = SPEC.save(fig, OUT_DIR / "binary-entropy-curve")
    print(f"Saved: {path}")

    if os.environ.get("PREVIEW"):
        preview = OUT_DIR / "binary-entropy-curve-preview.png"
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.05)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
