#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Électrodynamique",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Électrodynamique",
  "Violet",
  subtitle: "A notebook for electrodynamics",
  institute: "Notiz Physique",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This is a notebook for electrodynamics.",
)

#make-outline(depth: 2, title: "Contents")


#part("Basic Real Analysis") // 基础实分析




// 目录
// ==============================================================================
// Electrodynamics (电动力学) — Table of Contents
// ==============================================================================

// --- Part I: Mathematical Foundations (数学基础) ---

// Chapter 1: Vector Analysis and Field Theory (矢量分析与场论)
//   Section 1.1: Vector Algebra (矢量代数)
//   Section 1.2: Vector Calculus: Gradient, Divergence and Curl (矢量微积分：梯度、散度与旋度)
//   Section 1.3: Line, Surface and Volume Integrals (线积分、面积分与体积分)
//   Section 1.4: Theorems of Gauss, Stokes and Green (高斯定理、斯托克斯定理与格林定理)
//   Section 1.5: Helmholtz Decomposition Theorem (亥姆霍兹分解定理)
//   Section 1.6: Curvilinear Coordinates (曲线坐标系)
//   Section 1.7: Dirac Delta Function (狄拉克δ函数)

// Chapter 2: Tensor Analysis (张量分析)
//   Section 2.1: Cartesian Tensors (笛卡尔张量)
//   Section 2.2: Tensor Operations and Contractions (张量运算与缩并)
//   Section 2.3: Applications in Electrodynamics (在电动力学中的应用)

// --- Part II: Electrostatics (静电学) ---

// Chapter 3: Electrostatic Field (静电场)
//   Section 3.1: Coulomb's Law (库仑定律)
//   Section 3.2: Electric Field Intensity (电场强度)
//   Section 3.3: Gauss's Law and Electric Flux (高斯定律与电通量)
//   Section 3.4: Electric Potential (电势)
//   Section 3.5: Poisson's Equation and Laplace's Equation (泊松方程与拉普拉斯方程)
//   Section 3.6: Electrostatic Energy (静电能)

// Chapter 4: Boundary Value Problems in Electrostatics (静电学边值问题)
//   Section 4.1: Uniqueness Theorems (唯一性定理)
//   Section 4.2: Method of Images (镜像法)
//   Section 4.3: Separation of Variables in Cartesian Coordinates (直角坐标系分离变量法)
//   Section 4.4: Separation of Variables in Spherical Coordinates (球坐标系分离变量法)
//   Section 4.5: Separation of Variables in Cylindrical Coordinates (柱坐标系分离变量法)
//   Section 4.6: Multipole Expansion (多极展开)

// Chapter 5: Electrostatics in Matter (介质中的静电学)
//   Section 5.1: Polarization and Bound Charges (极化与束缚电荷)
//   Section 5.2: Electric Displacement (电位移矢量)
//   Section 5.3: Linear Dielectrics (线性电介质)
//   Section 5.4: Boundary Conditions at Dielectric Interfaces (电介质界面边界条件)
//   Section 5.5: Energy in Dielectric Systems (电介质系统中的能量)

// --- Part III: Magnetostatics (静磁学) ---

// Chapter 6: Magnetostatic Field (静磁场)
//   Section 6.1: Biot–Savart Law (毕奥–萨伐尔定律)
//   Section 6.2: Ampère's Law (安培定律)
//   Section 6.3: Magnetic Vector Potential (磁矢势)
//   Section 6.4: Magnetic Force and Torque (磁力与力矩)
//   Section 6.5: Magnetostatic Energy (静磁能)

// Chapter 7: Magnetostatics in Matter (介质中的静磁学)
//   Section 7.1: Magnetization and Bound Currents (磁化与束缚电流)
//   Section 7.2: Magnetic Field Intensity (磁场强度)
//   Section 7.3: Linear and Nonlinear Magnetic Materials (线性与非线性磁介质)
//   Section 7.4: Boundary Conditions at Magnetic Interfaces (磁介质界面边界条件)

// --- Part IV: Electromagnetic Induction and Time-Varying Fields (电磁感应与时变场) ---

// Chapter 8: Electromagnetic Induction (电磁感应)
//   Section 8.1: Faraday's Law of Induction (法拉第电磁感应定律)
//   Section 8.2: Motional EMF and Induced Electric Field (动生电动势与感应电场)
//   Section 8.3: Inductance (电感)
//   Section 8.4: Magnetic Energy in Circuits (电路中的磁能)

