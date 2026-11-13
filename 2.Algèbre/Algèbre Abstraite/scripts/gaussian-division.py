"""Division with remainder in the Gaussian integers.

Generates img/gaussian-division.svg.  Run from the repository root:

    uv run "2.Algèbre/Algèbre Abstraite/scripts/gaussian-division.py"

The quotient z / w lies in Q(i); the lattice drawn is Z[i].  Rounding both
coordinates lands on the nearest lattice point q, whose distance to z / w is at
most sqrt(2)/2.  Hence N(z/w - q) <= 1/2 < 1, which is the inequality
N(r) < N(w) needed for the Euclidean property.
"""
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import Circle

OUT = Path(__file__).resolve().parent.parent / "img" / "gaussian-division.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "gaussian-division-preview.png"

INK = "#22262e"
BLUE = "#3b6fb6"
RED = "#c74440"
GREEN = "#3f7d4f"
GRAY = "#9aa0a8"

P = (0.30, 0.62)          # the point z / w
Q = (0.0, 1.0)            # the nearest lattice point
R = (2 ** 0.5 / 2, )      # radius of the rounding disc


def main():
    fig, ax = plt.subplots(figsize=(5.4, 5.2))
    ax.set_xlim(-1.30, 1.55)
    ax.set_ylim(-2.35, 1.80)
    ax.set_aspect("equal")
    ax.axis("off")

    # grid
    for k in range(-1, 3):
        ax.plot([-1.2, 1.9], [k, k], color=GRAY, linewidth=0.7, zorder=1)
        ax.plot([k, k], [-1.2, 1.9], color=GRAY, linewidth=0.7, zorder=1)

    # lattice points
    for i in range(-1, 2):
        for j in range(-1, 2):
            ax.add_patch(Circle((i, j), 0.035, facecolor=INK, edgecolor="none", zorder=4))

    # the unit cell containing P
    ax.add_patch(plt.Rectangle((0, 0), 1, 1, facecolor=BLUE, alpha=0.08,
                               edgecolor=BLUE, linewidth=1.4, zorder=2))

    # rounding disc around the nearest lattice point
    ax.add_patch(Circle(Q, R[0], facecolor=GREEN, alpha=0.10, edgecolor=GREEN,
                        linewidth=1.2, linestyle=(0, (4, 3)), zorder=2))

    # the points and the remainder vector
    ax.add_patch(Circle(P, 0.045, facecolor=RED, edgecolor="none", zorder=6))
    ax.text(P[0] + 0.10, P[1] - 0.04, "$z \\/ w$", fontsize=11.5, color=RED,
            ha="left", va="top")
    ax.annotate("", xy=P, xytext=Q,
                arrowprops=dict(arrowstyle="-|>", color=GREEN, linewidth=1.6,
                                mutation_scale=13), zorder=5)
    ax.text(0.13, 1.10, "$z \\/ w - q$", fontsize=11, color=GREEN,
            ha="left", va="bottom")

    # axes labels and the two half-integer lines
    ax.plot([-1.2, 1.9], [0, 0], color=INK, linewidth=1.0, zorder=3)
    ax.plot([0, 0], [-1.2, 1.9], color=INK, linewidth=1.0, zorder=3)
    ax.text(1.86, -0.12, "$\\mathrm{Re}$", fontsize=10.5, color=INK, ha="right", va="top")
    ax.text(0.08, 1.9, "$\\mathrm{Im}$", fontsize=10.5, color=INK, ha="left", va="center")

    # annotation
    ax.text(-1.30, -1.45,
            "round each coordinate of $z \\/ w$ to the nearest integer:\n"
            "$|\\mathrm{Re}(z \\/ w - q)| \\leq 1/2$,  "
            "$|\\mathrm{Im}(z \\/ w - q)| \\leq 1/2$,\n"
            "hence $N(z \\/ w - q) \\leq 1/2$ and $N(r) < N(w)$",
            fontsize=10.2, color=INK, ha="left", va="top", linespacing=1.7)

    fig.tight_layout(pad=0.4)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
