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
