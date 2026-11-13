"""Taylor expansion disks — radius of convergence equals distance to the
nearest singularity.  f(z) = 1 / (1 - z²), singularities at z = ±1.

Left : expansion at z₀ = 0  →  R = 1   (blocked by z = ±1)
Right: expansion at z₀ = 1/2 → R = 1/2 (nearest singularity z = 1, circle
       passes through the origin)

Run with: uv run python src/math_paper/taylor_disk.py
"""

from __future__ import annotations

from pathlib import Path
import sys

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import OutputSpec

OUT_DIR = Path(__file__).resolve().parent.parent / "img"

SPEC = OutputSpec(
    figsize=(13.0, 6.2), fmt="svg", pad_inches=0.05,
    transparent=False, facecolor="white",
)

BLU = "#1f4e9b"
LBLU = "#4a90d9"
RED = "#c0392b"
GRY = "#888888"
DARK = "#333333"

TH = np.linspace(0, 2 * np.pi, 400)


def setup_plane(ax, title):
    ax.set_aspect("equal")
    ax.axhline(0, color=GRY, lw=0.6, alpha=0.7, zorder=1)
    ax.axvline(0, color=GRY, lw=0.6, alpha=0.7, zorder=1)
    ax.set_xlim(-1.9, 1.9)
    ax.set_ylim(-1.45, 1.45)
    ax.set_xlabel("Re z", fontsize=10, color=GRY)
    ax.set_ylabel("Im z", fontsize=10, color=GRY)
    ax.set_xticks([-1.0, -0.5, 0.5, 1.0])
    ax.set_yticks([-1.0, 1.0])
    ax.tick_params(labelsize=8, colors=GRY)
    ax.set_title(title, fontsize=13, fontweight="bold", pad=10)


def singularity(ax, x, y, color, ms=9, mew=2.0, zorder=7):
    ax.plot(x, y, marker="x", color=color, ms=ms, mew=mew, zorder=zorder)


def build_figure():
    fig = SPEC.figure()

    ax_l = fig.add_subplot(1, 2, 1)
    ax_r = fig.add_subplot(1, 2, 2)
    fig.subplots_adjust(left=0.06, right=0.98, top=0.90, bottom=0.11,
                        wspace=0.14)

    # ======================================================================= #
    # Left: expansion at z0 = 0,  R = 1
    # ======================================================================= #
    setup_plane(ax_l, "expansion at $z_0 = 0$")

    # Interior of the convergence disk
    ax_l.add_patch(mpatches.Circle((0, 0), 1.0, facecolor=LBLU, alpha=0.10,
                                   edgecolor="none", zorder=2))
    # Dashed boundary |z| = 1
    ax_l.plot(np.cos(TH), np.sin(TH), color=BLU, lw=1.8, ls="--", zorder=4)

    # Radius indicator (diagonal) with label R = 1
    ang = np.deg2rad(52)
    ax_l.plot([0, np.cos(ang)], [0, np.sin(ang)],
              color=BLU, lw=1.4, zorder=5)
    ax_l.text(0.5 * np.cos(ang) - 0.10, 0.5 * np.sin(ang) + 0.10,
              "$R = 1$", fontsize=12, color=BLU, fontweight="bold")

    # Center z0 = 0
    ax_l.plot(0, 0, "o", color=DARK, ms=8, zorder=8)
    ax_l.text(0.05, -0.20, "$z_0 = 0$", fontsize=11, color=DARK,
              fontweight="bold")

    # Singularities z = ±1 (both lie exactly on the circle)
    singularity(ax_l, 1.0, 0.0, RED)
    singularity(ax_l, -1.0, 0.0, RED)
    ax_l.annotate("$z = 1$", xy=(1.0, 0.0), xytext=(10, 14),
                  textcoords="offset points", fontsize=10, color=RED,
                  fontweight="bold")
    ax_l.annotate("$z = -1$", xy=(-1.0, 0.0), xytext=(-12, 14),
                  textcoords="offset points", fontsize=10, color=RED,
                  fontweight="bold")

    # Region labels
    ax_l.text(0, -0.55, "converges", fontsize=11, color=BLU, ha="center",
              style="italic", fontweight="bold")
    ax_l.text(-1.55, 1.20, "diverges", fontsize=11, color="#8a8a8a",
              ha="left", style="italic")

    # ======================================================================= #
    # Right: expansion at z0 = 1/2,  R = 1/2
    # ======================================================================= #
    c = 0.5
    r = 0.5
    setup_plane(ax_r, "expansion at $z_0 = 1/2$")

    ax_r.add_patch(mpatches.Circle((c, 0), r, facecolor=LBLU, alpha=0.12,
                                   edgecolor="none", zorder=2))
    ax_r.plot(c + r * np.cos(TH), r * np.sin(TH),
              color=BLU, lw=1.8, ls="--", zorder=4)

    # Radius to the nearest singularity (along the real axis, highlighted)
    ax_r.plot([c, 1.0], [0, 0], color=RED, lw=2.6, zorder=6)
    ax_r.text(c + 0.25, 0.10, "$R = 1/2$", fontsize=12, color=RED,
              fontweight="bold", ha="center")

    # Center z0 = 1/2
    ax_r.plot(c, 0, "o", color=DARK, ms=8, zorder=8)
    ax_r.annotate("$z_0 = 1/2$", xy=(c, 0), xytext=(-4, -22),
                  textcoords="offset points", fontsize=11, color=DARK,
                  fontweight="bold", ha="center")

    # Nearest singularity z = 1 (tangent point, highlighted)
    singularity(ax_r, 1.0, 0.0, RED, ms=13, mew=2.8, zorder=9)
    ax_r.annotate("nearest singularity\n$z = 1$", xy=(1.0, 0.0),
                  xytext=(16, -32), textcoords="offset points",
                  fontsize=10, color=RED, fontweight="bold")

    # Farther singularity z = -1 (small, gray)
    singularity(ax_r, -1.0, 0.0, GRY, ms=7, mew=1.6)
    ax_r.annotate("$z = -1$  (farther)", xy=(-1.0, 0.0), xytext=(-6, 12),
                  textcoords="offset points", fontsize=9, color=GRY,
                  ha="right")

    # Origin — the circle passes exactly through it
    ax_r.plot(0, 0, "o", mfc="white", mec=DARK, ms=6, mew=1.4, zorder=8)
    ax_r.annotate("passes through $O$", xy=(0, 0), xytext=(-80, -20),
                  textcoords="offset points", fontsize=9, color=DARK,
                  style="italic")

    # Region labels
    ax_r.text(c, -0.40, "converges", fontsize=9, color=BLU, ha="center",
              style="italic", fontweight="bold")
    ax_r.text(-1.60, 1.20, "diverges", fontsize=11, color="#8a8a8a",
              ha="left", style="italic")

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "taylor-disk")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
