"""Huygens-Fresnel construction: secondary spherical wavelets and the envelope forming the new wavefront.  Generates img/huygens-fresnel.svg.  Run from the repository root:  uv run ..."""
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"   # 统一语义色
OUT = Path(__file__).resolve().parent.parent / "img" / "huygens-fresnel.svg"
OUT_PNG = OUT.with_suffix(".png")


def main():
    fig, ax = plt.subplots(figsize=(7, 5.4))

    ax.set_xlim(0, 5.2)
    ax.set_ylim(0, 5.2)
    ax.set_aspect("equal")

    # old wavefront (vertical line of source points)
    ys = np.linspace(1.0, 4.0, 7)
    x0 = 1.0
    ax.plot([x0, x0], [0.6, 4.4], color=BLUE, lw=2.0)
    ax.text(x0 + 0.08, 4.55, r"initial wavefront", color=BLUE, fontsize=12)

    # secondary wavelets: semicircular arcs to the right of each source
    r = 1.2
    th = np.linspace(-70, 70, 200) * np.pi / 180
    for y in ys:
        ax.plot(x0 + r * np.cos(th), y + r * np.sin(th), color=GRAY, lw=1.1)
        ax.plot([x0], [y], marker="o", ms=5, color=RED)

    # envelope: the new wavefront (vertical line tangent to the arcs)
    x1 = x0 + r
    ax.plot([x1, x1], [0.6, 4.4], color=RED, lw=2.4)
    ax.text(x1 + 0.08, 4.55, r"new wavefront (envelope)", color=RED, fontsize=12)

    # propagation direction
    ax.annotate("", xy=(4.8, 4.8), xytext=(4.8, 4.2),
                arrowprops=dict(arrowstyle="->", color="black", lw=1.6))
    ax.text(4.85, 3.95, r"propagation", fontsize=11)

    ax.set_xticks([])
    ax.set_yticks([])
    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
