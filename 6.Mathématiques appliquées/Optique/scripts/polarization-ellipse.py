"""Polarization ellipses traced by the electric vector for phase differences 0, pi/2, pi/4.  Generates img/polarization-ellipse.svg (three panels).  Run from the repository root:  uv run ..."""
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"   # 统一语义色
OUT = Path(__file__).resolve().parent.parent / "img" / "polarization-ellipse.svg"
OUT_PNG = OUT.with_suffix(".png")


def main():
    fig, axes = plt.subplots(1, 3, figsize=(11, 3.9))

    t = np.linspace(0, 2 * np.pi, 400)
    for ax, (delta, title) in zip(
        axes,
        [(0.0, r"Linear: $\delta = 0$"), (np.pi / 2, r"Circular: $\delta = \pi/2$"), (np.pi / 4, r"Elliptical: $\delta = \pi/4$")],
    ):
        Ex = np.cos(t)
        Ey = np.cos(t + delta)
        ax.plot(Ex, Ey, color=RED, lw=2.2)
        ax.axhline(0, color=GRAY, lw=0.8)
        ax.axvline(0, color=GRAY, lw=0.8)
        ax.set_xlim(-1.3, 1.3)
        ax.set_ylim(-1.3, 1.3)
        ax.set_aspect("equal")
        ax.set_title(title, fontsize=12)
        ax.set_xlabel(r"$E_x$", fontsize=12)
        ax.set_ylabel(r"$E_y$", fontsize=12)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
