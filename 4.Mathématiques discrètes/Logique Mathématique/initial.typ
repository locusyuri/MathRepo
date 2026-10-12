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
  version: "v1.4.0",
  extra-info: "This is a notebook for mathematical logic.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline) — v1.4.0
// 主线：语言基础 → 主体理论 → 元数学 → 扩展（四段式）
// 参照 Analyse Mathématique：每个 Part 容纳 2–4 章实质内容
// 状态标记：[已写] 已完成 · [计划] 待写作 · [可选] 按需取舍
// ==========================================================================

// ==========================================================================
// Part I — Propositional Logic（命题逻辑）— 语言基础
// ==========================================================================
// 设计思路：最简单的形式语言。Ch 1 已完整写作（v0.3.0 完成修复）；
//   Ch 2 为方法章，承接紧致性与归结，形成命题层闭环（已写 v1.4.0）。
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

// --- Chapter 2: Normal Forms, Resolution and Compactness（范式、归结与紧致性）--- [已写，v1.4.0]
//   Section 2.1: Normal Forms and Truth-Functional Completeness（范式与真值函数完备性）
//   Section 2.2: Resolution（归结原理：可靠性/完全性完整证明）
//   Section 2.3: Propositional Compactness（命题紧致性；König 引理由 §2.4 移入）
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

// --- Chapter 7: Elementary Model Theory（初等模型论）--- [已写，v0.9.0]
//   Section 7.1: Substructures and Elementary Substructures（子结构与初等子结构，Tarski–Vaught；
//     一般基数 L-S（Skolem 闭包）兑现 Ch 6 L2050）
//   Section 7.2: Ultraproducts and Łoś's Theorem（超积与 Łoś 定理；交叉引用 Théorie des Ensembles 超滤；
//     紧致性构造化证明）
//   Section 7.3: Complete Theories and Categoricity（完备理论与范畴性；Vaught 检验；
//     DLO 完备性兑现 Ch 4 L1576 / Ch 5 L1943）
//   Section 7.4: Quantifier Elimination（量词消去：DLO 完整证明、ACF 陈述；兑现 Ch 3/Ch 6 承诺）

// --- Chapter 8: Computable Functions and Undecidability（可计算函数与不可判定性）--- [已写，v1.0.0]
//   Section 8.1: Primitive Recursive Functions（原始递归函数）
//   Section 8.2: Partial Recursive Functions and Church's Thesis（部分递归函数与 Church 论题）
//   Section 8.3: Turing Machines and the Halting Problem（图灵机与停机问题）
//   Section 8.4: Undecidability of First-Order Logic（一阶逻辑的不可判定性；兑现 Ch 5/Ch 7 承诺）

// --- Chapter 9: Gödel's Incompleteness Theorems（Gödel 不完备定理）--- [已写，v1.1.0]
//   Section 9.1: Arithmetization of Syntax（语法算术化：Gödel 编码、可表示性；兑现 §8.4 β-函数承诺）
//   Section 9.2: The First Incompleteness Theorem（第一不完备定理：对角化、ω-一致性；兑现 L1423/L2122）
//   Section 9.3: The Second Incompleteness Theorem（第二不完备定理：可证性条件 D1–D3、Con 不可证）
//   Section 9.4: Tarski's Undefinability of Truth（真值不可定义性；兑现 L2204/L2211）

// ==========================================================================
// Part IV — Extensions（扩展：二阶与非经典逻辑）— 展望
// ==========================================================================
// 设计思路：二阶逻辑在标准语义下无完全性，不宜与经典主线并列，降级为扩展章；
//   非经典逻辑为未来 Non-Classical Logic 笔记搭桥（桥梁模式）。
// 对应教材：Hedman Ch 6–7（扩展主题）
// 状态：Ch 10（v1.2.0）与 Ch 11（v1.3.0）均已写就，Part IV 收官。

// --- Chapter 10: Second-Order Logic（二阶逻辑）--- [已写，v1.2.0]
//   Section 10.1: Syntax and Semantics（二阶语法与语义；二阶可定义性示例）
//   Section 10.2: Standard vs. Henkin Semantics（标准语义 vs Henkin 语义；Henkin 完全性）
//   Section 10.3: Failure of Compactness and Completeness（紧致性与完全性失效；兑现 L2015）
//   Section 10.4: Categoricity of Second-Order Arithmetic（二阶算术的范畴性；兑现 L2549）

// --- Chapter 11: Non-Classical Logics: An Introduction（非经典逻辑导论）--- [已写，v1.3.0]
//   Section 11.1: Intuitionistic Logic and Kripke Semantics（直觉主义逻辑与 Kripke 语义；反例图）
//   Section 11.2: Modal Logic: Basics（模态逻辑基础；对应理论；框架性质图）
//   Section 11.3: Many-Valued Logics（多值逻辑；Kleene/Łukasiewicz；模糊一瞥）

// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循"语言基础 → 主体理论 → 元数学 → 扩展"的四段式主线，
// 共 4 个内容 Part、11 章（加附录共 5 个 Part、约 47 节）。
//
// Part I（语言基础，Ch 1–2）：命题逻辑。Ch 1 已完整写作；Ch 2 为方法章
//   （范式、归结、紧致性），形成命题层闭环——Part I 收官（Ch 1 v0.3.0、
//   Ch 2 v1.4.0）。
//
// Part II（主体理论，Ch 3–6）：一阶逻辑。语法 → 语义 → 证明论 →
//   紧致性/L-S。Ch 3–6 全部完成（v0.8.0）：语法、语义、证明论与
//   Henkin 完全性（Ch 5.4，全书核心定理）、紧致性与 L-S（Ch 6）均已写就。
//
// Part III（元数学，Ch 7–9）：模型论（理论有哪些模型）→ 可计算性（能算什么）
//   → 不完备性（证不出什么），元理论两翼递进。Ch 7 初等模型论（v0.9.0）、
//   Ch 8 可计算性与不可判定性（v1.0.0）、Ch 9 Gödel 不完备定理（v1.1.0：
//   算术化/对角化/两不完备定理/Tarski）均已写就——Part III 收官。
//
// Part IV（扩展，Ch 10–11）：二阶逻辑（Ch 10 已写 v1.2.0：标准语义下无完全性/
//   紧致性/L-S，Henkin 语义恢复元定理，PA₂ 范畴性）与非经典逻辑导论
//   （Ch 11 已写 v1.3.0：直觉主义/Kripke、模态对应理论、多值——为未来笔记搭桥）。
//   Part IV 收官：Ch 10–11 全部写就。
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

Chapter 1 answered the *semantic* and *proof-theoretic* questions:
which formulas are tautologies, which are provable, and why the two
answers coincide. This chapter answers the *algorithmic* question:
how do we decide satisfiability, and what combinatorial principle
underlies the decision? The truth tables of Ch 1 give an exponential
enumeration; normal forms reorganize the search, resolution
mechanizes it, and the propositional compactness theorem — a purely
combinatorial fact about finite satisfiability — turns out to be the
seed of the first-order compactness theorem of Ch 6 (promised there
at §6.1).

== Normal Forms and Truth-Functional Completeness // 范式与真值函数完备性

The connectives of Ch 1 are interdefinable in a strong sense: every
truth function can be built from a few of them, and every formula
can be rearranged, without changing its truth table, into a
canonical shape. The shapes are the *normal forms*, and they are the
raw material of the resolution method of §2.2.

#definition(name: "Literals and Clauses")[
  A *literal* is an atom $p$ or its negation $not p$. A *clause* is a
  disjunction of literals $ell_1 or ell_2 or dots or ell_n$ (the
  empty clause, written $bot$, is the disjunction of nothing and is
  unsatisfiable). A *clause set* is a conjunction of clauses.
] <def:literal>

#definition(name: "Conjunctive and Disjunctive Normal Forms")[
  A formula is in *conjunctive normal form* ($"CNF"$) if it is a
  conjunction of clauses; in *disjunctive normal form* ($"DNF"$) if
  it is a disjunction of conjunctions of literals:
  $
    "CNF": phi = ⋀_(i=1)^m (⋁_(j=1)^(n_i) ell_(i j)), quad
    "DNF": phi = ⋁_(i=1)^m (⋀_(j=1)^(n_i) ell_(i j)).
  $
] <def:cnf>

#eq[
  $
    phi = ⋀_(i=1)^m (⋁_(j=1)^(n_i) ell_(i j)).
  $
] <eq:cnf-representation>

#theorem(name: "Existence of CNF and DNF")[
  Every formula $phi$ with atoms $p_1, ..., p_n$ is logically
  equivalent to a formula in CNF and to a formula in DNF.
] <thm:cnf-dnf-existence>

#proof[
  Read $phi$ as a truth function of $p_1, ..., p_n$
  (#link(<def:valuation>)[Definition 1.8]).

  *Step 1: the DNF.* For every row of the truth table in which
  $phi$ evaluates to $1$, form the conjunction of literals that is
  true exactly on that row: the conjunct is $p_i$ if $p_i = 1$ on
  the row and $not p_i$ if $p_i = 0$. The disjunction of these
  conjunctions agrees with $phi$ on every row: on a row where
  $phi = 1$ one disjunct is true; on a row where $phi = 0$ no
  disjunct is true.

  *Step 2: the CNF.* Dually, for every row where $phi = 0$ form the
  disjunction of literals that is false exactly on that row — the
  disjunct is $p_i$ if $p_i = 0$ and $not p_i$ if $p_i = 1$. The
  conjunction of these disjunctions agrees with $phi$ on every row.

  *Step 3: equivalence.* Both constructions produce formulas whose
  truth table is the truth table of $phi$; by the completeness of
  the truth-table criterion (#link(<thm:soundness-completeness>)[Theorem 1.2]
  for the propositional layer), each is logically
  equivalent to $phi$. If $phi$ is a tautology, the DNF is the empty
  disjunction's worth of rows and one may take, e.g., $p_1 or not p_1$.
]

#example(name: "Normal Forms")[
  For $phi = (p -> q) and not r$, the truth table has $1$'s exactly
  on the rows $(1, 1, 0)$, $(0, 1, 0)$, $(0, 0, 0)$, so
  $
    "DNF": (p and q and not r) or (not p and q and not r) or (not p and not q and not r),
  $
  and the $0$'s give the CNF
  $
    (not p or q or r) and (p or not q or r) and (p or q or r).
  $
  Both are satisfiability-equivalent to $phi$, as required.
] <ex:cnf-examples>

#definition(name: "Truth Functions")[
  An *n-ary truth function* is a function
  ${0, 1}^n -> {0, 1}$. Every formula with atoms $p_1, ..., p_n$
  defines one.
] <def:truth-function>

#theorem(name: "Truth-Functional Completeness")[
  The set ${not, and, or}$ of connectives is *truth-functionally
  complete*: every n-ary truth function is realized by a formula
  built from $not$, $and$, $or$ only.
] <thm:truth-functional-completeness>

#proof[
  By #link(<thm:cnf-dnf-existence>)[the existence theorem], the DNF
  of any formula uses only $not$, $and$, $or$. For an arbitrary truth
  function $f$, take a formula $phi$ with the truth table of $f$
  (e.g., a disjunction of the appropriate variable signs) and apply
  the theorem. Hence $f$ is realized. Moreover the set can be cut
  down: $p and q$ is equivalent to $not (not p or not q)$ (de
  Morgan, #link(<prop:algebraic-laws>)[Proposition 1.4]), so
  ${not, or}$ suffices, and by duality ${not, and}$ does too; even a
  single connective works — the Sheffer stroke $p ↑ q := not (p and q)$
  alone is complete, since $not p$ is $p ↑ p$ and $p or q$ is
  $(p ↑ p) ↑ (q ↑ q)$.
]

#example(name: "Complete Sets of Connectives")[
  The intuitionistic and modal languages of Ch 11 use $not$ and
  $or$/$and$ as primitive exactly because of such reductions. The
  classical truth-functional base of Ch 1 — five connectives — is
  thus redundant: $not$ and $or$ (or the Sheffer stroke alone) carry
  the whole expressive power of propositional truth.
] <ex:functional-completeness-examples>

== Resolution // 归结原理

Resolution is a proof search on clause sets: it derives new clauses
from old ones, and the empty clause — a contradiction — appears
exactly when the set is unsatisfiable. It is the engine of modern SAT
solvers and the propositional skeleton of the first-order resolution
methods announced in Ch 3 (§3.4).

#definition(name: "Clause Sets")[
  A *clause set* is a finite set of clauses
  (#link(<def:literal>)[Definition 2.1]). The set is *satisfiable*
  if its conjunction is; the empty clause $bot$ is satisfiable by
  no valuation, so a set containing $bot$ is unsatisfiable. A clause
  containing complementary literals ($p$ and $not p$) is a
  *tautological clause* and may be deleted without changing
  satisfiability.
] <def:clause-set>

#definition(name: "The Resolution Rule")[
  If $C$ and $D$ are clauses and $ell$ is a literal, the *resolvent*
  of $C or ell$ and $D or overline(ell)$ is the clause
  $C or D$, obtained by cancelling the complementary pair:
  $
    (C or ell) quad "and" quad (D or overline(ell)) models C or D.
  $
] <def:resolution-rule>

#eq[
  $
    (C or ell), quad (D or overline(ell)) slash (C or D).
  $
] <eq:resolution-rule>

#definition(name: "Resolution Derivations and Refutations")[
  A *resolution derivation* from a clause set $S$ is a sequence of
  clauses in which each entry is either a clause of $S$ or a
  resolvent of two earlier entries. A *refutation* is a derivation
  ending in the empty clause $bot$.
] <def:resolution-refutation>

#lemma(name: "Soundness of One Step")[
  Every resolvent of two clauses of $S$ is a logical consequence of
  $S$: if a valuation satisfies $C or ell$ and $D or overline(ell)$,
  it satisfies $C or D$.
] <lem:resolution-basic>

#proof[
  Let $v$ satisfy both premises. If $v$ satisfies $ell$, then it must
  satisfy $D$ (since $D or overline(ell)$ holds and $overline(ell)$
  fails), so it satisfies $C or D$. If $v$ fails $ell$, then it must
  satisfy $C$ from the first premise, again giving $C or D$. Either
  way the resolvent holds.
]

#theorem(name: "Soundness of Resolution")[
  If a clause set $S$ has a refutation, then $S$ is unsatisfiable.
] <thm:resolution-soundness>

#proof[
  By #link(<lem:resolution-basic>)[Lemma 2.1], every derivable clause
  is a logical consequence of $S$; induction on the length of the
  derivation shows that a valuation satisfying $S$ satisfies every
  derivable clause. A refutation derives $bot$, which no valuation
  satisfies — contradiction. Hence no valuation satisfies $S$.
]

#theorem(name: "Completeness of Resolution")[
  Every unsatisfiable clause set $S$ has a refutation.
] <thm:resolution-completeness>

