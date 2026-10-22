"""Normal modes of a vibrating string fixed at both ends.

Three-panel physics-textbook illustration (serif, vertical stack):
  * Panel (a): n = 1 — fundamental mode
  * Panel (b): n = 2 — second harmonic
  * Panel (c): n = 3 — third harmonic

Each panel shows the standing-wave mode shape u_n(x) = A_n sin(n pi x / L)
with nodes (red dots) and antinodes (red dashed lines) marked.

Output: ../img/string-normal-modes.svg (transparent). Set PREVIEW=1 to also
save a PNG preview to %TEMP% for inspection.

Run from the repository root:
    uv run python "6.Mathématiques appliquées/Optique/scripts/string-normal-modes.py"
"""

import os
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.lines import Line2D

# 教科书风格：衬线字体 + 衬线数学字体
plt.rcParams.update({
    "font.family": "serif",
    "font.serif": ["DejaVu Serif", "Times New Roman", "serif"],
    "mathtext.fontset": "dejavuserif",
})

OUT = Path(__file__).resolve().parent.parent / "img" / "string-normal-modes.svg"

# 调色板
BLU = "#1f4e9b"
GRN = "#2e8b57"
ORG = "#d4740e"
RED = "#cc3333"
GREY = "#888888"


# --------------------------------------------------------------------------- #
# 单个面板
# --------------------------------------------------------------------------- #
def draw_mode_panel(
    ax,
    n: int,
    color: str,
    nodes: list[float],
    antinodes: list[float],
    wavelength_label: str,
    freq_label: str,
    title: str,
):
    """Draw one normal-mode panel with nodes, antinodes, and annotations.

    Parameters
    ----------
    ax : Axes
    n : int
        Mode number (1, 2, 3, ...).
    color : str
        Line colour for the displacement curve.
    nodes : list of float
        Normalised x positions where u = 0 (nodes).
    antinodes : list of float
        Normalised x positions where |u| is maximum (antinodes).
    wavelength_label : str
        Label for the wavelength.
    freq_label : str
        Label for the frequency.
    title : str
        Sub-panel title.
    """
    x = np.linspace(0, 1, 500)
    y = np.sin(n * np.pi * x)

    # --- 位移曲线 ---
    ax.plot(x, y, color=color, lw=2.4, zorder=4)

    # --- 节点（横轴上的红点） ---
    for xn in nodes:
        ax.scatter([xn], [0], s=40, color=RED, zorder=6, clip_on=False)

    # --- 腹点（贯穿全高的红色竖直虚线） ---
    for xa in antinodes:
        ax.axvline(xa, color=RED, ls="--", lw=1.0, alpha=0.7, zorder=2)

    # 只在第一个腹点处标注 "Antinode"
    if antinodes:
        xa0 = antinodes[0]
        ya0 = np.sin(n * np.pi * xa0)
        ax.text(xa0 + 0.02, ya0 + 0.12, "Antinode", fontsize=8, color=RED,
                va="bottom", ha="left",
                bbox=dict(boxstyle="round,pad=0.15", fc="white",
                          ec="#ffcccc", lw=0.4, alpha=0.85))

    # --- 第一个腹点处的振幅双向箭头 ---
    if antinodes:
        xa0 = antinodes[0]
        ya0 = np.sin(n * np.pi * xa0)
        ax.annotate("", xy=(xa0, 0), xytext=(xa0, ya0),
                    arrowprops=dict(arrowstyle="<->", color=color, lw=1.2))
        ax.text(xa0 + 0.04, ya0 / 2, f"$A_{n}$", fontsize=9, color=color,
                va="center")

    # --- 波长与频率标注 ---
    ax.text(0.98, 0.92, wavelength_label, transform=ax.transAxes,
            ha="right", va="top", fontsize=10, color=color,
            bbox=dict(boxstyle="round,pad=0.25", fc="white", ec="#cccccc",
                      lw=0.5))
    ax.text(0.98, 0.78, freq_label, transform=ax.transAxes,
            ha="right", va="top", fontsize=10, color=color,
            bbox=dict(boxstyle="round,pad=0.25", fc="white", ec="#cccccc",
                      lw=0.5))

    # --- 坐标轴 ---
    ax.set_xlim(0, 1)
    ax.set_xlabel(r"Position $x/L$", fontsize=10)
    ax.set_xticks(np.arange(0, 1.01, 0.25))

    ax.set_ylim(-1.25, 1.25)
    ax.set_ylabel(r"Displacement $u(x)/A_n$", fontsize=10)
    ax.set_yticks([-1, -0.5, 0, 0.5, 1])
    ax.tick_params(labelsize=8)

    # --- 网格 ---
    ax.grid(True, which="both", color="#dddddd", lw=0.6, ls="--", zorder=0)
    ax.axhline(0, color=GREY, lw=0.7, zorder=1)

    # --- 标题 ---
    ax.set_title(title, fontsize=11, pad=6)


