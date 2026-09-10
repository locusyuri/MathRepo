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
  version: "v0.2.0",
  extra-info: "Migrated from LaTeX to Typst (single-file mode).",
)

#make-outline(depth: 2, title: "Contents")

= Preface

Some notations are used throughout this book:

- $bb(N)$: Set of natural numbers (including 0).
- $bb(N)^* \/ bb(N)_+$: Set of natural numbers (excluding 0).
- $bb(Z)$: Set of integers.
- $bb(Q)$: Set of rational numbers.
- $bb(R)$: Set of real numbers.

#part("Foundations of Set Theory")

= Naïve Set Theory

== Sets and Their Operations

=== Operations on Sets

#definition(name: "Power Set")[
  Let $X$ be a set.
  The *power set* of $X$, denoted by $scr(P)(X)$, is defined as the set of all subsets of $X$:
  $
    scr(P)(X) = {A | A subset.eq X}.
  $
] <def:power-set>

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
] <def:basic-operations>

#theorem(name: "De Morgan's Formulas")[
  $
    X - union.big_(alpha in Gamma) A_alpha = inter.big_(alpha in Gamma) (X - A_alpha), \
    X - inter.big_(alpha in Gamma) A_alpha = union.big_(alpha in Gamma) (X - A_alpha).
  $
  If $A_alpha in X (forall alpha in Gamma)$, $X$ is a universal set, then the above formulas can be rewritten as:
  $
    (union.big_(alpha in Gamma) A_alpha)^c = inter.big_(alpha in Gamma) A_alpha^c, \
    (inter.big_(alpha in Gamma) A_alpha)^c = union.big_(alpha in Gamma) A_alpha^c.
  $
] <thm:de-morgan>

#property(name: "Distributive Laws")[
  For any sets $A$, $B$, $C$:
  $
    A union (B inter C) = (A union B) inter (A union C), \
    A inter (B union C) = (A inter B) union (A inter C).
  $
  These extend to arbitrary families: union distributes over intersection and vice versa.
] <prop:distributive-laws>

== Relations and Mappings

=== Relations
#definition(name: "Cartesian product")[
  Let $X$ and $Y$ be two sets.
  The *Cartesian product* (or direct product) of $X$ and $Y$, denoted by $X times Y$, is defined as the set of all ordered pairs $(x, y)$ where $x in X$ and $y in Y$:

  $
    X times Y = {(x, y) | x in X, y in Y}.
  $

  The Cartesian product can be extended to finitely many sets.
  The Cartesian product of $X$ and itself $n$ times is denoted by $X^n$.
] <def:cartesian-product>

#definition(name: "Relation")[
  Let $X$ and $Y$ be two sets.
  A *relation* $R$ from $X$ to $Y$ is a subset of the Cartesian product $X times Y$:

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
] <def:relation>

There are several special types of relations:

- *Empty relation*: The empty set $emptyset$ is a relation from $X$ to $Y$.
- *Total relation*: The Cartesian product $X times Y$ is a relation from $X$ to $Y$.
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
] <def:equivalence-relation>

=== Mappings

#definition(name: "Mapping (Function)")[
  A *mapping* (or function) $f$ from a set $X$ to a set $Y$ is a relation such that for every $x in X$, there exists a unique $y in Y$ such that $(x, y) in f$.
  We denote this by $f: X -> Y$ and write $f(x) = y$.

  The set $X$ is called the *domain* of $f$, and the set $Y$ is called the *codomain* of $f$.
  The set $f(X) = {f(x) | x in X}$ is called the *image* of $f$.
] <def:mapping>

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
    1\, quad x in A\,,
    0\, quad x in.not A.
  )
$
be the *characteristic function* of set $A$.

#definition(name: "Inverse Mapping and Composition Mappings")[
  Let $f: X -> Y$ be a bijective mapping.
  The *inverse mapping* of $f$, denoted by $f^(-1): Y -> X$, is defined by $f^(-1)(y) = x$ if and only if $f(x) = y$.

  Let $f: X -> Y$ and $g: Y -> Z$ be two mappings.
  The *composition mapping* of $f$ and $g$, denoted by $g compose f: X -> Z$, is defined by $(g compose f)(x) = g(f(x))$ for all $x in X$.
] <def:inverse-composition>

#definition(name: "Restriction and Extension")[
  Let $f: X -> Y$ be a mapping, and let $A subset X$.
  The *restriction* of $f$ to $A$, denoted by $f|_A$, is the mapping from $A$ to $Y$ defined by $f|_A(x) = f(x)$ for all $x in A$.

  Conversely, if $g: A -> Y$ is a mapping and $A subset X$, an *extension* of $g$ to $X$ is a mapping $f: X -> Y$ such that $f|_A = g$.
] <def:restriction-extension>


== Equivalence Relations and Quotient Sets // 等价关系与商集

An equivalence relation on a set $S$ — reflexive, symmetric,
transitive — allows us to *collapse* $S$ into the collection of its
equivalence classes. This quotient construction is one of the most
fundamental set-theoretic tools; in algebra it underlies quotient
groups, quotient rings, and quotient modules.

#definition(name: "Equivalence Class")[
  Let $R$ be an equivalence relation on $S$ and $a in S$. The
  *equivalence class* of $a$ is
  $
    [a]_R = {x in S | x R a}.
  $
  Any $x in [a]_R$ is called a *representative* of the class.
] <def:equivalence-class>

#property(name: "Basic Properties of Classes")[
  For all $a, b in S$:
  - $a in [a]_R$ (in particular every class is non-empty and every
    element lies in some class);
  - $a R b$ if and only if $[a]_R = [b]_R$;
  - $not (a R b)$ if and only if $[a]_R ∩ [b]_R = emptyset$.
] <prop:equivalence-class-props>

#proof[
  Reflexivity gives $a in [a]_R$. If $[a]_R = [b]_R$ then
  $a in [a]_R = [b]_R$ gives $a R b$; conversely if $a R b$ and $x in
  [a]_R$, then $x R a$ and $a R b$ give $x R b$, so $[a]_R subset.eq
  [b]_R$, and symmetry reverses the inclusion. The third item follows:
  if $x$ lies in both classes, then $a R x$ and $x R b$ force $a R b$,
  reducing to the second item.
]

