#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Équation Différentielle Ordinaire",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Équation Différentielle Ordinaire",
  "Violet",
  subtitle: "A notebook for ordinary differential equations",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.1.0",
  extra-info: "This is a notebook for ordinary differential equations.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
// 主线：基础与一阶理论 → 线性系统 → 定性与非线性 → 边值谱论
// 共 4 Part、7 Chapter。
//
// 职责边界：
//   - Banach 不动点 / Picard 迭代的抽象理论 → Analyse Réelle / Analyse Fonctionnelle
//     （交叉引用；本笔记仅给出 ODE 版本的应用形式）
//   - 矩阵指数、Jordan 标准形 → Algèbre Linéaire（交叉引用，直接使用结果）
//   - Laplace 变换的完整理论 → Analyse Harmonique（交叉引用；
//     本笔记仅给出 ODE 求解所需的最小版本）
//   - 谱理论抽象框架 → Analyse Fonctionnelle（交叉引用；
//     Sturm-Liouville 作为具体应用出现在本笔记）
//   - 一阶偏微分方程全部内容 → Équations aux Dérivées Partielles
//     （本笔记不包含，完整理论见 PDE 笔记）
//   - 相平面分支、混沌等深入内容 → 后续专门笔记（如有）
//
// 设计决策：
//   - 原 tex 笔记中 chap06（边值问题）被错误置于 chap08（一阶PDE）之后，
//     本设计删除原 chap08（一阶PDE）——该内容完全归属 PDE 笔记，
//     边值问题（原 chap06）按逻辑顺序归入 Part IV
//   - 存在唯一性定理（Ch 3）放在一阶初等解法（Ch 2）之后，
//     符合「先直观后严格」的认知顺序
//   - 高阶线性方程（Ch 5）与一阶线性系统（Ch 4）虽数学上等价，
//     但方法体系不同，分开成章便于查阅
//
// ==========================================================================
// Part I — Foundations and First-Order Theory (基础与一阶理论)
// ==========================================================================
// 设计思路：本 Part 是「语言层 + 方法层 + 严格基础层」。
// 先建立 ODE 的基本语言与分类（Ch 1），再给出一阶方程的全套初等解法（Ch 2），
// 最后用严格的存在唯一性定理为整个理论奠基（Ch 3）。
// 先解法后存在性：让读者先有具体计算的手感，再理解为什么解存在、唯一、依赖初值。
// 对应教材：导论 + 一阶方程 + 存在性定理。

// --- Chapter 1: Introduction (导论) ---

//   Section 1.1: Classification of Differential Equations (微分方程的分类)
//     - ODE 定义、阶数、线性与非线性
//     - 初值问题与边值问题的区分
//   Section 1.2: Solution to an ODE (常微分方程的解)
//     - 显式解、隐式解、通解与特解
//     - 解的几何解释：积分曲线

// --- Chapter 2: First-Order Equations (一阶方程初等解法) ---

//   Section 2.1: Exact Equations (恰当方程)
//     - 恰当微分形式、恰当方程的充要条件
//   Section 2.2: Separable Equations (可分离变量方程)
//     - 变量分离法
//   Section 2.3: Homogeneous Equations (齐次方程)
//     - 齐次方程的变量替换
//   Section 2.4: Linear Equations (线性方程)
//     - 一阶线性方程的通解公式、常数变易法
//   Section 2.5: Integrating Factors (积分因子)
//     - 积分因子的存在性与求法
//   Section 2.6: Implicit Equations (隐式方程)
//     - 可解出导数的隐式方程、参数法
//   Section 2.7: Reducible Higher-Order Equations (可降阶的高阶方程)
//     - 不显含未知函数、不显含自变量的降阶法

// --- Chapter 3: Existence, Uniqueness and Dependence (存在唯一性与解的依赖性) ---

