#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Analyse Fonctionnelle",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Analyse Fonctionnelle",
  "Violet",
  subtitle: "A notebook for functional analysis",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.4.0",
  extra-info: "This is a notebook for functional analysis.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
// 主线叙事：度量与赋范空间 → Banach 空间 → Hilbert 空间 → 紧算子与谱理论
//           → 分布/Sobolev/变分方法 → 无界算子与算子半群。
//
// 两条服务线贯穿全笔记：
//   (i) PDE 线：Ch11 分布 → Ch12 Sobolev → Ch13 变分方法 → Ch15 半群，
//       分别对接 EDP 笔记的弱形式、正则性与抛物篇。
//   (ii) 量子力学线：Ch6–8 Hilbert 几何 → Ch10 谱定理 → Ch14 无界自伴算子。
//
// 教材基线 (Textbook Baselines)：
//   - 主基线：H. Brezis, *Functional Analysis, Sobolev Spaces and PDE* (2011)，
//     Ch 1–9；本笔记 Ch1–Ch13 与其知识点集合对齐。
//   - 补充：W. Rudin, *Functional Analysis* (2nd ed.) Ch 1–6（拓扑向量空间、
//     Baire、凸性、分布、算子）。
//   - 补充：J. B. Conway, *A Course in Functional Analysis* (2nd ed.)（谱测度）。
//   - 半群基线：K.-J. Engel & R. Nagel, *One-Parameter Semigroups for Linear
//     Evolution Equations*（Ch15）。
//   - 完整覆盖度映射见文末 Coverage Mapping。
//
// 职责边界 (SRP Boundaries) —— 终裁，勿再循环推诿：
//   | 内容                                   | 权威归属                | 本笔记的处理              |
//   |----------------------------------------|-------------------------|---------------------------|
//   | 分布、弱导数、卷积与逼近（一般理论）   | 本笔记 Ch11             | 权威版；EDP Ch7–Ch8§8.1   |
//   |                                        |                         | 为 PDE 向最小自足摘要     |
//   | Sobolev 空间 W^{k,p} 定义与基本性质    | 本笔记 Ch12 §12.1–12.2  | 权威版；EDP Ch9 保留最小版|
//   | Sobolev 嵌入与迹定理（含边界正则性）   | EDP Ch9                 | 本笔记 §12.3 只给 R^d 全空间
//   |                                        |                         | 的 Fourier 证明；§12.4 仅陈述
//   | H^s 的 Fourier 刻画与插值              | Analyse Harmonique Pt III | 本笔记仅引用必要结论    |
//   | 基本解与具体核（Laplace/热/波）        | EDP Ch8 §8.2            | 本笔记不重建              |
//   | L^p / 测度论 / Radon 测度              | Analyse Réelle          | 仅引用结果                |
//   | 经典变分法、Euler–Lagrange、Hamilton 原理 | Mécanique analytique Ch6 | 本笔记不重建           |
//   | 现代变分方法（直接法、Lax–Milgram）    | 本笔记 Ch13             | 权威版；EDP Ch10 引用     |
//   | 最优控制（Pontryagin、HJB）            | Optimisation Convexe / EDP Ch15 | 本笔记不涉及       |
//   | 一般点集拓扑（非度量空间）             | 无（本笔记只做度量空间） | 弱拓扑在 Ch5 以对偶配对建立|
//
// 结构决策：
//   - Part IV 收窄为「紧算子 + 谱理论」，Ch11（旧）的弱收敛内容前移至
//     Part II Ch5（对偶与弱拓扑）与 Part IV 的紧性讨论，消除名实不符。
//   - 旧 Ch2 §2.4「连续线性映射」与 §2.5「有界算子」合并为 §2.4，新增
//     §2.5「算子空间」承载完备性与可逆性，避免同一等价命题两次陈述。
//   - 旧 Ch1 §1.2/§1.3 的完备性重复重划：§1.2 只讲开闭集与连续性，
//     §1.3 只讲收敛与完备性；新增 §1.5 Baire 纲定理（Ch4 三大定理的
//     必备前置，旧蓝图缺失）。
//   - 旧 Ch8 §8.3「有界算子的谱性质」限定为定义与基本性质，谱定理统一
//     归 Ch10；§8.4 由「二次型与变分方法」改为「二次型与相伴算子」，
//     变分内容移交 Ch13，避免与 §11.4（旧）重复。
//   - Gelfand 理论由独立 Section 降级为 §10.2 的注记：完整 Gelfand 理论
//     需要交换 Banach 代数，本笔记不设代数章，只保留 Beurling–Gelfand
//     谱半径公式。
//   - 新增 Part V（Ch11–13）与 Part VI（Ch14–15）：前者补齐 PDE 弱解
//     所需的分布/Sobolev/变分三件套，后者补齐抛物方程半群框架与量子
//     力学所需的无界自伴算子理论。
//
// 变更记录：
//   v0.4.0  重构 Part 划分（Ch11 弱收敛前移）；补 Baire 纲定理、Riesz
//           表示、Banach–Alaoglu、Krein–Milman、Fredholm 指标；新增
//           Part V（分布/Sobolev/变分）与 Part VI（无界算子/半群）；
//           Sobolev 与分布的三方归属一次终裁；修正 "Unitery" 拼写；
//           目录蓝图移至 #bibliography 之前并统一注释层级。
//   v0.3.0  初版四段式蓝图（4 Part / 11 Chapter）。

