"""The five modal frame conditions behind the axioms T, 4, B, D, 5.
Generates img/modal-frames.svg (five small panels).  Run from the repository root:
uv run "4.Mathématiques discrètes/Logique Mathématique/scripts/modal-frames.py"

Each panel shows the accessibility pattern the axiom enforces on frames:
T reflexive, 4 transitive, B symmetric, D serial, 5 euclidean.
"""
from pathlib import Path
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

OUT = Path(__file__).resolve().parent.parent / "img" / "modal-frames.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "modal-frames-preview.png"

INK = "#22262e"
BLUE = "#3b6fb6"
RED = "#c74440"
GREEN = "#2f8f7d"
LIGHT = "#eef2f8"
GRAY = "#6b7280"

WORLD_R = 0.34


def world(ax, x, y, label):
    ax.add_patch(plt.Circle((x, y), WORLD_R, facecolor=LIGHT, edgecolor=INK, lw=1.5, zorder=3))
    ax.text(x, y, label, ha="center", va="center", fontsize=11, color=INK, zorder=4)


def arrow(ax, p, q, color=BLUE, lw=1.8):
    dx, dy = q[0] - p[0], q[1] - p[1]
    d = (dx * dx + dy * dy) ** 0.5
    ux, uy = dx / d, dy / d
    ax.annotate("", xy=(q[0] - ux * (WORLD_R + 0.08), q[1] - uy * (WORLD_R + 0.08)),
                xytext=(p[0] + ux * (WORLD_R + 0.08), p[1] + uy * (WORLD_R + 0.08)),
                arrowprops=dict(arrowstyle="-|>", color=color, lw=lw))


def loop(ax, x, y, color=BLUE):
    ax.add_patch(mpatches.FancyArrowPatch((x + WORLD_R * 0.9, y + WORLD_R * 0.9),
                                          (x + WORLD_R * 0.9, y - WORLD_R * 0.9),
                                          connectionstyle="arc3,rad=0.55",
                                          arrowstyle="-|>", mutation_scale=12,
                                          color=color, lw=1.8))


def main():
    fig, axes = plt.subplots(1, 5, figsize=(15.0, 3.6))
    for a in axes:
        a.axis("off")
        a.set_xlim(0, 1)
        a.set_ylim(0, 1)
        a.set_aspect("equal")

    # T: reflexive
    a = axes[0]
    a.set_title("T: reflexive", fontsize=12, color=INK, pad=4)
    world(a, 0.5, 0.5, "w")
    loop(a, 0.5, 0.5)
    a.text(0.5, 0.07, "$\u25a1p \\rightarrow p$", ha="center", va="bottom", fontsize=10.5, color=GRAY)

    # 4: transitive
    a = axes[1]
    a.set_title("4: transitive", fontsize=12, color=INK, pad=4)
    world(a, 0.18, 0.5, "w")
    world(a, 0.5, 0.5, "v")
    world(a, 0.82, 0.5, "u")
    arrow(a, (0.18, 0.5), (0.5, 0.5))
    arrow(a, (0.5, 0.5), (0.82, 0.5))
    arrow(a, (0.18, 0.5), (0.82, 0.5), color=GREEN)
    a.text(0.5, 0.07, "$\u25a1p \\rightarrow \u25a1\u25a1p$", ha="center", va="bottom",
           fontsize=10.5, color=GRAY)

    # B: symmetric
    a = axes[2]
    a.set_title("B: symmetric", fontsize=12, color=INK, pad=4)
    world(a, 0.3, 0.5, "w")
    world(a, 0.7, 0.5, "v")
    arrow(a, (0.3, 0.5), (0.7, 0.5))
    arrow(a, (0.7, 0.5), (0.3, 0.5))
    a.text(0.5, 0.07, "$p \\rightarrow \u25a1\u25c7p$", ha="center", va="bottom",
           fontsize=10.5, color=GRAY)

    # D: serial
    a = axes[3]
    a.set_title("D: serial", fontsize=12, color=INK, pad=4)
    world(a, 0.3, 0.62, "w")
    world(a, 0.7, 0.62, "v")
    world(a, 0.7, 0.3, "u")
    arrow(a, (0.3, 0.62), (0.7, 0.62))
    arrow(a, (0.7, 0.3), (0.3, 0.62))
    a.text(0.5, 0.07, "$\u25a1p \\rightarrow \u25c7p$", ha="center", va="bottom",
           fontsize=10.5, color=GRAY)

    # 5: euclidean
    a = axes[4]
    a.set_title("5: euclidean", fontsize=12, color=INK, pad=4)
    world(a, 0.28, 0.72, "v")
    world(a, 0.5, 0.3, "w")
    world(a, 0.72, 0.72, "u")
    arrow(a, (0.5, 0.3), (0.28, 0.72))
    arrow(a, (0.5, 0.3), (0.72, 0.72))
    arrow(a, (0.28, 0.72), (0.72, 0.72), color=GREEN)
    a.text(0.5, 0.07, "$\u25c7p \\rightarrow \u25a1\u25c7p$", ha="center", va="bottom",
           fontsize=10.5, color=GRAY)

    fig.tight_layout(pad=0.6)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
