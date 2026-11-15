"""The magic hexagon of the trigonometric functions.

The six vertices, clockwise, are sin, cos, cot, csc, sec, tan, with 1 at the
centre.  The three shaded triangles read

    sin^2 + cos^2 = 1,   tan^2 + 1 = sec^2,   1 + cot^2 = csc^2,

and along the clockwise arrow every vertex is the product of the next two.

Output: img/trig-magic-hexagon.svg
"""

from __future__ import annotations

import os
from math import cos, pi, sin
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import Circle, FancyArrowPatch, Polygon

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "trig-magic-hexagon.svg")

INK = "#1f2933"
GRAY = "#c8ccd0"

R = 1.0
NODES = [("sin", 120), ("cos", 60), ("cot", 0),
         ("csc", -60), ("sec", -120), ("tan", 180)]


def at(angle_deg, radius=R):
    a = angle_deg * pi / 180
    return (radius * cos(a), radius * sin(a))


def main():
    fig = plt.figure(figsize=(4.6, 4.3))
    ax = fig.add_axes([0, 0, 1, 1])
    ax.set_xlim(-1.72, 1.72)
    ax.set_ylim(-1.62, 1.78)
    ax.set_aspect("equal")
    ax.axis("off")

    pos = {name: at(angle) for name, angle in NODES}

    # Shaded triangles: two adjacent vertices plus the centre.
    for a, b in (("sin", "cos"), ("tan", "sec"), ("cot", "csc")):
        ax.add_patch(Polygon([pos[a], pos[b], (0, 0)], closed=True,
                             facecolor=GRAY, edgecolor="none", zorder=1))

    # Hexagon outline.
    ring = [pos[name] for name, _ in NODES]
    ax.add_patch(Polygon(ring, closed=True, facecolor="none", edgecolor=INK,
                         lw=1.3, joinstyle="round", zorder=3))

    # Centre disc carrying 1.
    ax.add_patch(Circle((0, 0), 0.25, facecolor="white", edgecolor=INK,
                        lw=1.2, zorder=4))
    ax.text(0, 0, "1", fontsize=13, color=INK, ha="center", va="center",
            zorder=5)

    # Vertex labels, pushed slightly outside.
    for name, angle in NODES:
        lx, ly = at(angle, R * 1.34)
        ax.text(lx, ly, name, fontsize=13, color=INK, ha="center",
                va="center", zorder=6)

    # Clockwise arrow over the top, from sin to cos.
    start = at(133, R * 1.52)
    end = at(47, R * 1.52)
    ax.add_patch(FancyArrowPatch(
        start, end, connectionstyle="arc3,rad=-0.42", arrowstyle="-|>",
        mutation_scale=14, color=INK, lw=1.2, shrinkA=0, shrinkB=0,
        zorder=2))

    fig.savefig(OUT, transparent=True, bbox_inches="tight", pad_inches=0.02)
    print(f"Saved: {OUT}")

    if os.environ.get("PREVIEW"):
        preview = OUT.with_name("trig-magic-hexagon-preview.png")
        fig.savefig(preview, dpi=170, facecolor="white", bbox_inches="tight",
                    pad_inches=0.02)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
