"""Huygens' principle: sharp front in odd dimensions vs trailing wake in even ones.

Generates img/wave-huygens-principle.svg (two panels in the (x, t)-plane):
  (a) n = 3: the value depends only on data on the sphere -> two characteristic
      strips; a fixed receiver is silent once the sphere has crossed the support;
  (b) n = 2: the value depends on data on the whole disk -> the full forward
      cone is filled with a trailing wake.

Run from the repository root:
  uv run "1.Analyse/Équations aux Dérivées Partielles/scripts/wave-huygens-principle.py"
"""

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

A = 1.0
ALPHA, BETA = -1.0, 1.0  # support of the initial data
X0 = 2.5  # fixed receiver
TMAX = 4.0
BLUE = "#3b6fb6"
RED = "#c74440"
GRAY = "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "wave-huygens-principle.svg"


def setup(ax, title):
    ax.set_xlim(-2.6, 4.4)
    ax.set_ylim(0, TMAX)
    ax.set_aspect("equal")
    for side in ("top", "right"):
        ax.spines[side].set_visible(False)
    ax.spines["left"].set_position("zero")
    ax.spines["bottom"].set_position("zero")
    ax.set_xticks([])
    ax.set_yticks([])
    ax.annotate("$x$", xy=(4.4, 0), xytext=(4.2, -0.3), fontsize=11)
    ax.annotate("$t$", xy=(0, TMAX), xytext=(-0.35, TMAX - 0.3), fontsize=11)
    ax.plot([ALPHA, BETA], [0, 0], color=RED, lw=4, solid_capstyle="butt")
    ax.annotate("initial support", xy=(0, 0), xytext=(-1.15, -0.75), fontsize=9,
                color=RED)
    ax.plot([X0, X0], [0, TMAX], ls="--", color=GRAY, lw=1.0)
    ax.annotate(r"$x_0$", xy=(X0, 0), xytext=(X0 + 0.1, -0.3), fontsize=11)
    ax.set_title(title, fontsize=10.5)


def main():
    ts = np.array([0, TMAX])

    fig, axes = plt.subplots(1, 2, figsize=(9.8, 3.9))

    # ------------------------------------------------------------- (a) n = 3
    ax = axes[0]
    setup(ax, "(a) $n=3$: sharp front (strong Huygens)")
    # two characteristic strips: x - a t in [alpha, beta] and x + a t in [alpha, beta]
    ax.fill([ALPHA, ALPHA + TMAX, BETA + TMAX, BETA],
            [0, TMAX, TMAX, 0], color=BLUE, alpha=0.14, lw=0)
    ax.fill([BETA, BETA - TMAX, ALPHA - TMAX, ALPHA],
            [0, TMAX, TMAX, 0], color=BLUE, alpha=0.14, lw=0)
    ax.plot(ALPHA + A * ts, ts, color=BLUE, lw=1.3)
    ax.plot(BETA + A * ts, ts, color=BLUE, lw=1.3)
    ax.plot(ALPHA - A * ts, ts, color=BLUE, lw=1.3)
    ax.plot(BETA - A * ts, ts, color=BLUE, lw=1.3)
    t_in, t_out = X0 - BETA, X0 - ALPHA
    ax.plot([X0, X0], [t_in, t_out], color=BLUE, lw=4, solid_capstyle="butt")
    ax.annotate(r"$u(x_0,t)\neq 0$", xy=(X0, (t_in + t_out) / 2),
                xytext=(2.62, 3.35), fontsize=9, color=BLUE,
                arrowprops=dict(arrowstyle="-", color=BLUE, lw=0.7))
    ax.annotate("silence once the sphere\nhas crossed the support",
                xy=(X0, (t_out + TMAX) / 2 + 0.05), xytext=(-2.45, 3.15),
                fontsize=9, arrowprops=dict(arrowstyle="-", color="black", lw=0.7))

    # ------------------------------------------------------------- (b) n = 2
    ax = axes[1]
    setup(ax, "(b) $n=2$: trailing wake (weak Huygens)")
    # the whole forward cone of the support is filled with signal
    ax.fill([ALPHA, ALPHA - TMAX, BETA + TMAX, BETA],
            [0, TMAX, TMAX, 0], color=BLUE, alpha=0.14, lw=0)
    ax.plot(ALPHA - A * ts, ts, color=BLUE, lw=1.3)
    ax.plot(BETA + A * ts, ts, color=BLUE, lw=1.3)
    ax.plot([X0, X0], [t_in, TMAX], color=BLUE, lw=4, solid_capstyle="butt")
    ax.annotate("wake persists for all $t$" + "\n" + r"with $|u|\lesssim t^{-1/2}$",
                xy=(X0, 3.55), xytext=(0.05, 2.2), fontsize=9, color=BLUE,
                arrowprops=dict(arrowstyle="-", color=BLUE, lw=0.7))
    ax.annotate("the disk $B(x_0,at)$ keeps\nmeeting the support",
                xy=(1.85, 1.4), xytext=(-2.45, 0.6), fontsize=9,
                arrowprops=dict(arrowstyle="-", color="black", lw=0.7))

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    print(f"saved {OUT}")


if __name__ == "__main__":
    main()
