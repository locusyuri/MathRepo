#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Logique Mathématique", // 数理逻辑
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Logique Mathématique", // 数理逻辑
  "Violet",
  subtitle: "A notebook for mathematical logic",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.8.0",
  extra-info: "This is a notebook for mathematical logic.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline) — v0.8.0
// 主线：语言基础 → 主体理论 → 元数学 → 扩展（四段式）
// 参照 Analyse Mathématique：每个 Part 容纳 2–4 章实质内容
// 状态标记：[已写] 已完成 · [计划] 待写作 · [可选] 按需取舍
// ==========================================================================

// ==========================================================================
// Part I — Propositional Logic（命题逻辑）— 语言基础
// ==========================================================================
// 设计思路：最简单的形式语言。Ch 1 已完整写作（v0.3.0 完成修复）；
//   Ch 2 为方法章，承接紧致性与归结，形成命题层闭环。
// 对应教材：Enderton Ch 1；Mendelson Ch 1

// --- Chapter 1: The Propositional Calculus（命题演算）--- [已写]
//   Section 1.1: Connectives and Truth Tables（联结词与真值表）
//   Section 1.2: Formal Language and WFF（形式语言与合式公式）
//   Section 1.3: Axiom Systems（公理系统）
//   Section 1.4: Proof and Consistency（证明与一致性）
//   Section 1.5: Deduction Theorem and Derived Rules（演绎定理与导出规则）
//   Section 1.6: Law of Contradiction and Reductio ad Absurdum（矛盾律与反证法）
//   Section 1.7: Propositional Algebra（命题代数）
//   Section 1.8: Semantics: Valuations and Tautologies（语义：赋值与重言式，含完全性证明）

// --- Chapter 2: Normal Forms, Resolution and Compactness（范式、归结与紧致性）--- [计划]
//   Section 2.1: Normal Forms and Truth-Functional Completeness（范式与真值函数完备性）
//   Section 2.2: Resolution（归结原理：可靠性/完全性）
//   Section 2.3: Propositional Compactness（命题紧致性）
//   Section 2.4: Applications（应用：SAT、König 引理）

// ==========================================================================
// Part II — First-Order Logic（一阶逻辑）— 主体理论
// ==========================================================================
// 设计思路：占位 Part 升级为全书主体，四章推进：语法 → 语义 → 证明论 → 元定理。
//   Henkin 完全性（Ch 5.4）为全书核心定理。
// 对应教材：Enderton Ch 2–3；Mendelson Ch 2–3

// --- Chapter 3: Syntax of First-Order Logic（一阶逻辑语法）--- [已写，v0.5.0]
//   Section 3.1: Signatures, Terms, and Formulas（签名、项与公式）
//   Section 3.2: Free and Bound Variables; Substitution（自由/约束变元与替换）
//   Section 3.3: Prenex Normal Forms and Skolemization（前束范式与斯科伦化）
//   Section 3.4: Herbrand's Theorem（Herbrand 定理）

// --- Chapter 4: Semantics of First-Order Logic（一阶逻辑语义）--- [已写，v0.6.0]
//   Section 4.1: Structures and Interpretations（结构与解释）
//   Section 4.2: Satisfaction and Truth（满足与 Tarski 真定义）
//   Section 4.3: Semantic Consequence, Equivalence and Normal Form Correctness
//     （逻辑后承、等价与范式正确性；兑现 Ch 3 前束/斯科伦验证承诺）
//   Section 4.4: Elementary Equivalence（初等等价）

// --- Chapter 5: Proof Theory and Completeness（证明论与完全性）--- [已写，v0.7.0]
//   Section 5.1: Hilbert System for FOL（一阶 Hilbert 系统：量词公理 + Generalization）
//   Section 5.2: Deduction Theorem for FOL（一阶演绎定理与推广规则约束）
//   Section 5.3: Soundness（可靠性）
//   Section 5.4: Henkin Completeness（Henkin 完全性；全书核心定理，已证）

// --- Chapter 6: Compactness and Löwenheim–Skolem（紧致性与 L-S）--- [已写，v0.8.0]
//   Section 6.1: Compactness Theorem（紧致性定理；兑现 Ch 3 Herbrand 有限方向）
//   Section 6.2: Löwenheim–Skolem Theorems（上升/下降 L-S 与 Skolem 悖论）
//   Section 6.3: Applications（应用：非标准模型）
//   Section 6.4: Definability（可定义性初步）

// ==========================================================================
// Part III — Metamathematics（元数学：模型论、可计算性与不完备性）— 元理论两翼
// ==========================================================================
// 设计思路：语义侧（模型论：理论有哪些模型）与语法侧（可计算性：能算什么；
//   不完备性：证不出什么）合为一 Part，递进：模型 → 计算 → 极限。
// 对应教材：Enderton Ch 3 模型论部分 + Ch 4；Mendelson Ch 3–4

// --- Chapter 7: Elementary Model Theory（初等模型论）--- [计划]
//   Section 7.1: Substructures and Elementary Substructures（子结构与初等子结构，Tarski–Vaught）
//   Section 7.2: Ultraproducts and Łoś's Theorem（超积与 Łoś 定理；交叉引用 Théorie des Ensembles §7.1 超滤）
//   Section 7.3: Complete Theories and Categoricity（完备理论与范畴性）
//   Section 7.4: Quantifier Elimination（量词消去：DLO、ACF）[可选]

// --- Chapter 8: Computable Functions and Undecidability（可计算函数与不可判定性）--- [计划]
//   Section 8.1: Primitive Recursive Functions（原始递归函数）
//   Section 8.2: Partial Recursive Functions and Church's Thesis（部分递归函数与 Church 论题）
//   Section 8.3: Turing Machines and the Halting Problem（图灵机与停机问题）
//   Section 8.4: Undecidability of First-Order Logic（一阶逻辑的不可判定性）

// --- Chapter 9: Gödel's Incompleteness Theorems（Gödel 不完备定理）--- [计划]
//   Section 9.1: Arithmetization of Syntax（语法算术化：Gödel 编码、可表示性）
//   Section 9.2: The First Incompleteness Theorem（第一不完备定理）
//   Section 9.3: The Second Incompleteness Theorem（第二不完备定理）
//   Section 9.4: Tarski's Undefinability of Truth（真值不可定义性）[可选]

// ==========================================================================
// Part IV — Extensions（扩展：二阶与非经典逻辑）— 展望
// ==========================================================================
// 设计思路：二阶逻辑在标准语义下无完全性，不宜与经典主线并列，降级为扩展章；
//   非经典逻辑为未来 Non-Classical Logic 笔记搭桥（桥梁模式）。
// 对应教材：Hedman Ch 6–7（扩展主题）

// --- Chapter 10: Second-Order Logic（二阶逻辑）--- [升级：原占位 Part]
//   Section 10.1: Syntax and Semantics（二阶语法与语义）
//   Section 10.2: Standard vs. Henkin Semantics（标准语义 vs Henkin 语义）
//   Section 10.3: Failure of Compactness and Completeness（紧致性与完全性失效）
//   Section 10.4: Categoricity of Second-Order Arithmetic（二阶算术的范畴性）[可选]

// --- Chapter 11: Non-Classical Logics: An Introduction（非经典逻辑导论）--- [可选]
//   Section 11.1: Intuitionistic Logic and Kripke Semantics（直觉主义逻辑与 Kripke 语义）
//   Section 11.2: Modal Logic: Basics（模态逻辑基础）
//   Section 11.3: Many-Valued Logics（多值逻辑）[可选]

// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循"语言基础 → 主体理论 → 元数学 → 扩展"的四段式主线，
// 共 4 个内容 Part、11 章（加附录共 5 个 Part、约 47 节）。
//
// Part I（语言基础，Ch 1–2）：命题逻辑。Ch 1 已完整写作；Ch 2 为方法章
//   （范式、归结、紧致性），形成命题层闭环。
//
// Part II（主体理论，Ch 3–6）：一阶逻辑。语法 → 语义 → 证明论 →
//   紧致性/L-S。Ch 3–6 全部完成（v0.8.0）：语法、语义、证明论与
//   Henkin 完全性（Ch 5.4，全书核心定理）、紧致性与 L-S（Ch 6）均已写就。
//
// Part III（元数学，Ch 7–9）：模型论（理论有哪些模型）→ 可计算性（能算什么）
//   → 不完备性（证不出什么），元理论两翼递进。
//
// Part IV（扩展，Ch 10–11）：二阶逻辑（标准语义下无完全性，降级为扩展章）
//   与非经典逻辑导论（为未来笔记搭桥）。
//
// 教材覆盖：Enderton《A Mathematical Introduction to Logic》全部章节知识点
//   已纳入；Mendelson 公理化路线与 Hedman 扩展主题取并集。
// ==========================================================================

#part("Propositional Logic")  // 命题逻辑

= The Propositional Calculus  // 命题演算

== Connectives and Truth Tables  // 联结词与真值表

A *proposition* is a statement whose truth value can be determined
(represented by $1$ for true and $0$ for false).

#note[
  The set of logical truth values can be represented in various ways,
  such as ${T, F}$, ${top, bot}$, or ${"True", "False"}$. We use
  ${0, 1}$ throughout this book for simplicity.
]

We use lowercase letters such as $p, q, r, dots$ to denote
propositions. In classical binary logic, a proposition is either true
or false.

There are five commonly used propositional connectives.

#definition(name: "Negation")[
  If $p$ is a proposition, the *negation* of $p$, denoted by $¬p$,
  is true if and only if $p$ is false.
] <def:negation>

#tex-table(
  ([$p$], [$¬p$]),
  ([$0$], [$1$]),
  ([$1$], [$0$]),
)

#definition(name: "Conjunction")[
  The *conjunction* of two propositions $p$ and $q$, denoted by
  $p ∧ q$, is true if and only if both $p$ and $q$ are true.
] <def:conjunction>

#tex-table(
  ([$p$], [$q$], [$p ∧ q$]),
  ([$0$], [$0$], [$0$]),
  ([$0$], [$1$], [$0$]),
  ([$1$], [$0$], [$0$]),
  ([$1$], [$1$], [$1$]),
)

#definition(name: "Disjunction")[
  The *disjunction* of two propositions $p$ and $q$, denoted by
  $p ∨ q$, is true if and only if at least one of $p$ or $q$ is true.
] <def:disjunction>

#tex-table(
  ([$p$], [$q$], [$p ∨ q$]),
  ([$0$], [$0$], [$0$]),
  ([$0$], [$1$], [$1$]),
  ([$1$], [$0$], [$1$]),
  ([$1$], [$1$], [$1$]),
)

#definition(name: "Implication")[
  The *implication* $p -> q$ (read "if $p$, then $q$") is false if
  and only if $p$ is true and $q$ is false.
] <def:implication>

#tex-table(
  ([$p$], [$q$], [$p -> q$]),
  ([$0$], [$0$], [$1$]),
  ([$0$], [$1$], [$1$]),
  ([$1$], [$0$], [$0$]),
  ([$1$], [$1$], [$1$]),
)

#definition(name: "Biconditional")[
  The *biconditional* of two propositions $p$ and $q$, denoted by
  $p ↔ q$, is true if and only if $p$ and $q$ have the same
  truth value.
] <def:biconditional>

#tex-table(
  ([$p$], [$q$], [$p ↔ q$]),
  ([$0$], [$0$], [$1$]),
  ([$0$], [$1$], [$0$]),
  ([$1$], [$0$], [$0$]),
  ([$1$], [$1$], [$1$]),
)

== Formal Language and Well-Formed Formulas  // 形式语言与合式公式

Propositional calculus (also called *zero-order logic*) is a formal
system whose formulas are constructed from a fixed alphabet.

#definition(name: "Formal System of Propositional Calculus")[
  A *formal system* for propositional calculus is a quadruple
  $cal(L) = (A, Omega, Z, I)$, where:
  - $A$: the set of *propositional variables* (atomic propositions);
  - $Omega$: the set of *logical connectives*, partitioned into
    $Omega = Omega_0 union Omega_1 union Omega_2 union dots$, where
    $Omega_j$ is the set of $j$-ary connectives. Typically
    $Omega_0 = {0, 1}$, $Omega_1 = {¬}$,
    $Omega_2 = {∧, ∨, ->, ↔}$;
  - $Z$: the set of *inference rules*;
  - $I$: the set of *axioms*.
  Parentheses $"("$ and $")"$ are auxiliary symbols used to clarify
  the construction of formulas.
] <def:formal-system>

#definition(name: "Well-Formed Formula (WFF)")[
  The language of $cal(L)$, denoted by $L(A)$, is the set of
  *well-formed formulas* (WFFs, or formulas). A formula is a finite
  sequence of symbols from $A$ and $Omega$ constructed recursively:
  + Any propositional variable $p in A$ is a formula.
  + If $p_1, p_2, dots, p_j$ are formulas and $f in Omega_j$, then
    $(f\ p_1 p_2 dots p_j)$ is a formula.
  + Every formula is obtained by finitely many applications of the
    rules above.
] <def:wff>

#note[
  The set $L(A)$ can be *stratified by depth*: let $L_0(A) = A$, and
  for $n >= 0$,
  $
    L_(n+1)(A) = L_(n)(A) union {(f p_1 dots p_j) | p_i in L_(n)(A) "for all" i,
      "and" p_k in.not L_(n-1)(A) "for some" k},
  $
  with $L_(-1)(A) = emptyset$. Then
  $L(A) = union.big_(n >= 0) L_(n)(A)$, and every formula first appears
  exactly in the layer equal to its depth, where $d(p) = 0$ for
  $p in A$ and $d((f p_1 dots p_j)) = 1 + max_i d(p_i)$.
]

#definition(name: "Derived Connectives")[
  In a system whose primitive connectives are $¬$ and $->$, the
  other binary connectives are introduced as *abbreviations*:
  $
    p ∨ q = ¬p -> q, \
    p ∧ q = ¬(p -> ¬q), \
    p ↔ q = (p -> q) ∧ (q -> p).
  $
] <def:derived-connectives>

== Axiom Systems  // 公理系统

