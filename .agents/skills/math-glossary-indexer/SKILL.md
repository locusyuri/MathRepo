---
name: math-glossary-indexer
description: 扫描 Typst 文件中的标签（如 <def:limit-of-sequence-of-sets>），在 Appendix 的 Glossary 节中生成字母索引。
user_invocable: true
---

# Glossary Indexer (索引生成技能)

## Usage

```
/math-glossary-indexer <subject-initial.typ>
```

## Workflow

Given a Typst file path (e.g. `1.Analyse/Analyse Réelle/chapters/LebesgueIntegration.typ`), perform the following steps:

### Step 1: Scan for Labels

Search the file for all labels matching the pattern:

```regex
<[a-z]+:[a-z][a-z0-9-]*>
```

Examples: `<def:continuation>`, `<def:limit-of-sequence-of-sets>`, `<thm:open-set-construction>`

Use `grep` (POSIX) / `findstr` (Windows) to extract all unique labels.

### Step 2: Parse Each Label

Split each label into:
- **Prefix**: the part before the first `:` (e.g. `def`, `thm`, `lem`, `cor`, `prop`, `ex`, `note`)
- **Name**: the kebab-case part after the `:` (e.g. `limit-of-sequence-of-sets`)
- **Display Name**: convert kebab-case to Title Case with spaces
  - Replace `-` with ` `
  - Capitalize first letter of each word
  - Example: `limit-of-sequence-of-sets` → `Limit of a Sequence of Sets`

### Step 3: Organize Alphabetically

Group entries by the **first letter** of the Display Name (uppercase A-Z).

For each letter group, sort entries alphabetically.

### Step 4: Generate Glossary Content

Generate the following structure at the end of the file:

```typst
#part("Appendix")
= Glossary

#{
  set heading(numbering: none)
  show heading.where(level: 2): it => {
    set par(first-line-indent: 0em)
    v(1.2em)
    text(size: 18pt, font: font-latin-title, weight: "bold", fill: color-title)[#it.body]
    v(0.5em)
  }

  [
  == A
  - *#link(<def:...>)[Display Name]*
  - *#link(<thm:...>)[Display Name]*

  == B
  - ...
  ]
}
```

Rules:
- Use `== <Letter>` for each letter heading, but keep all letter headings **inside the scoped `#{}` block** so they are not numbered.
- Use `- *#link(<tag>)[Display Name]*` for each entry (bullet + link).
- Skip letters that have no entries.
- Delete any existing glossary content between `#part("Appendix")` and the end of file before inserting the new one.
- Close the content block (`]` + `}`) before `#bibliography`, `= References`, the next Part, or any other content outside the glossary.

**Why the scoped block is required:** the shared template's level-2 heading show rule prints `chapter.section` unconditionally. A bare `set heading(numbering: none)` does not suppress that printed prefix, and `== A` would render as `7.1 A`. The local `show heading.where(level: 2)` rule above replaces the template's numbering display for the glossary only. `set heading(numbering: none)` additionally removes numbering from the outline entries.

**Header caveat:** the template's running header counts every level-2 heading, including these unnumbered letters, so its `Sec. x.y.` prefix may still appear. Hiding that prefix requires a template-level change and is outside this skill's local scope.

### Step 5: Verify

Compile the file after insertion:

```bash
typst compile "<subject>/initial.typ" "<subject>/initial.pdf" --root .
```

### Repo-wide Term Index

To merge every note's glossary into the README term index:

```bash
uv run scripts/glossary/collect-glossaries.py --stats
uv run scripts/glossary/collect-glossaries.py --types def,thm,prop,lem,cor,ex --no-chinese --write README.md
```

The script groups terms A–Z, merges duplicate terms with all notes that define them, and replaces only the `# Term Index | 术语索引` section. Add `--defs-only` if the index should contain definitions only.
