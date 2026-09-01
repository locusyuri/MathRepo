#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Probabilités", // 概率论
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Probabilités", // 概率论
  "Violet",
  subtitle: "A notebook for probability",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This is a notebook for probability.",
)

#make-outline(depth: 2, title: "Contents")

#part("Fundamentals of Probability")
= Random Events and Probability // 随机事件与概率


// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
//
// 教材基准：茆诗松《概率论与数理统计教程》全部知识点
// 补充内容：指数族、Basu 定理、Delta 方法、多元正态、多元线性回归、
//           双因素方差分析、核密度估计、随机过程初步等
//
// 主线：概率论（公理→随机变量→极限定理）
//       → 数理统计（抽样→估计→检验→回归）
//       → 应用拓展
//
// 职责边界：
//   - 测度论 / σ-代数构造 → Théorie des Ensembles
//   - Lebesgue 积分理论  → Analyse Réelle
//   - Fourier 分析工具    → Processus Stochastique
//   - 随机过程深入理论    → Processus Stochastique
//
// ==========================================================================


// ==========================================================================
// Part I — 概率论基础 (Fundamentals of Probability)
// ==========================================================================
// 设计思路：从随机现象的数学建模出发，建立 Kolmogorov 公理框架，
// 再发展条件概率与独立性理论。这是整个概率论的地基。
// 对应教材：第一章 §1.1–§1.5

// --- Chapter 1: 随机事件与概率 (Random Events and Probability) ---

//   Section 1.1: 随机事件及其运算 (Random Events and Operations)
//     - 随机现象与随机试验
//     - 样本空间 (Sample Space)
//     - 随机事件与事件域 (Event Space / σ-field of Events)
//     - 事件间的关系（包含、相等、互斥、对立）
//     - 事件间的运算（并、交、差、De Morgan 律）
//     - 随机变量的直观引入

//   Section 1.2: 概率的定义 (Definitions of Probability)
//     - 概率的公理化定义 (Kolmogorov Axioms)
//     - 频率方法与频率的稳定性
//     - 古典概型 (Classical Probability)
//     - 几何概型 (Geometric Probability)
//     - 主观概率 (Subjective Probability)
//     - 注：σ-代数的深入构造参见 Théorie des Ensembles

//   Section 1.3: 概率的性质 (Properties of Probability)
//     - 概率的可加性 (Additivity)
//     - 概率的单调性 (Monotonicity)
//     - 加法公式 (Addition Formula)
//     - 概率的连续性 (Continuity of Probability)
//     - Borel-Cantelli 引理

//   Section 1.4: 组合方法 (Combinatorial Methods)
//     - 排列与组合公式
//     - 计数原理与经典概率计算
//     - 容斥原理
//     - 经典模型：配对问题、Polya 罐子模型


// --- Chapter 2: 条件概率与独立性 (Conditional Probability and Independence) ---

//   Section 2.1: 条件概率 (Conditional Probability)
//     - 条件概率的定义
//     - 乘法公式 (Multiplication Rule)

//   Section 2.2: 全概率公式与 Bayes 公式 (Total Probability and Bayes' Theorem)
//     - 样本空间的划分
//     - 全概率公式
//     - Bayes 公式及其统计诠释

//   Section 2.3: 独立性 (Independence)
//     - 两个事件的独立性
//     - 多个事件的相互独立性
//     - 试验的独立性
//     - 独立试验与 Bernoulli 概型


// ==========================================================================
// Part II — 随机变量及其分布 (Random Variables and Distributions)
// ==========================================================================
// 设计思路：从一维到多维，从分布函数到具体分布族，再到随机变量函数的分布。
// 建立完整的分布理论，为后续数字特征和统计推断提供对象。
// 对应教材：第二章 §2.1–§2.7 + 第三章 §3.1–§3.5

// --- Chapter 3: 一维随机变量及其分布 (Univariate Random Variables and Distributions) ---

//   Section 3.1: 随机变量及其分布 (Random Variables and Their Distributions)
//     - 随机变量的概念
//     - 分布函数 (CDF)：定义与基本性质
//     - 离散型随机变量与分布列 (PMF)
//     - 连续型随机变量与密度函数 (PDF)

//   Section 3.2: 常用离散分布 (Common Discrete Distributions)
//     - Bernoulli 分布
//     - 二项分布 (Binomial)
//     - Poisson 分布
//     - 超几何分布 (Hypergeometric)
//     - 几何分布与负二项分布 (Geometric & Negative Binomial)
//     - 各分布的背景模型与相互关系