Although axiomatic proof has been used since Euclid's *Elements of
Geometry*, in propositional logic it dates back to Gottlob Frege's
1879 *Begriffsschrift*. Frege's system used only implication and
negation as connectives, with six axioms ($p, q, r in A$):

#tex-table(
  ([Axiom], [Name]),
  ([$p -> (q -> p)$], [Law of Simplification]),
  ([$(p -> (q -> r)) -> ((p -> q) -> (p -> r))$], [Law of Self-Distribution]),
  ([$(p -> (q -> r)) -> (q -> (p -> r))$], [Law of Permutation]),
  ([$(p -> q) -> (¬ q -> ¬ p)$], [Law of Transposition]),
  ([$¬ ¬ p -> p$], [Law of Double Negation Elimination]),
  ([$p -> ¬ ¬ p$], [Law of Double Negation Introduction]),
)

These were used by Frege together with modus ponens and a rule of
substitution (which was used but never precisely stated) to yield a
complete and consistent axiomatization of classical truth-functional
propositional logic.

Jan Łukasiewicz showed that, in Frege's system, the third axiom is
superfluous since it can be derived from the preceding two, and that
the last three axioms can be replaced by the single sentence
$(¬ p -> ¬ q) -> (q -> p)$ — written in *Polish notation*
(prefix notation, which allows expressions without parentheses) as
$C C N p N q q p$. This simplified version is the *Łukasiewicz axiom
system*.

#note[
  *Polish notation* (prefix notation) places operators before their
  operands, e.g. $(5 - 6) times 7$ is written as $times - 5 6 7$. It
  is commonly used in logic and computer science.
]

#definition(name: "Łukasiewicz Axiom System")[
  The *Łukasiewicz axiom system* is $cal(L) = (A, Omega, Z, I)$, where:
  - $A$ contains sufficiently many propositional variables;
  - $Omega = Omega_1 union Omega_2$ is *complete*, with
    $Omega_1 = {¬}$ and $Omega_2 = {->}$;
  - $Z$ contains a single inference rule: *modus ponens* (MP): from
    $p$ and $p -> q$, infer $q$;
  - $I$ contains three axiom schemata ($p, q, r in A$):
    + (L1) $p -> (q -> p)$ *(Law of Simplification)*;
    + (L2) $(p -> (q -> r)) -> ((p -> q) -> (p -> r))$
      *(Law of Self-Distribution)*;
    + (L3) $(¬ p -> ¬ q) -> (q -> p)$ *(Law of Contraposition)*.
] <def:lukasiewicz-system>

== Proof and Consistency  // 证明与一致性

#definition(name: "Proof")[
  Let $Gamma subset.eq L(A)$ and $p in L(A)$. We say that $p$ is
  *provable from* $Gamma$ if there exists a finite sequence of
  formulas $p_1, dots, p_n$ with $p_n = p$ such that each $p_k$
  satisfies one of:
  + $p_k in Gamma$ (an assumption);
  + $p_k$ is an instance of an axiom schema;
  + there exist $i, j < k$ such that $p_j = p_i -> p_k$ (an
    application of MP).
  Such a sequence is called a *proof of $p$ from $Gamma$*. We write
  $Gamma ⊢ p$, or $Gamma ⊢_(cal(L)) p$.
] <def:proof>

#definition(name: "Theorem")[
  If $emptyset ⊢ p$, then $p$ is called a *theorem* of $cal(L)$,
  written $⊢ p$. A proof from $emptyset$ is simply a proof in
  $cal(L)$.
] <def:theorem>

#definition(name: "Consistency")[
  A set $Gamma subset.eq L(A)$ is *consistent* if there is no formula
  $q$ such that both $Gamma ⊢ q$ and $Gamma ⊢ ¬ q$ hold.
  Otherwise $Gamma$ is *inconsistent*.
] <def:consistency>

#proposition(name: "Consistency Property")[
  If $Gamma$ is consistent, then:
  + there exists a formula $p$ such that $Gamma ⊬ p$
    (*not every formula is provable*);
  + there exists a formula $p$ such that $Gamma ⊬ ¬ p$
    (*not every negation is provable*).
] <prop:consistency-property>

#proof[
  For the first item, suppose $Gamma ⊢ p$ for every formula $p$. Then
  in particular $Gamma ⊢ q$ and $Gamma ⊢ ¬ q$ for any $q$,
  contradicting #link(<def:consistency>)[consistency].

  For the second, assume $Gamma ⊢ ¬ p$ for every formula $p$. Then in
  particular $Gamma ⊢ ¬ q$ and $Gamma ⊢ ¬ ¬ q$ for any $q$. By
  #link(<cor:double-negation>)[double negation elimination],
  $Gamma ⊢ q$, so
  again $q$ and $¬ q$ are both provable — a contradiction.
]

#proposition(name: "Basic Theorems")[
  The following are theorems of the Łukasiewicz system:
  + $⊢ p -> p$ *(Law of Identity)*;
  + $⊢ ¬ q -> (q -> p)$ *(Principle of Explosion, ex falso quodlibet)*;
  + $⊢ ((p -> (q -> r)) -> (p -> q)) -> ((p -> (q -> r)) -> (p -> r))$.
] <prop:basic-theorems>

== Deduction Theorem and Derived Rules  // 演绎定理与导出规则

#theorem(name: "Deduction Theorem")[
  For any $Gamma subset.eq L(A)$ and $p, q in L(A)$,
  $
    Gamma union {p} ⊢ q quad "iff" quad Gamma ⊢ p -> q.
  $
] <thm:deduction-theorem>

#proof[
  (⇐) If $Gamma ⊢ p -> q$, then the sequence
  consisting of a proof of $p -> q$ from $Gamma$, followed by $p$,
  followed by $q$ (by MP), is a proof of $q$ from $Gamma union {p}$.

  (⇒) We prove by induction on the length $n$ of a proof
  $p_1, dots, p_n = q$ from $Gamma union {p}$.

  *Base case* ($n = 1$): $q$ is either an axiom, an element of
  $Gamma$, or $q = p$. In the first two cases, $q -> (p -> q)$ is an
  instance of (L1), so $Gamma ⊢ p -> q$ by MP. If $q = p$, then
  $p -> p$ is a theorem (#link(<prop:basic-theorems>)[Law of Identity]).

  *Inductive step*: If $q$ is obtained by MP from $p_i$ and
  $p_j = p_i -> q$ ($i, j < n$), then by the induction hypothesis
  $Gamma ⊢ p -> p_i$ and $Gamma ⊢ p -> (p_i -> q)$. Using
  (L2), $(p -> (p_i -> q)) -> ((p -> p_i) -> (p -> q))$, two
  applications of MP yield $Gamma ⊢ p -> q$.
]

#corollary(name: "Hypothetical Syllogism (HS)")[
  ${p -> q, q -> r} ⊢ p -> r$.
] <cor:hypothetical-syllogism>

#proof[
  By the #link(<thm:deduction-theorem>)[Deduction Theorem], it suffices
  to show ${p -> q, q -> r, p} ⊢ r$. Apply MP to $p$ and
  $p -> q$ to get $q$, then to $q$ and $q -> r$ to get $r$.
]

#proposition(name: "Derived Theorems")[
  The following are theorems:
  + $⊢ (p -> q) -> (¬ q -> ¬ p)$ *(Law of Transposition)*;
  + $⊢ p -> ¬ ¬ p$ *(Double Negation Introduction)*;
  + $⊢ ((p -> q) -> p) -> p$ *(Peirce's Law)*;
  + $⊢ ¬ (p -> q) -> (q -> p)$ *(Negated Implication — by
    #link(<prop:negation-reversal>)[Negation Reversal] (iii) and the
    Principle of Explosion, via
    #link(<cor:hypothetical-syllogism>)[HS])*.
] <prop:derived-theorems>

== Law of Contradiction and Reductio ad Absurdum  // 矛盾律与反证法

#theorem(name: "Law of Contradiction")[
  If $Gamma union {¬ p} ⊢ q$ and $Gamma union {¬ p} ⊢ ¬ q$,
  then $Gamma ⊢ p$.
] <thm:law-of-contradiction>

#theorem(name: "Reductio ad Absurdum")[
  If $Gamma union {p} ⊢ q$ and $Gamma union {p} ⊢ ¬ q$,
  then $Gamma ⊢ ¬ p$.
] <thm:reductio-ad-absurdum>

#corollary(name: "Double Negation")[
  + $⊢ p -> ¬ ¬ p$ (Introduction);
  + $⊢ ¬ ¬ p -> p$ (Elimination).
] <cor:double-negation>

#proposition(name: "Negation Reversal")[
  + $⊢ (p -> ¬ q) -> (q -> ¬ p)$;
  + $⊢ (¬ p -> q) -> (¬ q -> p)$;
  + $⊢ ¬ (p -> q) -> ¬ q$;
  + $⊢ ¬ (p -> q) -> p$.
] <prop:negation-reversal>

== Propositional Algebra  // 命题代数

Two formulas $p$ and $q$ are *logically equivalent* (written
$p equiv q$) if $p ↔ q$ is a tautology, i.e., they take the same
truth value under every valuation. The following algebraic laws
hold for all formulas $p, q, r$:

#proposition(name: "Algebraic Laws of Propositional Logic")[
  + *Idempotence*: $p ∧ p ≡ p$, $p ∨ p ≡ p$.
  + *Commutativity*: $p ∧ q ≡ q ∧ p$, $p ∨ q ≡ q ∨ p$.
  + *Associativity*: $(p ∧ q) ∧ r ≡ p ∧ (q ∧ r)$,
    $(p ∨ q) ∨ r ≡ p ∨ (q ∨ r)$.
  + *Distributivity*:
    $p ∧ (q ∨ r) ≡ (p ∧ q) ∨ (p ∧ r)$,
    $p ∨ (q ∧ r) ≡ (p ∨ q) ∧ (p ∨ r)$.
  + *Absorption*: $p ∧ (p ∨ q) ≡ p$, $p ∨ (p ∧ q) ≡ p$.
  + *Identity*: $p ∧ 1 ≡ p$, $p ∨ 0 ≡ p$.
  + *Annihilation*: $p ∧ 0 ≡ 0$, $p ∨ 1 ≡ 1$.
  + *Complement*: $p ∧ ¬ p ≡ 0$, $p ∨ ¬ p ≡ 1$.
  + *Double Negation*: $¬ ¬ p ≡ p$.
  + *De Morgan's Laws*:
    $¬ (p ∧ q) ≡ ¬ p ∨ ¬ q$,
    $¬ (p ∨ q) ≡ ¬ p ∧ ¬ q$.
  + *Implication*: $p -> q ≡ ¬ p ∨ q ≡ ¬ q -> ¬ p$ (contrapositive).
  + *Biconditional*: $p ↔ q ≡ (p -> q) ∧ (q -> p)$.
] <prop:algebraic-laws>

#note[
  Here $1$ and $0$ denote the nullary connectives of $Omega_0$ (the
  constants true and false), in accordance with the convention of
  §1.1. These laws make the set of formulas modulo logical equivalence
  into a *Boolean algebra*: a distributive complemented lattice. This
  is the algebraic perspective on classical propositional logic.
]

== Semantics: Valuations and Tautologies  // 语义：赋值与重言式

#definition(name: "Valuation")[
  A *valuation* (or *truth assignment*) is a function
  $v: A -> {0, 1}$ assigning a truth value to each propositional
  variable. It extends uniquely to all formulas by the truth tables of
  the connectives (#link(<def:negation>)[Negation]–#link(<def:biconditional>)[Biconditional], §1.1).
] <def:valuation>

#definition(name: "Tautology and Semantic Consequence")[
  - A formula $p$ is a *tautology* if $v(p) = 1$ for every valuation
    $v$, written $⊨ p$.
  - A formula $p$ is *satisfiable* if $v(p) = 1$ for some valuation
    $v$.
  - $p$ is a *semantic consequence* of $Gamma$, written
    $Gamma ⊨ p$, if every valuation satisfying all formulas in
    $Gamma$ also satisfies $p$.
] <def:tautology>

#theorem(name: "Soundness and Completeness")[
  For the Łukasiewicz system, for any $Gamma subset.eq L(A)$ and
  $p in L(A)$:
  $
    Gamma ⊢ p quad "iff" quad Gamma ⊨ p.
  $
  In particular, $⊢ p$ iff $p$ is a tautology.
] <thm:soundness-completeness>

