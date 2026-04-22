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

// --- Part I: Mathematical Foundations (数学基础) ---

// Chapter 1: Hilbert Spaces and Linear Operators (希尔伯特空间与线性算符)
//   Section 1.1: Vector Spaces and Inner Products (向量空间与内积)
//   Section 1.2: Hilbert Spaces: Completeness and Basis (希尔伯特空间：完备性与基)
//   Section 1.3: Linear Operators and Their Properties (线性算符及其性质)
//   Section 1.4: Hermitian, Unitary and Projection Operators (厄米算符、幺正算符与投影算符)
//   Section 1.5: Spectral Theory and Eigenvalue Problems (谱理论与本征值问题)
//   Section 1.6: Dirac Notation: Bras, Kets and Brackets (狄拉克符号：左矢、右矢与括号)

// Chapter 2: Fourier Analysis and Representations (傅里叶分析与表象)
//   Section 2.1: Fourier Series and Transforms (傅里叶级数与变换)
//   Section 2.2: Position and Momentum Representations (坐标表象与动量表象)
//   Section 2.3: Change of Basis and Unitary Transformations (基变换与幺正变换)
//   Section 2.4: Wave Packets and Uncertainty (波包与不确定性)

// --- Part II: Foundations of Quantum Mechanics (量子力学基础) ---

// Chapter 3: Postulates of Quantum Mechanics (量子力学公设)
//   Section 3.1: State Vectors and Wave Functions (态矢量与波函数)
//   Section 3.2: Observables and Operators (可观测量与算符)
//   Section 3.3: Measurement and Probability (测量与概率)
//   Section 3.4: Time Evolution and Schrödinger Equation (时间演化与薛定谔方程)
//   Section 3.5: Superposition Principle (叠加原理)
//   Section 3.6: Quantum Entanglement (量子纠缠)

// Chapter 4: The Schrödinger Equation (薛定谔方程)
//   Section 4.1: Time-dependent Schrödinger Equation (含时薛定谔方程)
//   Section 4.2: Time-independent Schrödinger Equation (不含时薛定谔方程)
//   Section 4.3: Stationary States and Energy Eigenstates (定态与能量本征态)
//   Section 4.4: Probability Current and Continuity Equation (概率流与连续性方程)
//   Section 4.5: Wave Function Normalization (波函数归一化)

// Chapter 5: Heisenberg Uncertainty Principle (海森堡不确定性原理)
//   Section 5.1: Position-Momentum Uncertainty (位置-动量不确定性)
//   Section 5.2: General Uncertainty Relations (一般不确定性关系)
//   Section 5.3: Minimum Uncertainty States (最小不确定性态)
//   Section 5.4: Heisenberg's Microscope (海森堡显微镜)

// --- Part III: One-Dimensional Problems (一维问题) ---

// Chapter 6: Free Particle and Wave Packets (自由粒子与波包)
//   Section 6.1: Plane Wave Solutions (平面波解)
//   Section 6.2: Gaussian Wave Packets (高斯波包)
//   Section 6.3: Spreading of Wave Packets (波包的扩散)
//   Section 6.4: Group Velocity and Phase Velocity (群速度与相速度)

// Chapter 7: Potential Wells and Barriers (势阱与势垒)
//   Section 7.1: Infinite Square Well (无限深方势阱)
//   Section 7.2: Finite Square Well (有限深方势阱)
//   Section 7.3: Potential Step and Reflection (势阶与反射)
//   Section 7.4: Tunneling through Barriers (势垒贯穿)
//   Section 7.5: Delta Function Potential (δ函数势)
//   Section 7.6: Bound States and Scattering States (束缚态与散射态)

// Chapter 8: Harmonic Oscillator (谐振子)
//   Section 8.1: Classical vs Quantum Oscillator (经典振子与量子振子)
//   Section 8.2: Analytic Solution: Hermite Polynomials (解析解：厄米多项式)
//   Section 8.3: Operator Method: Ladder Operators (算符方法：升降算符)
//   Section 8.4: Zero-point Energy (零点能)
//   Section 8.5: Coherent States (相干态)
//   Section 8.6: Squeezed States (压缩态)

// --- Part IV: Three-Dimensional Problems (三维问题) ---

