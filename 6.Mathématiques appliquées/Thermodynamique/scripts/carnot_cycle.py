"""Carnot cycle on the p-V diagram (ideal gas, gamma = 5/3).

States chosen with nu R T_h = 1, nu R T_c = 1/2, V_a = 1:
  a = (1, 1)        isothermal expansion  a -> b  at T_h (blue)
  b = (2, 1/2)      adiabatic expansion   b -> c  T_h -> T_c (red)
  c = (5.657, 0.0884)  isothermal compression c -> d  at T_c (blue)
  d = (2.828, 0.1768)  adiabatic compression  d -> a  T_c -> T_h (red)
The enclosed region is lightly shaded: its area is the net work.

Output: ../img/carnot-cycle.svg (transparent). Set PREVIEW=1 to also
save a PNG preview to %TEMP% for inspection.
"""

import os

import numpy as np
import matplotlib.pyplot as plt

GAMMA = 5.0 / 3.0
BLUE = "#1f4e9c"
RED = "#d9534f"
INK = "#222222"

TH = 1.0
TC = 0.5
VA = 1.0
VB = 2.0
VC = VB * (TH / TC) ** (1.0 / (GAMMA - 1.0))
VD = VA * (TH / TC) ** (1.0 / (GAMMA - 1.0))


def isotherm_h(v):
    return TH / v


def isotherm_c(v):
    return TC / v


def adiabat_from(v0, p0):
    return lambda v: p0 * (v0 / v) ** GAMMA


v_ab = np.linspace(VA, VB, 300)
v_bc = np.linspace(VB, VC, 500)
v_cd = np.linspace(VC, VD, 300)
v_da = np.linspace(VD, VA, 500)

p_ab, p_bc = isotherm_h(v_ab), adiabat_from(VB, TH / VB)(v_bc)
p_cd, p_da = isotherm_c(v_cd), adiabat_from(VA, TH / VA)(v_da)

fig, ax = plt.subplots(figsize=(6.2, 4.4))

# enclosed region (net work), traced a -> b -> c -> d -> a
v_loop = np.concatenate([v_ab, v_bc, v_cd, v_da])
p_loop = np.concatenate([p_ab, p_bc, p_cd, p_da])
ax.fill(v_loop, p_loop, color=BLUE, alpha=0.08, zorder=1)

# legs: isotherms blue, adiabats red
ax.plot(v_ab, p_ab, color=BLUE, lw=2.2, zorder=3, label="isothermal")
ax.plot(v_bc, p_bc, color=RED, lw=2.2, zorder=3, label="adiabatic")
ax.plot(v_cd, p_cd, color=BLUE, lw=2.2, zorder=3)
ax.plot(v_da, p_da, color=RED, lw=2.2, zorder=3)

# direction arrows, offset slightly outside the loop for legibility
centroid = (np.mean(v_loop), np.mean(p_loop))
for vv, pp in [(v_ab, p_ab), (v_bc, p_bc), (v_cd, p_cd), (v_da, p_da)]:
    i = len(vv) // 2
    dv, dp = vv[i + 1] - vv[i - 1], pp[i + 1] - pp[i - 1]
    norm = np.hypot(dv, dp)
    ux, uy = dv / norm, dp / norm
    # radial offset away from the enclosed region, scaled to the axes
    ox, oy = vv[i] - centroid[0], pp[i] - centroid[1]
    onorm = np.hypot(ox, oy) or 1.0
    off = 0.075
    bx, by = vv[i] + off * ox / onorm, pp[i] + off * oy / onorm * 2.2
    ax.annotate(
        "", xy=(bx + 0.45 * ux, by + 0.45 * uy),
        xytext=(bx - 0.45 * ux, by - 0.45 * uy),
        arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.4),
        zorder=4,
    )

# vertices
for v, p, name, (dx, dy) in [
    (VA, TH, "$a$", (-0.16, 0.02)),
    (VB, TH / VB, "$b$", (0.02, 0.05)),
    (VC, TC / VC, "$c$", (0.06, -0.005)),
    (VD, TC / VD, "$d$", (0.08, 0.02)),
]:
    ax.plot([v], [p], "o", color=INK, ms=4, zorder=5)
    ax.text(v + dx, p + dy, name, fontsize=12, va="center")

# heat exchange hints
ax.text(1.5, TH / 1.5 + 0.055, "absorbs $Q_h$", color=BLUE, fontsize=9.5,
        ha="center")
ax.text(4.3, TC / 4.3 + 0.03, "rejects $Q_c$", color=BLUE, fontsize=9.5,
        ha="center")

ax.legend(loc="upper right", frameon=False, fontsize=10.5)
ax.set_xlim(0.6, 6.3)
ax.set_ylim(0, 1.18)
ax.set_xlabel("$V$", fontsize=12)
ax.set_ylabel("$p$", fontsize=12)
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

fig.tight_layout()
out = os.path.join(os.path.dirname(__file__), "..", "img", "carnot-cycle.svg")
fig.savefig(out, transparent=True)
print("saved", os.path.abspath(out))

if os.environ.get("PREVIEW"):
    png = os.path.join(os.environ["TEMP"], "carnot-cycle.png")
    fig.savefig(png, dpi=180, facecolor="white")
    print("preview", png)
