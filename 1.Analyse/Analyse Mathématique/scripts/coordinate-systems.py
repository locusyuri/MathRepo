"""Draw the three coordinate-system figures for the multiple-integrals chapter.

Outputs (transparent SVG into ../img/, white JPG previews into ../../tmp/):
  - polar-coordinates.svg       (x = r cos theta, y = r sin theta)
  - cylindrical-coordinates.svg (cylinder surface drawn explicitly;
                                 x = r cos theta, y = r sin theta, z = z)
  - spherical-coordinates.svg   (sphere surface drawn explicitly;
                                 x = r sin Phi cos theta, y = r sin Phi sin theta,
                                 z = r cos Phi)

Notation follows the reference figure: r, Phi (capital, polar angle), theta.
"""

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

plt.rcParams["font.family"] = "serif"
plt.rcParams["mathtext.fontset"] = "stix"

ROOT = Path(__file__).resolve().parents[3]
LW = 1.5
FS = 15


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


def arc_segments(azim_deg):
    """Split a horizontal circle into the front (solid) and back (dashed) halves
    as seen from the camera at horizontal azimuth ``azim_deg``."""
    a_front = np.linspace(np.deg2rad(azim_deg - 90), np.deg2rad(azim_deg + 90), 80)
    a_back = np.linspace(np.deg2rad(azim_deg + 90), np.deg2rad(azim_deg + 270), 80)
    return a_front, a_back


SURFACE = "#9fb2c8"  # light blue-gray for the drawn surfaces

# ---------- 2. Cylindrical coordinates (3D) ----------
fig = plt.figure(figsize=(5.0, 4.6))
fig.patch.set_alpha(0)
ax = fig.add_subplot(projection="3d")
ax.set_alpha(0)

M = np.array([0.5, 1.7, 2.3])
rc = float(np.hypot(M[0], M[1]))  # cylinder radius through M
H = 2.9                            # cylinder height
th = np.arctan2(M[1], M[0])
P = np.array([M[0], M[1], 0.0])
AZIM = 25

axes3d(ax, 3.3, 2.7, 3.0)

# Lateral surface as a translucent shell.
uu = np.linspace(0, 2 * np.pi, 80)
zz = np.array([0, H])
UU, ZZ = np.meshgrid(uu, zz)
ax.plot_surface(rc * np.cos(UU), rc * np.sin(UU), ZZ,
                color=SURFACE, alpha=0.16, linewidth=0, shade=False)
# Bottom and top disks.
rr = np.linspace(0, rc, 20)
UU2, RR2 = np.meshgrid(uu, rr)
ax.plot_surface(RR2 * np.cos(UU2), RR2 * np.sin(UU2), 0 * RR2,
                color=SURFACE, alpha=0.12, linewidth=0, shade=False)
ax.plot_surface(RR2 * np.cos(UU2), RR2 * np.sin(UU2), H + 0 * RR2,
                color=SURFACE, alpha=0.12, linewidth=0, shade=False)

# Bottom rim: front half solid, back half dashed; top rim solid.
a_front, a_back = arc_segments(AZIM)
ax.plot(rc * np.cos(a_front), rc * np.sin(a_front), 0 * a_front,
        color="black", lw=LW)
ax.plot(rc * np.cos(a_back), rc * np.sin(a_back), 0 * a_back,
        color="black", lw=1.0, linestyle=(0, (4, 3)))
ax.plot(rc * np.cos(uu), rc * np.sin(uu), H + 0 * uu, color="black", lw=1.0)

# Silhouette generators at the horizontal extremes w.r.t. the camera.
for a_ext in (np.deg2rad(AZIM - 90), np.deg2rad(AZIM + 90)):
    ax.plot([rc * np.cos(a_ext)] * 2, [rc * np.sin(a_ext)] * 2, [0, H],
            color="black", lw=1.0)

# Point M on the cylinder, its projection P, the radius r and the angle theta.
ax.plot([0, P[0]], [0, P[1]], [0, 0], color="black", lw=LW)
ax.plot([P[0], M[0]], [P[1], M[1]], [0, M[2]], color="black", lw=1.0,
        linestyle=(0, (4, 3)))
t = np.linspace(0, th, 60)
ax.plot(0.9 * np.cos(t), 0.9 * np.sin(t), 0 * t, color="black", lw=1.2)

