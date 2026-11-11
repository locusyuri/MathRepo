# Mécanique Analytique — 笔记结构与设计思路

> **编号约定（2026-11-11 修订）**：模板的章节计数器跨 Part 连续递增（不重置），
> 因此本文件与 `initial.typ` 蓝图注释一律采用 **PDF 实际渲染编号**：
> Part I–VI（罗马数字），Chapter 1–20（全局连续）。
> 旧文档中的 "Part 0 + 各 Part 内部从 Ch1 重数" 为概念编号，已废弃，避免与 PDF 对不上。

## 整体设计哲学

这份笔记的核心目标是：**从经典力学入门一路走到分析力学前沿**，全程贯彻**对比学习**和**回顾提升**两条主线。

### 1. 渐进式路径

```
经典力学基础 (Part I) → 数学基础/变分法 (Part II) → 拉格朗日力学 (Part III) → 哈密顿力学 (Part IV) → 进阶专题 (Part V) → 相对论与场论 (Part VI)
```

即使读者只学过高中物理，也能从 Part I 的质点运动学开始，逐步攀升到 Part VI 的经典场论。

### 2. 对比学习 (Translational ↔ Rotational)

力学中存在深刻的**平动-转动同构**。全笔记在多处显式对比：

| 对比点 | 位置 |
|--------|------|
| 运动学线量-角量对应表 | Ch 1.3 |
| Newton 定律 ↔ 定轴转动定律 | Ch 2 |
| 动量 ↔ 角动量 的对称结构 | Ch 3.4 (Isomorphism) |
| 拉格朗日力学中的 callback 到上述对比 | Part III 各章节 |

### 3. Callback 机制

在进入分析力学后，频繁**回顾**基础力学中的结论并用新视角重新解释：

| Callback | 位置 | 基础力学源点 |
|----------|------|-------------|
| Lagrange 方程从 Hamilton 原理推导 → 还原 Newton 定律 | Ch 9.3 → Ch 2.1 | Newton's Three Laws |
| Lagrange 乘子给出约束反力 → 统一理解静力学约束 | Ch 9.6 → Ch 2.2 | Rigid Body Rotation |
| 广义动量守恒 → 还原动量/角动量 | Ch 10.1 → Ch 3.1-3.2 | Momentum & Angular Momentum |
| 能量守恒 → 时间平移对称性 (Noether) | Ch 10.2 → Ch 3.3 | Work-Energy Theorem |
| 第一积分（Beltrami）→ 能量守恒的物理诠释 | Ch 10.1-10.2 → Ch 6.2 | First Integrals (变分法) |
| 中心力问题用 Lagrangian 求解 | Ch 11.2 → Ch 4 | Celestial Mechanics |
| 小振动 → 简正模 → 从 Hooke 定律到耦合振子 | Ch 11.3-11.5 → Optique Part I | Vibrations and Waves（已迁至 Optique） |

---

## 完整目录结构

### Part I: Classical Mechanics Foundations (经典力学基础) — Ch 1–5

> **设计目标**：从零建立力学直觉，涵盖从质点到刚体、从平动到转动、从简谐振动到天体运动的全景。
> 为后续分析力学提供物理直觉和可 callback 的经典结果。

#### Chapter 1: Kinematics of Particles and Particle Systems // 质点与质点系
  - 1.1 Kinematic Attributes of Point Particles // 质点的运动学属性
  - 1.2 Rigid Body Kinematics: Translation and Rotation // 刚体平动与转动
  - 1.3 Correspondence between Linear and Angular Quantities // 线量与角量的对应

#### Chapter 2: Newton's Laws and Rigid Body Rotational Dynamics // 牛顿运动定律与刚体转动定律
  - 2.1 Newton's Three Laws // 牛顿三大定律
  - 2.2 Rigid Body Rotation about a Fixed Axis // 刚体定轴转动定律

#### Chapter 3: Momentum, Angular Momentum, and Energy // 动量、角动量与功能原理
  - 3.1 Linear Momentum and Impulse // 线动量与冲量
  - 3.2 Angular Momentum and Torque // 角动量与力矩
  - 3.3 Work-Energy Theorem and Energy Conservation // 功能定理与能量守恒
  - 3.4 Isomorphism between Translational and Rotational Structures // 平动与转动的同构性 ← **核心对比章节**
  - 3.5 Potential Energy and Force Fields // 势能与力场

