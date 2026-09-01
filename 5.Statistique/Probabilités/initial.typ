#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Probabilités", // 概率论
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Probabilités", // 概率论
  "Violet",
  subtitle: "A notebook for probability",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This is a notebook for probability.",
)

#make-outline(depth: 2, title: "Contents")

#part("Fundamentals of Probability")
= Random Events and Probability // 随机事件与概率

== Random Events and Operations // 随机事件及其运算

Probability theory is the mathematical study of *random phenomena* —
experiments whose outcome cannot be predicted with certainty even when
repeated under identical conditions. A *random experiment* is characterized by
three features: it can be repeated under (at least conceptually) identical
conditions; the set of all possible outcomes is known in advance; and the
individual outcome of a single trial is not predictable.

#definition(name: "Sample Space")[
  The set of all possible outcomes of a random experiment is called its
  *sample space*, denoted $Omega$; each individual outcome $omega$ is a
  *sample point*.
] <def:sample-space>

#example[
  - Tossing a coin once: $Omega = {H, T}$.
  - Rolling a die: $Omega = {1, 2, 3, 4, 5, 6}$.
  - Recording the lifetime of a light bulb: $Omega = [0, infinity)$, an
    uncountable sample space.
] <ex:sample-spaces>

#definition(name: "Random Event")[
  A *random event* is a subset of the sample space $Omega$. An event $A$
  *occurs* if the observed outcome $omega$ belongs to $A$. An event consisting
  of a single point is *elementary* (a *simple event*). The whole space
  $Omega$ is the *certain event* (always occurs) and the empty set is the
  *impossible event* (never occurs).
] <def:event>

Events are mathematical objects of exactly the same nature as sets, so the
set language developed in the Théorie des Ensembles note applies verbatim —
the only difference is vocabulary ("or" for union, "and" for intersection).

#definition(name: "Relations between Events")[
  Let $A, B$ be events in $Omega$.

  - $A$ *implies* $B$ (written $A subset.eq B$) if every outcome of $A$ is an
    outcome of $B$;
  - $A$ and $B$ are *equal* (written $A = B$) if $A subset.eq B$ and
    $B subset.eq A$;
  - $A$ and $B$ are *mutually exclusive* (disjoint) if $A inter B = emptyset$;
  - $A$ and $B$ are *complementary* (opposite) if $A inter B = emptyset$ and
    $A union B = Omega$; the complement of $A$ is written $overline(A)$.
] <def:event-relations>

#definition(name: "Operations on Events")[
  The operations on events are the set operations: $A union B$ ("$A$ or
  $B$"), $A inter B$ ("$A$ and $B$"), and the difference
  $
    A backslash B = A inter overline(B).
  $
  Unions and intersections extend to arbitrary families
  $union.big_(i) A_i$, $inter.big_(i) A_i$, and they obey the *De Morgan
  laws*
  $
    overline(A union B) = overline(A) inter overline(B),
    quad
    overline(A inter B) = overline(A) union overline(B).
  $
] <def:event-operations>

#example[
  Roll a die and let $A = {2, 4, 6}$ (even), $B = {1, 2, 3}$ (at most $3$).
  Then
  $
    A union B = {1, 2, 3, 4, 6},
    quad
    A inter B = {2},
    quad
    A backslash B = {4, 6},
    quad
    overline(A) = {1, 3, 5}.
  $
  The events $A$ and $overline(B) = {4, 5, 6}$ are not disjoint, since
  $A inter overline(B) = {4, 6} != emptyset$; likewise $A$ and $B$ share the
  point $2$.
  De Morgan's law checks: $overline(A union B) = {5} = overline(A) inter
  overline(B) = {1, 3, 5} inter {4, 5, 6} = {5}$.
] <ex:event-operations>

#figure(
  image("img/venn-operations.svg", width: 78%),
  caption: [Venn diagrams of the four basic operations on two events
    $A, B$: union $A union B$ (top left), intersection $A inter B$ (top
    right), difference $A backslash B$ (bottom left), and complement
    $overline(A)$ (bottom right).],
  placement: auto,
  supplement: [Fig.],
) <fig:venn-operations>

In finitely many-outcome experiments it is natural to allow *every* subset as
an event. For general sample spaces, however, one restricts attention to a
family closed under the operations above.

#definition(name: "Event Field")[
  A *field of events* (a $sigma$-field on $Omega$) is a family
  $F$ of subsets of $Omega$ such that

  - $Omega in F$;
  - $A in F$ implies $overline(A) in F$;
  - $A_1, A_2, dots in F$ implies $union.big_(n=1)^infinity A_n in F$.

  The pair $(Omega, F)$ is called a *measurable space*, and the elements of
  $F$ are the *events*.
] <def:event-field>

#note[
  The systematic construction of $sigma$-fields belongs to measure theory and
  is developed in the Théorie des Ensembles note. Throughout this note the
  ambient $sigma$-field is tacitly fixed: $F = {cal(P)}(Omega)$ for finite or
  countable $Omega$, and the Borel $sigma$-field for $Omega = RR$.
]

Events describe *what can happen*; assigning numbers to events — measuring
"how likely" each one is — is the task of the next section, and a random
variable will then simply be a device that converts outcomes into numbers so
that distributions can be studied with the tools of analysis.

