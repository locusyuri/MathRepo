"""实验一 3.1：二分法 / Newton 法 / 割线法求解 f(x) = x^3 - 6x^2 + 11x - 6 = 0。

真解 x = 1, 2, 3；精度 eps = 1e-4；停止准则统一取增量判据
    ||x^(k+1) - x^k||_inf < eps        （检查不计入迭代次数）
Newton 法另加 f'(x_k) 近零保护，割线法加差商分母近零保护。

默认假设（见 实验报告.md §2.2、§7）：
  * 二分法：报告只给"初始值 0.5"，本脚本取区间 [0.5, 1.4]
    —— 兼顾"下端点即报告给的 0.5"与"避开中点恰为真解 x=1 的退化命中"；
  * 割线法：报告表格无此方法，补两组初值 (1.5, 1.8) 与 (2.5, 2.8)；

产物（output/exp1/）：
  single-equation.{csv,md}            主表 7 行（列头照抄报告 3.1.2）
  single-equation-extra.{csv,md}      补充表：诊断列 + 割线法两行
  single-equation-convergence.{svg,png}  误差-迭代半对数曲线
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))  # → simulation/

import numpy as np  # noqa: E402
import matplotlib.pyplot as plt  # noqa: E402

from common import BLUE, GRAY, GREEN, RED, save, write_table  # noqa: E402

EPS = 1e-4
A0, B0 = 0.5, 1.4                 # 二分法区间
NEWTON_X0 = (0.5, 0.8, 1.5, 1.8, 2.5, 2.8)
SECANT_PAIRS = ((1.5, 1.8), (2.5, 2.8))
ROOTS = np.array([1.0, 2.0, 3.0])  # 已知真解，用于判断"收敛到哪个根"


def f(x: float) -> float:
    return x**3 - 6 * x**2 + 11 * x - 6


def df(x: float) -> float:
    return 3 * x**2 - 12 * x + 11


def bisect(a: float, b: float, eps: float = EPS, maxit: int = 200):
    """二分法。返回 (解, 迭代次数, 中点序列, 终止说明)。"""
    fa = f(a)
    mids = []
    for n in range(1, maxit + 1):
        if (b - a) / 2 < eps:
            return (a + b) / 2, n - 1, mids, "区间半宽 < ε"
        m = (a + b) / 2
        fm = f(m)
        mids.append(m)
        if fm == 0:  # 精确命中（本实验默认区间下不会发生）
            return m, n, mids, "中点恰为真解"
        if fa * fm < 0:
            b = m
        else:
            a, fa = m, fm
    return (a + b) / 2, maxit, mids, "达最大迭代次数"


def newton(x0: float, eps: float = EPS, maxit: int = 100):
    """Newton 法。返回 (解, 迭代次数, 迭代点序列, 终止说明, 是否收敛)。"""
    x = float(x0)
    xs = [x]
    for n in range(1, maxit + 1):
        d = df(x)
        if abs(d) < 1e-14:
            return x, n - 1, xs, "f'(x) ≈ 0，导数近零", False
        step = f(x) / d
        x -= step
        xs.append(x)
        if abs(step) < eps:
            return x, n, xs, "‖Δx‖∞ < ε", True
    return x, maxit, xs, "达最大迭代次数", False


def secant(x0: float, x1: float, eps: float = EPS, maxit: int = 200):
    """割线法。返回 (解, 迭代次数, 迭代点序列, 终止说明, 是否收敛)。"""
    f0, f1 = f(x0), f(x1)
    xs = [float(x0), float(x1)]
    for n in range(1, maxit + 1):
        den = f1 - f0
        if abs(den) < 1e-14:
            return x1, n - 1, xs, "差商分母近零", False
        x2 = x1 - f1 * (x1 - x0) / den
        xs.append(x2)
        if abs(x2 - x1) < eps:
            return x2, n, xs, "‖Δx‖∞ < ε", True
        x0, f0, x1, f1 = x1, f1, x2, f(x2)
    return x1, maxit, xs, "达最大迭代次数", False


def nearest_root(x: float) -> float:
    return float(ROOTS[np.argmin(np.abs(ROOTS - x))])


def err_curve(xs, root: float, floor: float = 1e-16):
    """|x_k - x*| 曲线：真解处的 0 误差压到 floor，并在首次触底处截断（避免贴底横线）。"""
    e = np.maximum(np.abs(np.array(xs, dtype=float) - root), floor)
    hit = e <= floor
    idx = int(np.argmax(hit)) if hit.any() else len(e) - 1
    return np.arange(idx + 1), e[: idx + 1]


def main() -> None:
    # ---------------- 跑三个方法 ----------------
    x_bis, n_bis, mids, why_bis = bisect(A0, B0)

    runs = []  # (标签, 解, n, 迭代点, 说明, 收敛到, 首步)
    for x0 in NEWTON_X0:
        x, n, xs, why, ok = newton(x0)
        runs.append((f"Newton 法", x0, x, n, xs, why, ok, xs[1] if len(xs) > 1 else float("nan")))

    sec_runs = []
    for x0, x1 in SECANT_PAIRS:
        x, n, xs, why, ok = secant(x0, x1)
        sec_runs.append(((x0, x1), x, n, xs, why, ok, xs[2] if len(xs) > 2 else float("nan")))

    # ---------------- 主表：列头与报告 3.1.2 逐字一致 ----------------
    rows = [["二分法", f"{A0}", x_bis, n_bis]]
    rows += [["Newton 法", f"{x0}", x, n] for _, x0, x, n, *_ in runs]
    write_table(
        1,
        "single-equation",
        ["数值方法", "初始值 $x_0$", "方程的数值解", "迭代次数 $n$"],
        rows,
        note=(
            "> 停止准则：$|x^{(k+1)}-x^{(k)}|<10^{-4}$（二分法为区间半宽 $(b-a)/2<10^{-4}$）。\n"
            f"> 二分法区间取 $[{A0},{B0}]$（报告仅给出初始值 0.5，区间为本实验自定）；"
            "Newton 法初值一一对应报告 7 行表。"
        ),
        float_fmt="%.10f",
    )

    # ---------------- 补充表：诊断列 + 割线法 ----------------
    extra = []
    extra.append(["二分法", f"[{A0}, {B0}]", mids[0], x_bis, n_bis, nearest_root(x_bis), abs(f(x_bis)), why_bis])
    for _, x0, x, n, xs, why, ok, first in runs:
        extra.append(["Newton 法", f"{x0}", first, x, n, nearest_root(x), abs(f(x)), why])
    for pair, x, n, xs, why, ok, first in sec_runs:
        extra.append(["割线法", f"({pair[0]}, {pair[1]})", first, x, n, nearest_root(x), abs(f(x)), why])
    write_table(
        1,
        "single-equation-extra",
        ["数值方法", "初值/区间", "首步 $x_1$", "方程的数值解", "迭代次数 $n$",
         "收敛到的根", "残差 $r_n$", "终止说明"],
        [
            [r[0], r[1], f"{r[2]:.6f}", f"{r[3]:.10f}", r[4], f"{r[5]:.0f}", f"{r[6]:.3e}", r[7]]
            for r in extra
        ],
        note=(
            "> 残差 $r_n=f(x_n)$；Newton 法在 $x_0=1.5,2.5$ 处首步即落到真解，故残差为 0。\n"
            "> 割线法为补充结果（报告表格未列该方法，但实验目的要求）：两组初值均取自 Newton 表附近。\n"
            "> \"首步 $x_1$\"一列用来说明初值的影响：$x_0=1.5$ 与 $2.5$ 处 $f'=-0.25$ 近驻点，"
            "Newton 首步直接跳到 3 与 1。"
        ),
        float_fmt=None,
    )

    # ---------------- 收敛曲线 ----------------
    fig, ax = plt.subplots(figsize=(7.8, 5.2))
    color_of = {1.0: BLUE, 2.0: GREEN, 3.0: RED}
    floor = 1e-16  # |x_k - x*| = 0 的机器精度点压到下沿，表示"一步到位"

    ks = np.arange(1, len(mids) + 1)
    ax.semilogy(ks, np.maximum(np.abs(np.array(mids) - 1.0), floor), "o--", ms=3, lw=1.2,
                color=BLUE, alpha=0.75, label=f"bisection [{A0}, {B0}] → 1  (n={n_bis})")
    ax.semilogy(ks, 0.45 * 2.0 ** (-ks), "-", lw=1.0, color=GRAY,
                label=r"bound $\frac{b-a}{2}=0.45\cdot2^{-k}$")

    for _, x0, x, n, xs, why, ok, _first in runs:
        root = nearest_root(x)
        k, e = err_curve(xs, root, floor)
        ax.semilogy(k, e, "o-", ms=3, lw=1.2, color=color_of[root], alpha=0.75,
                    label=f"Newton $x_0$={x0} → {root:.0f}  (n={n})")

    for pair, x, n, xs, why, ok, _first in sec_runs:
        root = nearest_root(x)
        k, e = err_curve(xs, root, floor)
        ax.semilogy(k, e, "s:", ms=3, lw=1.2, color=color_of[root], alpha=0.55,
                    label=f"secant ({pair[0]},{pair[1]}) → {root:.0f}  (n={n})")

    ax.set_xlabel("iteration  $k$")
    ax.set_ylabel(r"$|x_k-x^\ast|$")
    ax.set_title("Experiment 1.3.1: error vs. iteration ($\\varepsilon=10^{-4}$)", fontsize=10.5)
    ax.grid(True, which="both", ls=":", lw=0.6, alpha=0.6)
    ax.legend(fontsize=6.5, ncol=3, loc="upper center", bbox_to_anchor=(0.5, -0.13), frameon=False)
    ax.set_ylim(5e-17, 2.0)
    fig.subplots_adjust(left=0.09, right=0.99, top=0.93, bottom=0.25)
    save(fig, 1, "single-equation-convergence")


if __name__ == "__main__":
    main()
