#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Analyse Numérique",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Analyse Numérique",
  "Violet",
  subtitle: "A notebook for numerical analysis",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This is a notebook for numerical analysis.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
// 主线：误差与稳定性奠基 → 函数逼近与数值微积分 → 数值线性代数
//       → 非线性方程与常微分方程数值解
// 共 4 Part、12 Chapter、64 Section。
//
// 职责边界：
//   - 范数、内积空间、Banach/Hilbert 空间的一般理论 → Analyse Fonctionnelle
//     （交叉引用；本笔记 §2.1 仅建立有限维向量/矩阵范数、诱导范数与谱半径
//      这些数值代数自用的度量工具）
//   - Lebesgue 积分与 L² 空间 → Analyse Réelle（交叉引用）
//   - 线性方程组的代数理论（秩、Cramer 法则、解结构）、Jordan 标准形、
//     内积空间的正交性 → Algèbre Linéaire（交叉引用；本笔记仅负责数值算法
//     与误差分析）
//   - ODE 解析理论（存在唯一性、线性系统、Sturm–Liouville 谱论、边值问题
//     的存在性理论）→ Équation Différentielle Ordinaire（交叉引用；本笔记
//     仅负责数值解法）
//   - Fourier 级数、Fourier 变换与 FFT 快速算法 → Analyse Harmonique
//     （交叉引用；本笔记 §5.6 仅从三角插值与 DFT 的逼近角度讨论）
//   - 正交多项式与特殊函数的一般理论 → Analyse Harmonique（本笔记 §5.4 仅
//     包含数值所需部分：三项递推、零点分布与 Gauss 求积节点）
//   - PDE 数值方法（有限差分/有限元及其稳定性与收敛性理论）→ Équations aux
//     Dérivées Partielles 已有专章 Numerical Methods for PDEs（本笔记不设
//     对应 Section，仅在 Part IV 注释中交叉引用）
//
// 设计决策：
//   - Ch 2 独立成章：两本基线教材均无对应章（内容散落在绪论与直接法误差
//     分析中），集中为统一的精度评判框架供全文复用
//   - 有限维矩阵范数与谱半径（§2.1）留在本笔记：条件数（§2.3）、迭代法收敛
//     判据 ρ(B) < 1（§8.1）、扰动界（§7.6）均以其为语言；一般赋范空间理论
//     仍交由 Analyse Fonctionnelle
//   - 收敛阶（§2.4）前移至 Part I：Richardson 外推（§6.4）、迭代法收敛速度
//     （§8.1–8.3）、RK 阶与相容性（§11.2、§11.5）均需此概念，留在第 10 章
//     会造成大量前向引用
//   - QR 分解（§7.5）与 LU/Cholesky 并列：使离散最小二乘（§5.5）有稳定的
//     数值实现，同时为 QR 算法（§9.5）提供分解工具
//   - Hermite 插值归入 Ch 3（§3.4）：它是整体插值而非分段插值，原置于
//     "分段插值与样条"章内名实不符
//   - IEEE 754 浮点算术独立成节（§1.3），作为舍入误差的物理根源
//   - Krylov 子空间方法（CG/GMRES）在两本基线教材中均非系统覆盖，但作为
//     现代数值代数的核心工具，扩展为 §8.5
//   - SVD 独立成节（§9.6）：与特征值算法同源，现代应用广泛
//   - Ch 11（方法与格式）与 Ch 12（稳定性、刚性与边值问题）拆分：原单章
//     含 7 节，拆后分别聚焦"格式构造"与"稳定性/边值理论"
//
// 教材基线：李庆扬《数值分析》第 5 版 + Burden & Faires
//   《Numerical Analysis》第 10 版 知识点并集（组织顺序独立于教材）。
//
// ==========================================================================
// Part I — Foundations of Numerical Analysis (数值分析基础)
// ==========================================================================
// 设计思路：本 Part 是全书的"度量衡"层。Ch 1 建立误差的四类来源与度量，
// 并下探到浮点算术这一舍入误差的物理根源，最后归纳算法设计技术；Ch 2 从
// 有限维范数与谱半径出发，经前向/后向误差到条件数与收敛阶，形成后续所有
// 算法共用的"精度—效率"评判框架。两者共同回答"什么叫算得准、算得快"。
// 对应教材：李庆扬 第 1 章；Burden & Faires 第 1 章（Ch 2 为组织性扩展，
//   其素材来自两书绪论的误差分析与各章的条件数讨论）。

// --- Chapter 1: Error Analysis (误差分析) ---

//   Section 1.1: Sources of Error (误差来源)
//     - 模型误差、观测误差、截断误差、舍入误差
//     - 误差的定性区分与来源定位
//   Section 1.2: Absolute, Relative Error and Significant Digits (绝对误差、相对误差与有效数字)
//     - 绝对误差与误差限、相对误差
//     - 有效数字的定义与判定；四则运算的误差传播
//   Section 1.3: Floating-Point Arithmetic (IEEE 754) (浮点算术)
//     - 二进制浮点表示、机器精度 ε、上溢与下溢
//     - 浮点运算的舍入规则与误差放大
//   Section 1.4: Catastrophic Cancellation (灾难性抵消)
//     - 相近数相减的误差放大
//     - 误差危害的定性分析与病态实例
//   Section 1.5: Algorithm Design Techniques (算法设计技术)
//     - 秦九韶（Horner）算法与多项式求值
//     - 减少运算次数、避免大数吃小数、以直代曲、化难为易、外推加速

// --- Chapter 2: Norms, Conditioning and Stability (范数、条件数与稳定性) ---

//   Section 2.1: Vector and Matrix Norms (向量与矩阵范数)
//     - 向量 p-范数、矩阵诱导范数与 Frobenius 范数
//     - 相容性、谱半径 ρ(A) 与不等式 ρ(A) ≤ ‖A‖
//   Section 2.2: Forward and Backward Error (前向误差与后向误差)
//     - 前向/后向误差的定义与联系
//     - Wilkinson 后向误差分析思想
//   Section 2.3: Condition Number and Ill-Conditioned Problems (条件数与病态问题)
//     - 条件数的定义、计算与几何意义
//     - 矩阵条件数与病态实例（Hilbert 矩阵等）
//   Section 2.4: Rates of Convergence (收敛阶)
//     - 线性/超线性/二次收敛的定义与误差比刻画
//     - 收敛阶在迭代法与离散化误差分析中的统一用法
//   Section 2.5: Stability of Algorithms (算法的数值稳定性)
//     - 稳定/不稳定算法的判定、增长因子
//     - 稳定性与条件数的分工：问题 vs 算法

// ==========================================================================
// Part II — Polynomial Approximation and Numerical Calculus (多项式逼近与数值微积分)
// ==========================================================================
// 设计思路：本 Part 处理连续对象的离散化，是"函数层面"的计算。
// 插值（Ch 3–4）构造穿过给定点的逼近：Hermite 插值（§3.4）引入导数数据，
// 分段插值与样条（Ch 4）以放弃整体光滑性换取收敛性，正面回应 Runge 现象。
// 整体逼近与拟合（Ch 5）把视角从"插值条件"转为"范数意义下的误差极小化"，
// 其中正交多项式（§5.4）同时为 Gauss 求积（§6.5）提供节点。数值微积分
// （Ch 6）是插值多项式的直接应用，Richardson 外推（§6.4）与自适应策略
// （§6.6）体现"用误差估计驱动算法"的思想，呼应 §2.4 的收敛阶语言。
// 对应教材：李庆扬 第 2–4 章；Burden & Faires 第 3、4、8 章。

// --- Chapter 3: Polynomial Interpolation (多项式插值) ---

//   Section 3.1: Existence and Uniqueness (插值多项式的存在唯一性)
//     - 插值问题适定性、Vandermonde 矩阵
//   Section 3.2: Lagrange Interpolation (Lagrange 插值)
//     - 基函数构造、插值公式与算法
//   Section 3.3: Newton Interpolation and Divided Differences (Newton 插值与差商)
//     - 差商表、Newton 插值公式的递推结构与新增节点
//   Section 3.4: Hermite Interpolation (Hermite 插值)
//     - 带导数值条件的插值、基函数与余项
//     - 重节点差商形式
//   Section 3.5: Interpolation Error and Runge Phenomenon (插值余项与 Runge 现象)
//     - 插值余项定理
//     - Runge 现象：高次插值的振荡与启示

// --- Chapter 4: Piecewise Interpolation and Splines (分段插值与样条) ---

//   Section 4.1: Piecewise Linear Interpolation (分段线性插值)
//     - 分段低次插值的构造与收敛性
//   Section 4.2: Cubic Splines (三次样条)
//     Subsection 4.2.1: Definition and Degrees of Freedom (定义与自由度)
//       - 三条件式定义、4N-2 自由度计数、固支/简支/周期三类边界、not-a-knot 补充
//     Subsection 4.2.2: The Moment Equations (三弯矩方程)
//       - 三弯矩与三转角两种求解框架、三弯矩方程及其推导
//       - 性质：存在唯一性、极小能量（最优光滑）、误差阶与收敛性、良态稳定性
//       - 优缺点小结
//   Section 4.3: B-Splines and Local Bases (B 样条与局部基)
//     - B 样条的递推定义、局部支集与单位分解
//     - de Boor 算法

// --- Chapter 5: Function Approximation and Curve Fitting (函数逼近与曲线拟合) ---

//   Section 5.1: Best Uniform Approximation (最佳一致逼近)
//     - Weierstrass 逼近定理（存在性前提）
//     - Chebyshev 交错定理与 Remez 算法
//     - 有理逼近简介
//   Section 5.2: Chebyshev Polynomials and Economization (Chebyshev 多项式与多项式压缩)
//     - Chebyshev 多项式的性质与极值性质
//     - 多项式次数压缩（economization）
//   Section 5.3: Continuous Least-Squares Approximation (连续最小二乘逼近)
//     - 最佳平方逼近、法方程与 Hilbert 矩阵的病态性（回指 §2.3）
//   Section 5.4: Orthogonal Polynomials (正交多项式)
//     - Legendre/Chebyshev/Laguerre/Hermite 多项式系、三项递推
//     - 正交多项式使法方程对角化；零点分布
//   Section 5.5: Discrete Least-Squares Fitting (离散最小二乘拟合)
//     - 超定方程组与正规方程 AᵀAx = Aᵀb
//     - 正规方程的条件数平方恶化；稳定实现参见 §7.5（QR 分解）
//   Section 5.6: Trigonometric Interpolation and DFT (三角插值与离散 Fourier 变换)
//     - 三角插值、混叠与 DFT 作为逼近工具
//     - FFT 快速算法与 Fourier 级数理论交叉引用 Analyse Harmonique

// --- Chapter 6: Numerical Differentiation and Integration (数值微分与数值积分) ---

//   Section 6.1: Numerical Differentiation (数值微分)
//     - 前向/后向/中心差商、误差阶
//     - 舍入误差与最优步长、外推思想
//   Section 6.2: Newton–Cotes Formulas (Newton–Cotes 公式)
//     - 梯形公式、Simpson 公式、代数精度
//   Section 6.3: Composite Quadrature and Multiple Integrals (复化求积与多重积分)
//     - 复化梯形与复化 Simpson 的误差阶
//     - 张量积公式与矩形区域上的多重积分
//   Section 6.4: Richardson Extrapolation and Romberg Integration (Richardson 外推与 Romberg 积分)
//     - Richardson 外推原理（收敛阶语言见 §2.4）、Romberg 算法
//   Section 6.5: Gaussian Quadrature (Gauss 型求积公式)
//     - 节点-权重联立、2n−1 次代数精度
//     - Gauss–Legendre 公式与误差；节点为正交多项式的零点（§5.4）
//   Section 6.6: Adaptive Quadrature (自适应求积)
//     - 误差控制与区间细分策略

// ==========================================================================
// Part III — Numerical Linear Algebra (数值线性代数)
// ==========================================================================
// 设计思路：本 Part 处理矩阵层面的计算，是数值分析中应用最广、理论最成熟
// 的分支。度量工具（§2.1 的矩阵范数与谱半径）已在 Part I 备妥，此处直接从
// 算法展开：直接法（Ch 7）有限步得解，LU/Cholesky/QR 三大分解构成其骨架，
// 误差分析把舍入误差与条件数联系起来；迭代法（Ch 8）适合大型稀疏系统，
// 收敛速度由谱半径刻画；特征值问题（Ch 9）综合运用分解与迭代思想，是算法
// 理论的集大成者。矩阵代数理论（秩、Jordan 形）交叉引用 Algèbre Linéaire。
// 对应教材：李庆扬 第 5、6、8 章；Burden & Faires 第 6、7、9 章。

// --- Chapter 7: Direct Methods for Linear Systems (线性方程组直接法) ---

//   Section 7.1: Gaussian Elimination (Gauss 消去法)
//     - 消去与回代、运算量 O(n³)
//   Section 7.2: Pivoting Strategies (选主元策略)
//     - 列主元、全主元、标度化与数值稳定性
//   Section 7.3: LU and Cholesky Factorizations (LU 与 Cholesky 分解)
//     - Doolittle/Crout 分解、多右端项求解
//     - 对称正定矩阵的平方根法（Cholesky）及其运算量减半
//     - 带状矩阵与稀疏存储
//   Section 7.4: Tridiagonal Systems and Thomas Algorithm (三对角系统与追赶法)
//     - 追赶法、O(n) 复杂度与对角占优条件
//   Section 7.5: Orthogonal Factorizations and QR Decomposition (正交分解与 QR 分解)
//     - Gram–Schmidt（MGS/CGS）、Householder 与 Givens 变换
//     - 最小二乘问题的稳定求解（回指 §5.5）
//   Section 7.6: Error Analysis for Direct Methods (直接法的误差分析)
//     - 条件数误差界、增长因子与迭代改进

// --- Chapter 8: Iterative Methods for Linear Systems (线性方程组迭代法) ---

//   Section 8.1: Basic Iteration and Convergence (基本迭代格式与收敛性)
//     - 迭代格式的一般构造、谱半径判据 ρ(B) < 1（范数工具见 §2.1）
//     - 收敛速度与平均收敛率
//   Section 8.2: Jacobi and Gauss–Seidel Methods (Jacobi 与 Gauss–Seidel 迭代)
//     - 分量形式与矩阵形式
//   Section 8.3: Successive Over-Relaxation (SOR 松弛法)
//     - 松弛因子 ω、最优松弛参数
//   Section 8.4: Convergence Theorems (收敛定理)
//     - 严格对角占优、不可约弱对角占优、对称正定条件
//   Section 8.5: Krylov Subspace Methods (Krylov 子空间方法)
//     - 共轭梯度法（CG）、GMRES 导论
//     - 与正交化思想（§5.4、§7.5）的联系

// --- Chapter 9: Eigenvalue Problems (特征值问题) ---

//   Section 9.1: Eigenvalue Bounds and Sensitivity (特征值的界与敏感性)
//     - Gershgorin 圆盘定理、特征值的先验估计
//     - 特征值的条件数：对称 vs 非对称（回指 §2.3）
//   Section 9.2: Power and Inverse Power Methods (幂法与反幂法)
//     - 幂法求模最大特征值、收敛速度与谱隙
//     - 反幂法与原点平移
//   Section 9.3: Jacobi Method for Symmetric Matrices (Jacobi 旋转法)
//     - 正交相似变换逐次消元
//   Section 9.4: Householder Reduction (Householder 化简)
//     - Householder 变换、对称三对角化与 Hessenberg 化
//   Section 9.5: The QR Algorithm (QR 算法)
//     - 基本 QR 迭代、位移策略与收敛性
//     - 隐式 QR 与三对角/Hessenberg 形式的算法流程
//   Section 9.6: Singular Value Decomposition (奇异值分解)
//     - SVD 的定义、与对称特征值问题的联系
//     - Golub–Kahan 算法思想、伪逆与低秩逼近

// ==========================================================================
// Part IV — Nonlinear Equations and Numerical ODEs (非线性方程与常微分方程数值解)
// ==========================================================================
// 设计思路：本 Part 处理方程与演化系统的求解。Ch 10 从一维的二分/不动点/
// Newton 出发，经弦截法与抛物线法建立收敛阶对比（定义见 §2.4），再扩展到
// 非线性方程组与拟 Newton 法。Ch 11 构造 ODE 初值问题的格式：Euler 族与
// Runge–Kutta 属单步法，Adams 多步法依赖插值技术（呼应 Part II），方程组与
// 高阶方程降阶使方法可用于实际问题，隐式格式每步内嵌 Newton 迭代（依赖
// Ch 10）。Ch 12 汇集稳定性与边值问题：绝对稳定区域与刚性方程解释显式方法
// 的失效，BDF 与 A-稳定给出对策；打靶法（回指 Ch 10）与有限差分法
// （回指 §7.4）处理边值问题。PDE 数值方法不在此展开，深入理论参见
// Équations aux Dérivées Partielles 的 Numerical Methods for PDEs 一章。
// 对应教材：李庆扬 第 7、9 章；Burden & Faires 第 2、5、10、11 章。