// ==========================================================================
// Part I — Metric and Normed Spaces (度量与赋范空间)
// ==========================================================================
// 设计思路：本 Part 建立全笔记的两层底座——拓扑层（Ch1）与线性层（Ch2）。
// 拓扑层只做度量空间，不引入一般拓扑空间；线性层从范数过渡到连续线性
// 映射与算子空间，为 Part II 的三大定理准备语言。
// 对应教材：Brezis Ch1 前段、Rudin Ch1 前段、Conway Ch1。

// --- Chapter 1: Metric Spaces and Point-Set Preliminaries (度量空间与点集预备) ---
//   Section 1.1: Metric Spaces and Basic Examples (度量空间与基本例子)
//   Section 1.2: Open Sets, Closed Sets and Continuity (开集、闭集与连续性)
//   Section 1.3: Convergence, Cauchy Sequences and Completeness (收敛、柯西列与完备性)
//   Section 1.4: Compactness and Total Boundedness (紧致性与全有界性)
//   Section 1.5: Baire Category Theorem and Its Consequences (Baire 纲定理及其推论)
//      - 稠密开集的可数交、无处稠密集、第一/第二纲
//      - Baire 纲定理在完备度量空间与局部紧空间中的形式
//      - 推论：完备度量空间不可数、开映射与一致有界原理的前置

// --- Chapter 2: Normed Vector Spaces (赋范线性空间) ---
//   Section 2.1: Norms and Normed Spaces (范数与赋范空间)
//   Section 2.2: Equivalent Norms and Basic Examples (等价范数与基本例子)
//   Section 2.3: Subspaces, Quotient Spaces and Product Spaces (子空间、商空间与积空间)
//   Section 2.4: Continuous Linear Maps and Bounded Operators (连续线性映射与有界算子)
//      - 连续 ⟺ 有界 ⟺ 在原点连续（同一定理的三种表述，只证一次）
//      - 算子范数与 ||T|| 的计算
//   Section 2.5: Spaces of Bounded Operators (有界算子空间)
//      - cal(B)(X, Y) 的完备性（Y 完备时）
//      - 可逆算子集的开性、Neumann 级数
//      - 注：一般拓扑向量空间与局部凸结构只在 Ch5 §5.2 按需引入

// ==========================================================================
// Part II — Banach Space Theory (Banach 空间理论)
// ==========================================================================
// 设计思路：本 Part 是泛函分析的「硬核」。Ch3 给完备性与基本构造，Ch4 给
// 三大基本定理（全部以 Ch1 §1.5 的 Baire 纲定理为证明工具），Ch5 把
// Hahn–Banach 的对偶结论系统化为弱拓扑与表示定理。
// 对偶性是本 Part 的终点，也是 Hilbert 篇与 PDE 篇的公共入口。
// 对应教材：Brezis Ch1–Ch5、Rudin Ch2–Ch5、Conway Ch3–Ch5。