== Definitions of Probability // 概率的定义

Intuitively, the probability of an event is a number measuring the likelihood
of its occurrence. This intuition acquires mathematical meaning through an
axiom system; before stating it, we examine the empirical notion from which
it abstracts.

#property(name: "Frequencies and Their Stability")[
  Repeating an experiment $n$ times, let $n_A$ be the number of trials in
  which the event $A$ occurs. The ratio
  $
    f_n(A) = n_A / n
  $
  is the *frequency* of $A$. Frequencies satisfy $0 <= f_n(A) <= 1$,
  $f_n(Omega) = 1$, and $f_n(A union B) = f_n(A) + f_n(B)$ whenever
  $A inter B = emptyset$. Empirically, as $n$ grows, $f_n(A)$ *stabilizes*
  around a definite value — the frequency interpretation of probability.
] <prop:frequency-stability>

The stabilization of frequencies is itself a theorem, not an axiom — it is
Bernoulli's law of large numbers, proved in the Limit Theorems part. What the
axiomatic definition does is to fix the *idealized limit object* directly and
derive everything else from it.

#definition(name: "Axiomatic Definition of Probability")[
  Let $(Omega, F)$ be a measurable space. A *probability measure* is a
  function $P: F -> [0, 1]$ such that

  - (non-negativity) $P(A) >= 0$ for all $A in F$;
  - (normalization) $P(Omega) = 1$;
  - (countable additivity) for every sequence of pairwise disjoint events
    $A_1, A_2, dots$,
    $
      P(union.big_(n=1)^infinity A_n) = sum_(n=1)^infinity P(A_n).
    $

  The triple $(Omega, F, P)$ is a *probability space*.
] <def:probability-axioms>

#definition(name: "Classical Probability")[
  Let $Omega$ be finite and all its outcomes equally likely (the *classical
  model*). For $A subset.eq Omega$,
  $
    P(A) = abs(A) / abs(Omega)
    = ("favourable outcomes") / ("possible outcomes").
  $
] <def:classical-probability>

#example[
  An urn contains $N$ balls, $K$ of them red; $n$ balls are drawn. Let
  $A_(n, k)$ be the event "exactly $k$ red balls are drawn". According to the
  drawing protocol, the classical formula gives:

  - *without replacement, unordered* (hypergeometric model):
    $
      P(A_(n, k)) = binom(K, k) binom(N - K, n - k) / binom(N, n);
    $
  - *without replacement, ordered*: the count of ordered draws with $k$ red
    balls divided by $N^underline(n)$ gives the same value — the ordering
    cancels;
  - *with replacement, ordered* (binomial model):
    $
      P(A_(n, k)) = binom(n, k) (K \/ N)^k (1 - K \/ N)^(n - k);
    $
  - *with replacement, unordered*: a third value, rarely of practical
    interest, as physical drawing protocols are ordered.

  The lesson: the probability depends on the *physical protocol*, and the
  combinatorial bookkeeping must match it.
] <ex:balls-sampling>

#example[
  (Matching problem.) $n$ gentlemen check their hats; the hats are returned at
  random, one to each. What is the probability that *at least one* gentleman
  receives his own hat? Let $A_i$ be the event that gentleman $i$ gets his
  own hat. The event of interest is $union.big_(i=1)^n A_i$, and the
  inclusion–exclusion principle (proved in the Combinatoire note) with
  $abs(A_(i_1) inter dots inter A_(i_k)) = (n - k)!$ gives
  $
    P(union.big_(i=1)^n A_i)
    = sum_(k=1)^n (-1)^(k+1) binom(n, k) (n - k)! / n!
    = 1 - sum_(k=0)^n (-1)^k / k!
    -> 1 - 1 / e quad (n -> infinity),
  $
  where the last step uses the derangement count established in the
  Combinatoire note. The probability is already about $0.632$ for small
  $n$ and stays there.
] <ex:matching-problem>

#definition(name: "Geometric Probability")[
  Let $Omega subset.eq RR^d$ be a region of finite measure (length, area or
  volume) and suppose the outcome is "uniformly distributed" over $Omega$ in
  the sense that the probability of landing in a region depends only on its
  measure. For $A subset.eq Omega$,
  $
    P(A) = m(A) / m(Omega),
  $
  where $m$ is length, area or volume as appropriate.
] <def:geometric-probability>

#example[
  (The meeting problem.) Two friends agree to meet at a fixed spot between
  noon and $1$ pm; each arrives at a time uniformly distributed over the
  hour, independently of the other, and waits $15$ minutes before leaving.
  What is the probability that they meet? Model the two arrival times by a
  point $(x, y)$ of the square $[0, 1]^2$; they meet iff
  $abs(x - y) <= 1 \/ 4$ (see @fig:meeting-problem). The complementary
  region consists of two triangles of total area $(3 \/ 4)^2$, so
  $
    P("they meet") = 1 - (3 / 4)^2 = 7 / 16.
  $
] <ex:meeting-problem>

