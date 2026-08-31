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

#definition(name: "Addition Principle")[
  Suppose the objects to be counted can be *classified* into pairwise disjoint
  classes $E_1, E_2, dots, E_k$ containing $m_1, m_2, dots, m_k$ objects
  respectively. Then the total number of objects is
  $
    m_1 + m_2 + dots + m_k.
  $
] <def:addition-principle>

#definition(name: "Multiplication Principle")[
  Suppose a procedure consists of $k$ successive steps, where the $i$-th step
  can be performed in $m_i$ ways *regardless of the choices made in the previous
  steps*. Then the whole procedure can be performed in
  $
    m_1 times m_2 times dots times m_k
  $
  ways.
] <def:multiplication-principle>

#example[
  How many four-digit integers with pairwise distinct digits end with $0$ or $5$?

  - *Ending with $0$*: the leading three digits form an ordered selection of
    distinct digits from the remaining nine digits, giving $9 times 8 times 7 = 504$
    ways by #link(<def:multiplication-principle>)[the multiplication principle];
  - *Ending with $5$*: the first digit can be neither $0$ nor $5$, giving
    $8 times 8 times 7 = 448$ ways.

  The two classes are disjoint, so by #link(<def:addition-principle>)[the
    addition principle] the answer is $504 + 448 = 952$.
] <ex:digit-counting>

#note[
  The addition principle applies to *classification* (disjoint cases), while the
  multiplication principle applies to *successive steps*. Distinguishing these
  two situations is the first skill in solving counting problems.
]

== Bijection Principle

#definition(name: "Bijection Principle")[
  If there is a bijection between two finite sets, then they contain the same
  number of elements. Consequently, to count a set $S$ one may instead count any
  set $T$ in bijection with $S$.
] <def:bijection-principle>

The word *bijection* is understood in the sense of set theory (developed in the
Théorie des Ensembles note); here we only exploit its counting consequence. The
art lies in finding a "mirror" set whose elements are easier to enumerate.

#example[
  Every subset $S subset.eq {1, 2, dots, n}$ corresponds to its characteristic
  vector $(x_1, x_2, dots, x_n) in {0, 1}^n$, where $x_i = 1$ precisely when
  $i in S$. The correspondence is a bijection, so an $n$-element set has
  exactly $2^n$ subsets.
] <ex:subsets-bijection>

#example[
  For $0 <= k <= n$, pairing each $k$-element subset of an $n$-element set with
  its complement is a bijection onto the family of $(n - k)$-element subsets.
  Hence
  $
    C_n^k = C_n^(n-k).
  $
] <ex:symmetry-bijection>

Bijection arguments of this kind are the basic tool for proving combinatorial
identities; they reappear in #link(<prop:binomial-identities>)[the basic
  identities] and #link(<thm:vandermonde>)[Vandermonde's identity].

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
  3. $A_n^k = k! C_n^k$.

  Further properties of the binomial coefficients $C_n^k$ — symmetry, the Pascal
  recurrence, and the binomial theorem — are treated in the chapter
  *Binomial Coefficients* below.
]

#note[
  Quick link to the core definition:
  *#link(<def:perm_comb>)[Permutation and Combination]*.
]

=== Permutations and Combinations of Multisets

#definition(name: "Permutations of Multisets")[
  Let $S$ be a multiset with $k$ types of objects, where type $i$ occurs with
  multiplicity $n_i$ ($i = 1, 2, dots, k$), and let $n = n_1 + dots + n_k$.
  The number of permutations of $S$, that is, sequences of its $n$ objects in
  which objects of the same type are indistinguishable, is
  $
    (n!) / (n_1! n_2! dots n_k!).
  $
] <def:multiset-permutation>

#example[
  The letters of the word MISSISSIPPI form a multiset in which the letters
  $M, I, S, P$ occur $1, 4, 4, 2$ times respectively (total $11$). Hence the
  number of distinguishable permutations is
  $
    (11!) / (1! 4! 4! 2!) = 34650.
  $
]

#theorem(name: "Combinations with Repetition")[
  The number of ways to choose $k$ objects from $n$ types, with repetition
  allowed and order ignored, is
  $
    binom(k + n - 1, k).
  $
] <thm:multiset-combination>

#proof[
  Encode a choice by the multiplicities $(x_1, dots, x_n)$ with
  $x_1 + dots + x_n = k$. Write $x_i$ stars for type $i$ and separate adjacent
  types by bars; the resulting sequence of $k$ stars and $n - 1$ bars is
  determined by the positions of the bars, a bijection with the family of
  $(n - 1)$-subsets of the $k + n - 1$ available positions. By
  #link(<def:bijection-principle>)[the bijection principle] the count equals
  $binom(k + n - 1, n - 1) = binom(k + n - 1, k)$. This device is known as
  *stars and bars*.
]

