"""The defining chord inequality for a convex function.

For x_1 < x_2 and t in (0, 1), the chord joining (x_1, f(x_1)) and
(x_2, f(x_2)) lies above the graph at the convex combination
t x_1 + (1 - t) x_2:
  f(t x_1 + (1 - t) x_2) <= t f(x_1) + (1 - t) f(x_2).

Output: img/convex-function.svg
"""

from __future__ import annotations

import os
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

OUT = Path(__file__).resolve().parent.parent / "img" / "convex-function.svg"

INK = "#1f2933"
MAGENTA = "#c2189b"
GHOST = "#b0b8c1"

X1, X2 = 1.30, 6.00
T = 0.55                       # convex combination parameter
XT = T * X1 + (1 - T) * X2


def f(x):
    """A strictly convex curve, steeper on the right."""
    return 0.11 * (x - 2.5) ** 2 + 0.62 + 0.02 * np.exp(0.8 * (x - 2.5))


def main():
    f1, f2 = f(X1), f(X2)
    chord = lambda x: f1 + (x - X1) * (f2 - f1) / (X2 - X1)
    y_curve, y_chord = f(XT), chord(XT)

    fig = plt.figure(figsize=(9.4, 4.8))
    ax = fig.add_axes([0, 0, 1, 1])
    ax.set_xlim(-3.45, 7.65)
    ax.set_ylim(-0.55, 4.35)
    ax.axis("off")

    # Coordinate axes.
    ax.annotate("", xy=(7.55, 0), xytext=(0, 0),
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.1,
                                shrinkA=0, shrinkB=0, mutation_scale=12))
    ax.annotate("", xy=(0, 4.25), xytext=(0, 0),
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.1,
                                shrinkA=0, shrinkB=0, mutation_scale=12))

    # The graph and its chord.
    x = np.linspace(0.85, 6.95, 400)
    ax.plot(x, f(x), color=INK, lw=1.8, solid_capstyle="round", zorder=3)
    xc = np.linspace(0.85, 7.30, 100)
    ax.plot(xc, chord(xc), color=MAGENTA, lw=1.7, zorder=2)
    ax.text(6.48, f(6.48) + 0.24, r"$f(x)$", fontsize=15, color=INK,
            ha="center", va="bottom")

    # Guide lines.
    for xx, top in ((X1, f1), (XT, y_chord), (X2, f2)):
        ax.plot([xx, xx], [0, top], color=GHOST, lw=0.9, ls=(0, (2, 3)),
                zorder=1)
    for yy in (y_curve, y_chord):
        ax.plot([0, XT], [yy, yy], color=GHOST, lw=0.9, ls=(0, (2, 3)),
                zorder=1)

    # Labels on the x-axis.
    ax.text(X1, -0.16, r"$x_1$", ha="center", va="top", fontsize=13,
            color=INK)
    ax.text(XT, -0.16, r"$t x_1 + (1 - t) x_2$", ha="center", va="top",
            fontsize=13, color=INK)
    ax.text(X2, -0.16, r"$x_2$", ha="center", va="top", fontsize=13,
            color=INK)

    # Labels aligned with the two horizontal guides.
    ax.text(-0.22, y_chord, r"$t\,f(x_1) + (1 - t)\,f(x_2)$", ha="right",
            va="center", fontsize=13, color=INK)
    ax.text(-0.22, y_curve, r"$f(t x_1 + (1 - t) x_2)$", ha="right",
            va="center", fontsize=13, color=INK)

    fig.savefig(OUT, transparent=True, bbox_inches="tight", pad_inches=0.05)
    print(f"Saved: {OUT}")

    if os.environ.get("PREVIEW"):
        preview = OUT.with_name("convex-function-preview.png")
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.05)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
