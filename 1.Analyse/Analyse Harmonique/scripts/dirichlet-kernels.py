"""Dirichlet kernels D_N(x) = sin((N + 1/2) x) / sin(x / 2) for several N."""

import matplotlib.pyplot as plt
import numpy as np

OUT = "1.Analyse/Analyse Harmonique/img/dirichlet-kernels.svg"

x = np.linspace(-np.pi, np.pi, 2001)
# D_N(x) = 1 + 2 sum_{k=1}^{N} cos(k x)，避开 x = 0 处的 0/0
for n, color in zip((2, 4, 6, 8), ("tab:blue", "tab:green", "tab:red", "tab:purple")):
    d = 1.0 + 2.0 * sum(np.cos(k * x) for k in range(1, n + 1))
    plt.plot(x, d, color=color, linewidth=1.4, label=rf"$N = {n}$")

plt.axhline(0.0, color="0.6", linewidth=0.8)
plt.xlim(-np.pi, np.pi)
plt.ylim(-4.0, 18.0)
plt.xticks(
    [-np.pi, -np.pi / 2, 0, np.pi / 2, np.pi],
    [r"$-\pi$", r"$-\frac{\pi}{2}$", r"$0$", r"$\frac{\pi}{2}$", r"$\pi$"],
)
plt.xlabel(r"$x$")
plt.ylabel(r"$D_N(x)$")
plt.legend(fontsize=8, loc="upper right")
plt.tight_layout()
plt.savefig(OUT, format="svg")
plt.close()