#proof[
  *Soundness* ($⊢ => ⊨$). By induction on the length of a proof: every
  instance of the axiom schemata (L1)–(L3) is a tautology, and modus
  ponens preserves tautologicity (if $p$ and $p -> q$ hold under every
  valuation, then so does $q$). Hence every formula provable from
  $Gamma$ is a semantic consequence of $Gamma$.

  *Completeness* ($⊨ => ⊢$). We prove the contrapositive: if
  $Gamma ⊬ p$, then $Gamma ⊭ p$. We assume that $A$ is countable (the
  general case follows by Zorn's lemma).

  + *Step 1 — maximal consistent extension.* Enumerate all formulas of
    $L(A)$ as $p_1, p_2, dots$. Define $Gamma_0 = Gamma$ and, for
    $n >= 0$, set $Gamma_(n+1) = Gamma_n union {p_(n+1)}$ whenever
    this set is consistent, and $Gamma_(n+1) = Gamma_n$ otherwise.
    Let $Gamma^* = union.big_(n >= 0) Gamma_n$. Each $Gamma_n$ is
    consistent; since every proof uses only finitely many formulas, a
    contradiction from $Gamma^*$ would already arise from some
    $Gamma_n$, so $Gamma^*$ is consistent. Moreover $Gamma^*$ is
    *maximal consistent*: if $q in.not Gamma^*$, then $q = p_k$ for
    some $k$, and $Gamma_k union {q}$ was inconsistent at step $k$,
    so $Gamma^* union {q}$ is inconsistent.

  + *Step 2 — two closure properties.* For a maximal consistent
    $Gamma^*$:
    - *Deductive closure.* $Gamma^* ⊢ q$ iff $q in Gamma^*$. The
      "if" direction is the assumption rule. Conversely, if
      $Gamma^* ⊢ q$ but $q in.not Gamma^*$, then
      $Gamma^* union {q}$ is inconsistent, so for some $r$ both
      $Gamma^* union {q} ⊢ r$ and $Gamma^* union {q} ⊢ ¬ r$ hold; by
      the #link(<thm:deduction-theorem>)[Deduction Theorem],
      $Gamma^* ⊢ q -> r$ and $Gamma^* ⊢ q -> ¬ r$, and two
      applications of MP yield $Gamma^* ⊢ r$ and $Gamma^* ⊢ ¬ r$,
      contradicting #link(<def:consistency>)[consistency].
    - *Completeness at the level of formulas.* For every $q$, exactly
      one of $q in Gamma^*$ and $¬ q in Gamma^*$ holds. If both held,
      deductive closure would give $Gamma^* ⊢ q$ and
      $Gamma^* ⊢ ¬ q$. If neither held, both $Gamma^* union {q}$ and
      $Gamma^* union {¬ q}$ are inconsistent; the former yields
      $Gamma^* ⊢ ¬ q$ by the
      #link(<thm:reductio-ad-absurdum>)[Reductio ad Absurdum], and the
      latter yields $Gamma^* ⊢ q$ by the
      #link(<thm:law-of-contradiction>)[Law of Contradiction] — again
      both $q$ and $¬ q$ are provable, a contradiction.

  + *Step 3 — truth lemma.* Define a valuation $v: A -> {0,1}$ by
    $v(a) = 1$ iff $a in Gamma^*$. We show by induction on the
    construction of $p$ that
    $
      v(p) = 1 quad "iff" quad p in Gamma^*.
    $
    - If $p in A$, this is the definition of $v$.
    - If $p = ¬ q$, then $v(¬ q) = 1$ iff $v(q) = 0$ iff
      $q in.not Gamma^*$ iff $¬ q in Gamma^*$ (by Step 2).
    - If $p = q -> r$: if $q in.not Gamma^*$, then $¬ q in Gamma^*$
      and $⊢ ¬ q -> (q -> r)$ (Principle of Explosion), so
      $q -> r in Gamma^*$; if $r in Gamma^*$, then
      $r -> (q -> r)$ is an instance of (L1), so
      $q -> r in Gamma^*$. Conversely, if $q -> r in Gamma^*$ and
      $q in Gamma^*$, then $r in Gamma^*$ by MP and deductive closure;
      hence $q -> r in Gamma^*$ implies $q in.not Gamma^*$ or
      $r in Gamma^*$. This matches the truth table of $->$.

  + *Step 4.* If $Gamma ⊬ p$, then $p in.not Gamma^*$ (deductive
    closure, as $Gamma subset.eq Gamma^*$), so $v(p) = 0$ by the truth
    lemma, while $v$ satisfies every formula of $Gamma$. Hence
    $Gamma ⊭ p$, and the contrapositive is proved.
]

= Normal Forms, Resolution and Compactness  // 范式、归结与紧致性

#note[
  Placeholder: This chapter closes the propositional layer with the
  method and meta-theoretic tools: normal forms and truth-functional
  completeness (§2.1), resolution (§2.2), propositional compactness
  (§2.3), and applications such as SAT and König's lemma (§2.4).
  It will be developed in a subsequent revision.
]

#part("First-Order Logic")  // 一阶逻辑

= Syntax of First-Order Logic  // 一阶逻辑语法

First-order logic enriches the propositional calculus of Ch 1 with
*terms* — expressions naming objects — and *quantifiers*
($forall$, $exists$), which bind variables ranging over a domain.
This chapter builds the *syntax* of the language: the well-formed
expressions and the transformations among them. Semantics is deferred
to Ch 4 and the proof system to Ch 5; the present chapter is purely
syntactic.

== Signatures, Terms, and Formulas  // 签名、项与公式

#definition(name: "Signature")[
  A *signature* $sigma$ is a pair $("Func", "Rel")$ of disjoint sets
  of symbols together with an *arity function*
  $"ar": "Func" union "Rel" -> bb(N)$. The elements of $"Func"$ are
  *function symbols* and the elements of $"Rel"$ are *relation
  symbols*; a symbol $s$ with $"ar"(s) = n$ is *n-ary*. A 0-ary function
  symbol is a *constant symbol* (or simply a *constant*). The *logical
  symbols* are the connectives $¬$ and $->$, the quantifier $forall$,
  the equality symbol $=$, parentheses, and a countably infinite set
  $"Var" = {x_0, x_1, x_2, dots}$ of *variables*; we use
  $x, y, z$ as metavariables ranging over $"Var"$.
] <def:signature>

#note[
  We adopt equality as a *logical symbol* present in every signature
  (the convention of Enderton). Accordingly $=$ needs no declaration
  in $sigma$; it is interpreted as genuine identity in every structure
  (Ch 4) and governed by the equality axioms (Ch 5). The alternative
  convention (Mendelson) treats $=$ as an ordinary binary relation
  symbol of the signature; for most purposes the two conventions are
  inter-translatable.
]

#definition(name: "Term")[
  The set $"Term"(sigma)$ of *terms* over $sigma$ is defined
  recursively:
  + Every variable $x in "Var"$ is a term.
  + Every constant symbol $c$ is a term.
  + If $t_1, dots, t_n$ are terms and $f in "Func"$ has
    $"ar"(f) = n >= 1$, then $f(t_1, dots, t_n)$ is a term.
  + Every term is obtained by finitely many applications of the rules
    above.
  A term containing no variables is a *closed term* (or *ground term*).
] <def:term>

#definition(name: "Atomic Formula")[
  An *atomic formula* over $sigma$ is an expression of one of the two
  forms:
  + $t_1 = t_2$, where $t_1, t_2 in "Term"(sigma)$;
  + $R(t_1, dots, t_n)$, where $R in "Rel"$ has $"ar"(R) = n$ and
    $t_1, dots, t_n in "Term"(sigma)$.
] <def:atomic-formula>

#definition(name: "First-Order Formula")[
  The set $"Fml"(sigma)$ of *first-order formulas* (or simply
  *formulas*) over $sigma$ is defined recursively:
  + Every atomic formula is a formula.
  + If $phi$ is a formula, then $¬ phi$ is a formula.
  + If $phi$ and $psi$ are formulas, then $(phi -> psi)$ is a
    formula.
  + If $phi$ is a formula and $x in "Var"$, then $forall x phi$ is a
    formula.
  + Every formula is obtained by finitely many applications of the
    rules above.
  The set $"Fml"(sigma)$ is the *first-order language* $L(sigma)$ of
  the signature $sigma$.
] <def:first-order-formula>

#note[
  In contrast to the prefix (Polish) notation of the propositional
  WFFs (#link(<def:wff>)[§1.2]), first-order formulas are written in
  the customary infix notation, and parentheses are omitted when no
  ambiguity arises. As in propositional logic, the connectives $∧$,
  $∨$, $↔$ are abbreviations in the sense of
  #link(<def:derived-connectives>)[Derived Connectives].
]

#definition(name: "Existential Quantifier")[
  The existential quantifier is introduced as an abbreviation: for
  every formula $phi$ and every variable $x$, the formula
  $exists x phi$ abbreviates $¬ forall x ¬ phi$.
] <def:exists-abbreviation>

The abbreviation is recorded as a numbered formula for later use:

#eq[
  $
    exists x phi := ¬ forall x ¬ phi.
  $
] <eq:exists-def>

#lemma(name: "Induction on Terms")[
  Let $P$ be a property of terms such that:
  + $P(x)$ holds for every variable $x in "Var"$;
  + $P(c)$ holds for every constant symbol $c$;
  + if $P(t_1), dots, P(t_n)$ hold and $f in "Func"$ has
    $"ar"(f) = n >= 1$, then $P(f(t_1, dots, t_n))$ holds.
  Then $P(t)$ holds for every term $t in "Term"(sigma)$.
] <lem:term-induction>

#proof[
  A term is built by finitely many applications of the formation
  rules; argue by induction on the number of applications, whose
  hypotheses are exactly the three clauses.
]

#lemma(name: "Induction on Formulas")[
  Let $P$ be a property of formulas such that:
  + $P(alpha)$ holds for every atomic formula $alpha$;
  + $P(phi)$ implies $P(¬ phi)$ for every formula $phi$;
  + $P(phi)$ and $P(psi)$ imply $P(phi -> psi)$ for all formulas
    $phi, psi$;
  + $P(phi)$ implies $P(forall x phi)$ for every formula $phi$ and
    every $x in "Var"$.
  Then $P(phi)$ holds for every formula $phi in "Fml"(sigma)$.
] <lem:formula-induction>

#proof[
  Argue as in the induction on terms, taking the length of the
  formation sequence of the formula as the induction measure.
]

#example(name: "The Language of Arithmetic")[
  The *language of arithmetic* $sigma_"ar"$ has the constant symbol
  $0$, the unary function symbol $S$ (successor), the binary function
  symbols $+$ and $dot$ (addition and multiplication), and the binary
  relation symbol $<$. Examples of terms: $0$, $S(0)$, $S(S(x))$,
  $x + S(y)$, $x dot y$. Two of the *Peano axioms* are the formulas
  $
    forall x forall y (S x = S y -> x = y)
  $
  and
  $
    forall x ¬ (S x = 0),
  $
  and the ordering of the natural numbers begins with
  $
    forall x exists y (x < y).
  $
  The language $sigma_"ar"$ is the vehicle of arithmetic throughout
  Part III (Ch 8-9).
] <ex:language-of-arithmetic>

#example(name: "The Language of Set Theory")[
  The *language of set theory* $sigma_"set"$ has no function symbols
  and the single binary relation symbol $in$ (membership). The *axiom
  of extensionality* is the formula
  $
    forall x forall y (forall z (z in x <=> z in y) -> x = y),
  $
  and the *axiom of pairing* is
  $
    forall x forall y exists z forall w (w in z <=> w = x "or" w = y).
  $
  Here $in$ is the sole non-logical symbol of the signature, while $=$
  is the logical equality symbol. The theory over this language is
  developed in the notebook *Théorie des Ensembles*.
] <ex:language-of-set-theory>

#figure(
  image("img/formula-parse-tree.svg", width: 60%),
  caption: [Parse tree of the formula
    $forall x (R(x, f(x)) -> P(y))$, exhibiting the recursive
    construction of terms and formulas.],
  placement: auto,
  supplement: [Fig.]
) <fig:formula-parse-tree>

== Free and Bound Variables; Substitution  // 自由/约束变元与代入

Quantifiers bind variables, and this binding is what makes first-order
formulas templates rather than fixed assertions. This section isolates
the two syntactic mechanisms built on binding — free and bound
occurrences, and substitution — which the semantics of Ch 4 and the
axioms of Ch 5 will consume.

#definition(name: "Free and Bound Occurrences")[
  An *occurrence* of a variable $x$ in a formula is *bound* if it lies
  within the scope of an occurrence of $forall x$, and *free*
  otherwise. The *scope* of the quantifier in $forall x phi$ is the
  formula $phi$. Formally, the set $"FV"(phi)$ of *free variables* of
  a formula $phi$ is defined recursively:
  + If $phi$ is atomic, then $"FV"(phi)$ is the set of all variables
    occurring in $phi$.
  + $"FV"(¬ phi) = "FV"(phi)$.
  + $"FV"(phi -> psi) = "FV"(phi) union "FV"(psi)$.
  + $"FV"(forall x phi) = "FV"(phi) backslash {x}$.
  A variable having a bound occurrence in $phi$ is *bound in* $phi$;
  a variable may occur both free and bound in the same formula.
] <def:free-bound-variable>

#definition(name: "Sentence")[
  A formula $phi$ with $"FV"(phi) = emptyset$ is a *sentence* (or
  *closed formula*).
] <def:sentence>

#example(name: "Free and Bound Occurrences")[
  Consider the formula
  $
    phi = forall x (R(x, y) and forall y S(x, y)).
  $
  The scope of the outer $forall x$ is $R(x, y) and forall y S(x, y)$,
  and the scope of the inner $forall y$ is $S(x, y)$. Both occurrences
  of $x$ are bound (by the outer quantifier); the occurrence of $y$ in
  $R(x, y)$ is free, while the occurrence of $y$ in $S(x, y)$ is bound
  by the inner quantifier. Hence $"FV"(phi) = {y}$, and $phi$ is not a
  sentence.
] <ex:free-bound-example>

#definition(name: "Substitution")[
  Substitution on terms is defined first: for terms $s, t$ and a
  variable $x$, the term $s[t / x]$ is obtained from $s$ by replacing
  every occurrence of $x$ by $t$. Substitution on formulas is then
  defined recursively by:
  + $(t_1 = t_2)[t / x] = (t_1[t / x] = t_2[t / x])$ and
    $R(t_1, dots, t_n)[t / x] = R(t_1[t / x], dots, t_n[t / x])$ for
    atomic formulas;
  + $(¬ phi)[t / x] = ¬ (phi[t / x])$ and
    $(phi -> psi)[t / x] = phi[t / x] -> psi[t / x]$;
  + the quantifier clause, distinguishing the quantified variable, is
    recorded in the numbered formula below.
  The formula $phi[t / x]$ reads *"$phi$ with $t$ substituted for the
  free occurrences of $x$"*.
] <def:substitution>

#eq[
  $
    (forall y phi)[t / x] = cases(
      forall y phi quad & "if" y = x,
      forall y (phi[t / x]) quad & "if" y != x,
    ).
  $
] <eq:substitution-def>

#definition(name: "Substitutable")[
  A term $t$ is *substitutable for* $x$ *in* $phi$ (or *free for*
  $x$ *in* $phi$) if no variable of $t$ is *captured* when $t$
  replaces the free occurrences of $x$: for every variable $y$
  occurring in $t$, no free occurrence of $x$ in $phi$ lies in the
  scope of a quantifier $forall y$. Otherwise $t$ is *not
  substitutable* for $x$ in $phi$.
] <def:substitutable>

