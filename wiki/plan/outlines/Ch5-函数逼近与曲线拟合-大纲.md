# 第 5 章「Function Approximation and Curve Fitting // 函数逼近与曲线拟合」写作大纲

> 状态：正文已按本大纲写入 `6.Mathématiques appliquées/Analyse Numérique/initial.typ`。
> 三张配图已由同目录 `scripts/` 下的脚本生成（`chebyshev-extrema-zeros.svg`、`least-squares-fit.svg`、`aliasing.svg`）。
> 任务类型：**A 类新章规划**（该章目前仅有蓝图注释，L164–L183）。
> 已确认决策：§5.6 聚焦三角插值与混叠；保持「一致逼近 → Chebyshev」节序；配 3 张图。

## 零、章节定位与核心洞察

**章节定位**：Part II 的第三环。插值（Ch3）与分段插值/样条（Ch4）都以「穿过给定点」为硬约束；本章把约束换成「在某个范数下使误差最小」，从而同时处理三件事——无噪声数据的最优逼近、带噪声数据的拟合、周期数据的三角逼近。本章也是 Ch6 数值积分的逼近论底座（正交多项式的零点 → Gauss 求积节点）。

**核心洞察**：**同一个几何事实——正交投影——在三套度量下给出三种算法**：一致范数下它表现为 Chebyshev 交错（极小极大），加权平方范数下表现为法方程（最小二乘），离散周期范数下表现为 DFT（三角插值）。范数是唯一变化的量，代数结构不变。

**与既有内容的边界（SRP）**：

| 已有内容 | 位置 | 本章处理方式 |
|---|---|---|
| Weierstrass 第一/第二逼近定理 | `Analyse Mathématique` L8153 / L8248（`thm:weierstrass-first-approximation`、`thm:weierstrass-second-approximation`） | 只作为存在性前提引用，**不重证**；第一定理用于 §5.1，第二定理用于 §5.6 |
| 有限维最小二乘与正规方程 | `Algèbre Linéaire` L4382–L4447（`thm:least-squares-solution`） | §5.5 只陈述结论并注明出处，重心转向**条件数、基函数选择与 QR** |
| 正交投影与正交分解 | `Algèbre Linéaire` L4289 / L4302（`def:orthogonal-projection`、`thm:orthogonal-decomposition`） | §5.3 用作几何解释，不重推 |
| DFT、FFT、混叠（Poisson 求和） | `Analyse Harmonique` L2299–L2363（`def:dft`、`prop:fft-radix2`、`thm:poisson-summation`） | §5.6 只建立**三角插值**与混叠公式，DFT/FFT 仅引用 |
| Fourier 平方逼近、Bessel/Parseval | `Analyse Harmonique` L1156–L1210（`thm:square-approximation`、`thm:bessel`、`thm:parseval-identity`） | §5.4 作为正交展开的三角特例回指 |
| 插值余项、Lebesgue 常数、算子界 | 本笔记 Ch3（`thm:interpolation-error`、`def:lebesgue-constant`、`lem:interpolation-operator-bound`） | §5.2 直接消费，兑现 Ch4 承诺 |
| 条件数与 Hilbert 矩阵 | 本笔记 Ch2（`def:condition-number`、`ex:hilbert-matrices`） | §5.3 解释 Hilbert 矩阵的来源；§5.5 给出条件数平方恶化 |

**规模**：正文约 800–850 行，6 节，34 个新标签，3 张图，约 12 个编号公式。

## 一、结构方案

| 节 | 标题 | 预估行数 | 说明 |
|---|---|---|---|
| §5.1 | Best Uniform Approximation // 最佳一致逼近 | ~140 | 定义 $E_n^*(f)$；存在性引理；交错定理；de la Vallée Poussin 下界；Remez 算法；有理逼近注记 |
| §5.2 | Chebyshev Polynomials and Economization // Chebyshev 多项式与多项式压缩 | ~140 | Chebyshev 多项式性质；首一极小偏差定理；最优节点；多项式压缩；**兑现 Ch4 承诺** |
| §5.3 | Continuous Least-Squares Approximation // 连续最小二乘逼近 | ~120 | 加权平方范数；连续法方程；投影解释；Hilbert Gram 矩阵；误差恒等式 |
| §5.4 | Orthogonal Polynomials // 正交多项式 | ~170 | 正交多项式定义；四族一览；三项递推；零点分布；正交展开；Legendre 展开例；Clenshaw |
| §5.5 | Discrete Least-Squares Fitting // 离散最小二乘拟合 | ~130 | 离散最小二乘；引用线代结论；条件数平方；离散正交基；直线/指数拟合例；QR 前瞻 |
| §5.6 | Trigonometric Interpolation and DFT // 三角插值与离散 Fourier 变换 | ~130 | 三角插值存在唯一性；系数=DFT；混叠公式；收敛性注记；FFT 引用 |
| — | 章首导言 | ~25 | Part II 主线衔接 + 三种范数的统一视角 |

