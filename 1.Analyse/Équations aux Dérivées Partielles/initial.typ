#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Équations aux Dérivées Partielles",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Équations aux Dérivées Partielles",
  "Violet",
  subtitle: "A notebook for partial differential equations",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.8.0",
  extra-info: "This is a notebook for partial differential equations.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
// 主线：基础与分类 → 一阶方程 → 分布与工具 → 椭圆 → 抛物 → 双曲 → 方法与专题
// 共 7 Part、19 Chapter。
//
// 职责边界：
//   - Fourier 理论 → Analyse Harmonique（交叉引用）
//   - Sobolev 空间：嵌入定理等深层理论 → Analyse Harmonique（交叉引用；
//     W^{k,p} 定义与基本性质在 Ch 11 简述，以支撑弱解与正则性）
//   - Banach / Hilbert 抽象理论 → Analyse Fonctionnelle（交叉引用）
//   - 弱形式、Lax-Milgram、Galerkin、变分方法的抽象框架 → Analyse Fonctionnelle（交叉引用；
//     在椭圆/抛物边值问题中的应用属本笔记）
//   - 谱理论（抽象部分） → Analyse Fonctionnelle（交叉引用）
//   - L^p / 测度论 → Analyse Réelle（交叉引用）
//   - Hamilton-Jacobi 的力学应用 → Mécanique analytique（交叉引用）
//   - 调和函数的复分析视角 → Analyse Complexe（交叉引用）
//   - 应用 PDE（流体、薛定谔等） → 各专门笔记
//
// 去重裁决（相对 v0.4.0）：
//   - 标量一维守恒律完整保留在 Ch 5（原 Ch 2.4）；Ch 17 只保留系统情形增量
//   - 基本解统一在 Ch 7（原 Ch 4.4）构造；椭圆 Green 函数章不再重复
//   - D'Alembert 通解：Ch 2 标准形导出、Ch 15 完整 Cauchy 理论，显式衔接
//   - 比较原理统一在 Ch 13，非线性单调迭代并入，不再单独成节
//
// ==========================================================================
// Part I — Foundations and Classification (基础与分类)
// ==========================================================================
// 设计思路：建立 PDE 的基本语言、适定性概念与二阶分类框架。
// Ch 2（分类与标准形）由原 Ch 3 前移：它是三大类型 Part（IV-VI）的共同前置
// 框架，与 Ch 1 同属「语言层」；原一阶理论独立为 Part II。
// 对应教材：通常占据 PDE 教材的前 2 章。

// --- Chapter 1: Introduction to PDEs (偏微分方程导论) ---

//   Section 1.1: Basic Concepts and Examples (基本概念与例子)
//     - PDE 定义、多指标记号、阶与线性分类（线性/半线性/拟线性/完全非线性）
//     - Laplace、热、波动三大模型方程及物理导出
//   Section 1.2: Order, Linearity and Superposition (阶、线性与叠加原理)
//     - 齐次/非齐次、线性算子、叠加原理
//   Section 1.3: Initial and Boundary Value Problems (初值问题与边值问题)
//     - Cauchy 问题、Dirichlet/Neumann/Robin 边界条件
//   Section 1.4: Well-Posedness (适定性)
//     - Hadamard 三条件、病态例子（椭圆 Cauchy 问题、反向热方程）

#part("Foundations and Classification") // 基础与分类

= Introduction to PDEs // 偏微分方程导论

== Basic Concepts and Examples // 基本概念与例子

A *partial differential equation (PDE)* is an equation involving an unknown function of several variables and its partial derivatives. Formally, a PDE of order $m$ takes the form:

#definition(name: "Partial Differential Equation")[
  A *partial differential equation* of order $m$ is an equation of the form
  $
    F(x, u, nabla u, nabla^2 u, dots, nabla^m u) = 0,
  $
  where $x in Omega subset bb(R)^n$, $Omega$ is an open set, $u: Omega -> bb(R)$ is the unknown function, and $nabla^k u$ denotes all partial derivatives of order $k$ of $u$. Here $F$ is a given function.
] <def:pde>

To express partial derivatives systematically, we use multi-index notation.

#definition(name: "Multi-Index Notation")[
  A *multi-index* $alpha = (alpha_1, dots, alpha_n) in bb(Z)_+^n$ is an $n$-tuple of non-negative integers. We define the order $abs(alpha)$ and the corresponding derivative operator $D^alpha$ by:
] <def:multi-index>

#eq[$
  abs(alpha) &= alpha_1 + alpha_2 + dots + alpha_n, \
  D^alpha u &= (partial^(abs(alpha)) u) / (partial x_1^(alpha_1) partial x_2^(alpha_2) dots partial x_n^(alpha_n)) = partial^(alpha_1)_(x_1) partial^(alpha_2)_(x_2) dots partial^(alpha_n) u.
$] <eq:multi-index>

Using this notation, a general PDE of order $m$ can be written as:
$
  F(x, u, (D^alpha u)_(abs(alpha) <= m)) = 0.
$

#definition(name: "Order of PDE")[
  The *order* of a PDE is the highest order of the partial derivatives appearing in the equation.
] <def:pde-order>

PDEs are classified according to their linearity properties:

#definition(name: "Classification of PDEs by Linearity")[
  Consider a PDE of the form $F(x, u, nabla u, nabla^2 u, dots, nabla^m u) = 0$.

  1. The PDE is *linear* if $F$ is linear in $u$ and all its partial derivatives, i.e.,
    $
      F(x, u, nabla u, dots) = sum_(abs(alpha) <= m) a_alpha(x) D^alpha u - f(x),
    $
    where coefficients $a_alpha(x)$ depend only on $x$.

  2. The PDE is *semilinear* if it is linear in the highest-order derivatives but nonlinear in lower-order derivatives:
    $
      sum_(abs(alpha) = m) a_alpha(x) D^alpha u = f(x, u, (D^beta u)_(abs(beta) < m)).
    $

  3. The PDE is *quasilinear* if it is linear in the highest-order derivatives but coefficients may depend on the function and lower-order derivatives:
    $
      sum_(abs(alpha) = m) a_alpha(x, u, (D^beta u)_(abs(beta) < m)) D^alpha u = f(x, u, (D^beta u)_(abs(beta) < m)).
    $

  4. The PDE is *fully nonlinear* if it is nonlinear in the highest-order derivatives.
] <def:pde-linearity-classification>

Let us introduce three fundamental PDEs that serve as models for large classes of equations:

#definition(name: "Laplace Equation")[
  The *Laplace equation* is given by
  $
    Delta u = sum_(i=1)^n (partial^2 u) / (partial x_i^2) = 0.
  $
  Solutions to this equation are called *harmonic functions*.
] <def:laplace-equation>

The Laplace equation arises in various physical contexts:
- Electrostatics: $Delta V = 0$ where $V$ is the electrostatic potential in a charge-free region
- Steady-state heat conduction: $Delta T = 0$ where $T$ is temperature in equilibrium
- Incompressible fluid flow: $Delta phi = 0$ where $phi$ is the velocity potential

#definition(name: "Heat Equation")[
  The *heat equation* (or diffusion equation) is given by
  $
    u_t - kappa Delta u = f(x,t),
  $
  where $kappa > 0$ is the thermal diffusivity and $f(x,t)$ represents a heat source.
] <def:heat-equation>

Physical derivation: Consider heat flow in a homogeneous medium. Let $u(x,t)$ denote the temperature at position $x$ and time $t$. By conservation of energy and Fourier's law of heat conduction ($bold(q) = -kappa nabla u$ where $bold(q)$ is the heat flux), we obtain:
$
  rho c_p (partial u) / (partial t) = nabla dot (kappa nabla u) + Q,
$
where $rho$ is density, $c_p$ is specific heat capacity, and $Q$ is the heat source. For constant coefficients and rescaling, this becomes $u_t - kappa Delta u = f$.

#definition(name: "Wave Equation")[
  The *wave equation* is given by
  $
    u_(t t) - c^2 Delta u = f(x,t),
  $
  where $c > 0$ is the wave speed and $f(x,t)$ represents a forcing term.
] <def:wave-equation>

Physical derivation: For small amplitude waves in an elastic medium, consider the displacement $u(x,t)$ of particles from equilibrium. Newton's second law combined with Hooke's law for elastic forces leads to:
$
  rho (partial^2 u) / (partial t^2) = nabla dot (c^2 rho nabla u) + F,
$
where $rho$ is density, $c$ is the wave speed, and $F$ is the external force. This simplifies to $u_(t t) - c^2 Delta u = f$ after rescaling.

#example(name: "Identifying PDE Properties")[
  Consider the following equations:

  1. $u_x + u_y = 0$ (First-order linear PDE)
  2. $u_t + u u_x = 0$ (First-order quasilinear PDE - Burgers' equation)
  3. $u_(x x) + u_(y y) = u^2$ (Second-order semilinear PDE)
  4. $u_(x x) u_(y y) - u_(x y)^2 = 1$ (Second-order fully nonlinear PDE - Monge-Ampère type)

  Identify their orders, linearity types, and principal parts.
] <ex:pde-classification>

== Order, Linearity and Superposition // 阶、线性与叠加原理

The classification introduced in #link(<def:pde-linearity-classification>)[§1] determines which structural tools are available for analyzing a PDE. For *linear* equations, the superposition principle allows us to decompose complex solutions into simpler building blocks — a property that fundamentally distinguishes linear PDEs from their nonlinear counterparts.

#definition(name: "Homogeneous and Inhomogeneous Equations")[
  A linear PDE is said to be *homogeneous* if it can be written in the form $L u = 0$, where $L$ is a linear differential operator. It is *inhomogeneous* (or non-homogeneous) if it has the form $L u = f$ with $f not= 0$.
] <def:homogeneous-pde>

#definition(name: "Linear Operator")[
  A differential operator $L$ is *linear* if it satisfies:

  1. $L(u + v) = L u + L v$ (additivity)
  2. $L(c u) = c L u$ (homogeneity)

  for all functions $u, v$ in the domain of $L$ and all scalars $c$.
] <def:linear-operator>

#proposition(name: "Superposition Principle")[
  If $u_1, u_2, dots, u_k$ are solutions of the homogeneous linear PDE $L u = 0$, then any linear combination $u = c_1 u_1 + c_2 u_2 + dots + c_k u_k$ is also a solution, where $c_1, c_2, dots, c_k$ are arbitrary constants.

  Furthermore, if $u_p$ is a particular solution of the inhomogeneous equation $L u = f$ and $u_h$ is the general solution of the homogeneous equation $L u = 0$, then the general solution of $L u = f$ is $u = u_h + u_p$.
] <prop:superposition-principle>

#proof[
  Since $L$ is linear and $L u_i = 0$ for $i = 1, dots, k$, we have:
  $
    L(c_1 u_1 + c_2 u_2 + dots + c_k u_k) = c_1 L u_1 + c_2 L u_2 + dots + c_k L u_k = 0.
  $

  For the inhomogeneous case:
  $
    L(u_h + u_p) = L u_h + L u_p = 0 + f = f.
  $
]

#example(name: "Application of Superposition")[
  The heat equation $u_t - kappa u_(x x) = 0$ is linear and homogeneous. If $u_1(x,t) = sin(x)e^(-kappa t)$ and $u_2(x,t) = cos(x)e^(-kappa t)$ are both solutions, then $u(x,t) = A sin(x)e^(-kappa t) + B cos(x)e^(-kappa t)$ is also a solution for any constants $A, B$.
] <ex:superposition-application>

#note[
  The superposition principle is fundamental to the theory of linear PDEs. It allows us to build complex solutions from simpler ones and forms the basis for solution techniques like separation of variables and Fourier series.
]

== Initial and Boundary Value Problems // 初值问题与边值问题

A PDE alone does not uniquely determine a solution. Additional conditions are required, typically of two types:

#definition(name: "Initial Value Problem (Cauchy Problem)")[
  An *initial value problem* (also called *Cauchy problem*) consists of a PDE together with conditions on the unknown function and its derivatives at an initial time $t = t_0$:
  $
    u(x, t_0) = g_0(x), \
    u_t(x, t_0) = g_1(x), \
    dots.v \
    partial_t^(k-1) u(x, t_0) = g_(k-1)(x),
  $
  where $k$ is the order of the equation in time.
] <def:cauchy-problem>

For example, the wave equation $u_(t t) - c^2 Delta u = 0$ requires two initial conditions:
$
  u(x, 0) = g(x), quad u_t(x, 0) = h(x).
$

#definition(name: "Boundary Value Problem")[
  A *boundary value problem* consists of a PDE in a domain $Omega subset bb(R)^n$ together with conditions on the boundary $partial Omega$.
] <def:bvp>

The three most common boundary conditions are:

#definition(name: "Boundary Conditions")[
  Let $Omega subset bb(R)^n$ be a domain with boundary $partial Omega$, and $bold(n)$ the outward unit normal. The three classical boundary conditions are:

  1. *Dirichlet*: prescribes the value of the solution on the boundary:
    $
      u(x) = g(x) text(" for ") x in partial Omega.
    $

  2. *Neumann*: prescribes the normal derivative of the solution:
    $
      (partial u)/(partial n)(x) = nabla u(x) dot bold(n) = g(x) text(" for ") x in partial Omega.
    $

  3. *Robin* (mixed): a linear combination of the function and its normal derivative:
    $
      alpha(x) u(x) + beta(x) (partial u)/(partial n)(x) = g(x) text(" for ") x in partial Omega,
    $
    where $alpha, beta$ are given functions with $alpha^2 + beta^2 != 0$.
] <def:boundary-conditions>

#example(name: "Classifying Boundary Conditions")[
  For the heat equation $u_t - kappa Delta u = 0$ in a domain $Omega$:

  - Dirichlet: $u(x,t) = 0$ on $partial Omega$ (fixed temperature on boundary)
  - Neumann: $(partial u)/(partial n) = 0$ on $partial Omega$ (insulated boundary)
  - Robin: $u + gamma (partial u)/(partial n) = 0$ on $partial Omega$ (convective boundary condition)
] <ex:boundary-conditions-classification>

#note[
  The choice of boundary conditions depends on the physical problem being modeled. In general, for a second-order PDE, we need one boundary condition per boundary point.
]

== Well-Posedness // 适定性

The concept of well-posedness, introduced by Jacques Hadamard, provides a framework for determining whether a PDE problem has a meaningful solution in the physical sense.

#definition(name: "Well-Posed Problem (Hadamard)")[
  A problem consisting of a PDE together with auxiliary conditions (initial and/or boundary conditions) is said to be *well-posed* in the sense of Hadamard if:

  1. *(Existence)* A solution exists.
  2. *(Uniqueness)* The solution is unique.
  3. *(Stability)* The solution depends continuously on the data (initial/boundary conditions, coefficients, source terms).

  If any of these conditions fails, the problem is said to be *ill-posed* or *not well-posed*.
] <def:well-posedness>

The third condition (stability) is particularly important: small changes in the data should lead to small changes in the solution. This ensures that the mathematical model is robust and that numerical approximations will converge to the true solution.

#example(name: "Laplace Equation with Dirichlet Data")[
  The Dirichlet problem for Laplace's equation:
  $
    cases(
      Delta u = 0 text("in ") Omega,
      u = g text("on ") partial Omega,
    )
  $
  is well-posed under suitable regularity assumptions on the domain $Omega$ and boundary data $g$. Existence and uniqueness can be established using variational methods or maximum principles, and stability follows from the continuous dependence estimate:
  $
    norm(u)_(L^oo(Omega)) <= norm(g)_(L^oo(partial Omega)).
  $
] <ex:laplace-dirichlet-well-posed>

#example(name: "Cauchy Problem for Laplace Equation (Ill-posed)")[
  Consider the Cauchy problem for Laplace's equation in the upper half-plane:
  $
    cases(
      u_(x x) + u_(y y) = 0 y > 0,
      u(x, 0) = f(x),
      u_y(x, 0) = g(x) .,
    )
  $
  This problem is ill-posed. Even if $f$ and $g$ are very small, the solution can grow arbitrarily large. For example, with $f(x) = 0$ and $g(x) = (1/n) sin(n x)$ for large $n$, we have:
  $
    u_n(x,y) = (1/(n^2)) sin(n x) sinh(n y).
  $
  At $y = 1$ and $x = pi/(2n)$, we get $u_n(pi/(2n), 1) = (1/(n^2)) sinh(n) approx (e^n)/(2n^2)$, which grows exponentially as $n -> oo$, despite the data being small in any reasonable norm.
] <ex:laplace-cauchy-ill-posed>

#note[
  The instability of the Cauchy problem for elliptic equations like Laplace's equation explains why such problems rarely occur in applications. Physical measurements of both the function and its normal derivative simultaneously at the same boundary are typically impossible.
]

#example(name: "Backward Heat Equation (Ill-posed)")[
  The backward heat equation:
  $
    u_t = -kappa u_(x x), quad t > 0,
  $
  with final condition $u(x, T) = g(x)$ is ill-posed. Solutions may not exist for arbitrary final data, and when they do exist, they are unstable. Small changes in the final data can lead to exponential growth in the solution at earlier times.

  This can be seen from the solution formula (formal):
  $
    hat(u)(xi, t) = hat(g)(xi) e^(kappa xi^2 (t-T)),
  $
  where $hat(u)$ denotes the Fourier transform. The exponential factor $e^(kappa xi^2 (t-T))$ for $t < T$ grows rapidly for high frequencies $xi$, causing instability.
] <ex:backward-heat-ill-posed>

#proposition(name: "Well-Posedness of the Forward Heat Equation")[
  The initial-boundary value problem for the *forward* heat equation:
  $
    cases(
      u_t - kappa Delta u = f text("in ") Omega times (0, T],
      u(x, 0) = g(x) text("in ") Omega,
      u(x, t) = 0 text("on ") partial Omega times [0, T],
    )
  $
  is well-posed in the sense of #link(<def:well-posedness>)[Hadamard] for suitable data $f$ and $g$. The solution satisfies the stability estimate:
  $
    sup_(t in [0, T]) norm(u(dot, t))_(L^2(Omega)) <= norm(g)_(L^2(Omega)) + integral_0^T norm(f(dot, s))_(L^2(Omega)) dif s.
  $
  This stands in sharp contrast to the backward heat equation (#link(<ex:backward-heat-ill-posed>)[Example above]), where the same estimate fails catastrophically. The full proof requires energy methods developed in #link(<def:heat-equation>)[Ch 12].
] <prop:heat-well-posed>

#caution(title: "Importance of Well-Posedness")[
  Well-posedness is essential for a PDE to model a physical phenomenon correctly. An ill-posed problem indicates either an incomplete mathematical model or inappropriate auxiliary conditions. In numerical computations, ill-posed problems lead to unstable algorithms that amplify errors.
]

#note[
  While well-posedness is crucial for most applications, some important problems in inverse problems, imaging, and control theory are inherently ill-posed. In such cases, regularization techniques are used to obtain stable approximate solutions.
]

// ==========================================================================
// Chapter 2: Classification of Second-Order PDEs (二阶偏微分方程分类)
// ==========================================================================
// 设计思路：由原 Ch 3 前移至此。分类框架是三大类型 Part（IV-VI）的共同前置，
// 故紧接 Ch 1；一阶理论（原 Ch 2）已移往 Part II。

//   Section 2.1: Linear Second-Order Equations (线性二阶方程)
//     - 系数矩阵与主符号
//     - 特征曲面
//     - 二维特征 ODE 与判别式
//   Section 2.2: Elliptic, Parabolic, Hyperbolic Types (椭圆型、抛物型、双曲型)
//     - 判别式分类、Tricomi 混合型
//   Section 2.3: Canonical Forms and Characteristics (标准形与特征线)
//     - 双曲/抛物/椭圆标准形
//     - 波动方程 → d'Alembert 通解（衔接 Ch 15）
//     - 三类特征线视觉对比

= Classification of Second-Order PDEs // 二阶偏微分方程分类

The three model equations introduced in #link(<def:laplace-equation>)[Ch 1] — Laplace, heat, and wave — exhibit fundamentally different solution behaviors: harmonic functions are smooth, heat flow is irreversible, and waves propagate at finite speed. This chapter reveals the algebraic invariant behind this trichotomy: the _principal symbol_ of the second-order operator determines the equation type, which in turn governs the geometry of _characteristic surfaces_ and the canonical form to which the equation can be reduced.

== Linear Second-Order Equations // 线性二阶方程

The most general linear second-order PDE for $u: Omega subset bb(R)^n -> bb(R)$ takes the form

#eq[$
  L[u] = sum_(i, j = 1)^n a_(i j)(x) (partial^2 u) / (partial x_i partial x_j) + sum_(i=1)^n b_i(x) (partial u) / (partial x_i) + c(x) u = f(x),
$] <eq:general-2nd-order>

where $a_{i j}, b_i, c, f$ are given functions on $Omega$. By #link(<def:pde-linearity-classification>)[§1], this equation is _linear_: the unknown $u$ and all its derivatives appear to the first power. We assume $a_{i j} = a_{j i}$ throughout (any non-symmetric coefficient matrix can be symmetrized since $u_{x_i x_j} = u_{x_j x_i}$ for $C^2$ solutions).

=== The Coefficient Matrix and Principal Symbol // 系数矩阵与主符号

The second-order part of $L$ is encoded in the symmetric _coefficient matrix_:

$
  A(x) = (a_{i j}(x))_(1 <= i, j <= n).
$

The operator decomposes as $L[u] = L_2[u] + L_1[u] + c u$, where the _principal (second-order) part_ is

$
  L_2[u] = sum_(i, j = 1)^n a_(i j)(x) (partial^2 u) / (partial x_i partial x_j),
$

and $L_1[u] = sum_i b_i(x) u_(x_i)$ is the first-order part.

#definition(name: "Principal Symbol")[
  The _principal symbol_ of the operator $L$ is the quadratic form
  #eq[$
    a(x, xi) = sum_(i, j = 1)^n a_(i j)(x) xi_i xi_j = xi^T A(x) xi,
  $] <eq:principal-symbol>
  where $xi = (xi_1, dots, xi_n) in bb(R)^n$. The _full symbol_ of $L$ is $sigma(x, xi) = a(x, xi) + i sum_i b_i(x) xi_i - c(x)$, which incorporates lower-order contributions.
]

The principal symbol captures the highest-order behavior of the operator. Since classification depends only on the leading derivatives, the principal symbol — not the full symbol — determines the equation type.

=== Characteristic Surfaces // 特征曲面

The concept of characteristic surfaces generalizes the characteristic curves of first-order PDEs (#link(<def:characteristic-curve>)[§3.1]) to the second-order setting.

#definition(name: "Characteristic Surface")[
  A hypersurface $S subset bb(R)^n$ is a _characteristic surface_ for the operator $L$ if at every point $x in S$, the principal symbol vanishes in the direction of the normal $nu(x)$ to $S$:
  #eq[$
    a(x, nu) = sum_(i, j = 1)^n a_(i j)(x) nu_i nu_j = 0.
  $] <eq:characteristic-eq>
] <def:char-surface>

Characteristic surfaces are the loci along which singularities of solutions can propagate, and across which information may fail to determine the solution uniquely.

#example(name: "Characteristics of Model Equations")[
  *Laplace equation* $Delta u = 0$: Here $A = I$, so $a(xi) = xi_1^2 + dots + xi_n^2 = abs(xi)^2$. The characteristic equation $abs(nu)^2 = 0$ has no nonzero real solutions. The Laplace equation has _no real characteristic surfaces_.

  *Heat equation* $u_t = kappa u_(x x)$: With $(x_1, x_2) = (x, t)$, the coefficient matrix is $A = mat((kappa, 0), (0, 0))$. The characteristic equation $kappa nu_1^2 = 0$ gives $nu_1 = 0$, so surfaces $t = text("const")$ are characteristic. These are precisely the initial/boundary surfaces for the Cauchy problem (#link(<def:cauchy-problem>)[§1]).

  *Wave equation* $u_(t t) - c^2 u_(x x) = 0$: With $(x_1, x_2) = (x, t)$, we have $A = mat((-c^2, 0), (0, 1))$. The characteristic equation $-c^2 nu_1^2 + nu_2^2 = 0$ yields $nu_2 = +- c nu_1$, giving characteristic lines $x +- c t = text("const")$ in the $(x, t)$-plane.
]

=== The Characteristic ODE in Two Dimensions // 二维特征 ODE

For operators with two independent variables, the characteristic equation reduces to an ODE for the characteristic curves.

#proposition(name: "Characteristic Equation as ODE")[
  Let $n = 2$ with $(x_1, x_2) = (x, y)$, and write the principal part as $a u_(x x) + 2 b u_(x y) + c u_(y y)$, so that
  $
    A = mat((a, b), (b, c)).
  $
  The characteristic equation $a nu_1^2 + 2 b nu_1 nu_2 + c nu_2^2 = 0$ with $(nu_1, nu_2) = (d y, -d x)$ becomes
  #eq[$
    a (d y)^2 - 2 b dif x dif y + c (d x)^2 = 0,
  $] <eq:char-ode-2d>
  which yields the ODE for characteristic curves:
  $
    (d y) / (d x) = (b +- sqrt(b^2 - a c)) / a.
  $
  The _discriminant_ $Delta = b^2 - a c$ governs the nature of the solutions.
] <prop:char-ode>

#proof[
  Substitute $nu_1 = d y$ and $nu_2 = -d x$ into $a nu_1^2 + 2 b nu_1 nu_2 + c nu_2^2 = 0$:
  $
    a (d y)^2 + 2 b (d y)(-d x) + c (-d x)^2 = a (d y)^2 - 2 b dif x dif y + c (d x)^2 = 0.
  $
  Dividing by $(d x)^2$ and setting $lambda = (d y)/(d x)$:
  $
    a lambda^2 - 2 b lambda + c = 0 => lambda = (2 b +- sqrt(4 b^2 - 4 a c)) / (2 a) = (b +- sqrt(b^2 - a c)) / a.
  $
]

#note[
  *Extension to $n$ dimensions.* In general, the classification is determined by the eigenvalue signature of $A(x)$:
  - _Elliptic_: all eigenvalues have the same sign ($A$ is definite)
  - _Hyperbolic_: exactly one eigenvalue has a different sign from the rest
  - _Parabolic_: $A$ is singular (at least one zero eigenvalue)

  In two dimensions, these reduce to conditions on the discriminant $Delta = b^2 - a c$, since $det A = a c - b^2 = -Delta$. The systematic study of the three types in 2D is the subject of the next section.
]

