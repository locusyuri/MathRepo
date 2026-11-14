"""Where the pieces of the conic matrix appear in the quadratic form.

The 3x3 symmetric matrix A collects the coefficients of
a_11 x^2 + 2 a_12 x y + a_22 y^2 + 2 a_1 x + 2 a_2 y + a_0 = 0.  The blue,
green and magenta underlines are the rows F_1, F_2, F_3; the orange square is
the quadratic part Phi.

Output: ../img/conic-relation.svg
"""

from __future__ import annotations

import sys
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle
from matplotlib.path import Path as MPath
from matplotlib.patches import PathPatch

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _surf import save

OUT = Path(__file__).resolve().parent.parent / "img" / "conic-relation.svg"

BLUE = "#1565c0"
GREEN = "#1e8449"
PINK = "#b02a9b"
ORANGE = "#e07b16"
INK = "#1f2933"


def bracket(ax, x, y0, y1, sign=1):
    """A round parenthesis drawn as two cubic Bezier segments."""
    s = sign
    mid = (y0 + y1) / 2
    start = mid if sign < 0 else mid
    verts = [
        (x, y1),
        (x + 0.14 * s, y1 - 0.02), (x + 0.22 * s, y1 - 0.34),
        (x + 0.22 * s, start),
        (x + 0.22 * s, y0 + 0.34), (x + 0.14 * s, y0 + 0.02),
        (x, y0),
    ]
    codes = [MPath.MOVETO] + [MPath.CURVE4] * 6
    ax.add_patch(PathPatch(MPath(verts, codes), facecolor="none",
                           edgecolor=INK, lw=1.6, capstyle="round"))


def main():
    fig = plt.figure(figsize=(9.2, 2.6))
    ax = fig.add_axes([0, 0, 1, 1])
    ax.set_xlim(0, 12)
    ax.set_ylim(0, 3.6)
    ax.axis("off")

    ax.text(0.12, 1.8, r"$A =$", fontsize=24, va="center", color=INK)
    bracket(ax, 1.05, 0.55, 3.05, sign=-1)
    bracket(ax, 4.35, 0.55, 3.05, sign=1)

    entries = [
        [r"$a_{11}$", r"$a_{12}$", r"$a_{13}$"],
        [r"$a_{12}$", r"$a_{22}$", r"$a_{23}$"],
        [r"$a_{13}$", r"$a_{23}$", r"$a_{33}$"],
    ]
    xs = [1.55, 2.65, 3.75]
    ys = [2.70, 1.80, 0.90]
    for row, y in zip(entries, ys):
        for item, x in zip(row, xs):
            ax.text(x, y, item, fontsize=19, ha="center", va="center",
                    color=INK)

    # Orange box around the quadratic part.
    ax.add_patch(Rectangle((1.18, 1.42), 1.96, 1.92, fill=False,
                           edgecolor=ORANGE, lw=2.0))

    # Coloured underlines for the three rows.
    for y, colour, x0, x1 in ((2.38, BLUE, 1.18, 4.12),
                              (1.48, GREEN, 1.18, 4.12),
                              (0.58, PINK, 1.18, 4.12)):
        ax.plot([x0, x1], [y, y], color=colour, lw=2.4, solid_capstyle="round")

    formulas = [
        (r"$F_1(x,y) \equiv a_{11}x + a_{12}y + a_{13}$", BLUE, 2.95),
        (r"$F_2(x,y) \equiv a_{12}x + a_{22}y + a_{23}$", GREEN, 2.20),
        (r"$F_3(x,y) \equiv a_{13}x + a_{23}y + a_{33}$", PINK, 1.45),
        (r"$\Phi(x,y) \equiv a_{11}x^2 + 2a_{12}xy + a_{22}y^2$",
         ORANGE, 0.60),
    ]
    for text, colour, y in formulas:
        ax.text(5.10, y, text, fontsize=15, va="center", color=colour)

    save(fig, OUT)


if __name__ == "__main__":
    main()
