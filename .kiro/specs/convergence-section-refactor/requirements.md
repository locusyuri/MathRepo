# Requirements Document

## Introduction

Refactor the "Convergence of Measurable Functions" section (§2.2) in `1.Analyse/Analyse Réelle/chapters/LebesgueMeasure.typ`. The goal is to reorganize the section into a clearer pedagogical structure with two main subsections (Convergence in Measure and Almost Uniform Convergence), fix the incorrect Egorov's theorem statement, fill in the empty typewriter sequence example, and add a summary of implication relationships between all four convergence modes.

## Glossary

- **Refactored_Section**: The `== Convergence of Measurable Functions` section in `LebesgueMeasure.typ`, encompassing all content from the section heading to the next `==` heading.
- **Convergence_Modes**: The four modes of convergence: almost everywhere (a.e.), in measure (μ), almost uniform (a.u.), and $L^p$ norm convergence.
- **Typewriter_Sequence**: The "sliding bump" or "typewriter sequence" counterexample on $[0,1]$ demonstrating that convergence in measure does not imply almost everywhere convergence.
- **Egorov_Theorem**: The correct statement: on a finite measure space, almost everywhere convergence implies almost uniform convergence.
- **Implication_Diagram**: A summary note showing the logical relationships (implications and non-implications) between all four convergence modes.

## Requirements

### Requirement 1: Restructure the Definition Block at Section Top

**User Story:** As a reader, I want the section to start with the a.e. convergence definition as the primary concept, so that the most fundamental convergence mode is introduced first and other modes are introduced in their dedicated subsections.

#### Acceptance Criteria

1. THE Refactored_Section SHALL retain a definition block at the top containing only the almost everywhere convergence definition (extracted from the former three-mode block).
2. THE Refactored_Section SHALL move the convergence in measure definition into the Convergence in Measure subsection.
3. THE Refactored_Section SHALL move the almost uniform convergence definition into the Almost Uniform Convergence subsection.
4. THE Refactored_Section SHALL remove the `=== a.e. and $mu$` subsection heading and absorb its content into the new structure.
5. THE Refactored_Section SHALL remove the `=== $mu$ and a.u.` subsection heading and absorb its content into the new structure.
6. THE Refactored_Section SHALL remove the empty `=== a.e. and a.u.` subsection entirely.

### Requirement 2: Create Convergence in Measure Subsection

**User Story:** As a reader, I want a dedicated subsection on convergence in measure, so that I can study its properties, completeness, and relationship to other modes in one place.

#### Acceptance Criteria

