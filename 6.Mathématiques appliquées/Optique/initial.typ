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
// - 本笔记负责：振动与波动的介质无关机制、弹性介质中的机械波（应变/应力/弹性模量/泊松比/
//   P-S 波/特征阻抗/反射与半波损失）、几何光学、波动光学（干涉/衍射/偏振/傅里叶光学）、
//   量子光学（场量子化/光子统计/光与物质作用）
// - 弹性波内容已于 2026-10-22 自 Mécanique analytique Ch 4 整体迁入（Ch 2.4 与 Ch 2.6），
//   分析力学不再保留该章（其 Part 0 现为 5 章）
// - 拉格朗日小振动/简正模/耦合振子 → Mécanique analytique Part II（本笔记不重复，仅引用）
// - Maxwell 方程与电磁波推导 → Électrodynamique（本笔记 Ch 4 仅搭桥引用其时谐场结论）
// - Fourier 级数/变换完整理论 → Analyse Harmonique（本笔记仅使用其工具）
// - 希尔伯特空间/算符/相干态形式体系 → Mécanique quantique（Part IV 直接使用）
//
// 与相关笔记的衔接：
// - 本笔记 Part I 承接自 Mécanique analytique 迁入的振动与波动正文，2026-10-22 起再并入其
//   Ch 4 弹性波全部内容（应变/应力/模量/泊松比/P-S 波/阻抗/反射）；分析力学对应章已删除
// - 本笔记 Ch 4 桥接 Électrodynamique 的电磁波部分
// - 本笔记 Part IV 需要 Mécanique quantique 的希尔伯特空间与算符基础

// ==========================================================================
// Part I — Vibrations and Waves (振动与波动)
// ==========================================================================
// 设计思路：自 Mécanique analytique 迁入的波动力学，是全书的数学/物理公分母；
//           Ch 1 振动（含垂直合成/李萨如图形与谐波分析）、Ch 2 波动（含弹性介质波速/阻抗/
//           半波损失/驻波/常见波/多普勒）、Ch 3 色散与傅里叶简正模；Ch 4 桥接章通向 Part II/III。
// 对应教材：A. P. French, Vibrations and Waves
//
// 修订记录（2026-10-22）：Ch 1 由 2 节扩为 3 节（新增 1.3 谐波分析、1.1 增垂直合成与李萨如）；
//   Ch 2 由 5 节扩为 8 节，并入原 Mécanique analytique Ch 4 的弹性波内容（2.4、2.6），
//   并新增机械波几何描述、常见波与多普勒效应。
// 修订记录（2026-10-28）：按内容审查（violet-content-review）通修四个 Part：
//   Part I — 李萨如 p/q 周期数、任意夹角多普勒公式与横向红移、多普勒实例的音程、
//     P/S 波速比较、固定端与半波损失的一致性、时谐相位统一、能量密度标注时均；
//   Part II — 棱镜最小偏向角数值 17.5°→37.2°、Ch 6 符号约定改写、主平面定义（横向≠角放大率）、
//     面镜"折叠约定"补述、稳定性判据补 M=±I 退化情形；
//   Part III — 艾里斑尺寸 5.4mm→5.4µm、可见度—相干度关系的强度因子、牛顿环半径的 (m+1/2)、
//     Kirchhoff 积分的法向约定与"斜度佯谬"措辞、OTF 为光瞳的复自相关（含 ⊛ 与 abs 修正）；
//   Part IV — Rabi 频率 Ω₀=dE₀/ℏ 的幅度约定、Wigner-Weisskopf 中 Γ 与 Lorentz γ 的因子 2、
//     He-Ne 能级标注、压缩算符 (a†)² 写法、挤压增益"真空方差 vs 不确定度乘积"措辞；
//   规范：裸章号全部改为 #link、13 处 proof 补 name、补 5 个组件标签、note 小标签改用 title、
//     绝对值改 abs()（保留量子力学的 Dirac 竖线记号）。

// --- Chapter 1: Oscillations (振动) ---
//   Section 1.1: Simple Harmonic Motion (简谐运动)
//     - 运动方程、相位与相位差
//     - 能量守恒与振幅
//     - 旋转矢量法与复数表示
//     - 同频合成与拍频
//     - 垂直合成与李萨如图形
//     - 单摆与物理摆
//   Section 1.2: Damped and Driven Oscillations (阻尼与受驱振动)
//     - 阻尼振子（欠/临界/过阻尼）
//     - 受驱振子与共振
//     - 功率吸收与线宽（Q 因子）
//   Section 1.3: Harmonic Analysis of Periodic Motion (周期振动的谐波分析)
//     - 基频与谐频、频谱、Gibbs 现象

// --- Chapter 2: Wave Motion (波动) ---
//   Section 2.1: The Wave Equation and d'Alembert's Solution (波动方程与达朗贝尔解)
//   Section 2.2: Mechanical Waves and Their Geometry (机械波与几何描述：波源/介质/波面波线/惠更斯定性)
//   Section 2.3: Harmonic Travelling Waves: The Wave Function (简谐行波与波函数)
//   Section 2.4: Wave Speed in Elastic Media (弹性介质波速：应变/应力/模量/泊松比/P-S 波)
//   Section 2.5: Energy, Energy Density and Intensity (能量、能量密度与能流密度)
//   Section 2.6: Superposition, Interference and Standing Waves (叠加/相干/反射与半波损失/驻波)
//   Section 2.7: Common Waves: Sound, Seismic and Water (常见波)
//   Section 2.8: The Doppler Effect (多普勒效应)

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
// 设计思路：本体理论，体量最大（正文 ~930 行）；以标量衍射理论（Helmholtz 方程 + 格林函数）为统一框架，
//           干涉、衍射、傅里叶光学、介质传播依次展开，末章回到矢量性（偏振）。
//           正文已写入 Ch 8-13（框架先行、Ch 11 五节、8 张核心配图）。
// 对应教材：Born & Wolf Ch 7-10, 13-15；Goodman, Introduction to Fourier Optics

// --- Chapter 8: Scalar Diffraction Theory (标量衍射理论) ---
//   Section 8.1: The Scalar Approximation and Boundary Conditions (标量近似与边界条件)
//   Section 8.2: The Huygens-Fresnel Principle (惠更斯-菲涅耳原理)
//   Section 8.3: Green's Functions for Diffraction (衍射的格林函数，先于积分)
//   Section 8.4: Kirchhoff and Rayleigh-Sommerfeld Integrals (基尔霍夫与瑞利-索末菲积分)

// --- Chapter 9: Interference and Coherence (干涉与相干性) ---
//   Section 9.1: Two-Beam Interference: Young's Experiment (杨氏双缝)
//   Section 9.2: Interference of Thin Films (薄膜干涉)
//   Section 9.3: The Michelson Interferometer (迈克耳孙干涉仪)
//   Section 9.4: Multiple-Beam Interference: Fabry-Perot (多光束干涉与法布里-珀罗)
//   Section 9.5: Temporal and Spatial Coherence (时间/空间相干性)
//   Section 9.6: Visibility and the Degree of Coherence (可见度与相干度)

// --- Chapter 10: Diffraction: Approximations and Applications (衍射：近似与应用) ---
//   Section 10.1: Fresnel Diffraction and Zone Plates (菲涅耳衍射与波带片)
//   Section 10.2: Fraunhofer Diffraction: The Single Slit (单缝夫琅禾费衍射)
//   Section 10.3: Fraunhofer Diffraction: The Circular Aperture (圆孔夫琅禾费衍射)
//   Section 10.4: Diffraction Gratings and Spectroscopy (衍射光栅与光谱学)
//   Section 10.5: Resolution: Rayleigh and Abbe Criteria (瑞利/阿贝分辨极限)

// --- Chapter 11: Fourier Optics (傅里叶光学) ---
//   Section 11.1: The Lens as a Fourier Transformer (透镜作为傅里叶变换器)
//   Section 11.2: Aperture Functions and Pupil Transforms (孔径函数与光瞳变换)
//   Section 11.3: Spatial Filtering (空间滤波)
//   Section 11.4: PSF, OTF and the Coherent Transfer Function (点扩散函数与光学传递函数)
//   Section 11.5: Holography (全息) [简要]

// --- Chapter 12: Propagation in Media (介质中的传播) ---
//   Section 12.1: Dispersion and Absorption (色散与吸收)
//   Section 12.2: Kramers-Kronig Relations (Kramers-Kronig 关系) [可选]
//   Section 12.3: Rayleigh and Mie Scattering (瑞利与米氏散射)

// --- Chapter 13: Polarization (偏振) ---
//   Section 13.1: Polarization States of Light (光的偏振态)
//   Section 13.2: Jones Calculus (琼斯运算)
//   Section 13.3: Stokes Parameters and Mueller Calculus (斯托克斯参量与缪勒矩阵)
//   Section 13.4: Birefringence and Wave Plates (双折射与波片)
//   Section 13.5: Production and Analysis of Polarized Light (起偏与检偏：布儒斯特角)
//   Section 13.6: Optical Activity (旋光) [简要]

// ==========================================================================
// Part IV — Quantum Optics (量子光学)
// ==========================================================================
// 设计思路：光的量子化与光子统计；Ch 14 为桥接章（旧量子论），Ch 15-18 为核心，
//           Ch 19 为应用与前沿导论，标注"深入参见后续"。
//           正文已按规划写入 Ch 14-19（Ch 15 单模完整+多模简述、18.4 精简保留、4 张核心配图）。
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
// 规模：正文约 3350 行，Part I 943 / Part II 556 / Part III 932 / Part IV 656。
//
// Part I（Ch 1-4）：振动与波动力学（自 Mécanique analytique 迁入），含弹性介质中的机械波
//   （应力/应变/模量/P-S 波/阻抗/半波损失）、常见波与多普勒效应（7 张配图）；
//   为波动光学提供波动方程、叠加、干涉、色散、傅里叶简正模等数学基础；Ch 4 引入时谐场与 Helmholtz 方程。
// Part II（Ch 5-7）：几何光学，作为 Part III 的短波长极限 λ→0；正文已写入（含 6 张配图）。
// Part III（Ch 8-13）：波动光学核心，标量衍射理论为统一框架，展开干涉、衍射、傅里叶光学、介质传播，
//   最后由 Ch 13 偏振回到矢量性收束；正文已写入（框架先行 / Ch 11 五节 / 8 张核心配图）。
// Part IV（Ch 14-19）：量子光学，场量子化、相干态与压缩态、光子统计、光与物质相互作用、应用与前沿。
//   正文已写入（单模完整 / 18.4 精简保留 / 4 张核心配图）。
//
// 教材覆盖：A. P. French（振动与波动）、Hecht / Born & Wolf（几何与波动光学）、
//           Goodman（傅里叶光学）、Loudon / Scully & Zubairy（量子光学）知识点均已覆盖。
// 迁移说明：Part I 正文自 Mécanique analytique 迁入，分两批完成：
//           ① 2026-10-15 迁入振动与波动正文，重组为 Ch 1-3；
//           ② 2026-10-22 并入其 Ch 4 全部弹性波内容（应变/应力/模量/泊松比/P-S 波/阻抗/反射），
//              同时 Ch 1 增设 1.3 谐波分析与垂直合成，Ch 2 增设几何描述、常见波与多普勒，
//              分析力学对应章已删除（其 Part 0 由 6 章变为 5 章）。
//           Ch 4（时谐场与亥姆霍兹方程）为本笔记新写桥接章。
//
// 交叉引用约定：章标题带 <ch:...> 标签，跨章衔接写 #link(<ch:...>)[Chapter N]；
//   小节在被引用时于标题末尾加 <sec:...> 标签（放在 // 中文注释之前），节级引用写
//   #link(<sec:...>)[Section N.M]；组件引用写 #link(<def:...|thm:...>)[...]，图引用写 @fig:...。
//   全文不得出现裸章号文本、无链接的文本节号，也不得出现 § 记号。
// ==========================================================================

// 目录

// --------------------------------------------------------------------------
// Part I: Vibrations and Waves (振动与波动)
// --------------------------------------------------------------------------

#part("Vibrations and Waves") // 振动与波动

// --- Chapter 1: Oscillations (振动) ---

= Oscillations <ch:oscillations> // 振动

Oscillatory motion is ubiquitous in physics — from a swinging pendulum to vibrating molecules and electromagnetic waves.
This chapter (migrated from the *Mécanique analytique* notebook) develops simple harmonic motion, damped and driven oscillations, and the harmonic analysis of a general periodic motion; wave propagation follows in #link(<ch:wave-motion>)[Chapter 2].
These ideas are revisited in *Mécanique analytique* (Part II), where Lagrangian methods provide a systematic approach to small oscillations and normal modes.

Part I (Chapters 1–4) collects the medium-independent wave mechanics the whole notebook relies on: oscillations, wave motion, dispersion and eigenfunction expansions, and finally the time-harmonic Helmholtz formulation that opens both geometric and wave optics.

== Simple Harmonic Motion // 简谐运动

=== Equation of Motion // 运动方程

The simplest oscillatory system is a mass $m$ attached to a spring of stiffness $k$.
When displaced from equilibrium, Hooke's law gives $F = - k x$, and Newton's second law yields

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
  The period and frequency are
  $
    T = frac(2 pi, omega_0) = 2 pi sqrt(frac(m, k)), quad f = frac(1, T) = frac(omega_0, 2 pi).
  $
] <def:shm>

The argument $omega_0 t + phi$ is the *phase* of the oscillation, and $phi$ the phase at $t = 0$.
Two oscillators of the same frequency are compared through their *phase difference* $Delta phi$: a constant that decides whether they move together ($Delta phi = 0$), in opposition ($Delta phi = pi$), or in between.

Differentiating the solution gives the velocity and the acceleration:
$
  dot(x) = - omega_0 A sin(omega_0 t + phi), quad dot.double(x) = - omega_0^2 x.
$
The velocity leads the displacement by $pi / 2$ and the acceleration by $pi$.
The proportionality $dot.double(x) prop - x$ is the defining signature of simple harmonic motion: the restoring force grows with the displacement and points against it.

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
] <ex:mass-spring>

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
] <def:phasor>

The rotating vector makes phase relationships geometrically obvious: velocity leads displacement by $pi/2$ (the tangent direction), and acceleration leads displacement by $pi$ (opposite direction).

#note[
  The complex representation turns differentiation into multiplication by $i omega$, and superposition into complex addition.
  This is the foundation of phasor analysis in AC circuits and of Fourier methods in normal mode analysis (Mécanique analytique, Part II).
]

=== Superposition of Two SHMs // 同频简谐运动的合成

Because the equation of motion is linear, the sum of two SHM solutions is also a solution.
This leads to two regimes, according to whether the frequencies agree.

#definition(name: "Superposition of Two SHMs (Same Frequency)")[
  The sum of two SHMs with the same frequency $omega$ but different amplitudes $A_1, A_2$ and phases $phi_1, phi_2$ is another SHM at the same frequency:
  $
    x(t) = A_1 cos(omega t + phi_1) + A_2 cos(omega t + phi_2) = A cos(omega t + phi),
  $
  where $A = sqrt(A_1^2 + A_2^2 + 2 A_1 A_2 cos(Delta phi))$ and $tan phi = frac(A_1 sin phi_1 + A_2 sin phi_2, A_1 cos phi_1 + A_2 cos phi_2)$, with $Delta phi = phi_2 - phi_1$.
] <def:shm-superposition>

The result is read off the phasor diagram: two vectors of lengths $A_1, A_2$ at angle $Delta phi$ add vectorially.
In phase, the amplitudes add; in antiphase, they cancel; at $Delta phi = pi / 2$ the resultant amplitude is $sqrt(A_1^2 + A_2^2)$.

=== Beats // 拍频

For frequencies that are close but not equal, the phasor rotates relative to the other one, and the resultant amplitude slowly waxes and wanes.

#definition(name: "Beats")[
  Two SHMs of equal amplitude $A$ and slightly different frequencies $omega_1, omega_2$:
  $
    x(t) = A cos(omega_1 t) + A cos(omega_2 t) = 2 A cos(frac(Delta omega, 2) t) cos(bar(omega) t),
  $
  with $Delta omega = abs(omega_2 - omega_1)$ and $bar(omega) = (omega_1 + omega_2) / 2$.
  The carrier oscillates at $bar(omega)$ inside the slowly varying factor $2 A cos(Delta omega t / 2)$, whose signed value repeats at the angular frequency $Delta omega / 2$ and whose magnitude gives the *envelope* $2 A abs(cos(Delta omega t / 2))$, repeating twice as fast.
  The loudness peaks twice per envelope period, so the perceived *beat frequency* is
  $
    f_"beat" = abs(f_2 - f_1) = frac(Delta omega, 2 pi).
  $
] <def:beats>

#note[
  Beats are the simplest example of *amplitude modulation*: a fast carrier and a slow envelope.
  In *Mécanique analytique* (Part II) the normal-mode splitting of two coupled oscillators has the same mathematics — energy shuttles between the two masses at the beat frequency.
  When the two frequencies are incommensurable the sum is no longer periodic at all: it is a two-frequency quasiperiodic motion.
]

=== Perpendicular Superposition and Lissajous Figures // 垂直合成与李萨如图形

The two oscillations need not lie along the same line.
When one oscillates along $x$ and the other along $y$, the trajectory in the plane carries the phase information directly.

#definition(name: "Perpendicular Superposition")[
  Two SHMs of equal frequency along perpendicular axes:
  $
    x = A_1 cos(omega t), quad y = A_2 cos(omega t + Delta phi).
  $
  Eliminating $t$ gives the trajectory
  $
    frac(x^2, A_1^2) + frac(y^2, A_2^2) - frac(2 x y, A_1 A_2) cos(Delta phi) = sin^2(Delta phi).
  $
  For $Delta phi = 0$ or $pi$ the path is a straight segment of slope $plus.minus A_2 / A_1$; for $Delta phi = plus.minus pi / 2$ it is an ellipse with its axes along $x$ and $y$ (a circle when $A_1 = A_2$); otherwise the ellipse is tilted.
] <def:perpendicular-shm>

