"""Bifurcation diagrams of the three equilibrium prototypes.
Generates img/bifurcation-diagrams.svg (add --png for a PNG preview).
Run from repository root: uv run "1.Analyse/Équation Différentielle Ordinaire/scripts/bifurcation-diagrams.py"
"""
from pathlib import Path
import sys
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"
IMG = Path(__file__).resolve().parent.parent / "img"
OUT = IMG / "bifurcation-diagrams.svg"


def saddle_node(ax):
    mu = np.linspace(0, 1.2, 200)
    ax.plot(mu, np.sqrt(mu), color=BLUE, lw=1.6)
    ax.plot(mu, -np.sqrt(mu), color=BLUE, lw=1.6, ls="--")
    ax.set_title(r"saddle-node:  $\dot{x} = \mu - x^2$", fontsize=10)
    ax.set_xlim(-0.35, 1.2)
    ax.set_ylim(-1.15, 1.15)


def transcritical(ax):
    mu_n = np.linspace(-1.0, 0, 100)
    mu_p = np.linspace(0, 1.0, 100)
    ax.plot(mu_n, np.zeros_like(mu_n), color=BLUE, lw=1.6)
    ax.plot(mu_p, np.zeros_like(mu_p), color=BLUE, lw=1.6, ls="--")
    ax.plot(mu_n, mu_n, color=BLUE, lw=1.6, ls="--")
    ax.plot(mu_p, mu_p, color=BLUE, lw=1.6)
    ax.set_title(r"transcritical:  $\dot{x} = \mu x - x^2$", fontsize=10)
    ax.set_xlim(-1.0, 1.0)
    ax.set_ylim(-1.15, 1.15)


def pitchfork(ax):
    mu_n = np.linspace(-0.6, 0, 100)
    mu_p = np.linspace(0, 1.2, 200)
    ax.plot(mu_n, np.zeros_like(mu_n), color=BLUE, lw=1.6)
    ax.plot(mu_p, np.zeros_like(mu_p), color=BLUE, lw=1.6, ls="--")
    ax.plot(mu_p, np.sqrt(mu_p), color=BLUE, lw=1.6)
    ax.plot(mu_p, -np.sqrt(mu_p), color=BLUE, lw=1.6)
    ax.set_title(r"pitchfork:  $\dot{x} = \mu x - x^3$", fontsize=10)
    ax.set_xlim(-0.6, 1.2)
    ax.set_ylim(-1.15, 1.15)


def main():
    fig, axes = plt.subplots(1, 3, figsize=(10, 3.4))

    for ax, draw in zip(axes, (saddle_node, transcritical, pitchfork)):
        draw(ax)
        ax.axhline(0, color=GRAY, lw=0.5, zorder=0)
        ax.axvline(0, color=GRAY, lw=0.5, zorder=0)
        ax.set_xlabel(r"$\mu$", fontsize=11)
        ax.set_ylabel(r"$x$", fontsize=11)
        ax.tick_params(labelsize=8)
        ax.grid(alpha=0.2)

    handles = [
        Line2D([0], [0], color=BLUE, lw=1.6, label="stable equilibrium"),
        Line2D([0], [0], color=BLUE, lw=1.6, ls="--", label="unstable equilibrium"),
    ]
    axes[2].legend(handles=handles, fontsize=8, loc="upper left")

    fig.tight_layout()
    fig.savefig(OUT, format="svg")
    if "--png" in sys.argv:
        fig.savefig(IMG / "bifurcation-diagrams.png", format="png", dpi=150)
    print(f"Saved: {OUT}")


if __name__ == "__main__":
    main()
