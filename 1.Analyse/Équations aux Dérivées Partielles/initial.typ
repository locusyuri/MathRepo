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
  version: "v0.4.0",
  extra-info: "This is a notebook for partial differential equations.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
// 主线：基础分类 → 分布理论 → 椭圆 → 抛物 → 双曲 → 进阶专题
// 共 6 Part、15 Chapter。
//
// 职责边界：
//   - Fourier 理论 → Analyse Harmonique（交叉引用）
//   - Sobolev 空间 → Analyse Harmonique（交叉引用）
//   - Banach / Hilbert 抽象理论 → Analyse Fonctionnelle（交叉引用）
//   - 弱形式、Lax-Milgram、Galerkin、变分方法 → Analyse Fonctionnelle（交叉引用）
//   - 谱理论（抽象部分） → Analyse Fonctionnelle（交叉引用）
//   - L^p / 测度论 → Analyse Réelle（交叉引用）
//   - Hamilton-Jacobi 的力学应用 → Mécanique analytique（交叉引用）

// ==========================================================================
// Part I — Foundations and Classification (基础与分类)
// ==========================================================================
// 设计思路：建立 PDE 的基本语言、适定性概念和分类框架。
// Ch 2 完整处理一阶 PDE 理论（特征线法、Hamilton-Jacobi、守恒律）。
// 对应教材：通常占据 PDE 教材的前 2-3 章。

= Introduction to PDEs // 偏微分方程导论

== Basic Concepts and Examples // 基本概念与例子

A *partial differential equation (PDE)* is an equation involving an unknown function of several variables and its partial derivatives. Formally, a PDE of order $m$ takes the form:

#definition(name: "Partial Differential Equation")[
  A *partial differential equation* of order $m$ is an equation of the form
  $
    F(x, u, nabla u, nabla^2 u, dots, nabla^m u) = 0,
  $
  where $x in Omega subset R^n$, $Omega$ is an open set, $u: Omega -> R$ is the unknown function, and $nabla^k u$ denotes all partial derivatives of order $k$ of $u$. Here $F$ is a given function.
] <def:pde>

To express partial derivatives systematically, we use multi-index notation.

#definition(name: "Multi-Index Notation")[
  A *multi-index* $alpha = (alpha_1, dots, alpha_n) in Z_+^n$ is an $n$-tuple of non-negative integers. We define the order $abs(alpha)$ and the corresponding derivative operator $D^alpha$ by:
] <def:multi-index>

#eq[$
  |alpha| &= alpha_1 + alpha_2 + dots + alpha_n, \
  D^alpha u &= (partial^(|alpha|) u) / (partial x_1^(alpha_1) partial x_2^(alpha_2) dots partial x_n^(alpha_n)) = partial^(alpha_1)_(x_1) partial^(alpha_2)_(x_2) dots partial^(alpha_n) u.
$] <eq:multi-index>

Using this notation, a general PDE of order $m$ can be written as:
$
  F(x, u, (D^alpha u)_(|alpha| <= m)) = 0.
$

#definition(name: "Order of PDE")[
  The *order* of a PDE is the highest order of the partial derivatives appearing in the equation.
] <def:pde-order>

PDEs are classified according to their linearity properties:

#definition(name: "Classification of PDEs by Linearity")[
  Consider a PDE of the form $F(x, u, nabla u, nabla^2 u, dots, nabla^m u) = 0$.

  1. The PDE is *linear* if $F$ is linear in $u$ and all its partial derivatives, i.e.,
    $
      F(x, u, nabla u, dots) = sum_(|alpha| <= m) a_alpha(x) D^alpha u - f(x),
    $
    where coefficients $a_alpha(x)$ depend only on $x$.

  2. The PDE is *semilinear* if it is linear in the highest-order derivatives but nonlinear in lower-order derivatives:
    $
      sum_(|alpha| = m) a_alpha(x) D^alpha u = f(x, u, (D^beta u)_(|beta| < m)).
    $

  3. The PDE is *quasilinear* if it is linear in the highest-order derivatives but coefficients may depend on the function and lower-order derivatives:
    $
      sum_(|alpha| = m) a_alpha(x, u, (D^beta u)_(|beta| < m)) D^alpha u = f(x, u, (D^beta u)_(|beta| < m)).
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
  A *boundary value problem* consists of a PDE in a domain $Omega subset R^n$ together with conditions on the boundary $partial Omega$.
] <def:bvp>

