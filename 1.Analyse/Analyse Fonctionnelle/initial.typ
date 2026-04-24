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
  version: "v0.2.0",
  extra-info: "This is a notebook for functional analysis.",
)

#make-outline(depth: 2, title: "Contents")


#part("Basic Functional Analysis") // 基础泛函分析





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

// Structure note:
// This outline is organized into 4 Parts and 11 Chapters.
// Part I builds the metric and normed-space foundation needed throughout the notebook.
// Part II collects the core Banach-space theorems and duality theory in one coherent block.
// Part III develops Hilbert-space geometry and operator theory, which naturally mirror each other.
// Part IV closes with compact operators, spectral theory, and weak-convergence applications.