# MathRepo — Project Instructions

Bilingual (English/中文) math notes. Typst is the primary format; legacy `.tex` files stay as-is.

## Environment

- Python: use `uv run`（不要直接用 `python`/`py`）。
- JavaScript/TypeScript: use `bun`（不要用 `node`/`npm`/`pnpm`）。

## Build & Verify

```bash
typst compile "<subject>/initial.typ" "<subject>/initial.pdf" --root .
```

- 只编译入口 `initial.typ`，工作目录为仓库根，以退出码 0 为成功标准。

## Conventions

- 每个 `initial.typ` 顶部导入模板：
  ```typst
  #import "../../TypstTemplate/math-notes.typ": *
  ```
- 标题双语：英文在前，中文括号在后，如 `// Lebesgue Measure (勒贝格测度)`。
- 组件：`#theorem/#corollary/#lemma`（红）、`#definition/#property`（绿）、`#proposition/#example`（蓝）、`#axiom/#postulate`（紫）、`#proof/#solution`、`#note/#caution`、`#exercise`。
- 标签用 `<def:xxx>`、`<thm:xxx>` 等格式，交叉引用用 `@label`。
- 修改保持局部化，只动当前 subject 的 `initial.typ`。
- 技能见 `.agents/skills/`（均带 `violet-` 前缀，`.github/skills/` 为同源镜像）；写作规范查 `violet-typst-writing-conventions`，目录规划查 `violet-design-note`/`violet-make-outline`。
