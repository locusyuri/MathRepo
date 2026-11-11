#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Recherche Opérationnelle",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Recherche Opérationnelle",
  "Violet",
  subtitle: "A notebook for operations research",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.1.0",
  extra-info: "This is a notebook for operations research.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
// 主线叙事：建模与线性方法 → 离散与网络 → 非线性 → 随机 → 决策与博弈
//
// 本笔记的主线是"决策问题的数学化"：先把现实问题写成可求解的模型（Part I），
// 再处理模型中离散结构带来的复杂度跃升（Part II），随后放宽线性假设（Part III），
// 再放宽确定性假设（Part IV），最后放宽"单一决策者 + 单一明确目标"假设（Part V）。
// 每一段放宽都对应一类新的数学工具，这是 Part 划分的依据。
//
// 教材基线：
// - Hillier & Lieberman, Introduction to Operations Research (10th ed)：Ch 1-19
// - 运筹学教材编写组（清华大学出版社），《运筹学》：Ch 1-13
// 覆盖说明见文末 Structure Note。
//
// 职责边界 (SRP Boundaries)：
// - 本笔记负责：LP 建模与单纯形法、对偶的经济解释与灵敏度分析、整数规划、
//   网络优化、动态规划、排队论、存储论、MDP、随机规划、决策论、博弈论
// - 凸集/凸函数/次梯度/Fenchel 共轭的完整理论 → Optimisation Convexe（Ch 1-4）
// - Lagrange 对偶的严格理论（Slater 条件、强对偶、鞍点、KKT 完整证明）
//   → Optimisation Convexe（Ch 6-7）；本笔记 Ch 3 只用单纯形终止表给出 LP 强对偶，
//   Ch 9 陈述 KKT 结论并引用
// - 无约束/约束算法的收敛性理论、近端方法、ADMM、内点法
//   → Optimisation Convexe（Ch 12-15）；本笔记 Ch 8-9 只讲方法概览与工程选型
// - 多元函数极值与 Lagrange 乘子法基础 → Analyse Mathématique,
//   Extremum of Multi-variable Functions（含 thm:lagrange-multiplier-method）
// - 变分法、Euler-Lagrange 方程、Hamilton 原理 → Mécanique analytique,
//   Variational Calculus；本笔记 Ch 7 连续 DP 与 Ch 15 微分博弈仅引用
// - 向量/矩阵范数、条件数、收敛阶、算法稳定性 → Analyse Numérique,
//   Norms, Conditioning and Stability
// - LU/Cholesky/QR 分解、Krylov 子空间法 → Analyse Numérique,
//   Direct Methods for Linear Systems / Iterative Methods for Linear Systems
// - 二次型、正定性、内积空间 → Algèbre Linéaire, Quadratic Forms and Inner Product Spaces
// - Hall 定理与相异代表系 → Combinatoire, Systems of Distinct Representatives；
//   本笔记 Ch 4 指派问题仅引用其可行性判据
// - 概率分布、期望、条件期望、Poisson/指数分布 → Probabilités, Common Distributions
// - Markov 链的深入理论、随机过程一般框架 → Processus Stochastique（尚未建立）；
//   本笔记 Ch 10 自带最小必要的 Markov 链与生灭过程基础，Ch 12 建立 MDP
// - 图论的完整理论（着色、匹配理论、Ramsey、极值图论）→ Théorie des Graphes /
//   Combinatoire；本笔记 Ch 6 只建立网络优化所需的最小图论基础
// - 预测（Forecasting，Hillier Ch 20）不在本笔记范围，属统计推断/时间序列范畴
//
// 与 Optimisation Convexe 的分工原则：按"连续 vs 离散"切分。
// 连续凸问题的理论与算法归凸优化，离散/组合/随机模型与单纯形类组合算法归本笔记。
// LP 与对偶是唯一双向重叠区：本笔记负责建模、单纯形、经济解释、灵敏度；
// 凸优化负责几何与锥视角、对偶的一般理论。

// ==========================================================================
// Part I — Linear Programming and Duality (线性规划与对偶)
// ==========================================================================
// 设计思路：主线起点，也是全书方法论的样板——建模 → 几何 → 算法 → 对偶。
// 从"如何把现实决策问题写成数学模型"出发，建立 LP 的凸多面体几何直观，
// 再给出沿顶点行走的组合算法（单纯形），最后以对偶理论揭示 LP 的内在对称性
// 与资源的边际价值。对偶的经济解释与灵敏度分析是本笔记的主场，
// 一般凸对偶的严格理论交叉引用到 Optimisation Convexe。
// 对应教材：Hillier Ch 2-8；清华 Ch 1-3（目标规划除外，移至 Ch 14）

// --- Chapter 1: Introduction to Operations Research and LP Modeling (运筹学概论与线性规划建模) ---

