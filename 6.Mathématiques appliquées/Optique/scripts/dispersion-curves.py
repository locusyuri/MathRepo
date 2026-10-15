"""Lorentz oscillator: real part of the refractive index (normal and anomalous dispersion) and absorption.  Generates img/dispersion-curves.svg.  Run from the repository root:  uv run ..."""
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"   # 统一语义色
GREEN = "#2f9e44"
OUT = Path(__file__).resolve().parent.parent / "img" / "dispersion-curves.svg"
OUT_PNG = OUT.with_suffix(".png")


def main():
    fig, ax = plt.subplots(figsize=(8.5, 5))

    A = 0.5   # coupling strength (N q^2 / (eps0 m)) in units of omega0^2
    g = 0.12  # damping in units of omega0
    u = np.linspace(0.3, 1.9, 1600)
    eps = 1 + A / (1 - u**2 - 1j * g * u)
    n_tilde = np.sqrt(eps)
    n = np.real(n_tilde)
    kappa = np.imag(n_tilde)

    ax.plot(u, n, color=BLUE, lw=2.4, label=r"$n(\omega)$ (real part)")
    ax.plot(u, kappa, color=RED, lw=2.0, ls="--", label=r"$\kappa(\omega)$ (absorption)")
    ax.axvline(1.0, color=GRAY, lw=1.0, ls=":")

    # normal / anomalous labels
    ax.text(0.62, 1.62, "normal\ndispersion", ha="center", fontsize=11, color=GREEN)
    ax.text(1.22, 0.55, "anomalous\n(band)", ha="center", fontsize=11, color=RED)
    ax.text(1.06, 2.0, r"$\omega_0$", fontsize=12)

    ax.set_xlim(0.3, 1.9)
    ax.set_ylim(0, 2.1)
    ax.set_xlabel(r"$\omega / \omega_0$", fontsize=12)
    ax.set_ylabel("refractive index", fontsize=12)
    ax.legend(loc="upper left", fontsize=11, frameon=False)
    ax.grid(alpha=0.25)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
