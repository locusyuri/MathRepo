# -*- coding: utf-8 -*-
"""Generate img/mobius-strip.svg for the Oriented Surface section.

Draws a Möbius strip with the classic non-orientability illustration:
a unit normal vector transported continuously along the center circle
returns pointing in the OPPOSITE direction (-n_0 after one loop).

Mathematical content
--------------------
Standard parameterization (half-twist strip, u in [0, 2pi], v in [-1, 1]):
    r(u, v) = ((1 + (v/2) cos(u/2)) cos u,
               (1 + (v/2) cos(u/2)) sin u,
               (v/2) sin(u/2))
Unit normals are computed numerically as
    n(u, v) = normalize(r_u x r_v),
evaluated along the center circle (u, 0). The key fact verified below:
    n(2pi, 0) = -n(0, 0)
which is exactly why the Mobius strip admits no continuous unit normal
vector field (non-orientable, one-sided).

Output: ../img/mobius-strip.svg
Run from repo root:  uv run "1.Analyse/Analyse Mathematique/scripts/mobius_strip.py"
"""
import os
import numpy as np
import matplotlib.pyplot as plt

# ---------------------------------------------------------------- parameters
BLUE = "#7A9CC6"      # surface
CRIMSON = "#DC143C"   # transported normals n_0, n_1, n_2
PURPLE = "#6A4C93"    # returned vector -n_0
EDGE = "#3D5A80"

def surface(u, v):
    """Mobius strip parameterization. u, v are arrays of the same shape."""
    half = np.cos(u / 2.0)
    rad = 1.0 + (v / 2.0) * half
    return (rad * np.cos(u), rad * np.sin(u), (v / 2.0) * np.sin(u / 2.0))

def unit_normal(u, v, du=1e-6, dv=1e-6):
    """Numerical unit normal normalize(r_u x r_v)."""
    ru = np.array(surface(u + du, v)) - np.array(surface(u - du, v))
    rv = np.array(surface(u, v + dv)) - np.array(surface(u, v - dv))
    cross = np.cross(ru, rv)
    return cross / np.linalg.norm(cross)

# ------------------------------------------------------------- verification
n0 = unit_normal(0.0, 0.0)
n_end = unit_normal(2.0 * np.pi, 0.0)
assert np.allclose(n_end, -n0, atol=1e-8), "n(2pi,0) must equal -n(0,0)"
print("verified: n(2pi, 0) = -n(0, 0)  ->", n_end, "= -", n0)

# ------------------------------------------------------------------- figure
fig = plt.figure(figsize=(7.2, 5.4))
ax = fig.add_subplot(111, projection="3d")

u = np.linspace(0.0, 2.0 * np.pi, 240)
v = np.linspace(-1.0, 1.0, 24)
U, V = np.meshgrid(u, v)
X, Y, Z = surface(U, V)
ax.plot_surface(X, Y, Z, rstride=1, cstride=1, color=BLUE, alpha=0.55,
                linewidth=0, antialiased=True, shade=True)

# draw the two boundary circles of the strip for a crisp silhouette
for vb in (-1.0, 1.0):
    xb, yb, zb = surface(u, np.full_like(u, vb))
    ax.plot(xb, yb, zb, color=EDGE, lw=1.4)

# transported normal along the center circle (v = 0): one full loop u in [0, 2pi]
stops = [0.0, 2.0 * np.pi / 3.0, 4.0 * np.pi / 3.0]
labels = ["$\\mathbf{n}_0$", "$\\mathbf{n}_1$", "$\\mathbf{n}_2$"]
for ui, lab in zip(stops, labels):
    p = np.array(surface(ui, 0.0))
    n = unit_normal(ui, 0.0)
    ax.quiver(*p, *(0.42 * n), color=CRIMSON, lw=2.4, arrow_length_ratio=0.16)
    ax.text(*(p + 0.55 * n), lab, fontsize=12, color=CRIMSON, ha="center")

# after one full loop the normal returns as -n_0 at the same point
p0 = np.array(surface(0.0, 0.0))
ax.quiver(*p0, *(-0.42 * n0), color=PURPLE, lw=2.4,
          linestyle="dashed", arrow_length_ratio=0.16)
ax.text(*(p0 - 0.62 * n0), "$-\\mathbf{n}_0$", fontsize=12, color=PURPLE,
        ha="center")

ax.set_xlim(-1.4, 1.4)
ax.set_ylim(-1.4, 1.4)
ax.set_zlim(-0.8, 0.8)
ax.set_box_aspect((2.8, 2.8, 1.6))
ax.view_init(elev=16, azim=-58)
ax.set_axis_off()

out = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                   os.pardir, "img", "mobius-strip.svg")
fig.savefig(os.path.normpath(out), format="svg", bbox_inches="tight",
            transparent=True)
print("saved:", os.path.normpath(out))
