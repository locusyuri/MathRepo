"""Hydrogen energy levels E_n = -13.6/n^2 eV with the Lyman, Balmer and Paschen series.
Generates img/bohr-levels.svg.  Run from the repository root:
  uv run "6.Mathématiques appliquées/Mécanique quantique/scripts/bohr-levels.py"
"""
from pathlib import Path

import matplotlib.pyplot as plt

BLUE, RED, GREEN, GRAY = "#3b6fb6", "#c74440", "#2f9e44", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "bohr-levels.svg"

# 能级：E_n = -13.6 / n^2 (eV)
LEVELS = {1: -13.60, 2: -3.40, 3: -1.51, 4: -0.85}

# (系列名, 下能级, 上能级列表, 列起点, 颜色, 波长标注 nm)
SERIES = [
    ("Lyman", 1, [2, 3, 4], 4.9, BLUE, ["121.6", "102.6", "97.3"]),
    ("Balmer", 2, [3, 4], 6.9, RED, ["656.3", "486.1"]),
    ("Paschen", 3, [4], 8.7, GREEN, ["1875"]),
]
STEP = 0.55  # 同一系列内相邻箭头的横向间距


def main() -> None:
    fig, ax = plt.subplots(figsize=(9.0, 5.4))

    # 高能级密集，标签微调错开，避免 n = 3 与 n = 4 叠字
    label_shift = {3: -0.15, 4: 0.20}
    for n, energy in LEVELS.items():
        ax.hlines(energy, 0.0, 3.6, color=GRAY, lw=1.6)
        ax.text(-0.18, energy + label_shift.get(n, 0.0), rf"$n={n}$",
                ha="right", va="center", fontsize=11.5)

    ax.hlines(0.0, 0.0, 8.0, color=GRAY, lw=1.1, ls=":")
    ax.text(0.05, 0.35, "ionisation limit", fontsize=10.5, color="#4b5563")

    for name, n_low, n_highs, x0, color, labels in SERIES:
        ax.text(x0 + 0.5 * (len(n_highs) - 1) * STEP, 1.15, name,
                ha="center", fontsize=11, color=color)
        for i, (n_high, label) in enumerate(zip(n_highs, labels)):
            x = x0 + i * STEP
            ax.annotate(
                "",
                xy=(x, LEVELS[n_low]),
                xytext=(x, LEVELS[n_high]),
                arrowprops=dict(arrowstyle="-|>", color=color, lw=1.7, shrinkA=1, shrinkB=1),
            )
            ax.text(x + 0.09, 0.5 * (LEVELS[n_low] + LEVELS[n_high]),
                    rf"${label}$", fontsize=9, color=color,
                    va="center", ha="left", rotation=90)

    ax.set_xlim(-1.2, 10.2)
    ax.set_ylim(-15.0, 1.9)
    ax.set_ylabel("energy (eV)", fontsize=12)
    ax.set_yticks([-14, -12, -10, -8, -6, -4, -2, 0])
    ax.set_xticks([])
    ax.tick_params(axis="y", labelsize=11)
    for side in ("top", "right", "bottom"):
        ax.spines[side].set_visible(False)
    ax.text(0.05, -14.5, "wavelengths in nm", fontsize=9, color="#6b7280")

    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)


if __name__ == "__main__":
    main()
