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

An equation involving derivatives of a function of one or more independent variables is called a *differential equation*. Differential equations can be classified according to several criteria.

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
  a_(n)(x) y^(n) + a_(n-1)(x) y^(n-1) + dots + a_1(x) y' + a_0(x) y = g(x),
$
where the coefficients $a_(i)(x)$ and the inhomogeneous term $g(x)$ depend only on the independent variable $x$. Otherwise, the equation is *nonlinear*.
] <def:linear-ode>

#note[
For a linear equation, if $g(x) = 0$, the equation is called *homogeneous*; otherwise it is *non-homogeneous*. This distinction is central to the theory of linear systems developed in Part II.
]

== Solution to an ODE // 常微分方程的解

Let $J subset.eq bb(R)$ be an interval.

#definition(name: "Solution of an ODE")[
A smooth function $y = phi(x)$ defined on $J$ is called a *solution* to the ODE $F(x, y, y', dots, y^(n)) = 0$ if it satisfies
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

In contrast, if the conditions are prescribed at both ends of an interval $[a, b]$ — such as $phi(a) = y_a$ and $phi(b) = y_b$ — they are called *boundary conditions*, and an ODE together with such conditions is called a *boundary value problem* (BVP). We study BVPs in Part IV.

#definition(name: "Explicit and Implicit Solutions")[
A solution $y = phi(x)$ written directly as a function of $x$ is called an *explicit solution*. If the solution is determined by a relation $Phi(x, y) = 0$ that cannot (or need not) be solved for $y$ in terms of $x$, then $Phi(x, y) = 0$ is called an *implicit solution*. An implicit solution is also referred to as an *integral* of the equation.
] <def:implicit-solution>

In classical terminology, an implicit solution is also called an *integral* of the equation; this usage is distinct from the integral of calculus.

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
Remarkably, we can determine the tangent slope at any point from the equation alone, without knowing the explicit solution. @fig:direction-field illustrates this idea for the ODE $y' = x - y$.

#definition(name: "Direction Field (Line Element Field)")[
At each point $P = (x, y)$ in the region $G$, draw a short line segment with slope $f(P)$. This segment is called the *line element* (or *direction element*) of the ODE at $P$. The region $G$ together with the collection of all line elements is called the *direction field* (or *slope field* or *line element field*) of the ODE.
] <def:direction-field>

#note[
The direction field gives a geometric portrait of all solutions even when we cannot solve the equation explicitly. Integral curves are precisely the curves that are everywhere tangent to the direction field. This geometric viewpoint is the foundation of qualitative theory, which we develop in Part III.
]

#figure(
  image("img/direction-field.svg", width: 80%),
  caption: [Direction field and typical integral curves for the ODE $y' = x - y$. The dashed line shows the particular solution $y = x - 1$: under the substitution $z = y - x + 1$, this is the equilibrium $z = 0$ of the linearized equation $z' = -z$.],
  placement: auto,
  supplement: [Fig.]
) <fig:direction-field>

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

= Existence, Uniqueness and Dependence // 存在唯一性与解的依赖性

The previous chapter provided elementary methods for solving specific classes of first-order ODEs. This chapter addresses a more fundamental question: *when does a solution exist, when is it unique, and how does it depend on the initial data?* We prove the Picard-Lindelöf theorem using Picard iteration, study how far a solution can be extended, introduce singular solutions and envelopes, and conclude with the continuous dependence of solutions on initial values.

== Picard-Lindelöf Theorem // Picard-Lindelöf 定理

We begin with an auxiliary inequality that will be used repeatedly.

#theorem(name: "Bellman-Gronwall Inequality")[
Let $f(x)$ and $g(x)$ be continuous on $[a, b]$, with $g(x) >= 0$, and let $c >= 0$ be a constant. If
$
  f(x) <= c + integral_a^x f(t) g(t) dif t,
$
then
$
  f(x) <= c exp(lr(integral_a^x g(t) dif t)).
$
] <thm:bellman-gronwall>

Now consider the Cauchy problem
#eq[
  cases((d y) / (d x) = f(x, y), y(x_0) = y_0),
] <eq:cauchy-problem>

#definition(name: "Lipschitz Condition")[
A function $f(x, y)$ satisfies the *Lipschitz condition* with respect to $y$ in a domain $D$ if there exists a constant $L > 0$ such that for all $(x, y_1), (x, y_2) in D$,
$
  abs(f(x, y_1) - f(x, y_2)) <= L abs(y_1 - y_2).
$
] <def:lipschitz>

#theorem(name: "Picard-Lindelöf Theorem")[
Let $D = [x_0 - a, x_0 + a] times [y_0 - b, y_0 + b]$ be a closed rectangle. Suppose:

1. $f(x, y)$ is continuous in $D$.
2. $f(x, y)$ satisfies the Lipschitz condition with respect to $y$ in $D$.

Then there exists a unique solution $y = phi(x)$ (with $phi(x_0) = y_0$) to @eq:cauchy-problem on the interval $[x_0 - h, x_0 + h]$, where
$
  h = min(a, b / M), quad quad M = max_((x, y) in D) abs(f(x, y)).
$
] <thm:picard-lindelof>

#note[
The proof proceeds by *Picard iteration*:

1. Convert the Cauchy problem into an equivalent integral equation:
   $
     y = y_0 + integral_(x_0)^x f(t, y) dif t.
   $

2. Construct a sequence of approximations:
   $
     phi_(n + 1)(x) = y_0 + integral_(x_0)^x f(t, phi_(n)(t)) dif t, quad quad phi_0(x) = y_0.
   $

3. Show that ${phi_n}$ converges uniformly on $[x_0 - h, x_0 + h]$. The error between successive terms satisfies
   $
     abs(phi_(n + 1) - phi_n) <= (M L^n) / ((n + 1)!) abs(x - x_0)^(n + 1),
   $
   which decays factorially and guarantees uniform convergence.

4. Verify that the limit function satisfies the integral equation, and hence the ODE.

5. Uniqueness follows by applying the Lipschitz condition and Bellman-Gronwall to the difference of two solutions.
]

#figure(
  image("img/picard-iteration.svg", width: 75%),
  caption: [Picard iteration convergence for the simple ODE $y' = y, y(0) = 1$. The iterates $phi_0, phi_1, phi_2, phi_3$ approach the exact solution $y = e^x$ factorially fast.],
  placement: auto,
  supplement: [Fig.]
) <fig:picard-iteration>

=== Peano and Osgood Theorems // Peano 定理与 Osgood 定理

The Picard-Lindelöf theorem requires both continuity and Lipschitz continuity. If we drop the Lipschitz condition, we lose uniqueness but may still retain existence.

#definition(name: "Osgood Condition")[
Let $f(x, y)$ be continuous in $D$. If there exists a continuous function $F(t) > 0$ for $t > 0$ such that
$
  abs(f(x, y_1) - f(x, y_2)) <= F(abs(y_1 - y_2))