#lemma(name: "Basic Properties of Substitution")[
  Let $phi in "Fml"(sigma)$, $t in "Term"(sigma)$, and
  $x in "Var"$.
  + If $x in.not "FV"(phi)$, then $phi[t / x] = phi$.
  + If $t$ is closed, then
    $"FV"(phi[t / x]) subset.eq "FV"(phi) backslash {x}$.
  + If $t$ is substitutable for $x$ in $phi$, then
    $"FV"(phi[t / x]) = ("FV"(phi) backslash {x}) union "FV"(t)$.
] <lem:substitution-basic>

#proof[
  All three clauses follow by induction on the formula $phi$
  (#link(<lem:formula-induction>)[Induction on Formulas]). For (a): if
  $x$ is not free in $phi$, the substitution rules replace nothing and
  the formula is unchanged. For (b): a closed $t$ contributes no free
  variables, so substituting can only delete the free occurrences of
  $x$. For (c): substitutability guarantees that no variable of $t$
  is captured, so every free variable of $t$ survives as a free
  variable in the result, and $x$ disappears exactly at its free
  occurrences.
]

#definition(name: "Alpha-Equivalence")[
  Two formulas $phi$ and $psi$ are *α-equivalent* (notation
  $phi ~_alpha psi$) if $psi$ is obtained from $phi$ by renaming
  bound variables: $~_alpha$ is the smallest equivalence relation on
  $"Fml"(sigma)$ generated by
  $
    forall x phi ~ forall y (phi[y / x]),
  $
  whenever $y$ does not occur in $phi$. We write $[phi]_alpha$ for
  the α-equivalence class of $phi$.
] <def:alpha-equivalent>

#proposition(name: "Alpha-Equivalence Classes")[
  Alpha-equivalence is an equivalence relation on $"Fml"(sigma)$, and
  renaming preserves free variables: if $phi ~_alpha psi$, then
  $"FV"(phi) = "FV"(psi)$. The α-classes therefore partition
  $"Fml"(sigma)$ into formulas differing only in the names of bound
  variables.
] <prop:alpha-equiv-class>

#proof[
  Reflexivity, symmetry, and transitivity hold because $~_alpha$ is
  by definition the smallest equivalence relation containing the
  renaming steps. For the single step $forall x phi ~
  forall y (phi[y / x])$ with $y in.not phi$, the variable $y$ is
  substitutable for $x$ in $phi$, so by
  #link(<lem:substitution-basic>)[substitution (c)],
  $
    "FV"(forall y (phi[y / x]))
    = "FV"(phi[y / x]) backslash {y}
    = (("FV"(phi) backslash {x}) union {y}) backslash {y}
    = "FV"(phi) backslash {x}
    = "FV"(forall x phi),
  $
  and the general case follows by induction on the number of renaming
  steps.
]

#example(name: "Capture by Substitution")[
  In the language of arithmetic, let $phi = forall y (x < y)$ and
  $t = y$. The naive computation $phi[y / x] = forall y (y < y)$ is
  forbidden: the variable $y$ of $t$ is captured by the quantifier
  $forall y$, so $t$ is not substitutable for $x$ in $phi$. The
  legitimate procedure first renames the bound variable,
  $forall y (x < y) ~ forall z (x < z)$, and then applies the
  substitution:
  $
    phi[y / x] = forall z (y < z),
  $
  with $"FV"(phi[y / x]) = {y}$.
] <ex:substitution-capture>

#caution[
  Never substitute $t$ for $x$ in $phi$ without checking
  substitutability: a captured variable changes the very formula one
  intends to form. When a conflict arises, rename the bound variables
  first (α-equivalence) so that the term becomes substitutable.
] <caution:capture>

#note[
  The mechanisms of this section — free and bound occurrences,
  substitution, and α-renaming — are exactly what the satisfaction
  relation of Ch 4 and the quantifier axioms of Ch 5 consume: the
  semantics must be well-defined on α-classes, and the axiom
  $forall x phi -> phi[t / x]$ requires $t$ to be substitutable for
  $x$ in $phi$.
]

== Prenex Normal Forms and Skolemization  // 前束范式与斯科伦化

For many purposes — resolution methods, model-theoretic arguments,
quantifier elimination — it is convenient to push all quantifiers of a
formula to the front and then eliminate the existential ones. This
section develops the two standard normal forms, the *prenex* and the
*Skolem* form, together with the effective transformations producing
them. Their correctness (logical equivalence, preservation of
satisfiability) is verified in Ch 4, once the satisfaction relation is
at hand; the algorithms themselves are purely syntactic.

#lemma(name: "Quantifier Duality")[
  For every formula $phi$ and every variable $x$,
  $
    ¬ forall x phi ↔ exists x ¬ phi, quad
    ¬ exists x phi ↔ forall x ¬ phi.
  $
  The first equivalence is the defining identity of the existential
  quantifier (#link(<def:exists-abbreviation>)[§3.1]); the second
  follows from it by double negation. As equivalences of truth values
  they are verified in Ch 4.
] <lem:quantifier-duality>

#proposition(name: "Prenex Rules")[
  Let $phi, psi$ be formulas and $x in.not "FV"(psi)$. Then the
  following logical equivalences hold — the condition on $x$ is what
  licenses pulling the quantifier past $psi$:
  $
    ¬ forall x phi ↔ exists x ¬ phi, \
    ¬ exists x phi ↔ forall x ¬ phi, \
    psi and (forall x phi) ↔ forall x (psi and phi), \
    psi or (exists x phi) ↔ exists x (psi or phi), \
    psi -> (forall x phi) ↔ forall x (psi -> phi), \
    psi -> (exists x phi) ↔ exists x (psi -> phi), \
    (forall x phi) -> psi ↔ exists x (phi -> psi), \
    (exists x phi) -> psi ↔ forall x (phi -> psi).
  $
  The dual rules obtained by interchanging $forall$ and $exists$ in
  the conjunction and disjunction clauses hold as well. Verification
  of all equivalences is deferred to Ch 4; each follows directly from
  the satisfaction clauses for the quantifiers.
] <prop:prenex-rules>

#definition(name: "Prenex Normal Form")[
  A formula is in *prenex normal form* (PNF) if it has the shape
  $
    Q_1 x_1 Q_2 x_2 dots Q_n x_n psi,
  $
  where $Q_i in {forall, exists}$ for each $i$, the variables
  $x_1, dots, x_n$ are distinct, and the *matrix* $psi$ is
  quantifier-free. The block $Q_1 x_1 dots Q_n x_n$ is the *prefix*.
] <def:prenex-form>

#theorem(name: "Prenex Normal Form Theorem")[
  Every formula is logically equivalent to a formula in prenex normal
  form, and a prenex form can be computed effectively: there is an
  algorithm that transforms any formula into a PNF.
] <thm:prenex-normal-form>

#proof[
  (The equivalence steps are justified in Ch 4.) Transform the given
  formula by induction on its construction, using
  #link(<lem:formula-induction>)[Induction on Formulas].
  + *Atomic formulas* are already in PNF (empty prefix).
  + *Negation* $¬ phi$: if $phi ~ Q_1 x_1 dots Q_n x_n psi$, apply
    the duality lemma successively to obtain
    $¬ phi ~ Q'_1 x_1 dots Q'_n x_n ¬ psi$, where $Q'_i$ is the dual
    of $Q_i$.
  + *Implication* $phi -> psi$: first α-rename the bound variables of
    the two prenex forms so that their prefixes are disjoint; then
    pull the prefix of $phi$ out of the antecedent — interchanging
    $forall$ and $exists$ by the implication rules of the prenex
    proposition — and the prefix of $psi$ out of the consequent.
  + *Quantification* $forall x phi$: by induction, α-renaming $x$ if
    it already occurs bound in the prefix.
  Each step preserves logical equivalence and terminates, since the
  measure (number of quantifiers outside the prefix) decreases along
  the induction.
]

#definition(name: "Skolem Normal Form")[
  A formula in prenex normal form is in *Skolem normal form* (SNF) if
  its prefix contains only universal quantifiers. *Skolemization* is
  the transformation that eliminates the existential quantifiers of a
  prenex formula one at a time, from the left: if the prefix is
  $forall x_1 dots forall x_k exists y Q_1 z_1 dots Q_m z_m$ and $f$
  is a fresh $k$-ary function symbol (a *Skolem function*; a fresh
  constant symbol when $k = 0$), replace every occurrence of $y$ in
  the matrix by $f (x_1, dots, x_k)$ and delete the quantifier
  $exists y$. Eliminating all existential quantifiers yields the
  *Skolem form* $phi^S$ of $phi$:
] <def:skolem-form>

#eq[
  $
    forall x_1 forall x_2 dots forall x_n psi,
    quad psi "quantifier-free",
  $
] <eq:skolem-def>

#proposition(name: "Skolemization Preserves Satisfiability")[
  Let $phi$ be a formula in prenex normal form and $phi^S$ its Skolem
  form (in the language enlarged by the fresh Skolem symbols). Then
  $phi$ is satisfiable if and only if $phi^S$ is satisfiable.
] <prop:skolem-satisfiability>

#note[
  The proof is deferred to Ch 4, where satisfaction is defined:
  (⟸) restrict any model of $phi^S$ to the original signature;
  (⟹) use the axiom of choice to select, for each eliminated
  $exists y$, a witness function interpreting the fresh Skolem
  symbol. The equivalence is one of *satisfiability only*: $phi$ and
  $phi^S$ are not logically equivalent in general, since the Skolem
  functions need not exist in every model of $phi$.
]

#example(name: "Skolemization")[
  In a signature without function symbols, let
  $phi = forall x exists y R(x, y)$. Skolemization introduces a fresh
  unary Skolem function $f$ and yields
  $
    phi^S = forall x R(x, f(x)).
  $
  Every model of $phi^S$ is a model of $phi$ (take witnesses
  $y = f^M (x)$), and conversely every model of $phi$ can be expanded
  by a choice function $f^M$ to a model of $phi^S$ (axiom of choice).
  In the language of arithmetic, $forall x exists y (x < y)$ becomes
  $forall x (x < f(x))$ after Skolemization.
] <ex:skolem-example>

#note[
  Prenex and Skolem forms are the syntactic raw material of the next
  section (Herbrand's theorem) and of the resolution-based methods of
  Ch 2 in their first-order form; quantifier elimination (Ch 7.4)
  works with prenex matrices directly.
]

== Herbrand's Theorem  // Herbrand 定理

Herbrand's theorem reduces first-order unsatisfiability to
propositional unsatisfiability over *ground instances*. It is the
capstone of the syntax chapter: the objects it builds — the Herbrand
universe and Herbrand structures — are purely syntactic, and it
closes the loop back to the propositional layer of Ch 1.

#definition(name: "Herbrand Universe")[
  Let $sigma$ be a signature containing at least one constant symbol.
  The *Herbrand universe* of $sigma$ is the set $"HU"(sigma)$ of all
  closed terms of $sigma$: the smallest set containing every constant
  symbol and closed under every function symbol. If $sigma$ has no
  constant symbols, adjoin a fresh one; this does not affect
  satisfiability (the expanded language is conservative for
  satisfiability).
] <def:herbrand-universe>

#definition(name: "Herbrand Structure")[
  A *Herbrand structure* for $sigma$ is a structure whose domain is
  the Herbrand universe $"HU"(sigma)$ and in which every term is
  interpreted as itself: each constant $c$ denotes $c$, and each
  function symbol $f$ is interpreted by the mapping
  $f^H: (t_1, dots, t_n) -> f(t_1, dots, t_n)$ on closed terms.
  A Herbrand structure is therefore completely determined by its
  interpretation of the relation symbols.
] <def:herbrand-structure>

#definition(name: "Ground Instance")[
  Let $psi$ be a quantifier-free formula whose free variables are
  among $x_1, dots, x_n$, and let $t_1, dots, t_n$ be closed terms.
  The formula $psi[t_1 / x_1, dots, t_n / x_n]$ is a *ground
  instance* of $psi$. The *Herbrand expansion* of $psi$ is the set of
  all its ground instances:
] <def:ground-instance>

#eq[
  $
    E(psi) = {psi[t_1 / x_1, dots, t_n / x_n] : t_1, dots, t_n in "HU"(sigma)}.
  $
] <eq:herbrand-expansion>

#theorem(name: "Herbrand's Theorem")[
  Let $phi = forall x_1 dots forall x_n psi$ be a sentence in Skolem
  normal form with quantifier-free matrix $psi$. Then:
  + $phi$ is satisfiable if and only if $E(psi)$ is propositionally
    satisfiable, where atomic formulas are read as propositional
    atoms;
  + $phi$ is unsatisfiable if and only if some finite subset of
    $E(psi)$ is propositionally unsatisfiable.
] <thm:herbrand>

#proof[
  *Clause (i).* ($=>$) Let $M$ be a model of $phi$. Every closed term
  $t$ has an evaluation $t^M in M$, and since $M$ satisfies
  $forall x_1 dots forall x_n psi$, each ground instance
  $psi[t_1 / x_1, dots, t_n / x_n]$ holds in $M$. The valuation of
  atomic formulas induced by $M$ (assigning to $R(t_1, dots, t_n)$
  its truth value in $M$) therefore satisfies $E(psi)$
  propositionally. ($<=$) Let $v$ be a propositional valuation
  satisfying $E(psi)$, and define a Herbrand structure $H$ by
  $R^H (t_1, dots, t_n) = v(R(t_1, dots, t_n))$ for every relation
  symbol $R$. Then $H$ satisfies every ground instance of $psi$, and
  since every element of the Herbrand universe is a closed term, the
  satisfaction clause for $forall$ (Ch 4) gives $H models phi$.
  *Clause (ii).* ($<=$) If a finite subset of $E(psi)$ is
  propositionally unsatisfiable, then $E(psi)$ has no propositional
  valuation, so by (i) $phi$ has no model. ($=>$) If $phi$ is
  unsatisfiable, (i) yields that $E(psi)$ is not propositionally
  satisfiable; the conclusion that some *finite* subset is already
  propositionally unsatisfiable is the compactness theorem for
  propositional logic — deferred to Ch 6, where clause (ii) is
  recovered as a corollary of compactness (together with the
  completeness of the propositional layer, Ch 1).
]

