"""The 2f Fourier system: input plane, lens, focal plane; parallel rays focus at the Fourier plane.  Generates img/lens-fourier.svg (schematic).  Run from the repository root:  uv run ..."""
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"   # 统一语义色
ORANGE = "#e07b00"
OUT = Path(__file__).resolve().parent.parent / "img" / "lens-fourier.svg"
OUT_PNG = OUT.with_suffix(".png")


def main():
    fig, ax = plt.subplots(figsize=(8.5, 4.6))

    ax.set_xlim(-0.8, 6.6)
    ax.set_ylim(-2.2, 2.2)
    ax.set_aspect("equal")

    # optical axis
    ax.plot([-0.8, 6.6], [0, 0], color=GRAY, lw=1.0, ls="--")

    # input plane at x = 0 (aperture symbol), lens at x = 2, focal plane at x = 4
    ax.plot([0, 0], [-1.4, 1.4], color="black", lw=2.0)
    ax.plot([2, 2], [-1.4, 1.4], color="black", lw=2.2)
    for y in (-1.4, 1.4):
        ax.annotate("", xy=(1.85, y), xytext=(2, y),
                    arrowprops=dict(arrowstyle="-", color="black", lw=1.4))
        ax.annotate("", xy=(2.15, y), xytext=(2, y),
                    arrowprops=dict(arrowstyle="-", color="black", lw=1.4))
    ax.plot([4, 4], [-1.4, 1.4], color="black", lw=2.0)

    ax.text(0, 1.62, "input plane", fontsize=11, ha="center")
    ax.text(2, 1.62, "lens ($f$)", fontsize=11, ha="center")
    ax.text(4, 1.62, "focal plane", fontsize=11, ha="center")
    ax.text(4, 1.95, "(Fourier transform)", fontsize=10, ha="center")

    # rays: three parallel rays from the input, refracted through the lens to the focus
    for y in (-0.9, 0.0, 0.9):
        ax.plot([0, 2], [y, y], color=BLUE, lw=1.6)
        ax.plot([2, 4], [y, 0.0], color=RED, lw=1.6)
    # chief ray through the centre of the lens
    ax.plot([0, 2, 5.8], [1.4, 0.0, -1.4], color=BLUE, lw=1.6)

    # input signal symbol
    ax.plot([-0.35, 0.0, -0.35], [0.5, 0.0, -0.5], color=ORANGE, lw=2.0)
    ax.plot([-0.5, -0.35], [0.5, 0.5], color=ORANGE, lw=2.0)
    ax.plot([-0.5, -0.35], [-0.5, -0.5], color=ORANGE, lw=2.0)

    # focal markers
    ax.annotate("", xy=(4, -1.85), xytext=(2, -1.85),
                arrowprops=dict(arrowstyle="<->", color=ORANGE, lw=1.2))
    ax.annotate("", xy=(2, -1.85), xytext=(0, -1.85),
                arrowprops=dict(arrowstyle="<->", color=ORANGE, lw=1.2))
    ax.text(2.85, -2.15, r"$f$", color=ORANGE, fontsize=13)
    ax.text(0.85, -2.15, r"$f$", color=ORANGE, fontsize=13)

    ax.set_xticks([])
    ax.set_yticks([])
    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
