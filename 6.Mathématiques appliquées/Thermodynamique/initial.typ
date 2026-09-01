#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Thermodynamique",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Thermodynamique",
  "Violet",
  subtitle: "A notebook for thermodynamics and statistical mechanics",
  institute: "Notiz Physique",
  date: datetime.today().display(),
  version: "v0.1.0",
  extra-info: "This is a notebook for thermodynamics and statistical mechanics.",
)

#make-outline(depth: 2, title: "Contents")


// ==========================================================================
// Thermodynamique (热力学与统计力学) — Table of Contents
// ==========================================================================
//
// 主线叙事: "宏观经验 → 热力学框架 → 统计力学桥梁 → 量子统计 → 相互作用与非平衡"
//
// 从气体分子运动论的直观图像出发，建立热力学三大定律的宏观经验框架；
// 通过热力学势与勒让德变换构建完整的数学结构；然后搭建从微观到宏观
// 的桥梁——系综理论；引入量子统计处理全同粒子系统；最终推广到相互作用
// 系统（相变）和非平衡过程（输运与耗散）。
//
// 参考教材:
//   - Callen, H.B. "Thermodynamics and an Introduction to Thermostatistics" (2nd ed.)
//   - Landau & Lifshitz, "Statistical Physics" (Course of Theoretical Physics Vol.5)
//   - Pathria & Beale, "Statistical Mechanics" (3rd ed.)
//   - Reif, F. "Fundamentals of Statistical and Thermal Physics"
//
// 职责边界:
//   - 变分法、哈密顿原理、泊松括号、辛结构 → Mécanique analytique
//   - 相空间、刘维尔定理、遍历性 → Mécanique analytique (Part III-IV)
//     本笔记 Ch 11 简要回顾 + 交叉引用，自包含推导
//   - 相对论运动学（洛伦兹变换等）→ Électrodynamique (Part VII)
//     本笔记 Ch 5 直接使用结果，不重新推导
//   - 黑体辐射（经典电磁推导）→ Électrodynamique
//     本笔记从统计力学角度推导（Planck 定律）
//   - 布朗运动、朗之万方程的深入处理 → Processus Stochastique
//     本笔记 Ch 23 简要引入 + 交叉引用
//
// ==========================================================================
// --- Part I: Kinetic Theory and Classical Thermodynamics ---
// --- (气体动力学理论与经典热力学) ---
// ==========================================================================
//
// 设计思路: 从微观模型（气体分子运动论）和宏观经验（热力学定律）两条线索
// 并行出发，建立热力学的基本概念框架。末尾引入相对论热力学作为经典框架
// 的自然延伸，为后续统计力学做铺垫。
// 对应教材: Callen Ch 1; Reif Ch 1-5; Landau §7-16

// --- Chapter 1: Kinetic Theory of Gases (气体分子运动论) ---

//   Section 1.1: Ideal Gas Law and Equation of State (理想气体定律与状态方程)
//     - 状态变量 (p, V, T) 与状态方程的概念
//     - 理想气体状态方程 pV = nRT
//     - 常见状态方程: van der Waals, Dieterici, 维里展开简介
//     - 等温线、等压线、等容线与 PV 图

//   Section 1.2: Maxwell-Boltzmann Velocity Distribution (麦克斯韦-玻尔兹曼速度分布)
//     - 速度分布函数的推导（各向同性 + 分量独立性）
//     - 最概然速率、平均速率、方均根速率
//     - 能量分布与速率分布
//     - 实验验证: Stern 实验

//   Section 1.3: Mean Free Path and Collision Frequency (平均自由程与碰撞频率)
//     - 分子碰撞截面
//     - 平均自由程的推导
//     - 碰撞频率与碰撞数

//   Section 1.4: Energy Equipartition Theorem (能量均分定理)
//     - 自由度与二次型能量
//     - 均分定理的表述与推导
//     - 对理想气体热容的应用
//     - 均分定理的局限性

//   Section 1.5: Transport Phenomena (输运现象：粘滞、热传导、扩散)
//     - 粘滞现象与粘滞系数
//     - 热传导与热导率
//     - 扩散现象与扩散系数
//     - 输运系数的动力学理论推导

//   Section 1.6: Boltzmann H-Theorem and Irreversibility (玻尔兹曼 H 定理与不可逆性)
//     - H 函数的定义
//     - H 定理的推导
//     - 可逆性佯谬 (Loschmidt) 与回归性佯谬 (Zermelo)
//     - H 定理的统计诠释

