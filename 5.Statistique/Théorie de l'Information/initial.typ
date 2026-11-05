#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Théorie de l'Information",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Théorie de l'Information",
  "Violet",
  subtitle: "A notebook for information theory",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.1.0",
  extra-info: "From Shannon's two limits to algebraic and modern codes.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
// 主线：信息度量 → 编码极限 → 代数构造 → 网络与接口。
// 四段主线对应 5 个 Part（"编码极限"占 Part II、III 两个 Part），
// 共 15 Chapter、74 Section；另设附录（术语表）。
//
// 职责边界：
//   - σ-代数、集合运算、关系与映射 → Théorie des Ensembles（交叉引用）
//   - 概率空间、随机变量、期望、条件期望、Markov 链基础 → Probabilités
//     （交叉引用；Ch 3 的熵率直接使用其结论，不重述）
//   - 测度论、Lebesgue 积分、L^p 空间 → Analyse Réelle（交叉引用；§2.3
//     的微分熵只在绝对连续分布下定义，不重述积分理论）
//   - Fourier 变换、抽样定理、FFT → Analyse Harmonique（交叉引用；§9.3
//     的带限信道只引用抽样定理的结论）
//   - 随机过程的构造、鞅、Itô 积分 → Processus Stochastique（交叉引用；
//     Ch 3 仅处理熵率，不展开过程理论）
//   - 群、环、域的一般理论与多项式环 → Algèbre Abstraite（交叉引用；§10.1
//     回指其 Ch 13 §13.3「有限域」的存在唯一性、乘法群循环性与 Frobenius，
//     但本原多项式、最小多项式与 BCH 根集由 §10.1 自含——AA §13.3 不含这些）
//   - 矩阵的秩、线性方程组、SVD → Algèbre Linéaire（交叉引用；§10.2 的
//     生成矩阵与校验矩阵只讨论编码结构）
//   - 图论基本概念（图、树、流、割）→ Théorie des Graphes（交叉引用；该笔记
//     目前尚未在仓库中建立，§3.2、§13.5 只借用术语与结论，不重述图论）
//   - 组合计数方法（容斥、双计数、生成函数）→ Combinatoire（交叉引用；
//     §4.3 的类型计数只用到初等计数）
//   - 热力学熵、Gibbs 熵、Landauer 原理 → Thermodynamique（交叉引用；
//     §2.4 与 §3.3 只在概念上对照，不重述热力学）
//   - 光学信息量、光量子信道容量（傅祖芸 第 12 章）→ Optique 与
//     Mécanique quantique（不纳入；涉及量子光学与光子统计）
//   - 生命科学、医学信息分析（傅祖芸 第 12 章）→ 不纳入（非数学内容）
//   - von Neumann 熵、量子信道、Holevo 界、QKD → Mécanique quantique
//     §13.4（不纳入；本笔记保持经典 Shannon 体系）
//   - Kolmogorov 复杂度、算法随机性 → 不纳入（本笔记不建立可计算性基础；
//     §15.4 只使用 MDL 的信息论表述。仓库内亦无承载该主题的笔记，
//     因此不写成"归 XX"，避免制造空头承诺）
//
// 设计决策：
//   - Ch 4 独立于 Ch 3：熵率刻画"信源在时间上的渐近性质"，AEP 与类型方法
//     刻画"单次观测的典型性"，后者是两个编码定理共用的工具；按"工具先行"
//     把 AEP 放在 Part II 开头，而不是紧跟熵的定义
//   - AEP 的正本在 §4.1（DMS 情形）：§2.3 的典型体积、§3.3 的
//     Shannon–McMillan–Breiman、§8.1 的联合典型都只是回指 §4.1 的同一
//     论证骨架，各自只补"连续 / 平稳 / 多变量"的差异，不重证
//   - Ch 2 前移微分熵（C&T 第 8 章）与最大熵（C&T 第 12 章）：Part I 必须
//     同时给出离散与连续两套度量，否则 Ch 9 要跨 Part 引用；最大熵是度量层
//     的收官原理，与微分熵同章可避免概念往返。本章 §2.1–2.2（离散散度）与
//     §2.3–2.5（连续化）以 KL 为纽带：连续熵是离散熵在量化步长 → 0 时的
//     极限，故不拆章，改由本章标题如实反映两个主题
//   - Ch 7 与 Ch 8 拆分：容量是信道本身的优化问题，编码定理是可达性证明；
//     合并会使"容量计算"与"随机编码"两条论证线互相打断
//   - Ch 9 的衰落与 MIMO（§9.5）超出两本基线（傅祖芸止于限带高斯信道），
//     作为现代扩展保留，只给容量结论，不展开信道估计与预编码
//   - Part IV 独立成编：C&T 仅在 §7.11 提 Hamming 码，傅祖芸第 9 章系统讲
//     线性/循环/卷积码；按"极限（Part III）→ 构造（Part IV）"分编，并在
//     §10.1 回指 Algèbre Abstraite §13.3 的有限域结论，本原多项式与最小多项式
//     自含
//   - §12.3–12.5（Turbo/LDPC/Polar）超出两本基线，作为现代构造导论保留；
//     密度进化、极化理论的完整证明不在本笔记范围
//   - §5.6 合并 C&T 第 6 章（赌博）与第 16 章（投资组合）：两者是"熵 =
//     最优对数增长率"的同一数学事实，合并为一节，避免为应用单开一章
//   - Ch 15 合并 C&T 第 11 章（统计）与 MacKay 的推断/学习内容：两者都以
//     类型与散度为语言，是同一接口的经典侧与学习侧
//   - 量子信息不纳入：von Neumann 熵已由 Mécanique quantique 蓝图 §13.4
//     占位，按 SRP 只交叉引用；傅祖芸第 13 章亦仅"简介"
//   - 傅祖芸第 12 章（跨学科）不设专章：热力学/光学部分以交叉引用处理，
//     生命科学部分超出数学笔记范围
//   - §7.6 与 §8.5 的分工：分离定理的严格证明要用 Fano 不等式，故归 §8.5；
//     §7.6 只讲"匹配与失配代价"（率失真视角），避免两处重复陈述同一定理
//   - §9.1 与 §9.2 的分工：§9.1 只做高斯信道的可达性（编码 + 功率约束的
//     反向检验），§9.2 专做逆定理（EPI + 高斯为最坏噪声），使 §2.5 的熵
//     功率不等式在此获得唯一回收点
//   - Ch 11 由三节并为两节：原 §11.1–11.2 都在讲生成/校验多项式的表示，与
//     §11.3 的"编解码实现"才构成真正的分界；合并后为"结构 / 实现"两节，
//     BCH 与 RS 顺次前移
//   - §15.3 新增 Fisher 信息与估计界：C&T 第 11 章含 Fisher 信息与
//     Cramér–Rao 型不等式，原目录无落点；且 Part V 号称"为统计笔记搭桥"，
//     估计理论比 ELBO 更基础，故独立成节（原 §15.3–15.5 依次后移）
//
// 教材基线：Cover & Thomas《Elements of Information Theory》第 2 版
//   （Wiley, 2006）17 章 + 傅祖芸《信息论——基础理论与应用》第 4 版
//   （电子工业出版社, 2015）13 章的知识点并集；MacKay《Information Theory,
//   Inference, and Learning Algorithms》（Cambridge, 2003）作为推断/学习
//   接口的补充来源，不单独设章。组织顺序独立于教材。
//
// 教材覆盖度（章节级映射，按 C&T 第 2 版章号）：
//   C&T  1 → Ch 1 §1.1              C&T 10 → Ch 6
//   C&T  2 → Ch 1 §1.2–1.5, Ch 2 §2.1   C&T 11 → Ch 4 §4.3, Ch 15 §15.1–15.3
//   C&T  3 → Ch 4 §4.1–4.2          C&T 12 → Ch 2 §2.4
//   C&T  4 → Ch 3                   C&T 13 → Ch 5 §5.5
//   C&T  5 → Ch 5 §5.1–5.4          C&T 14 → 不纳入（不建立可计算性基础）
//   C&T  6 → Ch 5 §5.6, Ch 3 §3.4   C&T 15 → Ch 13
//   C&T  7 → Ch 7, Ch 8             C&T 16 → Ch 5 §5.6
//   C&T  8 → Ch 2 §2.3              C&T 17 → Ch 1 §1.4, Ch 2 §2.2
//   C&T  9 → Ch 9
//
//   章号说明：第 2 版以 Ch 1「Introduction and Preview」开篇，故 Ch 4 为
//   Entropy Rates、Ch 6 为 Gambling（内含 §6.4 The Entropy of English）。
//   逐节映射（到 C&T 的 §x.y 与傅祖芸的 §x.y 一级）在每章写作时同步追加到
//   本块下方，保持"覆盖度可在仓库内复核"；不再指向仓库外的交付说明。
//
//   傅 1 → Ch 1 §1.1    傅 6 → Ch 8     傅 11 → Ch 14
//   傅 2 → Ch 1, Ch 3   傅 7 → Ch 6（另见 §8.5）   傅 12 → §2.4（最大熵部分）；其余交叉引用
//   傅 3 → Ch 7         傅 8 → Ch 5     傅 13 → 不纳入（Mécanique quantique）
//   傅 4 → Ch 2, Ch 9   傅 9 → Ch 10–12
//   傅 5 → Ch 4, Ch 5   傅 10 → Ch 13
// ==========================================================================


