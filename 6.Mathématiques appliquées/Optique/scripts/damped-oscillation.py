"""Three damping regimes of a mass-spring system.

Two-panel physics-textbook illustration (serif, line-art style), side by side:
  * Left:  three vertically stacked mass-spring-damper models
           (underdamped, critically damped, overdamped).
  * Right: normalized displacement x(t)/A for the three regimes vs. time,
           with the underdamped envelope, time-constant marker, and
           first zero-crossing annotated.

All three curves use the release-from-rest initial condition x(0)=A,
dx/dt(0)=0, so the critical and overdamped solutions take the standard
textbook form.

Output: ../img/damped-oscillation.svg (transparent). Set PREVIEW=1 to also
save a PNG preview to %TEMP% for inspection.

Run from the repository root:
    uv run python "6.Mathématiques appliquées/Optique/scripts/damped-oscillation.py"
"""

import os
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.lines import Line2D
from matplotlib.patches import FancyArrowPatch, Rectangle

# 教科书风格：衬线字体 + 衬线数学字体
plt.rcParams.update({
    "font.family": "serif",
    "font.serif": ["DejaVu Serif", "Times New Roman", "serif"],
    "mathtext.fontset": "dejavuserif",
})

OUT = Path(__file__).resolve().parent.parent / "img" / "damped-oscillation.svg"

# --------------------------------------------------------------------------- #
# 物理参数与场景
# --------------------------------------------------------------------------- #
# 取 omega0 = 2*pi，使固有周期 T0 = 1 s，时间轴 [0, 6*T0] 的刻度均为整数。
OMEGA0 = 2.0 * np.pi          # 固有角频率 (rad/s)
T0 = 2.0 * np.pi / OMEGA0     # 固有周期 (= 1 s)
A = 1.0                       # 初始（归一化）振幅

# 三种阻尼比：欠阻尼、临界阻尼、过阻尼
BETA_U = 0.2 * OMEGA0         # 欠阻尼  (beta < omega0)
BETA_C = 1.0 * OMEGA0         # 临界阻尼 (beta = omega0)
BETA_O = 2.0 * OMEGA0         # 过阻尼  (beta > omega0)

# 调色板（与仓库其余插图保持一致）
BLU = "#1f4e9b"
GRN = "#2e8b57"
ORG = "#d4740e"
GREY = "#888888"
MASS_COL = "#2e6fb5"          # 质量块填充色（蓝）


# --------------------------------------------------------------------------- #
# 面板 (a) —— 模型示意图（纯二维线稿）
# --------------------------------------------------------------------------- #
def _bracket(ax, x, y, w=0.9, h=0.12):
    """A fixed support: hatched grey rectangle (ceiling/floor)."""
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
    """A blue mass block centered at (x, y)."""
    ax.add_patch(Rectangle(
        (x - w / 2, y - h / 2), w, h,
        facecolor=MASS_COL, edgecolor="black", linewidth=1.1, zorder=3,
    ))
    ax.text(x, y, label, ha="center", va="center",
            fontsize=11, color="white", fontweight="bold", zorder=4)


def _draw_one_system(ax, cx, cy_block, show_damper=True, motion_amp=0.22):
    """Draw one ceiling-spring-mass-(damper)-floor assembly.

    The mass block sits at ``cy_block`` (the equilibrium height).
    """
    mass_h = 0.30
    block_top = cy_block + mass_h / 2
    block_bot = cy_block - mass_h / 2

    # 天花板支座
    ceil_y = cy_block + 1.15
    _bracket(ax, cx, ceil_y)
    # 弹簧：天花板到质量块顶面
    _spring(ax, cx, ceil_y - 0.06, block_top)

    # 地板支座
    floor_y = cy_block - 1.15
    if show_damper:
        # 阻尼器：质量块底面到地板
        _damper(ax, cx, block_bot, floor_y + 0.06)
    else:
        # 不画阻尼器，仅用细点线连接，保持质量块"悬于地板上方"的视觉关系
        ax.plot([cx, cx], [block_bot, floor_y + 0.06],
                color=GREY, lw=1.4, ls=":", zorder=2)
    _bracket(ax, cx, floor_y)

    # 穿过质量块的平衡位置虚线
    ax.plot([cx - 0.75, cx + 0.75], [cy_block, cy_block],
            color=GREY, ls="--", lw=0.9, zorder=1)

    # 质量块右侧的双向运动箭头
    ax.add_patch(FancyArrowPatch(
        (cx + 0.62, cy_block - motion_amp),
        (cx + 0.62, cy_block + motion_amp),
        arrowstyle="<->", mutation_scale=10,
        color="black", lw=1.2, zorder=4,
    ))


