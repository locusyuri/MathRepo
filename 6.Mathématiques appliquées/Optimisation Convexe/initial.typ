#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Optimisation Convexe",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Optimisation Convexe",
  "Violet",
  subtitle: "A notebook for convex optimization",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.1.0",
  extra-info: "This is a notebook for convex optimization.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
// 主线叙事：凸性理论 → 对偶 → 问题谱系与应用 → 算法
//
// 本笔记的主线是"从结构到算法"：先建立凸性这一使优化问题可解的结构
// （Part I），再用对偶把结构转化为下界、证书与分解手段（Part II），
// 然后把抽象理论落到具体问题类与建模实践（Part III），
// 最后给出把理论变成可执行求解方法的算法体系（Part IV）。
//
// 教材基线：Boyd & Vandenberghe, Convex Optimization (Cambridge, 2004)，Ch 1-11。
// 重要说明：Boyd 原书只有 11 章，本笔记的 15 章包含大量超出基线的扩展，
// 扩展清单与理由见文末 Structure Note 的"教材覆盖"与"设计决策记录"。
// 扩展部分补充参考文献：Rockafellar (Convex Analysis)、Nesterov (Lectures)、
// Parikh-Boyd (Proximal Algorithms)、Beck (First-Order Methods)、
// Bauschke-Combettes (Convex Analysis and Monotone Operator Theory)、
// Nocedal-Wright (Numerical Optimization)。
//
// 职责边界 (SRP Boundaries)：
// - 本笔记负责：凸集/凸函数/次梯度/Fenchel 共轭、Lagrange 与 Fenchel 对偶的
//   严格理论、KKT 完整证明、锥规划（LP/QP/SOCP/SDP）的统一视角、
//   全部连续优化算法（下降法/Newton/一阶近端/算子分裂/内点法）
// - LP 建模、单纯形法、运输/指派、对偶的经济解释与灵敏度区间计算
//   → Recherche Opérationnelle（Ch 1-4）；本笔记 Ch 8 只讲 LP 的几何与锥视角
// - 整数规划、网络流、动态规划、元启发式、NP-难与近似算法框架
//   → Recherche Opérationnelle（Ch 5-7）；本笔记 Ch 9 只做凸松弛并引用其结论
// - 排队论、存储论、MDP、随机规划框架、决策论、博弈论
//   → Recherche Opérationnelle（Ch 10-15）；本笔记 Ch 11 只引用模型来源
// - 多元函数极值、条件极值、Lagrange 乘子法基础
//   → Analyse Mathématique, Extremum of Multi-variable Functions
//   （含 thm:lagrange-multiplier-method）；本笔记 Ch 6 推广到不等式约束 KKT
// - 变分法、Euler-Lagrange 方程、Hamilton 原理、连续时间最优控制
//   → Mécanique analytique, Variational Calculus；本笔记 Ch 11 只做离散化后的凸问题
// - 向量/矩阵范数、条件数、收敛阶、算法稳定性、浮点误差
//   → Analyse Numérique, Norms, Conditioning and Stability；本笔记 Ch 12 直接引用
// - LU/Cholesky/QR 分解、Krylov 子空间法、稀疏直接法
//   → Analyse Numérique, Direct Methods for Linear Systems /
//   Iterative Methods for Linear Systems；本笔记 Ch 12/15 引用为底层线性代数工具
// - 多项式插值、样条、最佳一致逼近、正交多项式、最小二乘拟合的逼近论
//   → Analyse Numérique, Function Approximation and Curve Fitting；
//   本笔记 Ch 10 只负责凸优化表述与正则化
// - 二次型、正定性判定、内积空间、SVD
//   → Algèbre Linéaire, Quadratic Forms and Inner Product Spaces；
//   本笔记 Ch 9 引用 PSD 判定，Ch 13 引用 SVD 做奇异值阈值
// - Hahn-Banach 定理、Hilbert 空间投影定理、弱收敛、自反空间、单调算子一般理论
//   → Analyse Fonctionnelle（Hahn-Banach Theorem / Projection Theorem /
//   Weak Convergence and Applications）；本笔记只在有限维欧氏空间处理，
//   分离定理与投影定理给出有限维自足证明，无穷维推广仅注明出处
// - 概率分布、期望、条件期望、指数族分布的性质 → Probabilités
// - 测度论与 Lebesgue 积分（Jensen 不等式的积分形式所需）→ Analyse Réelle
// - 图论与组合计数基础 → Théorie des Graphes / Combinatoire
//
// 与 Recherche Opérationnelle 的分工原则：按"连续 vs 离散"切分。
// 连续凸问题的理论与算法归本笔记，离散/组合/随机模型与单纯形类组合算法归运筹学。
// LP 与对偶是唯一双向重叠区：本笔记负责几何、锥视角与对偶的一般理论；
// 运筹学负责建模、单纯形、经济解释与灵敏度区间计算。

// ==========================================================================
// Part I — Foundations of Convex Analysis (凸分析基础)
// ==========================================================================
// 设计思路：主线起点，建立"凸性"这一使优化问题可解的核心结构。
// 按"集合 → 函数 → 广义导数 → 问题"的对象递进顺序展开：
// Ch 1-2 处理凸集（代数性质与几何/拓扑性质分章），
// Ch 3-4 处理凸函数（初等性质与广义导数/共轭分章），
// Ch 5 把前四章的工具组装成凸优化问题的标准形式与等价变换。
// 相对内部、分离定理、次微分、Fenchel 共轭是后续对偶理论与算法的全部基础。
// 对应教材：Boyd Ch 1-3、Ch 4.1-4.2、4.5、4.7；
// 扩展 Rockafellar Convex Analysis（Ch 2、Ch 4 的次梯度与闭凸理论）

// --- Chapter 1: Introduction and Convex Sets (引言与凸集) ---

//   Section 1.1: Mathematical Optimization and the Convex Landscape (数学优化与凸优化谱系)
//     - 优化问题的一般形式：目标、约束、可行集、最优值、最优解集
//     - 最小二乘与线性规划的历史：可解性的两个里程碑
//     - 凸优化的地位：局部即全局、对偶可用、多项式算法
//     - 可解性边界：凸 vs 非凸、光滑 vs 非光滑、有限维 vs 无穷维
//     - 本笔记的范围界定与阅读路线

//   Section 1.2: Affine and Convex Sets (仿射集与凸集)
//     - 直线、线段、仿射集、仿射包、仿射维数
//     - 凸集、凸包、凸组合、锥与凸锥
//     - 仿射集与凸集的关系、子空间平移
//     - 相对内部的初步引入（系统处理见 Ch 2）

