"""Cubic B-splines on a uniform knot vector with spacing one, t_i = i.

The basis functions are built by the Cox-de Boor recursion, so the picture documents the
definition itself. In the window [0, 4] exactly seven translates N_{i,3}, i = -3, ..., 3,
are active (support of N_{i,3} is [i, i + 4]), and their sum is identically one: that is
partition of unity, and it is why the Lebesgue constant of the basis does not grow.
Each translate takes the values 1/6, 2/3, 1/6 at three consecutive integer points.
"""

import matplotlib.pyplot as plt
import numpy as np

KNOTS = np.arange(-10, 20, dtype=float)  # t_i = i
DEGREE = 3
XS = np.linspace(0.0, 4.0, 1201)
ACTIVE = range(-3, 4)  # supports [i, i+4] meeting [0, 4]

OUT = "6.Mathématiques appliquées/Analyse Numérique/img/bspline-basis.svg"
PREVIEW = "tmp/preview-bspline-basis.png"


def bspline(i, p, x):
    """Cox-de Boor recursion, with the convention 0/0 = 0 for an empty knot span."""
    if p == 0:
        return ((x >= KNOTS[i]) & (x < KNOTS[i + 1])).astype(float)
    left = np.zeros_like(x)
    right = np.zeros_like(x)
    d1 = KNOTS[i + p] - KNOTS[i]
    d2 = KNOTS[i + p + 1] - KNOTS[i + 1]
    if d1 > 0:
        left = (x - KNOTS[i]) / d1 * bspline(i, p - 1, x)
    if d2 > 0:
        right = (KNOTS[i + p + 1] - x) / d2 * bspline(i + 1, p - 1, x)
    return left + right


fig, ax = plt.subplots(figsize=(6.6, 3.9))
total = np.zeros_like(XS)
shades = ("0.30", "0.42", "0.54", "0.66", "0.54", "0.42", "0.30")
for i, shade in zip(ACTIVE, shades):
    values = bspline(i + 10, DEGREE, XS)  # KNOTS[i + 10] = i
    total += values
    ax.plot(XS, values, color=shade, linewidth=1.2,
            label=r"translates $N_{i,3}$" if i == -3 else None)

# emphasise one translate
ax.plot(XS, bspline(10, DEGREE, XS), color="tab:red", linewidth=2.0, label=r"$N_{0,3}$")
ax.plot(XS, total, color="tab:blue", linewidth=1.4, linestyle="--",
        label=r"$\sum_{i} N_{i,3}(x) = 1$")

for knot in range(0, 5):
    ax.axvline(knot, color="0.9", linewidth=0.8, zorder=0)
ax.set_xlim(0.0, 4.0)
ax.set_ylim(0.0, 1.05)
ax.set_xlabel(r"$x$")
ax.set_ylabel(r"$N_{i,3}(x)$")
ax.legend(fontsize=8, ncol=3, loc="upper center", bbox_to_anchor=(0.5, -0.18), frameon=False)

fig.tight_layout()
fig.savefig(OUT, format="svg")
fig.savefig(PREVIEW, format="png", dpi=140)
plt.close(fig)
