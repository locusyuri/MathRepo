"""Magnetic field on the axis of a circular current loop.

Generates a physics-textbook style 3D illustration of a circular loop of
radius R carrying a steady current I in the xy-plane, and the magnetic
field B at a point P on the z-axis at height z. Field lines encircle the
wire as concentric circles; hidden (back-facing) portions are drawn dashed.

Run with:    uv run python src/magnetic_field_loop.py
"""

from __future__ import annotations

from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import FancyArrowPatch
from mpl_toolkits.mplot3d.art3d import Line3DCollection
from mpl_toolkits.mplot3d.proj3d import proj_transform

sys.path.insert(0, str(Path(__file__).resolve().parent))

from _viz import Presets


class Arrow3D(FancyArrowPatch):
    """A FancyArrowPatch that knows how to project itself in 3D.

    Plain FancyArrowPatch is a 2D artist; the 3D axes sorts its artists by
    calling ``do_3d_projection()``, which 2D patches lack. This subclass
    performs the projection and reports its depth so it renders correctly.
    """

    def __init__(self, start, vec, *args, **kwargs):
        super().__init__((0, 0), (0, 0), *args, **kwargs)
        self._xyz = tuple(start)
        self._dxdydz = tuple(vec)

    def do_3d_projection(self, renderer=None):
        x1, y1, z1 = self._xyz
        dx, dy, dz = self._dxdydz
        x2, y2, z2 = x1 + dx, y1 + dy, z1 + dz
        xs, ys, zs = proj_transform(
            (x1, x2), (y1, y2), (z1, z2), self.axes.M
        )
        self.set_positions((xs[0], ys[0]), (xs[1], ys[1]))
        return float(np.min(zs))

# --------------------------------------------------------------------------- #
# Physical / scene parameters
# --------------------------------------------------------------------------- #
R = 1.0          # loop radius
Z = 1.4          # height of point P on the z-axis
B_LEN = 1.1      # drawn length of the B vector (visual only)

# Output configuration: pick a Presets.X here to reuse a whole render profile
# (format, figure size, padding, dpi) across all model scripts.
SPEC = Presets.PNG_PRINT
OUT_DIR = Path(__file__).resolve().parent.parent / "img"


# --------------------------------------------------------------------------- #
# Helpers
# --------------------------------------------------------------------------- #
def loop_point(theta: float, radius: float = R, z: float = 0.0):
    """A point on a circle of given radius at height z."""
    return radius * np.cos(theta), radius * np.sin(theta), z


def field_circles(n_rings: int = 4, points: int = 60):
    """Concentric circular field lines wrapping around the loop wire.

    Each ring lies in the plane normal to the wire (tangent to the loop) at
    a sample point, centred slightly outside the wire. Returns the list of
    polylines plus a front/back mask for each segment.
    """
    rings = []
    masks = []
    # Sample points around the loop where we draw field-line rings.
    thetas = np.linspace(0.0, 2.0 * np.pi, n_rings, endpoint=False)

    for th in thetas:
        # Position on the loop and the local tangent (direction of current).
        cx, cy, cz = loop_point(th)
        tx, ty, tz = -np.sin(th), np.cos(th), 0.0          # tangent
        # Radial (outward in xy-plane) and binormal define the ring plane.
        nx, ny, nz = np.cos(th), np.sin(th), 0.0           # loop radial
        bx, by, bz = np.cross([tx, ty, tz], [nx, ny, nz])  # binormal (= ẑ)

        for offset in (0.18, 0.32):  # two concentric circles per site
            pts = []
            for a in np.linspace(0.0, 2.0 * np.pi, points):
                ca, sa = np.cos(a), np.sin(a)
                x = cx + offset * (ca * nx + sa * bx)
                y = cy + offset * (ca * ny + sa * by)
                z = cz + offset * (ca * nz + sa * bz)
                pts.append((x, y, z))
            pts.append(pts[0])  # close the ring

            # Front/back mask: a segment is "back" (dashed) if its midpoint
            # sits on the far side of the loop centre as seen from +x.
            mids = 0.5 * (np.asarray(pts[:-1]) + np.asarray(pts[1:]))
            seg_mask = mids[:, 0] < cx - 1e-6   # rough occlusion heuristic
            rings.append(np.asarray(pts))
            masks.append(seg_mask)
    return rings, masks


def add_vector(ax, start, vec, color, lw=2.2, mutate=18):
    """Draw a 3D arrow from `start` along `vec`."""
    ax.add_artist(
        Arrow3D(
            start,
            vec,
            mutation_scale=mutate,
            lw=lw,
            arrowstyle="-|>",
            color=color,
        )
    )


