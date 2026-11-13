"""Maximum modulus principle — |z² + 3| over the unit disk.

3D surface: height and color encode |f(z)|. The surface has no interior
peak; the maximum is attained on the boundary circle (at z = ±1, |f| = 4).

Run with: uv run python src/math_paper/maximum_modulus.py
"""

from __future__ import annotations

from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = Presets.SVG_MATH
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

BLU = "#1f4e9b"
RED = "#c0392b"
GRY = "#888888"

# Ridge of |f| on the boundary: z = e^{iθ}, |f| = |e^{2iθ} + 3|
# maximum at θ = 0, π with value 4
theta = np.linspace(0, 2 * np.pi, 300)
idx_max = np.argmax(np.cos(2 * theta))


def build_figure():
    fig = SPEC.figure()
    ax = fig.add_subplot(111, projection="3d")

    # ---- unit-disk grid ---- #
    r = np.linspace(0, 1, 60)
    t = np.linspace(0, 2 * np.pi, 120)
    R, T = np.meshgrid(r, t)
    X = R * np.cos(T)
    Y = R * np.sin(T)
    # |z²+3| = sqrt((x²-y²+3)² + (2xy)²)
    Z = np.sqrt((X**2 - Y**2 + 3.0) ** 2 + (2 * X * Y) ** 2)

    # ---- surface ---- #
    ax.plot_surface(X, Y, Z, cmap="YlGnBu", alpha=0.9,
                    edgecolor="none", antialiased=True, zorder=2)

    # ---- bold highlighted boundary ring ---- #
    bx = np.cos(theta)
    by = np.sin(theta)
    bz = np.sqrt((bx**2 - by**2 + 3.0) ** 2 + (2 * bx * by) ** 2)
    ax.plot(bx, by, bz, color=RED, lw=3.2, zorder=6)

    # Highest point marker (θ = 0 → z = 1, |f| = 4)
    px, py, pz = bx[idx_max], by[idx_max], bz[idx_max]
    ax.plot([px], [py], [pz], "o", color=RED, ms=9, zorder=10)
    ax.text(px + 0.15, py, pz + 0.25,
            "max on boundary\n$|f(z)| = 4$",
            fontsize=10, color=RED, ha="left", zorder=10)

    # ---- interior annotation ---- #
    ax.text(0, 0, 1.5, "no interior peaks",
            fontsize=11, color=BLU, ha="center", style="italic",
            fontweight="bold")

    # ---- base unit circle (faint, on z=0 plane) ---- #
    ax.plot(bx, by, np.zeros_like(bx), color=GRY, lw=1.0, ls=":", zorder=1)

    # ---- labels / view ---- #
    ax.set_xlabel("Re z", fontsize=10, labelpad=6)
    ax.set_ylabel("Im z", fontsize=10, labelpad=6)
    ax.set_zlabel(r"$|f(z)|$", fontsize=11, labelpad=4)
    ax.set_title(r"Maximum modulus principle:  $f(z) = z^2 + 3$",
                 fontsize=13, fontweight="bold", pad=14)
    ax.view_init(elev=28, azim=-70)

    return fig


def main():
    fig = build_figure()
    path = SPEC.save(fig, OUT_DIR / "maximum-modulus")
    plt.close(fig)
    print(f"Saved: {path}")


if __name__ == "__main__":
    main()
