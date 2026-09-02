#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Analyse Harmonique", // 调和分析
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Analyse Harmonique", // 调和分析
  "Violet",
  subtitle: "A notebook for harmonic analysis",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.3.0",
  extra-info: "This is a notebook for harmonic analysis.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
// 主线叙事：经典 Fourier 级数 → Fourier 变换与现代理论 → Sobolev 空间
// 参考教材：Stein & Shakarchi "Fourier Analysis: An Introduction"，于品 "Fourier 分析"
//
// 职责边界 (SRP Boundaries)：
// - 本笔记负责：Fourier 级数理论、Fourier 变换理论、Sobolev 空间
// - L¹/L²/p 空间的一般理论 → Analyse Réelle（本笔记仅引用结果）
// - Banach/Hilbert 空间抽象理论 → Analyse Fonctionnelle（本笔记仅引用结果）
// - 分布理论 (Distribution Theory) → Équations aux Dérivées Partielles
// - Sobolev 空间在 PDE 中的应用 → Équations aux Dérivées Partielles（引用本笔记定义与定理）

// ==========================================================================
// Part I — Classical Fourier Series (经典 Fourier 级数)
// ==========================================================================
// 设计思路：从经典 Fourier 级数出发，建立 Fourier 系数、核函数、收敛性等基础理论。
// Part I 涵盖从 Euler-Fourier 公式到逐点收敛判别法，再到 Cesàro 求和与平方平均收敛。
// 对应教材：Stein & Shakarchi Ch 1-3，于品 Ch 1-3
// 对应 LaTeX：chap01.tex (Classical Fourier Series), chap02.tex (Cesàro Summation)

// --- Chapter 1: Fourier Coefficients and Dirichlet Kernel (傅里叶系数与 Dirichlet 核) ---

//   Section 1.1: Functions on the Unit Circle (圆周上的函数)
//     - 周期函数与圆周 T 的对应
//     - 函数空间 R[-π, π] 的内积与范数结构

//   Section 1.2: Fourier Coefficients and Euler-Fourier Formula (傅里叶系数与 Euler-Fourier 公式)
//     - 正交基 {e^(inx)} 与 Fourier 系数定义
//     - 复数形式与实数形式的转换
//     - 任意周期 2T 的推广
//     - 正弦级数与余弦级数

//   Section 1.3: Dirichlet Kernel and Convolution (Dirichlet 核与卷积)
//     - Dirichlet 核 D_N(x) 的定义与性质（偶性、归一化）
//     - Lebesgue 常数与 D_N 的"坏核"本质
//     - 卷积的定义与基本性质（交换律、结合律、分配律、平移不变性）
//     - 卷积定理：频域乘积 ↔ 时域卷积

//   Section 1.4: Localization Theorem (局部化定理)
//     - Riemann-Lebesgue 引理（含证明）
//     - Riemann 局部化定理（含证明）
//     - Dirichlet 积分的化简

//   Section 1.5: Pointwise Convergence Tests (逐点收敛判别法)
//     - Hölder 条件与 Lipschitz 条件
//     - Dirichlet 引理
//     - Lipschitz 判别法、Dini 判别法、Dirichlet-Jordan 判别法
//     - Gibbs 现象

//   Section 1.6: Properties of Fourier Series (Fourier 级数的性质)
//     - 逐项积分与逐项微分
//     - 光滑性与衰减速度的关系
//     - 唯一性定理

// --- Chapter 2: Cesàro Summation and Square Mean Convergence (Cesàro 求和与平方平均收敛) ---

//   Section 2.1: Cesàro Summation and Fejér Kernel (Cesàro 求和与 Fejér 核)
//     - Cesàro 求和的定义
//     - Fejér 核 F_N(t) 的定义与四大性质（正性、归一化、集中性、有界性）
//     - Dirichlet 核 vs Fejér 核对比表
//     - Fejér 定理（含 Weierstrass 逼近定理推论）

//   Section 2.2: Square Approximation and Parseval's Identity (平方逼近与 Parseval 恒等式)
//     - Fourier 级数的最佳平方逼近性质
//     - Bessel 不等式
//     - Parseval 恒等式（含广义形式）
//     - 应用：计算特殊级数求和 (Σ1/n², Σ1/n⁴ 等)

//   Section 2.3: Classical Inequalities (经典不等式)
//     - Wirtinger 不等式（含等号条件）
//     - Poincaré 不等式
//     - Friedrichs 不等式

//   Section 2.4: Square Mean Convergence (平方平均收敛)
//     - L² 收敛的定义
//     - Fourier 级数的平方平均收敛定理

//   Section 2.5: Poisson Kernel (Poisson 核)
//     - Poisson 核的定义与基本性质
//     - Poisson 积分与调和函数
//     - Poisson 核的逼近性质

//   Section 2.6: Equidistribution (等分布问题)
//     - Weyl 等分布准则
//     - Fourier 分析在等分布理论中的应用

// ==========================================================================
// Part II — Fourier Transform and Modern Theory (Fourier 变换与现代理论)
// ==========================================================================
// 设计思路：从周期到非周期，引入 Fourier 变换；然后进入现代 Fourier 分析，
// 讨论 L¹/L² 空间中的 Fourier 级数收敛理论。
// 对应教材：Stein & Shakarchi Ch 4-5，于品 Ch 4-5
// 对应 LaTeX：chap04.tex (Fourier Transform), chap03.tex (Modern Fourier Analysis)

// --- Chapter 3: Modern Fourier Series (现代 Fourier 级数) ---

//   Section 3.1: L¹ Space and Fourier Coefficients (L¹ 空间与 Fourier 系数)
//     - L¹(T) 空间的基本性质
//     - L¹ 函数的 Fourier 系数
//     - Riemann-Lebesgue 引理（L¹ 版本）
//     - 注：L¹ 空间的一般理论参见 Analyse Réelle

//   Section 3.2: L² Space and Fourier Series (L² 空间与 Fourier 级数)
//     - L²(T) 空间的基本性质
//     - L² 中 Fourier 级数的收敛性
//     - Parseval 恒等式（L² 版本）
//     - 注：L² 空间的一般理论参见 Analyse Réelle

//   Section 3.3: Convergence Theory in L² (L² 空间中的收敛理论)
//     - Carleson-Hunt 定理（几乎处处收敛）
//     - 注：深入测度论工具参见 Analyse Réelle

// --- Chapter 4: Fourier Transform (Fourier 变换) ---

//   Section 4.1: From Periodic to Non-Periodic (从周期函数到非周期函数)
//     - 从 Fourier 级数到 Fourier 变换的极限过程
//     - Fourier 变换与逆变换的定义
//     - Poisson 求和公式

//   Section 4.2: Schwartz Space (Schwartz 速降空间)
//     - Schwartz 空间 S(R) 的定义
//     - 速降函数的性质

//   Section 4.3: Basic Properties of Fourier Transform (Fourier 变换的基本性质)
//     - 线性性、平移性、缩放性
//     - 微分性质与积分性质
//     - 卷积定理（Fourier 变换版本）

//   Section 4.4: Fourier Inversion Theorem (Fourier 反演定理)
//     - 反演定理的陈述与证明思路

//   Section 4.5: The L¹ and L² Dichotomy (L¹ 与 L² 理论的二分)
//     - L¹ 上的 Fourier 变换
//     - Plancherel 定理与 L² 上的 Fourier 变换
//     - F. Riesz 定理（注：一般 L^p 理论参见 Analyse Réelle）

//   Section 4.6: Heisenberg's Uncertainty Principle (海森堡不确定性原理)
//     - 不确定性原理的陈述与证明
//     - 等号条件（Gauss 函数）

