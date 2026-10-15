"""Hanbury Brown-Twiss experiment: setup schematic and thermal bunching g^(2)(tau).  Generates img/hbt-experiment.svg (two panels, first schematic).  Run from the repository root:  uv run ..."""
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.patches as mpatches

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"   # 统一语义色
OUT = Path(__file__).resolve().parent.parent / "img" / "hbt-experiment.svg"
OUT_PNG = OUT.with_suffix(".png")


def main():
    fig, axes = plt.subplots(1, 2, figsize=(11, 4.3))

    # (a) setup schematic
    ax = axes[0]
    ax.set_xlim(-0.6, 9.6)
    ax.set_ylim(-1.6, 2.4)
    ax.set_aspect("equal")
    # source
    ax.plot([0], [0], marker="o", ms=10, color=RED)
    ax.text(-0.15, 0.32, "source", fontsize=10, ha="center")
    # beam to beam splitter
    ax.plot([0, 3.5], [0, 0], color="black", lw=1.8)
    # beam splitter (diagonal line at x=3.5)
    ax.plot([3.2, 3.8], [-0.6, 0.6], color="black", lw=2.4)
    ax.text(3.9, 0.85, "beam\nsplitter", fontsize=9)
    # transmitted path to D1, reflected path to D2
    ax.plot([3.5, 6.5], [0, 0], color=BLUE, lw=1.6)
    ax.plot([3.5, 6.5], [0, 1.1], color=BLUE, lw=1.6)
    for x, y in [(6.5, 0), (6.5, 1.1)]:
        ax.plot([x], [y], marker="s", ms=8, color=BLUE)
    ax.text(6.5, -0.35, "D1", fontsize=11, ha="center")
    ax.text(6.55, 1.45, "D2", fontsize=11)
    # coincidence counter
    ax.plot([8.0], [0.55], marker="o", ms=7, color=RED)
    ax.text(8.0, 0.9, "coincidence\ncounter", fontsize=9, ha="center")
    ax.plot([6.5, 8.0], [0, 0.45], color=GRAY, lw=1.2, ls=":")
    ax.plot([6.5, 8.0], [1.1, 0.65], color=GRAY, lw=1.2, ls=":")
    ax.set_title("(a) Setup (schematic)", fontsize=12)
    ax.set_xticks([])
    ax.set_yticks([])

    # (b) g^(2)(tau): thermal bunching vs coherent
    ax = axes[1]
    tau = np.linspace(0, 4, 800)
    g_thermal = 1 + np.exp(-tau / 0.8)
    g_coherent = np.ones_like(tau)
    ax.plot(tau, g_thermal, color=RED, lw=2.2, label=r"thermal: $g^{(2)}(\tau)$")
    ax.plot(tau, g_coherent, color=BLUE, lw=2.0, ls="--", label=r"coherent: $g^{(2)}=1$")
    ax.plot([0], [2], marker="o", ms=6, color=RED)
    ax.text(0.05, 2.05, r"$g^{(2)}(0)=2$", fontsize=11)
    ax.set_xlim(0, 4)
    ax.set_ylim(0.8, 2.3)
    ax.set_xlabel(r"delay $\tau$ (in units of $\tau_c$)", fontsize=11)
    ax.set_ylabel(r"$g^{(2)}(\tau)$", fontsize=12)
    ax.set_title("(b) Bunching peak", fontsize=12)
    ax.legend(loc="upper right", fontsize=10, frameon=False)
    ax.grid(alpha=0.25)

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(OUT_PNG, format="png", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
