"""Young's double-slit experiment: geometry and cosine-squared fringes.  Generates img/young-double-slit.svg (two panels, schematic).  Run from the repository root:  uv run ..."""
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"   # 统一语义色
OUT = Path(__file__).resolve().parent.parent / "img" / "young-double-slit.svg"
OUT_PNG = OUT.with_suffix(".png")


def main():
    fig, axes = plt.subplots(1, 2, figsize=(10, 4.2))

    # (a) geometry (schematic, not to scale)
    ax = axes[0]
    ax.set_xlim(-0.6, 6.8)
    ax.set_ylim(-2.2, 2.2)
    ax.set_aspect("equal")

    # screen with two slits at x = 0
    ax.plot([0, 0], [-1.6, 1.6], color="black", lw=2.2)
    ax.plot([0, 0], [-0.45, 0.45], color="white", lw=3.0)
    d = 1.0
    for y in (-d / 2, d / 2):
        ax.plot([0], [y], marker="o", ms=7, color=RED)
    # observation screen at x = 6
    ax.plot([6, 6], [-1.6, 1.6], color="black", lw=2.2)

    # rays from the two slits to a common observation point
    y0 = 0.9
    for y in (-d / 2, d / 2):
        ax.plot([0, 6], [y, y0], color=BLUE, lw=1.5)
    ax.plot([6], [y0], marker="o", ms=6, color=BLUE)
    ax.text(0.25, 1.25, r"$d$", fontsize=13)
    ax.text(2.9, -1.05, r"$R$", fontsize=13)
    ax.text(6.15, 1.0, r"$y$", fontsize=13)
    ax.text(3.0, 1.9, r"screen", fontsize=12, ha="center")
    ax.set_title("(a) Geometry (schematic)", fontsize=12)
    ax.set_xticks([])
    ax.set_yticks([])

    # (b) fringe intensity in units of the fringe spacing u = y / Delta y
    ax = axes[1]
    u = np.linspace(-6, 6, 800)
    I = np.cos(np.pi * u) ** 2
    ax.plot(u, I, color=RED, lw=2.0)
    ax.set_xlim(-6, 6)
    ax.set_ylim(0, 1.15)
    ax.set_xlabel(r"$y / \Delta y$", fontsize=12)
    ax.set_ylabel(r"$I / I_{\max}$", fontsize=12)
    ax.set_title("(b) Fringe intensity $\\propto \\cos^2$", fontsize=12)
    ax.axvline(0, color=GRAY, lw=0.8, ls="--")
    ax.grid(alpha=0.3)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
