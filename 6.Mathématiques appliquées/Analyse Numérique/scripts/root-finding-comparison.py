"""Comparison of root-finding methods on f(x) = x^3 - 2.

(a) Bisection: a bracket [a0, b0] = [1, 2] is halved three times.
(b) Newton: tangents at x0 = 2 and x1 = 3/2.
(c) Secant: the chord through x0 = 2 and x1 = 3/2.
(d) Errors of the three methods on a logarithmic scale; bisection is a straight
    line (linear rate 1/2), Newton is quadratic, the secant method is between.
"""

import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GRAY, GREEN = "#3b6fb6", "#c74440", "#888888", "#3a8a5f"
OUT = "6.Mathématiques appliquées/Analyse Numérique/img/root-finding-comparison.svg"
PREVIEW = "tmp/preview-root-finding-comparison.png"

F = lambda x: x**3 - 2.0  # noqa: E731
DF = lambda x: 3.0 * x**2  # noqa: E731
ROOT = 2.0 ** (1.0 / 3.0)
GRID = np.linspace(1.0, 2.0, 601)

# bisection
brackets = [(1.0, 2.0)]
mids = []
a, b = 1.0, 2.0
for _ in range(4):
    m = 0.5 * (a + b)
    mids.append(m)
    if F(a) * F(m) <= 0.0:
        b = m
    else:
        a = m
    brackets.append((a, b))

# Newton from x0 = 2
newton = [2.0]
for _ in range(6):
    x = newton[-1]
    newton.append(x - F(x) / DF(x))

# secant from x0 = 2, x1 = 1.5
secant = [2.0, 1.5]
for _ in range(7):
    x0, x1 = secant[-2], secant[-1]
    f0, f1 = F(x0), F(x1)
    secant.append(x1 - f1 * (x1 - x0) / (f1 - f0))

fig, axes = plt.subplots(2, 2, figsize=(9.6, 7.2))

# (a) bisection
ax = axes[0, 0]
ax.plot(GRID, F(GRID), color=BLUE, linewidth=2.0)
ax.axhline(0.0, color="black", linewidth=0.8)
ax.axvline(ROOT, color=GRAY, linewidth=1.0, linestyle=":")
for k, (lo, hi) in enumerate(brackets):
    y = -0.6 - 0.55 * k
    ax.plot([lo, hi], [y, y], color=RED, linewidth=1.4)
    ax.plot([lo, lo], [y - 0.12, y + 0.12], color=RED, linewidth=1.0)
    ax.plot([hi, hi], [y - 0.12, y + 0.12], color=RED, linewidth=1.0)
    ax.plot(0.5 * (lo + hi), y, marker="o", markersize=3.6, color=RED)
    ax.text(hi + 0.02, y, r"$k=%d$" % k, fontsize=7.5, va="center", color=RED)
ax.set_xlim(1.0, 2.14)
ax.set_ylim(-3.0, 6.4)
ax.set_xlabel(r"$x$")
ax.set_ylabel(r"$f(x)$")
ax.set_title(r"(a) bisection: halve the bracket", fontsize=10, loc="left")

# (b) Newton tangents
ax = axes[0, 1]
ax.plot(GRID, F(GRID), color=BLUE, linewidth=2.0)
ax.axhline(0.0, color="black", linewidth=0.8)
ax.axvline(ROOT, color=GRAY, linewidth=1.0, linestyle=":")
x0, x1 = 2.0, 1.5
x2 = x1 - F(x1) / DF(x1)
for xk in (x0, x1):
    slope = DF(xk)
    x_next = xk - F(xk) / slope
    xs = np.array([x_next, xk])
    ax.plot(xs, F(xk) + slope * (xs - xk), color=RED, linewidth=1.2, linestyle="--")
    ax.plot(x_next, 0.0, marker="o", markersize=5.0, color=RED)
    ax.plot(xk, F(xk), marker="o", markersize=4.0, color="black")
