"""Optical instruments: (a) compound microscope, (b) Keplerian telescope.  Generates img/optical-instruments.svg (two panels).  Run from the repository root:  uv run ..."""
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"   # 统一语义色
ORANGE, GREEN = "#e07b00", "#2f9e44"
OUT = Path(__file__).resolve().parent.parent / "img" / "optical-instruments.svg"
OUT_PNG = OUT.with_suffix(".png")


def lens_symbol(ax, x, ymin, ymax):
    ax.plot([x, x], [ymin, ymax], color="black", lw=2.0)
    for y in (ymin, ymax):
        ax.annotate("", xy=(x - 0.15, y), xytext=(x, y),
                    arrowprops=dict(arrowstyle="-", color="black", lw=1.3))
        ax.annotate("", xy=(x + 0.15, y), xytext=(x, y),
                    arrowprops=dict(arrowstyle="-", color="black", lw=1.3))


def main():
    fig, axes = plt.subplots(1, 2, figsize=(11, 4.6))

    # ---- (a) compound microscope ----
    ax = axes[0]
    ax.set_xlim(-1.5, 13)
    ax.set_ylim(-4.2, 4.0)
    ax.set_aspect("equal")
    ax.plot([-1.5, 13], [0, 0], color=GRAY, lw=1.0, linestyle="--")

    x_obj, x_eye = 2.0, 10.0
    lens_symbol(ax, x_obj, -1.0, 1.0)
    lens_symbol(ax, x_eye, -1.0, 1.0)
    ax.text(x_obj, 1.25, "objective", fontsize=11, ha="center")
    ax.text(x_eye, 1.25, "eyepiece", fontsize=11, ha="center")

    # object (upright), intermediate image (inverted at x=8, height -2.4)
    ax.annotate("", xy=(0, 0.8), xytext=(0, 0),
                arrowprops=dict(arrowstyle="-|>", color=RED, lw=2.0))
    ax.text(0, 1.1, "object", color=RED, fontsize=11, ha="center")
    ax.annotate("", xy=(8, -2.4), xytext=(8, 0),
                arrowprops=dict(arrowstyle="-|>", color=ORANGE, lw=2.0))
    ax.text(8, -3.0, "intermediate\nimage", color=ORANGE, fontsize=10, ha="center")

    # rays: top of object -> objective -> intermediate image top; through centre
    ax.plot([0, x_obj, 8], [0.8, 0.8, -2.4], color=BLUE, lw=1.5)
    ax.plot([0, x_obj, 8], [0.8, 0.0, -2.4], color=BLUE, lw=1.5)
    # intermediate image top -> eyepiece -> parallel emerging rays
    ax.plot([8, x_eye, 12.8], [-2.4, -0.8, -0.8], color=BLUE, lw=1.5)
    ax.plot([8, x_eye, 12.8], [-2.4, 0.0, 0.0], color=BLUE, lw=1.5)
    ax.text(12.6, 0.55, r"image at infinity", fontsize=10, ha="right")
    ax.set_title("(a) Compound microscope", fontsize=12)
    ax.set_xticks([])
    ax.set_yticks([])

    # ---- (b) Keplerian telescope ----
    ax = axes[1]
    ax.set_xlim(-7.5, 11.5)
    ax.set_ylim(-3.0, 3.0)
    ax.set_aspect("equal")
    ax.plot([-7.5, 11.5], [0, 0], color=GRAY, lw=1.0, linestyle="--")

    x_obj, x_eye = 2.0, 8.0
    lens_symbol(ax, x_obj, -1.2, 1.2)
    lens_symbol(ax, x_eye, -1.2, 1.2)
    ax.text(x_obj, 1.55, "objective", fontsize=11, ha="center")
    ax.text(x_eye, 1.55, "eyepiece", fontsize=11, ha="center")

    # distant object, intermediate image at x = 6 (focal plane), height -0.5
    ax.annotate("", xy=(-6, 1.0), xytext=(-6, 0),
                arrowprops=dict(arrowstyle="-|>", color=RED, lw=2.0))
    ax.text(-6, 1.35, "distant object", color=RED, fontsize=10, ha="center")
    ax.annotate("", xy=(6, -0.5), xytext=(6, 0),
                arrowprops=dict(arrowstyle="-|>", color=ORANGE, lw=2.0))
    ax.text(6, -1.2, "intermediate\nimage", color=ORANGE, fontsize=10, ha="center")

    # rays: parallel bundle -> objective -> focus at intermediate image -> eyepiece -> parallel
    ax.plot([-6, x_obj, 6], [1.0, 1.0, -0.5], color=BLUE, lw=1.5)
    ax.plot([-6, x_obj, 6], [1.0, 0.0, -0.5], color=BLUE, lw=1.5)
    ax.plot([6, x_eye, 11], [-0.5, 0.25, 0.25], color=BLUE, lw=1.5)
    ax.plot([6, x_eye, 11], [-0.5, 0.0, 0.0], color=BLUE, lw=1.5)
    ax.text(11, 0.6, r"parallel rays", fontsize=10, ha="right")
    ax.set_title("(b) Keplerian telescope", fontsize=12)
    ax.set_xticks([])
    ax.set_yticks([])

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