//   Section 3.1: Picard-Lindelöf Theorem (Picard-Lindelöf 定理)
//     - Picard 迭代、压缩映射思想
//     - 局部存在唯一性证明
//   Section 3.2: Continuation of Solutions (解的延拓)
//     - 饱和解、解的最大存在区间
//   Section 3.3: Singular Solutions and Envelopes (奇解与包络)
//     - 奇解、C-判别式、包络
//   Section 3.4: Dependence on Initial Values (解对初值的依赖性)
//     - 连续性、可微性、解对参数的依赖性

// ==========================================================================
// Part II — Linear Systems Theory (线性系统理论)
// ==========================================================================
// 设计思路：本 Part 是 EDO 的核心解析理论。从一阶线性方程组（Ch 4）出发，
// 建立齐次/非齐次理论、常系数解法、周期系数理论；再过渡到高阶线性方程（Ch 5），
// 作为一阶系统的特例与对偶视角。高阶方程的算子法、待定系数法与 Laplace 变换
// 是工程与应用中最常用的工具，独立成章便于查阅。
// 对应教材：一阶线性方程组 + 高阶线性方程。

// --- Chapter 4: First-Order Linear Systems (一阶线性方程组) ---

//   Section 4.1: Systems of Linear ODEs (线性方程组)
//     - 方程组的向量形式、矩阵记号
//   Section 4.2: Homogeneous Linear Systems (齐次线性方程组的一般理论)
//     - 解空间、Wronskian、基解矩阵
//   Section 4.3: Nonhomogeneous Linear Systems (非齐次线性方程组)
//     - 常数变易法、常数变易公式
//   Section 4.4: Constant-Coefficient Homogeneous Systems (常系数齐次方程组)
//     - 矩阵指数 e^{At}、Jordan 标准形方法
//   Section 4.5: Periodic Coefficient Systems (周期系数线性系统)
//     - Floquet 理论、Floquet 乘子

// --- Chapter 5: Higher-Order Linear Equations (高阶线性方程) ---

//   Section 5.1: General Theory of Higher-Order Linear Equations (高阶线性方程一般理论)
//     - 解的结构、Wronskian、降阶法
//   Section 5.2: Constant-Coefficient Homogeneous Equations (常系数齐次方程)
//     - 特征方程、重根处理、Euler 方程
//   Section 5.3: Method of Undetermined Coefficients (待定系数法)
//     - 非齐次特解的求法
//   Section 5.4: Laplace Transform Method (Laplace 变换法)
//     - Laplace 变换求解初值问题、卷积

// ==========================================================================
// Part III — Qualitative Theory and Nonlinear Dynamics (定性理论与非线性动力学)
// ==========================================================================
// 设计思路：前两 Part 都是「求精确解」，本 Part 转向「不解方程也能了解解的性质」。
// 从相平面（Ch 6.1）的几何直观出发，引入 Lyapunov 稳定性概念与直接法（Ch 6.2-6.3），
// 最后讨论平面系统的奇点分类与极限环（Ch 6.4）。这是从解析到定性的范式转换，
// 也是现代动力系统的入口。
// 对应教材：非线性方程与稳定性。

// --- Chapter 6: Nonlinear Equations and Stability (非线性方程与稳定性) ---

//   Section 6.1: The Phase Plane (相平面)
//     - 相平面、相轨迹、平面自治系统
//   Section 6.2: Lyapunov Stability (Lyapunov 稳定性)
//     - 稳定/渐近稳定/不稳定的定义
//     - 线性近似稳定性
//   Section 6.3: Lyapunov Methods (Lyapunov 直接法)
//     - Lyapunov 函数、V 函数判定
//   Section 6.4: Critical Points and Limit Cycles (奇点与极限环)
//     - 平面奇点分类（结点、鞍点、焦点、中心）
//     - 极限环、Poincaré-Bendixson 定理

