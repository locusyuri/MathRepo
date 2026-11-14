"""The paraboloid of revolution obtained by rotating a parabola.

Rotating Gamma: y^2 = 2 p z (in the plane x = 0) about the z-axis gives the
elliptic (here circular) paraboloid x^2 + y^2 = 2 p z.

Output: ../img/parabola.svg
"""

from __future__ import annotations

import sys
from pathlib import Path

import matplotlib.pyplot as plt

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import axes, ellipse3d, paraboloid, save, setup, show

OUT = Path(__file__).resolve().parent.parent / "img" / "parabola.svg"


def main():
    fig = plt.figure(figsize=(4.6, 4.4))
    ax = fig.add_subplot(111, projection="3d")
    setup(ax, lim=1.35, elev=17, azim=-60, zoom=1.35)

    show(ax, *paraboloid(a=1.05, b=1.05, zmax=1.15), n_lat=6, n_lon=14)
    ellipse3d(ax, 1.05, 1.05, 1.15, lw=1.2)
    axes(ax, length=(1.15, 1.15, 1.42))

    save(fig, OUT)


if __name__ == "__main__":
    main()
