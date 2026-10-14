"""Phase portraits of four critical point types: node, saddle, focus, center.
Generates img/phase-plane-types.svg (2x2 panel).
Run from repository root: uv run "1.Analyse/Équation Différentielle Ordinaire/scripts/phase-plane-types.py"
"""
from pathlib import Path
import numpy as np
import matplotlib.pyplot as plt

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "phase-plane-types.svg"


def plot_node(ax):
    """Stable node: eigenvalues both negative."""
    x = np.linspace(-2, 2, 200)
    y = np.linspace(-2, 2, 200)
    X, Y = np.meshgrid(x, y)
    dXdt = -X
    dYdt = -2 * Y
    ax.streamplot(X, Y, dXdt, dYdt, color=BLUE, density=1.2, linewidth=0.8)
    ax.plot(0, 0, "ko", markersize=5)
    ax.set_title("Stable Node", fontsize=11)
    ax.set_xlabel("$x$")
    ax.set_ylabel("$y$")


def plot_saddle(ax):
    """Saddle: eigenvalues opposite signs."""
    x = np.linspace(-2, 2, 200)
    y = np.linspace(-2, 2, 200)
    X, Y = np.meshgrid(x, y)
    dXdt = X
    dYdt = -Y
    ax.streamplot(X, Y, dXdt, dYdt, color=BLUE, density=1.2, linewidth=0.8)
    ax.plot(0, 0, "ko", markersize=5)
    ax.set_title("Saddle", fontsize=11)
    ax.set_xlabel("$x$")
    ax.set_ylabel("$y$")


def plot_focus(ax):
    """Stable focus: complex eigenvalues with negative real part."""
    x = np.linspace(-2, 2, 200)
    y = np.linspace(-2, 2, 200)
    X, Y = np.meshgrid(x, y)
    dXdt = -X - Y
    dYdt = X - Y
    ax.streamplot(X, Y, dXdt, dYdt, color=BLUE, density=1.2, linewidth=0.8)
    ax.plot(0, 0, "ko", markersize=5)
    ax.set_title("Stable Focus", fontsize=11)
    ax.set_xlabel("$x$")
    ax.set_ylabel("$y$")


def plot_center(ax):
    """Center: purely imaginary eigenvalues."""
    x = np.linspace(-2, 2, 200)
    y = np.linspace(-2, 2, 200)
    X, Y = np.meshgrid(x, y)
    dXdt = -Y
    dYdt = X
    ax.streamplot(X, Y, dXdt, dYdt, color=BLUE, density=1.2, linewidth=0.8)
    ax.plot(0, 0, "ko", markersize=5)
    ax.set_title("Center", fontsize=11)
    ax.set_xlabel("$x$")
    ax.set_ylabel("$y$")


def main():
    fig, axes = plt.subplots(2, 2, figsize=(8, 7))
    plot_node(axes[0, 0])
    plot_saddle(axes[0, 1])
    plot_focus(axes[1, 0])
    plot_center(axes[1, 1])
    fig.suptitle("Classification of Critical Points in the Phase Plane", fontsize=13, y=1.02)
    fig.tight_layout()
    fig.savefig(OUT, format="svg", bbox_inches="tight")
    print(f"Saved: {OUT}")


if __name__ == "__main__":
    main()
