#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Analyse Harmonique", // 调和分析
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Analyse Harmonique", // 调和分析
  "Violet",
  subtitle: "A notebook for harmonic analysis",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.3.0",
  extra-info: "This is a notebook for harmonic analysis.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
// 主线叙事：经典 Fourier 级数 → Fourier 变换与现代理论 → Sobolev 空间
// 参考教材：Stein & Shakarchi "Fourier Analysis: An Introduction"，于品 "Fourier 分析"
//
// 职责边界 (SRP Boundaries)：
// - 本笔记负责：Fourier 级数理论、Fourier 变换理论、Sobolev 空间
// - L¹/L²/p 空间的一般理论 → Analyse Réelle（本笔记仅引用结果）
// - Banach/Hilbert 空间抽象理论 → Analyse Fonctionnelle（本笔记仅引用结果）
// - 分布理论 (Distribution Theory) → Équations aux Dérivées Partielles
// - Sobolev 空间在 PDE 中的应用 → Équations aux Dérivées Partielles（引用本笔记定义与定理）

// ==========================================================================
// Part I — Classical Fourier Series (经典 Fourier 级数)
// ==========================================================================
// 设计思路：从经典 Fourier 级数出发，建立 Fourier 系数、核函数、收敛性等基础理论。
// Part I 涵盖从 Euler-Fourier 公式到逐点收敛判别法，再到 Cesàro 求和与平方平均收敛。
// 对应教材：Stein & Shakarchi Ch 1-4（Ch 4 仅取其等分布部分，等周与热方程交叉引用其他笔记），于品 Ch 1-3
// 对应 LaTeX：chap01.tex (Classical Fourier Series), chap02.tex (Cesàro Summation)

// --- Chapter 1: Fourier Coefficients and Dirichlet Kernel (傅里叶系数与 Dirichlet 核) ---

//   Section 1.1: Functions on the Unit Circle (圆周上的函数)
//     - 周期函数与圆周 T 的对应
//     - 函数空间 R[-π, π] 的内积与范数结构

//   Section 1.2: Fourier Coefficients and Euler-Fourier Formula (傅里叶系数与 Euler-Fourier 公式)
//     - 正交基 {e^(inx)} 与 Fourier 系数定义
//     - 复数形式与实数形式的转换
//     - 任意周期 2T 的推广
//     - 正弦级数与余弦级数

//   Section 1.3: Dirichlet Kernel and Convolution (Dirichlet 核与卷积)
//     - Dirichlet 核 D_(N)(x) 的定义与性质（偶性、归一化）
//     - Lebesgue 常数与 D_N 的"坏核"本质
//     - 卷积的定义与基本性质（交换律、结合律、分配律、平移不变性）
//     - 卷积定理：频域乘积 ↔ 时域卷积

//   Section 1.4: Localization Theorem (局部化定理)
//     - Riemann-Lebesgue 引理（含证明）
//     - Riemann 局部化定理（含证明）
//     - Dirichlet 积分的化简

//   Section 1.5: Pointwise Convergence Tests (逐点收敛判别法)
//     - Hölder 条件与 Lipschitz 条件
//     - Dirichlet 引理
//     - Lipschitz 判别法、Dini 判别法、Dirichlet-Jordan 判别法
//     - Gibbs 现象

//   Section 1.6: Properties of Fourier Series (Fourier 级数的性质)
//     - 逐项积分与逐项微分
//     - 光滑性与衰减速度的关系
//     - 唯一性定理

// --- Chapter 2: Cesàro Summation and Square Mean Convergence (Cesàro 求和与平方平均收敛) ---

//   Section 2.1: Cesàro Summation and Fejér Kernel (Cesàro 求和与 Fejér 核)
//     - Cesàro 求和的定义
//     - Fejér 核 F_(N)(t) 的定义与四大性质（正性、归一化、集中性、有界性）
//     - Dirichlet 核 vs Fejér 核对比表
//     - Fejér 定理（含 Weierstrass 逼近定理推论）

//   Section 2.2: Square Approximation and Parseval's Identity (平方逼近与 Parseval 恒等式)
//     - Fourier 级数的最佳平方逼近性质
//     - Bessel 不等式
//     - Parseval 恒等式（含广义形式）
//     - 应用：计算特殊级数求和 (Σ1/n², Σ1/n⁴ 等)

//   Section 2.3: Classical Inequalities (经典不等式)
//     - Wirtinger 不等式（含等号条件）
//     - Poincaré 不等式
//     - Friedrichs 不等式

//   Section 2.4: Square Mean Convergence (平方平均收敛)
//     - L² 收敛的定义
//     - Fourier 级数的平方平均收敛定理

//   Section 2.5: Poisson Kernel (Poisson 核)
//     - Poisson 核的定义与基本性质
//     - Poisson 积分与调和函数
//     - Poisson 核的逼近性质

//   Section 2.6: Equidistribution (等分布问题)
//     - Weyl 等分布准则
//     - Fourier 分析在等分布理论中的应用
//
// 收尾注记（非独立章节）：Carleson-Hunt 定理
//     - L²(T)（乃至 L^p, p > 1）中 Fourier 级数几乎处处收敛
//     - 仅作陈述与历史定位；其证明依赖时频分析与算子理论，超出本笔记范围
//     - 由原 Part II "Ch 3 Modern Fourier Analysis" 降级而来，不单独成章

// ==========================================================================
// Part II — Fourier Transform and Modern Theory (Fourier 变换与现代理论)
// ==========================================================================
// 设计思路：本 Part 完成"周期 → 非周期"的转折，并把 Part I 中的有限测度（级数）
// 视角升级为连续谱（变换）视角。组织顺序严格遵循依赖关系：
//   变换本体（Schwartz 空间 → 基本性质 → 反演）→ L¹/L² 延拓（Plancherel）→ 补充与应用
// 即"先造工具、再谈延拓、最后扩展"，而非先讲 L¹/L² 再讲变换。
// 对应教材：Stein & Shakarchi Ch 5 (R 上的 Fourier 变换)、Ch 6 (R^d 上的 Fourier 变换)，于品 Ch 4-5
// 对应 LaTeX：chap04.tex (Fourier Transform)；原 chap03.tex (Modern Fourier Analysis) 已拆解重组
//
// 与 Part I 的分工：L²(T) 上的 Parseval 与平方平均收敛已在 Part I Ch 2 §2.2、§2.4 完成，
// 本 Part 不再重复；Carleson-Hunt 定理证明超出本笔记范围，降级为 Part I 的收尾注记。
//
// 职责边界（本 Part 的裁决）：
// - Fourier 变换本体（含 S(R)^d、缓增分布的 Fourier 变换、Plancherel）→ 本笔记
// - L^p 空间一般理论（完备性、可分性、对偶、Riesz-Thorin 插值）→ Analyse Réelle
//   （其蓝图 Ch 12 "Fourier Analysis on L^p" 应改为引用本 Part）
// - 一般分布理论（测试函数、弱导数、基本解）→ Équations aux Dérivées Partielles
//   本笔记只取 Fourier 变换所需的 S'(R) 最小片段，不重建分布论
// - Laplace 变换：EDO 笔记已将"收敛类 + 反演公式"抵押给本 Part（EDO:37, 1652），
//   故 §5.3 必须包含反演公式与收敛半平面，不能只列性质表
// - FFT（数值算法）不属于调和分析理论 → 移入附录，仅作注记

// --- Chapter 3: The Fourier Transform on R (实轴上的 Fourier 变换) ---

//   Section 3.1: From Periodic to Non-Periodic (从周期函数到非周期函数)
//     - 从 Fourier 级数到 Fourier 变换的极限过程（启发式推导，作为动机而非证明）
//     - Fourier 变换与逆变换的定义
//     - 频率约定（已定）：采用 xi 约定 hat(f)(xi) = ∫ f(x) e^(-2pi i xi x) dx，逆变换无前置系数；
//       另设换算字典 omega = 2 pi xi，供 §5.3 Laplace 的 s = sigma + i omega 复用
//     - 归一化陷阱：F[f](0) = ∫ f，与级数的 (1)/(2 pi) 约定不同（#caution）
//     - 注：Poisson 求和公式后移至 §4.3（它是反演的推论，不能作为入口）

//   Section 3.2: Schwartz Space and Tempered Distributions (速降空间与缓增分布)
//     - Schwartz 空间 S(R) 的定义与半范数族（Fréchet 结构）；完整写一维版，
//       并注明与 EDP 的 <def:test-fn-space-S>（n 维测试函数版）一致，不重复多指标部分
//     - S(R) 对微分、乘多项式的封闭性
//     - 缓增分布 S'(R) 的定义与基本运算（最小片段；一般分布论参见 EDP 笔记）
//     - 注：S'(R) 仅为 §3.3-§4.2 中"Fourier 变换可延拓"的表述服务

//   Section 3.3: Basic Properties of the Fourier Transform (Fourier 变换的基本性质)
//     - 线性性、平移性、调制性、缩放性
//     - 微分与乘子的对偶：F[f'] = i omega hat(f)，F[x f] = i (hat(f))'
//     - 卷积定理与乘法公式（Fourier 变换版本）
//     - S(R) 上变换的连续性与周期性 F^4 = id（其中 F^2 是反射 f(x) -> f(-x)）

//   Section 3.4: Fourier Inversion Theorem (Fourier 反演定理)
//     - Gauss 核与恒等逼近（与 Part I 的 Fejér 核平行，交叉引用其集中性论证）
//     - 反演定理（S(R) 上成立；L¹ 上需附加条件）
//     - 唯一性推论

// --- Chapter 4: L¹, L² and the Plancherel Theorem (L¹、L² 与 Plancherel 定理) ---

//   Section 4.1: The Fourier Transform on L¹ (L¹ 上的 Fourier 变换)
//     - F: L¹(R) → L^oo(R) 的有界性与范数估计
//     - Riemann-Lebesgue 引理的变换版本（级数版本见 Part I §1.4）
//     - 值域不闭：变换不映满 L^oo（Riemann-Lebesgue 的逆问题）
//     - L¹ 上的反演（附加条件下）

//   Section 4.2: Plancherel Theorem (Plancherel 定理)
//     - L¹ ∩ L² 上的等距性与稠密性延拓
//     - ||hat(f)||_2 = ||f||_2 与极化恒等式
//     - F 是 L²(R) 上的酉算子；与 Part I §2.2 Parseval 恒等式的对应
//     - 注：Riesz-Thorin 插值不在本笔记（→ Analyse Réelle）

//   Section 4.3: Poisson Summation Formula (Poisson 求和公式)
//     - 陈述与证明（周期化 + 反演定理）
//     - 抽样定理（Shannon）作为推论
//     - 注：级数与变换之间的桥梁，须在 §3.4 之后

//   Section 4.4: Heisenberg's Uncertainty Principle (海森堡不确定性原理)
//     - 陈述与证明（分部积分 + Cauchy-Schwarz）
//     - 等号条件（Gauss 函数）
//     - 与 Hardy 不确定性原理的关系（只作注记）

// --- Chapter 5: Complements and Applications (补充与应用) ---

//   Section 5.1: The Fourier Transform on R^d (R^d 上的 Fourier 变换)
//     - 多元定义、张量积结构、Fubini 化归
//     - 旋转不变性与球对称函数的变换
//     - Radon 变换与投影切片定理
//     - 波方程基本解（应用；PDE 细节交叉引用 EDP 笔记）

//   Section 5.2: Paley-Wiener Theorem (Paley-Wiener 定理)
//     - 紧支集函数的变换是整函数（指数型）
//     - 指数型整函数的刻画（复分析工具交叉引用 Analyse Complexe）

//   Section 5.3: Laplace Transform (拉普拉斯变换)
//     - 定义、收敛半平面与解析性（交叉引用 Analyse Complexe）
//     - 基本性质（线性性、微分性质、卷积定理）
//     - 与 Fourier 变换的关系（s = sigma + i omega）
//     - 反演公式（Bromwich 积分）——为 EDO 笔记提供被抵押的完整理论
//     - 常见变换表移至附录 B

// --- Appendices (附录) ---
//
//   Appendix A: Fast Fourier Transform (快速 Fourier 变换)
//     - 算法思想（分治）与计算复杂度
//     - 与 EDP 笔记谱方法的关系（仅注记，不展开证明）
//
//   Appendix B: Tables of Fourier and Laplace Transforms (Fourier 与 Laplace 变换表)
//     - 常见 Fourier 变换对
//     - 常见 Laplace 变换对（原 §4.7 的表格迁入此处）
//
// 正文迁移状态（蓝图与正文的差异，供施工时对照）：
// - 旧 "Ch 3 Modern Fourier Analysis"（正文 1380-1390）整体撤销：
//   L¹/L² 两节并入 Chapter 4；Carleson-Hunt 移作 Part I 收尾注记。
// - 旧 §4.1 "Introduction to Fourier Transform"（1393-1435）拆为 §3.1，Poisson 求和独立为 §4.3，
//   并需修复 1404-1418 的迁移残渣（孤立逗号、缺失 plus 与乘号）与频率约定不一致。
// - 旧 §4.2 "Schwartz Space"（1437-1447）→ §3.2，需补 S'(R) 片段。
// - 旧 §4.3 "Basic Properties"（1449-1477，含误置于其下的 === Convolution）→ §3.3，
//   需补 modulation、multiplication、Parseval 与空缺的第 5 条 Integration。
// - 旧 §4.4 "Fourier Inversion Theorem"（1479）→ §3.4。
// - 旧 §4.5 "The Dichotomy"（1481）→ §4.1 + §4.2（二分拆为两节，标题不再用 Dichotomy）。
// - 旧 §4.6 "Heisenberg"（1483-1494）→ §4.4，公式需修复。
// - 旧 §4.7 "Laplace Transform"（1496-1550）→ §5.3，补反演公式；表 1533-1550 迁入附录 B。
// - 旧 §4.8 "Fast Fourier Transform"（1552）→ 附录 A。

// ==========================================================================
// Part III — Sobolev Spaces (Sobolev 空间)
// ==========================================================================
// 设计思路：Sobolev 空间是调和分析的核心工具，也是连接 Fourier 分析与 PDE 的桥梁。
// 本 Part 的立足点是 Part II 的 Plancherel 定理：H^s 用 Fourier 变换刻画，
// 从而把"弱可微"翻译为"频谱衰减"，这是本笔记不可替代的贡献。
// 对应教材：Evans Ch 5，Adams "Sobolev Spaces"
//
// 职责边界（含待裁决项）：
// - 本笔记负责：H^s(R^d) 的 Fourier 刻画、Plancherel 型范数等价、Fourier 视角下的嵌入与紧嵌入
// - Équations aux Dérivées Partielles 已写完 Sobolev 空间的定义、嵌入定理与迹定理
//   （其 Ch "Sobolev Spaces"，EDP:1363-1451）。若照原规划全盘重建，将造成整章重复。
//   建议裁决：W^(k,p) 的定义、嵌入定理的证明、迹定理 → 归 EDP，本笔记交叉引用；
//   本 Part 只保留 H^s 的 Fourier 刻画与谱方法视角。此处暂按原规划列出，待用户确认后收缩。
// - Sobolev 空间在 PDE 弱解中的应用 → EDP

