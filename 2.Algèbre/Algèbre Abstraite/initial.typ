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

#note[
  A binary operation is, in itself, *nothing more* than an arbitrary
  mapping $S times S -> S$: any such map qualifies, no matter how
  chaotic. There is nothing intrinsic to the concept that singles it
  out — abstract algebra gives it a name and a notation only because
  every structure studied here (groups, rings, fields, modules) is
  built on top of one or more such maps, so the vocabulary recurs
  constantly. The actual mathematical content lies not in the map but
  in the *laws* a particular operation may satisfy
  (#link(<prop:operation-laws>)[below]); a generic binary operation
  has none of them.
] <note:binary-operation-trivial>

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

#proof(name: "of the generalised associativity")[
  Induct on $n$. For $n <= 3$
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
  the three-factor law, gives the result.
]

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

#proof[
  $e_L = e_L star e_R = e_R$, using that $e_R$ is a right
  identity in the first step and $e_L$ a left identity in the second.
  For inverses: $b = b star e = b star (a star c) = (b star a) star c =
  e star c = c$.
]

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

The general theory of equivalence relations, equivalence classes,
partitions, and quotient sets is developed in the *Théorie des
Ensembles* note. We recall only the notation here: if $R$ is an
equivalence relation on $S$, the class of $a in S$ is
$[a]_R = {x in S | x R a}$, and the quotient set is
$S \/ R = {[a]_R | a in S}$.

What algebra adds is a single, decisive question: *when does an
operation on $S$ descend to an operation on $S \/ R$?* The answer
controls every quotient construction in this book — quotient groups
(Chapter 4), quotient rings (Chapter 9), quotient modules
(Chapter 17). We motivate it with the most important example, then
state the general principle.

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

#definition(name: "Endomorphism and Automorphism")[
  A homomorphism from an algebraic system to *itself* is called an
  *endomorphism*: $f: (S, star) -> (S, star)$. A bijective
  endomorphism is an *automorphism* — equivalently, an isomorphism
  $S -> S$. The set of all automorphisms of $S$ is written
  $"Aut"(S)$; under composition it is closed, contains the identity
  map, and every element has an inverse (the inverse bijection), so
  $"Aut"(S)$ is a group — a fact we will use repeatedly once groups
  are defined in #link(<def:binary-operation>)[Chapter 2].
] <def:endomorphism-automorphism>

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

#proof[
  For any $y in T$, surjectivity gives $y = f(a)$ for some
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
  so $f(a^(-1))$ is an inverse of $f(a)$.
]

Surjectivity is essential in the first part: without it $f(e)$ is
merely an idempotent of $T$, not the identity. (For homomorphisms of
groups, where inverses exist for *every* element, the image $f(S)$
carries the induced operation and $f(e) = e'$ holds inside $f(S)$
regardless — this will be systematised in
#link(<note:kernel-preliminary>)[Chapter 5].)

#property(name: "Surjective Homomorphisms Preserve Operation Laws")[
  Let $f: (S, star) -> (T, diamond)$ be a *surjective* homomorphism.
  - If $star$ is associative, then $diamond$ is associative.
  - If $star$ is commutative, then $diamond$ is commutative.
  - For two operations on each side: if $f$ also preserves a second
    pair of operations $f(a star' b) = f(a) diamond' f(b)$, and $star$
    distributes over $star'$ in $S$, then $diamond$ distributes over
    $diamond'$ in $T$.

  In each case surjectivity is essential: without it the law holds
  only on the image $f(S)$, not on all of $T$.
] <prop:homomorphism-preserves-laws>

#proof[
  We prove associativity; the others are identical in pattern. Let
  $u, v, w in T$. Surjectivity gives $u = f(a)$, $v = f(b)$,
  $w = f(c)$ for some $a, b, c in S$. Then
  $
    (u diamond v) diamond w
    = (f(a) diamond f(b)) diamond f(c)
    = f(a star b) diamond f(c)
    = f((a star b) star c),
  $
  and on the other hand
  $
    u diamond (v diamond w)
    = f(a) diamond (f(b) diamond f(c))
    = f(a) diamond f(b star c)
    = f(a star (b star c)).
  $
  By associativity of $star$, $(a star b) star c = a star (b star c)$,
  so the two images are equal: $(u diamond v) diamond w = u diamond
  (v diamond w)$. Since $u, v, w$ were arbitrary, $diamond$ is
  associative. Commutativity and distributivity follow the same
  $f$-chasing argument.
]

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

#proof[
  First we upgrade the left inverse of $a$ to a two-sided
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
  have thus been upgraded to two-sided ones, and (G1)–(G3) hold.
]

Note the division of labour inside the proof: each upgrade uses
*both* one-sided conditions. Neither condition alone suffices — see
#link(<ex:non-groups>)[the right-zero operation] in §2.2.

#corollary(name: "Uniqueness Inside a Group")[
  In a group the identity is unique and each element has exactly one
  inverse. Conversely, any solution of $a b = e$ is already the
  inverse of $a$: $b a = e$ follows.
] <cor:group-identity-uniqueness>

#proof[
  In a group (G2) supplies an identity that the theorem just
  proved makes two-sided, and uniqueness of a two-sided identity —
  hence of each inverse — is
  #link(<prop:operation-laws-unique>)[Chapter 1]. For the converse,
  suppose $a b = e$. Then
  $
    b = e b = (a^(-1) a) b = a^(-1) (a b) = a^(-1) e = a^(-1),
  $
  using (G3) in the second step and the hypothesis $a b = e$ in the
  third. Hence $b a = a^(-1) a = e$, as claimed.
]

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

#proof[
  (1) Multiply $a b = a c$ by $a^(-1)$ on the left:
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
  $b^(-1) a^(-1) = a^(-1) b^(-1)$ outright.
]

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

#proof[
  Divide with remainder: every integer $m$ writes uniquely as
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
  $n | j - i$, impossible for $0 < j - i < n$.
]

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

#proof[
  Any two elements are $g^j$ and $g^k$, and
  $g^j g^k = g^(j+k) = g^(k+j) = g^k g^j$.
]

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

#proof[
  *Infinite case.* Define $phi: bb(Z) -> G$ by $phi(k) =
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
  surjectivity forces bijectivity.
]

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

#proof[
  By #link(<prop:order-properties>)[§2.3], $a^m = g^(k m) = e$
  holds exactly when $n | k m$. Write $d = "gcd"(n, k)$, so $n = d n'$
  and $k = d k'$ with $"gcd"(n', k') = 1$; then $n | k m$ unfolds to
  $d n' | d k' m$, i.e. $n' | k' m$, i.e. $n' | m$ since $n', k'$ are
  coprime. The smallest positive such $m$ is $n'$, so
  $"ord"(a) = n' = n \/ d$, which divides $n = d n'$.
]

#corollary(name: "Generators of a Finite Cyclic Group")[
  In a cyclic group $G = ⟨g⟩$ of order $n$, the element $g^k$ is a
  generator of $G$ if and only if $"gcd"(n, k) = 1$. Hence $G$ has
  exactly $phi(n)$ generators, where $phi$ is Euler's totient
  function, counting the integers in ${0, 1, dots, n - 1}$ coprime
  to $n$. For instance, $(bb(Z)_6, +)$ has generators $[1]$ and
  $[5]$.
] <cor:cyclic-generators>

#proof[
  $g^k$ generates $G$ exactly when $⟨g^k⟩ = G$, i.e. when
  $abs(⟨g^k⟩) = n$; by #link(<cor:order-divides>)[the corollary above],
  $abs(⟨g^k⟩) = "ord"(g^k) = n \/ ("gcd"(n, k))$, which equals $n$
  exactly when $"gcd"(n, k) = 1$. The count of such exponents $k$ in
  ${0, 1, dots, n - 1}$ is $phi(n)$ by definition.
]

#theorem(name: "Subgroups of Cyclic Groups")[
  Let $G = ⟨g⟩$ be a cyclic group.
  - Every subgroup of $G$ is cyclic.
  - If $abs(G) = n$ is finite, then for every positive divisor $d$
    of $n$ there is exactly one subgroup of order $d$, namely
    $⟨g^(n \/ d)⟩$; there are no other subgroups.
] <thm:cyclic-subgroups>

#proof[
  (1) Let $H$ be a subgroup of $G = ⟨g⟩$. If $H = {e}$, then
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
  are equal.
]

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
// Chapter 3: 子群、陪集与拉格朗日定理
// ==========================================================================

= Subgroups, Cosets, and Lagrange's Theorem // 子群、陪集与拉格朗日定理

Chapter 2 defined groups from the outside: axioms, examples, and
elementary consequences. We now step inside a group and study the
subsets that are themselves groups — *subgroups* (§3.1). The payoff
is immediate: cosets of a subgroup (§3.2) carve a finite group into
equal-sized tiles, and the resulting counting law, Lagrange's
theorem, is the first deep structural constraint of the subject.
§3.3 then reverses the perspective with Cayley's theorem: every
group, however abstract, lives inside a permutation group.

== Subgroups // 子群

The working definition of Chapter 2 — a non-empty subset closed
under the operation and inverses — now becomes official, together
with the tools that produce and certify subgroups.

#definition(name: "Subgroup")[
  Let $(G, star)$ be a group and $H$ a subset of $G$. Then $H$ is a
  *subgroup* of $G$, written $H <= G$, if $H$ is a group under the
  restricted operation — equivalently, if $H$ is non-empty and
  $
    h_1, h_2 in H quad ==> quad h_1 h_2 in H quad "and" quad h_1^(-1)
    in H,
  $
  the working criterion of #link(<note:subgroup-preview>)[Chapter
    2]. The whole group $G$ and the singleton ${e}$ are the *trivial
  subgroups*; any other subgroup is *proper*, written $H < G$.
] <def:subgroup>

Checking closure and inverses separately doubles the work; the
following criterion does both at once and will be the workhorse of
the chapter.

#theorem(name: "One-Step Subgroup Criterion")[
  Let $G$ be a group and $H$ a non-empty subset of $G$. Then $H$ is
  a subgroup of $G$ if and only if
  $
    a, b in H quad ==> quad a b^(-1) in H.
  $
] <thm:subgroup-criterion>

#proof[
  Necessity is immediate: if $H$ is a subgroup and
  $a, b in H$, then $b^(-1) in H$ by closure under inverses, and then
  $a b^(-1) in H$ by closure under the operation.

  Conversely, suppose $a b^(-1) in H$ whenever $a, b in H$. Since $H$
  is non-empty, pick $h in H$; then $e = h h^(-1) in H$, so the
  identity of $G$ lies in $H$ and acts as an identity inside $H$. For
  $h in H$, the criterion with $a = e$ and $b = h$ gives $h^(-1) = e
  h^(-1) in H$. For $a, b in H$, we now know $b^(-1) in H$, and the
  criterion with $b^(-1)$ in place of $b$ gives $a (b^(-1))^(-1) = a b
  in H$. Thus $H$ is non-empty and closed under the operation and
  under inverses — a subgroup by
  #link(<def:subgroup>)[the definition].
]

#example[
  (A subgroup inventory.)
  - For each $n >= 1$, the set $n bb(Z) = {n k | k in bb(Z)}$ is a
    subgroup of $(bb(Z), +)$: non-empty, and $a - b in n bb(Z)$
    whenever $a, b in n bb(Z)$ (in additive notation the criterion
    reads $a - b in H$). By #link(<thm:cyclic-subgroups>)[Chapter
      2] these are *all* subgroups of $bb(Z)$.
  - $"SL"_n(F) <= "GL"_n(F)$: non-empty since the identity matrix
    has determinant $1$, and for $A, B$ of determinant $1$ the
    product $A B^(-1)$ again has determinant $1$. The claim made
    when #link(<def:general-linear-group>)[they were defined in
      Chapter 2] is hereby certified by the one-step criterion.
  - $S_3$ has exactly six subgroups: ${e}$; the three of order $2$
    — $⟨(1 2)⟩$, $⟨(1 3)⟩$, $⟨(2 3)⟩$; the one of order $3$ —
    $⟨(1 2 3)⟩ = {e, (1 2 3), (1 3 2)}$; and $S_3$ itself. Each
    listed set passes the criterion; conversely, combining two
    distinct transpositions generates a 3-cycle and then the whole
    group, so no other subgroup exists. The list feeds §3.2 and
    Chapter 4.
] <ex:subgroup-inventory>

Subgroups beget subgroups: from any subset one can manufacture the
smallest subgroup containing it.

#definition(name: "Generated Subgroup")[
  Let $G$ be a group and $S$ a subset of $G$ (possibly empty). The
  *subgroup generated by $S$*, written $⟨S⟩$, is the intersection of
  all subgroups of $G$ that contain $S$. Equivalently, $⟨S⟩$ is the
  smallest subgroup containing $S$: it contains $S$, it is a
  subgroup, and every subgroup containing $S$ contains $⟨S⟩$.
  Concretely, $⟨S⟩$ consists of all finite products $s_1 s_2 dots
  s_k$ in which each factor lies in $S$ or is the inverse of an
  element of $S$. A group $G$ is *generated by* $S$ when $G = ⟨S⟩$;
  in particular $⟨g⟩$ is the cyclic subgroup of
  #link(<note:subgroup-preview>)[Chapter 2].
] <def:generated-subgroup>

#property(name: "Intersections of Subgroups")[
  Let ${H_i}_(i in I)$ be any family of subgroups of a group $G$.
  Then $inter.big_(i in I) H_i$ is a subgroup of $G$. Consequently
  $⟨S⟩$ — the intersection of all subgroups containing $S$ — is
  indeed a subgroup, the smallest one.
] <prop:intersection-subgroups>

#proof[
  The identity $e$ lies in every $H_i$, so the intersection
  is non-empty. If $a, b$ lie in the intersection, they lie in each
  $H_i$; by #link(<thm:subgroup-criterion>)[the criterion],
  $a b^(-1) in H_i$ for every $i$, so $a b^(-1)$ lies in the
  intersection. For the consequence: the concrete product description
  of $⟨S⟩$ is visibly closed under $a b^(-1)$ and contains $S$, so it
  coincides with the intersection.
]

#note[
  (The cyclic case, restated.) With the subgroup vocabulary in
  place, #link(<thm:cyclic-subgroups>)[Chapter 2] reads cleanly:
  every subgroup of a cyclic group is cyclic, and a cyclic group of
  finite order $n$ has exactly one subgroup of each order dividing
  $n$, namely $⟨g^(n \/ d)⟩$ for $d | n$. What powers were already
  doing, the generated-subgroup concept now says in general
  language.
] <note:cyclic-restated>

== Cosets and Lagrange's Theorem // 陪集与拉格朗日定理

Fix a subgroup $H <= G$. The subgroup $H$ is a tile inside $G$; the
remarkable fact is that the whole group is tiled by translated
copies of $H$, one for each "position" of the tile. These copies are
the cosets, and their counting is Lagrange's theorem.

#definition(name: "Cosets")[
  Let $H <= G$ and $a in G$. The *left coset* of $H$ by $a$ is the
  subset
  $
    a H = {a h | h in H},
  $
  and the *right coset* is $H a = {h a | h in H}$. In additive
  notation these read $a + H$ and $H + a$.
] <def:coset>

The definition specializes a familiar construction: for $G =
(bb(Z), +)$ and $H = n bb(Z)$, the coset $a + H$ is exactly the
residue class $[a]$ of #link(<ex:residue-classes>)[Chapter 1]. The
congruence arithmetic built there is the cyclic special case of a
general mechanism.

#lemma(name: "Cosets Tile the Group")[
  Let $H <= G$ and $a, b in G$.
  - $a in a H$, and the map $h arrow.r.double a h$ is a bijection
    $H -> a H$; in particular every left coset has the same
    cardinality as $H$.
  - $a H = b H$ if and only if $a^(-1) b in H$, equivalently if and
    only if $b in a H$.
  - Two left cosets are either equal or disjoint.
  - The left cosets of $H$ partition $G$.
] <lem:coset-equivalent>

#proof[
  (1) $a = a e in a H$. The map $h arrow.r.double a h$ has
  inverse $x arrow.r.double a^(-1) x$, so it is a bijection.

  (2) If $a H = b H$, then $b in b H = a H$, so $b = a h$ for some
  $h in H$ and $a^(-1) b = h in H$. Conversely, if $a^(-1) b = h in
  H$, then $b = a h in a H$, and for any $b h'$ with $h' in H$ we get
  $b h' = a h h' in a H$; so $b H subset.eq a H$, and symmetry of the
  argument reverses the inclusion.

  (3) If $x in a H ∩ b H$, write $x = a h_1 = b h_2$; then
  $a^(-1) b = h_1 h_2^(-1) in H$ by
  #link(<thm:subgroup-criterion>)[the criterion], and (2) gives
  $a H = b H$.

  (4) Every $a in G$ lies in its own coset $a H$, and the cosets are
  pairwise disjoint: a partition of $G$ (in the sense of the
  *Théorie des Ensembles* note). The equivalence relation behind
  it, "$a tilde b$ if and only if $a^(-1) b in H$", matches the
  partition-class correspondence.
]

#example[
  (Cosets in $S_3$.) Take $H = ⟨(1 2 3)⟩ = {e, (1 2 3), (1 3 2)}$.
  Every element of $H$ gives the coset $H$ itself, and
  $
    (1 2) H = {(1 2), (1 2)(1 2 3), (1 2)(1 3 2)}
    = {(1 2), (2 3), (1 3)},
  $
  with $(1 3) H$ and $(2 3) H$ giving the same set. So there are
  exactly two left cosets, and $6 = 2 dot 3$. Here one also checks
  that $a H = H a$ for *every* $a in S_3$ — a coincidence that
  Chapter 4 will single out.

  Now take $K = ⟨(1 2)⟩ = {e, (1 2)}$. The left cosets are
  $
    K, quad (1 3) K = {(1 3), (1 2 3)}, quad (2 3) K = {(2 3),
      (1 3 2)},
  $
  while the right cosets are
  $
    K, quad K (1 3) = {(1 3), (1 3 2)}, quad K (2 3) = {(2 3),
      (1 2 3)}.
  $
  Again $6 = 3 dot 2$ — but now $(1 3) K != K (1 3)$. The counting
  is blind to the difference; Chapter 4 will not be.
] <ex:s3-cosets>

#definition(name: "Index")[
  Let $H <= G$. The *index* of $H$ in $G$, written $[G : H]$, is the
  number of left cosets of $H$ in $G$. (When $G$ is finite this
  equals the number of right cosets, both counting the blocks of a
  partition into sets of size $abs(H)$.)
] <def:index>

#theorem(name: "Lagrange's Theorem")[
  Let $G$ be a finite group and $H <= G$ a subgroup. Then
  $
    abs(G) = [G : H] dot abs(H),
  $
  and in particular $abs(H)$ divides $abs(G)$.
] <thm:lagrange>

#proof[
  By #link(<lem:coset-equivalent>)[the lemma], the left
  cosets partition $G$ into $[G : H]$ classes, each of cardinality
  $abs(H)$. Counting elements class by class gives the identity.
]

The tiles are all the same size; the group is a whole number of
tiles. Every structural statement below is this picture in words.

#figure(
  image("img/cosets-partition.svg", width: 80%),
  caption: [The tiling behind Lagrange's theorem. A finite group
    $G$ of $12$ elements (dots) is partitioned by the subgroup $H$
    of $3$ elements (highlighted top row) into four left cosets
    $H, a H, b H, c H$: pairwise disjoint, all of size $abs(H)$,
    and covering $G$. Counting by rows gives
    $abs(G) = [G : H] dot abs(H) = 4 dot 3$; the divisibility of
    $abs(H)$ into $abs(G)$ is the theorem's whole content.],
  placement: auto,
  supplement: [Fig.],
) <fig:cosets-partition>

#corollary(name: "Element Orders Divide the Group Order")[
  In a finite group $G$, the order of every element $a$ divides
  $abs(G)$; in particular $a^(abs(G)) = e$ for all $a in G$.
] <cor:lagrange-order-divides>

