"""Two figures for the Maxwell-Boltzmann section (nitrogen, real units).

1. speed-distribution-experimental.svg — f(v) of N2 at 300 K: strip
   dN = N f(v) dv, shaded fraction in [v1, v2], peak at v_p ~ 422 m/s,
   tail asymptotic to the v-axis.
2. maxwell-temperature-family.svg — f(v) of N2 at T = 300/600/900 K.
   Since integral f dv = 1, raising T shifts v_p = sqrt(2RT/M) right
   AND lowers the peak (height ~ 1/v_p): the curves cannot merely slide.

Output: ../img/*.svg (transparent). Set PREVIEW=1 to also save PNG
previews to %TEMP% for inspection.
"""

import os

import numpy as np
import matplotlib.pyplot as plt

R = 8.314        # J/(mol K)
M = 28e-3        # kg/mol, nitrogen N2
BLUE = "#1f4e9c"
SHADE = "#aec7e8"
STRIP = "#d9534f"
COLORS = ["#9ecae1", "#4a90d9", "#1f4e9c"]


def f_v(v, T):
    """Maxwell speed distribution in s/m, exact expression."""
    vp = np.sqrt(2 * R * T / M)
    return (4.0 / np.sqrt(np.pi)) / vp * (v / vp) ** 2 * np.exp(
        -((v / vp) ** 2))


# ------------------------------------------------------- experimental
T1 = 300.0
v = np.linspace(0, 1600, 1200)
y = f_v(v, T1) * 1e3  # in units of 1e-3 s/m

fig, ax = plt.subplots(figsize=(6.2, 4.0))
ax.plot(v, y, color=BLUE, lw=2, zorder=3)

v_a, v_b = 600.0, 900.0  # [v1, v2]
mask = (v >= v_a) & (v <= v_b)
ax.fill_between(v[mask], y[mask], color=SHADE, alpha=0.55, zorder=1)

v0, dv = 280.0, 50.0  # strip [v, v + dv]
mask_strip = (v >= v0) & (v <= v0 + dv)
ax.fill_between(v[mask_strip], y[mask_strip], color=STRIP, alpha=0.9,
                zorder=2)

vp = np.sqrt(2 * R * T1 / M)  # ~422 m/s
ax.axvline(vp, color="gray", lw=0.9, ls="--", zorder=1)
ax.annotate("$v_p$", xy=(vp, f_v(vp, T1) * 1e3), xytext=(vp + 30, 2.12),
            color="dimgray", fontsize=12)

ax.annotate("$\\mathrm{d}N = N f(v)\\,\\mathrm{d}v$",
            xy=(v0 + dv / 2, f_v(v0 + dv / 2, T1) * 1e3),
            xytext=(60, 1.95), fontsize=11, color=STRIP,
            arrowprops=dict(arrowstyle="->", color=STRIP, lw=1.0))

ax.annotate("fraction in $[v_1, v_2]$",
            xy=(750, f_v(750, T1) * 1e3), xytext=(880, 1.15),
            fontsize=11, color="#2b5d8c",
            arrowprops=dict(arrowstyle="->", color="#2b5d8c", lw=1.0))

ax.annotate("$f(v) \\to 0$ as $v \\to \\infty$\n(asymptotic to the $v$-axis)",
            xy=(1080, 0.03), xytext=(980, 0.62),
            fontsize=10, color="dimgray",
            arrowprops=dict(arrowstyle="->", color="dimgray", lw=1.0))

ax.set_xticks([0, 400, 800, 1200, 1600])
ax.set_yticks([0, 0.5, 1.0, 1.5, 2.0])
ax.set_xlim(0, 1600)
ax.set_ylim(0, 2.35)
ax.set_xlabel("$v$ (m/s)")
ax.set_ylabel("$f(v)$ ($10^{-3}\\,\\mathrm{s/m}$)")
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

fig.tight_layout()
fig.savefig("../img/speed-distribution-experimental.svg", transparent=True)
if os.environ.get("PREVIEW"):
    fig.savefig(os.path.join(os.environ["TEMP"], "maxwell-check-1.png"),
                dpi=110)
plt.close(fig)

# -------------------------------------------------- temperature family
temps = [300.0, 600.0, 900.0]
labels = ["$T_1 = 300\\,\\mathrm{K}$", "$T_2 = 600\\,\\mathrm{K}$",
          "$T_3 = 900\\,\\mathrm{K}$"]

v = np.linspace(0, 1550, 1500)

fig, ax = plt.subplots(figsize=(6.6, 4.0))
for T, lab, c in zip(temps, labels, COLORS):
    # peak height = f(v_p) ~ 1/v_p  ->  strictly decreasing in T
    ax.plot(v, f_v(v, T) * 1e3, color=c, lw=2, label=lab)
    ax.axvline(np.sqrt(2 * R * T / M), color=c, lw=0.8, ls=":")

ax.annotate("$T$ rises: $v_p$ shifts right,\npeak lowers, area stays $1$",
            xy=(740, 1.10), xytext=(860, 1.55),
            fontsize=10, color="dimgray",
            arrowprops=dict(arrowstyle="->", color="dimgray", lw=1.0))

ax.annotate("long tail: a few\nfast molecules",
            xy=(1250, 0.18), xytext=(1150, 0.85),
            fontsize=10, color="dimgray",
            arrowprops=dict(arrowstyle="->", color="dimgray", lw=1.0))

ax.annotate("$f(v) \\to 0$ only as $v \\to \\infty$",
            xy=(1480, 0.03), xytext=(1300, 0.60),
            fontsize=10, color="dimgray",
            arrowprops=dict(arrowstyle="->", color="dimgray", lw=1.0))

ax.legend(frameon=False, fontsize=10, loc="upper right")
ax.set_xticks([0, 500, 1000, 1500])
ax.set_yticks([0, 0.5, 1.0, 1.5, 2.0])
ax.set_xlim(0, 1550)
ax.set_ylim(0, 2.35)
ax.set_xlabel("$v$ (m/s)")
ax.set_ylabel("$f(v)$ ($10^{-3}\\,\\mathrm{s/m}$)")
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

fig.tight_layout()
fig.savefig("../img/maxwell-temperature-family.svg", transparent=True)
if os.environ.get("PREVIEW"):
    fig.savefig(os.path.join(os.environ["TEMP"], "maxwell-check-2.png"),
                dpi=110)
print("saved ../img/speed-distribution-experimental.svg")
print("saved ../img/maxwell-temperature-family.svg")