// --- Chapter 3: Completeness and Fundamental Constructions (完备性与基本构造) ---
//   Section 3.1: Banach Spaces (Banach 空间)
//   Section 3.2: Completion of Normed Spaces (赋范空间的完备化)
//   Section 3.3: Series, Schauder Bases and Approximation (级数、Schauder 基与逼近)
//      - 绝对收敛与无条件收敛；Weierstrass 判别法
//      - Schauder 基的定义与例（ℓ^p、c_0），逼近性质只作注记
//   Section 3.4: Spaces of Continuous Functions and Sequence Spaces (连续函数空间与序列空间)

// --- Chapter 4: Fundamental Theorems of Functional Analysis (泛函分析基本定理) ---
//   Section 4.1: Hahn-Banach Theorem (Hahn-Banach 定理)
//      - 解析形式：次线性泛函、Minkowski 泛函、Zorn 引理
//      - 几何形式：凸集分离定理（点-闭凸集、两凸集）
//      - 推论：对偶空间分离点、范数可达泛函
//   Section 4.2: Uniform Boundedness Principle (一致有界原理)
//      - Banach–Steinhaus 定理（Baire 纲证明）
//      - 推论：逐点收敛算子列的范数有界
//   Section 4.3: Open Mapping Theorem (开映射定理)
//   Section 4.4: Closed Graph Theorem (闭图像定理)

// --- Chapter 5: Duality, Weak Topologies and Representation (对偶、弱拓扑与表示) ---
//   Section 5.1: Dual Spaces and Continuous Linear Functionals (对偶空间与连续线性泛函)
//   Section 5.2: Dual Pairs and Weak Topologies (对偶配对与弱拓扑)
//      - 对偶配对 <X, X*>、弱拓扑 sigma(X, X*) 与弱*拓扑 sigma(X*, X)
//      - Banach–Alaoglu 定理、弱*紧性、Goldstine 定理（陈述）
//   Section 5.3: Reflexive Spaces (自反空间)
//   Section 5.4: Separability and Separating Families (可分性与分离族)
//   Section 5.5: Riesz Representation Theorems (Riesz 表示定理)
//      - Hilbert 版：H* 与 H 的反线性等距（与 §7.3 投影定理互证）
//      - L^p 版：1 <= p < oo 时 (L^p)* = L^q（测度论细节引用 Analyse Réelle）
//      - C(K) 版：(C(K))* = M(K)（Radon 测度，引用 Analyse Réelle）
//   Section 5.6: Extremal Points and the Krein–Milman Theorem (端点与 Krein-Milman 定理)
//      - 端点、极点的存在性；凸紧集的 Krein–Milman 定理
//      - 应用：单位球的端点刻画、Stone–Weierstrass 的泛函证明（注记）

// ==========================================================================
// Part III — Hilbert Space Theory (Hilbert 空间理论)
// ==========================================================================
// 设计思路：从 Banach 的「范数 + 对偶」升级到「内积 + 正交几何」。正交投影
// 是本 Part 的中心机制，它同时给出最佳逼近、Riesz 表示与谱分解的入口。
// 本 Part 的结论被 Part IV（谱定理）与 Part VI（量子力学线）直接使用。
// 对应教材：Brezis Ch5、Rudin Ch4、Conway Ch1。

// --- Chapter 6: Inner Product Spaces (内积空间) ---
//   Section 6.1: Inner Products and Induced Norms (内积与诱导范数)
//   Section 6.2: Orthogonality and Pythagorean Identity (正交性与勾股恒等式)
//   Section 6.3: Cauchy-Schwarz and Triangle Inequalities (柯西-施瓦茨不等式与三角不等式)
//   Section 6.4: Hilbert Spaces and Completion (Hilbert 空间与完备化)