== Elliptic, Parabolic, Hyperbolic Types // 椭圆型、抛物型、双曲型

In two independent variables, the classification reduces to a single algebraic quantity: the _discriminant_ of the principal part. We work with the general linear second-order equation in $(x, y)$:

#eq[$
  a(x, y) u_(x x) + 2 b(x, y) u_(x y) + c(x, y) u_(y y) + text("lower-order terms") = f(x, y),
$] <eq:general-2d>

where the principal part has coefficient matrix $A = mat((a, b), (b, c))$ with $det A = a c - b^2$.

#definition(name: "Classification in Two Dimensions")[
  Let $Delta = b^2 - a c$ be the _discriminant_ of the principal part at a point $(x_0, y_0)$. The equation is classified at that point as:

  - *Elliptic* if $Delta < 0$ (equivalently, $det A > 0$): the matrix $A$ is definite.
  - *Parabolic* if $Delta = 0$ (equivalently, $det A = 0$): the matrix $A$ is singular.
  - *Hyperbolic* if $Delta > 0$ (equivalently, $det A < 0$): the matrix $A$ is indefinite.

  If the type is the same at every point of the domain $Omega$, the equation is said to be _of that type_ on $Omega$. If the type varies, the equation is of _mixed type_.
] <def:pde-type-2d>

The connection to characteristic surfaces (#link(<def:char-surface>)[§2.1]) is direct: the characteristic equation $a (d y)^2 - 2 b dif x dif y + c (d x)^2 = 0$ from #link(<eq:char-ode-2d>)[§2.1] has real solutions if and only if $Delta >= 0$. Thus:
- _Elliptic_: no real characteristic curves (solutions are smooth)
- _Parabolic_: one family of characteristic curves (one degenerate direction)
- _Hyperbolic_: two distinct families of characteristic curves (wave-like propagation)

#example(name: "Classification of Model Equations")[
  We classify the three model equations from #link(<def:laplace-equation>)[Ch 1] using #link(<def:pde-type-2d>)[Definition above].

  *Laplace equation* $u_(x x) + u_(y y) = 0$: Here $a = 1$, $b = 0$, $c = 1$, so $Delta = 0 - 1 = -1 < 0$. The Laplace equation is _elliptic_ everywhere.

  *Heat equation* $u_t - kappa u_(x x) = 0$: With $(x_1, x_2) = (x, t)$, we have $a = -kappa$, $b = 0$, $c = 0$, so $Delta = 0 - 0 = 0$. The heat equation is _parabolic_ everywhere. The characteristic surfaces are $t = text("const")$, consistent with #link(<eq:char-ode-2d>)[§2.1].

  *Wave equation* $u_(t t) - c^2 u_(x x) = 0$: With $(x_1, x_2) = (x, t)$, the coefficient matrix is $A = mat((-c^2, 0), (0, 1))$, so $Delta = 0^2 - (-c^2)(1) = c^2 > 0$. The wave equation is _hyperbolic_ everywhere. The characteristic lines $x +- c t = text("const")$ are the two families found in #link(<eq:char-ode-2d>)[§2.1].
] <ex:model-equations-type>

#example(name: "Tricomi Equation and Mixed Type")[
  The *Tricomi equation* is
  $
    y u_(x x) + u_(y y) = 0.
  $
  Here $a = y$, $b = 0$, $c = 1$, so $Delta = 0 - y = -y$. The type depends on the sign of $y$:
  - $y > 0$: $Delta < 0$, _elliptic_ (the upper half-plane)
  - $y = 0$: $Delta = 0$, _parabolic_ (the $x$-axis)
  - $y < 0$: $Delta > 0$, _hyperbolic_ (the lower half-plane)

  The Tricomi equation is the prototypical _mixed-type_ PDE. It arises in transonic gas dynamics, where the flow transitions from subsonic (elliptic) to supersonic (hyperbolic) across the sonic line $y = 0$. The boundary value problem for the Tricomi equation — elliptic in the upper half-plane with data prescribed on the parabolic degeneracy — is known as the _Tricomi problem_.
] <ex:tricomi>

#note[
  *Summary of the 2D classification.* The following table summarizes the three types:

  #table(
    columns: (1fr, 1fr, 1fr, 2fr),
    stroke: .5pt,
    align: center,
    table.header([Type], [Discriminant], [$det A$], [Characteristics]),
    [Elliptic], [$Delta < 0$], [$> 0$], [No real characteristics],
    [Parabolic], [$Delta = 0$], [$= 0$], [One degenerate family],
    [Hyperbolic], [$Delta > 0$], [$< 0$], [Two distinct families],
  )

  The transport equation $u_t + c u_x = 0$, introduced in #link(<ex:transport-equation>)[§3.1], is a _first-order_ hyperbolic equation. When viewed as a second-order equation (by differentiating), it satisfies the wave equation $u_(t t) - c^2 u_(x x) = 0$, confirming the consistency between the first-order and second-order classifications.
]

== Canonical Forms and Characteristics // 标准形与特征线

The classification of #link(<def:pde-type-2d>)[§2.2] is not merely a labeling scheme: it determines the _canonical form_ to which any equation of that type can be reduced by a suitable change of variables. The characteristic curves computed in #link(<eq:char-ode-2d>)[§2.1] provide exactly the coordinates needed for this reduction.

We work with the general linear second-order equation in two variables (#link(<eq:general-2d>)[§2.2]):
$
  a u_(x x) + 2 b u_(x y) + c u_(y y) + text("lower-order terms") = f(x, y).
$

=== Hyperbolic Equations // 双曲型方程

When $Delta = b^2 - a c > 0$, the characteristic ODE #link(<eq:char-ode-2d>)[§2.1] has two distinct real families of solutions:
$
  phi(x, y) = c_1, quad psi(x, y) = c_2.
$

#theorem(name: "Hyperbolic Canonical Form")[
  Let $Delta > 0$ in a domain $Omega$. Introduce characteristic coordinates $xi = phi(x, y)$ and $eta = psi(x, y)$. In these coordinates, the equation reduces to the _first canonical form_:
  #eq[$
    u_(xi eta) = Phi(xi, eta, u, u_xi, u_eta).
  $] <eq:canonical-hyperbolic>
  Equivalently, setting $alpha = xi + eta$ and $beta = xi - eta$, one obtains the _second canonical form_:
  #eq[$
    u_(alpha alpha) - u_(beta beta) = Psi(alpha, beta, u, u_alpha, u_beta).
  $] <eq:canonical-hyperbolic-alt>
]

#proof[
  The chain rule gives:
  $
    u_x = u_xi phi_x + u_eta psi_x, quad u_y = u_xi phi_y + u_eta psi_y.
  $
  Computing second derivatives and substituting into #link(<eq:general-2d>)[§2.2], the coefficient of $u_(xi xi)$ is $a phi_x^2 + 2 b phi_x phi_y + c phi_y^2$, which vanishes precisely because $phi = text("const")$ satisfies the characteristic ODE #link(<eq:char-ode-2d>)[§2.1]. Similarly, the coefficient of $u_(eta eta)$ vanishes because $psi = text("const")$ is also a characteristic family. The only surviving second-order term is proportional to $u_(xi eta)$, yielding #link(<eq:canonical-hyperbolic>)[(7)]. The second form follows by a linear change of variables.
]

#example(name: "Wave Equation in Canonical Form")[
  The wave equation $u_(t t) - c^2 u_(x x) = 0$ from #link(<def:wave-equation>)[Ch 1] has $a = -c^2$, $b = 0$, $c_"coeff" = 1$ (with variables $(x, t)$), so $Delta = c^2 > 0$. The characteristic ODE gives:
  $
    -c^2 (d t)^2 + (d x)^2 = 0 quad => quad x +- c t = text("const").
  $
  Setting $xi = x + c t$ and $eta = x - c t$, the wave equation becomes $u_(xi eta) = 0$, which integrates directly to $u = F(xi) + G(eta) = F(x + c t) + G(x - c t)$. This recovers the _d'Alembert formula_: every solution is a superposition of right- and left-traveling waves.
]

=== Parabolic Equations // 抛物型方程

When $Delta = 0$, the characteristic ODE has a single repeated family of solutions $phi(x, y) = c$.

#theorem(name: "Parabolic Canonical Form")[
  Let $Delta = 0$ in a domain $Omega$. Set $xi = phi(x, y)$ and choose $eta = psi(x, y)$ to be any function functionally independent of $phi$. In these coordinates, the equation reduces to:
  #eq[$
    u_(eta eta) = Phi(xi, eta, u, u_xi, u_eta).
  $] <eq:canonical-parabolic>
  Only one second-order derivative survives.
]

The proof follows the same chain-rule computation: since $Delta = 0$, the two characteristic families coincide, so both the $u_(xi xi)$ and $u_(xi eta)$ coefficients vanish, leaving only $u_(eta eta)$.

#example(name: "Heat Equation in Canonical Form")[
  The heat equation $u_t = kappa u_(x x)$ from #link(<def:heat-equation>)[Ch 1] has $a = -kappa$, $b = 0$, $c_"coeff" = 0$ (with variables $(x, t)$), so $Delta = 0$. The characteristic ODE gives $-kappa (d t)^2 = 0$, so $t = text("const")$ is the single characteristic family. Setting $xi = t$ and $eta = x$, the equation is already in canonical form #link(<eq:canonical-parabolic>)[(9)]:
  $
    u_(eta eta) = (1) / (kappa) u_xi.
  $
  The variable $xi = t$ plays the role of the "evolution parameter," and $eta = x$ is the spatial variable. The absence of a $u_(xi xi)$ term reflects the irreversible nature of diffusion.
]

=== Elliptic Equations // 椭圆型方程

When $Delta < 0$, the characteristic ODE has no real solutions. However, it has two _complex conjugate_ families:
$
  phi(x, y) = alpha(x, y) + i beta(x, y) = c_1, quad overline(phi)(x, y) = alpha(x, y) - i beta(x, y) = c_2.
$

#theorem(name: "Elliptic Canonical Form")[
  Let $Delta < 0$ in a domain $Omega$. Set $alpha = text("Re")(phi)$ and $beta = text("Im")(phi)$. In these coordinates, the equation reduces to:
  #eq[$
    u_(alpha alpha) + u_(beta beta) = Phi(alpha, beta, u, u_alpha, u_beta).
  $] <eq:canonical-elliptic>
]

#proof[
  If we formally apply the hyperbolic reduction with complex coordinates $z = alpha + i beta$ and $bar(z) = alpha - i beta$, the canonical form would be $u_(z bar(z)) = 0$. Converting back to real variables via $alpha = (z + bar(z)) / 2$, $beta = (z - bar(z)) / (2 i)$ transforms $4 u_(z bar(z))$ into $u_(alpha alpha) + u_(beta beta)$, yielding #link(<eq:canonical-elliptic>)[(10)].
]

#example(name: "Laplace Equation in Canonical Form")[
  The Laplace equation $u_(x x) + u_(y y) = 0$ from #link(<def:laplace-equation>)[Ch 1] has $a = 1$, $b = 0$, $c = 1$, so $Delta = -1 < 0$. The characteristic ODE gives:
  $
    (d y)^2 + (d x)^2 = 0 quad => quad y +- i x = text("const").
  $
  The complex characteristic families are $z = y + i x$ and $bar(z) = y - i x$, giving $alpha = y$, $beta = x$. The equation is already in canonical form: $u_(alpha alpha) + u_(beta beta) = 0$. Solutions are precisely the _harmonic functions_, and the canonical form reveals why elliptic equations have no preferred direction — the operator is isotropic.
]

=== Summary and the Transport Equation Revisited // 总结：传输方程再探

The following table summarizes the canonical forms and their characteristic geometry:

#table(
  columns: (1fr, 2fr, 2fr, 2fr),
  stroke: .5pt,
  align: center,
  table.header([Type], [Canonical form], [Coordinates], [Characteristics]),
  [Elliptic], [$u_(alpha alpha) + u_(beta beta) = Phi$], [$alpha + i beta = phi(x, y)$], [Complex; no real curves],
  [Parabolic], [$u_(eta eta) = Phi$], [$xi = phi(x, y)$; $eta$ free], [One real family],
  [Hyperbolic], [$u_(xi eta) = Phi$], [$xi = phi, eta = psi$], [Two real families],
)

#note[
  *The transport equation previewed.* The transport equation $u_t + c u_x = 0$, developed in detail in #link(<ex:transport-equation>)[§3.1], is "the simplest hyperbolic PDE". From the second-order perspective of this chapter, we can now make this precise.

  Differentiating $u_t + c u_x = 0$ with respect to $t$ and $x$ yields:
  $
    u_(t t) + c u_(x t) = 0, quad u_(x t) + c u_(x x) = 0.
  $
  Eliminating the mixed derivative gives $u_(t t) - c^2 u_(x x) = 0$: every solution of the transport equation also satisfies the wave equation. The characteristic lines $x - c t = text("const")$ of the transport equation are one of the two characteristic families of the wave equation; the other family $x + c t = text("const")$ corresponds to left-traveling waves, which the transport equation does not see.

  This confirms the classification hierarchy: first-order hyperbolic equations are the "square roots" of second-order hyperbolic equations, and the characteristic structure is consistent across both levels.
]

=== Characteristics of the Three Types: A Visual Comparison // 三类特征线的视觉对比

#figure(
  image("img/characteristics-three-types.svg", width: 90%),
  caption: [Characteristic curves for the three types of second-order PDEs. _Left_: Elliptic — no real characteristics (complex conjugate families). _Center_: Parabolic — one degenerate family of parallel lines. _Right_: Hyperbolic — two transverse families of characteristic curves.],
  placement: auto,
  supplement: [Fig.],
) <fig:characteristics-three-types>

The figure above provides a geometric summary of the classification. The characteristic curves (#link(<def:char-surface>)[§2.1]) partition the domain differently for each type:
- *Elliptic*: no real characteristics. Information propagates in all directions equally; solutions are smooth.
- *Parabolic*: one family of characteristics. Information propagates along a single preferred direction (the "time" direction); solutions smooth out in that direction.
- *Hyperbolic*: two transverse families. Information propagates along characteristics; solutions can develop singularities along characteristic curves.

// ==========================================================================
// Part II — First-Order PDEs (一阶偏微分方程)
// ==========================================================================
// 设计思路：一阶 PDE 理论（特征线法、Hamilton-Jacobi、守恒律）是类型无关的
// 完整体系，内容量足以独立成 Part。原 Ch 2 拆为三章；新增粘性解节补足
// Hamilton-Jacobi 的现代理论（v0.4.0 中承诺却无归属的部分）。
// 对应教材：通常占据 PDE 教材第 2-3 章。

// --- Chapter 3: Method of Characteristics and Quasilinear Equations (特征线法与拟线性方程) ---

//   Section 3.1: Quasilinear Equations (拟线性方程)
//     - 特征曲线与特征系统
//     - 传输方程
//   Section 3.2: Method of Characteristics (特征线法)
//     - Cauchy 问题、特征线求解三步
//     - 横截条件与非特征曲线定理
//     - 经典解的破裂（激波形成、梯度 catastrophe）

// --- Chapter 4: Hamilton--Jacobi Equations (Hamilton--Jacobi 方程) ---

//   Section 4.1: The Characteristic System and Charpit's Method (特征系统与 Charpit 方法)
//     - Charpit 特征系统
//   Section 4.2: Connection to Classical Mechanics (与经典力学的联系)
//     - Hamilton 主函数；力学应用 → Mécanique analytique（交叉引用）
//   Section 4.3: Viscosity Solutions (粘性解) [新增]
//     - Crandall-Lions 定义与唯一性
//     - 与特征线解的关系

// --- Chapter 5: Conservation Laws in One Space Dimension (一维守恒律) ---

//   Section 5.1: Derivation of Conservation Laws (守恒律的推导)
//   Section 5.2: Solution by Characteristics (特征线求解)
//   Section 5.3: Traveling Wave Solutions (行波解)
//   Section 5.4: The Rankine--Hugoniot Condition (Rankine--Hugoniot 条件)
//     - 激波与稀疏波
//   （标量一维理论在此完整处理；系统的守恒律见 Ch 17）

#part("First-Order PDEs") // 一阶偏微分方程

= Method of Characteristics and Quasilinear Equations // 特征线法与拟线性方程

The theory of first-order PDEs is built around a single unifying idea: _characteristic curves_ along which a PDE reduces to a system of ODEs. This part develops the method of characteristics in full generality and applies it to quasilinear equations, Hamilton--Jacobi equations, and conservation laws.

== Quasilinear Equations // 拟线性方程

Consider a first-order PDE with two independent variables:

#eq[$
  a(x, y, u) (partial u) / (partial x) + b(x, y, u) (partial u) / (partial y) = c(x, y, u).
$] <eq:quasilinear-pde>

where $u = u(x, y)$ is the unknown function and $a, b, c$ are given functions with $a$ and $b$ not both zero. By #link(<def:pde-linearity-classification>)[§1], this equation is _quasilinear_: it is linear in the first-order derivatives, but the coefficients may depend on $u$ itself.

The left-hand side can be interpreted as a directional derivative:
$
  a u_x + b u_y = nabla u dot (a, b).
$
The equation states that the directional derivative of $u$ along the vector field $(a, b)$ equals $c$ at every point.

=== Characteristic Equations // 特征方程

The key idea is to find curves along which the PDE becomes an ODE. Introduce a parameter $t$ and construct curves $(x(t), y(t), u(t))$ in three-dimensional space whose tangent vector is parallel to $(a, b, c)$ at each point.

#definition(name: "Characteristic Curves")[
  The _characteristic curves_ of the quasilinear equation (#link(<eq:quasilinear-pde>)[1]) are the curves $(x(t), y(t), u(t))$ satisfying the _characteristic system_:
] <def:characteristic-curve>

#eq[$
  (dif x) / (dif t) = a(x, y, u), quad (dif y) / (dif t) = b(x, y, u), quad (dif u) / (dif t) = c(x, y, u).
$] <eq:char-system>

Along these curves, the PDE reduces to an ODE.

#lemma(name: "Solution Along Characteristics")[
  If $u(x,y)$ satisfies (#link(<eq:quasilinear-pde>)[1]), then along any characteristic curve:
  $
    (dif u) / (dif t) = c(x(t), y(t), u(t)).
  $
] <lem:char-constant>

#proof[
  By the chain rule:
  $
    (dif u) / (dif t) = (partial u) / (partial x) (dif x) / (dif t) + (partial u) / (partial y) (dif y) / (dif t) = a u_x + b u_y = c.
  $
]

This lemma is the heart of the method: it converts the PDE into an ODE system along characteristic curves. The existence and uniqueness theory for the Cauchy problem then follows from the corresponding ODE theory (Picard--Lindelöf theorem).

The projection of the characteristic curve onto the $(x, y)$-plane (determined by the first two equations of (#link(<eq:char-system>)[2])) is called the _characteristic baseline_.

#example(name: "Transport Equation")[
  The simplest first-order PDE is the _transport equation_:
  $
    u_t + c u_x = 0, quad c in bb(R).
  $
  This is (#link(<eq:quasilinear-pde>)[1]) with $a = 1$, $b = c$, and $c(x,y,u) = 0$ (here the independent variables are $(x, t)$). The characteristic system is:
  $
    (dif x) / (dif t) = c, quad (dif u) / (dif t) = 0.
  $
  The characteristics are straight lines $x = c t + x_0$ in the $x t$-plane, and $u$ is constant along each line. The general solution is:
  $
    u(x, t) = f(x - c t),
  $
  where $f$ is an arbitrary differentiable function. The solution represents a wave profile $f$ propagating at speed $c$ without change of shape.
] <ex:transport-equation>

#note[
  The transport equation is closely related to the wave equation #link(<def:wave-equation>)[Ch 1]: it is the simplest hyperbolic PDE and serves as a building block for understanding wave propagation; the classification of Ch 2 makes this precise.
]

The example above illustrates the general strategy: (1) write down the characteristic equations (#link(<eq:char-system>)[2]); (2) solve the ODE system; (3) use the initial data to determine the solution. We formalize this procedure in §3.2.

#note[
  Although we have presented the theory for two independent variables, the method extends directly to $n$ variables. The characteristic system for a first-order PDE in $n$ independent variables consists of $n + 1$ ODEs, and the same geometric ideas apply.
]

== Method of Characteristics // 特征线法

We now formalize the procedure illustrated in §3.1 into a systematic method for solving the Cauchy problem for first-order PDEs.

=== The Cauchy Problem // Cauchy 问题

Given the quasilinear equation (#link(<eq:quasilinear-pde>)[1]), the _Cauchy problem_ consists of finding a solution $u(x, y)$ satisfying prescribed values on a curve $Gamma$ in the $(x, y)$-plane.

#definition(name: "Cauchy Problem for First-Order PDE")[
  Let $Gamma$ be a curve in $bb(R)^2$ parametrized by $(x_0(s), y_0(s))$ for $s in I subset bb(R)$, and let $u_0: I -> bb(R)$ be a given function. The _Cauchy problem_ for (#link(<eq:quasilinear-pde>)[1]) is:
  $
    cases(
      a u_x + b u_y = c(x, y, u), "along characteristics",
      u(x_0(s), y_0(s)) = u_0(s), "initial data on" Gamma,
    )
  $
  The curve $Gamma$ is called the _initial curve_ (or _base curve_), and $u_0$ is the _initial data_.
] <def:cauchy-first-order>

=== Solving via Characteristics // 特征线求解

The method proceeds in three steps.

*Step 1: Parametrize the initial data.* At each point $(x_0(s), y_0(s))$ on $Gamma$, the characteristic curve passing through this point carries the value $u_0(s)$. This gives the initial conditions for the characteristic system (#link(<eq:char-system>)[2]):

#eq[$
  x(s, 0) = x_0(s), quad y(s, 0) = y_0(s), quad u(s, 0) = u_0(s).
$] <eq:char-initial-cond>

*Step 2: Solve the characteristic ODE system.* For each fixed $s$, solve (#link(<eq:char-system>)[2]) with initial conditions (#link(<eq:char-initial-cond>)[3]) to obtain a family of characteristic curves:
$
  (x(s, t), y(s, t), u(s, t)).
$

*Step 3: Invert the projection.* The map $(s, t) |-> (x(s, t), y(s, t))$ sends characteristic labels to points in the plane. If this map is locally invertible, we can solve for $(s, t)$ as functions of $(x, y)$ and substitute into $u(s, t)$ to obtain the solution $u(x, y)$.

=== The Transversality Condition // 横截条件

The invertibility in Step 3 is guaranteed by the implicit function theorem provided the Jacobian is nonzero.

#definition(name: "Non-characteristic Curve")[
  The initial curve $Gamma$ is said to be _non-characteristic_ at a point $P = (x_0(s), y_0(s))$ if
  $
    det (mat(
      x_0'(s), y_0'(s);
      a(x_0(s), y_0(s), u_0(s)), b(x_0(s), y_0(s), u_0(s))
    )) != 0.
  $
  Equivalently, the vector $(a, b)$ is not tangent to $Gamma$ at $P$.
] <def:non-characteristic>

Geometrically, the non-characteristic condition means that the characteristic direction $(a, b)$ is _transverse_ to the initial curve: characteristics cross $Gamma$ rather than running along it.

#theorem(name: "Local Existence and Uniqueness")[
  Let $a, b, c$ be $C^1$ functions, and let $Gamma$ be a $C^1$ non-characteristic initial curve with $C^1$ initial data $u_0$. Then the Cauchy problem #link(<def:cauchy-first-order>)[1] has a unique $C^1$ solution in a neighborhood of $Gamma$.
] <thm:cauchy-existence-unique>

#proof[
  Since $Gamma$ is non-characteristic, the Jacobian
  $
    J(s, t) = det (mat(
      partial x / partial s, partial y / partial s;
      partial x / partial t, partial y / partial t
    ))
  $
  satisfies $J(s, 0) = x_0'(s) b - y_0'(s) a != 0$ at every point of $Gamma$. By the inverse function theorem, the map $(s, t) |-> (x(s, t), y(s, t))$ is a local diffeomorphism near $t = 0$. The solution $u(x, y) = u(s(x, y), t(x, y))$ is therefore well-defined and $C^1$ in a neighborhood of $Gamma$. Uniqueness follows from the uniqueness of the characteristic ODEs (Picard--Lindelöf theorem).
]

#example(name: "Cauchy Problem for the Transport Equation")[
  Consider the transport equation $u_t + c u_x = 0$ with initial data $u(x, 0) = g(x)$. The initial curve is the $x$-axis: $(x_0(s), t_0(s)) = (s, 0)$, with $u_0(s) = g(s)$.

  The characteristic system with initial conditions is:
  $
    (dif x) / (dif t) = c, quad x(s, 0) = s; quad quad (dif u) / (dif t) = 0, quad u(s, 0) = g(s).
  $
  Solving: $x(s, t) = s + c t$ and $u(s, t) = g(s)$. The map $(s, t) |-> (x, t) = (s + c t, t)$ has Jacobian $1 != 0$, so it is globally invertible: $s = x - c t$. The solution is:
  $
    u(x, t) = g(x - c t).
  $
] <ex:transport-cauchy>

=== Breakdown of Classical Solutions // 经典解的破裂

Even when the initial data is smooth, the solution of a _quasilinear_ (nonlinear in $u$) first-order PDE may cease to exist after a finite time. This occurs when characteristics cross, creating a _shock_.

#example(name: "Shock Formation in Burgers' Equation")[
  Consider _inviscid Burgers' equation_:
  $
    u_t + u u_x = 0, quad u(x, 0) = u_0(x).
  $
  This is (#link(<eq:quasilinear-pde>)[1]) with $a = 1$, $b = u$, $c = 0$. The characteristic system is:
  $
    (dif x) / (dif t) = u, quad (dif u) / (dif t) = 0.
  $
  Since $u$ is constant along characteristics, each characteristic is a straight line $x = u_0(s) t + s$ with slope $u_0(s)$. If $u_0$ is decreasing somewhere (i.e., $u_0'(s) < 0$ for some $s$), then characteristics emanating from regions where $u_0$ is larger will overtake those from regions where $u_0$ is smaller. The characteristics cross at time:
  $
    t^"break" = -1 / min u_0'(s),
  $
  provided $min u_0'(s) < 0$. At this time, the classical solution breaks down: $u_x$ becomes infinite (a _gradient catastrophe_).
] <ex:burgers-shock>

#note[
  After the breaking time $t^"break"$, the solution must be continued as a _weak solution_ that admits discontinuities (shocks). The theory of weak solutions and shock conditions is developed in Ch 5.
]

