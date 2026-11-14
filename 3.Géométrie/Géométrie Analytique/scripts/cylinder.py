"""The three quadratic cylinders.

Left: elliptic cylinder x^2/a^2 + y^2/b^2 = 1.  Middle: hyperbolic cylinder
x^2/a^2 - y^2/b^2 = 1 (two separate sheets).  Right: parabolic cylinder
y^2 = 2 p x.  In each case the generatrices are parallel to the z-axis.

Output: ../img/cylinder.svg
"""

from __future__ import annotations

import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import axes, save, setup, show

OUT = Path(__file__).resolve().parent.parent / "img" / "cylinder.svg"


def sheet(kind, zmax=1.10, nu=36, nv=72):
    z = np.linspace(-zmax, zmax, nu)
    if kind == "elliptic":
        t = np.linspace(0, 2 * np.pi, nv)
        X, Y = 0.72 * np.cos(t), 0.52 * np.sin(t)
    elif kind == "parabolic":
        t = np.linspace(-1.25, 1.25, nv)
        X, Y = 0.75 * t ** 2 - 0.35, 0.85 * t
    else:
        t = np.linspace(-1.05, 1.05, nv)
        X, Y = 0.50 * np.cosh(t), 0.55 * np.sinh(t)
    Z, T = np.meshgrid(z, np.arange(nv), indexing="ij")
    return np.broadcast_to(X, Z.shape), np.broadcast_to(Y, Z.shape), Z


def main():
    fig = plt.figure(figsize=(9.6, 3.6))
    specs = [(1, "elliptic", 1), (2, "hyperbolic", 2), (3, "parabolic", 1)]
    for index, kind, count in specs:
        ax = fig.add_subplot(1, 3, index, projection="3d")
        setup(ax, lim=1.25, elev=16, azim=-60, zoom=1.35)
        if kind == "hyperbolic":
            for sign in (-1, 1):
                X, Y, Z = sheet(kind)
                show(ax, sign * X, Y, Z, n_lat=6, n_lon=8)
        else:
            show(ax, *sheet(kind), n_lat=6, n_lon=12)
        axes(ax, length=(1.05, 1.00, 1.30), origin_label=False)

    fig.subplots_adjust(left=0.0, right=1.0, top=1.0, bottom=0.0, wspace=0.0)
    save(fig, OUT)


if __name__ == "__main__":
    main()
