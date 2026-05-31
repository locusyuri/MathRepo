# Chapter 3: Electrostatic Field (静电场) — 详细内容大纲

> 本文档为 Chapter 3 的七个小节提供从引言、理论定义、公式推导到物理讨论的完整内容组织方案。
> 每个小节下标注了 **内容要点**、**关键公式**、**物理讨论**、**示例/习题建议**。

---

## 3.1 Coulomb's Law (库仑定律)

### 3.1.1 历史背景与实验基础
- 18 世纪库仑扭秤实验的历史背景
- 电荷的基本性质：同号相斥、异号相吸
- 电荷量的 SI 单位：库仑 (C)

### 3.1.2 库仑定律的数学表述
- **内容要点**：两个静止点电荷之间的相互作用力
- **关键公式**：
  $$
  \mathbf{F}_{12} = k \frac{q_1 q_2}{|\mathbf{r}_{12}|^2} \hat{\mathbf{r}}_{12}, \quad k = \frac{1}{4\pi\varepsilon_0}
  $$
- **讨论**：
  - 平方反比律的实验验证精度 ($\propto r^{-(2\pm\delta)}$, $\delta \ll 1$)
  - 库仑力与万有引力的类比与区别

### 3.1.3 库仑力的叠加原理 (Superposition Principle)
- 多个点电荷对某一电荷的作用力为矢量求和：
  $$
  \mathbf{F}_i = \sum_{j \neq i} \frac{1}{4\pi\varepsilon_0} \frac{q_i q_j}{|\mathbf{r}_{ij}|^2} \hat{\mathbf{r}}_{ij}
  $$
- **物理讨论**：叠加原理是实验事实，并非逻辑推导的结果

### 3.1.4 库仑定律的地位与意义
- 静电学的基石实验定律
- 与牛顿万有引力定律的形式类比
- 仅在**静止**点电荷间严格成立；运动电荷需考虑相对论修正

### 示例/习题
- 三个共线点电荷的平衡问题
- 库仑力与重力的数量级比较（如电子与质子间的静电力 vs 万有引力）

---

## 3.2 Electric Field Intensity (电场强度)

### 3.2.1 场的引入：从力到场
- **动机**：库仑定律是"超距作用"形式；法拉第的场的观点引入
- **定义**：电场强度 $\mathbf{E}(\mathbf{r}) = \lim_{q \to 0} \mathbf{F}(\mathbf{r}) / q$
  - 使用"测试电荷"(test charge) 且 $q\to0$ 以避免测试电荷本身扰动原有电场
- **单位**：$\mathrm{N/C} = \mathrm{V/m}$