//   Section 4.7: Laplace Transform (拉普拉斯变换)
//     - Laplace 变换的定义与存在性
//     - 基本性质（线性性、微分性质）
//     - 常见 Laplace 变换表
//     - 与 Fourier 变换的关系

//   Section 4.8: Fast Fourier Transform (快速 Fourier 变换)
//     - FFT 算法的基本思想
//     - 计算复杂度分析

// ==========================================================================
// Part III — Sobolev Spaces (Sobolev 空间)
// ==========================================================================
// 设计思路：Sobolev 空间是调和分析的核心工具，也是连接 Fourier 分析与 PDE 的桥梁。
// 本 Part 建立 Sobolev 空间的完整理论，为 PDE 笔记提供函数空间基础。
// 对应教材：Evans Ch 5，Adams "Sobolev Spaces"
//
// 职责边界：本笔记负责 Sobolev 空间的定义、嵌入定理、迹定理等纯分析理论。
// Sobolev 空间在 PDE 弱解中的应用参见 Équations aux Dérivées Partielles。

// --- Chapter 5: Sobolev Spaces (Sobolev 空间) ---

//   Section 5.1: Definition and Basic Properties (定义与基本性质)
//     - 弱导数的定义
//     - Sobolev 空间 W^(k,p) 与 H^s 的定义
//     - 基本性质与范数等价

//   Section 5.2: Sobolev Embedding Theorems (Sobolev 嵌入定理)
//     - 连续嵌入与紧嵌入
//     - Sobolev 不等式
//     - Morrey 不等式
//     - Rellich-Kondrachov 紧嵌入定理

//   Section 5.3: Trace Theorem (迹定理)
//     - 边界迹算子的定义
//     - 迹定理的陈述与证明

//   Section 5.4: Poincaré and Friedrichs Inequalities (Poincaré 不等式与 Friedrichs 不等式)
//     - Poincaré 不等式（补全 Ch 2 中的空白）
//     - Friedrichs 不等式（补全 Ch 2 中的空白）
//     - 在 Sobolev 空间中的完整证明

//   Section 5.5: Interpolation and Duality (插值与对偶)
//     - 实插值与复插值方法
//     - Sobolev 空间的对偶空间
//     - 负指数 Sobolev 空间 H^(-s)

// ==========================================================================
// 教材覆盖度映射表 (Coverage Mapping)
// ==========================================================================
// | 教材位置                    | 知识点                     | 本笔记位置         | 备注                          |
// |----------------------------|---------------------------|-------------------|-------------------------------|
// | Stein Ch 1-3               | 经典 Fourier 级数          | Ch 1-2            | 直接对应                       |
// | Stein Ch 4-5               | Fourier 变换              | Ch 4              | 直接对应                       |
// | 于品 Ch 1-3                | 经典理论与收敛性           | Ch 1-2            | 直接对应                       |
// | 于品 Ch 4-5                | 现代理论与变换             | Ch 3-4            | 直接对应                       |
// | Evans Ch 5                 | Sobolev 空间              | Ch 5              | 本笔记负责纯分析理论            |
// | Poisson 核                 | Poisson 核与调和函数       | Ch 2, §2.5        | 补充内容                       |
// | 等分布理论                  | Weyl 准则等               | Ch 2, §2.6        | 补充内容                       |
// | Plancherel / F. Riesz      | L² 变换与 L^p 理论        | Ch 4, §4.5        | 补充内容                       |
//
// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循"经典级数 → 变换与现代理论 → Sobolev 空间"的三段式主线，共 3 Part、5 Chapter。
//
// Part I（Ch 1-2）：经典 Fourier 级数理论，从 Euler-Fourier 公式到逐点收敛与平方平均收敛。
// Part II（Ch 3-4）：现代 Fourier 分析，涵盖 L¹/L² 理论与 Fourier/Laplace 变换。
// Part III（Ch 5）：Sobolev 空间，为 PDE 弱解理论提供函数空间基础。
//
// 教材覆盖：Stein & Shakarchi 全部核心章节 + 于品核心章节均已覆盖，
// 并补充了 Poisson 核、等分布、Plancherel 定理等扩展内容。
// ==========================================================================

// ==========================================================================
// Migrated Content (LaTeX -> Typst)
// ==========================================================================

#part("Classical Fourier Series") // 经典 Fourier 级数

= Classical Fourier Series
In this chapter, we will explore the Fourier series in such function space:
1. *Set and Field.* The linear space we are working on is the set of all integrable
  (in the _Riemann sense_)#footnote[
    For common integral, it should be Riemann integral;
    for defective integral, it should be _absolute Riemann integral_.
    For convenience, we just say Riemann integral in this context.
  ]
  complex-valued periodic functions defined on $[-pi, pi]$#footnote[
    It can be also defined on interval $[-T, T]$,
    but we choose $[-pi, pi]$ for simplicity.
  ], equipped with the usual addition and scalar multiplication of functions.
  We denote it as $cal(R)[-pi, pi]$ that is an infinite-dimensional linear space.
  The field of scalars is the set of complex numbers $bb(C)$.

2. *Inner Product.* For any two functions $f(x), g(x)$ in this space, we define their inner product as:
  $
    ⟨ f, g ⟩ = (1) / (2pi) integral_(-pi)^(pi) f(x) overline(g(x)) dif x,
  $
  where $(1) / (2pi)$ is a normalization factor.

3. *Norm.* The norm induced by this inner product is given by:
  $
    || f || = sqrt(⟨ f, f ⟩) = ( (1) / (2pi) integral_(-pi)^(pi) abs(f(x))^2 dif x )^((1) / (2)).
  $
In fact, we often assume that the functions are always piecewise continuous or piecewise smooth on $[-pi, pi]$,
which is the most common case in engineering.

=== Function Defined on the Unit Circle

For a periodic function $f(x): bb(R) -> bb(C)$ with period $2pi$,
we can explore it from the perspective of complex exponential functions on the unit circle in the complex plane.
Let
$
  bb(T) = { z in bb(C) : abs(z) = 1 },
$
which is one-dimensional torus, also known as the unit circle in the complex plane.

For any $theta in bb(R)$, we can define:
$
  f(theta) = F(e^(i theta)),
$
where $F: bb(T) -> bb(C)$ is a *function defined on the unit circle*.
Thus, we can study the periodic function $f(x)$ by analyzing the function $F(z)$ on the unit circle $bb(T)$.
From the perspective of algebra, the set of all such functions $F(z)$ forms a function space over the unit circle,
which is _isomorphic_ to the space of periodic functions $f(x)$ with period $2pi$.

By introducing $bb(T)$ that is a compact manifold without boundary in fact,
we can not only eliminate the hassles of endpoints but also simplify many discussions.
Furthermore, since $bb(T)$ is a multiplicative group of complex numbers,

we can better understand the essence of Fourier series: the duality theory on compact Abelian groups.

== Fourier Coefficients
#theorem[
  $
    cal(E) = { e^(i n x) : n in bb(Z) }
  $
  is an orthonormal basis of the inner product space $cal(R)[-pi, pi]$.

  In real form,
  $
    { 1, cos x, sin x, cos 2 x, sin 2 x, dots }
  $
  is also an orthogonal basis#footnote[
    Note that this set is orthogonal but not orthonormal,
    for
    $ ⟨ 1, 1 ⟩ = 1, quad ⟨ cos n x, cos n x ⟩ = ⟨ sin n x,
      sin n x ⟩ = (1) / (2), quad n in bb(N). $
    To make it orthonormal, each function should be normalized by the appropriate factor.
  ] of the inner product space $cal(R)[-pi, pi]$.
]