//   Section 1.1: The OR Modeling Approach (运筹学建模方法论)
//     - 运筹学的定义、历史沿革与分支谱系
//     - 建模六步骤：问题定义、数据收集、模型构造、求解、检验、实施
//     - 模型分类：确定/随机、静态/动态、线性/非线性、连续/离散
//     - 数学规划的一般形式：目标函数、约束、可行域、最优解、局部与全局最优
//     - 建模中的常见陷阱：目标错置、约束遗漏、过度简化

//   Section 1.2: LP Models and Standard Forms (线性规划模型与标准型)
//     - 生产计划、配料、下料、运输、指派、投资组合、多周期生产-库存模型
//     - 标准型、松弛型、规范型及其相互转化
//     - 自由变量拆分、不等式化等式、松弛与剩余变量
//     - 建模技巧：分段线性目标、绝对值、min-max 目标的线性化

//   Section 1.3: Geometry of Linear Programs (线性规划的几何)
//     - 可行域为凸多面体；凸集、凸组合、极点与极方向
//     - 基、基解、基可行解与顶点的对应关系
//     - LP 基本定理：最优解若存在则必可在某顶点达到
//     - 无界、无可行解、多重最优解的几何刻画
//     - 多面体的表示定理（Minkowski-Weyl）

//   Section 1.4: Graphical Solution and the Enumerative View (图解法与枚举视角)
//     - 二维图解法、等值线平移、紧约束识别
//     - 顶点枚举的组合爆炸与单纯形法的动机
//     - 从枚举到局部改进：算法设计思想的转折

// --- Chapter 2: The Simplex Method (单纯形法) ---

//   Section 2.1: Algebra of the Simplex Method (单纯形法的代数结构)
//     - 基矩阵、基变量与非基变量、基解的显式表出
//     - 旋转运算（pivot）与基变换的代数
//     - 单纯形表的构造、读法与手工计算流程

//   Section 2.2: Optimality Test and Iteration (最优性检验与迭代)
//     - 检验数（reduced cost）的推导与最优性判据
//     - 进基变量选择规则、出基变量的最小比值规则
//     - 无界性判别与无界方向提取
//     - 多重最优解的识别

//   Section 2.3: Initialization: Two-Phase and Big-M (初始化：两阶段法与大 M 法)
//     - 人工变量与辅助问题的构造
//     - 两阶段法的完整流程、第一阶段终态的三种情形
//     - 大 M 法的原理与数值缺陷
//     - 无需人工变量的初始基构造技巧

//   Section 2.4: Degeneracy, Cycling and Anti-Cycling Rules (退化、循环与防循环规则)
//     - 退化基可行解、停滞（stalling）现象
//     - Beale 循环反例
//     - Bland 规则、字典序规则及其正确性
//     - 实践中退化的处理：扰动法

//   Section 2.5: Revised Simplex and Computational Issues (修正单纯形法与计算问题)
//     - 修正单纯形的矩阵形式、基逆的乘积形式（PFI）
//     - 稀疏性利用、存储结构与数值稳定性
//     - 定价策略：最陡边、部分定价、Devex
//     - Klee-Minty 反例与指数最坏复杂度
//     - 平滑分析（smoothed analysis）简介：为何实践中通常很快

//   Section 2.6: The Theory of the Simplex Method (单纯形法的理论)
//     - 基可行解的邻接结构、多面体图与直径
//     - Hirsch 猜想的提出与否定
//     - 多项式直径问题与单纯形法的复杂度现状
//     - 椭球法与内点法的多项式性对照

// --- Chapter 3: Duality Theory and Sensitivity Analysis (对偶理论与灵敏度分析) ---

//   Section 3.1: The Dual Problem (对偶问题)
//     - 对称型与非对称型对偶的构造规则、对偶表
//     - 原-对偶对应关系：变量 ↔ 约束、不等式方向 ↔ 符号限制
//     - 对偶的对偶是原问题
//     - 从经济问题与从数学式两条路径引入对偶

//   Section 3.2: Duality Theorems (对偶定理)
//     - 弱对偶定理与最优性判据
//     - 强对偶定理：经由单纯形终止表的构造性证明
//     - 互补松弛条件及其算法用途
//     - 无界性与不可行性的对偶刻画、择一定理（Farkas 引理）
//     - 边界说明：Slater 条件与一般凸对偶的完整理论见 Optimisation Convexe,
//       Lagrange Duality and KKT Conditions

//   Section 3.3: Economic Interpretation and Shadow Prices (经济解释与影子价格)
//     - 对偶变量作为资源的边际价值
//     - 影子价格、资源估价、机会成本与隐含成本
//     - 对偶单纯形法：原理、迭代规则与适用场景
//     - 对偶单纯形在灵敏度分析与整数规划割平面中的作用

