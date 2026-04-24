#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Théorie des Ensembles",
  author: "CatMono",
  date: datetime.today(),
)

#show: apply-style

#make-cover(
  "Théorie des Ensembles",
  "CatMono",
  subtitle: "A notebook for set theory",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.1.0",
  extra-info: "Migrated from LaTeX to Typst (single-file mode).",
)

#make-outline(depth: 2, title: "Contents")

= Preface

Some notations are used throughout this book:

- $bb(N)$: Set of natural numbers (including 0).
- $bb(N)^* / bb(N)_+$: Set of natural numbers (excluding 0).
- $bb(Z)$: Set of integers.
- $bb(Q)$: Set of rational numbers.
- $bb(R)$: Set of real numbers.

#part("Foundations of Set Theory")

= Naïve Set Theory

== Sets and Their Operations

#definition(name: "Power Set")[
  Let $X$ be a set.
  The *power set* of $X$, denoted by $scr(P)(X)$, is defined as the set of all subsets of $X$:

  $
    scr(P)(X) = {A | A subset X}.
  $
]

=== Operations on Sets

#definition(name: "Basic Operations on Sets")[
  Let $A$ and $B$ be two sets. The following operations are defined:

  - *Union*: The union of $A$ and $B$, denoted by $A union B$, is defined as the set of elements that are in $A$ or in $B$ (or in both):

    $
      A union B = {x | x in A text(" or ") x in B}.
    $

  - *Intersection*: The intersection of $A$ and $B$, denoted by $A inter B$, is defined as the set of elements that are in both $A$ and $B$:

    $
      A inter B = {x | x in A text(" and ") x in B}.
    $

  - *Difference*: The difference of $A$ and $B$, denoted by $A - B$ or $A backslash B$, is defined as the set of elements that are in $A$ but not in $B$:

    $
      A - B = {x | x in A text(" and ") x not in B}.
    $

  - *Complement*: The complement of $A$ with respect to a universal set $U$, denoted by $A^c$ or $overline(A)$, is defined as the set of elements that are in $U$ but not in $A$:

    $
      A^c = U - A = {x | x in U text(" and ") x in.not A}.
    $

  - *Symmetric Difference*: The symmetric difference of $A$ and $B$, denoted by $A plus.o B$ or $A triangle B$, is defined as the set of elements that are in either $A$ or $B$ but not in both:

    $
      A plus.o B = (A - B) union (B - A) = {x | (x in A text(" and ") x in.not B) text(" or ") (x in B text(" and ") x not in A)}.
    $
]

#definition(name: "Limit of a Sequence of Sets")[
  Let ${A_n}_{n=1}^infinity$ be a sequence of sets.
  The *limit inferior* (or *lim inf*) and *limit superior* (or *lim sup*) of the sequence are defined as follows:

  $
    liminf_(n -> infinity) A_n = union_(n=1)^infinity inter_(k=n)^infinity A_k,
  $

  $
    limsup_(n -> infinity) A_n = inter_(n=1)^infinity union_(k=n)^infinity A_k,
  $

  If $liminf_(n -> infinity) A_n = limsup_(n -> infinity) A_n$, then the common set is called the *limit* of the sequence, denoted by

  $
    lim_(n -> infinity) A_n = liminf_(n -> infinity) A_n = limsup_(n -> infinity) A_n.
  $
]

== Relations and Mappings

=== Relations
#definition(name: "Cartesian productuct")[
  Let $X$ and $Y$ be two sets.
  The *Cartesian productuct* (or direct productuct) of $X$ and $Y$, denoted by $X times Y$, is defined as the set of all ordered pairs $(x, y)$ where $x in X$ and $y in Y$:

  $
    X times Y = {(x, y) | x in X, y in Y}.
  $

  The Cartesian productuct can be extended to finitely many sets.
  The Cartesian productuct of $X$ and itself $n$ times is denoted by $X^n$.
]

