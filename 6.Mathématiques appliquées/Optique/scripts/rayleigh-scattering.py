"""Rayleigh scattering strength vs wavelength (lambda^-4 law).  Generates img/rayleigh-scattering.svg.  Run from the repository root:  uv run ..."""
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"   # 统一语义色
OUT = Path(__file__).resolve().parent.parent / "img" / "rayleigh-scattering.svg"
OUT_PNG = OUT.with_suffix(".png")


def main():
    fig, ax = plt.subplots(figsize=(8, 5))

    lam0 = 400.0
    lam = np.linspace(400, 700, 400)
    I = (lam0 / lam) ** 4
    ax.plot(lam, I, color=RED, lw=2.4)
    ax.fill_between(lam, 0, I, color=RED, alpha=0.15)

    for lam_mark, col in [(450, BLUE), (700, "#c2410c")]:
        val = (lam0 / lam_mark) ** 4
        ax.plot([lam_mark, lam_mark], [0, val], color=col, lw=1.4, ls="--")
        ax.plot([lam_mark], [val], marker="o", ms=6, color=col)
        ax.text(lam_mark + 8, val + 0.35, rf"{lam_mark:.0f} nm", color=col, fontsize=11)

    ax.set_xlim(400, 700)
    ax.set_ylim(0, 12.5)
    ax.set_xlabel(r"wavelength $\lambda$ (nm)", fontsize=12)
    ax.set_ylabel(r"relative scattering strength $(\lambda_0/\lambda)^4$", fontsize=12)
    ax.grid(alpha=0.25)
    ax.text(660, 9.5, r"$\sigma_R \propto \lambda^{-4}$", fontsize=13)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
