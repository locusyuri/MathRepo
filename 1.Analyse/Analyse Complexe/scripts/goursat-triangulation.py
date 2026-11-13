"""Goursat's theorem — triangulation proof technique (two panels).

Left:  Nested midpoint-bisection triangles T₀ ⊃ T₁ ⊃ T₂ ⊃ T₃ → z*
Right: Triangulated simply connected region D with boundary C;
       interior edges cancel (opposite-direction arrows).

Run with: uv run python src/math_paper/goursat_triangulation.py
"""

from __future__ import annotations

from pathlib import Path
import sys

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = Presets.SVG_TEXTBOOK
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#1f4e9b"
RED = "#c0392b"
GRY = "#888888"
LGRY = "#cccccc"


# =========================================================================== #
# Left panel — nested midpoint bisection
# =========================================================================== #
def midpoint(p, q):
    return (np.array(p) + np.array(q)) / 2.0


def subdivide(v0, v1, v2):
    """Return the four sub-triangles from midpoint bisection."""
    m01 = midpoint(v0, v1)
    m12 = midpoint(v1, v2)
    m20 = midpoint(v2, v0)
    return (
        (v0, m01, m20),   # corner near v0
        (m01, v1, m12),   # corner near v1
        (m20, m12, v2),   # corner near v2
        (m01, m12, m20),  # centre (inverted)
    )


def draw_left_panel(ax):
    ax.set_aspect("equal")
    ax.set_axis_off()

    # Original triangle vertices
    v0 = np.array([0.5, 0.3])
    v1 = np.array([5.5, 0.3])
    v2 = np.array([2.2, 5.2])

    # Draw original triangle
    tri = plt.Polygon([v0, v1, v2], fill=False, edgecolor="#333333", lw=1.8)
    ax.add_patch(tri)

    # Perform successive bisections — track the sub-triangle containing z*
    # We always pick the 4th (centre) sub-triangle for nesting
    verts = (v0, v1, v2)
    nest_alphas = [0.18, 0.25, 0.33, 0.42]
    nest_colors = [BLU, BLU, BLU, BLU]
    labels = ["$T_0$", "$T_1$", "$T_2$", "$T_3$"]

    all_sub_edges = []

    for level in range(4):
        subs = subdivide(*verts)
        # Draw all four sub-triangle edges (thin gray)
        for sub in subs:
            for i in range(3):
                edge = [sub[i], sub[(i + 1) % 3]]
                all_sub_edges.append(edge)

        # Shade the centre (4th) sub-triangle
        centre_tri = plt.Polygon(list(subs[3]), facecolor=nest_colors[level],
                                 alpha=nest_alphas[level],
                                 edgecolor=BLU, lw=0.8, ls="--")
        ax.add_patch(centre_tri)

        # Label the nested triangle
        cx = np.mean(subs[3], axis=0)
        offset = [(0.35, -0.45), (-0.55, -0.35), (0.3, 0.35), (-0.4, 0.2)]
        ax.text(cx[0] + offset[level][0], cx[1] + offset[level][1],
                labels[level], fontsize=10, color=BLU, ha="center",
                fontweight="bold")

        # Next level: subdivide the centre triangle
        verts = subs[3]

    # Draw all subdivision edges (thin gray)
    for edge in all_sub_edges:
        ax.plot([edge[0][0], edge[1][0]], [edge[0][1], edge[1][1]],
                color=LGRY, lw=0.6, zorder=1)

    # Limit point z*
    z_star = np.mean(verts, axis=0)
    ax.plot(*z_star, "o", color=RED, ms=6, zorder=10)
    ax.annotate("$z^*$", xy=z_star, xytext=(0.25, 0.35),
                textcoords="offset points", fontsize=12, color=RED,
                fontweight="bold")

    # Dashed neighbourhood circle around z*
    circle = plt.Circle(z_star, 0.55, fill=False, color=GRY,
                         lw=1.2, ls="--", zorder=8)
    ax.add_patch(circle)
    ax.text(z_star[0] + 0.6, z_star[1] + 0.35,
            "$|z - z^*| < r$", fontsize=9, color=GRY, style="italic")

    ax.set_xlim(-0.5, 6.5)
    ax.set_ylim(-0.5, 6.0)


