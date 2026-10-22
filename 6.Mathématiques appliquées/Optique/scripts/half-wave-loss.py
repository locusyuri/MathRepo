"""Standing waves at a fixed end (node, R = -1, half-wave loss) and at a free end (antinode, R = +1).  Generates img/half-wave-loss.svg.  Run from the repository root:  uv run "6.Mathématiques appliquées/Optique/scripts/half-wave-loss.py"  Math check: R = (Z1 - Z2)/(Z1 + Z2), so Z2 -> infinity gives R = -1 and Z2 = 0 gives R = +1. Fixed end: u = A sin(kx) with k L = n pi, L = 2 gives k = pi/2 and a node at x = 0. Free end: u = A cos(kx) with k L = (2n-1) pi/2, L = 2 gives k = pi/4 and an antinode at x = 0. Snapshots at wt = 0, pi/3, pi/2 have amplitudes 1, 0.5, 0. """
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GREEN, GRAY = "#3b6fb6", "#c74440", "#2f9e44", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "half-wave-loss.svg"
OUT_PNG = OUT.with_suffix(".png")

L = 2.0
x = np.linspace(-L, 0.0, 800)
PHASES = [(0.0, 1.0, BLUE), (np.pi / 3.0, 0.5, GREEN), (np.pi / 2.0, 0.0, GRAY)]


def panel(ax, shape, title, boundary_label, marker):
    k = np.pi / (2.0 * L) if shape == "cos" else np.pi / L
    profile = np.cos(k * x) if shape == "cos" else np.sin(k * x)
    for phase, amp, color in PHASES:
        ax.plot(x, amp * profile, color=color, lw=2.0, alpha=0.9)
    ax.axhline(0.0, color="#cccccc", lw=0.8)
    ax.axvline(0.0, color="black", lw=1.4)

    # nodes of the spatial profile
    nodes = x[np.where(np.abs(np.diff(np.sign(profile + 1e-12))) > 1)[0] + 1]
    ax.plot(nodes, np.zeros_like(nodes), "o", color="black", ms=6)

    if marker == "node":
        ax.plot([0.0], [0.0], "o", color=RED, ms=10)
    else:
        ax.plot([0.0], [1.0], "o", mfc="white", mec=RED, mew=2.0, ms=10)

    ax.text(-1.0, 1.24, boundary_label, color=RED, fontsize=11, ha="center")
    ax.set_ylim(-1.35, 1.45)
    ax.set_xlim(-L - 0.05, 0.35)
    ax.set_ylabel(r"$u$", fontsize=12)
    ax.set_title(title, fontsize=12)
    ax.grid(alpha=0.2)


def main():
    fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(8.8, 6.2), sharex=True)

    panel(ax1, "sin",
          r"fixed end: $R = -1$, phase jump $\pi$ (half-wave loss)",
          "node at the wall", "node")
    panel(ax2, "cos",
          r"free end: $R = +1$, no phase jump",
          "antinode at the free end", "antinode")
    ax2.set_xlabel(r"$x$", fontsize=12)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