// --- Chapter 7: Orthonormal Systems and Projection (标准正交系与投影) ---
//   Section 7.1: Orthonormal Bases (标准正交基)
//   Section 7.2: Gram-Schmidt Process (Gram-Schmidt 正交化)
//   Section 7.3: Projection Theorem (投影定理)
//      - 闭凸集上的唯一最佳逼近；正交分解 H = M ⊕ M^perp
//      - Riesz 表示定理的 Hilbert 证明（与 §5.5 对照，不重复测度论部分）
//   Section 7.4: Fourier Series in Hilbert Spaces (Hilbert 空间中的傅里叶级数)
//      - 完备正交系的 Parseval 恒等式；与 Analyse Harmonique 的级数理论分工

// --- Chapter 8: Operators on Hilbert Spaces (Hilbert 空间上的算子) ---
//   Section 8.1: Adjoint Operators (伴随算子)
//   Section 8.2: Self-Adjoint, Unitary and Normal Operators (自伴、酉与正规算子)
//   Section 8.3: Spectrum of Bounded Operators: Basic Properties (有界算子的谱：基本性质)
//      - 只给谱/预解集定义、谱的紧性与极值性质；谱定理归 Ch10
//   Section 8.4: Quadratic Forms and Associated Operators (二次型与相伴算子)
//      - 有界二次型、极化恒等式、Lax–Milgram 所需的强制性概念（证明在 §13.3）
//      - 注：变分方法与极小化子归 Ch13，本节不重复

// ==========================================================================
// Part IV — Compact Operators and Spectral Theory (紧算子与谱理论)
// ==========================================================================
// 设计思路：紧性是「无穷维中的有限维影子」。Ch9 用紧性把算子谱离散化，
// Ch10 把这一结构提升为谱定理。弱收敛方法作为紧性的对偶面，在 §9.1 与
// §5.2 之间建立往返引用，不再单列应用章。
// 对应教材：Brezis Ch6、Rudin Ch4–Ch5、Conway Ch2 与 Ch4。

// --- Chapter 9: Compact Operators (紧算子) ---
//   Section 9.1: Compactness in Operator Theory (算子论中的紧性)
//      - 紧算子定义、与弱收敛的等价刻画（x_n ⇀ x ⟹ T x_n → T x）
//      - 紧算子的复合封闭性、紧性与有限秩逼近
//   Section 9.2: Finite-Rank Operators and Approximation (有限秩算子与逼近)
//   Section 9.3: Spectral Properties of Compact Operators (紧算子的谱性质)
//      - Riesz–Schauder 理论：谱至多可数、仅 0 可能为聚点
//   Section 9.4: Fredholm Alternative (Fredholm 备择)
//   Section 9.5: Fredholm Operators and Index (Fredholm 算子与指标)
//      - Fredholm 算子、指标的定义与 Atkinson 刻画
//      - 指标的同伦不变性与稳定性（只作陈述，应用指向 EDP）

// --- Chapter 10: Spectral Theory (谱理论) ---
//   Section 10.1: Spectrum and Resolvent Set (谱与预解集)
//   Section 10.2: Spectral Radius and the Beurling–Gelfand Formula (谱半径与 Beurling–Gelfand 公式)
//      - r(T) = lim ||T^n||^(1/n) = sup |sigma(T)|
//      - 注：完整 Gelfand 理论（交换 Banach 代数、极大理想空间）不在本笔记范围
//   Section 10.3: Spectral Theorem for Compact Self-Adjoint Operators (紧自伴算子的谱定理)
//   Section 10.4: Spectral Theorem for Bounded Normal Operators (有界正规算子的谱定理)
//      - 连续函数演算路线；谱测度形式只陈述，完整版本见 §14.4

