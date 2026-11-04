"""Error of a forward difference quotient as a function of the step size.

Total error E(h) = M h / 2 + 2 eps / h with M = 1 and eps = 1e-16 (double precision),
minimised at h* = 2 sqrt(eps / M) = 2e-8 where E(h*) = 2 sqrt(eps M) = 2e-8.
Truncation grows like h, roundoff decays like 1/h, and neither can be reduced without
increasing the other.
"""

import matplotlib.pyplot as plt
import numpy as np

M, EPS = 1.0, 1e-16
H_STAR = 2 * np.sqrt(EPS / M)  # 2e-8
E_STAR = 2 * np.sqrt(EPS * M)  # 2e-8

OUT = "6.Mathématiques appliquées/Analyse Numérique/img/optimal-step-size.svg"
PREVIEW = "tmp/preview-optimal-step-size.png"

h = np.geomspace(1e-11, 1e-4, 600)
truncation = 0.5 * M * h
roundoff = 2 * EPS / h
total = truncation + roundoff

fig, ax = plt.subplots(figsize=(7.0, 4.6))

ax.loglog(h, truncation, color="tab:red", linewidth=1.8, linestyle="--",
          label=r"truncation $\simeq M h / 2$")
ax.loglog(h, roundoff, color="tab:blue", linewidth=1.8, linestyle="--",
          label=r"roundoff $\simeq 2\varepsilon / h$")
ax.loglog(h, total, color="black", linewidth=2.4, label=r"total $E(h)$")

ax.plot([H_STAR], [E_STAR], marker="o", markersize=6, color="tab:purple", zorder=5)
ax.axvline(H_STAR, color="tab:purple", linewidth=1.0, linestyle=":")
ax.axhline(E_STAR, color="tab:purple", linewidth=1.0, linestyle=":")
ax.text(1.1e-9, 1.4e-11, r"$h^* \approx 2\times 10^{-8}$", fontsize=9, color="tab:purple")
ax.text(2.6e-8, 1.4e-11, r"$E(h^*) \approx 2\times 10^{-8}$", fontsize=9, color="0.25")

ax.set_xlim(1e-11, 1e-4)
ax.set_ylim(1e-11, 1e-5)
ax.set_xlabel(r"step size $h$")
ax.set_ylabel(r"error of $(f(x+h)-f(x))/h$")
ax.grid(True, which="major", color="0.9", linewidth=0.6)
ax.legend(fontsize=9, loc="upper center")

fig.tight_layout()
fig.savefig(OUT, format="svg")
fig.savefig(PREVIEW, format="png", dpi=140)
plt.close(fig)