//   Section 3.4: Sensitivity Analysis (灵敏度分析)
//     - 目标系数 c 变动：最优基不变区间、非基变量检验数分析
//     - 右端项 b 变动：可行基不变区间、影子价格的有效范围
//     - 新增变量、新增约束的处理
//     - 系数矩阵 A 变动（基列/非基列）
//     - 参数规划：目标参数化与右端参数化、最优值函数的分段线性凸性

//   Section 3.5: Primal-Dual and Complementary Pivot Algorithms (原-对偶与互补枢轴算法)
//     - 原-对偶算法框架：从对偶可行解出发构造原可行解
//     - 受限原问题（restricted primal）与互补松弛的算法化
//     - 与 KKT 系统的联系
//     - 指派问题匈牙利法作为原-对偶算法的实例

// --- Chapter 4: Special LP Problems: Transportation, Assignment and DEA (LP 专题：运输、指派与数据包络分析) ---

//   Section 4.1: The Transportation Problem (运输问题)
//     - 产销平衡与不平衡模型、闭回路性质
//     - 初始基可行解：西北角法、最小元素法、Vogel 近似法
//     - 位势法（MODI）求检验数与闭回路调整
//     - 退化处理、运输悖论
//     - 转运问题与容量限制

//   Section 4.2: The Assignment Problem (指派问题)
//     - 匈牙利法（Kuhn-Munkres）的完整流程与正确性
//     - 效率矩阵变换、独立零元素与覆盖线
//     - 与二部图最大权匹配的关系
//     - 可行性判据引用 Combinatoire, Systems of Distinct Representatives（Hall 条件）
//     - 瓶颈指派、非方阵指派、带禁止指派

//   Section 4.3: Bounded-Variable and Network Simplex (有界变量 LP 与网络单纯形)
//     - 上界/下界变量的单纯形处理、基的三分类
//     - 网络矩阵的全单模性（total unimodularity）与整数解定理
//     - 网络单纯形：生成树基、树结构与定价
//     - 与一般修正单纯形的效率对比

//   Section 4.4: Data Envelopment Analysis (数据包络分析)
//     - 决策单元（DMU）与相对效率概念
//     - CCR 模型（规模报酬不变）与 BCC 模型（规模报酬可变）
//     - 投入导向与产出导向、乘子形式与包络形式
//     - 与 LP 对偶的联系、效率分解与规模效率
//     - 松弛变量与非 Archimedean 量

//   Section 4.5: Interior-Point Methods: An Overview (内点法概览)
//     - 单纯形（沿边界走顶点）与内点法（穿越内部）的路线对比
//     - 中心路径的直观、障碍函数的作用
//     - 多项式复杂度结论的陈述
//     - 边界说明：完整理论与实现见 Optimisation Convexe, Interior-Point Methods

// ==========================================================================
// Part II — Integer and Network Optimization (整数与网络优化)
// ==========================================================================
// 设计思路：从连续松弛走向离散约束，展示复杂度谱系的两端。
// 整数规划是 LP 加上可积性约束后复杂度跃升的典型（NP-难），需要分支定界与割平面；
// 网络优化则展示"结构好"的离散问题（全单模性）可以有多项式组合算法。
// 动态规划作为跨离散与连续的通用递推方法论独立成章，为 Part IV 的 MDP 铺路。
// 对应教材：Hillier Ch 9-11、13；清华 Ch 5、7、8

// --- Chapter 5: Integer Programming and Combinatorial Optimization (整数规划与组合优化) ---

//   Section 5.1: Integer Programming Models (整数规划模型)
//     - 纯整数、混合整数、0-1 规划
//     - 0-1 变量建模：逻辑约束、互斥、蕴含、固定费用、分段线性
//     - 背包、集合覆盖/划分/包装、设施选址
//     - TSP 建模：MTZ 约束与子回路消除约束
//     - 大 M 建模的数值陷阱与紧 formulation

//   Section 5.2: Branch and Bound (分支定界)
//     - 分支、定界、剪枝三要素
//     - 搜索策略：深度优先、最佳优先、混合策略
//     - incumbent 更新与界的质量
//     - 松弛选择对搜索树规模的影响
//     - 分支规则：变量分支、GUB/SOS 分支

//   Section 5.3: Cutting Planes and Branch-and-Cut (割平面与分支切割)
//     - Gomory 分数割、混合整数割（MIR）
//     - Chvátal-Gomory 闭包与割平面秩
//     - 有效不等式、面与 facet、多面体组合学
//     - 分支切割框架、预处理与 probing
//     - 覆盖不等式、流覆盖、团不等式

//   Section 5.4: Relaxations and Duality for Integer Programs (整数规划的松弛与对偶)
//     - LP 松弛与松弛强度比较
//     - 拉格朗日松弛、拉格朗日对偶与对偶间隙
//     - 次梯度法求拉格朗日乘子（收敛理论引用 Optimisation Convexe,
//       First-Order and Proximal Methods）
//     - Benders 分解：主问题与子问题、最优性割与可行性割
//     - Dantzig-Wolfe 分解与列生成简介

