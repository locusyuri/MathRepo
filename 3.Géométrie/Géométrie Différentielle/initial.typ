#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Géométrie Différentielle",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Géométrie Différentielle",
  "Violet",
  subtitle: "A notebook for differential geometry",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.1.0",
  extra-info: "This is a notebook for differential geometry.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
// 主线：古典曲线论 → 古典曲面论 → 光滑流形 → 流形上的结构与几何
// （对象递进：一维 → 二维 → n 维抽象 → 流形上的结构）
// 共 4 Part、17 Chapter。
//
// 职责边界：
//   - 隐函数定理、多元微分学（方向导数/链式/极值） → Analyse Mathématique
//     chap12（引用；legacy LaTeX 无标签，用章节文字指引）
//   - 参数化曲面/正则性/切空间法空间 → Analyse Mathématique chap14 §14.1-14.2（引用）
//   - 第一基本形式 E,F,G / 弧长 / 面积 → Analyse Mathématique chap14 §14.3（引用定义）
//   - 第二基本形式 L,M,N / Gauß 映射 / Weingarten / 法曲率 / 曲线曲率 κ →
//     Analyse Mathématique chap14 §14.4（引用定义，只深化不重述）
//   - 楔积 / 外微分 / Stokes / 闭-恰当形式 → Analyse Mathématique chap15
//     §15.2, 15.4, 15.5（引用；本笔记写流形上的推广）
//   - 标量/向量场线面积分 → Analyse Mathématique chap15 §15.1, 15.3（引用）
//   - 向量代数、参数方程、二次曲面、旋转曲面、圆锥曲线 → Géométrie Analytique（引用）
//   - Frenet-Serret 力学应用 → Mécanique analytique（曲线论完整重述于几何立场，
//     力学应用视角交叉引用）
//   - 群论基础（群、作用、同态） → Algèbre Abstraite（李群章引用）
//   - 同伦/同调/上同调、Euler 示性数 → Topologie Algébrique（曲面分类与
//     de Rham 联系，交叉引用）
//   - Hausdorff 测度 → Analyse Réelle（曲面测度论视角，交叉引用）
//   - 黎曼面上的复结构 → Analyse Complexe（进阶 note，不展开）
//   - 流形上函数空间、弱拓扑 → Analyse Fonctionnelle（交叉引用）
//
// 去重裁决：
//   - 数学分析（Analyse Mathématique，LaTeX legacy 只读）Part 4 已系统给出
//     曲面论与微分形式的"积分工具级"内容；本笔记一律引用其定义，只深化其
//     未展开的理论（主曲率分类、绝妙定理、测地线、de Rham 上同调等）
//   - 曲线论：数学分析仅有 κ 定义与密切圆；Frenet-Serret 完整框架、局部
//     标准形、曲线论基本定理为本笔记主体
//   - 点集拓扑基础：仓库无专门笔记，Ch 9 以一小节简短回顾（Hausdorff、
//     第二可数、紧致），不展开
//   - 张量/外代数：Algèbre Abstraite 无张量与模理论，Ch 13 自带多重线性
//     代数基础（Tu 式处理）
//
// 人名母语化（沿用用户规则）：Gauβ（德语正字法）、俄国人用西里尔、
// 其余按各自母语（如 Frenet、Serret、Meusnier、Céa 保法文原形）。
// ==========================================================================
// Part I — Classical Theory of Curves (古典曲线论)
// ==========================================================================
// 设计思路：一维对象（曲线）的完整理论，是微分几何的最小模型。数学分析
// 已在 chap14 给出曲线曲率 κ 与密切圆（积分工具语境），此处在此基础上
// 发展系统的 Frenet-Serret 理论并收束于整体性质。
// 对应教材：do Carmo Ch 1；Lee 相关预备。

// --- Chapter 1: Parameterized Curves (参数化曲线) ---

//   Section 1.1: Parameterized Curves and Regularity (参数化与正则性)
//     - 参数化曲线定义、正则曲线（引用数学分析 chap14 的曲线曲率语境）
//     - 可允许参数变换
//   Section 1.2: Arc Length and Natural Parameterization (弧长与自然参数)
//     - 弧长公式（引用数学分析 chap14 弧长定义）
//     - 弧长参数化与单位切向量
//   Section 1.3: Notation and Conventions (符号约定)
//     - 全文符号表、与各笔记的引用约定

// --- Chapter 2: Local Theory of Curves (曲线的局部理论) ---