// --- Chapter 6: Sobolev Spaces (Sobolev 空间) ---

//   Section 6.1: Definition and Basic Properties (定义与基本性质)
//     - 弱导数的定义（交叉引用 EDP 笔记，不重建）
//     - Sobolev 空间 W^(k,p) 与 H^s 的定义
//     - H^s 的 Fourier 刻画：||f||_(H^s)^2 = ∫ (1 + |xi|^2)^s |hat(f)(xi)|^2 dxi
//     - 基本性质与范数等价

//   Section 6.2: Sobolev Embedding Theorems (Sobolev 嵌入定理)
//     - 连续嵌入与紧嵌入
//     - Sobolev 不等式
//     - Morrey 不等式
//     - Rellich-Kondrachov 紧嵌入定理（证明归属待裁决，见上）

//   Section 6.3: Trace Theorem (迹定理)
//     - 边界迹算子的定义
//     - 迹定理的陈述与证明

//   Section 6.4: Poincaré and Friedrichs Inequalities (Poincaré 不等式与 Friedrichs 不等式)
//     - Poincaré 不等式（与 Part I §2.3 的级数版本对照，避免重复陈述）
//     - Friedrichs 不等式（同上）
//     - 在 Sobolev 空间中的完整证明

//   Section 6.5: Interpolation and Duality (插值与对偶)
//     - 实插值与复插值方法（Riesz-Thorin 的一般理论 → Analyse Réelle）
//     - Sobolev 空间的对偶空间
//     - 负指数 Sobolev 空间 H^(-s)

// ==========================================================================
// 教材覆盖度映射表 (Coverage Mapping)
// ==========================================================================
// | 教材位置      | 知识点                                                      | 本笔记位置                        | 备注                    |
// |--------------|-------------------------------------------------------------|----------------------------------|-------------------------|
// | Stein Ch 1   | 弦振动、热方程、Fourier 级数的起源                            | Ch 1, §1.1                       | 动机层面                 |
// | Stein Ch 2   | Fourier 级数、Dirichlet 核、典型例子                          | Ch 1                             | 直接对应                 |
// | Stein Ch 3   | Good kernels、Fejér/Cesàro、Poisson/Abel 求和、收敛判别         | Ch 1-2, §2.1, §2.5               | 直接对应                 |
// | Stein Ch 4   | 等周不等式、Weyl 等分布、热方程的应用                          | Ch 2, §2.6                       | 仅取等分布；其余交叉引用   |
// | Stein Ch 5   | R 上 Fourier 变换：反演、Plancherel、Paley-Wiener、Poisson 求和、Heisenberg | Ch 3-5, §3.4, §4.2-4.4, §5.2 | 直接对应（原表误记为 Ch 4）|
// | Stein Ch 6   | R^d 上 Fourier 变换：Radon 变换、波方程                        | Ch 5, §5.1                       | 原表遗漏，现补齐          |
// | Stein Ch 7   | 有限 Fourier 分析（Z/NZ）                                     | 附录 A                           | 仅作 FFT 的代数背景       |
// | 于品 Ch 1-3  | 经典理论与收敛性                                              | Ch 1-2                           | 直接对应                 |
// | 于品 Ch 4-5  | 变换与现代理论                                                | Ch 3-5                           | 直接对应                 |
// | Evans Ch 5   | Sobolev 空间                                                  | Ch 6                             | 与 EDP 重复，待裁决       |
// | Poisson 核   | Poisson 核与调和函数                                          | Ch 2, §2.5                       | 补充内容                 |
// | 等分布理论    | Weyl 准则                                                     | Ch 2, §2.6                       | 补充内容                 |
// | Plancherel   | L² 等距延拓与酉性                                             | Ch 4, §4.2                       | 补充内容（Riesz-Thorin → Analyse Réelle）|
// | 缓增分布      | S'(R) 上的 Fourier 变换                                       | Ch 3, §3.2                       | 补充内容，填补三方互推的空白 |
// | Laplace 变换  | 收敛半平面、反演公式、变换表                                   | Ch 5, §5.3 + 附录 B              | 兑现 EDO 笔记的抵押        |
// | FFT          | 分治算法与复杂度                                              | 附录 A                           | 数值内容，不入理论主体     |
//
// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循"经典级数 → 变换与现代理论 → Sobolev 空间"的三段式主线，
// 共 3 Part、6 Chapter、2 Appendix。
//
// Part I（Ch 1-2）：经典 Fourier 级数理论，从 Euler-Fourier 公式到逐点收敛与平方平均收敛；
//                   以 Carleson-Hunt 定理的陈述收尾（不单独成章）。
// Part II（Ch 3-5）：变换本体（Schwartz 空间 → 基本性质 → 反演）→ L¹/L² 延拓（Plancherel）
//                   → 补充与应用（R^d、Paley-Wiener、Laplace）；FFT 与变换表移入附录。
//                   L²(T) 上的 Parseval 与平方平均收敛已在 Part I 完成，此处不重复。
// Part III（Ch 6）：Sobolev 空间，以 H^s 的 Fourier 刻画为核心；
//                   W^(k,p) 定义、嵌入与迹定理与 EDP 笔记重叠，边界待裁决。
//
// 教材覆盖：Stein & Shakarchi Ch 1-7（Ch 7 仅作附录背景）、于品 Ch 1-5、Evans Ch 5，
// 并补充 Poisson 核、等分布、缓增分布的 Fourier 变换、Laplace 反演等内容。
//
// 正文进度：Part I 已完成；Part II 正文仍为旧 Ch 3-4 结构，须按上方迁移状态逐节改写；
//           Part III 仅有占位。
// ==========================================================================

// ==========================================================================
// Migrated Content (LaTeX -> Typst)
// ==========================================================================

#part("Classical Fourier Series") // 经典 Fourier 级数

= Fourier Coefficients and Dirichlet Kernel // Fourier 系数与 Dirichlet 核
In this chapter we investigate Fourier series in the following two function spaces.

== Function Spaces // 函数空间
#definition(name: "Riemann Integrable Functions on the Circle")[
  Let $cal(R)[-pi, pi]$ denote the space of complex-valued $2pi$-periodic functions on $[-pi, pi]$ that are Riemann integrable, or absolutely improperly Riemann integrable, there#footnote[
    "Improper" refers to a singularity at an endpoint, and the improper integral is required to converge absolutely; we write "Riemann integrable" for short in the sequel.
    The interval $[-pi, pi]$ may of course be replaced by $[-T, T]$.
  ].
  Let $cal(R)^2[-pi, pi]$ denote the subspace of those $f$ for which $integral_(-pi)^(pi) abs(f(x))^2 dif x$ converges.
] <def:function-spaces>

Both are infinite-dimensional linear spaces over $bb(C)$, and $cal(R)^2[-pi, pi] subset.eq cal(R)[-pi, pi]$: the Cauchy-Schwarz inequality gives, for $f$ supported in a bounded interval,
$
  integral_(a)^(b) abs(f(x)) dif x <= sqrt(b - a) ( integral_(a)^(b) abs(f(x))^2 dif x )^(1/2),
$
so square integrability implies absolute integrability.

On these spaces we use the normalized integral
$
  ⟨ f, g ⟩ = (1) / (2pi) integral_(-pi)^(pi) f(x) overline(g(x)) dif x, quad
  || f || = sqrt(⟨ f, f ⟩) = ( (1) / (2pi) integral_(-pi)^(pi) abs(f(x))^2 dif x )^((1) / (2)).
$
The factor $(1) / (2pi)$ is a convention, chosen so that $|| 1 || = 1$; it is the one used throughout the note.

Three caveats are worth recording at once.

- The pairing $⟨ f, g ⟩$ is only a _semi_-inner product on $cal(R)[-pi, pi]$: $⟨ f, f ⟩ = 0$ holds for every function vanishing almost everywhere, so the space is to be read as a space of equivalence classes modulo such functions.
- The norm is finite only on $cal(R)^2[-pi, pi]$; an integrable $f$ such as $abs(x)^(-1/2)$ has $|| f || = +oo$. This is why $|| dot ||$ is used only on $cal(R)^2[-pi, pi]$, and why the orthogonality statements below are stated there.
- $cal(R)^2[-pi, pi]$ is not complete for $|| dot ||$; its completion is $L^2[-pi, pi]$, whose theory belongs to the Analyse Réelle note.

In practice we shall mostly deal with piecewise continuous or piecewise smooth functions, which is the case most often met in applications.

=== Functions on the Unit Circle // 圆周上的函数

A periodic function $f(x): bb(R) -> bb(C)$ of period $2pi$ is best viewed through the complex exponential on the unit circle.
Let
$
  bb(T) = { z in bb(C) : abs(z) = 1 },
$
the one-dimensional torus, also known as the unit circle in the complex plane.

For any $theta in bb(R)$ we may set
$
  f(theta) = F(e^(i theta)),
$
where $F: bb(T) -> bb(C)$ is the corresponding *function defined on the unit circle*.
The periodic function $f(x)$ may thus be studied through $F(z)$ on $bb(T)$: the set of all such $F$ is a function space over the circle, _isomorphic_ to the space of $2pi$-periodic functions $f(x)$.

Working with $bb(T)$, a compact manifold without boundary, removes the inconvenience of endpoints and simplifies many arguments.
Moreover, since $bb(T)$ is a multiplicative group of complex numbers, it makes transparent the essence of Fourier series: the duality theory on compact Abelian groups.

== Fourier Coefficients // Fourier 系数
=== Fourier Coefficients of period $2pi$ // 2 pi 周期的傅里叶系数
#theorem(name: "Orthonormal System")[
  The family
  $
    cal(E) = { e^(i n x) : n in bb(Z) }
  $
  is orthonormal in $cal(R)^2[-pi, pi]$, i.e., $⟨ e^(i m x), e^(i n x) ⟩ = delta_(m n)$ for all $m, n in bb(Z)$.

  In real form,
  $
    { 1, cos x, sin x, cos 2 x, sin 2 x, dots }
  $
  is orthogonal though not orthonormal#footnote[
    Indeed
    $ ⟨ 1, 1 ⟩ = 1, quad ⟨ cos n x, cos n x ⟩ = ⟨ sin n x, sin n x ⟩ = (1) / (2), quad n in bb(N). $
    To make it orthonormal, each function should be normalized by the appropriate factor.
  ] in the same space.
] <thm:orthonormal-system>

Completeness of $cal(E)$ — the fact that it is a _basis_ and not merely an orthonormal system — is precisely the content of #link(<thm:parseval-identity>)[*Parseval's Identity*], and it holds for the square integrable space $cal(R)^2[-pi, pi]$.
For a merely integrable $f in cal(R)[-pi, pi]$ the expansion need not converge in norm, so no basis statement is available at this stage.

#definition(name: "Fourier Coefficients")[
  The *Fourier coefficients* of a function $f(x) in cal(R)[-pi, pi]$ are given by the Euler-Fourier formula
  $
    hat(f)(n) = ⟨ f, e^(i n x) ⟩ = (1) / (2pi) integral_(-pi)^(pi) f(x) e^(-i n x) dif x, quad n in bb(Z),
  $
  and the *Fourier series* of $f(x)$ is
  $
    f(x) ~ sum_(n=-oo)^(+oo) hat(f)(n) e^(i n x).
  $
  In real form it reads
  $
    f(x) ~ (a_0) / (2) + sum_(n=1)^(+oo) [ a_n cos(n x) + b_n sin(n x) ],
  $
  where
  $
    & a_0 = (1) / (pi) integral_(-pi)^(pi) f(x) dif x, \
    & a_n = (1) / (pi) integral_(-pi)^(pi) f(x) cos(n x) dif x, \
    & b_n = (1) / (pi) integral_(-pi)^(pi) f(x) sin(n x) dif x, quad n = 1, 2, dots.
  $
] <def:fourier-coefficients>

The symbol $~$ only records that the right-hand side is the Fourier series attached to $f$; it carries no claim of convergence.

The following algebraic rules are immediate from the linearity of the integral and from changes of variable, and will be used without further mention.

#property(name: "Elementary Properties of Fourier Coefficients")[
  Let $f, g in cal(R)[-pi, pi]$, $alpha, beta in bb(C)$ and $n in bb(Z)$. Then
  1. *Linearity.* $hat(alpha f + beta g)(n) = alpha hat(f)(n) + beta hat(g)(n)$.
  2. *Conjugation.* $hat(overline(f))(n) = overline(hat(f)(-n))$; in particular, if $f$ is real valued, then $hat(f)(-n) = overline(hat(f)(n))$.
  3. *Translation.* If $g(x) = f(x - a)$ with $a in bb(R)$, then $hat(g)(n) = e^(-i n a) hat(f)(n)$.
  4. *Modulation.* If $g(x) = e^(i k x) f(x)$ with $k in bb(Z)$, then $hat(g)(n) = hat(f)(n - k)$.
  5. *Boundedness.* $abs(hat(f)(n)) <= || f ||_1$, where $|| f ||_1 = (1) / (2pi) integral_(-pi)^(pi) abs(f(x)) dif x$.
] <prop:fourier-coefficient-rules>

In particular, a real and even $f$ has real coefficients, a real and odd $f$ has purely imaginary ones, and for real $f$ the identity $hat(f)(-n) = overline(hat(f)(n))$ is precisely what makes the coefficients $a_n, b_n$ of the real form real.

#note[
  Using Euler's formula,
  $
    cos n x = (e^(i n x) + e^(-i n x)) / (2), quad sin n x = (e^(i n x) - e^(-i n x)) / (2i),
  $
  the coefficients in the two forms are related by
  $
    hat(f)(0) = (a_0) / (2), quad hat(f)(n) = (a_n - i b_n) / (2), \
    hat(f)(-n) = (a_n + i b_n) / (2), quad n = 1, 2, dots,
  $
  and conversely
  $
    a_0 = 2hat(f)(0), quad a_n = hat(f)(n) + hat(f)(-n) = 2Re hat(f)(n), \
    b_n = i [ hat(f)(n) - hat(f)(-n) ] = -2Im hat(f)(n), quad n = 1, 2, dots.
  $
]

=== Fourier Coefficients of period $2T$ // 2T 周期的傅里叶系数
The construction rests on the same orthonormal system, rescaled to the interval $[-T, T]$.
On the space $cal(R)^2[-T, T]$ of $2T$-periodic square integrable functions, endowed with the normalized inner product
$
  ⟨ f, g ⟩ = (1) / (2T) integral_(-T)^(T) f(x) overline(g(x)) dif x,
$
the family
$
  cal(E)_T = { e^(i n (pi) / (T) x) : n in bb(Z) }
$
is orthonormal, i.e., $⟨ e^(i m (pi) / (T) x), e^(i n (pi) / (T) x) ⟩ = delta_(m n)$ for all $m, n in bb(Z)$.
In real form,
$
  { 1, cos((pi) / (T) x), sin((pi) / (T) x), cos(2 (pi) / (T) x), sin(2 (pi) / (T) x), dots }
