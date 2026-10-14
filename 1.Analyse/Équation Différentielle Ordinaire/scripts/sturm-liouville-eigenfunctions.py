"""First three eigenfunctions of the Sturm-Liouville problem y'' + lambda y = 0, y(0)=y(pi)=0.
Generates img/sturm-liouville-eigenfunctions.svg.
Run from repository root: uv run "1.Analyse/Équation Différentielle Ordinaire/scripts/sturm-liouville-eigenfunctions.py"
"""
from pathlib import Path
import numpy as np
import matplotlib.pyplot as plt

BLUE, RED, GREEN = "#3b6fb6", "#c74440", "#2e8b57"
OUT = Path(__file__).resolve().parent.parent / "img" / "sturm-liouville-eigenfunctions.svg"


def main():
    fig, ax = plt.subplots(figsize=(7, 4))

    x = np.linspace(0, np.pi, 200)

    # First eigenfunction: sin(x), lambda = 1
    ax.plot(x, np.sin(x), color=BLUE, linewidth=1.8,
            label="$\\phi_1(x) = \\sin x, \\; \\lambda_1 = 1$")

    # Second eigenfunction: sin(2x), lambda = 4
    ax.plot(x, np.sin(2 * x), color=RED, linewidth=1.8,
            label="$\\phi_2(x) = \\sin 2x, \\; \\lambda_2 = 4$")

    # Third eigenfunction: sin(3x), lambda = 9
    ax.plot(x, np.sin(3 * x), color=GREEN, linewidth=1.8,
            label="$\\phi_3(x) = \\sin 3x, \\; \\lambda_3 = 9$")

    # Zero line
    ax.axhline(y=0, color="k", linewidth=0.5)

    ax.set_xlabel("$x$", fontsize=12)
    ax.set_ylabel("$\\phi_n(x)$", fontsize=12)
    ax.set_title("First Three Eigenfunctions of the Sturm-Liouville Problem", fontsize=11)
    ax.set_xlim(0, np.pi)
    ax.set_xticks([0, np.pi/2, np.pi])
    ax.set_xticklabels(["$0$", "$\\pi/2$", "$\\pi$"])
    ax.legend(fontsize=10, loc="upper right")
    ax.grid(alpha=0.3)

    fig.tight_layout()
    fig.savefig(OUT, format="svg")
    print(f"Saved: {OUT}")


if __name__ == "__main__":
    main()
