"""The first three standing-wave modes of a string with fixed ends (Ch 15).
Generates img/wave-standing-waves.svg: modes sin(k*pi*x/L) for k = 1, 2, 3
in three panels, nodes marked, fixed ends marked, frequencies in ratio 1:2:3.
Run from the repository root:  uv run "1.Analyse/Équations aux Dérivées Partielles/scripts/wave-standing-waves.py"
"""
from pathlib import Path
import tempfile

import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "wave-standing-waves.svg"
PNG = Path(tempfile.gettempdir()) / "wave-standing-waves-preview.png"

L = 1.0
MODES = (1, 2, 3)
PANEL = ("(a)", "(b)", "(c)")
FREQ = r"$\omega_1 = a\pi/L$", r"$\omega_2 = 2a\pi/L$", r"$\omega_3 = 3a\pi/L$"

def main():
    fig, axes = plt.subplots(1, 3, figsize=(9.6, 3.2), sharey=True)
    x = np.linspace(0, L, 400)
    for ax, k, tag, om in zip(axes, MODES, PANEL, FREQ):
        y = np.sin(k * np.pi * x / L)
        ax.plot(x, y, color=BLUE, lw=2.2)
        ax.fill_between(x, y, 0, color=BLUE, alpha=0.12)

        # fixed ends
        ax.plot([0, L], [0, 0], "o", color="black", ms=6, zorder=5)

        # interior nodes
        nodes = np.arange(1, k) * L / k
        ax.plot(nodes, np.zeros_like(nodes), "x", color=RED, ms=8,
                mew=1.8, zorder=5)

        # equilibrium line
        ax.axhline(0, color=GRAY, lw=0.8, alpha=0.6)

        ax.set_xlim(-0.06, 1.06)
        ax.set_xticks([0, 1])
        ax.set_xticklabels(["0", "$L$"])
        ax.set_ylim(-1.55, 1.62)
        ax.set_title(f"{tag} $k={k}$, {om}", fontsize=10.5, pad=10)
        ax.set_xlabel(r"$x$", fontsize=10)
        ax.spines[["top", "right"]].set_visible(False)

    axes[0].set_ylabel(r"$X_k$", fontsize=10)
    axes[0].annotate("fixed ends", xy=(0.0, 0.0), xytext=(0.10, -1.15),
                     fontsize=9, color="black",
                     arrowprops=dict(arrowstyle="-", color="black", lw=0.7))
    axes[1].annotate("interior node", xy=(0.5, 0), xytext=(0.40, -1.15),
                     fontsize=9, color=RED,
                     arrowprops=dict(arrowstyle="-", color=RED, lw=0.7))
    axes[2].annotate("antinode", xy=(0.5, 1.0), xytext=(0.62, 1.28),
                     fontsize=9, color=BLUE,
                     arrowprops=dict(arrowstyle="-", color=BLUE, lw=0.7))

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PNG, format="png", dpi=150, bbox_inches="tight",
                facecolor="white")  # preview only; the SVG stays transparent
    print(f"saved {OUT}\npreview {PNG}")

if __name__ == "__main__":
    main()