$
and
$
  integral_0^epsilon (1 / F(t)) dif t = +oo quad quad text("for all") epsilon > 0,
$
then $f$ satisfies the *Osgood condition* with respect to $y$.
] <def:osgood-condition>

#note[
Every Lipschitz-continuous function satisfies the Osgood condition, since we may take $F(t) = L t$.
]

#theorem(name: "Peano Existence Theorem")[
Let $D = [x_0 - a, x_0 + a] times [y_0 - b, y_0 + b]$. If $f(x, y)$ is continuous in $D$, then there exists *at least one* solution to @eq:cauchy-problem on $[x_0 - h, x_0 + h]$, where
$
  h = min(a, b / M), quad quad M = max_((x, y) in D) abs(f(x, y)).
$
] <thm:peano>

#theorem(name: "Osgood Uniqueness Theorem")[
If $f(x, y)$ satisfies the Osgood condition with respect to $y$ in $D$, then the solution to @eq:cauchy-problem is unique on $[x_0 - h, x_0 + h]$.
] <thm:osgood>

#note[
The Peano theorem guarantees existence but not uniqueness. The classic counterexample is $y' = sqrt(y)$ with $y(0) = 0$, which has infinitely many solutions (including piecewise solutions that stay at zero for an arbitrary interval before taking off). The Osgood theorem gives the weakest known condition for uniqueness.
]

== Continuation of Solutions // 解的延拓

#definition(name: "Saturated (Uncontinuable) Solution")[
Let $y = phi(x)$ be a solution on interval $I_1$. If there exists another solution $y = tilde(phi)(x)$ on a strictly larger interval $I_2 supset I_1$ that agrees with $phi$ on $I_1$, then $phi$ is called *continuable*, and $tilde(phi)$ is a *continuation*. If no such extension exists, $phi$ is called *uncontinuable* or *saturated*.
] <def:saturated-solution>

#theorem(name: "Continuation Theorem")[
Let $D$ be a bounded closed rectangle. Suppose $f(x, y)$ is continuous in $D$ and satisfies the *local Lipschitz condition* with respect to $y$ — that is, every point has a neighborhood in which $f$ is Lipschitz. Then any solution passing through $(x_0, y_0) in D$ can be continued until it approaches arbitrarily close to the boundary of $D$.
] <thm:continuation>

#theorem(name: "Comparison Theorem")[
Let $f(x, y)$ and $g(x, y)$ be continuous and Lipschitz in $y$ in a region $D$. If $f(x, y) <= g(x, y)$ for all $(x, y) in D$, then the solutions $y = phi(x)$ and $y = psi(x)$ passing through the same point $(x_0, y_0)$ satisfy
$
  phi(x) <= psi(x)
$
on their common interval of existence. The same holds for strict inequalities.
] <thm:comparison>

== Singular Solutions and Envelopes // 奇解与包络

#definition(name: "Singular Solution")[
Let $Phi(x, y, c) = 0$ be the general solution of $F(x, y, y') = 0$. An integral curve $S$ is called a *singular solution* if:

1. $S$ satisfies the differential equation.
2. $S$ is not a member of the family $Phi(x, y, c) = 0$.
3. At every point of $S$, at least two distinct solutions pass through (thus violating uniqueness).
] <def:singular-solution>

#definition(name: "Envelope")[
Given a family of curves $Phi(x, y, c) = 0$, a curve $S$ is called the *envelope* of the family if at every point of $S$, there is a member of the family tangent to $S$.
] <def:envelope>

#caution[
A singular solution is not necessarily an envelope (it may be the locus of singular points of the family), and an envelope is not necessarily a singular solution. The two concepts are closely related but not identical.
]

#theorem(name: "c-Test (Envelope Condition)")[
Given the general solution $Phi(x, y, c) = 0$, eliminate $c$ from the system
$
  Phi(x, y, c) = 0, quad quad (partial Phi) / (partial c) = 0.
$
The resulting *c-test curve* is a candidate for the envelope. If, in addition:

1. The curve is regular (parametric form $x = phi(c), y = psi(c)$ with $phi'^2 + psi'^2 != 0$).
2. The gradient $nabla Phi = (Phi_x, Phi_y)$ is non-zero.

then the c-test curve is indeed the envelope of the family, and is also a singular solution of the ODE.
] <thm:c-test>

#theorem(name: "p-Test (Singular Solution Condition)")[
For the differential equation $F(x, y, y') = 0$ (where $p = y'$), eliminate $p$ from
$
  F(x, y, p) = 0, quad quad (partial F) / (partial p) = 0.
$
If the resulting curve $y = psi(x)$ is a solution of the equation, and $F_y != 0$ and $F_(p p) != 0$, then it is a singular solution.
] <thm:p-test>

== Dependence on Initial Values // 解对初值的依赖性

Denote by $y = phi(x; x_0, y_0)$ the solution to the Cauchy problem passing through $(x_0, y_0)$.

#definition(name: "Continuous Dependence on Initial Values")[
The solution depends continuously on the initial values $(x_0, y_0)$ if, for every $epsilon > 0$, there exists $delta > 0$ such that whenever $abs(x_0 - x_1) < delta$ and $abs(y_0 - y_1) < delta$, we have
$
  abs(phi(x; x_0, y_0) - phi(x; x_1, y_1)) < epsilon
$
on the common interval of existence.
] <def:continuous-dependence>

#theorem(name: "Differentiability with Respect to Initial Data")[
Suppose $f(x, y)$ and $f_(y)(x, y)$ are continuous in a closed rectangle $D$. Then the solution $y = phi(x; x_0, y_0)$ is of class $C^1$ as a function of $(x, x_0, y_0)$. Moreover,
$
  (partial phi) / (partial y_0) = exp(lr(integral_(x_0)^x f_y(t, phi(t; x_0, y_0)) dif t)),
$
$
  (partial phi) / (partial x_0) = -f(x_0, y_0) exp(lr(integral_(x_0)^x f_y(t, phi(t; x_0, y_0)) dif t)).
$
] <thm:dependence-derivatives>

#note[
These formulas show how sensitive the solution is to changes in the initial conditions. The derivative with respect to $y_0$ is a solution of the variational equation $z' = f_y(x, phi(x)) z$, which is the linearization of the original ODE along the solution trajectory. This variational equation plays a central role in stability theory (Part III).
]

#part("Linear Systems Theory") // 线性系统理论

= First-Order Linear Systems // 一阶线性方程组

This chapter develops the general theory of first-order linear systems. We introduce the matrix notation that unifies the treatment of $n$ coupled equations, establish the structure of the solution space for homogeneous systems, derive the variation-of-constants formula for non-homogeneous systems, and solve explicitly the constant-coefficient case using the matrix exponential.

== Systems and Matrix Notation // 线性方程组的矩阵形式

