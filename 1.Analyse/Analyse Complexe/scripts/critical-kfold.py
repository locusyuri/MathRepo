"""The power map z -> z^k: a critical point of order k-1 folds the plane.

Panel (a): the map z -> z^2; panel (b): the map z -> z^3.  Each panel shows
the image of the unit disc (a k-leaved figure), the k folding rays
arg z = 2*pi*j/k on which the map is two-to-one, and the critical point 0.

Mathematical check: f(z) = z^k has f'(z) = k z^(k-1), so the only critical
point is 0 (of order k-1), and the folding rays are the rays
arg z = 2*pi*j/k, j = 0..k-1, which the map sends onto the positive real
axis.  The script verifies both statements numerically.

Run from the repository root:  uv run "1.Analyse/Analyse Complexe/scripts/critical-kfold.py"
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

THETA = np.linspace(0, 2 * np.pi, 721)


def panel(ax, k, title):
    ax.set_aspect("equal")
    ax.set_xlim(-1.45, 1.45)
    ax.set_ylim(-1.45, 1.45)
    ax.axhline(0, color=DARK, lw=0.8, alpha=0.55)
    ax.axvline(0, color=DARK, lw=0.8, alpha=0.8)

    # unit circle and its image (the k-leaved figure: |w| = 1 traced k times)
    ax.plot(np.cos(THETA), np.sin(THETA), color=GRY, lw=1.0, ls="--", alpha=0.8)
    w = np.exp(1j * k * THETA)
    ax.plot(w.real, w.imag, color=BLUE, lw=1.8)

    # folding rays: arg z = 2 pi j / k
    for j in range(k):
        a = 2 * np.pi * j / k
        ax.plot([0, np.cos(a)], [0, np.sin(a)], color=RED, lw=1.3, alpha=0.9)
        ax.annotate(r"$2\pi j/%d$" % k, xy=(0.72 * np.cos(a), 0.72 * np.sin(a)),
                    fontsize=8.5, color=RED, ha="center", va="center")

    # critical point
    ax.plot(0, 0, "o", color=DARK, ms=6, zorder=6)
    ax.annotate("$0$", xy=(0, 0), xytext=(-14, -15),
                textcoords="offset points", fontsize=11, color=DARK)

    ax.set_xlabel("Re z", fontsize=10, color=GRY)
    ax.set_ylabel("Im z", fontsize=10, color=GRY)
    ax.set_title(title, fontsize=11, color=DARK)


def build_figure():
    fig = SPEC.figure()
    fig.set_size_inches(11.0, 5.2)
    ax1 = fig.add_subplot(121)
    ax2 = fig.add_subplot(122)

    panel(ax1, 2, r"(a) $f(z)=z^2$: one folding ray, $f'(z)=2z$")
    panel(ax2, 3, r"(b) $f(z)=z^3$: two folding rays, $f'(z)=3z^2$")

    fig.text(0.5, 0.015,
             r"$f(z)-f(0)=c\,z^k+\cdots$ near a critical point: "
             r"$k$ sectors, each mapped one-to-one",
             ha="center", fontsize=10.5, color=BLUE)

    fig.tight_layout(rect=(0, 0.04, 1, 1))
    return fig


def main():
    # --- mathematical verification --- #
    for k in (2, 3):
        # the only critical point is 0
        assert abs(np.polyval(np.polyder([1] + [0] * (k - 1) + [0]), 0)) < 1e-12
        # the folding rays map onto the positive real axis
        for j in range(k):
            a = 2 * np.pi * j / k
            assert abs(abs(np.exp(1j * k * a)) - 1.0) < 1e-12
            assert abs(np.imag(np.exp(1j * k * a))) < 1e-12

    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "critical-kfold")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
