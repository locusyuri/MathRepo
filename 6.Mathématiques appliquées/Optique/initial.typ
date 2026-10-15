#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Optique",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Optique",
  "Violet",
  subtitle: "A notebook for optics",
  institute: "Notiz Physique",
  date: datetime.today().display(),
  version: "v0.1.0",
  extra-info: "This is a notebook for optics.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
// 主线叙事：振动与波动（迁入基础）→ 几何光学（短波长极限 λ→0）→
//           波动光学（标量波本体理论）→ 量子光学（场的量子化）
//
// 职责边界 (SRP Boundaries)：
// - 本笔记负责：振动与波动的介质无关机制（自 Mécanique analytique 迁入）、
//   几何光学、波动光学（干涉/衍射/偏振/傅里叶光学）、量子光学（场量子化/光子统计/光与物质作用）
// - 弹性介质小节（应变/应力/泊松比/弹性波 P-S 波/机械阻抗）→ Mécanique analytique
//   （固体力学职责，不随迁；见其 Chapter 4: Elastic Waves in Solids）
// - 拉格朗日小振动/简正模/耦合振子 → Mécanique analytique Part II（本笔记不重复，仅引用）
// - Maxwell 方程与电磁波推导 → Électrodynamique（本笔记 Ch 4 仅搭桥引用其时谐场结论）
// - Fourier 级数/变换完整理论 → Analyse Harmonique（本笔记仅使用其工具）
// - 希尔伯特空间/算符/相干态形式体系 → Mécanique quantique（Part IV 直接使用）
//
// 与相关笔记的衔接：
// - 本笔记 Part I 承接自 Mécanique analytique 迁入的振动与波动正文（约 380 行，含三幅配图），
//   其弹性介质内容留在分析力学
// - 本笔记 Ch 4 桥接 Électrodynamique 的电磁波部分
// - 本笔记 Part IV 需要 Mécanique quantique 的希尔伯特空间与算符基础

// ==========================================================================
// Part I — Vibrations and Waves (振动与波动)
// ==========================================================================
// 设计思路：自 Mécanique analytique 迁入的介质无关波动力学，是全书的数学/物理公分母；
//           正文已按蓝图重组为 Ch 1-3（Ch 1 振动、Ch 2 波动、Ch 3 色散与傅里叶简正模），
//           Ch 4 桥接章（时谐场与亥姆霍兹方程）为新增内容，通向 Part II/III。
// 对应教材：A. P. French, Vibrations and Waves

// --- Chapter 1: Oscillations (振动) ---
//   Section 1.1: Simple Harmonic Motion (简谐运动)
//     - 运动方程与角频率
//     - 能量守恒与振幅
//     - 旋转矢量法与复数表示
//     - 简谐运动合成与拍频
//     - 单摆与物理摆
//   Section 1.2: Damped and Driven Oscillations (阻尼与受驱振动)
//     - 阻尼振子（欠/临界/过阻尼）
//     - 受驱振子与共振
//     - 功率吸收与线宽（Q 因子）

// --- Chapter 2: Wave Motion (波动) ---
//   Section 2.1: The Wave Equation and d'Alembert's Solution (波动方程与达朗贝尔解)
//   Section 2.2: Transverse and Longitudinal Waves (横波与纵波)
//   Section 2.3: Harmonic Travelling Waves (简谐行波：平面/球面/柱面波)
//   Section 2.4: Complex Representation, Standing Waves and Superposition (复数表示、驻波与叠加)
//   Section 2.5: Energy and Intensity (能量与强度)

// --- Chapter 3: Dispersion, Fourier Methods and Normal Modes (色散、傅里叶方法与简正模) ---
//   Section 3.1: Dispersion Relation, Phase and Group Velocity (色散关系、相速度与群速度)
//   Section 3.2: Fourier Series and Normal Modes (傅里叶级数与简正模)
//   Section 3.3: The Eigenfunction Expansion Idea (本征函数展开思想)

// --- Chapter 4: From Waves to Time-Harmonic Fields (时谐场与亥姆霍兹方程) ---
//   Section 4.1: Waves in 2D and 3D (二维三维波动)
//   Section 4.2: The Time-Harmonic Convention (时谐约定)
//   Section 4.3: The Helmholtz Equation (亥姆霍兹方程)
//   Section 4.4: Plane-Wave Expansions (平面波展开)

// ==========================================================================
// Part II — Geometric Optics (几何光学)
// ==========================================================================
// 设计思路：波动光学的短波长极限 λ→0；先光线直觉后波动理论（Hecht 式顺序），
//           程函方程由 Ch 5.1 的 WKB 渐近推导（兑现 Part I Ch 4 承诺），Part III 仅回指不重复；
//           正文已按规划写入 Ch 5-7（完整 WKB 推导、6 张配图）。
// 对应教材：Hecht, Optics Ch 3-6；Born & Wolf, Principles of Optics Ch 3-4

// --- Chapter 5: Ray Optics and the Eikonal Equation (光线光学与程函方程) ---
//   Section 5.1: From Waves to Rays: The Short-Wavelength Limit (从波到光线)
//   Section 5.2: Fermat's Principle (费马原理)
//   Section 5.3: The Eikonal Equation and Ray Equation (程函方程与光线方程)
//   Section 5.4: Reflection and Refraction: Snell's Law (反射与折射)
//   Section 5.5: Total Internal Reflection (全反射)

// --- Chapter 6: Paraxial Optics (近轴光学) ---
//   Section 6.1: The Paraxial Approximation (近轴近似)
//   Section 6.2: Mirrors and Lenses (球面镜与透镜)
//   Section 6.3: The Thin-Lens Equation and Lensmaker's Formula (薄透镜公式与磨镜者公式)
//   Section 6.4: Gaussian Imaging (高斯成像)

// --- Chapter 7: Matrix Optics and Optical Instruments (矩阵光学与光学仪器) ---
//   Section 7.1: ABCD Matrices and Stability (ABCD 矩阵与稳定性)
//   Section 7.2: Prisms and Dispersion (棱镜与色散)
//   Section 7.3: Microscopes and Telescopes (显微镜与望远镜)
//   Section 7.4: Aberrations (像差) [简要]
//   Section 7.5: Optical Fibers (光纤) [简要]

// ==========================================================================
// Part III — Wave Optics (波动光学)
// ==========================================================================
// 设计思路：本体理论，体量最大；以标量衍射理论（Helmholtz 方程 + 格林函数）为统一框架，
//           干涉、衍射、傅里叶光学、偏振、介质传播依次展开。
//           正文已按规划写入 Ch 8-13（框架先行顺序、Ch 11 完整 5 节、8 张核心配图）。
// 对应教材：Born & Wolf Ch 7-10, 13-15；Goodman, Introduction to Fourier Optics

// --- Chapter 8: Scalar Diffraction Theory (标量衍射理论) ---
//   Section 8.1: The Helmholtz Equation for Optical Fields (光场的亥姆霍兹方程)
//   Section 8.2: The Huygens-Fresnel Principle (惠更斯-菲涅耳原理)
//   Section 8.3: Kirchhoff and Rayleigh-Sommerfeld Integrals (基尔霍夫与瑞利-索末菲积分)
//   Section 8.4: Green's Functions for Diffraction (衍射的格林函数)

// --- Chapter 9: Interference and Coherence (干涉与相干性) ---
//   Section 9.1: Two-Beam Interference: Young's Experiment (杨氏双缝)
//   Section 9.2: Interference of Thin Films (薄膜干涉)
//   Section 9.3: The Michelson Interferometer (迈克耳孙干涉仪)
//   Section 9.4: Multiple-Beam Interference: Fabry-Perot (多光束干涉与法布里-珀罗)
//   Section 9.5: Temporal and Spatial Coherence (时间/空间相干性)
//   Section 9.6: Coherence Length and Visibility (相干长度与可见度)

// --- Chapter 10: Diffraction (衍射) ---
//   Section 10.1: Fresnel Diffraction and Zone Plates (菲涅耳衍射与波带片)
//   Section 10.2: Fraunhofer Diffraction: Single Slit and Circular Aperture (夫琅禾费衍射)
//   Section 10.3: Diffraction Gratings and Spectroscopy (衍射光栅与光谱学)
//   Section 10.4: Resolution: Rayleigh and Abbe Criteria (瑞利/阿贝分辨极限)

// --- Chapter 11: Fourier Optics (傅里叶光学) ---
//   Section 11.1: The Lens as a Fourier Transformer (透镜作为傅里叶变换器)
//   Section 11.2: Aperture Functions and Pupil Transforms (孔径函数与光瞳变换)
//   Section 11.3: Spatial Filtering (空间滤波)
//   Section 11.4: PSF, OTF and the Coherent Transfer Function (点扩散函数与光学传递函数)
//   Section 11.5: Holography (全息) [简要]

// --- Chapter 12: Polarization (偏振) ---
//   Section 12.1: Polarization States of Light (光的偏振态)
//   Section 12.2: Jones Calculus (琼斯运算)
//   Section 12.3: Stokes Parameters and Mueller Calculus (斯托克斯参量与缪勒矩阵)
//   Section 12.4: Birefringence and Wave Plates (双折射与波片)
//   Section 12.5: Production and Analysis of Polarized Light (起偏与检偏：布儒斯特角)
//   Section 12.6: Optical Activity (旋光) [简要]

// --- Chapter 13: Propagation in Media (介质中的传播) ---
//   Section 13.1: Dispersion and Absorption (色散与吸收)
//   Section 13.2: Kramers-Kronig Relations (Kramers-Kronig 关系) [可选]
//   Section 13.3: Rayleigh and Mie Scattering (瑞利与米氏散射)

// ==========================================================================
// Part IV — Quantum Optics (量子光学)
// ==========================================================================
// 设计思路：光的量子化与光子统计；Ch 14 为桥接章（旧量子论），Ch 15-18 为核心，
//           Ch 19 为应用与前沿导论，标注"深入参见后续"。
//           写作大纲已定稿（见 OUTLINE.md）：Ch 15 单模完整+多模简述、18.4 精简保留、4 张核心配图。
// 前置：Mécanique quantique（希尔伯特空间、算符、相干态定义）
// 对应教材：Loudon, The Quantum Theory of Light；Scully & Zubairy, Quantum Optics

// --- Chapter 14: Old Quantum Theory of Light (光的旧量子论) [桥接章] ---
//   Section 14.1: Blackbody Radiation and Planck's Law (黑体辐射与普朗克定律)
//   Section 14.2: The Photoelectric Effect (光电效应)
//   Section 14.3: Compton Scattering (康普顿散射)
//   Section 14.4: Wave-Particle Duality (波粒二象性)

// --- Chapter 15: Quantization of the Electromagnetic Field (电磁场量子化) ---
//   Section 15.1: Classical Field Modes (经典场模)
//   Section 15.2: Canonical Quantization of the Field (场的正则量子化)
//   Section 15.3: Photon Number (Fock) States (光子数态)
//   Section 15.4: Vacuum Fluctuations and Zero-Point Energy (真空涨落与零点能)

// --- Chapter 16: Coherent and Squeezed States (相干态与压缩态) ---
//   Section 16.1: Glauber Coherent States (相干态)
//   Section 16.2: Squeezed States (压缩态)
//   Section 16.3: Uncertainty Relations for Quadratures (正交分量不确定性)
//   Section 16.4: Phase-Space Representations: The Wigner Function (相空间表示与 Wigner 函数)

// --- Chapter 17: Photon Statistics and Correlation Functions (光子统计与关联函数) ---
//   Section 17.1: Thermal, Poisson and Sub-Poisson Statistics (热/泊松/亚泊松统计)
//   Section 17.2: First- and Second-Order Correlation Functions (一、二阶关联函数)
//   Section 17.3: The Hanbury Brown-Twiss Experiment (强度干涉实验)
//   Section 17.4: Photon Antibunching and Single-Photon Sources (反聚束与单光子源)

// --- Chapter 18: Light-Matter Interaction (光与物质相互作用) ---
//   Section 18.1: Two-Level Atoms and Rabi Oscillations (二能级原子与拉比振荡)
//   Section 18.2: Spontaneous Emission: Wigner-Weisskopf Theory (自发辐射)
//   Section 18.3: The Jaynes-Cummings Model (Jaynes-Cummings 模型)
//   Section 18.4: Semiclassical Laser Theory (激光半经典理论) [可选]

// --- Chapter 19: Applications and Frontiers (应用与前沿) [导论章] ---
//   Section 19.1: Lasers (激光器)
//   Section 19.2: Quantum Key Distribution (量子密钥分发)
//   Section 19.3: Photon Entanglement and Bell Tests (光子纠缠与贝尔检验)
//   Section 19.4: Spontaneous Parametric Down-Conversion (自发参量下转换)

// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循"振动与波动（迁入基础）→ 几何光学（短波长极限）→ 波动光学（本体理论）
// → 量子光学（场量子化）"的四段式主线，共 4 Part、19 Chapter（其中 Ch 4 桥接章、Ch 19 导论章）。
//
// Part I（Ch 1-4）：振动与波动的介质无关机制（自 Mécanique analytique 迁入），
//   为波动光学提供波动方程、叠加、色散、傅里叶简正模等数学基础；Ch 4 引入时谐场与 Helmholtz 方程。
// Part II（Ch 5-7）：几何光学，作为 Part III 的短波长极限 λ→0；正文已写入（含 6 张配图）。
// Part III（Ch 8-13）：波动光学核心，标量衍射理论为统一框架，展开干涉、衍射、傅里叶光学、偏振、介质传播。
//   正文已写入（框架先行 / Ch 11 完整 / 8 张核心配图）。
// Part IV（Ch 14-19）：量子光学，场量子化、相干态与压缩态、光子统计、光与物质相互作用、应用与前沿。
//
// 教材覆盖：A. P. French（振动与波动）、Hecht / Born & Wolf（几何与波动光学）、
//           Goodman（傅里叶光学）、Loudon / Scully & Zubairy（量子光学）知识点均已覆盖。
// 迁移说明：Part I 正文自 Mécanique analytique Ch 4 迁入（约 380 行，含三幅配图），
//           已重组为 Ch 1-3；Ch 4（时谐场与亥姆霍兹方程）为新写桥接章。
//           弹性介质小节（应变/应力/泊松比/弹性波/机械阻抗）留在分析力学（Chapter 4: Elastic Waves in Solids）。
// ==========================================================================