$
is orthogonal though not orthonormal, with
$
  ⟨ 1, 1 ⟩ = 1, quad ⟨ cos(n (pi) / (T) x), cos(n (pi) / (T) x) ⟩ = ⟨ sin(n (pi) / (T) x), sin(n (pi) / (T) x) ⟩ = (1) / (2), quad n in bb(N).
$
The frequency is now $n (pi) / (T)$ rather than $n$; the value $T = pi$ recovers the $2pi$-periodic case, and the normalization $(1) / (2T)$ is what keeps $⟨ 1, 1 ⟩ = 1$.

The coefficients are again denoted $hat(f)(n)$, and the Euler-Fourier formula reads
$
  hat(f)(n) = (1) / (2T) integral_(-T)^(T) f(x) e^(-i n (pi) / (T) x) dif x, quad n in bb(Z),
$
so that
$
  f(x) ~ sum_(n=-oo)^(+oo) hat(f)(n) e^(i n (pi) / (T) x),
$
or in real form
$
  f(x) ~ (a_0) / (2) + sum_(n=1)^(+oo) [ a_n cos(n (pi) / (T) x) + b_n sin(n (pi) / (T) x) ],
$
where $a_0, a_n, b_n$ are given by the formulas above with $(1) / (pi)$ replaced by $(1) / (T)$ and $[-pi, pi]$ by $[-T, T]$.

When $f(x)$ is even, all sine terms vanish and the Fourier series reduces to a cosine series,
$
  f(x) ~ (a_0) / (2) + sum_(n=1)^(+oo) a_n cos(n x), quad a_n = (2) / (pi) integral_(0)^(pi) f(x) cos(n x) dif x.
$
When $f(x)$ is odd, all cosine terms vanish and it reduces to a sine series,
$
  f(x) ~ sum_(n=1)^(+oo) b_n sin(n x), quad b_n = (2) / (pi) integral_(0)^(pi) f(x) sin(n x) dif x.
$

== Dirichlet Kernel and Convolution // Dirichlet 核与卷积

=== The Dirichlet Kernel // Dirichlet 核

The partial sum of the first $N$ terms of the Fourier series of $f(x)$ is
$
  S_(N)(f; x) = sum_(n=-N)^(N) hat(f)(n) e^(i n x) = (a_0) / (2) + sum_(n=1)^(N) [ a_n cos(n x) + b_n sin(n x) ].
$
To study its convergence we transform it into integral form.
By the Euler-Fourier formula,
$
  S_(N)(f; x) & = sum_(n=-N)^(N) hat(f)(n) e^(i n x) \
              & = sum_(n=-N)^(N) ( (1) / (2pi) integral_(-pi)^(pi) f(t) e^(-i n t) dif t ) e^(i n x) \
              & = (1) / (2pi) integral_(-pi)^(pi) f(t) ( sum_(n=-N)^(N) e^(i n (x - t)) ) dif t \
              & = (1) / (2pi) integral_(-pi)^(pi) f(t) D_(N)(x - t) dif t,
$
where
$
  D_(N)(x) = sum_(n=-N)^(N) e^(i n x) = 1 + sum_(n=1)^(N) 2 cos(n x) = ( sin((2N + 1) x / 2) ) / ( sin(x / 2) )
$
is called the *Dirichlet kernel*.
At $x = 2 k pi$ the quotient is understood by continuity, and $D_(N)(2 k pi) = 2N + 1$.

The Dirichlet kernel possesses the following properties:

#property[
  1. *Evenness.*
    $ D_(N)(-x) = D_(N)(x). $

  2. *Normalization.*
    $ (1) / (2pi) integral_(-pi)^(pi) D_(N)(x) dif x = 1. $
]

#figure(
  image("img/dirichlet-kernels.svg", width: 60%),
  caption: [Dirichlet kernels for various values of $N$.],
  supplement: [Fig.],
) <fig:dirichlet-kernels>

The graphs of $D_(N)$ for several values of $N$ are displayed in @fig:dirichlet-kernels.

However, $D_(N)(x)$ oscillates like a wave, taking both positive and negative values.
During convolution (weighted averaging) the positive and negative contributions therefore almost cancel, which makes the result extremely unstable.
For instance, the integral mean of $abs(D_(N))$, called the *Lebesgue constant*, satisfies
$
  L_(N) := (1) / (2pi) integral_(-pi)^(pi) abs(D_(N)(x)) dif x approx (4) / (pi^2) ln N, quad N -> +oo.
$
It is precisely because this absolute integral tends to infinity that $D_(N)$ is a "bad kernel": it amplifies errors, so that _the Fourier series of a continuous function may diverge_.

With the help of the convolution theorem,
$
  S_(N)(f; x) & = (1) / (2pi) integral_(-pi)^(pi) f(t) D_(N)(x - t) dif t \
              & = (1) / (2pi) integral_(-pi-x)^(pi-x) f(x + u) D_(N)(-u) dif u, quad u = t - x, \
              & = (1) / (2pi) integral_(-pi)^(pi) f(x + u) D_(N)(u) dif u, \
              & = (1) / (2pi) integral_(0)^(pi) [ f(x + u) + f(x - u) ] D_(N)(u) dif u.
$
In the third step we used the $2pi$-periodicity of $u |-> f(x + u) D_(N)(u)$ to shift the interval of integration back to $[-pi, pi]$; in the last step we used the evenness $D_(N)(-u) = D_(N)(u)$ and the symmetry of the interval.
The convergence of $S_(N)(f; x)$ can thus be analyzed through the properties of the last integral, which is called the *Dirichlet integral*.

Since the Dirichlet kernel is normalized, we can analyze the difference between $S_(N)(f; x)$ and an arbitrary function $s(x)$:
$
  S_(N)(f; x) - s(x) = (1) / (2pi) integral_(0)^(pi) [ f(x + u) + f(x - u) - 2s(x) ] D_(N)(u) dif u.
$
Denoting $phi(u, x) = f(x + u) + f(x - u) - 2s(x)$, the convergence of $S_(N)(f; x)$ to $s(x)$ is equivalent to
$
  lim_(N -> +oo) integral_(0)^(pi) phi(u, x) D_(N)(u) dif u = 0.
$

=== Convolution // 卷积

#definition(name: "Convolution")[
  For two functions $f(x), g(x)$ on $bb(R)$ such that the integral below converges absolutely, the *convolution* $f * g$ is
  $
    (f * g)(x) = integral_(-oo)^(+oo) f(t) g(x - t) dif t.
  $

  In particular, for $2pi$-periodic functions, that is, functions on the circle $bb(T)$, the convolution is
  $
    (f * g)(x) = (1) / (2pi) integral_(-pi)^(pi) f(t) g(x - t) dif t,
  $
  where $(1) / (2pi)$ is a normalization factor.
] <def:convolution>

#note[
  From a physically intuitive perspective, convolution is a form of "weighted averaging" or "filtering".
  Here, $g(t)$ serves as the weight function (kernel),
  which samples and averages $f$ within a "sliding window" around the point $x$.
]

#note(title: "Discrete Convolution")[
  The same definition makes sense on discrete groups, where the integral is replaced by a sum and the normalization by a counting measure.

  On $bb(Z)$, for absolutely summable sequences $a, b in ell^1(bb(Z))$, the *convolution* is
  $
    (a * b)(n) = sum_(k in bb(Z)) a(k) b(n - k), quad n in bb(Z),
  $
  and $ell^1(bb(Z))$ is a Banach algebra for this product, with unit the sequence $delta_0$ (where $delta_0(0) = 1$ and $delta_0(n) = 0$ for $n != 0$).
  Writing
  $
    hat(a)(theta) = sum_(n in bb(Z)) a(n) e^(-i n theta), quad theta in bb(R),
  $
  the convolution theorem takes the same form as on the circle:
  $
    hat(a * b)(theta) = hat(a)(theta) dot hat(b)(theta).
  $

  On the finite cyclic group $bb(Z) slash N bb(Z)$, the discrete counterpart of the circle $bb(T)$, the sum has to be taken modulo $N$ and one uses the *cyclic convolution*
  $
    (a *_N b)(n) = sum_(k=0)^(N-1) a(k) b((n - k) mod N), quad n = 0, 1, dots, N - 1.
  $
  With the discrete Fourier transform $hat(a)(j) = sum_(n=0)^(N-1) a(n) e^(-2pi i j n \/ N)$, the same statement holds up to the conventional factor $N$, namely
  $
    hat(a *_N b)(j) = hat(a)(j) dot hat(b)(j).
  $

  Letting $N -> +oo$ recovers the case of $bb(Z)$, just as $T -> +oo$ turns the circle $bb(T)$ into the line $bb(R)$; the continuous, the discrete and the finite cases are three instances of one algebraic pattern, convolution on a group.
]

#property[
  1. *Commutativity.* $f * g = g * f$.

  2. *Associativity.* $f * (g * h) = (f * g) * h$.

  3. *Distributivity.* $f * (g + h) = f * g + f * h$.

  4. *Translation Invariance.* $(T_a f) * g = T_a (f * g)$, where $(T_a f)(x) = f(x - a)$.
]

With this notation the partial sum of the Fourier series becomes
$
  S_(N)(f; x) = (1) / (2pi) integral_(-pi)^(pi) f(t) D_(N)(x - t) dif t = (f * D_(N))(x).
$
This is a special case of the following general statement.

#theorem(name: "Convolution Theorem")[
  Let $f, g in cal(R)[-pi, pi]$. Then the Fourier coefficients of the convolution are the products of the Fourier coefficients:
  $
    hat(f * g)(n) = hat(f)(n) dot hat(g)(n), quad n in bb(Z).
  $
] <thm:convolution>

In other words, convolution in the time domain corresponds to multiplication in the frequency domain.

#proof(name: "of the Convolution Theorem")[
  By the definition of convolution and the Euler-Fourier formula,
  $
    hat(f * g)(n) = (1) / (2pi) integral_(-pi)^(pi) ( (1) / (2pi) integral_(-pi)^(pi) f(t) g(x - t) dif t ) e^(-i n x) dif x.
  $
  Both $f$ and $g$ are bounded, so Fubini's theorem applies to the double integral; the substitution $x = t + u$ together with the $2pi$-periodicity of $g$ gives
  $
    hat(f * g)(n) = (1) / (2pi) integral_(-pi)^(pi) f(t) e^(-i n t) ( (1) / (2pi) integral_(-pi)^(pi) g(u) e^(-i n u) dif u ) dif t = hat(f)(n) dot hat(g)(n).
  $
]

=== Localization Theorem // 局部化定理

First, we need the following important lemma:
#lemma(name: "Riemann–Lebesgue Lemma")[
  Let $f$ be Riemann integrable, or absolutely improperly Riemann integrable, on $[a, b]$, and let $g$ be $T$-periodic and Riemann integrable on $[0, T]$. Then
  $
    lim_(p -> +oo) integral_(a)^(b) f(x) g(p x) dif x = integral_(a)^(b) f(x) dif x dot (1) / (T) integral_(0)^(T) g(t) dif t.
  $
  In particular, for $g(x) = sin x$ and $g(x) = cos x$ one gets, respectively,
  $
    lim_(p -> +oo) integral_(a)^(b) f(x) sin(p x) dif x = 0, quad lim_(p -> +oo) integral_(a)^(b) f(x) cos(p x) dif x = 0.
  $
] <lem:riemann-lebesgue>

#proof(name: "of the special case $g(x) = sin x$")[
  The case $g(x) = cos x$ is identical.

  Suppose first that $f$ is properly Riemann integrable on $[a, b]$.
  Then $f$ is bounded, so there is $M > 0$ with $abs(f(x)) <= M$ for all $x in [a, b]$.
  Put $n = floor(sqrt(p))$; then $n -> +oo$ as $p -> +oo$.

  Divide $[a, b]$ into $n$ subintervals of equal length $Delta x_i = (b - a) / n$:
  $
    a = x_0 < x_1 < x_2 < dots.h < x_n = b,
  $
  and let $omega_i$ be the oscillation of $f$ on the $i$-th subinterval $[x_(i-1), x_i]$.

  By the theory of Riemann integration,
  $
    lim_(n -> oo) sum_(i=1)^(n) omega_i Delta x_i = 0.
  $
  Moreover,
  $
    abs(integral_(x_(i-1))^(x_i) sin(p x) dif x) <= (2) / (p), quad abs(sin(p x)) <= 1.
  $
  We then estimate
  $
    abs(integral_(a)^(b) f(x) sin(p x) dif x) & = abs(sum_(i=1)^(n) integral_(x_(i-1))^(x_i) f(x) sin(p x) dif x) \
                                              & <= abs(sum_(i=1)^(n) integral_(x_(i-1))^(x_i) ( f(x) - f(x_i) ) sin(p x) dif x)
                                                + abs(sum_(i=1)^(n) integral_(x_(i-1))^(x_i) f(x_i) sin(p x) dif x) \
                                              & <= sum_(i=1)^(n) omega_i Delta x_i
                                                + M sum_(i=1)^(n) abs(integral_(x_(i-1))^(x_i) sin(p x) dif x) \
                                              & <= sum_(i=1)^(n) omega_i Delta x_i + M dot n dot (2) / (p).
  $
  Since $n / p <= 1 / sqrt(p) -> 0$, both terms tend to zero, hence
  $lim_(p -> +oo) integral_(a)^(b) f(x) sin(p x) dif x = 0$.

  Suppose now that $f$ is not properly Riemann integrable but absolutely integrable in the improper Riemann sense on $[a, b]$.
  Without loss of generality the only singularity of $f$ is the endpoint $b$.
  Then
  $
    forall epsilon > 0, exists delta > 0, forall eta in (0, delta): quad integral_(b - eta)^(b) abs(f(x)) dif x < (epsilon) / (2).
  $
  Fix such $eta$; then $f$ is properly Riemann integrable on $[a, b - eta]$, so by the first part there is $P > 0$ such that, for $p > P$,
  $
    abs(integral_(a)^(b - eta) f(x) sin(p x) dif x) < (epsilon) / (2).
  $
  Consequently
  $
    abs(integral_(a)^(b) f(x) sin(p x) dif x) & <= abs(integral_(a)^(b - eta) f(x) sin(p x) dif x)
                                                + abs(integral_(b - eta)^(b) f(x) sin(p x) dif x) \
                                              & < (epsilon) / (2) + integral_(b - eta)^(b) abs(f(x)) dif x < epsilon.
  $
  This proves the special case in both situations.
]