#figure(
  image("img/meeting-problem.svg", width: 62%),
  caption: [The meeting problem: the square $[0, 1]^2$ of arrival-time pairs;
    the shaded band $abs(x - y) <= 1 \/ 4$ is the meeting region, and the two
    unshaded right triangles form its complement.],
  placement: auto,
  supplement: [Fig.],
) <fig:meeting-problem>

#caution[
  (Bertrand's paradox.) Choose "a chord of a circle at random" and ask for the
  probability that it is longer than the side of the inscribed equilateral
  triangle. Three natural-sounding randomization mechanisms give different
  answers: uniformly chosen endpoints give $1 \/ 3$; a uniformly chosen radius
  with a uniformly chosen point on it gives $1 \/ 2$; a uniformly chosen chord
  midpoint in the disc gives $1 \/ 4$. The paradox does not reveal a
  contradiction in probability theory — it shows that "uniformly random" must
  specify *the mechanism generating the outcomes*, exactly as the urn example
  of #link(<ex:balls-sampling>)[the drawing protocols] warned. A geometric
  model is well-posed only once $Omega$ and its uniform measure are pinned
  down.
] <caution:bertrand>

#note[
  (Subjective probability.) In situations with no repeatable experiment —
  e.g. "the candidate will win the election" — practitioners assign
  *degrees of belief* obeying the same axioms. This Bayesian viewpoint,
  axiomatized by de Finetti and Savage, will resurface when prior
  distributions are discussed; the present note works with the objective
  axiomatic framework of #link(<def:probability-axioms>)[Kolmogorov].
]

== Properties of Probability // 概率的性质

The axioms of #link(<def:probability-axioms>)[the definition] already contain
the whole theory of $P$; this section unwinds its first consequences.

#property(name: "Finite Additivity and Consequences")[
  Let $P$ be a probability measure.

  - $P(emptyset) = 0$;
  - finite additivity: for pairwise disjoint $A_1, dots, A_n$,
    $
      P(union.big_(i=1)^n A_i) = sum_(i=1)^n P(A_i);
    $
  - complement rule: $P(overline(A)) = 1 - P(A)$;
  - Boole's inequality (subadditivity): for any events $A_1, dots, A_n$,
    $
      P(union.big_(i=1)^n A_i) <= sum_(i=1)^n P(A_i).
    $
] <prop:probability-additivity>

#proof[
  Take $A_1 = Omega$ and $A_n = emptyset$ for $n >= 2$ in countable
  additivity: $1 = P(Omega) = P(Omega) + P(emptyset) + P(emptyset) + dots$,
  so $P(emptyset) = 0$. For finite additivity, extend a finite disjoint
  family by infinitely many copies of $emptyset$ and use countable
  additivity. The complement rule follows from disjointness of $A$ and
  $overline(A)$. For Boole's inequality, decompose $union A_i$ into
  pairwise disjoint pieces $B_i = A_i backslash (A_1 union dots union
    A_(i-1))$, note $B_i subset.eq A_i$, and apply finite additivity to the
  $B_i$ together with #link(<prop:probability-monotonicity>)[monotonicity].
]

#property(name: "Monotonicity and Difference")[
  If $A subset.eq B$ then
  $
    P(B backslash A) = P(B) - P(A),
    quad "hence"
    quad P(A) <= P(B).
  $
  In particular $P(A) <= 1$ for every event $A$.
] <prop:probability-monotonicity>

#property(name: "Addition Formula")[
  For any two events,
  $
    P(A union B) = P(A) + P(B) - P(A inter B),
  $
  and for any three,
  $
    P(A union B union C)
    = P(A) + P(B) + P(C)
    - P(A inter B) - P(A inter C) - P(B inter C)
    + P(A inter B inter C).
  $
] <prop:addition-formula>

#proof[
  Decompose $A union B$ into the disjoint union
  $A union B = A union (B backslash (A inter B))$ and apply
  #link(<prop:probability-additivity>)[finite additivity] together with
  #link(<prop:probability-monotonicity>)[the difference formula]. The
  three-event version follows by the same decomposition, or directly by the
  inclusion–exclusion pattern known from the Combinatoire note.
]

The next theorem extends the addition pattern from finite unions to limits of
monotone sequences of events; it relies on the notion of limits of sequences
of sets from the Théorie des Ensembles note.

#theorem(name: "Continuity of Probability")[
  Let $(A_n)_(n >= 1)$ be a sequence of events.

  - If $A_1 subset.eq A_2 subset.eq dots$ is increasing, then
    $
      P(union.big_(n=1)^infinity A_n) = lim_(n -> infinity) P(A_n).
    $
  - If $A_1 supset.eq A_2 supset.eq dots$ is decreasing, then
    $
      P(inter.big_(n=1)^infinity A_n) = lim_(n -> infinity) P(A_n).
    $
] <thm:continuity-probability>

#proof[
  For the increasing case, set $A_0 = emptyset$ and decompose the union into
  the disjoint rings
  $B_n = A_n backslash A_(n - 1)$, so that
  $union.big_(n>=1) A_n = union.big_(n>=1) B_n$ with $B_i inter B_j =
  emptyset$ for $i != j$. Countable additivity and
  #link(<prop:probability-monotonicity>)[the difference formula] give
  $
    P(union.big_(n=1)^infinity A_n)
    = sum_(n=1)^infinity P(B_n)
    = lim_(N -> infinity) sum_(n=1)^N (P(A_n) - P(A_(n-1)))
    = lim_(N -> infinity) P(A_N),
  $
  the series telescoping. The decreasing case follows by taking complements:
  apply the increasing case to $overline(A_1) subset.eq overline(A_2) subset.eq
  dots$ and use the complement rule.
]

