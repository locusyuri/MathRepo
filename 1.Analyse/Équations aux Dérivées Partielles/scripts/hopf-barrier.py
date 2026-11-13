"""The barrier used in the proof of Hopf's lemma.

Generates img/hopf-barrier.svg with two panels.

(a) Geometry.  The boundary is the parabola y = x^2/2 and Omega is the region above
    it.  At x0 = (0, 0) the outward normal is nu = (0, -1) and the internally tangent
    ball is B(x_c, delta) with x_c = (0, 1) and delta = 1; the circle of radius
    rho = 0.4 about x0 cuts out the comparison region Omega ∩ B(x0, rho).

(b) Barrier.  Along the inward normal x = x0 - t*nu = (0, t), the barrier is
        w(t) = exp(-lambda (delta - t)^2) - exp(-lambda delta^2),
    with the choices of the lemma: delta = 1, n = 2, lambda = 2n/delta^2 = 4.
    Then w(0) = 0, w(t) > 0 for t > 0, and w'(0) = 2 lambda delta exp(-lambda delta^2)
    = 8 exp(-4) ~ 0.1465, so u_nu(x0) >= epsilon w'(0) > 0.

Run from the repository root:
    uv run "1.Analyse/Équations aux Dérivées Partielles/scripts/hopf-barrier.py"
"""

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

DELTA = 1.0
RHO = 0.4
LAMBDA = 4.0

INK = "#2D2D2D"
BLUE = "#3b6fb6"
RED = "#b03a3a"
GREEN = "#4fa36a"
FILL = "#dce8f5"

OUT = Path(__file__).resolve().parent.parent / "img" / "hopf-barrier.svg"

TOP = 2.15


def barrier(t):
    """Barrier w(t) along the inward normal."""
    return np.exp(-LAMBDA * (DELTA - t) ** 2) - np.exp(-LAMBDA * DELTA**2)


def panel_geometry(ax):
    """Tangent ball, comparison region and normal at the boundary point."""
    xs = np.linspace(-1.45, 1.45, 801)
    ax.fill_between(xs, 0.5 * xs**2, TOP, color=FILL, lw=0)
    ax.plot(xs, 0.5 * xs**2, color=INK, lw=2.0)

    ax.add_patch(plt.Circle((0.0, 1.0), DELTA, fill=False, color=BLUE,
                            lw=1.4, ls=(0, (5, 3))))
    ax.plot([0.0], [1.0], "o", color=BLUE, ms=4)
    ax.annotate(r"$x_c$", xy=(0.0, 1.0), xytext=(0.10, 1.02),
                fontsize=11, color=BLUE)

    ax.add_patch(plt.Circle((0.0, 0.0), RHO, fill=False, color=RED,
                            lw=1.2, ls=(0, (2, 2))))

    ax.plot([0.0], [0.0], "o", color=INK, ms=5)
    ax.annotate(r"$x_0$", xy=(0.0, 0.0), xytext=(-0.34, -0.22),
                fontsize=11, color=INK)

    ax.annotate("", xy=(0.0, -0.66), xytext=(0.0, 0.0),
                arrowprops=dict(arrowstyle="->", color=RED, lw=1.4))
    ax.annotate(r"$\nu$", xy=(0.0, -0.66), xytext=(0.09, -0.74),
                fontsize=12, color=RED)

    ax.annotate("", xy=(0.0, 0.82), xytext=(0.0, 0.0),
                arrowprops=dict(arrowstyle="->", color=GREEN, lw=1.4))
    ax.annotate(r"$-\nu$", xy=(0.0, 0.82), xytext=(0.08, 0.76),
                fontsize=11, color=GREEN)

    ax.annotate(r"$B(x_0,\rho)$", xy=(-0.28, 0.27), xytext=(-1.40, 0.10),
                fontsize=10, color=RED,
                arrowprops=dict(arrowstyle="-", color=RED, lw=0.8))

    ax.text(-1.40, 2.02, r"$\Omega$", fontsize=15, color=INK)
    ax.text(1.14, 0.82, r"$\partial\Omega$", fontsize=12, color=INK)

    ax.set_xlim(-1.45, 1.45)
    ax.set_ylim(-0.95, TOP)
    ax.set_aspect("equal")
    ax.set_xticks([])
    ax.set_yticks([])
    for side in ("top", "right", "bottom", "left"):
        ax.spines[side].set_visible(False)
    ax.set_title("(a) geometry", fontsize=11, color=INK)


def panel_barrier(ax):
    """The barrier as a function of the distance to the boundary."""
    t = np.linspace(0.0, RHO, 601)
    w = barrier(t)
    ax.plot(t, w, color=GREEN, lw=2.0)
    ax.fill_between(t, 0.0, w, color=GREEN, alpha=0.12, lw=0)

    slope = 2.0 * LAMBDA * DELTA * np.exp(-LAMBDA * DELTA**2)
    ax.plot([0.0, 0.09], [0.0, slope * 0.09], color=RED, lw=1.2, ls=(0, (4, 2)))

    ax.plot([0.0], [0.0], "o", color=INK, ms=4)
    ax.annotate(r"$w(x_0) = 0$", xy=(0.0, 0.0), xytext=(0.035, 0.050),
                fontsize=9.5, color=INK,
                arrowprops=dict(arrowstyle="-", color=INK, lw=0.7))

    ax.annotate(r"$w(t) = e^{-\lambda(\delta - t)^2} - e^{-\lambda\delta^2}$",
                xy=(0.19, 0.219), xytext=(0.015, 0.228),
                fontsize=10, color=GREEN, va="center")
    ax.annotate(r"$u_\nu(x_0) \geq \varepsilon\, w'(0) = \varepsilon\,"
                r" 2\lambda\delta e^{-\lambda\delta^2} > 0$",
                xy=(0.19, 0.180), xytext=(0.015, 0.189),
                fontsize=10, color=RED, va="center")

    ax.axhline(0.0, color=INK, lw=0.8)
    ax.set_xlim(0.0, RHO)
    ax.set_ylim(-0.006, 0.255)
    ax.set_xlabel(r"$t = $ distance to $\partial\Omega$ along $-\nu$", fontsize=10)
    ax.set_ylabel(r"$w$", fontsize=11)
    for side in ("top", "right"):
        ax.spines[side].set_visible(False)
    ax.set_title(r"(b) barrier, $\delta = 1$, $\lambda = 2n/\delta^2 = 4$",
                 fontsize=11, color=INK)


def main():
    fig, axes = plt.subplots(1, 2, figsize=(10.4, 4.6),
                             gridspec_kw={"width_ratios": (0.92, 1.0)})
    panel_geometry(axes[0])
    panel_barrier(axes[1])

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT.with_suffix(".png"), dpi=150, bbox_inches="tight",
                facecolor="white")
    print(f"saved {OUT}")


if __name__ == "__main__":
    main()