**组织主线**：一致范数（存在 → 刻画 → 构造）→ 平方范数（连续 → 正交系）→ 离散数据（拟合 → 条件数）→ 周期数据（三角 → DFT）。范数从「最坏情形」逐步放宽到「平均」再到「离散采样」，每换一次范数，正交投影就换一次外衣。

**节序决策**：先一致逼近（交错定理给出刻画），后 Chebyshev 多项式（给出显式极小元与最优节点），逻辑为「存在性 → 刻画 → 构造」。这与李庆扬第 3 章「基本概念 → 正交多项式 → 最佳一致 → 最佳平方」的顺序不同，理由是本章把「范数」作为主线，先讲最难的 $\infty$-范数，后两节自然成为其放宽。

## 二、组件频率预估

| 组件类型 | 数量 | 标签清单 |
|---|---|---|
| `#definition` | 6 | `<def:best-uniform-approximation>`, `<def:chebyshev-polynomial>`, `<def:best-square-approximation>`, `<def:orthogonal-polynomials>`, `<def:discrete-least-squares>`, `<def:trigonometric-interpolation>` |
| `#theorem` | 7 | `<thm:chebyshev-alternation>`, `<thm:chebyshev-minimax>`, `<thm:continuous-normal-equations>`, `<thm:three-term-recurrence>`, `<thm:orthogonal-polynomial-zeros>`, `<thm:orthogonal-expansion>`, `<thm:trig-interpolation-uniqueness>` |
| `#proposition` | 7 | `<prop:de-la-vallee-poussin>`, `<prop:chebyshev-properties>`, `<prop:economization>`, `<prop:classical-orthogonal-polynomials>`, `<prop:normal-equation-conditioning>`, `<prop:discrete-orthogonal-basis>`, `<prop:aliasing>` |
| `#corollary` | 2 | `<cor:square-approximation-error>`, `<cor:chebyshev-nodes-optimal>` |
| `#lemma` | 1 | `<lem:best-approximation-exists>` |
| `#example` | 8 | `<ex:best-linear-approximation>`, `<ex:taylor-economization>`, `<ex:continuous-least-squares>`, `<ex:hilbert-gram>`, `<ex:legendre-expansion>`, `<ex:linear-least-squares-fit>`, `<ex:exponential-fit>`, `<ex:aliasing-of-cosine>` |
| `#note` / `#caution` | ~8 | 无标签；Weierstrass 引用、Remez 收敛、Lebesgue 对数增长、Clenshaw、线代分工、线性化警告、收敛性、FFT |
| `#figure` | 3 | `<fig:chebyshev-extrema-zeros>`, `<fig:least-squares-fit>`, `<fig:aliasing>` |
| `#tex-table` | 1 | 四族经典正交多项式一览 |

## 三、各节知识点、组件与标签

### §5.1 Best Uniform Approximation // 最佳一致逼近

