#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Analyse Réelle",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Analyse Réelle",
  "Violet",
  subtitle: "A notebook for real analysis",
  institute: "Notiz  Mathematiques",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This is a notebook for real analysis.",
)

#make-outline(depth: 2, title: "Contents")

#part("Measure Theory") // 测度论
#include "chapters/LebesgueMeasure.typ" // 勒贝格测度

#part("Integration Theory") // 积分理论
#include "chapters/LebesgueIntegration.typ" // 勒贝格积分

#part("Function Spaces") // 函数空间
#include "chapters/FunctionSpaces.typ"

#part("Differentiation Theory") // 微分理论 
#include "chapters/Differentiation.typ"

*只有被引用的章节才会被编译和显示在目录中，因此如果你想要显示某个章节，请确保在主文件中正确引用了它。*
refer to @zhou2016


#bibliography("references.bib")

// 目录

// --- Part I: Measure Theory (测度论) ---

// Chapter 1: σ-Algebra and Measure (σ-代数与测度)
//   Section 1.1: Algebra of Sets (集代数)
//   Section 1.2: σ-Algebra and Borel Sets (σ-代数与Borel集)
//   Section 1.3: Measurable Spaces (可测空间)
//   Section 1.4: Measure and Its Properties (测度及其性质)
//   Section 1.5: Finite and σ-Finite Measures (有限测度与σ-有限测度)
//   Section 1.6: Complete Measures (完备测度)

// Chapter 2: Lebesgue Measure (勒贝格测度)
//   Section 2.1: Lebesgue Outer Measure (勒贝格外测度)
//   Section 2.2: Carathéodory Measurable Condition (Carathéodory可测性条件)
//   Section 2.3: Lebesgue Measurable Sets (勒贝格可测集)
//   Section 2.4: Properties of Lebesgue Measure (勒贝格测度的性质)
//   Section 2.5: Non-Measurable Sets (非可测集)
//   Section 2.6: Lebesgue-Stieltjes Measure (勒贝格-斯蒂尔吉斯测度)

// Chapter 3: Measurable Functions (可测函数)
//   Section 3.1: Definition of Measurable Functions (可测函数的定义)
//   Section 3.2: Equivalent Characterizations (等价刻画)
//   Section 3.3: Operations on Measurable Functions (可测函数的运算)
//   Section 3.4: Sequences of Measurable Functions (可测函数列)
//   Section 3.5: Simple Functions (简单函数)
//   Section 3.6: Approximation by Simple Functions (简单函数逼近)
// 
// --- Part II: Integration Theory (积分理论) ---

// Chapter 4: Lebesgue Integration (勒贝格积分)
//   Section 4.1: Integration of Simple Functions (简单函数的积分)
//   Section 4.2: Integration of Non-negative Measurable Functions (非负可测函数的积分)
//   Section 4.3: Integration of General Measurable Functions (一般可测函数的积分)
//   Section 4.4: Integrable Functions (可积函数)
//   Section 4.5: Properties of Lebesgue Integral (勒贝格积分的性质)
//   Section 4.6: Relationship with Riemann Integral (与黎曼积分的关系)

// Chapter 5: Convergence Theorems (收敛定理)
//   Section 5.1: Modes of Convergence (收敛方式)
//   Section 5.2: Monotone Convergence Theorem (单调收敛定理)
//   Section 5.3: Fatou's Lemma (Fatou引理)
//   Section 5.4: Dominated Convergence Theorem (控制收敛定理)
//   Section 5.5: Uniform Integrability (一致可积性)
//   Section 5.6: Vitali Convergence Theorem (Vitali收敛定理)

// Chapter 6: Product Measures and Fubini Theorem (乘积测度与Fubini定理)
//   Section 6.1: Product σ-Algebra (乘积σ-代数)
//   Section 6.2: Product Measure (乘积测度)
//   Section 6.3: Fubini-Tonelli Theorem (Fubini-Tonelli定理)
//   Section 6.4: Fubini's Theorem (Fubini定理)
//   Section 6.5: Applications of Fubini Theorem (Fubini定理的应用)

// --- Part III: Function Spaces (函数空间) ---

// Chapter 7: L^p Spaces (L^p空间)
//   Section 7.1: Definition of L^p Spaces (L^p空间的定义)
//   Section 7.2: Hölder's Inequality (Hölder不等式)
//   Section 7.3: Minkowski's Inequality (Minkowski不等式)
//   Section 7.4: Completeness of L^p Spaces (L^p空间的完备性)
//   Section 7.5: Duality of L^p Spaces (L^p空间的对偶)
//   Section 7.6: L^2 Space as Hilbert Space (L^2空间作为希尔伯特空间)