//   Section 2.1: Frenet--Serret Frame (Frenet-Serret 框架)
//     - 切向量、主法向量、副法向量；曲率 κ 与挠率 τ
//     - Frenet-Serret 公式（完整推导；κ 定义引用数学分析 chap14）
//   Section 2.2: Local Canonical Form (局部标准形)
//     - 密切平面/法平面/从切平面；Taylor 展开的几何意义
//   Section 2.3: Fundamental Theorem of Curves (曲线论基本定理)
//     - 存在唯一性：κ(s)>0 与 τ(s) 决定曲线（至多相差一个刚体运动）

// --- Chapter 3: Global Properties of Curves (曲线的整体性质) ---

//   Section 3.1: Rotation Index Theorem (旋转指标定理)
//     - 平面曲线的旋转数、Hopf 定理
//   Section 3.2: Convex Curves and the Four-Vertex Theorem (凸曲线与四顶点定理)
//   Section 3.3: Isoperimetric Inequality (等周不等式)

#part("Classical Theory of Curves") // 古典曲线论

// ==========================================================================
// Part II — Classical Theory of Surfaces (古典曲面论)
// ==========================================================================
// 设计思路：二维对象（曲面）从局部到整体的一条完整线：基本形式 → 曲率 →
// 内蕴几何（测地线）→ 整体 Gauss-Bonnet。数学分析 chap14 已给出第一/第二
// 基本形式、Gauß 映射、Weingarten、法曲率的"积分工具级"定义，本笔记引用
// 这些定义并深化其未展开的理论。
// 对应教材：do Carmo Ch 2-5。

// --- Chapter 4: Regular Surfaces (正则曲面) ---

//   Section 4.1: Regular Surfaces (正则曲面)
//     - 参数化定义（引用数学分析 chap14 §14.1）
//     - 图册/隐函数表述（引用隐函数定理，数学分析 chap12）
//   Section 4.2: Tangent Planes and Differentials (切平面与微分)
//     - 切空间/法空间（引用数学分析 chap14 §14.2）；切映射 dF
//   Section 4.3: Rank and Regular Values (秩与正则值)
//     - 微分的秩、正则值、水平集曲面

// --- Chapter 5: Fundamental Forms (基本形式) ---

//   Section 5.1: First Fundamental Form (第一基本形式)
//     - E,F,G 定义与 ds²（引用数学分析 chap14 §14.3）；长度/角度/面积
//   Section 5.2: Gauss Map and Second Fundamental Form (Gauß 映射与第二基本形式)
//     - Gauß 映射、L,M,N 定义（引用数学分析 chap14 §14.4）；II 的几何意义
//   Section 5.3: Weingarten Map and Rodrigues Formulas (Weingarten 映射与 Rodrigues 公式)
//     - shape operator；方向导数公式

// --- Chapter 6: Curvature of Surfaces (曲率) ---

//   Section 6.1: Normal Curvature and Meusnier's Theorem (法曲率与 Meusnier 定理)
//     - 法曲率定义（引用数学分析 chap14）；Meusnier 定理
//   Section 6.2: Principal Curvatures and Euler's Formula (主曲率与 Euler 公式)
//     - 主曲率、主方向、Euler 公式 κ_n = κ_1 cos²θ + κ_2 sin²θ
//   Section 6.3: Gaussian and Mean Curvature (Gauß 曲率与平均曲率)
//     - K = κ_1 κ_2 = (LN - M²)/(EG - F²)；H = (κ_1 + κ_2)/2
//     - 例子：平面、球面、圆柱面、鞍面、旋转曲面
//   Section 6.4: Theorema Egregium (绝妙定理)
//     - Gauß 曲率是内蕴量（完整证明）

// --- Chapter 7: Intrinsic Geometry (内在几何) ---

//   Section 7.1: Isometries and Conformal Maps (等距与保形映射)
//     - 局部等距、保形；内蕴性质的定义
//   Section 7.2: Geodesics (测地线)
//     - 测地线定义（变分观点）；测地线方程；短程性
//   Section 7.3: Parallel Transport and Gauss's Lemma (平行移动与 Gauss 引理)
//     - 平行移动、Levi-Civita 视角（为 Ch 16 铺垫）
//   Section 7.4: Geodesic Polar Coordinates (测地极坐标)

// --- Chapter 8: Global Theory of Surfaces (曲面整体理论) ---

