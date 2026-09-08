#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Théorie des Nombres", // 数论
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Théorie des Nombres", // 数论
  "Violet",
  subtitle: "A notebook for number theory",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.1.0",
  extra-info: "This is a notebook for number theory.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
// 主线叙事 (Main Narrative):
//   整除基础 → 模结构与剩余理论 → 算术函数与素数分布 → 逼近与不定方程
//   研究对象从 ℤ 上的整除算术出发，经模结构（CRT、Fermat–Euler、
//   原根、二次互反）逐步深化，再借算术函数把"计数与分布"工具化，
//   最后以连分数与不定方程收束为经典应用。
//
// 职责边界 (Responsibility Boundaries):
//   - 整数的整除/同余/原根/二次剩余/数论函数/连分数/不定方程 → 本笔记核心内容
//   - 环论视角（剩余类环 ℤ_n、CRT 的环同构、UFD/PID/ED、有限域、分圆域）
//     → Algèbre Abstraite，本笔记用算术语言自含并作结构交叉引用
//   - 多项式整除性、有理根、Eisenstein 判据 → Polynôme（本笔记不重复）
//   - 完整解析数论（PNT 证明、L-函数）→ 本笔记仅概述，完整理论归未来解析数论笔记
//   - p-adic 数、二元二次型、数的分拆等 → 超出范围，仅在 §8.3 展望
//
// 参考教材 (Reference Textbooks):
//   - 华罗庚《华罗庚文集 · 数论卷 II（数论导引）》科学出版社, 2010
//   - 余红兵《数论》华东师范大学出版社, 2011
//
// 结构：4 Parts, 10 Chapters, 约 40 Sections

// ==========================================================================
// Part I — Divisibility Theory（整除理论）
// ==========================================================================
// 设计思路：从 ℤ 上的整除结构出发建立全书根基：带余除法与进位制、
// gcd/lcm、辗转相除法与 Bézout 恒等式，再以素数无穷性与算术基本定理收束。
// 对应教材：华罗庚 Ch1（整数之分解）；余红兵 §1–3
// 对应 LaTeX：chap01.tex（拆分为 Ch1 与 Ch2）

// --- Chapter 1: Divisibility（整除性）---
//   核心洞察：带余除法是 ℤ 上"除"的完备答案——gcd 存在、Bézout 线性表示、
//   gcd·lcm 恒等式均由它机械推出；Ch2 的唯一分解即此引擎的首次总爆发。
//   Section 1.1: Integers and Floor/Ceiling Functions（整数与取整函数）
//     - 良序原理 #proposition <prop:well-ordering>（证明引擎，§1.2/§1.5 回链）
//     - floor/ceiling 与小数部分 #definition <def:floor-ceiling>；
//       刻画 <prop:floor-basic>、平移对偶 <prop:floor-identities>；<eq:hermite-identity>
//     - Hermite 恒等式 <prop:hermite-identity>（小数部分 1/n 网格统计）
//     - 数值例 <ex:floor-values>；#note 取整函数供 Ch7 求和消费（伏笔）
//   Section 1.2: Divisibility and the Division Algorithm（整除性与带余除法）
//     - 整除定义 #definition <def:divisibility>；运算律表 #property <prop:divisibility-rules>
//       （真因子 prose 概念，供 Ch2 素数定义）；Polynôme 多项式版仅 #note 划界
//     - 带余除法定理 #theorem <thm:division-algorithm>（良序取最小剩余 + 唯一性反证）
//     - 核心式 <eq:division-identity>；数值例 <ex:division-example>（含负数情形）
//     - #note 带余除法引向同余 Ch3 / 欧几里得引理 Ch2（伏笔）
//   Section 1.3: Numeral Systems（进位制）
//     - r 进制展开 #definition <def:numeral-system>；唯一性由反复带余除法（回链 thm）
//     - 转换例 <ex:base-conversion>；平衡三进制 #note（竞赛向，简明）
//   Section 1.4: GCD and LCM（最大公因数与最小公倍数）
//     - gcd/lcm/互素 #definition <def:gcd> <def:lcm> <def:coprime>
//     - 初等性质 #proposition <prop:gcd-basic>；
//       gcd | 一切线性组合 #corollary <cor:gcd-divides-linear>
//     - 例 <ex:gcd-lcm-example>（观察 6·90 = 18·30，暂不证）
//     - 乘积恒等式 |ab| 证明依赖 Bézout，留 §1.5 <cor:gcd-lcm-product> 兑现
//   Section 1.5: Euclidean Algorithm and Bézout's Identity（辗转相除法与 Bézout 恒等式）
//     - 换余引理 #lemma <lem:gcd-substitution>（公约数集合相等）
//     - 辗转相除法 #theorem <thm:euclidean-algorithm>（余数严格递减 ⇒ 有限步）
//     - Bézout 恒等式 #theorem <thm:bezout>（Euclid 步骤反向归纳构造）
//     - 算法呈现：编号算法框 + 回代表（非 C++ 代码块）；例 <ex:euclid-example>
//       <ex:bezout-example>（252 与 105：21 = 5·105 − 2·252）
//     - 互素判据 #corollary <cor:bezout-coprime>；核心式 <eq:bezout>
//     - 乘积恒等式 <cor:gcd-lcm-product> + <eq:gcd-lcm-product>（互素可消去引理）
//     - 章末 #note：Bézout → Ch10 §10.1 一次不定方程通解（兑现蓝图伏笔）
//   图片：fig:euclid-rectangle（img/euclid-rectangle.svg，24×9 矩形切 9²,9²,6²,3²,3²
//     → gcd 3；A 级核心图；占位先复制 0.Wiki/null.svg）
//   写作顺序：§1.2 定义+带余除法 → §1.1 良序/取整 → §1.4 → §1.5 → §1.3 → 章首串联；
//     每 1-2 节编译一次，编译检查点：§1.2 后、§1.5 后、全章终检

