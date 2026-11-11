"""Dependency structure of the divided difference table.

Data: nodes x_i = 0, 1, 2, 3 with values y_i = 1, 3, 2, 5, so the table is

    values   order 1   order 2   order 3
      1
      3         2
      2        -1       -3/2
      5         3         2        7/6

Every entry of order k >= 1 is obtained from the entry to its left (same row) and the
entry to its upper left, by subtracting the two and dividing by the difference of the
two extreme nodes:  f[x_i, ..., x_{i+k}] = (f[x_{i+1}, ..., x_{i+k}] - f[x_i, ..., x_{i+k-1}]) / (x_{i+k} - x_i).
The red arrows show one instance, -3/2 = (-1 - 2) / (2 - 0).
"""

import matplotlib.pyplot as plt
from matplotlib.patches import FancyArrowPatch, FancyBboxPatch

COL_X = {0: 0.0, 1: 1.75, 2: 3.5, 3: 5.25}
ROW_Y = {0: 0.0, 1: -1.15, 2: -2.30, 3: -3.45}
BOX_W, BOX_H = 1.10, 0.58

MINUS = "\u2212"
CELLS = {
    (0, 0): "1", (0, 1): "3", (0, 2): "2", (0, 3): "5",
    (1, 1): "2", (1, 2): f"{MINUS}1", (1, 3): "3",
    (2, 2): f"{MINUS}3/2", (2, 3): "2",
    (3, 3): "7/6",
}
HEADERS = {0: "values", 1: "order 1", 2: "order 2", 3: "order 3"}
HIGHLIGHT = (2, 2)
PARENTS = ((1, 1), (2, 1))
HIGHLIGHT_ROWS = (0, 2)  # nodes x_0 and x_2 entering the highlighted computation

OUT = "6.Mathématiques appliquées/Analyse Numérique/img/divided-difference-table.svg"
PREVIEW = "tmp/preview-divided-difference-table.png"

fig, ax = plt.subplots(figsize=(6.6, 4.4))


def centre(k, i):
    return COL_X[k], ROW_Y[i]


def box(k, i, edge, face, text, weight="normal"):
    x, y = centre(k, i)
    ax.add_patch(
        FancyBboxPatch(
            (x - BOX_W / 2, y - BOX_H / 2), BOX_W, BOX_H,
            boxstyle="round,pad=0.02,rounding_size=0.06",
            linewidth=1.3, edgecolor=edge, facecolor=face, zorder=2,
        )
    )
    ax.text(x, y, text, ha="center", va="center", fontsize=10, zorder=3, weight=weight)


def arrow(src, dst, color, width, rad):
    x1, y1 = centre(*src)
    x2, y2 = centre(*dst)
    ax.add_patch(
        FancyArrowPatch(
            (x1 + BOX_W / 2, y1), (x2 - BOX_W / 2, y2),
            connectionstyle=f"arc3,rad={rad}",
            arrowstyle="-|>", mutation_scale=9,
            linewidth=width, color=color, zorder=1,
        )
    )


# faint arrows for every derived entry
for (k, i) in CELLS:
    if k == 0:
        continue
    for src, rad in (((k - 1, i), -0.18), ((k - 1, i - 1), 0.18)):
        color = "tab:red" if (k, i) == HIGHLIGHT else "0.72"
        width = 1.6 if (k, i) == HIGHLIGHT else 0.8
        arrow(src, (k, i), color, width, rad)

# boxes
for (k, i), text in CELLS.items():
    if (k, i) == HIGHLIGHT:
        box(k, i, "tab:red", "#F5B7B1", text, weight="bold")
    elif (k, i) in PARENTS:
        box(k, i, "tab:red", "#FDECEC", text)
    else:
        box(k, i, "0.45", "#F5F5F5", text)

# headers and row labels
for k, label in HEADERS.items():
    ax.text(COL_X[k], 0.95, label, ha="center", va="center", fontsize=8.5, color="0.25")
for i in ROW_Y:
    highlighted = i in HIGHLIGHT_ROWS
    ax.text(-0.95, ROW_Y[i], rf"$x_{i} = {i}$", ha="right", va="center", fontsize=8.5,
            color="tab:red" if highlighted else "0.25",
            weight="bold" if highlighted else "normal")

ax.text(COL_X[2] + 0.05, -2.92, r"$(-1 - 2)\,/\,(2 - 0) = -3/2$", ha="center", va="center",
        fontsize=8.5, color="tab:red")

ax.set_xlim(-1.55, 5.9)
ax.set_ylim(-3.95, 1.25)
ax.set_aspect("equal")
ax.axis("off")

fig.tight_layout()
fig.savefig(OUT, format="svg")
fig.savefig(PREVIEW, format="png", dpi=140)
plt.close(fig)