#definition[
  The Fourier coefficients $hat(f)(n)$ of a function $f(x) in cal(R)[-pi, pi]$ is the
  projection of $f(x)$ onto the basis function $e^(i n x)$:
  $
    hat(f)(n) = ⟨ f, e^(i n x) ⟩ = (1) / (2pi) integral_(-pi)^(pi) f(x) e^(-i n x) dif x, quad n in bb(Z),
  $
  that is called Euler-Fourier formula.

  Hence, the Fourier series of $f(x)$ is given by:
  $
    f(x) ~ sum_(n=-oo)^(+oo) hat(f)(n) e^(i n x),
  $
  or in real form:
  $
    f(x) ~ (a_0) / (2) + sum_(n=1)^(+oo) [ a_n cos(n x) + b_n sin(n x) ],
  $
  where
  $
    &a_0 = (1) / (pi) integral_(-pi)^(pi) f(x) dif x, \
    &a_n = (1) / (pi) integral_(-pi)^(pi) f(x) cos(n x) dif x, \
    &b_n = (1) / (pi) integral_(-pi)^(pi) f(x) sin(n x) dif x, quad n = 1, 2, dots \
  $
  and the symbol "$~$" indicates that the right-hand side is the Fourier series representation of $f(x)$.
]
#note[
  Utilizing Euler formula:
  $
    cos n x = (e^(i n x) + e^(-i n x)) / (2), quad sin n x = (e^(i n x) - e^(-i n x)) / (2i),
  $
  we can easily derive the relationship between Fourier coefficients in complex form and real form:
  $
    hat(f)(0) = (a_0) / (2), quad hat(f)(n) = (a_n - i b_n) / (2), \
    quad hat(f)(-n) = (a_n + i b_n) / (2), quad n = 1, 2, dots \
  $
  $
    a_0 = 2hat(f)(0), quad a_n = hat(f)(n) + hat(f)(-n) = 2Re hat(f)(n), quad \
    b_n = i [ hat(f)(n) - hat(f)(-n) ] = -2Im hat(f)(n), quad n = 1, 2, dots \
  $
]


It can be easily extended to any periodic function with period $2T$ by the substitution $x = (pi) / (T) t$:
$
  f(x) ~ sum_(n=-oo)^(+oo) hat(f)(n) e^(i n (pi) / (T) x),
$
or in real form:
$
  f(x) ~ (a_0) / (2) + \
  sum_(n=1)^(+oo) [ a_n cos(n (pi) / (T) x) + b_n sin(n (pi) / (T) x) ]. \
$

#v(0.7cm)

When $f(x)$ is an even function, all sine terms vanish, and the Fourier series reduces to a cosine series:
$
  f(x) ~ (a_0) / (2) + sum_(n=1)^(+oo) a_n cos(n x).
$
When $f(x)$ is an odd function, all cosine terms vanish, and the Fourier series reduces to a sine series:
$
  f(x) ~ sum_(n=1)^(+oo) b_n sin(n x).
$

== The Dirichlet Kernel

=== Dirichlet Kernel

For partial sum of the first $N$ terms of the Fourier series of $f(x)$:
$
  S_N(f; x) = sum_(n=-N)^(N) hat(f)(n) e^(i n x) = (a_0) / (2) + sum_(n=1)^(N) [ a_n cos(n x) + b_n sin(n x) ],
$
in order to study its convergence, we can transform it into integral form.
By Euler-Fourier formula, we have:
$
  S_N(f; x) \
  & = sum_(n=-N)^(N) hat(f)(n) e^(i n x) \
  & = sum_(n=-N)^(N) ( (1) / (2pi) integral_(-pi)^(pi) f(t) e^(-i n t) dif t ) e^(i n x) \
  & = (1) / (2pi) integral_(-pi)^(pi) f(t) ( sum_(n=-N)^(N) e^(i n (x - t)) ) dif t \
  & = (1) / (2pi) integral_(-pi)^(pi) f(t) D_N(x - t) dif t, \
$
where
$
  D_N(x) = sum_(n=-N)^(N) e^(i n x) = sum_(n=1)^(N) 2 cos(n x) + 1 = \
  ( sin((2N + 1) / (2) x) ) / ( sin(x / (2)) ), \
$
is called the *Dirichlet kernel*.

Dirichlet kernel possesses the following important properties:

#property[
  1. *Evenness.*
    $ D_N(-x) = D_N(x). $

  2. *Normalization.*
    $ (1) / (2pi) integral_(-pi)^(pi) D_N(x) dif x = 1. $
]

#figure(
  image("img/Dirichlet_kernels.png", width: 60%),
  caption: [Dirichlet kernels for various values of $N$.],
  placement: auto,
  supplement: [Fig.],
) <fig:Dirichlet_kernels>

However, $D_N(x)$ is like water waves, with both positive and negative values.
This means that during convolution (weighted averaging), positive and negative offsets may lead to extremely unstable results.
For example, for integral mean of the absolute value of the Dirichlet kernel,
which is called the *Lebesgue constant*:
$
  L_n := (1) / (2pi) integral_(-pi)^(pi) abs(D_N(x)) dif x approx (4) / (pi^2) ln N, quad (N -> +oo).
$
It is precisely because the absolute integral of $D_N(x)$ tends to infinity
that it is a "bad kernel function".
It amplifies errors, causing #underline[the Fourier series of a continuous function to potentially diverge].

#v(0.7cm)
With the help of convolution theorem, we have:
$
  S_N(f; x) &= (1) / (2pi) integral_(-pi)^(pi) f(t) D_N(x - t) dif t \
  & =^("Let " u = t - x) (1) / (2pi) integral_(-pi)^(pi) f(x + u) D_N(-u) dif u \
  & =^(D_N(-u) = D_N(u)) (1) / (2pi) integral_(-pi)^(pi) f(x + u) D_N(u) dif u \
  & =^("Divide by " 2) (1) / (2pi) integral_(0)^(pi) [ f(x + u) + f(x - u) ] D_N(u) dif u. \
$
Then the convergence of $S_N(f; x)$ can be analyzed through the properties of the last integral
that is called the *Dirichlet integral*.

Since the normalization property of Dirichlet kernel, we can analyze the difference between
$S_N(f; x)$ and any a function $sigma(x)$:
$
  S_N(f; x) - sigma(x) = (1) / (2pi) integral_(0)^(pi) [ f(x + u) + f(x - u) - 2sigma(x) ] D_N(u) dif u.
$
Denote $phi_sigma(u, x) = f(x + u) + f(x - u) - 2sigma(x)$,
then the convergence of $S_N(f; x)$ to $sigma(x)$ is equivalent to:
$
  lim_(N -> +oo) integral_(0)^(pi) phi_sigma(u, x) D_N(u) dif u = 0.
$

=== Convolution

#definition(name: "Convolution")[
  For two functions $f(x), g(x)$ defined on $bb(R)$,
  their convolution $f * g$ is defined as:
  $
    (f * g)(x) = integral_(-oo)^(+oo) f(t) g(x - t) dif t.
  $

  Specially, if the functions are periodically defined on a finite interval $bb(T)$ with period $2pi$,
  then the convolution is defined as:
  $
    (f * g)(x) = (1) / (2pi) integral_(-pi)^(pi) f(t) g(x - t) dif t.
  $
  Here, $(1) / (2pi)$ is a normalization factor.
]

#note[
  From a physically intuitive perspective, convolution is a form of "weighted averaging" or "filtering".
  Here, $g(t)$ serves as the weight function (kernel),
  which samples and averages $f$ within a "sliding window" around the point $x$.
]

#property[
  1. *Commutativity.* $f * g = g * f$.

  2. *Associativity.* $f * (g * h) = (f * g) * h$.

  3. *Distributivity.* $f * (g + h) = f * g + f * h$.

  4. *Translation Invariance.* $(T_a f) * g = T_a (f * g)$, where $(T_a f)(x) = f(x - a)$.
]