So the classes are either *equal* or *disjoint* — never partially
overlapping. This is exactly what it takes for them to carve $S$ into
blocks.

#definition(name: "Partition")[
  A *partition* of a set $S$ is a family ${S_i}_("i in I")$ of
  non-empty subsets such that
  $
    union_(i in I) S_i = S, quad quad S_i ∩ S_j = emptyset
    quad "for" i != j.
  $
] <def:partition>

#theorem(name: "Partition-Class Correspondence")[
  Every equivalence relation on $S$ determines a partition of $S$,
  namely its family of equivalence classes; conversely, every
  partition of $S$ arises from exactly one equivalence relation,
  namely "$a R b$ if and only if $a$ and $b$ lie in the same block."
] <thm:partition-correspondence>

#proof[
  ($R ==>$ partition) Reflexivity covers $S$
  (#link(<prop:equivalence-class-props>)[first property]); classes are
  pairwise disjoint: if $[a]_R ∩ [b]_R != emptyset$, the second
  property forces $[a]_R = [b]_R$ — classes are equal or disjoint,
  never partially overlapping.

  (partition $==>$ $R$) Let ${S_i}$ be a partition and define $a R b$ if
  some block contains both. Reflexivity holds since $a$ lies in the
  block covering it, symmetry is built into "both lie", and
  transitivity holds because if $a, b$ share one block and $b, c$ share
  one, then both blocks contain $b$, so they coincide and contain $a$
  and $c$. Uniqueness is clear: the relation reads off the partition
  and conversely.
]

#figure(
  image("img/partition-quotient.svg", width: 82%),
  caption: [The quotient construction. Left: the set $S$ carved into
    pairwise disjoint equivalence classes $[a], [b], [c]$, each
    shaded region one class. Right: the classes themselves collected
    as points of the quotient set $S \/ R$. Elements *inside* one
    class are identified; the quotient set is the set of blocks.],
  placement: auto,
  supplement: [Fig.],
) <fig:partition-quotient>

#definition(name: "Quotient Set")[
  The set of all equivalence classes of $R$ on $S$,
  $
    S \/ R = {[a] | a in S},
  $
  is the *quotient set* of $S$ by $R$. Its elements are classes, not
  elements of $S$.
] <def:quotient-set>

== Order Relations // 序关系

A binary relation that is reflexive, antisymmetric and transitive —
or some variant thereof — singles out a notion of *order* on a set.
These structures are needed as early as
#link(<thm:zorn>)[Zorn's Lemma] in §2.2, so we collect the basic
vocabulary here.

#definition(name: "Preordered Set")[
  A *preordered set* is a set $P$ together with a binary relation
  $prec.eq$ that is reflexive and transitive.
] <def:preorder>

#definition(name: "Partially Ordered Set (Poset)")[
  A *partially ordered set* (or *poset*) is a set $P$ together with a
  binary relation $prec.eq$ that is reflexive, antisymmetric, and
  transitive.
  The relation $prec.eq$ is called a *partial order* on $P$.

  Specifically, $prec$ is called a *strict partial order* on $P$ if it
  is irreflexive, antisymmetric, and transitive.
] <def:poset>

#definition(name: "Totally Ordered Set (Chain)")[
  A *totally ordered set* (or *chain*) is a set $P$ together with a
  partial order $prec.eq$ that is connected (total), i.e., for any
  $x, y in P$, either $x prec.eq y$ or $y prec.eq x$.
] <def:total-order>

#definition(name: "Well-Ordered Set")[
  A *well-ordered set* is a set $P$ together with a total order
  $prec.eq$ that is well-founded, i.e., every nonempty subset of $P$
  has a least element.
] <def:well-order>

#note[
  The statement that *every* set can be well-ordered — the
  #link(<thm:well-ordering>)[Well-Ordering Theorem] — is developed in
  #link(<axiom:choice>)[§2.2] as an equivalent of the Axiom of Choice.
]

#definition(name: "Upper Bound and Maximal Element")[
  Let $(P, prec.eq)$ be a poset and $A subset.eq P$.
  - An element $u in P$ is an *upper bound* of $A$ if
    $a prec.eq u$ for all $a in A$.
  - An element $m in P$ is *maximal* in $P$ if no element of $P$ is
    strictly greater than $m$, i.e., $m prec.eq x$ implies $x = m$.
] <def:upper-bound-maximal>

#tex-table(
  (
    [Binary Relation],
    [Reflexive],
    [Symmetric],
    [Antisymmetric],
    [Transitive],
    [Connected],
    [Well-founded],
  ),
  (
    [Equivalence],
    [$checkmark$],
    [$checkmark$],
    [],
    [$checkmark$],
    [],
    [],
  ),
  (
    [Preorder],
    [$checkmark$],
    [],
    [],
    [$checkmark$],
    [],
    [],
  ),
  (
    [Partial Order],
    [$checkmark$],
    [],
    [$checkmark$],
    [$checkmark$],
    [],
    [],
  ),
  (
    [Total Order],
    [$checkmark$],
    [],
    [$checkmark$],
    [$checkmark$],
    [$checkmark$],
    [],
  ),
  (
    [Well-Order],
    [$checkmark$],
    [],
    [$checkmark$],
    [$checkmark$],
    [$checkmark$],
    [$checkmark$],
  ),
)

== Relational Algebra // 关系代数

Relational algebra, introduced by E. F. Codd in 1970, treats
relations (defined in #link(<def:relation>)[§1.2] as subsets of
Cartesian products) as the basic data model and operates on them with
a family of algebraic operators. Each operator takes one or more
relations as input and produces a new relation as output. In database
theory, a relation is often presented as a *table*: each tuple is a
row, and each attribute is a column. We write a relation on attributes
$A_1, dots, A_n$ as $R(A_1, dots, A_n)$, and a tuple in $R$ as
$t = (t_1, dots, t_n)$ where $t_i$ is the value of attribute $A_i$.

