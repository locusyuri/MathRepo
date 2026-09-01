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

// --- Chapter 1: Introduction to PDEs (偏微分方程导论) ---

//   Section 1.1: Basic Concepts and Examples (基本概念与例子)
//     - 偏微分方程的定义、阶、线性与非线性
//     - 典型例子：Laplace、热传导、波动方程的引出

//   Section 1.2: Order, Linearity and Superposition (阶、线性与叠加原理)
//     - 齐次与非齐次方程
//     - 叠加原理及其适用条件

//   Section 1.3: Initial and Boundary Value Problems (初值问题与边值问题)
//     - Cauchy 问题、Dirichlet / Neumann / Robin 边界条件
//     - 典型定解问题的适定性表述

//   Section 1.4: Well-Posedness (适定性: Hadamard 框架)
//     - 存在性、唯一性、连续依赖性
//     - 适定与不适定问题的例子

// --- Chapter 2: First-Order PDEs (一阶偏微分方程) ---

// 设计思路：完整处理一阶 PDE 的理论，包括特征线法、Hamilton-Jacobi 方程
// 和守恒律。本笔记作为一阶 PDE 的主要归属。

//   Section 2.1: Quasilinear Equations (拟线性方程)
//     - 拟线性一阶方程的一般形式
//     - 特征方程组的导出

//   Section 2.2: Method of Characteristics (特征线法)
//     - 特征曲线的几何意义
//     - Cauchy 问题的求解
//     - 特征线法的完整推导与应用

//   Section 2.3: Hamilton-Jacobi Equations (Hamilton-Jacobi 方程)
//     - 方程的导出与物理背景
//     - 特征系统方法
//     - 与经典力学的联系

//   Section 2.4: Conservation Laws in One Space Dimension (一维守恒律)
//     - 守恒律方程的导出
//     - 行波解
//     - 简单例子

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
