"""Volume of a parallelepiped spanned by a, b, c: V = |(a, b, c)|.

Single-panel isometric projection (elevation 30 deg, azimuth 30 deg):
- vectors a = (2, 0, 0) blue, b = (0.6, 1.8, 0) green, c = (0.3, 0.3, 1.8)
  orange, all drawn from the origin O;
- base parallelogram (0,0,0), (2,0,0), (2.6,1.8,0), (0.6,1.8,0) filled
  light blue; the three visible faces of the solid tinted pale grey with
  alpha so the base shows through; the 3 hidden edges dashed;
- dashed height line h from the base centre to the top centre, with a
  right-angle mark on the base;
- volume label V = |(a, b, c)| = |a x b| h at the right;
- white background, SVG output.

Run with: uv run python src/math_paper/mixed_product_volume.py
"""

from __future__ import annotations

import math
from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import matplotlib.patheffects as pe
import numpy as np
from matplotlib.colors import to_rgba
from matplotlib.patches import FancyArrowPatch, Polygon

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_TEXTBOOK, figsize=(8.6, 8.6), transparent=False)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

# -- colors ------------------------------------------------------------
BLUE = "#2563EB"
GREEN = "#16A34A"
ORANGE = "#EA580C"
BASE_FILL = "#DBEAFE"
SOLID_FILL = "#F3F4F6"
DASH = "#6B7280"
INK = "#333333"
HALO = [pe.withStroke(linewidth=3, foreground="white")]

# -- spec data ----------------------------------------------------------
A = np.array([2.0, 0.0, 0.0])
B = np.array([0.6, 1.8, 0.0])
C = np.array([0.3, 0.3, 1.8])
O = np.zeros(3)
BASE = [O, A, A + B, B]

# geometry self-check: V = base area x height
_det = abs(np.linalg.det(np.stack([A, B, C], axis=1)))
_area = np.linalg.norm(np.cross(A, B))
_h = np.dot(C, np.cross(A, B) / _area)
assert abs(_det - _area * _h) < 1e-9

# -- isometric projection: elevation 30 deg, azimuth 30 deg --------------
AZ = math.radians(30.0)
EL = math.radians(30.0)
SA, CA = math.sin(AZ), math.cos(AZ)
SE, CE = math.sin(EL), math.cos(EL)
CAM = np.array([CE * CA, CE * SA, SE])          # towards the viewer


def proj(p):
    x, y, z = p
    return (-x * SA + y * CA, -x * CA * SE - y * SA * SE + z * CE)


# -- faces: visibility via outward normal, edges hidden iff both faces hide
SOLID_C = sum(BASE, np.zeros(3)) / 4.0 + C / 2.0   # solid centre
FACES = [
    ("bottom", [O, A, A + B, B]),
    ("top", [p + C for p in BASE]),
    ("side a", [O, B, B + C, C]),                    # b-c face at origin
    ("side A", [A, A + B, A + B + C, A + C]),        # +a face
    ("side c", [O, A, A + C, C]),                    # a-c face at origin
    ("side b", [B, A + B, A + B + C, B + C]),        # +b face
]


def outward_normal(quad):
    n = np.cross(quad[1] - quad[0], quad[3] - quad[0])
    ctr = sum(quad, np.zeros(3)) / 4.0
    return n if np.dot(n, ctr - SOLID_C) > 0 else -n


VIS = {name: np.dot(outward_normal(quad), CAM) > 0 for name, quad in FACES}

# an edge is drawn solid iff at least one face containing it is visible
edge_vis = {}
for name, quad in FACES:
    for i in range(4):
        key = tuple(sorted((tuple(quad[i]), tuple(quad[(i + 1) % 4]))))
        edge_vis[key] = edge_vis.get(key, False) or VIS[name]

assert sum(1 for v in edge_vis.values() if not v) == 3   # 3 hidden edges