#proof[
  *Step 1: saturation.* Let $S^*$ be the smallest set containing $S$
  and closed under resolution. Since every resolvent consists of
  literals already occurring in $S$, the closure is finite: at most
  $2^(2 m)$ clauses for $m$ atoms. Suppose $bot in.not S^*$; we show
  that $S^*$ — hence $S$ — is satisfiable, a contradiction.

  *Step 2: the valuation.* Define $v$ by $v (p) = 1$ iff ${p} in S^*$.
  This is well defined: if both ${p}$ and ${not p}$ were in $S^*$,
  their resolvent $bot$ would be in $S^*$, contradicting the
  assumption. We claim $v$ satisfies every clause of $S^*$.

  *Step 3: the claim.* Suppose $C in S^*$ is false under $v$; we
  derive $bot in S^*$, contradiction. If $C$ contains a literal
  $overline(ell)$ with ${ell} in S^*$, then the resolvent of $C$ and
  ${ell}$ is $C ∖ {overline(ell)}$ — again in $S^*$ by
  closure and again false under $v$; repeat until no such literal
  remains. The surviving clause has at most one literal: if it still
  contained two literals $ell_1, ell_2$, falsity under $v$ forces
  ${overline(ell_1)}$ and ${overline(ell_2)}$ into $S^*$, and the
  argument applies again. A single literal $ell$ in $S^*$ with
  $v (ell) = 0$ means ${overline(ell)} in S^*$, and the resolvent is
  $bot$. Hence $bot in S^*$, contradiction. So $v$ satisfies $S^*$,
  and $S$ is satisfiable. Therefore unsatisfiability forces
  $bot in S^*$: a refutation exists.
]

#example(name: "A Refutation")[
  The set ${p or q, not p or q, p or not q, not p or not q}$ is
  unsatisfiable (every valuation falsifies one of the four clauses).
  Resolution finds this: from $p or q$ and $not p or q$ resolve
  $q$; from $p or not q$ and $not p or not q$ resolve $not q$; and
  $q$ with $not q$ resolve $bot$. Figure 2.1 draws the refutation
  tree.
] <ex:resolution-example>

#figure(
  image("img/resolution-tree.svg", width: 80%),
  caption: [
    A resolution refutation tree. The four clauses of Example 2.2
    resolve in two layers to $q$ and $not q$, and finally to the
    empty clause $bot$ — the certificate of unsatisfiability.
  ],
  placement: auto,
  supplement: [Fig.]
) <fig:resolution-tree>

== Propositional Compactness // 命题紧致性

A set of sentences is satisfiable if *every finite part* of it is:
there is no way to build an unsatisfiable set except from a finite
core of contradictions. This is the *propositional compactness
theorem*, announced at §6.1 of Ch 6 as the seed of the first-order
compactness theorem. Its proof is a purely combinatorial fact about
infinite trees.

#lemma(name: "König's Lemma")[
  Every infinite tree in which each node has finitely many
  successors has an infinite branch.
] <lem:konig-lemma>

#proof[
  A *tree* here is a set of finite sequences, closed under taking
  prefixes; a node is a sequence, its successors are the one-step
  extensions in the tree. Build the branch greedily. Let $x_0$ be the
  root (the empty sequence); the set of nodes extending $x_0$ is
  infinite because the tree is infinite. Given $x_n$ whose set of
  extensions $E_n = {y in T : y " extends " x_n}$ is infinite, the
  finitely many immediate successors of $x_n$ partition $E_n$
  (apart from $x_n$ itself), so at least one successor $x_(n+1)$ has
  infinitely many extensions; choose it. The sequence
  $(x_0, x_1, x_2, ...)$ is an infinite branch: every prefix lies in
  the tree, and the choices never stop.
]

#theorem(name: "Propositional Compactness")[
  A set $Sigma$ of propositional sentences is satisfiable if and only
  if every finite subset of $Sigma$ is satisfiable.
] <thm:propositional-compactness>

#proof[
  One direction is trivial. For the converse, enumerate the countably
  many sentences of $Sigma$ as $sigma_1, sigma_2, ...$ and the atoms
  as $p_1, p_2, ...$. Build a tree $T$ whose nodes of level $n$ are
  the finite valuations $alpha = (alpha_1, ..., alpha_n)$ (each
  $alpha_i in {0, 1}$) that satisfy every sentence among
  ${sigma_1, ..., sigma_n}$ whose atoms lie among $p_1, ..., p_n$.

  *Step 1: $T$ is a tree.* Prefixes of a valuation are valuations,
  and a longer valuation satisfies at least as many of the
  $sigma_i$ as its prefixes, so prefix closure holds.

  *Step 2: every level is nonempty.* Fix $n$. The finite set
  ${sigma_1, ..., sigma_n}$ uses finitely many atoms, hence atoms
  among $p_1, ..., p_N$ for some $N$. By hypothesis it has a
  satisfying valuation; its first $n$ coordinates satisfy every
  $sigma_i$ ($i <= n$) whose atoms lie among $p_1, ..., p_n$ — so
  level $n$ of $T$ is nonempty.

  *Step 3: König.* Each node has at most two successors. Since $T$ is
  infinite (infinitely many nonempty levels), König's lemma yields an
  infinite branch $(alpha_1, alpha_2, ...)$.

  *Step 4: the valuation.* Define $v (p_n) = alpha_n$. For any
  $sigma_k in Sigma$ with atoms among $p_1, ..., p_N$, take
  $n >= max (k, N)$: the level-$n$ node of the branch satisfies
  $sigma_k$ (it satisfies all of $sigma_1, ..., sigma_n$ with atoms
  among $p_1, ..., p_n$), and $v$ agrees with it on those atoms.
  Hence $v models sigma_k$, and $v$ satisfies all of $Sigma$.
]

#figure(
  image("img/konig-lemma.svg", width: 78%),
  caption: [
    König's lemma: an infinite tree with finite branching contains an
    infinite branch. The greedy choice at each level keeps the
    infinite part of the tree.
  ],
  placement: auto,
  supplement: [Fig.]
) <fig:konig-lemma>

#note[
  *The seed of Ch 6.* The propositional compactness theorem is the
  propositional analogue of the first-order theorem of Ch 6
  (#link(<thm:compactness>)[Theorem 6.1]), where the finite
  satisfiability hypothesis is lifted through completeness and the
  Henkin construction. Both theorems express the same finiteness
  principle: contradiction is always witnessed by a finite set. The
  principle fails in second-order logic with standard semantics
  (Ch 10), where a finite set $Sigma = {not "Inf"} union {sigma_n}$
  is finitely satisfiable but unsatisfiable as a whole — the
  propositional core of that counterexample is precisely what the
  compactness theorem rules out here.
]

== Applications: SAT and König's Lemma // 应用：SAT 与 König 引理

The machinery of this chapter has two faces: decision and
construction. SAT asks whether a given formula can be satisfied at
all; compactness turns local satisfiability into global
satisfiability, building objects of infinite size from finite data.

#definition(name: "The Satisfiability Problem")[
  The *satisfiability problem* ($"SAT"$) asks, given a formula $phi$
  (equivalently, a clause set), whether $phi$ is satisfiable.
] <def:sat>

The problem is decidable by brute force: with $n$ atoms the truth
table of Ch 1 enumerates $2^n$ valuations, and resolution
(#link(<thm:resolution-soundness>)[Theorem 2.3] +
#link(<thm:resolution-completeness>)[2.4]) gives the same answer by
search. This is the sharpest contrast with first-order logic, whose
satisfiability is undecidable (Ch 8, Theorem 8.4): propositional
truth is finite and combinatorial, first-order truth is not.

#example(name: "Infinite Graphs are Colorable iff Finite Parts Are")[
  Let $G$ be an infinite (countable) graph and $k$ a positive
  integer. *$G$ is $k$-colorable if and only if every finite
  subgraph of $G$ is $k$-colorable.*

  One direction is trivial. For the converse, fix atoms $p_(v, i)$
  meaning "vertex $v$ has color $i$", for $v in V(G)$ and
  $1 <= i <= k$. Let $Sigma$ contain, for every $v$, the sentence
  $p_(v,1) or dots or p_(v,k)$ ("some color"); for every $v$ and
  $i != j$, the sentence $not (p_(v,i) and p_(v,j))$ ("at most one
  color"); and for every edge $u v$ and every $i$, the sentence
  $not (p_(u,i) and p_(v,i))$ ("adjacent vertices differ"). A
  valuation satisfying $Sigma$ is exactly a proper $k$-coloring.

  Any finite subset of $Sigma$ mentions only finitely many vertices
  and edges, so it concerns a finite subgraph $H$ of $G$. By
  hypothesis $H$ is $k$-colorable; the coloring of $H$ satisfies the
  finite subset. By #link(<thm:propositional-compactness>)[propositional compactness],
  $Sigma$ is satisfiable, and $G$ is
  $k$-colorable.
] <ex:graph-coloring>

#example(name: "Uniform Satisfiability")[
  Suppose $Sigma$ is a set of sentences such that every finite subset
  is satisfiable *uniformly* — by a single valuation satisfying all
  finite subsets. Compactness gives more: $Sigma$ itself is
  satisfiable. Applications range from finite model theory to the
  existence of infinite combinatorial objects whose existence is
  first checked on finite pieces.
] <ex:compactness-applications>

#note[
  *What this chapter built.* Ch 1 gave truth tables and proofs; this
  chapter added the algorithmic spine. Normal forms reorganize
  formulas without changing satisfiability (§2.1); resolution decides
  satisfiability by search and certifies unsatisfiability with a
  finite refutation (§2.2); compactness lifts the finiteness of
  satisfiability to infinite sets (§2.3); König's lemma — the
  combinatorial heart of that lifting — turns local data into global
  objects (§2.4). The three chapters of Part I are the complete
  theory of propositional logic: syntax, semantics, proofs,
  algorithms, and the infinitary limit.
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

= Elementary Model Theory  // 初等模型论

Ch 6 closed Part II with the two structural theorems of first-order
logic; Part III turns to the metamathematics that rests on them. This
chapter is the model-theoretic wing: given a theory, what do its models
look like, and how are they related? Two construction principles —
elementary substructures (downward) and ultraproducts (upward, via
Łoś) — and three yardsticks on theories — completeness, categoricity,
and quantifier elimination — give the first systematic picture.
Elementary equivalence, introduced in Ch 4, is the entry point: we now
study the elementary relations *between* models rather than the
satisfaction of single formulas.

== Substructures and Elementary Substructures // 子结构与初等子结构

#definition(name: "Substructure")[
  Let $M$ and $N$ be structures for the same signature $L$. $N$ is a
  *substructure* of $M$ ($N subset M$) if $|N| subset |M|$, every
  constant of $L$ is interpreted as the same element in both, every
  function symbol is interpreted in $N$ as the restriction of its
  interpretation in $M$, and every relation symbol likewise.
] <def:substructure>

#definition(name: "Elementary Substructure")[
  $N$ is an *elementary substructure* of $M$ ($N prec.eq M$) if $N$
  is a substructure of $M$ and for every formula $phi (x_1, dots,
  x_n)$ and all $a_1, dots, a_n in |N|$,
  $M models phi [a_1, dots, a_n]$
  if and only if
  $N models phi [a_1, dots, a_n]$.
  The embedding $|N| -> |M|$ is then an *elementary embedding*.
] <def:elementary-substructure>

Being an elementary substructure is much stronger than being a
substructure: it requires $N$ and $M$ to agree on all first-order
formulas with parameters in $N$ — in particular, on all sentences, so
$N models T$ iff $M models T$ for every theory $T$. The substructure
relation alone guarantees agreement only on quantifier-free formulas.

#theorem(name: "Tarski–Vaught Test")[
  Let $N subset M$. Then $N prec.eq M$ if and only if for every
  formula $phi (x, y_1, dots, y_n)$ and all $b_1, dots, b_n in |N|$,
  if $M models exists x phi (x, b_1, dots, b_n)$, then there exists
  $a in |N|$ with $M models phi (a, b_1, dots, b_n)$.
] <thm:tarski-vaught>

#proof[
  *Sufficiency.* Suppose the witness condition holds. We prove by
  induction on $phi$ that $M models phi [a_1, dots, a_n]$ iff
  $N models phi [a_1, dots, a_n]$ for all parameters from $N$. The
  atomic, conjunction, and negation steps are immediate from
  $N subset M$. For the existential step, if
  $M models exists x psi (x, b_1, dots, b_n)$, the condition gives
  $a in |N|$ with $M models psi (a, b_1, dots, b_n)$; by induction
  $N models psi (a, b_1, dots, b_n)$, hence $N models exists x psi$.
  Conversely, if $N models exists x psi (x, b_1, dots, b_n)$, some
  $a in |N|$ witnesses it, induction transfers the satisfaction to
  $M$, and $M models exists x psi$.
  *Necessity.* If $N prec.eq M$ and
  $M models exists x phi (x, b_1, dots, b_n)$, then by elementarity
  $N models exists x phi (x, b_1, dots, b_n)$; the witnessing element
  of $N$ is the required $a$.
]

#definition(name: "Elementary Embedding")[
  An *elementary embedding* of $N$ into $M$ is an injective function
  $h : |N| -> |M|$ such that for every formula $phi (x_1, dots,
  x_n)$ and all $a_1, dots, a_n in |N|$,
  $N models phi [a_1, dots, a_n]$
  iff
  $M models phi [h (a_1), dots, h (a_n)]$.
  Its image is an elementary substructure of $M$ isomorphic to $N$.
] <def:elementary-embedding>

Elementary embeddings generalize isomorphisms
(#link(<prop:isomorphism-elementary>)[Proposition 4.8]): an
isomorphism is an elementary embedding, and an elementary embedding
need not be surjective, nor need it preserve cardinality — the Skolem
paradox below turns exactly this slack into a construction principle.

#theorem(name: "Downward Löwenheim–Skolem, General Cardinality")[
  Let $T$ be a consistent theory in a signature $L$ of cardinality
  $|L|$, and let $M models T$ with $|M| = lambda$. Then for every
  cardinal $kappa$ with $|L| <= kappa <= lambda$, $T$ has a model of
  cardinality $kappa$ which is an elementary substructure of $M$.
] <thm:downward-ls-general>