// --- Chapter 2: Zeroth and First Laws of Thermodynamics (热力学第零与第一定律) ---

//   Section 2.1: Thermodynamic Systems and State Variables (热力学系统与状态变量)
//     - 系统、环境、边界
//     - 广延量与强度量
//     - 平衡态与准静态过程
//     - 热力学公理化基础 (Callen 公设)

//   Section 2.2: Zeroth Law and Temperature (第零定律与温度)
//     - 热平衡的传递性
//     - 经验温度的定义
//     - 理想气体温标
//     - 绝对温标 (开尔文)

//   Section 2.3: Work and Heat in Thermodynamic Processes (热力学过程中的功与热)
//     - 体积功与一般功的形式
//     - 热量的定义
//     - 准静态过程中的功与热
//     - 热与功的路径依赖性

//   Section 2.4: First Law: Internal Energy (第一定律：内能)
//     - 第一定律的表述
//     - 内能作为状态函数
//     - 热容: C_V 与 C_p
//     - 绝热过程

//   Section 2.5: Heat Capacity and Enthalpy (热容与焓)
//     - 定容热容与定压热容的关系
//     - 焓的定义与物理意义
//     - 焦耳-汤姆孙效应

//   Section 2.6: Applications (应用：绝热过程与节流过程)
//     - 理想气体的绝热自由膨胀
//     - 理想气体的准静态绝热过程
//     - 节流过程与焦耳-汤姆孙系数

// --- Chapter 3: Second Law of Thermodynamics (热力学第二定律) ---

//   Section 3.1: Clausius and Kelvin-Planck Statements (克劳修斯与开尔文-普朗克表述)
//     - 两种经典表述
//     - 两种表述的等价性证明

//   Section 3.2: Carnot's Theorem (卡诺定理)
//     - 卡诺循环
//     - 卡诺定理的表述与证明
//     - 卡诺效率

//   Section 3.3: Entropy and the Clausius Inequality (熵与克劳修斯不等式)
//     - 克劳修斯不等式 ∮ δQ/T ≤ 0
//     - 熵的定义: dS = δQ_rev / T
//     - 熵是状态函数的证明
//     - 熵的计算方法

//   Section 3.4: Entropy and Irreversibility (熵与不可逆性)
//     - 熵增原理
//     - 不可逆过程中的熵变计算
//     - 热力学第二定律的统计意义概述

//   Section 3.5: Thermodynamic Temperature Scale (热力学温标)
//     - 基于卡诺循环的绝对温标
//     - 与理想气体温标的等价性

//   Section 3.6: Heat Engines and Refrigeration Cycles (热机与制冷循环)
//     - 热机效率
//     - 制冷系数与热泵系数
//     - 典型循环: Otto, Diesel, Brayton

// --- Chapter 4: Third Law of Thermodynamics (热力学第三定律) ---

//   Section 4.1: Nernst Heat Theorem (能斯特热定理)
//     - 能斯特定理的表述
//     - 低温极限下热容的行为

//   Section 4.2: Planck Formulation and Absolute Entropy (普朗克表述与绝对熵)
//     - S → 0 当 T → 0
//     - 绝对熵的计算
//     - 标准熵与热力学数据表

//   Section 4.3: Unattainability of Absolute Zero (绝对零度不可达性)
//     - 不可达性原理
//     - 绝热去磁制冷

//   Section 4.4: Low-Temperature Phenomena and Residual Entropy (低温现象与残余熵)
//     - 残余熵的来源 (构型无序)
//     - CO 冰、冰的残余熵

//   Section 4.5: Negative Temperatures (负温度)
//     - 自旋系统的负温度
//     - 负温度比无限高温更"热"
//     - 负温度系统的存在条件

// --- Chapter 5: Relativistic Thermodynamics (相对论热力学) ---

//   Section 5.1: Thermodynamics of the Relativistic Ideal Gas (相对论理想气体的热力学)
//     - 相对论能量-动量关系
//     - 极端相对论与极端非相对论极限
//     - 相对论理想气体的状态方程

//   Section 5.2: Relativistic Energy-Momentum and Thermal Equilibrium (相对论能量-动量与热平衡)
//     - 相对论框架下的温度变换问题
//     - Jüttner 分布

//   Section 5.3: Photon Gas and Ultra-Relativistic Limit (光子气体与极端相对论极限)
//     - 光子气体的热力学
//     - 辐射压与辐射能密度
//     - Stefan-Boltzmann 定律的初步推导

