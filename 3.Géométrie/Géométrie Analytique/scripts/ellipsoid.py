"""The ellipsoid and its parallel sections (method of parallel sections).

The surface x^2/a^2 + y^2/b^2 + z^2/c^2 = 1 is cut by planes z = +/- h and
y = h; each section is an ellipse.

Output: ../img/ellipsoid.svg
"""

from __future__ import annotations

import sys
from math import sqrt
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import axes, curve, ellipse3d, ellipsoid, save, setup, show

OUT = Path(__file__).resolve().parent.parent / "img" / "ellipsoid.svg"
A, B, C = 1.10, 0.85, 0.62


def main():
    fig = plt.figure(figsize=(5.0, 4.4))
    ax = fig.add_subplot(111, projection="3d")
    setup(ax, lim=1.35, elev=18, azim=-60, zoom=1.35)
    show(ax, *ellipsoid(A, B, C), n_lat=6, n_lon=12)

    # Horizontal sections z = +/- h.
    for h in (-0.32, 0.32):
        f = sqrt(1 - h ** 2 / C ** 2)
        ellipse3d(ax, A * f, B * f, h, lw=1.2)

    # A vertical section y = h.
    h = 0.30
    f = sqrt(1 - h ** 2 / B ** 2)
    t = np.linspace(0, 2 * np.pi, 180)
    curve(ax, A * f * np.cos(t), np.full_like(t, h), C * f * np.sin(t),
          lw=1.2)

    axes(ax, length=(1.30, 1.10, 0.95))
    save(fig, OUT)


if __name__ == "__main__":
    main()