//   Section 1.3: Important Examples of Convex Sets (凸集的重要例子)
//     - 超平面与半空间、多面体及其表示
//     - 单纯形、单位立方体、范数球与范数锥
//     - 椭球、半正定锥、对称矩阵空间
//     - 空集、单点集、全空间等退化情形
//     - 例子之间的包含关系图谱

//   Section 1.4: Operations That Preserve Convexity (保凸运算)
//     - 交集（任意多个）、仿射函数下的像与原像
//     - 线性分式映射与透视映射
//     - Minkowski 和、笛卡尔积
//     - 凸包与锥包运算
//     - 保凸运算在建模中的用途：从简单集合构造复杂集合

// --- Chapter 2: Geometry of Convex Sets and Separation (凸集几何与分离定理) ---

//   Section 2.1: Topology of Convex Sets (凸集的拓扑)
//     - 相对内部、闭包、相对边界的定义与性质
//     - 凸集的闭包与相对内部仍为凸
//     - 内部非空的条件、仿射包降维处理
//     - 相对内部在约束规范中的作用（预告 Ch 6 Slater 条件）

//   Section 2.2: Separating and Supporting Hyperplanes (分离与支撑超平面)
//     - 分离超平面定理：严格分离与正常分离
//     - 支撑超平面定理
//     - 有限维自足证明：投影 + 构造法向量
//     - 与 Hahn-Banach 定理的关系：引用 Analyse Fonctionnelle,
//       Hahn-Banach Theorem，本笔记不重复无穷维证明
//     - 分离定理的等价形式与择一定理预告

//   Section 2.3: Projection and Distance (投影与距离)
//     - 到闭凸集投影的存在唯一性
//     - 投影的变分刻画（钝角判据）与非扩张性
//     - 两凸集间的距离、分离的定量版本
//     - 边界说明：Hilbert 空间投影定理见 Analyse Fonctionnelle,
//       Projection Theorem；本笔记只在有限维欧氏空间处理
//     - 投影在近端算法中的核心地位（预告 Ch 13）

//   Section 2.4: Dual Cones and Generalized Inequalities (对偶锥与广义不等式)
//     - 对偶锥定义、基本性质、自对偶锥
//     - 广义不等式、最小/最大元与极小/极大元的区别
//     - 非负象限、PSD 锥、二阶锥的对偶计算
//     - 对偶锥与分离定理的联系

//   Section 2.5: Extreme Structure and Combinatorial Convex Geometry (极点结构与组合凸几何)
//     - 极点、极方向、回收锥（recession cone）
//     - Minkowski-Weyl 表示定理、多面体的分解
//     - Carathéodory 定理、Radon 定理、Helly 定理
//     - Krein-Milman 定理的有限维形式
//     - 极集（polar set）与 bipolar 定理
//     - 与 LP 顶点最优性、整数规划多面体组合学的联系

// --- Chapter 3: Convex Functions (凸函数) ---

//   Section 3.1: Definition and Basic Properties (定义与基本性质)
//     - 凸函数定义、严格凸、强凸
//     - 上镜图（epigraph）刻画、水平集与凸性的单向关系
//     - 定义域为凸集、凸函数与凸集的对应
//     - Jensen 不等式：有限形式、积分形式、期望形式
//     - 边界说明：积分形式所需测度论见 Analyse Réelle

//   Section 3.2: First- and Second-Order Conditions (一阶与二阶条件)
//     - 一阶条件：切平面为全局下界
//     - 二阶条件：Hessian 半正定
//     - 强凸的等价刻画、梯度 Lipschitz 的等价刻画
//     - 沿直线限制的一元化判据
//     - 这些刻画在算法收敛率分析中的作用（预告 Ch 12-13）

//   Section 3.3: Operations That Preserve Convexity (保凸运算)
//     - 非负加权和、仿射复合
//     - 逐点上确界（pointwise supremum）与逐点最大值
//     - 复合规则：标量复合、向量复合、单调性条件
//     - 透视函数、部分最小化（infimal projection）
//     - 下卷积（infimal convolution）的初步引入（详见 Ch 4）
//     - 保凸运算作为建模的语法：DCP 规则的理论基础（预告 Ch 8）

//   Section 3.4: Examples and Function Classes (例子与函数类)
//     - 仿射函数、范数、二次函数、指数与对数
//     - 熵与负熵、log-sum-exp、几何平均
//     - 矩阵函数：log det、最大特征值、谱函数
//     - 指示函数、支撑函数、距离函数
//     - 常见函数的凸性证明与反例

//   Section 3.5: Convexity with Respect to Generalized Inequalities (广义不等式下的凸性)
//     - K-凸函数定义、逐分量凸与 PSD 凸的区别
//     - 矩阵凸函数、算子凸简介
//     - 与 Ch 8-9 锥规划约束的联系

// --- Chapter 4: Subgradients and Conjugate Functions (次梯度与共轭函数) ---

//   Section 4.1: Continuity and Differentiability of Convex Functions (凸函数的连续性与可微性)
//     - 有限凸函数在相对内部连续、局部 Lipschitz
//     - 方向导数的存在性与次线性
//     - 可微性：几乎处处可微（Rademacher 定理）、稠密可微点
//     - 上半连续与下半连续、闭凸函数
//     - 下半连续包络与闭包运算

//   Section 4.2: Subgradients and the Subdifferential (次梯度与次微分)
//     - 次梯度定义、次微分集合
//     - 次微分的性质：闭凸、非空有界的条件
//     - 与方向导数的关系：支撑函数表示
//     - 次微分运算法则：和、仿射复合、逐点最大
//     - Fermat 法则：零属于次微分的最优性刻画
//     - 例子：绝对值、范数、指示函数的次微分（法锥）

//   Section 4.3: The Conjugate Function (共轭函数)
//     - Fenchel 共轭定义、几何解释（仿射下界的截距）
//     - Fenchel-Young 不等式与等号成立条件
//     - 共轭的基本性质：凸、下半连续、序反转
//     - 常见函数的共轭表：二次、范数、熵、指示函数
//     - 共轭在建模中的作用：把约束吸收进目标

//   Section 4.4: Biconjugation and Closed Convex Functions (双共轭与闭凸函数)
//     - Fenchel-Moreau 定理：双共轭等于闭凸包络
//     - 闭凸函数的刻画、下半连续包络
//     - 共轭与次微分的对偶关系
//     - 支撑函数与指示函数的共轭对
//     - 对偶理论的伏笔（预告 Ch 7）

