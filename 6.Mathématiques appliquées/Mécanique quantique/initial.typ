#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Mécanique quantique",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Mécanique quantique",
  "Violet",
  subtitle: "A notebook for quantum mechanics",
  institute: "Notiz Physique",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This is a notebook for quantum mechanics.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
// 主线叙事：基础（旧量子论 + 数学语言 + 公设）→ 精确可解系统（一维/三维/自旋）→
//           方法（微扰/变分/WKB/散射）与多粒子 → 应用（核/粒子/固体/激光/超导）→ 进阶形式
//
// 教材基线：《大学物理》第 5 篇 量子物理（第 21 章 量子物理基础；第 22 章 原子核物理和
//           粒子物理简介；第 23 章 固体物理基础），机械工业出版社。
//           教材是知识点基线（必须全覆盖），但组织顺序按知识依赖重排；教材之外的标准
//           内容（形式体系深化、近似方法、散射、相对论量子力学、路径积分、量子信息）
//           作为 Part III 与 Part V 的扩展。
//
// 分 Part 依据（参考知名教材的分块方式）：
// - Griffiths, Introduction to Quantum Mechanics：12 章不分 Part，实际聚成
//   ①波函数与公设 ②一维/三维精确解（含角动量、氢原子、自旋）③全同粒子
//   ④近似方法（微扰/变分/WKB）⑤散射 ⑥相对论与专题
// - Sakurai, Modern Quantum Mechanics：7 章，①基本概念 ②量子动力学 ③角动量
//   ④对称性 ⑤近似方法 ⑥散射 ⑦全同粒子
// - Shankar, Principles of Quantum Mechanics：4 个 Part（数学基础 / 非相对论量子力学 /
//   近似方法 / 相对论量子力学），共 21 章
// - Cohen-Tannoudji, Mécanique quantique：卷 I 6 章（波与粒子 / 量子公设 / 一维势 /
//   ...），按「形式 → 应用」成对编排
// - 曾谨言《量子力学》：12 章，近似方法与散射居中，多粒子与场论收尾
// 共同结构是 4–5 个知识块：基础 → 精确解 → 方法（含多体）→ 应用 → 进阶。
// 本笔记取 5 Part、27 Chapter，与仓库其他笔记（Optique 4 Part、Électrodynamique 6 Part、
// Analyse Fonctionnelle 4 Part）的粒度一致，且 Part 内章数均衡（4/6/6/6/5）。
//
// 职责边界 (SRP Boundaries)：
// - 本笔记负责：量子力学公设与形式体系、Schrödinger 方程与精确解、角动量与自旋、
//   全同粒子、近似方法与散射、相对论量子力学与路径积分、量子信息；
//   以及教材第 22–23 章的核物理/粒子物理/固体/激光/超导导论（无其他笔记承担）。
// - 黑体辐射的统计推导（光子气体、Planck 公式、Stefan–Boltzmann、Wien、Rayleigh–Jeans）
//   → Thermodynamique §17.1–17.2；本笔记 Ch 1 仅作历史动机与结论引用
// - 光的量子性（Planck 定律、光电效应、Compton 散射）→ Optique §14.1–14.3；
//   本笔记 Ch 1 只复述结论并交叉引用，不重复推导
// - 电磁场量子化、Fock 态、光子统计、压缩态 → Optique Ch 15–17；
//   本笔记 §7.5 只保留抽象相干态（最小不确定态），场的量子化归 Optique
// - 激光速率方程与阈值条件 → Optique §19.1；本笔记 Ch 21 从原子物理层面讲
//   Einstein 系数与粒子数反转，激光器件细节引用 Optique
// - 量子密钥分发与光子纠缠实验 → Optique §19.2–19.3；本笔记 Ch 27 只讲抽象理论
// - Hilbert 空间/有界与无界算子/谱定理的完整证明 → Analyse Fonctionnelle；
//   本笔记 Ch 3 只陈述并直接使用
// - Fourier 变换、δ 函数与广义函数、Sobolev 空间 → Analyse Harmonique
// - 变分法、Hamilton 力学、Poisson 括号、Hamilton–Jacobi 理论 → Mécanique analytique；
//   本笔记 Ch 13（WKB）与 Ch 26（路径积分）直接引用其结论
// - 狭义相对论运动学与四维矢量 → Mécanique analytique Ch 19 / Électrodynamique Part VII；
//   本笔记 Ch 25 只引用
// - 量子统计分布（Bose–Einstein、Fermi–Dirac）→ Thermodynamique Ch 16–17；
//   本笔记 Ch 16 只引用其结论
//
// 与相关笔记的衔接：
// - Optique Part IV 明确要求本笔记提供 Hilbert 空间、算符与相干态的形式体系
//   （见 Optique 蓝图「职责边界」），故本笔记 Part I 必须自足，不能只留引用
// - Thermodynamique 第 17 章把 Planck 定律定位为「统计力学结果」，本笔记 Part I
//   把它定位为「量子论的历史起点」，两者视角互补，均在 Ch 1 交叉引用
// - Mécanique analytique 的 Hamilton–Jacobi 理论（Ch 14）与 WKB（本笔记 Ch 13）、
//   路径积分（本笔记 Ch 26）构成「经典—半经典—量子」三级对应
//
// 修订记录：
// - 2026-11-23 v1：7 Part / 27 章（旧量子论、数学与公设、一维、三维与自旋、近似与散射、
//   应用、进阶）。问题：Part 粒度过细，「旧量子论」与「数学与公设」其实同属基础块，
//   「精确解」被拆成一维与三维两块而中间缺少方法支撑。
// - 2026-11-23 v2（本版）：合并为 5 Part。旧 Part I + Part II → 新 Part I；旧 Part III +
//   Part IV → 新 Part II；旧 Part V + 旧 Ch 11（全同粒子）→ 新 Part III（Sakurai 的
//   「微扰 → 散射 → 全同粒子」顺序）；旧 Part VI → 新 Part IV；旧 Part VII → 新 Part V。
//   章内容与节划分不变，仅重排归属与编号。

