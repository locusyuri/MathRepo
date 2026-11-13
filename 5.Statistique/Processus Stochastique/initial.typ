#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Processus Stochastique", // 随机过程
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Processus Stochastique", // 随机过程
  "Violet",
  subtitle: "A notebook for stochastic processes",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.1.0",
  extra-info: "This is a notebook for stochastic processes.",
)

#make-outline(depth: 2, title: "Contents")

#part("Foundations") // 一般理论

= Stochastic Processes and Finite-Dimensional Distributions // 随机过程与有限维分布

The probability theory of *Probabilités et Statistique* studies one random variable, or a fixed finite family of them.
A *stochastic process* is what appears once a new index — usually time — is allowed to vary, so that an entire family of random variables must be described at once.

Two questions organise this chapter.

- What *is* such a family, as a mathematical object? The answer is a collection of finite-dimensional distributions, subject to consistency conditions.
- Which of these objects possess paths with reasonable regularity? The answer requires separating the law of a process from the choice of a path version.

The first question is settled by Kolmogorov's extension theorem; the second by his continuity criterion.
Everything that follows in this note — Markov chains, the Poisson process, Brownian motion — is a particular way of specifying one of these families and then choosing a path version for it.

== Definition and Classification // 定义与分类

A random variable is a measurable map from a probability space into a measurable state space.
A process is the same object with a parameter attached.

#definition(name: "Stochastic Process")[
  Let $(Omega, cal(F), P)$ be a probability space, $T$ a set, and $(S, cal(S))$ a measurable space.
  A *stochastic process* indexed by $T$ with state space $S$ is a family ${X(t) : t in T}$ of $S$-valued random variables on $Omega$.
  Equivalently, it is a map $X : Omega times T -> S$ such that $omega |-> X(t)(omega)$ is measurable for every fixed $t in T$.
] <def:stochastic-process>

The set $T$ is the *index set* and is read as time; $S$ is the *state space*.
Nothing in the definition requires $T$ to be ordered, but every process treated in this note is indexed by $NN$, by $ZZ$, or by an interval of $RR$.
The two readings of the map $X$ correspond to the two ways of looking at a process.

- Fix $t$: then $X(t)$ is a random variable, and the whole family is a curve in the space of random variables.
- Fix $omega$: then $t |-> X(t)(omega)$ is an ordinary function of time, and the process is a random function.

The second reading is the one that carries the intuition, and it deserves a name.

#definition(name: "Sample Path")[
  For a fixed outcome $omega in Omega$, the function $t |-> X(t)(omega)$ from $T$ to $S$ is the *sample path*, or *trajectory*, of the process at $omega$.
] <def:sample-path>

A process is therefore a probability measure on a space of functions; the sample paths are the individual functions it produces.

The simplest process is an independent sequence.

#example(name: "Discrete white noise")[
  Let $X_1, X_2, dots$ be independent real random variables, all with the same law $nu$, mean $0$ and variance $sigma^2$.
  Indexed by $T = NN^*$ with state space $S = RR$, they form a stochastic process whose sample paths are the real sequences $(x_1, x_2, dots)$.
  It is called *white noise* because consecutive values carry no information about one another: the covariance $op("Cov")(X_i, X_j)$ vanishes for $i != j$.
] <ex:iid-noise>

White noise already shows that a process is more than a list of marginal laws: the *joint* behaviour of different times is part of the data.
That joint behaviour is the subject of the next section.

Two properties of the increments organise most of the classical theory, and both are visible in the models of the later chapters.

#definition(name: "Independent and Stationary Increments")[
  A process ${X(t) : t in T}$ with $T subset.eq RR$ has *independent increments* if for all $t_1 < dots < t_n$ the increments $X(t_2) - X(t_1), dots, X(t_n) - X(t_(n-1))$ are independent.
  It has *stationary increments* if the law of $X(t + h) - X(t)$ depends on $h$ only.
] <def:increments>

