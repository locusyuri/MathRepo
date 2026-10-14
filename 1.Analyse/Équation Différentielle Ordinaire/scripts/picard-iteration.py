"""Picard iteration convergence for y' = y, y(0) = 1.
Generates img/picard-iteration.svg.
Run from repository root: uv run "1.Analyse/Équation Différentielle Ordinaire/scripts/picard-iteration.py"
"""
from pathlib import Path
import numpy as np
import matplotlib.pyplot as plt

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "picard-iteration.svg"


def main():
    fig, ax = plt.subplots(figsize=(6, 4.5))

    x = np.linspace(0, 2, 200)

    # Exact solution y = e^x
    y_exact = np.exp(x)
    ax.plot(x, y_exact, color=RED, linewidth=2, linestyle="--",
            label="Exact solution $y = e^x$")

    # Picard iterates: y_0 = 1, y_{n+1} = 1 + integral_0^x y_n(t) dt
    # y_0 = 1
    y0 = np.ones_like(x)
    ax.plot(x, y0, color=GRAY, linewidth=1, alpha=0.5, label="Iteration 0")

    # y_1 = 1 + x
    y1 = 1 + x
    ax.plot(x, y1, color=BLUE, linewidth=1.2, alpha=0.6, label="Iteration 1")

    # y_2 = 1 + x + x^2/2
    y2 = 1 + x + x**2 / 2
    ax.plot(x, y2, color=BLUE, linewidth=1.4, alpha=0.75, label="Iteration 2")

    # y_3 = 1 + x + x^2/2 + x^3/6
    y3 = 1 + x + x**2 / 2 + x**3 / 6
    ax.plot(x, y3, color=BLUE, linewidth=1.6, alpha=0.9, label="Iteration 3")

    ax.set_xlabel("$x$", fontsize=12)
    ax.set_ylabel("$y$", fontsize=12)
    ax.set_title("Picard Iteration Convergence for $y' = y, y(0) = 1$", fontsize=11)
    ax.set_xlim(0, 2)
    ax.set_ylim(0, 8)
    ax.legend(fontsize=9, loc="upper left")
    ax.grid(alpha=0.3)

    fig.tight_layout()
    fig.savefig(OUT, format="svg")
    print(f"Saved: {OUT}")


if __name__ == "__main__":
    main()
