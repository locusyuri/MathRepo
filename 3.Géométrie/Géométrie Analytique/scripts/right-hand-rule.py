"""Right-hand rule for the cross product a x b = c in 3D.

Single-panel isometric projection (elevation 30 deg, azimuth 45 deg):
- black coordinate axes x, y, z from the origin to 2.5;
- vector a = (1.8, 0.4, 0) in blue, b = (0.4, 1.8, 0) in green,
  a x b = (0, 0, 1.8) in red;
- a grey curl arrow from a to b in the xy-plane;
- a stylised right hand (thumb along +z, curled fingers sweeping from
  a's side to b's side) in the upper-right;
- white background, SVG output.

Run with: uv run python src/math_paper/right_hand_rule.py
"""

from __future__ import annotations

import math
from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import matplotlib.patheffects as pe
import numpy as np
from matplotlib.patches import FancyArrowPatch, FancyBboxPatch

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_TEXTBOOK, figsize=(8.6, 8.6), transparent=False)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

# -- colors ------------------------------------------------------------
AXIS = "#000000"
BLUE = "#2563EB"
GREEN = "#16A34A"
RED = "#DC2626"
GREY = "#6B7280"     # hand outline, curl arrow
LIGHT = "#9CA3AF"    # finger creases
INK = "#333333"
HALO = [pe.withStroke(linewidth=3, foreground="white")]

# -- spec data ----------------------------------------------------------
A = np.array([1.8, 0.4, 0.0])
B = np.array([0.4, 1.8, 0.0])
C = np.array([0.0, 0.0, 1.8])
AXIS_LEN = 2.5

_cross = np.cross(A, B)
assert np.allclose(_cross / np.linalg.norm(_cross) * np.linalg.norm(C), C)

# -- isometric projection: elevation 30 deg, azimuth 45 deg -------------
AZ = math.radians(45.0)
EL = math.radians(30.0)
SA, CA = math.sin(AZ), math.cos(AZ)
SE, CE = math.sin(EL), math.cos(EL)


def proj(p):
    x, y, z = p
    return (-x * SA + y * CA, -x * CA * SE - y * SA * SE + z * CE)


def arrow3(ax, p0, p1, color, lw, zorder=4, ms=16):
    ax.add_patch(
        FancyArrowPatch(proj(p0), proj(p1), arrowstyle="-|>", color=color,
                        lw=lw, mutation_scale=ms, zorder=zorder,
                        shrinkA=0, shrinkB=0)
    )


def hand(ax, ox, oy, s):
    """Stylised right hand: fist of curled fingers, thumb pointing up."""
    # thumb shaft behind the fist, arrowhead beyond the tip
    ax.plot([ox - 0.30 * s] * 2, [oy + 0.30 * s, oy + 0.92 * s],
            color=GREY, lw=6.5, solid_capstyle="round", zorder=4)
    ax.add_patch(FancyArrowPatch((ox - 0.30 * s, oy + 0.90 * s),
                                 (ox - 0.30 * s, oy + 1.16 * s),
                                 arrowstyle="-|>", color=GREY, lw=1.8,
                                 mutation_scale=13, zorder=5,
                                 shrinkA=0, shrinkB=0))
    # fist: white rounded block covering the thumb root
    ax.add_patch(FancyBboxPatch(
        (ox - 0.42 * s, oy - 0.35 * s), 0.84 * s, 0.80 * s,
        boxstyle=f"round,pad=0,rounding_size={0.26 * s}",
        facecolor="white", edgecolor=GREY, lw=1.6, zorder=5))
    # curled fingers: three parallel arcs sweeping left -> right
    th = np.linspace(math.radians(150), math.radians(-20), 60)
    for r in (0.38, 0.27, 0.16):
        ax.plot(ox + (0.12 + r * np.cos(th)) * s,
                oy + (0.02 + r * np.sin(th)) * s,
                color=LIGHT, lw=1.5, zorder=6)
    # curl-direction arrowhead at the outer arc end
    t = math.radians(-20)
    end = np.array([0.12 + 0.38 * math.cos(t), 0.02 + 0.38 * math.sin(t)])
    tang = np.array([math.sin(t), -math.cos(t)])
    ax.add_patch(FancyArrowPatch(ox + end * s, ox + (end + 0.16 * tang) * s,
                                 arrowstyle="-|>", color=LIGHT, lw=1.5,
                                 mutation_scale=12, zorder=6,
                                 shrinkA=0, shrinkB=0))
    ax.text(ox - 0.12 * s, oy + 1.04 * s, "$+z$", ha="left", va="center",
            fontsize=9.5, color=GREY, zorder=6)


def panel(ax):
    ax.set_xlim(-2.05, 2.05)
    ax.set_ylim(-1.35, 2.62)
    ax.set_aspect("equal")
    ax.axis("off")

    # -- coordinate axes ---------------------------------------------------
    for vec, label, dx, dy, ha, va in (
        ((AXIS_LEN, 0, 0), "$x$", -0.10, -0.12, "right", "top"),
        ((0, AXIS_LEN, 0), "$y$", 0.10, -0.12, "left", "top"),
        ((0, 0, AXIS_LEN), "$z$", 0.0, 0.18, "center", "bottom"),
    ):
        arrow3(ax, (0, 0, 0), vec, AXIS, lw=1.3, zorder=3, ms=13)
        sp = proj(vec)
        ax.text(sp[0] + dx, sp[1] + dy, label, ha=ha, va=va,
                fontsize=14, color=AXIS, zorder=5, path_effects=HALO)

    # -- the three vectors ---------------------------------------------------
    arrow3(ax, (0, 0, 0), A, BLUE, lw=2.5)
    arrow3(ax, (0, 0, 0), B, GREEN, lw=2.5)
    arrow3(ax, (0, 0, 0), C, RED, lw=2.5)

    for vec, label, dx, dy, ha in (
        (A, r"$\mathbf{a}$", -0.16, -0.10, "right"),
        (B, r"$\mathbf{b}$", 0.16, -0.12, "left"),
        (C, r"$\mathbf{a}\times\mathbf{b}$", -0.16, 0.02, "right"),
    ):
        sp = proj(vec)
        ax.text(sp[0] + dx, sp[1] + dy, label, ha=ha, va="center",
                fontsize=13, color=INK, zorder=6, path_effects=HALO)

    # -- curl arrow from a to b, in the xy-plane ------------------------------
    th0, th1 = math.atan2(A[1], A[0]), math.atan2(B[1], B[0])
    r = 0.85
    th = np.linspace(th0, th1, 60)
    arc3d = np.stack([r * np.cos(th), r * np.sin(th), 0.06 * np.ones_like(th)],
                     axis=1)
    arc2d = np.array([proj(p) for p in arc3d])
    ax.plot(arc2d[:-2, 0], arc2d[:-2, 1], color=GREY, lw=2.2, zorder=2)
    ax.add_patch(FancyArrowPatch(arc2d[-3], arc2d[-1], arrowstyle="-|>",
                                 color=GREY, lw=2.2, mutation_scale=15,
                                 zorder=2, shrinkA=0, shrinkB=0))

    # -- right-hand icon -------------------------------------------------------
    hand(ax, ox=0.60, oy=1.42, s=0.75)
    ax.text(0.60, 0.98, "right-hand rule", ha="center", va="top",
            fontsize=10, color=GREY, style="italic", zorder=6)


def build_figure():
    fig = SPEC.figure()
    panel(fig.add_axes([0.02, 0.02, 0.96, 0.96]))
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "right-hand-rule")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