//   Section 5.5: Complexity and Approximation (复杂度与近似算法)
//     - P/NP/NP-难/NP-完全、多项式归约
//     - Cook-Levin 定理陈述、典型 NP-完全问题谱系
//     - 近似比、PTAS/FPTAS、不可近似性结果简介
//     - 贪心算法及其保证：集合覆盖的 ln n 界
//     - LP 松弛舍入、随机舍入

//   Section 5.6: Metaheuristics (元启发式算法)
//     - 局部搜索与邻域设计、局部最优的逃逸
//     - 模拟退火：Metropolis 准则、降温 schedule、收敛性讨论
//     - 禁忌搜索：禁忌表、特赦准则、长期记忆
//     - 遗传算法：编码、选择、交叉、变异
//     - 蚁群与粒子群简介、超启发式与算法选择
//     - 元启发式的评价：无免费午餐定理

// --- Chapter 6: Graph and Network Optimization (图与网络优化) ---

//   Section 6.1: Graph-Theoretic Preliminaries (图论基础)
//     - 图、有向图、多重图；路径、回路、连通性
//     - 树、生成树、割与圈的基本性质
//     - 邻接矩阵与关联矩阵、图的存储结构
//     - 边界说明：图论完整理论见 Théorie des Graphes 与 Combinatoire，
//       本节仅建立网络优化所需的最小基础

//   Section 6.2: Shortest Path Problems (最短路问题)
//     - Dijkstra 算法（非负权）与正确性证明
//     - Bellman-Ford（含负权、负环检测）
//     - Floyd-Warshall（全源最短路）
//     - DAG 上的拓扑序最短路、A* 与可采纳启发式
//     - 最短路的 LP 表述与对偶（势函数）、与 Ch 3 对偶理论呼应

//   Section 6.3: Maximum Flow and Minimum Cut (最大流与最小割)
//     - 流网络、可行流、残量网络与增广路
//     - Ford-Fulkerson 方法与 Edmonds-Karp 实现
//     - 最大流最小割定理及其证明
//     - Dinic 算法、预流推进（push-relabel）简介
//     - 全单模性与整数流定理
//     - 应用：二部图匹配、项目选择、图像分割

//   Section 6.4: Minimum Cost Flow and Applications (最小费用流与应用)
//     - 最小费用流模型、最优性判据（负圈消除）
//     - 消圈算法、连续最短路算法、原始-对偶算法
//     - 运输、指派、最短路作为特例的统一视角
//     - 最大权闭合子图、带预算的项目选择
//     - 网络单纯形（引用 Ch 4）

//   Section 6.5: Trees, Matchings and Routing (树、匹配与路径问题)
//     - 最小生成树：Prim、Kruskal 与割性质
//     - 二部图最大匹配与匈牙利法（引用 Ch 4）
//     - 一般图匹配简介（Edmonds 开花算法）
//     - 中国邮递员问题、TSP 的图上视角
//     - 车辆路径问题（VRP）与列生成求解简介

// --- Chapter 7: Dynamic Programming (动态规划) ---

//   Section 7.1: The Principle of Optimality (最优性原理)
//     - 多阶段决策过程：阶段、状态、决策、策略、指标函数
//     - Bellman 最优性原理与无后效性
//     - 递推方程：顺序解法与逆序解法
//     - DP 与分治、贪心的区别

//   Section 7.2: Deterministic DP Models (确定性动态规划模型)
//     - 背包问题的 DP、资源分配、生产-库存计划
//     - 最短路作为 DP、设备更新问题
//     - 状态空间设计与维数灾难
//     - 记忆化搜索与自底向上填表的对比

//   Section 7.3: DP over Combinatorial Structures (组合结构上的动态规划)
//     - 区间 DP、树形 DP、状态压缩 DP
//     - TSP 的 Held-Karp 算法
//     - 计数 DP 与组合计数（衔接 Combinatoire, Recurrence Relations and
//       Generating Functions）

//   Section 7.4: Continuous and Stochastic DP (连续与随机动态规划)
//     - 连续状态 DP、Bellman 方程的函数形式
//     - 随机 DP：期望指标、风险准则、场景树
//     - 与 Ch 12 MDP 的关系：MDP 是随机 DP 的 Markov 特例
//     - 边界说明：连续时间最优控制与变分形式见 Mécanique analytique,
//       Variational Calculus；Hamilton-Jacobi-Bellman 方程仅作导论