//   Section 3.3: 常用连续分布 (Common Continuous Distributions)
//     - 正态分布 (Normal)
//     - 均匀分布 (Uniform)
//     - 指数分布 (Exponential)
//     - Gamma 分布
//     - Beta 分布
//     - 连续分布的核 (Kernel of a Distribution)
//     - 各分布的性质与相互关系

//   Section 3.4: 随机变量函数的分布 (Distributions of Functions of RVs)
//     - 离散型随机变量函数的分布
//     - 连续型随机变量函数的分布


// --- Chapter 4: 多维随机变量及其分布 (Multivariate Random Variables and Distributions) ---

//   Section 4.1: 联合分布 (Joint Distributions)
//     - 多维随机变量
//     - 联合分布函数
//     - 联合分布列 / 联合密度函数
//     - 常用多维分布（多元均匀分布、多元正态分布等）

//   Section 4.2: 边缘分布与独立性 (Marginal Distributions and Independence)
//     - 边缘分布函数
//     - 边缘分布列 / 边缘密度函数
//     - 随机变量间的独立性

//   Section 4.3: 随机变量函数的分布 (Distributions of Functions of RVs)
//     - 多维离散随机变量函数的分布
//     - 最大值与最小值的分布
//     - 卷积公式 (Convolution Formula)
//     - 变量变换法 (Jacobian Method)

//   Section 4.4: 条件分布与条件期望 (Conditional Distributions and Expectation)
//     - 条件分布
//     - 条件数学期望
//     - 全期望公式与全方差公式


// --- Chapter 5: 分布的特征与分类 (Characterization and Classification of Distributions) ---
// 设计思路：补充教材之外的结构性内容——指数族是连接经典分布与现代统计推断的桥梁，
// 多元正态是多元统计的基础。

//   Section 5.1: 指数族 (Exponential Family)
//     - 自然参数与充分统计量的联系
//     - 自然参数空间

//   Section 5.2: 多元正态分布 (Multivariate Normal Distribution)
//     - 定义与性质
//     - 线性变换下的不变性


// ==========================================================================
// Part III — 数字特征与生成工具 (Numerical Characteristics and Generating Tools)
// ==========================================================================
// 设计思路：用数字特征刻画分布，用生成函数提供统一分析工具。
// 特征函数在 Part IV 的极限定理中扮演关键角色（证明 CLT）。
// 对应教材：§2.2–§2.3（期望/方差/不等式）、§2.7（其他特征数）、
//           §3.4（协方差/相关系数）、§4.2（特征函数）

// --- Chapter 6: 数字特征 (Numerical Characteristics) ---

//   Section 6.1: 数学期望 (Mathematical Expectation)
//     - 定义（离散 / 连续）
//     - 性质与运算规则
//     - 马尔可夫不等式 (Markov's Inequality)

//   Section 6.2: 方差与标准差 (Variance and Standard Deviation)
//     - 定义与性质
//     - 切比雪夫不等式 (Chebyshev's Inequality)

//   Section 6.3: 协方差与相关系数 (Covariance and Correlation)
//     - 协方差的定义与性质
//     - 相关系数；不相关与独立的关系
//     - 随机向量的期望向量与协方差矩阵

//   Section 6.4: 分布的其他特征数 (Other Characterization Numbers)
//     - k 阶矩与中心矩
//     - 变异系数 (Coefficient of Variation)
//     - 分位数与中位数 (Quantiles and Median)
//     - 偏度系数 (Skewness)
//     - 峰度系数 (Kurtosis)


// --- Chapter 7: 生成函数与变换方法 (Generating Functions and Transform Methods) ---

//   Section 7.1: 矩母函数 (Moment Generating Functions)
//     - 定义与性质
//     - 唯一性定理

//   Section 7.2: 特征函数 (Characteristic Functions)
//     - 定义与基本性质
//     - 反转公式
//     - 连续性定理
//     - 注：Fourier 分析工具详见 Processus Stochastique

//   Section 7.3: 概率生成函数 (Probability Generating Functions)
//     - 离散情形
//     - 复合分布的应用


// ==========================================================================
// Part IV — 极限定理 (Limit Theorems)
// ==========================================================================
// 设计思路：概率论的理论高峰——从收敛模式到大数定律和中心极限定理，
// 为统计推断的渐近理论提供保证。特征函数在此部分用于证明 CLT。
// 对应教材：第四章 §4.1–§4.4