//   Section 5.4: Thermodynamic Laws in Covariant Form (热力学定律的协变形式)
//     - 四维热力学流
//     - 协变形式的热力学第一定律
//
// ==========================================================================
// --- Part II: Thermodynamic Formalism (热力学形式理论) ---
// ==========================================================================
//
// 设计思路: 在 Part I 建立的热力学定律基础上，发展完整的热力学数学框架。
// 核心工具是热力学势（通过勒让德变换相互关联）和麦克斯韦关系。然后应用
// 于相平衡、化学平衡、稳定性分析和热力学几何。
// 对应教材: Callen Ch 2-9, 11-12; Reif Ch 6-8; Landau §16-27

// --- Chapter 6: Thermodynamic Potentials and Maxwell Relations (热力学势与麦克斯韦关系) ---

//   Section 6.1: Internal Energy as Fundamental Relation (作为基本关系的内能)
//     - 基本方程: U(S, V, N)
//     - 内能的全微分与热力学恒等式
//     - 基本方程的齐次性

//   Section 6.2: Enthalpy, Helmholtz Free Energy, Gibbs Free Energy (焓、亥姆霍兹自由能、吉布斯自由能)
//     - 焓: H(S, p)
//     - 亥姆霍兹自由能: F(T, V)
//     - 吉布斯自由能: G(T, p)
//     - 各热力学势的物理意义与适用条件

//   Section 6.3: Maxwell Relations (麦克斯韦关系)
//     - 四组麦克斯韦关系的推导
//     - 麦克斯韦关系在热力学计算中的应用
//     - 用可测量表示不可测量

//   Section 6.4: Legendre Transformations (勒让德变换)
//     - 勒让德变换的数学定义
//     - 热力学势作为勒让德变换的层级结构
//     - 变换的几何意义

//   Section 6.5: Thermodynamic Identities and Calculation Strategies (热力学恒等式与计算策略)
//     - 常用热力学恒等式汇总
//     - 热力学计算的系统方法 (Jacobian 方法)
//     - α, κ_T, C_p - C_V 关系

// --- Chapter 7: Multi-Component Systems and Phase Equilibrium (多组分系统与相平衡) ---

//   Section 7.1: Chemical Potential (化学势)
//     - 化学势的多种定义与等价性
//     - 化学势的物理意义
//     - 理想气体的化学势

//   Section 7.2: Gibbs-Duhem Equation (吉布斯-杜安方程)
//     - Gibbs-Duhem 方程的推导
//     - 强度量之间的约束关系
//     - 对混合物化学势的约束

//   Section 7.3: Phase Equilibrium Conditions (相平衡条件)
//     - 相平衡的热力学条件
//     - 多相平衡的一般理论

//   Section 7.4: Clausius-Clapeyron Equation (克劳修斯-克拉珀龙方程)
//     - 单组分两相平衡的 Clausius-Clapeyron 方程
//     - 固-液、液-气、固-气相变的应用

//   Section 7.5: Gibbs Phase Rule (吉布斯相律)
//     - 相律 F = C - P + 2 的推导
//     - 单元系、二元系的相图分析

//   Section 7.6: Phase Diagrams: First and Second Order Phase Transitions (相图：一级与二级相变)
//     - 一级相变的特征: 潜热、体积突变
//     - 二级（连续）相变: Ehrenfest 方程
//     - 典型相图: 水、CO₂

// --- Chapter 8: Chemical Thermodynamics (化学热力学) ---

//   Section 8.1: Reaction Equilibrium and Affinity (反应平衡与亲和势)
//     - 化学反应进度
//     - 亲和势的定义
//     - 化学平衡条件

//   Section 8.2: Law of Mass Action (质量作用定律)
//     - 质量作用定律的推导
//     - 平衡常数的热力学表达

//   Section 8.3: Equilibrium Constants (平衡常数)
//     - 标准平衡常数 K°
//     - van 't Hoff 方程
//     - 温度、压力对平衡的影响

//   Section 8.4: Le Chatelier's Principle (勒夏特列原理)
//     - 原理的表述
//     - 浓度、温度、压力变化的响应

//   Section 8.5: Electrochemistry: Nernst Equation (电化学：能斯特方程)
//     - 电化学势
//     - Nernst 方程的推导
//     - 电动势与 Gibbs 自由能

// --- Chapter 9: Stability and Fluctuations (稳定性与涨落) ---

//   Section 9.1: Intrinsic Stability Conditions (内禀稳定性条件)
//     - 熵的极大值原理与稳定性
//     - 热稳定性: C_V > 0
//     - 力学稳定性: (∂p/∂V)_T < 0
//     - 稳定性条件的矩阵形式

