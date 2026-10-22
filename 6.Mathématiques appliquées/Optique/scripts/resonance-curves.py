"""Resonance curves for a driven damped harmonic oscillator.

Two-panel physics-textbook illustration (serif, line-art style), side by side:
  * Left:  model schematic — spring-mass-damper driven by a crank mechanism.
  * Right: amplitude A(w) vs. driving frequency w for three damping ratios,
           with resonance-frequency markers, FWHM annotation, and the
           undamped asymptotic reference.

Output: ../img/resonance-curves.svg (transparent). Set PREVIEW=1 to also
save a PNG preview to %TEMP% for inspection.

Run from the repository root:
    uv run python "6.Mathématiques appliquées/Optique/scripts/resonance-curves.py"
"""

import os
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.lines import Line2D
from matplotlib.patches import Circle, FancyArrowPatch, Rectangle

# 教科书风格：衬线字体 + 衬线数学字体
plt.rcParams.update({
    "font.family": "serif",
    "font.serif": ["DejaVu Serif", "Times New Roman", "serif"],
    "mathtext.fontset": "dejavuserif",
})

OUT = Path(__file__).resolve().parent.parent / "img" / "resonance-curves.svg"

# --------------------------------------------------------------------------- #
# 物理参数
# --------------------------------------------------------------------------- #
OMEGA0 = 1.0                         # 固有频率（归一化）
ZETA_UNDER = 0.05                    # 弱阻尼   beta/omega0
ZETA_MEDIUM = 0.10                   # 中等阻尼 beta/omega0
ZETA_HEAVY = 0.30                    # 强阻尼   beta/omega0

# 调色板（与 damped-oscillation.py 一致）
BLU = "#1f4e9b"
GRN = "#2e8b57"
ORG = "#d4740e"
GREY = "#888888"
RED = "#cc3333"
MASS_COL = "#2e6fb5"


# --------------------------------------------------------------------------- #
# 绘图基元（与 damped-oscillation.py 相同的线稿构件）
# --------------------------------------------------------------------------- #
def _bracket(ax, x, y, w=0.9, h=0.12):
    """A fixed support: hatched grey rectangle (ceiling / floor)."""
    ax.add_patch(Rectangle(
        (x - w / 2, y - h / 2), w, h,
        facecolor="#d5d8dc", edgecolor=GREY, linewidth=1.0,
        hatch="////", zorder=2,
    ))


def _spring(ax, x, y_top, y_bot, coils=7, width=0.18, lw=1.6):
    """A vertical zig-zag spring from (x, y_top) down to (x, y_bot)."""
    n = coils * 2
    ys = np.linspace(y_top, y_bot, n + 3)
    xs = np.full_like(ys, x)
    # 中间各点相对中心线左右交替，形成锯齿
    xs[1:-1] = x + np.array(
        [width if i % 2 else -width for i in range(n + 1)]
    )
    ax.plot(xs, ys, color=GREY, lw=lw, zorder=2, solid_joinstyle="round")


def _damper(ax, x, y_top, y_bot, width=0.26, lw=1.6):
    """A vertical dashpot: piston rod + cylinder + piston head."""
    mid = (y_top + y_bot) / 2.0
    # 活塞杆：从上端连接到活塞头
    ax.plot([x, x], [y_top, mid + 0.02], color=GREY, lw=lw, zorder=2)
    # 缸体（顶端开口），容纳活塞头
    cyl_top = mid + 0.06
    ax.plot([x - width, x + width], [cyl_top, cyl_top], color=GREY, lw=lw,
            zorder=2)
    ax.plot([x - width, x - width], [cyl_top, y_bot], color=GREY, lw=lw,
            zorder=2)
    ax.plot([x + width, x + width], [cyl_top, y_bot], color=GREY, lw=lw,
            zorder=2)
    ax.plot([x - width, x + width], [y_bot, y_bot], color=GREY, lw=lw,
            zorder=2)
    # 缸内的活塞头
    ax.plot([x - width + 0.04, x + width - 0.04], [mid, mid],
            color=GREY, lw=lw + 0.6, zorder=3)


