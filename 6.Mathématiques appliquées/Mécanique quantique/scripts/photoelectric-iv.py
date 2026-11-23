"""Photocurrent against retarding voltage: same frequency with two intensities, and one higher frequency.
Generates img/photoelectric-iv.svg.  Run from the repository root:
  uv run "6.Mathématiques appliquées/Mécanique quantique/scripts/photoelectric-iv.py"
"""
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

BLUE, LIGHTBLUE, RED, GRAY = "#3b6fb6", "#7ea6d9", "#c74440", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "photoelectric-iv.svg"
OUT_PNG = OUT.with_suffix(".png")


def photocurrent(voltage, u0, i_sat, width=0.11):
    """Rising branch above the stopping voltage, saturating for accelerating voltages."""
    curve = i_sat * (1.0 - np.exp(-(voltage + u0) / width))
    return np.where(voltage < -u0, 0.0, curve)


def main() -> None:
    fig, ax = plt.subplots(figsize=(8.6, 5.4))
    u = np.linspace(-2.4, 1.2, 900)

    ax.plot(u, photocurrent(u, 0.90, 1.00), color=BLUE, lw=2.1,
            label=r"$\nu$ fixed, high intensity")
    ax.plot(u, photocurrent(u, 0.90, 0.52), color=LIGHTBLUE, lw=2.1, ls="--",
            label=r"$\nu$ fixed, low intensity")
    ax.plot(u, photocurrent(u, 1.60, 0.80), color=RED, lw=2.1,
            label=r"higher $\nu$")

    for u0, col in ((0.90, BLUE), (1.60, RED)):
        ax.axvline(-u0, color=col, lw=1.0, ls=":")
        ax.plot([-u0], [0.0], marker="o", color=col, ms=5)
        ax.annotate(rf"$-U_0 = -{u0:.1f}$ V", xy=(-u0, 0.0),
                    xytext=(-u0 - 0.05, 0.16), ha="right", fontsize=10, color=col)

    ax.set_xlim(-2.4, 1.2)
    ax.set_ylim(0.0, 1.15)
    ax.set_xlabel(r"retarding voltage $U$ (V)", fontsize=12)
    ax.set_ylabel("photocurrent (arb. units)", fontsize=12)
    ax.axhline(0.0, color=GRAY, lw=0.8)
    ax.legend(loc="upper left", fontsize=10, frameon=False)
    ax.grid(alpha=0.22)
    ax.tick_params(labelsize=11)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
