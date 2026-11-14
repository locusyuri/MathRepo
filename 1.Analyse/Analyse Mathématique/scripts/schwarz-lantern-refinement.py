"""Successively finer Schwarz lanterns.

Four inscribed polyhedral surfaces with (b, p) = (4, 7), (8, 15), (8, 30) and
(50, 70); b is the number of bands and p the number of points on each circle.
Refining both keeps the lantern visually close to the cylinder, yet its area
need not converge to the lateral area pi.

Output: img/schwarz-lantern-refinement.svg
"""

from __future__ import annotations

import os
import sys
from pathlib import Path

import matplotlib.pyplot as plt

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _lantern import cylinder_faces, dots, finished, paint

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "schwarz-lantern-refinement.svg")

HEIGHT, RADIUS = 1.0, 0.5
CASES = [(4, 7), (8, 15), (8, 30), (50, 70)]


def main():
    fig = plt.figure(figsize=(11.4, 3.3))
    for index, (bands, points) in enumerate(CASES, start=1):
        ax = fig.add_subplot(1, 4, index)
        finished(ax, ylim=(-0.62, 1.42))

        faces = cylinder_faces(bands, points, radius=RADIUS, height=HEIGHT)
        dense = bands * points > 400
        paint(ax, faces, linewidth=0.0 if dense else 0.45)

        # Only the two coarsest lanterns show their vertices.
        if index <= 2:
            vertices = [v for face, kind in faces if kind == "side"
                        for v in face]
            dots(ax, vertices, size=3.6, top_z=HEIGHT)

        ax.text(0.0, -0.50, rf"$b = {bands}\quad p = {points}$",
                fontsize=12, color="#1f2933", ha="center", va="center")

    fig.subplots_adjust(left=0.01, right=0.99, top=0.99, bottom=0.01,
                        wspace=0.02)
    fig.savefig(OUT, transparent=True, bbox_inches="tight", pad_inches=0.02)
    print(f"Saved: {OUT}")

    if os.environ.get("PREVIEW"):
        preview = OUT.with_name("schwarz-lantern-refinement-preview.png")
        fig.savefig(preview, dpi=150, facecolor="white", bbox_inches="tight",
                    pad_inches=0.02)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
