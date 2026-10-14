"""Solutions of constant-coefficient ODEs for different characteristic root types.
Generates img/characteristic-roots-solutions.svg (2x2 panel).
Run from repository root: uv run "1.Analyse/Équation Différentielle Ordinaire/scripts/characteristic-roots-solutions.py"
"""
from pathlib import Path
import numpy as np
import matplotlib.pyplot as plt

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "characteristic-roots-solutions.svg"


def plot_real_roots(ax):
    """Real distinct roots: y = C1 e^{x} + C2 e^{-2x}"""
    x = np.linspace(0, 3, 200)
    ax.plot(x, np.exp(x), color=BLUE, linewidth=1.5, label="$e^{x}$")
    ax.plot(x, np.exp(-2 * x), color=RED, linewidth=1.5, label="$e^{-2x}$")
    ax.plot(x, np.exp(x) - 0.5 * np.exp(-2 * x), color=GRAY, linewidth=1.2,
            linestyle="--", label="General solution")
    ax.set_title("Real Distinct Roots", fontsize=11)
    ax.set_xlabel("$x$")
    ax.set_ylabel("$y$")
    ax.legend(fontsize=8)
    ax.grid(alpha=0.3)


def plot_complex_roots(ax):
    """Complex roots: y = e^{-x/2} (C1 cos x + C2 sin x)"""
    x = np.linspace(0, 10, 300)
    ax.plot(x, np.exp(-x / 2) * np.cos(x), color=BLUE, linewidth=1.5,
            label="$e^{-x/2} \\cos x$")
    ax.plot(x, np.exp(-x / 2) * np.sin(x), color=RED, linewidth=1.5,
            label="$e^{-x/2} \\sin x$")
    ax.plot(x, np.exp(-x / 2), color=GRAY, linewidth=1, linestyle="--",
            label="Envelope $e^{-x/2}$")
    ax.plot(x, -np.exp(-x / 2), color=GRAY, linewidth=1, linestyle="--")
    ax.set_title("Complex Roots (Damped Oscillation)", fontsize=11)
    ax.set_xlabel("$x$")
    ax.set_ylabel("$y$")
    ax.legend(fontsize=8)
    ax.grid(alpha=0.3)


def plot_repeated_root(ax):
    """Repeated root: y = (C1 + C2 x) e^{lambda x}"""
    x = np.linspace(0, 2, 200)
    ax.plot(x, np.exp(2 * x), color=BLUE, linewidth=1.5, label="$e^{2x}$")
    ax.plot(x, x * np.exp(2 * x), color=RED, linewidth=1.5, label="$x e^{2x}$")
    ax.plot(x, (1 + 0.5 * x) * np.exp(2 * x), color=GRAY, linewidth=1.2,
            linestyle="--", label="General solution")
    ax.set_title("Repeated Root (Multiplicity 2)", fontsize=11)
    ax.set_xlabel("$x$")
    ax.set_ylabel("$y$")
    ax.legend(fontsize=8)
    ax.grid(alpha=0.3)


def plot_pure_imaginary(ax):
    """Pure imaginary roots: y = C1 cos x + C2 sin x"""
    x = np.linspace(0, 4 * np.pi, 300)
    ax.plot(x, np.cos(x), color=BLUE, linewidth=1.5, label="$\\cos x$")
    ax.plot(x, np.sin(x), color=RED, linewidth=1.5, label="$\\sin x$")
    ax.plot(x, np.cos(x) + np.sin(x), color=GRAY, linewidth=1.2,
            linestyle="--", label="General solution")
    ax.set_title("Pure Imaginary Roots (Undamped)", fontsize=11)
    ax.set_xlabel("$x$")
    ax.set_ylabel("$y$")
    ax.legend(fontsize=8)
    ax.grid(alpha=0.3)


def main():
    fig, axes = plt.subplots(2, 2, figsize=(9, 7))
    plot_real_roots(axes[0, 0])
    plot_complex_roots(axes[0, 1])
    plot_repeated_root(axes[1, 0])
    plot_pure_imaginary(axes[1, 1])
    fig.suptitle("Solutions for Different Characteristic Root Types", fontsize=13, y=1.02)
    fig.tight_layout()
    fig.savefig(OUT, format="svg", bbox_inches="tight")
    print(f"Saved: {OUT}")


if __name__ == "__main__":
    main()