#proof[
  This fulfils the promise attached to
  #link(<cor:order-divides>)[the cyclic case of Chapter 2]. The
  cyclic subgroup $⟨a⟩$ has $abs(⟨a⟩) = "ord"(a)$ elements
  (#link(<prop:order-properties>)[§2.3]), so Lagrange gives
  $"ord"(a) | abs(G)$. Writing $abs(G) = "ord"(a) dot m$, we get
  $a^(abs(G)) = (a^("ord"(a)))^m = e^m = e$.
]

#corollary(name: "Groups of Prime Order")[
  Every group of prime order is cyclic — indeed, every non-identity
  element generates it.
] <cor:prime-order-cyclic>

#proof[
  Let $abs(G) = p$ be prime and $a != e$. Then
  $"ord"(a) > 1$ and, by the corollary above, $"ord"(a) | p$; hence
  $"ord"(a) = p$, and $⟨a⟩$ already has $p = abs(G)$ elements:
  $⟨a⟩ = G$.
]

The prime-order corollary feeds the classification of the smallest
groups — and to run it at order $4$ we need the one non-cyclic
group lurking there.

#definition(name: "Klein Four-Group")[
  The *Klein four-group* $V_4$ is the group with elements
  $e, a, b, c$ subject to
  $
    a^2 = b^2 = c^2 = e, quad a b = b a = c, quad b c = c b = a,
    quad c a = a c = b.
  $
  It is abelian and non-cyclic: every non-identity element has
  order $2$, so no single element generates the group. (The group
  axioms are read off directly, or recognized in the symmetries of
  a rectangle.)
] <def:klein-four>

#example[
  (Groups of order at most $5$.) Let $abs(G) <= 5$.
  - $abs(G) = 1$: the trivial group.
  - $abs(G) = 2, 3, 5$ (primes): $G$ is cyclic,
    #link(<cor:prime-order-cyclic>)[by the corollary].
  - $abs(G) = 4$: pick $a != e$. If $"ord"(a) = 4$, then $G = ⟨a⟩ ≅
    bb(Z)_4$ by #link(<thm:cyclic-classification>)[Chapter 2].
    Otherwise every non-identity element has order $2$. Take two
    distinct such elements $a, b$: the product $a b$ cannot be $e$
    (it would give $b = a^(-1) = a$), cannot be $a$ (cancelling
    $a$), and cannot be $b$ (cancelling $b$); so $G = {e, a, b, c}$
    with $c = a b$, and $b a = c$ by the same elimination. The
    relations $a b = c$, $b c = b (a b) = (b a) b = c b = a$, and
    $a c = a (a b) = b$ then identify $G$ with
    #link(<def:klein-four>)[the Klein four-group].

  Up to isomorphism: the trivial group; $bb(Z)_2$, $bb(Z)_3$,
  $bb(Z)_5$; and $bb(Z)_4$, $V_4$. All six are abelian. The
  smallest non-abelian group therefore has order $6$ — and $S_3$
  supplies one, closing the promise of
  #link(<ex:s3-details>)[Chapter 2].
] <ex:low-order-classification>

#note[
  (Fermat's little theorem, free of charge.) Let $p$ be prime and
  $a$ an integer not divisible by $p$. The residue class $[a]$ is a
  non-identity element of the multiplicative group $(bb(Z)_p^*,
    dot)$ of order $p - 1$ (a group: $a$ coprime to $p$ has a
  multiplicative inverse modulo $p$). By
  #link(<cor:lagrange-order-divides>)[the corollary],
  $"ord"([a])$ divides $p - 1$, so $[a]^(p - 1) = [1]$, that is,
  $
    a^(p - 1) equiv 1 quad (mod p).
  $
  A result of number theory — the territory of the Théorie des
  Nombres note — obtained here from pure group counting. Euler's
  analogue for composite moduli, $a^(phi(n)) equiv 1 (mod n)$ for
  $a$ coprime to $n$, follows the same way once the group
  $(bb(Z)_n^*, dot)$ and its order $phi(n)$ are in hand.
] <note:fermat-little-theorem>

Counting has delivered: divisibility constraints, a classification,
a number-theoretic classic. The next section anchors groups in the
most concrete class of all — permutations — where the subgroups of
§3.2's example reappear and acquire a fundamental invariant.

== Transformation Groups and Permutation Groups // 变换群与置换群

Cayley's theorem closes the circle opened by the symmetric groups:
not only are permutations examples of groups — every group is, up
to isomorphism, a group of permutations of some set.

#definition(name: "Transformation Group")[
  Let $X$ be a set. A *transformation* of $X$ is a bijection
  $X -> X$; under composition these form the group $"Sym"(X)$
  (the symmetric group of #link(<def:symmetric-group>)[Chapter 2],
  for general $X$). A *transformation group* on $X$ is a subgroup
  of $"Sym"(X)$.
] <def:transformation-group>

#theorem(name: "Cayley's Theorem")[
  Every group $G$ is isomorphic to a transformation group — indeed,
  to a subgroup of $"Sym"(G)$.
] <thm:cayley>

#proof[
  For $g in G$ define the *left translation*
  $
    L_g: G -> G, quad x arrow.r.double g x.
  $
  Each $L_g$ is a bijection with inverse $L_(g^(-1))$, since
  $L_(g^(-1))(L_g(x)) = g^(-1) (g x) = x$ and similarly from the
  other side. Translations compose according to the group law:
  $
    (L_g circle L_h)(x) = L_g(h x) = (g h) x = L_(g h)(x),
  $
  so $L_g circle L_h = L_(g h)$. Now let $L(G) = {L_g | g in G}$, a
  subset of $"Sym"(G)$. It contains the identity map $L_e$, and for
  $L_g, L_h in L(G)$ the criterion computation gives
  $L_g circle L_h^(-1) = L_g circle L_(h^(-1)) = L_(g h^(-1)) in
  L(G)$; by #link(<thm:subgroup-criterion>)[the one-step criterion],
  $L(G)$ is a subgroup of $"Sym"(G)$ — a transformation group.
  Finally, $g arrow.r.double L_g$ maps $G$ bijectively onto $L(G)$
  (injective: $L_g = L_h$ says $g x = h x$ for all $x$, and $x = e$
  gives $g = h$) and preserves the operation, $L_(g h) = L_g circle
  L_h$. Hence $G ≅ L(G) <= "Sym"(G)$.
]

#note[
  (What Cayley says, and what it does not.) The theorem exhibits
  every abstract group concretely: $D_3$ as symmetries of a
  triangle, $Q_8$ inside $"Sym"(Q_8) ≅ S_8$ as $8 times 8$
  permutations. But the embedding is rarely economical — smaller
  permutation representations of $Q_8$ exist — so Cayley is a
  license for concreteness, not a recipe for the best
  representation. The construction $g arrow.r.double L_g$ is the
  *left regular representation*; in Chapter 6 it becomes the
  launching example of a group action.
] <note:regular-action-preview>

Inside $"Sym"(X)$ itself there is bookkeeping to do. For finite $X$
the elements of $"Sym"(X)$ admit a canonical normal form, and that
normal form carries an invariant of the first importance.

#lemma(name: "Cycle Decomposition")[
  Every permutation $sigma$ of a finite set is a product of
  *disjoint cycles* — cycles acting on pairwise disjoint sets of
  points — and this decomposition is unique up to the order of the
  factors and cyclic rotations inside each cycle.
] <lem:cycle-decomposition>

#proof[
  *Existence.* Pick $x_1$ and follow the sequence
  $x_1, sigma(x_1), sigma^2(x_1), dots$. Since $X$ is finite, some
  value repeats: $sigma^j(x_1) = sigma^k(x_1)$ with $0 < j < k$.
  Applying $sigma^(-j)$ yields $x_1 = sigma^(k - j)(x_1)$, so the
  *first* repetition is $x_1$ returning to itself, and the orbit
  closes into a cycle $c_1$ on
  ${x_1, sigma(x_1), dots, sigma^(k-j-1)(x_1)}$. If $c_1$ exhausts
  $X$, done. Otherwise pick $x'$ outside this orbit and repeat; the
  new orbit is disjoint from the first (orbits of a map cannot
  partially overlap, for the same first-repetition argument), and
  finiteness terminates the process. The product of the resulting
  disjoint cycles agrees with $sigma$ on every point.

  *Uniqueness.* Any decomposition into disjoint cycles determines the
  orbit of each point, hence the cycles on orbits of size $>= 2$ are
  forced; points fixed by $sigma$ appear as 1-cycles or are omitted,
  a harmless ambiguity.
]

#property(name: "Transpositions Generate")[
  A $k$-cycle factors into $k - 1$ transpositions:
  $
    (a_1 a_2 dots a_k) = (a_1 a_k)(a_1 a_(k-1)) dots (a_1 a_3)
    (a_1 a_2),
  $
  read right to left. Consequently every $sigma in S_n$ with
  $n >= 2$ is a product of transpositions.
] <prop:transpositions-generate>

#proof[
  Follow each point through the right-hand product: $a_1$
  maps to $a_2$ and then no factor touches it; $a_i$ ($i >= 2$) is
  untouched until $(a_1 a_i)$ sends it to $a_1$, after which
  $(a_1 a_(i+1))$ sends it to $a_(i+1)$, and so on — giving the
  cycle's action $a_i arrow.r.double a_(i+1)$ with $a_k arrow.r.double
  a_1$. Points outside $\{a_1, dots, a_k\}$ are fixed throughout.
  Existence of a factorization for $sigma$ then follows by decomposing
  into cycles first.
]

#lemma(name: "Parity Is Well Defined")[
  Let $sigma in S_n$ and suppose $sigma = tau_1 tau_2 dots tau_k$
  is any factorization into transpositions. Then the parity of $k$
  depends only on $sigma$: a second factorization into $l$
  transpositions satisfies $k equiv l (mod 2)$.
] <lem:sign-well-defined>

#proof[
  Consider the Vandermonde polynomial
  $
    Delta(x_1, dots, x_n) = product_(1 <= i < j <= n) (x_j - x_i),
  $
  a non-zero element of the polynomial ring in $n$ variables. For a
  permutation $sigma$, let $sigma(Delta)$ denote the polynomial
  obtained by replacing each $x_i$ with $x_(sigma(i))$. A transposition
  $tau = (p q)$ swaps the variables $x_p$ and $x_q$: the factor
  $(x_q - x_p)$ changes sign, each pair of factors involving exactly
  one of $p, q$ is exchanged without sign change, and all other
  factors are untouched; hence $tau(Delta) = -Delta$. Composing,
  $sigma = tau_1 dots tau_k$ gives $sigma(Delta) = (-1)^k Delta$. If
  also $sigma = tau'_1 dots tau'_l$, then
  $
    (-1)^k Delta = sigma(Delta) = (-1)^l Delta,
  $
  and since $Delta != 0$, the parities agree.
]

#definition(name: "Sign and the Alternating Group")[
  Let $sigma in S_n$ with $n >= 2$, and factor $sigma$ into
  transpositions in any way. The *sign* of $sigma$ is
  $
    "sign"(sigma) = (-1)^k,
  $
  well defined by #link(<lem:sign-well-defined>)[the lemma]. A
  permutation with $"sign"(sigma) = 1$ is *even*; with
  $"sign"(sigma) = -1$, *odd*. The sign is multiplicative:
  $"sign"(sigma tau) = "sign"(sigma) "sign"(tau)$, by concatenating
  factorizations. The *alternating group* $A_n$ is the set of even
  permutations. It is a subgroup of $S_n$ (the product of evens is
  even, the identity is even, and inverses preserve parity), and
  multiplication by the transposition $(1 2)$ pairs each even
  permutation with a unique odd one, so exactly half of $S_n$ is
  even: $abs(A_n) = n! \/ 2$ and $[S_n : A_n] = 2$.
] <def:alternating-group>

#example[
  (Signs in practice.) Every 3-cycle is even:
  $(a b c) = (a c)(a b)$ is a product of $2$ transpositions by
  #link(<prop:transpositions-generate>)[the factorization law]. In
  particular
  $
    A_3 = {e, (1 2 3), (1 3 2)} = ⟨(1 2 3)⟩,
  $
  the very subgroup $H$ of #link(<ex:s3-cosets>)[§3.2] — cyclic of
  order $3$, index $2$ in $S_3$. A transposition is odd, and
  generally a $k$-cycle is even exactly when $k$ is odd. The sign
  law checks concretely: $(1 2 3)(1 2) = (1 3)$ — even times odd is
  odd. Of the six elements of $S_3$, three are even ($e$ and the
  two 3-cycles) and three are odd (the transpositions).
] <ex:a3-alternating>

The chapter has delivered the first structural laws. Inside a group,
subgroups are certified by a single computation (§3.1); around a
subgroup, cosets tile the group evenly and force the divisibility of
Lagrange's theorem, with the classification of groups of small order
as immediate harvest (§3.2); and Cayley's theorem anchors every
group in the concrete world of permutations, whose parity mechanics
produce the alternating groups (§3.3). Yet the coset examples of
§3.2 exposed a fault line: sometimes $a H = H a$ for all $a$, and
sometimes not. Measuring that fault line — isolating the subgroups
for which left and right cosets coincide — is the business of the
next chapter, and it unlocks the construction of quotient groups
promised back in the quotient-set construction of the
*Théorie des Ensembles* note.

// ==========================================================================
// Chapter 4: 正规子群与商群
// ==========================================================================

= Normal Subgroups and Quotient Groups // 正规子群与商群

Chapter 3 ended on a fault line. In #link(<ex:s3-cosets>)[§3.2] the
subgroup $H = ⟨(1 2 3)⟩$ of $S_3$ satisfied $a H = H a$ for every $a
in S_3$, while $K = ⟨(1 2)⟩$ did not: $(1 3) K != K (1 3)$. Both
subgroups tile $S_3$ into equal-sized cosets — Lagrange's counting is
blind to the difference — but only the first behaves as if its cosets
were "transparent" to multiplication. This chapter isolates that
behavior under the name *normal subgroup* (§4.1), shows it is exactly
the condition that makes coset multiplication well-defined — redeeming
the compatibility check promised in
#link(<caution:well-defined-operations>)[Chapter 1] — and constructs
the *quotient group* $G \/ N$ (§4.2). The natural projection $pi: G
-> G \/ N$ is the universal homomorphism from $G$, and it sets up
the homomorphism theorems of Chapter 5. The chapter closes (§4.3)
with *simple groups*: groups with no non-trivial normal subgroups,
hence no non-trivial quotients — the irreducible building blocks of
finite group theory.

== Normal Subgroups // 正规子群

#definition(name: "Normal Subgroup")[
  Let $G$ be a group and $N <= G$ a subgroup. $N$ is *normal* in
  $G$, written $N ⊲ G$, if
  $
    a N = N a quad "for all" a in G,
  $
  where $a N = {a n | n in N}$ and $N a = {n a | n in N}$ are the
  left and right cosets of #link(<def:coset>)[§3.2]. If no
  ambient group needs to be named, $N$ is simply called *normal*.
] <def:normal-subgroup>

Two remarks are in order. First, normality is *relative to $G$*: the
same subgroup may be normal in one ambient group and not in another.
Second, $a N = N a$ is *not* the assertion that $a n = n a$ for every
$n in N$ — only that the two *sets* coincide; commutativity of
elements is far stronger, and is the special property of abelian
groups (which we exploit below). The slogan: normal subgroups are
those for which left and right cosets are the *same partition* of $G$,
not just same-sized partitions.

#theorem(name: "Equivalent Characterizations of Normality")[
  Let $N <= G$. The following are equivalent:
  + $a N = N a$ for every $a in G$.
  + $a N a^(-1) subset.eq N$ for every $a in G$.
  + $a n a^(-1) in N$ for every $a in G$, $n in N$.
  + $N$ is invariant under every inner automorphism $phi_a(x) = a x
    a^(-1)$ of $G$.
] <thm:normal-equivalents>

#proof[
  $(1) arrow.r.double (2)$: from $a N = N a$, multiply on the right
  by $a^(-1)$ to obtain $a N a^(-1) = N$, which in particular gives
  $a N a^(-1) subset.eq N$.

  $(2) arrow.r.double (3)$: element-wise specialization: $a n
  a^(-1) in a N a^(-1) subset.eq N$.

  $(3) arrow.r.double (4)$: condition (3) says precisely $phi_a(N)
  subset.eq N$; applying it to $a^(-1)$ gives $phi_(a^(-1))(N)
  subset.eq N$, which (relabeling $n$ as $a^(-1) n a$) yields the
  reverse inclusion $N subset.eq phi_a(N)$.

  $(4) arrow.r.double (1)$: invariance under $phi_a$ means $a N
  a^(-1) = N$, hence $a N = N a$ by right multiplication.
]

The third reformulation — closure under conjugation — is the working
test for normality: to verify $N ⊲ G$ one checks that $a n a^(-1) in
N$ for arbitrary $a$ and $n$. The fourth — invariance under inner
automorphisms — is the structural one: normal subgroups are precisely
those stable under the natural "change of frame" of the group.

#property(name: "Basic Properties of Normal Subgroups")[
  Let $G$ be a group.
  + Every subgroup of an abelian group is normal. The trivial
    subgroup $\\{e\\}$ and $G$ itself are normal in $G$.
  + If $N, M ⊲ G$, then $N inter M$ and the product $N M = {n m | n
    in N, m in M}$ are normal in $G$.
  + If $[G : N] = 2$, then $N ⊲ G$. In particular $A_n ⊲ S_n$ for
    $n >= 2$ (since $abs(A_n) = n! \/ 2$ by
    #link(<def:alternating-group>)[§3.3]).
  + The union of normal subgroups need not be normal — indeed, need
    not be a subgroup at all.
] <prop:normal-properties>

#proof[
  (1) Abelian: $a N = {a n} = {n a} = N a$ for every $a$, so every
  subgroup qualifies. The two trivial subgroups are visibly invariant
  under conjugation.

  (2) For the intersection: $a (N inter M) a^(-1) = a N a^(-1) inter
  a M a^(-1) = N inter M$. For the product: $a (n m) a^(-1) = (a n
  a^(-1))(a m a^(-1))$, a product of one element of $N$ and one of
  $M$, hence in $N M$.

  (3) When $[G : N] = 2$ there are exactly two left cosets — $N$ and
  $a N$ for any $a$ outside $N$ — and exactly two right cosets — $N$
  and $N a$. The set of elements outside $N$ is therefore equal to
  both $a N$ and $N a$, giving $a N = N a$ for every $a$ outside $N$
  (and trivially for $a in N$).

  (4) is the business of #link(<ex:non-normal>)[the example below].
]

#example[
  (A gallery of normal subgroups.)
  + In #link(<ex:a3-alternating>)[§3.3] we observed that $A_3 = {e,
    (1 2 3), (1 3 2)}$ has index $2$ in $S_3$, so $A_3 ⊲ S_3$ by
    #link(<prop:normal-properties>)[property (3)]. The same argument
    lifts: $A_n ⊲ S_n$ for every $n >= 2$.
  + The *special linear group* $"SL"_n(F)$ of
    #link(<def:general-linear-group>)[§2.2] is normal in
    $"GL"_n(F)$: it is the kernel of the determinant
    $
      det: "GL"_n(F) -> F^times,
    $
    a first taste of the general principle — *kernels of
    homomorphisms are normal* — systematised in
    #link(<note:kernel-preliminary>)[Chapter 5].
  + The *center* $Z(G) = {z in G | z g = g z "for all" g in G}$ is
    normal: $a z a^(-1) = z$ for $z in Z(G)$, so $a Z(G) a^(-1) =
    Z(G)$.
  + In an abelian group every subgroup is normal: $n bb(Z) ⊲ bb(Z)$
    for every $n >= 1$ — the foundation of
    #link(<ex:residue-classes>)[Chapter 1].
] <ex:normal-examples>

#example(name: "A Subgroup That Is Not Normal")[
  Recall $K = ⟨(1 2)⟩ = {e, (1 2)} <= S_3$ from
  #link(<ex:s3-cosets>)[§3.2]. The left coset
  $
    (1 3) K = {(1 3), (1 2 3)},
  $
  while the right coset is
  $
    K (1 3) = {(1 3), (1 3 2)}.
  $
  Since $(1 2 3) != (1 3 2)$, $(1 3) K != K (1 3)$; condition (1) of
  #link(<thm:normal-equivalents>)[the equivalent characterizations]
  fails, so $K$ is not normal in $S_3$. This is the kind of
  "blindness" Lagrange's theorem cannot see: $abs(S_3) = 3 dot
  abs(K)$ either way.
] <ex:non-normal>