#v(0.7cm)
With the definition of convolution, we can rewrite the partial sum of Fourier series as:
$
  S_N(f; x) = (1) / (2pi) integral_(-pi)^(pi) f(t) D_N(x - t) dif t = (f * D_N)(x).
$
Actually, this is a special case of convolution theorem,
and we have the following general conclusion:

#theorem(name: "Convolution Theorem")[
  Under suitable conditions the Fourier coefficients of a convolution of two functions (or signals)
  is the product of their Fourier coefficients,
  $
    hat(f * g)(n) = hat(f)(n) dot hat(g)(n).
  $

  In other words, the convolution in one domain corresponds to the product in another domain,
  for example, the convolution in the time domain corresponds to the product in the frequency domain.
]

=== Localization Theorem

First, we need the following important lemma:
#lemma(name: "Riemann-Lebesgue Lemma")[
  Let $f(x) in R[a, b]$, $g(x)$ has a period $T$ and $g(x) in R[0, T]$,
  then:
  $
    lim_(p -> +oo) integral_(a)^(b) f(x) g(p x) dif x \
    = integral_(a)^(b) f(x) dif x dot (1) / (T) integral_(0)^(T) g(t) dif t. \
  $
  A special case is when $g(x) = sin x$ or $g(x) = cos x$, then:
  $
    lim_(p -> +oo) integral_(a)^(b) f(x) sin(p x) dif x \
    = integral_(a)^(b) f(x) cos(p x) dif x = 0. \
  $
] <lem:Riemann-Lebesgue>

#proof[
  #text(fill: purple)[*Special case.*]
  Prove for $g(x) = sin x$, the case for $g(x) = cos x$ is similar.

  If $f(x) in B[a, b]$, i.e., $f(x)$ is integrable in the common Riemann sense on $[a, b]$.
  Then there exists $M > 0$ such that $abs(f(x)) <= M$ for all $x in [a, b]$.
  Denote $n = [sqrt(p)]$, then when $p -> +oo$, we have $n -> +oo$.

  Divide the interval $[a, b]$ into $n$ subintervals of equal length:
  $
    a = x_0 < x_1 < x_2 < dots.h < x_n = b,
  $
  and let $omega_i$ be the oscillation of $f(x)$ on the $i$-th subinterval $[x_(i-1), x_i]$.

  By the integrability theory,
  $
    lim_(n -> oo) sum_(i=1)^(n) omega_i Delta x_i = 0.
  $
  And we have:
  $
    abs(integral_(x_(i-1))^(x_i) sin(p x) dif x) < (2) / (p), quad \
    abs(sin(p x)) <= 1. \
  $
  Then we can estimate:
  $
    abs(integral_(a)^(b) f(x) sin(p x) dif x) \
    & = abs(sum_(i=1)^(n) integral_(x_(i-1))^(x_i) f(x) sin(p x) dif x) \
    & <= abs(sum_(i=1)^(n) integral_(x_(i-1))^(x_i) ( f(x) - f(x_i) ) sin(p x) dif x) \
    + abs(sum_(i=1)^(n) integral_(x_(i-1))^(x_i) f(x_i) sin(p x) dif x) \
    & <= sum_(i=1)^(n) omega_i Delta x_i \
    + M sum_(i=1)^(n) abs(integral_(x_(i-1))^(x_i) sin(p x) dif x) \
    & <= sum_(i=1)^(n) omega_i Delta x_i + M dot n dot (2) / (p) -> 0, quad (p -> +oo). \
  $
  Thus, $lim_(p -> oo) integral_(a)^(b) f(x) sin(p x) dif x = 0$.

  If $f(x) in.not B[a, b]$, i.e., $f(x)$ is absolutely integrable in the improper Riemann sense on $[a, b]$.
  Without loss of generality, assume that $f(x)$ is defective at point $b$.
  Then
  $
    forall epsilon > 0, exists delta > 0, forall eta in (0, delta): \
    integral_(b - eta)^(b) abs(f(x)) dif x < (epsilon) / (2). \
  $
  Fix such $eta$, then $f(x) in R[a, b - eta]$.
  According to the previous discussion, there exists $P > 0$, such that when $p > P$:
  $
    abs(integral_(a)^(b - eta) f(x) sin(p x) dif x) < (epsilon) / (2).
  $
  Then we have:
  $
    abs(integral_(a)^(b) f(x) sin(p x) dif x) \
    & <= abs(integral_(a)^(b - eta) f(x) sin(p x) dif x) \
    + abs(integral_(b - eta)^(b) f(x) sin(p x) dif x) \
    & < (epsilon) / (2) + integral_(b - eta)^(b) abs(f(x)) dif x < epsilon. \
  $
  Thus, $lim_(p -> oo) integral_(a)^(b) f(x) sin(p x) dif x = 0$.

  In summary, regardless of whether $f(x)$ is integrable in the common Riemann sense or
  absolutely integrable in the improper Riemann sense,
  we have proved the special case of Riemann-Lebesgue Lemma.
]

Then we can state Riemann's Localization Theorem:
#theorem(name: "Riemann's Localization Theorem")[
  The convergence or divergence of the Fourier series of a function $f(x) in cal(R)[-pi, pi]$
  at a given point $x$ depends only on the behavior of $f(x)$ in
  an arbitrarily small neighborhood of $x$.
]
#proof[
  For any given $delta > 0$, since $f(x) in cal(R)[-pi, pi]$,
  $((f(x + u) + f(x - u)) / (sin(u / (2)))) in cal(R)[delta, pi]$.

  Then by Riemann-Lebesgue lemma (#link(<lem:Riemann-Lebesgue>)[Lemma]), we have:
  $
    lim_(N -> oo) integral_(delta)^(pi) \
    [ f(x + u) + f(x - u) ] (sin((N + (1) / (2)) u)) / (sin(u / (2))) dif u = 0. \
  $
  Thus, divided the integral interval of $S_N(f; x)$ into $[0, delta]$ and $[delta, pi]$, that is:
  $
    S_N(f; x) = (1) / (2pi) integral_(0)^(delta) [ f(x + u) + f(x - u) ] D_N(u) dif u \
    + (1) / (2pi) integral_(delta)^(pi) \
    [ f(x + u) + f(x - u) ] (sin((N + (1) / (2)) u)) / (sin(u / (2))) dif u. \
  $
  When $N -> +oo$, the second term tends to zero, i.e.,
  the convergence of $S_N(f; x)$ only depends on the first term:
  $
    lim_(N -> +oo) S_N(f; x) = lim_(N -> +oo) (1) / (2pi) integral_(0)^(delta) \
    [ f(x + u) + f(x - u) ] D_N(u) dif u. \
  $
]

#v(0.7cm)
Since the oscillation of $D_N(x)$ is so severe that it causes poor convergence, is there a way to "smooth it out"?
In fact, we can use *Cesàro summation* and *Fejér kernel* to achieve this goal,
which will be discussed in the next chapter.

== Pointwise Convergence Tests
In this section, we will discuss several important convergence tests from coarse to fine for Fourier series.

#definition(name: "Hölder condition")[
  There exists a constant $L > 0$ and $alpha in (0, 1]$,
  such that for all sufficiently small $delta$:
  $
    abs(f(x plus.minus u) - f(x)) <= L u^alpha, quad 0 < u < delta,
  $
  then $f$ satisfies $alpha$-order *Hölder condition* at point $x$,
  denoted as $f in text("Lip")_alpha(x)$.
  When $alpha = 1$, it is called *Lipschitz condition*.
]