// ==========================================================================
// Part V — Distributions, Sobolev Spaces and Variational Methods
// (分布、Sobolev 空间与变分方法)
// ==========================================================================
// 设计思路：本 Part 是 PDE 线的工具箱，也是本笔记与 EDP 笔记的分工界面。
// Ch11 给「弱」的语言（分布与弱导数），Ch12 给「弱可微」的函数空间，
// Ch13 给「弱解存在」的变分机制。三章构成从语言到空间到存在性的闭环。
// 与 EDP 的关系：本 Part 是一般理论权威版；EDP 的 Part III 是面向 PDE 的
// 最小自足摘要，两者并存但只在一处证明（见文首终裁表）。
// 对应教材：Brezis Ch8–Ch9、Rudin Ch6、Evans 附录 A–B。

// --- Chapter 11: Distributions and Weak Derivatives (分布与弱导数) ---
//   Section 11.1: Test Function Spaces and Their Topologies (测试函数空间及其拓扑)
//      - C_c^oo(Omega)、D(Omega) 的归纳极限拓扑、S(R^d) 的 Fréchet 结构
//      - 与 EDP <def:test-fn-space-D>、<def:test-fn-space-S> 的一致性说明
//   Section 11.2: Distributions and Operations (分布与运算)
//      - D' 的定义、连续性刻画、求导、乘法、坐标变换
//      - S'（缓增分布）作为 D' 的子空间；Fourier 变换片段引用 Analyse Harmonique
//   Section 11.3: Support, Regular Distributions and the Dirac Mass (支撑、正则分布与 Dirac 质量)
//   Section 11.4: Weak Derivatives (弱导数)
//      - 弱导数定义、唯一性、与经典导数的一致性
//      - Sobolev 弱导数的多指标版本；分布意义下的 du Bois-Reymond 引理
//   Section 11.5: Convolution and Mollification (卷积与磨光)
//      - 函数/分布卷积、支集条件、结合律
//      - 磨光核 rho_epsilon、C_c^oo 在 L^p 与 D' 中的稠密性
//      - 注：具体基本解（Laplace/热/波核）的构造归 EDP Ch8 §8.2

// --- Chapter 12: Sobolev Spaces (Sobolev 空间) ---
//   Section 12.1: Definitions of W^{k,p} and H^s (W^{k,p} 与 H^s 的定义)
//      - 整数阶 W^{k,p} 与齐次空间；H^s 的 Fourier 刻画
//      - 与 EDP <def:sobolev-wkp> 的对应关系（定义只写一次，此处为权威版）
//   Section 12.2: Completeness, Reflexivity and Density (完备性、自反性与稠密性)
//      - W^{k,p} 的 Banach/Hilbert 结构、C_c^oo 与 C^oo 的稠密性
//   Section 12.3: Sobolev Embedding and Compactness (Sobolev 嵌入与紧嵌入)
//      - 全空间 R^d 的 Fourier 证明与 Sobolev 不等式
//      - Rellich–Kondrachov 的紧嵌入（有界域版本只陈述）
//      - 分工：有界域与边界正则性版本由 EDP Ch9 证明
//   Section 12.4: Trace Theory (迹理论)
//      - 迹算子与 W^{1,p} 的边界值；只给陈述与思路
//      - 权威证明见 EDP <thm:trace-theorem>，本节不重复
//   Section 12.5: Poincaré and Friedrichs Inequalities (Poincaré 与 Friedrichs 不等式)
//   Section 12.6: Duality, Negative Order and Interpolation (对偶、负阶与插值)
//      - H^(-s) 与 W^(-k,p)；实/复插值只给定义与常用结论
//      - 注：Riesz–Thorin 的完整理论在 Analyse Harmonique / Analyse Réelle