#definition(name: "Selection and Projection")[
  Let $R$ be a relation on attributes $A_1, dots, A_n$.
  - *Selection* $sigma_theta (R)$: the subset of tuples in $R$
    satisfying a predicate $theta$:
    $
      sigma_theta (R) = {t in R | theta(t)}.
    $
  - *Projection* $pi_S (R)$: the relation obtained by keeping only
    the attributes in $S subset.eq {A_1, dots, A_n}$ from each tuple:
    $
      pi_S (R) = {t[S] | t in R}.
    $
  Projection may reduce the number of tuples (duplicates are removed,
  since relations are sets).
] <def:selection-projection>

#definition(name: "Cartesian Product and Join")[
  Let $R(A_1, dots, A_n)$ and $S(B_1, dots, B_m)$ be relations.
  - *Cartesian product* $R times S$: the relation on
    $A_1, dots, A_n, B_1, dots, B_m$ consisting of all concatenations:
    $
      R times S = {(t, u) | t in R, u in S}.
    $
  - *$theta$-join* $R ⋈_"theta" S$: selection on the Cartesian
    product:
    $
      R ⋈_"theta" S = sigma_theta (R times S).
    $
  - *Natural join* $R ⋈ S$: the $theta$-join where $theta$
    requires equality on all common attributes, followed by projection
    to remove duplicate columns.
] <def:join>

#definition(name: "Set Operations on Relations")[
  When two relations $R$ and $S$ are *union-compatible* (same number
  of attributes with matching domains), the set operations of
  #link(<def:basic-operations>)[§1.1] apply directly:
  - *Union*: $R union S$
  - *Intersection*: $R inter S$
  - *Difference*: $R - S$
] <def:relation-set-operations>

#definition(name: "Division")[
  Let $R(A, B)$ be a relation with two attribute groups, and $S(B)$ a
  relation on $B$. The *division* $R div S$ is the set of $A$-values
  that, combined with every $B$-tuple in $S$, appear in $R$:
  $
    R div S = {a | forall s in S, (a, s) in R}.
  $
  Division is the algebraic dual of universal quantification and is
  useful for "for all" queries.
] <def:division>

#definition(name: "Rename")[
  The *rename* operator $rho_(A -> B) (R)$ changes the attribute name
  $A$ to $B$ in the schema of $R$, leaving the data unchanged.
] <def:rename>

#note[
  These operators are *complete*: any query expressible in first-order
  logic over relations can be expressed using selection, projection,
  Cartesian product, union, difference, and rename. The join and
  division operators are derived conveniences.
]

== Set Sequences // 集合列

#definition(name: "Monotone Sequence of Sets")[
  A sequence ${A_n}_{n=1}^infinity$ of sets is:
  - *increasing* (or *ascending*) if $A_n subset.eq A_(n+1)$ for all
    $n$;
  - *decreasing* (or *descending*) if $A_(n+1) subset.eq A_n$ for all
    $n$.
  Both cases are called *monotone*.
] <def:monotone-sequence>

#definition(name: "Limit of a Sequence of Sets")[
  Let ${A_n}_{n=1}^infinity$ be a sequence of sets.
  The *limit inferior* (or *lim inf*) and *limit superior* (or *lim sup*) of the sequence are defined as follows:

  $
    liminf_(n -> infinity) A_n & = {x | exists "infinite" k, "s.t." x in A_k} \
                               & = { x | forall n exists k > n, "s.t." x in A_k} \
                               & = union.big_(n=1)^infinity inter.big_(k=n)^infinity A_k,
  $

  $
    limsup_(n -> infinity) A_n & = {x | exists "infinite" k, "s.t." x in A_k} \
                               & = { x | forall n exists k > n, "s.t." x in A_k} \
                               & = inter.big_(n=1)^infinity union.big_(k=n)^infinity A_k,
  $

  If $liminf_(n -> infinity) A_n = limsup_(n -> infinity) A_n$, then the common set is called the *limit of the sequence of sets*, denoted by

  $
    lim_(n -> infinity) A_n = liminf_(n -> infinity) A_n = limsup_(n -> infinity) A_n.
  $
] <def:limit-of-sequence-of-sets>

#proposition(name: "Consistency of Limit Definitions")[
  The definitions of limit inferior and limit superior of a sequence of sets are consistent, i.e., the equalities in the definition hold.
] <prop:limit-consistency>

#theorem(name: "Conversion of Limit Inferior and Superior")[
  $
    X - limsup_(n -> infinity) A_n = liminf_(n -> infinity) (X - A_n), \
    X - liminf_(n -> infinity) A_n = limsup_(n -> infinity) (X - A_n).
  $
] <thm:limsup-liminf-conversion>

#property(name: "Limits of Monotone Sequences")[
  If ${A_n}$ is increasing, then $lim_(n -> infinity) A_n$ exists and equals $union.big_(n=1)^infinity A_n$.
  If ${A_n}$ is decreasing, then $lim_(n -> infinity) A_n$ exists and equals $inter.big_(n=1)^infinity A_n$.
] <prop:monotone-limit>

#note[
  Countable union and countable intersection can be viewed as special
  cases of set sequence limits. For an arbitrary sequence ${A_n}$:
  - $union.big_(n=1)^infinity A_n = limsup_(n -> infinity) A_n$ when
    the sequence is increasing;
  - $inter.big_(n=1)^infinity A_n = liminf_(n -> infinity) A_n$ when
    the sequence is decreasing.
  These connections make set sequences a fundamental tool in measure
  theory and probability, where continuity of measure is proved via
  monotone sequences.
]



= Zermelo-Fraenkel Set Theory

== Axioms of ZFC

Zermelo-Fraenkel Set Theory with Choice (ZFC) is a formal system that
provides a foundation for much of modern mathematics. We state the
axioms individually so that they can be referenced when needed.

#axiom(name: "Axiom of Extensionality")[
  Two sets are equal if they have the same elements.
  $
    forall A forall B (forall x (x in A <=> x in B) -> A = B).
  $
] <axiom:extensionality>

