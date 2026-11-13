#!/usr/bin/env python3
"""Figure: marginal consistency of the finite-dimensional distributions.

Layout
------
Three boxes in a row, connected by projection arrows:

    mu_{t1 t2 t3}  --pi-->  mu_{t1 t2}  --pi-->  mu_{t1}

Above each box the ambient space (S^3, S^2, S); below each box a one-line
description. The bottom line states the consistency requirement.

Output: img/fdd-consistency.svg
"""

from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch

INK = "#1f2933"
MUTED = "#52606d"
EDGE = "#9aa5b1"

BOXES = [
    (1.75, r"$\mu_{t_1 t_2 t_3}$", r"$S^3$", "joint law of three times", "#e8f1f8"),
    (5.00, r"$\mu_{t_1 t_2}$", r"$S^2$", "marginal on two times", "#e9f6ee"),
    (8.25, r"$\mu_{t_1}$", r"$S$", "marginal on one time", "#fdf1e3"),
]

W, H = 1.80, 1.00
CY = 2.15

fig, ax = plt.subplots(figsize=(9.0, 3.1))
ax.set_xlim(0, 10)
ax.set_ylim(0.35, 3.55)
ax.axis("off")

for x, formula, space, desc, fill in BOXES:
    ax.add_patch(
        FancyBboxPatch(
            (x - W / 2, CY - H / 2),
            W,
            H,
            boxstyle="round,pad=0.0,rounding_size=0.06",
            linewidth=1.0,
            edgecolor=EDGE,
            facecolor=fill,
        )
    )
    ax.text(x, CY + 0.16, formula, ha="center", va="center", fontsize=14.0, color=INK)
    ax.text(x, CY - 0.26, desc, ha="center", va="center", fontsize=8.4, color=MUTED)
    ax.text(x, CY + H / 2 + 0.20, space, ha="center", va="center", fontsize=10.0, color=MUTED)

for x0, x1, label in [(2.65, 4.10, "integrate out $t_3$"), (5.90, 7.35, "integrate out $t_2$")]:
    ax.annotate(
        "",
        xy=(x1, CY),
        xytext=(x0, CY),
        arrowprops=dict(arrowstyle="-|>", color=INK, linewidth=1.1, shrinkA=0, shrinkB=0),
    )
    ax.text((x0 + x1) / 2, CY + 0.20, label, ha="center", va="center", fontsize=8.2, color=MUTED)

ax.text(5.0, 0.72, "every marginal agrees with the one computed directly from the same joint law",
        ha="center", va="center", fontsize=9.0, color=INK)

fig.subplots_adjust(left=0.02, right=0.98, top=0.96, bottom=0.04)

out = Path(__file__).resolve().parent.parent / "img" / "fdd-consistency.svg"
fig.savefig(out, format="svg")
fig.savefig(out.with_suffix(".png"), format="png", dpi=140)
print("written:", out)
