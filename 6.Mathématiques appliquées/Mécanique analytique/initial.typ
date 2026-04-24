#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Mécanique Analytique", // 理论力学
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Mécanique Analytique",
  "Violet",
  subtitle: "A notebook for mechanics",
  institute: "Notiz Physique",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This is a notebook for mechanics.",
)

#make-outline(depth: 2, title: "Contents")


#part("Mathematical Foundations") // 数学基础

= Variational Calculus  // 变分法
== Functionals and Variations // 泛函与变分

In analytical mechanics, we optimize objects whose input is a whole function (or path), not a finite-dimensional vector.
This leads naturally from ordinary calculus to variational calculus.

#note[
  We only introduce the functional-analytic language needed for mechanics here.
  A systematic treatment of linear functionals, Banach/Hilbert spaces, and weak topologies is deferred to the Functional Analysis notebook.
]

=== Functionals and Admissible Curves

Let $X$ be a space of functions. A functional is a map
$
  J: X -> bb(R)
$
assigning a real number to each admissible function.


In mechanics, a standard example is

$
  J[q] = integral_a^b L(t, q(t), dot(q)(t)) dif t,
$

where $L$ is the Lagrangian and $q$ is an admissible trajectory.

#definition(name: "Admissible Variation")[
  Let $q$ be an admissible curve with fixed endpoints $q(a)=q_a$, $q(b)=q_b$.
  A variation of $q$ is a family

  $
    q_epsilon(t) = q(t) + epsilon eta(t),
  $

  where $eta(a)=eta(b)=0$ and $eta$ is sufficiently smooth.
]

=== First Variation

#definition(name: "First Variation")[
  The first variation of $J$ at $q$ along $eta$ is

  $
    delta J[q; eta] = lr(frac(dif, dif epsilon) J[q + epsilon eta]|)_(epsilon=0).
  $

  A curve $q$ is called *stationary* if $delta J[q; eta] = 0$ for every admissible $eta$.
]

For

$
  J[q] = integral_a^b L(t, q, dot(q)) dif t,
$

direct differentiation gives

$
  delta J[q; eta] = integral_a^b ( frac(partial L, partial q) eta + frac(partial L, partial dot(q)) dot(eta) ) dif t.
$

After integration by parts and using $eta(a)=eta(b)=0$,

$
  delta J[q; eta] = integral_a^b ( frac(partial L, partial q) - frac(dif, dif t) frac(partial L, partial dot(q)) ) eta(t) dif t.
$

#theorem(name: "Stationarity Criterion")[
  If $q$ is stationary for all endpoint-fixed variations, then

  $
    frac(partial L, partial q) - frac(dif, dif t) frac(partial L, partial dot(q)) = 0,
  $

  which is the Euler-Lagrange equation.
]

=== Simple Example: Shortest Curve in the Plane

#example[
  Consider

  $
    J[y] = integral_(x_0)^(x_1) sqrt(1 + (y')^2) dif x
  $

  with fixed endpoints $y(x_0)=y_0$, $y(x_1)=y_1$.
  Here $L(y, y') = sqrt(1 + (y')^2)$ does not depend explicitly on $y$, so

  $
    frac(dif, dif x) frac(partial L, partial y') = 0
  $

  implies $frac(partial L, partial y')$ is constant, hence $y' = C$.
  Therefore the stationary curve is a line segment.
]

This variational viewpoint is the direct bridge to Hamilton's principle and the full Lagrangian formalism.

== Euler-Lagrange Equation // 欧拉-拉格朗日方程

The Euler-Lagrange equation is the local differential form of stationarity for the action functional.
It turns a global variational statement into equations of motion.

#definition(name: "Euler-Lagrange Equation (Single Coordinate)")[
  For

  $
    J[q] = integral_a^b L(t, q, dot(q)) dif t,
  $

  with fixed endpoints $q(a), q(b)$, a stationary curve satisfies

  $
    frac(partial L, partial q) - frac(dif, dif t) frac(partial L, partial dot(q)) = 0.
  $
]

=== Derivation from First Variation

Starting from

$
  delta J[q; eta] = integral_a^b ( frac(partial L, partial q) eta + frac(partial L, partial dot(q)) dot(eta) ) dif t,
$

integration by parts gives

$
  delta J[q; eta] = lr(frac(partial L, partial dot(q)) eta|)_a^b + integral_a^b ( frac(partial L, partial q) - frac(dif, dif t) frac(partial L, partial dot(q)) ) eta dif t.
$

Because endpoint-fixed variations satisfy $eta(a)=eta(b)=0$, the boundary term vanishes.
By the fundamental lemma of variational calculus, the integrand must be zero, yielding the Euler-Lagrange equation.

=== Multi-Coordinate Form

#theorem(name: "Euler-Lagrange System")[
  For generalized coordinates $q_1, dots, q_n$ and

  $
    S[q] = integral_(t_0)^(t_1) L(t, q_1, dots, q_n, dot(q)_1, dots, dot(q)_n) dif t,
  $

  stationarity under endpoint-fixed variations implies, for each $i=1,dots,n$,

  $
    frac(dif, dif t) frac(partial L, partial dot(q)_i) - frac(partial L, partial q_i) = 0.
  $
]