// ==========================================================================
// Part IV — Boundary Value Problems and Sturm-Liouville Theory (边值问题与 Sturm-Liouville 理论)
// ==========================================================================
// 设计思路：前几 Part 都是初值问题，本 Part 转向边值问题。
// Sturm-Liouville 问题是 ODE 与谱理论的交汇点：特征值问题既是 ODE 边值问题的核心，
// 也是 Fourier 分析、正交函数系、PDE 分离变量法的基础。
// 放在定性理论之后：Sturm 比较定理与振动性与稳定性思想一脉相承。
// 对应教材：边值问题一章。

// --- Chapter 7: Boundary Value Problems (边值问题) ---

//   Section 7.1: Sturm-Liouville Problems (Sturm-Liouville 问题)
//     - Sturm-Liouville 边值问题的提法
//     - 特征值与特征函数、正交性
//     - Sturm 比较定理、振动定理

// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循「基础与一阶理论 → 线性系统 → 定性与非线性 → 边值谱论」
// 的四段式主线，共 4 Part、7 Chapter。
//
// Part I（Ch 1–3，基础与一阶理论）：ODE 基本语言、一阶方程全套初等解法、
//   存在唯一性与解的依赖性，奠定严格基础。
//
// Part II（Ch 4–5，线性系统理论）：一阶线性方程组的完整理论与解法，
//   高阶线性方程作为对偶视角，是解析理论的核心。
//
// Part III（Ch 6，定性与非线性）：相平面几何、Lyapunov 稳定性理论、
//   奇点与极限环，从「求精确解」转向「定性分析」。
//
// Part IV（Ch 7，边值问题）：Sturm-Liouville 特征值问题，
//   连接 ODE 与谱理论，为 PDE 分离变量法铺路。
//
// 教材覆盖：柳彬《常微分方程》、王高雄《常微分方程》、Boyce & DiPrima
//   《Elementary Differential Equations》全部核心知识点均已覆盖。
//   （注：原 tex 笔记中一阶 PDE 一章已全部移入 Équations aux Dérivées Partielles 笔记）
// ==========================================================================

#part("Foundations and First-Order Theory") // 基础与一阶理论

= Introduction // 导论

This chapter establishes the basic language of ordinary differential equations (ODEs). We begin with the classification of differential equations, then formalize what it means for a function to be a solution. The geometric interpretation of solutions as integral curves and the direction field provides the intuition that will guide our later study of existence theory and qualitative analysis.

== Classification of Differential Equations // 微分方程的分类

An equation involving one dependent variable and its derivatives with respect to one or more independent variables is called a *differential equation*. Differential equations can be classified according to several criteria.

#definition(name: "Ordinary Differential Equation (ODE)")[
An *ordinary differential equation* (ODE) is an equation of the form
$
  F(x, y, y', y'', dots, y^(n)) = 0, quad n in bb(N),
$
where $x$ is the independent variable, $y$ is the unknown function of $x$, and $y^(k) = d^k y / d x^k$ denotes the $k$-th derivative.
] <def:ode>

If the unknown function depends on two or more independent variables, and the equation involves partial derivatives, it is called a *partial differential equation* (PDE). PDEs are studied in the companion volume *Équations aux Dérivées Partielles*.

#definition(name: "Order of a Differential Equation")[
The *order* of a differential equation is the order of the highest derivative appearing in the equation.
] <def:ode-order>

- A first-order equation has the form $F(x, y, y') = 0$.
- A second-order equation has the form $F(x, y, y', y'') = 0$.
- Higher-order equations involve derivatives of order three or more.

#note[
Crucially, the order determines how many initial conditions are needed to single out a unique solution. An $n$-th order equation requires $n$ initial conditions.
]

#definition(name: "Linear Differential Equation")[
An $n$-th order differential equation is *linear* if it can be written in the form
$
  a_n(x) y^(n) + a_(n-1)(x) y^(n-1) + dots + a_1(x) y' + a_0(x) y = g(x),
$
where the coefficients $a_i(x)$ and the inhomogeneous term $g(x)$ depend only on the independent variable $x$. Otherwise, the equation is *nonlinear*.
] <def:linear-ode>