# =========================================================================== #
# Right panel — triangulated region D
# =========================================================================== #
def draw_right_panel(ax):
    ax.set_aspect("equal")
    ax.set_axis_off()

    # Boundary curve C (smooth, irregular, simply connected)
    n_pts = 200
    theta = np.linspace(0, 2 * np.pi, n_pts, endpoint=False)
    # Perturbed circle for irregular shape
    r_bnd = 2.5 + 0.5 * np.sin(3 * theta) + 0.3 * np.cos(5 * theta)
    bx = r_bnd * np.cos(theta)
    by = r_bnd * np.sin(theta)

    # Draw boundary
    ax.plot(np.append(bx, bx[0]), np.append(by, by[0]),
            color=BLU, lw=2.2, zorder=5)

    # CCW arrow on boundary (top of curve)
    idx = np.argmax(by)
    ax.annotate("", xy=(bx[(idx + 3) % n_pts], by[(idx + 3) % n_pts]),
                xytext=(bx[(idx - 3) % n_pts], by[(idx - 3) % n_pts]),
                xycoords="data", textcoords="data",
                arrowprops=dict(arrowstyle="-|>", color=BLU, lw=2.2,
                                mutation_scale=20))
    ax.text(bx[idx] + 0.3, by[idx] + 0.3, "$C$", fontsize=13, color=BLU,
            fontweight="bold")

    # Label D
    ax.text(0, 0, "$D$", fontsize=16, color="#555555", ha="center",
            va="center", fontweight="bold")

    # Light fill
    ax.fill(np.append(bx, bx[0]), np.append(by, by[0]),
            color=BLU, alpha=0.03, zorder=0)

    # ---- Triangular mesh (interior) ---- #
    # Build a regular triangular mesh on a grid, keep edges inside boundary
    from matplotlib.path import Path as MplPath

    n_grid = 12
    gx = np.linspace(-2.6, 2.6, n_grid)
    gy = np.linspace(-2.6, 2.6, n_grid)

    bnd_verts = np.column_stack([bx, by])
    bnd_path = MplPath(bnd_verts)

    # Collect all grid points and test containment
    all_pts = []
    pt_inside = []
    for iy in range(n_grid):
        for ix in range(n_grid):
            all_pts.append((gx[ix], gy[iy]))
            pt_inside.append(bnd_path.contains_point((gx[ix], gy[iy])))
    all_pts = np.array(all_pts)
    pt_inside = np.array(pt_inside)

    def pt_idx(ix, iy):
        return iy * n_grid + ix

    drawn_edges = set()
    tri_centres = []

    for iy in range(n_grid - 1):
        for ix in range(n_grid - 1):
            i00 = pt_idx(ix, iy)
            i10 = pt_idx(ix + 1, iy)
            i01 = pt_idx(ix, iy + 1)
            i11 = pt_idx(ix + 1, iy + 1)

            # Two triangles per cell: lower-left and upper-right
            for tri_indices in [(i00, i10, i11), (i00, i11, i01)]:
                # Only draw if at least 2 of 3 vertices are inside
                n_in = sum(pt_inside[i] for i in tri_indices)
                if n_in >= 2:
                    tc = np.mean([all_pts[i] for i in tri_indices], axis=0)
                    tri_centres.append(tc)
                    for k in range(3):
                        a_i = tri_indices[k]
                        b_i = tri_indices[(k + 1) % 3]
                        edge = (min(a_i, b_i), max(a_i, b_i))
                        if edge not in drawn_edges:
                            drawn_edges.add(edge)
                            ax.plot([all_pts[a_i, 0], all_pts[b_i, 0]],
                                    [all_pts[a_i, 1], all_pts[b_i, 1]],
                                    color=LGRY, lw=0.7, zorder=2)

    # ---- "Cancels" annotation on one interior edge ---- #
    if len(tri_centres) > 0:
        # Pick a triangle centre near the middle of the region
        centre_dists = np.sqrt(np.sum(np.array(tri_centres) ** 2, axis=1))
        pick = np.argsort(centre_dists)[len(centre_dists) // 3]
        tc = tri_centres[pick]

        # Find a nearby grid edge to annotate
        grid_pts_near = []
        for i, p in enumerate(all_pts):
            if pt_inside[i] and np.linalg.norm(p - tc) < 1.0:
                grid_pts_near.append((i, p))

        if len(grid_pts_near) >= 2:
            p1 = grid_pts_near[0][1]
            p2 = grid_pts_near[1][1]

            mid = (p1 + p2) / 2
            direction = p2 - p1
            direction = direction / np.linalg.norm(direction)
            perp = np.array([-direction[1], direction[0]])

            # Two small opposite arrows
            arr_len = 0.18
            offset_up = perp * 0.12
            offset_dn = -perp * 0.12

            ax.annotate("", xy=mid + direction * arr_len + offset_up,
                        xytext=mid - direction * arr_len + offset_up,
                        xycoords="data", textcoords="data",
                        arrowprops=dict(arrowstyle="-|>", color=RED, lw=1.5,
                                        mutation_scale=12))
            ax.annotate("", xy=mid - direction * arr_len + offset_dn,
                        xytext=mid + direction * arr_len + offset_dn,
                        xycoords="data", textcoords="data",
                        arrowprops=dict(arrowstyle="-|>", color=RED, lw=1.5,
                                        mutation_scale=12))
            ax.text(mid[0] + perp[0] * 0.45, mid[1] + perp[1] * 0.45,
                    "cancels", fontsize=8, color=RED, ha="center",
                    style="italic")

    # Label T for a triangle
    if len(tri_centres) > 2:
        tc = tri_centres[2]
        ax.text(tc[0], tc[1], "$T$", fontsize=10, color="#555555",
                ha="center", va="center", fontweight="bold")

    ax.set_xlim(-3.8, 3.8)
    ax.set_ylim(-3.5, 3.5)


# =========================================================================== #
# Build figure
# =========================================================================== #
def build_figure():
    fig = SPEC.figure()

    ax_left = fig.add_subplot(1, 2, 1)
    ax_right = fig.add_subplot(1, 2, 2)

    fig.subplots_adjust(left=0.02, right=0.98, top=0.95, bottom=0.05,
                        wspace=0.08)

    draw_left_panel(ax_left)
    draw_right_panel(ax_right)

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "goursat-triangulation")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