The direction of circulation distinguishes $Delta phi = pi / 2$ from $Delta phi = - pi / 2$: the ellipse is traced clockwise in one case and counter-clockwise in the other.

When the frequencies are commensurable, $omega_x : omega_y = p : q$ with small integers, the trajectory closes after $p$ periods along $x$ and $q$ periods along $y$: a *Lissajous figure*.
The number of tangencies with the horizontal sides of the bounding rectangle is $q$, and with the vertical sides $p$, which is how a frequency ratio is read off an oscilloscope.
For incommensurable frequencies the curve never closes and eventually fills the rectangle.
Both cases are drawn in @fig:lissajous.

#figure(
  image("img/lissajous.svg", width: 85%),
  caption: [Left: perpendicular composition at equal frequency, for $Delta phi = 0, pi / 4, pi / 2$. Right: Lissajous figures for the frequency ratios $1 : 2$ and $2 : 3$.],
  placement: auto,
  supplement: [Fig.]
) <fig:lissajous>

=== Pendulums // 单摆与物理摆

The pendulum is the canonical realisation of SHM and the standard laboratory test of the small-angle approximation.

#definition(name: "Simple and Physical Pendula")[
  A *simple pendulum* (mass $m$ on a massless string of length $L$) obeys
  $
    dot.double(theta) + frac(g, L) sin theta = 0,
  $
  which for small angles becomes SHM with $omega_0 = sqrt(g / L)$.
  A *physical pendulum* (rigid body of mass $M$, moment of inertia $I$ about the pivot, centre of mass at distance $d$) obeys
  $
    omega_0 = sqrt(frac(M g d, I)).
  $
] <def:pendulum>

The simple pendulum is the special case $I = M L^2$, $d = L$, recovering $omega_0 = sqrt(g / L)$.
The SHM framework thus unifies every system with a linear restoring torque.

#note[
  The small-angle approximation $sin theta approx theta$ is the first term of the Taylor expansion.
  For larger amplitudes the period grows: $T = 2 pi sqrt(L/g) (1 + theta_0^2 / 16 + ...)$, obtained from the energy integral (Mécanique analytique, Ch 3).
]

== Damped and Driven Oscillations <sec:damped-driven> // 阻尼与受驱振动

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

The characteristic equation $r^2 + 2 beta r + omega_0^2 = 0$ has roots $r = - beta plus.minus sqrt(beta^2 - omega_0^2)$.

#definition(name: "Damping Regimes")[
  - *Underdamped* ($beta < omega_0$): $x(t) = e^(-beta t) [A cos(omega_1 t) + B sin(omega_1 t)]$, where $omega_1 = sqrt(omega_0^2 - beta^2)$.
    The amplitude decays exponentially with time constant $1 / beta$.
  - *Critically damped* ($beta = omega_0$): $x(t) = (A + B t) e^(-omega_0 t)$.
    The system returns to equilibrium fastest without oscillating.
  - *Overdamped* ($beta > omega_0$): $x(t) = A e^(-r_1 t) + B e^(-r_2 t)$, with $r_1, r_2 > 0$.
    The system returns slowly without oscillating.
] <def:damping-regimes>

The three damping regimes are drawn in @fig:damped-oscillation.

#figure(
  image("img/damped-oscillation.svg", width: 100%),
  caption: [Damped oscillation: underdamped (blue), critically damped (green), and overdamped (orange).],
  placement: auto,
  supplement: [Fig.]
) <fig:damped-oscillation>

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

#property(name: "Resonance")[
  The amplitude $A(omega)$ reaches a maximum at the *resonance frequency*
  $
    omega_"res" = sqrt(omega_0^2 - 2 beta^2).
  $
  For weak damping ($beta << omega_0$), $omega_"res" approx omega_0$ and the peak amplitude is $A_"max" approx F_0 / (2 m beta omega_0)$.
  The width of the resonance curve (full width at half maximum) is $Delta omega approx 2 beta$, giving a quality factor $Q = omega_0 / (2 beta)$.
] <prop:resonance>

Amplitude and phase near resonance are plotted in @fig:resonance-curves.

#figure(
  image("img/resonance-curves.svg", width: 100%),
  caption: [Resonance curves for different damping ratios $beta / omega_0$. Sharp peaks correspond to weak damping; broad curves correspond to strong damping.],
  placement: auto,
  supplement: [Fig.]
) <fig:resonance-curves>

#note[
  Resonance explains why a small force at the right frequency can produce large oscillations: pushing a child on a swing, tuning a radio receiver, or the collapse of a bridge under a periodic load.
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
] <prop:power-absorption>

#note[
  The $Q$ factor connects driven oscillations to free decay: $Q = pi$ times the number of oscillations for the amplitude to decay to $1/e$.
  This same concept reappears in quantum mechanics (resonance width and particle lifetime) and in electrical engineering (bandwidth of RLC circuits).
]

== Harmonic Analysis of Periodic Motion // 周期振动的谐波分析

Most real oscillations are not sinusoidal: a bowed string, a struck membrane, or the current drawn by a rectifier are periodic but far from harmonic.
Fourier's theorem says that this is a complication of vocabulary rather than of physics — every periodic motion is a superposition of SHMs.

#definition(name: "Harmonic Analysis")[
  A periodic motion of period $T$ is a superposition of *harmonics*:
  $
    x(t) = frac(a_0, 2) + sum_(n=1)^oo (a_n cos(n omega t) + b_n sin(n omega t)), quad omega = frac(2 pi, T),
  $
  with $a_n, b_n$ given by the Fourier integrals collected in #link(<ch:dispersion-fourier>)[Chapter 3].
  The amplitudes $sqrt(a_n^2 + b_n^2)$ plotted against the harmonic order $n$ form the *spectrum* of the motion.
] <def:harmonic-analysis>

The spectrum is the fingerprint of the source: a pure tone is a single line, a plucked string has a decaying comb of harmonics, and an ideal percussion has a broad continuum.
Which harmonics survive is decided by symmetry — an odd function has only sines, a function with half-period antisymmetry has only odd harmonics.
Pointwise convergence is guaranteed by the Dirichlet conditions (piecewise smoothness of the motion); at a jump the series settles on the midpoint of the discontinuity, and this is what leaves the overshoot commented on below.

#example(name: "Spectrum of a Square Wave")[ // 方波频谱
  A square wave of amplitude $A$ and period $T$ has only odd harmonics, with amplitudes $A_n = 4 A / (n pi)$ for odd $n$ and zero otherwise.
  The series converges slowly: truncating it at $n = N$ still leaves an overshoot of about 9% of the jump at each edge, independent of $N$ (the Gibbs phenomenon).
] <ex:square-wave-spectrum>

#note[
  This section states the *idea* of harmonic analysis; the mathematical machinery — orthogonality, completeness, and the eigenfunction expansion of a boundary-value problem — is developed in #link(<ch:dispersion-fourier>)[Chapter 3].
]

// --- Chapter 2: Wave Motion (波动) ---

= Wave Motion <ch:wave-motion> // 波动

While oscillators describe the motion of individual particles, *waves* describe the propagation of disturbances through a continuous medium.
The key conceptual shift is from a function of time alone $x(t)$ to a function of both space and time $u(x,t)$.

This chapter builds that description in two layers: first the medium-independent kinematics and energetics of a travelling wave, then the concrete mechanics of waves in elastic media — their speed, their reflection, and the interference and standing-wave patterns they produce.

== The Wave Equation and d'Alembert's Solution // 波动方程与达朗贝尔解

=== The Wave Equation // 波动方程

#definition(name: "One-Dimensional Wave Equation")[
  The displacement $u(x, t)$ of a wave travelling along the $x$-axis satisfies
  $
    frac(partial^2 u, partial t^2) = v^2 frac(partial^2 u, partial x^2).
  $
  The constant $v$ is the *wave speed*, fixed by the medium and not by the source.
] <def:wave-eq-1d>

The equation is second order in both space and time and linear; the speed formulas for particular media are collected in #link(<sec:elastic-wave-speed>)[Section 2.4].

=== d'Alembert's Solution // 达朗贝尔解

The wave equation admits a general solution in terms of travelling waves:
$
  u(x, t) = f(x - v t) + g(x + v t),
$
where $f$ and $g$ are arbitrary twice-differentiable functions.
The function $f(x - v t)$ represents a wave travelling to the right at speed $v$ without changing shape; $g(x + v t)$ travels to the left.
This is *d'Alembert's solution*, and it reveals that the wave equation is fundamentally a statement that the waveform propagates without distortion in a non-dispersive medium.

== Mechanical Waves and Their Geometry // 机械波及其几何描述

=== Formation: Source and Medium // 波源与介质

A *mechanical wave* is a disturbance propagating through a material medium by virtue of the elastic coupling between neighbouring particles.
Two ingredients are therefore indispensable: a *source* that supplies the disturbance and a *medium* that transmits it.

The particles of the medium do not travel with the wave.
Each of them oscillates about its equilibrium position, while the disturbance — and with it the energy — moves forward.
This is the essential difference between a wave and a stream: what propagates is a *state of motion*, not matter.

=== Transverse and Longitudinal Waves // 横波与纵波

Waves are classified by the direction of particle displacement relative to the propagation direction.

#definition(name: "Transverse and Longitudinal Waves")[
  - *Transverse wave*: particle displacement is *perpendicular* to the direction of wave propagation (e.g., waves on a string, electromagnetic waves).
    The restoring mechanism is *shear stress*.
  - *Longitudinal wave*: particle displacement is *parallel* to the direction of wave propagation (e.g., sound waves in air, compression waves in a spring).
    The restoring mechanism is *bulk (compression) stress*.
  - A *surface wave* combines both: the particles trace ellipses near the surface (water waves, seismic surface waves), and the amplitude decays with depth.
] <def:transverse-longitudinal>

Solids support both types at once, and the two propagate at different speeds; this is the content of #link(<sec:elastic-wave-speed>)[Section 2.4], and the reason seismic stations record two distinct arrivals.

=== Wavefronts, Rays and Wave Parameters // 波面、波线与波的参量

A wave in three dimensions is described geometrically by two families of surfaces.

#definition(name: "Wavefronts and Rays")[
  A *wavefront* is a surface on which the phase of the wave is constant at a given instant — a surface of constant phase.
  A *ray* is a line drawn perpendicular to the wavefronts, in the direction of energy propagation.
  A wave is *plane* if its wavefronts are parallel planes, *spherical* if they are concentric spheres, and *cylindrical* if they are coaxial cylinders.
] <def:wave-geometry>

Four parameters describe a harmonic wave completely:
- the *wavelength* $lambda$, the distance between two successive wavefronts of the same phase;
- the *period* $T$, the time for one particle to complete an oscillation;
- the *frequency* $f = 1 / T$, fixed by the source;
- the *speed* $v$, fixed by the medium.

They are linked by
$
  v = frac(lambda, T) = lambda f,
$
so that a wave entering a new medium keeps its frequency and changes its wavelength in proportion to the speed.

From the same picture comes *Huygens' construction*: every point of a wavefront acts as a source of secondary spherical wavelets, and the wavefront at a later time is their envelope.
The construction explains qualitatively why waves bend around obstacles (diffraction) and why they obey the reflection and refraction laws.
Its quantitative form — with amplitudes, obliquity factors and boundary conditions — is the Huygens–Fresnel principle of #link(<ch:scalar-diffraction>)[Chapter 8]; the reflection and refraction laws are derived from Fermat's principle in #link(<ch:ray-optics>)[Chapter 5]; and the diffraction patterns themselves are computed in #link(<ch:diffraction>)[Chapter 10].
The four parameters, together with the two readings of the wave function, are collected in @fig:wave-parameters.

#figure(
  image("img/wave-parameters.svg", width: 95%),
  caption: [Left: the same harmonic wave read as a waveform $u(x)$ at fixed $t$ (top) and as the vibration $u(t)$ of a single particle (bottom). Right: wavefronts (blue) and rays (green) of a plane wave.],
  placement: auto,
  supplement: [Fig.]
) <fig:wave-parameters>

== Harmonic Travelling Waves: The Wave Function // 简谐行波与波函数

=== The Wave Function // 波函数

The simplest and most important special case of d'Alembert's solution is the *harmonic travelling wave*.

#definition(name: "Harmonic Travelling Wave")[
  $
    u(x, t) = A cos(k x - omega t + phi),
  $
  where $k = 2 pi / lambda$ is the wavenumber, $lambda$ the wavelength, and $omega = v k$ the angular frequency.
] <def:harmonic-wave>

The wave function has a double reading, and both are needed.
At fixed $t$ it is a *profile*: the shape of the disturbance along the medium (the waveform, or snapshot).
At fixed $x$ it is a *vibration*: the history of one particle, which is SHM with amplitude $A$ and period $T$.
The two graphs use the same function but answer different questions, and confusing them is the most common error in reading wave diagrams.

A travelling wave has three defining features:

#property(name: "Three Characteristics of Travelling Waves")[
  1. *Morphology*: The entire waveform translates rigidly at speed $v$.
     A snapshot at time $t+Delta t$ is identical to the snapshot at $t$ shifted by $v Delta t$.
  2. *Phase*: The pattern travels, so every particle repeats what the particle at its left has just done, a time $Delta x / v$ later (for $+x$ propagation).
     In the phase $k x - omega t$ this delay reads as a phase difference $Delta phi = k Delta x = 2 pi Delta x / lambda$ between two points separated by $Delta x$.
  3. *Energy*: Travelling waves carry energy unidirectionally — there is a net energy flux from source to receiver, unlike standing waves which store energy locally.
] <prop:travelling-wave-features>

The particle velocity $partial u / partial t$ is not the wave speed $v$: the first is a local oscillation of the medium, the second is the speed of the pattern.
For a harmonic wave the particle velocity has amplitude $omega A$, which may be larger or smaller than $v$ — nothing forbids it.

=== Plane, Spherical and Cylindrical Waves // 平面波、球面波与柱面波

Depending on the geometry of the source, the solutions of the wave equation take different forms.

#definition(name: "Plane, Spherical, and Cylindrical Waves")[
  - *Plane wave*: wavefronts are infinite planes. $u = A cos(bold(k) dot bold(r) - omega t + phi)$.
    Energy does not spread — amplitude is constant.
  - *Spherical wave* (point source): wavefronts are expanding spheres. $u(r, t) = frac(A, r) cos(k r - omega t + phi)$, far from the source.
    Amplitude decays as $1/r$ to conserve energy (intensity $prop 1/r^2$).
  - *Cylindrical wave* (line source): wavefronts are coaxial cylinders. $u(r, t) prop frac(1, sqrt(r)) cos(k r - omega t + phi)$.
    Amplitude decays as $1/sqrt(r)$.
] <def:wave-geometries>

== Wave Speed in Elastic Media <sec:elastic-wave-speed> // 弹性介质中的波速

=== Strain, Stress and Elastic Moduli // 应变、应力与弹性模量

To understand the restoring forces in a solid, we introduce the concepts of strain (deformation) and stress (internal force per area).

#definition(name: "Three Types of Strain")[
  - *Linear strain* (extension or compression): $epsilon = Delta L / L$, the fractional change in length.
  - *Shear strain*: $gamma = Delta x / h = tan theta approx theta$, the angular distortion.
  - *Bulk strain*: $Delta V / V$, the fractional change in volume.
] <def:strain-types>

Each type of strain is related to a corresponding stress through an elastic modulus:

#property(name: "Elastic Moduli")[
  $
    text("Tensile stress"): sigma = E epsilon, quad
    text("Shear stress"): tau = G gamma, quad
    text("Pressure"): p = -K frac(Delta V, V).
  $
  Here $E$ is Young's modulus, $G$ the shear modulus, and $K$ the bulk modulus.
  Each modulus measures the stiffness of the medium against one particular kind of deformation.
] <prop:elastic-moduli>

=== Poisson's Ratio // 泊松比

When a material is stretched in one direction, it contracts in the perpendicular directions. This coupling is quantified by *Poisson's ratio*:

#definition(name: "Poisson's Ratio")[
  $
    nu = - frac(text("lateral strain"), text("axial strain")) = - frac(epsilon_"lat", epsilon_"ax").
  $
  For most materials, $0 < nu < 0.5$. Rubber has $nu approx 0.5$ (incompressible), while cork has $nu approx 0$.

  The three elastic moduli are related by $E = 2 G (1 + nu) = 3 K (1 - 2 nu)$.
] <def:poisson-ratio>

#note[
  Poisson's ratio explains why a stretched rubber band becomes thinner, and why a cork (used in wine bottles) can be pushed in without expanding sideways — $nu approx 0$.
  The relation between moduli also shows that only two of $(E, G, K, nu)$ are independent.
]

=== Wave Speeds // 各类介质中的波速

The wave equation needs one coefficient, and that coefficient is fixed by the medium:

#definition(name: "Wave Speeds in Elastic Media")[
  - String or rope of tension $T$ and linear density $mu$, transverse: $v = sqrt(T / mu)$.
  - Thin rod, longitudinal: $v = sqrt(E / rho)$.
  - Fluid or gas, sound: $v = sqrt(K / rho)$; for an ideal gas $K = gamma p$, so $v = sqrt(gamma p / rho) = sqrt(gamma R T / M)$.
  - Solid, shear (S) wave: $v_"S" = sqrt(G / rho)$.
  - Solid, longitudinal (P) wave: $v_"P" = sqrt((K + 4 G / 3) / rho)$.
] <def:wave-speed-media>

Every entry has the same structure: an elastic modulus (restoring force) divided by a density (inertia).
Since $v_"P"^2 - v_"S"^2 = (K + G / 3) / rho > 0$ for any solid, the compressional wave always arrives first.