#example(name: "A Finite Propositional Refutation")[
  In the language with a constant $a$ and a unary function symbol $f$,
  let
  $
    phi = forall x (P(x) and ¬ P(f(x))),
  $
  so the matrix is $psi = P(x) and ¬ P(f(x))$ and the Herbrand
  universe is ${a, f(a), f(f(a)), dots}$. The first two ground
  instances are
  $
    P(a) and ¬ P(f(a)), quad P(f(a)) and ¬ P(f(f(a))).
  $
  These two formulas are propositionally unsatisfiable: the first
  forces the atom $P(f(a))$ to be true and the second forces it to be
  false. By Herbrand's theorem, $phi$ is unsatisfiable. The example
  exhibits the content of clause (ii): unsatisfiability is witnessed
  by a finite set of ground instances.
] <ex:herbrand-example>

#note[
  Herbrand's theorem is the theoretical foundation of first-order
  resolution — the extension of the propositional resolution of Ch 2 —
  and of automated theorem proving: to refute a Skolemized sentence,
  enumerate its ground instances and test propositional
  satisfiability. The finite witness property of clause (ii) is what
  makes such enumeration terminate in principle.
]

= Semantics of First-Order Logic  // 一阶逻辑语义

Ch 3 built the language; this chapter gives it meaning. The central
notion is the *satisfaction relation* of Tarski: a recursive definition
that assigns a truth value to every formula relative to a structure and
an assignment of its free variables. Everything semantic — truth,
models, logical consequence, logical equivalence, satisfiability,
theories — is derived from this single definition. The proof system of
Ch 5 is built on top of the semantic notions established here, and the
compactness theorem (Ch 6) and the model theory of Part III consume
them. This chapter also redeems the verification promises made in
Ch 3: the equality convention, the quantifier satisfaction clauses, and
the correctness of the prenex and Skolem transformations.

== Structures and Interpretations  // 结构与解释

A signature declares the non-logical vocabulary; a *structure* supplies
the objects over which variables range and the interpretation of that
vocabulary.

#definition(name: "Structure")[
  A *structure* for a signature $sigma$ is a pair $M = (|M|, I)$, where
  $|M| != emptyset$ is the *domain* (or universe) of $M$ and $I$ is an
  *interpretation* assigning:
  + to every constant symbol $c$, an element $c^M in |M|$;
  + to every $n$-ary function symbol $f$, a function
    $f^M: |M|^n -> |M|$;
  + to every $n$-ary relation symbol $R$, an $n$-ary relation
    $R^M subset.eq |M|^n$.
] <def:structure>

The domain is required to be nonempty, so that every structure has at
least one element to interpret constants by. We write $|M|$ for the
domain of $M$ and superscript the interpretations with $M$.

#definition(name: "Assignment")[
  An *assignment* in $M$ is a function $s: "Var" -> |M|$ from the set
  of variables to the domain. Given $a in |M|$ and a variable $x$, the
  *modified assignment* $s[x/a]$ is the assignment that agrees with $s$
  except at $x$, where it takes the value $a$:
  $
    s[x/a](y) = cases(
      a quad & text("if") y = x,
      s(y) quad & text("if") y != x,
    )
  $
] <def:assignment>

#definition(name: "Term Evaluation")[
  Let $M$ be a structure, $s$ an assignment, and $t$ a term. The
  *evaluation* of $t$ in $M$ under $s$ is the element
  $t^M [s] in |M|$ defined recursively on the construction of $t$
  (#link(<def:term>)[Definition 3.2]):
] <def:term-evaluation>

#eq[
  $
    x^M [s] = s(x), quad
    c^M [s] = c^M, \
    f(t_1, dots, t_n)^M [s] = f^M (t_1^M [s], dots, t_n^M [s]).
  $
] <eq:term-evaluation-def>

#note[
  In accordance with the convention of §3.1, the equality symbol $=$ is
  a logical symbol present in every signature; its interpretation is
  fixed once and for all: in every structure $M$ the formula $t_1 = t_2$
  will be declared satisfied exactly when $t_1^M [s]$ and $t_2^M [s]$ are
  the same element of $|M|$ (the satisfaction clause for $=$ in §4.2).
  This is the semantic content of the convention adopted in
  #link(<def:signature>)[Definition 3.1]. The alternative convention,
  treating $=$ as an ordinary relation symbol of the signature, is
  inter-translatable with this one.
]

#note[
  A structure for $sigma$ is also called an $L(sigma)$-structure.
  Enlarging the signature (e.g. adding Skolem symbols, §3.3) enlarges
  the class of structures; restricting a structure to a smaller
  signature forgets the interpretations of the removed symbols (the
  *reduct*), a device used throughout Part II.
]

== Satisfaction and Truth  // 满足与 Tarski 真定义

The satisfaction relation assigns a truth value to every formula
relative to a structure and an assignment. It is defined recursively on
the construction of formulas (#link(<lem:formula-induction>)[Lemma
3.2]), mirroring the recursion in the definition of the formulas
themselves (#link(<def:first-order-formula>)[Definition 3.4]).

#definition(name: "Satisfaction")[
  Let $M$ be a structure and $s$ an assignment. The *satisfaction
  relation* $M models phi[s]$ is defined recursively on the
  construction of the formula $phi$:
] <def:satisfaction>

#eq[
  $
    M models t_1 = t_2 [s] quad &"iff" quad t_1^M [s] = t_2^M [s], \
    M models R(t_1, dots, t_n)[s] quad &"iff" quad R^M (t_1^M [s], dots, t_n^M [s]), \
    M models ¬ phi[s] quad &"iff" quad M ⊭ phi[s], \
    M models (phi -> psi)[s] quad &"iff" quad M ⊭ phi[s] "or" M models psi[s], \
    M models forall x phi[s] quad &"iff" quad M models phi[s[x/a]] "for all" a in |M|.
  $
] <eq:satisfaction-def>

The first two clauses are the atomic cases: equality is interpreted as
genuine identity of evaluations (the convention of
#link(<def:signature>)[Definition 3.1]), and a relation symbol holds of
the tuple exactly when the tuple of evaluations lies in the relation.
The quantifier clause quantifies over the domain: $forall x phi$ holds
under $s$ precisely when $phi$ holds under every modification of $s$ at
$x$. The remaining connectives $and$, $or$, $<=>$ and the existential
quantifier are handled through their definitions as abbreviations
(#link(<def:derived-connectives>)[§1.1],
#link(<def:exists-abbreviation>)[§3.1]).

#definition(name: "Model")[
  A sentence $phi$ is *true* in $M$ — written $M models phi$ — if
  $M models phi[s]$ for some (and hence every, by the Coincidence
  Lemma below) assignment $s$. A structure $M$ is a *model* of a set
  $Gamma$ of sentences, written $M models Gamma$, if $M models phi$
  for every $phi in Gamma$.
] <def:model>

#proposition(name: "Quantifier Satisfaction")[
  For every formula $phi$, every variable $x$, every structure $M$,
  and every assignment $s$:
  $
    M models forall x phi[s] quad &"iff" quad M models phi[s[x/a]] "for all" a in |M|, \
    M models exists x phi[s] quad &"iff" quad M models phi[s[x/a]] "for some" a in |M|.
  $
  The first clause is the satisfaction clause for $forall$; the second
  is its consequence via the abbreviation
  $exists x phi := ¬ forall x ¬ phi$
  (#link(<def:exists-abbreviation>)[§3.1]).
] <prop:quantifier-satisfaction>

#proof[
  Only the existential clause needs a proof. By the abbreviation and
  the clauses for $¬$ and $forall$:
  $M models exists x phi[s]$ iff $M ⊭ forall x ¬ phi[s]$ iff it
  is not the case that for all $a in |M|$, $M models ¬ phi[s[x/a]]$ iff
  there is $a in |M|$ with $M ⊭ ¬ phi[s[x/a]]$ iff there is
  $a in |M|$ with $M models phi[s[x/a]]$.
]

This clause is the one invoked in the proof of Herbrand's theorem
(§3.4): the satisfaction of a universal sentence over the Herbrand
universe reduces to the satisfaction of all its ground instances.

#lemma(name: "Coincidence Lemma")[
  Let $M$ be a structure.
  + If assignments $s$ and $s'$ agree on the variables of a term $t$,
    then $t^M [s] = t^M [s']$.
  + If assignments $s$ and $s'$ agree on $"FV"(phi)$ for a formula
    $phi$, then $M models phi[s]$ iff $M models phi[s']$.
] <lem:coincidence>

#proof[
  Both claims are proved by induction, on terms and on formulas
  respectively. The term clauses are immediate from the recursion of
  #link(<eq:term-evaluation-def>)[term evaluation]; the atomic formula
  clauses follow from the term claim, and the clauses for $¬$ and $->$
  use the induction hypothesis directly. For the quantifier clause:
  if $s$ and $s'$ agree on $"FV"(forall x phi) = "FV"(phi) ∖ {x}$,
  then $s[x/a]$ and $s'[x/a]$ agree on $"FV"(phi)$ for every
  $a in |M|$, so by the induction hypothesis $M models phi[s[x/a]]$
  iff $M models phi[s'[x/a]]$ for all $a$; hence
  $M models forall x phi[s]$ iff $M models forall x phi[s']$.
]

#lemma(name: "Satisfaction Respects Substitution")[
  Let $t$ be a term and $x$ a variable, with $t$ substitutable for $x$
  in the formulas involved (#link(<def:substitutable>)[§3.2]). For
  every term $u$, every structure $M$, and every assignment $s$,
  $
    (u[t/x])^M [s] = u^M [s[x/t^M [s]]],
  $
  and for every formula $phi$,
  $
    M models phi[t/x][s] quad "iff" quad M models phi[s[x/t^M [s]]].
  $
] <lem:satisfaction-substitution>

#proof[
  The term claim follows by induction on $u$ from the recursion of
  #link(<eq:term-evaluation-def>)[term evaluation]. The formula claim
  is proved by induction on $phi$; the quantifier clause is the point
  where substitutability is used: for $phi = forall y psi$ with
  $y != x$ and $y in.not "FV"(t)$, the assignments $s[y/a]$ and
  $s[x/t^M [s]][y/a]$ agree with the induction hypothesis for $psi$,
  and the substitution $phi[t/x] = forall y psi[t/x]$ is evaluated
  under $s$ by quantifying over $a in |M|$ at $y$.
]

#proposition(name: "α-Equivalence Preserves Satisfaction")[
  If $phi$ and $psi$ are α-equivalent
  (#link(<def:alpha-equivalent>)[§3.2]), then for every structure $M$
  and every assignment $s$: $M models phi[s]$ iff $M models psi[s]$.
  In particular, satisfaction is well-defined on α-classes of formulas
  — the requirement anticipated in the note closing §3.2.
] <prop:alpha-invariance>

#proof[
  α-equivalence is generated by renaming a bound variable to a fresh
  one; each renaming step is a substitution of a fresh variable for the
  bound one, which is trivially substitutable and preserves
  satisfaction by
  #link(<lem:satisfaction-substitution>)[the Substitution Lemma]. The
  claim follows by induction on the number of renaming steps, using
  the α-class structure of
  #link(<prop:alpha-equiv-class>)[§3.2].
]

#example(name: "The Standard Model of Arithmetic")[
  Let $sigma_"ar"$ be the language of arithmetic
  (#link(<ex:language-of-arithmetic>)[Example 3.1]) and $bb(N)$ the
  structure with domain $bb(N)$, $0^M = 0$, $S^M (n) = n + 1$, $+^M$
  and $dot^M$ the usual addition and multiplication, and $<^M$ the
  usual ordering. The two Peano axioms of Example 3.1 are true in
  $bb(N)$: $bb(N) models forall x forall y (S x = S y -> x = y)$ (the
  successor map is injective on $bb(N)$) and
  $bb(N) models forall x (¬ S x = 0)$ ($0$ is not a successor). These
  verifications are purely semantic — they inspect the domain without
  any proof system. Ch 9 returns to this structure and shows that no
  finite set of first-order axioms characterizes it uniquely
  (non-standard models).
] <ex:model-arithmetic>

== Semantic Consequence, Equivalence and Normal Form Correctness  // 逻辑后承、等价与范式正确性

The satisfaction relation yields the semantic relations between
formulas — logical consequence and logical equivalence — and the
semantic classification of formulas and sets of sentences. This section
also redeems the deferred verifications of §3.3: the quantifier duality,
the prenex rules, and the satisfiability-preservation of Skolemization
are now proved from the satisfaction clauses.

#definition(name: "Logical Consequence")[
  Let $Gamma$ be a set of formulas and $phi$ a formula. $phi$ is a
  *logical consequence* of $Gamma$, written $Gamma models phi$, if for
  every structure $M$ and every assignment $s$: whenever
  $M models psi[s]$ for every $psi in Gamma$, also $M models phi[s]$.
  For a singleton ${psi}$ we write $psi models phi$. If the
  consequence holds for every structure and assignment, we say the
  implication is *valid*.
] <def:logical-consequence>

This is the first-order analogue of the propositional notion
(#link(<def:tautology>)[§1.8]): where Ch 1 quantified over truth-value
valuations, we now quantify over structures and assignments.

#definition(name: "Logical Equivalence")[
  Formulas $phi$ and $psi$ are *logically equivalent*, written
  $phi equiv psi$, if $phi models psi$ and $psi models phi$;
  equivalently, $M models phi[s]$ iff $M models psi[s]$ for every
  structure $M$ and every assignment $s$.
] <def:logical-equivalence>

#definition(name: "Theory")[
  A *theory* is a set of sentences. A *model* of a theory $Gamma$ is a
  structure $M$ with $M models Gamma$; the class of models is
  $"Mod"(Gamma) = {M : M models Gamma}$. A theory is *consistent* if it
  has a model, *complete* if for every sentence $phi$ exactly one of
  $phi$, $¬ phi$ follows from it — these notions are revisited with the
  proof system (Ch 5) and the compactness theorem (Ch 6).
] <def:theory>

