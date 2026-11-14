"""Hyperbolic paraboloid with its horizontal sections.

For z = c(x^2/a^2 - y^2/b^2), the level set z = h is a hyperbola whose real
axis is parallel to x for h > 0 and to y for h < 0; z = 0 is a pair of lines.

Output: ../img/hyperbolic-paraboloid1.svg
"""

from __future__ import annotations

import sys
from math import sqrt
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import INK, axes, curve, saddle, save, setup, show

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "hyperbolic-paraboloid1.svg")
A, B, C = 1.1, 0.9, 0.7
SPAN = 1.20


def main():
    fig = plt.figure(figsize=(5.2, 4.4))
    ax = fig.add_subplot(111, projection="3d")
    setup(ax, lim=1.35, elev=20, azim=-60, zoom=1.30)
    show(ax, *saddle(a=A, b=B, c=C, span=SPAN), n_lat=7, n_lon=11)

    u = np.linspace(-1.15, 1.15, 240)
    for h in (-0.38, 0.38):
        s = sqrt(abs(h) / C)
        z = np.full_like(u, h)
        if h > 0:
            x1, y1 = A * s * np.cosh(u), B * s * np.sinh(u)
            pairs = [(x1, y1), (-x1, y1)]
        else:
            x1, y1 = A * s * np.sinh(u), B * s * np.cosh(u)
            pairs = [(x1, y1), (x1, -y1)]
        for x, y in pairs:
            keep = (np.abs(x) <= SPAN) & (np.abs(y) <= SPAN)
            curve(ax, x[keep], y[keep], z[keep], lw=1.2)

    # The degenerate level z = 0: two straight lines through the origin.
    x = np.linspace(-1.20, 1.20, 80)
    ratio = B / A
    curve(ax, x, ratio * x, np.zeros_like(x), lw=1.0, color=INK)
    curve(ax, x, -ratio * x, np.zeros_like(x), lw=1.0, color=INK)

    axes(ax, length=(1.30, 1.15, 1.05))
    save(fig, OUT)


if __name__ == "__main__":
    main()
