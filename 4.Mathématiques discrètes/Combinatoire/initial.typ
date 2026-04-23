#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Combinatoire",
  author: "CatMono",
  date: datetime.today(),
)

#show: apply-style

#make-cover(
  "Combinatoire",
  "CatMono",
  subtitle: "A notebook for combinatorics",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.1.0",
  extra-info: "Migrated from LaTeX to Typst (single-file mode).",
)


#make-outline(depth: 2, title: "Contents")

#part("Basic Counting")

= Basic Counting Principles

== Addition and Multiplication Principles

== Bijection Principle

== Permutations and Combinations

#definition(name: "Permutation and Combination")[
  Let $n$ be a non-negative integer, and $k$ be an integer such that $0 <= k <= n$.
  The number of ways to choose $k$ elements from a set of $n$ distinct elements
  and arrange them in a specific order is called the number of permutations of $n$
  elements taken $k$ at a time, denoted as $P(n, k)$ (also written as $""_n P_k$, $P_n^k$, or $A_n^k$).
  It is given by
  $
    P(n, k) = n! / (n-k)!.
  $

  The number of ways to choose $k$ elements from a set of $n$ distinct elements
  without regard to order is called the number of combinations of $n$ elements taken
  $k$ at a time, denoted as $C(n, k)$ (also written as $""_n C_k$, $C_n^k$, or $binom(n, k)$).
  It is given by
  $
    C(n, k) = n! / (k!(n-k)!) = binom(n, k).
  $
] <def:perm_comb>

#property[
  The following properties hold for permutations and combinations:

  1. $A_n^0 = 1$ and $A_n^n = n!$.
  2. $C_n^0 = 1$ and $C_n^n = 1$.
  3. $C_n^k = C_n^(n-k)$.
  4. $A_n^k = k! C_n^k$.
  5. $C_n^k = C_(n-1)^(k-1) + C_(n-1)^k$ (*Pascal triangle/YangHui triangle*)#footnote[
    This property can also be understood that to choose $k$ elements from $n + 1$, you can first take one element A:
    + The number of ways that include A is $C_(n)^(k-1)$;
    + The number of ways that does not include A is $C_(n)^(k)$.
  ].

  In Pascal triangle, each element is equal to the sum of the two elements directly above it.

  #figure(
    image("img/pascal_triangle.png", width: 80%),
    caption: [Pascal triangle (YangHui triangle).],
    placement: auto,
    supplement: [Fig.]
  ) <fig:pascal_triangle>

  6. $(a+b)^n = sum_(k=0)^n C_n^k a^k b^(n-k)$ (*Binomial theorem*).

  Therefore, we can see the relationship between Pascal triangle and the Binomial theorem,
  as shown in @fig:pascal_and_binomial. Here, $C_n^k$ is the element in the $n$-th row and $k$-th column of Pascal's triangle.

  #figure(
    image("img/pascal_and_binomial.png", width: 80%),
    caption: [Pascal triangle and Binomial theorem.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:pascal_and_binomial>
]

#note[
  Quick link to the core definition:
  *#link(<def:perm_comb>)[Permutation and Combination]*.
]

= Binomial Coefficients

#note[
  This chapter currently contains only a title in the LaTeX source.
]

#part("Advanced Counting")

= Recurrence Relations and Generating Functions

== Recurrence Relations

*Recurrence relations* are equations that define sequences recursively,
expressing each term as a function of preceding terms, in the form
$
  a_n = f(a_(n-1), a_(n-2), dots, a_(n-k)), quad n >= k,
$
where $k$ is the order of the recurrence relation.

Common categories:

- *Homogeneous vs. non-homogeneous*:
  A recurrence is homogeneous if it is expressed solely in terms of previous terms;
  otherwise it is non-homogeneous.
- *Linear vs. non-linear*:
  A recurrence is linear if each term is a linear combination of previous terms, e.g.
  $
    a_n = c_1 a_(n-1) + c_2 a_(n-2) + dots + c_k a_(n-k)
  $.
- *Constant coefficients vs. variable coefficients*:
  If coefficients are constants, it has constant coefficients; otherwise variable coefficients.

=== Methods for Solving Recurrence Relations

=== Common Recurrence Relations

