"""Speed distribution of a simplified electron gas (Fermi cutoff).

f(v) = A v^2 for 0 < v < v_F and f(v) = 0 beyond, with A = 3 / v_F^3
fixed by normalisation. Plotted in units of v_F, where f v_F = 3 (v/v_F)^2:
a parabola that rises until the sharp cutoff, a dashed drop at v_F, and
nothing to the right of it.

Output: ../img/fermi-speed-distribution.svg (transparent). Set PREVIEW=1
to also save a PNG preview to %TEMP% for inspection.
"""

import os

import numpy as np
import matplotlib.pyplot as plt

BLUE = "#1f4e9c"
RED = "#d9534f"

x = np.linspace(0.0, 1.0, 400)
y = 3.0 * x**2

fig, ax = plt.subplots(figsize=(5.4, 3.9))

ax.plot(x, y, color=BLUE, lw=2.4, zorder=3)
ax.plot([1.0, 1.0], [0.0, 3.0], color=RED, lw=1.6, ls=(0, (4, 3)), zorder=2)
ax.plot([1.0], [3.0], "o", color=BLUE, ms=4, zorder=4)
ax.plot([0.0], [0.0], "o", color=BLUE, ms=4, zorder=4)

ax.text(0.08, 2.55, "$f(v) = A v^2$", color=BLUE, fontsize=11.5, ha="left")
ax.text(1.08, 1.45, "$f(v) = 0$", color=RED, fontsize=10.5, ha="left")
ax.text(1.03, -0.28, "$v_F$", fontsize=12, ha="left")

ax.set_xlim(0, 1.45)
ax.set_ylim(0, 3.45)
ax.set_xticks([0.0])
ax.set_yticks([0.0])
ax.set_xlabel("$v$", fontsize=12, loc="right")
ax.set_ylabel("$f(v)$", fontsize=12, loc="top")
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)
ax.spines["bottom"].set_position(("data", 0.0))
ax.spines["left"].set_position(("data", 0.0))

fig.tight_layout()
out = os.path.join(os.path.dirname(__file__), "..", "img",
                   "fermi-speed-distribution.svg")
fig.savefig(out, transparent=True)
print("saved", os.path.abspath(out))

if os.environ.get("PREVIEW"):
    png = os.path.join(os.environ["TEMP"], "fermi-speed-distribution.png")
    fig.savefig(png, dpi=180, facecolor="white")
    print("preview", png)