//   Section 9.2: Le Chatelier-Braun Principle (勒夏特列-布朗原理)
//     - 原理的严格表述
//     - 与稳定性条件的联系

//   Section 9.3: Metastability and Supercooling (亚稳态与过冷)
//     - 亚稳态的热力学描述
//     - 过冷液体、过热液体
//     - 旋节线 (spinodal) 与双节线 (binodal)

//   Section 9.4: Thermodynamic Fluctuation Theory (热力学涨落理论)
//     - Einstein 涨落公式
//     - 能量、体积、粒子数的涨落
//     - 涨落与响应函数的关系

//   Section 9.5: Correlation Functions and Susceptibilities (关联函数与响应函数)
//     - 静态关联函数
//     - 涨落-耗散关系的热力学形式
//     - 压缩率与密度涨落

// --- Chapter 10: Geometric Formulation of Thermodynamics (热力学几何表述) ---

//   Section 10.1: Thermodynamic State Space as Contact Manifold (热力学状态空间作为接触流形)
//     - 热力学相空间的接触结构
//     - 平衡态子流形

//   Section 10.2: Ruppeiner Geometry and Thermodynamic Curvature (鲁普赖纳几何与热力学曲率)
//     - Ruppeiner 度规: 基于熵的涨落
//     - 热力学曲率的物理意义
//     - 曲率与关联长度的关系

//   Section 10.3: Weinhold Metric (温霍尔德度规)
//     - Weinhold 度规的定义
//     - 与 Ruppeiner 度规的关系 (共形变换)

//   Section 10.4: Geometric Interpretation of Phase Transitions (相变的几何解释)
//     - 曲率发散与临界点
//     - 理想气体的曲率
//     - 几何方法的优势与局限
//
// ==========================================================================
// --- Part III: Foundations of Statistical Mechanics (统计力学基础) ---
// ==========================================================================
//
// 设计思路: 搭建从微观到宏观的桥梁。从相空间与刘维尔定理出发（交叉引用
// 分析力学），建立系综理论的核心框架：微正则 → 正则 → 大正则三大系综。
// 每个系综都完整推导配分函数与热力学量的对应关系，然后通过经典应用验证理论。
// 对应教材: Callen Ch 13-16; Pathria Ch 3-5; Reif Ch 9-10; Landau §28-38
// 交叉引用: Mécanique analytique Part III-IV (哈密顿力学、刘维尔定理)

// --- Chapter 11: Phase Space and Liouville's Theorem (相空间与刘维尔定理) ---

//   Section 11.1: Microstate and Macrostate (微观态与宏观态)
//     - 微观态的完整描述
//     - 宏观态与微观态的关系
//     - 粗粒化的概念

//   Section 11.2: Phase Space and Liouville's Theorem (相空间与刘维尔定理)
//     - Γ 空间与 μ 空间
//     - 刘维尔定理的表述与证明
//     - 交叉引用: Mécanique analytique Part IV Ch 10
//     - 相空间体积与状态计数

//   Section 11.3: Ergodic Hypothesis (遍历假设)
//     - 遍历假设的表述
//     - 时间平均与系综平均的等价性
//     - 遍历假设的局限与反例
//     - 交叉引用: Mécanique analytique Part IV Ch 10

//   Section 11.4: Postulates of Statistical Mechanics (统计力学的基本假设)
//     - 等先验概率假设
//     - 统计力学的基本公设
//     - 从微观到宏观的映射规则

//   Section 11.5: Number of Microstates and Entropy (微观态数与熵)
//     - 微观态数的计算
//     - Boltzmann 熵: S = k_B ln Ω
//     - Gibbs 熵公式

// --- Chapter 12: Microcanonical Ensemble (微正则系综) ---

//   Section 12.1: Isolated Systems and Equal a Priori Probability (孤立系统与等先验概率)
//     - 孤立系统的约束条件
//     - 等先验概率原理
//     - 微正则系综的密度矩阵

//   Section 12.2: Density of States and Phase Space Volume (态密度与相空间体积)
//     - 态密度 g(E) 的定义与计算
//     - 相空间体积的半经典计算
//     - 全同粒子修正: 1/N! 因子

//   Section 12.3: Entropy from Microcanonical Partition Function (从微正则配分函数计算熵)
//     - 微正则配分函数 Ω(E, V, N)
//     - 熵的显式计算
//     - 温度、压强的统计定义

//   Section 12.4: Temperature and Thermal Equilibrium (温度与热平衡)
//     - 温度的统计定义: 1/T = (∂S/∂E)
//     - 热平衡条件与热流方向
//     - 热力学第零定律的统计基础

