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

#bibliography("references.bib", title: "References", full: true)