ax.annotate(r"$x_0$", (x0, F(x0)), textcoords="offset points", xytext=(-18, 4), fontsize=9)
ax.annotate(r"$x_1$", (x1, 0.0), textcoords="offset points", xytext=(4, 8), fontsize=9)
ax.annotate(r"$x_2$", (x2, 0.0), textcoords="offset points", xytext=(-6, -14), fontsize=9)
ax.set_xlim(1.0, 2.0)
ax.set_ylim(-1.6, 6.4)
ax.set_xlabel(r"$x$")
ax.set_ylabel(r"$f(x)$")
ax.set_title(r"(b) Newton: follow the tangent", fontsize=10, loc="left")

# (c) secant chord
ax = axes[1, 0]
ax.plot(GRID, F(GRID), color=BLUE, linewidth=2.0)
ax.axhline(0.0, color="black", linewidth=0.8)
ax.axvline(ROOT, color=GRAY, linewidth=1.0, linestyle=":")
x0, x1 = 2.0, 1.5
x2 = x1 - F(x1) * (x1 - x0) / (F(x1) - F(x0))
xs = np.array([x2, x0])
ax.plot(xs, F(x1) + (F(x1) - F(x0)) / (x1 - x0) * (xs - x1),
        color=RED, linewidth=1.2, linestyle="--")
for xk in (x0, x1):
    ax.plot(xk, F(xk), marker="o", markersize=4.0, color="black")
ax.plot(x2, 0.0, marker="o", markersize=5.0, color=RED)
ax.annotate(r"$x_0$", (x0, F(x0)), textcoords="offset points", xytext=(-18, 4), fontsize=9)
ax.annotate(r"$x_1$", (x1, F(x1)), textcoords="offset points", xytext=(4, 4), fontsize=9)
ax.annotate(r"$x_2$", (x2, 0.0), textcoords="offset points", xytext=(-6, -14), fontsize=9)
ax.set_xlim(1.0, 2.0)
ax.set_ylim(-1.6, 6.4)
ax.set_xlabel(r"$x$")
ax.set_ylabel(r"$f(x)$")
ax.set_title(r"(c) secant: follow the chord", fontsize=10, loc="left")

# (d) errors
ax = axes[1, 1]
err_b = [abs(m - ROOT) for m in mids]
err_b.append(abs(0.5 * (brackets[-1][0] + brackets[-1][1]) - ROOT))
bound_b = [1.0 / 2.0 ** (k + 1) for k in range(len(err_b))]
err_n = [abs(x - ROOT) for x in newton]
err_s = [abs(x - ROOT) for x in secant]
err_b = np.maximum(err_b, 1e-16)
err_n = np.maximum(err_n, 1e-16)
err_s = np.maximum(err_s, 1e-16)
ax.semilogy(range(len(bound_b)), bound_b, color=GRAY, linewidth=1.0, linestyle="--",
            label="bisection bound")
ax.semilogy(range(len(err_b)), err_b, color=GRAY, marker="s", markersize=4.0,
            linewidth=1.4, label="bisection")
ax.semilogy(range(len(err_n)), err_n, color=BLUE, marker="o", markersize=4.0,
            linewidth=1.6, label="Newton")
ax.semilogy(range(len(err_s)), err_s, color=RED, marker="^", markersize=4.0,
            linewidth=1.4, label="secant")
ax.set_xlabel(r"iteration $k$")
ax.set_ylabel("error")
ax.set_title(r"(d) error vs iteration", fontsize=10, loc="left")
ax.legend(fontsize=8, loc="upper right", frameon=False)
ax.grid(True, which="major", color="0.9", linewidth=0.6)

fig.tight_layout()
fig.savefig(OUT, format="svg")
fig.savefig(PREVIEW, format="png", dpi=140)
plt.close(fig)

print("root %.15f" % ROOT)
print("brackets", brackets)
print("newton errors", ["%.2e" % e for e in err_n])
print("secant errors", ["%.2e" % e for e in err_s])
