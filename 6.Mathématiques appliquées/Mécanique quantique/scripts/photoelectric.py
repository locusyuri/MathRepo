"""Photoelectric effect: (a) photocurrent against retarding voltage, (b) stopping voltage against frequency.
Generates img/photoelectric.svg (SVG only).  Run from the repository root:
  uv run "6.Mathématiques appliquées/Mécanique quantique/scripts/photoelectric.py"
"""
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

BLUE, LIGHTBLUE, RED, GREEN, GRAY = "#3b6fb6", "#7ea6d9", "#c74440", "#2f9e44", "#6b7280"
OUT = Path(__file__).resolve().parent.parent / "img" / "photoelectric.svg"

H_OVER_E = 4.135667696e-15  # V s
NU = np.linspace(3.5e14, 1.3e15, 500)

# (金属, 逸出功 eV, 颜色)
METALS = [("Cs", 1.9, BLUE), ("Na", 2.3, GREEN), ("Ca", 2.9, RED)]


def photocurrent(voltage, u0, i_sat, width=0.11):
    """Rising branch above the stopping voltage, saturating for accelerating voltages."""
    curve = i_sat * (1.0 - np.exp(-(voltage + u0) / width))
    return np.where(voltage < -u0, 0.0, curve)


def main() -> None:
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(11.2, 4.6))

    # ---- (a) 伏安特性 ----
    u = np.linspace(-2.2, 1.0, 900)
    ax1.plot(u, photocurrent(u, 0.90, 1.00), color=BLUE, lw=2.0,
             label=r"$\nu$ fixed, high intensity")
    ax1.plot(u, photocurrent(u, 0.90, 0.52), color=LIGHTBLUE, lw=2.0, ls="--",
             label=r"$\nu$ fixed, low intensity")
    ax1.plot(u, photocurrent(u, 1.60, 0.80), color=RED, lw=2.0,
             label=r"higher $\nu$")

    for u0, color in ((0.90, BLUE), (1.60, RED)):
        ax1.axvline(-u0, color=color, lw=1.0, ls=":")
        ax1.plot([-u0], [0.0], marker="o", color=color, ms=5)
        ax1.annotate(rf"$-U_0 = -{u0:.1f}$ V", xy=(-u0, 0.0),
                     xytext=(-u0 - 0.06, 0.17), ha="right", fontsize=9.5, color=color)

    ax1.set_xlim(-2.2, 1.0)
    ax1.set_ylim(0.0, 1.15)
    ax1.set_xlabel(r"retarding voltage $U$ (V)", fontsize=11.5)
    ax1.set_ylabel("photocurrent (arb. units)", fontsize=11.5)
    ax1.legend(loc="upper left", fontsize=9.5, frameon=False)
    ax1.grid(alpha=0.22)
    ax1.tick_params(labelsize=10)
    ax1.set_title("(a) current against voltage", fontsize=12)
    ax1.text(0.02, 0.93, "", transform=ax1.transAxes)

    # ---- (b) 截止电压与频率 ----
    for name, work, color in METALS:
        u0 = H_OVER_E * NU - work
        mask = u0 >= 0.0
        ax2.plot(NU[mask] / 1e14, u0[mask], color=color, lw=2.0, label=name)
        ax2.plot([work / H_OVER_E / 1e14], [0.0], marker="o", ms=5, color=color)

    ax2.set_xlim(3.5, 13.0)
    ax2.set_ylim(0.0, 3.4)
    ax2.set_xlabel(r"frequency $\nu$ ($10^{14}$ Hz)", fontsize=11.5)
    ax2.set_ylabel(r"stopping voltage $U_0$ (V)", fontsize=11.5)
    ax2.legend(title="metal", loc="upper left", fontsize=9.5, frameon=False)
    ax2.grid(alpha=0.22)
    ax2.tick_params(labelsize=10)
    ax2.set_title(r"(b) stopping voltage against frequency", fontsize=12)
    ax2.annotate(r"slope $= h/e$", xy=(10.6, H_OVER_E * 10.6e14 - 2.3),
                 xytext=(8.4, 2.55), fontsize=10, color="#4b5563",
                 arrowprops=dict(arrowstyle="-", color="#9ca3af", lw=1.0))
    ax2.text(3.7, 0.08, r"thresholds $\nu_0 = W/h$", fontsize=9.5, color=GRAY)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
