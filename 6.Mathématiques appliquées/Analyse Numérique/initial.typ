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
  version: "v0.1.0",
  extra-info: "This is a notebook for numerical analysis.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
// 主线：误差与稳定性奠基 → 函数逼近与数值微积分 → 数值线性代数
//       → 非线性方程与常微分方程数值解
// 共 4 Part、11 Chapter。
//
// 职责边界：
//   - 范数、内积空间、Banach/Hilbert 空间 → Analyse Fonctionnelle
//     （交叉引用，直接使用结果）
//   - Lebesgue 积分与 L² 空间 → Analyse Réelle（交叉引用）
//   - 线性方程组的代数理论（秩、Cramer 法则、解结构）、Jordan 标准形
//     → Algèbre Linéaire（交叉引用；本笔记仅负责数值算法与误差分析）
//   - ODE 解析理论（存在唯一性、线性系统、Sturm-Liouville 谱论）
//     → Équation Différentielle Ordinaire（交叉引用；本笔记仅数值解法）
//   - Fourier 级数与 Fourier 变换的完整理论 → Analyse Harmonique
//     （交叉引用；本笔记 Ch 5.6 仅含 FFT 的算法导论）
//   - PDE 数值方法的深入理论（有限差分/有限元）→ Équations aux Dérivées
//     Partielles（本笔记不包含，仅 Ch 11.7 作导论衔接）
//
// 设计决策：
//   - Krylov 子空间方法（CG/GMRES）在两本基线教材中均非系统覆盖，
//     但作为现代数值代数的核心工具，扩展为 Ch 8.5
//   - IEEE 754 浮点算术独立成节（Ch 1.3），作为舍入误差的根源
//   - FFT 仅保留算法导论（Ch 5.6），理论归属 Analyse Harmonique
//   - 边值问题数值解（打靶法/有限差分）纳入 Ch 11.6：ODE 笔记不含数值
//     内容，且该节为 PDE 数值方法自然铺垫
//   - SVD 独立成节（Ch 9.5）：与特征值算法同源，现代应用广泛
//
// 教材基线：李庆扬《数值分析》第 5 版 + Burden & Faires
//   《Numerical Analysis》第 10 版 知识点并集（组织顺序独立于教材）。
//
// ==========================================================================
// Part I — Foundations of Numerical Analysis (数值分析基础)
// ==========================================================================
// 设计思路：本 Part 是全书的"度量衡"层。先建立误差的四类来源与度量
// （Ch 1），并下探到浮点算术这一舍入误差的物理根源；再从前向/后向误差
// 的视角引入条件数与数值稳定性（Ch 2），为后续所有算法提供统一的
// 精度—效率评判框架。
// 对应教材：李庆扬 第 1 章；Burden & Faires 第 1 章。

// --- Chapter 1: Error Analysis (误差分析) ---

//   Section 1.1: Sources of Error (误差来源)
//     - 模型误差、观测误差、截断误差、舍入误差
//     - 误差的定性区分与来源定位
//   Section 1.2: Absolute, Relative Error and Significant Digits (绝对误差、相对误差与有效数字)
//     - 绝对误差与误差限、相对误差
//     - 有效数字的定义与判定
//   Section 1.3: Floating-Point Arithmetic (IEEE 754) (浮点算术)
//     - 二进制浮点表示、机器精度 ε、上溢与下溢
//     - 浮点运算的舍入规则与误差放大
//   Section 1.4: Catastrophic Cancellation (灾难性抵消)
//     - 相近数相减的误差放大
//     - 算法设计原则（避免大数吃小数、减少运算次数）

// --- Chapter 2: Numerical Stability and Conditioning (数值稳定性与条件数) ---