A general first-order system of $n$ equations has the form
$
  cases(
    (d y_1) / (d x) = f_1(x, y_1, y_2, dots, y_n),
    (d y_2) / (d x) = f_2(x, y_1, y_2, dots, y_n),
    quad quad dots.v,
    (d y_n) / (d x) = f_(n)(x, y_1, y_2, dots, y_n),
  )
$
If the right-hand side does not depend explicitly on $x$, the system is called *autonomous*.

For compactness, we write the system in matrix form. Let
$
  bold(Y) = mat(y_1, y_2, dots.v, y_n), quad quad bold(F)(x, bold(Y)) = mat(f_1, f_2, dots.v, f_n).
$
Then the system becomes
#eq[
  (d bold(Y)) / (d x) = bold(F)(x, bold(Y)),
] <eq:general-system>
and the Cauchy problem is
$
  cases((d bold(Y)) / (d x) = bold(F)(x, bold(Y)), bold(Y)(x_0) = bold(Y)_0).
$

A system is *linear* if the right-hand side is linear in $bold(Y)$:
#eq[
  (d bold(Y)) / (d x) = bold(A)(x) bold(Y) + bold(F)(x),
] <eq:linear-system>
where $bold(A)(x) = (a_(i j)(x))$ is an $n times n$ matrix and $bold(F)(x)$ is an $n$-dimensional vector, both continuous on an interval $I$.

When $bold(F)(x) equiv bold(0)$, the system is *homogeneous*:
#eq[
  (d bold(Y)) / (d x) = bold(A)(x) bold(Y),
] <eq:homogeneous-system>
otherwise it is *non-homogeneous*.

#theorem(name: "Existence and Uniqueness for Linear Systems")[
If $bold(A)(x)$ and $bold(F)(x)$ are continuous on an interval $I$ containing $x_0$, then the Cauchy problem for @eq:linear-system has a unique solution on the entire interval $I$.
] <thm:linear-existence-uniqueness>

#note[
Unlike the general Picard-Lindelöf theorem (which gives only a local solution), for linear systems the solution exists on the whole interval of continuity of the coefficients. This is because linear growth automatically satisfies a global Lipschitz condition.
]

== General Theory of Homogeneous Systems // 齐次线性方程组的一般理论

The solution set of the homogeneous system @eq:homogeneous-system has a rich algebraic structure.

*Superposition principle.* If $bold(Y)_1(x)$ and $bold(Y)_2(x)$ are solutions of @eq:homogeneous-system, then any linear combination
$
  bold(Y)(x) = c_1 bold(Y)_1(x) + c_2 bold(Y)_2(x)
$
is also a solution. It follows that the set of all solutions forms an $n$-dimensional vector space.

#definition(name: "Fundamental Solution Matrix")[
Let $bold(Y)_1(x), dots, bold(Y)_(n)(x)$ be $n$ linearly independent solutions of the homogeneous system @eq:homogeneous-system. The $n times n$ matrix
$
  bold(Phi)(x) = mat(bold(Y)_1(x), dots, bold(Y)_(n)(x))
$
whose columns are these solutions is called a *fundamental solution matrix*. The set ${bold(Y)_1, dots, bold(Y)_n}$ is called a *fundamental system of solutions*.
] <def:fundamental-matrix>

#definition(name: "Wronskian Determinant")[
For $n$ vector functions $bold(Y)_1(x), dots, bold(Y)_(n)(x)$, their *Wronskian determinant* is
$
  W(x) = "det" lr(mat(bold(Y)_1(x), dots, bold(Y)_(n)(x))).
$
] <def:wronskian>

#theorem(name: "Liouville's Formula")[
Let $W(x)$ be the Wronskian of $n$ solutions of the homogeneous system @eq:homogeneous-system. Then
$
  W(x) = W(x_0) exp(lr(integral_(x_0)^x "tr"(bold(A)(t)) dif t)).
$
] <thm:liouville>

#note[
Liouville's formula implies that $W(x)$ either vanishes identically on $I$ or never vanishes on $I$. For solutions of the homogeneous system, linear dependence is equivalent to $W(x) equiv 0$. Thus a fundamental solution matrix is precisely a matrix whose Wronskian is non-zero.
]

#theorem(name: "General Solution of Homogeneous Linear Systems")[
If $bold(Phi)(x)$ is a fundamental solution matrix of @eq:homogeneous-system, then the general solution is
$
  bold(Y)(x) = bold(Phi)(x) bold(C),
$
where $bold(C) in bb(R)^n$ is an arbitrary constant vector.
] <thm:homogeneous-general-solution>

== Non-Homogeneous Systems and Variation of Constants // 非齐次方程组与常数变易法

For the non-homogeneous system @eq:linear-system, the structure of solutions is analogous to the scalar case:

- The difference of two solutions of the non-homogeneous system is a solution of the corresponding homogeneous system.
- The general solution is the sum of the general solution of the homogeneous system and any particular solution of the non-homogeneous system.

#theorem(name: "General Solution of Non-Homogeneous Linear Systems")[
Let $bold(Phi)(x)$ be a fundamental matrix of the homogeneous system @eq:homogeneous-system. Then the general solution of @eq:linear-system is
$
  bold(Y)(x) = bold(Phi)(x) bold(C) + tilde(bold(Y))(x),
$
where $tilde(bold(Y))(x)$ is any particular solution.
] <thm:nonhomogeneous-general-solution>

The particular solution can be found by *variation of constants*. Assume the solution has the form
$
  bold(Y)(x) = bold(Phi)(x) bold(C)(x),
$
where the constant vector $bold(C)$ is now allowed to vary. Substituting into @eq:linear-system and using the fact that $bold(Phi)'(x) = bold(A)(x) bold(Phi)(x)$, we obtain
$
  bold(Phi)(x) (d bold(C)) / (d x) = bold(F)(x).
$
Since $bold(Phi)(x)$ is invertible,
$
  (d bold(C)) / (d x) = bold(Phi)^(-1)(x) bold(F)(x).
$
Integrating from $x_0$ to $x$ gives the variation-of-constants formula:

$
  tilde(bold(Y))(x) = bold(Phi)(x) integral_(x_0)^x bold(Phi)^(-1)(t) bold(F)(t) dif t.
$

where $bold(Phi)$ is a fundamental matrix.

With initial condition $bold(Y)(x_0) = bold(Y)_0$, the solution becomes
$
  bold(Y)(x) = bold(Phi)(x) bold(Phi)^(-1)(x_0) bold(Y)_0 + bold(Phi)(x) integral_(x_0)^x bold(Phi)^(-1)(t) bold(F)(t) dif t.
$

== Constant-Coefficient Systems // 常系数线性方程组

For the constant-coefficient homogeneous system
#eq[
  (d bold(Y)) / (d x) = bold(A) bold(Y),
] <eq:constant-coefficient>
where $bold(A)$ is a constant matrix, the fundamental solution matrix is given by the *matrix exponential*:
$
  bold(Phi)(x) = e^(bold(A) x).