The Poisson process of the continuous-time part is characterised by independent, stationary increments together with a counting structure; Brownian motion, by the same two properties together with Gaussian increments.
Independence of increments is the exact counterpart, at the level of a process, of independence of trials at the level of a sequence.

Finally, the pair (index set, state space) sorts the elementary examples into four classes.

#figure(
  image("img/process-classification.svg", width: 82%),
  caption: [The four types of processes obtained by combining a discrete or continuous index set with a discrete or continuous state space, with a canonical example and the place where this note treats it.],
  placement: auto,
  supplement: [Fig.],
) <fig:process-classification>

The four entries are not equally hard.
A discrete index set with a discrete state space is the setting of Markov chains, where everything reduces to matrix algebra; a continuous index set with a continuous state space is the setting of Brownian motion, where the paths are irregular enough to require a new integral.

== Finite-Dimensional Distributions // 有限维分布

An experiment never observes a whole path.
It records the values of the process at finitely many times, and a process is known once the joint law of every such finite sample is known.
This section makes that statement precise and asks when a prescribed family of joint laws really comes from a process.

#definition(name: "Finite-Dimensional Distributions")[
  The *finite-dimensional distributions* of a process ${X(t) : t in T}$ are the probability measures
  $
    mu_(t_1 dots t_n)(B_1 times dots times B_n) = P(X(t_1) in B_1, dots, X(t_n) in B_n),
  $
  indexed by $n >= 1$, by $t_1, dots, t_n in T$ and by measurable sets $B_1, dots, B_n subset.eq S$.
] <def:finite-dimensional-distributions>

The family ${mu_(t_1 dots t_n)}$ cannot be arbitrary: a joint law determines its marginals, so the measures attached to different tuples of times must agree on the overlap.

#property(name: "Consistency of the Finite-Dimensional Distributions")[
  The family ${mu_(t_1 dots t_n)}$ of a process is consistent in two senses.

  - (marginal consistency) If $(s_1, dots, s_m)$ is a subfamily of $(t_1, dots, t_n)$, then $mu_(s_1 dots s_m)$ is the corresponding marginal of $mu_(t_1 dots t_n)$.
  - (permutation consistency) $mu_(t_1 dots t_n)$ is unchanged when the times and the sets are permuted simultaneously.
] <prop:fdd-consistency>

#proof[
  Both statements follow from the definition by integrating out the irrelevant coordinates.
  For the first, sum over the remaining variables, which is legitimate by the law of total probability; for the second, note that a joint law is symmetric in its arguments, since the event $X(t_i) in B_i$ for all $i$ does not depend on the order in which the conditions are listed.
]

#figure(
  image("img/fdd-consistency.svg", width: 72%),
  caption: [Marginal consistency: a three-dimensional law determines its two-dimensional and one-dimensional marginals, and every marginal obtained from the same high-dimensional law agrees with the one computed directly.],
  placement: auto,
  supplement: [Fig.],
) <fig:fdd-consistency>

The converse is the content of the extension theorem: consistency is not merely necessary but also sufficient.

#theorem(name: "Kolmogorov's Extension Theorem")[
  Let $T$ be a set, let $(S, cal(S))$ be a standard Borel space, and let ${mu_(t_1 dots t_n)}$ be a consistent family of probability measures on $S^n$, $n >= 1$.
  Then there exist a probability space $(Omega, cal(F), P)$ and a process ${X(t) : t in T}$ on it whose finite-dimensional distributions are exactly the given family.
] <thm:kolmogorov-extension>

#note(title: "Division of labour")[
  The proof is measure-theoretic: one builds the product σ-algebra on $S^T$, checks that the consistent family defines a finitely additive set function on the algebra of cylinder sets, and extends it by Carathéodory's theorem.
  This is the machinery of the Analyse Réelle note, and it is not repeated here.
  What matters for the sequel is the *content* of the theorem: a process may be specified by its finite-dimensional distributions alone, with no reference to a path space.
]

The theorem is the licence to define every model in this note the same way: write down the joint law of finitely many times, check consistency, and let the theorem produce the process.
Two warnings must accompany that licence.