// ==========================================================================
// Part III — Nonlinear and Convex Optimization: An Introduction (非线性与凸优化导论)
// ==========================================================================
// 设计思路：本 Part 是过渡与衔接部分，只作导论，不追求完备。
// 放宽 Part I-II 的线性假设，给出非线性优化的方法地图与工程选型视角。
// 凸性理论、对偶理论与算法收敛性的严格处理全部交叉引用到 Optimisation Convexe，
// 本 Part 的价值在于"知道有哪些方法、各自适用什么问题、去哪里找严格理论"。
// 对应教材：Hillier Ch 12；清华 Ch 6

// --- Chapter 8: Unconstrained Optimization (无约束优化) ---

//   Section 8.1: Optimality Conditions and Problem Classes (最优性条件与问题分类)
//     - 一阶必要条件、二阶必要条件与二阶充分条件
//     - 边界说明：多元极值与 Lagrange 乘子法基础见 Analyse Mathématique,
//       Extremum of Multi-variable Functions
//     - 光滑/非光滑、凸/非凸的算法可解性分界
//     - 病态问题与条件数的影响（引用 Analyse Numérique,
//       Norms, Conditioning and Stability）

//   Section 8.2: One-Dimensional Search (一维搜索)
//     - 单峰函数、黄金分割法、Fibonacci 法
//     - 二分法与插值法（二次/三次插值）
//     - 非精确线搜索：Armijo、Wolfe、Goldstein 条件
//     - 边界说明：线搜索的收敛性理论见 Optimisation Convexe,
//       Descent Methods and Newton's Method

//   Section 8.3: Gradient and Newton-Type Methods (梯度类与 Newton 类方法)
//     - 最速下降法、锯齿现象与收敛率
//     - Newton 法、阻尼 Newton、Hessian 不正定时的修正
//     - 拟 Newton：DFP、BFGS、L-BFGS 的更新公式与工程实现
//     - 共轭方向法与共轭梯度法（线性/非线性）
//     - 边界说明：自和谐性、Newton decrement 与收敛分析见 Optimisation Convexe,
//       Descent Methods and Newton's Method

//   Section 8.4: Trust-Region and Derivative-Free Methods (信赖域与无导数方法)
//     - 信赖域框架、Cauchy 点、dogleg 与 Steihaug-CG
//     - Nelder-Mead 单纯形法、模式搜索
//     - 有限差分梯度与自动微分简介
//     - 方法选型：问题规模、导数可得性、精度需求、函数求值成本

// --- Chapter 9: Constrained Optimization and a First Look at Convexity (约束优化与凸优化导论) ---

//   Section 9.1: KKT Conditions (KKT 条件)
//     - 不等式约束问题的 Lagrange 函数与乘子符号约定
//     - 约束规范：LICQ、MFCQ、Slater 条件
//     - KKT 必要性与凸情形下的充分性
//     - 边界说明：完整证明、对偶间隙与强对偶见 Optimisation Convexe,
//       Lagrange Duality and KKT Conditions

//   Section 9.2: Penalty, Barrier and Multiplier Methods (罚函数、障碍与乘子法)
//     - 外点罚函数法、罚参数递增与病态化
//     - 内点障碍法、对数障碍
//     - 增广 Lagrange 乘子法及其相对罚函数的优势
//     - 边界说明：ADMM 与算子分裂见 Optimisation Convexe,
//       Operator Splitting and Dual Algorithms

//   Section 9.3: Sequential Quadratic Programming and Feasible Directions (SQP 与可行方向法)
//     - SQP 子问题构造、merit 函数与线搜索
//     - Zoutendijk 可行方向法、梯度投影法
//     - 既约梯度法（GRG）
//     - 与内点法的适用场景对比

//   Section 9.4: Convex Sets, Convex Functions and the Problem Zoo (凸集、凸函数与问题谱系)
//     - 凸集与凸函数的速览、一阶/二阶判据
//     - 局部最优 = 全局最优的意义与可解性边界
//     - LP → QP → QCQP → SOCP → SDP 谱系与表达能力
//     - 可凸化问题：几何规划、分数规划的变换技巧
//     - 边界说明：完整理论见 Optimisation Convexe, Convex Sets / Convex Functions /
//       Conic Programming: LP, QP and SOCP / Semidefinite Programming

// ==========================================================================
// Part IV — Stochastic Operations Research (随机运筹)
// ==========================================================================
// 设计思路：放宽确定性假设，从"参数已知"走向"参数随机"。
// 本 Part 自带 Markov 链与生灭过程基础（因 Processus Stochastique 笔记尚未建立），
// 排队论、存储论、MDP、随机规划依次展开，覆盖服务系统、库存系统、
// 序贯决策与随机数学规划四类典型随机运筹问题。
// 概率分布与期望的计算结果直接引用 Probabilités，不重复推导。
// 对应教材：Hillier Ch 16-19；清华 Ch 9-10

// --- Chapter 10: Queueing Theory (排队论) ---