#proof[
  *Step 1: Skolemization.* Add a function symbol $f_phi$ of arity
  $n$ for each formula $phi (x, y_1, dots, y_n)$, with the Skolem
  axiom
  $forall y_1 dots forall y_n (exists x phi (x, y_1, dots, y_n) ->
  phi (f_phi (y_1, dots, y_n), y_1, dots, y_n))$.
  By #link(<prop:skolem-satisfiability>)[Proposition 3.4] the
  expansion $T^S$ is satisfiable iff $T$ is; $M$ expands to a model
  of $T^S$, still denoted $M$.
  *Step 2: Skolem closure.* Fix a set $X_0 subset |M|$ of cardinality
  $kappa$. Let $X_(n+1)$ be $X_n$ together with
  $f_phi (b_1, dots, b_n)$ for all $b_1, dots, b_n in X_n$ and all
  Skolem functions $f_phi$. Each $X_n$ has cardinality at most
  $kappa$ (there are at most $|L| + aleph_0 <= kappa$ formulas), so
  $X = union_(n in bb(N)) X_n$ has cardinality $kappa$, and $X$ is
  closed under all Skolem functions; interpreting the symbols of $L$
  on $X$ gives a substructure $N subset M$ of cardinality $kappa$.
  *Step 3: Tarski–Vaught.* If
  $M models exists x phi (x, b_1, dots, b_n)$ with
  $b_1, dots, b_n in X$, the Skolem axiom gives
  $M models phi (f_phi (b_1, dots, b_n), b_1, dots, b_n)$, and
  $f_phi (b_1, dots, b_n) in X$ by closure. By
  #link(<thm:tarski-vaught>)[the Tarski–Vaught test],
  $N prec.eq M$, so $N models T$ and $|N| = kappa$.
]

#example(name: "Skolem's Paradox, Reprise")[
  Apply the general downward theorem to a consistent ZFC with a model
  $M$: it yields a countable elementary substructure
  $N prec.eq M$. Inside $N$, the set $N$ believes to be $bb(R)$ is
  uncountable, yet $N$ itself is countable from the outside — the
  bijection witnessing external countability is absent from $N$. The
  paradox of Ch 6 is now seen as a theorem about elementary
  substructures: $N$ contains all the *definable* witnesses of $M$
  that the language can name, and nothing more.
] <ex:skolem-paradox-reprise>

#note[
  The countable version of Ch 6
  (#link(<thm:downward-ls>)[Theorem 6.2]) is the special case
  $kappa = aleph_0 = |L|$; the general form above is the one promised
  at L2050. Elementary substructures are the model-theoretic core of
  the downward principle, and their further applications — the
  amalgamation of models and the analysis of complete theories —
  drive §7.3.
]

== Ultraproducts and Łoś's Theorem // 超积与 Łoś 定理

A second construction principle builds models *upward*, out of many
small models. Filters and ultrafilters are developed in the notes on
*Théorie des Ensembles* (chapter "Filters and Boolean Algebras",
section "Filters and Ultrafilters"); we use the standard facts: a
filter $U$ on a set $I$ is a family of subsets closed under finite
intersection and supersets, and an *ultrafilter* is a filter that
contains, for every $X subset I$, exactly one of $X$ and $I ∖
X$. Ultrafilters on a set exist by Zorn's lemma.

#definition(name: "Ultraproduct")[
  Let $(M_i)_(i in I)$ be structures for the signature $L$ and let
  $U$ be an ultrafilter on $I$. On the Cartesian product
  $product_(i in I) |M_i|$, declare $f ~ g$ iff
  ${i in I : f (i) = g (i)} in U$; this is an equivalence relation.
  The *ultraproduct* $product_U M_i$ is the quotient structure: its
  domain is the set of equivalence classes $[f]$, and for each
  relation symbol $R$, function symbol $g$, and constant $c$,
  $R^M ([f_1], dots, [f_n])$ holds iff
  ${i in I : R^(M_i) (f_1 (i), dots, f_n (i))} in U$,
  $g^M ([f_1], dots, [f_n]) = [g^(M_i) (f_1 (i), dots, f_n (i))]_(i)$,
  and $c^M = [c^(M_i)]_(i)$. If all $M_i = M$, the ultraproduct is the
  *ultrapower* $M^I / U$.
] <def:ultraproduct>

The definitions of the relations and functions are well-defined:
ultrafilters are closed under finite intersections and under
supersets, so the truth or value of a coordinate-wise definition does
not depend on the chosen representatives. The three stages of the
construction are summarized in Figure 7.1.

#figure(
  image("img/ultraproduct-flow.svg", width: 80%),
  caption: [
    The ultraproduct construction: the product of the domains,
    the equivalence relation induced by the ultrafilter, and the
    quotient structure; Łoś's theorem transfers truth
    coordinate-wise.
  ],
  placement: auto,
  supplement: [Fig.]
) <fig:ultraproduct-flow>

The defining property of
the ultraproduct — the transfer of truth — is Łoś's theorem.

#theorem(name: "Łoś's Theorem")[
  For every formula $phi (x_1, dots, x_n)$ and all
  $f_1, dots, f_n$ in $product_(i in I) |M_i|$,
  $
    product_U M_i models phi [f_1, dots, f_n]
    <=> {i in I : M_i models phi [f_1 (i), dots, f_n (i)]} in U.
  $
] <thm:los>

#eq[
  $
    product_U M_i models phi [f_1, dots, f_n]
    <=> {i in I : M_i models phi [f_1 (i), dots, f_n (i)]} in U.
  $
] <eq:los-condition>

#proof[
  Induction on $phi$. The atomic case is the definition of the
  ultraproduct structure. For $phi = psi and chi$ and $phi = not
  psi$, the claim follows from closure of $U$ under finite
  intersections and under complements (ultrafilters decide every
  subset). For $phi = exists y psi (y, x_1, dots, x_n)$: if the set
  $J = {i : M_i models exists y psi (y, f_1 (i), dots, f_n (i))}$ is
  in $U$, choose, for each $i in J$, a witness $a_i$ with
  $M_i models psi (a_i, f_1 (i), dots, f_n (i))$ (and an arbitrary
  value outside $J$); the coordinate function $f$ with $f (i) = a_i$
  satisfies ${i : M_i models psi (f (i), f_1 (i), dots, f_n (i))}
  supset.eq J in U$, so by induction $product_U M_i models psi (f,
  f_1, dots, f_n)$ and the ultraproduct satisfies the existential.
  Conversely, if $product_U M_i models exists y psi (y, f_1, dots,
  f_n)$, some $g$ witnesses it; by induction
  ${i : M_i models psi (g (i), f_1 (i), dots, f_n (i))} in U$, and
  this set is contained in $J$, which therefore lies in $U$.
]

#corollary(name: "Consequences of Łoś's Theorem")[
  If all $M_i$ are elementarily equivalent to a structure $M$, then
  $product_U M_i equiv M$. In particular, for any structure $M$,
  the ultrapower $M^I / U$ is elementarily equivalent to $M$.
] <cor:los-consequences>

#example(name: "Nonstandard Arithmetic via Ultrapowers")[
  Let $M = bb(N)$ in the language of arithmetic
  (#link(<ex:language-of-arithmetic>)[Example 3.1]) and let $U$ be a
  nonprincipal ultrafilter on $bb(N)$ (one extending the cofinite
  filter). The ultrapower $bb(N)^bb(N) / U$ is elementarily
  equivalent to $bb(N)$, so it satisfies $"PA"$, but it contains the
  class of the identity function $[id]$, which is greater than every
  standard numeral: ${n : n > m} in U$ for each fixed $m$. This is a
  *canonical* nonstandard model — a single uniform construction that
  reproduces, from the compactness side, the nonstandard models of
  Ch 6, and whose fine structure is studied in Ch 9.
] <ex:ultraproduct-nonstandard>

#note[
  Compactness is a corollary of Łoś's theorem in disguise: if every
  finite subset of a theory $Sigma$ has a model, take $I$ to be the
  set of finite subsets of $Sigma$, choose a model $M_F models F$ for
  each $F in I$, and let $U$ be an ultrafilter on $I$ extending the
  family of "upward cones" ${F : phi in F}$ for each $phi in Sigma$.
  Then $product_U M_F models phi$ for every $phi in Sigma$ by Łoś — a
  direct constructional proof of compactness (Ch 6) that builds the
  model rather than proving its existence via completeness.
]

== Complete Theories and Categoricity // 完备理论与范畴性

With the two construction principles in place we turn to the
yardsticks: which theories are *rigid* enough that their models are
determined? A complete theory decides every sentence; a categorical
theory has (up to isomorphism) only one model of a given cardinality.
The results below — Vaught's test and the completeness of DLO —
connect these notions and close two promises from Ch 4 and Ch 5.

#definition(name: "Complete Theory")[
  A theory $T$ is *complete* if for every sentence $phi$ of its
  signature, exactly one of $T models phi$ and $T models not phi$
  holds — equivalently, all models of $T$ are elementarily equivalent
  (#link(<def:elementary-equivalence>)[Definition 4.7]).
] <def:complete-theory>

#definition(name: "Categoricity")[
  A theory $T$ is *categorical in cardinality* $kappa$ (or
  $kappa$-categorical) if all models of $T$ of cardinality $kappa$
  are isomorphic.
] <def:categoricity>

#theorem(name: "Vaught's Test")[
  Let $T$ be a consistent theory in a countable signature with no
  finite models. If $T$ is $aleph_0$-categorical, then $T$ is
  complete.
] <thm:vaught-test>

#proof[
  Suppose $T$ is not complete: some sentence $phi$ satisfies both
  $T union {phi}$ and $T union {not phi}$ consistently. Since $T$ has
  no finite models, each of the two extensions has a model of
  cardinality $aleph_0$ by the downward Löwenheim–Skolem theorem
  (#link(<thm:downward-ls>)[Theorem 6.2]); these models disagree on
  $phi$, hence are not elementarily equivalent. But $aleph_0$
  categoricity requires them to be isomorphic, and isomorphic
  structures are elementarily equivalent
  (#link(<prop:isomorphism-elementary>)[Proposition 4.8]) —
  contradiction.
]

#lemma(name: "Cantor's Back-and-Forth")[
  Any two countable dense linear orders without endpoints are
  isomorphic.
] <lem:cantor-back-forth>

#proof[
  Let $A = (A, <)$ and $B = (B, <)$ be countable dense linear orders
  without endpoints, with enumerations $A = {a_0, a_1, dots}$ and
  $B = {b_0, b_1, dots}$. We build a partial isomorphism $f$ by
  alternating two steps. At even stages take the first unused $a_n$
  and place its image between the images of its $<$-neighbours: by
  density, $B$ contains an element strictly between the two (or beyond
  the single neighbour, since $B$ has no endpoints). At odd stages do
  the same in the other direction, taking the first unused $b_m$ and
  finding a preimage between the appropriate $A$-elements. Each stage
  preserves the order relation on the finite partial map, and both
  enumerations are exhausted by the alternation, so the union of the
  finite partial isomorphisms is an isomorphism $A -> B$.
]

#theorem(name: "Completeness of DLO")[
  The theory of dense linear orders without endpoints (DLO) is
  complete.
] <thm:dlo-completeness>

#proof[
  DLO has no finite models (every finite linear order has endpoints
  and is not dense). By Cantor's back-and-forth, every countable
  model of DLO is isomorphic, so DLO is $aleph_0$-categorical; Vaught's
  test gives completeness. Thus
  $(bb(Q), <) equiv (bb(R), <)$ — the example of Ch 4
  (#link(<ex:elementary-equivalence-example>)[Example 4.9]) is now a
  theorem rather than a computation.
]

#note[
  DLO is $aleph_0$-categorical but *not* $aleph_1$-categorical: there
  are $2^(aleph_0)$ pairwise non-isomorphic dense linear orders
  without endpoints of cardinality $aleph_1$. Complete theories with
  a unique model in every cardinality — strongly minimal ones such as
  algebraically closed fields of a fixed characteristic — are the
  subject of deeper structure theory (quantifier elimination, §7.4,
  is the first tool). The contrast with second-order arithmetic,
  which *is* categorical and therefore escapes compactness and
  completeness (Ch 10), is the moral boundary of this chapter.
]

== Quantifier Elimination // 量词消去

Completeness and categoricity measure how rigid a theory is; quantifier
elimination describes what its *definable sets* look like. A theory
with quantifier elimination is one in which every formula is equivalent
to a quantifier-free one — the simplest possible form — so that the
definable sets of its models are exactly the Boolean combinations of
basic (quantifier-free) sets. This section proves quantifier
elimination for DLO and states it for algebraically closed fields,
closing the promises of Ch 6 (§6.4).

#definition(name: "Quantifier Elimination")[
  A theory $T$ *has quantifier elimination* if for every formula
  $phi (x_1, dots, x_n)$ there is a quantifier-free formula
  $psi (x_1, dots, x_n)$ such that $T models phi <=> psi$.
] <def:quantifier-elimination>

#eq[
  $
    T models forall x_1 dots forall x_n (phi (x_1, dots, x_n)
    <=> psi (x_1, dots, x_n)).
  $
] <eq:qe-form>

#proposition(name: "Elimination Criterion")[
  A theory $T$ has quantifier elimination if every formula of the
  form $exists y (psi_1 and dots and psi_n)$, where each $psi_k$ is
  atomic or the negation of an atomic formula, is equivalent in $T$
  to a quantifier-free formula.
] <prop:qe-criterion>

#proof[
  Write every quantifier-free formula in disjunctive normal form;
  the existential quantifier distributes over disjunction, so it
  suffices to eliminate $exists y$ from conjunctions of atomic and
  negated-atomic formulas. Induction on the formula structure then
  removes quantifiers one at a time, innermost first.
]

#lemma(name: "Elimination of One Existential in DLO")[
  In the theory DLO of dense linear orders without endpoints, every
  formula $exists y (psi_1 and dots and psi_n)$ as in the criterion
  is equivalent to a quantifier-free formula.
] <lem:qe-dlo-exists>

#proof[
  Atoms over ${<}$ are of the forms $u < v$ and $u = v$ with $u, v$
  terms (variables or parameters; DLO has no function symbols).
  Degenerate atoms are decided outright: $u < u$ and $u = v$ with $u
  != v$ are false, $u = u$ is true. Discard the decided atoms. If some
  conjunct is $y = t$ with $t$ free of $y$, substitute $t$ for $y$
  throughout and the formula is already quantifier-free. Otherwise $y$
  occurs only in comparisons $t_1 < y, dots, t_p < y, y < s_1, dots,
  y < s_q$. The existential is then equivalent to
  $and_(i, j) (t_i < s_j)$ together with the $y$-free part: each
  inequality $t_i < s_j$ is necessary, and density plus the absence
  of endpoints supplies a witness $y$ strictly between the largest
  lower bound and the smallest upper bound — and, when $p = 0$ or
  $q = 0$, the axioms $forall x exists z (z < x)$ and
  $forall x exists z (x < z)$ provide the witness. The result is
  quantifier-free.
]

#theorem(name: "Quantifier Elimination for DLO")[
  The theory DLO has quantifier elimination.
] <thm:qe-dlo>

#proof[
  Combine #link(<prop:qe-criterion>)[the criterion] with
  #link(<lem:qe-dlo-exists>)[Lemma 7.2].
]

#theorem(name: "Quantifier Elimination for Algebraically Closed Fields")[
  The theory ACF of algebraically closed fields (in the language
  ${+ , dot, -, 0, 1}$) has quantifier elimination.
] <thm:qe-acf>

