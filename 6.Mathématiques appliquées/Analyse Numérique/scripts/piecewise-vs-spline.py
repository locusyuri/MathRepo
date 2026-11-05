"""Three interpolants of Runge's function f(x) = 1 / (1 + 25 x^2) on [-1, 1].

Nine equispaced nodes (N = 8 subintervals), so h = 1/4:
  * piecewise linear interpolant (continuous, corners at the nodes),
  * clamped cubic spline (C^2, exact end slopes f'(+-1) = -+50/676),
  * global interpolating polynomial of degree 8, solved from the Vandermonde system.

Maximum errors on 8001 sample points: piecewise linear 6.4e-2, clamped spline 5.6e-2,
polynomial of degree 8 about 1.05 (it oscillates with amplitude comparable to the function).
"""

import matplotlib.pyplot as plt
import numpy as np

F = lambda x: 1.0 / (1.0 + 25.0 * x**2)  # noqa: E731
DF = lambda x: -50.0 * x / (1.0 + 25.0 * x**2) ** 2  # noqa: E731
N = 8

OUT = "6.Mathématiques appliquées/Analyse Numérique/img/piecewise-vs-spline.svg"
PREVIEW = "tmp/preview-piecewise-vs-spline.png"

xs = np.linspace(-1.0, 1.0, N + 1)
ys = F(xs)
h = xs[1] - xs[0]

# clamped cubic spline through the moment equations, unknowns M_0..M_N
A = np.zeros((N + 1, N + 1))
r = np.zeros(N + 1)
A[0, 0], A[0, 1] = 2.0, 1.0
r[0] = 6.0 / h * ((ys[1] - ys[0]) / h - DF(xs[0]))
for i in range(1, N):
    A[i, i - 1], A[i, i], A[i, i + 1] = 0.5, 2.0, 0.5
    r[i] = 3.0 / h**2 * (ys[i + 1] - 2.0 * ys[i] + ys[i - 1])
A[N, N - 1], A[N, N] = 1.0, 2.0
r[N] = 6.0 / h * (DF(xs[N]) - (ys[N] - ys[N - 1]) / h)
M = np.linalg.solve(A, r)

grid = np.linspace(-1.0, 1.0, 8001)
spline = np.zeros_like(grid)
for k in range(N):
    m = (grid >= xs[k]) & (grid <= xs[k + 1] + 1e-12)
    x = grid[m]
    spline[m] = (
        M[k] * (xs[k + 1] - x) ** 3 / (6 * h)
        + M[k + 1] * (x - xs[k]) ** 3 / (6 * h)
        + (ys[k] - M[k] * h * h / 6) * (xs[k + 1] - x) / h
        + (ys[k + 1] - M[k + 1] * h * h / 6) * (x - xs[k]) / h
    )

coeffs = np.linalg.solve(np.vander(xs, N + 1, increasing=True), ys)
poly = np.vander(grid, N + 1, increasing=True) @ coeffs

fig, ax = plt.subplots(figsize=(7.4, 4.4))
ax.plot(grid, F(grid), color="black", linewidth=2.4, label=r"$f(x) = 1/(1+25x^2)$")
ax.plot(grid, np.interp(grid, xs, ys), color="tab:blue", linewidth=1.4, linestyle="-.",
        label="piecewise linear")
ax.plot(grid, spline, color="tab:green", linewidth=1.8, label="clamped cubic spline")
ax.plot(grid, poly, color="tab:red", linewidth=1.2, linestyle="--",
        label=r"polynomial of degree $8$")
ax.plot(xs, ys, linestyle="none", marker="o", markersize=4.0, color="black")

ax.set_xlim(-1.0, 1.0)
ax.set_ylim(-1.6, 2.2)
ax.set_xlabel(r"$x$")
ax.set_ylabel(r"$y$")
ax.legend(fontsize=8, loc="upper center", ncol=2, frameon=False)

fig.tight_layout()
fig.savefig(OUT, format="svg")
fig.savefig(PREVIEW, format="png", dpi=140)
plt.close(fig)

print("PL   max err %.2e" % np.abs(np.interp(grid, xs, ys) - F(grid)).max())
print("spln max err %.2e" % np.abs(spline - F(grid)).max())
print("poly max err %.2e" % np.abs(poly - F(grid)).max())
