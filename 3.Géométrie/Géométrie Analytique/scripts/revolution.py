"""A surface of revolution about the y-axis.

The generatrix Gamma lies in the plane x = 0; rotating it about y sweeps out
the surface.  Each point M_1 of Gamma describes a horizontal circle (a
parallel), drawn here as a solid front arc and a dashed back arc.

Output: ../img/revolution.svg
"""

from __future__ import annotations

import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import GHOST, INK, axes, curve, save, setup, solid

OUT = Path(__file__).resolve().parent.parent / "img" / "revolution.svg"


def radius(y):
    return 0.42 + 0.22 * np.asarray(y) ** 2


def main():
    fig = plt.figure(figsize=(6.0, 4.2))
    ax = fig.add_subplot(111, projection="3d")
    setup(ax, lim=1.35, elev=16, azim=-60, zoom=1.35)

    y = np.linspace(-1.20, 1.20, 60)
    theta = np.linspace(0, 2 * np.pi, 90)
    Y, T = np.meshgrid(y, theta, indexing="ij")
    r = radius(Y)
    solid(ax, r * np.cos(T), Y, r * np.sin(T), color="#eaf1fa")

    # Parallels: the front half solid, the back half dashed and faint.
    for yy in (-1.00, -0.45, 0.45, 1.00):
        rr = radius(yy)
        for lo, hi, style, colour in ((0, np.pi, "-", GHOST),
                                      (np.pi, 2 * np.pi, "--", GHOST)):
            t = np.linspace(lo, hi, 90)
            curve(ax, rr * np.cos(t), np.full_like(t, yy), rr * np.sin(t),
                  color=colour, lw=0.8, ls=style, zorder=3)

    # Silhouette meridians at theta = 0, pi; the generatrix at theta = pi/2.
    for sign in (-1, 1):
        curve(ax, sign * radius(y), y, np.zeros_like(y), lw=1.5)
    curve(ax, np.zeros_like(y), y, radius(y), lw=1.3)

    # A marked point M_1 on the surface.
    yy, tt = 0.55, np.pi / 3
    rr = radius(yy)
    ax.plot([rr * np.cos(tt)], [yy], [rr * np.sin(tt)], "o", color=INK, ms=4,
            zorder=8)
    ax.text(rr * np.cos(tt), yy + 0.02, rr * np.sin(tt) + 0.12, r"$M_1$",
            fontsize=10, color=INK)
    ax.text(0.0, -0.35, radius(-0.35) + 0.14, r"$\Gamma$", fontsize=11,
            color=INK)

    axes(ax, length=(1.10, 1.30, 1.05))
    save(fig, OUT)


if __name__ == "__main__":
    main()