// ==========================================================================
// Part I — Information Measures (信息度量)
// ==========================================================================
// 设计思路：本 Part 回答 Shannon 的第一问"信息量如何度量"。Ch 1 从公理化
// 定义出发建立熵与互信息，并给出链式法则、数据处理不等式与 Fano 不等式
// 这套"信息不等式工具箱"；Ch 2 把度量从离散推广到连续（微分熵、KL、
// f-散度），并以最大熵原理收束，说明"熵最大"如何刻画分布族；Ch 3 把单变量
// 度量提升到过程层面（熵率），为 Part II 准备"每个符号需要多少比特"这个量。
// 对应教材：C&T 第 1、2、4、8、12、17 章；傅祖芸 第 1、2、4 章（4.1–4.5）。

// --- Chapter 1: Information, Uncertainty and the Axiomatic Foundation (信息、不确定性与公理化基础) ---

//   Section 1.1: Communication Systems and Shannon's Three Questions (通信系统与 Shannon 三问)
//     - 通信系统的五个部件；信源、编码器、信道、译码器、信宿
//     - 有效性与可靠性；压缩极限与传输极限
//     - 信息论与概率论、组合学、统计学的接口（总览，不展开）
//     - 全书路线图：度量 → 极限 → 构造 → 接口

//   Section 1.2: Axiomatic Definition of Entropy (熵的公理化定义)
//     - 自信息 I(x) = -log p(x)；底数的选择与单位（bit / nat）
//     - 熵的公理化刻画（连续性、对称性、极值性、可加性）
//     - 唯一性定理：满足公理的泛函只能是 H = -Σ p log p
//     - 基本性质：非负性、H(X) ≤ log|X|、等号条件
//     - 熵的推广：加权熵与意义信息（傅祖芸 第 2 章；Rényi 熵见 §2.1）

