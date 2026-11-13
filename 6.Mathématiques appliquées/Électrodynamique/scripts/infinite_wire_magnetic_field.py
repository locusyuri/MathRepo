"""Magnetic field around an infinite straight current-carrying wire.

Two-panel physics-textbook illustration (serif, line-art style), side by side:
  * Left:  3D view of a vertical wire with concentric circular magnetic field
           rings (right-hand rule) and a tangential B vector.
  * Right: B(ρ) = μ₀I/(2πρ) vs. radial distance (single curve, no potential).

Run with:    uv run python src/infinite_wire_magnetic_field.py
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
MU0 = 4 * np.pi * 1e-7     # vacuum permeability, T·m/A
I_AMP = 10.0               # current, A  ->  μ₀I/(2π) = 2e-6

BLU = "#1f3b73"            # (unused; reserved)
RED = "#c0392b"            # wire / current
GRN = "#2e8b57"            # magnetic field lines + B vector
GREY = "#888888"

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
# Left panel — 3D wire with concentric magnetic field rings
# --------------------------------------------------------------------------- #
def draw_model(ax):
    ax.set_axis_off()
    ax.set_xlim(-3.5, 3.5)
    ax.set_ylim(-3.5, 3.5)
    ax.set_zlim(-3.5, 3.5)
    ax.set_box_aspect((1, 1, 1))
    ax.view_init(elev=18, azim=-60)

    ax.set_title("(a) Magnetic Field Around an Infinite Straight Wire",
                 fontsize=11, pad=8)

    # Wire: a vertical thin cylinder (red), along the z-axis.
    ax.plot([0, 0], [0, 0], [-3.2, 3.2], color=RED, lw=3.0, zorder=5)

    # Current direction arrow (upward) near the top of the wire.
    ax.add_artist(Arrow3D(
        (0, 0, 2.2), (0, 0, 1.0),
        arrowstyle="-|>", mutation_scale=16, color=RED, lw=3.0,
    ))
    ax.text(0.15, 0.15, 2.9, r"$I$", fontsize=14, color=RED, fontweight="bold")

    # z-axis label at the bottom.
    ax.text(0.10, 0.10, -3.2, r"$z$", fontsize=11, color="k")

    # Concentric circular magnetic field rings (right-hand rule: CCW from top).
    # All rings lie in the SAME horizontal plane (z = 0) as the ρ indicator,
    # forming true concentric circles — field strength varies only with ρ.
    ring_radii = [1.0, 1.7, 2.4, 3.0]
    for radius in ring_radii:
        theta = np.linspace(0, 2 * np.pi, 200)
        cx = radius * np.cos(theta)
        cy = radius * np.sin(theta)
        cz = np.zeros_like(theta)
        # front (y > 0) solid, back (y < 0) dashed
        front = cy > -0.02
        segs_front, segs_back = [], []
        for i in range(len(theta) - 1):
            seg = [(cx[i], cy[i], cz[i]), (cx[i + 1], cy[i + 1], cz[i + 1])]
            (segs_back if not front[i] else segs_front).append(seg)
        if segs_front:
            ax.add_collection3d(Line3DCollection(
                segs_front, colors=GRN, linewidths=1.4, alpha=0.85))
        if segs_back:
            ax.add_collection3d(Line3DCollection(
                segs_back, colors=GRN, linewidths=1.0, linestyles="--",
                alpha=0.5))

        # Direction arrow on each ring (tangential, CCW from top = +φ̂).
        # Fixed arc length so arrows look the same size on every ring;
        # direction is the exact unit tangent (-sinθ, cosθ) at angle θ.
        a0 = np.deg2rad(200)   # place on the back-left, away from B vector
        arc = 0.55              # fixed arrow length (data units)
        tx0, ty0 = -np.sin(a0), np.cos(a0)
        ax.add_artist(Arrow3D(
            (radius * np.cos(a0), radius * np.sin(a0), 0),
            (arc * tx0, arc * ty0, 0),
            arrowstyle="-|>", mutation_scale=11, color=GRN, lw=1.6,
        ))

    # Tangential B vector on the smallest ring (front-right point), at ρ.
    rho_pt = 1.0
    z_pt = 0.0
    a_pt = np.deg2rad(30)
    px = rho_pt * np.cos(a_pt)
    py = rho_pt * np.sin(a_pt)
    # tangent direction at this point: d/dθ (cosθ, sinθ) = (-sinθ, cosθ)
    tlen = 1.0
    tx = -np.sin(a_pt)
    ty = np.cos(a_pt)
    # ax.add_artist(Arrow3D(
    #     (px, py, z_pt), (tlen * tx, tlen * ty, 0),
    #     arrowstyle="-|>", mutation_scale=18, color=GRN, lw=2.8,
    # ))
    ax.text(px + 1.2, py + 1.55, z_pt, r"$\mathbf{B}(\rho)$",
            fontsize=13, color=GRN, fontweight="bold")

    # Radial ρ indicator: dashed double-arrow from wire axis to the B point
    # (projected onto z = 0 plane for clarity).
    ax.plot([0, px], [0, py], [0, 0], color=GREY, ls="--", lw=1.0)
    ax.text(px * 0.5 + 0.10, py * 0.5 - 0.25, 0.05, r"$\rho$",
            fontsize=13, color=GREY, style="italic")

    # Legend (2D handles projected into the 3D axes).
    handles = [
        Line2D([0], [0], color=RED, lw=3.0, marker=">",
               markersize=8, label="Current $I$"),
        Line2D([0], [0], color=GRN, ls="--", lw=1.6,
               label="Magnetic field lines"),
        Line2D([0], [0], color=GRN, lw=2.8, marker=">",
               markersize=8, label=r"$\mathbf{B}$ (field vector)"),
    ]
    ax.legend(handles=handles, loc="upper left", fontsize=8,
              frameon=True, edgecolor="#cccccc", facecolor="white",
              framealpha=0.9)


# --------------------------------------------------------------------------- #
# Right panel — B(ρ) vs. ρ (single curve, no potential)
# --------------------------------------------------------------------------- #
def draw_curves(ax):
    ax.set_title(r"(b) Magnetic Field Magnitude $B(\rho)$ vs. Radial Distance $\rho$",
                 fontsize=11, pad=8)

    rho = np.linspace(0.5, 5.0, 400)
    B = (MU0 * I_AMP) / (2 * np.pi * rho) * 1e6   # convert T → μT

    ax.plot(rho, B, color=GRN, lw=2.8, label=r"$B(\rho)$")

    ax.set_xlim(0.5, 5.0)
    ax.set_ylim(0, 5)
    ax.set_xlabel(r"Radial Distance $\rho$ (m)", fontsize=11)
    ax.set_ylabel(r"Magnetic Field $B(\rho)$ ($\mu$T)", fontsize=11, color=GRN)
    ax.set_xticks(np.arange(0.5, 5.01, 0.5))
    ax.set_yticks(np.arange(0, 5.01, 1.0))
    ax.tick_params(axis="y", labelcolor=GRN, labelsize=9)
    ax.tick_params(axis="x", labelsize=9)
    ax.grid(True, which="both", color="#dddddd", lw=0.6, ls="--")

    # B → 0 asymptote.
    ax.axhline(0, color=GREY, ls="--", lw=0.8)
    ax.text(4.9, 0.15, r"$B \rightarrow 0$", ha="right", va="bottom",
            fontsize=10, color=GREY, style="italic")

    # Marked characteristic points.
    pts = [(1.0, None), (2.0, None), (4.0, None)]
    for rr, _ in pts:
        bb = (MU0 * I_AMP) / (2 * np.pi * rr) * 1e6
        ax.scatter([rr], [bb], s=28, facecolor="white",
                   edgecolor=GRN, zorder=5)
        ax.annotate(f"B = {bb:.2f}", xy=(rr, bb),
                    xytext=(8, 8), textcoords="offset points",
                    fontsize=9, color=GRN)

    # Formula box (upper-right).
    ax.text(
        0.97, 0.85,
        r"$\mathbf{B(\rho) = \dfrac{\mu_0 I}{2\pi\,\rho}}$",
        transform=ax.transAxes, ha="right", va="top",
        fontsize=14, color=GRN, fontweight="bold",
        bbox=dict(boxstyle="round,pad=0.4", fc="white",
                  ec="#cccccc", lw=0.6),
    )

    # Legend.
    ax.legend(loc="upper right", fontsize=10, frameon=True,
              edgecolor="#cccccc", facecolor="white")


# --------------------------------------------------------------------------- #
# Build the figure
# --------------------------------------------------------------------------- #
def build_figure():
    fig = SPEC.figure()
    ax_model = fig.add_subplot(121, projection="3d")
    ax_b = fig.add_subplot(122)

    fig.subplots_adjust(left=0.07, right=0.97, top=0.92, bottom=0.10,
                        wspace=0.25)

    draw_model(ax_model)
    draw_curves(ax_b)

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "infinite_wire_magnetic_field")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