//   Section 12.5: Application: Ideal Gas Revisited (应用：理想气体再探)
//     - 从微正则系综推导理想气体状态方程
//     - Sackur-Tetrode 方程
//     - 与动力学理论结果的比较

// --- Chapter 13: Canonical Ensemble (正则系综) ---

//   Section 13.1: System in Thermal Contact with Reservoir (与热库接触的系统)
//     - 系统+热库的复合孤立系统
//     - 正则分布的推导
//     - 玻尔兹曼因子 e^{-βE}

//   Section 13.2: Partition Function and Boltzmann Factor (配分函数与玻尔兹曼因子)
//     - 正则配分函数 Z(T, V, N)
//     - Z 的物理意义
//     - 可分离系统的配分函数

//   Section 13.3: Thermodynamic Quantities from Z (从配分函数 Z 计算热力学量)
//     - 内能: U = -∂ ln Z / ∂β
//     - 自由能: F = -k_B T ln Z
//     - 熵、压强、热容的统计表达

//   Section 13.4: Connection to Helmholtz Free Energy (与亥姆霍兹自由能的联系)
//     - F = U - TS 的统计推导
//     - 正则系综与亥姆霍兹自由能的一一对应
//     - 最大项方法的合理性

//   Section 13.5: Energy Fluctuations (能量涨落)
//     - 能量涨落与热容的关系
//     - 相对涨落的量级: ~1/√N
//     - 涨落在热力学极限下的行为

//   Section 13.6: Classical Limit and Equipartition Revisited (经典极限与均分定理再探)
//     - 经典配分函数的相空间积分形式
//     - 均分定理的统计推导
//     - 经典极限的适用条件

// --- Chapter 14: Grand Canonical Ensemble (大正则系综) ---

//   Section 14.1: Open Systems and Particle Exchange (开放系统与粒子交换)
//     - 系统与粒子库的接触
//     - 大正则分布的推导

//   Section 14.2: Grand Partition Function (大配分函数)
//     - 大配分函数 Ξ(T, V, μ)
//     - 逸度 z = e^{βμ}
//     - Ξ 与微观态求和

//   Section 14.3: Grand Potential and Thermodynamic Relations (巨势与热力学关系)
//     - 巨势: Φ_G = -k_B T ln Ξ
//     - Φ_G = -pV 的证明
//     - 平均粒子数与热力学量的计算

//   Section 14.4: Particle Number Fluctuations (粒子数涨落)
//     - 粒子数涨落与等温压缩率的关系
//     - 热力学极限下涨落的消失

//   Section 14.5: Applications to Adsorption and Surface Phenomena (在吸附与表面现象中的应用)
//     - 晶格气体模型
//     - Langmuir 吸附等温线
//     - 表面吸附的统计力学处理

// --- Chapter 15: Classical Applications (经典应用) ---

//   Section 15.1: Ideal Gas: Full Thermodynamic Description (理想气体：完整热力学描述)
//     - 从正则系综完整推导理想气体热力学
//     - 单原子、双原子、多原子气体的配分函数
//     - 平动、转动、振动自由度的贡献

//   Section 15.2: Paramagnetism: Curie Law (顺磁性：居里定律)
//     - 经典顺磁性的统计模型
//     - 朗之万函数
//     - 居里定律的推导

//   Section 15.3: Einstein and Debye Models of Solid Heat Capacity (固体热容：爱因斯坦与德拜模型)
//     - Einstein 模型: 独立谐振子
//     - Debye 模型: 连续弹性介质
//     - 低温 T³ 定律

//   Section 15.4: Barometric Formula and Atmospheric Physics (气压公式与大气物理)
//     - 重力场中的粒子分布
//     - 气压公式的统计推导
//     - 大气标高

//   Section 15.5: Diatomic Gas: Rotational and Vibrational Contributions (双原子气体：转动与振动贡献)
//     - 刚性转子配分函数
//     - 谐振子配分函数
//     - 特征温度: Θ_rot, Θ_vib
//     - 热容随温度的变化
//
// ==========================================================================
// --- Part IV: Quantum Statistics (量子统计) ---
// ==========================================================================
//
// 设计思路: 引入量子力学的全同粒子概念，推导玻色-爱因斯坦和费米-狄拉克
// 两大量子统计分布。然后系统展开其应用：光子气体（黑体辐射）、声子
// （固体热容的量子理论）、电子气体（金属与白矮星）、玻色-爱因斯坦凝聚。
// 这是从经典统计到量子世界的核心跃迁。
// 对应教材: Callen Ch 15-17, 21; Pathria Ch 7-11; Landau §54-64

