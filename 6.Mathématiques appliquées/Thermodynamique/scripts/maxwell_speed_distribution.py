"""Maxwell speed distribution f(v)-v figure (two panels).

Left  : single temperature — the strip dN = N f(v) dv and the shaded
        area = fraction of molecules in [v1, v2]; peak at v_p.
Right : three temperatures — the peak shifts right and flattens as T
        rises, the total area staying 1.

Output: ../img/maxwell-speed-distribution.svg (transparent background).
"""

import os

import numpy as np
import matplotlib.pyplot as plt

BLUE = "#1f4e9c"
SHADE = "#aec7e8"
STRIP = "#d9534f"

x = np.linspace(0, 4, 900)


def f(x):
    # f(v) in units of 1/v_p, with x = v / v_p
    return 4.0 / np.sqrt(np.pi) * x**2 * np.exp(-(x**2))


fig, axes = plt.subplots(1, 2, figsize=(9.4, 3.8))

# ------------------------------------------------------------------ left
ax = axes[0]
ax.plot(x, f(x), color=BLUE, lw=2, zorder=3)

# shaded area = fraction of molecules in [v1, v2]
v1, v2 = 1.3, 2.0
mask = (x >= v1) & (x <= v2)
ax.fill_between(x[mask], f(x)[mask], color=SHADE, alpha=0.55, zorder=1)

# dark strip = dN = N f(v) dv
v0, dv = 0.48, 0.06
mask_strip = (x >= v0) & (x <= v0 + dv)
ax.fill_between(x[mask_strip], f(x)[mask_strip], color=STRIP, alpha=0.9,
                zorder=2)

# peak marker
ax.axvline(1.0, color="gray", lw=0.9, ls="--", zorder=1)
ax.annotate("$v_p$", xy=(1.0, f(1.0)), xytext=(1.22, 0.86),
            color="dimgray", fontsize=12)

ax.annotate("$\\mathrm{d}N = N f(v)\\,\\mathrm{d}v$",
            xy=(v0 + dv / 2, f(v0 + dv / 2)), xytext=(0.10, 0.88),
            fontsize=11, color=STRIP,
            arrowprops=dict(arrowstyle="->", color=STRIP, lw=1.0))

ax.annotate("fraction in $[v_1, v_2]$",
            xy=(1.62, f(1.62)), xytext=(1.95, 0.50),
            fontsize=11, color="#2b5d8c",
            arrowprops=dict(arrowstyle="->", color="#2b5d8c", lw=1.0))

ax.set_xticks([1.0, v1, v2])
ax.set_xticklabels(["$v_p$", "$v_1$", "$v_2$"])
ax.set_yticks([])
ax.set_xlim(0, 4)
ax.set_ylim(0, 0.95)
ax.set_xlabel("$v$")
ax.set_ylabel("$f(v)$")

# ----------------------------------------------------------------- right
ax = axes[1]
scales = [1.0, 1.5, 2.25]
labels = ["$T_1$", "$T_2$", "$T_3$"]
colors = ["#9ecae1", "#4a90d9", "#1f4e9c"]
xmax = 5.6
xx = np.linspace(0, xmax, 900)

for s, lab, c in zip(scales, labels, colors):
    vv = xx / s  # x / v_p
    ax.plot(xx, f(vv), color=c, lw=2, label=lab)
    ax.axvline(s, color=c, lw=0.8, ls=":")

ax.annotate("$T$ rises: peak shifts right\nand flattens, area stays $1$",
            xy=(2.25, f(1.0)), xytext=(3.15, 0.62),
            fontsize=10, color="dimgray",
            arrowprops=dict(arrowstyle="->", color="dimgray", lw=1.0))

ax.legend(frameon=False, fontsize=11, loc="upper right")
ax.set_xticks([])
ax.set_yticks([])
ax.set_xlim(0, xmax)
ax.set_ylim(0, 0.95)
ax.set_xlabel("$v$")
ax.set_ylabel("$f(v)$")

for ax in axes:
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)

fig.tight_layout()
fig.savefig("../img/maxwell-speed-distribution.svg", transparent=True)
if os.environ.get("PREVIEW"):
    fig.savefig(os.path.join(os.environ["TEMP"], "maxwell-check.png"), dpi=110)
print("saved ../img/maxwell-speed-distribution.svg")