// --- Chapter 10: Nonlinear Equations (非线性方程求根) ---

//   Section 10.1: Bisection Method (二分法)
//     - 区间收缩、线性收敛与停机准则
//   Section 10.2: Fixed-Point Iteration and Acceleration (不动点迭代与加速)
//     - 压缩条件 |g′(x*)| < 1、收敛性定理
//     - Aitken Δ² 加速与 Steffensen 迭代
//   Section 10.3: Newton's Method (Newton 法)
//     - 切线逼近、二次收敛、多重根处理与下山策略
//   Section 10.4: Secant and Muller Methods (弦截法与抛物线法)
//     - 差商替代导数、超线性收敛阶
//     - 抛物线法（Müller）与复根情形
//   Section 10.5: Comparison of Root-Finding Methods (求根方法的收敛阶对比)
//     - 各方法的收敛阶、每步代价与稳健性比较（定义见 §2.4）
//   Section 10.6: Systems of Nonlinear Equations (非线性方程组)
//     - 多元 Newton 法、Jacobian 与收敛性
//     - 拟 Newton（Broyden）法与最速下降法导论

// --- Chapter 11: Numerical Methods for ODEs: One-Step and Multistep (常微分方程数值解：单步法与多步法) ---

//   Section 11.1: One-Step Methods: Euler Family (单步法：Euler 族)
//     - 显式/隐式/梯形/改进 Euler 方法
//     - 局部截断误差与精度阶
//   Section 11.2: Runge–Kutta Methods (Runge–Kutta 方法)
//     - RK 族构造原理、Butcher 表与经典 RK4
//     - 嵌入式方法（RKF45）与步长控制导论
//   Section 11.3: Multistep Methods (多步法)
//     - Adams–Bashforth/Adams–Moulton 公式
//     - 预测-校正格式与起步值
//   Section 11.4: Systems of ODEs and Higher-Order Equations (方程组与高阶方程)
//     - 高阶方程化为一阶方程组、向量形式的格式
//     - 刚性现象的出现（动机，详见 Ch 12）
//   Section 11.5: Consistency and Convergence (相容性与收敛性)
//     - 相容性、零稳定性与 Dahlquist 等价定理（相容 + 零稳定 ⟺ 收敛）
//     - 收敛阶与整体误差的阶条件

// --- Chapter 12: Stability, Stiff Equations and Boundary Value Problems (稳定性、刚性方程与边值问题) ---

//   Section 12.1: Absolute Stability and Stability Regions (绝对稳定性与稳定域)
//     - 模型方程 y′ = λy、绝对稳定区域
//     - A-稳定、L-稳定与阶障碍（Dahlquist 第二障碍）
//   Section 12.2: Stiff Equations and BDF Methods (刚性方程与 BDF 方法)
//     - 刚性的本质与刚性比
//     - 向后微分公式（BDF）、隐式方法的 Newton 内迭代（依赖 §10.3）
//   Section 12.3: Shooting Methods for BVPs (边值问题的打靶法)
//     - 线性打靶法、非线性打靶法与 Newton 迭代
//   Section 12.4: Finite Difference Methods for BVPs (边值问题的有限差分法)
//     - 差分格式、截断误差与稳定性
//     - 三对角线性系统的求解（依赖 §7.4）
//   Section 12.5: Spline Methods and Eigenvalue BVPs (样条方法与边值特征值问题)
//     - 样条配置法（回指 Ch 4）
//     - Sturm–Liouville 型边值特征值的数值逼近（解析理论见 Équation Différentielle Ordinaire）

// ==========================================================================
// Appendix (附录)
// ==========================================================================
// 设计思路：术语表由 violet-glossary-indexer 依据正文标签生成。需特别注意
// "稳定性"一词在不同 Part 中的含义差异：Part I 指算法的数值稳定性，Ch 8 指
// 迭代收敛，Ch 12 指数值方法的绝对稳定性；"阶"亦同时用于收敛阶（§2.4）与
// 方法的精度阶（§11.1）。术语表须为这些同名异义给出区分。

// --- Appendix A: Glossary (术语表) ---

// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循"基础奠基 → 函数逼近 → 矩阵计算 → 方程求解"的对象递进主线，
// 共 4 Part、12 Chapter。
//
// Part I（Ch 1–2，数值分析基础）：误差四源、有效数字、浮点算术与算法
//   设计技术（Ch 1）；向量与矩阵范数、谱半径、前向/后向误差、条件数、
//   收敛阶与算法稳定性（Ch 2），构成全书的精度评判框架。
//
// Part II（Ch 3–6，多项式逼近与数值微积分）：插值（含 Hermite）→ 分段
//   插值与样条 → 最佳一致/平方逼近、正交多项式与三角插值 → 数值微分与
//   积分，完成连续对象在函数层面的离散化。
//
// Part III（Ch 7–9，数值线性代数）：直接法（LU/Cholesky/QR）、迭代法
//   （含 Krylov）、特征值问题（含 Gershgorin 界与 SVD），矩阵层面的
//   求解与算法理论。
//
// Part IV（Ch 10–12，非线性方程与常微分方程数值解）：非线性求根与方程组、
//   ODE 单步/多步法与方程组形式、绝对稳定性/刚性方程/边值问题。
//
// 教材覆盖：李庆扬《数值分析》第 5 版全部 9 章知识点均已覆盖（Ch 2 的
//   范数与收敛阶为跨章集中化处理）；Burden & Faires《Numerical Analysis》
//   第 10 版核心章节（Ch 1–11）知识点均已覆盖，并补充 Krylov 方法、
//   QR/SVD 的数值实现、IEEE 754 浮点算术等现代扩展内容。PDE 数值方法
//   （B&F Ch 12）归属 Équations aux Dérivées Partielles。
// ==========================================================================

#part("Foundations of Numerical Analysis") // 数值分析基础

= Error Analysis // 误差分析

Numerical analysis studies how to approximate the solution of a mathematical problem with finitely many arithmetic operations, and how large the resulting deviation can be.
Four distinct sources of error enter this process, and only two of them are under the control of the algorithm designer.
This chapter builds the language for measuring error, locates the physical origin of rounding error in floating-point arithmetic, and derives the first quantitative consequence: the catastrophic loss of accuracy caused by subtracting nearly equal numbers.
The closing section turns these observations into design principles, and explains why accuracy cannot be pushed to its limit: truncation and rounding errors respond in opposite directions to the same parameter.

== Sources of Error // 误差来源

Every numerical computation replaces an exact problem by a chain of approximations.
The chain has four links, and each link contributes its own error.

#tex-table(
  ("Source", "Where it enters", "Controllable", "Typical size"),
  ("Model error", "The mathematical model idealizes the real problem", "No", "not quantifiable"),
  ("Data error", "The input data are measured, hence inexact", "No", "inherited from the measurement"),
  (
    "Truncation error",
    "An infinite or continuous process is replaced by a finite or discrete one",
    "Yes",
    [decreases with the step size $h$],
  ),
  (
    "Roundoff error",
    "Real numbers are replaced by floating-point numbers",
    "Yes",
    [of the order of $u$, independent of $h$],
  ),
)

The first two links belong to the modelling stage and cannot be repaired by any numerical method: a biased model or a miscalibrated instrument corrupts every subsequent step equally.
The last two links belong to the computation, and they are the subject of this notebook.
The next two definitions isolate them.

#definition(name: "Truncation Error")[
  Let $x$ be the exact value produced by an infinite or continuous mathematical operation, and let $T_h (x)$ be the value produced when that operation is replaced by a finite or discrete process governed by a parameter $h$.
  The difference $x - T_h (x)$ is called the *truncation error* (or *discretization error*) of the process.
] <def:truncation-error>

#definition(name: "Roundoff Error")[
  Let $z$ be an exact real number and let $"fl"(z)$ be the floating-point number that represents it.
  The difference $z - "fl"(z)$ is called the *roundoff error* of the representation.
] <def:roundoff-error>

Truncation error is a property of the method alone: it is present even in exact arithmetic, and it vanishes only if the finite process is allowed infinitely many steps.
Roundoff error is a property of the arithmetic alone: it is present even when the method is exact, and it never vanishes because the real numbers involved usually require infinitely many digits.
A numerical method is therefore judged by two independent questions, namely how fast the truncation error decays and how the roundoff error accumulates.

#example(name: "Truncating the geometric series")[
  For $abs(x) < 1$ the value $1/(1 - x)$ is the sum of the infinite series $sum_(k=0)^oo x^k$.
  Summing only the first $n + 1$ terms gives
  $
    abs(1/(1 - x) - sum_(k=0)^n x^k) = (abs(x)^(n+1))/(1 - abs(x)),
  $
  which tends to zero as $n -> oo$ but stays positive for every finite $n$.
  The gap is produced by truncation only; no arithmetic error is involved.
  Take $x = 1/2$ and $n = 10$.
  The truncation error is $2^(-11) approx 4.9 times 10^(-4)$, while the summands are exactly representable, so the computed sum carries no roundoff error at all.
]

#note[
  This chapter analyses only truncation and roundoff errors.
  The abstract counterpart of truncation, namely the rate at which a sequence of approximations approaches its limit, is formalized as the order of convergence in *Ch 2*.
  The competition between the two errors is visible already in the example above: raising $n$ reduces truncation but adds more arithmetic operations, hence more opportunity for roundoff.
]

== Absolute and Relative Error, Significant Digits // 绝对误差、相对误差与有效数字

Let $x$ be an exact value and $x^*$ an approximation of it.
Two questions must be answered before any error can be called large or small: how far apart are the two numbers, and how far apart are they compared with the size of $x$ itself.
The first question leads to the absolute error, the second to the relative error.

#definition(name: "Absolute Error and Error Bound")[
  The *absolute error* of the approximation $x^*$ is
  #eq[$
    e = x^* - x.
  $] <eq:absolute-error>
  A number $epsilon >= 0$ satisfying $abs(e) <= epsilon$ is called an *absolute error bound*.
] <def:absolute-error>

In practice $x$ is unknown, so $e$ cannot be computed either; what a numerical method can supply is a bound $epsilon$, derived from the method and from the arithmetic.

#definition(name: "Relative Error")[
  For $x^* != 0$, the *relative error* of the approximation is
  #eq[$
    e_r = (x^* - x)/(x^*),
  $] <eq:relative-error>
  and $epsilon_r = epsilon slash abs(x^*)$ is a *relative error bound* whenever $abs(e) <= epsilon$.
] <def:relative-error>

#note(title: "Which denominator?")[
  Many textbooks divide by the exact value $x$ instead of the approximation $x^*$.
  The two conventions differ by a factor $1 + O(u)$, which is irrelevant at the level of accuracy that error bounds usually target.
  The choice made here uses only quantities that are actually available, and it keeps the statements on significant digits and on the relative error of a difference free of extra hypotheses.
]

Among the two, only the relative error is invariant under a change of units, and only the relative error stays meaningful across different scales.
This is why floating-point arithmetic, which knows nothing about the scale of a problem, is naturally described by relative errors.

A different and more practical way of reporting accuracy is to count the digits that can be trusted.

#definition(name: "Significant Digits")[
  Write the approximation in normalized decimal form
  #eq[$
    x^* = ±0.a_1 a_2 dots times 10^m, quad a_1 != 0.
  $] <eq:decimal-normal-form>
  If its absolute error satisfies
  #eq[$
    abs(x - x^*) <= 0.5 times 10^(m - n),
  $] <eq:significant-digits>
  then $x^*$ is said to have $n$ *significant digits*.
] <def:significant-digits>

The condition says that the error does not exceed half a unit in the $n$-th decimal place of $x^*$, counted from the leading nonzero digit.
Significant digits therefore measure relative accuracy, not absolute accuracy, and the following theorem makes the conversion explicit.

#theorem(name: "Significant Digits and Relative Error")[
  Let $x^* = ±0.a_1 a_2 dots times 10^m$ with $a_1 != 0$ have $n$ significant digits.
  Then
  $
    abs(e_r) <= 1/(2 a_1) times 10^(1 - n).
  $
  Conversely, if the relative error satisfies
  $
    abs(e_r) <= 1/(2 (a_1 + 1)) times 10^(1 - n),
  $
  then $x^*$ has at least $n$ significant digits.
] <thm:significant-digits-relative-error>

#proof[
  *Forward direction.* By @eq:significant-digits we have $abs(x - x^*) <= 0.5 times 10^(m-n)$, while @eq:decimal-normal-form gives $abs(x^*) >= a_1 times 10^(m-1)$.
  Dividing the two,
  $
    abs(e_r) = (abs(x - x^*))/(abs(x^*)) <= (0.5 times 10^(m-n))/(a_1 times 10^(m-1)) = 1/(2 a_1) times 10^(1-n).
  $

  *Converse.* Suppose the relative error bound holds.
  Since the decimal expansion of $x^*$ starts with $a_1$, we have $abs(x^*) < (a_1 + 1) times 10^(m-1)$, hence
  $
    abs(x - x^*) <= abs(e_r) abs(x^*) < 1/(2(a_1 + 1)) times 10^(1-n) dot (a_1 + 1) times 10^(m-1) = 0.5 times 10^(m-n),
  $
  which is precisely @eq:significant-digits for $n$ digits.
]

#example(name: "Significant digits of approximations to $pi$")[
  Take $pi = 3.14159265 dots$ and the two approximations $x_1^* = 3.1416$ and $x_2^* = 3.14$.
  In normalized form $x_1^* = 0.31416 times 10^1$, so $m = 1$ and $a_1 = 3$, and
  $
    abs(pi - x_1^*) approx 7.3 times 10^(-6) <= 0.5 times 10^(-4) = 0.5 times 10^(m-5),
  $
  so $x_1^*$ has five significant digits.
  For $x_2^*$ the corresponding bound is $0.5 times 10^(-2)$ and $abs(pi - x_2^*) approx 1.6 times 10^(-3)$, so $x_2^*$ has three significant digits.
  The theorem gives the matching relative error bounds $abs(e_r) <= 1.7 times 10^(-5)$ and $abs(e_r) <= 1.7 times 10^(-3)$.
]

#caution[
  Significant digits are not decimal places.
  The numbers $0.000314$ and $3.14$ both have three significant digits, yet they differ by three orders of magnitude; their relative accuracy is the same, their absolute accuracy is not.
  Reporting an absolute error in a context where the scale of the answer varies, as it does in floating-point computation, hides exactly the information that matters.
]

Error bounds propagate through arithmetic in a way that is easy to remember: absolute bounds add under addition and subtraction, relative bounds add under multiplication and division.

#proposition(name: "Propagation of Error in Arithmetic")[
  Let $x_1, x_2$ be exact values approximated by $x_1^*, x_2^*$ with absolute error bounds $epsilon_1, epsilon_2$ and relative error bounds $epsilon_(r 1), epsilon_(r 2)$.
  Then
  #eq[$
    epsilon (x_1^* ± x_2^*) = epsilon_1 + epsilon_2, quad epsilon_r (x_1^* x_2^*) <= epsilon_(r 1) + epsilon_(r 2), quad epsilon_r (x_1^* slash x_2^*) <= epsilon_(r 1) + epsilon_(r 2),
  $] <eq:error-propagation>
  where the last two inequalities hold to first order in the relative errors and require $x_2^* != 0$.
] <prop:error-propagation-arithmetic>

The additive rules follow from the triangle inequality and from writing the perturbed quantities as $x_i^* = x_i (1 + delta_i)$.
For the product, $x_1^* x_2^* = x_1 x_2 (1 + delta_1)(1 + delta_2)$, so the relative error is $delta_1 + delta_2 + delta_1 delta_2$, and the last term is negligible because both factors are below $u$ in the applications below.
For the quotient the same expansion gives $delta_1 - delta_2$ to first order, and the sign is irrelevant for a bound.

The rule for subtraction deserves separate attention, because it is the only one in which a small absolute bound can translate into a large relative bound.

#corollary(name: "Relative Error of a Difference")[
  If $x_1^* != x_2^*$, then
  $
    abs(e_r (x_1^* - x_2^*)) <= (epsilon_1 + epsilon_2)/(abs(x_1^* - x_2^*)).
  $
  The right-hand side is unbounded as the two approximations approach each other.
] <cor:relative-error-difference>

#example(name: "A small term swallowed by a large one")[
  Suppose a measurement gives $x_1 = 1000$ with absolute error bound $0.5$ and $x_2 = 0.001$ with absolute error bound $0.0005$, and consider the sum.
  By @eq:error-propagation the sum $1000.001$ carries an absolute error bound of $0.5005$, hence a relative error bound of $5.0 times 10^(-4)$.
  The second summand contributes only $10^(-6)$ to the relative error of the result, so all the digits describing $x_2$ are lost in the sum, although none of them was lost in $x_2$ itself.
  The lesson is that absolute and relative accuracy are not interchangeable, and that the order in which terms are combined matters.
]