def _mass_block(ax, x, y, w=0.42, h=0.30, label=r"$m$"):
    """A blue mass block centred at (x, y)."""
    ax.add_patch(Rectangle(
        (x - w / 2, y - h / 2), w, h,
        facecolor=MASS_COL, edgecolor="black", linewidth=1.1, zorder=3,
    ))
    ax.text(x, y, label, ha="center", va="center",
            fontsize=11, color="white", fontweight="bold", zorder=4)


# --------------------------------------------------------------------------- #
# 面板 (a) —— 模型示意图
# --------------------------------------------------------------------------- #
def draw_model(ax):
    """Draw the driven damped harmonic oscillator model.

    Left side: vertical spring-mass-damper assembly.
    Right side: rotating crank mechanism delivering the driving force.
    """
    ax.set_axis_off()
    ax.set_xlim(-0.5, 5.8)
    ax.set_ylim(-2.8, 2.8)
    ax.set_aspect("equal")

    ax.set_title("(a) Driven Damped Harmonic Oscillator",
                 fontsize=11, pad=8)

    # --- 竖直的弹簧-质量块-阻尼器组合 ---
    cx = 1.5          # 质量块中心横坐标
    cy = 0.0          # 质量块平衡位置纵坐标
    mass_h = 0.30
    mass_w = 0.42
    block_top = cy + mass_h / 2
    block_bot = cy - mass_h / 2

    # 天花板支座
    ceil_y = cy + 1.6
    _bracket(ax, cx, ceil_y)

    # 弹簧：天花板到质量块顶面
    _spring(ax, cx, ceil_y - 0.06, block_top)

    # 地板支座 + 阻尼器：质量块底面到地板
    floor_y = cy - 1.6
    _damper(ax, cx, block_bot, floor_y + 0.06)
    _bracket(ax, cx, floor_y)

    # 质量块
    _mass_block(ax, cx, cy)

    # 穿过质量块的平衡位置虚线
    ax.plot([cx - 0.75, cx + 0.75], [cy, cy],
            color=GREY, ls="--", lw=0.9, zorder=1)

    # --- 弹簧与阻尼器上的受力箭头 ---
    # 弹簧恢复力（向上，指向天花板）
    arrow_y_s = cy + 0.55
    ax.annotate("", xy=(cx + 0.38, arrow_y_s + 0.28),
                xytext=(cx + 0.38, arrow_y_s - 0.28),
                arrowprops=dict(arrowstyle="->", color=RED, lw=1.4))
    ax.text(cx + 0.58, arrow_y_s, r"$F_s = -kx$",
            fontsize=8.5, color=RED, va="center")

    # 阻尼力（与速度反向；此处对应正速度，故画成向下）
    arrow_y_d = cy - 0.55
    ax.annotate("", xy=(cx + 0.38, arrow_y_d - 0.28),
                xytext=(cx + 0.38, arrow_y_d + 0.28),
                arrowprops=dict(arrowstyle="->", color=RED, lw=1.4))
    ax.text(cx + 0.58, arrow_y_d, r"$F_d = -b\dot{x}$",
            fontsize=8.5, color=RED, va="center")

    # --- 曲柄机构（右侧） ---
    wheel_cx = 4.0
    wheel_cy = cy
    wheel_r = 0.55
    crank_angle = np.deg2rad(30)  # 取 30° 使机构看起来处于运动中

    # 飞轮外圈
    ax.add_patch(Circle((wheel_cx, wheel_cy), wheel_r,
                        facecolor="none", edgecolor=GREY, lw=1.8, zorder=3))
    # 轮心
    ax.scatter([wheel_cx], [wheel_cy], s=18, color=GREY, zorder=4)

    # 曲柄臂（从轮心到销钉的半径线）
    pin_x = wheel_cx + wheel_r * np.cos(crank_angle)
    pin_y = wheel_cy + wheel_r * np.sin(crank_angle)
    ax.plot([wheel_cx, pin_x], [wheel_cy, pin_y],
            color=GREY, lw=2.0, zorder=3)
    # 销钉
    ax.scatter([pin_x], [pin_y], s=28, facecolor="white",
               edgecolor=GREY, lw=1.2, zorder=4)

    # 连杆：质量块右缘到销钉
    mass_right = cx + mass_w / 2
    ax.plot([mass_right, pin_x], [cy, pin_y],
            color=GREY, lw=2.0, zorder=3, solid_joinstyle="round")

    # 旋转方向箭头（绕飞轮逆时针的弧线）
    ax.annotate("", xy=(wheel_cx + 0.38, wheel_cy + 0.35),
                xytext=(wheel_cx - 0.38, wheel_cy + 0.45),
                arrowprops=dict(
                    arrowstyle="->,head_length=4,head_width=3",
                    color=RED, lw=1.4,
                    connectionstyle="arc3,rad=0.45",
                ),
                zorder=5)

    # 沿连杆方向的驱动力箭头
    ax.annotate("", xy=(mass_right + 0.12, cy + 0.04),
                xytext=(pin_x - 0.25, pin_y - 0.04),
                arrowprops=dict(arrowstyle="->", color=RED, lw=1.4))

    # --- 文字标注 ---
    # k：刚度系数
    ax.text(cx + 0.75, cy + 0.85, r"$k$", fontsize=10, color=GREY,
            ha="center")
    # b：阻尼系数
    ax.text(cx + 0.75, cy - 0.85, r"$b$", fontsize=10, color=GREY,
            ha="center")
    # omega：旋转箭头旁
    ax.text(wheel_cx + 0.92, wheel_cy + 0.35, r"$\omega$",
            fontsize=10, color=RED, ha="center")
    # F0：销钉旁
    ax.text(pin_x + 0.18, pin_y + 0.22, r"$F_0$",
            fontsize=10, color=RED, ha="center")
    # 驱动力表达式
    ax.text(wheel_cx + 0.05, wheel_cy - 0.95,
            r"$F_0\cos(\omega t)$", fontsize=9.5, color=RED,
            ha="center", va="top")

    # --- 图例 ---
    handles = [
        Line2D([0], [0], color=GREY, lw=1.8, label="Spring ($k$)"),
        Line2D([0], [0], color=GREY, lw=1.8, label="Damper ($b$)"),
        Line2D([0], [0], color=MASS_COL, lw=6.0, label="Mass ($m$)"),
        Line2D([0], [0], color=RED, lw=1.4,
               label=r"Driving force $F_0\cos(\omega t)$"),
    ]
    ax.legend(handles=handles, loc="upper left", fontsize=7.5,
              frameon=True, edgecolor="#cccccc", facecolor="white",
              framealpha=0.9, bbox_to_anchor=(0.0, 0.05))


