"""Gaussian imaging with a thin converging lens: three characteristic rays.  Generates img/lens-imaging.svg.  Run from the repository root:  uv run ..."""
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"   # 统一语义色
ORANGE = "#e07b00"
OUT = Path(__file__).resolve().parent.parent / "img" / "lens-imaging.svg"
OUT_PNG = OUT.with_suffix(".png")


def main():
    fig, ax = plt.subplots(figsize=(10.5, 3.4))

    f = 2.0
    xO, xL, xI = -5.0, 0.0, 10.0 / 3.0
    hO, hI = 1.0, -2.0 / 3.0

    ax.set_xlim(-6, 6)
    ax.set_ylim(-1.5, 1.9)
    ax.set_aspect("equal")

    # optical axis
    ax.plot([-6, 6], [0, 0], color=GRAY, lw=1.0, linestyle="--")

    # thin lens symbol at x = 0
    ax.plot([0, 0], [-1.0, 1.0], color="black", lw=2.0)
    ax.annotate("", xy=(-0.25, 1.0), xytext=(0, 1.0),
                arrowprops=dict(arrowstyle="-", color="black", lw=1.4))
    ax.annotate("", xy=(-0.25, -1.0), xytext=(0, -1.0),
                arrowprops=dict(arrowstyle="-", color="black", lw=1.4))
    ax.annotate("", xy=(0.25, 1.0), xytext=(0, 1.0),
                arrowprops=dict(arrowstyle="-", color="black", lw=1.4))
    ax.annotate("", xy=(0.25, -1.0), xytext=(0, -1.0),
                arrowprops=dict(arrowstyle="-", color="black", lw=1.4))

    # object (upright arrow) and image (inverted arrow)
    ax.annotate("", xy=(xO, hO), xytext=(xO, 0),
                arrowprops=dict(arrowstyle="-|>", color=RED, lw=2.2))
    ax.annotate("", xy=(xI, hI), xytext=(xI, 0),
                arrowprops=dict(arrowstyle="-|>", color=ORANGE, lw=2.2))
    ax.text(xO, 1.12, r"$P$", color=RED, fontsize=14)
    ax.text(xI, hI - 0.45, r"$P'$", color=ORANGE, fontsize=14)

    # focal points
    ax.plot([-f, f], [0, 0], marker="|", ms=14, color="black")
    ax.text(-f, 0.22, r"$F$", fontsize=14)
    ax.text(f, 0.22, r"$F'$", fontsize=14)

    # three characteristic rays: parallel, through centre, through F
    ax.plot([xO, xL, 2.0, xI], [hO, hO, 0.0, hI], color=BLUE, lw=1.6)
    ax.plot([xO, xL, xI], [hO, 0.0, hI], color=BLUE, lw=1.6)
    ax.plot([xO, -f, xL, xI], [hO, 0.0, hI, hI], color=BLUE, lw=1.6)

    # distances s, s', f
    ax.annotate("", xy=(xL, -1.25), xytext=(xO, -1.25),
                arrowprops=dict(arrowstyle="<->", color="black", lw=1.1))
    ax.text(-3.1, -1.45, r"$s$", fontsize=14)
    ax.annotate("", xy=(xI, -1.25), xytext=(xL, -1.25),
                arrowprops=dict(arrowstyle="<->", color="black", lw=1.1))
    ax.text(1.35, -1.45, r"$s'$", fontsize=14)
    ax.annotate("", xy=(f, -1.75), xytext=(0, -1.75),
                arrowprops=dict(arrowstyle="<->", color=ORANGE, lw=1.1))
    ax.text(0.55, -1.95, r"$f$", color=ORANGE, fontsize=14)

    ax.set_xticks([])
    ax.set_yticks([])
    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