#lemma(name: "Dirichlet's Lemma")[
  Let $f(x)$ be monotonic on $[0, delta]$, then:
  $
    lim_(p -> oo) integral_(0)^(delta) (f(u) - f(0+)) / (u) sin(p u) dif u = 0.
  $
]
#proof[
  Without loss of generality, assume that $f(x)$ is increasing on $[0, delta]$,
  then for any $epsilon$, there exists a $eta in (0, delta)$, such that:
  $
    0 <= f(u) - f(0+) < epsilon, quad u in (0, eta].
  $
  Divide the integral into two parts:
  $
    & integral_(0)^(delta) (f(u) - f(0+)) / (u) sin(p u) dif u \
      = & integral_(0)^(eta) (f(u) - f(0+)) / (u) sin(p u) dif u \
          + integral_(eta)^(delta) (f(u) - f(0+)) / (u) sin(p u) dif u. \
  $

  For the first term, by integral second mean value theorem,
  there exists $xi in [0, eta]$,
  $
    abs(integral_(0)^(eta) (f(u) - f(0+)) / (u) sin(p u) dif u) \
    &= \
    [f(eta) - f(0+)] abs(integral_(xi)^(eta) (sin(p u)) / (u) dif u) \
    & <= \
    epsilon abs(integral_(xi)^(eta) (sin(p u)) / (u) dif u) \
    & = \
    abs(integral_(p xi)^(p eta) (sin u) / (u) dif u) epsilon \
  $
  Since
  $
    integral_(0)^(+oo) (sin u) / (u) dif u = (pi) / (2),
  $
  there exists a constant $M > 0$, such that:
  $
    abs(integral_(p xi)^(p eta) (sin u) / (u) dif u) < M,
  $
  that is,
  $
    abs(integral_(0)^(eta) (f(u) - f(0+)) / (u) sin(p u) dif u) < M epsilon.
  $

  For the second term, since $((f(u) - f(0+)) / (u)) in cal(R)[eta, delta]$,
  by Riemann-Lebesgue lemma (#link(<lem:Riemann-Lebesgue>)[Lemma]),
  there exists a $P > 0$, such that when $p > P$:
  $
    abs(integral_(eta)^(delta) (f(u) - f(0+)) / (u) sin(p u) dif u) < epsilon.
  $

  In summary, the conclusion holds.
]
#note[
  - There is an equivalent form of Dirichlet's lemma:
    $
      lim_(p -> oo) integral_(0)^(delta) f(u) (sin(p u)) / (u) dif u = (pi) / (2) f(0+).
    $

  - If $f(x)$ is a piecewise monotonic bounded function,
    then Dirichlet's lemma still holds.
]

#theorem[
  Let $f(x) in cal(R)[-pi, pi]$, and satisfies one of the following conditions,
  then the Fourier series of $f(x)$ converges to $(f(x+) + f(x-)) / (2)$ at point $x$:
  1. *Lipschitz's Test.* If $f in text("Lip")_alpha(x)$.

    Since the condition is not easy to verify directly, we can use the following sufficient condition:
    the two quasi-uniliteral derivatives of $f$ at point $x$ exist, i.e.,
    $
      lim_(h -> 0^+) (f(x plus.minus h) - f(x plus.minus)) / (h)
    $
    exist finitely.

  2. *Dini's Test.* There exists a $delta > 0$, such that:
    $
      integral_(0)^(delta) (abs(f(x + u) + f(x - u) - 2S)) / (u) dif u < +oo,
    $
    where $S = (f(x+) + f(x-)) / (2)$.

  3. *Dirichlet-Jordan Test.* If $f(x)$ is of bounded variation on some neighborhood of point $x$,
    i.e., there exists a $delta > 0$, such that $f in "BV"(x - delta, x + delta)$.
]


#example[
  Let $f(x)$ be a $2pi$-periodic function defined as:
  $
    f(x) = cases(
      x x in [-pi, pi),
      -pi x = pi. ,
    ) 
  $
  Find its Fourier series and $1 - (1) / (3) + (1) / (5) - (1) / (7) + dots.h$.
] <ex:1>

#solution[
  By Euler-Fourier formula, we have:
  $
    & a_0 = (1) / (pi) integral_(-pi)^(pi) f(x) dif x = 0, \
    & a_n = (1) / (pi) integral_(-pi)^(pi) f(x) cos(n x) dif x \
    = (1) / (pi) [ x dot (sin(n x)) / (n) |_(-pi)^(pi) \
      - integral_(-pi)^(pi) (sin(n x)) / (n) dif x ] = 0, \
    & b_n = (1) / (pi) integral_(-pi)^(pi) f(x) sin(n x) dif x \
    = (1) / (pi) [ -x dot (cos(n x)) / (n) |_(-pi)^(pi) + integral_(-pi)^(pi) (cos(n x)) / (n) dif x ] \
    = (2 (-1)^(n+1)) / (n). \
  $
  Thus, the Fourier series of $f(x)$ is:
  $
    f(x) ~ sum_(n=1)^(+oo) (-1)^(n+1) (2) / (n) sin(n x).
  $
  Since $f(x) in "BV"[-pi, pi]$, by Dirichlet-Jordan test,
  its Fourier series converges to $f(x)$ at every continuous point $x$
  and to $(f(x+) + f(x-)) / (2)$ at every discontinuous point $x$.

  Then
  $
    x = f(x) = sum_(n=1)^(+oo) (-1)^(n+1) (2) / (n) sin(n x), quad x in (-pi, pi).
  $
  Furthermore,
  $
    tilde(f)(x) = cases(
      f(x) x != 2 k pi + pi,
      (f(pi+) + f(pi-)) / (2) x = 2 k pi + pi,
    ) 
  $
  $
    tilde(f)(x) = cases(
      f(x) x in (2 k pi - pi, 2 k pi + pi),
      (-pi + pi) / (2) = 0 x = 2 k pi + pi,
    ) 
  $
  $
    tilde(f)(x) = sum_(n=1)^(+oo) (-1)^(n+1) (2) / (n) sin(n x),
  $
  where $k in bb(Z), x in bb(R)$.

  Let $x = (pi) / (2)$, then we have:
  $
    (pi) / (2) = sum_(n=1)^(+oo) (-1)^(n+1) (2) / (n) sin(n dot (pi) / (2)),
  $
  $
    (pi) / (4) = sum_(n=1)^(+oo) (-1)^(n+1) (1) / (n) sin(n dot (pi) / (2)) = ,
    sum_(n=1)^(+oo) (-1)^(2 n + 2) (1) / (2 n + 1) sin((2 n + 1) dot (pi) / (2)) = ,
    1 - (1) / (3) + (1) / (5) - (1) / (7) + dots.h. ,
  $
]


=== Gibbs Phenomenon

When a function $f(x)$ has jump discontinuities,
its Fourier series converges to the midpoint of the jump at the discontinuity point.
However, near the discontinuity, the Fourier series exhibits oscillations that overshoot and undershoot
the function's actual values.
This phenomenon is known as the *Gibbs phenomenon*.

For example, for a square wave function $f(x)$ with period $2pi$:
$
  f(x) = cases(
    -1 x in [-pi, 0),
    1 x in (0, pi],
  ) quad quad ,
  f(x) ~ (4) / (pi) sum_(n=0)^(+oo) (sin((2 n + 1) x)) / (2 n + 1). ,
$
Using Dirichlet-Jordan test, $f(x) in "BV"$,
then we can show that the Fourier series of $f(x)$ converges to:
$
  cases(
    f(x) x " is continuous",
    (f(x+) + f(x-)) / (2) x " is discontinuous". ,
  ) 
$
Regarding the partial sum of the $N$-term Fourier series $S_N(f; x)$,
it will exhibit significant overshoot near the discontinuity points (@fig:gibbs).
Even if more sine terms are used, this approximation error will only converge to a limit of
approximately $9 percent$ of the jump height,
although the infinite Fourier series will eventually converge almost everywhere.
#figure(
  image("img/Gibbs.png", width: 40%),
  caption: [Gibbs phenomenon of square wave near a jump discontinuity.],
  placement: auto,
  supplement: [Fig.],
) <fig:gibbs>