== Floating-Point Arithmetic // 浮点算术

The relative error language of the previous section is the natural one for machines, because a computer cannot store a real number, only a rounded copy of it.
The set of available numbers is finite and is not distributed uniformly: the same relative precision is offered in every decade.

#definition(name: "Floating-Point Number System")[
  Let $beta >= 2$ be an integer base, $t in bb(N)$ a precision, and $L <= U$ two integers delimiting the exponent range.
  The *floating-point number system* $F(beta, t, L, U)$ consists of zero together with all numbers of the form
  #eq[$
    x = ±0.d_1 d_2 dots d_t times beta^e, quad d_1 != 0, quad d_i in {0, 1, dots, beta - 1}, quad L <= e <= U.
  $] <eq:floating-point-representation>
  Numbers with $d_1 != 0$ are called *normalized*.
] <def:floating-point-system>

Two constants attached to a system measure its precision, and they differ by a factor $2$, a fact that is a permanent source of confusion when results from different sources are compared.

#definition(name: "Machine Epsilon")[
  The *machine epsilon* of $F(beta, t, L, U)$ is
  $
    epsilon_"mach" = beta^(1 - t),
  $
  the distance from $1$ to the next larger floating-point number.
] <def:machine-epsilon>

#definition(name: "Unit Roundoff")[
  The *unit roundoff* of $F(beta, t, L, U)$ is
  #eq[$
    u = 1/2 beta^(1 - t).
  $] <eq:unit-roundoff>
] <def:unit-roundoff>

#note(title: "Two conventions")[
  Both $epsilon_"mach"$ and $u$ appear in the literature under the name "machine epsilon", and they differ by exactly a factor of two.
  This notebook uses $u$ throughout, because $u$ is the largest relative error produced by rounding, and it is the constant that appears in every error bound of the sequel.
  For IEEE double precision, $u = 2^(-53) approx 1.11 times 10^(-16)$ and $epsilon_"mach" = 2^(-52) approx 2.22 times 10^(-16)$.
]

The following lemma records how the gap between neighbouring floating-point numbers scales, and it is the only structural fact needed to derive the rounding model.

#lemma(name: "Relative Spacing of Floating-Point Numbers")[
  Let $x in F(beta, t, L, U)$ be normalized with exponent $e$, and let $"ulp"(x) = beta^(e - t)$ be the distance between $x$ and its nearest neighbour having the same exponent.
  Then
  $
    beta^(-t) < ("ulp"(x))/(abs(x)) <= beta^(1 - t).
  $
] <lem:relative-spacing>

#proof[
  A normalized number with exponent $e$ satisfies $beta^(e-1) <= abs(x) < beta^e$, and all floating-point numbers sharing this exponent are spaced by $"ulp"(x) = beta^(e-t)$.
  Dividing the spacing by $abs(x)$ and inserting the two extremes of the allowed range,
  $
    (beta^(e-t))/(beta^e) < ("ulp"(x))/(abs(x)) <= (beta^(e-t))/(beta^(e-1)),
  $
  which is the claim.
]

Rounding to the nearest representable number can therefore be absorbed into a multiplicative factor, and this is the form in which roundoff error will be handled from now on.

#proposition(name: "Standard Model of Floating-Point Arithmetic")[
  Assume round-to-nearest and assume that no overflow, underflow or division by zero occurs.
  Then for all real $x, y$ and every elementary operation $op in {+, -, times, slash}$,
  #eq[$
    "fl"(x op y) = (x op y)(1 + delta), quad abs(delta) <= u,
  $] <eq:fl-model>
  where $"fl"(dot)$ denotes the computed result, provided $x op y$ lies in the normalized range of the system.
] <prop:fl-rounding-model>

#proof[
  Denote by $z = x op y$ the exact result and by $"fl"(z)$ its rounded value, and let $e$ be the exponent of $z$.
  Rounding to nearest moves $z$ by at most half a unit in the last place, so
  $
    abs("fl"(z) - z) <= 1/2 "ulp"(z) <= 1/2 beta^(1-t) abs(z) = u abs(z),
  $
  the second inequality being #link(<lem:relative-spacing>)[*Relative Spacing of Floating-Point Numbers*].
  Setting $delta = ("fl"(z) - z)/z$ gives @eq:fl-model.
]

@eq:fl-model is the pivot of numerical error analysis: every algorithm studied in this notebook is a finite sequence of such operations, so its roundoff error is a product of factors $1 + delta$ whose size is bounded by $u$.
The only question left is how many of these factors accumulate along a computation, which is the subject of *Ch 2*.

#example(name: "IEEE double precision")[
  The standard binary64 format has $beta = 2$, $t = 53$, $L = -1022$ and $U = 1023$.
  Hence $u = 2^(-53) approx 1.11 times 10^(-16)$ and $epsilon_"mach" = 2^(-52) approx 2.22 times 10^(-16)$, which is why a double precision computation is said to carry about sixteen decimal digits of relative accuracy.
  The smallest positive normalized number is $2^(-1022) approx 2.2 times 10^(-308)$ and the largest is $(1 - 2^(-53)) 2^(1024) approx 1.8 times 10^(308)$; values beyond this range overflow, values below it are represented as subnormal numbers with a reduced number of significant digits.
]

#example(name: "The number $0.1$ is not a floating-point number")[
  In base $2$ the fraction $0.1$ has the nonterminating expansion $0.0001100110011 dots_2$, so its stored value is not $0.1$ but the nearest binary64 number, whose decimal expansion is $0.1000000000000000055511151231257827$.
  Since $abs(0.1) in [2^(-4), 2^(-3))$, we have $"ulp"(0.1) = 2^(-55)$, so the representation error does not exceed $2^(-56) approx 1.4 times 10^(-17)$, in agreement with @eq:fl-model.
  The same phenomenon explains why the computed value of $0.1 + 0.2$ is $0.30000000000000004$ and not $0.3$: the two representation errors survive the addition and are then rounded once more.
]

#example(name: "Addition is not associative")[
  Let $u = 2^(-53)$, $a = 1$, $b = 2^(-53)$ and $c = -1$.
  Computing $(a + b) + c$ first forms $1 + 2^(-53)$, a number exactly halfway between two floating-point numbers, which rounds back to $1$; subtracting $c$ then gives $0$.
  Computing $a + (b + c)$ first forms $b + c = -1 + 2^(-53)$, which is representable exactly; adding $a$ then gives $2^(-53) approx 1.11 times 10^(-16)$.
  The two groupings differ by the whole size of the summand, so the order of summation is part of the algorithm and not a matter of taste.
]

#figure(
  image("img/floating-point-spacing.svg", width: 92%),
  caption: [Floating-point numbers in $F(2, 4, -2, 2)$. Top: the grid is uniform inside each decade and doubles its spacing at every power of the base. Bottom: the relative spacing $"ulp"(x) slash abs(x)$ oscillates between $beta^(-t)$ and $beta^(1-t)$, so that the same relative precision is available at every scale.],
) <fig:floating-point-spacing>

#note(title: "Beyond the normal range")[
  Four features of IEEE 754 are deliberately left out of @eq:fl-model, and each of them breaks it in a different way.
  Subnormal numbers, which fill the gap between zero and the smallest normalized number, have fewer than $t$ significant digits, so #link(<lem:relative-spacing>)[*Relative Spacing of Floating-Point Numbers*] fails there and the relative error can be much larger than $u$.
  Overflow produces $infinity$ and underflow may produce zero, and neither is a perturbation of the exact result.
  The value $"NaN"$ propagates through any operation that touches it, so a single invalid operation contaminates the whole computation.
  Finally, the four rounding modes of the standard differ in the bound of #link(<prop:fl-rounding-model>)[*Standard Model of Floating-Point Arithmetic*]: directed rounding replaces $u$ by $beta^(1-t)$, while round-to-nearest, used everywhere below, gives the tighter constant $u$.
]

== Catastrophic Cancellation // 灾难性抵消

The corollary on the relative error of a difference already announced the danger: a small denominator converts negligible absolute errors into a large relative error.
With @eq:fl-model at hand, the size of the amplification can be computed exactly.

#proposition(name: "Amplification of Error by Cancellation")[
  Let $x != y$ be real numbers represented by $tilde(x) = x (1 + delta_1)$ and $tilde(y) = y (1 + delta_2)$ with $abs(delta_i) <= u$, and suppose the subtraction itself is performed exactly.
  Then
  #eq[$
    abs((tilde(x) - tilde(y)) - (x - y)) <= u (abs(x) + abs(y)),
  $] <eq:cancellation-bound>
  so the relative error of the computed difference obeys
  #eq[$
    (abs((tilde(x) - tilde(y)) - (x - y)))/(abs(x - y)) <= u K, quad K = (abs(x) + abs(y))/(abs(x - y)).
  $] <eq:cancellation-factor>
] <prop:cancellation-amplification>

#proof[
  Expanding the perturbation,
  $
    (tilde(x) - tilde(y)) - (x - y) = x delta_1 - y delta_2,
  $
  and the triangle inequality together with $abs(delta_i) <= u$ gives $abs(x delta_1 - y delta_2) <= u (abs(x) + abs(y))$, which is @eq:cancellation-bound.
  Dividing by $abs(x - y)$ produces @eq:cancellation-factor.
]

The factor $K$ is the ratio between the size of the operands and the size of their difference.
When $x$ and $y$ agree in their first $k$ decimal digits, $K$ is of the order of $10^k$, and every one of those digits is destroyed: the computed difference carries only the digits that were never trustworthy in the first place.
The subtraction is not the culprit, and in fact it can be shown to be exact in floating point whenever $y slash 2 <= x <= 2 y$; the damage is done by the representation of the inputs, which the subtraction merely exposes.

#example(name: "A quadratic equation with a badly cancelled root")[
  Consider $x^2 - 2 p x + q = 0$ with $p = 10^8$ and $q = 1$, whose roots are $p ± sqrt(p^2 - q)$.
  The smaller root equals $p - sqrt(p^2 - q) = q slash (p + sqrt(p^2 - q)) approx 5 times 10^(-9)$, and the two terms in the subtraction differ by less than their own representation error $u p approx 1.1 times 10^(-8)$.
  In double precision the quantity $p^2 - q = 10^16 - 1$ is not representable, since the spacing near $10^16$ is $2$; it rounds back to $10^16$, whose square root is exactly $10^8$.
  The computed smaller root is therefore $0$, an error of one hundred percent, while the larger root is computed accurately.
  Dividing the constant term by the large root, $x_- = q slash (p + sqrt(p^2 - q))$, computes the same number with full relative accuracy, because it replaces a subtraction of nearly equal quantities by a sum and a division.
]

#example(name: "A trigonometric expression near zero")[
  The function $(1 - cos x) slash x^2$ tends to $1 slash 2$ as $x -> 0$, yet a direct evaluation at $x = 10^(-4)$ fails.
  Here $cos x approx 1 - x^2 slash 2$, so $1 - cos x approx 5 times 10^(-9)$, while the absolute error in the computed cosine is of the order of $u approx 1.1 times 10^(-16)$.
  The relative error of the numerator is thus of the order of $2 times 10^(-8)$, and about eight significant digits are lost before the division by $x^2$ is even performed.
  The identity $1 - cos x = 2 sin^2 (x slash 2)$ turns the expression into $(1 slash 2) (sin (x slash 2) slash (x slash 2))^2$, in which no subtraction of nearby numbers occurs and the limiting value is obtained with full accuracy.
]

The two examples illustrate the three standard remedies, all of which amount to replacing a subtraction of nearby numbers by an operation that does not cancel:

- *Rationalization.* Multiply by the conjugate, as in the quadratic example, to move the small difference to the denominator.
- *Trigonometric or algebraic identities.* Use $1 - cos x = 2 sin^2 (x slash 2)$ or $1 - e^x = (e^x - 1)$ series forms to express the difference as a product.
- *Series expansion.* Replace the difference by its leading Taylor terms when the argument is known to be small.

#caution[
  Cancellation is not by itself a defect of an algorithm.
  The factor $K$ in @eq:cancellation-factor belongs to the problem, not to the method: whenever the answer is genuinely much smaller than the data, some of the input information must be lost, and no rearrangement can create digits that were never present.
  The part of the loss that can be avoided is the part contributed by the algorithm, and separating the two contributions requires the notion of condition number developed in *Ch 2*.
]

== Algorithm Design Techniques // 算法设计技术

The preceding sections supply both the diagnosis and the cure: roundoff error enters through individual operations, and its effect is governed by how the operands relate to the result.
The following principles collect the consequences, and each of them is a statement about the shape of a formula rather than about the machine.

- *Avoid subtracting nearly equal numbers.* Rewrite the expression whenever the answer is a small difference of large quantities, as in the quadratic example above.
- *Avoid adding a small number to a large one.* The small term disappears once it falls below half a unit in the last place of the large one.
- *Reduce the number of operations.* Every operation potentially injects a factor $1 + delta$, so shorter formulas accumulate less error and also run faster.
- *Avoid dividing by a small quantity.* A small denominator amplifies whatever error the numerator already carries, in the same way that a small difference does.
- *Choose an algorithm whose error growth is controlled.* Two formulas for the same quantity may differ by many orders of magnitude in accuracy; this principle is made precise by the notion of stability in *Ch 2*.

The second principle has a quantitative form that explains why summation order matters.

#example(name: "A small number added to a large one")[
  In double precision $u = 2^(-53) approx 1.11 times 10^(-16)$, so a unit added to $10^16$ is smaller than half the spacing at that scale, and
  $
    (10^16 + 1) - 10^16 = 0, quad "while" quad 10^16 + (1 - 10^16) = 2^(-53).
  $
  The same effect destroys the tail of a long sum: adding $10^6$ copies of $1$ to $10^16$ one at a time leaves the value $10^16$ unchanged, because each individual increment $1$ is below the rounding threshold, whereas summing the small terms first and adding the total once gives the correct answer.
]

#note(title: "Compensated summation")[
  When the order of the summands cannot be chosen, the lost low-order digits can be recovered explicitly.
  Kahan's compensated summation keeps a running correction term and adds it back at each step, which reduces the error growth of a sum of $n$ terms from $O(n u)$ to $O(u)$ independent of $n$.
  The price is one extra addition and one extra subtraction per term, which illustrates the general trade-off between accuracy and operation count.
]

The third principle is particularly effective for polynomials, where the same value can be computed by radically different numbers of operations.

#proposition(name: "Horner Scheme")[
  Let $p(x) = a_0 + a_1 x + dots + a_n x^n$ with $a_n != 0$.
  Then
  #eq[$
    p(x) = a_0 + x (a_1 + x (a_2 + dots + x (a_(n-1) + a_n x) dots )),
  $] <eq:horner>
  and this nested form requires exactly $n$ multiplications and $n$ additions.
] <prop:horner-scheme>

Evaluating the powers separately and then summing costs $n (n+1) slash 2$ multiplications plus $n$ additions, so the saving grows quadratically with the degree.
The advantage is not only speed: fewer operations mean fewer rounding factors, and the nested form also avoids forming the large intermediate powers $x^k$.

#example(name: "Horner evaluation")[
  Let $p(x) = 2 x^3 - 3 x^2 + 4 x - 5$ and $x = 1.37$.
  The nested form gives
  $
    ((2 dot 1.37 - 3) dot 1.37 + 4) dot 1.37 - 5 = -0.007994,
  $
  while evaluating $2 x^3$, $3 x^2$ and $4 x$ separately and adding them gives the same value with three times as many multiplications.
  The difference is invisible here, but the saved operations matter when $p$ is evaluated millions of times, or when $n$ is large and the intermediate powers $x^k$ overflow or lose significance.
]

Finally, the tension between truncation and roundoff gives the last principle a quantitative form.

#proposition(name: "Optimal Step Size for a Difference Quotient")[
  Let $f$ be twice continuously differentiable with $abs(f'') <= M$ on the interval of interest, and let $epsilon$ be a bound for the absolute error in each computed value of $f$.
  The total error of the forward difference $(f(x + h) - f(x)) slash h$ is then approximately
  $
    E(h) approx (M h)/2 + (2 epsilon)/h,
  $
  which is minimized at
  #eq[$
    h^* = 2 sqrt(epsilon slash M).
  $] <eq:optimal-step-size>
] <prop:optimal-step-size>

#proof[
  The first term is the truncation error, obtained from $f(x + h) = f(x) + h f'(x) + (h^2 slash 2) f''(xi)$ for some $xi$ between $x$ and $x + h$.
  The second term is the roundoff error: each of the two function values carries an absolute error of at most $epsilon$, so their difference carries at most $2 epsilon$, and the division by $h$ divides the bound by $h$.
  Differentiating $E$ gives $E'(h) = M slash 2 - 2 epsilon slash h^2$, which vanishes at $h^* = 2 sqrt(epsilon slash M)$, and $E''(h) = 4 epsilon slash h^3 > 0$ confirms that this is a minimum.
  The minimal error is $E(h^*) = 2 sqrt(epsilon M)$.
]