// Chapter 9: Central Potentials and Angular Momentum (中心势与角动量)
//   Section 9.1: Separation of Variables in Spherical Coordinates (球坐标系分离变量)
//   Section 9.2: Angular Momentum Operators (角动量算符)
//   Section 9.3: Spherical Harmonics (球谐函数)
//   Section 9.4: Quantization of Angular Momentum (角动量的量子化)
//   Section 9.5: Radial Equation and Effective Potential (径向方程与有效势)

// Chapter 10: Hydrogen Atom (氢原子)
//   Section 10.1: Coulomb Potential and Radial Equation (库仑势与径向方程)
//   Section 10.2: Laguerre Polynomials and Radial Functions (拉盖尔多项式与径向函数)
//   Section 10.3: Energy Levels and Degeneracy (能级与简并)
//   Section 10.4: Wave Functions and Probability Distributions (波函数与概率分布)
//   Section 10.5: Orbital Angular Momentum and Quantum Numbers (轨道角动量与量子数)

// Chapter 11: Spin and Identical Particles (自旋与全同粒子)
//   Section 11.1: Stern-Gerlach Experiment (斯特恩-格拉赫实验)
//   Section 11.2: Spin Operators and Pauli Matrices (自旋算符与泡利矩阵)
//   Section 11.3: Spin-1/2 Systems (自旋1/2系统)
//   Section 11.4: Addition of Angular Momenta (角动量耦合)
//   Section 11.5: Identical Particles and Symmetry (全同粒子与对称性)
//   Section 11.6: Bosons and Fermions (玻色子与费米子)
//   Section 11.7: Pauli Exclusion Principle (泡利不相容原理)

// --- Part V: Formalism and Symmetries (形式体系与对称性) ---

// Chapter 12: Heisenberg Picture and Pictures of Quantum Mechanics (海森堡绘景与量子力学绘景)
//   Section 12.1: Schrödinger Picture (薛定谔绘景)
//   Section 12.2: Heisenberg Picture (海森堡绘景)
//   Section 12.3: Interaction Picture (相互作用绘景)
//   Section 12.4: Equivalence of Pictures (绘景的等价性)
//   Section 12.5: Heisenberg Equations of Motion (海森堡运动方程)

// Chapter 13: Density Matrix and Mixed States (密度矩阵与混合态)
//   Section 13.1: Pure and Mixed States (纯态与混合态)
//   Section 13.2: Density Operator and Its Properties (密度算符及其性质)
//   Section 13.3: Ensemble Interpretation (系综诠释)
//   Section 13.4: Von Neumann Entropy (冯诺依曼熵)
//   Section 13.5: Partial Trace and Reduced Density Matrix (偏迹与约化密度矩阵)

// Chapter 14: Symmetry and Conservation Laws (对称性与守恒律)
//   Section 14.1: Symmetry Transformations (对称变换)
//   Section 14.2: Unitary Representations of Symmetries (对称性的幺正表示)
//   Section 14.3: Noether's Theorem in Quantum Mechanics (量子力学中的诺特定理)
//   Section 14.4: Translational Symmetry and Momentum Conservation (平移对称性与动量守恒)
//   Section 14.5: Rotational Symmetry and Angular Momentum Conservation (旋转对称性与角动量守恒)
//   Section 14.6: Time Translation and Energy Conservation (时间平移与能量守恒)

// --- Part VI: Approximation Methods (近似方法) ---

// Chapter 15: Time-independent Perturbation Theory (不含时微扰理论)
//   Section 15.1: Non-degenerate Perturbation Theory (非简并微扰理论)
//   Section 15.2: Degenerate Perturbation Theory (简并微扰理论)
//   Section 15.3: First and Second Order Corrections (一级与二级修正)
//   Section 15.4: Stark Effect (斯塔克效应)
//   Section 15.5: Fine Structure of Hydrogen (氢原子的精细结构)
//   Section 15.6: Zeeman Effect (塞曼效应)

// Chapter 16: Variational Method (变分法)
//   Section 16.1: Variational Principle (变分原理)
//   Section 16.2: Ground State Energy Estimation (基态能量估计)
//   Section 16.3: Trial Wave Functions (试探波函数)
//   Section 16.4: Applications to Helium Atom (在氦原子中的应用)
//   Section 16.5: Linear Variational Method (线性变分法)

