"""Perpendicular superposition of two SHMs: equal-frequency ellipses (left) and Lissajous figures (right).  Generates img/lissajous.svg.  Run from the repository root:  uv run "6.Mathématiques appliquées/Optique/scripts/lissajous.py"  Math check: for x = cos(p t), y = cos(q t) the curve closes after t = 2*pi because both coordinates return to their initial values; for equal frequencies the ellipse is the conic A y^2 + B xy + C x^2 = sin^2(dphi). """
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GREEN, ORANGE = "#3b6fb6", "#c74440", "#2f9e44", "#e08214"
OUT = Path(__file__).resolve().parent.parent / "img" / "lissajous.svg"
OUT_PNG = OUT.with_suffix(".png")


def main():
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(9.5, 4.6))

    t = np.linspace(0.0, 2.0 * np.pi, 1200)

    # ---- left: equal frequency, three phase differences ----
    for dphi, color, label in [
        (0.0, BLUE, r"$\Delta\varphi = 0$"),
        (np.pi / 4.0, GREEN, r"$\Delta\varphi = \pi/4$"),
        (np.pi / 2.0, RED, r"$\Delta\varphi = \pi/2$"),
    ]:
        x, y = np.cos(t), np.cos(t + dphi)
        ax1.plot(x, y, color=color, lw=2.2, label=label)

    ax1.axhline(0.0, color="#cccccc", lw=0.8)
    ax1.axvline(0.0, color="#cccccc", lw=0.8)
    ax1.set_aspect("equal")
    ax1.set_xlim(-1.15, 1.15)
    ax1.set_ylim(-1.15, 1.15)
    ax1.set_xlabel(r"$x / A_1$", fontsize=12)
    ax1.set_ylabel(r"$y / A_2$", fontsize=12)
    ax1.set_title("equal frequency", fontsize=12)
    ax1.legend(loc="upper right", fontsize=10, frameon=False)
    ax1.grid(alpha=0.2)

    # ---- right: commensurable frequency ratios ----
    t2 = np.linspace(0.0, 2.0 * np.pi, 4000)
    for (p, q), color, label in [
        ((1, 2), ORANGE, r"$\omega_x : \omega_y = 1 : 2$"),
        ((2, 3), BLUE, r"$\omega_x : \omega_y = 2 : 3$"),
    ]:
        ax2.plot(np.cos(q * t2), np.cos(p * t2), color=color, lw=2.0, label=label)

    ax2.axhline(0.0, color="#cccccc", lw=0.8)
    ax2.axvline(0.0, color="#cccccc", lw=0.8)
    ax2.set_aspect("equal")
    ax2.set_xlim(-1.15, 1.15)
    ax2.set_ylim(-1.15, 1.15)
    ax2.set_xlabel(r"$x / A_1$", fontsize=12)
    ax2.set_ylabel(r"$y / A_2$", fontsize=12)
    ax2.set_title("commensurable frequencies", fontsize=12)
    ax2.legend(loc="upper right", fontsize=10, frameon=False)
    ax2.grid(alpha=0.2)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