#figure(
  image("img/optimal-step-size.svg", width: 66%),
  caption: [The two error contributions of a forward difference quotient. Truncation grows linearly in $h$ while roundoff decays as $epsilon slash h$, so the total error has a minimum at $h^* = 2 sqrt(epsilon slash M)$. No choice of step size can push the error below $2 sqrt(epsilon M)$, which for double precision is of the order of $10^(-8)$ when $M$ is of order one.],
) <fig:optimal-step-size>

For double precision with $epsilon approx 10^(-16)$ and $M$ of order one, the optimal step is about $2 times 10^(-8)$ and the best achievable accuracy is about $10^(-8)$, which is eight digits worse than the machine precision.
This is the first instance of a phenomenon that recurs throughout the notebook: accuracy is not a monotone function of effort, and pushing a parameter to its limit can make the result worse.

#caution[
  The constant in @eq:optimal-step-size depends on the formula and on the bound $M$, and the central difference quotient, whose truncation error is of order $h^2$, leads to $h^* = (3 epsilon slash M)^(1 slash 3)$ instead.
  The formula is therefore a scaling law, not a prescription: what matters is the order of magnitude of $h^*$, and the fact that the two errors balance there.
]

The last principle is made quantitative in *Ch 2*, where the condition number separates the difficulty of a problem from the quality of an algorithm.
A further technique, extrapolation, cancels the leading truncation term instead of shrinking it; it is developed in *Richardson Extrapolation and Romberg Integration*.

= Norms, Conditioning and Stability // 范数、条件数与稳定性

#counter(math.equation).update(0)

The error analysis of the previous chapter measured the deviation of a single computed number from its exact value.
To compare vectors and matrices, and above all to compare whole computations, that notion of distance must be replaced by a norm, and a single question must be split into two: how sensitive is the problem, and how good is the algorithm.
This chapter supplies the four tools that answer it: norms, which measure vectors and matrices; the pair forward and backward error, which separates the error of the answer from the perturbation of the data; the condition number, which is a property of the problem alone; and the order of convergence, which is the language in which iterative methods are compared.
The chapter closes with the definition of stability, which classifies algorithms once the difficulty of the problem has been factored out.

The single idea behind all four tools is the inequality
$
  "forward error" <= "condition number" times "backward error",
$
which says that an algorithm can never be blamed for more than the sensitivity of its problem allows, and that it should never be blamed for less either.
Every result of this chapter is a quantitative version of this sentence.

== Vector and Matrix Norms // 向量与矩阵范数

An error bound for a scalar is a number; an error bound for a vector or a matrix must be a single number that summarizes many components.
Such a summary is what a norm provides, and the axioms below are exactly the properties needed for the error bounds of the sequel to be provable by the triangle inequality.

#definition(name: "Norm")[
  A *norm* on a real vector space $V$ is a map $||dot|| : V -> bb(R)$ such that, for all $x, y in V$ and all $alpha in bb(R)$,
  - $||x|| >= 0$, with $||x|| = 0$ only for $x = 0$;
  - $||alpha x|| = abs(alpha) ||x||$;
  - $||x + y|| <= ||x|| + ||y||$.
] <def:norm>

The three most used families on $bb(R)^n$ are the following.

#definition(name: "$p$-Norms")[
  For $1 <= p < oo$ and $x = (x_1, dots, x_n) in bb(R)^n$, the *$p$-norm* is
  #eq[$
    ||x||_p = (sum_(i=1)^n abs(x_i)^p)^(1 slash p),
  $] <eq:p-norm>
  and the limiting case $p -> oo$ gives the *maximum norm*
  $
    ||x||_oo = max_(1 <= i <= n) abs(x_i).
  $
] <def:p-norm>

That @eq:p-norm indeed defines a norm is Minkowski's inequality, which belongs to the theory of $L^p$ spaces and is proved there; only the triangle inequality is not immediate.
For matrices the analogous construction takes the norm of the image of a vector.

#definition(name: "Induced Matrix Norm")[
  Let $||dot||$ be a norm on $bb(R)^n$ and on $bb(R)^m$, and let $A in bb(R)^(m times n)$.
  The *matrix norm induced by* $||dot||$ is
  #eq[$
    ||A|| = sup_(x != 0) (||A x||)/(||x||) = sup_(||x|| = 1) ||A x||.
  $] <eq:induced-norm>
] <def:matrix-norm>

The induced norm has a direct geometric meaning: it is the largest factor by which $A$ can stretch a vector.
For the three norms above the supremum can be computed explicitly.

#proposition(name: "Formulas for Induced Norms")[
  For $A = (a_(i j))_(m times n)$,
  $
    ||A||_1 = max_(1 <= j <= n) sum_(i=1)^m abs(a_(i j)), quad ||A||_oo = max_(1 <= i <= m) sum_(j=1)^n abs(a_(i j)), quad ||A||_2 = sqrt(rho(A^"T" A)).
  $
  The first two are the largest column sum and the largest row sum respectively, and $rho$ denotes the spectral radius.
] <prop:induced-norm-formulas>

The formulas for $p = 1$ and $p = oo$ follow by pushing the absolute values through the sum, since each is attained by concentrating the mass of $x$ on a single entry.
The formula for $p = 2$ is the singular value characterization of the Euclidean norm and is proved in *Algèbre Linéaire*; it shows that $||A||_2$ is the largest singular value of $A$.

A fourth norm is often used because it is cheap to compute, although it is not induced by any vector norm.

#definition(name: "Frobenius Norm")[
  The *Frobenius norm* of $A = (a_(i j))_(m times n)$ is
  $
    ||A||_"F" = (sum_(i=1)^m sum_(j=1)^n abs(a_(i j))^2)^(1 slash 2).
  $
] <def:frobenius-norm>

#lemma(name: "Submultiplicativity")[
  Let $||dot||$ be an induced matrix norm.
  Then for all compatible $A, B$ and all $x$,
  $
    ||A x|| <= ||A|| ||x||, quad ||A B|| <= ||A|| ||B||.
  $
] <lem:submultiplicativity>

#proof[
  The first inequality is immediate from @eq:induced-norm when $x != 0$ and trivial when $x = 0$.
  For the second, apply the first twice: $||A B x|| <= ||A|| ||B x|| <= ||A|| ||B|| ||x||$, and take the supremum over $||x|| = 1$.
]

The quantity that governs the convergence of iterative methods is not a norm but the spectral radius, and the two are linked by an inequality that will be used repeatedly.

#definition(name: "Spectral Radius")[
  For $A in bb(R)^(n times n)$ with eigenvalues $lambda_1, dots, lambda_n$, the *spectral radius* is
  $
    rho(A) = max_(1 <= i <= n) abs(lambda_i).
  $
] <def:spectral-radius>

#theorem(name: "Spectral Radius and Norms")[
  Let $A in bb(R)^(n times n)$.
  Then $rho(A) <= ||A||$ for every induced norm, and for every $epsilon > 0$ there exists an induced norm with $||A|| <= rho(A) + epsilon$.
] <thm:spectral-radius-norm>

#proof[
  *First claim.* Let $lambda$ be an eigenvalue of largest modulus and $x$ a corresponding eigenvector.
  Then $abs(lambda) ||x|| = ||A x|| <= ||A|| ||x||$, and dividing by $||x|| != 0$ gives $rho(A) <= ||A||$.

  *Second claim.* Over $bb(C)$ the matrix $A$ is similar to an upper triangular matrix $T$ whose diagonal entries are the eigenvalues, say $A = S T S^(-1)$.
  For $D_epsilon = "diag"(1, epsilon, epsilon^2, dots, epsilon^(n-1))$ the matrix $D_epsilon^(-1) T D_epsilon$ has the same diagonal and off-diagonal entries multiplied by powers of $epsilon$, hence its row sums tend to $rho(A)$ as $epsilon -> 0$.
  Since $||B||_oo$ is the largest row sum, the norm $||x||_epsilon = ||D_epsilon^(-1) S^(-1) x||_oo$ satisfies the claim.
]

#caution[
  The spectral radius is not a norm: for $A = mat(0, 1; 0, 0)$ we have $rho(A) = 0$ while $A != 0$.
  It nevertheless controls the asymptotic behaviour of powers, since $rho(A) < 1$ if and only if $A^k -> 0$, which is why the convergence of the iterative methods of *Ch 8* is stated in terms of $rho$ rather than of $norm(dot)$.
]

#example(name: "Four norms of a small matrix")[
  Let $A = mat(1, 2; 3, 4)$.
  Its column sums are $4$ and $6$, so $||A||_1 = 6$; its row sums are $3$ and $7$, so $||A||_oo = 7$; and $||A||_"F" = sqrt(30) approx 5.477$.
  The eigenvalues solve $lambda^2 - 5 lambda - 2 = 0$, giving $lambda approx 5.372$ and $lambda approx -0.372$, so $rho(A) approx 5.372$.
  Finally $A^"T" A = mat(10, 14; 14, 20)$ has eigenvalues $29.866$ and $0.134$, so $||A||_2 = sqrt(29.866) approx 5.465$.
  The four numbers differ, and none of the inequalities $rho(A) <= ||A||_2 <= ||A||_"F"$ is an equality here.
]

#figure(
  image("img/unit-balls.svg", width: 54%),
  caption: [The unit balls of the $1$-, $2$- and $oo$-norms in $bb(R)^2$. The diamond, the disc and the square are all convex and centrally symmetric, and each is the unit ball of some norm. The induced matrix norm @eq:induced-norm is the largest stretch factor of such a ball, which is why $||A||_1$ and $||A||_oo$ are read off from columns and rows.],
) <fig:unit-balls>

#note(title: "Equivalence of norms")[
  All norms on $bb(R)^n$ are equivalent, but the constants depend on $n$: for instance $||x||_oo <= ||x||_2 <= sqrt(n) ||x||_oo$ and $||x||_2 <= ||x||_1 <= sqrt(n) ||x||_2$.
  In numerical analysis the constants matter, because a bound proved in one norm may deteriorate by a factor $sqrt(n)$ or $n$ when restated in another.
  This is why every error bound below states explicitly which norm is used, and why the choice of norm is part of the design of an algorithm rather than a cosmetic matter.
]

== Forward and Backward Error // 前向误差与后向误差

A computed answer can be described in two ways.
One may say how far it is from the exact answer, or one may say which slightly different problem it solves exactly.
The first description is the forward error, the second the backward error, and the second is the one that can be measured without knowing the exact answer.

#definition(name: "Forward Error")[
  Let $x$ be the exact solution of a problem and $hat(x)$ a computed approximation.
  The *forward error* is the difference $x - hat(x)$, measured in a norm suited to the answer.
] <def:forward-error>

The forward error is what a user cares about, and it is exactly what cannot be computed, since $x$ is unknown.
Wilkinson's idea was to reverse the point of view: instead of asking how wrong the answer is, ask how much the data would have to be changed for the answer to be right.

#definition(name: "Backward Error")[
  Let a problem be represented by a map $f : X -> Y$ and let $hat(y)$ be the computed value of $y = f(x)$.
  Any $Delta x$ satisfying $f(x + Delta x) = hat(y)$ is called a *backward perturbation* of the data, and the *backward error* is the norm of the smallest such perturbation, usually reported relative to $||x||$.
] <def:backward-error>

#definition(name: "Backward Stable Algorithm")[
  An algorithm computing $f(x)$ is *backward stable* if the computed value equals $f(x + Delta x)$ for some $Delta x$ with
  $
    ||Delta x|| <= c(n) u ||x||,
  $
  where $u$ is the unit roundoff and $c(n)$ is a modest function of the size of the problem.
] <def:backward-stability>

The standard model of Chapter 1 is exactly a statement of backward stability for a single operation, and this is where the promise made there is kept.

#proposition(name: "Elementary Operations are Backward Stable")[
  Under the standard model @eq:fl-model, each of the four elementary operations is backward stable with $c = 1$: for $op in {+, -, times, slash}$ and for $x op y != 0$ there exist relative perturbations $abs(Delta x) <= u abs(x)$ and $abs(Delta y) <= u abs(y)$ such that
  $
    "fl"(x op y) = (x + Delta x) op (y + Delta y)
  $
  exactly.
] <prop:fl-backward-stable>

#proof[
  Write $"fl"(x op y) = (x op y)(1 + delta)$ with $abs(delta) <= u$ by @eq:fl-model.
  For multiplication and division it suffices to perturb one operand: $(x(1 + delta)) dot y = x y (1 + delta)$ and $(x(1 + delta)) slash y = (x slash y)(1 + delta)$.
  For addition and subtraction, perturb both operands by the same factor: $(x(1 + delta)) ± (y(1 + delta)) = (x ± y)(1 + delta)$.
  In each case the computed value is the exact value of the operation applied to the perturbed operands.
]

Backward stability is therefore a property of the arithmetic, not of the algorithm, and it is inherited by any finite sequence of operations: the whole computation is the exact computation for slightly perturbed input data.
The error analysis of an algorithm then reduces to bounding the size of that perturbation.

#example(name: "Backward error of a dot product")[
  Let $s = sum_(i=1)^n x_i y_i$ and compute it as the sum of the computed products.
  Collecting the rounding factors, $hat(s) = sum_i x_i y_i (1 + delta_i)$ with $abs(delta_i) <= n u$ to first order, so $hat(s)$ is the exact dot product of $x$ with a vector $tilde(y)$ satisfying $abs(tilde(y)_i - y_i) <= n u abs(y_i)$.
  The backward error is small, of order $n u$, and yet the forward error obeys
  $
    abs(s - hat(s)) <= n u sum_(i=1)^n abs(x_i y_i),
  $
  whose right-hand side involves the sum of absolute values and not $abs(s)$.
  When the terms cancel, this bound is enormous compared with $abs(s)$: the algorithm is backward stable and still inaccurate.
]

The distinction is sharpest for linear systems, where two different measures of the error are routinely confused.

#definition(name: "Residual")[
  Let $A x = b$ with $A$ invertible, and let $hat(x)$ be a computed solution.
  The vector
  $
    r = b - A hat(x)
  $
  is the *residual* of $hat(x)$.
] <def:residual>

For a linear system the residual measures how far $hat(x)$ is from solving the given system, which is precisely a backward error: $A hat(x) = b + Delta b$ with $Delta b = -r$.
The error $x - hat(x)$, by contrast, is a forward error, and the two can differ by a factor as large as the condition number of $A$.

#example(name: "A small residual does not imply a small error")[
  Let
  $
    A = mat(1, 1; 1, 1 + 10^(-3)), quad b = mat(2; 2 + 10^(-3)),
  $
  whose exact solution is $x = (1, 1)$.
  Take $hat(x) = (1 + delta, 1 - delta)$ with $delta = 1 slash 2$.
  Then $A hat(x) = (2, 2 + 10^(-3) - 10^(-3) delta)$, so $r = (0, 10^(-3) delta) = (0, 5 times 10^(-4))$ and the relative residual is $||r||_oo slash ||b||_oo approx 1.8 times 10^(-4)$.
  The relative error, however, is $||x - hat(x)||_oo slash ||x||_oo = 0.5$, more than three orders of magnitude larger.
  The perturbation of the data that explains the answer is tiny, but the problem amplifies it.
]

#note(title: "Wilkinson's programme")[
  Backward error analysis converts a question about the accuracy of an algorithm into a question about the size of an equivalent perturbation.
  This is what makes Gaussian elimination analysable despite its notorious growth of intermediate quantities: it is backward stable with a modest constant, so any inaccuracy in the computed solution is attributable to the sensitivity of the system.
  That sensitivity is measured by the condition number, which is the subject of the next section.
]

== Condition Number and Ill-Conditioned Problems // 条件数与病态问题

The backward error of the previous section measures the algorithm; the condition number measures the problem.
The two combine into a single inequality, which is the reason for introducing either of them.

#definition(name: "Condition Number of a Problem")[
  Let $f : X -> Y$ be a problem, and let $x != 0$ with $f(x) != 0$.
  The *relative condition number* of $f$ at $x$ is
  #eq[$
    kappa(x) = lim_(delta -> 0) sup_(||Delta x|| <= delta) (||f(x + Delta x) - f(x)|| slash ||f(x)||)/(||Delta x|| slash ||x||).
  $] <eq:condition-number>
  A problem with a small condition number is called *well conditioned*, one with a large condition number *ill conditioned*.
] <def:condition-number>

For a differentiable problem the limit is a derivative ratio, namely $kappa(x) = ||f'(x)|| ||x|| slash ||f(x)||$, so the condition number is the ratio between the relative change of the answer and the relative change of the data.