$

#theorem(name: "Matrix Exponential as Fundamental Matrix")[
The matrix exponential $e^(bold(A) x)$ is a fundamental solution matrix of @eq:constant-coefficient, with $e^(bold(A) * 0) = bold(I)$.
] <thm:matrix-exponential-fundamental>

For the non-homogeneous constant-coefficient system, the variation-of-constants formula simplifies to:

$
  bold(Y)(x) = e^(bold(A) x) bold(C) + integral_(x_0)^x e^(bold(A) (x - s)) bold(F)(s) dif s.
$ <eq:constant-coefficient-solution>

With initial condition $bold(Y)(x_0) = bold(Y)_0$:
$
  bold(Y)(x) = e^(bold(A) (x - x_0)) bold(Y)_0 + integral_(x_0)^x e^(bold(A) (x - s)) bold(F)(s) dif s.
$

=== Computing $e^(bold(A) x)$ // 矩阵指数的计算

The matrix exponential can be computed in finite form using the Jordan canonical form of $bold(A)$.

For a single Jordan block of size $n$ with eigenvalue $lambda$,
$
  e^(bold(J) x) = e^(lambda x) mat(
    1, x, x^2 / 2!, dots, x^(n-1) / (n-1)!,
    0, 1, x, dots, x^(n-2) / (n-2)!,
    dots.v, dots.v, dots.v, dots.down, dots.v,
    0, 0, 0, dots, 1
  ).
$

More generally, if $bold(A)$ has Jordan canonical form $bold(J) = bold(P)^(-1) bold(A) bold(P)$, then
$
  e^(bold(A) x) = bold(P) e^(bold(J) x) bold(P)^(-1).
$

#note[
The full theory of Jordan canonical form belongs to linear algebra (see the *Algèbre Linéaire* notes). Here we only use the result: any matrix is similar to a block-diagonal matrix of Jordan blocks, and the exponential of a block-diagonal matrix is block-diagonal with the exponentials of the blocks on the diagonal.
]

#theorem(name: "Generalized Eigenvector Solutions")[
If $lambda_i$ is an eigenvalue of $bold(A)$ with algebraic multiplicity $k_i$, then @eq:constant-coefficient has $k_i$ linearly independent solutions of the form
$
  bold(Y)(x) = (bold(R)_0 + bold(R)_1 x + dots + bold(R)_(k_i - 1) x^(k_i - 1)) e^(lambda_i x),
$
where the vectors $bold(R)_j$ are determined recursively from the generalized eigenvector chain.
] <thm:generalized-eigenvector-solutions>

== Periodic Coefficient Systems // 周期系数线性方程组

For linear systems with periodic coefficients — i.e., $bold(A)(x + T) = bold(A)(x)$ for some period $T$ — the structure of solutions is described by *Floquet theory*. The fundamental result is that any fundamental matrix can be written in the form
$
  bold(Phi)(x) = bold(P)(x) e^(bold(B) x),
$
where $bold(P)(x)$ is periodic with period $T$ and $bold(B)$ is a constant matrix. The eigenvalues of $bold(B)$ (or equivalently, the Floquet multipliers $e^(lambda_i T)$) determine the stability of the system.

#note[
Floquet theory connects the behavior of periodic linear systems to constant-coefficient systems via a periodic change of variables. This is a foundational tool in the study of oscillatory systems and parametric resonance.
]

= Higher-Order Linear Equations // 高阶线性方程

This chapter extends the theory of first-order linear systems to $n$-th order scalar linear differential equations. The key insight is that any higher-order equation can be rewritten as a first-order system via the companion matrix, which means all the results of Chapter 4 apply directly. We then specialize to the constant-coefficient case, where explicit solutions can be constructed from the characteristic polynomial.

== Reduction to First-Order Systems // 化为一阶方程组

The general $n$-th order linear differential equation has the form
#eq[$
  (d^n y) / (d x^n) + p_1(x) (d^(n-1) y) / (d x^(n-1)) + dots + p_(n-1)(x) (d y) / (d x) + p_(n)(x) y = f(x).
$] <eq:higher-order-nonhomogeneous>

When $f(x) equiv 0$, we obtain the homogeneous case:
#eq[$
  (d^n y) / (d x^n) + p_1(x) (d^(n-1) y) / (d x^(n-1)) + dots + p_(n-1)(x) (d y) / (d x) + p_(n)(x) y = 0.
$] <eq:higher-order-homogeneous>

To reduce this to a first-order system, introduce the state vector
$
  bold(Y) = mat(y, y', y'', dots, y^((n-1)))^T.
$
Then the system becomes
$
  (d bold(Y)) / (d x) = bold(A)(x) bold(Y) + bold(F)(x),
$
where $bold(A)(x)$ is the *companion matrix*
$
  bold(A)(x) = mat(
    0, 1, 0, dots, 0,
    0, 0, 1, dots, 0,
    dots.v, dots.v, dots.v, dots.down, dots.v,
    -p_(n)(x), -p_(n-1)(x), -p_(n-2)(x), dots, -p_1(x)
  ),
$
and $bold(F)(x) = mat(0, 0, dots, f(x))^T$.

#theorem(name: "Equivalence of Higher-Order Equations and First-Order Systems")[
Equation @eq:higher-order-nonhomogeneous is equivalent to the first-order system @eq:linear-system with companion matrix.
That is, if $y(x)$ is a solution of @eq:higher-order-nonhomogeneous, then
$bold(Y)(x) = mat(y, y', y'', dots, y^((n-1)))^T$ is a solution of the corresponding first-order system; conversely, the first component of any solution of the system is a solution of the higher-order equation.
] <thm:higher-order-equivalence>

The initial conditions
$
  y(x_0) = y_0, quad quad y'(x_0) = y_(1, 0), quad quad dots, quad quad y^((n-1))(x_0) = y_((n-1), 0)
$
translate to $bold(Y)(x_0) = bold(Y)_0$.

== General Theory // 一般理论

All the results of Chapter 4 carry over to higher-order equations via the equivalence #link(<thm:higher-order-equivalence>)[theorem].

#definition(name: "Wronskian of Higher-Order Equations")[
For $n$ solutions $y_1(x), dots, y_(n)(x)$ of the homogeneous equation @eq:higher-order-homogeneous, their *Wronskian determinant* is
$
  W(x) = mat(
    y_1(x), y_2(x), dots, y_(n)(x),
    y_1'(x), y_2'(x), dots, y_n'(x),
    dots.v, dots.v, dots.down, dots.v,
    y_1^((n-1))(x), y_2^((n-1))(x), dots, y_n^((n-1))(x)
  ),
$
where the matrix is interpreted as a determinant.
] <def:wronskian-higher-order>