// Chapter 8: Convergence in L^p (L^p中的收敛)
//   Section 8.1: Convergence in Norm (范数收敛)
//   Section 8.2: Weak Convergence (弱收敛)
//   Section 8.3: Strong vs Weak Convergence (强收敛与弱收敛)
//   Section 8.4: Dense Subspaces of L^p (L^p的稠密子空间)
//   Section 8.5: Approximation by Continuous Functions (连续函数逼近)

// --- Part IV: Differentiation Theory (微分理论) ---

// Chapter 9: Differentiation of Measures (测度的微分)
//   Section 9.1: Signed Measures (有号测度)
//   Section 9.2: Hahn Decomposition (Hahn分解)
//   Section 9.3: Jordan Decomposition (Jordan分解)
//   Section 9.4: Radon-Nikodym Theorem (Radon-Nikodym定理)
//   Section 9.5: Radon-Nikodym Derivative (Radon-Nikodym导数)

// Chapter 10: Differentiation of Functions (函数的微分)
//   Section 10.1: Functions of Bounded Variation (有界变差函数)
//   Section 10.2: Absolutely Continuous Functions (绝对连续函数)
//   Section 10.3: Lebesgue Differentiation Theorem (勒贝格微分定理)
//   Section 10.4: Fundamental Theorem of Calculus for Lebesgue Integral (勒贝格积分的基本定理)
//   Section 10.5: Density Points and Lebesgue Points (密度点与勒贝格点)

// Chapter 11: Covering Lemmas and Maximal Functions (覆盖引理与极大函数)
//   Section 11.1: Vitali Covering Lemma (Vitali覆盖引理)
//   Section 11.2: Hardy-Littlewood Maximal Function (Hardy-Littlewood极大函数)
//   Section 11.3: Weak Type Estimates (弱型估计)
//   Section 11.4: Lebesgue Differentiation via Maximal Functions (通过极大函数证明勒贝格微分定理)

// --- Part V: Advanced Topics (进阶主题) ---

// Chapter 12: Fourier Analysis on L^p (L^p上的傅里叶分析)
//   Section 12.1: Fourier Transform on L^1 (L^1上的傅里叶变换)
//   Section 12.2: Fourier Transform on L^2 (L^2上的傅里叶变换)
//   Section 12.3: Plancherel Theorem (Plancherel定理)
//   Section 12.4: Inversion Formula (反演公式)
//   Section 12.5: Convolution and Approximate Identities (卷积与近似单位元)

// Chapter 13: Hausdorff Measure and Dimension (Hausdorff测度与维数)
//   Section 13.1: Hausdorff Measure (Hausdorff测度)
//   Section 13.2: Hausdorff Dimension (Hausdorff维数)
//   Section 13.3: Fractal Sets (分形集)
//   Section 13.4: Relationship with Lebesgue Measure (与勒贝格测度的关系)

// Chapter 14: Abstract Measure Theory (抽象测度论)
//   Section 14.1: Regular Measures (正则测度)
//   Section 14.2: Borel Measures on Locally Compact Spaces (局部紧空间上的Borel测度)
//   Section 14.3: Riesz Representation Theorem (Riesz表示定理)
//   Section 14.4: Weak Convergence of Measures (测度的弱收敛)
//   Section 14.5: Prokhorov's Theorem (Prokhorov定理)

// Chapter 15: Applications (应用)
//   Section 15.1: Change of Variables Formula (变量替换公式)
//   Section 15.2: Surface Measure and Integration on Manifolds (曲面测度与流形上的积分)
//   Section 15.3: Sobolev Spaces (Sobolev空间)
//   Section 15.4: Applications to PDEs (在偏微分方程中的应用)
//   Section 15.5: Applications to Probability Theory (在概率论中的应用)

// 结构说明：
// 本目录分为五个部分，共15章。Part I 建立测度论基础，从σ-代数到勒贝格测度再到可测函数；Part II 系统阐述积分理论，包括勒贝格积分、收敛定理与Fubini定理；Part III 研究L^p函数空间及其收敛性；Part IV 讨论微分理论，涵盖测度的微分、函数的微分与极大函数理论；Part V 涵盖傅里叶分析、Hausdorff测度、抽象测度论与应用等进阶主题。整体编排遵循从测度到积分、从积分到函数空间、从积分到微分、从基础到应用的逻辑主线。