//   Section 1.3: Joint Entropy, Conditional Entropy and Mutual Information (联合熵、条件熵与互信息)
//     - 联合熵 H(X,Y) 与条件熵 H(X|Y)
//     - 互信息 I(X;Y) = H(X) - H(X|Y) = H(Y) - H(Y|X)
//     - 对称性与非负性；I(X;Y) = 0 ⇔ 独立
//     - Venn 图表示与常见误用（"互信息为负"的伪命题）

//   Section 1.4: Chain Rules and Information Inequalities (链式法则与信息不等式)
//     - 熵、相对熵、互信息的链式法则
//     - Jensen 不等式与 log-sum 不等式
//     - 次可加性、条件降低熵、数据处理不等式（DPI）
//     - 信息不等式的线性规划视角（C&T 第 17 章的入门部分）

//   Section 1.5: Data Processing, Sufficient Statistics and Fano's Inequality (数据处理、充分统计量与 Fano 不等式)
//     - 马尔可夫链 X → Y → Z 下的 DPI
//     - 充分统计量的信息论刻画
//     - Fano 不等式及其证明
//     - Fano 不等式的用途：逆定理、下界、错误概率与熵的关系


// --- Chapter 2: Divergences, Continuous Entropy and Maximum Entropy (散度、连续熵与最大熵原理) ---

//   Section 2.1: Relative Entropy, Cross Entropy and f-Divergences (相对熵、交叉熵与 f-散度)
//     - KL 散度 D(p||q)；交叉熵 H(p,q)
//     - 非负性与不对称性；KL 不是度量
//     - f-散度族（KL、总变差、χ²、Hellinger）；Rényi 熵与 Rényi 散度
//     - 与最大似然、交叉熵损失的联系（只给接口，详见 §15.5）

//   Section 2.2: Pinsker's Inequality and Variational Representations (Pinsker 不等式与变分表示)
//     - 总变差距离与 KL 的相互控制
//     - Pinsker 不等式；KL 的变分表示（D = sup_f E_P[f] - log E_Q[e^f]）
//     - 散度的数据处理不等式
//     - 散度与假设检验的关系（预告 §15.2）

//   Section 2.3: Differential Entropy and Its Properties (微分熵及其性质)
//     - 微分熵 h(X) = -∫ f log f；与离散熵的关系（量化极限）
//     - 联合/条件微分熵；相对熵与互信息的连续版本
//     - 典型体积与高概率集（连续 AEP；回指 §4.1 的正本，C&T 第 8 章）
//     - 平移不变性与尺度变换：h(aX) = h(X) + log|a|
//     - 线性变换下的微分熵：h(AX) = h(X) + log|det A|（傅祖芸 第 4 章的坐标变换）
//     - 微分熵可为负，它不是"比特数"（与离散熵的关键区别）

//   Section 2.4: The Principle of Maximum Entropy (最大熵原理)
//     - 约束下的最大熵：给定支撑、给定方差、给定均值
//     - 指数族是最大熵分布族（交叉引用 Probabilités Ch 7 的指数族）
//     - 最大熵与最大似然的对偶；Jaynes 解释及其边界
//     - 最大熵图像恢复（傅祖芸 第 12 章，只给结论）
//     - Burg 最大熵谱估计与 AR 模型（只给结论）

//   Section 2.5: Entropy Power and the Gaussian Bound (熵功率与高斯界)
//     - 熵功率 N(X) = exp(2h(X)) / (2πe)
//     - 高斯分布的最大微分熵定理
//     - 熵功率不等式（EPI）；与中心极限定理的类比
//     - 连续情形的"信息量"解释及其局限（交叉引用 Analyse Réelle）


// --- Chapter 3: Entropy Rates and Stationary Sources (熵率与平稳信源) ---

//   Section 3.1: Entropy Rate of a Stochastic Process (随机过程的熵率)
//     - 联合熵的次可加性；H(X) = lim H(X_1..X_n)/n 的存在性
//     - 平稳过程的熵率；与条件熵极限的等价（链式法则）
//     - 熵率作为"每符号信息量"的操作意义

//   Section 3.2: Markov Sources and Their Entropy Rate (Markov 信源与熵率)
//     - Markov 链的熵率 H(X|X_{n-1})；平稳分布下的计算公式
//     - m 阶 Markov 信源；状态图与转移矩阵（交叉引用 Probabilités Ch 9）
//     - 加权图上的随机游走熵率（C&T 第 4 章；与 Théorie des Graphes 交叉引用）
//     - 马尔可夫链的函数（隐藏 Markov 模型）：只给熵率定义与例子

//   Section 3.3: Asymptotic Equipartition for Stationary Sources (平稳信源的渐近均分性)
//     - 本节只补"平稳/遍历"相对 DMS 的差异；论证骨架回指 §4.1，不重证
//     - Shannon–McMillan–Breiman 定理（陈述，不证一般遍历情形）
//     - 典型序列的存在性与概率集中
//     - 经验熵与熵率的估计
//     - 与热力学第二定律的形式类比（交叉引用 Thermodynamique，不展开物理）

//   Section 3.4: Redundancy and the Entropy of Natural Language (剩余度与自然语言的熵)
//     - 剩余度 R = log|X| - H；冗余与可压缩性
//     - 自然语言的熵：Shannon 猜词实验（C&T §6.4；Shannon 1951 原始论文）
//     - 压缩与语言模型的关系（预告 §15.5 的交叉熵）
//     - 英文/中文熵估计的量级与结论（只给结论）