#theorem(name: "Liouville's Formula for Higher-Order Equations")[
$
  W(x) = W(x_0) exp(- integral_(x_0)^x p_1(s) dif s).
$
] <thm:liouville-higher-order>

#theorem(name: "General Solution of Higher-Order Linear Equations")[
Let $y_1(x), dots, y_(n)(x)$ be $n$ linearly independent solutions of the homogeneous equation @eq:higher-order-homogeneous. Then the general solution of @eq:higher-order-nonhomogeneous is
$
  y(x) = C_1 y_1(x) + C_2 y_2(x) + dots + C_n y_(n)(x) + y_(p)(x),
$
where $C_1, dots, C_n$ are arbitrary constants and $y_(p)(x)$ is a particular solution.

The particular solution can be found by variation of parameters:
$
  y_(p)(x) = sum_(i=1)^n y_(i)(x) integral (W_(i)(x) / W(x)) f(x) dif x,
$
where $W_(i)(x)$ is the algebraic cofactor of the element in the $n$-th row and $i$-th column of $W(x)$.
] <thm:higher-order-general-solution>

#example(name: "Reduction of Order")[
Suppose $y = phi(x)$ is a known non-zero solution of the second-order homogeneous equation
$
  y'' + p(x) y' + q(x) y = 0.
$
Then a second linearly independent solution is
$
  y_2(x) = phi(x) integral (exp(- integral p(x) dif x) / phi^2(x)) dif x.
$
This is known as *reduction of order*: knowing one solution reduces the order of the equation.
] <ex:reduction-of-order>

== Constant-Coefficient Homogeneous Equations // 常系数齐次方程

For constant-coefficient equations, the companion matrix is constant, and the theory of the matrix exponential simplifies dramatically. Introduce the differential operator
$
  L_n = (d^n) / (d x^n) + a_1 (d^(n-1)) / (d x^(n-1)) + dots + a_(n-1) (d) / (d x) + a_n,
$
where $a_1, dots, a_n$ are constants. The homogeneous equation is then $L_n y = 0$.

The *characteristic polynomial* is
$
  f(lambda) = lambda^n + a_1 lambda^(n-1) + dots + a_(n-1) lambda + a_n.
$

#theorem(name: "Characteristic Roots and Fundamental Solutions")[
Let $lambda_1, dots, lambda_s$ be the distinct roots of $f(lambda)$, with algebraic multiplicities $n_1, dots, n_s$ respectively (where $n_1 + dots + n_s = n$). Then a fundamental system of solutions is given by:
$
  mat(
    e^(lambda_1 x), x e^(lambda_1 x), dots, x^(n_1 - 1) e^(lambda_1 x),
    e^(lambda_2 x), x e^(lambda_2 x), dots, x^(n_2 - 1) e^(lambda_2 x),
    dots.v,
    e^(lambda_s x), x e^(lambda_s x), dots, x^(n_s - 1) e^(lambda_s x)
  ).
$
] <thm:characteristic-roots>

#note[
For complex roots $lambda = alpha + beta i$, the corresponding complex solutions $e^((alpha + beta i) x)$ can be combined to give real solutions $e^(alpha x) cos(beta x)$ and $e^(alpha x) sin(beta x)$.
]

#figure(
  image("img/characteristic-roots-solutions.svg", width: 90%),
  caption: [Solution behavior for different characteristic root types: real distinct roots (top-left), complex conjugate roots with negative real part (top-right), repeated roots (bottom-left), and purely imaginary roots (bottom-right).],
  placement: auto,
  supplement: [Fig.]
) <fig:characteristic-roots>

== Method of Undetermined Coefficients // 待定系数法

For non-homogeneous constant-coefficient equations, the variation-of-constants formula is computationally expensive. When the forcing term $f(x)$ has a special form, the *method of undetermined coefficients* provides a much simpler approach.

#lemma(name: "Superposition Principle")[
If $y_(text("p1"))(x)$ and $y_(text("p2"))(x)$ are particular solutions of $L_n y = f_1(x)$ and $L_n y = f_2(x)$ respectively, then $y_(p)(x) = y_(text("p1"))(x) + y_(text("p2"))(x)$ is a particular solution of $L_n y = f_1(x) + f_2(x)$.
] <lem:superposition>

#theorem(name: "Form of the Particular Solution")[
Suppose the forcing term has the form
$
  f(x) = e^(alpha x) [P_(m)(x) cos(beta x) + Q_(m)(x) sin(beta x)],
$
where $P_m$ and $Q_m$ are polynomials of degree at most $m$. Then a particular solution has the form
$
  y_(p)(x) = x^k e^(alpha x) [R_(m)(x) cos(beta x) + S_(m)(x) sin(beta x)],
$
where $R_m$ and $S_m$ are polynomials of degree at most $m$, and $k$ is the multiplicity of $alpha + beta i$ as a root of the characteristic polynomial ($k = 0$ if $alpha + beta i$ is not a root).
] <thm:undetermined-coefficients>

#part("Qualitative and Nonlinear Theory") // 定性与非线性理论

= Nonlinear Equations and Stability // 非线性方程与稳定性

This chapter develops the qualitative theory of nonlinear autonomous systems. Instead of seeking explicit solutions, we study the geometric behavior of trajectories in the phase space: equilibrium points, stability, periodic orbits, and limit cycles. This approach is especially powerful when explicit solutions are unavailable.

== The Phase Plane // 相平面

We consider two-dimensional autonomous systems of the form
#eq[$
  cases(
    (d x) / (d t) = F(x, y),
    (d y) / (d t) = G(x, y),
  )
$] <eq:phase-plane-system>

where $F$ and $G$ are continuously differentiable in a domain $D$. In vector form,
#eq[$
  (d bold(x)) / (d t) = bold(f)(bold(x)), quad quad bold(x)(t_0) = bold(x)^0,
$] <eq:autonomous-system>

where $bold(x) = (x, y)^T$ and $bold(f)(bold(x)) = (F(x, y), G(x, y))^T$.

#definition(name: "Phase Space and Trajectories")[
- The *phase space* is the domain $D subset.eq bb(R)^2$.
- A *phase trajectory* (or *orbit*) is the curve traced by a solution $bold(x)(t)$ in the phase space as $t$ varies.
- A *phase portrait* is the collection of all typical trajectories, with arrows indicating the direction of increasing $t$.
] <def:phase-space>

#definition(name: "Critical Points")[
A point $bold(x)^*$ where $bold(f)(bold(x)^*) = bold(0)$ is called a *critical point* (or *equilibrium point*, *singular point*).
] <def:critical-point>

At a critical point, the solution is constant: $bold(x)(t) = bold(x)^*$ for all $t$. The local behavior of trajectories near a critical point determines the qualitative dynamics of the system.

== Lyapunov Stability // Lyapunov 稳定性

We now define stability concepts for an equilibrium point $bold(x)^*$ of the autonomous system @eq:autonomous-system.

