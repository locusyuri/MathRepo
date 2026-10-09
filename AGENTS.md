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
- 技能见 `.agents/skills/`（均带 `violet-` 前缀，`.github/skills/` 为同源镜像）。

## Skill Routing（场景 → 技能）

| 场景 | 技能 |
|------|------|
| 编辑/创建 `.typ`，写公式、符号、语法 | `violet-typst-writing-conventions`（单一事实源，含 §9.7 编辑一致性、§9.8 编译验证） |
| 查模板组件 API、参数、颜色 | `violet-template-usage` |
| 从零规划新笔记目录骨架 | `violet-design-note` |
| 规划某章/节大纲（含补全、重构） | `violet-make-outline` |
| 审查笔记内容（严谨性、一致性、引用等） | `violet-content-review` |
| 处理 reviewer 批注文件 | `violet-review-annotation` |
| LaTeX `.tex` 迁移为 Typst | `violet-latex-to-typst` |
| 生成 Glossary 字母索引 | `violet-glossary-indexer` |
| Typst 语言/包通用问题（英文参考） | `violet-typst` |
