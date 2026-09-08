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
  version: "v0.2.0",
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
    sum_(k=0)^n k C_n^k & = n sum_(k=1)^n C_(n-1)^(k-1) & = n sum_(j=0)^(n-1) C_(n-1)^j & = n 2^(n-1).
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
    (x_1 + x_2 + dots + x_k)^n & = sum_(n_1 + dots + n_k = n)
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

#definition(name: "Recurrence Relation")[
  A *recurrence relation* is an equation that defines a sequence recursively,
  expressing each term as a function of preceding terms, in the form
  $
    a_n = f(a_(n-1), a_(n-2), dots, a_(n-k)), quad n >= k,
  $
  where $k$ is the order of the recurrence relation.
] <def:recurrence>

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

*Iteration (unrolling).* The most direct device is to apply the recurrence to
itself repeatedly until a pattern emerges.

#example[
  We solve the Tower of Hanoi recurrence of @fig:hanoi,
  $
    T(n) = 2 T(n-1) + 1, quad T(1) = 1,
  $
  by iteration:
  $
    T(n) &= 2 T(n-1) + 1
    &= 2^2 T(n-2) + 2 + 1
    &= 2^3 T(n-3) + 2^2 + 2 + 1
    &= dots
    &= 2^(n-1) T(1) + (2^(n-2) + dots + 2 + 1)
    &= 2^(n-1) + (2^(n-1) - 1)
    &= 2^n - 1.
  $
  The finite geometric sum $2^(n-2) + dots + 2 + 1 = 2^(n-1) - 1$ closes the
  computation. Iteration works best for first-order recurrences; higher-order
  ones need more structure.
] <ex:hanoi-closed>

*Linear homogeneous recurrences with constant coefficients.* In normal form
(all terms moved to the left), such a recurrence reads
$
  a_n + c_1 a_(n-1) + dots + c_k a_(n-k) = 0, quad n >= k,
$
with constants $c_1, dots, c_k$ and $c_k != 0$.

#theorem(name: "Characteristic Equation Method")[
  Associate to the recurrence its *characteristic polynomial*
  $
    p(r) = r^k + c_1 r^(k-1) + dots + c_k.
  $
  If $p$ has $k$ distinct roots $r_1, dots, r_k$, then every solution is of the
  form
  $
    a_n = alpha_1 r_1^n + alpha_2 r_2^n + dots + alpha_k r_k^n,
  $
  where the constants $alpha_i$ are uniquely determined by the initial values
  $a_0, dots, a_(k-1)$. If a root $r$ has multiplicity $mu$, the part of the
  general solution contributed by $r$ is instead
  $
    (beta_0 + beta_1 n + dots + beta_(mu-1) n^(mu-1)) r^n.
  $
] <thm:characteristic>

#proof[
  Substituting $a_n = r^n$ into the recurrence gives $r^(n-k) p(r) = 0$ for all
  $n >= k$: the pure exponentials $r^n$ are solutions precisely for
  characteristic roots. By linearity, linear combinations of solutions are
  solutions; when $r$ has multiplicity $mu$, the sequences $n^j r^n$ for
  $0 <= j < mu$ are also solutions, which follows by induction on $j$ from the
  factorization $p(x) = (x - r)^mu tilde(p)(x)$.

  The solution set is a vector space of dimension $k$: a solution is uniquely
  determined by its $k$ initial values $a_0, dots, a_(k-1)$, and any initial
  values extend uniquely along the recurrence. Finally, the $k$ sequences
  displayed in the theorem are linearly independent — for distinct roots this
  is the invertibility of the Vandermonde matrix $(r_i^j)_(0 <= j, i < k)$, and
  the multiple-root families contribute independent directions. Hence they form
  a basis of the solution space, which is the claim.
]

#example[
  The Fibonacci recurrence
  $
    F_n = F_(n-1) + F_(n-2), quad F_0 = 0, quad F_1 = 1
  $
  has characteristic polynomial $p(r) = r^2 - r - 1$ with roots
  $
    phi = (1 + sqrt(5)) / 2, quad psi = (1 - sqrt(5)) / 2.
  $
  The general solution is $F_n = alpha_1 phi^n + alpha_2 psi^n$; the initial
  values give $alpha_1 + alpha_2 = 0$ and $alpha_1 phi + alpha_2 psi = 1$, so
  $alpha_1 = 1 / sqrt(5)$ and $alpha_2 = -1 / sqrt(5)$, using
  $phi - psi = sqrt(5)$. Therefore
  $
    F_n = (phi^n - psi^n) / sqrt(5),
  $
  the *Binet formula*. The irrational ingredients conspire to produce integers.
] <ex:fibonacci-closed-form>

*Linear non-homogeneous recurrences.*

#property[
  Consider a linear recurrence with constant coefficients and a non-zero
  right-hand side:
  $
    a_n + c_1 a_(n-1) + dots + c_k a_(n-k) = f(n).
  $
  Every solution is the sum of one *particular* solution of the full recurrence
  and the general solution of the associated homogeneous recurrence; in
  particular, the difference of any two solutions satisfies the homogeneous
  recurrence.
] <prop:nonhomogeneous>

#example[
  Solve $a_n = a_(n-1) + n$ with $a_0 = 0$. The homogeneous solution is the
  constant sequence $a_n = alpha$. For a particular solution, try a quadratic
  polynomial $a_n^((p)) = c n^2 + d n$; substituting and equating coefficients
  gives $c = 1 / 2$ and $d = 1 / 2$, so
  $
    a_n = alpha + (n^2 + n) / 2.
  $
  The initial value forces $alpha = 0$, and we recognize the triangular numbers
  $a_n = n (n + 1) / 2$.
]

