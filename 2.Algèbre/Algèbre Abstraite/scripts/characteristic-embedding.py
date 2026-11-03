"""The canonical homomorphism chi_R: Z -> R in the two possible cases.

Generates img/characteristic-embedding.svg.  Run from the repository root:

    uv run "2.Algèbre/Algèbre Abstraite/scripts/characteristic-embedding.py"

Left panel: characteristic 0, where chi is injective and the prime subring is a
copy of Z.  Right panel: characteristic p, where chi collapses the multiples of
p (the dashed block pZ) and the prime subring is the field F_p.
"""
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import Circle, FancyArrowPatch, FancyBboxPatch

OUT = Path(__file__).resolve().parent.parent / "img" / "characteristic-embedding.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "characteristic-embedding-preview.png"

INK = "#22262e"
BLUE = "#3b6fb6"
RED = "#c74440"
GREEN = "#3f7d4f"
GRAY = "#6b7280"
FILL_LEFT = "#f7f7f8"
FILL_RIGHT = "#f4f7fb"
FILL_IMAGE = "#dfe9f6"


def box(ax, x0, y0, w, h, fill, edge, dashed=False, lw=1.5):
    ax.add_patch(
        FancyBboxPatch(
            (x0, y0), w, h,
            boxstyle="round,pad=0.02,rounding_size=0.09",
            facecolor=fill, edgecolor=edge, linewidth=lw,
            linestyle=(0, (4, 3)) if dashed else "solid",
            zorder=2,
        )
    )


def dot(ax, x, y, color, label=None, dy=-0.23, fs=8.5):
    ax.add_patch(Circle((x, y), 0.030, facecolor=color, edgecolor="none", zorder=5))
    if label:
        ax.text(x, y + dy, label, fontsize=fs, color=color, ha="center",
                va="center", zorder=6)


def panel(ax, char_zero):
    ax.set_xlim(0, 5.6)
    ax.set_ylim(0, 5.0)
    ax.axis("off")
    ax.set_aspect("equal")

    box(ax, 0.30, 1.95, 1.95, 1.90, FILL_LEFT, INK)
    box(ax, 3.55, 1.95, 1.70, 1.90, FILL_RIGHT, INK)
    ax.text(1.27, 3.48, "$\\mathbb{Z}$", fontsize=15, color=INK,
            ha="center", va="center")
    ax.text(4.40, 3.48, "$R$", fontsize=15, color=INK,
            ha="center", va="center")

    ax.add_patch(
        FancyArrowPatch((2.32, 2.80), (3.50, 2.80), arrowstyle="-|>",
                        mutation_scale=14, linewidth=1.6, color=GREEN, zorder=3)
    )
    ax.text(2.91, 3.02, "$\\chi_R$", fontsize=13, color=GREEN,
            ha="center", va="center")
    ax.text(2.91, 2.55, "$n \\mapsto n \\cdot 1_R$", fontsize=9.0,
            color=GREEN, ha="center", va="center")

    box(ax, 3.68, 2.10, 1.44, 0.42, FILL_IMAGE, BLUE, lw=1.1)
    ax.text(4.40, 2.31,
            "$\\mathrm{im}\\,\\chi \\cong \\mathbb{Z}$" if char_zero
            else "$\\mathrm{im}\\,\\chi \\cong \\mathbb{F}_p$",
            fontsize=10, color=BLUE, ha="center", va="center")

    if char_zero:
        for x, lab in ((0.68, "$0$"), (1.02, "$1$"), (1.36, "$2$")):
            dot(ax, x, 2.60, INK, label=lab)
        ax.text(1.74, 2.60, "$\\cdots$", fontsize=11, color=INK,
                ha="center", va="center")
        caption = ["$\\chi$ is injective:  $\\ker\\chi = \\{0\\}$",
                   "prime subring $\\cong \\mathbb{Z}$ (not a field)"]
    else:
        for x, lab in ((0.70, "$0$"), (1.04, "$1$")):
            dot(ax, x, 3.10, INK, label=lab)
        ax.text(1.42, 3.10, "$\\cdots$", fontsize=11, color=INK,
                ha="center", va="center")

        box(ax, 0.50, 2.02, 1.10, 0.56, "none", RED, dashed=True, lw=1.0)
        for x, lab in ((0.72, "$p$"), (1.06, "$2p$")):
            dot(ax, x, 2.40, RED, label=lab, fs=8.0, dy=-0.21)
        ax.text(1.38, 2.40, "$\\cdots$", fontsize=10, color=RED,
                ha="center", va="center")
        ax.text(1.70, 2.30, "$p\\mathbb{Z}$", fontsize=9.5, color=RED,
                ha="left", va="center")
        caption = ["$\\chi$ is not injective:  $\\ker\\chi = p\\mathbb{Z}$",
                   "prime subring $\\cong \\mathbb{F}_p$ (already a field)"]

    ax.text(0.40, 1.55, caption[0], fontsize=11.5, color=INK, ha="left",
            va="center")
    ax.text(0.40, 1.13, caption[1], fontsize=11.5, color=INK, ha="left",
            va="center")


def main():
    fig, axes = plt.subplots(1, 2, figsize=(7.6, 3.9))
    for ax, zero in zip(axes, (True, False)):
        panel(ax, zero)
        ax.set_title("characteristic $0$" if zero
                     else "characteristic $p$ (prime)",
                     fontsize=13, color=INK, pad=2)

    fig.tight_layout(pad=0.8)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
