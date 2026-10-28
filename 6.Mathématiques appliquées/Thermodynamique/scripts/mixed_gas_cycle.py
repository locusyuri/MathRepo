"""Cycle of a mixed ideal gas on the p-V diagram.

Mixture of 2 mol monatomic + 2 mol rigid diatomic ideal gas:
C_{V,m} = 2R, C_{p,m} = 3R, gamma = 3/2. States in units of
p_a = 1 and nu R T_a = 1 (T a = 300 K):
  a = (1, 1)    T_a = 300 K   isobaric expansion    a -> b (blue)
  b = (3, 1)    T_b = 900 K   adiabatic expansion   b -> c (red)
  c = (12, 1/8) T_c = 450 K   isobaric compression  c -> d (blue)
  d = (4, 1/8)  T_d = 150 K   adiabatic compression d -> a (red)
The shaded region is the net work W = 3600 R.

Output: ../img/mixed-gas-cycle.svg (transparent). Set PREVIEW=1 to also
save a PNG preview to %TEMP% for inspection.
"""

import os

import numpy as np
import matplotlib.pyplot as plt

GAMMA = 1.5
BLUE = "#1f4e9c"
RED = "#d9534f"
INK = "#222222"

VA, PA = 1.0, 1.0
VB = 3.0
VC, PC = 12.0, 0.125
VD, PD = 4.0, 0.125

v_ab = np.linspace(VA, VB, 200)
v_bc = np.linspace(VB, VC, 500)
v_cd = np.linspace(VC, VD, 200)
v_da = np.linspace(VD, VA, 500)

p_ab = np.full_like(v_ab, PA)
p_bc = PA * (VB / v_bc) ** GAMMA
p_cd = np.full_like(v_cd, PD)
p_da = PD * (VD / v_da) ** GAMMA

fig, ax = plt.subplots(figsize=(6.2, 3.8))

# enclosed region (net work), traced a -> b -> c -> d -> a
v_loop = np.concatenate([v_ab, v_bc, v_cd, v_da])
p_loop = np.concatenate([p_ab, p_bc, p_cd, p_da])
ax.fill(v_loop, p_loop, color=BLUE, alpha=0.08, zorder=1)

# legs: isobars blue, adiabats red
ax.plot(v_ab, p_ab, color=BLUE, lw=2.2, zorder=3, label="isobaric")
ax.plot(v_bc, p_bc, color=RED, lw=2.2, zorder=3, label="adiabatic")
ax.plot(v_cd, p_cd, color=BLUE, lw=2.2, zorder=3)
ax.plot(v_da, p_da, color=RED, lw=2.2, zorder=3)


def arrow(v0, p0, v1, p1, color):
    """Mid-leg direction marker along the chord."""
    t, back = 0.58, 0.14
    ax.annotate(
        "",
        xy=(v0 + t * (v1 - v0), p0 + t * (p1 - p0)),
        xytext=(v0 + (t - back) * (v1 - v0), p0 + (t - back) * (p1 - p0)),
        arrowprops=dict(arrowstyle="-|>", color=color, lw=1.6),
        zorder=4,
    )


arrow(VA, PA, VB, PA, BLUE)
arrow(VB, PA, VC, PC, RED)
arrow(VC, PC, VD, PD, BLUE)
arrow(VD, PD, VA, PA, RED)

# vertices, with the temperature of each state
for v, p, name, temp, (dx, dy) in [
    (VA, PA, "a", 300, (-0.75, 0.055)),
    (VB, PA, "b", 900, (0.12, 0.055)),
    (VC, PC, "c", 450, (-0.30, -0.055)),
    (VD, PD, "d", 150, (-1.45, -0.055)),
]:
    ax.plot([v], [p], "o", color=INK, ms=4, zorder=5)
    ax.text(v + dx, p + dy, f"${name}$, {temp} K", fontsize=11, va="center")

# heat exchange hints
ax.text(2.30, PA + 0.055, "absorbs $Q_{ab}$", color=BLUE, fontsize=9.5,
        ha="center")
ax.text(8.0, PD - 0.075, "rejects $Q_{cd}$", color=BLUE, fontsize=9.5,
        ha="center")

ax.legend(loc="upper right", frameon=False, fontsize=10.5)
ax.set_xlim(0, 13.6)
ax.set_ylim(-0.06, 1.18)
ax.set_xlabel("$V$", fontsize=12)
ax.set_ylabel("$p$", fontsize=12)
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)
ax.spines["bottom"].set_position(("data", 0.0))

fig.tight_layout()
out = os.path.join(os.path.dirname(__file__), "..", "img",
                   "mixed-gas-cycle.svg")
fig.savefig(out, transparent=True)
print("saved", os.path.abspath(out))

if os.environ.get("PREVIEW"):
    png = os.path.join(os.environ["TEMP"], "mixed-gas-cycle.png")
    fig.savefig(png, dpi=180, facecolor="white")
    print("preview", png)