#note[
  Trial particular solutions: if $f(n)$ is a polynomial of degree $d$, try a
  polynomial of degree $d$ — multiplied by $n^mu$ when $1$ is a characteristic
  root of multiplicity $mu$; if $f(n) = s^n q(n)$ with $q$ of degree $d$, try
  $n^mu s^n q(n)$, where $mu$ is the multiplicity of $s$ as a characteristic
  root. The multipliers $n^mu$ are exactly the resonance phenomenon of
  #link(<thm:characteristic>)[multiple roots].
]

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

A *generating function* packages an infinite sequence $(a_0, a_1, a_2, dots)$
into a single analytic object — typically a formal power series in one
variable — so that algebraic manipulations of the function correspond to
combinatorial manipulations of the sequence. Addition of two such functions
adds the sequences term-by-term; multiplication (the Cauchy product) yields
the convolution, which encodes ordered pairs of sub-objects; differentiation
shifts the index; evaluation and partial fractions extract coefficients. By
translating counting problems into algebra, generating functions turn
recurrence-driven guesswork into systematic machinery: the answer to a
counting question is read off as a coefficient, often without ever closing
the sequence in closed form.

Three flavours cover most of combinatorics and number theory, differing only
in the weighting assigned to the index.

#definition(name: "Generating Functions")[
  The *ordinary generating function* (OGF) of a sequence $(a_n)_(n>=0)$ is
  $
    G(a_n; x) = sum_(n=0)^infinity a_n x^n,
  $
  the formal power series whose coefficient of $x^n$ records $a_n$ with weight
  $1$. OGFs are the right tool for *unlabelled* structures, where objects of
  size $n$ are counted without distinguishing their elements (e.g. partitions,
  tilings, Catalan objects).

  The *exponential generating function* (EGF) is
  $
    E(a_n; x) = sum_(n=0)^infinity (a_n / n!) x^n,
  $
  where each $a_n$ is weighted by $1 \/ n!$. The division by $n!$ absorbs the
  $n!$ permutations of an $n$-element set, so EGFs are natural for
  *labelled* structures (e.g. permutations, set partitions, labelled trees);
  the product of two EGFs is the exponential formula, building an ordered pair
  of labelled sub-structures with a binomial factor accounting for splitting
  the labels.

  The *Dirichlet generating function* (DGF) is
  $
    D(a_n; s) = sum_(n=1)^infinity a_n / n^s,
  $
  where $s$ is a complex variable and the index is weighted by $1 \/ n^s$.
  DGFs are tailored to multiplicative number theory: their product encodes
  Dirichlet convolution, which is the arithmetic of divisors underlying
  #link(<thm:mobius-inversion>)[Möbius inversion] (e.g. $zeta(s)$ and
  $1 \/ zeta(s)$ for the constant sequence and the Mobius function).
] <def:generating-functions>

=== Solving Recurrence Relations Using Generating Functions

The generating function packages an entire sequence into a single object.
Its power for recurrences is this: the recurrence translates into an *algebraic
equation* for the generating function, which can be solved by ordinary algebra
and then "read back" coefficient by coefficient.

#property[
  Let $A(x) = sum_(n>=0) a_n x^n$ and $B(x) = sum_(n>=0) b_n x^n$ be ordinary
  generating functions. Then:

  - *Sum*: $A(x) + B(x) = sum_(n>=0) (a_n + b_n) x^n$;
  - *Shift*: $A(x) - a_0 - a_1 x - dots - a_(k-1) x^(k-1) = x^k sum_(n>=0) a_(n+k) x^n$;
  - *Scale and shift*: $c x^m A(x) = sum_(n>=m) c a_(n-m) x^n$;
  - *Derivative*: $A'(x) = sum_(n>=1) n a_n x^(n-1)$, and equivalently
    $x A'(x) = sum_(n>=0) n a_n x^n$;
  - *Cauchy product*:
    $A(x) B(x) = sum_(n>=0) (sum_(i=0)^n a_i b_(n-i)) x^n$.
] <prop:gf-operations>

The shift rule is the engine for recurrences: multiplying $A(x)$ by $x$ shifts
every coefficient one step to the right, so multiplying the recurrence through
by powers of $x$ and summing converts the recurrence into a closed equation.

#example[
  We solve the Fibonacci recurrence a second time — compare
  #link(<ex:fibonacci-closed-form>)[the characteristic equation solution]. Let
  $F(x) = sum_(n>=0) F_n x^n$. Summing $F_n = F_(n-1) + F_(n-2)$ for $n >= 2$
  against $x^n$:
  $
    F(x) - F_0 - F_1 x & = x sum_(n>=2) F_(n-1) x^(n-1) + x^2 sum_(n>=2) F_(n-2) x^(n-2).
  $
  With $F_0 = 0$, $F_1 = 1$ both tail sums equal $F(x)$, so
  $
    F(x) - x = x F(x) + x^2 F(x)
    quad ==> quad
    F(x) = x / (1 - x - x^2).
  $
  Factor the denominator: $1 - x - x^2 = (1 - phi x)(1 - psi x)$, where
  $phi$ and $psi$ are again the roots of $r^2 - r - 1$. Partial fractions give
  $
    F(x) = (1 / sqrt(5)) (1 / (1 - phi x) - 1 / (1 - psi x)).
  $
  Expanding the geometric series $(1 - phi x)^(-1) = sum phi^n x^n$ and taking
  coefficients recovers the Binet formula
  $
    F_n = (phi^n - psi^n) / sqrt(5),
  $
  in exact agreement with #link(<ex:fibonacci-closed-form>)[the earlier
    derivation].
] <ex:fibonacci-ogf>