ACF — as a theory in the language of rings, axiomatized by the field
axioms plus "every nonconstant polynomial has a root" for each degree
$n$ — is treated here at statement level, with the proof framework:
the elimination criterion reduces the task to conjunctions of
polynomial equations and inequations, and one eliminates an
existential $exists y$ by polynomial pseudo-division (the Euclidean
algorithm over the field), which produces a quantifier-free condition
equivalent to "the system has a solution in the algebraic closure".
This is Chevalley's theorem in disguise — the projection of a
constructible set is constructible. The details are standard (see
Enderton, Ch 3; the field-theoretic background is developed in the
algebra notes).

#corollary(name: "Definable Sets under Quantifier Elimination")[
  If $T$ has quantifier elimination and $M models T$, then every
  definable subset of $|M|^n$ is a Boolean combination of
  quantifier-free definable sets.
] <cor:qe-definable-sets>

#example(name: "Definable Sets in DLO")[
  In any model of DLO, the definable subsets of the domain are
  exactly the finite unions of intervals with endpoints in the model
  (each interval open, closed, or half-open): quantifier-free formulas
  are Boolean combinations of inequalities $x < t$ and $x = t$, which
  carve out intervals and singletons. This is the promised structure
  of §6.4, #link(<def:definable-set>)[Definition 6.1] now made
  explicit.
] <ex:dlo-definable>

#note[
  Quantifier elimination implies decidability for the model classes
  it governs: in DLO, every sentence is equivalent to a
  quantifier-free sentence, hence (there being no closed terms) to
  $top$ or $bot$ — a second proof of completeness
  (#link(<thm:dlo-completeness>)[Theorem 7.3]) and the seed of the
  decidability arguments of Ch 8. Likewise, ACF_p is complete and
  decidable for each characteristic $p$ (Lefschetz's principle: a
  first-order sentence true in one algebraically closed field of
  characteristic $p$ is true in all of them).
]

= Computable Functions and Undecidability  // 可计算函数与不可判定性

Ch 7 measured what a *theory* can do; this chapter measures what a
*logic* can do as a decision procedure. Its central question — which
sets of sentences can be decided by an algorithm? — forces a precise
notion of computability. We develop three equivalent characterizations
(primitive recursive functions, partial recursive functions via
minimalization, and Turing machines), prove the undecidability of the
halting problem, and then prove the two central negative results of
metamathematics: the valid formulas of first-order logic are
recursively enumerable but not decidable, and — with the arithmetic
language of Ch 3 as vehicle — any theory strong enough to represent
the computable functions is undecidable.

== Primitive Recursive Functions // 原始递归函数

The simplest robust class of computable functions is generated from a
few initial functions by two closure operations: composition and
primitive recursion.

#definition(name: "Initial Functions")[
  The *initial functions* are the zero function $Z (x) = 0$, the
  successor function $S (x) = x + 1$, and the projection functions
  $P_i^n (x_1, dots, x_n) = x_i$ ($1 <= i <= n$).
] <def:initial-functions>

#definition(name: "Primitive Recursion")[
  A function $f$ of arity $n + 1$ is defined by *primitive recursion*
  from $g$ of arity $n$ and $h$ of arity $n + 2$ if
  $
    f (x_1, dots, x_n, 0) = g (x_1, dots, x_n),
  $
  $
    f (x_1, dots, x_n, y + 1) = h (x_1, dots, x_n, y, f (x_1, dots, x_n, y)).
  $
] <def:primitive-recursion>

#eq[
  $
    f (x_1, dots, x_n, 0) = g (x_1, dots, x_n),
    quad
    f (x_1, dots, x_n, y + 1) = h (x_1, dots, x_n, y, f (x_1, dots, x_n, y)).
  $
] <eq:primitive-recursion-scheme>

#definition(name: "Primitive Recursive Functions")[
  A function is *primitive recursive* if it can be obtained from the
  initial functions by finitely many applications of composition and
  primitive recursion.
] <def:primitive-recursive>

#theorem(name: "Closure of Primitive Recursive Functions")[
  The primitive recursive functions are closed under composition and
  primitive recursion, and include addition, multiplication,
  exponentiation, the predecessor function
  $"pred" (0) = 0$, $"pred" (y + 1) = y$, and truncated subtraction.
] <thm:primitive-recursive-closure>

#proof[
  Closure under the two schemata is by definition. Addition:
  $f (x, 0) = x$ and $f (x, y + 1) = f (x, y) + 1$, i.e. $f = "add"$
  is defined by primitive recursion from $P_1^1$ and
  $S compose P_3^3$. Multiplication: $x dot 0 = 0$ and
  $x dot (y + 1) = x dot y + x$, using addition. Predecessor: as
  above. Truncated subtraction — the function equal to $x - y$
  when $x >= y$ and to $0$ otherwise — is defined by recursion on its
  second argument using the predecessor function, and exponentiation
  by recursion using multiplication. Iterating these constructions
  yields all the usual elementary functions.
]

#example(name: "Primitive Recursive Examples")[
  The characteristic function of a relation is primitive recursive
  whenever the relation is decidable by a primitive recursive test;
  equality and order on $bb(N)$ are such relations:
  $"eq" (x, y) = 1$ iff $x = y$, and $"lt" (x, y) = 1$ iff $x < y$,
  via iteration of the predecessor. The factorial $x !$ satisfies
  $0 ! = 1$ and $(y + 1) ! = (y + 1) dot y !$.
] <ex:primitive-recursive-examples>

#note[
  Every primitive recursive function is total (defined on all of
  $bb(N)$), and the class is enormous — it contains every function
  ever needed in elementary number theory. Yet it is not all of
  computability: the Ackermann function, defined by the double
  recursion $A (0, y) = y + 1$, $A (x + 1, 0) = A (x, 1)$,
  $A (x + 1, y + 1) = A (x, A (x + 1, y))$, grows faster than any
  primitive recursive function and is therefore not primitive
  recursive, although it is perfectly computable. This motivates the
  larger class of the next section.
]

== Partial Recursive Functions and Church's Thesis // 部分递归函数与 Church 论题

The Ackermann example shows that primitive recursion is too narrow.
Adjoining the *minimalization operator* yields the full class of
computable functions — partial ones included.

#definition(name: "Minimalization")[
  For a partial function $g$ of arity $n + 1$, the function defined
  by *minimalization* is
  $
    f (x_1, dots, x_n) = mu y [g (x_1, dots, x_n, y) = 0],
  $
  the least $y$ such that $g (x_1, dots, x_n, y) = 0$ and all values
  $g (x_1, dots, x_n, z)$ with $z < y$ are defined and nonzero. If no
  such $y$ exists, $f (x_1, dots, x_n)$ is undefined.
] <def:mu-operator>

#eq[
  $
    f (x_1, dots, x_n) = mu y [g (x_1, dots, x_n, y) = 0].
  $
] <eq:mu-operator-def>

#definition(name: "Partial Recursive Functions")[
  A *partial recursive* function is one obtainable from the initial
  functions by finitely many applications of composition, primitive
  recursion, and minimalization. A partial recursive function that is
  total is *recursive* (or *computable*).
] <def:partial-recursive>

#definition(name: "Computable Function")[
  A total function $f : bb(N)^n -> bb(N)$ is *computable* if it is
  partial recursive. A relation is *decidable* if its characteristic
  function is computable, and *recursively enumerable* if it is the
  domain (or the range) of a partial recursive function.
] <def:computable-function>

#example(name: "Functions Defined by Minimalization")[
  Division with remainder: the quotient
  $"quot" (x, y) = mu z [x < y dot (z + 1)]$ with the convention
  $"quot" (x, 0) = 0$; the discrete logarithm
  $log_2 (x) = mu z [2^(z+1) > x]$; the square root
  $sqrt (x) = mu z [(z + 1)^2 > x]$. Each minimalization is bounded by
  the argument, so the resulting functions are total.
] <ex:mu-example>

#definition(name: "Church's Thesis")[
  *Church's thesis* is the assertion that the partial recursive
  functions — equivalently, any of the equivalent characterizations
  developed in this chapter — exhaust the intuitively computable
  functions.
] <def:church-thesis>

It is not a theorem of mathematics but a hypothesis about the
empirical notion of computation, confirmed by decades of convergent
evidence and universally accepted; its mathematical content lies in
the *equivalences* between the formal characterizations, one of which
is proved in the next section.

== Turing Machines and the Halting Problem // 图灵机与停机问题

The most concrete model of computation is Turing's: a finite control,
a tape, and a read-write head. The equivalence with partial recursive
functions is the bridge between the algebraic and the mechanical
view of computability.

#definition(name: "Turing Machine")[
  A *Turing machine* is a tuple
  $M = (Q, Sigma, Gamma, delta, q_0, F)$, where $Q$ is a finite set of
  states, $Sigma subset Gamma$ the input alphabet, $Gamma$ the tape
  alphabet containing the blank symbol $B$ (with $B in.not
  Sigma$), $q_0 in Q$ the initial state, $F subset Q$ the accepting
  states, and $delta$ a partial function
  $delta : Q times Gamma -> Q times Gamma times {L, R}$ (the
  transition function, $L$ and $R$ the head moves). A configuration
  is a word over $Gamma$ together with a state and a head position; a
  computation is a finite or infinite sequence of configurations
  obtained by applying $delta$. $M$ *halts* on input $x$ if the
  computation starting in the initial configuration reaches a
  configuration from which $delta$ is undefined (in particular, on
  accepting).
] <def:turing-machine>

#definition(name: "Turing-Computable Function")[
  A function $f$ is *Turing-computable* if there is a Turing machine
  $M$ such that, on input the (encoded) tuple $x_1, dots, x_n$, $M$
  halts with the (encoded) value $f (x_1, dots, x_n)$ written on the
  tape whenever $f$ is defined, and $M$ does not halt when it is
  undefined.
] <def:turing-computable>

#theorem(name: "Turing Machines and Partial Recursive Functions")[
  A function is Turing-computable if and only if it is partial
  recursive.
] <thm:turing-rosser-equivalence>

#proof[
  *Turing-computable implies partial recursive.* Encode configurations
  as natural numbers (the tape as a word over $Gamma$, the state and
  head position in the tuple). One verifies that the relation "the
  machine passes from configuration $c$ to configuration $c'$ in one
  step" is primitive recursive — it is a bounded search over the
  finite transition table — and that the configuration after $t$
  steps is a primitive recursive function of $t$. Whether a
  configuration is accepting is likewise primitive recursive, so the
  output function is obtained from these by minimalization over the
  halting time. *Partial recursive implies Turing-computable.* Each
  initial function is trivially a machine; composition, primitive
  recursion, and minimalization are simulated by composing machines,
  with the tape holding the intermediate values. The simulation is
  uniform: a machine is built by structural recursion on the
  definition of the function.
]

#theorem(name: "Undecidability of the Halting Problem")[
  There is no Turing machine that decides, given the code of a Turing
  machine $M$ and an input $x$, whether $M$ halts on $x$.
] <thm:halting-undecidable>

#proof[
  Fix a coding of Turing machines and inputs as natural numbers, and
  suppose a machine $H$ decides the halting problem: $H$ halts with
  1 on input $(angle M angle, x)$ iff $M$ halts on $x$, and with 0
  otherwise. Build the machine $D$: on input $angle M angle$,
  simulate $H$ on $(angle M angle, angle M angle)$; if $H$ outputs 1,
  $D$ enters an infinite loop, and if $H$ outputs 0, $D$ halts.
  Now run $D$ on its own code $angle D angle$: $D$ halts on
  $angle D angle$ iff $H$ outputs 0 on $(angle D angle, angle D
  angle)$ iff $D$ does not halt on $angle D angle$ — a contradiction.
]

#note[
  The halting problem is recursively enumerable (simulate machines in
  parallel and report those that halt) but not decidable; this is the
  canonical example of the gap between enumerability and decision,
  which recurs in §8.4 for the valid formulas of first-order logic.
]

== Undecidability of First-Order Logic // 一阶逻辑的不可判定性

We now connect computability with the logic of Part II. Two facts
converge: validity is recursively enumerable because of completeness
(promised at L1600), and — for languages rich enough to do
arithmetic — validity is not decidable. Figure 8.1 locates these
classes in the spectrum of computability.

#figure(
  image("img/computability-spectrum.svg", width: 72%),
  caption: [
    The spectrum of computability: decidable relations sit inside
    the total computable functions, which sit inside the partial
    recursive functions. The valid formulas of first-order logic are
    recursively enumerable but not decidable.
  ],
  placement: auto,
  supplement: [Fig.]
) <fig:computability-spectrum>

#definition(name: "Representable Functions")[
  Let $T$ be a theory in the language of arithmetic
  (#link(<ex:language-of-arithmetic>)[Example 3.1]) and let
  $f : bb(N)^n -> bb(N)$ be a total function. $f$ is *representable*
  in $T$ if there is a formula $phi (x_1, dots, x_n, y)$ such that
  for all $a_1, dots, a_n, b in bb(N)$,
  $f (a_1, dots, a_n) = b$ implies
  $T tack forall y (phi (a_1, dots, a_n, y) <=> y = b)$.
] <def:representable>

#eq[
  $
    f (a_1, dots, a_n) = b
    => T tack forall y (phi (a_1, dots, a_n, y) <=> y = b).
  $
] <eq:representability-def>

#lemma(name: "Representability of Computable Functions")[
  Every partial recursive function is representable in the theory of
  arithmetic ($"PA"$, or any consistent theory proving the basic
  arithmetic axioms used in the proof).
] <lem:recursive-representable>

#proof[
  *Outline.* Gödel's β-function trick encodes finite sequences of
  natural numbers into single numbers, so the "computation of $f$
  at step $t$" — a primitive recursive relation on codes — becomes an
  arithmetic formula; the initial functions, composition, primitive
  recursion, and minimalization are each translated into arithmetic
  definitions, and the defining equations of $f$ become theorems of
  $"PA"$. The claim that $f (a_1, dots, a_n) = b$ implies
  $T tack phi (a_1, dots, a_n, b)$ — and that $T$ proves the
  uniqueness of $b$ — follows by induction on the construction of
  $f$. The full details are the starting point of Ch 9.1
  (arithmetization).
]

#proposition(name: "Validity is Recursively Enumerable")[
  The set $"Val" = {phi : models phi}$ of valid formulas of
  first-order logic (in a finite signature) is recursively enumerable.
] <prop:r-e-closed>

#proof[
  By #link(<cor:completeness-form>)[completeness in consequence
  form], $phi$ is valid iff $tack phi$ is derivable in the Hilbert  system of Ch 5. Enumerate all finite sequences of formulas; each
  sequence is a derivation iff a primitive recursive check of the
  axioms and rules succeeds, so the set of derivable formulas is the
  range of a partial recursive function enumerating valid proofs —
  hence recursively enumerable.
]

