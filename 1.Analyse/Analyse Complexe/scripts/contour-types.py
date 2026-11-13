"""Four types of contours in the complex plane (2×2 grid).

1. Smooth contour (ellipse-like)
2. Piecewise smooth contour (polygon)
3. Circle |z − a| = r
4. Multiply connected domain (annulus with oriented boundaries)

Run with: uv run python src/math_paper/contour_types.py
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
LGRY = "#dddddd"


def setup_axes(ax, lim=3.0, title=""):
    ax.set_aspect("equal")
    ax.axhline(0, color=GRY, lw=0.5, alpha=0.6)
    ax.axvline(0, color=GRY, lw=0.5, alpha=0.6)
    ax.set_xlim(-lim, lim)
    ax.set_ylim(-lim, lim)
    ax.set_xlabel("Re z", fontsize=9, color=GRY)
    ax.set_ylabel("Im z", fontsize=9, color=GRY)
    ax.grid(True, color=LGRY, lw=0.4)
    if title:
        ax.set_title(title, fontsize=11, fontweight="bold", pad=8)


def draw_ccw_arrow(ax, x, y, dx, dy, color=RED):
    """Draw a small CCW direction arrowhead on a curve."""
    ax.annotate("", xy=(x + dx * 0.01, y + dy * 0.01),
                xytext=(x - dx * 0.01, y - dy * 0.01),
                xycoords="data", textcoords="data",
                arrowprops=dict(arrowstyle="-|>", color=color, lw=2.0,
                                mutation_scale=18))


def draw_cw_arrow(ax, x, y, dx, dy, color=RED, ls="--"):
    """Draw a small CW direction arrowhead on a curve."""
    ax.annotate("", xy=(x - dx * 0.01, y - dy * 0.01),
                xytext=(x + dx * 0.01, y + dy * 0.01),
                xycoords="data", textcoords="data",
                arrowprops=dict(arrowstyle="-|>", color=color, lw=2.0,
                                mutation_scale=18, linestyle=ls))


def build_figure():
    fig = SPEC.figure()
    axes = [fig.add_subplot(2, 2, i) for i in range(1, 5)]
    fig.subplots_adjust(left=0.08, right=0.96, top=0.93, bottom=0.07,
                        hspace=0.35, wspace=0.28)

    # ---- Panel 1: Smooth contour (ellipse) ---- #
    ax1 = axes[0]
    setup_axes(ax1, title="Smooth contour")
    t = np.linspace(0, 2 * np.pi, 300)
    ex = 2.0 * np.cos(t)
    ey = 1.3 * np.sin(t)
    ax1.plot(ex, ey, color=BLU, lw=2.0)
    # CCW arrow at top of ellipse
    draw_ccw_arrow(ax1, 0, 1.3, 1.0, 0.0)
    ax1.text(0, 1.65, "CCW", fontsize=8, color=RED, ha="center",
             fontweight="bold")

    # ---- Panel 2: Piecewise smooth contour (rounded rectangle) ---- #
    ax2 = axes[1]
    setup_axes(ax2, title="Piecewise smooth contour")
    # Draw a polygon (hexagon for clear corners)
    n_sides = 6
    angles = np.linspace(0, 2 * np.pi, n_sides + 1)
    rx = 2.0 * np.cos(angles)
    ry = 1.5 * np.sin(angles)
    ax2.plot(rx, ry, color=BLU, lw=2.0)
    # Mark corners with small dots
    ax2.plot(rx[:-1], ry[:-1], "o", color=BLU, ms=4, zorder=5)
    # CCW arrow on top edge
    draw_ccw_arrow(ax2, -1.0, 1.5, 1.0, 0.0)
    ax2.text(-1.0, 1.85, "CCW", fontsize=8, color=RED, ha="center",
             fontweight="bold")

    # ---- Panel 3: Circle |z − a| = r ---- #
    ax3 = axes[2]
    setup_axes(ax3, title=r"Circle $|z - a| = r$")
    a_re, a_im = 0.5, -0.3
    r_circ = 1.6
    t3 = np.linspace(0, 2 * np.pi, 300)
    cx = a_re + r_circ * np.cos(t3)
    cy = a_im + r_circ * np.sin(t3)
    ax3.plot(cx, cy, color=BLU, lw=2.0)
    # Center point
    ax3.plot(a_re, a_im, "o", color=BLU, ms=5, zorder=5)
    ax3.annotate("$a$", xy=(a_re, a_im), xytext=(6, -12),
                 textcoords="offset points", fontsize=11, color=BLU,
                 fontweight="bold")
    # Radius line
    rx_end = a_re + r_circ * np.cos(np.pi / 4)
    ry_end = a_im + r_circ * np.sin(np.pi / 4)
    ax3.plot([a_re, rx_end], [a_im, ry_end], color=BLU, lw=1.0, ls=":")
    ax3.text((a_re + rx_end) / 2 + 0.1, (a_im + ry_end) / 2 + 0.1,
             "$r$", fontsize=11, color=BLU, fontstyle="italic")
    # CCW arrow at top
    draw_ccw_arrow(ax3, a_re, a_im + r_circ, 1.0, 0.0)

    # ---- Panel 4: Multiply connected domain (annulus) ---- #
    ax4 = axes[3]
    setup_axes(ax4, title="Multiply connected domain")

    r_out = 2.2
    r_in = 0.9

    # Shaded annular region
    theta4 = np.linspace(0, 2 * np.pi, 300)
    outer_x = r_out * np.cos(theta4)
    outer_y = r_out * np.sin(theta4)
    inner_x = r_in * np.cos(theta4[::-1])
    inner_y = r_in * np.sin(theta4[::-1])
    ax4.fill(np.concatenate([outer_x, inner_x]),
             np.concatenate([outer_y, inner_y]),
             color=BLU, alpha=0.08, zorder=1)

    # Outer circle (solid, CCW)
    ax4.plot(outer_x, outer_y, color=BLU, lw=2.0, zorder=3)
    # CCW arrow on outer circle (right side)
    draw_ccw_arrow(ax4, r_out, 0, 0.0, 1.0)
    ax4.text(r_out + 0.15, 0.45, "positive", fontsize=8, color=RED,
             fontweight="bold")

    # Inner circle (dashed, CW)
    ix = r_in * np.cos(theta4)
    iy = r_in * np.sin(theta4)
    ax4.plot(ix, iy, color=BLU, lw=2.0, ls="--", zorder=3)
    # CW arrow on inner circle (right side)
    draw_cw_arrow(ax4, r_in, 0, 0.0, 1.0, color=RED)
    ax4.text(r_in + 0.15, -0.45, "negative", fontsize=8, color=RED,
             fontweight="bold")

    # Domain label
    ax4.text(0, (r_out + r_in) / 2, "$D$", fontsize=14, color=BLU,
             ha="center", va="center", fontweight="bold")

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "contour-types")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