#proposition(name: "Prenex and Duality Rules Verified")[
  Let $phi, psi$ be formulas with $x in.not "FV"(psi)$. Then the
  duality identities and the eight prenex rules of §3.3 hold as logical
  equivalences; in particular, by
  #link(<thm:prenex-normal-form>)[the Prenex Normal Form Theorem of
  §3.3], every formula is logically equivalent to a formula in prenex
  normal form.
] <prop:prenex-correctness>

#proof[
  This proves the equivalences whose verification was deferred in §3.3.
  Each rule is verified directly from the satisfaction clauses of
  #link(<eq:satisfaction-def>)[§4.2]; the condition $x in.not "FV"(psi)$
  enters through the Coincidence Lemma. As a representative case
  consider the conjunction rule:
  $M models (forall x phi) and psi[s]$ iff $M models forall x phi[s]$
  and $M models psi[s]$ iff for all $a in |M|$, $M models phi[s[x/a]]$
  and $M models psi[s]$ — and since $psi$ does not depend on the value
  at $x$ (coincidence), the last conjunction is
  $M models (phi and psi)[s[x/a]]$ for all $a in |M|$ — iff
  $M models forall x (phi and psi)[s]$. The remaining rules are
  checked identically; the implication rules use
  $phi -> psi equiv ¬ phi or psi$
  (#link(<def:implication>)[Definition 1.4]) together with the duality
  identities.
]

#proposition(name: "Skolemization Preserves Satisfiability: Proof")[
  Let $phi$ be a formula in prenex normal form and $phi^S$ its Skolem
  form (in the language enlarged by the fresh Skolem symbols). Then
  $phi$ is satisfiable if and only if $phi^S$ is satisfiable.
] <prop:skolem-correctness>

#proof[
  This completes the proof deferred in §3.3. ($<=$) Any model of
  $phi^S$ is a model of $phi$: the fresh Skolem symbols occur only in
  the Skolem functions, and a model of $phi^S$ satisfies, for each
  eliminated quantifier $exists y$, the matrix with the Skolem term in
  place of $y$, so the existential quantifier is witnessed and the
  original prenex formula holds. ($=>$) Let $M$ be a model of $phi$
  and process the eliminated existential quantifiers from the left.
  For a quantifier $forall x_1 dots forall x_k exists y$ with matrix
  $psi$, the axiom of choice selects, for every tuple
  $(a_1, dots, a_k) in |M|^k$, an element $b in |M|$ such that
  $M models psi[s[x_1 / a_1] dots [x_k / a_k][y / b]]$ — such a $b$
  exists because $M models phi$. Interpreting the fresh $k$-ary Skolem
  function $f$ by $f^M (a_1, dots, a_k) = b$ and expanding $M$ with all
  the chosen functions yields a model of $phi^S$.
]

#example(name: "Consequence in Action")[
  In a signature with a constant $c$ and a unary relation symbol $R$,
  the universal sentence implies its instances:
  $forall x R(x) models R(c)$, since $c^M in |M|$ is an element of the
  domain over which the universal quantifier ranges. As an illustration
  that quantifier order cannot be reversed, take a structure with
  domain $bb(N)$ and $R^M$ the relation $<=$: then
  $bb(N) models forall x exists y R(x, y)$ but
  $bb(N) ⊭ exists y forall x R(x, y)$ (no natural number is
  <= all others), so $forall x exists y R(x, y) ⊭ exists y forall x R(x, y)$.
] <ex:consequence-example>

== Elementary Equivalence  // 初等等价

Two structures for the same signature may be quite different as sets
and yet agree on every first-order sentence. The relation capturing
"indistinguishable by the first-order language" is elementary
equivalence — the first notion of model theory proper. This section
introduces it; its systematic study (elementary embeddings, the
Tarski–Vaught test) belongs to Ch 7.

#definition(name: "Elementary Equivalence")[
  Structures $M$ and $N$ for the same signature $sigma$ are
  *elementarily equivalent*, written $M equiv N$, if for every
  sentence $phi$: $M models phi$ iff $N models phi$.
] <def:elementary-equivalence>

The symbol $equiv$ is shared with logical equivalence of formulas
(§4.3); the context — structures or formulas — disambiguates the two
notions. Elementary equivalence is an equivalence relation on the class
of $sigma$-structures, by construction.

#proposition(name: "Isomorphic Structures are Elementarily Equivalent")[
  If $M$ and $N$ are isomorphic — there is a bijection
  $h: |M| -> |N|$ preserving constants, functions, and relations, so
  that $h (c^M) = c^N$, $h (f^M (a_1, dots, a_n)) =
  f^N (h(a_1), dots, h(a_n))$, and
  $R^M (a_1, dots, a_n)$ iff $R^N (h(a_1), dots, h(a_n))$ — then
  $M equiv N$.
] <prop:isomorphism-elementary>

#proof[
  By induction on formulas: for every isomorphism $h: M -> N$, every
  assignment $s$ in $M$, and every formula $phi$,
  $M models phi[s]$ iff $N models phi[h compose s]$, where
  $h compose s$ is the assignment $v mapsto h(s(v))$. The term claim
  $h (t^M [s]) = t^N [h compose s]$ is an induction on terms; the atomic
  clauses then follow from the preservation of relations and equality;
  the clauses for $¬$ and $->$ are immediate; and the quantifier clause
  uses that $h$ is a bijection, so quantification over $a in |M|$ and
  over $h(a) in |N|$ coincide. For sentences the claim reads
  $M models phi$ iff $N models phi$, i.e. $M equiv N$.
]

#example(name: "Elementary Equivalence")[
  For *finite* structures the converse holds: two finite structures
  are elementarily equivalent if and only if they are isomorphic.
  Indeed, one can write down a single sentence describing the
  isomorphism type of a finite structure (an existential sentence
  listing the elements up to equality and the truth values of all
  atomic formulas), which is satisfied exactly by its isomorphic
  copies. As a non-finite example, the dense linear orders
  $(bb(Q), <)$ and $(bb(R), <)$ are elementarily equivalent: both
  satisfy the theory of dense linear orders without endpoints, whose
  completeness is established in Ch 7.
] <ex:elementary-equivalence-example>

#note[
  Elementary equivalence is the entry point of Ch 7: elementary
  embeddings refine the notion (they preserve all formulas, not only
  sentences), the Tarski–Vaught test characterizes when a substructure
  is elementary, and the completeness of DLO proved there makes the
  example above rigorous.
]

= Proof Theory and Completeness // 证明论与完全性

Ch 3 built the language and Ch 4 gave it meaning; this chapter builds a
*proof system* on top of the syntax and proves that the two notions of
consequence coincide: the semantic $models$ of Ch 4 and the syntactic
$tack$ defined here. The climax is the Henkin completeness theorem, the
central theorem of the book: a set of sentences is consistent exactly
when it has a model. Everything downstream — compactness (Ch 6), the
model theory of Part III, the undecidability of first-order logic
(Ch 8) — rests on this identification.

== The Hilbert System for First-Order Logic // 一阶 Hilbert 系统

The proof system is the axiomatic one of Ch 1, lifted to first-order
logic: logical axiom schemata plus the rules of inference. The
propositional fragment of Ch 1 is reused verbatim, and two new axiom
schemata govern the quantifier and the equality symbol. The equality
axiom is the proof-theoretic content of the convention of §3.1
(promised at L645).

#definition(name: "Logical Axioms of First-Order Logic")[
  The *logical axioms* of first-order logic consist of three groups.
  (A1) *Propositional tautologies*: every instance of a tautology of
  propositional logic, i.e. every formula of the form of a tautology of
  §1.8 with propositional variables replaced by first-order formulas.
  (A2) *Universal instantiation*: for every formula $phi$, every
  variable $x$, and every term $t$ substitutable for $x$ in $phi$,
  $forall x phi -> phi[t/x]$.
  (A3) *Equality axioms*: for all variables $x$, $y$,
  $forall x (x = x)$, and
  $forall x forall y (x = y -> (phi -> phi'))$,
  where $phi'$ results from $phi$ by replacing some free occurrences of
  $x$ by $y$.
] <def:fol-axioms>

#definition(name: "Generalization")[
  The rule of *generalization* (Gen) allows deriving $forall x phi$
  from $phi$, provided that the variable $x$ does not occur free in any
  premise of the derivation in which $phi$ occurs.
] <def:generalization>

#definition(name: "Derivation in First-Order Logic")[
  A *derivation* of $phi$ from $Gamma$ — written $Gamma tack phi$ — is
  a finite sequence of formulas ending in $phi$, each of which is either
  a logical axiom (Definition 5.1), a formula of $Gamma$, or obtained
  from earlier formulas by Modus Ponens (Definition 1.3) or by
  Generalization (Definition 5.2). As in §1.4, $tack phi$ abbreviates
  $emptyset tack phi$; a *theorem* is a formula derivable from
  $emptyset$. The formulas of $Gamma$ are the *premises* (or *hypotheses*)
  of the derivation.
] <def:fol-derivation>

#example(name: "First Derivations")[
  The axiom (A2) with $phi = R(x, x)$ and $t = c$ yields
  $tack forall x R(x, x) -> R(c, c)$, an instance of universal
  instantiation. To see Generalization at work: the formula
  $R(x, x) -> (S(x) -> R(x, x))$ is an instance of the propositional
  tautology $p -> (q -> p)$ of (A1). Since this derivation has no
  premises, $x$ is not free in any premise, and Generalization yields
  $tack forall x (R(x, x) -> (S(x) -> R(x, x)))$.
] <ex:fol-proof-example>

#note[
  The equality axioms (A3) are the proof-theoretic counterpart of the
  convention of §3.1 that $=$ is a logical symbol interpreted as genuine
  identity (§4.2); they redeem the promise made at L645. The
  existential quantifier is not primitive: a formula $exists x phi$
  abbreviates $not forall x not phi$ (§3.1), so existential reasoning in
  derivations flows through the negation and the axiom (A2). The
  deduction theorem of §5.2 will hinge on the restriction built into
  Generalization.
]

== The Deduction Theorem for First-Order Logic // 一阶演绎定理

The deduction theorem of Ch 1 carries over to first-order logic with
one qualification: Generalization can export a variable that is free in
the discharged hypothesis. The classical formulation restricts exactly
that step.

#theorem(name: "Deduction Theorem for First-Order Logic")[
  If $Gamma, phi tack psi$ and no application of Generalization in the
  derivation quantifies a variable free in $phi$, then
  $Gamma tack phi -> psi$.
] <thm:deduction-theorem-fol>

#proof[
  As in §1.5, induct on the length of the derivation of $psi$ from
  $Gamma union {phi}$. The cases where $psi$ is a logical axiom, a
  formula of $Gamma$, or the hypothesis $phi$ itself are as before
  (the last uses the tautology $phi -> phi$). The case of Modus Ponens
  uses the propositional tautology
  $(chi -> psi) -> ((phi -> chi) -> (phi -> psi))$. The new case is
  Generalization: $psi = forall x chi$ is obtained from $chi$ by Gen,
  and by hypothesis $x$ is not free in $phi$. By the induction
  hypothesis $Gamma tack phi -> chi$. The scheme
  $forall x (phi -> chi) -> (phi -> forall x chi)$, valid when $x$ is
  not free in $phi$, is derivable from (A1)–(A2): universally
  instantiate (A2) to pass $phi -> chi$ under $forall x$, then use the
  tautologies to rearrange, and discharge with Gen. Applying Gen to
  $phi -> chi$ (allowed, since $x$ is not free in any premise of the
  subderivation and not free in $phi$) and then Modus Ponens with this
  scheme yields $Gamma tack phi -> forall x chi$.
]

The qualification cannot be dropped: with $x$ free in $phi$,
$phi -> forall x phi$ is not a logical consequence of $phi$'s being
derivable. Semantically, in a structure $M$ with two elements and a
unary relation $R$ holding of exactly one element, the assignment
$s(x) = a$ with $not R(a)$ satisfies $R(x)$ but not $forall x R(x)$,
so $M ⊭ R(x) -> forall x R(x)$ under $s$ (Ch 4). Any system proving
$R(x) -> forall x R(x)$ would therefore be unsound.

#caution[
  The restriction "no Gen quantifies a variable free in the discharged
  hypothesis" is the *only* obstacle: without it the deduction theorem
  fails, and with it the theorem holds for arbitrary premises
  $Gamma$. This is precisely the condition recorded in
  #link(<def:generalization>)[Generalization (Definition 5.2)].
] <caution:gen-restriction>

#note[
  All derived rules of propositional logic — Hypothetical Syllogism,
  Reductio ad Absurdum, Negation Reversal (§1.5) — remain valid inside
  first-order derivations, since they are proved from tautologies and
  Modus Ponens only. The deduction theorem makes them available under
  hypotheses as well, subject to the Gen restriction above.
]

== Soundness // 可靠性

Soundness asserts that the proof system proves no falsehood: whatever
is derivable is a genuine logical consequence. The proof checks each
axiom schema against the satisfaction relation of Ch 4 and each rule
against validity.

#theorem(name: "Soundness of First-Order Logic")[
  If $Gamma tack phi$, then $Gamma models phi$.
] <thm:soundness-fol>

#proof[
  Induct on the length of the derivation; it suffices to verify the
  axioms and the two rules. (A1) An instance of a propositional
  tautology is satisfied by every structure under every assignment:
  substituting first-order formulas for propositional variables in a
  tautology preserves truth under any truth assignment induced by
  satisfaction. (A2) Fix $M$ and $s$; assume $M models forall x phi[s]$.
  By the satisfaction clause for $forall x$ (Definition 4.4),
  $M models phi[s[x/a]]$ for every $a in |M|$, in particular for
  $a = t^M [s]$. The Substitution Lemma
  (#link(<lem:satisfaction-substitution>)[Ch 4]) — applicable because
  $t$ is substitutable for $x$ in $phi$ — yields
  $M models phi[t/x][s]$, hence $M models (forall x phi -> phi[t/x])[s]$.
  (A3) The clause $forall x (x = x)$ is immediate from the equality
  clause of satisfaction. For $x = y -> (phi -> phi')$: if
  $M models x = y[s]$, then $s(x) = s(y)$, and the Substitution Lemma
  again gives $M models phi[s]$ iff $M models phi'[s]$, so the
  implication holds. Rules: Modus Ponens preserves truth by the clause
  for $->$. For Generalization, assume $x$ is not free in any premise
  of the derivation and $M models phi[s]$ follows from $Gamma models phi$
  for every $M, s$. Then $M models forall x phi[s]$ by the quantifier
  clause, since modifying $s$ at $x$ changes nothing that $phi$ reads.
]

The dual formulation — consistency is a semantic notion in disguise —
is the stepping stone to completeness:

#lemma(name: "Consistency Implies Satisfiability")[
  If $Gamma$ is a consistent set of sentences in a countable signature,
  then $Gamma$ is satisfiable.
] <lem:consistency-satisfiable>