#definition(name: "Relation")[
  Let $X$ and $Y$ be two sets.
  A *relation* $R$ from $X$ to $Y$ is a subset of the Cartesian productuct $X times Y$:

  $
    R subset X times Y.
  $

  If $(x, y) in R$, we say that $x$ is related to $y$ by the relation $R$, denoted by $x R y$.

  If $A subset X$, then the subset of $Y$ defined by

  $
    R(A) = {y in Y | exists x in A, (x, y) in R}
  $

  is called the *image* of $A$ under the relation $R$.
  $R(X)$ is called the *range* of the relation $R$.
]

There are several special types of relations:

- *Empty relation*: The empty set $emptyset$ is a relation from $X$ to $Y$.
- *Total relation*: The Cartesian productuct $X times Y$ is a relation from $X$ to $Y$.
- *Identity relation*: The relation $I_X = {(x, x) | x in X}$ is called the *identity relation* on $X$.

When studying binary relations, we often focus on whether they have some special properties.
For a binary relation $R$ on a set $X$, we define the following special properties:

- *Reflexive*: $(forall x in X) x R x$.
- *Irreflexive*: $(forall x in X) not (x R x)$.
- *Symmetric*: $(forall x, y in X) (x R y <=> y R x)$.
- *Antisymmetric*: $(forall x, y in X) (x R y and y R x) -> x = y$.
- *Transitive*: $(forall x, y, z in X) (x R y and y R z) -> x R z$.
- *Connected (Total)*: $(forall x, y in X) x != y -> (x R y or y R x)$.
- *Well-founded*: $(exists x in X != emptyset) (forall y in X backslash {x}) not(y R x)$.
- *Transitive of incomparability*: $(forall x, y, z in X) (not(x R y or y R x) and not(y R z or z R y)) -> not(x R z or z R x)$.

#definition(name: "Equivalence Relation")[
  A binary relation $R$ on a set $X$ is called an *equivalence relation* if it is reflexive, symmetric, and transitive.
]

=== Mappings

#definition(name: "Mapping (Function)")[
  A *mapping* (or function) $f$ from a set $X$ to a set $Y$ is a relation such that for every $x in X$, there exists a unique $y in Y$ such that $(x, y) in f$.
  We denote this by $f: X -> Y$ and write $f(x) = y$.

  The set $X$ is called the *domain* of $f$, and the set $Y$ is called the *codomain* of $f$.
  The set $f(X) = {f(x) | x in X}$ is called the *image* of $f$.
]

There are several special types of mappings:

- *Identity mapping*: The mapping $id_X: X -> X$ defined by $id_X(x) = x$ for all $x in X$ is called the *identity mapping* on $X$.
- *Constant mapping*: A mapping $f: X -> Y$ is called a *constant mapping* if there exists a fixed element $y_0 in Y$ such that $f(x) = y_0$ for all $x in X$.

Mappings can be classified based on their behavior:

- *Injective (One-to-One)*: A mapping $f: X -> Y$ is *injective* if for every $x_1, x_2 in X$, $f(x_1) = f(x_2) => x_1 = x_2$.
- *Surjective (Onto)*: A mapping $f: X -> Y$ is *surjective* if for every $y in Y$, there exists an $x in X$ such that $f(x) = y$.
- *Bijective*: A mapping $f: X -> Y$ is *bijective* if it is both injective and surjective.

For $A subset X$, let

$
  chi_A (x) = cases(
    1\, quad  x in A\, ,
    0\, quad  x in.not A.
  )
$

be the *characteristic function* of set $A$.

#definition(name: "Inverse Mapping and Composition Mappings")[
  Let $f: X -> Y$ be a bijective mapping.
  The *inverse mapping* of $f$, denoted by $f^(-1): Y -> X$, is defined by $f^(-1)(y) = x$ if and only if $f(x) = y$.

  Let $f: X -> Y$ and $g: Y -> Z$ be two mappings.
  The *composition mapping* of $f$ and $g$, denoted by $g compose f: X -> Z$, is defined by $(g compose f)(x) = g(f(x))$ for all $x in X$.
]

