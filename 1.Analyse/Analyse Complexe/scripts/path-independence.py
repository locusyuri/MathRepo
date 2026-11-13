"""Path independence of contour integrals.

Two paths C₁ (upper, blue) and C₂ (lower, red) from a to b,
forming a closed contour C₁ − C₂ enclosing a shaded region.
The return path −C₂ (green dashed) goes from b back to a along C₂ reversed.

Run with: uv run python src/math_paper/path_independence.py
"""

from __future__ import annotations

from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = Presets.SVG_TEXTBOOK
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#1f4e9b"
RED = "#c0392b"
GRN = "#2e8b57"
GRY = "#888888"

# Endpoints
A = np.array([-2.0, 0.0])
B = np.array([2.0, 0.0])


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)
    ax.set_aspect("equal")
    ax.axhline(0, color=GRY, lw=0.5, alpha=0.6)
    ax.axvline(0, color=GRY, lw=0.5, alpha=0.6)
    ax.set_xlim(-3.2, 3.2)
    ax.set_ylim(-2.8, 2.8)
    ax.set_xlabel("Re z", fontsize=10, color=GRY)
    ax.set_ylabel("Im z", fontsize=10, color=GRY)
    ax.grid(True, color="#eeeeee", lw=0.4)

    # Parameter t from 0 to 1
    t = np.linspace(0, 1, 400)

    # C₁: upper path (blue solid), arches upward
    c1_x = A[0] + (B[0] - A[0]) * t
    c1_y = 1.8 * np.sin(np.pi * t)

    # C₂: lower path (red solid), arches downward
    c2_x = A[0] + (B[0] - A[0]) * t
    c2_y = -1.2 * np.sin(np.pi * t)

    # ---- Shaded enclosed region (C₁ above, C₂ below) ---- #
    ax.fill(np.concatenate([c1_x, c2_x[::-1]]),
            np.concatenate([c1_y, c2_y[::-1]]),
            color=BLU, alpha=0.06, zorder=1)

    # ---- Draw C₁ (blue, solid, a → b) ---- #
    ax.plot(c1_x, c1_y, color=BLU, lw=2.2, zorder=3)
    # Arrow on C₁ (midpoint, pointing right-upward)
    mid1 = 200
    ax.annotate("", xy=(c1_x[mid1 + 5], c1_y[mid1 + 5]),
                xytext=(c1_x[mid1 - 5], c1_y[mid1 - 5]),
                xycoords="data", textcoords="data",
                arrowprops=dict(arrowstyle="-|>", color=BLU, lw=2.2,
                                mutation_scale=20))
    # Label C₁
    ax.text(0, c1_y[200] + 0.25, "$C_1$", fontsize=13, color=BLU,
            ha="center", fontweight="bold")

    # ---- Draw C₂ (red, solid, a → b) ---- #
    ax.plot(c2_x, c2_y, color=RED, lw=2.2, zorder=3)
    # Arrow on C₂ (midpoint, pointing right-downward)
    ax.annotate("", xy=(c2_x[mid1 + 5], c2_y[mid1 + 5]),
                xytext=(c2_x[mid1 - 5], c2_y[mid1 - 5]),
                xycoords="data", textcoords="data",
                arrowprops=dict(arrowstyle="-|>", color=RED, lw=2.2,
                                mutation_scale=20))
    # Label C₂
    ax.text(0, c2_y[200] - 0.35, "$C_2$", fontsize=13, color=RED,
            ha="center", fontweight="bold")

    # ---- Draw −C₂ (green dashed, b → a) ---- #
    # Offset slightly below C₂ for visibility
    offset = 0.18
    ax.plot(c2_x[::-1], c2_y[::-1] - offset, color=GRN, lw=1.8,
            ls="--", zorder=4)
    # Arrow on −C₂ (midpoint, pointing left)
    ax.annotate("",
                xy=(c2_x[::-1][mid1 + 5], c2_y[::-1][mid1 + 5] - offset),
                xytext=(c2_x[::-1][mid1 - 5], c2_y[::-1][mid1 - 5] - offset),
                xycoords="data", textcoords="data",
                arrowprops=dict(arrowstyle="-|>", color=GRN, lw=2.0,
                                mutation_scale=18))
    # Label −C₂
    ax.text(0, c2_y[200] - 0.35 - offset - 0.3, "$-C_2$",
            fontsize=12, color=GRN, ha="center", fontweight="bold")

    # ---- Endpoints a and b ---- #
    ax.plot(*A, "o", color="#333333", ms=7, zorder=6)
    ax.annotate("$a$", xy=A, xytext=(-12, -14), textcoords="offset points",
                fontsize=14, fontweight="bold", color="#333333")
    ax.plot(*B, "o", color="#333333", ms=7, zorder=6)
    ax.annotate("$b$", xy=B, xytext=(8, -14), textcoords="offset points",
                fontsize=14, fontweight="bold", color="#333333")

    # ---- Enclosed region label ---- #
    ax.text(0, 0.15, "closed contour\n$C_1 - C_2$",
            fontsize=10, ha="center", va="center", color="#555555",
            style="italic")

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "path-independence")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
