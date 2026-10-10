"""Weierstrass function (a=1/2, b=3): global view + zoom showing scale-invariant oscillation.
Generates img/weierstrass-function.svg.  Run from the repository root:
  uv run "1.Analyse/Analyse Mathématique/scripts/weierstrass-function.py"
"""
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

BLUE, GRAY = "#3b6fb6", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "weierstrass-function.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "tmp" / "weierstrass-preview.png"

A, B = 0.5, 3.0  # b = 2k+1 with k = 1


def weierstrass(x, n_max):
    """Partial sum sum_{n=0}^{n_max} a^n cos(b^n pi x), vectorized over x."""
    w = np.zeros_like(x)
    for n in range(n_max + 1):
        w += A**n * np.cos((B**n) * np.pi * x)
    return w


def main():
    fig, axes = plt.subplots(1, 2, figsize=(8, 3))

    # Panel (a): global view on [-2, 2].  Terms n <= 10 (lambda_10 ~ 3.4e-5
    # resolves with sample spacing 2e-6); omitted amplitudes <= 0.5^11 ~ 5e-4.
    x1 = np.linspace(-2.0, 2.0, 2_000_001)
    w1 = weierstrass(x1, 10)
    ax = axes[0]
    ax.plot(x1, w1, color=BLUE, lw=0.5)
    ax.axvspan(1.31, 1.35, color=GRAY, alpha=0.18, lw=0)
    ax.set_xlim(-2.2, 2.2)
    ax.set_title(r"(a) $W(x)$ on $[-2,\,2]$", fontsize=10)

    # Panel (b): zoom of the shaded window [1.31, 1.35] (width 0.04).
    # Terms n <= 14 (lambda_14 ~ 3.8e-6 resolves with sample spacing 2e-8).
    x2 = np.linspace(1.31, 1.35, 2_000_001)
    w2 = weierstrass(x2, 14)
    ax = axes[1]
    ax.plot(x2, w2, color=BLUE, lw=0.6)
    ax.set_xlim(1.3095, 1.3505)
    ax.set_title(r"(b) zoom: $x \in [1.31,\,1.35]$", fontsize=10)

    for ax in axes:
        ax.set_xlabel(r"$x$", fontsize=9)
        ax.tick_params(labelsize=8)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", dpi=110, bbox_inches="tight", facecolor="white")


if __name__ == "__main__":
    main()
