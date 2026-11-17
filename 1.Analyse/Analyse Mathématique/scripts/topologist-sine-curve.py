"""The topologist's sine curve: connected but not path-connected.

Left panel: the graph $y = sin(1/x)$ on $(0, 1]$ together with the vertical
segment ${0} times [-1, 1]$.  As $x -> 0^+$ the graph oscillates between
$-1$ and $1$, so its closure adds the whole segment, and the union is
connected.

Right panel: a schematic of a path that tries to leave the vertical segment.
Any such path would have to cross graph points with arbitrarily small $x$,
where the oscillation is unbounded in frequency; uniform continuity of the
path on $[0, 1]$ forbids this.

Output: img/topologist-sine-curve.svg
"""

from __future__ import annotations

import os
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import Rectangle

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "topologist-sine-curve.svg")

INK = "#1f2933"
GRAY = "#c8ccd0"
ACCENT = "#c0392b"

XMIN = 8.0e-4          # left end of the sampled graph in panel (a)
XSPLIT = 0.03          # switch from the dense to the sparse sampling
N_DENSE = 60000
N_SPARSE = 20000


def panel_a(ax):
    x = np.concatenate([
        np.linspace(XMIN, XSPLIT, N_DENSE),
        np.linspace(XSPLIT, 1.0, N_SPARSE),
    ])
    ax.plot(x, np.sin(1.0 / x), color=INK, lw=0.55, zorder=2)
    ax.plot([0.0, 0.0], [-1.0, 1.0], color=INK, lw=2.4,
            solid_capstyle="round", zorder=3)

    ax.text(0.02, -1.22, "$0$", fontsize=10, color=INK, ha="left", va="top")
    ax.text(1.0, -1.22, "$1$", fontsize=10, color=INK, ha="center", va="top")
    ax.text(-0.10, 1.0, "$1$", fontsize=10, color=INK, ha="right", va="center")
    ax.text(-0.10, -1.0, "$-1$", fontsize=10, color=INK, ha="right",
            va="center")

    ax.annotate("", xy=(1.06, -1.22), xytext=(-0.02, -1.22),
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=0.9))
    ax.text(1.07, -1.22, "$x$", fontsize=10, color=INK, ha="left", va="center")

    ax.set_xlim(-0.22, 1.22)
    ax.set_ylim(-1.34, 1.26)
    ax.set_aspect("auto")
    ax.axis("off")
    ax.set_title("(a)  $S$: graph plus vertical segment", fontsize=10,
                 color=INK, pad=6)


def panel_b(ax):
    # Oscillatory band near the y-axis, drawn as a shaded strip with a few
    # representative oscillations.
    ax.add_patch(Rectangle((0.0, -1.0), 0.16, 2.0, facecolor=GRAY,
                           edgecolor="none", alpha=0.75, zorder=1))
    xs = np.linspace(0.011, 0.16, 900)
    ax.plot(xs, np.sin(1.0 / xs), color=INK, lw=0.6, zorder=2,
            clip_on=True)
    ax.plot([0.0, 0.0], [-1.0, 1.0], color=INK, lw=2.4,
            solid_capstyle="round", zorder=3)

    # Attempted path leaving the vertical segment.
    ax.plot([0.0, 0.16], [0.35, 0.60], color=ACCENT, lw=1.8, ls=(0, (5, 3)),
            zorder=4)
    ax.plot([0.16], [0.60], marker="o", ms=4.5, color=ACCENT, zorder=5)
    ax.plot([0.235], [0.60], marker="x", ms=9, mew=2.2, color=ACCENT,
            zorder=6)
    ax.text(0.31, 0.60, "impossible crossing", fontsize=9, color=ACCENT,
            ha="left", va="center")

    # A further graph point that such a path would have to reach.
    x_target = 0.62
    y_target = np.sin(1.0 / x_target)
    ax.plot([x_target], [y_target], marker="o", ms=4.5, color=INK, zorder=5)
    ax.text(x_target + 0.04, y_target - 0.14, "graph point", fontsize=9,
            color=INK, ha="left", va="top")

    ax.text(0.55, -0.96, "$x \\to 0^+$ oscillation", fontsize=9, color=INK,
            ha="center", va="center")

    ax.set_xlim(-0.06, 1.02)
    ax.set_ylim(-1.20, 1.20)
    ax.set_aspect("auto")
    ax.axis("off")
    ax.set_title("(b)  no path leaves the segment", fontsize=10, color=INK,
                 pad=6)


def main():
    fig, (ax_a, ax_b) = plt.subplots(
        1, 2, figsize=(7.2, 2.9), gridspec_kw={"width_ratios": (1.0, 1.05)}
    )
    fig.subplots_adjust(left=0.015, right=0.985, top=0.86, bottom=0.04,
                        wspace=0.10)
    panel_a(ax_a)
    panel_b(ax_b)

    fig.savefig(OUT, transparent=True, bbox_inches="tight", pad_inches=0.02)
    print(f"Saved: {OUT}")

    if os.environ.get("PREVIEW"):
        preview = OUT.with_name("topologist-sine-curve-preview.png")
        fig.savefig(preview, dpi=170, facecolor="white",
                    bbox_inches="tight", pad_inches=0.02)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
