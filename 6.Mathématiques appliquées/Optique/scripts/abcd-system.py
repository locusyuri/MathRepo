"""ABCD ray transfer: a paraxial ray (y, theta) through a translation T(d) and a thin lens L(f).  Generates img/abcd-system.svg.  Run from the repository root:  uv run ..."""
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import Rectangle

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"   # 统一语义色
OUT = Path(__file__).resolve().parent.parent / "img" / "abcd-system.svg"
OUT_PNG = OUT.with_suffix(".png")


def main():
    fig, ax = plt.subplots(figsize=(8, 4))

    d = 3.0
    f = 2.0
    y0, th0 = 0.5, 0.2
    y1 = y0 + th0 * d
    th1 = th0 - y1 / f
    y2 = y1 + th1 * d

    ax.set_xlim(-0.6, 7.2)
    ax.set_ylim(-1.3, 1.9)

    # optical axis
    ax.plot([-0.6, 7.2], [0, 0], color=GRAY, lw=1.0, linestyle="--")

    # translation region and lens
    ax.add_patch(Rectangle((0, -1.1), d, 2.4, facecolor="#dbeafe", alpha=0.35, edgecolor="none"))
    ax.plot([d, d], [-1.0, 1.0], color="black", lw=2.0)
    ax.text(d + 0.12, 1.15, r"thin lens $L(f)$", fontsize=11, ha="left")
    ax.text(d / 2, 1.35, r"translation $T(d)$", fontsize=11, ha="center")

    # ray path
    ax.plot([0, d, 2 * d], [y0, y1, y2], color=RED, lw=2.0)

    # ray vector symbols
    ax.annotate("", xy=(0.0, y0), xytext=(0.0, y0 - 0.55),
                arrowprops=dict(arrowstyle="-|>", color=BLUE, lw=1.6))
    ax.annotate("", xy=(2 * d, y2), xytext=(2 * d, y2 - 0.55),
                arrowprops=dict(arrowstyle="-|>", color=BLUE, lw=1.6))
    ax.text(-0.55, y0 - 0.75, r"$(y,\theta)$", color=BLUE, fontsize=13)
    ax.text(2 * d + 0.05, y2 - 0.75, r"$(y',\theta')$", color=BLUE, fontsize=13)

    ax.text(3.3, -0.95, r"system matrix:  $M = L(f)\,T(d)$", fontsize=12)

    ax.set_xticks([])
    ax.set_yticks([])
    ax.set_xlabel("z", fontsize=11)
    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
