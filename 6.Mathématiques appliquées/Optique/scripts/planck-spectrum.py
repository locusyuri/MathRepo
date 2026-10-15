"""Blackbody spectral energy density at several temperatures, with the classical Rayleigh-Jeans curve.  Generates img/planck-spectrum.svg.  Run from the repository root:  uv run ..."""
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"   # 统一语义色
GREEN, ORANGE = "#2f9e44", "#e07b00"
OUT = Path(__file__).resolve().parent.parent / "img" / "planck-spectrum.svg"
OUT_PNG = OUT.with_suffix(".png")


def planck(lam_um, T):
    """Spectral energy density u_lambda in arbitrary units; lam in microns."""
    lam = lam_um * 1e-6
    kT = 1.380649e-23 * T
    hc = 6.62607015e-34 * 2.99792458e8
    with np.errstate(over="ignore", divide="ignore"):
        u = (8 * np.pi * hc / lam**5) / (np.exp(hc / (lam * kT)) - 1)
    return u / np.max(u)


def rayleigh_jeans(lam_um):
    """Classical RJ curve (u ~ 1/lam^4) normalized to the 5000 K Planck peak."""
    lam = lam_um * 1e-6
    return (1.0 / lam**4) * 1e-30


def main():
    fig, ax = plt.subplots(figsize=(8.5, 5.2))

    lam = np.linspace(0.15, 3.0, 1200)
    colors = [GREEN, ORANGE, RED]
    for T, col in zip([3000, 4000, 5000], colors):
        ax.plot(lam, planck(lam, T), color=col, lw=2.0, label=rf"$T = {T}$ K")
    rj = rayleigh_jeans(lam)
    ax.plot(lam, rj / np.max(rj[:600]), color=GRAY, lw=1.6, ls="--",
            label="Rayleigh-Jeans (classical)")

    ax.set_xlim(0.15, 3.0)
    ax.set_ylim(0, 1.15)
    ax.set_xlabel(r"wavelength $\lambda$ ($\mu$m)", fontsize=12)
    ax.set_ylabel(r"spectral energy density (normalized)", fontsize=12)
    ax.legend(loc="upper right", fontsize=11, frameon=False)
    ax.grid(alpha=0.25)
    ax.text(0.22, 1.0, "ultraviolet catastrophe", fontsize=11, color="#6b7280", rotation=0)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