Monotone limits prepare the language of "infinitely often", on which the
strong limit theorems of the Limit Theorems part rest.

#theorem(name: "Borel–Cantelli Lemmas")[
  Let $(A_n)_(n >= 1)$ be a sequence of events. The *upper limit*
  $lim"sup" A_n$ of the sequence is the event "$A_n$ infinitely often"
  ($A_n$ "i.o." for short):
  $
    lim"sup" A_n
    = inter.big_(N=1)^infinity union.big_(n=N)^infinity A_n.
  $

  - (First lemma) If $sum_(n=1)^infinity P(A_n) < infinity$, then
    $P(lim"sup" A_n) = 0$.
  - (Second lemma) If the $A_n$ are mutually independent and
    $sum_(n=1)^infinity P(A_n) = infinity$, then
    $P(lim"sup" A_n) = 1$.
] <thm:borel-cantelli>

#proof[
  (First lemma.) For every $N$,
  $lim"sup" A_n subset.eq union.big_(n=N)^infinity A_n$, so by
  #link(<prop:probability-additivity>)[Boole's inequality] (iterated)
  $
    P(lim"sup" A_n)
    <= sum_(n=N)^infinity P(A_n)
    -> 0 quad "as" N -> infinity,
  $
  since the tail of a convergent series tends to zero. (Second lemma:
  independence enters through a product inequality; its proof is deferred to
  the Limit Theorems part where independence in the limit sense has been
  developed.)
]

== Combinatorial Methods // 组合方法

In the classical model of #link(<def:classical-probability>)[the definition],
computing $P(A) = abs(A) \/ abs(Omega)$ is a *counting problem*. The tools —
permutations, combinations, and the addition and multiplication principles —
are developed once and for all in the Combinatoire note and are used here
without restatement; the examples below are chosen for their probabilistic
content.

#example[
  (Inclusion–exclusion in probability.) An integer is drawn uniformly at
  random from ${1, 2, dots, 1000}$. Let $D_2, D_3, D_5$ be the events that
  it is divisible by $2, 3, 5$ respectively. Then
  $P(D_2) = 1 \/ 2$, $P(D_3) = 1 \/ 3$, $P(D_5) = 1 \/ 5$, and
  $P(D_i inter D_j) = 1 \/ (i j)$ for distinct $i, j$, while
  $P(D_2 inter D_3 inter D_5) = 1 \/ 30$. By the inclusion–exclusion
  principle (the Combinatoire note again),
  $
    P(D_2 union D_3 union D_5)
    = 1/2 + 1/3 + 1/5 - 1/6 - 1/10 - 1/15 + 1/30
    = 11 / 15.
  $
] <ex:inclusion-exclusion-prob>

#example[
  (Pólya's urn.) An urn initially contains $a$ red and $b$ black balls. At
  each step one ball is drawn uniformly at random, its colour is noted, and
  it is returned together with $c$ additional balls of the *same colour*.
  Remarkably, the probability of drawing a red ball at step $k$ equals
  $a / (a + b)$ *for every* $k$: letting $X_(k-1)$ be the number of red
  balls drawn in the first $k - 1$ steps (and writing $E[X_(k-1)]$ for its
  average over the drawing protocols — the notion of expectation is made
  precise in the Numerical Characteristics part), the induction hypothesis
  $E[X_(k-1)] = (k - 1) a / (a + b)$ (trivial for $k = 1$) gives
  $
    P("red at step " k)
    = E[(a + c X_(k-1)) / (a + b + (k - 1) c)]
    = (a + c (k - 1) a / (a + b)) / (a + b + (k - 1) c)
    = a / (a + b).
  $
  The model produces reinforced randomness — early draws bias later ones —
  yet the marginal probability of each draw stays constant; this self-reinforcing
  structure reappears in Bayesian statistics as a predictive scheme.
] <ex:polya-urn>

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
//
// 教材基准：茆诗松《概率论与数理统计教程》全部知识点
// 补充内容：指数族、Basu 定理、Delta 方法、多元正态、多元线性回归、
//           双因素方差分析、核密度估计、随机过程初步等
//
// 主线：概率论（公理→随机变量→极限定理）
//       → 数理统计（抽样→估计→检验→回归）
//       → 应用拓展
//
// 职责边界：
//   - 测度论 / σ-代数构造 → Théorie des Ensembles
//   - Lebesgue 积分理论  → Analyse Réelle
//   - Fourier 分析工具    → Processus Stochastique
//   - 随机过程深入理论    → Processus Stochastique
//
// ==========================================================================


// ==========================================================================
// Part I — 概率论基础 (Fundamentals of Probability)
// ==========================================================================
// 设计思路：从随机现象的数学建模出发，建立 Kolmogorov 公理框架，
// 再发展条件概率与独立性理论。这是整个概率论的地基。
// 对应教材：第一章 §1.1–§1.5

