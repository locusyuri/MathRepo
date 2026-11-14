"""The two families of straight generatrices of the one-sheet hyperboloid.

For x^2/a^2 + y^2/b^2 - z^2/c^2 = 1 the lines
  P(t) + u(-a sin t, b cos t, +/-c),  P(t) = (a cos t, b sin t, 0),
stay on the surface.  Each panel highlights one of the two families.

Output: ../img/ruled-surface1.svg
"""

from __future__ import annotations

import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import GHOST, INK, curve, one_sheet, save, setup, show

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "ruled-surface1.svg")
A, B, C = 0.60, 0.60, 0.85


def family(ax, t, sign, colour, lw):
    u = np.linspace(-1.25, 1.25, 100)
    x = A * np.cos(t) - u * A * np.sin(t)
    y = B * np.sin(t) + u * B * np.cos(t)
    z = sign * C * u
    curve(ax, x, y, z, color=colour, lw=lw)


def panel(fig, index, main_sign):
    ax = fig.add_subplot(1, 2, index, projection="3d")
    setup(ax, lim=1.30, elev=15, azim=-60, zoom=1.35)
    show(ax, *one_sheet(b=B, c=C, zmax=1.15), n_lat=6, n_lon=10)
    ts = np.linspace(0, 2 * np.pi, 13)[:-1]
    for t in ts:
        family(ax, t, -main_sign, GHOST, 0.45)
    for t in ts:
        family(ax, t, main_sign, INK, 1.0)


def main():
    fig = plt.figure(figsize=(7.6, 3.8))
    panel(fig, 1, +1)
    panel(fig, 2, -1)
    fig.subplots_adjust(left=0.0, right=1.0, top=1.0, bottom=0.0, wspace=0.0)
    save(fig, OUT)


if __name__ == "__main__":
    main()
