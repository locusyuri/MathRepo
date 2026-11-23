"""Blackbody spectral exitance at four temperatures: peak shift and T^4 growth.
Generates img/blackbody-spectrum.svg (SVG only).  Run from the repository root:
  uv run "6.Mathématiques appliquées/Mécanique quantique/scripts/blackbody-spectrum.py"
"""
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

H, C, KB = 6.62607015e-34, 2.99792458e8, 1.380649e-23
OUT = Path(__file__).resolve().parent.parent / "img" / "blackbody-spectrum.svg"

COLORS = ["#4c72b0", "#2f9e44", "#e07b00", "#c74440"]
TEMPERATURES = [1100, 1300, 1500, 1700]
WIEN_B = 2.898e-3  # m K


def planck(lam_um, temperature):
    """Spectral exitance in units of 1e4 W m^-2 um^-1; wavelength in microns."""
    lam = lam_um * 1e-6
    with np.errstate(over="ignore", divide="ignore"):
        m_lambda = (2 * np.pi * H * C**2 / lam**5) / (np.exp(H * C / (lam * KB * temperature)) - 1)
    return m_lambda * 1e-6 / 1e4


def main() -> None:
    fig, ax = plt.subplots(figsize=(8.6, 5.4))
    lam = np.linspace(0.05, 8.0, 2000)

    for temperature, color in zip(TEMPERATURES, COLORS):
        ax.plot(lam, planck(lam, temperature), color=color, lw=2.0,
                label=rf"$T = {temperature}$ K")

    lam_max = WIEN_B / TEMPERATURES[-1] * 1e6
    ax.axvline(lam_max, color="#6b7280", lw=1.0, ls="--")
    ax.annotate(r"$\lambda_m$", xy=(lam_max, planck(lam_max, TEMPERATURES[-1])),
                xytext=(lam_max + 0.25, planck(lam_max, TEMPERATURES[-1])),
                fontsize=12, color="#4b5563")

    ax.set_xlim(0.0, 8.0)
    ax.set_ylim(0.0, 19.0)
    ax.set_xlabel(r"wavelength $\lambda$ ($\mu$m)", fontsize=12)
    ax.set_ylabel(r"$M_\lambda$ ($10^4$ W m$^{-2}$ $\mu$m$^{-1}$)", fontsize=12)
    ax.legend(loc="upper right", fontsize=11, frameon=False)
    ax.grid(alpha=0.22)
    ax.tick_params(labelsize=11)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
