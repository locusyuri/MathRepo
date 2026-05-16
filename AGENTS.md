# MathRepo Agent Instructions

- This repository is a bilingual mathematics note collection. Treat Typst as the primary authoring format; keep legacy LaTeX files unchanged unless the task explicitly targets `.tex` sources.
- Start from the subject entrypoint (`initial.typ` or legacy `initial.tex`) in the folder you are editing. Do not introduce new wrapper directories or reorganize the note tree.
- Keep edits local to the active subject and its directly included files. Preserve the existing bilingual naming, chapter ordering, and template style.
- For Typst syntax, symbols, theorem-like blocks, and common pitfalls, follow [`.agent/Typst.md`](.agent/Typst.md). For chapter-structure generation, follow [`.agent/Gen_Content.md`](.agent/Gen_Content.md).
- Keep formal images in `img/` for Typst subjects or `fig/` for legacy LaTeX subjects, bibliography in `references.bib`, and build output in `tmp/`.
- Preserve the shared Typst template import from `TypstTemplate/math-notes.typ` and existing component patterns such as `#part`, headings, and theorem/definition/proof blocks.
- There is no central build system; compile or check only the touched entrypoint when needed. Use Typst tooling for `.typ` files and LaTeX tooling only for legacy `.tex` files.
- Prefer linking to [README.md](README.md) and the `.agent/` docs rather than duplicating guidance in new files.

---
- 本仓库是一个双语数学笔记集合。请将 Typst 作为主要写作格式；除非任务明确指定要使用 `.tex` 源文件，否则请保持原有的 LaTeX 文件不变。

- 请从您正在编辑的文件夹中的主题入口点（`initial.typ` 或原有的 `initial.tex`）开始。请勿创建新的包装目录或重新组织笔记树。

- 请将编辑限制在当前主题及其直接包含的文件范围内。请保留现有的双语命名、章节顺序和模板样式。

- 有关 Typst 语法、符号、定理类代码块和常见陷阱，请参阅 [`.agent/Typst.md`](.agent/Typst.md)。有关章节结构生成，请参阅 [`.agent/Gen_Content.md`](.agent/Gen_Content.md)。 - 将 Typst 相关主题的正式图像保存在 `img/` 目录下，将旧版 LaTeX 相关主题的正式图像保存在 `fig/` 目录下；参考文献保存在 `references.bib` 目录下；构建输出保存在 `tmp/` 目录下。

- 保留从 `TypstTemplate/math-notes.typ` 导入的共享 Typst 模板，以及现有的组件模式，例如 `#part`、标题和定理/定义/证明块。

- 没有中央构建系统；仅在需要时编译或检查已修改的入口点。对 `.typ` 文件使用 Typst 工具，对旧版 `.tex` 文件仅使用 LaTeX 工具。

- 建议链接到 [README.md](README.md) 和 `.agent/` 文档，而不是在新文件中重复编写指南。