This phenomenon is an important consideration in signal processing,
as it can cause high-frequency noise and ringing effects.

== Properties of Fourier series
By Riemann-Lebesgue lemma (#link(<lem:Riemann-Lebesgue>)[Lemma]),
we have the following important conclusion of Fourier coefficients directly:
#proposition[
  Let $f(x) in cal(R)[-pi, pi]$,
  then its Fourier coefficients satisfy:
  $
    lim_(abs(n) -> +oo) hat(f)(n) = 0.
  $

  In real form, it is equivalent to:
  $
    lim_(n -> +oo) a_n = 0, quad lim_(n -> +oo) b_n = 0.
  $
]
And we give a theoretical property, used as a fallback option.
#theorem(name: "Uniqueness Theorem")[
  If $f(x), g(x) in cal(R)[-pi, pi]$ have the same Fourier coefficients,
  i.e., $hat(f)(n) = hat(g)(n)$ for all $n in bb(Z)$,
  then $f(x) = g(x)$ almost everywhere on $[-pi, pi]$.
]

=== Analytical Properties

#theorem(name: "Termwise Integration")[
  If $f(x) in cal(R)[-pi, pi]$ with Fourier series:
  $
    f(x) ~ (a_0) / (2) + sum_(n=1)^(+oo) [ a_n cos(n x) + b_n sin(n x) ],
  $
  then its integral also has a Fourier series obtained by termwise integration:
  $
    integral_(c)^(x) f(t) dif t = integral_(c)^(x) (a_0) / (2) dif t + sum_(n=1)^(+oo) ,
    integral_(c)^(x) [ a_n cos(n t) + b_n sin(n t) ] dif t, quad c, x in [-pi, pi]. ,
  $
]

#note[
  Note that after termwise integration, the resulting Fourier series converges on $[-pi, pi]$
  ($~$ to $=$).
  This is because integration smooths out the function, reducing oscillations and improving convergence behavior.
]

#proof[
  Here, we only prove the case that $f(x)$ has finitely many discontinuities of the first kind on $[-pi, pi]$.
]


#theorem(name: "Termwise Differentiation")[
  If $f(x) in cal(R)[-pi, pi]$ with Fourier series:
  $
    f(x) ~ (a_0) / (2) + sum_(n=1)^(+oo) [ a_n cos(n x) + b_n sin(n x) ],
  $
  and if $f(x)$ is piecewise smooth on $[-pi, pi]$,
  then its derivative also has a Fourier series obtained by termwise differentiation:
  $
    f'(x) ~ sum_(n=1)^(+oo) [ -n a_n sin(n x) + n b_n cos(n x) ].
  $
]

=== Smoothness and Decay Rate

The smoother and less angular a function is,
its Fourier coefficients decay more rapidly (with fewer high-frequency components).
The rougher a function is (with jumps),
the more high-frequency components it has (and the slower the coefficients decay).

#tex-table(
  ("Function Smoothness", "Fourier Coefficient Decay Rate"),
  ([$f in cal(R)[-pi, pi]$], [$hat(f)(n) -> 0$ (slowest)]),
  ([$f$ has jump discontinuities], [$hat(f)(n) ~ O((1) / (n))$]),
  ([$f$ is continuous but not differentiable], [$hat(f)(n) ~ O((1) / (n^2))$]),
  ([$f in C^k$], [$hat(f)(n) ~ O((1) / (n^(k+1)))$]),
  ("Analytic Function", [Exponential Decay ($O(e^(-c abs(n)))$)]),
)

= Cesàro Summation
In the previous chapter, we denote $cal(R)[-pi, pi]$ as the linear space whose elements are
all Riemann integrable or absolutely Riemann integrable functions on $[-pi, pi]$.
Now, for convenience, we introduce the notation $cal(R)^2[-pi, pi]$ as the linear space whose elements are
all Riemann integrable or square Riemann integrable functions on $[-pi, pi]$.
Since for defective integral, the square integrability implies absolute integrability,
we have
$
  cal(R)^2[-pi, pi] subset cal(R)[-pi, pi].
$

== Cesàro Summation and Fejér Kernel
Until now, when we discuss the convergence of series $sum_(n=1)^(oo) a_n$,
the convergence of partial sums $S_N = sum_(n=1)^(N) a_n$ as $N -> oo$ is considered de facto.
The definition is put forward by Cauchy in 1821.
However, there are other ways to define the convergence of series.
Here we introduce Cesàro summation, which is a method to assign sums to some divergent series#footnote[
  By Cauchy proposition (see _Analyse Mathématique - Section 2.1: Convergent Sequences_),
  if $lim_(n -> oo) x_n = l$, then $lim_(n -> oo) (x_1 + x_2 + dots.h + x_n) / (n) = l$.
  That is, the Cesàro sum of a convergent series is equal to its Cauchy sum.
].
#definition(name: "Cesàro Summation")[
  A series $sum_(n=1)^(oo) a_n$ is said to be Cesàro summable to $S$
  if the arithmetical average $sigma_k$ of its partial sums converges to $S$, i.e.,
  $
    lim_(k -> oo) sigma_k = S,
  $
  where
  $
    sigma_k = (S_1 + S_2 + dots.h + S_k) / (k).
  $
]

Due to
$
  S_N(f; x) = (1) / (2pi) integral_(-pi)^(pi) f(x - t) D_N(t) dif t,
$
then
$
  sigma_N(f; x) &= (1) / (N) sum_(k=0)^(N-1) S_k(f; x) ,
  &= (1) / (N) sum_(k=0)^(N-1) (1) / (2pi) integral_(-pi)^(pi) f(x - t) D_k(t) dif t ,
  &= (1) / (2pi) integral_(-pi)^(pi) f(x - t) ( (1) / (N) sum_(k=0)^(N-1) D_k(t) ) dif t ,
  &= (1) / (2pi) integral_(-pi)^(pi) f(x - t) F_N(t) dif t,
$
where
$
  F_N(t) = (1) / (N) sum_(k=0)^(N-1) D_k(t) = (1) / (N) ( (sin((N t) / (2))) / (sin(t / (2))) )^2,
$
is called the *Fejér kernel*.

#figure(
  image("img/Fejér_kernels.png", width: 60%),
  caption: [Fejér kernels $F_N(t)$ for $N = 2, 4, 6, 8, 10$.],
  placement: auto,
  supplement: [Fig.],
) <fig:Fejer-kernels>

Fejér kernel has the following excellent properties:
#property[
  1. *Positivity.* For any integer $N$ and real number $t$, $F_N(t) >= 0$.
    This property significantly distinguishes Fejér kernel from Dirichlet kernel.

  2. *Normalization.* For any integer $N$,
    $
      (1) / (2pi) integral_(-pi)^(pi) F_N(t) dif t = 1.
    $

  3. *Concentration.* For any $delta in (0, pi)$,
    $
      lim_(N -> oo) integral_(delta)^(pi) F_N(t) dif t = 0.
    $

  4. *Bounded.* Its $L^1$ norm is bounded:
    $
      (1) / (2pi) integral_(-pi)^(pi) abs(F_N(t)) dif t = 1.
    $
    Distinct from Dirichlet kernel, whose $L^1$ norm grows logarithmically with $N$:
    $
      (1) / (2pi) integral_(-pi)^(pi) abs(D_N(t)) dif t ~ (4) / (pi^2) log N.
    $
]