def arrow3(ax, p0, p1, color, lw, zorder=4, ms=16):
    ax.add_patch(
        FancyArrowPatch(proj(p0), proj(p1), arrowstyle="-|>", color=color,
                        lw=lw, mutation_scale=ms, zorder=zorder,
                        shrinkA=0, shrinkB=0)
    )


def panel(ax):
    ax.set_xlim(-1.62, 2.62)
    ax.set_ylim(-1.90, 1.85)
    ax.set_aspect("equal")
    ax.axis("off")

    # -- base parallelogram (light blue), then translucent visible faces ---
    ax.add_patch(Polygon([proj(p) for p in BASE], closed=True,
                         facecolor=BASE_FILL, edgecolor="none", zorder=1))
    for name, quad in FACES:
        if VIS[name]:
            ax.add_patch(Polygon([proj(p) for p in quad], closed=True,
                                 facecolor=to_rgba(SOLID_FILL, 0.55),
                                 edgecolor=INK, lw=1.0, zorder=2))

    # -- hidden edges on top of the faces, dashed --------------------------
    for (p0, p1), visible in edge_vis.items():
        if not visible:
            (x0, y0), (x1, y1) = proj(np.array(p0)), proj(np.array(p1))
            ax.plot([x0, x1], [y0, y1], ls=(0, (4, 3)), color=DASH,
                    lw=1.1, zorder=3)

    # -- height line h with right-angle mark at the base centre ------------
    base_c = sum(BASE, np.zeros(3)) / 4.0
    top_c = base_c + C
    (x0, y0), (x1, y1) = proj(base_c), proj(top_c)
    ax.plot([x0, x1], [y0, y1], ls=(0, (5, 4)), color=DASH, lw=1.2,
            zorder=3.5)
    mark = [base_c, base_c + 0.16 * A / np.linalg.norm(A),
            base_c + 0.16 * A / np.linalg.norm(A) + 0.16 * C / np.linalg.norm(C),
            base_c + 0.16 * C / np.linalg.norm(C)]
    ax.add_patch(Polygon([proj(p) for p in mark], closed=True,
                         facecolor="none", edgecolor=DASH, lw=0.9,
                         zorder=3.5))
    ax.text(x0 + 0.12, (y0 + y1) / 2, "$h$", fontsize=13, color=DASH,
            ha="left", va="center", zorder=6, path_effects=HALO)

    # -- origin label --------------------------------------------------------
    ax.text(-0.10, -0.12, "$O$", fontsize=12, color=INK, ha="right",
            va="top", zorder=6, path_effects=HALO)

    # -- the three vectors ----------------------------------------------------
    arrow3(ax, O, A, BLUE, lw=2.4)
    arrow3(ax, O, B, GREEN, lw=2.4)
    arrow3(ax, O, C, ORANGE, lw=2.4)

    for vec, label, dx, dy, ha in (
        (A, r"$\mathbf{a}$", -0.16, -0.09, "right"),
        (B, r"$\mathbf{b}$", 0.17, -0.09, "left"),
        (C, r"$\mathbf{c}$", 0.13, 0.09, "left"),
    ):
        sp = proj(vec)
        ax.text(sp[0] + dx, sp[1] + dy, label, ha=ha, va="center",
                fontsize=13, color=INK, zorder=6, path_effects=HALO)

    # -- volume label ----------------------------------------------------------
    ax.text(1.38, 0.95, r"$V = |(\mathbf{a},\mathbf{b},\mathbf{c})|$",
            fontsize=14.5, color="black", ha="left", va="center", zorder=6)
    ax.text(1.56, 0.48, r"$= |\mathbf{a}\times\mathbf{b}|\; h$",
            fontsize=13, color=INK, ha="left", va="center", zorder=6)


def build_figure():
    fig = SPEC.figure()
    panel(fig.add_axes([0.02, 0.02, 0.96, 0.96]))
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "mixed-product-volume")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