#example[
  Define the Fibonacci sequence $(F_n)$ by
  $
    F_0 = 0, quad F_1 = 1, quad F_n = F_(n-1) + F_(n-2), quad n >= 2.
  $
  This is a linear homogeneous recurrence relation with constant coefficients.
]

#example[
  The Tower of Hanoi problem (see @fig:hanoi) is a classic example solved by recurrence.
  Move $n$ plates from A to C, using B as an auxiliary,
  with the condition that only one plate can be moved at a time
  and a larger plate cannot be placed on a smaller one.

  Let $T(n)$ be the minimum number of moves to transfer $n$ disks.
  Then
  $
    T(n) = 2T(n-1) + 1, quad T(1) = 1.
  $

  Here $T(n)$ represents the minimum number of moves required to transfer
  $n$ disks from one peg to another.

  #figure(
    image("img/Hanoi.png", width: 80%),
    caption: [Tower of Hanoi problem.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:hanoi>
]

== Generating Functions

#definition(name: "Generating Functions")[
  The *ordinary generating function* (OGF) of a sequence $(a_n)$ is
  $
    G(a_n; x) = sum_(n=0)^infinity a_n x^n,
  $
  where $x$ is an indeterminate.

  The *exponential generating function* (EGF) is
  $
    E(a_n; x) = sum_(n=0)^infinity (a_n / n!) x^n.
  $

  The *Dirichlet generating function* (DGF) is
  $
    D(a_n; s) = sum_(n=1)^infinity a_n / n^s,
  $
  where $s$ is a complex variable.
]

=== Solving Recurrence Relations Using Generating Functions

=== Integer Partitions

= Inclusion-Exclusion Principle

== Inclusion-Exclusion Principle

#theorem(name: "Inclusion-Exclusion Principle")[
  Let $A_1, A_2, dots, A_n$ be finite sets. Then
  $
    abs(union.big_(i=1)^n A_i)
    = sum_(i=1)^n abs(A_i)
    - sum_(1 <= i < j <= n) abs(A_i inter A_j)
    + sum_(1 <= i < j < k <= n) abs(A_i inter A_j inter A_k)
    - dots + (-1)^(n+1) abs(A_1 inter A_2 inter dots inter A_n).
  $

  Denote
  $
    S_k = sum_(1 <= i_1 < i_2 < dots < i_k <= n)
      abs(A_(i_1) inter A_(i_2) inter dots inter A_(i_k)),
    quad k = 1, 2, dots, n.
  $
  Then
  $
    abs(union.big_(i=1)^n A_i) = sum_(k=1)^n (-1)^(k+1) S_k.
  $
]

#note[
  Mnemonic: add odd, subtract even.
]

Special cases:

$
  abs(A_1 union A_2) = abs(A_1) + abs(A_2) - abs(A_1 inter A_2).
$

$
  abs(A_1 union A_2 union A_3)
  = abs(A_1) + abs(A_2) + abs(A_3)
  - abs(A_1 inter A_2) - abs(A_1 inter A_3) - abs(A_2 inter A_3)
  + abs(A_1 inter A_2 inter A_3).
$

#v(0.7cm)

The complement form (property counting method):
let $U$ be the universal set and $overline(A_i) = U backslash A_i$.
Then
$
  abs(union.big_(i=1)^n A_i)
  = abs(U) - abs(inter.big_(i=1)^n overline(A_i))
  = abs(U) - sum_(k=0)^n (-1)^k S_k.
$

== Mobius Inversion

The inclusion-exclusion principle is deeply connected to partially ordered structures.
Mobius inversion generalizes this viewpoint to arithmetic functions and posets.

#definition(name: "Arithmetic Function")[
  An *arithmetic function* is a function on positive integers with complex values:
  $
    f: NN^* -> CC.
  $
  Examples include the divisor function $d(n)$, Euler totient function $phi(n)$,
  and Mobius function $mu(n)$.
]

#definition(name: "Mobius Function")[
  The Mobius function $mu(n)$ is defined by
  $
    mu(n) = cases(
      1 & "if " n = 1,
      (-1)^k & "if " n " is a product of " k " distinct primes,",
      0 & "if " n " has a squared prime factor."
    ).
  $
]

