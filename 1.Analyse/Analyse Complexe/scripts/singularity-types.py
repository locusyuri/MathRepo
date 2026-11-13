"""Three types of isolated singularities of a holomorphic function.

|f(z)| surfaces over a disk centred at z₀ for the model behaviours
    Removable        bounded, single finite limit
    Pole             monotone blow-up like 1/|z-z₀|
    Essential        oscillates with no limit (Casorati–Weierstrass)

Run with: uv run python src/math_paper/singularity_types.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH, figsize=(14.0, 5.2), transparent=False)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#4a90d9"
DARK = "#222222"
GRY = "#c8c8c8"

Z_LIM = (0.0, 5.0)
RES_R, RES_T = 64, 72

# Disk grid shared by all three panels
_r = np.linspace(0.0, 1.0, RES_R)
_t = np.linspace(0.0, 2 * np.pi, RES_T)
_R, _T = np.meshgrid(_r, _t)
X = _R * np.cos(_T)
Y = _R * np.sin(_T)


def removable(rho):
    # Smooth dome: bounded, tends to a single finite value at the centre.
    return 3.1 + 1.35 * np.exp(-(rho / 0.62) ** 2)


def pole(rho):
    # Hyperbolic blow-up, like |1/z^m|.
    return 0.75 + 3.6 / (1.0 + rho / 0.14)


def essential(rho, theta):
    # Infinitely many oscillations as rho -> 0: no limit exists.
    safe = np.maximum(rho, 0.035)
    return 2.5 + 1.85 * np.sin(2.35 / safe + 4.0 * theta) * np.exp(-1.1 * rho)


def style_axis(ax, title):
    ax.set_xlabel("Re z", fontsize=9, labelpad=4)
    ax.set_ylabel("Im z", fontsize=9, labelpad=4)
    ax.set_zlabel("|f(z)|", fontsize=10, labelpad=2)
    ax.set_title(title, fontsize=13, fontweight="bold", pad=8)
    ax.set_zlim(*Z_LIM)
    ax.view_init(elev=26, azim=-62)
    ax.tick_params(labelsize=7, colors="#555555")

    for spine in (ax.xaxis, ax.yaxis, ax.zaxis):
        spine.pane.set_alpha(0.0)
        spine._axinfo["grid"]["color"] = GRY
        spine._axinfo["grid"]["linewidth"] = 0.4


def plot_surface(ax, Z):
    ax.plot_surface(X, Y, Z, color=BLU, alpha=0.78, shade=True,
                    edgecolor="none", antialiased=True, rstride=1, cstride=1)


def build_figure():
    fig = SPEC.figure()
    axes = [fig.add_subplot(1, 3, i + 1, projection="3d") for i in range(3)]
    fig.subplots_adjust(left=0.01, right=0.99, top=0.90, bottom=0.02,
                        wspace=-0.14)

    zs = [removable(_R), pole(_R), essential(_R, _T)]
    titles = ["Removable", "Pole of order m", "Essential"]
    # Centre height: the pole diverges, so its marker sits at the clip plane.
    z0_heights = [removable(np.array([0.0]))[0],
                  Z_LIM[1],
                  essential(np.array([0.0]), np.array([0.0]))[0]]

    for ax, Z, title, h0 in zip(axes, zs, titles, z0_heights):
        plot_surface(ax, Z)
        ax.plot([0], [0], [h0], "o", color=DARK, ms=6, zorder=10)
        ax.text2D(0.5, -0.06, "$z_0$", transform=ax.transAxes,
                  fontsize=12, color=DARK, fontweight="bold",
                  ha="center")
        style_axis(ax, title)

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "singularity-types")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