// ==========================================================================
// Part I — Foundations: Waves, States and Postulates (量子论基础与公设)
// ==========================================================================
// 设计思路：把旧量子论、数学语言与五条公设收成一条连续论证链——
//           「经典物理为何失效 → 需要什么数学工具 → 用什么公设取代经典力学」。
//           教材 21.1–21.3.2 的知识点全部落在这里；光的量子性压缩为引用（Optique 已完整处理），
//           篇幅让给教材独有、且后续反复使用的 Bohr 模型与物质波。
//           Griffiths 把波函数、概率、不确定关系与旧量子论实验合为第 1 章，
//           Shankar 把数学基础单列 Part，本笔记取折中：四章同属一个基础 Part。
// 对应教材：21.1 量子论的出现；21.2 物质波与不确定关系；21.3.1–21.3.2 薛定谔方程与波函数条件

// --- Chapter 1: The Quantum Hypothesis (能量子假说与玻尔模型) ---

//   Section 1.1: Blackbody Radiation and Planck's Quantum Hypothesis (黑体辐射与普朗克能量子假说)
//     - 热辐射、黑体模型与基尔霍夫定律
//     - Stefan–Boltzmann 定律与 Wien 位移定律（引用 Thermodynamique §17.2）
//     - Rayleigh–Jeans 公式与紫外灾难（经典困难的定量表述）
//     - Planck 能量子假设、Planck 公式及其两个经典极限（推导引用 Optique §14.1）
//   Section 1.2: The Photoelectric Effect and Light Quanta (光电效应与光量子)
//     - 光电效应的实验规律：截止电压、红限频率、瞬时性、光强无关性
//     - Einstein 光量子假设与光电方程，逸出功与截止电压的测量
//     - 光子的能量与动量，Compton 散射（结论与公式引用 Optique §14.2–14.3）
//   Section 1.3: Atomic Spectra and Bohr's Model (原子光谱与玻尔氢原子理论)
//     - 氢原子光谱系（Lyman、Balmer、Paschen）与 Rydberg 公式、组合原理
//     - Rutherford 核式模型与经典电动力学的稳定性困难
//     - Bohr 三条假设：定态假设、频率条件、角动量量子化
//     - 轨道半径、能级公式、电离能与 Rydberg 常数的导出
//     - Franck–Hertz 实验：能级分立的直接验证
//     - 对应原理（大 n 极限）与旧量子论的局限（为何需要波动方程）

// --- Chapter 2: Matter Waves and the Uncertainty Principle (物质波与不确定关系) ---

//   Section 2.1: De Broglie Matter Waves (德布罗意物质波)
//     - de Broglie 关系 λ = h/p、ν = E/h 及其相对论形式
//     - 电子衍射实验（Davisson–Germer）与双缝干涉
//     - 实物粒子的波粒二象性、互补原理
//     - Bohr 量子化条件的物质波解释（驻波条件）
//   Section 2.2: Wave Packets and Dispersion (波包与色散)
//     - 波包构造：平面波的叠加、Fourier 频谱（引用 Analyse Harmonique）
//     - 相速度与群速度、de Broglie 波的色散关系
//     - 波包扩散与「粒子」定位的困难
//   Section 2.3: The Heisenberg Uncertainty Relation (海森堡不确定关系)
//     - Δx·Δp ≥ ℏ/2 的表述与量级估计
//     - 单缝衍射与 γ 射线显微镜：测量论证
//     - 能量-时间不确定关系与能级自然宽度
//     - 零点能与定态稳定性的定性推论
//     - 从经典轨迹到概率描述：为何需要波函数（过渡到 Ch 3–4）

// --- Chapter 3: The Mathematical Language of Quantum Mechanics (量子力学的数学语言) ---

//   Section 3.1: State Vectors and Dirac Notation (态矢量与狄拉克符号)
//     - ket/bra、内积、范数、正交归一系
//     - 态空间即平方可积函数空间 L²（完备性证明引用 Analyse Fonctionnelle）
//     - 连续基与 δ 函数归一化
//   Section 3.2: Linear Operators and Their Algebra (线性算符及其代数)
//     - 线性算符、算符的加法/数乘/乘积、对易子与反对易子
//     - Hermite（自伴）算符与实本征值、正交本征函数系
//     - 幺正算符与内积保持、投影算符与正交分解
//   Section 3.3: Eigenvalue Problems and Spectral Decomposition (本征值问题与谱分解)
//     - 本征值、本征态、简并与本征子空间
//     - 分立谱与连续谱、谱定理（陈述，不证明）
//     - 完备性关系（closure relation）与单位分解
//   Section 3.4: Functions of Operators and Commutators (算符函数与对易关系)
//     - 算符函数、指数算符、时间演化算符 U(t)
//     - 对易子与相容可观测量、共同本征态
//     - 不确定性关系的一般形式（对易子的直接推论，详细推导见 §4.6）
//   Section 3.5: Representations and Basis Transformations (表象与基变换)
//     - 坐标表象与动量表象、波函数作为态矢量的投影
//     - 基变换、幺正矩阵、变换算符
//     - Fourier 变换即坐标表象与动量表象之间的幺正变换（引用 Analyse Harmonique）

// --- Chapter 4: Postulates of Quantum Mechanics (量子力学公设) ---

