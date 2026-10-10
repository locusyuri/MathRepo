#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Algèbre Linéaire", // 线性代数
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Algèbre Linéaire", // 线性代数
  "Violet",
  subtitle: "A notebook for linear algebra",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.1.0",
  extra-info: "This is a notebook for linear algebra.",
)

#make-outline(depth: 2, title: "Contents")

// 目录

// ==========================================================================
// Part I — Determinants, Matrices and Linear Systems (行列式、矩阵与线性方程组)
// ==========================================================================
// 设计思路：本 Part 建立线性代数的具体计算工具——行列式是矩阵可逆性的判据，
// 矩阵是线性映射的坐标表示，线性方程组是这三个工具的综合应用。
// 对应教材：丘维声 §1–3、谢启鸿 §1–3、王萼芳 §1–3。

#part("Determinants, Matrices and Linear Systems") // 行列式、矩阵与线性方程组

= Preliminaries // 预备知识

This chapter collects the notational conventions used throughout the notebook.
Set-theoretic and mapping basics are quoted from the Théorie des Ensembles note
rather than redefined here.

== Notations // 符号说明

The set of all $m times n$ matrices over the number field $P$ is denoted by $M_(m times n)(P)$ or $P^(m times n)$.
Similarly, the set of all linear mappings from $V$ to $V'$ over the field $F$
is represented by $upright("Hom")(V, V')$ or $upright("L")(V, V')$.
Furthermore, when considering the set of all linear transformations,
it is commonly denoted by $upright("Hom")(V)$, $upright("L")(V)$, or $upright("End")(V)$.

The rank of a matrix $A$ is denoted by $upright("rank")(A)$ or $r(A)$.
Two square matrices $A$ and $B$ are called *similar*, denoted $A ~ B$,
if there exists an invertible matrix $P$ such that $B = P^(-1) A P$.
The characteristic polynomial of $A$ is $f(lambda) = |lambda E - A|$,
and the minimal polynomial is the monic polynomial $m(lambda)$ of least degree
such that $m(A) = 0$.

= Determinants // 行列式

行列式是方阵的一个标量值，既是矩阵可逆性的判据，也是 Cramer 法则和特征值理论的基础。
本章从排列的逆序数出发定义行列式，逐步建立其性质、展开法则与特殊行列式的计算。

== Permutations // 排列

// TODO: 排列、逆序数、奇偶性、n 阶行列式的定义

== Determinant and Its Properties // 行列式及其性质

// TODO: 行列式的基本性质（转置、交换行、倍乘、倍加、拆分）

== Expanding by Rows and Columns // 按行（列）展开

// TODO: 余子式与代数余子式、Laplace 展开、Cramer 法则

== Special Determinants // 特殊行列式

// TODO: Vandermonde 行列式、Arrow 行列式、Two-Triangular 行列式

= Matrices // 矩阵

矩阵是线性映射的坐标表示，也是线性方程组的系数载体。
本章涵盖矩阵的基本运算、特殊方阵的性质、逆矩阵的求法、分块矩阵技巧以及秩的运算性质。

== Basic Operations // 基本运算

// TODO: 加法、数乘、转置、乘法、行列式乘积公式、Cauchy-Binet 公式、矩阵等价

== Special Square Matrices // 特殊方阵

// TODO: 对角矩阵、基本矩阵、三角矩阵（含 LU 分解）、初等矩阵、对称矩阵、循环矩阵、幂零矩阵、满秩矩阵

== Inverse Matrix // 逆矩阵

// TODO: 逆矩阵的定义与运算、等价命题与求逆方法、广义逆

== Block Matrix // 分块矩阵

// TODO: 分块运算、Kronecker 积、行列式降阶公式

== Operations of Rank // 秩的运算

// TODO: 加法不等式、乘法不等式（Sylvester、Frobenius）、转置与逆的秩

== Low-Rank Corrections // 低秩修正

// TODO: 秩 1 矩阵的性质、Sherman-Morrison 公式、Woodbury 恒等式

= Linear Systems // 线性方程组

线性方程组是线性代数最直接的应用对象。
本章用矩阵的初等变换和秩理论刻画线性方程组解的存在性与结构。

== Elimination Method // 消元法

// TODO: Gauss 消元法、行阶梯形与行最简形

== Rank of Vector Groups and Matrices // 向量组与矩阵的秩

// TODO: 极大线性无关组、向量组的秩、矩阵的秩（行秩=列秩）、初等变换不改变秩

