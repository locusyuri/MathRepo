"""Lagrange basis polynomials for six equispaced nodes on [0, 1].

Nodes x_j = j / 5, j = 0, ..., 5. Each basis polynomial l_i satisfies l_i(x_j) = delta_{ij},
has degree five, and its amplitude grows towards the ends of the interval: the sum of the
absolute values has maximum about 3.1 there, which is the Lebesgue constant of these nodes.
"""

import matplotlib.pyplot as plt
import numpy as np

NODES = np.linspace(0.0, 1.0, 6)
XS = np.linspace(0.0, 1.0, 1200)

OUT = "6.Mathématiques appliquées/Analyse Numérique/img/lagrange-basis.svg"
PREVIEW = "tmp/preview-lagrange-basis.png"

colors = ("tab:blue", "tab:orange", "tab:green", "tab:red", "tab:purple", "tab:brown")

fig, ax = plt.subplots(figsize=(6.4, 3.8))

for i, color in enumerate(colors):
    basis = np.ones_like(XS)
    for j in range(len(NODES)):
        if j != i:
            basis *= (XS - NODES[j]) / (NODES[i] - NODES[j])
    ax.plot(XS, basis, color=color, linewidth=1.3, label=rf"$\ell_{i}$")

for node in NODES:
    ax.axvline(node, color="0.88", linewidth=0.7, zorder=0)

ax.axhline(0.0, color="0.6", linewidth=0.9)
ax.set_xlim(0.0, 1.0)
ax.set_ylim(-1.05, 1.45)
ax.set_xlabel(r"$x$")
ax.set_ylabel(r"$\ell_i(x)$")
ax.legend(fontsize=7.5, ncol=6, loc="upper center", bbox_to_anchor=(0.5, -0.16), frameon=False)

fig.tight_layout()
fig.savefig(OUT, format="svg")
fig.savefig(PREVIEW, format="png", dpi=140)
plt.close(fig)
