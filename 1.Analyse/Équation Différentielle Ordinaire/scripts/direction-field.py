"""Direction field with typical integral curves for y' = x - y.
Generates img/direction-field.svg.
Run from repository root: uv run "1.Analyse/Équation Différentielle Ordinaire/scripts/direction-field.py"
"""
from pathlib import Path
import numpy as np
import matplotlib.pyplot as plt

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "direction-field.svg"


def f(x, y):
    return x - y


def main():
    fig, ax = plt.subplots(figsize=(6, 4.5))

    # Direction field grid
    x = np.linspace(-1, 4, 20)
    y = np.linspace(-1, 3, 16)
    X, Y = np.meshgrid(x, y)
    dYdX = f(X, Y)
    # Normalize arrows
    step = 0.15
    dx = step / np.sqrt(1 + dYdX**2)
    dy = dYdX * dx
    ax.quiver(X, Y, dx, dy, angles="xy", scale_units="xy", scale=1,
              color=GRAY, alpha=0.6, width=0.0025)

    # Integral curves (exact solution y = x - 1 + C e^{-x})
    x_curve = np.linspace(-1, 4, 200)
    for C in [-2, -0.5, 1, 2.5]:
        y_curve = x_curve - 1 + C * np.exp(-x_curve)
        ax.plot(x_curve, y_curve, color=BLUE, linewidth=1.5)

    # Particular solution (C=0, equilibrium)
    ax.plot(x_curve, x_curve - 1, color=RED, linewidth=2, linestyle="--",
            label="Particular solution $y = x - 1$")

    ax.set_xlabel("$x$", fontsize=12)
    ax.set_ylabel("$y$", fontsize=12)
    ax.set_title("Direction Field and Integral Curves for $y' = x - y$", fontsize=12)
    ax.set_xlim(-1, 4)
    ax.set_ylim(-1, 3)
    ax.legend(fontsize=10, loc="upper right")
    ax.grid(alpha=0.3)

    fig.tight_layout()
    fig.savefig(OUT, format="svg")
    print(f"Saved: {OUT}")


if __name__ == "__main__":
    main()