### 3.2.2 点电荷与点电荷系的电场
- 单个点电荷的电场：
  $$
  \mathbf{E}(\mathbf{r}) = \frac{1}{4\pi\varepsilon_0} \frac{q}{|\mathbf{r} - \mathbf{r}'|^2} \hat{\mathbf{r}}
  $$
- 点电荷系的电场（叠加原理）：
  $$
  \mathbf{E}(\mathbf{r}) = \frac{1}{4\pi\varepsilon_0} \sum_i \frac{q_i}{|\mathbf{r} - \mathbf{r}_i|^2} \hat{\mathbf{r}}_i
  $$

### 3.2.3 连续分布电荷的电场
- 体电荷分布：
  $$
  \mathbf{E}(\mathbf{r}) = \frac{1}{4\pi\varepsilon_0} \int_V \frac{\rho(\mathbf{r}')}{|\mathbf{r} - \mathbf{r}'|^2} \hat{(\mathbf{r} - \mathbf{r}')} \, \mathrm{d}^3 r'
  $$
- 面电荷分布：
  $$
  \mathbf{E}(\mathbf{r}) = \frac{1}{4\pi\varepsilon_0} \int_S \frac{\sigma(\mathbf{r}')}{|\mathbf{r} - \mathbf{r}'|^2} \hat{(\mathbf{r} - \mathbf{r}')} \, \mathrm{d}S'
  $$
- 线电荷分布：
  $$
  \mathbf{E}(\mathbf{r}) = \frac{1}{4\pi\varepsilon_0} \int_L \frac{\lambda(\mathbf{r}')}{|\mathbf{r} - \mathbf{r}'|^2} \hat{(\mathbf{r} - \mathbf{r}')} \, \mathrm{d}l'
  $$

### 3.2.4 电力线 (Electric Field Lines) 的概念
- 电力线的定义：切线方向为 $\mathbf{E}$ 方向
- 电力线的性质：始于正电荷，终于负电荷；不相交；疏密表示场强大小
- 与 3.3 的衔接：电力线数正比于电通量

### 物理讨论
- 电场叠加原理与库仑力叠加原理的一致性
- $\mathbf{E}$ 作为"场"的实在性：即使无测试电荷，场也存在

### 示例/习题
- 电偶极子的电场计算
- 均匀带电细棒的电场（沿中垂线和端线方向）
- 均匀带电圆环轴线上的电场

---

## 3.3 Gauss's Law and Electric Flux (高斯定律与电通量)

### 3.3.1 电通量 (Electric Flux) 的定义
- 面元 $\mathrm{d}\mathbf{S}$ 的电通量：
  $$
  \mathrm{d}\Phi_E = \mathbf{E} \cdot \mathrm{d}\mathbf{S}
  $$
- 闭合曲面的电通量：
  $$
  \Phi_E = \oint_S \mathbf{E} \cdot \mathrm{d}\mathbf{S}
  $$

### 3.3.2 高斯定律的积分形式
- **内容**：通过任意闭合曲面的电通量等于曲面内净电荷除以 $\varepsilon_0$
  $$
  \oint_S \mathbf{E} \cdot \mathrm{d}\mathbf{S} = \frac{Q_{\text{enc}}}{\varepsilon_0}
  $$
- **推导**：从库仑定律 + 叠加原理出发，利用立体角概念证明

### 3.3.3 高斯定律的微分形式
- 应用散度定理 ($\oint_S \mathbf{E} \cdot \mathrm{d}\mathbf{S} = \int_V \nabla \cdot \mathbf{E} \, \mathrm{d}V$) 得到：
  $$
  \nabla \cdot \mathbf{E} = \frac{\rho}{\varepsilon_0}
  $$
- **物理意义**：电荷是电场的源——散度不为零处必有电荷
- 对比：静电场是有源场

### 3.3.4 高斯定律的应用（对称性分析）
- **球对称分布**：均匀带电球体/球壳
- **柱对称分布**：无限长均匀带电直线/圆柱
- **平面对称分布**：无限大均匀带电平面
- 每种情况演示如何选择高斯面、利用对称性简化积分

### 3.3.5 高斯定律与库仑定律的关系
- 高斯定律 $\Longleftrightarrow$ 库仑定律 + 叠加原理（在静电场中等价）
- 库仑定律是平方反比律的直接体现；高斯定律是平方反比的积分形式
- 实验意义：高斯定律比库仑定律适用范围更广（也适用于运动电荷的瞬时电场）

### 示例/习题
- 用高斯定律求均匀带电球体的电场分布
- 无限大带电平面两侧的电场
- 验证：对非对称分布，高斯定律依然成立但无法直接用来求 $\mathbf{E}$

---

## 3.4 Electric Potential (电势)

### 3.4.1 静电场的保守性
- 回顾数学基础 Ch1 中的保守场概念
- 点电荷电场的环量（闭合路径积分为零）：
  $$
  \oint \mathbf{E} \cdot \mathrm{d}\mathbf{l} = 0
  $$
- **物理含义**：静电场是保守场，电场力做功与路径无关
- 由 Stokes 定理推导微分形式：
  $$
  \nabla \times \mathbf{E} = \mathbf{0}
  $$

### 3.4.2 电势的定义
- 从保守性引入标量势函数 $V$：
  $$
  \mathbf{E} = -\nabla V
  $$
- 负号的约定：电场指向电势降低的方向
- 电势差（电压）：
  $$
  V(\mathbf{r}_B) - V(\mathbf{r}_A) = -\int_{\mathbf{r}_A}^{\mathbf{r}_B} \mathbf{E} \cdot \mathrm{d}\mathbf{l}
  $$

### 3.4.3 参考点的选择
- 点电荷系统：通常取无穷远处为电势零点
- 有限电荷分布：$V(\mathbf{r}) = \frac{1}{4\pi\varepsilon_0} \int \frac{\rho(\mathbf{r}')}{|\mathbf{r} - \mathbf{r}'|} \, \mathrm{d}^3 r'$
- 无穷远参考的限制：对于无限大带电平面/无限长直线，不能取无穷远为零点

### 3.4.4 电势叠加原理
- 点电荷系：
  $$
  V(\mathbf{r}) = \frac{1}{4\pi\varepsilon_0} \sum_i \frac{q_i}{|\mathbf{r} - \mathbf{r}_i|}
  $$
- 连续分布：
  $$
  V(\mathbf{r}) = \frac{1}{4\pi\varepsilon_0} \int \frac{\rho(\mathbf{r}')}{|\mathbf{r} - \mathbf{r}'|} \, \mathrm{d}^3 r'
  $$

### 3.4.5 电场强度与电势的关系（回顾）
- 微分关系：$\mathbf{E} = -\nabla V$
- 积分关系：$V(\mathbf{r}_B) - V(\mathbf{r}_A) = -\int_A^B \mathbf{E} \cdot \mathrm{d}\mathbf{l}$
- 物理意义：等势面垂直于电场线；等势面密集处电场强度大

### 3.4.6 常见电荷分布的电势
- 点电荷：$V(r) = \frac{1}{4\pi\varepsilon_0} \frac{q}{r}$
- 电偶极子（远处近似）：
  $$
  V(\mathbf{r}) = \frac{1}{4\pi\varepsilon_0} \frac{\mathbf{p} \cdot \hat{\mathbf{r}}}{r^2} + O(1/r^3)
  $$
- 均匀带电圆环轴线上的电势

### 物理讨论
- 标量势 vs 矢量场：使用电势简化计算
- 电势的物理意义：单位电荷的电势能

### 示例/习题
- 由已知电场分布求电势
- 电偶极子的电势与电场再计算
- 由电势梯度求电场

---

## 3.5 Common Models: Field and Potential (常见模型的电场强度与电势)

> 本节以参考表的形式，汇总静电学中所有具有高度对称性的标准电荷构型的电场 $\mathbf{E}$ 和电势 $V$。
> 每一个模型标注使用的坐标系、对称性类型、计算方法和适用的物理场景。

### 3.5.1 点电荷 (Point Charge)
- **位置**：原点
- **对称性**：球对称
- **方法**：库仑定律叠加 / 高斯定律
- **电场**：
  $$
  \mathbf{E}(\mathbf{r}) = \frac{1}{4\pi\varepsilon_0} \frac{q}{r^2} \hat{\mathbf{r}}
  $$
- **电势**：
  $$
  V(r) = \frac{1}{4\pi\varepsilon_0} \frac{q}{r}
  $$
- **适用场景**：原子核、点粒子近似

### 3.5.2 电偶极子 (Electric Dipole)
- **构型**：$+q$ 和 $-q$ 相距 $\mathbf{d}$，偶极矩 $\mathbf{p} = q\mathbf{d}$
- **对称性**：轴对称
- **方法**：叠加原理 + 远场近似
- **电场（远处，球坐标）**：
  $$
  \mathbf{E}(\mathbf{r}) = \frac{1}{4\pi\varepsilon_0} \frac{1}{r^3} \left[ 3(\mathbf{p} \cdot \hat{\mathbf{r}})\hat{\mathbf{r}} - \mathbf{p} \right]
  $$
- **电势**：
  $$
  V(\mathbf{r}) = \frac{1}{4\pi\varepsilon_0} \frac{\mathbf{p} \cdot \hat{\mathbf{r}}}{r^2}
  $$
- **适用场景**：分子电偶极矩、极化介质的元模型

### 3.5.3 均匀带电细棒 (Uniformly Charged Rod)
- **位置**：沿 $z$ 轴从 $-L/2$ 到 $L/2$，线电荷密度 $\lambda$
- **对称性**：柱对称（有限长）/$z$ 平移对称（无限长）
- **方法**：直接积分
- **电场（中垂面上，距中心 $r$）**：
  $$
  \mathbf{E} = \frac{1}{4\pi\varepsilon_0} \frac{\lambda L}{r\sqrt{r^2 + (L/2)^2}} \hat{\mathbf{r}}
  $$
- **无限长极限 ($L \to \infty$)**：
  $$
  \mathbf{E} = \frac{\lambda}{2\pi\varepsilon_0 r} \hat{\mathbf{r}}
  $$
  此时电势不能取无穷远为参考点，需取某参考点 $r_0$：
  $$
  V(r) = \frac{\lambda}{2\pi\varepsilon_0} \ln\frac{r_0}{r}
  $$

### 3.5.4 均匀带电圆环 (Uniformly Charged Ring)
- **构型**：半径 $R$，总电荷 $Q$，位于 $xy$ 平面
- **对称性**：轴对称
- **方法**：直接积分（利用对称性仅保留轴向分量）
- **电场（轴线上）**：
  $$
  \mathbf{E}(z) = \frac{1}{4\pi\varepsilon_0} \frac{Qz}{(z^2 + R^2)^{3/2}} \hat{\mathbf{z}}
  $$
- **电势（轴线上）**：
  $$
  V(z) = \frac{1}{4\pi\varepsilon_0} \frac{Q}{\sqrt{z^2 + R^2}}
  $$
- **极限行为**：
  - $z \gg R$：退化为点电荷 $\displaystyle \mathbf{E} \approx \frac{1}{4\pi\varepsilon_0} \frac{Q}{z^2}\hat{\mathbf{z}}$
  - $z = 0$ 中心处：$\mathbf{E} = \mathbf{0}$，$V = \dfrac{1}{4\pi\varepsilon_0} \dfrac{Q}{R}$

### 3.5.5 均匀带电圆盘 (Uniformly Charged Disk)
- **构型**：半径 $R$，面电荷密度 $\sigma$，位于 $xy$ 平面
- **方法**：将圆盘视为圆环的叠加（径向积分）
- **电场（轴线上）**：
  $$
  \mathbf{E}(z) = \frac{\sigma}{2\varepsilon_0} \left( 1 - \frac{z}{\sqrt{z^2 + R^2}} \right) \hat{\mathbf{z}}
  $$
- **极限行为**：
  - $R \to \infty$（无限大带电平面）：$\mathbf{E} = \dfrac{\sigma}{2\varepsilon_0} \hat{\mathbf{z}}$（均匀场！）
  - $z \gg R$：退化为点电荷 $\displaystyle \mathbf{E} \approx \frac{1}{4\pi\varepsilon_0} \frac{Q}{z^2}\hat{\mathbf{z}}$

### 3.5.6 无限大均匀带电平面 (Infinite Charged Plane)
- **构型**：面电荷密度 $\sigma$
- **对称性**：平面对称
- **方法**：高斯定律
- **电场**：
  $$
  \mathbf{E} = \frac{\sigma}{2\varepsilon_0} \hat{\mathbf{n}}
  $$
  （$\hat{\mathbf{n}}$ 为平面外法向，两侧方向相反，大小恒定）
- **电势**（取平面处为参考零点）：
  $$
  V(z) = -\frac{\sigma}{2\varepsilon_0} |z|
  $$

### 3.5.7 均匀带电球面 (Uniformly Charged Spherical Shell)
- **构型**：半径 $R$，总电荷 $Q$，球面分布
- **对称性**：球对称
- **方法**：高斯定律
- **电场**：
  $$
  \mathbf{E} = \begin{cases}
  \displaystyle \frac{1}{4\pi\varepsilon_0} \frac{Q}{r^2} \hat{\mathbf{r}}, & r > R \\[6pt]
  \mathbf{0}, & r < R
  \end{cases}
  $$
- **电势**：
  $$
  V = \begin{cases}
  \displaystyle \frac{1}{4\pi\varepsilon_0} \frac{Q}{r}, & r \ge R \\[6pt]
  \displaystyle \frac{1}{4\pi\varepsilon_0} \frac{Q}{R}, & r < R
  \end{cases}
  $$
- **物理讨论**：球壳内部电场为零（法拉第笼原理）；内部电势处处相等（等势体）

### 3.5.8 均匀带电球体 (Uniformly Charged Sphere)
- **构型**：半径 $R$，体电荷密度 $\rho = 3Q/(4\pi R^3)$
- **对称性**：球对称
- **方法**：高斯定律
- **电场**：
  $$
  \mathbf{E} = \begin{cases}
  \displaystyle \frac{1}{4\pi\varepsilon_0} \frac{Q}{r^2} \hat{\mathbf{r}}, & r > R \\[6pt]
  \displaystyle \frac{1}{4\pi\varepsilon_0} \frac{Q r}{R^3} \hat{\mathbf{r}}, & r < R
  \end{cases}
  $$
- **电势**：
  $$
  V = \begin{cases}
  \displaystyle \frac{1}{4\pi\varepsilon_0} \frac{Q}{r}, & r \ge R \\[6pt]
  \displaystyle \frac{1}{4\pi\varepsilon_0} \frac{Q}{2R} \left( 3 - \frac{r^2}{R^2} \right), & r < R
  \end{cases}
  $$
- **物理讨论**：球体内电场线性增长（$E \propto r$），球体外与点电荷相同；电势在球心处取最大值 $V(0) = \dfrac{3}{2} \dfrac{Q}{4\pi\varepsilon_0 R}$

### 3.5.9 无限长均匀带电圆柱 (Infinite Charged Cylinder)
- **构型**：半径 $R$，体电荷密度 $\rho$，沿 $z$ 轴
- **对称性**：柱对称（$z$ 平移 + 旋转）
- **方法**：高斯定律
- **电场（柱坐标 $\rho$ 为径向距离）**：
  $$
  \mathbf{E} = \begin{cases}
  \displaystyle \frac{R^2 \rho}{2\varepsilon_0} \frac{1}{\rho} \hat{\boldsymbol{\rho}} = \frac{\lambda}{2\pi\varepsilon_0} \frac{1}{\rho} \hat{\boldsymbol{\rho}}, & \rho > R \\[6pt]
  \displaystyle \frac{\rho}{2\varepsilon_0} \rho \hat{\boldsymbol{\rho}}, & \rho < R
  \end{cases}
  $$
  其中 $\lambda = \rho \pi R^2$ 为单位长度的电荷量
- **电势**：需选参考点 $\rho_0$，不能取无穷远

### 3.5.10 平行板电容器 (Parallel-Plate Capacitor)
- **构型**：两块无限大平行平面，带等量异号电荷 $\pm \sigma$
- **方法**：高斯定律 + 叠加原理
- **电场**（板间区域，忽略边缘效应）：
  $$
  \mathbf{E} = \frac{\sigma}{\varepsilon_0} \hat{\mathbf{n}} \quad (\text{从正极指向负极})
  $$
- **板外**：$\mathbf{E} = \mathbf{0}$
- **电势差**：
  $$
  \Delta V = Ed = \frac{\sigma d}{\varepsilon_0}
  $$
- **电容**：
  $$
  C = \frac{Q}{\Delta V} = \frac{\varepsilon_0 A}{d}
  $$

### 物理讨论与使用建议
- 本节是**计算工具快速索引**——在后续章节（边值问题、介质、能量等）中遇到积分计算时，可直接引用本节结论
- 注意每种模型使用的高斯面类型/积分策略：球面→球对称，圆柱面→柱对称，柱形盒→平面对称
- 对有限分布取无限远为电势参考点；对无限分布（无限长线、无限大面）需另选参考点

### 示例/习题
- 利用叠加原理求"均匀带电圆盘轴线上一点"的场强（以圆环结果为基础积分）
- 利用均匀带电球面结果推导均匀带电球体的 $E$ 和 $V$（球体积分）
- 比较三种无限构型（无限长直线、无限大平面、无限长圆柱）的 $E$ 和 $V$ 在 $r$ 或 $z$ 上的依赖关系差异

---

## 3.6 Poisson's Equation and Laplace's Equation (泊松方程与拉普拉斯方程)

### 3.6.1 从高斯定律与电势定义推导泊松方程
- 已知：
  $$
  \nabla \cdot \mathbf{E} = \frac{\rho}{\varepsilon_0}, \quad \mathbf{E} = -\nabla V
  $$
- 代入得泊松方程：
  $$
  \nabla^2 V = -\frac{\rho}{\varepsilon_0}
  $$

### 3.6.2 拉普拉斯方程 (无源区域)
- 在 $\rho = 0$ 的区域，泊松方程退化为拉普拉斯方程：
  $$
  \nabla^2 V = 0
  $$
- 满足拉普拉斯方程的函数称为**调和函数** (harmonic functions)

### 3.6.3 泊松方程的形式解 (积分形式)
- 已知格林函数解（直观推导）：
  $$
  V(\mathbf{r}) = \frac{1}{4\pi\varepsilon_0} \int \frac{\rho(\mathbf{r}')}{|\mathbf{r} - \mathbf{r}'|} \, \mathrm{d}^3 r'
  $$
- 这是泊松方程的一个特解（无穷远边界）

### 3.6.4 拉普拉斯算子在常见坐标系中的展开
- 直角坐标系：
  $$
  \nabla^2 V = \frac{\partial^2 V}{\partial x^2} + \frac{\partial^2 V}{\partial y^2} + \frac{\partial^2 V}{\partial z^2}
  $$
- 球坐标系：
  $$
  \nabla^2 V = \frac{1}{r^2}\frac{\partial}{\partial r}\left(r^2 \frac{\partial V}{\partial r}\right) + \frac{1}{r^2\sin\theta}\frac{\partial}{\partial\theta}\left(\sin\theta \frac{\partial V}{\partial\theta}\right) + \frac{1}{r^2\sin^2\theta}\frac{\partial^2 V}{\partial\phi^2}
  $$
- 柱坐标系：
  $$
  \nabla^2 V = \frac{1}{\rho}\frac{\partial}{\partial\rho}\left(\rho \frac{\partial V}{\partial\rho}\right) + \frac{1}{\rho^2}\frac{\partial^2 V}{\partial\phi^2} + \frac{\partial^2 V}{\partial z^2}
  $$

### 3.6.5 与 Chapter 4 的衔接说明
- 本章仅推导方程，给出物理背景
- 具体求解方法（分离变量法、镜像法等）留待 Chapter 4 (边值问题)

### 物理讨论
- 泊松方程揭示了"电荷分布 $\Longleftrightarrow$ 电势分布"的局域关系
- 拉普拉斯方程的无源区域性质——电势无局部极值（极值原理）

### 示例/习题
- 验证已知电荷分布产生的电势满足泊松方程
- 在无源区域内验证调和函数的性质（如平均值定理的简单例子）

---

## 3.7 Electrostatic Energy (静电能)

### 3.7.1 点电荷系的静电能
- 从功的角度定义：将点电荷从无穷远逐步移动到当前位置所做的功
- 两个点电荷：
  $$
  W = \frac{1}{4\pi\varepsilon_0} \frac{q_1 q_2}{r_{12}}
  $$
- $N$ 个点电荷：
  $$
  W = \frac{1}{4\pi\varepsilon_0} \sum_{i<j} \frac{q_i q_j}{r_{ij}} = \frac{1}{2} \sum_{i=1}^N q_i V_i
  $$
  其中 $V_i$ 是除 $q_i$ 外所有其他电荷在 $q_i$ 处产生的电势

### 3.7.2 连续分布电荷的静电能
- 体电荷分布：
  $$
  W = \frac{1}{2} \int_V \rho(\mathbf{r}) V(\mathbf{r}) \, \mathrm{d}^3 r
  $$
- 面电荷分布：
  $$
  W = \frac{1}{2} \int_S \sigma(\mathbf{r}) V(\mathbf{r}) \, \mathrm{d}S
  $$

### 3.7.3 用电场表示静电能（场能密度）
- 利用泊松方程 $\rho = -\varepsilon_0 \nabla^2 V$ 代入分部积分可得：
  $$
  W = \frac{\varepsilon_0}{2} \int_{\mathbb{R}^3} |\mathbf{E}|^2 \, \mathrm{d}^3 r
  $$
- **关键推导步骤**（需详细展示）：
  1. 从 $W = \frac12 \int \rho V \, d^3r$ 开始
  2. 代入 $\rho = \varepsilon_0 \nabla \cdot \mathbf{E}$ 使用矢量恒等式
  3. 应用散度定理，边界项在无穷远为零
- 定义静电场的**能量密度**：
  $$
  u_E = \frac{\varepsilon_0}{2} |\mathbf{E}|^2
  $$

### 3.7.4 静电能概念的两个视角
- **电荷视角**：能量储存在电荷系统中（$W = \frac12 \int \rho V$）
- **场视角**：能量储存在电场中（$W = \frac{\varepsilon_0}{2} \int |\mathbf{E}|^2$）
- **物理讨论**：在静电场中两种表述等价；在时变场中场视角更基本（能量以电磁波传播）

### 3.7.5 电容与静电能
- 电容定义：$C = Q/V$
- 电容器的静电能：
  $$
  W = \frac{1}{2} \frac{Q^2}{C} = \frac{1}{2} C V^2
  $$
- 平行板电容器的场能密度验证

### 物理讨论
- 静电能的正定性：$u_E \ge 0$
- 自能 vs 相互作用能
- 点电荷模型的自能发散问题（经典电子半径）

### 示例/习题
- 均匀带电球体的静电能计算（分别用 $\frac12 \int \rho V$ 和 $\frac{\varepsilon_0}{2} \int E^2$ 验证等价性）
- 平行板电容器静电能
- 同轴电缆单位长度的静电能

---

## 本章逻辑脉络总结

```
3.1 库仑定律 (实验基础：点电荷间的力)
     │
     ▼
3.2 电场强度 (从力到场：场的定义 + 叠加原理)
     │
     ├──► 3.3 高斯定律 (场的通量性质：散度方程)
     │         ∇·E = ρ/ε₀
     │
     └──► 3.4 电势 (场的保守性质：旋度方程)
               ∇×E = 0  ⇒  E = -∇V
                    │
                    ▼
              3.5 泊松/拉普拉斯方程 (电势满足的微分方程)
                    ∇²V = -ρ/ε₀
                    │
                    ▼
              3.7.静电能 (从功到能：场能密度 ε₀|E|²/2)
```

每个后续小节都建立在前一节的基础之上，构成一个从实验定律到理论框架再到能量描述的完整叙事链。
