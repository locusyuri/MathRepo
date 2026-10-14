"""Lyapunov function level sets and trajectory decay.
Generates img/lyapunov-function.svg.
Run from repository root: uv run "1.Analyse/Équation Différentielle Ordinaire/scripts/lyapunov-function.py"
"""
from pathlib import Path
import numpy as np
import matplotlib.pyplot as plt

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "lyapunov-function.svg"


def main():
    fig, ax = plt.subplots(figsize=(6, 5))

    # Lyapunov function V(x, y) = x^2 + y^2 (circles)
    x = np.linspace(-2, 2, 200)
    y = np.linspace(-2, 2, 200)
    X, Y = np.meshgrid(x, y)
    V = X**2 + Y**2

    # Contour plot
    contours = ax.contour(X, Y, V, levels=[0.5, 1, 2, 3, 4],
                         colors=GRAY, linewidths=0.8, linestyles="--")
    ax.clabel(contours, inline=True, fontsize=8, fmt="$V = %g$")

    # Trajectory: system x' = -x, y' = -y (converges to origin)
    # Start from (1.5, 1.5)
    t = np.linspace(0, 3, 100)
    x_traj = 1.5 * np.exp(-t)
    y_traj = 1.5 * np.exp(-t)
    ax.plot(x_traj, y_traj, color=BLUE, linewidth=2, label="Trajectory")
    ax.plot(x_traj[-1], y_traj[-1], "ko", markersize=5)

    # Direction arrows along trajectory
    for i in range(10, 100, 15):
        ax.annotate("", xy=(x_traj[i+1], y_traj[i+1]),
                    xytext=(x_traj[i], y_traj[i]),
                    arrowprops=dict(arrowstyle="->", color=BLUE, lw=1.5))

    ax.plot(0, 0, "ro", markersize=6, label="Equilibrium $V = 0$")
    ax.set_xlabel("$x$", fontsize=12)
    ax.set_ylabel("$y$", fontsize=12)
    ax.set_title("Lyapunov Function $V(x,y) = x^2 + y^2$ and Trajectory", fontsize=11)
    ax.set_xlim(-2, 2)
    ax.set_ylim(-2, 2)
    ax.legend(fontsize=9, loc="upper right")
    ax.set_aspect("equal")
    ax.grid(alpha=0.3)

    fig.tight_layout()
    fig.savefig(OUT, format="svg")
    print(f"Saved: {OUT}")


if __name__ == "__main__":
    main()