#definition(name: "Lyapunov Stability")[
The equilibrium point $bold(x)^*$ is
- *Lyapunov stable* if for every $epsilon > 0$, there exists $delta = delta(epsilon) > 0$ such that every solution $bold(x)(t)$ with $norm(bold(x)(t_0) - bold(x)^*) < delta$ satisfies $norm(bold(x)(t) - bold(x)^*) < epsilon$ for all $t >= t_0$.
- *asymptotically stable* if it is Lyapunov stable, and there exists $delta_0 > 0$ such that $norm(bold(x)(t_0) - bold(x)^*) < delta_0$ implies $lim_(t -> oo) bold(x)(t) = bold(x)^*$.
- *unstable* if it is not Lyapunov stable.
] <def:lyapunov-stability>

#note[
These definitions are geometric: stability means trajectories starting nearby stay nearby; asymptotic stability means trajectories starting nearby actually converge to the equilibrium.
]

== Lyapunov Methods // Lyapunov 方法

Direct Lyapunov methods allow us to determine stability without solving the equations explicitly.

#definition(name: "Lyapunov Function")[
A continuously differentiable function $V: D -> bb(R)$ is called a *Lyapunov function* for the equilibrium $bold(x)^*$ if:
- $V(bold(x)^*) = 0$,
- $V(bold(x)) > 0$ for all $bold(x) != bold(x)^*$ in some neighborhood of $bold(x)^*$,
- The derivative along trajectories $dot(V)(bold(x)) = nabla V(bold(x)) dot bold(x) = sum_(i=1)^n (partial V) / (partial x_i) f_(i)(bold(x))$ satisfies $dot(V)(bold(x)) <= 0$ in that neighborhood.
] <def:lyapunov-function>

#theorem(name: "Lyapunov's Stability Theorem")[
If there exists a Lyapunov function $V$ for the equilibrium $bold(x)^*$, then $bold(x)^*$ is Lyapunov stable.
If additionally $dot(V)(bold(x)) < 0$ for all $bold(x) != bold(x)^*$, then $bold(x)^*$ is asymptotically stable.
] <thm:lyapunov-stability>

#note[
The function $V$ can be thought of as a generalized "energy" or "distance" from the equilibrium. The condition $dot(V) <= 0$ means that this "energy" does not increase along trajectories.
]

#figure(
  image("img/lyapunov-function.svg", width: 75%),
  caption: [Lyapunov function $V(x,y) = x^2 + y^2$ (dashed contours) and a typical trajectory. The trajectory moves toward lower level sets of $V$, converging to the equilibrium at the origin.],
  placement: auto,
  supplement: [Fig.]
) <fig:lyapunov-function>

== Critical Points and Limit Cycles // 奇点与极限环

For two-dimensional systems, the behavior near a critical point can be classified by linearization. Let $bold(x)^*$ be a critical point, and let $bold(A) = bold(D) bold(f)(bold(x)^*)$ be the Jacobian matrix at $bold(x)^*$.

The local behavior is determined by the eigenvalues of $bold(A)$:

#tex-table(
  ("Eigenvalues", "Type of Critical Point", "Stability"),
  ("Real, both positive", "Unstable node", "Unstable"),
  ("Real, both negative", "Stable node", "Asymptotically stable"),
  ("Real, opposite signs", "Saddle", "Unstable"),
  ("Complex, positive real part", "Unstable focus", "Unstable"),
  ("Complex, negative real part", "Stable focus", "Asymptotically stable"),
  ("Purely imaginary", "Center", "Lyapunov stable"),
)

#figure(
  image("img/phase-plane-types.svg", width: 90%),
  caption: [Phase portraits of the four main critical point types: stable node (top-left), saddle (top-right), stable focus (bottom-left), and center (bottom-right).],
  placement: auto,
  supplement: [Fig.]
) <fig:critical-point-types>

#definition(name: "Limit Cycle")[
A *limit cycle* is an isolated closed trajectory (periodic orbit) in the phase plane.
] <def:limit-cycle>

#theorem(name: "Poincaré-Bendixson Theorem")[
Let $D$ be a bounded region in the plane, and let $bold(x)(t)$ be a trajectory that remains in $D$ for all $t >= t_0$. Then the trajectory either approaches a critical point, or approaches a periodic orbit (limit cycle).
] <thm:poincare-bendixson>

#note[
The Poincaré-Bendixson theorem is a deep result that restricts the possible asymptotic behavior of planar flows. In dimensions three and higher, chaotic behavior is possible, which is excluded in the plane.
]

#figure(
  image("img/limit-cycle.svg", width: 75%),
  caption: [Limit cycle in the Van der Pol oscillator. Trajectories starting inside the cycle spiral outward, while those starting outside spiral inward, all approaching the same closed orbit.],
  placement: auto,
  supplement: [Fig.]
) <fig:limit-cycle>

#part("Boundary Value Problems and Spectral Theory") // 边值问题与谱论

= Boundary Value Problems // 边值问题

This chapter studies boundary value problems (BVPs) for linear ODEs, where conditions are specified at two endpoints of an interval rather than at a single initial point. The central object is the Sturm-Liouville problem, whose eigenfunctions form an orthogonal basis for expanding arbitrary functions — the foundation of Fourier series and spectral methods.

== Boundary Value Problems vs. Initial Value Problems // 边值问题与初值问题

An initial value problem (IVP) specifies all conditions at a single point $x = x_0$:
$
  y(x_0) = y_0, quad quad y'(x_0) = y_(1, 0), quad quad dots, quad quad y^((n-1))(x_0) = y_((n-1), 0).
$

A boundary value problem specifies conditions at two endpoints $x = a$ and $x = b$:
$
  cases(
    alpha_1 y(a) + alpha_2 y'(a) = c_1,
    beta_1 y(b) + beta_2 y'(b) = c_2,
  )
$

Unlike IVPs, which always have a unique solution (under mild conditions), BVPs may have no solution, a unique solution, or infinitely many solutions — depending on the parameter values.

#example(name: "A Simple BVP")[
Consider the second-order equation
$
  y'' + lambda y = 0, quad quad y(0) = 0, quad quad y(pi) = 0.
$
- If $lambda < 0$, the only solution is $y equiv 0$.
- If $lambda = 0$, the only solution is $y equiv 0$.
- If $lambda = n^2$ for integer $n$, there are non-trivial solutions $y(x) = C sin(n x)$.
- If $lambda > 0$ is not a perfect square, the only solution is $y equiv 0$.
] <ex:simple-bvp>

This example shows that non-trivial solutions exist only for special values of $lambda$, called *eigenvalues*.

== Linear BVPs and Green's Functions // 线性边值问题与格林函数

Consider the general second-order linear non-homogeneous boundary value problem
$
  y'' + p(x) y' + q(x) y = f(x), quad quad y(a) = c_1, quad quad y(b) = c_2.
$