// Chapter 9: Maxwell's Equations (麦克斯韦方程组)
//   Section 9.1: Displacement Current and Ampère–Maxwell Law (位移电流与安培–麦克斯韦定律)
//   Section 9.2: Maxwell's Equations in Vacuum (真空中的麦克斯韦方程组)
//   Section 9.3: Maxwell's Equations in Matter (介质中的麦克斯韦方程组)
//   Section 9.4: Boundary Conditions for Electromagnetic Fields (电磁场边界条件)
//   Section 9.5: Conservation of Energy: Poynting's Theorem (能量守恒：坡印廷定理)

// --- Part V: Electromagnetic Waves (电磁波) ---

// Chapter 10: Electromagnetic Waves in Vacuum (真空中的电磁波)
//   Section 10.1: Wave Equation from Maxwell's Equations (由麦克斯韦方程组导出波动方程)
//   Section 10.2: Plane Wave Solutions (平面波解)
//   Section 10.3: Polarization of Electromagnetic Waves (电磁波的偏振)
//   Section 10.4: Energy and Momentum of Electromagnetic Waves (电磁波的能量与动量)

// Chapter 11: Electromagnetic Waves in Media (介质中的电磁波)
//   Section 11.1: Wave Equation in Linear Media (线性介质中的波动方程)
//   Section 11.2: Reflection and Refraction at Interfaces (界面上的反射与折射)
//   Section 11.3: Fresnel Equations (菲涅尔公式)
//   Section 11.4: Dispersion Relations (色散关系)
//   Section 11.5: Absorption and Complex Refractive Index (吸收与复折射率)

// Chapter 12: Waveguides and Cavities (波导与谐振腔)
//   Section 12.1: Waveguides: TE and TM Modes (波导：TE模与TM模)
//   Section 12.2: Rectangular Waveguide (矩形波导)
//   Section 12.3: Resonant Cavities (谐振腔)

// --- Part VI: Potentials and Radiation (势与辐射) ---

// Chapter 13: Electromagnetic Potentials (电磁势)
//   Section 13.1: Scalar and Vector Potentials (标势与矢势)
//   Section 13.2: Gauge Transformations (规范变换)
//   Section 13.3: Coulomb Gauge and Lorenz Gauge (库仑规范与洛伦兹规范)
//   Section 13.4: Retarded Potentials (推迟势)

// Chapter 14: Radiation (辐射)
//   Section 14.1: Radiation from Point Charges (点电荷的辐射)
//   Section 14.2: Electric Dipole Radiation (电偶极辐射)
//   Section 14.3: Magnetic Dipole Radiation (磁偶极辐射)
//   Section 14.4: Electric Quadrupole Radiation (电四极辐射)
//   Section 14.5: Larmor Formula (拉莫尔公式)
//   Section 14.6: Radiation Reaction (辐射反作用)

// Chapter 15: Scattering and Diffraction (散射与衍射)
//   Section 15.1: Thomson Scattering (汤姆孙散射)
//   Section 15.2: Rayleigh Scattering (瑞利散射)
//   Section 15.3: Diffraction: Kirchhoff's Theory (衍射：基尔霍夫理论)

// --- Part VII: Special Relativity and Electrodynamics (狭义相对论与电动力学) ---

// Chapter 16: Special Relativity (狭义相对论)
//   Section 16.1: Lorentz Transformations (洛伦兹变换)
//   Section 16.2: Four-Vectors and Minkowski Spacetime (四维矢量与闵可夫斯基时空)
//   Section 16.3: Relativistic Kinematics (相对论运动学)
//   Section 16.4: Relativistic Dynamics (相对论动力学)

// Chapter 17: Relativistic Electrodynamics (相对论电动力学)
//   Section 17.1: Electromagnetic Field Tensor (电磁场张量)
//   Section 17.2: Covariant Form of Maxwell's Equations (麦克斯韦方程组的协变形式)
//   Section 17.3: Lorentz Transformation of Fields (电磁场的洛伦兹变换)
//   Section 17.4: Relativistic Lagrangian and Hamiltonian (相对论拉格朗日量与哈密顿量)
//   Section 17.5: Invariants of the Electromagnetic Field (电磁场的不变量)