// --- Chapter 8: 大数定律与中心极限定理 (LLN and CLT) ---

//   Section 8.1: 收敛概念 (Concepts of Convergence)
//     - 依概率收敛
//     - 依分布收敛 / 弱收敛
//     - 几乎必然收敛
//     - L^p 收敛
//     - 各收敛模式之间的关系

//   Section 8.2: 大数定律 (Laws of Large Numbers)
//     - Bernoulli 大数定律
//     - Chebyshev 大数定律
//     - Khinchin 大数定律
//     - Kolmogorov 强大数定律

//   Section 8.3: 中心极限定理 (Central Limit Theorem)
//     - 独立同分布情形 (Lindeberg-Lévy CLT)
//     - 二项分布的正态近似 (De Moivre-Laplace)
//     - 独立不同分布情形 (Lindeberg / Lyapunov 条件)
//     - CLT 的应用与近似计算

//   Section 8.4: Delta 方法 (Delta Method)
//     - 一阶 Delta 方法
//     - 在统计量渐近分布中的应用


// ==========================================================================
// Part V — 数理统计基础 (Fundamentals of Mathematical Statistics)
// ==========================================================================
// 设计思路：从概率论过渡到数理统计——数据如何产生（抽样）、
// 如何压缩信息（充分统计量）。这是从"已知模型推数据"到"从数据推模型"的转折。
// 对应教材：第五章 §5.1–§5.5

// --- Chapter 9: 抽样与经验分布 (Sampling and Empirical Distributions) ---

//   Section 9.1: 总体与样本 (Population and Samples)
//     - 总体与个体
//     - 样本与统计量
//     - 经验分布函数 (Empirical Distribution Function)
//     - Glivenko-Cantelli 定理

//   Section 9.2: 样本矩与抽样分布 (Sample Moments and Sampling Distributions)
//     - 统计量与抽样分布的概念
//     - 样本均值及其抽样分布
//     - 样本方差与样本标准差
//     - 样本矩及其函数
//     - 蒙特卡罗方法 (Monte Carlo Methods)

//   Section 9.3: 次序统计量 (Order Statistics)
//     - 次序统计量的概念
//     - 单个次序统计量的分布
//     - 多个次序统计量及其函数的分布
//     - 样本中位数与样本分位数
//     - 五数概括 (Five-Number Summary) 与箱线图 (Box Plot)

//   Section 9.4: 三大抽样分布 (Three Major Sampling Distributions)
//     - χ² 分布 (Chi-Squared)：定义、性质、分位数
//     - t 分布 (Student's t)：定义、性质、分位数
//     - F 分布 (Fisher's F)：定义、性质、分位数

//   Section 9.5: 正态总体下的抽样分布 (Sampling Distributions under Normality)
//     - X̄ 与 S² 的独立性
//     - 基于正态总体的经典抽样分布结论


// --- Chapter 10: 充分统计量 (Sufficient Statistics) ---

//   Section 10.1: 充分性的概念 (Concept of Sufficiency)

//   Section 10.2: 因子分解定理 (Factorization Theorem)

//   Section 10.3: 完备统计量 (Complete Statistics)
//     - 完备性定义
//     - Bahadur 定理

//   Section 10.4: Ancillary 统计量与 Basu 定理 (Ancillary Statistics and Basu's Theorem)


// ==========================================================================
// Part VI — 参数估计 (Parametric Estimation)
// ==========================================================================
// 设计思路：点估计的方法→评价→改进→区间估计，构成参数估计的完整链条。
// EM 算法和 MLE 渐近正态性是现代计算与理论的重要补充。
// 对应教材：第六章 §6.1–§6.6

// --- Chapter 11: 点估计方法 (Methods of Point Estimation) ---

//   Section 11.1: 矩估计法 (Method of Moments)
//     - 替换原理
//     - 概率函数已知时的矩估计

//   Section 11.2: 极大似然估计法 (Maximum Likelihood Estimation)
//     - 似然函数与 MLE
//     - EM 算法 (EM Algorithm)
//     - MLE 的渐近正态性 (Asymptotic Normality)
//     - MLE 的不变性原理

//   Section 11.3: 最小二乘法 (Least Squares Method)

//   Section 11.4: Bayes 估计 (Bayesian Estimation)
//     - 统计推断的贝叶斯范式
//     - 先验分布的选择与共轭先验族
//     - 后验分布的密度函数形式