#axiom(name: "Axiom of Regularity (Foundation)")[
  Every non-empty set $A$ contains an element that is disjoint from
  $A$.
  $
    forall A (A != emptyset -> exists B (B in A and B inter A = emptyset)).
  $
] <axiom:regularity>

#axiom(name: "Axiom Schema of Specification (Separation)")[
  For any set $A$ and any property $P(x)$, there exists a subset $B$
  of $A$ containing exactly those elements of $A$ that satisfy $P(x)$.
  $
    forall A exists B forall x (x in B <=> (x in A and P(x))).
  $
] <axiom:specification>

#axiom(name: "Axiom of Pairing")[
  For any two sets $A$ and $B$, there exists a set $C$ that contains
  exactly $A$ and $B$ as elements.
  $
    forall A forall B exists C forall x (x in C <=> (x = A or x = B)).
  $
] <axiom:pairing>

#axiom(name: "Axiom of Union")[
  For any set $A$, there exists a set $B$ that contains exactly the
  elements of the elements of $A$.
  $
    forall A exists B forall x (x in B <=> exists C (C in A and x in C)).
  $
] <axiom:union>

#axiom(name: "Axiom Schema of Replacement")[
  For any set $A$ and any definable function $F$, there exists a set
  $B$ that contains exactly the images of the elements of $A$ under
  $F$.
  $
    forall A exists B forall y (y in B <=> exists x (x in A and y = F(x))).
  $
] <axiom:replacement>

#axiom(name: "Axiom of Infinity")[
  There exists a set $A$ that contains the empty set and is closed
  under the operation of taking the successor.
  $
    exists A (emptyset in A and forall x (x in A -> x union {x} in A)).
  $
] <axiom:infinity>

#axiom(name: "Axiom of Power Set")[
  For any set $A$, there exists a set $B$ that contains exactly the
  subsets of $A$.
  $
    forall A exists B forall C (C in B <=> C subset.eq A).
  $
] <axiom:power-set-axiom>

#axiom(name: "Axiom of Choice")[
  For any set $A$ of non-empty sets, there exists a choice function
  $f$ that selects exactly one element from each set in $A$.
  $
    forall A (forall B in A B != emptyset -> exists f : A -> union A forall B in A (f(B) in B)).
  $
] <axiom:choice>

== Axiom of Choice and Equivalent Principles // 选择公理及其等价命题

The #link(<axiom:choice>)[Axiom of Choice] (AC) is independent of the
other ZF axioms (Gödel 1938, Cohen 1963). Its importance lies in the
fact that it is *equivalent* to several seemingly different
statements. We list the most important ones.

#theorem(name: "Well-Ordering Theorem")[
  Every set can be well-ordered.
] <thm:well-ordering>

#note[
  The well-ordering theorem is an equivalent formulation of the axiom
  of choice and is unprovable in ZF. It was the original form in which
  Zermelo stated the axiom in 1904.
]

#theorem(name: "Zorn's Lemma")[
  Let $(P, prec.eq)$ be a non-empty
  #link(<def:poset>)[partially ordered set] in which every chain
  (#link(<def:total-order>)[totally ordered subset]) has an
  #link(<def:upper-bound-maximal>)[upper bound] in $P$. Then $P$ has
  at least one #link(<def:upper-bound-maximal>)[maximal element].
] <thm:zorn>

#theorem(name: "Hausdorff Maximal Principle")[
  Every partially ordered set contains a maximal chain.
] <thm:hausdorff-maximal>

#note[
  The following are all equivalent (in ZF):
  - #link(<axiom:choice>)[Axiom of Choice]
  - #link(<thm:well-ordering>)[Well-Ordering Theorem]
  - #link(<thm:zorn>)[Zorn's Lemma]
  - #link(<thm:hausdorff-maximal>)[Hausdorff Maximal Principle]

  The proofs of equivalence are non-trivial. AC $->$ Zorn uses
  transfinite induction on the ordinals; Zorn $->$ Well-Ordering
  applies Zorn to the poset of partial well-orderings; Well-Ordering
  $->$ AC is immediate (well-order the union, then pick the least
  element from each set).
]

== Von Neumann-Bernays-Gödel Set Theory

#note[
  Placeholder: NBG set theory, an alternative axiomatization that
  distinguishes between *sets* and *proper classes*, will be developed
  here.
]

#part("Ordinals and Cardinals")

= Ordinals

== Ordinal Numbers

#definition(name: "Transitive Set")[
  A set $A$ is called *transitive* if every element of $A$ is also a
  subset of $A$, i.e., $(forall x in A) (x subset.eq A)$.
] <def:transitive-set>

#definition(name: "Von Neumann Ordinal")[
  A set $alpha$ is an ordinal number (an *ordinal*) if it is
  transitive and well-ordered by the membership relation $in$.

  All ordinals form a proper class denoted by $"Ord"$.
] <def:ordinal>

#note[
  In ZF, the above definition is equivalent to: $alpha$ is an ordinal
  if and only if $alpha$ is a transitive set and all of its elements
  are transitive sets. This is because the
  #link(<axiom:regularity>)[Axiom of Regularity] ensures the
  well-foundedness of sets.
]

Ordinals can be classified into three types:

- *Zero*: The empty set $emptyset$ is the only ordinal that is neither
  a successor nor a limit.
- *Successor Ordinal*: An ordinal $alpha$ is a *successor ordinal* if
  there exists an ordinal $beta$ such that $alpha = beta + 1 = beta
  union {beta}$.
- *Limit Ordinal*: An ordinal $lambda$ is a *limit ordinal* if it is
  nonzero and not a successor, i.e., $lambda = union.big_(beta < lambda)
  beta$.

#definition(name: "Natural Number")[
  Denote the least nonzero limit ordinal by $omega$ (or $bb(N)$).
  The ordinals less than $omega$ are called *finite numbers*, or
  *natural numbers*. Specially,

  $
    0 = emptyset, quad 1 = {0}, quad 2 = {0, 1}, quad 3 = {0, 1, 2}, quad dots
  $

  A set $X$ is *finite* if there is a one-to-one mapping of $X$ onto
  some $n in bb(N)$. $X$ is *infinite* if it is not finite.
] <def:natural-number>