#note[
For a linear equation, if $g(x) = 0$, the equation is called *homogeneous*; otherwise it is *non-homogeneous*. This distinction is central to the theory of linear systems developed in Part II.
]

== Solution to an ODE // 常微分方程的解

Let $J subset.eq bb(R)$ be an interval.

#definition(name: "Solution of an ODE")[
A function $y = phi(x)$ defined on $J$ is called a *solution* to the ODE $F(x, y, y', dots, y^(n)) = 0$ if it satisfies
$
  F(x, phi(x), phi'(x), phi''(x), dots, phi^(n)(x)) = 0 quad quad text("for all") x in J.
$
The interval $J$ is called the *interval of existence* of the solution.
] <def:solution>

#definition(name: "General and Particular Solutions")[
Suppose $y = phi(x; c_1, c_2, dots, c_n)$ is a solution depending on $n$ arbitrary constants $c_1, dots, c_n$. If these constants are *mutually independent* — meaning the Jacobian determinant
$
  "det" (partial(phi, phi', dots, phi^(n-1))) / (partial(c_1, c_2, dots, c_n)) != 0 quad quad text("for all") x in J
$
is non-vanishing — then $y = phi(x; c_1, dots, c_n)$ is called the *general solution* of the ODE.

A solution obtained by fixing specific values of the arbitrary constants is called a *particular solution*.
] <def:general-solution>

#definition(name: "Initial Conditions and Cauchy Problem")[
Let $y = phi(x)$ be a solution of an $n$-th order ODE. The conditions
$
  phi(x_0) = y_0, quad phi'(x_0) = y_0', quad dots, quad phi^(n-1)(x_0) = y_0^(n-1)
$
are called *initial conditions* at $x = x_0$. An ODE together with a set of initial conditions is called an *initial value problem* (IVP), also known as a *Cauchy problem*.
] <def:cauchy-problem>

#definition(name: "Explicit and Implicit Solutions")[
A solution $y = phi(x)$ written directly as a function of $x$ is called an *explicit solution*. If the solution is determined by a relation $Phi(x, y) = 0$ that cannot (or need not) be solved for $y$ in terms of $x$, then $Phi(x, y) = 0$ is called an *implicit solution*. An implicit solution is also referred to as an *integral* of the equation.
] <def:implicit-solution>

=== Integral Curves and Direction Fields // 积分曲线与方向场

Consider the first-order ODE
#eq[
  (d y) / (d x) = f(x, y),
] <eq:first-order-ode>
where $f$ is continuous in a planar region $G subset.eq bb(R)^2$.

#definition(name: "Integral Curve")[
If $y = phi(x)$, $x in J$, is a solution to @eq:first-order-ode, then the set of points
$
  Gamma = { (x, y) : y = phi(x), x in J }
$
forms a differentiable curve in the plane. This curve is called a *solution curve* or an *integral curve* of the ODE.
] <def:integral-curve>

At any point $(x_0, y_0)$ on the integral curve, the slope of the tangent line is
$
  phi'(x_0) = f(x_0, y_0).
$
Thus the tangent line at $(x_0, y_0)$ has equation
$
  y - y_0 = f(x_0, y_0) (x - x_0).
$
Remarkably, we can determine the tangent slope at any point from the equation alone, without knowing the explicit solution.

#definition(name: "Direction Field (Line Element Field)")[
At each point $P = (x, y)$ in the region $G$, draw a short line segment with slope $f(P)$. This segment is called the *line element* (or *direction element*) of the ODE at $P$. The region $G$ together with the collection of all line elements is called the *direction field* (or *slope field* or *line element field*) of the ODE.
] <def:direction-field>

#note[
The direction field gives a geometric portrait of all solutions even when we cannot solve the equation explicitly. Integral curves are precisely the curves that are everywhere tangent to the direction field. This geometric viewpoint is the foundation of qualitative theory, which we develop in Part III.
]