// 目录

// --------------------------------------------------------------------------
// Part I: Vibrations and Waves (振动与波动)
// --------------------------------------------------------------------------

#part("Vibrations and Waves") // 振动与波动

// --- Chapter 1: Oscillations (振动) ---

= Oscillations // 振动

Oscillatory motion is ubiquitous in physics — from a swinging pendulum to vibrating molecules and electromagnetic waves.
This chapter (migrated from the *Mécanique analytique* notebook) develops the fundamental concepts of simple harmonic motion and of damped and driven oscillations; wave propagation follows in Chapter 2.
These ideas are revisited in *Mécanique analytique* (Part II), where Lagrangian methods provide a systematic approach to small oscillations and normal modes.

== Simple Harmonic Motion // 简谐运动

=== Equation of Motion // 运动方程

The simplest oscillatory system is a mass $m$ attached to a spring of stiffness $k$.
When displaced from equilibrium, Hooke's law gives $F = - k x$, and Newton's second law yields:

$
  m dot.double(x) + k x = 0.
$

This is the equation of *simple harmonic motion* (SHM).
Dividing by $m$ and defining the *angular frequency* $omega_0 = sqrt(k / m)$:

#definition(name: "Simple Harmonic Motion")[
  The equation of SHM and its general solution:
  $
    dot.double(x) + omega_0^2 x = 0, quad x(t) = A cos(omega_0 t + phi),
  $
  where $A$ is the amplitude and $phi$ is the initial phase.
  The period and frequency are:
  $
    T = frac(2 pi, omega_0) = 2 pi sqrt(frac(m, k)), quad f = frac(1, T) = frac(omega_0, 2 pi).
  $
]

=== Energy of the Simple Harmonic Oscillator // 简谐振子的能量

The total mechanical energy is conserved and oscillates between kinetic and potential forms:

$
  E = frac(1,2) m dot(x)^2 + frac(1,2) k x^2 = frac(1,2) k A^2.
$

#example(name: "Mass-Spring System")[ // 弹簧振子
  A mass $m = 0.5 "kg"$ on a spring of stiffness $k = 32 "N/m"$ is pulled $A = 0.1 "m"$ from equilibrium and released.

  Angular frequency: $omega_0 = sqrt(k / m) = sqrt(32 / 0.5) = 8 "rad/s"$.
  Period: $T = 2 pi / omega_0 = pi / 4 approx 0.785 "s"$.
  Maximum speed: $v_"max" = omega_0 A = 0.8 "m/s"$.
  Total energy: $E = frac(1,2) k A^2 = frac(1,2) times 32 times 0.1^2 = 0.16 "J"$.
]

=== Rotating Vector and Complex Representation // 旋转矢量法与复数表示

The solution $x(t) = A cos(omega_0 t + phi)$ can be visualised as the projection of a rotating vector (phasor) of length $A$ rotating at angular speed $omega_0$.

#definition(name: "Rotating Vector / Phasor")[
  The SHM displacement is the real part of a complex exponential:
  $
    x(t) = Re(bold(A) e^(i omega_0 t)), quad bold(A) = A e^(i phi).
  $
  Here $bold(A)$ is the *complex amplitude* (phasor) encoding both amplitude $A$ and initial phase $phi$.
  The velocity and acceleration are:
  $
    dot(x) = Re(i omega_0 bold(A) e^(i omega_0 t)), quad
    dot.double(x) = Re(- omega_0^2 bold(A) e^(i omega_0 t)).
  $
]

#note[
  The complex representation turns differentiation into multiplication by $i omega$, and superposition into complex addition.
  This is the foundation of phasor analysis in AC circuits and of Fourier methods in normal mode analysis (Mécanique analytique, Part II).
]

The rotating vector makes phase relationships geometrically obvious: velocity leads displacement by $pi/2$ (the tangent direction), and acceleration leads displacement by $pi$ (opposite direction).

=== Superposition of SHM and Beats // 简谐运动的合成与拍频

Because the wave equation is linear, the sum of two SHM solutions is also a solution.
This leads to two important phenomena.

#definition(name: "Superposition of Two SHMs (Same Frequency)")[
  The sum of two SHMs with the same frequency $omega$ but different amplitudes $A_1, A_2$ and phases $phi_1, phi_2$ is another SHM at the same frequency:
  $
    x(t) = A_1 cos(omega t + phi_1) + A_2 cos(omega t + phi_2) = A cos(omega t + phi),
  $
  where $A = sqrt(A_1^2 + A_2^2 + 2 A_1 A_2 cos(Delta phi))$ and $tan phi = frac(A_1 sin phi_1 + A_2 sin phi_2, A_1 cos phi_1 + A_2 cos phi_2)$.
]

#definition(name: "Beats")[
  When two SHMs have *slightly different* frequencies $omega_1$ and $omega_2 = omega_1 + Delta omega$:
  $
    x(t) = A cos(omega_1 t) + A cos(omega_2 t) = 2 A cos(frac(Delta omega, 2) t) cos(bar(omega) t),
  $
  where $bar(omega) = (omega_1 + omega_2) / 2$.
  The amplitude is modulated at the *beat frequency* $Delta omega = |omega_2 - omega_1|$.
]

#note[
  Beats are the simplest example of *amplitude modulation*.
  In *Mécanique analytique* (Part II), the normal mode splitting of coupled oscillators follows the same mathematics — two resonant frequencies produce a "beat-like" energy transfer between the two masses.
]

=== The Simple Pendulum // 单摆

The simple pendulum (mass $m$, length $L$) obeys $dot.double(theta) + (g / L) sin theta = 0$.
For small angles, $sin theta approx theta$, giving SHM:

$
  dot.double(theta) + omega_0^2 theta = 0, quad omega_0 = sqrt(frac(g, L)).
$

#note[
  The small-angle approximation $sin theta approx theta$ is the first term of the Taylor expansion.
  For larger amplitudes, corrections appear: the period becomes $T = 2 pi sqrt(L/g) (1 + theta_0^2 / 16 + ...)$, as derived from the energy integral (Mécanique analytique, Ch 3).
]

=== Relation to the Physical Pendulum // 与物理摆的联系

The physical pendulum (Mécanique analytique, Ch 2) has $omega_0 = sqrt(M g d / I)$.
For a simple pendulum, $I = M L^2$ and $d = L$, recovering $omega_0 = sqrt(g / L)$.
The SHM framework thus unifies all systems with a linear restoring torque.

== Damped and Driven Oscillations // 阻尼与受驱振动

=== Damped Harmonic Oscillator // 阻尼振子

Real oscillators experience energy loss due to friction or drag.
For a velocity-dependent damping force $F_d = - b dot(x)$, the equation of motion becomes:

$
  m dot.double(x) + b dot(x) + k x = 0.
$

Dividing by $m$ and defining $beta = b / (2m)$ (damping coefficient) and $omega_0 = sqrt(k / m)$:

$
  dot.double(x) + 2 beta dot(x) + omega_0^2 x = 0.
$

The characteristic equation $r^2 + 2 beta r + omega_0^2 = 0$ has roots $r = - beta ± sqrt(beta^2 - omega_0^2)$.

#definition(name: "Damping Regimes")[
  - *Underdamped* ($beta < omega_0$): $x(t) = e^(-beta t) [A cos(omega_1 t) + B sin(omega_1 t)]$, where $omega_1 = sqrt(omega_0^2 - beta^2)$.
    The amplitude decays exponentially with time constant $1 / beta$.
  - *Critically damped* ($beta = omega_0$): $x(t) = (A + B t) e^(-omega_0 t)$.
    The system returns to equilibrium fastest without oscillating.
  - *Overdamped* ($beta > omega_0$): $x(t) = A e^(-r_1 t) + B e^(-r_2 t)$, with $r_1, r_2 > 0$.
    The system returns slowly without oscillating.
]

#figure(
  image("img/damped_oscillation.png", width: 100%),
  caption: [Damped oscillation: underdamped (blue), critically damped (green), and overdamped (orange).],
  placement: auto,
  supplement: [Fig.]
) <fig:damped_oscillation>

=== Driven Oscillator and Resonance // 受驱振子与共振

When an external driving force $F(t) = F_0 cos(omega t)$ is applied:

$
  dot.double(x) + 2 beta dot(x) + omega_0^2 x = frac(F_0, m) cos(omega t).
$

The steady-state solution is $x(t) = A(omega) cos(omega t - delta)$, with:

$
  A(omega) = frac(F_0 / m, sqrt((omega_0^2 - omega^2)^2 + (2 beta omega)^2)), quad
  tan delta = frac(2 beta omega, omega_0^2 - omega^2).
$

#theorem(name: "Resonance")[
  The amplitude $A(omega)$ reaches a maximum at the *resonance frequency*:
  $
    omega_"res" = sqrt(omega_0^2 - 2 beta^2).
  $
  For weak damping ($beta << omega_0$), $omega_"res" approx omega_0$ and the peak amplitude is:
  $
    A_"max" approx frac(F_0, 2 m beta omega_0).
  $
  The width of the resonance curve (full width at half maximum) is $Delta omega approx 2 beta$, giving a quality factor $Q = omega_0 / (2 beta)$.
]

#figure(
  image("img/resonance_curves.png", width: 100%),
  caption: [Resonance curves for different damping ratios $beta / omega_0$. Sharp peaks correspond to weak damping; broad curves correspond to strong damping.],
  placement: auto,
  supplement: [Fig.]
) <fig:resonance_curves>

#note[
  Resonance is a crucial phenomenon across physics: it explains why a small force at the right frequency can produce large oscillations (e.g., pushing a child on a swing, tuning a radio receiver, or the Tacoma Narrows Bridge collapse).
]

=== Power Absorption and Linewidth // 功率吸收与线宽

The rate at which the driving force does work on the oscillator is $P(t) = F(t) dot(x)(t)$.
The *average power* absorbed is:

$
  P_"avg" = frac(F_0^2 beta omega^2, m ((omega_0^2 - omega^2)^2 + (2 beta omega)^2)).
$

#property(name: "Power Absorption Characteristics")[
  - The peak absorbed power occurs at $omega = omega_0$ (not at $omega_"res"$): $P_"max" = F_0^2 / (4 m beta)$.
  - The full width at half maximum (FWHM) of the power curve is $Delta omega = 2 beta$.
  - The quality factor $Q = omega_0 / (2 beta) = omega_0 / Delta omega$ measures the sharpness of resonance.
  - A high-$Q$ oscillator rings for many cycles after the driving force is removed; the number of oscillations for the amplitude to decay to $1/e$ is approximately $Q / pi$.
]

#note[
  The $Q$ factor connects driven oscillations to free decay: $Q = pi$ times the number of oscillations for the amplitude to decay to $1/e$.
  This same concept reappears in quantum mechanics (resonance width and particle lifetime) and in electrical engineering (bandwidth of RLC circuits).
]

// --- Chapter 2: Wave Motion (波动) ---

= Wave Motion // 波动

While oscillators describe the motion of individual particles, *waves* describe the propagation of disturbances through a continuous medium.
The key conceptual shift is from a function of time alone $x(t)$ to a function of both space and time $u(x,t)$.

== The Wave Equation and d'Alembert's Solution // 波动方程与达朗贝尔解

=== The Wave Equation // 波动方程

#definition(name: "One-Dimensional Wave Equation")[
  The displacement $u(x, t)$ of a wave travelling along the $x$-axis satisfies:
  $
    frac(partial^2 u, partial t^2) = v^2 frac(partial^2 u, partial x^2).
  $
  For a wave on a string of tension $T$ and linear density $mu$: $v = sqrt(T / mu)$.
  For a sound wave in a fluid of bulk modulus $K$ and density $rho$: $v = sqrt(K / rho)$.
]

=== d'Alembert's Solution // 达朗贝尔解

The wave equation admits a general solution in terms of travelling waves:

$
  u(x, t) = f(x - v t) + g(x + v t),
$

where $f$ and $g$ are arbitrary twice-differentiable functions.
The function $f(x - v t)$ represents a wave travelling to the right at speed $v$ without changing shape; $g(x + v t)$ travels to the left.
This is *d'Alembert's solution*, and it reveals that the wave equation is fundamentally a statement that the waveform propagates without distortion in a non-dispersive medium.

== Transverse and Longitudinal Waves // 横波与纵波

Waves are classified by the direction of particle displacement relative to the propagation direction.

#definition(name: "Transverse and Longitudinal Waves")[
  - *Transverse wave*: particle displacement is *perpendicular* to the direction of wave propagation (e.g., waves on a string, electromagnetic waves).
    The restoring mechanism is *shear stress*.
  - *Longitudinal wave*: particle displacement is *parallel* to the direction of wave propagation (e.g., sound waves in air, compression waves in a spring).
    The restoring mechanism is *bulk (compression) stress*.
  - In solids, both types coexist, giving rise to distinct wave speeds:
    $
      v_"transverse" = sqrt(frac(G, rho)), quad
      v_"longitudinal" = sqrt(frac(K + 4G/3, rho)),
    $
    where $G$ is the shear modulus and $K$ is the bulk modulus.
    Since $G < K$ typically, $v_"longitudinal" > v_"transverse"$ — this is why seismic P-waves (longitudinal) arrive before S-waves (transverse).
]

== Harmonic Travelling Waves // 简谐行波

The simplest and most important special case of d'Alembert's solution is the *harmonic travelling wave*.

#definition(name: "Harmonic Travelling Wave")[
  $
    u(x, t) = A cos(k x - omega t + phi),
  $
  where $k = 2 pi / lambda$ is the wavenumber, $lambda$ the wavelength, and $omega = v k$ the angular frequency.
]

A travelling wave has three defining features:

#property(name: "Three Characteristics of Travelling Waves")[
  1. *Morphology*: The entire waveform translates rigidly at speed $v$.
     A snapshot at time $t+Delta t$ is identical to the snapshot at $t$ shifted by $v Delta t$.
  2. *Phase*: Each particle lags behind the particle to its left (for $+x$ propagation).
     The phase difference between two points separated by $Delta x$ is $Delta phi = k Delta x$.
  3. *Energy*: Traveling waves carry energy unidirectionally — there is a net energy flux from source to receiver, unlike standing waves which store energy locally.
]

=== Plane, Spherical, and Cylindrical Waves // 平面波、球面波与柱面波

Depending on the geometry of the wave source, the solutions of the wave equation take different forms.

#definition(name: "Plane, Spherical, and Cylindrical Waves")[
  - *Plane wave*: wavefronts are infinite planes. $u = A cos(omega t - bold(k) dot bold(r) + phi)$.
    Energy does not spread — amplitude is constant.
  - *Spherical wave* (point source): wavefronts are expanding spheres. $u(r, t) = frac(A, r) cos(omega t - k r + phi)$.
    Amplitude decays as $1/r$ to conserve energy (intensity $prop 1/r^2$).
  - *Cylindrical wave* (line source): wavefronts are coaxial cylinders. $u(r, t) prop frac(1, sqrt(r)) cos(omega t - k r + phi)$.
    Amplitude decays as $1/sqrt(r)$.
]

== Complex Representation, Standing Waves and Superposition // 复数表示、驻波与叠加

=== Complex Representation of Waves // 波的复数表示

Just as for SHM, harmonic waves are most conveniently written using complex exponentials:

$
  u(x, t) = Re(bold(U) e^(i(k x - omega t))), quad bold(U) = A e^(i phi).
$

The complex amplitude $bold(U)$ encodes both the real amplitude $A$ and the initial phase $phi$.
This representation makes superposition, differentiation, and impedance calculations straightforward.

=== Standing Waves // 驻波

When two identical waves travel in opposite directions, they interfere to form a *standing wave*:

$
  u(x, t) = 2 A cos(k x) cos(omega t).
$

The points where $cos(k x) = 0$ (nodes) are stationary; the points where $|cos(k x)| = 1$ (antinodes) oscillate with maximum amplitude.

#example(name: "Standing Waves on a String Fixed at Both Ends")[ // 两端固定弦的驻波
  For a string of length $L$ fixed at $x = 0$ and $x = L$, the boundary conditions $u(0, t) = u(L, t) = 0$ require $k L = n pi$, $n = 1, 2, 3, ...$.

  The *normal modes* are:
  $
    u_(n)(x, t) = A_n sin(frac(n pi x, L)) cos(omega_n t), quad omega_n = n omega_1, quad omega_1 = frac(pi v, L).
  $

  The fundamental frequency is $f_1 = omega_1 / (2 pi) = v / (2 L)$, and the higher harmonics are integer multiples: $f_n = n f_1$.
]

#figure(
  image("img/string_normal_modes.png", width: 100%),
  caption: [Normal modes of a string fixed at both ends: $n = 1$ (fundamental), $n = 2$ (second harmonic), $n = 3$ (third harmonic).],
  placement: auto,
  supplement: [Fig.]
) <fig:string_normal_modes>

=== Superposition Principle // 叠加原理

#property(name: "Superposition for Waves")[
  The wave equation is *linear*: if $u_1$ and $u_2$ are solutions, then $u_1 + u_2$ is also a solution.
  This allows complex wave patterns to be built from simple harmonic components.
]

== Energy and Intensity // 能量与强度

A travelling wave carries both kinetic and potential energy.
For a wave on a string:

$
  text("Kinetic energy density"): cal(K) = frac(1,2) mu (frac(partial u, partial t))^2,
  quad
  text("Potential energy density"): cal(V) = frac(1,2) T (frac(partial u, partial x))^2.
$

For a harmonic travelling wave $u = A cos(k x - omega t)$:

$
  cal(K) = cal(V) = frac(1,4) mu omega^2 A^2,
  quad
  text("Total energy density"): cal(E) = frac(1,2) mu omega^2 A^2.
$

#definition(name: "Wave Intensity")[
  The *intensity* (average power per unit area) of a harmonic wave is:
  $
    I = frac(1,2) rho v omega^2 A^2 = frac(1,2) Z omega^2 A^2.
  $
  For a point source emitting power $P$, the intensity at distance $r$ is $I = P / (4 pi r^2)$, consistent with the $1/r$ amplitude decay of spherical waves.
]

#note[
  The energy flux of a mechanical wave is the analogue of the Poynting vector in electromagnetism.
  The same structure — energy density, energy flux, and conservation law — appears in the electromagnetic field (Électrodynamique, Electromagnetic Waves).
]

// --- Chapter 3: Dispersion, Fourier Methods and Normal Modes (色散、傅里叶方法与简正模) ---

= Dispersion, Fourier Methods and Normal Modes // 色散、傅里叶方法与简正模

== Dispersion and Group Velocity // 色散与群速度

For the ideal string, the wave speed $v = sqrt(T / mu)$ is independent of frequency — all frequency components travel at the same speed.
In many real media, however, the wave speed depends on frequency; this is called *dispersion*.

#definition(name: "Dispersion Relation and Wave Velocities")[
  The *dispersion relation* $omega(k)$ links angular frequency and wavenumber:
  - Non-dispersive: $omega = v k$ (constant $v$), e.g., ideal string.
  - Dispersive: $omega(k)$ is nonlinear, e.g., deep water waves $omega = sqrt(g k)$, bending waves on a beam $omega prop k^2$.

  Two velocities are defined:
  $
    v_p = frac(omega, k) quad text("(phase velocity — speed of a single crest)"),
    v_g = frac(dif omega, dif k) quad text("(group velocity — speed of a wave packet / energy)").
  $
  In a non-dispersive medium, $v_p = v_g$.
  In a dispersive medium, $v_p != v_g$; a wave packet spreads as it propagates.
]

#example(name: "Deep Water Waves")[ // 深水波
  For deep water waves, the dispersion relation is $omega = sqrt(g k)$.
  The phase velocity $v_p = omega / k = sqrt(g / k)$ increases with wavelength (longer waves travel faster).
  The group velocity $v_g = dif omega / dif k = frac(1,2) sqrt(g / k) = v_p / 2$ — energy travels at half the speed of the crests.
]

== Fourier Series and Normal Modes // 傅里叶级数与简正模

Any standing wave configuration on a string can be expressed as a sum of normal modes — this is the essence of *Fourier analysis*.

#definition(name: "Fourier Series for Standing Waves")[
  The general solution for a string fixed at both ends is a superposition of normal modes:
  $
    u(x, t) = sum_(n=1)^oo (a_n cos(omega_n t) + b_n sin(omega_n t)) sin(frac(n pi x, L)).
  $
  The coefficients $a_n, b_n$ are determined by the initial conditions $u(x, 0)$ and $dot(u)(x, 0)$ through the Fourier integrals:
  $
    a_n = frac(2, L) integral_0^L u(x, 0) sin(frac(n pi x, L)) dif x,
    quad
    b_n = frac(2, L omega_n) integral_0^L dot(u)(x, 0) sin(frac(n pi x, L)) dif x.
  $
]

== The Eigenfunction Expansion Idea // 本征函数展开思想

The normal modes are the *eigenfunctions* of the wave equation with given boundary conditions.
This concept — expanding a general solution in eigenfunctions — is one of the most powerful ideas in mathematical physics, reappearing in quantum mechanics (particle in a box), electromagnetism (waveguide modes), and structural engineering (modal analysis).

#note[
  *Connection to later topics:*
  - The normal modes of a string are the first example of a discrete eigenvalue problem.
    In *Mécanique analytique* (Part II, Lagrangian mechanics), this is generalised to coupled oscillators and normal mode analysis using matrix methods.
  - The Fourier series is the discrete precursor to the Fourier transform, which describes the continuous spectrum of a wave packet.
  - In quantum mechanics, the same "expand in eigenfunctions" strategy solves the Schrödinger equation for bound states.
]

The preceding chapters of this part develop the wave equation and its general mathematical machinery — d'Alembert's solution, complex (phasor) representation, superposition, standing waves, dispersion, group velocity, and Fourier analysis.
These concepts are *medium-independent*: they apply equally to mechanical waves, electromagnetic waves, and quantum probability waves.
The elastic-solid specialisation (strain, stress, P/S waves, mechanical impedance) is treated in the *Mécanique analytique* notebook (Elastic Waves in Solids).

// --- Chapter 4: From Waves to Time-Harmonic Fields (时谐场与亥姆霍兹方程) ---

= From Waves to Time-Harmonic Fields // 时谐场与亥姆霍兹方程

The wave machinery of Chapters 1–3 describes disturbances that depend on both space and time.
Almost all of classical optics is built on one special case: fields that oscillate at a single, fixed frequency.
This chapter isolates that case, derives the spatial equation it satisfies — the *Helmholtz equation* — and expands its solutions in plane waves.
The Helmholtz equation is the mathematical backbone of Part II (geometric optics as the $lambda -> 0$ limit) and of Part III (diffraction and Fourier optics).

== Waves in 2D and 3D // 二维三维波动

The one-dimensional wave equation of Chapter 2 generalises to three dimensions by replacing the second spatial derivative with the Laplacian $nabla^2$.

#definition(name: "Three-Dimensional Wave Equation")[
  The displacement $u(bold(r), t)$ of a wave propagating in three-dimensional space satisfies
  $
    frac(partial^2 u, partial t^2) = v^2 nabla^2 u,
  $
  where $nabla^2 = gradient dot gradient$ is the Laplacian and $v$ is the wave speed.
] <def:wave-eq-3d>

The plane, spherical, and cylindrical solutions of Chapter 2 are the three-dimensional solutions obtained by separating $u(bold(r), t)$ in Cartesian, spherical, and cylindrical coordinates.
Separation of variables turns the problem into an equation for the spatial part alone — this is the route to the Helmholtz equation below.

== The Time-Harmonic Convention // 时谐约定

#definition(name: "Time-Harmonic Field")[
  A field $u(bold(r), t)$ is *time-harmonic* at (angular) frequency $omega > 0$ if it can be written as
  $
    u(bold(r), t) = Re(bold(U)(bold(r)) e^(-i omega t)),
  $
  where $bold(U)(bold(r))$ is a complex-valued *spatial amplitude* (phasor).
] <def:time-harmonic>

The sign in $e^(-i omega t)$ is a convention.
We adopt the physics convention $e^(-i omega t)$; the engineering convention uses $e^(+i omega t)$ and reverses the sign of every phase term.
All phases in this notebook are measured consistently with the $e^(-i omega t)$ convention.

#note[
  The complex amplitude $bold(U)$ encodes both the real amplitude and the phase: the real oscillation is $abs(bold(U)) cos(omega t - phi)$ when $bold(U) = abs(bold(U)) e^(i phi)$.
]

== The Helmholtz Equation // 亥姆霍兹方程

Substituting the time-harmonic ansatz into the three-dimensional wave equation replaces time derivatives by multiplication with $(-i omega)^2 = - omega^2$:

$
  - omega^2 bold(U) = v^2 nabla^2 bold(U).
$

Rearranging yields the Helmholtz equation.

#definition(name: "Helmholtz Equation")[
  The spatial amplitude of a time-harmonic wave satisfies
  $
    (nabla^2 + k^2) bold(U) = 0, quad k = frac(omega, v),
  $
  where $k$ is the *wavenumber*.
] <def:helmholtz>

For light in vacuum, $v = c$ and $k = 2 pi / lambda$.
In a medium of refractive index $n$, the wavenumber becomes $k = n omega / c = 2 pi n / lambda$.

The Helmholtz equation is the spatial eigenvalue problem of the Laplacian: the field $bold(U)$ is an eigenfunction of $nabla^2$ with eigenvalue $-k^2$.
Its solutions are the building blocks of the entire optical theory that follows.

#note[
  In a source-free, homogeneous medium, every Cartesian component of the electromagnetic field satisfies the scalar Helmholtz equation (see Électrodynamique, Electromagnetic Waves).
  The scalar theory of this notebook works with a single component $bold(U)$; the vector character of the field returns in Chapter 12 (Polarization).

  The Helmholtz equation alone admits both outgoing and incoming solutions.
  Physical radiation problems single out the outgoing family by the *Sommerfeld radiation condition*; the diffraction integrals of Chapter 8 are the Green-function solutions that enforce it.
]

== Plane-Wave Expansions // 平面波展开

The simplest solutions of the Helmholtz equation are the plane waves $e^(i bold(k) dot bold(r))$, with wavevector $bold(k)$ constrained to the sphere $abs(bold(k)) = k$.
Because the equation is linear, general solutions are superpositions of plane waves.

For a field prescribed on the plane $z = 0$, the solution for $z > 0$ admits the *angular-spectrum representation*.

#definition(name: "Angular-Spectrum Representation")[
  Let $bold(U)(bold(r)_(⊥), 0)$ be the field on the plane $z = 0$.
  The general solution of the Helmholtz equation for $z > 0$ is
  $
    bold(U)(bold(r)) = integral.double_(bb(R)^2) hat(bold(U))(bold(k)_(⊥)) e^(i bold(k) dot bold(r)) dif k_x dif k_y,
  $
  where $hat(bold(U))(bold(k)_(⊥))$ is the two-dimensional Fourier transform of the boundary field and the wavevector components satisfy $k_z = sqrt(k^2 - k_(⊥)^2)$ with $k_(⊥)^2 = k_x^2 + k_y^2$.
] <def:angular-spectrum>

The angular spectrum decomposes the field into plane waves travelling in every direction.

- Components with $k_(⊥) < k$ give a real $k_z$ — these are *propagating* waves that transport energy.
- Components with $k_(⊥) > k$ give a purely imaginary $k_z$ — these are *evanescent* waves that decay exponentially away from the plane and carry no net power.

The evanescent component is responsible for the diffraction limit: fine spatial detail at the boundary does not propagate to the far field.
This distinction reappears in Chapter 10 (Resolution) and Chapter 11 (Fourier Optics).

#note[
  The angular-spectrum representation is the bridge between Part I and the rest of the notebook: the diffraction integrals of Chapter 8 are this representation evaluated at a distant observation plane, and the lens analysis of Chapter 11 implements it physically as a Fourier transform.
]

