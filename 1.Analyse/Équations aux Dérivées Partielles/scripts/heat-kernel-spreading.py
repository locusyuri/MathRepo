"""The one-dimensional heat kernel at four times.

Generates img/heat-kernel-spreading.svg: E(t, x) = (4*pi*t)^(-1/2) exp(-x^2/(4t))
for t = 0.05, 0.2, 0.8, 3 on a common axis.  Each curve encloses unit area; the
peak height (4*pi*t)^(-1/2) decreases while the width ~ sqrt(t) increases.

Run from the repository root:
    uv run "1.Analyse/Équations aux Dérivées Partielles/scripts/heat-kernel-spreading.py"
"""

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

TIMES = (0.05, 0.2, 0.8, 3.0)
COLORS = ("#b03a3a", "#d59a2a", "#4fa36a", "#3b6fb6")
OUT = Path(__file__).resolve().parent.parent / "img" / "heat-kernel-spreading.svg"


def kernel(t, x):
    """Heat kernel of the one-dimensional heat equation."""
    return np.exp(-x**2 / (4.0 * t)) / np.sqrt(4.0 * np.pi * t)


def main():
    fig, ax = plt.subplots(figsize=(7.2, 4.0))
    x = np.linspace(-7.0, 7.0, 2001)

    for t, color in zip(TIMES, COLORS):
        y = kernel(t, x)
        ax.plot(x, y, color=color, lw=1.8, label=rf"$t = {t:g}$")
        ax.fill_between(x, y, color=color, alpha=0.10, lw=0)

    # peak markers
    for t, color in zip(TIMES, COLORS):
        peak = 1.0 / np.sqrt(4.0 * np.pi * t)
        ax.plot([0.0], [peak], "o", color=color, ms=4)
        ax.annotate(rf"${peak:.2f}$", xy=(0.0, peak), xytext=(0.30, peak + 0.015),
                    fontsize=9, color=color,
                    bbox=dict(boxstyle="round,pad=0.12", fc="white", ec="none", alpha=0.9))

    ax.axhline(0.0, color="black", lw=0.8)
    ax.set_xlim(-7.0, 7.0)
    ax.set_ylim(0.0, 1.45)
    ax.set_xlabel(r"$x$", fontsize=11)
    ax.set_ylabel(r"$E(t, x)$", fontsize=11)
    for side in ("top", "right"):
        ax.spines[side].set_visible(False)

    ax.annotate("peak height $=(4\\pi t)^{-1/2}$\narea under each curve $=1$",
                xy=(-6.6, 1.18), fontsize=9.5, color="#2D2D2D", va="top")
    ax.legend(loc="upper right", frameon=False, fontsize=10)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT.with_suffix(".png"), dpi=150, bbox_inches="tight", facecolor="white")
    print(f"saved {OUT}")


if __name__ == "__main__":
    main()