//   Section 4.1: The State Postulate (态公设与波函数)
//     - 微观态由波函数（态矢量）完全描述
//     - 波函数的标准条件：单值、有限、连续、平方可积
//     - 归一化条件与相对概率解释
//   Section 4.2: Observables as Hermitian Operators (可观测量与厄米算符)
//     - 可观测量 ↔ 厄米算符；力学量的算符化规则
//     - 位置、动量、角动量、Hamilton 量算符
//   Section 4.3: Measurement and Probability (测量与概率)
//     - 本征值即可能的测量值、Born 概率解释
//     - 期望值、方差与不确定度
//     - 测量塌缩、重复测量的可复现性
//     - 相容与不相容可观测量的测量次序
//   Section 4.4: Time Evolution and the Schrödinger Equation (时间演化与薛定谔方程)
//     - 时间演化算符与无穷小生成元
//     - 含时 Schrödinger 方程、定态与能量本征态
//     - 守恒量与概率守恒（连续性方程见 §5.2）
//   Section 4.5: The Superposition Principle (叠加原理)
//     - 线性叠加、干涉项与相位
//     - 叠加态与测量塌缩的关系、宏观可区分性
//   Section 4.6: The General Uncertainty Relation (一般不确定关系)
//     - Robertson 不等式、对易子与不确定度的定量关系
//     - 最小不确定态、Gaussian 波包
//     - 能量-时间关系的严格地位（非对易子推论）

// ==========================================================================
// Part II — Exactly Solvable Systems (精确可解系统)
// ==========================================================================
// 设计思路：教材 21.3.3–21.6.1 的主体，一条「从一维到三维、从无自旋到有自旋」的
//           精确解链：求解流程（Ch 5）→ 方势/δ 势（Ch 6）→ 谐振子（Ch 7）→
//           角动量与中心势（Ch 8）→ 氢原子（Ch 9）→ 自旋（Ch 10）。
//           Ch 8 先立角动量，氢原子只是其最重要的应用，避免旧设计里「氢原子章顺便讲角动量」。
//           轨道磁矩/正常塞曼留在 §9.5（未微扰图像），反常塞曼与精细结构移入 §11.4–11.5。
//           自由粒子与波包并入 §2.2 与 §5.4，一维散射并入 §6.3–6.6，不再单列。
// 对应教材：21.3.3 一维无限深方势阱；21.3.4 方势垒与隧道效应；21.4 一维线性谐振子；
//           21.5 氢原子的量子理论；21.6.1 施特恩-格拉赫实验与电子自旋

// --- Chapter 5: The Schrödinger Equation and Stationary States (薛定谔方程与定态) ---

//   Section 5.1: The Time-Independent Schrödinger Equation (定态薛定谔方程)
//     - 从平面波到波动方程的启发式建立、分离变量
//     - 定态、能量本征值问题的提法
//     - 一维求解流程：分区、通解、边界匹配、归一化
//   Section 5.2: Probability Current and Continuity (概率流与连续性方程)
//     - 概率流密度 j 与连续性方程
//     - 定态的概率流、实波函数与驻波图像
//   Section 5.3: Boundary and Normalization Conditions (边界条件与归一化)
//     - ψ 与 ψ′ 的连续性、势跃变处的匹配条件
//     - δ 势的导数跃变条件（预告 §6.5）
//     - 束缚态与散射态的判定标准
//   Section 5.4: The Free Particle and Wave Packets (自由粒子与波包)
//     - 平面波解、连续谱与 δ 归一化
//     - Gaussian 波包的时间演化、扩散与相干长度
//   Section 5.5: The Classical Limit: Ehrenfest Theorem (经典极限：埃伦费斯特定理)
//     - Ehrenfest 定理与 Newton 方程的期望值形式
//     - 对应原理的定量表述

// --- Chapter 6: One-Dimensional Potentials (一维势场) ---

//   Section 6.1: The Infinite Square Well (一维无限深方势阱)
//     - 能级量子化公式、波函数与节点数
//     - 零点能、宇称、正交完备性
//     - 与经典概率密度对比（大 n 极限）
//   Section 6.2: The Finite Square Well (有限深方势阱)
//     - 分区解与超越方程、束缚态数目与阱深/阱宽的关系
//     - 阱外指数衰减与穿透深度
//     - 无限深极限的回归
//   Section 6.3: Potential Step, Barrier and Tunneling (势阶、方势垒与隧道效应)
//     - E > V 与 E < V 的反射/透射系数
//     - 方势垒透射系数、薄垒/高垒近似、共振透射
//   Section 6.4: Tunneling Phenomena and Applications (隧道效应的应用)
//     - 扫描隧道显微镜（STM）与隧道电流的指数依赖
//     - α 衰变（与 §13.4 的 Gamow 因子呼应）
//     - 半导体隧道二极管、核聚变中的库仑势垒穿透
//   Section 6.5: The Delta-Function Potential (δ 函数势)
//     - δ 势的束缚态（唯一束缚态）与导数跃变
//     - δ 势散射：透射/反射系数
//   Section 6.6: Bound and Scattering States (束缚态与散射态)
//     - 两类态的光谱特征（分立 vs 连续）、边界条件差异
//     - 一维散射的 S 矩阵与共振（预告 Ch 15）

// --- Chapter 7: The Harmonic Oscillator (一维线性谐振子) ---

