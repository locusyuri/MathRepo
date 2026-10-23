"""Gibbs phenomenon: partial sums of the square wave for N = 5, 25, 125."""

import matplotlib.pyplot as plt
import numpy as np

OUT = "1.Analyse/Analyse Harmonique/img/gibbs.svg"

x = np.linspace(-np.pi, np.pi, 4001)
square = np.where(x < 0.0, -1.0, 1.0)

fig, axes = plt.subplots(3, 1, figsize=(6.0, 5.4), sharex=True)
for ax, n in zip(axes, (5, 25, 125)):
    s = (4.0 / np.pi) * sum(np.sin((2 * k + 1) * x) / (2 * k + 1) for k in range(n))
    ax.plot(x, square, color="0.6", linewidth=1.0, linestyle="--")
    ax.plot(x, s, color="tab:blue", linewidth=1.2)
    ax.set_ylim(-1.7, 1.7)
    ax.set_yticks([-1.0, 0.0, 1.0])
    ax.set_ylabel(rf"$S_{{{n}}}$")
    ax.axhline(0.0, color="0.85", linewidth=0.6)
axes[-1].set_xlim(-np.pi, np.pi)
axes[-1].set_xticks(
    [-np.pi, -np.pi / 2, 0, np.pi / 2, np.pi],
    [r"$-\pi$", r"$-\frac{\pi}{2}$", r"$0$", r"$\frac{\pi}{2}$", r"$\pi$"],
)
axes[-1].set_xlabel(r"$x$")
fig.tight_layout()
fig.savefig(OUT, format="svg")
plt.close(fig)
