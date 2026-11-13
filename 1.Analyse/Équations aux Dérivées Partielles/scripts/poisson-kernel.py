"""Concentration of the Poisson kernel of the unit disc.

Generates img/poisson-kernel.svg: for the unit disc B = B(0, 1) and x = (r, 0), the
kernel of the boundary point y = (cos theta, sin theta) is

    P(x, y) = (1 - r^2) / (2 pi |x - y|^2)
            = (1 - r^2) / (2 pi (1 - 2 r cos theta + r^2)).

Three positions of x are drawn, r = 0, 0.5, 0.9.  In each case

    integral_{-pi}^{pi} P(x, y(theta)) dtheta = 1

(the disc has omega_2 = 2 pi), while the peak at theta = 0 equals (1 + r)/(2 pi (1 - r)),
namely 1/(2 pi) ~ 0.159, 0.477 and 3.02.  The mass stays equal to 1 and concentrates
near y_0 = (1, 0) as x approaches y_0, which is what recovers the boundary datum.

Run from the repository root:
    uv run "1.Analyse/Équations aux Dérivées Partielles/scripts/poisson-kernel.py"
"""

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

RADII = (0.0, 0.5, 0.9)
COLORS = ("#4fa36a", "#3b6fb6", "#b03a3a")
INK = "#2D2D2D"

OUT = Path(__file__).resolve().parent.parent / "img" / "poisson-kernel.svg"


def kernel(theta, r):
    """Poisson kernel of the unit disc at x = (r, 0)."""
    return (1.0 - r**2) / (2.0 * np.pi * (1.0 - 2.0 * r * np.cos(theta) + r**2))


def main():
    fig, ax = plt.subplots(figsize=(7.4, 4.2))
    theta = np.linspace(-np.pi, np.pi, 1201)

    for r, color in zip(RADII, COLORS):
        y = kernel(theta, r)
        ax.plot(theta, y, color=color, lw=1.9, label=rf"$r = {r:g}$")
        ax.fill_between(theta, 0.0, y, color=color, alpha=0.08, lw=0)

    label_positions = {0.0: (-2.55, 0.44), 0.5: (0.44, 0.600), 0.9: (0.24, 3.110)}
    label_anchors = {0.0: (-2.55, 0.165), 0.5: (0.0, 0.477), 0.9: (0.0, 3.024)}
    for r, color in zip(RADII, COLORS):
        peak = (1.0 + r) / (2.0 * np.pi * (1.0 - r))
        ax.plot([0.0], [peak], "o", color=color, ms=4)
        ax.annotate(rf"${peak:.3f}$", xy=label_anchors[r], xytext=label_positions[r],
                    fontsize=9, color=color,
                    arrowprops=dict(arrowstyle="-", color=color, lw=0.7),
                    bbox=dict(boxstyle="round,pad=0.12", fc="white", ec="none",
                              alpha=0.9))

    ax.axhline(0.0, color=INK, lw=0.8)
    ax.axvline(0.0, color=INK, lw=0.6, ls=(0, (3, 3)))
    ax.set_xlim(-np.pi, np.pi)
    ax.set_ylim(0.0, 3.35)
    ax.set_xticks([-np.pi, -np.pi / 2, 0.0, np.pi / 2, np.pi])
    ax.set_xticklabels([r"$-\pi$", r"$-\pi/2$", r"$0$", r"$\pi/2$", r"$\pi$"])
    ax.set_xlabel(r"$\theta$ with $y = (\cos\theta, \sin\theta)$", fontsize=10)
    ax.set_ylabel(r"$P(x, y)$", fontsize=11)
    for side in ("top", "right"):
        ax.spines[side].set_visible(False)

    ax.annotate(r"$x = (r, 0)$, peak at $y_0 = (1, 0)$" "\n"
                r"area under each curve $= 1$",
                xy=(-3.05, 2.95), fontsize=9.5, color=INK, va="top")
    ax.legend(loc="upper right", frameon=False, fontsize=10)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT.with_suffix(".png"), dpi=150, bbox_inches="tight",
                facecolor="white")
    print(f"saved {OUT}")


if __name__ == "__main__":
    main()