| 内容 | 组件/标签 | 备注 |
|---|---|---|
| 一致逼近问题与误差 $E_n^*(f)=min_(p in Pi_n)||f-p||_oo$ | `#definition` `<def:best-uniform-approximation>` | 回链 Ch3 `lem:interpolation-operator-bound` 已用此记号；说明与插值的区别 |
| 极小元存在性（有限维紧性 + Bolzano–Weierstrass） | `#lemma` `<lem:best-approximation-exists>` | 证明策略：误差序列的系数一致有界 → 取收敛子列 → 范数连续性 |
| Weierstrass 定理只作存在性前提 | `#note`（无标签） | 交叉引用 `Analyse Mathématique` 两定理；强调 $E_n^*(f) -> 0$ 但不给出算法 |
| Chebyshev 交错定理（刻画 + 唯一性） | `#theorem` `<thm:chebyshev-alternation>` | 证明策略：(⇐) 符号计数 + Haar 条件；(⇒) 在极值点上用同号多项式扰动；唯一性再用符号计数 |
| de la Vallée Poussin 下界 | `#proposition` `<prop:de-la-vallee-poussin>` | 用于 Remez 的停机判据；证明：与交错定理 (⇐) 同一符号计数 |
| Remez 交换算法 | 普通 prose + 编号列表 | 四步：选参考点 → 解线性方程组（含 $E$）→ 找新极值 → 迭代；收敛性只在 `#note` 提及不证 |
| 最佳线性逼近 $x^2$ 于 $[0,1]$ | `#example` `<ex:best-linear-approximation>` | $p^*=x-1/8$，误差 $1/8$，交错点 $0,1/2,1$；对比 Taylor 与插值 |
| 有理逼近简介 | `#note`（无标签） | $(m,n)$ 有理逼近、同样满足交错原理、极点附近指数级优势；不展开 |

### §5.2 Chebyshev Polynomials and Economization // Chebyshev 多项式与多项式压缩

| 内容 | 组件/标签 | 备注 |
|---|---|---|
| Chebyshev 多项式定义 $T_n(cos theta)=cos(n theta)$ | `#definition` `<def:chebyshev-polynomial>` | 给出三项递推 `eq:chebyshev-recurrence`；说明由恒等式延拓为多项式 |
| 基本性质（次数、首项系数、$abs(T_n)<=1$、极值点、零点、奇偶性） | `#proposition` `<prop:chebyshev-properties>` | 极值点 $cos(k pi \/ n)$、零点 $cos((2k-1)pi \/ (2n))$；正交性留到 §5.4 |
| 首一多项式的最小偏差 | `#theorem` `<thm:chebyshev-minimax>` | $min_(p "monic")||p||_oo = 2^(1-n)$，极小元 $2^(1-n)T_n$；证明：在 $n+1$ 个极值点符号计数 |
| Chebyshev 节点最优性与 $E_n^*$ 比较 | `#corollary` `<cor:chebyshev-nodes-optimal>` | **兑现 Ch4 L1714**：$||omega||_oo<=2^(-n)$，区间 $[a,b]$ 上 $(b-a)^(n+1) \/ 2^(2n+1)$；配合 `lem:interpolation-operator-bound` 得 $E_n^* <= ||f-L_n f||_oo <= (1+Lambda_n)E_n^*$ |
| Lebesgue 常数的对数增长 | `#note` | 只陈述 $Lambda_n = (2\/pi)log n + O(1)$，引标准结果，不证 |
| 多项式压缩（economization） | `#proposition` `<prop:economization>` | 把 $p=sum b_k T_k$ 截断到 $k<=m$，误差 $<=sum_(k>m)abs(b_k)$；三角不等式 |
| Taylor 级数的 Chebyshev 压缩 | `#example` `<ex:taylor-economization>` | $e^x$ 五次 Taylor 在 $[-1,1]$：原误差 $approx 1.6 times 10^(-3)$，压缩掉 $T_5$ 项（系数 $1/1920$）后四次多项式误差 $approx 2.1 times 10^(-3)$，远优于四次 Taylor 的 $9.9 times 10^(-3)$ |
| 图：$T_5$ 的极值/零点与首一极小偏差 | `#figure` `<fig:chebyshev-extrema-zeros>` | 双面板；写作时先占位 `wiki/assets/null.svg` |

### §5.3 Continuous Least-Squares Approximation // 连续最小二乘逼近

