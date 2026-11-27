"""数值分析上机实验的公共约定：配色、中文字体、输出目录、图表落盘。

各实验脚本只需三行引导，就能复用这里的常量与函数：

    import sys
    from pathlib import Path
    sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
    from common import BLUE, RED, GRAY, GREEN, save, write_table

所有产物统一落在 ``simulation/output/exp<N>/``：``.svg`` 留档、``.png`` 贴报告，
``.csv`` 存数据、``.md`` 是同内容的 Markdown 表（可直接复制进 docx）。
"""

from __future__ import annotations

import csv
from pathlib import Path
from typing import Iterable, Sequence

import matplotlib

matplotlib.use("Agg")  # 无界面后端：脚本可在后台/无桌面环境直接运行
import matplotlib.pyplot as plt  # noqa: E402

BLUE, RED, GRAY, GREEN = "#3b6fb6", "#c74440", "#888888", "#3a8a5f"

HERE = Path(__file__).resolve().parent  # …/Analyse Numérique/simulation
OUT_ROOT = HERE / "output"

# 图内标签走英文/LaTeX，但流程图方框里是中文——不显式指定字体就会画成方块。
# svg.fonttype="path" 让 svg 里的字变成路径，换机器打开也不会变形。
plt.rcParams.update(
    {
        "font.family": "sans-serif",
        "font.sans-serif": ["Microsoft YaHei", "SimHei", "DejaVu Sans"],
        "axes.unicode_minus": False,
        "svg.fonttype": "path",
        "figure.dpi": 120,
    }
)


def out_dir(exp: int) -> Path:
    """返回 ``output/exp<exp>``，不存在就建好。"""
    d = OUT_ROOT / f"exp{exp}"
    d.mkdir(parents=True, exist_ok=True)
    return d


def save(fig, exp: int, name: str, *, dpi: int = 200) -> tuple[Path, Path]:
    """同时落 ``<name>.svg``（留档）与 ``<name>.png``（dpi≥200，贴报告用）。

    返回两个路径；顺手关闭 figure，避免批量出图时内存堆积。
    """
    d = out_dir(exp)
    svg, png = d / f"{name}.svg", d / f"{name}.png"
    fig.savefig(svg, format="svg")
    fig.savefig(png, format="png", dpi=dpi)
    plt.close(fig)
    return svg, png


def write_table(
    exp: int,
    name: str,
    header: Sequence[str],
    rows: Iterable[Sequence[object]],
    *,
    note: str = "",
    float_fmt: str | None = "%.6f",
) -> tuple[Path, Path]:
    """写 ``<name>.csv`` 与同内容的 ``<name>.md``，并把 Markdown 表打印到 stdout。

    列头直接照抄报告表格；``float_fmt`` 只作用于 float（None 表示原样输出）。
    """

    def cell(v: object) -> str:
        if isinstance(v, float) and float_fmt:
            return float_fmt % v
        return str(v)

    rows = [list(map(cell, r)) for r in rows]

    d = out_dir(exp)
    csv_path = d / f"{name}.csv"
    with csv_path.open("w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(rows)

    def esc(s: str) -> str:
        return s.replace("|", "\\|").replace("\n", "<br>")

    lines = []
    if note:
        lines += [note, ""]
    lines.append("| " + " | ".join(esc(h) for h in header) + " |")
    lines.append("|" + "|".join(["---"] * len(header)) + "|")
    for r in rows:
        lines.append("| " + " | ".join(esc(c) for c in r) + " |")
    md = "\n".join(lines) + "\n"

    md_path = d / f"{name}.md"
    md_path.write_text(md, encoding="utf-8")
    print(md)
    return csv_path, md_path