#### Chapter 4: Celestial Mechanics Foundations // 天体力学基础
  - 4.1 Kepler's Laws // 开普勒定律
  - 4.2 Orbit Classification // 轨道分类
  - 4.3 Two-Body Problem and Reduced Mass // 二体问题与约化质量

#### Chapter 5: Fluid Mechanics Foundations // 流体力学基础
  - 5.1 Continuum Hypothesis and Density Fields // 连续体假设与密度场
  - 5.2 Euler's Equations of Motion // 欧拉运动方程
  - 5.3 Bernoulli's Equation // 伯努利方程

> 迁移说明（2026-10-22）：原「Elastic Waves in Solids」章（应变/应力/泊松比/P-S 波/阻抗/
> 反射与半波损失）已**整体迁入 Optique 笔记 Ch 2.4 与 Ch 2.6**，本章删除；本 Part 由 6 章变为 5 章，
> 天体力学与流体力学顺次上移编号。振动与波动的介质无关部分此前已迁至 Optique Part I。

---

### Part II: Mathematical Foundations (数学基础) — Ch 6–8

> **设计目标**：为分析力学提供变分法和广义坐标的数学工具。
> 以 Hamilton 原理为核心公理起点。
>
> **2026-11-11 修订**：补全原空缺的「带约束变分问题」节；将 Euler-Lagrange 推导集中于 Ch 6，
> Ch 9 改为直接调用变分法结论（消除重复推导）；Hamilton 公理补充适用范围（完整约束 + 有势力，
> 区分 vakonomic 与 d'Alembert 动力学）与「驻定而非最小」说明（Legendre 条件）。

#### Chapter 6: Variational Calculus // 变分法
  - 6.1 Functionals and Variations // 泛函与变分
    - 泛函定义、容许变分、一阶变分、分部积分恒等式
  - 6.2 Derivation of Euler-Lagrange Equations // 欧拉-拉格朗日方程的推导
    - 基本引理（du Bois-Reymond）、驻定判据、Euler-Lagrange 方程（组）
    - 自然边界条件、循环坐标、Beltrami 恒等式（第一积分的纯数学处理）
    - 例：最短曲线、势场中的质点、最速降线
  - 6.3 Variational Problems with Constraints // 带约束的变分问题
    - 等周问题与 Lagrange 乘子、完整约束的乘子形式、悬链线例