The multiset permutations and the numbers $binom(k + n - 1, k)$ are special
cases of the #link(<def:multinomial>)[multinomial coefficients].

= Binomial Coefficients

== Binomial Theorem

#theorem(name: "Binomial Theorem")[
  For every integer $n >= 0$ and all $a, b$,
  $
    (a + b)^n = sum_(k=0)^n C_n^k a^k b^(n-k).
  $
] <thm:binomial-theorem>

#proof[
  Expand $(a + b)^n$ as the product of $n$ identical factors $(a + b)$: every one
  of the $2^n$ monomials arises by picking, from each factor, either an $a$ or a
  $b$. A monomial $a^k b^(n-k)$ arises exactly when $a$ is picked from $k$ of the
  $n$ factors, which can be done in $C_n^k$ ways. Grouping the monomials by the
  exponent of $a$ — a disjoint classification — and applying
  #link(<def:addition-principle>)[the addition principle] yields the identity.
]

#note[
  Replacing $b$ by $-b$ gives
  $(a - b)^n = sum_(k=0)^n (-1)^k C_n^k a^(n-k) b^k$; in particular the
  coefficients of $(a - b)^n$ alternate in sign.
]

#note[
  An alternative proof proceeds by induction on $n$ using the Pascal recurrence
  (#link(<prop:pascal-recurrence>)[below]). The combinatorial proof above is
  preferred here, as it exhibits *why* binomial coefficients appear.
]

== Basic Combinatorial Identities

Throughout, $n$ is a non-negative integer and $0 <= k <= n$ unless stated
otherwise. The following identities are the working toolbox of elementary
combinatorics.

#property[
  The following identities hold:

  1. *Symmetry*: $C_n^k = C_n^(n-k)$; see
    #link(<ex:symmetry-bijection>)[the example above] for a bijective proof.
  2. *Absorption*: $k C_n^k = n C_(n-1)^(k-1)$ for $k >= 1$.
  3. *Row sum*: $sum_(k=0)^n C_n^k = 2^n$; this refines
    #link(<ex:subsets-bijection>)[the subset count] by classifying subsets
    according to their cardinality.
  4. *Alternating sum*: $sum_(k=0)^n (-1)^k C_n^k = 0$ for $n >= 1$; indeed,
    toggling a fixed element is a bijection between the subsets of odd and even
    cardinality.
] <prop:binomial-identities>

#property(name: "Pascal's Recurrence")[
  For $1 <= k <= n$,
  $
    C_n^k = C_(n-1)^(k-1) + C_(n-1)^k.
  $

  Combinatorial proof: to choose $k$ elements from $n + 1$ elements, fix one
  element $A$. The choices that contain $A$ number $C_n^(k-1)$, and those that
  do not contain $A$ number $C_n^k$; the two classes are disjoint, and
  #link(<def:addition-principle>)[the addition principle] applies.

  In Pascal's triangle, each element is equal to the sum of the two elements
  directly above it. Here $C_n^k$ is the element in the $n$-th row and $k$-th
  column of the triangle, and the recurrence generates the whole triangle from
  its boundary values $C_n^0 = C_n^n = 1$.

  #figure(
    image("img/pascal_triangle.png", width: 80%),
    caption: [Pascal triangle (YangHui triangle).],
    placement: auto,
    supplement: [Fig.],
  ) <fig:pascal_triangle>

  #figure(
    image("img/pascal_and_binomial.png", width: 80%),
    caption: [Pascal triangle and Binomial theorem.],
    placement: auto,
    supplement: [Fig.],
  ) <fig:pascal_and_binomial>
] <prop:pascal-recurrence>

#theorem(name: "Vandermonde's Identity")[
  For non-negative integers $m, n$ and $r$,
  $
    sum_(k=0)^r C_m^k C_n^(r-k) = C_(m+n)^r.
  $
] <thm:vandermonde>