#definition(name: "Restriction and Extension")[
  Let $f: X -> Y$ be a mapping, and let $A subset X$.
  The *restriction* of $f$ to $A$, denoted by $f|_A$, is the mapping from $A$ to $Y$ defined by $f|_A(x) = f(x)$ for all $x in A$.

  Conversely, if $g: A -> Y$ is a mapping and $A subset X$, an *extension* of $g$ to $X$ is a mapping $f: X -> Y$ such that $f|_A = g$.
]

#note[
  In analysis, the term "extension" is often used interchangeably with "*continuation*"<def:continuation>.
  However, an extension typically requires the extended mapping to satisfy certain properties, such as continuity or differentiability.
]



= Zermelo-Fraenkel Set Theory

== Axioms of ZFC

#axiom(name: "Zermelo-Fraenkel Set Theory with Choice (ZFC)")[
  Zermelo-Fraenkel Set Theory with Choice (ZFC) is a formal system that provides a foundation for much of modern mathematics.
  It consists of a set of axioms that describe the properties and behavior of sets.

  The axioms of ZFC are as follows:

  - *Axiom of Extensionality*: Two sets are equal if they have the same elements.

    $
      forall A forall B (forall x (x in A <=> x in B) -> A = B)
    $

  - *Axiom of Regularity (Foundation)*: Every non-empty set $A$ contains an element that is disjoint from $A$.

    $
      forall A (A != emptyset -> exists B (B in A and B inter A = emptyset))
    $

  - *Axiom Schema of Specification (Separation)*: For any set $A$ and any property $P(x)$, there exists a subset $B$ of $A$ containing exactly those elements of $A$ that satisfy the property $P(x)$.

    $
      forall A exists B forall x (x in B <=> (x in A and P(x)))
    $

  - *Axiom of Pairing*: For any two sets $A$ and $B$, there exists a set $C$ that contains exactly $A$ and $B$ as elements.

    $
      forall A forall B exists C forall x (x in C <=> (x = A or x = B))
    $

  - *Axiom of Union*: For any set $A$, there exists a set $B$ that contains exactly the elements of the elements of $A$.

    $
      forall A exists B forall x (x in B <=> exists C (C in A and x in C))
    $

  - *Axiom Schema of Replacement*: For any set $A$ and any definable function $F$, there exists a set $B$ that contains exactly the images of the elements of $A$ under $F$.

    $
      forall A exists B forall y (y in B <=> exists x (x in A and y = F(x)))
    $

  - *Axiom of Infinity*: There exists a set $A$ that contains the empty set and is closed under the operation of taking the successor.

    $
      exists A (emptyset in A and forall x (x in A -> x union {x} in A))
    $

  - *Axiom of Power Set*: For any set $A$, there exists a set $B$ that contains exactly the subsets of $A$.

    $
      forall A exists B forall C (C in B <=> C subset A)
    $

  - *Axiom of Choice*: For any set $A$ of non-empty sets, there exists a choice function $f$ that selects exactly one element from each set in $A$.

    $
      forall A (forall B in A B != emptyset -> exists f : A -> union A forall B in A (f(B) in B))
    $
]

== Axiom of Choice

== Von Neumann-Bernays-Gödel Set Theory

#part("Ordinals and Cardinals")

= Ordinals

== Order

#definition(name: "Preordered Set")[
  A *preordered set* is a set $P$ together with a binary relation $prec.eq$ that is reflexive and transitive.
]

#definition(name: "Partially Ordered Set (Poset)")[
  A *partially ordered set* (or *poset*) is a set $P$ together with a binary relation $prec.eq$ that is reflexive, antisymmetric, and transitive.
  The relation $prec.eq$ is called a *partial order* on $P$.

  Specifically, $prec$ is called a *strict partial order* on $P$ if it is irreflexive, antisymmetric, and transitive.
]

#definition(name: "Totally Ordered Set (Chain)")[
  A *totally ordered set* (or *chain*) is a set $P$ together with a partial order $prec.eq$ that is connected (total), i.e., for any $x, y in P$, either $x prec.eq y$ or $y prec.eq x$.
]

#definition(name: "Well-Ordered Set")[
  A *well-ordered set* is a set $P$ together with a totally ordered $prec.eq$ that is well-founded, i.e., every nonempty subset of $P$ has a least element.
]

