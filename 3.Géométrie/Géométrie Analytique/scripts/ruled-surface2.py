"""The two families of straight generatrices of the hyperbolic paraboloid.

Writing z = c(x^2/a^2 - y^2/b^2) in the coordinates
  s = x/a - y/b,  v = x/a + y/b,  z = c s v,
the lines s = const and the lines v = const are the two rulings.

Output: ../img/ruled-surface2.svg
"""

from __future__ import annotations

import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import GHOST, INK, curve, saddle, save, setup, show

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "ruled-surface2.svg")
A, B, C = 1.10, 0.90, 0.70
SPAN = 1.20


def ruling_s(ax, s, colour, lw):
    v = np.linspace(-2.0, 2.0, 120)
    x = A * (s + v) / 2
    y = B * (v - s) / 2
    z = C * s * v
    keep = (np.abs(x) <= SPAN) & (np.abs(y) <= SPAN)
    curve(ax, x[keep], y[keep], z[keep], color=colour, lw=lw)


def ruling_v(ax, v, colour, lw):
    s = np.linspace(-2.0, 2.0, 120)
    x = A * (s + v) / 2
    y = B * (v - s) / 2
    z = C * s * v
    keep = (np.abs(x) <= SPAN) & (np.abs(y) <= SPAN)
    curve(ax, x[keep], y[keep], z[keep], color=colour, lw=lw)


def panel(fig, index, main_is_s):
    ax = fig.add_subplot(1, 2, index, projection="3d")
    setup(ax, lim=1.35, elev=20, azim=-60, zoom=1.30)
    show(ax, *saddle(a=A, b=B, c=C, span=SPAN), n_lat=6, n_lon=10)
    values = np.linspace(-1.1, 1.1, 11)
    for val in values:
        (ruling_s if not main_is_s else ruling_v)(ax, val, GHOST, 0.45)
    for val in values:
        (ruling_s if main_is_s else ruling_v)(ax, val, INK, 1.0)


def main():
    fig = plt.figure(figsize=(7.8, 3.8))
    panel(fig, 1, True)
    panel(fig, 2, False)
    fig.subplots_adjust(left=0.0, right=1.0, top=1.0, bottom=0.0, wspace=0.0)
    save(fig, OUT)


if __name__ == "__main__":
    main()
