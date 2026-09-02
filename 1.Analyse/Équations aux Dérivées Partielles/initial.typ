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

// ==========================================================================
// Chapter 3: Classification of Second-Order PDEs (二阶偏微分方程分类)
// ==========================================================================

= Classification of Second-Order PDEs // 二阶偏微分方程分类

The three model equations introduced in #link(<def:laplace-equation>)[Ch 1] — Laplace, heat, and wave — exhibit fundamentally different solution behaviors: harmonic functions are smooth, heat flow is irreversible, and waves propagate at finite speed. This chapter reveals the algebraic invariant behind this trichotomy: the _principal symbol_ of the second-order operator determines the equation type, which in turn governs the geometry of _characteristic surfaces_ and the canonical form to which the equation can be reduced.

== Linear Second-Order Equations // 线性二阶方程

The most general linear second-order PDE for $u: Omega subset bold(R)^n -> bold(R)$ takes the form

#eq[$
  L[u] = sum_(i, j = 1)^n a_(i j)(x) (partial^2 u) / (partial x_i partial x_j) + sum_(i=1)^n b_i(x) (partial u) / (partial x_i) + c(x) u = f(x),
$] <eq:general-2nd-order>

where $a_{i j}, b_i, c, f$ are given functions on $Omega$. By #link(<def:pde-linearity-classification>)[§1], this equation is _linear_: the unknown $u$ and all its derivatives appear to the first power. We assume $a_{i j} = a_{j i}$ throughout (any non-symmetric coefficient matrix can be symmetrized since $u_{x_i x_j} = u_{x_j x_i}$ for $C^2$ solutions).

=== The Coefficient Matrix and Principal Symbol

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
  where $xi = (xi_1, dots, xi_n) in bold(R)^n$. The _full symbol_ of $L$ is $sigma(x, xi) = a(x, xi) + i sum_i b_i(x) xi_i - c(x)$, which incorporates lower-order contributions.
]

The principal symbol captures the highest-order behavior of the operator. Since classification depends only on the leading derivatives, the principal symbol — not the full symbol — determines the equation type.

=== Characteristic Surfaces