// --- Chapter 1: 随机事件与概率 (Random Events and Probability) ---

//   Section 1.1: 随机事件及其运算 (Random Events and Operations)
//     - 随机现象与随机试验
//     - 样本空间 (Sample Space)
//     - 随机事件与事件域 (Event Space / σ-field of Events)
//     - 事件间的关系（包含、相等、互斥、对立）
//     - 事件间的运算（并、交、差、De Morgan 律）
//     - 随机变量的直观引入

//   Section 1.2: 概率的定义 (Definitions of Probability)
//     - 概率的公理化定义 (Kolmogorov Axioms)
//     - 频率方法与频率的稳定性
//     - 古典概型 (Classical Probability)
//     - 几何概型 (Geometric Probability)
//     - 主观概率 (Subjective Probability)
//     - 注：σ-代数的深入构造参见 Théorie des Ensembles

//   Section 1.3: 概率的性质 (Properties of Probability)
//     - 概率的可加性 (Additivity)
//     - 概率的单调性 (Monotonicity)
//     - 加法公式 (Addition Formula)
//     - 概率的连续性 (Continuity of Probability)
//     - Borel-Cantelli 引理

//   Section 1.4: 组合方法 (Combinatorial Methods)
//     - 排列与组合公式
//     - 计数原理与经典概率计算
//     - 容斥原理
//     - 经典模型：配对问题、Polya 罐子模型


// --- Chapter 2: 条件概率与独立性 (Conditional Probability and Independence) ---

//   Section 2.1: 条件概率 (Conditional Probability)
//     - 条件概率的定义
//     - 乘法公式 (Multiplication Rule)

//   Section 2.2: 全概率公式与 Bayes 公式 (Total Probability and Bayes' Theorem)
//     - 样本空间的划分
//     - 全概率公式
//     - Bayes 公式及其统计诠释

//   Section 2.3: 独立性 (Independence)
//     - 两个事件的独立性
//     - 多个事件的相互独立性
//     - 试验的独立性
//     - 独立试验与 Bernoulli 概型


// ==========================================================================
// Part II — 随机变量及其分布 (Random Variables and Distributions)
// ==========================================================================
// 设计思路：从一维到多维，从分布函数到具体分布族，再到随机变量函数的分布。
// 建立完整的分布理论，为后续数字特征和统计推断提供对象。
// 对应教材：第二章 §2.1–§2.7 + 第三章 §3.1–§3.5

// --- Chapter 3: 一维随机变量及其分布 (Univariate Random Variables and Distributions) ---

//   Section 3.1: 随机变量及其分布 (Random Variables and Their Distributions)
//     - 随机变量的概念
//     - 分布函数 (CDF)：定义与基本性质
//     - 离散型随机变量与分布列 (PMF)
//     - 连续型随机变量与密度函数 (PDF)

//   Section 3.2: 常用离散分布 (Common Discrete Distributions)
//     - Bernoulli 分布
//     - 二项分布 (Binomial)
//     - Poisson 分布
//     - 超几何分布 (Hypergeometric)
//     - 几何分布与负二项分布 (Geometric & Negative Binomial)
//     - 各分布的背景模型与相互关系

//   Section 3.3: 常用连续分布 (Common Continuous Distributions)
//     - 正态分布 (Normal)
//     - 均匀分布 (Uniform)
//     - 指数分布 (Exponential)
//     - Gamma 分布
//     - Beta 分布
//     - 连续分布的核 (Kernel of a Distribution)
//     - 各分布的性质与相互关系

//   Section 3.4: 随机变量函数的分布 (Distributions of Functions of RVs)
//     - 离散型随机变量函数的分布
//     - 连续型随机变量函数的分布


// --- Chapter 4: 多维随机变量及其分布 (Multivariate Random Variables and Distributions) ---

//   Section 4.1: 联合分布 (Joint Distributions)
//     - 多维随机变量
//     - 联合分布函数
//     - 联合分布列 / 联合密度函数
//     - 常用多维分布（多元均匀分布、多元正态分布等）

//   Section 4.2: 边缘分布与独立性 (Marginal Distributions and Independence)
//     - 边缘分布函数
//     - 边缘分布列 / 边缘密度函数
//     - 随机变量间的独立性

//   Section 4.3: 随机变量函数的分布 (Distributions of Functions of RVs)
//     - 多维离散随机变量函数的分布
//     - 最大值与最小值的分布
//     - 卷积公式 (Convolution Formula)
//     - 变量变换法 (Jacobian Method)

//   Section 4.4: 条件分布与条件期望 (Conditional Distributions and Expectation)
//     - 条件分布
//     - 条件数学期望
//     - 全期望公式与全方差公式


// --- Chapter 5: 分布的特征与分类 (Characterization and Classification of Distributions) ---
// 设计思路：补充教材之外的结构性内容——指数族是连接经典分布与现代统计推断的桥梁，
// 多元正态是多元统计的基础。

//   Section 5.1: 指数族 (Exponential Family)
//     - 自然参数与充分统计量的联系
//     - 自然参数空间

