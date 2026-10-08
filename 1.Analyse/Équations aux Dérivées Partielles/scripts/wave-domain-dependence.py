"""Domains of dependence, determinacy and influence for the 1-D wave equation.

Generates img/wave-domain-dependence.svg (three panels):
  (a) backward characteristic cone and the domain of dependence B(x0, a t0);
  (b) domain of determinacy of an interval D of the initial line;
  (c) domain of influence of a point y of the initial line.

Run from the repository root:  uv run "1.Analyse/Équations aux Dérivées Partielles/scripts/wave-domain-dependence.py"
"""

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

A = 1.0  # wave speed (a = 1 for the picture)
BLUE = "#3b6fb6"
RED = "#c74440"
OUT = Path(__file__).resolve().parent.parent / "img" / "wave-domain-dependence.svg"


def setup_axes(ax, xlim, tmax):
    ax.set_xlim(*xlim)
    ax.set_ylim(0, tmax)
    ax.set_aspect("equal")
    for side in ("top", "right"):
        ax.spines[side].set_visible(False)
    ax.spines["left"].set_position("zero")
    ax.spines["bottom"].set_position("zero")
    ax.set_xticks([])
    ax.set_yticks([])
    ax.annotate("$x$", xy=(xlim[1], 0), xytext=(xlim[1] - 0.12, -0.16), fontsize=12)
    ax.annotate("$t$", xy=(0, tmax), xytext=(-0.18, tmax - 0.12), fontsize=12)


def main():
    fig, axes = plt.subplots(1, 3, figsize=(10.2, 3.7))

    # ------------------------------------------------------------------ (a)
    ax = axes[0]
    x0, t0 = 0.0, 1.2
    setup_axes(ax, (-2.4, 2.4), 2.1)
    xs = np.array([x0 - A * t0, x0, x0 + A * t0])
    ax.fill(xs, [0, t0, 0], color=BLUE, alpha=0.16, lw=0)
    ax.plot([x0 - A * t0, x0, x0 + A * t0], [0, t0, 0], color=BLUE, lw=1.6)
    ax.plot([x0 - A * t0, x0 + A * t0], [0, 0], color=RED, lw=4, solid_capstyle="butt")
    ax.plot([x0], [t0], "o", color=RED, ms=5)
    ax.annotate(r"apex $(x_0,\,t_0)$", xy=(x0, t0), xytext=(0.42, 1.7), fontsize=10,
                color=RED, arrowprops=dict(arrowstyle="-", color=RED, lw=0.7))
    ax.annotate(r"$B(x_0,\,a t_0)$" + "\n" + "domain of dependence",
                xy=(x0 + A * t0 * 0.62, 0), xytext=(0.82, 0.9), fontsize=9,
                color=RED, ha="left",
                arrowprops=dict(arrowstyle="-", color=RED, lw=0.7))
    ax.annotate("backward\ncharacteristic cone", xy=(-0.82, 0.62), xytext=(-2.28, 1.5),
                fontsize=9, color=BLUE,
                arrowprops=dict(arrowstyle="-", color=BLUE, lw=0.7))
    ax.set_title(r"(a) domain of dependence", fontsize=10.5)

    # ------------------------------------------------------------------ (b)
    ax = axes[1]
    x1, x2 = -1.1, 1.1
    t_apex = (x2 - x1) / (2 * A)
    setup_axes(ax, (-2.4, 2.4), 2.1)
    xs = np.array([x1, (x1 + x2) / 2, x2])
    ax.fill(xs, [0, t_apex, 0], color=BLUE, alpha=0.16, lw=0)
    ax.plot([x1, (x1 + x2) / 2, x2], [0, t_apex, 0], color=BLUE, lw=1.6)
    ax.plot([x1, x2], [0, 0], color=RED, lw=4, solid_capstyle="butt")
    ax.annotate(r"data interval $D$", xy=(x2 * 0.78, 0), xytext=(1.32, 0.5),
                fontsize=9, color=RED, va="bottom",
                arrowprops=dict(arrowstyle="-", color=RED, lw=0.7))
    ax.annotate("domain of determinacy" + "\n" + r"$\{(x,t):\ B(x,at)\subset D\}$",
                xy=(0.02, t_apex * 0.55), xytext=(0.66, 1.28), fontsize=9,
                arrowprops=dict(arrowstyle="-", color="black", lw=0.7))
    ax.set_title(r"(b) domain of determinacy", fontsize=10.5)

    # ------------------------------------------------------------------ (c)
    ax = axes[2]
    y, tmax = 0.0, 1.4
    setup_axes(ax, (-2.4, 2.4), 2.1)
    xs = np.array([y - A * tmax, y, y + A * tmax])
    ax.fill(xs, [tmax, 0, tmax], color=BLUE, alpha=0.16, lw=0)
    ax.plot([y - A * tmax, y, y + A * tmax], [tmax, 0, tmax], color=BLUE, lw=1.6)
    ax.plot([y], [0], "o", color=RED, ms=5)
    ax.annotate(r"$y$", xy=(y, 0), xytext=(-0.38, 0.12), fontsize=11, color=RED)
    ax.annotate("domain of influence" + "\n" + r"$\{(x,t):\ |x-y|\leq a t\}$",
                xy=(y + A * 0.9 * tmax * 0.75, 0.9 * tmax * 0.75), xytext=(0.7, 1.62),
                fontsize=9, arrowprops=dict(arrowstyle="-", color="black", lw=0.7))
    ax.set_title(r"(c) domain of influence", fontsize=10.5)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight")
    print(f"saved {OUT}")


if __name__ == "__main__":
    main()