#caution(title: "The finite-dimensional distributions do not determine the paths")[
  The extension theorem produces *some* process with the prescribed finite-dimensional distributions, and it gives no control whatsoever on its sample paths.
  Two processes may share every finite-dimensional distribution and still have paths that differ on a set of times of full measure.
  The counterexample appears in *Path Regularity*, where the distinction between a law and a path version is made precise.
  Every model below therefore has to specify a path version, not only a family of laws.
]

The description of white noise in terms of joint laws is immediate.

#example(name: "The finite-dimensional distributions of white noise")[
  For the independent sequence of #link(<ex:iid-noise>)[*Discrete white noise*], the joint law of $X(t_1), dots, X(t_n)$ is the product measure
  $
    mu_(t_1 dots t_n) = nu^(times n),
  $
  independently of the times $t_1, dots, t_n$.
  Consistency is then obvious: a marginal of a product measure is again a product measure, and the order of the factors is irrelevant.
  The family is therefore consistent, and the extension theorem recovers the sequence from its finite-dimensional distributions.
] <ex:fdd-of-white-noise>

White noise is the exceptional case in which the joint laws are as simple as the marginal ones.
In every other model of this note the dependence between different times is the whole point, and the finite-dimensional distributions encode it: for a Markov chain they factor through the transition matrix, for the Poisson process they are forced by independent increments, and for Brownian motion by Gaussian increments.

== Path Regularity // 路径正则性

The extension theorem produces a process from a family of laws and says nothing about the paths of the result.
Two processes with identical finite-dimensional distributions may differ on a set of times that carries the whole probability.
This section separates the two notions, then gives the standard criterion under which a well-behaved version can be recovered.

#definition(name: "Modification and Indistinguishability")[
  Two processes ${X(t) : t in T}$ and ${Y(t) : t in T}$ on the same probability space are *modifications* of each other if, for every $t in T$,
  $
    P(X(t) = Y(t)) = 1.
  $
  They are *indistinguishable* if
  $
    P(X(t) = Y(t) "for all" t in T) = 1.
  $
] <def:modification>

Indistinguishability plainly implies being a modification.
The converse holds whenever the index set is countable, since a countable union of null sets is null; it fails in general, and the failure is exactly what makes path regularity a separate problem.

#example(name: "Same finite-dimensional distributions, different paths")[
  Let $U$ be uniform on $[0, 1]$, let $T = [0, 1]$, and put $X(t) = 0$ for every $t$.
  Define $Y(t) = 1$ when $t = U$ and $Y(t) = 0$ otherwise.
  For each fixed $t$ one has $P(Y(t) = 1) = P(U = t) = 0$, so $X$ and $Y$ are modifications and share every finite-dimensional distribution.
  Yet $P(Y(t) = X(t) "for all" t) = 0$: the two paths differ at the single time $U$, which is random.
] <ex:same-fdd-different-paths>

This is the precise form of the warning stated after the extension theorem.
A law determines the distribution of the *values*, never the distribution of the *path*; the two are linked only when the index set is countable.

Separating laws from paths requires a measurability condition on $X$ viewed as a function of $t$.

#definition(name: "Separable Process")[
  A process ${X(t) : t in T}$ with $T subset.eq RR$ is *separable* if there exist a countable set $D subset.eq T$ and a null set $N in cal(F)$ such that, for every $omega in.not N$ and every open interval $I$,
  $
    sup_(t in I) X(t)(omega) = sup_(t in I inter D) X(t)(omega).
  $
] <def:separable-process>

Separability says that suprema over uncountable families of times can be read off from a countable set, which is what makes quantities such as $sup_(t <= T) X(t)$ measurable.
Every process has a separable modification; the construction is again measure-theoretic and belongs to the Analyse Réelle note.

Separability makes the path measurable, but not continuous.
Continuity is bought by a moment condition on the increments.