//   Section 5.2: 多元正态分布 (Multivariate Normal Distribution)
//     - 定义与性质
//     - 线性变换下的不变性


// ==========================================================================
// Part III — 数字特征与生成工具 (Numerical Characteristics and Generating Tools)
// ==========================================================================
// 设计思路：用数字特征刻画分布，用生成函数提供统一分析工具。
// 特征函数在 Part IV 的极限定理中扮演关键角色（证明 CLT）。
// 对应教材：§2.2–§2.3（期望/方差/不等式）、§2.7（其他特征数）、
//           §3.4（协方差/相关系数）、§4.2（特征函数）

// --- Chapter 6: 数字特征 (Numerical Characteristics) ---

//   Section 6.1: 数学期望 (Mathematical Expectation)
//     - 定义（离散 / 连续）
//     - 性质与运算规则
//     - 马尔可夫不等式 (Markov's Inequality)

//   Section 6.2: 方差与标准差 (Variance and Standard Deviation)
//     - 定义与性质
//     - 切比雪夫不等式 (Chebyshev's Inequality)

//   Section 6.3: 协方差与相关系数 (Covariance and Correlation)
//     - 协方差的定义与性质
//     - 相关系数；不相关与独立的关系
//     - 随机向量的期望向量与协方差矩阵

//   Section 6.4: 分布的其他特征数 (Other Characterization Numbers)
//     - k 阶矩与中心矩
//     - 变异系数 (Coefficient of Variation)
//     - 分位数与中位数 (Quantiles and Median)
//     - 偏度系数 (Skewness)
//     - 峰度系数 (Kurtosis)


// --- Chapter 7: 生成函数与变换方法 (Generating Functions and Transform Methods) ---

//   Section 7.1: 矩母函数 (Moment Generating Functions)
//     - 定义与性质
//     - 唯一性定理

//   Section 7.2: 特征函数 (Characteristic Functions)
//     - 定义与基本性质
//     - 反转公式
//     - 连续性定理
//     - 注：Fourier 分析工具详见 Processus Stochastique

//   Section 7.3: 概率生成函数 (Probability Generating Functions)
//     - 离散情形
//     - 复合分布的应用


// ==========================================================================
// Part IV — 极限定理 (Limit Theorems)
// ==========================================================================
// 设计思路：概率论的理论高峰——从收敛模式到大数定律和中心极限定理，
// 为统计推断的渐近理论提供保证。特征函数在此部分用于证明 CLT。
// 对应教材：第四章 §4.1–§4.4

// --- Chapter 8: 大数定律与中心极限定理 (LLN and CLT) ---

//   Section 8.1: 收敛概念 (Concepts of Convergence)
//     - 依概率收敛
//     - 依分布收敛 / 弱收敛
//     - 几乎必然收敛
//     - L^p 收敛
//     - 各收敛模式之间的关系

//   Section 8.2: 大数定律 (Laws of Large Numbers)
//     - Bernoulli 大数定律
//     - Chebyshev 大数定律
//     - Khinchin 大数定律
//     - Kolmogorov 强大数定律

//   Section 8.3: 中心极限定理 (Central Limit Theorem)
//     - 独立同分布情形 (Lindeberg-Lévy CLT)
//     - 二项分布的正态近似 (De Moivre-Laplace)
//     - 独立不同分布情形 (Lindeberg / Lyapunov 条件)
//     - CLT 的应用与近似计算

//   Section 8.4: Delta 方法 (Delta Method)
//     - 一阶 Delta 方法
//     - 在统计量渐近分布中的应用


// ==========================================================================
// Part V — 数理统计基础 (Fundamentals of Mathematical Statistics)
// ==========================================================================
// 设计思路：从概率论过渡到数理统计——数据如何产生（抽样）、
// 如何压缩信息（充分统计量）。这是从"已知模型推数据"到"从数据推模型"的转折。
// 对应教材：第五章 §5.1–§5.5

// --- Chapter 9: 抽样与经验分布 (Sampling and Empirical Distributions) ---

//   Section 9.1: 总体与样本 (Population and Samples)
//     - 总体与个体
//     - 样本与统计量
//     - 经验分布函数 (Empirical Distribution Function)
//     - Glivenko-Cantelli 定理

//   Section 9.2: 样本矩与抽样分布 (Sample Moments and Sampling Distributions)
//     - 统计量与抽样分布的概念
//     - 样本均值及其抽样分布
//     - 样本方差与样本标准差
//     - 样本矩及其函数
//     - 蒙特卡罗方法 (Monte Carlo Methods)

//   Section 9.3: 次序统计量 (Order Statistics)
//     - 次序统计量的概念
//     - 单个次序统计量的分布
//     - 多个次序统计量及其函数的分布
//     - 样本中位数与样本分位数
//     - 五数概括 (Five-Number Summary) 与箱线图 (Box Plot)

//   Section 9.4: 三大抽样分布 (Three Major Sampling Distributions)
//     - χ² 分布 (Chi-Squared)：定义、性质、分位数
//     - t 分布 (Student's t)：定义、性质、分位数
//     - F 分布 (Fisher's F)：定义、性质、分位数

