"""Principal branch of the complex logarithm with branch cut.

Educational diagram showing:
- Branch cut along negative real axis (-∞, 0]
- Branch points at 0 and ∞
- Domain D = ℂ \ (-∞, 0]
- Sample point z = r·e^(iθ) with angle θ ∈ (-π, π)

Run with: uv run python src/math_paper/branch_cut_log.py
"""

from __future__ import annotations

from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import Arc, FancyArrowPatch

sys.path.insert(0, str(Path(__file__).resolve().parent))

from _viz import Presets

# --------------------------------------------------------------------------- #
# Configuration
# --------------------------------------------------------------------------- #
SPEC = Presets.SVG_MATH  # Square format
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

# Sample point
r = 1.8
theta = np.pi / 3  # 60 degrees

# --------------------------------------------------------------------------- #
# Build the figure
# --------------------------------------------------------------------------- #
def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111)

    ax.set_aspect("equal")
    ax.set_xlim(-3.5, 3.5)
    ax.set_ylim(-3.5, 3.5)

    # Domain shading (light blue, excluding branch cut)
    # Create a large circle for the domain
    domain_theta = np.linspace(0, 2 * np.pi, 300)
    domain_r = 3.3
    domain_x = domain_r * np.cos(domain_theta)
    domain_y = domain_r * np.sin(domain_theta)
    ax.fill(domain_x, domain_y, "#4a90d9", alpha=0.08, zorder=1)

    # Axes (thin, gray)
    ax.axhline(0, color="#888888", lw=0.8, zorder=2)
    ax.axvline(0, color="#888888", lw=0.8, zorder=2)

    # Branch cut: zigzag line along negative real axis
    cut_x = np.linspace(-3.3, 0, 50)
    cut_y = np.zeros_like(cut_x)
    # Add zigzag pattern
    zigzag_amplitude = 0.08
    for i in range(len(cut_x)):
        if i % 4 == 1:
            cut_y[i] = zigzag_amplitude
        elif i % 4 == 3:
            cut_y[i] = -zigzag_amplitude

    ax.plot(cut_x, cut_y, color="#c0392b", lw=2.5, zorder=5)

    # Branch point at origin (red dot)
    ax.scatter([0], [0], s=60, color="#c0392b", zorder=10)
    ax.text(0.15, -0.3, "0", fontsize=11, color="#c0392b", fontweight="bold")

    # Branch point at infinity (red dot at left edge)
    ax.scatter([-3.3], [0], s=60, color="#c0392b", zorder=10)
    ax.text(-3.2, -0.3, "∞", fontsize=11, color="#c0392b", fontweight="bold")

    # Branch cut label
    ax.text(-1.8, -0.5, "branch cut (-∞, 0]", fontsize=10, color="#c0392b",
            ha="center", fontweight="bold")

    # Domain label
    ax.text(1.5, 2.5, r"$D = \mathbb{C} \setminus (-\infty, 0]$", fontsize=12,
            color="#1f4e9b", fontweight="bold")

    # Sample point z = r·e^(iθ)
    z_x = r * np.cos(theta)
    z_y = r * np.sin(theta)
    ax.scatter([z_x], [z_y], s=70, color="#1f4e9b", zorder=8)
    ax.text(z_x + 0.2, z_y + 0.15, r"$z = r \cdot e^{i\theta}$", fontsize=11,
            color="#1f4e9b")

    # Radius line from origin to z
    ax.plot([0, z_x], [0, z_y], color="#1f4e9b", lw=1.5, ls="--", zorder=6)

    # Angle arc (from 0 to θ)
    arc_radius = 0.6
    arc_theta = np.linspace(0, theta, 50)
    arc_x = arc_radius * np.cos(arc_theta)
    arc_y = arc_radius * np.sin(arc_theta)
    ax.plot(arc_x, arc_y, color="#2e8b57", lw=2.0, zorder=7)

    # Angle label θ
    theta_label_angle = theta / 2
    theta_label_r = arc_radius + 0.2
    ax.text(theta_label_r * np.cos(theta_label_angle),
            theta_label_r * np.sin(theta_label_angle),
            r"$\theta$", fontsize=12, color="#2e8b57", ha="center", va="center",
            fontweight="bold")

    # Annotation: arg z ∈ (-π, π)
    ax.text(0, -3.0, r"arg $z \in (-\pi, \pi)$", fontsize=12, ha="center",
            color="#555555", fontweight="bold")

    # Title
    ax.set_title("Principal branch of ln z", fontsize=14, fontweight="bold",
                 pad=15)

    # Remove ticks for cleaner look
    ax.set_xticks([])
    ax.set_yticks([])

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "branch-cut-log")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
