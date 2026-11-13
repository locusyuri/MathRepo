"""Electric field and potential of a uniformly charged solid cylinder.

Two-panel physics-textbook illustration (serif, line-art style), side by side:
  * Left:  cross-section of an infinite solid cylinder with internal (E ∝ ρ)
           and external (E ∝ 1/ρ) radial E arrows, plus a 3D cylinder inset.
  * Right: piecewise E(ρ) and V(ρ) curves vs. radial distance, dual y-axes.

Run with:    uv run python src/charged_solid_cylinder.py
"""

from __future__ import annotations

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.lines import Line2D
from matplotlib.patches import Circle, Ellipse, FancyArrowPatch

import sys
sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

# --------------------------------------------------------------------------- #
# Physical constants & scene
# --------------------------------------------------------------------------- #
EPS0 = 8.854e-12
LAMBDA = 1.0e-9        # linear charge density, C/m
R = 1.0                # cylinder radius, m
RHO0 = 2.0             # reference distance, m

FACTOR = LAMBDA / (2 * np.pi * EPS0)   # ≈ 17.98

BLU = "#1f4e9b"
RED = "#c0392b"
GRN = "#2e8b57"
GREY = "#888888"

SPEC = Presets.PNG_TEXTBOOK
OUT_DIR = Path(__file__).resolve().parent.parent / "img"