#theorem(name: "Integral Curve Criterion")[
A continuously differentiable curve $Gamma = { (x, y) : y = psi(x), x in J }$ in the plane is an integral curve of @eq:first-order-ode if and only if, at every point $(x, y) in Gamma$, its tangent line coincides with the line element prescribed by the ODE at that point.
] <thm:integral-curve-criterion>

#proof[
*Necessity.* If $y = psi(x)$ is a solution, then by definition $psi'(x) = f(x, psi(x))$, which means the tangent slope at each point matches the line element.

*Sufficiency.* Suppose the tangent line of $Gamma$ at every point coincides with the line element. Then at each point $(x, y) = (x, psi(x))$ on the curve, we have
$
  psi'(x) = f(x, y) = f(x, psi(x)).
$
Since this holds for all $x in J$, the function $y = psi(x)$ satisfies the ODE and is therefore a solution.
]

= First-Order Equations // 一阶方程

This chapter presents the elementary solution methods for first-order ODEs. We proceed from the symmetric differential form (§2.1), then derive several important special classes: separable equations, homogeneous equations, and linear equations. The method of integrating factors unifies these approaches by converting non-exact forms into exact ones. Finally, we treat implicit equations and the reduction of higher-order equations.

== Exact Equations // 恰当方程

#definition(name: "Exact Equation")[
An equation of the form
#eq[
  M(x, y) dif x + N(x, y) dif y = 0,
] <eq:symmetric-form>
is called the *symmetric form* (or *differential form*) of a first-order differential equation.

If there exists a continuously differentiable function $U(x, y)$ such that
$
  dif U(x, y) = M(x, y) dif x + N(x, y) dif y,
$
then @eq:symmetric-form is said to be an *exact equation* (or *total differential equation*). When this holds, the equation can be rewritten as $d(U(x, y)) = 0$, which implies
#eq[
  U(x, y) = c,
] <eq:exact-general-integral>
where $c$ is an arbitrary constant. @eq:exact-general-integral is called the *general integral* of the equation.
] <def:exact-equation>

#note[
Strictly speaking, the symmetric form is not a differential equation in the traditional sense. However, expressing a first-order ODE in this form is extremely convenient for analysis, as it does not require $y$ to be expressed as a function of $x$. For simplicity, we often refer to the symmetric form itself as a differential equation.
]

#theorem(name: "Exactness Criterion")[
Let $M(x, y)$ and $N(x, y)$ be continuous in a simply connected domain $D subset.eq bb(R)^2$, and suppose their first-order partial derivatives $partial M / partial y$ and $partial N / partial x$ are also continuous. Then a necessary and sufficient condition for @eq:symmetric-form to be exact is
$
  (partial M) / (partial y) = (partial N) / (partial x) quad quad text("in") D.
$
When this condition holds, a general integral is given by
$
  integral_gamma M(x, y) dif x + N(x, y) dif y = c,
$
where $gamma$ is any piecewise smooth curve in $D$ connecting $(x_0, y_0)$ to $(x, y)$.
] <thm:exactness-criterion>

#proof[
This is a standard result from multivariable calculus — the equivalence of closed and exact 1-forms on simply connected domains. For a complete proof, see *Analyse Mathématique*, Theorem 15.9.
]

Beyond the line-integral method, there are two practical methods for finding $U(x, y)$:

- *Term combination method*: Using known exact differentials, we group terms of the equation into a total differential. Useful identities include:
  $
    y dif x + x dif y = dif(x y), quad quad (y dif x - x dif y) / y^2 = dif(x / y),
  $
  $
    (1 / x) dif x + (1 / y) dif y = dif(ln abs(x y)), quad quad (y dif x + x dif y) / (x^2 + y^2) = dif(arctan(y / x)).
  $

In differential form language, the 1-form $omega = M(x, y) dif x + N(x, y) dif y$ is *closed* if its exterior derivative vanishes, and *exact* if it is the differential of some function $U(x, y)$. By Poincaré's lemma, on the simply connected domain $bb(R)^2$, a 1-form is exact if and only if it is closed — which is precisely the condition $(partial M) / (partial y) = (partial N) / (partial x)$.

