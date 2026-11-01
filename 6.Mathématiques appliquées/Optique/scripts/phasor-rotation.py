"""Rotating-vector (phasor) picture of SHM: rotation and projection (left), displacement-velocity-acceleration phasors (right).  Generates img/phasor-rotation.svg.  Run from the repository root:  uv run "6.Mathématiques appliquées/Optique/scripts/phasor-rotation.py"  Math check: x = A cos(w0 t + phi) is the projection of A e^(i(w0 t + phi)) on the real axis; multiplying by i w0 rotates by +pi/2 and by -w0^2 by +pi, so velocity leads by pi/2 and acceleration by pi. Amplitudes in the right panel are normalised to the same length. """
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import Arc, Circle

BLUE, RED, GREEN, GRAY, SKY = "#3b6fb6", "#c74440", "#2f9e44", "#888888", "#9cc0e8"
OUT = Path(__file__).resolve().parent.parent / "img" / "phasor-rotation.svg"
OUT_PNG = OUT.with_suffix(".png")


def main():
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(9.6, 4.6))

    # ---- left: rotating phasor and its projection ----
    phi0 = np.deg2rad(35.0)
    theta = phi0 + np.deg2rad(45.0)

    ax1.add_patch(Circle((0.0, 0.0), 1.0, fill=False, color="#cccccc", lw=1.0, ls="--"))
    ax1.axhline(0.0, color="#cccccc", lw=0.9)
    ax1.axvline(0.0, color="#cccccc", lw=0.9)

    # phasor at t = 0 (solid) and at a later time (faded, dashed)
    ax1.annotate("", xy=(np.cos(theta), np.sin(theta)), xytext=(0.0, 0.0),
                 arrowprops=dict(arrowstyle="-|>", color=SKY, lw=2.0,
                                 linestyle="--", mutation_scale=14))
    ax1.annotate("", xy=(np.cos(phi0), np.sin(phi0)), xytext=(0.0, 0.0),
                 arrowprops=dict(arrowstyle="-|>", color=BLUE, lw=2.4, mutation_scale=16))

    # projection onto the real axis
    ax1.plot([np.cos(phi0), np.cos(phi0)], [0.0, np.sin(phi0)], ls="--", color=RED, lw=1.1)
    ax1.plot([np.cos(phi0)], [0.0], "o", color=RED, ms=5.0)

    # rotation arc
    ax1.add_patch(Arc((0.0, 0.0), 1.24, 1.24, theta1=np.rad2deg(phi0) + 2.0,
                      theta2=np.rad2deg(theta) - 2.0, color=GRAY, lw=1.0, ls="--"))
    a0, a1 = np.deg2rad(np.rad2deg(theta) - 10.0), np.deg2rad(np.rad2deg(theta) - 4.0)
    ax1.annotate("", xy=(0.62 * np.cos(a1), 0.62 * np.sin(a1)),
                 xytext=(0.62 * np.cos(a0), 0.62 * np.sin(a0)),
                 arrowprops=dict(arrowstyle="-|>", color=GRAY, lw=1.0, mutation_scale=9))

    ax1.text(0.95, 0.62, r"$A$", color=BLUE, fontsize=12)
    ax1.text(0.30, 0.78, r"$\omega_0$", color=GRAY, fontsize=11)
    ax1.text(0.62, -0.30, r"$x(t) = A\cos(\omega_0 t + \phi)$", color=RED,
             fontsize=11, ha="center")

    ax1.set_xlim(-1.35, 1.35)
    ax1.set_ylim(-1.25, 1.25)
    ax1.set_aspect("equal")
    ax1.set_xticks([])
    ax1.set_yticks([])
    ax1.set_title("rotating phasor and its projection", fontsize=11)
    ax1.grid(alpha=0.15)

    # ---- right: displacement, velocity and acceleration phasors ----
    for angle, color, label, offset in [
        (phi0, BLUE, r"$x$", (0.10, 0.06)),
        (phi0 + np.pi / 2.0, GREEN, r"$\dot{x}$", (0.02, 0.10)),
        (phi0 + np.pi, RED, r"$\ddot{x}$", (-0.10, -0.14)),
    ]:
        tip = (np.cos(angle), np.sin(angle))
        ax2.annotate("", xy=tip, xytext=(0.0, 0.0),
                     arrowprops=dict(arrowstyle="-|>", color=color, lw=2.4,
                                     mutation_scale=16))
        ax2.text(tip[0] + offset[0], tip[1] + offset[1], label, color=color, fontsize=13,
                 ha="center", va="center")

    ax2.add_patch(Arc((0.0, 0.0), 1.3, 1.3, theta1=np.rad2deg(phi0),
                      theta2=np.rad2deg(phi0) + 90.0, color=GRAY, lw=1.0, ls="--"))
    ax2.text(0.80 * np.cos(phi0 + np.pi / 4.0), 0.80 * np.sin(phi0 + np.pi / 4.0),
             r"$\pi/2$", color=GRAY, fontsize=11, ha="center", va="center")

    ax2.set_xlim(-1.45, 1.45)
    ax2.set_ylim(-1.45, 1.45)
    ax2.set_aspect("equal")
    ax2.set_xticks([])
    ax2.set_yticks([])
    ax2.set_title("displacement, velocity, acceleration phasors", fontsize=11)
    ax2.grid(alpha=0.15)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