// --- Chapter 16: Foundations of Quantum Statistics (量子统计基础) ---

//   Section 16.1: Indistinguishability and Quantum States (全同性与量子态)
//     - 全同粒子的不可区分性
//     - 对称态与反对称态
//     - 玻色子与费米子

//   Section 16.2: Bose-Einstein Distribution (玻色-爱因斯坦分布)
//     - 大正则系综推导 BE 分布
//     - 平均占据数: 1/(e^{β(ε-μ)} - 1)
//     - 化学势的约束: μ < ε₀

//   Section 16.3: Fermi-Dirac Distribution (费米-狄拉克分布)
//     - 大正则系综推导 FD 分布
//     - 平均占据数: 1/(e^{β(ε-μ)} + 1)
//     - Pauli 不相容原理的统计表达

//   Section 16.4: Classical Limit: Maxwell-Boltzmann Recovery (经典极限：回到麦克斯韦-玻尔兹曼分布)
//     - 高温低密度极限
//     - 简并条件与热德布罗意波长
//     - 量子到经典的过渡

//   Section 16.5: Density Matrix Formulation (密度矩阵表述)
//     - 量子密度矩阵
//     - 纯态与混合态
//     - 量子统计的密度矩阵方法

// --- Chapter 17: Bose-Einstein Statistics and Applications (玻色-爱因斯坦统计与应用) ---

//   Section 17.1: Photon Gas and Planck's Law (光子气体与普朗克定律)
//     - 光子作为零化学势玻色子
//     - Planck 辐射公式的推导
//     - 模式密度的计算

//   Section 17.2: Black-Body Radiation (黑体辐射：Stefan-Boltzmann 与 Wien 定律)
//     - Stefan-Boltzmann 定律
//     - Wien 位移定律
//     - Rayleigh-Jeans 极限与紫外灾难

//   Section 17.3: Phonons and Quantum Theory of Heat (声子与热的量子理论)
//     - 晶格振动的量子化: 声子
//     - Debye 模型的统计力学推导
//     - 低温热容的 T³ 定律

//   Section 17.4: Bose-Einstein Condensation (玻色-爱因斯坦凝聚)
//     - 无相互作用玻色气体的 BEC
//     - 临界温度 T_c 的推导
//     - 凝聚体的热力学性质

//   Section 17.5: Superfluidity of Helium-4 (氦-4 的超流性)
//     - 液氦的 λ 相变
//     - 双流体模型
//     - 超流性的定性解释

// --- Chapter 18: Fermi-Dirac Statistics and Applications (费米-狄拉克统计与应用) ---

//   Section 18.1: Ideal Fermi Gas at Zero Temperature (零温理想费米气体)
//     - T = 0 时的费米分布
//     - 费米面与费米球

//   Section 18.2: Fermi Energy and Density of States (费米能与态密度)
//     - 费米能量 ε_F 的计算
//     - 态密度的表达式
//     - 低温展开: Sommerfeld 展开

//   Section 18.3: Electronic Heat Capacity of Metals (金属电子热容)
//     - 金属中自由电子气的热容
//     - 线性项: C_el = γT
//     - 与晶格热容的比较

//   Section 18.4: Pauli Paramagnetism (泡利顺磁性)
//     - 外磁场中的费米气体
//     - 泡利顺磁磁化率
//     - 与经典顺磁性的对比

//   Section 18.5: Degenerate Fermi Gas: White Dwarfs and Neutron Stars (简并费米气体：白矮星与中子星)
//     - 白矮星的电子简并压
//     - Chandrasekhar 质量极限
//     - 中子星的简并中子压
//
// ==========================================================================
// --- Part V: Interacting Systems and Phase Transitions ---
// --- (相互作用系统与相变) ---
// ==========================================================================
//
// 设计思路: 从理想气体推广到有相互作用的真实系统。用集团展开和位力系数
// 处理弱非理想性，用平均场理论处理相变。然后深入临界现象——标度律、
// 普适性、重整化群的基本思想。
// 对应教材: Callen Ch 7-9, 11-12; Pathria Ch 12-16; Landau §41-53, §135-141

// --- Chapter 19: Interacting Particle Systems (相互作用粒子系统) ---

//   Section 19.1: Configuration Integral and Partition Function (位形积分与配分函数)
//     - 位形积分 Q_N
//     - 配分函数中动能与势能的分离
//     - Mayer f 函数