#theorem(name: "The Fundamental Inequality")[
  Let an algorithm compute $f(x)$ with backward error $||Delta x|| <= c u ||x||$, so that $hat(y) = f(x + Delta x)$.
  Then the relative forward error satisfies
  #eq[$
    (||hat(y) - f(x)||)/(||f(x)||) <= kappa(x) c u + O(u^2).
  $] <eq:fundamental-inequality>
] <thm:fundamental-inequality>

#proof[
  Expanding to first order, $f(x + Delta x) = f(x) + f'(x) Delta x + O(||Delta x||^2)$, hence
  $
    ||hat(y) - f(x)|| <= ||f'(x)|| ||Delta x|| + O(u^2) <= ||f'(x)|| c u ||x|| + O(u^2).
  $
  Dividing by $||f(x)||$ and inserting $kappa(x) = ||f'(x)|| ||x|| slash ||f(x)||$ gives @eq:fundamental-inequality.
]

@eq:fundamental-inequality is the sentence announced in the introduction: the forward error is bounded by the product of the sensitivity of the problem and the backward error of the algorithm.
A backward stable algorithm is therefore optimal up to the constant $c$; nothing better can be achieved in the same arithmetic, and the remaining error belongs to the problem.

#example(name: "The square root is perfectly conditioned")[
  For $f(x) = sqrt(x)$ with $x > 0$ we have $f'(x) = 1 slash (2 sqrt(x))$, so
  $
    kappa(x) = 1/(2 sqrt(x)) dot x/sqrt(x) = 1/2.
  $
  A relative perturbation of the data of size $u$ produces a relative change of the answer of about $u slash 2$, whatever the size of $x$.
  Taking a square root never loses digits, which is why the operation appears in so many stabilizations of formulas.
]

#example(name: "Subtraction is ill conditioned when it cancels")[
  For $f(x_1, x_2) = x_1 - x_2$ measured in the $1$-norm on the data, a perturbation satisfies $abs(Delta f) <= ||Delta x||_1$, so
  $
    kappa(x) = (abs(x_1) + abs(x_2))/(abs(x_1 - x_2)).
  $
  This is exactly the amplification factor $K$ of *Catastrophic Cancellation*, now identified as a property of the map $f$ rather than of any particular formula.
  The condition number is small when the two numbers are far apart and unbounded when they are close, which confirms the conclusion reached there: no rearrangement can rescue a genuinely ill-conditioned subtraction, and a rearrangement is needed precisely when the cancellation is avoidable.
]

The same analysis applies to linear systems, where the condition number of the matrix governs everything.

#proposition(name: "Condition Number of a Linear System")[
  Let $A in bb(R)^(n times n)$ be invertible, $b != 0$ and $x = A^(-1) b$, and let $kappa(A) = ||A|| ||A^(-1)||$ for a fixed induced norm.
  If $b$ is perturbed by $Delta b$ and $Delta x$ denotes the resulting change of the solution, then
  #eq[$
    (||Delta x||)/(||x||) <= kappa(A) (||Delta b||)/(||b||).
  $] <eq:linear-system-b-perturbation>
  If in addition $A$ is perturbed by $Delta A$ with $||A^(-1)|| ||Delta A|| < 1$, then
  #eq[$
    (||Delta x||)/(||x||) <= (kappa(A))/(1 - kappa(A) (||Delta A||)/(||A||)) ((||Delta A||)/(||A||) + (||Delta b||)/(||b||)).
  $] <eq:linear-system-a-perturbation>
] <prop:linear-system-condition>

#proof[
  From $A (x + Delta x) = b + Delta b$ and $A x = b$ we get $Delta x = A^(-1) Delta b$, hence $||Delta x|| <= ||A^(-1)|| ||Delta b||$.
  Since $b = A x$ gives $||b|| <= ||A|| ||x||$, that is $1 slash ||x|| <= ||A|| slash ||b||$, multiplying the two bounds yields @eq:linear-system-b-perturbation.

  The second bound combines this estimate with the perturbation of $A$; the denominator accounts for the possibility that $A + Delta A$ is close to singular.
]

#example(name: "Hilbert matrices")[
  The Hilbert matrix $H_n$ with entries $1 slash (i + j - 1)$ is the classical example of an ill-conditioned matrix that arises naturally from least squares fitting.
  In the $2$-norm, $kappa(H_5) approx 4.8 times 10^5$ and $kappa(H_(10)) approx 1.6 times 10^13$.
  With $u approx 1.1 times 10^(-16)$ the fundamental inequality only guarantees about ten correct digits for $H_5$, and none at all for $H_(10)$: the computed solution of a Hilbert system of order ten can be entirely wrong although the elimination is backward stable.
]

#figure(
  image("img/conditioning-ellipse.svg", width: 62%),
  caption: [Geometry of the condition number. The matrix $A$ maps the unit circle onto an ellipse whose semi-axes are the extreme singular values, and $kappa(A) = ||A||_2 ||A^(-1)||_2$ is their ratio. A relative ball of uncertainty of radius $epsilon$ around the data is stretched into an ellipse whose aspect ratio is the same, so the answer inherits an uncertainty magnified by $kappa(A)$ in the worst direction.],
) <fig:conditioning-geometry>

#caution[
  An ill-conditioned problem cannot be repaired by a better algorithm.
  If $kappa(A) u >= 1$, the fundamental inequality permits a relative error of order one, and no backward stable method can avoid it; what can be changed is the problem, not the solver.
  The remedies are of a different nature: reformulate the model, rescale the unknowns, or regularize the problem by adding information.
]

#note(title: "Conditioning of eigenvalues")[
  The same idea applies to eigenproblems, with a different formula.
  A simple eigenvalue $lambda$ of $A$ with right eigenvector $x$ and left eigenvector $y$ has condition number $1 slash abs(y^"T" x)$, which equals one for symmetric matrices and can be enormous for non-symmetric ones.
  This explains why symmetric eigenvalue algorithms of *Ch 9* are far better behaved than general ones, and why the eigenvalues of a non-symmetric matrix may be computed accurately even when its eigenvectors are not.
]

== Rates of Convergence // 收敛阶

Most algorithms of the sequel do not compute an answer in finitely many exact steps; they generate a sequence of approximations.
Comparing such algorithms requires a precise notion of how fast the sequence approaches its limit, and that notion is the order of convergence promised in *Ch 1*.

#definition(name: "Order of Convergence")[
  Let $x_k -> x^*$ with $x_k != x^*$ for all $k$.
  The sequence has *order of convergence* $p >= 1$ and *rate* $C$ if
  $
    lim_(k -> oo) (||x_(k+1) - x^*||)/(||x_k - x^*||^p) = C,
  $
  with $0 < C < oo$ when $p > 1$ and $0 < C < 1$ when $p = 1$.
  The case $p = 1$ is called *linear* convergence, $1 < p < 2$ *superlinear* convergence, and $p = 2$ *quadratic* convergence.
] <def:order-of-convergence>

The order is best understood in terms of digits, because that is how accuracy is reported in practice.

#proposition(name: "Digits Gained per Step")[
  Let $e_k = ||x_k - x^*||$ and suppose $e_(k+1) approx C e_k^p$.
  Then
  $
    log_10 e_(k+1) approx p log_10 e_k + log_10 C,
  $
  so that asymptotically the number of correct decimal digits is multiplied by $p$ at each step.
  For linear convergence the number of digits gained per step is $-log_10 C$.
] <prop:digits-per-step>

#proof[
  Take logarithms in $e_(k+1) approx C e_k^p$.
  The additive term $log_10 C$ is negligible compared with $p log_10 e_k$ when $e_k$ is small and $p > 1$, and it is the whole story when $p = 1$.
]

#example(name: "Linear versus quadratic")[
  The sequence $x_k = 2^(-k)$ converges linearly to zero with rate $C = 1 slash 2$, so it gains $log_10 2 approx 0.301$ digits per step: a hundred iterations buy thirty digits.
  Newton's iteration for $sqrt(2)$, started at $x_0 = 1$, gives
  $x_1 = 1.5$, $x_2 approx 1.41667$, $x_3 approx 1.4142157$, $x_4 approx 1.41421356237$,
  whose errors are $8.6 times 10^(-2)$, $2.5 times 10^(-3)$, $2.1 times 10^(-6)$ and $1.6 times 10^(-12)$.
  The number of correct digits is roughly $1$, $3$, $6$, $12$: it doubles at each step, which is the practical meaning of quadratic convergence.
]

#note(title: "Two meanings of order")[
  The word *order* is used in two different senses in numerical analysis, and both are powers of a small quantity.
  For an iterative method the small quantity is the current error, and the order $p$ introduced in #link(<def:order-of-convergence>)[*Order of Convergence*] controls how fast the iteration converges.
  For a discretization the small quantity is the step size $h$, and the order $p$ in a bound of the form $abs("error") <= C h^p$ controls how fine the mesh must be.
  The two are unified by the same question, namely how many digits one unit of extra work buys, and the estimates of *Ch 6* and *Ch 11* are of the second type while those of *Ch 8* and *Ch 10* are of the first.
]

#caution[
  Quadratic convergence is a local property: it holds once the iterate is close enough to the root, and says nothing about the first steps.
  It also degrades in finite precision, because once $e_k$ reaches the level $u$ of the roundoff error no iteration can improve it, and further steps may oscillate or diverge away from the root.
  An iteration is therefore stopped when the increment falls below a tolerance related to $u$, not when it becomes as small as possible.
]

== Stability of Algorithms // 算法的数值稳定性

The fundamental inequality separates the error into a factor belonging to the problem and a factor belonging to the algorithm.
The second factor deserves a name, and it is the notion announced in *Algorithm Design Techniques* as the fifth principle.

#definition(name: "Numerical Stability")[
  Let $f$ be a problem with condition number $kappa(x)$, and let an algorithm compute $hat(y)$ in arithmetic with unit roundoff $u$.
  The algorithm is *numerically stable* for the inputs under consideration if
  $
    (||hat(y) - f(x)||)/(||f(x)||) <= c kappa(x) u
  $
  for a modest constant $c$ independent of the input, and *unstable* if for some admissible input the relative error is much larger than $kappa(x) u$.
] <def:numerical-stability>

Backward stability is the stronger property: by @eq:fundamental-inequality a backward stable algorithm is stable with $c$ equal to the constant of its backward error.
The converse fails, and the distinction matters when the problem is itself sensitive, since then a stable algorithm is all that can be asked for.

#example(name: "An unstable recurrence")[
  Let $I_n = integral_0^1 (x^n)/(x + 5) dif x$ for $n >= 0$.
  Adding and subtracting $5 x^(n-1)$ inside the integrand gives the exact identity
  $
    I_n + 5 I_(n-1) = 1/n.
  $
  Computing upwards, $I_n = 1 slash n - 5 I_(n-1)$, multiplies whatever error $I_(n-1)$ carries by $5$, so an initial error $delta$ becomes $5^n delta$ after $n$ steps; with $n = 10$ the amplification is $5^(10) approx 9.8 times 10^6$ and the computed values, which should decrease monotonically to zero, turn negative.
  Computing downwards, $I_(n-1) = (1 slash n - I_n) slash 5$, divides the error by $5$ at each step and is perfectly stable, but it needs a starting value $I_N$, which can be obtained by a quadrature rule.
  The problem of evaluating $I_n$ is well conditioned; only the direction of the recurrence decides whether the computation succeeds.
]

The interplay between the two factors gives a complete classification of the sources of inaccuracy.

#tex-table(
  ("Problem", "Algorithm", "Outcome"),
  ("well conditioned", "stable", [the answer is accurate to about $u$]),
  ("ill conditioned", "stable", [the error is bounded by $kappa u$ and cannot be improved]),
  ("well conditioned", "unstable", [arbitrary loss of accuracy, avoidable by choosing another algorithm]),
  ("ill conditioned", "unstable", "nothing can be said; both factors contribute"),
)

#note(title: "Growth factors")[
  Stability is usually proved by exhibiting a quantity whose growth controls the error, and Gaussian elimination is the standard case.
  With partial pivoting the computed solution is the exact solution of a perturbed system, so the method is backward stable, and the size of the perturbation is governed by the growth factor, namely the largest entry appearing during elimination divided by the largest entry of $A$.
  Partial pivoting keeps this factor below $2^(n-1)$ in the worst case, a bound that is almost never approached in practice; the details belong to *Direct Methods for Linear Systems*, where the same factorization is used to solve the systems of *Ch 7*.
]

#part("Polynomial Approximation and Numerical Calculus") // 多项式逼近与数值微积分

= Polynomial Interpolation // 多项式插值

#counter(math.equation).update(0)

Part I supplied the tools for judging a computation; this part uses them to build one.
Interpolation is the first construction of the notebook: a finite table of values is replaced by a polynomial that agrees with it, and everything later in the part — piecewise interpolation, best approximation, quadrature — is a variation on it.
The algebraic facts are elementary and complete: the interpolating polynomial exists, is unique, and can be written in several equivalent ways.
The numerical facts are not: the natural way to compute it is hopelessly ill conditioned, and the ways that work are the subject of this chapter.

== The Interpolation Problem: Existence and Uniqueness // 插值问题：存在唯一性

The problem is to pass a polynomial through a prescribed set of points.
Nothing more is assumed about the data: the values may come from a function, from a table, or from a measurement.

#definition(name: "Polynomial Interpolation Problem")[
  Let $x_0, x_1, dots, x_n$ be $n + 1$ distinct real numbers, the *nodes*, and let $y_0, y_1, dots, y_n$ be given real numbers.
  A polynomial $p$ of degree at most $n$ satisfying
  #eq[$
    p(x_i) = y_i, quad i = 0, 1, dots, n,
  $] <eq:interpolation-conditions>
  is called the *interpolating polynomial* of the data $(x_i, y_i)_(i = 0)^n$.
] <def:interpolation-problem>

The number of conditions equals the number of coefficients, so @eq:interpolation-conditions is a square linear system once the coefficients are chosen as unknowns.

#definition(name: "Vandermonde System")[
  Writing $p(x) = a_0 + a_1 x + dots + a_n x^n$, the conditions @eq:interpolation-conditions become
  #eq[$
    mat(
      1, x_0, dots.h, x_0^n;
      1, x_1, dots.h, x_1^n;
      dots.v, dots.v, dots.down, dots.v;
      1, x_n, dots.h, x_n^n;
    ) mat(a_0; a_1; dots.v; a_n) = mat(y_0; y_1; dots.v; y_n).
  $] <eq:vandermonde-system>
  The matrix is the *Vandermonde matrix* $V(x_0, dots, x_n)$.
] <def:vandermonde-system>

Whether the system can be solved is decided by the determinant, which is known from linear algebra.

#theorem(name: "Existence and Uniqueness of the Interpolating Polynomial")[
  Let $x_0, dots, x_n$ be distinct.
  Then there is exactly one polynomial of degree at most $n$ satisfying @eq:interpolation-conditions.
] <thm:interpolation-uniqueness>

#proof[
  *Existence.* By the formula for the Vandermonde determinant,
  $
    "det" V(x_0, dots, x_n) = product_(0 <= i < j <= n) (x_j - x_i),
  $
  which is nonzero because the nodes are distinct; the evaluation of this determinant belongs to linear algebra and is not repeated here.
  Hence @eq:vandermonde-system has a solution.

  *Uniqueness.* If $p$ and $q$ both satisfy @eq:interpolation-conditions, then $r = p - q$ has degree at most $n$ and vanishes at the $n + 1$ distinct nodes.
  A nonzero polynomial of degree at most $n$ has at most $n$ roots, so $r$ is identically zero and $p = q$.
]

The theorem settles the existence question completely, and it is worth pausing on how little it settles.
The uniqueness proof does not exhibit the polynomial, and the existence proof produces it only by inverting a matrix.

#example(name: "Vandermonde systems are ill conditioned")[
  For $n + 1$ equispaced nodes on $[0, 1]$ the condition number $kappa_2 (V)$ of the Vandermonde matrix grows rapidly with $n$: it equals $9.9 times 10^1$ for four nodes, $4.9 times 10^3$ for six, $2.7 times 10^5$ for eight, $1.5 times 10^7$ for ten, and $3.1 times 10^12$ for sixteen.
  By @eq:fundamental-inequality, solving @eq:vandermonde-system in double precision leaves about $16 - log_10 kappa$ correct digits, that is four digits for ten nodes and none at all for sixteen.
  The interpolation problem is perfectly posed; it is the representation by coefficients in the monomial basis that is ill conditioned.
]

The distinction is the one drawn in *Condition Number and Ill-Conditioned Problems*: the difficulty lies in the problem of expressing the answer as a coefficient vector, not in the algorithm that solves the system.

#note(title: "Uniqueness is not the same as computability")[
  The polynomial is unique, but its *representation* is not.
  Written in the monomial basis it is a vector of coefficients, and recovering that vector from the data is an ill-conditioned task.
  Written in the Lagrange basis or in the Newton basis it is a vector of values or of divided differences, and the corresponding tasks are well conditioned.
  The next two sections construct these two representations, and the comparison between them is the practical content of the chapter.
]

