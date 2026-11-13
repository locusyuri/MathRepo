"""Electric field and potential of an electric dipole (on-axis).

Two-panel physics-textbook illustration (serif, line-art style), side by side:
  * Left:  3D view of a dipole (+q above, -q below) with curved field lines
           running from +q to -q, and the dipole moment p arrow.
  * Right: E(z) and V(z) along the dipole axis, dual y-axes.

Run with:    uv run python src/electric_field/electric_dipole.py
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.lines import Line2D
from matplotlib.patches import FancyArrowPatch
from mpl_toolkits.mplot3d.proj3d import proj_transform

from _viz import Presets


class Arrow3D(FancyArrowPatch):
    """FancyArrowPatch that projects correctly in 3D axes."""

    def __init__(self, start, vec, *args, **kwargs):
        super().__init__((0, 0), (0, 0), *args, **kwargs)
        self._xyz = tuple(start)
        self._dxdydz = tuple(vec)

    def do_3d_projection(self, renderer=None):
        x1, y1, z1 = self._xyz
        dx, dy, dz = self._dxdydz
        x2, y2, z2 = x1 + dx, y1 + dy, z1 + dz
        xs, ys, zs = proj_transform(
            (x1, x2), (y1, y2), (z1, z2), self.axes.M
        )
        self.set_positions((xs[0], ys[0]), (xs[1], ys[1]))
        return float(np.min(zs))


# --------------------------------------------------------------------------- #
# Physical constants & scene
# --------------------------------------------------------------------------- #
K_COULOMB = 8.988e9    # 1/(4πε₀), N·m²/C²
Q = 1.0e-9             # charge magnitude, C
D = 1.0                # charge separation, m
P = Q * D              # dipole moment, C·m

BLU = "#1f4e9b"
RED = "#c0392b"
GRN = "#2e8b57"
GREY = "#888888"

SPEC = Presets.PNG_TEXTBOOK
OUT_DIR = Path(__file__).resolve().parent.parent / "img"


# --------------------------------------------------------------------------- #
# Left panel — 3D model of electric dipole with field lines
# --------------------------------------------------------------------------- #
def draw_model(ax):
    ax.set_axis_off()
    ax.set_xlim(-3, 3)
    ax.set_ylim(-3, 3)
    ax.set_zlim(-3, 3)
    ax.set_box_aspect((1, 1, 1))
    ax.view_init(elev=18, azim=-55)

    ax.set_title("Model of Electric Dipole",
                 fontsize=12, pad=8)

    z_half = D / 2

    # z-axis line.
    ax.plot([0, 0], [0, 0], [-2.8, 2.8], color="k", lw=0.8, ls="-")
    ax.text(0.1, 0.1, 2.9, r"$z$", fontsize=13, color="k")

    # +q charge (red sphere).
    ax.scatter([0], [0], [z_half], s=120, color=RED, zorder=5)
    ax.text(0.25, 0, z_half + 0.15, r"$+q$", fontsize=13, color=RED,
            fontweight="bold")

    # -q charge (blue sphere).
    ax.scatter([0], [0], [-z_half], s=120, color=BLU, zorder=5)
    ax.text(0.25, 0, -z_half - 0.25, r"$-q$", fontsize=13, color=BLU,
            fontweight="bold")

    # Dipole moment arrow p (from -q to +q, along +z).
    ax.add_artist(Arrow3D(
        (-0.6, 0, -z_half + 0.1), (0, 0, D - 0.2),
        arrowstyle="-|>", mutation_scale=14,
        color="k", lw=2.0,
    ))
    ax.text(-0.85, 0, 0, r"$\vec{p}$", fontsize=14, color="k",
            fontweight="bold", ha="center", va="center")

    # Field lines from +q to -q (parametric curves in xz-plane).
    # r(t) = w·sin²(t), z(t) = z_half·cos(t),  t ∈ [0, π]
    t = np.linspace(0, np.pi, 100)
    widths = [0.5, 0.9, 1.4, 2.0]
    for w in widths:
        r = w * np.sin(t) ** 2
        z_line = z_half * np.cos(t)
        # Draw in two azimuthal planes (front and side).
        for phi in [0, np.pi / 2, np.pi, 3 * np.pi / 2]:
            x_line = r * np.cos(phi)
            y_line = r * np.sin(phi)
            ax.plot(x_line, y_line, z_line,
                    color=RED, lw=1.0, alpha=0.55, zorder=2)

    # Small arrowheads on a few field lines to show direction (+q → -q).
    for w in [0.9, 1.4]:
        t_mid = np.pi * 0.55
        r_mid = w * np.sin(t_mid) ** 2
        z_mid = z_half * np.cos(t_mid)
        # Tangent direction (toward increasing t = toward -q).
        dt = 0.05
        r_next = w * np.sin(t_mid + dt) ** 2
        z_next = z_half * np.cos(t_mid + dt)
        dr = r_next - r_mid
        dz = z_next - z_mid
        ax.add_artist(Arrow3D(
            (r_mid, 0, z_mid), (dr, 0, dz),
            arrowstyle="-|>", mutation_scale=10,
            color=RED, lw=1.4,
        ))

    # Separation label "d".
    ax.plot([1.0, 1.0], [0, 0], [-z_half, z_half], color="k", lw=1.0)
    ax.text(1.15, 0, 0, "d", fontsize=13, style="italic",
            va="center", ha="left")

    # Legend.
    handles = [
        Line2D([0], [0], marker="o", color=RED, markersize=10,
               markerfacecolor=RED, linestyle="none",
               label=r"$+q$"),
        Line2D([0], [0], marker="o", color=BLU, markersize=10,
               markerfacecolor=BLU, linestyle="none",
               label=r"$-q$"),
        Line2D([0], [0], color=RED, lw=1.4,
               label="Field lines"),
        Line2D([0], [0], color="k", lw=2.0, marker=">",
               markersize=7, label=r"Dipole moment $\vec{p}$"),
    ]
    ax.legend(handles=handles, loc="lower right", fontsize=8,
              frameon=True, edgecolor="#cccccc", facecolor="white",
              framealpha=0.9)


# --------------------------------------------------------------------------- #
# Right panel — E(z) and V(z) along dipole axis, dual y-axes
# --------------------------------------------------------------------------- #
def draw_curves(ax_e, ax_v):
    ax_e.set_title("Field and Potential of Electric Dipole (along axis)",
                   fontsize=11, pad=8)

    z_half = D / 2
    TWO_KP = 2 * K_COULOMB * P

    # Three z-regions (avoid singularities at z = ±d/2).
    eps = 0.012
    z_far_neg = np.linspace(-4 * D, -z_half - eps, 250)
    z_mid = np.linspace(-z_half + eps, z_half - eps, 300)
    z_far_pos = np.linspace(z_half + eps, 4 * D, 250)

    # E_z(z) = 2kpz / (z² - d²/4)²
    def _e_z(z):
        return TWO_KP * z / (z ** 2 - z_half ** 2) ** 2

    E_far_neg = _e_z(z_far_neg)
    E_mid = _e_z(z_mid)
    E_far_pos = _e_z(z_far_pos)

    ax_e.plot(z_far_neg, E_far_neg, color=BLU, lw=2.8)
    ax_e.plot(z_mid, E_mid, color=BLU, lw=2.8)
    ax_e.plot(z_far_pos, E_far_pos, color=BLU, lw=2.8, label=r"$E(z)$")

    # V(z): odd function
    def _v_z(z):
        az = np.abs(z)
        denom = np.abs(z ** 2 - z_half ** 2)
        sign = np.where(z > 0, 1.0, -1.0)
        return sign * K_COULOMB * P * 2 * az / denom

    V_far_neg = _v_z(z_far_neg)
    V_mid = _v_z(z_mid)
    V_far_pos = _v_z(z_far_pos)

    ax_v.plot(z_far_neg, V_far_neg, color=GRN, lw=2.8)
    ax_v.plot(z_mid, V_mid, color=GRN, lw=2.8)
    ax_v.plot(z_far_pos, V_far_pos, color=GRN, lw=2.8, label=r"$V(z)$")

    # --- Shared x-axis ---
    ax_e.set_xlim(-4 * D, 4 * D)
    ax_e.set_xlabel("Distance z (m)", fontsize=10)
    ax_e.set_xticks(np.arange(-4 * D, 4 * D + 0.01, D))
    ax_e.set_xticklabels([
        r"$-4d$", r"$-3d$", r"$-2d$", r"$-d$",
        "0", r"$d$", r"$2d$", r"$3d$", r"$4d$",
    ])

    # --- Left y-axis: E ---
    ax_e.set_ylim(-80, 80)
    ax_e.set_ylabel("E (N/C)", fontsize=10, color=BLU)
    ax_e.set_yticks(np.arange(-60, 61, 30))
    ax_e.tick_params(axis="y", labelcolor=BLU, labelsize=8)

    # --- Right y-axis: V ---
    ax_v.set_ylim(-50, 50)
    ax_v.set_ylabel("V (V)", fontsize=10, color=GRN)
    ax_v.set_yticks(np.arange(-40, 41, 20))
    ax_v.tick_params(axis="y", labelcolor=GRN, labelsize=8)
    ax_v.spines["right"].set_color(GRN)
    ax_v.spines["left"].set_color(BLU)

    # --- Vertical dashed lines ---
    ax_e.axvline(0, color=GREY, ls="--", lw=1.0, zorder=0)
    ax_e.axvline(z_half, color=GREY, ls="--", lw=0.8, zorder=0)
    ax_e.axvline(-z_half, color=GREY, ls="--", lw=0.8, zorder=0)
    ax_e.text(0.08, 76, r"$z = 0$", fontsize=9, color="k", va="top")
    ax_e.text(z_half + 0.06, 76, r"$+d/2$", fontsize=8, color=GREY, va="top")
    ax_e.text(-z_half - 0.06, 76, r"$-d/2$", fontsize=8, color=GREY,
              va="top", ha="right")

    # --- Grid ---
    ax_e.grid(True, which="both", color="#dddddd", lw=0.6)
    ax_e.tick_params(axis="x", labelsize=7)

    # --- Asymptotes ---
    ax_e.axhline(0, color=GREY, ls="--", lw=0.6)
    ax_e.text(4 * D - 0.1, 0, r"$E \rightarrow 0$",
              ha="right", va="bottom", fontsize=9, color=GREY, style="italic")
    ax_v.text(4 * D - 0.1, 3, r"$V \rightarrow 0$",
              ha="right", va="bottom", fontsize=9, color=GREY, style="italic")

    # Decay rate annotations.
    ax_e.text(3.5 * D, -5, r"$E \propto 1/|z|^3$",
              fontsize=9, color=BLU, style="italic")
    ax_v.text(3.5 * D, 7, r"$V \propto 1/z^2$",
              fontsize=9, color=GRN, style="italic")

    # --- Marked points ---
    # V(0) = 0
    ax_v.scatter([0], [0], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)
    ax_v.annotate(r"$V(0) = 0$", xy=(0, 0),
                  xytext=(12, 10), textcoords="offset points",
                  fontsize=10, color=GRN)

    # E(0) = 0
    ax_e.scatter([0], [0], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)

    # Charge position markers.
    ax_e.scatter([z_half], [0], s=30, color=RED, marker="|",
                 linewidths=2, zorder=5)
    ax_e.scatter([-z_half], [0], s=30, color=BLU, marker="|",
                 linewidths=2, zorder=5)

    # E value at z = d (far field example).
    e_at_d = _e_z(D)
    ax_e.scatter([D], [e_at_d], s=24, facecolor="white",
                 edgecolor=BLU, zorder=5)
    ax_e.annotate(f"E = {e_at_d:.1f}", xy=(D, e_at_d),
                  xytext=(8, 10), textcoords="offset points",
                  fontsize=9, color=BLU)

    # V value at z = d.
    v_at_d = _v_z(D)
    ax_v.scatter([D], [v_at_d], s=24, facecolor="white",
                 edgecolor=GRN, zorder=5)
    ax_v.annotate(f"V = {v_at_d:.1f}", xy=(D, v_at_d),
                  xytext=(8, -14), textcoords="offset points",
                  fontsize=9, color=GRN)

    # --- Formula boxes ---
    ax_e.text(
        0.03, 0.97,
        r"$\mathbf{E(z) = \dfrac{2kpz}{(z^2 - d^2/4)^2}}$"
        "\n\n"
        r"$\quad |z| \gg d:\; E \approx \dfrac{2kp}{|z|^3}$",
        transform=ax_e.transAxes, ha="left", va="top",
        fontsize=10, color=BLU, fontweight="bold", linespacing=1.5,
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )
    ax_v.text(
        0.03, 0.55,
        r"$\mathbf{V(z) = \pm\dfrac{kp}{(z \mp d/2)^2}}$"
        "\n\n"
        r"$\quad |z| \gg d:\; V \approx \dfrac{kp}{z^2}$",
        transform=ax_v.transAxes, ha="left", va="top",
        fontsize=10, color=GRN, fontweight="bold", linespacing=1.5,
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )

    # --- Legend ---
    handles = [
        Line2D([0], [0], color=BLU, lw=2.8, label=r"$E(z)$"),
        Line2D([0], [0], color=GRN, lw=2.8, label=r"$V(z)$"),
    ]
    ax_e.legend(handles=handles, loc="lower right", fontsize=9,
                frameon=True, edgecolor="#cccccc", facecolor="white")


# --------------------------------------------------------------------------- #
# Build the figure
# --------------------------------------------------------------------------- #
def build_figure():
    fig = SPEC.figure()
    ax_model = fig.add_subplot(121, projection="3d")
    ax_e = fig.add_subplot(122)
    ax_v = ax_e.twinx()

    fig.subplots_adjust(left=0.06, right=0.94, top=0.92, bottom=0.10,
                        wspace=0.30)

    draw_model(ax_model)
    draw_curves(ax_e, ax_v)

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "electric_dipole")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