// --- Chapter 2: Primes and the Fundamental Theorem of Arithmetic（素数与算术基本定理）---
//   Section 2.1: Prime Numbers and the Infinitude of Primes（素数及其无穷性）
//     - 素数/合数、最小正因子引理
//     - Euclid 无穷性证明
//   Section 2.2: The Fundamental Theorem of Arithmetic（算术基本定理）
//     - 分解存在性（强归纳）与唯一性
//     - 标准分解式
//   Section 2.3: Sieve Methods（筛法）
//     - Eratosthenes 筛、Euler 筛（含 C++ 实现）
//   Section 2.4: Applications of Unique Factorization（唯一分解的应用）
//     - 由分解式计算 gcd/lcm
//     - n! 中素数 p 的指数（Legendre 公式）

// ==========================================================================
// Part II — Theory of Congruences（同余理论）
// ==========================================================================
// 设计思路：模结构逐级深化。先建立同余语言与 CRT（环同构视角交叉引用
// Algèbre Abstraite），再证 Fermat–Euler–Wilson 三定理，继而研究阶与
// 原根（(ℤ/mℤ)ˣ 的循环结构），最后以二次剩余与互反律收束为本部分
// 最完整的经典定理。原根板块显式列出，避免隐藏于同余章。
// 对应教材：华罗庚 Ch2（同余式）、Ch3（二次剩余）；余红兵 Ch6
// 对应 LaTeX：chap02.tex（拆为 Ch3–Ch5），chap03.tex（→ Ch6）

// --- Chapter 3: Basic Theory of Congruences（同余的基本理论）---
//   Section 3.1: Congruences and Their Properties（同余及其性质）
//     - 同余的定义与运算规则
//     - 消去律成立的条件
//   Section 3.2: Residue Classes and Systems（剩余类与剩余系）
//     - 完全剩余系、既约剩余系
//     - 简化剩余系的乘法性质
//   Section 3.3: Linear Congruences（一次同余）
//     - ax ≡ b (mod m) 的可解条件与解数
//   Section 3.4: The Chinese Remainder Theorem（中国剩余定理）
//     - 互素模情形与非互素处理
//     - 环同构 ℤ_m ≅ ℤ_(m_1) × … 视角（@Algèbre Abstraite 蓝图 §9.4）
//   Section 3.5: Euler's φ Function（Euler φ 函数）
//     - 定义与计算公式（既约剩余系视角）
//     - 积性性质（引向 Ch7 卷积处理）

// --- Chapter 4: Theorems of Fermat, Euler, and Wilson（Fermat–Euler–Wilson 定理）---
//   Section 4.1: Fermat's Little Theorem（Fermat 小定理）
//     - a^p ≡ a (mod p)；组合与群论两种证明
//   Section 4.2: Euler's Theorem（Euler 定理）
//     - a^φ(m) ≡ 1 (mod m) 及其推论
//   Section 4.3: Wilson's Theorem（Wilson 定理）
//     - (p-1)! ≡ -1 (mod p) 及逆定理
//   Section 4.4: Applications（应用与伪素数）
//     - 快速模幂（C++ 实现）
//     - Fermat 伪素数、Carmichael 数（引向 Ch8 §8.4）

// --- Chapter 5: Primitive Roots and Discrete Logarithms（原根与离散对数）---
//   Section 5.1: The Order of an Integer（元素的阶）
//     - 阶的定义与性质、o(m,a) | φ(m)
//   Section 5.2: Existence of Primitive Roots（原根的存在性）
//     - 模 p、p^α、2p^α 原根存在性
//     - 原根个数 φ(φ(m))
//   Section 5.3: Indices and Discrete Logarithms（指数与离散对数）
//     - 指标表、幂方程 x^k ≡ a 的求解
//   Section 5.4: Power Residues（幂剩余）
//     - n 次剩余判别条件（n = 2 特例引向 Ch6）

// --- Chapter 6: Quadratic Residues and the Law of Quadratic Reciprocity（二次剩余与二次互反律）---
//   Section 6.1: Quadratic Residues and Legendre Symbols（二次剩余与 Legendre 符号）
//     - Euler 判据、Legendre 符号及其运算律
//   Section 6.2: Gauss's Lemma（Gauss 引理）
//     - 特殊值 (-1/p)、(2/p)
//   Section 6.3: The Law of Quadratic Reciprocity（二次互反律）
//     - 互反律陈述、证明与应用
//   Section 6.4: Jacobi Symbols（Jacobi 符号）
//     - 定义、性质与互反律推广

// ==========================================================================
// Part III — Arithmetic Functions and the Distribution of Primes（数论函数与素数分布）
// ==========================================================================
// 设计思路：把计数直觉抽象为积性函数与 Dirichlet 卷积（方法论章），
// 紧接着将其作为研究素数分布的工具（π(x) 的初等估计、Bertrand 假定与
// Chebyshev 界）；Dirichlet 定理与素数定理仅作概述，注明通向未来解析数论笔记。
// 原 LaTeX "渐进法与连分数" 章的解析部分在此落地为 Ch8。
// 对应教材：华罗庚 Ch5（素数分布概况）、Ch6（数论函数）
// 对应 LaTeX：chap04.tex（→ Ch7），chap05.tex（→ Ch8）