//   Section 7.1: The Oscillator Potential (谐振子的势函数)
//     - 经典振子回顾、抛物线近似与 Taylor 展开
//     - 无量纲化与特征长度/能量尺度
//   Section 7.2: Analytic Solution and Hermite Polynomials (解析解与厄米多项式)
//     - 级数解法、截断条件与能级量子化
//     - Hermite 多项式、归一化波函数
//   Section 7.3: Ladder Operators (升降算符方法)
//     - a、a† 的定义与对易关系
//     - 能级量子化公式、零点能
//     - 矩阵元与代数求解的优越性
//   Section 7.4: Wave Functions and Probability Densities (能级、波函数与概率密度)
//     - 各能级波函数图形、经典禁区内的指数衰减
//     - 概率密度随 n 的演化与对应原理
//   Section 7.5: Coherent States (相干态)
//     - 相干态的定义（湮灭算符本征态）、最小不确定性
//     - 与经典振子轨道的对应；场的相干态（压缩态）引用 Optique Ch 16
//   Section 7.6: Applications: Molecules and Phonons (应用：双原子分子与声子)
//     - 双原子分子振动光谱与零点能
//     - 声子、固体比热（引用 Thermodynamique §17.3）

// --- Chapter 8: Angular Momentum and Central Potentials (角动量与中心势) ---

//   Section 8.1: Separation of Variables in Spherical Coordinates (球坐标下的分离变量)
//     - 中心势的一般形式、球坐标 Laplacian
//     - 径向与角向变量的分离、角量子数的出现
//   Section 8.2: Angular Momentum Operators (角动量算符)
//     - L 算符的坐标表示、对易关系
//     - 升降算符 L± 与阶梯结构
//   Section 8.3: Eigenvalues and Spherical Harmonics (本征值与球谐函数)
//     - L²、L_z 的本征值与本征函数
//     - 球谐函数、角动量量子化的几何（矢量模型）
//   Section 8.4: The Radial Equation and Effective Potential (径向方程与有效势)
//     - u(r) = rR(r) 的一维化、离心势
//     - 原点与无穷远的渐近行为、边界条件
//   Section 8.5: Three-Dimensional Wells and Degeneracy (三维势阱与简并)
//     - 三维无限深方势阱的能级与简并度
//     - 对称性与简并的关系（预告 §24.3）

// --- Chapter 9: The Hydrogen Atom (氢原子) ---

//   Section 9.1: The Coulomb Potential and Radial Equation (库仑势与径向方程)
//     - 库仑势、无量纲化、渐近解与级数解
//   Section 9.2: Laguerre Polynomials and Radial Functions (拉盖尔多项式与径向函数)
//     - 截断条件与主量子数 n 的来源
//     - 径向波函数、归一化
//   Section 9.3: Energy Levels, Quantum Numbers and Degeneracy (能级、量子数与简并度)
//     - 能级公式（重现 Bohr 结果）、n/l/m 的取值与物理意义
//     - n² 重简并与库仑势的「偶然简并」
//   Section 9.4: Probability Distributions and the Electron Cloud (概率分布与电子云)
//     - 径向分布函数、最可几半径、平均半径
//     - 角分布与 s/p/d 轨道形状、电子云图像
//   Section 9.5: Orbital Magnetic Moment and the Normal Zeeman Effect (轨道磁矩与正常塞曼效应)
//     - 轨道磁矩、Bohr 磁子、Larmor 进动
//     - 正常 Zeeman 效应（能量移动的微扰处理见 §11.5）

// --- Chapter 10: Spin (电子自旋) ---

//   Section 10.1: The Stern-Gerlach Experiment (施特恩-格拉赫实验)
//     - 实验装置与结果：空间量子化的直接证据
//     - 碱金属基态的双线结构 → 自旋假设
//   Section 10.2: Spin Operators and Pauli Matrices (自旋算符与泡利矩阵)
//     - S²、S_z 的本征值与自旋量子数
//     - Pauli 矩阵、自旋态、Bloch 球表示
//   Section 10.3: Spin Precession and Magnetic Resonance (自旋进动与磁共振)
//     - 磁场中的 Larmor 进动、自旋态的时间演化
//     - 磁共振（NMR/MRI）的基本原理
//   Section 10.4: Addition of Angular Momenta (角动量耦合)
//     - 角动量相加、Clebsch–Gordan 系数
//     - 单态与三重态、自旋-轨道耦合与总角动量 J
//   Section 10.5: The Anomalous Zeeman Effect (反常塞曼效应)
//     - Landé g 因子、反常 Zeeman 分裂
//     - Paschen–Back 效应（强弱场过渡，详见 §11.5）

// ==========================================================================
// Part III — Approximation, Scattering and Many-Particle Systems (近似、散射与多粒子)
// ==========================================================================
// 设计思路：教材不涉及的「解不出精确解时怎么办」，同时承接多粒子问题。
//           顺序取自 Sakurai：微扰（Ch 11–12 定态/变分）→ 半经典（Ch 13 WKB）→
//           含时微扰与辐射（Ch 14）→ 散射（Ch 15）→ 全同粒子（Ch 16）。
//           把「全同粒子与多电子原子」放在本 Part 末尾的理由：
//           ① 交换能与 Hartree–Fock 需要先有 §12.4–12.5 的变分方法；
//           ② 电子排布与周期表需要 Ch 10 的自旋与 Pauli 原理；
//           ③ 它同时是 Part IV（核壳层、费米海、能带填充）的直接前提。
// 对应教材：扩展内容（超出教材第 21–23 章范围）；Ch 16 覆盖教材 21.6.2

// --- Chapter 11: Time-Independent Perturbation Theory (不含时微扰理论) ---

