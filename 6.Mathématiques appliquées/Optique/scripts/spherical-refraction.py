"""Single spherical refracting surface: object, image, centre of curvature, paraxial ray.  Generates img/spherical-refraction.svg.  Run from the repository root:  uv run ..."""
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import Wedge

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"   # 统一语义色
ORANGE = "#e07b00"
OUT = Path(__file__).resolve().parent.parent / "img" / "spherical-refraction.svg"
OUT_PNG = OUT.with_suffix(".png")


def main():
    fig, ax = plt.subplots(figsize=(9, 4.5))

    R = 2.0        # radius of curvature (centre C at (R, 0))
    xP, xQ, xPP = -6.0, 2.0 - R * np.cos(np.deg2rad(30)), 18.0
    yQ = R * np.sin(np.deg2rad(30))

    ax.set_xlim(-7, 20)
    ax.set_ylim(-2.6, 2.6)
    ax.set_aspect("equal")

    # optical axis
    ax.plot([-7, 20], [0, 0], color=GRAY, lw=1.0, linestyle="--")

    # medium 2 (right of the surface apex, shaded)
    ax.add_patch(Wedge((R, 0), R, -55, 55, facecolor="#fed7aa", alpha=0.45, edgecolor="none"))

    # refracting surface: arc centred at C with vertex at (0,0)
    th = np.linspace(-50, 50, 200)
    ax.plot(R + R * np.cos(np.deg2rad(th)), R * np.sin(np.deg2rad(th)), color="black", lw=2.0)

    # object and image points
    ax.plot([xP], [0], marker="o", ms=7, color=BLUE)
    ax.plot([xPP], [0], marker="o", ms=7, color=RED)
    ax.plot([R], [0], marker="o", ms=6, color=GRAY)
    ax.text(xP, -0.45, r"$P$", color=BLUE, fontsize=14)
    ax.text(xPP, -0.45, r"$P'$", color=RED, fontsize=14)
    ax.text(R, -0.45, r"$C$", color=GRAY, fontsize=14)

    # paraxial ray from P through Q (height y=1) to P'
    ax.plot([xP, xQ], [0, yQ], color=BLUE, lw=1.8)
    ax.plot([xQ, xPP], [yQ, 0], color=RED, lw=1.8)
    ax.plot([xQ, R], [yQ, 0], color=GRAY, lw=1.0, linestyle=":")

    # distances
    ax.annotate("", xy=(0, -1.7), xytext=(xP, -1.7),
                arrowprops=dict(arrowstyle="<->", color="black", lw=1.1))
    ax.text(-3.6, -2.15, r"$s$", fontsize=14)
    ax.annotate("", xy=(xPP, -1.7), xytext=(0, -1.7),
                arrowprops=dict(arrowstyle="<->", color="black", lw=1.1))
    ax.text(8.6, -2.15, r"$s'$", fontsize=14)
    ax.annotate("", xy=(xQ, 1.55), xytext=(0, 1.55),
                arrowprops=dict(arrowstyle="<->", color=ORANGE, lw=1.1))
    ax.text(0.6, 1.85, r"$R$", color=ORANGE, fontsize=14)

    ax.set_xticks([])
    ax.set_yticks([])
    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