// --- Chapter 7: Arithmetic Functions（数论函数）---
//   Section 7.1: Multiplicative Functions（积性函数）
//     - 积性与完全积性；τ、σ、φ 的积性
//   Section 7.2: Dirichlet Convolution and Möbius Inversion（Dirichlet 卷积与 Möbius 反演）
//     - 卷积代数、μ 函数、Möbius 反演公式
//   Section 7.3: Further Properties of φ and σ（φ 与 σ 的深入性质）
//     - Σ_(d|n) φ(d) = n、φ 与 μ 的关系、除数函数高阶公式
//   Section 7.4: Summatory Functions（和函数初步）
//     - 求和技巧与平均阶的直观（为 Ch8 提供估计语料）

// --- Chapter 8: Distribution of Primes（素数分布）---
//   Section 8.1: The Function π(x)（π(x) 与素数无穷的再证）
//     - Euclid 变体、调和级数发散 → 素数无穷
//   Section 8.2: Bertrand's Postulate and Chebyshev's Bounds（Bertrand 假定与 Chebyshev 界）
//     - 中二项式系数技巧；π(x) 的阶
//   Section 8.3: Dirichlet's Theorem and the Prime Number Theorem: An Overview（Dirichlet 定理与素数定理概述）
//     - 算术级数中的素数；PNT 表述与渐近含义
//     - 交叉引用 → 未来解析数论笔记；p-adic/分拆等展望
//   Section 8.4: Primality Testing and Open Problems（素性判定与开放问题）
//     - Miller–Rabin 概率素性判定（承接 Ch4 §4.4）
//     - 孪生素数、Goldbach、Riemann 假设一览

// ==========================================================================
// Part IV — Continued Fractions and Diophantine Equations（连分数与不定方程）
// ==========================================================================
// 设计思路：连分数提供实数的丢番图逼近与二次无理数的完整描述，是解 Pell
// 方程的工具；不定方程将全书方法（Bézout、勾股参数化、连分数、无穷递降）
// 收束为经典问题与竞赛应用。原 LaTeX ch06 连分数部分独立为 Ch9。
// 对应教材：华罗庚 Ch10（连分数）、Ch11（不定方程）；余红兵 §4 及竞赛选讲
// 对应 LaTeX：chap06.tex（拆分：解析部分→Ch8，连分数→Ch9），chap07.tex（→ Ch10）

// --- Chapter 9: Continued Fractions（连分数）---
//   Section 9.1: Finite and Infinite Continued Fractions（有限与无限连分数）
//     - 有限连分数与欧几里得算法（呼应 Ch1 §1.5）
//     - 无限连分数作为数列极限
//   Section 9.2: Convergents and Best Approximations（收敛子与最佳逼近）
//     - 收敛子递推关系、p_n q_(n-1) − p_(n-1) q_n = ±1
//     - 最佳逼近性质
//   Section 9.3: Periodic Continued Fractions（周期连分数）
//     - 二次无理数 ⟷ 周期连分数（Lagrange）
//     - √D 的展开
//   Section 9.4: Applications（逼近应用）
//     - 无理数逼近与丢番图逼近引论

// --- Chapter 10: Diophantine Equations（不定方程）---
//   Section 10.1: Linear Diophantine Equations（一次不定方程）
//     - ax + by = c 通解公式（收束 Ch1 Bézout）
//   Section 10.2: Pythagorean Triples（勾股数组）
//     - 本原勾股数组的结构与参数化
//   Section 10.3: The Pell Equation（Pell 方程）
//     - x² − Dy² = ±1；连分数求最小解与全部解（引用 Ch9）
//   Section 10.4: Fermat's Last Theorem and Infinite Descent（Fermat 大定理与无穷递降）
//     - n = 4 情形的无穷递降证明；历史与现状展望

// ==========================================================================
// 教材覆盖度映射表 (Coverage Mapping)
// ==========================================================================
// 华罗庚《数论导引》:
//   Ch1 整数之分解          → Part I (Ch1–Ch2)
//   Ch2 同余式              → Part II (Ch3–Ch5)
//   Ch3 二次剩余            → Ch6
//   Ch4 多项式之性质        → Polynôme 笔记（本笔记省略）
//   Ch5 素数分布概况        → Ch8
//   Ch6 数论函数            → Ch7
//   Ch9 素数定理            → Ch8 §8.3（概述，完整证明归解析数论）
//   Ch10 连分数             → Ch9
//   Ch11 不定方程           → Ch10
//   Ch7–8, Ch12–20（三角和、分拆、p-adic、二元二次型、模变换…）→ 展望，不入正文
// 余红兵《数论》:
//   整除/gcd·lcm/素数及唯一分解 → Part I；同余 → Ch3–4；不定方程 → Ch10
//   竞赛选讲技巧 → 分散嵌入各章例题与 Ch10 §10.4

// ==========================================================================
// 正文
// ==========================================================================

#part("Divisibility Theory") // 整除理论

= Divisibility // 整除性

Number theory — at its most classical, the study of the integers — opens
with a single operation that is far richer than it looks: division.
Where addition and multiplication assemble structure from a pair of
operands, division asks _when_ one integer fits inside another exactly,
and when it does not, how large the leftover is. That leftover — the
remainder — is the first quantitative answer, and the whole chapter is
the story of pushing this one idea: iterate the remainder, and you
extract the greatest common divisor of two integers; read the iteration
backwards, and you obtain the linear combination of Bézout's identity,
which will echo through every later chapter of this notebook.

== Integers and Floor/Ceiling Functions // 整数与取整函数

The raw material of the chapter is $bb(Z) = {dots, -2, -1, 0, 1, 2,
dots}$, the set of integers, with its usual order and its usual
arithmetic. Before doing any division we record the one ordering fact
that makes proofs about $bb(Z)$ work like proofs by induction, but
without the ceremony.

