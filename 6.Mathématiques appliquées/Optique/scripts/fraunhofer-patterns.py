"""Fraunhofer diffraction patterns: single slit, double slit, circular aperture (Airy).  Generates img/fraunhofer-patterns.svg (three panels with intensity curves and grey bands).  Run from the repository root:  uv run ..."""
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"   # 统一语义色
OUT = Path(__file__).resolve().parent.parent / "img" / "fraunhofer-patterns.svg"
OUT_PNG = OUT.with_suffix(".png")


def j1(x):
    """Bessel function of the first kind, order one, by its series (valid for small/medium argument)."""
    x = np.asarray(x, dtype=float)
    s = np.zeros_like(x)
    term = x / 2.0
    for k in range(60):
        s = s + term
        term = -term * (x * x) / (4.0 * (k + 1) * (k + 2))
        if np.max(np.abs(term)) < 1e-14:
            break
    return s


def airy(x):
    """(2 J1(x) / x)^2 with the x=0 limit equal to 1."""
    x = np.asarray(x, dtype=float)
    out = np.empty_like(x)
    nz = np.abs(x) > 1e-9
    out[nz] = (2 * j1(x[nz]) / x[nz]) ** 2
    out[~nz] = 1.0
    return out


def main():
    fig, axes = plt.subplots(1, 3, figsize=(13.5, 4.6))

    # (a) single slit: sinc^2(beta), beta in [-3pi, 3pi]
    ax = axes[0]
    b = np.linspace(-3 * np.pi, 3 * np.pi, 1200)
    Ib = np.where(np.abs(b) > 1e-9, (np.sin(b) / b) ** 2, 1.0)
    ax.plot(b / np.pi, Ib, color="black", lw=2.0)
    ax.imshow(np.tile(Ib, (10, 1)), aspect="auto", extent=[-3, 3, -0.55, -0.1],
              cmap="gray", vmin=0, vmax=1)
    ax.set_xlim(-3.2, 3.2)
    ax.set_ylim(-0.7, 1.2)
    ax.set_title(r"Single slit: $\mathrm{sinc}^2(\beta)$", fontsize=12)
    ax.set_xlabel(r"$\beta / \pi$", fontsize=11)
    ax.grid(alpha=0.25)

    # (b) double slit: cos^2(2 pi u) * sinc^2(pi u), u = a sin(theta)/lambda
    ax = axes[1]
    u = np.linspace(-3, 3, 1200)
    env = np.where(np.abs(np.pi * u) > 1e-9, (np.sin(np.pi * u) / (np.pi * u)) ** 2, 1.0)
    Iu = np.cos(2 * np.pi * u) ** 2 * env
    ax.plot(u, Iu, color="black", lw=2.0)
    ax.imshow(np.tile(Iu, (10, 1)), aspect="auto", extent=[-3, 3, -0.55, -0.1],
              cmap="gray", vmin=0, vmax=1)
    ax.set_xlim(-3.2, 3.2)
    ax.set_ylim(-0.7, 1.2)
    ax.set_title(r"Double slit: $\cos^2 \cdot \mathrm{sinc}^2$", fontsize=12)
    ax.set_xlabel(r"$u = a\sin\theta/\lambda$", fontsize=11)
    ax.grid(alpha=0.25)

    # (c) circular aperture: Airy pattern
    ax = axes[2]
    x = np.linspace(0, 12, 1200)
    Ia = airy(x)
    ax.plot(x, Ia, color="black", lw=2.0)
    ax.imshow(np.tile(Ia, (10, 1)), aspect="auto", extent=[0, 12, -0.55, -0.1],
              cmap="gray", vmin=0, vmax=1)
    ax.set_xlim(0, 12.4)
    ax.set_ylim(-0.7, 1.2)
    ax.set_title(r"Circular aperture: Airy $(2J_1(x)/x)^2$", fontsize=12)
    ax.set_xlabel(r"$x = (kD\sin\theta)/2$", fontsize=11)
    ax.grid(alpha=0.25)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
