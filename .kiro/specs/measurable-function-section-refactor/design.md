# Design Document: Measurable Function Section Refactor

## Overview

This design describes the reorganization of content within the file `1.Analyse/Analyse Réelle/chapters/LebesgueMeasure.typ`. The refactoring improves logical flow in §2.1 (Definition and Properties of Measurable Functions) by:

1. Relocating the "Almost Everywhere" definition to the Measure Space subsection where it conceptually belongs
2. Renaming the "Measurable Functions Series" subsection to use precise mathematical terminology
3. Reordering the algebraic operations proposition to follow equivalent characterizations directly
4. Correcting the Simple Function note to accurately describe the general vs. measurable distinction
5. Adding a clarifying proposition about Borel vs. Lebesgue measurable functions

No new files are created. Section 2.2 (Convergence) and all subsequent sections remain untouched.

## Architecture

This is a single-file content reorganization. The architecture is the existing document structure:

```
LebesgueMeasure.typ
├── = Lebesgue Measure
│   ├── == σ-Algebra and Measure
│   ├── == Lebesgue Measure
│   │   ├── === Lebesgue Measure (definitions)
│   │   ├── === Measure Space          ← receives "Almost Everywhere" definition
│   │   └── ...
│   └── ...
├── = Measurable Function
│   ├── == Definition and Properties   ← main refactoring target
│   │   ├── === Measurable Function
│   │   ├── === Simple Function
│   │   └── === Sequences of Measurable Functions (renamed)
│   ├── == Convergence                 ← UNCHANGED
│   └── == Measurable Functions and Continuous Functions ← UNCHANGED
```

## Components and Interfaces

Since this is a content reorganization within a single `.typ` file, there are no software components or interfaces. The "components" are logical document sections.

### Operation 1: Move "Almost Everywhere" Definition

**Source location (to be removed from):**
- In `=== Measurable Function` subsection of §2.1, after the `#proposition(name: "Equivalent Characterizations of Measurable Functions")` block
- Includes the `#definition(name: "Almost Everywhere")` block and the following example list (from "For example," through the two bullet points)

**Target location (to be inserted at):**
- In `=== Measure Space` subsection, after the `#definition(name: "Lebesgue Measure Space")` block and its `\` + `#v(0.5em)` spacing
- Before the paragraph starting "Finally, we present a commonly used lemma..."

**Exact content to move (preserved verbatim):**
```typst
#definition(name: "Almost Everywhere")[
    Let $(X, cal(S), mu)$ be a measure space. A property $P(x)$ is said to hold *almost everywhere* (a.e.) if the set of points where $P$ fails to hold has measure zero, i.e., $mu({x in X : not P(x)}) = 0$, denoted by $P(x) a.e.$.
]
For example, 
- *Almost everywhere continuous*: $f$ is almost everywhere continuous if $f$ is continuous at every point of $X$ except for a set of measure zero.
- *Almost everywhere equality*: $f$ is almost everywhere equal to $g$ if $f(x) = g(x)$ for almost every $x in X$.
```

### Operation 2: Rename Subsection Heading

**Change:**
```typst
// Before:
=== Measurable Functions Series // 可测函数列

// After:
=== Sequences of Measurable Functions // 可测函数列
```

### Operation 3: Move Algebraic Operations Proposition

**Source location (to be removed from):**
- Currently the last block in §2.1, after the `#corollary` about simple function approximation characterization

**Target location (to be inserted at):**
- Immediately after the `#proposition(name: "Equivalent Characterizations of Measurable Functions")` block (which will no longer be followed by the "Almost Everywhere" definition after Operation 1)
- Before the `=== Simple Function` subsection heading

**Exact content to move (preserved verbatim):**
```typst
#proposition[
// 可测函数的和、差、积、商（分母不为零）也是可测函数
Let $(X, cal(S))$ be a measurable space and $f, g: X  -> overline(bb(R))$ be measurable functions. Then the functions $f + g$, $f - g$, $f g$, and $f / g$ (where defined) are also measurable functions.
]
```

