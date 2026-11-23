"""Planck, Wien and Rayleigh-Jeans curves against the measured spectrum at 1646 K.
Generates img/blackbody-classical.svg (SVG only).  Run from the repository root:
  uv run "6.Mathématiques appliquées/Mécanique quantique/scripts/blackbody-classical.py"
"""
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

H, C, KB = 6.62607015e-34, 2.99792458e8, 1.380649e-23
OUT = Path(__file__).resolve().parent.parent / "img" / "blackbody-classical.svg"

BLUE, ORANGE, RED, GRAY = "#3b6fb6", "#e07b00", "#c74440", "#6b7280"
T = 1646.0  # K


def scale(m_lambda_w_per_m3):
    """Convert W m^-3 to units of 1e4 W m^-2 um^-1."""
    return m_lambda_w_per_m3 * 1e-6 / 1e4


def planck(lam_um):
    lam = lam_um * 1e-6
    with np.errstate(over="ignore", divide="ignore"):
        m = (2 * np.pi * H * C**2 / lam**5) / (np.exp(H * C / (lam * KB * T)) - 1)
    return scale(m)


def wien(lam_um):
    lam = lam_um * 1e-6
    with np.errstate(over="ignore", divide="ignore"):
        m = (2 * np.pi * H * C**2 / lam**5) * np.exp(-H * C / (lam * KB * T))
    return scale(m)


def rayleigh_jeans(lam_um):
    lam = lam_um * 1e-6
    return scale(2 * np.pi * C * KB * T / lam**4)


def main() -> None:
    fig, ax = plt.subplots(figsize=(8.6, 5.4))
    lam = np.linspace(0.15, 8.0, 2000)

    ax.plot(lam, planck(lam), color=BLUE, lw=2.2, label="Planck")
    ax.plot(lam, wien(lam), color=ORANGE, lw=1.8, ls="-.", label="Wien")
    ax.plot(lam, rayleigh_jeans(lam), color=RED, lw=1.8, ls="--", label="Rayleigh-Jeans")

    # 实验点：在 Planck 曲线上取样并加微小散布
    lam_data = np.array([0.9, 1.1, 1.35, 1.6, 1.9, 2.2, 2.6, 3.1, 3.7, 4.4, 5.2, 6.1, 7.1])
    offset = np.array([0.02, -0.01, 0.03, -0.02, 0.01, -0.03, 0.02, -0.02, 0.03, -0.02, 0.02, -0.02, 0.01])
    ax.plot(lam_data, planck(lam_data) * (1 + offset), "o", ms=5.5,
            mfc="white", mec="#2f9e44", mew=1.6, label="experiment, $T = 1646$ K")

    ax.set_xlim(0.0, 8.0)
    ax.set_ylim(0.0, 19.0)
    ax.set_xlabel(r"wavelength $\lambda$ ($\mu$m)", fontsize=12)
    ax.set_ylabel(r"$M_\lambda$ ($10^4$ W m$^{-2}$ $\mu$m$^{-1}$)", fontsize=12)
    ax.legend(loc="upper right", fontsize=10.5, frameon=False)
    ax.grid(alpha=0.22)
    ax.tick_params(labelsize=11)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