//   Section 8.1: Local Gauss--Bonnet Theorem (局部 Gauss-Bonnet 定理)
//   Section 8.2: Global Gauss--Bonnet Theorem (整体 Gauss-Bonnet 定理)
//     - ∫_S K dA + ∫_∂S κ_g ds = 2πχ(S)
//   Section 8.3: Classification of Compact Surfaces (紧致曲面分类)
//     - Euler 示性数与亏格（引用 Topologie Algébrique）；例子与几何推论

#part("Classical Theory of Surfaces") // 古典曲面论

// ==========================================================================
// Part III — Smooth Manifolds (光滑流形)
// ==========================================================================
// 设计思路：对象抽象化为 n 维流形，建立现代微分几何语言。点集拓扑基础
// 仓库无专门笔记，Ch 9 用一小节简短回顾；古典部分（Part I-II）作为
// R³ 中低维模型的直观背景。
// 对应教材：Lee Ch 1-8；Tu 相应部分。

// --- Chapter 9: Charts and Smooth Structures (图册与光滑结构) ---

//   Section 9.1: Topological Manifolds (拓扑流形)
//     - 简短回顾：Hausdorff、第二可数、局部欧氏
//   Section 9.2: Charts and Smooth Structures (图册与光滑结构)
//     - 图册、相容性、光滑结构；光滑结构与正则曲面的联系（引用 Ch 4）
//   Section 9.3: Smooth Maps and Diffeomorphisms (光滑映射与微分同胚)
//   Section 9.4: Rank Theorem (秩定理)

// --- Chapter 10: Tangent and Cotangent Spaces (切空间与余切空间) ---

//   Section 10.1: Tangent Vectors and Tangent Spaces (切向量与切空间)
//     - 导子定义；切空间维数与基；与 Ch 4 切平面的对应
//   Section 10.2: The Differential (微分)
//     - dF: T_pM -> T_F(p)N；链式法则
//   Section 10.3: Cotangent Space and Vector Bundles (余切空间与向量丛)
//     - 余切向量、对偶性；切丛/余切丛简介

// --- Chapter 11: Vector Fields and Flows (向量场与流) ---

//   Section 11.1: Vector Fields (向量场)
//     - 向量场定义、C^oo 向量场
//   Section 11.2: Flows and the Lie Bracket (流与李括号)
//     - 积分曲线、流、李括号、可交换流
//   Section 11.3: Partitions of Unity (分割单位)
//     - 存在性与流形上的逼近工具

// --- Chapter 12: Submanifolds and Embeddings (子流形与嵌入) ---

//   Section 12.1: Immersions and Embeddings (浸入与嵌入)
//     - 定义与例子（正则曲面是嵌入子流形）；嵌入与浸入的区别
//   Section 12.2: Regular Values and Sard's Theorem (正则值与 Sard 定理)
//     - 正则值定理；Sard 定理（陈述）
//   Section 12.3: Whitney Embedding Theorem (Whitney 嵌入定理)
//     - 陈述与意义；乘积流形

#part("Smooth Manifolds") // 光滑流形

// ==========================================================================
// Part IV — Tensors, Differential Forms and Riemannian Geometry
// (张量、微分形式与黎曼几何)
// ==========================================================================
// 设计思路：在流形上建立"结构层"：张量（线性代数）、微分形式（微积分）、
// 黎曼度量与联络（几何）、李群（对称性）。Rⁿ 中的楔积/外微分/Stokes 基础
// 引用数学分析 chap15，本笔记写流形上的推广（拉回、流形 Stokes、de Rham）。
// 黎曼几何与李群定位为桥梁导论，深入留给未来专门笔记。
// 对应教材：Lee Ch 8-16（张量/形式/积分）；Lee Ch 4, 15, 21（黎曼/李群导论）。

// --- Chapter 13: Tensors and Tensor Fields (张量与张量场) ---

//   Section 13.1: Multilinear Algebra (多重线性代数)
//     - 张量积、对偶空间、对称/反对称（自带基础；Algèbre Abstraite 无张量理论）
//   Section 13.2: Tensor Fields (张量场)
//     - 张量丛截面、缩并与迹；例子：度量张量（对应第一基本形式，引用 Ch 5）
//   Section 13.3: Riemannian Metrics (黎曼度量)
//     - 内积场、切空间上的度量；与第一基本形式的对应

// --- Chapter 14: Differential Forms (微分形式) ---

