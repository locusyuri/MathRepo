"""Least-squares line through four data points.

Data (0, 1), (1, 2), (2, 4), (3, 5); the fit is y = 0.9 + 1.4 x, with residuals
0.1, -0.3, 0.3, -0.1 and sum of squares 0.2.
The vertical segments are the residuals that the fit minimizes in squared sum.
"""

import matplotlib.pyplot as plt
import numpy as np

OUT = "6.Mathématiques appliquées/Analyse Numérique/img/least-squares-fit.svg"
PREVIEW = "tmp/preview-least-squares-fit.png"

xs = np.array([0.0, 1.0, 2.0, 3.0])
ys = np.array([1.0, 2.0, 4.0, 5.0])

A = np.column_stack([np.ones_like(xs), xs])
c, *_ = np.linalg.lstsq(A, ys, rcond=None)
pred = A @ c
sse = float(np.sum((ys - pred) ** 2))

fig, ax = plt.subplots(figsize=(6.6, 4.4))
grid = np.linspace(-0.25, 3.25, 200)
ax.plot(grid, c[0] + c[1] * grid, color="tab:blue", linewidth=2.0,
        label=r"$y = %.1f + %.1f x$" % (c[0], c[1]))

for xi, yi, pi in zip(xs, ys, pred):
    ax.plot([xi, xi], [yi, pi], color="tab:red", linewidth=1.2, linestyle="-")
    ax.plot([xi, xi], [yi, pi], linestyle="none", marker="_", markersize=7.0,
            color="tab:red")

ax.plot(xs, ys, linestyle="none", marker="o", markersize=7.0, color="black",
        label="data")
ax.set_xlim(-0.3, 3.3)
ax.set_ylim(0.0, 6.0)
ax.set_xlabel(r"$x$")
ax.set_ylabel(r"$y$")
ax.legend(fontsize=9, loc="upper left", frameon=False)
ax.text(0.04, 0.06, r"$\sum r_i^2 = %.1f$" % sse, transform=ax.transAxes, fontsize=10)

fig.tight_layout()
fig.savefig(OUT, format="svg")
fig.savefig(PREVIEW, format="png", dpi=140)
plt.close(fig)

print("c0 = %.4f, c1 = %.4f, SSE = %.4f" % (c[0], c[1], sse))
