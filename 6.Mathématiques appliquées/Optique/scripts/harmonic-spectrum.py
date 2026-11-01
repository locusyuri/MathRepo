"""Harmonic analysis of a periodic motion: square-wave reconstruction (left) and its line spectrum (right).  Generates img/harmonic-spectrum.svg.  Run from the repository root:  uv run "6.Mathématiques appliquées/Optique/scripts/harmonic-spectrum.py"  Math check: the odd square wave has b_n = 4A/(n*pi) for odd n only, so the partial sums overshoot by the Wilbraham-Gibbs constant (2/pi)*integral_0^pi sin(t)/t dt = 1.0895... independently of the number of terms. """
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GREEN, GRAY = "#3b6fb6", "#c74440", "#2f9e44", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "harmonic-spectrum.svg"
OUT_PNG = OUT.with_suffix(".png")


def main():
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(9.8, 4.4))

    period = 2.0
    omega = 2.0 * np.pi / period
    t = np.linspace(0.0, 2.0 * period, 2000)
    square = np.sign(np.sin(omega * t))

    # ---- left: square wave and partial sums ----
    ax1.plot(t, square, color=GRAY, lw=1.0, ls=":", label="square wave")
    for n_max, color, label in [
        (1, GREEN, r"$N = 1$"),
        (3, BLUE, r"$N = 3$"),
        (9, RED, r"$N = 9$"),
    ]:
        partial = np.zeros_like(t)
        for n in range(1, n_max + 1, 2):
            partial += np.sin(n * omega * t) / n
        ax1.plot(t, 4.0 / np.pi * partial, color=color, lw=1.8, label=label)

    ax1.axhline(0.0, color="#cccccc", lw=0.8)
    ax1.set_xlim(0.0, 2.0 * period)
    ax1.set_ylim(-1.55, 1.55)
    ax1.set_xlabel(r"$t$", fontsize=11)
    ax1.set_ylabel(r"$x / A$", fontsize=11)
    ax1.set_title("square wave and partial sums", fontsize=11)
    ax1.set_xticks([])
    ax1.legend(loc="upper center", bbox_to_anchor=(0.5, -0.2), ncol=4, fontsize=9, frameon=False)
    ax1.grid(alpha=0.2)

    # ---- right: line spectrum ----
    n = np.arange(1, 16, 2)
    amp = 4.0 / (np.pi * n)
    ax2.vlines(n, 0.0, amp, color=BLUE, lw=2.0)
    ax2.plot(n, amp, "o", color=BLUE, ms=5.0)
    ax2.axhline(0.0, color="#cccccc", lw=0.8)
    ax2.set_xlim(0.0, 16.0)
    ax2.set_ylim(0.0, 1.45)
    ax2.set_xlabel(r"harmonic order $n$", fontsize=11)
    ax2.set_ylabel(r"$A_n / A = 4 / (n \pi)$", fontsize=11)
    ax2.set_title("line spectrum", fontsize=11)
    ax2.set_xticks(n)
    ax2.grid(alpha=0.2)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