//   Section 4.5: Infimal Convolution and Duality of Operations (下卷积与运算的对偶)
//     - 下卷积定义、与共轭的对应：和 ↔ 下卷积
//     - Moreau 包络与 Moreau 分解（预告 Ch 13 近端算子）
//     - 运算对偶表：保凸运算与共轭运算的对照
//     - 边界说明：无穷维与单调算子一般理论见 Analyse Fonctionnelle；
//       本笔记只在有限维处理

// --- Chapter 5: Convex Optimization Problems (凸优化问题) ---

//   Section 5.1: Standard Form and Terminology (标准形式与术语)
//     - 凸优化问题标准形式、可行集与最优集
//     - 凹最大化、目标与约束的凸性要求
//     - 局部最优即全局最优、最优集的凸性
//     - 最优性判据：变分不等式形式与法锥形式
//     - 解的存在性：Weierstrass 条件与强制性（coercivity）

//   Section 5.2: Equivalent Transformations (等价变换)
//     - 消除等式约束：零空间参数化
//     - 上镜图形式（epigraph form）、松弛变量引入
//     - 变量替换、目标的单调变换
//     - 隐式约束与显式约束的相互转化
//     - 变换对问题条件数与算法性能的影响

//   Section 5.3: Quasiconvex and Log-Convex Problems (拟凸与对数凸问题)
//     - 拟凸/拟凹函数、水平集刻画
//     - 拟凸优化的二分法求解
//     - 对数凸与对数凹函数、保凸运算
//     - 对数凹函数的积分性质、Prékopa-Leindler 不等式简介
//     - 拟凸与凸的差距：为何拟凸问题仍"基本可解"

//   Section 5.4: Problems That Can Be Convexified (可凸化问题)
//     - 几何规划：单项式、posynomial、对数变量替换
//     - 分数规划：线性分式、Charnes-Cooper 变换
//     - 广义几何规划与指数锥
//     - 非凸问题的凸松弛思路（预告 Ch 9）
//     - 可凸化的识别技巧与局限

//   Section 5.5: Vector Optimization and Pareto Optimality (向量优化与 Pareto 最优)
//     - 广义不等式下的向量优化问题
//     - Pareto 最优、弱 Pareto 最优、真 Pareto 最优
//     - 标量化：加权法、约束法、加权 Chebyshev 法
//     - 与 Recherche Opérationnelle, Multi-Objective Decision Making 的分工：
//       本笔记负责凸性与标量化理论，运筹学负责 AHP/TOPSIS/目标规划等决策方法

// ==========================================================================
// Part II — Duality Theory (对偶理论)
// ==========================================================================
// 设计思路：本 Part 是全书的理论枢纽。对偶把 Part I 的凸性结构转化为
// 下界、最优性证书、停机准则与分解算法的基础，是 Part III 锥对偶与
// Part IV 对偶类算法的前提。Ch 6 建立 Lagrange 对偶与 KKT 的完整理论，
// Ch 7 给出 Fenchel 对偶与 minimax 视角，并统一推导四类锥规划的对偶。
// LP 对偶的单纯形证明与经济解释归 Recherche Opérationnelle，
// 本 Part 负责一般凸情形的严格证明。
// 对应教材：Boyd Ch 5；扩展 Rockafellar Conjugate Duality and Optimization、
// Borwein-Lewis（Fenchel 对偶与 Sion minimax）

// --- Chapter 6: Lagrange Duality and KKT Conditions (Lagrange 对偶与 KKT 条件) ---

//   Section 6.1: The Lagrange Dual Function and Dual Problem (Lagrange 对偶函数与对偶问题)
//     - Lagrange 函数、乘子符号约定
//     - 对偶函数的凹性（无论原问题是否凸）
//     - 对偶问题、对偶可行解、对偶最优值
//     - 与线性规划对偶的关系：引用 Recherche Opérationnelle,
//       Duality Theory and Sensitivity Analysis
//     - 对偶函数的逐点下确界结构

//   Section 6.2: Weak Duality and the Duality Gap (弱对偶与对偶间隙)
//     - 弱对偶定理、下界性质
//     - 最优对偶间隙、强对偶的定义
//     - 对偶间隙作为停机准则与近似最优性证书
//     - 非凸问题的对偶间隙：为何仍有价值

//   Section 6.3: Constraint Qualifications and Strong Duality (约束规范与强对偶)
//     - Slater 条件（严格可行）与强对偶定理
//     - 仿射约束下的弱化 Slater 条件
//     - 其他约束规范：LICQ、MFCQ、Abadie、相对内部条件
//     - 强对偶失效的反例
//     - 强对偶与对偶最优解存在性的区别

//   Section 6.4: Complementary Slackness and KKT Conditions (互补松弛与 KKT 条件)
//     - 互补松弛条件及其推导
//     - KKT 条件的完整陈述：原始可行、对偶可行、互补松弛、梯度条件
//     - 凸情形：强对偶下 KKT 是充要条件
//     - 非凸情形：KKT 仅为必要条件
//     - 从鞍点角度推导 KKT
//     - 与 Analyse Mathématique, Lagrange Multiplier Method 的关系：
//       本笔记把等式约束乘子法推广到不等式约束与凸性框架

//   Section 6.5: Geometric and Saddle-Point Interpretations (几何与鞍点解释)
//     - 对偶的几何解释：支撑超平面与扰动函数
//     - 下确界投影的几何图像、对偶间隙的几何含义
//     - 鞍点解释、minimax 不等式
//     - 择一定理：Farkas 引理、Gordan 定理、Stiemke 定理
//     - 择一定理与分离定理、对偶定理的三角关系

//   Section 6.6: Perturbation and Sensitivity Analysis (扰动与灵敏度分析)
//     - 扰动函数（最优值函数）及其凸性
//     - 对偶变量作为灵敏度：影子价格的严格凸分析版本
//     - 全局灵敏度界、次梯度刻画
//     - 与 Recherche Opérationnelle, Sensitivity Analysis 的分工：
//       本笔记给出凸分析证明，运筹学给出 LP 的区间计算与经济解释

// --- Chapter 7: Fenchel Duality and Minimax Theory (Fenchel 对偶与 minimax 理论) ---

//   Section 7.1: Fenchel-Rockafellar Duality (Fenchel-Rockafellar 对偶)
//     - 原问题 inf f(x) + g(Ax) 的对偶构造
//     - Fenchel 对偶定理、强对偶的相对内部条件
//     - 与 Lagrange 对偶的等价与相互推导
//     - 共轭在建模中的作用：把约束吸收进目标
//     - 应用：正则化问题的对偶、距离问题的对偶