== Induction and Recursion

#theorem(name: "Transfinite Induction")[
  Let $C$ be a class of ordinals and assume that:

  + $0 in C$.
  + If $alpha in C$, then $alpha + 1 in C$.
  + If $lambda$ is a nonzero limit ordinal and $(forall beta < lambda)
    beta in C$, then $lambda in C$.

  Then $C = "Ord"$.
] <thm:transfinite-induction>

#theorem(name: "Transfinite Recursion")[
  Let $F$ be a class function that assigns to each ordinal $alpha$
  an element $F(alpha, g)$, where $g$ is a function with domain
  $alpha$. Then there exists a unique class function $G$ with domain
  $"Ord"$ such that for every ordinal $alpha$,

  $
    G(alpha) = F(alpha, G|_alpha),
  $

  where $G|_alpha$ is the restriction of $G$ to the domain $alpha$.
] <thm:transfinite-recursion>

== Ordinal Arithmetic

Ordinal addition, multiplication and exponentiation are defined by
#link(<thm:transfinite-recursion>)[transfinite recursion] on the
right argument.

#definition(name: "Ordinal Addition")[
  For ordinals $alpha, beta$:
  + $alpha + 0 = alpha$;
  + $alpha + (beta + 1) = (alpha + beta) + 1$;
  + $alpha + lambda = union.big_(beta < lambda) (alpha + beta)$ for
    a nonzero limit ordinal $lambda$.
] <def:ordinal-addition>

#definition(name: "Ordinal Multiplication")[
  For ordinals $alpha, beta$:
  + $alpha dot 0 = 0$;
  + $alpha dot (beta + 1) = alpha dot beta + alpha$;
  + $alpha dot lambda = union.big_(beta < lambda) (alpha dot beta)$
    for a nonzero limit ordinal $lambda$.
] <def:ordinal-multiplication>

#definition(name: "Ordinal Exponentiation")[
  For ordinals $alpha, beta$:
  + $alpha^0 = 1$;
  + $alpha^(beta+1) = alpha^beta dot alpha$;
  + $alpha^lambda = union.big_(beta < lambda) alpha^beta$ for a
    nonzero limit ordinal $lambda$.
] <def:ordinal-exponentiation>

#property(name: "Laws of Ordinal Arithmetic")[
  Ordinal arithmetic is *associative* but *not commutative* and
  *left-distributive* but not right-distributive:
  + Associativity: $(alpha + beta) + gamma = alpha + (beta + gamma)$,
    $(alpha dot beta) dot gamma = alpha dot (beta dot gamma)$.
  + Left-distributivity: $alpha dot (beta + gamma) = alpha dot beta +
    alpha dot gamma$.
  + Non-commutativity: $1 + omega = omega != omega + 1$,
    $2 dot omega = omega != omega dot 2 = omega + omega$.
  + Failure of right-distributivity:
    $(omega + 1) dot 2 = omega + 1 + omega + 1 = omega + (1 + omega)
    + 1 = omega + omega + 1$,
    while $omega dot 2 + 1 dot 2 = omega + omega + 1$ only if
    distributivity held; in fact $1 dot 2 = 2$ and the right side
    becomes $omega dot 2 + 2 = omega + omega + 2 != omega + omega +
    1$.
] <prop:ordinal-arithmetic-laws>

#theorem(name: "Cantor's Normal Form")[
  Every ordinal $alpha > 0$ can be uniquely expressed in the form

  $
    alpha = omega^beta_1 dot c_1 + omega^beta_2 dot c_2 + dots + omega^beta_n dot c_n,
  $

  where $n$ is a positive integer, $c_1, c_2, dots, c_n$ are positive
  integers, and $beta_1 > beta_2 > dots > beta_n$ are ordinals.
] <thm:cantor-normal-form>

#note[
  Cantor's Normal Form is the ordinal analogue of base-$omega$
  representation; it is the key tool for computations in ordinal
  arithmetic.
]



= Cardinals

== Cardinality and Equinumerosity

#definition(name: "Equinumerosity and Cardinality")[
  Two sets $A$ and $B$ are said to be *equinumerous* (or have the same
  *cardinality*), denoted by $A tilde B$, if there exists a bijection
  $f : A -> B$.

  The *cardinality* of a set $A$ is the least ordinal $kappa$ such
  that $A tilde kappa$, denoted by $|A|$ (or $"card"(A)$,
  $overline(overline(A))$).
] <def:equinumerosity>

#definition(name: "Aleph Numbers")[
  The *aleph numbers* are a sequence of cardinal numbers defined as
  follows:

  - $aleph_0$ is the cardinality of $bb(N)$.
  - For any ordinal $alpha$, $aleph_(alpha + 1)$ is the least cardinal
    number greater than $aleph_alpha$.
  - For any limit ordinal $lambda$,
    $aleph_lambda = sup {aleph_beta | beta < lambda}$.
] <def:aleph-numbers>

#definition(name: "Cardinal Comparison")[
  Write $|A| <= |B|$ if there is an injection $A -> B$, and
  $|A| < |B|$ if $|A| <= |B|$ but $|A| != |B|$ (no bijection). The
  relation $<=$ on cardinals is a
  #link(<def:total-order>)[total order] (a consequence of the
  #link(<thm:well-ordering>)[Well-Ordering Theorem]).
] <def:cardinal-comparison>

== Countable and Uncountable Sets

#definition(name: "Countable and Uncountable Sets")[
  A set $A$ is called *countable* if $|A| <= aleph_0$, i.e., there
  exists an injection from $A$ to $bb(N)$. A set is called
  *uncountable* if it is not countable, i.e., its cardinality is
  greater than $aleph_0$.
] <def:countable>

#caution[
  In some textbooks, a countable set is defined as an *infinite* set
  that can be put into one-to-one correspondence with $bb(N)$. In this
  book, we consider finite sets to be countable as well.
]