#property(name: "Normal Closure")[
  Let $S subset.eq G$ be any subset. The *normal closure* of $S$ in
  $G$, written $⟨⟨S⟩⟩_G$, is the smallest normal subgroup of $G$
  containing $S$ — equivalently, the intersection of all normal
  subgroups of $G$ that contain $S$. Concretely,
  $
    ⟨⟨S⟩⟩_G = ⟨g s g^(-1) : s in S, g in G⟩,
  $
  the subgroup generated by the entire conjugacy class of $S$ in $G$.
  It is normal because conjugating a generator by $a in G$ permutes
  the generators: $a (g s g^(-1)) a^(-1) = (a g) s (a g)^(-1)$, again
  a generator.
] <prop:normal-closure>

Normal closure is the construction of choice when one needs *the*
smallest normal subgroup containing a given set — it will return, for
instance, when we ask which normal subgroup a generating set of $G$
produces (and so, indirectly, in
#link(<note:kernel-preliminary>)[Chapter 5], when we examine kernels
of homomorphisms from $G$).

== Quotient Groups // 商群

Chapter 1 closed §1.2 with a warning, enshrined in
#link(<caution:well-defined-operations>)[a caution]: an operation on
the equivalence classes of a quotient set descends cleanly only when
the underlying equivalence relation is *compatible* with the
operation. The congruence relation $a tilde b "iff" a - b in n bb(Z)$
satisfied this for addition and multiplication, and the residue-class
arithmetic of #link(<ex:residue-classes>)[Chapter 1] descended to
$bb(Z)_n$. The same compatibility check, run on the coset relation
"$a tilde b "iff" a^(-1) b in N$" of
#link(<lem:coset-equivalent>)[§3.2], is the substance of this
section. The verdict is crisp: the descent succeeds *exactly* when
$N$ is normal.

#lemma(name: "Coset Multiplication Is Well-Defined iff Normal")[
  Let $N <= G$. The operation on left cosets
  $
    (a N) dot (b N) = (a b) N
  $
  is well-defined — that is, $a N = a' N$ and $b N = b' N$ imply
  $(a b) N = (a' b') N$ — if and only if $N ⊲ G$.
] <lem:coset-multiplication-well-defined>

#proof[
  $(arrow.r.double)$ Suppose $N ⊲ G$; by
  #link(<thm:normal-equivalents>)[criterion (3)] we may use $a n
  a^(-1) in N$ freely. Take representatives $a' = a n_1$ and $b' = b
  n_2$ with $n_1, n_2 in N$. By normality ($N b = b N$), there is
  $n_3 in N$ with $n_1 b = b n_3$. Then
  $
    a' b' = a n_1 b n_2 = a b n_3 n_2 in (a b) N,
  $
  giving $(a' b') N = (a b) N$ as required.

  $(arrow.l.double)$ Suppose the operation is well-defined. Fix
  $a in G$ and $n in N$. Since $n in N$, the cosets $n N$ and $e N$
  coincide (both equal $N$); well-definedness then forces
  $
    (n N) dot (a^(-1) N) = (e N) dot (a^(-1) N),
  $
  i.e. $(n a^(-1)) N = a^(-1) N$. By the coset-equality criterion
  #link(<lem:coset-equivalent>)[of §3.2], this is
  $
    (a^(-1))^(-1) (n a^(-1)) = a n a^(-1) in N,
  $
  which is normality.
]

The lemma fulfills the promise of
#link(<caution:well-defined-operations>)[Chapter 1] for groups: the
"compatibility check" is precisely the conjugation-closure condition
of #link(<thm:normal-equivalents>)[§4.1]. With well-definedness in
hand, the rest is a verification.

#theorem(name: "Quotient Group")[
  Let $N ⊲ G$. The set $G \/ N$ of left cosets of $N$ in $G$,
  equipped with the operation $(a N) dot (b N) = (a b) N$, is a
  group. The identity is $e N = N$, the inverse of $a N$ is
  $a^(-1) N$, and the *natural projection*
  $
    pi: G -> G \/ N, quad pi(a) = a N
  $
  is a surjective homomorphism with $"ker" pi = N$.
] <thm:quotient-group>

#proof[
  Closure and well-definedness are the lemma. Associativity is
  inherited from $G$:
  $
    ((a N) dot (b N)) dot c N = (a b) N dot c N = (a b c) N = a N
    dot (b c) N = a N dot ((b N) dot (c N)).
  $
  The coset $N = e N$ is the identity: $N dot a N = (e a) N = a N$
  and $a N dot N = (a e) N = a N$. The inverse of $a N$ is
  $a^(-1) N$ since $a N dot a^(-1) N = (a a^(-1)) N = N$, and the
  reverse product is the same. Thus $G \/ N$ is a group.

  For the projection: $pi(a b) = (a b) N = (a N) dot (b N) = pi(a)
  pi(b)$, so $pi$ is a homomorphism; it is surjective by
  construction, and
  $
    "ker" pi = {a in G | a N = N} = N
  $
  by the coset-equality criterion.
]

#figure(
  image("img/quotient-projection.svg", width: 80%),
  caption: [The quotient map collapses each coset of $N$ to a
    single point. *Left:* the group $G$ (here $S_3$, six
    permutations) partitioned by $N = A_3$ into two cosets — $N$
    itself (highlighted) and the reflected coset $(1 2) N$.
    *Right:* the quotient $G \/ N$, a two-element group whose
    identity is the coset $N$ and whose other element is $(1 2) N$.
    The natural projection $pi: G -> G \/ N$ sends every element of
    a coset to the corresponding point; the multiplication of
    cosets, $(a N)(b N) = (a b) N$, is exactly multiplication in
    $G \/ N$.],
  placement: auto,
  supplement: [Fig.],
) <fig:quotient-projection>

#property(name: "Order of the Quotient")[
  For a finite group $G$ and $N ⊲ G$,
  $
    abs(G \/ N) = [G : N] = abs(G) \/ abs(N).
  $
  In particular $abs(N)$ divides $abs(G)$ (as
  #link(<thm:lagrange>)[Lagrange] already guaranteed) and
  $abs(G \/ N)$ divides $abs(G)$.
] <prop:quotient-order>

#proof[
  The elements of $G \/ N$ are the left cosets of $N$; their count is
  $[G : N]$ by #link(<def:index>)[definition], and
  #link(<thm:lagrange>)[Lagrange] gives $abs(G) = [G : N] dot
  abs(N)$.
]

#example[
  (Residue classes as a quotient.) For $G = (bb(Z), +)$ and $N = n
  bb(Z)$ (which is normal since $bb(Z)$ is abelian), the quotient
  $G \/ N$ is precisely $bb(Z) \/ n bb(Z) = bb(Z)_n$ of
  #link(<ex:residue-classes>)[Chapter 1], now revealed as a genuine
  quotient group. The coset $a + N$ is the residue class $[a]$, and
  the addition $([a]) + ([b]) = ([a + b])$ is exactly the coset
  multiplication of #link(<thm:quotient-group>)[the theorem]. The
  natural projection $pi: bb(Z) -> bb(Z)_n$, $pi(a) = [a]$, is the
  classical "mod $n$" map.
] <ex:quotient-zn>

#example[
  (Parity as a quotient.) The subgroup $A_3 ⊲ S_3$ has index $2$
  (#link(<ex:a3-alternating>)[§3.3]), so $S_3 \/ A_3$ is a group of
  order $2$, hence isomorphic to $bb(Z)_2$ by
  #link(<ex:low-order-classification>)[the order-$2$ case]. The two
  cosets — $A_3$ (the even permutations) and $(1 2) A_3$ (the odd
  ones) — multiply as one would expect: even$dot$even $=$ even,
  odd$dot$odd $=$ even, mixed $=$ odd. In other words, the sign map
  $"sign": S_3 -> {plus.minus 1} ~= bb(Z)_2$ of
  #link(<def:alternating-group>)[§3.3] *is* (up to isomorphism) the
  natural projection $S_3 -> S_3 \/ A_3$. The same pattern holds in
  every degree: $S_n \/ A_n ~= bb(Z)_2$ for $n >= 2$.
] <ex:s3-quotient>

#example[
  (Orientation as a quotient.) Let $D_n$ be the dihedral group of
  #link(<def:dihedral-group>)[§2.2] — symmetries of a regular
  $n$-gon — and let $r$ denote the rotation by $2 pi \/ n$. The
  subgroup $⟨r⟩$ of rotations is normal in $D_n$: it has index $2$
  (the rotations tile the group with the reflections), so
  #link(<prop:normal-properties>)[property (3)] applies. The
  quotient
  $
    D_n \/ ⟨r⟩ ~= bb(Z)_2
  $
  captures the single bit "rotation or reflection" — the
  orientation of a symmetry. Multiplication in the quotient is
  exactly the orientation rule: two rotations compose to a rotation,
  two reflections to a rotation, mixed to a reflection. The quotient
  thus *forgets* the angle of rotation and retains only the
  orientation type.
] <ex:dihedral-quotient>

#note[
  (The universal property, a first taste.) The natural projection
  $pi: G -> G \/ N$ is more than a homomorphism: it is the
  *universal* homomorphism out of $G$ whose kernel contains $N$.
  Precisely, any homomorphism $f: G -> H$ with $N subset.eq "ker" f$
  factors uniquely through $G \/ N$ — that is, there is a unique
  homomorphism $f^~: G \/ N -> H$ with $f = f^~ compose pi$. This
  factorization, the content of the *First Isomorphism Theorem*, is
  the subject of #link(<note:kernel-preliminary>)[Chapter 5]; it
  underlies the homomorphism-theoretic reading of normal subgroups
  as "kernels" and of quotient groups as "images, up to isomorphism,
  of homomorphisms from $G$."
] <note:natural-projection-universal>

== Simple Groups // 单群

Normal subgroups, we have just seen, are the price of admission for
a quotient: $G \/ N$ exists only when $N ⊲ G$, and the resulting
quotient measures how much of $G$'s structure $N$ collapses. At one
extreme sit the trivial cases $N = \\{e\\}$ (quotient $G \/ \\{e\\} ~=
G$, no collapse) and $N = G$ (quotient $G \/ G$ is the one-element
trivial group, total collapse). At the other extreme sit groups
*with no non-trivial normal subgroups at all* — groups, that is,
that admit no non-trivial quotient. These are the *simple* groups,
and they play in group theory the role that primes play in
arithmetic: the atoms from which, by a yet-undeveloped composition
process, every finite group is built.

#definition(name: "Simple Group")[
  A group $G$ is *simple* if its only normal subgroups are the
  trivial subgroup $\\{e\\}$ and $G$ itself. An abelian simple group
  is necessarily cyclic of prime order (see
  #link(<thm:abelian-simple>)[below]); the non-abelian case is the
  subtler one.
] <def:simple-group>

#theorem(name: "Abelian Simple Groups")[
  An abelian group is simple if and only if it is cyclic of prime
  order.
] <thm:abelian-simple>

#proof[
  $(arrow.r.double)$ Let $G = bb(Z)_p$ with $p$ prime, and let $H
  ⊲ G$. By #link(<thm:lagrange>)[Lagrange], $abs(H)$ divides
  $abs(G) = p$; the only divisors are $1$ and $p$, so $abs(H) = 1$
  ($H = \\{e\\}$) or $abs(H) = p$ ($H = G$). Hence $bb(Z)_p$ is
  simple.

  $(arrow.l.double)$ Let $G$ be a simple abelian group. Abelian
  implies every subgroup is normal
  (#link(<prop:normal-properties>)[property (1)]), so simple
  abelian = "no non-trivial subgroups". Pick any $a in G$ with $a
  != e$; the cyclic subgroup $⟨a⟩$ is non-trivial, so $⟨a⟩ = G$,
  i.e. $G$ is cyclic. By
  #link(<thm:cyclic-classification>)[Chapter 2], $G ~= bb(Z)$ or
  $G ~= bb(Z)_n$ for some $n$. The infinite case is excluded:
  $⟨a^2⟩$ would be a non-trivial proper subgroup of $bb(Z)$. So $G
  ~= bb(Z)_n$ for some $n >= 2$, and
  #link(<thm:cyclic-subgroups>)[the subgroup structure of cyclic
  groups] gives one subgroup of each order dividing $n$;
  simplicity forces $n$ to have no non-trivial divisors, i.e. $n =
  p$ is prime.
]

#example[
  (The atomic abelian groups.) For each prime $p$, the cyclic
  group $bb(Z)_p$ is the unique abelian simple group of order $p$ —
  by #link(<thm:cyclic-classification>)[Chapter 2] it is the only
  cyclic group of that order, and by
  #link(<thm:abelian-simple>)[the theorem] it is simple. These are
  the simplest non-trivial groups in existence: $bb(Z)_2$ sits
  underneath the parity quotient $S_n \/ A_n ~= bb(Z)_2$ of
  #link(<ex:s3-quotient>)[§4.2], and $bb(Z)_3$ is the rotating part
  of $D_3 ~= S_3$. They are the building blocks of the structure
  theorem for finite abelian groups, to which
  #link(<note:composition-series-preview>)[a later note] returns.
] <ex:cyclic-prime-simple>

#theorem(name: "Simplicity of $A_n$ for $n >= 5$")[
  For $n >= 5$, the alternating group $A_n$ is simple.
] <thm:an-simple>

#proof[
  The argument is substantial; we record the four-step strategy,
  with full details to be revisited elsewhere.

  + *3-cycles generate.* For $n >= 3$, every element of $A_n$ is a
    product of 3-cycles: a $k$-cycle decomposes into $k - 1$
    transpositions by
    #link(<prop:transpositions-generate>)[§3.3], and any
    even-length product of transpositions is, by a case-by-case
    verification, a product of 3-cycles.

  + *A non-trivial normal $N$ contains a 3-cycle.* This is the
    technical heart: the structure of $A_n$ for $n >= 5$ is rich
    enough that conjugating any non-identity element of $N$ by a
    suitable 3-cycle yields a 3-cycle still inside $N$ (one uses
    that the support of the conjugating element can be made
    disjoint from that of the given element when $n$ is large
    enough).

  + *All 3-cycles are conjugate in $A_n$ for $n >= 5$.* Two
    3-cycles in $S_n$ are conjugate "iff" they have the same cycle
    type, and the conjugating element can be chosen inside $A_n$
    once $n >= 5$ (one has enough "extra" points to flip the parity
    of the conjugator if needed). Thus $N$, containing one
    3-cycle, contains them all.

  + *Conclusion.* By (1) and (3), $N$ contains every 3-cycle and
    every product of 3-cycles; but these generate $A_n$, so $N =
    A_n$.
]

#example[
  ($A_5$, the smallest non-abelian simple group.) The alternating
  group $A_5$ has order $5! \/ 2 = 60$ and is, by
  #link(<thm:an-simple>)[the theorem above], simple. It is the
  symmetry group of the icosahedron (or, equivalently, of the
  dodecahedron): the $60$ rotations of a regular icosahedron form a
  group isomorphic to $A_5$. As the smallest non-abelian simple
  group, $A_5$ is the first obstruction to "solvability" of a
  finite group — a notion that returns in Chapter 6 and, ultimately,
  in Chapter 16 decides which polynomial equations are solvable by
  radicals.
] <ex:a5-simple>

#note[
  (The classification of finite simple groups.) The simple groups
  are the periodic table of finite group theory, and the
  classification theorem — completed in $2004$ after a multi-decade,
  tens-of-thousands-of-pages effort — lists them all:
  + the cyclic groups $bb(Z)_p$ for $p$ prime (the abelian ones, by
    #link(<thm:abelian-simple>)[the theorem]);
  + the alternating groups $A_n$ for $n >= 5$
    (#link(<thm:an-simple>)[above]);
  + the finite groups of Lie type (e.g. the projective special
    linear groups $"PSL"_n(q)$, including $A_5 ~= "PSL"_2(4)$);
  + $26$ *sporadic* groups, ranging from the Mathieu groups in
    degrees $12$ and $24$ up to the *Monster* of order about $8
    times 10^53$.

  Every finite simple group is on this list; and every finite
  group, by the Jordan–Hölder programme, is a "stack" of such
  simple factors — see #link(<note:composition-series-preview>)[the
  following note].
] <note:classification-finite-simple>

#note[
  (Composition series, a preview.) A *composition series* for a
  finite group $G$ is a chain
  $
    G = G_0 ⊳ G_1 ⊳ dots ⊳ G_k = \\{e\\}
  $
  in which each $G_(i+1)$ is normal in $G_i$ and the quotients $G_i
  \/ G_(i+1)$ are simple. The *Jordan–Hölder theorem* states that
  any two composition series for $G$ have the same length and the
  same multiset of simple factors (up to reordering and
  isomorphism). In particular, the simple factors are invariants of
  $G$. This is the precise sense in which simple groups are the
  "atoms" of finite group theory: every finite group is determined
  — up to the way its simple factors are stacked — by those factors
  themselves.

  For abelian $G$, the theorem reduces to the structure theorem
  for finite abelian groups, the subject of Chapter 7. For
  non-abelian $G$, the question of which "stackings" of given simple
  factors actually yield a group is the *extension problem*, which
  remains intractable in general — the price one pays for replacing
  "elements" by "simple quotients".
] <note:composition-series-preview>

Chapter 4 closes. We began with the fault line of
#link(<ex:s3-cosets>)[§3.2] — the asymmetry between left and right
cosets — and isolated it under the name *normal subgroup* (§4.1).
Normality turned out to be exactly the condition that makes coset
multiplication well-defined, redeeming
#link(<caution:well-defined-operations>)[the promise of Chapter 1];
the resulting *quotient group* $G \/ N$ and its natural projection
$pi$ gave us our first universal homomorphism out of $G$ (§4.2). The
chapter closed with *simple groups* — the atoms of group theory,
admitting no further quotient (§4.3). The story so far says *when*
one can take a quotient; Chapter 5 says *why* one does — every
homomorphism $f: G -> H$ is, up to isomorphism, the natural
projection $G -> G \/ "ker" f$.

// ==========================================================================
// Chapter 5: 群的同态定理
// ==========================================================================

= Homomorphism Theorems for Groups // 群的同态定理

Chapter 4 closed on a promise: every homomorphism $f: G -> H$ is,
up to isomorphism, the natural projection $G -> G \/ "ker" f$. This
chapter fulfills it. §5.1 strengthens the homomorphism concept of
#link(<def:homomorphism>)[Chapter 1] for the group setting:
kernels — previewed in #link(<note:kernel-preliminary>)[§1.3] — are
not merely subgroups but *normal* subgroups, exactly the structures
that support a quotient (§4.1). §5.2 then states and proves the
*First Isomorphism Theorem* $G \/ "ker" f ~= "im" f$, the precise
form of #link(<note:natural-projection-universal>)[§4.2]'s universal
property, and unpacks its consequence: every $f$ factors as natural
projection, isomorphism, and inclusion. §5.3 closes with the
*Second* and *Third Isomorphism Theorems* — refinements of the First
at the level of subgroups — and the *Correspondence Theorem* that
links the subgroup lattices of $G$ and $G \/ N$. Together, these
four theorems are the first great structural result of group theory,
and the template for the analogous theorems in ring theory (§9.3)
and module theory (§17.3).

== Homomorphisms of Groups // 群的同态

The homomorphism concept of #link(<def:homomorphism>)[§1.3] was
stated for any algebraic system with one operation. Specialised to
groups — where every element has an inverse — it acquires two
features invisible in the general setting: the image of the identity
is *always* the identity (no surjectivity needed, redeeming
#link(<prop:homomorphism-properties>)[§1.3]'s caveat), and the
kernel is *always* normal (the link between homomorphisms and
quotients).

#property(name: "Group Homomorphisms Preserve Structure")[
  Let $f: G -> H$ be a homomorphism of groups, with identities
  $e in G$, $e' in H$.
  + $f(e) = e'$ — no surjectivity required.
  + $f(a^(-1)) = f(a)^(-1)$ for every $a in G$.
  + $f(a^n) = f(a)^n$ for every $a in G$, $n in bb(Z)$.
  + If $K <= G$ then $f(K) <= H$; if $K ⊲ G$ then $f(K) ⊲ f(G)$.
  + If $L <= H$ then $f^(-1)(L) <= G$; if $L ⊲ H$ then
    $f^(-1)(L) ⊲ G$.
] <prop:group-homomorphism-properties>