#theorem(name: "Well-Ordering Theorem")[
  Every set can be well-ordered.
]

#note[
  The well-ordering theorem is an equivalent formulation of the axiom of choice and is unprovable in ZF.
]

#tex-table(
  (
    [Binary Relation], [Reflexive], [Symmetric], [Antisymmetric], [Transitive], [Connected], [Well-founded],
  ),
  (
    [Equivalence], [$checkmark$], [$checkmark$], [], [$checkmark$], [], [],
  ),
  (
    [Preorder], [$checkmark$], [], [], [$checkmark$], [], [],
  ),
  (
    [Partial Order], [$checkmark$], [], [$checkmark$], [$checkmark$], [], [],
  ),
  (
    [Total Order], [$checkmark$], [], [$checkmark$], [$checkmark$], [$checkmark$], [],
  ),
  (
    [Well-Order], [$checkmark$], [], [$checkmark$], [$checkmark$], [$checkmark$], [$checkmark$],
  ),
)

== Ordinal Numbers

#definition(name: "Transitive Set")[
  A set $A$ is called *transitive* if every element of $A$ is also a subset of $A$, i.e., $(forall x in A) (x subset A)$.
]

#definition(name: "Von Neumann Ordinal")[
  A set $alpha$ is an ordinal number (an *ordinal*) if it is transitive and well-ordered by the membership relation $in$.

  All ordinals form a proper class denoted by $"Ord"$.
]

#note[
  In ZF, the above definition is equivalent to: $alpha$ is an ordinal if and only if $alpha$ is a transitive set and all of its elements are transitive sets.
  This is because the axiom of regularity ensures the well-foundedness of sets.
]

Ordinals can be classified into three types:

- *Zero*: The empty set $emptyset$ is the only ordinal that is neither a successor nor a limit.
- *Successor Ordinal*: An ordinal $alpha$ is a *successor ordinal* if there exists an ordinal $beta$ such that $alpha = beta + 1 = beta union {beta}$.
- *Limit Ordinal*: An ordinal $lambda$ is a *limit ordinal* if it is nonzero and not a successor, i.e., $lambda = union_(beta < lambda) beta$.

#definition(name: "Natural Number")[
  Denote the least nonzero limit ordinal by $omega$ (or $bb(N)$).
  The ordinals less than $omega$ are called *finite numbers*, or *natural numbers*.
  Specially,

  $
    0 = emptyset, quad 1 = {0}, quad 2 = {0, 1}, quad 3 = {0, 1, 2}, quad dots
  $

  A set $X$ is finite if there is a one-to-one mapping of $X$ onto some $n in bb(N)$.
  $X$ is infinite if it is not finite.
]

== Induction and Recursion

#theorem(name: "Transfinite Induction")[
  Let $C$ be a class of ordinals and assume that:

  1. $0 in C$.
  2. If $alpha in C$, then $alpha + 1 in C$.
  3. If $lambda$ is a nonzero limit ordinal and $(forall beta < lambda) beta in C$, then $lambda in C$.

  Then $C = "Ord"$.
]

#theorem(name: "Transfinite Recursion")[
  Let $F$ be a class function that assigns to each ordinal $alpha$ an element $F(alpha, g)$, where $g$ is a function with domain $alpha$.
  Then there exists a unique class function $G$ with domain $"Ord"$ such that for every ordinal $alpha$,

  $
    G(alpha) = F(alpha, G|_alpha),
  $

  where $G|_alpha$ is the restriction of $G$ to the domain $alpha$.
]

== Ordinal Arithmetic

#theorem(name: "Cantor's Normal Form")[
  Every ordinal $alpha > 0$ can be uniquely expressed in the form

  $
    alpha = omega^beta_1 dot c_1 + omega^beta_2 dot c_2 + dots + omega^beta_n dot c_n,
  $

  where $n$ is a positive integer, $c_1, c_2, dots, c_n$ are positive integers, and $beta_1 > beta_2 > dots > beta_n$ are ordinals.
]



= Cardinals

== Cardinality

