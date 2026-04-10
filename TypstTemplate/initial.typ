// ==========================================================================
// MATH NOTES TEMPLATE - COMPLETE ENGLISH SHOWCASE
// ==========================================================================

#import "math-notes.typ": *

#set document(
  title: "Math Notes Template Showcase",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Math Notes Template Showcase",
  "Violet",
  subtitle: "A Complete Demo of Structure, Components, and Writing Utilities",
  institute: "Notiz  Mathematiques",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This document demonstrates major and minor components, notes, tables, highlights, footnotes, and bibliography usage.",
)

#make-outline(depth: 3, title: "Contents")


#part("Quick Start")

= Quick Start

== Minimal Setup

A minimal working setup looks like this:

```typ
#import "math-notes.typ": *
#show: apply-style

#make-cover("Document Title", "Author")
#make-outline()

= First Chapter
Your text starts here.
```

== Inline Utilities

You can use #highlight[inline highlight] for key phrases.
You can also add a short note#footnote[Footnotes are useful for side remarks and references.] directly in a sentence.

== Structure Preview

This template currently supports:

- Cover page and metadata area
- Styled outline page
- Part and chapter structure
- Theorem-like major components
- Proof / solution / exercise blocks
- Note and caution callouts
- Table helpers


#part("Core Components")

= Major Components

== Theorem Family

#theorem(name: "Extreme Value Theorem")[
  Let $f$ be continuous on a closed interval $[a, b]$.

  Then $f$ attains a minimum and a maximum on $[a, b]$.

  In particular, there exist $x_m, x_M in [a, b]$ such that
  $f(x_m) <= f(x) <= f(x_M)$ for all $x in [a, b]$.
]

#corollary[
  Every polynomial of odd degree has at least one real root.
]

#lemma[
  If $a_n -> 0$ and $(b_n)$ is bounded, then $a_n b_n -> 0$.
]

== Definitions and Properties

#definition(name: "Monotone Sequence")[
  A sequence $(a_n)$ is monotone increasing if $a_n <= a_{n+1}$ for all $n$.
]

#proposition[
  Every bounded monotone sequence converges.
]

#property[
  If $f$ and $g$ are even functions, then $f + g$ is even.
]

== Axiomatic Blocks

#axiom[
  The empty set is a subset of every set.
]

#postulate[
  Through a point not on a line, there is exactly one parallel line in Euclidean geometry.
]

#example[
  The function $f(x) = x^2$ is convex on $bb(R)$ because $f''(x) = 2 > 0$.
]


= Minor Components

== Proof and Solution

#proof(name: "for the Mean Value Theorem")[
  Define
  $g(x) = f(x) - frac(f(b)-f(a), b-a) (x-a)$.

  Since $g(a) = g(b)$, Rolle's theorem yields some $c in (a,b)$ with $g'(c) = 0$.

  Therefore $f'(c) = frac(f(b)-f(a), b-a)$.
]

#solution(name: "quadratic minimization")[
  Complete the square:
  $x^2 - 4x + 7 = (x-2)^2 + 3$.

  The minimum value is $3$, attained at $x=2$.
]

== Exercise

#exercise(name: "Warm-up")[
  Show that if $a_n -> 0$ and $(b_n)$ is bounded, then $a_n b_n -> 0$.

  Hint: start from $|a_n b_n| <= M|a_n|$.
]

== Note and Caution

#note[
  Use this block for commentary, migration notes, and reminders.
]

#caution(title: "Caution")[
  Before dividing by an expression, ensure it is non-zero.
]

#note(
  title: "Custom Palette",
  icon: [\*],
  bg: rgb("#EEF7FF"),
  border: rgb("#9CC6EB"),
  accent: rgb("#2F6EA5"),
)[
  The note component supports custom color overrides for topic-specific emphasis.
]


#part("Writing Utilities")

= Tables and Formatting

== Theme Table

#tex-table(
  ("Topic", "Level", "Status"),
  ("Real Analysis", "Intermediate", "Reviewed"),
  ("Linear Algebra", "Beginner", "Draft"),
  ("Topology", "Advanced", "Planned"),
)

== Plain Table

#plain-table(
  ("Symbol", "Meaning", "Example"),
  ("$forall$", "for all", $forall x in A$) ,
  ("$exists$", "there exists", $exists n in NN$) ,
  ("$->$", "converges to", 	$a_n -> 0$) ,
)

== Lists

1. Draft chapter notes.
2. Convert rough arguments into formal proofs.
3. Add examples and edge cases.
4. Add citations and references.
	1. Use footnotes for side remarks and references.
	2. Use bibliography for full references.

- Keep arguments short.
- Keep notation consistent.
	- Use highlights sparingly.

= Citations, Footnotes, and References

The style of mathematical writing is strongly influenced by classic references @knuth1984 and @rudin1976.

When you introduce notation, add a short context note#footnote[For example: define the domain, assumptions, and whether objects are fixed globally.].

For implementation-level typography and compositional structure in this project, compare the ideas with @lamport1994.

#bibliography("references.bib")
