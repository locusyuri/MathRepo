"""Wavefronts and rays for the eikonal picture.  Generates img/waves-to-rays.svg (two panels).  Run from the repository root:  uv run ..."""
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"   # 统一语义色
OUT = Path(__file__).resolve().parent.parent / "img" / "waves-to-rays.svg"
OUT_PNG = OUT.with_suffix(".png")


def main():
    fig, axes = plt.subplots(1, 2, figsize=(9, 4.2))

    # (a) plane wavefronts with orthogonal rays
    ax = axes[0]
    ax.set_xlim(0, 4)
    ax.set_ylim(0, 4)
    ax.set_aspect("equal")
    for x in (0.6, 1.6, 2.6, 3.6):
        ax.plot([x, x], [0.4, 3.6], color=BLUE, lw=1.5)
    for y in (0.7, 1.7, 2.7, 3.4):
        ax.annotate("", xy=(3.9, y), xytext=(0.2, y),
                    arrowprops=dict(arrowstyle="->", color=RED, lw=1.5))
    ax.text(0.6, 0.2, r"wavefronts", color=BLUE, fontsize=11)
    ax.text(2.0, 3.7, r"rays $(\nabla S)$", color=RED, fontsize=11)
    ax.set_title("(a) Plane wavefronts", fontsize=12)
    ax.set_xticks([])
    ax.set_yticks([])
    ax.set_xlabel("z", fontsize=11)

    # (b) spherical wavefronts with radial rays
    ax = axes[1]
    ax.set_xlim(-2.4, 2.4)
    ax.set_ylim(-2.4, 2.4)
    ax.set_aspect("equal")
    for r in (0.6, 1.2, 1.8, 2.3):
        th = np.linspace(0, 2 * np.pi, 200)
        ax.plot(r * np.cos(th), r * np.sin(th), color=BLUE, lw=1.5)
    for ang in np.linspace(0, 2 * np.pi, 8, endpoint=False):
        ux, uy = np.cos(ang), np.sin(ang)
        ax.annotate("", xy=(2.2 * ux, 2.2 * uy), xytext=(0.5 * ux, 0.5 * uy),
                    arrowprops=dict(arrowstyle="->", color=RED, lw=1.5))
    ax.text(0.0, -1.95, r"rays $(\nabla S)$", color=RED, fontsize=11, ha="center")
    ax.text(1.45, 1.05, r"wavefronts", color=BLUE, fontsize=11)
    ax.set_title("(b) Spherical wavefronts", fontsize=12)
    ax.set_xticks([])
    ax.set_yticks([])
    ax.set_xlabel("z", fontsize=11)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