#theorem(name: "Kolmogorov's Continuity Criterion")[
  Let ${X(t) : t in [0, 1]}$ be a process such that, for some constants $alpha > 0$, $beta > 0$ and $C < infinity$,
  $
    bb(E)[abs(X(t) - X(s))^alpha] <= C abs(t - s)^(1 + beta)
  $
  for all $s, t in [0, 1]$.
  Then $X$ has a modification whose sample paths are Hölder continuous of every order $gamma < beta \/ alpha$.
] <thm:kolmogorov-continuity>

#proof[
  Fix $gamma < beta \/ alpha$ and let $D_n = \{k 2^(-n) : k = 0, dots, 2^n\}$ be the dyadic grid of level $n$.

  *Step 1 (dyadic increments).* For $n >= 1$ set
  $
    A_n = union.big_(k=1)^(2^n) \{abs(X(k 2^(-n)) - X((k-1) 2^(-n))) > 2^(-n gamma)\}.
  $
  Markov's inequality bounds each term by $C 2^(-n (1 + beta) + n gamma alpha)$, and there are $2^n$ of them, so
  $
    P(A_n) <= C 2^(-n (beta - gamma alpha)).
  $
  Since $beta - gamma alpha > 0$, the series $sum_n P(A_n)$ converges, and the Borel–Cantelli lemma gives $P(limsup A_n) = 0$.

  *Step 2 (uniform control on the grid).* Off the null set of Step 1, for every $omega$ there is an index $n_0 (omega)$ such that every dyadic increment of level $n >= n_0 (omega)$ is at most $2^(-n gamma)$.
  Two points of $D = union.big_(n >= 0) D_n$ at distance at most $2^(-n)$ are joined by finitely many dyadic increments, at most two per level, so
  $
    abs(X(s) - X(t)) <= K_gamma 2^(-n gamma)
  $
  for a constant $K_gamma$ depending on $gamma$ only.
  On $D$ the process is therefore uniformly Hölder continuous of order $gamma$.

  *Step 3 (extension).* Set $tilde(X)(t) = lim_(s -> t, s in D) X(s)$ whenever the limit exists, and $tilde(X)(t) = 0$ otherwise.
  Since $D$ is dense and $X$ is uniformly continuous on $D$, the limit exists off a null set, and the resulting process has continuous paths with the same Hölder constant.

  *Step 4 (modification).* Fix $t in [0, 1]$ and choose $t_n in D_n$ with $abs(t_n - t) <= 2^(-n)$.
  The same Markov bound applied to the pair $(t_n, t)$, followed by Borel–Cantelli, gives $X(t_n) -> X(t)$ almost surely, while $X(t_n) -> tilde(X)(t)$ almost surely by construction.
  Hence $P(tilde(X)(t) = X(t)) = 1$, and $tilde(X)$ is a modification of $X$.
]

The criterion is the only place in this chapter where a path property is proved rather than assumed.
Its hypothesis is a *local* moment condition — increments over short intervals are controlled on average — and its conclusion is a *global* regularity statement.
That gap between local control and global regularity is the recurring theme of stochastic analysis, and it reappears in the quadratic variation of Brownian motion.

Two path spaces will be used in the continuous-time part.

- $C([0, T])$, the continuous functions, equipped with the supremum norm.
- $D([0, T])$, the right-continuous functions with left limits, equipped with the Skorokhod topology.

The first suits Brownian motion, the second the Poisson process, whose paths jump.

== Stationarity and Ergodic Ideas // 平稳性与遍历思想

Until now the finite-dimensional distributions were an arbitrary consistent family.
Structural assumptions on that family select the models of the later chapters, and the most important of them is invariance under time shift.

#definition(name: "Stationary Process")[
  A process ${X(t) : t in T}$ with $T subset.eq RR$ is *strictly stationary* if, for every $n >= 1$, all $t_1, dots, t_n$ and every $h$, the law of $(X(t_1 + h), dots, X(t_n + h))$ does not depend on $h$.
] <def:stationary-process>

Strict stationarity is a statement about whole joint laws and says nothing about moments.
When second moments exist, the dependence structure is summarised by two numerical functions.