//   Section 11.1: Non-degenerate Perturbation Theory (非简并微扰理论)
//     - 一级与二级能量修正、一级波函数修正
//     - 微扰级数的收敛性与适用条件
//   Section 11.2: Degenerate Perturbation Theory (简并微扰理论)
//     - 简并子空间内的对角化、好量子数的选取
//     - 「微扰解除简并」的一般机制
//   Section 11.3: The Stark Effect (斯塔克效应)
//     - 基态（二级效应）与激发态（一级线性效应）
//     - 氢原子 Stark 效应与抛物线坐标
//   Section 11.4: Fine Structure of Hydrogen (氢原子的精细结构)
//     - 相对论动能修正、自旋-轨道耦合、Darwin 项
//     - 精细结构公式与能级移动的量级
//   Section 11.5: The Zeeman Effect (塞曼效应)
//     - 弱场（反常 Zeeman，Landé g 因子）与强场（Paschen–Back）
//     - 与 §9.5、§10.5 的分工

// --- Chapter 12: The Variational Method (变分法) ---

//   Section 12.1: The Variational Principle (变分原理)
//     - 能量泛函、基态能量上界定理
//   Section 12.2: Trial Wave Functions and Bounds (试探波函数与能量上界)
//     - 试探函数的构造原则、标度变换
//   Section 12.3: The Linear Variational Method (线性变分法)
//     - 基组展开、久期方程与广义本征值问题
//   Section 12.4: Application: The Helium Atom (应用：氦原子)
//     - 有效核电荷、屏蔽效应、基态能量估计
//   Section 12.5: The Hartree-Fock Idea (哈特里-福克方法概要)
//     - 自洽场、Slater 行列式与平均场
//     - 与 §16.4 电子排布、§20.2 能带理论的衔接

// --- Chapter 13: The WKB Approximation (WKB 半经典近似) ---

//   Section 13.1: The Semiclassical Expansion (半经典展开)
//     - ℏ 展开、缓变势条件
//   Section 13.2: WKB Wave Functions (WKB 波函数)
//     - 经典允许区与禁区中的解、指数因子
//   Section 13.3: Connection Formulas and Quantization (连接公式与量子化条件)
//     - 转折点附近的 Airy 函数匹配、Bohr–Sommerfeld 量子化
//   Section 13.4: Tunneling and Alpha Decay (隧穿与 α 衰变)
//     - Gamow 因子、势垒穿透概率的指数律
//     - 与 §6.4 的呼应、与 Mécanique analytique Ch 14 的经典极限对应

// --- Chapter 14: Time-Dependent Perturbation Theory and Radiation (含时微扰与辐射) ---

//   Section 14.1: The Interaction Picture and the Perturbation Series (相互作用绘景与微扰级数)
//     - 相互作用绘景（完整讨论见 §23.1）
//     - 一阶含时微扰解、跃迁振幅
//   Section 14.2: Transition Probabilities (跃迁概率)
//     - 跃迁概率的一阶表达式、长时间极限
//   Section 14.3: Fermi's Golden Rule (费米黄金规则)
//     - 态密度、跃迁速率
//   Section 14.4: Harmonic Perturbations and Selection Rules (简谐微扰与选择定则)
//     - 共振吸收/受激辐射、偶极近似
//     - 电偶极选择定则 Δl = ±1、Δm = 0, ±1
//   Section 14.5: Einstein Coefficients and Radiative Transitions (爱因斯坦系数与辐射跃迁)
//     - A、B 系数及其相互关系、自发辐射的量子解释
//     - 与 Ch 21（激光）的衔接
//   Section 14.6: Adiabatic and Sudden Approximations (绝热近似与突然近似)
//     - 绝热定理与 Berry 相位（简述，深入待专题）
//     - 突然近似与量子淬火

// --- Chapter 15: Scattering Theory (散射理论) ---

//   Section 15.1: Cross Sections and the Scattering Amplitude (散射截面与散射振幅)
//     - 微分截面、总截面、入射/散射流
//     - 一维散射的反射与透射系数（复用 §6.3）
//   Section 15.2: Partial Wave Analysis and Phase Shifts (分波分析与相移)
//     - 球面波展开、相移 δ_l、分波截面
//   Section 15.3: The Born Approximation (玻恩近似)
//     - 一阶 Born 振幅、Yukawa/Coulomb 势的散射
//   Section 15.4: The Optical Theorem (光学定理)
//     - 前向散射振幅与总截面的关系
//   Section 15.5: Low-Energy Scattering and the Scattering Length (低能散射与散射长度)
//     - s 波主导、散射长度、束缚态判据

// --- Chapter 16: Identical Particles and Many-Electron Atoms (全同粒子与多电子原子) ---

//   Section 16.1: Indistinguishability and Exchange Symmetry (全同粒子与交换对称性)
//     - 不可分辨性、交换算符与对称/反对称波函数
//     - 交换简并的消除（与 §12.4 氦原子衔接）
//   Section 16.2: Bosons, Fermions and the Pauli Principle (玻色子、费米子与泡利原理)
//     - 自旋-统计定理、Pauli 不相容原理
//     - 费米海与填充规则；Bose 凝聚（引用 Thermodynamique Ch 17）
//   Section 16.3: Helium and the Exchange Interaction (氦原子与交换相互作用)
//     - 氦原子能级、正氦与仲氦
//     - 交换能的来源及其对 Hund 规则的影响
//   Section 16.4: Electronic Configuration and the Periodic Table (电子排布与元素周期表)
//     - 四个量子数 (n, l, m_l, m_s) 与壳层/次壳层容量
//     - 能级次序、填充顺序与 Hund 规则
//     - 原子半径、电离能的周期性；元素周期表的结构解释
//   Section 16.5: Molecules and the Chemical Bond (分子与化学键)
//     - H₂⁺ 与 LCAO 近似、成键/反键轨道
//     - 共价键的量子力学解释；分子光谱（转动/振动/电子）