The three most common boundary conditions are:

#definition(name: "Boundary Conditions")[
  Let $Omega subset R^n$ be a domain with boundary $partial Omega$, and $bold(n)$ the outward unit normal. The three classical boundary conditions are:

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
  This stands in sharp contrast to the backward heat equation (#link(<ex:backward-heat-ill-posed>)[Example above]), where the same estimate fails catastrophically. The full proof requires energy methods developed in #link(<def:heat-equation>)[Ch 9].
] <prop:heat-well-posed>

#caution(title: "Importance of Well-Posedness")[
  Well-posedness is essential for a PDE to model a physical phenomenon correctly. An ill-posed problem indicates either an incomplete mathematical model or inappropriate auxiliary conditions. In numerical computations, ill-posed problems lead to unstable algorithms that amplify errors.
]

#note[
  While well-posedness is crucial for most applications, some important problems in inverse problems, imaging, and control theory are inherently ill-posed. In such cases, regularization techniques are used to obtain stable approximate solutions.
]

// ==========================================================================
// Chapter 2: First-Order PDEs (一阶偏微分方程)
// ==========================================================================

= First-Order PDEs // 一阶偏微分方程

The theory of first-order PDEs is built around a single unifying idea: _characteristic curves_ along which a PDE reduces to a system of ODEs. This chapter develops the method of characteristics in full generality and applies it to quasilinear equations, Hamilton--Jacobi equations, and conservation laws.

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

=== Characteristic Equations

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
  The transport equation is closely related to the wave equation #link(<def:wave-equation>)[Ch 1]: it is the simplest hyperbolic PDE and serves as a building block for understanding wave propagation. We will revisit it in Ch 3 when we classify second-order PDEs.
]

The example above illustrates the general strategy: (1) write down the characteristic equations (#link(<eq:char-system>)[2]); (2) solve the ODE system; (3) use the initial data to determine the solution. We formalize this procedure in §2.2.

#note[
  Although we have presented the theory for two independent variables, the method extends directly to $n$ variables. The characteristic system for a first-order PDE in $n$ independent variables consists of $n + 1$ ODEs, and the same geometric ideas apply.
]

== Method of Characteristics // 特征线法

We now formalize the procedure illustrated in §2.1 into a systematic method for solving the Cauchy problem for first-order PDEs.

=== The Cauchy Problem

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

=== Solving via Characteristics

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

=== The Transversality Condition

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

=== Breakdown of Classical Solutions

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
  After the breaking time $t^"break"$, the solution must be continued as a _weak solution_ that admits discontinuities (shocks). The theory of weak solutions and shock conditions is developed in §2.4.
]

#note[
  #figure(
    image("./img/characteristics-crossing.svg", width: 70%),
    caption: [Characteristic curves in the $x t$-plane for Burgers' equation $u_t + u u_x = 0$ with decreasing initial data. The characteristics converge and intersect at the breaking time $t^"break"$, where the classical solution develops a gradient catastrophe.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:characteristics-crossing>
]

== Hamilton--Jacobi Equations // Hamilton--Jacobi 方程

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

=== The Characteristic System for Hamilton--Jacobi

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

=== Connection to Classical Mechanics

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

== Conservation Laws in One Space Dimension // 一维守恒律

We now apply the method of characteristics to an important class of nonlinear first-order PDEs arising in fluid dynamics, traffic flow, and gas dynamics.

=== Derivation of Conservation Laws

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

=== Solution by Characteristics

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

=== Traveling Wave Solutions

When the flux function is linear, $f(u) = c u$, the conservation law reduces to the transport equation and the solution is a traveling wave. For nonlinear flux, we can still look for special solutions.

#definition(name: "Traveling Wave Solution")[
  A _traveling wave solution_ of the conservation law is a solution of the form $u(x, t) = phi(x - v t)$ for some profile function $phi$ and wave speed $v$. Substituting into $u_t + f'(u) u_x = 0$:
  $
    -v phi' + f'(phi) phi' = 0 => (f'(phi) - v) phi' = 0.
  $
  Either $phi' = 0$ (constant solution) or $f'(phi) = v$ (constant speed). For a _shock wave_ (discontinuous traveling wave), the speed is determined by the Rankine--Hugoniot condition.
] <def:traveling-wave>