#definition(name: "Mean and Covariance Functions")[
  Let ${X(t) : t in T}$ have finite second moments.
  Its *mean function* is $m(t) = bb(E)[X(t)]$, and its *covariance function* is
  $
    gamma(s, t) = op("Cov")(X(s), X(t)) = bb(E)[(X(s) - m(s))(X(t) - m(t))].
  $
] <def:covariance-function>

#property(name: "Weak Stationarity")[
  A process is *weakly stationary* if $m(t)$ is constant and $gamma(s, t)$ depends on $t - s$ only.
  Strict stationarity together with finite second moments implies weak stationarity; the converse fails in general.
] <prop:stationary-covariance>

The converse does hold for Gaussian processes: such a process is determined by its mean and covariance functions, so weak and strict stationarity coincide.
This is why the theory of stationary time series is written almost entirely in terms of $gamma$.

#example(name: "Stationary increments without stationarity")[
  The Poisson process and Brownian motion both have stationary increments, yet neither is stationary: the law of $N(t)$ depends on $t$, and $"Var"(B(t)) = t$.
  Stationarity of the increments is a statement about the *changes* of the process, not about its values.
] <ex:stationary-increments>

The usefulness of stationarity lies in the possibility of averaging along a single path.

#note(title: "The ergodic theorem, informally")[
  For a stationary process with $bb(E)[abs(X(0))] < infinity$, the time average
  $
    (1 / T) integral_0^T X(t) dif t
  $
  is expected to converge, as $T -> infinity$, to the constant $bb(E)[X(0)]$.
  Without a further hypothesis the statement is false; the hypothesis is *ergodicity*, and the precise theorem (Birkhoff's) is proved in the Analyse Harmonique note, together with the spectral decomposition that makes it effective.
  The Markov-chain version appears in *Discrete-Time Markov Chains*, where it becomes the equality of time averages and space averages.
]

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
//
// 教材基准：Ross《Stochastic Processes》(2nd) 为主干骨架；
//           Karlin–Taylor《A First Course in Stochastic Processes》(2nd)
//           与 Grimmett–Stirzaker (4th) 提供测度论层面的严格化；
//           Norris《Markov Chains》支撑 Part II–III 的链论部分；
//           Øksendal《SDE》(6th) 与 Karatzas–Shreve 支撑 Part IV；
//           中文参考：钱敏平、龚光鲁《随机过程论》。
//
// 主线："一般理论 → 离散时间 → 连续时间 → 随机分析"四段递进：
//   先把过程定义为对象并建立两件工具（条件期望、鞅），
//   再沿"时间参数离散→连续、路径正则性由弱到强"推进，
//   最后进入以 Brown 运动为驱动的随机分析。
//
// 职责边界：
//   - σ-代数、可测性、Kolmogorov 扩展定理的证明 → Analyse Réelle
//   - Fourier 分析、谱理论与平稳过程的谱分解        → Analyse Harmonique
//   - 分布、特征函数、LLN / CLT、初等条件期望       → Probabilités et Statistique
//   - MCMC 的统计推断应用                            → Probabilités et Statistique
//   - 排队网络的运筹优化视角                          → 运筹学笔记
//   本笔记只引用上述结论，不重复证明。

// ==========================================================================
// Part I — Foundations (一般理论)  [待写出]
// ==========================================================================
// 设计思路：先把"随机过程"作为数学对象定义清楚——指标集、状态空间、
// 有限维分布、路径正则性——避免后面各章各自为政地重述。
// 随后建立全书共用的两件工具：条件期望与鞅。鞅独立成章放在最前，
// 因为 Markov 链的调和函数、Brown 运动的可选停时、Itô 积分的
// 鞅表示定理都要直接调用；若推迟到 Part III 再讲，会造成大量前向依赖。
// 对应教材：Ross Ch 1；Grimmett–Stirzaker Ch 6、Ch 12；Williams Ch 9–11