The concept of characteristic surfaces generalizes the characteristic curves of first-order PDEs (#link(<def:characteristic-curve>)[§2.1]) to the second-order setting.

#definition(name: "Characteristic Surface")[
  A hypersurface $S subset bold(R)^n$ is a _characteristic surface_ for the operator $L$ if at every point $x in S$, the principal symbol vanishes in the direction of the normal $nu(x)$ to $S$:
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

=== The Characteristic ODE in Two Dimensions

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

The connection to characteristic surfaces (#link(<def:char-surface>)[§3.1]) is direct: the characteristic equation $a (d y)^2 - 2 b dif x dif y + c (d x)^2 = 0$ from #link(<eq:char-ode-2d>)[§3.1] has real solutions if and only if $Delta >= 0$. Thus:
- _Elliptic_: no real characteristic curves (solutions are smooth)
- _Parabolic_: one family of characteristic curves (one degenerate direction)
- _Hyperbolic_: two distinct families of characteristic curves (wave-like propagation)

#example(name: "Classification of Model Equations")[
  We classify the three model equations from #link(<def:laplace-equation>)[Ch 1] using #link(<def:pde-type-2d>)[Definition above].

  *Laplace equation* $u_(x x) + u_(y y) = 0$: Here $a = 1$, $b = 0$, $c = 1$, so $Delta = 0 - 1 = -1 < 0$. The Laplace equation is _elliptic_ everywhere.

  *Heat equation* $u_t - kappa u_(x x) = 0$: With $(x_1, x_2) = (x, t)$, we have $a = -kappa$, $b = 0$, $c = 0$, so $Delta = 0 - 0 = 0$. The heat equation is _parabolic_ everywhere. The characteristic surfaces are $t = text("const")$, consistent with #link(<eq:char-ode-2d>)[§3.1].

  *Wave equation* $u_(t t) - c^2 u_(x x) = 0$: With $(x_1, x_2) = (x, t)$, the coefficient matrix is $A = mat((-c^2, 0), (0, 1))$, so $Delta = 0^2 - (-c^2)(1) = c^2 > 0$. The wave equation is _hyperbolic_ everywhere. The characteristic lines $x +- c t = text("const")$ are the two families found in #link(<eq:char-ode-2d>)[§3.1].
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

  The transport equation $u_t + c u_x = 0$ from #link(<ex:transport-equation>)[§2] is a _first-order_ hyperbolic equation. When viewed as a second-order equation (by differentiating), it satisfies the wave equation $u_(t t) - c^2 u_(x x) = 0$, confirming the consistency between the first-order and second-order classifications.
]

== Canonical Forms and Characteristics // 标准形与特征线

The classification of #link(<def:pde-type-2d>)[§3.2] is not merely a labeling scheme: it determines the _canonical form_ to which any equation of that type can be reduced by a suitable change of variables. The characteristic curves computed in #link(<eq:char-ode-2d>)[§3.1] provide exactly the coordinates needed for this reduction.

We work with the general linear second-order equation in two variables (#link(<eq:general-2d>)[§3.2]):
$
  a u_(x x) + 2 b u_(x y) + c u_(y y) + text("lower-order terms") = f(x, y).
$

=== Hyperbolic Equations

When $Delta = b^2 - a c > 0$, the characteristic ODE #link(<eq:char-ode-2d>)[§3.1] has two distinct real families of solutions:
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
  Computing second derivatives and substituting into #link(<eq:general-2d>)[§3.2], the coefficient of $u_(xi xi)$ is $a phi_x^2 + 2 b phi_x phi_y + c phi_y^2$, which vanishes precisely because $phi = text("const")$ satisfies the characteristic ODE #link(<eq:char-ode-2d>)[§3.1]. Similarly, the coefficient of $u_(eta eta)$ vanishes because $psi = text("const")$ is also a characteristic family. The only surviving second-order term is proportional to $u_(xi eta)$, yielding #link(<eq:canonical-hyperbolic>)[(7)]. The second form follows by a linear change of variables.
]

#example(name: "Wave Equation in Canonical Form")[
  The wave equation $u_(t t) - c^2 u_(x x) = 0$ from #link(<def:wave-equation>)[Ch 1] has $a = -c^2$, $b = 0$, $c_"coeff" = 1$ (with variables $(x, t)$), so $Delta = c^2 > 0$. The characteristic ODE gives:
  $
    -c^2 (d t)^2 + (d x)^2 = 0 quad => quad x +- c t = text("const").
  $
  Setting $xi = x + c t$ and $eta = x - c t$, the wave equation becomes $u_(xi eta) = 0$, which integrates directly to $u = F(xi) + G(eta) = F(x + c t) + G(x - c t)$. This recovers the _d'Alembert formula_: every solution is a superposition of right- and left-traveling waves.
]

=== Parabolic Equations

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

=== Elliptic Equations

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

=== Summary and the Transport Equation Revisited

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
  *The transport equation revisited.* In #link(<ex:transport-equation>)[§2], we noted that the transport equation $u_t + c u_x = 0$ is "the simplest hyperbolic PDE" and promised to revisit it in this chapter. We can now make this precise from the second-order perspective.

  Differentiating $u_t + c u_x = 0$ with respect to $t$ and $x$ yields:
  $
    u_(t t) + c u_(x t) = 0, quad u_(x t) + c u_(x x) = 0.
  $
  Eliminating the mixed derivative gives $u_(t t) - c^2 u_(x x) = 0$: every solution of the transport equation also satisfies the wave equation. The characteristic lines $x - c t = text("const")$ of the transport equation are one of the two characteristic families of the wave equation; the other family $x + c t = text("const")$ corresponds to left-traveling waves, which the transport equation does not see.

  This confirms the classification hierarchy: first-order hyperbolic equations are the "square roots" of second-order hyperbolic equations, and the characteristic structure is consistent across both levels.
]

=== Characteristics of the Three Types: A Visual Comparison