//   Section 19.2: Cluster Expansion (集团展开)
//     - Mayer 集团展开方法
//     - 不可约集团积分
//     - 配分函数的集团展开

//   Section 19.3: Virial Expansion and Virial Coefficients (位力展开与位力系数)
//     - 位力状态方程: pV/NkT = 1 + B₂(T)/V + ...
//     - 第二、第三位力系数
//     - 位力系数与分子间势的关系

//   Section 19.4: Mean Field Theory (平均场理论)
//     - 平均场近似的基本思想
//     - Bragg-Williams 近似
//     - 平均场方程的求解

//   Section 19.5: Van der Waals Equation of State (范德瓦尔斯状态方程)
//     - 从分子间力推导 van der Waals 方程
//     - 等温线与 Maxwell 构造
//     - 对应态原理

// --- Chapter 20: Phase Transitions and Critical Phenomena (相变与临界现象) ---

//   Section 20.1: Classification of Phase Transitions (相变的分类)
//     - Ehrenfest 分类
//     - 现代分类: 一级 vs 连续相变
//     - 序参量的概念

//   Section 20.2: Critical Exponents (临界指数)
//     - 临界指数 α, β, γ, δ, ν, η 的定义
//     - 实验测量值
//     - 平均场预言 vs 实验值

//   Section 20.3: Scaling Laws and Universality (标度律与普适性)
//     - 标度假设
//     - Rushbrooke, Griffiths, Widom 标度律
//     - 普适性: 临界指数仅依赖于维度和对称性

//   Section 20.4: Ising Model (伊辛模型：精确解与平均场解)
//     - Ising 模型的定义
//     - 一维精确解 (转移矩阵法)
//     - 二维 Onsager 解简介
//     - 平均场解

//   Section 20.5: Landau Theory of Phase Transitions (朗道相变理论)
//     - 朗道自由能展开
//     - 临界指数的朗道预言
//     - 朗道理论的适用范围

//   Section 20.6: Renormalization Group: Basic Ideas (重整化群：基本思想)
//     - Kadanoff 标度变换
//     - Wilson 重整化群的基本步骤
//     - 不动点与普适性
//     - 临界指数的重整化群计算概述
//
// ==========================================================================
// --- Part VI: Non-Equilibrium Statistical Mechanics ---
// --- (非平衡统计力学) ---
// ==========================================================================
//
// 设计思路: 从平衡态推广到非平衡过程。以玻尔兹曼输运方程为微观基础，
// 建立线性不可逆热力学的一般框架（昂萨格倒易关系），最后以涨落-耗散
// 定理和随机过程收尾，连接统计力学与随机过程笔记。
// 对应教材: Callen Ch 10, 19-20; Reif Ch 15-17; Pathria Ch 16
// 交叉引用: Processus Stochastique（布朗运动与朗之万方程的深入处理）

// --- Chapter 21: Boltzmann Transport Equation (玻尔兹曼输运方程) ---

//   Section 21.1: Distribution Function and Phase Space Density (分布函数与相空间密度)
//     - 单粒子分布函数 f(r, v, t)
//     - 分布函数的物理意义
//     - 宏观量作为分布函数的矩

//   Section 21.2: Derivation of the Boltzmann Equation (玻尔兹曼方程的推导)
//     - 漂移项、外力项、碰撞项
//     - 分子混沌假设 (Stosszahlansatz)
//     - 玻尔兹曼方程的完整形式

//   Section 21.3: Relaxation Time Approximation (弛豫时间近似)
//     - BGK 模型
//     - 弛豫时间的物理意义
//     - 稳态解的求解方法

//   Section 21.4: H-Theorem Revisited (H 定理再探)
//     - 从玻尔兹曼方程推导 H 定理
//     - 平衡分布的唯一性
//     - 局部平衡假设

//   Section 21.5: Transport Coefficients from Kinetic Theory (从动力学理论计算输运系数)
//     - 粘滞系数的推导
//     - 热导率的推导
//     - 电导率 (Drude 模型)
//     - Wiedemann-Franz 定律

// --- Chapter 22: Linear Irreversible Thermodynamics (线性不可逆热力学) ---

//   Section 22.1: Entropy Production Rate (熵产率)
//     - 局部平衡假设
//     - 熵平衡方程
//     - 熵产率的非负性

//   Section 22.2: Thermodynamic Forces and Fluxes (热力学力与流)
//     - 热力学力 X_i 的定义
//     - 热力学位流 J_i 的定义
//     - 熵产率: σ = Σ J_i X_i ≥ 0