#proposition(name: "Basic Facts on Cardinals")[
  + *$aleph_0$ is the smallest infinite cardinal*: Any infinite set
    contains a countable subset.
  + *Characterisation of infinite sets*: $A$ is infinite if and only
    if $A$ is equinumerous to a proper subset of itself.
  + *Characterisation of uncountable sets*: $A$ is uncountable if and
    only if $A$ is infinite and $A$ is not equinumerous to any
    countable subset $B subset A$.
  + *#link(<thm:cantor>)[Cantor's Theorem]*:
    $|A| < |scr(P)(A)|$ for any set $A$.
  + *Countable union of countable sets*: The countable union of
    countable sets is countable.
] <prop:cardinal-facts>

#proof[
  (1) Pick $a_0 in A$; since $A$ is infinite, $A - {a_0}$ is
  non-empty, pick $a_1$ from it; continue. This recursion defines an
  injection $n mapsto a_n$ from $bb(N)$ into $A$.

  (4) The map $a mapsto {a}$ is an injection $A -> scr(P)(A)$, so
  $|A| <= |scr(P)(A)|$. For the reverse, suppose for contradiction
  that a bijection $f : A -> scr(P)(A)$ exists. Define
  $D = {a in A | a in.not f(a)}$. Then $D subset.eq A$, so $D = f(d)$
  for some $d in A$. But then $d in D "iff" d in.not f(d) = D$, a
  contradiction.

  (5) Index the family as ${A_n}_{n in bb(N)}$. For each $n$ choose
  an injection $f_n : A_n -> bb(N)$ (this uses the
  #link(<axiom:choice>)[Axiom of Choice] for countably many choices).
  The map $(n, a) mapsto 2^n (2 f_n(a) + 1)$ injects $union.big_n A_n$
  into $bb(N)$ by unique prime factorisation.
]

#theorem(name: "Cantor's Theorem")[
  For any set $A$, $|A| < |scr(P)(A)|$.
] <thm:cantor>

== Cantor-Bernstein-Schröder Theorem

#lemma(name: "Banach's Decomposition Lemma")[
  Let $f: X -> Y$ and $g: Y -> X$ be mappings. Then there exist
  disjoint decompositions of $X$ and $Y$:
  $
    X = A union overline(A), quad Y = B union overline(B),
  $
  such that $f(A) = B$, $g(B) = overline(A)$, $A inter overline(A) =
  emptyset$, and $B inter overline(B) = emptyset$.
] <lem:banach-decomposition>

#proof[
  Call a subset $C subset.eq X$ *good* if $C inter g(Y - f(C))
  = emptyset$, i.e., $C$ and $g(Y - f(C))$ are disjoint. The
  union of any chain of good subsets is good, so by
  #link(<thm:zorn>)[Zorn's Lemma] (or directly by taking the union of
  all good subsets) there is a maximal good subset $A subset.eq X$.
  Define $B = f(A)$ and $overline(A) = g(Y - B)$. Then $A$ and
  $overline(A)$ partition $X$, $B$ and $overline(B) = Y - B$
  partition $Y$, and $g(overline(B)) = overline(A)$ by maximality.
]

#theorem(name: "Cantor-Bernstein-Schröder Theorem")[
  If there exist injections $f : A -> B$ and $g : B -> A$, then there
  exists a bijection $h : A -> B$. In other words, $|A| = |B|$.
] <thm:cantor-bernstein>

#proof[
  By the #link(<lem:banach-decomposition>)[Banach Decomposition Lemma]
  applied to $f$ and $g$, decompose
  $A = A_0 union overline(A_0)$, $B = B_0 union overline(B_0)$ with
  $f(A_0) = B_0$ and $g(overline(B_0)) = overline(A_0)$. Then $f$
  bijects $A_0$ onto $B_0$, and $g^(-1)$ bijects $overline(A_0)$ onto
  $overline(B_0)$. Piecing them together gives a bijection
  $
    h(a) = cases(f(a) "if" a in A_0, g^(-1)(a) "if" a in overline(A_0)).
  $
]

#exercise[
  Prove:
  + If $A$ is countable and $B$ is infinite, then $A union B tilde B$.
  + $bb(Q)$ is countable (in multiple ways).
  + $[0, 1]$, $[0, 1)$ are uncountable.
] <ex:cardinality-exercises>

== Cardinal Arithmetic

#definition(name: "Cardinal Arithmetic")[
  Let $kappa, lambda$ be cardinals.
  + *Sum*: $kappa + lambda = |kappa union^* lambda|$, where
    $union^*$ denotes disjoint union (e.g.
    $kappa times {0} union lambda times {1}$).
  + *Product*: $kappa dot lambda = |kappa times lambda|$.
  + *Exponentiation*: $kappa^lambda = |kappa^lambda|$, the cardinality
    of the set of all functions $lambda -> kappa$.
] <def:cardinal-arithmetic>

#property(name: "Laws of Cardinal Arithmetic")[
  + Commutativity: $kappa + lambda = lambda + kappa$, $kappa dot
    lambda = lambda dot kappa$.
  + Associativity and distributivity hold as for cardinals.
  + *Absorption*: $kappa + lambda = kappa dot lambda = max(
      kappa,
      lambda
    )$ for infinite $kappa, lambda$, provided at least one is
    nonzero.
  + $kappa^0 = 1$, $kappa^1 = kappa$, $1^kappa = 1$,
    $kappa^(lambda + mu) = kappa^lambda dot kappa^mu$,
    $(kappa^lambda)^mu = kappa^(lambda dot mu)$.
] <prop:cardinal-arithmetic-laws>

#theorem(name: "Cantor's Diagonal Argument for $2^aleph_0$")[
  $|bb(R)| = 2^(aleph_0)$, and $aleph_0 < 2^(aleph_0)$.
] <thm:continuum>

#proof[
  Identify $bb(R)$ with $scr(P)(bb(N))$ via characteristic functions
  (mod countable/finite adjustments). Then
  $|bb(R)| = |scr(P)(bb(N))| = 2^(aleph_0)$. The inequality
  $aleph_0 < 2^(aleph_0)$ is #link(<thm:cantor>)[Cantor's Theorem].
]

