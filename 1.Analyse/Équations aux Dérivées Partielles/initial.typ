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
  version: "v0.2.0",
  extra-info: "This is a notebook for partial differential equations.",
)

#make-outline(depth: 2, title: "Contents")


#part("Basic Functional Analysis") // 基础泛函分析




#bibliography("references.bib")

// 目录

// --- Part I: Foundations and Classification (基础与分类) ---

// Chapter 1: Introduction to Partial Differential Equations (偏微分方程导论)
//   Section 1.1: Basic Concepts and Examples (基本概念与例子)
//   Section 1.2: Order, Linearity and Superposition (阶、线性与叠加原理)
//   Section 1.3: Initial Value Problems and Boundary Value Problems (初值问题与边值问题)
//   Section 1.4: Well-Posedness, Uniqueness and Stability (适定性、唯一性与稳定性)
//   Section 1.5: Physical Origins of PDEs (PDE 的物理背景)

// Chapter 2: First-Order PDEs (一阶偏微分方程)
//   Section 2.1: Quasilinear Equations (拟线性方程)
//   Section 2.2: Method of Characteristics (特征线法)
//   Section 2.3: Hamilton-Jacobi Equations (Hamilton-Jacobi 方程)
//   Section 2.4: Conservation Laws in One Space Dimension (一维守恒律)

// Chapter 3: Classification of Second-Order PDEs (二阶偏微分方程分类)
//   Section 3.1: Linear Second-Order Equations (线性二阶方程)
//   Section 3.2: Elliptic, Parabolic and Hyperbolic Types (椭圆型、抛物型与双曲型)
//   Section 3.3: Canonical Forms (标准形)
//   Section 3.4: Characteristic Curves and Surfaces (特征曲线与特征面)
//   Section 3.5: Variable-Coefficient Equations (变系数方程)

// --- Part II: Elliptic Equations and Potential Theory (椭圆型方程与势论) ---

// Chapter 4: Harmonic Functions and Laplace Equations (调和函数与拉普拉斯方程)
//   Section 4.1: Laplace's Equation and Poisson's Equation (拉普拉斯方程与泊松方程)
//   Section 4.2: Mean Value Property (平均值性质)
//   Section 4.3: Maximum Principle and Minimum Principle (最大值原理与最小值原理)
//   Section 4.4: Green's Identities (格林恒等式)
//   Section 4.5: Harmonic Measure and Potential Theory (调和测度与势论)

// Chapter 5: Boundary Value Problems for Elliptic Equations (椭圆型方程边值问题)
//   Section 5.1: Dirichlet Problem (狄利克雷问题)
//   Section 5.2: Neumann Problem (纽曼问题)
//   Section 5.3: Mixed and Robin Boundary Conditions (混合与 Robin 边界条件)
//   Section 5.4: Uniqueness and Energy Methods (唯一性与能量方法)
//   Section 5.5: Method of Sub- and Supersolutions (上下解方法)

// Chapter 6: Green Functions, Fundamental Solutions and Regularity (格林函数、基本解与正则性)
//   Section 6.1: Fundamental Solutions (基本解)
//   Section 6.2: Green's Function (格林函数)
//   Section 6.3: Representation Formulas (表示公式)
//   Section 6.4: Interior and Boundary Regularity (内正则性与边界正则性)
//   Section 6.5: Schauder and $L^p$ Estimates (Schauder 估计与 $L^p$ 估计)

// --- Part III: Parabolic Equations and Semigroups (抛物型方程与半群) ---

// Chapter 7: Heat Equation and Diffusion (热方程与扩散)
//   Section 7.1: Heat Kernel and Fundamental Solution (热核与基本解)
//   Section 7.2: Initial Value Problem (初值问题)
//   Section 7.3: Maximum Principle for Parabolic Equations (抛物型方程最大值原理)
//   Section 7.4: Energy Estimates and Smoothing Effect (能量估计与平滑效应)
//   Section 7.5: Long-Time Behavior (长期行为)

// Chapter 8: Linear Parabolic Boundary Value Problems (线性抛物型边值问题)
//   Section 8.1: Dirichlet and Neumann Problems (狄利克雷与纽曼问题)
//   Section 8.2: Comparison Principles (比较原理)
//   Section 8.3: Harnack-Type Inequalities (Harnack 型不等式)
//   Section 8.4: Semigroup Interpretation (半群解释)
//   Section 8.5: Abstract Parabolic Problems (抽象抛物问题)

// Chapter 9: Nonlinear Parabolic Equations (非线性抛物型方程)
//   Section 9.1: Reaction-Diffusion Equations (反应-扩散方程)
//   Section 9.2: Logistic and Fisher-KPP Equations (Logistic 方程与 Fisher-KPP 方程)
//   Section 9.3: Blow-Up and Global Existence (爆破与整体存在)
//   Section 9.4: Fixed Point and Monotone Iteration Methods (不动点法与单调迭代法)

// --- Part IV: Hyperbolic Equations and Conservation Laws (双曲型方程与守恒律) ---

// Chapter 10: Wave Equation (波动方程)
//   Section 10.1: D'Alembert Formula (达朗贝尔公式)
//   Section 10.2: Initial and Boundary Value Problems (初边值问题)
//   Section 10.3: Energy Conservation (能量守恒)
//   Section 10.4: Finite Propagation Speed (有限传播速度)
//   Section 10.5: Duhamel Principle (Duhamel 原理)

