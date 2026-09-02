#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Algèbre Abstraite", // 抽象代数
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Algèbre Abstraite", // 抽象代数
  "Violet",
  subtitle: "A notebook for abstract algebra",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This is a notebook for abstract algebra.",
)

#make-outline(depth: 2, title: "Contents")

#part("Group Theory")

= Preliminaries // 预备知识

Abstract algebra studies sets equipped with operations and the maps
between them that preserve those operations. This chapter assembles
the three tools the whole notebook rests on: *binary operations*
(§1.1), the *quotient construction* (§1.2), and *homomorphisms*
(§1.3). Set-theoretic prerequisites — sets, mappings, equivalence
relations — are quoted from the Théorie des Ensembles note rather
than redefined.

== Algebraic Operations // 代数运算

#definition(name: "Binary Operation")[
  A *binary operation* on a set $S$ is a mapping
  $
    mu: S times S -> S, quad (a, b) mapsto mu(a, b).
  $
  Writing $mu(a, b) = a star b$, the defining requirement is
  *closure*: $a star b in S$ for all $a, b in S$. More generally, an
  $n$-ary operation is a mapping $S^n -> S$.
] <def:binary-operation>

Familiar operations: addition and multiplication on $bb(Z)$,
composition of self-maps of a set, vector addition in $bb(R)^n$. In
each case the interesting structure — what makes the operation
usable — is not the bare mapping but the *laws* it satisfies.

#property(name: "Fundamental Operation Laws")[
  A binary operation $star$ on $S$ may satisfy:
  - *associativity*: $(a star b) star c = a star (b star c)$ for all
    $a, b, c in S$;
  - *commutativity*: $a star b = b star a$;
  - for a pair of operations $star, diamond$: the *distributive laws*
    $a star (b diamond c) = (a star b) diamond (a star c)$ and dually.
  Under associativity alone, the generalised product
  $a_1 star a_2 star dots star a_n$ is independent of how parentheses
  are inserted.
] <prop:operation-laws>

*Proof of the generalised associativity.* Induct on $n$. For $n <= 3$
this is the associativity law itself. Let every bracketing of $n >= 4$
factors split as $P star Q$ with $P$ a bracketing of the first $k$
factors and $Q$ one of the last $n - k$, for some $1 <= k <= n - 1$.
By induction both $P = a_1 star dots star a_k$ and
$Q = a_(k+1) star dots star a_n$ are the "clean" products, so every
bracketing equals
$
  (a_1 star dots star a_k) star (a_(k+1) star dots star a_n).
$
It remains to see this value is the same for all $k$; a second
induction moving one factor at a time across the middle $star$, using
the three-factor law, gives the result. ⊙

The distributive laws involve two operations at once and will be
decisive for rings (Chapter 8); here we only record their form.

#definition(name: "Identity and Inverse")[
  Let $star$ be a binary operation on $S$.
  - An element $e in S$ is a *two-sided identity* if
    $e star a = a star e = a$ for all $a in S$. A *left identity*
    satisfies only $e star a = a$, a *right identity* only
    $a star e = a$.
  - If an identity $e$ exists and $a star b = b star a = e$, then $b$
    is an *inverse* of $a$.
] <def:identity-inverse>

#property(name: "Uniqueness of Identity and Inverses")[
  If a left identity $e_L$ and a right identity $e_R$ both exist, then
  $e_L = e_R$; hence a two-sided identity, when it exists, is unique.
  When the identity is unique, so is each inverse: if $b$ and $c$ are
  both inverses of $a$, then $b = c$.
] <prop:operation-laws-unique>

*Proof.* $e_L = e_L star e_R = e_R$, using that $e_R$ is a right
identity in the first step and $e_L$ a left identity in the second.
For inverses: $b = b star e = b star (a star c) = (b star a) star c =
e star c = c$. ⊙

#example[
  (Reading a Cayley table.) The operation table (*Cayley table*) of
  addition modulo 4 on $S = {0, 1, 2, 3}$:
  #align(center)[
    #table(
      columns: 5,
      align: center,
      stroke: 0.5pt,
      table.header([$+$], [$0$], [$1$], [$2$], [$3$]),
      table.hline(),
      [$0$], [$0$], [$1$], [$2$], [$3$],
      [$1$], [$1$], [$2$], [$3$], [$0$],
      [$2$], [$2$], [$3$], [$0$], [$1$],
      [$3$], [$3$], [$0$], [$1$], [$2$],
    )
  ]
  The table encodes everything at a glance: the row and column
  headings coincide with the entries of the $0$-row and $0$-column,
  revealing $0$ as the identity; each row contains $0$ exactly once,
  reading off inverses ($1^(-1) = 3$, $2^(-1) = 2$); the table is
  symmetric about its diagonal — the operation is commutative.
  Associativity, in contrast, cannot be read off the table: it would
  require $4^3 = 64$ checks. Structural laws beat brute force.
] <ex:cayley-table>

#note[
  (Power notation.) For an associative operation with identity $e$,
  define $a^n$ for $n in bb(Z)^+$ by
  $
    a^1 = a, quad a^(n+1) = a^n star a,
  $
  and $a^0 = e$, $a^(-n) = (a^(-1))^n$ when inverses exist. The
  exponent laws
  $
    a^m star a^n = a^(m+n), quad (a^m)^n = a^(m n)
  $
  follow by induction on $n$. In *additive notation* (the operation
  written $+$) the same quantity is the multiple $n a$, and one never
  writes $a^n$. Mixing the two notations is the standard beginner's
  error; keep them apart from the start. The interplay between powers
  and orders of elements will be central in
  #link(<def:identity-inverse>)[Chapter 2].
] <note:power-notation>

== Equivalence Relations and Quotient Sets // 等价关系与商集

An *equivalence relation* on a set $S$ — reflexive, symmetric,
transitive — was defined in the Théorie des Ensembles note, together
with the general vocabulary of relations and mappings. What algebra
adds is the construction performed with it: *collapsing* a set into
its equivalence classes. This quotient construction, built here in
the purely set-theoretic setting, is the prototype of quotient groups
(Chapter 4), quotient rings (Chapter 9), and quotient modules
(Chapter 17).

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

*Proof.* Reflexivity gives $a in [a]_R$. If $[a]_R = [b]_R$ then
$a in [a]_R = [b]_R$ gives $a R b$; conversely if $a R b$ and $x in
[a]_R$, then $x R a$ and $a R b$ give $x R b$, so $[a]_R subset.eq
[b]_R$, and symmetry reverses the inclusion. The third item follows:
if $x$ lies in both classes, then $a R x$ and $x R b$ force $a R b$,
reducing to the second item. ⊙

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

*Proof.* ($R ==>$ partition) Reflexivity covers $S$
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
and conversely. ⊙

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

#example[
  (Residue classes.) On $bb(Z)$, declare
  $
    a equiv b quad (mod n)
    quad <=> quad n "divides" a - b.
  $
  Reflexivity ($n | 0$), symmetry ($n | a-b ==>$ $n | b-a$) and
  transitivity ($n | a-b, n | b-c ==>$ $n | a-c$) are immediate. The
  class of $a$ is the arithmetic progression
  $[a] = {a + k n | k in bb(Z)}$, and there are exactly $n$ classes:
  $
    bb(Z)_n = {[0], [1], dots, [n-1]},
  $
  since every integer is congruent to its remainder upon division by
  $n$. For $n = 4$: $[0] = {dots, -8, -4, 0, 4, 8, dots}$,
  $[1] = {dots, -7, -3, 1, 5, dots}$, and so on.
] <ex:residue-classes>

The quotient set $bb(Z)_n$ begs for arithmetic: surely
$[a] + [b]$ should be $[a + b]$. The request conceals the single most
important technical point in the theory of quotients.