#proof[
  (1) For any $a in G$, $f(a) = f(a dot e) = f(a) dot f(e)$; by
  #link(<prop:group-basic-properties>)[cancellation in $H$], $f(e) =
  e'$.

  (2) $e' = f(e) = f(a a^(-1)) = f(a) f(a^(-1))$, so $f(a^(-1))$ is
  an inverse of $f(a)$, hence equals $f(a)^(-1)$ by uniqueness of
  inverses.

  (3) For $n >= 0$ this is induction on $n$; for $n < 0$ combine the
  $n > 0$ case with (2).

  (4) Closure: $f(a), f(b) in f(K)$ with $a, b in K$ gives $f(a)
  f(b)^(-1) = f(a b^(-1)) in f(K)$ by (2), since $K$ is closed under
  $a b^(-1)$. For normality when $K ⊲ G$: take $f(a) in f(G)$ and
  $f(k) in f(K)$, then $f(a) f(k) f(a)^(-1) = f(a k a^(-1)) in
  f(K)$ by normality of $K$ in $G$.

  (5) For $L <= H$ and $a, b in f^(-1)(L)$: $f(a b^(-1)) = f(a)
  f(b)^(-1) in L$, so $a b^(-1) in f^(-1)(L)$. For normality when
  $L ⊲ H$: $a in G$, $b in f^(-1)(L)$ gives $f(a b a^(-1)) = f(a)
  f(b) f(a)^(-1) in L$ since $L ⊲ H$, hence $a b a^(-1) in
  f^(-1)(L)$.
]

#definition(name: "Kernel and Image")[
  Let $f: G -> H$ be a group homomorphism. The *kernel* of $f$ is
  $
    "ker" f = {a in G | f(a) = e'},
  $
  and the *image* of $f$ is
  $
    "im" f = {f(a) | a in G}.
  $
  By #link(<prop:group-homomorphism-properties>)[property (4) and
  (5)] $"ker" f <= G$ and $"im" f <= H$.
] <def:kernel-image>

This formalises #link(<note:kernel-preliminary>)[§1.3]'s
preliminary kernel. The key new fact — invisible at the level of
general algebraic systems, where inverses need not exist for every
element — is that the kernel is *normal*.

#theorem(name: "Kernels Are Normal")[
  For any group homomorphism $f: G -> H$, the kernel $"ker" f$ is a
  normal subgroup of $G$.
] <thm:kernel-normal>

#proof[
  We verify criterion (3) of
  #link(<thm:normal-equivalents>)[§4.1]: for $a in G$ and $n in
  "ker" f$ we must show $a n a^(-1) in "ker" f$. Compute
  $
    f(a n a^(-1)) = f(a) f(n) f(a)^(-1) = f(a) dot e' dot f(a)^(-1)
    = e',
  $
  using #link(<prop:group-homomorphism-properties>)[property (1) and
  (2)] and the fact that $f(n) = e'$ (since $n in "ker" f$). Hence
  $a n a^(-1) in "ker" f$ as required.
]

The theorem has a striking converse, which we record for emphasis:
*every* normal subgroup of $G$ is the kernel of *some* homomorphism
— namely, the natural projection $pi: G -> G \/ N$ of
#link(<thm:quotient-group>)[§4.2], whose kernel is exactly $N$. So
the link between "normal subgroup" and "kernel of a homomorphism"
is exact:
$
  {N ⊲ G} <-> {"ker" f | f: G -> H "for some" H}.
$

#example[
  (Determinant as a homomorphism.) The determinant map
  $
    det: "GL"_n(F) -> F^times, quad A |-> det(A),
  $
  is a homomorphism since $det(A B) = det(A) det(B)$. Its kernel is
  $
    "ker"(det) = {A in "GL"_n(F) | det(A) = 1} = "SL"_n(F),
  $
  the special linear group of #link(<def:general-linear-group>)[§2.2]
  and #link(<ex:normal-examples>)[§4.1]. Theorem
  #link(<thm:kernel-normal>)[above] re-proves, in one line, that
  $"SL"_n(F) ⊲ "GL"_n(F)$.
] <ex:det-kernel>

#example[
  (Sign as a homomorphism.) The sign map
  $
    "sign": S_n -> {plus.minus 1}, quad sigma |-> "sign"(sigma),
  $
  recording the parity of a permutation, is a homomorphism since the
  sign of a product is the product of the signs (see
  #link(<def:alternating-group>)[§3.3]). Its kernel is
  $
    "ker"("sign") = {sigma in S_n | "sign"(sigma) = +1} = A_n,
  $
  the alternating group. Again, Theorem
  #link(<thm:kernel-normal>)[above] re-proves, in one line, that
  $A_n ⊲ S_n$ — the result of
  #link(<prop:normal-properties>)[§4.1 property (3)], recovered from
  a structural perspective.
] <ex:sign-kernel>

The two examples share a common shape: a "natural" homomorphism
out of $G$ produces, as kernel, a "natural" normal subgroup. The
First Isomorphism Theorem will run this construction in reverse —
given $N ⊲ G$, it finds a homomorphism (the natural projection) with
kernel $N$.

#property(name: "Image Is a Subgroup")[
  For any homomorphism $f: G -> H$, the image $"im" f$ is a
  subgroup of $H$. The corestriction — same mapping rule, target
  restricted to the image — is a *surjective* homomorphism $G ->
  "im" f$ with the same kernel as $f$.
] <prop:image-subgroup>

#proof[
  Immediate from #link(<prop:group-homomorphism-properties>)[property
  (4)] with $K = G$: $f(G) = "im" f <= H$. Surjectivity of the
  corestriction is by construction, and the kernel is unchanged
  since the mapping rule is.
]

#example[
  (Two extreme homomorphisms.) Let $G$ be any group.
  + For any subgroup $H <= G$, the *inclusion* $i: H -> G$, $i(h) =
    h$, is an injective homomorphism with $"ker" i = {e_H}$ and
    $"im" i = H$. The kernel is as small as possible — trivial — so
    $i$ "forgets nothing".
  + For any $N ⊲ G$, the *natural projection* $pi: G -> G \/ N$,
    $pi(a) = a N$, of #link(<thm:quotient-group>)[§4.2] is a
    surjective homomorphism with $"ker" pi = N$ and $"im" pi = G \/
    N$. The kernel is as large as $N$ — chosen by us — and the
    projection "forgets exactly $N$'s worth of structure".

  Every homomorphism sits between these two extremes; the First
  Isomorphism Theorem will say that it is, up to isomorphism, the
  composite of a projection with an inclusion.
] <ex:inclusion-projection>

== First Isomorphism Theorem // 第一同构定理

The two extreme examples of #link(<ex:inclusion-projection>)[above] —
inclusions (trivial kernel) and projections (kernel $N$, image $G \/ N$)
— are the building blocks of *every* homomorphism. Given $f: G -> H$,
the projection $pi: G -> G \/ "ker" f$ quotients out exactly the
information $f$ forgets, and the inclusion $i: "im" f -> H$ records
where the images land. The First Isomorphism Theorem says that what
remains in between is an isomorphism: the quotient $G \/ "ker" f$
recovers, up to renaming, exactly the image $"im" f$.

#theorem(name: "First Isomorphism Theorem")[
  Let $f: G -> H$ be a group homomorphism. The map
  $
    overline(f): G \/ "ker" f -> "im" f, quad a("ker" f) |-> f(a),
  $
  is a well-defined isomorphism. In particular,
  $
    G \/ "ker" f ~= "im" f.
  $
] <thm:first-isomorphism>

#proof[
  We verify four things in turn: that $overline(f)$ is well-defined,
  a homomorphism, injective, and surjective.

  *Well-defined.* If $a("ker" f) = b("ker" f)$ then $b^(-1) a in
  "ker" f$ by #link(<def:coset>)[§3.2], so $f(b^(-1) a) = e'$, i.e.
  $f(b)^(-1) f(a) = e'$, giving $f(a) = f(b)$. Thus $overline(f)$
  depends only on the coset, not on the representative.

  *Homomorphism.* For $a, b in G$,
  $
    overline(f)(a("ker" f) dot b("ker" f)) &= overline(f)((a b)("ker"
    f)) = f(a b) \
    &= f(a) f(b) = overline(f)(a("ker" f)) dot overline(f)(b("ker" f)),
  $
  using the definition of the quotient operation
  (#link(<thm:quotient-group>)[§4.2]) and that $f$ is a homomorphism.

  *Injective.* If $overline(f)(a("ker" f)) = e'$, then $f(a) = e'$,
  so $a in "ker" f$, i.e. $a("ker" f) = "ker" f$ — the identity of
  $G \/ "ker" f$. The kernel of $overline(f)$ is trivial.

  *Surjective.* By definition, every element of $"im" f$ is of the
  form $f(a) = overline(f)(a("ker" f))$ for some $a in G$.

  Being a well-defined, injective and surjective homomorphism,
  $overline(f)$ is an isomorphism.
]

#figure(
  image("img/first-isomorphism.svg"),
  caption: [The First Isomorphism Theorem as a commutative diagram:
    every row is exact, and $overline(f)$ fills the dashed arrow as
    the canonical isomorphism $G \/ "ker" f ~= "im" f$.],
) <fig:first-isomorphism>

The theorem unpacks into a *factorization* of $f$, which is often
more useful in practice than the bare isomorphism.

#corollary(name: "Homomorphism Factorization")[
  Every group homomorphism $f: G -> H$ factors as
  $
    G arrow.r^pi G \/ "ker" f arrow.r^(overline(f)) "im" f
    arrow.r.hook H,
  $
  where $pi$ is the natural projection, $overline(f)$ is the
  isomorphism of #link(<thm:first-isomorphism>)[the theorem], and
  the last arrow is the inclusion. In particular, every homomorphism
  is — up to isomorphism — a projection followed by an inclusion.
] <cor:homomorphism-factorization>

This is the sense in which #link(<ex:inclusion-projection>)[the two
extremes] generate all homomorphisms: any $f$ is recovered from its
kernel (deciding what to forget) and its image (deciding where to
land), with the quotient doing the rest.

#example[
  (Cyclic groups from $bb(Z)$.) Consider the homomorphism
  $
    phi: bb(Z) -> bb(Z)_n, quad k |-> overline(k) = k + n bb(Z),
  $
  mapping an integer to its residue modulo $n$. It is surjective,
  with kernel $"ker" phi = n bb(Z)$. The First Isomorphism Theorem
  recovers the classification of cyclic groups of order $n$:
  $
    bb(Z) \/ n bb(Z) ~= bb(Z)_n.
  $
  The same construction with $n = 0$ gives $bb(Z) \/ {0} ~= bb(Z)$,
  and the infinite cyclic group is recovered as a quotient of
  itself.
] <ex:zn-iso>

#example[
  (Sign map and $bb(Z)_2$.) The sign homomorphism of
  #link(<ex:sign-kernel>)[§5.1],
  $
    "sign": S_n -> {plus.minus 1},
  $
  is surjective with kernel $A_n$. The First Isomorphism Theorem
  gives
  $
    S_n \/ A_n ~= {plus.minus 1} ~= bb(Z)_2,
  $
  re-deriving from #link(<def:alternating-group>)[§3.3] the structural
  fact that $A_n$ has index $2$ in $S_n$ (hence is normal): $S_n \/ A_n$
  has order $2$, and any group of order $2$ is isomorphic to
  $bb(Z)_2$.

  The same pattern recovers $bb(Z)_2$ from the determinant:
  $bb(R)^times$ has a sign component, and
  $
    "GL"_n(bb(R)) \/ "GL"_n^+(bb(R)) ~= {plus.minus 1} ~= bb(Z)_2,
  $
  where $"GL"_n^+(bb(R))$ is the subgroup of matrices with positive
  determinant (index $2$, hence normal).
] <ex:sign-iso>

#note[
  *Isomorphism invariants.* The First Isomorphism Theorem turns the
  question "compute $G \/ "ker" f$" into the often-easier question
  "compute $"im" f$". Combined with
  #link(<prop:group-homomorphism-properties>)[§5.1], this makes the
  following invariants cheap to read off from any homomorphism out of
  $G$:
  - *Order*: $abs(G \/ "ker" f) = abs("im" f)$, so quotients of $G$
    are bounded by the orders of its homomorphic images.
  - *Abelianness*: $G \/ "ker" f$ is abelian "iff" $"im" f$ is — quotients
    inherit commutativity from images and conversely.
  - *Simplicity*: if $G$ is simple, every non-trivial homomorphism
    out of $G$ is injective (its kernel cannot be $G$), so $G$ embeds
    into its image — the content of #link(<def:simple-group>)[§4.3].

  Conversely, to *show* two groups are isomorphic, build a
  surjective homomorphism between them and verify its kernel is
  trivial; the theorem does the rest.
] <note:iso-invariants>

With the First Isomorphism Theorem in hand, two refinements become
natural: what happens when we quotient by a larger normal subgroup
containing another, and what happens when we quotient a subgroup of
$G$ by its intersection with $N$. These are the *Second* and *Third*
Isomorphism Theorems, treated next.

== Second and Third Isomorphism Theorems // 第二与第三同构定理

The First Isomorphism Theorem identifies $G \/ "ker" f$ with $"im" f$.
Two natural follow-up questions arise:

  (a) If $N$, $K$ are both normal in $G$ with $N subset.eq K$, does
      $K \/ N$ sit inside $G \/ N$ as a normal subgroup, and is the
      further quotient $(G \/ N) \/ (K \/ N)$ the same as $G \/ K$?
  (b) If $H <= G$ and $N ⊲ G$, what is $H N \/ N$ in terms of $H$?

The *Third* Isomorphism Theorem answers (a) — quotienting "twice" is
the same as quotienting once by the larger subgroup. The *Second*
Isomorphism Theorem answers (b) — quotienting $H N$ by $N$ kills only
the $N$-part, leaving $H$ intact.

#theorem(name: "Second Isomorphism Theorem (Diamond Theorem)")[
  Let $G$ be a group, $H <= G$ a subgroup, and $N ⊲ G$ a normal
  subgroup. Then $H N$ is a subgroup of $G$, $N ⊲ H N$, $H ∩ N ⊲ H$,
  and
  $
    H N \/ N ~= H \/ (H ∩ N).
  $
] <thm:second-isomorphism>

#proof[
  *$H N$ is a subgroup.* For $h_1 n_1, h_2 n_2 in H N$ we have
  $(h_1 n_1)(h_2 n_2)^(-1) = h_1 h_2 (h_2^(-1) n_1 h_2)
  n_2^(-1)$. Since $N$ is normal, $h_2^(-1) n_1 h_2 in N$, so the
  product lies in $H N$; closure under inverses and products follows.

  *$N ⊲ H N$ and $H ∩ N ⊲ H$.* Both follow from
  #link(<thm:normal-equivalents>)[§4.1 criterion (3)]: $N$ is normal
  in $G$, hence in any subgroup containing it; $H ∩ N$ is the
  intersection of $H$ with a normal subgroup of $G$, which
  #link(<prop:normal-properties>)[§4.1 property (4)] shows is normal
  in $H$.

  *The isomorphism.* Consider the homomorphism
  $
    phi: H -> H N \/ N, quad h |-> h N,
  $
  i.e. the restriction of the projection $H N -> H N \/ N$ to $H$. It
  is surjective: every coset $h n N$ equals $h N$ since $n in N$.
  Its kernel is $H ∩ N$ (those $h in H$ with $h in N$). The First
  Isomorphism Theorem
  (#link(<thm:first-isomorphism>)[§5.2]) gives the result.
]

The theorem is called the *diamond* theorem because the four groups
form a diamond-shaped lattice, with $H N$ at the top, $H ∩ N$ at
the bottom, and $H$, $N$ on the sides; opposite sides of the diamond
have isomorphic quotients.

#example[
  (A diamond in $S_4$.) Take $G = S_4$, $H = S_3$ (the stabiliser of
  $4$, embedded as permutations of ${1, 2, 3}$), and
  $N = V_4 = {e, (1 2)(3 4), (1 3)(2 4), (1 4)(2 3)}$ the Klein
  four-group, normal in $S_4$ (it is the kernel of the conjugation
  action of $S_4$ on ${(1 2), (1 3), (1 4), (2 3), (2 4), (3 4)}$).
  Then
  $
    H ∩ N = {e, (1 2)(3 4)}, quad H N \/ N ~= H \/ (H ∩ N)
    ~= S_3 \/ bb(Z)_2 ~= "Dih"_6,
  $
  the dihedral group of order $6$. The quotient $S_4 \/ V_4 ~= S_3$
  is itself a Second Isomorphism Theorem computation with $H = S_3$
  and $N = V_4$: $S_4 \/ V_4 ~= S_3$, recovering the well-known
  isomorphism from #link(<ex:normal-examples>)[§4.1] via a direct
  application of the theorem.
] <ex:s4-diamond>

#theorem(name: "Third Isomorphism Theorem")[
  Let $G$ be a group with $N$, $K ⊲ G$ and $N subset.eq K$. Then
  $K \/ N ⊲ G \/ N$ and
  $
    (G \/ N) \/ (K \/ N) ~= G \/ K.
  $
] <thm:third-isomorphism>

#proof[
  Consider the composite
  $
    G arrow.r^pi G \/ N arrow.r^q (G \/ N) \/ (K \/ N),
  $
  where $pi$ is the natural projection and $q$ is the quotient by
  $K \/ N$. This is a surjective homomorphism $psi: G -> (G \/ N)
  \/ (K \/ N)$. Its kernel is $K$: $a in "ker" psi$ "iff" $a N$ lies in
  $K \/ N$, "iff" $a in K$ (since $K \/ N$ consists of cosets $k N$
  with $k in K$). The First Isomorphism Theorem
  (#link(<thm:first-isomorphism>)[§5.2]) applied to $psi$ gives
  $
    (G \/ N) \/ (K \/ N) ~= G \/ "ker" psi = G \/ K.
  $
]

In words: *quotienting in stages is the same as quotienting once by
the larger normal subgroup*. The Third Isomorphism Theorem is the
formal justification for the colloquial fact that "killing $N$ and
then killing $K \/ N$ is the same as killing $K$ outright".

#example[
  (Modular arithmetic in stages.) Take $G = bb(Z)$ (additive), $K =
  6 bb(Z)$, $N = 2 bb(Z)$. Both are normal since $bb(Z)$ is abelian,
  and $N subset.eq K$ since $2 | 6$. The theorem gives
  $
    (bb(Z) \/ 2 bb(Z)) \/ (6 bb(Z) \/ 2 bb(Z)) ~= bb(Z) \/ 6 bb(Z),
  $
  i.e. $bb(Z)_2 \/ {0, 2, 4} ~= bb(Z)_6$ — quotienting $bb(Z)_2$
  (the parity classes) by the subgroup ${0, 2, 4}$ (the
  even-remainder subgroup) recovers $bb(Z)_6$. Concretely, the
  quotient collapses the two odd classes ${1, 3, 5}$ and
  ${0, 2, 4}$ of $bb(Z)_6$ viewed as a $bb(Z)_2$-module, leaving
  a single cyclic group of order $6$.
] <ex:modular-stages>

The third theorem is often summarised as: "$G$ has the same quotients
by $K$ whether or not we first quotient by a smaller $N$." The next
theorem is a related but distinct structural result: it says that
*every* normal subgroup of $G \/ N$ comes from a normal subgroup of
$G$ containing $N$.

#theorem(name: "Correspondence Theorem (Fourth Isomorphism Theorem)")[
  Let $G$ be a group, $N ⊲ G$, and $pi: G -> G \/ N$ the natural
  projection. The assignments
  $
    Phi: K |-> K \/ N, quad Psi: L |-> pi^(-1)(L)
  $
  are mutually inverse, inclusion-preserving bijections between
  ${K <= G | N subset.eq K}$ (subgroups of $G$ containing $N$) and
  the subgroups of $G \/ N$. Moreover, $K_1 subset.eq K_2$ iff
  $K_1 \/ N subset.eq K_2 \/ N$, and under this bijection $K ⊲ G$
  "iff" $K \/ N ⊲ G \/ N$, in which case
  $
    (G \/ N) \/ (K \/ N) ~= G \/ K
  $
  (recovering the Third Isomorphism Theorem).
] <thm:correspondence>

