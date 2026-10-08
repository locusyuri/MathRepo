"""Splitting of the initial displacement into traveling waves (d'Alembert).

Generates img/wave-dalembert-traveling-waves.svg (two panels):
  (a) the half-amplitude profiles F(x - a t) and G(x + a t) traveling right/left;
  (b) the superposition u = F(x - a t) + G(x + a t) at t = 0, t1, t2.

Data: phi(x) = exp(-x^2 / w), psi = 0.  Run from the repository root:
  uv run "1.Analyse/Équations aux Dérivées Partielles/scripts/wave-dalembert-traveling-waves.py"
"""

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

A = 1.0
W = 0.7
T1, T2 = 0.9, 1.8
BLUE = "#3b6fb6"
RED = "#c74440"
GRAY = "#888888"
OUT = (
    Path(__file__).resolve().parent.parent
    / "img"
    / "wave-dalembert-traveling-waves.svg"
)

phi = lambda x: np.exp(-(x**2) / W)


def main():
    x = np.linspace(-4.2, 4.2, 900)
    fig, axes = plt.subplots(1, 2, figsize=(9.8, 3.3))

    # ------------------------------------------------------------- (a)
    ax = axes[0]
    ax.plot(x, phi(x) / 2, ls="--", color=GRAY, lw=1.2, label=r"$\varphi/2$ at $t=0$")
    ax.plot(x, phi(x - A * T1) / 2, color=BLUE, lw=1.8, label=r"$F(x-at)$ (right)")
    ax.plot(x, phi(x + A * T1) / 2, color=RED, lw=1.8, label=r"$G(x+at)$ (left)")
    ax.annotate("", xy=(2.9, 0.16), xytext=(2.0, 0.16),
                arrowprops=dict(arrowstyle="->", color=BLUE, lw=1.2))
    ax.annotate("", xy=(-2.9, 0.16), xytext=(-2.0, 0.16),
                arrowprops=dict(arrowstyle="->", color=RED, lw=1.2))
    ax.set_title("(a) half-amplitude profiles", fontsize=10.5)
    ax.legend(fontsize=8.5, loc="upper right", frameon=False)

    # ------------------------------------------------------------- (b)
    ax = axes[1]
    ax.plot(x, phi(x), color="black", lw=1.6, label=r"$t=0$")
    ax.plot(x, (phi(x - A * T1) + phi(x + A * T1)) / 2, color=BLUE, lw=1.6,
            label=rf"$t=T_1={T1}$")
    ax.plot(x, (phi(x - A * T2) + phi(x + A * T2)) / 2, color=RED, lw=1.6,
            label=rf"$t=T_2={T2}$")
    ax.set_title(r"(b) superposition $u = F(x-at) + G(x+at)$", fontsize=10.5)
    ax.legend(fontsize=8.5, loc="upper right", frameon=False)

    for ax in axes:
        ax.set_xlim(-4.2, 4.2)
        ax.set_ylim(0, 1.12)
        for side in ("top", "right"):
            ax.spines[side].set_visible(False)
        ax.set_xlabel("$x$", fontsize=10)
    axes[0].set_ylabel("$u$", fontsize=10)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight")
    print(f"saved {OUT}")


if __name__ == "__main__":
    main()
