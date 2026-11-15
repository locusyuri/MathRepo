---
name: 踩坑与解法
description: Typst 渲染、插图脚本、工具链的已知坑与验证过的解法；遇到相似现象先查这里
---

# 踩坑与解法

## Typst

- **`_^` 后紧跟括号会被吞进上下标**：`L^oo(Omega)` 渲染成 `L^{oo(Omega)}`，应写 `L^(oo)(Omega)`。`scripts/check/check-typst-attachments.py` 可自动修。
- **LaTeX 花括号残留**：`a_{i j}(x)` 会按字面渲染出可见的 `{i j}`，改 `a_(i j)(x)`。
- **LaTeX 宏残留**（`\left`、`\cdot`、`\int` 等）由 `.agents/hooks` 的 PostToolUse 钩子拦截，不要靠手工兜底。
- **编译必须带 `--root .`**，否则图片相对路径与模板导入会解析失败。

## 插图

- **相对路径依赖**：部分绘图脚本用 `../img` 写文件，必须在笔记目录下运行；`build-images.py` 已按脚本的输出声明自动切换工作目录。
- **白底 SVG**：个别脚本输出白底，需再用笔记内 `scripts/svg-transparent.py` 去底，否则深色主题下露出白块。
- **图片不入 Git**：`img/`、`*.svg`、`*.png` 被忽略，重出图不产生 diff，提交内容只有脚本。

## 工具链

- Python 一律 `uv run`，不要用裸 `python`/`py`。
- 工程脚本靠"向上 N 层"推仓库根：`scripts/images/`、`scripts/check/`、`scripts/pdf/` 都在 `scripts/` 下一层，调整目录层级时必须同步改 `ROOT` / `$RepoRoot`。