// ==========================================================================
// Part IV — Quantum Physics Applications: Nuclei, Particles and Solids (量子物理应用)
// ==========================================================================
// 设计思路：教材第 22–23 章的完整覆盖。这些内容属于「量子力学的应用与延伸」，
//           没有其他笔记承担（Thermodynamique 只做光子气体，Optique 只做激光的
//           场论/速率方程），故由本笔记以导论深度承担：保留教材结论与量级估计，
//           不展开量子场论、多体理论、BCS 推导细节。
//           排列「核 → 粒子 → 固体 → 激光 → 超导」与教材一致；激光放在固体之后，
//           因为受激辐射需要 §14.5 与 Ch 20 的能带图像。
//           本 Part 是全书唯一的「应用段」，前三个 Part 提供语言、解与方法。
// 对应教材：22.1 原子核的基本性质；22.2 结合能与放射性衰变；22.3 粒子物理简介；
//           23.1 固体的能带结构；23.2 半导体、绝缘体、导体；23.3 激光原理；23.4 超导电性

// --- Chapter 17: Basic Properties of Nuclei (原子核的基本性质) ---

//   Section 17.1: The Proton-Neutron Model (质子-中子模型)
//     - 核素、同位素、同量异位素；核半径与核密度
//     - 核的组成与电荷数/质量数
//   Section 17.2: Nuclear Spin and Magnetic Moments (核自旋与磁矩)
//     - 核自旋、核磁矩与核磁子
//     - 磁共振与 MRI 的物理基础（与 §10.3 衔接）
//   Section 17.3: The Nuclear Force (核力)
//     - 核力的短程性、饱和性、电荷无关性
//     - 核力的介子交换图像（定性）

// --- Chapter 18: Binding Energy and Radioactivity (结合能与放射性衰变) ---

//   Section 18.1: Mass Defect and Binding Energy (质量亏损与结合能)
//     - 质量亏损、结合能、平均结合能曲线
//     - 裂变与聚变的能量来源解释
//   Section 18.2: Nuclear Stability and Decay Modes (核的稳定性与衰变类型)
//     - 稳定核素图、中子-质子比
//     - α、β、γ 衰变及其守恒律
//   Section 18.3: The Radioactive Decay Law (放射性衰变定律)
//     - 指数衰变律、半衰期、平均寿命、活度
//     - 放射性定年（¹⁴C）与示踪应用
//   Section 18.4: Nuclear Fission and Fusion (核裂变与核聚变)
//     - 链式反应、临界质量、反应堆基本原理
//     - 聚变条件与太阳能源（与 §6.4 隧穿衔接）

// --- Chapter 19: Elementary Particles (粒子物理简介) ---

//   Section 19.1: Particle Properties and the Four Interactions (粒子特征与四种相互作用)
//     - 质量、电荷、自旋、寿命；四种基本相互作用的比较
//   Section 19.2: Classification of Particles (粒子的分类)
//     - 轻子、强子、规范玻色子；反粒子与粒子-反粒子对称
//   Section 19.3: Quarks and Hadron Structure (夸克与强子结构)
//     - 夸克的种类与电荷、色荷与禁闭
//     - 介子与重子的夸克组成
//   Section 19.4: Unification of Interactions (相互作用的统一)
//     - 电弱统一、大统一设想、标准模型的地位与局限

// --- Chapter 20: Electrons in Solids (固体中的电子) ---

//   Section 20.1: Crystal Structure and Classification (晶体结构与分类)
//     - 晶格、基元、Bravais 格子；单晶/多晶/非晶
//     - 密堆积与常见晶体结构
//   Section 20.2: The Origin of Energy Bands (能带的形成)
//     - 周期势中的电子、Bloch 定理（陈述）
//     - 能级分裂 → 能带 → 能隙；紧束缚与近自由电子图像
//   Section 20.3: Metals, Semiconductors and Insulators (导体、半导体与绝缘体)
//     - 能带填充、Fermi 能级、带隙宽度
//     - 三类固体的能带判据与电导率量级
//   Section 20.4: Doped Semiconductors (杂质半导体)
//     - 施主/受主、n 型与 p 型半导体
//     - 载流子浓度与温度依赖
//   Section 20.5: The p-n Junction and Devices (p-n 结与半导体器件)
//     - 接触势垒、耗尽层、正向/反向偏置
//     - 二极管、晶体管、太阳能电池、LED 的工作原理

// --- Chapter 21: Lasers (激光原理) ---

//   Section 21.1: Absorption, Spontaneous and Stimulated Emission (吸收、自发辐射与受激辐射)
//     - 三种基本过程的 Einstein 系数描述（复用 §14.5）
//   Section 21.2: Population Inversion and Optical Cavities (粒子数反转与光学谐振腔)
//     - 粒子数反转的实现（三能级/四能级）
//     - 谐振腔模式选择、阈值条件（细节引用 Optique §19.1）
//   Section 21.3: Laser Systems (激光器)
//     - 红宝石激光器、He–Ne 激光器、半导体激光器
//   Section 21.4: Properties of Laser Light (激光的特性)
//     - 单色性、方向性、相干性、高亮度
//   Section 21.5: Applications of Lasers (激光的应用)
//     - 加工、医疗、通信、信息存储、惯性约束聚变、量子技术

// --- Chapter 22: Superconductivity (超导电性) ---

//   Section 22.1: Basic Properties of Superconductors (超导的基本特性)
//     - 零电阻、Meissner 效应、临界温度/磁场/电流
//     - 超导体的电磁响应（London 方程，定性）
//   Section 22.2: BCS Theory and Cooper Pairs (BCS 理论与库珀对)
//     - 电子-声子相互作用、Cooper 对、能隙
//     - 同位素效应与比热跃变
//   Section 22.3: Classification of Superconductors (超导材料的分类)
//     - 第 I 类与第 II 类超导体、混合态与磁通涡旋
//     - 高温超导的现状与新动向
//   Section 22.4: The Josephson Effects (约瑟夫孙效应)
//     - 直流与交流 Josephson 效应、Josephson 结
//     - SQUID、电压基准、超导量子比特
//   Section 22.5: Applications of Superconductivity (超导的应用)
//     - 超导磁体、MRI、输电、磁悬浮、量子计算