#note[
  The two methods are two faces of one computation. The characteristic
  polynomial $p(r)$ of a recurrence and the denominator of the rational
  generating function are related by $P(x) = x^k p(1 \/ x)$: roots $r_i$ of
  $p$ correspond to poles $1 \/ r_i$ of $A(x)$, and the partial fraction
  decomposition of $A(x)$ is precisely the general solution of
  #link(<thm:characteristic>)[the characteristic equation method]. Generating
  functions nevertheless reach further: they handle variable coefficients,
  non-linear recurrences, and two-dimensional arrays by the same algebraic
  mechanics.
]

=== Integer Partitions

#definition(name: "Integer Partition")[
  A *partition* of a positive integer $n$ is a way of writing $n$ as a sum of
  positive integers,
  $
    n = lambda_1 + lambda_2 + dots + lambda_k,
    quad lambda_1 >= lambda_2 >= dots >= lambda_k >= 1,
  $
  where the *order of the summands does not matter*. The summands $lambda_i$
  are the *parts* of the partition. Let $p(n)$ denote the number of partitions
  of $n$, and let $p_(m)(n)$ denote the number of partitions of $n$ into exactly
  $m$ parts.
] <def:partition>

#example[
  There are $p(4) = 5$ partitions of $4$:
  $
    4, quad 3 + 1, quad 2 + 2, quad 2 + 1 + 1, quad 1 + 1 + 1 + 1.
  $
  Note that $3 + 1$ and $1 + 3$ are the *same* partition — this is what
  distinguishes partitions from compositions, where order matters.
] <ex:partitions-of-4>

Partitions have no simple recurrence, but they do have a marvellous product
formula — arguably the birth certificate of the subject.

#theorem(name: "Euler's Generating Function for Partitions")[
  The ordinary generating function of the partition numbers is the infinite
  product
  $
    sum_(n=0)^infinity p(n) x^n = product_(k=1)^infinity 1 / (1 - x^k).
  $
  More generally, the generating function of $p_(m)(n)$, the number of
  partitions of $n$ into exactly $m$ parts, is
  $
    sum_(n>=0) p_(m)(n) x^n = product_(k=1)^infinity x^k / (1 - x^k),
  $
  the same product divided by $x^(1 + 2 + dots + m)$.
] <thm:partition-gf>

#proof[
  A partition either contains a part of size $k$ (some number of times,
  possibly zero) or it does not. Choosing, independently for each $k$, how
  many copies of $k$ the partition contains, the generating function factors
  as a Cauchy product over all part sizes:
  $
    sum_(n>=0) p(n) x^n & = product_(k=1)^infinity (1 + x^k + x^(2k) + dots) & = product_(k=1)^infinity 1 / (1 - x^k),
  $
  by #link(<prop:gf-operations>)[the Cauchy product rule] extended to
  infinitely many factors, valid formally since the coefficient of $x^n$
  involves only factors with $k <= n$.

  For $p_(m)(n)$, partitioning into exactly $m$ parts and subtracting $1$ from
  each part leaves a partition of $n - m$ into at most $m$ parts; each part
  of size $k$ then contributes a copy of $x^(k)$ with total exponent offset
  $1 + 2 + dots + m$, giving the stated quotient.
]

The product formula makes conjugate partitions transparent through the Ferrers
diagram, a visual representation in which each part is a row of dots.

#figure(
  image("img/ferrers-diagram.svg", width: 62%),
  caption: [The Ferrers diagram of the partition $6 + 4 + 4 + 2 + 1$ of $17$
    (left) and its conjugate $5 + 4 + 3 + 3 + 1 + 1$ (right).],
  placement: auto,
  supplement: [Fig.],
) <fig:ferrers>

#example[
  Reading #link(<fig:ferrers>)[the Ferrers diagram] by rows gives the partition
  $lambda = (6, 4, 4, 2, 1)$ of $17$; reading it by *columns* gives the
  *conjugate partition* $lambda' = (5, 4, 3, 3, 1, 1)$. Row-column duality
  implies
  $
    p_(m)(n) = p(n) "into at most" m "parts",
  $
  i.e. the number of partitions of $n$ into exactly $m$ parts equals the
  number of partitions of $n$ whose largest part is $m$. This is the visual
  form of the second part of #link(<thm:partition-gf>)[Euler's formula].
] <ex:conjugate-partitions>

The same product technology proves Euler's celebrated theorem on distinct
versus odd parts.

#theorem(name: "Euler's Distinct–Odd Partitions Theorem")[
  For every $n$, the number of partitions of $n$ into *distinct* parts equals
  the number of partitions of $n$ into *odd* parts.
] <thm:euler-distinct-odd>

#proof[
  The generating function for partitions into distinct parts is
  $
    product_(k=1)^infinity (1 + x^k),
  $
  since each part size $k$ is used at most once. The generating function for
  partitions into odd parts is
  $
    product_(j=1)^infinity 1 / (1 - x^(2j - 1)),
  $
  since only odd part sizes are available, each with unbounded multiplicity.
  Using the identity $1 + x^k = (1 - x^(2k)) / (1 - x^k)$,
  $
    product_(k=1)^infinity (1 + x^k)
    &= product_(k=1)^infinity (1 - x^(2k)) / (1 - x^k)
    &= product_(k=1)^infinity 1 / (1 - x^(2k - 1)),
  $
  because the even factors $1 - x^(2k)$ cancel against the same factors
  appearing in the denominator. The two generating functions coincide, hence
  so do their coefficients.
]

