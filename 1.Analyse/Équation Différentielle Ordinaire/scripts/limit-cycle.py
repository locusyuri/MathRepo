"""Limit cycle phase portrait (van der Pol oscillator).
Generates img/limit-cycle.svg.
Run from repository root: uv run "1.Analyse/Équation Différentielle Ordinaire/scripts/limit-cycle.py"
"""
from pathlib import Path
import numpy as np
import matplotlib.pyplot as plt

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "limit-cycle.svg"


def main():
    fig, ax = plt.subplots(figsize=(6, 5))

    # Van der Pol oscillator: x' = y, y' = mu(1 - x^2)y - x
    mu = 0.8
    x = np.linspace(-3, 3, 300)
    y = np.linspace(-3, 3, 300)
    X, Y = np.meshgrid(x, y)
    dXdt = Y
    dYdt = mu * (1 - X**2) * Y - X

    # Streamplot
    ax.streamplot(X, Y, dXdt, dYdt, color=BLUE, density=1.3, linewidth=0.7)

    # Mark the limit cycle (approximate: largest closed orbit)
    # Numerically integrate from an initial point inside and outside
    def integrate(x0, y0, t_max=30, dt=0.01):
        xs, ys = [x0], [y0]
        x, y = x0, y0
        for _ in range(int(t_max / dt)):
            dx = y
            dy = mu * (1 - x**2) * y - x
            x += dx * dt
            y += dy * dt
            xs.append(x)
            ys.append(y)
        return np.array(xs), np.array(ys)

    # Inside trajectory spirals out
    x_in, y_in = integrate(0.1, 0.1)
    ax.plot(x_in[500:], y_in[500:], color=RED, linewidth=1.2, alpha=0.7,
            label="Inside trajectory (spirals out)")

    # Outside trajectory spirals in
    x_out, y_out = integrate(2.5, 2.5)
    ax.plot(x_out[500:], y_out[500:], color=GRAY, linewidth=1.2, alpha=0.7,
            label="Outside trajectory (spirals in)")

    ax.plot(0, 0, "ko", markersize=5, label="Equilibrium")
    ax.set_xlabel("$x$", fontsize=12)
    ax.set_ylabel("$y$", fontsize=12)
    ax.set_title("Limit Cycle (Van der Pol Oscillator)", fontsize=12)
    ax.set_xlim(-3, 3)
    ax.set_ylim(-3, 3)
    ax.legend(fontsize=9, loc="upper right")
    ax.grid(alpha=0.3)

    fig.tight_layout()
    fig.savefig(OUT, format="svg")
    print(f"Saved: {OUT}")


if __name__ == "__main__":
    main()