#definition(name: "Continuum Hypothesis")[
  The *Continuum Hypothesis* (CH) is the statement
  $2^(aleph_0) = aleph_1$. The *Generalised Continuum Hypothesis*
  (GCH) is the statement $2^(aleph_kappa) = aleph_(kappa + 1)$ for
  every ordinal $kappa$.
] <def:ch>

#note[
  CH is independent of ZFC (Gödel 1938: $L models dash(C)$; Cohen 1963:
  forcing gives a model of ZFC $+ not("CH")$). Thus CH can neither be
  proved nor disproved within ZFC.
]

== The Canonical Well-Ordering of $alpha times alpha$

#theorem(name: "Canonical Well-Ordering of $alpha times alpha$")[
  For every ordinal $alpha$, there is a well-ordering $prec$ of
  $alpha times alpha$ such that for any $beta < alpha$, the initial
  segment determined by $(beta, beta)$ has cardinality less than
  $max(|beta|, aleph_0)$. In particular, $|alpha times alpha| =
  |alpha|$ for every infinite ordinal $alpha$.
] <thm:canonical-well-ordering>

#proof[
  Order pairs $(gamma, delta) in alpha times alpha$ by *max first*:
  $(gamma_1, delta_1) prec (gamma_2, delta_2)$ if
  $max(gamma_1, delta_1) < max(gamma_2, delta_2)$, or the maxima are
  equal and $gamma_1 < gamma_2$, or both equal and $delta_1 < delta_2$.
  The initial segment below $(beta, beta)$ is contained in
  $(beta + 1) times (beta + 1)$, which has cardinality at most
  $|beta + 1| dot |beta + 1|$. For infinite $beta$ this equals
  $|beta|$ by induction on $beta$. Hence the whole product
  $alpha times alpha$ has cardinality $|alpha|$ for infinite $alpha$.
]

#corollary(name: "Cardinal Multiplication is Idempotent")[
  For every infinite cardinal $kappa$, $kappa dot kappa = kappa$.
  Consequently, $kappa + kappa = kappa$ and $kappa dot lambda =
  max(kappa, lambda)$ for infinite $kappa, lambda$ with $lambda != 0$.
] <cor:cardinal-idempotent>

== Cofinality

#definition(name: "Cofinality")[
  Let $alpha$ be an ordinal. A subset $C subset.eq alpha$ is
  *cofinal* in $alpha$ if for every $beta < alpha$ there exists
  $gamma in C$ with $beta <= gamma$. The *cofinality* of $alpha$,
  written $"cf"(alpha)$, is the least ordinal $kappa$ such that $alpha$
  has a cofinal subset of order type $kappa$.
] <def:cofinality>

#definition(name: "Regular and Singular Cardinals")[
  An infinite cardinal $kappa$ is *regular* if $"cf"(kappa) = kappa$,
  and *singular* otherwise.
] <def:regular-singular>

#property(name: "Basic Properties of Cofinality")[
  + $"cf"(alpha) <= alpha$ for every ordinal $alpha$.
  + $"cf"("cf"(alpha)) = "cf"(alpha)$; in particular $"cf"(alpha)$ is
    always a regular cardinal.
  + $aleph_0$ is regular.
  + $"cf"(aleph_omega) = aleph_0$ (since
    $aleph_omega = sup_n aleph_n$), so $aleph_omega$ is singular.
  + For every cardinal $kappa$, $"cf"(2^kappa) > kappa$. In
    particular $"cf"(2^(aleph_0)) > aleph_0$.
] <prop:cofinality-facts>

#theorem(name: "König's Theorem")[
  Let ${kappa_i}_{i in I}$ and ${lambda_i}_{i in I}$ be families of
  cardinals with $kappa_i < lambda_i$ for each $i in I$. Then
  $
    sum_(i in I) kappa_i < product_(i in I) lambda_i.
  $
] <thm:konig>

#corollary(name: "Cofinality of $2^aleph_0$")[
  $"cf"(2^(aleph_0)) > aleph_0$.
] <cor:cf-continuum>

#note[
  König's Theorem is the cardinal analogue of Cantor's diagonal
  argument and is the key tool for proving lower bounds on
  cofinalities of power sets.
]

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
=== Classification of Point Sets
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

=== Open Set Construction
#lemma[
  Let $G subset bb(R)$ be non-empty bounded open set, then for all $x_0 in G$, there exists an open interval $(alpha, beta)$ such that

  1. $x_0 in (alpha, beta)$.
  2. $alpha, beta in.not G$.
]

#proof[
  Let $x_0 in G$. Since $G$ is open, there exists an open interval $(a, b) subset G$ such that $x_0 in (a, b)$.

  _Conclusion 1: $x_0 in (alpha, beta)$_

  Let $alpha = sup{x in bb(R) | (x, x_0] subset G}$, $beta = inf{b' in bb(R) | [x_0, b') subset G}$.
  Since $G$ is bounded open set and $alpha, beta$ are defined as supremum and infimum respectively, we have $alpha < x_0 < beta$, i.e., $x_0 in (alpha, beta)$.

  _Conclusion 2: $alpha, beta in.not G$_

  $forall x in (alpha, beta)$, without loss of generality, assume $x < x_0$.
  We have $alpha < (alpha + x)/2 < x_0$ and $x in ((alpha + x)/2, x_0)$. By the definition of $alpha$, we have $((alpha + x)/2, x_0) subset G$, so $x in G$.
  Assume $alpha in G$, there exists $delta > 0$ such that $(alpha - delta, alpha + delta) subset G$, then $(alpha - delta, beta) subset G$, contradicting the definition of $alpha$. Hence $alpha in.not G$.
  Similarly, we can show that $beta in.not G$, which completes the proof.
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
]

#theorem(name: "Open Set Construction Theorem")[
  Every non-empty open set on the real line can be expressed as a countable union of construction intervals.

  Furthermore, every non-empty open set in $bb(R)^n$ can be expressed as a countable union of pairwise disjoint half-open $n$-dimensional cubes.
]<thm:open-set-construction>

