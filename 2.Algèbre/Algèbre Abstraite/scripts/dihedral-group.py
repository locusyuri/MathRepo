"""The dihedral group D_6 acting on the regular hexagon.

Generates img/dihedral-group.svg.  Run from the repository root:

    uv run "2.Algèbre/Algèbre Abstraite/scripts/dihedral-group.py"

Left panel: the rotation r through 2 pi / 6.  Right panel: one reflection s,
whose mirror axis passes through two opposite vertices and swaps the two pairs
of remaining vertices.  Together the six rotations and six reflections form D_6.
"""
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import Arc, Circle, FancyArrowPatch, Polygon

OUT = Path(__file__).resolve().parent.parent / "img" / "dihedral-group.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "dihedral-group-preview.png"

INK = "#22262e"
BLUE = "#3b6fb6"
RED = "#c74440"
LIGHT = "#eef2f8"
GRAY = "#6b7280"

N = 6
ANGLES = np.pi / 2 + 2 * np.pi * np.arange(N) / N


def draw_polygon(ax):
    pts = np.column_stack([np.cos(ANGLES), np.sin(ANGLES)])
    ax.add_patch(Polygon(pts, closed=True, facecolor=LIGHT, edgecolor=INK, lw=1.8, zorder=2))
    for k, (x, y) in enumerate(pts):
        ax.add_patch(Circle((x, y), 0.075, facecolor="white", edgecolor=INK, lw=1.1, zorder=4))
        ax.text(1.16 * x, 1.16 * y, str(k), ha="center", va="center",
                fontsize=10.5, color=INK, zorder=5)


def rotation_panel(ax):
    draw_polygon(ax)
    radius = 0.60
    ax.add_patch(Arc((0, 0), 2 * radius, 2 * radius, theta1=84, theta2=153,
                     color=BLUE, lw=2.0, zorder=3))
    end_ang = np.deg2rad(153)
    end = np.array([radius * np.cos(end_ang), radius * np.sin(end_ang)])
    tangent = np.array([-np.sin(end_ang), np.cos(end_ang)])
    ax.annotate("", xy=end, xytext=end - 0.05 * tangent,
                arrowprops=dict(arrowstyle="-|>", color=BLUE, lw=2.0,
                                mutation_scale=15), zorder=3)
    mid_ang = np.deg2rad(118)
    ax.text(0.78 * np.cos(mid_ang), 0.78 * np.sin(mid_ang), "$r$",
            ha="center", va="center", fontsize=13, color=BLUE)
    ax.text(0.0, -1.38, "$r$: rotation through $60^\\circ$",
            ha="center", va="center", fontsize=11, color=BLUE)


def reflection_panel(ax):
    draw_polygon(ax)
    ax.plot([0, 0], [-1.12, 1.12], color=RED, lw=1.4,
            linestyle=(0, (5, 4)), zorder=3)
    for y, rad in ((0.5, 0.12), (-0.5, -0.12)):
        ax.add_patch(FancyArrowPatch((-0.866, y), (0.866, y),
                                     connectionstyle=f"arc3,rad={rad}",
                                     arrowstyle="<|-|>", mutation_scale=14,
                                     color=RED, lw=1.8, zorder=3))
    ax.text(0.11, 0.0, "$s$", ha="left", va="center", fontsize=13, color=RED)
    ax.text(0.0, -1.38, "$s$: reflection in a mirror axis",
            ha="center", va="center", fontsize=11, color=RED)


def main():
    fig, axes = plt.subplots(1, 2, figsize=(10.8, 5.6))
    for ax, title, panel in zip(axes, ("rotation", "reflection"),
                                (rotation_panel, reflection_panel)):
        ax.axis("off")
        ax.set_xlim(-1.45, 1.45)
        ax.set_ylim(-1.55, 1.45)
        ax.set_aspect("equal")
        ax.set_title(title, fontsize=12, color=INK, pad=4)
        panel(ax)

    fig.tight_layout(pad=0.8)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
