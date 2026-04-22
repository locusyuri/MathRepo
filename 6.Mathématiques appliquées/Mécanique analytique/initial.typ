#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Mécanique Analytique", // 理论力学
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Mécanique Analytique",
  "Violet",
  subtitle: "A notebook for mechanics",
  institute: "Notiz Physique",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This is a notebook for mechanics.",
)

#make-outline(depth: 2, title: "Contents")


#part("Basic Real Analysis") // 基础实分析


// 目录

// --- Part I: Mathematical Foundations (数学基础) ---

// Chapter 1: Variational Calculus (变分法)
//   Section 1.1: Functionals and Variations (泛函与变分)
//   Section 1.2: Euler-Lagrange Equation (欧拉-拉格朗日方程)
//   Section 1.3: First Integrals and Conservation Laws (首次积分与守恒律)
//   Section 1.4: Variational Problems with Constraints (带约束的变分问题)
//   Section 1.5: Multi-variable Variational Problems (多元变分问题)
//   Section 1.6: Hamilton's Principle (哈密顿原理)

// Chapter 2: Generalized Coordinates and Constraints (广义坐标与约束)
//   Section 2.1: Degrees of Freedom and Generalized Coordinates (自由度与广义坐标)
//   Section 2.2: Holonomic and Non-holonomic Constraints (完整约束与非完整约束)
//   Section 2.3: Virtual Displacements and Virtual Work (虚位移与虚功)
//   Section 2.4: D'Alembert's Principle (达朗贝尔原理)

// --- Part II: Lagrangian Mechanics (拉格朗日力学) ---

// Chapter 3: Lagrange's Equations (拉格朗日方程)
//   Section 3.1: Lagrangian Function (拉格朗日函数)
//   Section 3.2: Derivation from Hamilton's Principle (从哈密顿原理推导)
//   Section 3.3: Lagrange's Equations of the Second Kind (第二类拉格朗日方程)
//   Section 3.4: Generalized Forces (广义力)
//   Section 3.5: Lagrange's Equations with Constraints (带约束的拉格朗日方程)
//   Section 3.6: Lagrange Multipliers in Mechanics (力学中的拉格朗日乘子)

// Chapter 4: Conservation Laws in Lagrangian Mechanics (拉格朗日力学中的守恒律)
//   Section 4.1: Cyclic Coordinates and Generalized Momenta (循环坐标与广义动量)
//   Section 4.2: Energy Conservation (能量守恒)
//   Section 4.3: Noether's Theorem (诺特定理)
//   Section 4.4: Momentum Conservation and Translational Symmetry (动量守恒与平移对称性)
//   Section 4.5: Angular Momentum Conservation and Rotational Symmetry (角动量守恒与旋转对称性)

// Chapter 5: Applications of Lagrangian Mechanics (拉格朗日力学的应用)
//   Section 5.1: Central Force Motion (中心力运动)
//   Section 5.2: Rigid Body Dynamics (刚体动力学)
//   Section 5.3: Small Oscillations (小振动)
//   Section 5.4: Normal Modes and Eigenfrequencies (简正模与本征频率)
//   Section 5.5: Coupled Oscillators (耦合振子)

// --- Part III: Hamiltonian Mechanics (哈密顿力学) ---

// Chapter 6: Hamilton's Equations (哈密顿方程)
//   Section 6.1: Legendre Transformation (勒让德变换)
//   Section 6.2: Hamiltonian Function (哈密顿函数)
//   Section 6.3: Canonical Equations of Motion (正则运动方程)
//   Section 6.4: Hamiltonian for Common Systems (常见系统的哈密顿量)
//   Section 6.5: Phase Space and Phase Portraits (相空间与相图)

// Chapter 7: Canonical Transformations (正则变换)
//   Section 7.1: Generating Functions (生成函数)
//   Section 7.2: Types of Generating Functions (生成函数的类型)
//   Section 7.3: Conditions for Canonical Transformations (正则变换的条件)
//   Section 7.4: Poisson Brackets (泊松括号)
//   Section 7.5: Invariants under Canonical Transformations (正则变换下的不变量)
//   Section 7.6: Symplectic Structure (辛结构)

// Chapter 8: Hamilton-Jacobi Theory (哈密顿-雅可比理论)
//   Section 8.1: Hamilton-Jacobi Equation (哈密顿-雅可比方程)
//   Section 8.2: Separation of Variables (分离变量法)
//   Section 8.3: Action-Angle Variables (作用量-角变量)
//   Section 8.4: Complete Integrals and Characteristics (完全积分与特征线)
//   Section 8.5: Applications to Central Force Problems (在中心力问题中的应用)

// --- Part IV: Advanced Topics (进阶主题) ---

// Chapter 9: Liouville's Theorem and Statistical Mechanics (刘维尔定理与统计力学)
//   Section 9.1: Liouville's Theorem (刘维尔定理)
//   Section 9.2: Phase Space Volume Conservation (相空间体积守恒)
//   Section 9.3: Ergodicity and Mixing (遍历性与混合)
//   Section 9.4: Poincaré Recurrence Theorem (庞加莱回归定理)

// Chapter 10: Perturbation Theory (微扰理论)
//   Section 10.1: Time-independent Perturbation Theory (不含时微扰理论)
//   Section 10.2: Time-dependent Perturbation Theory (含时微扰理论)
//   Section 10.3: Adiabatic Invariants (绝热不变量)
//   Section 10.4: Canonical Perturbation Theory (正则微扰理论)

// Chapter 11: Integrable Systems (可积系统)
//   Section 11.1: Complete Integrability (完全可积性)
//   Section 11.2: Lax Pairs (Lax对)
//   Section 11.3: Inverse Scattering Method (逆散射方法)
//   Section 11.4: Examples of Integrable Systems (可积系统示例)

// Chapter 12: Stability and Chaos (稳定性与混沌)
//   Section 12.1: Linear Stability Analysis (线性稳定性分析)
//   Section 12.2: Lyapunov Exponents (李雅普诺夫指数)
//   Section 12.3: Poincaré Sections (庞加莱截面)
//   Section 12.4: Bifurcations (分岔)
//   Section 12.5: Routes to Chaos (通向混沌的道路)

// --- Part V: Relativistic and Field Extensions (相对论与场的推广) ---

// Chapter 13: Relativistic Mechanics (相对论力学)
//   Section 13.1: Relativistic Lagrangian (相对论拉格朗日量)
//   Section 13.2: Relativistic Hamiltonian (相对论哈密顿量)
//   Section 13.3: Electromagnetic Interactions (电磁相互作用)
//   Section 13.4: Covariant Formulation (协变形式)

// Chapter 14: Classical Field Theory (经典场论)
//   Section 14.1: Lagrangian Density (拉格朗日密度)
//   Section 14.2: Field Equations from Variational Principle (从变分原理推导场方程)
//   Section 14.3: Noether's Theorem for Fields (场的诺特定理)
//   Section 14.4: Stress-Energy Tensor (应力-能量张量)
//   Section 14.5: Examples: Scalar and Electromagnetic Fields (示例：标量场与电磁场)

// 结构说明：
// 本目录分为五个部分，共14章。Part I 建立变分法与广义坐标的数学基础；Part II 系统阐述拉格朗日力学，从方程推导到守恒律再到具体应用；Part III 深入哈密顿力学，包括正则变换与哈密顿-雅可比理论；Part IV 涵盖刘维尔定理、微扰理论、可积系统与混沌等进阶主题；Part V 将分析力学推广至相对论与经典场论。整体编排遵循从基础到进阶、从有限自由度到无限自由度的逻辑主线。


