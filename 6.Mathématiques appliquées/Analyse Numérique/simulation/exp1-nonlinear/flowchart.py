"""实验一 3.1.1 程序流程图（含 3.2 方程组 Newton）。

四个面板（2x2）：
  (a) 二分法           while (b-a)/2 >= eps
  (b) Newton 法        x_{k+1}=x_k-f/f'，|dx|<eps 终止，f'≈0 保护
  (c) 割线法           两点差商，分母近零保护
  (d) 非线性方程组 Newton  J*dX=-F，||dX||_inf<eps 终止（对应 3.2 悬链线）

产物：output/exp1/flowcharts.{svg,png}

每个面板都画齐：输入、判定菱形、更新框、循环回边（左侧蓝线）、终止输出。
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))  # → simulation/

from matplotlib.patches import FancyArrowPatch, FancyBboxPatch, Polygon  # noqa: E402
from matplotlib.path import Path as MPath  # noqa: E402
import matplotlib.pyplot as plt  # noqa: E402

from common import BLUE, GRAY, RED, save  # noqa: E402

FS = 9.2          # 框内字号
HGT = {"start": 0.80, "end": 0.80, "in": 1.00, "out": 1.00, "proc": 1.30, "if": 1.75}
WID = {"start": 2.70, "end": 3.60, "in": 4.40, "out": 3.80, "proc": 4.40, "if": 5.40}
GAP = 0.52        # 相邻节点竖向间隙
XC, XS = 3.40, 8.75   # 主干列 / 右侧分支列的中心 x
X_BUS = 0.55      # 回边的竖直走线位置


def _node(ax, kind: str, x: float, y: float, text: str, w=None, h=None, fs=FS) -> None:
    w = WID[kind] if w is None else w
    h = HGT[kind] if h is None else h
    if kind == "if":
        pts = [(x - w / 2, y), (x, y + h / 2), (x + w / 2, y), (x, y - h / 2)]
        ax.add_patch(Polygon(pts, closed=True, fc="#fffdf5", ec=GRAY, lw=1.3, zorder=2))
    else:
        rounded = kind in ("start", "end")
        style = "round,pad=0,rounding_size=0.34" if rounded else "square,pad=0"
        fill = {"start": "#e8eff8", "end": "#e8eff8", "in": "#f5f5f5", "out": "#f5f5f5", "proc": "white"}
        ax.add_patch(
            FancyBboxPatch(
                (x - w / 2, y - h / 2), w, h, boxstyle=style, fc=fill[kind], ec=GRAY, lw=1.3, zorder=2
            )
        )
    ax.text(x, y, text, ha="center", va="center", fontsize=fs, zorder=3, linespacing=1.5)


def _arrow(ax, p0, p1, label: str = "", color=GRAY, dx: float = 0.0, dy: float = 0.0) -> None:
    ax.add_patch(
        FancyArrowPatch(
            p0, p1, arrowstyle="-|>", mutation_scale=13, lw=1.25, color=color, shrinkA=0, shrinkB=0, zorder=1
        )
    )
    if label:
        mx = (p0[0] + p1[0]) / 2 + dx
        my = (p0[1] + p1[1]) / 2 + dy
        ax.text(mx, my, label, fontsize=8.6, color=RED, ha="center", va="center",
                bbox=dict(fc="white", ec="none", pad=0.9), zorder=4)


def _bus(ax, starts, y_bus: float, y_target: float, x_entry: float, label: str = "") -> None:
    """回边：各分支下沿 → 横向汇到左侧竖线 → 上行 → 箭头指回目标菱形左顶点。"""
    for sx, sy in starts:
        ax.plot([sx, sx], [sy, y_bus], color=BLUE, lw=1.25, zorder=1)
        ax.plot([sx, X_BUS], [y_bus, y_bus], color=BLUE, lw=1.25, zorder=1)
    verts = [(X_BUS, y_bus), (X_BUS, y_target), (x_entry, y_target)]
    codes = [MPath.MOVETO, MPath.LINETO, MPath.LINETO]
    ax.add_patch(
        FancyArrowPatch(path=MPath(verts, codes), arrowstyle="-|>", mutation_scale=13, lw=1.25, color=BLUE, zorder=1)
    )
    if label:
        ax.text(X_BUS, (y_bus + y_target) / 2, label, fontsize=8.6, color=BLUE,
                ha="center", va="center", rotation=90,
                bbox=dict(fc="white", ec="none", pad=1.0), zorder=4)


def _panel(ax, title: str, spine, sides=(), back_target=None, back_label="k ← k+1") -> None:
    hs = [node.get("h", HGT[node["kind"]]) for node in spine]
    total = sum(hs) + GAP * (len(spine) - 1)
    ys, ycur = [], total
    for h in hs:
        ys.append(ycur - h / 2)
        ycur -= h + GAP

    ax.set_xlim(0, 11.2)
    ax.set_ylim(-0.85, total + 0.25)
    ax.axis("off")
    ax.set_title(title, fontsize=11, pad=2)

    for node, y, h in zip(spine, ys, hs):
        _node(ax, node["kind"], XC, y, node["text"], h=h, fs=node.get("fs", FS))

    for i in range(len(spine) - 1):
        y0 = ys[i] - hs[i] / 2
        y1 = ys[i + 1] + hs[i + 1] / 2
        _arrow(ax, (XC, y0), (XC, y1), spine[i].get("label", ""), dx=0.30)

    for side in sides:
        y = ys[side["row"]]
        w = WID[side["kind"]]
        _node(ax, side["kind"], XS, y, side["text"], w=w, fs=side.get("fs", FS))
        x0 = XC + WID[spine[side["row"]]["kind"]] / 2
        _arrow(ax, (x0, y), (XS - w / 2, y), side.get("label", ""), dy=0.32)

    if back_target is not None:
        starts = [(XC, ys[-1] - hs[-1] / 2)]
        starts += [(XS, ys[s["row"]] - HGT[s["kind"]] / 2) for s in sides if s.get("back")]
        y_bus = min(s[1] for s in starts) - 0.42
        x_entry = XC - WID[spine[back_target]["kind"]] / 2  # 正好落在左顶点/左边界
        _bus(ax, starts, y_bus, ys[back_target], x_entry, back_label)


# ---------------------------------------------------------------- 四个面板
BISECT = dict(
    title="（a）二分法",
    spine=[
        {"kind": "start", "text": "开始"},
        {"kind": "in", "text": "输入 a, b 与精度 ε\n需 f(a)·f(b) < 0"},
        {"kind": "if", "text": "(b − a) / 2 ≥ ε ?"},
        {"kind": "proc", "text": "m ← (a + b) / 2\n计算 f(m)"},
        {"kind": "if", "text": "f(a)·f(m) < 0 ?", "label": "否"},
        {"kind": "proc", "text": "a ← m，f(a) ← f(m)"},
    ],
    sides=[
        {"row": 2, "kind": "end", "text": "输出 x = (a + b) / 2\n及迭代次数 n"},
        {"row": 4, "kind": "proc", "text": "b ← m，f(b) ← f(m)", "label": "是", "back": True},
    ],
    back_target=2,
)

NEWTON = dict(
    title="（b）Newton 法",
    spine=[
        {"kind": "start", "text": "开始"},
        {"kind": "in", "text": "输入初值 $x_0$ 与精度 $\\varepsilon$"},
        {"kind": "if", "text": "$f'(x_k) = 0$ ?"},
        {"kind": "proc", "text": "$x_{k+1}=x_k-f(x_k)/f'(x_k)$"},
        {"kind": "if", "text": "$|x_{k+1}-x_k|<\\varepsilon$ ?"},
        {"kind": "proc", "text": "$k\\leftarrow k+1$", "label": "否"},
    ],
    sides=[
        {"row": 2, "kind": "end", "text": "导数近零，迭代失败\n输出 $x_k$ 并标注"},
        {"row": 4, "kind": "end", "text": "输出 $x_{k+1}$\n与迭代次数 $n$"},
    ],
    back_target=2,
)

SECANT = dict(
    title="（c）割线法",
    spine=[
        {"kind": "start", "text": "开始"},
        {"kind": "in", "text": "输入 $x_0,x_1$ 与精度 $\\varepsilon$"},
        {"kind": "if", "text": "$|f(x_k)-f(x_{k-1})|<\\delta$ ?"},
        {
            "kind": "proc",
            "text": "$x_{k+1}=x_k-f(x_k)\\,d_k$\n"
            "$d_k=\\dfrac{x_k-x_{k-1}}{f(x_k)-f(x_{k-1})}$",
            "fs": 8.6,
            "h": 1.80,
        },
        {"kind": "if", "text": "$|x_{k+1}-x_k|<\\varepsilon$ ?"},
        {"kind": "proc", "text": "$k\\leftarrow k+1$", "label": "否"},
    ],
    sides=[
        {"row": 2, "kind": "end", "text": "差商分母近零\n终止并标注"},
        {"row": 4, "kind": "end", "text": "输出 $x_{k+1}$\n与迭代次数 $n$"},
    ],
    back_target=2,
)

SYSTEM = dict(
    title="（d）非线性方程组 Newton（3.2 用）",
    spine=[
        {"kind": "start", "text": "开始"},
        {"kind": "in", "text": "输入 $X_0=(x_0,y_0)^{T}$ 与 $\\varepsilon$"},
        {"kind": "proc", "text": "计算 $F(X_k)$ 与 Jacobian $J(X_k)$"},
        {"kind": "if", "text": "$\\det J(X_k)=0$ ?"},
        {"kind": "proc", "text": "解 $J\\,\\Delta X=-F(X_k)$\n$X_{k+1}\\leftarrow X_k+\\Delta X$"},
        {"kind": "if", "text": "$\\|\\Delta X\\|_\\infty<\\varepsilon$ ?"},
        {"kind": "proc", "text": "$k\\leftarrow k+1$", "label": "否"},
    ],
    sides=[
        {"row": 3, "kind": "end", "text": "$J$ 奇异，迭代失败"},
        {"row": 5, "kind": "end", "text": "输出 $X_{k+1}$\n与迭代次数 $n$"},
    ],
    back_target=2,
)


def main() -> None:
    fig, axes = plt.subplots(2, 2, figsize=(11, 13.2))
    for ax, spec in zip(axes.ravel(), (BISECT, NEWTON, SECANT, SYSTEM)):
        _panel(
            ax,
            spec["title"],
            spec["spine"],
            sides=spec["sides"],
            back_target=spec["back_target"],
            back_label="k ← k+1，返回判定",
        )
    fig.subplots_adjust(left=0.01, right=0.99, top=0.965, bottom=0.01, wspace=0.04, hspace=0.10)
    save(fig, 1, "flowcharts")


if __name__ == "__main__":
    main()
