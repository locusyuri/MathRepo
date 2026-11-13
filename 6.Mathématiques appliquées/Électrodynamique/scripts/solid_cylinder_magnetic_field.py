"""Magnetic field and vector potential of a uniformly conducting solid cylinder.

Two-panel physics-textbook illustration (serif, line-art style), side by side:
  * Left:  3D side-view — grey cylinder with internal current density J,
           concentric magnetic field rings, and tangential B vectors.
  * Right: B(ρ) (solid green) and A_z(ρ) (dashed orange) vs. radial distance,
           dual y-axes.

Note: The vector potential A_z is continuous at ρ = R, which requires
choosing the gauge constant ρ₀ = R in the outside expression so that
A_z(R⁺) = A_z(R⁻) = 0.

Run with:    uv run python src/solid_cylinder_magnetic_field.py
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.lines import Line2D
from matplotlib.patches import FancyArrowPatch
from mpl_toolkits.mplot3d.art3d import Line3DCollection
from mpl_toolkits.mplot3d.proj3d import proj_transform

from _viz import Presets

# --------------------------------------------------------------------------- #
# Physical constants & scene
# --------------------------------------------------------------------------- #
MU0 = 4 * np.pi * 1e-7       # vacuum permeability, T·m/A
I_TOTAL = 50.0                # total current, A
R = 1.0                      # cylinder radius, m

RED = "#c0392b"
GRN = "#2e8b57"
GRN_DARK = "#1a6b3a"
ORG = "#d4740e"
GREY = "#888888"

# Convenience: μ₀I/(2π) = 1e-5 T·m = 10 μT·m
B_PRE = MU0 * I_TOTAL / (2 * np.pi)   # ≈ 1e-5 T·m

SPEC = Presets.PNG_TEXTBOOK
OUT_DIR = Path(__file__).resolve().parent.parent / "img"


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
# Left panel — 3D cylinder with magnetic field rings
# --------------------------------------------------------------------------- #
def draw_model(ax):
    ax.set_axis_off()
    ax.set_xlim(-4.0, 4.0)
    ax.set_ylim(-4.0, 4.0)
    ax.set_zlim(-3.5, 3.5)
    ax.set_box_aspect((1, 1, 0.9))
    ax.view_init(elev=20, azim=-55)

    ax.set_title(
        "(a) Magnetic Field of a Conducting Solid Cylinder",
        fontsize=11, pad=8,
    )

    S = 1.6  # visual scale for the 3D model panel

    # --- 3D semi-transparent grey cylinder (radius R, along z-axis) ---
    cyl_h = 3.0 * S
    theta_cyl = np.linspace(0, 2 * np.pi, 60)
    z_cyl = np.linspace(-cyl_h / 2, cyl_h / 2, 2)
    Theta_c, Z_c = np.meshgrid(theta_cyl, z_cyl)
    X_c = (R * S) * np.cos(Theta_c)
    Y_c = (R * S) * np.sin(Theta_c)
    ax.plot_surface(X_c, Y_c, Z_c, color="#d5d8dc", alpha=0.30,
                    edgecolor=GREY, linewidth=0.3, shade=False)

    # --- Current density J arrows (red, pointing up, inside cylinder) ---
    for x_off in (-0.5 * S, 0.0, 0.5 * S):
        for z_pos in np.linspace(-cyl_h / 3, cyl_h / 3, 4):
            ax.add_artist(Arrow3D(
                (x_off, 0, z_pos - 0.15 * S), (0, 0, 0.35 * S),
                arrowstyle="-|>", mutation_scale=9, color=RED, lw=1.8,
            ))

    # Current direction arrow on top.
    ax.add_artist(Arrow3D(
        (0, 0, cyl_h / 2 + 0.1 * S), (0, 0, 0.8 * S),
        arrowstyle="-|>", mutation_scale=14, color=RED, lw=2.5,
    ))
    ax.text(0.15 * S, 0.15 * S, cyl_h / 2 + 0.7 * S,
            r"$I = J\pi R^2$", fontsize=11, color=RED, fontweight="bold")

    # --- Concentric magnetic field rings (z = 0 plane, ρ > R) ---
    ring_radii = [r * S for r in (1.4, 2.0, 2.6, 3.2)]
    for radius in ring_radii:
        theta = np.linspace(0, 2 * np.pi, 200)
        cx = radius * np.cos(theta)
        cy = radius * np.sin(theta)
        cz = np.zeros_like(theta)
        front = cy > -0.02
        segs_f, segs_b = [], []
        for i in range(len(theta) - 1):
            seg = [(cx[i], cy[i], cz[i]), (cx[i + 1], cy[i + 1], cz[i + 1])]
            (segs_b if not front[i] else segs_f).append(seg)
        if segs_f:
            ax.add_collection3d(Line3DCollection(
                segs_f, colors=GRN, linewidths=1.3, alpha=0.85))
        if segs_b:
            ax.add_collection3d(Line3DCollection(
                segs_b, colors=GRN, linewidths=1.0,
                linestyles="--", alpha=0.5))
        # Tangential direction arrow (CCW, +φ̂).
        a0 = np.deg2rad(200)
        arc = 0.55 * S
        ax.add_artist(Arrow3D(
            (radius * np.cos(a0), radius * np.sin(a0), 0),
            (arc * (-np.sin(a0)), arc * np.cos(a0), 0),
            arrowstyle="-|>", mutation_scale=11, color=GRN, lw=1.5,
        ))

    # --- B vector OUTSIDE (tangential, on smallest ring) ---
    rho_out = 1.4 * S
    a_out = np.deg2rad(30)
    px, py = rho_out * np.cos(a_out), rho_out * np.sin(a_out)
    tlen_out = 0.9 * S
    # ax.add_artist(Arrow3D(
    #     (px, py, 0),
    #     (tlen_out * (-np.sin(a_out)), tlen_out * np.cos(a_out), 0),
    #     arrowstyle="-|>", mutation_scale=16, color=GRN_DARK, lw=2.6,
    # ))
    ax.text(px - 0.25 * S, py + 0.95 * S, 0.15 * S,
            r"$\mathbf{B}(\rho)$", fontsize=13,
            color=GRN_DARK, fontweight="bold")

    # --- B vector INSIDE (tangential, shorter, B ∝ ρ) ---
    rho_in = 0.55 * S
    a_in = np.deg2rad(30)
    px2, py2 = rho_in * np.cos(a_in), rho_in * np.sin(a_in)
    tlen_in = 0.45 * S   # shorter than outside
    ax.add_artist(Arrow3D(
        (px2, py2, 0),
        (tlen_in * (-np.sin(a_in)), tlen_in * np.cos(a_in), 0),
        arrowstyle="-|>", mutation_scale=13, color=GRN_DARK, lw=2.0,
    ))
    ax.text(px2 - 0.55 * S, py2 + 0.5 * S, 0.15 * S,
            r"$B \propto \rho$", fontsize=11,
            color=GRN_DARK, fontweight="bold")

    # --- ρ indicator (horizontal dashed from axis to outside B point) ---
    ax.plot([0, px], [0, py], [0, 0], color=GREY, ls="--", lw=1.0)
    ax.text(px * 0.5 + 0.10 * S, -0.25 * S, 0.05 * S, r"$\rho$",
            fontsize=12, color=GREY, style="italic")

    # --- R indicator (from axis to surface) ---
    ax.add_artist(Arrow3D(
        (0, 0, 0.05 * S), (R * S + 0.05 * S, 0, 0),
        arrowstyle="-|>", mutation_scale=12, color="k", lw=1.0,
    ))
    ax.text(R * S / 2, -0.25 * S, 0.15 * S, "R", fontsize=12, style="italic")

    # --- Legend ---
    handles = [
        Line2D([0], [0], color=RED, lw=2.5, marker=">",
               markersize=8, label="Current density $J$"),
        Line2D([0], [0], color=GRN, ls="--", lw=1.5,
               label="Magnetic field lines"),
        Line2D([0], [0], color=GRN_DARK, lw=2.5, marker=">",
               markersize=8, label=r"$\mathbf{B}$ (field vector)"),
    ]
    ax.legend(handles=handles, loc="upper left", fontsize=8,
              frameon=True, edgecolor="#cccccc", facecolor="white",
              framealpha=0.9)


# --------------------------------------------------------------------------- #
# Right panel — B(ρ) and A_z(ρ) dual curves
# --------------------------------------------------------------------------- #
def draw_curves(ax_b, ax_a):
    ax_b.set_title(
        r"(b) $B(\rho)$ and $A_z(\rho)$ vs. Radial Distance $\rho$",
        fontsize=11, pad=8,
    )

    r1 = np.linspace(0, R, 300)
    r2 = np.linspace(R, 4 * R, 400)

    # --- B(ρ): linear inside, 1/ρ outside ---
    B1 = (B_PRE * r1 / R**2) * 1e6          # → μT
    B2 = (B_PRE / r2) * 1e6

    ax_b.plot(r1, B1, color=GRN, lw=2.8)
    ax_b.plot(r2, B2, color=GRN, lw=2.8, label=r"$B(\rho)$")

    # --- A_z(ρ): parabola inside, log outside (continuous at ρ=R) ---
    # Gauge: ρ₀ = R → A_z(R⁺) = A_z(R⁻) = 0
    A1 = B_PRE * (R**2 - r1**2) / (2 * R**2) * 1e6   # → μWb/m
    A2 = B_PRE * np.log(R / r2) * 1e6                    # → μWb/m

    ax_a.plot(r1, A1, color=ORG, lw=2.4, ls="--",
              label=r"$A_z(\rho)$")
    ax_a.plot(r2, A2, color=ORG, lw=2.4, ls="--")

    # --- Shared x-axis ---
    ax_b.set_xlim(0, 4 * R)
    ax_b.set_xlabel(r"Radial Distance $\rho$ (m)", fontsize=10)
    ax_b.set_xticks(np.arange(0, 4 * R + 0.01, 1.0))
    ax_b.tick_params(axis="x", labelsize=8)

    # --- Left y-axis: B ---
    ax_b.set_ylim(0, 12)
    ax_b.set_ylabel(r"$B(\rho)$ ($\mu$T)", fontsize=10, color=GRN)
    ax_b.set_yticks(np.arange(0, 13, 2))
    ax_b.tick_params(axis="y", labelcolor=GRN, labelsize=8)
    ax_b.spines["left"].set_color(GRN)

    # --- Right y-axis: A_z ---
    ax_a.set_ylim(-15, 12)
    ax_a.set_ylabel(r"$A_z$ ($\mu$Wb/m)", fontsize=10, color=ORG)
    ax_a.set_yticks(np.arange(-15, 13, 5))
    ax_a.tick_params(axis="y", labelcolor=ORG, labelsize=8)
    ax_a.spines["right"].set_color(ORG)

    # --- Vertical dashed line at ρ = R ---
    ax_b.axvline(R, color=GREY, ls="--", lw=1.0, zorder=0)
    ax_b.text(R + 0.05, 11.5, r"$\rho = R$", fontsize=9, color="k")

    # --- Zero lines ---
    ax_b.axhline(0, color=GREY, ls="-", lw=0.4, zorder=0)
    ax_a.axhline(0, color=GREY, ls="--", lw=0.6, zorder=0)

    # --- Asymptote B → 0 ---
    ax_b.text(4 * R - 0.1, 0.5, r"$B \rightarrow 0$",
              ha="right", va="bottom", fontsize=9,
              color=GREY, style="italic")

    # --- Grid ---
    ax_b.grid(True, which="both", color="#dddddd", lw=0.6)

    # --- Marked points: B ---
    for rr, val in ((1.0, 10.0), (2.0, 5.0)):
        bb = B_PRE / rr * 1e6
        ax_b.scatter([rr], [bb], s=24, facecolor="white",
                     edgecolor=GRN, zorder=5)
        ax_b.annotate(f"B = {val:g}", xy=(rr, bb),
                      xytext=(8, 8), textcoords="offset points",
                      fontsize=9, color=GRN)

    # --- Marked points: A_z ---
    # A_z(0) = B_PRE * R² / (2R²) * 1e6 = B_PRE/2 * 1e6 = 5 μWb/m
    az0 = B_PRE / 2 * 1e6
    ax_a.scatter([0], [az0], s=24, facecolor="white",
                edgecolor=ORG, zorder=5)
    ax_a.annotate(f"$A_z$ = {az0:g}", xy=(0, az0),
                  xytext=(10, 6), textcoords="offset points",
                  fontsize=9, color=ORG)

    # A_z at R (continuity check) = 0
    ax_a.scatter([R], [0], s=24, facecolor="white",
                 edgecolor=ORG, zorder=5)
    ax_a.annotate("$A_z$ = 0", xy=(R, 0),
                  xytext=(10, -12), textcoords="offset points",
                  fontsize=9, color=ORG)

    # --- Formula boxes ---
    ax_b.text(
        0.97, 0.58,
        r"$\mathbf{B(\rho):}$" "\n"
        r"$\quad \rho < R:\; B = \dfrac{\mu_0 J\rho}{2}$"
        "\n\n"
        r"$\quad \rho \geq R:\; B = \dfrac{\mu_0 I}{2\pi\rho}$",
        transform=ax_b.transAxes, ha="right", va="top",
        fontsize=11, color=GRN, fontweight="bold", linespacing=1.7,
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )
    ax_a.text(
        0.97, 0.85,
        r"$\mathbf{A_z(\rho):}$" "\n"
        r"$\quad \rho < R:\; A_z = \dfrac{\mu_0 J(R^2-\rho^2)}{4}$"
        "\n\n"
        r"$\quad \rho \geq R:\; A_z = \dfrac{\mu_0 I}{2\pi}\ln\dfrac{R}{\rho}$",
        transform=ax_a.transAxes, ha="right", va="top",
        fontsize=11, color=ORG, fontweight="bold", linespacing=1.7,
        bbox=dict(boxstyle="round,pad=0.35", fc="white",
                  ec="#cccccc", lw=0.6),
    )

    # --- Legend ---
    handles = [
        Line2D([0], [0], color=GRN, lw=2.8, label=r"$B(\rho)$"),
        Line2D([0], [0], color=ORG, lw=2.4, ls="--", label=r"$A_z(\rho)$"),
    ]
    ax_b.legend(handles=handles, loc="upper right", fontsize=9,
                frameon=True, edgecolor="#cccccc", facecolor="white")


# --------------------------------------------------------------------------- #
# Build the figure
# --------------------------------------------------------------------------- #
def build_figure():
    fig = SPEC.figure()
    ax_model = fig.add_subplot(121, projection="3d")
    ax_b = fig.add_subplot(122)
    ax_a = ax_b.twinx()

    fig.subplots_adjust(left=0.07, right=0.93, top=0.92, bottom=0.10,
                        wspace=0.28)

    draw_model(ax_model)
    draw_curves(ax_b, ax_a)

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "solid_cylinder_magnetic_field")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