Then we can state Riemann's Localization Theorem:
#theorem(name: "Riemann's Localization Theorem")[
  The convergence or divergence of the Fourier series of a function $f(x) in cal(R)[-pi, pi]$
  at a given point $x$ depends only on the behavior of $f(x)$ in
  an arbitrarily small neighborhood of $x$.
]
#proof[
  Extend $f$ periodically to $bb(R)$, so that $f(x plus.minus u)$ is defined for all $u in [0, pi]$.
  For any $delta > 0$, the function $u |-> (f(x + u) + f(x - u)) / (sin(u / 2))$ is Riemann integrable on $[delta, pi]$, because $sin(u / 2) >= sin(delta / 2) > 0$ there.

  Since $(sin((N + (1) / (2)) u)) / (sin(u / (2))) = (1) / (sin(u / (2))) sin(p u)$ with $p = N + (1) / (2) -> +oo$, the #link(<lem:riemann-lebesgue>)[*Riemann–Lebesgue Lemma*] gives
  $
    lim_(N -> oo) integral_(delta)^(pi) (f(x + u) + f(x - u)) / (sin(u / (2))) sin((N + (1) / (2)) u) dif u = 0.
  $
  Splitting the integral defining $S_(N)(f; x)$ at $delta$ therefore yields
  $
    S_(N)(f; x) = (1) / (2pi) integral_(0)^(delta) [ f(x + u) + f(x - u) ] D_(N)(u) dif u
    + (1) / (2pi) integral_(delta)^(pi) (f(x + u) + f(x - u)) / (sin(u / (2))) sin((N + (1) / (2)) u) dif u.
  $
  As $N -> +oo$ the second term tends to zero, so the convergence of $S_(N)(f; x)$ depends only on the first term:
  $
    lim_(N -> +oo) S_(N)(f; x) = lim_(N -> +oo) (1) / (2pi) integral_(0)^(delta) [ f(x + u) + f(x - u) ] D_(N)(u) dif u.
  $
]

Since the oscillation of $D_(N)(x)$ is so violent that it causes poor convergence, one may ask whether it can be "smoothed out".
It can: *Cesàro summation* together with the *Fejér kernel* does exactly that, and this is the subject of *Cesàro Summation and Square Mean Convergence*.

== Pointwise Convergence Tests // 逐点收敛判别法
In this section we discuss several convergence tests for Fourier series, from the coarsest to the finest.

#definition(name: "Hölder Condition")[
  A function $f$ satisfies the *Hölder condition of order* $alpha in (0, 1]$ at a point $x$ if there exist constants $L > 0$ and $delta > 0$ such that
  $
    abs(f(x plus.minus u) - f(x)) <= L u^alpha, quad 0 < u < delta.
  $
  This is denoted $f in "Lip"_(alpha)(x)$; for $alpha = 1$ it is called the *Lipschitz condition*.
] <def:holder-condition>

#lemma(name: "Dirichlet's Lemma")[
  Let $f$ be monotonic on $[0, delta]$. Then
  $
    lim_(p -> +oo) integral_(0)^(delta) (f(u) - f(0^+)) / (u) sin(p u) dif u = 0.
  $
] <lem:dirichlet>
#proof[
  Without loss of generality assume that $f$ is increasing on $[0, delta]$.
  For every $epsilon > 0$ there is $eta in (0, delta)$ such that
  $
    0 <= f(u) - f(0^+) < epsilon, quad u in (0, eta].
  $
  Split the integral into two parts:
  $
    integral_(0)^(delta) (f(u) - f(0^+)) / (u) sin(p u) dif u
    & = integral_(0)^(eta) (f(u) - f(0^+)) / (u) sin(p u) dif u \
    & + integral_(eta)^(delta) (f(u) - f(0^+)) / (u) sin(p u) dif u.
  $

  For the first term, the second mean value theorem for integrals, applied to the monotone factor $f(u) - f(0^+)$, provides $xi in [0, eta]$ with
  $
    abs(integral_(0)^(eta) (f(u) - f(0^+)) / (u) sin(p u) dif u)
    & = [f(eta) - f(0^+)] abs(integral_(xi)^(eta) (sin(p u)) / (u) dif u) \
    & <= epsilon abs(integral_(xi)^(eta) (sin(p u)) / (u) dif u) \
    & = epsilon abs(integral_(p xi)^(p eta) (sin v) / (v) dif v).
  $
  Since the Dirichlet integral converges,
  $
    integral_(0)^(+oo) (sin v) / (v) dif v = (pi) / (2),
  $
  its partial integrals are bounded: there is $M > 0$ with
  $
    abs(integral_(p xi)^(p eta) (sin v) / (v) dif v) < M
  $
  for all $0 <= p xi <= p eta$, whence
  $
    abs(integral_(0)^(eta) (f(u) - f(0^+)) / (u) sin(p u) dif u) < M epsilon.
  $

  For the second term, $u |-> (f(u) - f(0^+)) / u$ is Riemann integrable on $[eta, delta]$, so the #link(<lem:riemann-lebesgue>)[*Riemann–Lebesgue Lemma*] gives $P > 0$ such that, for $p > P$,
  $
    abs(integral_(eta)^(delta) (f(u) - f(0^+)) / (u) sin(p u) dif u) < epsilon.
  $

  In summary the limit vanishes, as claimed.
]

#note[
  - For monotonic $f$ there is an equivalent form:
    $
      lim_(p -> +oo) integral_(0)^(delta) f(u) (sin(p u)) / (u) dif u = (pi) / (2) f(0^+).
    $
  - Dirichlet's lemma remains valid when $f$ is only piecewise monotonic on $[0, delta]$, provided $f(0^+)$ exists.
]

#theorem(name: "Pointwise Convergence Tests")[
  Let $f(x) in cal(R)[-pi, pi]$. If one of the following conditions holds at a point $x$, then the Fourier series of $f$ converges at $x$ to $(f(x^+) + f(x^-)) / (2)$.

  1. *Lipschitz's Test.* $f in "Lip"_(alpha)(x)$ for some $alpha in (0, 1]$.
  2. *Dini's Test.* There exists $delta > 0$ such that
    $
      integral_(0)^(delta) (abs(f(x + u) + f(x - u) - 2 S)) / (u) dif u < +oo,
    $
    where $S = (f(x^+) + f(x^-)) / (2)$.
  3. *Dirichlet-Jordan Test.* $f$ is of bounded variation on some neighbourhood of $x$, i.e., $f in "BV"(x - delta, x + delta)$ for some $delta > 0$.
] <thm:pointwise-tests>

The Lipschitz condition is rarely verifiable directly; a handy sufficient condition is that the two one-sided derivatives of $f$ at $x$ exist finitely:
$
  lim_(h -> 0^+) (f(x + h) - f(x^+)) / (h), quad lim_(h -> 0^+) (f(x - h) - f(x^-)) / (h).
$
For the definition and basic properties of functions of bounded variation see *Functions of Bounded Variation and Absolute Continuity* in the Analyse Réelle note.

#note(title: "On the proofs")[
  Each of the three tests is obtained by combining *Riemann's Localization Theorem* with Dirichlet's Lemma applied to the monotone pieces (Jordan decomposition, in the third case); we omit the routine details since they are not used later.
]


#example(name: "Sawtooth wave")[
  Let $f(x)$ be the $2pi$-periodic function defined on $[-pi, pi]$ by
  $
    f(x) = cases(
      x quad & x in [-pi, pi),
      -pi quad & x = pi,
    )
  $
  Find its Fourier series, and deduce the value of $1 - (1) / (3) + (1) / (5) - (1) / (7) + dots.h$.
] <ex:sawtooth>

#solution(name: "sawtooth wave")[
  By the Euler-Fourier formula,
  $
    a_0 & = (1) / (pi) integral_(-pi)^(pi) f(x) dif x = 0, \
    a_n & = (1) / (pi) integral_(-pi)^(pi) f(x) cos(n x) dif x = (1) / (pi) [ x dot (sin(n x)) / (n) |_(-pi)^(pi) - integral_(-pi)^(pi) (sin(n x)) / (n) dif x ] = 0, \
    b_n & = (1) / (pi) integral_(-pi)^(pi) f(x) sin(n x) dif x = (1) / (pi) [ -x dot (cos(n x)) / (n) |_(-pi)^(pi) + integral_(-pi)^(pi) (cos(n x)) / (n) dif x ] = (2 (-1)^(n+1)) / (n).
  $
  Hence the Fourier series of $f(x)$ is
  $
    f(x) ~ sum_(n=1)^(+oo) (-1)^(n+1) (2) / (n) sin(n x).
  $
  Since $f in "BV"[-pi, pi]$, the Dirichlet-Jordan test shows that this series converges to $f(x)$ at every point of continuity and to $(f(x^+) + f(x^-)) / 2$ at every point of discontinuity.
  In particular,
  $
    f(x) = sum_(n=1)^(+oo) (-1)^(n+1) (2) / (n) sin(n x), quad x in (-pi, pi),
  $
  while the periodic extension $tilde(f)$ of $f$ satisfies
  $
    tilde(f)(x) = cases(
      f(x) quad & x in (2 k pi - pi, 2 k pi + pi),
      0 quad & x = 2 k pi + pi,
    ) = sum_(n=1)^(+oo) (-1)^(n+1) (2) / (n) sin(n x), quad k in bb(Z).
  $

  Taking $x = (pi) / (2)$ gives
  $
    (pi) / (2) = sum_(n=1)^(+oo) (-1)^(n+1) (2) / (n) sin(n (pi) / (2)),
  $
  that is,
  $
    (pi) / (4) = sum_(n=1)^(+oo) (-1)^(n+1) (1) / (n) sin(n (pi) / (2)) = sum_(n=0)^(+oo) (1) / (2 n + 1) sin((2 n + 1) (pi) / (2)).
  $
  Since $sin((2 n + 1) (pi) / (2)) = (-1)^n$, we obtain
  $
    1 - (1) / (3) + (1) / (5) - (1) / (7) + dots.h = (pi) / (4).
  $
]


=== Gibbs Phenomenon // Gibbs 现象

When a function $f(x)$ has jump discontinuities, its Fourier series converges to the midpoint of the jump at the discontinuity.
Near the jump, however, the partial sums oscillate, overshooting and undershooting the actual values of the function.
This is the *Gibbs phenomenon*.

For example, consider the $2pi$-periodic square wave
$
  f(x) = cases(
    -1 quad & x in [-pi, 0),
    1 quad & x in (0, pi],
  )
$
whose Fourier series is
$
  f(x) ~ (4) / (pi) sum_(n=0)^(+oo) (sin((2 n + 1) x)) / (2 n + 1).
$
Since $f in "BV"$, the Dirichlet-Jordan test shows that the series converges to
$
  cases(
    f(x) quad & x " is a point of continuity",
    (f(x^+) + f(x^-)) / (2) quad & x " is a point of discontinuity".
  )
$
As regards the partial sums $S_(N)(f; x)$, they overshoot near the jump points (@fig:gibbs).
Adding more sine terms only pushes the oscillation towards the jump: the maximal overshoot converges to a limit of approximately $9 percent$ of the jump height, even though the infinite Fourier series converges everywhere.
#figure(
  image("img/gibbs.svg", width: 55%),
  caption: [Gibbs phenomenon of square wave near a jump discontinuity.],
  supplement: [Fig.],
) <fig:gibbs>

This behaviour matters in signal processing, where it produces high-frequency ringing.

== Properties of Fourier Series // Fourier 级数的性质
By the #link(<lem:riemann-lebesgue>)[*Riemann–Lebesgue Lemma*] we obtain at once a first property of the Fourier coefficients:
#proposition[
  Let $f(x) in cal(R)[-pi, pi]$. Then
  $
    lim_(abs(n) -> +oo) hat(f)(n) = 0,
  $
  or, in real form,
  $
    lim_(n -> +oo) a_n = 0, quad lim_(n -> +oo) b_n = 0.
  $
] <prop:riemann-lebesgue-coefficients>

We record one more structural property, useful whenever convergence of the series itself is not available.
#theorem(name: "Uniqueness Theorem")[
  If $f(x), g(x) in cal(R)[-pi, pi]$ have the same Fourier coefficients, i.e., $hat(f)(n) = hat(g)(n)$ for all $n in bb(Z)$, then $f(x) = g(x)$ almost everywhere on $[-pi, pi]$.
] <thm:uniqueness>

#note(title: "Proof")[
  Deferred to the Cesàro theory: a Riemann integrable function is continuous almost everywhere, so by the generalized #link(<thm:fejer>)[*Fejér Theorem*] its Cesàro means converge to $f$ almost everywhere.
  If all Fourier coefficients of $f$ vanish, then every Cesàro mean vanishes identically, hence $f = 0$ almost everywhere.
]

=== Analytical Properties // 解析性质

#theorem(name: "Termwise Integration")[
  If $f(x) in cal(R)[-pi, pi]$ has Fourier series
  $
    f(x) ~ (a_0) / (2) + sum_(n=1)^(+oo) [ a_n cos(n x) + b_n sin(n x) ],
  $
  then
  $
    integral_(c)^(x) f(t) dif t = integral_(c)^(x) (a_0) / (2) dif t + sum_(n=1)^(+oo) integral_(c)^(x) [ a_n cos(n t) + b_n sin(n t) ] dif t, quad c, x in [-pi, pi],
  $
  the series on the right being uniformly convergent on $[-pi, pi]$.
] <thm:termwise-integration>

#note(title: "Why the symbol becomes an equality")[
  After termwise integration the series converges uniformly, so the relation $~$ may be upgraded to $=$.
  Integration smooths the function: the coefficients acquire a factor $1 / n$, which improves the decay and hence the convergence.
]

#proof(name: "of Termwise Integration")[
  Fix $c in [-pi, pi]$ and put
  $
    F(x) = integral_(c)^(x) f(t) dif t, quad H(x) = F(x) - (a_0) / (2) (x - c).
  $
  Since $f$ is Riemann integrable, it is bounded, so $F$ is Lipschitz and therefore of bounded variation on $[-pi, pi]$; the same holds for $H$.
  Because $H' = f - a_0 / 2$ almost everywhere and
  $
    H(pi) - H(-pi) = integral_(-pi)^(pi) (f(t) - (a_0) / (2)) dif t = pi a_0 - pi a_0 = 0,
  $
  $H$ is a continuous function on the circle, and by the Dirichlet-Jordan test its Fourier series converges uniformly to $H$.
  Integration by parts on $[-pi, pi]$ then gives, for $n != 0$,
  $
    hat(H)(n) = (1) / (i n) hat(H')(n) = (1) / (i n) hat(f)(n),
  $
  since the constant $a_0 / 2$ has vanishing Fourier coefficients for $n != 0$.
  In real form this reads
  $
    H(x) = hat(H)(0) + sum_(n=1)^(+oo) [ (a_n) / (n) sin(n x) - (b_n) / (n) cos(n x) ].
  $
  On the other hand,
  $
    integral_(c)^(x) [ a_n cos(n t) + b_n sin(n t) ] dif t = (a_n) / (n) sin(n x) - (b_n) / (n) cos(n x) + C_n, quad C_n = -(a_n sin(n c) - b_n cos(n c)) / (n),
  $
  so
  $
    F(x) = integral_(c)^(x) (a_0) / (2) dif t + sum_(n=1)^(+oo) integral_(c)^(x) [ a_n cos(n t) + b_n sin(n t) ] dif t + K,
  $
  where $K$ does not depend on $x$.
  Evaluating at $x = c$ gives $0 = 0 + 0 + K$, so $K = 0$, which is the claimed identity.
]