//   Section 2.1: Forward and Backward Error (前向误差与后向误差)
//     - 前向/后向误差的定义与联系
//     - Wilkinson 后向误差分析思想
//   Section 2.2: Condition Number and Ill-Conditioned Problems (条件数与病态问题)
//     - 条件数的定义、计算与几何意义
//     - 病态问题实例（Hilbert 矩阵等）
//   Section 2.3: Stability of Algorithms (算法的数值稳定性)
//     - 稳定/不稳定算法的判定
//     - 稳定性与条件数的分工：问题 vs 算法

// ==========================================================================
// Part II — Polynomial Approximation and Numerical Calculus (多项式逼近与数值微积分)
// ==========================================================================
// 设计思路：本 Part 处理连续对象的离散化，是"函数层面"的计算。
// 从插值（Ch 3–4，构造多项式穿过给定点）出发，过渡到整体逼近与拟合
// （Ch 5，不要求过点、只要求误差最小），最后落到数值微分与数值积分
// （Ch 6，插值多项式的直接应用）。插值是整个 Part 的理论支点。
// 对应教材：李庆扬 第 2–4 章；Burden & Faires 第 3、4、8 章。

// --- Chapter 3: Polynomial Interpolation (多项式插值) ---

//   Section 3.1: Existence and Uniqueness (插值多项式的存在唯一性)
//     - 插值问题适定性、Vandermonde 矩阵
//   Section 3.2: Lagrange Interpolation (Lagrange 插值)
//     - 基函数构造、插值公式与算法
//   Section 3.3: Newton Interpolation and Divided Differences (Newton 插值与差商)
//     - 差商表、Newton 插值公式的递推结构
//   Section 3.4: Interpolation Error and Runge Phenomenon (插值余项与 Runge 现象)
//     - 插值余项定理
//     - Runge 现象：高次插值的振荡与启示

// --- Chapter 4: Piecewise Interpolation and Splines (分段插值与样条) ---

//   Section 4.1: Piecewise Linear Interpolation (分段线性插值)
//     - 分段低次插值的收敛性
//   Section 4.2: Hermite Interpolation (Hermite 插值)
//     - 带导数值条件的插值、余项
//   Section 4.3: Cubic Splines (三次样条)
//     - 自然/夹紧样条的构造、二阶光滑性、误差估计
//   Section 4.4: B-Splines (B 样条)
//     - B 样条的递推定义与局部支集性质

// --- Chapter 5: Function Approximation and Curve Fitting (函数逼近与曲线拟合) ---

//   Section 5.1: Best Uniform Approximation (最佳一致逼近)
//     - 无穷范数意义下的逼近、Chebyshev 交错定理
//   Section 5.2: Chebyshev Polynomials and Economization (Chebyshev 多项式与多项式压缩)
//     - Chebyshev 多项式的性质、多项式次数压缩
//   Section 5.3: Least-Squares Approximation (连续最小二乘逼近)
//     - 最佳平方逼近、法方程
//   Section 5.4: Orthogonal Polynomials (正交多项式)
//     - Legendre/Chebyshev/Laguerre/Hermite 多项式系
//     - 正交多项式使法方程对角化
//   Section 5.5: Discrete Least-Squares Fitting (离散最小二乘拟合)
//     - 超定方程组与正规方程 AᵀAx = Aᵀb
//   Section 5.6: Trigonometric Approximation and FFT (三角逼近与 FFT)
//     - 离散 Fourier 变换与 FFT 算法导论
//     - 理论细节交叉引用 Analyse Harmonique

// --- Chapter 6: Numerical Differentiation and Integration (数值微分与数值积分) ---

//   Section 6.1: Numerical Differentiation (数值微分)
//     - 前向/后向/中心差商、误差阶
//     - 舍入误差与最优步长
//   Section 6.2: Newton–Cotes Formulas (Newton–Cotes 公式)
//     - 梯形公式、Simpson 公式、代数精度
//   Section 6.3: Composite Quadrature (复化求积公式)
//     - 复化梯形与复化 Simpson 的误差阶
//   Section 6.4: Richardson Extrapolation and Romberg Integration (Richardson 外推与 Romberg 积分)
//     - Richardson 外推原理、Romberg 算法
//   Section 6.5: Gaussian Quadrature (Gauss 型求积公式)
//     - 节点-权重联立、2n−1 次代数精度
//     - Gauss–Legendre 公式与误差
//   Section 6.6: Adaptive Quadrature (自适应求积)
//     - 误差控制与区间细分策略

