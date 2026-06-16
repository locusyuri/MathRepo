---
name: glossary-indexer
description: 扫描 Typst 文件中的标签（如 <def:limit-of-sequence-of-sets>），在 Appendix 的 Glossary 节中生成字母索引。
user_invocable: true
---

# Glossary Indexer (索引生成技能)

## Usage

```
/glossary-indexer <subject-initial.typ>
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

== A
- *#link(<def:...>)[Display Name]*
- *#link(<thm:...>)[Display Name]*

== B
- ...
```

Rules:
- Use `== <Letter>` for each letter heading
- Use `- *#link(<tag>)[Display Name]*` for each entry (bullet + link)
- Skip letters that have no entries
- Delete any existing glossary content between `#part("Appendix")` and the end of file before inserting the new one

### Step 5: Verify

Compile the file after insertion:

```bash
typst compile "<subject>/initial.typ" "<subject>/initial.pdf" --root .
```
