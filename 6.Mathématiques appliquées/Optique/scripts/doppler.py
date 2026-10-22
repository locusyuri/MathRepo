"""Doppler effect: wavefronts of a moving source (left) and the Mach cone of a supersonic source (right).  Generates img/doppler.svg.  Run from the repository root:  uv run "6.Mathématiques appliquées/Optique/scripts/doppler.py"  Math check: each circle has centre at the emission point x_k = -v_s * tau_k and radius u * tau_k with u = 1. Left: v_s = 0.6 < u, so the spacing ahead is (u - v_s) * period and behind is (u + v_s) * period. Right: v_s = 1.8 > u, the envelope satisfies sin(theta) = u / v_s = 0.5556, theta = 33.75 deg, and the tangency is verified by distance(centre, line) = |m x_k| / sqrt(1 + m^2) = u * tau_k with m = tan(theta). """
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import Circle

BLUE, RED, GREEN, ORANGE, GRAY = "#3b6fb6", "#c74440", "#2f9e44", "#e08214", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "doppler.svg"
OUT_PNG = OUT.with_suffix(".png")

U = 1.0  # wave speed


def ring(ax, x0, r, color=BLUE):
    ax.add_patch(Circle((x0, 0.0), r, fill=False, color=color, lw=1.2, alpha=0.85))


def main():
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(10.2, 4.9))

    taus = np.linspace(0.2, 1.0, 5)

    # ---- left: subsonic source ----
    vs = 0.6
    for tau in taus:
        ring(ax1, -vs * tau, U * tau)
    ax1.plot([-vs * 1.0, 0.0], [0.0, 0.0], color=GRAY, lw=1.0, ls=":")
    ax1.plot([0.0], [0.0], "o", color=RED, ms=8)
    ax1.annotate("", xy=(0.42, 0.0), xytext=(0.0, 0.0),
                 arrowprops=dict(arrowstyle="-|>", color=RED, lw=1.8))
    ax1.text(0.44, 0.10, r"$v_s$", color=RED, fontsize=12)
    ax1.annotate("compressed\nahead", xy=(0.13, 0.16), xytext=(0.85, 1.05),
                 color=GREEN, fontsize=11, ha="center",
                 arrowprops=dict(arrowstyle="->", color=GREEN, lw=1.2))
    ax1.annotate("stretched\nbehind", xy=(-0.85, 0.55), xytext=(-1.75, 1.05),
                 color=ORANGE, fontsize=11, ha="center",
                 arrowprops=dict(arrowstyle="->", color=ORANGE, lw=1.2))
    ax1.set_xlim(-2.2, 2.2)
    ax1.set_ylim(-1.7, 1.7)
    ax1.set_aspect("equal")
    ax1.set_xlabel(r"$x$", fontsize=11)
    ax1.set_title(r"subsonic source: $v_s = 0.6\,u$", fontsize=12)
    ax1.set_yticks([])

    # ---- right: supersonic source, Mach cone ----
    vs2 = 1.8
    for tau in taus:
        ring(ax2, -vs2 * tau, U * tau, color=ORANGE)
    theta = np.arcsin(U / vs2)
    m = np.tan(theta)
    xs = -vs2 * 1.0
    ax2.plot([xs, 0.0], [m * xs, 0.0], color=BLUE, lw=2.0)
    ax2.plot([xs, 0.0], [-m * xs, 0.0], color=BLUE, lw=2.0)
    ax2.plot([0.0], [0.0], "o", color=RED, ms=8)
    ax2.annotate("", xy=(0.42, 0.0), xytext=(0.0, 0.0),
                 arrowprops=dict(arrowstyle="-|>", color=RED, lw=1.8))
    ax2.text(0.44, 0.10, r"$v_s > u$", color=RED, fontsize=11)
    ax2.annotate(r"$\theta$", xy=(-0.62, 0.0), fontsize=13, color=BLUE)
    ax2.text(-1.55, 0.62, "Mach cone", color=BLUE, fontsize=11, rotation=0)
    ax2.set_xlim(-2.2, 1.2)
    ax2.set_ylim(-1.7, 1.7)
    ax2.set_aspect("equal")
    ax2.set_xlabel(r"$x$", fontsize=11)
    ax2.set_title(r"supersonic source: $\sin\theta = u / v_s$", fontsize=12)
    ax2.set_yticks([])

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