//   Section 14.1: Exterior Algebra (外代数)
//     - 楔积、反对称性（引用数学分析 chap15 §15.2）
//   Section 14.2: Differential Forms on Manifolds (流形上的形式)
//     - 余切丛的反对称幂；拉回 f^*ω
//   Section 14.3: Exterior Differentiation (外微分)
//     - 外微分（引用数学分析性质：线性/Leibniz/幂零）；Poincaré 引理

// --- Chapter 15: Integration and de Rham Cohomology (积分与 de Rham 上同调) ---

//   Section 15.1: Orientability (可定向性)
//     - 定向流形；与定向曲面（引用数学分析 chap14 §14.5）的衔接
//   Section 15.2: Integration of Forms and Stokes' Theorem (形式积分与 Stokes 定理)
//     - 支撑在坐标邻域的形式积分；流形上的 Stokes（推广数学分析 chap15 §15.4）
//   Section 15.3: de Rham Cohomology (de Rham 上同调)
//     - 闭/恰当（引用数学分析 chap15 §15.5）；de Rham 上同调群、Betti 数
//     - 与 Topologie Algébrique 同调理论的联系

// --- Chapter 16: Connections and Curvature (联络与曲率) ---

//   Section 16.1: Affine Connections (仿射联络)
//     - Koszul 联络定义、Christoffel 符号
//   Section 16.2: Levi-Civita Connection (Levi-Civita 联络)
//     - 相容性与无挠；与 Ch 7 平行移动的衔接
//   Section 16.3: Geodesics and the Exponential Map (测地线与指数映射)
//     - 测地线方程（衔接 Ch 7 测地线）；指数映射
//   Section 16.4: Curvature Tensor (曲率张量)
//     - 黎曼曲率张量、截面曲率/Ricci/标量曲率
//     - Hopf-Rinow 定理（陈述）；Cartan-Hadamard（陈述）

// --- Chapter 17: Lie Groups (李群) ---

//   Section 17.1: Lie Groups and Lie Algebras (李群与李代数)
//     - 定义、例子（GL(n)、SO(n) 等）；李代数与李括号
//     - 群论基础引用 Algèbre Abstraite
//   Section 17.2: Exponential Map and One-Parameter Subgroups (指数映射与单参数子群)
//   Section 17.3: Group Actions and Homogeneous Spaces (群作用与齐性空间)
//     - 李群作用、轨道、齐性空间；与对称性的应用联系

#part("Tensors, Differential Forms and Riemannian Geometry") // 张量、微分形式与黎曼几何

// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循"一维 → 二维 → n 维抽象 → 流形上的结构"的对象递进主线，
// 共 4 Part、17 Chapter。
//
// Part I（Ch 1–3，古典曲线论）：一维对象（曲线）的局部与整体理论。
//   数学分析已给曲线曲率 κ 与密切圆定义（chap14），此处发展完整的
//   Frenet-Serret 理论、局部标准形与曲线论基本定理，以旋转指标、
//   四顶点定理与等周不等式收束。
//
// Part II（Ch 4–8，古典曲面论）：二维对象从局部到整体的一条完整线。
//   第一/第二基本形式、Gauß 映射、Weingarten、法曲率的定义引用数学分析
//   chap14（积分工具级），本笔记深化主曲率分类、Euler 公式、绝妙定理、
//   测地线与平行移动，并以整体 Gauss-Bonnet 与紧致曲面分类收束。
//
// Part III（Ch 9–12，光滑流形）：对象抽象化为 n 维。图册与光滑结构、
//   切空间、向量场与流、子流形与嵌入——现代微分几何语言。
//
// Part IV（Ch 13–17，流形上的结构与几何）：在流形上建立结构层——
//   张量（多重线性代数，自带基础）、微分形式（Rⁿ 基础引用数学分析
//   chap15，本笔记写拉回/流形 Stokes/de Rham）、黎曼联络与曲率、
//   李群导论。黎曼几何与李群定位为桥梁，深入留给未来专门笔记。
//
// 教材覆盖：do Carmo《Differential Geometry of Curves and Surfaces》
//   （曲线与曲面古典理论全部知识点）与 Lee《Introduction to Smooth
//   Manifolds》（流形与流形上微积分）均已覆盖；黎曼几何与李群按导论
//   处理。数学分析（Analyse Mathématique）Part 4 为引用基线。
// ==========================================================================

#bibliography("references.bib")

// 目录