#note[
  There is also a purely bijective proof: split each distinct part into its
  odd part times a power of two — e.g. $6 = 3 dot 2$, $12 = 3 dot 2^2$ — and
  collect the odd parts; this maps distinct partitions to odd partitions, and
  the map is invertible. The generating function proof and the bijection are
  the two standard styles of the subject, and both recur throughout
  enumerative combinatorics.
]

= Inclusion-Exclusion and Sieve Methods

== Inclusion-Exclusion Principle

#theorem(name: "Inclusion-Exclusion Principle")[
  Let $A_1, A_2, dots, A_n$ be finite sets. Then
  $
    abs(union.big_(i=1)^n A_i) & = sum_(i=1)^n abs(A_i)
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
] <thm:inclusion-exclusion>

#proof[
  It suffices to show that every element of $union.big_(i=1)^n A_i$ contributes
  exactly $1$ to the alternating sum $sum_(k=1)^n (-1)^(k+1) S_k$, while
  elements outside contribute nothing. Fix an element $x$ lying in exactly
  $m >= 1$ of the sets, and relabel so that $x in A_1, dots, A_m$ and
  $x in.not A_(m+1), dots, A_n$. Then $x$ contributes to exactly those $S_k$
  indexed by $k$-subsets of ${1, dots, m}$, hence its total contribution is
  $
    sum_(k=1)^m (-1)^(k+1) binom(m, k) & = 1 - sum_(k=0)^m (-1)^k binom(m, k) & = 1 - (1 - 1)^m & = 1,
  $
  as required. The alternating sum therefore counts $union A_i$ exactly.
]

#note[
  Mnemonic: add odd, subtract even.
]

Two small cases, obtained by expanding the sums:

$
  abs(A_1 union A_2) = abs(A_1) + abs(A_2) - abs(A_1 inter A_2).
$

$
  abs(A_1 union A_2 union A_3) & = abs(A_1) + abs(A_2) + abs(A_3)
                                 - abs(A_1 inter A_2) - abs(A_1 inter A_3) - abs(A_2 inter A_3)
                                 + abs(A_1 inter A_2 inter A_3).
$

#corollary(name: "Complement Form")[
  Let $U$ be a finite universal set and $A_1, dots, A_n subset.eq U$, and put
  $S_0 = abs(U)$. The number of elements of $U$ lying in *none* of the $A_i$
  is
  $
    abs(inter.big_(i=1)^n overline(A_i)) & = abs(U) - abs(union.big_(i=1)^n A_i) & = sum_(k=0)^n (-1)^k S_k,
  $
  where $overline(A_i) = U backslash A_i$. In applications this "count the
  complement" form is often the most efficient: rather than counting the good
  objects directly, one counts the bad ones and subtracts.
] <cor:complement-form>

== Applications of Inclusion-Exclusion

The complement form is best seen in action. Each application follows the
same pattern: identify the "bad" sets $A_i$, compute the intersections
$S_k$, and apply the alternating sum.

#example(name: "Derangements")[
  A *derangement* of ${1, 2, dots, n}$ is a permutation fixing no point; let
  $D_n$ be their number. Let $A_i$ be the set of permutations fixing $i$. Then
  permutations fixing a prescribed set of $k$ points number $(n - k)!$, so
  $S_k = binom(n, k) (n - k)!$. By #link(<cor:complement-form>)[the complement
    form],
  $
    D_n & = sum_(k=0)^n (-1)^k binom(n, k) (n - k)! & = n! sum_(k=0)^n (-1)^k / k!.
  $
  Since $sum_(k=0)^n (-1)^k / k! -> 1 \/ e$ extremely fast, $D_n$ is the
  nearest integer to $n! \/ e$ for all $n >= 1$, and the probability that a
  random permutation is a derangement tends to $1 \/ e$.
] <ex:derangements>

The same idea counts coprime integers.

#example(name: "Euler's totient")[
  Let $n = p_1^(a_1) dots p_r^(a_r)$ be the prime factorization of $n$, and
  count the integers in ${1, dots, n}$ coprime to $n$ — this is Euler's
  totient $phi(n)$. Let $A_i$ be the set of integers divisible by $p_i$. An
  intersection of $k$ of them counts multiples of $p_(i_1) dots p_(i_k)$,
  contributing $n / (p_(i_1) dots p_(i_k))$ to $S_k$. By
  #link(<cor:complement-form>)[the complement form],
  $
    phi(n) & = n sum_(I subset.eq {1, dots, r}) (-1)^(abs(I))
             1 / (product_(i in I) p_i) & = n product_(i=1)^r (1 - 1 / p_i).
  $
  We will rederive this formula by Möbius inversion in
  #link(<ex:mobius-phi>)[a later example].
] <ex:euler-phi>

Surjections are functions that miss no value.

#example(name: "Onto functions")[
  How many surjections $f: {1, dots, m} -> {1, dots, n}$ are there? Let $A_i$
  be the set of functions missing the value $i$. Functions missing a
  prescribed set of $k$ values number $(n - k)^m$, so $S_k =
  binom(n, k)(n - k)^m$, and #link(<cor:complement-form>)[the complement form]
  gives
  $
    "Sur"(m, n) = sum_(k=0)^n (-1)^k binom(n, k) (n - k)^m.
  $
  Every surjection splits its domain into $n$ non-empty fibres, so
  $"Sur"(m, n) = n! S(m, n)$, where $S(m, n)$ is the Stirling number of the
  second kind; we will meet it again from this angle in
  #link(<ex:stirling-onto>)[the Stirling chapter].
] <ex:onto-functions>