// --- Chapter 13: Variational Methods (变分方法) ---
// 设计思路：本笔记只承担「现代变分方法」，即无穷维极小化与弱解存在性。
// 经典变分法（Euler–Lagrange、Hamilton 原理、约束变分）在
// Mécanique analytique Ch6，本笔记不重建，只引用其结论。
//   Section 13.1: Convex Functionals and Lower Semicontinuity (凸泛函与下半连续性)
//      - 凸性、下半连续、弱下半连续性；凸 ⇒ 弱下半连续
//   Section 13.2: Coercivity and the Direct Method (强制性与直接法)
//      - 强制性、有界性、弱紧性；极小化子的存在性
//      - 与 Optimisation Convexe 的分工：本笔记在无穷维，那里在有限维
//   Section 13.3: The Lax–Milgram Theorem (Lax-Milgram 定理)
//      - 连续双线性型的强制性、存在唯一性；与 Riesz 表示的关系
//      - 对接 EDP Ch10 的 Dirichlet 弱形式
//   Section 13.4: Galerkin Approximation (Galerkin 逼近)
//      - 有限维子空间逼近、Céa 引理、收敛性
//   Section 13.5: Applications to Boundary Value Problems (边值问题中的应用)
//      - 椭圆弱解的存在唯一性（模型问题，计算细节引用 EDP）
//      - Dirichlet 原理与能量极小化的现代表述

// ==========================================================================
// Part VI — Unbounded Operators and Evolution Equations
// (无界算子与演化方程)
// ==========================================================================
// 设计思路：前五个 Part 以有界算子为主。但微分算子（-Delta、i d/dx）在
// 自然定义域上无界，量子力学与抛物方程都必须处理无界情形。Ch14 建立
// 闭算子、伴随与自伴扩张理论；Ch15 把自伴（或扇形）算子的谱理论转化为
// 演化方程的解，服务 EDP 的抛物篇。
// 对应教材：Brezis Ch10（部分）、Conway Ch10、Engel–Nagel Ch1–2。

// --- Chapter 14: Unbounded Operators (无界算子) ---
//   Section 14.1: Closed and Closable Operators (闭算子与可闭算子)
//      - 图像、闭性、可闭性；与 §4.4 闭图像定理的反向对照
//   Section 14.2: Adjoints of Unbounded Operators (无界算子的伴随)
//      - 定义域、共轭算子 T*、von Neumann 关系
//   Section 14.3: Symmetric and Self-Adjoint Operators (对称算子与自伴算子)
//      - 对称 vs 自伴；本质自伴与自伴扩张（Friedrichs 扩张）
//      - 示例：动量算子、Laplace 算子在 H^1_0 上的实现
//   Section 14.4: Spectral Theorem and Functional Calculus (谱定理与函数演算)
//      - 谱测度、投影值测度、Borel 函数演算；与 §10.4 的衔接
//      - 应用：量子力学中的可观测量（交叉引用 Mécanique quantique）

// --- Chapter 15: Semigroups and Evolution Equations (算子半群与演化方程) ---
//   Section 15.1: Strongly Continuous Semigroups (强连续半群)
//      - C_0 半群、生成元、基本性质
//   Section 15.2: The Hille–Yosida Theorem (Hille-Yosida 定理)
//      - 生成元的刻画、预解估计；压缩半群版本
//   Section 15.3: Analytic Semigroups (解析半群)
//      - 扇形算子、解析半群的正则化效应
//   Section 15.4: Applications to Parabolic Equations (抛物方程中的应用)
//      - 热半群的抽象构造；与 EDP Ch13 §13.2 的半群框架对接

