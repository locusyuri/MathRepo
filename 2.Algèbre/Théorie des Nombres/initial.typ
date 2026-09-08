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
