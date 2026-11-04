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
//   Section 4.2: Cubic Splines: Construction (三次样条：构造)
//     - 自然/夹紧边界条件、三弯矩方程、二阶光滑性
//   Section 4.3: Cubic Splines: Error Estimates (三次样条：误差估计)
//     - 样条插值的误差阶与最优性
//   Section 4.4: B-Splines and Local Bases (B 样条与局部基)
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
  ("Truncation error", "An infinite or continuous process is replaced by a finite or discrete one", "Yes", [decreases with the step size $h$]),
  ("Roundoff error", "Real numbers are replaced by floating-point numbers", "Yes", [of the order of $u$, independent of $h$]),
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

#bibliography("references.bib", title: "References", full: true)