| 内容 | 组件/标签 | 备注 |
|---|---|---|
| 加权内积与平方范数 $(f,g)_w=integral_a^b w f g$ | 普通 prose + display 公式 | 不新设组件：内积空间一般理论归 `Analyse Fonctionnelle`/`Analyse Réelle`；此处只固定记号与权函数条件 |
| 最佳平方逼近定义 | `#definition` `<def:best-square-approximation>` | $p^*$ 最小化 $||f-p||_(2,w)$；与 §5.1 的 $E_n^*$ 对照 |
| 连续法方程与投影特征 | `#theorem` `<thm:continuous-normal-equations>` | $(f-p^*,phi_j)_w=0$；$G c=d$ 且 $G$ 对称正定；证明：展开二次泛函、Gram 矩阵正定 |
| 误差恒等式（勾股） | `#corollary` `<cor:square-approximation-error>` | $||f-p^*||^2=||f||^2-d^T c$；后续 §5.4 复用 |
| 最佳线性平方逼近 $sqrt(x)$ | `#example` `<ex:continuous-least-squares>` | $p^*=4/15+4x/5$；$L^2$ 误差 $approx 0.047$，但端点 $x=0$ 处误差 $4/15$，与一致逼近对比 |
| 单项式基导致 Hilbert Gram 矩阵 | `#example` `<ex:hilbert-gram>` | $G_(j k)=1\/(j+k+1)$；**解释 Ch2 L1123** 的「Hilbert 矩阵来自最小二乘」；回链 `ex:hilbert-matrices` |
| 基函数是病态根源，不是问题本身 | `#note` | 问题在理论上良态；换正交基可对角化 Gram → 预告 §5.4 |

### §5.4 Orthogonal Polynomials // 正交多项式

| 内容 | 组件/标签 | 备注 |
|---|---|---|
| 正交多项式系定义 | `#definition` `<def:orthogonal-polynomials>` | 首一规范；权 $w$、区间 $(a,b)$ |
| Legendre/Chebyshev/Laguerre/Hermite 一览 | `#proposition` `<prop:classical-orthogonal-polynomials>` + `#tex-table` | 区间、权、递推、首项系数、范数平方；详讲 Legendre/Chebyshev，另两族表格化 |
| 三项递推 | `#theorem` `<thm:three-term-recurrence>` | 首一形式 $p_(n+1)=(x-alpha_n)p_n-beta_n p_(n-1)$；证明：$x p_n$ 在正交基中展开，正交性只留三项 |
| 零点的实性与交错 | `#theorem` `<thm:orthogonal-polynomial-zeros>` | $n$ 个单实零点位于 $(a,b)$；证明：符号变化数 + 正交性矛盾；交错性由三项递推给要点 |
| 正交展开即最佳平方逼近 | `#theorem` `<thm:orthogonal-expansion>` | $c_k=(f,p_k)\/(p_k,p_k)$；误差 $||f-p^*||^2=||f||^2-sum c_k^2||p_k||^2$；证明：§5.3 法方程 + 对角 Gram + `cor:square-approximation-error` |
| 与 Fourier 级数的关系 | 普通 prose + 回指 | 三角系是正交系特例；回链 `Analyse Harmonique` 的 `thm:square-approximation`、`thm:bessel` |
| Legendre 展开 $e^x$ | `#example` `<ex:legendre-expansion>` | 二次截断：$c_0=sinh 1 approx 1.1752$、$c_1=3\/e approx 1.1036$、$c_2=(5\/2)(e-7\/e) approx 0.3584$；误差 $approx 0.0357$ |
| Clenshaw 求和 | `#note` | 与 `prop:horner-scheme` 对偶；用三项递推 $O(n)$ 稳定求值 |
| 零点 → Gauss 求积节点 | 普通 prose（前瞻） | 指向 Ch6 `== Gaussian Quadrature` |

### §5.5 Discrete Least-Squares Fitting // 离散最小二乘拟合

| 内容 | 组件/标签 | 备注 |
|---|---|---|
| 离散加权最小二乘定义 | `#definition` `<def:discrete-least-squares>` | 数据 $(x_i,y_i)$、权 $omega_i$、$min sum omega_i(y_i-p(x_i))^2$；矩阵形式 $A c approx y$ |
| 与线性代数结论的分工 | `#note` | 正规方程 $A^T W A c=A^T W y$ 的存在唯一性见 `Algèbre Linéaire` 的 `thm:least-squares-solution`，此处只引用 |
| 正规方程的条件数平方恶化 | `#proposition` `<prop:normal-equation-conditioning>` | $kappa_2(A^T A)=kappa_2(A)^2$；证明：奇异值平方；回链 `def:condition-number` |
| 离散正交基使法方程对角化 | `#proposition` `<prop:discrete-orthogonal-basis>` | $<u,v>_omega=sum omega_i u(x_i)v(x_i)$；$c_k=<y,phi_k>\/<phi_k,phi_k>$ |
| 直线拟合 | `#example` `<ex:linear-least-squares-fit>` | 数据 $(0,1),(1,2),(2,4),(3,5)$：$y=0.9+1.4x$，SSE $=0.2$ |
| 指数拟合与线性化 | `#example` `<ex:exponential-fit>` | $y=a e^(b t)$ 取对数化直线；给出数据与系数 |
| 线性化改变了误差度量 | `#caution` | 对数变换把绝对误差变成相对误差；最小二乘不具非线性变换不变性 |
| 稳定实现：QR/SVD | `#note`（前瞻） | 指向 Ch7 `== Orthogonal Factorizations and QR Decomposition`；回指 §5.4 正交基 |
| 图：拟合直线与残差 | `#figure` `<fig:least-squares-fit>` | 单面板：散点 + 拟合线 + 竖直残差段；标注 SSE |