#proposition(name: "Well-Ordering Principle")[
  Every nonempty subset of the positive integers
  $bb(Z)^+ = {1, 2, 3, dots}$ contains a least element. Equivalently,
  every nonempty subset of $bb(Z)$ that is bounded below has a least
  element.
] <prop:well-ordering>

#note[
  This principle is logically equivalent to mathematical induction:
  each can be derived from the other. We take it as an accepted starting
  point and use it as the engine of the Division Algorithm (§1.2) and
  the Euclidean Algorithm (§1.5), where it guarantees that a certain
  decreasing sequence of nonnegative remainders must stop.
]

Division in $bb(Z)$ produces quotients and remainders, and to describe
the sizes of remainders we need notation for "rounding down". The floor
function goes back to the *integer part* of Carl Friedrich Gauss,
usually written $[x]$ in number-theoretic texts.

#definition(name: "Floor, Ceiling and Fractional Part")[
  Let $x in bb(R)$.
  - The *floor* of $x$, written $floor(x)$ or, in the Gauss bracket
    notation, $[x]$, is the greatest integer not exceeding $x$:
    $floor(x) = m$ where $m in bb(Z)$ satisfies $m <= x < m + 1$.
  - The *ceiling* of $x$, written $ceil(x)$, is the least integer not
    smaller than $x$: $ceil(x) = m$ where $m - 1 < x <= m$.
  - The *fractional part* of $x$ is ${x} = x - floor(x)$, an element of
    the half-open interval $[0, 1)$.
] <def:floor-ceiling>

#example(name: "Numerical Values")[
  $floor(7\/2) = 3$, $floor(-7\/2) = -4$ (note: rounding down, not
  towards zero), $ceil(7\/2) = 4$, $ceil(-7\/2) = -3$, and
  $floor(3) = ceil(3) = 3$. For the fractional part:
  ${7\/2} = 1\/2$, while ${-7\/2} = -7\/2 - (-4) = 1\/2$.
] <ex:floor-values>

#property(name: "Fundamental Properties of the Floor")[
  For $x in bb(R)$ and $n in bb(Z)$:
  - $x - 1 < floor(x) <= x$, so $floor(x)$ is the *unique* integer $m$
    with $m <= x < m + 1$;
  - $floor(x) = x$ iff $x in bb(Z)$;
  - *translation*: $floor(x + n) = floor(x) + n$;
  - *monotonicity*: $x <= y$ implies $floor(x) <= floor(y)$.
] <prop:floor-basic>

#property(name: "Duality and Complementary Identities")[
  For $x in bb(R)$:
  - *duality*: $ceil(x) = -floor(-x)$ and $floor(x) = -ceil(-x)$;
  - $ceil(x) - floor(x)$ equals $0$ if $x in bb(Z)$ and $1$ otherwise;
  - $x = floor(x) + {x}$ with $0 <= {x} < 1$; in particular
    ${x} = 0$ iff $x in bb(Z)$.
] <prop:floor-identities>

The single most useful identity of this section tiles the unit interval
into $n$ equal cells and counts how many of the shifted points
$x + k\/n$ cross an integer boundary. The result is due to Charles
Hermite.

#proposition(name: "Hermite's Identity")[
  Let $n in bb(Z)^+$ and $x in bb(R)$. Then
  #eq[
    $sum_(k=0)^(n-1) floor(x + k\/n) = floor(n x)$.
  ] <eq:hermite-identity>
] <prop:hermite-identity>

#proof(name: "of Hermite's identity")[
  Write $x = m + theta$ with $m = floor(x) in bb(Z)$ and
  $0 <= theta < 1$. Since $m$ is an integer, translation gives
  $floor(x + k\/n) = m + floor(theta + k\/n)$, so the left-hand side
  equals $n m + sum_(k=0)^(n-1) floor(theta + k\/n)$, while the
  right-hand side is $floor(n m + n theta) = n m + floor(n theta)$.
  It remains to show
  $
    sum_(k=0)^(n-1) floor(theta + k\/n) = floor(n theta)
    quad (0 <= theta < 1).
  $

  For such a $theta$, each term $floor(theta + k\/n)$ is $0$ or $1$, and
  it equals $1$ exactly when $theta + k\/n >= 1$, i.e. when
  $k >= n(1 - theta)$. Let $ell = floor(n theta)$, so that
  $n theta in [ell, ell + 1)$ and therefore
  $n(1 - theta) in (n - ell - 1, n - ell]$. The integers
  $k in {0, 1, dots, n - 1}$ with $k >= n(1 - theta)$ are precisely
  $k = n - ell, dots, n - 1$: there are exactly $ell = floor(n theta)$
  of them. Hence the sum equals $floor(n theta)$, as claimed.
]

#note[
  A good picture: $theta$ fixes a point in $[0, 1)$; the sum counts how
  many of the $n$ cells of the uniform grid
  $0 < 1\/n < 2\/n < dots < 1$ are "to the left" of $theta$ in the
  wrapped sense of the identity. This grid-counting viewpoint will
  reappear when summatory estimates are developed in Chapter 7.
]

== Divisibility and the Division Algorithm // 整除性与带余除法

The central relation of elementary number theory is divisibility: one
integer "goes evenly into" another. Everything else — common divisors,
primes, unique factorization — is built from this definition.

#definition(name: "Divisibility")[
  Let $a, b in bb(Z)$ with $a != 0$. We say that $a$ *divides* $b$, and
  write $a | b$, if there exists an integer $c$ such that $b = a c$.
  - If $a | b$, then $a$ is a *divisor* (or *factor*) of $b$, and $b$ is
    a *multiple* of $a$.
  - If $a | b$ and $abs(a) < abs(b)$, then $a$ is a *proper divisor* of
    $b$; if in addition $abs(a) != 1$, it is a *nontrivial proper
    divisor*.
] <def:divisibility>

