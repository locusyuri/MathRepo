"""Fejér kernels F_N(t) = (1 / N) (sin(N t / 2) / sin(t / 2))^2 for several N."""

import matplotlib.pyplot as plt
import numpy as np

OUT = "1.Analyse/Analyse Harmonique/img/fejer-kernels.svg"

t = np.linspace(-np.pi, np.pi, 2000)  # 偶数个点，避开 t = 0 的奇点
for n, color in zip((2, 4, 6, 8, 10), ("tab:blue", "tab:green", "tab:red", "tab:purple", "tab:brown")):
    f = (np.sin(n * t / 2) / np.sin(t / 2)) ** 2 / n
    plt.plot(t, f, color=color, linewidth=1.4, label=rf"$N = {n}$")

plt.axhline(0.0, color="0.6", linewidth=0.8)
plt.xlim(-np.pi, np.pi)
plt.xticks(
    [-np.pi, -np.pi / 2, 0, np.pi / 2, np.pi],
    [r"$-\pi$", r"$-\frac{\pi}{2}$", r"$0$", r"$\frac{\pi}{2}$", r"$\pi$"],
)
plt.xlabel(r"$t$")
plt.ylabel(r"$F_N(t)$")
plt.legend(fontsize=8, loc="upper right")
plt.tight_layout()
plt.savefig(OUT, format="svg")
plt.close()