// ==========================================================================
// Part V — Advanced Formalisms and Topics (进阶形式与专题)
// ==========================================================================
// 设计思路：教材范围之外的自洽进阶段，可在 Part I–IV 完成后按需写作。
//           顺序为「形式 → 对称性 → 相对论 → 路径积分 → 信息」：先把绘景、密度矩阵、
//           对称性讲清（Ch 23–24），再进入相对论量子力学（Ch 25）、路径积分（Ch 26），
//           最后用量子信息收束（Ch 27）。
//           原设计（7 Part 版）把路径积分、相对论量子力学、量子信息塞在同一 Part，
//           并在其前另设「量子动力学与相干态」章；该章内容已拆解：
//           相干态归 §7.5、Berry 相位归 §14.6、波包演化归 §5.4。
// 对应教材：扩展内容，标注「进阶、可选」

// --- Chapter 23: Pictures of Quantum Mechanics and the Density Matrix (绘景与密度矩阵) ---

//   Section 23.1: Schrödinger, Heisenberg and Interaction Pictures (三种绘景)
//     - 态与算符的分工、三者的等价性
//     - Heisenberg 运动方程
//   Section 23.2: The Density Operator: Pure and Mixed States (密度算符：纯态与混合态)
//     - 密度算符的定义与性质、纯态判据
//     - 系综诠释、部分迹与约化密度矩阵
//   Section 23.3: Measurement, Decoherence and the Classical Limit (测量、退相干与经典极限)
//     - 测量问题的诸诠释、环境诱导退相干
//     - 宏观可区分性与经典世界的涌现
//   Section 23.4: Entropy and Entanglement Measures (熵与纠缠度量)
//     - von Neumann 熵、纠缠熵
//     - 与 §27.2 的衔接

// --- Chapter 24: Symmetry and Conservation Laws (对称性与守恒律) ---

//   Section 24.1: Symmetry Transformations and Unitary Operators (对称变换与幺正算符)
//     - 变换群与 Wigner 定理（陈述）
//   Section 24.2: Translation Symmetry and Momentum Conservation (平移对称性与动量守恒)
//     - 平移算符、生成元与动量
//   Section 24.3: Rotation Symmetry and Angular Momentum (旋转对称性与角动量守恒)
//     - 转动算符、角动量作为生成元、简并与对称性的关系
//   Section 24.4: Parity and Time Reversal (宇称与时间反演)
//     - 宇称算符、宇称选择定则
//     - 时间反演与 Kramers 简并
//   Section 24.5: Noether's Theorem in Quantum Mechanics (量子力学中的诺特定理)
//     - 连续对称性 → 守恒量；与 Mécanique analytique Ch 10 的对应

// --- Chapter 25: Relativistic Quantum Mechanics (相对论量子力学) ---

//   Section 25.1: The Klein-Gordon Equation (克莱因-戈尔登方程)
//     - 相对论能量-动量关系、Klein–Gordon 方程的困难
//   Section 25.2: The Dirac Equation (狄拉克方程)
//     - Dirac 方程的建立、协变形式与自由粒子解
//   Section 25.3: Dirac Matrices, Spinors and Spin (狄拉克矩阵、旋量与自旋)
//     - γ 矩阵代数、四分量旋量
//     - 自旋 1/2 的内禀起源
//   Section 25.4: Antiparticles and Hole Theory (反粒子与空穴理论)
//     - 负能态、正电子、粒子-反粒子对称
//   Section 25.5: The Non-Relativistic Limit and the Pauli Equation (非相对论极限与泡利方程)
//     - 从 Dirac 到 Pauli 方程、自旋-轨道耦合的自动出现

// --- Chapter 26: The Path Integral Formulation (路径积分表述) ---

//   Section 26.1: Propagators and Green's Functions (传播子与格林函数)
//     - 时间演化核、传播子的性质与合成
//   Section 26.2: Feynman's Path Integral (费曼路径积分)
//     - 路径求和的定义、作用量权重
//     - 与 Schrödinger 方程的等价性
//   Section 26.3: The Classical Limit and Stationary Phase (经典极限与稳定相位)
//     - ℏ → 0、驻相近似、经典路径的主导地位
//   Section 26.4: Free Particle and Harmonic Oscillator (自由粒子与谐振子的路径积分)
//     - Gaussian 路径积分的精确计算
//   Section 26.5: Semiclassical Expansion and the WKB Limit (半经典展开与 WKB 极限)
//     - 与 Ch 13 的对应、隧穿的瞬子图像（简述）

// --- Chapter 27: Quantum Information and Entanglement (量子信息与纠缠) ---

//   Section 27.1: Qubits and Quantum Gates (量子比特与量子门)
//     - 二能级系统作为 qubit、Bloch 球、单/双比特门
//   Section 27.2: Entanglement and Bell States (纠缠与贝尔态)
//     - 张量积结构、四个 Bell 态
//   Section 27.3: Bell's Inequality and the EPR Paradox (贝尔不等式与 EPR 佯谬)
//     - EPR 论证、定域隐变量、CHSH 不等式与实验判决
//   Section 27.4: Quantum Teleportation (量子隐形传态)
//     - 传态协议、经典通信的必要性
//   Section 27.5: Quantum Computing and Cryptography (量子计算与量子密码)
//     - 量子并行、Deutsch–Jozsa/Grover/Shor 概览
//     - 量子密钥分发（光学实现引用 Optique §19.2）