#note[
  #figure(
    image("./img/characteristics-crossing.svg", width: 70%),
    caption: [Characteristic curves in the $x t$-plane for Burgers' equation $u_t + u u_x = 0$ with decreasing initial data. The characteristics converge and intersect at the breaking time $t^"break"$, where the classical solution develops a gradient catastrophe.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:characteristics-crossing>
]

= Hamilton--Jacobi Equations // Hamilton--Jacobi 方程

We now turn to a fundamentally different class of first-order PDEs: those that are _fully nonlinear_ in the first-order derivatives.

#definition(name: "Hamilton--Jacobi Equation")[
  A _Hamilton--Jacobi equation_ is a first-order PDE of the form
  $
    H(x, y, u, u_x, u_y) = 0,
  $
  where $H: bb(R)^5 -> bb(R)$ is a given function. The equation is _fully nonlinear_ in the sense that $H$ depends nonlinearly on the gradient $(u_x, u_y)$.
] <def:hamilton-jacobi>

The most important special case arises when $H$ does not depend on $u$ explicitly:

#eq[$
  H(x, y, u_x, u_y) = 0.
$] <eq:hj-no-u>

This is the form that appears most naturally in classical mechanics and the calculus of variations.

== The Characteristic System for Hamilton--Jacobi // Hamilton--Jacobi 特征系统

Unlike the quasilinear case, the characteristic system for a fully nonlinear equation involves not only $(x, y, u)$ but also the derivatives $p = u_x$ and $q = u_y$.

#theorem(name: "Charpit's Method")[
  Let $F(x, y, u, p, q) = 0$ be a fully nonlinear first-order PDE, where $p = u_x$ and $q = u_y$. The _Charpit characteristic system_ is:
  $
    cases(
      (dif x) / (dif t) = F_p,
      (dif y) / (dif t) = F_q,
      (dif u) / (dif t) = p F_p + q F_q,
      (dif p) / (dif t) = -(F_x + p F_u),
      (dif q) / (dif t) = -(F_y + q F_u),
    )
  $
  where subscripts on $F$ denote partial derivatives. Along the characteristic curves, $F$ is conserved: $(dif F)/(dif t) = 0$.
] <thm:charpit>

#proof[
  We verify that $F$ is conserved. By the chain rule:
  $
    (dif F) / (dif t) = F_x (dif x) / (dif t) + F_y (dif y) / (dif t) + F_u (dif u) / (dif t) + F_p (dif p) / (dif t) + F_q (dif q) / (dif t).
  $
  Substituting the characteristic equations:
  $
    (dif F) / (dif t) = F_x F_p + F_y F_q + F_u (p F_p + q F_q) + F_p (-(F_x + p F_u)) + F_q (-(F_y + q F_u)).
  $
  Expanding and collecting terms:
  $
    (dif F) / (dif t) = F_x F_p + F_y F_q + p F_u F_p + q F_u F_q - F_p F_x - p F_p F_u - F_q F_y - q F_q F_u = 0.
  $
  All terms cancel in pairs.
]

== Connection to Classical Mechanics // 与经典力学的联系

The Hamilton--Jacobi equation plays a central role in classical mechanics. Consider a Hamiltonian system with Hamiltonian $H(bold(q), bold(p), t)$, where $bold(q) = (q_1, dots, q_n)$ are generalized coordinates and $bold(p) = (p_1, dots, p_n)$ are conjugate momenta.

#definition(name: "Hamilton--Jacobi Equation in Mechanics")[
  The _Hamilton--Jacobi equation_ for a mechanical system with Hamiltonian $H$ is:
  $
    (partial S) / (partial t) + H(bold(q), nabla_(bold(q)) S, t) = 0,
  $
  where $S(bold(q), t)$ is _Hamilton's principal function_ and $bold(p) = nabla_(bold(q)) S$.
] <def:hj-mechanics>

#note[
  The key insight of Hamilton--Jacobi theory is that if one can find a complete solution $S(bold(q), bold(alpha), t)$ depending on $n$ parameters $bold(alpha) = (alpha_1, dots, alpha_n)$, then the equations of motion are obtained by differentiation: $bold(p) = nabla_(bold(q)) S$ and $bold(beta) = nabla_(bold(alpha)) S$, where $bold(beta)$ are constants. This reduces the problem of solving $2n$ ODEs (Hamilton's equations) to solving a single PDE.
]

#example(name: "Hamilton--Jacobi for a Free Particle")[
  For a free particle of mass $m$, the Hamiltonian is $H = abs(bold(p))^2 / (2m)$. The Hamilton--Jacobi equation in one dimension is:
  $
    (partial S) / (partial t) + 1 / (2m) ((partial S) / (partial q))^2 = 0.
  $
  We seek a complete solution of the form $S(q, alpha, t) = W(q, alpha) - E(alpha) t$. Substituting:
  $
    -E + 1 / (2m) (W'(q))^2 = 0 => W'(q) = sqrt(2 m E) => W = sqrt(2 m E) q.
  $
  Taking $alpha = E$, the complete solution is:
  $
    S(q, E, t) = sqrt(2 m E) q - E t.
  $
  The equation of motion follows from $beta = (partial S) / (partial E) = sqrt(m / (2E)) q - t$, giving $q = sqrt(2E/m) (t + beta)$, which is uniform motion as expected.
] <ex:hj-free-particle>

= Conservation Laws in One Space Dimension // 一维守恒律

We now apply the method of characteristics to an important class of nonlinear first-order PDEs arising in fluid dynamics, traffic flow, and gas dynamics.

== Derivation of Conservation Laws // 守恒律的推导

Consider a quantity with density $u(x, t)$ and flux $f(u)$ in one spatial dimension. Conservation of the quantity in any interval $[a, b]$ requires:

#eq[$
  (dif) / (dif t) integral_a^b u(x, t) dif x = f(u(a, t)) - f(u(b, t)).
$] <eq:conservation-integral>

Assuming sufficient smoothness and applying the fundamental theorem of calculus to the right side:

#eq[$
  integral_a^b [u_t + (f(u))_x] dif x = 0.
$]

Since this holds for every interval $[a, b]$, the integrand must vanish:

#definition(name: "Conservation Law")[
  The _conservation law_ in one space dimension is:
  $
    u_t + (f(u))_x = 0,
  $
  where $u = u(x, t)$ is the conserved density and $f: bb(R) -> bb(R)$ is the _flux function_. Expanding the derivative:
  $
    u_t + f'(u) u_x = 0.
  $
] <def:conservation-law>

This is a quasilinear equation (#link(<eq:quasilinear-pde>)[1]) with $a = 1$, $b = f'(u)$, and $c = 0$.

== Solution by Characteristics // 特征线求解

The characteristic system for the conservation law is:

#eq[$
  (dif x) / (dif t) = f'(u), quad (dif u) / (dif t) = 0.
$] <eq:conservation-char>

Since $u$ is constant along characteristics, each characteristic is a straight line in the $x t$-plane with slope $f'(u_0(s))$, where $u_0(s)$ is the initial data $u(x, 0) = u_0(x)$.

The solution is given implicitly by:

#eq[$
  u(x, t) = u_0(x - f'(u) t).
$] <eq:conservation-implicit>

This is an implicit equation for $u$: the value of $u$ at $(x, t)$ equals the initial value at the foot of the characteristic passing through $(x, t)$.

== Traveling Wave Solutions // 行波解

When the flux function is linear, $f(u) = c u$, the conservation law reduces to the transport equation and the solution is a traveling wave. For nonlinear flux, we can still look for special solutions.

#definition(name: "Traveling Wave Solution")[
  A _traveling wave solution_ of the conservation law is a solution of the form $u(x, t) = phi(x - v t)$ for some profile function $phi$ and wave speed $v$. Substituting into $u_t + f'(u) u_x = 0$:
  $
    -v phi' + f'(phi) phi' = 0 => (f'(phi) - v) phi' = 0.
  $
  Either $phi' = 0$ (constant solution) or $f'(phi) = v$ (constant speed). For a _shock wave_ (discontinuous traveling wave), the speed is determined by the Rankine--Hugoniot condition.
] <def:traveling-wave>

== The Rankine--Hugoniot Condition // Rankine--Hugoniot 条件

When characteristics cross, the classical solution breaks down and we must admit discontinuous (weak) solutions. Consider a shock located at $x = s(t)$ separating left state $u_L$ from right state $u_R$.

#theorem(name: "Rankine--Hugoniot Condition")[
  A discontinuity at $x = s(t)$ is a weak solution of the conservation law $u_t + f(u)_x = 0$ if and only if the shock speed satisfies:
  $
    s'(t) = (f(u_L) - f(u_R)) / (u_L - u_R),
  $
  where $u_L$ and $u_R$ are the values of $u$ to the left and right of the shock.
] <thm:rankine-hugoniot>

#proof[
  Integrate the conservation law over a small rectangle $[s(t) - epsilon, s(t) + epsilon] times [t_1, t_2]$:
  $
    integral_(t_1)^(t_2) integral_(s(t) - epsilon)^(s(t) + epsilon) [u_t + f(u)_x] dif x dif t = 0.
  $
  Applying the fundamental theorem of calculus and letting $epsilon -> 0$:
  $
    integral_(t_1)^(t_2) [f(u_L) - f(u_R) - s'(t)(u_L - u_R)] dif t = 0.
  $
  Since this holds for all $[t_1, t_2]$, the integrand must vanish, yielding the result.
]

#example(name: "Burgers' Equation with Shock")[
  Consider Burgers' equation $u_t + u u_x = 0$ (flux $f(u) = u^2 / 2$) with step initial data:
  $
    u(x, 0) = cases(u_L, x < 0, u_R, x > 0.)
  $
  where $u_L > u_R$. The characteristics from the left carry value $u_L$ with speed $u_L$, and those from the right carry $u_R$ with speed $u_R$. Since $u_L > u_R$, they intersect immediately, forming a shock at $x = 0$.

  The Rankine--Hugoniot condition (#link(<thm:rankine-hugoniot>)[RH]) gives the shock speed:
  $
    s' = (u_L^2 / 2 - u_R^2 / 2) / (u_L - u_R) = (u_L + u_R) / 2.
  $
  The shock is the straight line $x = (u_L + u_R) t / 2$.
] <ex:burgers-shock-solution>

#note[
  When $u_L < u_R$ (the opposite case), characteristics diverge rather than converge, and no shock forms. Instead, a _rarefaction wave_ (continuous self-similar solution) fills the gap:
  $
    u(x, t) = cases(
      u_L, x < u_L t,
      x / t, u_L t <= x <= u_R t,
      u_R, x > u_R t.
    )
  $
]

#note[
  #figure(
    image("./img/burgers-shock-rarefaction.svg", width: 80%),
    caption: [Solutions of Burgers' equation $u_t + u u_x = 0$. *Left:* Shock wave for $u_L > u_R$: characteristics converge and a shock forms at speed $s = (u_L + u_R)/2$. *Right:* Rarefaction wave for $u_L < u_R$: characteristics diverge and a fan of characteristics fills the expansion region.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:burgers-shock-rarefaction>
]

// ==========================================================================
// Part III — Distribution Theory (分布理论)
// ==========================================================================
// 设计思路：分布理论是为三类方程服务的工具层，拆为两章以避免单章 Part。
// 基本解（原 Ch 4.4）在此统一构造；椭圆 Green 函数章不再重复（去重）。
// 对应教材：通常占据 PDE 教材 1-2 章（或附录）。

// --- Chapter 6: Distributions and Weak Derivatives (分布与弱导数) ---

//   Section 6.1: Test Functions and Distributions (测试函数与分布)
//     - D(Ω)、S(bb(R)^n)、分布、正则/奇异分布、支撑
//   Section 6.2: Weak Derivatives (弱导数)
//     - 定义、唯一性、与经典导数一致
//     - |x| 与 Heaviside 的例子

// --- Chapter 7: Convolution and Fundamental Solutions (卷积与基本解) ---

//   Section 7.1: Convolution and Approximation (卷积与逼近)
//     - 卷积、磨光子、逼近定理
//   Section 7.2: Fundamental Solutions (基本解)
//     - Malgrange-Ehrenpreis 定理
//     - Laplace/Heat/Wave 基本解（Newton 位势、热核、光锥支撑）
//     - 三大类型传播行为对比（衔接 Ch 8/12/15）

#part("Distribution Theory") // 分布理论

= Distributions and Weak Derivatives // 分布与弱导数 <sec:ch4-distributions>

The classical theory of PDEs seeks smooth solutions. However, many physically relevant problems — point charges in electrostatics, shock waves, impulse forces — have no classical solution. Distribution theory, introduced by Schwartz in the 1940s, provides a rigorous framework that extends the notion of functions, allows differentiation of non-smooth objects, and supplies the concept of a *fundamental solution* for linear PDEs with constant coefficients.

This chapter develops the foundational tools: test function spaces, distributions, weak derivatives, convolution, and fundamental solutions. These tools are then applied in subsequent chapters to study elliptic, parabolic, and hyperbolic equations.

== Test Functions and Distributions // 测试函数与分布

The strategy of distribution theory is to transfer derivatives from the unknown function onto smooth "test functions" via integration by parts. This requires a space of test functions with strong regularity and support properties, and a dual space of "generalized functions."

#definition(name: "Space of Test Functions $cal(D)(Omega)$")[
  Let $Omega subset bb(R)^n$ be an open set. The space $cal(D)(Omega) = C_c^oo(Omega)$ consists of all infinitely differentiable functions with *compact support* in $Omega$:
  $
    cal(D)(Omega) = {phi in C^oo(Omega) : "supp"(phi) " is compact and" "supp"(phi) subset Omega}.
  $
  A sequence $(phi_j)$ *converges* to $phi$ in $cal(D)(Omega)$ if there exists a compact set $K subset Omega$ such that $"supp"(phi_j) subset K$ for all $j$, and for every multi-index $alpha$,
  $
    sup_(x in K) abs(D^alpha phi_j(x) - D^alpha phi(x)) -> 0 quad "as" j -> oo.
  $
] <def:test-fn-space-D>

The space $cal(D)(Omega)$ is non-trivial: it contains functions that are smooth yet compactly supported.

#lemma(name: "Existence of Bump Functions")[
  For every $a in bb(R)^n$ and $r > 0$, there exists a function $phi in cal(D)(bb(R)^n)$ such that $phi >= 0$, $"supp"(phi) = overline(B(a, r))$, and $integral phi dif x > 0$.

  #proof[
    Define the auxiliary function:
    $
      f(t) = cases(
        e^(-1/t), t > 0,
        0, t <= 0.
      )
    $
    One verifies by induction that $f in C^oo(bb(R))$ with $f^(k)(0) = 0$ for all $k >= 0$. Now set:
    $
      g(x) = f(r^2 - abs(x - a)^2).
    $
    Then $g in C^oo(bb(R)^n)$, $g(x) > 0$ for $abs(x - a) < r$, and $g(x) = 0$ for $abs(x - a) >= r$. Thus $"supp"(g) = overline(B(a, r))$ and $g$ is the desired bump function.
  ]
] <lem:bump-function>

#note[
  The bump function from #link(<lem:bump-function>)[§6.1 Lemma] is the building block for partitions of unity, which are essential for localizing PDE problems and extending local results to global ones.
]

For problems on all of $bb(R)^n$, a larger test function space with controlled decay at infinity is more convenient.

#definition(name: "Schwartz Space $cal(S)(bb(R)^n)$")[
  The *Schwartz space* $cal(S)(bb(R)^n)$ consists of all $phi in C^oo(bb(R)^n)$ such that for every pair of multi-indices $alpha, beta$,
  $
    sup_(x in bb(R)^n) abs(x^alpha D^beta phi(x)) < oo.
  $
  A sequence $(phi_j)$ converges to $phi$ in $cal(S)(bb(R)^n)$ if for all multi-indices $alpha, beta$,
  $
    sup_(x in bb(R)^n) abs(x^alpha D^beta(phi_j(x) - phi(x))) -> 0 quad "as" j -> oo.
  $
] <def:test-fn-space-S>

#note[
  The Schwartz space satisfies $cal(D)(bb(R)^n) subset cal(S)(bb(R)^n) subset C^oo(bb(R)^n)$. Functions in $cal(S)$ and all their derivatives decay faster than any polynomial at infinity — this makes $cal(S)$ the natural domain for the Fourier transform (see Analyse Harmonique).
]

We now define distributions as continuous linear functionals on test functions.

#definition(name: "Distribution")[
  A *distribution* on an open set $Omega subset bb(R)^n$ is a continuous linear functional $T: cal(D)(Omega) -> bb(R)$. The space of all distributions is denoted $cal(D)'(Omega)$.

  Concretely, $T in cal(D)'(Omega)$ satisfies:
  1. *Linearity*: $T(a phi + b psi) = a T(phi) + b T(psi)$ for all $phi, psi in cal(D)(Omega)$ and $a, b in bb(R)$.
  2. *Continuity*: If $phi_j -> phi$ in $cal(D)(Omega)$, then $T(phi_j) -> T(phi)$.

  The value of $T$ on a test function $phi$ is denoted by the *duality pairing*:
  $
    ⟨ T, phi ⟩ = T(phi).
  $
] <def:distribution>

#eq[$
  ⟨ T, phi ⟩ = T(phi).
$] <eq:duality-pairing>

The angle bracket notation $⟨ T, phi ⟩$ generalizes the integral $integral f phi dif x$ and emphasizes that $T$ need not be a function.

Many classical functions can be identified with distributions.

#proposition(name: "Regular Distributions")[
  Every locally integrable function $f in L^1_"loc"(Omega)$ defines a distribution $T_f in cal(D)'(Omega)$ via:
  $
    ⟨ T_f, phi ⟩ = integral_Omega f(x) phi(x) dif x, quad phi in cal(D)(Omega).
  $
  The map $f |-> T_f$ is injective: if $T_f = T_g$, then $f = g$ almost everywhere.
] <prop:reg-func-as-distribution>

#proof[
  Linearity of $T_f$ is immediate from the linearity of the integral. For continuity, if $phi_j -> phi$ in $cal(D)(Omega)$, then all $phi_j$ are supported in a common compact set $K$ and $phi_j -> phi$ uniformly. Since $f in L^1(K)$, dominated convergence gives $integral f phi_j dif x -> integral f phi dif x$.

  Injectivity: if $integral (f - g) phi dif x = 0$ for all $phi in cal(D)(Omega)$, then $f = g$ a.e. by the fundamental lemma of the calculus of variations.
]

Distributions arising from locally integrable functions in this way are called *regular distributions*. Those not of this form are called *singular distributions*.

#example(name: "Dirac Delta Distribution")[
  The *Dirac delta* at $a in Omega$ is the distribution $delta_a in cal(D)'(Omega)$ defined by:
  $
    ⟨ delta_a, phi ⟩ = phi(a), quad phi in cal(D)(Omega).
  $
  When $a = 0$, we write $delta$ for $delta_0$. The delta distribution is the prototypical singular distribution.
] <ex:dirac-delta>

#example(name: "Delta Is Not Regular")[
  The Dirac delta $delta$ cannot be represented by any locally integrable function.

  #proof[
    Suppose for contradiction that $delta = T_f$ for some $f in L^1_"loc"(bb(R)^n)$. Then for all $phi in cal(D)(bb(R)^n)$:
    $
      integral_(bb(R)^n) f(x) phi(x) dif x = phi(0).
    $
    Choose a sequence of test functions $phi_j in cal(D)(bb(R)^n)$ with $"supp"(phi_j) subset B(0, 1/j)$, $0 <= phi_j <= 1$, and $phi_j(0) = 1$ (constructed from the bump function in #link(<lem:bump-function>)[§6.1]). Then:
    $
      abs(integral f phi_j dif x) <= integral_(B(0, 1/j)) abs(f(x)) dif x -> 0
    $
    as $j -> oo$, since $f in L^1_"loc"$. But $phi_j(0) = 1$ for all $j$, contradicting $integral f phi_j dif x = phi_j(0) = 1$.
  ]
] <ex:delta-not-regular>

#definition(name: "Support of a Distribution")[
  The *support* of a distribution $T in cal(D)'(Omega)$, denoted $"supp"(T)$, is the complement of the largest open set $U subset Omega$ on which $T$ vanishes, i.e., $⟨ T, phi ⟩ = 0$ for all $phi in cal(D)(U)$.
] <def:support-distribution>

For example, $"supp"(delta_a) = {a}$, and for a regular distribution $T_f$, the support coincides with the essential support of $f$.

#note[
  A key conceptual point: distributions do not have pointwise values in general. The expression "$T(x)$" is not defined for a general distribution. Only operations that can be transferred to test functions — differentiation, multiplication by smooth functions, convolution — are well-defined. This "duality philosophy" is the central principle of distribution theory.
]

== Weak Derivatives // 弱导数

The most important operation on distributions for PDE theory is differentiation. Classical derivatives require pointwise limits, which fail for non-smooth functions. Distribution theory extends differentiation to _all_ distributions by transferring derivatives to test functions via integration by parts.

#definition(name: "Weak Derivative")[
  Let $u in L^1_"loc"(Omega)$ and let $alpha in bb(N)^n$ be a multi-index with $abs(alpha) = 1$. A function $v in L^1_"loc"(Omega)$ is called the *weak derivative of order* $alpha$ *of* $u$ if for all $phi in cal(D)(Omega)$:
  $
    integral_(Omega) v(x) phi(x) dif x = (-1)^(abs(alpha)) integral_(Omega) u(x) partial^alpha phi(x) dif x.
  $
  We write $v = partial^alpha u$ in the weak sense. More generally, for a multi-index $alpha$ with $abs(alpha) >= 1$, the weak derivative $partial^alpha u$ is defined by:
  $
    integral_(Omega) (partial^alpha u) phi dif x = (-1)^(abs(alpha)) integral_(Omega) u (partial^alpha phi) dif x
  $
  for all $phi in cal(D)(Omega)$.
] <def:weak-derivative>

#note[
  The key idea is a complete reversal of perspective: instead of requiring $u$ to be differentiable, we _define_ the derivative of $u$ to be whatever distribution $v$ satisfies the integration-by-parts formula. Since test functions are $C^oo$, the right-hand side $integral u (partial^alpha phi) dif x$ is always well-defined for $u in L^1_"loc"$. The question is whether the resulting linear functional on $cal(D)(Omega)$ is represented by a locally integrable function.
]

#proposition(name: "Uniqueness of Weak Derivatives")[
  If the weak derivative $partial^alpha u$ exists, it is unique up to equality almost everywhere.
] <prop:weak-derivative-unique>

#proof[
  Suppose $v_1, v_2 in L^1_"loc"(Omega)$ both satisfy the weak derivative definition. Then for all $phi in cal(D)(Omega)$:
  $
    integral_(Omega) (v_1 - v_2) phi dif x = 0.
  $
  By the fundamental lemma of the calculus of variations (du Bois-Reymond lemma), $v_1 = v_2$ a.e. in $Omega$.
]

#proposition(name: "Consistency with Classical Derivatives")[
  If $u in C^(abs(alpha))(Omega)$, then the weak derivative $partial^alpha u$ exists and coincides with the classical derivative almost everywhere.
] <prop:weak-classical-consistency>

#proof[
  When $u in C^(abs(alpha))(Omega)$, the classical derivative $partial^alpha u in C(Omega) subset L^1_"loc"(Omega)$. For any $phi in cal(D)(Omega)$, integration by parts gives:
  $
    integral_(Omega) (partial^alpha u) phi dif x = (-1)^(abs(alpha)) integral_(Omega) u (partial^alpha phi) dif x.
  $
  The boundary terms vanish since $phi in cal(D)(Omega)$ has compact support in $Omega$. This is exactly the weak derivative definition, so the classical derivative is also the weak derivative.
]

The following two examples illustrate the power of weak derivatives: functions that are not classically differentiable can still possess weak derivatives.

#example(name: "Weak Derivative of $abs(x)$")[
  Let $u(x) = abs(x)$ on $bb(R)$. This function is not differentiable at $x = 0$ in the classical sense. We claim its weak derivative is the sign function:
  $
    u'(x) = "sign"(x) = cases(1, x > 0, -1, x < 0, 0, x = 0.).
  $

  #proof[
    We must verify that for all $phi in cal(D)(bb(R))$:
    $
      integral_(bb(R)) "sign"(x) phi(x) dif x = -integral_(bb(R)) abs(x) phi'(x) dif x.
    $
    Split the left side at $x = 0$:
    $
      integral_(bb(R)) "sign"(x) phi(x) dif x = -integral_(-oo)^0 phi(x) dif x + integral_0^oo phi(x) dif x.
    $
    On $(0, oo)$, integrate by parts:
    $
      integral_0^oo phi(x) dif x = [x phi(x)]_0^oo - integral_0^oo x phi'(x) dif x = -integral_0^oo x phi'(x) dif x
    $
    since $phi$ has compact support (so $x phi(x) -> 0$ as $x -> oo$) and $0 dot phi(0) = 0$.

    On $(-oo, 0)$, integrate by parts similarly:
    $
      -integral_(-oo)^0 phi(x) dif x = -([x phi(x)]_(-oo)^0 - integral_(-oo)^0 x phi'(x) dif x) = -integral_(-oo)^0 x phi'(x) dif x.
    $
    Adding the two halves:
    $
      integral_(bb(R)) "sign"(x) phi(x) dif x = -integral_(-oo)^0 x phi'(x) dif x - integral_0^oo x phi'(x) dif x = -integral_(bb(R)) abs(x) phi'(x) dif x,
    $
    which is exactly the weak derivative definition.
  ]
] <ex:weak-abs-x>

#example(name: "Weak Derivative of the Heaviside Function")[
  Let $H(x)$ be the Heaviside step function:
  $
    H(x) = cases(1, x > 0, 0, x < 0.).
  $
  The weak derivative of $H$ is the Dirac delta: $H' = delta$ in $cal(D)'(bb(R))$.

  #proof[
    For any $phi in cal(D)(bb(R))$:
    $
      integral_(bb(R)) H(x) phi'(x) dif x = integral_0^oo phi'(x) dif x = -phi(0).
    $
    Therefore:
    $
      -integral_(bb(R)) H(x) phi'(x) dif x = phi(0) = ⟨ delta, phi ⟩.
    $
    By #link(<def:weak-derivative>)[Definition 6.2], $H' = delta$ in the sense of distributions. Note that $delta$ is not a regular distribution (#link(<ex:delta-not-regular>)[Example 6.1]), so $H'$ cannot be represented by any locally integrable function.
  ]
] <ex:weak-heaviside>