//   Section 7.2: Minimax Theorems and Saddle Points (minimax 定理与鞍点)
//     - 鞍点存在性、minimax 等式成立的条件
//     - Sion minimax 定理及其证明思路
//     - von Neumann minimax 定理作为特例
//     - 与博弈论的联系：引用 Recherche Opérationnelle,
//       Two-Person Zero-Sum Games
//     - 鞍点问题与原始-对偶算法（预告 Ch 14）

//   Section 7.3: Conic Duality (锥对偶)
//     - 广义不等式约束的 Lagrange 对偶一般形式
//     - LP 对偶的锥推导
//     - QP 与 QCQP 对偶
//     - SOCP 对偶、二阶锥的自对偶性
//     - SDP 对偶、迹内积与 PSD 锥的自对偶性
//     - 四类锥对偶的统一表格

//   Section 7.4: Duality in Practice (对偶的实践用途)
//     - 对偶作为下界与最优性证书
//     - 停机准则设计：绝对间隙与相对间隙
//     - 对偶分解与分布式求解（预告 Ch 14）
//     - 对偶问题更易求解的情形：变量少、约束可分
//     - 最大熵与最小交叉熵问题的对偶
//     - 对偶与正则化的关系、对偶范数

// ==========================================================================
// Part III — Problem Classes and Applications (问题谱系与应用)
// ==========================================================================
// 设计思路：把 Part I-II 的抽象理论落到具体问题类与建模实践。
// Ch 8-9 沿"锥的复杂度"递进：非负象限（LP）→ 二阶锥（SOCP）→ PSD 锥（SDP），
// 展示表达能力的层级与代价。Ch 10-11 展示凸优化在逼近、统计、学习、
// 几何、控制中的建模能力，是理论到应用的桥梁。
// 本 Part 是超出 Boyd 基线最多的部分：SOCP/SDP 独立成章、压缩感知、
// 矩阵补全、CVaR、MPC 均为 Boyd 2004 未纳入或一笔带过的内容。
// 对应教材：Boyd Ch 4.3-4.6、Ch 6、Ch 7、Ch 8；
// 扩展 Lobo et al. (SOCP)、Vandenberghe-Boyd (SDP)、Hastie-Tibshirani-Wainwright、
// Candès-Donoho (压缩感知)、Rockafellar-Uryasev (CVaR)、Rawlings-Mayne-Diehl (MPC)

// --- Chapter 8: Conic Programming: LP, QP and SOCP (锥规划：LP、QP 与 SOCP) ---

//   Section 8.1: Linear Programs (线性规划)
//     - 标准型与不等式型、可行多面体
//     - 顶点最优性、LP 基本定理（引用 Ch 2 极点结构）
//     - LP 作为非负象限锥规划：本笔记的统一视角
//     - 边界说明：单纯形法、运输/指派、灵敏度区间计算见
//       Recherche Opérationnelle, The Simplex Method / Special LP Problems

//   Section 8.2: Quadratic Programs and QCQP (二次规划与二次约束二次规划)
//     - QP 标准型、凸 QP 的判据
//     - 等式约束 QP 的 KKT 线性系统
//     - QCQP、凸 QCQP 的条件
//     - 二次规划到 SOCP 的转化
//     - 应用：Markowitz 组合、带约束最小二乘

//   Section 8.3: Second-Order Cone Programming (二阶锥规划)
//     - 二阶锥（Lorentz 锥）定义与自对偶性
//     - SOCP 标准型、与 LP/QP 的包含关系
//     - 二阶锥表示技巧：范数约束、二次约束、双曲约束
//     - 旋转二阶锥、与指数锥/几何规划的关系
//     - SOCP 的表达能力与建模模式

//   Section 8.4: Robust Optimization and Chance Constraints (鲁棒优化与机会约束)
//     - 鲁棒最小二乘：椭球不确定集的 SOCP 表述
//     - 鲁棒 LP 与不确定集设计：盒式、椭球、多面体、预算型
//     - 机会约束的正态情形转化
//     - 与 Recherche Opérationnelle, Chance Constraints and Robust Optimization
//       的分工：本笔记负责锥表述与凸性证明，运筹学负责建模与随机规划框架

//   Section 8.5: Modeling Practice and Disciplined Convex Programming (建模实践与规范化凸规划)
//     - 原子函数与组合规则、DCP 规则体系（理论基础见 Ch 3 保凸运算）
//     - CVX/CVXPY 建模范式
//     - 常见建模陷阱：伪凸表达、数值尺度、冗余约束
//     - 求解器选择：ECOS、SCS、MOSEK、Gurobi
//     - 建模到求解的完整工作流

// --- Chapter 9: Semidefinite Programming and Combinatorial Relaxation (半定规划与组合松弛) ---

//   Section 9.1: The PSD Cone and SDP Standard Form (PSD 锥与 SDP 标准型)
//     - 对称矩阵空间、PSD 锥的自对偶性
//     - SDP 标准型与不等式型
//     - 线性矩阵不等式（LMI）
//     - Schur 补及其在 LMI 化中的作用
//     - PSD 判定与 Cholesky 分解（引用 Algèbre Linéaire, Quadratic Forms）

//   Section 9.2: SDP Modeling Techniques (SDP 建模技巧)
//     - 特征值优化：最大特征值最小化、谱范数
//     - 矩阵范数与核范数的 SDP 表示
//     - 二次约束的 SDP 松弛、S-procedure
//     - 多项式优化与平方和（SOS）、矩量方法简介
//     - 非凸二次问题的 Shor 松弛

//   Section 9.3: Applications in Systems and Control (系统与控制中的应用)
//     - Lyapunov 稳定性判据的 LMI 形式
//     - H-infinity 与 H2 范数、有界实引理
//     - 状态反馈综合、LQR 的 SDP 表述
//     - 与 Mécanique analytique 的分工：本笔记只做线性系统的凸表述，
//       不涉及连续时间变分原理

//   Section 9.4: Combinatorial Relaxations (组合松弛)
//     - MaxCut 的 SDP 松弛与 Goemans-Williamson 随机舍入
//     - 0.878 近似比的证明思路
//     - 二次指派、图着色、稳定集的 SDP 松弛
//     - Lovász theta 函数
//     - 秩约束与核范数松弛、矩阵补全（衔接 Ch 10）
//     - 边界说明：NP-难与近似算法框架见 Recherche Opérationnelle,
//       Complexity and Approximation

//   Section 9.5: Duality and Degeneracy in SDP (SDP 的对偶与退化)
//     - SDP 对偶、强对偶的失效情形
//     - 严格可行性与 Slater 条件在 SDP 中的微妙性
//     - 退化、面缩减（facial reduction）简介
//     - 与 Ch 6 一般对偶理论的对照