#tex-table(
  ("Property", [Dirichlet Kernel ($D_N$)], [Fejér Kernel ($F_N$)]),
  ("Corresponding operation", [Partial sum $S_N$ (truncation)], [Cesàro sum $sigma_N$ (averaging)]),
  (
    "Formula feature",
    [$(sin((N + (1) / (2)) x)) / (2 sin(x / (2)))$ (1st-order)],
    [$(1) / (N) ((sin(((N + 1) x) / (2))) / (sin(x / (2))))^2$ (square)],
  ),
  ("Positivity", [Violent oscillations (positive & negative)], [Non-negative everywhere ($>= 0$)]),
  ([$L^1$ Norm], [$ln N -> oo$ (divergent)], [$= 1$ (bounded)]),
  ([$f in C$], "May diverge", "Uniform convergence"),
  ("Role", "Projection operator", "Approximation operator"),
)

With such a "good kernel", we can develop the following theorem:
#theorem(name: "Fejér Theorem")[
  If $f(x)$ is a continuous function defined on $bb(T)$,
  then its Cesàro means $sigma_N(f; x)$ converge uniformly to $f(x)$ on $bb(T)$, i.e.,
  $
    lim_(N -> oo) sup_(x in bb(T)) abs(sigma_N(f; x) - f(x)) = 0.
  $

  The generalized version is:
  if $f(x) in cal(R)[-pi, pi]$, and $f$ has left and right limits at point $x_0 in [-pi, pi]$,
  then its Cesàro means $sigma_N(f; x_0)$ converge to the average of the left and right limits, i.e.,
  $
    lim_(N -> oo) sigma_N(f; x_0) = (f(x_0^+) + f(x_0^-)) / (2).
  $
]

#note[
  It means that as long as $f$ is integrable or absolutely integrable,
  and has left and right limits at point $x_0$,
  then its Fourier series converges in Cesàro sense at $x_0$.

  Compared with various convergence tests of Fourier series in previous chapter,
  Fejér theorem is brief and to the point.
]

With Fejér theorem, we can obtain that
the trigonometric polynomials are dense in the continuous function space $C(bb(T))$.
and the Weierstrass second approximation theorem#footnote[
  The Weierstrass second approximation theorem states that
  any continuous function defined on a closed interval can be uniformly approximated
  by polynomials to any desired degree of accuracy.
  Refer to _Analyse Mathématique - Section 10.3: Smooth Appropriation of Functions_ for details.
]
can be proved easily.

== Square mean Convergence
=== Parseval's Identity

#theorem(name: "Square Approximation Property of Fourier Series")[
  Let $f(x) in cal(R)^2[-pi, pi]$, and $W$ be an $N$-degree subspace of $cal(R)^2[-pi, pi]$,
  then the best approximation of $f(x)$ in $W$ is just given by its Fourier series partial sum $S_N(f; x)$:
  $
    S_N(f; x) = sum_(n=-N)^(N) hat(f)(n) e^(i n x) = (a_0) / (2) + sum_(n=1)^(N) [ a_n cos(n x) + b_n sin(n x) ].
  $
  And the remainder $E_N(f; x) = f(x) - S_N(f; x)$ satisfies#footnote[
    Refer to _Algèbre Linéaire - Section 10.5: Orthogonal Completion and Orthogonal Projection_.
  ]:
  $
    || E_N(f; x) ||^2 = || f ||^2 - sum_(n=-N)^(N) abs(hat(f)(n))^2 ,
    = (1) / (pi) integral_(-pi)^(pi) f^2(x) dif x - [ (a_0^2) / (2) + sum_(n=1)^(N) (a_n^2 + b_n^2) ]. ,
  $
]

#theorem(name: "Bessel's Inequality")[
  Let $f(x) in cal(R)^2[-pi, pi]$ with Fourier coefficients $hat(f)(n)$,
  then for any integer $N >= 0$:
  $
    sum_(n=-N)^(N) abs(hat(f)(n))^2 <= || f ||^2,
  $
  or in real form:
  $
    (a_0^2) / (2) + sum_(n=1)^(N) (a_n^2 + b_n^2) <= (1) / (pi) integral_(-pi)^(pi) f^2(x) dif x.
  $
]

#theorem(name: "Parseval's Identity")[
  Let $f(x) in cal(R)^2[-pi, pi]$ with Fourier coefficients $hat(f)(n)$,
  then:
  $
    sum_(n=-oo)^(+oo) abs(hat(f)(n))^2 = || f ||^2,
  $
  or in real form:
  $
    (a_0^2) / (2) + sum_(n=1)^(+oo) (a_n^2 + b_n^2) = (1) / (pi) integral_(-pi)^(pi) f^2(x) dif x.
  $

  The generalized form is:
  $
    sum_(n=-oo)^(+oo) hat(f)(n) overline(hat(g)(n)) = ⟨ f, g ⟩,
  $
  or in real form:
  $
    (a_0 c_0) / (2) + sum_(n=1)^(+oo) (a_n c_n + b_n d_n) = (1) / (pi) integral_(-pi)^(pi) f(x) g(x) dif x,
  $
  where $g(x) in cal(R)^2[-pi, pi]$ with Fourier coefficients $hat(g)(n)$,
  $
    g(x) ~ (c_0) / (2) + sum_(n=1)^(+oo) [ c_n cos(n x) + d_n sin(n x) ].
  $
]

#proof[

]

#theorem(name: "Wirtinger Inequality")[
  Let $f(x) in C^1[-pi, pi]$,
  and satisfies:
  $
    integral_(-pi)^(pi) f(x) dif x = 0, f(-pi) = f(pi),
  $
  then:
  $
    integral_(-pi)^(pi) f^2(x) dif x <= integral_(-pi)^(pi) f'^2(x) dif x,
  $
  with equality if and only if $f(x) = A cos x + B sin x$ for some constants $A, B in bb(R)$.
]

#theorem(name: "Poincaré Inequality")[

]

#theorem(name: "Friedrichs Inequality")[

]


=== Square Mean Convergence

#definition(name: "Square Mean Convergence")[
  A sequence of functions $f_n(x)$ is said to converge to $f(x)$
  in the square mean (or $L^2$) sense on interval $[a, b]$,
  if
  $
    lim_(n -> oo) || f_n - f ||^2 = ,
    lim_(n -> oo) integral_(a)^(b) abs(f_n(x) - f(x))^2 dif x = 0. ,
  $
]

#theorem[
  If $f(x) in cal(R)^2[-pi, pi]$,
  then its Fourier series converges to $f(x)$ in the square mean sense on $[-pi, pi]$, i.e.,
  $
    lim_(N -> oo) integral_(-pi)^(pi) abs(f(x) - S_N(f; x))^2 dif x = 0.
  $
]


#example[
  Proof:
  1.
    $
      sum_(n=1)^(oo) (1) / (n^2) = (pi^2) / (6);
    $
  2.
    $
      sum_(n=1)^(oo) (1) / ((2n - 1)^2) = (pi^2) / (8);
    $
  3.
    $
      sum_(n=1)^(oo) ((-1)^(n+1)) / (n^2) = (pi^2) / (12);
    $
  4.
    $
      sum_(n=1)^(oo) ((-1)^(n+1)) / (n^4) = (7 pi^4) / (720);
    $
  5.
    $
      sum_(n=1)^(oo) (1) / (n^4) = (pi^4) / (90).
    $
] <ex:parseval-sums>

#proof[
  #text(fill: purple)[*1.*]
  By #link(<ex:1>)[Example],
  $
    x = 2 sum_(n=1)^(oo) ((-1)^(n+1)) / (n) sin n x, quad x in (-pi, pi).
  $
  Using Parseval's identity, we have
  $
    4 sum_(n=1)^(oo) (1) / (n^2) = (1) / (pi) integral_(-pi)^(pi) x^2 dif x = (2 pi^2) / (3),
  $
  i.e.,
  $
    sum_(n=1)^(oo) (1) / (n^2) = (pi^2) / (6).
  $

  #text(fill: purple)[*2.*]
]