// --- Chapter 1: Stochastic Processes and Finite-Dimensional Distributions (随机过程与有限维分布) ---

//   Section 1.1: Definition and Classification (定义与分类)
//     - 指标集与状态空间；样本路径
//     - 独立增量过程与平稳增量过程
//     - 四象限分类：离散/连续时间 × 离散/连续状态

//   Section 1.2: Finite-Dimensional Distributions (有限维分布)
//     - 有限维分布的相容性条件
//     - Kolmogorov 扩展定理（陈述；证明见 Analyse Réelle）
//     - 由有限维分布确定过程律的含义与局限

//   Section 1.3: Path Regularity (路径正则性)
//     - 可分性 (separability) 与修正 (modification)
//     - 连续版本的存在性：Kolmogorov 连续性准则
//     - 路径空间 C([0,T]) 与右连左极路径 D([0,T]) 初步

//   Section 1.4: Stationarity and Ergodic Ideas (平稳性与遍历思想)
//     - 严平稳与弱平稳
//     - 均值函数与协方差函数
//     - 遍历定理的直观陈述（严格版本见 Analyse Harmonique 的谱分解）


// --- Chapter 2: Conditional Expectation and Martingales (条件期望与鞅) ---

//   Section 2.1: Conditional Expectation (条件期望)
//     - 关于 σ-代数的条件期望：存在性、唯一性、基本性质
//     - 塔性质；条件 Jensen 不等式
//     - 与初等条件期望（Probabilités et Statistique）的衔接

//   Section 2.2: Martingales and Stopping Times (鞅与停时)
//     - 鞅、下鞅、上鞅；典型例子（随机游走、似然比、Doob 鞅）
//     - 停时与停时 σ-代数
//     - Doob 分解（可选）

//   Section 2.3: Optional Stopping Theorem (可选停时定理)
//     - 有界停时版本；一致可积版本
//     - 应用：赌徒破产、Wald 等式、首中时期望

//   Section 2.4: Martingale Convergence (鞅收敛)
//     - 上穿不等式与几乎必然收敛定理
//     - L^1 / L^2 收敛；一致可积性
//     - 反向鞅与 Lévy 上穿


// ==========================================================================
// Part II — Discrete Time (离散时间)  [待写出]
// ==========================================================================
// 设计思路：离散时间是结构最清晰、证明最完整的战场：Markov 链把
// "独立性失效"以最少的工具处理掉，随机游走是它的样板实例，
// 分枝与排队则给出两类典型应用。本章的结论在 Part III 连续化时
// 反复对照。
// 对应教材：Ross Ch 2、Ch 3；Norris Ch 1–3；Grimmett–Stirzaker Ch 6


// --- Chapter 3: Discrete-Time Markov Chains (离散时间 Markov 链) ---

//   Section 3.1: Transition Probabilities (转移概率)
//     - Markov 性与转移矩阵；时间齐次性
//     - Chapman–Kolmogorov 方程与 n 步转移
//     - 强 Markov 性与首中时

//   Section 3.2: Classification of States (状态分类)
//     - 常返、暂留、周期；闭类与不可约性
//     - 常返判据：∑ p_n 级数判别
//     - 正常返与零常返

//   Section 3.3: Stationary Distributions (平稳分布)
//     - 平稳分布的存在唯一性
//     - 极限定理：不可约非周期链的收敛
//     - 细致平衡与可逆测度

//   Section 3.4: Ergodic Theorems and Convergence Rate (遍历定理与收敛速度)
//     - 遍历定理：时间平均 = 空间平均
//     - 耦合方法与全变差距离
//     - 谱隙与 Poincaré / Cheeger 不等式（初步）

//   Section 3.5: MCMC (Markov 链 Monte Carlo)
//     - Metropolis–Hastings 算法
//     - Gibbs 抽样
//     - 收敛诊断；与统计推断衔接（应用细节见 Probabilités et Statistique）


// --- Chapter 4: Random Walks (随机游走) ---