### §5.6 Trigonometric Interpolation and DFT // 三角插值与离散 Fourier 变换

| 内容 | 组件/标签 | 备注 |
|---|---|---|
| 三角插值问题 | `#definition` `<def:trigonometric-interpolation>` | $N=2n+1$ 等距节点；空间 $"span"{e^(i k x): abs(k)<=n}$；实形式等价 |
| 存在唯一性与系数公式 | `#theorem` `<thm:trig-interpolation-uniqueness>` | 证明：指数系在离散内积下正交（几何和）；$c_k=1/N sum y_j e^(-i k x_j)$ |
| 系数公式就是 DFT | `#note` | 只引用 `Analyse Harmonique` 的 `def:dft`，不重定义；编号公式 `eq:trig-coefficients` |
| 混叠公式 | `#proposition` `<prop:aliasing>` | $c_k=sum_(l in bb(Z)) hat(f)(k+l N)$；证明：Fourier 级数代入 + 几何和 |
| 余弦混叠 | `#example` `<ex:aliasing-of-cosine>` | $N=9$、采样 $cos 5x$，因 $5 equiv -4 (mod 9)$，插值多项式为 $cos 4x$ |
| 收敛性与光滑度 | `#note` | $f in C^s$ 时误差 $O(N^(-s))$；解析则指数收敛；回指 `Analyse Harmonique` 的衰减结果；Weierstrass 第二定理只作密度前提 |
| FFT 的成本 | 普通 prose | 直接求系数 $O(N^2)$，FFT $O(N log_2 N)$；引用 `prop:fft-radix2` |
| 图：混叠 | `#figure` `<fig:aliasing>` | 连续 $cos 5x$ 与插值 $cos 4x$ 在 9 个采样点重合 |

## 四、逻辑链路图

**向上依赖**

```
Analyse Mathématique thm:weierstrass-first-approximation (L8153)
        ──► §5.1 存在性前提（E_n(f) -> 0），不重证
Analyse Mathématique thm:weierstrass-second-approximation (L8248)
        ──► §5.6 三角多项式稠密性前提

Algèbre Linéaire def:orthogonal-projection (L4289) + thm:orthogonal-decomposition (L4302)
        ──► §5.3 连续法方程的几何解释
Algèbre Linéaire thm:least-squares-solution (L4417)
        ──► §5.5 正规方程存在唯一性（只引用）

Analyse Harmonique def:dft (L2303) + prop:fft-radix2 (L2332)
        ──► §5.6 系数公式与成本（不重推）
Analyse Harmonique thm:square-approximation (L1172) + thm:bessel (L1189)
        ──► §5.4 正交展开的三角特例

本笔记 Ch2 def:condition-number (L1053) + ex:hilbert-matrices (L1122)
        ──► §5.3 ex:hilbert-gram（解释来源）+ §5.5 prop:normal-equation-conditioning
本笔记 Ch3 thm:interpolation-error (L1370) + cor:interpolation-error-bound (L1650)
        ──► §5.2 cor:chebyshev-nodes-optimal
本笔记 Ch3 def:lebesgue-constant (L1682) + lem:interpolation-operator-bound (L1689)
        ──► §5.2 与 E_n^* 的比较
本笔记 Ch1 prop:horner-scheme (L771)
        ──► §5.4 Clenshaw 求和的类比
本笔记 Ch2 def:norm / def:matrix-norm (L849/L873)
        ──► 全章范数记号
```