// --- Chapter 10: Approximation, Fitting and Sparse Optimization (逼近、拟合与稀疏优化) ---

//   Section 10.1: Norm Approximation and Least Norm (范数逼近与最小范数问题)
//     - 范数逼近问题、L1/L2/L-infinity 的选择与几何
//     - 最小范数问题及其对偶
//     - 加权范数、死区（deadzone）线性函数
//     - 与 Analyse Numérique, Function Approximation and Curve Fitting 的分工：
//       数值分析负责多项式/样条逼近理论，本笔记负责凸优化表述与正则化

//   Section 10.2: Regularized Approximation (正则化逼近)
//     - L2 正则化（ridge）、L1 正则化（LASSO）
//     - elastic net、正则化路径
//     - 正则化的统计解释：MAP 与先验
//     - 稀疏性的几何解释：L1 球的顶点
//     - 正则化参数的选择（衔接 Ch 11 实验设计与交叉验证）

//   Section 10.3: Robust Approximation (鲁棒逼近)
//     - Huber 损失、epsilon-不敏感损失
//     - 随机鲁棒逼近与最坏情形鲁棒逼近
//     - 异常值处理、重尾噪声
//     - 与 Ch 8 鲁棒优化的联系

//   Section 10.4: Sparse Optimization and Compressed Sensing (稀疏优化与压缩感知)
//     - L0 问题的凸松弛、L1 最小化
//     - 压缩感知：RIP 条件、精确恢复定理
//     - 基追踪（basis pursuit）、基追踪去噪
//     - 贪婪算法（OMP）与凸方法的对比
//     - 稀疏优化的算法选择（衔接 Ch 13 ISTA/FISTA）

//   Section 10.5: Matrix Completion and Low-Rank Recovery (矩阵补全与低秩恢复)
//     - 核范数最小化、秩的凸包络
//     - 矩阵补全的精确恢复条件
//     - 鲁棒 PCA、低秩加稀疏分解
//     - 相位恢复简介
//     - 奇异值阈值算子（衔接 Ch 13 近端算子）

//   Section 10.6: Function Fitting and Model Selection (函数拟合与模型选择)
//     - 参数拟合、基函数选择
//     - 交叉验证与正则化参数选择
//     - 非参数拟合、平滑样条的凸表述
//     - 全变差（TV）正则化与图像去噪
//     - 与 Analyse Numérique 样条理论的衔接

// --- Chapter 11: Applications: Statistics, Learning, Geometry and Control (应用选讲：统计、学习、几何与控制) ---

//   Section 11.1: Statistical Estimation (统计估计)
//     - 参数分布估计、MLE 与 MAP 的凸性条件
//     - 指数族与对数配分函数的凸性
//     - 非参数分布估计、最大熵
//     - 假设检测与最优检测器设计
//     - Chebyshev 与 Chernoff 界的凸优化表述
//     - 实验设计：A-最优、D-最优、E-最优
//     - 边界说明：分布性质与期望计算见 Probabilités

//   Section 11.2: Machine Learning Models (机器学习模型)
//     - 线性判别与 logistic 回归
//     - 支持向量机：原问题、对偶、核技巧
//     - softmax 回归与多分类
//     - 神经网络训练中的凸子问题、损失函数设计
//     - 分类问题的几何解释（衔接 Ch 11 几何问题）
//     - 算法衔接：Ch 13 随机一阶方法、Ch 14 分布式优化

//   Section 11.3: Risk Measures and Portfolio Optimization (风险度量与投资组合)
//     - Markowitz 均值-方差模型
//     - 方差、半方差、下行风险
//     - Value-at-Risk 与 Conditional Value-at-Risk（CVaR）
//     - CVaR 的凸优化表述与 Rockafellar-Uryasev 公式
//     - 交易成本、换手率约束、鲁棒组合
//     - 与 Recherche Opérationnelle 的分工：本笔记负责凸表述，
//       运筹学负责随机规划框架与决策准则

//   Section 11.4: Geometric Problems (几何问题)
//     - 到凸集的投影、两集间距离（引用 Ch 2）
//     - 欧氏距离与角度问题
//     - 极值体积椭球：最大内接椭球（Löwner-John）、最小外接椭球
//     - 中心问题：Chebyshev 中心、最大体积内接球、解析中心
//     - 设施选址与放置问题
//     - 地板规划（floor planning）简介

//   Section 11.5: Optimal Control and MPC (最优控制与模型预测控制)
//     - 离散时间线性系统的最优控制、有限阶段 LQR
//     - 输入/状态约束的凸表述
//     - 模型预测控制（MPC）：滚动时域、稳定性与递归可行性
//     - 显式 MPC 与多参数规划
//     - 边界说明：连续时间变分法与 Euler-Lagrange 方程见
//       Mécanique analytique, Variational Calculus；本笔记只做离散化后的凸问题

// ==========================================================================
// Part IV — Algorithms (算法)
// ==========================================================================
// 设计思路：主线终点，把理论变成可执行的求解方法。
// 按"利用导数信息的程度与问题结构"递进：
// Ch 12 二阶方法（Newton 及其变体，光滑无约束/等式约束）→
// Ch 13 一阶与近端方法（大规模、非光滑、复合结构）→
// Ch 14 算子分裂与对偶算法（可分结构、分布式）→
// Ch 15 内点法（一般约束问题的多项式算法）。
// 本 Part 大量超出 Boyd 基线：近端方法、Nesterov 加速、ADMM、SGD 与方差缩减
// 是 2004 年后的主流工具，Boyd 未纳入，需补充专门参考文献。
// 对应教材：Boyd Ch 9-11；扩展 Nesterov Lectures on Convex Optimization、
// Parikh-Boyd Proximal Algorithms、Beck First-Order Methods in Optimization、
// Bauschke-Combettes、Nocedal-Wright、Boyd et al. (ADMM)、Wright (Primal-Dual IPM)

// --- Chapter 12: Descent Methods and Newton's Method (下降方法与 Newton 法) ---

//   Section 12.1: Descent Method Framework (下降方法框架)
//     - 迭代格式、下降方向、步长
//     - 收敛性分析的一般框架、Zoutendijk 条件
//     - 全局收敛与局部收敛率的区别
//     - 停机准则设计（衔接 Ch 7 对偶间隙）