#proof[
  *$pi(K) = K \/ N$ is a subgroup of $G \/ N$* by
  #link(<prop:group-homomorphism-properties>)[§5.1 property (4)], and
  *the preimage of a subgroup is a subgroup* by the same property. We
  check the two maps are inverses.

  *$pi^(-1)(pi(K)) = K$:* $pi(K) = K \/ N$, and $pi^(-1)(K \/ N) = K$
  since $N subset.eq K$ — an element $a in G$ satisfies $a N in K \/ N$
  "iff" $a in K$.

  *$pi(pi^(-1)(L)) = L$:* since $pi$ is surjective (every coset of
  $G \/ N$ is of the form $pi(a) = a N$ for some $a$), this holds
  for any subgroup $L$ of $G \/ N$.

  *Inclusion preservation* is immediate: $K_1 subset.eq K_2$ implies
  $K_1 \/ N subset.eq K_2 \/ N$, and conversely. *Normality:* if $K
  ⊲ G$ with $N subset.eq K$, then $K \/ N ⊲ G \/ N$ by
  #link(<prop:group-homomorphism-properties>)[§5.1 property (4)]
  applied to $pi$. Conversely, if $L ⊲ G \/ N$, then $pi^(-1)(L) ⊲
  G$ by property (5) of the same proposition. The last clause is the
  Third Isomorphism Theorem.
]

#example[
  (Subgroups of $bb(Z)_4$.) Take $G = bb(Z)$, $N = 4 bb(Z)$, so $G \/
  N = bb(Z)_4$. By the Correspondence Theorem, the subgroups of
  $bb(Z)_4$ are in bijection with the subgroups of $bb(Z)$ containing
  $4 bb(Z)$. Since every subgroup of $bb(Z)$ is of the form $d bb(Z)$
  for $d in bb(N) union {0}$ (#link(<thm:cyclic-subgroups>)[§2.4]),
  the containing ones are exactly $d bb(Z)$ with $d | 4$, i.e. $d in
  {1, 2, 4}$ (and $d = 0$ gives $bb(Z)$ itself, which is not in
  the range since $bb(Z)$ strictly contains $4 bb(Z)$). The lattice of
  subgroups of $bb(Z)_4$ is thus
  $
    {0} = 4 bb(Z) \/ 4 bb(Z) subset.eq 2 bb(Z) \/ 4 bb(Z)
    subset.eq bb(Z) \/ 4 bb(Z) = bb(Z)_4,
  $
  i.e. $bb(Z)_4$ has exactly three subgroups, of orders $1, 2, 4$
  respectively — recovering the cyclic group classification of
  #link(<cor:cyclic-generators>)[§2.4].
] <ex:z4-subgroups>

#note[
  *Subgroup lattices.* The Correspondence Theorem says that to
  understand the subgroup lattice of $G \/ N$, it suffices to
  understand the subgroups of $G$ *containing $N$*. In particular:

  - If $N$ is *maximal normal* (i.e. $N eq G$ and there is no $K$ with
    $N subset.neq K subset.neq G$), then $G \/ N$ is simple — the
    very definition of #link(<def:simple-group>)[§4.3].
  - Quotients of simple groups are simple or trivial: $G$ simple
    means the only normal subgroups are ${e, G}$, so $G \/ N$ is
    $G \/ G$ (trivial) or $G \/ {e} ~= G$ (simple).
  - The lattice of $G$ is "folded" by the projection $pi$, and the
    lattice of $G \/ N$ is precisely the upper part of the lattice of
    $G$ above $N$.

  This is the sense in which the quotient $G \/ N$ is "$G$ with $N$
  collapsed to the identity": subgroups below $N$ disappear, those
  above $N$ survive with their relative structure intact.
] <note:subgroup-lattice>

The three isomorphism theorems together — First, Second, Third,
together with the Correspondence Theorem as a "zeroth" companion —
form the *structural calculus of quotients*. Every manipulation of
normal subgroups and quotient groups, in group theory and beyond
(rings in §9, modules in §17), reduces to these four results. With
them in hand, we turn next to *group actions*, the second great
structural tool of group theory.

= Group Actions and the Sylow Theorems // 群的作用与 Sylow 定理

Through Chapters 3–5 the lens was *internal*: subgroups, cosets,
normal subgroups, quotients — all measured the structure of $G$ from
inside. The turning point of group theory is to look *outside*: at
how $G$ acts on a set $X$. Three results follow from this single
shift of perspective:

  + The *orbit-stabilizer theorem* — Lagrange's theorem reborn as a
    counting principle, $|G| = |O_x| dot.c x |G_x|$, applicable far
    beyond coset arithmetic.
  + The *class equation* — the conjugation action of $G$ on itself,
    decomposing $G$ into conjugacy classes whose sizes are controlled
    by centralisers.
  + The *Sylow theorems* — the existence, conjugacy, and counting of
    Sylow $p$-subgroups, the deepest structural theorem for finite
    groups short of full classification.

This chapter develops all three, ending with applications to the
classification of small groups and to the recognition of simple
groups. It is the second great peak of group theory, the foundation
for the structure of finite abelian groups (Chapter 7) and for the
solvability criterion of Galois theory (Chapter 16).

== Group Actions // 群的作用

A group action is the formal counterpart of "letting a group move a
set". The prototype is the symmetric group $S_n$ permuting ${1, dots,
n}$, or any transformation group of #link(<def:transformation-group>)[§3.3]
moving its underlying set. The definition below extracts the algebraic
essence of this motion.

#definition(name: "Group Action")[
  Let $G$ be a group and $X$ a set. A *(left) action* of $G$ on $X$
  is a map
  $
    G times X -> X, quad (g, x) |-> g dot.c x,
  $
  satisfying, for all $g, h in G$ and $x in X$,
  + *identity*: $e dot.c x = x$ for the identity $e in G$;
  + *compatibility*: $(g h) dot.c x = g dot.c (h dot.c x)$.
  In this case $X$ is called a *$G$-set*, and we write $G$ acts on $X$.
] <def:group-action>

The compatibility axiom is what makes the action a *representation*
of the group law: applying $g$ then $h$ is the same as applying $g h$.
Two equivalent formulations make this explicit.

#property(name: "Actions as Permutation Representations")[
  Giving an action of $G$ on $X$ is equivalent to giving a homomorphism
  $
    rho: G -> "Sym"(X),
  $
  called the *permutation representation* of the action. Under this
  correspondence:
  + The action $g dot.c x$ is recovered as $rho(g)(x)$.
  + The action is *faithful* (different $g$ move some $x$
    differently) "iff" $rho$ is injective.
  + The *kernel* of the action, $K = {g in G | g dot.c x = x
    "for all" x in X}$, equals $"ker" rho$; it is a normal subgroup
    of $G$ by #link(<prop:group-homomorphism-properties>)[§5.1].
] <prop:action-permutation-rep>

The equivalence is immediate: $rho(g) = (x |-> g dot.c x)$ is a
permutation (with inverse $rho(g^(-1))$) and compatibility says
$rho(g h) = rho(g) ∘ rho(h)$. Conversely, any homomorphism
$rho: G -> "Sym"(X)$ defines an action by $g dot.c x = rho(g)(x)$.

#property(name: "Basic Properties of Actions")[
  Let $G$ act on $X$. For $x in X$:
  + The set $O_x = {g dot.c x | g in G}$ is a $G$-invariant subset
    of $X$, the *orbit* of $x$ (formal definition in
    #link(<def:orbit>)[below]).
  + The set $G_x = {g in G | g dot.c x = x}$ is a subgroup of $G$,
    the *stabiliser* of $x$ (formal definition in
    #link(<def:stabilizer>)[below]).
  + The *fixed-point set* $X^G = {x in X | g dot.c x = x "for all" g
    in G}$ is $G$-invariant pointwise.
  + The kernel $K = op("∩")_(x in X) G_x$ is normal in $G$, and $G
    \/ K$ acts faithfully on $X$.
] <prop:action-basic>

Three examples anchor the abstraction. They are not merely
illustrative — each reappears as a structural tool later in the
chapter.

#example[
  (Left regular action — the launching example.) Any group $G$
  acts on itself by left multiplication:
  $
    G times G -> G, quad (g, x) |-> g x.
  $
  This is the construction of #link(<thm:cayley>)[§3.3] viewed as an
  action. The axioms are the group axioms themselves: $e dot.c x = e
  x = x$ and $(g h) dot.c x = (g h) x = g (h x) = g dot.c (h dot.c
  x)$. The action is faithful ($g dot.c e = g$, so $g dot.c x = x$
  for all $x$ forces $g = e$), and the permutation representation
  $rho: G -> "Sym"(G)$, $rho(g) = L_g$, is the *left regular
  representation* promised in
  #link(<note:regular-action-preview>)[§3.3].

  Every orbit is all of $G$ (the action is *transitive*); every
  stabiliser is trivial. The regular action is the "largest" action —
  it forgets nothing.
] <ex:regular-action>

#example[
  (Conjugation action.) Any group $G$ acts on itself by conjugation:
  $
    G times G -> G, quad (g, x) |-> g x g^(-1).
  $
  Identity and compatibility are the identities $e x e^(-1) = x$ and
  $(g h) x (g h)^(-1) = g (h x h^(-1)) g^(-1)$. This action is the
  structural backbone of the *class equation* (§6.2).

  - The orbit of $x$ is its *conjugacy class* $"Cl"(x) = {g x g^(-1)
    | g in G}$.
  - The stabiliser of $x$ is its *centraliser* $C_G(x) = {g in G | g x
    = x g}$, a subgroup of $G$.
  - The fixed points $X^G$ form the *centre* $Z(G) = {z in G | g z =
    z g "for all" g}$, an abelian normal subgroup of $G$.
  - The kernel is $Z(G)$ again: $g$ acts trivially "iff" $g x g^(-1) =
    x$ for all $x$, "iff" $g in Z(G)$.
] <ex:conjugation-action>

#example[
  (Left multiplication on cosets.) Let $H <= G$ be a subgroup. The
  group $G$ acts on the set of left cosets $G \/ H = {g H | g in G}$
  by left multiplication:
  $
    G times (G \/ H) -> (G \/ H), quad (g, a H) |-> (g a) H.
  $
  This is well-defined (cosets depend only on representatives modulo
  $H$, and $g a$ is a fresh representative) and satisfies the action
  axioms directly. The stabiliser of the coset $a H$ is the conjugate
  subgroup $a H a^(-1)$:
  $
    G_(a H) = {g in G | g a H = a H} = {g | a^(-1) g a in H} = a H
    a^(-1).
  $
  In particular, the stabiliser of $H$ itself is $H$. The action is
  transitive (any coset $a H$ is $a dot.c H$), and its kernel is
  $
    op("∩")_(a in G) a H a^(-1),
  $
  the largest normal subgroup of $G$ contained in $H$ — a key
  construction in the theory of permutation representations.

  When $H = {e}$, this recovers the left regular action of
  #link(<ex:regular-action>)[above]. When $H = G$, the action is
  trivial. The coset action interpolates between these extremes and,
  as #link(<thm:orbit-stabilizer>)[§6.2] will show, recovers
  Lagrange's theorem $|G \/ H| = [G : H] = |G| \/ |H|$ from a single
  application of orbit-stabilizer counting.
] <ex:left-coset-action>

The example above suggests that *every* orbit is the set of cosets
of some subgroup. The next definitions make this precise.

#definition(name: "Orbit")[
  Let $G$ act on $X$. The *orbit* of $x in X$ is
  $
    O_x = G dot.c x = {g dot.c x | g in G} subset.eq X.
  $
  A subset $Y subset.eq X$ is *$G$-invariant* if $g dot.c Y = Y$ for
  all $g in G$; equivalently, $Y$ is a union of orbits. The action is
  *transitive* if $O_x = X$ for some (hence every) $x$.
] <def:orbit>

#definition(name: "Stabiliser")[
  Let $G$ act on $X$. The *stabiliser* of $x in X$ is
  $
    G_x = {g in G | g dot.c x = x} <= G,
  $
  a subgroup of $G$. The action is *free* if $G_x = {e}$ for every
  $x$, and *faithful* if $op("∩")_(x in X) G_x = {e}$.
] <def:stabilizer>

The orbits of an action carve $X$ into disjoint pieces — the
fundamental structural fact about actions, on which all subsequent
counting rests.

#lemma(name: "Orbits Partition the Set")[
  Let $G$ act on $X$. The relation $x ~ y "iff" y = g dot.c x$ for some $g
  in G$ is an equivalence relation on $X$. Its equivalence classes
  are exactly the orbits $O_x$, and consequently
  $
    X = union.big_(x in I) O_x quad "(*disjoint union*)"
  $
  for any set $I$ of orbit representatives. In particular, if $X$ is
  finite then $abs(X) = sum_(x in I) abs(O_x)$.
] <lem:orbit-equivalence>

#proof[
  *Reflexivity*: $x = e dot.c x$ with $e$ the identity, so $x ~ x$.
  *Symmetry*: if $y = g dot.c x$ then $x = g^(-1) dot.c y$ (apply
  $g^(-1)$), so $x ~ y$. *Transitivity*: if $y = g dot.c x$ and $z =
  h dot.c y$ then $z = h dot.c (g dot.c x) = (h g) dot.c x$, so $x ~
  z$. The equivalence class of $x$ is by definition the orbit $O_x$.
]

The decomposition $X = union.big O_x$ is the visual heart of the
theory: a single action slices an arbitrary set into orbits, each
carrying its own geometry. The next figure captures the picture.

#figure(
  image("img/orbit-partition.svg"),
  caption: [A finite $G$-set $X$ decomposed into disjoint orbits.
    Each orbit is the image of the action map restricted to $G times
    {x}$; distinct orbits do not interact.],
) <fig:orbit-partition>

#note[
  (Actions generalise coset counting.) The left coset action of
  #link(<ex:left-coset-action>)[above] makes the formal connection:
  cosets of $H$ in $G$ are the *orbits* of $H$ on $G \/ H$? — no, the
  single orbit, since the action is transitive. The precise
  statement is that the orbit-stabilizer theorem
  (#link(<thm:orbit-stabilizer>)[§6.2]) applied to the coset action
  yields $|G| = |G \/ H| dot.c |H|$, i.e. Lagrange's theorem
  (#link(<thm:lagrange>)[§3.2]) — a hint that actions are the proper
  generality for counting in group theory.
] <note:action-as-coset-generalization>

With orbits, stabilisers, and the partition lemma in hand, we can
now state and prove the central counting theorem of the theory.

== Orbit-Stabilizer and Burnside's Lemma // 轨道-稳定子定理与 Burnside 引理

The orbit-stabilizer theorem is the single most useful identity in
finite group theory. It converts the geometric data of an action (the
size of an orbit) into the algebraic data of a subgroup (the index of
a stabiliser), and vice versa. Lagrange's theorem drops out as the
special case of the coset action.

#theorem(name: "Orbit-Stabilizer Theorem")[
  Let $G$ act on $X$, and let $x in X$. There is a bijection
  $
    G \/ G_x -> O_x, quad g G_x |-> g dot.c x,
  $
  between the left cosets of the stabiliser $G_x$ and the orbit
  $O_x$. In particular, if $G$ is finite,
  $
    abs(G) = abs(O_x) dot.c abs(G_x),
  $
  or equivalently $abs(O_x) = [G : G_x]$.
] <thm:orbit-stabilizer>

#proof[
  Define $phi: G \/ G_x -> O_x$ by $phi(g G_x) = g dot.c x$. The map
  is:
  + *well-defined*: if $g G_x = g' G_x$ then $g' = g h$ for some $h in
    G_x$, so $g' dot.c x = (g h) dot.c x = g dot.c (h dot.c x) = g
    dot.c x$ (since $h$ stabilises $x$), hence $phi(g G_x) = phi(g'
    G_x)$.
  + *injective*: if $g dot.c x = g' dot.c x$ then $g^(-1) g' dot.c x =
    x$, so $g^(-1) g' in G_x$, i.e. $g G_x = g' G_x$.
  + *surjective*: every $y in O_x$ is of the form $y = g dot.c x$ for
    some $g in G$, i.e. $y = phi(g G_x)$.

  The bijection gives $abs(G \/ G_x) = abs(O_x)$, and Lagrange's
  theorem (#link(<thm:lagrange>)[§3.2]) gives $abs(G) = abs(G \/ G_x)
  dot.c abs(G_x) = abs(O_x) dot.c abs(G_x)$.
]

The theorem recovers Lagrange in one line, as promised.

#corollary(name: "Lagrange from Orbit-Stabilizer")[
  If $H <= G$ and $G$ is finite, then $abs(G) = abs(H) dot.c [G : H]$.
  In particular, $abs(H)$ divides $abs(G)$, and $[G : H] = abs(G) \/
  abs(H)$.
] <cor:lagrange-from-orbit-stabilizer>

#proof[
  Apply #link(<thm:orbit-stabilizer>)[the theorem] to the left coset
  action of #link(<ex:left-coset-action>)[§6.1] on $G \/ H$: the
  action is transitive, so $O_H = G \/ H$ has $abs(O_H) = [G : H]$,
  and the stabiliser $G_H = H$ has $abs(G_H) = abs(H)$. The theorem
  gives $abs(G) = [G : H] dot.c abs(H)$.
]

The second pillar of the theory is the *class equation*, which
applies orbit-stabilizer to the conjugation action.

#theorem(name: "Class Equation")[
  Let $G$ be a finite group, let $Z(G)$ be its centre, and let
  $x_1, dots, x_r$ be representatives of the non-central conjugacy
  classes. Then
  $
    abs(G) = abs(Z(G)) + sum_(i=1)^r [G : C_G(x_i)].
  $
  Equivalently, $abs(G) = abs(Z(G)) + sum abs("Cl"(x_i))$, since each
  $abs("Cl"(x_i)) = [G : C_G(x_i)]$ by
  #link(<thm:orbit-stabilizer>)[orbit-stabilizer] applied to
  conjugation.
] <thm:class-equation>

#proof[
  By #link(<lem:orbit-equivalence>)[the partition lemma], $G$ is the
  disjoint union of its conjugacy classes (the orbits of the
  conjugation action of #link(<ex:conjugation-action>)[§6.1]):
  $
    G = union.big_(x in I) "Cl"(x).
  $
  Split the index set into central elements $Z(G)$ (classes of size
  $1$, since $g x g^(-1) = x$ for all $g$ iff $x in Z(G)$) and
  non-central representatives $x_1, dots, x_r$. Then
  $
    abs(G) = abs(Z(G)) + sum_(i=1)^r abs("Cl"(x_i)).
  $
  By #link(<thm:orbit-stabilizer>)[orbit-stabilizer], $abs("Cl"(x_i))
  = [G : (G)_(x_i)] = [G : C_G(x_i)]$ since the stabiliser of $x_i$
  under conjugation is the centraliser $C_G(x_i)$.
]

The class equation is a versatile tool. Its first application is to
$p$-groups, where it forces the centre to be non-trivial.

#example[
  (Non-trivial centre of a $p$-group.) Let $G$ be a group with
  $abs(G) = p^n$ for some prime $p$ and $n >= 1$. The class equation
  gives
  $
    p^n = abs(Z(G)) + sum_(i=1)^r [G : C_G(x_i)].
  $
  Each $[G : C_G(x_i)]$ is a power of $p$ (by Lagrange, since it
  divides $abs(G) = p^n$) and is $> 1$ (since $x_i ∉ Z(G)$, so
  $C_G(x_i) ≠ G$). Hence each term in the sum is divisible by
  $p$. As $p$ divides the left-hand side $p^n$, $p$ must also divide
  $abs(Z(G))$. Since $abs(Z(G)) >= 1$ (the identity is always central),
  we conclude $abs(Z(G)) >= p$ — the centre of a $p$-group is
  non-trivial.

  This is the seed of the structure theorem for $p$-groups: every
  $p$-group has a non-trivial centre, hence a non-trivial normal
  subgroup (the centre itself), hence is *not* simple unless it has
  prime order.
] <ex:class-equation-pgroup>