// --------------------------------------------------------------------------
// Part II: Geometric Optics (几何光学)
// --------------------------------------------------------------------------

#part("Geometric Optics") // 几何光学

// --- Chapter 5: Ray Optics and the Eikonal Equation (光线光学与程函方程) ---

= Ray Optics and the Eikonal Equation // 光线光学与程函方程

Geometric optics describes the propagation of light in terms of rays rather than waves.
It is not a separate theory: it is the short-wavelength limit of wave optics, obtained from the Helmholtz equation as $lambda -> 0$.
This chapter develops that limit systematically — wavefronts become surfaces of constant phase, rays become their normals, and every classical law of geometric optics follows from the *eikonal equation*.
It redeems the promise made at the end of Chapter 4.

== From Waves to Rays: The Short-Wavelength Limit // 从波到光线

Geometric optics applies when the wavelength is much smaller than every relevant length scale of the problem: the size of apertures, the radii of curvature of interfaces, and the scale over which the refractive index varies.
Under this condition the spatial amplitude varies slowly over one wavelength, and the field is well approximated by a slowly varying envelope multiplied by a rapidly oscillating phase.

For a time-harmonic field in a medium of refractive index $n(bold(r))$, the scalar Helmholtz equation of Chapter 4 reads:

$
  (nabla^2 + k_0^2 n^2) bold(U) = 0,
$

where $k_0 = omega / c$ is the vacuum wavenumber.

#definition(name: "WKB Ansatz")[
  A *WKB ansatz* for the spatial amplitude has the form
  $
    bold(U)(bold(r)) = A(bold(r)) e^(i k_0 S(bold(r))),
  $
  where the amplitude $A$ and the *eikonal* $S$ are real, slowly varying functions of position.
] <def:wkb-ansatz>

Substituting the ansatz into the Helmholtz equation and collecting powers of $k_0$ gives:

$
  0 = (nabla^2 + k_0^2 n^2) bold(U)
  = e^(i k_0 S) [k_0^2 A (n^2 - abs(gradient S)^2) + i k_0 (2 gradient A dot gradient S + A nabla^2 S) + nabla^2 A].
$

Since the identity holds for every point and the amplitude $A$ is not identically zero, the coefficients of the leading powers of $k_0$ must vanish separately.

#theorem(name: "From Helmholtz to Eikonal")[
  In the short-wavelength limit $lambda -> 0$, the WKB ansatz reduces the Helmholtz equation to two leading-order equations:
  $
    abs(gradient S)^2 = n^2, quad 2 gradient A dot gradient S + A nabla^2 S = 0.
  $
  The first is the *eikonal equation* (order $k_0^2$); the second is the *transport equation* (order $k_0$).
  The order-$k_0^0$ term $nabla^2 A$ is dropped in the geometric-optics approximation.
] <thm:eikonal-from-helmholtz>

// 兑现 Ch4 L682 的承诺：geometric optics as the λ→0 limit

#proof[
  *Step 1 — Substitute the ansatz.*
  The gradient and Laplacian of the ansatz are:
  $
    gradient bold(U) = e^(i k_0 S) (i k_0 A gradient S + gradient A),
  $
  $
    nabla^2 bold(U) = e^(i k_0 S) (- k_0^2 A abs(gradient S)^2 + 2 i k_0 gradient A dot gradient S + i k_0 A nabla^2 S + nabla^2 A).
  $

  *Step 2 — Collect powers of $k_0$.*
  Substituting into the Helmholtz equation and cancelling the common factor $e^(i k_0 S)$:
  $
    k_0^2 A (n^2 - abs(gradient S)^2) + i k_0 (2 gradient A dot gradient S + A nabla^2 S) + nabla^2 A = 0.
  $

  *Step 3 — Separate the orders.*
  The coefficient of $k_0^2$ yields the eikonal equation $abs(gradient S)^2 = n^2$.
  The coefficient of $k_0$ yields the transport equation $2 gradient A dot gradient S + A nabla^2 S = 0$.
  The remaining term $nabla^2 A$ is of order $k_0^0$ and is negligible compared with the leading terms when $k_0$ is large.
]

#definition(name: "Eikonal and Wavefronts")[
  The function $S$ solving the eikonal equation is the *eikonal*.
  Its level sets $S(bold(r)) = "const"$ are the *wavefronts* (surfaces of constant phase).
  Since $gradient S != 0$, the rays are the curves orthogonal to the wavefronts, traced in the direction of increasing $S$.
] <def:eikonal-equation>

#figure(
  image("img/waves-to-rays.svg", width: 100%),
  caption: [Wavefronts and rays: rays are the normals to the wavefronts (surfaces of constant phase).],
  placement: auto,
  supplement: [Fig.]
) <fig:waves-to-rays>

#note[
  *Validity.* The WKB approximation breaks down where the amplitude varies rapidly — at focal points (caustics), at interfaces, and near turning points.
  There the geometric-optics field diverges, and one must return to the full wave equation; the diffraction integrals of Part III provide the correct description.
]

== Fermat's Principle // 费马原理

#definition(name: "Optical Path Length")[
  The *optical path length* between two points $A$ and $B$ along a curve $C$ is
  $
    "OPL"(C) = integral_C n(bold(r)) dif s,
  $
  where $dif s$ is the arc-length element and $n$ is the refractive index.
] <def:optical-path-length>

#law(name: "Fermat's Principle")[
  A ray connecting two points $A$ and $B$ follows a path for which the optical path length is *stationary* under small variations of the path:
  $
    delta integral_C n(bold(r)) dif s = 0.
  $
] <law:fermat>

"Stationary" means that the first variation vanishes; in most optical situations the ray is a local minimum of the OPL.
The principle subsumes both the law of reflection and Snell's law (Section 5.4), and it is the variational form of the eikonal equation: along a ray, the accumulated phase $S$ is exactly the optical path length, and the rays are the extremals of $integral n dif s$.

#note[
  Fermat's principle is the optical analogue of Hamilton's principle in mechanics: a particle extremises the action $integral L dif t$, a ray extremises the optical path $integral n dif s$.
]

== The Eikonal Equation and Ray Equation // 程函方程与光线方程

#definition(name: "Ray Equation")[
  Let $bold(r)(s)$ parametrise a ray by arc length $s$, and write $bold(r)' = frac(dif bold(r), dif s)$ for the unit tangent.
  The *ray equation* is
  $
    frac(dif, dif s) (n bold(r)') = gradient n.
  $
  Equivalently, along a ray the optical momentum satisfies $n bold(r)' = gradient S$.
] <def:ray-equation>

#theorem(name: "From Eikonal to Ray")[
  The rays are the characteristic curves of the eikonal equation, and they satisfy the ray equation.
] <thm:ray-from-eikonal>

#proof[
  *Step 1 — Rays as gradient flow.*
  Set the ray direction to $bold(r)' = gradient S / n$.
  Since $abs(gradient S) = n$ by the eikonal equation, this is a unit vector, and it is normal to the wavefronts by construction.

  *Step 2 — Differentiate along the ray.*
  Apply the directional derivative $dif/dif s = bold(r)' dot gradient$ to the identity $gradient S = n bold(r)'$:
  $
    frac(dif, dif s) gradient S = frac(dif, dif s) (n bold(r)').
  $
  With $bold(r)' = gradient S / n$ and the eikonal equation, the left-hand side becomes
  $
    frac(1, n) gradient S dot gradient (gradient S) = frac(1, 2 n) gradient (abs(gradient S)^2) = frac(1, 2 n) gradient (n^2) = gradient n.
  $

  *Step 3 — Conclude.*
  Equating the two sides gives the ray equation $frac(dif, dif s) (n bold(r)') = gradient n$.
]

In a homogeneous medium, $gradient n = 0$ and the ray equation forces $n bold(r)'$ to be constant: rays are straight lines.
In an inhomogeneous medium, rays bend toward the region of higher refractive index — the origin of mirages, heat shimmer, and graded-index guidance.

#note[
  *Optical-mechanical analogy (Hamiltonian optics).* With the "optical momentum" $bold(p) = n bold(r)'$, the ray equation reads $bold(p)' = gradient n$, the exact analogue of Newton's law $dot(bold(p)) = - gradient V$.
  Fermat's principle is Hamilton's principle for light, and the eikonal $S$ plays the role of the action.
  The full Hamiltonian formulation of optics belongs to *Mécanique analytique*; here the analogy serves only as intuition.
]

== Reflection and Refraction: Snell's Law // 反射与折射

Consider a ray incident on a planar interface between two media of refractive indices $n_1$ and $n_2$.
The reflected and transmitted rays lie in the plane of incidence, the plane spanned by the incident ray and the surface normal.

#law(name: "Law of Reflection")[
  The reflected ray makes the same angle with the surface normal as the incident ray:
  $
    theta_1 = theta_1'.
  $
] <law:reflection>

#law(name: "Snell's Law of Refraction")[
  The transmitted ray satisfies
  $
    n_1 sin theta_1 = n_2 sin theta_2,
  $
  where $theta_1$ and $theta_2$ are the angles with respect to the interface normal.
] <law:snell>

#figure(
  image("img/snells-law.svg", width: 70%),
  caption: [Reflection and refraction at a planar interface: the incident, reflected, and transmitted rays lie in the plane of incidence, and $n_1 sin theta_1 = n_2 sin theta_2$.],
  placement: auto,
  supplement: [Fig.]
) <fig:snells-law>

Both laws follow from Fermat's principle: the stationary optical path between two fixed points on opposite sides of the interface is achieved when the crossing point satisfies these angle relations.

#note[
  *Wavefront (phase-matching) argument.* Across the interface the phase must be continuous, so the tangential component of the wavevector, $k_0 n sin theta$, is conserved.
  Equating it on the two sides gives Snell's law directly — the same condition that Fermat's principle produces.
  The reflected ray is obtained by requiring the tangential wavevector to be preserved on the same side: $n_1 sin theta_1 = n_1 sin theta_1'$, hence $theta_1 = theta_1'$.
]

== Total Internal Reflection // 全反射

When light enters a less dense medium ($n_1 > n_2$), Snell's law admits a real transmitted angle only up to a limiting incidence.

#definition(name: "Critical Angle")[
  The *critical angle* is defined by
  $
    sin theta_c = frac(n_2, n_1).
  $
  For $theta_1 > theta_c$, Snell's law would require $sin theta_2 > 1$, which has no real solution: no transmitted ray exists and the light is *totally internally reflected*.
] <def:critical-angle>

Beyond the critical angle, the "transmitted" field is an evanescent wave that decays exponentially away from the interface and carries no net energy — the geometric-optics avatar of the evanescent plane waves of Chapter 4.
Its full wave description reappears in Part III.

#note[
  Total internal reflection is the working principle of optical fibres (Section 7.5), prism reflectors, and waveguides.
  If a second interface is placed within a wavelength, a fraction of the energy tunnels through — the phenomenon of *frustrated total internal reflection*, an instance of quantum tunnelling in optics.
]

// --- Chapter 6: Paraxial Optics (近轴光学) ---

= Paraxial Optics // 近轴光学

Most optical instruments are designed so that light stays close to a single axis of symmetry — the *optical axis*.
In this *paraxial regime*, the trigonometric functions of geometric optics linearise, and imaging becomes a linear theory.
This chapter develops the paraxial theory of refraction, mirrors, and lenses, culminating in the thin-lens equation and Gaussian imaging.

== The Paraxial Approximation // 近轴近似

A ray is described, at any plane perpendicular to the optical axis, by its height $y$ above the axis and its inclination angle $theta$.

#definition(name: "Paraxial Approximation")[
  The *paraxial approximation* replaces, for small angles $theta$,
  $
    sin theta approx theta, quad tan theta approx theta, quad cos theta approx 1 - theta^2 / 2.
  $
  To first order, the propagation of rays is then *linear* in the ray variables $(y, theta)$.
] <def:paraxial-approximation>

The approximation is accurate for rays whose angle with the axis is only a few degrees; its failure produces the *aberrations* of Section 7.4.

#caution[
  *Sign convention.* We adopt the standard Cartesian sign convention for ray tracing:
  - Light travels from left to right.
  - Distances measured to the right of a vertex, or along the direction of propagation, are positive.
  - Heights above the optical axis are positive; angles are measured from the axis, counter-clockwise positive.
  The same convention underlies the matrix formalism of Chapter 7.
] <caution:sign-convention>

== Mirrors and Lenses // 球面镜与透镜

A single spherical surface of radius $R$ separates two media of refractive indices $n_1$ (left) and $n_2$ (right).
Consider an object point $P$ on the axis at distance $s$ from the vertex; its paraxial image $P'$ forms at distance $s'$.

#theorem(name: "Single Spherical Refracting Surface")[
  For paraxial rays, a spherical refracting surface obeys
  $
    frac(n_1, s) + frac(n_2, s') = frac(n_2 - n_1, R).
  $
  The image-side focal length of the surface is $f' = n_2 R / (n_2 - n_1)$.
] <thm:spherical-refraction>