#caution[
  (Well-definedness on quotient sets.) A formula
  $[a] star [b] = [a star b]$ does not define an operation on
  $S \/ R$ until it is shown *independent of the chosen
  representatives*: replacing $a$ by $a'$ and $b$ by $b'$ must give
  the same class. For $bb(Z)_n$ this succeeds: $a equiv a'$,
  $b equiv b' (mod n)$ imply $a + b equiv a' + b'$ and
  $a b equiv a' b'$, so addition and multiplication descend to
  $bb(Z)_n$.

  For a general equivalence relation the descent can *fail*. On
  $bb(Z)$ take $a R b "iff" abs(a) = abs(b)$, with classes
  ${0}, {plus.minus 1}, {plus.minus 2}, dots$. Attempting
  $[a] + [b] = [a + b]$ gives, using representatives $1$ and $-1$
  (the same class),
  $
    [1] + [1] = [2], quad quad [-1] + [1] = [0],
  $
  and $[2] != [0]$: the "operation" depends on the representative and
  is therefore *not an operation at all*.

  An equivalence relation compatible with the operations — called a
  *congruence relation* — is exactly what makes quotients inherit
  algebra. This compatibility check will be replayed, with
  growing sophistication, for quotient groups (Chapter 4) and
  quotient rings (Chapter 9).
] <caution:well-defined-operations>

== Homomorphisms and Isomorphisms // 同态与同构

Mappings between sets were the business of the Théorie des Ensembles
note: injective, surjective, bijective maps and their composition.
Algebra asks the first structural question about a map: *does it
respect the operations?* A map that does is the algebraic notion of
"sameness-preserving assignment", and everything in this notebook —
from Cayley's theorem to Galois theory — is a study of such maps.

#definition(name: "Homomorphism")[
  Let $(S, star)$ and $(T, diamond)$ be algebraic systems, each
  equipped with one binary operation. A mapping $f: S -> T$ is a
  *homomorphism* if it preserves the operation:
  $
    f(a star b) = f(a) diamond f(b) quad quad "for all" a, b in S.
  $
  A homomorphism that is bijective is called an *isomorphism*; two
  systems between which an isomorphism exists are *isomorphic*,
  written $S equiv T$.
] <def:homomorphism>

#property(name: "Homomorphisms Preserve Identity and Inverses")[
  Let $f: (S, star) -> (T, diamond)$ be a *surjective* homomorphism,
  where both operations have identities $e$ and $e'$. Then
  $
    f(e) = e',
  $
  and for any $a in S$ possessing an inverse $a^(-1)$ in $S$, the
  element $f(a)$ possesses an inverse in $T$, namely
  $
    f(a)^(-1) = f(a^(-1)).
  $
] <prop:homomorphism-properties>

*Proof.* For any $y in T$, surjectivity gives $y = f(a)$ for some
$a in S$, and
$
  f(e) diamond y = f(e) diamond f(a) = f(e star a) = f(a) = y,
$
so $f(e)$ is a left identity of $T$; dually it is a right identity.
By #link(<prop:operation-laws-unique>)[uniqueness of the identity],
$f(e) = e'$. For inverses:
$
  f(a^(-1)) diamond f(a) = f(a^(-1) star a) = f(e) = e',
  quad quad f(a) diamond f(a^(-1)) = e',
$
so $f(a^(-1))$ is an inverse of $f(a)$. ⊙

Surjectivity is essential in the first part: without it $f(e)$ is
merely an idempotent of $T$, not the identity. (For homomorphisms of
groups, where inverses exist for *every* element, the image $f(S)$
carries the induced operation and $f(e) = e'$ holds inside $f(S)$
regardless — this will be systematised in
#link(<note:kernel-preliminary>)[Chapter 5].)

#example[
  (Two isomorphisms.)
  - $f: (bb(Z), +) -> (2 bb(Z), +)$, $f(n) = 2 n$: bijective, and
    $f(m + n) = 2(m + n) = 2m + 2n = f(m) + f(n)$. The even integers,
    with addition, are an algebraic copy of the integers — they are
    "the same" additive system.
  - Let $U_4 = {1, i, -1, -i}$ under multiplication. The map
    $f: bb(Z)_4 -> U_4$, $f([k]) = i^k$ is well defined (if
    $k equiv k' mod 4$ then $i^k = i^(k')$) and satisfies
    $f([k] + [l]) = i^(k+l) = i^k i^l = f([k]) f([l])$; it is
    bijective. So the residue-class addition of
    #link(<ex:residue-classes>)[Example 1.4] is, structurally,
    rotation of the square.
] <ex:isomorphic-examples>

#note[
  (The kernel, a first look.) For a homomorphism $f: (S, star) ->
  (T, diamond)$ where both systems have identities $e, e'$ and
  inverses, the *kernel* of $f$ is
  $
    "ker" f = {a in S | f(a) = e'}.
  $
  It measures the collapse $f$ performs. In particular, a homomorphism
  of such systems is injective exactly when $"ker" f$ is trivial:
  $f(a) = f(b)$ implies $f(a star b^(-1)) = e'$, so $a star b^(-1) in
  "ker" f$; if the kernel holds only $e$, then $a = b$. The kernel
  turns out to be not merely a subset but a substructure of a very
  special kind — normal subgroup (Chapter 5), ideal (Chapter 9) — and
  the homomorphism theorems of Chapters 5 and 9, the first great
  structure theorems of this subject, are precisely the statement
  that $S$ is built from $"ker" f$ and the image $f(S)$.
] <note:kernel-preliminary>

A closing remark situates the chapter. We now possess: objects with
operations (§1.1), a method for constructing new objects by
identifying elements (§1.2), and the arrows between objects that
preserve structure (§1.3). The axiomatic selection of the most
important class of objects — associative operation, identity, all
inverses — is the definition of a group, and it is where
#link(<def:binary-operation>)[Chapter 2] begins.

// ==========================================================================
// Chapter 2: 群的定义与基本性质
// ==========================================================================

= Definition and Basic Properties of Groups // 群的定义与基本性质

Chapter 1 assembled the toolkit: sets with operations (§1.1), the
quotient construction (§1.2), and structure-preserving maps (§1.3).
We now make the axiomatic selection promised there. Among all binary
operations we ask for the least that must be demanded so that
computation becomes reliable: that products can be rebracketed at
will (*associativity*), that there is a neutral element to measure
against (*identity*), and that every element can be undone
(*inverses*). The answer is the definition of a *group* — and the
rest of this notebook studies how much structure these three axioms
buy.

#definition(name: "Group")[
  A *group* is a set $G$ equipped with a binary operation $star$
  satisfying:
  - (G1) *associativity*: $(a star b) star c = a star (b star c)$
    for all $a, b, c in G$;
  - (G2) *identity*: there exists $e in G$ with
    $e star a = a star e = a$ for all $a in G$;
  - (G3) *inverses*: for every $a in G$ there exists $a^(-1) in G$
    with $a star a^(-1) = a^(-1) star a = e$.

  Strictly the group is the pair $(G, star)$; the operation is
  suppressed in the notation when no confusion is possible. Axioms
  (G2) and (G3) are the two-sided versions of the laws isolated in
  #link(<def:identity-inverse>)[Chapter 1], with associativity
  borrowed from #link(<prop:operation-laws>)[the fundamental laws].
] <def:group>

#definition(name: "Abelian Group")[
  A group whose operation is commutative — $a star b = b star a$
  for all $a, b in G$ — is called *abelian* (or *commutative*),
  after N. H. Abel.
] <def:abelian-group>

#note[
  (Notation.) In *multiplicative notation* the operation is written
  as juxtaposition, $a star b = a b$, the identity as $e$ (or $1$),
  and the inverse as $a^(-1)$; powers $a^n$ follow the rules of
  #link(<note:power-notation>)[Chapter 1]. In *additive notation*
  the operation is $+$, the identity is $0$, the inverse of $a$ is
  $-a$, and one writes the multiple $n a$ instead of the power
  $a^n$. Additive notation is reserved for abelian groups;
  multiplicative notation serves in general. The promise made in
  #link(<note:power-notation>)[Chapter 1] — that the interplay of
  powers and orders would become central — is redeemed in §2.3,
  where the *order* of an element is defined through powers.
] <note:notation-convention>