//   Section 12.2: Line Search (线搜索)
//     - 精确线搜索：黄金分割、Fibonacci
//     - 非精确线搜索：Armijo、Wolfe、强 Wolfe、Goldstein
//     - 回溯线搜索的实现与参数选择
//     - 线搜索与信赖域的对比
//     - 与 Recherche Opérationnelle, One-Dimensional Search 的分工：
//       本笔记负责收敛性理论，运筹学负责方法概览与工程选型

//   Section 12.3: Gradient Descent and Its Rates (梯度下降法及其收敛率)
//     - 最速下降法、锯齿现象
//     - 光滑凸情形的 O(1/k) 率、强凸情形的线性率
//     - 条件数的影响与预处理（引用 Analyse Numérique,
//       Norms, Conditioning and Stability）
//     - 最速下降方向与范数选择：L1/L-infinity 下的坐标方向
//     - 复杂度下界（Nemirovski-Yudin）与最优性

//   Section 12.4: Newton's Method (Newton 法)
//     - Newton 步与 Newton decrement
//     - 仿射不变性、二次收敛
//     - 阻尼 Newton 与回溯线搜索
//     - Newton 法的实现：线性系统求解，引用 Analyse Numérique,
//       Direct Methods for Linear Systems / Iterative Methods for Linear Systems
//     - 等式约束 Newton、不可行启动 Newton、KKT 系统
//     - Newton 法与求根 Newton 法的区别（对照 Analyse Numérique,
//       Nonlinear Equations）

//   Section 12.5: Self-Concordance (自和谐性)
//     - 自和谐函数定义、基本例子
//     - 自和谐函数的 Newton 法分析：无需 Lipschitz 常数
//     - 自和谐障碍（预告 Ch 15）
//     - 广义自和谐与相对光滑
//     - 自和谐性为何是内点法复杂度理论的关键

//   Section 12.6: Quasi-Newton and Conjugate Gradient (拟 Newton 与共轭梯度)
//     - 拟 Newton 方程、割线条件
//     - DFP、BFGS、SR1 更新公式
//     - L-BFGS 的有限存储实现
//     - 线性共轭梯度、非线性共轭梯度（FR、PR、HS、DY）
//     - 与 Newton 法的工程权衡：存储、求值成本、收敛速度

// --- Chapter 13: First-Order and Proximal Methods (一阶与近端方法) ---

//   Section 13.1: Subgradient Methods (次梯度法)
//     - 次梯度法格式、步长规则
//     - 收敛性分析、O(1/sqrt(k)) 率
//     - 投影次梯度法、约束处理
//     - 次梯度法的实践缺陷与改进：迭代平均、Polyak 步长
//     - 应用：拉格朗日对偶求解（衔接 Recherche Opérationnelle,
//       Relaxations and Duality for Integer Programs）

//   Section 13.2: Proximal Operators (近端算子)
//     - 近端算子定义、Moreau 包络（引用 Ch 4）
//     - 存在唯一性、非扩张性、firmly nonexpansive 性质
//     - 常见近端算子表：L1（软阈值）、L2、指示函数（投影）、核范数（SVT）
//     - Moreau 分解、近端算子与共轭的关系
//     - 近端算子的计算：闭式、迭代、二分

//   Section 13.3: Proximal Gradient and ISTA/FISTA (近端梯度与 ISTA/FISTA)
//     - 复合优化问题 f + g 的结构
//     - 近端梯度法（forward-backward splitting）
//     - ISTA、FISTA 的加速机制
//     - 收敛率：O(1/k) 与 O(1/k^2)
//     - 单调性变体与自适应重启
//     - 应用：LASSO、矩阵补全、TV 去噪（衔接 Ch 10）

//   Section 13.4: Accelerated Gradient Methods (加速梯度法)
//     - Nesterov 加速的原始形式与动量解释
//     - 估计序列（estimate sequence）技术
//     - 强凸情形的加速、重启策略
//     - 加速的连续时间极限：ODE 视角
//     - 复杂度下界与加速的最优性
//     - 加速与近端算子的结合

//   Section 13.5: Mirror Descent and Non-Euclidean Geometry (镜像下降与非欧几何)
//     - Bregman 散度、镜像映射
//     - 镜像下降格式与收敛率
//     - 熵镜像下降与单纯形约束
//     - 与近端方法的统一视角
//     - 相对光滑与 NoLips 条件

//   Section 13.6: Stochastic First-Order Methods (随机一阶方法)
//     - SGD 格式、步长衰减、收敛率
//     - 随机近端梯度、mini-batch
//     - 方差缩减：SVRG、SAGA、Prox-SVRG
//     - 自适应方法：AdaGrad、RMSProp、Adam
//     - 随机方法的复杂度下界
//     - 与 Ch 11 机器学习应用的联系

// --- Chapter 14: Operator Splitting and Dual Algorithms (算子分裂与对偶算法) ---

//   Section 14.1: Dual Ascent and Dual Decomposition (对偶上升与对偶分解)
//     - 对偶上升法、对偶次梯度
//     - 对偶分解：可分结构的利用
//     - 收敛性与步长选择
//     - 与 Ch 7 对偶理论的衔接
//     - 对偶分解的局限：非严格凸时的振荡

//   Section 14.2: Augmented Lagrangian and the Method of Multipliers (增广 Lagrange 与乘子法)
//     - 增广 Lagrange 函数、罚项的作用
//     - 乘子法（Hestenes-Powell）格式
//     - 与罚函数法的对比：无需罚参数趋于无穷
//     - 收敛性分析、与近端点算法的等价
//     - 与 Recherche Opérationnelle, Penalty, Barrier and Multiplier Methods
//       的分工：本笔记负责收敛理论，运筹学负责方法概览

//   Section 14.3: ADMM (交替方向乘子法)
//     - ADMM 格式、两步分裂
//     - 收敛性定理与收敛率
//     - 缩放形式（scaled form）与实现细节
//     - 自适应罚参数、残差平衡
//     - 应用：共识优化、分布式优化、LASSO、矩阵补全
//     - ADMM 与 Douglas-Rachford 的等价

//   Section 14.4: Proximal Splitting Methods (近端分裂方法)
//     - 近端点算法（proximal point algorithm）
//     - Douglas-Rachford 分裂
//     - Peaceman-Rachford、forward-backward-forward
//     - Chambolle-Pock 原始-对偶混合梯度（PDHG）
//     - 三算子分裂与 Condat-Vu 方法
//     - 单调算子视角：最大单调、resolvent（有限维自足处理，
//       无穷维理论引用 Analyse Fonctionnelle）

//   Section 14.5: Consensus, Distributed and Parallel Optimization (共识、分布式与并行优化)
//     - 共识优化形式、全局变量与局部变量
//     - 分布式 ADMM、网络拓扑的影响
//     - 异步与去中心化方法
//     - 联邦优化简介
//     - 与 Ch 11 机器学习应用的联系

