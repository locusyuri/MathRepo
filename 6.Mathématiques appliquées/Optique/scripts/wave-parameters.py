"""Wave description: waveform (u vs x) versus vibration (u vs t), and the geometric picture of wavefronts and rays.  Generates img/wave-parameters.svg.  Run from the repository root:  uv run "6.Mathématiques appliquées/Optique/scripts/wave-parameters.py"  Math check: with u = A cos(kx - wt), the spatial period is lambda = 2*pi/k and the temporal period is T = 2*pi/w; the plot uses lambda = 2 and T = 1, so v = lambda/T = 2 in the same units. """
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GREEN, GRAY = "#3b6fb6", "#c74440", "#2f9e44", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "wave-parameters.svg"
OUT_PNG = OUT.with_suffix(".png")


def main():
    fig = plt.figure(figsize=(9.8, 5.2))
    gs = fig.add_gridspec(2, 2, width_ratios=[1.15, 1.0], hspace=0.55, wspace=0.28)

    lam, period = 2.0, 1.0  # lambda and T in arbitrary units; v = lam / period = 2

    # ---- top left: waveform u(x) at fixed t ----
    ax1 = fig.add_subplot(gs[0, 0])
    x = np.linspace(0.0, 2.0 * lam, 600)
    ax1.plot(x, np.cos(2.0 * np.pi * x / lam), color=BLUE, lw=2.2)
    ax1.annotate("", xy=(0.5, -1.28), xytext=(0.5 + lam, -1.28),
                 arrowprops=dict(arrowstyle="<->", color=GRAY, lw=1.1))
    ax1.text(0.5 + lam / 2, -1.52, r"$\lambda$", ha="center", fontsize=12)
    ax1.axhline(0.0, color="#cccccc", lw=0.8)
    ax1.set_ylim(-1.7, 1.25)
    ax1.set_xlim(0.0, 2.0 * lam)
    ax1.set_xlabel(r"$x$", fontsize=11)
    ax1.set_ylabel(r"$u$", fontsize=11)
    ax1.set_title("waveform: snapshot at fixed $t$", fontsize=11)
    ax1.set_xticks([])
    ax1.grid(alpha=0.2)

    # ---- bottom left: vibration u(t) at fixed x ----
    ax2 = fig.add_subplot(gs[1, 0])
    t = np.linspace(0.0, 2.0 * period, 600)
    ax2.plot(t, np.cos(2.0 * np.pi * t / period), color=RED, lw=2.2)
    ax2.annotate("", xy=(0.25, -1.28), xytext=(0.25 + period, -1.28),
                 arrowprops=dict(arrowstyle="<->", color=GRAY, lw=1.1))
    ax2.text(0.25 + period / 2, -1.52, r"$T = \lambda / v$", ha="center", fontsize=11)
    ax2.axhline(0.0, color="#cccccc", lw=0.8)
    ax2.set_ylim(-1.7, 1.25)
    ax2.set_xlim(0.0, 2.0 * period)
    ax2.set_xlabel(r"$t$", fontsize=11)
    ax2.set_ylabel(r"$u$", fontsize=11)
    ax2.set_title("vibration: history of one particle", fontsize=11)
    ax2.set_xticks([])
    ax2.grid(alpha=0.2)

    # ---- right: plane-wave wavefronts and rays ----
    ax3 = fig.add_subplot(gs[:, 1])
    for i in range(5):
        xv = 0.6 + i * 0.9
        ax3.plot([xv, xv], [0.0, 4.5], color=BLUE, lw=1.6)
    for yv in np.linspace(0.35, 4.15, 4):
        ax3.annotate("", xy=(4.6, yv), xytext=(0.3, yv),
                     arrowprops=dict(arrowstyle="-|>", color=GREEN, lw=1.0))
    ax3.text(1.05, 4.62, "wavefronts", color=BLUE, fontsize=11, ha="center")
    ax3.text(2.45, 2.25, "rays", color=GREEN, fontsize=11)
    ax3.set_xlim(0.0, 4.9)
    ax3.set_ylim(-0.2, 5.0)
    ax3.set_xlabel(r"$x$", fontsize=11)
    ax3.set_ylabel(r"$y$", fontsize=11)
    ax3.set_title("plane wave: wavefronts and rays", fontsize=11)
    ax3.set_xticks([])
    ax3.set_yticks([])
    ax3.set_aspect("equal")

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