#definition(name: "Equinumerosity and Cardinality")[
  Two sets $A$ and $B$ are said to be *equinumerous* (or have the same cardinality), denoted by $A tilde B$, if there exists a bijection $f : A -> B$.

  The *cardinality* of a set $A$ is the least ordinal $kappa$ such that $A tilde kappa$, denoted by $|A|$ (or $"card"(A)$, $overline(overline(A))$).
]

#definition(name: "Aleph Numbers")[
  The *aleph numbers* are a sequence of cardinal numbers defined as follows:

  - $aleph_0$ is the cardinality of the set of natural numbers $bb(N)$.
  - For any ordinal $alpha$, $aleph_(alpha + 1)$ is the least cardinal number greater than $aleph_alpha$.
  - For any limit ordinal $lambda$, $aleph_lambda = sup{aleph_beta | beta < lambda}$.
]

#theorem(name: "Cantor-Bernstein-Schröder Theorem")[
  If there exist injections $f : A -> B$ and $g : B -> A$, then there exists a bijection $h : A -> B$.
  In particular, $|A| = |B|$.
]

#definition(name: "Countable and Uncountable Sets")[
  A set $A$ is called *countable* if $|A| <= aleph_0$, i.e., there exists an injection from $A$ to $bb(N)$.
  A set is called *uncountable* if it is not countable, i.e., its cardinality is greater than $aleph_0$.
]

#proposition[
  1. The subsets of a countable set are countable.
  2. The countable union of countable sets is countable.
  3. Any infinite set contains a countable subset.
]

#theorem(name: "Cantor's Theorem")[
  For any set $A$, $|A| < |scr(P)(A)|$.
]

== Cardinal Arithmetic

== The Canonical Well-Ordering of $alpha times alpha$

== Cofinality

#part("Real Numbers and Point Sets in Euclidean Space")

= Real Numbers

== Construction of Real Numbers and the Cardinality of the Continuum

== Point Sets in Euclidean Space

In this section, we explore the point sets in Euclidean space.
Furthermore, these concepts can be generalized to metric spaces and topological spaces.

#definition(name: "Diameter and Bounded Set")[
  Let $A$ be a subset of the Euclidean space $bb(R)^n$.
  The *diameter* of set $A$ is defined as

  $
    "diam"(A) = sup {d(x, y) | x, y in A},
  $

  where $d(x, y)$ denotes the Euclidean distance between points $x$ and $y$.

  A set $A$ is called *bounded* if there exists a real number $M > 0$ such that

  $
    d(x, y) < M, quad forall x, y in A.
  $

  Let $x_0 in bb(R)^n, delta > 0$, the set

  $
    B(x_0, delta) = {x in bb(R)^n | d(x, x_0) < delta}
  $

  is called the *open ball* (or *neighborhood*) with center $x_0$ and radius $delta$#footnote[
    It can be also denoted as $N(x_0, delta)$ or $U(x_0, delta)$.
    When $delta$ does not need to be emphasized, it can also be abbreviated as $B(x_0)$.
  ].
  Similarly, the closed ball can be defined as
  
  $
    overline(B)(x_0, delta) = {x in bb(R)^n | d(x, x_0) <= delta}.
  $

  Let $a_i, b_i$ ($i = 1, 2, dots, n$) be real numbers with $a_i < b_i$, the set

  $
    product_(i=1)^n [a_i, b_i] = {(x_1, x_2, dots, x_n) in bb(R)^n | a_i <= x_i text(" for all ") i = 1, 2, dots, n}
  $

  is called a *rectangle* (or *box*) in $bb(R)^n$.
  If all the edge lengths are equal, i.e., $b_i - a_i = c$ for some constant $c > 0$ and for all $i$, then the rectangle is called a *cube* with side length $c$.
  Similarly, we can define the open rectangle (or open box) as

  $
    product_(i=1)^n (a_i, b_i) = {(x_1, x_2, dots, x_n) in bb(R)^n | a_i < x_i text(" for all ") i = 1, 2, dots, n}.
  $

  Rectangles are often denoted by $I, J, dots$ and their volumes by $|I|, |J|, dots$.
]