The third great counting result is *Burnside's lemma*, which counts
the number of orbits of an action by averaging fixed points. Its
proof is a paradigmatic double-counting argument.

#theorem(name: "Burnside's Lemma")[
  Let $G$ act on a finite set $X$. Let $X^g = {x in X | g dot.c x =
  x}$ be the fixed-point set of $g$, and let $r$ be the number of
  orbits. Then
  $
    r = 1 \/ abs(G) sum_(g in G) abs(X^g).
  $
  In words: the number of orbits equals the average number of fixed
  points.
] <thm:burnside>

#proof[
  We count the set $S = {(g, x) in G times X | g dot.c x = x}$ in two
  ways.

  *Counting by $g$*: for each $g in G$, the number of $x$ with $g
  dot.c x = x$ is $abs(X^g)$, so $abs(S) = sum_(g in G) abs(X^g)$.

  *Counting by $x$*: for each $x in X$, the number of $g$ with $g
  dot.c x = x$ is $abs(G_x)$ (the stabiliser), so $abs(S) = sum_(x in
  X) abs(G_x)$.

  Group the second sum by orbits: if $x, y$ are in the same orbit
  then $abs(G_x) = abs(G_y)$ (their stabilisers are conjugate, hence
  equal in size, by #link(<thm:orbit-stabilizer>)[orbit-stabilizer]).
  So
  $
    sum_(x in X) abs(G_x) = sum_(i=1)^r sum_(x in O_i) abs(G_(x_i))
    = sum_(i=1)^r abs(O_i) dot.c abs(G_(x_i)),
  $
  where $x_i$ is any representative of $O_i$. By
  #link(<thm:orbit-stabilizer>)[orbit-stabilizer], $abs(O_i) dot.c
  abs(G_(x_i)) = abs(G)$. Hence the sum is $r dot.c abs(G)$.

  Equating the two counts: $sum_(g in G) abs(X^g) = r dot.c abs(G)$,
  i.e. $r = 1 \/ abs(G) sum_(g in G) abs(X^g)$.
]

Burnside's lemma turns orbit counting into the simpler problem of
counting fixed points. Its most famous application is the
combinatorics of colourings under symmetry.

#example[
  (Necklace colourings.) Consider $n$ beads on a necklace, each
  coloured in one of $k$ colours. Two colourings are the same
  necklace if some rotation of the necklace turns one into the other;
  equivalently, the colourings form a set $X = {1, dots, k}^n$ on
  which the cyclic group $bb(Z)_n$ acts by cyclic rotation.

  To apply Burnside, count the fixed colourings of each rotation. A
  rotation by $d$ positions (where $d | n$ for a fixed colouring to
  exist) fixes a colouring iff the beads in each cycle of the rotation
  have the same colour. A rotation by $d$ positions has $gcd(n, d)$
  cycles, each of length $n \/ gcd(n, d)$. So a colouring is fixed iff
  it is constant on each cycle, giving $k^(gcd(n, d))$ fixed
  colourings.

  Burnside's lemma gives the number of distinct necklaces as
  $
    1 \/ n sum_(d=0)^(n-1) k^(gcd(n, d)).
  $
  For $n = 4, k = 2$: the sum is $k^4 + k^2 + k^2 + k^4 = 16 + 4 + 4
  + 16 = 40$, divided by $4$ gives $10$ distinct binary necklaces of
  length $4$. (A direct enumeration confirms: $0000, 0001, 0011, 0101,
  0111, 1111, 0010, 0110, 0100, 1000$ collapse into $10$ classes
  under rotation.)

  The same computation with the *full* dihedral group $D_n$ (rotations
  + reflections) replaces the average over $bb(Z)_n$ by an average
  over $D_n$, halving the number of necklaces when no colouring is
  fixed by a reflection.
] <ex:burnside-coloring>

The three theorems — orbit-stabilizer, class equation, Burnside —
are the *counting toolkit* of group actions. The next section turns
them on the deepest question of finite group theory: which
$p$-subgroups does $G$ contain, and how do they fit together?

== The Sylow Theorems // Sylow 定理

Lagrange's theorem (#link(<thm:lagrange>)[§3.2]) says that the order
of any subgroup divides $abs(G)$. The converse is false in general:
$A_4$ has order $12$ but no subgroup of order $6$
(#link(<ex:low-order-classification>)[§3.3]). Yet for *prime power*
divisors, the converse *does* hold — this is the content of the
Sylow theorems, the deepest structural theorem for finite groups
short of full classification.

#definition(name: "$p$-Subgroup and Sylow $p$-Subgroup")[
  Let $G$ be a finite group and $p$ a prime. A *$p$-subgroup* of $G$
  is a subgroup whose order is a power of $p$. A *Sylow $p$-subgroup*
  is a $p$-subgroup whose order is the highest power of $p$ dividing
  $abs(G)$: if $abs(G) = p^k m$ with $p$ not dividing $m$, a Sylow
  $p$-subgroup has order $p^k$. The set of Sylow $p$-subgroups is
  denoted $"Syl"_p(G)$, and $n_p = abs("Syl"_p(G))$.
] <def:sylow-p-subgroup>

The theorems come in three parts: *existence* (Sylow $p$-subgroups
exist), *conjugacy* (any two are conjugate), and *counting* ($n_p$
satisfies two congruences). We build up to them through two lemmas,
each important in its own right.

#lemma(name: "Cauchy's Theorem")[
  Let $G$ be a finite group and $p$ a prime dividing $abs(G)$. Then
  $G$ contains an element of order $p$ — equivalently, a subgroup of
  order $p$.
] <lem:cauchy>

#proof[
  Consider the set $X = {(a_1, dots, a_p) in G^p | a_1 a_2 dots a_p
  = e}$ of $p$-tuples multiplying to the identity. By cyclic
  rotation, $bb(Z)_p$ acts on $X$ by
  $
    k dot.c (a_1, dots, a_p) = (a_(k+1), dots, a_p, a_1, dots, a_k),
  $
  where indices are modulo $p$. The rotation is well-defined on $X$:
  if $a_1 a_2 dots a_p = e$ then $a_(k+1) dots a_p a_1 dots a_k = a_k
  a_1 dots a_(k+1)$ ... let us argue more cleanly. Since $a_1 dots
  a_p = e$ we have $a_1 = (a_2 dots a_p)^(-1)$, and cyclically
  permuting the tuple preserves the product-to-identity condition
  (this is the cyclic-conjugation identity, checked by multiplying
  out).

  By #link(<lem:p-group-fixed-point>)[the fixed-point lemma below],
  $abs(X) ≡ abs(X^(bb(Z)_p)) \pmod p$. The fixed points are tuples
  with all entries equal: $(a, a, dots, a)$ with $a^p = e$. Each such
  tuple is determined by $a$, an element of $G$ of order dividing
  $p$. There is at least one such element, namely $a = e$ (giving the
  tuple $(e, dots, e)$). Hence $abs(X^(bb(Z)_p)) >= 1$.

  To show $abs(X) > 1$: count $X$ directly. The first $p - 1$ entries
  $a_1, dots, a_(p-1)$ are arbitrary elements of $G$ (any choice),
  and $a_p$ is then forced to be $a_p = (a_1 dots a_(p-1))^(-1)$. So
  $abs(X) = abs(G)^(p-1)$, which is divisible by $p$ (since $p | abs(G)$).
  From $abs(X) ≡ abs(X^G) \pmod p$ with both sides divisible by $p$,
  we get $abs(X^G) ≡ 0 \pmod p$, but $abs(X^G) >= 1$ (the tuple $(e,
  dots, e)$ is fixed), so $abs(X^G) >= p$. Hence there is a
  non-identity element $a in G$ with $a^p = e$ — an element of order
  $p$.
]

The key ingredient in Cauchy's proof — that a $p$-group action
produces fixed points modulo $p$ — is itself a fundamental lemma.

#lemma(name: "Fixed-Point Lemma for $p$-Group Actions")[
  Let $P$ be a finite $p$-group acting on a finite set $X$. Then
  $
    abs(X) ≡ abs(X^P) \pmod p,
  $
  where $X^P = {x in X | g dot.c x = x "for all" g in P}$ is the
  fixed-point set. In particular, if $p | abs(X)$ then $X^P$ is
  non-empty.
] <lem:p-group-fixed-point>

#proof[
  By #link(<lem:orbit-equivalence>)[the partition lemma], $X$ is the
  disjoint union of its $P$-orbits. By
  #link(<thm:orbit-stabilizer>)[orbit-stabilizer], each orbit has
  size $abs(O_x) = [P : P_x]$, a power of $p$ (since $abs(P)$ is a
  power of $p$, so any divisor is too). Orbits of size $1$ correspond
  exactly to fixed points ($O_x = {x}$ iff $P_x = P$ iff $x in X^P$);
  orbits of size $> 1$ are divisible by $p$. Hence
  $
    abs(X) = abs(X^P) + sum abs(O_i),
  $
  where the sum is over orbits with $abs(O_i) > 1$, and each such term
  is divisible by $p$. Reducing modulo $p$ gives $abs(X) ≡ abs(X^P)
  \pmod p$.
]

Note: Cauchy's lemma used the fixed-point lemma applied to the
$bb(Z)_p$-action on $X subset.eq G^p$; the order of the reasoning is
that the fixed-point lemma is proved first, then Cauchy follows. With
both in hand, we can prove the *first Sylow theorem*: Sylow
$p$-subgroups exist.

#theorem(name: "First Sylow Theorem (Existence)")[
  Let $G$ be a finite group with $abs(G) = p^k m$, $p$ not dividing
  $m$. Then $G$ has a subgroup of order $p^k$ — a Sylow
  $p$-subgroup.
] <thm:sylow-first>

#proof[
  Let $X$ be the set of all subsets of $G$ of size $p^k$:
  $
    X = {S subset.eq G | abs(S) = p^k}.
  $
  The group $G$ acts on $X$ by left translation: $g dot.c S = {g s | s
  in S}$. We have $abs(X) = binom(abs(G), p^k) = binom(p^k m, p^k)$,
  and a classical congruence (Lucas's theorem, or a direct $p$-adic
  valuation) gives
  $
    binom(p^k m, p^k) ≡ m \pmod p,
  $
  so $p$ does not divide $abs(X)$ (since $p$ does not divide $m$).

  Let $O$ be any orbit of the $G$-action on $X$ with $abs(O)$ not
  divisible by $p$ (such an orbit exists, since $abs(X)$ itself is
  not divisible by $p$, and the orbits partition $X$). Let $S in O$
  be a representative, and let $H = G_S$ be its stabiliser. By
  #link(<thm:orbit-stabilizer>)[orbit-stabilizer], $abs(O) = [G : H]
  = abs(G) \/ abs(H)$. Since $p$ does not divide $abs(O)$ and $abs(G)
  = p^k m$, the highest power of $p$ dividing $abs(H)$ is at least
  $p^k$; in other words $p^k | abs(H)$.

  On the other hand $H$ acts on $S$ by left translation, and this
  action is *free* (if $h s_1 = s_2$ for $h in H$ and $s_1, s_2 in S$,
  then $h = s_2 s_1^(-1)$ is a single element of $S$; but free means
  $h = e$ unless $s_1 = s_2$, so we need the alternative argument
  below). Actually, we use the sharper fact: $H$ stabilises $S$ means
  $H S = S$ (setwise), so $H$ permutes the $p^k$ elements of $S$. The
  permutation decomposes $S$ into $H$-orbits each of size dividing
  $abs(H)$, and the sum is $p^k$, so each orbit size divides both
  $abs(H)$ and $p^k$, hence is a power of $p$. Each element of $H$
  itself lies in some orbit of size a power of $p$ — but in fact we
  can extract more: since $H subset.eq G$ and $H$ acts on $S$ with
  $abs(S) = p^k$, the orbit-stabilizer theorem gives $abs(H)$ divides
  a sum of powers of $p$, so $abs(H) = p^j$ for some $j <= k$.

  Combining $p^k | abs(H)$ and $abs(H) = p^j$ with $j <= k$: $j = k$,
  and $abs(H) = p^k$. Hence $H$ is a Sylow $p$-subgroup.
]

The first Sylow theorem settles existence. The second and third
together settle *uniqueness up to conjugacy* and *counting*.

#theorem(name: "Second Sylow Theorem (Conjugacy)")[
  Let $G$ be a finite group, $p$ a prime, and $P, Q$ Sylow
  $p$-subgroups of $G$. Then $P$ and $Q$ are conjugate in $G$:
  there exists $g in G$ with $Q = g P g^(-1)$.
] <thm:sylow-second>

#proof[
  Let $P$ act on $"Syl"_p(G)$ by conjugation: $p dot.c Q = p Q p^(-1)$
  for $p in P$, $Q in "Syl"_p(G)$. By
  #link(<lem:p-group-fixed-point>)[the fixed-point lemma],
  $abs("Syl"_p(G)) ≡ abs("Syl"_p(G)^P) \pmod p$.

  We claim the only $P$-fixed point of this action is $P$ itself.
  Indeed, if $Q$ is fixed by $P$, then $P <= N_G(Q)$ (the normaliser
  of $Q$). Both $P$ and $Q$ are Sylow $p$-subgroups of $G$, hence of
  $N_G(Q)$ as well (since $abs(N_G(Q))$ divides $abs(G)$, the Sylow
  $p$-subgroups of $N_G(Q)$ have order $p^k$). By the second Sylow
  theorem *applied inside $N_G(Q)$* — but wait, this is circular.

  *Cleaner argument.* Let $P$ act on the set of left cosets $G \/ Q$
  by left multiplication ($p dot.c (g Q) = (p g) Q$). The fixed-point
  lemma gives $abs(G \/ Q) ≡ abs((G \/ Q)^P) \pmod p$. Since $abs(G
  \/ Q) = [G : Q] = m$ (not divisible by $p$), there is at least one
  fixed coset $g Q$. The coset $g Q$ is fixed by $P$ iff $P g Q
  subset.eq g Q$, iff $g^(-1) P g <= Q$. But $abs(g^(-1) P g) = abs(P)
  = p^k = abs(Q)$, so $g^(-1) P g = Q$, i.e. $P = g Q g^(-1)$. Hence
  $P$ and $Q$ are conjugate.
]

#theorem(name: "Third Sylow Theorem (Counting)")[
  Let $abs(G) = p^k m$ with $p$ not dividing $m$, and let $n_p =
  abs("Syl"_p(G))$ be the number of Sylow $p$-subgroups. Then
  + $n_p | m$ (so $n_p$ divides the $p$-free part $m$ of $abs(G)$);
  + $n_p ≡ 1 \pmod p$.
] <thm:sylow-third>

#proof[
  $G$ acts on $"Syl"_p(G)$ by conjugation; by
  #link(<thm:sylow-second>)[the second theorem], this action is
  transitive (all Sylow $p$-subgroups are conjugate). So $"Syl"_p(G)$
  is a single orbit, and by
  #link(<thm:orbit-stabilizer>)[orbit-stabilizer] applied to $P in
  "Syl"_p(G)$,
  $
    n_p = abs("Syl"_p(G)) = [G : N_G(P)] = abs(G) \/ abs(N_G(P)).
  $
  Since $P <= N_G(P)$, $abs(P) = p^k$ divides $abs(N_G(P))$, so
  $n_p = abs(G) \/ abs(N_G(P))$ divides $abs(G) \/ p^k = m$. This
  proves (1).

  For (2), apply #link(<lem:p-group-fixed-point>)[the fixed-point
  lemma] to the conjugation action of $P$ on $"Syl"_p(G)$:
  $n_p ≡ abs("Syl"_p(G)^P) \pmod p$. By the same argument as in the
  second theorem, the only $P$-fixed Sylow $p$-subgroup is $P$
  itself: if $Q$ is fixed by $P$ then $P <= N_G(Q)$, both $P$ and $Q$
  are Sylow $p$-subgroups of $N_G(Q)$ of the same order $p^k$, and the
  second Sylow theorem *inside $N_G(Q)$* (which we may now invoke,
  non-circularly, since $N_G(Q)$ is a smaller group and the second
  theorem is already proved) gives $P = Q$. So $abs("Syl"_p(G)^P) =
  1$, and $n_p ≡ 1 \pmod p$.
]

The figure below sketches how the Sylow $p$-subgroups fit together:
they form a single conjugacy class inside $G$, and the size of this
class is controlled by the normaliser $N_G(P)$.

#figure(
  image("img/sylow-conjugacy.svg"),
  caption: [The Sylow $p$-subgroups of $G$ form a single conjugacy
    class of size $n_p = [G : N_G(P)]$. The third Sylow theorem
    constrains $n_p$ by $n_p | m$ and $n_p ≡ 1 \pmod p$.],
) <fig:sylow-conjugacy>

#note[
  (Sylow strategy.) The three Sylow theorems form a strategy with
  three moves:
  + *Existence* (#link(<thm:sylow-first>)[first theorem]): Sylow
    $p$-subgroups exist for every prime $p | abs(G)$.
  + *Uniqueness up to conjugacy* (#link(<thm:sylow-second>)[second
    theorem]): any two are conjugate, so the Sylow $p$-subgroups form
    a single conjugacy class.
  + *Counting* (#link(<thm:sylow-third>)[third theorem]): $n_p$
    satisfies $n_p | m$ and $n_p ≡ 1 \pmod p$.

  In applications (#link(<ex:groups-order-pq>)[§6.4]), the third
  theorem often forces $n_p = 1$ — and a unique Sylow $p$-subgroup is
  normal. This is how Sylow theory turns counting arguments into
  structural statements about normal subgroups.
] <note:sylow-strategy>

The Sylow theorems are the high-water mark of finite group theory:
they give us, for free, the existence of subgroups of prime-power
order and a tight grip on how many such subgroups there can be. The
next section turns this grip into concrete classifications.

== Applications of the Sylow Theorems // Sylow 定理的应用

The Sylow theorems are most powerful when the congruences $n_p ≡ 1
\pmod p$ and $n_p | m$ together force $n_p = 1$. A unique Sylow
$p$-subgroup is normal (it is fixed by conjugation, being alone in
its conjugacy class), and a non-trivial normal subgroup rules out
simplicity. We illustrate this strategy on two classification
problems.

#example[
  (Groups of order $p q$.) Let $G$ have order $p q$ with $p, q$
  primes, $p < q$. We claim:
  - If $q ≢ 1 \pmod p$, then $G$ is cyclic, $G ≅ bb(Z)_(p
    q)$.
  - If $q equiv 1 \pmod p$, then there is additionally a
    non-abelian group of order $p q$, the semidirect product
    $bb(Z)_q ⋊ bb(Z)_p$.

  *Argument.* Let $Q$ be a Sylow $q$-subgroup (order $q$). By the
  third Sylow theorem, $n_q | p$ and $n_q ≡ 1 \pmod q$. Since $q >
  p$, the congruence $n_q ≡ 1 \pmod q$ with $n_q | p$ forces $n_q =
  1$. So $Q ⊲ G$ is normal.

  Let $P$ be a Sylow $p$-subgroup (order $p$). Then $n_p | q$ and
  $n_p ≡ 1 \pmod p$. So $n_p in {1, q}$, and $q ≡ 1 \pmod p$
  decides: if $q ≢ 1 \pmod p$, then $n_p = 1$ and $P ⊲ G$
  as well.

  *If $n_p = 1$*: both $P$ and $Q$ are normal, with trivial
  intersection, and $P Q = G$ (since $abs(P) abs(Q) = p q =
  abs(G)$). So $G ≅ P times Q ≅ bb(Z)_p times bb(Z)_q ≅ bb(Z)_(p q)$
  (cyclic, by the Chinese remainder theorem since $gcd(p, q) = 1$).

  *If $n_p = q$*: $P$ is not normal; there are $q$ Sylow
  $p$-subgroups. The unique normal $Q$ admits a homomorphism $P -> 
  "Aut"(Q) ≅ bb(Z)_(q-1)$ (the conjugation action of $P$ on $Q$); a
  non-trivial such homomorphism exists iff $p | (q - 1)$, i.e. $q ≡
  1 \pmod p$. The corresponding semidirect product $bb(Z)_q ⋊ bb(Z)_p$
  is the non-abelian group of order $p q$.

  For $p = 2, q = 3$: $q = 3 ≢ 1 \pmod 2$, so groups of
  order $6$ are cyclic — but wait, $S_3$ is non-abelian of order
  $6$! The issue is that $3 equiv 1 \pmod 2$ (since $3 - 1 = 2$ is
  divisible by $2$), so the non-abelian case applies: $S_3 ≅ bb(Z)_3
  ⋊ bb(Z)_2$.
] <ex:groups-order-pq>