#caution[
  Interpolation forces the polynomial through every data point, which is the right requirement when the data are exact and the wrong one when they are noisy.
  When the data carry measurement error, the appropriate problem is approximation in a norm rather than interpolation, and it is treated in *Function Approximation and Curve Fitting*.
]

== Lagrange Interpolation // Lagrange 插值

Since the interpolating polynomial is unique, any construction that produces it is the right one.
The Lagrange construction avoids solving a system altogether: it builds the polynomial out of pieces that are switched on at one node and off at all the others.

#definition(name: "Lagrange Basis")[
  For distinct nodes $x_0, dots, x_n$, the *Lagrange basis polynomials* are
  #eq[$
    ell_i (x) = product_(j = 0, j != i)^n (x - x_j)/(x_i - x_j), quad i = 0, 1, dots, n.
  $] <eq:lagrange-basis>
] <def:lagrange-basis>

#proposition(name: "Properties of the Lagrange Basis")[
  The polynomials @eq:lagrange-basis have degree $n$ and satisfy $ell_i (x_j) = delta_(i j)$ for all $i, j$.
  Consequently
  #eq[$
    L_n (x) = sum_(i=0)^n y_i ell_i (x)
  $] <eq:lagrange-formula>
  is the unique interpolating polynomial of the data, and $sum_(i=0)^n ell_i (x) = 1$ identically.
] <prop:lagrange-basis-properties>

#proof[
  Each factor in @eq:lagrange-basis vanishes at $x_j$ for $j != i$, and at $x = x_i$ the product equals one.
  Hence $L_n (x_j) = y_j$ for every $j$, and $L_n$ has degree at most $n$, so it is the interpolating polynomial by uniqueness.

  Applying the same argument to the constant data $y_i = 1$ gives the sum rule, since the polynomial that interpolates the value one at every node is the constant one.
]

Two low degrees carry names of their own, and they are the building blocks of the piecewise constructions of the next chapter.
For $n = 1$ the interpolant is the straight line through two points, and $L_1$ is called the *linear interpolant*.
For $n = 2$ it is the parabola through three points, and $L_2$ is called the *quadratic interpolant*, or *parabolic interpolant*.

The formula is exact at the nodes and differs from $f$ everywhere else, and the difference is what any error analysis of interpolation must bound.

#definition(name: "Interpolation Remainder")[
  For a function $f$ sampled at nodes as in #link(<def:interpolation-problem>)[*Polynomial Interpolation Problem*], the *interpolation remainder*, also called the *truncation error* of the interpolant, is
  $
    R_n (x) = f(x) - L_n (x), quad x in [a, b].
  $
] <def:interpolation-remainder>

#theorem(name: "Remainder of the Interpolating Polynomial")[
  Let $f in C^(n+1) [a, b]$ and let $x_0, dots, x_n$ be distinct nodes in $[a, b]$.
  Then for every $x in [a, b]$ there exists $xi in (a, b)$, depending on $x$, such that
  #eq[$
    R_n (x) = (f^((n+1)) (xi))/((n+1)!) omega_(n+1) (x), quad omega_(n+1) (x) = product_(i=0)^n (x - x_i).
  $] <eq:interpolation-error>
] <thm:interpolation-error>

#proof[
  Fix $x$ different from the nodes and choose $K$ so that $phi (t) = f(t) - L_n (t) - K omega_(n+1) (t)$ vanishes at $t = x$.
  Then $phi$ vanishes at $x$ and at the $n + 1$ nodes, that is at $n + 2$ distinct points, so $n + 1$ applications of Rolle's theorem give a point $xi$ with $phi^((n+1)) (xi) = 0$.
  Since $L_n$ has degree at most $n$ and $omega_(n+1)$ has leading coefficient one, this reads $f^((n+1)) (xi) - (n + 1)! K = 0$, and substituting $K$ gives @eq:interpolation-error.
  The case $x = x_i$ is trivial.
]

Equation @eq:interpolation-error separates the remainder into a factor that depends on the function, through its derivative of order $n + 1$, and a factor $omega_(n+1)$ that depends on the nodes alone.
The theorem says nothing yet about convergence, because the point $xi$ moves with $x$ and with the data; bounding the two factors is the subject of *Interpolation Error and Runge Phenomenon*.

The formula is elegant but expensive to apply directly: each basis polynomial costs $n$ multiplications and one division, so a single evaluation of $L_n$ costs $O(n^2)$ operations and may overflow when the nodes are widely spread.
Both defects disappear once a common factor is taken out.

#proposition(name: "Barycentric Lagrange Formula")[
  Let
  #eq[$
    w_i = 1/(product_(j != i) (x_i - x_j)), quad i = 0, 1, dots, n,
  $] <eq:barycentric-weights>
  be the *barycentric weights* of the nodes.
  Then for every $x$ distinct from the nodes,
  #eq[$
    L_n (x) = (sum_(i=0)^n (w_i y_i)/(x - x_i))/(sum_(i=0)^n (w_i)/(x - x_i)).
  $] <eq:barycentric-formula>
] <prop:barycentric-formula>

#proof[
  Let $omega (x) = product_(j=0)^n (x - x_j)$.
  Dividing @eq:lagrange-basis by $omega (x)$ gives $ell_i (x) = omega (x) w_i slash (x - x_i)$, so @eq:lagrange-formula becomes
  $
    L_n (x) = omega (x) sum_(i=0)^n (w_i y_i)/(x - x_i).
  $
  Applying the same identity to the constant data $y_i = 1$ gives $1 = omega (x) sum_i w_i slash (x - x_i)$, and dividing the two relations eliminates $omega (x)$, which is @eq:barycentric-formula.
]

The weights depend on the nodes alone.
Evaluating @eq:barycentric-formula for a new data set therefore costs $O(n)$ operations after the $O(n^2)$ preliminary computation of the weights, and changing a single value $y_i$ costs nothing at all.

#note(title: "Why implementations use the barycentric form")[
  @eq:barycentric-formula is numerically stable: with the weights computed once and accurately, the evaluation is backward stable in the sense of *Forward and Backward Error*, and the second form obtained by replacing the numerator and denominator by weighted sums of differences avoids overflow for large $n$.
  This is why modern codes evaluate interpolants in barycentric rather than in expanded form; the classical Lagrange formula @eq:lagrange-formula is the right object for proofs and the wrong one for computation.
]

#example(name: "Quadratic interpolant in two forms")[
  Interpolate the data $(0, 1)$, $(1, 3)$, $(2, 2)$.
  The basis polynomials are
  $
    ell_0 (x) = ((x - 1)(x - 2))/2, quad ell_1 (x) = -x (x - 2), quad ell_2 (x) = (x (x - 1))/2,
  $
  and @eq:lagrange-formula gives $L_2 (x) = -3/2 x^2 + 7/2 x + 1$, whose values at the nodes are $1, 3, 2$ as required.
  The barycentric weights are $w_0 = 1 slash 2$, $w_1 = -1$ and $w_2 = 1 slash 2$.
  At $x = 1 slash 2$ the two sums in @eq:barycentric-formula equal $-19 slash 3$ and $-8 slash 3$, whose ratio $19 slash 8 = 2.375$ agrees with the expanded form.
]

#figure(
  image("img/lagrange-basis.svg", width: 68%),
  caption: [The six basis polynomials of @eq:lagrange-basis for equispaced nodes on $[0, 1]$. Each vanishes at all nodes except its own, and the lobes are largest towards the ends of the interval: the sum of the absolute values reaches $3.11$ near $x = 0.078$, and that maximum is the Lebesgue constant of these nodes, the quantity responsible for the Runge phenomenon of the last section.],
) <fig:lagrange-basis>

The cost of @eq:lagrange-basis is not merely arithmetic.
Adding one node changes every basis polynomial, so a table that grows one entry at a time must be recomputed completely, whereas the Newton form of the next section extends in a single step.
Neither form escapes the difficulty of high degree with equispaced nodes, and that difficulty is analysed in *Interpolation Error and Runge Phenomenon*.

== Newton Interpolation and Divided Differences // Newton 插值与差商

The Lagrange form treats the data as one object.
In practice data arrive one point at a time, and a representation that extends in a single step is worth more than one that must be rebuilt.
The Newton form achieves this by expressing the interpolant in a basis that depends on the order in which the nodes are added.

#definition(name: "Divided Differences")[
  The *divided differences* of the data $(x_i, y_i)_i$ are defined recursively.
  The zeroth, first and second orders are
  $
    f[x_i] = y_i, quad f[x_i, x_(i+1)] = (y_(i+1) - y_i)/(x_(i+1) - x_i),
  $
  $
    f[x_i, x_(i+1), x_(i+2)] = (f[x_(i+1), x_(i+2)] - f[x_i, x_(i+1)])/(x_(i+2) - x_i),
  $
  and in general, for $k >= 1$,
  #eq[$
    f[x_i, dots, x_(i+k)] = (f[x_(i+1), dots, x_(i+k)] - f[x_i, dots, x_(i+k-1)])/(x_(i+k) - x_i);
  $] <eq:divided-difference>
  all indices are understood to lie between $0$ and $n$.
] <def:divided-difference>

The order $k$ of a divided difference is the number of nodes it involves minus one, so that $f[x_i, dots, x_(i+k)]$ is a difference of order $k$.
Each step of the recursion uses two divided differences of order $k - 1$, namely the one obtained by dropping the first node and the one obtained by dropping the last node, and divides their difference by the distance between the two nodes that were dropped.

The recursion computes all divided differences in a triangular table whose first column holds the data and whose last entry is the highest-order difference.
The construction of the interpolant then reads the table along its diagonal.

#theorem(name: "Newton Interpolation Formula")[
  The polynomial
  #eq[$
    N_n (x) = f[x_0] + sum_(k=1)^n f[x_0, dots, x_k] product_(j=0)^(k-1) (x - x_j)
  $] <eq:newton-form>
  is the interpolating polynomial of the data.
] <thm:newton-form>

#proof[
  Write $N_k$ for the polynomial formed with the first $k + 1$ nodes, so that $N_k = N_(k-1) + f[x_0, dots, x_k] omega_(k-1) (x)$ with $omega_(k-1) (x) = product_(j=0)^(k-1) (x - x_j)$.
  For $k = 0$ the claim is $N_0 = y_0$.
  Assume $N_(k-1) (x_i) = y_i$ for $i < k$; since $omega_(k-1)$ vanishes at those nodes, $N_k$ agrees with $N_(k-1)$ there.
  At $x_k$ only the last term survives, so
  $
    N_k (x_k) = N_(k-1) (x_k) + f[x_0, dots, x_k] product_(j=0)^(k-1) (x_k - x_j) = y_k,
  $
  the last equality being exactly the recursion @eq:divided-difference solved for $f[x_0, dots, x_k]$.
  By induction $N_n$ interpolates all the data, and uniqueness identifies it with $L_n$.
]

Two properties of divided differences make the table more than a bookkeeping device.
The first says that the labels of the nodes do not matter.

#proposition(name: "Symmetry of Divided Differences")[
  For any permutation $sigma$ of the indices,
  $
    f[x_(sigma (0)), dots, x_(sigma (k))] = f[x_0, dots, x_k].
  $
] <prop:divided-difference-symmetry>

#proof[
  The coefficient of $x^k$ in the interpolating polynomial of $k + 1$ points is $f[x_0, dots, x_k]$ by @eq:newton-form, since every other term of the sum has degree below $k$.
  The same coefficient can be read off the Lagrange form, where it equals $sum_(j=0)^k y_j slash product_(l != j) (x_j - x_l)$, a quantity that is plainly independent of the order of the nodes.
  Since the interpolating polynomial does not depend on that order either, the two expressions for its leading coefficient coincide for every permutation.
]

The second connects the table to derivatives, and it is the bridge to the error theorem of the last section.

#proposition(name: "Divided Differences and Derivatives")[
  Let $f in C^k [a, b]$ and let $x_0, dots, x_k$ lie in $[a, b]$.
  Then there exists $xi in (min_i x_i, max_i x_i)$ such that
  $
    f[x_0, dots, x_k] = (f^((k)) (xi))/(k!).
  $
] <prop:divided-difference-derivative>

#proof[
  Let $N_k$ be the Newton interpolant of the $k + 1$ points of the graph of $f$, and set $g = f - N_k$.
  Then $g$ has $k + 1$ distinct zeros, so by Rolle's theorem applied $k$ times there is a point $xi$ with $g^((k)) (xi) = 0$.
  Since $N_k$ has degree at most $k$ with leading coefficient $f[x_0, dots, x_k]$, its $k$-th derivative is the constant $k! f[x_0, dots, x_k]$, hence $f^((k)) (xi) = k! f[x_0, dots, x_k]$.
]

The proposition extends to coinciding nodes by passing to the limit, and the limiting values are the ones needed whenever derivative data enter an interpolation problem.

#corollary(name: "Repeated Nodes")[
  Let $f in C^k [a, b]$ and let $x_0$ be interior to $[a, b]$.
  If $k + 1$ nodes tend to $x_0$, the corresponding divided differences converge, and their common limit, denoted $f[x_0, dots, x_0]$, satisfies
  #eq[$
    f[x_0, dots, x_0] = (f^((k)) (x_0))/(k!).
  $] <eq:repeated-node-difference>
  In particular, for two coinciding nodes,
  $
    f[x_0, x_0] = f'(x_0).
  $
] <cor:repeated-nodes>

#proof[
  For distinct nodes, #link(<prop:divided-difference-derivative>)[*Divided Differences and Derivatives*] gives $f[x_0, dots, x_k] = f^((k)) (xi) slash k!$ with $xi$ between the smallest and the largest node.
  As the nodes tend to $x_0$, the point $xi$ is squeezed to $x_0$, and the continuity of $f^((k))$ gives the limit @eq:repeated-node-difference.
  The case $k = 1$ is $f[x_0, x_1] = f'(xi) -> f'(x_0)$, and $k = 0$ is the trivial statement $f[x_0] = f(x_0)$.
]

The corollary is what makes derivative data compatible with the divided difference table: a node that appears twice contributes the function value and the derivative value, exactly as required in *Hermite Interpolation*.

Because of the product $omega_(k-1)$ in @eq:newton-form, the evaluation of $N_n$ is a nested computation of the same shape as Horner's scheme.

#eq[$
  N_n (x) = f[x_0] + (x - x_0) (f[x_0, x_1] + (x - x_1) (dots + (x - x_(n-1)) f[x_0, dots, x_n] dots )).
$] <eq:newton-horner>

Evaluating @eq:newton-horner costs $n$ multiplications and $n$ additions, the same as the Horner scheme for the monomial basis, and no powers of $x$ are formed.

#figure(
  image("img/divided-difference-table.svg", width: 80%),
  caption: [The divided difference table for the nodes $0, 1, 2, 3$ with values $1, 3, 2, 5$. Every entry of positive order is obtained from the two entries to its left and to its upper left: subtract them and divide by the distance between the two nodes dropped from the arguments. The cell $f[x_0, x_1, x_2] = (-1 - 2) slash (2 - 0) = -3 slash 2$ is marked in red together with its four sources, namely the nodes $x_0 = 0$, $x_2 = 2$ and the first-order differences $f[x_0, x_1] = 2$, $f[x_1, x_2] = -1$; reading from left to right fills the whole table in $n (n + 1) slash 2$ subtractions and divisions.],
) <fig:divided-difference-table>

#example(name: "The divided difference table extends in one term")[
  With the table of the figure, @eq:newton-form gives
  $
    N_3 (x) = 1 + 2 x - 3/2 x (x - 1) + 7/6 x (x - 1)(x - 2).
  $
  The coefficients are read off the first row of the table, that is along its diagonal, and the first three of them are exactly the quadratic interpolant of the data $1, 3, 2$ computed in *Quadratic interpolant in two forms*.
  Appending the fourth point added the single term $(7 slash 6) x (x - 1)(x - 2)$ and changed nothing else, which is the practical advantage of the Newton form over @eq:lagrange-formula.
]

#note(title: "Neville's algorithm")[
  When only the value at a single point is wanted, the interpolant need not be formed at all.
  Neville's recursion builds the table of values $P_(i,0) = y_i$ and
  $
    P_(i,k) (x) = ((x - x_(i+k)) P_(i,k-1) (x) - (x - x_i) P_(i+1,k-1) (x))/(x_i - x_(i+k)),
  $
  which converges to $L_n (x)$ at the far corner.
  The cost is the same as the divided difference table, but no coefficients are produced, which makes it the method of choice for table lookups.
]

#caution[
  Each divided difference contains a difference of two values, so the cancellation analysis of *Catastrophic Cancellation* applies term by term.
  With closely spaced nodes and a smooth function the higher divided differences are small differences of small differences, and their computed values consist mostly of noise; this is one reason why interpolation with many clustered nodes is avoided even when the nodes are not equispaced.
]

== Hermite Interpolation // Hermite 插值