# --------------------------------------------------------------------------- #
# Left panel — solid cylinder cross-section (2D) + 3D inset
# --------------------------------------------------------------------------- #
def draw_model(ax):
    ax.set_aspect("equal")
    ax.set_axis_off()
    ax.set_xlim(-4.0, 4.0)
    ax.set_ylim(-4.0, 4.0)

    ax.set_title("Model of Uniformly Charged Solid Cylinder",
                 fontsize=12, pad=8)

    # Solid cylinder cross-section: pink fill (uniform volume charge).
    ax.add_patch(Circle((0, 0), R, fc="#fadbd8", ec=RED, lw=1.6, zorder=2))

    # "+" symbols uniformly scattered inside (volume charge density ρ).
    rng = np.random.default_rng(7)
    pts = []
    while len(pts) < 20:
        x, y = rng.uniform(-R * 0.85, R * 0.85), rng.uniform(-R * 0.85, R * 0.85)
        if x * x + y * y < (R * 0.85) ** 2:
            pts.append((x, y))
    for x, y in pts:
        ax.text(x, y, "+", ha="center", va="center",
                fontsize=10, color=RED, fontweight="bold", zorder=4)

    # Labels: R and ρ (charge density).
    ax.annotate("", xy=(R, 0.14), xytext=(0, 0.14),
                arrowprops=dict(arrowstyle="-|>", color="k", lw=1.0))
    ax.text(R / 2, -0.18, "R", ha="center", va="top",
            fontsize=13, style="italic")
    ax.text(0.30, 0.30, r"$\rho$", fontsize=12, color=RED, fontweight="bold")

    # Radial ρ-distance indicator from centre outward.
    ax.annotate("", xy=(2.8, 0.0), xytext=(0, 0.0),
                arrowprops=dict(arrowstyle="-|>", color=GREY, lw=1.0, ls="--"))
    ax.text(1.7, -0.22, r"$\rho$", fontsize=12, color=GREY, style="italic")

    # Centre marker.
    ax.scatter([0], [0], s=14, color="k", zorder=5)
    ax.text(0.10, 0.12, "O", fontsize=10, zorder=5)

    # Internal radial E arrows (length ∝ ρ, i.e. grows outward).
    # Drawn at 6 angles; tip at frac*R, so longer the further out.
    for i in range(6):
        a = np.pi / 6 + i * np.pi / 3
        dx, dy = np.cos(a), np.sin(a)
        r_start = 0.08
        r_tip = 0.78 * R
        ax.add_patch(FancyArrowPatch(
            (r_start * dx, r_start * dy),
            (r_tip * dx, r_tip * dy),
            arrowstyle="-|>", mutation_scale=10, color=BLU, lw=1.5, zorder=3,
        ))

    # External radial E arrows (length ∝ 1/ρ, decreasing outward).
    for i in range(10):
        a = 2 * np.pi * i / 10
        dx, dy = np.cos(a), np.sin(a)
        rho_s = R + 0.08
        rho_e = rho_s + 1.0 * (R / rho_s)
        rho_e = min(rho_e, 3.6)
        ax.add_patch(FancyArrowPatch(
            (rho_s * dx, rho_s * dy),
            (rho_e * dx, rho_e * dy),
            arrowstyle="-|>", mutation_scale=10, color=BLU, lw=1.6, zorder=3,
        ))

    # --- 3D cylinder inset (lower-left) indicating cross-section ---
    cx, cy, h = -3.1, -3.0, 1.4
    rx, ry = 0.80, 0.20
    ax.add_patch(plt.Rectangle((cx - rx, cy - h / 2), 2 * rx, h,
                               fc="#fadbd8", ec="none", zorder=2))
    ax.add_patch(Ellipse((cx, cy - h / 2), 2 * rx, 2 * ry,
                         fc="#f5b7b1", ec=RED, lw=1.0, zorder=2))
    ax.add_patch(Ellipse((cx, cy + h / 2), 2 * rx, 2 * ry,
                         fc="#f5b7b1", ec=RED, lw=1.0, zorder=3))
    ax.plot([cx - rx, cx - rx], [cy - h / 2, cy + h / 2],
            color=RED, lw=1.0, zorder=2)
    ax.plot([cx + rx, cx + rx], [cy - h / 2, cy + h / 2],
            color=RED, lw=1.0, zorder=3)
    ax.text(cx, cy + 0.05, "+", ha="center", va="center",
            fontsize=9, color=RED, fontweight="bold", zorder=4)
    # Arrow from inset to main circle (counter-clockwise tilt).
    ANGLE = np.deg2rad(55)
    sx = cx + rx * np.cos(ANGLE) + 0.05
    sy = cy + (h / 2) * np.sin(ANGLE) + 0.15
    ex = sx + 1.6 * np.cos(ANGLE)
    ey = sy + 1.6 * np.sin(ANGLE)
    ax.add_patch(FancyArrowPatch((sx, sy), (ex, ey),
                                 arrowstyle="-|>", mutation_scale=12,
                                 color="k", lw=1.2, zorder=4))
    ax.text(cx + 0.05, cy + h / 2 + 0.30, "cross-section",
            ha="center", va="bottom", fontsize=8, color="k", style="italic")

    # Legend (lower-right).
    handles = [
        Line2D([0], [0], marker="o", color=RED, markerfacecolor="#fadbd8",
               markersize=11, linestyle="none",
               label="Solid cylinder (radius R)"),
        Line2D([0], [0], marker="+", color=RED, markersize=10,
               markeredgewidth=1.5, linestyle="none",
               label="Volume charge ($\\rho$)"),
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
    ax_e.set_title("Field and Potential of Uniformly Charged Solid Cylinder",
                   fontsize=11, pad=8)

    r1 = np.linspace(0, R, 300)
    r2 = np.linspace(R, 4 * R, 400)

    # --- E(ρ): linear inside (∝ρ), 1/ρ outside ---
    # Inside: E = λρ/(2πε₀R²) = FACTOR · ρ / R
    E1 = FACTOR * r1 / R
    E2 = FACTOR / r2

    ax_e.plot(r1, E1, color=BLU, lw=2.8)
    ax_e.plot(r2, E2, color=BLU, lw=2.8, label=r"$E(\rho)$")

    # --- V(ρ): parabola inside, ln(ρ₀/ρ) outside ---
    V1 = FACTOR * (np.log(RHO0 / R) + 0.5 * (1 - (r1 / R) ** 2))
    V2 = FACTOR * np.log(RHO0 / r2)

    ax_v.plot(r1, V1, color=GRN, lw=2.8)
    ax_v.plot(r2, V2, color=GRN, lw=2.8, label=r"$V(\rho)$")

    # --- Shared x-axis ---
    ax_e.set_xlim(0, 4 * R)
    ax_e.set_xlabel(r"Distance $\rho$ (m)", fontsize=10)
    ax_e.set_xticks(np.arange(0, 4 * R + 0.01, 1.0))

    # --- Left y-axis: E ---
    ax_e.set_ylim(0, 22)
    ax_e.set_ylabel("E (N/C)", fontsize=10, color=BLU)
    ax_e.set_yticks(np.arange(0, 23, 5))
    ax_e.tick_params(axis="y", labelcolor=BLU, labelsize=8)

    # --- Right y-axis: V ---
    ax_v.set_ylim(0, 24)
    ax_v.set_ylabel("V (V)", fontsize=10, color=GRN)
    ax_v.set_yticks(np.arange(0, 25, 4))
    ax_v.tick_params(axis="y", labelcolor=GRN, labelsize=8)
    ax_v.spines["right"].set_color(GRN)
    ax_v.spines["left"].set_color(BLU)

    # --- Vertical dashed lines at ρ = R and ρ = ρ₀ ---
    ax_e.axvline(R, color=GREY, ls="--", lw=1.0, zorder=0)
    ax_e.axvline(RHO0, color=GREY, ls="--", lw=1.0, zorder=0)
    ax_e.text(R + 0.05, 21, r"$\rho = R$", fontsize=9, color="k")
    ax_e.text(RHO0 + 0.05, 21, r"$\rho = \rho_0$", fontsize=9, color="k")

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

    v0 = FACTOR * (np.log(RHO0 / R) + 0.5)
    ax_v.scatter([0], [v0], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)
    ax_v.annotate(f"V = {v0:.1f}", xy=(0, v0),
                  xytext=(12, -4), textcoords="offset points",
                  fontsize=9, color=GRN)

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
        r"$\quad \rho < R:\; E = \dfrac{\lambda\,\rho}{2\pi\varepsilon_0 R^2}$"
        "\n\n"
        r"$\quad \rho \geq R:\; E = \dfrac{\lambda}{2\pi\varepsilon_0\,\rho}$",
        transform=ax_e.transAxes, ha="right", va="top",
        fontsize=11, color=BLU, fontweight="bold", linespacing=2.0,
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )
    ax_v.text(
        0.97, 0.97,
        r"$\mathbf{V(\rho):}$" "\n"
        r"$\quad \rho < R:\; V = \dfrac{\lambda}{2\pi\varepsilon_0}"
        r"\left[\ln\dfrac{\rho_0}{R} + \frac{1}{2}\left(1-\dfrac{\rho^2}{R^2}\right)\right]$"
        "\n\n"
        r"$\quad \rho \geq R:\; V = \dfrac{\lambda}{2\pi\varepsilon_0}\ln\dfrac{\rho_0}{\rho}$",
        transform=ax_v.transAxes, ha="right", va="top",
        fontsize=10, color=GRN, fontweight="bold", linespacing=2.0,
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )

    # --- Legend ---
    handles = [
        Line2D([0], [0], color=BLU, lw=2.8, label=r"$E(\rho)$"),
        Line2D([0], [0], color=GRN, lw=2.8, label=r"$V(\rho)$"),
    ]
    ax_e.legend(handles=handles, loc="lower right", fontsize=9,
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
    path = SPEC.save(fig, OUT_DIR / "charged_solid_cylinder")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