//   Section 9.5: 正态总体下的抽样分布 (Sampling Distributions under Normality)
//     - X̄ 与 S² 的独立性
//     - 基于正态总体的经典抽样分布结论


// --- Chapter 10: 充分统计量 (Sufficient Statistics) ---

//   Section 10.1: 充分性的概念 (Concept of Sufficiency)

//   Section 10.2: 因子分解定理 (Factorization Theorem)

//   Section 10.3: 完备统计量 (Complete Statistics)
//     - 完备性定义
//     - Bahadur 定理

//   Section 10.4: Ancillary 统计量与 Basu 定理 (Ancillary Statistics and Basu's Theorem)


// ==========================================================================
// Part VI — 参数估计 (Parametric Estimation)
// ==========================================================================
// 设计思路：点估计的方法→评价→改进→区间估计，构成参数估计的完整链条。
// EM 算法和 MLE 渐近正态性是现代计算与理论的重要补充。
// 对应教材：第六章 §6.1–§6.6

// --- Chapter 11: 点估计方法 (Methods of Point Estimation) ---

//   Section 11.1: 矩估计法 (Method of Moments)
//     - 替换原理
//     - 概率函数已知时的矩估计

//   Section 11.2: 极大似然估计法 (Maximum Likelihood Estimation)
//     - 似然函数与 MLE
//     - EM 算法 (EM Algorithm)
//     - MLE 的渐近正态性 (Asymptotic Normality)
//     - MLE 的不变性原理

//   Section 11.3: 最小二乘法 (Least Squares Method)

//   Section 11.4: Bayes 估计 (Bayesian Estimation)
//     - 统计推断的贝叶斯范式
//     - 先验分布的选择与共轭先验族
//     - 后验分布的密度函数形式


// --- Chapter 12: 估计的评价与改进 (Evaluation and Improvement of Estimators) ---

//   Section 12.1: 无偏性 (Unbiasedness)

//   Section 12.2: 有效性与 Cramér-Rao 不等式 (Efficiency and Cramér-Rao Inequality)
//     - Fisher 信息量
//     - Cramér-Rao 下界的推导与等号成立条件

//   Section 12.3: 一致性 / 相合性 (Consistency)
//     - 弱一致性与强一致性
//     - 矩估计与 MLE 的相合性

//   Section 12.4: 均方误差 (Mean Squared Error)

//   Section 12.5: 一致最小方差无偏估计 (UMVUE)
//     - 充分性原则
//     - Rao-Blackwell 定理
//     - Lehmann-Scheffé 定理（基于完备充分统计量）


// --- Chapter 13: 区间估计 (Interval Estimation) ---

//   Section 13.1: 置信区间的概念 (Concept of Confidence Intervals)
//     - 置信水平与频率诠释
//     - 枢轴量法 (Pivotal Quantity Method)

//   Section 13.2: 单个正态总体参数的置信区间 (CIs for Single Normal Population)
//     - μ 的置信区间（σ 已知 / σ 未知）
//     - σ² 的置信区间

//   Section 13.3: 两个正态总体参数的置信区间 (CIs for Two Normal Populations)
//     - μ₁ - μ₂ 的置信区间（含配对样本）
//     - σ₁² / σ₂² 的置信区间

//   Section 13.4: 大样本置信区间 (Large-Sample CIs)

//   Section 13.5: 样本量的确定 (Sample Size Determination)


// ==========================================================================
// Part VII — 假设检验 (Hypothesis Testing)
// ==========================================================================
// 设计思路：从基本思想到具体检验，再到拟合优度与非参数方法。
// 假设检验与置信区间的对偶性是重要的统一视角。
// 对应教材：第七章 §7.1–§7.6

// --- Chapter 14: 假设检验的理论与方法 (Theory and Methods of Hypothesis Testing) ---

//   Section 14.1: 假设检验的基本概念 (Basic Concepts)
//     - 假设检验问题与基本步骤
//     - 第一类错误与第二类错误
//     - P 值 (P-value)

//   Section 14.2: Neyman-Pearson 范式 (Neyman-Pearson Paradigm)
//     - 功效函数 (Power Function)
//     - Neyman-Pearson 引理

//   Section 14.3: 似然比检验 (Likelihood Ratio Tests)
//     - 广义似然比检验的思想

//   Section 14.4: 正态总体参数的假设检验 (Tests for Normal Population Parameters)
//     - 单个正态总体均值的检验（Z 检验、t 检验）
//     - 两个正态总体均值差的检验（含成对数据检验）
//     - 正态总体方差的检验（χ² 检验、F 检验）

//   Section 14.5: 假设检验与置信区间的对偶性 (Duality of Tests and CIs)

//   Section 14.6: 其他分布参数的假设检验 (Tests for Other Distribution Parameters)
//     - 指数分布参数的检验
//     - 比率 p 的检验
//     - 大样本检验


// --- Chapter 15: 拟合检验与非参数检验 (Goodness-of-Fit and Nonparametric Tests) ---

//   Section 15.1: 正态性检验 (Normality Tests)
//     - 正态概率纸 (Normal Probability Paper)
//     - W 检验 (Shapiro-Wilk Test)
//     - EP 检验 (Epstein Test)