**横向链路**

```
§5.1 def:best-uniform-approximation
        │ 存在性：lem:best-approximation-exists
        ▼
thm:chebyshev-alternation ──► prop:de-la-vallee-poussin ──► Remez 算法
        │
        ▼
§5.2 def:chebyshev-polynomial ──► prop:chebyshev-properties
        │                                   │
        ▼                                   ▼
thm:chebyshev-minimax ──► cor:chebyshev-nodes-optimal（兑现 Ch4 L1714）
        │                                   │
        ▼                                   ▼
prop:economization ──► ex:taylor-economization

§5.3 def:best-square-approximation ──► thm:continuous-normal-equations
        │                                   │
        │                                   ├──► cor:square-approximation-error
        │                                   └──► ex:hilbert-gram（解释 Ch2 L1123）
        ▼
§5.4 def:orthogonal-polynomials ──► thm:three-term-recurrence
        │                                   │
        │                                   ▼
        │                          thm:orthogonal-polynomial-zeros
        ▼                                   │
prop:classical-orthogonal-polynomials       │（零点成为 Gauss 节点）
        │                                   │
        ▼                                   ▼
thm:orthogonal-expansion ──► ex:legendre-expansion    ［Ch6 消费］

§5.5 def:discrete-least-squares ──► prop:discrete-orthogonal-basis
        │                                   │
        ├──► prop:normal-equation-conditioning ──► QR 前瞻（Ch7）
        └──► ex:linear-least-squares-fit / ex:exponential-fit

§5.6 def:trigonometric-interpolation ──► thm:trig-interpolation-uniqueness
        │                                   │
        ▼                                   ▼
  DFT（引用）                        prop:aliasing ──► ex:aliasing-of-cosine
```

**向下兑现**

```
Ch6 == Gaussian Quadrature：§5.4 thm:orthogonal-polynomial-zeros 的零点 ──► Gauss–Legendre 节点、2n-1 次代数精度
Ch7 == Orthogonal Factorizations and QR Decomposition：§5.5 prop:normal-equation-conditioning ──► 用 QR 稳定求解最小二乘
Ch8 == Krylov Subspace Methods：§5.4 正交基 + §7.5 正交化 ──► 共轭梯度
Ch5 §5.6 ──► 与 Analyse Harmonique 的 Fourier 级数/DFT 附录形成双向引用（不重复）
```

## 五、承诺追踪

| 类型 | 位置 | 内容 | 处理 |
|---|---|---|---|
| 兑现 | Ch3 L1321 | 「数据带测量误差时，应在范数意义下逼近」 | §5.5 开篇 + `def:discrete-least-squares>` |
| 兑现 | Ch4 L1714 | 「Chebyshev 节点在精确意义下最优，并与 $E_n^*(f)$ 比较」 | §5.2 `cor:chebyshev-nodes-optimal` + 紧邻 `#note` |
| 兑现 | Ch4 L2007 | 「数据有噪声、无法插值时怎么办」 | §5.5 开篇 |
| 解释 | Ch2 L1123 | 「Hilbert 矩阵自然来自最小二乘拟合」 | §5.3 `ex:hilbert-gram`（单项式 Gram 矩阵） |
| 埋下 | §5.4 `thm:orthogonal-polynomial-zeros` | 零点作为 Gauss 求积节点 | Ch6 `== Gaussian Quadrature` |
| 埋下 | §5.5 `prop:normal-equation-conditioning` | 条件数平方恶化 → QR 稳定实现 | Ch7 `== Orthogonal Factorizations and QR Decomposition` |
| 埋下 | §5.4 `thm:three-term-recurrence` | 正交化思想 | Ch8 `== Krylov Subspace Methods` |
| 保留 | Ch3 `lem:interpolation-operator-bound` | 已完整证明，无需改动 | 本章只消费 |

## 六、证明策略表

