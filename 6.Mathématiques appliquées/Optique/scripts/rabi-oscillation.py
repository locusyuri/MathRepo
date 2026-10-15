"""Rabi oscillations: excitation probability vs time, resonant and detuned.  Generates img/rabi-oscillation.svg.  Run from the repository root:  uv run ..."""
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"   # 统一语义色
OUT = Path(__file__).resolve().parent.parent / "img" / "rabi-oscillation.svg"
OUT_PNG = OUT.with_suffix(".png")


def main():
    fig, ax = plt.subplots(figsize=(8.5, 5))

    t = np.linspace(0, 3, 900)  # in units of 2 pi / Omega0
    u = 2 * np.pi * t
    # resonant: P = sin^2(u/2)
    P_res = np.sin(u / 2) ** 2
    # detuned Delta = 2 Omega0: P = (Omega0/Omega)^2 sin^2(Omega t/2), Omega = sqrt(5) Omega0
    Omega_ratio = np.sqrt(5)
    P_det = (1 / Omega_ratio) ** 2 * np.sin(Omega_ratio * u / 2) ** 2

    ax.plot(t, P_res, color=RED, lw=2.2, label=r"resonant: $\Delta = 0$")
    ax.plot(t, P_det, color=BLUE, lw=2.0, ls="--", label=r"detuned: $\Delta = 2\Omega_0$")
    ax.axhline(1, color=GRAY, lw=0.8, ls=":")
    ax.plot([0.5], [1], marker="o", ms=5, color=RED)
    ax.text(0.52, 1.03, r"$\pi$-pulse", fontsize=11, color=RED)

    ax.set_xlim(0, 3)
    ax.set_ylim(0, 1.15)
    ax.set_xlabel(r"time $t$ (units of $2\pi/\Omega_0$)", fontsize=12)
    ax.set_ylabel(r"excitation probability $P_e(t)$", fontsize=12)
    ax.legend(loc="upper right", fontsize=11, frameon=False)
    ax.grid(alpha=0.25)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
