"""Snell's law and the law of reflection at a planar interface.  Generates img/snells-law.svg.  Run from the repository root:  uv run ..."""
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import Arc, Rectangle

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"   # 统一语义色
GREEN, ORANGE = "#2f9e44", "#e07b00"
OUT = Path(__file__).resolve().parent.parent / "img" / "snells-law.svg"
OUT_PNG = OUT.with_suffix(".png")


def main():
    fig, ax = plt.subplots(figsize=(7, 6))

    ax.set_xlim(-5, 5)
    ax.set_ylim(-3.4, 3.4)
    ax.set_aspect("equal")

    # media
    ax.add_patch(Rectangle((-5, 0), 10, 3.4, facecolor="#dbeafe", alpha=0.55, edgecolor="none"))
    ax.add_patch(Rectangle((-5, -3.4), 10, 3.4, facecolor="#fed7aa", alpha=0.55, edgecolor="none"))

    # interface and normal
    ax.plot([-5, 5], [0, 0], color="black", lw=1.6)
    ax.plot([0, 0], [-2.9, 2.9], color=GRAY, lw=1.2, linestyle="--")

    # rays: incidence 45 deg, reflection 45 deg, refraction 30 deg (n1 sin45 = n2 sin30 -> n2/n1 = sqrt2)
    ax.annotate("", xy=(0, 0), xytext=(-3, 3),
                arrowprops=dict(arrowstyle="->", color=BLUE, lw=2))
    ax.annotate("", xy=(3, 3), xytext=(0, 0),
                arrowprops=dict(arrowstyle="->", color=GREEN, lw=2))
    ax.annotate("", xy=(4, -4 * np.tan(np.deg2rad(30))), xytext=(0, 0),
                arrowprops=dict(arrowstyle="->", color=RED, lw=2))

    # angle arcs
    ax.add_patch(Arc((0, 0), 2.4, 2.4, theta1=45, theta2=90, color=BLUE, lw=1.2))
    ax.add_patch(Arc((0, 0), 2.4, 2.4, theta1=90, theta2=135, color=GREEN, lw=1.2))
    ax.add_patch(Arc((0, 0), 2.0, 2.0, theta1=270, theta2=300, color=RED, lw=1.2))

    ax.text(1.05, 0.75, r"$\theta_1$", color=BLUE, fontsize=14)
    ax.text(-1.3, 0.75, r"$\theta_1'$", color=GREEN, fontsize=14)
    ax.text(0.85, -1.15, r"$\theta_2$", color=RED, fontsize=14)
    ax.text(0.35, 3.05, r"$n_1$", fontsize=14, color="#1d4ed8")
    ax.text(0.35, -3.2, r"$n_2$", fontsize=14, color="#c2410c")

    ax.set_xticks([])
    ax.set_yticks([])
    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
