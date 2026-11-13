"""Electric field and potential of concentric spherical shells.

Two-panel physics-textbook illustration (serif, line-art style), side by side:
  * Left:  two concentric dashed shells with radial E arrows in each region.
  * Right: piecewise E(r) and V(r) curves vs. distance, with dual y-axes.

Run with:    uv run python src/concentric_shells.py
"""

from __future__ import annotations

import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.lines import Line2D
from matplotlib.patches import Circle, FancyArrowPatch

# 添加 src/ 到 sys.path，以便从 src/_viz 导入
sys.path.insert(0, str(Path(__file__).resolve().parent))

from _viz import Presets

# --------------------------------------------------------------------------- #
# Physical constants & scene
# --------------------------------------------------------------------------- #
K = 9.0e9
Q_A = 1.0e-9       # inner shell charge
Q_B = 1.0e-9       # outer shell charge
A = 1.0             # inner radius, m
B = 2.0             # outer radius, m

RED = "#c0392b"
BLU = "#1f4e9b"
BLU_SHELL = "#2e6cb5"   # outer shell circle colour
GRN = "#2e8b57"
GREY = "#888888"

SPEC = Presets.PNG_TEXTBOOK
OUT_DIR = Path(__file__).resolve().parent.parent / "img"


# --------------------------------------------------------------------------- #
# Left panel — concentric shells model
# --------------------------------------------------------------------------- #
def draw_model(ax):
    ax.set_aspect("equal")
    ax.set_axis_off()
    ax.set_xlim(-5.5, 5.5)
    ax.set_ylim(-5.5, 5.5)

    ax.set_title("Model of Concentric Spherical Shells",
                 fontsize=12, pad=8)

    # Centre "O".
    ax.scatter([0], [0], s=18, color="k", zorder=5)
    ax.text(0.12, -0.22, "O", fontsize=11, zorder=5)

    # Inner shell (red dashed circle, radius a).
    theta = np.linspace(0, 2 * np.pi, 300)
    ax.plot(A * np.cos(theta), A * np.sin(theta),
            color=RED, ls="--", lw=2.0, zorder=4)

    # Outer shell (blue dashed circle, radius b).
    ax.plot(B * np.cos(theta), B * np.sin(theta),
            color=BLU_SHELL, ls="--", lw=2.0, zorder=4)

    # Labels "r = a" and "r = b".
    ax.text(A + 0.08, -0.30, r"$r = a$", fontsize=10, color=RED, style="italic")
    ax.text(B + 0.08, -0.30, r"$r = b$", fontsize=10,
            color=BLU_SHELL, style="italic")

    # Charge labels.
    ax.text(-0.25, A + 0.15, r"$Q_a$", fontsize=10, color=RED, fontweight="bold")
    ax.text(-0.25, B + 0.15, r"$Q_b$", fontsize=10,
            color=BLU_SHELL, fontweight="bold")

    # --- Region I (r < a): E = 0 — small × marks ---
    for i in range(5):
        a_angle = np.pi / 6 + i * np.pi / 3
        r_pos = A * 0.5
        x, y = r_pos * np.cos(a_angle), r_pos * np.sin(a_angle)
        d = 0.12
        ax.plot([x - d, x + d], [y - d, y + d], color=GREY, lw=1.0, zorder=3)
        ax.plot([x - d, x + d], [y + d, y - d], color=GREY, lw=1.0, zorder=3)
    ax.text(0, 0, r"$E = 0$", ha="center", va="center",
            fontsize=9, color=GREY, zorder=6,
            bbox=dict(fc="white", ec="none", pad=1, alpha=0.8))

    # --- Region II (a < r < b): E = kQ_a/r², arrows length ∝ 1/r ---
    n_arrows = 8
    for i in range(n_arrows):
        a_angle = 2 * np.pi * i / n_arrows
        dx, dy = np.cos(a_angle), np.sin(a_angle)
        r_start = A + 0.15
        # arrow length proportional to 1/r at midpoint
        r_mid = (A + B) / 2
        frac = A / r_mid                     # relative length
        length = (B - A - 0.3) * frac * 0.8  # scale to fit region
        ax.add_patch(FancyArrowPatch(
            (r_start * dx, r_start * dy),
            ((r_start + length) * dx, (r_start + length) * dy),
            arrowstyle="-|>", mutation_scale=10, color=BLU, lw=1.6, zorder=3,
        ))

    # --- Region III (r > b): E = k(Q_a+Q_b)/r², arrows ---
    for i in range(10):
        a_angle = 2 * np.pi * i / 10
        dx, dy = np.cos(a_angle), np.sin(a_angle)
        r_start = B + 0.15
        r_mid = (B + 4.5) / 2
        frac = B / r_mid
        length = (4.5 - B) * frac * 0.6
        ax.add_patch(FancyArrowPatch(
            (r_start * dx, r_start * dy),
            ((r_start + length) * dx, (r_start + length) * dy),
            arrowstyle="-|>", mutation_scale=10, color=BLU, lw=1.6, zorder=3,
        ))

    # Legend (lower-right).
    handles = [
        Line2D([0], [0], color=RED, ls="--", lw=2.0,
               label="Inner shell ($Q_a$, radius $a$)"),
        Line2D([0], [0], color=BLU_SHELL, ls="--", lw=2.0,
               label="Outer shell ($Q_b$, radius $b$)"),
        Line2D([0], [0], color=BLU, lw=2.0, marker=">",
               markersize=7, label="E (Field Vector)"),
    ]
    ax.legend(handles=handles, loc="lower right", fontsize=8,
              frameon=True, edgecolor="#cccccc", facecolor="white",
              framealpha=0.9)