Unlike IVPs, which always have a unique solution under mild conditions, BVPs have a more nuanced existence theory.

#theorem(name: "Fredholm Alternative")[
For the linear BVP
$
  L y = f, quad quad B_(1)(y) = c_1, quad quad B_(2)(y) = c_2,
$
exactly one of the following holds:
1. The homogeneous problem $L y = 0, B_(1)(y) = 0, B_(2)(y) = 0$ has only the trivial solution $y equiv 0$. Then the non-homogeneous problem has a unique solution for any $f, c_1, c_2$.
2. The homogeneous problem has $k$ linearly independent non-trivial solutions. Then the non-homogeneous problem has solutions if and only if $f$ is orthogonal (with respect to the appropriate inner product) to all solutions of the adjoint homogeneous problem. In that case, there are infinitely many solutions.
] <thm:fredholm-alternative>

#note[
The Fredholm alternative is the infinite-dimensional analog of the linear algebra fact: a square matrix $A$ is either invertible (unique solution for every right-hand side) or has a nontrivial null space (solutions exist only for right-hand sides orthogonal to the left null space).
]

When the homogeneous BVP has only the trivial solution, we can construct the solution explicitly using the *Green's function*.

#definition(name: "Green's Function")[
Let the homogeneous BVP
$
  y'' + p(x) y' + q(x) y = 0, quad quad y(a) = 0, quad quad y(b) = 0
$
have only the trivial solution. The *Green's function* $G(x, xi)$ for this BVP is the function satisfying:
1. For each fixed $xi in (a, b)$, $G(x, xi)$ satisfies the homogeneous ODE in $x$ on both intervals $(a, xi)$ and $(xi, b)$.
2. $G(x, xi)$ satisfies the boundary conditions $G(a, xi) = G(b, xi) = 0$.
3. $G(x, xi)$ is continuous at $x = xi$.
4. The derivative has a jump discontinuity at $x = xi$:
   $
     (partial G) / (partial x) |_(xi^+) - (partial G) / (partial x) |_(xi^-) = 1.
   $
] <def:greens-function>

#theorem(name: "Solution Representation via Green's Function")[
If $G(x, xi)$ is the Green's function for the homogeneous BVP, then the unique solution of
$
  y'' + p(x) y' + q(x) y = f(x), quad quad y(a) = 0, quad quad y(b) = 0
$
is given by
#eq[$
  y(x) = integral_a^b G(x, xi) f(xi) dif xi.
$] <eq:greens-solution>
] <thm:greens-representation>

#note[
The Green's function is the continuous analog of the matrix inverse: the solution operator $f mapsto y$ is an integral operator with kernel $G(x, xi)$, just as solving $A bold(x) = bold(bold(b))$ in linear algebra gives $bold(x) = A^(-1) bold(b)$.
]

#example(name: "Green's Function for $y'' = 0$ with Dirichlet BCs")[
Consider the BVP $y'' = 0, y(0) = 0, y(1) = 0$. The Green's function is
$
  G(x, xi) = cases(
    x(1 - xi), & x <= xi,
    xi(1 - x), & x >= xi.
  )
$
It is symmetric: $G(x, xi) = G(xi, x)$, which reflects the self-adjointness of the differential operator.
] <ex:greens-simple>

== Sturm-Liouville Problems // Sturm-Liouville 问题

#definition(name: "Sturm-Liouville Equation")[
A *Sturm-Liouville equation* has the form
#eq[$
  - (d) / (d x) lr(p(x) (d y) / (d x)) + q(x) y = lambda r(x) y,
$] <eq:sturm-liouville>
where $p(x) > 0$, $r(x) > 0$, and $q(x)$ are continuous on $[a, b]$.
] <def:sturm-liouville>

The functions $p$, $q$, and $r$ are the coefficients of the Sturm-Liouville operator, and $r(x)$ is called the *weight function*.

#definition(name: "Regular Sturm-Liouville Problem")[
A *regular Sturm-Liouville problem* on $[a, b]$ consists of the equation @eq:sturm-liouville together with boundary conditions
$
  cases(
    alpha_1 y(a) + alpha_2 y'(a) = 0,
    beta_1 y(b) + beta_2 y'(b) = 0,
  )
$
where $alpha_1, alpha_2$ are not both zero, and $beta_1, beta_2$ are not both zero.
] <def:regular-slp>

These are *homogeneous* boundary conditions (the right-hand side is zero).

=== Self-Adjointness and the Inner Product // 自伴性与内积

The Sturm-Liouville equation can be written in operator form:
$
  L y = lambda r(x) y,
$
where the *Sturm-Liouville operator* is
$
  L = - (d) / (d x) lr(p(x) (d) / (d x)) + q(x).
$

#definition(name: "Weighted Inner Product")[
For two functions $u(x), v(x)$ on $[a, b]$, the *weighted inner product* with weight $r(x)$ is
$
  ⟨ u, v ⟩_(r) = integral_a^b u(x) v(x) r(x) dif x.
$
Two functions are *orthogonal* with respect to this inner product if $⟨ u, v ⟩_(r) = 0$.
] <def:weighted-inner-product>

#theorem(name: "Self-Adjointness of the Sturm-Liouville Operator")[
For functions $u, v$ satisfying the regular Sturm-Liouville boundary conditions, the operator $L$ is self-adjoint with respect to the weighted inner product:
$
  ⟨ L u, v ⟩_(r) = ⟨ u, L v ⟩_(r).
$
] <thm:self-adjoint>

#proof[
Integrate by parts twice:
$
  integral_a^b (L u) v r dif x = - integral_a^b (p u')' v dif x + integral_a^b q u v r dif x
  = - p u' v |_a^b + integral_a^b p u' v' dif x + integral_a^b q u v r dif x.
$
The boundary term $-p u' v |_a^b$ vanishes because of the boundary conditions. Repeating the integration by parts for $u v'$ gives the symmetric expression, hence $⟨ L u, v ⟩_(r) = ⟨ u, L v ⟩_(r)$.
]

=== Periodic and Singular Sturm-Liouville Problems // 周期与奇异 Sturm-Liouville 问题

#definition(name: "Periodic Sturm-Liouville Problem")[
A *periodic Sturm-Liouville problem* has periodic boundary conditions:
$
  y(a) = y(b), quad quad y'(a) = y'(b),
$
in addition to $p(a) = p(b)$. This is the setting for the full Fourier series (sine and cosine).
] <def:periodic-slp>

#definition(name: "Singular Sturm-Liouville Problem")[
A Sturm-Liouville problem is *singular* if at least one endpoint is singular: either $p(a) = 0$ or $p(b) = 0$, or the interval is unbounded. The boundary conditions are replaced by appropriate boundedness/integrability conditions.
] <def:singular-slp>

#note[
Singular Sturm-Liouville problems give rise to classical special functions: Legendre's equation (singular endpoints at $x = +-1$), Bessel's equation (singular at $x = 0$), and Hermite/Laguerre equations (unbounded intervals).
]