#definition(name: "Limit")[
  Let ${x_k}$ be a sequence in $bb(R)^n$ and $x in bb(R)^n$.
  We say that ${x_k}$ *converges* to $x$, or $x$ is the *limit* of the sequence ${x_k}$, if for every $epsilon > 0$, there exists a natural number $N$ such that

  $
    d(x_k, x) < epsilon, quad forall k > N.
  $

  In this case, we write

  $
    lim_(k -> infinity) x_k = x.
  $
]

== Classification of Points

#definition(name: "Classification of Points")[
  Let $E$ be a subset of the Euclidean space $bb(R)^n$.
  Points in $bb(R)^n$ can be classified based on their relationship to set $E$:

  - *Interior Point*: A point $x in E$ is called an *interior point* of set $E$ if there exists $U(x)$ such that $U(x) subset E$.
  - *Exterior Point*: A point $x in bb(R)^n backslash E$ is called an *exterior point* of set $E$ if there exists $U(x)$ such that $U(x) subset bb(R)^n backslash E$, or equivalently, $U(x) inter E = emptyset$.
  - *Boundary Point*: A point $x in bb(R)^n$ is called a *boundary point* of set $E$ if for every $U(x)$, the set $U(x)$ contains points in both $E$ and $bb(R)^n backslash E$.
  - *Accumulation Point (Limit Point)*: A point $x in bb(R)^n$ is called an *accumulation point* (or *limit point*) of set $E$ if for every $U(x)$, the set $U(x)$ contains at least one point of $E$ different from $x$#footnote[
    Obviously, only infinite sets can have accumulation points.
    In fact, here, containing at least one (distinct) point in the neighborhood is equivalent to containing infinitely many points.
  ].
  - *Isolated Point*: A point $x in E$ is called an *isolated point* of set $E$ if $x$ is not an accumulation point of $E$, i.e., there exists $U(x)$ such that $U(x) inter E = {x}$.
]


#definition(name: "Derived Set / Interior / Boundary / Closure")[
  Let $E$ be a subset of the Euclidean space $bb(R)^n$.

  - The *derived set* of $E$, denoted by $E'$, is the set of all accumulation points of $E$.
  - The *interior* of set $E$, denoted by $"int"(E)$, or $E^circle.tiny$, is the set of all interior points of $E$.
  - The *boundary* of set $E$, denoted by $partial E$, is the set of all boundary points of $E$, or equivalently, $partial E = overline(E) backslash E^circle.tiny$.
  - The *closure* of set $E$, denoted by $overline(E)$, is the union of $E$ and its accumulation points, i.e., $overline(E) = E union E'$.
]

#property[
  - $(E^circle.tiny)^c = overline(E^c)$, $(overline(E))^c = E^circle.tiny$.
  - Let $A subset B$, then $A' subset B'$, $E^circle.tiny (A) subset E^circle.tiny (B)$ and $overline(A) subset overline(B)$.
  - $(A union B)' = A' union B'$.
]

#note[
  In a metric space, an alternative definition of accumulation point can be given:
  A point $x$ is an accumulation point of set $E$ if and only if it is the limit of some sequence of points in $E$.
]

#note[
  By replacing the Euclidean distance with a general metric $d$, all the above definitions can be naturally extended to a general metric space $(X, d)$.

  By replacing the metric $d$ with the family of open sets in a general topological structure, all the above definitions can be extended to a general topological space $(X, tau)$.
]

== Open and Closed Sets

#definition(name: "Classification of Point Sets")[
  Let $E$ be a subset of the Euclidean space $bb(R)^n$.
  Point sets can be classified:

  - *Closed Set*: A set $E$ is called a *closed set* if it contains all its accumulation points.
  - *Open Set*: A set $E$ is called an *open set* if every point in $E$ is an interior point of $E$.
  - *Compact Set*: A set $E$ is called a *compact set* if every open cover of $E$ has a finite subcover, or equivalently, if $E$ is closed and bounded (Heine-Borel Theorem).
  - *Perfect Set*: A set $E$ is called a *perfect set* if it is closed and has no isolated points, i.e., every point in $E$ is an accumulation point of $E$, or equivalently, $E = E'$.
  - *Dense Set*: A set $E$ is called a *dense set* in $bb(R)^n$ if every point in $bb(R)^n$ is either in $E$ or is an accumulation point of $E$, i.e., $overline(E) = bb(R)^n$.
  - *Nowhere Dense Set*: A set $E$ is called a *nowhere dense set* in $bb(R)^n$ if the interior of its closure is empty, i.e., $overline(E)^circle = emptyset$.
    Or equivalently, the complement of its closure is dense in $bb(R)^n$, i.e., $overline(E)^c$ is dense in $bb(R)^n$.
]