#example(name: "Sound Speed in Air")[ // 空气声速
  For air, $gamma = 1.4$, $M = 29 times 10^(-3) "kg/mol"$ and $R = 8.31 "J/(mol K)"$.
  At $T = 293 "K"$ this gives
  $
    v = sqrt(frac(1.4 times 8.31 times 293, 29 times 10^(-3))) approx 343 "m/s",
  $
  the familiar speed of sound at room temperature.
] <ex:sound-speed>

=== P-waves and S-waves // P 波与 S 波

In a solid, any deformation can be decomposed into a *dilatational* (volume-changing) part and a *distortional* (volume-preserving) part — this is the *Helmholtz decomposition* of the displacement field $bold(u)$:
$
  bold(u) = nabla Phi + nabla times bold(psi), quad nabla dot bold(psi) = 0,
$

#property(name: "P-waves and S-waves")[
  - The *irrotational* part $nabla Phi$ ($Phi$ is the scalar displacement potential, not the phase) corresponds to *P-waves* (primary / pressure waves): longitudinal, curl-free ($nabla times bold(u) = 0$). These are the fastest seismic waves.
  - The *solenoidal* part $nabla times bold(psi)$ corresponds to *S-waves* (secondary / shear waves): transverse, divergence-free ($nabla dot bold(u) = 0$). These cannot propagate through fluids (no shear resistance).
  - The Helmholtz decomposition shows that P-waves and S-waves propagate *independently* in a homogeneous isotropic elastic medium — they do not mix or convert into each other except at boundaries.
] <prop:p-s-waves>

#example(name: "S–P Time and Epicentral Distance")[ // 地震 P、S 波到时差
  A station records the P-wave at $v_"P" = 6.0 "km/s"$ and the S-wave at $v_"S" = 3.5 "km/s"$, with a delay $Delta t = 12 "s"$ between the arrivals.
  The distance is $d$ with $d / 3.5 - d / 6.0 = 12$, hence $d = 12 / (1/3.5 - 1/6.0) approx 100 "km"$.
  The S–P time is the standard first estimate of the distance to an earthquake.
] <ex:seismic-arrival>

== Energy, Energy Density and Intensity // 能量、能量密度与能流密度

A travelling wave carries both kinetic and potential energy.
For a wave on a string:

$
  text("Kinetic energy density"): cal(K) = frac(1,2) mu (frac(partial u, partial t))^2,
  quad
  text("Potential energy density"): cal(V) = frac(1,2) T (frac(partial u, partial x))^2.
$

For a harmonic travelling wave $u = A cos(k x - omega t)$ the two densities are equal at *every instant*,
$
  cal(K) = cal(V) = frac(1,2) mu omega^2 A^2 sin^2 (k x - omega t),
$
so that after averaging over one period,
$
  overline(cal(K)) = overline(cal(V)) = frac(1,4) mu omega^2 A^2,
  quad
  text("mean total energy density"): overline(cal(E)) = frac(1,2) mu omega^2 A^2.
$

Kinetic and potential energy are equal at every instant for a travelling wave — unlike an oscillator, where they exchange.
The energy moves with the wave: the *energy flux density* is the energy crossing unit area per unit time, and for a harmonic wave its period average is the mean energy density times the speed, $overline(cal(E)) v$.

#definition(name: "Wave Intensity")[
  The *intensity* (average power per unit area) of a harmonic wave is
  $
    I = frac(1,2) rho v omega^2 A^2 = frac(1,2) Z omega^2 A^2.
  $
  For a point source emitting power $P$, the intensity at distance $r$ is $I = P / (4 pi r^2)$, consistent with the $1/r$ amplitude decay of spherical waves.
] <def:wave-intensity>

#note[
  The energy flux of a mechanical wave is the analogue of the Poynting vector in electromagnetism.
  The same structure — energy density, energy flux, and conservation law — appears in the electromagnetic field (Électrodynamique, Electromagnetic Waves).
]

== Superposition, Interference and Standing Waves <sec:superposition-standing> // 叠加、干涉与驻波

=== The Superposition Principle // 叠加原理

#property(name: "Superposition for Waves")[
  The wave equation is *linear*: if $u_1$ and $u_2$ are solutions, then $u_1 + u_2$ is also a solution.
  This allows complex wave patterns to be built from simple harmonic components.
] <prop:wave-superposition>

=== Coherence and Interference // 相干条件与干涉

Superposition is always true; a *stable* interference pattern is not.
It requires the two waves to keep a definite phase relation over the time of observation and across the region of interest.

#definition(name: "Coherence Conditions")[
  Two waves produce a stable interference pattern only if they are *coherent*:
  - the same frequency;
  - a phase difference that is constant in time;
  - the same (or nearly the same) direction of oscillation.
  Independent sources fail the second condition, because their phases fluctuate randomly.
] <def:coherence-conditions>

For two coherent waves of amplitudes $A_1, A_2$ meeting at a point with phase difference $Delta phi$, the intensity is
$
  I = I_1 + I_2 + 2 sqrt(I_1 I_2) cos(Delta phi),
$
maximal for $Delta phi = 2 m pi$ (*constructive*) and minimal for $Delta phi = (2 m + 1) pi$ (*destructive*).
With $I_1 = I_2$ the pattern runs from $4 I_1$ to $0$: fringes of full contrast.
The optical case is developed in #link(<ch:interference>)[Chapter 9], where $Delta phi$ is produced by an optical path difference.

=== Reflection, Impedance and Half-Wave Loss // 反射、阻抗与半波损失

When a wave encounters a boundary between two media, part of the energy is reflected and part is transmitted. The determining factor is the *characteristic impedance* of each medium.

#definition(name: "Characteristic Impedance")[
  For a wave on a string: $Z = mu v = sqrt(T mu)$ (ratio of transverse force to transverse velocity).
  For a sound wave: $Z = rho v$ (ratio of acoustic pressure to particle velocity).
] <def:characteristic-impedance>

#theorem(name: "Reflection and Transmission at a Boundary")[
  At a boundary between two media with impedances $Z_1$ and $Z_2$:
  $
    R = frac(Z_1 - Z_2, Z_1 + Z_2) quad (text("amplitude reflection coefficient")),
    T = frac(2 Z_1, Z_1 + Z_2) quad (text("amplitude transmission coefficient")).
  $
  Special cases:
  - Fixed end ($Z_2 -> infinity$): $R = -1$ (reflected wave inverted, total reflection).
  - Free end ($Z_2 = 0$): $R = +1$ (reflected wave upright, total reflection).
  - Impedance matching ($Z_1 = Z_2$): $R = 0$, $T = 1$ (no reflection, perfect transmission).

  Both coefficients compare *displacement* amplitudes: if the acoustic *pressure* is taken instead, the reflection coefficient reverses its sign, $R_p = (Z_2 - Z_1) / (Z_1 + Z_2)$.
  The $T$ above is the transmitted fraction, unrelated to the string tension and to the period.
] <thm:reflection-transmission>

#proof(name: "Reflection and Transmission at a Boundary")[
  *Step 1 — Continuity of displacement.*
  Write the incident, reflected and transmitted waves at the boundary $x = 0$ as $e^(i(k_1 x - omega t))$, $R e^(i(-k_1 x - omega t))$ and $T e^(i(k_2 x - omega t))$.
  Continuity of the displacement requires $1 + R = T$.

  *Step 2 — Continuity of the transverse force.*
  On each side the transverse force is the tension multiplied by the slope, $tau_k partial u / partial x$, where $tau_k$ is the string tension of #link(<sec:elastic-wave-speed>)[Section 2.4] (not the transmission coefficient $T$ of this theorem).
  Demanding equality at $x = 0$ gives $i k_1 tau_1 (1 - R) = i k_2 tau_2 T$.
  Because $Z_k = mu_k v_k$, $tau_k = mu_k v_k^2$ and $v_k = omega / k_k$, we have $tau_k k_k = Z_k omega$, so the condition collapses to $Z_1 (1 - R) = Z_2 T$ — which is to say that each travelling component transmits a force $Z partial u / partial t$, up to a sign set by its direction of travel.

  *Step 3 — Solve.*
  Combining the two conditions yields $R = (Z_1 - Z_2)/(Z_1 + Z_2)$ and $T = 2 Z_1/(Z_1 + Z_2)$.
]

The two limiting cases have a geometrical face.
At a fixed end the reflected pulse returns inverted, so that the sum at the boundary is always zero; at a free end it returns upright, so that the boundary is an antinode.

#definition(name: "Half-Wave Loss")[
  When a wave reflects from a medium of *higher* impedance, the reflection coefficient is negative: the reflected wave is inverted, which is equivalent to a phase jump of $pi$, that is, to an extra optical path of $lambda / 2$.
  This inversion is called *half-wave loss*.
  Reflection from a medium of *lower* impedance ($R > 0$) produces no inversion.
] <def:half-wave-loss>

The half-wave loss is what decides whether a reflected wave adds to or subtracts from the incident one, and it is the reason a thin film can be dark at normal incidence even when its optical thickness is small (#link(<sec:thin-film-interference>)[Section 9.2]).

The resulting standing patterns are compared in @fig:half-wave-loss: the wall is a node, the free end an antinode.

#figure(
  image("img/half-wave-loss.svg", width: 88%),
  caption: [Standing waves at a fixed end (node, $R = -1$, half-wave loss) and at a free end (antinode, $R = +1$), shown at three instants. Nodes are solid dots; the boundary condition is marked in red.],
  placement: auto,
  supplement: [Fig.]
) <fig:half-wave-loss>

=== Standing Waves // 驻波

When two identical waves travel in opposite directions, they interfere to form a *standing wave*:

#definition(name: "Standing Wave")[
  The superposition of two equal-amplitude harmonic waves travelling in opposite directions is
  $
    u(x, t) = 2 A cos(k x) cos(omega t),
  $
  a pattern that oscillates in place.
  The *nodes* are the points where $cos(k x) = 0$ and the displacement is always zero; the *antinodes* are the points where $abs(cos(k x)) = 1$ and the amplitude is maximal.
  Neighbouring nodes are separated by $lambda / 2$, and so are neighbouring antinodes; the standing wave carries no net energy flux.
] <def:standing-wave>

A standing wave is thus a pair of travelling waves trapped between two boundaries, and its allowed frequencies are fixed by the boundary conditions.

#example(name: "Standing Waves on a String Fixed at Both Ends")[ // 两端固定弦的驻波
  For a string of length $L$ fixed at $x = 0$ and $x = L$, the boundary conditions $u(0, t) = u(L, t) = 0$ require $k L = n pi$, $n = 1, 2, 3, ...$.

  The *normal modes* are:
  $
    u_(n)(x, t) = A_n sin(frac(n pi x, L)) cos(omega_n t), quad omega_n = n omega_1, quad omega_1 = frac(pi v, L).
  $

  The fundamental frequency is $f_1 = omega_1 / (2 pi) = v / (2 L)$, and the higher harmonics are integer multiples: $f_n = n f_1$.
] <ex:string-standing-waves>

The first normal modes of the string are drawn in @fig:string-normal-modes.

#figure(
  image("img/string-normal-modes.svg", width: 100%),
  caption: [Normal modes of a string fixed at both ends: $n = 1$ (fundamental), $n = 2$ (second harmonic), $n = 3$ (third harmonic).],
  placement: auto,
  supplement: [Fig.]
) <fig:string-normal-modes>

Each fixed end is a node, and this is exactly the $Z_2 -> infinity$ limit of the impedance argument above: reading the support as a prescribed node and reading it as a $R = -1$ reflection (half-wave loss) give the same answer.
For a string with one free end the antinode sits at the free end, and the allowed lengths become $L = (2 n + 1) lambda / 4$ with $n = 0, 1, 2, dots.c$.

== Common Waves: Sound, Seismic and Water // 常见波

The same machinery describes the waves met in practice, with one twist each.

*Sound.* A longitudinal compression wave in a fluid, governed by $v = sqrt(K / rho)$ and, for a gas, $v = sqrt(gamma R T / M)$.
The audible range is a narrow band of frequencies, but the physics is that of #link(<sec:elastic-wave-speed>)[Section 2.4]; the intensity level is quoted on a logarithmic scale, $L = 10 log_(10)(I / I_0)$ in decibels, referenced to the threshold of hearing $I_0 = 10^(-12) "W/m"^2$.

*Seismic waves.* The Earth supports both P- and S-waves, plus surface waves that travel more slowly and carry most of the destructive energy.
The S–P delay locates the epicentre, and the absence of S-waves on the far side of the Earth is the classical evidence for a liquid core.

*Water waves.* Gravity and surface tension supply the restoring force, so the dispersion relation is not linear: deep-water waves have $omega = sqrt(g k)$ and hence $v_p = sqrt(g lambda / 2 pi)$, while shallow-water waves have $v = sqrt(g h)$ and are non-dispersive.
This is the example that opens the discussion of dispersion in #link(<ch:dispersion-fourier>)[Chapter 3].

== The Doppler Effect // 多普勒效应

=== Mechanical Doppler // 机械波多普勒

A moving source or a moving observer changes the rate at which wavefronts are met, hence the observed frequency.

#definition(name: "Doppler Effect")[
  Let the wave speed in the medium be $u$, the source speed $v_s$ and the observer speed $v_o$, both measured along the line joining them.
  Then
  $
    f' = f frac(u + v_o, u - v_s) quad text("(observer and source approaching)"),
  $
  $
    f' = f frac(u - v_o, u + v_s) quad text("(observer and source receding)"),
  $
  where the signs are attached to the components of the motion along the line of sight.
] <def:doppler-effect>

The two shifts have different origins: a moving observer counts the same wavefronts faster, while a moving source compresses the wavefronts ahead of it and stretches them behind.
Only the latter changes the wavelength in the medium.

#example(name: "Passing Train")[ // 列车鸣笛
  A horn emits $f = 500 "Hz"$; the train moves at $v_s = 30 "m/s"$ and the air is still, with $u = 340 "m/s"$.
  Approaching: $f' = 500 times 340 / (340 - 30) approx 548 "Hz"$.
  Receding: $f' = 500 times 340 / (340 + 30) approx 459 "Hz"$.
  The two differ by a factor $548 / 459 approx 1.19$, about three semitones (a minor third), and this sudden drop as the train passes is the familiar acoustic signature of the effect.
] <ex:doppler-train>

=== Electromagnetic Doppler // 电磁波多普勒

Light needs no medium, so there is no preferred frame and the formula must be relativistic.
For a source receding at speed $v$ along the line of sight, writing $beta = v / c$ (here $beta$ is the speed ratio, not the damping coefficient of #link(<sec:damped-driven>)[Section 1.2]) and $gamma = 1 / sqrt(1 - beta^2)$:
$
  f' = f sqrt(frac(1 - beta, 1 + beta)),
$
and the reciprocal expression holds for approach.
For an arbitrary angle $theta$ measured *in the observer's frame* between the velocity and the line of sight, the same result reads
$
  f' = frac(f, gamma (1 - beta cos theta)),
$
which reduces to the reciprocal of the expression above at $theta = 0$, back to it at $theta = pi$, and to the *transverse Doppler redshift* $f' = f / gamma$ at $theta = pi / 2$ — a genuine redshift, not merely a cancellation of the line-of-sight term.

The effect is the basis of radar speed measurement, of the redshift of distant galaxies, and of Doppler broadening of spectral lines — the thermal motion of the emitting atoms spreads each line by $Delta lambda / lambda ~ v_"th" / c$ (#link(<sec:dispersion-absorption>)[Section 12.1]).

=== Shock Waves // 冲击波

When the source moves faster than the waves it emits ($v_s > u$), the wavefronts cannot outrun it and pile up on a cone.

The envelope of the wavefronts is a *Mach cone* of half-angle $theta$ given by
$
  sin theta = frac(u, v_s) = frac(1, "Ma"),
$
where $"Ma" = v_s / u$ is the Mach number.
On crossing the cone the pressure jumps discontinuously — the sonic boom; the same geometry gives the bow wave of a ship and the Cherenkov cone of a charged particle moving faster than light in a medium.
The two regimes are compared in @fig:doppler.

#figure(
  image("img/doppler.svg", width: 95%),
  caption: [Left: wavefronts of a subsonic source, compressed ahead and stretched behind. Right: wavefronts of a supersonic source and their envelope, the Mach cone of half-angle $theta$ with $sin theta = u / v_s$.],
  placement: auto,
  supplement: [Fig.]
) <fig:doppler>

// --- Chapter 3: Dispersion, Fourier Methods and Normal Modes (色散、傅里叶方法与简正模) ---

= Dispersion, Fourier Methods and Normal Modes <ch:dispersion-fourier> // 色散、傅里叶方法与简正模

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
] <def:dispersion-relation>

#example(name: "Deep Water Waves")[ // 深水波
  For deep water waves, the dispersion relation is $omega = sqrt(g k)$.
  The phase velocity $v_p = omega / k = sqrt(g / k)$ increases with wavelength (longer waves travel faster).
  The group velocity $v_g = dif omega / dif k = frac(1,2) sqrt(g / k) = v_p / 2$ — energy travels at half the speed of the crests.
] <ex:deep-water-waves>

A wave packet is a superposition of modes, and the two velocities answer different questions: $v_g$ moves the envelope, $v_p$ moves the carrier inside it.

For a narrow spectrum around $k_0$, the expansion of the dispersion relation,
$
  omega(k) = omega_0 + v_g (k - k_0) + frac(1,2) alpha (k - k_0)^2 + dots.c, quad alpha = (dif^2 omega) / (dif k^2),
$
with $v_g$ and $alpha$ evaluated at $k_0$, shows that the packet keeps its shape to first order, translating at $v_g$; the second-order term $alpha$, the *group-velocity dispersion*, is what deforms it.

