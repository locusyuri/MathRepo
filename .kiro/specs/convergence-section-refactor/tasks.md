# Tasks: Convergence Section Refactor

## Task 1: Replace §2.2 content with refactored structure

- [x] 1.1 Replace the entire `== Convergence of Measurable Functions` section (from the `==` heading up to but not including `== Measurable Functions and Continuous Functions`) with the new reorganized content following the design document structure.

  **Subtasks:**
  - Replace the three-mode definition block with a single a.e. convergence definition at the top
  - Create `=== Convergence in Measure // 依测度收敛` subsection with: μ-convergence definition (moved from top block), Cauchy sequence definition, completeness theorem, Riesz's theorem (fix spelling from "Rieze" to "Riesz"), filled typewriter sequence example, L^p definition, Markov's inequality, L^1⟹μ proposition
  - Create `=== Almost Uniform Convergence // 近一致收敛` subsection with: a.u. convergence definition (moved from top block), corrected Egorov's theorem (a.e. ⟹ a.u.), a.u. ⟹ a.e. proposition, a.u. ⟹ μ proposition, implication summary note
  - Remove old subsection headings (`=== a.e. and $mu$`, `=== $mu$ and a.u.`, `=== a.e. and a.u.`, `=== Norm Convergence`)

## Task 2: Verify compilation

- [x] 2.1 Run `typst compile` on the entry point to verify the refactored file compiles without errors.