#theorem(name: "Church's Theorem: Undecidability of Validity")[
  The set of valid formulas of first-order logic in the language of
  arithmetic is not decidable.
] <thm:first-order-undecidable>

#proof[
  It suffices to reduce the halting problem to validity. Fix an
  enumeration of Turing machines $M_e$ by code $e$. By
  #link(<lem:recursive-representable>)[representability], there is a
  formula $theta (x, y, z)$ such that, for each $e$ and each input
  $x$, "$M_e$ halts on $x$" is equivalent to
  $exists y theta (e, x, y)$ being true in the standard model.
  Moreover representability plus completeness
  gives: $M_e$ halts
  on $x$ iff $models exists y theta (e, x, y)$ — the sentence is
  *valid*, not merely true, because $exists y theta (e, x, y)$ is
  provable whenever it holds. If validity were decidable, the halting
  problem would be decidable, contradicting
  #link(<thm:halting-undecidable>)[the undecidability of the halting
  problem].
]

#proposition(name: "Decidable Theories versus Validity")[
  The theories DLO and ACF are decidable (quantifier elimination,
  Ch 7 §7.4), while validity in any language containing arithmetic is
  undecidable. The decision problem of a specific theory is
  *easier* than the validity problem: a theory decides its own
  sentences, whereas validity ranges over all formulas of a rich
  language.
] <prop:effective-enumerable>

#note[
  The results of this section are the pivot to Ch 9: representability
  is exactly the "arithmetization" needed for Gödel's
  incompleteness theorems, and the recursive enumerability of
  validity underlies the second incompleteness theorem (no consistent
  theory can prove its own consistency — the consistency statement,
  though true, escapes provability). First-order logic is
  complete, enumerable, and undecidable — the three properties
  together delimit the metamathematics of Part III.
]

= Gödel's Incompleteness Theorems  // Gödel 不完备定理

Chapter 8 proved that computability is faithfully mirrored inside
arithmetic: every partial recursive function is representable, and
validity is enumerable but undecidable. This chapter turns the mirror
onto logic itself. Gödel's central discovery is that *provability* —
not just computability — can be expressed by an arithmetic formula;
once provability lives inside the language, the theory can talk about
its own proofs, and a self-referential sentence escapes them. The
chapter closes Part III with the two limits of formal proof:
incompleteness (Gödel) and the undefinability of truth (Tarski).

== Arithmetization of Syntax // 语法算术化

The first step is to code the syntax of the language — symbols,
formulas, and proofs — by natural numbers, so that the metalanguage
becomes part of the object language. This is *arithmetization*.

#definition(name: "Gödel Numbering")[
  Fix an enumeration of the symbols of the language of arithmetic
  (#link(<ex:language-of-arithmetic>)[Example 3.1]) and of the
  variables. The *Gödel number* of an expression $e = s_1 s_2 dots.c
  s_k$ (a sequence of symbols) is
  $
    angle e angle = product_(i = 1)^k p_i^(c_i),
  $
  where $p_i$ is the $i$-th prime and $c_i$ the code of the symbol
  $s_i$. The Gödel number of a *proof* is the Gödel number of the
  sequence of its formulas. The function $e |-> angle e angle$ is
  injective, and the basic syntactic predicates ("$x$ is a formula",
  "$x$ is a term", "$x$ is a proof of $y$") are primitive recursive.
] <def:godel-numbering>

#eq[
  $
    angle e angle = product_(i = 1)^k p_i^(c_i).
  $
] <eq:godel-numbering-def>

#example(name: "The Gödel Number of a Formula")[
  Suppose $0$, $=$, and the variable $x_1$ receive codes $1$, $5$,
  and $9$ respectively. Then
  $angle 0 = x_1 angle = 2^1 dot 3^5 dot 5^9$,
  a number with more than $2.5 times 10^6$ digits. The enormous size
  is irrelevant: the coding is *effective* in the sense that decoding
  is a primitive recursive computation, and it is *unique* in the
  sense that distinct expressions receive distinct numbers.
] <ex:godel-number-example>

#theorem(name: "Gödel's β-Function")[
  There is a primitive recursive function $beta (a, b, i)$ such that
  for every finite sequence of natural numbers
  $n_0, dots, n_k$ there exist $a, b$ with
  $beta (a, b, i) = n_i$ for all $i <= k$.
] <thm:beta-function>

#proof[
  *Step 1: definition.* Let $beta (a, b, i)$ be the remainder of $a$
  upon division by $1 + (i + 1) b$:
  $
    beta (a, b, i) = a mod (1 + (i + 1) b),
  $
  a primitive recursive function of $(a, b, i)$ by the results of
  §8.1.

  *Step 2: surjectivity onto finite sequences.* Given
  $n_0, dots, n_k$, choose $b$ divisible by $k + 1$! and so large
  that the numbers $d_i = 1 + (i + 1) b$ are pairwise coprime (they
  are: any prime dividing both $d_i$ and $d_j$ with $i < j$ divides
  $(j - i) b$, hence divides $b$, contradicting the coprimality built
  into the choice of $b$). Then, by the Chinese remainder theorem,
  there is an $a$ satisfying
  $a equiv n_i quad ("mod" d_i)$ for every $i <= k$, which is exactly
  $beta (a, b, i) = n_i$.
]

#definition(name: "Provability Predicate")[
  Let $"Proof" (y, x)$ be the primitive recursive relation "$y$ is
  the Gödel number of a proof of the formula with Gödel number $x$"
  and define the *provability predicate*
  $
    "Bew" (x) :<=> exists y "Proof" (y, x).
  $
  By #link(<lem:recursive-representable>)[Lemma 8.1], the relation
  $"Proof"$ is representable in $"PA"$, hence $"Bew" (x)$ is a
  $Sigma_1$ formula of the language of arithmetic satisfying, for
  every sentence $phi$,
  $
    "PA" tack phi <=> bb(N) models "Bew" (angle phi angle).
  $
] <def:provability-predicate>

#eq[
  $
    "PA" tack phi <=> bb(N) models "Bew" (angle phi angle).
  $
] <eq:provability-def>

#note[
  The equivalence just displayed is the content of arithmetization: the
  metamathematical fact "$phi$ is provable" has become a *truth of
  arithmetic* about the number $angle phi angle$. Gödel's revolution
  is precisely this collapse of levels — the theory of numbers now
  contains a formula that speaks about the theory's own proofs, and
  it is on this self-reference that the next sections build.
]

== The First Incompleteness Theorem // 第一不完备定理

With provability expressible inside the language, we can construct a
sentence that asserts its own unprovability. The engine is the
*diagonalization lemma* — the arithmetic form of self-reference,
diagrammed in Figure 9.1.

#figure(
  image("img/godel-self-reference.svg", width: 72%),
  caption: [
    The self-reference loop: a formula $phi$ is coded by the number
    $angle phi angle$; the provability predicate $"Bew"$ applies to
    codes; diagonalization feeds a formula its own code, producing
    the Gödel sentence $G :<=> not "Bew" (angle G angle)$ — true in
    $bb(N)$ but unprovable in $"PA"$.
  ],
  placement: auto,
  supplement: [Fig.]
) <fig:godel-self-reference>

#lemma(name: "Diagonalization Lemma")[
  For every formula $psi (x)$ with one free variable there is a
  sentence $G$ such that
  $
    "PA" tack G <=> psi (angle G angle).
  $
] <lem:diagonalization>

#eq[
  $
    "PA" tack G <=> psi (angle G angle).
  $
] <eq:diagonalization-def>

#proof[
  *Step 1: the substitution function.* Let $"sub" (m, n)$ be the
  Gödel number of the expression obtained from the formula with code
  $m$ by replacing the free variable with the numeral for $n$. The
  function $"sub"$ is primitive recursive (it is a bounded
  computation over the coding of §9.1).

  *Step 2: diagonalization.* Let $d (x) = "sub" (x, x)$. For a fixed
  $psi$, put
  $G := psi (d (angle psi (d (x)) angle))$.
  Then $angle G angle = d (angle psi (d (x)) angle)$, and since
  $d (angle psi (d (x)) angle) = "sub" (angle psi (d (x)) angle,
  angle psi (d (x)) angle)$ is the Gödel number of $psi$ applied to
  the numeral of its own code,
  $G$ is the sentence $psi (angle G angle)$. The equivalence
  $G <=> psi (angle G angle)$ is provable in $"PA"$, which formalizes
  the computation of $"sub"$ (representability of primitive
  recursion, §8.4).
]

#theorem(name: "Gödel's First Incompleteness Theorem")[
  If $"PA"$ is consistent and $omega$-consistent, there is a
  sentence $G$ of arithmetic such that neither $G$ nor $not G$ is
  provable in $"PA"$. The sentence $G$ is true in the standard model.
] <thm:first-incompleteness>

#proof[
  Apply #link(<lem:diagonalization>)[Lemma 9.1] to
  $psi (x) = not "Bew" (x)$ and obtain
  $
    "PA" tack G <=> not "Bew" (angle G angle).
  $
  ($omega$-consistency is the condition: whenever $"PA"$ proves
  $exists x phi (x)$, it fails to prove $not phi (overline(n))$ for
  every numeral $overline(n)$; it implies consistency.)

  *Step 1: $G$ is not provable.* Suppose $"PA" tack G$. Then by the
  provability equivalence
  $bb(N) models "Bew" (angle G angle)$, and by
  #link(<lem:recursive-representable>)[Lemma 8.1] this truth is
  proved by $"PA"$: $"PA" tack "Bew" (angle G angle)$. But $"PA"$
  also proves $not "Bew" (angle G angle)$ (the equivalence), so
  $"PA"$ is inconsistent — contradiction.

  *Step 2: $not G$ is not provable.* Suppose $"PA" tack not G$, i.e.
  $"PA" tack "Bew" (angle G angle)$ by the equivalence. If some
  numeral $overline(n)$ satisfied $"Proof" (overline(n), angle G
  angle)$, representability would give
  $"PA" tack "Proof" (overline(n), angle G angle)$, hence
  $"PA" tack "Bew" (angle G angle)$ and, with the equivalence,
  $"PA" tack G$ — contradicting Step 1. So for every $n$,
  $bb(N) models not "Proof" (overline(n), angle G angle)$, and by
  representability $"PA" tack not "Proof" (overline(n), angle G
  angle)$ for every $n$. By $omega$-consistency,
  $"PA" tack.not exists y "Proof" (y, angle G angle)$, i.e.
  $"PA" tack not "Bew" (angle G angle)$, i.e. $"PA" tack G$ by the
  equivalence — again contradicting Step 1. Hence $not G$ is not
  provable.

  *Truth of $G$.* Since $"PA"$ does not prove $G$, no numeral codes a
  proof of $G$, so $bb(N) models not "Bew" (angle G angle)$ and
  therefore $bb(N) models G$ by the equivalence. The sentence that
  says "I am not provable" is *true* — and unprovable.
]

#corollary(name: "Incompleteness of Peano Arithmetic")[
  $"PA"$ is incomplete: there are sentences of arithmetic (such as
  $G$) that are neither provable nor refutable in $"PA"$.
] <cor:incompleteness-of-pa>

#theorem(name: "Peano Arithmetic is Not Categorical")[
  $"PA"$ is not categorical: there are two countable models of
  $"PA"$ that are not elementarily equivalent, in particular models
  not isomorphic to $bb(N)$.
] <thm:pa-not-categorical>

#proof[
  A complete theory decides every sentence: for each $phi$, either
  $phi$ or $not phi$ is provable, hence either holds in all models or
  fails in all models — all models are elementarily equivalent. By
  #link(<cor:incompleteness-of-pa>)[Corollary 9.1], $"PA"$ is not
  complete, so it has two models $M_1, M_2$ disagreeing on some
  sentence; by #link(<thm:downward-ls>)[the downward
  Löwenheim–Skolem theorem] they may be taken countable, and they are
  not elementarily equivalent, hence not isomorphic.
]

#example(name: "Nonstandard Models Revisited")[
  The incompleteness of $"PA"$ and its nonstandard models are two
  faces of the same phenomenon (promised at L1423 and in §6.3). The
  Gödel sentence $G$ is true in $bb(N)$; by
  #link(<cor:model-existence>)[the model existence theorem], the
  consistent theory $"PA" union {not G}$ has a model $M$, necessarily
  nonstandard. In $M$ the sentence $"Bew" (angle G angle)$ holds, yet
  no *standard* natural number codes a proof of $G$ — the witnessing
  "proof" must be a nonstandard element, a code of infinite
  "length" in the internal sense. Incompleteness and nonstandardness
  are inseparable: any consistent extension of $"PA"$ that is
  incomplete (and every consistent r.e. extension is, by Rosser's
  strengthening) admits nonstandard models, and the fine structure of
  those models — first glimpsed with compactness in §6.3 and
  ultraproducts in §7.2 — is what the provability predicate looks
  like from inside.
] <ex:nonstandard-reprise>

#note[
  *Rosser's strengthening.* Gödel's proof uses $omega$-consistency
  only to rule out $"PA" tack not G$. Rosser replaced $G$ by a
  sentence asserting "any proof of me is outnumbered by a shorter
  refutation of me", which separates proofs of $G$ from proofs of
  $not G$ inside the arithmetic; with it, *consistency* alone
  suffices for the first incompleteness theorem. The sharper theorem
  holds for every consistent recursively enumerable extension of
  $"PA"$.
]

== The Second Incompleteness Theorem // 第二不完备定理

The first theorem shows that a sentence speaking about its own
provability escapes proof. The second theorem shows that the
*consistency of arithmetic* is such a sentence: the theory cannot
prove its own consistency. The argument formalizes the first theorem
inside $"PA"$, which requires the provability predicate to satisfy
three *derivability conditions*.

#lemma(name: "Derivability Conditions")[
  The provability predicate $"Bew"$ of §9.1 satisfies, provably in
  $"PA"$:
  $
    "(D1)" quad "PA" tack phi => "PA" tack "Bew" (angle phi angle),
  $
  $
    "(D2)" quad "PA" tack "Bew" (angle phi -> psi angle)
    -> ("Bew" (angle phi angle) -> "Bew" (angle psi angle)),
  $
  $
    "(D3)" quad "PA" tack "Bew" (angle phi angle)
    -> "Bew" (angle "Bew" (angle phi angle) angle).
  $
] <lem:derivability-conditions>

#proof[
  *D1* is representability applied to $"Proof"$
  (#link(<lem:recursive-representable>)[Lemma 8.1]): if $"PA"$
  proves $phi$, some numeral $overline(n)$ satisfies
  $"Proof" (overline(n), angle phi angle)$ in $bb(N)$, hence this
  fact is provable in $"PA"$, so $"PA" tack exists y "Proof" (y,
  angle phi angle)$, i.e. D1.

  *D2* formalizes modus ponens inside the coding: given Gödel numbers
  of proofs of $phi -> psi$ and of $phi$, concatenating them (a
  primitive recursive operation on codes, §9.1) yields a proof of
  $psi$; the implication is provable by the representability of this
  concatenation operation.

  *D3* is D1 *formalized*: the proof of D1 is uniform in $phi$ and
  itself a mathematical argument, which $"PA"$ can carry out for the
  formula $"Bew" (angle phi angle)$ in place of $phi$. This is the
  deepest of the three conditions — it says the theory knows that it
  proves what it proves.
]