A natural suspicion: are the axioms perhaps redundant — does one of
them follow from the others, or can the two-sidedness requirements
be halved? The equivalence at the heart of the definition is the
following.

#theorem(name: "Equivalent Axioms for Groups")[
  Let $G$ be a non-empty set with an associative binary operation.
  Suppose there exists a *left identity*: an element $e$ with
  $e a = a$ for all $a in G$; and suppose each $a in G$ has a *left
  inverse*: an element $a'$ with $a' a = e$. Then $G$ is a group.
] <thm:group-equivalent-axioms>

*Proof.* First we upgrade the left inverse of $a$ to a two-sided
one. Let $a''$ be a left inverse of $a'$, which exists by
hypothesis. Then
$
  a a' = e (a a') = (a'' a') (a a') = a'' ((a' a) a') = a'' (e a')
  = a'' a' = e,
$
each step justified in turn by the left identity $e$, the choice of
$a''$, associativity, $a' a = e$, $e a' = a'$, and $a'' a' = e$. So
$a'$ is also a *right* inverse of $a$. Now the left identity becomes
two-sided as well:
$
  a e = a (a' a) = (a a') a = e a = a,
$
using $e = a' a$, associativity, the identity $a a' = e$ just
proved, and the left identity property. Both one-sided conditions
have thus been upgraded to two-sided ones, and (G1)–(G3) hold. ⊙

Note the division of labour inside the proof: each upgrade uses
*both* one-sided conditions. Neither condition alone suffices — see
#link(<ex:non-groups>)[the right-zero operation] in §2.2.

#corollary(name: "Uniqueness Inside a Group")[
  In a group the identity is unique and each element has exactly one
  inverse. Conversely, any solution of $a b = e$ is already the
  inverse of $a$: $b a = e$ follows.
] <cor:group-identity-uniqueness>

*Proof.* In a group (G2) supplies an identity that the theorem just
proved makes two-sided, and uniqueness of a two-sided identity —
hence of each inverse — is
#link(<prop:operation-laws-unique>)[Chapter 1]. For the converse,
suppose $a b = e$. Then
$
  b = e b = (a^(-1) a) b = a^(-1) (a b) = a^(-1) e = a^(-1),
$
using (G3) in the second step and the hypothesis $a b = e$ in the
third. Hence $b a = a^(-1) a = e$, as claimed. ⊙

== Typical Examples // 典型例子

Definitions earn their keep through examples. We build a stock that
will serve the whole notebook, checking the axioms in each case; a
run of deliberate near-misses at the end shows which axiom does
which work.

#example[
  (Elementary groups.) The sets $bb(Z)$, $bb(Q)$, $bb(R)$ under
  addition are abelian groups: closure and associativity are
  inherited from arithmetic, $0$ is the identity, and $-a$ inverts
  $a$. The non-zero rationals and reals under multiplication,
  $(bb(Q)^*, dot)$ and $(bb(R)^*, dot)$, are abelian groups with
  identity $1$ and inverse $1 \/ a$. Note the exclusion of $0$: it
  has no multiplicative inverse, so the full structures
  $(bb(Q), dot)$ fail (G3).
] <ex:elementary-groups>

#example[
  (Residue classes form a group.) Take $bb(Z)_n$ with the addition
  defined in #link(<caution:well-defined-operations>)[Chapter 1] —
  the well-definedness check made there is precisely what allows us
  to speak of an operation at all. The axioms lift from $bb(Z)$:
  $([a] + [b]) + [c] = [a + b + c] = [a] + ([b] + [c])$, the class
  $[0]$ acts as identity, and $[-a]$ inverts $[a]$. The result is an
  abelian group $(bb(Z)_n, +)$ of order $n$ — the Cayley table of
  $(bb(Z)_4, +)$ appeared in #link(<ex:cayley-table>)[Chapter 1].
] <ex:residue-group>

#definition(name: "Symmetric Group")[
  Let $X$ be a set. A *permutation* of $X$ is a bijection
  $sigma: X -> X$. Under composition the permutations of $X$ form a
  group: the composite of bijections is a bijection, composition of
  mappings is associative (a fact of the Théorie des Ensembles
  note), the identity map is neutral, and a bijection has an inverse
  bijection. For $X = {1, 2, dots, n}$ this group is the *symmetric
  group* $S_n$; its order is $n!$, since a bijection on $n$ points
  is determined by choosing, in succession, the images of
  $1, dots, n$.
] <def:symmetric-group>

#note[
  (Cycle notation.) A permutation is written in *cycle notation*:
  $(1 2 3)$ denotes the map $1 -> 2$, $2 -> 3$, $3 -> 1$ — each
  entry mapped to the next, the last wrapping around to the first —
  and $(1 2)$ denotes a *transposition*, swapping $1$ and $2$ while
  fixing all other points. Products are read right to left:
  $sigma tau$ means "apply $tau$ first, then $sigma$". Fixed points
  are omitted, so $(1 2)$ and $(1 2)(3)$ are the same permutation.
] <note:cycle-notation>

#example[
  (The smallest non-abelian group.) $S_3$ has six elements:
  $
    e, quad (1 2 3), quad (1 3 2), quad (1 2), quad (1 3), quad (2 3).
  $
  Each transposition is its own inverse and the two 3-cycles are
  inverse to each other, so every element has order at most $3$.
  Composition is not commutative:
  $
    (1 2)(2 3) = (1 2 3), quad quad (2 3)(1 2) = (1 3 2),
  $
  as one checks by following each point through the right factor
  first. Thus $S_3$ is a non-abelian group of order $6$ — indeed the
  smallest possible, a fact that will drop out of the classification
  of groups of small order in Chapter 3.
] <ex:s3-details>

#definition(name: "Dihedral Group")[
  Let $n >= 3$. The *dihedral group* $D_n$ is the group of symmetry
  transformations of the regular $n$-gon: the $n$ rotations and $n$
  reflections that preserve the polygon, composed as mappings of the
  plane. Writing $r$ for the rotation through $(2 pi) \/ n$ and $s$
  for one fixed reflection, every element is uniquely $r^k$ or
  $r^k s$ with $0 <= k <= n - 1$, so $abs(D_n) = 2 n$, and the two
  generators satisfy
  $
    r^n = e, quad quad s^2 = e, quad quad s r = r^(-1) s.
  $
  The last relation shows $s r != r s$ as soon as $r != r^(-1)$,
  that is, $n >= 3$: dihedral groups are non-abelian.
] <def:dihedral-group>

#definition(name: "General and Special Linear Groups")[
  Let $F$ be a field — for the time being, $bb(Q)$ or $bb(R)$
  suffices. The *general linear group* $"GL"_n(F)$ is the set of
  invertible $n times n$ matrices over $F$ under matrix
  multiplication: the product of invertible matrices is invertible,
  matrix multiplication is associative, the identity matrix $I$ is
  neutral, and every invertible matrix has its inverse matrix — the
  axioms are exactly linear algebra. The *special linear group*
  $"SL"_n(F)$ consists of the matrices of determinant $1$; it is a
  group in its own right, since products and inverses of
  determinant-$1$ matrices again have determinant $1$. For $n >= 2$
  these groups are non-abelian.
] <def:general-linear-group>

#example[
  (The quaternion group.) Let
  $Q_8 = {plus.minus 1, plus.minus i, plus.minus j, plus.minus k}$
  with multiplication determined by
  $
    i^2 = j^2 = k^2 = -1, quad i j = k, quad j k = i, quad k i = j,
  $
  and the products in reversed order carrying a minus sign:
  $j i = -k$, $k j = -i$, $i k = -j$. One checks that $1$ is the
  identity, $-1$ commutes with everything and squares to $1$, and
  each of $plus.minus i$, $plus.minus j$, $plus.minus k$ has order
  $4$; so $abs(Q_8) = 8$. The group is non-abelian
  ($i j = k != -k = j i$), yet all of its proper subgroups are
  cyclic — a small group with a rich structure to which Chapter 7
  will return.
] <ex:quaternion-group>

