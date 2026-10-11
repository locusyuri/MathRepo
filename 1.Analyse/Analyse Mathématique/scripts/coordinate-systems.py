"""Draw the three coordinate-system figures for the multiple-integrals chapter.

Outputs (transparent SVG into ../img/, white JPG previews into ../../tmp/):
  - polar-coordinates.svg       (x = r cos theta, y = r sin theta)
  - cylindrical-coordinates.svg (x = r cos theta, y = r sin theta, z = z)
  - spherical-coordinates.svg   (x = r sin phi cos theta, y = r sin phi sin theta, z = r cos phi)
"""

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

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


# ---------- 1. Polar coordinates (2D) ----------
fig, ax = plt.subplots(figsize=(4.4, 3.9))
fig.patch.set_alpha(0)
ax.set_alpha(0)

r0, th0 = 3.9, np.deg2rad(36)
M = (r0 * np.cos(th0), r0 * np.sin(th0))

ax.annotate("", xy=(4.9, 0), xytext=(-0.6, 0), arrowprops=dict(arrowstyle="-|>", color="black", lw=LW))
ax.annotate("", xy=(0, 3.9), xytext=(0, -0.5), arrowprops=dict(arrowstyle="-|>", color="black", lw=LW))
ax.plot([0, M[0]], [0, M[1]], color="black", lw=LW)
t = np.linspace(0, th0, 60)
ax.plot(1.15 * np.cos(t), 1.15 * np.sin(t), color="black", lw=1.0)
ax.plot([M[0], M[0]], [0, M[1]], color="black", lw=0.9, linestyle=(0, (4, 3)))
ax.plot([-0.6, M[0]], [M[1], M[1]], color="black", lw=0.9, linestyle=(0, (4, 3)))

ax.text(0.5 * M[0] - 0.12, 0.5 * M[1] + 0.18, r"$r$", fontsize=FS)
ax.text(1.42 * np.cos(th0 / 2), 1.42 * np.sin(th0 / 2), r"$\theta$", fontsize=FS)
ax.text(M[0], -0.3, r"$r\cos\theta$", fontsize=FS, ha="center", va="top")
ax.text(M[0] + 0.12, 0.5 * M[1], r"$r\sin\theta$", fontsize=FS, ha="left")
ax.text(4.95, -0.02, r"$x$", fontsize=FS, ha="left", va="center")
ax.text(0.06, 3.95, r"$y$", fontsize=FS, ha="center", va="bottom")
ax.text(-0.14, -0.05, r"$O$", fontsize=FS, ha="right", va="top")
ax.text(M[0] + 0.12, M[1] + 0.1, r"$M$", fontsize=FS, ha="left")

ax.set_xlim(-0.9, 5.5)
ax.set_ylim(-0.9, 4.3)
ax.axis("off")
save(fig, "polar-coordinates")


# ---------- helpers for 3D figures ----------
def axes3d(ax, xmax, ymax, zmax):
    for vec in (np.array([xmax, 0, 0]), np.array([0, ymax, 0]), np.array([0, 0, zmax])):
        ax.quiver(0, 0, 0, *vec, arrow_length_ratio=0.07, color="black", lw=LW)


# ---------- 2. Cylindrical coordinates (3D) ----------
fig = plt.figure(figsize=(5.0, 4.6))
fig.patch.set_alpha(0)
ax = fig.add_subplot(projection="3d")
ax.set_alpha(0)

axes3d(ax, 4.4, 3.6, 3.6)
P = np.array([1.6, 1.1, 0.0])
M = np.array([1.6, 1.1, 2.4])
th = np.arctan2(1.1, 1.6)

ax.plot([0, P[0]], [0, P[1]], [0, 0], color="black", lw=LW)
ax.plot([P[0], M[0]], [P[1], M[1]], [0, M[2]], color="black", lw=0.9, linestyle=(0, (4, 3)))
t = np.linspace(0, th, 60)
ax.plot(0.9 * np.cos(t), 0.9 * np.sin(t), 0 * t, color="black", lw=1.0)

ax.text(*0.5 * P + np.array([0.1, 0.08, 0.15]), r"$r$", fontsize=FS)
ax.text(1.18 * np.cos(th / 2), 1.18 * np.sin(th / 2) - 0.04, 0, r"$\theta$", fontsize=FS)
ax.text(P[0] - 0.2, P[1] + 0.12, 1.1, r"$z$", fontsize=FS)
ax.text(4.5, 0, 0, r"$x$", fontsize=FS)
ax.text(0, 3.7, 0, r"$y$", fontsize=FS)
ax.text(0, 0, 3.7, r"$z$", fontsize=FS)
ax.text(-0.15, -0.12, 0, r"$O$", fontsize=FS)
ax.text(M[0] + 0.1, M[1] + 0.1, M[2] + 0.12, r"$M$", fontsize=FS)

ax.view_init(elev=20, azim=-55)
ax.set_box_aspect((1, 1, 1))
ax.set_xlim(0, 4.4)
ax.set_ylim(0, 3.6)
ax.set_zlim(0, 3.6)
ax.axis("off")
save(fig, "cylindrical-coordinates")


# ---------- 3. Spherical coordinates (3D) ----------
fig = plt.figure(figsize=(5.0, 4.6))
fig.patch.set_alpha(0)
ax = fig.add_subplot(projection="3d")
ax.set_alpha(0)

axes3d(ax, 4.0, 3.2, 3.8)
M = np.array([1.15, 0.95, 2.55])
r = np.linalg.norm(M)
P = np.array([M[0], M[1], 0.0])
phi = np.arccos(M[2] / r)
th = np.arctan2(M[1], M[0])

ax.plot([0, M[0]], [0, M[1]], [0, M[2]], color="black", lw=LW)
ax.plot([M[0], P[0]], [M[1], P[1]], [M[2], 0], color="black", lw=0.9, linestyle=(0, (4, 3)))
t = np.linspace(0, th, 60)
ax.plot(0.85 * np.cos(t), 0.85 * np.sin(t), 0 * t, color="black", lw=1.0)
u = np.linspace(0, phi, 60)
ax.plot(1.25 * np.sin(u) * np.cos(th), 1.25 * np.sin(u) * np.sin(th), 1.25 * np.cos(u), color="black", lw=1.0)

ax.text(*0.58 * M + np.array([0.22, 0.05, -0.28]), r"$r$", fontsize=FS)
um = phi / 2
ax.text(1.5 * np.sin(um) * np.cos(th) - 0.32, 1.5 * np.sin(um) * np.sin(th) + 0.1, 1.5 * np.cos(um), r"$\phi$", fontsize=FS)
ax.text(1.1 * np.cos(th / 2), 1.1 * np.sin(th / 2), 0, r"$\theta$", fontsize=FS)
ax.text(P[0] + 0.05, P[1] + 0.2, 0.08, r"$P$", fontsize=FS)
ax.text(4.1, 0, 0, r"$x$", fontsize=FS)
ax.text(0, 3.3, 0, r"$y$", fontsize=FS)
ax.text(0, 0, 3.9, r"$z$", fontsize=FS)
ax.text(-0.15, -0.1, 0, r"$O$", fontsize=FS)
ax.text(M[0] + 0.1, M[1] + 0.1, M[2] + 0.12, r"$M$", fontsize=FS)

ax.view_init(elev=18, azim=-55)
ax.set_box_aspect((1, 1, 1))
ax.set_xlim(0, 4.0)
ax.set_ylim(0, 3.2)
ax.set_zlim(0, 3.8)
ax.axis("off")
save(fig, "spherical-coordinates")
