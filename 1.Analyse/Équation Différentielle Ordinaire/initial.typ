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

#bibliography("references.bib")