#proof[
  *Step 1 — Geometry.*
  Let a paraxial ray from $P$ meet the surface at height $y$.
  With the paraxial angles $alpha = y/s$, $alpha' = y/s'$ and the normal angle $phi = y/R$, the angles of incidence and refraction are $theta_1 = alpha + phi$ and $theta_2 = phi - alpha'$.

  *Step 2 — Snell's law in the paraxial limit.*
  Snell's law $n_1 sin theta_1 = n_2 sin theta_2$ becomes $n_1 theta_1 = n_2 theta_2$:
  $
    n_1 (alpha + phi) = n_2 (phi - alpha').
  $

  *Step 3 — Conclude.*
  Substituting the three angles and cancelling the common height $y$:
  $
    frac(n_1, s) + frac(n_2, s') = frac(n_2 - n_1, R).
  $
]

#figure(
  image("img/spherical-refraction.svg", width: 80%),
  caption: [Imaging by a single spherical refracting surface: the object $P$, the image $P'$, and the centre of curvature $C$ lie on the optical axis.],
  placement: auto,
  supplement: [Fig.]
) <fig:spherical-refraction>

A spherical mirror is the reflection analogue: formally, reflection is refraction into a medium of index $n_2 = - n_1$.
With the mirror sign convention, the paraxial mirror formula is

$
  frac(1, s) + frac(1, s') = frac(2, R),
$

so the focal length is $f = R / 2$ for a concave mirror and $f = - R / 2$ for a convex mirror.

== The Thin-Lens Equation and Lensmaker's Formula // 薄透镜公式与磨镜者公式

A thin lens is two spherical surfaces separated by a negligible thickness.
Applying the single-surface formula twice and passing to the thin limit:

#theorem(name: "Thin-Lens Formula")[
  A thin lens of focal length $f$ images an object at distance $s$ to an image at distance $s'$ according to
  $
    frac(1, s) + frac(1, s') = frac(1, f).
  $
  For a thin lens in air of refractive index $n$ with surface radii $R_1, R_2$, the *lensmaker's formula* gives
  $
    frac(1, f) = (n - 1) (frac(1, R_1) - frac(1, R_2)).
  $
] <thm:thin-lens-formula>

#proof[
  *Step 1 — First surface.*
  The first surface (index $1$ to $n$) forms an intermediate image at distance $s_1'$:
  $
    frac(1, s_1) + frac(n, s_1') = frac(n - 1, R_1).
  $

  *Step 2 — Second surface.*
  This intermediate image is the object for the second surface (index $n$ to $1$):
  $
    frac(n, s_2) + frac(1, s_2') = frac(1 - n, R_2).
  $
  In the thin limit $s_2 = - s_1'$: the object distance for the second surface is the negative of the image distance from the first.

  *Step 3 — Combine.*
  Adding the two equations with $s_2 = - s_1'$ cancels the $n / s_1'$ and $n / s_2$ terms:
  $
    frac(1, s_1) + frac(1, s_2') = (n - 1) (frac(1, R_1) - frac(1, R_2)).
  $
  Writing $s = s_1$, $s' = s_2'$, and $1/f$ for the right-hand side gives the thin-lens formula.
]

#example(name: "Thin-Lens Imaging")[ // 薄透镜成像
  A converging lens of focal length $f = 10 "cm"$ images an object at $s = 15 "cm"$.
  From the thin-lens formula, $1/s' = 1/f - 1/s = 1/10 - 1/15 = 1/30$, so $s' = 30 "cm"$.
  The image is real, inverted, and magnified by $m = - s' / s = - 2$.
]

#figure(
  image("img/lens-imaging.svg", width: 90%),
  caption: [Gaussian imaging with a thin converging lens: three characteristic rays locate the image $P'$ of the object $P$.],
  placement: auto,
  supplement: [Fig.]
) <fig:lens-imaging>

== Gaussian Imaging // 高斯成像

#definition(name: "Principal Planes and Transverse Magnification")[
  The *principal planes* of a lens system are the two planes of unit angular magnification: a ray meeting the first principal plane at height $y$ leaves the second at the same height.
  The *transverse magnification* of a thin lens is
  $
    m = - frac(s', s),
  $
  negative for a real, inverted image.
] <def:principal-planes>

#definition(name: "Gaussian (Newton) Imaging")[
  Measuring object and image distances from the focal points instead of the principal planes, $x = s - f$ and $x' = s' - f$, the imaging condition becomes
  $
    x x' = f^2,
  $
  the *Newton form* of the thin-lens equation.
] <def:gaussian-imaging>

#note[
  The sign conventions matter: for a converging lens, $s > f$ gives a real image ($s' > 0$), while $s < f$ gives a virtual image ($s' < 0$) that can be seen only through the lens.
  The same equations describe mirrors with the appropriate sign conventions.
]

// --- Chapter 7: Matrix Optics and Optical Instruments (矩阵光学与光学仪器) ---

= Matrix Optics and Optical Instruments // 矩阵光学与光学仪器

The paraxial theory of Chapter 6 is linear; this chapter organises it into a compact matrix formalism and applies it to prisms and optical instruments.
Every paraxial optical element is represented by a $2 times 2$ matrix, and a system of elements is represented by the product of their matrices.

== ABCD Matrices and Stability // ABCD 矩阵与稳定性

#definition(name: "ABCD Matrix")[
  A paraxial ray is described by the column vector
  $
    mat(y; theta),
  $
  and each optical element acts by a linear transformation
  $
    mat(y'; theta') = M mat(y; theta) = mat(A, B; C, D) mat(y; theta).
  $
  The elementary matrices are:
  $
    T(d) = mat(1, d; 0, 1) quad text("(translation over distance ") d text(")"),
    quad
    L(f) = mat(1, 0; - 1/f, 1) quad text("(thin lens of focal length ") f text(")").
  $
] <def:abcd-matrix>

For a system of elements with matrices $M_1, M_2, ..., M_N$ traversed in that order, the system matrix is the product in reverse order:

$
  M = M_N dots.c M_2 M_1.
$

#figure(
  image("img/abcd-system.svg", width: 80%),
  caption: [A paraxial ray $(y, theta)$ propagated through a translation $T(d)$ and a thin lens $L(f)$; the system matrix is $L(f) T(d)$.],
  placement: auto,
  supplement: [Fig.]
) <fig:abcd-system>

#theorem(name: "Cavity Stability Criterion")[
  For a periodic system with unimodular matrix $M = mat(A, B; C, D)$ (i.e., $A D - B C = 1$), the repeated propagation $M^n$ remains bounded if and only if
  $
    abs(frac(A + D, 2)) < 1.
  $
] <thm:stability-criterion>

#proof[
  *Step 1 — Eigenvalues.*
  Since $"det"(M) = A D - B C = 1$, the eigenvalues of $M$ satisfy $lambda_1 lambda_2 = 1$ and $lambda_1 + lambda_2 = A + D$.

  *Step 2 — Boundedness.*
  If $abs(A + D) < 2$, the eigenvalues are complex conjugates on the unit circle, $lambda = e^(± i phi)$, and the powers $M^n$ oscillate — the ray stays bounded.
  If $abs(A + D) >= 2$, at least one eigenvalue has modulus $>= 1$, and $M^n$ grows — the ray escapes.
]

#example(name: "Two-Mirror Optical Cavity")[ // 两镜腔
  Consider a cavity of length $d$ between two mirrors of radii of curvature $R_1$ and $R_2$.
  The round-trip matrix is the product of the two mirror matrices and two translations,
  $
    M = mat(1, d; 0, 1) mat(1, 0; - 2/R_1, 1) mat(1, d; 0, 1) mat(1, 0; - 2/R_2, 1),
  $
  and the cavity is stable exactly when $abs(A + D) / 2 < 1$.
  For two plane mirrors ($R = oo$), $A + D = 2$: the cavity sits on the stability boundary.
  The same criterion returns in Chapter 19, where it governs laser resonators.
]

== Prisms and Dispersion // 棱镜与色散

A prism of apex angle $A$ deviates a ray by an angle $delta$ that depends on the incidence angles and on the refractive index.

#definition(name: "Prism Deviation")[
  For a prism of apex angle $A$ and refractive index $n$, the total deviation is
  $
    delta = theta_1 + theta_2' - A,
  $
  where $theta_1$ is the angle of incidence at the first face and $theta_2'$ the angle of emergence from the second.
] <def:prism-deviation>

The deviation is minimised when the ray path through the prism is symmetric; the minimum deviation $delta_"min"$ satisfies

$
  n = frac(sin((A + delta_"min") / 2), sin(A / 2)).
$

#example(name: "Minimum Deviation")[ // 最小偏向角
  A $60°$ prism with $n = 1.5$ satisfies $sin((60° + delta_"min") / 2) = 1.5 sin 30° = 0.75$.
  Hence $delta_"min" = 2 arcsin(0.75) - 60° approx 17.5°$.
]

Since $n$ depends on wavelength, the deviation depends on wavelength: a prism spreads white light into its spectrum.
The *angular dispersion* is $D = dif delta / dif lambda$, and the material dependence $n(lambda)$ is developed in Chapter 13.

#note[
  Prisms and gratings both disperse light; gratings (Chapter 10) disperse by interference rather than refraction.
  The wavelength dependence of $n$ itself — normal and anomalous dispersion — belongs to Part III (Propagation in Media).
]

== Microscopes and Telescopes // 显微镜与望远镜

Optical instruments are sequences of lenses analysed with the matrix formalism of Section 7.1.

#example(name: "Compound Microscope")[ // 显微镜
  A compound microscope consists of a short-focal-length objective and a longer-focal-length eyepiece.
  The objective forms a real, magnified intermediate image; the eyepiece acts as a magnifier.
  The total magnification is the product
  $
    M = M_"obj" M_"eye",
  $
  with the objective magnification $M_"obj" = - L / f_"obj"$ (for tube length $L$) and the eyepiece angular magnification $M_"eye" = 25 "cm" / f_"eye"$ for a near point at $25 "cm"$.
] <ex:microscope>

#example(name: "Refracting Telescope")[ // 折射望远镜
  A Keplerian telescope images a distant object with an objective of focal length $f_"obj"$ and views it through an eyepiece of focal length $f_"eye"$.
  The angular magnification is
  $
    M = - frac(f_"obj", f_"eye"),
  $
  so a long objective and a short eyepiece give high magnification.
  The Galilean telescope uses a negative eyepiece, giving an erect image with $M = f_"obj" / f_"eye"$ and a shorter tube.
] <ex:telescope>

#figure(
  image("img/optical-instruments.svg", width: 100%),
  caption: [Ray diagrams of (a) a compound microscope and (b) a Keplerian refracting telescope.],
  placement: auto,
  supplement: [Fig.]
) <fig:optical-instruments>

#note[
  *Resolution.* Magnification alone is useless beyond the *diffraction limit*: a lens of diameter $D$ cannot separate two points whose angular separation is below $approx 1.22 lambda / D$ (Rayleigh criterion).
  This wave-optical limit is developed in Chapter 10.
]

== Aberrations // 像差 [简要]

#property(name: "Aberration Types")[
  - *Spherical aberration*: rays far from the axis focus at a different point than paraxial rays.
  - *Coma*: off-axis point sources produce comet-like images.
  - *Astigmatism*: meridional and sagittal rays focus at different distances.
  - *Field curvature*: the image surface is curved rather than flat.
  - *Distortion*: magnification varies across the field (barrel / pincushion).
  - *Chromatic aberration*: $n(lambda)$ varies with wavelength, so different colours focus at different distances (axial) and at different magnifications (lateral).
] <prop:aberration-types>

#note[
  Aberrations are exactly the failure of the paraxial approximation of Section 6.1, i.e., of the linear theory.
  Their detailed theory belongs to lens design; here we only catalogue them, since the wave optics of Part III accounts for the diffraction limit rather than for geometric aberrations.
]

== Optical Fibers // 光纤 [简要]

#definition(name: "Numerical Aperture")[
  A step-index optical fibre consists of a core of index $n_1$ surrounded by a cladding of index $n_2 < n_1$.
  Light is guided by total internal reflection (Section 5.5); the maximum acceptance angle $theta_a$ in air satisfies
  $
    "NA" = n_"air" sin theta_a = sqrt(n_1^2 - n_2^2),
  $
  where $"NA"$ is the *numerical aperture*.
] <def:numerical-aperture>

#note[
  The modes of a fibre — the discrete transverse patterns it can support — are a wave phenomenon invisible to geometric optics; they are governed by the Helmholtz equation with cylindrical symmetry and belong to Part III.
  The evanescent field outside the core is the same phenomenon as in Section 5.5.
]

// --------------------------------------------------------------------------
// Part III: Wave Optics (波动光学)
// --------------------------------------------------------------------------

#part("Wave Optics") // 波动光学

// --- Chapter 8: Scalar Diffraction Theory (标量衍射理论) ---

= Scalar Diffraction Theory // 标量衍射理论

Geometric optics traced rays; wave optics propagates fields.
This chapter builds the unifying framework for the whole of Part III: the diffraction integral, obtained as the Green-function solution of the Helmholtz equation.
Every phenomenon studied in Part III — interference, diffraction patterns, imaging by lenses, resolution limits — is this integral evaluated in a suitable approximation.

== The Helmholtz Equation for Optical Fields // 光场的亥姆霍兹方程

The electromagnetic field is a vector field, but in free space and in media whose index varies slowly each Cartesian component satisfies the same scalar wave equation (see Électrodynamique).
We therefore work with a single complex scalar amplitude $U(bold(r))$.

#definition(name: "Scalar Optical Field")[
  A *scalar optical field* $U(bold(r))$ is a solution of the Helmholtz equation
  $
    (nabla^2 + k^2) U = 0,
  $
  where $k = 2 pi n / lambda_0$ is the wavenumber in the medium.
  The physical field is recovered as $u(bold(r), t) = "Re"(U(bold(r)) e^(-i omega t))$, with the time-harmonic convention of Chapter 4.
] <def:scalar-field>

A unique solution requires boundary conditions.
On an aperture or screen we prescribe the field or its normal derivative; for radiation problems we add the Sommerfeld radiation condition of Chapter 4, which selects the outgoing solutions.

#note[
  The scalar approximation fails near sharp edges, in strongly absorbing media, and for tightly focused beams, where the vector character of the field (Chapter 12) must be retained.
]

== The Huygens-Fresnel Principle // 惠更斯-菲涅耳原理

#definition(name: "Huygens-Fresnel Principle")[
  Every point $P_0$ of a wavefront acts as a source of secondary spherical wavelets with amplitude proportional to $e^(i k r) / r$, weighted by an obliquity factor $K(theta)$ depending on the angle $theta$ between the direction of propagation and the normal to the wavefront.
  The field at a later point $P$ is the superposition of all secondary wavelets.
] <def:huygens-fresnel>

The principle converts propagation into an integral over the wavefront:

$
  U(P) = 1 / (i lambda) integral_Sigma U(P_0) e^(i k r) / r K(theta) dif S.
$

The factor $1 / (i lambda)$ and the obliquity factor $K(theta)$ cannot be obtained from the intuitive argument alone; they emerge from the rigorous diffraction theory of Section 8.3.