// --- Chapter 15: Interior-Point Methods (内点法) ---

//   Section 15.1: Inequality Constrained Minimization (不等式约束最小化)
//     - 障碍函数的动机：在可行域内部行走
//     - 对数障碍函数、指示函数的光滑近似
//     - 障碍问题的解与原问题的关系
//     - 与 Ch 9 障碍法/罚函数法概览的衔接

//   Section 15.2: The Central Path (中心路径)
//     - 中心路径定义与参数化
//     - 中心路径的性质：光滑性、收敛到最优解
//     - 对偶间隙与障碍参数的关系
//     - 中心路径的几何直观
//     - 与 Recherche Opérationnelle, Interior-Point Methods: An Overview 的分工

//   Section 15.3: The Barrier Method (障碍法)
//     - 障碍法外迭代/内迭代框架
//     - 障碍参数更新规则、mu 的选择
//     - 收敛性与迭代复杂度
//     - 严格可行启动、相位 I 方法
//     - 障碍法与 Newton 法的结合（引用 Ch 12）

//   Section 15.4: Primal-Dual Interior-Point Methods (原始-对偶内点法)
//     - 修正 KKT 系统、中心路径的原始-对偶刻画
//     - 预测-校正（Mehrotra）方法
//     - 原始-对偶方向的计算、线性系统结构
//     - 步长选择与可行性保持
//     - 收敛性与实际性能

//   Section 15.5: Self-Concordant Barriers and Complexity (自和谐障碍与复杂度)
//     - 自和谐障碍定义、障碍参数
//     - 对数障碍的自和谐性证明（引用 Ch 12）
//     - Nesterov-Nemirovskii 通用复杂度理论
//     - 多项式时间可解性的理论基础
//     - 障碍参数的下界与最优障碍

//   Section 15.6: Conic Interior-Point Methods (锥内点法)
//     - LP 的内点法、Karmarkar 算法的历史地位
//     - QP 与 SOCP 的内点法、Nesterov-Todd 方向
//     - SDP 的内点法、尺度化与对称锥
//     - 对称锥与 Jordan 代数简介
//     - 齐次自对偶嵌入（homogeneous self-dual embedding）
//     - 与 Ch 8-9 锥规划谱系的呼应

//   Section 15.7: Implementation and Solver Landscape (实现与求解器生态)
//     - 线性系统求解：Cholesky、稀疏分解、Krylov，引用 Analyse Numérique
//     - 数值稳定性、尺度化、预处理
//     - 求解器对比：MOSEK、SeDuMi、SDPT3、ECOS、SCS、IPOPT、Gurobi
//     - 内点法与一阶方法的适用边界：精度 vs 规模
//     - 从建模到求解的完整工作流总结（呼应 Ch 8）

// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循"凸性理论 → 对偶 → 问题谱系与应用 → 算法"的四段式主线，
// 共 4 Part、15 Chapter。主线是"从结构到算法"：凸性使问题可解，
// 对偶把结构转化为证书与分解手段，问题谱系展示建模能力，算法给出求解路径。
//
// Part I（Ch 1-5，凸分析基础）：凸集（代数 + 几何）→ 凸函数（初等 + 广义导数）→
//   凸优化问题标准形式。对象递进：集合 → 函数 → 问题。
// Part II（Ch 6-7，对偶理论）：Lagrange 对偶与 KKT → Fenchel 对偶与 minimax →
//   锥对偶统一推导。全书理论枢纽。
// Part III（Ch 8-11，问题谱系与应用）：LP/QP/SOCP → SDP 与组合松弛 →
//   逼近拟合与稀疏优化 → 统计/学习/几何/控制应用选讲。锥复杂度递进 + 建模实践。
// Part IV（Ch 12-15，算法）：下降法与 Newton → 一阶与近端 → 算子分裂与对偶算法 →
//   内点法。按导数信息利用程度与问题结构递进。
//
// 教材覆盖（Boyd & Vandenberghe, Convex Optimization, 2004）：
// - Boyd Ch 1 (Introduction) → Ch 1, Section 1.1
// - Boyd Ch 2 (Convex sets)：2.1 affine & convex → Ch 1, Section 1.2；
//   2.2 important examples → Ch 1, Section 1.3；
//   2.3 operations preserving convexity → Ch 1, Section 1.4；
//   2.4 generalized inequalities → Ch 2, Section 2.4；
//   2.5 separating & supporting hyperplanes → Ch 2, Section 2.2；
//   2.6 dual cones → Ch 2, Section 2.4
// - Boyd Ch 3 (Convex functions)：3.1 basic properties & examples → Ch 3,
//   Section 3.1 与 3.4；3.2 operations preserving convexity → Ch 3, Section 3.3；
//   3.3 conjugate function → Ch 4, Section 4.3-4.4；
//   3.4 quasiconvex functions → Ch 5, Section 5.3；
//   3.5 log-concave & log-convex functions → Ch 5, Section 5.3；
//   3.6 convexity w.r.t. generalized inequalities → Ch 3, Section 3.5
// - Boyd Ch 4 (Convex optimization problems)：4.1 standard form → Ch 5, Section 5.1；
//   4.2 convex optimization → Ch 5, Section 5.1-5.2；4.3 LP → Ch 8, Section 8.1；
//   4.4 QP → Ch 8, Section 8.2；4.5 geometric programming → Ch 5, Section 5.4；
//   4.6 generalized inequality constraints → Ch 8-9；
//   4.7 vector optimization → Ch 5, Section 5.5
// - Boyd Ch 5 (Duality)：5.1 Lagrange dual function → Ch 6, Section 6.1；
//   5.2 Lagrange dual problem → Ch 6, Section 6.1-6.2；
//   5.3 geometric interpretation → Ch 6, Section 6.5；
//   5.4 saddle-point interpretation → Ch 6, Section 6.5 与 Ch 7, Section 7.2；
//   5.5 optimality conditions → Ch 6, Section 6.4；
//   5.6 perturbation & sensitivity → Ch 6, Section 6.6；
//   5.7 examples → Ch 7, Section 7.3-7.4；
//   5.8 theorems of alternatives → Ch 6, Section 6.5
// - Boyd Ch 6 (Approximation & fitting) → Ch 10, Section 10.1-10.3 与 10.6
// - Boyd Ch 7 (Statistical estimation) → Ch 11, Section 11.1
// - Boyd Ch 8 (Geometric problems) → Ch 11, Section 11.4；
//   8.6 classification → Ch 11, Section 11.2；8.7 placement & location → Ch 11, Section 11.4
// - Boyd Ch 9 (Unconstrained minimization) → Ch 12, Section 12.1-12.5
// - Boyd Ch 10 (Equality constrained minimization) → Ch 12, Section 12.4
// - Boyd Ch 11 (Interior-point methods) → Ch 15, Section 15.1-15.5
// - Boyd Appendices A/B/C（数值线性代数背景）→ 裁决为引用 Analyse Numérique，
//   不在本笔记重复
// Boyd 全部 11 章知识点均已覆盖，无遗漏。
//
// 超出 Boyd 基线的扩展清单（依据内容丰富度原则，均为 2004 年后凸优化主流工具）：
// - Ch 2, Section 2.1/2.3/2.5：相对内部与闭包的系统处理、投影与距离、
//   Carathéodory/Radon/Helly/Krein-Milman。Boyd 仅在习题与附录提及。
//   补充文献：Rockafellar Convex Analysis、Schneider Convex Bodies。
// - Ch 3, Section 3.2：强凸与梯度 Lipschitz 的等价刻画。Boyd 未系统处理，
//   但这是全部一阶方法收敛率分析的前提。补充文献：Nesterov、Beck。
// - Ch 4 整章：次梯度、次微分、闭凸函数、Moreau 包络的系统理论。
//   Boyd 只在 Section 3.3 讲共轭函数，完全不讲次梯度。
//   补充文献：Rockafellar、Hiriart-Urruty & Lemaréchal、Bauschke-Combettes。
// - Ch 7, Section 7.1-7.2：Fenchel-Rockafellar 对偶定理、Sion minimax 定理。
//   Boyd 只有鞍点解释，无 Fenchel 对偶的一般定理。补充文献：Rockafellar
//   Conjugate Duality and Optimization、Borwein-Lewis。
// - Ch 8, Section 8.3/8.5：SOCP 独立成章、DCP 建模规则体系。
//   Boyd 在 Section 4.6 一笔带过。补充文献：Lobo et al.、Alizadeh-Goldfarb、
//   Agrawal et al. (DCP)。
// - Ch 9 整章：SDP 独立成章、LMI/Schur 补、SOS 与矩量方法、控制应用、
//   MaxCut 的 GW 松弛。Boyd 在 Section 4.6 与 11.6 提及但无独立章节。
//   补充文献：Vandenberghe-Boyd、Wolkowicz、Goemans-Williamson、Parrilo、Lasserre。
// - Ch 10, Section 10.4-10.6：压缩感知、矩阵补全、鲁棒 PCA、TV 正则化。
//   Boyd 2004 未纳入（压缩感知理论 2006 年才出现）。
//   补充文献：Candès-Romberg-Tao、Donoho、Recht-Fazel-Parrilo、Hastie-Tibshirani-Wainwright。
// - Ch 11, Section 11.2/11.3/11.5：SVM 与 logistic 回归的完整处理、CVaR、MPC。
//   Boyd Section 8.6 有分类但无 CVaR/MPC。补充文献：Cortes-Vapnik、
//   Rockafellar-Uryasev、Rawlings-Mayne-Diehl。
// - Ch 12, Section 12.6：拟 Newton（DFP/BFGS/SR1）、L-BFGS、非线性共轭梯度。
//   Boyd 只提一句。补充文献：Nocedal-Wright、Dennis-Schnabel、Liu-Nocedal。
// - Ch 13 整章：次梯度法、近端算子、ISTA/FISTA、Nesterov 加速、镜像下降、
//   SGD 与方差缩减。Boyd 完全未涉及。补充文献：Nesterov Lectures、
//   Parikh-Boyd Proximal Algorithms、Beck First-Order Methods、
//   Beck-Teboulle (FISTA)、Bottou et al.、Johnson-Guestrin (SVRG)。
// - Ch 14 整章：对偶分解、乘子法、ADMM、Douglas-Rachford、PDHG、共识与分布式。
//   Boyd 完全未涉及。补充文献：Boyd et al. (ADMM 2011)、Parikh-Boyd、
//   Combettes-Pesquet、Chambolle-Pock、Eckstein-Bertsekas、Gabay-Mercier。
// - Ch 15, Section 15.4/15.6/15.7：原始-对偶内点法细节、锥内点法与对称锥、
//   求解器生态。Boyd Section 11.7 有原始-对偶但较简。
//   补充文献：Wright Primal-Dual Interior-Point Methods、Nesterov-Nemirovskii、
//   Ben-Tal-Nemirovski、Karmarkar。
//
// 设计决策记录：
// - 凸集拆为 Ch 1（代数与例子）与 Ch 2（几何与拓扑）：Boyd Ch 2 一章内容过重，
//   分离定理、投影、极点结构、组合凸几何需要独立空间；且 Ch 2 的分离定理与
//   投影定理是 Ch 6 对偶与 Ch 13 近端算法的直接前提，独立成章便于交叉引用。
// - 凸函数拆为 Ch 3（初等性质）与 Ch 4（次梯度与共轭）：次微分与共轭是
//   超出 Boyd 的扩展内容，且体量大、自成体系，与初等凸函数性质分开更清晰。
// - SOCP 与 SDP 各自独立成章（Ch 8 含 SOCP，Ch 9 为 SDP）：二者在现代应用中
//   地位远超 Boyd 成书时，且 SDP 的组合松弛与控制应用需要完整篇幅。
// - Ch 11 把统计、学习、几何、控制四类应用合为一章"应用选讲"：
//   避免应用部分碎片化为四章，每类应用只取凸优化视角的核心模型，
//   深入理论交叉引用到相应笔记。
// - 算法部分按"导数信息利用程度"而非 Boyd 原序排列：Boyd 把内点法放最后，
//   本笔记沿用，但在其前插入一阶近端（Ch 13）与算子分裂（Ch 14），
//   因为现代大规模问题主要靠这两类方法，内点法适用于中等规模高精度场景。
// - 拟 Newton 与共轭梯度并入 Ch 12 而非独立成章：它们是 Newton 法的
//   工程近似，与 Newton 法构成同一方法论谱系。
// - 随机一阶方法（SGD/方差缩减/Adam）放入 Ch 13 而非独立成章：
//   它们是一阶方法的随机化变体，共享收敛分析框架。
// - 数值线性代数背景（Boyd 附录 A/B/C）裁决为引用 Analyse Numérique：
//   仓库已有完整的数值线性代数蓝图，不重复。
// ==========================================================================

#bibliography("references.bib", title: "References", full: true)

// 目录