#example[
  (Near-misses: why each axiom is needed.)
  - $(bb(N), +)$ is closed and associative with identity $0$, but no
    positive number has an inverse: (G3) fails, everything else
    holds.
  - $(bb(Z), -)$ with $a star b = a - b$ is closed, but not
    associative ($(1 - 2) - 3 = -4$ while $1 - (2 - 3) = 2$) and
    without identity: (G1) and (G2) fail.
  - $(bb(R), dot)$ has identity $1$ and inverses of every $a != 0$,
    but $0$ has none. Deleting $0$ repairs the structure — the
    identity must be invertible *for every element*, with no
    exceptions.
  - On any set with at least two elements define the *right zero*
    operation $x star y = y$. Then $star$ is associative:
    $(x star y) star z = z = x star (y star z)$. Every element is a
    *left* identity ($e star y = y$ for all $e$), yet no right
    identity exists ($x star e = e != x$), and no element has a left
    inverse. A group fails for want of the right-handed half of the
    axioms — compare #link(<thm:group-equivalent-axioms>)[the
      equivalent axioms], where the two *left-handed* conditions, held
    *simultaneously*, do suffice.
] <ex:non-groups>

The stock is complete: abelian specimens ($(bb(Z), +)$,
$(bb(Z)_n, +)$), non-abelian ones ($S_3$, $D_n$, $"GL"_n(F)$,
$Q_8$), and structures dismissed at each axiom in turn. What do the
axioms buy once admitted? The next section collects the first
dividends — all of them free, none requiring extra hypotheses.

== Basic Properties of Groups // 群的基本性质

The axioms look modest; their first dividends follow. Everything in
this section is obtained by multiplying on the left or on the right
by a well-chosen inverse — the two moves that a semigroup cannot
make.

#property(name: "Basic Consequences of the Axioms")[
  Let $G$ be a group and $a, b, c in G$.
  + *Cancellation*: $a b = a c$ implies $b = c$, and
    $b a = c a$ implies $b = c$.
  + *Unique solutions*: the equation $a x = b$ has the unique
    solution $x = a^(-1) b$; the equation $y a = b$ has the unique
    solution $y = b a^(-1)$.
  + *Double inverse*: $(a^(-1))^(-1) = a$.
  + *Socks and shoes*: $(a b)^(-1) = b^(-1) a^(-1)$. In an abelian
    group the order may be swapped: $(a b)^(-1) = a^(-1) b^(-1)$.
] <prop:group-basic-properties>

*Proof.* (1) Multiply $a b = a c$ by $a^(-1)$ on the left:
$(a^(-1) a) b = (a^(-1) a) c$ gives $e b = e c$, that is, $b = c$;
the right-sided version multiplies on the right. (2) The element
$x_0 = a^(-1) b$ solves $a x = b$, since
$a x_0 = (a a^(-1)) b = e b = b$; if $x$ is any solution then
$a x = a x_0$ and cancellation in (1) gives $x = x_0$. Symmetrically
for $y a = b$. (3) By (G3), $a^(-1) a = e$ and $a a^(-1) = e$: so
*both* $a$ and $(a^(-1))^(-1)$ are inverses of $a^(-1)$, and
inverses are unique by #link(<cor:group-identity-uniqueness>)[the
  corollary above]. (4) $(b^(-1) a^(-1)) (a b) = b^(-1) (a^(-1) a) b
= b^(-1) b = e$ and dually $(a b) (b^(-1) a^(-1)) = e$, so
$b^(-1) a^(-1)$ is the inverse of $a b$; in the abelian case
$b^(-1) a^(-1) = a^(-1) b^(-1)$ outright. ⊙

The name of (4): to undo "$a$ then $b$" one removes $b$ first, then
$a$ — socks before shoes. Two warnings worth fixing early. First,
*cancellation* is a group phenomenon: $(bb(N), +)$ cannot cancel
subtraction because inverses are missing. Second, $(a b)^(-1) =
b^(-1) a^(-1)$ *reverses* the order — forgetting the reversal is
the standard slip, and the abelian shortcut above is a privilege,
not a right.

== The Order of an Element // 元素的阶

Powers $a^n$ were defined for any associative operation in
#link(<note:power-notation>)[Chapter 1] — with a promise attached.
The group axioms make every power well behaved, and the following
notion cashes the promise.

#definition(name: "Order of an Element")[
  Let $G$ be a group and $a in G$. If some positive power of $a$
  equals $e$, the smallest such exponent is the *order* of $a$,
  written $"ord"(a)$; in this case $a$ has *finite order*. If
  $a^n != e$ for every $n in bb(Z)^+$, then $a$ has *infinite
  order*, written $"ord"(a) = infinity$: all powers $a^n$ with
  $n in bb(Z)$ are then distinct.
] <def:order-element>

#example[
  (Orders at a glance.) In $(bb(Z)_4, +)$:
  $"ord"([1]) = 4$, $"ord"([2]) = 2$ (since $2 [2] = [4] = [0]$),
  $"ord"([0]) = 1$. In $S_3$
  (#link(<ex:s3-details>)[§2.2]): every transposition has order $2$,
  the 3-cycles have order $3$, and $e$ has order $1$. In
  $(bb(Z), +)$ the element $1$ has infinite order, as does every
  non-zero integer.
] <ex:element-orders>

#property(name: "Powers Wrap Around")[
  Let $G$ be a group and $a in G$ an element of finite order $n =
  "ord"(a)$. Then:
  - $a^m = e$ if and only if $n$ divides $m$;
  - $a^m = a^k$ if and only if $m equiv k (mod n)$;
  - the set of powers $⟨a⟩ = {a^k | k in bb(Z)}$ — which Chapter 3
    will recognise as a *subgroup* — has exactly $n$ elements:
    $⟨a⟩ = {e, a, a^2, dots, a^(n-1)}$, and in particular
    $abs(⟨a⟩) = n = "ord"(a)$.
] <prop:order-properties>

*Proof.* Divide with remainder: every integer $m$ writes uniquely as
$m = q n + r$ with $0 <= r <= n - 1$, and
$
  a^m = a^(q n + r) = (a^n)^q a^r = e^q a^r = a^r.
$
So $a^m = e$ exactly when $a^r = e$, which by minimality of $n$
happens exactly when $r = 0$ — that is, when $n$ divides $m$. The
second item follows by subtraction: $a^m = a^k$ holds exactly when
$a^(m - k) = e$, i.e. $n | m - k$, i.e. $m equiv k (mod n)$. For the
third item: by the division step every power $a^m$ lands in
${a^0, dots, a^(n-1)}$, and these $n$ powers are distinct — if
$a^i = a^j$ with $0 <= i < j <= n - 1$, the second item would force
$n | j - i$, impossible for $0 < j - i < n$. ⊙

The wrap-around phenomenon is the algebraic shadow of a clock:
after $n$ steps the walk returns to its start, and only the
remainder of the step count matters.

#definition(name: "Order of a Group")[
  The *order* of a group $G$ is the number of its elements, written
  $abs(G)$ — a cardinal, for infinite groups, in the sense of the
  Théorie des Ensembles note. The group is *finite* if $abs(G)$ is
  finite. Do not confuse the two orders: the order of a *group*
  counts elements, the order of an *element* measures powers. They
  meet in the cyclic world of §2.4, where
  $abs(⟨a⟩) = "ord"(a)$.
] <def:order-group>

== Cyclic Groups // 循环群

We have met, repeatedly, groups in which every element is a power of
a single element: $(bb(Z), +)$ is generated by $1$, $(bb(Z)_n, +)$
by $[1]$, and $⟨a⟩$ of #link(<prop:order-properties>)[§2.3] is built
from its own namesake. The phenomenon deserves a name, for these
groups admit a complete classification — the first structure theorem
of this notebook.