#note[
  The Heaviside example is paradigmatic: the weak derivative framework allows us to differentiate discontinuous functions, with the result being a _distribution_ (not necessarily a function). This is impossible in classical analysis. For PDE theory, this means we can seek solutions in distribution spaces, dramatically enlarging the class of admissible solutions. The systematic study of function spaces built on weak derivatives — Sobolev spaces — is developed in Analyse Harmonique and Analyse Fonctionnelle; here we only establish the distribution-theoretic foundation.
]

= Convolution and Fundamental Solutions // 卷积与基本解

== Convolution and Approximation // 卷积与逼近

Convolution with smooth functions provides the primary tool for approximating distributions by smooth functions. This section develops the mollification technique, which is indispensable for PDE theory: it allows us to regularize rough data and construct smooth approximate solutions.

#definition(name: "Convolution of Functions")[
  Let $f in L^1_"loc"(bb(R)^n)$ and $g in cal(D)(bb(R)^n)$. The *convolution* $f * g$ is the function:
  $
    (f * g)(x) = integral_(bb(R)^n) f(y) g(x - y) dif y.
  $
  The integral is well-defined since $g$ has compact support. The result $f * g in C^oo(bb(R)^n)$, with derivatives:
  $
    partial^alpha (f * g) = f * (partial^alpha g).
  $
] <def:conv-function>

For distributions, we extend convolution by duality. If $T in cal(D)'(bb(R)^n)$ and $psi in cal(D)(bb(R)^n)$, the convolution $T * psi$ is defined as a smooth function.

#definition(name: "Convolution of a Distribution with a Test Function")[
  Let $T in cal(D)'(bb(R)^n)$ and $psi in cal(D)(bb(R)^n)$. The *convolution* $T * psi$ is the $C^oo$ function:
  $
    (T * psi)(x) = ⟨ T, psi(x - dot) ⟩,
  $
  where the distribution $T$ acts on the function $y |-> psi(x - y)$. Its derivatives satisfy:
  $
    partial^alpha (T * psi) = T * (partial^alpha psi).
  $
] <def:conv-distribution>

#note[
  The key property is that convolution with a smooth function _smooths_ a distribution: even if $T$ is highly singular (like $delta$), the convolution $T * psi$ is always $C^oo$. This is because the smoothness of $psi(x - y)$ as a function of $x$ transfers to the convolution.
]

#definition(name: "Standard Mollifier")[
  The *standard mollifier* is the function $rho in cal(D)(bb(R)^n)$ defined by:
  $
    rho(x) = cases(c exp(-1 / (1 - abs(x)^2)), abs(x) < 1, 0, abs(x) >= 1.,)
  $
  where $c > 0$ is chosen so that $integral_(bb(R)^n) rho(x) dif x = 1$. For $epsilon > 0$, define the rescaled mollifier:
  $
    rho_epsilon(x) = epsilon^(-n) rho(x / epsilon).
  $
  Then $"supp"(rho_epsilon) = overline(B(0, epsilon))$, $rho_epsilon >= 0$, and $integral rho_epsilon dif x = 1$ for all $epsilon > 0$.
] <def:mollifier>

The family $(rho_epsilon)_(epsilon > 0)$ is an _approximate identity_: as $epsilon -> 0$, the mollifier concentrates at the origin while maintaining unit mass. Convolving with $rho_epsilon$ produces smooth approximations that converge to the original distribution.

#theorem(name: "Mollifier Approximation")[
  Let $T in cal(D)'(bb(R)^n)$ and let $(rho_epsilon)_(epsilon > 0)$ be the standard mollifier family. Then:
  $
    T * rho_epsilon -> T quad text("in") quad cal(D)'(bb(R)^n)  quad text("as") quad epsilon -> 0,
  $
  meaning $⟨ T * rho_epsilon, phi ⟩ -> ⟨ T, phi ⟩$ for all $phi in cal(D)(bb(R)^n)$.

  Moreover, if $T = T_f$ for $f in L^p(bb(R)^n)$ ($1 <= p < oo$), then $f * rho_epsilon -> f$ in $L^p(bb(R)^n)$.
] <thm:mollifier-approx>

#proof[
  *Step 1: Convergence in $cal(D)'(bb(R)^n)$.* For any $phi in cal(D)(bb(R)^n)$:
  $
    ⟨ T * rho_epsilon, phi ⟩ = integral_(bb(R)^n) (T * rho_epsilon)(x) phi(x) dif x.
  $
  By definition of $T * rho_epsilon$:
  $
    ⟨ T * rho_epsilon, phi ⟩ = integral (⟨ T_y, rho_epsilon(x - y) ⟩) phi(x) dif x = ⟨ T_y, integral rho_epsilon(x - y) phi(x) dif x ⟩ = ⟨ T, rho_epsilon * phi ⟩.
  $
  The classical result $rho_epsilon * phi -> phi$ in $cal(D)(bb(R)^n)$ (uniform convergence of all derivatives on compact sets) combined with the continuity of $T$ gives $⟨ T, rho_epsilon * phi ⟩ -> ⟨ T, phi ⟩$.

  *Step 2: $L^p$ convergence.* For $f in L^p$, the $L^p$ convergence $f * rho_epsilon -> f$ follows from Minkowski's integral inequality and the density of $C_c(bb(R)^n)$ in $L^p(bb(R)^n)$.
]

#corollary(name: "Density of Smooth Functions in $cal(D)'$")[
  Every distribution $T in cal(D)'(bb(R)^n)$ is the limit (in $cal(D)'$) of a sequence of $C^oo$ functions. Specifically, $T * rho_(1/j) in C^oo(bb(R)^n)$ and $T * rho_(1/j) -> T$ in $cal(D)'(bb(R)^n)$ as $j -> oo$.
] <cor:smooth-density-D-prime>

This density result is fundamental: it means we can approximate any distribution — no matter how singular — by smooth functions. In PDE theory, this allows us to first solve problems for smooth data and then pass to the limit.

#figure(
  image("img/mollifier-approx.svg", width: 85%),
  caption: [Mollification of the Heaviside function $H(x)$. *Left:* The discontinuous function $H(x)$ (blue) and the mollifier kernel $rho_epsilon(x)$ (red, dashed). *Right:* The convolution $H * rho_epsilon$ (green) is a smooth approximation of $H$; as $epsilon -> 0$, it converges pointwise to $H$ away from the jump.],
  placement: auto,
  supplement: [Fig.]
) <fig:mollifier-approx>

== Fundamental Solutions // 基本解

The concept of a fundamental solution transforms PDE theory: it reduces the problem of solving $P(partial) u = f$ to convolution. Every linear PDE with constant coefficients possesses a fundamental solution in the distributional sense — a fact that is far from obvious and constitutes one of the deepest results in the field.

#definition(name: "Fundamental Solution")[
  Let $P(partial) = sum_(abs(alpha) <= m) a_alpha partial^alpha$ be a linear differential operator with constant coefficients $a_alpha in bb(R)$. A distribution $E in cal(D)'(bb(R)^n)$ is called a *fundamental solution* of $P(partial)$ if:
  $
    P(partial) E = delta quad text("in") quad cal(D)'(bb(R)^n),
  $
  i.e., for all $phi in cal(D)(bb(R)^n)$:
  $
    ⟨ P(partial) E, phi ⟩ = phi(0).
  $
] <def:fundamental-solution>

If $E$ is a fundamental solution, then for any $f in cal(D)(bb(R)^n)$ the convolution $u = E * f$ satisfies $P(partial) u = f$ in the sense of distributions (see #link(<def:conv-distribution>)[Definition 7.1]). This reduces solving a PDE to computing a convolution — provided the fundamental solution is known.

The fundamental solution is not unique: if $E_1$ and $E_2$ are both fundamental solutions, then $P(partial)(E_1 - E_2) = 0$, so $E_1 - E_2$ solves the homogeneous equation. This freedom is exploited in applications by selecting the fundamental solution with the most convenient properties (causal, retarded, advanced, etc.).

#theorem(name: "Malgrange–Ehrenpreis Theorem")[
  Every linear differential operator $P(partial)$ with constant coefficients (not identically zero) possesses a fundamental solution $E in cal(D)'(bb(R)^n)$.
] <thm:malgrange-ehrenpreis>

This is a deep existence theorem; we omit the general proof (which requires tools from Fourier analysis on $cal(S)'$, treated in Analyse Harmonique). Instead, we verify it concretely by constructing fundamental solutions for the three central operators of PDE theory.

#example(name: "Fundamental Solution of the Laplace Operator")[
  For the Laplace operator $Delta = sum_(i=1)^n partial_(x_i)^2$, the fundamental solution is:

  For $n >= 3$:
  $
    E(x) = -1 / ((n - 2) omega_n) abs(x)^(2 - n),
  $
  where $omega_n = 2 pi^(n/2) / Gamma(n/2)$ is the surface area of the unit sphere $S^(n-1) subset bb(R)^n$.

  For $n = 2$:
  $
    E(x) = 1 / (2 pi) log abs(x).
  $
  In both cases, $Delta E = delta$ in $cal(D)'(bb(R)^n)$. The function $abs(x)^(2-n)$ (for $n >= 3$) is called the *Newtonian potential*.

  #proof[
    We treat $n >= 3$; the $n = 2$ case is analogous. Away from the origin, $E in C^oo$ and a direct computation shows $Delta abs(x)^(2-n) = 0$ for $x != 0$.

    For $phi in cal(D)(bb(R)^n)$, we evaluate $⟨ Delta E, phi ⟩ = ⟨ E, Delta phi ⟩$ by excising a small ball. Since $abs(x)^(2-n) in L^1_"loc"(bb(R)^n)$:
    $
      ⟨ E, Delta phi ⟩ = lim_(epsilon -> 0) (-1) / ((n - 2) omega_n) integral_(abs(x) > epsilon) abs(x)^(2 - n) Delta phi(x) dif x.
    $
    By Green's second identity on $Omega_epsilon = {x : abs(x) > epsilon}$:
    $
      integral_(Omega_epsilon) (abs(x)^(2 - n) Delta phi - phi Delta(abs(x)^(2 - n))) dif x = integral_(partial B(0, epsilon)) (abs(x)^(2 - n) (partial phi) / (partial nu) - phi (partial(abs(x)^(2 - n))) / (partial nu)) dif S(x),
    $
    where $nu$ is the _inward_ unit normal to $partial B(0, epsilon)$ (inward with respect to $Omega_epsilon$). Since $Delta abs(x)^(2-n) = 0$ in $Omega_epsilon$, the left side reduces to $integral_(Omega_epsilon) abs(x)^(2-n) Delta phi dif x$.

    On $partial B(0, epsilon)$: $abs(x)^(2-n) = epsilon^(2-n)$, and $(partial abs(x)^(2-n)) / (partial nu) = -(d / (dif r)) r^(2-n) |_(r = epsilon) = (n - 2) epsilon^(1 - n)$. Therefore:
    $
      integral_(partial B(0, epsilon)) (partial(abs(x)^(2 - n))) / (partial nu) phi dif S = (n - 2) epsilon^(1 - n) integral_(partial B(0, epsilon)) phi dif S -> (n - 2) epsilon^(1 - n) dot omega_n epsilon^(n - 1) phi(0) = (n - 2) omega_n phi(0)
    $
    as $epsilon -> 0$, using the mean value property of integrals over spheres. The other boundary term satisfies:
    $
      epsilon^(2 - n) integral_(partial B(0, epsilon)) (partial phi) / (partial nu) dif S -> 0
    $
    since $"supp"(phi)$ is bounded and $partial phi / partial nu$ is bounded.

    Combining:
    $
      ⟨ Delta E, phi ⟩ = (-1) / ((n - 2) omega_n) dot (-(n - 2) omega_n phi(0)) = phi(0).
    $
    Hence $Delta E = delta$.

    For $n = 2$: $E(x) = (1 / (2 pi)) log abs(x)$. The proof is analogous: $Delta log abs(x) = 0$ for $x != 0$, and the boundary integral on $partial B(0, epsilon)$ gives $(d / (dif r)) log r |_(r = epsilon) = 1 / epsilon$, so $integral_(partial B(0, epsilon)) (1 / epsilon) phi dif S -> 2 pi phi(0)$, yielding $⟨ Delta E, phi ⟩ = (1 / (2 pi)) dot 2 pi phi(0) = phi(0)$.
  ]
] <ex:fund-laplace>

#example(name: "Fundamental Solution of the Heat Operator")[
  For the heat operator $partial_t - Delta_x$ on $bb(R)^(1+n)$ with coordinates $(t, x) in bb(R) times bb(R)^n$, the fundamental solution is the *heat kernel*:
  $
    E(t, x) = cases(1 / (4 pi t)^(n/2) exp(-abs(x)^2 / (4 t)), t > 0, 0, t < 0.)
  $
  Then $(partial_t - Delta_x) E = delta$ in $cal(D)'(bb(R)^(1+n))$, where $delta = delta_(0, 0)$ is the delta at the origin of spacetime.

  #proof[
    For $t > 0$, $E in C^oo$ and satisfies the classical heat equation $(partial_t - Delta_x) E = 0$ (direct verification by computing partial derivatives of the Gaussian). For $t < 0$, $E = 0$.

    For $phi in cal(D)(bb(R)^(1+n))$:
    $
      ⟨ (partial_t - Delta) E, phi ⟩ = -⟨ E, (partial_t + Delta) phi ⟩ = -integral_0^oo integral_(bb(R)^n) E(t, x) ((partial_t + Delta_x) phi)(t, x) dif x dif t.
    $
    Since $E$ is smooth for $t > 0$ and decays rapidly in $x$, we integrate by parts in $t$ over $(0, oo)$:
    $
      -integral_0^oo integral E (partial_t phi) dif x dif t = integral_0^oo integral (partial_t E) phi dif x dif t + integral_(bb(R)^n) E(0^+, x) phi(0, x) dif x.
    $
    The spatial integration by parts gives $-integral E Delta phi dif x dif t = integral (Delta E) phi dif x dif t$ (boundary terms in $x$ vanish by rapid decay). Since $partial_t E = Delta E$ for $t > 0$, the volume integrals cancel, leaving:
    $
      ⟨ (partial_t - Delta) E, phi ⟩ = integral_(bb(R)^n) E(0^+, x) phi(0, x) dif x.
    $
    As $t -> 0^+$, the heat kernel $E(t, dot) -> delta$ in $cal(D)'(bb(R)^n)$ (it is an approximate identity: $E >= 0$, $integral E dif x = 1$ for all $t > 0$, and $"supp"(E(t, dot))$ concentrates at the origin). Therefore:
    $
      integral_(bb(R)^n) E(0^+, x) phi(0, x) dif x = phi(0, 0).
    $
    Hence $(partial_t - Delta) E = delta_(0,0)$.
  ]
] <ex:fund-heat>

#example(name: "Fundamental Solution of the Wave Operator")[
  For the wave operator $square = partial_t^2 - Delta_x$ on $bb(R)^(1+n)$, the fundamental solution depends on the spatial dimension in a qualitatively different way.

  For $n = 1$:
  $
    E(t, x) = 1/2 H(t) H(t^2 - x^2) = cases(1/2, t > abs(x), 0, t < abs(x).),
  $
  where $H$ is the Heaviside function (#link(<ex:weak-heaviside>)[Example 6.2]). The support of $E$ is the forward light cone ${(t, x) : t >= abs(x)}$.

  For $n = 3$:
  $
    E(t, x) = 1 / (4 pi t) delta(t - abs(x)) H(t),
  $
  supported on the _surface_ of the forward light cone.

  For general odd $n >= 3$, $E$ involves the derivative $partial_t^((n-3)/2)$ of a distribution supported on the light cone. For general even $n >= 2$, $E$ is supported on the _entire interior_ of the forward light cone.

  We verify $square E = delta$ for $n = 1$ in detail, as the key mechanism already appears in this simplest case.

  #proof[
    For $n = 1$, $E(t, x) = (1/2) H(t - abs(x))$. For $phi in cal(D)(bb(R)^2)$:
    $
      ⟨ square E, phi ⟩ = ⟨ E, square phi ⟩ = 1/2 integral_0^oo (integral_(-t)^t (partial_t^2 phi - partial_x^2 phi) dif x) dif t.
    $

    *Step 1: The $partial_t^2$ integral.* For fixed $t > 0$, integrate in $t$ over $(0, oo)$ by parts. On each half-line:
    $
      integral_0^oo integral_x^oo partial_t^2 phi dif t dif x = -integral_0^oo partial_t phi(x, x) dif x
    $
    (since $phi$ has compact support, $partial_t phi(x, t) -> 0$ as $t -> oo$). Similarly:
    $
      integral_0^oo integral_(-oo)^(-x) partial_t^2 phi dif t dif x = -integral_(-oo)^0 partial_t phi(-x, -x) dif x.
    $
    Substituting $x -> -x$ in the second integral:
    $
      integral_0^oo integral_(-t)^t partial_t^2 phi dif x dif t = -integral_0^oo partial_t phi(x, x) dif x - integral_0^oo partial_t phi(x, -x) dif x.
    $

    *Step 2: The $partial_x^2$ integral.* For fixed $t$:
    $
      integral_(-t)^t partial_x^2 phi dif x = partial_x phi(t, t) - partial_x phi(t, -t).
    $
    So:
    $
      integral_0^oo integral_(-t)^t partial_x^2 phi dif x dif t = integral_0^oo partial_x phi(t, t) dif t - integral_0^oo partial_x phi(t, -t) dif t.
    $

    *Step 3: Combining.* Let $A = integral_0^oo partial_t phi(x, x) dif x$ and $B = integral_0^oo partial_x phi(x, x) dif x$. Since $(d / (dif x)) phi(x, x) = partial_x phi(x, x) + partial_t phi(x, x)$:
    $
      A + B = integral_0^oo (d / (dif x)) phi(x, x) dif x = phi(oo, oo) - phi(0, 0) = -phi(0, 0).
    $
    Similarly, let $C = integral_0^oo partial_t phi(x, -x) dif x$ and $D = integral_0^oo partial_x phi(x, -x) dif x$. Since $(d / (dif x)) phi(x, -x) = partial_x phi(x, -x) - partial_t phi(x, -x)$:
    $
      D - C = integral_0^oo (d / (dif x)) phi(x, -x) dif x = phi(oo, -oo) - phi(0, 0) = -phi(0, 0).
    $

    From Steps 1 and 2:
    $
      2 ⟨ square E, phi ⟩ = -(A + C) - (B - D) = -(A + B) - (C - D) = phi(0, 0) + phi(0, 0) = 2 phi(0, 0).
    $
    Hence $⟨ square E, phi ⟩ = phi(0, 0)$, i.e., $square E = delta_(0, 0)$.
  ]
] <ex:fund-wave>

#note[
  The three fundamental solutions reveal fundamentally different propagation behaviors, reflecting the classification of Chapter 2:

  - *Laplace* ($Delta$): $E$ is supported on _all_ of $bb(R)^n$ — elliptic equations have infinite propagation in all directions; disturbances are felt everywhere instantaneously.
  - *Heat* ($partial_t - Delta$): $E$ is supported on ${t >= 0}$ — parabolic equations have infinite spatial propagation speed but respect the arrow of time (irreversibility).
  - *Wave* ($partial_t^2 - Delta$): $E$ is supported on the forward light cone ${t >= abs(x)}$ — hyperbolic equations respect finite propagation speed and causality.

  Moreover, the wave fundamental solution reveals a striking dimensional dichotomy: for odd $n$, $E$ is supported on the _surface_ of the light cone (sharp signals — the *strong Huygens' principle*); for even $n$, $E$ fills the _interior_ (after-effects — the *weak Huygens' principle*). This is explored in detail in Chapter 15.
]

// ==========================================================================
// Part IV — Elliptic Equations (椭圆型方程)
// ==========================================================================
// 设计思路：从 Laplace 方程的经典理论出发，逐步过渡到
// 一般椭圆方程的弱解理论和正则性。
// 弱形式与 Sobolev 空间的深层理论参见 Analyse Harmonique 和
// Analyse Fonctionnelle；本笔记仅在 Ch 11 简述 W^{k,p} 基本性质。
// 与 Analyse Complexe 的边界：复分析笔记从全纯函数角度处理调和函数；
// 本笔记从 PDE 角度（弱解、正则性）。

// --- Chapter 8: Laplace's Equation and Harmonic Functions (拉普拉斯方程与调和函数) ---

//   Section 8.1: Laplace's and Poisson's Equations (拉普拉斯方程与泊松方程)
//     - 方程的导出与物理背景
//     - 基本性质

//   Section 8.2: Mean Value Property (平均值性质)
//     - 球面平均值与球体平均值
//     - 逆命题

//   Section 8.3: Maximum and Minimum Principles (最大值与最小值原理)
//     - 弱最大值原理
//     - 强最大值原理
//     - Hopf 引理

//   Section 8.4: Green's Identities (格林恒等式)
//     - 第一与第二格林恒等式
//     - 在唯一性证明中的应用

// --- Chapter 9: Boundary Value Problems for Elliptic Equations (椭圆型方程边值问题) ---

//   Section 9.1: Dirichlet Problem (狄利克雷问题)
//     - 弱形式与 Lax-Milgram 应用
//     - 存在性与唯一性

//   Section 9.2: Neumann Problem (纽曼问题)
//     - 弱形式
//     - 相容性条件

//   Section 9.3: Robin and Mixed Conditions (Robin 与混合边界条件)
//     - Robin 边界条件的弱形式
//     - 混合边界条件的处理

//   Section 9.4: Uniqueness via Energy Methods (能量方法的唯一性)
//     - 能量积分方法
//     - 与最大值原理的互补

// --- Chapter 10: Green Functions and Representation (格林函数与表示) ---
// 设计思路：基本解已在 Ch 7 统一构造（去重，不再重复 Newton 位势）。

//   Section 10.1: Green's Function Construction (格林函数的构造)
//     - 有界区域上的 Green 函数
//     - 镜像法

//   Section 10.2: Representation Formulas (表示公式)
//     - 用 Green 函数表示解
//     - Poisson 积分公式

//   Section 10.3: Method of Images and Conformal Mapping (镜像法与保角映射)
//     - 特殊区域的 Green 函数
//     - 与复分析方法的联系（参见 Analyse Complexe）

// --- Chapter 11: Regularity Theory (正则性理论) ---
// 设计思路：Sobolev 空间的定义与基本性质在此简述（支撑弱解与 W^{k,p} 估计）；
// 嵌入定理等深层理论参见 Analyse Harmonique。

//   Section 11.1: Interior Regularity (内正则性)
//     - W^{2,p} 内估计
//     - 椭圆正则性定理

//   Section 11.2: Boundary Regularity (边界正则性)
//     - 边界附近的正则性
//     - 区域光滑性的要求

//   Section 11.3: Schauder Estimates (Schauder 估计)
//     - Hölder 空间中的估计
//     - Schauder 定理

//   Section 11.4: L^p Estimates and Calderón-Zygmund Theory (L^p 估计与 Calderón-Zygmund 理论)
//     - Calderón-Zygmund 奇异积分
//     - L^p 正则性

#part("Elliptic Equations") // 椭圆型方程

= Laplace's Equation and Harmonic Functions // 拉普拉斯方程与调和函数

The Laplace equation, introduced in Chapter 1 (#link(<def:laplace-equation>)[Ch 1]), is the prototypical elliptic equation. Its solutions — the *harmonic functions* — form the smoothest and most rigid class of objects in PDE theory: they are $C^oo$ wherever defined, enjoy the mean value property and the maximum principle, and their theory provides the blueprint for the general elliptic theory developed in this Part.

== Laplace's and Poisson's Equations // 拉普拉斯方程与泊松方程

#definition(name: "Laplace and Poisson Equations")[
  Let $Omega subset bb(R)^n$ be an open set. The *Laplace equation* is
  $
    Delta u = 0 quad "in" quad Omega,
  $
  and the *Poisson equation* is
  $
    -Delta u = f quad "in" quad Omega,
  $
  where $u: Omega -> bb(R)$ is the unknown function and $f: Omega -> bb(R)$ is given. A $C^2$ function $u$ satisfying $Delta u = 0$ is called a *harmonic function* on $Omega$.
] <def:harmonic-function>

#note[
  Physical origins. The Laplacian measures the local deviation of $u$ from its mean, so $Delta u = 0$ describes equilibrium configurations: the electrostatic potential in a charge-free region, the gravitational potential in empty space, and the steady-state temperature distribution. The Poisson equation $-Delta u = f$ incorporates sources (charge density, heat sources).

  Linearity and ellipticity. Both equations are linear with constant coefficients, so linear combinations of solutions are again solutions (Chapter 1, #link(<def:pde-linearity-classification>)[§1]). By the classification of Chapter 2, $Delta$ is the canonical *elliptic* operator: its principal symbol $abs(xi)^2$ is positive definite, and no characteristic surfaces exist in $bb(R)^n$.
]

#proposition(name: "Invariance Properties of the Laplacian")[
  The Laplacian commutes with rigid motions: for $T_a (x) = x + a$ and any orthogonal matrix $Q$,
  $
    Delta (u compose T_a) = (Delta u) compose T_a, quad Delta (u compose Q) = (Delta u) compose Q.
  $
  Hence harmonicity is invariant under translations, rotations, and reflections. Moreover, $u$ is harmonic on $Omega$ if and only if $v (x) = u (lambda x)$ is harmonic on $lambda^(-1) Omega$ for every $lambda > 0$; indeed $Delta v = lambda^2 (Delta u) compose (x |-> lambda x)$.
] <prop:laplacian-invariance>

#proof[
  These are direct chain-rule computations. For example, if $v (x) = u (Q x)$, then $partial_(x_i) v = sum_j Q_(j i) (partial_(x_j) u) compose (Q dot)$ and, since $Q Q^T = I$,
  $
    Delta v = sum_i sum_(j, k) Q_(j i) Q_(k i) (partial_(x_j) partial_(x_k) u) compose (Q dot) = sum_j (partial_(x_j)^2 u) compose (Q dot) = (Delta u) compose (Q dot).
  $
]

== Mean Value Property // 平均值性质