=== The Rankine--Hugoniot Condition

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
// Part II — Distribution Theory (分布理论)
// ==========================================================================

// --- Chapter 3: Classification of Second-Order PDEs (二阶偏微分方程分类) ---

// 设计思路：建立椭圆/抛物/双曲三分体系，为后续三 Part 提供框架。

//   Section 3.1: Linear Second-Order Equations (线性二阶方程)
//     - 一般线性二阶算子的标准记号
//     - 主象征 (principal symbol)

//   Section 3.2: Elliptic, Parabolic, Hyperbolic Types (椭圆型、抛物型与双曲型)
//     - 判别准则
//     - 典型模型方程归类

//   Section 3.3: Canonical Forms and Characteristics (标准形与特征)
//     - 化简为标准形的方法
//     - 特征曲线与特征面的几何意义

// ==========================================================================
// Part II — Distribution Theory (分布理论)
// ==========================================================================
// 设计思路：为后续三类方程提供广义函数与基本解的语言基础。
// 本 Part 仅包含分布理论——PDE 中最基本的广义函数工具。
// Sobolev 空间、弱形式、变分方法、谱理论等内容
// 分别在 Analyse Harmonique 和 Analyse Fonctionnelle 中处理，
// 本笔记通过交叉引用使用这些工具。

// --- Chapter 4: Distribution Theory (分布理论) ---

//   Section 4.1: Test Functions and Distributions (测试函数与分布)
//     - 测试函数空间 D, S
//     - 分布的定义与例子

//   Section 4.2: Weak Derivatives (弱导数)
//     - 弱导数的定义
//     - 与经典导数的关系

//   Section 4.3: Convolution and Approximation (卷积与近似恒等)
//     - 分布的卷积
//     - 磨光算子 (mollifier)

//   Section 4.4: Fundamental Solutions (基本解)
//     - 基本解的定义
//     - Laplace、热传导、波动算子的基本解

// ==========================================================================
// Part III — Elliptic Equations (椭圆型方程)
// ==========================================================================
// 设计思路：从 Laplace 方程的经典理论出发，逐步过渡到
// 一般椭圆方程的弱解理论和正则性。
// 弱形式与 Sobolev 空间工具参见 Analyse Harmonique 和
// Analyse Fonctionnelle 中的相关章节。
// 与 Analyse Complexe Ch 18 的边界：复分析笔记从全纯函数角度
// 处理调和函数；本笔记从 PDE 角度（弱解、正则性）。

// --- Chapter 5: Laplace's Equation and Harmonic Functions (拉普拉斯方程与调和函数) ---

//   Section 5.1: Laplace's and Poisson's Equations (拉普拉斯方程与泊松方程)
//     - 方程的导出与物理背景
//     - 基本性质

//   Section 5.2: Mean Value Property (平均值性质)
//     - 球面平均值与球体平均值
//     - 逆命题

//   Section 5.3: Maximum and Minimum Principles (最大值与最小值原理)
//     - 弱最大值原理
//     - 强最大值原理
//     - Hopf 引理

//   Section 5.4: Green's Identities (格林恒等式)
//     - 第一与第二格林恒等式
//     - 在唯一性证明中的应用

// --- Chapter 6: Boundary Value Problems for Elliptic Equations (椭圆型方程边值问题) ---

//   Section 6.1: Dirichlet Problem (狄利克雷问题)
//     - 弱形式与 Lax-Milgram 应用
//     - 存在性与唯一性

//   Section 6.2: Neumann Problem (纽曼问题)
//     - 弱形式
//     - 相容性条件

//   Section 6.3: Robin and Mixed Conditions (Robin 与混合边界条件)
//     - Robin 边界条件的弱形式
//     - 混合边界条件的处理

//   Section 6.4: Uniqueness via Energy Methods (能量方法的唯一性)
//     - 能量积分方法
//     - 与最大值原理的互补

// --- Chapter 7: Green Functions and Representation (格林函数与表示) ---

//   Section 7.1: Fundamental Solutions of Elliptic Operators (椭圆算子的基本解)
//     - 全空间基本解的构造
//     - Newton 位势

//   Section 7.2: Green's Function Construction (格林函数的构造)
//     - 有界区域上的 Green 函数
//     - 镜像法