#example[
  (Groups of order $12$.) Let $abs(G) = 12 = 2^2 dot.c 3$. The Sylow
  theorems constrain the possibilities:

  - *Sylow $2$-subgroups*: order $4$, $n_2 | 3$ and $n_2 ≡ 1 \pmod
    2$, so $n_2 in {1, 3}$.
  - *Sylow $3$-subgroups*: order $3$, $n_3 | 4$ and $n_3 ≡ 1 \pmod
    3$, so $n_3 in {1, 4}$.

  There are five groups of order $12$ up to isomorphism:
  + $bb(Z)_12 ≅ bb(Z)_3 times bb(Z)_4$ (cyclic, abelian);
  + $bb(Z)_2 times bb(Z)_6$ (abelian, non-cyclic);
  + $A_4$ (alternating group, $n_3 = 4$, $n_2 = 1$ — the Sylow
    $2$-subgroup $V_4$ is normal);
  + $D_6$ (dihedral group, $n_2 = 3$, $n_3 = 1$);
  + $"Dic"_3$ (dicyclic group, $n_2 = 1$, $n_3 = 1$, but
    non-abelian).

  The key dichotomy: if $n_3 = 1$ then the Sylow $3$-subgroup is
  normal (cases 1, 2, 4, 5); if $n_3 = 4$ then $G$ has a homomorphism
  to $S_4$ via the conjugation action on its four Sylow
  $3$-subgroups, which for $A_4$ is the standard embedding $A_4 -> 
  S_4$ (and in general forces $G$ to have a normal subgroup of index
  $4$ — i.e. $A_4$ is the only group of order $12$ with $n_3 = 4$).

  The Sylow theorems alone do not pin down the isomorphism types —
  one must also analyse the possible semidirect products
  $bb(Z)_3 ⋊ bb(Z)_4$ and $bb(Z)_3 ⋊ (bb(Z)_2 times bb(Z)_2)$ — but
  they narrow the search dramatically.
] <ex:groups-order-12>

The same strategy — count Sylow subgroups, force normality — rules
out simplicity for many orders.

#property(name: "No Simple Groups of Small Order")[
  If $G$ is a simple group of order $abs(G) <= 100$, then either
  $abs(G)$ is prime (so $G ≅ bb(Z)_p$) or $abs(G) = 60$ (so $G ≅
  A_5$).
] <prop:no-simple-small-order>

#proof[
  (Sketch.) For most composite orders $n <= 100$, the Sylow
  congruences force $n_p = 1$ for some prime $p | n$ — equivalently,
  a unique (hence normal) Sylow $p$-subgroup — so $G$ is not simple.
  The exceptions are handled case by case:

  - $abs(G) = 36 = 2^2 dot.c 3^2$: $n_3 in {1, 4}$, $n_2 in {1, 3,
    9}$; if $n_3 = 4$ then the action on $4$ Sylow $3$-subgroups
    gives a homomorphism $G -> S_4$, and $abs(G) = 36 > 24 =
    abs(S_4)$ forces a non-trivial kernel.
  - $abs(G) = 48 = 2^4 dot.c 3$: $n_3 in {1, 4, 16}$; $n_3 = 16$
    would give $16 dot.c 2 = 32$ elements of order $3$, plus the
    identity, plus elements of order $>= 2$ — exceeding $48$; so
    $n_3 in {1, 4}$, and the case $n_3 = 4$ again embeds into
    $abs(S_4) = 24$.
  - $abs(G) = 60 = 2^2 dot.c 3 dot.c 5$: this is the borderline case
    — $A_5$ is simple, and it is the *only* simple group of order
    $60$. The Sylow congruences ($n_5 in {1, 6}$, $n_3 in {1, 4,
    10}$, $n_2 in {1, 3, 5, 15}$) are all satisfied by multiple
    values, so Sylow alone cannot rule out simplicity. A separate
    argument (counting elements of order $5$ and using the
    embedding into $S_5$ via the action on $6$ Sylow
    $5$-subgroups) shows that any simple group of order $60$
    embeds into $S_5$ as a subgroup of index $2$, hence equals
    $A_5$.
  - $abs(G) = 72, 90$: similar counting arguments force a normal
    Sylow subgroup or an embedding contradiction.

  The full case analysis is routine; see e.g. #link(<ex:a5-simple>)[§4.3]
  for the structure of $A_5$ as the smallest non-abelian simple
  group. The pattern — Sylow congruences + counting elements +
  permutation representations — is the standard template for
  recognising simplicity in small orders.
]

The closure of this chapter is also a transition. We have seen that
finite group theory splits into two regimes: the *abelian* regime,
where Lagrange's theorem has a full converse (the structure theorem
for finite abelian groups, Chapter 7), and the *non-abelian* regime,
where Sylow theory is the main tool and $A_5$ is the smallest
obstruction. The latter regime culminates in the question of
*solvability*: a group is solvable if it has a composition series with
abelian factors. The non-solvability of $A_5$ (and of any group
containing a copy of $A_5$) is, by Galois theory, exactly the
obstruction to solving polynomial equations by radicals — the subject
of Chapter 16. With the structure of finite abelian groups (Chapter
7) and the recognition of $A_5$ as the smallest non-abelian simple
group (#link(<thm:an-simple>)[§4.3]) in hand, we are ready for that
final chapter of the group-theoretic narrative.

= Structure of Finitely Generated Abelian Groups // 有限生成 Abel 群的结构

The structure theorem for finitely generated abelian groups is the
crown of the group-theoretic half of this book. It is the *full
converse* of Lagrange's theorem in the abelian setting: not only does
the order of any subgroup divide $abs(G)$ (#link(<thm:lagrange>)[§3.2]),
but for every prime-power divisor of $abs(G)$ there is a subgroup of
exactly that order, and these subgroups fit together so tightly that
$G$ is — up to isomorphism — completely determined by a finite list
of integers.

The theorem has two equivalent standard forms. The *invariant factor
form* writes
$
  G ~= bb(Z)^r ⊕ bb(Z) \/ d_1 ⊕ dots.c ⊕ bb(Z) \/ d_k,
  quad d_1 | d_2 | dots | d_k,
$
where $d_1 | d_2 | dots | d_k$ are the *invariant factors*. The
*elementary divisor form* writes
$
  G ~= bb(Z)^r ⊕ bb(Z) \/ p_1^(a_1) ⊕ dots.c ⊕ bb(Z)
  \/ p_s^(a_s),
$
where each $p_i$ is prime. Both decompositions are *unique* (up to
reordering of the cyclic factors), and they are related by the unique
factorisation of each $d_j$ into prime powers in $bb(Z)$.

The integer $r$ is the *rank* of $G$ (the number of infinite cyclic
factors); the $d_i$ and $p^a$ are its *torsion data*. The theorem
says that a finitely generated abelian group is, up to isomorphism,
exactly a rank and a finite list of prime-power torsion data — the
abelian analogue of the fundamental theorem of arithmetic for $bb(Z)$.

This chapter develops the theorem in three stages: direct sums and
free abelian groups (the building blocks, §7.1); the structure
theorem itself, with both standard forms and the uniqueness argument
(§7.2); and the classification of finite abelian groups, with
explicit enumeration in small orders (§7.3).

== Direct Sums and Free Abelian Groups // 直和与自由 Abel 群

The structure theorem expresses $G$ as a *direct sum* of cyclic
groups. We begin by making this notion precise, then introduce the
free abelian groups $bb(Z)^r$ as the "skeleton" of every finitely
generated abelian group.

#definition(name: "Direct Sum of Abelian Groups")[
  Let $G_1, dots, G_n$ be abelian groups (written additively). The
  *direct sum* is the abelian group
  $
    G_1 ⊕ dots.c ⊕ G_n = G_1 times dots times G_n
  $
  with componentwise addition: $(g_1, dots, g_n) + (g'_1, dots,
  g'_n) = (g_1 + g'_1, dots, g_n + g'_n)$. The identity is
  $(0, dots, 0)$ and the inverse of $(g_1, dots, g_n)$ is $(-g_1,
  dots, -g_n)$.
] <def:direct-sum>

We write $⊕$ rather than $times$ when we wish to emphasise
that the operation is additive (the direct *sum* rather than direct
*product*). The two agree for finite index sets; for infinite families
they differ, but we shall not need the infinite case.

#property(name: "Basic Properties of Direct Sums")[
  Let $G = G_1 ⊕ dots.c ⊕ G_n$.
  + *Commutativity and associativity*: $G_i ⊕ G_j ≅ G_j ⊕
    G_i$ and $(G_1 ⊕ G_2) ⊕ G_3 ≅ G_1 ⊕ (G_2 ⊕
    G_3)$.
  + *Projections and injections*: there are homomorphisms $pi_i: G
    -> G_i$ (projections) and $iota_i: G_i -> G$ (injections), with
    $pi_i ∘ iota_i = "id"_(G_i)$ and $sum_i iota_i ∘
    pi_i = "id"_G$.
  + *Universal property*: a homomorphism $f: G -> H$ is equivalent to
    a list of homomorphisms $f_i = f ∘ iota_i: G_i -> H$,
    with $f(g_1, dots, g_n) = f_1(g_1) + dots + f_n(g_n)$.
  + *Order (finite case)*: if each $G_i$ is finite then $abs(G_1
    ⊕ dots.c ⊕ G_n) = abs(G_1) dots.c abs(G_n)$.
] <prop:direct-sum-properties>

The last point makes direct sums the natural tool for building
abelian groups out of cyclic components: $abs(bb(Z)_m ⊕ bb(Z)_n)
= m n$, so $bb(Z)_m ⊕ bb(Z)_n$ and $bb(Z)_(m n)$ have the same
order, even though they are isomorphic only when $gcd(m, n) = 1$.

#property(name: "Order of a Direct Sum")[
  Let $G_1, dots, G_n$ be finite abelian groups. Then
  $
    abs(G_1 ⊕ dots.c ⊕ G_n) = abs(G_1) dots.c abs(G_n).
  $
  In particular, $abs(bb(Z) \/ n bb(Z)) = n$, and the *exponent* of a
  direct sum (the smallest $m$ with $m G = {0}$) is the least common
  multiple of the exponents of the summands.
] <prop:order-direct-sum>

The building blocks of the structure theorem are the *free* abelian
groups, the additive analogue of a vector space.

#definition(name: "Free Abelian Group")[
  An abelian group $F$ is *free abelian* if it is isomorphic to
  $bb(Z)^r$ for some $r >= 0$, where
  $
    bb(Z)^r = bb(Z) ⊕ dots.c ⊕ bb(Z) quad ("r copies").
  $
  A *basis* of $F$ is a set ${e_1, dots, e_r}$ such that every $x in
  F$ has a unique expression $x = n_1 e_1 + dots + n_r e_r$ with $n_i
  in bb(Z)$. The integer $r$ is the *rank* of $F$, written $"rank"(F)
  = r$.
] <def:free-abelian>

A free abelian group is thus an abelian group with a $bb(Z)$-basis —
the exact analogue of a vector space, with $bb(Z)$ replacing the field
of scalars. The same proofs as in linear algebra (Gaussian
elimination over $bb(Z)$) give:

- Every subgroup of $bb(Z)^r$ is free abelian of rank $<= r$.
- Any two bases of a free abelian group have the same size.

The second statement — *rank invariance* — deserves a self-contained
proof, as it is the engine of uniqueness in the structure theorem.

#definition(name: "Basis and Rank")[
  Let $F$ be a free abelian group. A *basis* is a linearly
  independent generating set: ${e_1, dots, e_r} subset.eq F$ such that
  $n_1 e_1 + dots + n_r e_r = 0$ implies $n_1 = dots = n_r = 0$
  (independence) and every $x in F$ is such a combination (span). The
  *rank* of $F$, $r = "rank"(F)$, is the size of any basis.
] <def:basis-rank>

#theorem(name: "Rank is Well-Defined")[
  Any two bases of a free abelian group $F$ have the same size. Hence
  the rank is an invariant of $F$.
] <thm:rank-invariance>

#proof[
  Let ${e_1, dots, e_r}$ and ${f_1, dots, f_s}$ be two bases of $F$.
  Fix any prime $p$. Consider the quotient $F \/ p F$ as a vector
  space over $bb(Z) \/ p bb(Z) = bb(F)_p$: scalar multiplication by
  $overline(n) in bb(F)_p$ is defined by $overline(n) dot.c (x + p F)
  = n x + p F$, which is well-defined since $p F$ absorbs the
  ambiguity modulo $p$.

  The basis ${e_1, dots, e_r}$ descends to a basis of $F \/ p F$ over
  $bb(F)_p$: any $x in F$ is $x = n_1 e_1 + dots + n_r e_r$, so $x + p
  F = overline(n_1) (e_1 + p F) + dots + overline(n_r) (e_r + p F)$
  (spanning); and $overline(n_1) (e_1 + p F) + dots + overline(n_r)
  (e_r + p F) = 0$ means $n_1 e_1 + dots + n_r e_r in p F$, i.e.
  $n_1 e_1 + dots + n_r e_r = p m_1 e_1 + dots + p m_r e_r$ for some
  $m_i in bb(Z)$, so $(n_1 - p m_1) e_1 + dots = 0$, hence $p | n_i$
  by independence, so $overline(n_i) = 0$ (independence).

  Hence $F \/ p F$ has $bb(F)_p$-dimension $r$. The same argument with
  the other basis gives dimension $s$. Since dimension is an invariant
  of vector spaces, $r = s$.
]

The proof illustrates a recurring theme: properties of free abelian
groups are detected by reducing to a *vector space over a field*
($bb(F)_p$), where linear algebra applies. The same idea will
underwrite the existence proof of the structure theorem in §7.2.

Every finitely generated abelian group is a quotient of a free
abelian group:

#lemma(name: "Free Subgroup of a Finitely Generated Abelian Group")[
  Let $G$ be a finitely generated abelian group, with generators
  $g_1, dots, g_n$. Then:
  + There is a surjective homomorphism $phi: bb(Z)^n -> G$, $e_i |-> 
    g_i$ (so $G ≅ bb(Z)^n \/ "ker" phi$).
  + Let $t(G) = {x in G | m x = 0 "for some" m > 0}$ be the *torsion
    subgroup* of $G$ (elements of finite order). Then $t(G)$ is a
    subgroup, and there is a free abelian subgroup $F <= G$ of rank
    $r = "rank"(G / t(G))$ with
    $
      G ~= F ⊕ t(G).
    $
  In particular, $G$ is the direct sum of a free abelian group $bb(Z)^r$
  and a finite abelian group $t(G)$, where $r$ is the *rank* of $G$.
] <lem:free-subgroup>

#proof[
  (1) The map $phi: bb(Z)^n -> G$, $phi(n_1, dots, n_n) = n_1 g_1 +
  dots + n_n g_n$, is a surjective homomorphism (the $g_i$ generate
  $G$). The First Isomorphism Theorem
  (#link(<thm:first-isomorphism>)[§5.2]) gives $G ≅ bb(Z)^n \/
  "ker" phi$.

  (2) The torsion elements $t(G)$ form a subgroup: if $m x = 0$ and $n
  y = 0$ then $m n (x - y) = 0$. The quotient $G / t(G)$ is
  torsion-free (if $m (x + t(G)) = 0 + t(G)$ then $m x in t(G)$, so
  $k m x = 0$ for some $k$, hence $x in t(G)$, i.e. $x + t(G) = 0 +
  t(G)$). Being finitely generated and torsion-free, $G / t(G)$ is
  free abelian of some rank $r$ (a classical lemma: a finitely
  generated torsion-free abelian group is free — proved by embedding
  into $bb(Q)^r$ and clearing denominators).

  Let $pi: G -> G / t(G) ~= bb(Z)^r$. Choose $f_1, dots, f_r in G$
  with $pi(f_i) = $ standard basis of $bb(Z)^r$. The subgroup $F =
  ⟨f_1, dots, f_r⟩$ is free abelian of rank $r$, and
  $G = F + t(G)$ (any $x in G$ has $pi(x) = sum n_i pi(f_i)$, so $x -
  sum n_i f_i in "ker" pi = t(G)$). Since $F ∩ t(G) = {0}$ (free
  vs. torsion), $G ~= F ⊕ t(G)$.
]

This lemma reduces the structure theorem to two cases: the free part
$bb(Z)^r$ (already classified) and the finite torsion part $t(G)$
(classified in §7.2). The rank $r$ is an invariant — by the same
$F / p F$ argument — and the torsion part is classified by its
*p-primary components*, to which we now turn.

== The Structure Theorem // 结构定理

We now state the main theorem in its two standard forms. The two
statements are *equivalent* — each is a re-packaging of the other via
unique factorisation in $bb(Z)$ — but they optimise different
computations, so both are kept on record. The proofs of existence
and uniqueness occupy the second half of this section.

#theorem(name: "Invariant Factor Form")[
  Let $G$ be a finitely generated abelian group. Then there is a
  unique integer $r >= 0$ and a unique list of integers
  $d_1, dots, d_k >= 2$ with $d_1 | d_2 | dots | d_k$ such that
  $
    G ~= bb(Z)^r ⊕ bb(Z) \/ d_1 bb(Z) ⊕ dots.c ⊕ bb(Z) \/ d_k bb(Z).
  $
  The integer $r$ is the *rank* of $G$; the $d_i$ are its *invariant
  factors*.
] <thm:structure-invariant>

The divisibility chain $d_1 | d_2 | dots | d_k$ is what makes the
list canonical: it forces a single ordering of the cyclic torsion
factors, so any two such decompositions of $G$ coincide term by term.
A useful mnemonic: $d_k$ is the largest cyclic direct summand of the
torsion subgroup, and $d_1$ is its exponent.

#theorem(name: "Elementary Divisor Form")[
  Let $G$ be a finitely generated abelian group. Then there is a
  unique integer $r >= 0$ and a unique multiset of prime powers
  $p_1^(a_1), dots, p_s^(a_s)$ (each $p_i$ prime, each $a_i >= 1$)
  such that
  $
    G ~= bb(Z)^r ⊕ bb(Z) \/ p_1^(a_1) bb(Z) ⊕ dots.c ⊕ bb(Z) \/ p_s^(a_s) bb(Z).
  $
  The $p_i^(a_i)$ are the *elementary divisors* of $G$.
] <thm:structure-elementary>

The elementary divisors are the *finest* torsion data: each cyclic
summand has prime-power order, so it cannot be split further. The
invariant factors, by contrast, pack the same data into the smallest
number of cyclic summands. The two views are equivalent by the
*primary decomposition*, which we now develop.

#lemma(name: "p-Primary Decomposition")[
  Let $G$ be a finite abelian group of order
  $n = p_1^(a_1) dots.c p_s^(a_s)$ (prime factorisation). For each
  prime $p$ dividing $abs(G)$, the *$p$-primary component* of $G$ is
  $
    G_(p) = {x in G : p^k x = 0 "for some" k >= 1}.
  $
  Then:
  + Each $G_(p)$ is a subgroup of $G$.
  + $G ~= G_(p_1) ⊕ dots.c ⊕ G_(p_s)$ (internal direct sum).
  + $abs(G_(p)) = p^(a_p)$ where $p^(a_p)$ is the $p$-part of $abs(G)$.
] <lem:p-primary-decomposition>

