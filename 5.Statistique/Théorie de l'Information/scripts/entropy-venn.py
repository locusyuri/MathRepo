"""Venn diagram of the entropy identities for two random variables.

Two circles of areas H(X) and H(Y) overlap; the crescents are the conditional
entropies H(X|Y) and H(Y|X), the overlap is the mutual information I(X;Y), and
the union is the joint entropy H(X,Y) = H(X) + H(Y) - I(X;Y).

Output: ../img/entropy-venn.svg
"""

from __future__ import annotations

import os
import sys
from dataclasses import replace
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import Circle

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(5.6, 3.9))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1f2933"
BLUE = "#1f4e9b"
BLUE_FILL = "#dbe8f7"
ORANGE = "#b3541e"
ORANGE_FILL = "#fbe3d0"

RADIUS = 1.0
OFFSET = 0.62


def main():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)
    ax.set_aspect("equal")
    ax.set_xlim(-1.85, 1.85)
    ax.set_ylim(-1.45, 1.45)
    ax.axis("off")

    ax.add_patch(Circle((-OFFSET, 0), RADIUS, facecolor=BLUE_FILL,
                        edgecolor=BLUE, lw=1.4, alpha=0.85, zorder=1))
    ax.add_patch(Circle((OFFSET, 0), RADIUS, facecolor=ORANGE_FILL,
                        edgecolor=ORANGE, lw=1.4, alpha=0.70, zorder=2))

    ax.text(-1.02, 0.0, r"$H(X\mid Y)$", ha="center", va="center",
            fontsize=11, color=INK, zorder=4)
    ax.text(0.0, 0.0, r"$I(X;Y)$", ha="center", va="center", fontsize=11,
            color=INK, zorder=4)
    ax.text(1.02, 0.0, r"$H(Y\mid X)$", ha="center", va="center",
            fontsize=11, color=INK, zorder=4)

    ax.text(-OFFSET, 1.14, r"$H(X)$", ha="center", va="bottom", fontsize=11,
            color=BLUE)
    ax.text(OFFSET, 1.14, r"$H(Y)$", ha="center", va="bottom", fontsize=11,
            color=ORANGE)
    ax.text(0.0, -1.30, r"$H(X,Y) = H(X) + H(Y) - I(X;Y)$", ha="center",
            va="top", fontsize=10.5, color=INK)

    path = SPEC.save(fig, OUT_DIR / "entropy-venn")
    print(f"Saved: {path}")

    if os.environ.get("PREVIEW"):
        preview = OUT_DIR / "entropy-venn-preview.png"
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.05)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