#example(name: "Spreading of a Wave Packet")[ // 波包展宽
  A packet of initial spatial width $sigma_0$ broadens on the time scale $tau ~ sigma_0^2 / abs(alpha)$, with $alpha$ evaluated at the carrier wavenumber: a sharply localized packet disperses quickly, a broad one slowly.
  In optics this is the stretching of a short laser pulse in glass, the effect that limits long-haul fibre links (#link(<sec:dispersion-absorption>)[Section 12.1]).
] <ex:wave-packet-spreading>

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
] <def:fourier-series-string>

The same projection gives the coefficients of the general sine–cosine series stated in #link(<ch:oscillations>)[Chapter 1]: for a motion $x(t)$ of period $T$ with $omega = 2 pi / T$,
$
  a_0 = frac(2, T) integral_0^T x(t) dif t,
  quad
  a_n = frac(2, T) integral_0^T x(t) cos(n omega t) dif t,
  quad
  b_n = frac(2, T) integral_0^T x(t) sin(n omega t) dif t.
$

#example(name: "Plucked String")[ // 拨弦
  A string pulled at its midpoint and released has the triangular profile $u(x, 0) = 2 h x / L$ for $x <= L / 2$, symmetric beyond it.
  The even coefficients vanish and the odd ones decay as $a_n prop 1 / n^2$, so the fundamental carries most of the energy and the higher modes only sharpen the corner.
] <ex:plucked-string>

== The Eigenfunction Expansion Idea // 本征函数展开思想

The normal modes are the *eigenfunctions* of the wave operator with the given boundary conditions: each mode satisfies $(dif^2 X) / (dif x^2) = - k_n^2 X$ together with the conditions at the ends of the string.
The step from "solving one mode" to "reconstructing every solution" is a general one, worth stating as a definition.

#definition(name: "Eigenfunction Expansion")[
  Let $cal(L)$ be a linear differential operator on a domain with homogeneous boundary conditions, with eigenfunctions $phi_n$ and eigenvalues $lambda_n$.
  An admissible function $f$ is expanded as
  $
    f = sum_n c_n phi_n, quad c_n = (⟨ phi_n, f ⟩) / (⟨ phi_n, phi_n ⟩),
  $
  where the coefficients are the projections of $f$ onto the eigenfunctions.
] <def:eigenfunction-expansion>

The eigenfunctions are orthogonal, $⟨ phi_m, phi_n ⟩ = 0$ for $m != n$, which is exactly why the coefficients can be computed one at a time by projection.
For the string, $phi_n (x) = sin(n pi x / L)$ and $⟨ phi_m, phi_n ⟩ = (L / 2) delta_(m n)$, so the coefficients of the previous section are these projections written out in full.

This is the discrete ancestor of the Fourier transform, and the same idea returns three times in the notebook:

- Fourier optics expands the field on plane waves, the eigenfunctions of the Laplacian in free space (#link(<sec:plane-wave-expansions>)[Section 4.4]);
- the diffraction integrals of #link(<ch:scalar-diffraction>)[Chapter 8] are that expansion evaluated at the observation plane;
- the quantized field of #link(<ch:field-quantization>)[Chapter 15] expands on the modes of a cavity, one oscillator per mode.

In *Mécanique analytique* (Part II) the same projection is applied to coupled oscillators, where the eigenfunctions become the normal coordinates of the system.

// --- Chapter 4: From Waves to Time-Harmonic Fields (时谐场与亥姆霍兹方程) ---

= From Waves to Time-Harmonic Fields <ch:helmholtz> // 时谐场与亥姆霍兹方程

The wave machinery of Chapters 1–3 describes disturbances that depend on both space and time.
Almost all of classical optics is built on one special case: fields that oscillate at a single, fixed frequency.
This chapter isolates that case, derives the spatial equation it satisfies — the *Helmholtz equation* — and expands its solutions in plane waves.
The Helmholtz equation is the mathematical backbone of Part II (geometric optics as the $lambda -> 0$ limit) and of Part III (diffraction and Fourier optics).

== Waves in 2D and 3D // 二维三维波动

The one-dimensional wave equation of #link(<ch:wave-motion>)[Chapter 2] generalises to three dimensions by replacing the second spatial derivative with the Laplacian $nabla^2$.

#definition(name: "Three-Dimensional Wave Equation")[
  The displacement $u(bold(r), t)$ of a wave propagating in three-dimensional space satisfies
  $
    frac(partial^2 u, partial t^2) = v^2 nabla^2 u,
  $
  where $nabla^2 = gradient dot gradient$ is the Laplacian and $v$ is the wave speed.
] <def:wave-eq-3d>

The plane, spherical, and cylindrical solutions of #link(<ch:wave-motion>)[Chapter 2] are the three-dimensional solutions obtained by separating $u(bold(r), t)$ in Cartesian, spherical, and cylindrical coordinates.
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
In a medium of refractive index $n$, the wavenumber becomes $k = n omega / c = 2 pi n / lambda$, where the $lambda$ on the right is still the vacuum wavelength (inside the medium the wavelength is $lambda / n$).

The Helmholtz equation is the spatial eigenvalue problem of the Laplacian: the field $bold(U)$ is an eigenfunction of $nabla^2$ with eigenvalue $-k^2$.
Its solutions are the building blocks of the entire optical theory that follows.

#note[
  In a source-free, homogeneous medium, every Cartesian component of the electromagnetic field satisfies the scalar Helmholtz equation (see Électrodynamique, Electromagnetic Waves).
  The scalar theory of this notebook works with a single component $bold(U)$; the vector character of the field returns in #link(<ch:polarization>)[Chapter 13 (Polarization)].

  The Helmholtz equation alone admits both outgoing and incoming solutions.
  Physical radiation problems single out the outgoing family by the *Sommerfeld radiation condition*; the diffraction integrals of #link(<ch:scalar-diffraction>)[Chapter 8] are the Green-function solutions that enforce it.
]

== Plane-Wave Expansions <sec:plane-wave-expansions> // 平面波展开

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
This distinction reappears in #link(<ch:diffraction>)[Chapter 10 (Resolution)] and #link(<ch:fourier-optics>)[Chapter 11 (Fourier Optics)].

#note[
  The angular-spectrum representation is the bridge between Part I and the rest of the notebook: the diffraction integrals of #link(<ch:scalar-diffraction>)[Chapter 8] are this representation evaluated at a distant observation plane, and the lens analysis of #link(<ch:fourier-optics>)[Chapter 11] implements it physically as a Fourier transform.
]

Chapters 1–3 of this part developed the wave equation and its general mathematical machinery — d'Alembert's solution, the wave function, complex (phasor) representation, superposition, interference, standing waves, dispersion, group velocity, and Fourier analysis.
These concepts are *medium-independent*: they apply equally to mechanical waves, electromagnetic waves, and quantum probability waves.
The elastic-medium specialisation — strain, stress, elastic moduli, P/S waves, impedance, reflection and half-wave loss — is now part of this notebook as well (#link(<sec:elastic-wave-speed>)[Section 2.4] and #link(<sec:superposition-standing>)[Section 2.6]); it originally came from *Mécanique analytique*.
#link(<ch:helmholtz>)[Chapter 4] has added the last piece: the time-harmonic Helmholtz formulation on which both geometric optics (Part II) and wave optics (Part III) rest.

// --------------------------------------------------------------------------
// Part II: Geometric Optics (几何光学)
// --------------------------------------------------------------------------

#part("Geometric Optics") // 几何光学

// --- Chapter 5: Ray Optics and the Eikonal Equation (光线光学与程函方程) ---

= Ray Optics and the Eikonal Equation <ch:ray-optics> // 光线光学与程函方程

Geometric optics describes the propagation of light in terms of rays rather than waves.
It is not a separate theory: it is the short-wavelength limit of wave optics, obtained from the Helmholtz equation as $lambda -> 0$.
This chapter develops that limit systematically — wavefronts become surfaces of constant phase, rays become their normals, and every classical law of geometric optics follows from the *eikonal equation*.
It redeems the promise made at the end of #link(<ch:helmholtz>)[Chapter 4].

Part II builds geometric optics in three steps, one chapter each: the eikonal limit (#link(<ch:ray-optics>)[Chapter 5]), the paraxial approximation (#link(<ch:paraxial-optics>)[Chapter 6]), and matrix optics with its instruments (#link(<ch:matrix-optics>)[Chapter 7]).
Everything here is an approximation to Part III, and every error term reappears there as diffraction.

== From Waves to Rays: The Short-Wavelength Limit // 从波到光线

Geometric optics applies when the wavelength is much smaller than every relevant length scale of the problem: the size of apertures, the radii of curvature of interfaces, and the scale over which the refractive index varies.
Under this condition the spatial amplitude varies slowly over one wavelength, and the field is well approximated by a slowly varying envelope multiplied by a rapidly oscillating phase.

For a time-harmonic field in a medium of refractive index $n(bold(r))$, the scalar Helmholtz equation of #link(<ch:helmholtz>)[Chapter 4] reads:

$
  (nabla^2 + k_0^2 n^2) bold(U) = 0,
$

where $k_0 = omega / c$ is the vacuum wavenumber.

=== The WKB Ansatz // WKB 拟设

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

=== The Eikonal and Transport Equations // 程函方程与输运方程

#theorem(name: "From Helmholtz to Eikonal")[
  In the short-wavelength limit $lambda -> 0$, the WKB ansatz reduces the Helmholtz equation to two leading-order equations:
  $
    abs(gradient S)^2 = n^2, quad 2 gradient A dot gradient S + A nabla^2 S = 0.
  $
  The first is the *eikonal equation* (order $k_0^2$); the second is the *transport equation* (order $k_0$).
  The order-$k_0^0$ term $nabla^2 A$ is dropped in the geometric-optics approximation.
] <thm:eikonal-from-helmholtz>

// 兑现 Ch 4 引言的承诺：geometric optics as the λ→0 limit

#proof(name: "From Helmholtz to Eikonal")[
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

=== Wavefronts and Rays // 波前与光线

#definition(name: "Eikonal and Wavefronts")[
  The function $S$ solving the eikonal equation is the *eikonal*.
  Its level sets $S(bold(r)) = "const"$ are the *wavefronts* (surfaces of constant phase).
  Since $gradient S != 0$, the rays are the curves orthogonal to the wavefronts, traced in the direction of increasing $S$.
] <def:eikonal-equation>

The construction is drawn in @fig:waves-to-rays: the wavefronts are the level sets of the eikonal and the rays are their normals.

#figure(
  image("img/waves-to-rays.svg", width: 100%),
  caption: [Wavefronts and rays: rays are the normals to the wavefronts (surfaces of constant phase).],
  placement: auto,
  supplement: [Fig.]
) <fig:waves-to-rays>

#note(title: "Validity")[
  The WKB approximation breaks down where the amplitude varies rapidly — at focal points (caustics), at interfaces, and near turning points.
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
The principle subsumes both the law of reflection and Snell's law (#link(<sec:snell-law>)[Section 5.4]), and it is the variational form of the eikonal equation: along a ray the eikonal $S$ accumulated from a reference wavefront is exactly the optical path length (the accumulated phase being $k_0 S$), and the rays are the extremals of $integral n dif s$.

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

#proof(name: "From Eikonal to Ray")[
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

#note(title: "Optical-mechanical analogy (Hamiltonian optics)")[
  Fermat's principle is the optical counterpart of the Maupertuis principle of mechanics: a particle extremises $integral p dif s = integral sqrt(2 m (E - V)) dif s$, a ray extremises $integral n dif s$ — so the refractive index plays the role of the *mechanical momentum* $sqrt(2 m (E - V))$, and the eikonal $S$ plays the role of the action.
  If one nevertheless writes $bold(p) = n bold(r)'$, the ray equation reads $bold(p)' = gradient n$, formally Newton's law $dot(bold(p)) = - gradient V$ for a position-dependent "mass" $n$; this is *not* Newtonian mechanics with a potential $V = - n$, since $|bold(r)'| = 1$ is maintained along every ray.
  The full Hamiltonian formulation of optics belongs to *Mécanique analytique*; here the analogy serves only as intuition.
]

== Reflection and Refraction: Snell's Law <sec:snell-law> // 反射与折射

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

The construction is drawn in @fig:snells-law.

#figure(
  image("img/snells-law.svg", width: 70%),
  caption: [Reflection and refraction at a planar interface: the incident, reflected, and transmitted rays lie in the plane of incidence, and $n_1 sin theta_1 = n_2 sin theta_2$.],
  placement: auto,
  supplement: [Fig.]
) <fig:snells-law>

Both laws follow from Fermat's principle: the stationary optical path between two fixed points on either side of the interface is achieved when the crossing point satisfies these angle relations.
Concretely, let the crossing point slide by $dif x$ along the interface inside the plane of incidence; the first variation of the optical path is $(n_1 sin theta_1 - n_2 sin theta_2) dif x$ for the refracted path and $(n_1 sin theta_1 - n_1 sin theta_1') dif x$ for the reflected one, so stationarity gives Snell's law and $theta_1 = theta_1'$ respectively.

#note(title: "Wavefront (phase-matching) argument")[
  Across the interface the phase must be continuous, so the tangential component of the wavevector, $k_0 n sin theta$, is conserved.
  Equating it on the two sides gives Snell's law directly — the same condition that Fermat's principle produces.
  The reflected ray is obtained by requiring the tangential wavevector to be preserved on the same side: $n_1 sin theta_1 = n_1 sin theta_1'$, hence $theta_1 = theta_1'$.
]

== Total Internal Reflection <sec:total-internal-reflection> // 全反射

When light enters a less dense medium ($n_1 > n_2$), Snell's law admits a real transmitted angle only up to a limiting incidence.

#definition(name: "Critical Angle")[
  The *critical angle* is defined by
  $
    sin theta_c = frac(n_2, n_1).
  $
  For $theta_1 > theta_c$, Snell's law would require $sin theta_2 > 1$, which has no real solution: no transmitted ray exists and the light is *totally internally reflected*.
] <def:critical-angle>

Beyond the critical angle, the "transmitted" field is an evanescent wave that decays exponentially away from the interface and carries no net energy — the geometric-optics avatar of the evanescent plane waves of #link(<ch:helmholtz>)[Chapter 4].
Its full wave description reappears in Part III.

#note[
  Total internal reflection is the working principle of optical fibres (#link(<sec:optical-fibers>)[Section 7.5]), prism reflectors, and waveguides.
  If a second interface is placed within a wavelength, a fraction of the energy tunnels through — the phenomenon of *frustrated total internal reflection*, an instance of quantum tunnelling in optics.
]

// --- Chapter 6: Paraxial Optics (近轴光学) ---

= Paraxial Optics <ch:paraxial-optics> // 近轴光学

Most optical instruments are designed so that light stays close to a single axis of symmetry — the *optical axis*.
In this *paraxial regime*, the trigonometric functions of geometric optics linearise, and imaging becomes a linear theory.
This chapter develops the paraxial theory of refraction, mirrors, and lenses, culminating in the thin-lens equation and Gaussian imaging.

== The Paraxial Approximation <sec:paraxial-approximation> // 近轴近似

A ray is described, at any plane perpendicular to the optical axis, by its height $y$ above the axis and its inclination angle $theta$.

#definition(name: "Paraxial Approximation")[
  The *paraxial approximation* replaces, for small angles $theta$,
  $
    sin theta approx theta, quad tan theta approx theta, quad cos theta approx 1 - theta^2 / 2.
  $
  To first order, the propagation of rays is then *linear* in the ray variables $(y, theta)$.
] <def:paraxial-approximation>

The approximation is accurate for rays whose angle with the axis is only a few degrees; its failure produces the *aberrations* of #link(<sec:aberrations>)[Section 7.4].

#caution(title: "Sign convention")[
  We adopt the Gaussian sign convention for ray tracing, used throughout this chapter:
  - Light travels from left to right.
  - The *object* distance $s$ is measured from the object point to the vertex *along the direction of propagation*: a real object upstream of the vertex has $s > 0$, a virtual object downstream has $s < 0$.
  - The *image* distance $s'$ is measured from the vertex to the image *along the direction of propagation*: a real image downstream of the vertex has $s' > 0$, a virtual image upstream has $s' < 0$.
  - The radius of curvature $R$ is positive when the centre of curvature lies on the outgoing side of the vertex — for a mirror, on the side facing the incident light, so that a concave mirror has $R > 0$.
  - Heights above the optical axis are positive; angles are measured from the axis, counter-clockwise positive.
  So a real object on the left has $s > 0$ even though it lies to the *left* of the vertex: the sign records whether the segment runs with or against the light, not its direction on the page.
  The same convention underlies the matrix formalism of #link(<ch:matrix-optics>)[Chapter 7].
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

#proof(name: "Single Spherical Refracting Surface")[
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

The conjugate-point construction is drawn in @fig:spherical-refraction.

#figure(
  image("img/spherical-refraction.svg", width: 80%),
  caption: [Imaging by a single spherical refracting surface: the object $P$, the image $P'$, and the centre of curvature $C$ lie on the optical axis.],
  placement: auto,
  supplement: [Fig.]
) <fig:spherical-refraction>

A spherical mirror is the reflection analogue: formally, reflection is refraction into a medium of index $n_2 = - n_1$.
This substitution is meant in the *folded* convention, where the image side is unfolded back onto the incident side, so that the image distance and the radius of curvature reverse their sign together: putting $n_2 = - n_1$, $s' -> - s'$ and $R -> - R$ into the surface formula turns $n_1 / s + n_2 / s' = (n_2 - n_1) / R$ into

$
  frac(1, s) + frac(1, s') = frac(2, R),
$

now read with the actual (unfolded) image distance.
For a concave mirror ($R > 0$) the focal length is $f = R / 2$; for a convex mirror it is $f = - R / 2$.

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

#proof(name: "Thin-Lens Formula")[
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
] <ex:thin-lens-imaging>

The thin-lens construction is drawn in @fig:lens-imaging.

#figure(
  image("img/lens-imaging.svg", width: 90%),
  caption: [Gaussian imaging with a thin converging lens: three characteristic rays locate the image $P'$ of the object $P$.],
  placement: auto,
  supplement: [Fig.]
) <fig:lens-imaging>