== Mobius Inversion

The inclusion-exclusion principle is an *alternating-sum inversion*: from
$S_k = sum$ (intersections of $k$ sets) one recovers $abs(union A_i)$ by
$sum (-1)^(k+1) S_k$. The same pattern — "invert a sum by an alternating
correction" — appears in number theory, where the Mobius function $mu$
plays the role of $(-1)^k$. The two themes are unified in §4.4.

#definition(name: "Arithmetic Function")[
  An *arithmetic function* is a function on positive integers with complex values:
  $
    f: NN^* -> CC.
  $
  Examples include the divisor function $d(n)$, Euler totient function $phi(n)$,
  and Mobius function $mu(n)$.
] <def:arithmetic-function>

#definition(name: "Mobius Function")[
  Writing the prime factorisation of $n$ as
  $
    n = p_1^(a_1) p_2^(a_2) dots p_k^(a_k),
  $
  the *Mobius function* $mu: NN^* -> {-1, 0, 1}$ is defined by
  $
    mu(n) = cases(
      1 "if " n = 1,
      0 "if " exists_i (a_i >= 2) ("(squared prime factor)"),
      (-1)^k "if " a_1 = a_2 = dots = a_k = 1 ("(square-free)").
    ).
  $
  Equivalently, $mu(n) = (-1)^k$ when $n$ is a product of $k$ distinct
  primes, $mu(1) = 1$, and $mu(n) = 0$ as soon as $p^2 | n$ for some prime $p$.
] <def:mobius-function>

The key property of $mu$ is that its divisor sums vanish away from $1$.

#lemma(name: "Mobius Divisor Sum")[
  For every positive integer $n$,
  $
    sum_(d | n) mu(d) = cases(1 "if " n = 1, 0 "if " n > 1).
  $
] <lem:mobius-sum>

#proof[
  Write $n = p_1^(a_1) dots p_r^(a_r)$. Only square-free divisors contribute,
  and these are exactly the products $d_I = product_(i in I) p_i$ over subsets
  $I subset.eq {1, dots, r}$. Hence
  $
    sum_(d | n) mu(d) & = sum_(I subset.eq {1, dots, r}) (-1)^(abs(I)) & = (1 - 1)^r,
  $
  which is $1$ when $r = 0$ (i.e. $n = 1$) and $0$ otherwise.
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
] <thm:mobius-inversion>

#proof[
  Substitute the formula for $g$ into the claimed inversion and interchange
  the order of summation:
  $
    sum_(d | n) mu(d) g(n / d) & = sum_(d | n) mu(d) sum_(e | n / d) f(e) & = sum_(e | n) f(e) sum_(d | n / e) mu(d).
  $
  By #link(<lem:mobius-sum>)[the divisor-sum lemma] the inner sum is $1$
  precisely when $n \/ e = 1$, i.e. $e = n$, and vanishes otherwise. Only the
  term $e = n$ survives, leaving $f(n)$.
]

#definition(name: "Dirichlet Convolution")[
  The *Dirichlet convolution* of two arithmetic functions $f$ and $g$ is
  $
    (f * g)(n) = sum_(d | n) f(d) g(n / d).
  $
  Three special functions appear frequently: the *unit* $1(n) = 1$, the
  *identity* $"id"(n) = n$, and the *Dirichlet identity* $epsilon(n) = cases(1 "if" n=1, 0 "if" n>1)$. The convolution satisfies
  $mu * 1 = epsilon$, which is exactly
  #link(<lem:mobius-sum>)[the divisor-sum lemma] in convolution notation.
] <def:dirichlet-convolution>

#example[
  We rederive #link(<ex:euler-phi>)[Euler's totient formula] by inversion.
  Classifying the integers $1, dots, n$ by $gcd(m, n)$ gives at once
  $
    sum_(d | n) phi(d) = n:
  $
  the integers with $gcd(m, n) = d$ are exactly $m = d m'$ with
  $gcd(m', n \/ d) = 1$, and there are $phi(n \/ d)$ of those. In
  #link(<def:dirichlet-convolution>)[Dirichlet convolution] notation this
  reads $phi * 1 = "id"$. Applying
  #link(<thm:mobius-inversion>)[Mobius inversion] — equivalently convolving
  both sides by $mu$, since $mu * 1 = epsilon$ — yields
  $
    phi = mu * "id", quad text("i.e.") quad
    phi(n) & = sum_(d | n) mu(d) n / d & = n sum_(d | n, d " square-free") mu(d) / d & = n product_(p | n) (1 - 1 / p),
  $
  the last step because the square-free divisors of $n$ are the products of
  subsets of its prime divisors. Two independent routes to one formula.
] <ex:mobius-phi>

== Generalizations of Inclusion-Exclusion

Inclusion-exclusion and arithmetic Mobius inversion share the same
skeleton: a sum $F = sum G$ is inverted by an alternating correction.
The unifying framework is *poset Mobius inversion* — one definition of
$mu_P$ on any finite poset, one inversion theorem, and all the preceding
results drop out as special cases.