//   Section 7.3: Representation Formulas (表示公式)
//     - 用 Green 函数表示解
//     - Poisson 积分公式

//   Section 7.4: Method of Images and Conformal Mapping (镜像法与保角映射)
//     - 特殊区域的 Green 函数
//     - 与复分析方法的联系（参见 Analyse Complexe）

// --- Chapter 8: Regularity Theory (正则性理论) ---

//   Section 8.1: Interior Regularity (内正则性)
//     - W^{2,p} 内估计
//     - 椭圆正则性定理

//   Section 8.2: Boundary Regularity (边界正则性)
//     - 边界附近的正则性
//     - 区域光滑性的要求

//   Section 8.3: Schauder Estimates (Schauder 估计)
//     - Hölder 空间中的估计
//     - Schauder 定理

//   Section 8.4: L^p Estimates and Calderón-Zygmund Theory (L^p 估计与 Calderón-Zygmund 理论)
//     - Calderón-Zygmund 奇异积分
//     - L^p 正则性

// ==========================================================================
// Part IV — Parabolic Equations (抛物型方程)
// ==========================================================================
// 设计思路：以热方程为核心模型，建立抛物型方程的
// 存在性、唯一性、正则性和长期行为理论。
// 半群理论作为统一框架自然嵌入 Ch 10。

// --- Chapter 9: Heat Equation (热方程) ---

//   Section 9.1: Heat Kernel and Fundamental Solution (热核与基本解)
//     - 热核的导出与性质
//     - 基本解

//   Section 9.2: Cauchy Problem (Cauchy 问题)
//     - 初值问题的解
//     - 正则化效应

//   Section 9.3: Maximum Principle (最大值原理)
//     - 弱最大值原理
//     - 强最大值原理

//   Section 9.4: Energy Estimates and Smoothing Effect (能量估计与平滑效应)
//     - 能量不等式
//     - 无穷次光滑效应

// --- Chapter 10: Linear Parabolic Boundary Value Problems (线性抛物型边值问题) ---

//   Section 10.1: Dirichlet and Neumann Problems (狄利克雷与纽曼问题)
//     - 弱形式与存在性
//     - Galerkin 逼近

//   Section 10.2: Semigroup Framework (半群框架)
//     - C_0 半群与无穷小生成元
//     - 热方程的半群解释

//   Section 10.3: Comparison Principles (比较原理)
//     - 上下解比较
//     - 正性保持

//   Section 10.4: Long-Time Behavior (长期行为)
//     - 指数衰减
//     - 与椭圆问题的联系

// --- Chapter 11: Nonlinear Parabolic Equations (非线性抛物型方程) ---

//   Section 11.1: Reaction-Diffusion Equations (反应-扩散方程)
//     - 一般框架
//     - 局部存在性

//   Section 11.2: Fisher-KPP Equation (Fisher-KPP 方程)
//     - 行波解
//     - 传播速度

//   Section 11.3: Blow-Up and Global Existence (爆破与整体存在)
//     - 爆破判据
//     - 整体存在条件

//   Section 11.4: Monotone Iteration Methods (单调迭代法)
//     - 上下解方法
//     - 迭代格式与收敛

// ==========================================================================
// Part V — Hyperbolic Equations (双曲型方程)
// ==========================================================================
// 设计思路：以波动方程为核心，建立双曲型方程的
// 经典理论和现代守恒律理论。

// --- Chapter 12: Wave Equation (波动方程) ---

//   Section 12.1: D'Alembert Formula (达朗贝尔公式)
//     - 一维波动方程的通解
//     - 行波解释

//   Section 12.2: Initial and Boundary Value Problems (初边值问题)
//     - Cauchy 问题（高维）
//     - 有界区域上的边值问题

//   Section 12.3: Energy Conservation (能量守恒)
//     - 能量恒等式
//     - 在唯一性证明中的应用

//   Section 12.4: Finite Propagation Speed (有限传播速度)
//     - 依赖区域
//     - 影响区域

//   Section 12.5: Duhamel Principle (Duhamel 原理)
//     - 非齐次方程的求解
//     - 与齐次问题的化归

// --- Chapter 13: Linear Hyperbolic Systems (线性双曲系统) ---