== Gaussian Imaging // 高斯成像

#definition(name: "Principal Planes and Transverse Magnification")[
  The *principal planes* of a lens system are its two conjugate planes of *unit transverse magnification*: a ray meeting the first principal plane at height $y$ leaves the second at the same height.
  (Unit *angular* magnification instead defines the *nodal points*.)
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

= Matrix Optics and Optical Instruments <ch:matrix-optics> // 矩阵光学与光学仪器

The paraxial theory of #link(<ch:paraxial-optics>)[Chapter 6] is linear; this chapter organises it into a compact matrix formalism and applies it to prisms and optical instruments.
Every paraxial optical element is represented by a $2 times 2$ matrix, and a system of elements is represented by the product of their matrices.

== ABCD Matrices and Stability <sec:abcd-matrices> // ABCD 矩阵与稳定性

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

The equivalent ABCD system is drawn in @fig:abcd-system.

#figure(
  image("img/abcd-system.svg", width: 80%),
  caption: [A paraxial ray $(y, theta)$ propagated through a translation $T(d)$ and a thin lens $L(f)$; the system matrix is $L(f) T(d)$.],
  placement: auto,
  supplement: [Fig.]
) <fig:abcd-system>

#theorem(name: "Cavity Stability Criterion")[
  For a periodic system with unimodular matrix $M = mat(A, B; C, D)$ (i.e., $A D - B C = 1$), the repeated propagation $M^n$ remains bounded if and only if
  $
    abs(frac(A + D, 2)) < 1,
  $
  the sole exception being the degenerate round trip $M = plus.minus I$.
] <thm:stability-criterion>

#proof(name: "Cavity Stability Criterion")[
  *Step 1 — Eigenvalues.*
  Since $"det"(M) = A D - B C = 1$, the eigenvalues of $M$ satisfy $lambda_1 lambda_2 = 1$ and $lambda_1 + lambda_2 = A + D$.

  *Step 2 — Boundedness.*
  If $abs(A + D) < 2$, the eigenvalues are complex conjugates on the unit circle, $lambda = e^(± i phi)$, and the powers $M^n$ oscillate — the ray stays bounded.
  If $abs(A + D) >= 2$, at least one eigenvalue has modulus $>= 1$, and $M^n$ grows — exponentially in general, linearly in the defective cases such as a pure translation — so the ray escapes; the one exception is again the degenerate round trip $M = plus.minus I$.
]

#example(name: "Two-Mirror Optical Cavity")[ // 两镜腔
  Consider a cavity of length $d$ between two mirrors of radii of curvature $R_1$ and $R_2$.
  The round-trip matrix is the product of the two mirror matrices and two translations,
  $
    M = mat(1, d; 0, 1) mat(1, 0; - 2/R_1, 1) mat(1, d; 0, 1) mat(1, 0; - 2/R_2, 1),
  $
  and the cavity is stable exactly when $abs(A + D) / 2 < 1$.
  For two plane mirrors ($R = oo$), $A + D = 2$: the cavity sits on the stability boundary.
  The same criterion returns in #link(<ch:applications>)[Chapter 19], where it governs laser resonators.
] <ex:cavity-stability>

== Prisms and Dispersion <sec:prisms-dispersion> // 棱镜与色散

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
  Hence $delta_"min" = 2 arcsin(0.75) - 60° = 2 times 48.59° - 60° approx 37.2°$, the standard result for a $60°$ crown-glass prism.
] <ex:minimum-deviation>

Since $n$ depends on wavelength, the deviation depends on wavelength: a prism spreads white light into its spectrum.
The *angular dispersion* is $D_"ang" = dif delta / dif lambda$ ($D_"ang"$ here, not the matrix element $D$ of #link(<sec:abcd-matrices>)[Section 7.1]), and the material dependence $n(lambda)$ is developed in #link(<ch:propagation-media>)[Chapter 12].

#note[
  Prisms and gratings both disperse light; gratings (#link(<ch:diffraction>)[Chapter 10]) disperse by interference rather than refraction.
  The wavelength dependence of $n$ itself — normal and anomalous dispersion — belongs to Part III (Propagation in Media).
]

== Microscopes and Telescopes // 显微镜与望远镜

Optical instruments are sequences of lenses analysed with the matrix formalism of #link(<sec:abcd-matrices>)[Section 7.1].

#example(name: "Compound Microscope")[ // 显微镜
  A compound microscope consists of a short-focal-length objective and a longer-focal-length eyepiece.
  The objective forms a real, magnified intermediate image; the eyepiece acts as a magnifier.
  The total *angular* magnification is the product
  $
    M_"tot" = M_"obj" M_"eye",
  $
  of one transverse and one angular factor — the standard convention for a visual instrument: the objective magnification $M_"obj" = - L / f_"obj"$ (for tube length $L$) times the eyepiece angular magnification $M_"eye" = 25 "cm" / f_"eye"$ for a near point at $25 "cm"$.
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

The two instruments are compared in @fig:optical-instruments.

#figure(
  image("img/optical-instruments.svg", width: 100%),
  caption: [Ray diagrams of (a) a compound microscope and (b) a Keplerian refracting telescope.],
  placement: auto,
  supplement: [Fig.]
) <fig:optical-instruments>

#note(title: "Resolution")[
  Magnification alone is useless beyond the *diffraction limit*: a lens of aperture diameter $D_"ap"$ cannot separate two points whose angular separation is below $approx 1.22 lambda / D_"ap"$ (Rayleigh criterion).
  This wave-optical limit is developed in #link(<ch:diffraction>)[Chapter 10].
]

== Aberrations <sec:aberrations> // 像差 [简要]

#property(name: "Aberration Types")[
  - *Spherical aberration*: rays far from the axis focus at a different point than paraxial rays.
  - *Coma*: off-axis point sources produce comet-like images.
  - *Astigmatism*: meridional and sagittal rays focus at different distances.
  - *Field curvature*: the image surface is curved rather than flat.
  - *Distortion*: magnification varies across the field (barrel / pincushion).
  - *Chromatic aberration*: $n(lambda)$ varies with wavelength, so different colours focus at different distances (axial) and at different magnifications (lateral).
] <prop:aberration-types>

#note[
  Aberrations are exactly the failure of the paraxial approximation of #link(<sec:paraxial-approximation>)[Section 6.1], i.e., of the linear theory.
  Their detailed theory belongs to lens design; here we only catalogue them, since the wave optics of Part III accounts for the diffraction limit rather than for geometric aberrations.
]

== Optical Fibers <sec:optical-fibers> // 光纤 [简要]

#definition(name: "Numerical Aperture")[
  A step-index optical fibre consists of a core of index $n_1$ surrounded by a cladding of index $n_2 < n_1$.
  Light is guided by total internal reflection (#link(<sec:total-internal-reflection>)[Section 5.5]); the maximum acceptance angle $theta_a$ in air satisfies
  $
    "NA" = n_"air" sin theta_a = sqrt(n_1^2 - n_2^2),
  $
  where $"NA"$ is the *numerical aperture*.
] <def:numerical-aperture>

#note[
  The modes of a fibre — the discrete transverse patterns it can support — are a wave phenomenon invisible to geometric optics; they are governed by the Helmholtz equation with cylindrical symmetry and belong to Part III.
  The evanescent field outside the core is the same phenomenon as in #link(<sec:total-internal-reflection>)[Section 5.5].
]

Chapters 5–7 built geometric optics as the $lambda -> 0$ limit of wave optics: rays are the normals of the level sets of the eikonal, imaging is linear because paraxial rays obey linear equations, and every paraxial element is a $2 times 2$ matrix.
Everything neglected on the way — the finite wavelength, the interference of secondary waves, the finite aperture — returns in Part III as diffraction.

// --------------------------------------------------------------------------
// Part III: Wave Optics (波动光学)
// --------------------------------------------------------------------------

#part("Wave Optics") // 波动光学

// --- Chapter 8: Scalar Diffraction Theory (标量衍射理论) ---

= Scalar Diffraction Theory <ch:scalar-diffraction> // 标量衍射理论

Geometric optics traced rays; wave optics propagates fields.
This chapter builds the unifying framework for the whole of Part III: the diffraction integral, obtained as the Green-function solution of the Helmholtz equation.
Every phenomenon studied in Part III — interference, diffraction patterns, imaging by lenses, resolution limits — is this integral evaluated in a suitable approximation.

== The Scalar Approximation and Boundary Conditions // 标量近似与边界条件

The electromagnetic field is a vector field, but in free space and in media whose index varies slowly each Cartesian component satisfies the same scalar wave equation (see Électrodynamique).
We therefore work with a single complex scalar amplitude $U(bold(r))$.

#definition(name: "Scalar Optical Field")[
  A *scalar optical field* $U(bold(r))$ is a solution of the Helmholtz equation
  $
    (nabla^2 + k^2) U = 0,
  $
  where $k = 2 pi n / lambda_0$ is the wavenumber in the medium.
  The physical field is recovered as $u(bold(r), t) = "Re"(U(bold(r)) e^(-i omega t))$, with the time-harmonic convention of #link(<ch:helmholtz>)[Chapter 4].
] <def:scalar-field>

A unique solution requires boundary conditions.
On an aperture or screen we prescribe the field or its normal derivative; for radiation problems we add the Sommerfeld radiation condition of #link(<ch:helmholtz>)[Chapter 4], which selects the outgoing solutions.

#note[
  The scalar approximation fails near sharp edges, in strongly absorbing media, and for tightly focused beams, where the vector character of the field (#link(<ch:polarization>)[Chapter 13]) must be retained.
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

The factor $1 / (i lambda)$ and the obliquity factor $K(theta)$ cannot be obtained from the intuitive argument alone; they emerge from the rigorous diffraction theory of #link(<sec:kirchhoff-rayleigh-sommerfeld>)[Section 8.4].

The construction is summarised in @fig:huygens-fresnel.

#figure(
  image("img/huygens-fresnel.svg", width: 80%),
  caption: [The Huygens-Fresnel construction: secondary spherical wavelets emitted from a wavefront, whose envelope forms the new wavefront.],
  placement: auto,
  supplement: [Fig.]
) <fig:huygens-fresnel>

== Green's Functions for Diffraction <sec:green-functions-diffraction> // 衍射的格林函数

The diffraction integral is the Green-function solution of the Helmholtz equation, so the Green function comes first: it is the kernel out of which every integral of this chapter is built.

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

The Green's function admits a plane-wave (angular-spectrum) representation: it is the superposition of the outgoing plane waves of #link(<def:angular-spectrum>)[the angular spectrum].
This is the precise sense in which the diffraction integrals of this chapter are the angular-spectrum representation evaluated at a distant observation plane, redeeming the promise of #link(<ch:helmholtz>)[Chapter 4].

#note(title: "Evanescent waves")[
  The angular-spectrum form of the Green's function contains the evanescent components identified in #link(<sec:plane-wave-expansions>)[Section 4.4].
  Their full wave description — exponential decay away from the aperture, frustrated total internal reflection — was promised at the end of #link(<ch:ray-optics>)[Chapter 5] and is now accounted for by the diffraction integrals of #link(<sec:kirchhoff-rayleigh-sommerfeld>)[Section 8.4].
]

#note(title: "Guided modes")[
  In cylindrical symmetry (fibres, #link(<ch:matrix-optics>)[Chapter 7]), the Helmholtz equation separates with Bessel functions, and the transverse patterns are the discrete guided modes promised in #link(<sec:optical-fibers>)[Section 7.5].
  The same Green-function machinery, with the appropriate modal basis, describes their propagation.
]

== Kirchhoff and Rayleigh-Sommerfeld Integrals <sec:kirchhoff-rayleigh-sommerfeld> // 基尔霍夫与瑞利-索末菲积分

The diffraction integrals follow from Green's theorem applied to the Helmholtz equation, with #link(<def:green-diffraction>)[the free-space Green's function] of #link(<sec:green-functions-diffraction>)[Section 8.3] as kernel.

=== Kirchhoff's Integral // 基尔霍夫积分

#theorem(name: "Kirchhoff Diffraction Integral")[
  Let $Sigma$ be an aperture in an opaque screen, and let $U$ be a field that satisfies the Helmholtz equation behind the screen.
  With the free-space Green's function $G = e^(i k r) / r$, the field at a point $P$ is
  $
    U(P) = 1 / (4 pi) integral_Sigma [U (partial G)/(partial n) - G (partial U)/(partial n)] dif S,
  $
  where $partial / partial n$ is the derivative along the normal to $Sigma$ directed *towards the observation region* (the direction of propagation) and $r$ is the distance from the integration point to $P$; the opposite orientation of the normal introduces an overall minus sign, and the same convention is used again below.
] <thm:kirchhoff-integral>

#proof(name: "Kirchhoff Diffraction Integral")[
  *Step 1 — Green's second identity.*
  For two smooth functions $U$ and $G$ on a volume $V$ bounded by a surface $S$:
  $
    integral_V (U nabla^2 G - G nabla^2 U) dif V = integral_S (U (partial G)/(partial n) - G (partial U)/(partial n)) dif S.
  $

  *Step 2 — Apply to the Helmholtz equation.*
  Both $U$ and $G$ solve the Helmholtz equation away from the singular point of $G$, so $U nabla^2 G - G nabla^2 U = 0$ on the integration region.
  A large closing hemisphere is made to vanish by the Sommerfeld radiation condition, so what remains of the surface integral is the aperture $Sigma$ (the screen contributes nothing under the Kirchhoff boundary conditions below) together with the small sphere around $P$.

  *Step 3 — Pick up the singularity.*
  Surrounding $P$ by a small sphere of radius $epsilon$ and using $G = e^(i k r) / r$ on it, the integral over the small sphere gives $4 pi U(P)$ as $epsilon -> 0$.
  Rearranging yields the Kirchhoff integral.
]

The theorem as stated uses the *Kirchhoff boundary conditions*: on the aperture $U$ and $partial U / partial n$ take the values of the incident field, and on the screen they vanish.

#note(title: "Inconsistency")[
  The Kirchhoff conditions assign both $U$ and its normal derivative on the screen, which over-determines the elliptic problem: a Helmholtz solution is fixed by one boundary condition alone, and one that vanishes together with its normal derivative on an open piece of the boundary vanishes identically.
  The practical consequence is that the formula never returns the very values fed into it: in particular it does not reproduce the incident wave when the screen is removed.
  The Rayleigh-Sommerfeld theory repairs both defects.
]

=== The Rayleigh-Sommerfeld Integral // 瑞利-索末菲积分

#theorem(name: "Rayleigh-Sommerfeld Diffraction Integral")[
  Choose the Green's function with vanishing value on the screen, $G_D = e^(i k r) / r - e^(i k r') / r'$, where $r'$ is the distance to the mirror image of $P$ in the plane of the screen.
  Then the Dirichlet problem has the solution
  $
    U(P) = 1 / (i lambda) integral_Sigma U(P_0) e^(i k r) / r cos theta dif S,
  $
  where $theta$ is the angle between the segment $P_0 P$ and the normal to the screen.
] <thm:rayleigh-sommerfeld>

#proof(name: "Rayleigh-Sommerfeld Diffraction Integral")[
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

// --- Chapter 9: Interference and Coherence (干涉与相干性) ---

= Interference and Coherence <ch:interference> // 干涉与相干性

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
] <ex:young-fringes>

The geometry and the resulting fringes are shown in @fig:young-double-slit.

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
  Real slits have finite width: each slit diffracts, and the two-beam pattern is modulated by the single-slit diffraction envelope (#link(<ch:diffraction>)[Chapter 10]).
  The diffraction envelope answers "where the light goes"; the interference term answers "how it distributes within the envelope".
]

== Interference of Thin Films <sec:thin-film-interference> // 薄膜干涉

A thin film of thickness $t$ and index $n$ between two media reflects light from both surfaces.
The reflected waves interfere with phase difference from the extra optical path $2 n t cos theta_t$ and from any phase jump at reflection:

$
  Delta = 2 n t cos theta_t + (lambda_0) / 2,
$

where the $lambda_0 / 2$ term accounts for a phase jump of $pi$ when light reflects off a denser medium.

#example(name: "Newton's Rings")[ // 牛顿环
  A plano-convex lens of radius $R$ resting on a flat plate creates a film of thickness $t(r) approx r^2 / (2 R)$.
  Bright rings occur where $2 t = (m + 1/2) lambda$, giving ring radii $r_m = sqrt((m + 1/2) lambda R)$ for $m = 0, 1, 2, dots.c$, which reduce to the familiar estimate $r_m approx sqrt(m lambda R)$ at large order $m$.
  The regular rings resisted a corpuscular account, and their explanation by interference was one of the early successes of the wave theory.
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
  Its modern descendants include Fourier-transform spectrometers, gravitational-wave detectors (LIGO-type cavities), and the coherence measurements of #link(<sec:visibility-coherence>)[Section 9.6].
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

#proof(name: "Airy Function")[
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
  The sharpness is what makes the Fabry-Perot the standard tool for high-resolution spectroscopy and for laser cavities (#link(<ch:applications>)[Chapter 19]).
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

== Visibility and the Degree of Coherence <sec:visibility-coherence> // 可见度与相干度

#definition(name: "Complex Degree of Coherence")[
  The normalized first-order correlation of two fields is the *complex degree of coherence*
  $
    gamma_(12)(tau) = (⟨ U_(1)(t + tau) U_(2)^"*"(t) ⟩) / sqrt(⟨ abs(U_(1))^2 ⟩ ⟨ abs(U_(2))^2 ⟩),
  $
  where the averages are over time.
  Its modulus satisfies $0 <= abs(gamma_(12)) <= 1$.
] <def:complex-coherence-degree>

For quasi-monochromatic fields the *visibility* measures the modulus of the degree of coherence; for two beams of intensities $I_1$ and $I_2$,

