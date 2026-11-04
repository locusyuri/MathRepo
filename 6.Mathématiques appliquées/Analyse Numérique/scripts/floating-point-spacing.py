"""Relative spacing of the floating-point system F(2, 4, -2, 2).

Panel A (log-log): the absolute spacing ulp(x) = 2^(e-4) on the binade [2^(e-1), 2^e),
a staircase whose steps double at every power of the base. The two slope-1 reference
lines are y = 2^(-t) x and y = 2^(1-t) x (t = 4).

Panel B (log-log): the relative spacing ulp(x)/x, a sawtooth inside (u, 2u] with
u = 1/2 beta^(1-t) = 2^(-t) = 0.0625. This is the geometric content of the lemma on
relative spacing: the same relative precision is available at every scale.
"""

import matplotlib.pyplot as plt
import numpy as np

BETA, T = 2, 4
E_MIN, E_MAX = -2, 2
X_LEFT = BETA ** (E_MIN - 1)  # 0.125
X_RIGHT = BETA**E_MAX  # 4.0
U = 0.5 * BETA ** (1 - T)  # 0.0625
TWO_U = BETA ** (1 - T)  # 0.125

OUT = "6.Mathématiques appliquées/Analyse Numérique/img/floating-point-spacing.svg"
PREVIEW = "tmp/preview-floating-point-spacing.png"

fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(7.2, 6.0), sharex=True)

# ---------------------------------------------------------------- panel A
for e in range(E_MIN, E_MAX + 1):
    left, right = BETA ** (e - 1), BETA**e
    ulp = BETA ** (e - T)
    ax1.hlines(ulp, left, right, color="tab:blue", linewidth=2.4)
    ax1.plot([left, left], [ulp / 2, ulp], color="tab:blue", linewidth=1.0, linestyle=":")

grid = np.array([BETA**e for e in range(E_MIN - 1, E_MAX + 1)])
tick_ys = [BETA ** (e - T) for e in range(E_MIN, E_MAX + 1)]
for y in tick_ys:
    ax1.axhline(y, color="0.85", linewidth=0.6, zorder=0)

xx = np.array([X_LEFT, X_RIGHT])
ax1.plot(xx, BETA ** (-T) * xx, color="tab:red", linewidth=1.2, linestyle="--")
ax1.plot(xx, BETA ** (1 - T) * xx, color="tab:green", linewidth=1.2, linestyle="--")
ax1.text(0.17, BETA ** (-T) * 0.17 * 0.62, r"$2^{-t}\,x$", color="tab:red", fontsize=9)
ax1.text(1.9, BETA ** (1 - T) * 1.9 * 1.35, r"$2^{1-t}\,x$", color="tab:green", fontsize=9)

ax1.set_xscale("log", base=2)
ax1.set_yscale("log", base=2)
ax1.set_xlim(X_LEFT, X_RIGHT)
ax1.set_ylim(2 ** (-7), 2 ** (-1))
ax1.set_ylabel(r"$\mathrm{ulp}(x)$")
ax1.set_title(r"Absolute spacing (log-log): flat inside a binade, doubled at each power of 2", fontsize=9)

# ---------------------------------------------------------------- panel B
ratio_x, ratio_y = [], []
for e in range(E_MIN, E_MAX + 1):
    xs = np.geomspace(BETA ** (e - 1), BETA**e, 200, endpoint=(e == E_MAX))
    ratio_x.append(xs)
    ratio_y.append(BETA ** (e - T) / xs)

ax2.plot(np.concatenate(ratio_x), np.concatenate(ratio_y), color="tab:blue", linewidth=1.8)
ax2.axhline(TWO_U, color="tab:green", linewidth=1.0, linestyle="--")
ax2.axhline(U, color="tab:red", linewidth=1.0, linestyle="--")

ax2.set_xscale("log", base=2)
ax2.set_yscale("log", base=2)
ax2.set_xlim(X_LEFT, X_RIGHT)
ax2.set_ylim(2 ** (-4.7), 2 ** (-2.5))
ax2.set_xlabel(r"$x$")
ax2.set_ylabel(r"$\mathrm{ulp}(x)/|x|$")
ax2.set_title(r"Relative spacing: the same relative precision $u < \mathrm{ulp}(x)/|x| \leq 2u$ at every scale", fontsize=9)
ax2.set_xticks([BETA**e for e in range(E_MIN - 1, E_MAX + 1)])
ax2.set_xticklabels([rf"$2^{{{e}}}$" for e in range(E_MIN - 1, E_MAX + 1)])
ax2.set_yticks([U, TWO_U])
ax2.set_yticklabels([r"$2^{-4} = u$", r"$2^{-3} = 2u$"])

fig.tight_layout()
fig.savefig(OUT, format="svg")
fig.savefig(PREVIEW, format="png", dpi=140)
plt.close(fig)
