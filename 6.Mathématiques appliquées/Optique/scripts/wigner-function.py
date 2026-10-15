"""Wigner functions: coherent state (Gaussian) vs single-photon Fock state (negative dip).  Generates img/wigner-function.svg (two panels).  Run from the repository root:  uv run ..."""
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np

OUT = Path(__file__).resolve().parent.parent / "img" / "wigner-function.svg"
OUT_PNG = OUT.with_suffix(".png")


def wigner_coherent(x, p, x0):
    """W of |alpha>, alpha = x0 (real), in units where W_0 = (1/pi) exp(-2H)."""
    return (1 / np.pi) * np.exp(-2 * ((x - x0) ** 2 + p**2))


def wigner_fock1(x, p):
    """W of |1>: (1/pi) (2(x^2+p^2) - 1) exp(-(x^2+p^2))."""
    H = x**2 + p**2
    return (1 / np.pi) * (2 * H - 1) * np.exp(-H)


def main():
    x = np.linspace(-3, 3, 300)
    p = np.linspace(-3, 3, 300)
    X, P = np.meshgrid(x, p)

    fig, axes = plt.subplots(1, 2, figsize=(11, 4.6), constrained_layout=True)

    # (a) coherent state |alpha=1.5>
    ax = axes[0]
    W = wigner_coherent(X, P, 1.5)
    im = ax.pcolormesh(X, P, W, cmap="RdBu_r", vmin=-0.35, vmax=0.35, shading="auto")
    ax.contour(X, P, W, levels=[0.05, 0.15, 0.25, 0.3], colors="#333", linewidths=0.8)
    ax.set_title(r"Coherent state $|\alpha\rangle$ (Gaussian)", fontsize=12)
    ax.set_xlabel(r"$x$ (quadrature)", fontsize=11)
    ax.set_ylabel(r"$p$ (quadrature)", fontsize=11)
    ax.set_aspect("equal")

    # (b) single-photon Fock state |1> with negative dip
    ax = axes[1]
    W = wigner_fock1(X, P)
    im = ax.pcolormesh(X, P, W, cmap="RdBu_r", vmin=-0.35, vmax=0.35, shading="auto")
    ax.contour(X, P, W, levels=[-0.1, -0.05, 0.05, 0.1, 0.2], colors="#333", linewidths=0.8)
    ax.set_title(r"Single-photon state $|1\rangle$ (negative dip)", fontsize=12)
    ax.set_xlabel(r"$x$ (quadrature)", fontsize=11)
    ax.set_ylabel(r"$p$ (quadrature)", fontsize=11)
    ax.set_aspect("equal")

    cbar = fig.colorbar(im, ax=axes, orientation="vertical", fraction=0.03, pad=0.02)
    cbar.set_label(r"$W(x,p)$", fontsize=11)

    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