=== Natural Boundary Conditions (Free Endpoints)

#note[
  If an endpoint is free, the boundary term does not automatically vanish.
  One then obtains a natural boundary condition, typically
  $frac(partial L, partial dot(q)) = 0$ at that free endpoint (or its constrained variant).
]

=== First Integrals and Cyclic Coordinates

#proposition(name: "Cyclic Coordinate")[
  If $frac(partial L, partial q_k) = 0$, then

  $
    frac(dif, dif t) frac(partial L, partial dot(q)_k) = 0,
  $

  so the conjugate momentum
  $
    p_k = frac(partial L, partial dot(q)_k)
  $
  is conserved.
]

#proposition(name: "Energy Integral (Autonomous Case)")[
  If $L$ has no explicit $t$-dependence, then

  $
    E = sum_i dot(q)_i frac(partial L, partial dot(q)_i) - L
  $

  is constant along solutions.
]

=== Example: Particle in a Potential

#example[
  Let

  $
    L(q, dot(q)) = frac(1,2) m dot(q)^2 - V(q).
  $

  Then
  $
    frac(partial L, partial dot(q)) = m dot(q),
  $
  and
  $
    frac(partial L, partial q) = -frac(dif V, dif q).
  $

  The Euler-Lagrange equation becomes

  $
    m frac(dif^2 q, dif t^2) + frac(dif V, dif q) = 0,
  $

  i.e. Newton's equation $m dot.double(q) = -frac(dif V, dif q)$.
]

This section provides the variational core used in the next chapters on Lagrange's equations, constraints, and Hamiltonian reformulation.

= Generalized Coordinates and Constraints // 广义坐标与约束

#part("Lagrangian Mechanics") // 拉格朗日力学

= Lagrange's Equations // 拉格朗日方程

#part("Hamiltonian Mechanics") // 哈密顿力学

#part("Advanced Topics") // 进阶主题


// 目录

// --- Part I: Mathematical Foundations (数学基础) ---

// Chapter 1: Variational Calculus (变分法)
//   Section 1.1: Functionals and Variations (泛函与变分)
//   Section 1.2: Euler-Lagrange Equation (欧拉-拉格朗日方程)
//   Section 1.3: First Integrals and Conservation Laws (首次积分与守恒律)
//   Section 1.4: Variational Problems with Constraints (带约束的变分问题)
//   Section 1.5: Multi-variable Variational Problems (多元变分问题)
//   Section 1.6: Hamilton's Principle (哈密顿原理)

// Chapter 2: Generalized Coordinates and Constraints (广义坐标与约束)
//   Section 2.1: Degrees of Freedom and Generalized Coordinates (自由度与广义坐标)
//   Section 2.2: Holonomic and Non-holonomic Constraints (完整约束与非完整约束)
//   Section 2.3: Virtual Displacements and Virtual Work (虚位移与虚功)
//   Section 2.4: D'Alembert's Principle (达朗贝尔原理)

// --- Part II: Lagrangian Mechanics (拉格朗日力学) ---

// Chapter 3: Lagrange's Equations (拉格朗日方程)
//   Section 3.1: Lagrangian Function (拉格朗日函数)
//   Section 3.2: Derivation from Hamilton's Principle (从哈密顿原理推导)
//   Section 3.3: Lagrange's Equations of the Second Kind (第二类拉格朗日方程)
//   Section 3.4: Generalized Forces (广义力)
//   Section 3.5: Lagrange's Equations with Constraints (带约束的拉格朗日方程)
//   Section 3.6: Lagrange Multipliers in Mechanics (力学中的拉格朗日乘子)

// Chapter 4: Conservation Laws in Lagrangian Mechanics (拉格朗日力学中的守恒律)
//   Section 4.1: Cyclic Coordinates and Generalized Momenta (循环坐标与广义动量)
//   Section 4.2: Energy Conservation (能量守恒)
//   Section 4.3: Noether's Theorem (诺特定理)
//   Section 4.4: Momentum Conservation and Translational Symmetry (动量守恒与平移对称性)
//   Section 4.5: Angular Momentum Conservation and Rotational Symmetry (角动量守恒与旋转对称性)

