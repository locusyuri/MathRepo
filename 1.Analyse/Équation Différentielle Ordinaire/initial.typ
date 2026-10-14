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

#bibliography("references.bib")