// ==========================================================================
// 教材覆盖度映射表 (Coverage Mapping)
// ==========================================================================
// | 教材位置            | 知识点                                   | 本笔记位置              | 备注                          |
// |---------------------|------------------------------------------|-------------------------|-------------------------------|
// | Brezis Ch1          | Hahn–Banach（解析与几何形式）            | Ch4 §4.1                | 直接对应                      |
// | Brezis Ch2          | Baire 纲定理与三大定理                   | Ch1 §1.5 + Ch4 §4.2–4.4 | Baire 前置单独成节            |
// | Brezis Ch3          | 凸集分离、Krein–Milman                   | Ch4 §4.1 + Ch5 §5.6     | 拆分到对偶与凸性两处          |
// | Brezis Ch4          | 弱拓扑、Banach–Alaoglu、自反             | Ch5 §5.2–5.3            | 新增对偶配对框架              |
// | Brezis Ch5          | Hilbert 空间、投影、Riesz 表示           | Ch6–Ch8 + §5.5          | Riesz 表示独立成节            |
// | Brezis Ch6          | 紧算子、Fredholm 备择                    | Ch9 §9.1–9.4            | 新增 §9.5 指标                |
// | Brezis Ch7          | 谱理论（有界/紧自伴）                    | Ch10                    | Gelfand 理论降为注记          |
// | Brezis Ch8.1–8.4    | Sobolev 定义、嵌入、紧嵌入               | Ch12 §12.1–12.3         | 与 EDP Ch9 双轨，权威在此     |
// | Brezis Ch8.5        | 迹定理                                   | Ch12 §12.4（仅陈述）    | 证明权威在 EDP Ch9            |
// | Brezis Ch9          | 变分方法、Lax–Milgram、Galerkin          | Ch13                    | 新增 Part V                   |
// | Rudin Ch1           | 拓扑向量空间、局部凸结构                 | Ch2 §2.5 注记 + §5.2    | 按需引入，不设独立章          |
// | Rudin Ch2           | Baire 纲定理                             | Ch1 §1.5                | 直接对应                      |
// | Rudin Ch3           | 凸性、端点、Krein–Milman                 | Ch5 §5.6                | 直接对应                      |
// | Rudin Ch4           | 对偶性、Banach–Alaoglu                   | Ch5 §5.1–5.3            | 直接对应                      |
// | Rudin Ch5           | 算子、谱、紧算子                         | Ch9–Ch10                | 直接对应                      |
// | Rudin Ch6           | 分布理论                                 | Ch11                    | 新增 Part V，权威在此         |
// | Conway Ch2/Ch4      | 谱定理、函数演算                         | Ch10 §10.4 + Ch14 §14.4 | 有界/无界分开                 |
// | Conway Ch10         | 无界算子、自伴扩张                       | Ch14                    | 新增 Part VI                  |
// | Engel–Nagel Ch1–2   | C_0 半群、Hille–Yosida、解析半群         | Ch15                    | 新增，服务 EDP Ch13           |
// | Evans App A–B       | Sobolev 不等式、嵌入常数                 | Ch12 §12.3              | 只取 R^d 情形                 |
//
// 未覆盖项（有意排除，均已在上表或终裁表注明归属）：
//   - 一般拓扑空间与网/滤子（只做到度量空间与弱拓扑）
//   - 交换 Banach 代数与 Gelfand 理论的完整证明（仅保留谱半径公式）
//   - 算子 K-理论、C*-代数进阶、指标定理（超出本笔记范围）

// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循「底座（度量/赋范）→ Banach → Hilbert → 谱理论 → 工具层
// （分布/Sobolev/变分）→ 无界与演化」的六段式主线，共 6 Part、15 Chapter。
//
// Part I（Ch1–2）：底座。度量空间拓扑 + 赋范线性结构，含 Baire 纲定理。
// Part II（Ch3–5）：Banach 理论。完备性、三大定理、对偶与弱拓扑、
//   Riesz 表示、Krein–Milman。
// Part III（Ch6–8）：Hilbert 几何。内积、正交系、投影、伴随与二次型。
// Part IV（Ch9–10）：紧性与谱。Riesz–Schauder 理论、Fredholm 指标、谱定理。
// Part V（Ch11–13）：PDE 工具箱。分布与弱导数、Sobolev 空间、变分方法。
// Part VI（Ch14–15）：无界算子与半群。自伴扩张、谱测度、Hille–Yosida。
//
// 衔接声明：
//   - 本笔记 Ch11–Ch13 为 EDP 笔记 Part III 与 Ch10 提供一般理论；
//     EDP 保留面向 PDE 的最小自足摘要，二者不构成重复（见终裁表）。
//   - 本笔记 Ch15 为 EDP 抛物篇（Ch13 §13.2）提供半群框架。
//   - 经典变分法在 Mécanique analytique Ch6，本笔记 Ch13 只承担现代变分方法。
//   - H^s 的 Fourier 刻画与插值以 Analyse Harmonique Part III 为准。
// ==========================================================================

#bibliography("references.bib", title: "References", full: true)

// 目录