#proof[
  _Step 1: Dyadic grid construction._

  For each $k in bb(N)$, define the dyadic grid of level $k$ as the collection of half-open $n$-dimensional cubes:
  $
    Gamma_k = { product_(i=1)^n [m_i 2^(-k), (m_i+1) 2^(-k)) : (m_1, dots, m_n) in bb(Z)^n }.
  $

  Each $Gamma_k$ partitions $bb(R)^n$ into countably many pairwise disjoint half-open cubes of side length $2^(-k)$.

  _Step 2: Selection algorithm._

  Define collections $cal(H)_k$ inductively:

  - Let $cal(H)_0$ be the set of all cubes in $Gamma_0$ that are contained in $G$.

  - For $k >= 1$, let $cal(H)_k$ be the set of all cubes in $Gamma_k$ that are contained in
    $
      G backslash union.big_(i=0)^(k-1) union.big_(J in cal(H)_i) J.
    $

  _Step 3: Countability._

  Each $cal(H)_k$ is countable (since $Gamma_k$ is countable), so the total collection $cal(H) = union.big_(k=0)^(oo) cal(H)_k$ is countable.

  _Step 4: Pairwise disjointness._

  By construction, cubes in different levels are disjoint: if $J in cal(H)_i$ and $J' in cal(H)_j$ with $i < j$, then $J' subset.eq G backslash J$, so $J inter J' = emptyset$. Cubes within the same level are disjoint by the grid property.

  _Step 5: Coverage._

  Let $x in G$. Since $G$ is open, there exists $delta > 0$ such that $B(x; delta) subset.eq G$. The diameter of cubes in $Gamma_k$ is $sqrt(n) 2^(-k) -> 0$ as $k -> oo$. Choose $k$ large enough so that $sqrt(n) 2^(-k) < delta$. Then the unique cube $J in Gamma_k$ containing $x$ satisfies $J subset.eq B(x; delta) subset.eq G$.

  By the selection algorithm, $J$ must belong to some $cal(H)_i$ with $i <= k$ (since it was not already covered by cubes from earlier levels). Hence $x in J subset.eq union.big cal(H)$.

  Therefore $G = union.big_(J in cal(H)) J$.
]

=== $G_delta$ and $F_sigma$ Sets
#definition(name: [$G_delta$ and $F_sigma$ Sets])[
  A subset $E subset bb(R)^n$ is called a *$G_delta$ set* if it can be expressed as a countable intersection of open sets:
  $
    E = inter.big_(n=1)^infinity U_n, quad U_n "open".
  $

  A subset $E subset bb(R)^n$ is called an *$F_sigma$ set* if it can be expressed as a countable union of closed sets:
  $
    E = union.big_(n=1)^infinity F_n, quad F_n "closed".
  $
]

#property[
  + $E$ is a $G_delta$ set if and only if $E^c$ is an $F_sigma$ set.
  + Every Borel set is both a $G_delta$ set and an $F_sigma$ set.
]


#proposition[
  + *Continuity set of a function* Let $G subset bb(R)^n$ be open and $f: G -> bb(R)$ be a function. Then the set of points where $f$ is continuous is a $G_delta$ set (hence a Borel set).
  + *Differentiability set of a continuous function* Let $f: bb(R) -> bb(R)$ be a continuous function. Then the set of points where $f$ is differentiable is a $F_{delta sigma}$ set (a countable intersection of $F_sigma$ sets).
  + *Properties of the limit function of a sequence of continuous functions* Let $f_i: bb(R)^n -> bb(R)$ be continuous functions, $i in bb(N)$, and suppose $lim_(i -> +infinity) f_i(x) = f(x)$ for all $x in bb(R)^n$. Then:
    - If $G subset bb(R)$ is open, then $f^(-1)(G)$ is an $F_sigma$ set;
    - The set of continuity points of $f$ is a dense $G_delta$ set in $bb(R)^n$ (equivalently, the set of discontinuity points $D(f)$ is an $F_sigma$ set with empty interior in $bb(R)^n$).
]


#theorem(name: "Baire Theorem")[
  Let $E subset bb(R)^n$ be an $F_sigma$ set, i.e., $E = union.big_(k=1)^infinity F_k$, where each $F_k$ ($k in bb(N)$) is a closed set.

  If each $F_k$ ($k in bb(N)$) has empty interior, then $E$ also has empty interior.

  Equivalently, if $E$ has non-empty interior, then there exists some $F_{k_0}$ that contains an interior point.
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


#definition(name: "")[ // 类 Cantor 三分集

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
- *#link(<def:cardinal-arithmetic>)[Cardinal Arithmetic]*
- *#link(<def:cardinal-comparison>)[Cardinal Comparison]*
- *#link(<thm:cantor-bernstein>)[Cantor-Bernstein-Schröder Theorem]*
- *#link(<thm:cantor>)[Cantor's Theorem]*
- *#link(<thm:cantor-normal-form>)[Cantor's Normal Form]*
- *#link(<def:ch>)[Continuum Hypothesis]*
- *#link(<def:countable>)[Countable and Uncountable Sets]*
- *#link(<def:cofinality>)[Cofinality]*

== E
- *#link(<def:equinumerosity>)[Equinumerosity and Cardinality]*
- *#link(<def:equivalence-class>)[Equivalence Class]*

== L
- *#link(<def:limit-of-sequence-of-sets>)[Limit of a Sequence of Sets]*

== O
- *#link(<thm:open-set-construction>)[Open Set Construction Theorem]*
- *#link(<def:ordinal>)[Ordinal]*
- *#link(<def:ordinal-addition>)[Ordinal Addition]*
- *#link(<def:ordinal-multiplication>)[Ordinal Multiplication]*
- *#link(<def:ordinal-exponentiation>)[Ordinal Exponentiation]*

== P
- *#link(<def:partition>)[Partition]*
- *#link(<def:poset>)[Poset]*
- *#link(<def:preorder>)[Preordered Set]*

== R
- *#link(<def:regular-singular>)[Regular and Singular Cardinals]*

== Z
- *#link(<thm:zorn>)[Zorn's Lemma]*

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
