"""Hopf bifurcation: bifurcation diagram and phase portrait.
Generates img/hopf-bifurcation.svg (add --png for a PNG preview).
Run from repository root: uv run "1.Analyse/Équation Différentielle Ordinaire/scripts/hopf-bifurcation.py"
"""
from pathlib import Path
import sys
import numpy as np
import matplotlib.pyplot as plt

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"
IMG = Path(__file__).resolve().parent.parent / "img"
OUT = IMG / "hopf-bifurcation.svg"

MU = 0.2


def diagram(ax):
    mu_n = np.linspace(-1.0, 0, 100)
    mu_p = np.linspace(0, 1.0, 100)
    ax.plot(mu_n, np.zeros_like(mu_n), color=BLUE, lw=1.6)
    ax.plot(mu_p, np.zeros_like(mu_p), color=BLUE, lw=1.6, ls="--")
    ax.plot(mu_p, np.sqrt(mu_p), color=RED, lw=1.6)
    ax.set_title(r"bifurcation diagram", fontsize=10)
    ax.set_xlabel(r"$\mu$", fontsize=11)
    ax.set_ylabel(r"$r$", fontsize=11)
    ax.set_xlim(-1.0, 1.0)
    ax.set_ylim(-0.1, 1.1)
    ax.annotate(r"stable cycle", xy=(0.6, np.sqrt(0.6)), xytext=(0.25, 0.95),
                fontsize=8, color=RED,
                arrowprops=dict(arrowstyle="->", color=RED, lw=0.8))
    ax.annotate("stable\nequilibrium", xy=(-0.55, 0.0), xytext=(-0.95, 0.35),
                fontsize=8, color=BLUE,
                arrowprops=dict(arrowstyle="->", color=BLUE, lw=0.8))


def portrait(ax):
    xs = np.linspace(-0.8, 0.8, 300)
    ys = np.linspace(-0.8, 0.8, 300)
    X, Y = np.meshgrid(xs, ys)
    dX = MU * X - Y - X * (X**2 + Y**2)
    dY = X + MU * Y - Y * (X**2 + Y**2)
    ax.streamplot(X, Y, dX, dY, color=GRAY, density=1.1, linewidth=0.6,
                  arrowsize=0.6)

    r = np.sqrt(MU)
    theta = np.linspace(0, 2 * np.pi, 400)
    ax.plot(r * np.cos(theta), r * np.sin(theta), color=RED, lw=1.8,
            label="limit cycle")
    ax.plot(0, 0, "o", color=BLUE, markersize=5, label="unstable focus")
    ax.set_title(rf"phase portrait at $\mu = {MU}$", fontsize=10)
    ax.set_xlabel("$x$", fontsize=11)
    ax.set_ylabel("$y$", fontsize=11)
    ax.set_xlim(-0.8, 0.8)
    ax.set_ylim(-0.8, 0.8)
    ax.set_aspect("equal")
    ax.legend(fontsize=8, loc="upper right")


def main():
    fig, axes = plt.subplots(1, 2, figsize=(9, 3.6))
    diagram(axes[0])
    portrait(axes[1])
    for ax in axes:
        ax.tick_params(labelsize=8)
        ax.grid(alpha=0.2)

    fig.tight_layout()
    fig.savefig(OUT, format="svg")
    if "--png" in sys.argv:
        fig.savefig(IMG / "hopf-bifurcation.png", format="png", dpi=150)
    print(f"Saved: {OUT}")


if __name__ == "__main__":
    main()