Data often carry more than values: a trajectory comes with velocities, a curve with slopes.
The divided difference table of the previous section absorbs this extra information with almost no modification, which is the reason for presenting the two topics in this order.

#definition(name: "Hermite Interpolation Problem")[
  Let $x_0, dots, x_n$ be distinct nodes, and let $y_i$ and $y'_i$ be prescribed values for $i = 0, dots, n$.
  A polynomial $H$ of degree at most $2 n + 1$ satisfying
  #eq[$
    H(x_i) = y_i, quad H'(x_i) = y'_i, quad i = 0, dots, n,
  $] <eq:hermite-conditions>
  is called the *Hermite interpolating polynomial* of the data.
] <def:hermite-interpolation>

There are $2 n + 2$ conditions and $2 n + 2$ coefficients, so @eq:hermite-conditions is again a square linear system, and the same argument as in *Existence and Uniqueness of the Interpolating Polynomial* shows that it has exactly one solution: a nonzero polynomial of degree at most $2 n + 1$ cannot have $n + 1$ double zeros.
The relevant computation is best organized by repeating every node twice.

Every node is therefore listed twice, and the entries of the form $f[x_i, x_i]$ that appear on the diagonal are the derivatives $f'(x_i)$, as established in #link(<cor:repeated-nodes>)[*Repeated Nodes*].
With that convention the table of @eq:divided-difference, written with each node listed twice, produces the Hermite interpolant through @eq:newton-form unchanged.
The interpolation conditions of order two also determine the error exactly as before.

#theorem(name: "Hermite Interpolation Error")[
  Let $f in C^(2 n + 2) [a, b]$, let the nodes lie in $[a, b]$, and let $H$ be the Hermite interpolant of $f$ and $f'$ at these nodes.
  Then for every $x in [a, b]$ there is $xi$ between $x$ and the nodes such that
  #eq[$
    f(x) - H(x) = (f^((2 n + 2)) (xi))/((2 n + 2)!) product_(i=0)^n (x - x_i)^2.
  $] <eq:hermite-error>
] <thm:hermite-error>

#proof[
  Fix $x$ different from the nodes and set $omega (x) = product_(i=0)^n (x - x_i)^2$.
  Choose $K$ so that $phi (t) = f(t) - H(t) - K omega (t)$ vanishes at $t = x$, and note that $phi$ also vanishes, together with its first derivative, at each node, by @eq:hermite-conditions.
  Counting multiplicities, $phi$ has at least $2 n + 3$ zeros, so $2 n + 2$ applications of Rolle's theorem produce a point $xi$ with $phi^((2 n + 2)) (xi) = 0$.
  Since $H$ has degree at most $2 n + 1$ and $omega$ has leading coefficient one, that relation reads $f^((2 n + 2)) (xi) - (2 n + 2)! K = 0$, and substituting the definition of $K$ gives @eq:hermite-error.
]

For the most common case of two nodes the interpolant can be written down explicitly, and the formula is used repeatedly in later chapters.

#proposition(name: "Cubic Hermite Basis")[
  Let $a < b$, $h = b - a$ and $t = (x - a) slash h$.
  The cubic polynomial satisfying @eq:hermite-conditions at $a$ and $b$ is
  #eq[$
    H_3 (x) = y_a h_00 (t) + h y'_a h_10 (t) + y_b h_01 (t) + h y'_b h_11 (t),
  $] <eq:hermite-basis>
  where
  $
    h_00 (t) = 2 t^3 - 3 t^2 + 1, quad h_10 (t) = t^3 - 2 t^2 + t, quad h_01 (t) = -2 t^3 + 3 t^2, quad h_11 (t) = t^3 - t^2.
  $
] <prop:hermite-basis>

#proof[
  Each of the four basis functions has degree three, and direct evaluation shows the pattern of @eq:hermite-conditions: $h_00 (0) = 1$, $h_00 (1) = h'_00 (0) = h'_00 (1) = 0$, with the analogous statements for the other three.
  The combination @eq:hermite-basis therefore satisfies the four conditions, and uniqueness of the Hermite interpolant identifies it as the answer.
]

#example(name: "A cubic Hermite interpolant")[
  Interpolate the data $H(0) = 0$, $H'(0) = 1$, $H(1) = 1$, $H'(1) = 0$.
  With $h = 1$ and $t = x$, @eq:hermite-basis gives
  $
    H_3 (x) = (x^3 - 2 x^2 + x) + (-2 x^3 + 3 x^2) = -x^3 + x^2 + x,
  $
  and indeed $H_3 (0) = 0$, $H_3 (1) = 1$, $H'_3 (x) = -3 x^2 + 2 x + 1$ gives $H'_3 (0) = 1$ and $H'_3 (1) = 0$.
  At the midpoint $H_3 (1 slash 2) = 5 slash 8 = 0.625$, while the straight line through the two values would give $0.5$: the derivatives push the graph upwards in between.
]

#note(title: "Where the derivatives come from")[
  Hermite interpolation is only as good as its derivative data.
  When $f'$ is itself computed numerically, the error of that computation enters the interpolant with weight $h$, as @eq:hermite-basis shows, and the accuracy promised by @eq:hermite-error may never be observed.
  The optimal step size of *Algorithm Design Techniques* therefore reappears here: differentiating a tabulated function just accurately enough to interpolate it is a balance problem, and the balance is analysed in *Numerical Differentiation and Integration*.
]

== Interpolation Error and Runge Phenomenon // 插值余项与 Runge 现象

The three constructions above produce the same polynomial, so they share the same remainder @eq:interpolation-error.
What remains of the elementary theory is to turn that formula into a usable bound, and then to see that the bound can fail for reasons that have nothing to do with the data.

#corollary(name: "Interpolation Error Bound")[
  If $abs(f^((n+1))) <= M_(n+1)$ on $[a, b]$, then
  #eq[$
    abs(f(x) - L_n (x)) <= (M_(n+1))/((n+1)!) abs(omega (x)), quad x in [a, b].
  $] <eq:interpolation-error-bound>
] <cor:interpolation-error-bound>

#example(name: "Interpolating the sine with five nodes")[
  Interpolate $f(x) = sin x$ on $[0, 1]$ at the five equispaced nodes $0, 1 slash 4, 1 slash 2, 3 slash 4, 1$.
  Here $abs(f^((5))) <= 1$ and the maximum of $abs(omega)$ on the interval is $3.5 times 10^(-3)$, attained near $x = 0.089$.
  The bound @eq:interpolation-error-bound therefore reads $abs(f - L_4) <= 3.5 times 10^(-3) slash 120 approx 2.9 times 10^(-5)$, and the actual maximum error is $2.7 times 10^(-5)$.
  The bound is sharp here because $abs(f^((5)))$ really does reach its maximum on the interval, and it shows that four interpolating points already deliver almost five correct digits.
]

The bound contains two competing quantities, and the competition is not always won.

#example(name: "Runge's counterexample")[
  Interpolate $f(x) = 1 slash (1 + 25 x^2)$ on $[-1, 1]$ at equispaced nodes and measure the maximum error.
  With $n + 1 = 5$ nodes the maximum error is $0.44$, with $11$ nodes it is $1.9$, with $15$ nodes it is $7.2$, and with $21$ nodes it is $60$.
  The error does not merely fail to decrease: it grows without bound, and the oscillations are concentrated near the endpoints, where the interpolant departs from the function by an amount comparable to the function itself.
]

#figure(
  image("img/runge-phenomenon.svg", width: 88%),
  caption: [Runge's example. Top: $f(x) = 1/(1 + 25x^2)$ together with its equispaced interpolants of degree $6$, $10$ and $20$. The interpolant matches the function in the middle of the interval and oscillates violently near the endpoints, and the amplitude of the oscillation increases with the degree. Bottom: the maximum error on $[-1, 1]$ as a function of the number of nodes, on a logarithmic scale.],
) <fig:runge-phenomenon>

The failure is not an accident of the example, and the reason is visible in @eq:interpolation-error: the quantity $M_(n+1) slash (n+1)!$ does not decrease for this function, because its higher derivatives grow faster than the factorial.
The factorial is not a general guarantee, and a bound that relies on it silently assumes analyticity of a very strong kind.

A second, more informative diagnosis separates the role of the function from the role of the nodes altogether.

#definition(name: "Lebesgue Constant")[
  For nodes $x_0, dots, x_n$ in $[a, b]$, the *Lebesgue constant* is
  $
    Lambda_n = max_(x in [a, b]) sum_(i=0)^n abs(ell_i (x)).
  $
] <def:lebesgue-constant>

#lemma(name: "Interpolation Operator Bound")[
  Let $f$ be continuous on $[a, b]$ and let $E_n^* (f) = min_(p in Pi_n) ||f - p||_oo$ be the best uniform approximation error by polynomials of degree at most $n$.
  Then
  $
    ||L_n f||_oo <= Lambda_n ||f||_oo, quad ||f - L_n f||_oo <= (1 + Lambda_n) E_n^* (f).
  $
] <lem:interpolation-operator-bound>

#proof[
  By @eq:lagrange-formula, $abs(L_n f (x)) <= sum_i abs(ell_i (x)) abs(f(x_i)) <= Lambda_n ||f||_oo$, which is the first inequality.
  For the second, let $p$ be a best approximation; then $f - L_n f = (f - p) - L_n (f - p)$ because $L_n p = p$ for $p in Pi_n$, and the two terms are bounded by $E_n^* (f)$ and $Lambda_n E_n^* (f)$ respectively.
]

#link(<lem:interpolation-operator-bound>)[*Interpolation Operator Bound*] is the right statement of the problem: interpolation converges uniformly if and only if $Lambda_n E_n^* (f) -> 0$, and the two factors behave in opposite ways depending on the nodes.
For equispaced nodes the Lebesgue constant grows exponentially: $Lambda_4 approx 2.2$, $Lambda_8 approx 11.0$ and $Lambda_14 approx 283$ on $[-1, 1]$.
For Chebyshev nodes it grows only logarithmically: $Lambda_10 approx 2.5$ and $Lambda_20 approx 2.9$ for the same interval.
The Runge function has a small best approximation error, since it is analytic in a neighbourhood of the interval, but the exponential factor of equispaced nodes destroys it.

#caution[
  Raising the degree with equispaced nodes is not a way to improve accuracy.
  The interpolant may be computed exactly and still be a bad approximation, and in double precision the computation itself eventually fails as well, since high degree equispaced interpolation is also an ill-conditioned operation.
  Two cures exist, and both abandon the idea of a single polynomial of high degree: piecewise interpolation of low degree, and interpolation at specially chosen nodes.
]

The first cure is the subject of the next chapter, where the interval is cut into pieces and the degree is kept fixed, so that the Lebesgue constant stays bounded by a constant independent of the number of nodes.
The second is developed in *Function Approximation and Curve Fitting*, where the Chebyshev nodes are shown to be optimal in a precise sense and the interpolation error is compared with the best possible error $E_n^* (f)$.
Until then, the practical rule is the one stated in the caution: for tables of many equispaced values, interpolate locally, not globally.

= Piecewise Interpolation and Splines // 分段插值与样条

#counter(math.equation).update(0)

The last section of the previous chapter diagnosed the failure of high degree interpolation and announced two cures.
This chapter develops the first of them: instead of one polynomial of high degree, use many polynomials of low degree, glued together so that the result is still smooth enough to be useful.

The idea can be stated as an exchange rate.
A single polynomial of degree $n$ is infinitely differentiable but has global support, and its Lebesgue constant grows exponentially with $n$ when the nodes are equispaced.
A piecewise polynomial is only finitely differentiable, but each piece depends on a bounded number of data, so the Lebesgue constant stays bounded and the interpolation converges at a rate fixed by the degree rather than by the number of nodes.
Everything in this chapter is an instance of that trade: piecewise linear interpolation buys locality at the price of a discontinuous derivative, and the cubic spline buys back two continuous derivatives at the price of a global tridiagonal system.

== Piecewise Linear Interpolation // 分段线性插值

The simplest way to avoid a global polynomial is to join the data points by straight lines.

#definition(name: "Grid")[
  A *grid* on $[a, b]$ is a set of points $a = x_0 < x_1 < dots < x_N = b$.
  The *step sizes* are $h_i = x_(i+1) - x_i$ and the *mesh size* is $h = max_i h_i$.
] <def:grid>

#definition(name: "Piecewise Linear Interpolant")[
  The *piecewise linear interpolant* of the data $(x_i, y_i)_(i=0)^N$ is the continuous function $p$ that is linear on each $[x_i, x_(i+1)]$ and satisfies $p(x_i) = y_i$ for all $i$.
] <def:piecewise-linear-interpolant>

On the interval $[x_i, x_(i+1)]$ the function $p$ is exactly the linear interpolant of the two endpoint values, so the error theory of *Interpolation Error and Runge Phenomenon* applies piece by piece.

#theorem(name: "Error of Piecewise Linear Interpolation")[
  Let $f in C^2 [a, b]$ with $abs(f'') <= M_2$, and let $p$ be its piecewise linear interpolant on a grid with step sizes $h_i$.
  Then for $x in [x_i, x_(i+1)]$,
  #eq[$
    abs(f(x) - p(x)) <= (M_2)/8 h_i^2 <= (M_2)/8 h^2.
  $] <eq:pl-error>
] <thm:pl-error>

#proof[
  Apply @eq:interpolation-error with $n = 1$ on the interval $[x_i, x_(i+1)]$.
  There, $omega (x) = (x - x_i)(x - x_(i+1))$, whose modulus is maximal at the midpoint and equals $h_i^2 slash 4$, while $(n+1)! = 2$.
  Hence $abs(f - p) <= (M_2 slash 2) dot (h_i^2 slash 4)$, which is @eq:pl-error.
]

Two consequences follow immediately, and both are worth stating because they contrast with the previous chapter.

First, the estimate is uniform in the number of nodes: with $M_2$ fixed, the error tends to zero as the mesh size tends to zero.
In the language of *Rates of Convergence*, the piecewise linear interpolant is a method of order two in $h$, and the order is governed by the smoothness of $f$, not by the number of data points.

Second, the interpolation operator is bounded independently of the grid.
On each interval $p(x) = (1 - t) y_i + t y_(i+1)$ with $t in [0, 1]$, which is a convex combination, so $abs(p(x)) <= ||f||_oo$ and the Lebesgue constant is exactly one.

#example(name: "Piecewise linear interpolation of the sine")[
  Interpolate $sin x$ on $[0, 1]$ with $N = 8$ equal subintervals, so that $h = 1 slash 8$.
  Here $M_2 = 1$ and @eq:pl-error predicts a maximum error of $1 slash 512 approx 1.95 times 10^(-3)$; the observed maximum is $1.57 times 10^(-3)$.
  To reach an accuracy of $10^(-6)$ the same bound requires $h <= sqrt(8 times 10^(-6)) approx 2.8 times 10^(-3)$, that is about $360$ subintervals.
  The cost is a consequence of the order two, and it is the reason for looking for a smoother interpolant.
]

Piecewise linear interpolation is continuous but its derivative jumps at every node.
For plotting it is often enough; for anything that involves differentiating the interpolant, or solving a differential equation with it, the jumps are fatal, because the second derivative is a sum of Dirac masses and the first derivative is not even well defined at the nodes.

#figure(
  image("img/piecewise-vs-spline.svg", width: 70%),
  caption: [The same nine nodes and the same function as in the Runge example, interpolated in three ways. The piecewise linear interpolant is continuous and converges, but has corners at every node; the clamped cubic spline is twice continuously differentiable and reproduces the shape of the peak; the interpolating polynomial of degree eight oscillates with an amplitude comparable to the function itself, as the Lebesgue constant predicts. At this mesh the two piecewise methods have comparable maximum error, of order $10^(-2)$; the difference between them is the regularity of the result, and the order of convergence once the mesh is refined.],
) <fig:piecewise-vs-spline>

#note(title: "Piecewise Hermite interpolation")[
  A cheap way to raise the order without leaving the local setting is to use the derivative data as well, exactly as in *Hermite Interpolation*.
  Piecewise cubic Hermite interpolation on each interval needs $f$ and $f'$ at both ends, is locally determined, and has order four, but it is only once continuously differentiable and it requires derivative data that a table does not usually provide.
  The cubic spline avoids that requirement by determining the missing derivative values from the interpolation conditions themselves.
]

== Cubic Splines // 三次样条

The corners of the piecewise linear interpolant disappear if the pieces are allowed to be cubic and are glued with matching first and second derivatives.
The result is twice continuously differentiable, converges two orders faster than the piecewise linear interpolant, and is still determined by a banded linear system.
This section defines it, counts its degrees of freedom, and then solves it with the moment equations, which are the framework used throughout the rest of the notebook.

=== Definition and Degrees of Freedom // 定义与自由度

