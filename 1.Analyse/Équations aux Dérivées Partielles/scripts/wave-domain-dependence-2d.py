"""Domains of dependence, determinacy and influence for the 2-D wave equation.

Generates img/wave-domain-dependence-2d.svg (three panels, drawn in the
coordinates (x1, x2, t) with a = 1):
  (a) backward characteristic cone with apex (x0, t0) meeting the initial
      plane in the domain of dependence B(x0, a t0);
  (b) domain of determinacy of a disk D of the initial plane;
  (c) domain of influence of a point y of the initial plane.

Run from the repository root:  uv run "1.Analyse/Équations aux Dérivées Partielles/scripts/wave-domain-dependence-2d.py"
"""

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

A = 1.0  # wave speed (a = 1 for the picture)
BLUE = "#3b6fb6"
RED = "#c74440"
OUT = Path(__file__).resolve().parent.parent / "img" / "wave-domain-dependence-2d.svg"


def cone_surface(cx, cy, z_lo, z_hi, radius_fn, n_theta=72, n_z=40):
    # 生成锥面网格：高度 z 处半径为 radius_fn(z)，中心 (cx, cy)
    z = np.linspace(z_lo, z_hi, n_z)
    theta = np.linspace(0, 2 * np.pi, n_theta)
    T, Z = np.meshgrid(theta, z)
    R = radius_fn(Z)
    return cx + R * np.cos(T), cy + R * np.sin(T), Z


def disk_surface(cx, cy, radius, n_r=2, n_theta=72):
    # 生成平面圆盘网格（用于半透明填充）
    r = np.linspace(0, radius, n_r)
    theta = np.linspace(0, 2 * np.pi, n_theta)
    R, T = np.meshgrid(r, theta)
    return cx + R * np.cos(T), cy + R * np.sin(T)


def setup_3d(ax, lim, tmax, elev=16, azim=-58):
    ax.set_xlim(-lim, lim)
    ax.set_ylim(-lim, lim)
    ax.set_zlim(0, tmax)
    ax.set_box_aspect((1, 1, 0.78))
    ax.view_init(elev=elev, azim=azim)
    ax.grid(False)
    for axis in (ax.xaxis, ax.yaxis, ax.zaxis):
        axis.set_pane_color((1, 1, 1, 0))
        axis.line.set_color((0, 0, 0, 0.35))
        axis.set_ticks([])
    ax.set_xlabel("$x_1$", labelpad=-10)
    ax.set_ylabel("$x_2$", labelpad=-10)
    ax.set_zlabel("$t$", labelpad=-10)


def initial_plane(ax, lim):
    # 初始平面 t = 0 的半透明灰色底面
    xs = np.linspace(-lim, lim, 2)
    X, Y = np.meshgrid(xs, xs)
    ax.plot_surface(X, Y, np.zeros_like(X), color="0.72", alpha=0.18, linewidth=0)


def main():
    fig = plt.figure(figsize=(12.8, 4.6))

    # ------------------------------------------------------------------ (a)
    ax = fig.add_subplot(1, 3, 1, projection="3d")
    t0 = 1.2
    setup_3d(ax, 1.8, 1.75)
    initial_plane(ax, 1.55)
    X, Y, Z = cone_surface(0, 0, 0, t0, lambda z: (t0 - z) * A)
    ax.plot_surface(X, Y, Z, color=BLUE, alpha=0.28, linewidth=0)
    ax.plot_wireframe(X, Y, Z, color=BLUE, alpha=0.55, lw=0.35, rcount=5, ccount=12)
    Xd, Yd = disk_surface(0, 0, A * t0)
    ax.plot_surface(Xd, Yd, np.zeros_like(Xd), color=RED, alpha=0.30, linewidth=0)
    th = np.linspace(0, 2 * np.pi, 120)
    ax.plot(A * t0 * np.cos(th), A * t0 * np.sin(th), np.zeros_like(th), color=RED, lw=2.4)
    ax.scatter([0], [0], [t0], color=RED, s=26, depthshade=False)
    ax.text2D(0.03, 0.05, r"dependence $B(\mathbf{x}_0,\,a t_0)$", fontsize=9,
              color=RED, transform=ax.transAxes)
    ax.text2D(0.03, 0.90, r"backward characteristic cone" + "\n" + r"apex $(\mathbf{x}_0,\,t_0)$",
              fontsize=9, color=BLUE, transform=ax.transAxes)
    ax.set_title(r"(a) domain of dependence", fontsize=10.5, pad=0)

    # ------------------------------------------------------------------ (b)
    ax = fig.add_subplot(1, 3, 2, projection="3d")
    R = 1.15
    setup_3d(ax, 1.8, 1.75)
    initial_plane(ax, 1.55)
    X, Y, Z = cone_surface(0, 0, 0, R, lambda z: (R - z) * A / A)  # 半径 R - z（a = 1）
    ax.plot_surface(X, Y, Z, color=BLUE, alpha=0.28, linewidth=0)
    ax.plot_wireframe(X, Y, Z, color=BLUE, alpha=0.55, lw=0.35, rcount=5, ccount=12)
    Xd, Yd = disk_surface(0, 0, R)
    ax.plot_surface(Xd, Yd, np.zeros_like(Xd), color=RED, alpha=0.30, linewidth=0)
    ax.plot(R * np.cos(th), R * np.sin(th), np.zeros_like(th), color=RED, lw=2.4)
    ax.text2D(0.55, 0.05, r"data disk $D$", fontsize=9, color=RED, transform=ax.transAxes)
    ax.text2D(0.03, 0.90, "domain of determinacy" + "\n" + r"$\{(\mathbf{x},t):\ B(\mathbf{x},at)\subset D\}$",
              fontsize=9, color="black", transform=ax.transAxes)
    ax.set_title(r"(b) domain of determinacy", fontsize=10.5, pad=0)

    # ------------------------------------------------------------------ (c)
    ax = fig.add_subplot(1, 3, 3, projection="3d")
    tmax = 1.4
    setup_3d(ax, 1.8, 1.75)
    initial_plane(ax, 1.55)
    X, Y, Z = cone_surface(0, 0, 0, tmax, lambda z: z * A)
    ax.plot_surface(X, Y, Z, color=BLUE, alpha=0.28, linewidth=0)
    ax.plot_wireframe(X, Y, Z, color=BLUE, alpha=0.55, lw=0.35, rcount=5, ccount=12)
    ax.scatter([0], [0], [0], color=RED, s=26, depthshade=False)
    ax.text2D(0.44, 0.03, r"$\mathbf{y}$", fontsize=10, color=RED, transform=ax.transAxes)
    ax.text2D(0.03, 0.90, "domain of influence" + "\n" + r"$\{(\mathbf{x},t):\ |\mathbf{x}-\mathbf{y}|\leq a t\}$",
              fontsize=9, color="black", transform=ax.transAxes)
    ax.set_title(r"(c) domain of influence", fontsize=10.5, pad=0)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    print(f"saved {OUT}")


if __name__ == "__main__":
    main()