#caution[
  Divisibility is only defined for a *nonzero* divisor. The case $a = 0$
  is degenerate: the equation $b = 0 dot c$ forces $b = 0$, so $0$
  divides only $0$ — and that convention causes nothing but confusion,
  so we simply exclude it from the definition.
]

#property(name: "Basic Rules of Divisibility")[
  Let $a, b, c in bb(Z)$ with $a != 0$.
  - $a | a$, $a | 0$; $1 | a$ and $(-1) | a$ for every integer $a$.
  - *transitivity*: $a | b$ and $b | c$ imply $a | c$.
  - *linear combinations*: $a | b$ and $a | c$ imply
    $a | (b x + c y)$ for all $x, y in bb(Z)$.
  - *size bound*: if $b != 0$ and $a | b$, then $abs(a) <= abs(b)$.
  - $a | b$ and $b | a$ imply $b = plus.minus a$.
  - $a | 1$ iff $a = plus.minus 1$.
] <prop:divisibility-rules>

#proof(name: "of the rules")[
  Transitivity: $b = a u$ and $c = b v$ give $c = a (u v)$. For linear
  combinations: $b = a u$, $c = a v$, hence $b x + c y = a (u x + v y)$.
  For the size bound, $b = a c$ with $b != 0$ forces $abs(c) >= 1$, so
  $abs(b) = abs(a) abs(c) >= abs(a)$. The last two statements follow
  from the size bound applied twice (or directly from the definitions).
]

#note[
  For polynomials, the same notions appear with degrees in place of
  absolute values — divisibility in $P[x]$, the polynomial GCD and the
  Euclidean algorithm for polynomials are developed in the *Polynôme*
  note and are not repeated here. The integer version below is the
  prototype that the polynomial version imitates.
]

Division in the integers is only defined when the divisor divides
evenly. The fundamental tool repairs this gap: any two integers can be
divided, provided we allow a *remainder* smaller than the divisor. This
is the result that makes all of elementary number theory quantitative.

#theorem(name: "Division Algorithm")[
  Let $a in bb(Z)$ and $b in bb(Z)^+$. Then there exist *unique*
  integers $q$ and $r$ such that
  #eq[
    $a = b q + r, quad 0 <= r < b$.
  ] <eq:division-identity>
] <thm:division-algorithm>

#proof(name: "of the division algorithm")[
  *Existence.* Consider the set of nonnegative integers of the form
  $a - b k$ with $k in bb(Z)$:
  $
    S = {a - b k : k in bb(Z), a - b k >= 0}.
  $
  $S$ is nonempty: taking $k = -abs(a)$ gives
  $a - b(-abs(a)) = a + b abs(a) >= 0$. By the
  #link(<prop:well-ordering>)[well-ordering principle], $S$ has a least
  element $r = a - b q >= 0$. If $r >= b$, then
  $r - b = a - b(q + 1)$ is a smaller nonnegative element of $S$, a
  contradiction. Hence $0 <= r < b$, and $a = b q + r$.

  *Uniqueness.* Suppose $a = b q + r = b q' + r'$ with
  $0 <= r, r' < b$. Subtracting gives $b(q - q') = r' - r$. But
  $abs(r' - r) < b$, and $b$ divides $r' - r$; the only multiple of $b$
  in $(-b, b)$ is $0$. Therefore $r' = r$ and $q' = q$.
]

The integer $q$ is the *quotient* and $r$ the *remainder* of $a$ on
division by $b$. Note carefully what the condition $0 <= r < b$ means
for negative $a$: the remainder is always chosen nonnegative, which is
_not_ what a calculator does when it truncates toward zero.

#example(name: "Division with Remainder")[
  - $a = 17$, $b = 5$: $17 = 3 dot 5 + 2$, so $q = 3$, $r = 2$.
  - $a = -17$, $b = 5$: $-17 = (-4) dot 5 + 3$, so $q = -4$, $r = 3$.
    (Note $r = 3 >= 0$, while truncation toward zero would give
    $q = -3$, $r = -2$.)
  - $a = 0$, $b = 7$: $0 = 0 dot 7 + 0$, so $q = r = 0$.
  - $a = 42$, $b = 6$: $42 = 7 dot 6 + 0$, so $r = 0$: the remainder
    vanishes exactly when the divisor divides the dividend.
] <ex:division-example>

#note[
  Two roads open here. First, equality of remainders
  $r_1 = r_2$ after division by $b$ is exactly the relation
  $b | (a_1 - a_2)$, which becomes the language of congruences in
  Chapter 3. Second, when $b$ is prime the division algorithm will
  produce the Euclidean lemma that powers unique factorization in
  Chapter 2.
]

== Numeral Systems // 进位制

The division algorithm gives a canonical way to *write* every positive
integer: repeatedly strip off the remainder. This is where base-$r$
notation comes from — far from being a fact about "digits", it is an
iteration of §1.2, and its proof is a perfect first exercise in the
division-iteration technique that drives the whole chapter.

#definition(name: "Base-$r$ Numeral System")[
  Let $r >= 2$ be an integer, the *base*. A (finite) sequence of digits
  $(a_k, a_(k-1), dots, a_0)$ with $0 <= a_i < r$ represents the integer
  $
    N = a_k r^k + a_(k-1) r^(k-1) + dots + a_1 r + a_0,
  $
  written $N = (a_k a_(k-1) dots a_0)_r$. The leading digit $a_k$ is
  required to be nonzero (except for the number $0$ itself).
] <def:numeral-system>

