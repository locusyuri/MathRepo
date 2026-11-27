"""实验一 3.2：弹性悬链线理论非线性方程组（2x2 Newton 法）。

方程组（王健、杨雨豪 2020）：
    f(x,y) = y + c*sh(y) - x - c*sh(x) - l/xi = 0
    g(x,y) = ch(y) + c/2*sh^2(y) - ch(x) - c/2*sh^2(x) - h/xi = 0
参数：H/EA = 0.0015，l = 200，h = 250，xi = 3500；初值 x0 = 1, y0 = 1.5。
解析 Jacobian 见模块内 J()，不解数值差分。

两次运行只改误差界（1e-3 / 1e-4），停止准则 ||dX||_inf < eps。
补充说明：两档精度都停在 n = 4——第 3 步到第 4 步的增量从 ~1.5e-2 直接跌到 ~9e-5，
一次性跨过 1e-3 与 1e-4，这本身就是二次收敛的表现；要看步数差异需把 eps 推到 1e-5 以下
（见 catenary-sweep 表）。

产物（output/exp1/）：
  catenary.{csv,md}          主表 2 行（列头照抄报告 3.2.1）
  catenary-detail.{csv,md}   每步 ||dX||_inf 与 ||F||_inf
  catenary-sweep.{csv,md}    误差界 -> 迭代次数
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))  # → simulation/

import numpy as np  # noqa: E402

from common import write_table  # noqa: E402

C = 0.0015        # H/EA
L = 200.0         # 索长参数 l
H = 250.0         # 高差参数 h
XI = 3500.0       # xi
X0 = np.array([1.0, 1.5])

EPS_LIST = (1e-3, 1e-4)
SWEEP = (1e-2, 1e-3, 1e-4, 1e-5, 1e-6, 1e-8, 1e-12)


def F(v: np.ndarray) -> np.ndarray:
    x, y = v
    return np.array(
        [
            y + C * np.sinh(y) - x - C * np.sinh(x) - L / XI,
            np.cosh(y) + 0.5 * C * np.sinh(y) ** 2 - np.cosh(x) - 0.5 * C * np.sinh(x) ** 2 - H / XI,
        ]
    )


def J(v: np.ndarray) -> np.ndarray:
    x, y = v
    chx, chy, shx, shy = np.cosh(x), np.cosh(y), np.sinh(x), np.sinh(y)
    return np.array(
        [
            [-1 - C * chx, 1 + C * chy],
            [-shx - C * shx * chx, shy + C * shy * chy],
        ]
    )


def newton_sys(x0: np.ndarray = X0, eps: float = 1e-4, maxit: int = 50):
    """2x2 Newton：解 J*dX = -F，X <- X + dX。返回 (解, 迭代次数, 逐步记录)。"""
    X = np.asarray(x0, dtype=float).copy()
    hist = []
    for n in range(1, maxit + 1):
        Jk = J(X)
        if abs(np.linalg.det(Jk)) < 1e-14:
            return X, n - 1, hist, "J 奇异"
        dX = np.linalg.solve(Jk, -F(X))
        X = X + dX
        hist.append((n, float(np.abs(dX).max()), float(np.abs(F(X)).max())))
        if np.abs(dX).max() < eps:
            return X, n, hist, "‖ΔX‖∞ < ε"
    return X, maxit, hist, "达最大迭代次数"


def main() -> None:
    results = {}
    hist_all = []
    for eps in EPS_LIST:
        X, n, hist, why = newton_sys(eps=eps)
        results[eps] = (X, n, why)
        hist_all += [(eps, k, dx, nf) for k, dx, nf in hist]

    # ---------------- 主表：列头与报告 3.2.1 逐字一致 ----------------
    rows = [
        [
            "$x_0=1,\\ y_0=1.5$",
            "(%.10f, %.10f)" % tuple(X),
            n,
            f"$\\varepsilon=10^{{{int(np.log10(eps))}}}$",
        ]
        for eps, (X, n, why) in results.items()
    ]
    write_table(
        1,
        "catenary",
        ["初始值", "方程的数值解", "迭代次数 $n$", "误差界"],
        rows,
        note=(
            "> 同一初值、只改误差界；停止准则 $\\|\\Delta X\\|_\\infty<\\varepsilon$。\n"
            "> 两档精度的迭代次数相同：第 3→4 步的 $\\|\\Delta X\\|_\\infty$ 由 $1.51\\times10^{-2}$ "
            "直落到 $9.07\\times10^{-5}$，一步跨过 $10^{-3}$ 与 $10^{-4}$ 两个量级（二次收敛的正常现象）；"
            "对应残差 $\\|F\\|_\\infty\\approx2.97\\times10^{-10}$。"
        ),
        float_fmt=None,
    )

    # ---------------- 逐步记录 ----------------
    write_table(
        1,
        "catenary-detail",
        ["误差界 $\\varepsilon$", "迭代 $k$", "$\\Vert\\Delta X_k\\Vert_\\infty$", "$\\Vert F(X_k)\\Vert_\\infty$"],
        [
            [f"1e{int(np.log10(eps))}", k, f"{dx:.3e}", f"{nf:.3e}"]
            for eps, k, dx, nf in hist_all
        ],
        note="> Newton 的二次收敛：残差每步大致平方下降（1.9e-2 → 1.4e-3 → 8.3e-6 → 3.0e-10）。",
        float_fmt=None,
    )

    # ---------------- 误差界扫描 ----------------
    write_table(
        1,
        "catenary-sweep",
        ["误差界 $\\varepsilon$", "迭代次数 $n$"],
        [[f"1e{int(np.log10(eps))}", newton_sys(eps=eps)[1]] for eps in SWEEP],
        note=(
            "> 报告只要求 1e-3 与 1e-4 两档（均为 4 步）；本表说明"
            "\"精度每提高一个量级步数不变\"只是恰好落在同一步，eps<=1e-5 后才多一步。"
        ),
        float_fmt=None,
    )

    X = newton_sys(eps=1e-15)[0]
    print("machine-precision solution: x = %.12f, y = %.12f" % (X[0], X[1]))
    print("residual ||F||_inf = %.3e" % np.abs(F(X)).max())
    print("J at solution:\n", J(X))
    print("det J = %.6e" % np.linalg.det(J(X)))


if __name__ == "__main__":
    main()
