"""Polytropic process family on the p-V diagram.

All curves pass through the common state (V0, p0) = (1, 1) and obey
p = p0 (V/V0)^(-n) for n = 0 (isobar), 0.6, 1 (isotherm), gamma = 5/3
(reversible adiabat), 3, and the n -> oo limit (isochore, vertical).
As n grows the curve steepens monotonically: 0 < n < 1 flattens below
the isotherm, 1 < n < gamma steepens between isotherm and adiabat, and
n > gamma steepens beyond the adiabat.

Output: ../img/polytropic-family.svg (transparent). Set PREVIEW=1 to
also save a PNG preview to %TEMP% for inspection.
"""

import os

import numpy as np
import matplotlib.pyplot as plt

GAMMA = 5.0 / 3.0
BLUE = "#1f4e9c"
RED = "#d9534f"
GREEN = "#2e8b57"
PURPLE = "#7b5ea7"
GRAY = "#8a8a8a"
POINT = "#222222"

V = np.linspace(0.42, 2.45, 800)


def curve(n):
    return V ** (-n)


fig, ax = plt.subplots(figsize=(6.2, 4.4))

# intermediate families in muted grey
for n, ls in [(0.6, (0, (4, 3))), (3.0, (0, (4, 3)))]:
    ax.plot(V, curve(n), color=GRAY, lw=1.4, ls=ls, zorder=2)

# the four canonical limits, coloured
ax.plot(V, curve(0.0), color=BLUE, lw=2.0, zorder=3)          # isobar
ax.plot(V, curve(1.0), color=GREEN, lw=2.0, zorder=3)         # isotherm
ax.plot(V, curve(GAMMA), color=RED, lw=2.0, zorder=3)         # adiabat
ax.axvline(1.0, color=PURPLE, lw=2.0, zorder=3)               # isochore

# common initial state
ax.plot([1.0], [1.0], "o", color=POINT, ms=5, zorder=5)

# labels, placed at the right end of each curve
ax.text(2.50, 1.0, "$n=0$\n(isobaric)", color=BLUE, fontsize=10.5,
        va="center", ha="left")
ax.text(2.15, curve(1.0)[np.searchsorted(V, 2.15)] - 0.075,
        "$n=1$ (isothermal)", color=GREEN, fontsize=10.5, va="top")
ax.text(2.15, curve(GAMMA)[np.searchsorted(V, 2.15)] - 0.02,
        "$n=\\gamma$ (adiabatic)", color=RED, fontsize=10.5, va="top")
ax.text(1.06, 2.42, "$n\\to\\infty$\n(isochoric)", color=PURPLE,
        fontsize=10.5, va="top", ha="left")
ax.text(0.62, curve(0.6)[np.searchsorted(V, 0.62)] + 0.10,
        "$0<n<1$", color=GRAY, fontsize=10, va="bottom")
ax.text(0.63, 2.42, "$1<n<\\gamma$", color=GRAY, fontsize=10, va="top")
ax.text(0.42, 2.42, "$n>\\gamma$", color=GRAY, fontsize=10, va="top")

ax.set_xlim(0.40, 2.95)
ax.set_ylim(0, 2.75)
ax.set_xlabel("$V$", fontsize=12)
ax.set_ylabel("$p$", fontsize=12)
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

fig.tight_layout()
out = os.path.join(os.path.dirname(__file__), "..", "img",
                   "polytropic-family.svg")
fig.savefig(out, transparent=True)
print("saved", os.path.abspath(out))

if os.environ.get("PREVIEW"):
    png = os.path.join(os.environ["TEMP"], "polytropic-family.png")
    fig.savefig(png, dpi=180, facecolor="white")
    print("preview", png)
