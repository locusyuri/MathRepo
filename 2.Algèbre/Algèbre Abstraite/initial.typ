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
