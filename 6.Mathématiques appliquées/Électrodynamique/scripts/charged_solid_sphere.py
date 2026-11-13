"""Electric field and potential of a uniformly charged solid sphere.

Two-panel physics-textbook illustration (serif, line-art style), side by side:
  * Left:  solid sphere cross-section with internal E ∝ r arrows.
  * Right: piecewise E(r) and V(r) curves vs. distance, with dual y-axes.

Run with:    uv run python src/charged_solid_sphere.py
"""

from __future__ import annotations

from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.lines import Line2D
from matplotlib.patches import Circle, FancyArrowPatch

sys.path.insert(0, str(Path(__file__).resolve().parent))

from _viz import Presets

# --------------------------------------------------------------------------- #
# Physical constants & scene
# --------------------------------------------------------------------------- #
K = 9.0e9          # Coulomb constant, N·m^2/C^2
Q = 1.0e-9         # total charge, C
R = 1.0            # sphere radius, m

RED = "#c0392b"
BLU = "#1f4e9b"
GRN = "#2e8b57"
GREY = "#888888"

SPEC = Presets.PNG_TEXTBOOK
OUT_DIR = Path(__file__).resolve().parent.parent / "img"


# --------------------------------------------------------------------------- #
# Left panel — solid sphere cross-section
# --------------------------------------------------------------------------- #
def draw_model(ax):
    ax.set_aspect("equal")
    ax.set_axis_off()
    ax.set_xlim(-4.0, 4.0)
    ax.set_ylim(-4.0, 4.0)

    ax.set_title("Model of a Uniformly Charged Solid Sphere",
                 fontsize=12, pad=8)

    # Sphere interior (light blue transparent fill).
    ax.add_patch(Circle((0, 0), R, fc="#d6eaf8", ec="none", alpha=0.5, zorder=1))

    # Sphere boundary (black ring).
    ax.add_patch(Circle((0, 0), R, fc="none", ec="black", lw=2.2, zorder=4))

    # Centre "O".
    ax.scatter([0], [0], s=18, color="k", zorder=5)
    ax.text(0.12, -0.18, "O", fontsize=11, zorder=5)

    # Label "R" along +x inside.
    ax.annotate("", xy=(R, -0.12), xytext=(0, -0.12),
                arrowprops=dict(arrowstyle="-|>", color="k", lw=1.0))
    ax.text(R / 2, -0.35, "R", ha="center", va="top",
            fontsize=13, style="italic")

    # "+" symbols uniformly distributed inside the sphere.
    rng = np.random.default_rng(42)
    pts = []
    while len(pts) < 24:
        x, y = rng.uniform(-R * 0.88, R * 0.88), rng.uniform(-R * 0.88, R * 0.88)
        if x * x + y * y < (R * 0.88) ** 2:
            pts.append((x, y))
    for x, y in pts:
        ax.text(x, y, "+", ha="center", va="center",
                fontsize=11, color=RED, fontweight="bold", zorder=3)

    # Boundary label at r = R.
    ax.text(R + 0.08, 0.50, r"$r = R$", fontsize=10, color="k", style="italic")

    # External radial field lines (8 directions, arrows at ~55%).
    for i in range(8):
        a = 2 * np.pi * i / 8
        dx, dy = np.cos(a), np.sin(a)
        ax.plot([R * dx, 3.2 * dx], [R * dy, 3.2 * dy],
                color=BLU, lw=1.2, zorder=2)
        t = 0.55
        r1 = R + t * (3.2 - R) - 0.12
        r2 = R + t * (3.2 - R)
        ax.add_patch(FancyArrowPatch(
            (r1 * dx, r1 * dy), (r2 * dx, r2 * dy),
            arrowstyle="-|>", mutation_scale=9, color=BLU, lw=1.2, zorder=3,
        ))

    # Internal radial E arrows (length ∝ r, drawn at 5 angles).
    for i in range(5):
        a = np.pi / 6 + i * np.pi / 3   # 30°, 90°, 150°, 210°, 270°
        dx, dy = np.cos(a), np.sin(a)
        frac = 0.85                       # arrow tip at 85% of R
        ax.add_patch(FancyArrowPatch(
            (0.05 * dx, 0.05 * dy), (frac * R * dx, frac * R * dy),
            arrowstyle="-|>", mutation_scale=11, color=BLU, lw=1.8, zorder=5,
        ))

    # Legend (lower-right).
    handles = [
        Line2D([0], [0], marker="+", color=RED, markersize=10,
               markeredgewidth=1.5, linestyle="none",
               label="Positive charge (+)"),
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
    ax_e.set_title("Electric Field and Potential of a Uniformly Charged Solid Sphere",
                   fontsize=11, pad=8)

    r_inner = np.linspace(0, R, 300)
    r_outer = np.linspace(R, 4.0, 400)

    # --- E(r): E = kQr/R³ for r<R, E = kQ/r² for r≥R ---
    E_inner = K * Q * r_inner / R ** 3
    E_outer = K * Q / r_outer ** 2

    ax_e.plot(r_inner, E_inner, color=BLU, lw=2.8)
    ax_e.plot(r_outer, E_outer, color=BLU, lw=2.8, label=r"$E(r)$")

    # --- V(r): V = (kQ/2R)(3-r²/R²) for r≤R, V = kQ/r for r>R ---
    V_inner = (K * Q / (2 * R)) * (3 - (r_inner / R) ** 2)
    V_outer = K * Q / r_outer

    ax_v.plot(r_inner, V_inner, color=GRN, lw=2.8)
    ax_v.plot(r_outer, V_outer, color=GRN, lw=2.8, label=r"$V(r)$")

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
    ax_v.set_ylim(0, 16)
    ax_v.set_ylabel("V (V)", fontsize=10, color=GRN)
    ax_v.set_yticks(np.arange(0, 17, 4))
    ax_v.tick_params(axis="y", labelcolor=GRN, labelsize=8)
    ax_v.spines["right"].set_color(GRN)
    ax_v.spines["left"].set_color(BLU)

    # --- Vertical dashed line at r = R ---
    ax_e.axvline(R, color=GREY, ls="--", lw=1.0, zorder=0)
    ax_e.text(R + 0.05, 9.5, r"$r = R$", fontsize=9, color="k")

    # --- Light grey grid ---
    ax_e.grid(True, which="both", color="#dddddd", lw=0.6)
    ax_e.tick_params(axis="x", labelsize=8)

    # --- Asymptotes E→0 and V→0 ---
    ax_e.axhline(0, color=GREY, ls="--", lw=0.6)
    ax_v.axhline(0, color=GREY, ls="--", lw=0.6)
    ax_v.text(3.9, 0.5, r"$V \rightarrow 0$", ha="right", va="bottom",
              fontsize=9, color=GREY, style="italic")
    ax_e.text(3.9, 0.5, r"$E \rightarrow 0$", ha="right", va="bottom",
              fontsize=9, color=GREY, style="italic")

    # --- Marked points: E ---
    for rr in (1.0, 2.0):
        y = K * Q / rr ** 2
        ax_e.scatter([rr], [y], s=24, facecolor="white",
                     edgecolor=BLU, zorder=5)
        ax_e.annotate(f"E = {y:g}", xy=(rr, y),
                      xytext=(8, 6), textcoords="offset points",
                      fontsize=9, color=BLU)

    # --- Marked points: V ---
    v0 = 3 * K * Q / (2 * R)   # V(0) = 13.5
    ax_v.scatter([0], [v0], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)
    ax_v.annotate(r"$V_0 = \frac{3kQ}{2R}$" "\n" f"= {v0:g}",
                  xy=(0, v0), xytext=(12, -4), textcoords="offset points",
                  fontsize=9, color=GRN)

    for rr in (1.0, 2.0):
        y = K * Q / rr
        ax_v.scatter([rr], [y], s=24, facecolor="white",
                     edgecolor=GRN, zorder=5)
        ax_v.annotate(f"V = {y:g}", xy=(rr, y),
                      xytext=(8, 6), textcoords="offset points",
                      fontsize=9, color=GRN)

    # --- Formula boxes (full piecewise expressions) ---
    ax_e.text(
        0.97, 0.72,
        r"$\mathbf{E(r):}$" "\n"
        r"$\quad r < R:\; E = kQr\,/\,R^3$" "\n"
        r"$\quad r \geq R:\; E = kQ\,/\,r^2$",
        transform=ax_e.transAxes, ha="right", va="top",
        fontsize=11, color=BLU, fontweight="bold", linespacing=1.5,
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )
    ax_v.text(
        0.97, 0.97,
        r"$\mathbf{V(r):}$" "\n"
        r"$\quad r \leq R:\; V = \frac{kQ}{2R}\!\left(3 - \frac{r^2}{R^2}\right)$"
        "\n"
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
    path = SPEC.save(fig, OUT_DIR / "charged_solid_sphere")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