#theorem(name: "Termwise Differentiation")[
  Let $f$ be continuous on $[-pi, pi]$, $2pi$-periodic and piecewise $C^1$, with Fourier series
  $
    f(x) ~ (a_0) / (2) + sum_(n=1)^(+oo) [ a_n cos(n x) + b_n sin(n x) ].
  $
  Then, at every point where $f'$ is continuous,
  $
    f'(x) = sum_(n=1)^(+oo) [ -n a_n sin(n x) + n b_n cos(n x) ].
  $
] <thm:termwise-differentiation>

#note(title: "Why continuity of $f$ is needed")[
  Continuity of $f$ is what makes the boundary terms of the integration by parts disappear, giving $hat(f')(n) = i n hat(f)(n)$.
  For a function with a jump these boundary terms survive, and the differentiated series no longer represents $f'$.
]

=== Smoothness and Decay Rate // 光滑性与衰减速度

The smoother a function is, the more rapidly its Fourier coefficients decay; the rougher it is, the more high-frequency components it carries.

#tex-table(
  ([Smoothness of $f$], [Decay of $hat(f)(n)$]),
  ([$f in cal(R)[-pi, pi]$], [$hat(f)(n) -> 0$ (slowest)]),
  ([piecewise $C^1$ with jumps], [$O(1 / n)$]),
  ([continuous and piecewise $C^1$], [$O(1 / n^2)$]),
  ([piecewise $C^k$, $f, dots, f^((k-1))$ continuous], [$O(1 / n^(k+1))$]),
  ([real analytic], [$O(e^(-c abs(n)))$ for some $c > 0$]),
)

= Cesàro Summation, Square Mean Convergence and Applications // Cesàro 求和、平方平均收敛及其应用
Throughout this chapter $cal(R)[-pi, pi]$ and $cal(R)^2[-pi, pi]$ denote the spaces of #link(<def:function-spaces>)[*Riemann Integrable Functions on the Circle*], equipped with the normalized inner product and norm introduced there, and $cal(R)^2[-pi, pi] subset.eq cal(R)[-pi, pi]$.

== Cesàro Summation and Fejér Kernel // Cesàro 求和与 Fejér 核
Up to now, the convergence of a series $sum_(n=1)^(oo) a_n$ has always meant the convergence of its partial sums $S_(N) = sum_(n=1)^(N) a_n$ as $N -> oo$, the definition put forward by Cauchy in 1821.
There are other ways of attaching a sum to a series; the following one is due to Cesàro and assigns sums to some divergent series#footnote[
  By Cauchy's proposition (see *Convergent Sequences* in the Analyse Mathématique note), if $lim_(n -> oo) x_n = l$, then $lim_(n -> oo) (x_1 + x_2 + dots.h + x_n) / (n) = l$.
  In other words, the Cesàro sum of a convergent series equals its Cauchy sum.
].

#definition(name: "Cesàro Summation")[
  Let $S_(k) = sum_(n=1)^(k) a_n$ be the partial sums of a series $sum_(n=1)^(oo) a_n$, with $S_(0) = 0$.
  The series is *Cesàro summable* to $S$ if the arithmetic means
  $
    sigma_(N) = (S_(0) + S_(1) + dots.h + S_(N-1)) / (N), quad N >= 1,
  $
  converge to $S$ as $N -> +oo$.
] <def:cesaro-summation>

Since
$
  S_(k)(f; x) = (1) / (2pi) integral_(-pi)^(pi) f(x - t) D_(k)(t) dif t,
$
the Cesàro means of the Fourier series are
$
  sigma_(N)(f; x) & = (1) / (N) sum_(k=0)^(N-1) S_(k)(f; x) \
                  & = (1) / (N) sum_(k=0)^(N-1) (1) / (2pi) integral_(-pi)^(pi) f(x - t) D_(k)(t) dif t \
                  & = (1) / (2pi) integral_(-pi)^(pi) f(x - t) ( (1) / (N) sum_(k=0)^(N-1) D_(k)(t) ) dif t \
                  & = (1) / (2pi) integral_(-pi)^(pi) f(x - t) F_(N)(t) dif t,
$
where
$
  F_(N)(t) = (1) / (N) sum_(k=0)^(N-1) D_(k)(t) = (1) / (N) ( (sin(N t / 2)) / (sin(t / 2)) )^2
$
is called the *Fejér kernel*.
At $t = 2 k pi$ its value is again understood by continuity, and $F_(N)(0) = N$.

#figure(
  image("img/fejer-kernels.svg", width: 60%),
  caption: [Fejér kernels $F_(N)(t)$ for $N = 2, 4, 6, 8, 10$.],
  supplement: [Fig.],
) <fig:fejer-kernels>

The graphs of $F_(N)$ for several values of $N$ are displayed in @fig:fejer-kernels.

The Fejér kernel has the following excellent properties:
#property[
  1. *Positivity.* $F_(N)(t) >= 0$ for every integer $N >= 1$ and every real $t$.
    This is what distinguishes it sharply from the Dirichlet kernel.

  2. *Normalization.* For every $N >= 1$,
    $
      (1) / (2pi) integral_(-pi)^(pi) F_(N)(t) dif t = 1.
    $

  3. *Concentration.* For every $delta in (0, pi)$,
    $
      lim_(N -> oo) integral_(delta)^(pi) F_(N)(t) dif t = 0,
    $
    and in fact $F_(N)(t) <= 1 / (N sin^2(t / 2))$ for $t in [delta, pi]$.

  4. *Bounded $L^1$ norm.* Since $F_(N) >= 0$,
    $
      (1) / (2pi) integral_(-pi)^(pi) abs(F_(N)(t)) dif t = 1,
    $
    in contrast with the Dirichlet kernel, whose $L^1$ norm grows logarithmically:
    $
      (1) / (2pi) integral_(-pi)^(pi) abs(D_(N)(t)) dif t ~ (4) / (pi^2) ln N.
    $
] <prop:fejer-properties>

#tex-table(
  ("Property", [Dirichlet kernel $D_(N)$], [Fejér kernel $F_(N)$]),
  ("Corresponding operation", [Partial sum $S_(N)$ (truncation)], [Cesàro mean $sigma_(N)$ (averaging)]),
  (
    "Formula",
    [$(sin((N + (1) / (2)) x)) / (sin(x / 2))$ (first order)],
    [$(1) / (N) ( (sin(N x / 2)) / (sin(x / 2)) )^2$ (square)],
  ),
  ("Positivity", [Violent oscillations (positive and negative)], [Non-negative everywhere ($>= 0$)]),
  ([$L^1$ norm], [$ln N -> oo$ (divergent)], [$= 1$ (bounded)]),
  ([$f in C$], "May diverge", "Uniform convergence"),
  ("Role", "Projection operator", "Approximation operator"),
)

With such a "good kernel" we can prove the following theorem.
#theorem(name: "Fejér Theorem")[
  If $f(x)$ is continuous on $bb(T)$, then its Cesàro means $sigma_(N)(f; x)$ converge uniformly to $f(x)$ on $bb(T)$:
  $
    lim_(N -> oo) sup_(x in bb(T)) abs(sigma_(N)(f; x) - f(x)) = 0.
  $

  More generally, if $f(x) in cal(R)[-pi, pi]$ has left and right limits at a point $x_0 in [-pi, pi]$, then
  $
    lim_(N -> oo) sigma_(N)(f; x_0) = (f(x_0^+) + f(x_0^-)) / (2).
  $
] <thm:fejer>

#proof(name: "of Fejér Theorem, continuous case")[
  Let $M = sup_(x in bb(T)) abs(f(x)) < +oo$ and let $epsilon > 0$.
  By uniform continuity of $f$ on $bb(T)$ there is $delta in (0, pi)$ such that $abs(f(x - t) - f(x)) < epsilon$ whenever $abs(t) < delta$.
  Using the normalization of $F_(N)$,
  $
    sigma_(N)(f; x) - f(x) = (1) / (2pi) integral_(-pi)^(pi) (f(x - t) - f(x)) F_(N)(t) dif t.
  $
  Splitting the integral and using positivity,
  $
    abs(sigma_(N)(f; x) - f(x)) <= epsilon + (2M) / (2pi) dot 2 integral_(delta)^(pi) F_(N)(t) dif t.
  $
  By the concentration property and the bound $F_(N)(t) <= 1 / (N sin^2(delta / 2))$ for $t in [delta, pi]$, the second term is at most
  $
    (2 M) / (sin^2(delta / 2)) dot (1) / (N) -> 0, quad N -> oo,
  $
  uniformly in $x$.
  Hence $abs(sigma_(N)(f; x) - f(x)) <= 2 epsilon$ for all $x$ and all $N$ large enough, which is uniform convergence.

  The general statement for $f in cal(R)[-pi, pi]$ follows from the same three properties applied to the one-sided intervals around $x_0$; the details are routine.
]

#note[
  As soon as $f$ is integrable, or absolutely integrable, and has left and right limits at $x_0$, its Fourier series is Cesàro summable at $x_0$.
  Compared with the tests collected in *Pointwise Convergence Tests*, this statement asks for almost nothing.
]

With Fejér's theorem at hand, the trigonometric polynomials are dense in the space $C(bb(T))$ of continuous functions on the circle, and the Weierstrass approximation theorem#footnote[
  The Weierstrass approximation theorem states that every continuous function on a closed interval can be uniformly approximated by polynomials to any prescribed accuracy.
  See *Smooth Approximation of Functions* in the Analyse Mathématique note for details.
]
follows easily.

== Square Approximation and Parseval's Identity // 平方逼近与 Parseval 恒等式

=== Best Approximation in the Square Mean // 平方平均意义下的最佳逼近

#theorem(name: "Square Approximation Property of Fourier Series")[
  Let $f(x) in cal(R)^2[-pi, pi]$ and let $W_(N) = op("span"){ e^(i n x) : abs(n) <= N }$.
  Then the best approximation of $f$ in $W_(N)$ with respect to the norm $|| dot ||$ is the Fourier partial sum
  $
    S_(N)(f; x) = sum_(n=-N)^(N) hat(f)(n) e^(i n x) = (a_0) / (2) + sum_(n=1)^(N) [ a_n cos(n x) + b_n sin(n x) ],
  $
  and the remainder $E_(N)(f) = f - S_(N)(f)$ satisfies#footnote[
    See *Orthogonal Completion and Orthogonal Projection* in the Algèbre Linéaire note.
  ]
  $
    || E_(N)(f) ||^2 = || f ||^2 - sum_(n=-N)^(N) abs(hat(f)(n))^2.
  $
] <thm:square-approximation>

In terms of the real coefficients the same identity reads
$
  || E_(N)(f) ||^2 = (1) / (2) [ (1) / (pi) integral_(-pi)^(pi) abs(f(x))^2 dif x - ( (a_0^2) / (2) + sum_(n=1)^(N) (a_n^2 + b_n^2) ) ],
$
the factor $1 / 2$ being the one relating the normalized inner product to $integral_(-pi)^(pi) dot dif x$.

#theorem(name: "Bessel's Inequality")[
  Let $f(x) in cal(R)^2[-pi, pi]$ with Fourier coefficients $hat(f)(n)$. Then, for every integer $N >= 0$,
  $
    sum_(n=-N)^(N) abs(hat(f)(n))^2 <= || f ||^2,
  $
  or, in real form,
  $
    (a_0^2) / (2) + sum_(n=1)^(N) (a_n^2 + b_n^2) <= (1) / (pi) integral_(-pi)^(pi) abs(f(x))^2 dif x.
  $
] <thm:bessel>

#theorem(name: "Parseval's Identity")[
  Let $f(x) in cal(R)^2[-pi, pi]$ with Fourier coefficients $hat(f)(n)$. Then
  $
    sum_(n=-oo)^(+oo) abs(hat(f)(n))^2 = || f ||^2,
  $
  or, in real form,
  $
    (a_0^2) / (2) + sum_(n=1)^(+oo) (a_n^2 + b_n^2) = (1) / (pi) integral_(-pi)^(pi) abs(f(x))^2 dif x.
  $

  The polarized form reads, for $f, g in cal(R)^2[-pi, pi]$,
  $
    sum_(n=-oo)^(+oo) hat(f)(n) overline(hat(g)(n)) = ⟨ f, g ⟩,
  $
  or, in real form,
  $
    (a_0 c_0) / (2) + sum_(n=1)^(+oo) (a_n c_n + b_n d_n) = (1) / (pi) integral_(-pi)^(pi) f(x) overline(g(x)) dif x,
  $
  where $g(x) in cal(R)^2[-pi, pi]$ has real coefficients $c_0, c_n, d_n$.
] <thm:parseval-identity>

#proof(name: "of Parseval's Identity")[
  By #link(<thm:square-approximation>)[*Square Approximation Property of Fourier Series*],
  $
    || E_(N)(f) ||^2 = || f ||^2 - sum_(n=-N)^(N) abs(hat(f)(n))^2 >= 0,
  $
  so the partial sums of $sum abs(hat(f)(n))^2$ are bounded; the series therefore converges and
  $
    sum_(n=-oo)^(+oo) abs(hat(f)(n))^2 <= || f ||^2.
  $

  It remains to prove equality.
  Let $epsilon > 0$. Since continuous functions are dense in $L^2[-pi, pi]$ and trigonometric polynomials are dense in $C(bb(T))$ by #link(<thm:fejer>)[*Fejér Theorem*], there is a trigonometric polynomial $P = sum_(abs(n) <= M) c_(n) e^(i n x)$ with $|| f - P || < epsilon$.
  As $P in W_(M)$ and $S_(M)(f)$ is the best approximation in $W_(M)$,
  $
    || E_(M)(f) || <= || f - P || < epsilon.
  $
  Since $|| E_(N)(f) ||$ is non-increasing in $N$ and every level $N$ is dominated by some such $M$, we get $|| E_(N)(f) || -> 0$ as $N -> +oo$, i.e.,
  $
    lim_(N -> +oo) sum_(abs(n) <= N) abs(hat(f)(n))^2 = || f ||^2.
  $
]

== Classical Inequalities // 经典不等式

=== Wirtinger Inequality // Wirtinger 不等式

#theorem(name: "Wirtinger Inequality")[
  Let $f in C^1[-pi, pi]$ be real-valued and satisfy
  $
    integral_(-pi)^(pi) f(x) dif x = 0, quad f(-pi) = f(pi).
  $
  Then
  $
    integral_(-pi)^(pi) f^2(x) dif x <= integral_(-pi)^(pi) (f'(x))^2 dif x,
  $
  with equality if and only if $f(x) = A cos x + B sin x$ for some constants $A, B in bb(R)$.
] <thm:wirtinger>

#proof(name: "of Wirtinger Inequality")[
  Since $f in C^1$ is continuous and of bounded variation, #link(<thm:parseval-identity>)[*Parseval's Identity*] applies to both $f$ and $f'$.
  As $f$ is continuous and periodic, integration by parts gives $hat(f')(n) = i n hat(f)(n)$ for every $n$, and $hat(f)(0) = (1) / (2pi) integral_(-pi)^(pi) f = 0$.
  Hence
  $
    integral_(-pi)^(pi) (f'(x))^2 dif x = 2pi sum_(n in bb(Z)) abs(hat(f')(n))^2 = 2pi sum_(n != 0) n^2 abs(hat(f)(n))^2 >= 2pi sum_(n != 0) abs(hat(f)(n))^2 = integral_(-pi)^(pi) f^2(x) dif x.
  $
  Equality holds exactly when $hat(f)(n) = 0$ for $abs(n) >= 2$, that is, when $f(x) = A cos x + B sin x$.
]

