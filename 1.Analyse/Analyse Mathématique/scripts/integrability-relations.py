"""Implication diagram between integrability, absolute and square integrability.

Each panel has three nodes f(x), f^2(x), |f(x)| joined by pairs of arrows, one
per direction of the implication.  A red cross marks a direction that fails in
general (a counterexample exists):

  * Riemann integral  : |f| => f and f^2 => f fail;
  * infinite integral : f => |f|, and both directions between f and f^2 and
                        between f^2 and |f| fail;
  * defective integral: f => |f|, f => f^2 and |f| => f^2 fail, while
                        f^2 => |f| holds.

Output: img/integrability-relations.svg
"""

from __future__ import annotations

import os
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

OUT = (Path(__file__).resolve().parent.parent / "img"
       / "integrability-relations.svg")

INK = "#1f2933"
CROSS = "#e03131"

F_POS = np.array([0.12, 0.80])       # f(x)
ABS_POS = np.array([0.88, 0.80])     # |f(x)|
SQ_POS = np.array([0.50, 0.16])      # f^2(x)


def pair(ax, p, q, offset=0.035, pad=0.11, cross=()):
    """Two anti-parallel arrows between p and q; `cross` lists failing dirs."""
    d = q - p
    length = np.linalg.norm(d)
    u = d / length
    n = np.array([-u[1], u[0]]) * offset

    a, b = p + u * pad + n, q - u * pad + n       # forward lane
    c, e = q - u * pad - n, p + u * pad - n       # backward lane

    ax.annotate("", xy=b, xytext=a,
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.0,
                                shrinkA=0, shrinkB=0, mutation_scale=9))
    ax.annotate("", xy=e, xytext=c,
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.0,
                                shrinkA=0, shrinkB=0, mutation_scale=9))

    if "fwd" in cross:
        ax.plot(*((a + b) / 2), marker="x", color=CROSS, ms=9, mew=2.4,
                zorder=5)
    if "bwd" in cross:
        ax.plot(*((c + e) / 2), marker="x", color=CROSS, ms=9, mew=2.4,
                zorder=5)


def panel(ax, title, cross_abs, cross_sq, cross_abs_sq):
    ax.set_xlim(-0.03, 1.03)
    ax.set_ylim(-0.14, 1.04)
    ax.set_aspect("equal")
    ax.axis("off")

    # Nodes.
    ax.text(*F_POS, r"$f(x)$", fontsize=14, color=INK, ha="center",
            va="center")
    ax.text(*ABS_POS, r"$|f(x)|$", fontsize=14, color=INK, ha="center",
            va="center")
    ax.text(*SQ_POS, r"$f^2(x)$", fontsize=14, color=INK, ha="center",
            va="center")

    # f(x) <-> |f(x)| along the top.
    pair(ax, F_POS, ABS_POS, cross=cross_abs)
    # f(x) <-> f^2(x) along the lower left.
    pair(ax, F_POS, SQ_POS, cross=cross_sq)
    # f^2(x) <-> |f(x)| along the lower right.
    pair(ax, SQ_POS, ABS_POS, cross=cross_abs_sq)

    ax.text(0.5, -0.10, title, fontsize=11, color=INK, ha="center", va="top")


def main():
    fig = plt.figure(figsize=(10.8, 3.6))

    ax1 = fig.add_subplot(1, 3, 1)
    panel(ax1, "Riemann integral", cross_abs=("bwd",), cross_sq=("bwd",),
          cross_abs_sq=())

    ax2 = fig.add_subplot(1, 3, 2)
    panel(ax2, "Infinite integral", cross_abs=("fwd",),
          cross_sq=("fwd", "bwd"), cross_abs_sq=("fwd", "bwd"))

    ax3 = fig.add_subplot(1, 3, 3)
    panel(ax3, "Defective integral", cross_abs=("fwd",), cross_sq=("fwd",),
          cross_abs_sq=("bwd",))

    fig.subplots_adjust(left=0.01, right=0.99, top=0.97, bottom=0.06,
                        wspace=0.05)
    fig.savefig(OUT, transparent=True, bbox_inches="tight", pad_inches=0.02)
    print(f"Saved: {OUT}")

    if os.environ.get("PREVIEW"):
        preview = OUT.with_name("integrability-relations-preview.png")
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.02)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
