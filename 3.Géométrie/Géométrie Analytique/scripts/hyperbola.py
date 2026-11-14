"""Hyperboloids obtained by rotating a hyperbola about its axes.

Left: rotation about the conjugate axis gives a one-sheet hyperboloid (a waist
that never closes).  Right: rotation about the real axis gives a two-sheet
hyperboloid (two disjoint cups).

Output: ../img/hyperbola.svg
"""

from __future__ import annotations

import sys
from pathlib import Path

import matplotlib.pyplot as plt

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import axes, one_sheet, save, setup, show, two_sheet

OUT = Path(__file__).resolve().parent.parent / "img" / "hyperbola.svg"


def panel(fig, index):
    ax = fig.add_subplot(1, 2, index, projection="3d")
    setup(ax, lim=1.45, elev=16, azim=-60, zoom=1.35)
    return ax


def main():
    fig = plt.figure(figsize=(7.6, 3.9))

    ax1 = panel(fig, 1)
    show(ax1, *one_sheet(b=0.52, c=0.85, zmax=1.15), n_lat=7, n_lon=12)
    axes(ax1, length=(1.05, 1.05, 1.35))

    ax2 = panel(fig, 2)
    for sheet in two_sheet(b=0.55, c=0.85, zmax=1.45):
        show(ax2, *sheet, n_lat=5, n_lon=12)
    axes(ax2, length=(1.05, 1.05, 1.42))

    fig.subplots_adjust(left=0.0, right=1.0, top=1.0, bottom=0.0, wspace=0.0)
    save(fig, OUT)


if __name__ == "__main__":
    main()