// ==========================================================================
// Part II — Source Coding: The Limit of Compression (信源编码：压缩的极限)
// ==========================================================================
// 设计思路：本 Part 回答"数据能压到多小"。Ch 4 建立 AEP 与类型方法，即
// "典型集只有约 2^{nH} 个元素"这一核心事实；Ch 5 把它变成无失真编码定理
// （H 是压缩极限），并给出从 Huffman 到 LZ 的可实现算法；Ch 6 把"无失真"
// 放宽为"允许失真"，得到率失真函数 R(D)。三者共同构成"有效性"一侧的完整理论。
// Ch 6 结束处与 Part III 的容量形成"率失真 ↔ 容量"的对偶，是后一 Part 的入口。
// 对应教材：C&T 第 3、5、6、10、11、13、16 章；傅祖芸 第 5、7、8 章。

// --- Chapter 4: Asymptotic Equipartition and Typicality (渐近均分性与典型性) ---

//   Section 4.1: The AEP for Discrete Memoryless Sources (离散无记忆信源的 AEP)
//     - 本节是全书 AEP 的"正本"；§2.3（连续）、§3.3（平稳）、§8.1（联合）
//       三处只回指此处的论证骨架，各自仅补差异，不重证
//     - 大数定律视角：-log p(X^n)/n → H(X)
//     - 典型集 A_ε^(n) 的定义与三条性质
//     - 典型集的概率、大小与元素概率的下界

//   Section 4.2: Typical Sets and Their Properties (典型集及其性质)
//     - 高概率集与典型集的差别（C&T 第 3 章）
//     - 典型集是对最小高概率集的近似
//     - 典型性作为"可压缩序列"的刻画

//   Section 4.3: Method of Types and Type Classes (类型方法与类型类)
//     - 类型 P_x 与类型类 T(P)
//     - 类型类的大小与概率的指数界
//     - 类型计数（与 Combinatoire 的计数技巧交叉引用）
//     - 通用信源编码中的类型计数（预告 §5.5）

//   Section 4.4: Consequences for Compression (压缩的推论)
//     - 典型集编码：固定长度约 nH 比特
//     - 高概率集编码；ε-典型序列（傅祖芸 第 5 章）
//     - AEP 的边界：非平稳、非遍历信源的失效


// --- Chapter 5: Lossless Source Coding (无失真信源编码) ---

//   Section 5.1: Codes, Unique Decodability and Kraft's Inequality (码、唯一可译性与 Kraft 不等式)
//     - 码的分类：定长/变长、非奇异、唯一可译、即时码
//     - 前缀码与码树；Kraft 不等式（必要与充分）
//     - McMillan 定理：唯一可译 ⇒ 满足 Kraft 不等式
//     - 唯一可译码的判定法（Sardinas–Patterson；傅祖芸 第 5 章）

//   Section 5.2: Optimal Codes: Huffman and Shannon–Fano–Elias (最优码：Huffman 与 Shannon–Fano–Elias)
//     - 最优码长的上下界 L* ∈ [H, H+1)
//     - Huffman 算法与最优性证明；r 元 Huffman
//     - Shannon–Fano–Elias 编码与算术编码的思想起源
//     - Fano 编码（Shannon–Fano 分组）；与 Huffman 的性能比较（傅祖芸 第 8 章）
//     - 竞争最优性（C&T 第 5 章；只给结论）

//   Section 5.3: Arithmetic Coding, Run-Length and Lempel–Ziv (算术编码、游程与 Lempel–Ziv)
//     - 算术编码：区间划分、累积分布、渐近最优
//     - 游程编码与 MH 编码（傅祖芸 第 8 章）
//     - LZ77 / LZ78 / LZW 的字典思想
//     - 由公平硬币生成任意分布（Knuth–Yao 方法；C&T 第 5 章）
//     - 算法复杂度与实用性能的比较（定性）

//   Section 5.4: Shannon's Source Coding Theorem (Shannon 无失真信源编码定理)
//     - 定理陈述：可靠压缩的速率下界是 H(X)
//     - 可达性：典型集编码 + 变长编码
//     - 逆定理：L < H 时错误概率不趋零
//     - 与 Kraft 不等式、AEP 的逻辑关系

//   Section 5.5: Universal Source Coding and Redundancy (通用编码与冗余度)
//     - 通用码与未知分布下的编码；LZ 的渐近最优性
//     - 冗余度的定义与下界；Bayesian 与 minimax 冗余
//     - 两遍编码与一遍编码的差异
//     - 与 MDL 原理的联系（预告 §15.4）

//   Section 5.6: Gambling, the Kelly Criterion and Universal Portfolios (赌博、Kelly 准则与通用投资组合)
//     - 赛马模型与公平赔率；财富增长的对数效用
//     - Kelly 准则：最优增长率的熵表达式
//     - 边信息与熵率（C&T 第 6 章）
//     - 通用投资组合与"熵 = 增长率"的同一性（C&T 第 16 章，只给主定理）


// --- Chapter 6: Rate–Distortion Theory (率失真理论) ---

//   Section 6.1: Distortion Measures and the Rate–Distortion Function (失真度量与率失真函数)
//     - 失真矩阵与平均失真 D
//     - R(D) = min I(X;X̂) s.t. E[d(X,X̂)] ≤ D
//     - R(D) 的性质：凸性、单调不增、D ≥ D_max 时 R = 0
//     - 无失真情形是 D = 0 的退化

//   Section 6.2: Properties and Calculation of R(D) (R(D) 的性质与计算)
//     - 参量表示与斜率；二元对称信源的 R(D)
//     - 离散对称信源的 R(D)（傅祖芸 第 7 章）
//     - 迭代算法（Blahut–Arimoto，陈述）
//     - 与信道容量的对偶（率失真 vs 容量）

