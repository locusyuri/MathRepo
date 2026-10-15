# -*- coding: utf-8 -*-
"""Generate img/exterior-ladder.svg for the section
"Differential Forms and Exterior Differentiation" of Analyse Mathématique.

Layout: a 3-column (R, R^2, R^3) x 4-row (0-form ... 3-form) ladder.
Each downward arrow is the exterior derivative d (raises the degree by one);
the rungs matched with Green / Stokes / Gauß are annotated.
Vanished cells (degree > dimension) are greyed out.

Usage (from repo root):  uv run "1.Analyse/Analyse Mathématique/scripts/exterior-ladder.py"
Output:                  1.Analyse/Analyse Mathématique/img/exterior-ladder.svg (transparent background)
"""

import os
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

# ---- exact style constants -------------------------------------------------
EDGE = "#888888"      # cell borders
TEXT = "#1a1a1a"      # main text
ZERO = "#aaaaaa"      # vanished cells
ARROW = "#2c6e8f"     # d arrows
MARK = "#a0522d"      # theorem annotations
HEADBG = "#f0f0f0"    # header cells background
DASH = "#bbbbbb"      # dashed zero arrows

CELL_W, CELL_H = 3.4, 1.05
COLS = [2.4, 6.4, 10.4]          # x-centres of the three space columns
ROWS = [6.0, 4.7, 3.4, 2.1]      # y-centres, 0-form ... 3-form

CELLS = {
    (0, 0): r"$f(x)$",
    (0, 1): r"$P(x)\,\mathrm{d}x$",
    (1, 0): r"$f(x,y)$",
    (1, 1): r"$P\,\mathrm{d}x+Q\,\mathrm{d}y$",
    (1, 2): r"$P\,\mathrm{d}x\wedge\mathrm{d}y$",
    (2, 0): r"$f(x,y,z)$",
    (2, 1): r"$P\,\mathrm{d}x+Q\,\mathrm{d}y+R\,\mathrm{d}z$",
    (2, 2): r"$P\,\mathrm{d}y\wedge\mathrm{d}z+Q\,\mathrm{d}z\wedge\mathrm{d}x+R\,\mathrm{d}x\wedge\mathrm{d}y$",
    (2, 3): r"$f\,\mathrm{d}x\wedge\mathrm{d}y\wedge\mathrm{d}z$",
}

fig, ax = plt.subplots(figsize=(9.2, 6.2))
ax.set_xlim(0, 12.6)
ax.set_ylim(1.2, 7.6)
ax.set_aspect("equal")
ax.axis("off")

# ---- column headers ---------------------------------------------------------
for j, label in enumerate([r"$\mathbb{R}$", r"$\mathbb{R}^2$", r"$\mathbb{R}^3$"]):
    x = COLS[j]
    ax.add_patch(plt.Rectangle((x - CELL_W / 2, 7.0), CELL_W, 0.52,
                               facecolor=HEADBG, edgecolor=EDGE, lw=0.8))
    ax.text(x, 7.26, label, ha="center", va="center", fontsize=14, color=TEXT)

# ---- row headers ------------------------------------------------------------
for i, label in enumerate(["0-form", "1-form", "2-form", "3-form"]):
    ax.text(0.45, ROWS[i], label, ha="center", va="center",
            fontsize=11, color=TEXT)

# ---- cells ------------------------------------------------------------------
for i in range(4):
    for j in range(3):
        x, y = COLS[j], ROWS[i]
        vanished = i > j + 1      # degree exceeds dimension (columns index R^(j+1))
        ax.add_patch(plt.Rectangle((x - CELL_W / 2, y - CELL_H / 2), CELL_W, CELL_H,
                                   facecolor="none", edgecolor=EDGE, lw=0.8))
        if vanished:
            ax.text(x, y, r"$0$", ha="center", va="center",
                    fontsize=13, color=ZERO)
        else:
            fs = 11.5 if len(CELLS[(j, i)]) < 46 else 9.0
            ax.text(x, y, CELLS[(j, i)], ha="center", va="center",
                    fontsize=fs, color=TEXT)

# ---- d arrows between adjacent non-vanished rows ----------------------------
def d_arrow(col, row_top, row_bot, label=None, dashed=False):
    x = COLS[col]
    ax.annotate(
        "", xy=(x, row_bot + CELL_H / 2 + 0.03), xytext=(x, row_top - CELL_H / 2 - 0.03),
        arrowprops=dict(arrowstyle="-|>", lw=1.6, color=DASH if dashed else ARROW,
                        linestyle="--" if dashed else "-"))
    if label:
        ax.text(x + 0.55, (row_top + row_bot) / 2, label, ha="left", va="center",
                fontsize=10.5, color=MARK)

# degree-raising arrows (mathematical verification: each arrow maps a k-form to
# a (k+1)-form; the greyed arrows would leave the ladder, hence dashed)
d_arrow(0, ROWS[0], ROWS[1])                                   # R:   0 -> 1
d_arrow(1, ROWS[0], ROWS[1])                                   # R2:  0 -> 1
d_arrow(1, ROWS[1], ROWS[2], label="Green")                    # R2:  1 -> 2
d_arrow(2, ROWS[0], ROWS[1], label=r"$\mathrm{d}f=\nabla f$")  # R3:  0 -> 1
d_arrow(2, ROWS[1], ROWS[2], label="Stokes")                   # R3:  1 -> 2
d_arrow(2, ROWS[2], ROWS[3], label="Gauß")                     # R3:  2 -> 3

out = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                   "..", "img", "exterior-ladder.svg")
fig.savefig(out, format="svg", transparent=True, bbox_inches="tight", pad_inches=0.05)
print("written:", os.path.normpath(out))