The mean value property is the fundamental structural feature of harmonic functions: the value at a point is the average over any sphere or ball centered at that point. It encodes the rigidity of harmonic functions (no interior extrema unless constant) and, through its converse, their smoothness.

#theorem(name: "Mean Value Property")[
  Let $u in C^2 (Omega)$ be harmonic. Then for every $x in Omega$ and every $r > 0$ with $overline(B (x, r)) subset Omega$,
  $
    u (x) = 1 / (omega_n r^(n-1)) integral_(partial B (x, r)) u dif S = 1 / (abs(B (x, r))) integral_(B (x, r)) u dif y,
  $
  where $omega_n$ is the surface area of the unit sphere $S^(n-1) subset bb(R)^n$ and $abs(B (x, r)) = omega_n r^n / n$ is the volume of the ball.
] <thm:mean-value-property>

#proof[
  Define $phi: (0, R) -> bb(R)$ by the spherical average
  $
    phi (r) = 1 / (omega_n r^(n-1)) integral_(partial B (x, r)) u dif S = 1 / (omega_n) integral_(S^(n-1)) u (x + r z) dif S (z).
  $
  Differentiating under the integral and using the divergence theorem:
  $
    phi' (r) = 1 / (omega_n r^(n-1)) integral_(partial B (x, r)) (partial u)/(partial nu) dif S = 1 / (omega_n r^(n-1)) integral_(B (x, r)) Delta u dif y = 0,
  $
  since $u$ is harmonic. Hence $phi$ is constant, and $phi (r) = lim_(s -> 0^+) phi (s) = u (x)$ by continuity. Integrating the spherical averages over $0 < s < r$ gives the ball average:
  $
    integral_(B (x, r)) u dif y = integral_0^r integral_(partial B (x, s)) u dif S dif s = u (x) integral_0^r omega_n s^(n-1) dif s = u (x) (omega_n r^n)/n.
  $
]

#corollary(name: "Derivative Estimates")[
  Let $u$ be harmonic in $Omega$. For every multi-index $alpha$ and every $B (x, r) subset Omega$,
  $
    abs(D^alpha u (x)) <= C_(n, k) / r^k sup_(B (x, r)) abs(u), quad k = abs(alpha),
  $
  where $C_(n, k)$ depends only on $n$ and $k$. In particular, harmonic functions are $C^oo$, and the derivatives at $x$ are controlled by the supremum of $u$ on any ball around $x$.
] <cor:derivative-estimates>

#proof[
  For $k = 1$, differentiate the ball mean value property with respect to the center (legitimate by translation invariance: $integral_(B (x, r)) u dif y = integral_(B (0, r)) u (x + z) dif z$):
  $
    (partial u)/(partial x_i) (x) = 1 / (abs(B (x, r))) integral_(B (x, r)) (partial u)/(partial x_i) dif y = 1 / (abs(B (x, r))) integral_(partial B (x, r)) u nu_i dif S,
  $
  where the last step is the divergence theorem applied to the (harmonic) function $partial_(x_i) u$. Hence
  $
    abs(nabla u (x)) <= (n / r) sup_(partial B (x, r)) abs(u) <= (n / r) sup_(B (x, r)) abs(u).
  $
  Replacing $r$ by $r/2$ (so that the final ball lies inside $B (x, r)$) and applying the $k = 1$ estimate to the derivatives $partial^alpha u$, which are harmonic whenever $u$ is, gives the general case by induction on $k$.
]

#corollary(name: "Converse: Mean Value Property Implies Harmonicity")[
  Let $u in C (Omega)$ satisfy the (ball) mean value property: for every $x in Omega$ and every $r > 0$ with $overline(B (x, r)) subset Omega$,
  $
    u (x) = 1 / (abs(B (x, r))) integral_(B (x, r)) u dif y.
  $
  Then $u in C^oo (Omega)$ and $u$ is harmonic.
] <cor:mean-value-converse>

#proof[
  Let $rho_epsilon$ be the standard mollifier (Chapter 7, #link(<def:mollifier>)[§7.1]) and set $u_epsilon = u * rho_epsilon$ on $Omega_epsilon = {x in Omega : "dist"(x, partial Omega) > epsilon}$. Since mollification averages $u$ against a smooth kernel, the mean value property passes to $u_epsilon$: for $B (x, r) subset Omega_epsilon$,
  $
    u_epsilon (x) = 1 / (abs(B (x, r))) integral_(B (x, r)) u_epsilon dif y.
  $
  For fixed $x$, the spherical average of $u_epsilon$ over $partial B (x, r)$ is therefore constant in $r$, so its derivative vanishes; by the divergence theorem,
  $
    integral_(B (x, r)) Delta u_epsilon dif y = integral_(partial B (x, r)) (partial u_epsilon)/(partial nu) dif S = 0
  $
  for every $r$. Dividing by $abs(B (x, r)) = omega_n r^n / n$ and letting $r -> 0^+$, the continuity of $Delta u_epsilon$ gives $Delta u_epsilon (x) = 0$. Thus each $u_epsilon$ is harmonic on $Omega_epsilon$.

  Now $u_epsilon -> u$ locally uniformly on $Omega$ (Chapter 7). By the derivative estimates above, $D^alpha u_epsilon$ converges locally uniformly to a continuous function, and $Delta u = lim_(epsilon -> 0) Delta u_epsilon = 0$. Hence $u in C^oo (Omega)$ and $u$ is harmonic.
]

== Maximum and Minimum Principles // 最大值与最小值原理

#theorem(name: "Weak Maximum Principle")[
  Let $Omega$ be bounded and $u in C^2 (Omega) inter C (overline(Omega))$ with $Delta u >= 0$ in $Omega$ (such $u$ is called *subharmonic*). Then
  $
    max_(overline(Omega)) u = max_(partial Omega) u.
  $
  In particular, a harmonic function attains its maximum on the boundary. For $Delta u <= 0$ (*superharmonic* $u$), the same holds with minima: $min_(overline(Omega)) u = min_(partial Omega) u$.
] <thm:weak-maximum-principle>

#proof[
  First suppose $Delta u > 0$ strictly. If $u$ attained an interior maximum at $x_0 in Omega$, the second-derivative test gives $Delta u (x_0) = sum_i (partial^2 u)/(partial x_i^2) (x_0) <= 0$ (each second derivative at a maximum is non-positive), a contradiction. Hence the maximum is attained on the boundary. For the general case $Delta u >= 0$, apply the strict case to $u_epsilon (x) = u (x) + epsilon abs(x)^2$, for which $Delta u_epsilon = Delta u + 2 n epsilon > 0$, and let $epsilon -> 0^+$.
]

#theorem(name: "Strong Maximum Principle")[
  Let $Omega$ be connected and $u in C^2 (Omega) inter C (overline(Omega))$ be subharmonic ($Delta u >= 0$). If $u$ attains its maximum at an interior point of $Omega$, then $u$ is constant on $Omega$. Consequently, a non-constant harmonic function attains neither a maximum nor a minimum in the interior.
] <thm:strong-maximum-principle>

#proof[
  Let $x_0 in Omega$ be a maximum point and set $M = u (x_0)$. For $0 < r < "dist"(x_0, partial Omega)$, the spherical average $phi (r)$ of $u$ over $partial B (x_0, r)$ satisfies
  $
    phi' (r) = 1 / (omega_n r^(n-1)) integral_(partial B (x_0, r)) (partial u)/(partial nu) dif S = 1 / (omega_n r^(n-1)) integral_(B (x_0, r)) Delta u dif y >= 0,
  $
  so $phi$ is non-decreasing and $phi (r) >= lim_(s -> 0^+) phi (s) = u (x_0) = M$. But $u <= M$ on $partial B (x_0, r)$, hence $phi (r) <= M$; therefore $phi (r) = M$ and, since the integrand is continuous and its average attains the maximum, $u = M$ on $partial B (x_0, r)$ for every such $r$. Thus $u = M$ on $B (x_0, "dist"(x_0, partial Omega))$, so the set ${x in Omega : u (x) = M}$ is open; it is relatively closed by continuity, and by connectedness of $Omega$ it is all of $Omega$.
]

#theorem(name: "Hopf's Lemma")[
  Let $Omega$ be a bounded domain with $C^2$ boundary and $u in C^2 (overline(Omega))$ with $Delta u >= 0$ in $Omega$. Suppose $x_0 in partial Omega$ satisfies $u (x_0) > u (x)$ for all $x in Omega$ (a strict boundary maximum, with the maximum over $overline(Omega)$ attained at $x_0$). Then
  $
    (partial u)/(partial nu) (x_0) > 0,
  $
  where $nu$ is the outward unit normal. (For $Delta u <= 0$ and an interior minimum the inequality is reversed.)
] <thm:hopf-lemma>

#note[
  Hopf's lemma is proved by constructing a suitable *barrier*: near $x_0$, take a ball internally tangent to $partial Omega$ at $x_0$ and compare $u$ with a carefully chosen function of $r = abs(x - x_c)$, which is subharmonic and vanishes appropriately on the boundary of the ball. The strict inequality $partial u / partial nu > 0$ is the quantitative form of the strong maximum principle at the boundary; it is the key input for uniqueness and boundary estimates in Chapters 9–11.
]

#corollary(name: "Uniqueness for the Dirichlet Problem")[
  If $u, v in C^2 (Omega) inter C (overline(Omega))$ are harmonic in the bounded domain $Omega$ and agree on $partial Omega$, then $u = v$ in $Omega$.
] <cor:dirichlet-uniqueness>

#proof[
  The difference $w = u - v$ is harmonic and vanishes on $partial Omega$. By the weak maximum principle applied to $w$ and to $-w$, $max_(overline(Omega)) w = 0$ and $min_(overline(Omega)) w = 0$, so $w = 0$ everywhere.
]

== Green's Identities // 格林恒等式

#proposition(name: "Green's Identities")[
  Let $Omega subset bb(R)^n$ be a bounded domain with $C^1$ boundary and let $u, v in C^2 (overline(Omega))$. With $nu$ the outward unit normal,
  $
    integral_Omega nabla u dot nabla v dif x = integral_(partial Omega) v (partial u)/(partial nu) dif S - integral_Omega v Delta u dif x,
  $
  and, subtracting the first identity with $u$ and $v$ interchanged,
  $
    integral_Omega (u Delta v - v Delta u) dif x = integral_(partial Omega) (u (partial v)/(partial nu) - v (partial u)/(partial nu)) dif S.
  $
] <prop:green-identities>

#proof[
  Both identities follow from the divergence theorem $integral_Omega "div" bold(F) dif x = integral_(partial Omega) bold(F) dot nu dif S$. For the first, take $bold(F) = v nabla u$; then $"div"(bold(F)) = nabla v dot nabla u + v Delta u$.
]

#example(name: "Uniqueness for the Neumann Problem")[
  Let $u_1, u_2 in C^2 (overline(Omega))$ satisfy $Delta u_1 = Delta u_2 = 0$ in $Omega$ and $(partial u_1)/(partial nu) = (partial u_2)/(partial nu)$ on $partial Omega$. Then $w = u_1 - u_2$ is harmonic with zero normal derivative on the boundary. The first Green identity with $v = w$ gives
  $
    integral_Omega abs(nabla w)^2 dif x = integral_(partial Omega) w (partial w)/(partial nu) dif S - integral_Omega w Delta w dif x = 0,
  $
  so $nabla w = 0$ in $Omega$, and $w$ is constant. Thus solutions of the Neumann problem are unique up to an additive constant (Chapter 9, §9.2).
]

#example(name: "The Compatibility Condition")[
  Taking $u = 1$ in the second Green identity shows that a solution of the Neumann problem $Delta u = f$ in $Omega$, $(partial u)/(partial nu) = g$ on $partial Omega$ must satisfy
  $
    integral_Omega f dif x = integral_(partial Omega) g dif S,
  $
  a necessary condition for existence (Chapter 9, §9.2). The first Green identity with $v = 1$ gives the same conclusion directly.
]

= Boundary Value Problems for Elliptic Equations // 椭圆型方程边值问题

The maximum principle and Green's identities of Chapter 8 give the classical (strong) theory. Modern PDE theory works with *weak solutions* in Sobolev spaces, where existence follows from the Lax--Milgram theorem. This chapter develops the Dirichlet, Neumann, and Robin problems in the weak framework; the abstract Hilbert-space theory is that of Analyse Fonctionnelle, and we apply it here.

== Dirichlet Problem // 狄利克雷问题

#definition(name: "The Dirichlet Problem")[
  Let $Omega subset bb(R)^n$ be a bounded domain and $f: Omega -> bb(R)$, $g: partial Omega -> bb(R)$ given functions. The *Dirichlet problem* is to find $u$ such that
  $
    -Delta u = f quad "in" quad Omega, quad u = g quad "on" quad partial Omega.
  $
  A classical solution is a function $u in C^2 (Omega) inter C (overline(Omega))$ satisfying the equation pointwise; a weak solution is defined below.
] <def:dirichlet-problem>

#definition(name: "Sobolev Space $H^1 (Omega)$")[
  The space $H^1 (Omega) = W^(1,2) (Omega)$ consists of all $u in L^2 (Omega)$ whose first-order weak derivatives (Chapter 6, #link(<def:weak-derivative>)[§6.2]) belong to $L^2 (Omega)$, with the norm
  $
    ||u||_(H^1) = (integral_Omega (abs(u)^2 + abs(nabla u)^2) dif x)^(1/2).
  $
  The subspace $H_0^1 (Omega)$ is the closure of $C_c^oo (Omega)$ in $H^1 (Omega)$; equivalently, it consists of the functions that vanish on $partial Omega$ in the trace sense. The abstract theory of $H^1$ — completeness and embeddings — is developed in Analyse Harmonique; here we need only completeness and Poincaré's inequality below.
] <def:sobolev-h1>

#proposition(name: "Poincaré's Inequality")[
  Let $Omega subset bb(R)^n$ be a bounded domain. There exists a constant $C = C (Omega)$ such that for every $u in H_0^1 (Omega)$,
  $
    integral_Omega abs(u)^2 dif x <= C integral_Omega abs(nabla u)^2 dif x.
  $
  Consequently, $||nabla u||_(L^2)$ is an equivalent norm on $H_0^1 (Omega)$.
] <prop:poincare-inequality>

#proof[
  For a bounded box containing $Omega$, write $u (x) = integral_(-oo)^(x_1) (partial u)/(partial x_1) (t, x_2, dots, x_n) dif t$ for $u in C_c^oo$ (extended by zero), square and integrate; the one-dimensional Poincaré inequality gives the bound with a constant depending on the side length. The result for general $u in H_0^1$ follows by density of $C_c^oo$ in $H_0^1$.
]

#theorem(name: "Lax--Milgram Theorem")[
  Let $H$ be a Hilbert space and $B: H times H -> bb(R)$ a bilinear form that is *bounded* and *coercive*: there exist constants $alpha, beta > 0$ such that
  $
    abs(B (u, v)) <= beta ||u|| ||v||, quad B (u, u) >= alpha ||u||^2 quad "for all" u, v in H.
  $
  Then for every bounded linear functional $F: H -> bb(R)$ there exists a unique $u in H$ with
  $
    B (u, v) = F (v) quad "for all" v in H.
  $
  (The abstract proof — Riesz representation and the contraction mapping argument — is given in Analyse Fonctionnelle; we apply the theorem here.)
] <thm:lax-milgram>

#definition(name: "Weak Solution of the Dirichlet Problem")[
  Let $f in L^2 (Omega)$ and $g in H^1 (Omega)$. A function $u in H^1 (Omega)$ with $u - g in H_0^1 (Omega)$ is a *weak solution* of the Dirichlet problem if
  $
    integral_Omega nabla u dot nabla v dif x = integral_Omega f v dif x quad "for all" v in H_0^1 (Omega).
  $
  The boundary condition $u = g$ on $partial Omega$ is understood in the trace sense (for $g in H^1 (Omega)$).
] <def:weak-dirichlet>

#theorem(name: "Existence and Uniqueness for the Dirichlet Problem")[
  Let $Omega subset bb(R)^n$ be a bounded domain and $f in L^2 (Omega)$. For every $g in H^1 (Omega)$ the weak Dirichlet problem has a unique solution $u in H^1 (Omega)$, and
  $
    ||u||_(H^1) <= C (||f||_(L^2) + ||g||_(H^1))
  $
  for a constant $C = C (Omega)$.
] <thm:dirichlet-existence>

#proof[
  *Step 1: Reduce to homogeneous data.* Let $w = u - g$. Then $w in H_0^1 (Omega)$ and $w$ solves the weak problem with right-hand side
  $
    F (v) = integral_Omega f v dif x - integral_Omega nabla g dot nabla v dif x,
  $
  which is a bounded linear functional on $H_0^1 (Omega)$ (by Cauchy--Schwarz and Poincaré's inequality).

  *Step 2: Apply Lax--Milgram.* On $H = H_0^1 (Omega)$ equip the inner product $⟨ u, v ⟩ = integral_Omega nabla u dot nabla v dif x$. The form $B (u, v) = ⟨ u, v ⟩$ is bounded ($abs(B (u, v)) <= ||nabla u||_(L^2) ||nabla v||_(L^2)$) and coercive: by Poincaré's inequality $||u||_(L^2) <= C^(1/2) ||nabla u||_(L^2)$, so
  $
    B (u, u) = ||nabla u||_(L^2)^2 >= 1/(1 + C) ||u||_(H^1)^2.
  $
  Lax--Milgram yields a unique $w$, hence a unique $u = w + g$.

  *Step 3: Estimate.* Applying the bound $||w||_(H^1) <= (1/alpha) ||F||$ and the explicit bound on $F$ gives the stated estimate for $u$.
]

#note[
  The classical and weak formulations are consistent: if $u in C^2 (Omega) inter C^1 (overline(Omega))$ is a weak solution with $f$ continuous, then integrating by parts in the weak formulation shows $Delta u = f$ pointwise, so $u$ is a classical solution. Regularity theory (Chapter 11) shows that weak solutions are automatically classical under mild smoothness assumptions on the data.
]

== Neumann Problem // 纽曼问题

#definition(name: "The Neumann Problem")[
  Let $Omega subset bb(R)^n$ be a bounded domain with Lipschitz boundary and let $f in L^2 (Omega)$, $g in L^2 (partial Omega)$ be given. The *Neumann problem* is to find $u in H^1 (Omega)$ such that
  $
    integral_Omega nabla u dot nabla v dif x = integral_Omega f v dif x + integral_(partial Omega) g v dif S quad "for all" v in H^1 (Omega).
  $
  (Formally, this corresponds to $-Delta u = f$ in $Omega$ and $(partial u)/(partial nu) = g$ on $partial Omega$, obtained by integrating by parts.)
] <def:neumann-problem>

#proposition(name: "Compatibility Condition and Uniqueness")[
  (i) If a solution of the Neumann problem exists, then the data satisfy the *compatibility condition*
  $
    integral_Omega f dif x + integral_(partial Omega) g dif S = 0.
  $
  (ii) Solutions are unique up to an additive constant: if $u_1, u_2$ are both solutions, then $u_1 - u_2 = c$ a.e. for some constant $c$.
] <prop:neumann-compatibility>

#proof[
  (i) Take $v = 1$ in the weak formulation; both gradient terms vanish and the condition follows.
  (ii) The difference $w = u_1 - u_2$ satisfies $integral_Omega nabla w dot nabla w dif x = 0$, so $nabla w = 0$ a.e.; by connectedness of $Omega$, $w$ is constant a.e.
]

#theorem(name: "Existence for the Neumann Problem")[
  Assume the compatibility condition holds. Then the Neumann problem has a unique solution in the space ${u in H^1 (Omega) : integral_Omega u dif x = 0}$.
] <thm:neumann-existence>

#proof[
  On $H = {v in H^1 (Omega) : integral_Omega v dif x = 0}$, the form $B (u, v) = integral_Omega nabla u dot nabla v dif x$ is coercive: this is Poincaré's inequality for mean-zero functions, $||u||_(L^2) <= C ||nabla u||_(L^2)$ for $u in H$ (proved like Proposition 9.1, using the mean-zero condition instead of vanishing on the boundary). The functional $F (v) = integral_Omega f v dif x + integral_(partial Omega) g v dif S$ is bounded on $H$ (trace inequality for $H^1$), and Lax--Milgram applies. The compatibility condition ensures that $F$ vanishes on constants, so $F$ is well-defined on $H$ (i.e., on equivalence classes modulo constants).
]

== Robin and Mixed Conditions // Robin 与混合边界条件

#definition(name: "The Robin Problem")[
  Let $sigma in L^oo (partial Omega)$ with $sigma >= 0$ and $integral_(partial Omega) sigma dif S > 0$. The *Robin problem* $-Delta u = f$ in $Omega$, $(partial u)/(partial nu) + sigma u = g$ on $partial Omega$ has the weak form: find $u in H^1 (Omega)$ such that
  $
    integral_Omega nabla u dot nabla v dif x + integral_(partial Omega) sigma u v dif S = integral_Omega f v dif x + integral_(partial Omega) g v dif S quad "for all" v in H^1 (Omega).
  $
] <def:robin-problem>

#theorem(name: "Existence and Uniqueness for the Robin Problem")[
  Let $Omega$ be a bounded Lipschitz domain, $f in L^2 (Omega)$, $g in L^2 (partial Omega)$, and $sigma$ as above. Then the Robin problem has a unique weak solution $u in H^1 (Omega)$.
] <thm:robin-existence>

#proof[
  Apply Lax--Milgram on $H = H^1 (Omega)$ with $B (u, v) = integral_Omega nabla u dot nabla v dif x + integral_(partial Omega) sigma u v dif S$. Boundedness follows from the trace inequality. For coercivity, note that $B (u, u) = 0$ would force $nabla u = 0$ (so $u$ is constant) and $integral_(partial Omega) sigma u^2 dif S = 0$, hence $u = 0$ since $integral_(partial Omega) sigma dif S > 0$; by a compactness argument (Rellich embedding) the form is coercive on $H^1 (Omega)$.
]

#note[
  *Mixed boundary conditions.* One may prescribe Dirichlet data on a part $Gamma_D$ of the boundary and Neumann or Robin data on the remainder $Gamma_N$. The weak formulation is the same, with the test space $H_(Gamma_D)^1 = {v in H^1 (Omega) : v = 0 "on" Gamma_D}$; existence follows from Lax--Milgram under analogous coercivity assumptions. The trace theorems required for $L^2 (partial Omega)$ boundary terms are treated in Analyse Harmonique.
]

== Uniqueness via Energy Methods // 能量方法的唯一性

#theorem(name: "Dirichlet's Principle")[
  Let $Omega$ be bounded, $f in L^2 (Omega)$, and $g in H^1 (Omega)$. A function $u in H^1 (Omega)$ with $u - g in H_0^1 (Omega)$ minimizes the energy functional
  $
    E (v) = 1/2 integral_Omega abs(nabla v)^2 dif x - integral_Omega f v dif x
  $
  over the affine space $g + H_0^1 (Omega)$ if and only if $u$ is the weak solution of the Dirichlet problem.
] <thm:dirichlet-principle>

#proof[
  For any $w in H_0^1 (Omega)$, the map $t |-> E (u + t w)$ is a convex quadratic polynomial (the Hessian is $B (w, w) = integral_Omega abs(nabla w)^2 dif x >= 0$), whose derivative at $0$ is
  $
    E' (u) [w] = integral_Omega nabla u dot nabla w dif x - integral_Omega f w dif x.
  $
  A minimizer satisfies $E' (u) [w] = 0$ for all $w in H_0^1 (Omega)$, which is exactly the weak formulation; convexity makes this first-order condition sufficient. Existence of the minimizer also follows directly from coercivity and convexity (direct method of the calculus of variations).
]

#note[
  The energy viewpoint and the maximum principle are complementary tools. The maximum principle (Chapter 8) is quantitative and works in $C^2$; energy methods provide existence in the weak framework and are the starting point for numerical approximation (Ritz--Galerkin). The Dirichlet principle also shows that the weak solution is the "least energy" representative among functions with the given boundary data — a variational characterization that extends to parabolic problems in Part V.
]



= Green Functions and Representation // 格林函数与表示

The fundamental solution of the Laplacian was constructed in Chapter 7 (#link(<ex:fund-laplace>)[§7.2]): it is the Newtonian potential $Gamma$, satisfying $-Delta Gamma = delta$ on $bb(R)^n$. For a bounded domain, the *Green function* modifies $Gamma$ by a harmonic correction so that it vanishes on the boundary; it then encodes the solution of the Dirichlet problem through an explicit representation formula.

== Green's Function Construction // 格林函数的构造

#definition(name: "Green's Function of a Domain")[
  Let $Omega subset bb(R)^n$ be a bounded domain with smooth boundary and let $Gamma$ be the fundamental solution of the Laplacian (Chapter 7, #link(<ex:fund-laplace>)[§7.2]):
  $
    Gamma (x) = cases(
      -1 / ((n - 2) omega_n) abs(x)^(2 - n), n >= 3,
      1 / (2 pi) log abs(x), n = 2,
    )
  $
  For each fixed $y in Omega$, the *Green function* of $Omega$ is
  $
    G (x, y) = Gamma (x - y) - h^y (x), quad x in Omega backslash {y},
  $
  where $h^y$ is the unique harmonic function in $Omega$, smooth up to the boundary, with $h^y = Gamma (dot - y)$ on $partial Omega$ (existence of $h^y$: Chapter 9, §9.1). Equivalently, $G$ is the unique function such that
  $
    -Delta_x G (dot, y) = delta_y quad "in" quad Omega, quad G (dot, y) = 0 quad "on" quad partial Omega.
  $
] <def:green-function>

#note[
  The correction term is chosen so that $G$ vanishes on the boundary, while the singularity at $y$ is exactly that of the fundamental solution. By the maximum principle, the Dirichlet problem for $h^y$ has a unique solution, so $G$ is well defined. The construction does not repeat the fundamental solution (already treated in Chapter 7); it only exploits it as the singular part.
]

#theorem(name: "Symmetry of the Green Function")[
  $G (x, y) = G (y, x)$ for all $x != y$ in $Omega$.
] <thm:green-symmetry>

