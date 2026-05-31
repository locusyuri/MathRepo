# MathRepo Agent Instructions

- Bilingual math notes repo; use Typst as the primary source and avoid editing legacy `.tex` unless explicitly asked.
- Start from each subject entrypoint (`initial.typ` or legacy `initial.tex`) in the folder you edit; do not add wrapper directories or reorganize the tree.
- Keep edits local to the active subject and its directly included files; preserve bilingual naming and chapter ordering.
- Typst rules and theorem/definition blocks: follow `.agent/Typst.md`; chapter-structure generation: follow `.agent/Gen_Content.md`.
- Place assets in `img/` for Typst subjects and `fig/` for legacy LaTeX; keep `references.bib` alongside the entrypoint; build output stays in `tmp/`.
- Preserve the shared Typst template import from `TypstTemplate/math-notes.typ` and existing `#part`/heading/theorem block patterns.
- No central build system; compile only the touched entrypoint (Typst for `.typ`, LaTeX for `.tex`).