//   Section 6.3: The Rate–Distortion Theorem (率失真定理)
//     - 可达性：联合典型 + 随机码本
//     - 逆定理：D 约束下 R < R(D) 不可能
//     - 强典型序列与率失真（C&T 第 10 章，只给结论）
//     - 与无失真定理的逻辑关系：D → 0 的连续性

//   Section 6.4: Gaussian Sources and Reverse Water-Filling (高斯信源与反向注水)
//     - 高斯信源的 R(D) = ½ log(σ²/D)
//     - 平行高斯信源：反向注水
//     - 变换编码与 KLT 的最优性（只给结论）
//     - 与 §9.4 正向注水的对偶

//   Section 6.5: Quantization and Vector Quantization (量化与矢量量化)
//     - 标量量化：均匀/非均匀、最优量化器
//     - 矢量量化与率失真下界
//     - 实用编码器（JPEG/音频）与理论的差距（定性）


// ==========================================================================
// Part III — Channel Coding: The Limits (信道编码：传输的极限)
// ==========================================================================
// 设计思路：本 Part 回答"噪声信道上能可靠传多快"。Ch 7 定义信道模型与容量
// （一个优化问题），Ch 8 证明容量是可达且不可越过的锐利阈值（存在性证明），
// Ch 9 把离散理论搬到连续的高斯信道，得到 Shannon–Hartley 公式与注水结构。
// 这三章只讲"极限在哪里"，具体码的构造留给 Part IV。Ch 8 的随机编码论证
// 只证明存在性，这个"存在而不构造"的缺口正是 Part IV 的动机。
// 对应教材：C&T 第 7、9 章（第 8 章的微分熵已在 §2.3 备妥）；傅祖芸 第 3、4.6–4.8、6 章。

// --- Chapter 7: Channel Models and Capacity (信道模型与容量) ---

//   Section 7.1: Channel Models and the Discrete Memoryless Channel (信道模型与离散无记忆信道)
//     - 信道的数学描述：转移概率 P(y|x)
//     - 无记忆、平稳、对称；BSC/BEC/删除信道
//     - 信道与信源的匹配问题（预告 §7.6）

//   Section 7.2: Mutual Information and Channel Capacity (互信息与信道容量)
//     - 容量 C = max_{p(x)} I(X;Y)
//     - 容量的性质：非负、连续性、对 p(x) 的凸性
//     - 数据处理：串联信道容量不增
//     - 容量的操作意义（预告 Ch 8）

//   Section 7.3: Canonical Channels (典型信道)
//     - 无噪二进制信道、无重叠输出的噪声信道
//     - 噪声打字机；BSC 与 BEC 的容量公式
//     - 弱对称/对称信道的容量
//     - 零错误容量（C&T 第 7 章）

//   Section 7.4: Symmetric and Quasi-Symmetric Channels (对称与准对称信道)
//     - 对称信道的容量公式；准对称信道的分解
//     - 独立并联信道的容量相加
//     - 串联信道的互信息与数据处理（傅祖芸 第 3 章）

//   Section 7.5: Computation of Capacity: Blahut–Arimoto (容量的计算：Blahut–Arimoto)
//     - 交替最大化；收敛性
//     - 离散无记忆信道的数值计算
//     - 与 §6.2 率失真迭代算法的同构

//   Section 7.6: Source–Channel Matching and the Cost of Mismatch (信源信道匹配与失配代价)
//     - 匹配：按 R(D) 与 C 分配比特；信源编码 + 信道编码的级联
//     - 失配代价：码率偏离匹配点时的性能损失（定性；回指 Ch 6 的 R(D)）
//     - 分离定理的严格陈述与证明归 §8.5，本节只做匹配层面的讨论


// --- Chapter 8: The Channel Coding Theorem (信道编码定理) ---

//   Section 8.1: Joint Typicality and Random Coding (联合典型性与随机编码)
//     - 联合典型序列与条件典型集
//     - 随机码本：M = 2^{nR} 个码字独立抽样
//     - 联合典型译码与错误事件分解

//   Section 8.2: Achievability of Capacity (容量的可达性)
//     - 错误概率的指数上界；union bound
//     - R < C 时错误概率可任意小
//     - 随机编码的存在性论证（非构造性）

//   Section 8.3: The Converse via Fano's Inequality (用 Fano 不等式证明逆定理)
//     - Fano 不等式回顾（§1.5）
//     - nR ≤ nC + 1 + P_e nR 的推导
//     - 容量是锐利阈值的含义；P_e 与 R 的权衡

//   Section 8.4: Error Exponents and Gallager's Bound (错误指数与 Gallager 界)
//     - 随机编码错误指数 E_r(R)
//     - Gallager 界与可靠性函数
//     - 截止速率 R_comp；与容量的差距
//     - 有限码长效应（只给量级，不展开有限块长理论）

//   Section 8.5: Feedback and Source–Channel Separation (反馈与信源信道分离)
//     - 反馈不增加 DMC 容量（C&T 第 7 章）
//     - 信源信道分离定理的严格表述与证明（承 §7.6 的匹配讨论；C&T 第 7 章）
//     - 联合信源信道编码：有失真情形（傅祖芸 第 6、7 章）
//     - 反馈在时变/多用户信道中的作用（定性）
//     - 零错误码与零错误容量只在 §7.3 处理，本节回指不重复


// --- Chapter 9: Gaussian Channels and Capacity (高斯信道与容量) ---

