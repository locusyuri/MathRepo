"""Orbit partition of a group action on a set X.

Two-panel diagram:
  Left  -- Set X decomposed into four disjoint orbits O1..O4
  Right -- Each orbit extracted individually (2x2 grid)

Run with: uv run python src/math_paper/orbit_partition.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SANS_RC = {
    "font.family": "sans-serif",
    "font.sans-serif": ["DejaVu Sans", "Helvetica", "Arial", "sans-serif"],
    "mathtext.fontset": "dejavusans",
}
SPEC = replace(Presets.SVG_MATH_PANEL, figsize=(14.0, 5.5),
               transparent=False, rc_overrides=SANS_RC)
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1C1C1C"
BLU = "#2C5F7C"
COR = "#E07B54"
GRN = "#2E7D5B"
AMB = "#E8C547"

DOT_R = 0.07          # dot radius in data coords
LINE_LW = 0.5         # connecting-line width


def _orbit_points(cx, cy, n, r_rot):
    """Return (n,2) array of points on a regular polygon."""
    angles = np.linspace(np.pi / 2, np.pi / 2 + 2 * np.pi, n, endpoint=False)
    xs = cx + r_rot * np.cos(angles)
    ys = cy + r_rot * np.sin(angles)
    return np.column_stack([xs, ys])


def _draw_orbit(ax, cx, cy, n, r_rot, color, label=None, label_offset=(0, -0.35)):
    """Draw n dots connected as a regular polygon, with optional centre label."""
    pts = _orbit_points(cx, cy, n, r_rot)
    # connecting edges (closed polygon for n>=3, single segment for n==2)
    if n >= 3:
        poly = np.vstack([pts, pts[0]])
        ax.plot(poly[:, 0], poly[:, 1], color=color, lw=LINE_LW, zorder=1)
    else:
        ax.plot(pts[:, 0], pts[:, 1], color=color, lw=LINE_LW, zorder=1)
    # dots
    ax.scatter(pts[:, 0], pts[:, 1], s=DOT_R * 200, color=color,
               zorder=2, edgecolors="none")
    if label:
        ax.text(cx + label_offset[0], cy + label_offset[1], label,
                fontsize=11, ha="center", va="center", color=color,
                style="italic")


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)

    # ================================================================ #
    # LEFT PANEL -- X decomposed into orbits                           #
    # ================================================================ #
    # Dashed boundary of X
    rect_x = mpatches.FancyBboxPatch(
        (1.0, 1.0), 5.0, 3.5,
        boxstyle="round,pad=0.15",
        facecolor="white", edgecolor=INK, lw=0.8,
        ls=(0, (4, 2)), alpha=1.0, zorder=0)
    ax.add_patch(rect_x)
    ax.text(0.7, 4.65, r"$X$", fontsize=14, ha="center", va="center",
            color=INK)

    # Four orbits inside X
    _draw_orbit(ax, 2.0, 3.5, 5, 0.6, BLU, r"$O_1$")
    _draw_orbit(ax, 4.5, 3.5, 3, 0.5, COR, r"$O_2$")
    _draw_orbit(ax, 2.0, 1.8, 4, 0.45, GRN, r"$O_3$")
    _draw_orbit(ax, 4.5, 1.8, 2, 0.25, AMB, r"$O_4$", label_offset=(0, -0.30))

    ax.text(3.5, 5.0, "X decomposed into orbits",
            fontsize=12, ha="center", va="center", color=INK)

    # ================================================================ #
    # RIGHT PANEL -- Individual orbits (2x2 grid)                      #
    # ================================================================ #
    CW, CH = 2.5, 1.8    # cell width / height
    GAP = 0.3
    # top-left corners of the four cells
    cells = [
        (8.0,  2.7),   # O1 top-left
        (10.8, 2.7),   # O2 top-right
        (8.0,  0.7),   # O3 bottom-left
        (10.8, 0.7),   # O4 bottom-right
    ]
    orbit_info = [
        (5, 0.6, BLU, r"$O_1$", r"$|O_1|=5$"),
        (3, 0.5, COR, r"$O_2$", r"$|O_2|=3$"),
        (4, 0.45, GRN, r"$O_3$", r"$|O_3|=4$"),
        (2, 0.25, AMB, r"$O_4$", r"$|O_4|=2$"),
    ]

    for (cx0, cy0), (n, r_rot, color, olbl, size_lbl) in zip(cells, orbit_info):
        # cell rectangle
        ax.add_patch(mpatches.FancyBboxPatch(
            (cx0, cy0), CW, CH,
            boxstyle="round,pad=0.1",
            facecolor="white", edgecolor=color, lw=0.5,
            alpha=1.0, zorder=0))
        # orbit centred in cell
        ocx = cx0 + CW / 2
        ocy = cy0 + CH / 2 + 0.1
        _draw_orbit(ax, ocx, ocy, n, r_rot, color)
        # size label bottom-right
        ax.text(cx0 + CW - 0.15, cy0 + 0.20, size_lbl,
                fontsize=10, ha="right", va="center", color=INK)

    ax.text(10.5, 5.0, "Individual orbits (symmetry visible)",
            fontsize=12, ha="center", va="center", color=INK)

    # -- canvas ---------------------------------------------------------- #
    ax.set_xlim(0.0, 14.0)
    ax.set_ylim(0.0, 5.5)
    ax.set_aspect("equal")
    ax.axis("off")

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "orbit-partition")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