1. THE Refactored_Section SHALL contain a subsection `=== Convergence in Measure // 依测度收敛` as the first subsection after the top-level definition block.
2. WHEN presenting convergence in measure content, THE Refactored_Section SHALL include the definition of Cauchy sequence in measure followed by the completeness theorem (existence of limit function).
3. WHEN presenting the relationship between convergence in measure and a.e. convergence, THE Refactored_Section SHALL include Riesz's theorem (subsequence characterization).
4. WHEN presenting the relationship between convergence in measure and a.e. convergence, THE Refactored_Section SHALL include a filled-in example of the typewriter sequence demonstrating that μ-convergence does not imply a.e. convergence.
5. THE Refactored_Section SHALL place the norm convergence content ($L^p$ convergence definition, Markov's inequality, and $L^1 => mu$ proposition) at the end of the Convergence in Measure subsection.
6. THE Refactored_Section SHALL remove the former standalone `=== Norm Convergence` subsection heading, integrating its content into the Convergence in Measure subsection.

### Requirement 3: Create Almost Uniform Convergence Subsection

**User Story:** As a reader, I want a dedicated subsection on almost uniform convergence, so that I can understand Egorov's theorem and the relationships between a.u. convergence and other modes.

#### Acceptance Criteria

1. THE Refactored_Section SHALL contain a subsection `=== Almost Uniform Convergence // 近一致收敛` as the second subsection.
2. WHEN presenting almost uniform convergence, THE Refactored_Section SHALL include the a.u. convergence definition (moved from the former combined definition block) as the first component of this subsection.
3. THE Refactored_Section SHALL state Egorov's theorem correctly: on a finite measure space, almost everywhere convergence implies almost uniform convergence (a.e. ⟹ a.u.), not the incorrect bidirectional equivalence with μ-convergence.
4. THE Refactored_Section SHALL include a statement that almost uniform convergence implies almost everywhere convergence (a.u. ⟹ a.e.).
5. THE Refactored_Section SHALL include a statement that almost uniform convergence implies convergence in measure (a.u. ⟹ μ).
6. THE Refactored_Section SHALL conclude with a summary note or diagram showing the implication relationships between all four convergence modes (a.e., μ, a.u., $L^p$).

### Requirement 4: Fill in the Typewriter Sequence Example

**User Story:** As a reader, I want a concrete counterexample showing that convergence in measure does not imply a.e. convergence, so that I understand the distinction between these modes.

#### Acceptance Criteria

1. WHEN presenting the typewriter sequence example, THE Refactored_Section SHALL define the sequence explicitly on $[0,1]$ with Lebesgue measure.
2. WHEN presenting the typewriter sequence example, THE Refactored_Section SHALL demonstrate that the sequence converges in measure to zero.
3. WHEN presenting the typewriter sequence example, THE Refactored_Section SHALL demonstrate that the sequence does not converge almost everywhere (every point is visited infinitely often).

### Requirement 5: Fix Egorov's Theorem Statement

**User Story:** As a reader, I want the correct statement of Egorov's theorem, so that I do not learn an incorrect mathematical fact.

#### Acceptance Criteria

1. THE Refactored_Section SHALL state Egorov's theorem as: if $f_n$ converges almost everywhere to $f$ on a finite measure space, then $f_n$ converges almost uniformly to $f$.
2. THE Refactored_Section SHALL NOT state Egorov's theorem as a biconditional equivalence between μ-convergence and a.u. convergence.
3. THE Refactored_Section SHALL use the correct hypothesis (a.e. convergence) rather than the incorrect hypothesis (μ-convergence) in the theorem statement.

### Requirement 6: Add Implication Summary

**User Story:** As a reader, I want a clear summary of all implication relationships between convergence modes, so that I can quickly reference which implications hold and which do not.

#### Acceptance Criteria

1. THE Refactored_Section SHALL include a summary note at the end of the Almost Uniform Convergence subsection showing all valid implications.
2. WHEN presenting the implication summary, THE Refactored_Section SHALL include: a.u. ⟹ a.e. ⟹ μ (on finite measure spaces), a.u. ⟹ μ, $L^p$ ⟹ μ, and a.e. ⟹ a.u. (Egorov, on finite measure spaces).
3. WHEN presenting the implication summary, THE Refactored_Section SHALL note that μ-convergence does NOT imply a.e. convergence in general (referencing the typewriter sequence).

### Requirement 7: Preserve All Correct Mathematical Content

**User Story:** As a reader, I want all existing correct theorems, definitions, and propositions preserved during the refactoring, so that no mathematical content is lost.

#### Acceptance Criteria

1. THE Refactored_Section SHALL preserve the Riesz theorem statement and content.
2. THE Refactored_Section SHALL preserve the Cauchy sequence in measure definition and completeness theorem.
3. THE Refactored_Section SHALL preserve the $L^p$ norm convergence definition, Markov's inequality, and the $L^1$ convergence proposition.
4. THE Refactored_Section SHALL preserve all existing Typst formatting conventions (theorem blocks, definition blocks, xarrow notation, bilingual comments).

### Requirement 8: Maintain Typst Compilation Compatibility

**User Story:** As a developer, I want the refactored file to compile without errors, so that the PDF output remains valid.

#### Acceptance Criteria

1. THE Refactored_Section SHALL use valid Typst syntax throughout all new and modified content.
2. THE Refactored_Section SHALL maintain consistent use of `xarrow` notation for convergence arrows.
3. THE Refactored_Section SHALL NOT introduce any new package imports beyond those already present in the file header.