#note[
  (Subgroups, a working definition.) A non-empty subset $H$ of a
  group $G$ is a *subgroup* if it is closed under the operation and
  under inverses: $h_1 h_2 in H$ and $h^(-1) in H$ whenever
  $h_1, h_2, h in H$. A subgroup is itself a group under the
  restricted operation — the axioms restrict for free. The formal
  definition and the subgroup criteria belong to Chapter 3; this
  working notion suffices here. Note at once that for any $a$ the
  power set $⟨a⟩ = {a^k | k in bb(Z)}$ is a subgroup:
  $a^j a^k = a^(j+k) in ⟨a⟩$ and $(a^j)^(-1) = a^(-j) in ⟨a⟩$.
] <note:subgroup-preview>

#definition(name: "Cyclic Group")[
  A group $G$ is *cyclic* if $G = ⟨g⟩$ for some $g in G$ — that is,
  every element of $G$ is a power $g^k$ with $k in bb(Z)$. The
  element $g$ is then a *generator* of $G$, and one writes
  $G = ⟨g⟩$.
] <def:cyclic-group>

#corollary(name: "Cyclic Implies Abelian")[
  Every cyclic group is abelian.
] <cor:cyclic-abelian>

*Proof.* Any two elements are $g^j$ and $g^k$, and
$g^j g^k = g^(j+k) = g^(k+j) = g^k g^j$. ⊙

#theorem(name: "Classification of Cyclic Groups")[
  Let $G = ⟨g⟩$ be a cyclic group.
  - If $g$ has infinite order, then $G$ is isomorphic to
    $(bb(Z), +)$, via the map $g^k arrow.r.double k$.
  - If $"ord"(g) = n < infinity$, then $abs(G) = n$ and $G$ is
    isomorphic to $(bb(Z)_n, +)$, via the map $g^k arrow.r.double
    [k]$.

  Consequently, up to isomorphism there is exactly one cyclic group
  of each order: the infinite one $(bb(Z), +)$, and, for each
  $n >= 1$, the group $(bb(Z)_n, +)$.
] <thm:cyclic-classification>

*Proof.* *Infinite case.* Define $phi: bb(Z) -> G$ by $phi(k) =
g^k$. Surjectivity is the very definition of $G = ⟨g⟩$, and $phi$
preserves the operations: $phi(j + k) = g^(j+k) = g^j g^k = phi(j)
phi(k)$. Injectivity: if $g^j = g^k$ with $j > k$, then $g^(j-k) = e$
with the *positive* exponent $j - k$, contradicting infinite order.
A bijective operation-preserving map is an isomorphism
(#link(<def:homomorphism>)[Chapter 1]).

*Finite case.* Since $g^n = e$ by the definition of order, the
division step in #link(<prop:order-properties>)[§2.3] gives
$⟨g⟩ = {e, g, dots, g^(n-1)}$ with these $n$ elements distinct;
hence $abs(G) = n$. Define $psi: bb(Z)_n -> G$ by $psi([k]) = g^k$.
*Well-definedness*: if $[j] = [k]$ then $n | j - k$, so $g^(j-k) = e$
and $g^j = g^k$ — exactly the compatibility pattern of
#link(<caution:well-defined-operations>)[Chapter 1], the congruence
relation on exponents being tailored to the powers of $g$. The map
preserves addition, $psi([j] + [k]) = g^(j+k) = psi([j]) psi([k])$,
and is surjective by $G = ⟨g⟩$; since both sides have $n$ elements,
surjectivity forces bijectivity. ⊙

The isomorphism $bb(Z)_4 ≅ U_4$ computed in
#link(<ex:isomorphic-examples>)[Chapter 1] is precisely the case
$n = 4$ of the theorem; the theorem says such luck is *systematic*.

#corollary(name: "Element Orders Divide the Group Order")[
  Let $G = ⟨g⟩$ be cyclic of finite order $n$, and let $a = g^k$ be
  any element of $G$. Then
  $
    "ord"(a) = n \/ ("gcd"(n, k)),
  $
  which in particular divides $n$. (That element orders divide the
  group order in *every* finite group is Lagrange's theorem,
  Chapter 3; in the cyclic world it already falls out here.)
] <cor:order-divides>

*Proof.* By #link(<prop:order-properties>)[§2.3], $a^m = g^(k m) = e$
holds exactly when $n | k m$. Write $d = "gcd"(n, k)$, so $n = d n'$
and $k = d k'$ with $"gcd"(n', k') = 1$; then $n | k m$ unfolds to
$d n' | d k' m$, i.e. $n' | k' m$, i.e. $n' | m$ since $n', k'$ are
coprime. The smallest positive such $m$ is $n'$, so
$"ord"(a) = n' = n \/ d$, which divides $n = d n'$. ⊙

#corollary(name: "Generators of a Finite Cyclic Group")[
  In a cyclic group $G = ⟨g⟩$ of order $n$, the element $g^k$ is a
  generator of $G$ if and only if $"gcd"(n, k) = 1$. Hence $G$ has
  exactly $phi(n)$ generators, where $phi$ is Euler's totient
  function, counting the integers in ${0, 1, dots, n - 1}$ coprime
  to $n$. For instance, $(bb(Z)_6, +)$ has generators $[1]$ and
  $[5]$.
] <cor:cyclic-generators>

*Proof.* $g^k$ generates $G$ exactly when $⟨g^k⟩ = G$, i.e. when
$abs(⟨g^k⟩) = n$; by #link(<cor:order-divides>)[the corollary above],
$abs(⟨g^k⟩) = "ord"(g^k) = n \/ ("gcd"(n, k))$, which equals $n$
exactly when $"gcd"(n, k) = 1$. The count of such exponents $k$ in
${0, 1, dots, n - 1}$ is $phi(n)$ by definition. ⊙

#theorem(name: "Subgroups of Cyclic Groups")[
  Let $G = ⟨g⟩$ be a cyclic group.
  - Every subgroup of $G$ is cyclic.
  - If $abs(G) = n$ is finite, then for every positive divisor $d$
    of $n$ there is exactly one subgroup of order $d$, namely
    $⟨g^(n \/ d)⟩$; there are no other subgroups.
] <thm:cyclic-subgroups>

*Proof.* (1) Let $H$ be a subgroup of $G = ⟨g⟩$. If $H = {e}$, then
$H = ⟨e⟩$ is cyclic. Otherwise $H$ contains $g^m$ with $m != 0$;
since also $(g^m)^(-1) = g^(-m) in H$, we may choose $m$ *positive*,
and choose it minimal among the positive exponents with $g^m in H$.
Every element of $H$ is some $g^k$; write $k = q m + r$ with
$0 <= r < m$. Then
$
  g^r = g^(k - q m) = g^k (g^m)^(-q) in H,
$
and the minimality of $m$ forces $r = 0$. Hence every $g^k in H$
equals $(g^m)^q$, so $H subset.eq ⟨g^m⟩$; the reverse inclusion is
trivial, and $H = ⟨g^m⟩$ is cyclic.

(2) *Existence.* Let $d | n$. The element $g^(n \/ d)$ has order
$n \/ ("gcd"(n, n \/ d)) = n \/ (n \/ d) = d$, where
$"gcd"(n, n \/ d) = n \/ d$ because $d | n$; so $⟨g^(n \/ d)⟩$ is a
subgroup of order $d$.

*Uniqueness.* Let $H$ be any subgroup of order $d$. By (1),
$H = ⟨g^m⟩$ for some $m$ with $"ord"(g^m) = d$, i.e.
$n \/ ("gcd"(n, m)) = d$, i.e. $"gcd"(n, m) = n \/ d$. Then
$(n \/ d) | m$, so $g^m$ is a power of $g^(n \/ d)$ and
$H subset.eq ⟨g^(n \/ d)⟩$; both sides have $d$ elements, so they
are equal. ⊙