//   Section 9.1: The Gaussian Channel and Its Capacity (高斯信道与容量)
//     - AWGN 模型 Y = X + Z；功率约束 E[X²] ≤ P
//     - 容量 C = ½ log(1 + P/N)
//     - 可达性：把 §8.1–8.2 的联合典型与随机编码改写到连续情形，只给适配要点
//     - 逆定理不在本节：见 §9.2

//   Section 9.2: Converse for the Gaussian Channel (高斯信道的逆定理)
//     - 用 §8.3 的 Fano 论证 + 微分熵推出 nR ≤ nC + 1 + n P_e R
//     - 熵功率不等式（§2.5）的作用
//     - 高斯噪声是最坏噪声（最大熵，回指 §2.4）
//     - 紧性：可达性与逆定理在 C = ½ log(1 + P/N) 处相遇

//   Section 9.3: Bandlimited Channels and the Shannon–Hartley Formula (带限信道与 Shannon–Hartley 公式)
//     - 采样定理与自由度（交叉引用 Analyse Harmonique 的抽样定理）
//     - C = W log(1 + P/(N₀W))
//     - 功率-带宽权衡；能量效率与频谱效率
//     - 极限：W → ∞ 时 C → P/(N₀ ln 2)

//   Section 9.4: Parallel Channels, Water-Filling and Colored Noise (平行信道、注水与有色噪声)
//     - 平行高斯信道的容量分配
//     - 注水算法；与 §6.4 反向注水的对偶
//     - 有色高斯噪声：频域注水
//     - MIMO 的并行子信道分解（只给 SVD 视角，交叉引用 Algèbre Linéaire）

//   Section 9.5: Fading and MIMO Channels (衰落与 MIMO 信道)
//     - 衰落信道模型：慢衰落/快衰落
//     - 中断容量与遍历容量
//     - MIMO 容量：空间复用增益
//     - 高斯信道的反馈：不提高容量，但可简化编码（C&T 第 9 章）
//     - 与现代标准（5G）的接口（定性，不展开）


// ==========================================================================
// Part IV — Code Constructions: Approaching the Limits (编码构造：逼近极限)
// ==========================================================================
// 设计思路：Part III 证明极限可达，但用的是随机编码——存在而不构造。本 Part
// 给出可实现的码：Ch 10 用有限域上的线性代数建立线性分组码与界；Ch 11 用
// 多项式环构造循环码、BCH 与 RS；Ch 12 转向网格/图/极化三类现代构造，把
// "译码"作为算法问题处理。三章的共同主线是"结构（代数/图）→ 距离 → 译码"。
// 对应教材：傅祖芸 第 9 章；C&T 第 7 章（Hamming 码）；§12.3–12.5 为现代扩展。

// --- Chapter 10: Finite Fields and Linear Block Codes (有限域与线性分组码) ---

//   Section 10.1: Finite Fields and Polynomial Arithmetic (有限域与多项式算术)
//     - GF(q) 的存在唯一性与乘法群的循环性：回指 Algèbre Abstraite §13.3，不重证
//     - 本原元与本原多项式；最小多项式（AA §13.3 未含此内容，本节自含）
//     - 多项式环与欧几里得算法（交叉引用 Algèbre Abstraite 的环论）
//     - 编码所需的全部代数工具（不重述群环域一般理论）

//   Section 10.2: Linear Block Codes (线性分组码)
//     - 差错控制方式：FEC/ARQ；纠错码按代数结构的分类（傅祖芸 第 9 章）
//     - 码的定义：(n,k) 线性码；生成矩阵 G 与校验矩阵 H
//     - 系统码；对偶码；GHᵀ = 0
//     - 码的维数与秩；缩短、扩展、打孔

//   Section 10.3: Minimum Distance, Syndrome Decoding and Standard Arrays (最小距离、伴随式译码与标准阵列)
//     - 最小距离 d_min 与纠错/检错能力
//     - 伴随式 s = rHᵀ；标准阵列与陪集首
//     - 最大似然译码与最小距离译码的等价
//     - 译码复杂度：查表 vs 代数译码

//   Section 10.4: Hamming Codes and Perfect Codes (Hamming 码与完备码)
//     - Hamming 码的构造与参数
//     - 完备码的定义；Hamming 界
//     - 扩展 Hamming 码；与 C&T 第 7 章的衔接
//     - 其他完备码的存在性（只给结论）

//   Section 10.5: Bounds: Hamming, Singleton, Plotkin, Gilbert–Varshamov (界：Hamming、Singleton、Plotkin、Gilbert–Varshamov)
//     - 四个界的陈述与证明思路
//     - 界的可达性：MDS 码与 §11.4 的衔接
//     - 渐近界与编码理论的基本极限（只给结论）
//     - 与 Part III 容量界的对照：距离界 vs 容量界


// --- Chapter 11: Cyclic Codes, BCH and Reed–Solomon (循环码、BCH 与 Reed–Solomon) ---

//   Section 11.1: Cyclic Codes: Polynomial Structure (循环码：多项式结构)
//     - 循环移位不变性；理想与多项式环的对应
//     - 码多项式、生成多项式 g(x)；g(x) | x^n - 1
//     - 生成矩阵的系统形式；校验多项式 h(x)；对偶码与互反多项式
//     - 循环码的维数与最小距离下界

//   Section 11.2: Encoding and Decoding of Cyclic Codes (循环码的编码与译码)
//     - 多项式除法编码；系统循环码
//     - 编码与伴随式的移位寄存器（LFSR）实现
//     - 错误定位与译码器结构；复杂度

//   Section 11.3: BCH Codes (BCH 码)
//     - 本原 BCH 码的构造：根集与生成多项式
//     - BCH 界；设计距离与实际距离
//     - 译码：Berlekamp–Massey 与 Chien 搜索（只给算法框架）
//     - 二元 BCH 与 §10.4 Hamming 码的关系

