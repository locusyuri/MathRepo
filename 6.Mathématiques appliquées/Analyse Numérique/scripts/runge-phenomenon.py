"""Runge's counterexample: equispaced interpolation of f(x) = 1 / (1 + 25 x^2) on [-1, 1].

Top panel: f together with the equispaced interpolants of degree 6, 10 and 20, computed by
solving the Vandermonde system (the coefficient representation is adequate at this degree).
The frame is clipped at y = -1.5 so that the middle of the interval remains visible; the
degree-20 interpolant reaches values of order -60 near x = ±0.975.

Bottom panel: the maximum error on [-1, 1], sampled on 20001 points, for n + 1 =
5, 7, 9, 11, 15, 21 nodes. Values: 0.438, 0.617, 1.045, 1.916, 7.195, 59.82.
"""

import matplotlib.pyplot as plt
import numpy as np

F = lambda x: 1.0 / (1.0 + 25.0 * x**2)  # noqa: E731
DEGREES = (6, 10, 20)
COUNTS = (5, 7, 9, 11, 15, 21)
XS = np.linspace(-1.0, 1.0, 20001)

OUT = "6.Mathématiques appliquées/Analyse Numérique/img/runge-phenomenon.svg"
PREVIEW = "tmp/preview-runge-phenomenon.png"


def interpolant(degree):
    nodes = np.linspace(-1.0, 1.0, degree + 1)
    coeffs = np.linalg.solve(np.vander(nodes, degree + 1, increasing=True), F(nodes))
    return np.vander(XS, degree + 1, increasing=True) @ coeffs


fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(7.0, 6.4), gridspec_kw={"height_ratios": [1.35, 1.0]})

ax1.plot(XS, F(XS), color="black", linewidth=2.2, label=r"$f(x) = 1/(1 + 25x^2)$")
for degree, color in zip(DEGREES, ("tab:blue", "tab:orange", "tab:red")):
    ax1.plot(XS, interpolant(degree), color=color, linewidth=1.2, linestyle="--",
             label=rf"$n = {degree}$")
    ax1.plot(np.linspace(-1, 1, degree + 1), F(np.linspace(-1, 1, degree + 1)),
             linestyle="none", marker="o", markersize=3.0, color=color)

ax1.set_ylim(-1.5, 2.0)
ax1.set_xlim(-1.0, 1.0)
ax1.set_ylabel(r"$y$")
ax1.legend(fontsize=8, loc="lower center", ncol=2, frameon=False)
ax1.set_title("Equispaced interpolants oscillate near the endpoints", fontsize=9)
ax1.grid(True, color="0.92", linewidth=0.6)

errors = [np.abs(interpolant(n) - F(XS)).max() for n in (c - 1 for c in COUNTS)]
ax2.semilogy(COUNTS, errors, color="tab:red", marker="o", markersize=5, linewidth=1.6)
for count, err in zip(COUNTS, errors):
    ax2.annotate(f"{err:.3g}", xy=(count, err), xytext=(4, 5), textcoords="offset points",
                 fontsize=7.5, color="0.25")
ax2.set_ylim(top=errors[-1] * 2.4)
ax2.set_xlim(3.2, 23.0)
ax2.set_xlabel("number of equispaced nodes")
ax2.set_ylabel(r"max $|f - L_n|$ on $[-1,1]$")
ax2.set_title("The maximum error grows with the degree", fontsize=9)
ax2.grid(True, which="both", color="0.92", linewidth=0.6)

fig.tight_layout()
fig.savefig(OUT, format="svg")
fig.savefig(PREVIEW, format="png", dpi=140)
plt.close(fig)