#figure(
  image("img/cyclic-group-circle.svg", width: 62%),
  caption: [The cyclic group $bb(Z)_6$ drawn as a clock. The six
    classes $[0], dots, [5]$ sit on a circle, and the outer arrows
    are the steps of the generator $[1]$. The subgroup generated by
    $[2]$ — the triangle ${[0], [2], [4]}$ — and the subgroup
    generated by $[3]$ — the diameter ${[0], [3]}$ — appear as
    smaller circuits; their orders $3$ and $2$ divide $6$, as
    #link(<cor:order-divides>)[predicted], and they are the *only*
    proper subgroups, as #link(<thm:cyclic-subgroups>)[the subgroup
      theorem] guarantees.],
  placement: auto,
  supplement: [Fig.],
) <fig:cyclic-circle>

The chapter closes with a tally. We have the axiomatic object (§2.1),
a stocked bestiary from $(bb(Z), +)$ to $Q_8$ (§2.2), the free
cancellations and the two notions of order purchased by the axioms
(§2.3), and the first classification theorem: cyclic groups are
unique up to isomorphism, and their subgroups are laid out by the
divisors of the order (§2.4). The next chapter steps *inside* a
group and studies the subsets it shelters: subgroups and the cosets
they carve out lead to Lagrange's theorem — the first structural
constraint on finite groups, and the tool with which Chapter 3 will
classify groups of small order, delivering the promise of
#link(<ex:s3-details>)[§2.2] that $S_3$ is the smallest non-abelian
group.

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
//
// 主线叙事 (Main Narrative):
// "群论 → 环论 → 域论与伽罗瓦理论 → 模论初步"
// 研究对象从群（单一运算）→ 环（双重运算）→ 域（可除结构）→ 模（环上线性对象），
// 复杂度逐步升级。伽罗瓦理论是群论与域论的汇合点，也是本笔记的高潮。
//
// 职责边界 (Responsibility Boundaries):
// - 集合、映射、等价关系 → Théorie des Ensembles 已有，本笔记仅引用
// - 群/环/域/模的代数理论 → 本笔记核心内容
// - 伽罗瓦理论 → 本笔记（群论与域论的交汇）
//
// 参考教材 (Reference Textbooks):
// - 杨子胥《近世代数》(第三版)
// - 丘维生《抽象代数》
//
// ==========================================================================
// Part I — 群论 (Group Theory)
// ==========================================================================
// 设计思路：从代数运算的公理化视角出发，建立群的完整理论。
// Part I 覆盖群论从基本定义到结构定理的全部内容，
// 以有限生成Abel群的结构定理作为群论的总结。
// 对应教材：杨子胥 第一章–第二章；丘维生 第一章
//
// --- Chapter 1: 预备知识 (Preliminaries) ---

//   Section 1.1: 代数运算 (Algebraic Operations)
//     - 二元运算的定义与性质（结合律、交换律）
//     - 单位元与逆元
//     - 运算表 (Cayley 表)

//   Section 1.2: 等价关系与商集 (Equivalence Relations and Quotient Sets)
//     - 等价关系与等价类（引用 Théorie des Ensembles）
//     - 商集的定义
//     - 同余关系 (Congruence Relations)

//   Section 1.3: 同态与同构 (Homomorphisms and Isomorphisms)
//     - 代数系统间的同态映射
//     - 同构的概念与意义
//     - 同态核的初步概念

// --- Chapter 2: 群的定义与基本性质 (Definition and Basic Properties of Groups) ---

//   Section 2.1: 群的定义 (Definition of Groups)
//     - 群的四条公理（封闭性、结合律、单位元、逆元）
//     - 交换群 (Abel 群)
//     - 群的等价定义方式

//   Section 2.2: 典型例子 (Typical Examples)
//     - 整数加法群、模 n 剩余类群
//     - 对称群 $S_n$
//     - 二面体群 $D_n$
//     - 一般线性群 $GL_n(F)$、特殊线性群 $SL_n(F)$
//     - 四元数群 $Q_8$

//   Section 2.3: 群的基本性质 (Basic Properties of Groups)
//     - 消去律
//     - 元素的阶 (Order of an Element)
//     - 群的阶 (Order of a Group)

//   Section 2.4: 循环群 (Cyclic Groups)
//     - 循环群的定义与基本性质
//     - 无限循环群同构于 $\bb(Z)$
//     - 有限循环群同构于 $\bb(Z)_n$
//     - 循环群的子群结构

// --- Chapter 3: 子群、陪集与拉格朗日定理 (Subgroups, Cosets, and Lagrange's Theorem) ---

//   Section 3.1: 子群 (Subgroups)
//     - 子群的定义与判定定理
//     - 子群生成的概念
//     - 子群的交

//   Section 3.2: 陪集与拉格朗日定理 (Cosets and Lagrange's Theorem)
//     - 左陪集与右陪集
//     - 陪集的基本性质
//     - 拉格朗日定理及其推论
//     - 指数 (Index) 的概念

//   Section 3.3: 变换群与置换群 (Transformation Groups and Permutation Groups)
//     - 变换群的定义
//     - Cayley 定理：任何群同构于一个变换群
//     - 置换的分解（对换分解、轮换分解）
//     - 交错群 $A_n$

// --- Chapter 4: 正规子群与商群 (Normal Subgroups and Quotient Groups) ---

//   Section 4.1: 正规子群 (Normal Subgroups)
//     - 正规子群的定义与判定
//     - 正规子群与陪集的关系
//     - 典型例子

//   Section 4.2: 商群 (Quotient Groups)
//     - 商群的构造
//     - 商群的阶
//     - 自然同态

//   Section 4.3: 单群简介 (Introduction to Simple Groups)
//     - 单群的定义
//     - $A_n$ ($n \geq 5$) 的单性（概述）
//     - 有限单群分类定理（简述）

// --- Chapter 5: 群的同态定理 (Homomorphism Theorems for Groups) ---

//   Section 5.1: 群的同态 (Homomorphisms of Groups)
//     - 同态的基本性质
//     - 同态核与同态像
//     - 同态核是正规子群

//   Section 5.2: 第一同构定理 (First Isomorphism Theorem)
//     - 定理陈述与证明
//     - 典型应用

//   Section 5.3: 第二与第三同构定理 (Second and Third Isomorphism Theorems)
//     - 第二同构定理（菱形同构定理）
//     - 第三同构定理（商群的同构定理）
//     - 对应定理 (Correspondence Theorem)

// --- Chapter 6: 群的作用与Sylow定理 (Group Actions and Sylow Theorems) ---

//   Section 6.1: 群的作用 (Group Actions)
//     - 群作用的各种等价定义
//     - 轨道与稳定子
//     - 典型例子（共轭作用、左乘作用）

//   Section 6.2: 轨道-稳定子定理与Burnside引理 (Orbit-Stabilizer and Burnside's Lemma)
//     - 轨道-稳定子定理
//     - 类方程 (Class Equation)
//     - Burnside 引理（计数应用）

//   Section 6.3: Sylow定理 (Sylow Theorems)
//     - $p$-群的性质
//     - 第一 Sylow 定理（Sylow $p$-子群的存在性）
//     - 第二 Sylow 定理（Sylow $p$-子群的共轭性）
//     - 第三 Sylow 定理（Sylow $p$-子群的个数）

//   Section 6.4: Sylow定理的应用 (Applications of Sylow Theorems)
//     - 低阶群的分类
//     - 有限群的简单性判定

// --- Chapter 7: 有限生成Abel群的结构 (Structure of Finitely Generated Abelian Groups) ---

//   Section 7.1: 自由Abel群 (Free Abelian Groups)
//     - 自由Abel群的定义
//     - 基与秩

//   Section 7.2: 有限生成Abel群的结构定理 (Structure Theorem)
//     - 不变因子分解
//     - 初等因子分解
//     - 两种标准形式的等价性

