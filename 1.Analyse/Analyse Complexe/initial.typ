#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Analyse Complexe",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Analyse Complexe",
  "Violet",
  subtitle: "A notebook for complex analysis",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This is a notebook for complex analysis.",
)

#make-outline(depth: 2, title: "Contents")


#part("Basic Complex Analysis") // 基础复分析
#include "chapters/ComplexNumber.typ" // 复数与复平面

#part("Complex Integration") // 复积分
#include "chapters/ComplexIntegral.typ" // 复积分




#bibliography("references.bib")

// 目录

// --- Part I: Foundations of Complex Analysis (复分析基础) ---

// Chapter 1: Complex Numbers and Complex Plane (复数与复平面)
//   Section 1.1: Complex Numbers and Their Geometric Representation (复数与其几何表示)
//   Section 1.2: Polar Form and Euler's Formula (极坐标形式与欧拉公式)
//   Section 1.3: Powers and Roots of Complex Numbers (复数的幂与根)
//   Section 1.4: The Extended Complex Plane and Riemann Sphere (扩充复平面与黎曼球)
//   Section 1.5: Topology of the Complex Plane (复平面的拓扑)

// Chapter 2: Complex Functions (复函数)
//   Section 2.1: Definition and Basic Properties (定义与基本性质)
//   Section 2.2: Limits and Continuity (极限与连续性)
//   Section 2.3: Differentiability and Cauchy-Riemann Equations (可微性与柯西-黎曼方程)
//   Section 2.4: Analytic Functions (解析函数)
//   Section 2.5: Harmonic Functions (调和函数)
//   Section 2.6: Conformal Mappings (共形映射)

// Chapter 3: Elementary Functions (初等函数)
//   Section 3.1: Exponential Function (指数函数)
//   Section 3.2: Trigonometric and Hyperbolic Functions (三角函数与双曲函数)
//   Section 3.3: Logarithmic Function (对数函数)
//   Section 3.4: Complex Powers (复数幂)
//   Section 3.5: Inverse Trigonometric Functions (反三角函数)

// --- Part II: Complex Integration (复积分) ---

// Chapter 4: Complex Integral (复积分)
//   Section 4.1: Definition of Complex Integral (复积分的定义)
//   Section 4.2: Properties of Complex Integral (复积分的性质)
//   Section 4.3: Contour Integrals (围道积分)
//   Section 4.4: Path Independence (路径无关性)

// Chapter 5: Cauchy's Theorem and Integral Formula (柯西定理与积分公式)
//   Section 5.1: Cauchy-Goursat Theorem (柯西-古尔萨定理)
//   Section 5.2: Cauchy Integral Formula (柯西积分公式)
//   Section 5.3: Cauchy Integral Formula for Derivatives (导数的柯西积分公式)
//   Section 5.4: Morera's Theorem (莫雷拉定理)
//   Section 5.5: Liouville's Theorem (刘维尔定理)
//   Section 5.6: Fundamental Theorem of Algebra (代数基本定理)

// Chapter 6: Applications of Cauchy Integral Formula (柯西积分公式的应用)
//   Section 6.1: Maximum Modulus Principle (最大模原理)
//   Section 6.2: Mean Value Property (平均值性质)
//   Section 6.3: Schwarz Lemma (施瓦茨引理)
//   Section 6.4: Identity Theorem (恒等定理)
//   Section 6.5: Weierstrass Convergence Theorem (魏尔斯特拉斯收敛定理)

// --- Part III: Series Representations (级数表示) ---

// Chapter 7: Power Series (幂级数)
//   Section 7.1: Convergence of Power Series (幂级数的收敛性)
//   Section 7.2: Radius of Convergence (收敛半径)
//   Section 7.3: Taylor Series (泰勒级数)
//   Section 7.4: Laurent Series (洛朗级数)
//   Section 7.5: Uniqueness of Series Representations (级数表示的唯一性)

// Chapter 8: Residue Theory (留数理论)
//   Section 8.1: Isolated Singularities (孤立奇点)
//   Section 8.2: Classification of Singularities (奇点的分类)
//   Section 8.3: Residues and Their Calculation (留数及其计算)
//   Section 8.4: Residue Theorem (留数定理)
//   Section 8.5: Argument Principle (辐角原理)
//   Section 8.6: Rouché's Theorem (儒歇定理)

// Chapter 9: Evaluation of Real Integrals (实积分的计算)
//   Section 9.1: Integrals of Rational Functions (有理函数的积分)
//   Section 9.2: Integrals Involving Trigonometric Functions (含三角函数的积分)
//   Section 9.3: Improper Integrals (反常积分)
//   Section 9.4: Integrals with Branch Cuts (含割线的积分)
//   Section 9.5: Summation of Series (级数求和)

// --- Part IV: Conformal Mapping (共形映射) ---

