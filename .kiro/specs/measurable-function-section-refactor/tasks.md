# Implementation Plan: Measurable Function Section Refactor

## Overview

Reorganize content within `1.Analyse/Analyse Réelle/chapters/LebesgueMeasure.typ` to improve logical flow in §2.1 (Definition and Properties of Measurable Functions). All operations are sequential edits to a single file, where each step depends on the previous due to line number shifts. A final compilation step verifies the result.

## Tasks

- [x] 1. Reorganize measurable function section content
  - [x] 1.1 Move "Almost Everywhere" definition to Measure Space subsection
    - Cut the `#definition(name: "Almost Everywhere")` block and its associated example list from the `=== Measurable Function` subsection in §2.1
    - Paste it into the `=== Measure Space` subsection, after the `#definition(name: "Lebesgue Measure Space")` block (and its spacing), before the paragraph starting "Finally, we present a commonly used lemma..."
    - Preserve the complete text content verbatim
    - _Requirements: 1.1, 1.2, 1.3_

  - [x] 1.2 Rename "Measurable Functions Series" subsection heading
    - Change `=== Measurable Functions Series // 可测函数列` to `=== Sequences of Measurable Functions // 可测函数列`
    - Preserve all content within the renamed subsection
    - _Requirements: 2.1, 2.2_

  - [x] 1.3 Move Algebraic Operations proposition after Equivalent Characterizations
    - Cut the `#proposition` about sums, differences, products, and quotients of measurable functions from its current location (after the Approximation by Simple Functions corollary)
    - Insert it immediately after the `#proposition(name: "Equivalent Characterizations of Measurable Functions")` block (which no longer has the "Almost Everywhere" definition after it), before the `=== Simple Function` subsection heading
    - Preserve the complete text content verbatim
    - _Requirements: 3.1, 3.2, 3.3_

  - [x] 1.4 Fix Simple Function note
    - Replace the current `#note` block after the Simple Function definition with the corrected version
    - New note explains: (1) general simple functions only require finite distinct values and disjoint partition without measurability, (2) the definition above uses the stronger measurable version, (3) "simple function" refers to measurable version by default
    - Write in bilingual style (English with Chinese comments)
    - _Requirements: 4.1, 4.2, 4.3, 4.4_

  - [x] 1.5 Add Borel and Lebesgue measurable function proposition
    - Insert a new `#proposition(name: "Borel and Lebesgue Measurable Functions")` block after the paragraph about real measurable functions ("Specially, if $Y = overline(bb(R))$...") and before the equivalent characterizations proposition
    - Content: defines Borel measurable (domain with $cal(B)(bb(R)^n)$) and Lebesgue measurable (domain with $cal(L)(bb(R)^n)$), states every Borel measurable function is Lebesgue measurable but not conversely
    - Write in bilingual style (English with Chinese comments)
    - _Requirements: 5.1, 5.2, 5.3_

- [x] 2. Verify compilation
  - [x] 2.1 Compile the document and confirm no errors
    - Run `typst compile "1.Analyse/Analyse Réelle/initial.typ" "1.Analyse/Analyse Réelle/initial.pdf" --root .`
    - Verify the command exits with no errors
    - _Requirements: 6.1, 6.2_

- [x] 3. Checkpoint - Verify all changes are correct
  - Ensure compilation passes, ask the user if questions arise.

## Notes

- All 5 content operations (tasks 1.1–1.5) modify the same file and must be executed sequentially since line numbers shift after each edit
- No property-based tests apply — this is a static document reorganization with no algorithmic behavior
- Section 2.2 (Convergence) and all subsequent sections must remain completely untouched
- The exact content for each operation is specified in the design document

## Task Dependency Graph

```json
{
  "waves": [
    { "id": 0, "tasks": ["1.1"] },
    { "id": 1, "tasks": ["1.2"] },
    { "id": 2, "tasks": ["1.3"] },
    { "id": 3, "tasks": ["1.4"] },
    { "id": 4, "tasks": ["1.5"] },
    { "id": 5, "tasks": ["2.1"] }
  ]
}
```