| 定理 | 证明策略 | 关键工具 |
|---|---|---|
| `<lem:best-approximation-exists>` | 取极小化序列 → 系数一致有界 → Bolzano–Weierstrass 取子列 → 范数连续性 | `Analyse Mathématique` 的 Bolzano–Weierstrass 定理 |
| `<thm:chebyshev-alternation>` | (⇐) 若更优多项式存在，则 $p^*-q$ 在 $n+2$ 个交错点变号 → 至少 $n+1$ 个零点，矛盾；(⇒) 在所有极值点上构造同号多项式 $h$ 并沿 $-h$ 方向扰动以降低最大误差；唯一性用同一符号计数 | Haar 条件（非零 $n$ 次多项式至多 $n$ 个零点） |
| `<prop:de-la-vallee-poussin>` | 与交错定理 (⇐) 同一论证 | 符号计数 |
| `<thm:chebyshev-minimax>` | 在 $T_n$ 的 $n+1$ 个极值点上，首一差多项式的符号交替 → 至少 $n$ 个零点，而次数 $<=n-1$ | `prop:chebyshev-properties` |
| `<cor:chebyshev-nodes-optimal>` | $omega = 2^(-n) T_(n+1)$；代入 `thm:interpolation-error`；再与 `lem:interpolation-operator-bound` 合并 | `thm:interpolation-error`、`lem:interpolation-operator-bound` |
| `<prop:economization>` | 截断误差 $=abs(sum_(k>m) b_k T_k) <= sum abs(b_k)$，因 $abs(T_k)<=1$ | `prop:chebyshev-properties` |
| `<thm:continuous-normal-equations>` | 展开 $Q(c)=||f-sum c_j phi_j||^2$ 为二次型；Gram 矩阵对称正定 → 唯一驻点即极小点；驻点条件给出法方程 | 内积双线性、Gram 正定 |
| `<thm:three-term-recurrence>` | 将 $x p_n$ 在正交基中展开，次数比较 + 正交性消去除 $n-1,n,n+1$ 外各项 | `def:orthogonal-polynomials` |
| `<thm:orthogonal-polynomial-zeros>` | 若变号点少于 $n$，乘以符号匹配多项式后内积非零但正交性要求为零 → 矛盾；交错性由递推的 Sturm 型论证 | 正交性、介值定理、Rolle |
| `<thm:orthogonal-expansion>` | 法方程在对角 Gram 下解耦；误差恒等式用勾股 | `thm:continuous-normal-equations`、`cor:square-approximation-error` |
| `<prop:normal-equation-conditioning>` | 奇异值 $\sigma_i(A^T A)=\sigma_i(A)^2$ → 条件数平方 | 回链 `def:matrix-norm`、`def:condition-number` |
| `<prop:discrete-orthogonal-basis>` | 法方程的 Gram 矩阵为对角矩阵，直接求逆 | `def:discrete-least-squares>` |
| `<thm:trig-interpolation-uniqueness>` | 离散正交性 $sum_j omega_N^(j(k-l))=N delta_(k l)$ → Gram 对角 → 系数显式 | 几何和公式 |
| `<prop:aliasing>` | 把 Fourier 级数代入系数公式，交换有限和，几何和只在 $m equiv k (mod N)$ 时非零 | 同上 |

## 七、公式编号规划

| 标签 | 公式 | 说明 |
|---|---|---|
| `<eq:best-uniform-error>` | $E_n^*(f)=min_(p in Pi_n)||f-p||_oo$ | 全章统一记号 |
| `<eq:chebyshev-recurrence>` | $T_(n+1)=2x T_n-T_(n-1)$ | 后续压缩、Clenshaw、零点反复引用 |
| `<eq:chebyshev-minimal-monic>` | $min ||p||_oo = 2^(1-n)$ | 极小极大核心 |
| `<eq:chebyshev-node-bound>` | $abs(omega(x))<=((b-a)\/(2))^(n+1) 2^(-n)$ | 兑现 Ch4 承诺的关键式 |
| `<eq:continuous-normal-equations>` | $(f-p^*,phi_j)_w=0$ | 连续法方程的定义式 |
| `<eq:gram-system>` | $G c=d$ | 矩阵形式，§5.3/§5.4 共用 |
| `<eq:three-term-recurrence>` | $p_(n+1)=(x-alpha_n)p_n-beta_n p_(n-1)$ | 四族统一递推 |
| `<eq:orthogonal-coefficients>` | $c_k=(f,p_k)_w\/(p_k,p_k)_w$ | 正交展开系数 |
| `<eq:orthogonal-error>` | $||f-p^*||^2=||f||^2-sum c_k^2||p_k||^2$ | 平方误差恒等式 |
| `<eq:discrete-normal-equations>` | $A^T W A c=A^T W y$ | 离散法方程 |
| `<eq:normal-equation-conditioning>` | $kappa_2(A^T A)=kappa_2(A)^2$ | 条件数平方 |
| `<eq:trig-coefficients>` | $c_k=1/N sum_j y_j e^(-"i"k x_j)$ | 三角插值系数 = DFT |
| `<eq:aliasing>` | $c_k=sum_(l in bb(Z)) hat(f)(k+l N)$ | 混叠公式 |