//   Section 11.4: Reed–Solomon Codes and MDS Codes (Reed–Solomon 码与 MDS 码)
//     - RS 码作为 GF(q) 上的 BCH 码；参数 (n, n-d+1)
//     - MDS 码与 Singleton 界等号
//     - 纠删与纠错；多项式求值视角
//     - 应用：存储、QR 码、深空通信（定性）


// --- Chapter 12: Convolutional, Turbo, LDPC and Polar Codes (卷积码、Turbo 码、LDPC 与 Polar 码) ---

//   Section 12.1: Convolutional Codes: Algebraic and Trellis Description (卷积码：代数与网格描述)
//     - 卷积码的生成多项式/矩阵；记忆长度与约束长度
//     - 状态转移与网格图；自由距离
//     - 与分组码的关系；Viterbi 译码的输入结构

//   Section 12.2: Viterbi and BCJR Decoding (Viterbi 与 BCJR 译码)
//     - Viterbi 算法：最大似然序列检测；复杂度 O(2^ν n)
//     - BCJR：后验概率与软判决；前向-后向递推
//     - 硬判决 vs 软判决的性能差距（定性）
//     - 与 §8.4 错误指数的联系

//   Section 12.3: Turbo Codes and Iterative Decoding (Turbo 码与迭代译码)
//     - 并行级联卷积码；交织器的作用
//     - 迭代译码：外信息与置信传播
//     - 接近容量的性能与"错误平台"
//     - 复杂度与译码时延权衡

//   Section 12.4: LDPC Codes and Message Passing (LDPC 码与消息传递)
//     - Tanner 图与稀疏校验矩阵
//     - 置信传播/和积算法；密度进化（只给思想）
//     - 规则/非规则 LDPC；围长与性能
//     - 与 MacKay 的 LDPC 内容衔接

//   Section 12.5: Polar Codes and Channel Polarization (Polar 码与信道极化)
//     - 信道合成与分裂；极化现象
//     - 极化码的构造：信息位与冻结位
//     - 逐次消除译码（SC）与列表译码（SCL）
//     - 容量可达性与 5G 应用（定性）


// ==========================================================================
// Part V — Networks, Security and Interfaces (网络、安全与接口)
// ==========================================================================
// 设计思路：前四个 Part 都是"单用户、点对点"。本 Part 把理论推到三个方向：
// Ch 13 多用户/网络（容量区域取代单一容量）；Ch 14 安全（保密容量取代可靠
// 传输容量）；Ch 15 统计与学习（把类型、散度、描述长度接到推断与表示学习）。
// 三章共享同一套工具（联合典型、类型方法、互信息），是"同一理论的不同边界"。
// Ch 15 同时为未来的数理统计笔记（估计/检验/回归）搭桥：§15.2（检验）与
// §15.3（估计）是"从数据推模型"的两侧入口，§15.4（MDL）给出选择准则。
// 对应教材：C&T 第 11、15 章；傅祖芸 第 10、11 章；MacKay 的推断/学习部分。
// （傅祖芸第 12 章的跨学科内容按交叉引用分散处理，其中最大熵谱估计见 §2.4。）

// --- Chapter 13: Network Information Theory (网络信息论) ---

//   Section 13.1: Multiple-Access Channels (多址接入信道)
//     - 通信网的分类与多用户信道模型（傅祖芸 第 10 章）
//     - 多用户信道模型；容量区域而非单一容量
//     - 离散 MAC 的可达区域与时分/频分对照
//     - 高斯 MAC 的容量区域（叠加编码）
//     - 多用户检测与联合译码（定性）

//   Section 13.2: Broadcast Channels (广播信道)
//     - 退化广播信道；叠加编码
//     - 容量区域；与 MAC 的对偶
//     - 衰落广播与机会调度（定性）
//     - 与 §13.1 的结构对照

//   Section 13.3: Relay and Interference Channels (中继与干扰信道)
//     - 中继信道：放大转发/译码转发；容量界
//     - 干扰信道：干扰对齐的思想（只给结论）
//     - 协作通信与网络编码的接口
//     - 开放问题（定性）

//   Section 13.4: Distributed Source Coding: Slepian–Wolf (分布式信源编码：Slepian–Wolf)
//     - 两个相关信源的独立编码、联合译码
//     - Slepian–Wolf 定理与可达区域
//     - 与信道编码的对偶（Costa 脏纸码，只给结论）
//     - 应用：传感器网络、视频编码（定性）

//   Section 13.5: Network Coding and Duality (网络编码与对偶)
//     - 网络编码的基本模型；线性网络编码
//     - 最大流-最小割的信息论版本
//     - 信源-信道对偶：MAC/BC、Slepian–Wolf/信道编码
//     - 与 Théorie des Graphes 的交叉引用


// --- Chapter 14: Information-Theoretic Security (信息论安全) ---

//   Section 14.1: Perfect Secrecy and the One-Time Pad (完善保密与一次性密码本)
//     - 保密系统的数学模型：明文、密钥、密文
//     - 完善保密性 I(M;C) = 0；Shannon 定理 H(K) ≥ H(M)
//     - 一次性密码本的达到与局限
//     - 与计算安全的边界（只给概念）

//   Section 14.2: Theoretical versus Practical Security (理论保密性与实际保密性)
//     - 理论保密性、实际保密性；唯一解距离
//     - 冗余度与破译工作量（傅祖芸 第 11 章）
//     - 古典密码体制：单表代换、移位、乘数、多表代换与置换（只给信息论视角）
//     - 现代密码不在此展开