#figure(
  image("img/huygens-fresnel.svg", width: 80%),
  caption: [The Huygens-Fresnel construction: secondary spherical wavelets emitted from a wavefront, whose envelope forms the new wavefront.],
  placement: auto,
  supplement: [Fig.]
) <fig:huygens-fresnel>

== Kirchhoff and Rayleigh-Sommerfeld Integrals // 基尔霍夫与瑞利-索末菲积分

The diffraction integral follows from Green's theorem applied to the Helmholtz equation.

#theorem(name: "Kirchhoff Diffraction Integral")[
  Let $Sigma$ be an aperture in an opaque screen, and let $U$ be a field that satisfies the Helmholtz equation behind the screen.
  With the free-space Green's function $G = e^(i k r) / r$, the field at a point $P$ is
  $
    U(P) = 1 / (4 pi) integral_Sigma [U (partial G)/(partial n) - G (partial U)/(partial n)] dif S,
  $
  where $partial / partial n$ is the outward normal derivative and $r$ is the distance from the integration point to $P$.
] <thm:kirchhoff-integral>

#proof[
  *Step 1 — Green's second identity.*
  For two smooth functions $U$ and $G$ on a volume $V$ bounded by a surface $S$:
  $
    integral_V (U nabla^2 G - G nabla^2 U) dif V = integral_S (U (partial G)/(partial n) - G (partial U)/(partial n)) dif S.
  $

  *Step 2 — Apply to the Helmholtz equation.*
  Both $U$ and $G$ solve the Helmholtz equation away from the singular point of $G$, so $U nabla^2 G - G nabla^2 U = 0$ on the integration region.
  The surface integral therefore reduces to the boundary $Sigma$ (the aperture) together with the point $P$ itself.

  *Step 3 — Pick up the singularity.*
  Surrounding $P$ by a small sphere of radius $epsilon$ and using $G = e^(i k r) / r$ on it, the integral over the small sphere gives $4 pi U(P)$ as $epsilon -> 0$.
  Rearranging yields the Kirchhoff integral.
]

The theorem as stated uses the *Kirchhoff boundary conditions*: on the aperture $U$ and $partial U / partial n$ take the values of the incident field, and on the screen they vanish.

#note[
  *Inconsistency.* The Kirchhoff conditions assign both $U$ and its normal derivative on the screen, which over-determines the elliptic problem: a Helmholtz solution is fixed by one boundary condition alone.
  Moreover the formula fails to reproduce the incident field in the absence of a screen (the so-called *obliquity paradox*).
  The Rayleigh-Sommerfeld theory repairs both defects.
]

#theorem(name: "Rayleigh-Sommerfeld Diffraction Integral")[
  Choose the Green's function with vanishing value on the screen, $G_D = e^(i k r) / r - e^(i k r') / r'$, where $r'$ is the distance to the mirror image of $P$ in the plane of the screen.
  Then the Dirichlet problem has the solution
  $
    U(P) = 1 / (i lambda) integral_Sigma U(P_0) e^(i k r) / r cos theta dif S,
  $
  where $theta$ is the angle between the segment $P_0 P$ and the normal to the screen.
] <thm:rayleigh-sommerfeld>

#proof[
  *Step 1 — A Dirichlet Green's function.*
  The mirrored source makes $G_D$ vanish identically on the screen, so the boundary term containing $G_D (partial U)/(partial n)$ disappears from Green's identity.

  *Step 2 — Normal derivative on the screen.*
  For a point $P_0$ in the aperture and observation point $P$, a direct differentiation gives
  $
    (partial G_D)/(partial n) = - 2 i k cos theta e^(i k r) / r,
  $
  up to terms of higher order in $1 / r$.

  *Step 3 — Conclude.*
  Substitution into Green's identity yields
  $
    U(P) = 1 / (i lambda) integral_Sigma U(P_0) e^(i k r) / r cos theta dif S.
  $
]

The Rayleigh-Sommerfeld integral uses only the field on the aperture — a mathematically consistent Dirichlet problem — and automatically produces the correct obliquity factor $K(theta) = cos theta$.

#note[
  The Kirchhoff and Rayleigh-Sommerfeld integrals differ in their obliquity factors ($(1 + cos theta) / 2$ versus $cos theta$) and in their treatment of the boundary data.
  For apertures large compared with the wavelength, and for observation points not too oblique, the two agree to leading order.
]

== Green's Functions for Diffraction // 衍射的格林函数

#definition(name: "Free-Space Green's Function")[
  The *free-space Green's function* for the Helmholtz equation satisfies
  $
    (nabla^2 + k^2) G = - 4 pi delta(bold(r) - bold(r)'),
  $
  and is given by
  $
    G(bold(r), bold(r)') = e^(i k abs(bold(r) - bold(r)')) / abs(bold(r) - bold(r)').
  $
] <def:green-diffraction>

The Green's function admits a plane-wave (angular-spectrum) representation: it is the superposition of the outgoing plane waves of Chapter 4.
This is the precise sense in which the diffraction integrals of this chapter are the angular-spectrum representation evaluated at a distant observation plane, redeeming the promise of Chapter 4.

#note[
  *Evanescent waves.* The angular-spectrum form of the Green's function contains the evanescent components identified in Section 4.4.
  Their full wave description — exponential decay away from the aperture, frustrated total internal reflection — was promised at the end of Chapter 5 and is now accounted for by the exact diffraction theory.
]

#note[
  *Guided modes.* In cylindrical symmetry (fibres, Chapter 7), the Helmholtz equation separates with Bessel functions, and the transverse patterns are the discrete guided modes promised in Section 7.5.
  The same Green-function machinery, with the appropriate modal basis, describes their propagation.
]

// --- Chapter 9: Interference and Coherence (干涉与相干性) ---

= Interference and Coherence // 干涉与相干性

Interference is the superposition of coherent fields: when two or more light waves meet, their amplitudes add and the intensity shows stationary bright and dark fringes.
This chapter develops two-beam and multiple-beam interference, and then asks how stable the phase relationship must be — leading from deterministic interference to the statistical theory of coherence.

== Two-Beam Interference: Young's Experiment // 杨氏双缝

#definition(name: "Optical Path Difference")[
  The *optical path difference* (OPD) between two rays reaching a common point is
  $
    Delta = n_2 s_2 - n_1 s_1,
  $
  the difference of their optical paths.
  A phase difference $delta = k_0 Delta$ accompanies it, where $k_0 = 2 pi / lambda_0$ is the vacuum wavenumber.
] <def:optical-path-difference>

In Young's experiment two slits separated by $d$, illuminated by a common source, emit secondary waves.
At a point on a screen at distance $R$, the path difference is $Delta = d sin theta approx d y / R$, where $y$ is the height of the point above the axis.

For equal amplitudes $U_0$, the two-beam intensity is

$
  I(y) = 4 I_0 cos^2 (pi d y / (lambda R)).
$

Bright fringes occur where $d sin theta = m lambda$ ($m in bb(Z)$), with spacing $Delta y = lambda R / d$.

#example(name: "Young's Fringes")[ // 杨氏双缝
  Two slits $d = 1 "mm"$ apart, illuminated with green light $lambda = 550 "nm"$, project fringes on a screen $R = 2 "m"$ away.
  The fringe spacing is $Delta y = lambda R / d = (550 times 10^(-9) dot 2) / (10^(-3)) = 1.1 "mm"$, comfortably visible to the naked eye.
]

#figure(
  image("img/young-double-slit.svg", width: 80%),
  caption: [Young's double-slit experiment: geometry (top) and the cosine-squared fringe intensity (bottom).],
  placement: auto,
  supplement: [Fig.]
) <fig:young-double-slit>

#definition(name: "Fringe Visibility")[
  The *visibility* (contrast) of an interference pattern is
  $
    V = (I_"max" - I_"min") / (I_"max" + I_"min"),
  $
  with $0 <= V <= 1$.
  Perfectly coherent equal-amplitude beams give $V = 1$; incoherent superposition gives $V = 0$.
] <def:fringe-visibility>

#note[
  Real slits have finite width: each slit diffracts, and the two-beam pattern is modulated by the single-slit diffraction envelope (Chapter 10).
  The diffraction envelope answers "where the light goes"; the interference term answers "how it distributes within the envelope".
]

== Interference of Thin Films // 薄膜干涉

A thin film of thickness $t$ and index $n$ between two media reflects light from both surfaces.
The reflected waves interfere with phase difference from the extra optical path $2 n t cos theta_t$ and from any phase jump at reflection:

$
  Delta = 2 n t cos theta_t + (lambda_0) / 2,
$

where the $lambda_0 / 2$ term accounts for a phase jump of $pi$ when light reflects off a denser medium.

#example(name: "Newton's Rings")[ // 牛顿环
  A plano-convex lens of radius $R$ resting on a flat plate creates a film of thickness $t(r) approx r^2 / (2 R)$.
  Bright rings occur where $2 t = (m + 1/2) lambda$, giving ring radii $r_m approx sqrt(m lambda R)$.
  Newton's rings were decisive evidence for the wave nature of light.
] <ex:newton-rings>

#note[
  Films of constant thickness produce *equal-inclination* fringes (colours varying with viewing angle, as in soap bubbles); films of varying thickness produce *equal-thickness* fringes (as in Newton's rings and oil slicks).
]

== The Michelson Interferometer // 迈克耳孙干涉仪

A Michelson interferometer splits a beam at a half-silvered mirror, sends the two parts to fixed and movable mirrors, and recombines them.
The optical path difference is twice the displacement $Delta L$ of the movable mirror:

$
  Delta = 2 Delta L.
$

Moving the mirror by $lambda / 2$ shifts the pattern by one full fringe, so the interferometer measures lengths and wavelengths with interferometric precision.

#note[
  The Michelson interferometer is the archetype of amplitude-splitting interferometers.
  Its modern descendants include Fourier-transform spectrometers, gravitational-wave detectors (LIGO-type cavities), and the coherence measurements of Section 9.6.
]

== Multiple-Beam Interference: Fabry-Perot // 多光束干涉与法布里-珀罗

A Fabry-Perot interferometer is a pair of parallel, highly reflecting surfaces.
Light bounces many times between them; the transmitted field is the coherent sum of all transmitted partial waves.

#theorem(name: "Airy Function")[
  For a Fabry-Perot etalon with amplitude reflectivity $r$ (intensity reflectivity $R = r^2$) and round-trip phase $delta = 2 k n d cos theta_t$, the transmitted intensity is
  $
    I = I_"max" / (1 + F sin^2 (delta / 2)),
  $
  where $I_"max" = T^2 / (1 - R)^2 I_"in"$ and the *coefficient of finesse* is
  $
    F = (4 R) / (1 - R)^2.
  $
] <thm:airy-function>

#proof[
  *Step 1 — Sum the partial waves.*
  The transmitted field is the geometric series
  $
    E_t = E_0 t^2 (1 + r^2 e^(i delta) + r^4 e^(i 2 delta) + dots.c) = (E_0 t^2) / (1 - r^2 e^(i delta)).
  $

  *Step 2 — Take the modulus squared.*
  With $R = r^2$ and $T = t^2$,
  $
    I = I_"in" T^2 / abs(1 - R e^(i delta))^2 = (I_"in" T^2) / (1 - 2 R cos delta + R^2).
  $

  *Step 3 — Express in the finesse form.*
  Using $1 - 2 R cos delta + R^2 = (1 - R)^2 (1 + F sin^2 (delta / 2))$ completes the proof.
]

#example(name: "Fabry-Perot Resolution")[ // 法布里-珀罗分光本领
  The finesse $cal(F) = pi sqrt(F) / 2$ measures the sharpness of the transmission peaks.
  For $R = 0.97$, $F = 4 R / (1 - R)^2 approx 4300$ and $cal(F) approx 100$.
  A Fabry-Perot of plate spacing $d = 1 "cm"$ then resolves wavelengths separated by $Delta lambda approx lambda^2 / (2 d cal(F))$, far beyond what a grating of the same size can do.
] <ex:fabry-perot-resolution>

#note[
  The two-beam pattern is a broad $cos^2$; the multiple-beam pattern is a comb of sharp peaks.
  The sharpness is what makes the Fabry-Perot the standard tool for high-resolution spectroscopy and for laser cavities (Chapter 19).
]

== Temporal and Spatial Coherence // 时间/空间相干性

Real sources are not perfectly monochromatic, and their wavefronts are not perfectly correlated.
Two independent notions of coherence describe the two defects.

#definition(name: "Coherence Time and Length")[
  A source with bandwidth $Delta nu$ has *coherence time*
  $
    tau_c approx 1 / (Delta nu),
  $
  and *coherence length*
  $
    L_c = c tau_c approx c / (Delta nu) approx lambda_0^2 / (Delta lambda).
  $
  Waves separated by more than $L_c$ have lost their fixed phase relationship.
] <def:coherence-time-length>

A thermal source is temporally incoherent: its coherence length is tiny ($L_c ~ 1 mu "m"$ for white light).
A laser is highly coherent: a narrow linewidth $Delta nu ~ 1 "MHz"$ gives $L_c ~ 300 "m"$.

#definition(name: "Spatial Coherence")[
  A source has *spatial coherence* over a transverse separation if the fields at two points of a wavefront maintain a fixed phase relationship.
  In Young's experiment, spatial coherence is measured by the visibility as the slit separation $d$ grows: fringes disappear when $d$ exceeds the transverse coherence width, $d_c approx lambda R / sigma_s$, where $sigma_s$ is the source size.
] <def:spatial-coherence>

#note[
  The sun subtends a small angle, so sunlight is partially spatially coherent: Young's fringes are visible with slits close together but vanish as the slits are separated.
  Stellar interferometry exploits exactly this: measuring the slit separation at which fringes vanish yields the angular diameter of a star.
]

== Coherence Length and Visibility // 相干长度与可见度