// ==========================================================================
// Part III — Numerical Linear Algebra (数值线性代数)
// ==========================================================================
// 设计思路：本 Part 处理矩阵层面的计算，是数值分析中应用最广、
// 理论最成熟的分支。直接法（Ch 7）有限步得解但受舍入与存储限制；
// 迭代法（Ch 8）适合大型稀疏系统，收敛理论依赖谱半径（与 Ch 9 特征值
// 互为工具）；特征值问题（Ch 9）综合运用分解与迭代思想，是算法理论的
// 集大成者。矩阵代数理论（秩、Jordan 形）交叉引用 Algèbre Linéaire。
// 对应教材：李庆扬 第 5、6、8 章；Burden & Faires 第 6、7、9 章。

// --- Chapter 7: Direct Methods for Linear Systems (线性方程组直接法) ---

//   Section 7.1: Gaussian Elimination (Gauss 消去法)
//     - 消去与回代、运算量 O(n³)
//   Section 7.2: Pivoting Strategies (选主元策略)
//     - 列主元、标度化与数值稳定性
//   Section 7.3: LU Factorization (LU 分解)
//     - Doolittle/Crout 分解、多右端项求解
//   Section 7.4: Cholesky Factorization (Cholesky 分解)
//     - 对称正定矩阵的分解、运算量减半
//   Section 7.5: Tridiagonal Systems and Thomas Algorithm (三对角系统与追赶法)
//     - 追赶法、O(n) 复杂度
//   Section 7.6: Error Analysis for Direct Methods (直接法的误差分析)
//     - 条件数误差界、迭代改进

// --- Chapter 8: Iterative Methods for Linear Systems (线性方程组迭代法) ---

//   Section 8.1: Basic Iteration and Convergence (基本迭代格式与收敛性)
//     - 迭代格式的一般构造、谱半径判据 ρ(B) < 1
//   Section 8.2: Jacobi and Gauss–Seidel Methods (Jacobi 与 Gauss–Seidel 迭代)
//     - 分量形式与矩阵形式、收敛速度
//   Section 8.3: Successive Over-Relaxation (SOR 松弛法)
//     - 松弛因子 ω、最优松弛参数
//   Section 8.4: Convergence Theorems (收敛定理)
//     - 严格对角占优、对称正定条件
//   Section 8.5: Krylov Subspace Methods (Krylov 子空间方法)
//     - 共轭梯度法（CG）、GMRES 导论

// --- Chapter 9: Eigenvalue Problems (特征值问题) ---

//   Section 9.1: Power and Inverse Power Methods (幂法与反幂法)
//     - 幂法求模最大特征值、反幂法与平移
//   Section 9.2: Jacobi Method for Symmetric Matrices (Jacobi 旋转法)
//     - 正交相似变换逐次消元
//   Section 9.3: Householder Reduction (Householder 化简)
//     - Householder 变换、Hessenberg 化
//   Section 9.4: The QR Algorithm (QR 算法)
//     - 基本 QR 迭代、位移策略与收敛性
//   Section 9.5: Singular Value Decomposition (奇异值分解)
//     - SVD 定义、与特征值问题的联系

// ==========================================================================
// Part IV — Nonlinear Equations and Numerical ODEs (非线性方程与常微分方程数值解)
// ==========================================================================
// 设计思路：本 Part 处理方程与演化系统的求解。非线性求根（Ch 10）从
// 一维的二分/不动点/Newton 出发，建立收敛阶理论，并扩展到方程组；
// ODE 数值解（Ch 11）从单步法到多步法再到稳定性与刚性方程，
// 其中隐式方法每步内嵌 Newton 迭代（依赖 Ch 10），Adams 多步法依赖
// 插值技术（呼应 Part II）。末节（11.7）为 PDE 数值方法作导论衔接，
// 深入理论归属 Équations aux Dérivées Partielles。
// 对应教材：李庆扬 第 7、9 章；Burden & Faires 第 2、5、10–12 章。