# --------------------------------------------------------------------------- #
# 组图与入口
# --------------------------------------------------------------------------- #
def build_figure():
    fig = plt.figure(figsize=(10.0, 13.0))

    ax_a = fig.add_subplot(311)
    ax_b = fig.add_subplot(312)
    ax_c = fig.add_subplot(313)

    fig.subplots_adjust(left=0.10, right=0.96, top=0.96, bottom=0.07,
                        hspace=0.30)

    # 面板 (a)：n = 1
    draw_mode_panel(
        ax_a, n=1, color=BLU,
        nodes=[0, 1],
        antinodes=[0.5],
        wavelength_label=r"$\lambda_1 = 2L$",
        freq_label=r"$f_1 = v/(2L)$",
        title=r"(a) $n = 1$ — Fundamental Mode ($f_1$)",
    )

    # 面板 (b)：n = 2
    draw_mode_panel(
        ax_b, n=2, color=GRN,
        nodes=[0, 0.5, 1],
        antinodes=[0.25, 0.75],
        wavelength_label=r"$\lambda_2 = L$",
        freq_label=r"$f_2 = 2f_1$",
        title=r"(b) $n = 2$ — Second Harmonic ($f_2 = 2f_1$)",
    )

    # 面板 (c)：n = 3
    draw_mode_panel(
        ax_c, n=3, color=ORG,
        nodes=[0, 1 / 3, 2 / 3, 1],
        antinodes=[1 / 6, 0.5, 5 / 6],
        wavelength_label=r"$\lambda_3 = 2L/3$",
        freq_label=r"$f_3 = 3f_1$",
        title=r"(c) $n = 3$ — Third Harmonic ($f_3 = 3f_1$)",
    )

    # 面板下方的共享图例
    handles = [
        Line2D([0], [0], color=BLU, lw=2.4,
               label=r"Displacement $u_n(x)$"),
        Line2D([0], [0], color=RED, marker="o", lw=0, markersize=6,
               label=r"Node ($u = 0$)"),
        Line2D([0], [0], color=RED, ls="--", lw=1.0,
               label="Antinode"),
    ]
    fig.legend(handles=handles, loc="lower center", fontsize=9,
               frameon=True, edgecolor="#cccccc", facecolor="white",
               framealpha=0.9, ncol=3, bbox_to_anchor=(0.5, 0.01))

    return fig


def main():
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig = build_figure()
    fig.savefig(OUT, transparent=True, bbox_inches="tight", pad_inches=0.05)
    print("saved", OUT.resolve())

    # 可选：把 PNG 预览写到临时目录，便于人工检查
    if os.environ.get("PREVIEW"):
        png = Path(os.environ["TEMP"]) / "string-normal-modes.png"
        fig.savefig(png, dpi=150, facecolor="white", bbox_inches="tight")
        print("preview", png)

    plt.close(fig)


if __name__ == "__main__":
    main()
