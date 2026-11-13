"""Electric field and potential of a uniformly charged cylindrical shell.

Two-panel physics-textbook illustration (serif, line-art style), side by side:
  * Left:  cross-section of an infinite cylindrical shell with external E arrows.
  * Right: piecewise E(ρ) and V(ρ) curves vs. radial distance, dual y-axes.

Run with:    uv run python src/charged_cylindrical_shell.py
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.lines import Line2D
from matplotlib.patches import Circle, FancyArrowPatch

from _viz import Presets

# --------------------------------------------------------------------------- #
# Physical constants & scene
# --------------------------------------------------------------------------- #
EPS0 = 8.854e-12
LAMBDA = 1.0e-9        # linear charge density, C/m
R = 1.0                # shell radius, m
RHO0 = 2.0             # reference distance, m

FACTOR = LAMBDA / (2 * np.pi * EPS0)   # ≈ 17.98

BLU = "#1f4e9b"
RED = "#c0392b"
GRN = "#2e8b57"
GREY = "#888888"

SPEC = Presets.PNG_TEXTBOOK
OUT_DIR = Path(__file__).resolve().parent.parent / "img"


# --------------------------------------------------------------------------- #
# Left panel — cylindrical shell cross-section (2D)
# --------------------------------------------------------------------------- #
def draw_model(ax):
    ax.set_aspect("equal")
    ax.set_axis_off()
    ax.set_xlim(-4.0, 4.0)
    ax.set_ylim(-4.0, 4.0)

    ax.set_title("Model of Uniformly Charged Cylindrical Shell",
                 fontsize=12, pad=8)

    # Shell (blue dashed circle).
    ax.add_patch(Circle((0, 0), R, fc="none", ec=BLU, ls="--", lw=2.0, zorder=4))

    # "+" symbols on the shell (surface charge σ).
    n_charges = 12
    for i in range(n_charges):
        a = 2 * np.pi * i / n_charges
        x, y = R * np.cos(a), R * np.sin(a)
        ax.text(x, y, "+", ha="center", va="center",
                fontsize=11, color=RED, fontweight="bold", zorder=5)

    # Labels: R and σ.
    ax.annotate("", xy=(R, 0.12), xytext=(0, 0.12),
                arrowprops=dict(arrowstyle="-|>", color="k", lw=1.0))
    ax.text(R / 2, -0.20, "R", ha="center", va="top",
            fontsize=13, style="italic")
    ax.text(0.70 * R, 0.70 * R, r"$\sigma$", fontsize=12,
            color=RED, fontweight="bold")

    # Radial ρ indicator from centre outward.
    ax.annotate("", xy=(2.8, 0.0), xytext=(0, 0.0),
                arrowprops=dict(arrowstyle="-|>", color=GREY, lw=1.0, ls="--"))
    ax.text(1.7, -0.25, r"$\rho$", fontsize=12, color=GREY, style="italic")

    # Centre marker.
    ax.scatter([0], [0], s=14, color="k", zorder=5)
    ax.text(0.10, 0.12, "O", fontsize=10, zorder=5)

    # External radial E arrows (length ∝ 1/ρ), 10 directions.
    for i in range(10):
        a = 2 * np.pi * i / 10
        dx, dy = np.cos(a), np.sin(a)
        rho_s = R + 0.10
        rho_e = rho_s + 1.0 * (R / rho_s)   # length ∝ 1/ρ at start
        rho_e = min(rho_e, 3.6)
        ax.add_patch(FancyArrowPatch(
            (rho_s * dx, rho_s * dy),
            (rho_e * dx, rho_e * dy),
            arrowstyle="-|>", mutation_scale=10, color=BLU, lw=1.6, zorder=3,
        ))

    # Inner annotation: E = 0.
    ax.text(0, 0.0, r"$E = 0$", ha="center", va="center",
            fontsize=9, color=GREY, zorder=6,
            bbox=dict(fc="white", ec="none", pad=1, alpha=0.8))

    # Inset (lower-left): a small 3D-style cylinder indicating that the
    # main figure is the cross-section of a cylindrical shell.
    from matplotlib.patches import Ellipse, FancyArrowPatch as FAP
    cx, cy, h = -3.1, -3.0, 1.4        # cylinder centre & height
    rx, ry = 0.80, 0.20                # ellipse radii (wider/narrower = bigger cylinder)
    # body (rectangle between top & bottom ellipses)
    ax.add_patch(plt.Rectangle((cx - rx, cy - h / 2), 2 * rx, h,
                               fc="#eaf2fb", ec="none", zorder=2))
    # bottom ellipse (dashed back half, solid front half approximated)
    ax.add_patch(Ellipse((cx, cy - h / 2), 2 * rx, 2 * ry,
                         fc="#d6eaf8", ec=BLU, lw=1.0, zorder=2))
    # top ellipse
    ax.add_patch(Ellipse((cx, cy + h / 2), 2 * rx, 2 * ry,
                         fc="#d6eaf8", ec=BLU, lw=1.0, zorder=3))
    # side lines
    ax.plot([cx - rx, cx - rx], [cy - h / 2, cy + h / 2],
            color=BLU, lw=1.0, zorder=2)
    ax.plot([cx + rx, cx + rx], [cy - h / 2, cy + h / 2],
            color=BLU, lw=1.0, zorder=3)
    # "+" on cylinder surface
    ax.text(cx, cy + 0.05, "+", ha="center", va="center",
            fontsize=9, color=RED, fontweight="bold", zorder=4)
    # arrow pointing from the inset to the main circle.
    # Starts at the upper-right of the cylinder, ends near the shell circle.
    # Tweak ANGLE (radians) to rotate the arrow direction counter-clockwise.
    ANGLE = np.deg2rad(55)            # 0 = pointing right; larger = more CCW
    sx = cx + rx * np.cos(ANGLE) + 0.05
    sy = cy + (h / 2) * np.sin(ANGLE) + 0.15
    ex = sx + 1.6 * np.cos(ANGLE)
    ey = sy + 1.6 * np.sin(ANGLE)
    ax.add_patch(FAP((sx, sy), (ex, ey),
                     arrowstyle="-|>", mutation_scale=12,
                     color="k", lw=1.2, zorder=4))
    ax.text(cx + 0.05, cy + h / 2 + 0.30, "cross-section",
            ha="center", va="bottom", fontsize=8, color="k", style="italic")

    # Legend (lower-right).
    handles = [
        Line2D([0], [0], color=BLU, ls="--", lw=2.0,
               label="Cylindrical shell (radius R)"),
        Line2D([0], [0], marker="+", color=RED, markersize=10,
               markeredgewidth=1.5, linestyle="none",
               label="Surface charge ($\\sigma$)"),
        Line2D([0], [0], color=BLU, lw=2.0, marker=">",
               markersize=7, label="E (Field Vector)"),
    ]
    ax.legend(handles=handles, loc="lower right", fontsize=8,
              frameon=True, edgecolor="#cccccc", facecolor="white",
              framealpha=0.9)


# --------------------------------------------------------------------------- #
# Right panel — piecewise E(ρ) and V(ρ) with dual y-axes
# --------------------------------------------------------------------------- #
def draw_curves(ax_e, ax_v):
    ax_e.set_title("Field and Potential of Uniformly Charged Cylindrical Shell",
                   fontsize=11, pad=8)

    r1 = np.linspace(0, R, 200)
    r2 = np.linspace(R, 4 * R, 400)

    # --- E(ρ): 0 inside, λ/(2πε₀ρ) outside ---
    E1 = np.zeros_like(r1)
    E2 = FACTOR / r2

    ax_e.plot(r1, E1, color=BLU, lw=2.8)
    ax_e.plot(r2, E2, color=BLU, lw=2.8, label=r"$E(\rho)$")

    # --- V(ρ): const inside, (λ/2πε₀)ln(ρ₀/ρ) outside ---
    V1 = np.full_like(r1, FACTOR * np.log(RHO0 / R))
    V2 = FACTOR * np.log(RHO0 / r2)

    ax_v.plot(r1, V1, color=GRN, lw=2.8)
    ax_v.plot(r2, V2, color=GRN, lw=2.8, label=r"$V(\rho)$")

    # --- Shared x-axis ---
    ax_e.set_xlim(0, 4 * R)
    ax_e.set_xlabel(r"Distance $\rho$ (m)", fontsize=10)
    ax_e.set_xticks(np.arange(0, 4 * R + 0.01, 1.0))

    # --- Left y-axis: E ---
    ax_e.set_ylim(0, 20)
    ax_e.set_ylabel("E (N/C)", fontsize=10, color=BLU)
    ax_e.set_yticks(np.arange(0, 21, 5))
    ax_e.tick_params(axis="y", labelcolor=BLU, labelsize=8)

    # --- Right y-axis: V ---
    ax_v.set_ylim(0, 14)
    ax_v.set_ylabel("V (V)", fontsize=10, color=GRN)
    ax_v.set_yticks(np.arange(0, 15, 2))
    ax_v.tick_params(axis="y", labelcolor=GRN, labelsize=8)
    ax_v.spines["right"].set_color(GRN)
    ax_v.spines["left"].set_color(BLU)

    # --- Vertical dashed lines at ρ = R and ρ = ρ₀ ---
    ax_e.axvline(R, color=GREY, ls="--", lw=1.0, zorder=0)
    ax_e.axvline(RHO0, color=GREY, ls="--", lw=1.0, zorder=0)
    ax_e.text(R + 0.05, 19, r"$\rho = R$", fontsize=9, color="k")
    ax_e.text(RHO0 + 0.05, 19, r"$\rho = \rho_0$", fontsize=9, color="k")

    # --- Grid ---
    ax_e.grid(True, which="both", color="#dddddd", lw=0.6)
    ax_e.tick_params(axis="x", labelsize=8)

    # --- Asymptote ---
    ax_e.axhline(0, color=GREY, ls="--", lw=0.6)
    ax_e.text(4 * R - 0.1, 0.6, r"$E \rightarrow 0$", ha="right", va="bottom",
              fontsize=9, color=GREY, style="italic")

    # --- Marked points ---
    e_at_r = FACTOR / R
    ax_e.scatter([R], [e_at_r], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)
    ax_e.annotate(f"E = {e_at_r:.1f}", xy=(R, e_at_r),
                  xytext=(8, 14), textcoords="offset points",
                  fontsize=9, color=BLU)

    v_at_r = FACTOR * np.log(RHO0 / R)
    ax_v.scatter([R], [v_at_r], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)
    ax_v.annotate(f"V = {v_at_r:.1f}", xy=(R, v_at_r),
                  xytext=(8, -14), textcoords="offset points",
                  fontsize=9, color=GRN)

    # V = 0 at ρ₀
    ax_v.scatter([RHO0], [0], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)
    ax_v.annotate("V = 0", xy=(RHO0, 0),
                  xytext=(8, 8), textcoords="offset points",
                  fontsize=9, color=GRN)

    # --- Formula boxes (full piecewise) ---
    ax_e.text(
        0.97, 0.72,
        r"$\mathbf{E(\rho):}$" "\n"
        r"$\quad \rho < R:\; E = 0$" "\n"
        r"$\quad \rho \geq R:\; E = \dfrac{\lambda}{2\pi\varepsilon_0\,\rho}$",
        transform=ax_e.transAxes, ha="right", va="top",
        fontsize=11, color=BLU, fontweight="bold", linespacing=1.5,
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )
    ax_v.text(
        0.97, 0.97,
        r"$\mathbf{V(\rho):}$" "\n"
        r"$\quad \rho < R:\; V = \dfrac{\lambda}{2\pi\varepsilon_0}\ln\dfrac{\rho_0}{R}$"
        "\n\n"
        r"$\quad \rho \geq R:\; V = \dfrac{\lambda}{2\pi\varepsilon_0}\ln\dfrac{\rho_0}{\rho}$",
        transform=ax_v.transAxes, ha="right", va="top",
        fontsize=11, color=GRN, fontweight="bold", linespacing=2.0,
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )

    # --- Legend ---
    handles = [
        Line2D([0], [0], color=BLU, lw=2.8, label=r"$E(\rho)$"),
        Line2D([0], [0], color=GRN, lw=2.8, label=r"$V(\rho)$"),
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
    path = SPEC.save(fig, OUT_DIR / "charged_cylindrical_shell")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