#definition(name: "Möbius Function of a Poset")[
  Let $(P, <=)$ be a finite partially ordered set. The *Möbius function*
  $mu_P: P times P -> ZZ$ is defined recursively by
  $
    mu_(P)(x, x) = 1,
    quad
    mu_(P)(x, y) = -sum_(x <= z < y) mu_(P)(x, z) quad "for" x < y,
  $
  and $mu_(P)(x, y) = 0$ unless $x <= y$.
] <def:poset-mobius>

#theorem(name: "Möbius Inversion on a Poset")[
  Let $(P, <=)$ be a finite poset and let $F, G: P -> CC$ satisfy
  $
    F(x) = sum_(y in P, y >= x) G(y) quad "for all" x in P.
  $
  Then conversely
  $
    G(x) = sum_(y in P, y >= x) mu_(P)(x, y) F(y)
    quad "for all" x in P.
  $
] <thm:poset-mobius-inversion>

#proof[
  Substitute the expression for $F$ and interchange the sums:
  $
    sum_(y >= x) mu_(P)(x, y) F(y)
    &= sum_(y >= x) mu_(P)(x, y) sum_(z >= y) G(z)
    &= sum_(z >= x) (sum_(x <= y <= z) mu_(P)(x, y)) G(z).
  $
  The inner sum equals $sum_(x <= y < z) mu_(P)(x, y) + mu_(P)(x, z)$, which by
  #link(<def:poset-mobius>)[the recursive definition] is $0$ when $x < z$ and
  $mu_(P)(x, x) = 1$ when $x = z$. Only the term $z = x$ survives, leaving
  $G(x)$.
]

#note[
  Take $P = {1, dots, n}$-subsets ordered by inclusion (the *Boolean lattice*)
  and let $A_i$ be finite sets. Setting $F(X) = abs(inter.big_(i in X) A_i)$
  and $G(X)$ to be the number of elements belonging to exactly the sets
  indexed by $X$, the identity $F(X) = sum_(Y supset.eq X) G(Y)$ holds by
  classifying each element through the exact set of $A_i$ containing it. One
  computes $mu_(P)(X, Y) = (-1)^(abs(Y backslash X))$, so
  #link(<thm:poset-mobius-inversion>)[poset Möbius inversion] produces
  precisely the inclusion–exclusion expansion of
  #link(<thm:inclusion-exclusion>)[the principle] — the two themes of this
  chapter are one. The arithmetic Möbius function
  #link(<def:mobius-function>)[$mu$] arises the same way from the divisor
  lattice, with $mu_(P)(1, n) = mu(n)$. Deeper poset enumeration belongs to a
  more advanced treatment and is not pursued here.
] <note:boolean-lattice-ie>

= Special Counting Sequences

== Catalan Numbers

#definition(name: "Catalan Numbers")[
  The $n$-th Catalan number is
  $
    C_n = 1/(n+1) binom(2n, n).
  $

  First ten values:
  $
    C_0 = 1, C_1 = 1, C_2 = 2, C_3 = 5, C_4 = 14,
    C_5 = 42, C_6 = 132, C_7 = 429, C_8 = 1430, C_9 = 4862.
  $
] <def:catalan>

#property[
  The Catalan numbers admit three equivalent descriptions, each useful in its
  own right:

  1. *Ratio recurrence*:
    $
      C_n = (2 (2n - 1)) / (n + 1) dot C_(n-1), quad n >= 1, quad C_0 = 1.
    $

  2. *Generating function*: with
    $G(x) = sum_(n=0)^infinity C_n x^n$ from
    #link(<def:generating-functions>)[the OGF],
    $
      G(x) = 1 + x G(x)^2,
      quad "and hence"
      quad G(x) = (1 - sqrt(1 - 4x)) / (2x).
    $

  3. *Convolution recurrence*:
    $
      C_n = sum_(i=0)^(n-1) C_i C_(n-1-i), quad n >= 1,
    $
    reflecting the self-similarity of Catalan structures.
] <prop:catalan-recurrences>

#proof[
  (1) is a direct computation: $binom(2n, n) = binom(2n-2, n-1) dot (2n)(2n-1) / n^2$
  and $n / (n+1)$ upgrades to the ratio
  $C_n / C_(n-1) = (2n)(2n-1) / (n(n+1)) = 2(2n-1)/(n+1)$.

  For (2), expand $sqrt(1 - 4x)$ by the generalized binomial theorem. For
  $n >= 1$ one computes
  $
    binom(1 \/ 2, n) (-4)^n = -2 binom(2n - 2, n - 1) / n = -2 C_(n-1),
  $
  so
  $
    sqrt(1 - 4x) = 1 - 2 sum_(n>=1) C_(n-1) x^n = 1 - 2 x G(x),
  $
  i.e. $G(x) = (1 - sqrt(1 - 4x)) / (2x)$. Squaring out verifies the quadratic
  equation: $x G(x)^2 = (1 - 2x - sqrt(1 - 4x)) / (2x)$, and adding $1$ gives
  $G(x)$.

  For (3), read off coefficients in $G = 1 + x G^2$: the constant term gives
  $C_0 = 1$, and for $n >= 1$ the coefficient of $x^n$ on the right is
  $sum_(i=0)^(n-1) C_i C_(n-1-i)$ by #link(<prop:gf-operations>)[the Cauchy
    product rule].
]

The Catalan numbers are the answer to a remarkable list of counting problems:

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

The Dyck path interpretation deserves a proof — both for its own elegance and
because the reflection trick it rests on recurs throughout combinatorics.