// Chapter 11: Linear Hyperbolic Systems (线性双曲系统)
//   Section 11.1: Symmetric Hyperbolic Systems (对称双曲系统)
//   Section 11.2: Diagonalization and Riemann Invariants (对角化与 Riemann 不变量)
//   Section 11.3: Boundary Conditions and Well-Posedness (边界条件与适定性)
//   Section 11.4: Energy Methods (能量方法)

// Chapter 12: Nonlinear Conservation Laws (非线性守恒律)
//   Section 12.1: Weak Solutions (弱解)
//   Section 12.2: Shock Waves and Rarefaction Waves (激波与稀疏波)
//   Section 12.3: Entropy Conditions (熵条件)
//   Section 12.4: Riemann Problems (Riemann 问题)
//   Section 12.5: Scalar Conservation Laws (标量守恒律)

// --- Part V: Functional-Analytic Methods (泛函分析方法) ---

// Chapter 13: Distribution Theory (分布理论)
//   Section 13.1: Test Functions and Distributions (测试函数与分布)
//   Section 13.2: Weak Derivatives (弱导数)
//   Section 13.3: Convolution and Approximation of Identity (卷积与近似恒等)
//   Section 13.4: Support and Regularity of Distributions (分布的支集与正则性)

// Chapter 14: Sobolev Spaces (Sobolev 空间)
//   Section 14.1: Sobolev Spaces and Norms (Sobolev 空间与范数)
//   Section 14.2: Embedding Theorems (嵌入定理)
//   Section 14.3: Compactness Theorems (紧性定理)
//   Section 14.4: Trace Theorems (迹定理)
//   Section 14.5: Poincaré and Friedrichs Inequalities (Poincaré 与 Friedrichs 不等式)

// Chapter 15: Weak Formulations and Variational Methods (弱形式与变分方法)
//   Section 15.1: Weak Formulation of PDEs (PDE 的弱形式)
//   Section 15.2: Lax-Milgram Theorem (Lax-Milgram 定理)
//   Section 15.3: Galerkin Methods (Galerkin 方法)
//   Section 15.4: Variational Principles (变分原理)
//   Section 15.5: A Priori Estimates and Compactness Arguments (先验估计与紧性论证)

// Chapter 16: Evolution Equations in Banach and Hilbert Spaces (Banach 与 Hilbert 空间中的演化方程)
//   Section 16.1: Semigroup Theory (半群理论)
//   Section 16.2: Abstract Cauchy Problems (抽象 Cauchy 问题)
//   Section 16.3: Maximal Regularity (最大正则性)
//   Section 16.4: Mild and Weak Solutions (温和解与弱解)

// --- Part VI: Fourier and Transform Methods (Fourier 与变换方法) ---

// Chapter 17: Fourier Series and Fourier Transform (Fourier 级数与 Fourier 变换)
//   Section 17.1: Fourier Series on Bounded Domains (有界区域上的 Fourier 级数)
//   Section 17.2: Fourier Transform on Euclidean Space (欧氏空间上的 Fourier 变换)
//   Section 17.3: Plancherel and Parseval Identities (Plancherel 与 Parseval 恒等式)
//   Section 17.4: Inversion Formula and Convolution (反演公式与卷积)
//   Section 17.5: Applications to PDEs (PDE 中的应用)

// Chapter 18: Integral Equations and Green-Function Methods (积分方程与格林函数方法)
//   Section 18.1: Fredholm and Volterra Equations (Fredholm 与 Volterra 方程)
//   Section 18.2: Green-Function Representation (格林函数表示)
//   Section 18.3: Boundary Integral Methods (边界积分方法)
//   Section 18.4: Spectral Expansions (谱展开)

// --- Part VII: Advanced Topics and Applications (进阶主题与应用) ---

// Chapter 19: Nonlinear and Fully Nonlinear PDEs (非线性与完全非线性 PDE)
//   Section 19.1: Quasilinear Equations (拟线性方程)
//   Section 19.2: Fully Nonlinear Equations (完全非线性方程)
//   Section 19.3: Viscosity Solutions (粘性解)
//   Section 19.4: Fixed Point and Continuation Methods (不动点与延拓方法)

// Chapter 20: Numerical Methods for PDEs (PDE 数值方法)
//   Section 20.1: Finite Difference Methods (有限差分法)
//   Section 20.2: Finite Element Methods (有限元法)
//   Section 20.3: Finite Volume Methods (有限体积法)
//   Section 20.4: Spectral Methods (谱方法)

// Chapter 21: Applied and Geometric PDEs (应用与几何 PDE)
//   Section 21.1: Fluid Dynamics Models (流体力学模型)
//   Section 21.2: Schrödinger and Klein-Gordon Equations (薛定谔方程与 Klein-Gordon 方程)
//   Section 21.3: Minimal Surfaces and Mean Curvature Flow (极小曲面与平均曲率流)
//   Section 21.4: Inverse Problems and Control (反问题与控制)

// Structure note:
// This outline is organized into 7 Parts and 21 Chapters.
// Part I introduces the language, classification and first-order theory of PDEs.
// Parts II to IV cover the three classical families: elliptic, parabolic and hyperbolic equations.
// Part V collects the functional-analytic machinery that underpins weak solutions and modern PDE theory.
// Part VI adds Fourier, transform and integral-equation methods that are standard in a comprehensive PDE notebook.
// Part VII reserves space for nonlinear, numerical and applied directions, so the notebook can grow without losing the core structure.