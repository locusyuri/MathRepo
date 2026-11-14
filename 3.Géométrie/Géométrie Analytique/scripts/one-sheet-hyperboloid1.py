"""One-sheet hyperboloid, cut by horizontal planes.

For x^2/a^2 + y^2/b^2 - z^2/c^2 = 1 the section z = h is always an ellipse;
the smallest one is the throat ellipse at z = 0.

Output: ../img/one-sheet-hyperboloid1.svg
"""

from __future__ import annotations

import sys
from math import sqrt
from pathlib import Path

import matplotlib.pyplot as plt

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import axes, ellipse3d, one_sheet, save, setup, show

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "one-sheet-hyperboloid1.svg")
B, C = 0.52, 0.85


def main():
    fig = plt.figure(figsize=(4.4, 5.0))
    ax = fig.add_subplot(111, projection="3d")
    setup(ax, lim=1.30, elev=15, azim=-60, zoom=1.35, box=(1, 1, 1.15))
    show(ax, *one_sheet(b=B, c=C, zmax=1.10), n_lat=7, n_lon=12)

    for h in (-0.85, 0.0, 0.85):
        r = B * sqrt(1 + h ** 2 / C ** 2)
        ellipse3d(ax, r, r, h, lw=1.2)

    axes(ax, length=(0.95, 0.95, 1.25))
    save(fig, OUT)


if __name__ == "__main__":
    main()