Every positive integer has one and only one such representation: apply
the Division Algorithm to $N$ and $r$, obtaining
$N = r q_1 + a_0$ with $0 <= a_0 < r$; then to $q_1$, obtaining
$q_1 = r q_2 + a_1$; and so on. The quotients $q_i$ decrease strictly
while positive, so the process terminates; the last nonzero quotient is
the leading digit. Uniqueness follows by reading the same chain
backwards: if two representations agreed, subtracting them would
exhibit a positive multiple of $r$ strictly smaller than $r$ — the
bound $0 <= a_i < r$ is exactly what makes the writing unique.

#example(name: "Converting Between Bases")[
  - Write $37$ in base $5$: repeated division by $5$ gives
    $
      37 = 7 dot 5 + 2, quad 7 = 1 dot 5 + 2, quad 1 = 0 dot 5 + 1,
    $
    so the remainders, read from last to first, are $1, 2, 2$, and
    $37 = (122)_5 = 25 + 2 dot 5 + 2$.
  - The same number in base $2$: $37 = 32 + 4 + 1 = 2^5 + 2^2 + 1$, so
    $37 = (100101)_2$.
  - *From base $r$ to decimal* is expansion: $(122)_5 = 1 dot 25 + 2 dot
    5 + 2 = 37$. This is the easier direction.
] <ex:base-conversion>

#note[
  Requiring $0 <= a_i < r$ fixes a *unique* standard system. Loosening
  it produces exotic but useful cousins, of which the best known is the
  *balanced ternary* system with digits ${-1, 0, 1}$ in base $3$. It
  represents every integer (no sign needed) and reappears in
  computational contexts; we will not need it below, but the definition
  shows precisely which hypothesis was dropped.
]

== GCD and LCM // 最大公因数与最小公倍数

Common divisors are where divisibility becomes a relation between two
numbers rather than a property of one. The greatest common divisor is
the largest integer that divides both; the least common multiple is the
smallest positive integer divisible by both. They are dual notions, and
one of the goals of §1.5 is to make the duality precise.

#definition(name: "Greatest Common Divisor")[
  Let $a, b in bb(Z)$, not both zero. The *greatest common divisor* of
  $a$ and $b$, written $"gcd"(a, b)$, is the largest positive integer
  $d$ that divides both $a$ and $b$.
] <def:gcd>

#definition(name: "Least Common Multiple")[
  Let $a, b in bb(Z)$ be nonzero. The *least common multiple* of $a$
  and $b$, written $"lcm"(a, b)$, is the smallest positive integer that
  is a multiple of both $a$ and $b$.
] <def:lcm>

#definition(name: "Coprime Integers")[
  Integers $a$ and $b$ (not both zero) are *coprime* (or *relatively
  prime*) if $"gcd"(a, b) = 1$.
] <def:coprime>

#note[
  The definition of the gcd asks for the *largest* common divisor. That
  it exists is not a formality: the set of common divisors of $a, b$ is
  nonempty (it contains $1$) and bounded above by $abs(a)$ whenever
  $a != 0$, so the well-ordering principle applies. The genuinely
  surprising fact — that this largest divisor is also a *linear
  combination* of $a$ and $b$ — requires the Euclidean algorithm and is
  proved in §1.5.
]

#proposition(name: "Elementary Properties of the GCD")[
  Let $a, b in bb(Z)$ be nonzero and $c in bb(Z)$.
  - $"gcd"(a, b) = "gcd"(b, a) = "gcd"(abs(a), abs(b)) = "gcd"(abs(b),
    abs(a))$;
  - $"gcd"(a, 0) = abs(a)$, $"gcd"(a, 1) = 1$, $"gcd"(a, a) = abs(a)$;
  - $"gcd"(a, b) = "gcd"(a, b + c a)$ for every integer $c$ (adding a
    multiple of one argument to the other does not change the gcd).
] <prop:gcd-basic>

#proof(name: "of the elementary properties")[
  The first two statements are immediate from the definition, since
  $x$ and $-x$ have the same divisors and $1$ divides everything. For
  the third, note that a common divisor of $a$ and $b + c a$ also
  divides $(b + c a) - c a = b$; and conversely a common divisor of $a$
  and $b$ divides $b + c a$. Hence the two numbers have *exactly the
  same* common divisors, so in particular the same greatest one.
]

The second property above shows that even when one argument vanishes,
the gcd is well defined. A useful reformulation of "greatest common
divisor" points forward to the linear-combination world of §1.5.

#corollary(name: "GCD Divides Every Linear Combination")[
  Let $a, b in bb(Z)$, not both zero, and $d = "gcd"(a, b)$. Then $d$
  divides every integer linear combination
  $
    a x + b y quad (x, y in bb(Z)).
  $
  In particular $d | (a + b)$ and $d | (a - b)$.
] <cor:gcd-divides-linear>

#example(name: "Computing GCD and LCM by Hand")[
  The divisors of $18$ are $1, 2, 3, 6, 9, 18$; the divisors of $30$ are
  $1, 2, 3, 5, 6, 10, 15, 30$. The common ones are $1, 2, 3, 6$, so
  $"gcd"(18, 30) = 6$. For the lcm: the positive common multiples of
  $18$ and $30$ are $90, 180, dots$, so $"lcm"(18, 30) = 90$. Observe
  the pleasing identity
  $
    6 dot 90 = 540 = 18 dot 30,
  $
  suggesting $"gcd"(a, b) dot "lcm"(a, b) = a b$. A proof that works
  for all pairs must wait for the tools of §1.5.
] <ex:gcd-lcm-example>