#figure(
  image("img/dyck-paths.svg", width: 68%),
  caption: [The $C_3 = 5$ Dyck paths of semilength $3$ (left), and the
    reflection principle: a bad path (first hitting $-1$ marked) reflects its
    remaining steps to end at $(6, -2)$ (right).],
  placement: auto,
  supplement: [Fig.],
) <fig:dyck-paths>

#example[
  We prove the Dyck path count. A Dyck path of semilength $n$ is a word of
  $n$ up-steps and $n$ down-steps whose partial sums stay non-negative, so
  there are at most $binom(2n, n)$ candidates. Call a path *bad* if some
  partial sum reaches $-1$. Map each bad path to a path from $(0, 0)$ to
  $(2n, -2)$ as follows: up to and including the *first* step reaching $-1$,
  keep the path; afterwards, swap every up-step with a down-step. This
  "reflection" turns the remaining $n - 1$ up-steps and $n$ down-steps into
  $n - 1$ down-steps and $n$ up-steps, so the image is a path with $n + 1$
  down-steps and $n - 1$ up-steps ending at $(2n, -2)$ — see
  @fig:dyck-paths. The map is a bijection: applying it again to the first
  step reaching $-1$ of the image (interpreted with up/down swapped)
  recovers the original path. Hence the number of bad paths is
  $binom(2n, n - 1)$, and
  $
    "Dyck"_n = binom(2n, n) - binom(2n, n - 1)
    = binom(2n, n) - binom(2n, n + 1),
  $
  which equals $C_n$ — the difference form alluded to in
  #link(<def:catalan>)[the definition], here obtained combinatorially.
  The ballot interpretation follows by mapping the grid path to a Dyck path
  (a right step becomes an up-step and an up-step a down-step, rotated).
] <ex:catalan-reflection>

== Stirling Numbers

Catalan numbers count structures on a *linearly ordered* object. The Stirling
numbers instead measure how a set can be *split* — the basic enumeration of
set partitions.

#definition(name: "Stirling Numbers of the Second Kind")[
  For $n >= 0$ and $0 <= k <= n$, the *Stirling number of the second kind*
  $S(n, k)$ is the number of ways to partition an $n$-element set into $k$
  non-empty, unlabelled blocks. By convention $S(n, 0) = 0$ for $n >= 1$ and
  $S(0, 0) = 1$.
] <def:stirling-second>

#definition(name: "Stirling Numbers of the First Kind")[
  The *Stirling number of the first kind* $s(n, k)$ counts the permutations
  of an $n$-element set having exactly $k$ cycles. We work with the unsigned
  convention throughout; in identities involving signs the factor
  $(-1)^(n - k)$ is attached explicitly.
] <def:stirling-first>

#property[
  Both Stirling numbers satisfy Pascal-type recurrences:
  $
    S(n, k) = k S(n - 1, k) + S(n - 1, k - 1),
    quad
    s(n, k) = (n - 1) s(n - 1, k) + s(n - 1, k - 1),
  $
  for $n >= 1$ and $1 <= k <= n$, with boundary values $S(n, 0) =
  s(n, 0) = 0$ for $n >= 1$ and $S(0, 0) = s(0, 0) = 1$.
] <prop:stirling-recurrences>

#proof[
  For $S$: partition ${1, dots, n}$ according to the fate of the element $n$.
  If $n$ forms a single block, the remaining elements form a partition of an
  $(n-1)$-set into $k - 1$ blocks; if not, first partition ${1, dots, n-1}$
  into $k$ blocks ($S(n-1, k)$ ways) and insert $n$ into any one of them
  ($k$ choices).

  For $s$: write each permutation of ${1, dots, n}$ as cycles.
  If $n$ is a fixed point, remove it to get a permutation of $n - 1$
  elements with $k - 1$ cycles. Otherwise insert $n$ into one of the $n - 1$
  positions of a permutation of ${1, dots, n - 1}$ with $k$ cycles (after any
  of the $n - 1$ existing symbols), and this correspondence is bijective.
]

#theorem(name: "Change of Basis")[
  For all $n >= 0$,
  $
    x^n = sum_(k=0)^n S(n, k) x^underline(k),
    quad
    x^underline(n) = sum_(k=0)^n (-1)^(n - k) s(n, k) x^k,
  $
  where $x^underline(k) = x (x - 1) dots (x - k + 1)$ is the falling
  factorial. In matrix language, the matrices $(S(n, k))$ and
  $((-1)^(n-k) s(n, k))$ are inverses of each other.
] <thm:stirling-connection>

#proof[
  First identity: both sides are polynomials in $x$, so it suffices to check
  them at all non-negative integers $x = m$. A function $f: {1, dots, n} ->
  {1, dots, m}$ factors uniquely as (a partition of the domain into the
  non-empty fibres) followed by (a labelling of the $k$ fibres by values).
  Classifying by the number $k$ of fibres:
  $
    m^n = sum_(k=0)^n S(n, k) m^underline(k),
  $
  since choosing which $k$ of the $m$ values occur and requiring each to
  occur gives $m^underline(k)$ labellings. Second identity: the falling
  factorial counts *injective* functions ${1, dots, n} -> {1, dots, x}$
  when $x$ is a non-negative integer, and injectivity excludes pairs of
  elements sharing a value; classifying injections by their partition into
  fibres and applying inclusion–exclusion — or inducting on $n$ with
  #link(<prop:stirling-recurrences>)[the recurrence of
    #link(<def:stirling-first>)[$s$]] — yields the signed expansion.
  The two identities are inverse change-of-basis formulas between the bases
  $(x^n)$ and $(x^underline(n))$ of the polynomial ring, which is the matrix
  statement.
]

