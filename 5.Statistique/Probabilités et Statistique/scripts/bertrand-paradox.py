"""Bertrand's paradox: three chord-selection methods giving different P.

Three-panel SVG (equal width):
  Left   Random endpoints : P = 1/3
  Middle Random radius    : P = 1/2
  Right  Random midpoint  : P = 1/4

Each panel shows the circle with an inscribed equilateral triangle (side
sqrt(3) r) as the "longer than side" criterion and the corresponding
favorable region.

Run with: uv run python src/math_paper/bertrand_paradox.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
from matplotlib.patches import Circle, Polygon
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH_PANEL, figsize=(13.8, 5.6))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1a1a1a"
RED = "#d32f2f"
BLU = "#4a7fb5"
LBLU = "#a9cde6"

R = 1.0
SQ3 = np.sqrt(3.0)


def _tri_vertices(r):
    """Inscribed equilateral triangle, apex at top. Vertices CCW."""
    return np.array([
        [0.0, r],
        [-SQ3 * r / 2, -r / 2],
        [SQ3 * r / 2, -r / 2],
    ])


def _style_panel(ax, title):
    ax.set_xlim(-1.25, 1.25)
    ax.set_ylim(-1.55, 1.3)
    ax.set_aspect("equal")
    ax.axis("off")
    # light-gray grid
    ax.set_xticks(np.arange(-1.0, 1.01, 0.5))
    ax.set_yticks(np.arange(-1.0, 1.01, 0.5))
    ax.grid(True, ls=":", lw=0.7, color="#e0e0e0")
    ax.set_title(title, fontsize=15, pad=8)
    # P label below the circle
    ax.text(0, -1.42, title.split(": ")[1], fontsize=16, color=INK,
            ha="center", fontweight="bold")


def _frame(ax, tri=True):
    """Circle + faint dashed diameter helpers (+ triangle)."""
    th = np.linspace(0, 2 * np.pi, 300)
    ax.plot(R * np.cos(th), R * np.sin(th), color=INK, lw=1.4, zorder=4)
    ax.plot([-R, R], [0, 0], color="#c9c9c9", lw=0.8, ls="--", zorder=1)
    ax.plot([0, 0], [-R, R], color="#c9c9c9", lw=0.8, ls="--", zorder=1)
    ax.plot(0, 0, "o", ms=3, color="#888888", zorder=2)
    if tri:
        v = _tri_vertices(R)
        poly = Polygon(v, closed=True, fill=False, edgecolor=INK,
                       lw=1.0, zorder=5)
        ax.add_patch(poly)


def _arc(ax, a1, a2, color, lw, zorder, n=120):
    th = np.linspace(np.radians(a1), np.radians(a2), n)
    ax.plot(R * np.cos(th), R * np.sin(th), color=color, lw=lw,
            zorder=zorder, solid_capstyle="butt")


def _chord(ax, ang, t, color, zorder):
    """Chord perpendicular to the radius at angle `ang`, whose midpoint
    sits t*r from the centre. Returns the midpoint."""
    phi = np.radians(ang)
    half = np.sqrt(R * R - (t * R) ** 2)
    u = np.array([np.cos(phi), np.sin(phi)])
    p = np.array([-np.sin(phi), np.cos(phi)])
    M = t * R * u
    ax.plot([M[0] - half * p[0], M[0] + half * p[0]],
            [M[1] - half * p[1], M[1] + half * p[1]],
            color=color, lw=2.0, zorder=6)
    return M


def panel_endpoints(ax):
    _style_panel(ax, "Random endpoints: P = 1/3")
    # favorable arcs: two thirds of the circle bounded by triangle vertices
    _frame(ax)
    _arc(ax, 210, 330, LBLU, 6, 3)
    _arc(ax, 330, 450, LBLU, 6, 3)
    _arc(ax, 90, 210, INK, 1.0, 3)
    _frame(ax, tri=True)
    # random endpoints with separation > 120 deg  -> chord longer than side
    for ang in (250, 25):
        ax.plot(R * np.cos(np.radians(ang)), R * np.sin(np.radians(ang)),
                "o", ms=6, color=RED, zorder=7)
    ax.plot([R * np.cos(np.radians(250)), R * np.cos(np.radians(25))],
            [R * np.sin(np.radians(250)), R * np.sin(np.radians(25))],
            color=RED, lw=2.0, zorder=6)


def panel_radius(ax):
    _style_panel(ax, "Random radius + point: P = 1/2")
    _frame(ax)
    # favorable disc: midpoint within r/2 of the centre
    ax.add_patch(Circle((0, 0), R / 2, facecolor=LBLU, alpha=0.55,
                        edgecolor=BLU, lw=1.5, zorder=2))
    ang, t = 30, 0.28
    phi = np.radians(ang)
    ax.plot([0, R * np.cos(phi)], [0, R * np.sin(phi)], color=INK, lw=1.4,
            zorder=5)
    _chord(ax, ang, t, RED, 6)
    ax.plot(t * R * np.cos(phi), t * R * np.sin(phi), "o", ms=5,
            color=RED, zorder=7)


def panel_midpoint(ax):
    _style_panel(ax, "Random midpoint: P = 1/4")
    _frame(ax)
    ax.add_patch(Circle((0, 0), R / 2, facecolor=LBLU, alpha=0.55,
                        edgecolor=BLU, lw=1.5, zorder=2))
    ang, t = 250, 0.32
    phi = np.radians(ang)
    M = _chord(ax, ang, t, RED, 6)
    ax.plot(*M, "o", ms=6, color=RED, zorder=7)


def build_figure():
    fig = SPEC.figure()
    panel_endpoints(fig.add_subplot(1, 3, 1))
    panel_radius(fig.add_subplot(1, 3, 2))
    panel_midpoint(fig.add_subplot(1, 3, 3))
    # add sub-titles (already set inside each panel function)
    fig.subplots_adjust(left=0.01, right=0.99, bottom=0.06, top=0.88,
                        wspace=0.35)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "bertrand-paradox")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
