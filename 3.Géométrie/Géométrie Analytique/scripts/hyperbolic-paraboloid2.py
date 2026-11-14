"""Hyperbolic paraboloid with its vertical sections.

The sections y = h are parabolas z = c(x^2/a^2 - h^2/b^2), all congruent.

Output: ../img/hyperbolic-paraboloid2.svg
"""

from __future__ import annotations

import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import axes, curve, saddle, save, setup, show

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "hyperbolic-paraboloid2.svg")
A, B, C = 1.1, 0.9, 0.7
SPAN = 1.20


def main():
    fig = plt.figure(figsize=(5.2, 4.4))
    ax = fig.add_subplot(111, projection="3d")
    setup(ax, lim=1.35, elev=20, azim=-60, zoom=1.30)
    show(ax, *saddle(a=A, b=B, c=C, span=SPAN), n_lat=7, n_lon=11)

    x = np.linspace(-SPAN, SPAN, 200)
    for h in (-0.95, -0.48, 0.0, 0.48, 0.95):
        y = np.full_like(x, h)
        z = C * (x ** 2 / A ** 2 - h ** 2 / B ** 2)
        curve(ax, x, y, z, lw=1.15)

    axes(ax, length=(1.30, 1.15, 1.05))
    save(fig, OUT)


if __name__ == "__main__":
    main()