// --- Chapter 12: 估计的评价与改进 (Evaluation and Improvement of Estimators) ---

//   Section 12.1: 无偏性 (Unbiasedness)

//   Section 12.2: 有效性与 Cramér-Rao 不等式 (Efficiency and Cramér-Rao Inequality)
//     - Fisher 信息量
//     - Cramér-Rao 下界的推导与等号成立条件

//   Section 12.3: 一致性 / 相合性 (Consistency)
//     - 弱一致性与强一致性
//     - 矩估计与 MLE 的相合性

//   Section 12.4: 均方误差 (Mean Squared Error)

//   Section 12.5: 一致最小方差无偏估计 (UMVUE)
//     - 充分性原则
//     - Rao-Blackwell 定理
//     - Lehmann-Scheffé 定理（基于完备充分统计量）


// --- Chapter 13: 区间估计 (Interval Estimation) ---

//   Section 13.1: 置信区间的概念 (Concept of Confidence Intervals)
//     - 置信水平与频率诠释
//     - 枢轴量法 (Pivotal Quantity Method)

//   Section 13.2: 单个正态总体参数的置信区间 (CIs for Single Normal Population)
//     - μ 的置信区间（σ 已知 / σ 未知）
//     - σ² 的置信区间

//   Section 13.3: 两个正态总体参数的置信区间 (CIs for Two Normal Populations)
//     - μ₁ - μ₂ 的置信区间（含配对样本）
//     - σ₁² / σ₂² 的置信区间

//   Section 13.4: 大样本置信区间 (Large-Sample CIs)

//   Section 13.5: 样本量的确定 (Sample Size Determination)


// ==========================================================================
// Part VII — 假设检验 (Hypothesis Testing)
// ==========================================================================
// 设计思路：从基本思想到具体检验，再到拟合优度与非参数方法。
// 假设检验与置信区间的对偶性是重要的统一视角。
// 对应教材：第七章 §7.1–§7.6

// --- Chapter 14: 假设检验的理论与方法 (Theory and Methods of Hypothesis Testing) ---

//   Section 14.1: 假设检验的基本概念 (Basic Concepts)
//     - 假设检验问题与基本步骤
//     - 第一类错误与第二类错误
//     - P 值 (P-value)

//   Section 14.2: Neyman-Pearson 范式 (Neyman-Pearson Paradigm)
//     - 功效函数 (Power Function)
//     - Neyman-Pearson 引理

//   Section 14.3: 似然比检验 (Likelihood Ratio Tests)
//     - 广义似然比检验的思想

//   Section 14.4: 正态总体参数的假设检验 (Tests for Normal Population Parameters)
//     - 单个正态总体均值的检验（Z 检验、t 检验）
//     - 两个正态总体均值差的检验（含成对数据检验）
//     - 正态总体方差的检验（χ² 检验、F 检验）

//   Section 14.5: 假设检验与置信区间的对偶性 (Duality of Tests and CIs)

//   Section 14.6: 其他分布参数的假设检验 (Tests for Other Distribution Parameters)
//     - 指数分布参数的检验
//     - 比率 p 的检验
//     - 大样本检验


// --- Chapter 15: 拟合检验与非参数检验 (Goodness-of-Fit and Nonparametric Tests) ---

//   Section 15.1: 正态性检验 (Normality Tests)
//     - 正态概率纸 (Normal Probability Paper)
//     - W 检验 (Shapiro-Wilk Test)
//     - EP 检验 (Epstein Test)

//   Section 15.2: χ² 拟合优度与独立性检验 (Chi-Squared Tests)
//     - 分类数据的 χ² 拟合优度检验
//     - 分布的 χ² 拟合优度检验
//     - 列联表的独立性检验

//   Section 15.3: 方差齐性检验 (Tests for Homogeneity of Variances)
//     - Hartley 检验
//     - Bartlett 检验
//     - 修正的 Bartlett 检验

//   Section 15.4: 非参数检验 (Nonparametric Tests)
//     - 游程检验 (Runs Test)
//     - 符号检验 (Sign Test)
//     - Wilcoxon 秩和检验 (Wilcoxon Rank-Sum Test)
//     - Mann-Whitney U 检验