=== Poincaré Inequality // Poincaré 不等式

#theorem(name: "Poincaré Inequality")[
  Let $f in C^1[a, b]$ be real-valued with
  $
    integral_(a)^(b) f(x) dif x = 0.
  $
  Then
  $
    integral_(a)^(b) f^2(x) dif x <= ((b - a)^2) / (pi^2) integral_(a)^(b) (f'(x))^2 dif x,
  $
  and the constant is optimal.
] <thm:poincare>

#note(title: "Comparison with Wirtinger")[
  No periodicity is assumed here, and the constant $4$ obtained for $[a, b] = [-pi, pi]$ is weaker than the constant $1$ of #link(<thm:wirtinger>)[*Wirtinger Inequality*].
  The difference comes precisely from the boundary condition $f(-pi) = f(pi)$, which rules out the extremal function $sin(x / 2)$.
]

#note(title: "Proof")[
  Deferred to *Poincaré and Friedrichs Inequalities* in the Sobolev spaces part, where the constant is obtained from the first eigenvalue of $-d^2 / d x^2$ with Neumann boundary conditions.
]

=== Friedrichs Inequality // Friedrichs 不等式

#theorem(name: "Friedrichs Inequality")[
  Let $f in C^1[a, b]$ be real-valued with $f(a) = 0$. Then
  $
    integral_(a)^(b) f^2(x) dif x <= (4 (b - a)^2) / (pi^2) integral_(a)^(b) (f'(x))^2 dif x,
  $
  and the constant is optimal.
] <thm:friedrichs>

#note(title: "Proof")[
  Deferred to *Poincaré and Friedrichs Inequalities* in the Sobolev spaces part.
  The inequality is the counterpart of Poincaré's for functions vanishing on part of the boundary, and it holds more generally when $f$ vanishes on a subset of $[a, b]$ of positive measure.
]

== Square Mean Convergence // 平方平均收敛

#definition(name: "Square Mean Convergence")[
  A sequence $f_(n)(x)$ converges to $f(x)$ in the *square mean* (or $L^2$) sense on $[a, b]$ if
  $
    lim_(n -> oo) integral_(a)^(b) abs(f_(n)(x) - f(x))^2 dif x = 0.
  $
  With the normalization of the first chapter, this is the same as $lim_(n -> oo) || f_(n) - f || = 0$ on $[-pi, pi]$.
] <def:square-mean-convergence>

#theorem(name: "Square Mean Convergence of Fourier Series")[
  If $f(x) in cal(R)^2[-pi, pi]$, then its Fourier series converges to $f(x)$ in the square mean sense on $[-pi, pi]$:
  $
    lim_(N -> oo) integral_(-pi)^(pi) abs(f(x) - S_(N)(f; x))^2 dif x = 0.
  $
] <thm:square-mean>

#proof(name: "of Square Mean Convergence")[
  By #link(<thm:parseval-identity>)[*Parseval's Identity*] the partial sums of $sum abs(hat(f)(n))^2$ tend to $|| f ||^2$, so by #link(<thm:square-approximation>)[*Square Approximation Property of Fourier Series*]
  $
    || E_(N)(f) ||^2 = || f ||^2 - sum_(abs(n) <= N) abs(hat(f)(n))^2 -> 0, quad N -> oo.
  $
  Since $integral_(-pi)^(pi) abs(f(x) - S_(N)(f; x))^2 dif x = 2pi || E_(N)(f) ||^2$, the claim follows.
]

=== Sums of Special Series // 特殊级数求和

#example(name: "Sums computed by Parseval's identity")[
  Using #link(<thm:parseval-identity>)[*Parseval's Identity*] and suitable Fourier series, compute
  1. $sum_(n=1)^(oo) (1) / (n^2) = (pi^2) / (6)$;
  2. $sum_(n=1)^(oo) (1) / ((2 n - 1)^2) = (pi^2) / (8)$;
  3. $sum_(n=1)^(oo) ((-1)^(n+1)) / (n^2) = (pi^2) / (12)$;
  4. $sum_(n=1)^(oo) ((-1)^(n+1)) / (n^4) = (7 pi^4) / (720)$;
  5. $sum_(n=1)^(oo) (1) / (n^4) = (pi^4) / (90)$.
] <ex:parseval-sums>

#solution(name: "sums of special series")[
  *(1)* By #link(<ex:sawtooth>)[*Sawtooth wave*],
  $
    x = 2 sum_(n=1)^(oo) ((-1)^(n+1)) / (n) sin(n x), quad x in (-pi, pi),
  $
  so $a_n = 0$ and $b_n = (2 (-1)^(n+1)) / n$. Parseval's identity gives
  $
    sum_(n=1)^(oo) (4) / (n^2) = (1) / (pi) integral_(-pi)^(pi) x^2 dif x = (2 pi^2) / (3),
  $
  hence $sum_(n=1)^(oo) (1) / (n^2) = (pi^2) / (6)$.

  *(2)* For the square wave of *Gibbs Phenomenon* one has $a_n = 0$, $b_(2 n) = 0$ and $b_(2 n + 1) = (4) / (pi (2 n + 1))$.
  Since $(1) / (pi) integral_(-pi)^(pi) f^2 = 2$, Parseval's identity gives
  $
    (16) / (pi^2) sum_(n=0)^(oo) (1) / ((2 n + 1)^2) = 2,
  $
  i.e. $sum_(n=1)^(oo) (1) / ((2 n - 1)^2) = (pi^2) / (8)$.

  *(3)* Splitting the alternating series into odd and even indices and using (1) and (2),
  $
    sum_(n=1)^(oo) ((-1)^(n+1)) / (n^2) = sum_(n=0)^(oo) (1) / ((2 n + 1)^2) - sum_(n=1)^(oo) (1) / ((2 n)^2) = (pi^2) / (8) - (1) / (4) dot (pi^2) / (6) = (pi^2) / (12).
  $

  *(4)* The same splitting, applied to (5) below, gives with $S = sum_(n=1)^(oo) 1 / n^4$ an even part $S / 16$ and an odd part $(15) / (16) S$, hence
  $
    sum_(n=1)^(oo) ((-1)^(n+1)) / (n^4) = (15) / (16) S - (1) / (16) S = (7) / (8) S = (7 pi^4) / (720).
  $

  *(5)* For $f(x) = x^2$ on $[-pi, pi]$ one computes $a_0 = (2 pi^2) / (3)$, $a_n = (4 (-1)^n) / (n^2)$ and $b_n = 0$. Parseval's identity then gives
  $
    (1) / (2) dot (4 pi^4) / (9) + 16 sum_(n=1)^(oo) (1) / (n^4) = (1) / (pi) integral_(-pi)^(pi) x^4 dif x = (2 pi^4) / (5),
  $
  hence $sum_(n=1)^(oo) (1) / (n^4) = (pi^4) / (90)$.
]

== Poisson Kernel // Poisson 核

The averaging device that produced the Fejér kernel also works when the truncation parameter is sent to $1$ rather than to $+oo$.

#definition(name: "Poisson Kernel")[
  For $0 <= r < 1$ and $t in bb(R)$, the *Poisson kernel* is
  $
    P_(r)(t) = sum_(n=-oo)^(+oo) r^(abs(n)) e^(i n t) = (1 - r^2) / (1 - 2 r cos t + r^2).
  $
] <def:poisson-kernel>

#property[
  1. *Positivity.* $P_(r)(t) >= 0$, since $1 - 2 r cos t + r^2 >= (1 - r)^2 > 0$.
  2. *Normalization.* $(1) / (2pi) integral_(-pi)^(pi) P_(r)(t) dif t = 1$.
  3. *Concentration.* For every $delta in (0, pi)$,
    $
      sup_(delta <= abs(t) <= pi) P_(r)(t) <= (1 - r^2) / (1 - 2 r cos delta + r^2) -> 0, quad r -> 1^-.
    $
] <prop:poisson-properties>

#theorem(name: "Abel's Theorem")[
  Let $f in cal(R)[-pi, pi]$ and $0 <= r < 1$. The *Abel means*
  $
    A_(r)(f; x) = (1) / (2pi) integral_(-pi)^(pi) f(t) P_(r)(x - t) dif t = sum_(n=-oo)^(+oo) r^(abs(n)) hat(f)(n) e^(i n x)
  $
  satisfy:
  1. if $f$ is continuous, then $A_(r)(f; x) -> f(x)$ uniformly on $bb(T)$ as $r -> 1^-$;
  2. if $f$ has left and right limits at $x_0$, then $A_(r)(f; x_0) -> (f(x_0^+) + f(x_0^-)) / 2$.
] <thm:abel>

#proof(name: "of Abel's Theorem")[
  The argument is that of #link(<thm:fejer>)[*Fejér Theorem*]: positivity, normalization and concentration of $P_(r)$ play exactly the role of the same three properties of $F_(N)$, and the identity for the Abel means follows from the uniform convergence of $sum r^(abs(n))$ by exchanging sum and integral.
]

#note(title: "Harmonic functions")[
  For $f in cal(R)[-pi, pi]$ the function $u(r e^(i theta)) = A_(r)(f; theta)$ is harmonic in the open unit disc, and by the theorem above it tends to $f$ at every point where $f$ has one-sided limits.
  This is the Poisson integral formula for the Dirichlet problem on the disc; its use in PDEs belongs to the Équations aux Dérivées Partielles note.
]

== Equidistribution // 等分布

Fourier analysis also decides when a sequence fills an interval evenly.

#definition(name: "Equidistributed Sequence")[
  A sequence $(x_(n))_(n >= 1)$ in $[0, 1)$ is *equidistributed* if for every interval $[a, b) subset.eq [0, 1)$ the proportion of the first $N$ terms falling into it tends to its length:
  $
    lim_(N -> oo) (1) / (N) sum_(n=1)^(N) bold(1)_([a, b))(x_(n)) = b - a,
  $
  where $bold(1)_([a, b))$ denotes the indicator function of $[a, b)$.
] <def:equidistributed>

#theorem(name: "Weyl's Criterion")[
  A sequence $(x_(n))_(n >= 1)$ in $[0, 1)$ is equidistributed if and only if, for every integer $k != 0$,
  $
    lim_(N -> oo) (1) / (N) sum_(n=1)^(N) e^(2 pi i k x_(n)) = 0.
  $
] <thm:weyl>

#proof(name: "of Weyl's Criterion")[
  *(1) Equidistribution implies averages.* If $x_(n)$ is equidistributed, then
  $
    lim_(N -> oo) (1) / (N) sum_(n=1)^(N) g(x_(n)) = integral_(0)^(1) g(t) dif t
  $
  for every Riemann integrable $g$ on $[0, 1]$: the identity holds for indicator functions of intervals by hypothesis, hence for step functions, and every Riemann integrable $g$ is a uniform limit of step functions.
  Taking $g(t) = e^(2 pi i k t)$ with $k != 0$ gives necessity, since $integral_(0)^(1) e^(2 pi i k t) dif t = 0$.

  *(2) Sufficiency.* Assume that the exponential averages vanish for all $k != 0$.
  Let $g$ be continuous on $[0, 1]$; replacing $g$ by a function continuous on the circle (the value at $1$ is never taken by $x_(n)$), #link(<thm:fejer>)[*Fejér Theorem*] provides trigonometric polynomials uniformly close to $g$.
  For $P(t) = sum_(abs(k) <= K) c_(k) e^(2 pi i k t)$ the hypothesis gives
  $
    (1) / (N) sum_(n=1)^(N) P(x_(n)) -> c_(0) = integral_(0)^(1) P(t) dif t,
  $
  and the same limit holds for $g$.
  Finally, for $0 <= a < b <= 1$ and $epsilon > 0$ there are continuous $g_(1) <= bold(1)_([a, b)) <= g_(2)$ with $integral_(0)^(1) (g_(2) - g_(1)) < epsilon$; passing to the limit in $N$ squeezes the proportion between $integral_(0)^(1) g_(1)$ and $integral_(0)^(1) g_(2)$, which gives the required limit $b - a$.
]

#example(name: "Rotation by an angle")[
  For $alpha in bb(R)$ let $x_(n) = {n alpha}$ be the fractional part of $n alpha$.
  Then $(x_(n))$ is equidistributed if and only if $alpha$ is irrational.
] <ex:equidistribution>

#solution(name: "rotation by an angle")[
  If $alpha = p / q$ is rational, then $x_(q) = 0$, so taking $k = q$ in Weyl's criterion gives an average equal to $1$ and the sequence is not equidistributed.

  Let $alpha$ be irrational. For $k != 0$ the number $e^(2 pi i k alpha)$ is different from $1$, and the geometric sum formula gives
  $
    abs(sum_(n=1)^(N) e^(2 pi i k n alpha)) = abs((e^(2 pi i k alpha) (1 - e^(2 pi i k N alpha))) / (1 - e^(2 pi i k alpha))) <= (2) / (abs(1 - e^(2 pi i k alpha))),
  $
  whence the averages tend to zero for every $k != 0$, and Weyl's criterion applies.
]

The convergence theory developed so far is conditional: it asks for regularity, monotonicity or bounded variation of $f$. The following theorem removes every hypothesis.

#theorem(name: "Carleson–Hunt Theorem")[
  Let $f in L^p(bb(T))$ with $1 < p <= +oo$. Then the Fourier series of $f$ converges to $f$ almost everywhere on $bb(T)$.
] <thm:carleson-hunt>

In particular the Fourier series of every $L^2$ function converges almost everywhere, although it need not converge uniformly or even at every point. This is the sharp endpoint of the theory: no condition on $f$ beyond integrability of some power is required.
The proof is far outside the scope of this note — it rests on time-frequency decompositions and on $L^2$ weighted estimates for the maximal Carleson operator — so the statement is recorded for reference only. Carleson proved the $L^2$ case in 1966 and Hunt extended it to $L^p$, $1 < p < +oo$, in 1968.
The hypothesis $p > 1$ cannot be lowered: Kolmogorov constructed an $L^1$ function whose Fourier series diverges almost everywhere.

#part("Fourier Transform and Modern Theory") // Fourier 变换与现代理论

= The Fourier Transform on $bb(R)$ // 实轴上的 Fourier 变换

== From Periodic to Non-Periodic // 从周期函数到非周期函数

Every function considered in Part I was periodic, so its spectrum was a discrete family $(hat(f)(n))_(n in bb(Z))$. Dropping periodicity should replace that family by a function of a continuous frequency variable. The following computation is the heuristic that performs the replacement; the rigorous statement is the *Fourier Inversion Theorem* of §3.4.