The proof is the Henkin construction of §5.4: extend $Gamma$ to a
maximal consistent set with witnesses, form the term model, and verify
that it satisfies $Gamma$. The lemma is stated here to mark the pivot:
soundness says "derivable implies valid", this lemma says "not
derivable-consistent implies has a model", and the two meet in the
completeness theorem.

#note[
  Soundness has a practical reading: any $Gamma$ with a model cannot
  be inconsistent, and any formula $phi$ with $Gamma tack phi$ is true
  in every model of $Gamma$ (#link(<def:model>)[Definition 4.5]). The
  semantic notions of Ch 4 — consequence, equivalence, theory — are
  therefore the yardstick against which the proof system is measured;
  the converse direction is the content of §5.4.
]

== Henkin Completeness // Henkin 完全性

The completeness theorem closes the loop: everything semantically
entailed is syntactically derivable. The proof, due to Henkin, is
constructive in a strong sense — it *builds* a model out of the syntax
of a consistent theory. The figure below sketches the four stages.

#figure(
  image("img/henkin-flow.svg", width: 85%),
  caption: [
    The Henkin construction: extend to a maximal consistent set with
    witnesses, form the term model, verify truth, and conclude.
  ],
  placement: auto,
  supplement: [Fig.]
) <fig:henkin-flow>

We work with a countable signature (a countably infinite set of
sentences can then be enumerated); the uncountable case follows the
same pattern with transfinite iteration, which we do not need.

#lemma(name: "Lindenbaum's Lemma")[
  Every consistent set $Gamma$ of sentences extends to a *maximal
  consistent* set $Gamma^+$: $Gamma subset Gamma^+$, $Gamma^+$ is
  consistent, and for every sentence $phi$ exactly one of $phi$ and
  $not phi$ belongs to $Gamma^+$.
] <lem:lindenbaum>

#proof[
  Enumerate all sentences of the language: $phi_0, phi_1, phi_2, dots$.
  Define $Gamma_0 = Gamma$ and, given $Gamma_n$, let
  $Gamma_(n+1) = Gamma_n union {phi_n}$ if this set is consistent, and
  $Gamma_(n+1) = Gamma_n$ otherwise. Let
  $Gamma^+ = union_(n in bb(N)) Gamma_n$. Consistency of $Gamma^+$
  follows by compactness of finite subderivations: a contradiction from
  $Gamma^+$ would use finitely many formulas, all already present in
  some $Gamma_n$. Maximality: if $phi_n$ were added, it was consistent
  to do so; if not, $Gamma_n union {phi_n}$ was inconsistent, so
  $Gamma_n tack not phi_n$ by the propositional metatheorem of §1.6,
  and $not phi_n in Gamma^+$ by a further closure argument. Hence for
  every $n$ exactly one of $phi_n, not phi_n$ is in $Gamma^+$. Moreover
  $Gamma^+$ is *deductively closed*: if $Gamma^+ tack psi$, then
  $psi in Gamma^+$ — otherwise $Gamma^+ union {psi}$ would be
  consistent, contradicting maximality.
]

#lemma(name: "Henkin Expansion")[
  Let $Gamma^+$ be a maximal consistent set. Adding to the language a
  countable set of new constant symbols, one witness constant $c$ for
  each formula of the form $exists x phi$, and adding every sentence
  $exists x phi -> phi[c/x]$, yields a maximal consistent set
  $Gamma^*$ with the *witness property*: if $exists x phi in Gamma^*$,
  then $phi[c/x] in Gamma^*$ for the witness constant $c$ of
  $exists x phi$.
] <lem:henkin-expansion>

#proof[
  Add the witnesses one at a time and show each addition preserves
  consistency. Suppose $Gamma$ is consistent, $exists x phi$ is a
  sentence, $c$ is a new constant, and
  $Gamma union {exists x phi -> phi[c/x]}$ were inconsistent. Then
  $Gamma tack not (exists x phi -> phi[c/x])$, i.e.
  $Gamma tack exists x phi$ and $Gamma tack not phi[c/x]$ (tautology
  rearrangement). Since $c$ occurs nowhere in $Gamma$ or in $phi$, the
  derivation of $not phi[c/x]$ can be generalized: replacing $c$ by a
  variable $y$ not occurring anywhere in the derivation shows
  $Gamma tack forall y not phi[y/x]$, whence $Gamma tack not exists x phi$,
  contradicting consistency. Repeating countably many times keeps the
  whole process consistent, and maximality is preserved since the added
  sentences are forced by $Gamma^+$.
]

#definition(name: "Term Model")[
  Let $Gamma^*$ be a maximal consistent set with the witness property.
  The *term model* $M$ of $Gamma^*$ is the structure whose domain is the
  set of equivalence classes of closed terms under the relation
  $t approx u$ iff $(t = u) in Gamma^*$; constants and function symbols
  act on classes by $c^M = [c]$ and
  $f^M ([t_1], dots, [t_n]) = [f(t_1, dots, t_n)]$; and
  $R^M ([t_1], dots, [t_n])$ holds iff $R(t_1, dots, t_n) in Gamma^*$.
] <def:term-model>

The relation $approx$ is well behaved: the equality axiom
$forall x (x = x)$ and the replacement scheme (A3) make $approx$
reflexive, symmetric, and transitive, and make the definitions of
$f^M$ and $R^M$ independent of the chosen representatives — two classes
agreeing on $=$ satisfy the same atomic formulas by the substitution
part of (A3).

#lemma(name: "Truth Lemma")[
  Let $M$ be the term model of $Gamma^*$. For every closed term $t$ and
  every sentence $phi$:
  $t^M = [t]$, and $M models phi$ iff $phi in Gamma^*$.
] <lem:truth-lemma>

#proof[
  The term claim is an induction on closed terms. For sentences,
  induct on the construction of $phi$. Atomic: $M models t_1 = t_2$
  iff $[t_1] = [t_2]$ iff $(t_1 = t_2) in Gamma^*$; and
  $M models R(t_1, dots, t_n)$ iff
  $R^M ([t_1], dots, [t_n])$ iff $R(t_1, dots, t_n) in Gamma^*$.
  The clauses for $¬$ and $->$ use maximal consistency. For
  $forall x phi(x)$, first relativize to closed instances: by induction
  $M models forall x phi(x)$ iff $M models phi(t)$ for every closed
  term $t$ (the domain consists of classes of closed terms), iff
  $phi(t) in Gamma^*$ for every closed $t$. If
  $forall x phi(x) in Gamma^*$, then each $phi(t) in Gamma^*$ by (A2)
  and deductive closure. Conversely, if every $phi(t) in Gamma^*$ but
  $forall x phi(x) in.not Gamma^*$, then
  $exists x not phi(x) in Gamma^*$ by maximality; the witness property
  gives a constant $c$ with $not phi[c/x] in Gamma^*$, contradicting
  $phi(c) in Gamma^*$. Hence $M models forall x phi(x)$ iff
  $forall x phi(x) in Gamma^*$.
]

#theorem(name: "Henkin Completeness Theorem")[
  Every consistent set $Gamma$ of sentences in a countable signature
  has a model.
] <thm:henkin-completeness>

#proof[
  Extend $Gamma$ to a maximal consistent $Gamma^+$
  (#link(<lem:lindenbaum>)[Lindenbaum]), then to
  $Gamma^*$ with witnesses (#link(<lem:henkin-expansion>)[Henkin
  Expansion]). The term model $M$ of $Gamma^*$
  (#link(<def:term-model>)[Definition 5.4]) satisfies every sentence of
  $Gamma^*$ by the #link(<lem:truth-lemma>)[Truth Lemma]; since
  $Gamma subset Gamma^+ subset Gamma^*$, $M models Gamma$.
]

#corollary(name: "Completeness in Consequence Form")[
  If $Gamma models phi$ for a countable signature, then
  $Gamma tack phi$.
] <cor:completeness-form>

#proof[
  Suppose $Gamma tack phi$ fails. Then $Gamma union {not phi}$ is
  consistent (otherwise $Gamma tack phi$ by Reductio ad Absurdum and
  the deduction theorem), so by the Henkin theorem it has a model $M$
  with $M models Gamma$ and $M ⊭ phi$, contradicting
  $Gamma models phi$.
]

#corollary(name: "Countable Model Existence")[
  Every satisfiable countable theory has a countable model.
] <cor:model-existence>

The term model of a countable theory is countable: its domain is made of
countably many closed terms modulo $approx$. This is the downward
Löwenheim–Skolem phenomenon, to be studied in Ch 6.

#example(name: "A Term Model in Miniature")[
  Let $Gamma = {exists x R(x)}$ with $R$ a unary relation symbol and no
  other symbols. Lindenbaum completes $Gamma$, and Henkin expansion adds
  a witness constant $c$ with $exists x R(x) -> R(c) in Gamma^*$. The
  only closed terms are $c$ (and, if present, the original constants),
  so the domain of the term model is the single class $[c]$ (modulo
  equality with any original constant it is forced to equal).
  $R^M ([c])$ holds iff $R(c) in Gamma^*$, which the witness property
  guarantees: $M models exists x R(x)$. The construction realizes the
  existential witness as an element of the model — the essence of the
  Henkin method.
] <ex:henkin-model>

#note[
  Henkin completeness is the engine of the rest of the book. Compactness
  and the Löwenheim–Skolem theorems are direct corollaries (Ch 6); the
  theory of complete theories and categoricity, and the completeness of
  DLO, are developed in Ch 7; and the undecidability of first-order
  logic (Ch 8) combines completeness with computability. Together with
  Soundness (§5.3), it closes the loop $Gamma models phi$ iff
  $Gamma tack phi$ — the syntactic and the semantic notions of
  consequence coincide.
]

= Compactness and Löwenheim–Skolem // 紧致性与 Löwenheim–Skolem

Ch 5 closed the loop between syntax and semantics; this chapter harvests
the two direct corollaries of Henkin completeness and puts them to
work. The compactness theorem says that satisfiability is a finitary
property; the Löwenheim–Skolem theorems say that the cardinality of
models can be controlled. Together they are the workhorse of model
theory: they produce nonstandard models, refute axiomatizability, and
delimit what first-order logic can define. This chapter closes Part II.

== The Compactness Theorem // 紧致性定理

#theorem(name: "Compactness Theorem")[
  A set $Gamma$ of sentences has a model if and only if every finite
  subset of $Gamma$ has a model.
] <thm:compactness>

#proof[
  The forward direction is immediate. Conversely, suppose $Gamma$ has
  no model. Then $Gamma models bot$ (vacuously, by
  #link(<def:logical-consequence>)[Definition 4.6]), so by
  #link(<cor:completeness-form>)[completeness in consequence form]
  $Gamma tack bot$. A derivation of a contradiction uses only
  finitely many formulas of $Gamma$, say $Gamma_0$; hence
  $Gamma_0 tack bot$ and, by
  #link(<thm:soundness-fol>)[soundness], $Gamma_0$ has no model — a
  finite subset of $Gamma$ without a model. Contrapositively, if every
  finite subset has a model, so does $Gamma$.
]

#corollary(name: "Compactness in Consequence Form")[
  If $Gamma models phi$, then $Gamma_0 models phi$ for some finite
  $Gamma_0 subset Gamma$.
] <cor:compactness-consequence>

#proof[
  Otherwise every finite $Gamma_0 subset Gamma$ would have a model of
  $not phi$, so by compactness $Gamma union {not phi}$ would have a
  model, contradicting $Gamma models phi$.
]

The compactness theorem redeems the deferred direction of Herbrand's
theorem (promised at L1159). Recall from §3.4 that the Herbrand
expansion of a Skolemized sentence $sigma$ is the set of all ground
instances of its matrix, and that $sigma$ is satisfiable iff some
Herbrand structure satisfies the expansion
(#link(<eq:herbrand-expansion>)[Equation 3.5]). Clause (ii), proved
there only in the direction "finite unsatisfiability implies
unsatisfiability", now follows by compactness: if $sigma$ were
unsatisfiable, no finite subset of the expansion would be satisfiable
in a Herbrand structure (by the finite-direction argument of §3.4),
hence no finite subset would be satisfiable at all, and compactness
forces the full expansion to be unsatisfiable — the direct statement of
clause (ii). The finite direction of Herbrand's theorem is thus closed.

#note[
  Compactness is a topological phenomenon in disguise: the set of
  complete theories in a countable signature forms a compact Stone
  space, and the theorem is its compactness. The propositional analogue
  was announced in Ch 2 (§2.3); the first-order theorem, via
  completeness, is its infinitary counterpart. It fails for second-order
  logic with standard semantics (Ch 10) — a first sign that full
  second-order logic outruns finitary provability.
]

== The Löwenheim–Skolem Theorems // Löwenheim–Skolem 定理

Compactness controls *existence* of models; the Löwenheim–Skolem
theorems control their *cardinalities*. A theory that has a model at
all has models of every cardinality within a wide range — a stark
contrast with, say, the theory of finite fields. The cardinality
spectrum is sketched in Figure 6.1.

#figure(
  image("img/ls-cardinality.svg", width: 80%),
  caption: [
    Model cardinalities allowed by Löwenheim–Skolem: DLO has models of
    every infinite cardinality, PA has countable models and arbitrarily
    large ones, and a consistent ZFC even has a countable model despite
    proving the existence of uncountable sets.
  ],
  placement: auto,
  supplement: [Fig.]
) <fig:ls-cardinality>