== Eigenvalues and Eigenfunctions // 特征值与特征函数

#definition(name: "Eigenvalues and Eigenfunctions")[
A value of $lambda$ for which the regular Sturm-Liouville problem has a non-trivial solution is called an *eigenvalue*. The corresponding non-trivial solution is called an *eigenfunction*.
] <def:sl-eigenvalue>

#theorem(name: "Real Eigenvalues")[
All eigenvalues of a regular Sturm-Liouville problem are real.
] <thm:real-eigenvalues>

#proof[
Suppose $lambda = alpha + i beta$ is a complex eigenvalue with eigenfunction $y = u + i v$. Taking the complex conjugate, $overline(lambda) = alpha - i beta$ is also an eigenvalue with eigenfunction $overline(y) = u - i v$. By orthogonality,
$
  integral_a^b y overline(y) r dif x = 0,
$
since $lambda != overline(lambda)$. But $y overline(y) = abs(y)^2 > 0$ unless $y equiv 0$, a contradiction. Hence $beta = 0$, so $lambda$ is real.
]

#theorem(name: "Properties of Sturm-Liouville Eigenvalues")[
For a regular Sturm-Liouville problem:
1. The eigenvalues form an infinite sequence $lambda_1 < lambda_2 < lambda_3 < dots$ with $lambda_n -> oo$.
2. All eigenvalues are real.
3. Eigenfunctions corresponding to distinct eigenvalues are orthogonal with respect to the weight function $r(x)$:
   $
     integral_a^b y_(m)(x) y_(n)(x) r(x) dif x = 0, quad quad m != n.
   $
4. The eigenfunctions form a complete orthogonal basis: any piecewise smooth function $f(x)$ can be expanded as a generalized Fourier series
   $
     f(x) = sum_(n=1)^oo c_n y_(n)(x),
   $
   where $c_n = (integral_a^b f(x) y_(n)(x) r(x) dif x) / (integral_a^b y_n^2(x) r(x) dif x)$.
] <thm:sl-properties>

#theorem(name: "Sturm Oscillation Theorem")[
For the $n$-th eigenfunction $y_(n)(x)$ of a regular Sturm-Liouville problem:
- $y_(n)(x)$ has exactly $n - 1$ zeros in the open interval $(a, b)$.
- Consecutive eigenfunctions' zeros interlace: between any two consecutive zeros of $y_(n)(x)$ there is exactly one zero of $y_(n+1)(x)$.
] <thm:sturm-oscillation>

#note[
The oscillation theorem explains the ordering of eigenvalues: higher eigenfunctions oscillate faster, hence correspond to larger eigenvalues. This is also the origin of the uncertainty principle intuition: more oscillation = higher energy = higher eigenvalue.
]

#theorem(name: "Asymptotic Behavior of Eigenvalues")[
For large $n$, the eigenvalues of a regular Sturm-Liouville problem satisfy
$
  lambda_n ~ (n pi / L)^2, quad quad L = integral_a^b sqrt(r(x) / p(x)) dif x.
$
The eigenfunctions oscillate asymptotically like $sin(n pi (x - a) / L)$.
] <thm:eigenvalue-asymptotics>

== Generalized Fourier Series // 广义傅里叶级数

#note[
This theorem is the spectral theorem for self-adjoint differential operators. The Sturm-Liouville operator is self-adjoint with respect to the inner product weighted by $r(x)$, which is why its eigenvalues are real and its eigenfunctions are orthogonal.
]

#figure(
  image("img/sturm-liouville-eigenfunctions.svg", width: 85%),
  caption: [First three eigenfunctions of the Sturm-Liouville problem $y'' + lambda y = 0, y(0) = y(pi) = 0$. Each higher eigenfunction has one additional node (zero crossing) in the interval $(0, pi)$.],
  placement: auto,
  supplement: [Fig.]
) <fig:sl-eigenfunctions>

#example(name: "Fourier Sine Series")[
The classic Fourier sine series is the Sturm-Liouville problem
$
  y'' + lambda y = 0, quad quad y(0) = 0, quad quad y(pi) = 0.
$
The eigenvalues are $lambda_n = n^2$, and the eigenfunctions are $y_(n)(x) = sin(n x)$. Orthogonality is with respect to the weight $r(x) = 1$:
$
  integral_0^pi sin(m x) sin(n x) dif x = pi / 2 delta_(m n).
$
] <ex:fourier-sine>

=== Convergence of Generalized Fourier Series // 广义傅里叶级数的收敛性

#theorem(name: "Mean Square Convergence")[
The generalized Fourier series converges in the mean-square sense:
$
  lim_(N -> oo) integral_a^b abs(f(x) - sum_(n=1)^N c_n y_(n)(x))^2 r(x) dif x = 0.
$
This is the Hilbert space interpretation: the eigenfunctions form an orthonormal basis in $L^2([a, b], r(x) dif x)$.
] <thm:l2-convergence>

#theorem(name: "Pointwise Convergence")[
If $f(x)$ is piecewise smooth on $[a, b]$, then the generalized Fourier series converges pointwise:
- At points where $f$ is continuous, the series converges to $f(x)$.
- At jump discontinuities, the series converges to the average $(f(x^+) + f(x^-)) / 2$.
] <thm:pointwise-convergence>

=== Other Examples // 其他例子

#example(name: "Fourier Cosine Series (Neumann Boundary)")[
The problem
$
  y'' + lambda y = 0, quad quad y'(0) = 0, quad quad y'(pi) = 0
$
has eigenvalues $lambda_n = n^2$ and eigenfunctions $y_(n)(x) = cos(n x)$. The corresponding expansion is the Fourier cosine series, which represents even functions on $[0, pi]$ extended to $[-pi, pi]$.
] <ex:fourier-cosine>

#example(name: "Full Fourier Series (Periodic Boundary)")[
The periodic problem
$
  y'' + lambda y = 0, quad quad y(-pi) = y(pi), quad quad y'(-pi) = y'(pi)
$
has eigenvalues $lambda_0 = 0$ and $lambda_n = n^2$ for $n >= 1$. The eigenfunctions are $1, cos(x), sin(x), cos(2x), sin(2x), dots$ — the full Fourier series basis.
] <ex:fourier-full>

#example(name: "Legendre Polynomials (Singular SL Problem)")[
Legendre's equation
$
  - (d) / (d x) lr((1 - x^2) y') = lambda y, quad quad x in (-1, 1)
$
is a singular Sturm-Liouville problem with $p(x) = 1 - x^2$ vanishing at both endpoints. The eigenvalues are $lambda_n = n(n + 1)$, and the eigenfunctions are the Legendre polynomials $P_n(x)$. They are orthogonal with weight $r(x) = 1$ on $[-1, 1]$.
] <ex:legendre>

#bibliography("references.bib")