#definition(name: "Complex Degree of Coherence")[
  The normalized first-order correlation of two fields is the *complex degree of coherence*
  $
    gamma_(12)(tau) = (⟨ U_(1)(t + tau) U_(2)^"*"(t) ⟩) / sqrt(⟨ abs(U_(1))^2 ⟩ ⟨ abs(U_(2))^2 ⟩),
  $
  where the averages are over time.
  Its modulus satisfies $0 <= abs(gamma_(12)) <= 1$.
] <def:complex-coherence-degree>

For quasi-monochromatic fields, the visibility of the interference pattern equals the modulus of the degree of coherence:

$
  V = abs(gamma_(12)(0)) .
$

Perfect coherence ($abs(gamma) = 1$) gives unit visibility; incoherence ($abs(gamma) = 0$) gives none.
The fringe phase carries the argument of $gamma$, which encodes the optical path difference.

#note[
  The degree of coherence is the classical precursor of the first-order correlation function of quantum optics: the Hanbury Brown–Twiss experiments of Chapter 17 measure the second-order analogue, and photon statistics sharpen the classical average into a quantum expectation.
]

// --- Chapter 10: Diffraction (衍射) ---

= Diffraction // 衍射

The diffraction integral of Chapter 8 is exact but rarely evaluated in closed form.
This chapter introduces the two standard approximations — Fresnel (near field) and Fraunhofer (far field) — and applies them to slits, apertures, gratings, and imaging.
The Fraunhofer patterns are nothing but Fourier transforms of the aperture, which prepares the Fourier optics of Chapter 11.

== Fresnel Diffraction and Zone Plates // 菲涅耳衍射与波带片

#definition(name: "Fresnel Approximation")[
  For an aperture at $z = 0$ and observation at distance $z$, the *Fresnel approximation* keeps quadratic phase terms in the diffraction integral:
  $
    U(x, y) = e^(i k z) / (i lambda z) integral.double U_0(x_0, y_0) e^(i k / (2 z) [(x - x_0)^2 + (y - y_0)^2]) dif x_0 dif y_0.
  $
  It is valid when the Fresnel number $F_N = a^2 / (lambda z)$ is of order unity or larger, i.e., in the near field.
] <def:fresnel-approximation>

#definition(name: "Fresnel Integrals")[
  The *Fresnel integrals* are
  $
    C(s) = integral_0^s cos(pi u^2 / 2) dif u, quad S(s) = integral_0^s sin(pi u^2 / 2) dif u.
  $
  They describe the one-dimensional near-field patterns, e.g., diffraction by a straight edge.
] <def:fresnel-integral>

The Fresnel integral has no elementary closed form, but it is well tabulated; its limit at infinity is $C(oo) = S(oo) = 1/2$.

#note[
  *Zone plates.* Divide the wavefront into concentric *half-period zones* so that waves from successive zones arrive out of phase.
  Blocking every other zone turns the remaining zones into an approximate converging lens: a zone plate focuses light even though it contains no refracting material.
]

== Fraunhofer Diffraction: Single Slit and Circular Aperture // 夫琅禾费衍射

#definition(name: "Fraunhofer Approximation")[
  The *Fraunhofer (far-field) approximation* holds when $z >> a^2 / lambda$, where $a$ is the largest aperture dimension.
  Then the quadratic phase terms in the Fresnel integral reduce to
  $
    U(u, v) = e^(i k z) / (i lambda z) e^(i k (u^2 + v^2) / (2 z)) integral.double U_0(x_0, y_0) e^(- i k (x_0 u + y_0 v) / z) dif x_0 dif y_0.
  $
  Apart from a phase factor, the far field is the *two-dimensional Fourier transform* of the aperture field.
] <def:fraunhofer-approximation>

The Fourier structure explains everything that follows: the far-field pattern is the spatial-frequency content of the aperture.

#theorem(name: "Fraunhofer Diffraction by a Single Slit")[
  A slit of width $a$ illuminated by a plane wave produces the far-field intensity
  $
    I(theta) = I_0 "sinc"^2 (beta), quad beta = (k a sin theta) / 2,
  $
  where $"sinc"(x) = sin x / x$.
  The first zeros lie at $sin theta = ± lambda / a$.
] <thm:fraunhofer-single-slit>

#proof[
  *Step 1 — Fourier transform of a rectangle.*
  The aperture field is $U_0(x_0) = U_0$ on $|x_0| <= a/2$ and zero elsewhere.
  Its Fourier transform is proportional to the integral $integral_(-a/2)^(a/2) e^(- i k x_0 sin theta) dif x_0 = a "sinc"(k a sin theta / 2)$.

  *Step 2 — Intensity.*
  Squaring the modulus gives $I(theta) prop "sinc"^2(k a sin theta / 2)$, hence the stated form with $beta = k a sin theta / 2$.
]

#theorem(name: "Fraunhofer Diffraction by a Circular Aperture")[
  A circular aperture of diameter $D$ produces the *Airy pattern*
  $
    I(theta) = I_0 (2 J_(1)(x) / x)^2, quad x = (k D sin theta) / 2,
  $
  where $J_(1)$ is the Bessel function of the first kind of order one.
  The first dark ring lies at $x = 3.832$, i.e.,
  $
    sin theta_(1) = 1.22 lambda / D.
  $
] <thm:airy-pattern>

#proof[
  *Step 1 — Fourier transform in polar coordinates.*
  The circular aperture is the indicator of a disk; its two-dimensional Fourier transform is the Hankel transform of the disk, which evaluates to $2 J_(1)(x) / x$.

  *Step 2 — First zero.*
  The first zero of $J_(1)(x)$ is at $x = 3.8317 approx 1.22 pi$, giving $sin theta_(1) = 1.22 lambda / D$.
]

#example(name: "Airy Disc Diameter")[ // 艾里斑直径
  A camera lens of diameter $D = 25 "mm"$ at $lambda = 550 "nm"$ has an Airy disc of angular radius $theta_(1) = 1.22 lambda / D approx 2.7 times 10^(-5) "rad"$, i.e., about $5.4 "mm"$ at a focal distance of $200 "mm"$.
  Stopping the lens down increases the Airy disc — smaller aperture, worse diffraction resolution.
] <ex:airy-disc-diameter>

#figure(
  image("img/fraunhofer-patterns.svg", width: 100%),
  caption: [Fraunhofer diffraction patterns: single slit (sinc²), double slit (interference modulated by diffraction), and circular aperture (Airy pattern).],
  placement: auto,
  supplement: [Fig.]
) <fig:fraunhofer-patterns>

#note[
  The double-slit pattern is the product of the two-slit interference term of Chapter 9 and the single-slit diffraction envelope of this section:
  $
    I(theta) = 4 I_0 cos^2(pi d sin theta / lambda) "sinc"^2(k a sin theta / 2).
  $
]

== Diffraction Gratings and Spectroscopy // 衍射光栅与光谱学

#definition(name: "Grating Equation")[
  A grating of period $d$ (slits or grooves) produces principal maxima at angles satisfying
  $
    d sin theta = m lambda, quad m in bb(Z).
  $
] <def:grating-equation>

#theorem(name: "Grating Resolution")[
  A grating with $N$ illuminated grooves resolves wavelengths differing by
  $
    (lambda) / (Delta lambda) = m N,
  $
  the *resolving power* at order $m$.
] <thm:grating-resolution>

#proof[
  *Step 1 — Principal maximum.*
  For $N$ equally spaced slits, the intensity is
  $
    I = I_0 (sin(N delta / 2) / sin(delta / 2))^2, quad delta = (2 pi d sin theta) / lambda.
  $
  Principal maxima occur at $delta = 2 pi m$, i.e., $d sin theta = m lambda$.

  *Step 2 — Nearest zero.*
  The first zero next to the maximum is at $N delta / 2 = m N pi ± pi$, i.e., at $Delta delta = 2 pi / N$.

  *Step 3 — Resolving power.*
  Differentiating the grating equation at fixed $theta$: $Delta delta = 2 pi m (Delta lambda) / lambda$.
  Setting this equal to $2 pi / N$ gives $lambda / Delta lambda = m N$.
]

#example(name: "Grating Spectral Resolution")[ // 光栅分光
  A grating with $N = 10^4$ grooves at order $m = 2$ has resolving power $lambda / Delta lambda = 2 times 10^4$.
  At $lambda = 500 "nm"$, it separates lines $Delta lambda = 0.025 "nm"$ apart — enough to resolve the sodium doublet ($589.0$ and $589.6 "nm"$).
] <ex:grating-spectral-resolution>

#note[
  When $d$ is an integer multiple of the slit width $a$, certain orders are *missing*: the diffraction envelope has a zero exactly where the interference has a maximum.
  This is the textbook mechanism of the missing orders $m = ± d / a, ± 2 d / a, dots.c$.
]

== Resolution: Rayleigh and Abbe Criteria // 分辨极限

The finite size of any aperture sets a fundamental limit on imaging: the image of a point is an Airy pattern, not a point.

#definition(name: "Rayleigh Criterion")[
  Two point sources are *resolved* when the first dark ring of one Airy pattern falls on the maximum of the other:
  $
    theta_"min" = 1.22 lambda / D.
  $
  The two patterns are then separated by the half-width of the Airy disc.
] <def:rayleigh-criterion>

#definition(name: "Abbe Resolution Limit")[
  For a microscope with numerical aperture $"NA" = n sin theta$ (Section 7.5), the finest resolvable spacing is
  $
    d_"min" = (lambda) / (2 "NA").
  $
] <def:abbe-limit>

#figure(
  image("img/resolution-criterion.svg", width: 100%),
  caption: [The Rayleigh criterion: two Airy patterns at separations below, equal to, and above $theta_"min"$ — unresolved, just resolved, and resolved.],
  placement: auto,
  supplement: [Fig.]
) <fig:resolution-criterion>

#note[
  *Why the limit is fundamental.* The angular-spectrum analysis of Section 4.4 showed that fine spatial detail generates evanescent waves that do not propagate to the far field.
  The Rayleigh and Abbe criteria are exactly that statement in imaging language: the aperture collects only the propagating components, so detail finer than $lambda / (2 "NA")$ is lost — the wave-optical limit promised in Chapter 7.
]

// --- Chapter 11: Fourier Optics (傅里叶光学) ---

= Fourier Optics // 傅里叶光学

Section 10.2 showed that the Fraunhofer pattern is the Fourier transform of the aperture.
This chapter makes that observation operational: a lens performs the transform optically, and two lenses in a row build a complete filtering system.
Fourier optics is the engineering branch of wave optics, and it redeems the promise of Chapter 4 that the lens implements the angular-spectrum representation as a physical Fourier transform.

== The Lens as a Fourier Transformer // 透镜作为傅里叶变换器

A thin lens of focal length $f$ delays the wave by a thickness proportional to $x^2 + y^2$.
Its transmission function is the quadratic phase factor

$
  t(x, y) = e^(- i k (x^2 + y^2) / (2 f)).
$

#theorem(name: "Lens Fourier Transform")[
  Place an input field $U_(i n)(x, y)$ in the front focal plane of a lens ($z = - f$) and observe the field in the back focal plane ($z = f$).
  Then
  $
    U_(f)(u, v) = 1 / (i lambda f) integral.double U_(i n)(x, y) e^(- i k (x u + y v) / f) dif x dif y,
  $
  the two-dimensional Fourier transform of the input evaluated at spatial frequencies $f_x = u / (lambda f)$, $f_y = v / (lambda f)$.
] <thm:lens-fourier-transform>

#proof[
  *Step 1 — Lens phase.*
  Immediately after the lens the field is $U_(i n)(x, y) t(x, y)$, with $t$ the quadratic phase factor above.

  *Step 2 — Fresnel propagation to the focal plane.*
  Propagate this field a distance $f$ with the Fresnel integral of Section 10.1.
  The quadratic phase of $t$ cancels the quadratic phase of the Fresnel kernel exactly, leaving only the cross term.

  *Step 3 — Conclude.*
  The surviving term is the stated integral: the lens converts the quadratic Fresnel kernel into the linear Fourier kernel.
]

The magic of the result is the cancellation: without the lens the Fresnel kernel keeps its quadratic phase and no clean transform appears.

#note[
  *The 2f system.* With the input in the front focal plane, the output is a *strict* Fourier transform with no residual phase factor.
  If the input is placed elsewhere, the output carries an additional quadratic phase, so the standard configuration for Fourier processing is the 2f system.
  This is the lens analysis promised in Chapter 4, where the angular-spectrum representation is physically implemented by the lens.
]

#figure(
  image("img/lens-fourier.svg", width: 90%),
  caption: [The 2f Fourier system: an input placed one focal length in front of the lens produces its Fourier transform in the back focal plane.],
  placement: auto,
  supplement: [Fig.]
) <fig:lens-fourier>

== Aperture Functions and Pupil Transforms // 孔径函数与光瞳变换

#definition(name: "Pupil Function")[
  The *pupil (aperture) function* $P(x, y)$ is the complex transmission of the limiting aperture of an optical system: it is 1 inside the aperture and 0 outside, with possible additional phase (aberrations).
  The far field of the aperture is the Fourier transform of $P$.
] <def:pupil-function>

The pupil function unifies the diffraction results of Chapter 10: the single slit, the circular aperture, and every grating are special pupils.
An imaging system with pupil $P$ acts as a linear filter on the field, and its impulse response is the Fraunhofer pattern of $P$.

== Spatial Filtering // 空间滤波

A *4f system* chains two Fourier transforms: lens 1 produces the spectrum of the input in its focal plane, where a filter is inserted, and lens 2 Fourier-transforms the filtered spectrum back to an image.

#example(name: "4f Spatial Filtering")[ // 4f 空间滤波
  - *Low-pass filter*: a circular stop on the axis blocks high spatial frequencies — the image is blurred and speckle and periodicity are suppressed.
  - *High-pass filter*: an opaque disc on the axis blocks the DC and low frequencies — edges are enhanced, since edges live in the high-frequency content.
  - *Phase filter*: a phase plate alters the spectrum, e.g., for phase contrast microscopy of transparent specimens.
] <ex:4f-spatial-filtering>

The 4f system is the physical image of the statement "multiplication in the frequency domain" that underlies all linear filtering, and it is the basis of optical information processing.

== PSF, OTF and the Coherent Transfer Function // 点扩散函数与光学传递函数