#definition(name: "Consistency Sentence")[
  The *consistency sentence* of $"PA"$ is
  $
    "Con"("PA") :<=> not "Bew" (angle bot angle),
  $
  the arithmetic statement "there is no proof of the false sentence
  $bot$".
] <def:con-sentence>

#theorem(name: "Gödel's Second Incompleteness Theorem")[
  If $"PA"$ is consistent, then
  $
    "PA" tack.not "Con"("PA").
  $
] <thm:second-incompleteness>

#proof[
  Let $G$ be the Gödel sentence, $"PA" tack G <=> not "Bew" (angle G
  angle)$.

  *Step 1: formalizing the first theorem.* The argument of
  #link(<thm:first-incompleteness>)[Theorem 9.2] that "if $"PA"$ is
  consistent then $G$ is not provable" is a proof in ordinary
  mathematics about $"PA"$; inspecting it, every step is itself
  formalizable in $"PA"$ using (D1)–(D3) — the first theorem is
  provable *inside* $"PA"$. Hence
  $
    "PA" tack "Con"("PA") -> not "Bew" (angle G angle).
  $

  *Step 2: consistency implies $G$.* From Step 1 and the defining
  equivalence of $G$,
  $
    "PA" tack "Con"("PA") -> G.
  $

  *Step 3: contradiction.* If $"PA" tack "Con"("PA")$, then Step 2
  gives $"PA" tack G$, contradicting
  #link(<thm:first-incompleteness>)[Theorem 9.2]. Therefore
  $"PA" tack.not "Con"("PA")$.
]

#corollary(name: "Consistency of Richer Theories")[
  The same proof applies to any consistent recursively enumerable
  extension $T$ of $"PA"$ (with its consistency sentence
  $"Con"(T)$): $T tack.not "Con"(T)$. In particular, no consistent
  theory that can do arithmetic proves its own consistency.
] <cor:consistency-unprovable>

#note[
  *Löb's theorem.* The second theorem is the special case
  $phi = bot$ of a stronger principle: if
  $"PA" tack "Bew" (angle phi angle) -> phi$, then
  $"PA" tack phi$ — the only sentences the theory can prove "safe"
  are those it actually proves. The philosophical upshot (recalling
  §8.4, where recursive enumerability made $"Bew"$ possible at all):
  Hilbert's program of justifying mathematics by a *finitistic*
  consistency proof cannot be carried out within the theory itself;
  consistency of a rich theory can only be established in a stronger
  theory (relative consistency), a hierarchy without bottom.
]

== Tarski's Undefinability of Truth // 真值不可定义性

Gödel's theorems concern *provability*, a syntactic notion coded by
the arithmetic formula $"Bew"$. Tarski's theorem concerns *truth*
itself: no arithmetic formula can define the set of true sentences.
The proof is the diagonalization lemma applied to a truth predicate —
the liar paradox, formalized.

#definition(name: "Truth Predicate")[
  A formula $T (x)$ of the language of arithmetic is a *truth
  predicate* for arithmetic if it satisfies the *Tarski
  biconditionals*: for every sentence $phi$ of the language,
  $
    bb(N) models T (angle phi angle) <=> bb(N) models phi.
  $
] <def:truth-predicate>

#theorem(name: "Tarski's Undefinability Theorem")[
  No formula $T (x)$ of the language of arithmetic defines truth:
  there is no truth predicate for arithmetic.
] <thm:tarski-undefinability>

#proof[
  Suppose $T (x)$ satisfies the Tarski biconditionals. Apply
  #link(<lem:diagonalization>)[Lemma 9.1] to $not T (x)$: there is a
  sentence $L$ (the *liar sentence*) such that
  $
    bb(N) models L <=> not T (angle L angle).
  $
  By the Tarski biconditional applied to $L$,
  $bb(N) models T (angle L angle) <=> bb(N) models L$, so
  $bb(N) models T (angle L angle) <=> not T (angle L angle)$ — a
  contradiction. Hence no such $T$ exists.
]

#note[
  *Provability versus truth.* The contrast sharpens the two limits of
  Part III. The Gödel sentence $G$ says "I am not provable": it is
  *true but unprovable* — provability is expressible, yet incomplete.
  The liar sentence $L$ says "I am false": it can exist only because
  *truth is not expressible at all*. Formally, $bb(N) models G$ and
  $"PA" tack.not G$ (an internal, syntactic gap); $T$ cannot even be
  defined (a semantic, expressive gap). This is why the true sentences
  of arithmetic — recall the definable sets of §6.4 — form no
  definable set: the set of Gödel numbers of true sentences is
  undefinable in the standard model, a far stronger failure than
  undecidability (Ch 8), which concerns provability rather than
  truth.
]

#part("Extensions")  // 扩展：二阶逻辑与非经典逻辑

= Second-Order Logic  // 二阶逻辑

Chapter 9 located the limits of first-order logic: every consistent
r.e. extension of arithmetic is incomplete, and truth is not
definable. This chapter asks whether a *stronger* logic can escape
those limits. It can — at a price. Allowing quantifiers over
relations and functions (*second-order logic* with *standard
semantics*) pins down the structure of arithmetic completely, but the
metatheorems of Part II collapse: compactness, completeness, and the
Löwenheim–Skolem theorems all fail. The trade is best read as a
single moral: the model class and the metatheory are bought and sold
together.

== Syntax and Semantics // 二阶语法与语义

Second-order logic adds to a first-order signature (#link(<def:signature>)[Definition 3.1])
new *variables* ranging over relations and functions, with their own
quantifiers.

#definition(name: "Second-Order Language")[
  Let $L$ be a first-order signature. The *second-order language*
  $L_2$ adds to the terms and formulas of $L$:
  - relation variables $X_1^n, X_2^n, dots$ and function variables
    $F_1^n, F_2^n, dots$ of every arity $n >= 1$;
  - atomic formulas $X_i^n (t_1, dots, t_n)$ and terms
    $F_i^n (t_1, dots, t_n)$;
  - second-order quantifiers: if $phi$ is a formula, so are
    $
      forall X_i^n phi, quad exists X_i^n phi,
      quad forall F_i^n phi, quad exists F_i^n phi.
    $
  The notions of free and bound variable extend in the obvious way
  (variables bound by second-order quantifiers are second-order
  variables).
] <def:second-order-language>

#eq[
  $
    forall X^n phi, quad exists X^n phi.
  $
] <eq:second-order-quantifier>

#definition(name: "Standard Structure and Standard Semantics")[
  A *standard structure* for $L_2$ is a first-order structure
  #link(<def:structure>)[$M = (A, dots)$] for the underlying
  signature $L$. In *standard semantics*, a relation variable $X^n$
  ranges over *all* subsets of $A^n$, a function variable $F^n$
  over *all* functions $A^n -> A$, and the satisfaction relation
  (#link(<def:satisfaction>)[Definition 4.2]) is extended by
  $
    M models forall X^n phi
    <=> M models phi [X^n / R]
    " for every " R subset A^n,
  $
  and similarly for $exists$, $F^n$, and all functions $A^n -> A$.
] <def:standard-structure>

#proposition(name: "Second-Order Definability")[
  A property is *second-order definable* in the standard semantics
  if it is expressible by a second-order formula. Second-order
  quantifiers can scan all subsets, so structural properties that
  first-order logic cannot express become definable: finiteness,
  well-ordering, completeness, and the natural numbers themselves.
] <prop:second-order-definability-basics>

#example(name: "Second-Order Definitions")[
  - *Infinity.* A set $A$ is infinite iff it admits an injective
    non-surjective self-map:
    $
      exists F forall x forall y (F x = F y -> x = y)
      and exists z forall x (F x != z).
    $
    No first-order sentence has this property in every model
    (#link(<prop:finitude-not-axiomatizable>)[Proposition 6.1]).
  - *Finite.* $A$ is finite iff the negation of the above holds.
  - *Well-ordering.* A linear order is a well-order iff every
    nonempty subset has a least element:
    $
      forall X (exists x X x -> exists x (X x and forall y (X y -> x <= y))).
    $
  - *Completeness of the reals.* The Dedekind completeness axiom —
    every nonempty bounded subset has a least upper bound — is a
    single second-order sentence; it is the content of
    #link(<ex:connectedness-not-axiomatizable>)[Example 6.3] that no
    first-order theory can express it.
] <ex:second-order-definable-examples>

#note[
  The price of this expressive power is already visible in §10.4: a
  second-order sentence that *pins down* $bb(N)$ also encodes all
  true arithmetic, and by #link(<thm:tarski-undefinability>)[Tarski's
  theorem] no r.e. set of formulas can capture that. Expressiveness
  and metatheory move inversely.
]

== Standard vs. Henkin Semantics // 标准语义 vs Henkin 语义

The failures of §10.3 all stem from one feature of standard
semantics: the second-order quantifiers range over the *full* power
set, which is too rich to be controlled by syntax. Henkin's remedy is
to treat the second-order objects as ordinary elements of a
first-order structure — to *first-orderize* the logic.

#definition(name: "Henkin Structure")[
  A *Henkin structure* for $L_2$ is a first-order structure
  $M = (A, S, I)$ where $S$ is a nonempty set of relations and
  functions on $A$ (the *second-order domain*), and the
  second-order quantifiers range only over $S$:
  $
    M models forall X^n phi
    <=> M models phi [X^n / R]
    " for every " R in S.
  $
  A Henkin structure is *full* if $S$ contains all relations and
  functions on $A$ — exactly the standard case.
] <def:henkin-structure>

#theorem(name: "Henkin Completeness for Second-Order Logic")[
  Second-order logic with Henkin semantics is complete: a sentence
  $phi$ is valid in all Henkin structures iff it is provable in a
  natural second-order Hilbert system extending that of Ch 5.
] <thm:henkin-completeness-so>

#proof[
  *Outline.* The Henkin structure is an ordinary first-order
  structure in a two-sorted signature: one sort for individuals, one
  sort for the elements of $S$, with an evaluation relation
  $\in$ linking them. The second-order quantifiers become first-order
  quantifiers over the second sort, so a derivation in the
  second-order Hilbert system is a derivation in a first-order
  system, and the Henkin proof of Ch 5
  (#link(<thm:henkin-completeness>)[Theorem 5.1]) applies verbatim:
  Lindembaum, Henkin constants, the term model, the truth lemma. The
  details are exactly those of Ch 5 with the second sort carried
  along.
]

#note[
  The two semantics are therefore two different logics wearing the
  same syntax. With Henkin semantics the classical metatheory of
  Part II survives intact (compactness, L-S, completeness all hold),
  but categoricity is lost: a Henkin structure can cut $S$ down
  arbitrarily, so $"PA"_2$ admits many non-isomorphic Henkin models.
  With standard semantics the metatheory collapses but the structures
  are pinned down (§10.4). This is the whole trade, in miniature.
  Figure 10.1 summarizes the three logics side by side.
]

#figure(
  image("img/second-order-vs-first-order.svg", width: 82%),
  caption: [
    Three logics, five properties. First-order logic and Henkin
    second-order logic share the classical metatheory; standard
    second-order logic trades compactness, completeness, and
    Löwenheim–Skolem for categoricity of $"PA"_2$.
  ],
  placement: auto,
  supplement: [Fig.]
) <fig:second-order-vs-first-order>

== Failure of Compactness and Completeness // 紧致性与完全性失效

With standard semantics, the three pillars of the first-order
metatheory — compactness, completeness, and the Löwenheim–Skolem
theorems — all fail. Each failure is a facet of the same fact: the
full power set cannot be controlled by finitary syntax.

#theorem(name: "Failure of Compactness")[
  Second-order logic with standard semantics is not compact: there
  is a set $Sigma$ of second-order sentences such that every finite
  subset of $Sigma$ has a model but $Sigma$ itself has none.
] <thm:compactness-fails-so>

#proof[
  Let $"Inf"$ be the second-order sentence of
  #link(<ex:second-order-definable-examples>)[Example 10.1] asserting
  that the domain is infinite, and let $sigma_n$ be the first-order
  sentence "there are at least $n$ elements", for $n >= 2$. Put
  $
    Sigma = {not "Inf"} union {sigma_n : n >= 2}.
  $
  Every finite subset of $Sigma$ contains $not "Inf"$ and finitely
  many $sigma_n$; it is satisfied by any finite model with at least
  the required number of elements. But $Sigma$ itself has no model: a
  model of $not "Inf"$ is finite, while a model of all $sigma_n$ is
  infinite. The compactness theorem of
  #link(<thm:compactness>)[Ch 6] therefore fails for standard
  semantics (promised at L2015).
]

#theorem(name: "Failure of Completeness")[
  The set of valid second-order sentences (standard semantics) is
  not recursively enumerable: second-order logic has no complete,
  effective proof system.
] <thm:completeness-fails-so>

#proof[
  By #link(<thm:categoricity-so-arithmetic>)[the categoricity of
  second-order arithmetic] (§10.4), every standard model of $"PA"_2$
  is isomorphic to $bb(N)$, so for every arithmetic sentence $phi$,
  $
    "PA"_2 models phi <=> bb(N) models phi,
  $
  and, by #link(<thm:deduction-theorem-fol>)[the deduction theorem],
  $phi$ is a valid consequence of $"PA"_2$ iff it is true in
  $bb(N)$. If validity were recursively enumerable, the set of true
  arithmetic sentences would be recursively enumerable, hence
  $Sigma_1$-definable, contradicting
  #link(<thm:tarski-undefinability>)[Tarski's undefinability theorem]
  (Ch 9). So the set of valid second-order sentences is not
  recursively enumerable, and no effective proof system is complete
  for it.
]

#theorem(name: "Failure of Löwenheim–Skolem")[
  The downward and upward Löwenheim–Skolem theorems
  (#link(<thm:downward-ls>)[Theorem 6.2],
  #link(<thm:upward-ls>)[Theorem 6.3]) fail for second-order logic
  with standard semantics: $"PA"_2$ has a countable model but no
  uncountable one.
] <thm:ls-fails-so>

#proof[
  $bb(N)$ is a countable model of $"PA"_2$. By
  #link(<thm:categoricity-so-arithmetic>)[the categoricity theorem]
  (§10.4) every model of $"PA"_2$ is isomorphic to $bb(N)$, hence
  countable — so no uncountable model exists, and neither the
  downward nor the upward theorem can hold.
]