#proof[
  *Bijective proof.* Let $M$ and $N$ be disjoint sets with $abs(M) = m$ and
  $abs(N) = n$. The right-hand side counts the $r$-element subsets of
  $M union N$. Every such subset contains exactly $k$ elements of $M$ for a
  unique $k in {0, 1, dots, r}$, and for fixed $k$ the choices are counted by
  $C_m^k C_n^(r-k)$. Summing over $k$ gives the identity.

  *Generating-function proof.* Multiply the expansions of $(1 + x)^m$ and
  $(1 + x)^n$:
  $
    (1 + x)^(m+n) = (sum_(k=0)^m C_m^k x^k)(sum_(j=0)^n C_n^j x^j).
  $
  The coefficient of $x^r$ on the left is $C_(m+n)^r$, while on the right it is
  $sum_(k=0)^r C_m^k C_n^(r-k)$; equating coefficients gives the identity. The
  generating-function method is developed systematically in the chapter on
  recurrence relations and generating functions.
]

#example[
  The absorption and row-sum identities yield, for $n >= 1$,
  $
    sum_(k=0)^n k C_n^k
    = n sum_(k=1)^n C_(n-1)^(k-1)
    = n sum_(j=0)^(n-1) C_(n-1)^j
    = n 2^(n-1).
  $

  A bijective proof counts the pairs $(A, a)$ where $A$ is a subset of an
  $n$-element set and $a in A$ an element thereof: first by the cardinality of
  $A$ (the left-hand sum), then by the marked element $a$, which can be chosen
  in $n$ ways and completed by an arbitrary subset of the remaining
  $n - 1$ elements (the right-hand side).
] <ex:identity-application>

== Multinomial Coefficients

#definition(name: "Multinomial Coefficient")[
  Let $n_1, n_2, dots, n_k$ be non-negative integers with $n = n_1 + dots + n_k$.
  The *multinomial coefficient* is
  $
    binom(n, n_1, n_2, dots, n_k) = (n!) / (n_1! n_2! dots n_k!).
  $
  It counts the permutations of a multiset with multiplicities $n_1, dots, n_k$
  (#link(<def:multiset-permutation>)[above]), and equally the ways to partition
  an $n$-element set into an ordered list of classes of sizes
  $n_1, dots, n_k$.

  For $k = 2$ it reduces to the binomial coefficient:
  $binom(n, k, n - k) = binom(n, k)$.
] <def:multinomial>

#theorem(name: "Multinomial Theorem")[
  For every integer $n >= 0$ and all $x_1, x_2, dots, x_k$,
  $
    (x_1 + x_2 + dots + x_k)^n
    = sum_(n_1 + dots + n_k = n)
    binom(n, n_1, n_2, dots, n_k) x_1^(n_1) x_2^(n_2) dots x_k^(n_k),
  $
  where the sum runs over all $k$-tuples of non-negative integers with total $n$.
] <thm:multinomial-theorem>

#proof[
  Expand the product of $n$ identical factors as in the proof of
  #link(<thm:binomial-theorem>)[the binomial theorem]: each monomial
  $x_1^(n_1) dots x_k^(n_k)$ arises once for every assignment of the $n$ factors
  to the $k$ variables in which variable $x_i$ is chosen exactly $n_i$ times.
  The assignments with prescribed exponents $(n_1, dots, n_k)$ are counted by
  the multinomial coefficient.
]

#example[
  $
    (a + b + c)^3 = a^3 + b^3 + c^3
    + 3(a^2 b + a^2 c + a b^2 + b^2 c + a c^2 + b c^2)
    + 6 a b c.
  $
  For instance, the coefficient of $a b c$ is
  $binom(3, 1, 1, 1) = (3!) / (1! 1! 1!) = 6$.
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
  $ a_n = c_1 a_(n-1) + c_2 a_(n-2) + dots + c_k a_(n-k) $.
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
    supplement: [Fig.],
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

= Inclusion-Exclusion and Sieve Methods

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

== Applications of Inclusion-Exclusion

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

// --------------------------------------------------------------------------
// Boundary note (structure design):
// - Graph theory is used informally in this part (Ramsey, extremal, matchings);
//   a systematic treatment belongs to a separate note (Theorie des Graphes, planned).
// - Group actions used by Burnside / Polya counting are developed in
//   Algèbre Abstraite; only the enumeration side is treated here.
// - Probability generating functions are developed in Probabilités.
// --------------------------------------------------------------------------

= Pigeonhole Principle

#note[
  This chapter currently contains only a title in the LaTeX source.
]

= Extremal Principle

== Double Counting

== Averaging Arguments

== Sperner's Theorem

== Erdos-Ko-Rado Theorem

== Probabilistic Method

= Systems of Distinct Representatives

== Hall's Theorem

== Matchings in Bipartite Graphs

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

== Group Actions

== Burnside's Lemma

== Polya's Enumeration Theorem


#bibliography("references.bib")
