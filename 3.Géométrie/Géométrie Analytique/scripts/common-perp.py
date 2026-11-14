"""The common perpendicular of two skew lines.

Two skew lines l_1, l_2 with direction vectors v_1, v_2; the segment M_1 M_2
is perpendicular to both.  The auxiliary line l_0 meets the two lines at
N_1, N_2 so that the right angles at M_1 and M_2 are visible.

Output: ../img/common-perp.svg
"""

from __future__ import annotations

import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import save

OUT = Path(__file__).resolve().parent.parent / "img" / "common-perp.svg"

INK = "#1f2933"
GHOST = "#8b949e"


def line(ax, p, d, half, colour=INK, lw=1.3):
    a, b = p - half * d, p + half * d
    ax.plot([a[0], b[0]], [a[1], b[1]], color=colour, lw=lw,
            solid_capstyle="round")


def arrow_along(ax, p, d, t0, t1, label, offset):
    a, b = p + t0 * d, p + t1 * d
    ax.annotate("", xy=b, xytext=a,
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.2,
                                shrinkA=0, shrinkB=0, mutation_scale=11))
    m = 0.5 * (a + b)
    ax.text(m[0] + offset[0], m[1] + offset[1], label, fontsize=11, color=INK)


def dot(ax, p, label, offset):
    ax.plot([p[0]], [p[1]], "o", ms=6, mfc="white", mec=INK, mew=1.1)
    ax.text(p[0] + offset[0], p[1] + offset[1], label, fontsize=11, color=INK)


def right_angle(ax, vertex, along, across, size=0.22):
    e = along / np.linalg.norm(along)
    f = across / np.linalg.norm(across)
    pts = [vertex + size * e, vertex + size * (e + f), vertex + size * f]
    ax.plot([p[0] for p in pts], [p[1] for p in pts], color=GHOST, lw=0.9)


def main():
    fig = plt.figure(figsize=(5.4, 4.0))
    ax = fig.add_axes([0, 0, 1, 1])
    ax.set_aspect("equal")
    ax.axis("off")
    ax.set_xlim(-2.4, 3.0)
    ax.set_ylim(-2.0, 2.2)

    # l_1 through M_1, l_2 through M_2.
    d1 = np.array([1.0, 0.32])
    d2 = np.array([1.0, -0.22])
    M1 = np.array([0.85, 0.95])
    M2 = np.array([0.30, -1.05])
    line(ax, M1, d1, 2.1)
    line(ax, M2, d2, 2.1)

    # Common perpendicular M_1 M_2.
    perp = M1 - M2
    ax.plot([M2[0], M1[0]], [M2[1], M1[1]], color=INK, lw=1.8)
    right_angle(ax, M1, -perp, d1)
    right_angle(ax, M2, perp, d2)

    # Direction arrows.
    arrow_along(ax, M1, d1, 0.55, 1.35, r"$\mathbf{v}_1$", (0.0, 0.18))
    arrow_along(ax, M2, d2, 0.55, 1.35, r"$\mathbf{v}_2$", (0.0, -0.34))

    # Labels.
    dot(ax, M1, r"$M_1$", (-0.65, 0.18))
    dot(ax, M2, r"$M_2$", (0.12, -0.36))
    ax.text(2.62, 1.62, r"$l_1$", fontsize=11, color=INK)
    ax.text(2.62, -1.51, r"$l_2$", fontsize=11, color=INK)

    # Auxiliary line l_0, drawn through both N_1 and N_2.
    N1 = M1 - 0.95 * d1
    N2 = M2 - 0.45 * d2
    n = (N1 - N2) / np.linalg.norm(N1 - N2)
    start, end = N2 - 0.45 * n, N1 + 0.45 * n
    ax.plot([start[0], end[0]], [start[1], end[1]], color=GHOST, lw=1.0)
    dot(ax, N1, r"$N_1$", (-0.55, 0.16))
    dot(ax, N2, r"$N_2$", (-0.55, 0.16))
    ax.text(N1[0] - 0.18, N1[1] + 1.42, r"$l_0$", fontsize=11, color=INK)

    save(fig, OUT)


if __name__ == "__main__":
    main()
