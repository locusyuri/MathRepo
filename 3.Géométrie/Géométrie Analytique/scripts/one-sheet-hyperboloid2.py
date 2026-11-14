"""Three vertical sections of the one-sheet hyperboloid.

For x^2/b^2 + y^2/b^2 - z^2/c^2 = 1 and a plane y = h:
  |h| < b  -> a hyperbola with real axis x,
  |h| = b  -> two straight lines x = +/- (b/c) z,
  |h| > b  -> a hyperbola with real axis z.

Output: ../img/one-sheet-hyperboloid2.svg
"""

from __future__ import annotations

import sys
from math import sqrt
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import axes, curve, one_sheet, save, setup, show

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "one-sheet-hyperboloid2.svg")
B, C = 0.62, 0.85


def section(ax, h, zmax=1.08):
    k = 1 - h ** 2 / B ** 2
    if abs(k) < 1e-9:
        z = np.linspace(-zmax, zmax, 120)
        for sign in (-1, 1):
            curve(ax, sign * (B / C) * z, np.full_like(z, h), z, lw=1.3)
        return
    u = np.linspace(-1.25, 1.25, 200)
    s = sqrt(abs(k))
    if k > 0:
        x = B * s * np.cosh(u)
        z = C * s * np.sinh(u)
        pairs = [(x, z), (-x, z)]
    else:
        x = B * s * np.sinh(u)
        z = C * s * np.cosh(u)
        pairs = [(x, z), (x, -z)]
    for xx, zz in pairs:
        keep = (np.abs(zz) <= zmax) & (np.abs(xx) <= 1.20)
        curve(ax, xx[keep], np.full(keep.sum(), h), zz[keep], lw=1.3)


def main():
    fig = plt.figure(figsize=(9.6, 3.5))
    for index, h in enumerate((0.35, B, 0.85), start=1):
        ax = fig.add_subplot(1, 3, index, projection="3d")
        setup(ax, lim=1.25, elev=15, azim=-60, zoom=1.35)
        show(ax, *one_sheet(b=B, c=C, zmax=1.08), n_lat=6, n_lon=10)
        section(ax, h)
        axes(ax, length=(0.95, 0.95, 1.20), origin_label=False)

    fig.subplots_adjust(left=0.0, right=1.0, top=1.0, bottom=0.0, wspace=0.0)
    save(fig, OUT)


if __name__ == "__main__":
    main()