#theorem(name: "Downward Löwenheim–Skolem Theorem")[
  Let $Gamma$ be a consistent set of sentences in a countable
  signature. Then $Gamma$ has a model whose domain is countable.
] <thm:downward-ls>

#proof[
  This is the #link(<cor:model-existence>)[Countable Model Existence
  Corollary] of Ch 5 restated: the Henkin construction produces a term
  model whose domain consists of equivalence classes of closed terms,
  and a countable signature has only countably many closed terms. The
  same construction, applied to a signature of cardinality $lambda$,
  yields a model of cardinality at most $lambda$. The general downward
  Löwenheim–Skolem theorem — if $T$ has a model of cardinality
  $lambda$ and $|L| <= kappa <= lambda$, then $T$ has a model of
  cardinality $kappa$ — follows by closing under Skolem functions; the
  resulting elementary submodel is developed in Ch 7 (§7.1).
]

#theorem(name: "Upward Löwenheim–Skolem Theorem")[
  Let $Gamma$ be a consistent set of sentences with an infinite model.
  Then $Gamma$ has a model of every infinite cardinality
  $kappa >= |L|$.
] <thm:upward-ls>

#proof[
  Fix a cardinal $kappa$ and add $kappa$ new constant symbols
  $c_alpha$ ($alpha < kappa$). Consider
  $Gamma' = Gamma union {c_alpha != c_beta : alpha < beta < kappa}$.
  Every finite subset of $Gamma'$ mentions finitely many of the new
  constants, so it is satisfiable in any infinite model of $Gamma$ by
  interpreting the finitely many constants as distinct elements. By
  #link(<thm:compactness>)[compactness], $Gamma'$ has a model $M$; the
  constants witness $kappa$ distinct elements, so $|M| >= kappa$, and
  its reduct to the original signature is a model of $Gamma$.
]

#example(name: "Skolem's Paradox")[
  Zermelo–Fraenkel set theory with choice (ZFC) is a theory in the
  countable signature ${in}$. If ZFC is consistent, the downward
  Löwenheim–Skolem theorem gives a *countable* model $M models "ZFC"$.
  Yet ZFC proves the existence of uncountable sets — for instance
  $bb(R)$ — and inside $M$ the set that $M$ believes to be $bb(R)$ is
  uncountable from $M$'s point of view. The paradox dissolves once one
  notes that "countable" is a relational notion: a set $x in M$ is
  countable in $M$ iff $M$ contains a bijection $x -> bb(N)$. The
  bijection witnessing the external countability of $M$'s "reals" is
  simply not an element of $M$. Countability is not absolute; this
  relativity is characteristic of first-order set theory and a leitmotif
  of Ch 7.
] <ex:skolem-paradox>

#note[
  The two theorems delimit the spectrum of model cardinalities: from a
  single infinite model, downward Löwenheim–Skolem supplies models as
  small as the language, upward Löwenheim–Skolem models of every larger
  cardinality. Complete theories with a single model in every
  cardinality — the *categorical* ones — are rigid enough to pin down
  their models; the study of such theories begins in Ch 7 (§7.3).
]

== Applications // 应用

Compactness and Löwenheim–Skolem power a standard repertoire of
arguments: add new constants with prescribed inequalities, check
finite satisfiability, and let compactness deliver a model that
*witnesses* the desired failure. Two classical applications follow:
nonstandard models of arithmetic, and the non-axiomatizability of
connectedness.

#example(name: "Nonstandard Models of Arithmetic")[
  Let $L$ be the language of arithmetic
  (#link(<ex:language-of-arithmetic>)[Example 3.1]) and let $"PA"$ be
  Peano arithmetic formulated in $L$. Add a new constant $c$ and the
  sentences $c != 0$, $c != S(0)$, $c != S(S(0))$, and so on — "c is
  greater than every numeral". Every finite subset of
  $"PA" union {c != S^n (0) : n in bb(N)}$ is satisfiable in the
  standard model $bb(N)$ by interpreting $c$ as a sufficiently large
  natural number. By compactness, the whole set has a model $M$; $M$
  satisfies $"PA"$ but contains an element $c^M$ distinct from every
  numeral — a *nonstandard* element, greater than every standard
  natural number in the internal order. Such models exist for every
  consistent arithmetic theory; their detailed structure is taken up
  in Ch 9.
] <ex:nonstandard-arithmetic>

#example(name: "Connectedness is Not Axiomatizable")[
  Let $L = {E}$ be the language of graphs. Suppose a set $Sigma$ of
  sentences axiomatized connectedness: a graph satisfies $Sigma$ iff it
  is connected. For each $n >= 0$ there is a connected graph $G_n$ with
  two distinguished elements $a_n, b_n$ whose distance is at least $n$
  (a long path, say). The formula $P_n (x, y)$ — "there is a path from
  $x$ to $y$ of length at most $n$" — is first-order: a finite
  disjunction of existential conjunctions over $E$. Now consider
  $Sigma union {not P_(n-1) (a, b) : n in bb(N)}$, where $a, b$ are
  new constants. Every finite subset is satisfied by the appropriate
  $G_n$ with $a, b$ mapped to $a_n, b_n$. By compactness, some model
  $M$ satisfies $Sigma$ and $not P_(n-1) (a, b)$ for every $n$; but $M$
  is connected (it satisfies $Sigma$), so the distance of $a^M, b^M$
  is some finite $d$, contradicting $not P_d (a, b) in M$. Therefore
  connectedness — unlike, say, the theory of equivalence relations —
  is not expressible by any set of first-order sentences.
] <ex:connectedness-not-axiomatizable>

#note[
  Both arguments follow the same template: force a property on
  finitely many elements (an element above all numerals; two elements
  arbitrarily far apart), verify finite satisfiability, and let
  compactness convert it into a genuine model. The first example is
  the seed of nonstandard analysis and of the model theory of
  arithmetic (Ch 9); the second is the reason infinitary properties
  such as connectedness, well-foundedness, and finiteness resist
  first-order axiomatization.
]

== Definability // 可定义性初步

Compactness and Löwenheim–Skolem also delimit what first-order logic
can *say about* a structure: which subsets of a model can be picked out
by formulas. Definability is the interface between model theory and the
structure itself — the notions defined here are used throughout Part
III, and quantified elimination (Ch 7.4) will describe definable sets
for special theories.

#definition(name: "Definable Set")[
  Let $M$ be a structure and $phi (x_1, dots, x_n)$ a formula. The set
  *defined by* $phi$ in $M$ is
  $phi^M = {(a_1, dots, a_n) in |M|^n : M models phi[a_1, dots, a_n]}$.
  A set $X subset |M|^n$ is *definable* (without parameters) in $M$ if
  $X = phi^M$ for some formula $phi$.
] <def:definable-set>

#definition(name: "Definable Relation with Parameters")[
  If the formula is allowed constants from a finite set $A subset |M|$,
  $X$ is *definable with parameters from* $A$; the parameters are
  treated as constant symbols interpreted in $M$.
] <def:definable-relation>

#proposition(name: "Finiteness is Not Axiomatizable")[
  There is no set of sentences $Sigma$ such that a structure satisfies
  $Sigma$ if and only if it is finite.
] <prop:finitude-not-axiomatizable>

#proof[
  Suppose such $Sigma$ exists. Let $sigma_n$ be the sentence asserting
  "there are at least $n$ elements" — a finite conjunction of
  inequalities of $n$ existential variables. Every finite subset of
  $Sigma union {sigma_n : n in bb(N)}$ contains $Sigma_0$ and finitely
  many $sigma_n$; it is satisfied by any finite structure with enough
  elements (all finite structures satisfy $Sigma$). By
  #link(<thm:compactness>)[compactness], the whole set has a model
  $M$; but $M$ satisfies every $sigma_n$, so $M$ is infinite, while it
  also satisfies $Sigma$ — contradiction. Finiteness, unlike
  "having at least $n$ elements", is not a first-order property.
]

#example(name: "Definable Sets in Arithmetic")[
  In the standard model $(bb(N), +, dot)$ of arithmetic
  (#link(<ex:language-of-arithmetic>)[Example 3.1]), the even numbers
  are definable by $exists y (x = y + y)$; the perfect squares by
  $exists y (x = y dot y)$; the primes by
  $x > 1 and forall y forall z (x = y dot z -> (y = 1 or z = 1))$.
  Each definable set is a finite Boolean combination of sets picked out
  by quantifier-free formulas after quantification is removed — the
  theme of quantifier elimination in Ch 7.4. In contrast, the set of
  Gödel numbers of true sentences is *not* definable in arithmetic:
  Tarski's undefinability theorem (Ch 9).
] <ex:definable-arithmetic>

#note[
  Definability is the bridge to the rest of Part III: quantifier
  elimination (Ch 7.4) characterizes the definable sets of DLO and of
  algebraically closed fields; Tarski's undefinability of truth (Ch 9)
  shows that the language of arithmetic cannot talk about its own
  semantics. Together with compactness and Löwenheim–Skolem, the three
  chapters of Part II close with a complete picture of what
  first-order logic can and cannot do.
]

#part("Metamathematics")  // 元数学：模型论、可计算性与不完备性

= Metamathematics  // 元数学

#note[
  Placeholder: The two wings of metamathematics. Planned as three
  chapters: elementary model theory (Ch 7: substructures, ultraproducts
  and Łoś, categoricity) → computable functions and undecidability
  (Ch 8) → Gödel's incompleteness theorems (Ch 9). It will be
  developed in a subsequent revision.
]

#part("Extensions")  // 扩展：二阶逻辑与非经典逻辑

= Extensions  // 扩展

#note[
  Placeholder: Beyond classical logic. Planned as two chapters:
  second-order logic (Ch 10: standard vs. Henkin semantics, failure of
  compactness and completeness) and an introduction to non-classical
  logics (Ch 11: intuitionistic logic, modal logic). It will be
  developed in a subsequent revision.
]

#part("Appendix")

= Glossary

== A
- *#link(<def:alpha-equivalent>)[Alpha-Equivalence]*
- *#link(<def:lukasiewicz-system>)[Axiom Schema]*

== B
- *#link(<prop:algebraic-laws>)[Boolean Algebra]*

== C
- *#link(<thm:compactness>)[Compactness Theorem]*
- *#link(<def:consistency>)[Consistency]*
- *#link(<def:conjunction>)[Conjunction]*

== D
- *#link(<thm:deduction-theorem>)[Deduction Theorem]*
- *#link(<def:definable-set>)[Definable Set]*
- *#link(<def:derived-connectives>)[Derived Connectives]*
- *#link(<def:disjunction>)[Disjunction]*
- *#link(<cor:double-negation>)[Double Negation]*

== E
- *#link(<def:elementary-equivalence>)[Elementary Equivalence]*
- *#link(<def:exists-abbreviation>)[Existential Quantifier]*

== F
- *#link(<def:first-order-formula>)[First-Order Formula]*
- *#link(<def:free-bound-variable>)[Free and Bound Variables]*

== G
- *#link(<def:generalization>)[Generalization (Gen)]*

== H
- *#link(<thm:henkin-completeness>)[Henkin Completeness Theorem]*
- *#link(<thm:herbrand>)[Herbrand's Theorem]*
- *#link(<cor:hypothetical-syllogism>)[Hypothetical Syllogism (HS)]*

== I
- *#link(<def:implication>)[Implication]*

== L
- *#link(<def:logical-consequence>)[Logical Consequence]*
- *#link(<def:logical-equivalence>)[Logical Equivalence]*
- *#link(<thm:downward-ls>)[Löwenheim–Skolem Theorems]*

== M
- *#link(<def:model>)[Model]*
- *#link(<def:lukasiewicz-system>)[Modus Ponens (MP)]*

== N
- *#link(<def:negation>)[Negation]*

== P
- *#link(<prop:derived-theorems>)[Peirce's Law]*
- *#link(<def:prenex-form>)[Prenex Normal Form]*
- *#link(<prop:basic-theorems>)[Principle of Explosion]*
- *#link(<def:proof>)[Proof]*

== R
- *#link(<thm:reductio-ad-absurdum>)[Reductio ad Absurdum]*

== S
- *#link(<def:satisfaction>)[Satisfaction]*
- *#link(<def:tautology>)[Satisfiable]*
- *#link(<def:tautology>)[Semantic Consequence]*
- *#link(<def:sentence>)[Sentence]*
- *#link(<def:signature>)[Signature]*
- *#link(<def:skolem-form>)[Skolem Normal Form]*
- *#link(<thm:soundness-completeness>)[Soundness and Completeness]*
- *#link(<def:structure>)[Structure]*
- *#link(<def:substitutable>)[Substitutable]*
- *#link(<def:substitution>)[Substitution]*

== T
- *#link(<def:tautology>)[Tautology]*
- *#link(<def:term>)[Term]*
- *#link(<def:term-model>)[Term Model]*
- *#link(<def:theorem>)[Theorem]*
- *#link(<def:model>)[Truth]*

== V
- *#link(<def:valuation>)[Valuation]*

== W
- *#link(<def:wff>)[Well-Formed Formula (WFF)]*

= References

- G. Frege, *Begriffsschrift, eine der arithmetischen nachgebildete
  Formelsprache des reinen Denkens*, Halle, 1879.
- J. Łukasiewicz and A. Tarski, *Untersuchungen über den
  Aussagenkalkül*, Comptes rendus des séances de la Société des
  Sciences et des Lettres de Varsovie, Classe III, 23 (1930), 30–50.
- E. Mendelson, *Introduction to Mathematical Logic*, 6th ed.,
  Chapman & Hall/CRC, 2015.
- H.-D. Ebbinghaus, J. Flum, and W. Thomas, *Mathematical Logic*,
  2nd ed., Springer, 1994.
- H. B. Enderton, *A Mathematical Introduction to Logic*, 2nd ed.,
  Academic Press, 2001.
- S. Hedman, *A First Course in Logic: An Introduction to Model
  Theory, Proof Theory, Computability, and Complexity*, Oxford
  University Press, 2004.