def draw_model(ax):
    ax.set_axis_off()
    ax.set_xlim(-0.5, 4.5)
    ax.set_ylim(-4.6, 1.6)
    ax.set_aspect("equal")

    ax.set_title("(a) Three Damping Regimes of a Mass-Spring System",
                 fontsize=11, pad=8)

    # 三套系统的纵坐标（自上而下）
    ys = [0.35, -1.55, -3.45]
    regimes = [
        ("Underdamped", r"$\beta < \omega_0$", True),
        ("Critically damped", r"$\beta = \omega_0$", True),
        ("Overdamped", r"$\beta > \omega_0$", False),
    ]
    cx = 1.4

    for i, (name, cond, show_d) in enumerate(regimes):
        cy = ys[i]
        _draw_one_system(ax, cx, cy, show_damper=show_d)

        # 右侧标注阻尼类型与条件
        ax.text(cx + 1.05, cy + 0.08, name,
                fontsize=11, fontweight="bold", va="center")
        ax.text(cx + 1.05, cy - 0.16, cond,
                fontsize=10, color=GREY, va="center")

        # 系统之间的分隔虚线（最后一组之后不画）
        if i < len(regimes) - 1:
            sep_y = (ys[i] + ys[i + 1]) / 2.0 - 0.55
            ax.plot([-0.35, 4.0], [sep_y, sep_y],
                    color="#cccccc", ls="--", lw=0.7, zorder=0)

    # 面板底部图例
    handles = [
        Line2D([0], [0], color=GREY, lw=1.8, label="Spring ($k$)"),
        Line2D([0], [0], color=GREY, lw=1.8, label="Damper ($b$)"),
        Line2D([0], [0], color=MASS_COL, lw=6.0, label="Mass ($m$)"),
        Line2D([0], [0], color=GREY, ls="--", lw=1.0, label="Equilibrium"),
    ]
    ax.legend(handles=handles, loc="upper left", fontsize=8,
              frameon=True, edgecolor="#cccccc", facecolor="white",
              framealpha=0.9, bbox_to_anchor=(0.0, 0.135))


# --------------------------------------------------------------------------- #
# 解析解（均由静止释放：x(0)=A, x'(0)=0）
# --------------------------------------------------------------------------- #
def x_underdamped(t, beta):
    """beta < omega0: x = A e^{-beta t} cos(w1 t), w1 = sqrt(omega0^2 - beta^2)."""
    w1 = np.sqrt(OMEGA0**2 - beta**2)
    return A * np.exp(-beta * t) * np.cos(w1 * t)


def x_critical(t):
    """beta = omega0: x = A (1 + omega0 t) e^{-omega0 t}."""
    return A * (1.0 + OMEGA0 * t) * np.exp(-OMEGA0 * t)


def x_overdamped(t, beta):
    """beta > omega0: x = (A/2)(e^{-r1 t} + e^{-r2 t}), r1,2 = beta -+ sqrt(beta^2 - omega0^2)."""
    disc = np.sqrt(beta**2 - OMEGA0**2)
    r1 = beta - disc
    r2 = beta + disc
    return A * 0.5 * (np.exp(-r1 * t) + np.exp(-r2 * t))