// --- Chapter 10: Nonlinear Equations (非线性方程求根) ---

//   Section 10.1: Bisection Method (二分法)
//     - 区间收缩、线性收敛与停机准则
//   Section 10.2: Fixed-Point Iteration (不动点迭代)
//     - 压缩条件 |g′(x*)| < 1、收敛性定理
//   Section 10.3: Newton's Method (Newton 法)
//     - 切线逼近、二次收敛、多重根与下山策略
//   Section 10.4: Secant Method (弦截法)
//     - 差商替代导数、超线性收敛阶
//   Section 10.5: Order of Convergence (收敛阶分析)
//     - 收敛阶定义、各方法收敛阶对比
//   Section 10.6: Systems of Nonlinear Equations (非线性方程组)
//     - 多元 Newton 法、Jacobian 与收敛性

// --- Chapter 11: Numerical Methods for ODEs (常微分方程数值解) ---

//   Section 11.1: One-Step Methods: Euler Family (单步法：Euler 族)
//     - 显式/隐式/梯形/改进 Euler 方法
//     - 局部截断误差与精度阶
//   Section 11.2: Runge–Kutta Methods (Runge–Kutta 方法)
//     - RK 族构造原理、经典 RK4
//     - 误差估计（嵌入式方法导论）
//   Section 11.3: Multistep Methods (多步法)
//     - Adams–Bashforth/Adams–Moulton 公式
//     - 预测-校正格式与起步值
//   Section 11.4: Consistency, Convergence and Stability (相容性、收敛性与稳定性)
//     - 相容性、收敛性、绝对稳定区域
//     - Lax 等价定理（相容 + 稳定 ⟺ 收敛）
//   Section 11.5: Stiff Equations (刚性方程)
//     - 刚性问题的本质、A-稳定与 BDF 方法
//   Section 11.6: Boundary Value Problems (边值问题数值解)
//     - 打靶法、有限差分法
//   Section 11.7: Numerical Methods for PDEs: A Bridge (PDE 数值方法导论)
//     - 有限差分思想简述
//     - 深入理论参见 Équations aux Dérivées Partielles

// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循"基础奠基 → 函数逼近 → 矩阵计算 → 方程求解"的对象递进主线，
// 共 4 Part、11 Chapter。
//
// Part I（Ch 1–2，数值分析基础）：误差四源、有效数字、浮点算术，
//   以及前向/后向误差、条件数与数值稳定性，构成全书的精度评判框架。
//
// Part II（Ch 3–6，多项式逼近与数值微积分）：插值（含样条）→ 逼近与
//   拟合 → 数值微分与积分，完成连续对象在函数层面的离散化。
//
// Part III（Ch 7–9，数值线性代数）：直接法、迭代法、特征值问题，
//   矩阵层面的求解与算法理论，其中 Krylov 方法与 SVD 为现代扩展。
//
// Part IV（Ch 10–11，非线性方程与常微分方程数值解）：非线性求根与
//   ODE 数值解法，隐式方法内嵌 Newton、多步法依赖插值，
//   末节为 PDE 数值方法作导论衔接。
//
// 教材覆盖：李庆扬《数值分析》第 5 版全部 9 章知识点均已覆盖；
//   Burden & Faires《Numerical Analysis》第 10 版核心章节
//   （Ch 1–9、11–12）知识点均已覆盖，并补充 Krylov 方法、SVD、
//   IEEE 754 浮点算术等现代扩展内容。
// ==========================================================================

#bibliography("references.bib", title: "References", full: true)