== Separable Equations // 可分离变量方程

#definition(name: "Separable Equation")[
If $M(x, y)$ and $N(x, y)$ in @eq:symmetric-form can both be written as the product of a function of $x$ and a function of $y$,
$
  M(x, y) = M_1(x) M_2(y), quad quad N(x, y) = N_1(x) N_2(y),
$
then @eq:symmetric-form is called a *separable equation*. In the more familiar derivative notation, this becomes
#eq[
  (d y) / (d x) = f(x) g(y),
] <eq:separable-form>
where $f(x) = -M_1(x) / N_1(x)$ and $g(y) = N_2(y) / M_2(y)$.
] <def:separable-equation>

#theorem(name: "Solutions to Separable Equations")[
All solutions to the separable equation @eq:separable-form are given by
$
  integral_(x_0)^x (M_1(t)) / (N_1(t)) dif t + integral_(y_0)^y (N_2(s)) / (M_2(s)) dif s = c,
$
together with the constant solutions
$
  y equiv b_i, quad quad i = 1, 2, dots, m, quad quad x equiv a_j, quad quad j = 1, 2, dots, n,
$
where $M_2(b_i) = 0$ and $N_1(a_j) = 0$, and $c$ is an arbitrary constant.
] <thm:separable-solutions>

#caution[
When separating variables, we must divide by $M_2(y)$ and $N_1(x)$. The roots of $M_2(y) = 0$ and $N_1(x) = 0$ give constant solutions that are lost during division. These must be checked separately and added back to the solution set.
]

== Homogeneous Equations // 齐次方程

#definition(name: "Homogeneous Function")[
A function $f(x, y)$ is called a *homogeneous function* of degree $n$ if
$
  f(t x, t y) = t^n f(x, y) quad quad text("for all") t > 0.
$
] <def:homogeneous-function>

#definition(name: "Homogeneous Equation")[
A first-order equation $M(x, y) dif x + N(x, y) dif y = 0$ is called a *homogeneous equation* if both $M$ and $N$ are homogeneous functions of the same degree. Equivalently, in derivative form
$
  (d y) / (d x) = f(x, y),
$
the right-hand side can be written as $g(y / x)$.
] <def:homogeneous-equation>

Homogeneous equations are solved by the substitution $u = y / x$, i.e., $y = u x$. Differentiating with respect to $x$ gives
$
  (d y) / (d x) = x (d u) / (d x) + u.
$
Substituting into the equation yields
$
  x (d u) / (d x) + u = g(u) quad quad => quad quad (d u) / (d x) = (g(u) - u) / x,
$
which is a separable equation in $u$ and $x$. After solving for $u(x)$, substitute back $u = y / x$ to obtain $y(x)$.

A more general form is
#eq[
  (d y) / (d x) = f((a_1 x + b_1 y + c_1) / (a_2 x + b_2 y + c_2)),
] <eq:linear-fraction-equation>
which can be reduced to a homogeneous or separable equation by coordinate translation and scaling.

== Linear Equations // 线性方程

#definition(name: "First-Order Linear Equation")[
A *first-order linear equation* has the form
#eq[
  (d y) / (d x) + p(x) y = q(x),
] <eq:first-order-linear>
where $p(x)$ and $q(x)$ are continuous on an interval $(a, b)$. When $q(x) equiv 0$, the equation
$
  (d y) / (d x) + p(x) y = 0
$
is called the *homogeneous* linear equation; otherwise it is *non-homogeneous*.
] <def:first-order-linear>

#note[
The term "homogeneous" here means the right-hand side is zero — this is a different usage from the "homogeneous equation" of §2.3, where homogeneity refers to the scaling property of $f(x, y)$.
]