//   Section 10.1: Stochastic Process Preliminaries (随机过程预备)
//     - Poisson 过程、指数分布与无记忆性（引用 Probabilités, Common Distributions）
//     - Markov 链：转移矩阵、Chapman-Kolmogorov 方程
//     - 状态分类：常返/瞬过、周期、遍历性
//     - 平稳分布与极限分布、平衡方程
//     - 连续时间 Markov 链、生灭过程与 Q 矩阵
//     - 更新过程初步、可靠性函数与维修更新模型

//   Section 10.2: Queueing Models and Kendall Notation (排队模型与 Kendall 记号)
//     - 输入过程、服务机制、排队规则三要素
//     - Kendall 记号 A/B/c/K/N/D
//     - 性能指标：队长、等待时间、逗留时间、忙期、服务台利用率
//     - Little 定律及其证明与适用范围

//   Section 10.3: The M/M/1 and M/M/c Queues (M/M/1 与 M/M/c 排队)
//     - M/M/1 的稳态分布推导、性能指标公式、稳定性条件
//     - M/M/c 与 Erlang C 公式
//     - M/M/1/K 有限容量、M/M/c/c 损失制与 Erlang B 公式
//     - 有限源模型与机器维修问题
//     - 排队系统的经济性权衡

//   Section 10.4: M/G/1 and General Service (M/G/1 与一般服务)
//     - 嵌入 Markov 链方法
//     - Pollaczek-Khinchine 均值公式与变换公式
//     - M/D/1、M/E_k/1 特例
//     - 优先权排队（非抢占/抢占）、休假排队简介
//     - G/M/1 与对偶性

//   Section 10.5: Queueing Networks and Approximations (排队网络与近似)
//     - Jackson 网络与乘积形式解
//     - BCMP 网络简介
//     - 重 traffic 近似、扩散近似与 Kingman 公式
//     - 排队系统的优化设计：服务率与服务台数决策
//     - 与 Ch 12 MDP 的联系：排队控制作为 MDP

// --- Chapter 11: Inventory Theory (存储论) ---

//   Section 11.1: Deterministic Inventory Models (确定性存储模型)
//     - EOQ 基本模型、瞬时补货与均匀补货
//     - 允许缺货模型、数量折扣
//     - 多物品联合订货、生产批量与 EPQ
//     - 成本结构：订货费、持有费、缺货费

//   Section 11.2: Single-Period Stochastic Models (单周期随机存储模型)
//     - 报童模型、临界分位数（critical fractile）
//     - 离散与连续需求、损失函数
//     - 期望利润最大化与期望成本最小化的等价性
//     - 边界说明：分布与期望计算见 Probabilités

//   Section 11.3: Multi-Period and (s, S) Policies (多周期与 (s,S) 策略)
//     - 动态库存模型、K-凸性与 (s,S) 策略最优性
//     - 基库存（base-stock）策略及其最优性条件
//     - 周期盘点与连续盘点、提前期随机
//     - 与 Ch 7 动态规划的方法论联系

//   Section 11.4: Supply Chain and Advanced Topics (供应链与进阶话题)
//     - 牛鞭效应、信息共享与协调契约
//     - 多级库存、报童扩展（多产品、预算约束）
//     - 收益管理与动态定价简介
//     - 随机存储的凸优化表述（引用 Optimisation Convexe,
//       Applications: Statistics, Learning, Geometry and Control）

// --- Chapter 12: Markov Decision Processes (马尔可夫决策过程) ---

//   Section 12.1: MDP Formulation (MDP 建模)
//     - 状态空间、动作空间、转移概率、报酬函数
//     - 策略：平稳/非平稳、确定/随机
//     - 折扣准则与平均准则、值函数定义
//     - Bellman 期望方程与 Bellman 最优方程

//   Section 12.2: Value Iteration and Policy Iteration (值迭代与策略迭代)
//     - 值迭代的压缩映射性质与收敛率
//     - 策略评估、策略改进定理、策略迭代
//     - 修正策略迭代、异步与优先扫描
//     - 有限阶段 MDP 与后向归纳（衔接 Ch 7）

//   Section 12.3: Linear Programming Formulation (MDP 的线性规划表述)
//     - 占用测度（occupancy measure）与策略的等价刻画
//     - 折扣 MDP 的 LP 表述及其对偶
//     - 平均准则 MDP 的 LP 与相对值函数
//     - 与 Ch 3 对偶理论、Ch 5 拉格朗日松弛的联系

//   Section 12.4: Applications and Extensions (应用与扩展)
//     - 设备维修与更换、库存控制、排队控制作为 MDP
//     - 半 Markov 决策过程、连续时间 MDP
//     - 部分可观测 MDP（POMDP）简介
//     - 强化学习简介：Q-learning、策略梯度、近似动态规划
//     - 边界说明：随机过程一般理论见 Processus Stochastique（待建）