//   Section 4.1: Recurrence and Transience (常返与暂留)
//     - 简单随机游走在 $ZZ^d$ 上的常返性判据
//     - 局部中心极限定理（陈述）
//     - 与 Part I 鞅工具的联系

//   Section 4.2: Hitting Times and Reflection (首中时与反射)
//     - 反射原理与首中时分布
//     - 最大值分布；反正弦律
//     - 有偏随机游走；破产问题

//   Section 4.3: Renewal Theory (更新理论)
//     - 更新过程与更新函数
//     - 更新定理；剩余寿命与前向递推
//     - 更新报酬过程（可选）


// --- Chapter 5: Branching and Queueing (分枝与排队) ---

//   Section 5.1: Galton–Watson Process (Galton–Watson 过程)
//     - 后代分布与生成函数迭代
//     - 灭绝概率：最小不动点定理
//     - 临界、次临界、超临界情形

//   Section 5.2: Queueing Models (排队模型)
//     - 排队系统的描述（到达、服务、队列规则）
//     - Little 律
//     - 与 Part III 连续时间模型的接口


// ==========================================================================
// Part III — Continuous Time (连续时间)  [待写出]
// ==========================================================================
// 设计思路：连续化的两条主线——计数型（Poisson，跳过程）与分析型
// （Brown 运动，连续路径）。二者分别对应 Part II 的随机游走与更新过程，
// 且都以 Part I 的鞅论为核心工具。排队论放在连续时间一侧，
// 因为它天然由 Poisson 到达驱动。
// 对应教材：Ross Ch 5、Ch 8；Karatzas–Shreve Ch 1–2；Grimmett–Stirzaker Ch 8

// --- Chapter 6: Poisson Process (Poisson 过程) ---

//   Section 6.1: Definitions and Equivalences (定义与等价刻画)
//     - 计数过程；独立平稳增量刻画
//     - 到达间隔刻画；无穷小刻画
//     - 三条定义等价性的证明

//   Section 6.2: Inter-arrival Times (到达间隔)
//     - 间隔 i.i.d. 指数；第 n 次到达为 Erlang / Gamma
//     - 条件到达时刻的均匀分布
//     - 与 Probabilités et Statistique 中 Erlang 分布的关系

//   Section 6.3: Operations on Poisson Processes (Poisson 过程的运算)
//     - 复合 Poisson 过程（与 PGF 章的复合分布呼应）
//     - 稀疏化 (thinning) 与叠加 (superposition)
//     - 标记定理

//   Section 6.4: Non-homogeneous and Cox Processes (非齐次与 Cox 过程)
//     - 非齐次强度函数与时间变换
//     - Cox 过程（双重随机）述评


// --- Chapter 7: Continuous-Time Markov Chains (连续时间 Markov 链) ---

//   Section 7.1: Generator and Kolmogorov Equations (生成矩阵与 Kolmogorov 方程)
//     - 转移半群；生成矩阵 $Q$
//     - Kolmogorov 前向 / 后向方程
//     - 嵌入链与爆炸现象

//   Section 7.2: Birth–Death Processes (生灭过程)
//     - 生灭链的常返性与平稳分布
//     - 具体模型：线性生灭、M/M/∞
//     - 与 Part II 离散链的对照

//   Section 7.3: Queueing Theory (排队论)
//     - M/M/1 与 M/M/c：平稳分布、等待时间
//     - M/G/1 与 Pollaczek–Khinchin 公式（陈述）
//     - 排队网络的 Jackson 定理（可选）


// --- Chapter 8: Brownian Motion (Brown 运动) ---

//   Section 8.1: Definition and Construction (定义与构造)
//     - 定义：独立平稳增量 + 高斯增量 + 连续路径
//     - Lévy–Ciesielski 构造与随机游走极限（Donsker 定理）
//     - 与 Part II 随机游走的对应

//   Section 8.2: Martingale Properties and Strong Markov (鞅性质与强 Markov 性)
//     - $B(t)$、$B(t)^2 - t$、指数鞅
//     - 强 Markov 性与反射原理
//     - 首中时分布与反正弦律

