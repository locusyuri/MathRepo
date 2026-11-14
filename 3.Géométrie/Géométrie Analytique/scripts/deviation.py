"""Deviation of a point from a plane, on the positive and negative side.

The plane pi is drawn in oblique projection; n_0 is its unit normal through O,
Q is the foot of the perpendicular from M_0, and the signed deviation is the
projection of Q->M_0 onto n_0.  The left panel has M_0 on the positive side,
the right panel on the negative side.

Output: ../img/deviation.svg
"""

from __future__ import annotations

import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import Polygon

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import save

OUT = Path(__file__).resolve().parent.parent / "img" / "deviation.svg"

INK = "#1f2933"
AXIS = "#8b949e"
GHOST = "#aab2bb"
KEY = "#c0392b"

O = np.array([0.0, 0.0])
C = np.array([2.55, 1.65])
U = np.array([1.95, 0.42])
V = np.array([-0.82, 1.05])


def arrow(ax, start, end, colour=INK, lw=1.1, style="-|>"):
    ax.annotate("", xy=end, xytext=start,
                arrowprops=dict(arrowstyle=style, color=colour, lw=lw,
                                shrinkA=0, shrinkB=0, mutation_scale=11))


def dot(ax, point, label=None, offset=(0.10, 0.10), colour=INK):
    ax.plot([point[0]], [point[1]], "o", color=colour, ms=4.0)
    if label:
        ax.text(point[0] + offset[0], point[1] + offset[1], label, fontsize=10,
                color=INK)


def panel(fig, index, side):
    ax = fig.add_subplot(1, 2, index)
    ax.set_aspect("equal")
    ax.axis("off")
    ax.set_xlim(-1.5, 5.3)
    ax.set_ylim(-1.5, 4.0)

    # Axes with labels.
    arrow(ax, O, np.array([5.1, 0.0]), colour=AXIS)
    arrow(ax, O, np.array([0.0, 3.7]), colour=AXIS)
    arrow(ax, O, np.array([-1.25, -1.25]), colour=AXIS)
    ax.text(5.15, -0.14, r"$y$", fontsize=10, color=INK)
    ax.text(-0.15, 3.75, r"$z$", fontsize=10, color=INK)
    ax.text(-1.35, -1.35, r"$x$", fontsize=10, color=INK)
    ax.text(-0.22, -0.28, r"$O$", fontsize=10, color=INK)

    # The plane pi.
    corners = [C + su * U + sv * V for su, sv in
               ((1, 1), (-1, 1), (-1, -1), (1, -1))]
    ax.add_patch(Polygon(corners, closed=True, facecolor="#eef3fa",
                         edgecolor=INK, lw=1.0, alpha=0.85))
    ax.text(corners[-1][0] - 0.35, corners[-1][1] + 0.18, r"$\pi$",
            fontsize=11, color=INK)

    # Unit normal through O and its foot P on the plane.
    P = C - 0.15 * U + 0.45 * V
    arrow(ax, O, P)
    dot(ax, P, r"$P$", offset=(-0.35, 0.08))
    ax.text(0.55, 0.72, r"$\mathbf{n}_0$", fontsize=10, color=INK)
    R = P + 0.42 * (P - O) / np.linalg.norm(P - O)
    dot(ax, R, r"$R$", offset=(-0.10, 0.14))

    # Foot Q, point M_0 and the perpendicular (parallel to n_0).
    n_unit = (P - O) / np.linalg.norm(P - O)
    Q = C + 0.30 * U - 0.20 * V
    M0 = Q + side * 1.35 * n_unit
    ax.plot([Q[0], M0[0]], [Q[1], M0[1]], color=GHOST, lw=1.0,
            ls=(0, (3, 3)))
    dot(ax, Q, r"$Q$", offset=(0.06, -0.30))
    dot(ax, M0, r"$M_0$", offset=(0.10, 0.08), colour=KEY)

    # Position vectors r_0 = OM_0 and q = OQ.
    arrow(ax, O, M0, colour=INK, lw=1.0)
    arrow(ax, O, Q, colour=INK, lw=1.0)
    ax.text(*(0.45 * M0 + np.array([-0.30, 0.10])), r"$\mathbf{r}_0$",
            fontsize=10, color=INK)
    ax.text(*(0.60 * Q + np.array([0.0, -0.28])), r"$\mathbf{q}$",
            fontsize=10, color=INK)
    ax.text(*(0.5 * (Q + M0) + np.array([0.12, 0.0])), r"$\delta$",
            fontsize=10, color=KEY)


def main():
    fig = plt.figure(figsize=(9.6, 4.0))
    panel(fig, 1, +1)
    panel(fig, 2, -1)
    fig.subplots_adjust(left=0.0, right=1.0, top=1.0, bottom=0.0, wspace=0.0)
    save(fig, OUT)


if __name__ == "__main__":
    main()