== Solution to Linear Systems // 线性方程组的解

// TODO: 解的存在性判定（系数矩阵秩=增广矩阵秩）、齐次方程组的解空间与基础解系、非齐次方程组的解结构

// ==========================================================================
// Part II — Linear Spaces and Linear Mappings (线性空间与线性映射)
// ==========================================================================
// 设计思路：本 Part 从具体计算上升到抽象结构——线性空间定义了向量及其运算的公理框架，
// 线性映射刻画了空间之间的结构保持关系，矩阵表示建立了"空间↔矩阵"的桥梁。
// 对应教材：丘维声 §4–5、谢启鸿 §4–5、王萼芳 §4–5。

#part("Linear Spaces and Linear Mappings") // 线性空间与线性映射

= Linear Spaces // 线性空间

线性空间是线性代数的抽象基础——将所有具有加法和数乘结构的集合统一到一个公理框架下。
本章建立线性空间的定义、基与维数理论，并讨论子空间的结构性质。

== Linear Spaces and Their Bases // 线性空间与基

// TODO: 线性空间定义与公理、线性组合与线性表示、线性相关与线性无关、极大无关组、
//       维数、基与坐标、Steinitz 替换定理

== Subspaces // 子空间

// TODO: 子空间定义与判定、交与和、维数公式、直和（定义与充要条件）

== Isomorphisms // 同构

// TODO: 同构映射、同构定理、有限维空间的同构分类

== Quotient Spaces // 商空间

// TODO: 商空间定义、商空间的维数、线性映射的诱导映射

== Special Linear Spaces // 特殊线性空间

// TODO: 交换空间 C(A)、其他由矩阵方程定义的子空间

= Linear Mappings // 线性映射

线性映射是保持线性结构的空间之间的映射，是矩阵与空间之间的桥梁。
本章讨论线性映射的定义、运算、核与像、矩阵表示以及特殊线性变换。

== Linear Mappings and Their Computation // 线性映射及其运算

// TODO: 线性映射定义、存在唯一性定理（线性延拓）、加法与数乘、复合（线性变换的代数结构）、代数

== Kernel and Image of Linear Mappings // 线性映射的核与像

// TODO: 核与像、秩-零度定理、余核、升链

== Matrix Representation of Linear Mappings // 线性映射的矩阵表示

// TODO: 矩阵表示的定义、基变换与坐标变换、相似矩阵

== Special Linear Transformations // 特殊线性变换

// TODO: 常见线性变换、幂等变换与投影变换、对合变换、可逆变换的等价命题

== Linear Functions and Dual Spaces // 线性函数与对偶空间

// TODO: 线性函数、对偶空间、对偶基

// ==========================================================================
// Part III — Structure Theory of Linear Operators (线性算子的结构理论)
// ==========================================================================
// 设计思路：本 Part 研究线性算子的结构——通过相似变换寻找最简矩阵表示。
// 对角化是理想情形（矩阵相似于对角矩阵），Jordan 标准型是普适情形（任意矩阵相似于 Jordan 块直和）。
// 对应教材：丘维声 §6–7、谢启鸿 §6–7、王萼芳 §6–7。

#part("Structure Theory of Linear Operators") // 线性算子的结构理论

= Diagonalization // 对角化

对角化是线性算子结构理论的第一步——寻找一组基使线性算子的矩阵表示最简化。
本章讨论相似关系、特征值与特征向量、极小多项式、空间分解以及对角化的充要条件。

== Similarity of Matrices // 矩阵的相似

// TODO: 相似矩阵定义、相似不变量（行列式、秩、迹、特征多项式）、相似变换的应用

== Eigenvectors and Eigenvalues // 特征向量与特征值

// TODO: 特征值与特征向量定义、特征多项式、特征值的性质（和=迹、积=行列式）、
//       几何重数与代数重数、特征子空间、Gerschgorin 圆盘定理

== Minimal Polynomial // 极小多项式

// TODO: 零化多项式、极小多项式定义与性质、Cayley-Hamilton 定理

== Space Decomposition // 空间分解

// TODO: 不变子空间、块上三角与块对角、根子空间、根空间分解定理

== Diagonalization // 对角化

// TODO: 对角化的等价条件（n 个线性无关特征向量 / 几何重数=代数重数 / 直和分解 / 极小多项式无重根）

== Diagonalization of Special Matrices // 特殊矩阵的对角化