#note[
  In a metric space, an alternative definition of closed set can be given:
  A set $E$ is closed if and only if it contains all its sequential limits.
  (This is because metric spaces satisfy the first countability axiom, and sequential convergence is equivalent to topological closure.)
  In fact, in a metric space, closed sets and sequentially closed sets are equivalent.

  However, in a topological space, the definitions of open and closed sets depend on the topological structure, and closed sets are always sequentially closed, but the converse is not true.
]

#v(0.7cm)

#lemma[
  Let $G subset bb(R)$ be non-empty bounded open set, then for all $x_0 in G$, there exists an open interval $(alpha, beta)$ such that

  1. $x_0 in (alpha, beta)$.
  2. $alpha, beta in.not G$.
]

#property[
  1. Such interval $(alpha, beta)$ is the maximal open interval containing $x_0$ and contained in $G$, and is called the *construction interval* of $G$.
  2. For any $x in G$, there exists a construction interval of $G$ that contains $x$.
  3. The construction intervals of $G$ are pairwise disjoint.
]

#note[
  The boundedness of $G$ in the lemma is not necessary, and the conclusion still holds for unbounded sets.
  However, the corresponding construction interval can also be unbounded.
  For example, if $G = (0, infinity)$ and $x_0 = 1$, then the construction interval can be $(0, infinity)$.

  Similarly, the definition of construction interval can also be extended to $bb(R)^n$.
]

#theorem(name: "Open Set Construction Theorem")[
  Every non-empty open set on the real line can be expressed as a countable union of construction intervals.

  Furthermore, every non-empty open set in $bb(R)^n$ can be expressed as a countable union of construction intervals.
]

== Special Point Sets and Special Functions

#definition(name: "Cantor Set")[
  The *Cantor set* $C$ is defined as the set of all points in the interval $[0, 1]$ that can be represented in base $3$ without the digit $1$.
  Equivalently, $C$ can be constructed by repeatedly removing the open middle third of each remaining interval, starting with the interval $[0, 1]$.
]

The endpoints of the intervals in the construction of the Cantor set can be represented in base $3$ as:

$
  0 = 0_3, quad 1/3 = 0.1..._3 = 0.0222..._3, quad 2/3 = 0.2..._3, \
  quad 1/9 = 0.01..._3 = 0.0022..._3, quad 2/9 = 0.02..._3, quad 7/9 = 0.21..._3, quad 8/9 = 0.22..._3,
  quad dots
$

The common feature of these endpoints is that *they either have a finite number of digits or, from some digit onward, all digits are $2$*.

The number of these endpoints is countable, but there are many other non-endpoint points in the Cantor set, such as $1/4 = 0.02020202..._3$ and $4/13 = 0.002200220022..._3$, and the number of these points is uncountable.

#property[
  Denote by $C_n$ the set obtained after the $n$-th step of the construction process, then 
  $
  C = inter.big_(n=0)^infinity C_n,
  $
  and each $C_n$ is a union of $2^n$ closed intervals of length $3^(-n)$.
  1. $C$ is uncountable, and has the same cardinality as the interval $[0, 1]$.
  2. $C$ is a closed set not containing any interval, i.e., $C$ is a perfect nowhere dense set.
]


= Special Classes of Sets

#note[
  The LaTeX source for this chapter currently contains only a chapter title.
]

#part("Filters and Boolean Algebras")

= Filters and Boolean Algebras

== Filters and Ultrafilters

#note[
  The LaTeX source for this section currently contains only a section title.
]

