"""Unit balls of the 1-, 2- and infinity-norms in R^2.

The three sets {x : ||x||_p = 1} are drawn together to show that every norm has its
own notion of distance: a diamond (p = 1), a disc (p = 2) and a square (p = infinity).
An induced matrix norm is the largest stretch factor of such a ball under the map x -> A x.
"""

import matplotlib.pyplot as plt
import numpy as np

OUT = "6.Mathématiques appliquées/Analyse Numérique/img/unit-balls.svg"
PREVIEW = "tmp/preview-unit-balls.png"

fig, ax = plt.subplots(figsize=(4.6, 4.6))

# p = 1 : diamond |x| + |y| = 1
ax.plot([1, 0, -1, 0, 1], [0, 1, 0, -1, 0], color="tab:blue", linewidth=1.8,
        label=r"$p = 1$: $|x| + |y| = 1$")

# p = 2 : unit circle
t = np.linspace(0, 2 * np.pi, 700)
ax.plot(np.cos(t), np.sin(t), color="tab:red", linewidth=1.8,
        label=r"$p = 2$: $x^2 + y^2 = 1$")

# p = infinity : square
ax.plot([1, 1, -1, -1, 1], [1, -1, -1, 1, 1], color="tab:green", linewidth=1.8,
        label=r"$p = \infty$: $\max(|x|, |y|) = 1$")


ax.set_aspect("equal")
ax.set_xlim(-1.35, 1.35)
ax.set_ylim(-1.35, 1.35)
ax.axhline(0, color="0.85", linewidth=0.8, zorder=0)
ax.axvline(0, color="0.85", linewidth=0.8, zorder=0)
ax.set_xlabel(r"$x_1$")
ax.set_ylabel(r"$x_2$")
ax.legend(fontsize=7.5, loc="upper center", bbox_to_anchor=(0.5, -0.14), frameon=False)

fig.tight_layout()
fig.savefig(OUT, format="svg")
fig.savefig(PREVIEW, format="png", dpi=140)
plt.close(fig)