## 八、图片规划

| # | 文件名 | 标签 | 内容 | 布局 | 优先级 |
|---|---|---|---|---|---|
| 1 | `chebyshev-extrema-zeros.svg` | `<fig:chebyshev-extrema-zeros>` | (a) $T_5$ 在 $[-1,1]$ 上的振荡，标注 5 个零点与 6 个极值点；(b) 首一多项式 $2^(-4)T_5$ 与 $plus.minus 2^(-4)$ 包络，显示「最小可能的偏差」 | 双面板纵向 | A |
| 2 | `least-squares-fit.svg` | `<fig:least-squares-fit>` | 数据点、拟合直线 $y=0.9+1.4x$、竖直残差线段，标注 SSE $=0.2$ | 单面板 | B |
| 3 | `aliasing.svg` | `<fig:aliasing>` | 连续 $cos 5x$（灰实线）与插值 $cos 4x$（蓝虚线），9 个采样点同时落在两条曲线上，标注 $5 equiv -4 (mod 9)$ | 单面板 | B |

写作时用 `wiki/assets/null.svg` 复制为占位；完成后在 `scripts/` 下写 `chebyshev-extrema-zeros.py`、`least-squares-fit.py`、`aliasing.py`，`uv run` 生成 SVG。

## 九、教材对照

| 教材 | 对应内容 | 本章差异 |
|---|---|---|
| 李庆扬《数值分析》第 5 版第 3 章 | 函数逼近基本概念、正交多项式、最佳一致逼近、最佳平方逼近、最小二乘拟合、有理逼近、三角逼近与 FFT | 顺序改为按范数展开；有理逼近压缩为注记；三角逼近聚焦插值与混叠，DFT/FFT 交给 `Analyse Harmonique` |
| Burden & Faires 第 10 版第 8 章 | 离散最小二乘、正交多项式与平方逼近、Chebyshev 与 economization、有理逼近、三角多项式逼近、FFT | 把「离散最小二乘」后置到 §5.5，使连续平方逼近（§5.3）与正交多项式（§5.4）先建立理论；其余对应 |

## 十、写作顺序建议

1. 章首导言 + §5.1（定义、存在性引理、交错定理、de la Vallée Poussin）→ 编译验证
2. §5.1 余下（Remez、例题、有理逼近注记）+ §5.2（Chebyshev 定义/性质/极小偏差/节点最优/压缩）→ 编译验证
3. §5.3（连续法方程、误差恒等式、两个例题）→ 编译验证
4. §5.4（正交多项式、四族表、递推、零点、正交展开、Legendre 例、Clenshaw）→ 编译验证
5. §5.5（离散最小二乘、条件数、离散正交基、两个拟合例、QR 前瞻）→ 编译验证
6. §5.6（三角插值、DFT 引用、混叠、余弦例、收敛注记、FFT 引用）→ 编译验证
7. 三张图的脚本与占位替换 → 最终 `typst compile` 退出码 0

每节写完后执行 `[_\^]([a-zA-Z]+)\(` 自查与 `rg "§"` 自查（正文不得出现 `§x.y`）。

## 十一、决策记录

| 决策点 | 选定方案 | 理由 |
|---|---|---|
| §5.6 的定位 | 聚焦三角插值与混叠，DFT/FFT 仅引用 | DFT 已在 `Analyse Harmonique` 附录完整给出，重讲违反 SRP |
| §5.1 / §5.2 顺序 | 先一致逼近，后 Chebyshev | 「存在 → 刻画 → 构造」；Chebyshev 多项式作为交错定理的显式极小元出现 |
| 配图 | 3 张 | 每节核心直觉各一张；不硬凑 Runge 对照图（Ch4 已有 `fig:runge-phenomenon`） |
