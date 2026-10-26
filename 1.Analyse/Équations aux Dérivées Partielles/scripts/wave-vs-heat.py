"""Finite versus infinite propagation speed for the same triangular datum.

Generates img/wave-vs-heat.svg (two panels):
  (a) wave equation u_tt = u_xx, speed a = 1, zero initial velocity:
      u(x, t) = 1/2 [g(x - t) + g(x + t)] with g the triangle of height 1 on [-1, 1].
      At time t the support is exactly [-1 - t, -1 + t] U [1 - t, 1 + t];
      outside it the solution vanishes identically.
  (b) heat equation u_t = u_xx, same datum: u(x, t) = E(t, .) * g.
      At every t > 0 the solution is strictly positive on the whole line.

Run from the repository root:
    uv run "1.Analyse/Équations aux Dérivées Partielles/scripts/wave-vs-heat.py"
"""

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

T_WAVE = 1.8
TIMES_HEAT = (0.05, 0.4, 1.5)
COLORS = ("#b03a3a", "#d59a2a", "#3b6fb6")
BLUE = "#3b6fb6"
GREY = "#8a8a8a"
OUT = Path(__file__).resolve().parent.parent / "img" / "wave-vs-heat.svg"


def datum(x):
    """Triangular datum: height 1 at the origin, supported on [-1, 1]."""
    return np.maximum(0.0, 1.0 - np.abs(x))


def kernel(t, x):
    """Heat kernel of the one-dimensional heat equation."""
    return np.exp(-x**2 / (4.0 * t)) / np.sqrt(4.0 * np.pi * t)


def heat_solution(x, t, y, g):
    """u(x, t) = integral E(t, x - y) g(y) dy by the trapezoidal rule."""
    e = np.exp(-((x[:, None] - y[None, :]) ** 2) / (4.0 * t)) / np.sqrt(4.0 * np.pi * t)
    return np.trapezoid(e * g[None, :], y, axis=1)


def main():
    fig, axes = plt.subplots(1, 2, figsize=(10.0, 3.8))

    # ---------------------------------------------------------------- (a) wave
    ax = axes[0]
    x = np.linspace(-4.5, 4.5, 2001)
    ax.plot(x, datum(x), color=GREY, lw=1.2, ls=(0, (4, 3)), label=r"datum $g$")
    u = 0.5 * (datum(x - T_WAVE) + datum(x + T_WAVE))
    ax.plot(x, u, color=BLUE, lw=1.9, label=rf"$u(\cdot, {T_WAVE:g})$")

    for edge in (-1.0 - T_WAVE, -1.0 + T_WAVE, 1.0 - T_WAVE, 1.0 + T_WAVE):
        ax.axvline(edge, color=BLUE, lw=0.8, ls=(0, (2, 2)), alpha=0.8)
    for x0 in (-1.0 - T_WAVE, 1.0 + T_WAVE):
        ax.annotate(rf"${x0:.1f}$", xy=(x0, -0.075), fontsize=9, color=BLUE, ha="center",
                    bbox=dict(boxstyle="round,pad=0.10", fc="white", ec="none", alpha=0.9))

    ax.axhline(0.0, color="black", lw=0.8)
    ax.set_xlim(-4.5, 4.5)
    ax.set_ylim(-0.14, 1.12)
    ax.set_xlabel(r"$x$", fontsize=11)
    ax.set_ylabel(r"$u(x, t)$", fontsize=11)
    ax.set_title(r"(a) wave: $u_{tt} = u_{xx}$", fontsize=11)
    for side in ("top", "right"):
        ax.spines[side].set_visible(False)
    ax.legend(loc="upper right", frameon=False, fontsize=9.5)
    ax.annotate("support exactly $[-1-t,\\,1+t]$\nvanishes identically outside",
                xy=(-4.4, 0.98), fontsize=9, va="top", color="#2D2D2D")

    # ---------------------------------------------------------------- (b) heat
    ax = axes[1]
    y = np.linspace(-1.0, 1.0, 1201)
    g = datum(y)
    for t, color in zip(TIMES_HEAT, COLORS):
        ax.plot(x, heat_solution(x, t, y, g), color=color, lw=1.8, label=rf"$t = {t:g}$")

    ax.plot(x, datum(x), color=GREY, lw=1.2, ls=(0, (4, 3)), label=r"datum $g$")
    ax.axhline(0.0, color="black", lw=0.8)
    ax.set_xlim(-4.5, 4.5)
    ax.set_ylim(-0.14, 1.12)
    ax.set_xlabel(r"$x$", fontsize=11)
    ax.set_ylabel(r"$u(x, t)$", fontsize=11)
    ax.set_title(r"(b) heat: $u_t = u_{xx}$", fontsize=11)
    for side in ("top", "right"):
        ax.spines[side].set_visible(False)
    ax.legend(loc="upper right", frameon=False, fontsize=9.5)
    ax.annotate("positive on the whole line\nfor every $t > 0$",
                xy=(-4.4, 0.34), fontsize=9, va="top", color="#2D2D2D")
    ax.annotate("Gaussian tail:\n$u (x, t) > 0$ for every $x$",
                xy=(3.05, 0.010), xytext=(1.45, 0.46), fontsize=8.5, color="#2D2D2D",
                arrowprops=dict(arrowstyle="-", color="#2D2D2D", lw=0.7))

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT.with_suffix(".png"), dpi=150, bbox_inches="tight", facecolor="white")
    print(f"saved {OUT}")


if __name__ == "__main__":
    main()