//   Section 13.1: Symmetric Hyperbolic Systems (对称双曲系统)
//     - Friedrichs 对称正系统
//     - 能量估计

//   Section 13.2: Riemann Invariants (Riemann 不变量)
//     - 对角化方法
//     - 不变量的构造

//   Section 13.3: Energy Methods and Well-Posedness (能量方法与适定性)
//     - 能量不等式
//     - 适定性证明

// --- Chapter 14: Nonlinear Conservation Laws (非线性守恒律) ---

//   Section 14.1: Weak Solutions (弱解)
//     - 弱解的定义
//     - Rankine-Hugoniot 条件

//   Section 14.2: Shock Waves and Rarefaction Waves (激波与稀疏波)
//     - 激波的形成
//     - 稀疏波（中心稀疏波）

//   Section 14.3: Entropy Conditions (熵条件)
//     - 熵不等式
//     - Lax 熵条件与 Oleinik 条件

//   Section 14.4: Riemann Problems (Riemann 问题)
//     - Riemann 问题的定义
//     - 标量情形与系统情形的解

// ==========================================================================
// Part VI — Advanced Topics (进阶专题)
// ==========================================================================
// 设计思路：精选数值方法作为理论与计算的桥梁。
// 非线性 PDE 的高级主题（粘性解等）分散在 Part IV 和 Part V 中处理。
// 应用 PDE（流体力学、薛定谔等）归属各专门笔记。

// --- Chapter 15: Numerical Methods for PDEs (PDE 数值方法) ---

//   Section 15.1: Finite Difference Methods (有限差分法)
//     - 差分格式（显式、隐式、Crank-Nicolson）
//     - 稳定性与收敛性（Lax 等价定理）

//   Section 15.2: Finite Element Methods (有限元法)
//     - 弱形式到离散格式
//     - 收敛性与误差估计

//   Section 15.3: Finite Volume Methods (有限体积法)
//     - 守恒格式
//     - 在守恒律中的应用

//   Section 15.4: Spectral Methods (谱方法)
//     - 谱离散化
//     - 与 Fourier 方法的联系

// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循"基础分类 → 分布理论 → 椭圆 → 抛物 → 双曲 → 进阶"的
// 六段式主线，共 6 Part、15 Chapter。
//
// Part I（Ch 1-3，基础与分类）：建立 PDE 基本语言、适定性概念，
//   完整处理一阶 PDE 理论（特征线法、Hamilton-Jacobi、守恒律），
//   以及二阶方程的椭圆/抛物/双曲三分框架。
//
// Part II（Ch 4，分布理论）：PDE 中最基本的广义函数工具——
//   测试函数、分布、弱导数、卷积与基本解。
//   Sobolev 空间、弱形式与变分方法、谱理论等更高级的工具
//   分别在 Analyse Harmonique 和 Analyse Fonctionnelle 中处理。
//
// Part III（Ch 5-8，椭圆型方程）：从 Laplace 方程的经典调和函数理论
//   到一般椭圆方程的弱解、Green 函数和正则性理论。
//
// Part IV（Ch 9-11，抛物型方程）：以热方程为核心，建立最大值原理、
//   能量估计、半群框架，并推广到非线性反应-扩散方程。
//
// Part V（Ch 12-14，双曲型方程）：从波动方程的 d'Alembert 公式和
//   能量守恒到线性双曲系统，最终到非线性守恒律和激波理论。
//
// Part VI（Ch 15，进阶专题）：PDE 数值方法概览（有限差分、有限元、
//   有限体积、谱方法）。
//
// 职责边界：
//   Fourier 理论 → Analyse Harmonique（交叉引用，不重复）
//   Sobolev 空间 → Analyse Harmonique（交叉引用）
//   Banach / Hilbert 抽象理论 → Analyse Fonctionnelle（交叉引用）
//   弱形式、Lax-Milgram、Galerkin、变分方法 → Analyse Fonctionnelle（交叉引用）
//   谱理论（抽象部分） → Analyse Fonctionnelle（交叉引用）
//   L^p / 测度论 → Analyse Réelle（交叉引用）
//   Hamilton-Jacobi 的力学应用 → Mécanique analytique（交叉引用）
//   应用 PDE → 各专门笔记（Mécanique quantique, Électrodynamique 等）
// ==========================================================================

#bibliography("references.bib")

// 目录