// Chapter 10: Theory of Conformal Mapping (共形映射理论)
//   Section 10.1: Conformal Mapping and Analytic Functions (共形映射与解析函数)
//   Section 10.2: Local Properties of Analytic Functions (解析函数的局部性质)
//   Section 10.3: Riemann Mapping Theorem (黎曼映射定理)
//   Section 10.4: Boundary Behavior (边界行为)
//   Section 10.5: Schwarz-Christoffel Transformation (施瓦茨-克里斯托费尔变换)

// Chapter 11: Elementary Conformal Mappings (初等共形映射)
//   Section 11.1: Linear Fractional Transformations (线性分式变换)
//   Section 11.2: Mappings to Canonical Domains (到标准区域的映射)
//   Section 11.3: Mappings of the Unit Disk (单位圆盘的映射)
//   Section 11.4: Mappings of the Upper Half-Plane (上半平面的映射)
//   Section 11.5: Applications to Potential Theory (在势论中的应用)

// --- Part V: Analytic Continuation (解析延拓) ---

// Chapter 12: Analytic Continuation (解析延拓)
//   Section 12.1: Direct Analytic Continuation (直接解析延拓)
//   Section 12.2: Analytic Continuation along a Curve (沿曲线的解析延拓)
//   Section 12.3: Monodromy Theorem (单值性定理)
//   Section 12.4: Branch Points and Branch Cuts (支点与割线)
//   Section 12.5: Riemann Surfaces (黎曼曲面)
//   Section 12.6: Schwarz Reflection Principle (施瓦茨反射原理)

// --- Part VI: Special Functions (特殊函数) ---

// Chapter 13: Gamma and Beta Functions (伽马函数与贝塔函数)
//   Section 13.1: Gamma Function (伽马函数)
//   Section 13.2: Properties of Gamma Function (伽马函数的性质)
//   Section 13.3: Beta Function (贝塔函数)
//   Section 13.4: Relation between Gamma and Beta Functions (伽马函数与贝塔函数的关系)
//   Section 13.5: Stirling's Formula (斯特林公式)

// Chapter 14: Zeta Function and Prime Numbers (ζ函数与素数)
//   Section 14.1: Riemann Zeta Function (黎曼ζ函数)
//   Section 14.2: Euler Product Formula (欧拉乘积公式)
//   Section 14.3: Functional Equation (函数方程)
//   Section 14.4: Riemann Hypothesis (黎曼猜想)
//   Section 14.5: Prime Number Theorem (素数定理)

// Chapter 15: Elliptic Functions (椭圆函数)
//   Section 15.1: Doubly Periodic Functions (双周期函数)
//   Section 15.2: Weierstrass ℘-Function (魏尔斯特拉斯℘函数)
//   Section 15.3: Jacobi Elliptic Functions (雅可比椭圆函数)
//   Section 15.4: Elliptic Integrals (椭圆积分)
//   Section 15.5: Applications (应用)

// --- Part VII: Advanced Topics (进阶主题) ---

// Chapter 16: Entire and Meromorphic Functions (整函数与亚纯函数)
//   Section 16.1: Weierstrass Factorization Theorem (魏尔斯特拉斯分解定理)
//   Section 16.2: Hadamard Factorization Theorem (阿达马分解定理)
//   Section 16.3: Order and Type of Entire Functions (整函数的阶与型)
//   Section 16.4: Mittag-Leffler Theorem (米塔格-莱夫勒定理)
//   Section 16.5: Picard's Theorems (皮卡定理)

// Chapter 17: Harmonic Functions and Dirichlet Problem (调和函数与狄利克雷问题)
//   Section 17.1: Harmonic Functions in the Plane (平面上的调和函数)
//   Section 17.2: Mean Value Property and Maximum Principle (平均值性质与最大值原理)
//   Section 17.3: Poisson Integral Formula (泊松积分公式)
//   Section 17.4: Dirichlet Problem for the Unit Disk (单位圆盘上的狄利克雷问题)
//   Section 17.5: Dirichlet Problem for General Domains (一般区域上的狄利克雷问题)

// Chapter 18: Asymptotic Methods (渐近方法)
//   Section 18.1: Method of Steepest Descent (最速下降法)
//   Section 18.2: Saddle Point Method (鞍点法)
//   Section 18.3: Watson's Lemma (沃森引理)
//   Section 18.4: Laplace's Method (拉普拉斯方法)
//   Section 18.5: Applications to Special Functions (在特殊函数中的应用)

// 结构说明：
// 本目录分为七个部分，共18章。Part I 建立复分析基础，从复数与复平面到复函数与初等函数；Part II 系统阐述复积分理论，包括柯西定理与积分公式及其应用；Part III 讨论级数表示，涵盖幂级数、留数理论与实积分计算；Part IV 研究共形映射理论及其应用；Part V 讨论解析延拓与黎曼曲面；Part VI 介绍伽马函数、ζ函数与椭圆函数等特殊函数；Part VII 涵盖整函数、调和函数与渐近方法等进阶主题。整体编排遵循从基础到应用、从局部到整体、从经典到现代的逻辑主线。