# --------------------------------------------------------------------------- #
# 幅频特性
# --------------------------------------------------------------------------- #
def amplitude(x, zeta):
    """Normalised amplitude A(x) / A_static for a driven damped oscillator.

    Parameters
    ----------
    x : array_like
        Normalised driving frequency w/w0.
    zeta : float
        Damping ratio beta/w0.

    Returns
    -------
    array_like
        A(x) / A_static = 1 / sqrt((1 - x^2)^2 + (2 zeta x)^2).
    """
    denom = np.sqrt((1 - x ** 2) ** 2 + (2 * zeta * x) ** 2)
    with np.errstate(divide="ignore"):
        result = 1.0 / denom
    return result


def resonance_x(zeta):
    """Resonance frequency (normalised): w_res / w0 = sqrt(1 - 2 zeta^2).

    Returns 0 when zeta >= 1/sqrt(2) (no resonance peak).
    """
    disc = 1 - 2 * zeta ** 2
    if disc <= 0:
        return 0.0
    return np.sqrt(disc)


# --------------------------------------------------------------------------- #
# 面板 (b) —— 共振曲线
# --------------------------------------------------------------------------- #
def draw_curves(ax):
    """Draw amplitude A(w) vs. driving frequency for three damping ratios.

    Includes resonance-frequency markers, a FWHM annotation, and the
    undamped asymptotic reference.
    """
    ax.set_title(
        r"(b) Resonance Curves — Amplitude vs. Driving Frequency",
        fontsize=11, pad=8,
    )

    x = np.linspace(0.001, 2.5, 2000)  # 避开 x = 0

    # 三条阻尼比对应的归一化幅值
    a_under = amplitude(x, ZETA_UNDER)    # beta/omega0 = 0.05
    a_medium = amplitude(x, ZETA_MEDIUM)  # beta/omega0 = 0.10
    a_heavy = amplitude(x, ZETA_HEAVY)    # beta/omega0 = 0.30

    # 全局最大值（弱阻尼曲线的峰值），用于统一归一化
    a_max = np.max(a_under)
    a_under_n = a_under / a_max
    a_medium_n = a_medium / a_max
    a_heavy_n = a_heavy / a_max

    # 各阻尼比下的共振频率（归一化）及共振处的幅值
    x_res_u = resonance_x(ZETA_UNDER)
    x_res_m = resonance_x(ZETA_MEDIUM)
    x_res_h = resonance_x(ZETA_HEAVY)

    a_res_u = amplitude(x_res_u, ZETA_UNDER) / a_max
    a_res_m = amplitude(x_res_m, ZETA_MEDIUM) / a_max
    a_res_h = amplitude(x_res_h, ZETA_HEAVY) / a_max

    # --- 曲线 ---
    ax.plot(x, a_under_n, color=BLU, lw=2.6,
            label=r"$\beta/\omega_0 = 0.05$", zorder=4)
    ax.plot(x, a_medium_n, color=GRN, lw=2.6,
            label=r"$\beta/\omega_0 = 0.10$", zorder=4)
    ax.plot(x, a_heavy_n, color=ORG, lw=2.6,
            label=r"$\beta/\omega_0 = 0.30$", zorder=4)

    # --- 无阻尼极限：x = 1 处的竖直虚线（幅值发散到无穷） ---
    ax.axvline(1.0, color=GREY, ls="--", lw=1.4, alpha=0.8, zorder=2)
    ax.text(1.0, 1.15, r"$\to\infty$", ha="center", va="bottom",
            fontsize=9, color=GREY, fontstyle="italic")

    # --- 固有频率标记（红色点状竖线） ---
    ax.axvline(1.0, color=RED, ls=":", lw=1.0, alpha=0.7, zorder=2)
    ax.annotate(r"Natural frequency $\omega_0$",
                xy=(1.0, 1.08), xytext=(1.28, 1.08),
                fontsize=8.5, color=RED,
                arrowprops=dict(arrowstyle="->", color=RED, lw=0.8))

    # --- 共振频率标记（各峰值处的空心圆） ---
    ax.scatter([x_res_u], [a_res_u], s=50, facecolor="white",
               edgecolor=BLU, lw=1.5, zorder=6)
    ax.scatter([x_res_m], [a_res_m], s=50, facecolor="white",
               edgecolor=GRN, lw=1.5, zorder=6)
    ax.scatter([x_res_h], [a_res_h], s=50, facecolor="white",
               edgecolor=ORG, lw=1.5, zorder=6)

    # 共振频率公式（只标一次，放在蓝色峰附近）
    ax.annotate(
        r"$\omega_{\rm res} = \omega_0\sqrt{1 - 2\beta^2/\omega_0^2}$",
        xy=(x_res_u, a_res_u),
        xytext=(x_res_u + 0.50, a_res_u - 0.02),
        fontsize=9, color=BLU,
        arrowprops=dict(arrowstyle="->", color=BLU, lw=0.8),
        bbox=dict(boxstyle="round,pad=0.25", fc="white", ec="#cccccc",
                  lw=0.5),
    )

    # --- 在绿色曲线（zeta = 0.1）上标注半高全宽 FWHM ---
    half_max = a_res_m / 2.0
    x_left = 1.0 - ZETA_MEDIUM
    x_right = 1.0 + ZETA_MEDIUM

    # 半高处水平双向箭头
    ax.annotate("", xy=(x_left, half_max), xytext=(x_right, half_max),
                arrowprops=dict(arrowstyle="<->", color=GRN, lw=1.2))
    # 半高点到横轴的竖直点线
    ax.plot([x_left, x_left], [0, half_max], color=GRN, ls=":",
            lw=0.7, alpha=0.6, zorder=2)
    ax.plot([x_right, x_right], [0, half_max], color=GRN, ls=":",
            lw=0.7, alpha=0.6, zorder=2)
    # FWHM 标注
    ax.text(1.0, half_max + 0.025,
            r"FWHM $\Delta\omega = 2\beta$",
            ha="center", va="bottom", fontsize=8.5, color=GRN,
            bbox=dict(boxstyle="round,pad=0.20", fc="white", ec=GRN,
                      lw=0.5, alpha=0.85))

    # --- 坐标轴 ---
    ax.set_xlim(0, 2.5)
    ax.set_xlabel(r"Driving frequency $\omega/\omega_0$", fontsize=10)
    ax.set_xticks(np.arange(0, 2.6, 0.5))

    ax.set_ylim(0, 1.2)
    ax.set_ylabel(r"Amplitude $A(\omega)/A_{\rm max}$", fontsize=10)
    ax.set_yticks(np.arange(0, 1.3, 0.2))
    ax.tick_params(labelsize=8)

    # --- 浅灰虚线网格 ---
    ax.grid(True, which="both", color="#dddddd", lw=0.6, ls="--", zorder=0)
    ax.axhline(0, color=GREY, lw=0.7, zorder=1)

    # --- 图例 ---
    handles = [
        Line2D([0], [0], color=BLU, lw=2.6,
               label=r"$\beta/\omega_0 = 0.05$"),
        Line2D([0], [0], color=GRN, lw=2.6,
               label=r"$\beta/\omega_0 = 0.10$"),
        Line2D([0], [0], color=ORG, lw=2.6,
               label=r"$\beta/\omega_0 = 0.30$"),
        Line2D([0], [0], color=GREY, ls="--", lw=1.4,
               label=r"Undamped ($\beta \to 0$)"),
    ]
    ax.legend(handles=handles, loc="center right", fontsize=8.5,
              frameon=True, edgecolor="#cccccc", facecolor="white",
              framealpha=0.9, bbox_to_anchor=(1.0, 0.55))


# --------------------------------------------------------------------------- #
# 组图与入口
# --------------------------------------------------------------------------- #
def build_figure():
    fig = plt.figure(figsize=(14.0, 7.0))
    ax_model = fig.add_subplot(121)
    ax_curve = fig.add_subplot(122)

    fig.subplots_adjust(left=0.06, right=0.97, top=0.91, bottom=0.10,
                        wspace=0.22)

    draw_model(ax_model)
    draw_curves(ax_curve)

    return fig


def main():
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig = build_figure()
    fig.savefig(OUT, transparent=True, bbox_inches="tight", pad_inches=0.05)
    print("saved", OUT.resolve())

    # 可选：把 PNG 预览写到临时目录，便于人工检查
    if os.environ.get("PREVIEW"):
        png = Path(os.environ["TEMP"]) / "resonance-curves.png"
        fig.savefig(png, dpi=150, facecolor="white", bbox_inches="tight")
        print("preview", png)

    plt.close(fig)


if __name__ == "__main__":
    main()