#proof[
  Fix distinct points $x_0, y_0 in Omega$ and set $Omega_epsilon = Omega backslash (overline(B (x_0, epsilon)) union overline(B (y_0, epsilon)))$ for small $epsilon$. The functions $u = G (dot, x_0)$ and $v = G (dot, y_0)$ are harmonic in $Omega_epsilon$, so Green's second identity (#link(<prop:green-identities>)[§8.4]) gives
  $
    integral_(partial Omega_epsilon) (u (partial v)/(partial nu) - v (partial u)/(partial nu)) dif S = 0.
  $
  The integral over $partial Omega$ vanishes because $u = v = 0$ there. On the sphere $partial B (x_0, epsilon)$, the leading term of $u$ is $Gamma (x - x_0)$, so
  $
    lim_(epsilon -> 0) integral_(partial B (x_0, epsilon)) v (partial u)/(partial nu) dif S = -v (y_0) ... 
  $
  hmm.
]

#proof[
  Fix distinct $x_0, y_0 in Omega$ and excise small balls: $Omega_epsilon = Omega backslash (B (x_0, epsilon) union B (y_0, epsilon))$. Both $u = G (dot, x_0)$ and $v = G (dot, y_0)$ are harmonic on $Omega_epsilon$, so Green's second identity (#link(<prop:green-identities>)[§8.4]) yields
  $
    integral_(partial Omega_epsilon) (u (partial v)/(partial nu) - v (partial u)/(partial nu)) dif S = 0.
  $
  On $partial Omega$ both $u$ and $v$ vanish. On the two small spheres, $u (x) = Gamma (x - x_0) + O(1)$ with $partial u / partial nu ~ -1 / (omega_n epsilon^(n-1))$ as $epsilon -> 0$ (and similarly for $v$), so the surviving terms give, in the limit,
  $
    v (y_0) = u (x_0), quad "i.e." quad G (y_0, x_0) = G (x_0, y_0).
  $
]

== Representation Formulas // 表示公式

#theorem(name: "Green's Representation Formula")[
  Let $Omega subset bb(R)^n$ be a bounded domain with $C^1$ boundary and let $u in C^2 (overline(Omega))$. Then for every $y in Omega$,
  $
    u (y) = integral_(partial Omega) (u (x) (partial G)/(partial nu_x) (x, y) - G (x, y) (partial u)/(partial nu) (x)) dif S (x) - integral_Omega G (x, y) Delta u (x) dif x.
  $
  In particular, a harmonic function is determined by its boundary values together with the normal derivative of $G$ on the boundary.
] <thm:green-representation>

#proof[
  Apply Green's second identity (#link(<prop:green-identities>)[§8.4]) to $u$ and $v = G (dot, y)$ on $Omega_epsilon = Omega backslash B (y, epsilon)$; both functions are $C^2$ there. Since $G$ vanishes on $partial Omega$ and $Delta G = 0$ away from $y$,
  $
    integral_(partial Omega_epsilon) (u (partial G)/(partial nu) - G (partial u)/(partial nu)) dif S = -integral_(Omega_epsilon) G Delta u dif x.
  $
  On the small sphere $partial B (y, epsilon)$, write $G (x, y) = Gamma (x - y) + O(1)$ and $(partial G)/(partial nu) (x, y) = -1 / (omega_n epsilon^(n-1)) + O(1)$. Then as $epsilon -> 0$,
  $
    integral_(partial B (y, epsilon)) (u (partial G)/(partial nu) - G (partial u)/(partial nu)) dif S -> -u (y),
  $
  and rearranging gives the representation formula.
]

#theorem(name: "Poisson's Integral Formula on a Ball")[
  Let $B = B (0, R) subset bb(R)^n$ and $g in C (partial B)$. The unique harmonic function $u in C^2 (B) inter C (overline(B))$ with $u = g$ on $partial B$ is given by
  $
    u (x) = integral_(partial B) Phi (x, y) g (y) dif S (y), quad Phi (x, y) = (R^2 - abs(x)^2) / (omega_n R abs(x - y)^n), quad x in B.
  $
  The function $Phi$ is called the *Poisson kernel* of the ball. Moreover, $Phi (x, y) > 0$ and $integral_(partial B) Phi (x, y) dif S (y) = 1$ for every $x in B$.
] <thm:poisson-integral-formula>

#proof[
  *Step 1: The Green function of the ball.* For $y in B$, let $y^* = (R^2 / abs(y)^2) y$ be the inverse point (the Kelvin transform of $y$). One verifies that for $abs(x) = R$,
  $
    abs(x - y) = (abs(y)/R) abs(x - y^*),
  $
  so the function $G (x, y) = Gamma (x - y) - Gamma ((abs(y)/R) (x - y^*))$ vanishes on $partial B$, is harmonic in $x != y$, and has the singularity of $Gamma$ at $y$. By uniqueness of the Green function, this is the Green function of the ball.

  *Step 2: Compute the normal derivative.* For $u$ harmonic, the representation formula reduces to $u (y) = integral_(partial B) u (x) (partial G)/(partial nu_x) (x, y) dif S (x)$. A direct differentiation of the explicit $G$ on the sphere gives
  $
    (partial G)/(partial nu_x) (x, y) = (R^2 - abs(y)^2) / (omega_n R abs(x - y)^n),
  $
  and using the symmetry of $G$ (Chapter 10, §10.1) and renaming variables yields the Poisson kernel $Phi$.

  *Step 3: Properties.* Taking $u = 1$ (harmonic) shows $integral_(partial B) Phi (x, y) dif S (y) = 1$; positivity is immediate from the formula. Uniqueness follows from the maximum principle (Chapter 8, §8.3).
]

== Method of Images and Conformal Mapping // 镜像法与保角映射

#example(name: "Green's Function of the Half-Space via the Method of Images")[
  For the half-space $Omega = bb(R)_+^n = {x = (x', x_n) : x_n > 0}$, the Green function is obtained by reflecting the source: for $y = (y', y_n)$ the image point is $tilde(y) = (y', -y_n)$, and
  $
    G (x, y) = Gamma (x - y) - Gamma (x - tilde(y)), quad x, y in bb(R)_+^n.
  $
  On the boundary ${x_n = 0}$, one has $abs(x - y) = abs(x - tilde(y))$, so the two terms cancel and $G = 0$; away from $y$ the reflected term is harmonic (its singularity lies in the lower half-space). This is the *method of images*: the boundary condition is enforced by a mirror source of opposite sign.
]

#example(name: "Green's Function of the Ball via the Kelvin Transform")[
  For $Omega = B (0, R)$ and $y in B (0, R)$, let $y^* = (R^2 / abs(y)^2) y$ be the inverse point. Then
  $
    G (x, y) = Gamma (x - y) - Gamma ((abs(y)/R) (x - y^*)).
  $
  As shown in the proof of Poisson's formula (Chapter 10, §10.2), the second term cancels $Gamma (x - y)$ on $partial B (0, R)$ and is harmonic inside the ball, so this is the Green function of the ball.
]

#note[
  *Conformal invariance in two dimensions.* In the plane, harmonic functions interact with complex analysis: if $f: Omega -> bb(C)$ is holomorphic and $u$ is harmonic, then $u compose f$ is harmonic wherever defined (the Laplacian transforms by the conformal factor $abs(f')^2$). Consequently, Green functions and Dirichlet problems can be transferred between conformally equivalent planar domains — a powerful tool for solving problems on disks, strips, and polygons (the Riemann mapping theorem guarantees the equivalence). This is the viewpoint developed in Analyse Complexe; here we only record the elementary invariance fact.
]

= Regularity Theory // 正则性理论

Weak solutions constructed in Chapter 9 are $H^1$ functions; the question of their smoothness is *regularity theory*. This chapter states the central results: interior and boundary regularity, the Schauder estimates in Hölder spaces, and the $L^p$ estimates based on the Calderón--Zygmund theory. The Sobolev space machinery is summarized here; its deeper theory (embeddings, traces) belongs to Analyse Harmonique.

== Interior Regularity // 内正则性

#definition(name: "Sobolev Spaces $W^(k,p)$")[
  For $k >= 0$ and $1 <= p <= oo$, the space $W^(k,p) (Omega)$ consists of all $u in L^p (Omega)$ whose weak derivatives $partial^alpha u$ (Chapter 6, #link(<def:weak-derivative>)[§6.2]) belong to $L^p (Omega)$ for every multi-index $alpha$ with $abs(alpha) <= k$, with the norm
  $
    ||u||_(W^(k,p)) = (sum_(abs(alpha) <= k) integral_Omega abs(partial^alpha u)^p dif x)^(1/p), quad 1 <= p < oo,
  $
  and the essential-supremum norm for $p = oo$. For $p = 2$ we write $H^k (Omega) = W^(k,2) (Omega)$; $H_("loc")^k$ denotes membership on every compactly contained subdomain. The basic theory (completeness, density, embeddings) is developed in Analyse Harmonique.
] <def:sobolev-wkp>

#theorem(name: "Interior Regularity")[
  Let $u in H^1 (Omega)$ be a weak solution of $-Delta u = f$ in $Omega$ (#link(<def:weak-dirichlet>)[§9.1]). If $f in H_("loc")^k (Omega)$ for some $k >= 0$, then $u in H_("loc")^(k+2) (Omega)$. In particular, if $f in C^oo (Omega)$ then $u in C^oo (Omega)$ after modification on a null set.
] <thm:interior-regularity>

#proof[
  *Step 1: Difference quotients.* Let $D_i^h u (x) = (u (x + h e_i) - u (x))/h$. Testing the weak formulation with $v = -D_i^(-h) (eta^2 D_i^h u)$, where $eta in C_c^oo (Omega)$ is a cutoff with $eta = 1$ on $Omega' subset subset Omega$, and using the elementary identity
  $
    integral_Omega (D_i^(-h) w) z dif x = integral_Omega w (D_i^h z) dif x,
  $
  one obtains, uniformly in small $h$,
  $
    integral_Omega eta^2 abs(D_i^h nabla u)^2 dif x <= C (||f||_(L^2 (U))^2 + ||u||_(H^1 (U))^2)
  $
  for a slightly larger open set $U$. Passing $h -> 0$ gives $u in H_("loc")^2 (Omega)$ and the local $H^2$ estimate.

  *Step 2: Bootstrap.* Since $u in H_("loc")^2$, the differentiated equation $Delta (partial^alpha u) = partial^alpha f$ holds weakly; applying Step 1 to the derivatives iterates the gain of two derivatives, yielding $u in H_("loc")^(k+2) (Omega)$.

  *Step 3: Smoothness.* If $f in C^oo (Omega)$, Step 2 gives $u in H_("loc")^m (Omega)$ for every $m$, and the Sobolev embedding theorem (Analyse Harmonique) implies $u in C^oo (Omega)$.
]

#corollary(name: "Weyl's Lemma")[
  If $u in L_("loc")^1 (Omega)$ satisfies $Delta u = 0$ in the sense of distributions, then $u$ is (equal a.e. to) a harmonic $C^oo$ function.
] <cor:weyl-lemma>

#proof[
  Mollify: $u_epsilon = u * rho_epsilon$ is smooth on $Omega_epsilon$ and, since $Delta u = 0$ distributionally, $Delta u_epsilon = rho_epsilon * Delta u = 0$ classically. By the mean value property and its converse (Chapter 8, §8.2), the locally uniform limit $u$ is harmonic and smooth.
]

== Boundary Regularity // 边界正则性

#theorem(name: "Boundary Regularity")[
  Let $Omega$ be a bounded domain with $C^(k+2)$ boundary, $f in H^k (Omega)$, and $g in H^(k + 3/2) (partial Omega)$ (trace sense). Then the weak solution of the Dirichlet problem satisfies $u in H^(k+2) (Omega)$ and
  $
    ||u||_(H^(k+2) (Omega)) <= C (||f||_(H^k (Omega)) + ||g||_(H^(k + 3/2) (partial Omega))),
  $
  with $C = C (Omega, k)$.
] <thm:boundary-regularity>

#note[
  The improvement near the boundary requires regularity of the domain: the proof localizes near $partial Omega$, flattens the boundary by a $C^(k+2)$ diffeomorphism, and applies the interior estimates to the straightened problem. At corners or on nonsmooth domains the regularity degrades; the precise loss depends on the opening angle. The fractional-order spaces on the boundary (traces) are treated in Analyse Harmonique.
]

== Schauder Estimates // Schauder 估计

#definition(name: "Hölder Spaces")[
  For $0 < alpha <= 1$ and an open set $Omega$, the space $C^(0, alpha) (Omega)$ consists of bounded functions with finite Hölder seminorm
  $
    [u]_(C^(0, alpha)) = sup_(x != y) abs(u (x) - u (y)) / abs(x - y)^alpha,
  $
  normed by $||u||_(C^(0, alpha)) = ||u||_oo + [u]_(C^(0, alpha))$. For $k >= 1$, $C^(k, alpha) (Omega)$ consists of functions whose derivatives of order at most $k$ are in $C^(0, alpha)$, with the analogous norm; $C^(k, alpha) (overline(Omega))$ is defined by uniform extendability to a neighborhood.
] <def:holder-spaces>

#theorem(name: "Interior Schauder Estimates")[
  Let $u in C^(2, alpha) (Omega)$ solve $-Delta u = f$ in $Omega$ with $f in C^(0, alpha) (Omega)$. Then for every $Omega' subset subset Omega$,
  $
    ||u||_(C^(2, alpha) (Omega')) <= C (||u||_(C^(0, alpha) (Omega)) + ||f||_(C^(0, alpha) (Omega))),
  $
  with $C = C (n, alpha, Omega', Omega)$. In particular, the second derivatives of $u$ and their Hölder seminorms are controlled by the data and the size of $u$.
] <thm:schauder-interior>

#theorem(name: "Global Schauder Estimates")[
  Let $Omega$ be a bounded domain with $partial Omega in C^(2, alpha)$. If $u in C^(2, alpha) (overline(Omega))$ solves the Dirichlet problem with $f in C^(0, alpha) (overline(Omega))$ and $g in C^(2, alpha) (partial Omega)$, then
  $
    ||u||_(C^(2, alpha) (overline(Omega))) <= C (||u||_(C^0 (overline(Omega))) + ||f||_(C^(0, alpha) (overline(Omega))) + ||g||_(C^(2, alpha) (partial Omega))).
  $
] <thm:schauder-global>

#note[
  The proof of the Schauder estimates is potential-theoretic: writing $u = Gamma * f + h$ with $h$ harmonic, the second derivatives of the Newtonian potential are singular integrals, and the Hölder estimates for such integrals (Calderón--Zygmund theory, Chapter 11, §11.4) give the result. The estimates are the quantitative backbone of nonlinear elliptic theory (freezing coefficients, linearization).
]

== L^p Estimates and Calderón-Zygmund Theory // L^p 估计与 Calderón-Zygmund 理论

#definition(name: "Calderón–Zygmund Singular Integrals")[
  An operator $T$ of the form
  $
    T f (x) = p.v. integral_(bb(R)^n) K (x - y) f (y) dif y
  $
  with kernel $K$ homogeneous of degree $-n$ ($K (lambda z) = lambda^(-n) K (z)$ for $lambda > 0$), smooth away from the origin, and mean-zero on the unit sphere, is a *Calderón--Zygmund singular integral operator*. The second derivatives of the Newtonian potential $Gamma * f$ are such operators.
] <def:cz-operator>

#theorem(name: "$L^p$ Estimates for the Laplacian")[
  For $1 < p < oo$ there exists $C = C (n, p)$ such that every $u in W^(2,p) (bb(R)^n)$ satisfies
  $
    ||D^2 u||_(L^p) <= C ||Delta u||_(L^p).
  $
  Consequently, for $f in L^p (Omega)$ the weak solution of the Dirichlet problem on a bounded $C^2$ domain satisfies the a priori estimate
  $
    ||u||_(W^(2,p) (Omega)) <= C (||f||_(L^p (Omega)) + ||u||_(L^p (Omega))).
  $
] <thm:lp-estimate>

#note[
  The proof of the $L^p$ estimates uses the Calderón--Zygmund decomposition: the operator $D^2 Gamma$ is of weak type $(1, 1)$ (a distributional inequality controlling the level sets), and interpolation (Marcinkiewicz) upgrades this to strong $L^p$ bounds for $1 < p < oo$. The theory is developed in full in Analyse Harmonique; here we record the statement, which is the $L^p$ analogue of the Schauder estimates — the two families (Hölder and Lebesgue spaces) are the twin pillars of elliptic regularity.
]

// ==========================================================================
// Part V — Parabolic Equations (抛物型方程)
// 设计思路：以热方程为核心模型，建立抛物型方程的
// 存在性、唯一性、正则性和长期行为理论。
// 半群理论作为统一框架自然嵌入 Ch 13。

// --- Chapter 12: Heat Equation (热方程) ---

//   Section 12.1: Heat Kernel and Fundamental Solution (热核与基本解)
//     - 热核的导出与性质（基本解已在 Ch 7 构造，此处给初值问题视角）
//     - 初值问题的基本解

//   Section 12.2: Cauchy Problem (Cauchy 问题)
//     - 初值问题的解
//     - 正则化效应

//   Section 12.3: Maximum Principle (最大值原理)
//     - 弱最大值原理
//     - 强最大值原理

//   Section 12.4: Energy Estimates and Smoothing Effect (能量估计与平滑效应)
//     - 能量不等式
//     - 无穷次光滑效应

// --- Chapter 13: Linear Parabolic Boundary Value Problems (线性抛物型边值问题) ---

//   Section 13.1: Dirichlet and Neumann Problems (狄利克雷与纽曼问题)
//     - 弱形式与存在性
//     - Galerkin 逼近

//   Section 13.2: Semigroup Framework (半群框架)
//     - C_0 半群与无穷小生成元
//     - 热方程的半群解释

//   Section 13.3: Comparison Principles and Monotone Iteration (比较原理与单调迭代)
//     - 上下解比较、正性保持
//     - 单调迭代格式与收敛（原 Ch 11.4 并入此处）

//   Section 13.4: Long-Time Behavior (长期行为)
//     - 指数衰减
//     - 与椭圆问题的联系

// --- Chapter 14: Nonlinear Parabolic Equations (非线性抛物型方程) ---

//   Section 14.1: Reaction-Diffusion Equations (反应-扩散方程)
//     - 一般框架
//     - 局部存在性

//   Section 14.2: Fisher-KPP Equation (Fisher-KPP 方程)
//     - 行波解
//     - 传播速度

//   Section 14.3: Blow-Up and Global Existence (爆破与整体存在)
//     - 爆破判据
//     - 整体存在条件

#part("Parabolic Equations") // 抛物型方程

= The Heat Equation // 热方程

The heat equation, introduced in Chapter 1 (#link(<def:heat-equation>)[Ch 1]), is the prototypical parabolic equation. Its fundamental solution — the heat kernel — was constructed in Chapter 7 (#link(<ex:fund-heat>)[§7.2]); this chapter develops the classical theory of the initial value problem: the Cauchy problem, the maximum principle, and the energy estimates. Two features distinguish parabolic equations from hyperbolic ones (Part VI): *regularization* — arbitrary rough data become $C^oo$ instantly — and *irreversibility* — the backward problem is ill-posed.

== Heat Kernel and Fundamental Solution // 热核与基本解

#definition(name: "The Heat Kernel")[
  The *heat kernel* on $bb(R)^n$ is
  $
    E (t, x) = cases(1 / (4 pi t)^(n/2) exp(-abs(x)^2 / (4 t)), t > 0, 0, t <= 0.)
  $
  It is the fundamental solution of the heat operator (Chapter 7, #link(<ex:fund-heat>)[§7.2]): $(partial_t - Delta_x) E = delta$ in $cal(D)'(bb(R)^(1+n))$.
] <def:heat-kernel>

#proposition(name: "Basic Properties of the Heat Kernel")[
  For every $t > 0$:
  (i) $E (t, dot) in C^oo (bb(R)^n)$ and $E (t, x) > 0$ for all $x$;
  (ii) $integral_(bb(R)^n) E (t, x) dif x = 1$;
  (iii) $(partial_t - Delta) E (t, x) = 0$ for $t > 0$;
  (iv) as $t -> 0^+$, $E (t, dot) -> delta$ in $cal(D)'(bb(R)^n)$ (approximate identity).
] <prop:heat-kernel-properties>

#proof[
  (i) and (iii) are direct computations with the Gaussian, already carried out in Chapter 7 (#link(<ex:fund-heat>)[§7.2]). For (ii), use the one-dimensional Gaussian integral $integral_(-oo)^oo e^(-s^2) dif s = sqrt(pi)$:
  $
    integral_(bb(R)^n) E (t, x) dif x = 1 / (4 pi t)^(n/2) product_(i=1)^n integral_(-oo)^oo exp(-x_i^2 / (4 t)) dif x_i = 1 / (4 pi t)^(n/2) (sqrt(4 pi t))^n = 1.
  $
  (iv) follows from (ii), positivity, and the concentration of the mass at the origin as $t -> 0^+$ (Chapter 7, §7.1).
]

== Cauchy Problem // Cauchy 问题

#definition(name: "The Cauchy Problem for the Heat Equation")[
  The *Cauchy problem* is to find $u: [0, oo) times bb(R)^n -> bb(R)$ such that
  $
    partial_t u = Delta u quad "in" quad (0, oo) times bb(R)^n, quad u (0, x) = g (x) quad "on" quad {t = 0},
  $
  where $g: bb(R)^n -> bb(R)$ is the prescribed initial datum.
] <def:cauchy-heat>

#theorem(name: "Solution of the Cauchy Problem")[
  Let $g in C (bb(R)^n) inter L^oo (bb(R)^n)$. Then
  $
    u (t, x) = integral_(bb(R)^n) E (t, x - y) g (y) dif y, quad t > 0, quad u (0, x) = g (x),
  $
  defines $u in C^oo ((0, oo) times bb(R)^n) inter C ([0, oo) times bb(R)^n)$, which satisfies the heat equation for $t > 0$ and $u (0, dot) = g$.
] <thm:cauchy-heat>

#proof[
  For each fixed $t > 0$, $E (t, dot) in cal(S) (bb(R)^n)$ and $g in L^oo$, so the convolution is well defined; differentiating under the integral and using (iii) of the heat kernel properties gives $(partial_t - Delta) u = 0$ for $t > 0$, and $u in C^oo$ there. For the initial condition, (iv) says ${E (t, dot)}_(t > 0)$ is an approximate identity; the standard mollifier argument (Chapter 7, #link(<def:mollifier>)[§7.1]) gives $u (t, dot) = E (t, dot) * g -> g$ locally uniformly as $t -> 0^+$, so $u$ extends continuously to $t = 0$ with the right limit.
]

#note[
  *Smoothing effect.* No regularity of $g$ beyond continuity is needed: $u (t, dot)$ is $C^oo$ for every $t > 0$, and by the derivative estimates of Chapter 8 the derivatives decay as $t^(-abs(alpha)/2)$ (quantified in §12.4). This instantaneous regularization is the hallmark of parabolic equations and is in sharp contrast to the wave equation (Part VI), which propagates the regularity of the data without improvement.
]

== Maximum Principle // 最大值原理

#theorem(name: "Weak Maximum Principle for the Heat Equation")[
  Let $Omega subset bb(R)^n$ be bounded and $T > 0$, and set $Omega_T = (0, T] times Omega$. If $u in C^2 (Omega_T) inter C (overline(Omega_T))$ satisfies $partial_t u - Delta u <= 0$ in $Omega_T$, then
  $
    max_(overline(Omega_T)) u = max_(Gamma_T) u,
  $
  where $Gamma_T = ({0} times overline(Omega)) union ([0, T] times partial Omega)$ is the *parabolic boundary* (the bottom and the lateral sides; the top $t = T$ is not part of it). For $partial_t u - Delta u >= 0$ the same holds with minima.
] <thm:parabolic-weak-maximum>

#proof[
  *Step 1: Strict inequality.* Suppose $partial_t u - Delta u < 0$. If $u$ attained its maximum at an interior point $(t_0, x_0)$ with $0 < t_0 < T$ and $x_0 in Omega$, then $partial_t u (t_0, x_0) = 0$ (first-order condition) and $Delta u (t_0, x_0) <= 0$ (second-derivative test), contradicting the strict inequality. If the maximum occurred on the top $t = T$, say at $(T, x_0)$ with $x_0 in Omega$, then for small $h > 0$, $u (T, x_0) >= u (T - h, x_0)$ gives $(partial u)/(partial t) (T, x_0) >= 0$, while $Delta u (T, x_0) <= 0$, again contradicting $partial_t u - Delta u < 0$. Hence the maximum lies on $Gamma_T$.

  *Step 2: General case.* For $epsilon > 0$ consider $u_epsilon (t, x) = u (t, x) - epsilon t$, for which $partial_t u_epsilon - Delta u_epsilon = (partial_t u - Delta u) - epsilon < 0$. By Step 1, $max_(overline(Omega_T)) u_epsilon = max_(Gamma_T) u_epsilon$. Letting $epsilon -> 0$ and using $u_epsilon <= u <= u_epsilon + epsilon T$ gives $max u = max_(Gamma_T) u$.
]

#theorem(name: "Strong Maximum Principle for the Heat Equation")[
  Let $Omega$ be connected and $u in C^2 (Omega_T) inter C (overline(Omega_T))$ with $partial_t u - Delta u <= 0$ in $Omega_T$. If $u$ attains its maximum at a point of $Omega_T$ (i.e. with $t > 0$), then $u$ is constant on $overline(Omega) times [0, t]$. In particular, a non-constant solution of the heat equation attains its maximum only on the parabolic boundary.
] <thm:parabolic-strong-maximum>

#proof[
  (Sketch.) The proof propagates the maximum backward in time using the positivity of the heat kernel. If $u (t_0, x_0) = M$ is the maximum, then for $0 < s < t_0$ the mean value formula for the heat equation gives
  $
    u (t_0, x_0) = integral_(bb(R)^n) E (s, y) u (t_0 - s, x_0 - y) dif y
  $
  (on the whole space; for bounded domains, boundary terms enter with the correct sign for sub-solutions). Since $E (s, y) > 0$, $integral E dif y = 1$, and $u <= M$, the average can equal $M$ only if $u (t_0 - s, dot) = M$ a.e., hence everywhere by continuity. Iterating backward in $t$ and spreading in space by connectedness yields $u = M$ on $overline(Omega) times [0, t_0]$.
]

#corollary(name: "Uniqueness of Bounded Solutions of the Cauchy Problem")[
  Let $u, v in C^2 ((0, oo) times bb(R)^n) inter C ([0, oo) times bb(R)^n)$ be bounded solutions of the Cauchy problem with the same initial datum. Then $u = v$; in particular, the solution of Theorem 12.2 is the unique bounded solution.
] <cor:cauchy-heat-uniqueness>

