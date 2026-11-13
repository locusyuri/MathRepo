"""Electric field and potential of a uniformly charged spherical shell.

Two-panel physics-textbook illustration (serif, line-art style), side by side:
  * Left:  shell cross-section with radial E-lines (zero inside).
  * Right: piecewise E(r) and V(r) curves vs. distance, with dual y-axes.

Run with:    uv run python src/charged_sphere.py
"""

from __future__ import annotations

from pathlib import Path

import sys

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.lines import Line2D
from matplotlib.patches import Circle, FancyArrowPatch, Wedge

sys.path.insert(0, str(Path(__file__).resolve().parent))

from _viz import Presets

# --------------------------------------------------------------------------- #
# Physical constants & scene
# --------------------------------------------------------------------------- #
K = 9.0e9          # Coulomb constant, N·m^2/C^2
Q = 1.0e-9         # total charge, C
R = 1.0            # shell radius, m  ->  E(R)=9.0, V(R)=9.0

RED = "#c0392b"
BLU = "#1f4e9b"
GRN = "#2e8b57"
GREY = "#888888"

SPEC = Presets.PNG_TEXTBOOK
OUT_DIR = Path(__file__).resolve().parent.parent / "img"


# --------------------------------------------------------------------------- #
# Left panel — shell cross-section
# --------------------------------------------------------------------------- #
def draw_model(ax):
    ax.set_aspect("equal")
    ax.set_axis_off()
    ax.set_xlim(-4.0, 4.0)
    ax.set_ylim(-4.0, 4.0)

    ax.set_title("Uniformly Charged Spherical Shell — Cross Section",
                 fontsize=12, pad=8)

    # Shell interior (light grey fill).
    ax.add_patch(Circle((0, 0), R, fc="#f0f0f0", ec="none", zorder=1))

    # Shell boundary (black ring).
    ax.add_patch(Circle((0, 0), R, fc="none", ec="black", lw=2.2, zorder=4))

    # Label "R" below the shell.
    ax.annotate("", xy=(R, -0.12), xytext=(0, -0.12),
                arrowprops=dict(arrowstyle="-|>", color="k", lw=1.0))
    ax.text(R / 2, -0.35, "R", ha="center", va="top",
            fontsize=13, style="italic")

    # "+Q" labels at four positions on the shell.
    for angle in (0, np.pi / 2, np.pi, 3 * np.pi / 2):
        x = R * np.cos(angle)
        y = R * np.sin(angle)
        dx = 0.12 * np.cos(angle)
        dy = 0.12 * np.sin(angle)
        ax.text(x + dx, y + dy, "+Q", ha="center", va="center",
                fontsize=11, color=RED, fontweight="bold", zorder=5)

    # 8 radial field lines outside the shell (with arrows at ~50%).
    for i in range(8):
        a = 2 * np.pi * i / 8
        dx, dy = np.cos(a), np.sin(a)
        ax.plot([R * dx, 3.2 * dx], [R * dy, 3.2 * dy],
                color=RED, lw=1.2, zorder=2)
        t = 0.55
        r1 = R + t * (3.2 - R) - 0.12
        r2 = R + t * (3.2 - R)
        ax.add_patch(FancyArrowPatch(
            (r1 * dx, r1 * dy), (r2 * dx, r2 * dy),
            arrowstyle="-|>", mutation_scale=9, color=RED, lw=1.2, zorder=3,
        ))

    # Region annotations.
    ax.text(0, 0, r"""$r < R$:  
$E = 0$,  $V = \mathrm{const}$
                    """,
            ha="center", va="center", fontsize=10, color="#555", zorder=6)
    ax.text(2.8, -2.8, r"$r > R$", ha="center", va="center",
            fontsize=10, color="#555")

    # Test points at r = 2R and r = 3R on the +x axis, with blue E arrows.
    for name, frac in (("P1", 2.0), ("P2", 3.0)):
        px = frac * R
        ax.scatter([px], [0], s=22, facecolor="white", edgecolor="k", zorder=6)
        ax.text(px, -0.30, name, ha="center", va="top", fontsize=9, zorder=6)
        ax.add_patch(FancyArrowPatch(
            (px + 0.08, 0), (px + 0.40, 0),
            arrowstyle="-|>", mutation_scale=14, color=BLU, lw=2.4, zorder=7,
        ))
        ax.text(px + 0.25, 0.15, "E", ha="center", va="bottom",
                fontsize=12, color=BLU, fontweight="bold", zorder=7)

    # Legend (bottom-right).
    handles = [
        Line2D([0], [0], marker="o", color="none", markerfacecolor="black",
               markeredgecolor="black", markersize=8,
               label="Shell (radius R)"),
        Line2D([0], [0], color=RED, lw=1.4, label="Electric Field Lines"),
        Line2D([0], [0], color=BLU, lw=2.4, label="E (Field Vector)"),
    ]
    ax.legend(handles=handles, loc="lower right", fontsize=8,
              frameon=True, edgecolor="#cccccc", facecolor="white",
              framealpha=0.9)


