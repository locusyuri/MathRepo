"""Ellipsoids obtained by rotating an ellipse about its axes.

Left: rotation about the major axis gives a prolate spheroid (elongated along
x).  Right: rotation about the minor axis gives an oblate spheroid (flattened
along z).

Output: ../img/ellipse.svg
"""

from __future__ import annotations

import sys
from pathlib import Path

import matplotlib.pyplot as plt

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import axes, ellipsoid, save, setup, show

OUT = Path(__file__).resolve().parent.parent / "img" / "ellipse.svg"


def panel(fig, index):
    ax = fig.add_subplot(1, 2, index, projection="3d")
    setup(ax, lim=1.55, elev=18, azim=-60, zoom=1.45)
    return ax


def main():
    fig = plt.figure(figsize=(7.8, 3.6))

    ax1 = panel(fig, 1)
    show(ax1, *ellipsoid(1.40, 0.62, 0.62), n_lat=7, n_lon=12)
    axes(ax1, length=(1.60, 1.00, 1.00))

    ax2 = panel(fig, 2)
    show(ax2, *ellipsoid(1.20, 1.20, 0.55), n_lat=7, n_lon=14)
    axes(ax2, length=(1.45, 1.45, 0.90))

    fig.subplots_adjust(left=0.0, right=1.0, top=1.0, bottom=0.0, wspace=0.0)
    save(fig, OUT)


if __name__ == "__main__":
    main()
