"""Conformality: a square grid in the z-plane and its image under f(z) = exp(z).

Panel (a): the z-plane with a rectangular grid and two tangent vectors at
z0 = 0.30 + 0.20i (one along the x-axis, one at 60 degrees).
Panel (b): the w-plane with the images of the grid lines (vertical lines
become rays, horizontal lines become circular arcs centred at the origin),
the images of the two tangent vectors, and the preserved angle.

Mathematical check: f'(z) = exp(z/2)/2, so at z0 = 0.30 + 0.20i the
differential is the similarity rho = exp(0.15)/2 = 0.58092 with rotation
angle phi = 0.10 rad; the script verifies both numerically.

Run from the repository root:  uv run "1.Analyse/Analyse Complexe/scripts/conformal-local-grid.py"
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

Z0 = 0.30 + 0.20j


def f(z):
    return np.exp(z)


def fp(z):
    return np.exp(z)


def build_figure():
    fig = SPEC.figure()
    fig.set_size_inches(11.0, 5.2)
    ax1 = fig.add_subplot(121)
    ax2 = fig.add_subplot(122)

    # ---------------- panel (a): z-plane grid ---------------- #
    xs = np.linspace(-1.1, 1.1, 5)
    ys = np.linspace(-1.1, 1.1, 5)
    for x in xs:
        ax1.plot([x, x], [-1.1, 1.1], color=GRY, lw=0.7, alpha=0.75)
    for y in ys:
        ax1.plot([-1.1, 1.1], [y, y], color=GRY, lw=0.7, alpha=0.75)

    ax1.axhline(0, color=DARK, lw=0.8, alpha=0.55)
    ax1.axvline(0, color=DARK, lw=0.8, alpha=0.55)
    ax1.set_xlim(-1.35, 1.35)
    ax1.set_ylim(-1.35, 1.35)
    ax1.set_aspect("equal")
    ax1.set_xlabel("Re z", fontsize=10, color=GRY)
    ax1.set_ylabel("Im z", fontsize=10, color=GRY)
    ax1.set_title("(a) $z$-plane: grid and tangent vectors at $z_0$",
                  fontsize=11, color=DARK)

    # tangent vectors at z0: directions 0 and pi/3
    angles = [0.0, np.pi / 3.0]
    for a_ in angles:
        v = 0.42 * np.exp(1j * a_)
        ax1.annotate("", xy=(Z0.real + v.real, Z0.imag + v.imag),
                     xytext=(Z0.real, Z0.imag),
                     arrowprops=dict(arrowstyle="-|>", color=BLUE, lw=1.8,
                                     mutation_scale=14))
    ax1.plot(Z0.real, Z0.imag, "o", color=RED, ms=6, zorder=6)
    ax1.annotate("$z_0$", xy=(Z0.real, Z0.imag), xytext=(-16, -16),
                 textcoords="offset points", fontsize=10, color=RED)

    # ---------------- panel (b): w-plane ---------------- #
    for x in xs:
        # vertical line Re z = x, Im z in [-1.1, 1.1] -> ray at angle Im/2
        t = np.linspace(-1.1, 1.1, 400)
        w = f(x + 1j * t)
        ax2.plot(w.real, w.imag, color=GRY, lw=0.7, alpha=0.75)
    for y in ys:
        s = np.linspace(-1.1, 1.1, 400)
        w = f(s + 1j * y)
        ax2.plot(w.real, w.imag, color=GRY, lw=0.7, alpha=0.75)

    ax2.axhline(0, color=DARK, lw=0.8, alpha=0.55)
    ax2.axvline(0, color=DARK, lw=0.8, alpha=0.55)
    ax2.set_xlim(-2.6, 2.6)
    ax2.set_ylim(-2.6, 2.6)
    ax2.set_aspect("equal")
    ax2.set_xlabel("Re w", fontsize=10, color=GRY)
    ax2.set_ylabel("Im w", fontsize=10, color=GRY)
    ax2.set_title("(b) $w$-plane: $w = e^{z}$, angles preserved",
                  fontsize=11, color=DARK)

    w0 = f(Z0)
    d = fp(Z0)
    for a_ in angles:
        v = d * (0.42 * np.exp(1j * a_))
        ax2.annotate("", xy=(w0.real + v.real, w0.imag + v.imag),
                     xytext=(w0.real, w0.imag),
                     arrowprops=dict(arrowstyle="-|>", color=BLUE, lw=1.8,
                                     mutation_scale=14))
    ax2.plot(w0.real, w0.imag, "o", color=RED, ms=6, zorder=6)
    ax2.annotate("$f(z_0)$", xy=(w0.real, w0.imag), xytext=(-14, -16),
                 textcoords="offset points", fontsize=10, color=RED)

    ax2.text(0.0, 2.32,
             r"$f'(z_0)=\rho e^{i\varphi},\quad \rho=e^{0.30}=%.5f,"
             r"\quad \varphi=0.20$" % abs(d),
             fontsize=10.5, ha="center", color=DARK)
    ax2.text(0.0, -2.42,
             r"grid bends, but the angle between the vectors is unchanged",
             fontsize=10, ha="center", color=BLUE)

    fig.tight_layout()
    return fig


def main():
    # --- mathematical verification --- #
    d = fp(Z0)
    assert abs(abs(d) - np.exp(0.30)) < 1e-12, "scale factor wrong"
    assert abs(np.angle(d) - 0.20) < 1e-12, "rotation angle wrong"
    # conformality: the map preserves angles, so the image of a small disc
    # is a disc of radius |f'(z0)| * r to first order
    r = 1e-5
    assert abs(abs(f(Z0 + r) - f(Z0)) - abs(d) * r) < 1e-9, "local scale wrong"

    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "conformal-local-grid")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