#### Chapter 7: Description of Mechanical Systems // 力学系统的完整描述
  - 7.1 Degrees of Freedom and Generalized Coordinates // 自由度与广义坐标
  - 7.2 Classification of Constraints // 约束的分类
  - 7.3 Real Displacements and Virtual Displacements // 实位移与虚位移
  - 7.4 D'Alembert's Principle and Virtual Work // 达朗贝尔原理与虚功原理
    → Callback to Part I Ch 2 (Newton's Laws)

#### Chapter 8: Axiom: Hamilton's Principle // 公理：哈密顿原理
  - 8.1 Definition of Action Functional // 作用量泛函的定义
  - 8.2 Axiomatic Statement // 公理陈述
    - 公理本体、「驻定而非最小」注记（Legendre 条件）、适用范围警示（vakonomic 对比）
    - D'Alembert 原理 ⇒ Hamilton 原理（完整约束 + 有势力情形）
  - 8.3 Additivity and Gauge Invariance of Lagrangian // 拉格朗日量的可加性与不唯一性

---

### Part III: Lagrangian Mechanics (拉格朗日力学) — Ch 9–11

> **设计目标**：将 Hamilton 原理转化为实用的运动方程。
> 大量 callback 到 Part I，用新视角重新解释旧结论。

#### Chapter 9: Lagrange's Equations // 拉格朗日方程
  - 9.1 Lagrangian Function // 拉格朗日函数
    → Callback to Part I Ch 3.5 (Potential Energy)
  - 9.2 Derivation from Hamilton's Principle // 从哈密顿原理推导
    → 直接调用 Ch 6 的 Euler-Lagrange 定理与 Ch 8 的 D'Alembert⇒Hamilton 命题，不重复推导
  - 9.3 Lagrange's Equations of the Second Kind // 第二类拉格朗日方程
    → Recovers Part I Ch 2.1 (Newton's Laws)
  - 9.4 Generalized Forces // 广义力
  - 9.5 Lagrange's Equations with Constraints // 带约束的拉格朗日方程
    → Generalizes Part I Ch 2.2 (Rigid Body Rotation)
  - 9.6 Lagrange Multipliers in Mechanics // 力学中的拉格朗日乘子

#### Chapter 10: Conservation Laws in Lagrangian Mechanics // 拉格朗日力学中的守恒律
  - 10.1 Cyclic Coordinates and Generalized Momenta // 循环坐标与广义动量
  - 10.2 Energy Conservation // 能量守恒
    → Callback to Part I Ch 3.3 (Work-Energy)；承接 Ch 6.2 Beltrami 第一积分的物理诠释
  - 10.3 Noether's Theorem // 诺特定理
  - 10.4 Momentum Conservation and Translational Symmetry // 动量守恒与平移对称性
    → Callback to Part I Ch 3.1
  - 10.5 Angular Momentum Conservation and Rotational Symmetry // 角动量守恒与旋转对称性
    → Callback to Part I Ch 3.2

#### Chapter 11: Applications of Lagrangian Mechanics // 拉格朗日力学的应用
  - 11.1 Rigid Body Dynamics // 刚体动力学
    → Recovers Part I Ch 2.2 via Lagrangian
  - 11.2 Central Force Motion // 中心力运动
    → Connects to Part I Ch 4 (Celestial Mechanics)
  - 11.3 Small Oscillations // 小振动
    → Generalizes the SHM of *Optique* Part I Ch 1
  - 11.4 Normal Modes and Eigenfrequencies // 简正模与本征频率
  - 11.5 Coupled Oscillators // 耦合振子

---

### Part IV: Hamiltonian Mechanics (哈密顿力学) — Ch 12–14

> **设计目标**：从 Lagrangian 出发经 Legendre 变换进入相空间，
> 为统计力学、混沌和场论铺路。

#### Chapter 12: Hamilton's Equations // 哈密顿方程
  - 12.1 Legendre Transformation // 勒让德变换
  - 12.2 Hamiltonian Function // 哈密顿函数
  - 12.3 Canonical Equations of Motion // 正则运动方程
  - 12.4 Hamiltonian for Common Systems // 常见系统的哈密顿量
  - 12.5 Phase Space and Phase Portraits // 相空间与相图

#### Chapter 13: Canonical Transformations // 正则变换
  - 13.1 Generating Functions // 生成函数
  - 13.2 Types of Generating Functions // 生成函数的类型
  - 13.3 Conditions for Canonical Transformations // 正则变换的条件
  - 13.4 Poisson Brackets // 泊松括号
  - 13.5 Invariants under Canonical Transformations // 正则变换下的不变量
  - 13.6 Symplectic Structure // 辛结构

#### Chapter 14: Hamilton-Jacobi Theory // 哈密顿-雅可比理论
  - 14.1 Hamilton-Jacobi Equation // 哈密顿-雅可比方程
  - 14.2 Separation of Variables // 分离变量法
  - 14.3 Action-Angle Variables // 作用量-角变量
  - 14.4 Complete Integrals and Characteristics // 完全积分与特征线
  - 14.5 Applications to Central Force Problems // 在中心力问题中的应用

---

### Part V: Advanced Topics (进阶主题) — Ch 15–18

> **设计目标**：从可积系统到混沌，从微扰理论到统计力学基础。

#### Chapter 15: Liouville's Theorem and Statistical Mechanics // 刘维尔定理与统计力学
  - 15.1 Liouville's Theorem // 刘维尔定理
  - 15.2 Phase Space Volume Conservation // 相空间体积守恒
  - 15.3 Ergodicity and Mixing // 遍历性与混合
  - 15.4 Poincaré Recurrence Theorem // 庞加莱回归定理

#### Chapter 16: Perturbation Theory // 微扰理论
  - 16.1 Time-independent Perturbation Theory // 不含时微扰理论
  - 16.2 Time-dependent Perturbation Theory // 含时微扰理论
  - 16.3 Adiabatic Invariants // 绝热不变量
  - 16.4 Canonical Perturbation Theory // 正则微扰理论

#### Chapter 17: Integrable Systems // 可积系统
  - 17.1 Complete Integrability // 完全可积性
  - 17.2 Lax Pairs // Lax对
  - 17.3 Inverse Scattering Method // 逆散射方法
  - 17.4 Examples of Integrable Systems // 可积系统示例

#### Chapter 18: Stability and Chaos // 稳定性与混沌
  - 18.1 Linear Stability Analysis // 线性稳定性分析
  - 18.2 Lyapunov Exponents // 李雅普诺夫指数
  - 18.3 Poincaré Sections // 庞加莱截面
  - 18.4 Bifurcations // 分岔
  - 18.5 Routes to Chaos // 通向混沌的道路

---

### Part VI: Relativistic and Field Extensions (相对论与场的推广) — Ch 19–20

> **设计目标**：将分析力学推广到相对论和连续场。

#### Chapter 19: Relativistic Mechanics // 相对论力学
  - 19.1 Relativistic Lagrangian // 相对论拉格朗日量
  - 19.2 Relativistic Hamiltonian // 相对论哈密顿量
  - 19.3 Electromagnetic Interactions // 电磁相互作用
  - 19.4 Covariant Formulation // 协变形式

#### Chapter 20: Classical Field Theory // 经典场论
  - 20.1 Lagrangian Density // 拉格朗日密度
  - 20.2 Field Equations from Variational Principle // 从变分原理推导场方程
  - 20.3 Noether's Theorem for Fields // 场的诺特定理
  - 20.4 Stress-Energy Tensor // 应力-能量张量
  - 20.5 Examples: Scalar and Electromagnetic Fields // 示例：标量场与电磁场

---

## 关键设计决策

| 决策 | 理由 |
|------|------|
| **Part I 涵盖流体力学** | 提供完整力学图景；流体力学中的 Euler 方程和 Bernoulli 原理可在后续场论中 callback |
| **Hamilton 原理作为公理起点** | 不从头推导最小作用量，将其作为第一性原理，从它推导 Lagrange 方程；公理注明适用范围（完整约束 + 有势力），并区分 vakonomic 变分动力学 |
| **Euler-Lagrange 推导集中在 Ch 6** | Ch 9 直接调用变分法结论，避免同一推导写两遍；数学工具与物理应用职责分离 |
| **第一积分数学/物理分层** | Beltrami 恒等式作为纯数学结论放 Ch 6.2；其物理诠释（能量守恒）放 Ch 10，前后呼应 |
| **Noether 定理写在 Lagrangian 力学中** | 此时读者已具备变分法和 Lagrangian，可直接理解；若放在 Hamiltonian 力学后太晚 |
| **Part IV 包含辛结构** | 为从经典力学过渡到几何力学（辛流形）留接口 |
| **Part V 包含混沌和可积系统** | 展示分析力学不止于求解方程，也涉及定性理论和不可积性 |
| **Part VI 包含场论** | 从有限自由度到无限自由度的自然推广；为后续量子场论铺垫 |

## 职责边界（SRP）

| 知识点 | 归属 | 处理方式 |
|--------|------|---------|
| 经典变分法 / Euler-Lagrange / Hamilton 原理 | 本笔记 | Optimisation Convexe 已显式委托给本笔记 |
| 分布意义下的基本引理 | PDE 笔记 | 本笔记只给经典形式（du Bois-Reymond） |
| 弱形式 / 无穷维变分 | Analyse Fonctionnelle | 交叉引用，不重复 |
| Legendre 变换的系统理论 | 本笔记 Part IV | Ch 6 只给 Legendre 必要条件 |

## 写作状态

| Part | 章节 | 状态 |
|------|------|------|
| Part I | Ch 1-5 | ✅ 已完成（Celestial / Fluid；原弹性波章已迁至 Optique） |
| Part II | Ch 6-8 | ✅ 已完成（2026-11-11 修订：补全约束变分、去重推导、公理范围限定） |
| Part III | Ch 9-11 | ✅ 已完成 |
| Part IV | Ch 12-14 | ❌ 未写 |
| Part V | Ch 15-18 | ❌ 未写 |
| Part VI | Ch 19-20 | ❌ 未写 |