// --- Chapter 13: Stochastic Programming and Simulation (随机规划与模拟) ---

//   Section 13.1: Two-Stage Stochastic Linear Programs (两阶段随机线性规划)
//     - 场景树、here-and-now 与 wait-and-see 决策
//     - recourse 问题与完全 recourse 假设
//     - 期望值问题、EVPI 与 VSS
//     - 确定性等价形式及其规模爆炸

//   Section 13.2: Decomposition Methods (分解方法)
//     - L-shaped 方法：Benders 分解在随机情形的特化
//     - 场景分解与拉格朗日松弛
//     - 多阶段随机规划、SDDP 简介
//     - 与 Ch 5 Benders 分解的方法论统一

//   Section 13.3: Chance Constraints and Robust Optimization (机会约束与鲁棒优化)
//     - 机会约束的凸性条件、正态情形的 SOCP 转化
//     - 鲁棒对等式、不确定集设计（盒式、椭球、多面体、预算型）
//     - 鲁棒优化的保守性与价格
//     - 分布鲁棒优化简介
//     - 边界说明：鲁棒最小二乘的 SOCP 表述见 Optimisation Convexe,
//       Conic Programming: LP, QP and SOCP

//   Section 13.4: Monte Carlo Simulation (Monte Carlo 模拟)
//     - 随机数生成、逆变换法、接受-拒绝法
//     - 方差缩减：对偶变量、控制变量、重要性抽样、分层抽样
//     - 离散事件模拟：事件表、时钟推进
//     - 样本平均近似（SAA）与统计误差界
//     - 模拟优化：随机逼近、样本路径优化

// ==========================================================================
// Part V — Decision Analysis and Game Theory (决策论与博弈论)
// ==========================================================================
// 设计思路：主线终点，放宽前四 Part 隐含的两个假设。
// 前四 Part 假设"单一决策者 + 明确目标"；本 Part 先放宽目标假设
// （目标不确定、多目标、偏好非线性），再放宽决策者假设（多利益主体互动）。
// 目标规划作为多目标 LP 方法归入本 Part 而非 Part I，因为它本质是偏好建模而非算法。
// 对应教材：Hillier Ch 14-15；清华 Ch 4、11、12

// --- Chapter 14: Decision Analysis (决策论) ---

//   Section 14.1: Decision Making under Uncertainty (不确定型决策)
//     - 决策矩阵、支付表、自然状态
//     - 乐观（maximax）与悲观（maximin）准则
//     - Hurwicz 折中准则、等可能（Laplace）准则
//     - 最小最大后悔值（Savage）准则
//     - 各准则的公理化差异与适用场景

//   Section 14.2: Decision Making under Risk (风险型决策)
//     - 期望货币值（EMV）、期望机会损失（EOL）
//     - 完全信息期望值（EVPI）、样本信息期望值（EVSI）
//     - 决策树构造与后向归纳
//     - 贝叶斯决策：先验、似然、后验分析
//     - 信息的价值与实验设计

//   Section 14.3: Utility Theory (效用理论)
//     - 偏好公理：完备性、传递性、连续性、独立性
//     - von Neumann-Morgenstern 期望效用定理
//     - 风险厌恶、确定性等价、Arrow-Pratt 绝对/相对风险厌恶度量
//     - 效用曲线的构造：彩票法、等价法
//     - 对期望效用理论的批评：Allais 悖论、前景理论简介

//   Section 14.4: Multi-Objective Decision Making (多目标决策)
//     - Pareto 最优、非支配解、Pareto 前沿
//     - 加权法、约束法、理想点法
//     - 层次分析法（AHP）：判断矩阵、一致性检验
//     - TOPSIS 与 ELECTRE 简介
//     - 目标规划（goal programming）：偏差变量、优先级与权重
//     - 边界说明：向量优化的完整理论见 Optimisation Convexe,
//       Convex Optimization Problems

// --- Chapter 15: Game Theory (博弈论) ---

//   Section 15.1: Two-Person Zero-Sum Games (二人零和博弈)
//     - 矩阵博弈、纯策略与鞍点
//     - 混合策略、期望支付、minimax 定理
//     - 与 LP 的等价性及求解（衔接 Ch 3）
//     - 优超（dominance）化简、2×n 与 m×2 博弈的图解法
//     - 博弈值与最优策略的性质

//   Section 15.2: Non-Cooperative Games (非合作博弈)
//     - 策略式博弈、严格/弱占优、迭代剔除
//     - Nash 均衡的定义与存在性定理（Brouwer/Kakutani 不动点）
//     - 双矩阵博弈、Lemke-Howson 算法简介
//     - 混合策略均衡的计算与 PPAD 复杂度简介
//     - 重复博弈、无名氏定理简介
//     - 贝叶斯博弈与不完全信息、Harsanyi 转换