#figure(
  image("img/characteristics-three-types.svg", width: 90%),
  caption: [Characteristic curves for the three types of second-order PDEs. _Left_: Elliptic — no real characteristics (complex conjugate families). _Center_: Parabolic — one degenerate family of parallel lines. _Right_: Hyperbolic — two transverse families of characteristic curves.],
  placement: auto,
  supplement: [Fig.],
) <fig:characteristics-three-types>

The figure above provides a geometric summary of the classification. The characteristic curves (#link(<def:char-surface>)[§3.1]) partition the domain differently for each type:
- *Elliptic*: no real characteristics. Information propagates in all directions equally; solutions are smooth.
- *Parabolic*: one family of characteristics. Information propagates along a single preferred direction (the "time" direction); solutions smooth out in that direction.
- *Hyperbolic*: two transverse families. Information propagates along characteristics; solutions can develop singularities along characteristic curves.

// ==========================================================================
// Part II — Distribution Theory (分布理论)
// ==========================================================================

= Chapter 4: Distribution Theory (分布理论) <sec:ch4-distributions>

The classical theory of PDEs seeks smooth solutions. However, many physically relevant problems — point charges in electrostatics, shock waves, impulse forces — have no classical solution. Distribution theory, introduced by Schwartz in the 1940s, provides a rigorous framework that extends the notion of functions, allows differentiation of non-smooth objects, and supplies the concept of a *fundamental solution* for linear PDEs with constant coefficients.

This chapter develops the foundational tools: test function spaces, distributions, weak derivatives, convolution, and fundamental solutions. These tools are then applied in subsequent chapters to study elliptic, parabolic, and hyperbolic equations.

== Section 4.1: Test Functions and Distributions (测试函数与分布)

The strategy of distribution theory is to transfer derivatives from the unknown function onto smooth "test functions" via integration by parts. This requires a space of test functions with strong regularity and support properties, and a dual space of "generalized functions."

#definition(name: "Space of Test Functions $cal(D)(Omega)$")[
  Let $Omega subset R^n$ be an open set. The space $cal(D)(Omega) = C_c^oo(Omega)$ consists of all infinitely differentiable functions with *compact support* in $Omega$:
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
  For every $a in R^n$ and $r > 0$, there exists a function $phi in cal(D)(R^n)$ such that $phi >= 0$, $"supp"(phi) = overline(B(a, r))$, and $integral phi dif x > 0$.

  #proof[
    Define the auxiliary function:
    $
      f(t) = cases(
        e^(-1/t), t > 0,
        0, t <= 0.
      )
    $
    One verifies by induction that $f in C^oo(R)$ with $f^(k)(0) = 0$ for all $k >= 0$. Now set:
    $
      g(x) = f(r^2 - abs(x - a)^2).
    $
    Then $g in C^oo(R^n)$, $g(x) > 0$ for $abs(x - a) < r$, and $g(x) = 0$ for $abs(x - a) >= r$. Thus $"supp"(g) = overline(B(a, r))$ and $g$ is the desired bump function.
  ]
] <lem:bump-function>

#note[
  The bump function from #link(<lem:bump-function>)[§4.1 Lemma] is the building block for partitions of unity, which are essential for localizing PDE problems and extending local results to global ones.
]

For problems on all of $R^n$, a larger test function space with controlled decay at infinity is more convenient.

#definition(name: "Schwartz Space $cal(S)(R^n)$")[
  The *Schwartz space* $cal(S)(R^n)$ consists of all $phi in C^oo(R^n)$ such that for every pair of multi-indices $alpha, beta$,
  $
    sup_(x in R^n) abs(x^alpha D^beta phi(x)) < oo.
  $
  A sequence $(phi_j)$ converges to $phi$ in $cal(S)(R^n)$ if for all multi-indices $alpha, beta$,
  $
    sup_(x in R^n) abs(x^alpha D^beta(phi_j(x) - phi(x))) -> 0 quad "as" j -> oo.
  $
] <def:test-fn-space-S>