#proof[
  (1) *Closure*: if $p^k x = 0$ and $p^ell y = 0$ then
  $p^(max(k, ell)) (x - y) = 0$, so $G_(p)$ is closed under subtraction.
  Since $G$ is abelian, $G_(p)$ is automatically normal, hence a
  subgroup.

  (2) *Direct sum*: write $n_p = n \/ p^(a_p)$, the $p'$-part of $n$.
  The integers $n_(p_1), dots, n_(p_s)$ are jointly coprime — their
  gcd is $1$ — so by repeated Bezout there exist $u_1, dots, u_s in
  bb(Z)$ with $sum_(p=1)^s u_p n_p = 1$. For any $x in G$, set
  $
    x_p = u_p n_p dot x in G, quad p = 1, dots, s.
  $
  Then $p^(a_p) x_p = u_p n_p p^(a_p) x = u_p n x = 0$ (Lagrange,
  #link(<thm:lagrange>)[§3.2]: $n x = 0$ for every $x in G$), so
  $x_p in G_(p_p)$. And $x = sum_p x_p$ because
  $sum_p u_p n_p = 1$. Hence $G = sum_p G_(p_p)$.

  For independence, suppose
  $x in G_(p_p) ∩ sum_(q != p) G_(q_q)$. Then $p^(a_p) x = 0$
  (since $x in G_(p_p)$), and there are elements $y_q in G_(q_q)$
  with $x = sum_(q != p) y_q$, so $m x = 0$ for any common multiple
  $m$ of $q^(a_q)$ for $q != p$ — such an $m$ is coprime to $p$. Bezout
  gives $u, v$ with $u p^(a_p) + v m = 1$, so
  $
    x = (u p^(a_p) + v m) x = u p^(a_p) x + v m x = 0 + 0 = 0.
  $
  Hence $G_(p_p) ∩ sum_(q != p) G_(q_q) = {0}$, and the sum is direct.

  (3) By (2) and #link(<prop:order-direct-sum>)[§7.1],
  $abs(G) = product_p abs(G_(p_p))$. Every element of $G_(p_p)$ has
  $p$-power order (by definition), so $G_(p_p)$ is a $p$-group and
  $abs(G_(p_p))$ is a power of $p$. Since the prime factorisation of
  $abs(G)$ is $product_p p^(a_p)$, we must have $abs(G_(p_p)) = p^(a_p)$.
]

The $p$-primary decomposition reduces the structure theorem for a
*finite* abelian group to the case of a $p$-group. For *finitely
generated* groups, combine with #link(<lem:free-subgroup>)[the free
subgroup lemma] to peel off the free part $bb(Z)^r$ first; then the
finite torsion part splits as $t(G) ~= ⊕_p G_(p_p)$, and the theorem
is reduced to the finite $p$-group case.

#note(title: "Equivalence of the Two Canonical Forms")[
  The two forms in
  #link(<thm:structure-invariant>)[the invariant factor theorem] and
  #link(<thm:structure-elementary>)[the elementary divisor theorem]
  are equivalent. To pass from invariant factors to elementary
  divisors: factorise each $d_j$ into prime powers,
  $d_j = product_p p^(a_(p, j))$, and lay out all the resulting
  prime powers as the elementary divisors (with repetitions). To pass
  back: collect the elementary divisors of each prime $p$, order the
  powers increasingly as
  $a_(p, 1) <= dots.c <= a_(p, k_p)$, pad shorter columns at the
  *top* with $p^0 = 1$ so every column has length $k = max_p k_p$,
  and reconstruct each invariant factor as
  $
    d_i = product_p p^(a_(p, i)), quad i = 1, dots, k.
  $
  Because each column is sorted increasingly, $a_(p, i) <= a_(p, i+1)$,
  so $d_i | d_(i+1)$; the divisibility $d_1 | d_2 | dots | d_k$ is
  automatic.
] <note:two-canonical-forms>

#figure(
  image("img/factor-correspondence.svg"),
  caption: [The dictionary between invariant factors $d_1, d_2, d_3$
  and elementary divisors. Each row reconstructs one $d_j$ as the
  product of one prime power per column, with the powers ordered
  increasingly down each column; this guarantees $d_1 | d_2 | d_3$.]
) <fig:factor-correspondence>

=== Existence and Uniqueness of the Decomposition // 分解的存在性与唯一性

We now prove #link(<thm:structure-invariant>)[the structure theorem]
— both existence and uniqueness. Existence is an application of the
*Smith normal form* of an integer matrix; uniqueness then follows from
counting elements of bounded order in each $p$-primary component.

#theorem(name: "Smith Normal Form over Z")[
  Let $A$ be an $m times n$ integer matrix. Then $A$ can be
  transformed by elementary row and column operations (over $bb(Z)$)
  into a diagonal matrix
  $
    "diag"(d_1, d_2, dots, d_r, 0, dots, 0), quad d_1 | d_2 | dots | d_r, quad d_i > 0,
  $
  for some $r <= min(m, n)$. The $d_i$ are unique (given $A$) and are
  the *invariant factors* of $A$.
] <thm:smith-normal-form>

#proof[
  *Existence.* The algorithm runs in two phases.

  Phase (i) — *Diagonalisation.* If $A = 0$ we are done. Otherwise
  pick an entry of $A$ of smallest positive absolute value; by row
  and column swaps, move it to position $(1, 1)$ and call it $a$. For
  every other entry $b$ in row 1, divide $b$ by $a$: write
  $b = q a + r$ with $0 <= r < a$, and subtract $q$ times column 1
  from the column containing $b$. If some $r != 0$, move $r$ to
  position $(1, 1)$ (so $a$ shrinks). Repeat until all off-diagonal
  entries in row 1 are zero. Apply the same procedure to column 1
  (using row operations), then recurse on the
  $(m - 1) times (n - 1)$ minor. Termination is guaranteed because
  the absolute value of the $(1, 1)$ entry strictly decreases at each
  swap.

  Phase (ii) — *Divisibility chain.* Suppose phase (i) yields
  diagonal entries $delta_1, dots, delta_r$ with $delta_i > 0$. If
  $delta_i$ does not divide $delta_(i+1)$ for some $i$, add row
  $(i+1)$ to row $i$ (so the $(i, i+1)$ entry becomes
  $delta_(i+1)$ and the $(i, i)$ entry remains $delta_i$), then
  re-run phase (i) on the $2 times 2$ block in rows $i, i+1$ and
  columns $i, i+1$. The new top-left entry is
  $gcd(delta_i, delta_(i+1))$, a strict divisor of $delta_i$ unless
  $delta_i | delta_(i+1)$ already. The product
  $delta_1 dots.c delta_r$ is preserved by the operations, so the
  iteration terminates, producing $d_1 | d_2 | dots | d_r$.

  *Uniqueness (sketch).* For each $k = 1, dots, r$, let $Delta_k(A)$
  be the gcd of all $k times k$ minors of $A$ (with $Delta_0 = 1$).
  Elementary row and column operations do not change $Delta_k$ (they
  multiply $k$-minors by $plus.minus 1$ or replace them with
  $bb(Z)$-combinations, which preserves the gcd). For the diagonal
  form, $Delta_k = d_1 d_2 dots.c d_k$. Hence
  $d_k = Delta_k \/ Delta_(k-1)$ is determined by $A$, so the list
  $d_1, dots, d_r$ is unique.
]

We can now complete the proof of the structure theorem.

*Existence in the structure theorem.* By
#link(<lem:free-subgroup>)[the free subgroup lemma], $G$ admits a
surjection $phi : bb(Z)^n -> G$ with $G ≅ bb(Z)^n \/ "ker" phi$. The
kernel $"ker" phi$ is a subgroup of $bb(Z)^n$; since $bb(Z)$ is
Noetherian (every ideal of $bb(Z)$ is principal), every subgroup of
$bb(Z)^n$ is finitely generated, so $"ker" phi = A dot bb(Z)^m$ for
some $n times m$ integer matrix $A$.

Apply #link(<thm:smith-normal-form>)[Smith normal form] to $A$:
there are unimodular matrices $P in "GL"_n(bb(Z))$ and
$Q in "GL"_m(bb(Z))$ with
$
  P A Q = "diag"(d_1, dots, d_r, 0, dots, 0), quad d_1 | dots | d_r.
$
The change of basis $P$ on $bb(Z)^n$ and $Q$ on $bb(Z)^m$ are
isomorphisms, so they do not change $G$ up to isomorphism. After
the change of basis, the quotient becomes
$
  bb(Z)^n \/ "diag"(d_1, dots, d_r, 0, dots, 0) bb(Z)^m ~= bb(Z) \/ d_1 bb(Z) ⊕ dots.c ⊕ bb(Z) \/ d_r bb(Z) ⊕ bb(Z)^(n-r).
$
Setting $r_("free") = n - r$ (the free part) and discarding any
$d_i = 1$ (which give trivial cyclic summands $bb(Z) \/ 1 bb(Z) =
{0}$) yields the invariant factor decomposition of
#link(<thm:structure-invariant>)[the theorem].

*Uniqueness.* By
#link(<lem:p-primary-decomposition>)[the $p$-primary decomposition],
uniqueness for $G$ reduces to uniqueness for each $p$-primary
component $G_(p)$. So assume $G$ is a finite abelian $p$-group with
two decompositions
$
  G ~= bb(Z) \/ p^(a_1) ⊕ dots.c ⊕ bb(Z) \/ p^(a_k)
  ~= bb(Z) \/ p^(b_1) ⊕ dots.c ⊕ bb(Z) \/ p^(b_ell),
$
with $a_1 >= dots >= a_k >= 1$ and $b_1 >= dots >= b_ell >= 1$. We
show $k = ell$ and $a_i = b_i$ for all $i$.

For $j >= 0$, let $G[p^j] = {x in G : p^j x = 0}$, the $p^j$-torsion
subgroup. In the first decomposition,
$
  abs(G[p^j]) = product_(i=1)^k p^(min(a_i, j)) = p^(sum_(i=1)^k min(a_i, j)).
$
The same formula on the second decomposition gives
$abs(G[p^j]) = p^(sum_(i=1)^ell min(b_i, j))$. So for every $j >= 0$,
$
  sum_(i=1)^k min(a_i, j) = sum_(i=1)^ell min(b_i, j).
$
Subtracting the $j$-equation from the $(j+1)$-equation gives
$
  abs({i : a_i >= j+1}) = abs({i : b_i >= j+1}), quad forall j >= 0.
$
The sequence $abs({i : a_i >= 1}) >= abs({i : a_i >= 2}) >= dots$
determines the multiset ${a_i}$ by telescoping: the number of $i$
with $a_i = j$ is $abs({i : a_i >= j}) - abs({i : a_i >= j+1})$.
Hence the multiset ${a_i}$ is determined by $G$, so after sorting
$a_i = b_i$ term by term, and $k = ell$.

This completes the proof of both existence and uniqueness in
#link(<thm:structure-invariant>)[the structure theorem]. The
equivalence with the elementary divisor form
(#link(<thm:structure-elementary>)[the elementary divisor theorem])
follows from #link(<note:two-canonical-forms>)[the dictionary
between the two forms], so the elementary divisor form is also
uniquely determined by $G$.

#note(title: "Generalisation to Principal Ideal Domains")[
  The proof of the structure theorem goes through verbatim with
  $bb(Z)$ replaced by any principal ideal domain (PID) $R$: every
  finitely generated $R$-module $M$ admits a Smith normal form, and
  the same counting argument gives uniqueness. The structure theorem
  then reads
  $
    M ~= R^r ⊕ R \/ d_1 R ⊕ dots.c ⊕ R \/ d_k R, quad d_1 | dots | d_k,
  $
  with $d_i$ defined up to units of $R$. The case $R = k[x]$ (polynomials
  over a field) gives the *rational canonical form* of a linear
  operator, and the elementary divisor form gives the *Jordan normal
  form* (after base-change to the algebraic closure of $k$). We will
  develop the module-theoretic version in the chapters on ring theory.
] <note:pid-generalisation>

== Classification of Finite Abelian Groups // 有限 Abel 群的分类

The structure theorem gives a *complete* classification of finite
abelian groups: such a group is determined up to isomorphism by its
list of elementary divisors (or, equivalently, its list of invariant
factors). We illustrate this with explicit enumeration in small
orders, and connect the result to the Sylow theory of
#link(<thm:sylow-first>)[§6.3].

#corollary(name: "Full Converse of Lagrange in the Abelian Case")[
  Let $G$ be a finite abelian group of order $n$. For every divisor
  $d | n$, there is a subgroup $H <= G$ with $abs(H) = d$.
] <cor:lagrange-converse-abelian>

#proof[
  Factorise $n = p_1^(a_1) dots.c p_s^(a_s)$. By
  #link(<lem:p-primary-decomposition>)[the $p$-primary
  decomposition], $G ~= G_(p_1) ⊕ dots.c ⊕ G_(p_s)$ with
  $abs(G_(p_i)) = p_i^(a_i)$. Any divisor $d | n$ factors as
  $d = d_1 dots.c d_s$ with $d_i | p_i^(a_i)$. It suffices to find,
  in each $G_(p_i)$, a subgroup of order $d_i$.

  So let $G$ be a finite abelian $p$-group, written in elementary
  divisor form as
  $G ~= bb(Z) \/ p^(a_1) ⊕ dots.c ⊕ bb(Z) \/ p^(a_k)$
  with $a_1 >= dots >= a_k >= 1$. Any divisor of $p^(a_1 + dots + a_k)$
  has the form $p^(b_1 + dots + b_k)$ with $0 <= b_i <= a_i$. In the
  $i$-th summand $bb(Z) \/ p^(a_i) bb(Z)$, the subgroup
  $
    p^(a_i - b_i) bb(Z) \/ p^(a_i) bb(Z) ~= bb(Z) \/ p^(b_i) bb(Z)
  $
  has order $p^(b_i)$. The direct sum of these subgroups gives a
  subgroup of $G$ of order $p^(b_1 + dots + b_k) = d$.
]

The abelian case is thus the "happy" setting for Lagrange's theorem:
*every* divisor is realised as the order of a subgroup. In a general
finite group this fails (cf. $A_4$ has no subgroup of order $6$,
although $6 | 12$).

#property(name: "Exponent Equals Maximum Order")[
  Let $G$ be a finite abelian group. The *exponent* of $G$ — the
  smallest $m$ with $m G = {0}$ — equals the maximum order of an
  element of $G$. In invariant factor form, the exponent is $d_k$,
  the last (largest) invariant factor.
] <prop:exponent-characterisation>

#proof[
  Write $G ~= bb(Z) \/ d_1 ⊕ dots.c ⊕ bb(Z) \/ d_k$ with
  $d_1 | dots | d_k$. The exponent is the least common multiple of
  the $d_i$, which — because $d_i | d_k$ for all $i$ — is exactly
  $d_k$. The element $(0, dots, 0, overline(1))$ in the last summand
  has order $d_k$, so the maximum order equals the exponent.
]

We now illustrate the classification by enumerating abelian groups of
small orders.

#example(name: "Abelian Groups of Order 8")[
  We classify abelian groups $G$ with $abs(G) = 8 = 2^3$. The
  elementary divisors are partitions of the exponent $3$ (as a sum of
  positive integers, the exponents of $2$ in each cyclic summand).
  There are three partitions of $3$:

  + $3 = 3$: one elementary divisor $2^3$, so
    $G ~= bb(Z) \/ 8 bb(Z)$ (cyclic of order $8$).

  + $3 = 2 + 1$: elementary divisors $2^2, 2^1$, so
    $G ~= bb(Z) \/ 4 bb(Z) ⊕ bb(Z) \/ 2 bb(Z)$.

  + $3 = 1 + 1 + 1$: three elementary divisors $2^1, 2^1, 2^1$, so
    $G ~= (bb(Z) \/ 2 bb(Z))^3$.

  In invariant factor form (using
  #link(<note:two-canonical-forms>)[the dictionary]), the three
  groups are $bb(Z) \/ 8 bb(Z)$ with $d_1 = 8$;
  $bb(Z) \/ 4 bb(Z) ⊕ bb(Z) \/ 2 bb(Z)$ with $d_1 = 2 | d_2 = 4$;
  and $(bb(Z) \/ 2 bb(Z))^3$ with $d_1 = d_2 = d_3 = 2$.
] <ex:abelian-order-8>

#example(name: "Abelian Groups of Order 12")[
  We classify abelian groups $G$ with $abs(G) = 12 = 2^2 dot 3$. By
  #link(<lem:p-primary-decomposition>)[the $p$-primary
  decomposition], $G ~= G_(2) ⊕ G_(3)$ with $abs(G_(2)) = 4$ and
  $abs(G_(3)) = 3$.

  Abelian groups of order $4 = 2^2$: the partitions of $2$ give two
  groups:
  $bb(Z) \/ 4 bb(Z)$ (partition $2 = 2$) and
  $bb(Z) \/ 2 bb(Z) ⊕ bb(Z) \/ 2 bb(Z)$ (partition $2 = 1 + 1$).

  Abelian groups of order $3 = 3^1$: only one, $bb(Z) \/ 3 bb(Z)$
  (partition $1 = 1$).

  Combining via direct sum (and using the Chinese Remainder Theorem
  to merge coprime cyclic factors), the abelian groups of order $12$
  are:

  + $bb(Z) \/ 4 bb(Z) ⊕ bb(Z) \/ 3 bb(Z) ~= bb(Z) \/ 12 bb(Z)$
    (cyclic, since $gcd(4, 3) = 1$).

  + $bb(Z) \/ 2 bb(Z) ⊕ bb(Z) \/ 2 bb(Z) ⊕ bb(Z) \/ 3 bb(Z)
    ~= bb(Z) \/ 2 bb(Z) ⊕ bb(Z) \/ 6 bb(Z)$
    (merge one factor $2$ with the $3$ via CRT).

  The invariant factor forms are $bb(Z) \/ 12 bb(Z)$ with
  $d_1 = 12$; and $bb(Z) \/ 2 bb(Z) ⊕ bb(Z) \/ 6 bb(Z)$ with
  $d_1 = 2 | d_2 = 6$.
] <ex:abelian-order-12>

The general pattern is now clear: *abelian groups of order $n$ are in
bijection with multisets of prime powers whose product is $n$*, or
equivalently with divisibility chains $d_1 | dots | d_k$ with
$d_1 dots.c d_k = n$.

#note(title: "Relation to the Sylow Theorems")[
  In a finite abelian group $G$ of order
  $p_1^(a_1) dots.c p_s^(a_s)$, the $p_i$-primary component
  $G_(p_i)$ is the *unique* Sylow $p_i$-subgroup (of order
  $p_i^(a_i)$). Uniqueness is automatic: $G$ is abelian, so every
  subgroup is normal, and the conjugate Sylow $p_i$-subgroups (which
  #link(<thm:sylow-second>)[the second Sylow theorem] says are all
  conjugate) must all coincide.

  The structure theorem refines the Sylow theorem in the abelian
  case: not only does a Sylow $p$-subgroup exist
  (#link(<thm:sylow-first>)[the first Sylow theorem]) and is unique,
  it splits *as a direct sum of cyclic groups of prime-power order*.
  For *general* finite groups, the Sylow theorems give existence and
  conjugacy of $p$-subgroups but no internal decomposition — that
  is the special gift of commutativity.
] <note:sylow-connection>

=== Closing Remarks on Group Theory // 群论总结

The structure theorem for finitely generated abelian groups closes
the group-theoretic half of this book. Three threads converge here:

- *Lagrange's theorem* (#link(<thm:lagrange>)[§3.2]) restricted the
  possible orders of subgroups; the structure theorem realises
  *every* divisor in the abelian case
  (#link(<cor:lagrange-converse-abelian>)[above]).
- *The Sylow theorems* (#link(<thm:sylow-first>)[§6.3]) guaranteed
  Sylow $p$-subgroups in any finite group; in the abelian case, the
  $p$-primary decomposition makes them unique and completely
  decomposes them.
- *The isomorphism theorems* (#link(<thm:first-isomorphism>)[§5.2])
  let us write $G$ as a quotient $bb(Z)^n \/ "ker" phi$, from which
  the Smith normal form extracts the invariant factors.

For *non-abelian* groups, no structure theorem of comparable strength
exists — the simplicity of $A_5$ (#link(<ex:a5-simple>)[§4.3])
already shows that the building blocks are far more varied than the
cyclic groups $bb(Z) \/ n bb(Z)$. The rest of this book shifts focus
from groups to *rings* and *modules*, where the structure theorem
generalises beautifully: the same proof, with $bb(Z)$ replaced by any
principal ideal domain $R$, classifies finitely generated $R$-modules
(#link(<note:pid-generalisation>)[§7.2]).

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
