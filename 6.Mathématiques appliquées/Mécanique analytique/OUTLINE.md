# Mécanique Analytique — 笔记结构与设计思路

## 整体设计哲学

这份笔记的核心目标是：**从经典力学入门一路走到分析力学前沿**，全程贯彻**对比学习**和**回顾提升**两条主线。

### 1. 渐进式路径

```
经典力学基础 (Part 0) → 数学基础 (变分法) → 拉格朗日力学 → 哈密顿力学 → 进阶专题 → 相对论与场论
```

即使读者只学过高中物理，也能从 Part 0 的质点运动学开始，逐步攀升到 Part V 的经典场论。

### 2. 对比学习 (Translational ↔ Rotational)

力学中存在深刻的**平动-转动同构**。全笔记在多处显式对比：

| 对比点 | 位置 |
|--------|------|
| 运动学线量-角量对应表 | Ch1.3 (行 208-283) |
| Newton 定律 ↔ 定轴转动定律 | Ch2 |
| 动量 ↔ 角动量 的对称结构 | Ch3.4 (Isomorphism) |
| 拉格朗日力学中的 callback 到上述对比 | Part II 各章节 |

### 3. Callback 机制

在进入分析力学后，频繁**回顾**基础力学中的结论并用新视角重新解释：

| Callback | 位置 | 基础力学源点 |
|----------|------|-------------|
| Lagrange 方程从 Hamilton 原理推导 → 还原 Newton 定律 | Ch4.3 → Ch2.1 | Newton's Three Laws |
| Lagrange 乘子给出约束反力 → 统一理解静力学约束 | Ch4.6 → Ch2.2 | Rigid Body Rotation |
| 广义动量守恒 → 还原动量/角动量 | Ch5.1 → Ch3.1-3.2 | Momentum & Angular Momentum |
| 能量守恒 → 时间平移对称性 (Noether) | Ch5.2 → Ch3.3 | Work-Energy Theorem |
| 中心力问题用 Lagrangian 求解 | Ch6.2 → Ch5 | Celestial Mechanics |
| 小振动 → 简正模 → 从 Hooke 定律到耦合振子 | Ch6.3-6.5 → Ch4 | Oscillations |

---

## 完整目录结构

### Part 0: Classical Mechanics Foundations (经典力学基础)

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

#### Chapter 4: Oscillations and Waves // 振动与波动
  - 4.1 Simple Harmonic Motion // 简谐运动
  - 4.2 Damped and Driven Oscillations // 阻尼与受驱振动
  - 4.3 Wave Propagation // 波动传播

#### Chapter 5: Celestial Mechanics Foundations // 天体力学基础
  - 5.1 Kepler's Laws // 开普勒定律
  - 5.2 Orbit Classification // 轨道分类
  - 5.3 Two-Body Problem and Reduced Mass // 二体问题与约化质量

#### Chapter 6: Fluid Mechanics Foundations // 流体力学基础
  - 6.1 Continuum Hypothesis and Density Fields // 连续体假设与密度场
  - 6.2 Euler's Equations of Motion // 欧拉运动方程
  - 6.3 Bernoulli's Equation // 伯努利方程

---

### Part I: Mathematical Foundations (数学基础)

> **设计目标**：为分析力学提供变分法和广义坐标的数学工具。
> 以 Hamilton 原理为核心公理起点。

#### Chapter 1: Variational Calculus // 变分法
  - 1.1 Functionals and Variations // 泛函与变分
  - 1.2 Derivation of Euler-Lagrange Equations // 欧拉-拉格朗日方程的推导
  - 1.3 Variational Problems with Constraints // 带约束的变分问题

