"""Schwarz-Christoffel: the upper half-plane mapped onto a square.

Panel (a): the upper half-plane with the four prevertices on the real axis;
the four arcs of the real line cut out by them are coloured, each arc being
carried to one side of the square (the fourth arc passes through the point
at infinity of the real line).
Panel (b): the image square, with the four vertices labelled and the point
that is the image of infinity marked on the fourth side.

The map is the Schwarz-Christoffel map of the square,
    f'(z) = C * prod_{k=1..4} (z - x_k)^(-1/2),
with prevertices x = (-1/r, -r, r, 1/r) and r = sqrt(2) - 1; the branch of
(z - x_k)^(-1/2) is taken with arg(z - x_k) in (0, pi) in the upper half
plane.  The image of the real line is integrated numerically on a mesh
graded at the prevertices; the script checks that the four image points
form a square with right angles.

Run from the repository root:  uv run "1.Analyse/Analyse Complexe/scripts/schwarz-christoffel-polygon.py"
"""

from __future__ import annotations

from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = Presets.SVG_MATH
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

GRY = "#888888"
DARK = "#333333"
BLUE = "#1f4e9b"
RED = "#c0392b"
ORANGE = "#d35400"
GREEN = "#2e8b57"
PURPLE = "#8e44ad"

R_PREF = np.sqrt(2.0) - 1.0
XP = np.array([-1.0 / R_PREF, -R_PREF, R_PREF, 1.0 / R_PREF])
T_FAR = 40.0
COLS = [BLUE, ORANGE, GREEN, PURPLE]


def fp(t):
    """f'(t) on the real axis, approached from the upper half-plane."""
    val = 1.0 + 0.0j
    for xk in XP:
        d = t - xk
        if d > 0:
            val *= d ** -0.5
        else:
            val *= -1j * abs(d) ** -0.5
    return val


def graded(a, b, n=60000):
    """Mesh on [a, b] clustered at both ends (removes the singularity)."""
    u = np.linspace(0.0, 1.0, n)
    s = 3.0 * u ** 2 - 2.0 * u ** 3
    return a + (b - a) * s


def boundary():
    """Numerical image of the real line, from -T_FAR to T_FAR."""
    breaks = [-T_FAR, XP[0], XP[1], XP[2], XP[3], T_FAR]
    pieces = [graded(breaks[k], breaks[k + 1]) for k in range(5)]
    t = np.unique(np.concatenate(pieces))
    vals = np.zeros(len(t), dtype=complex)
    # midpoint rule: the integrand is singular at the prevertices, so it is
    # never evaluated there
    for i in range(1, len(t)):
        mid = 0.5 * (t[i] + t[i - 1])
        vals[i] = vals[i - 1] + fp(mid) * (t[i] - t[i - 1])
    return t, vals


def build_figure():
    t, vals = boundary()
    fig = SPEC.figure()
    fig.set_size_inches(11.0, 5.2)
    ax1 = fig.add_subplot(121)
    ax2 = fig.add_subplot(122)

    # ---------------- panel (a): upper half-plane ---------------- #
    ax1.set_aspect("equal")
    ax1.set_xlim(-3.4, 3.4)
    ax1.set_ylim(-1.6, 2.4)
    ax1.fill_between([-3.4, 3.4], 0, 2.4, color=BLUE, alpha=0.06)
    ax1.axhline(0, color=DARK, lw=1.1)

    for k in range(3):
        seg = np.linspace(XP[k], XP[k + 1], 200)
        ax1.plot(seg, np.zeros_like(seg), color=COLS[k], lw=3.4,
                 solid_capstyle="butt")
    for seg, sign in ((np.linspace(-3.4, XP[0], 200), 1),
                      (np.linspace(XP[3], 3.4, 200), 1)):
        ax1.plot(seg, np.zeros_like(seg), color=COLS[3], lw=3.4,
                 solid_capstyle="butt", ls="--")
    for k in range(4):
        ax1.plot(XP[k], 0, "o", color=COLS[k], ms=7, zorder=6)
        ax1.annotate("$x_%d$" % (k + 1), xy=(XP[k], 0), xytext=(0, -20),
                     textcoords="offset points", fontsize=9.5, color=COLS[k],
                     ha="center")
    ax1.set_xticks([])
    ax1.set_yticks([])
    ax1.set_xlabel("Re z", fontsize=10, color=GRY)
    ax1.set_title("(a) upper half-plane with prevertices $x_1,\\dots,x_4$",
                  fontsize=11, color=DARK)
    ax1.text(-3.3, 1.95, "each arc of the real line maps to one side",
             fontsize=9.5, color=GRY)

    # ---------------- panel (b): the image square ---------------- #
    ax2.set_aspect("equal")
    ax2.plot(vals.real, vals.imag, color=BLUE, lw=1.9)
    idx = [int(np.argmin(np.abs(t - x))) for x in XP]
    V = [vals[i] for i in idx]
    for k, v in enumerate(V):
        ax2.plot(v.real, v.imag, "o", color=RED, ms=6, zorder=6)
        ax2.annotate("$w_%d$" % (k + 1), xy=(v.real, v.imag),
                     xytext=(10, 10), textcoords="offset points",
                     fontsize=10, color=RED)
    inf = vals[0]
    ax2.plot(inf.real, inf.imag, marker="s", ls="none", color=GRY, ms=5,
             zorder=6)
    ax2.annotate("$f(oo)$", xy=(inf.real, inf.imag), xytext=(0, -20),
                 textcoords="offset points", fontsize=9.5, color=GRY,
                 ha="center")
    lim = 1.5 * max(abs(v) for v in V)
    ax2.set_xlim(-lim, lim)
    ax2.set_ylim(-lim, lim)
    ax2.axhline(0, color=GRY, lw=0.6, alpha=0.5)
    ax2.axvline(0, color=GRY, lw=0.6, alpha=0.5)
    ax2.set_xlabel("Re w", fontsize=10, color=GRY)
    ax2.set_ylabel("Im w", fontsize=10, color=GRY)
    ax2.set_title("(b) image square, interior angles $\\alpha_k\\pi=\\pi/2$",
                  fontsize=11, color=DARK)

    fig.tight_layout()
    return fig, V


def main():
    fig, V = build_figure()
    # --- mathematical verification: the image is a square --- #
    side = abs(V[1] - V[0])
    for k in range(4):
        nxt = V[(k + 1) % 4]
        assert abs(abs(nxt - V[k]) - side) < 1e-5 * side, "sides differ"
    for k in range(4):
        u = (V[(k + 1) % 4] - V[k]) / abs(V[(k + 1) % 4] - V[k])
        v = (V[(k + 2) % 4] - V[(k + 1) % 4]) / abs(V[(k + 2) % 4] - V[(k + 1) % 4])
        assert abs(np.real(np.conj(u) * v)) < 1e-5, "not a right angle"
    print("side = %.6f, vertices = %s"
          % (side, ["%.4f%+.4fi" % (v.real, v.imag) for v in V]))

    path = SPEC.save(fig, OUT_DIR / "schwarz-christoffel-polygon")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
