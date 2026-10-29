"""Schematic of a power-heating unit.

A reversible engine (left circle) draws Q_1 from the boiler at T_1,
rejects Q_2 into the heating water at T_2, and delivers the work A
(horizontal arrow) to a reversible heat pump (right circle), which
extracts Q_3 from the pond at T_3 and delivers Q_2' — also into the
heating water at T_2. The water thus receives Q = Q_2 + Q_2'.

Output: ../img/power-heating-unit.svg (transparent). Set PREVIEW=1 to
also save a PNG preview to %TEMP% for inspection.
"""

import os

import matplotlib.pyplot as plt
from matplotlib.patches import Circle

INK = "#222222"
FILL = "#eef2f8"
ACCENT = "#1f4e9c"

fig, ax = plt.subplots(figsize=(5.4, 4.4))
ax.set_xlim(0, 1.05)
ax.set_ylim(0, 1.05)
ax.set_aspect("equal")
ax.axis("off")

ENGINE = (0.28, 0.50)
PUMP = (0.78, 0.50)
BOILER = (0.28, 0.92)
POND = (0.78, 0.92)
WATER = (0.53, 0.10)
R = 0.13


def box(xy, label):
    ax.text(*xy, label, ha="center", va="center", fontsize=11,
            bbox=dict(boxstyle="round,pad=0.45", fc=FILL, ec=INK, lw=1.2))


def machine(xy, label):
    ax.add_patch(Circle(xy, R, fc="white", ec=INK, lw=1.6, zorder=3))
    ax.text(*xy, label, ha="center", va="center", fontsize=10.5, zorder=4)


def arrow(p0, p1, label, dx=0.035, dy=0.0, ha="left"):
    ax.annotate(
        "", xy=p1, xytext=p0,
        arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.8),
        zorder=2,
    )
    xm, ym = (p0[0] + p1[0]) / 2 + dx, (p0[1] + p1[1]) / 2 + dy
    ax.text(xm, ym, label, ha=ha, va="center", fontsize=11.5, color=ACCENT)


box(BOILER, "boiler\n$T_1 = 483$ K")
box(POND, "pond\n$T_3 = 288$ K")
box(WATER, "heating water, $T_2 = 333$ K")
machine(ENGINE, "reversible\nengine")
machine(PUMP, "reversible\nheat pump")

arrow((0.28, 0.845), (0.28, 0.645), "$Q_1$")
arrow((0.78, 0.845), (0.78, 0.645), "$Q_3$")
arrow((0.28, 0.355), (0.42, 0.175), "$Q_2$", dx=-0.10, ha="right")
arrow((0.78, 0.355), (0.64, 0.175), "$Q_2'$", dx=0.10)
arrow((0.425, 0.50), (0.635, 0.50), "$A$", dy=0.05, ha="center")

fig.tight_layout()
out = os.path.join(os.path.dirname(__file__), "..", "img",
                   "power-heating-unit.svg")
fig.savefig(out, transparent=True)
print("saved", os.path.abspath(out))

if os.environ.get("PREVIEW"):
    png = os.path.join(os.environ["TEMP"], "power-heating-unit.png")
    fig.savefig(png, dpi=180, facecolor="white")
    print("preview", png)
