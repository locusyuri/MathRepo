"""Two analytic branches of the complex square root function.

Two stacked panels, each showing:
  Left  — z-plane with branch cut on negative real axis, sample points z₁, z₂
  Right — w-plane showing the mapped values under that branch

Top panel: principal branch f₊(z) = √r · e^(iθ/2),  θ ∈ (-π, π]
Bottom panel: second branch f₋(z) = -f₊(z)

Arrows crossing the branch cut illustrate branch switching.

Run with: uv run python src/math_paper/sqrt_branches.py
"""

from __future__ import annotations

from pathlib import Path
import sys

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = Presets.SVG_TEXTBOOK
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

# --------------------------------------------------------------------------- #
# Geometry
# --------------------------------------------------------------------------- #
R = 1.6
EPS = 0.18
BLU = "#1f4e9b"
ORG = "#e67e22"
GRY = "#888888"

z1 = R * np.exp(1j * (np.pi - EPS))       # just above neg. real axis
z2 = R * np.exp(1j * (-np.pi + EPS))      # just below neg. real axis

w1 = np.sqrt(R) * np.exp(1j * (np.pi - EPS) / 2)    # f₊(z₁) ≈ i√r
w2 = np.sqrt(R) * np.exp(1j * (-np.pi + EPS) / 2)   # f₊(z₂) ≈ -i√r


def draw_plane(ax, plane: str, z1_val, z2_val, w1_val, w2_val,
               label: str, z1_c, z2_c):
    """Draw one complex-plane panel (z-plane or w-plane)."""
    ax.set_aspect("equal")
    ax.axhline(0, color=GRY, lw=0.5, alpha=0.5)
    ax.axvline(0, color=GRY, lw=0.5, alpha=0.5)

    # Branch cut (bold segment on negative real axis)
    ax.plot([-3.2, 0], [0, 0], color="#333333", lw=3.0,
            solid_capstyle="round", zorder=3)

    if plane == "z":
        ax.plot(z1_val.real, z1_val.imag, "o", color=z1_c, ms=10,
                mec="white", mew=1.5, zorder=5)
        ax.annotate("$z_1$", xy=(z1_val.real, z1_val.imag),
                    xytext=(10, 10), textcoords="offset points",
                    fontsize=12, color=z1_c, fontweight="bold")
        ax.plot(z2_val.real, z2_val.imag, "o", color=z2_c, ms=10,
                mec="white", mew=1.5, zorder=5)
        ax.annotate("$z_2$", xy=(z2_val.real, z2_val.imag),
                    xytext=(10, -14), textcoords="offset points",
                    fontsize=12, color=z2_c, fontweight="bold")
        ax.text(-1.6, -0.42, "branch cut", fontsize=9, color="#333333",
                ha="center", style="italic")
        ax.set_title(label, fontsize=12, fontweight="bold", pad=10)
        ax.set_xlabel("Re z", fontsize=10)
        ax.set_ylabel("Im z", fontsize=10)
        ax.set_xlim(-3.2, 3.2)
        ax.set_ylim(-3.2, 3.2)
    else:
        ax.plot(w1_val.real, w1_val.imag, "o", color=z1_c, ms=10,
                mec="white", mew=1.5, zorder=5)
        ax.annotate("$w_1$", xy=(w1_val.real, w1_val.imag),
                    xytext=(10, 10), textcoords="offset points",
                    fontsize=12, color=z1_c, fontweight="bold")
        ax.plot(w2_val.real, w2_val.imag, "o", color=z2_c, ms=10,
                mec="white", mew=1.5, zorder=5)
        ax.annotate("$w_2$", xy=(w2_val.real, w2_val.imag),
                    xytext=(10, -14), textcoords="offset points",
                    fontsize=12, color=z2_c, fontweight="bold")
        ax.set_title(label, fontsize=12, fontweight="bold", pad=10)
        ax.set_xlabel("Re w", fontsize=10)
        ax.set_ylabel("Im w", fontsize=10)
        ax.set_xlim(-2.5, 2.5)
        ax.set_ylim(-2.5, 2.5)

    ax.grid(True, color="#eeeeee", lw=0.5)


