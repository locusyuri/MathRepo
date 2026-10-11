"""Redraw the cone figure and the project-method example figure (line-art style).

Outputs (transparent SVG into ../img/, white JPG previews into ../../tmp/):
  - cone.svg                    cone z^2 = (h^2/R^2)(x^2+y^2) capped by z = h
  - project-method-example.svg  solid 0 <= z <= xy over the triangle 0 <= y <= 1-x
"""

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.mplot3d import proj3d

plt.rcParams["font.family"] = "serif"
plt.rcParams["mathtext.fontset"] = "stix"

ROOT = Path(__file__).resolve().parents[3]
LW = 1.3
FS = 13


def save(fig, name):
    fig.savefig(ROOT / "1.Analyse/Analyse Mathématique/img" / f"{name}.svg", transparent=True, bbox_inches="tight", pad_inches=0.05)
    fig.savefig(ROOT / "tmp" / f"{name}-preview.jpg", facecolor="white", bbox_inches="tight", pad_inches=0.05, dpi=150)
    plt.close(fig)
    print(f"saved: {name}.svg")


def axes3d(ax, tips):
    for vec, lab, pos in tips:
        ax.quiver(0, 0, 0, *vec, arrow_length_ratio=0.07, color="black", lw=LW)
        ax.text(*pos, lab, fontsize=FS)
    ax.text(-0.12, -0.12, 0, r"$O$", fontsize=FS)


def screen_x_extreme(ax, pts):
    """Indices of the ellipse points with extreme screen-x (cone silhouette)."""
    p = np.asarray(pts)
    xs, _, _ = proj3d.proj_transform(p[:, 0], p[:, 1], p[:, 2], ax.get_proj())
    return int(np.argmin(xs)), int(np.argmax(xs))


# ---------- 1. Cone ----------
fig = plt.figure(figsize=(5.0, 4.6))
fig.patch.set_alpha(0)
ax = fig.add_subplot(projection="3d")
ax.set_alpha(0)

R, h = 1.0, 1.3
t = np.linspace(0, 2 * np.pi, 200)
ellipse = np.column_stack([R * np.cos(t), R * np.sin(t), np.full_like(t, h)])
ax.plot(*ellipse.T, color="black", lw=LW)
i0, i1 = screen_x_extreme(ax, ellipse)
for i in (i0, i1):
    ax.plot([0, ellipse[i, 0]], [0, ellipse[i, 1]], [0, h], color="black", lw=LW)

axes3d(ax, [
    (np.array([2.1, 0, 0]), r"$x$", (2.15, 0, -0.05)),
    (np.array([0, 2.4, 0]), r"$y$", (0, 2.5, 0)),
    (np.array([0, 0, 1.85]), r"$z$", (0.1, 0, 1.95)),
])
ax.plot([0, 0], [0, 0], [0, h], color="black", lw=0.9, linestyle=(0, (4, 3)))

ax.text(0.38, 0.55, 1.18, r"$z = h$", fontsize=FS)
ax.text(1.15, 1.05, 0.62, r"$z^2 = \dfrac{h^2}{R^2}(x^2 + y^2)$", fontsize=FS)

ax.view_init(elev=18, azim=-55)
ax.set_box_aspect((1, 1, 1))
ax.set_xlim(-0.6, 2.1)
ax.set_ylim(-0.6, 2.4)
ax.set_zlim(0, 1.9)
ax.axis("off")
save(fig, "cone")


# ---------- 2. Project method example ----------
fig = plt.figure(figsize=(5.0, 4.6))
fig.patch.set_alpha(0)
ax = fig.add_subplot(projection="3d")
ax.set_alpha(0)

axes3d(ax, [
    (np.array([1.45, 0, 0]), r"$x$", (1.52, 0, -0.03)),
    (np.array([0, 1.45, 0]), r"$y$", (0, 1.55, 0)),
    (np.array([0, 0, 0.38]), r"$z$", (0.05, 0, 0.4)),
])

# surface z = xy over the triangle 0 <= y <= 1 - x (z stretched for clarity)
u = np.linspace(0, 1, 40)
v = np.linspace(0, 1, 40)
uu, vv = np.meshgrid(u, v)
xx, yy = uu, vv * (1 - uu)
ax.plot_surface(xx, yy, xx * yy, color="gray", alpha=0.18, linewidth=0, shade=False)

s = np.linspace(0, 0.5, 60)
ax.plot(s, s, s**2, color="black", lw=LW)  # silhouette along y = x, up to the peak
c = np.linspace(0, 1, 60)
ax.plot(c, 1 - c, c * (1 - c), color="black", lw=LW)  # arch above the chord x + y = 1
ax.plot(c, 1 - c, 0 * c, color="black", lw=LW)  # chord on the floor
ax.plot([0.015] * 60, c, [0.008] * 60, color="black", lw=0.9, linestyle=(0, (4, 3)))  # floor edge on the y-axis

ax.text(0.22, 0.42, 0.2, r"$z = x y$", fontsize=FS)
ax.text(0.1, 0.72, -0.035, r"$x + y = 1$", fontsize=FS)

ax.view_init(elev=18, azim=-55)
ax.set_box_aspect((1, 1, 1))
ax.set_xlim(-0.25, 1.5)
ax.set_ylim(-0.25, 1.5)
ax.set_zlim(0, 0.42)
ax.axis("off")
save(fig, "project-method-example")