#### Chapter 2: Description of Mechanical Systems // 力学系统的完整描述
  - 2.1 Degrees of Freedom and Generalized Coordinates // 自由度与广义坐标
  - 2.2 Classification of Constraints // 约束的分类
  - 2.3 Real Displacements and Virtual Displacements // 实位移与虚位移
  - 2.4 D'Alembert's Principle and Virtual Work // 达朗贝尔原理与虚功原理
    → Callback to Part 0 Ch 2 (Newton's Laws)

#### Chapter 3: Axiom: Hamilton's Principle // 公理：哈密顿原理
  - 3.1 Definition of Action Functional // 作用量泛函的定义
  - 3.2 Axiomatic Statement // 公理陈述
  - 3.3 Additivity and Gauge Invariance of Lagrangian // 拉格朗日量的可加性与不唯一性

---

### Part II: Lagrangian Mechanics (拉格朗日力学)

> **设计目标**：将 Hamilton 原理转化为实用的运动方程。
> 大量 callback 到 Part 0，用新视角重新理解旧结论。

#### Chapter 4: Lagrange's Equations // 拉格朗日方程
  - 4.1 Lagrangian Function // 拉格朗日函数
    → Callback to Part 0 Ch 3.5 (Potential Energy)
  - 4.2 Derivation from Hamilton's Principle // 从哈密顿原理推导
  - 4.3 Lagrange's Equations of the Second Kind // 第二类拉格朗日方程
    → Recovers Part 0 Ch 2.1 (Newton's Laws)
  - 4.4 Generalized Forces // 广义力
  - 4.5 Lagrange's Equations with Constraints // 带约束的拉格朗日方程
    → Generalizes Part 0 Ch 2.2 (Rigid Body Rotation)
  - 4.6 Lagrange Multipliers in Mechanics // 力学中的拉格朗日乘子

#### Chapter 5: Conservation Laws in Lagrangian Mechanics // 拉格朗日力学中的守恒律
  - 5.1 Cyclic Coordinates and Generalized Momenta // 循环坐标与广义动量
  - 5.2 Energy Conservation // 能量守恒
    → Callback to Part 0 Ch 3.3 (Work-Energy)
  - 5.3 Noether's Theorem // 诺特定理
  - 5.4 Momentum Conservation and Translational Symmetry // 动量守恒与平移对称性
    → Callback to Part 0 Ch 3.1
  - 5.5 Angular Momentum Conservation and Rotational Symmetry // 角动量守恒与旋转对称性
    → Callback to Part 0 Ch 3.2

#### Chapter 6: Applications of Lagrangian Mechanics // 拉格朗日力学的应用
  - 6.1 Rigid Body Dynamics // 刚体动力学
    → Recovers Part 0 Ch 2.2 via Lagrangian
  - 6.2 Central Force Motion // 中心力运动
    → Connects to Part 0 Ch 5 (Celestial Mechanics)
  - 6.3 Small Oscillations // 小振动
    → Generalizes Part 0 Ch 4 (Oscillations)
  - 6.4 Normal Modes and Eigenfrequencies // 简正模与本征频率
  - 6.5 Coupled Oscillators // 耦合振子

---

### Part III: Hamiltonian Mechanics (哈密顿力学)

> **设计目标**：从 Lagrangian 出发经 Legendre 变换进入相空间，
> 为统计力学、混沌和场论铺路。

#### Chapter 7: Hamilton's Equations // 哈密顿方程
  - 7.1 Legendre Transformation // 勒让德变换
  - 7.2 Hamiltonian Function // 哈密顿函数
  - 7.3 Canonical Equations of Motion // 正则运动方程
  - 7.4 Hamiltonian for Common Systems // 常见系统的哈密顿量
  - 7.5 Phase Space and Phase Portraits // 相空间与相图

#### Chapter 8: Canonical Transformations // 正则变换
  - 8.1 Generating Functions // 生成函数
  - 8.2 Types of Generating Functions // 生成函数的类型
  - 8.3 Conditions for Canonical Transformations // 正则变换的条件
  - 8.4 Poisson Brackets // 泊松括号
  - 8.5 Invariants under Canonical Transformations // 正则变换下的不变量
  - 8.6 Symplectic Structure // 辛结构

#### Chapter 9: Hamilton-Jacobi Theory // 哈密顿-雅可比理论
  - 9.1 Hamilton-Jacobi Equation // 哈密顿-雅可比方程
  - 9.2 Separation of Variables // 分离变量法
  - 9.3 Action-Angle Variables // 作用量-角变量
  - 9.4 Complete Integrals and Characteristics // 完全积分与特征线
  - 9.5 Applications to Central Force Problems // 在中心力问题中的应用

---

### Part IV: Advanced Topics (进阶主题)

> **设计目标**：从可积系统到混沌，从微扰理论到统计力学基础。

#### Chapter 10: Liouville's Theorem and Statistical Mechanics // 刘维尔定理与统计力学
  - 10.1 Liouville's Theorem // 刘维尔定理
  - 10.2 Phase Space Volume Conservation // 相空间体积守恒
  - 10.3 Ergodicity and Mixing // 遍历性与混合
  - 10.4 Poincaré Recurrence Theorem // 庞加莱回归定理

#### Chapter 11: Perturbation Theory // 微扰理论
  - 11.1 Time-independent Perturbation Theory // 不含时微扰理论
  - 11.2 Time-dependent Perturbation Theory // 含时微扰理论
  - 11.3 Adiabatic Invariants // 绝热不变量
  - 11.4 Canonical Perturbation Theory // 正则微扰理论

#### Chapter 12: Integrable Systems // 可积系统
  - 12.1 Complete Integrability // 完全可积性
  - 12.2 Lax Pairs // Lax对
  - 12.3 Inverse Scattering Method // 逆散射方法
  - 12.4 Examples of Integrable Systems // 可积系统示例

#### Chapter 13: Stability and Chaos // 稳定性与混沌
  - 13.1 Linear Stability Analysis // 线性稳定性分析
  - 13.2 Lyapunov Exponents // 李雅普诺夫指数
  - 13.3 Poincaré Sections // 庞加莱截面
  - 13.4 Bifurcations // 分岔
  - 13.5 Routes to Chaos // 通向混沌的道路

---

### Part V: Relativistic and Field Extensions (相对论与场的推广)

> **设计目标**：将分析力学推广到相对论和连续场。

#### Chapter 14: Relativistic Mechanics // 相对论力学
  - 14.1 Relativistic Lagrangian // 相对论拉格朗日量
  - 14.2 Relativistic Hamiltonian // 相对论哈密顿量
  - 14.3 Electromagnetic Interactions // 电磁相互作用
  - 14.4 Covariant Formulation // 协变形式

#### Chapter 15: Classical Field Theory // 经典场论
  - 15.1 Lagrangian Density // 拉格朗日密度
  - 15.2 Field Equations from Variational Principle // 从变分原理推导场方程
  - 15.3 Noether's Theorem for Fields // 场的诺特定理
  - 15.4 Stress-Energy Tensor // 应力-能量张量
  - 15.5 Examples: Scalar and Electromagnetic Fields // 示例：标量场与电磁场

---

## 关键设计决策

| 决策 | 理由 |
|------|------|
| **Part 0 涵盖流体力学** | 提供完整力学图景；流体力学中的 Euler 方程和 Bernoulli 原理可在后续场论中 callback |
| **Hamilton 原理作为公理起点** | 不从头推导最小作用量，将其作为第一性原理，从它推导 Lagrange 方程 |
| **Noether 定理写在 Lagrangian 力学中** | 此时读者已具备变分法和 Lagrangian，可直接理解；若放在 Hamiltonian 力学后太晚 |
| **Part III 包含辛结构** | 为从经典力学过渡到几何力学（辛流形）留接口 |
| **Part IV 包含混沌和可积系统** | 展示分析力学不止于求解方程，也涉及定性理论和不可积性 |
| **Part V 包含场论** | 从有限自由度到无限自由度的自然推广；为后续量子场论铺垫 |

## 写作状态

| Part | 章节 | 状态 |
|------|------|------|
| Part 0 | Ch1-3 | ✅ 已完成 |
| Part 0 | Ch4-6 | ❌ 未写（仅目录） |
| Part I | Ch1-3 | ✅ 已完成 |
| Part II | Ch4-6 | ✅ 已完成 |
| Part III | Ch7-9 | ❌ 未写 |
| Part IV | Ch10-13 | ❌ 未写 |
| Part V | Ch14-15 | ❌ 未写 |