#theorem(name: "Mobius Inversion")[
  Let $f$ and $g$ be arithmetic functions.
  If for every positive integer $n$,
  $
    g(n) = sum_(d | n) f(d),
  $
  then
  $
    f(n) = sum_(d | n) mu(d) g(n / d).
  $
]

== Generalizations of Inclusion-Exclusion

= Special Counting Sequences

== Catalan Numbers

#definition(name: "Catalan Numbers")[
  The $n$-th Catalan number is
  $
    C_n = 1/(n+1) binom(2n, n) = (2n)!/((n+1)!n!) = binom(2n, n) - binom(2n, n+1).
  $

  First ten values:
  $
    C_0 = 1, C_1 = 1, C_2 = 2, C_3 = 5, C_4 = 14,
    C_5 = 42, C_6 = 132, C_7 = 429, C_8 = 1430, C_9 = 4862.
  $
]

#property[
  Catalan numbers satisfy multiple recurrences:

  1.
     $
       C_n = sum_(i=0)^(n-1) C_i C_(n-1-i), quad (n >= 1), quad C_0 = 1.
     $
     This recurrence relation reflects the self-similarity of Catalan numbers.

  2.
     $
       C_n = (2(2n-1)/(n+1)) C_(n-1), quad (n >= 1), quad C_0 = 1.
     $
     This recurrence relation can be derived from the closed-form expression of Catalan numbers.

  3. Let $G(x) = sum_(n=0)^infinity C_n x^n$ be the generating function of Catalan numbers.
     Then $G(x)$ satisfies the functional equation:
     $
       G(x) = 1 + x G(x)^2,
     $
     id est,
     $
       G(x) = (1 - sqrt(1-4x))/(2x).
     $
     This functional equation can be used to derive the closed-form expression of Catalan numbers
     using the Lagrange inversion formula.
]

#v(0.7cm)

Catalan numbers is the answer to many combinatorial problems:

- *Ballot problem*: There is an $n times n$ grid graph, with the bottom-left corner at $(0, 0)$
  and the top-right corner at $(n, n)$. Starting from the bottom-left corner, and
  *moving only right or up one unit at each step*, the total number of paths to reach
  the top-right corner without going above the diagonal $y=x$ (but allowing touching it)
  is denoted as $C_n$.
- *Dyck path counting problem*: A Dyck path of semilength $n$ is a lattice path from
  $(0, 0)$ to $(2n, 0)$ that never dips below the $x$-axis and consists of steps $(1, 1)$
  (up step) and $(1, -1)$ (down step). The number of Dyck paths of semilength $n$ is $C_n$.
- *Counting non-intersecting chords in a circle*: There are $2n$ points on a circle.
  The number of ways to pair these points with $n$ chords such that no two chords intersect
  is the Catalan number $C_n$.
- *Triangulation counting problem*: The number of ways to divide a convex $(n+2)$-sided region
  into triangular regions without intersecting diagonals is $C_n$.
- *Binary tree counting problem*: The number of structurally different binary trees with $n$
  nodes is $C_n$. Equivalently, the number of structurally different full binary trees
  with $n$ non-leaf nodes is $C_n$.
- *Counting problem of parenthesis sequences*: The number of valid parenthesis sequences
  consisting of $n$ pairs of parentheses is $C_n$.
- *Stack popping sequence counting problem*: The push sequence of a stack (of infinite size)
  is $1, 2, dots, n$, and the number of valid popping sequences is $C_n$.
- *Sequence counting problem*: The number of sequences $a_1, a_2, dots, a_(2n)$ consisting of
  $n$ $+1$'s and $n$ $-1$'s such that the partial sums satisfy
  $a_1 + a_2 + dots + a_k >= 0$ ($k = 1, 2, 3, dots, 2n$) is $C_n$.

== Stirling Numbers

== Bell Numbers

== Schroder Numbers

#part("Existence and Extremal")

= Pigeonhole Principle

#note[
  This chapter currently contains only a title in the LaTeX source.
]

= Extremal Principle

#note[
  This chapter currently contains only a title in the LaTeX source.
]

= Ramsey Theory

#note[
  This chapter currently contains only a title in the LaTeX source.
]

#part("Structure and Algebra")

= Design Theory

#note[
  This chapter currently contains only a title in the LaTeX source.
]

= Polya Counting

#note[
  This chapter currently contains only a title in the LaTeX source.
]


#bibliography("references.bib")
