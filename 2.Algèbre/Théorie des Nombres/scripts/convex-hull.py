"""The permutahedron: convex hull of the permutation orbit of a vector in R^3.

For alpha = (3, 2, 1) the six rearrangements are the vertices of a regular
hexagon lying in the plane x + y + z = 6; the hull is drawn together with a
patch of that plane.

Output: ../img/convex-hull.svg
"""

from __future__ import annotations

import os
import sys
from dataclasses import replace
from itertools import permutations
from pathlib import Path

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d.art3d import Poly3DCollection

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(5.6, 4.8))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1f2933"
AXIS = "#8b949e"
BLUE = "#1f4e9b"
FILL = "#dbe8f7"
DOT = "#c0392b"

ALPHA = (3, 2, 1)


def main():
    verts = np.array(sorted(set(permutations(ALPHA))), dtype=float)
    centre = verts.mean(axis=0)

    # Orthonormal basis of the plane x + y + z = const.
    u = np.array([1.0, -1.0, 0.0]) / np.sqrt(2)
    v = np.array([1.0, 1.0, -2.0]) / np.sqrt(6)
    order = sorted(verts, key=lambda p: np.arctan2((p - centre) @ v,
                                                   (p - centre) @ u))

    fig = SPEC.figure()
    ax = fig.add_subplot(111, projection="3d")
    ax.set_box_aspect((1, 1, 1))

    # A patch of the plane containing the hexagon.
    span = 1.75
    corners = [centre + span * (su * u + sv * v)
               for su, sv in ((1, 1), (-1, 1), (-1, -1), (1, -1))]
    ax.add_collection3d(Poly3DCollection(
        [[tuple(c) for c in corners]], facecolor=FILL, edgecolor="none",
        alpha=0.30))

    ax.add_collection3d(Poly3DCollection(
        [[tuple(p) for p in order]], facecolor=FILL, edgecolor=BLUE,
        lw=1.4, alpha=0.55))

    for p in verts:
        ax.scatter(*p, color=DOT, s=16, depthshade=False)
        out = p - centre
        label_at = p + 0.45 * out / np.linalg.norm(out)
        ax.text(*label_at, "(%d,%d,%d)" % tuple(int(t) for t in p),
                fontsize=7.0, color=INK, ha="center", va="center")

    ax.grid(False)
    for axis in (ax.xaxis, ax.yaxis, ax.zaxis):
        axis.pane.set_facecolor((1, 1, 1, 0))
        axis.pane.set_edgecolor((1, 1, 1, 0))
        axis.pane.set_alpha(0.0)
        axis.line.set_color(AXIS)

    ax.set_xlim(0.4, 3.8)
    ax.set_ylim(0.4, 3.8)
    ax.set_zlim(0.4, 3.8)
    ax.set_xticks([1, 2, 3])
    ax.set_yticks([1, 2, 3])
    ax.set_zticks([1, 2, 3])
    ax.tick_params(labelsize=7, colors=INK, pad=1, length=2)
    ax.set_xlabel(r"$x$", fontsize=9, color=INK, labelpad=0)
    ax.set_ylabel(r"$y$", fontsize=9, color=INK, labelpad=0)
    ax.set_zlabel(r"$z$", fontsize=9, color=INK, labelpad=0)
    ax.view_init(elev=38, azim=32)

    path = SPEC.save(fig, OUT_DIR / "convex-hull")
    print(f"Saved: {path}")

    if os.environ.get("PREVIEW"):
        preview = OUT_DIR / "convex-hull-preview.png"
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.05)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