//   Section 7.3: 有限Abel群的分类 (Classification of Finite Abelian Groups)
//     - 有限Abel群的同构分类
//     - 计数问题

// ==========================================================================
// Part II — 环论 (Ring Theory)
// ==========================================================================
// 设计思路：引入第二种运算，建立环的理想理论。
// 整除性理论（UFD/PID/ED）是环论的核心内容，
// 也是后续域扩张和伽罗瓦理论的基础工具。
// 对应教材：杨子胥 第三章–第四章；丘维生 第二章–第三章
//
// --- Chapter 8: 环的基本概念 (Basic Concepts of Rings) ---

//   Section 8.1: 环的定义 (Definition of Rings)
//     - 环的公理（加法Abel群 + 乘法半群 + 分配律）
//     - 含幺环、交换环
//     - 零因子与整环

//   Section 8.2: 整环与域 (Integral Domains and Fields)
//     - 整环的定义与性质
//     - 域的定义
//     - 整环到域的嵌入（分式域的构造）

//   Section 8.3: 环的特征 (Characteristic of a Ring)
//     - 特征的定义
//     - 整环的特征为 0 或素数
//     - 素域 (Prime Field)

//   Section 8.4: 环的典型构造 (Typical Constructions of Rings)
//     - 剩余类环 $\bb(Z)_n$
//     - 矩阵环 $M_n(R)$
//     - 直积环

// --- Chapter 9: 理想与商环 (Ideals and Quotient Rings) ---

//   Section 9.1: 理想 (Ideals)
//     - 理想的定义与判定
//     - 主理想、生成理想
//     - 理想的运算（和、交、积）

//   Section 9.2: 商环 (Quotient Rings)
//     - 商环的构造
//     - 自然同态
//     - 典型例子

//   Section 9.3: 环的同态定理 (Homomorphism Theorems for Rings)
//     - 第一同构定理
//     - 第二、第三同构定理
//     - 对应定理

//   Section 9.4: 中国剩余定理 (Chinese Remainder Theorem)
//     - 互素理想
//     - 中国剩余定理的陈述与证明
//     - 在 $\bb(Z)_n$ 中的应用

// --- Chapter 10: 整除性理论 (Divisibility Theory) ---

//   Section 10.1: 整除与相伴 (Divisibility and Associates)
//     - 整除的定义
//     - 相伴元
//     - 不可约元与素元

//   Section 10.2: 唯一分解整环 (Unique Factorization Domains, UFD)
//     - UFD 的定义
//     - 唯一分解的存在性与唯一性
//     - UFD 的性质（多项式环的 UFD 性）

//   Section 10.3: 主理想整环 (Principal Ideal Domains, PID)
//     - PID 的定义
//     - PID $\Rightarrow$ UFD
//     - PID 中不可约元与素元的等价性

//   Section 10.4: 欧几里得整环 (Euclidean Domains, ED)
//     - ED 的定义
//     - ED $\Rightarrow$ PID
//     - 典型例子：$\bb(Z)$、$F[x]$、$\bb(Z}[i]$

// --- Chapter 11: 多项式环 (Polynomial Rings) ---

//   Section 11.1: 一元多项式环 (Polynomial Rings in One Variable)
//     - 多项式环的构造
//     - 次数与首项系数
//     - 带余除法

//   Section 11.2: 多项式的整除性 (Divisibility of Polynomials)
//     - 最大公因式与辗转相除法
//     - 互素多项式
//     - 不可约多项式

//   Section 11.3: 多项式的根 (Roots of Polynomials)
//     - 余数定理与因式定理
//     - 根的重数
//     - 多项式的分裂

//   Section 11.4: 多元多项式环简介 (Introduction to Multivariate Polynomial Rings)
//     - $R[x_1, \ldots, x_n]$ 的构造
//     - Hilbert 基定理（简述）

// ==========================================================================
// Part III — 域论与伽罗瓦理论 (Field Theory and Galois Theory)
// ==========================================================================
// 设计思路：域论是本笔记的高潮。从域扩张出发，
// 经过分裂域、可分扩张，最终到达伽罗瓦基本定理。
// 伽罗瓦理论将群论与域论完美统一，并给出方程可解性的判据。
// 对应教材：杨子胥 第六章；丘维生 第四章–第五章
//
// --- Chapter 12: 域扩张 (Field Extensions) ---

//   Section 12.1: 域扩张的概念 (Concept of Field Extensions)
//     - 子域与域扩张 $E/F$
//     - 扩张的次数 $[E:F]$
//     - 有限扩张与代数扩张的关系

//   Section 12.2: 代数元与超越元 (Algebraic and Transcendental Elements)
//     - 代数元的定义
//     - 极小多项式
//     - 单扩张 $F(\alpha)$ 的结构

//   Section 12.3: 代数扩张的性质 (Properties of Algebraic Extensions)
//     - 代数扩张的塔定理
//     - 代数元的运算封闭性
//     - 代数闭包的存在性（简述）

// --- Chapter 13: 分裂域与正规扩张 (Splitting Fields and Normal Extensions) ---

//   Section 13.1: 分裂域 (Splitting Fields)
//     - 分裂域的存在性定理
//     - 分裂域的唯一性（至多在同构意义下）
//     - 典型例子

//   Section 13.2: 正规扩张 (Normal Extensions)
//     - 正规扩张的定义与等价刻画
//     - 正规扩张与分裂域的关系

//   Section 13.3: 有限域 (Finite Fields)
//     - 有限域的存在性与唯一性 $\bb(F)_{p^n}$
//     - 有限域的乘法群是循环群
//     - Frobenius 自同态

// --- Chapter 14: 可分扩张 (Separable Extensions) ---

//   Section 14.1: 可分多项式与可分元 (Separable Polynomials and Elements)
//     - 重根与形式导数
//     - 可分多项式的定义
//     - 可分元

//   Section 14.2: 可分扩张与完全域 (Separable Extensions and Perfect Fields)
//     - 可分扩张的定义
//     - 完全域的特征（特征 0 的域、有限域都是完全域）

//   Section 14.3: 本原元素定理 (Primitive Element Theorem)
//     - 定理陈述与证明
//     - 有限可分扩张 = 单扩张

// --- Chapter 15: 伽罗瓦理论 (Galois Theory) ---

//   Section 15.1: 伽罗瓦扩张 (Galois Extensions)
//     - 伽罗瓦群 $\text{Gal}(E/F)$ 的定义
//     - 伽罗瓦扩张的等价刻画（正规 + 可分）
//     - 伽罗瓦群的阶与扩张次数的关系

//   Section 15.2: 伽罗瓦基本定理 (Fundamental Theorem of Galois Theory)
//     - Galois 对应：子群 $\leftrightarrow$ 中间域
//     - 对应的反序性质
//     - 正规子群与正规扩张的对应

//   Section 15.3: 伽罗瓦理论的应用 (Applications of Galois Theory)
//     - 有限域上的伽罗瓦群
//     - 分圆域与分圆多项式
//     - 中间域的求解

// --- Chapter 16: 方程的可解性 (Solvability of Equations) ---

//   Section 16.1: 可解群 (Solvable Groups)
//     - 导群与导列
//     - 可解群的定义与基本性质
//     - 典型例子

//   Section 16.2: 根式可解 (Solvability by Radicals)
//     - 根式扩张的定义
//     - 方程根式可解 $\Leftrightarrow$ Galois 群可解

//   Section 16.3: Abel-Ruffini定理 (Abel-Ruffini Theorem)
//     - 一般 $n$ 次方程的 Galois 群为 $S_n$
//     - $S_n$ ($n \geq 5$) 不可解
//     - 五次及以上一般方程无根式解