#definition(name: "PSF and OTF")[
  The *point spread function* (PSF) of an incoherent imaging system is the intensity pattern produced by a point source, the squared modulus of the pupil's Fraunhofer pattern:
  $
    "PSF"(x, y) = abs(cal(F)[P](x, y))^2.
  $
  The *optical transfer function* (OTF) is the normalized Fourier transform of the PSF:
  $
    "OTF"(f_x, f_y) = cal(F)["PSF"](f_x, f_y) / cal(F)["PSF"](0, 0).
  $
  The image is the convolution of the ideal image with the PSF, so the OTF multiplies the object spectrum.
] <def:psf-otf>

#definition(name: "Coherent Transfer Function")[
  For coherent illumination the field amplitudes add, and the system is linear in the *field* rather than the intensity.
  The transfer function is then the pupil function itself:
  $
    "CTF"(f_x, f_y) = P(lambda f f_x, lambda f f_y).
  $
] <def:coherent-transfer-function>

#note[
  The distinction is sharp: coherent imaging is linear in amplitude (CTF = P), incoherent imaging is linear in intensity (OTF = |P| ⊛ |P|, the autocorrelation of the pupil).
  The Abbe limit of Section 10.4 is the support of the CTF: spatial frequencies beyond the pupil support are simply cut off.
]

== Holography // 全息 [简要]

#definition(name: "Holography")[
  A *hologram* is an interference record of the object wave with a known reference wave, recorded on a photographic plate.
  Illuminating the record with the reference wave reconstructs the object wave by diffraction: the plate acts as a complicated grating whose first-order diffraction reproduces the original wavefront, with full phase information.
] <def:holography>

#note[
  Ordinary photography records intensity only, losing the phase; the hologram records both, because the reference wave converts phase into intensity fringes.
  Reconstructing the wavefront makes the holographic image three-dimensional: moving one's viewpoint reveals parallax, exactly as for the original object.
]

// --- Chapter 12: Polarization (偏振) ---

= Polarization // 偏振

So far the field was scalar. Light, however, is a vector field, and its transverse structure is the polarization.
This chapter returns to the vector character promised in Chapter 4, describes polarization states by two compact algebras — Jones (2 × 2, coherent) and Mueller (4 × 4, incoherent) — and studies how matter modifies them.

== Polarization States of Light // 光的偏振态

#definition(name: "Polarization State")[
  A plane wave along $z$ has an electric field confined to the transverse plane:
  $
    bold(E)(z, t) = "Re" [mat(E_x; E_y) e^(i (k z - omega t))],
  $
  with complex amplitudes $E_x, E_y$.
  The *polarization state* is the relative amplitude and phase of the two components.
] <def:polarization-state>

Writing $E_y / E_x = tan chi e^(i delta)$, the tip of the field vector traces an ellipse:

- $delta = 0$ or $pi$: *linear polarization*;
- $delta = ± pi / 2$ with $chi = pi / 4$: *circular polarization* (right or left);
- otherwise: *elliptical polarization*.

#figure(
  image("img/polarization-ellipse.svg", width: 100%),
  caption: [Polarization ellipses traced by the electric vector for phase differences $delta = 0, pi / 2$, and a general value, with $E_y / E_x = 1$.],
  placement: auto,
  supplement: [Fig.]
) <fig:polarization-ellipse>

#note[
  The polarization state is a point on the *Poincaré sphere*: the equator carries the linear states, the poles the circular states, and every other point an elliptical state.
  This geometric picture becomes the quantum Bloch-sphere picture of photon polarization in Part IV.
]

== Jones Calculus // 琼斯运算

#definition(name: "Jones Vector and Jones Matrix")[
  The *Jones vector* is the column of complex amplitudes
  $
    bold(J) = mat(E_x; E_y).
  $
  A polarizing element is represented by a $2 times 2$ complex *Jones matrix* $M$, and the output state is
  $
    bold(J)' = M bold(J).
  $
] <def:jones-vector>

#definition(name: "Jones Matrices of Basic Elements")[
  - *Linear polarizer* at angle $theta$: $M = mat(cos^2 theta, cos theta sin theta; cos theta sin theta, sin^2 theta)$.
  - *Retarder* (wave plate) with fast-axis angle $phi$ and retardance $delta$: a phase-only unitary matrix; for fast axis along $x$:
    $
      M = mat(e^(- i delta / 2), 0; 0, e^(i delta / 2)).
    $
  - *Rotator* by angle $alpha$: $M = mat(cos alpha, - sin alpha; sin alpha, cos alpha)$.
] <def:jones-matrix>

The Jones calculus is valid for fully polarized, coherent light: amplitudes add, and matrices compose by multiplication in order.

== Stokes Parameters and Mueller Calculus // 斯托克斯参量与缪勒矩阵

#definition(name: "Stokes Parameters")[
  The *Stokes parameters* of a field are the four real quantities
  $
    S_0 = abs(E_x)^2 + abs(E_y)^2, quad S_1 = abs(E_x)^2 - abs(E_y)^2,
    S_2 = 2 "Re"(E_x^"*" E_y), quad S_3 = 2 "Im"(E_x^"*" E_y).
  $
  They measure total intensity, linear polarization along the axes, linear polarization at $45°$, and circular polarization, respectively.
] <def:stokes-parameters>

For completely polarized light $S_0^2 = S_1^2 + S_2^2 + S_3^2$; for partially polarized light the inequality holds, and the degree of polarization is

$
  P = sqrt(S_1^2 + S_2^2 + S_3^2) / S_0.
$

#definition(name: "Mueller Matrix")[
  A polarizing element acts on the Stokes vector by a real $4 times 4$ *Mueller matrix* $M$:
  $
    bold(S)' = M bold(S).
  $
  Unlike the Jones calculus, the Mueller calculus handles partially polarized and incoherent light.
] <def:mueller-matrix>

== Birefringence and Wave Plates // 双折射与波片

#definition(name: "Birefringence")[
  A uniaxial *birefringent* crystal has two refractive indices: the ordinary index $n_o$ for polarization perpendicular to the optic axis, and the extraordinary index $n_e$ for polarization along it.
  The two polarizations propagate with different speeds and accumulate a relative phase
  $
    delta = (2 pi (n_e - n_o) d) / lambda
  $
  over a thickness $d$.
] <def:birefringence>

#definition(name: "Wave Plate")[
  A *wave plate* of thickness $d$ is a birefringent plate that introduces a chosen retardance $delta$.
  - *Quarter-wave plate* ($delta = pi / 2$): converts linear to circular polarization and vice versa.
  - *Half-wave plate* ($delta = pi$): rotates linear polarization; it flips the handedness of circular polarization.
] <def:wave-plate>

#example(name: "Quarter-Wave Plate Conversion")[ // 四分之一波片
  Linearly polarized light at $45°$ to the fast axis enters a $lambda/4$ plate: the two components emerge with a relative phase $pi / 2$ and equal amplitudes, i.e., circularly polarized.
  Rotating the plate by $90°$ reverses the handedness.
] <ex:quarter-wave-plate>

== Production and Analysis of Polarized Light // 起偏与检偏

#law(name: "Malus's Law")[
  A linear polarizer transmits the component of the field along its axis.
  The transmitted intensity is
  $
    I(theta) = I_0 cos^2 theta,
  $
  where $theta$ is the angle between the incident polarization and the polarizer axis.
] <law:malus>

#definition(name: "Brewster's Angle")[
  At the interface between media of indices $n_1$ and $n_2$, the reflected beam is fully $s$-polarized when the refracted and reflected rays are perpendicular, which occurs at
  $
    tan theta_B = n_2 / n_1.
  $
] <def:brewster-angle>

#example(name: "Brewster Reflection")[ // 布儒斯特角
  For an air–glass interface ($n_2 / n_1 = 1.5$), $theta_B = arctan 1.5 approx 56.3°$.
  Unpolarized light incident at this angle reflects with $p$-polarization completely suppressed — the basis of polarizing windows and laser cavity windows.
] <ex:brewster-reflection>

#note[
  Malus's law is the amplitude-splitting analogue of the interference visibility of Chapter 9: both measure how much of a field survives a projection.
  For partially polarized light the transmitted intensity follows from the Mueller calculus, generalizing Malus.
]

== Optical Activity // 旋光 [简要]

#definition(name: "Optical Activity")[
  In a *chiral* medium the two circular polarizations propagate with different speeds, and linearly polarized light has its plane of polarization rotated by
  $
    theta = alpha d,
  $
  where $alpha$ is the specific rotation and $d$ the path length.
] <def:optical-activity>

#note[
  Optical activity is a difference of refractive indices for opposite circular polarizations — the circular analogue of birefringence.
  Its quantum counterpart, the coupling of photon helicity to chiral matter, returns in Part IV alongside the polarization states of single photons.
]

// --- Chapter 13: Propagation in Media (介质中的传播) ---

= Propagation in Media // 介质中的传播

So far the medium entered through a given refractive index $n$.
This final chapter of Part III asks where $n$ comes from: light drives the charges of the medium, and the driven response — dispersive, absorptive, causal, scattering — is the material side of wave optics.
It redeems the promise of Chapter 7 that the wavelength dependence $n(lambda)$ belongs here.

== Dispersion and Absorption // 色散与吸收

#definition(name: "Lorentz Oscillator Model")[
  In the *Lorentz oscillator model*, each electron is a damped harmonic oscillator driven by the electric field:
  $
    dot.double(x) + gamma dot(x) + omega_0^2 x = q/m E_0 e^(- i omega t),
  $
  with damping rate $gamma$ and resonance frequency $omega_0$.
  The induced polarization gives the dielectric function
  $
    epsilon(omega) = 1 + (N q^2) / (epsilon_0 m) dot 1 / (omega_0^2 - omega^2 - i gamma omega),
  $
  where $N$ is the number density of oscillators.
] <def:lorentz-oscillator>

#definition(name: "Complex Refractive Index")[
  The *complex refractive index* is
  $
    tilde(n)(omega) = n + i kappa = sqrt(epsilon(omega)),
  $
  with real part $n$ governing phase velocity and imaginary part $kappa$ (the extinction coefficient) governing absorption.
  A wave attenuates as $e^(- kappa k_0 z)$.
] <def:complex-refractive-index>

#figure(
  image("img/dispersion-curves.svg", width: 100%),
  caption: [Refractive index $n(omega)$ near a single resonance: normal dispersion far from resonance, anomalous dispersion within the absorption band.],
  placement: auto,
  supplement: [Fig.]
) <fig:dispersion-curves>

#note[
  *Normal vs anomalous dispersion.* Far from resonance, $n(omega)$ increases with frequency (normal dispersion, familiar from prism spectra, Section 7.2).
  Inside the absorption band the real part *decreases* with frequency — anomalous dispersion — and absorption is strongest.
  The damping $gamma$ is what makes $epsilon$ complex and couples the two effects.
]

== Kramers-Kronig Relations // Kramers-Kronig 关系

#theorem(name: "Kramers-Kronig Relations")[
  Causality — the response at time $t$ depends only on the field at earlier times — forces the real and imaginary parts of the susceptibility to be linked:
  $
    chi_1(omega) = 2/pi cal(P) integral_0^oo (omega' chi_2(omega')) / (omega'^2 - omega^2) dif omega',
  $
  $
    chi_2(omega) = - 2/pi cal(P) integral_0^oo (omega chi_1(omega')) / (omega'^2 - omega^2) dif omega',
  $
  where $cal(P)$ denotes the Cauchy principal value.
] <thm:kramers-kronig>

#proof[
  *Step 1 — Analyticity.*
  Causality makes the susceptibility $chi(omega)$ analytic in the upper half-plane: the Fourier transform of a retarded response has no poles for $"Im"(omega) > 0$.

  *Step 2 — Contour integration.*
  Integrate $chi(omega') / (omega' - omega)$ over a large semicircle in the upper half-plane, indented around the pole on the real axis.
  The analyticity plus the decay of $chi$ at infinity leaves only the principal-value integral and the residue.

  *Step 3 — Take real and imaginary parts.*
  Separating $chi = chi_1 + i chi_2$ in the resulting identity yields the two dispersion relations.
]

#note[
  The Kramers-Kronig relations are the physics statement of the general principle that real and imaginary parts of a causal linear response cannot be chosen independently: measure absorption at all frequencies and the refractive index is determined, and vice versa.
]

== Rayleigh and Mie Scattering // 瑞利与米氏散射

#law(name: "Rayleigh Scattering")[
  A small particle (size $d << lambda$) illuminated by light of wavelength $lambda$ scatters with cross section
  $
    sigma_R prop (d^6) / (lambda^4),
  $
  i.e., $sigma_R prop omega^4$.
  Short wavelengths are scattered far more strongly than long ones.
] <law:rayleigh-scattering>

#example(name: "Why the Sky Is Blue")[ // 天空为什么是蓝的
  Sunlight passes through the atmosphere; molecules scatter blue light ($lambda approx 450 "nm"$) roughly $(700 / 450)^4 approx 6$ times more strongly than red light ($lambda approx 700 "nm"$).
  Scattered light reaching the eye from all directions is therefore blue; the transmitted sunlight, depleted of blue, appears red at sunset.
] <ex:sky-color>

#definition(name: "Mie Scattering")[
  When the particle size is comparable to the wavelength ($d ~ lambda$), scattering enters the *Mie regime*: the cross section oscillates with size and becomes weakly wavelength-dependent, with pronounced forward scattering.
] <def:mie-scattering>

#figure(
  image("img/rayleigh-scattering.svg", width: 70%),
  caption: [Rayleigh scattering strength versus wavelength: the $lambda^(-4)$ law suppresses long wavelengths relative to short ones.],
  placement: auto,
  supplement: [Fig.]
) <fig:rayleigh-scattering>

#note[
  Rayleigh scattering by air is why the sky is blue; Mie scattering by water droplets and aerosols is why clouds and milk are white — comparable particle sizes scatter all wavelengths equally.
  This closes Part III: from the Helmholtz equation through diffraction, interference, Fourier optics, polarization, to the material response, the scalar wave theory of optics is complete, and the quantum theory of light (Part IV) begins.
]