$
  V = frac(2 sqrt(I_1 I_2), I_1 + I_2) abs(gamma_(12)(0)),
$

which reduces to $V = abs(gamma_(12)(0))$ when the intensities are equal.

Perfect coherence ($abs(gamma) = 1$) gives unit visibility; incoherence ($abs(gamma) = 0$) gives none.
The fringe phase carries the argument of $gamma$, which encodes the optical path difference.

#note[
  The degree of coherence is the classical precursor of the first-order correlation function of quantum optics: the Hanbury Brown–Twiss experiments of #link(<ch:photon-statistics>)[Chapter 17] measure the second-order analogue, and photon statistics sharpen the classical average into a quantum expectation.
]

// --- Chapter 10: Diffraction (衍射) ---

= Diffraction: Approximations and Applications <ch:diffraction> // 衍射：近似与应用

The diffraction integral of #link(<ch:scalar-diffraction>)[Chapter 8] is exact but rarely evaluated in closed form.
This chapter introduces the two standard approximations — Fresnel (near field) and Fraunhofer (far field) — and applies them to slits, apertures, gratings, and imaging.
The Fraunhofer patterns are nothing but Fourier transforms of the aperture, which prepares the Fourier optics of #link(<ch:fourier-optics>)[Chapter 11].

== Fresnel Diffraction and Zone Plates <sec:fresnel-diffraction> // 菲涅耳衍射与波带片

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

#note(title: "Zone plates")[
  Divide the wavefront into concentric *half-period zones* so that waves from successive zones arrive out of phase.
  Blocking every other zone turns the remaining zones into an approximate converging lens: a zone plate focuses light even though it contains no refracting material.
]

== Fraunhofer Diffraction: The Single Slit <sec:fraunhofer-single-slit> // 单缝夫琅禾费衍射

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

#proof(name: "Fraunhofer Diffraction by a Single Slit")[
  *Step 1 — Fourier transform of a rectangle.*
  The aperture field is $U_0(x_0) = U_0$ on $abs(x_0) <= a / 2$ and zero elsewhere.
  Its Fourier transform is proportional to the integral $integral_(-a/2)^(a/2) e^(- i k x_0 sin theta) dif x_0 = a "sinc"(k a sin theta / 2)$.

  *Step 2 — Intensity.*
  Squaring the modulus gives $I(theta) prop "sinc"^2(k a sin theta / 2)$, hence the stated form with $beta = k a sin theta / 2$.
]

== Fraunhofer Diffraction: The Circular Aperture // 圆孔夫琅禾费衍射

The circular aperture is the case of practical importance: every lens, every camera stop, and every telescope objective is one.

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

#proof(name: "Fraunhofer Diffraction by a Circular Aperture")[
  *Step 1 — Fourier transform in polar coordinates.*
  The circular aperture is the indicator of a disk; its two-dimensional Fourier transform is the Hankel transform of the disk, which evaluates to $2 J_(1)(x) / x$.

  *Step 2 — First zero.*
  The first zero of $J_(1)(x)$ is at $x = 3.8317 approx 1.22 pi$, giving $sin theta_(1) = 1.22 lambda / D$.
]

#example(name: "Airy Disc Size")[ // 艾里斑尺寸
  A camera lens of diameter $D = 25 "mm"$ at $lambda = 550 "nm"$ has an Airy disc of angular radius $theta_(1) = 1.22 lambda / D approx 2.7 times 10^(-5) "rad"$.
  At a focal distance of $200 "mm"$ that is a radius of only $5.4 times 10^(-3) "mm" = 5.4 "µm"$ (diameter $approx 11 "µm"$) — at the scale of the pixel pitch of a modern sensor, which is why diffraction limits the finest usable pixels.
  Stopping the lens down increases the Airy disc — smaller aperture, worse diffraction resolution.
] <ex:airy-disc-diameter>

Single slit, double slit and circular aperture are compared in @fig:fraunhofer-patterns.

#figure(
  image("img/fraunhofer-patterns.svg", width: 100%),
  caption: [Fraunhofer diffraction patterns: single slit (sinc²), double slit (interference modulated by diffraction), and circular aperture (Airy pattern).],
  placement: auto,
  supplement: [Fig.]
) <fig:fraunhofer-patterns>

#note[
  The double-slit pattern is the product of the two-slit interference term of #link(<ch:interference>)[Chapter 9] and the single-slit diffraction envelope of #link(<sec:fraunhofer-single-slit>)[Section 10.2]:
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

#proof(name: "Grating Resolution")[
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

== Resolution: Rayleigh and Abbe Criteria <sec:resolution-criteria> // 分辨极限

The finite size of any aperture sets a fundamental limit on imaging: the image of a point is an Airy pattern, not a point.

#definition(name: "Rayleigh Criterion")[
  Two point sources are *resolved* when the first dark ring of one Airy pattern falls on the maximum of the other:
  $
    theta_"min" = 1.22 lambda / D.
  $
  The two patterns are then separated by the half-width of the Airy disc.
] <def:rayleigh-criterion>

#definition(name: "Abbe Resolution Limit")[
  For a microscope with numerical aperture $"NA" = n sin theta$ (#link(<sec:optical-fibers>)[Section 7.5]), the finest resolvable spacing is
  $
    d_"min" = (lambda) / (2 "NA").
  $
] <def:abbe-limit>

The three regimes are drawn in @fig:resolution-criterion.

#figure(
  image("img/resolution-criterion.svg", width: 100%),
  caption: [The Rayleigh criterion: two Airy patterns at separations below, equal to, and above $theta_"min"$ — unresolved, just resolved, and resolved.],
  placement: auto,
  supplement: [Fig.]
) <fig:resolution-criterion>

#note(title: "Why the limit is fundamental")[
  The angular-spectrum analysis of #link(<sec:plane-wave-expansions>)[Section 4.4] showed that fine spatial detail generates evanescent waves that do not propagate to the far field.
  The Rayleigh and Abbe criteria are exactly that statement in imaging language: the aperture collects only the propagating components, so detail finer than $lambda / (2 "NA")$ is lost — the wave-optical limit promised in #link(<ch:matrix-optics>)[Chapter 7].
]

// --- Chapter 11: Fourier Optics (傅里叶光学) ---

= Fourier Optics <ch:fourier-optics> // 傅里叶光学

#link(<sec:fraunhofer-single-slit>)[Section 10.2] showed that the Fraunhofer pattern is the Fourier transform of the aperture.
This chapter makes that observation operational: a lens performs the transform optically, and two lenses in a row build a complete filtering system.
Fourier optics is the engineering branch of wave optics, and it redeems the promise of #link(<ch:helmholtz>)[Chapter 4] that the lens implements the angular-spectrum representation as a physical Fourier transform.

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

#proof(name: "Lens Fourier Transform")[
  *Step 1 — Lens phase.*
  Immediately after the lens the field is $U_(i n)(x, y) t(x, y)$, with $t$ the quadratic phase factor above.

  *Step 2 — Fresnel propagation to the focal plane.*
  Propagate this field a distance $f$ with the Fresnel integral of #link(<sec:fresnel-diffraction>)[Section 10.1].
  The quadratic phase of $t$ cancels the quadratic phase of the Fresnel kernel exactly, leaving only the cross term.

  *Step 3 — Conclude.*
  The surviving term is the stated integral: the lens converts the quadratic Fresnel kernel into the linear Fourier kernel.
]

The magic of the result is the cancellation: without the lens the Fresnel kernel keeps its quadratic phase and no clean transform appears.

#note(title: "The 2f system")[
  With the input in the front focal plane, the output is a *strict* Fourier transform with no residual phase factor.
  If the input is placed elsewhere, the output carries an additional quadratic phase, so the standard configuration for Fourier processing is the 2f system.
  This is the lens analysis promised in #link(<ch:helmholtz>)[Chapter 4], where the angular-spectrum representation is physically implemented by the lens.
]

The 2f geometry is drawn in @fig:lens-fourier.

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

The pupil function unifies the diffraction results of #link(<ch:diffraction>)[Chapter 10]: the single slit, the circular aperture, and every grating are special pupils.
An imaging system with pupil $P$ acts as a linear filter on the field, and its impulse response is the Fraunhofer pattern of $P$.

The choice of pupil is therefore the design variable of an imaging system, and two consequences are worth stating.

- *Apodization.* Softening the edge of the pupil — a gradual rather than abrupt taper to zero — suppresses the secondary rings of its Fraunhofer pattern at the price of a slightly wider central lobe.
- *Aberrations as phase.* A departure from a spherical wavefront enters the pupil as a phase factor $e^(i k W(x, y))$, which is exactly the geometric aberration of #link(<ch:matrix-optics>)[Chapter 7] rewritten in wave language.

The pupil thus carries the whole optical specification of the system: its modulus and its autocorrelation become the transfer functions of #link(<sec:psf-otf>)[Section 11.4].

== Spatial Filtering // 空间滤波

A *4f system* chains two Fourier transforms: lens 1 produces the spectrum of the input in its focal plane, where a filter is inserted, and lens 2 Fourier-transforms the filtered spectrum back to an image.

#example(name: "4f Spatial Filtering")[ // 4f 空间滤波
  - *Low-pass filter*: a circular stop on the axis blocks high spatial frequencies — the image is blurred and speckle and periodicity are suppressed.
  - *High-pass filter*: an opaque disc on the axis blocks the DC and low frequencies — edges are enhanced, since edges live in the high-frequency content.
  - *Phase filter*: a phase plate alters the spectrum, e.g., for phase contrast microscopy of transparent specimens.
] <ex:4f-spatial-filtering>

The 4f system is the physical image of the statement "multiplication in the frequency domain" that underlies all linear filtering, and it is the basis of optical information processing.

The two illumination regimes must be kept apart, because the same physical filter acts differently in each.

- *Coherent illumination.* The filter multiplies the field spectrum, so the system is linear in amplitude: a stop that removes a spatial frequency deletes that amplitude everywhere in the image.
- *Incoherent illumination.* Intensities add, the filter acts on the transfer function of #link(<sec:psf-otf>)[Section 11.4], and a stop attenuates the contrast of that frequency instead of deleting it.

The price of the 4f architecture is its length — four focal lengths, two lenses, and a filter that must sit exactly in the focal plane — and its sensitivity to alignment.
In practice the same operation is increasingly performed digitally on a recorded image.

== PSF, OTF and the Coherent Transfer Function <sec:psf-otf> // 点扩散函数与光学传递函数

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
  The distinction is sharp: coherent imaging is linear in amplitude, so the transfer function is the pupil itself ($"CTF" = P$); incoherent imaging is linear in intensity, so the transfer function is the *complex autocorrelation of the pupil*, $"OTF" = P ⊛ P$ — the pupil enters with its phase, not through its modulus.
  The Abbe limit of #link(<sec:resolution-criteria>)[Section 10.5] is the support of the CTF: spatial frequencies beyond the pupil support are simply cut off.
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

// --- Chapter 12: Propagation in Media (介质中的传播) ---

= Propagation in Media <ch:propagation-media> // 介质中的传播

So far the medium entered through a given refractive index $n$.
This chapter asks where $n$ comes from: light drives the charges of the medium, and the driven response — dispersive, absorptive, causal, scattering — is the material side of wave optics.
It redeems the promise of #link(<ch:matrix-optics>)[Chapter 7] that the wavelength dependence $n(lambda)$ belongs here.
With the material response in place, the closing chapter of Part III restores what the scalar theory suppressed: the vector character of the field.

== Dispersion and Absorption <sec:dispersion-absorption> // 色散与吸收

#definition(name: "Lorentz Oscillator Model")[
  In the *Lorentz oscillator model*, each electron is a damped harmonic oscillator driven by the electric field:
  $
    dot.double(x) + gamma dot(x) + omega_0^2 x = q/m E_0 e^(- i omega t),
  $
  with damping rate $gamma$ (a decay rate here, not the Lorentz factor of #link(<ch:wave-motion>)[Chapter 2]) and resonance frequency $omega_0$.
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

The resulting $n(omega)$ is plotted in @fig:dispersion-curves.

#figure(
  image("img/dispersion-curves.svg", width: 100%),
  caption: [Refractive index $n(omega)$ near a single resonance: normal dispersion far from resonance, anomalous dispersion within the absorption band.],
  placement: auto,
  supplement: [Fig.]
) <fig:dispersion-curves>

#note(title: "Normal vs anomalous dispersion")[
  Far from resonance, $n(omega)$ increases with frequency (normal dispersion, familiar from prism spectra, #link(<sec:prisms-dispersion>)[Section 7.2]).
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

#proof(name: "Kramers-Kronig Relations")[
  *Step 1 — Analyticity.*
  Causality makes the susceptibility $chi(omega)$ analytic in the upper half-plane: the Fourier transform of a retarded response has no poles for $"Im"(omega) > 0$.

  *Step 2 — Contour integration.*
  Integrate $chi(omega') / (omega' - omega)$ over a large semicircle in the upper half-plane, indented around the pole on the real axis.
  The analyticity plus the decay of $chi$ at infinity leaves only the principal-value integral and the residue.

  *Step 3 — Fold the integral and separate real and imaginary parts.*
  Crossing symmetry, $chi(- omega') = chi(omega')^*$, folds the integral over the whole real axis onto $omega' > 0$; separating $chi = chi_1 + i chi_2$ in the resulting identity then yields the two dispersion relations above.
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

The $lambda^(-4)$ dependence is plotted in @fig:rayleigh-scattering.

#figure(
  image("img/rayleigh-scattering.svg", width: 70%),
  caption: [Rayleigh scattering strength versus wavelength: the $lambda^(-4)$ law suppresses long wavelengths relative to short ones.],
  placement: auto,
  supplement: [Fig.]
) <fig:rayleigh-scattering>

#note[
  Rayleigh scattering by air is why the sky is blue; Mie scattering by water droplets and aerosols is why clouds and milk are white — comparable particle sizes scatter all wavelengths equally.
  This closes the scalar account of propagation: the Helmholtz equation, diffraction, interference and Fourier optics now have their material side. The vector structure of the field is restored in the next chapter, which closes Part III.
]

// --- Chapter 13: Polarization (偏振) ---

= Polarization <ch:polarization> // 偏振

So far the field was scalar. Light, however, is a vector field, and its transverse structure is the polarization.
This chapter returns to the vector character promised in #link(<ch:helmholtz>)[Chapter 4], describes polarization states by two compact algebras — Jones (2 × 2, coherent) and Mueller (4 × 4, incoherent) — and studies how matter modifies them.

== Polarization States of Light <sec:polarization-states> // 光的偏振态

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

The three cases are drawn in @fig:polarization-ellipse.

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
  Malus's law is the amplitude-splitting analogue of the interference visibility of #link(<ch:interference>)[Chapter 9]: both measure how much of a field survives a projection.
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

This closes Part III.
From the Helmholtz equation through diffraction, interference, Fourier optics and the material response, the scalar wave theory is complete; with the vector character restored, the field is ready to be quantized in Part IV.

#part("Quantum Optics") // 量子光学

// --- Chapter 14: Old Quantum Theory of Light (光的旧量子论) ---

= Old Quantum Theory of Light <ch:old-quantum> // 光的旧量子论

Part III treated light as a classical wave field.
Between 1900 and 1925, three experiments forced the conclusion that light exchanges energy with matter in quantized packets $h nu$: blackbody radiation, the photoelectric effect, and Compton scattering.
This bridging chapter establishes the particle side of light; #link(<ch:field-quantization>)[Chapter 15] shows how the quantized field reconciles it with the wave picture.

Part IV (Chapters 14–19) proceeds from that bridge through the quantized field (#link(<ch:field-quantization>)[Chapter 15]), its states and phase space (#link(<ch:coherent-states>)[Chapter 16]), photon statistics (#link(<ch:photon-statistics>)[Chapter 17]), light–matter interaction (#link(<ch:light-matter>)[Chapter 18]), and the applications that follow from them (#link(<ch:applications>)[Chapter 19]).

== Blackbody Radiation and Planck's Law // 黑体辐射与普朗克定律

A cavity at temperature $T$ emits radiation whose spectral energy density $u(nu, T)$ depends only on $T$ and the frequency $nu$.
Classical physics (Rayleigh–Jeans) predicts the low-frequency behaviour correctly but diverges at high frequencies:

$
  u_("RJ")(nu, T) = (8 pi nu^2 k_B T) / c^3.
$

#definition(name: "Planck's Law")[
  The spectral energy density of blackbody radiation is
  $
    u(nu, T) = (8 pi h nu^3) / c^3 dot 1 / (e^(h nu / (k_B T)) - 1),
  $
  with Planck's constant $h = 6.626 times 10^(-34) "J s"$.
] <def:planck-law>

#theorem(name: "Derivation of Planck's Law")[
  The law follows from the density of cavity modes $8 pi nu^2 / c^3$ times the average energy of a quantized oscillator.
  Assigning each mode the discrete energies $epsilon_n = n h nu$ gives the Bose–Einstein average
  $
    ⟨ E ⟩ = h nu / (e^(h nu / (k_B T)) - 1),
  $
  and multiplying by the mode density yields the formula above.
] <thm:planck-derivation>

#note(title: "The ultraviolet catastrophe")[
  The Rayleigh–Jeans law diverges as $nu -> oo$ — the classical prediction that every hot body emits infinite energy at high frequency.
  The quantization $epsilon_n = n h nu$ cuts the high-frequency contribution off exponentially and removes the divergence.
]

Planck's law and its two limits are plotted in @fig:planck-spectrum.

#figure(
  image("img/planck-spectrum.svg", width: 100%),
  caption: [Blackbody spectral energy density at three temperatures; the classical Rayleigh–Jeans curve diverges at high frequency.],
  placement: auto,
  supplement: [Fig.]
) <fig:planck-spectrum>

