# MathRepo — Project Instructions

Bilingual (English/中文) math notes. Typst is the primary format; legacy `.tex` files stay as-is.

## Environment

- Python: use `uv run`（不要直接用 `python`/`py`）。
- JavaScript/TypeScript: use `bun`（不要用 `node`/`npm`/`pnpm`）。

## Build & Verify

```bash
typst compile "<subject>/initial.typ" "<subject>/initial.pdf" --root .
```

只编译入口 `initial.typ`，工作目录为仓库根，以退出码 0 为成功标准。

## Conventions

- 每个 `initial.typ` 顶部导入模板：`#import "../../TypstTemplate/math-notes.typ": *`
- 标题双语：英文在前，中文括号在后，如 `// Lebesgue Measure (勒贝格测度)`。
- 标签用 `<def:xxx>`、`<thm:xxx>` 等格式，交叉引用用 `@label`。
- 修改保持局部化，只动当前 subject 的 `initial.typ`。
- 组件用法、写作规范、目录/大纲规划、内容审查等场景路由见 `.agents/skills/` 下各技能的 `description`（均带 `violet-` 前缀），此处不重复列出。

## 熔断机制

遇到难以解决的问题时（连续失败、反复试错仍无进展、或问题超出当前能力），**立即停止尝试并及时向用户求助**，说明已尝试的路径与卡点，不要自己一直试下去。
