"""3D surface plot of |sin z| over the complex plane.

The modulus of sin(z) for z = x + iy is:
    |sin z| = sqrt(sin²x + sinh²y)

Features:
- Along real axis (y=0): |sin z| = |sin x|, oscillates between 0 and 1
- Along imaginary axis (x=0): |sin z| = |sinh y|, grows exponentially

Run with: uv run python src/math_paper/sin_modulus.py
"""

from __future__ import annotations

from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))

from _viz import Presets

# --------------------------------------------------------------------------- #
# Configuration
# --------------------------------------------------------------------------- #
SPEC = Presets.SVG_MATH  # Square format for 3D plot
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

# Domain
x_min, x_max = -2 * np.pi, 2 * np.pi
y_min, y_max = -2.5, 2.5
resolution = 200

# --------------------------------------------------------------------------- #
# Mathematical function
# --------------------------------------------------------------------------- #
def sin_modulus(x, y):
    """Compute |sin z| = sqrt(sin²x + sinh²y) for z = x + iy"""
    return np.sqrt(np.sin(x)**2 + np.sinh(y)**2)

# --------------------------------------------------------------------------- #
# Build the figure
# --------------------------------------------------------------------------- #
def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111, projection="3d")

    # Generate grid
    x = np.linspace(x_min, x_max, resolution)
    y = np.linspace(y_min, y_max, resolution)
    X, Y = np.meshgrid(x, y)
    Z = sin_modulus(X, Y)

    # Cap the z-values for better visualization (exponential growth)
    z_max = 8
    Z = np.clip(Z, 0, z_max)

    # Plot surface with soft blue colormap
    surf = ax.plot_surface(X, Y, Z, cmap="Blues", alpha=0.85,
                           edgecolor="none", antialiased=True)

    # Emphasize the real axis (y=0) with the sine wave profile
    y_zero_idx = np.argmin(np.abs(y))
    x_line = x
    z_line = np.abs(np.sin(x_line))
    ax.plot(x_line, np.zeros_like(x_line), z_line,
            color="#1f4e9b", lw=2.5, zorder=10)

    # Axis labels
    ax.set_xlabel("x (Re z)", fontsize=11, labelpad=8)
    ax.set_ylabel("y (Im z)", fontsize=11, labelpad=8)
    ax.set_zlabel("|sin z|", fontsize=11, labelpad=5)

    # Title
    ax.set_title(r"$|\sin z|$", fontsize=16, fontweight="bold", pad=15)

    # Viewing angle
    ax.view_init(elev=25, azim=-60)

    # Axis limits
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    ax.set_zlim(0, z_max)

    # Reduce grid clutter
    ax.xaxis._axinfo["grid"]["linewidth"] = 0.5
    ax.yaxis._axinfo["grid"]["linewidth"] = 0.5
    ax.zaxis._axinfo["grid"]["linewidth"] = 0.5
    ax.xaxis._axinfo["grid"]["color"] = "#dddddd"
    ax.yaxis._axinfo["grid"]["color"] = "#dddddd"
    ax.zaxis._axinfo["grid"]["color"] = "#dddddd"

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "sin-modulus")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
