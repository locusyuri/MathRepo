"""Rayleigh criterion: two Airy patterns at 0.5, 1.0 and 1.5 times the Rayleigh separation.  Generates img/resolution-criterion.svg (three panels).  Run from the repository root:  uv run ..."""
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"   # 统一语义色
OUT = Path(__file__).resolve().parent.parent / "img" / "resolution-criterion.svg"
OUT_PNG = OUT.with_suffix(".png")


def j1(x):
    x = np.asarray(x, dtype=float)
    s = np.zeros_like(x)
    term = x / 2.0
    for k in range(60):
        s = s + term
        term = -term * (x * x) / (4.0 * (k + 1) * (k + 2))
        if np.max(np.abs(term)) < 1e-14:
            break
    return s


def airy(x):
    x = np.asarray(x, dtype=float)
    out = np.empty_like(x)
    nz = np.abs(x) > 1e-9
    out[nz] = (2 * j1(x[nz]) / x[nz]) ** 2
    out[~nz] = 1.0
    return out


def main():
    x1 = 3.8317  # first zero of J1; Rayleigh separation in x-units
    fig, axes = plt.subplots(1, 3, figsize=(13, 3.9), sharey=True)

    for ax, (frac, title) in zip(
        axes,
        [(0.5, "Unresolved"), (1.0, "Just resolved (Rayleigh)"), (1.5, "Resolved")],
    ):
        s = frac * x1
        x = np.linspace(-2.4 * x1, 2.4 * x1, 900)
        I1 = airy(x - s)
        I2 = airy(x + s)
        Itot = I1 + I2
        ax.plot(x / x1, I1, color=GRAY, lw=1.4, ls="--")
        ax.plot(x / x1, I2, color=GRAY, lw=1.4, ls="--")
        ax.plot(x / x1, Itot, color=RED, lw=2.0)
        ax.set_xlim(-2.4, 2.4)
        ax.set_ylim(0, 1.25)
        ax.set_title(title, fontsize=12)
        ax.set_xlabel(r"$x / \theta_{\min}$", fontsize=11)
        ax.grid(alpha=0.25)

    axes[0].set_ylabel(r"$I$", fontsize=12)
    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
