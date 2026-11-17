"""Chebyshev polynomial T_5 on [-1, 1] and the corresponding monic polynomial.

Top panel: T_5 with its six alternating extrema at cos(k pi / 5) and its five zeros
at cos((2k-1) pi / 10).
Bottom panel: the monic polynomial 2^{-4} T_5 and the band +-2^{-4}: among monic
polynomials of degree five it has the smallest possible maximum modulus on [-1, 1].
"""

import matplotlib.pyplot as plt
import numpy as np

N = 5
OUT = "6.Mathématiques appliquées/Analyse Numérique/img/chebyshev-extrema-zeros.svg"
PREVIEW = "tmp/preview-chebyshev-extrema-zeros.png"

x = np.linspace(-1.0, 1.0, 2001)
t = np.cos(N * np.arccos(x))
x_ext = np.cos(np.arange(N + 1) * np.pi / N)
y_ext = np.cos(np.arange(N + 1) * np.pi)
x_zero = np.cos((2 * np.arange(1, N + 1) - 1) * np.pi / (2 * N))

fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(7.2, 6.2), sharex=True)

ax1.axhline(1.0, color="0.55", linewidth=0.9, linestyle=":")
ax1.axhline(-1.0, color="0.55", linewidth=0.9, linestyle=":")
ax1.plot(x, t, color="tab:blue", linewidth=2.0, label=r"$T_5(x)$")
ax1.plot(x_ext, y_ext, linestyle="none", marker="o", markersize=5.0, color="tab:red",
         label="extrema")
ax1.plot(x_zero, np.zeros_like(x_zero), linestyle="none", marker="o", markersize=5.0,
         color="black", label="zeros")
ax1.set_ylim(-1.28, 1.28)
ax1.set_ylabel(r"$T_5$")
ax1.legend(fontsize=8, loc="upper left", ncol=3, frameon=False)
ax1.set_title(r"(a) $T_5(x)=\cos(5\,\arccos x)$: six alternating extrema and five zeros",
              fontsize=10, loc="left")

ax2.axhline(2.0**-4, color="0.55", linewidth=0.9, linestyle="--")
ax2.axhline(-2.0**-4, color="0.55", linewidth=0.9, linestyle="--")
ax2.plot(x, t / 2.0**(N - 1), color="tab:green", linewidth=2.0,
         label=r"$2^{-4}T_5(x)$")
ax2.plot(x_ext, y_ext / 2.0**(N - 1), linestyle="none", marker="o", markersize=5.0,
         color="tab:red")
ax2.set_ylim(-0.085, 0.085)
ax2.set_xlim(-1.02, 1.02)
ax2.set_xlabel(r"$x$")
ax2.set_ylabel(r"$2^{-4}T_5$")
ax2.legend(fontsize=8, loc="lower left", frameon=False)
ax2.set_title(r"(b) monic: its deviation stays inside $\pm 2^{-4}$, and is minimal",
              fontsize=10, loc="left")

fig.tight_layout()
fig.savefig(OUT, format="svg")
fig.savefig(PREVIEW, format="png", dpi=140)
plt.close(fig)

print("max |T5| = %.6f" % np.abs(t).max())
print("max |2^-4 T5| = %.6f  (2^-4 = %.6f)" % ((np.abs(t) / 16.0).max(), 2.0**-4))