#note[
  The law reduces to Rayleigh–Jeans for $h nu << k_B T$ (low frequencies) and to Wien's law for $h nu >> k_B T$.
  The peak shifts as $lambda_max T = 2.898 times 10^(-3) "m K"$ (Wien's displacement law), which is why a hotter body glows bluer.
]

== The Photoelectric Effect // 光电效应

Light shining on a metal surface ejects electrons.
The kinetic energy of the fastest electrons and the existence of a threshold frequency are independent of intensity — facts inexplicable classically.

#law(name: "Photoelectric Effect")[
  The maximum kinetic energy of the ejected electrons is
  $
    K_max = h nu - W,
  $
  where $W$ is the work function of the metal.
  No electrons are emitted below the cutoff frequency $nu_0 = W / h$, whatever the intensity.
] <law:photoelectric>

#example(name: "Cutoff Frequency")[ // 截止频率
  Sodium has work function $W = 2.28 "eV"$.
  Its cutoff frequency is $nu_0 = W / h = (2.28 dot 1.602 times 10^(-19)) / (6.626 times 10^(-34)) "Hz" approx 5.5 times 10^14 "Hz"$, corresponding to green light.
  Red light, no matter how intense, ejects no electrons.
] <ex:photoelectric-cutoff>

#note[
  Classically the electron energy should grow with intensity, and emission should occur at any frequency once the field is strong enough.
  Einstein's 1905 hypothesis — light consists of quanta of energy $h nu$, one quantum per absorbed electron — explains both facts at once.
]

== Compton Scattering // 康普顿散射

X-rays scattered by free electrons emerge with a longer wavelength, the shift growing with scattering angle.

#theorem(name: "Compton Shift")[
  A photon of energy $h nu$ scattered by an electron at rest emerges with wavelength
  $
    lambda' = lambda + h / (m_e c) (1 - cos theta),
  $
  where $theta$ is the scattering angle and $m_e$ the electron mass.
] <thm:compton-shift>

#proof(name: "Compton Shift")[
  *Step 1 — Conserve energy.*
  The photon loses energy $h nu - h nu'$, which the electron gains as kinetic energy:
  $
    h nu - h nu' = (m_e c^2) / sqrt(1 - beta^2) - m_e c^2.
  $
  *Step 2 — Conserve momentum.*
  Resolving photon momenta along the initial direction and perpendicular to it:
  $
    h / lambda = h / lambda' cos theta + p_e cos phi, quad 0 = h / lambda' sin theta - p_e sin phi.
  $
  *Step 3 — Eliminate the electron.*
  Using the relativistic identity $p_e^2 c^2 = K^2 + 2 K m_e c^2$ and eliminating $phi$ gives the stated shift.
]

#example(name: "Compton Wavelength")[ // 康普顿波长
  At $theta = 90°$, the shift is $h / (m_e c) approx 2.43 "pm"$, the Compton wavelength of the electron.
  The shift is measurable for X-rays ($lambda ~ 0.1 "nm"$) but negligible for visible light.
] <ex:compton-scattering>

== Wave-Particle Duality // 波粒二象性

#definition(name: "Photon Momentum")[
  A photon of frequency $nu$ carries momentum
  $
    bold(p) = h / lambda bold(hat(n)),
  $
  with magnitude $p = h / lambda = h nu / c$.
] <def:photon-momentum>

#note(title: "The single-photon double slit")[
  In Young's experiment (#link(<ch:interference>)[Chapter 9]) the fringe pattern appears even when the intensity is so low that photons arrive one at a time — each photon interferes with itself, and the pattern builds up as a statistical accumulation of detections.
  The wave picture (Part III) governs the probability distribution; the particle picture governs the individual detection events.
]

#note[
  Wave–particle duality is not a paradox to be resolved by choosing one picture per experiment: #link(<ch:field-quantization>)[Chapter 15] quantizes the field so that a single quantum object — the photon — carries both the wave-like mode structure and the particle-like energy quanta $h nu$.
]

// --- Chapter 15: Quantization of the Electromagnetic Field (电磁场量子化) ---

= Quantization of the Electromagnetic Field <ch:field-quantization> // 电磁场量子化

Einstein's photon carries the energy quantum $h nu$, yet interference and diffraction (Part III) demand a wave field.
The resolution is to quantize the field itself: every field mode is a harmonic oscillator, and photons are the excitation quanta of these oscillators.
This chapter performs the canonical quantization for a single mode in full and summarizes the multimode extension; it uses the harmonic oscillator formalism of *Mécanique quantique* and of #link(<ch:oscillations>)[Chapter 1].

== Classical Field Modes // 经典场模

The electromagnetic field inside a cavity can be expanded in spatial modes (the plane-wave expansion of #link(<ch:helmholtz>)[Chapter 4], or the cavity modes of #link(<ch:matrix-optics>)[Chapter 7]).
In each mode the field factors into a time-dependent amplitude and a fixed spatial pattern:

$
  bold(E)(r, t) = q(t) bold(E)_0 (r),
$

where $q(t)$ is the generalized coordinate of the mode.

#definition(name: "Field Mode Hamiltonian")[
  The electromagnetic energy of the mode reduces to that of a harmonic oscillator:
  $
    H = 1/2 integral (epsilon_0 bold(E)^2 + bold(B)^2 / mu_0) dif V = (p^2 + omega^2 q^2) / 2,
  $
  with generalized momentum $p = dot(q)$ and mode frequency $omega$.
  In dimensionless variables $Q = sqrt(omega / planck) q$ and $P = p / sqrt(planck omega)$,
  $
    H = planck omega (P^2 + Q^2) / 2.
  $
] <def:field-mode>

== Canonical Quantization of the Field // 场的正则量子化

Quantization promotes the coordinate and momentum to operators satisfying the canonical commutation relation:

$
  [hat(Q), hat(P)] = i.
$

#definition(name: "Ladder Operators")[
  The *annihilation* and *creation* operators are
  $
    hat(a) = (hat(Q) + i hat(P)) / sqrt(2), quad hat(a)^dagger = (hat(Q) - i hat(P)) / sqrt(2),
  $
  and satisfy
  $
    [hat(a), hat(a)^dagger] = 1.
  $
] <def:ladder-operators>

#definition(name: "Number Operator")[
  The *number operator* of the mode is $hat(N) = hat(a)^dagger hat(a)$.
] <def:number-operator>

The number operator is Hermitian and counts the quanta of the mode: its eigenstates $| n ⟩$, with $n = 0, 1, 2, dots$, are the photon-number states of #link(<sec:fock-states>)[Section 15.3].

#theorem(name: "Quantization of the Field Hamiltonian")[
  In terms of #link(<def:number-operator>)[the number operator], the field Hamiltonian is
  $
    hat(H) = planck omega (hat(N) + 1/2).
  $
] <thm:field-quantization>

#proof(name: "Quantization of the Field Hamiltonian")[
  *Step 1 — Substitute the ladder operators.*
  With $hat(Q) = (hat(a) + hat(a)^dagger) / sqrt(2)$ and $hat(P) = (hat(a) - hat(a)^dagger) / (i sqrt(2))$, the dimensionless sum $hat(P)^2 + hat(Q)^2$ becomes $hat(a)^dagger hat(a) + hat(a) hat(a)^dagger$.
  *Step 2 — Use the commutator.*
  The relation $[hat(a), hat(a)^dagger] = 1$ gives $hat(a) hat(a)^dagger = hat(a)^dagger hat(a) + 1$, hence $hat(H) = planck omega (hat(N) + 1/2)$.
]

#note(title: "Multimode extension")[
  Independent modes carry independent ladder operators with $[hat(a)_k, hat(a)_l^dagger] = delta_(k l)$.
  The full field Hamiltonian is the sum $hat(H) = sum_k planck omega_k (hat(N)_k + 1/2)$ — the field is a collection of independent quantum oscillators.
]

== Photon Number (Fock) States <sec:fock-states> // 光子数态

#definition(name: "Fock States")[
  The *number states* (Fock states) are the eigenstates of $hat(N)$:
  $
    | n ⟩ = (hat(a)^dagger)^n / sqrt(n!) | 0 ⟩,
  $
  with
  $
    hat(a)| n ⟩ = sqrt(n) | n - 1 ⟩, quad hat(a)^dagger | n ⟩ = sqrt(n + 1) | n + 1 ⟩, quad hat(N)| n ⟩ = n | n ⟩.
  $
] <def:fock-state>

#property(name: "Properties of the Number States")[
  - Orthonormality: $⟨ m | n ⟩ = delta_(m n)$.
  - Completeness: $sum_(n=0)^oo | n ⟩ ⟨ n | = 1$.
  - Energy: each state $| n ⟩$ carries energy $E_n = (n + 1/2) planck omega$, an integer number of quanta $planck omega$ above the zero-point energy.
] <prop:number-state-properties>

#example(name: "Single-Mode Energy")[ // 单模能量
  A single mode at optical frequency $nu = 5 times 10^14 "Hz"$ has photon energy $h nu approx 2 "eV"$.
  The state $| 3 ⟩$ carries three quanta, $E_3 = 3 h nu$ above the zero-point energy.
] <ex:single-mode-energy>

== Vacuum Fluctuations and Zero-Point Energy <sec:vacuum-fluctuations> // 真空涨落与零点能

#definition(name: "Zero-Point Energy")[
  The ground state $| 0 ⟩$ has energy $1/2 planck omega$ per mode, so the vacuum of a multimode field carries the *zero-point energy*
  $
    E_0 = sum_k planck omega_k / 2,
  $
  which formally diverges in the continuum limit.
] <def:zero-point-energy>

#note(title: "Vacuum fluctuations")[
  The vacuum expectation of the field vanishes, $⟨ 0 | hat(bold(E)) | 0 ⟩ = 0$, but its square does not: $⟨ 0 | hat(bold(E))^2 | 0 ⟩ != 0$.
  The empty field therefore exhibits fluctuating fields of zero mean — the physical origin of spontaneous emission (#link(<ch:light-matter>)[Chapter 18]) and of the Casimir force between conducting plates.
  The polarization states of #link(<ch:polarization>)[Chapter 13] become, in this language, superpositions of the two Fock modes of orthogonal polarization — the Bloch-sphere picture promised in #link(<ch:polarization>)[Chapter 13], and the photon helicity states are the circular-polarization superpositions introduced in #link(<sec:polarization-states>)[Section 13.1].
]

// --- Chapter 16: Coherent and Squeezed States (相干态与压缩态) ---

= Coherent and Squeezed States <ch:coherent-states> // 相干态与压缩态

The number states of #link(<ch:field-quantization>)[Chapter 15] have a definite photon number but an ill-defined phase.
A laser, however, produces a field with a stable classical amplitude and phase.
The Glauber coherent states — eigenstates of the annihilation operator — are the quantum states closest to a classical wave; the squeezed states go further and redistribute the vacuum uncertainty between the field quadratures.

== Glauber Coherent States // Glauber 相干态

#definition(name: "Coherent State")[
  A *coherent state* $| alpha ⟩$ is the eigenstate of the annihilation operator,
  $
    hat(a)| alpha ⟩ = alpha | alpha ⟩, quad alpha in CC,
  $
  obtained by acting on the vacuum with the displacement operator
  $
    hat(D)(alpha) = exp(alpha hat(a)^dagger - alpha^"*" hat(a)), quad | alpha ⟩ = hat(D)(alpha)| 0 ⟩.
  $
] <def:coherent-state>

#theorem(name: "Properties of Coherent States")[
  The coherent state has the number-state expansion
  $
    | alpha ⟩ = e^(- abs(alpha)^2 / 2) sum_(n=0)^oo alpha^n / sqrt(n!) | n ⟩,
  $
  and therefore:
  - the photon statistics are Poissonian: $P(n) = abs(⟨ n | alpha ⟩)^2 = e^(- abs(alpha)^2) abs(alpha)^(2 n) / n!$, with mean $bar(n) = abs(alpha)^2$;
  - the quadrature uncertainties are minimal: $Delta X Delta P = 1/4$;
  - the states are not orthogonal: $⟨ beta | alpha ⟩ = exp(- 1/2 (abs(alpha)^2 + abs(beta)^2 - 2 beta^"*" alpha))$.
] <thm:coherent-state-properties>

#proof(name: "Properties of Coherent States")[
  *Step 1 — Expand in number states.*
  Write $| alpha ⟩ = sum_n c_n | n ⟩$ and apply $hat(a)$: the eigenvalue equation forces $c_(n+1) = alpha c_n / sqrt(n + 1)$, giving $c_n = alpha^n / sqrt(n!) c_0$.
  *Step 2 — Normalize.*
  The normalization $sum | c_n |^2 = e^(abs(alpha)^2) | c_0 |^2 = 1$ fixes $c_0 = e^(- abs(alpha)^2 / 2)$.
  *Step 3 — Statistics.*
  Squaring $⟨ n | alpha ⟩$ yields the Poisson distribution; the quadrature variance follows from the Baker–Campbell–Hausdorff formula applied to the displacement operator.
]

#note[
  The coherent state is the quantum image of the classical field: its mean field $⟨ alpha | hat(E) | alpha ⟩$ oscillates sinusoidally with amplitude proportional to $abs(alpha)$, and its photon statistics are those of independent random emissions — exactly what a laser produces.
]

== Squeezed States // 压缩态

#definition(name: "Squeezed State")[
  Acting with the *squeeze operator*
  $
    hat(S)(zeta) = exp(1/2 (zeta^"*" hat(a)^2 - zeta (hat(a)^dagger)^2)), quad zeta = r e^(i phi),
  $
  on a coherent state gives the squeezed state $| zeta, alpha ⟩ = hat(S)(zeta) hat(D)(alpha)| 0 ⟩$.
] <def:squeezed-state>

#example(name: "Squeezed Vacuum")[ // 压缩真空
  The squeezed vacuum $| zeta, 0 ⟩$ contains only even numbers of photons: it is a superposition of $| 0 ⟩, | 2 ⟩, | 4 ⟩, dots.c$ with zero mean field but nonzero variance — the vacuum noise has been redistributed.
] <ex:squeezed-vacuum>

== Uncertainty Relations for Quadratures // 正交分量不确定性

#definition(name: "Quadrature Operators")[
  The *quadrature operators*
  $
    hat(X) = (hat(a) + hat(a)^dagger) / 2, quad hat(P) = (hat(a) - hat(a)^dagger) / (2 i),
  $
  satisfy $[hat(X), hat(P)] = i / 2$, hence the uncertainty relation
  $
    Delta X Delta P >= 1/4.
  $
] <def:quadrature-operators>

#property(name: "Squeezed Uncertainty")[
  For a squeezed state with squeeze parameter $r$ and $phi = 0$,
  $
    (Delta X)^2 = e^(-2 r) / 4, quad (Delta P)^2 = e^(2 r) / 4.
  $
  One variance falls below the *vacuum* variance $1/4$ (so that $Delta X < 1/2$ for that quadrature) while the product $Delta X Delta P >= 1/4$ stays saturated; squeezing redistributes the vacuum noise, it does not remove it.
  A state with $Delta X < 1/2$ has no classical counterpart and is a signature of nonclassical light.
] <prop:squeezed-uncertainty>

== Phase-Space Representations: The Wigner Function // 相空间表示与 Wigner 函数

#definition(name: "Wigner Function")[
  The *Wigner function* of a state $rho$ is the phase-space quasiprobability
  $
    W(x, p) = 1 / (pi planck) integral_(-oo)^oo ⟨ x + y/2 | rho | x - y/2 ⟩ e^(- i p y / planck) dif y,
  $
  normalized so that $integral.double W(x, p) dif x dif p = 1$.
] <def:wigner-function>

#note(title: "Negativity is nonclassical")[
  A coherent state has a positive Gaussian Wigner function; a single-photon state $| 1 ⟩$ has a Wigner function with a negative dip at the origin.
  Since a genuine classical probability must be nonnegative, negative values of $W$ certify nonclassical light — the quantum feature probed in homodyne tomography.
]

Coherent and number states are compared in phase space in @fig:wigner-function.

#figure(
  image("img/wigner-function.svg", width: 100%),
  caption: [Wigner functions: a coherent state (smooth Gaussian hump) versus a single-photon Fock state (negative dip at the origin).],
  placement: auto,
  supplement: [Fig.]
) <fig:wigner-function>

// --- Chapter 17: Photon Statistics and Correlation Functions (光子统计与关联函数) ---

= Photon Statistics and Correlation Functions <ch:photon-statistics> // 光子统计与关联函数

Chapters 15 and 16 built the quantum states of the field; measurement reveals them through photon statistics and correlation functions.
The first-order correlation governs interference (the quantum version of the coherence degree of #link(<ch:interference>)[Chapter 9]); the second-order correlation probes intensity correlations and separates classical from quantum light.

== Thermal, Poisson and Sub-Poisson Statistics // 热/泊松/亚泊松统计

#definition(name: "Photon Number Distribution")[
  The *photon number distribution* $P(n)$ is the probability of detecting $n$ photons of a given mode.
  - *Thermal light* (blackbody, incoherent sources): Bose–Einstein statistics,
    $
      P(n) = bar(n)^n / (bar(n) + 1)^(n + 1),
    $
    with variance $"Var"(n) = bar(n) + bar(n)^2$;
  - *Coherent light* (a laser far above threshold): Poisson statistics, $P(n) = e^(- bar(n)) bar(n)^n / n!$, with $"Var"(n) = bar(n)$;
  - *Number states*: $P(n) = delta_(n m)$ for $| m ⟩$, with $"Var"(n) = 0 < bar(n)$ — sub-Poisson statistics.
] <def:photon-number-distribution>

#theorem(name: "Thermal Statistics")[
  Thermal light is an incoherent mixture of coherent states with random phase: $rho = integral P(alpha)| alpha ⟩ ⟨ alpha | dif^2 alpha$ with the Gaussian $P$-function $P(alpha) = 1/(pi bar(n)) e^(- abs(alpha)^2 / bar(n))$.
  Averaging the Poisson distribution of $| alpha ⟩$ over this phase-space mixture yields the Bose–Einstein distribution above.
] <thm:thermal-statistics>