//   Section 14.3: The Wiretap Channel and Secrecy Capacity (窃听信道与保密容量)
//     - Wyner 窃听信道模型
//     - 保密容量 C_s；与主信道容量的关系
//     - 退化窃听信道的结果（只给定理陈述）
//     - 与 §13 网络模型的接口

//   Section 14.4: Secret Key Agreement (密钥协商)
//     - 公共信道上的密钥协商；敌手观测
//     - 秘密容量；与 Slepian–Wolf 的对偶
//     - 信息论安全 vs 计算安全的适用边界
//     - 量子密钥分发的定位（交叉引用 Mécanique quantique，不展开）


// --- Chapter 15: Information Theory, Statistics and Learning (信息论、统计与学习) ---

//   Section 15.1: Method of Types and Sanov's Theorem (类型方法与 Sanov 定理)
//     - 类型方法回顾（§4.3）；大偏差速率函数
//     - Sanov 定理：经验分布的偏差概率
//     - 与假设检验错误指数的联系（预告 §15.2）
//     - 与 Probabilités 的大数定律对照（只给接口）

//   Section 15.2: Hypothesis Testing and Error Exponents (假设检验与错误指数)
//     - 简单假设 vs 复合假设；Neyman–Pearson
//     - Chernoff–Stein 引理；Stein 引理
//     - Chernoff 信息与错误指数
//     - 与 §2.2 散度、§8.4 错误指数的统一视角

//   Section 15.3: Fisher Information and Estimation Bounds (Fisher 信息与估计界)
//     - 得分函数与 Fisher 信息 J(θ)；与 KL 的局部展开（J 是 D 的二阶项）
//     - 数据处理不等式下的 Fisher 信息；信息不等式链
//     - Cramér–Rao 下界；渐近有效估计
//     - 与 §15.2 错误指数、§2.1 散度的接口（C&T 第 11 章的估计部分）

//   Section 15.4: MDL and Model Selection (最小描述长度与模型选择)
//     - 两遍编码与 MDL；码长 = -log P(x|θ) + 模型描述
//     - MDL 与 BIC/AIC 的关系（只给结论）
//     - 通用编码与模型选择的等价（回指 §5.5）
//     - Kolmogorov 复杂度的定位（只说明"不可计算"，不建立理论，见职责边界）

//   Section 15.5: Cross-Entropy, Variational Inference and the ELBO (交叉熵、变分推断与 ELBO)
//     - 交叉熵损失 = H(p) + D(p||q)
//     - 变分下界 ELBO = E_q[log p(x,z)] - E_q[log q(z)]
//     - KL 的分解与重参数化（只给框架）
//     - 与 §2.1 的 KL、§2.4 的最大熵对照

//   Section 15.6: Information Bottleneck and Representation Learning (信息瓶颈与表示学习)
//     - 信息瓶颈目标：min I(X;T) - β I(T;Y)
//     - 与 §15.5 的变分近似；自编码器的信息论解读
//     - 对比学习中的互信息最大化（InfoNCE，只给目标函数）
//     - 信息论的边界：相关性不等于因果（谨慎结论）


// ==========================================================================
// Appendix (附录)
// ==========================================================================
// 设计思路：术语表由 violet-glossary-indexer 依据正文标签生成。需特别注意
// 三组同名异义："熵"（Shannon 熵 / 微分熵 / 热力学熵 / von Neumann 熵）、
// "容量"（信道容量 / 保密容量 / 容量区域）、"码"（信源码 / 信道码 / 线性码）。
// 术语表须为这些词给出区分，并在条目中标注所属 Part。

// --- Appendix A: Glossary (术语表) ---


// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循"度量 → 极限 → 构造 → 拓展"的四段式主线，共 5 Part、15 Chapter、
// 74 Section。
//
// Part I（Ch 1–3，信息度量）：熵与互信息的公理化、散度与连续信息、熵率，
//   建立全书共用的度量语言与信息不等式工具箱。
//
// Part II（Ch 4–6，信源编码）：AEP 与类型方法 → 无失真编码定理与实用算法
//   → 率失真理论，回答"数据能压到多小"。
//
// Part III（Ch 7–9，信道编码的极限）：信道模型与容量 → 信道编码定理与逆定理
//   → 高斯信道与 Shannon–Hartley 公式，回答"噪声下能可靠传多快"。
//
// Part IV（Ch 10–12，编码构造）：有限域与线性码 → 循环码/BCH/RS → 卷积/
//   Turbo/LDPC/Polar，把 Part III 的存在性结果落成可实现的结构。
//
// Part V（Ch 13–15，网络、安全与接口）：多用户容量区域、信息论安全、
//   统计推断与学习接口，展示同一套工具在三个方向的边界。
//
// 教材覆盖：Cover & Thomas 第 2 版 17 章中 16 章的知识点已覆盖（第 14 章
//   Kolmogorov 复杂度不纳入：本笔记不建立可计算性基础）；傅祖芸第 4 版 13 章中
//   11 章已覆盖（第 12 章跨学科按交叉引用分散处理，第 13 章量子信息归
//   Mécanique quantique §13.4）。MacKay 的推断/学习内容并入 Ch 15。
//
// 与相邻笔记的衔接：Ch 3 使用 Probabilités 的 Markov 链结论；Ch 15 为未来的
//   数理统计笔记提供"类型/检验/Fisher 估计/MDL"入口；Part IV 的有限域复习
//   衔接 Algèbre Abstraite §13.3（本原多项式与最小多项式由 §10.1 自含）。
// ==========================================================================

#bibliography("references.bib", title: "References", full: true)

// 目录