// Chapter 5: Applications of Lagrangian Mechanics (拉格朗日力学的应用)
//   Section 5.1: Central Force Motion (中心力运动)
//   Section 5.2: Rigid Body Dynamics (刚体动力学)
//   Section 5.3: Small Oscillations (小振动)
//   Section 5.4: Normal Modes and Eigenfrequencies (简正模与本征频率)
//   Section 5.5: Coupled Oscillators (耦合振子)

// --- Part III: Hamiltonian Mechanics (哈密顿力学) ---

// Chapter 6: Hamilton's Equations (哈密顿方程)
//   Section 6.1: Legendre Transformation (勒让德变换)
//   Section 6.2: Hamiltonian Function (哈密顿函数)
//   Section 6.3: Canonical Equations of Motion (正则运动方程)
//   Section 6.4: Hamiltonian for Common Systems (常见系统的哈密顿量)
//   Section 6.5: Phase Space and Phase Portraits (相空间与相图)

// Chapter 7: Canonical Transformations (正则变换)
//   Section 7.1: Generating Functions (生成函数)
//   Section 7.2: Types of Generating Functions (生成函数的类型)
//   Section 7.3: Conditions for Canonical Transformations (正则变换的条件)
//   Section 7.4: Poisson Brackets (泊松括号)
//   Section 7.5: Invariants under Canonical Transformations (正则变换下的不变量)
//   Section 7.6: Symplectic Structure (辛结构)

// Chapter 8: Hamilton-Jacobi Theory (哈密顿-雅可比理论)
//   Section 8.1: Hamilton-Jacobi Equation (哈密顿-雅可比方程)
//   Section 8.2: Separation of Variables (分离变量法)
//   Section 8.3: Action-Angle Variables (作用量-角变量)
//   Section 8.4: Complete Integrals and Characteristics (完全积分与特征线)
//   Section 8.5: Applications to Central Force Problems (在中心力问题中的应用)

// --- Part IV: Advanced Topics (进阶主题) ---

// Chapter 9: Liouville's Theorem and Statistical Mechanics (刘维尔定理与统计力学)
//   Section 9.1: Liouville's Theorem (刘维尔定理)
//   Section 9.2: Phase Space Volume Conservation (相空间体积守恒)
//   Section 9.3: Ergodicity and Mixing (遍历性与混合)
//   Section 9.4: Poincaré Recurrence Theorem (庞加莱回归定理)

// Chapter 10: Perturbation Theory (微扰理论)
//   Section 10.1: Time-independent Perturbation Theory (不含时微扰理论)
//   Section 10.2: Time-dependent Perturbation Theory (含时微扰理论)
//   Section 10.3: Adiabatic Invariants (绝热不变量)
//   Section 10.4: Canonical Perturbation Theory (正则微扰理论)

// Chapter 11: Integrable Systems (可积系统)
//   Section 11.1: Complete Integrability (完全可积性)
//   Section 11.2: Lax Pairs (Lax对)
//   Section 11.3: Inverse Scattering Method (逆散射方法)
//   Section 11.4: Examples of Integrable Systems (可积系统示例)

// Chapter 12: Stability and Chaos (稳定性与混沌)
//   Section 12.1: Linear Stability Analysis (线性稳定性分析)
//   Section 12.2: Lyapunov Exponents (李雅普诺夫指数)
//   Section 12.3: Poincaré Sections (庞加莱截面)
//   Section 12.4: Bifurcations (分岔)
//   Section 12.5: Routes to Chaos (通向混沌的道路)

// --- Part V: Relativistic and Field Extensions (相对论与场的推广) ---

// Chapter 13: Relativistic Mechanics (相对论力学)
//   Section 13.1: Relativistic Lagrangian (相对论拉格朗日量)
//   Section 13.2: Relativistic Hamiltonian (相对论哈密顿量)
//   Section 13.3: Electromagnetic Interactions (电磁相互作用)
//   Section 13.4: Covariant Formulation (协变形式)

// Chapter 14: Classical Field Theory (经典场论)
//   Section 14.1: Lagrangian Density (拉格朗日密度)
//   Section 14.2: Field Equations from Variational Principle (从变分原理推导场方程)
//   Section 14.3: Noether's Theorem for Fields (场的诺特定理)
//   Section 14.4: Stress-Energy Tensor (应力-能量张量)
//   Section 14.5: Examples: Scalar and Electromagnetic Fields (示例：标量场与电磁场)

// 结构说明：
// 本目录分为五个部分，共14章。Part I 建立变分法与广义坐标的数学基础；Part II 系统阐述拉格朗日力学，从方程推导到守恒律再到具体应用；Part III 深入哈密顿力学，包括正则变换与哈密顿-雅可比理论；Part IV 涵盖刘维尔定理、微扰理论、可积系统与混沌等进阶主题；Part V 将分析力学推广至相对论与经典场论。整体编排遵循从基础到进阶、从有限自由度到无限自由度的逻辑主线。