# --------------------------------------------------------------------------- #
# Right panel — piecewise E(r) and V(r) with dual y-axes
# --------------------------------------------------------------------------- #
def draw_curves(ax_e, ax_v):
    ax_e.set_title("E(r) and V(r) vs. Distance r", fontsize=12, pad=8)

    r_inner = np.linspace(0, R, 200)
    r_outer = np.linspace(R, 4.0, 400)

    # --- E(r): E = 0 for r<R, E = kQ/r² for r>=R ---
    E_inner = np.zeros_like(r_inner)
    E_outer = K * Q / r_outer ** 2

    ax_e.plot(r_inner, E_inner, color=BLU, lw=2.8)
    ax_e.plot(r_outer, E_outer, color=BLU, lw=2.8,
              label=r"$E(r)$")

    # --- V(r): V = kQ/R for r<=R, V = kQ/r for r>R ---
    V_inner = np.full_like(r_inner, K * Q / R)
    V_outer = K * Q / r_outer

    ax_v.plot(r_inner, V_inner, color=GRN, lw=2.8)
    ax_v.plot(r_outer, V_outer, color=GRN, lw=2.8,
              label=r"$V(r)$")

    # --- Shared x-axis ---
    ax_e.set_xlim(0, 4.0)
    ax_e.set_xlabel("Distance r (m)", fontsize=10)
    ax_e.set_xticks(np.arange(0, 4.01, 0.5))

    # --- Left y-axis: E ---
    ax_e.set_ylim(0, 10)
    ax_e.set_ylabel("E (N/C)", fontsize=10, color=BLU)
    ax_e.set_yticks(np.arange(0, 11, 2))
    ax_e.tick_params(axis="y", labelcolor=BLU, labelsize=8)

    # --- Right y-axis: V ---
    ax_v.set_ylim(0, 10)
    ax_v.set_ylabel("V (V)", fontsize=10, color=GRN)
    ax_v.set_yticks(np.arange(0, 11, 2))
    ax_v.tick_params(axis="y", labelcolor=GRN, labelsize=8)
    ax_v.spines["right"].set_color(GRN)
    ax_v.spines["left"].set_color(BLU)

    # --- Vertical dashed line at r = R ---
    ax_e.axvline(R, color="k", ls="--", lw=1.0, zorder=0)
    ax_e.text(R + 0.05, 9.2, r"$r = R$", fontsize=9, color="k")

    # --- Light grey grid ---
    ax_e.grid(True, which="both", color="#dddddd", lw=0.6)
    ax_e.tick_params(axis="x", labelsize=8)

    # --- V→0 asymptote (grey dashed, at V=0 extended) ---
    ax_v.axhline(0, color=GREY, ls="--", lw=0.8)
    ax_v.text(3.9, 0.3, r"$V \rightarrow 0$", ha="right", va="bottom",
              fontsize=9, color=GREY, style="italic")

    # --- Marked points ---
    # E
    for rr, val in ((1.0, 9.0), (2.0, 2.25), (3.0, 1.0)):
        y = K * Q / rr ** 2 if rr >= R else 0
        ax_e.scatter([rr], [y], s=24, facecolor="white",
                     edgecolor=BLU, zorder=5)
        ax_e.annotate(f"E = {val:g}", xy=(rr, y),
                      xytext=(8, 6), textcoords="offset points",
                      fontsize=9, color=BLU)
    # V
    for rr, val in ((1.0, 9.0), (2.0, 4.5), (3.0, 3.0)):
        y = K * Q / R if rr <= R else K * Q / rr
        ax_v.scatter([rr], [y], s=24, facecolor="white",
                     edgecolor=GRN, zorder=5)
        ax_v.annotate(f"V = {val:g}", xy=(rr, y),
                      xytext=(8, 6), textcoords="offset points",
                      fontsize=9, color=GRN)

    # --- Formula boxes (full piecewise expressions) ---
    # mathtext lacks \begin{cases}, so we stack lines manually.
    ax_e.text(
        0.97, 0.72,
        r"$\mathbf{E(r):}$" "\n"
        r"$\quad r < R:\; E = 0$" "\n"
        r"$\quad r \geq R:\; E = kQ\,/\,r^2$",
        transform=ax_e.transAxes, ha="right", va="top",
        fontsize=11, color=BLU, fontweight="bold", linespacing=1.5,
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )
    ax_v.text(
        0.97, 0.97,
        r"$\mathbf{V(r):}$" "\n"
        r"$\quad r \leq R:\; V = kQ\,/\,R$" "\n"
        r"$\quad r > R:\; V = kQ\,/\,r$",
        transform=ax_v.transAxes, ha="right", va="top",
        fontsize=11, color=GRN, fontweight="bold", linespacing=1.5,
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )

    # --- Combined legend (upper-right of E axis) ---
    handles = [
        Line2D([0], [0], color=BLU, lw=2.8, label=r"$E(r)$"),
        Line2D([0], [0], color=GRN, lw=2.8, label=r"$V(r)$"),
    ]
    ax_e.legend(handles=handles, loc="upper right", fontsize=9,
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
    path = SPEC.save(fig, OUT_DIR / "charged_sphere")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