### Operation 4: Fix Simple Function Note

**Current content (to be replaced):**
```typst
#note[
// 在测度论中，我们更关心可测简单函数。如果上述定义中的每个集合 EiE_iEi​ 都属于 σ\sigmaσ-代数 F\mathcal{F}F（即都是可测集），那么 s(x)s(x)s(x) 就称为​F\mathcal{F}F-可测简单函数。
In measure theory, we are more interested in measurable simple functions. If each set $A_k$ in the above definition belongs to the $sigma$-algebra $cal(S)$ (i.e., is a measurable set), then $s(x)$ is called a *$cal(S)$-measurable simple function*.

// 以后我们说简单函数时, 默认都是可测简单函数.
From now on, when we say simple functions, we will assume they are measurable simple functions by default.
]
```

**New content (replacement):**
```typst
#note[
// 一般的简单函数只要求取有限个不同值，并将定义域划分为有限个不相交集合，但不要求这些集合可测。
A general simple function only requires taking finitely many distinct values and partitioning the domain into finitely many disjoint sets, without requiring those sets to be measurable.

// 上面的定义使用的是更强的版本：要求 A_k ∈ cal(S)，即每个集合都是可测集，因此定义的是可测简单函数。
The definition given above uses the stronger version where $A_k in cal(S)$ (i.e., each partition set is measurable), so it defines a *measurable simple function* by default.

// 以后我们说简单函数时，默认都是指可测简单函数。
From now on, "simple function" refers to the measurable version unless stated otherwise.
]
```

### Operation 5: Add Borel vs. Lebesgue Measurable Function Proposition

**Insertion location:**
- After the paragraph "Specially, if $Y = overline(bb(R))$..." about real measurable functions
- Before the paragraph "Now we present some equivalent characterizations..."

**New content to insert:**
```typst
#proposition(name: "Borel and Lebesgue Measurable Functions")[
// 当定义域配备不同的 σ-代数时，可测函数有不同的名称。
Let $f: bb(R)^n -> overline(bb(R))$ be a function.
- If $f$ is $cal(B)(bb(R)^n)"-"cal(B)(overline(bb(R)))$ measurable (i.e., the domain is equipped with the Borel $sigma$-algebra), then $f$ is called a *Borel measurable function*.
- If $f$ is $cal(L)(bb(R)^n)"-"cal(B)(overline(bb(R)))$ measurable (i.e., the domain is equipped with the Lebesgue $sigma$-algebra), then $f$ is called a *Lebesgue measurable function*.

// 由于 Borel σ-代数包含于 Lebesgue σ-代数，每个 Borel 可测函数都是 Lebesgue 可测的，但反之不然。
Since $cal(B)(bb(R)^n) subset cal(L)(bb(R)^n)$, every Borel measurable function is Lebesgue measurable, but the converse does not hold in general.
]
```

## Data Models

Not applicable. This is a document content reorganization with no data structures or persistence.

## Error Handling

Not applicable. This is a static document edit. The only "error" scenario is a Typst compilation failure after editing, which is handled by verifying the file compiles after all changes are applied.

## Testing Strategy

**Why Property-Based Testing does not apply:**
This refactoring is a content reorganization task — moving text blocks, renaming a heading, and editing a note within a single Typst document. There are no functions, no input/output behavior, no algorithms, and no data transformations. PBT requires universally quantified properties over varying inputs, which is not meaningful for static document edits.

**Verification approach:**
1. **Compilation check**: Run `typst compile` on the entrypoint file to verify the document still compiles without errors after all changes.
2. **Manual review**: Visually inspect the generated PDF to confirm:
   - The "Almost Everywhere" definition appears in the Measure Space subsection
   - The subsection is renamed correctly
   - The algebraic operations proposition follows equivalent characterizations
   - The Simple Function note reads correctly
   - The new Borel/Lebesgue proposition is present and well-formatted
   - Section 2.2 and beyond are unchanged
3. **Diff review**: Use `git diff` to confirm only §2.1 and the Measure Space subsection are modified, and that §2.2 onward has zero changes.