//   Section 15.3: Cooperative Games (合作博弈)
//     - 特征函数、联盟、分配与优超
//     - 核（core）的存在性与平衡性（Bondareva-Shapley 定理）
//     - Shapley 值及其公理化（有效性、对称性、哑元性、可加性）
//     - 成本分摊、nucleolus 简介
//     - 与 Ch 5 整数规划的联系：核的非空性判定

//   Section 15.4: Extensions and Applications (扩展与应用)
//     - 演化博弈、复制动态、演化稳定策略（ESS）
//     - 机制设计、显示原理、VCG 机制简介
//     - 拍卖理论：一价/二价拍卖、收益等价定理
//     - 匹配与市场设计：Gale-Shapley 延迟接受算法
//     - 微分博弈简介（衔接 Mécanique analytique, Variational Calculus 与 Ch 7）

// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循"建模与线性方法 → 离散与网络 → 非线性 → 随机 → 决策与博弈"的五段式主线，
// 共 5 Part、15 Chapter。主线是"决策问题的数学化"，每一 Part 放宽前一段的一个假设：
// Part I 建立基本范式，Part II 放宽连续性，Part III 放宽线性，
// Part IV 放宽确定性，Part V 放宽单一决策者与单一目标。
//
// Part I（Ch 1-4，线性规划与对偶）：建模方法论 → LP 几何 → 单纯形法 →
//   对偶与灵敏度 → 运输/指派/DEA 专题。本 Part 是全书的方法论样板。
// Part II（Ch 5-7，整数与网络优化）：整数规划与元启发式 → 图与网络 → 动态规划。
//   展示复杂度谱系两端：NP-难的一般整数规划 vs 多项式可解的结构化网络问题。
// Part III（Ch 8-9，非线性与凸优化导论）：无约束方法 → 约束方法与凸性速览。
//   本 Part 仅作导论，严格理论全部交叉引用到 Optimisation Convexe。
// Part IV（Ch 10-13，随机运筹）：排队论（自带 Markov 链基础）→ 存储论 →
//   MDP → 随机规划与模拟。
// Part V（Ch 14-15，决策论与博弈论）：不确定/风险/多目标决策 → 零和/非合作/合作博弈。
//
// 教材覆盖：
// - Hillier & Lieberman (10th ed) Ch 1-2 → Ch 1；Ch 3 → Ch 1；Ch 4-5 → Ch 2；
//   Ch 6 → Ch 3；Ch 7-8 → Ch 4 与 Ch 6；Ch 9 → Ch 6；Ch 10 → Ch 7；
//   Ch 11 → Ch 5；Ch 12 → Ch 8-9；Ch 13 → Ch 5；Ch 14 → Ch 15；
//   Ch 15 → Ch 14；Ch 16 → Ch 10；Ch 17 → Ch 11；Ch 18 → Ch 12；
//   Ch 19 → Ch 13。Ch 20（Forecasting）裁决为不在本笔记范围。
// - 清华《运筹学》Ch 1 → Ch 1-2；Ch 2 → Ch 3；Ch 3 → Ch 4；Ch 4（目标规划）→ Ch 14；
//   Ch 5 → Ch 5；Ch 6 → Ch 8-9；Ch 7 → Ch 7；Ch 8 → Ch 6；Ch 9 → Ch 10；
//   Ch 10 → Ch 11；Ch 11 → Ch 15；Ch 12 → Ch 14；Ch 13 → Ch 5。
//
// 设计决策记录：
// - 原"运筹学概论"与"LP 建模"合并为 Ch 1：两者都是建模方法论，分章会造成内容单薄。
// - 启发式与元启发式并入 Ch 5 而非独立成章：它们主要服务于整数与组合优化，
//   与分支定界/割平面构成同一问题的不同求解路线，放在一章便于对比。
// - 原"约束优化"与"凸优化导论"合并为 Ch 9：本 Part 定位为导论，
//   凸性速览与 KKT 天然相邻，合并后交叉引用到 Optimisation Convexe 的入口更集中。
// - 目标规划从 Part I 移至 Ch 14：它本质是偏好建模与多目标权衡，不是 LP 算法。
// - DEA 放入 Ch 4：它是 LP 对偶的直接应用，与运输/指派同属"结构化 LP 专题"。
// - 可靠性与更新过程放入 Ch 10：与生灭过程、更新理论天然相邻。
// - Monte Carlo 模拟放入 Ch 13：服务于随机规划的场景生成与 SAA。
// - Markov 链基础自建于 Ch 10：Processus Stochastique 尚未建立，
//   本笔记只建立排队论与 MDP 所需的最小基础，不展开一般随机过程理论。
// ==========================================================================

#bibliography("references.bib", title: "References", full: true)

// 目录