# --------------------------------------------------------------------------- #
# Right panel — piecewise E(r) and V(r) with dual y-axes
# --------------------------------------------------------------------------- #
def draw_curves(ax_e, ax_v):
    ax_e.set_title("Electric Field and Potential of Concentric Spherical Shells",
                   fontsize=11, pad=8)

    r1 = np.linspace(0, A, 200)
    r2 = np.linspace(A, B, 300)
    r3 = np.linspace(B, 4 * B, 400)

    # --- E(r) ---
    E1 = np.zeros_like(r1)
    E2 = K * Q_A / r2 ** 2
    E3 = K * (Q_A + Q_B) / r3 ** 2

    ax_e.plot(r1, E1, color=BLU, lw=2.8)
    ax_e.plot(r2, E2, color=BLU, lw=2.8)
    ax_e.plot(r3, E3, color=BLU, lw=2.8, label=r"$E(r)$")

    # --- V(r) ---
    V1 = np.full_like(r1, K * Q_A / A + K * Q_B / B)
    V2 = K * Q_A / r2 + K * Q_B / B
    V3 = K * (Q_A + Q_B) / r3

    ax_v.plot(r1, V1, color=GRN, lw=2.8)
    ax_v.plot(r2, V2, color=GRN, lw=2.8)
    ax_v.plot(r3, V3, color=GRN, lw=2.8, label=r"$V(r)$")

    # --- Shared x-axis ---
    ax_e.set_xlim(0, 4 * B)
    ax_e.set_xlabel("Distance r (m)", fontsize=10)
    ax_e.set_xticks(np.arange(0, 4 * B + 0.01, 1.0))

    # --- Left y-axis: E ---
    ax_e.set_ylim(0, 10)
    ax_e.set_ylabel("E (N/C)", fontsize=10, color=BLU)
    ax_e.set_yticks(np.arange(0, 11, 2))
    ax_e.tick_params(axis="y", labelcolor=BLU, labelsize=8)

    # --- Right y-axis: V ---
    ax_v.set_ylim(0, 16)
    ax_v.set_ylabel("V (V)", fontsize=10, color=GRN)
    ax_v.set_yticks(np.arange(0, 17, 4))
    ax_v.tick_params(axis="y", labelcolor=GRN, labelsize=8)
    ax_v.spines["right"].set_color(GRN)
    ax_v.spines["left"].set_color(BLU)

    # --- Vertical dashed lines at r = a and r = b ---
    ax_e.axvline(A, color=GREY, ls="--", lw=1.0, zorder=0)
    ax_e.axvline(B, color=GREY, ls="--", lw=1.0, zorder=0)
    ax_e.text(A + 0.05, 9.5, r"$r = a$", fontsize=9, color="k")
    ax_e.text(B + 0.05, 9.5, r"$r = b$", fontsize=9, color="k")

    # --- Grid ---
    ax_e.grid(True, which="both", color="#dddddd", lw=0.6)
    ax_e.tick_params(axis="x", labelsize=8)

    # --- Asymptotes ---
    ax_e.axhline(0, color=GREY, ls="--", lw=0.6)
    ax_v.axhline(0, color=GREY, ls="--", lw=0.6)
    ax_e.text(7.5, 0.5, r"$E \rightarrow 0$", ha="right", va="bottom",
              fontsize=9, color=GREY, style="italic")
    ax_v.text(7.5, 0.5, r"$V \rightarrow 0$", ha="right", va="bottom",
              fontsize=9, color=GREY, style="italic")

    # --- Marked points: E ---
    e_at_a = K * Q_A / A ** 2
    e_at_b_outside = K * (Q_A + Q_B) / B ** 2
    ax_e.scatter([A], [e_at_a], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)
    ax_e.annotate(f"E = {e_at_a:g}", xy=(A, e_at_a),
                  xytext=(8, 6), textcoords="offset points",
                  fontsize=9, color=BLU)
    ax_e.scatter([B], [e_at_b_outside], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)
    ax_e.annotate(f"E = {e_at_b_outside:g}", xy=(B, e_at_b_outside),
                  xytext=(8, 6), textcoords="offset points",
                  fontsize=9, color=BLU)

    # --- Marked points: V ---
    v0 = K * Q_A / A + K * Q_B / B
    v_at_b = K * (Q_A + Q_B) / B
    ax_v.scatter([0], [v0], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)
    ax_v.annotate(f"V = {v0:g}", xy=(0, v0),
                  xytext=(12, -4), textcoords="offset points",
                  fontsize=9, color=GRN)
    ax_v.scatter([B], [v_at_b], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)
    ax_v.annotate(f"V = {v_at_b:g}", xy=(B, v_at_b),
                  xytext=(8, 6), textcoords="offset points",
                  fontsize=9, color=GRN)

    # --- Formula boxes (full piecewise) ---
    ax_e.text(
        0.97, 0.68,
        r"$\mathbf{E(r):}$" "\n"
        r"$\quad r < a:\; E = 0$" "\n"
        r"$\quad a \leq r < b:\; E = kQ_a\,/\,r^2$" "\n"
        r"$\quad r \geq b:\; E = k(Q_a\!+\!Q_b)\,/\,r^2$",
        transform=ax_e.transAxes, ha="right", va="top",
        fontsize=10, color=BLU, fontweight="bold", linespacing=1.4,
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )
    ax_v.text(
        0.97, 0.97,
        r"$\mathbf{V(r):}$" "\n"
        r"$\quad r < a:\; V = kQ_a\,/\,a + kQ_b\,/\,b$" "\n"
        r"$\quad a \leq r < b:\; V = kQ_a\,/\,r + kQ_b\,/\,b$" "\n"
        r"$\quad r \geq b:\; V = k(Q_a\!+\!Q_b)\,/\,r$",
        transform=ax_v.transAxes, ha="right", va="top",
        fontsize=10, color=GRN, fontweight="bold", linespacing=1.4,
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )

    # --- Legend ---
    handles = [
        Line2D([0], [0], color=BLU, lw=2.8, label=r"$E(r)$"),
        Line2D([0], [0], color=GRN, lw=2.8, label=r"$V(r)$"),
    ]
    ax_e.legend(handles=handles, loc="center right", fontsize=9,
                frameon=True, edgecolor="#cccccc", facecolor="white")


# --------------------------------------------------------------------------- #
# Build the figure
# --------------------------------------------------------------------------- #
def build_figure():
    fig = SPEC.figure()
    ax_model = fig.add_subplot(121)
    ax_e = fig.add_subplot(122)
    ax_v = ax_e.twinx()

    fig.subplots_adjust(left=0.06, right=0.94, top=0.92, bottom=0.10,
                        wspace=0.30)

    draw_model(ax_model)
    draw_curves(ax_e, ax_v)

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "concentric_shells")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
