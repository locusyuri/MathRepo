"""Geometry of the condition number for A = [[3, 1], [1, 1]].

A is symmetric, so its singular values are its eigenvalues and its singular vectors are
its eigenvectors v1 = (1, 1)/sqrt(2) and v2 = (1, -1)/sqrt(2). Hence
sigma_max = 2 + sqrt(2) = 3.414214 (along v1), sigma_min = 2 - sqrt(2) = 0.585786
(along v2), and kappa_2(A) = sigma_max / sigma_min = 5.828427.
The unit circle is mapped to an ellipse whose semi-axes lie along v1 and v2, and the
aspect ratio of that ellipse is exactly the condition number.
"""

import matplotlib.pyplot as plt
import numpy as np

A = np.array([[3.0, 1.0], [1.0, 1.0]])
SIGMA_MAX, SIGMA_MIN = 2 + np.sqrt(2), 2 - np.sqrt(2)
KAPPA = SIGMA_MAX / SIGMA_MIN
V_MAX = np.array([1.0, 1.0]) / np.sqrt(2)
V_MIN = np.array([1.0, -1.0]) / np.sqrt(2)

OUT = "6.Mathématiques appliquées/Analyse Numérique/img/conditioning-ellipse.svg"
PREVIEW = "tmp/preview-conditioning-ellipse.png"

t = np.linspace(0, 2 * np.pi, 800)
circle = np.vstack([np.cos(t), np.sin(t)])
image = A @ circle

fig, ax = plt.subplots(figsize=(5.0, 4.8))

ax.plot(circle[0], circle[1], color="tab:blue", linewidth=1.4, linestyle="--",
        label=r"unit ball $\|x\|_2 = 1$")
ax.plot(image[0], image[1], color="tab:red", linewidth=2.0,
        label=r"image $\|A x\|_2$")

# principal axes: ± sigma_max along v1, ± sigma_min along v2
for sign in (1, -1):
    ax.annotate("", xy=sign * SIGMA_MAX * V_MAX, xytext=(0, 0),
                arrowprops=dict(arrowstyle="->", color="tab:red", linewidth=1.1))
    ax.annotate("", xy=sign * SIGMA_MIN * V_MIN, xytext=(0, 0),
                arrowprops=dict(arrowstyle="->", color="tab:red", linewidth=1.1))

ax.text(2.50, 2.02, r"$\sigma_{\max} = 3.414$", fontsize=8.5, color="tab:red")
ax.text(0.55, -0.88, r"$\sigma_{\min} = 0.586$", fontsize=8.5, color="tab:red")
ax.text(0.05, -2.35, r"$\kappa_2(A) = \sigma_{\max}/\sigma_{\min} = 5.83$",
        fontsize=9, color="0.2")

ax.set_aspect("equal")
ax.set_xlim(-3.2, 3.8)
ax.set_ylim(-2.7, 2.7)
ax.axhline(0, color="0.88", linewidth=0.8, zorder=0)
ax.axvline(0, color="0.88", linewidth=0.8, zorder=0)
ax.set_xlabel(r"$y_1$")
ax.set_ylabel(r"$y_2$")
ax.legend(fontsize=8, loc="lower left", frameon=False)

fig.tight_layout()
fig.savefig(OUT, format="svg")
fig.savefig(PREVIEW, format="png", dpi=140)
plt.close(fig)