// ==========================================================================
// Part IV — 模论初步 (Introduction to Module Theory)
// ==========================================================================
// 设计思路：模是群与向量空间的统一推广，
// 是进一步学习代数几何、表示论、代数数论的重要工具。
// 本 Part 仅作导论，重点放在 PID 上有限生成模的结构定理，
// 并回看 Part I 中有限生成Abel群结构定理的模论视角。
// 对应教材：丘维生 第六章
//
// --- Chapter 17: 模的基本概念 (Basic Concepts of Modules) ---

//   Section 17.1: 模的定义 (Definition of Modules)
//     - 左 $R$-模与右 $R$-模
//     - 典型例子（Abel群是 $\bb(Z)$-模、向量空间是 $F$-模、理想是 $R$-模）

//   Section 17.2: 子模与商模 (Submodules and Quotient Modules)
//     - 子模的定义与判定
//     - 商模的构造
//     - 模的同态定理

//   Section 17.3: 模的同态 (Homomorphisms of Modules)
//     - 模同态的核与像
//     - 模的直积与直和
//     - 自由模与基

// --- Chapter 18: 主理想整环上的有限生成模 (Finitely Generated Modules over PIDs) ---

//   Section 18.1: 有限生成模的结构定理 (Structure Theorem)
//     - 不变因子分解
//     - 初等因子分解
//     - 与矩阵标准形的联系

//   Section 18.2: 有限生成Abel群的结构再探 (Structure of FG Abelian Groups Revisited)
//     - 作为 $\bb(Z)$-模的结构定理的特殊情况
//     - 模论视角的统一理解

//   Section 18.3: 线性代数的应用 (Applications to Linear Algebra)
//     - 矩阵的有理标准形
//     - Jordan 标准形的模论推导

// ==========================================================================
// Appendix — 附录
// ==========================================================================

// --- Glossary (术语索引) ---
// 按字母顺序索引所有定义标签

// ==========================================================================
// 教材覆盖度映射表 (Coverage Mapping)
// ==========================================================================
//
// 杨子胥《近世代数》:
// | 教材位置          | 知识点                     | 本笔记位置              | 备注             |
// |------------------|---------------------------|------------------------|-----------------|
// | 第一章 §1        | 集合                       | Ch 1 §1.1              | 引用 Théorie des Ensembles |
// | 第一章 §2        | 映射与运算                  | Ch 1 §1.1              | 直接对应          |
// | 第一章 §3        | 代数运算                    | Ch 1 §1.1              | 直接对应          |
// | 第一章 §4        | 同态与同构                  | Ch 1 §1.3              | 直接对应          |
// | 第一章 §5        | 等价关系与分类               | Ch 1 §1.2              | 直接对应          |
// | 第二章 §1        | 群的定义                    | Ch 2 §2.1              | 直接对应          |
// | 第二章 §2        | 子群                       | Ch 3 §3.1              | 直接对应          |
// | 第二章 §3        | 变换群与置换群              | Ch 3 §3.3              | 直接对应          |
// | 第二章 §4        | 陪集与拉格朗日定理           | Ch 3 §3.2              | 直接对应          |
// | 第二章 §5        | 正规子群与商群              | Ch 4 §4.1–4.2          | 直接对应          |
// | 第二章 §6        | 循环群                     | Ch 2 §2.4              | 直接对应          |
// | 第二章 §7        | Sylow定理                  | Ch 6 §6.3–6.4          | 直接对应          |
// | 第三章 §1        | 环的定义                    | Ch 8 §8.1              | 直接对应          |
// | 第三章 §2        | 整环与域                    | Ch 8 §8.2              | 直接对应          |
// | 第三章 §3        | 环的同态                    | Ch 9 §9.3              | 直接对应          |
// | 第三章 §4        | 理想                       | Ch 9 §9.1              | 直接对应          |
// | 第三章 §5        | 商环与域                    | Ch 9 §9.2              | 直接对应          |
// | 第四章 §1–3      | 整除性与算术基本定理         | Ch 10 §10.1–10.2       | 直接对应          |
// | 第四章 §4        | 唯一分解整环                | Ch 10 §10.2            | 直接对应          |
// | 第四章 §5        | 主理想整环                  | Ch 10 §10.3            | 直接对应          |
// | 第四章 §6        | 欧几里得整环                | Ch 10 §10.4            | 直接对应          |
// | 第五章            | 有限生成Abel群              | Ch 7                   | 直接对应          |
// | 第六章 §1–2      | 域扩张与代数扩张            | Ch 12                  | 直接对应          |
// | 第六章 §3        | 分裂域                     | Ch 13 §13.1            | 直接对应          |
// | 第六章 §4        | 可分扩张                    | Ch 14                  | 直接对应          |
// | 第六章 §5        | 正规扩张                    | Ch 13 §13.2            | 直接对应          |
// | 第六章 §6        | 伽罗瓦群                    | Ch 15 §15.1–15.2       | 直接对应          |
// | 第六章 §7        | 方程的可解性                | Ch 16                  | 直接对应          |
//
// 丘维生《抽象代数》:
// | 教材位置          | 知识点                     | 本笔记位置              | 备注             |
// |------------------|---------------------------|------------------------|-----------------|
// | 第一章 §1–5      | 群的基本理论                | Ch 2–5                 | 直接对应          |
// | 第一章 §6        | 群的作用                    | Ch 6 §6.1–6.2          | 直接对应          |
// | 第一章 §7        | Sylow定理                  | Ch 6 §6.3–6.4          | 直接对应          |
// | 第二章 §1–5      | 环的基本理论                | Ch 8–9                 | 直接对应          |
// | 第二章 §6        | 中国剩余定理                | Ch 9 §9.4              | 直接对应          |
// | 第三章            | 唯一分解整环                | Ch 10                  | 直接对应          |
// | 第四章            | 域扩张                     | Ch 12–14               | 直接对应          |
// | 第五章            | 伽罗瓦理论                  | Ch 15–16               | 直接对应          |
// | 第六章            | 模论初步                    | Ch 17–18               | 直接对应          |
//
// ==========================================================================
// 设计决策记录 (Design Decisions)
// ==========================================================================
//
// 1. 群的作用独立成章 (Ch 6)：群作用是独立的有力工具，
//    与 Sylow 定理、Burnside 引理紧密关联，独立成章更清晰。
//
// 2. 有限生成Abel群结构定理放在 Part I 末尾 (Ch 7)：
//    遵循杨子胥的处理方式，用群论语言证明。
//    同时在 Part IV Ch 18 中给出模论视角的再证明。
//
// 3. 模论独立为 Part IV：丘维生教材包含此内容，
//    模论是进一步学习代数几何、表示论的重要基础。
//    作为导论性专题，不追求完备性。
//
// 4. 多项式环独立成章 (Ch 11)：虽然教材中多项式理论分散在
//    整除性理论和域扩张中，但作为环论的重要实例和域扩张的
//    基本工具，聚合为独立章节更便于查阅。
//
// 5. 有限域放在 Ch 13（分裂域与正规扩张）：有限域的理论
//    依赖分裂域的存在性，放在此处逻辑更顺畅。
//
// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循"群论 → 环论 → 域论与伽罗瓦理论 → 模论初步"的四段式主线，
// 共 4 Part、18 Chapter。
//
// Part I（群论，Ch 1–7）：从代数运算的公理化出发，建立群的完整理论，
// 包括同态定理、群的作用与 Sylow 定理，以有限生成Abel群结构定理收尾。
//
// Part II（环论，Ch 8–11）：引入第二种运算，建立理想理论与整除性理论，
// 多项式环作为环论的核心实例独立成章。
//
// Part III（域论与伽罗瓦理论，Ch 12–16）：域扩张 → 分裂域 → 可分扩张 →
// 伽罗瓦基本定理 → 方程可解性，是本笔记的高潮部分。
//
// Part IV（模论初步，Ch 17–18）：导论性专题，重点在 PID 上有限生成模
// 的结构定理，并回看 Abel 群结构定理的模论视角。
//
// 教材覆盖：杨子胥全部 6 章 + 丘维生全部 6 章知识点均已覆盖。
// ==========================================================================

#bibliography("references.bib")
