"""Elliptic paraboloid with its parallel sections.

For x^2/a^2 + y^2/b^2 = 2 z, the planes z = h give ellipses and the planes
y = h give parabolas.

Output: ../img/elliptic-paraboloid.svg
"""

from __future__ import annotations

import sys
from math import sqrt
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import axes, curve, ellipse3d, paraboloid, save, setup, show

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "elliptic-paraboloid.svg")
A, B = 1.05, 0.85


def main():
    fig = plt.figure(figsize=(4.8, 4.6))
    ax = fig.add_subplot(111, projection="3d")
    setup(ax, lim=1.30, elev=18, azim=-60, zoom=1.35)
    show(ax, *paraboloid(a=A, b=B, zmax=1.10), n_lat=6, n_lon=14)

    for h in (0.45, 0.85):
        f = sqrt(h / 1.10)
        ellipse3d(ax, A * f, B * f, h, lw=1.1)

    # Vertical section y = 0.
    x = np.linspace(-1.05, 1.05, 200)
    curve(ax, x, np.zeros_like(x), 1.10 * (x / A) ** 2, lw=1.2)

    axes(ax, length=(1.20, 1.05, 1.35))
    save(fig, OUT)


if __name__ == "__main__":
    main()
