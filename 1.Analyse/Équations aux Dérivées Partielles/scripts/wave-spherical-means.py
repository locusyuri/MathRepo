"""The method of spherical means behind Kirchhoff's formula.

Generates img/wave-spherical-means.svg (two panels):
  (a) the spherical mean M_u(x, r, t): average of u(., t) over the sphere;
  (b) the reduction v = r M_u to the 1-D wave equation on the whole line via
      the odd extension in r.

Run from the repository root:
  uv run "1.Analyse/Équations aux Dérivées Partielles/scripts/wave-spherical-means.py"
"""

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import Ellipse

BLUE = "#3b6fb6"
RED = "#c74440"
GRAY = "#888888"
T1 = 1.0
OUT = Path(__file__).resolve().parent.parent / "img" / "wave-spherical-means.svg"

v0 = lambda r: 0.9 * r * np.exp(-(r**2) / 0.6)  # odd data v(r, 0)


def main():
    fig, axes = plt.subplots(1, 2, figsize=(9.8, 4.1))

    # ------------------------------------------------------- (a) sphere
    ax = axes[0]
    ax.set_aspect("equal")
    ax.axis("off")
    ax.set_xlim(-2.1, 2.1)
    ax.set_ylim(-1.75, 2.0)
    circ = plt.Circle((0, 0.1), 1.25, fill=True, color=BLUE, alpha=0.08, lw=1.4)
    ax.add_patch(circ)
    ax.add_patch(Ellipse((0, 0.1), 2.5, 0.55, fill=False, color=BLUE, lw=0.9, alpha=0.65))
    ax.add_patch(Ellipse((0, 0.1), 0.62, 2.5, fill=False, color=BLUE, lw=0.9, alpha=0.65))
    ax.plot([0], [0.1], "o", color=RED, ms=5)
    ax.annotate("$x$", xy=(0, 0.1), xytext=(-0.34, 0.22), fontsize=12, color=RED)
    ax.annotate("", xy=(1.25 * np.cos(0.6), 0.1 + 1.25 * np.sin(0.6)), xytext=(0, 0.1),
                arrowprops=dict(arrowstyle="->", color="black", lw=1.0))
    ax.annotate("$r$", xy=(0.62, 0.55), fontsize=12)
    for ang in (0.35, 1.5, 2.6, 4.0, 5.3):
        ax.plot([1.25 * np.cos(ang)], [0.1 + 1.25 * np.sin(ang)], "o",
                color=BLUE, ms=3.5)
    ax.annotate("$u(y,t)$", xy=(1.25 * np.cos(1.5), 0.1 + 1.25 * np.sin(1.5)),
                xytext=(1.05, 1.72), fontsize=10,
                arrowprops=dict(arrowstyle="-", color=GRAY, lw=0.7))
    ax.text(0, -1.45,
            r"$M_u(x,r,t)=\dfrac{1}{4\pi r^2}\int_{\partial B(x,r)} u(y,t)\,dS_y$",
            ha="center", fontsize=10.5)
    ax.set_title("(a) average over the sphere", fontsize=10.5)

    # ------------------------------------------------- (b) (r, t)-plane
    ax = axes[1]
    ax.set_xlim(-2.6, 2.6)
    ax.set_ylim(-0.55, 2.2)
    ax.set_aspect("equal")
    for side in ("top", "right"):
        ax.spines[side].set_visible(False)
    ax.spines["left"].set_position("zero")
    ax.spines["bottom"].set_position("zero")
    ax.set_xticks([])
    ax.set_yticks([])
    ax.annotate("$r$", xy=(2.6, 0), xytext=(2.42, -0.28), fontsize=11)
    ax.annotate("$t$", xy=(0, 2.2), xytext=(-0.3, 1.98), fontsize=11)
    r = np.linspace(-2.6, 2.6, 700)
    ax.fill([0, 2.6, 2.6, 0], [0, 0, 2.2, 2.2], color=BLUE, alpha=0.06, lw=0)
    ax.plot(r, v0(r), color="black", lw=1.5)
    ax.plot(r, (v0(r - T1) + v0(r + T1)) / 2, color=BLUE, lw=1.5)
    ax.annotate(r"$v(r,0)=r\,M_\varphi$", xy=(0.95, 0.24), xytext=(1.35, 0.62),
                fontsize=10, arrowprops=dict(arrowstyle="-", color="black", lw=0.7))
    ax.annotate(r"$v(r,t)=\frac{1}{2}\left(v_0(r-t)+v_0(r+t)\right)$",
                xy=(-0.55, 0.15), xytext=(-2.5, 1.45), fontsize=10, color=BLUE,
                arrowprops=dict(arrowstyle="-", color=BLUE, lw=0.7))
    ax.plot([0], [0], "o", color=RED, ms=4.5)
    ax.annotate(r"$u(x,t)=\partial_r v(0,t)$", xy=(0.04, 0.02),
                xytext=(0.5, 1.85), fontsize=10, color=RED,
                arrowprops=dict(arrowstyle="-", color=RED, lw=0.7))
    ax.text(-2.5, 0.42, "odd extension\nin $r$", fontsize=9, color=GRAY)
    ax.text(2.02, 1.02, "$r>0$", fontsize=9, color=GRAY)
    ax.set_title("(b) reduction to the 1-D wave equation", fontsize=10.5)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    print(f"saved {OUT}")


if __name__ == "__main__":
    main()