#note[
  The product identity $"gcd"(a, b) dot "lcm"(a, b) = abs(a b)$ is
  proved at the end of §1.5 as
  #link(<cor:gcd-lcm-product>)[the product identity]. The catch is
  that one must first know the gcd is not merely a divisor but a
  *linear combination* of $a$ and $b$ — the content of Bézout's
  identity — and that is precisely what the Euclidean algorithm
  provides.
]

== Euclidean Algorithm and Bézout's Identity // 辗转相除法与 Bézout 恒等式

Computing the gcd by listing all divisors (as in §1.4's example) is
hopeless for large numbers. The *Euclidean algorithm* replaces the pair
$(a, b)$ by a smaller pair with the same gcd, over and over, until the
answer falls out. The engine is the observation recorded already in
#link(<prop:gcd-basic>)[§1.4]: adding a multiple of one number to the
other does not change the gcd. Iterating the division algorithm turns
this into a termination proof.

#lemma(name: "GCD Substitution Lemma")[
  Let $a, b in bb(Z)$ with $b != 0$, and let $r$ be the remainder of $a$
  upon division by $b$, i.e. $a = b q + r$ with $0 <= r < abs(b)$. Then
  $
    "gcd"(a, b) = "gcd"(b, r).
  $
  More generally, replacing $(a, b)$ by $(b, r)$ preserves the set of
  common divisors, hence the gcd.
] <lem:gcd-substitution>

#proof[
  Since $r = a - b q$ is a linear combination of $a$ and $b$, every
  common divisor of $a$ and $b$ divides $r$
  (#link(<cor:gcd-divides-linear>)[§1.4]); and since $a = b q + r$,
  every common divisor of $b$ and $r$ divides $a$. The two pairs share
  exactly the same common divisors, so in particular their greatest
  common divisors agree.
]

The lemma gives the algorithm its bite: dividing $a$ by $b$ makes the
second argument strictly smaller than the first, so a repeated chain of
divisions must terminate at a division with remainder $0$.

#theorem(name: "The Euclidean Algorithm")[
  Let $a, b in bb(Z)$ with $b != 0$. Repeatedly applying the division
  algorithm produces the chain
  $
    a = b q_1 + r_1, &quad 0 < r_1 < abs(b), \
    b = r_1 q_2 + r_2, &quad 0 < r_2 < r_1, \
    r_1 = r_2 q_3 + r_3, &quad 0 < r_3 < r_2, \
    dots.v \
    r_(n-2) = r_(n-1) q_n + r_n, &quad 0 < r_n < r_(n-1), \
    r_(n-1) = r_n q_(n+1) + 0.
  $
  The remainders are strictly decreasing nonnegative integers, so the
  process stops after finitely many steps, and the last nonzero
  remainder is the greatest common divisor:
  $
    r_n = "gcd"(a, b).
  $
] <thm:euclidean-algorithm>

#proof[
  Existence of the chain and its termination follow from the division
  algorithm and the strict decrease $abs(b) > r_1 > r_2 > dots >= 0$. By
  #link(<lem:gcd-substitution>)[the substitution lemma] applied along
  the chain,
  $
    "gcd"(a, b) = "gcd"(b, r_1) = "gcd"(r_1, r_2) = dots = "gcd"(r_(n-1),
    r_n) = "gcd"(r_n, 0) = r_n,
  $
  since $"gcd"(x, 0) = abs(x)$ (#link(<prop:gcd-basic>)[§1.4]).
]

The algorithm is the oldest nontrivial algorithm in mathematics and
admits a purely geometric reading: to tile a $24 times 9$ rectangle
with the largest possible squares, repeatedly cut off the largest
square and repeat on the remaining rectangle — the side length of the
last square is the gcd (@fig:euclid-rectangle).

#figure(
  image("img/euclid-rectangle.svg", width: 62%),
  caption: [
    The Euclidean algorithm as rectangular tiling: cutting squares from
    a $24 times 9$ rectangle leaves the squares $9^2, 9^2, 6^2, 3^2,
    3^2$; the last square has side $3 = "gcd"(24, 9)$.
  ],
  placement: auto,
  supplement: [Fig.],
) <fig:euclid-rectangle>

#example(name: "Running the Euclidean Algorithm")[
  Compute $"gcd"(252, 105)$:
  $
    252 = 2 dot 105 + 42, & 105 = 2 dot 42 + 21, & 42 = 2 dot 21 + 0.
  $
  The last nonzero remainder is $21$, hence $"gcd"(252, 105) = 21$. The
  chain had three divisions; each new pair is strictly smaller, and the
  decrease $252 > 105 > 42 > 21 > 0$ makes termination visible.
] <ex:euclid-example>

The algorithm is efficient — it is this efficiency, not just its
existence, that makes the gcd a computational tool — but its true
power for theory lies in what reading the chain *backwards* produces:
the gcd as an explicit linear combination of $a$ and $b$. This is
Bézout's identity.

#theorem(name: "Bézout's Identity")[
  Let $a, b in bb(Z)$, not both zero, and $d = "gcd"(a, b)$. Then there
  exist integers $x, y in bb(Z)$ such that
  #eq[
    $a x + b y = d$.
  ] <eq:bezout>
] <thm:bezout>

