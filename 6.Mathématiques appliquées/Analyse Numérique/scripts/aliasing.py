"""Aliasing of cos(5x) on a grid of N = 9 equally spaced points.

The nodes are x_j = 2 pi j / 9.  Since 5 = -4 (mod 9), cos(5 x_j) = cos(4 x_j),
so the trigonometric interpolant of the samples is cos(4x), not cos(5x).
The dashed curve is the interpolant; the grey curve is the sampled function.
"""

import matplotlib.pyplot as plt
import numpy as np

OUT = "6.Mathématiques appliquées/Analyse Numérique/img/aliasing.svg"
PREVIEW = "tmp/preview-aliasing.png"

N = 9
xj = 2.0 * np.pi * np.arange(N) / N
yj = np.cos(5.0 * xj)
x = np.linspace(0.0, 2.0 * np.pi, 1201)

fig, ax = plt.subplots(figsize=(7.2, 4.2))
ax.plot(x, np.cos(5.0 * x), color="0.55", linewidth=1.6,
        label=r"$f(x)=\cos 5x$ (sampled)")
ax.plot(x, np.cos(4.0 * x), color="tab:blue", linewidth=1.8, linestyle="--",
        label=r"$T(x)=\cos 4x$ (interpolant)")
ax.plot(xj, yj, linestyle="none", marker="o", markersize=6.5, color="black",
        label="samples")
ax.set_xlim(0.0, 2.0 * np.pi)
ax.set_ylim(-1.3, 1.3)
ax.set_xticks([0.0, np.pi / 2.0, np.pi, 3.0 * np.pi / 2.0, 2.0 * np.pi])
ax.set_xticklabels(["$0$", r"$\pi/2$", r"$\pi$", r"$3\pi/2$", r"$2\pi$"])
ax.set_xlabel(r"$x$")
ax.set_ylabel(r"$y$")
ax.legend(fontsize=8, loc="lower center", bbox_to_anchor=(0.5, 1.02), ncol=3,
          frameon=False)
ax.text(0.02, 0.05, r"$5 \equiv -4\ (\mathrm{mod}\ 9)$", transform=ax.transAxes, fontsize=10)

fig.tight_layout()
fig.savefig(OUT, format="svg")
fig.savefig(PREVIEW, format="png", dpi=140)
plt.close(fig)

print("max |cos5xj - cos4xj| = %.3e" % np.abs(np.cos(5.0 * xj) - np.cos(4.0 * xj)).max())