# --------------------------------------------------------------------------- #
# 面板 (b) —— 位移曲线
# --------------------------------------------------------------------------- #
def draw_curves(ax):
    ax.set_title(
        r"(b) Displacement vs. Time for Three Damping Regimes",
        fontsize=11, pad=8,
    )

    t = np.linspace(0, 6 * T0, 2000)
    w1 = np.sqrt(OMEGA0**2 - BETA_U**2)

    xu = x_underdamped(t, BETA_U)
    xc = x_critical(t)
    xo = x_overdamped(t, BETA_O)
    env_p = A * np.exp(-BETA_U * t)   # 正包络
    env_n = -env_p                    # 负包络

    # --- 三条曲线 ---
    ax.plot(t, xu, color=BLU, lw=2.6, label="Underdamped", zorder=4)
    ax.plot(t, xc, color=GRN, lw=2.6, label="Critically damped", zorder=4)
    ax.plot(t, xo, color=ORG, lw=2.6, label="Overdamped", zorder=4)

    # --- 欠阻尼包络（蓝色虚线） ---
    ax.plot(t, env_p, color=BLU, ls="--", lw=1.4, alpha=0.9, zorder=3)
    ax.plot(t, env_n, color=BLU, ls="--", lw=1.4, alpha=0.9, zorder=3)

    # --- 坐标轴 ---
    ax.set_xlim(0, 6 * T0)
    ax.set_xticks(np.arange(0, 6 * T0 + 1e-9, T0))
    ax.set_xticklabels([r"$0$", r"$T_0$", r"$2T_0$", r"$3T_0$",
                        r"$4T_0$", r"$5T_0$", r"$6T_0$"])
    ax.set_xlabel(r"Time $t$ (s)", fontsize=10)

    ax.set_ylim(-0.45, 1.18)
    ax.set_yticks([1.0, 0.5, 0.0, -0.5])
    ax.set_ylabel(r"Displacement $x(t)/A$", fontsize=10)
    ax.tick_params(labelsize=8)

    # --- 浅灰虚线网格 ---
    ax.grid(True, which="both", color="#dddddd", lw=0.6, ls="--", zorder=0)
    ax.axhline(0, color=GREY, lw=0.7, zorder=1)

    # --- 共同起点 (0, A) ---
    ax.scatter([0], [A], s=30, facecolor="white",
               edgecolor="black", zorder=6)

    # --- 时间常数标记：包络在 t = tau = 1/beta 处取 A/e ---
    inv_e = A / np.e
    tau = 1.0 / BETA_U
    ax.axhline(inv_e, color=BLU, ls=":", lw=1.0, alpha=0.8, zorder=2)
    ax.plot([tau, tau], [0, inv_e], color=BLU, ls=":", lw=1.0,
            alpha=0.8, zorder=2)
    ax.scatter([tau], [inv_e], s=26, facecolor="white",
               edgecolor=BLU, zorder=6)
    ax.annotate(r"$\tau = 1/\beta$", xy=(tau, inv_e),
                xytext=(tau + 0.25, inv_e + 0.13),
                fontsize=9, color=BLU,
                arrowprops=dict(arrowstyle="->", color=BLU, lw=0.8))
    ax.text(6 * T0 - 0.05, inv_e + 0.015, r"$A/e$",
            ha="right", va="bottom", fontsize=8, color=BLU)

    # --- 欠阻尼首次过零点：cos(w1 t) = 0 -> t = pi/(2 w1) ---
    t_zero1 = np.pi / (2 * w1)
    ax.scatter([t_zero1], [0], s=26, facecolor="white",
               edgecolor=BLU, zorder=6)
    ax.annotate("first zero", xy=(t_zero1, 0),
                xytext=(t_zero1 + 0.2, -0.22),
                fontsize=8, color=BLU,
                arrowprops=dict(arrowstyle="->", color=BLU, lw=0.8))

    # --- 公式标注（加粗、配色、圆角底色框） ---
    ax.text(
        0.985, 0.94,
        r"$\mathbf{x(t) = A\,e^{-\beta t}\cos(\omega_1 t)}$",
        transform=ax.transAxes, ha="right", va="top",
        fontsize=10.5, color=BLU, fontweight="bold",
        bbox=dict(boxstyle="round,pad=0.30", fc="white",
                  ec="#cccccc", lw=0.6),
    )
    ax.text(
        0.985, 0.80,
        r"$\mathbf{x(t) = A(1+\omega_0 t)\,e^{-\omega_0 t}}$",
        transform=ax.transAxes, ha="right", va="top",
        fontsize=10.5, color=GRN, fontweight="bold",
        bbox=dict(boxstyle="round,pad=0.30", fc="white",
                  ec="#cccccc", lw=0.6),
    )
    ax.text(
        0.985, 0.66,
        r"$\mathbf{x(t) = \dfrac{A}{2}(e^{-r_1 t}+e^{-r_2 t})}$",
        transform=ax.transAxes, ha="right", va="top",
        fontsize=10.5, color=ORG, fontweight="bold",
        bbox=dict(boxstyle="round,pad=0.30", fc="white",
                  ec="#cccccc", lw=0.6),
    )
    # omega1 的定义（小字，紧跟在欠阻尼公式下方）
    ax.text(
        0.985, 0.585,
        r"$\omega_1 = \sqrt{\omega_0^2 - \beta^2}$",
        transform=ax.transAxes, ha="right", va="top",
        fontsize=9, color=BLU, style="italic",
    )

    # --- 图例 ---
    handles = [
        Line2D([0], [0], color=BLU, lw=2.6, label="Underdamped"),
        Line2D([0], [0], color=GRN, lw=2.6, label="Critically damped"),
        Line2D([0], [0], color=ORG, lw=2.6, label="Overdamped"),
        Line2D([0], [0], color=BLU, ls="--", lw=1.4,
               label=r"Envelope $\pm A e^{-\beta t}$"),
    ]
    # 三条曲线在右下方均已衰减到 0 附近，图例放在该处
    ax.legend(handles=handles, loc="lower right", fontsize=8.5,
              frameon=True, edgecolor="#cccccc", facecolor="white",
              framealpha=0.9)


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
        png = Path(os.environ["TEMP"]) / "damped-oscillation.png"
        fig.savefig(png, dpi=150, facecolor="white", bbox_inches="tight")
        print("preview", png)

    plt.close(fig)


if __name__ == "__main__":
    main()
