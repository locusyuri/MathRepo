"""Redraw the Viviani curve figure (sphere cut by the cylinder x^2 + y^2 = a x).

Output: ../img/viviani.svg (transparent) + ../../tmp/viviani-preview.jpg (white).
"""

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.mplot3d import proj3d
from mpl_toolkits.mplot3d.art3d import Poly3DCollection

plt.rcParams["font.family"] = "serif"
plt.rcParams["mathtext.fontset"] = "stix"

ROOT = Path(__file__).resolve().parents[3]
LW = 1.3
FS = 13

fig = plt.figure(figsize=(5.2, 5.0))
fig.patch.set_alpha(0)
ax = fig.add_subplot(projection="3d")
ax.set_alpha(0)
ax.set_proj_type("ortho")

a = 1.0
elev, azim = np.deg2rad(16), np.deg2rad(-55)
view = np.array([np.cos(elev) * np.cos(azim), np.cos(elev) * np.sin(azim), np.sin(elev)])  # toward viewer


def screen_x(pts):
    p = np.asarray(pts)
    xs, _, _ = proj3d.proj_transform(p[:, 0], p[:, 1], p[:, 2], ax.get_proj())
    return xs


def circle3d(center, radius, normal, n=240):
    normal = normal / np.linalg.norm(normal)
    helper = np.array([0, 0, 1.0]) if abs(normal[2]) < 0.9 else np.array([1.0, 0, 0])
    u1 = np.cross(normal, helper)
    u1 /= np.linalg.norm(u1)
    u2 = np.cross(normal, u1)
    t = np.linspace(0, 2 * np.pi, n)
    return center + radius * (np.outer(np.cos(t), u1) + np.outer(np.sin(t), u2))


def split_front_back(pts):
    dots = (pts - pts.mean(axis=0)) @ view
    front = dots < 0
    return front


def draw_split(pts, front_kw, back_kw):
    front = split_front_back(pts)
    for mask, kw in ((front, front_kw), (~front, back_kw)):
        idx = np.where(mask)[0]
        if len(idx) == 0:
            continue
        splits = np.where(np.diff(idx) > 1)[0]
        for seg in np.split(idx, splits + 1):
            if len(seg) > 1:
                ax.plot(*pts[seg].T, **kw)


# sphere silhouette (great circle perpendicular to the view direction, ortho projection)
sil = circle3d(np.zeros(3), a, view)
ax.plot(*sil.T, color="black", lw=LW)

# equator and cylinder base circle: back dashed, front solid
equator = circle3d(np.zeros(3), a, np.array([0, 0, 1.0]))
draw_split(equator, dict(color="black", lw=LW), dict(color="black", lw=0.9, linestyle=(0, (4, 3))))

base = circle3d(np.array([a / 2, 0, 0]), a / 2, np.array([0, 0, 1.0]))
draw_split(base, dict(color="black", lw=LW), dict(color="black", lw=0.9, linestyle=(0, (4, 3))))

# floor projection disk (inside the cylinder) and the cylindrical curtain up to the Viviani curve
s = np.linspace(0, 2 * np.pi, 240)
bx, by = a / 2 + a / 2 * np.cos(s), a / 2 * np.sin(s)
bottom = np.column_stack([bx, by, np.zeros_like(s)])
top = np.column_stack([bx, by, a * np.sin(s / 2)])
ax.add_collection3d(Poly3DCollection([bottom], facecolors=(0.75, 0.45, 0.45, 0.4), edgecolors="none"))
curtain = np.vstack([bottom, top[::-1]])
ax.add_collection3d(Poly3DCollection([curtain], facecolors=(0.55, 0.55, 0.55, 0.35), edgecolors="none"))

# Viviani curve (two branches through the north pole and (a, 0, 0))
t = np.linspace(0, 2 * np.pi, 400)
vx, vy = a / 2 * (1 + np.cos(t)), a / 2 * np.sin(t)
vz = a * np.sin(t / 2)
ax.plot(vx, vy, vz, color="black", lw=1.9)
ax.plot(vx, vy, -vz, color="black", lw=1.9)

# dashed projection lines at the silhouette points of the base circle
pts = np.column_stack([bx, by, np.zeros_like(s)])
for i in (int(np.argmin(screen_x(pts))), int(np.argmax(screen_x(pts)))):
    ax.plot([bx[i], bx[i]], [by[i], by[i]], [0, a * np.sin(s[i] / 2)], color="black", lw=0.9, linestyle=(0, (4, 3)))

# axes
for vec, lab, pos in (
    (np.array([1.55, 0, 0]), r"$x$", (1.65, 0, -0.05)),
    (np.array([0, 1.55, 0]), r"$y$", (0, 1.68, 0)),
    (np.array([0, 0, 1.45]), r"$z$", (0.08, 0, 1.5)),
):
    ax.quiver(0, 0, 0, *vec, arrow_length_ratio=0.07, color="black", lw=LW)
    ax.text(*pos, lab, fontsize=FS)
ax.text(-0.16, -0.14, 0, r"$O$", fontsize=FS)

ax.view_init(elev=16, azim=-55)
ax.set_box_aspect((1, 1, 1))
ax.set_xlim(-1.25, 1.25)
ax.set_ylim(-1.25, 1.25)
ax.set_zlim(-1.25, 1.45)
ax.axis("off")

fig.savefig(ROOT / "1.Analyse/Analyse Mathématique/img/viviani.svg", transparent=True, bbox_inches="tight", pad_inches=0.05)
fig.savefig(ROOT / "tmp/viviani-preview.jpg", facecolor="white", bbox_inches="tight", pad_inches=0.05, dpi=150)
print("saved: viviani.svg")
