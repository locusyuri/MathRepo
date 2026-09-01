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
  version: "v0.3.0",
  extra-info: "This is a notebook for functional analysis.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
// 主线叙事：度量与赋范空间 → Banach 空间 → Hilbert 空间 → 紧算子与谱理论
//
// 职责边界 (SRP Boundaries)：
// - 本笔记负责：Banach/Hilbert 空间抽象理论、算子理论、谱理论、弱收敛方法
// - Fourier 级数与 Fourier 变换 → Analyse Harmonique（本笔记 §7.4 仅从 Hilbert 空间视角讨论）
// - Sobolev 空间理论 → Analyse Harmonique（本笔记仅引用其定义与嵌入定理）
// - 分布理论 → Équations aux Dérivées Partielles
// - L^p 空间的一般测度论基础 → Analyse Réelle（本笔记仅引用结果）
//
// 与 PDE 笔记的衔接：
// - 本笔记 §8.4 (二次型与变分方法)、§11.4 (微分方程与变分问题) 为 PDE 弱解理论提供泛函基础
// - PDE 笔记中的弱形式、Lax-Milgram 定理、Galerkin 方法均引用本笔记的抽象框架




#bibliography("references.bib")

// 目录

// --- Part I: Metric and Normed Spaces (度量与赋范空间) ---

// Chapter 1: Metric Spaces and Topological Preliminaries (度量空间与拓扑预备)
//   Section 1.1: Metric Spaces and Basic Examples (度量空间与基本例子)
//   Section 1.2: Open Sets, Closed Sets and Completeness (开集、闭集与完备性)
//   Section 1.3: Convergence, Cauchy Sequences and Completeness Criteria (收敛、柯西列与完备性判别)
//   Section 1.4: Compactness and Total Boundedness (紧致性与全有界性)

// Chapter 2: Normed Vector Spaces (赋范线性空间)
//   Section 2.1: Norms and Normed Spaces (范数与赋范空间)
//   Section 2.2: Equivalent Norms and Basic Examples (等价范数与基本例子)
//   Section 2.3: Subspaces, Quotient Spaces and Product Spaces (子空间、商空间与积空间)
//   Section 2.4: Continuous Linear Maps (连续线性映射)
//   Section 2.5: Bounded Operators and Operator Norms (有界算子与算子范数)

// --- Part II: Banach Space Theory (Banach 空间理论) ---

// Chapter 3: Completeness and Fundamental Constructions (完备性与基本构造)
//   Section 3.1: Banach Spaces (Banach 空间)
//   Section 3.2: Completion of Normed Spaces (赋范空间的完备化)
//   Section 3.3: Series in Banach Spaces (Banach 空间中的级数)
//   Section 3.4: Spaces of Continuous Functions and Sequence Spaces (连续函数空间与序列空间)

// Chapter 4: Fundamental Theorems of Functional Analysis (泛函分析基本定理)
//   Section 4.1: Hahn-Banach Theorem (Hahn-Banach 定理)
//   Section 4.2: Uniform Boundedness Principle (一致有界原理)
//   Section 4.3: Open Mapping Theorem (开映射定理)
//   Section 4.4: Closed Graph Theorem (闭图像定理)

// Chapter 5: Duality and Reflexivity (对偶性与自反性)
//   Section 5.1: Dual Spaces and Continuous Linear Functionals (对偶空间与连续线性泛函)
//   Section 5.2: Weak and Weak-* Topologies (弱拓扑与弱*拓扑)
//   Section 5.3: Reflexive Spaces (自反空间)
//   Section 5.4: Separability and Separating Families (可分性与分离族)

// --- Part III: Hilbert Space Theory (Hilbert 空间理论) ---

// Chapter 6: Inner Product Spaces (内积空间)
//   Section 6.1: Inner Products and Induced Norms (内积与诱导范数)
//   Section 6.2: Orthogonality and Pythagorean Identity (正交性与勾股恒等式)
//   Section 6.3: Cauchy-Schwarz and Triangle Inequalities (柯西-施瓦茨不等式与三角不等式)
//   Section 6.4: Hilbert Spaces and Completion (Hilbert 空间与完备化)

// Chapter 7: Orthonormal Systems and Projection (标准正交系与投影)
//   Section 7.1: Orthonormal Bases (标准正交基)
//   Section 7.2: Gram-Schmidt Process (Gram-Schmidt 正交化)
//   Section 7.3: Projection Theorem (投影定理)
//   Section 7.4: Fourier Series in Hilbert Spaces (Hilbert 空间中的傅里叶级数)

// Chapter 8: Operators on Hilbert Spaces (Hilbert 空间上的算子)
//   Section 8.1: Adjoint Operators (伴随算子)
//   Section 8.2: Self-Adjoint, Unitery and Normal Operators (自伴、酉与正规算子)
//   Section 8.3: Spectral Properties of Bounded Operators (有界算子的谱性质)
//   Section 8.4: Quadratic Forms and Variational Methods (二次型与变分方法)

// --- Part IV: Compact Operators and Spectral Theory (紧算子与谱理论) ---

// Chapter 9: Compact Operators (紧算子)
//   Section 9.1: Compactness in Operator Theory (算子论中的紧性)
//   Section 9.2: Finite-Rank Operators and Approximation (有限秩算子与逼近)
//   Section 9.3: Spectral Properties of Compact Operators (紧算子的谱性质)
//   Section 9.4: Fredholm Alternative (Fredholm 备择)

// Chapter 10: Spectral Theory (谱理论)
//   Section 10.1: Spectrum and Resolvent Set (谱与预解集)
//   Section 10.2: Spectral Radius and Gelfand Theory (谱半径与 Gelfand 理论)
//   Section 10.3: Spectral Theorem for Compact Self-Adjoint Operators (紧自伴算子的谱定理)
//   Section 10.4: Spectral Theorem for Normal Operators (正规算子的谱定理)

// Chapter 11: Weak Convergence and Applications (弱收敛与应用)
//   Section 11.1: Weak Convergence in Banach Spaces (Banach 空间中的弱收敛)
//   Section 11.2: Weak Compactness and Reflexive Methods (弱紧性与自反方法)
//   Section 11.3: Applications to Integral Equations (积分方程中的应用)
//   Section 11.4: Applications to Differential Equations and Variational Problems (微分方程与变分问题中的应用)

// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循"度量与赋范空间 → Banach 空间 → Hilbert 空间 → 紧算子与谱理论"的四段式主线，
// 共 4 Part、11 Chapter。
//
// Part I（Ch 1-2）：度量与赋范空间基础，建立拓扑与线性结构的基本框架。
// Part II（Ch 3-5）：Banach 空间理论，涵盖完备性、三大基本定理与对偶理论。
// Part III（Ch 6-8）：Hilbert 空间理论，内积几何、正交系与算子理论。
// Part IV（Ch 9-11）：紧算子与谱理论，弱收敛方法及其在积分/微分方程中的应用。
//
// 本笔记为 PDE 弱解理论提供泛函分析基础（§8.4 变分方法、§11.4 微分方程应用）。
// Fourier 级数与 Sobolev 空间的完整理论参见 Analyse Harmonique。
// ==========================================================================