#definition(name: "Cubic Spline Interpolant")[
  Let $a = x_0 < x_1 < dots < x_N = b$ be a grid.
  A *cubic spline* interpolating the data $(x_i, y_i)_(i=0)^N$ is a function $S$ satisfying three conditions:
  + it is an interpolant: $S(x_i) = y_i$ for $i = 0, dots, N$, in the sense of #link(<def:interpolation-problem>)[*Polynomial Interpolation Problem*];
  + it is twice continuously differentiable: $S in C^2 [a, b]$;
  + on each subinterval $[x_i, x_(i+1)]$ it is a polynomial of degree at most three.
] <def:cubic-spline>

Counting conditions explains why two further requirements are needed.
There are $4 N$ coefficients, the interpolation conditions give $N + 1$, and the continuity of $S$, $S'$ and $S''$ at the $N - 1$ interior nodes gives $3 (N - 1)$; the total $4 N - 2$ leaves exactly two degrees of freedom.
They are fixed by boundary conditions, of which three kinds are standard.

#definition(name: "Boundary Conditions for Cubic Splines")[
  The two missing conditions are chosen among the following, applied to the interpolant of #link(<def:cubic-spline>)[*Cubic Spline Interpolant*].
  - *Clamped* (or *fixed*, first kind): the end slopes $S'(a)$ and $S'(b)$ are prescribed, usually as $f'(a)$ and $f'(b)$.
  - *Simply supported* (second kind): the end curvatures vanish, $S''(a) = S''(b) = 0$.
  - *Periodic* (third kind): $S'$ and $S''$ take equal values at $a$ and at $b$.
] <def:spline-boundary-conditions>

A spline built with the simply supported conditions is called a *natural spline*.
The name comes from the calculus of variations: when the bending energy of the curve is minimized among all interpolants, the condition $S''(a) = S''(b) = 0$ arises as the natural boundary condition of the problem, without being imposed.

#note(title: "The not-a-knot condition")[
  Engineering software rarely uses the conditions above by default.
  MATLAB's `spline` and most drafting and CAD systems impose the *not-a-knot* condition: the first two and the last two subintervals are required to be pieces of the same cubic, so that $x_1$ and $x_(N-1)$ cease to be knots in the sense of a change of polynomial.
  This removes the need to estimate end slopes, keeps the fourth order of accuracy, and behaves well on ordinary data, which is why it became the default despite having no interpretation in terms of boundary data.
  The boundary conditions of #link(<def:spline-boundary-conditions>)[*Boundary Conditions for Cubic Splines*] remain the right choice when the end slopes or the end curvature are known from the problem.
]

=== The Moment Equations // 三弯矩方程

Two frameworks are used to compute a cubic spline, and they differ only in the unknowns.
The *moment* (or *three-moment*) equations take the second derivatives $M_i = S''(x_i)$ as unknowns.
The *rotation* (or *three-slope*) equations take the first derivatives $m_i = S'(x_i)$ as unknowns, and are the classical form in structural analysis, where they express the equilibrium of the end rotations of each beam.
Both lead to a tridiagonal system of the same size and are related by a diagonal scaling, so the choice is a matter of taste; this notebook develops the moment equations, because the second derivatives enter the error estimates directly.

Writing the spline through its moments is immediate.
Set $M_i = S''(x_i)$ and $h_i = x_(i+1) - x_i$.
Since $S''$ is piecewise linear and continuous, it is the piecewise linear interpolant of the values $M_i$, and integrating twice gives the following formula.

#eq[$
  S(x) = M_i ((x_(i+1) - x)^3)/(6 h_i) + M_(i+1) ((x - x_i)^3)/(6 h_i) + (y_i - (M_i h_i^2)/6) (x_(i+1) - x)/(h_i) + (y_(i+1) - (M_(i+1) h_i^2)/6) (x - x_i)/(h_i)
$] <eq:spline-moment-form>

is the only cubic on $[x_i, x_(i+1)]$ with the prescribed values at the endpoints and second derivatives $M_i$, $M_(i+1)$ there; it is the piecewise linear interpolant of $S''$, integrated twice.
The unknowns $M_0, dots, M_N$ are then determined by requiring that $S'$ be continuous at the interior nodes.

#definition(name: "Moment Equations")[
  The *moment equations* are the linear relations
  #eq[$
    mu_i M_(i-1) + 2 M_i + lambda_i M_(i+1) = d_i, quad i = 1, dots, N - 1,
  $] <eq:moment-equations>
  with
  $
    mu_i = (h_(i-1))/(h_(i-1) + h_i), quad lambda_i = (h_i)/(h_(i-1) + h_i), quad d_i = 6 f[x_(i-1), x_i, x_(i+1)],
  $
  where $f[x_(i-1), x_i, x_(i+1)]$ is the second divided difference of the data.
] <def:moment-equations>

The derivation is one line of bookkeeping: differentiating @eq:spline-moment-form and equating the limits of $S'$ at $x_i$ from the two sides gives
$
  (h_(i-1))/6 M_(i-1) + (h_(i-1) + h_i)/3 M_i + (h_i)/6 M_(i+1) = (y_(i+1) - y_i)/(h_i) - (y_i - y_(i-1))/(h_(i-1)),
$
and dividing by $(h_(i-1) + h_i) slash 6$ produces @eq:moment-equations, the right-hand side being six times the second divided difference.
The natural conditions simply set $M_0 = M_N = 0$, while the clamped conditions are the two additional equations
$
  2 M_0 + M_1 = 6/h_0 ((y_1 - y_0)/(h_0) - f'(a)), quad M_(N-1) + 2 M_N = 6/(h_(N-1)) (f'(b) - (y_N - y_(N-1))/(h_(N-1))).
$

#theorem(name: "Existence and Uniqueness of the Cubic Spline")[
  For distinct nodes and either natural or clamped conditions, the cubic spline interpolant exists and is unique.
] <thm:spline-existence>

#proof[
  The coefficient matrix of @eq:moment-equations is tridiagonal with diagonal entries $2$ and off-diagonal entries $mu_i$ and $lambda_i$, which are positive and sum to one.
  Hence it is strictly diagonally dominant, therefore nonsingular, and the moments are uniquely determined; the clamped conditions only replace the two end rows by equations that are themselves diagonally dominant.
  Once the moments are known, @eq:spline-moment-form determines $S$ uniquely on every subinterval.
]

#example(name: "A natural spline through three points")[
  Take the nodes $0, 1, 2$ with values $0, 1, 0$ and unit spacing.

  *Step 1: boundary conditions.* The simply supported choice gives $M_0 = M_2 = 0$.

  *Step 2: the interior moment.* The only equation of @eq:moment-equations reads $2 M_1 = 6 f[0, 1, 2] = -6$, hence $M_1 = -3$.

  *Step 3: the pieces.* Substituting the moments into @eq:spline-moment-form on $[0, 1]$ gives
  $
    S(x) = -1/2 x^3 + 3/2 x,
  $
  and on $[1, 2]$ the same formula with $2 - x$ in place of $x$ gives $S(x) = -1/2 (2 - x)^3 + 3/2 (2 - x)$.

  *Step 4: verification.* The two pieces have second derivatives $-3 x$ and $-3 (2 - x)$, both equal to $-3$ at $x = 1$, so $S''$ is continuous and $S$ is a cubic spline; its values at the nodes are $0, 1, 0$ and its end curvatures vanish, as the boundary conditions require.
]

The construction is now complete, and three properties summarize its quality, the first of them being accuracy: compared with @eq:pl-error the function error improves from $h^2$ to $h^4$, and the second derivative, which does not even exist in the piecewise linear case, is now accurate to $h^2$.

#theorem(name: "Error of the Clamped Cubic Spline")[
  Let $f in C^4 [a, b]$ with $abs(f^((4))) <= M_4$, and let $S$ be the clamped cubic spline of $f$ with $S'(a) = f'(a)$ and $S'(b) = f'(b)$.
  Then
  #eq[$
    ||f - S||_oo <= 5/384 M_4 h^4, quad ||f' - S'||_oo <= (M_4)/24 h^3, quad ||f'' - S''||_oo <= 3/8 M_4 h^2.
  $] <eq:spline-error>
] <thm:spline-error>

#proof[
  Two ingredients are needed, and both are classical.
  First, by the optimality established in *Optimal smoothness* below, the difference between any competitor and the spline is orthogonal to the spline in the inner product of second derivatives.
  Second, the interpolation error of the competitor can be expressed as an integral of $f^((4))$ against a Peano kernel, whose modulus is bounded by the constants in @eq:spline-error.
  Combining the two gives the three estimates; the constants are sharp and are attained, up to the usual factor, by functions with constant fourth derivative.
]

#example(name: "Clamped versus natural spline")[
  Interpolate $sin x$ on $[0, 1]$ with $N = 8$ equal subintervals and $h = 1 slash 8$.
  With the clamped conditions and the exact endpoint slopes, $M_4 = 1$ and @eq:spline-error predicts an error of at most $5 slash 384 dot h^4 approx 3.2 times 10^(-6)$; the observed maximum error is $5.3 times 10^(-7)$.
  The natural spline on the same grid gives $6.5 times 10^(-4)$, three orders of magnitude worse, and refining the grid barely helps: the errors for $N = 8, 16, 32$ are $6.5 times 10^(-4)$, $1.6 times 10^(-4)$ and $4.0 times 10^(-5)$, which decrease like $h^2$ and not like $h^4$.
  The loss is entirely due to the artificial condition $S''(1) = 0$, which is false for $sin x$ at $x = 1$; the interior of the interval is far more accurate than the maximum error suggests.
]

The second property is optimality, and it is what the word *spline* originally meant.

#note(title: "Optimal smoothness")[
  Among all functions of class $C^2$ that interpolate the data and take the prescribed end slopes, the cubic spline is the unique minimizer of the bending energy
  $
    integral_a^b (S''(x))^2 dif x.
  $
  For the natural spline the same statement holds with no slope conditions imposed, the minimizer then satisfying $S''(a) = S''(b) = 0$ as a natural boundary condition of the variational problem.
  This is the precise sense in which a spline is the *smoothest* interpolant, and it explains both its good behaviour and its sensitivity to the boundary conditions: the data determine everything except the two end slopes, and the minimizer fills them in the way that bends least.
]

The third property is numerical stability, and it is the reason the moment equations are used rather than the Vandermonde system of the interpolating polynomial.

#note(title: "A well-conditioned tridiagonal system")[
  The matrix in @eq:moment-equations does not depend on the values $y_i$ and has a condition number bounded independently of $N$, because it is a strictly diagonally dominant matrix with a fixed diagonal.
  The whole spline therefore costs $O(N)$ operations and is computed by a backward stable banded solver, the Thomas algorithm of *Tridiagonal Systems and Thomas Algorithm*.
  This contrasts sharply with the monomial representation of *The Interpolation Problem: Existence and Uniqueness*, where the same interpolant is obtained from a dense system whose condition number grows exponentially with the number of nodes.
]

The balance sheet of the cubic spline is therefore short.

- *Advantages.* It is $C^2$, hence differentiable twice and usable in differential equations; it attains fourth order accuracy when the end conditions are correct; and it is computed by a banded, well-conditioned system in $O(N)$ operations.
- *Drawbacks.* It needs two boundary conditions that the data may not provide; it is only $C^2$, so the third derivative jumps at every node; it does not preserve shape, since a monotone or positive data set can produce a spline that overshoots and oscillates mildly; and a change of one value alters the whole spline in principle, although its influence decays geometrically with distance from the changed node.

Two qualifications belong to the drawbacks just listed.
The estimates @eq:spline-error refer to the global maximum on $[a, b]$ and presuppose the correct end conditions: a wrong boundary condition contaminates the first and last few subintervals and reduces the global order, as the comparison between the clamped and the natural spline in the example above shows, while the interior of the interval remains far more accurate than the maximum error suggests.
When the end slopes are themselves estimated numerically, their error enters the spline with weight of order one near the boundary, in the sense of the discussion in *Hermite Interpolation*, and can dominate the fourth order estimate even when the conditions are formally correct.

== B-Splines and Local Bases // B 样条与局部基

The moment form of the previous section is the right tool for theory: it turns the spline problem into a tridiagonal system whose entries are divided differences.
It is not the right tool for computation, because it presupposes a particular degree and a particular boundary condition, and because the formula @eq:spline-moment-form mixes the data $y_i$ with the unknowns $M_i$.
A basis that depends only on the knots, and in which every spline has a simple coordinate vector, is what is needed, and it is provided by the B-splines.

#definition(name: "Knot Vector")[
  A *knot vector* on $[a, b]$ is a nondecreasing sequence $t_0 <= t_1 <= dots <= t_m$ with $t_0 = a$ and $t_m = b$.
  Repeated knots lower the continuity of the splines at that point: a knot repeated $r$ times gives continuity $C^(p-r)$ for splines of degree $p$.
] <def:knot-vector>

#definition(name: "B-Splines")[
  The *B-splines of degree zero* are the indicator functions of the intervals $[t_i, t_(i+1))$.
  For $p >= 1$ the *Cox–de Boor recursion* defines
  #eq[$
    N_(i,p) (x) = (x - t_i)/(t_(i+p) - t_i) N_(i,p-1) (x) + (t_(i+p+1) - x)/(t_(i+p+1) - t_(i+1)) N_(i+1,p-1) (x).
  $] <eq:bspline-recursion>
] <def:bspline>

The recursion is written with the convention that a quotient whose denominator vanishes is zero.
Its two structural properties are what make the B-splines a good basis.

#proposition(name: "Properties of B-Splines")[
  Each $N_(i,p)$ is a nonnegative piecewise polynomial of degree $p$ whose support is $[t_i, t_(i+p+1)]$, and on $[a, b]$ the B-splines form a partition of unity,
  $
    sum_i N_(i,p) (x) = 1.
  $
] <prop:bspline-properties>

#proof[
  Both claims are proved by induction on $p$.
  For $p = 0$ the indicator functions are nonnegative and sum to one wherever they are defined.
  If they hold for $p - 1$, then @eq:bspline-recursion writes $N_(i,p)$ as a combination with nonnegative weights, since the weights are ratios of nonnegative differences, and the support is the union of the supports of the two terms.
  Summing the recursion over $i$ makes the two sums telescope into the same expression, which equals one by the induction hypothesis.
]

#theorem(name: "Dimension of a Spline Space")[
  Let $t_0, dots, t_m$ be a knot vector and $p >= 0$.
  Then the splines of degree $p$ with these knots form a vector space of dimension $m - p$, and the B-splines $N_(0,p), dots, N_(m-p-1,p)$ are a basis of it.
] <thm:spline-dimension>

The count is transparent once one notices that the recursion @eq:bspline-recursion starts from $m$ indicator functions of degree zero and loses one basis function at each step because the first and last knots support no degree-one spline.

#example(name: "The uniform cubic B-spline")[
  Take integer knots and $p = 3$.
  The B-spline supported on $[-2, 2]$ equals $1 slash 6$ at $x = ±1$, $2 slash 3$ at $x = 0$, and vanishes outside $(-2, 2)$, so that the four unit-spaced values sum to one, in accordance with partition of unity.
  It is the cubic analogue of the hat function of degree one, and translates of it by integers form the basis of the uniform cubic splines used in computer graphics and in signal processing.
]

#figure(
  image("img/bspline-basis.svg", width: 62%),
  caption: [Cubic B-splines on a uniform knot vector of spacing one. Each basis function is supported on four consecutive knot intervals, and in the window shown exactly seven translates are active: their sum, dashed, is identically one. Such a local support is what makes the basis numerically stable, and what allows a single coefficient to be changed without recomputing the whole spline.],
) <fig:bspline-basis>

#note(title: "de Boor's algorithm and stability")[
  A spline written as $S = sum_i c_i N_(i,p)$ is evaluated by de Boor's algorithm, a triangular recursion of the same shape as the divided difference table of *Newton Interpolation and Divided Differences*.
  Every step is an affine combination with positive weights summing to one, so no cancellation occurs and the evaluation is backward stable in the sense of #link(<def:backward-stability>)[*Backward Stable Algorithm*].
  In addition, summing the absolute values of the basis functions gives one by partition of unity, so the Lebesgue constant of the basis is one and does not grow with the number of knots; this is the structural reason why the B-spline basis replaced the monomial basis in every serious spline implementation.
]

The two descriptions of the cubic splines are related in the expected way: with knots at the data points and degree three, the splines of this chapter are exactly the span of the B-splines, and the moment equations @eq:moment-equations are the collocation system in the B-spline basis after elimination of the knot values.
The moment form is convenient for proving error estimates, and the B-spline form is convenient for computing; both describe the same space.

The chapter closes the first of the two cures announced in *Interpolation Error and Runge Phenomenon*.
Piecewise interpolation keeps the Lebesgue constant bounded and reaches any prescribed accuracy by refining the grid, and the cubic spline does so while remaining twice differentiable.
The remaining question, namely what happens when the data are noisy and cannot be interpolated at all, is taken up in *Function Approximation and Curve Fitting*.

#bibliography("references.bib", title: "References", full: true)