Let $f$ have period $2T$. By #link(<def:fourier-coefficients>)[the Euler–Fourier formula] in the form given in §1.2,
$
  f(x) ~ sum_(n in bb(Z)) hat(f)_T(n) e^(i n (pi) / (T) x), quad hat(f)_T(n) = (1) / (2T) integral_(-T)^(T) f(t) e^(-i n (pi) / (T) t) dif t.
$
Put $xi_n = n / (2T)$, so that the exponentials read $e^(2 pi i xi_n x)$ and the spacing of consecutive frequencies is
$
  Delta xi = xi_(n+1) - xi_n = (1) / (2T).
$
Then
$
  f(x) ~ sum_(n in bb(Z)) ( integral_(-T)^(T) f(t) e^(-2 pi i xi_n t) dif t ) e^(2 pi i xi_n x) Delta xi,
$
which is a Riemann sum, over the grid $(xi_n)$, for the function
$
  xi |-> ( integral_(-oo)^(oo) f(t) e^(-2 pi i xi t) dif t ) e^(2 pi i xi x).
$
Letting $T -> +oo$ sends $Delta xi -> 0$ and the sum to the integral of that function:
$
  f(x) = integral_(-oo)^(oo) ( integral_(-oo)^(oo) f(t) e^(-2 pi i xi t) dif t ) e^(2 pi i xi x) dif xi.
$

#caution[
  This is only a formal derivation. Three limits are taken without justification: the expanding interval $[-T, T]$ is replaced by $bb(R)$, the Riemann sum is replaced by an integral of a function that need not be integrable, and the two integrations are interchanged. The identity it suggests is true, but it has to be proved, and the proof is the content of §3.4.
]

#definition(name: "Fourier Transform")[
  Let $f$ be absolutely integrable on $bb(R)$. Its *Fourier transform* is the function
  $
    hat(f)(xi) = cal(F)[f](xi) = integral_(-oo)^(oo) f(x) e^(-2 pi i xi x) dif x, quad xi in bb(R).
  $ <eq:fourier-transform>
  Whenever the integral below converges, the *inverse Fourier transform* of $g$ is
  $
    cal(F)^(-1)[g](x) = integral_(-oo)^(oo) g(xi) e^(2 pi i xi x) dif xi, quad x in bb(R).
  $ <eq:inverse-fourier-transform>
] <def:fourier-transform>

The variable $xi$ is the *frequency*: it counts the number of oscillations per unit length, and $e^(2 pi i xi x)$ has period $1 \/ xi$. Thus $hat(f)(xi)$ measures how much of $f$ oscillates at that rate. Under this convention no constant appears in front of either integral; the price is the factor $2 pi$ hidden in the exponent.

#caution[
  Several normalizations circulate in the literature, and a formula copied from a source that uses another one is false as it stands. The three common choices are: no constant in either direction (used here), $1 \/ sqrt(2 pi)$ in both directions (unitary, but with $e^(plus.minus i omega x)$), and $1$ forward with $1 \/ (2 pi)$ backward (the *angular* convention below). Conversion is mechanical once the frequency variable is matched, see #link(<eq:freq-dictionary>)[the dictionary].
]

#note(title: "Angular frequency")[
  Writing $omega = 2 pi xi$, so that $e^(2 pi i xi x) = e^(i omega x)$, the same transform reads
  $
    hat(f)_(omega)(omega) = hat(f)(omega / (2 pi)) = integral_(-oo)^(oo) f(x) e^(-i omega x) dif x,
  $
  and the inverse formula carries the factor $1 \/ (2 pi)$:
  $
    f(x) = (1) / (2 pi) integral_(-oo)^(oo) hat(f)_(omega)(omega) e^(i omega x) dif omega.
  $ <eq:freq-dictionary>
  The angular variable is the natural one for the Laplace transform in §5.3, where $s = sigma + i omega$; both conventions are recorded so that the two chapters can be read side by side.
]

#example(name: "Fourier transform of the box function")[
  Let $f = bold(1)_([-a, a])$ with $a > 0$. For $xi != 0$,
  $
    hat(f)(xi) = integral_(-a)^(a) e^(-2 pi i xi x) dif x = (e^(2 pi i xi a) - e^(-2 pi i xi a)) / (2 pi i xi) = (sin(2 pi a xi)) / (pi xi),
  $
  while $hat(f)(0) = 2a$. The transform is continuous and decays like $1 \/ abs(xi)$, so it is _not_ absolutely integrable on $bb(R)$: already for this harmless $f$ the inversion formula cannot be justified by an absolutely convergent integral. This is the obstruction taken up in §4.1.
] <ex:box-fourier>

== Schwartz Space and Tempered Distributions // 速降空间与缓增分布

The definition of the Fourier transform asks only for absolute integrability, and #link(<ex:box-fourier>)[the box function] already shows that the transform of an integrable function need not be integrable. A proof of inversion therefore needs a space in which differentiation, multiplication by polynomials and the Fourier transform itself act without leaving the space. That space is the Schwartz space: it trades generality for total stability.

#definition(name: "Schwartz Seminorms")[
  For $phi in C^oo(bb(R))$ and integers $m, n >= 0$ put
  $
    || phi ||_((m, n)) = sup_(x in bb(R)) abs(x^m phi^((n))(x)).
  $ <eq:schwartz-seminorm>
  Each $|| dot ||_((m, n))$ is a seminorm on the space of smooth functions: homogeneous and subadditive, but vanishing on every function supported away from the origin when $m >= 1$. No single one of them is a norm.
] <def:schwartz-seminorms>

#definition(name: "Schwartz Space")[
  The *Schwartz space* $cal(S)(bb(R))$ is the set of $phi in C^oo(bb(R))$ such that
  $
    || phi ||_((m, n)) < oo quad "for every" m, n >= 0.
  $
  In words: $phi$ and each of its derivatives decay faster than the reciprocal of any polynomial at infinity.

  A sequence $(phi_j)$ converges to $phi$ in $cal(S)(bb(R))$ if $|| phi_j - phi ||_((m, n)) -> 0$ for every pair $(m, n)$;
  the space is endowed with the topology defined by the whole family of seminorms. With this topology $cal(S)(bb(R))$ is a Fréchet space, and it contains $cal(D)(bb(R))$ as a dense subspace.
] <def:schwartz-space>

#note[
  This is the one-dimensional case of the space introduced in the Équations aux Dérivées Partielles note as the *Schwartz space* $cal(S)(bb(R)^n)$, where the definition is stated with multi-indices on $bb(R)^n$.
  Only the case $n = 1$ is needed here, and the seminorm family above is the extra structure that the Fourier transform requires; the multi-index version is not repeated.
]

The stability of $cal(S)$ is what makes it usable.

#proposition(name: "Closure Properties of the Schwartz Space")[
  Let $phi, psi in cal(S)(bb(R))$. Then:
  1. *Differentiation.* $phi' in cal(S)(bb(R))$, and $D: cal(S) -> cal(S)$ is continuous.
  2. *Multiplication.* $x phi in cal(S)(bb(R))$, and the map $phi |-> x phi$ is continuous.
  3. *Multiplication by functions of moderate growth.* If $a in C^oo(bb(R))$ has all derivatives of polynomial growth, then $a phi in cal(S)(bb(R))$.
  4. *Products.* $phi psi in cal(S)(bb(R))$; in particular $cal(S)$ is an algebra.
  5. *Integrability.* $cal(S)(bb(R)) subset L^1(bb(R))$, so that the Fourier transform of every Schwartz function is defined.
] <prop:schwartz-stability>

#proof[
  Statements 1, 2 and 4 are immediate from the Leibniz rule: each seminorm of a derivative or of a product is controlled by finitely many seminorms of the factors, which is exactly continuity.
  For 3, $D^n(a phi) = sum_(k=0)^(n) binom(n, k) D^(n-k)(a) D^k(phi)$ and $abs(x^m D^(n-k) a(x))$ is bounded by hypothesis, so $|| a phi ||_((m, n))$ is bounded by a finite sum of seminorms of $phi$.
  For 5, $abs(phi(x)) <= || phi ||_((2, 0)) / (1 + x^2)$ and $x |-> 1 \/ (1 + x^2)$ is integrable.
]

#definition(name: "Tempered Distribution")[
  A *tempered distribution* on $bb(R)$ is a linear functional $T: cal(S)(bb(R)) -> bb(C)$ that is continuous for the topology above: $phi_j -> phi$ in $cal(S)$ implies $T(phi_j) -> T(phi)$.
  The space of all tempered distributions is denoted $cal(S)' (bb(R))$, and the value of $T$ at $phi$ is written $⟨ T, phi ⟩$.
] <def:tempered-distribution>

#note[
  A general distribution is a continuous functional on $cal(D)(Omega)$; its definition and the duality pairing $⟨ T, phi ⟩$ are given in the Équations aux Dérivées Partielles note (see its chapter on distributions).
  Since $cal(D) subset cal(S)$ with a finer topology on $cal(S)$, every tempered distribution is a distribution, $cal(S)'(bb(R)) subset cal(D)'(bb(R))$; the converse fails, and $x |-> e^(x^2)$ is the standard example of a distribution that is not tempered.
  Every function of polynomial growth acts on $cal(S)$ by integration against it, so $L^p(bb(R)) subset cal(S)'(bb(R))$ for every $p in [1, +oo]$.
]

Tempered distributions are exactly the class on which the Fourier transform extends by duality, which is the reason for introducing them at this point; the extension itself is stated at the end of §3.4, once the inversion formula is available.

== Basic Properties of the Fourier Transform // Fourier 变换的基本性质

Every statement below is made for $f, g in cal(S)(bb(R))$, the space introduced in §3.2. The proofs are short computations, and they are not the point: what matters is the pattern. Each operation on the variable $x$ has a dual operation on the frequency $xi$, and the transform passes from one column of the following list to the other.

#property(name: "Fourier Transform Rules")[
  Let $f, g in cal(S)(bb(R))$, $a, b in bb(C)$, $x_0, xi_0 in bb(R)$ and $c in bb(R) without {0}$. Then
  1. *Linearity.*
    $ cal(F)[a f + b g] = a cal(F)[f] + b cal(F)[g]. $

  2. *Translation and modulation.*
    $ cal(F)[f(x - x_0)](xi) = e^(-2 pi i xi x_0) hat(f)(xi), quad cal(F)[e^(2 pi i xi_0 x) f(x)](xi) = hat(f)(xi - xi_0). $

  3. *Scaling.*
    $ cal(F)[f(c x)](xi) = (1) / (abs(c)) hat(f)(xi / c). $

  4. *Conjugation and reflection.*
    $ hat(overline(f))(xi) = overline(hat(f)(-xi)), quad cal(F)[f(-x)](xi) = hat(f)(-xi). $

  5. *Differentiation and multiplication.* For every $n >= 0$,
    $ cal(F)[f^((n))](xi) = (2 pi i xi)^n hat(f)(xi), quad cal(F)[x^n f(x)](xi) = (1) / (2 pi i)^n hat(f)^((n))(xi). $

  6. *Multiplication formula.*
    $ integral_(-oo)^(oo) f(x) hat(g)(x) dif x = integral_(-oo)^(oo) hat(f)(xi) g(xi) dif xi. $
] <prop:fourier-transform-rules>

#proof[
  (1) is the linearity of the integral. In (2) the substitution $u = x - x_0$ produces the factor $e^(-2 pi i xi x_0)$, and the modulation statement is the same computation written with the frequencies shifted.
  In (3) the substitution $u = c x$ produces the factor $1 \/ abs(c)$ and rescales the frequency into $xi \/ c$.
  In (4) take conjugates and substitute $u = -x$.
  In (5) integrate by parts $n$ times: the boundary terms vanish because every derivative of a Schwartz function decays faster than any polynomial, and each integration by parts brings down a factor $2 pi i xi$; differentiating under the integral sign gives the second identity.
  For (6), apply Fubini to the absolutely convergent double integral
  $
    integral_(-oo)^(oo) integral_(-oo)^(oo) abs(f(x) g(y) e^(-2 pi i x y)) dif x dif y = || f ||_1 || g ||_1 < +oo.
  $
]

The product rule, which is the frequency-side shadow of the convolution theorem below, is the most used property of the transform.

#theorem(name: "Convolution Theorem")[
  Let $f, g in cal(S)(bb(R))$. Then $f * g in cal(S)(bb(R))$ and
  $
    hat(f * g)(xi) = hat(f)(xi) dot hat(g)(xi), quad xi in bb(R).
  $
  Conversely, $hat(f g) = hat(f) * hat(g)$.
] <thm:convolution-R>

#proof[
  By #link(<def:convolution>)[the definition of convolution], $(f * g)(x) = integral_(-oo)^(oo) f(t) g(x - t) dif t$, so
  $
    hat(f * g)(xi) & = integral_(-oo)^(oo) ( integral_(-oo)^(oo) f(t) g(x - t) dif t ) e^(-2 pi i xi x) dif x \
    & = integral_(-oo)^(oo) f(t) ( integral_(-oo)^(oo) g(x - t) e^(-2 pi i xi x) dif x ) dif t \
    & = integral_(-oo)^(oo) f(t) e^(-2 pi i xi t) hat(g)(xi) dif t = hat(f)(xi) dot hat(g)(xi).
  $
  The interchange of integrals is legitimate: the integrand is dominated by $abs(f(t) g(x - t))$, whose double integral is $|| f ||_1 || g ||_1$ by Fubini and translation invariance of the integral. The second statement follows from the first applied to $hat(f)$ and $hat(g)$, using the inversion formula of §3.4, or directly from the multiplication formula of the preceding proposition.
]

=== The Transform as an Operator on $cal(S)$ // 作为速降空间上的算子

Rule 5 has a consequence that was promised in §3.2: the transform never leaves the Schwartz space, and it acts continuously there.

#proposition(name: "The Fourier Transform on the Schwartz Space")[
  For every $phi in cal(S)(bb(R))$ the transform $hat(phi)$ belongs to $cal(S)(bb(R))$, and $cal(F): cal(S)(bb(R)) -> cal(S)(bb(R))$ is continuous for the topology defined by the seminorms of §3.2.
] <prop:fourier-schwartz>

#proof[
  Fix $m, n >= 0$ and write $psi = (-2 pi i x)^m phi(x)$, which is again a Schwartz function by #link(<prop:schwartz-stability>)[the closure properties]. By rule 5 applied twice,
  $
    xi^n hat(phi)^((m))(xi) = (1) / (2 pi i)^n cal(F)[psi^((n))](xi) = (1) / (2 pi i)^n integral_(-oo)^(oo) psi^((n))(x) e^(-2 pi i xi x) dif x.
  $
  Taking absolute values and then suprema over $xi$,
  $
    || hat(phi) ||_((m, n)) <= (1) / (2 pi)^n || psi^((n)) ||_1 <= (1) / (2 pi)^n sum_(k=0)^(n) binom(n, k) (2 pi)^(m - k) || phi ||_((m, n - k)),
  $
  where the last inequality uses $abs(psi^((n))(x)) <= C \/ (1 + x^2)$ for a combination of finitely many seminorms of $phi$, exactly as in the proof of the closure properties. Hence $hat(phi) in cal(S)$ and $phi_j -> phi$ in $cal(S)$ implies $hat(phi_j) -> hat(phi)$ in $cal(S)$.
]

