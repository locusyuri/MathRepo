"""Exponential mapping w = e^z illustration.

Two-panel figure showing how the exponential function maps:
- Vertical lines Re(z) = c in z-plane → circles |w| = e^c in w-plane
- Horizontal lines Im(z) = c in z-plane → rays arg(w) = c in w-plane

The strip 0 ≤ Im(z) ≤ 2π maps to the entire w-plane (punctured at origin).

Run with: uv run python src/math_paper/exp_mapping.py
"""

from __future__ import annotations

from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import Circle

sys.path.insert(0, str(Path(__file__).resolve().parent))

from _viz import Presets

# --------------------------------------------------------------------------- #
# Configuration
# --------------------------------------------------------------------------- #
SPEC = Presets.SVG_MATH_PANEL
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

# Mapping function
def f(z):
    return np.exp(z)

# --------------------------------------------------------------------------- #
# Build the figure
# --------------------------------------------------------------------------- #
def build_figure():
    fig = SPEC.figure()

    # =========================================================================
    # Left panel: z-plane
    # =========================================================================
    ax_z = fig.add_subplot(121)
    ax_z.set_title("z-plane", fontsize=14, pad=10, fontweight="bold")
    ax_z.set_aspect("equal")
    ax_z.grid(True, color="#dddddd", lw=0.6, zorder=0)
    ax_z.axhline(0, color="k", lw=1.0, zorder=1)
    ax_z.axvline(0, color="k", lw=1.0, zorder=1)
    ax_z.set_xlim(-2.5, 2.5)
    ax_z.set_ylim(-0.5, 7.0)
    ax_z.set_xlabel("Re z", fontsize=11, loc="right")
    ax_z.set_ylabel("Im z", fontsize=11, rotation=0, loc="top")
    ax_z.text(0, -0.3, "O", fontsize=10, ha="right", va="top")

    # Horizontal strip boundaries (Im z = 0 and Im z = 2π)
    ax_z.axhline(0, color="#888888", ls="--", lw=1.2, zorder=2)
    ax_z.axhline(2 * np.pi, color="#888888", ls="--", lw=1.2, zorder=2)
    ax_z.text(2.3, 0.15, "Im z = 0", fontsize=9, color="#888888", ha="right")
    ax_z.text(2.3, 2 * np.pi + 0.15, "Im z = 2π", fontsize=9, color="#888888", ha="right")

    # Vertical line Re(z) = c (maps to circle |w| = e^c)
    c_vert = 0.5
    ax_z.axvline(c_vert, color="#1f4e9b", lw=2.0, zorder=3)
    ax_z.text(c_vert + 0.1, 3.5, "Re z = c", fontsize=10, color="#1f4e9b", va="center")

    # Horizontal line Im(z) = c (maps to ray arg(w) = c)
    c_horiz = np.pi / 2
    ax_z.axhline(c_horiz, color="#2e8b57", lw=2.0, zorder=3, xmin=0.0, xmax=0.95)
    ax_z.text(1.8, c_horiz + 0.2, "Im z = c", fontsize=10, color="#2e8b57")

    # =========================================================================
    # Right panel: w-plane
    # =========================================================================
    ax_w = fig.add_subplot(122)
    ax_w.set_title("w-plane", fontsize=14, pad=10, fontweight="bold")
    ax_w.set_aspect("equal")
    ax_w.grid(True, color="#dddddd", lw=0.6, zorder=0)
    ax_w.axhline(0, color="k", lw=1.0, zorder=1)
    ax_w.axvline(0, color="k", lw=1.0, zorder=1)
    ax_w.set_xlim(-3.5, 3.5)
    ax_w.set_ylim(-3.5, 3.5)
    ax_w.set_xlabel("Re w", fontsize=11, loc="right")
    ax_w.set_ylabel("Im w", fontsize=11, rotation=0, loc="top")
    ax_w.text(0, -0.25, "O", fontsize=10, ha="right", va="top")

    # Punctured origin (e^z ≠ 0)
    ax_w.scatter([0], [0], s=50, facecolor="white", edgecolor="k", lw=1.5, zorder=5)
    ax_w.text(0.15, 0.15, "0\npunctured", fontsize=8, va="bottom", color="#888888")

    # Circle |w| = e^c (image of vertical line Re(z) = c)
    radius = np.exp(c_vert)
    theta = np.linspace(0, 2 * np.pi, 200)
    ax_w.plot(radius * np.cos(theta), radius * np.sin(theta),
              color="#1f4e9b", lw=2.0, zorder=3)
    ax_w.text(radius + 0.15, 0, "|w| = eᶜ", fontsize=10, color="#1f4e9b", va="center")

    # Ray arg(w) = c (image of horizontal line Im(z) = c)
    r_ray = np.linspace(0.1, 3.2, 100)
    ax_w.plot(r_ray * np.cos(c_horiz), r_ray * np.sin(c_horiz),
              color="#2e8b57", lw=2.0, zorder=3)
    ax_w.text(2.5 * np.cos(c_horiz) + 0.2, 2.5 * np.sin(c_horiz) + 0.2,
              "arg w = c", fontsize=10, color="#2e8b57")

    # Additional concentric circles (faint, for illustration)
    for r in [0.5, 1.5, 2.5]:
        if r != radius:
            ax_w.plot(r * np.cos(theta), r * np.sin(theta),
                      color="#1f4e9b", lw=0.8, alpha=0.4, zorder=2)

    # Additional rays (faint, for illustration)
    for angle in [0, np.pi / 4, np.pi, 3 * np.pi / 2]:
        if abs(angle - c_horiz) > 0.1:
            r_ray = np.linspace(0.1, 3.2, 100)
            ax_w.plot(r_ray * np.cos(angle), r_ray * np.sin(angle),
                      color="#2e8b57", lw=0.8, alpha=0.4, zorder=2)

    # =========================================================================
    # Mapping arrow and label (between panels)
    # =========================================================================
    # Curved arrow between panels (figure-relative coordinates)
    ax_z.annotate(
        "",
        xy=(0.41, 0.50), xycoords="figure fraction",
        xytext=(0.28, 0.50), textcoords="figure fraction",
        arrowprops=dict(
            arrowstyle="-|>",
            connectionstyle="arc3,rad=-0.3",
            color="#c0392b",
            lw=2.5,
            mutation_scale=30,
        ),
    )

    fig.text(0.48, 0.6, r"$w = e^z$", fontsize=14, ha="center", va="center",
             fontweight="bold")

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "exp_mapping")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
