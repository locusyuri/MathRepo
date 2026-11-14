"""Two-sheet hyperboloid and its horizontal sections.

For x^2/a^2 + y^2/b^2 - z^2/c^2 = -1 the surface has two cups, meeting the
plane z = +/- c at single points; higher sections are ellipses.

Output: ../img/two-sheet-hyperboloid.svg
"""

from __future__ import annotations

import sys
from math import sqrt
from pathlib import Path

import matplotlib.pyplot as plt

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import axes, ellipse3d, save, setup, show, two_sheet

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "two-sheet-hyperboloid.svg")
B, C = 0.55, 0.75


def main():
    fig = plt.figure(figsize=(4.4, 5.0))
    ax = fig.add_subplot(111, projection="3d")
    setup(ax, lim=1.30, elev=15, azim=-60, zoom=1.35, box=(1, 1, 1.15))
    for sheet in two_sheet(b=B, c=C, zmax=1.40):
        show(ax, *sheet, n_lat=6, n_lon=12)

    for h in (-1.20, 1.20):
        r = B * sqrt(h ** 2 / C ** 2 - 1)
        ellipse3d(ax, r, r, h, lw=1.2)

    axes(ax, length=(0.95, 0.95, 1.50))
    save(fig, OUT)


if __name__ == "__main__":
    main()
