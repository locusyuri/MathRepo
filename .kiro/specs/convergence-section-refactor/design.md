# Design Document: Convergence Section Refactor

## Overview

This design describes the structural reorganization of §2.2 "Convergence of Measurable Functions" in `LebesgueMeasure.typ`. The refactoring replaces the current flat subsection layout with a two-subsection hierarchy, fixes the incorrect Egorov's theorem, fills in the typewriter sequence example, and adds an implication summary.

## Current Structure (Before)

```
== Convergence of Measurable Functions
  #definition (three-mode: a.e., μ, a.u.)
  === a.e. and μ
    Riesz's Theorem
    Cauchy Sequence in Measure (definition)
    Completeness Theorem
  === μ and a.u.
    #example (empty — typewriter sequence)
    Egorov's Theorem (INCORRECT: μ ⟺ a.u.)
  === a.e. and a.u. (empty)
  === Norm Convergence
    L^p definition
    Markov's inequality
    L^1 ⟹ μ proposition
```

## Target Structure (After)

```
== Convergence of Measurable Functions
  #definition (a.e. convergence ONLY)
  Transition text

  === Convergence in Measure // 依测度收敛
    #definition: Convergence in Measure (moved from former combined block)
    Cauchy Sequence in Measure (definition)
    Completeness Theorem
    --- Relationship with a.e. convergence ---
    Riesz's Theorem (subsequence characterization)
    #example: Typewriter Sequence (FILLED IN)
    --- Norm Convergence ---
    L^p norm convergence definition
    Markov's Inequality
    L^1 ⟹ μ proposition

  === Almost Uniform Convergence // 近一致收敛
    #definition: Almost Uniform Convergence (moved from former combined block)
    Egorov's Theorem (CORRECTED: a.e. ⟹ a.u. on finite measure spaces)
    Proposition: a.u. ⟹ a.e.
    Proposition: a.u. ⟹ μ
    #note: Implication Summary Diagram
```

## Detailed Design

### 1. Section Top (Lines ~285–298 equivalent)

Replace the existing three-mode `#definition(name: "Convergence of Measurable Functions")` block with a definition containing only the almost everywhere convergence definition. The convergence in measure and almost uniform convergence definitions will be moved to their respective subsections.

### 2. Subsection: Convergence in Measure

**Order of content:**

1. **Convergence in measure definition** — Move the μ-convergence definition from the former combined block into a new `#definition(name: "Convergence in Measure")` here.
2. **Cauchy sequence in measure** — Move the existing `#definition(name: "Cauchy Sequence in Measure")` here.
3. **Completeness theorem** — Move the existing unnamed `#theorem` (Cauchy ⟹ limit exists) here.
4. **Transition text** — "We now examine the relationship between convergence in measure and almost everywhere convergence."
5. **Riesz's Theorem** — Move existing theorem here. Fix the spelling to "Riesz's Theorem".
6. **Typewriter sequence example** — Replace the empty `#example` with a complete construction.
7. **Norm convergence transition** — "We now introduce a stronger mode of convergence that implies convergence in measure."
8. **$L^p$ norm convergence definition** — Move existing `#definition(name: "Norm Convergence")`.
9. **Markov's Inequality** — Move existing `#theorem(name: "Markov's Inequality")`.
10. **$L^1 => mu$ proposition** — Move existing `#proposition` (two items: $L^1 => mu$ and integral interchange).

### 3. Subsection: Almost Uniform Convergence

**Order of content:**

1. **Almost uniform convergence definition** — Move the a.u. convergence definition from the former combined block into a new `#definition(name: "Almost Uniform Convergence")` here.
2. **Egorov's Theorem (corrected)** — State correctly:
   - Hypothesis: $f_n xarrow("a.e.") f$ on a finite measure space.
   - Conclusion: $f_n xarrow("a.u.") f$.
   - This is a one-directional implication, NOT a biconditional.
3. **Proposition: a.u. ⟹ a.e.** — Trivial direction: if $f_n -> f$ uniformly outside a set of arbitrarily small measure, then $f_n -> f$ a.e.
4. **Proposition: a.u. ⟹ μ** — Almost uniform convergence implies convergence in measure.
5. **Implication Summary** — A `#note` block with a text-based diagram:
   ```
   L^p ⟹ μ (Markov's inequality)
   a.e. ⟹ a.u. (Egorov, finite measure)
   a.u. ⟹ a.e.
   a.u. ⟹ μ
   μ ⟹ a.e. subsequence (Riesz)
   μ ⟹̸ a.e. (typewriter sequence)
   ```

### 4. Typewriter Sequence Construction

The standard "typewriter sequence" (also called "sliding bump") on $[0,1]$:

Define intervals by cycling through $[0,1]$ with decreasing widths:
- $n = 1$: $[0, 1]$ (width 1)
- $n = 2, 3$: $[0, 1/2], [1/2, 1]$ (width 1/2)
- $n = 4, 5, 6$: $[0, 1/3], [1/3, 2/3], [2/3, 1]$ (width 1/3)
- In general, for the $k$-th "round", we have $k$ intervals of width $1/k$.

Let $f_n = chi_(I_n)$ where $I_n$ is the $n$-th interval in this enumeration.

- **μ-convergence**: For any $epsilon > 0$, eventually the intervals have width $< epsilon$, so $mu({f_n > epsilon}) <= 1/k -> 0$.
- **No a.e. convergence**: For every $x in [0,1]$, $x$ belongs to infinitely many $I_n$ (since each round covers all of $[0,1]$), so $f_n(x) = 1$ infinitely often and $f_n(x) = 0$ infinitely often. Thus $lim f_n(x)$ does not exist for any $x$.

### 5. Egorov's Theorem Correction

**Current (incorrect):**
> $f_n xarrow(mu) f$ if and only if $f_n xarrow("a.u.") f$

**Corrected:**
> If $f_n xarrow("a.e.") f$ on a finite measure space, then $f_n xarrow("a.u.") f$.

The converse (a.u. ⟹ a.e.) is a separate, simpler proposition.

### 6. Files Modified

Only one file is modified: `1.Analyse/Analyse Réelle/chapters/LebesgueMeasure.typ`

The modification scope is from the `== Convergence of Measurable Functions` heading (line ~285) to the `== Measurable Functions and Continuous Functions` heading (exclusive).

## Non-Goals

- No changes to content outside §2.2.
- No changes to the file header (imports).
- No new files created.
- No changes to the template or other chapters.
