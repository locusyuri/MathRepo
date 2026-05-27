# Requirements Document

## Introduction

Refactor the "Definition and Properties of Measurable Functions" section (§2.1) in `1.Analyse/Analyse Réelle/chapters/LebesgueMeasure.typ`. The goal is to reorganize content placement for better logical flow without altering mathematical content. The convergence section (§2.2) is explicitly out of scope.

## Glossary

- **Source_File**: The Typst file `1.Analyse/Analyse Réelle/chapters/LebesgueMeasure.typ`
- **Section_2_1**: The "Definition and Properties of Measurable Functions" section (`== Definition and Properties of Measurable Functions`)
- **Section_1**: The "σ-Algebra and Measure" section (`== $sigma$-Algebra and Measure // Sigma 代数和测度`)
- **Measure_Space_Subsection**: The `=== Measure Space // 测度空间` subsection within Section_1
- **Almost_Everywhere_Definition**: The `#definition(name: "Almost Everywhere")` block and its associated examples
- **Algebraic_Operations_Proposition**: The `#proposition` about sums, differences, products, and quotients of measurable functions being measurable
- **Equivalent_Characterizations_Proposition**: The `#proposition(name: "Equivalent Characterizations of Measurable Functions")` block
- **Simple_Function_Definition**: The `#definition(name: "Simple Function")` block
- **Simple_Function_Note**: The `#note` block immediately following the Simple_Function_Definition
- **Measurable_Functions_Series_Subsection**: The `=== Measurable Functions Series` subsection heading
- **Section_2_2**: The "Convergence of Measurable Functions" section (`== Convergence of Measurable Functions`), which is out of scope

## Requirements

### Requirement 1: Move "Almost Everywhere" Definition to Measure Space Section

**User Story:** As a reader, I want the "Almost Everywhere" definition to appear in the measure space section, so that it is introduced alongside other fundamental measure-theoretic concepts before being used in the measurable functions section.

#### Acceptance Criteria

1. WHEN the refactoring is applied, THE Source_File SHALL contain the Almost_Everywhere_Definition (including its examples block) in the Measure_Space_Subsection, placed after the Lebesgue Measure Space definition and before the Borel-Cantelli Lemma.
2. WHEN the refactoring is applied, THE Source_File SHALL NOT contain the Almost_Everywhere_Definition in Section_2_1.
3. THE Source_File SHALL preserve the complete text content of the Almost_Everywhere_Definition and its associated examples without modification.

### Requirement 2: Rename "Measurable Functions Series" Subsection

**User Story:** As a reader, I want the subsection to be named "Sequences of Measurable Functions" with its Chinese annotation, so that the terminology is mathematically precise and consistent with standard usage.

#### Acceptance Criteria

1. WHEN the refactoring is applied, THE Source_File SHALL contain the heading `=== Sequences of Measurable Functions // 可测函数列` in place of the previous `=== Measurable Functions Series // 可测函数列` heading.
2. THE Source_File SHALL preserve all content within the renamed subsection without modification.

### Requirement 3: Move Algebraic Operations Proposition

**User Story:** As a reader, I want the proposition about algebraic operations on measurable functions to appear right after the equivalent characterizations, so that basic algebraic closure properties are presented before introducing simple functions.

#### Acceptance Criteria

1. WHEN the refactoring is applied, THE Source_File SHALL contain the Algebraic_Operations_Proposition immediately after the Equivalent_Characterizations_Proposition (and before the Simple Function subsection heading).
2. WHEN the refactoring is applied, THE Source_File SHALL NOT contain the Algebraic_Operations_Proposition in its original location (after the Approximation by Simple Functions corollary).
3. THE Source_File SHALL preserve the complete text content of the Algebraic_Operations_Proposition without modification.

### Requirement 4: Fix Simple Function Note

**User Story:** As a reader, I want the note after the Simple Function definition to correctly explain the relationship between general simple functions and measurable simple functions, so that the note does not contradict the definition it follows.

#### Acceptance Criteria

1. WHEN the refactoring is applied, THE Simple_Function_Note SHALL explain that a general simple function only requires finite distinct values and a partition into disjoint sets (without requiring measurability of those sets).
2. WHEN the refactoring is applied, THE Simple_Function_Note SHALL clarify that the definition given above uses the stronger version where $A_k in cal(S)$ (measurable simple function) by default.
3. WHEN the refactoring is applied, THE Simple_Function_Note SHALL state that from now on, "simple function" refers to the measurable version by default.
4. THE Simple_Function_Note SHALL be written in the bilingual style consistent with the rest of the document (English with Chinese comments).

### Requirement 5: Add Borel and Lebesgue Measurable Function Clarification

**User Story:** As a reader, I want a brief remark clarifying the relationship between Borel measurable functions and Lebesgue measurable functions, so that I understand how the general measurable function definition specializes in common settings.

#### Acceptance Criteria

1. WHEN the refactoring is applied, THE Source_File SHALL contain a `#proposition` block after the real measurable function paragraph (following the measurable function definition) that states: when the domain is equipped with the Borel σ-algebra $cal(B)(bb(R)^n)$, the function is called Borel measurable; when equipped with the Lebesgue σ-algebra $cal(L)(bb(R)^n)$, it is called Lebesgue measurable; and every Borel measurable function is Lebesgue measurable (since $cal(B)(bb(R)^n) subset cal(L)(bb(R)^n)$), but the converse does not hold in general.
2. THE proposition SHALL be placed in a logical position: after the paragraph about real measurable functions and before the equivalent characterizations proposition.
3. THE proposition SHALL be written in the bilingual style consistent with the rest of the document (English with Chinese comments).

### Requirement 6: Preserve Section 2.2 (Convergence) Unchanged

**User Story:** As a maintainer, I want the convergence section to remain untouched, so that it can be refactored separately in a future task.

#### Acceptance Criteria

1. THE Source_File SHALL preserve all content in Section_2_2 and subsequent sections identical to the original.
2. THE refactoring SHALL NOT add, remove, or modify any content at or after the `== Convergence of Measurable Functions` heading.