#caution[
  The estimate above is the reason for choosing $cal(S)$ rather than $cal(D)$ or $L^1$: on $cal(D)$ the transform leaves the space, and on $L^1$ it does not even land in $L^1$. The price is that $cal(S)$ contains no compactly supported function except $0$, so it cannot be used where support conditions matter.
]

== Fourier Inversion Theorem // Fourier 反演定理

The heuristic of §3.1 ended with the formula $f(x) = integral hat(f)(xi) e^(2 pi i xi x) dif xi$. #link(<ex:box-fourier>)[The box function] shows why this cannot be taken at face value: $hat(f)$ need not be integrable, so the integral may not converge. A factor forcing convergence has to be inserted, and the natural choice is the Gaussian, because it is its own transform.

#definition(name: "Gauss Kernel")[
  For $delta > 0$ and $x in bb(R)$ the *Gauss kernel* of width $delta$ is
  $
    K_delta(x) = (1) / (delta) e^(-pi (x / delta)^2).
  $ <eq:gauss-kernel>
] <def:gauss-kernel>

#proposition(name: "The Gaussian is its own transform")[
  For every $xi in bb(R)$,
  $
    integral_(-oo)^(oo) e^(-pi x^2) e^(-2 pi i xi x) dif x = e^(-pi xi^2),
  $ <eq:gauss-fourier>
  and consequently $hat(K_delta)(xi) = e^(-pi delta^2 xi^2)$.
] <prop:gauss-fourier-transform>

#proof[
  Put $F(xi) = integral_(-oo)^(oo) e^(-pi x^2) e^(-2 pi i xi x) dif x$. The integrand is dominated by $e^(-pi x^2)$, so $F$ may be differentiated under the integral sign:
  $
    F'(xi) = -2 pi i integral_(-oo)^(oo) x e^(-pi x^2) e^(-2 pi i xi x) dif x.
  $
  Since $(dif) / (dif x) e^(-pi x^2) = -2 pi x e^(-pi x^2)$, an integration by parts gives
  $
    F'(xi) = i integral_(-oo)^(oo) ( (dif) / (dif x) e^(-pi x^2) ) e^(-2 pi i xi x) dif x = -2 pi xi F(xi),
  $
  the boundary term vanishing at both ends. Moreover $F(0) = integral e^(-pi x^2) dif x = 1$, the classical Gaussian integral. The only solution of $F' = -2 pi xi F$ with $F(0) = 1$ is $F(xi) = e^(-pi xi^2)$.
  For the second statement, substitute $x = delta u$:
  $
    hat(K_delta)(xi) = integral_(-oo)^(oo) (1) / (delta) e^(-pi (x / delta)^2) e^(-2 pi i xi x) dif x = integral_(-oo)^(oo) e^(-pi u^2) e^(-2 pi i delta xi u) dif u = e^(-pi delta^2 xi^2).
  $
]

#lemma(name: "The Gauss Kernel is an Approximate Identity")[
  For every $delta > 0$ the kernel $K_delta$ satisfies:
  1. *Positivity.* $K_delta(x) >= 0$ for all $x$.
  2. *Normalization.* $integral_(-oo)^(oo) K_delta(x) dif x = 1$.
  3. *Concentration.* For every $eta > 0$,
    $
      integral_(abs(x) > eta) K_delta(x) dif x -> 0, quad delta -> 0^+.
    $
  Consequently, for every $f in cal(S)(bb(R))$, the convolution $f * K_delta$ converges to $f$ uniformly on $bb(R)$ as $delta -> 0^+$.
] <lem:gauss-approximation>

#proof[
  Positivity is clear. For normalization, substitute $u = x \/ delta$ and use the Gaussian integral. For concentration, the same substitution gives
  $
    integral_(abs(x) > eta) K_delta(x) dif x = integral_(abs(u) > eta \/ delta) e^(-pi u^2) dif u -> 0,
  $
  since $eta \/ delta -> +oo$ and the tail of an integrable function vanishes.

  For the last claim write $f * K_delta - f$ as an integral and split it at $eta$:
  $
    abs((f * K_delta)(x) - f(x)) <= integral_(abs(y) <= eta) K_delta(y) abs(f(x - y) - f(x)) dif y + 2 || f ||_oo integral_(abs(y) > eta) K_delta(y) dif y.
  $
  Given $epsilon > 0$, uniform continuity of $f$ on $bb(R)$ gives $eta > 0$ with $abs(f(x - y) - f(x)) < epsilon \/ 2$ whenever $abs(y) <= eta$, and then concentration makes the second term smaller than $epsilon \/ 2$ for $delta$ small enough. This is the same three-property argument as in #link(<prop:fejer-properties>)[the Fejér kernel].
]

#theorem(name: "Fourier Inversion Theorem")[
  Let $f in cal(S)(bb(R))$. Then for every $x in bb(R)$
  $
    f(x) = integral_(-oo)^(oo) hat(f)(xi) e^(2 pi i xi x) dif xi,
  $ <eq:inversion-formula>
  the integral converging absolutely, and the convergence being uniform in $x$.
] <thm:fourier-inversion>

#proof[
  Let $delta > 0$ and put
  $
    f_delta(x) = integral_(-oo)^(oo) hat(f)(xi) e^(2 pi i xi x) e^(-pi delta^2 xi^2) dif xi.
  $
  Since $hat(f) in cal(S)$ by #link(<prop:fourier-schwartz>)[the preceding proposition], the integrand is integrable and Fubini applies:
  $
    f_delta(x) = integral_(-oo)^(oo) f(t) ( integral_(-oo)^(oo) e^(2 pi i xi (x - t)) e^(-pi delta^2 xi^2) dif xi ) dif t = integral_(-oo)^(oo) f(t) K_delta(x - t) dif t,
  $
  where the inner integral equals $K_delta(x - t)$: after the substitution $eta = delta xi$ it reads $(1) / (delta) hat(G)((t - x) / (delta))$ with $G(u) = e^(-pi u^2)$, and $hat(G) = G$ is #link(<prop:gauss-fourier-transform>)[the Gaussian identity], while $G$ is even. Hence $f_delta = f * K_delta$, and #link(<lem:gauss-approximation>)[the approximate identity lemma] gives $f_delta -> f$ uniformly.

  On the other hand $abs(hat(f)(xi) e^(2 pi i xi x) e^(-pi delta^2 xi^2)) <= abs(hat(f)(xi))$, which is integrable, so dominated convergence gives
  $
    f_delta(x) -> integral_(-oo)^(oo) hat(f)(xi) e^(2 pi i xi x) dif xi quad "for every" x.
  $
  The two limits coincide, which is the claimed identity. Absolute convergence follows from $hat(f) in L^1(bb(R))$, and uniformity from the uniform convergence of $f * K_delta$ and the domination just used.
]

#corollary(name: "Injectivity and Invertibility")[
  If $f, g in cal(S)(bb(R))$ and $hat(f) = hat(g)$, then $f = g$. More generally $cal(F): cal(S)(bb(R)) -> cal(S)(bb(R))$ is a linear isomorphism.
] <cor:fourier-injective>

#corollary(name: "Involutivity")[
  For $f in cal(S)(bb(R))$,
  $
    cal(F)^2[f](x) = f(-x), quad "hence" quad cal(F)^4 = "id".
  $
] <cor:fourier-involution>

#proof[
  By the definition applied to $hat(f)$ and then the inversion formula with $x$ replaced by $-x$,
  $
    cal(F)^2[f](x) = integral_(-oo)^(oo) hat(f)(xi) e^(-2 pi i x xi) dif xi = f(-x).
  $
  Applying this twice more returns $f$.
]

=== The Transform on Tempered Distributions // 缓增分布上的 Fourier 变换

#proposition(name: "Fourier Transform of a Tempered Distribution")[
  For $T in cal(S)' (bb(R))$ define $cal(F)T$ by
  $
    ⟨ cal(F)T, phi ⟩ = ⟨ T, cal(F)phi ⟩, quad phi in cal(S)(bb(R)).
  $
  Then $cal(F)T in cal(S)' (bb(R))$, and $cal(F): cal(S)' (bb(R)) -> cal(S)' (bb(R))$ is a linear isomorphism whose inverse is given by the same formula with $cal(F)^(-1)$ in place of $cal(F)$.
] <prop:fourier-tempered>

#proof[
  The functional $cal(F)T$ is well defined because $cal(F)phi in cal(S)$ for $phi in cal(S)$, and it is continuous because $phi_j -> phi$ in $cal(S)$ implies $cal(F)phi_j -> cal(F)phi$ by #link(<prop:fourier-schwartz>)[continuity of the transform on $cal(S)$], whence $⟨ T, cal(F)phi_j ⟩ -> ⟨ T, cal(F)phi ⟩$.
  Linearity in $T$ is clear. For the inverse, #link(<cor:fourier-involution>)[involutivity] gives $⟨ cal(F)^2 T, phi ⟩ = ⟨ T, tilde(phi) ⟩$ where $tilde(phi)(x) = phi(-x)$, so applying $cal(F)$ four times returns $T$; hence $cal(F)^(-1) = cal(F)^3$ on $cal(S)'$, and $cal(F)^(-1) T$ is computed by the same transposition formula.
]

#example(name: "Fourier transform of the constant and of the Dirac mass")[
  For $phi in cal(S)(bb(R))$, the definition gives
  $
    ⟨ cal(F)1, phi ⟩ = ⟨ 1, cal(F)phi ⟩ = integral_(-oo)^(oo) hat(phi)(xi) dif xi = phi(0),
  $
  the last step being #link(<eq:inversion-formula>)[the inversion formula] at $x = 0$. Hence $cal(F)1 = delta_0$. The same computation with the roles exchanged, using $⟨ cal(F)delta_0, phi ⟩ = ⟨ delta_0, cal(F)phi ⟩ = hat(phi)(0) = integral phi$, gives $cal(F)delta_0 = 1$.
  So a constant has only the zero frequency, and a point mass is spread over all frequencies; on tempered distributions the transform becomes a symmetry with no preferred side.
] <ex:fourier-delta>

#corollary(name: "Inversion on $L^1$")[
  Let $f in L^1(bb(R))$ and assume that $hat(f) in L^1(bb(R))$. Then $f$ agrees almost everywhere with the continuous function
  $
    x |-> integral_(-oo)^(oo) hat(f)(xi) e^(2 pi i xi x) dif xi.
  $
] <cor:fourier-inversion-l1>

#note[
  The proof is deferred to §4.1. It repeats the argument above with the Gaussian factor kept and the limit taken in $L^1$ instead of uniformly, and it requires two facts proved there: the density of $cal(S)(bb(R))$ in $L^1(bb(R))$ and the continuity of the transform on $L^1$, which is the transform version of the Riemann–Lebesgue lemma.
]

= L¹, L² and the Plancherel Theorem // L¹、L² 与 Plancherel 定理

== The Fourier Transform on $L^1$ // $L^1$ 上的 Fourier 变换
// TODO：lem:riemann-lebesgue-transform（变换版）、值域不闭、L¹ 上的反演条件
// 旧稿的 == $L^1$ Space 已撤销，内容并入本节

== Plancherel Theorem // Plancherel 定理
// TODO：L¹ ∩ L² 上的等距 -> 稠密性延拓 -> 酉性；与 @thm:parseval-identity 的对应
// 原 "The Dichotomy" 一分为二：本节与上一节

== Poisson Summation Formula // Poisson 求和公式
// TODO：由 @thm:fourier-inversion 周期化推出；抽样定理作为推论
// 原为 §3.1 的子节，因依赖反演定理而后移至此

== Heisenberg's Uncertainty Principle

#theorem(name: "Heisenberg's Uncertainty Principle")[
  For any function $f in cal(S)(bb(R))$,
  $
    ( integral_(-oo)^(oo) x^2 abs(f(x))^2 dif x ) ,
    ( integral_(-oo)^(oo) omega^2 abs(hat(f)(omega))^2 dif omega ) ,
    >= (1) / (4) ( integral_(-oo)^(oo) abs(f(x))^2 dif x )^2. ,
  $
  Equality holds if and only if $f(x)$ is a Gaussian function of the form
  $f(x) = A e^(-a x^2)$ for some constants $A in bb(C)$ and $a > 0$.
]

== Laplace Transform
Fourier transform requires the function to be integrable over the entire real line,
which may not hold for functions that grow exponentially.
To handle such functions, we introduce the Laplace transform, defined as follows.
#definition(name: "Laplace Transform")[
  The *Laplace transform* of a function $f(t)$ defined for $t >= 0$ is given by
  $
    cal(L)[f](s) = integral_(0)^(oo) f(t) e^(-s t) dif t,
  $
  where $s$ is a complex variable.
]

#theorem(name: "Existence of Laplace Transform")[
  If there exist constants $M, s_0 > 0$ such that $abs(f(t)) <= M e^(s_0 t)$ for all $t >= 0$,
  then the Laplace transform $cal(L)[f](s)$ exists for all $s$ with $Re(s) > s_0$.
]

#property[
  1. *Linearity.* For any functions $f, g$ and scalars $a, b$,
    $
      cal(L)[a f + b g](s) = a cal(L)[f](s) + b cal(L)[g](s).
    $

  2. *Derivative.* For any function $f$ with appropriate growth conditions,
    $
      cal(L)[ (dif f) / (dif t) ](s) = s cal(L)[f](s) - f(0).
    $
    Or more generally,
    $
      cal(L)[ (dif^n f) / (dif t^n) ](s) = ,
      s^n cal(L)[f](s) - sum_(k=0)^(n-1) s^(n-1-k) f^((k))(0). ,
    $
]

Some common Laplace transforms are listed in the following table.
// TODO: The transform formulas of the last two rows were corrupted in the LaTeX source
// (mismatched \( ... \) and $ delimiters) and are left as placeholders.
#figure(
  tex-table(
    ([$f(t)$], [$cal(L)[f](s)$]),
    ([$1$], [$(1) / (s)$]),
    ([$t^n$], [$(n!) / (s^(n+1))$]),
    ([$e^(a t)$], [$(1) / (s - a)$]),
    ([$t^n e^(a t)$], [$(n!) / ((s - a)^(n+1))$]),
    ([$sin(omega t)$], [$(omega) / (s^2 + omega^2)$]),
    ([$cos(omega t)$], [$(s) / (s^2 + omega^2)$]),
    ([$sinh(omega t)$], [$(omega) / (s^2 - omega^2)$]),
    ([$cosh(omega t)$], [$(s) / (s^2 - omega^2)$]),
    ([$t^n e^(a t) sin(omega t)$], [TODO]),
    ([$t^n e^(a t) cos(omega t)$], [TODO]),
  ),
  caption: [Common Laplace transforms.],
  placement: auto,
  supplement: [Tab.],
) <tab:laplace-transforms>

== Fast Fourier Transform

// Part III — Sobolev Spaces (Sobolev 空间): Chapter 6 has no content yet (placeholder).

#bibliography("references.bib", title: "References", full: true)

// 目录