#proof[
  The difference $w = u - v$ is bounded, say $abs(w) <= 2 M$, and solves the heat equation with $w (0, dot) = 0$. Fix $(T, y)$ and $epsilon > 0$. By continuity at $t = 0$, there is $delta > 0$ with $abs(w (t, x)) < epsilon$ for $0 <= t < delta$ on every bounded set; fix $R$ so large that on the cylinder $Q = (delta, T) times {abs(x - y) < R}$ the Gaussian barrier
  $
    v (t, x) = 2 M (1 - exp(-(abs(x - y)^2)/(4 (T - t)))) + epsilon
  $
  dominates $abs(w)$ on the parabolic boundary of $Q$ (at $t = delta$ this holds for $R$ large since $v (delta, x) -> 2 M + epsilon$ as $R -> oo$; on the lateral side $v -> 2 M + epsilon$ as $t -> T^-$). A direct computation gives $partial_t v - Delta v <= 0$, so by the weak maximum principle $abs(w) <= v$ in $Q$; at the point $(T, y)$, $v = epsilon$, hence $abs(w (T, y)) <= epsilon$. Letting $epsilon -> 0$ gives $w (T, y) = 0$, and $(T, y)$ is arbitrary.
]

== Energy Estimates and Smoothing Effect // 能量估计与平滑效应

#proposition(name: "Energy Dissipation")[
  Let $u$ be a smooth solution of the heat equation on $(0, oo) times Omega$ with either $u = 0$ on $partial Omega$ (Dirichlet) or $(partial u)/(partial nu) = 0$ on $partial Omega$ (Neumann). Then
  $
    1/2 (dif)/(dif t) integral_Omega abs(u)^2 dif x = -integral_Omega abs(nabla u)^2 dif x.
  $
  In particular the $L^2$ energy is non-increasing in time.
] <prop:energy-dissipation>

#proof[
  Differentiating under the integral, using the equation, and integrating by parts:
  $
    1/2 (dif)/(dif t) integral_Omega abs(u)^2 dif x = integral_Omega u partial_t u dif x = integral_Omega u Delta u dif x = -integral_Omega abs(nabla u)^2 dif x + integral_(partial Omega) u (partial u)/(partial nu) dif S.
  $
  The boundary term vanishes for both Dirichlet and Neumann data.
]

#theorem(name: "Smoothing Estimates")[
  Let $g in L^2 (bb(R)^n)$ and $u = E * g$ the solution of the Cauchy problem. Then for every multi-index $alpha$ and every $t > 0$,
  $
    ||partial^alpha u (t, dot)||_(L^2) <= C_(n, alpha) t^(-abs(alpha)/2) ||g||_(L^2),
  $
  and for $g in L^1 (bb(R)^n) inter L^2 (bb(R)^n)$,
  $
    ||u (t, dot)||_oo <= (4 pi t)^(-n/2) ||g||_(L^1).
  $
  These are quantitative forms of the smoothing effect: each derivative costs the factor $t^(-abs(alpha)/2)$, which diverges only as $t -> 0^+$.
] <thm:smoothing-estimates>

#proof[
  By the scaling of the Gaussian, $partial^alpha E (t, x) = t^(-(n + abs(alpha))/2) (partial^alpha E) (1, x / sqrt(t))$, so $||partial^alpha E (t, dot)||_(L^1) = C t^(-abs(alpha)/2)$; Young's inequality for convolutions gives
  $
    ||partial^alpha u (t, dot)||_(L^2) <= ||partial^alpha E (t, dot)||_(L^1) ||g||_(L^2) <= C t^(-abs(alpha)/2) ||g||_(L^2).
  $
  The second estimate is the trivial Young bound $||E (t, dot) * g||_oo <= ||E (t, dot)||_oo ||g||_(L^1) = (4 pi t)^(-n/2) ||g||_(L^1)$.
]

#note[
  The smoothing effect is irreversible. The backward heat equation is ill-posed, as already noted in Chapter 1 (#link(<ex:backward-heat-ill-posed>)[§1.3]): the estimates above all blow up as $t -> 0^+$, and no bounded backward solution exists for general data. This asymmetry — regularization forward, instability backward — is characteristic of parabolic equations and underlies the arrow of time in diffusion processes.
]

= Linear Parabolic Boundary Value Problems // 线性抛物型边值问题

The Cauchy problem of Chapter 12 treats the whole space. On a bounded domain one prescribes, in addition to the initial datum, boundary conditions — the initial-boundary value problems of Chapter 9, now with a time derivative. The weak framework extends the elliptic theory (Chapter 9) to parabolic equations, and the semigroup viewpoint gives the abstract structure.

== Dirichlet and Neumann Problems // 狄利克雷与纽曼问题

#definition(name: "The Parabolic Initial-Boundary Value Problem")[
  Let $Omega subset bb(R)^n$ be a bounded domain and $T > 0$. The *Dirichlet initial-boundary value problem* is to find $u$ with
  $
    partial_t u - Delta u = f quad "in" quad (0, T) times Omega, quad u = 0 quad "on" quad (0, T) times partial Omega, quad u (0, dot) = u_0 quad "in" quad Omega.
  $
  The Neumann version replaces the boundary condition by $(partial u)/(partial nu) = 0$ on $(0, T) times partial Omega$.
] <def:parabolic-ibvp>

#definition(name: "Weak Formulation and Bochner Spaces")[
  Let $H = L^2 (Omega)$ and $V = H_0^1 (Omega)$ (Dirichlet) or $V = H^1 (Omega)$ (Neumann). A function $u in L^2 (0, T; V)$ with $partial_t u in L^2 (0, T; V')$ is a *weak solution* if $u (0) = u_0$ and, for a.e. $t in (0, T)$,
  $
    ⟨ partial_t u, v ⟩ + integral_Omega nabla u dot nabla v dif x = integral_Omega f v dif x quad "for all" v in V,
  $
  where $⟨ dot, dot ⟩$ denotes the duality pairing of $V'$ and $V$, and $u_0 in L^2 (Omega)$. (The Bochner spaces $L^p (0, T; X)$ are treated in Analyse Fonctionnelle; here they provide the natural functional framework.)
] <def:weak-parabolic>

#theorem(name: "Existence and Uniqueness via Galerkin Approximation")[
  Let $Omega$ be a bounded domain, $f in L^2 (0, T; L^2 (Omega))$, and $u_0 in L^2 (Omega)$. Then the Dirichlet problem has a unique weak solution
  $
    u in C ([0, T]; L^2 (Omega)) inter L^2 (0, T; H_0^1 (Omega)), quad partial_t u in L^2 (0, T; H^(-1) (Omega)),
  $
  satisfying the energy estimate
  $
    sup_(0 <= t <= T) ||u (t)||_(L^2)^2 + integral_0^T ||nabla u (t)||_(L^2)^2 dif t <= C (||u_0||_(L^2)^2 + ||f||_(L^2 (0, T; L^2))^2).
  $
] <thm:parabolic-existence>

#proof[
  *Step 1: The Galerkin system.* Let ${w_k}$ be an orthonormal basis of $L^2 (Omega)$ consisting of eigenfunctions of the Dirichlet Laplacian (spectral theorem for the compact resolvent, Analyse Fonctionnelle), with $-Delta w_k = lambda_k w_k$ and $0 < lambda_1 <= lambda_2 <= dots$. Look for $u_m (t) = sum_(k=1)^m c_k (t) w_k$ solving the system of ODEs
  $
    c_k' (t) + lambda_k c_k (t) = f_k (t), quad c_k (0) = (u_0, w_k), quad f_k (t) = (f (t), w_k).
  $
  By Duhamel's formula $c_k (t) = e^(-lambda_k t) c_k (0) + integral_0^t e^(-lambda_k (t - s)) f_k (s) dif s$, so $u_m$ is well defined on $[0, T]$.

  *Step 2: A priori estimates.* Multiply the $k$-th equation by $c_k$ and sum over $k$: using $sum_k lambda_k c_k^2 = ||nabla u_m||_(L^2)^2$ (orthonormality),
  $
    1/2 (dif)/(dif t) ||u_m||_(L^2)^2 + ||nabla u_m||_(L^2)^2 = (f, u_m) <= ||f||_(L^2) ||u_m||_(L^2).
  $
  Grönwall's inequality gives the uniform bound
  $
    sup_t ||u_m (t)||_(L^2)^2 + integral_0^T ||nabla u_m (t)||_(L^2)^2 dif t <= C
  $
  with $C$ independent of $m$.

  *Step 3: Passage to the limit.* By the uniform bounds, a subsequence converges weakly in $L^2 (0, T; H_0^1)$ and weakly-$*$ in $L^oo (0, T; L^2)$ to some $u$; the compactness lemma of Aubin--Lions (Analyse Fonctionnelle) upgrades this to the strong convergence needed to pass to the limit in the weak formulation. Uniqueness follows from the energy estimate applied to the difference of two solutions, which has zero data.
]

== Semigroup Framework // 半群框架

#definition(name: "$C_0$-Semigroup and Its Generator")[
  Let $X$ be a Banach space. A family ${S (t)}_(t >= 0)$ of bounded linear operators on $X$ is a *$C_0$-semigroup* if $S (0) = I$, $S (t + s) = S (t) S (s)$ for all $t, s >= 0$, and $t |-> S (t) x$ is continuous for every $x in X$. The *infinitesimal generator* is
  $
    A x = lim_(t -> 0^+) (S (t) x - x)/t,
  $
  defined on the set of $x$ for which the limit exists. (The abstract theory — the Hille--Yosida theorem — is developed in Analyse Fonctionnelle; here we apply it to the heat semigroup.)
] <def:semigroup>

#theorem(name: "The Heat Semigroup and Duhamel's Formula")[
  On $X = L^2 (Omega)$, the solution operator $S (t): u_0 |-> u (t, dot)$ of the homogeneous Dirichlet problem ($f = 0$) is a $C_0$-semigroup of self-adjoint contractions whose generator is the Dirichlet Laplacian $A = Delta$ with $"dom"(A) = H^2 (Omega) inter H_0^1 (Omega)$. The solution of the inhomogeneous problem is given by *Duhamel's formula*
  $
    u (t) = S (t) u_0 + integral_0^t S (t - s) f (s) dif s.
  $
] <thm:heat-semigroup>

#proof[
  The semigroup property $S (t + s) = S (t) S (s)$ follows from uniqueness of the Cauchy problem (both sides solve the heat equation with initial datum $S (s) u_0$); contractivity from the energy estimate (Chapter 13, §13.1) with $f = 0$; self-adjointness from the symmetry of the Laplacian on $H_0^1$. That the generator is the Dirichlet Laplacian on the stated domain is the content of the boundary regularity theorem (Chapter 11, §11.2). Duhamel's formula is verified by differentiation: the right-hand side satisfies the heat equation with the correct initial and boundary data (for smooth data directly; in general, approximate).
]

#note[
  The semigroup viewpoint recasts the heat equation as an infinite-dimensional linear ODE $u' (t) = A u (t)$ with $A = Delta$ negative self-adjoint, so $S (t) = e^(t A)$ behaves like a decaying exponential. The rate of decay is governed by the spectrum of $A$ (§13.4), and the semigroup estimates of Chapter 12 (§12.4) are exactly the $L^p -> L^q$ smoothing bounds used for nonlinear problems in Chapter 14.
]

== Comparison Principles and Monotone Iteration // 比较原理与单调迭代

#theorem(name: "Comparison Principle")[
  Let $Omega subset bb(R)^n$ be bounded and $u, v in C^2 (overline(Omega_T))$ with
  $
    partial_t u - Delta u <= partial_t v - Delta v quad "in" quad Omega_T, quad u <= v quad "on" quad Gamma_T.
  $
  Then $u <= v$ throughout $Omega_T$. In particular, if $partial_t u - Delta u <= 0$ and $u >= 0$ on $Gamma_T$, then $u >= 0$ in $Omega_T$ (*positivity preservation*).
] <thm:comparison-principle>

#proof[
  Apply the weak maximum principle (Chapter 12, #link(<thm:parabolic-weak-maximum>)[§12.3]) to $w = u - v$: since $partial_t w - Delta w <= 0$ in $Omega_T$ and $w <= 0$ on $Gamma_T$, we get $w <= 0$ everywhere.
]

#example(name: "Monotone Iteration for Semilinear Problems")[
  Consider the semilinear problem $partial_t u - Delta u = f (u)$ in $Omega_T$ with $u = 0$ on the lateral boundary and $u (0, dot) = u_0$, where $f$ is smooth and bounded. A pair $(underline(u), overline(u))$ of *sub- and super-solutions* satisfies
  $
    partial_t underline(u) - Delta underline(u) <= f (underline(u)), quad partial_t overline(u) - Delta overline(u) >= f (overline(u)),
  $
  with ordered data $underline(u) <= overline(u)$ on $Gamma_T$ and $underline(u) (0, dot) <= u_0 <= overline(u) (0, dot)$. The iteration
  $
    partial_t u_(n+1) - Delta u_(n+1) = f (u_n), quad u_(n+1) (0, dot) = u_0, quad u_(n+1) = 0 "on" (0, T) times partial Omega,
  $
  started from $u_0 = underline(u)$, produces — by the comparison principle and standard compactness — an increasing sequence converging to the minimal solution of the problem; starting from $overline(u)$ gives the maximal solution. This *method of monotone iteration* (the former Chapter 11.4) is the standard existence tool for semilinear parabolic equations with monotone reaction terms.
] <ex:monotone-iteration>

== Long-Time Behavior // 长期行为

#theorem(name: "Exponential Decay for the Dirichlet Problem")[
  Let $lambda_1 > 0$ be the first eigenvalue of $-Delta$ with Dirichlet data on $Omega$. Then the solution of the homogeneous heat equation satisfies
  $
    ||u (t)||_(L^2) <= e^(-lambda_1 t) ||u_0||_(L^2), quad t >= 0,
  $
  and the spectrum of the generator consists of the eigenvalues ${-lambda_k}$ with $lambda_k -> oo$. Consequently $||u (t)||_(L^2) -> 0$ exponentially as $t -> oo$.
] <thm:exponential-decay>

#proof[
  Multiply the equation by $u$ and use Poincaré's inequality (#link(<prop:poincare-inequality>)[§9.1]), $||nabla u||_(L^2)^2 >= lambda_1 ||u||_(L^2)^2$. From the energy identity (Chapter 12, §12.4),
  $
    1/2 (dif)/(dif t) ||u||_(L^2)^2 = -||nabla u||_(L^2)^2 <= -lambda_1 ||u||_(L^2)^2,
  $
  and Grönwall's inequality gives the decay. The spectral statement follows from the spectral decomposition of the compact resolvent (Analyse Fonctionnelle): $S (t) = sum_k e^(-lambda_k t) P_k$ with the projections $P_k$ onto the eigenspaces.
]

#note[
  *Asymptotic stabilization.* For time-independent $f$, the solution converges to the elliptic steady state: if $v_oo$ solves $-Delta v_oo = f$ in $Omega$, $v_oo = 0$ on $partial Omega$ (Chapter 9, §9.1), then $w = u - v_oo$ satisfies the homogeneous heat equation, so
  $
    ||u (t) - v_oo||_(L^2) <= C e^(-lambda_1 t).
  $
  This is the parabolic-to-elliptic connection: the long-time behavior of the heat equation is governed by the elliptic problem, tying Part V back to Chapters 8–11.
]

= Nonlinear Parabolic Equations // 非线性抛物型方程

The linear theory of Chapters 12–13 is the platform for semilinear parabolic equations $partial_t u = Delta u + f (u)$, which model reaction-diffusion phenomena. Two qualitative phenomena dominate: *traveling fronts* propagating at a characteristic speed (the Fisher--KPP equation) and *finite-time blow-up* when the reaction dominates diffusion. The basic existence machinery is the contraction argument on Duhamel's formula.

== Reaction-Diffusion Equations // 反应-扩散方程

#definition(name: "Reaction-Diffusion Equations")[
  A *reaction-diffusion equation* is a semilinear parabolic equation of the form
  $
    partial_t u = Delta u + f (u, nabla u), quad u (0, dot) = u_0,
  $
  where $f$ is the reaction (source) term. Standard models: $f (u) = u (1 - u)$ (Fisher--KPP, §14.2), $f (u) = u^p$ (power nonlinearity, §14.3), and systems arising in chemistry, biology, and ecology.
] <def:reaction-diffusion>

#theorem(name: "Local Existence by Contraction on Duhamel's Formula")[
  Let $f: bb(R) -> bb(R)$ be $C^1$ with $f (0) = 0$ and $abs(f' (u)) <= C (1 + abs(u)^(q-1))$ for some $q$. Then for suitable initial data $u_0 in L^p (bb(R)^n)$ there exist $T > 0$ and a unique *mild solution* $u in C ([0, T]; L^p (bb(R)^n))$ of
  $
    u (t) = S (t) u_0 + integral_0^t S (t - s) f (u (s)) dif s,
  $
  where $S$ is the heat semigroup (Chapter 13, §13.2). The solution is obtained by the contraction mapping principle on a ball of $C ([0, T]; L^p)$, using the $L^q -> L^p$ smoothing estimates of the heat semigroup (Chapter 12, §12.4).
] <thm:local-existence>

#note[
  The *maximal time of existence* $T_max$ satisfies the blow-up alternative: either $T_max = oo$ (the solution is global) or $||u (t)||_oo -> oo$ as $t -> T_max^-$ (finite-time blow-up). This dichotomy is the basic qualitative question for reaction-diffusion equations (§14.3).
]

== Fisher-KPP Equation // Fisher-KPP 方程

#definition(name: "The Fisher--KPP Equation")[
  The *Fisher--KPP equation* (Fisher and Колмогоров, Петровский, Пискунов) is
  $
    partial_t u = partial_(x x)^2 u + u (1 - u), quad x in bb(R), quad t > 0,
  $
  the prototype for the spread of an advantageous gene (Fisher, 1937) and of a population (KPP, 1937). The constant solutions are the unstable equilibrium $u = 0$ and the stable equilibrium $u = 1$.
] <def:fisher-kpp>

#theorem(name: "Traveling Waves for Fisher--KPP")[
  A *traveling wave* is a solution $u (t, x) = phi (x - c t)$ with $phi (-oo) = 1$ and $phi (oo) = 0$ (a front connecting the two equilibria). Such fronts exist for the Fisher--KPP equation if and only if the speed satisfies
  $
    abs(c) >= 2,
  $
  and for $abs(c) >= 2$ the front $phi_c$ is strictly decreasing. The minimal speed $c^* = 2$ is the *spreading speed*: for compactly supported initial data $0 <= u_0 <= 1$, the solution converges to the front with speed $c^*$ in the moving frame.
] <thm:fisher-kpp-fronts>

#proof[
  Substituting $u (t, x) = phi (x - c t)$ into the equation gives the ODE
  $
    phi'' + c phi' + phi (1 - phi) = 0.
  $
  Linearizing at the unstable equilibrium $phi = 0$ (relevant as $x -> oo$), the characteristic equation is $lambda^2 + c lambda + 1 = 0$, whose roots are real if and only if $abs(c) >= 2$; real negative roots correspond to monotone fronts without oscillations. For $abs(c) >= 2$, a phase-plane analysis of the second-order ODE yields a monotone heteroclinic connection from $1$ to $0$ (and its reflection). The convergence of compactly supported solutions to the minimal front is the classical KPP theorem (Колмогоров, Петровский, Пискунов, 1937).
]

#note[
  The minimal speed admits the variational characterization $c^* = 2 sqrt(f' (0))$ for general monostable nonlinearities $f$ with $f (0) = f (1) = 0$ and $f > 0$ on $(0, 1)$: the speed is selected by the linearization at the unstable equilibrium. This *linear selection* principle is a hallmark of the KPP class; nonlinearities with $f' (0) = 0$ can give faster "pulled" fronts, and the analysis differs (non-KPP, pushed waves).
]

== Blow-Up and Global Existence // 爆破与整体存在

#definition(name: "Finite-Time Blow-Up")[
  A solution of a semilinear heat equation with maximal existence time $T_max < oo$ is said to *blow up in finite time*; by the blow-up alternative, $||u (t)||_oo -> oo$ as $t -> T_max^-$.
] <def:blow-up>

#theorem(name: "The Fujita Exponent")[
  Consider $partial_t u = Delta u + u^p$ on $bb(R)^n$, $p > 1$, with $u (0, dot) = u_0 >= 0$ nontrivial. The *Fujita critical exponent* is
  $
    p_c = 1 + 2/n.
  $
  (i) If $1 < p < p_c$, every nontrivial non-negative solution blows up in finite time.
  (ii) If $p > p_c$, small solutions exist globally and decay to zero as $t -> oo$, while large solutions may blow up.
  At the critical value $p = p_c$, blow-up occurs for all nontrivial solutions as well.
] <thm:fujita-exponent>

#note[
  The Fujita phenomenon exhibits the delicate balance between diffusion, which spreads mass, and the power nonlinearity, which amplifies it: for $p < p_c$ the reaction always wins, for $p > p_c$ small data are damped. The proof uses the heat kernel (Chapter 12) and the semigroup estimates: solutions are compared with self-similar subsolutions $u (t, x) = (T - t)^(-1/(p-1)) phi (x / sqrt(T - t))$, or blow-up is obtained by the Kaplan energy method below.
]

#proposition(name: "Blow-Up via the Kaplan Method")[
  Let $Omega subset bb(R)^n$ be bounded and $u$ solve $partial_t u = Delta u + f (u)$ in $Omega_T$ with $u = 0$ on $(0, T) times partial Omega$. If $f (u) >= u^(1 + epsilon)$ for some $epsilon > 0$ and the initial datum is large in the sense of the first Dirichlet eigenfunction, then $T_max < oo$: the solution blows up in finite time.
] <prop:blow-up-kaplan>

#proof[
  Let $phi_1 > 0$ be the first eigenfunction of the Dirichlet Laplacian, normalized by $integral_Omega phi_1 dif x = 1$, with $-Delta phi_1 = lambda_1 phi_1$. Define the moment $F (t) = integral_Omega u (t, x) phi_1 (x) dif x$. Multiplying the equation by $phi_1$ and integrating by parts,
  $
    F' (t) = integral_Omega (Delta u + f (u)) phi_1 dif x = integral_Omega u Delta phi_1 dif x + integral_Omega f (u) phi_1 dif x = -lambda_1 F (t) + integral_Omega f (u) phi_1 dif x.
  $
  Since $f (u) >= u^(1 + epsilon)$, Jensen's inequality (with the probability measure $phi_1 dif x$) gives $integral_Omega u^(1 + epsilon) phi_1 dif x >= F (t)^(1 + epsilon)$, hence the differential inequality
  $
    F' (t) >= F (t)^(1 + epsilon) - lambda_1 F (t),
  $
  which blows up in finite time whenever $F (0)$ is sufficiently large (the ODE $y' = y^(1 + epsilon) - lambda_1 y$ with large initial data has a finite explosion time).
]

// ==========================================================================
// Part VI — Hyperbolic Equations (双曲型方程)
// ==========================================================================
// 设计思路：以波动方程为核心模型，建立双曲型方程的
// 经典理论和现代守恒律理论。
// 去重：标量一维守恒律已在 Ch 5 完整处理，Ch 17 专注系统情形增量。

// --- Chapter 15: Wave Equation (波动方程) ---

//   Section 15.1: D'Alembert Formula (达朗贝尔公式)
//     - 通解已在 Ch 2 由标准形导出，此处给出完整 Cauchy 公式
//     - 行波解释

//   Section 15.2: Initial and Boundary Value Problems (初边值问题)
//     - Cauchy 问题（高维）
//     - 有界区域上的边值问题

//   Section 15.3: Energy Conservation (能量守恒)
//     - 能量恒等式
//     - 在唯一性证明中的应用

//   Section 15.4: Finite Propagation Speed (有限传播速度)
//     - 依赖区域
//     - 影响区域

//   Section 15.5: Duhamel Principle (Duhamel 原理)
//     - 非齐次方程的求解
//     - 与齐次问题的化归

// --- Chapter 16: Linear Hyperbolic Systems (线性双曲系统) ---

//   Section 16.1: Symmetric Hyperbolic Systems (对称双曲系统)
//     - Friedrichs 对称正系统
//     - 能量估计

//   Section 16.2: Riemann Invariants (Riemann 不变量)
//     - 对角化方法
//     - 不变量的构造

//   Section 16.3: Energy Methods and Well-Posedness (能量方法与适定性)
//     - 能量不等式
//     - 适定性证明

// --- Chapter 17: Conservation Laws for Systems (守恒律系统) ---
// 设计思路：由原 Ch 14 重构。标量一维理论（弱解、RH、激波/稀疏波）
// 已在 Ch 5 处理，此处仅保留系统情形增量并交叉引用 Ch 5。

//   Section 17.1: Weak Solutions for Systems (系统的弱解与 Rankine-Hugoniot 条件)
//     - 弱解的定义（标量情形见 Ch 5）
//     - RH 条件

//   Section 17.2: Entropy Conditions (熵条件)
//     - 熵不等式
//     - Lax 熵条件与 Oleinik 条件

//   Section 17.3: Riemann Problems (Riemann 问题)
//     - Riemann 问题的定义
//     - 标量情形与系统情形的解

#part("Hyperbolic Equations") // 双曲型方程

= Wave Equation // 波动方程

The wave equation, introduced in Chapter 1 (#link(<def:wave-equation>)[Ch 1]), is the prototypical hyperbolic equation. Its canonical form and general solution in one dimension were obtained in Chapter 2 (#link(<eq:canonical-hyperbolic>)[§2.3]), and its fundamental solution was constructed in Chapter 7 (#link(<ex:fund-wave>)[§7.2]). This chapter develops the complete Cauchy theory: the d'Alembert formula, energy conservation, finite propagation speed, and the Duhamel principle. The qualitative picture is complementary to the heat equation (Part V): the wave equation *propagates* information at finite speed, conserves energy, and does not regularize the data.

== D'Alembert Formula // 达朗贝尔公式

#definition(name: "The One-Dimensional Cauchy Problem")[
  The *Cauchy problem* for the one-dimensional wave equation with speed $c > 0$ is to find $u: [0, oo) times bb(R) -> bb(R)$ with
  $
    partial_t^2 u = c^2 partial_x^2 u quad "in" quad (0, oo) times bb(R), quad u (0, x) = g (x), quad partial_t u (0, x) = h (x),
  $
  where $g, h: bb(R) -> bb(R)$ are the initial displacement and velocity.
] <def:cauchy-wave>

