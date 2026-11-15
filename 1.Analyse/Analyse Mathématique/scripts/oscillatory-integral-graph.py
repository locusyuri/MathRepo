"""Graph of the integrand 1 / (1 + x^6 sin^2 x) of the oscillatory integral.

The function stays below 1 and spikes to almost 1 at every x = k pi, where the
sin^2 x factor vanishes; the spikes become narrower as k grows, which is what
makes the improper integral converge.

Output: img/oscillatory-integral-graph.svg
"""

from __future__ import annotations

import os
from math import pi
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "oscillatory-integral-graph.svg")

INK = "#1f2933"
GHOST = "#9aa5b1"
CURVE = "#c0392b"

X_MAX = 4 * pi
X_RIGHT = 4.45 * pi          # the last spike is drawn in full


def integrand(x):
    return 1.0 / (1.0 + x ** 6 * np.sin(x) ** 2)


def samples(periods=4, n=6000, m=2000):
    """One panel per period, with extra points near both ends of each."""
    parts = []
    for k in range(periods):
        base = np.linspace(0, pi, n)
        near = np.geomspace(1e-10, 0.08, m)
        u = np.unique(np.concatenate([base, near, pi - near]))
        parts.append(k * pi + u)
    return np.concatenate(parts)


def main():
    fig = plt.figure(figsize=(9.2, 4.3))
    ax = fig.add_axes([0.055, 0.10, 0.93, 0.87])

    x = samples(periods=5)
    keep = x <= X_RIGHT
    ax.plot(x[keep], integrand(x[keep]), color=CURVE, lw=1.4, zorder=3,
            solid_joinstyle="round")

    # Reference level y = 1.
    ax.axhline(1.0, color=GHOST, lw=0.8, ls=(0, (5, 3)), zorder=1)

    # Axes with arrows.
    ax.annotate("", xy=(X_RIGHT * 1.01, 0), xytext=(0, 0),
                annotation_clip=False,
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.1,
                                shrinkA=0, shrinkB=0, mutation_scale=11))
    ax.annotate("", xy=(0, 1.18), xytext=(0, 0), annotation_clip=False,
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.1,
                                shrinkA=0, shrinkB=0, mutation_scale=11))
    ax.text(X_RIGHT * 1.02, -0.06, r"$x$", fontsize=12, color=INK, ha="left",
            va="top")
    ax.text(-0.30, 1.16, r"$y$", fontsize=12, color=INK, ha="right",
            va="center")
    ax.text(-0.16, -0.05, r"$O$", fontsize=11, color=INK, ha="right", va="top")

    ax.set_xlim(0, X_RIGHT)
    ax.set_ylim(0, 1.14)
    ax.set_xticks([0, pi, 2 * pi, 3 * pi, 4 * pi])
    ax.set_xticklabels([r"$0$", r"$\pi$", r"$2\pi$", r"$3\pi$", r"$4\pi$"],
                       fontsize=11)
    ax.set_yticks([0, 0.5, 1.0])
    ax.set_yticklabels([r"$0$", r"$1/2$", r"$1$"], fontsize=11)
    ax.tick_params(colors=INK, length=3, width=0.8, pad=3)
    for side in ("top", "right"):
        ax.spines[side].set_visible(False)
    ax.spines["left"].set_color(INK)
    ax.spines["bottom"].set_color(INK)
    ax.spines["left"].set_linewidth(0.9)
    ax.spines["bottom"].set_linewidth(0.9)

    fig.savefig(OUT, transparent=True, bbox_inches="tight", pad_inches=0.02)
    print(f"Saved: {OUT}")

    if os.environ.get("PREVIEW"):
        preview = OUT.with_name("oscillatory-integral-graph-preview.png")
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.02)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