First solve the homogeneous equation. Since it is separable, its general solution is
$
  y = c e^(- integral p(x) dif x).
$

For the non-homogeneous equation, we use the *method of variation of constants*: assume the solution has the form
$
  y = c(x) e^(- integral p(x) dif x),
$
where the constant $c$ is now allowed to vary. Substituting into @eq:first-order-linear and simplifying gives
#eq[
  y = e^(- integral p(x) dif x) lr(c + integral q(x) e^(integral p(x) dif x) dif x).
] <eq:linear-general-solution>

With an initial condition $y(x_0) = y_0$, the solution becomes
$
  y = e^(- integral_(x_0)^x p(t) dif t) y_0 + integral_(x_0)^x q(t) e^(- integral_t^x p(s) dif s) dif t.
$

This expression has a natural interpretation: *the fundamental solution times the initial value, plus the convolution of the fundamental solution with the forcing term*.

#note[
The method of variation of constants generalizes to non-homogeneous linear PDEs, where it is known as *Duhamel's principle*.
]

#definition(name: "Bernoulli Equation")[
A *Bernoulli equation* is a first-order equation of the form
$
  (d y) / (d x) + p(x) y = q(x) y^n, quad quad n != 0, 1,
$
where $n$ is a real constant.
] <def:bernoulli-equation>

Bernoulli equations are transformed into linear equations by the substitution $z = y^(1 - n)$. Differentiating gives
$
  (d z) / (d x) = (1 - n) y^(-n) (d y) / (d x).
$
Substituting from the Bernoulli equation yields
$
  (d z) / (d x) + (1 - n) p(x) z = (1 - n) q(x),
$
which is a linear equation in $z$, solvable by the method above.

== Integrating Factors // 积分因子

#definition(name: "Integrating Factor")[
For a non-exact differential form $omega = M(x, y) dif x + N(x, y) dif y$, if there exists a non-zero differentiable function $mu(x, y)$ such that $mu(x, y) omega$ is exact, then $mu(x, y)$ is called an *integrating factor* of $omega$. That is, there exists $U(x, y)$ such that
$
  mu(x, y) omega = dif U(x, y).
$
] <def:integrating-factor>

The condition for $mu$ to be an integrating factor is
$
  (partial (mu M)) / (partial y) = (partial (mu N)) / (partial x),
$
which expands to the first-order PDE
#eq[
  N (partial mu) / (partial x) - M (partial mu) / (partial y) = lr((partial M) / (partial y) - (partial N) / (partial x)) mu.
] <eq:integrating-factor-pde>

#theorem(name: "Special Forms of Integrating Factors")[
1. If the integrating factor depends only on $x$, i.e., $mu = mu(x)$, then a necessary and sufficient condition is that
   $
     G(x) = - (1 / N) lr((partial N) / (partial x) - (partial M) / (partial y))
   $
   depends only on $x$. In this case,
   $
     mu(x) = e^( integral G(x) dif x).
   $

2. If the integrating factor depends only on $y$, i.e., $mu = mu(y)$, then a necessary and sufficient condition is that
   $
     H(y) = (1 / M) lr((partial N) / (partial x) - (partial M) / (partial y))
   $
   depends only on $y$. In this case,
   $
     mu(y) = e^( integral H(y) dif y).
   $
] <thm:integrating-factor-special>

#theorem(name: "Integrating Factor Ratio")[
Suppose $mu_1(x, y)$ and $mu_2(x, y)$ are two integrating factors of the same equation, and their ratio $mu_1 / mu_2$ is not constant. Then
$
  (mu_1(x, y)) / (mu_2(x, y)) = c
$
is a general solution of the equation, where $c$ is an arbitrary constant.
] <thm:integrating-factor-ratio>

== Implicit Equations // 隐式方程