// Chapter 17: WKB Approximation (WKB近似)
//   Section 17.1: Semiclassical Approximation (半经典近似)
//   Section 17.2: WKB Wave Functions (WKB波函数)
//   Section 17.3: Connection Formulas (连接公式)
//   Section 17.4: Quantization Condition (量子化条件)
//   Section 17.5: Tunneling in WKB (WKB近似下的隧穿)

// Chapter 18: Time-dependent Perturbation Theory (含时微扰理论)
//   Section 18.1: Time-dependent Perturbation Series (含时微扰级数)
//   Section 18.2: Transition Probabilities (跃迁概率)
//   Section 18.3: Fermi's Golden Rule (费米黄金规则)
//   Section 18.4: Harmonic Perturbations (简谐微扰)
//   Section 18.5: Adiabatic and Sudden Approximations (绝热近似与突然近似)

// --- Part VII: Scattering Theory (散射理论) ---

// Chapter 19: Scattering in One Dimension (一维散射)
//   Section 19.1: Reflection and Transmission Coefficients (反射系数与透射系数)
//   Section 19.2: Scattering Matrix (散射矩阵)
//   Section 19.3: Resonances (共振)

// Chapter 20: Three-Dimensional Scattering (三维散射)
//   Section 20.1: Partial Wave Analysis (分波分析)
//   Section 20.2: Phase Shifts (相移)
//   Section 20.3: Scattering Amplitude and Cross Section (散射振幅与散射截面)
//   Section 20.4: Born Approximation (玻恩近似)
//   Section 20.5: Optical Theorem (光学定理)
//   Section 20.6: Low-energy Scattering and Scattering Length (低能散射与散射长度)

// --- Part VIII: Advanced Topics (进阶主题) ---

// Chapter 21: Path Integral Formulation (路径积分表述)
//   Section 21.1: Feynman's Path Integral (费曼路径积分)
//   Section 21.2: Propagator and Green's Function (传播子与格林函数)
//   Section 21.3: Classical Limit and Stationary Phase (经典极限与稳定相位)
//   Section 21.4: Path Integrals for Free Particle and Harmonic Oscillator (自由粒子与谐振子的路径积分)
//   Section 21.5: Semiclassical Approximation from Path Integrals (从路径积分导出半经典近似)

// Chapter 22: Quantum Dynamics and Coherent States (量子动力学与相干态)
//   Section 22.1: Time Evolution of Wave Packets (波包的时间演化)
//   Section 22.2: Coherent State Dynamics (相干态动力学)
//   Section 22.3: Squeezed States and Quantum Optics (压缩态与量子光学)
//   Section 22.4: Berry Phase (贝里相位)

// Chapter 23: Relativistic Quantum Mechanics (相对论量子力学)
//   Section 23.1: Klein-Gordon Equation (克莱因-戈尔登方程)
//   Section 23.2: Dirac Equation (狄拉克方程)
//   Section 23.3: Dirac Matrices and Spinors (狄拉克矩阵与旋量)
//   Section 23.4: Antiparticles and Negative Energy States (反粒子与负能态)
//   Section 23.5: Non-relativistic Limit and Pauli Equation (非相对论极限与泡利方程)

// Chapter 24: Quantum Information and Entanglement (量子信息与纠缠)
//   Section 24.1: Quantum Bits and Qubits (量子比特)
//   Section 24.2: Bell States and Bell's Inequality (贝尔态与贝尔不等式)
//   Section 24.3: Quantum Entanglement and EPR Paradox (量子纠缠与EPR佯谬)
//   Section 24.4: Quantum Teleportation (量子隐形传态)
//   Section 24.5: Quantum Computing Basics (量子计算基础)

// 结构说明：
// 本目录分为八个部分，共24章。Part I 建立希尔伯特空间与傅里叶分析的数学基础；Part II 阐述量子力学公设、薛定谔方程与不确定性原理等核心基础；Part III 处理一维问题，包括势阱、势垒与谐振子；Part IV 拓展至三维问题，涵盖角动量、氢原子与自旋；Part V 讨论量子力学的形式体系与对称性；Part VI 系统介绍各类近似方法；Part VII 专门讨论散射理论；Part VIII 涵盖路径积分、相对论量子力学与量子信息等进阶主题。整体编排遵循从数学基础到物理原理、从一维到三维、从精确解到近似方法、从基础到前沿的逻辑主线。

