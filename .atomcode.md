# MathRepo — Project Instructions

Bilingual (English/Chinese) mathematics notes repository. Typst is the primary authoring format; legacy LaTeX (`.tex`) files are preserved as-is and should not be edited unless explicitly requested.

## Build & Verification

- **No test framework**. Verify changes by compiling the subject's entrypoint:
  ```bash
  typst compile "<subject>/initial.typ" "<subject>/initial.pdf" --root .
  ```
- Always compile `initial.typ` (the entrypoint), not individual chapter files.
- Working directory must be the repo root (`C:\Notiz\MathRepo`).
- Common errors: `unknown variable` → check Typst symbol names; `--root .` missing → append it.

## Project Structure

```
<Subject>/
  initial.typ          # Entrypoint (only compile target)
  initial.pdf          # Generated PDF (same directory)
  references.bib       # Bibliography (optional)
  chapters/            # Chapter source files
  img/                 # Images
  tmp/                 # Build cache (legacy)
```

- Import the shared template at the top of every `initial.typ`:
  ```typst
  #import "../../TypstTemplate/math-notes.typ": *
  ```
- Group content with `#part("Title")`, include chapters with `#include "chapters/...typ"`.

## Content Conventions

- **Bilingual**: English title first, Chinese translation in parentheses, e.g. `// Lebesgue Measure (勒贝格测度)`.
- **Theorem blocks** (from template):
  | Component | Usage |
  |-----------|-------|
  | `#theorem`, `#corollary`, `#lemma` | Red (♥) — theorems |
  | `#definition`, `#property` | Green (♣) — definitions |
  | `#proposition`, `#example` | Blue (♠) — propositions |
  | `#axiom`, `#postulate` | Purple (♦) — axioms |
  | `#proof`, `#solution` | Unnumbered proofs |
  | `#note`, `#caution` | Annotations |
  | `#exercise` | Practice problems |
- **Typography**: Follow `.agent/Typst.md` for Typst syntax, `.agent/Gen_Content.md` for directory structure generation.
- **Cross-references**: Use `@label-name` tags.
- **Edits**: Keep changes local to the active subject and its directly included files.

## Available Skills

| Skill | File | Purpose |
|-------|------|---------|
| typst-compile | `.github/skills/typst-compile/SKILL.md` | Compile and verify `.typ` files |
| typst-writing-conventions | `.github/skills/typst-writing-conventions/SKILL.md` | LaTeX → Typst symbol mapping, formatting rules |
| proof-reviewer | `.github/skills/proof-reviewer/SKILL.md` | Review mathematical proof logic and rigor |
| code-reviewer | `.github/skills/code-reviewer/SKILL.md` | Cross-file consistency and SRP checks |
| template-usage | `.github/skills/template-usage/SKILL.md` | Template components and conventions |
