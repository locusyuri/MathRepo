#import "../../TypstTemplate/math-notes.typ": *

#set page(
  paper: "a4",
  margin: (x: 2cm, y: 2.5cm),
)
#set text(font: ("Times New Roman", "SimSun"), size: 11pt)
#show heading.where(level: 1): it => pagebreak() + it

#align(center)[
  *#text(size: 22pt, color-structure)[Mathematical Logic]* \
  #text(size: 14pt, color-muted)[数理逻辑] \
  #v(0.5em)
  #text(size: 11pt, color-muted)[CatMono · 2025]
]

#v(2em)

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

#table(
  columns: (1fr, 1fr),
  [ $p$ ], [ $¬p$ ],
  [ $0$ ], [ $1$ ],
  [ $1$ ], [ $0$ ],
)

#definition(name: "Conjunction")[
  The *conjunction* of two propositions $p$ and $q$, denoted by
  $p ∧ q$, is true if and only if both $p$ and $q$ are true.
] <def:conjunction>

#table(
  columns: (1fr, 1fr, 1fr),
  [ $p$ ], [ $q$ ], [ $p ∧ q$ ],
  [ $0$ ], [ $0$ ], [ $0$ ],
  [ $0$ ], [ $1$ ], [ $0$ ],
  [ $1$ ], [ $0$ ], [ $0$ ],
  [ $1$ ], [ $1$ ], [ $1$ ],
)

#definition(name: "Disjunction")[
  The *disjunction* of two propositions $p$ and $q$, denoted by
  $p ∨ q$, is true if and only if at least one of $p$ or $q$ is true.
] <def:disjunction>

#table(
  columns: (1fr, 1fr, 1fr),
  [ $p$ ], [ $q$ ], [ $p ∨ q$ ],
  [ $0$ ], [ $0$ ], [ $0$ ],
  [ $0$ ], [ $1$ ], [ $1$ ],
  [ $1$ ], [ $0$ ], [ $1$ ],
  [ $1$ ], [ $1$ ], [ $1$ ],
)

#definition(name: "Implication")[
  The *implication* $p -> q$ (read "if $p$, then $q$") is false if
  and only if $p$ is true and $q$ is false.
] <def:implication>

#table(
  columns: (1fr, 1fr, 1fr),
  [ $p$ ], [ $q$ ], [ $p -> q$ ],
  [ $0$ ], [ $0$ ], [ $1$ ],
  [ $0$ ], [ $1$ ], [ $1$ ],
  [ $1$ ], [ $0$ ], [ $0$ ],
  [ $1$ ], [ $1$ ], [ $1$ ],
)

#definition(name: "Biconditional")[
  The *biconditional* of two propositions $p$ and $q$, denoted by
  $p ↔ q$, is true if and only if $p$ and $q$ have the same
  truth value.
] <def:biconditional>

#table(
  columns: (1fr, 1fr, 1fr),
  [ $p$ ], [ $q$ ], [ $p ↔ q$ ],
  [ $0$ ], [ $0$ ], [ $1$ ],
  [ $0$ ], [ $1$ ], [ $0$ ],
  [ $1$ ], [ $0$ ], [ $0$ ],
  [ $1$ ], [ $1$ ], [ $1$ ],
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
  $L_(n+1)(A) = L_n(A) union {(f p_1 dots p_j) | p_i in L_n(A),
  f in Omega_j}$. Then $L(A) = union.big_(n >= 0) L_n(A)$.
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

#note[
  Axiomatic proof dates back to Euclid's *Elements*, but in
  propositional logic it originates from Gottlob Frege's 1879
  *Begriffsschrift*. Frege's system used only implication and negation,
  with six axioms and modus ponens. Jan Łukasiewicz later simplified
  it to three axioms.
]

#definition(name: "Łukasiewicz Axiom System")[
  The *Łukasiewicz axiom system* is $cal(L) = (A, Omega, Z, I)$, where:
  - $A$ contains sufficiently many propositional variables;
  - $Omega = Omega_1 union Omega_2$ is *complete*, with
    $Omega_1 = {¬}$ and $Omega_2 = {->}$;
  - $Z$ contains a single inference rule: *modus ponens* (MP): from
    $p$ and $p -> q$, infer $q$;
  - $I$ contains three axiom schemata ($p, q, r in A$):
    + (L1) $p -> (q -> p)$ *(Law of Affirming the Consequent)*;
    + (L2) $(p -> (q -> r)) -> ((p -> q) -> (p -> r))$
      *(Law of Distribution of Implication)*;
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
  If $Gamma$ is consistent, then for any formula $p$,
  $Gamma ⊬ ¬ p$ (i.e., not every negation is provable).
] <prop:consistency-property>

#proposition(name: "Basic Theorems")[
  The following are theorems of the Łukasiewicz system:
  + $⊢ p -> p$ *(Law of Identity)*;
  + $⊢ ¬ q -> (q -> p)$ *(Law of Denying the Antecedent)*;
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
  + $⊢ ¬ (p -> q) -> (q -> p)$ *(Overall Negation Reversal)*.
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

#note[
  *Soundness* ($⊢ => ⊨$) is proved by induction on the length
  of a proof: every axiom is a tautology, and MP preserves
  tautologicity. *Completeness* ($⊨ => ⊢$) is deeper; one
  standard proof goes through the #link(<def:consistency>)[consistency]
  of a maximal consistent set and the Lindenbaum lemma. The details
  are omitted here.
]

#part("First-Order Logic")  // 一阶逻辑

= First-Order Logic  // 一阶逻辑

#note[
  Placeholder: First-order logic extends propositional logic with
  quantifiers ($forall$, $exists$), variables, terms, and predicates.
  It will be developed in a subsequent revision.
]

#part("Second-Order Logic")  // 二阶逻辑

= Second-Order Logic  // 二阶逻辑

#note[
  Placeholder: Second-order logic allows quantification over
  predicates and relations. It will be developed in a subsequent
  revision.
]

#part("Appendix")

= Glossary

== C
- *#link(<def:consistency>)[Consistency]*
- *#link(<def:conjunction>)[Conjunction]*

== D
- *#link(<thm:deduction-theorem>)[Deduction Theorem]*
- *#link(<def:derived-connectives>)[Derived Connectives]*
- *#link(<def:disjunction>)[Disjunction]*

== I
- *#link(<def:implication>)[Implication]*

== N
- *#link(<def:negation>)[Negation]*

== P
- *#link(<def:proof>)[Proof]*

== T
- *#link(<def:tautology>)[Tautology]*
- *#link(<def:theorem>)[Theorem]*
- *#link(<def:wff>)[Well-Formed Formula (WFF)]*

== V
- *#link(<def:valuation>)[Valuation]*