// ==========================================================================
// 教材覆盖度映射 (Textbook Coverage)
// ==========================================================================
// | 教材位置 | 知识点 | 本笔记位置 | 备注 |
// |---|---|---|---|
// | 21.1.1 | 黑体辐射、Planck 能量子 | §1.1 | 推导引用 Optique §14.1 / Thermodynamique §17 |
// | 21.1.2 | 光电效应、光量子 | §1.2 | 引用 Optique §14.2 |
// | 21.1.3 | 玻尔氢原子理论 | §1.3 | 本笔记自足（Optique 不含） |
// | 21.2.1 | 物质波 | §2.1 | 直接对应 |
// | 21.2.2 | 实物粒子的波粒二象性 | §2.1 | 并入物质波 |
// | 21.2.3 | 不确定关系 | §2.3 + §4.6 | 定性 → 严格（Robertson） |
// | 21.3.1 | 薛定谔方程 | §4.4 + §5.1 | 公设侧 + 求解侧 |
// | 21.3.2 | 波函数标准条件与归一化 | §4.1 + §5.3 | 拆分 |
// | 21.3.3 | 一维无限深方势阱 | §6.1 | 直接对应 |
// | 21.3.4 | 一维方势垒、隧道效应 | §6.3 + §6.4 | 拆为理论 + 应用 |
// | 21.4.1 | 谐振子势函数 | §7.1 | 直接对应 |
// | 21.4.2 | 谐振子方程及求解 | §7.2 + §7.3 | 解析解 + 升降算符 |
// | 21.4.3 | 能级、波函数与概率密度 | §7.4 | 直接对应 |
// | 21.5.1 | 氢原子势函数 | §9.1 | 直接对应 |
// | 21.5.2 | 氢原子方程及求解 | §9.1–9.2 | 角向部分见 Ch 8 |
// | 21.5.3 | 电子概率分布 | §9.4 | 直接对应 |
// | 21.5.4 | 量子化条件、量子数、简并度 | §9.3 | 直接对应 |
// | 21.6.1 | Stern–Gerlach 实验、电子自旋 | §10.1–10.3 | 扩展为完整自旋章 |
// | 21.6.2 | 多电子原子中的电子分布 | §16.1–16.4 | 扩展为全同粒子章 |
// | 22.1.1 | 质子-中子模型 | §17.1 | 直接对应 |
// | 22.1.2 | 核自旋与磁矩 | §17.2 | 直接对应 |
// | 22.1.3 | 核力 | §17.3 | 直接对应 |
// | 22.2.1 | 结合能 | §18.1 | 直接对应 |
// | 22.2.2 | 核的稳定性 | §18.2 | 直接对应 |
// | 22.2.3 | 核衰变 | §18.2 | 直接对应 |
// | 22.2.4 | 放射性衰变定律 | §18.3 | 直接对应 |
// | 22.3.1 | 粒子特征、四种相互作用、分类 | §19.1–19.2 | 直接对应 |
// | 22.3.2 | 强子的夸克结构 | §19.3 | 直接对应 |
// | 22.3.3 | 相互作用的统一 | §19.4 | 直接对应 |
// | 23.1.1 | 晶体结构与分类 | §20.1 | 直接对应 |
// | 23.1.2 | 固体的能带 | §20.2 | 直接对应 |
// | 23.2.1 | 半导体/绝缘体/导体的能带 | §20.3 | 直接对应 |
// | 23.2.2 | 杂质半导体与 p-n 结 | §20.4–20.5 | 直接对应 |
// | 23.3.1–23.3.2 | 激光基本原理与激光器 | §21.1–21.3 | 与 Optique §19.1 分工 |
// | 23.3.3–23.3.4 | 激光特性与应用 | §21.4–21.5 | 直接对应 |
// | 23.4.1 | 超导基本特性 | §22.1 | 直接对应 |
// | 23.4.2 | 超导微观机制 | §22.2 | BCS 定性 |
// | 23.4.3 | 超导材料分类 | §22.3 | 直接对应 |
// | 23.4.4 | 约瑟夫孙效应及应用 | §22.4 | 直接对应 |
// | 23.4.5–23.4.6 | 超导新动向与工业应用 | §22.3 + §22.5 | 并入两节 |

// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循「基础 → 精确解 → 方法与多粒子 → 应用 → 进阶」的五段式主线，
// 共 5 Part、27 Chapter，Part 内章数为 4/6/6/6/5。
//
// Part I（Ch 1–4）：基础块。教材 21.1–21.3.2。旧量子论 → 物质波与不确定关系 →
//   数学语言（Dirac 记号、算符、谱分解、表象）→ 五条公设与严格不确定关系。
// Part II（Ch 5–10）：精确可解系统。教材 21.3.3–21.6.1。求解流程 → 一维势场 →
//   谐振子 → 角动量与中心势 → 氢原子 → 自旋。
// Part III（Ch 11–16）：方法与多粒子。教材外工具段 + 教材 21.6.2。
//   定态微扰 → 变分 → WKB → 含时微扰与辐射 → 散射 → 全同粒子与多电子原子。
// Part IV（Ch 17–22）：应用块。教材 22.1–23.4 全覆盖：核性质、结合能与衰变、
//   粒子物理、固体电子、激光、超导，导论深度、结论导向。
// Part V（Ch 23–27）：进阶块。绘景与密度矩阵 → 对称性 → 相对论量子力学 →
//   路径积分 → 量子信息，标注「进阶、可选」，不阻塞前四个 Part。
//
// 教材覆盖：第 21 章 5 节 20 个知识点、第 22 章 3 节 10 个知识点、
//   第 23 章 4 节 15 个知识点，全部映射到上方覆盖度表，无遗漏。
// ==========================================================================