//   Section 8.3: Path Properties (路径性质)
//     - 处处不可微；Hölder 正则性
//     - 二次变差与协变差
//     - 重对数律；零点集与水平集的结构

//   Section 8.4: Brownian Motion and PDE (Brown 运动与偏微分方程)
//     - 热方程的基本解
//     - 热半群与 Feynman–Kac 的预备
//     - 边值问题与调和测度


// ==========================================================================
// Part IV — Stochastic Analysis (随机分析)  [待写出]
// ==========================================================================
// 设计思路：以 Brown 运动为驱动建立积分与微分方程理论。Itô 积分
// 之所以存在，根源在 Part III 的二次变差（路径不够正则，无法用
// Riemann–Stieltjes）；Itô 公式则是这一事实的补偿项。末章给出
// Girsanov 与 Feynman–Kac，把前文的鞅工具、偏微分方程与应用串起来。
// 对应教材：Øksendal Ch 3–5；Karatzas–Shreve Ch 3–5；Protter Ch 1–2

// --- Chapter 9: Itô Integral and Itô's Formula (Itô 积分与 Itô 公式) ---

//   Section 9.1: Construction of the Integral (积分构造)
//     - 简单过程的积分；$L^2$ 等距
//     - 可积过程的延拓；积分作为鞅
//     - 二次变差与积分过程的协变差

//   Section 9.2: Itô's Formula (Itô 公式)
//     - 一维 Itô 公式的陈述与证明
//     - 多维版本与分部积分公式
//     - 例：几何 Brown 运动、$B(t)^2 - t$ 的再推导

//   Section 9.3: Martingale Representation (鞅表示定理)
//     - 关于 Brown 过滤的鞅表示
//     - 与可预测过程的对应
//     - Girsanov 定理的预备


// --- Chapter 10: Stochastic Differential Equations (随机微分方程) ---

//   Section 10.1: Existence and Uniqueness (存在唯一性)
//     - 强解：Lipschitz 与线性增长条件
//     - Picard 迭代
//     - 弱解与轨道唯一性（述评）

//   Section 10.2: Linear SDEs and the Ornstein–Uhlenbeck Process (线性方程与 OU 过程)
//     - 线性 SDE 的显式解
//     - 几何 Brown 运动
//     - OU 过程的平稳性与遍历性

//   Section 10.3: Girsanov and Change of Measure (Girsanov 与测度变换)
//     - 指数鞅与测度变换
//     - Girsanov 定理
//     - 漂移的消除；风险中性测度的动机

//   Section 10.4: Feynman–Kac and Black–Scholes (Feynman–Kac 与 Black–Scholes)
//     - Feynman–Kac 公式：PDE 的概率表示
//     - Black–Scholes 方程与其概率解
//     - 从鞅定价到 PDE 定价的两条路径


// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循"一般理论 → 离散时间 → 连续时间 → 随机分析"的四段式主线，
// 共 4 Part、10 Chapter。
//
// Part I（一般理论，Ch 1–2）：过程作为对象的定义（有限维分布、路径正则性）
// → 条件期望与鞅（全书工具章）。
//
// Part II（离散时间，Ch 3–5）：Markov 链（分类、平稳、遍历、MCMC）
// → 随机游走（常返、首中、更新）→ 分枝与排队。
//
// Part III（连续时间，Ch 6–8）：Poisson 过程（计数型）
// → 连续时间 Markov 链与排队 → Brown 运动（连续路径型）。
//
// Part IV（随机分析，Ch 9–10）：Itô 积分与公式 → SDE、Girsanov、
// Feynman–Kac 与 Black–Scholes。
//
// 与 Probabilités et Statistique 的分工：后者负责分布、特征函数、
// LLN / CLT 与统计推断，不涉及时间演化；本笔记从"独立增量与相依性"
// 开始，两本笔记在 Poisson 极限定理、Erlang 分布、复合分布处交叉引用。
// ==========================================================================


#bibliography("references.bib", title: "References", full: true)
