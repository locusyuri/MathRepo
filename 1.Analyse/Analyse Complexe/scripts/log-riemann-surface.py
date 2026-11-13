"""3D Riemann surface of the complex logarithm.

The surface is a helicoid (spiral ramp) winding around a central vertical axis.
Each full turn represents one sheet where arg(z) increases by 2π.
Parameterization:  x = r cos θ,  y = r sin θ,  z = θ.

Run with: uv run python src/math_paper/log_riemann_surface.py
"""

from __future__ import annotations

from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))

from _viz import OutputSpec

OUT_DIR = Path(__file__).resolve().parent.parent / "img"

# --------------------------------------------------------------------------- #
# Parameters
# --------------------------------------------------------------------------- #
R_MIN = 0.15
R_MAX = 2.8
N_THETA = 3.0          # number of turns (sheets)
RES = 200
Z_SCALE = 1.0          # height per radian
ELEV, AZIM = 22, -55

SPEC = OutputSpec(
    figsize=(9.5, 9.0), fmt="svg", pad_inches=0.05,
    transparent=False, facecolor="white",
)


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111, projection="3d")
    ax.set_facecolor("white")

    # ---- helicoid surface -------------------------------------------------- #
    r = np.linspace(R_MIN, R_MAX, RES)
    theta = np.linspace(0.02, N_THETA * 2 * np.pi, RES)
    R, T = np.meshgrid(r, theta)
    X = R * np.cos(T)
    Y = R * np.sin(T)
    Z = T * Z_SCALE

    surf = ax.plot_surface(
        X, Y, Z, cmap="YlGnBu", alpha=0.78,
        edgecolor="none", antialiased=True,
    )

    # Subtle contour lines on the surface for depth
    for level in np.arange(2 * np.pi, N_THETA * 2 * np.pi - 0.5, 2 * np.pi):
        xl = r * np.cos(level)
        yl = r * np.sin(level)
        ax.plot(xl, yl, np.full_like(r, level * Z_SCALE),
                color="white", lw=0.6, alpha=0.35)

    # ---- central axis (branch point) -------------------------------------- #
    z_top = N_THETA * 2 * np.pi * Z_SCALE
    ax.plot([0, 0], [0, 0], [0, z_top],
            color="#c0392b", lw=1.8, ls="--", alpha=0.7, zorder=10)

    # ---- branch-cut edges (dashed radial lines at neg. real axis) --------- #
    for k in range(int(N_THETA)):
        th = (2 * k + 1) * np.pi
        h = th * Z_SCALE
        ax.plot([R_MIN * np.cos(th), R_MAX * np.cos(th)],
                [R_MIN * np.sin(th), R_MAX * np.sin(th)],
                [h, h],
                color="#2980b9", lw=1.2, ls="--", alpha=0.55)

    # ---- "0" label at origin ---------------------------------------------- #
    ax.text(0.22, 0.28, -0.6, "0",
            fontsize=16, fontweight="bold", color="#c0392b")

    # ---- "+2πi" annotation (height gap between sheets) -------------------- #
    th_ann = np.pi
    r_ann = (R_MIN + R_MAX) * 0.48
    x_ann = r_ann * np.cos(th_ann)
    y_ann = r_ann * np.sin(th_ann)
    z_lo = np.pi * Z_SCALE
    z_hi = 3 * np.pi * Z_SCALE

    ax.plot([x_ann, x_ann], [y_ann, y_ann], [z_lo, z_hi],
            color="#e67e22", lw=2.2, zorder=10)
    cap = 0.12
    for zc in (z_lo, z_hi):
        ax.plot([x_ann - cap * np.cos(th_ann), x_ann + cap * np.cos(th_ann)],
                [y_ann - cap * np.sin(th_ann), y_ann + cap * np.sin(th_ann)],
                [zc, zc],
                color="#e67e22", lw=1.8, zorder=10)

    ax.text(x_ann - 0.9, y_ann - 0.3, (z_lo + z_hi) / 2,
            "one full turn\n  $= +2\\pi i$",
            fontsize=11, color="#e67e22", fontweight="bold",
            ha="center", va="center")

    # ---- axes / view ------------------------------------------------------ #
    ax.set_xlabel("Re z", fontsize=11, labelpad=8)
    ax.set_ylabel("Im z", fontsize=11, labelpad=8)
    ax.set_zlim(0, z_top + 1)
    ax.view_init(elev=ELEV, azim=AZIM)

    for spine in (ax.xaxis, ax.yaxis, ax.zaxis):
        spine.pane.set_alpha(0.0)
        spine._axinfo["grid"]["color"] = "#eeeeee"
        spine._axinfo["grid"]["linewidth"] = 0.4

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "log-riemann-surface")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