# --------------------------------------------------------------------------- #
# Build the figure
# --------------------------------------------------------------------------- #
def build_figure(spec=SPEC):
    fig = spec.figure()
    ax = fig.add_subplot(111, projection="3d")
    ax.set_facecolor("white")

    # View: a 3D perspective looking down slightly from +x/+y.
    ax.view_init(elev=22, azim=-55)

    # ----- Loop (wire): front solid, back dashed -------------------------- #
    theta = np.linspace(0.0, 2.0 * np.pi, 400)
    lx, ly = R * np.cos(theta), R * np.sin(theta)
    # Back half of the loop (far side) -> dashed.
    back = ly < 0
    for is_back, mask in ((False, ~back), (True, back)):
        segs = []
        for i in range(len(theta) - 1):
            if mask[i]:
                segs.append(
                    [(lx[i], ly[i], 0.0), (lx[i + 1], ly[i + 1], 0.0)]
                )
        if segs:
            ax.add_collection3d(
                Line3DCollection(
                    segs,
                    colors="#1f3b73",
                    linewidths=3.2,
                    linestyles="--" if is_back else "-",
                )
            )

    # ----- Current-direction arrows on the loop --------------------------- #
    for th in (np.pi / 4, 5.0 * np.pi / 4):
        tx, ty = -np.sin(th), np.cos(th)
        add_vector(
            ax,
            (R * np.cos(th), R * np.sin(th), 0.0),
            (0.28 * tx, 0.28 * ty, 0.0),
            color="#d1495b",
            lw=2.6,
            mutate=16,
        )
    # "I" label near the first current arrow.
    th0 = np.pi / 4
    ax.text(
        R * np.cos(th0) + 0.12,
        R * np.sin(th0) + 0.12,
        0.05,
        r"$I$",
        color="#d1495b",
        fontsize=16,
        fontweight="bold",
    )

    # ----- Field-line rings around the wire ------------------------------- #
    rings, masks = field_circles()
    for ring, mask in zip(rings, masks):
        segs_front, segs_back = [], []
        for i in range(len(ring) - 1):
            seg = [tuple(ring[i]), tuple(ring[i + 1])]
            (segs_back if mask[i] else segs_front).append(seg)
        if segs_front:
            ax.add_collection3d(
                Line3DCollection(
                    segs_front,
                    colors="#3a7ca5",
                    linewidths=1.5,
                    alpha=0.85,
                )
            )
        if segs_back:
            ax.add_collection3d(
                Line3DCollection(
                    segs_back,
                    colors="#3a7ca5",
                    linewidths=1.2,
                    linestyles="--",
                    alpha=0.5,
                )
            )

    # ----- Coordinate axes (z-axis emphasised) ---------------------------- #
    ax.plot([0, 0], [0, 0], [-0.3, Z + B_LEN + 0.4], color="k", lw=1.1)
    ax.text(0, 0, Z + B_LEN + 0.5, r"$z$", fontsize=14)
    # Radius indicator in the xy-plane.
    ax.plot([0, R], [0, 0], [0, 0], color="#555", lw=1.2, ls=":")

    # ----- Point P and the B vector --------------------------------------- #
    ax.scatter([0], [0], [Z], color="k", s=28, depthshade=False)
    ax.text(0.05, 0.05, Z + 0.04, r"$P$", fontsize=14)
    add_vector(ax, (0, 0, Z), (0, 0, B_LEN), color="#2e8b57", lw=3.0, mutate=22)
    ax.text(0.12, 0.12, Z + B_LEN / 2, r"$\mathbf{B}$", color="#2e8b57",
            fontsize=17, fontweight="bold")

    # ----- z-distance drop line from origin to P -------------------------- #
    ax.plot([0, 0], [0, 0], [0, Z], color="#555", lw=1.2, ls=(0, (4, 3)))
    ax.text(-0.18, -0.18, Z / 2, r"$z$", fontsize=14, color="#333")

    # ----- Labels for R and the centre ------------------------------------ #
    ax.text(R / 2, 0.06, -0.18, r"$R$", fontsize=15, color="#1f3b73")
    ax.scatter([0], [0], [0], color="k", s=16, depthshade=False)

    # ----- Cosmetics ------------------------------------------------------ #
    ax.set_xlim(-1.4, 1.4)
    ax.set_ylim(-1.4, 1.4)
    ax.set_zlim(-0.3, Z + B_LEN + 0.6)
    ax.set_box_aspect((1, 1, 1.0))
    ax.set_axis_off()

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "magnetic_field_loop")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