// TODO: 可逆矩阵、幂等矩阵、幂零矩阵、对合矩阵、全 1 矩阵、循环移位矩阵、循环矩阵、三角矩阵的对角化

== Simultaneous Characteristics Induced by Commutativity // 交换性诱导的同时性质

// TODO: 特征空间互为不变子空间、公共特征向量、同时上三角化、同时对角化

= Jordan Canonical Form // Jordan 标准型

Jordan 标准型是线性算子结构理论的普适结果——任意方阵相似于 Jordan 块的直和。
本章通过多项式矩阵的 Smith 标准型建立不变因子与初等因子理论，最终导出 Jordan 标准型的存在性与计算方法。

== Polynomial Matrices // 多项式矩阵

// TODO: 多项式矩阵定义、可逆性（行列式为非零常数）、Smith 标准型

== Invariant Divisors and Rational Canonical Form // 不变因子与有理标准型

// TODO: 行列式因子、不变因子、Frobenius 伴随矩阵、有理标准型（Frobenius 标准型）、循环子空间的几何解释

== Elementary Divisors and Jordan Canonical Form // 初等因子与 Jordan 标准型

// TODO: 初等因子定义、Jordan 块、Jordan 标准型存在性定理、几何解释

== Finding Jordan Canonical Form and Transition Matrices // Jordan 标准型与过渡矩阵的求法

// TODO: 求 Jordan 标准型的方法、求过渡矩阵的方法

== Complete Set of Invariant Quantities for Matrix Similarity // 矩阵相似的完全相似不变量

// TODO: 不变因子组 / 初等因子组作为相似关系的完全不变量

// ==========================================================================
// Part IV — Quadratic Forms and Inner Product Spaces (二次型与内积空间)
// ==========================================================================
// 设计思路：本 Part 将线性代数的结构理论推广到几何场景——二次型是多元函数泰勒展开的二次项，
// 内积空间为向量引入角度与长度概念。两者通过正交变换与合同变换相联系。
// 对应教材：丘维声 §8–9、谢启鸿 §8–9、王萼芳 §8–9。

#part("Quadratic Forms and Inner Product Spaces") // 二次型与内积空间

= Quadratic Forms // 二次型

二次型是多元函数的二次齐次多项式，在优化、几何和物理中有广泛应用。
本章讨论二次型的矩阵表示、合同变换下的标准形与规范形，以及正定二次型的判定。

== Quadratic Forms and Their Standard Forms // 二次型及其标准形

// TODO: 二次型定义、矩阵表示（对称矩阵）、合同变换、配方法、初等变换法

== Canonical Forms // 规范形

// TODO: 复二次型的规范形、实二次型的规范形（惯性定理）、惯性指数

== Definite Quadratic Forms // 正定二次型

// TODO: 正定/半正定/负定/不定二次型定义、正定的充要条件（特征值 / 合同于单位阵 / 顺序主子式 > 0）

= Inner Product Spaces // 内积空间

内积空间为向量引入了长度与角度概念，是 Euclidean 几何的代数推广。
本章涵盖双线性型、实内积空间、标准正交基、正交补与投影、正交变换与对称变换，以及酉空间与正规变换。

== Bilinear Forms // 双线性型

// TODO: 双线性型定义、双线性型的矩阵表示、对称双线性型与二次型的关系

== Real Inner Product Spaces // 实内积空间

// TODO: 内积定义与公理、范数、Cauchy-Schwarz 不等式、距离、角度、正交性、Euclidean 空间

== Metric Matrices and Orthonormal Bases // 度量矩阵与标准正交基

// TODO: Gram 矩阵、标准正交基、正交矩阵、Gram-Schmidt 正交化

== Orthogonal Completion and Orthogonal Projection // 正交补与正交投影

// TODO: 正交补定义与性质、最小二乘法、最佳逼近元、正交投影

== Orthogonal Transformations and Symmetric Transformations // 正交变换与对称变换

// TODO: 正交变换定义与性质、对称变换定义、对称变换的正交对角化

== Unitary Spaces and Normal Transformations // 酉空间与正规变换

// TODO: 复内积空间、酉矩阵、Hermitian 变换、正规变换与正规矩阵的对角化

== Symplectic Spaces // 辛空间

// TODO: 辛内积定义、辛空间的基本性质

// ==========================================================================
// Appendix (附录)
// ==========================================================================

#part("Appendix") // 附录

= Glossary // 术语表

// TODO: 迁移完成后用 violet-glossary-indexer 自动生成

#pagebreak()

#bibliography("references.bib")