def build_figure():
    fig = SPEC.figure()

    # 2 rows × 2 cols:  z-plane | w-plane
    #  row 0 = f₊,  row 1 = f₋
    ax_zt = fig.add_subplot(2, 2, 1)
    ax_wt = fig.add_subplot(2, 2, 2)
    ax_zb = fig.add_subplot(2, 2, 3)
    ax_wb = fig.add_subplot(2, 2, 4)

    fig.subplots_adjust(left=0.08, right=0.96, top=0.90, bottom=0.08,
                        hspace=0.55, wspace=0.32)

    # ---- Top row: principal branch f₊ ---- #
    draw_plane(ax_zt, "z", z1, z2, w1, w2,
               r"$f_+(z)=\sqrt{r}\,e^{i\theta/2}$", BLU, ORG)
    draw_plane(ax_wt, "w", z1, z2, w1, w2,
               r"$w = f_+(z)$", BLU, ORG)

    # Mapping arrow z → w (top row) — in the gap between columns
    ax_zt.annotate(
        "", xy=(0.485, 0.72), xycoords="figure fraction",
        xytext=(0.335, 0.72), textcoords="figure fraction",
        arrowprops=dict(arrowstyle="-|>", color=GRY, lw=2.5,
                        mutation_scale=25, clip_on=False),
    )
    fig.text(0.495, 0.755, r"$w=\sqrt{z}$", fontsize=11, color=GRY,
             ha="center")

    # ---- Bottom row: second branch f₋ (colors swapped) ---- #
    draw_plane(ax_zb, "z", z1, z2, -w1, -w2,
               r"$f_-(z)=-f_+(z)$", ORG, BLU)
    draw_plane(ax_wb, "w", z1, z2, -w1, -w2,
               r"$w = f_-(z)$", ORG, BLU)

    # Mapping arrow z → w (bottom row) — in the gap between columns
    ax_zt.annotate(
        "", xy=(0.485, 0.27), xycoords="figure fraction",
        xytext=(0.335, 0.27), textcoords="figure fraction",
        arrowprops=dict(arrowstyle="-|>", color=GRY, lw=2.5,
                        mutation_scale=25, clip_on=False),
    )
    fig.text(0.495, 0.305, r"$w=\sqrt{z}$", fontsize=11, color=GRY,
             ha="center")

    # ---- Branch-switching arrows between rows (figure fraction) ---- #
    # Arrow 1: upper-left → lower-left  (cross cut → switch branch)
    ax_zt.annotate(
        "", xy=(0.10, 0.38), xycoords="figure fraction",
        xytext=(0.10, 0.58), textcoords="figure fraction",
        arrowprops=dict(arrowstyle="-|>", color=ORG, lw=2.0,
                        connectionstyle="arc3,rad=0.3"),
    )
    fig.text(0.12, 0.48, "cross cut\n$\\Rightarrow$ switch branch",
             fontsize=8.5, color=ORG, ha="center", va="center",
             style="italic")

    # Arrow 2: upper-right → lower-right  (mapped values swap)
    ax_zt.annotate(
        "", xy=(0.78, 0.38), xycoords="figure fraction",
        xytext=(0.78, 0.58), textcoords="figure fraction",
        arrowprops=dict(arrowstyle="-|>", color=ORG, lw=2.0,
                        connectionstyle="arc3,rad=-0.3"),
    )
    fig.text(0.90, 0.48, "$w_1 \\leftrightarrow w_2$",
             fontsize=10, color=ORG, ha="center", va="center",
             fontweight="bold")

    # ---- Bottom annotation ---- #
    fig.text(0.50, 0.01,
             "0 and $\\infty$ are algebraic branch points of order 2",
             fontsize=11, ha="center", va="bottom", style="italic",
             color="#444444")

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "sqrt-branches")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
