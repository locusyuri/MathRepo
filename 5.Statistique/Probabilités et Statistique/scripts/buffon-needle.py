"""Buffon's needle: crossing geometry (left) vs (theta, x)-rectangle (right).

Two-panel SVG:
  Left   : three parallel lines spaced d, tilted needle of length ell whose
           lower tip just touches a line, midpoint distance x, angle theta.
  Right  : the (theta, x) rectangle [0, pi] x [0, d/2] with the red curve
           x = (ell/2) sin(theta) and the crossing region shaded below it.

Run with: uv run python src/math_paper/buffon_needle.py
"""

from __future__ import annotations

from dataclasses import replace
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH_PANEL, figsize=(13.0, 6.2))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1a1a1a"
RED = "#d32f2f"
FILL = "#f4b8b3"
GRY = "#888888"
LG = "#cccccc"

D = 1.0          # line spacing
ELL = 0.72       # needle length (< d)
TH = 1.05        # needle angle (rad)


def panel_left(ax):
    ylines = [0.0, D, 2 * D]
    A = np.array([0.5, 0.0])
    u = np.array([np.cos(TH), np.sin(TH)])
    B = A + ELL * u
    M = 0.5 * (A + B)
    mx = M[0]

    # three parallel lines
    for y in ylines:
        ax.plot([-0.35, 2.7], [y, y], color=INK, lw=1.8, zorder=1)

    # distance d between two adjacent lines (double arrow + label)
    xd = 2.15
    ax.annotate("", xy=(xd, 0), xytext=(xd, D),
                arrowprops=dict(arrowstyle="<->", color=INK, lw=1.2))
    ax.text(xd + 0.13, D / 2, "$d$", fontsize=13, color=INK, va="center")

    # needle (red)
    ax.plot([A[0], B[0]], [A[1], B[1]], color=RED, lw=2.4, zorder=4)
    # length label ell along the needle
    ax.text(mx, 0.47, r"$\ell$", fontsize=13, color=RED,
            ha="center", va="center", rotation=np.degrees(TH) - 10)
    # midpoint dot
    ax.plot(*M, "o", ms=5, color=INK, zorder=5)
    # vertical dashed guide from midpoint to the line below
    ax.plot([mx, mx], [M[1], 0], color=GRY, lw=1.0, ls="--", zorder=3)
    # x dimension (double arrow, offset to the right)
    xx = mx + 0.1
    ax.annotate("", xy=(xx, 0), xytext=(xx, M[1]),
                arrowprops=dict(arrowstyle="<->", color=GRY, lw=1.2))
    ax.text(xx + 0.08, M[1] / 2, "$x$", fontsize=12, color=GRY,
            va="center")

    # angle arc theta at the lower tip
    from matplotlib.patches import Arc
    r_arc = 0.16
    ax.add_patch(Arc(A, 2 * r_arc, 2 * r_arc, theta1=0,
                     theta2=np.degrees(TH), color=INK, lw=1.3))
    lab = A + 0.28 * np.array([np.cos(TH / 2), np.sin(TH / 2)])
    ax.text(lab[0] + 0.02, lab[1], r"$\theta$", fontsize=13, color=INK)

    ax.set_xlim(-0.35, 2.75)
    ax.set_ylim(-0.55, 2.5)
    ax.set_aspect("equal")
    ax.axis("off")
    ax.set_title("Needle and parallel lines", fontsize=15, pad=10)


def panel_right(ax):
    t = np.linspace(0, np.pi, 300)
    y = (ELL / 2) * np.sin(t)
    d2 = D / 2

    ax.fill_between(t, 0, y, color=RED, alpha=0.15, zorder=1)
    ax.plot(t, y, color=RED, lw=2.2, zorder=3)
    # peak height ell/2
    ax.axhline(ELL / 2, xmin=0, xmax=1, color=GRY, lw=1.0, ls="--", zorder=2)
    ax.text(np.pi - 0.1, ELL / 2 + 0.04, r"$\ell/2$", fontsize=12,
            color=GRY, ha="right")

    ax.set_xlim(0, np.pi)
    ax.set_ylim(0, d2 * 1.18)
    ax.set_xticks([0, np.pi])
    ax.set_xticklabels([r"$0$", r"$\pi$"], fontsize=12)
    ax.set_yticks([0, d2])
    ax.set_yticklabels([r"$0$", r"$d/2$"], fontsize=12)
    ax.set_xlabel(r"$\theta$", fontsize=14, labelpad=2)
    ax.set_ylabel(r"$x$", fontsize=14)
    ax.grid(True, ls=":", lw=0.7, color=LG, zorder=0)
    for sp in ax.spines.values():
        sp.set_color(LG)
        sp.set_linewidth(1.0)
    ax.tick_params(colors=INK, labelsize=11)
    ax.set_title("Crossing region in the (θ, x)-rectangle", fontsize=15, pad=10)


def build_figure():
    fig = SPEC.figure()
    panel_left(fig.add_subplot(1, 2, 1))
    panel_right(fig.add_subplot(1, 2, 2))
    fig.subplots_adjust(left=0.03, right=0.97, bottom=0.09, top=0.87,
                        wspace=0.3)
    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "buffon-needle")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