#corollary(name: "Consequence is Not Enumerable")[
  The consequence relation of second-order logic (standard
  semantics) is not recursively enumerable, in sharp contrast to
  first-order logic, where validity is r.e.
  (#link(<prop:r-e-closed>)[Proposition 8.1]).
] <cor:consequence-not-enumerable>

== Categoricity of Second-Order Arithmetic // 二阶算术的范畴性

The failures of §10.3 are the price of a success: second-order
arithmetic pins down $bb(N)$ exactly. The induction axiom, which in
first-order logic is an infinite scheme, becomes a single sentence,
and it is strong enough to make every model isomorphic.

#definition(name: "Second-Order Arithmetic")[
  *Second-order arithmetic* $"PA"_2$ is the second-order theory in
  the language of arithmetic whose axioms are the Peano axioms of
  #link(<ex:language-of-arithmetic>)[Example 3.1] — successor,
  addition, multiplication — together with the *second-order
  induction axiom*
  $
    forall X [(X (0) and forall x (X x -> X (S x))) -> forall x X x].
  $
] <def:second-order-arithmetic>

#eq[
  $
    forall X [(X (0) and forall x (X x -> X (S x))) -> forall x X x].
  $
] <eq:pa2-axioms>

#theorem(name: "Categoricity of Second-Order Arithmetic")[
  All standard models of $"PA"_2$ are isomorphic; in particular,
  every model of $"PA"_2$ is isomorphic to $bb(N)$.
] <thm:categoricity-so-arithmetic>

#proof[
  *Step 1: the map.* Let $M$ and $N$ be standard models of $"PA"_2$.
  Define the relation $f subset M times N$ by the recursive clauses
  $f (0^M) = 0^N$ and $f (S^M x) = S^N f (x)$.

  *Step 2: $f$ is defined on all of $M$.* Let
  $X = {x in M : f (x) " is defined"}$. Then $0^M in X$, and
  $x in X$ implies $S^M x in X$; by the second-order induction axiom
  applied in $M$, $X = M$.

  *Step 3: $f$ is injective.* Let
  $Y = {x in M : f " is injective on " {z : z <=_M x}}$ — a
  second-order definable set. $0^M in Y$ (no earlier elements), and
  if $x in Y$ then $S^M x in Y$: two elements $u, v <=_M S^M x$
  with $f (u) = f (v)$ lie in ${z : z <=_M x}$ unless one is
  $S^M x$, in which case $u = S^M z$ and $f (u) = S^N f (z)$, and
  injectivity of $S^N$ forces the missing case into the induction
  hypothesis. So $Y = M$ and $f$ is injective.

  *Step 4: $f$ is surjective.* Let
  $Z = {y in N : exists x in M f (x) = y}$. Then $0^N in Z$, and
  $y in Z$ with $y = f (x)$ gives $S^N y = f (S^M x) in Z$; the
  induction axiom in $N$ yields $Z = N$.

  The map $f$ is therefore a bijection preserving $0$, $S$, and —
  by induction, as in §10.1 — the recursive definitions of $+$ and
  $dot$; it is an isomorphism.
]

#corollary(name: "Gödel's Theorems in Second-Order Disguise")[
  The Gödel sentence $G$ of Chapter 9 is a *logical consequence* of
  $"PA"_2$ (in standard semantics): $"PA"_2 models G$. But no r.e.
  theory captures that consequence relation
  (#link(<thm:completeness-fails-so>)[Theorem 10.2]): the semantic
  completeness of the model class and the syntactic incompleteness
  of every effective axiom system are two sides of the same coin
  (promised at L2549).
] <cor:godel-fails-so>

#example(name: "No Nonstandard Models")[
  In first-order arithmetic, compactness produces nonstandard models
  (#link(<ex:nonstandard-arithmetic>)[Example 6.2]) and incompleteness
  forces them (Chapter 9, Example 9.2). Second-order arithmetic has
  none: the second-order induction axiom excludes every nonstandard
  element, because the set of standard elements it generates is a
  definable subset. The nonstandard universe of §6.3, §7.2, and §9.2
  is precisely the territory that first-order logic opens up and that
  second-order logic — at the price of losing all its metatheorems —
  closes off.
] <ex:nonstandard-excluded>

#note[
  *Second-order logic and set theory.* Standard semantics quantifies
  over the full power set, so the truth value of a second-order
  sentence depends on which sets exist — on the ambient set theory
  (ZFC). Quine's quip that second-order logic is "set theory in
  sheep's clothing" is exactly this: what looks like a logic is a
  theory of $P (A)$ smuggled in through the semantics. Henkin
  semantics (§10.2) removes the dependence by making the second-order
  domain part of the model. This is also the hinge to Chapter 11:
  non-classical logics generalize the *semantics* rather than the
  syntax, exactly as Henkin generalized the models of Ch 5.
]

= Non-Classical Logics: An Introduction // 非经典逻辑导论

Classical first-order logic is not the only logic: it is one
particular choice of semantics. The three systems of this chapter
keep the syntax of Ch 1 and change the meaning of truth.
Intuitionistic logic constrains the truth functions (truth becomes
constructive provability), modal logic makes truth world-relative
(what is true depends on which possible world we are in), and
many-valued logic replaces the set of truth values. The metatheorems
of Part II — completeness, compactness, Löwenheim–Skolem — are
properties of a *semantics*, not of logic as such: change the
semantics and the metatheory changes with it, exactly as it did for
standard vs. Henkin semantics in Ch 10. This chapter keeps every
proof short and every technical completeness proof at the level of a
sketch, in the spirit of §10.2.

== Intuitionistic Logic and Kripke Semantics // 直觉主义逻辑与 Kripke 语义

Intuitionism, founded by Brouwer, refuses to treat a mathematical
statement as true unless it has a construction behind it. The law of
excluded middle $phi or not phi$ is rejected: "either $phi$ holds
or its negation holds" is a claim about a fact of the matter that,
for an intuitionist, has not been exhibited. What makes the
rejection formal is that it is not a philosophical footnote: the
logic obtained by dropping the law from Ch 1 has a semantics of its
own, and that semantics is the modern (Kripke's, 1965) formulation
of "truth as knowledge growth".

#definition(name: "Intuitionistic Propositional Calculus")[
  The *intuitionistic propositional calculus* $"IPC"$ is the
  Hilbert-style system of Ch 1 whose axioms are the standard schemes
  for implication, conjunction, and disjunction, the two negation
  schemes
  $
    (phi -> psi) -> ((phi -> not psi) -> not phi),
    quad not phi -> (phi -> psi),
  $
  and the rule of modus ponens — but *without* the law of excluded
  middle $phi or not phi$. Classical propositional logic is exactly
  $"IPC"$ plus the law of excluded middle (or, equivalently, plus
  double negation elimination $not not phi -> phi$).
] <def:intuitionistic-axioms>

#example(name: "Classical Validities that are not Intuitionistic")[
  The law of excluded middle $p or not p$ and double negation
  elimination $not not p -> p$ are theorems of classical logic
  (#link(<cor:double-negation>)[Corollary 1.1]) but are not theorems
  of $"IPC"$: both are equivalent to the excluded middle over $"IPC"$
  and the scheme is exactly what we dropped. Peirce's law
  $((p -> q) -> p) -> p$ is classical (it is equivalent to excluded
  middle) but fails intuitionistically. The classical proof that there
  exist irrational $a, b$ with $a^b$ rational — take
  $sqrt(2)^(sqrt(2))$ and argue by cases — is non-constructive: the
  proof shows that *one of* two numbers works without saying which.
] <ex:constructive-examples>

Truth tables cannot describe this logic. A two-valued valuation
fixes every formula absolutely; but intuitionistic truth is not
absolute, it grows. The insight that makes the semantics
mathematical is due to Kripke: a formula is true at a *stage* of
information, and later stages may verify more atoms.

#definition(name: "Kripke Frames and Models")[
  An *intuitionistic Kripke frame* is a nonempty poset $(W, <=)$;
  its elements are *worlds* or *stages*. A *Kripke model* is a frame
  together with a forcing relation $models$ between worlds and
  atomic formulas that is *hereditary*: if $w models p$ and
  $w <= v$, then $v models p$. Truth never disappears as knowledge
  grows.
] <def:kripke-frame>

#definition(name: "Kripke Forcing")[
  The forcing relation is extended to all formulas by
  $
    w models phi and psi quad & "iff" quad w models phi "and" w models psi,
    w models phi or psi quad & "iff" quad w models phi "or" w models psi,
  $
  and — this is the point — the implication and the negation look at
  every future stage:
  $
    w models phi -> psi quad & "iff" quad forall v >= w (v models phi => v models psi),
    w models not phi quad & "iff" quad forall v >= w (v tack.not phi).
  $
  A formula is *valid* in a model if it is forced at every world, and
  *intuitionistically valid* if it is valid in every Kripke model.
] <def:kripke-forcing>

#eq[
  $
    w models phi -> psi & <=> forall v >= w (v models phi => v models psi), \
    w models not phi & <=> forall v >= w (v tack.not phi).
  $
] <eq:kripke-forcing>

#example(name: "The Law of Excluded Middle Fails")[
  Let $W = {w_1, w_2}$ with $w_1 <= w_2$, and let $p$ be forced only
  at $w_2$: at $w_1$ the atom $p$ is not yet decided. Then $w_1$ does
  not force $p$ (nothing forces it below), and $w_1$ does not force
  $not p$ either, because $w_2 >= w_1$ forces $p$. Hence
  $w_1 tack.not p or not p$: the law of excluded middle is not
  intuitionistically valid. The same frame shows why truth tables
  are blind here: $p$ is not simply "true" or "false", it is
  *undecided at $w_1$ and decided at $w_2$*.
] <ex:kripke-lem-counterexample>

#figure(
  image("img/kripke-counterexample.svg", width: 78%),
  caption: [
    The two-world counterexample. At $w_1$ the atom $p$ is undecided;
    the stage $w_2$ decides it. Since $w_2$ forces $p$, the world
    $w_1$ forces neither $p$ nor $not p$, so $p or not p$ fails there.
  ],
  placement: auto,
  supplement: [Fig.]
) <fig:kripke-counterexample>

#theorem(name: "Kripke Completeness for IPC")[
  For every formula $phi$: $"IPC"$ proves $phi$ if and only if $phi$
  is valid in every Kripke model.
] <thm:kripke-completeness-ipc>

#proof[
  *Soundness* is a routine induction on proofs: each axiom is valid
  and modus ponens preserves validity. *Completeness* is the Henkin
  method of Ch 5 in disguise. The *canonical model* has as worlds the
  prime theories of $"IPC"$ — consistent theories closed under
  disjunction, ordered by inclusion — with $Gamma models p$ iff
  $p in Gamma$. The Truth Lemma is proved by induction, the
  implication case using the closure properties of prime theories.
  The canonical model may be uncountable; a filtration argument
  (identifying worlds that agree on the subformulas of $phi$) cuts it
  down to a finite model. This is exactly the Ch 5 route — Lindenbaum,
  then witnesses, then the term model — with a prime theory playing
  the role of a Henkin theory
  (#link(<thm:henkin-completeness>)[Theorem 5.1]).
]

#theorem(name: "Glivenko's Theorem")[
  For every formula $phi$,
  $
    "IPC" tack not not phi "iff" "CPC" tack phi,
  $
  where $"CPC"$ is classical propositional logic: a formula is
  classical if and only if its double negation is intuitionistic.
] <thm:glivenko>

#proof[
  The forward direction is trivial: $"IPC" subset "CPC"$, and in
  $"CPC"$ the double negation $not not phi$ implies $phi$ by
  #link(<cor:double-negation>)[Corollary 1.1]. For the converse,
  two facts are provable in $"IPC"$:
  $
    "IPC" tack not not (phi -> psi) -> (not not phi -> not not psi), \
    "IPC" tack not not (phi or not phi).
  $
  The first is the contrapositive closure of implication; the second
  says that the double negation of the excluded middle is
  intuitionistic. Now induct on the classical derivation of $phi$:
  every axiom scheme of $"IPC"$ is an $"IPC"$-theorem, hence has an
  $"IPC"$-provable double negation (each $psi -> not not psi$ is
  intuitionistic); modus ponens is preserved by the first fact; and
  the one extra classical axiom, $chi or not chi$, is handled by the
  second fact. Thus $"CPC" tack phi$ implies $"IPC" tack not not phi$.
]

#theorem(name: "The Disjunction Property")[
  If $"IPC"$ proves $phi or psi$, then $"IPC"$ proves $phi$ or
  $"IPC"$ proves $psi$.
] <thm:disjunction-property>

#proof[
  Suppose $"IPC" tack.not phi$ and $"IPC" tack.not psi$. By
  #link(<thm:kripke-completeness-ipc>)[Kripke completeness], there
  are Kripke models $(W_1, <=_1, models_1)$ and $(W_2, <=_2, models_2)$
  with worlds $w_1 in W_1$, $w_2 in W_2$ such that
  $w_1 tack.not_1 phi$ and $w_2 tack.not_2 psi$. Glue the two trees
  under a new root $r$: $W = {r} union W_1 union W_2$ with
  $r <= v$ for every $v$, the two partial orders otherwise unchanged,
  and no atom forced at $r$. This is a Kripke model. Since $w_1 >= r$
  and $w_1 tack.not phi$, the world $r$ cannot force $phi$ — forcing
  is hereditary upward — and likewise $r tack.not psi$. By the local
  clause for disjunction, $r tack.not phi or psi$. But
  $"IPC" tack phi or psi$ would force it at every world of every
  model, contradiction.
]

#note[
  *Why the law fails.* The Kripke clause for $not phi$ reads "no
  future stage verifies $phi$", and the clause for $phi -> psi$ reads
  "every future stage that verifies $phi$ verifies $psi$". The
  excluded middle would assert $forall v >= w (v models phi)$ or
  $forall v >= w (v tack.not phi)$ — a statement about the *whole
  future*, which no finite stage can justify. The disjunction
  property is the semantic reflection of this: an intuitionistic
  proof of a disjunction always contains a proof of a disjunct. This
  is why intuitionistic logic is the logic of constructive
  mathematics: existence and disjunction carry information.
]

#caution[
  In intuitionistic logic, $not phi$ does *not* mean "we know
  $phi$ is false": it means "we can derive a contradiction from
  assuming $phi$" — a proof of impossibility. The double negation
  $not not phi$ means "assuming $phi$ leads to a contradiction is
  itself contradictory", which is *not* a proof of $phi$. Classical
  logic collapses these two readings; intuitionistic logic keeps
  them apart.
]

== Modal Logic: Basics // 模态逻辑基础

Modal logic reads a sentence relative to a *possible world*: "it is
necessary that $phi$" ($square phi$), "it is always the case"
(temporal reading), "it is known that" (epistemic reading), "it is
obligatory that" (deontic reading). The formal semantics is again
due to Kripke — and it is the same construction as §11.1, with the
poset replaced by an arbitrary relation.