//   Section 15.2: χ² 拟合优度与独立性检验 (Chi-Squared Tests)
//     - 分类数据的 χ² 拟合优度检验
//     - 分布的 χ² 拟合优度检验
//     - 列联表的独立性检验

//   Section 15.3: 方差齐性检验 (Tests for Homogeneity of Variances)
//     - Hartley 检验
//     - Bartlett 检验
//     - 修正的 Bartlett 检验

//   Section 15.4: 非参数检验 (Nonparametric Tests)
//     - 游程检验 (Runs Test)
//     - 符号检验 (Sign Test)
//     - Wilcoxon 秩和检验 (Wilcoxon Rank-Sum Test)
//     - Mann-Whitney U 检验


// ==========================================================================
// Part VIII — 方差分析与回归分析 (ANOVA and Regression Analysis)
// ==========================================================================
// 设计思路：统计推断在组间比较与变量关系建模中的核心应用。
// 方差分析本质上是线性模型的特例，两者统一于最小二乘框架。
// 对应教材：第八章 §8.1–§8.5

// --- Chapter 16: 方差分析 (Analysis of Variance) ---

//   Section 16.1: 单因素方差分析 (One-Way ANOVA)
//     - 统计模型
//     - 平方和分解
//     - F 检验
//     - 参数估计
//     - 重复数不等的情形

//   Section 16.2: 多重比较 (Multiple Comparisons)
//     - 水平均值差的置信区间
//     - 重复数相等时的 T 法 (Tukey HSD)
//     - 重复数不等时的 S 法 (Scheffé)

//   Section 16.3: 方差齐性检验 (Tests for Homogeneity of Variances)
//     - Hartley 检验、Bartlett 检验
//     - 与 §15.3 的联系与区别

//   Section 16.4: 双因素方差分析 (Two-Way ANOVA)
//     - 无交互作用模型
//     - 有交互作用模型


// --- Chapter 17: 回归分析 (Regression Analysis) ---

//   Section 17.1: 一元线性回归 (Simple Linear Regression)
//     - 变量间的两类关系
//     - 回归模型与最小二乘估计
//     - 回归方程的显著性检验
//     - 估计与预测

//   Section 17.2: 一元非线性回归 (Simple Nonlinear Regression)
//     - 确定可能的函数形式
//     - 参数估计（线性化方法）
//     - 曲线回归方程的比较

//   Section 17.3: 多元线性回归 (Multiple Linear Regression)
//     - 矩阵表示
//     - 参数估计与统计推断

//   Section 17.4: 回归诊断 (Regression Diagnostics)
//     - 拟合优度 R²
//     - 残差分析


// ==========================================================================
// Part IX — 拓展专题 (Advanced Topics)
// ==========================================================================
// 设计思路：从独立随机变量到相依随机过程的自然延伸，
// 为后续深入学习 Processus Stochastique 搭建桥梁。
// 本部分仅作导论，深入理论参见 Processus Stochastique 笔记。

// --- Chapter 18: 随机过程初步 (Introduction to Stochastic Processes) ---

//   Section 18.1: 随机过程的定义与分类 (Definition and Classification)
//     - 有限维分布；平稳性；独立增量

//   Section 18.2: 离散时间 Markov 链 (Discrete-Time Markov Chains)
//     - 转移概率矩阵；状态分类；平稳分布

//   Section 18.3: Poisson 过程 (Poisson Processes)
//     - 定义与性质；到达时间间隔

//   Section 18.4: 连续时间 Markov 链初步 (Introduction to CTMCs)

//   Section 18.5: Brown 运动初步 (Introduction to Brownian Motion)


// ==========================================================================
// Appendix
// ==========================================================================
// 设计思路：统计分布表供查表使用（对应教材附表），
// Glossary 按字母顺序索引所有定义标签，与仓库其他笔记格式一致。

// --- 统计分布表 (Statistical Distribution Tables) ---
//   - Poisson 分布函数表
//   - 标准正态分布函数表
//   - χ² 分布分位数表
//   - t 分布分位数表
//   - F 分布分位数表
//   - 正态性检验统计量 W 的系数与分位数表
//   - 非参数检验临界值表（游程、Wilcoxon 等）

// --- Glossary ---


// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循"概率论 → 数理统计 → 应用拓展"的三段式主线，共 9 Part、18 Chapter。
//
// Part I–IV（概率论，Ch 1–8）：从公理化的概率空间出发，经随机变量与分布
// （一维→多维）、数字特征与生成函数，到极限定理——构成概率论的完整理论框架。
//
// Part V（过渡，Ch 9–10）：抽样分布与充分统计量是连接概率论与统计推断的桥梁，
// 从"已知模型推数据"转向"从数据推模型"。
//
// Part VI–VIII（数理统计，Ch 11–17）：参数估计（方法→评价→改进→区间）→
// 假设检验（理论→具体检验→拟合/非参数）→ 方差分析与回归分析。
//
// Part IX（拓展，Ch 18）：随机过程初步作为概率论的自然延伸，
// 为后续 Processus Stochastique 笔记做铺垫。
//
// 教材覆盖：茆诗松《概率论与数理统计教程》全部 8 章知识点均已覆盖。
// ==========================================================================


#bibliography("references.bib")

// 目录

