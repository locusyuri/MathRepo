"""Contour deformation (CIF) — Cauchy integral formula keyhole argument.

Outer contour C₁, inner circle C₂ around z₀, annular region shaded,
crosscuts with cancelling arrows.

Run with: uv run python src/math_paper/cif_deformation.py
"""

from __future__ import annotations

from pathlib import Path
import sys

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import OutputSpec

OUT_DIR = Path(__file__).resolve().parent.parent / "img"

SPEC = OutputSpec(
    figsize=(10.0, 8.0), fmt="svg", pad_inches=0.05,
    transparent=False, facecolor="white",
)

BLU = "#1f4e9b"
RED = "#c0392b"
GRY = "#888888"


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)
    ax.set_aspect("equal")

    # ---- Axis setup ---- #
    ax.axhline(0, color=GRY, lw=0.5, alpha=0.6)
    ax.axvline(0, color=GRY, lw=0.5, alpha=0.6)
    ax.set_xlim(-4.0, 4.0)
    ax.set_ylim(-3.5, 3.5)
    ax.set_xlabel("x", fontsize=12, color=GRY)
    ax.set_ylabel("y", fontsize=12, color=GRY)

    # Origin marker
    ax.plot(0, 0, "o", color="#333333", ms=4, zorder=5)

    # ---- Outer contour C₁ (irregular, simply closed) ---- #
    t1 = np.linspace(0, 2 * np.pi, 400, endpoint=False)
    r_out = 2.8 + 0.4 * np.sin(3 * t1) + 0.2 * np.cos(5 * t1)
    c1_x = r_out * np.cos(t1)
    c1_y = r_out * np.sin(t1)
    ax.plot(np.append(c1_x, c1_x[0]), np.append(c1_y, c1_y[0]),
            color=BLU, lw=2.2, zorder=5)

    # CCW arrow on C₁ (upper-right)
    idx1 = 100  # ~upper-right region
    ax.annotate("", xy=(c1_x[idx1 + 5], c1_y[idx1 + 5]),
                xytext=(c1_x[idx1 - 5], c1_y[idx1 - 5]),
                xycoords="data", textcoords="data",
                arrowprops=dict(arrowstyle="-|>", color=BLU, lw=2.2,
                                mutation_scale=20))
    ax.text(c1_x[60] + 0.3, c1_y[60] + 0.3, "$C_1$", fontsize=14,
            color=BLU, fontweight="bold")

    # ---- Inner circle C₂ ---- #
    z0_x, z0_y = 0.0, 0.0
    r_c2 = 1.0
    t2 = np.linspace(0, 2 * np.pi, 200, endpoint=False)
    c2_x = z0_x + r_c2 * np.cos(t2)
    c2_y = z0_y + r_c2 * np.sin(t2)
    ax.plot(np.append(c2_x, c2_x[0]), np.append(c2_y, c2_y[0]),
            color=BLU, lw=2.2, zorder=5)

    # CCW arrow on C₂
    ax.annotate("", xy=(c2_x[55], c2_y[55]),
                xytext=(c2_x[45], c2_y[45]),
                xycoords="data", textcoords="data",
                arrowprops=dict(arrowstyle="-|>", color=BLU, lw=2.2,
                                mutation_scale=18))
    ax.text(z0_x + 0.15, z0_y + r_c2 + 0.25,
            "$C_2$: $|z - z_0| = r$", fontsize=11, color=BLU,
            fontweight="bold", ha="center")

    # ---- z₀ point ---- #
    ax.plot(z0_x, z0_y, "o", color=RED, ms=8, zorder=10)
    ax.annotate("$z_0$", xy=(z0_x, z0_y), xytext=(-14, -14),
                textcoords="offset points", fontsize=13, color=RED,
                fontweight="bold")

    # ---- Shaded regions ---- #
    # Annular region (between C1 and C2)
    ax.fill(np.append(c1_x, c1_x[0]), np.append(c1_y, c1_y[0]),
            color=BLU, alpha=0.06, zorder=1)
    ax.fill(np.append(c2_x, c2_x[0]), np.append(c2_y, c2_y[0]),
            color="white", zorder=2)

    # Region inside C₂ slightly darker
    ax.fill(np.append(c2_x, c2_x[0]), np.append(c2_y, c2_y[0]),
            color=BLU, alpha=0.12, zorder=3)

    # ---- Annular region label ---- #
    ax.text(-2.0, 2.0, "annular region", fontsize=10, color="#555555",
            ha="center", style="italic")
    ax.text(-2.0, 1.6, "$f$ analytic here", fontsize=9, color="#555555",
            ha="center", style="italic")

    # ---- Crosscuts ---- #
    # Left crosscut: from C1 left side to C2 left side
    # Find leftmost point of C1 and leftmost of C2
    idx_left_c1 = np.argmin(c1_x)
    idx_left_c2 = np.argmin(c2_x)

    cut_l_start = (c1_x[idx_left_c1], c1_y[idx_left_c1])
    cut_l_end = (c2_x[idx_left_c2], c2_y[idx_left_c2])
    ax.plot([cut_l_start[0], cut_l_end[0]],
            [cut_l_start[1], cut_l_end[1]],
            color="#333333", lw=1.5, zorder=6)

    # Paired opposite arrows on left crosscut
    mid_l = np.array([(cut_l_start[0] + cut_l_end[0]) / 2,
                      (cut_l_start[1] + cut_l_end[1]) / 2])
    dir_l = np.array([cut_l_end[0] - cut_l_start[0],
                      cut_l_end[1] - cut_l_start[1]])
    dir_l = dir_l / np.linalg.norm(dir_l)
    perp_l = np.array([-dir_l[1], dir_l[0]])

    arr = 0.15
    ax.annotate("", xy=mid_l + dir_l * arr + perp_l * 0.08,
                xytext=mid_l - dir_l * arr + perp_l * 0.08,
                xycoords="data", textcoords="data",
                arrowprops=dict(arrowstyle="-|>", color="#333333", lw=1.2,
                                mutation_scale=10))
    ax.annotate("", xy=mid_l - dir_l * arr - perp_l * 0.08,
                xytext=mid_l + dir_l * arr - perp_l * 0.08,
                xycoords="data", textcoords="data",
                arrowprops=dict(arrowstyle="-|>", color="#333333", lw=1.2,
                                mutation_scale=10))
    ax.text(mid_l[0] - 0.5, mid_l[1] + 0.15,
            "crosscut\n(cancels)", fontsize=8, color="#333333",
            ha="center", style="italic")

    # Right crosscut
    idx_right_c1 = np.argmax(c1_x)
    idx_right_c2 = np.argmax(c2_x)

    cut_r_start = (c1_x[idx_right_c1], c1_y[idx_right_c1])
    cut_r_end = (c2_x[idx_right_c2], c2_y[idx_right_c2])
    ax.plot([cut_r_start[0], cut_r_end[0]],
            [cut_r_start[1], cut_r_end[1]],
            color="#333333", lw=1.5, zorder=6)

    mid_r = np.array([(cut_r_start[0] + cut_r_end[0]) / 2,
                      (cut_r_start[1] + cut_r_end[1]) / 2])
    dir_r = np.array([cut_r_end[0] - cut_r_start[0],
                      cut_r_end[1] - cut_r_start[1]])
    dir_r = dir_r / np.linalg.norm(dir_r)
    perp_r = np.array([-dir_r[1], dir_r[0]])

    ax.annotate("", xy=mid_r + dir_r * arr + perp_r * 0.08,
                xytext=mid_r - dir_r * arr + perp_r * 0.08,
                xycoords="data", textcoords="data",
                arrowprops=dict(arrowstyle="-|>", color="#333333", lw=1.2,
                                mutation_scale=10))
    ax.annotate("", xy=mid_r - dir_r * arr - perp_r * 0.08,
                xytext=mid_r + dir_r * arr - perp_r * 0.08,
                xycoords="data", textcoords="data",
                arrowprops=dict(arrowstyle="-|>", color="#333333", lw=1.2,
                                mutation_scale=10))
    ax.text(mid_r[0] + 0.6, mid_r[1] + 0.15,
            "crosscut\n(cancels)", fontsize=8, color="#333333",
            ha="center", style="italic")

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "cif-deformation")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