//   Section 22.3: Onsager Reciprocal Relations (昂萨格倒易关系)
//     - 线性唯象关系: J_i = Σ L_{ij} X_j
//     - Onsager 倒易关系: L_{ij} = L_{ji}
//     - 微观可逆性的宏观体现
//     - Curie 对称性原理

//   Section 22.4: Applications: Thermoelectric Effects (应用：热电效应)
//     - Seebeck 效应
//     - Peltier 效应
//     - Thomson 效应
//     - Onsager 关系在热电现象中的应用

//   Section 22.5: Prigogine's Theorem of Minimum Entropy Production (普里高金最小熵产率定理)
//     - 最小熵产率原理的表述
//     - 适用条件与限制
//     - 与平衡态的类比

// --- Chapter 23: Fluctuations and Stochastic Processes (涨落与随机过程) ---

//   Section 23.1: Fluctuation-Dissipation Theorem (涨落-耗散定理)
//     - 涨落与耗散的深刻联系
//     - Nyquist 定理 (热噪声)
//     - 一般形式的涨落-耗散定理

//   Section 23.2: Langevin Equation (朗之万方程)
//     - 朗之万方程的建立
//     - 随机力与摩擦力的关系
//     - 速度自关联函数
//     - 交叉引用: Processus Stochastique

//   Section 23.3: Fokker-Planck Equation (福克-普朗克方程)
//     - 从朗之万方程到 Fokker-Planck 方程
//     - Kramers-Moyal 展开
//     - Fokker-Planck 方程的稳态解

//   Section 23.4: Brownian Motion (布朗运动)
//     - Einstein 的布朗运动理论
//     - 扩散系数与迁移率的关系
//     - 均方位移: ⟨x²⟩ = 2Dt
//     - Perrin 实验验证

//   Section 23.5: Kubo Formula and Linear Response Theory (久保公式与线性响应理论)
//     - 线性响应的一般理论
//     - Kubo 公式: 响应函数与关联函数
//     - Green-Kubo 关系式
//     - 电导率的 Green-Kubo 表达


// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
//
// 本笔记遵循"宏观经验 → 形式理论 → 统计桥梁 → 量子统计 → 相互作用 → 非平衡"
// 六段式主线，共 6 Part、23 Chapter。
//
// Part I (Ch 1-5): 气体动力学理论与经典热力学——从分子运动论和热力学三定律
// 建立宏观框架，以相对论热力学收尾。
//
// Part II (Ch 6-10): 热力学形式理论——热力学势、相平衡、化学热力学、稳定性
// 分析、热力学几何表述。
//
// Part III (Ch 11-15): 统计力学基础——系综理论的核心框架 (微正则、正则、大正则)
// 及经典应用。
//
// Part IV (Ch 16-18): 量子统计——全同粒子统计分布 (BE, FD) 及其在天体物理、
// 凝聚态中的应用。
//
// Part V (Ch 19-20): 相互作用系统与相变——从集团展开到临界现象与重整化群。
//
// Part VI (Ch 21-23): 非平衡统计力学——玻尔兹曼输运方程、线性不可逆热力学、
// 涨落-耗散理论。
//
// 教材覆盖: Callen 全部 21 章知识点均已覆盖，并有适当扩展（热力学几何、
// 重整化群初步、输运方程等）。
//
// 关键设计决策:
// 1. 气体动力学理论独立成章 (Ch 1): Callen 几乎不处理动力学理论，但从教学
//    角度，麦克斯韦分布和输运现象是统计力学的必要直觉准备。
// 2. 负温度放在第三定律章节 (§4.5): 负温度本质上是熵概念的推论 (S(E) 的
//    非单调性)，逻辑上紧承第三定律，而非如 Callen 作为独立补充章节。
// 3. 热力学几何独立成节 (Ch 10): 这是 Callen 和多数标准教材不涉及的现代内容。
//    加入理由: (a) 连接微分几何工具，(b) Ruppeiner 曲率与相变有深刻联系，
//    (c) 为热力学提供现代视角。
// 4. 重整化群初步纳入 (§20.6): 虽然属于高级话题，但作为"基本思想"介绍是
//    合理的，因为它是理解临界现象普适性的关键。
// 5. Part VI 非平衡部分: 从 Callen 的 Ch 10 (涨落) 和 Ch 19-20 (不可逆热力学)
//    扩展为完整的 3 章，覆盖输运方程、不可逆热力学、涨落-耗散理论。
// ==========================================================================

#bibliography("references.bib")

// 目录