ax.text(0.30, 1.30, 0.38, r"$r$", fontsize=FS)
ax.text(0.70, 0.70, 0, r"$\theta$", fontsize=FS)
ax.text(P[0] + 0.12, P[1] - 0.22, 1.3, r"$z$", fontsize=FS)
ax.text(3.45, 0, 0, r"$x$", fontsize=FS)
ax.text(0, 2.85, 0, r"$y$", fontsize=FS)
ax.text(0.08, 0, 3.12, r"$z$", fontsize=FS)
ax.text(0.95, -0.62, 0, r"$O$", fontsize=FS)
ax.text(M[0] + 0.1, M[1] + 0.1, M[2] + 0.12, r"$M$", fontsize=FS)

ax.view_init(elev=20, azim=AZIM)
ax.set_box_aspect((1, 1, 1))
ax.set_xlim(-2.0, 3.4)
ax.set_ylim(-2.1, 3.3)
ax.set_zlim(-1.6, 3.8)
ax.axis("off")
save(fig, "cylindrical-coordinates")


# ---------- 3. Spherical coordinates (3D) ----------
fig = plt.figure(figsize=(5.0, 4.6))
fig.patch.set_alpha(0)
ax = fig.add_subplot(projection="3d")
ax.set_alpha(0)

M = np.array([0.42, 1.43, 2.55])
R = float(np.linalg.norm(M))  # sphere radius through M
P = np.array([M[0], M[1], 0.0])
phi = np.arccos(M[2] / R)
th = np.arctan2(M[1], M[0])
AZIM = 25

axes3d(ax, 3.9, 3.5, 3.7)

# Sphere as a clean translucent shell (no wireframe clutter).
u_sphere = np.linspace(0, 2 * np.pi, 80)
v_sphere = np.linspace(0, np.pi, 40)
UU, VV = np.meshgrid(u_sphere, v_sphere)
ax.plot_surface(R * np.sin(VV) * np.cos(UU), R * np.sin(VV) * np.sin(UU),
                R * np.cos(VV), color=SURFACE, alpha=0.16, linewidth=0,
                shade=False)

# Equator: dashed (as in the reference figure).
ax.plot(R * np.cos(u_sphere), R * np.sin(u_sphere), 0 * u_sphere,
        color="black", lw=1.0, linestyle=(0, (4, 3)))

# Front meridian through M, the radius vector, vertical projection, theta arc.
u_mer = np.linspace(0, np.pi, 80)
ax.plot(R * np.sin(u_mer) * np.cos(th), R * np.sin(u_mer) * np.sin(th),
        R * np.cos(u_mer), color="black", lw=1.2)
ax.plot([0, M[0]], [0, M[1]], [0, M[2]], color="black", lw=LW)
ax.plot([M[0], P[0]], [M[1], P[1]], [M[2], 0], color="black", lw=1.0,
        linestyle=(0, (4, 3)))
t = np.linspace(0, th, 60)
ax.plot(0.85 * np.cos(t), 0.85 * np.sin(t), 0 * t, color="black", lw=1.2)
u = np.linspace(0, phi, 60)
ax.plot(1.6 * np.sin(u) * np.cos(th), 1.6 * np.sin(u) * np.sin(th),
        1.6 * np.cos(u), color="black", lw=1.2)

ax.text(0.55, 1.15, 2.15, r"$r$", fontsize=FS)
um = phi / 2
ax.text(-0.02, 0.55, 1.62, r"$\Phi$", fontsize=FS)
ax.text(0.92, 0.92, 0, r"$\theta$", fontsize=FS)
ax.text(P[0] + 0.16, P[1] + 0.22, 0.05, r"$P$", fontsize=FS)
ax.text(4.05, 0, 0, r"$x$", fontsize=FS)
ax.text(0, 3.65, 0, r"$y$", fontsize=FS)
ax.text(0.08, 0, 3.82, r"$z$", fontsize=FS)
ax.text(-0.35, -0.35, 0, r"$O$", fontsize=FS)
ax.text(M[0] + 0.1, M[1] + 0.1, M[2] + 0.12, r"$M$", fontsize=FS)

ax.view_init(elev=18, azim=AZIM)
ax.set_box_aspect((1, 1, 1))
ax.set_xlim(-3.3, 4.2)
ax.set_ylim(-3.3, 4.2)
ax.set_zlim(-3.3, 4.2)
ax.axis("off")
save(fig, "spherical-coordinates")
