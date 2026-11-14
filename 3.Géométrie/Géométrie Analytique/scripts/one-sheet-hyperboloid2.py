"""The three vertical sections of a one-sheet hyperboloid.

For x^2/b^2 + y^2/b^2 - z^2/c^2 = 1 and the cutting plane y = h, the part of
the plane inside the surface is shaded:
  |h| < b  -> a single waist-shaped band bounded by a hyperbola,
  |h| = b  -> two triangles bounded by the lines x = +/- (b/c) z,
  |h| > b  -> two caps bounded by the other hyperbola.

Output: ../img/one-sheet-hyperboloid2.svg
"""

from __future__ import annotations

import sys
from math import sqrt
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.mplot3d.art3d import Poly3DCollection

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import INK, axes, curve, ellipse3d, one_sheet, save, setup, show

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "one-sheet-hyperboloid2.svg")
B, C = 0.62, 0.85
ZMAX = 1.08


def cut_face(ax, h):
    """Shade the part of the plane y = h lying inside the surface."""
    k = 1 - h ** 2 / B ** 2
    zs = np.linspace(-ZMAX, ZMAX, 90)

    def half_width(z):
        value = k + z ** 2 / C ** 2
        return B * sqrt(value) if value > 0 else 0.0

    quads = []
    for z0, z1 in zip(zs[:-1], zs[1:]):
        w0, w1 = half_width(z0), half_width(z1)
        if w0 == 0 and w1 == 0:
            continue
        quads.append([(-w0, h, z0), (w0, h, z0),
                      (w1, h, z1), (-w1, h, z1)])
    ax.add_collection3d(Poly3DCollection(
        quads, facecolor="#9aa5b1", edgecolor="none", alpha=0.55, zorder=4))


def section_outline(ax, h):
    """The conic in which the cutting plane meets the surface."""
    k = 1 - h ** 2 / B ** 2
    if abs(k) < 1e-9:
        z = np.linspace(-ZMAX, ZMAX, 120)
        for sign in (-1, 1):
            curve(ax, sign * (B / C) * z, np.full_like(z, h), z, lw=1.5)
        return
    u = np.linspace(-1.25, 1.25, 220)
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
        keep = (np.abs(zz) <= ZMAX) & (np.abs(xx) <= 1.20)
        curve(ax, xx[keep], np.full(keep.sum(), h), zz[keep], lw=1.5)


def main():
    fig = plt.figure(figsize=(9.6, 3.6))
    for index, h in enumerate((0.35, B, 0.70), start=1):
        ax = fig.add_subplot(1, 3, index, projection="3d")
        setup(ax, lim=1.25, elev=15, azim=-60, zoom=1.35)
        show(ax, *one_sheet(b=B, c=C, zmax=ZMAX), n_lat=4, n_lon=8,
             color="#d9e0e7", lw=0.35)
        cut_face(ax, h)
        section_outline(ax, h)
        for z in (-ZMAX, ZMAX):
            ellipse3d(ax, B * sqrt(1 + z ** 2 / C ** 2),
                      B * sqrt(1 + z ** 2 / C ** 2), z, lw=1.0)
        axes(ax, length=(0.95, 0.95, 1.20), origin_label=False)

    fig.subplots_adjust(left=0.0, right=1.0, top=1.0, bottom=0.0, wspace=0.0)
    save(fig, OUT)


if __name__ == "__main__":
    main()