== Equidistribution


== Poisson Kernel

#part("Fourier Transform and Modern Theory") // Fourier 变换与现代理论

= Modern Fourier Analysis
== $L^1$ Space


== $L^2$ Space


== Convergence Theory in $L^2$ Space
#theorem(name: "Carleson-Hunt Theorem")[
  If $f in L^2(bb(T))$, then the Fourier series of $f$ converges to $f$ almost everywhere.
]

= Fourier Transform
== Introduction to Fourier Transform
=== From Periodic to Non-Periodic Functions

Until now, we have only discussed Fourier series for periodic functions.
To extend the idea of Fourier series to non-periodic functions,
we consider the limit as the period $T -> oo$.
In this limit, the discrete frequencies of the Fourier series become continuous,
leading to the definition of the Fourier transform.

For a function $f(x)$ with period $T$, its Fourier series representation is given by
$
  f_T(x) = sum_(n=-oo)^(oo) [ (1) / (2T) integral_(-T)^(T) f(x) e^(-i (pi n) / (T) x) dif x ] ,
  e^(i (pi n) / (T) x). ,
$
Define the frequency variable $omega_n = (n) / (2T)$,
and the frequency increment $Delta omega = omega_(n+1) - omega_n = (1) / (2T)$.
Then we can rewrite the Fourier series as
$
  f_T(x) = sum_(n=-oo)^(oo) [ integral_(-T)^(T) f(x) e^(-i 2 pi omega_n x) dif x ] ,
  e^(i 2 pi omega_n x) Delta omega. ,
$
Let $T -> oo$, we have $Delta omega -> 0$ and the sum becomes an integral:
$
  f(x) = integral_(-oo)^(oo) [ integral_(-oo)^(oo) f(t) e^(-i 2 pi omega t) dif t ] ,
  e^(i 2 pi omega x) dif omega. ,
$
Naturally, we define the Fourier transform and its inverse as follows.
#definition(name: "Fourier Transform and Inverse Fourier Transform")[
  The *Fourier transform* of a function $f(x)$ is defined as
  $
    hat(f)(omega) = cal(F)[f](omega) = integral_(-oo)^(oo) f(x) e^(-i omega x) dif x.
  $
  The *inverse Fourier transform* is given by
  $
    f(x) = cal(F)^(-1)[hat(f)](x) = (1) / (2pi) integral_(-oo)^(oo) hat(f)(omega) e^(i omega x) dif omega.
  $
]
#note[
  The definition of $omega_n$ above leads to the difference of $2pi$ in the exponent compared to the classical definition.
]

=== Poisson Summation Formula


== Schwartz Space
#definition(name: "Schwartz Space")[
  The *Schwartz space* $cal(S)(bb(R))$ is the set of
  all infinitely differentiable functions $f: bb(R) -> bb(C)$
  such that for every pair of non-negative integers $m, n$,
  $
    sup_(x in bb(R)) abs(x^m f^((n))(x)) < oo.
  $
  In other words, functions in $cal(S)(bb(R))$ and
  all their derivatives decay faster than any polynomial as $abs(x) -> oo$.
]

== Basic Properties
#property[
  1. *Linearity.* For any functions $f, g in cal(S)(bb(R))$ and scalars $a, b in bb(C)$,
    $
      cal(F)[a f + b g] = a cal(F)[f] + b cal(F)[g].
    $

  2. *Translation.* For any function $f in cal(S)(bb(R))$ and $x_0 in bb(R)$,
    $
      cal(F)[f(x - x_0)](omega) = e^(-i omega x_0) hat(f)(omega).
    $

  3. *Scaling.* For any function $f in cal(S)(bb(R))$ and $a in bb(R) backslash {0}$,
    $
      cal(F)[f(a x)](omega) = (1) / (abs(a)) hat(f)( (omega) / (a) ).
    $

  4. *Differentiation.* For any function $f in cal(S)(bb(R))$,
    $
      cal(F)[ (dif^n f) / (dif x^n) ](omega) = (i omega)^n hat(f)(omega).
    $

  5. *Integration.*
]



=== Convolution


== Fourier Inversion Theorem

== The Dichotomy

== Heisenberg's Uncertainty Principle

#theorem(name: "Heisenberg's Uncertainty Principle")[
  For any function $f in cal(S)(bb(R))$,
  $
    ( integral_(-oo)^(oo) x^2 abs(f(x))^2 dif x ) ,
    ( integral_(-oo)^(oo) omega^2 abs(hat(f)(omega))^2 dif omega ) ,
    >= (1) / (4) ( integral_(-oo)^(oo) abs(f(x))^2 dif x )^2. ,
  $
  Equality holds if and only if $f(x)$ is a Gaussian function of the form
  $f(x) = A e^(-a x^2)$ for some constants $A in bb(C)$ and $a > 0$.
]

== Laplace Transform
Fourier transform requires the function to be integrable over the entire real line,
which may not hold for functions that grow exponentially.
To handle such functions, we introduce the Laplace transform, defined as follows.
#definition(name: "Laplace Transform")[
  The *Laplace transform* of a function $f(t)$ defined for $t >= 0$ is given by
  $
    cal(L)[f](s) = integral_(0)^(oo) f(t) e^(-s t) dif t,
  $
  where $s$ is a complex variable.
]

#theorem(name: "Existence of Laplace Transform")[
  If there exist constants $M, s_0 > 0$ such that $abs(f(t)) <= M e^(s_0 t)$ for all $t >= 0$,
  then the Laplace transform $cal(L)[f](s)$ exists for all $s$ with $Re(s) > s_0$.
]

#property[
  1. *Linearity.* For any functions $f, g$ and scalars $a, b$,
    $
      cal(L)[a f + b g](s) = a cal(L)[f](s) + b cal(L)[g](s).
    $

  2. *Derivative.* For any function $f$ with appropriate growth conditions,
    $
      cal(L)[ (dif f) / (dif t) ](s) = s cal(L)[f](s) - f(0).
    $
    Or more generally,
    $
      cal(L)[ (dif^n f) / (dif t^n) ](s) = ,
      s^n cal(L)[f](s) - sum_(k=0)^(n-1) s^(n-1-k) f^((k))(0). ,
    $
]

Some common Laplace transforms are listed in the following table.
// TODO: The transform formulas of the last two rows were corrupted in the LaTeX source
// (mismatched \( ... \) and $ delimiters) and are left as placeholders.
#figure(
  tex-table(
    ([$f(t)$], [$cal(L)[f](s)$]),
    ([$1$], [$(1) / (s)$]),
    ([$t^n$], [$(n!) / (s^(n+1))$]),
    ([$e^(a t)$], [$(1) / (s - a)$]),
    ([$t^n e^(a t)$], [$(n!) / ((s - a)^(n+1))$]),
    ([$sin(omega t)$], [$(omega) / (s^2 + omega^2)$]),
    ([$cos(omega t)$], [$(s) / (s^2 + omega^2)$]),
    ([$sinh(omega t)$], [$(omega) / (s^2 - omega^2)$]),
    ([$cosh(omega t)$], [$(s) / (s^2 - omega^2)$]),
    ([$t^n e^(a t) sin(omega t)$], [TODO]),
    ([$t^n e^(a t) cos(omega t)$], [TODO]),
  ),
  caption: [Common Laplace transforms.],
  placement: auto,
  supplement: [Tab.],
) <tab:laplace-transforms>

== Fast Fourier Transform

// Part III — Sobolev Spaces (Sobolev 空间): Chapter 5 has no content yet (placeholder).

#bibliography("references.bib")

// 目录
