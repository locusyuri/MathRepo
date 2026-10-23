"""Fourier duality under the xi convention: box, Gaussian, shifted Gaussian and their transforms.

Generates img/fourier-duality.svg: 3 x 2 panels, left column time domain f(x),
right column frequency domain hat f(xi), using hat f(xi) = int f(x) e^(-2 pi i xi x) dx.
Run from the repository root:
    uv run "1.Analyse/Analyse Harmonique/scripts/fourier-duality.py"
"""

import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "fourier-duality.svg"

A = 0.5  # half-width of the box
SIGMA = 0.6  # width parameter of the Gaussian
X0 = 1.0  # shift of the third Gaussian

X_LIM = (-3.0, 3.0)
XI_LIM = (-6.0, 6.0)


def box_transform(xi):
    """hat f for f = 1_[-A, A]: sin(2 pi A xi) / (pi xi), value 2A at xi = 0."""
    out = np.empty_like(xi)
    near_zero = np.abs(xi) < 1e-12
    out[near_zero] = 2.0 * A
    out[~near_zero] = np.sin(2.0 * np.pi * A * xi[~near_zero]) / (np.pi * xi[~near_zero])
    return out


def main():
    x = np.linspace(*X_LIM, 1201)
    xi = np.linspace(*XI_LIM, 2401)

    box = np.where(np.abs(x) <= A, 1.0, 0.0)
    sinc = box_transform(xi)
    gauss = np.exp(-np.pi * (x / SIGMA) ** 2)
    gauss_hat = SIGMA * np.exp(-np.pi * SIGMA**2 * xi**2)
    shifted = np.exp(-np.pi * ((x - X0) / SIGMA) ** 2)
    shifted_hat_real = gauss_hat * np.cos(2.0 * np.pi * xi * X0)

    rows = [
        (
            box,
            sinc,
            r"$f = \mathbf{1}_{[-a,a]}$" + f",  $a = {A}$",
            r"$\hat f(\xi) = \frac{\sin(2\pi a\xi)}{\pi\xi}$",
            (0.0, 1.18),
            (-0.42, 1.18),
            "decays like $1/|\\xi|$",
        ),
        (
            gauss,
            gauss_hat,
            r"$f = e^{-\pi (x/\sigma)^2}$" + f",  $\\sigma = {SIGMA}$",
            r"$\hat f = \sigma e^{-\pi\sigma^2\xi^2}$",
            (0.0, 1.18),
            (0.0, 0.74),
            "Gaussian $\\leftrightarrow$ Gaussian, width $1/(\\pi\\sigma)$",
        ),
        (
            shifted,
            shifted_hat_real,
            r"$f(\cdot - x_0)$" + f",  $x_0 = {X0}$",
            r"$\Re\hat f$: $|\hat f|$ unchanged, phase $e^{-2\pi i x_0\xi}$",
            (0.0, 1.18),
            (-0.74, 0.74),
            "translation $\\leftrightarrow$ modulation",
        ),
    ]

    fig, axes = plt.subplots(3, 2, figsize=(7.4, 6.6))

    for row, (f_vals, fhat_vals, label_left, label_right, ylim_left, ylim_right, law) in enumerate(rows):
        ax_l, ax_r = axes[row, 0], axes[row, 1]

        ax_l.plot(x, f_vals, color=BLUE, linewidth=1.5)
        ax_l.set_xlim(*X_LIM)
        ax_l.set_ylim(*ylim_left)
        ax_l.set_title(label_left, fontsize=8.5, color=BLUE, loc="left")
        ax_l.set_xlabel(r"$x$", fontsize=8)
        ax_l.set_ylabel(r"$f(x)$", fontsize=8)
        ax_l.grid(False)

        ax_r.plot(xi, fhat_vals, color=RED, linewidth=1.5)
        if row == 2:
            ax_r.plot(xi, gauss_hat, color=GRAY, linewidth=1.0, linestyle="--")
            ax_r.text(0.02, 0.92, r"$|\hat f|$", color=GRAY, fontsize=8, ha="left", va="top", transform=ax_r.transAxes)
        ax_r.axhline(0.0, color="0.7", linewidth=0.7)
        ax_r.set_xlim(*XI_LIM)
        ax_r.set_ylim(*ylim_right)
        ax_r.set_title(label_right, fontsize=8.5, color=RED, loc="left")
        ax_r.set_xlabel(r"$\xi$", fontsize=8)
        ax_r.set_ylabel(r"$\Re\hat f$" if row == 2 else r"$\hat f(\xi)$", fontsize=8)
        ax_r.grid(False)
        law_y, law_va = (0.06, "bottom") if row == 2 else (0.92, "top")
        ax_r.text(
            0.99,
            law_y,
            law,
            color="0.25",
            fontsize=7.5,
            ha="right",
            va=law_va,
            transform=ax_r.transAxes,
        )

        for ax in (ax_l, ax_r):
            ax.tick_params(labelsize=7, length=3)

    fig.tight_layout(h_pad=1.1, w_pad=1.6)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    if "--png" in sys.argv:
        fig.savefig(
            OUT.with_name("_preview.png"),
            format="png",
            dpi=150,
            bbox_inches="tight",
            facecolor="white",
        )
    plt.close(fig)


if __name__ == "__main__":
    main()