#theorem(name: "D'Alembert's Formula")[
  For $g in C^2 (bb(R))$ and $h in C^1 (bb(R))$, the Cauchy problem has the unique classical solution
  $
    u (t, x) = (g (x + c t) + g (x - c t))/2 + 1/(2 c) integral_(x - c t)^(x + c t) h (s) dif s.
  $
  In particular $u in C^2 ([0, oo) times bb(R))$.
] <thm:d-alembert>

#proof[
  *Step 1: General solution.* By the canonical form of Chapter 2 (#link(<eq:canonical-hyperbolic>)[§2.3]), every $C^2$ solution has the form
  $
    u (t, x) = F (x - c t) + G (x + c t),
  $
  a superposition of a right-moving and a left-moving wave.

  *Step 2: Fit the data.* The initial conditions give
  $
    F (x) + G (x) = g (x), quad -c F' (x) + c G' (x) = h (x).
  $
  Integrating the second equation: $F (x) - G (x) = -1/c integral_0^x h (s) dif s + "const"$. Solving for $F$ and $G$ and substituting $x = x + c t$, $x = x - c t$ yields the formula.
]

#note[
  The two terms in the formula are traveling waves: $F (x - c t)$ moves right with speed $c$ without changing shape, $G (x + c t)$ moves left. The initial velocity $h$ contributes the integral term, whose value at $(t, x)$ depends on $h$ only on the interval $[x - c t, x + c t]$ — the first manifestation of finite propagation speed (§15.4).
]

== Initial and Boundary Value Problems // 初边值问题

#theorem(name: "Poisson's Formula in Three Dimensions")[
  For $n = 3$, the Cauchy problem $partial_t^2 u = Delta u$, $u (0, x) = g (x)$, $partial_t u (0, x) = h (x)$ has the classical solution
  $
    u (t, x) = partial_t (t M_g (x, t)) + t M_h (x, t), quad M_phi (x, t) = 1 / (4 pi t^2) integral_(partial B (x, t)) phi dif S,
  $
  where $M_phi$ is the spherical mean of $phi$ over the sphere of radius $t$. For $g in C^3$, $h in C^2$ this is a $C^2$ solution, and it is unique.
] <thm:poisson-formula-3d>

#proof[
  (Sketch.) The proof uses the method of spherical means. For a solution $u$, the spherical mean $M_u (x, r) = 1/(4 pi r^2) integral_(partial B(x,r)) u (t, dot) dif S$ satisfies the Euler--Poisson--Darboux equation $partial_t^2 M_u = partial_r^2 M_u + (2/r) partial_r M_u$ with $M_u (0, x) = g (x)$, $partial_t M_u (0, x) = h (x)$. Writing $r M_u$ solves the one-dimensional wave equation in $(t, r)$, d'Alembert's formula gives an explicit expression for $M_u$; the identity $u (t, x) = M_u (x, 0^+)$ (the mean over a point is the value) then yields the formula. The regularity follows from differentiating the mean (one derivative on $M_g$ in the $partial_t$ term).
]

#theorem(name: "Kirchhoff's Formula in Two Dimensions")[
  For $n = 2$, the solution of the Cauchy problem is obtained by the *method of descent* from the three-dimensional formula:
  $
    u (t, x) = 1/(2 pi) partial_t integral_(B (x, t)) (g (y))/(sqrt(t^2 - abs(x - y)^2)) dif y + 1/(2 pi) integral_(B (x, t)) (h (y))/(sqrt(t^2 - abs(x - y)^2)) dif y.
  $
] <thm:kirchhoff-formula-2d>

#proof[
  Regard $u$ as a function of three space variables independent of the third coordinate and apply Poisson's formula; the spherical means reduce to integrals over disks with the weight $1/sqrt(t^2 - r^2)$ (the Jacobian of the projection), giving the formula.
]

#note[
  *Boundary value problems on bounded domains.* On a bounded interval (vibrating string) or domain (membrane), the wave equation is supplemented by boundary conditions. The standard tool is separation of variables: writing $u (t, x) = sum_k a_k (t) phi_k (x)$ with the eigenfunctions $phi_k$ of the Dirichlet Laplacian (Chapter 18, §18.1) reduces the problem to decoupled oscillators $a_k'' + lambda_k a_k = 0$. The spectral viewpoint is developed in Chapter 18.
]

== Energy Conservation // 能量守恒

#theorem(name: "Conservation of Energy")[
  Let $u$ be a $C^2$ solution of the wave equation $partial_t^2 u = Delta u$ in $Omega subset bb(R)^n$ with either $u = 0$ or $(partial u)/(partial nu) = 0$ on $partial Omega$. Then the energy
  $
    E (t) = 1/2 integral_Omega (abs(partial_t u)^2 + abs(nabla u)^2) dif x
  $
  is constant in time: $E (t) = E (0)$ for all $t$.
] <thm:wave-energy>

#proof[
  Differentiate under the integral and integrate by parts:
  $
    (dif)/(dif t) E (t) = integral_Omega (partial_t u partial_t^2 u + nabla u dot nabla partial_t u) dif x = integral_Omega partial_t u (partial_t^2 u - Delta u) dif x + integral_(partial Omega) partial_t u (partial u)/(partial nu) dif S = 0,
  $
  the volume term vanishing by the equation and the boundary term by the boundary condition.
]

#corollary(name: "Uniqueness of the Cauchy Problem")[
  Let $u, v$ be $C^2$ solutions of the wave equation on $Omega$ (or on all of $bb(R)^n$ with suitable decay) with the same initial data $u (0, dot) = v (0, dot)$ and $partial_t u (0, dot) = partial_t v (0, dot)$. Then $u = v$.
] <cor:wave-uniqueness>

#proof[
  The difference $w = u - v$ has zero initial data and satisfies the wave equation. By conservation of energy, $E (t) = E (0) = 0$ for all $t$, so $partial_t w = 0$ and $nabla w = 0$; hence $w$ is constant in space-time, and the initial condition gives $w = 0$.
]

== Finite Propagation Speed // 有限传播速度

#theorem(name: "Domain of Dependence")[
  Let $u$ solve the wave equation $partial_t^2 u = Delta u$ in $bb(R)^n$. The value $u (t, x)$ depends only on the initial data in the ball $overline(B (x, c t))$: if $g = tilde(g)$ and $h = tilde(h)$ on $B (x, c t)$, then $u (t, x) = tilde(u) (t, x)$. The *domain of dependence* of $(t, x)$ is $B (x, c t)$; the *domain of influence* of a point $y$ is the cone ${(t, x) : abs(x - y) <= c t}$.
] <thm:domain-of-dependence>

#proof[
  By linearity it suffices to show that data supported outside $B (x, c t)$ do not affect $u (t, x)$. Let $w$ be the solution with data supported in the exterior of $B (x, c t)$. Consider the backward cone $C = {(s, y) : 0 <= s <= t, abs(y - x) <= c (t - s)}$. The energy of $w$ on the time slice $C inter {s = tau}$ is zero at $tau = 0$ (data vanish on $B (x, c t)$); by the same computation as in Theorem 15.3, with the boundary term on the lateral cone vanishing (the normal is characteristic), the energy is non-increasing, hence zero, and $w (t, x) = 0$. For the one-dimensional formula this is immediate from d'Alembert's formula; the argument here is the general energy proof.
]

#note[
  *Huygens' principle.* In odd dimensions $n >= 3$ (in particular $n = 3$), the value $u (t, x)$ depends only on the data on the *sphere* $partial B (x, c t)$ — a sharp wave front with no wake: by Poisson's formula only spherical means enter. In even dimensions (in particular $n = 2$) the data on the whole disk enter (Kirchhoff's formula), producing a trailing wake. This distinction is the physical content of Huygens' principle and its failure in even dimensions.
]

== Duhamel Principle // Duhamel 原理

#theorem(name: "Duhamel's Principle for the Wave Equation")[
  Let $S (t)$ be the solution operator of the homogeneous Cauchy problem with data $(0, h)$: $S (t) h = w (t, dot)$, where $partial_t^2 w = Delta w$, $w (0, dot) = 0$, $partial_t w (0, dot) = h$. Then the solution of the inhomogeneous problem
  $
    partial_t^2 u = Delta u + f, quad u (0, dot) = 0, quad partial_t u (0, dot) = 0,
  $
  is given by
  $
    u (t, x) = integral_0^t S (t - s) f (s, dot) (x) dif s.
  $
  For general data, superpose the homogeneous solution with this formula.
] <thm:duhamel-wave>

#proof[
  Let $w (t, s; x)$ be the solution of the homogeneous problem with $w (s, s; dot) = 0$ and $partial_t w (s, s; dot) = f (s, dot)$, i.e. $w (t, s; dot) = S (t - s) f (s, dot)$. Define $u (t, dot) = integral_0^t w (t, s; dot) dif s$. Then $u (0, dot) = 0$, $partial_t u (0, dot) = w (0, 0; dot) = 0$, and differentiating twice (using $w (t, t; dot) = 0$, $partial_t w (t, t; dot) = f (t, dot)$):
  $
    partial_t^2 u - Delta u = (partial_t w) (t, t; dot) + integral_0^t (partial_t^2 w - Delta w) dif s = f (t, dot),
  $
  since each $w$ is a homogeneous solution. Uniqueness (Theorem 15.3) identifies $u$ as the solution.
]

#note[
  The same principle applies to the heat equation (Chapter 13, §13.2) and to the wave equation with boundary conditions; it reduces inhomogeneous evolution problems to the homogeneous one, provided the solution operator is known. For the wave equation, $S (t)$ is explicitly given by the d'Alembert / Poisson / Kirchhoff formulas.
]

= Linear Hyperbolic Systems // 线性双曲系统

Many physical systems — acoustics, elasticity, electromagnetism — are first-order hyperbolic systems rather than scalar second-order equations. This chapter develops the linear theory: symmetric hyperbolic systems in the sense of Friedrichs, the diagonalization via Riemann invariants, and the energy method for well-posedness.

== Symmetric Hyperbolic Systems // 对称双曲系统

#definition(name: "First-Order Hyperbolic Systems")[
  Let $u: bb(R)^n times [0, oo) -> bb(R)^m$ and $A_1, dots, A_n in bb(R)^(m times m)$. The system
  $
    partial_t u + sum_(j=1)^n A_j partial_(x_j) u = 0
  $
  is *hyperbolic* if for every $xi in bb(R)^n backslash {0}$ the matrix $A (xi) = sum_j xi_j A_j$ has only real eigenvalues and is diagonalizable over $bb(R)$ (a complete set of real eigenvectors). It is *symmetric hyperbolic* (in the sense of Friedrichs) if all $A_j$ are symmetric matrices.
] <def:hyperbolic-system>

#note[
  The wave equation is equivalent to a symmetric hyperbolic system: setting $u = (v, w)$ with $v = partial_t u$, $w = nabla u$, the second-order equation becomes a first-order system whose coefficient matrices are symmetric. More generally, any second-order hyperbolic equation can be reduced this way. The symmetry of the $A_j$ is exactly what makes the energy method (§16.3) work directly.
]

#theorem(name: "Energy Identity for Symmetric Systems")[
  Let $u$ be a $C^1$ solution of a symmetric hyperbolic system on $bb(R)^n$ with constant symmetric $A_j$. Then the energy
  $
    E (t) = 1/2 integral_(bb(R)^n) abs(u (t, x))^2 dif x
  $
  is conserved: $E (t) = E (0)$ for all $t$.
] <thm:symmetric-energy>

#proof[
  Multiply the equation by $u$ (scalar product in $bb(R)^m$) and integrate over $bb(R)^n$:
  $
    1/2 (dif)/(dif t) integral abs(u)^2 dif x = -sum_j integral u dot A_j partial_(x_j) u dif x = -1/2 sum_j integral partial_(x_j) (u dot A_j u) dif x = 0,
  $
  where the second equality uses the symmetry of $A_j$ and the last the divergence theorem with rapid decay (or periodic boundary conditions).
]

== Riemann Invariants // Riemann 不变量

#definition(name: "Riemann Invariants")[
  Consider the one-dimensional system $partial_t u + A partial_x u = 0$ with $A in bb(R)^(m times m)$ diagonalizable: $A = R Lambda R^(-1)$ with $Lambda = "diag"(lambda_1, dots, lambda_m)$ and $R$ the matrix of right eigenvectors. The *characteristic variables* (Riemann invariants)
  $
    w = R^(-1) u, quad w_i = (R^(-1) u)_i,
  $
  satisfy the decoupled transport equations
  $
    partial_t w_i + lambda_i partial_x w_i = 0, quad i = 1, dots, m.
  $
  Hence each $w_i$ is constant along the characteristic lines $x - lambda_i t = "const"$.
] <def:riemann-invariants>

#proof[
  Substituting $u = R w$ into the system and multiplying by $R^(-1)$:
  $
    R^(-1) (R w_t + A R w_x) = w_t + Lambda w_x = 0,
  $
  which is the diagonal system. Each component is a scalar transport equation (Chapter 3, §3.1), solved by $w_i (t, x) = w_i (0, x - lambda_i t)$.
]

#note[
  The Riemann invariants exhibit the hyperbolic structure: the solution is a superposition of $m$ waves, each propagating along its characteristic family with speed $lambda_i$ without interacting (linear case). In the nonlinear case (Chapter 17) the invariants are the building blocks of the solution of the Riemann problem, but the characteristic speeds then depend on the solution.
]

== Energy Methods and Well-Posedness // 能量方法与适定性

#theorem(name: "Energy Inequality and Well-Posedness")[
  Consider the symmetric hyperbolic system with lower-order terms,
  $
    partial_t u + sum_j A_j partial_(x_j) u = B (x) u, quad u (0, dot) = u_0,
  $
  with $A_j$ constant symmetric and $B$ bounded. Then for every $u_0 in L^2 (bb(R)^n; bb(R)^m)$ there is a unique weak solution $u in C ([0, oo); L^2)$, and
  $
    ||u (t)||_(L^2) <= e^(C t) ||u_0||_(L^2), quad C = ||B||_oo + 1.
  $
  In particular the Cauchy problem is well-posed: existence, uniqueness, and continuous dependence on the data.
] <thm:energy-wellposedness>

#proof[
  *Step 1: A priori estimate for smooth solutions.* Multiplying by $u$ as in Theorem 16.1 gives
  $
    1/2 (dif)/(dif t) ||u||_(L^2)^2 = integral u dot B u dif x <= ||B||_oo ||u||_(L^2)^2,
  $
  and Grönwall's inequality yields the estimate $||u (t)||_(L^2) <= e^(||B||_oo t) ||u_0||_(L^2)$.

  *Step 2: Existence.* Mollify the data, $u_0^epsilon = u_0 * rho_epsilon$; the system with smooth data has a smooth solution (by characteristics, since the system is diagonalizable, or by Picard iteration on the semigroup generated by $sum A_j partial_j$). The a priori estimate is uniform in $epsilon$, so a subsequence converges weakly to a weak solution; uniqueness follows from the estimate applied to the difference.
]

#note[
  For systems with *variable* coefficients $A_j (t, x)$, the same energy argument works provided the matrices are symmetric and $C^1$: the derivative of $E$ produces a term $sum_j (partial_(x_j) A_j) u dot u$ bounded by $C E (t)$, giving the exponential bound. This robustness is the reason the energy method is the standard tool for well-posedness of hyperbolic problems (and for the symmetrization of nonlinear systems in Chapter 17).
]

= Conservation Laws for Systems // 守恒律系统

The scalar one-dimensional conservation law was treated completely in Chapter 5 (#link(<def:conservation-law>)[Ch 5]), including weak solutions, the Rankine--Hugoniot condition (#link(<thm:rankine-hugoniot>)[§5.4]), shocks, and rarefaction waves. This chapter covers only the *system* increment: weak solutions and jump conditions for systems, entropy conditions, and the Riemann problem — cross-referencing Chapter 5 for the scalar theory.

== Weak Solutions for Systems // 系统的弱解与 Rankine-Hugoniot 条件

#definition(name: "Systems of Conservation Laws")[
  A *system of conservation laws* in one space dimension is
  $
    partial_t u + partial_x F (u) = 0, quad u: bb(R) times [0, oo) -> bb(R)^m, quad F: bb(R)^m -> bb(R)^m,
  $
  where $u$ is the vector of conserved quantities and $F$ the flux. A *weak solution* satisfies, for every $phi in C_c^1 (bb(R) times [0, oo); bb(R)^m)$,
  $
    integral_0^oo integral_(-oo)^oo (u dot partial_t phi + F (u) dot partial_x phi) dif x dif t = 0
  $
  (componentwise, as in the scalar case of Chapter 5, #link(<def:conservation-law>)[§5.1]).
] <def:conservation-system>

#theorem(name: "Rankine--Hugoniot Condition for Systems")[
  Let $u$ be a piecewise smooth weak solution of a conservation law system with a jump discontinuity across a curve $x = sigma (t)$, and set $s = sigma' (t)$. Then
  $
    s (u_R - u_L) = F (u_R) - F (u_L),
  $
  a vector identity holding componentwise; $s$ is the *shock speed* and $[u] = u_R - u_L$ the jump.
] <thm:rh-systems>

#proof[
  The proof is identical to the scalar case (Chapter 5, #link(<thm:rankine-hugoniot>)[§5.4]): apply the weak formulation with test functions supported in a small neighborhood of a point of the curve, integrate by parts on each smooth side, and let the neighborhood shrink to the curve. Each component of the equation yields the corresponding scalar condition.
]

#note[
  The prototype is the system of isentropic gas dynamics: $u = (rho, rho v)$ with flux $F (rho, rho v) = (rho v, rho v^2 + p (rho))$, where $rho$ is the density, $v$ the velocity, and $p$ the pressure. The system is hyperbolic whenever $p' (rho) > 0$ (sound speed $c (rho) = sqrt(p' (rho)) > 0$).
]

== Entropy Conditions // 熵条件

#definition(name: "Entropy and Entropy Flux")[
  A pair $(eta, q)$ of smooth functions $eta, q: bb(R)^m -> bb(R)$ is an *entropy--entropy flux pair* for $partial_t u + partial_x F (u) = 0$ if $eta$ is convex and
  $
    nabla eta (u) dot nabla F (u) = nabla q (u).
  $
  A weak solution is admissible (an *entropy solution*) if it satisfies the entropy inequality
  $
    partial_t eta (u) + partial_x q (u) <= 0
  $
  in the sense of distributions: $integral (eta (u) partial_t phi + q (u) partial_x phi) dif x dif t >= 0$ for all $0 <= phi in C_c^1$.
] <def:entropy-condition>

#theorem(name: "Lax Entropy Condition")[
  A shock of speed $s$ separating states $u_L$ and $u_R$ is admissible if the characteristic speeds $lambda_k (u) = lambda_k (nabla F (u))$ satisfy
  $
    lambda_k (u_L) >= s >= lambda_k (u_R)
  $
  for the genuinely nonlinear characteristic field $k$ (the $k$-th family of waves); equivalently, characteristics impinge on the shock from both sides. This is the *Lax entropy condition*.
] <thm:lax-entropy>

#note[
  *The Oleinik condition.* For scalar conservation laws with convex flux, the entropy inequality is equivalent to the *Oleinik condition* (Олейник, 1957): for all $a > 0$ and $t > 0$,
  $
    (u (x + a, t) - u (x, t))/a <= C/t,
  $
  a quantitative "no rarefaction-shock interaction" bound that singles out the physically relevant solution (Chapter 5, §5.4). For systems no fully equivalent scalar condition exists; the Lax condition above is the standard admissibility criterion, together with the Liu conditions for general flux.
]

== Riemann Problems // Riemann 问题

#definition(name: "The Riemann Problem")[
  The *Riemann problem* is the conservation law system with piecewise constant initial data
  $
    u (0, x) = cases(u_L, x < 0, u_R, x > 0,)
  $
  for two constant states $u_L, u_R in bb(R)^m$. Its self-similar solution $u (t, x) = v (x/t)$ is the building block of the general theory (front tracking, Godunov-type schemes, Chapter 19).
] <def:riemann-problem>

#theorem(name: "Structure of the Solution for Systems")[
  For a strictly hyperbolic system with genuinely nonlinear or linearly degenerate characteristic fields, the solution of the Riemann problem (for states sufficiently close) consists of a finite number of elementary waves separating constant states:
  - *shocks* (genuinely nonlinear fields, Lax entropy condition);
  - *rarefaction waves* (genuinely nonlinear fields, self-similar continuous transitions);
  - *contact discontinuities* (linearly degenerate fields, jumps with $s = lambda_k (u_L) = lambda_k (u_R)$).
  The solution exists and is unique for $u_L$, $u_R$ sufficiently close; this is the Lax theorem (1957).
] <thm:riemann-structure>

#proof[
  (Sketch.) In the genuinely nonlinear case the $k$-th characteristic field supports exactly two types of elementary waves — shocks (compressive jumps satisfying the Lax condition) and rarefactions (integral curves of the corresponding eigenvector field). For each $k$, the possible states reachable from $u_L$ by a single $k$-wave form a curve $S_k union R_k$ through $u_L$; the solution of the Riemann problem consists of finding intermediate states $u_1, dots, u_(m-1)$ such that $u_(i-1)$ and $u_i$ are connected by an $i$-th wave. The monotonicity of the speeds (genuine nonlinearity) makes the construction a contraction, and the implicit function theorem gives existence and uniqueness for small data. Linearly degenerate fields produce contact discontinuities, along which the characteristic speed is constant.
]

#note[
  For the scalar equation ($m = 1$), the Riemann problem was solved completely in Chapter 5 (#link(<thm:rankine-hugoniot>)[§5.4]): the solution is a shock if $u_L > u_R$ and a rarefaction if $u_L < u_R$ (convex flux). The system case combines these waves, and the entropy condition (Lax or Олейник) selects the admissible configuration. The general existence theory for arbitrary large data — the Glimm scheme and front tracking — is beyond this note (see Analyse Fonctionnelle and the numerical methods of Chapter 19).
]

// ==========================================================================
// Part VII — Methods and Advanced Topics (方法与进阶专题)
// ==========================================================================
// 设计思路：补齐经典 PDE 课程的核心方法——分离变量与谱方法（v0.4.0 缺失，
// 但 Ch 1 已声明其为基本方法），并以数值方法收尾，作为理论与计算的桥梁。
// 粘性解已并入 Ch 4；应用 PDE（流体力学、薛定谔等）归属各专门笔记。

// --- Chapter 18: Separation of Variables and Spectral Methods (分离变量与谱方法) ---
// 设计思路：新增章。Fourier 级数/变换的深层理论 → Analyse Harmonique（交叉引用）。

//   Section 18.1: Separation of Variables (分离变量法)
//     - 齐次/非齐次问题
//     - 特征函数展开

//   Section 18.2: Sturm--Liouville Theory (Sturm--Liouville 理论)
//     - 特征值问题
//     - 正交性与完备性

//   Section 18.3: Applications to the Model Equations (在三大模型方程中的应用)
//     - 热方程、波动方程、Laplace 的分离变量解
//     - 与谱方法、Fourier 方法的联系

// --- Chapter 19: Numerical Methods for PDEs (PDE 数值方法) ---

//   Section 19.1: Finite Difference Methods (有限差分法)
//     - 差分格式（显式、隐式、Crank-Nicolson）
//     - 稳定性与收敛性（Lax 等价定理）

//   Section 19.2: Finite Element Methods (有限元法)
//     - 弱形式到离散格式
//     - 收敛性与误差估计

//   Section 19.3: Finite Volume Methods (有限体积法)
//     - 守恒格式
//     - 在守恒律中的应用

//   Section 19.4: Spectral Methods (谱方法)
//     - 谱离散化
//     - 与 Fourier 方法的联系

#part("Methods and Advanced Topics") // 方法与进阶专题

// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循「基础与分类 → 一阶方程 → 分布与工具 → 椭圆 → 抛物 → 双曲 →
// 方法与专题」的七段式主线，共 7 Part、19 Chapter。
//
// Part I（Ch 1–2，基础与分类）：PDE 基本语言、适定性概念，二阶方程的
//   椭圆/抛物/双曲分类框架与标准形。
//
// Part II（Ch 3–5，一阶方程）：特征线法、Hamilton-Jacobi（含粘性解）、
//   一维守恒律与激波理论。
//
// Part III（Ch 6–7，分布与工具）：测试函数、分布、弱导数、卷积与基本解。
//   Sobolev 空间的深层理论在 Analyse Harmonique 处理（本笔记仅在 Ch 11
//   简述 W^{k,p} 基本性质）。
//
// Part IV（Ch 8–11，椭圆型方程）：Laplace 经典理论 → 边值问题 → Green 函数
//   → 正则性。
//
// Part V（Ch 12–14，抛物型方程）：热方程 → 线性抛物边值问题（半群）→
//   非线性反应-扩散方程。
//
// Part VI（Ch 15–17，双曲型方程）：波动方程 → 线性双曲系统 → 守恒律系统。
//
// Part VII（Ch 18–19，方法与进阶专题）：分离变量与谱方法（新增）、PDE 数值
//   方法概览。
//
// 职责边界：
//   Fourier 理论 → Analyse Harmonique（交叉引用，不重复）
//   Sobolev 空间（深层理论） → Analyse Harmonique（交叉引用）
//   Banach / Hilbert 抽象理论 → Analyse Fonctionnelle（交叉引用）
//   弱形式、Lax-Milgram、Galerkin、变分方法（抽象框架） → Analyse Fonctionnelle（交叉引用）
//   谱理论（抽象部分） → Analyse Fonctionnelle（交叉引用）
//   L^p / 测度论 → Analyse Réelle（交叉引用）
//   Hamilton-Jacobi 的力学应用 → Mécanique analytique（交叉引用）
//   应用 PDE → 各专门笔记（Mécanique quantique, Électrodynamique 等）
//
// 去重记录（相对 v0.4.0）：
//   - Ch 5 完整承载标量一维守恒律；Ch 17 仅保留系统情形增量
//   - 基本解统一在 Ch 7；Ch 10（Green 函数）不再重复构造
//   - D'Alembert 通解在 Ch 2 由标准形导出，Ch 15 给出完整 Cauchy 公式
//   - 比较原理与单调迭代统一在 Ch 13
// ==========================================================================

#bibliography("references.bib")

// 目录