#definition(name: "Modal Language and Diamond")[
  The *modal language* extends the propositional language of Ch 1 by
  a unary connective $square$ ("box"). The *diamond* is defined:
  $
    diamond phi := not square not phi,
  $
  so that "possibly $phi$" is "not necessarily not $phi$".
] <def:modal-language>

#eq[
  $diamond phi := not square not phi$
] <eq:diamond-def>

#definition(name: "Modal Frames and Models")[
  A *modal frame* is a nonempty set $W$ of *worlds* together with a
  binary *accessibility relation* $R subset W times W$. A *modal
  model* adds a valuation of atoms at worlds (no hereditariness: in
  modal logic atoms are plain truth values). Truth at a world is
  defined by the classical clauses of Ch 1 plus
  $
    w models square phi quad & "iff" quad forall v (w R v => v models phi), \
    w models diamond phi quad & "iff" quad exists v (w R v and v models phi).
  $
  A formula is *valid on a frame* if it is true at every world of
  every model on it.
] <def:modal-frame>

#definition(name: "Modal Axioms and Systems")[
  The basic system $"K"$ has the propositional axioms of Ch 1, the
  *distribution axiom* $square (phi -> psi) -> (square phi -> square psi)$,
  and the rules of modus ponens and *necessitation* ($tack phi$
  implies $tack square phi$). The important extensions add axiom
  schemes:
  $
    "T": square phi -> phi, quad
    "4": square phi -> square square phi, quad
    "B": phi -> square diamond phi, \
    "D": square phi -> diamond phi, quad
    "5": diamond phi -> square diamond phi.
  $
  $"T" = "K" + "T"$, $"S4" = "T" + "4"$, and
  $"S5" = "T" + "4" + "5"$ are the standard systems.
] <def:modal-axioms>

#theorem(name: "Correspondence Theory")[
  Each of the five schemes characterizes a first-order property of
  the accessibility relation:
  $
    "T valid on " (W, R) & <=> R " is reflexive", \
    "4 valid on " (W, R) & <=> R " is transitive", \
    "B valid on " (W, R) & <=> R " is symmetric", \
    "D valid on " (W, R) & <=> R " is serial", \
    "5 valid on " (W, R) & <=> R " is euclidean".
  $
] <thm:modal-correspondence>

#proof[
  We show the reflexive case in full; the others are the same
  pattern. If $R$ is reflexive, then $w models square phi$ gives
  $w models phi$ by the clause for $square$ (take $v = w$), so T
  holds. Conversely, if $w$ is not reflexive but has an accessible
  $v$, let $p$ be true only at $v$; then $w models square p$ while
  $w tack.not p$, so T fails. Transitivity: $square phi -> square square phi$
  fails when $w R v$, $v R u$ but not $w R u$, by making $p$ false at
  $u$ only. Symmetry for B: $phi -> square diamond phi$ fails when
  $w R v$ but no successor of $v$ reaches $w$. Seriality for D:
  $square phi -> diamond phi$ fails at a world with no successor.
  Euclideanness for 5: $diamond phi -> square diamond phi$ fails
  when $w R v$, $w R u$ but $v$ cannot reach $u$ (make $p$ true only
  at $u$).
]

#figure(
  image("img/modal-frames.svg", width: 82%),
  caption: [
    The frame conditions behind the systems: reflexive (T), transitive
    (4), symmetric (B), serial (D), euclidean (5). The system S5 is
    exactly the class of equivalence relations.
  ],
  placement: auto,
  supplement: [Fig.]
) <fig:modal-frames>

#example(name: "Natural Frames")[
  *Time.* The frame $(bb(N), <=)$ with the usual order validates S4:
  accessibility is reflexive and transitive, so "always in the
  future" behaves like $square$ in S4. *Knowledge.* The frame of
  equivalence classes of indistinguishable situations validates S5:
  "agent $a$ knows that" is $square$ on the equivalence relation of
  worlds the agent cannot tell apart, which is exactly the S5
  condition. *Obligation.* The frame of "ideal worlds" relative to a
  normative system gives a serial frame validating K + D.
] <ex:modal-frames-examples>

#theorem(name: "Kripke Completeness for Modal Systems")[
  The system $"K"$ is sound and complete for the class of all frames;
  $"T"$ for the reflexive frames; $"S4"$ for the reflexive transitive
  frames; $"S5"$ for the frames whose accessibility relation is an
  equivalence relation.
] <thm:modal-completeness>

#proof[
  Soundness is immediate from the correspondence theorem. For
  completeness, the Henkin method applies once more: the *canonical
  model* has as worlds the maximal consistent sets of the system,
  with $w R v$ iff every $square phi in w$ has $phi in v$. One verifies
  by induction the Truth Lemma (the modal clause uses the maximality
  of the sets), and the accessibility relation of the canonical model
  inherits exactly the frame conditions forced by the axioms: T makes
  it reflexive, 4 transitive, B symmetric, D serial, 5 euclidean.
  The route is the Ch 5 route once again
  (#link(<thm:henkin-completeness>)[Theorem 5.1]) — maximal
  consistent sets play the role of Henkin theories.
]

#note[
  *Modal semantics and second-order semantics.* Modal logic and the
  Henkin semantics of Ch 10 are two faces of the same move: instead
  of fixing one universe, the semantics lets the relevant domain
  vary — a set of possible worlds in one case, an arbitrary
  second-order domain in the other. The correspondence theorem adds
  a genuinely first-order aspect: each modal axiom is equivalent to a
  first-order condition on frames, so model theory of Ch 6
  (definability, compactness, completeness) applies to the *frame
  classes* themselves. This is the hinge promised in §10.4: changing
  the semantics is a choice about what counts as a model, and the
  metatheory follows.
]

== Many-Valued Logics // 多值逻辑

The third way to change the meaning of truth is the most literal:
replace the set of truth values. Where intuitionistic logic keeps
two values but makes truth world-relative, many-valued logic keeps
one flat world but admits a third value — "undefined", "unknown",
"future" — or a continuum of them.

#definition(name: "Kleene's Strong Three-Valued Tables")[
  Let the truth values be ${T, U, F}$, with $U$ ("undefined")
  between $F$ and $T$. *Kleene's strong three-valued logic* extends
  the classical tables by the rule that $U$ *propagates*: a
  connective whose classical output is already determined ignores
  $U$, and otherwise yields $U$. Concretely,
  $p and U = U = U and p$ (unless $p = F$, giving $F$),
  $p or U = U = U or p$ (unless $p = T$, giving $T$), and
  $not U = U$.
] <def:many-valued-valuation>

#tex-table(
  ([$p$], [$¬p$]),
  ([$T$], [$F$]),
  ([$U$], [$U$]),
  ([$F$], [$T$]),
)

#definition(name: "Łukasiewicz Three-Valued Implication")[
  *Łukasiewicz's* three-valued implication differs from Kleene's:
  the classical truth table is preserved on ${T, F}$, and the
  "undefined" cases read
  $
    U -> U = T, quad T -> U = U, quad U -> F = U, quad F -> U = T.
  $
  The scheme $phi -> (psi -> phi)$ remains valid, but the excluded
  middle $phi or not phi$ takes the value $U$ when $phi$ does, and is
  therefore not a validity.
] <def:lukasiewicz-logic>

#tex-table(
  ([$p$], [$q$], [$p → q$]),
  ([$T$], [$T$], [$T$]),
  ([$T$], [$U$], [$U$]),
  ([$T$], [$F$], [$F$]),
  ([$U$], [$T$], [$T$]),
  ([$U$], [$U$], [$T$]),
  ([$U$], [$F$], [$U$]),
  ([$F$], [$T$], [$T$]),
  ([$F$], [$U$], [$T$]),
  ([$F$], [$F$], [$T$]),
)

#example(name: "Where the Third Value Comes From")[
  Division by zero: "$1 / 0 > 0$" is neither true nor false in the
  intended reading — it is *undefined*, and the strong tables model
  how undefinedness spreads through conjunction and disjunction.
  The liar paradox "this sentence is false" cannot be assigned
  $T$ or $F$ without contradiction; a third value breaks the
  dichotomy. Future contingents ("there will be a sea battle
  tomorrow") are classically forced to $T$ or $F$ by bivalence, a
  commitment some philosophers reject; $U$ ("undetermined") is the
  natural reading. In all three cases the logic did not change — the
  set of truth values did.
] <ex:three-valued-examples>

#note[
  *The continuum: fuzzy logic.* Replace ${T, U, F}$ by the whole
  interval $[0, 1]$ and read truth as *degree*: $p and q = min (p, q)$,
  $p or q = max (p, q)$, $not p = 1 - p$, and the continuous
  Łukasiewicz implication $p -> q = min (1, 1 - p + q)$. This is
  fuzzy logic — not a logic of degrees of belief but a truth
  functional logic on a continuum of values. The uniform picture of
  this chapter stands: intuitionism made truth world-relative, modal
  logic made it relational, many-valued logic made it graded. In
  every case the syntax of Ch 1 is untouched, and in every case the
  metatheory of Part II must be re-examined — completeness and
  compactness are theorems about a semantics, not about logic.
]

#part("Appendix")

= Glossary

== A
- *#link(<def:alpha-equivalent>)[Alpha-Equivalence]*
- *#link(<def:lukasiewicz-system>)[Axiom Schema]*

== B
- *#link(<prop:algebraic-laws>)[Boolean Algebra]*

== C
- *#link(<def:categoricity>)[Categoricity]*
- *#link(<def:church-thesis>)[Church's Thesis]*
- *#link(<thm:propositional-compactness>)[Compactness (Propositional)]*
- *#link(<thm:compactness>)[Compactness Theorem]*
- *#link(<def:complete-theory>)[Complete Theory]*
- *#link(<def:computable-function>)[Computable Function]*
- *#link(<def:cnf>)[Conjunctive Normal Form]*
- *#link(<def:consistency>)[Consistency]*
- *#link(<def:con-sentence>)[Consistency Sentence]*
- *#link(<def:conjunction>)[Conjunction]*

== D
- *#link(<thm:deduction-theorem>)[Deduction Theorem]*
- *#link(<def:definable-set>)[Definable Set]*
- *#link(<def:derived-connectives>)[Derived Connectives]*
- *#link(<lem:diagonalization>)[Diagonalization Lemma]*
- *#link(<def:disjunction>)[Disjunction]*
- *#link(<def:cnf>)[Disjunctive Normal Form]*
- *#link(<cor:double-negation>)[Double Negation]*

== E
- *#link(<def:elementary-equivalence>)[Elementary Equivalence]*
- *#link(<def:elementary-substructure>)[Elementary Substructure]*
- *#link(<def:exists-abbreviation>)[Existential Quantifier]*

== F
- *#link(<def:first-order-formula>)[First-Order Formula]*
- *#link(<def:free-bound-variable>)[Free and Bound Variables]*

== G
- *#link(<def:generalization>)[Generalization (Gen)]*
- *#link(<thm:glivenko>)[Glivenko's Theorem]*
- *#link(<def:godel-numbering>)[Gödel Numbering]*
- *#link(<thm:first-incompleteness>)[Gödel's First Incompleteness Theorem]*
- *#link(<thm:second-incompleteness>)[Gödel's Second Incompleteness Theorem]*

== H
- *#link(<thm:halting-undecidable>)[Halting Problem]*
- *#link(<thm:henkin-completeness>)[Henkin Completeness Theorem]*
- *#link(<def:henkin-structure>)[Henkin Semantics]*
- *#link(<thm:herbrand>)[Herbrand's Theorem]*
- *#link(<cor:hypothetical-syllogism>)[Hypothetical Syllogism (HS)]*

== I
- *#link(<def:implication>)[Implication]*
- *#link(<def:intuitionistic-axioms>)[Intuitionistic Logic]*

== K
- *#link(<lem:konig-lemma>)[König's Lemma]*
- *#link(<thm:kripke-completeness-ipc>)[Kripke Completeness (IPC)]*
- *#link(<def:kripke-frame>)[Kripke Semantics]*

== L
- *#link(<def:logical-consequence>)[Logical Consequence]*
- *#link(<def:logical-equivalence>)[Logical Equivalence]*
- *#link(<thm:downward-ls>)[Löwenheim–Skolem Theorems]*
- *#link(<def:lukasiewicz-logic>)[Łukasiewicz Logic]*
- *#link(<thm:los>)[Łoś's Theorem]*

== M
- *#link(<def:many-valued-valuation>)[Many-Valued Logics]*
- *#link(<def:mu-operator>)[Minimalization]*
- *#link(<def:modal-language>)[Modal Logic]*
- *#link(<def:model>)[Model]*
- *#link(<def:lukasiewicz-system>)[Modus Ponens (MP)]*

== N
- *#link(<def:negation>)[Negation]*
- *#link(<def:cnf>)[Normal Form]*

== P
- *#link(<def:partial-recursive>)[Partial Recursive Function]*
- *#link(<prop:derived-theorems>)[Peirce's Law]*
- *#link(<def:prenex-form>)[Prenex Normal Form]*
- *#link(<def:primitive-recursive>)[Primitive Recursive Function]*
- *#link(<prop:basic-theorems>)[Principle of Explosion]*
- *#link(<def:proof>)[Proof]*
- *#link(<def:provability-predicate>)[Provability Predicate]*

== Q
- *#link(<def:quantifier-elimination>)[Quantifier Elimination]*

== R
- *#link(<thm:reductio-ad-absurdum>)[Reductio ad Absurdum]*
- *#link(<def:representable>)[Representable Function]*
- *#link(<thm:resolution-completeness>)[Resolution]*

== S
- *#link(<def:satisfaction>)[Satisfaction]*
- *#link(<def:sat>)[SAT]*
- *#link(<def:tautology>)[Satisfiable]*- *#link(<def:tautology>)[Semantic Consequence]*
- *#link(<def:second-order-arithmetic>)[Second-Order Arithmetic]*
- *#link(<def:second-order-language>)[Second-Order Logic]*
- *#link(<def:sentence>)[Sentence]*
- *#link(<thm:truth-functional-completeness>)[Sheffer Stroke]*
- *#link(<def:signature>)[Signature]*
- *#link(<def:skolem-form>)[Skolem Normal Form]*
- *#link(<thm:soundness-completeness>)[Soundness and Completeness]*
- *#link(<def:standard-structure>)[Standard Semantics]*
- *#link(<def:structure>)[Structure]*
- *#link(<def:substitutable>)[Substitutable]*
- *#link(<def:substitution>)[Substitution]*

== T
- *#link(<thm:tarski-undefinability>)[Tarski's Undefinability Theorem]*
- *#link(<def:tautology>)[Tautology]*
- *#link(<def:term>)[Term]*
- *#link(<def:term-model>)[Term Model]*
- *#link(<def:theorem>)[Theorem]*
- *#link(<def:turing-machine>)[Turing Machine]*
- *#link(<def:model>)[Truth]*

== U
- *#link(<def:ultraproduct>)[Ultraproduct]*

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