#proof(name: "of Bézout's identity, by back-substitution")[
  We show the claim by induction on the number of steps in the
  Euclidean chain for $(abs(a), abs(b))$; signs are restored at the end.

  *Base case.* If $b$ divides $a$, the chain has length one, and
  $a = b q + 0$ gives $"gcd"(a, b) = abs(b)$, which we exhibit directly
  as $a dot 0 + b dot s = abs(b)$, where $s in {plus.minus 1}$ is the
  sign of $b$ — a linear combination with integer coefficients.

  *Inductive step.* Assume the chain has at least two divisions, and
  let $a = b q + r$, $r != 0$. By
  #link(<lem:gcd-substitution>)[the lemma], $d = "gcd"(a, b) =
  "gcd"(b, r)$, and the chain for $(b, r)$ is one step shorter. By
  induction there exist integers $x_0, y_0$ with
  $b x_0 + r y_0 = d$. Substituting $r = a - b q$ gives
  $
    d = b x_0 + (a - b q) y_0 = a y_0 + b (x_0 - q y_0),
  $
  a linear combination of $a$ and $b$ with integer coefficients. The
  induction is complete; tracking signs of $a, b$ only changes signs of
  $x, y$.
]

Back-substitution is best seen on a concrete chain: solve for the
remainders, from bottom to top, and substitute upwards.

#example(name: "Bézout Coefficients by Back-Substitution")[
  For $a = 252$, $b = 105$, the chain of
  #link(<ex:euclid-example>)[the previous example] is
  $
    252 = 2 dot 105 + 42, quad 105 = 2 dot 42 + 21, quad 42 = 2 dot 21.
  $
  Solve for the remainders and substitute from the last equation up:

  $r_2 = 21 = 105 - 2 dot 42$ (from the middle equation);

  then $42 = 252 - 2 dot 105$ (from the first), giving

  $21 = 105 - 2 dot (252 - 2 dot 105) = 5 dot 105 - 2 dot 252$.

  Hence $21 = (-2) dot 252 + 5 dot 105$, i.e. $x = -2$, $y = 5$ work in
  Bézout's identity.
] <ex:bezout-example>

#corollary(name: "Coprime Criterion")[
  Two integers $a, b$ (not both zero) are coprime if and only if there
  exist integers $x, y$ with
  $
    a x + b y = 1.
  $
] <cor:bezout-coprime>

#proof[
  If $"gcd"(a, b) = 1$, Bézout's identity gives the combination
  directly. Conversely, if $a x + b y = 1$ and $d = "gcd"(a, b)$, then
  $d$ divides the left-hand side
  (#link(<cor:gcd-divides-linear>)[§1.4]), so $d | 1$ and $d = 1$.
]

This criterion is the workhorse behind everything multiplicative in
this notebook. Its first harvest is the promised product identity,
which needs one further observation: a common multiple of two coprime
numbers is a multiple of their product.

#lemma(name: "Coprime Divisibility (Euclid's Lemma, Coprime Form)")[
  If $"gcd"(a, b) = 1$ and $a | (b c)$, then $a | c$.
] <lem:coprime-divisibility>

#proof[
  By the #link(<cor:bezout-coprime>)[coprime criterion], there exist
  integers $x, y$ with $a x + b y = 1$. Multiply by $c$:
  $a x c + b c y = c$. Since $a | (a x c)$ trivially and $a | (b c)$ by
  assumption, $a$ divides the sum $c$.
]

#corollary(name: "The Product Identity for GCD and LCM")[
  For nonzero integers $a, b$,
  #eq[
    $"gcd"(a, b) dot "lcm"(a, b) = abs(a b)$.
  ] <eq:gcd-lcm-product>
] <cor:gcd-lcm-product>

#proof(name: "of the product identity")[
  Let $d = "gcd"(a, b)$ and write $a = d a_0$, $b = d b_0$ with
  $"gcd"(a_0, b_0) = 1$ (dividing both by their gcd can only remove
  common factors). Consider $M = d a_0 b_0$: it is a common multiple of
  $a = d a_0$ and $b = d b_0$. We show it is the *least* one.

  Let $m$ be any common multiple of $a$ and $b$, say $m = a a_1 = b b_1$.
  Substituting $a = d a_0$, $b = d b_0$ gives
  $a_0 a_1 = b_0 b_1$ after cancelling $d$. Since
  $"gcd"(a_0, b_0) = 1$, the
  #link(<lem:coprime-divisibility>)[coprime form of Euclid's lemma]
  applies: $b_0 | a_1$, so $a_1 = b_0 t$ and
  $m = a a_1 = d a_0 b_0 t = M t$. Hence every common multiple is a
  multiple of $M$, and $M = "lcm"(a, b)$.

  Finally $d dot "lcm"(a, b) = d dot (d a_0 b_0) = (d a_0)(d b_0) =
  a b$, and since $d, "lcm"(a, b) > 0$ both sides are positive; with
  signs restored this reads $d dot "lcm"(a, b) = abs(a b)$.
]

#example(name: "The Product Identity in Action")[
  For $a = 18$, $b = 30$, the identity from
  #link(<ex:gcd-lcm-example>)[§1.4] reads
  $"gcd"(18, 30) dot "lcm"(18, 30) = 6 dot 90 = 540 = 18 dot 30$: the
  relation observed numerically is now a theorem.
]

#note[
  Bézout's identity is the seed of Chapter 10: the solutions of the
  linear Diophantine equation $a x + b y = c$ are parameterised by one
  particular solution (obtained from Bézout) plus the general solution
  of the homogeneous equation $a x + b y = 0$. All of §10.1 is nothing
  but this observation, developed systematically.
]

The chapter has built its fundamental machinery: divisibility and the
division algorithm (§1.1–§1.2), base-$r$ notation as its first
iteration (§1.3), the gcd/lcm and their elementary identities
(§1.4), and finally the Euclidean algorithm with the Bézout identity
as its backward reading (§1.5). The next chapter feeds this engine its
favourite fuel — primes — and the division algorithm's remainder-free
case will return as the Euclidean lemma behind unique factorization.
