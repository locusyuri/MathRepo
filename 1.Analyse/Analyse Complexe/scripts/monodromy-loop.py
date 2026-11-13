"""Monodromy around a branch point illustration.

Educational diagram showing how analytic continuation around a branch point
leads to a different value of a multi-valued function (e.g., log z).

Key elements:
- Branch point at origin (red dot)
- Loop γ encircling the origin counterclockwise
- Point z₀ on the loop with two values (before/after one traversal)
- Inset showing spiral rise of values

Run with: uv run python src/math_paper/monodromy_loop.py
"""

from __future__ import annotations

from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import Circle, FancyArrowPatch, Arc

sys.path.insert(0, str(Path(__file__).resolve().parent))

from _viz import Presets

# --------------------------------------------------------------------------- #
# Configuration
# --------------------------------------------------------------------------- #
SPEC = Presets.SVG_MATH  # Square format
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

# Loop parameters
loop_radius = 1.5
z0_angle = np.pi / 4  # 45 degrees

# --------------------------------------------------------------------------- #
# Build the figure
# --------------------------------------------------------------------------- #
def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)

    ax.set_aspect("equal")
    ax.set_xlim(-3.0, 3.0)
    ax.set_ylim(-3.0, 3.0)

    # Grid (subtle)
    ax.grid(True, color="#eeeeee", lw=0.5, zorder=0)

    # Axes
    ax.axhline(0, color="k", lw=0.8, zorder=1)
    ax.axvline(0, color="k", lw=0.8, zorder=1)

    # Branch point at origin (red dot)
    ax.scatter([0], [0], s=80, color="#c0392b", zorder=10)
    ax.text(0.15, -0.25, "branch point 0", fontsize=10, color="#c0392b",
            fontweight="bold")

    # Loop γ (counterclockwise circle with arrow)
    theta = np.linspace(0, 2 * np.pi, 200)
    loop_x = loop_radius * np.cos(theta)
    loop_y = loop_radius * np.sin(theta)
    ax.plot(loop_x, loop_y, color="#1f4e9b", lw=2.0, zorder=5)

    # Arrow on the loop (at top)
    arrow_angle = np.pi / 2
    arrow_x = loop_radius * np.cos(arrow_angle)
    arrow_y = loop_radius * np.sin(arrow_angle)
    arrow = FancyArrowPatch(
        (arrow_x - 0.15, arrow_y),
        (arrow_x + 0.15, arrow_y),
        arrowstyle="-|>",
        mutation_scale=20,
        color="#1f4e9b",
        lw=2.0,
        zorder=6,
    )
    ax.add_patch(arrow)

    # Label γ
    ax.text(0, loop_radius + 0.3, r"$\gamma$", fontsize=14, ha="center",
            color="#1f4e9b", fontweight="bold")

    # Point z₀ on the loop
    z0_x = loop_radius * np.cos(z0_angle)
    z0_y = loop_radius * np.sin(z0_angle)

    # Starting value (blue open circle)
    ax.scatter([z0_x], [z0_y], s=70, facecolor="white", edgecolor="#1f4e9b",
               lw=2.0, zorder=8)
    ax.text(z0_x + 0.2, z0_y + 0.15, r"$z_0$", fontsize=12, color="#1f4e9b")

    # Value after one loop (orange filled circle, slightly offset)
    offset = 0.25
    z0_after_x = z0_x + offset * np.cos(z0_angle + np.pi / 2)
    z0_after_y = z0_y + offset * np.sin(z0_angle + np.pi / 2)
    ax.scatter([z0_after_x], [z0_after_y], s=70, color="#e67e22", zorder=8)

    # Curved arrow connecting the two values (helix/ramp symbol)
    mid_x = (z0_x + z0_after_x) / 2 + 0.15
    mid_y = (z0_y + z0_after_y) / 2 + 0.15
    ax.annotate(
        "",
        xy=(z0_after_x, z0_after_y),
        xytext=(z0_x, z0_y),
        arrowprops=dict(
            arrowstyle="-|>",
            connectionstyle="arc3,rad=0.4",
            color="#888888",
            lw=1.5,
            mutation_scale=15,
        ),
    )

    # Label for value change
    ax.text(z0_x + 0.5, z0_y + 0.5, r"$+2\pi i$", fontsize=11,
            color="#e67e22", fontweight="bold")

    # Caption
    ax.text(0, -2.7, "value changes after one loop", fontsize=11,
            ha="center", style="italic", color="#555555")

    # =========================================================================
    # Inset: spiral showing value rise
    # =========================================================================
    # Small inset in the corner showing the spiral structure
    inset_ax = fig.add_axes([0.65, 0.65, 0.25, 0.25])  # [left, bottom, width, height]

    # Spiral: r increases with angle
    theta_spiral = np.linspace(0, 4 * np.pi, 300)
    r_spiral = 0.2 + 0.15 * theta_spiral / (2 * np.pi)
    x_spiral = r_spiral * np.cos(theta_spiral)
    y_spiral = r_spiral * np.sin(theta_spiral)

    inset_ax.plot(x_spiral, y_spiral, color="#2e8b57", lw=2.0)

    # Mark one loop
    loop_end_idx = np.argmin(np.abs(theta_spiral - 2 * np.pi))
    inset_ax.scatter([x_spiral[loop_end_idx]], [y_spiral[loop_end_idx]],
                     s=40, color="#e67e22", zorder=5)

    # Arrow showing rise
    inset_ax.annotate(
        "",
        xy=(x_spiral[loop_end_idx], y_spiral[loop_end_idx]),
        xytext=(x_spiral[0], y_spiral[0]),
        arrowprops=dict(
            arrowstyle="-|>",
            connectionstyle="arc3,rad=-0.3",
            color="#c0392b",
            lw=1.5,
            mutation_scale=12,
        ),
    )

    inset_ax.set_aspect("equal")
    inset_ax.set_xlim(-1.5, 1.5)
    inset_ax.set_ylim(-1.5, 1.5)
    inset_ax.axis("off")
    inset_ax.text(0, -1.8, "Riemann surface", fontsize=9, ha="center",
                  color="#555555", transform=inset_ax.transAxes)

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "monodromy-loop")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