// ==========================================================================
// Part VIII — 方差分析与回归分析 (ANOVA and Regression Analysis)
// ==========================================================================
// 设计思路：统计推断在组间比较与变量关系建模中的核心应用。
// 方差分析本质上是线性模型的特例，两者统一于最小二乘框架。
// 对应教材：第八章 §8.1–§8.5

// --- Chapter 16: 方差分析 (Analysis of Variance) ---

//   Section 16.1: 单因素方差分析 (One-Way ANOVA)
//     - 统计模型
//     - 平方和分解
//     - F 检验
//     - 参数估计
//     - 重复数不等的情形

//   Section 16.2: 多重比较 (Multiple Comparisons)
//     - 水平均值差的置信区间
//     - 重复数相等时的 T 法 (Tukey HSD)
//     - 重复数不等时的 S 法 (Scheffé)

//   Section 16.3: 方差齐性检验 (Tests for Homogeneity of Variances)
//     - Hartley 检验、Bartlett 检验
//     - 与 §15.3 的联系与区别

//   Section 16.4: 双因素方差分析 (Two-Way ANOVA)
//     - 无交互作用模型
//     - 有交互作用模型


// --- Chapter 17: 回归分析 (Regression Analysis) ---

//   Section 17.1: 一元线性回归 (Simple Linear Regression)
//     - 变量间的两类关系
//     - 回归模型与最小二乘估计
//     - 回归方程的显著性检验
//     - 估计与预测

//   Section 17.2: 一元非线性回归 (Simple Nonlinear Regression)
//     - 确定可能的函数形式
//     - 参数估计（线性化方法）
//     - 曲线回归方程的比较

//   Section 17.3: 多元线性回归 (Multiple Linear Regression)
//     - 矩阵表示
//     - 参数估计与统计推断

//   Section 17.4: 回归诊断 (Regression Diagnostics)
//     - 拟合优度 R²
//     - 残差分析


// ==========================================================================
// Part IX — 拓展专题 (Advanced Topics)
// ==========================================================================
// 设计思路：从独立随机变量到相依随机过程的自然延伸，
// 为后续深入学习 Processus Stochastique 搭建桥梁。
// 本部分仅作导论，深入理论参见 Processus Stochastique 笔记。

// --- Chapter 18: 随机过程初步 (Introduction to Stochastic Processes) ---

//   Section 18.1: 随机过程的定义与分类 (Definition and Classification)
//     - 有限维分布；平稳性；独立增量

//   Section 18.2: 离散时间 Markov 链 (Discrete-Time Markov Chains)
//     - 转移概率矩阵；状态分类；平稳分布

//   Section 18.3: Poisson 过程 (Poisson Processes)
//     - 定义与性质；到达时间间隔

//   Section 18.4: 连续时间 Markov 链初步 (Introduction to CTMCs)

//   Section 18.5: Brown 运动初步 (Introduction to Brownian Motion)


// ==========================================================================
// Appendix
// ==========================================================================
// 设计思路：统计分布表供查表使用（对应教材附表），
// Glossary 按字母顺序索引所有定义标签，与仓库其他笔记格式一致。

// --- 统计分布表 (Statistical Distribution Tables) ---
//   - Poisson 分布函数表
//   - 标准正态分布函数表
//   - χ² 分布分位数表
//   - t 分布分位数表
//   - F 分布分位数表
//   - 正态性检验统计量 W 的系数与分位数表
//   - 非参数检验临界值表（游程、Wilcoxon 等）

// --- Glossary ---


// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循"概率论 → 数理统计 → 应用拓展"的三段式主线，共 9 Part、18 Chapter。
//
// Part I–IV（概率论，Ch 1–8）：从公理化的概率空间出发，经随机变量与分布
// （一维→多维）、数字特征与生成函数，到极限定理——构成概率论的完整理论框架。
//
// Part V（过渡，Ch 9–10）：抽样分布与充分统计量是连接概率论与统计推断的桥梁，
// 从"已知模型推数据"转向"从数据推模型"。
//
// Part VI–VIII（数理统计，Ch 11–17）：参数估计（方法→评价→改进→区间）→
// 假设检验（理论→具体检验→拟合/非参数）→ 方差分析与回归分析。
//
// Part IX（拓展，Ch 18）：随机过程初步作为概率论的自然延伸，
// 为后续 Processus Stochastique 笔记做铺垫。
//
// 教材覆盖：茆诗松《概率论与数理统计教程》全部 8 章知识点均已覆盖。
// ==========================================================================


#bibliography("references.bib")

// 目录