#note(title: "Classicality of Poisson statistics")[
  A Poisson distribution describes independent, random emissions; thermal light shows *super-Poisson* bunching ($"Var" > bar(n)$), while number states and other nonclassical states show *sub-Poisson* statistics ($"Var" < bar(n)$).
  Sub-Poisson light has no classical stochastic model.
]

== First- and Second-Order Correlation Functions // 一、二阶关联函数

#definition(name: "First-Order Correlation Function")[
  The normalized *first-order* correlation function is
  $
    g^((1))(tau) = (⟨ hat(a)^dagger (t) hat(a) (t + tau) ⟩) / (⟨ hat(a)^dagger hat(a) ⟩).
  $
] <def:first-order-correlation>

#definition(name: "Second-Order Correlation Function")[
  The normalized *second-order* correlation function is
  $
    g^((2))(tau) = (⟨ hat(a)^dagger (t) hat(a)^dagger (t + tau) hat(a) (t + tau) hat(a) (t) ⟩) / (⟨ hat(a)^dagger hat(a) ⟩^2).
  $
] <def:second-order-correlation>

#note[
  The first-order function is the quantum version of #link(<def:complex-coherence-degree>)[the complex degree of coherence] of #link(<ch:interference>)[Chapter 9]: its modulus $abs(g^((1))(tau))$ equals the fringe visibility in an interferometer.
  The second-order function measures the joint probability of detecting photons separated by $tau$ — insensitive to phase, but decisive for photon statistics.
]

#property(name: "Values of $g^((2))(0)$")[
  At zero delay, with $bar(n) = ⟨ hat(N) ⟩$,
  $
    g^((2))(0) = 1 + ("Var"(n) - bar(n)) / (bar(n)^2).
  $
  - Coherent light: $g^((2))(0) = 1$;
  - Thermal light: $g^((2))(0) = 2$ (bunching);
  - Number state $| n ⟩$: $g^((2))(0) = 1 - 1/n$ (antibunching).
] <prop:g2-values>

#note(title: "The classical bound")[
  For any classical stochastic field, the Cauchy–Schwarz inequality forces $g^((2))(0) >= 1$.
  A measured value $g^((2))(0) < 1$ therefore proves that the light has no classical description — a direct witness of nonclassicality.
]

== The Hanbury Brown-Twiss Experiment // 强度干涉实验

#definition(name: "HBT Setup")[
  In the Hanbury Brown–Twiss (HBT) experiment, light is split by a beam splitter, detected by two photodetectors, and the coincidences are counted as a function of the delay $tau$.
  The normalized coincidence rate measures exactly $g^((2))(tau)$.
] <def:hbt-setup>

#theorem(name: "Thermal Bunching")[
  For thermal light, $g^((2))(0) = 2$: photons arrive preferentially in bunches.
  The bunching peak decays to $g^((2))(tau) = 1$ over the coherence time $tau_c$ of #link(<ch:interference>)[Chapter 9].
] <thm:hbt-thermal>

The apparatus and the corresponding $g^((2))(tau)$ are drawn in @fig:hbt-experiment.

#figure(
  image("img/hbt-experiment.svg", width: 100%),
  caption: [Hanbury Brown–Twiss setup (beam splitter, two detectors, coincidence counter) and the bunching peak $g^((2))(tau)$ of thermal light.],
  placement: auto,
  supplement: [Fig.]
) <fig:hbt-experiment>

#note(title: "Intensity interferometry")[
  Because HBT measures intensity correlations rather than phase, it tolerates atmospheric turbulence: stellar interferometry measures the angular diameter of stars from the slit separation at which the bunching peak vanishes — the spatial-coherence idea of #link(<ch:interference>)[Chapter 9] in photon-counting form.
]

== Photon Antibunching and Single-Photon Sources // 反聚束与单光子源

#definition(name: "Antibunching")[
  A source exhibits *antibunching* when $g^((2))(0) < g^((2))(tau)$: successive photons are anticorrelated, arriving more regularly than a Poisson stream.
] <def:antibunching>

#definition(name: "Single-Photon Source")[
  A *single-photon source* emits exactly one photon per pulse, characterized by $g^((2))(0) -> 0$.
] <def:single-photon-source>

#example(name: "Single-Photon Emission")[ // 单光子源
  A single quantum dot or single molecule emits at most one photon per excitation cycle: the detector records $g^((2))(0) << 1$, the hallmark of antibunched, single-photon emission.
  Such sources are the building blocks of quantum key distribution (#link(<ch:applications>)[Chapter 19]); an alternative source is the pair production of spontaneous parametric down-conversion, where detecting one photon of a pair heralds the other.
] <ex:single-photon-source-example>

// --- Chapter 18: Light-Matter Interaction (光与物质相互作用) ---

= Light-Matter Interaction <ch:light-matter> // 光与物质相互作用

This chapter couples the quantized field (#link(<ch:field-quantization>)[Chapter 15]) to atoms.
Absorption and stimulated emission follow from a semiclassical treatment; spontaneous emission — an atom radiating with no driving field at all — requires the quantized vacuum, whose fluctuations (#link(<sec:vacuum-fluctuations>)[Section 15.4]) stimulate the decay.
The Jaynes–Cummings model is the simplest exactly solvable atom-field system, and the rate-equation laser theory closes the chapter.

== Two-Level Atoms and Rabi Oscillations // 二能级原子与拉比振荡

#definition(name: "Two-Level Atom")[
  An atom restricted to its ground state $| g ⟩$ and excited state $| e ⟩$, split by energy $planck omega_0$, is a two-level system with Hamiltonian
  $
    hat(H)_("at") = 1/2 planck omega_0 hat(sigma)_z,
  $
  where $hat(sigma)_z = | e ⟩ ⟨ e | - | g ⟩ ⟨ g |$.
  A classical field $E_0 cos(omega t)$ couples the levels through the dipole term $- bold(d) dot bold(E)$, and here $E_0$ denotes its *real peak amplitude*, so that the positive-frequency part carries the amplitude $E_0 / 2$.
] <def:two-level-atom>

#theorem(name: "Rabi Oscillations")[
  In the rotating-wave approximation, an atom initially in the ground state driven by a field detuned by $Delta = omega - omega_0$ has excitation probability
  $
    P_e (t) = (Omega_0^2) / (Omega^2) sin^2 (Omega t / 2),
  $
  with the generalized Rabi frequency
  $
    Omega = sqrt(Omega_0^2 + Delta^2), quad Omega_0 = (abs(bold(d)) E_0) / planck
  $
  for the real amplitude $E_0$ introduced above; the alternative convention in which $E_0$ denotes the positive-frequency complex amplitude doubles this value, and the two are related by the same factor 2 that turns the cavity coupling $g$ into the vacuum Rabi frequency $2 g$ of #link(<sec:jaynes-cummings>)[Section 18.3].
] <thm:rabi-oscillation>

#proof(name: "Rabi Oscillations")[
  *Step 1 — Schrödinger equation in the interaction picture.*
  Writing the state as $c_g (t)| g ⟩ + c_e (t) e^(- i omega_0 t)| e ⟩$ and applying the rotating-wave approximation (dropping the $2 omega$ terms), the amplitudes satisfy $dot(c)_e = - i Omega_0 / 2 e^(i Delta t) c_g$.
  *Step 2 — Solve the two-level system.*
  Eliminating $c_g$ gives a second-order equation for $c_e$; with $c_e (0) = 0$ the solution is the stated Rabi formula.
  *Step 3 — Interpret.*
  On resonance ($Delta = 0$), the population oscillates fully: $P_e (t) = sin^2 (Omega_0 t / 2)$; a pulse of duration $pi / Omega_0$ (a $pi$-pulse) inverts the atom completely.
] 

#example(name: "Rabi Flopping")[ // 拉比振荡
  A resonant pulse of area $Omega_0 t = pi$ transfers the atom from $| g ⟩$ to $| e ⟩$ with unit probability; a $pi/2$-pulse places it in the superposition $(| g ⟩ + | e ⟩) / sqrt(2)$.
] <ex:rabi-flopping>

Both regimes of the example are drawn in @fig:rabi-oscillation: on resonance the population is fully inverted and returns periodically, while a detuning leaves part of the population behind at every period.

#figure(
  image("img/rabi-oscillation.svg", width: 90%),
  caption: [Rabi oscillations: excitation probability $P_e (t)$ on resonance (full transfer) and at finite detuning (incomplete transfer at the generalized Rabi frequency $Omega$).],
  placement: auto,
  supplement: [Fig.]
) <fig:rabi-oscillation>

== Spontaneous Emission: Wigner-Weisskopf Theory // 自发辐射

An excited atom in otherwise empty space decays, emitting a photon — even though no classical field drives it.
The decay is stimulated by the vacuum fluctuations of #link(<sec:vacuum-fluctuations>)[Section 15.4].

#theorem(name: "Wigner-Weisskopf Decay")[
  Coupling the atom to the continuum of field modes yields exponential decay
  $
    P_e (t) = e^(- Gamma t),
  $
  with the spontaneous emission rate (Fermi's golden rule)
  $
    Gamma = (omega_0^3 abs(bold(d))^2) / (3 pi epsilon_0 planck c^3).
  $
] <thm:wigner-weisskopf>

#proof(name: "Wigner-Weisskopf Decay")[
  *Step 1 — Golden rule.*
  The transition rate into all final field states is $Gamma = (2 pi) / planck sum_f abs(⟨ f | hat(V) | i ⟩)^2 delta (E_f - E_i)$.
  *Step 2 — Dipole matrix element.*
  The coupling $hat(V) = - hat(bold(d)) dot hat(bold(E))$ gives $abs(⟨ g, 1_k | hat(V) | e, 0 ⟩)^2 = abs(bold(d))^2 (planck omega_k) / (2 epsilon_0 V)$.
  *Step 3 — Sum over modes.*
  The density of modes and the dipole orientation average produce the stated rate; the exponential decay follows from the Markov approximation on the amplitude.
]

#note[
  The quantum rate $Gamma$ is the field-quantized version of the classical Lorentz linewidth of #link(<ch:propagation-media>)[Chapter 12]: the damping $gamma$ of the Lorentz oscillator is the same physics — radiation reaction — seen semiclassically.
  The identification carries one caveat: $Gamma$ is the decay rate of the *population* (excited-state probability), whereas the Lorentz $gamma$ damps the dipole *amplitude*, so the two agree only up to the usual factor 2, $gamma = Gamma / 2$.
]

== The Jaynes-Cummings Model <sec:jaynes-cummings> // Jaynes-Cummings 模型

#definition(name: "Jaynes-Cummings Hamiltonian")[
  Quantizing the field (#link(<ch:field-quantization>)[Chapter 15]) and coupling it to the atom gives the *Jaynes–Cummings Hamiltonian*
  $
    hat(H) = planck omega hat(a)^dagger hat(a) + 1/2 planck omega_0 hat(sigma)_z + planck g (hat(a) hat(sigma)_+ + hat(a)^dagger hat(sigma)_-),
  $
  where $hat(sigma)_+ = | e ⟩ ⟨ g |$, $hat(sigma)_- = | g ⟩ ⟨ e |$, and $g$ is the atom-field coupling strength.
] <def:jaynes-cummings-hamiltonian>

#theorem(name: "Jaynes-Cummings Dynamics")[
  On resonance, the JC Hamiltonian couples only the pairs $| e, n ⟩ <-> | g, n + 1 ⟩$ with effective coupling $g sqrt(n + 1)$.
  The excited-state population oscillates at the vacuum Rabi frequency $2 g$ for $n = 0$; for a coherent initial field the oscillations collapse and revive on a longer time scale.
] <thm:jc-dynamics>

#note[
  The JC model is exactly solvable, which makes it the "hydrogen atom" of quantum optics: it predicts vacuum Rabi splitting, collapse and revival, and photon blockade — effects with no semiclassical explanation.
]

== Semiclassical Laser Theory <sec:semiclassical-laser> // 激光半经典理论

#definition(name: "Laser Rate Equations")[
  With populations $N_2$ (upper) and $N_1$ (lower), pump rate $R$, and field intensity $I$, the simplest rate equations are
  $
    (dif N_2) / (dif t) = R - Gamma N_2 - B (N_2 - N_1) I, quad (dif I) / (dif t) = B (N_2 - N_1) I - kappa I,
  $
  where $B$ is the stimulated-emission coefficient and $kappa$ the cavity loss rate.
] <def:laser-rate-equations>

#note(title: "Threshold")[
  Lasing begins when gain balances loss, $B (N_2 - N_1) = kappa$.
  The laser cavity selects the mode — the Fabry-Perot etalon of #link(<ch:interference>)[Chapter 9] with the stability condition of #link(<ch:matrix-optics>)[Chapter 7] — and the coherent field that emerges is, quantum-mechanically, a coherent state of #link(<ch:coherent-states>)[Chapter 16].
  The engineering details and applications are taken up in #link(<ch:applications>)[Chapter 19].
]

// --- Chapter 19: Applications and Frontiers (应用与前沿) ---

= Applications and Frontiers <ch:applications> // 应用与前沿

This concluding chapter is an introduction: it shows how the tools of Part IV become technology — lasers, quantum cryptography, entanglement — and marks the frontiers.
Each section is deliberately brief and points beyond this notebook.

== Lasers // 激光器

#definition(name: "Laser Principle")[
  A *laser* (light amplification by stimulated emission of radiation) amplifies light by stimulated emission in a gain medium inside an optical resonator.
  Above the threshold of #link(<sec:semiclassical-laser>)[Section 18.4], the cavity selects a single mode of the Fabry-Perot etalon (#link(<ch:interference>)[Chapter 9]) that satisfies the stability condition (#link(<ch:matrix-optics>)[Chapter 7]), and the output is a coherent state (#link(<ch:coherent-states>)[Chapter 16]).
] <def:laser-principle>

#example(name: "A Helium-Neon Laser")[ // 氦氖激光器
  A helium-neon laser at $lambda = 632.8 "nm"$ amplifies a neon transition of the $3 s -> 2 p$ family ($3 s_2 -> 2 p_4$ in Paschen notation); the cavity length selects the longitudinal mode, and the output linewidth is set by the cavity finesse — the same physics as the Fabry-Perot resolution of #link(<ch:interference>)[Chapter 9].
] <ex:laser-example>

#note[
  The laser is the physical realization of the coherent state: far above threshold its photon statistics are Poissonian (#link(<ch:photon-statistics>)[Chapter 17]), its field has a well-defined phase, and its spectrum is limited by phase diffusion.
]

== Quantum Key Distribution // 量子密钥分发

#definition(name: "Quantum Key Distribution")[
  *Quantum key distribution* (QKD) distributes a secret key between two parties using single photons.
  In the BB84 protocol, Alice encodes bits in four polarization states drawn from two conjugate bases ($H/V$ and $±45°$); Bob measures in a randomly chosen basis, and the two publicly compare bases to distill a key.
] <def:qkd>

#example(name: "BB84 and Eavesdropping")[ // BB84 与窃听
  An eavesdropper who measures a photon in the wrong basis disturbs it irreversibly, raising the error rate between Alice and Bob.
  A measured error above a threshold reveals the eavesdropper; combined with a one-time pad, the distilled key is unconditionally secure.
] <ex:bb84-protocol>

#note[
  QKD uses exactly the polarization states of #link(<ch:polarization>)[Chapter 13] and the single-photon sources of #link(<ch:photon-statistics>)[Chapter 17]: it is quantum optics made into cryptography.
]

== Photon Entanglement and Bell Tests <sec:bell-tests> // 光子纠缠与贝尔检验

#definition(name: "Entangled Photon Pair")[
  Two photons in the Bell state
  $
    | Phi^(+) ⟩ = (| H H ⟩ + | V V ⟩) / sqrt(2)
  $
  are *entangled*: the joint state cannot be factored into a product of single-photon states, and neither photon has a definite polarization of its own.
] <def:entangled-photon-pair>

#theorem(name: "Bell Inequality (CHSH)")[
  Any local hidden-variable theory satisfies the Clauser-Horne-Shimony-Holt inequality
  $
    S = E(a, b) - E(a, b') + E(a', b) + E(a', b') <= 2,
  $
  where $E(a, b)$ is the correlation of polarization measurements at settings $a, b$.
  Quantum entanglement predicts $S = 2 sqrt(2) > 2$ — a violation confirmed experimentally.
] <thm:bell-inequality>

#example(name: "Bell Test")[ // 贝尔检验
  Entangled photon pairs produced by spontaneous parametric down-conversion are sent to two distant detectors; rotating the polarization analyzers (#link(<ch:polarization>)[Chapter 13]) and accumulating coincidences yields $S approx 2.4$, violating the local bound and confirming entanglement.
] <ex:bell-test>

== Spontaneous Parametric Down-Conversion // 自发参量下转换

#definition(name: "Spontaneous Parametric Down-Conversion")[
  In a crystal with nonzero second-order susceptibility $chi^((2))$, a pump photon of frequency $omega_p$ can split into two lower-frequency photons (signal and idler) obeying energy and momentum (phase-matching) conservation:
  $
    omega_p = omega_s + omega_i, quad bold(k)_p = bold(k)_s + bold(k)_i.
  $
] <def:spdc>

#note(title: "Heralded single photons and entanglement")[
  Detecting the idler photon heralds the signal photon — a single-photon source of the type discussed in #link(<ch:photon-statistics>)[Chapter 17] — and the pair inherits the polarization correlations of #link(<sec:bell-tests>)[Section 19.3], the workhorse of quantum information experiments.
]

#note[
  This closes Part IV, and with it the whole notebook: from the vibrations of #link(<ch:oscillations>)[Chapter 1] through geometric and wave optics to the quantized field, the photon, and its entanglement, the four-part line — vibrations, rays, waves, quanta — is complete.
]
