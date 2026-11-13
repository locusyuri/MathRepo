"""Schwarz lemma — |f(z)| ≤ |z| for f: D → D with f(0) = 0.

Unit disk with dashed concentric reference circles; sample points z_k
(hollow) with arrows pointing inward to their images f(z_k) (filled),
each image on the same ray but closer to the origin.

Run with: uv run python src/math_paper/schwarz_lemma.py
"""

from __future__ import annotations

from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = Presets.SVG_MATH
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

GRY = "#888888"
DARK = "#333333"

# Sample points: z_k with shrinking factors λ_k (image = λ_k · z_k, same ray)
SAMPLES = [
    (0.42, 1.05, 0.55, "#1f4e9b"),   # (|z|, arg, λ, color)
    (0.75, 2.30, 0.55, "#2e8b57"),
    (0.92, 0.35, 0.70, "#c0392b"),
    (0.60, -1.20, 0.60, "#8e44ad"),
    (0.85, -2.40, 0.50, "#d35400"),
]


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)
    ax.set_aspect("equal")

    # ---- dashed concentric reference circles ---- #
    for r_ref in (0.3, 0.6):
        th = np.linspace(0, 2 * np.pi, 200)
        ax.plot(r_ref * np.cos(th), r_ref * np.sin(th),
                color=GRY, lw=0.9, ls="--", alpha=0.5)
        ax.text(r_ref * 0.72, 0.06, f"$|z| = {r_ref:g}$",
                fontsize=7.5, color=GRY, style="italic")

    # ---- unit circle boundary ---- #
    th = np.linspace(0, 2 * np.pi, 400)
    ax.plot(np.cos(th), np.sin(th), color=DARK, lw=2.2)
    ax.text(1.0 * 0.72, 1.0 * 0.72 + 0.10, r"$\partial D$",
            fontsize=9, color=DARK)

    # ---- axes ---- #
    ax.axhline(0, color=GRY, lw=0.5, alpha=0.6)
    ax.axvline(0, color=GRY, lw=0.5, alpha=0.6)
    ax.set_xlim(-1.45, 1.45)
    ax.set_ylim(-1.45, 1.45)
    ax.set_xlabel("Re z", fontsize=10, color=GRY)
    ax.set_ylabel("Im z", fontsize=10, color=GRY)

    # ---- sample points and inward arrows ---- #
    for rad, ang, lam, col in SAMPLES:
        z = rad * np.exp(1j * ang)
        fz = lam * z
        # arrow from z toward f(z) (image closer to O on the same ray)
        ax.annotate("", xy=(fz.real, fz.imag), xytext=(z.real, z.imag),
                    xycoords="data", textcoords="data",
                    arrowprops=dict(arrowstyle="-|>", color=col, lw=1.6,
                                    mutation_scale=14,
                                    shrinkA=5, shrinkB=4))
        ax.plot(z.real, z.imag, "o", mfc="white", mec=col, ms=9,
                mew=1.8, zorder=6)
        ax.plot(fz.real, fz.imag, "o", color=col, ms=7, zorder=6)
        ax.annotate("$z_k$", xy=(z.real, z.imag),
                    xytext=(7, 7), textcoords="offset points",
                    fontsize=10, color=col)
        ax.annotate("$f(z_k)$", xy=(fz.real, fz.imag),
                    xytext=(-8, -14), textcoords="offset points",
                    fontsize=9, color=col, ha="right")

    # ---- origin ---- #
    ax.plot(0, 0, "o", color=DARK, ms=5, zorder=7)
    ax.text(-0.06, -0.11, "$O$", fontsize=11, color=DARK,
            fontweight="bold")

    # ---- lemma labels ---- #
    ax.text(0, 1.32, r"$f : D \to D,\quad f(0) = 0$",
            fontsize=13, ha="center", fontweight="bold", color=DARK)
    ax.text(0, -1.38, r"$|f(z)| \leq |z|$",
            fontsize=14, ha="center", fontweight="bold", color="#1f4e9b")

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "schwarz-lemma")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