#note[
  The Schwartz space satisfies $cal(D)(R^n) subset cal(S)(R^n) subset C^oo(R^n)$. Functions in $cal(S)$ and all their derivatives decay faster than any polynomial at infinity — this makes $cal(S)$ the natural domain for the Fourier transform (see §4.4).
]

We now define distributions as continuous linear functionals on test functions.

#definition(name: "Distribution")[
  A *distribution* on an open set $Omega subset R^n$ is a continuous linear functional $T: cal(D)(Omega) -> R$. The space of all distributions is denoted $cal(D)'(Omega)$.

  Concretely, $T in cal(D)'(Omega)$ satisfies:
  1. *Linearity*: $T(a phi + b psi) = a T(phi) + b T(psi)$ for all $phi, psi in cal(D)(Omega)$ and $a, b in R$.
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
    Suppose for contradiction that $delta = T_f$ for some $f in L^1_"loc"(R^n)$. Then for all $phi in cal(D)(R^n)$:
    $
      integral_(R^n) f(x) phi(x) dif x = phi(0).
    $
    Choose a sequence of test functions $phi_j in cal(D)(R^n)$ with $"supp"(phi_j) subset B(0, 1/j)$, $0 <= phi_j <= 1$, and $phi_j(0) = 1$ (constructed from the bump function in #link(<lem:bump-function>)[§4.1]). Then:
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

== Section 4.2: Weak Derivatives (弱导数)

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
    By #link(<def:weak-derivative>)[Definition 4.2], $H' = delta$ in the sense of distributions. Note that $delta$ is not a regular distribution (#link(<ex:delta-not-regular>)[Example 4.1]), so $H'$ cannot be represented by any locally integrable function.
  ]
] <ex:weak-heaviside>

#note[
  The Heaviside example is paradigmatic: the weak derivative framework allows us to differentiate discontinuous functions, with the result being a _distribution_ (not necessarily a function). This is impossible in classical analysis. For PDE theory, this means we can seek solutions in distribution spaces, dramatically enlarging the class of admissible solutions. The systematic study of function spaces built on weak derivatives — Sobolev spaces — is developed in Analyse Harmonique and Analyse Fonctionnelle; here we only establish the distribution-theoretic foundation.
]

== Section 4.3: Convolution and Approximation (卷积与逼近)

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

== Section 4.4: Fundamental Solutions (基本解)

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

If $E$ is a fundamental solution, then for any $f in cal(D)(bb(R)^n)$ the convolution $u = E * f$ satisfies $P(partial) u = f$ in the sense of distributions (see #link(<def:conv-distribution>)[Definition 4.5]). This reduces solving a PDE to computing a convolution — provided the fundamental solution is known.

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
  where $omega_n = 2 pi^(n/2) / Gamma(n/2)$ is the surface area of the unit sphere $S^(n-1) subset R^n$.

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
  where $H$ is the Heaviside function (#link(<ex:weak-heaviside>)[Example 4.2]). The support of $E$ is the forward light cone ${(t, x) : t >= abs(x)}$.

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
  The three fundamental solutions reveal fundamentally different propagation behaviors, reflecting the classification of Chapter 3:

  - *Laplace* ($Delta$): $E$ is supported on _all_ of $R^n$ — elliptic equations have infinite propagation in all directions; disturbances are felt everywhere instantaneously.
  - *Heat* ($partial_t - Delta$): $E$ is supported on ${t >= 0}$ — parabolic equations have infinite spatial propagation speed but respect the arrow of time (irreversibility).
  - *Wave* ($partial_t^2 - Delta$): $E$ is supported on the forward light cone ${t >= abs(x)}$ — hyperbolic equations respect finite propagation speed and causality.

  Moreover, the wave fundamental solution reveals a striking dimensional dichotomy: for odd $n$, $E$ is supported on the _surface_ of the light cone (sharp signals — the *strong Huygens' principle*); for even $n$, $E$ fills the _interior_ (after-effects — the *weak Huygens' principle*). This is explored in detail in Chapter 12.
]

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