== Boolean Algebras

#note[
  The LaTeX source for this section currently contains only a section title.
]



#part("Appendix")
= Glossary

== C
- *#link(<def:continuation>)[Continuation]*


#bibliography("references.bib")


// --- Part I: Foundations of Set Theory (集合论基础) ---

// Chapter 1: Naïve Set Theory (朴素集合论)
//   Section 1.1: Sets and Their Operations (集合及其运算)
//   Section 1.2: Relations and Mappings (关系与映射)
//   Section 1.3: Basic Notions of Set Sequences (集合列的基本概念)

// Chapter 2: Axiomatic Set Theory (公理化集合论)
//   Section 2.1: Zermelo-Fraenkel Set Theory with Choice (ZFC) (带选择公理的ZFC)
//   Section 2.2: Axiom of Choice and Equivalent Principles (选择公理及其等价命题)
//   Section 2.3: Von Neumann-Bernays-Gödel Set Theory (NBG公理)

// --- Part II: Ordinals and Cardinals (序数与基数) ---

// Chapter 3: Ordinals (序数)
//   Section 3.1: Order Relations (序关系)
//   Section 3.2: Ordinal Numbers (序数的定义与分类)
//   Section 3.3: Transfinite Induction and Recursion (超限归纳与超限递归)
//   Section 3.4: Ordinal Arithmetic (序数运算)

// Chapter 4: Cardinals (基数)
//   Section 4.1: Cardinality and Equinumerosity (基数与等势)
//   Section 4.2: Countable and Uncountable Sets (可数集与不可数集)
//   Section 4.3: Cantor-Bernstein-Schröder Theorem and Cantor's Theorem (康托-伯恩斯坦-施罗德定理与康托定理)
//   Section 4.4: Cardinal Arithmetic (基数运算)
//   Section 4.5: Cofinality and Continuum Hypothesis (共终性与连续统假设)

// --- Part III: Real Numbers and Point-Set Topology (实数与点集拓扑) ---

// Chapter 5: Real Numbers and Euclidean Point Sets (实数与欧氏空间中的点集)
//   Section 5.1: Construction of the Real Numbers (实数的构造)
//   Section 5.2: Diameter, Boundedness and Limits (直径、有界性与极限)
//   Section 5.3: Classification of Points (点的分类)
//   Section 5.4: Open and Closed Sets (开集与闭集)
//   Section 5.5: Compactness, Perfectness and Density (紧致性、完美性与稠密性)

// Chapter 6: Special Point Sets and Special Classes of Sets (特殊点集与特殊集合类)
//   Section 6.1: Derived Sets and Closure Operations (导集与闭包运算)
//   Section 6.2: Nowhere Dense Sets and Meagre-Type Notions (处处稀疏集与瘦集类概念)
//   Section 6.3: Cantor Set and Related Fractals (Cantor 集及相关分形)
//   Section 6.4: Special Classes of Sets in the Real Line (实直线上的特殊集合类)

// --- Part IV: Filters and Descriptive Set Theory (滤子与描述集合论) ---

// Chapter 7: Filters and Boolean Algebras (滤子与布尔代数)
//   Section 7.1: Filters and Ultrafilters (滤子与极大滤子)
//   Section 7.2: Boolean Algebras (布尔代数)
//   Section 7.3: Stone Representation Philosophy (Stone 表示思想)

// Chapter 8: Borel and Analytic Sets (Borel 集与分析集)
//   Section 8.1: Algebras and Sigma-Algebras (集合代数与σ-代数)
//   Section 8.2: Borel Sets (Borel 集)
//   Section 8.3: Borel Hierarchy and Generated Classes (Borel 层级与生成类)
//   Section 8.4: Analytic Sets and Descriptive Set Theory (分析集与描述集合论)

// Structure note:
// - Part I establishes the language and axioms of set theory.
// - Part II collects ordinals, cardinals, and transfinite methods in one coherent block.
// - Part III unifies real numbers with point-set topology and geometric set classes.
// - Part IV closes the book with filters, Boolean algebras, and Borel / analytic set theory.
