#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Topologie Algébrique",
  author: "CatMono",
  date: datetime.today(),
)

#show: apply-style

#let ref1 = "ref1"

#make-cover(
  "Topologie Algébrique",
  "CatMono",
  subtitle: "A notebook for algebraic topology",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.1.0",
  extra-info: "Migrated from LaTeX to Typst.",
)

#make-outline(depth: 2, title: "Contents")

#part("Homotopy Theory")
= Fundamental Group

#definition(name: "Simply Connected Space")[
  Let $X$ be a topological space.
  We say $X$ is *simply connected* if it is

  1. path-connected, and
  2. every loop in $X$ can be continuously contracted to a point, i.e.,
     for any loop $gamma: S^1 -> X$, there exists a homotopy
     $H: S^1 times [0, 1] -> X$ such that
     $H(s, 0) = gamma(s)$ for all $s in S^1$ and
     $H(s, 1) = x_0$ for some fixed point $x_0 in X$.

  Equivalently, $X$ is simply connected if its fundamental group
  $pi_1(X, x_0)$ is trivial for some (and hence any) base point $x_0 in X$.
  $pi_1(X, x_0) = 0$ is also a common way to express that the fundamental group is trivial.
]<def:simply_connected_space>

In complex analysis, simply connected spaces (as subsets of $bb(C)$) are often characterized by the property that
*any simple closed curve in the space has its interior completely contained within the space*.
This is an important property of simply connected spaces.

= Plane Separation Theorem


#definition(name: "Jordan Curve and Simple Closed Curve")[
  Let $X$ be a topological space.
  If there exists a continuous injective mapping $gamma: [0, 1] -> X$,
  then the image $gamma([0, 1])$ is called a *Jordan curve* or *simple curve* in $X$.

  If $gamma(0) = gamma(1)$, then $gamma([0, 1])$ is called a *simple closed curve* in $X$.

  Another definition is that a simple closed curve is a space homeomorphic to the unit circle $S^1$.
]<def:jordan_curve>


= Homotopy Topics

#note[
  Placeholder chapter migrated from empty LaTeX source file chap03.tex.
]

#part("Homology Theory")

#part("Cohomology Theory")
#note[
  This part is currently a placeholder and will be expanded in later migration steps.
]

#part("Appendix")
= Glossary

== J
- *#link(<def:jordan_curve>)[Jordan Curve and Simple Closed Curve]*

== S
- *#link(<def:jordan_curve>)[Jordan Curve and Simple Closed Curve]*
- *#link(<def:simply_connected_space>)[Simply Connected Space]*

// #bibliography("references.bib")
