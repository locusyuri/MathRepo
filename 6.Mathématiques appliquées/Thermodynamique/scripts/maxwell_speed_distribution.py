"""Two figures for the Maxwell-Boltzmann section.

1. speed-distribution-experimental.svg — f(v) as an experimental curve:
   strip dN = N f(v) dv, shaded fraction in [v1, v2], peak at v_p, long
   tail asymptotic to the v-axis.
2. maxwell-temperature-family.svg — Maxwell speed distribution at three
   temperatures. Since integral f dv = 1, raising T shifts v_p right
   AND lowers the peak (height ~ 1/v_p): the curves cannot merely slide.

Output: ../img/*.svg (transparent). Set PREVIEW=1 to also save PNG
previews to %TEMP% for inspection.
"""

import os

import numpy as np
import matplotlib.pyplot as plt

BLUE = "#1f4e9c"
SHADE = "#aec7e8"
STRIP = "#d9534f"
COLORS = ["#9ecae1", "#4a90d9", "#1f4e9c"]


def f(x):
    # Maxwell speed distribution in units of 1/v_p, with x = v / v_p
    return 4.0 / np.sqrt(np.pi) * x**2 * np.exp(-(x**2))


# ------------------------------------------------------- experimental
x = np.linspace(0, 4.6, 1000)

fig, ax = plt.subplots(figsize=(5.8, 3.9))
ax.plot(x, f(x), color=BLUE, lw=2, zorder=3)

v1, v2 = 1.3, 2.0
mask = (x >= v1) & (x <= v2)
ax.fill_between(x[mask], f(x)[mask], color=SHADE, alpha=0.55, zorder=1)

v0, dv = 0.48, 0.06
mask_strip = (x >= v0) & (x <= v0 + dv)
ax.fill_between(x[mask_strip], f(x)[mask_strip], color=STRIP, alpha=0.9,
                zorder=2)

ax.axvline(1.0, color="gray", lw=0.9, ls="--", zorder=1)
ax.annotate("$v_p$", xy=(1.0, f(1.0)), xytext=(1.22, 0.86),
            color="dimgray", fontsize=12)

ax.annotate("$\\mathrm{d}N = N f(v)\\,\\mathrm{d}v$",
            xy=(v0 + dv / 2, f(v0 + dv / 2)), xytext=(0.08, 0.88),
            fontsize=11, color=STRIP,
            arrowprops=dict(arrowstyle="->", color=STRIP, lw=1.0))

ax.annotate("fraction in $[v_1, v_2]$",
            xy=(1.62, f(1.62)), xytext=(2.15, 0.58),
            fontsize=11, color="#2b5d8c",
            arrowprops=dict(arrowstyle="->", color="#2b5d8c", lw=1.0))

ax.annotate("$f(v) \\to 0$ as $v \\to \\infty$\n(asymptotic to the $v$-axis)",
            xy=(3.0, f(3.0) + 0.012), xytext=(2.7, 0.26),
            fontsize=10, color="dimgray",
            arrowprops=dict(arrowstyle="->", color="dimgray", lw=1.0))

ax.set_xticks([1.0, v1, v2])
ax.set_xticklabels(["$v_p$", "$v_1$", "$v_2$"])
ax.set_yticks([])
ax.set_xlim(0, 4.6)
ax.set_ylim(0, 0.98)
ax.set_xlabel("$v$")
ax.set_ylabel("$f(v)$")
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

fig.tight_layout()
fig.savefig("../img/speed-distribution-experimental.svg", transparent=True)
if os.environ.get("PREVIEW"):
    fig.savefig(os.path.join(os.environ["TEMP"], "maxwell-check-1.png"),
                dpi=110)
plt.close(fig)

# -------------------------------------------------- temperature family
xx = np.linspace(0, 6.8, 1400)
scales = [1.0, 1.6, 2.5]  # v_p proportional to sqrt(T)
labels = ["$T_1$", "$T_2$", "$T_3$"]

fig, ax = plt.subplots(figsize=(6.6, 3.9))
for s, lab, c in zip(scales, labels, COLORS):
    # peak height = f(1) / v_p  ->  strictly decreasing in T
    ax.plot(xx, f(xx / s) / s, color=c, lw=2, label=lab)
    ax.axvline(s, color=c, lw=0.8, ls=":")

ax.annotate("$T$ rises: $v_p$ shifts right,\npeak lowers, area stays $1$",
            xy=(2.52, 0.36), xytext=(3.55, 0.55),
            fontsize=10, color="dimgray",
            arrowprops=dict(arrowstyle="->", color="dimgray", lw=1.0))

ax.annotate("long tail: a few\nfast molecules",
            xy=(4.6, 0.045), xytext=(4.85, 0.20),
            fontsize=10, color="dimgray",
            arrowprops=dict(arrowstyle="->", color="dimgray", lw=1.0))

ax.annotate("$f(v) \\to 0$ only as $v \\to \\infty$",
            xy=(6.1, 0.008), xytext=(4.6, 0.09),
            fontsize=10, color="dimgray",
            arrowprops=dict(arrowstyle="->", color="dimgray", lw=1.0))

ax.legend(frameon=False, fontsize=11, loc="upper right")
ax.set_xticks([])
ax.set_yticks([])
ax.set_xlim(0, 6.8)
ax.set_ylim(0, 0.95)
ax.set_xlabel("$v$")
ax.set_ylabel("$f(v)$")
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

fig.tight_layout()
fig.savefig("../img/maxwell-temperature-family.svg", transparent=True)
if os.environ.get("PREVIEW"):
    fig.savefig(os.path.join(os.environ["TEMP"], "maxwell-check-2.png"),
                dpi=110)
print("saved ../img/speed-distribution-experimental.svg")
print("saved ../img/maxwell-temperature-family.svg")