#example[
  The first rows of $S(n, k)$:

  #table(
    columns: 6,
    align: center,
    table.header[$n backslash k$][$0$][$1$][$2$][$3$][$4$],
    [$0$], [$1$], [], [], [], [],
    [$1$], [$0$], [$1$], [], [], [],
    [$2$], [$0$], [$1$], [$1$], [], [],
    [$3$], [$0$], [$1$], [$3$], [$1$], [],
    [$4$], [$0$], [$1$], [$7$], [$6$], [$1$],
  )

  For instance $S(4, 2) = 7$: writing each partition with a vertical bar
  between its two blocks, they are
  $12 | 34, quad 13 | 24, quad 14 | 23, quad 123 | 4, quad 124 | 3,
  quad 134 | 2, quad 234 | 1$.
] <ex:stirling-table>

#example[
  Revisiting #link(<ex:onto-functions>)[the surjection count from the
    inclusion–exclusion chapter]: a surjection ${1, dots, m} -> {1, dots, n}$
  is exactly a set partition into $n$ non-empty fibres together with a
  bijection from fibres to values, so
  $
    "Sur"(m, n) = n! S(m, n).
  $
  The inclusion–exclusion formula
  $sum_(k=0)^n (-1)^k binom(n, k)(n - k)^m$ and the Stirling recurrence
  compute the same numbers by different means: the former evaluates fast for
  fixed $n$, the latter tabulates the whole triangle at once.
] <ex:stirling-onto>

== Bell Numbers

Summing over the number of blocks turns the Stirling triangle into a single
sequence counting *all* set partitions.

#definition(name: "Bell Numbers")[
  The $n$-th *Bell number* is the number of partitions of an $n$-element
  set:
  $
    B_n = sum_(k=0)^n S(n, k).
  $
] <def:bell>

#example[
  $B_3 = 5$: the partitions of ${1, 2, 3}$ are
  $123, quad 1 | 23, quad 2 | 13, quad 3 | 12, quad 1 | 2 | 3$
  (one block, three two-block splits, three singletons). The first values
  are $B_0 = 1, B_1 = 1, B_2 = 2, B_3 = 5, B_4 = 15, B_5 = 52$.
] <ex:bell-partitions>

#property[
  The Bell numbers satisfy the recurrence
  $
    B_(n+1) = sum_(k=0)^n binom(n, k) B_k,
  $
  and their exponential generating function from
  #link(<def:generating-functions>)[the EGF] is
  $
    B(x) = sum_(n=0)^infinity B_n x^n / n! = e^(e^x - 1).
  $
] <prop:bell-egf>

#proof[
  For the recurrence, classify partitions of ${1, dots, n + 1}$ by the block
  containing $n + 1$: if the other elements of that block are chosen from
  $n - k$ of the $n$ remaining elements (equivalently, $k$ elements are left
  out, in $binom(n, k)$ ways), the excluded $k$ elements are partitioned
  freely in $B_k$ ways.

  For the EGF, fix the number of blocks $k$. Splitting an $n$-set into $k$
  labelled non-empty blocks and then forgetting the labels, the EGF of
  $S(n, k)$ over $n$ is $(e^x - 1)^k \/ k!$ — each labelled block contributes
  the EGF $e^x - 1$ of a non-empty set, and the $k!$ removes the labelling.
  Summing over $k$ and using the exponential series,
  $
    B(x) = sum_(k=0)^infinity (e^x - 1)^k / k! = e^(e^x - 1).
  $
]

== Schroder Numbers

Catalan paths take unit steps; allowing *diagonal* shortcuts gives the last
family of this chapter.

#definition(name: "Schröder Numbers")[
  The $n$-th (large) *Schröder number* $R_n$ is the number of lattice paths
  from $(0, 0)$ to $(n, n)$ that use steps $(1, 0)$ (east), $(0, 1)$ (north)
  and $(1, 1)$ (diagonal) and never go above the diagonal $y = x$. The first
  values are
  $
    R_0 = 1, R_1 = 2, R_2 = 6, R_3 = 22, R_4 = 90, R_5 = 394.
  $
] <def:schroder>

#example[
  For $n = 2$ the $R_2 = 6$ paths are, written as words in the steps $E$,
  $N$, $D$ (diagonal):
  $
    E E N N, quad E N E N, quad D E N, quad E D N, quad E N D, quad D D.
  $
  Every word starting with $N$ immediately crosses the diagonal, and $D N E$
  crosses it after its second step, so the six words above exhaust the
  possibilities: two without a diagonal, three with one, one with two.
] <ex:schroder-paths>

#note[
  Splitting at the last diagonal-free segment gives the functional equation
  for the ordinary generating function $R(x) = sum_(n>=0) R_n x^n$:
  $
    R(x) = 1 + x R(x) + x R(x)^2,
  $
  whose solution (the branch with $R(0) = 1$) is
  $R(x) = (1 - x - sqrt(1 - 6x + x^2)) / (2x)$. Comparing with
  #link(<prop:catalan-recurrences>)[the Catalan equation] $G = 1 + x G^2$,
  the Schröder equation is the Catalan equation plus the single-step option
  $x R$: the two families are linked by
  $R_n = sum_(k=0)^n binom(n + k, 2k) C_k$, and the *small* Schröder numbers
  $R_n \/ 2$ ($n >= 1$) count the same paths in which no diagonal step lies
  on the main diagonal.
]

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
