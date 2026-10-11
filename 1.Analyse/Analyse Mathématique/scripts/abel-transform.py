"""Redraw the Abel transform illustration as a transparent SVG.

Layout (upright): Abel summation formula on top; below it a coordinate system
with B_1..B_5 on the horizontal axis and a_1..a_5 on the vertical axis. The
staircase rectangles a_k b_k (column k, height a_k) together with the strips
(a_{k+1} - a_k) B_k (x in [0, B_k], y in [a_k, a_{k+1}]) tile the bounding
rectangle a_5 B_5, which proves the formula by comparing areas.

Output: ../img/abel-transform.svg (+ a PNG preview in ../../tmp for eyeball).
"""

from pathlib import Path

import matplotlib.pyplot as plt

plt.rcParams["font.family"] = "serif"
plt.rcParams["mathtext.fontset"] = "stix"

B = [1.0, 1.9, 2.7, 3.4, 4.0]  # B_1 .. B_5
A = [1.0, 1.8, 2.5, 3.1, 3.6]  # a_1 .. a_5
B0 = [0.0, *B]  # B_0 .. B_5
A0 = [0.0, *A]  # a_0 .. a_5

fig, ax = plt.subplots(figsize=(6.4, 5.6))
fig.patch.set_alpha(0)
ax.set_alpha(0)

LW = 1.3

# Outer boundary: top edge y = a_5 and right edge x = B_5
ax.plot([0, B[4]], [A[4], A[4]], color="black", lw=LW)
ax.plot([B[4], B[4]], [0, A[4]], color="black", lw=LW)

# Vertical lines x = B_k spanning y in [0, a_{k+1}] (k = 1..4):
# exactly long enough to separate the staircase cells without cutting the strips
for k in range(4):
    ax.plot([B[k], B[k]], [0, A[k + 1]], color="black", lw=LW)

# Horizontal lines y = a_k spanning x in [0, B_k] (k = 1..4)
for k in range(4):
    ax.plot([0, B[k]], [A[k], A[k]], color="black", lw=LW)

# Cell labels: staircase a_k b_k and strips (a_{k+1} - a_k) B_k
for k in range(5):
    xc = (B0[k] + B0[k + 1]) / 2
    ax.text(xc, A[k] / 2, rf"$a_{k + 1} b_{k + 1}$", ha="center", va="center", fontsize=13)
for k in range(4):
    ax.text(
        B[k] / 2,
        (A[k] + A[k + 1]) / 2,
        rf"$(a_{k + 2} - a_{k + 1}) B_{k + 1}$",
        ha="center",
        va="center",
        fontsize=13,
    )

# Axes with arrows; O at the lower left
ax.annotate("", xy=(4.9, 0), xytext=(0, 0), arrowprops=dict(arrowstyle="-|>", color="black", lw=LW))
ax.annotate("", xy=(0, 4.35), xytext=(0, 0), arrowprops=dict(arrowstyle="-|>", color="black", lw=LW))
ax.text(-0.16, -0.2, "$O$", ha="right", va="top", fontsize=13)

# Tick labels
for k in range(5):
    ax.text(B[k], -0.2, rf"$B_{k + 1}$", ha="center", va="top", fontsize=13)
    ax.text(-0.16, A[k], rf"$a_{k + 1}$", ha="right", va="center", fontsize=13)

# Abel summation formula on top
ax.text(
    2.5,
    4.1,
    r"$\sum_{k=1}^{5} a_k b_k \,=\, a_5 B_5 \,-\, \sum_{k=1}^{4} \left(a_{k+1}-a_k\right) B_k\,.$",
    ha="center",
    va="center",
    fontsize=15,
)

ax.set_xlim(-0.9, 5.1)
ax.set_ylim(-0.65, 4.6)
ax.axis("off")

root = Path(__file__).resolve().parents[3]
out_svg = root / "1.Analyse/Analyse Mathématique/img/abel-transform.svg"
fig.savefig(out_svg, format="svg", transparent=True, bbox_inches="tight", pad_inches=0.05)
fig.savefig(root / "tmp/abel-transform-preview.png", facecolor="white", bbox_inches="tight", pad_inches=0.05, dpi=150)
fig.savefig(root / "tmp/abel-transform-preview.jpg", facecolor="white", bbox_inches="tight", pad_inches=0.05, dpi=150)
print(f"saved: {out_svg}")