This section treats first-order implicit equations of the form
$
  F(x, y, y') = 0,
$
where $F$ is continuously differentiable. Denote $p = y' = d y / d x$.

Depending on which variable can be solved explicitly, there are several cases:

- *Case (a): $p = f(x, y)$ solvable.* The equation reduces to an explicit first-order ODE, solvable by the methods above.

- *Case (b): $y = f(x, p)$ solvable.* Differentiate both sides with respect to $x$:
  $
    p = (d y) / (d x) = (partial f) / (partial x) + (partial f) / (partial p) (d p) / (d x).
  $
  Rearranging gives
  $
    (d p) / (d x) = (p - (partial f) / (partial x)) / ((partial f) / (partial p)),
  $
  which is a first-order equation in $p$. Solve for $p(x)$, then substitute back into $y = f(x, p)$.

- *Case (c): $x = f(y, p)$ solvable.* Differentiate with respect to $x$ and derive an equation for $p$ as a function of $y$.

=== Clairaut and Lagrange Equations // Clairaut 方程与 Lagrange 方程

#definition(name: "Clairaut Equation")[
A *Clairaut equation* has the form
$
  y = x p + g(p), quad quad p = y', quad quad g in C^1.
$
] <def:clairaut-equation>

Differentiating both sides with respect to $x$ gives
$
  p = p + x (d p) / (d x) + g'(p) (d p) / (d x),
$
which simplifies to
$
  lr(x + g'(p)) (d p) / (d x) = 0.
$

There are two cases:

1. *$d p / d x = 0$*: Then $p = c$ (constant), and substituting back gives the general solution
   $
     y = c x + g(c).
   $

2. *$x + g'(p) = 0$*: Then $x = -g'(p)$. Substituting back gives the *singular solution* in parametric form:
   $
     x = -g'(p), quad quad y = -p g'(p) + g(p).
   $

The Clairaut equation generalizes to the *Lagrange equation*:
$
  y = x f(p) + g(p),
$
where $f(p) not equiv p$. The solution procedure is analogous: differentiate, factor, and treat the two cases separately.

== Reducible Higher-Order Equations // 可降阶的高阶方程

Some higher-order equations can be reduced to lower order by variable substitution. We consider three types:

1. *Equations missing the dependent variable and its lower derivatives*: If the equation has the form
   $
     F(x, y^(k), y^(k+1), dots, y^(n)) = 0,
   $
   let $p = y^(k)$. Then the equation reduces to order $n - k$ in the new unknown $p$.

2. *Equations missing the independent variable*: If
   $
     F(y, y', y'', dots, y^(n)) = 0,
   $
   let $p = y'$ and treat $y$ as the independent variable. Then
   $
     y'' = p (d p) / (d y), quad quad y''' = p^2 (d^2 p) / (d y^2) + p lr((d p) / (d y))^2,
   $
   and so on. The equation reduces to order $n - 1$ in $p(y)$.

3. *Equations missing a particular derivative*: Similar substitution techniques apply depending on which derivative is absent.

#definition(name: "Euler-Cauchy Equation")[
An *Euler-Cauchy equation* (or equidimensional equation) has the form
$
  x^n y^(n) + a_(n-1) x^(n-1) y^(n-1) + dots + a_1 x y' + a_0 y = f(x),
$
where $a_0, a_1, dots, a_(n-1)$ are constants.
] <def:euler-cauchy>

Euler-Cauchy equations are transformed into constant-coefficient linear equations by the substitution $x = e^t$. Under this change of variable,
$
  (d y) / (d x) = (1 / x) (d y) / (d t), quad quad (d^2 y) / (d x^2) = (1 / x^2) lr((d^2 y) / (d t^2) - (d y) / (d t)),
$
and higher derivatives follow similarly. The equation becomes a constant-coefficient linear ODE in $t$, solvable by the methods of Part II.

#caution[
When an equation is written in symmetric form $M(x, y) dif x + N(x, y) dif y = 0$, the roles of $x$ and $y$ are symmetric. It is sometimes easier to treat $x$ as the unknown function of $y$, especially when the resulting equation becomes linear in $x$.
]

#bibliography("references.bib")
