#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Théorie des Nombres", // 数论
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Théorie des Nombres", // 数论
  "Violet",
  subtitle: "A notebook for number theory",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.1.0",
  extra-info: "This is a notebook for number theory.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
// 主线叙事 (Main Narrative):
//   整除基础 → 模结构与剩余理论 → 算术函数与素数分布 → 逼近与不定方程
//   研究对象从 ℤ 上的整除算术出发，经模结构（CRT、Fermat–Euler、
//   原根、二次互反）逐步深化，再借算术函数把"计数与分布"工具化，
//   最后以连分数与不定方程收束为经典应用。
//
// 职责边界 (Responsibility Boundaries):
//   - 整数的整除/同余/原根/二次剩余/数论函数/连分数/不定方程 → 本笔记核心内容
//   - 环论视角（剩余类环 ℤ_n、CRT 的环同构、UFD/PID/ED、有限域、分圆域）
//     → Algèbre Abstraite，本笔记用算术语言自含并作结构交叉引用
//   - 多项式整除性、有理根、Eisenstein 判据 → Polynôme（本笔记不重复）
//   - 完整解析数论（PNT 证明、L-函数）→ 本笔记仅概述，完整理论归未来解析数论笔记
//   - p-adic 数、二元二次型、数的分拆等 → 超出范围，仅在 §8.3 展望
//
// 参考教材 (Reference Textbooks):
//   - 华罗庚《华罗庚文集 · 数论卷 II（数论导引）》科学出版社, 2010
//   - 余红兵《数论》华东师范大学出版社, 2011
//
// 结构：4 Parts, 10 Chapters, 约 40 Sections
// ==========================================================================
// Part I — Divisibility Theory（整除理论）
// ==========================================================================
// 设计思路：从 ℤ 上的整除结构出发建立全书根基：带余除法与进位制、
// gcd/lcm、辗转相除法与 Bézout 恒等式，再以素数无穷性与算术基本定理收束。
// 对应教材：华罗庚 Ch1（整数之分解）；余红兵 §1–3
// 对应 LaTeX：chap01.tex（拆分为 Ch1 与 Ch2）

// --- Chapter 1: Divisibility（整除性）---
//   核心洞察：带余除法是 ℤ 上"除"的完备答案——gcd 存在、Bézout 线性表示、
//   gcd·lcm 恒等式均由它机械推出；Ch2 的唯一分解即此引擎的首次总爆发。
//   Section 1.1: Integers and Floor/Ceiling Functions（整数与取整函数）
//     - 良序原理 #proposition <prop:well-ordering>（证明引擎，§1.2/§1.5 回链）
//     - floor/ceiling 与小数部分 #definition <def:floor-ceiling>；
//       刻画 <prop:floor-basic>、平移对偶 <prop:floor-identities>；<eq:hermite-identity>
//     - Hermite 恒等式 <prop:hermite-identity>（小数部分 1/n 网格统计）
//     - 数值例 <ex:floor-values>；#note 取整函数供 Ch7 求和消费（伏笔）
//   Section 1.2: Divisibility and the Division Algorithm（整除性与带余除法）
//     - 整除定义 #definition <def:divisibility>；运算律表 #property <prop:divisibility-rules>
//       （真因子 prose 概念，供 Ch2 素数定义）；Polynôme 多项式版仅 #note 划界
//     - 带余除法定理 #theorem <thm:division-algorithm>（良序取最小剩余 + 唯一性反证）
//     - 核心式 <eq:division-identity>；数值例 <ex:division-example>（含负数情形）
//     - #note 带余除法引向同余 Ch3 / 欧几里得引理 Ch2（伏笔）
//   Section 1.3: Numeral Systems（进位制）
//     - r 进制展开 #definition <def:numeral-system>；唯一性由反复带余除法（回链 thm）
//     - 转换例 <ex:base-conversion>；平衡三进制 #note（竞赛向，简明）
//   Section 1.4: GCD and LCM（最大公因数与最小公倍数）
//     - gcd/lcm/互素 #definition <def:gcd> <def:lcm> <def:coprime>
//     - 初等性质 #proposition <prop:gcd-basic>；
//       gcd | 一切线性组合 #corollary <cor:gcd-divides-linear>
//     - 例 <ex:gcd-lcm-example>（观察 6·90 = 18·30，暂不证）
//     - 乘积恒等式 |ab| 证明依赖 Bézout，留 §1.5 <cor:gcd-lcm-product> 兑现
//   Section 1.5: Euclidean Algorithm and Bézout's Identity（辗转相除法与 Bézout 恒等式）
//     - 换余引理 #lemma <lem:gcd-substitution>（公约数集合相等）
//     - 辗转相除法 #theorem <thm:euclidean-algorithm>（余数严格递减 ⇒ 有限步）
//     - Bézout 恒等式 #theorem <thm:bezout>（Euclid 步骤反向归纳构造）
//     - 算法呈现：编号算法框 + 回代表（非 C++ 代码块）；例 <ex:euclid-example>
//       <ex:bezout-example>（252 与 105：21 = 5·105 − 2·252）
//     - 互素判据 #corollary <cor:bezout-coprime>；核心式 <eq:bezout>
//     - 乘积恒等式 <cor:gcd-lcm-product> + <eq:gcd-lcm-product>（互素可消去引理）
//     - 章末 #note：Bézout → Ch10 §10.1 一次不定方程通解（兑现蓝图伏笔）
//   图片：fig:euclid-rectangle（img/euclid-rectangle.svg，24×9 矩形切 9²,9²,6²,3²,3²
//     → gcd 3；A 级核心图；占位先复制 0.Wiki/null.svg）
//   写作顺序：§1.2 定义+带余除法 → §1.1 良序/取整 → §1.4 → §1.5 → §1.3 → 章首串联；
//     每 1-2 节编译一次，编译检查点：§1.2 后、§1.5 后、全章终检

// --- Chapter 2: Primes and the Fundamental Theorem of Arithmetic（素数与算术基本定理）---
//   核心洞察：素数的原子性 p | ab ⇒ p | a∨p | b（Euclid 引理）由 Ch1 整除/Bézout 工具
//   直接产出（兑现 §1.2/章末伏笔），唯一分解随后把乘法问题化为逐素数指数问题，
//   gcd/lcm 变 min/max、阶乘指数由 Legendre 求和给出——"乘法问题加法化"。
//   Section 2.1: Prime Numbers and the Infinitude of Primes（素数及其无穷性）
//     - 素数/合数定义 #definition <def:prime-composite>（回链 def:divisibility 真因子）；
//       #caution：1 既非素亦非合、非正整数排除
//     - 最小素因子引理 #lemma <lem:least-prime-divisor>（良序取最小 + 反证）
//     - 合数有 ≤√n 素因子 #corollary <cor:composite-sqrt-bound>（§2.3 筛法依据）
//     - Euclid 无穷性 #theorem <thm:infinitude-of-primes>（N = p₁…pₖ + 1，不依赖 FTA）
//     - Euclid 引理（素数整除性）#theorem <thm:euclid-lemma>（兑现 §1.2 承诺；证明用
//       gcd(p,a)=1 + §1.5 互素可消去引理 <lem:coprime-divisibility>）
//     - 多因子推广 #corollary <cor:euclid-lemma-product>（§2.2 唯一性引擎）
//     - 例 <ex:prime-table>（≤30 素数、2 唯一偶素）；#note 素数 vs 环论 irreducible/prime
//       → Algèbre Abstraite UFD 划界
//   Section 2.2: The Fundamental Theorem of Arithmetic（算术基本定理）
//     - 算术基本定理 #theorem <thm:fta>（存在性：强归纳；唯一性：Euclid 引理逐因子消去）
//     - 标准分解式 #definition <def:prime-factorization> + 核心式 <eq:canonical-form>
//     - 例 <ex:factorization-example>（72, 1000, 360, 1001）；#note n = 1 空积约定
//     - 例 <ex:sqrt2-irrational>（FTA 指数奇偶对比，唯一性第一个 payoff）
//     - #note 预告 §2.4 v_p 语言
//   Section 2.3: Sieve Methods（筛法；仅 Eratosthenes + 试除，无代码块，编号步骤呈现）
//     - 筛法正确性 #proposition <prop:sieve-correctness>（cor:composite-sqrt-bound 反命题）
//     - 算法：编号步骤 1-4（从 p² 开始划，p² > N 停）
//     - 图：fig:sieve-grid（img/eratosthenes-sieve.svg，1-100 筛去 2,3,5,7 倍数后余 25 素数；
//       B 级核心图；占位已复制 0.Wiki/null.svg）
//     - 例 <ex:sieve-example>（≤100 逐素数划去；@fig:sieve-grid 验证 25 个素数）
//     - #note 筛法是列示非测试；素性判定/π(x) → Ch8 §8.1/§8.4（前瞻）
//   Section 2.4: Applications of Unique Factorization（唯一分解的应用）
//     - p 进指数 v_p #definition <def:p-adic-valuation> + <eq:valuation-def>
//       （v_p(n) = p^k || n 的最大 k；除法转指数不等式，Ch7 反复消费）
//     - gcd/lcm 指数公式 #corollary <cor:gcd-lcm-valuation> + <eq:gcd-lcm-valuation>
//       （v_p(gcd) = min、v_p(lcm) = max；与 §1.5 乘积恒等式 <cor:gcd-lcm-product> 闭环验证）
//     - 例 <ex:gcd-lcm-valuation>（72 与 84 的分解式 gcd/lcm）
//     - Legendre 公式 #theorem <thm:legendre-formula> + <eq:legendre-formula>
//       （v_p(n!) = Σ⌊n/p^k⌋，逐层计 p^k 的倍数；回链 def:floor-ceiling §1.1）
//     - 例 <ex:legendre-example>（v₅(100!) = 24、v₂ = 97、末尾零 min = 24）
//     - #note 前瞻 Ch8 §8.2（中二项式系数、Chebyshev、Bertrand）
//   图片：fig:sieve-grid（详见 §2.3；全章仅此 1 张，占位后任务收尾给提示词）
//   写作顺序：§2.1 → §2.2 → §2.3 → §2.4 逐节写入，每节编译一次；
//     编译检查点：§2.1 后、§2.2 后、§2.3 后、全章终检
//   承诺：兑现 Ch1 §1.2 note（L473-476）与 Ch1 章末 prose（L839-845）的
//     "Euclidean lemma" 伏笔 → §2.1 <thm:euclid-lemma>；埋 Ch7 v_p 消费、
//     Ch8 Legendre/筛法/素性判定前瞻


// ==========================================================================
// Part II — Theory of Congruences（同余理论）
// ==========================================================================
// 设计思路：模结构逐级深化。先建立同余语言与 CRT（环同构视角交叉引用
// Algèbre Abstraite），再证 Fermat–Euler–Wilson 三定理，继而研究阶与
// 原根（(ℤ/mℤ)ˣ 的循环结构），最后以二次剩余与互反律收束为本部分
// 最完整的经典定理。原根板块显式列出，避免隐藏于同余章。
// 对应教材：华罗庚 Ch2（同余式）、Ch3（二次剩余）；余红兵 Ch6
// 对应 LaTeX：chap02.tex（拆为 Ch3–Ch5），chap03.tex（→ Ch6）

// --- Chapter 3: Basic Theory of Congruences（同余的基本理论）---
//   核心洞察：同余把"b | (a−a′)"重铸为 ℤ 上的等价关系 ≡，令"模 m 算术"独立成
//   对象；一次同余 ax ≡ b (mod m) 的可解性由 gcd(a,m) 全权决定（Bézout 首次
//   应用），CRT 说明互素模可分解再拼合——Part II 结构定理（Fermat–Euler–Wilson、
//   原根、二次剩余）的全部语言地基。
//   Section 3.1: Congruences and Their Properties（同余及其性质）
//     - 同余定义 #definition <def:congruence> + <eq:congruence-def>
//       （a ≡ b (mod m) ⟺ m | (a−b)；回链 def:divisibility；≡ 是等价关系 prose）
//     - 运算律 #property <prop:congruence-basic>（同加减乘/移项/乘同数/换小模 d | m）
//     - 消去律 #proposition <prop:congruence-cancellation>
//       （ac ≡ bc (mod m) ⟺ a ≡ b (mod m/gcd(c,m))；证明回链 §1.5
//       <lem:coprime-divisibility>；gcd(c,m) = 1 可消去为关键特例）
//     - 例 <ex:congruence-clock>（时钟 mod 12 / 星期 mod 7）；#note 同余保持
//       P(a) ≡ P(b)（整数多项式求值；Ch5 指标/幂方程伏笔）
//   Section 3.2: Residue Classes and Systems（剩余类与剩余系）
//     - 剩余类 #definition <def:residue-class>（bar(a)_m = {a + k m}，等价类视角）
//     - 完全剩余系 #definition <def:complete-residue-system>（{0,…,m−1}；平移仍 CRS）
//     - 既约剩余系 #definition <def:reduced-residue-system>（与 m 互素的代表，
//       个数记 φ(m)，正式定义 §3.5 <def:phi-function>）
//     - RRS 乘法封闭 #property <prop:reduced-closed>（(a,m) = (b,m) = 1 ⟹
//       (ab,m) = 1；证明用 @thm:euclid-lemma：p | ab ⟹ p | a∨p | b）
//     - 例 <ex:residue-systems>（mod 8 与 mod 12 的 CRS/RRS 表；mod 12 乘法表
//       验证 {1,5,7,11} 封闭）
//     - #note 互素类在乘法下有逆（@thm:bezout），预告 §3.3 逆元；RRS 结构 →
//       Ch5 原根（伏笔）
//   Section 3.3: Linear Congruences（一次同余）
//     - 乘法逆元 #definition <def:modular-inverse>（ax ≡ 1 (mod m)，存在 ⟺
//       gcd(a,m) = 1；算法沿用 §1.5 Euclid 回代表）
//     - 可解判据 #theorem <thm:linear-congruence>（d = gcd(a,m) | b ⟺ 可解；
//       模 m 下恰 d 个解；约化到模 m/d 的唯一类后回代 d 个代表）
//     - 互素唯一解 #corollary <cor:linear-congruence-coprime>
//       （x ≡ a⁻¹b (mod m)）
//     - 求解算法：编号步骤 1–3（非代码块）；例 <ex:linear-congruence>
//       （6x ≡ 15 (mod 21)：d = 3、三个解；14x ≡ 3 (mod 31) 用回代表求逆）
//   Section 3.4: The Chinese Remainder Theorem（中国剩余定理）
//     - 两两互素乘积引理 #lemma <lem:pairwise-coprime-product>
//       （可用 v_p 指数路线，回链 def:p-adic-valuation；CRT 唯一性引擎）
//     - 中国剩余定理 #theorem <thm:crt>（m_i 两两互素 ⟹ 模 M = Πm_i 唯一解；
//       构造 x ≡ Σ a_i M_i y_i (mod M)，M_i = M/m_i，y_i 为 M_i 的逆 mod m_i；
//       唯一性用 <lem:pairwise-coprime-product>）
//     - 例 <ex:crt-sunzi>（孙子算经"物不知数"：≡ 2,3,2 (mod 3,5,7) → 23 (mod 105)）
//     - 非互素合并：#note 相容条件 a ≡ b (mod gcd(m,n))、解 mod lcm(m,n)；
//       例 <ex:crt-noncoprime>（x ≡ 7 (mod 12), x ≡ 3 (mod 8) → 19 (mod 24)）
//       附不相容反例（x ≡ 5 (mod 8) 时）；#note 环同构
//       ℤ_m ≅ ℤ_(m₁) × … × ℤ_(m_k) 视角划界 → Algèbre Abstraite 蓝图 §9.4
//       （算术语言自含，仅 note 交叉引用）
//   Section 3.5: Euler's φ Function（Euler φ 函数）
//     - φ 定义 #definition <def:phi-function> + <eq:phi-def>（φ(1) = 1；
//       φ(m) = #{1 ≤ k ≤ m : gcd(k,m) = 1} = RRS 大小，回链 §3.2）
//     - 素幂计数 φ(p^α) = p^α − p^(α−1)（prose/公式）
//     - 乘法性 #proposition <prop:phi-multiplicative>（gcd(m,n) = 1 ⟹
//       φ(mn) = φ(m)φ(n)；证明 = CRT 双射 <thm:crt>，结构性 payoff；
//       Ch7 卷积框架再抽象）
//     - 一般公式 #theorem <thm:phi-formula> + <eq:phi-formula>
//       （φ(n) = n∏_(p|n)(1 − 1/p)；FTA + 乘法性 + 素幂公式叠加）
//     - 例 <ex:phi-values>（φ(360) = 96；φ(1..12) 数值表）
//     - #note 前瞻：Euler 定理 a^φ(m) ≡ 1 → Ch4；φ(φ(m)) → Ch5 §5.2；
//       φ 积性 → Ch7 §7.1/§7.3 卷积与 Möbius
//   图片：全章无图（纯代数推导，CRT/φ 以文字与表格清晰呈现，C 类省略不硬凑）
//   写作顺序：§3.1 → §3.2 → §3.3 → §3.4 → §3.5 逐节写入，每节编译一次；
//     编译检查点：§3.1 后、§3.2 后、§3.3 后、§3.4 后、全章终检
//   承诺：兑现 Ch1 §1.2 note（L504-506，"becomes the language of congruences
//     in Chapter 3"）与 Ch2 章末 prose（L1363-1367，equivalence classes 预告）
//     → §3.1 <def:congruence>；埋 Ch4 Euler 定理（φ/RRS）、Ch5 原根结构、
//     Ch5 指标/幂方程、Ch7 卷积（φ 积性）、Algèbre Abstraite 环同构（跨笔记）

// --- Chapter 4: Theorems of Fermat, Euler, and Wilson（Fermat–Euler–Wilson 定理）---
//   Section 4.1: Fermat's Little Theorem（Fermat 小定理）
//     - a^p ≡ a (mod p)；组合与群论两种证明
//   Section 4.2: Euler's Theorem（Euler 定理）
//     - a^φ(m) ≡ 1 (mod m) 及其推论
//   Section 4.3: Wilson's Theorem（Wilson 定理）
//     - (p-1)! ≡ -1 (mod p) 及逆定理
//   Section 4.4: Applications（应用与伪素数）
//     - 快速模幂（C++ 实现）
//     - Fermat 伪素数、Carmichael 数（引向 Ch8 §8.4）

// --- Chapter 5: Primitive Roots and Discrete Logarithms（原根与离散对数）---
//   核心洞察：Euler 定理的周期 φ(m) 在"好模"上能被取满——存在阶恰为 φ(m)
//   的生成元，其幂次穷尽全部互素类（(ℤ/mℤ)ˣ 循环）；指标（离散对数）把乘法
//   翻译成模 φ(m) 的加法，于是幂方程 x^k ≡ a 坍缩为一次同余。Part II 结构理论
//   的高潮，依赖 Ch3/Ch4 全部底座，不需任何新分析工具（多项式根数界自含）。
//   期望目标：① 给出阶的完整工具（整除 φ、幂的阶、周期判据、LCM 可达）；
//   ② 证明原根存在性（p、p^α、2p^α）并给"当且仅当"完整分类 m ∈ {1,2,4,p^α,
//   2p^α}（含"只当"排除证明，蓝图原为存在性三款，本轮决策扩展为闭环分类）；
//   ③ 建立指标运算律与幂方程求解（化为线性同余回链 §3.3）；
//   ④ 幂剩余判据 a^((p−1)/d) ≡ 1 与计数；n = 2 仅预告 Ch6（不预写 Euler 判据，
//   SRP）。决策：证明路线取 max-order + LCM 引理（绕开 Σφ(d) = n，避免与 Ch7
//   §7.3 卷积内容重复）；全章不配图（延续 Ch3/Ch4 纯代数风格，阶表/指标表承担
//   直观）。Section 顺序 = 结构(§5.1) → 存在与分类(§5.2) → 应用(§5.3/§5.4)。
//   Section 5.1: The Order of an Element（元素的阶）
//     - 阶定义 #definition <def:order-of-element>（gcd(a,m) = 1 时最小 t > 0 使
//       a^t ≡ 1 (mod m)；存在性由 Euler 定理 <thm:euler-theorem> 保证）
//     - 阶整除 φ(m) #proposition <prop:order-divides-phi>（带余除法 + 最小性；
//       兑现 ex:euler-example 注"隔离最小周期"）
//     - 幂的阶 #proposition <prop:order-power>（ord(a^k) = ord(a)/gcd(ord(a), k)；
//       供 §5.2 计数与 §5.3 幂方程反复消费）
//     - 周期判据 #proposition <prop:order-periodicity>（a^r ≡ a^s (mod m) ⟺
//       r ≡ s (mod ord_m(a))；指标唯一性引擎）
//     - LCM 可达引理 #lemma <lem:order-lcm>（ord a = r、ord b = s ⟹ 存在 c 使
//       ord c = lcm(r, s)；内证互素阶乘积子步；供 §5.2 主定理反证）
//     - 例 <ex:order-table>（mod 7 各元素阶表；2 的阶 3 是 φ(6) 的真因子，
//       呼应 <ex:euler-example>）；#note 互素类按阶分层与 RRS 结构（兑现
//       Ch3 §3.2 note L1695-1699），引向 §5.2
//   Section 5.2: Existence of Primitive Roots（原根的存在性）
//     - 原根定义 #definition <def:primitive-root>（阶 = φ(m)，幂穷尽 RRS；
//       回链 <def:reduced-residue-system>）
//     - 原根计数 #proposition <prop:primitive-root-power> + #corollary
//       <cor:primitive-root-count>（g^k 原根 ⟺ gcd(k, φ(m)) = 1，故恰 φ(φ(m))
//       个；兑现 Ch3 §3.5 note L2127-2132）
//     - 多项式根数界 #lemma <lem:poly-roots-bound>（模素 p：d 次多项式至多 d 个
//       解；归纳 + 因式定理 mod p，途中用 @thm:euclid-lemma；算术自含）
//     - 素数原根存在性 #theorem <thm:primitive-root-prime>（max-order 路线：
//       l = max{ord}，反证所有阶整除 l（@lem:order-lcm），x^l − 1 有 p − 1 个根
//       逼出 l = p − 1；决策：不用 N(d) = φ(d) 分圆计数，避开 Σφ(d) = n 归 Ch7）
//     - 二项式提升引理 #lemma <lem:binom-power-lift>（(1 + p^k u)^p ≡
//       1 + p^(k+1) u (mod p^(k+2))，k ≥ 1；只需 @lem:binom-prime 整除系数）
//     - 素幂原根 #theorem <thm:primitive-root-prime-power>（模 p 原根 g：
//       g^(p−1) ≢ 1 (mod p²) 时直升，否则取 g + p；配 binom-power-lift 归纳抬升）
//     - 2p^α 原根 #corollary <cor:primitive-root-twice-power>（g 偶则取 g + p^α）
//     - 完整分类 #theorem <thm:primitive-root-classification>（原根存在 ⟺
//       m ∈ {1,2,4,p^α,2p^α}；"只当"两情形：① m = 2^k (k ≥ 3) 归纳得阶 ≤
//       2^(k−2)；② m 裂成互素 u,v > 2 时 φ(u)、φ(v) 皆偶，lcm 严格小于积；
//       回链 <prop:phi-multiplicative>；本轮决策纳入完整 iff 闭环）
//     - 例 <ex:primitive-roots-mod-prime>（mod 7 原根 {3,5}、mod 13 原根
//       {2,6,7,11}，验 φ(φ) 计数）；例 <ex:lifted-primitive-root>（2 模 25 原根、
//       mod 9 原根 2；展示提升定理小素数实例）
//   Section 5.3: Indices and Discrete Logarithms（指标与离散对数）
//     - 指标定义 #definition <def:index-logarithm>（固定原根 g，a ≡ g^(ind_g a)，
//       指数模 φ(m) 唯一；唯一性即 <prop:order-periodicity>；仅对有原根的模成立）
//     - 运算律 #proposition <prop:index-rules>（乘积→和、幂→倍数、换底公式；
//       乘法幂与加法指标同构的显式兑现——呼应 Ch3 §3.1 note L1568-1570）
//     - 例 <ex:index-table>（mod 13 以 2 为底的 12 值指标表，两行文本呈现）
//     - 幂方程 #theorem <thm:power-congruence>（x^k ≡ a (mod m) 有原根模：
//       换元 x = g^y 化为 k y ≡ ind(a) (mod φ(m))，回链 <thm:linear-congruence>
//       <cor:linear-congruence-coprime>；可解 ⟺ d = gcd(k, φ(m)) | ind(a)，
//       解数恰 d；兑现 Ch3 §3.3 note L1845-1847）
//     - 例 <ex:power-congruence>（x³ ≡ 5 (mod 13) 恰 3 解 {8,11,7}；x⁴ ≡ 2
//       (mod 13) 无解；验证 d | ind 判据）
//     - #note 离散对数计算困难性与密码学应用一句（不展开，非本笔记主线）
//   Section 5.4: Power Residues（幂剩余）
//     - 幂剩余定义 #definition <def:power-residue>（x^n ≡ a (mod m) 可解，
//       gcd(a,m) = 1）
//     - 判别条件 #theorem <thm:power-residue-criterion>（模素 p、d = gcd(n, p−1)：
//       a 为 n 次剩余 ⟺ a^((p−1)/d) ≡ 1 (mod p)；⇒ 向用 <thm:fermat-little>，
//       ⇐ 向原根化为整除 d | u 后线性可解；幂语言 ⇄ 指标语言双向示范）
//     - 计数 #proposition <prop:count-power-residues>（模 p 的 n 次剩余恰
//       (p−1)/d 个；指标视角 = 模 p−1 线性方程解数）
//     - 例 <ex:power-residues>（mod 7：二次剩余 {1,2,4}（(7−1)/2 = 3 个）、
//       三次剩余 {1,6}（(7−1)/3 = 2 个），判据双口径验证）
//     - #note n = 2 时即 Euler 判据雏形 a^((p−1)/2) ≡ 1，Legendre 记号与完整
//       理论属 Ch6 §6.1（SRP：本章不预写 Euler 判据）
//   图片：全章无图（纯代数，阶表/指标表以文字呈现，C 类省略；本轮决策确认）
//   写作顺序：§5.1 → §5.2 → §5.3 → §5.4 逐节写入，每节编译一次；
//     编译检查点：§5.1 后、§5.2 前后半各一次、§5.3 后、全章终检
//   承诺：兑现 Ch3 §3.1 note（L1530-1532 结构、L1568-1570 指标伏笔）、§3.2 note
//     （L1695-1699 RRS 结构）、§3.3 note（L1845-1847 线性同余工具）、§3.5 note
//     （L2127-2132 φ(φ(m))）、Ch4 §4.2 note（L2346-2350 最小周期、L2354-2359 群
//     视角）与 Ch4 章末 prose（L2582-2587 阶与原根）共 8 处；埋 Ch6 Euler 判据/
//     Legendre（n = 2 特例）；跨笔记引用 Algèbre Abstraite（(ℤ/mℤ)ˣ 循环结构）

// --- Chapter 6: Quadratic Residues and the Law of Quadratic Reciprocity（二次剩余与二次互反律）---
//   Section 6.1: Quadratic Residues and Legendre Symbols（二次剩余与 Legendre 符号）
//     - Euler 判据、Legendre 符号及其运算律
//   Section 6.2: Gauss's Lemma（Gauss 引理）
//     - 特殊值 (-1/p)、(2/p)
//   Section 6.3: The Law of Quadratic Reciprocity（二次互反律）
//     - 互反律陈述、证明与应用
//   Section 6.4: Jacobi Symbols（Jacobi 符号）
//     - 定义、性质与互反律推广

// ==========================================================================
// Part III — Arithmetic Functions and the Distribution of Primes（数论函数与素数分布）
// ==========================================================================
// 设计思路：把计数直觉抽象为积性函数与 Dirichlet 卷积（方法论章），
// 紧接着将其作为研究素数分布的工具（π(x) 的初等估计、Bertrand 假定与
// Chebyshev 界）；Dirichlet 定理与素数定理仅作概述，注明通向未来解析数论笔记。
// 原 LaTeX "渐进法与连分数" 章的解析部分在此落地为 Ch8。
// 对应教材：华罗庚 Ch5（素数分布概况）、Ch6（数论函数）
// 对应 LaTeX：chap04.tex（→ Ch7），chap05.tex（→ Ch8）

// --- Chapter 7: Arithmetic Functions（数论函数）---
//   Section 7.1: Multiplicative Functions（积性函数）
//     - 积性与完全积性；τ、σ、φ 的积性
//   Section 7.2: Dirichlet Convolution and Möbius Inversion（Dirichlet 卷积与 Möbius 反演）
//     - 卷积代数、μ 函数、Möbius 反演公式
//   Section 7.3: Further Properties of φ and σ（φ 与 σ 的深入性质）
//     - Σ_(d|n) φ(d) = n、φ 与 μ 的关系、除数函数高阶公式
//   Section 7.4: Summatory Functions（和函数初步）
//     - 求和技巧与平均阶的直观（为 Ch8 提供估计语料）

// --- Chapter 8: Distribution of Primes（素数分布）---
//   Section 8.1: The Function π(x)（π(x) 与素数无穷的再证）
//     - Euclid 变体、调和级数发散 → 素数无穷
//   Section 8.2: Bertrand's Postulate and Chebyshev's Bounds（Bertrand 假定与 Chebyshev 界）
//     - 中二项式系数技巧；π(x) 的阶
//   Section 8.3: Dirichlet's Theorem and the Prime Number Theorem: An Overview（Dirichlet 定理与素数定理概述）
//     - 算术级数中的素数；PNT 表述与渐近含义
//     - 交叉引用 → 未来解析数论笔记；p-adic/分拆等展望
//   Section 8.4: Primality Testing and Open Problems（素性判定与开放问题）
//     - Miller–Rabin 概率素性判定（承接 Ch4 §4.4）
//     - 孪生素数、Goldbach、Riemann 假设一览

// ==========================================================================
// Part IV — Continued Fractions and Diophantine Equations（连分数与不定方程）
// ==========================================================================
// 设计思路：连分数提供实数的丢番图逼近与二次无理数的完整描述，是解 Pell
// 方程的工具；不定方程将全书方法（Bézout、勾股参数化、连分数、无穷递降）
// 收束为经典问题与竞赛应用。原 LaTeX ch06 连分数部分独立为 Ch9。
// 对应教材：华罗庚 Ch10（连分数）、Ch11（不定方程）；余红兵 §4 及竞赛选讲
// 对应 LaTeX：chap06.tex（拆分：解析部分→Ch8，连分数→Ch9），chap07.tex（→ Ch10）

// --- Chapter 9: Continued Fractions（连分数）---
//   Section 9.1: Finite and Infinite Continued Fractions（有限与无限连分数）
//     - 有限连分数与欧几里得算法（呼应 Ch1 §1.5）
//     - 无限连分数作为数列极限
//   Section 9.2: Convergents and Best Approximations（收敛子与最佳逼近）
//     - 收敛子递推关系、p_n q_(n-1) − p_(n-1) q_n = ±1
//     - 最佳逼近性质
//   Section 9.3: Periodic Continued Fractions（周期连分数）
//     - 二次无理数 ⟷ 周期连分数（Lagrange）
//     - √D 的展开
//   Section 9.4: Applications（逼近应用）
//     - 无理数逼近与丢番图逼近引论

// --- Chapter 10: Diophantine Equations（不定方程）---
//   Section 10.1: Linear Diophantine Equations（一次不定方程）
//     - ax + by = c 通解公式（收束 Ch1 Bézout）
//   Section 10.2: Pythagorean Triples（勾股数组）
//     - 本原勾股数组的结构与参数化
//   Section 10.3: The Pell Equation（Pell 方程）
//     - x² − Dy² = ±1；连分数求最小解与全部解（引用 Ch9）
//   Section 10.4: Fermat's Last Theorem and Infinite Descent（Fermat 大定理与无穷递降）
//     - n = 4 情形的无穷递降证明；历史与现状展望

// ==========================================================================
// 教材覆盖度映射表 (Coverage Mapping)
// ==========================================================================
// 华罗庚《数论导引》:
//   Ch1 整数之分解          → Part I (Ch1–Ch2)
//   Ch2 同余式              → Part II (Ch3–Ch5)
//   Ch3 二次剩余            → Ch6
//   Ch4 多项式之性质        → Polynôme 笔记（本笔记省略）
//   Ch5 素数分布概况        → Ch8
//   Ch6 数论函数            → Ch7
//   Ch9 素数定理            → Ch8 §8.3（概述，完整证明归解析数论）
//   Ch10 连分数             → Ch9
//   Ch11 不定方程           → Ch10
//   Ch7–8, Ch12–20（三角和、分拆、p-adic、二元二次型、模变换…）→ 展望，不入正文
// 余红兵《数论》:
//   整除/gcd·lcm/素数及唯一分解 → Part I；同余 → Ch3–4；不定方程 → Ch10
//   竞赛选讲技巧 → 分散嵌入各章例题与 Ch10 §10.4

// ==========================================================================
// 正文
// ==========================================================================

#part("Divisibility Theory") // 整除理论

= Divisibility // 整除性

Number theory — at its most classical, the study of the integers — opens
with a single operation that is far richer than it looks: division.
Where addition and multiplication assemble structure from a pair of
operands, division asks _when_ one integer fits inside another exactly,
and when it does not, how large the leftover is. That leftover — the
remainder — is the first quantitative answer, and the whole chapter is
the story of pushing this one idea: iterate the remainder, and you
extract the greatest common divisor of two integers; read the iteration
backwards, and you obtain the linear combination of Bézout's identity,
which will echo through every later chapter of this notebook.

== Integers and Floor/Ceiling Functions // 整数与取整函数

The raw material of the chapter is $bb(Z) = {dots, -2, -1, 0, 1, 2,
  dots}$, the set of integers, with its usual order and its usual
arithmetic. Before doing any division we record the one ordering fact
that makes proofs about $bb(Z)$ work like proofs by induction, but
without the ceremony.

#proposition(name: "Well-Ordering Principle")[
  Every nonempty subset of the positive integers
  $bb(Z)^+ = {1, 2, 3, dots}$ contains a least element. Equivalently,
  every nonempty subset of $bb(Z)$ that is bounded below has a least
  element.
] <prop:well-ordering>

#note[
  This principle is logically equivalent to mathematical induction:
  each can be derived from the other. We take it as an accepted starting
  point and use it as the engine of the Division Algorithm (§1.2) and
  the Euclidean Algorithm (§1.5), where it guarantees that a certain
  decreasing sequence of nonnegative remainders must stop.
]

Division in $bb(Z)$ produces quotients and remainders, and to describe
the sizes of remainders we need notation for "rounding down". The floor
function goes back to the *integer part* of Carl Friedrich Gauss,
usually written $[x]$ in number-theoretic texts.

#definition(name: "Floor, Ceiling and Fractional Part")[
  Let $x in bb(R)$.
  - The *floor* of $x$, written $floor(x)$ or, in the Gauss bracket
    notation, $[x]$, is the greatest integer not exceeding $x$:
    $floor(x) = m$ where $m in bb(Z)$ satisfies $m <= x < m + 1$.
  - The *ceiling* of $x$, written $ceil(x)$, is the least integer not
    smaller than $x$: $ceil(x) = m$ where $m - 1 < x <= m$.
  - The *fractional part* of $x$ is ${x} = x - floor(x)$, an element of
    the half-open interval $[0, 1)$.
] <def:floor-ceiling>

#example(name: "Numerical Values")[
  $floor(7\/2) = 3$, $floor(-7\/2) = -4$ (note: rounding down, not
  towards zero), $ceil(7\/2) = 4$, $ceil(-7\/2) = -3$, and
  $floor(3) = ceil(3) = 3$. For the fractional part:
  ${7\/2} = 1\/2$, while ${-7\/2} = -7\/2 - (-4) = 1\/2$.
] <ex:floor-values>

#property(name: "Fundamental Properties of the Floor")[
  For $x in bb(R)$ and $n in bb(Z)$:
  - $x - 1 < floor(x) <= x$, so $floor(x)$ is the *unique* integer $m$
    with $m <= x < m + 1$;
  - $floor(x) = x$ iff $x in bb(Z)$;
  - *translation*: $floor(x + n) = floor(x) + n$;
  - *monotonicity*: $x <= y$ implies $floor(x) <= floor(y)$.
] <prop:floor-basic>

#property(name: "Duality and Complementary Identities")[
  For $x in bb(R)$:
  - *duality*: $ceil(x) = -floor(-x)$ and $floor(x) = -ceil(-x)$;
  - $ceil(x) - floor(x)$ equals $0$ if $x in bb(Z)$ and $1$ otherwise;
  - $x = floor(x) + {x}$ with $0 <= {x} < 1$; in particular
    ${x} = 0$ iff $x in bb(Z)$.
] <prop:floor-identities>

The single most useful identity of this section tiles the unit interval
into $n$ equal cells and counts how many of the shifted points
$x + k\/n$ cross an integer boundary. The result is due to Charles
Hermite.

#proposition(name: "Hermite's Identity")[
  Let $n in bb(Z)^+$ and $x in bb(R)$. Then
  #eq[
    $sum_(k=0)^(n-1) floor(x + k\/n) = floor(n x)$.
  ] <eq:hermite-identity>
] <prop:hermite-identity>

#proof(name: "of Hermite's identity")[
  Write $x = m + theta$ with $m = floor(x) in bb(Z)$ and
  $0 <= theta < 1$. Since $m$ is an integer, translation gives
  $floor(x + k\/n) = m + floor(theta + k\/n)$, so the left-hand side
  equals $n m + sum_(k=0)^(n-1) floor(theta + k\/n)$, while the
  right-hand side is $floor(n m + n theta) = n m + floor(n theta)$.
  It remains to show
  $
    sum_(k=0)^(n-1) floor(theta + k\/n) = floor(n theta)
    quad (0 <= theta < 1).
  $

  For such a $theta$, each term $floor(theta + k\/n)$ is $0$ or $1$, and
  it equals $1$ exactly when $theta + k\/n >= 1$, i.e. when
  $k >= n(1 - theta)$. Let $ell = floor(n theta)$, so that
  $n theta in [ell, ell + 1)$ and therefore
  $n(1 - theta) in (n - ell - 1, n - ell]$. The integers
  $k in {0, 1, dots, n - 1}$ with $k >= n(1 - theta)$ are precisely
  $k = n - ell, dots, n - 1$: there are exactly $ell = floor(n theta)$
  of them. Hence the sum equals $floor(n theta)$, as claimed.
]

#note[
  A good picture: $theta$ fixes a point in $[0, 1)$; the sum counts how
  many of the $n$ cells of the uniform grid
  $0 < 1\/n < 2\/n < dots < 1$ are "to the left" of $theta$ in the
  wrapped sense of the identity. This grid-counting viewpoint will
  reappear when summatory estimates are developed in Chapter 7.
]

== Divisibility and the Division Algorithm // 整除性与带余除法

The central relation of elementary number theory is divisibility: one
integer "goes evenly into" another. Everything else — common divisors,
primes, unique factorization — is built from this definition.

#definition(name: "Divisibility")[
  Let $a, b in bb(Z)$ with $a != 0$. We say that $a$ *divides* $b$, and
  write $a | b$, if there exists an integer $c$ such that $b = a c$.
  - If $a | b$, then $a$ is a *divisor* (or *factor*) of $b$, and $b$ is
    a *multiple* of $a$.
  - If $a | b$ and $abs(a) < abs(b)$, then $a$ is a *proper divisor* of
    $b$; if in addition $abs(a) != 1$, it is a *nontrivial proper
    divisor*.
] <def:divisibility>

#caution[
  Divisibility is only defined for a *nonzero* divisor. The case $a = 0$
  is degenerate: the equation $b = 0 dot c$ forces $b = 0$, so $0$
  divides only $0$ — and that convention causes nothing but confusion,
  so we simply exclude it from the definition.
]

#property(name: "Basic Rules of Divisibility")[
  Let $a, b, c in bb(Z)$ with $a != 0$.
  - $a | a$, $a | 0$; $1 | a$ and $(-1) | a$ for every integer $a$.
  - *transitivity*: $a | b$ and $b | c$ imply $a | c$.
  - *linear combinations*: $a | b$ and $a | c$ imply
    $a | (b x + c y)$ for all $x, y in bb(Z)$.
  - *size bound*: if $b != 0$ and $a | b$, then $abs(a) <= abs(b)$.
  - $a | b$ and $b | a$ imply $b = plus.minus a$.
  - $a | 1$ iff $a = plus.minus 1$.
] <prop:divisibility-rules>

#proof(name: "of the rules")[
  Transitivity: $b = a u$ and $c = b v$ give $c = a (u v)$. For linear
  combinations: $b = a u$, $c = a v$, hence $b x + c y = a (u x + v y)$.
  For the size bound, $b = a c$ with $b != 0$ forces $abs(c) >= 1$, so
  $abs(b) = abs(a) abs(c) >= abs(a)$. The last two statements follow
  from the size bound applied twice (or directly from the definitions).
]

#note[
  For polynomials, the same notions appear with degrees in place of
  absolute values — divisibility in $P[x]$, the polynomial GCD and the
  Euclidean algorithm for polynomials are developed in the *Polynôme*
  note and are not repeated here. The integer version below is the
  prototype that the polynomial version imitates.
]

Division in the integers is only defined when the divisor divides
evenly. The fundamental tool repairs this gap: any two integers can be
divided, provided we allow a *remainder* smaller than the divisor. This
is the result that makes all of elementary number theory quantitative.

#theorem(name: "Division Algorithm")[
  Let $a in bb(Z)$ and $b in bb(Z)^+$. Then there exist *unique*
  integers $q$ and $r$ such that
  #eq[
    $a = b q + r, quad 0 <= r < b$.
  ] <eq:division-identity>
] <thm:division-algorithm>

#proof(name: "of the division algorithm")[
  *Existence.* Consider the set of nonnegative integers of the form
  $a - b k$ with $k in bb(Z)$:
  $
    S = {a - b k : k in bb(Z), a - b k >= 0}.
  $
  $S$ is nonempty: taking $k = -abs(a)$ gives
  $a - b(-abs(a)) = a + b abs(a) >= 0$. By the
  #link(<prop:well-ordering>)[well-ordering principle], $S$ has a least
  element $r = a - b q >= 0$. If $r >= b$, then
  $r - b = a - b(q + 1)$ is a smaller nonnegative element of $S$, a
  contradiction. Hence $0 <= r < b$, and $a = b q + r$.

  *Uniqueness.* Suppose $a = b q + r = b q' + r'$ with
  $0 <= r, r' < b$. Subtracting gives $b(q - q') = r' - r$. But
  $abs(r' - r) < b$, and $b$ divides $r' - r$; the only multiple of $b$
  in $(-b, b)$ is $0$. Therefore $r' = r$ and $q' = q$.
]

The integer $q$ is the *quotient* and $r$ the *remainder* of $a$ on
division by $b$. Note carefully what the condition $0 <= r < b$ means
for negative $a$: the remainder is always chosen nonnegative, which is
_not_ what a calculator does when it truncates toward zero.

#example(name: "Division with Remainder")[
  - $a = 17$, $b = 5$: $17 = 3 dot 5 + 2$, so $q = 3$, $r = 2$.
  - $a = -17$, $b = 5$: $-17 = (-4) dot 5 + 3$, so $q = -4$, $r = 3$.
    (Note $r = 3 >= 0$, while truncation toward zero would give
    $q = -3$, $r = -2$.)
  - $a = 0$, $b = 7$: $0 = 0 dot 7 + 0$, so $q = r = 0$.
  - $a = 42$, $b = 6$: $42 = 7 dot 6 + 0$, so $r = 0$: the remainder
    vanishes exactly when the divisor divides the dividend.
] <ex:division-example>

#note[
  Two roads open here. First, equality of remainders
  $r_1 = r_2$ after division by $b$ is exactly the relation
  $b | (a_1 - a_2)$, which becomes the language of congruences in
  Chapter 3. Second, when $b$ is prime the division algorithm will
  produce the Euclidean lemma that powers unique factorization in
  Chapter 2.
]

== Numeral Systems // 进位制

The division algorithm gives a canonical way to *write* every positive
integer: repeatedly strip off the remainder. This is where base-$r$
notation comes from — far from being a fact about "digits", it is an
iteration of §1.2, and its proof is a perfect first exercise in the
division-iteration technique that drives the whole chapter.

#definition(name: "Base-$r$ Numeral System")[
  Let $r >= 2$ be an integer, the *base*. A (finite) sequence of digits
  $(a_k, a_(k-1), dots, a_0)$ with $0 <= a_i < r$ represents the integer
  $
    N = a_k r^k + a_(k-1) r^(k-1) + dots + a_1 r + a_0,
  $
  written $N = (a_k a_(k-1) dots a_0)_r$. The leading digit $a_k$ is
  required to be nonzero (except for the number $0$ itself).
] <def:numeral-system>

Every positive integer has one and only one such representation: apply
the Division Algorithm to $N$ and $r$, obtaining
$N = r q_1 + a_0$ with $0 <= a_0 < r$; then to $q_1$, obtaining
$q_1 = r q_2 + a_1$; and so on. The quotients $q_i$ decrease strictly
while positive, so the process terminates; the last nonzero quotient is
the leading digit. Uniqueness follows by reading the same chain
backwards: if two representations agreed, subtracting them would
exhibit a positive multiple of $r$ strictly smaller than $r$ — the
bound $0 <= a_i < r$ is exactly what makes the writing unique.

#example(name: "Converting Between Bases")[
  - Write $37$ in base $5$: repeated division by $5$ gives
    $
      37 = 7 dot 5 + 2, quad 7 = 1 dot 5 + 2, quad 1 = 0 dot 5 + 1,
    $
    so the remainders, read from last to first, are $1, 2, 2$, and
    $37 = (122)_5 = 25 + 2 dot 5 + 2$.
  - The same number in base $2$: $37 = 32 + 4 + 1 = 2^5 + 2^2 + 1$, so
    $37 = (100101)_2$.
  - *From base $r$ to decimal* is expansion: $(122)_5 = 1 dot 25 + 2 dot
    5 + 2 = 37$. This is the easier direction.
] <ex:base-conversion>

#note[
  Requiring $0 <= a_i < r$ fixes a *unique* standard system. Loosening
  it produces exotic but useful cousins, of which the best known is the
  *balanced ternary* system with digits ${-1, 0, 1}$ in base $3$. It
  represents every integer (no sign needed) and reappears in
  computational contexts; we will not need it below, but the definition
  shows precisely which hypothesis was dropped.
]

== GCD and LCM // 最大公因数与最小公倍数

Common divisors are where divisibility becomes a relation between two
numbers rather than a property of one. The greatest common divisor is
the largest integer that divides both; the least common multiple is the
smallest positive integer divisible by both. They are dual notions, and
one of the goals of §1.5 is to make the duality precise.

#definition(name: "Greatest Common Divisor")[
  Let $a, b in bb(Z)$, not both zero. The *greatest common divisor* of
  $a$ and $b$, written $"gcd"(a, b)$, is the largest positive integer
  $d$ that divides both $a$ and $b$.
] <def:gcd>

#definition(name: "Least Common Multiple")[
  Let $a, b in bb(Z)$ be nonzero. The *least common multiple* of $a$
  and $b$, written $"lcm"(a, b)$, is the smallest positive integer that
  is a multiple of both $a$ and $b$.
] <def:lcm>

#definition(name: "Coprime Integers")[
  Integers $a$ and $b$ (not both zero) are *coprime* (or *relatively
  prime*) if $"gcd"(a, b) = 1$.
] <def:coprime>

#note[
  The definition of the gcd asks for the *largest* common divisor. That
  it exists is not a formality: the set of common divisors of $a, b$ is
  nonempty (it contains $1$) and bounded above by $abs(a)$ whenever
  $a != 0$, so the well-ordering principle applies. The genuinely
  surprising fact — that this largest divisor is also a *linear
  combination* of $a$ and $b$ — requires the Euclidean algorithm and is
  proved in §1.5.
]

#proposition(name: "Elementary Properties of the GCD")[
  Let $a, b in bb(Z)$ be nonzero and $c in bb(Z)$.
  - $"gcd"(a, b) = "gcd"(b, a) = "gcd"(abs(a), abs(b)) = "gcd"(abs(b),
      abs(a))$;
  - $"gcd"(a, 0) = abs(a)$, $"gcd"(a, 1) = 1$, $"gcd"(a, a) = abs(a)$;
  - $"gcd"(a, b) = "gcd"(a, b + c a)$ for every integer $c$ (adding a
    multiple of one argument to the other does not change the gcd).
] <prop:gcd-basic>

#proof(name: "of the elementary properties")[
  The first two statements are immediate from the definition, since
  $x$ and $-x$ have the same divisors and $1$ divides everything. For
  the third, note that a common divisor of $a$ and $b + c a$ also
  divides $(b + c a) - c a = b$; and conversely a common divisor of $a$
  and $b$ divides $b + c a$. Hence the two numbers have *exactly the
  same* common divisors, so in particular the same greatest one.
]

The second property above shows that even when one argument vanishes,
the gcd is well defined. A useful reformulation of "greatest common
divisor" points forward to the linear-combination world of §1.5.

#corollary(name: "GCD Divides Every Linear Combination")[
  Let $a, b in bb(Z)$, not both zero, and $d = "gcd"(a, b)$. Then $d$
  divides every integer linear combination
  $
    a x + b y quad (x, y in bb(Z)).
  $
  In particular $d | (a + b)$ and $d | (a - b)$.
] <cor:gcd-divides-linear>

#example(name: "Computing GCD and LCM by Hand")[
  The divisors of $18$ are $1, 2, 3, 6, 9, 18$; the divisors of $30$ are
  $1, 2, 3, 5, 6, 10, 15, 30$. The common ones are $1, 2, 3, 6$, so
  $"gcd"(18, 30) = 6$. For the lcm: the positive common multiples of
  $18$ and $30$ are $90, 180, dots$, so $"lcm"(18, 30) = 90$. Observe
  the pleasing identity
  $
    6 dot 90 = 540 = 18 dot 30,
  $
  suggesting $"gcd"(a, b) dot "lcm"(a, b) = a b$. A proof that works
  for all pairs must wait for the tools of §1.5.
] <ex:gcd-lcm-example>

#note[
  The product identity $"gcd"(a, b) dot "lcm"(a, b) = abs(a b)$ is
  proved at the end of §1.5 as
  #link(<cor:gcd-lcm-product>)[the product identity]. The catch is
  that one must first know the gcd is not merely a divisor but a
  *linear combination* of $a$ and $b$ — the content of Bézout's
  identity — and that is precisely what the Euclidean algorithm
  provides.
]

== Euclidean Algorithm and Bézout's Identity // 辗转相除法与 Bézout 恒等式

Computing the gcd by listing all divisors (as in §1.4's example) is
hopeless for large numbers. The *Euclidean algorithm* replaces the pair
$(a, b)$ by a smaller pair with the same gcd, over and over, until the
answer falls out. The engine is the observation recorded already in
#link(<prop:gcd-basic>)[§1.4]: adding a multiple of one number to the
other does not change the gcd. Iterating the division algorithm turns
this into a termination proof.

#lemma(name: "GCD Substitution Lemma")[
  Let $a, b in bb(Z)$ with $b != 0$, and let $r$ be the remainder of $a$
  upon division by $b$, i.e. $a = b q + r$ with $0 <= r < abs(b)$. Then
  $
    "gcd"(a, b) = "gcd"(b, r).
  $
  More generally, replacing $(a, b)$ by $(b, r)$ preserves the set of
  common divisors, hence the gcd.
] <lem:gcd-substitution>

#proof[
  Since $r = a - b q$ is a linear combination of $a$ and $b$, every
  common divisor of $a$ and $b$ divides $r$
  (#link(<cor:gcd-divides-linear>)[§1.4]); and since $a = b q + r$,
  every common divisor of $b$ and $r$ divides $a$. The two pairs share
  exactly the same common divisors, so in particular their greatest
  common divisors agree.
]

The lemma gives the algorithm its bite: dividing $a$ by $b$ makes the
second argument strictly smaller than the first, so a repeated chain of
divisions must terminate at a division with remainder $0$.

#theorem(name: "The Euclidean Algorithm")[
  Let $a, b in bb(Z)$ with $b != 0$. Repeatedly applying the division
  algorithm produces the chain
  $
                a = b q_1 + r_1, & quad 0 < r_1 < abs(b), \
              b = r_1 q_2 + r_2, & quad 0 < r_2 < r_1, \
            r_1 = r_2 q_3 + r_3, & quad 0 < r_3 < r_2, \
                          dots.v \
    r_(n-2) = r_(n-1) q_n + r_n, & quad 0 < r_n < r_(n-1), \
      r_(n-1) = r_n q_(n+1) + 0.
  $
  The remainders are strictly decreasing nonnegative integers, so the
  process stops after finitely many steps, and the last nonzero
  remainder is the greatest common divisor:
  $
    r_n = "gcd"(a, b).
  $
] <thm:euclidean-algorithm>

#proof[
  Existence of the chain and its termination follow from the division
  algorithm and the strict decrease $abs(b) > r_1 > r_2 > dots >= 0$. By
  #link(<lem:gcd-substitution>)[the substitution lemma] applied along
  the chain,
  $
    "gcd"(a, b) = "gcd"(b, r_1) = "gcd"(r_1, r_2) = dots = "gcd"(r_(n-1),
      r_n) = "gcd"(r_n, 0) = r_n,
  $
  since $"gcd"(x, 0) = abs(x)$ (#link(<prop:gcd-basic>)[§1.4]).
]

The algorithm is the oldest nontrivial algorithm in mathematics and
admits a purely geometric reading: to tile a $24 times 9$ rectangle
with the largest possible squares, repeatedly cut off the largest
square and repeat on the remaining rectangle — the side length of the
last square is the gcd (@fig:euclid-rectangle).

#figure(
  image("img/euclid-rectangle.svg", width: 62%),
  caption: [
    The Euclidean algorithm as rectangular tiling: cutting squares from
    a $24 times 9$ rectangle leaves the squares $9^2, 9^2, 6^2, 3^2,
    3^2$; the last square has side $3 = "gcd"(24, 9)$.
  ],
  placement: auto,
  supplement: [Fig.],
) <fig:euclid-rectangle>

#example(name: "Running the Euclidean Algorithm")[
  Compute $"gcd"(252, 105)$:
  $
    252 = 2 dot 105 + 42, & 105 = 2 dot 42 + 21, & 42 = 2 dot 21 + 0.
  $
  The last nonzero remainder is $21$, hence $"gcd"(252, 105) = 21$. The
  chain had three divisions; each new pair is strictly smaller, and the
  decrease $252 > 105 > 42 > 21 > 0$ makes termination visible.
] <ex:euclid-example>

The algorithm is efficient — it is this efficiency, not just its
existence, that makes the gcd a computational tool — but its true
power for theory lies in what reading the chain *backwards* produces:
the gcd as an explicit linear combination of $a$ and $b$. This is
Bézout's identity.

#theorem(name: "Bézout's Identity")[
  Let $a, b in bb(Z)$, not both zero, and $d = "gcd"(a, b)$. Then there
  exist integers $x, y in bb(Z)$ such that
  #eq[
    $a x + b y = d$.
  ] <eq:bezout>
] <thm:bezout>

#proof(name: "of Bézout's identity, by back-substitution")[
  We show the claim by induction on the number of steps in the
  Euclidean chain for $(abs(a), abs(b))$; signs are restored at the end.

  *Base case.* If $b$ divides $a$, the chain has length one, and
  $a = b q + 0$ gives $"gcd"(a, b) = abs(b)$, which we exhibit directly
  as $a dot 0 + b dot s = abs(b)$, where $s in {plus.minus 1}$ is the
  sign of $b$ — a linear combination with integer coefficients.

  *Inductive step.* Assume the chain has at least two divisions, and
  let $a = b q + r$, $r != 0$. By
  #link(<lem:gcd-substitution>)[the lemma], $d = "gcd"(a, b) =
  "gcd"(b, r)$, and the chain for $(b, r)$ is one step shorter. By
  induction there exist integers $x_0, y_0$ with
  $b x_0 + r y_0 = d$. Substituting $r = a - b q$ gives
  $
    d = b x_0 + (a - b q) y_0 = a y_0 + b (x_0 - q y_0),
  $
  a linear combination of $a$ and $b$ with integer coefficients. The
  induction is complete; tracking signs of $a, b$ only changes signs of
  $x, y$.
]

Back-substitution is best seen on a concrete chain: solve for the
remainders, from bottom to top, and substitute upwards.

#example(name: "Bézout Coefficients by Back-Substitution")[
  For $a = 252$, $b = 105$, the chain of
  #link(<ex:euclid-example>)[the previous example] is
  $
    252 = 2 dot 105 + 42, quad 105 = 2 dot 42 + 21, quad 42 = 2 dot 21.
  $
  Solve for the remainders and substitute from the last equation up:

  $r_2 = 21 = 105 - 2 dot 42$ (from the middle equation);

  then $42 = 252 - 2 dot 105$ (from the first), giving

  $21 = 105 - 2 dot (252 - 2 dot 105) = 5 dot 105 - 2 dot 252$.

  Hence $21 = (-2) dot 252 + 5 dot 105$, i.e. $x = -2$, $y = 5$ work in
  Bézout's identity.
] <ex:bezout-example>

#corollary(name: "Coprime Criterion")[
  Two integers $a, b$ (not both zero) are coprime if and only if there
  exist integers $x, y$ with
  $
    a x + b y = 1.
  $
] <cor:bezout-coprime>

#proof[
  If $"gcd"(a, b) = 1$, Bézout's identity gives the combination
  directly. Conversely, if $a x + b y = 1$ and $d = "gcd"(a, b)$, then
  $d$ divides the left-hand side
  (#link(<cor:gcd-divides-linear>)[§1.4]), so $d | 1$ and $d = 1$.
]

This criterion is the workhorse behind everything multiplicative in
this notebook. Its first harvest is the promised product identity,
which needs one further observation: a common multiple of two coprime
numbers is a multiple of their product.

#lemma(name: "Coprime Divisibility (Euclid's Lemma, Coprime Form)")[
  If $"gcd"(a, b) = 1$ and $a | (b c)$, then $a | c$.
] <lem:coprime-divisibility>

#proof[
  By the #link(<cor:bezout-coprime>)[coprime criterion], there exist
  integers $x, y$ with $a x + b y = 1$. Multiply by $c$:
  $a x c + b c y = c$. Since $a | (a x c)$ trivially and $a | (b c)$ by
  assumption, $a$ divides the sum $c$.
]

#corollary(name: "The Product Identity for GCD and LCM")[
  For nonzero integers $a, b$,
  #eq[
    $"gcd"(a, b) dot "lcm"(a, b) = abs(a b)$.
  ] <eq:gcd-lcm-product>
] <cor:gcd-lcm-product>

#proof(name: "of the product identity")[
  Let $d = "gcd"(a, b)$ and write $a = d a_0$, $b = d b_0$ with
  $"gcd"(a_0, b_0) = 1$ (dividing both by their gcd can only remove
  common factors). Consider $M = d a_0 b_0$: it is a common multiple of
  $a = d a_0$ and $b = d b_0$. We show it is the *least* one.

  Let $m$ be any common multiple of $a$ and $b$, say $m = a a_1 = b b_1$.
  Substituting $a = d a_0$, $b = d b_0$ gives
  $a_0 a_1 = b_0 b_1$ after cancelling $d$. Since
  $"gcd"(a_0, b_0) = 1$, the
  #link(<lem:coprime-divisibility>)[coprime form of Euclid's lemma]
  applies: $b_0 | a_1$, so $a_1 = b_0 t$ and
  $m = a a_1 = d a_0 b_0 t = M t$. Hence every common multiple is a
  multiple of $M$, and $M = "lcm"(a, b)$.

  Finally $d dot "lcm"(a, b) = d dot (d a_0 b_0) = (d a_0)(d b_0) =
  a b$, and since $d, "lcm"(a, b) > 0$ both sides are positive; with
  signs restored this reads $d dot "lcm"(a, b) = abs(a b)$.
]

#example(name: "The Product Identity in Action")[
  For $a = 18$, $b = 30$, the identity from
  #link(<ex:gcd-lcm-example>)[§1.4] reads
  $"gcd"(18, 30) dot "lcm"(18, 30) = 6 dot 90 = 540 = 18 dot 30$: the
  relation observed numerically is now a theorem.
]

#note[
  Bézout's identity is the seed of Chapter 10: the solutions of the
  linear Diophantine equation $a x + b y = c$ are parameterised by one
  particular solution (obtained from Bézout) plus the general solution
  of the homogeneous equation $a x + b y = 0$. All of §10.1 is nothing
  but this observation, developed systematically.
]

The chapter has built its fundamental machinery: divisibility and the
division algorithm (§1.1–§1.2), base-$r$ notation as its first
iteration (§1.3), the gcd/lcm and their elementary identities
(§1.4), and finally the Euclidean algorithm with the Bézout identity
as its backward reading (§1.5). The next chapter feeds this engine its
favourite fuel — primes — and the division algorithm's remainder-free
case will return as the Euclidean lemma behind unique factorization.

= Primes and the Fundamental Theorem of Arithmetic // 素数与算术基本定理

Multiplication assembles structure; the question that opens this
chapter is its inverse — *disassembly*. When can an integer be written
as a product of smaller positive integers, and how far can the process
be pushed? The integers that cannot be split further are the *prime
numbers*, the atoms of multiplication. Two facts turn this atomism
into a working theory: there are infinitely many primes, and — far less
obvious — every integer is built from them in *essentially one way*.
The first claim is proved by a construction of Euclid; the second, the
*Fundamental Theorem of Arithmetic*, is the payoff of Chapter 1, since
its key ingredient is exactly the Euclidean lemma promised there.

== Prime Numbers and the Infinitude of Primes // 素数及其无穷性

We isolate the indivisible integers. The definition is stated relative
to the divisibility language of §1.2, where a proper divisor was
already introduced.

#definition(name: "Prime and Composite Numbers")[
  A positive integer $n > 1$ is *prime* if its only positive divisors
  are $1$ and $n$ itself — equivalently, $n$ has no *nontrivial proper
  divisor* (#link(<def:divisibility>)[§1.2]). A positive integer
  $n > 1$ that is not prime is *composite*: it admits a factorization
  $n = a b$ with $1 < a, b < n$.
] <def:prime-composite>

#caution[
  The integer $1$ is neither prime nor composite: it is the
  multiplicative unit, and admitting it among the primes would destroy
  any hope of uniqueness of factorization. Nonpositive integers are
  excluded for the same reason — factorization is studied up to the
  common factor $-1$ anyway, so it suffices to treat positive integers.
]

The definition is only useful if it is not vacuous: every $n > 1$ must
actually contain a prime factor. This is the first structural
guarantee, and it rests only on well-ordering.

#lemma(name: "Least Prime Divisor")[
  Let $n > 1$ be an integer. The smallest divisor of $n$ greater than
  $1$ is a prime. In particular, every integer $n > 1$ has a prime
  divisor.
] <lem:least-prime-divisor>

#proof[
  The set of divisors $d$ of $n$ with $d > 1$ is nonempty (it contains
  $n$), so by the
  #link(<prop:well-ordering>)[well-ordering principle] it has a least
  element $p$. If $p$ were composite, say $p = a b$ with $1 < a < p$,
  then $a$ divides $p$ hence $n$, contradicting the minimality of $p$.
  Thus $p$ is prime.
]

The lemma has an immediate quantitative refinement that will power the
sieve of §2.3 and all trial-division tests: a composite number always
betrays itself by a small factor.

#corollary(name: "Composite Numbers Have Small Prime Divisors")[
  If $n$ is composite, then $n$ has a prime divisor $p$ with
  $p <= sqrt(n)$.
] <cor:composite-sqrt-bound>

#proof[
  Write $n = a b$ with $1 < a, b < n$, ordering the factors so that
  $a <= b$. Then $a <= sqrt(n)$: otherwise $b >= a > sqrt(n)$ would give
  $n = a b > n$. By the previous lemma, $a$ has a prime divisor $p$
  with $p <= a <= sqrt(n)$, and $p$ divides $a$ hence $n$.
]

The sieve of §2.3 says nothing more than the contrapositive of this
corollary: if no prime $p <= sqrt(n)$ divides $n$, then $n$ must be
prime. Before developing that theme, however, we record the first
grand consequence of having at least one prime divisor of every integer
— the primes themselves are inexhaustible.

#theorem(name: "Euclid's Theorem: The Infinitude of Primes")[
  There are infinitely many prime numbers.
] <thm:infinitude-of-primes>

#proof[
  Suppose, to the contrary, that $p_1, p_2, dots, p_k$ are *all* the
  primes. Consider
  $
    N = p_1 p_2 dots p_k + 1.
  $
  Since $N > 1$, the least-prime-divisor lemma
  (#link(<lem:least-prime-divisor>)[§2.1]) provides a prime $q$ dividing
  $N$. If $q = p_i$ for some $i$, then $q$ divides both $N$ and the
  product $p_1 dots p_k$, so $q$ divides their difference $N - p_1 dots
  p_k = 1$ — impossible since $q >= 2$. Hence $q$ is a prime not on the
  list, contradicting the assumption that the list was complete.
]

#note[
  The construction does _not_ require the Fundamental Theorem: Euclid's
  proof needs only the existence of *some* prime divisor of $N$, which
  the least-prime-divisor lemma supplies, not uniqueness of
  factorization. This is worth stressing, because the two results are
  logically independent. A later, analytic proof of the same infinitude
  (from the divergence of the harmonic series) appears in Chapter 8.
]

The definition of a prime says that $p$ has no *proper* divisors; the
next theorem converts this negative statement into a positive engine of
divisibility. It is the lemma promised at the end of §1.2, where it was
observed that division by a prime leaves essentially no remainder
cases.

#theorem(name: "Euclid's Lemma (Prime Divisibility)")[
  Let $p$ be a prime. If $p | (a b)$, then $p | a$ or $p | b$.
] <thm:euclid-lemma>

#proof[
  If $p | a$ there is nothing to prove, so assume $p$ does not divide
  $a$. Because $p$ is prime, its only positive divisors are $1$ and $p$;
  since $p$ does not divide $a$, the common divisors of $p$ and $a$
  reduce to $1$, i.e. $"gcd"(p, a) = 1$. Now $p | (a b)$ and $p$ is
  coprime to $a$: the
  #link(<lem:coprime-divisibility>)[coprime form of Euclid's lemma]
  proved in §1.5 applies and yields $p | b$.
]

The single-factor statement extends to arbitrary products by
iteration — this is the precise form needed to prove uniqueness of
factorization.

#corollary(name: "Euclid's Lemma for Products")[
  Let $p$ be a prime. If $p$ divides a product $a_1 a_2 dots a_k$,
  then $p$ divides at least one of the factors $a_i$.
] <cor:euclid-lemma-product>

#proof[
  Induction on $k$. The case $k = 1$ is trivial and $k = 2$ is exactly
  #link(<thm:euclid-lemma>)[Euclid's lemma]. For $k >= 3$, apply the
  lemma to the two-factor product $a_1 (a_2 dots a_k)$: either
  $p | a_1$, or $p | (a_2 dots a_k)$, in which case the induction
  hypothesis finishes the argument.
]

#example(name: "The Smallest Primes")[
  Checking candidates by hand gives $2, 3, 5, 7, 11, 13, 17, 19, 23,
  29$ as the primes not exceeding $30$. Note in particular that $2$ is
  the only even prime: every larger even number is divisible by $2$ and
  hence composite.
] <ex:prime-table>

#note[
  The vocabulary of "prime" and "composite" lives here purely in the
  integers. In a general ring the two roles split: an *irreducible*
  element (no nontrivial factorization) need not be *prime* (satisfying
  Euclid's lemma), and rings where the two notions coincide and unique
  factorization holds are the *unique factorization domains* studied in
  the Algèbre Abstraite notebook. Over $bb(Z)$ the classical proof just
  given shows there is no such pathology.
]

== The Fundamental Theorem of Arithmetic // 算术基本定理

We now reap the harvest of §2.1. The least-prime-divisor lemma says
that every $n > 1$ has *some* prime factor; peeling factors off
recursively gives *a* factorization into primes. The genuine content of
this section is that this factorization is unique — up to reordering,
there is exactly one way to write $n$ as a product of primes. This is
the *Fundamental Theorem of Arithmetic*, and its proof has two parts:
existence, by strong induction; and uniqueness, by Euclid's lemma.

#theorem(name: "Fundamental Theorem of Arithmetic")[
  Every integer $n > 1$ can be written as a product of primes:
  $
    n = p_1 p_2 dots p_r,
  $
  where each $p_i$ is prime. This factorization is *unique* up to the
  order of the factors.
] <thm:fta>

#proof[
  *Existence.* Strong induction on $n$. For $n = 2$ the claim is clear.
  Assume every integer in ${2, 3, dots, n - 1}$ is a product of primes.
  If $n$ is prime, it is itself such a product (of length $1$). If $n$
  is composite, then $n = a b$ with $1 < a, b < n$
  (#link(<def:prime-composite>)[§2.1]); by the induction hypothesis
  both $a$ and $b$ are products of primes, and multiplying the two
  products expresses $n$ as a product of primes.

  *Uniqueness.* Suppose
  $
    p_1 p_2 dots p_r = q_1 q_2 dots q_s
  $
  are two factorizations into primes, and argue by induction on $r$.
  If $r = 1$, then $n = p_1$ is prime, so the right-hand side, a
  product of primes equal to a prime, must consist of the single factor
  $q_1 = p_1$. For $r >= 2$, the prime $p_1$ divides the right-hand
  side $q_1 dots q_s$, so by
  #link(<cor:euclid-lemma-product>)[Euclid's lemma for products],
  $p_1 = q_j$ for some $j$. Cancelling $p_1$ from both sides leaves
  two factorizations of the same integer with $r - 1$ factors, and the
  induction hypothesis identifies the remaining primes up to order.
]

#note[
  Uniqueness is the reason the theorem deserves its name; without it,
  a "prime factorization" would be a bookkeeping accident of the method
  used to find one. Euclid's lemma is precisely the bridge: it is what
  lets a single prime, once detected, be *cancelled* from an equality
  of products. This is the role Chapter 1 promised when it observed that
  the division algorithm, applied to a prime divisor, yields the
  Euclidean lemma.
]

Collecting equal primes and writing them with exponents gives the
standard form of the factorization, in which the order is fixed by
increasing the base. This is the form we will use throughout the rest
of the notebook.

#definition(name: "Standard (Prime-Power) Factorization")[
  Let $n > 1$ be an integer. Its *standard factorization* (or
  *prime-power decomposition*) is the unique writing
  #eq[
    $n = p_1^(a_1) p_2^(a_2) dots p_k^(a_k)$,
  ] <eq:canonical-form>
  where $p_1 < p_2 < dots < p_k$ are distinct primes and $a_1, a_2,
  dots, a_k$ are positive integers. The factor $p_i^(a_i)$ is the
  $p_i$-*primary part* of $n$.
] <def:prime-factorization>

#note[
  For $n = 1$ the standard factorization is the *empty product* (the
  product over the empty list), which equals $1$ by convention. This
  keeps the statement of uniqueness uniform: $1$ has no prime factors.
]

#example(name: "Writing the Standard Factorization")[
  - $72 = 8 dot 9 = 2^3 dot 3^2$, since $72 = 2^3 dot 3^2$.
  - $1000 = 10^3 = (2 dot 5)^3 = 2^3 dot 5^3$.
  - $360 = 2^3 dot 3^2 dot 5$: divide by $2$ three times
    ($360 -> 180 -> 90 -> 45$), then by $3$ twice ($45 -> 15 -> 5$),
    leaving the prime $5$.
  - $1001 = 7 dot 11 dot 13$: all three factors are prime.
] <ex:factorization-example>

The uniqueness of the prime factorization is a scalpel for questions
that resist everything done so far. The classic example is the
irrationality of $sqrt(2)$, which the Pythagoreans discovered and which
now falls out of comparing exponents.

#example(name: "The Irrationality of $sqrt(2)$")[
  Suppose $sqrt(2)$ were rational, $sqrt(2) = a\/b$ with positive
  integers $a, b$. Squaring gives
  $
    a^2 = 2 b^2.
  $
  In the standard factorization of $a^2$ every exponent is even (it is
  twice the exponent in $a$), and likewise for $b^2$. But the
  factorization of $2 b^2$ is that of $b^2$ with the exponent of $2$
  increased by one: an odd exponent on the prime $2$. An integer cannot
  have both an even and an odd exponent of $2$ in its unique
  factorization — contradiction. Hence $sqrt(2)$ is irrational.
] <ex:sqrt2-irrational>

#note[
  The exponent argument is the seed of a much more systematic language:
  the *valuation* $v_p(n)$, the exponent of the prime $p$ in $n$,
  introduced in §2.4. It turns every question about divisibility into a
  question about comparing small integers. We will also see §2.4 that
  the same exponent language makes the gcd and lcm formulas transparent.
]

== Sieve Methods // 筛法

The results of §2.1 give a strategy for *producing* primes. To test one
number $n$ we only need to try dividing by primes up to $sqrt(n)$
(#link(<cor:composite-sqrt-bound>)[§2.1]); to produce a *list* of
primes, the most ancient algorithm in the subject strikes out
composites in bulk. This is the *sieve of Eratosthenes* (third century
BC), and it is nothing but the contrapositive of the corollary of §2.1,
applied simultaneously to every number in a range.

#proposition(name: "Sieve of Eratosthenes: Correctness")[
  Fix a bound $N >= 2$. Write down the integers
  $2, 3, dots, N$. For each prime $p <= sqrt(N)$, cross out every proper
  multiple of $p$ in the list (i.e. every $p k$ with $k >= 2$). At the
  end, the numbers that are *not* crossed out are exactly the primes
  not exceeding $N$.
] <prop:sieve-correctness>

#proof[
  A number that remains is not divisible by any prime $p <= sqrt(N)$,
  so by the contrapositive of
  #link(<cor:composite-sqrt-bound>)[§2.1] it cannot be composite; it is
  prime. Conversely, a prime $q <= N$ is never crossed out: it is
  written down, and crossing out removes only proper multiples $p k$
  with $k >= 2$, but no such product equals the prime $q$.
]

In practice one runs the sieve by levels: the smallest uncrossed number
at any stage is prime, and its multiples are then removed.

1. Start with the list $2, 3, 4, dots, N$.
2. Let $p$ be the smallest number in the list not yet handled. Then
   $p$ is prime: it survived all earlier crossings, so no prime
   $< p$ divides it, and no composite divisor can exist without a prime
   divisor.
3. Cross out all proper multiples of $p$, i.e. $p^2, p(p+1), dots$ up
   to $N$. (Multiples $p dot 2, dots, p dot (p-1)$ have already been
   crossed out by smaller primes, so starting at $p^2$ saves work.)
4. Repeat from step 2 until $p^2 > N$; the numbers left are the primes
   $\le N$.

The running example is the classical table of primes below $100$. Since
$sqrt(100) = 10$ and the primes $\le 10$ are $2, 3, 5, 7$, only the
multiples of these four primes need be crossed out.

#figure(
  image("img/eratosthenes-sieve.svg", width: 62%),
  caption: [
    The sieve of Eratosthenes for $N = 100$. Multiples of $2$, $3$, $5$
    and $7$ (the primes $\le sqrt(100) = 10$) are struck out; the
    remaining entries are the $25$ primes not exceeding $100$.
  ],
  placement: auto,
  supplement: [Fig.],
) <fig:sieve-grid>

#example(name: "Sifting the Primes up to 100")[
  Starting from the list $2, 3, dots, 100$:
  - $p = 2$: cross out $4, 6, 8, dots, 100$ (the even numbers);
  - $p = 3$: cross out $9, 15, 21, dots, 99$ (proper multiples of $3$
    not already removed);
  - $p = 5$: cross out $25, 35, 55, 65, 85, 95$ (the remaining proper
    multiples of $5$);
  - $p = 7$: cross out $49, 77, 91$;
  - $p = 11$: since $11^2 = 121 > 100$, stop.
  The survivors are the primes
  $
    2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59,
    61, 67, 71, 73, 79, 83, 89, 97,
  $
  twenty-five of them, matching the count visible in
  @fig:sieve-grid.
] <ex:sieve-example>

#note[
  The sieve is a *listing* device, not a *testing* device: it is
  marvellous for sieving all primes below a moderate bound, but
  hopeless for deciding whether a single very large integer is prime.
  The frontier of primality testing — probabilistic tests and
  polynomial-time determinism — belongs to Chapter 8. The same chapter
  studies the *counting function* $pi(x)$, and the sieve furnishes one
  of its crudest but most robust lower bounds.
]

== Applications of Unique Factorization // 唯一分解的应用

The Fundamental Theorem pays its way as a *calculus*: whenever a
question involves divisibility, the standard factorization of the
numbers involved turns it into a question about the exponents of the
individual primes. The clean way to phrase this is to record, for each
prime $p$ separately, how many times $p$ occurs in $n$. This is the
*p-adic valuation*, a function that will accompany the rest of this
notebook.

#definition(name: "The $p$-adic Valuation")[
  Let $p$ be a prime and $n >= 1$ an integer. The *valuation of $n$ at
  $p$*, written $v_p(n)$, is the exponent of $p$ in the standard
  factorization of $n$ (#link(<def:prime-factorization>)[§2.2]); in
  symbols,
  #eq[
    $v_p(n) = max{k >= 0 : p^k | n}$.
  ] <eq:valuation-def>
  For $n = 1$ the set is ${0}$, so $v_p(1) = 0$. Equivalently,
  $p^k | n$ iff $k <= v_p(n)$, and one writes $p^(v_p(n)) "||" n$ to
  say that $p^(v_p(n))$ divides $n$ but $p^(v_p(n)+1)$ does not.
] <def:p-adic-valuation>

#note[
  With this notation the standard factorization reads
  $
    n = product_p p^(v_p(n)),
  $
  where the product runs over all primes $p$ but only finitely many
  factors differ from $1$. The valuation turns divisibility into an
  inequality of ordinary integers: $a | b$ iff $v_p(a) <= v_p(b)$ for
  every prime $p$. This dictionary — one inequality per prime — is the
  most useful reformulation of unique factorization in the whole
  theory; it will be exploited heavily in Chapter 7.
]

The dictionary makes the gcd and lcm of two numbers trivial to
describe: at each prime, the common part is governed by the *smaller*
exponent and the joint part by the *larger* exponent.

#corollary(name: "GCD and LCM from the Valuation")[
  For positive integers $a, b$ and every prime $p$,
  #eq[
    $v_p("gcd"(a, b)) = min(v_p(a), v_p(b)), \
     v_p("lcm"(a, b)) = max(v_p(a), v_p(b)).
  $] <eq:gcd-lcm-valuation>
] <cor:gcd-lcm-valuation>

#proof[
  Fix $p$ and write $alpha = v_p(a)$, $beta = v_p(b)$. Since the gcd
  divides both $a$ and $b$, the valuation inequality of the previous
  note gives
  $v_p("gcd"(a, b)) <= alpha$ and $v_p("gcd"(a, b)) <= beta$, hence
  $v_p("gcd"(a, b)) <= min(alpha, beta)$. Conversely, the common
  divisor $p^(min(alpha, beta))$ divides both $a$ and $b$, so it
  divides their gcd, whence $v_p("gcd"(a, b)) >= min(alpha, beta)$.
  The two inequalities give equality. The argument for the lcm is
  symmetric.
]

#example(name: "Valuation Computation of GCD and LCM")[
  Take $a = 72 = 2^3 dot 3^2$ and $b = 84 = 2^2 dot 3 dot 7$. Applying
  the corollary prime by prime:
  - at $p = 2$: $min(3, 2) = 2$, so $2^2$ divides the gcd;
  - at $p = 3$: $min(2, 1) = 1$;
  - at $p = 7$: $min(0, 1) = 0$ (the factor $7$ is absent from $a$).
  Hence $"gcd"(72, 84) = 2^2 dot 3 = 12$, and likewise
  $"lcm"(72, 84) = 2^3 dot 3^2 dot 7 = 504$. Note that
  $12 dot 504 = 6048 = 72 dot 84$, the product identity of §1.5
  (#link(<cor:gcd-lcm-product>)[§1.5]) again.
] <ex:gcd-lcm-valuation>

As a second payoff of the exponent dictionary, we answer the question
"how many factors of the prime $p$ are hidden inside the factorial
$n!$?" This is the classical *Legendre formula*, whose proof is a pure
exercise in counting multiples.

#theorem(name: "Legendre's Formula for the Exponent of a Prime in a Factorial")[
  For a prime $p$ and an integer $n >= 1$,
  #eq[
    $v_p(n!) = sum_(k=1)^oo floor(n\/p^k)$.
  ] <eq:legendre-formula>
] <thm:legendre-formula>

#proof[
  The product $n! = 1 dot 2 dots n$ has $v_p(n!)$ factors of $p$
  in total. Count them by "layers": among $1, 2, dots, n$ there are
  exactly $floor(n\/p)$ multiples of $p$, each contributing at least one
  factor $p$; among those, $floor(n\/p^2)$ are multiples of $p^2$, each
  contributing a *second* factor $p$; and so on. Adding the layers
  counts every factor $p$ of $m$ exactly $v_p(m)$ times, so
  $
    v_p(n!) = sum_(m=1)^n v_p(m) = sum_(k=1)^oo floor(n\/p^k),
  $
  the series terminating as soon as $p^k > n$ (whence
  $floor(n\/p^k) = 0$). The floor function is that of
  #link(<def:floor-ceiling>)[§1.1].
]

#example(name: "The Exponent of $5$ in $100!$ and Trailing Zeros")[
  By Legendre's formula,
  $
    v_5(100!) = floor(100\/5) + floor(100\/25) + floor(100\/125)
      = 20 + 4 + 0 = 24,
  $
  while
  $
    v_2(100!) = 50 + 25 + 12 + 6 + 3 + 1 = 97.
  $
  The number of trailing zeros of $100!$ in base $10$ is the largest
  power of $10 = 2 dot 5$ dividing $100!$, namely
  $min(v_2(100!), v_5(100!)) = 24$: the "scarce" prime $5$ is the
  bottleneck, as it is in every factorial $n!$ with $n >= 2$.
] <ex:legendre-example>

#note[
  Legendre's formula is the main engine of the estimates in Chapter 8,
  where the exponents $v_p(n!)$ and $v_p((2n)!) - 2 v_p(n!)$ control
  the prime factors of binomial coefficients; the same machinery is at
  the heart of the Chebyshev estimates and of Bertrand's postulate.
  Already here it shows how the abstract unique factorization becomes
  a concrete counting device.
]

This chapter completes Part I: Chapter 1 supplied the mechanics of
divisibility and its crown, the Bézout identity; this chapter supplied
the objects — primes — that the mechanics acts on, proved that every
integer is assembled from them in a unique way, and converted that
theorem into the computational vocabulary of valuations. Two recurring
tools now stand ready for the rest of the notebook: *Euclid's lemma*
for cancelling primes from products, and the *valuation* $v_p$ that
reads divisibility as inequalities of exponents. Chapter 3 begins
Part II by changing the point of view: instead of asking when $b$
divides $a - a'$, it studies the equivalence classes this relation
carves out of $bb(Z)$ — the language of congruences, which will absorb
all of Part I's machinery.

#part("Theory of Congruences") // 同余理论

= Basic Theory of Congruences // 同余的基本理论

Chapter 1 asked when one integer divides another, and sharpened the
answer into the Bézout identity; Chapter 2 crowned that identity with
unique factorization. Part II changes the point of view. The equality
of remainders that appeared in the wake of the Division Algorithm
(§1.2) is promoted from an observation to a *language*: we agree to
call two integers equivalent when they leave the same remainder on
division by a fixed modulus, and we study the arithmetic of these
equivalence classes as a world of its own. This is the theory of
*congruences*, given its notation and first systematic treatment by
Gauss in the *Disquisitiones Arithmeticae* (1801). Everything that
follows in Part II — the theorems of Fermat, Euler and Wilson
(Chapter 4), the order of elements and the primitive roots
(Chapter 5), and the theory of quadratic residues (Chapter 6) — is a
statement about this refined arithmetic, which absorbs all of the
divisibility machinery of Part I into a cleaner setting.

== Congruences and Their Properties // 同余及其性质

Where Chapter 1 asked _when_ one integer divides another, this
section asks when two integers behave "the same" relative to a third.
The key observation, already noted after the Division Algorithm
(§1.2), is that two integers leave the same remainder on division by
$m$ exactly when their difference is a multiple of $m$.

#definition(name: "Congruence Modulo $m$")[
  Let $m in bb(Z)^+$ and $a, b in bb(Z)$. We say that $a$ is
  *congruent* to $b$ modulo $m$, written
  #eq[
    $a equiv b quad ("mod" m)$,
  ] <eq:congruence-def>
  if $m$ divides the difference $a - b$; otherwise $a$ is
  *incongruent* to $b$ modulo $m$. The fixed integer $m$ is the
  *modulus* of the congruence.
] <def:congruence>

Congruence modulo $m$ is an equivalence relation on $bb(Z)$: it is
*reflexive* ($m | 0$), *symmetric* (if $m | (a - b)$, then
$m | (b - a)$), and *transitive* (from $m | (a - b)$ and
$m | (b - c)$ the linear-combination rule of §1.2 gives
$m | (a - c)$). The equivalence classes are arithmetic progressions of
step $m$ that partition $bb(Z)$; §3.2 studies them as objects in their
own right. What makes the relation useful for computation is that it
*interacts* with arithmetic: congruent numbers may be interchanged
freely inside expressions, provided the modulus is respected.

#property(name: "Basic Rules of Congruence Arithmetic")[
  Fix a modulus $m in bb(Z)^+$. For integers $a, b, c, d$:
  - if $a equiv b$ and $c equiv d$ modulo $m$, then $a + c equiv b + d$
    and $a - c equiv b - d$ modulo $m$;
  - if $a equiv b$ and $c equiv d$ modulo $m$, then $a c equiv b d$
    modulo $m$; in particular, $a c equiv b c$ modulo $m$ for every
    integer $c$;
  - if $a equiv b$ modulo $m$ and $d | m$, then $a equiv b$ modulo $d$
    (*transfer to a divisor of the modulus*);
  - congruences are *transitive*: if $a equiv b$ and $b equiv c$
    modulo $m$, then $a equiv c$ modulo $m$.
] <prop:congruence-basic>

#proof(name: "of the rules")[
  Write $a - b = m k$ and $c - d = m ell$ with $k, ell in bb(Z)$.
  *Addition and subtraction.*
  $(a + c) - (b + d) = (a - b) + (c - d) = m (k + ell)$ and
  $(a - c) - (b - d) = (a - b) - (c - d) = m (k - ell)$, both multiples
  of $m$.
  *Multiplication.*
  $a c - b d = c(a - b) + b(c - d) = m (c k + b ell)$, again a multiple
  of $m$.
  *Transfer.* If $d | m$ and $m | (a - b)$, then $d | (a - b)$ by the
  transitivity of divisibility (#link(<prop:divisibility-rules>)[§1.2]).
  *Transitivity.* This is the transitivity of the equivalence relation
  shown above.
]

The rules are the complete arithmetic of congruences *except for
division*, which is delicate: one cannot in general cancel a common
factor from a congruence. The next result describes precisely what
cancellation is allowed.

#proposition(name: "Cancellation Law for Congruences")[
  Let $m in bb(Z)^+$ and $a, b, c in bb(Z)$. Then
  $
    a c equiv b c quad ("mod" m) <=> a equiv b quad ("mod" m\/g),
  $
  where $g = "gcd"(c, m)$. In particular, when $"gcd"(c, m) = 1$, the
  factor $c$ cancels outright:
  $
    a c equiv b c quad ("mod" m) <=> a equiv b quad ("mod" m).
  $
] <prop:congruence-cancellation>

#proof[
  The congruence $a c equiv b c$ modulo $m$ means $m | c(a - b)$.
  Write $c = g c_0$ and $m = g m_0$; then
  $"gcd"(c_0, m_0) = 1$. Dividing out the common factor $g$,
  $
    m | c(a - b) <=> m_0 | c_0 (a - b),
  $
  and since $"gcd"(c_0, m_0) = 1$, the
  #link(<lem:coprime-divisibility>)[coprime form of Euclid's lemma]
  (§1.5) lets us drop $c_0$: $m_0 | (a - b)$, i.e.
  $a equiv b$ modulo $m_0 = m\/g$. The final clause is the case
  $g = 1$.
]

Modulo a prime $p$ the law takes its cleanest form: every $c$ not
divisible by $p$ is coprime to $p$, hence can be cancelled. In other
words, nonzero "corrections" never distort a congruence modulo a
prime. This qualitative difference between prime and composite moduli
is the first hint of the refined structure theory that occupies
Chapter 5.

#example(name: "Clocks, Calendars, and Reduction")[
  A twelve-hour clock measures time modulo $12$: the readings $13:00$
  and $1:00$ coincide because $13 - 1 = 12$. If it is $11:00$, then
  $8$ hours later the dial reads
  $
    11 + 8 = 19 equiv 7 quad ("mod" 12),
  $
  seven o'clock: the twelve-hour cycle has made a full revolution,
  invisible to the dial.

  The calendar runs modulo $7$. If today is the first day of the week
  (Monday), then $30$ days from now falls on day
  $
    1 + 30 = 31 equiv 3 quad ("mod" 7),
  $
  i.e. Wednesday — because $30 equiv 2$ modulo $7$ leaves two extra
  days beyond the full weeks.

  The rules also justify *reduction before computing*: since
  $17 equiv 5$ modulo $12$, the multiplication rule gives
  $2 dot 17 equiv 2 dot 5 = 10$ modulo $12$; indeed
  $34 - 24 = 10$. Large products can be taken apart into residues of
  their factors.
] <ex:congruence-clock>

#note[
  The multiplication rule upgrades from pairs of numbers to *integer
  polynomials*: if $a equiv b$ modulo $m$ and $P(x) = sum_(k=0)^n c_k
  x^k$ has integer coefficients, then $P(a) equiv P(b)$ modulo $m$.
  Indeed each power satisfies
  $a^k - b^k = (a - b)(a^(k-1) + a^(k-2) b + dots + b^(k-1))$, a
  multiple of $a - b$, hence of $m$; summing over $k$ gives the claim.
  This *substitution principle* — a residue may be replaced by any
  congruent integer at every intermediate step — is what makes modular
  computation genuinely easier than integer arithmetic. Chapter 5 will
  press it into service when powers $x^k$ modulo $m$ are evaluated
  through their indices.
]

== Residue Classes and Systems // 剩余类与剩余系

Because congruence modulo $m$ is an equivalence relation (§3.1), it
splits $bb(Z)$ into $m$ disjoint pieces. This section names these
pieces — the *residue classes* — and studies the various ways of
selecting one representative from each class: the *complete* residue
systems. Among the classes, those coprime to the modulus deserve
special attention, since they alone behave well under multiplication.

#definition(name: "Residue Class")[
  Let $m in bb(Z)^+$. The *residue class* of the integer $a$ modulo
  $m$ is the equivalence class
  $
    [a]_m = {a + k m : k in bb(Z)},
  $
  an arithmetic progression of step $m$. Every element of $[a]_m$ is
  a *representative* of the class, and $[a]_m = [b]_m$ if and only if
  $a equiv b$ (mod $m$). There are exactly $m$ distinct classes
  modulo $m$: $[0]_m, [1]_m, dots, [m-1]_m$, and they partition
  $bb(Z)$.
] <def:residue-class>

Among the representatives of a class, the one satisfying
$0 <= r < m$ is the *least nonnegative residue*; it is precisely the
remainder of the Division Algorithm (§1.2). In computations we
usually identify a class with its least nonnegative residue, writing,
for instance, $-5 equiv 7$ (mod $12$), the residue of $19$ modulo
$12$ being $7$.

The rules of §3.1 state exactly that the following class operations
are well defined, independently of the representatives chosen:
$
  [a]_m + [b]_m = [a + b]_m, quad [a]_m dot [b]_m = [a b]_m.
$

#note[
  The operations just displayed equip the residue classes with the
  structure of the *ring of integers modulo $m$*, treated
  systematically in the *Algèbre Abstraite* notebook. Here we keep
  the elementary representative language: a class is named by any
  convenient representative, and results are reduced to least
  nonnegative residues at the end.
]

#definition(name: "Complete Residue System")[
  A *complete residue system* modulo $m$ (CRS for short) is a set of
  $m$ integers no two of which are congruent modulo $m$ — equivalently,
  a set containing exactly one representative of each residue class.
  The *canonical* system consists of the least nonnegative residues
  ${0, 1, dots, m-1}$.
] <def:complete-residue-system>

Translating a complete system by a fixed integer preserves
completeness: if $S$ is a CRS, then so is ${s + t : s in S}$, because
the map $s -> s + t$ merely permutes the classes. The analogous
statement for multiplication — a CRS multiplied by any integer coprime
to $m$ is again a CRS — requires inverses, and is best proved in
§3.3.

#definition(name: "Reduced Residue System")[
  A *reduced residue system* modulo $m$ (RRS for short) is a set of
  integers containing exactly one representative of each residue
  class $[a]_m$ with $"gcd"(a, m) = 1$. The *canonical* reduced system
  is the set of least nonnegative residues coprime to $m$,
  $
    {1 <= k <= m : "gcd"(k, m) = 1},
  $
  whose size is Euler's function $phi(m)$, studied in §3.5.
] <def:reduced-residue-system>

The reduced system is singled out because coprimality to $m$ is
preserved under products — a fact whose proof is the first genuine
use of Euclid's lemma in the arithmetic of congruences.

#property(name: "Reduced Systems Are Closed under Multiplication")[
  Let $m in bb(Z)^+$. If $"gcd"(a, m) = 1$ and $"gcd"(b, m) = 1$, then
  $"gcd"(a b, m) = 1$. Hence the integers coprime to $m$ form a set
  closed under multiplication: products of elements of the canonical
  RRS reduce to elements of the canonical RRS.
] <prop:reduced-closed>

#proof[
  Suppose, for contradiction, that $"gcd"(a b, m) > 1$, and let $p$ be
  a prime divisor of $"gcd"(a b, m)$. Then $p | a b$ and $p | m$. By
  #link(<thm:euclid-lemma>)[Euclid's lemma] (§2.1), $p | a b$ forces
  $p | a$ or $p | b$. If $p | a$, then $p$ divides both $a$ and $m$,
  contradicting $"gcd"(a, m) = 1$; the case $p | b$ contradicts
  $"gcd"(b, m) = 1$ similarly.
]

#example(name: "Residue Systems Modulo 8 and 12")[
  Modulo $8$ the canonical complete system is ${0, 1, dots, 7}$, and
  the reduced system retains only the elements coprime to $8$:
  ${1, 3, 5, 7}$ — four elements, so $phi(8) = 4$. Modulo $12$ the
  reduced system is ${1, 5, 7, 11}$, again with four elements, but for
  a different reason: $phi(12) = 4$ counts the residues $1, 5, 7, 11$
  together with their negatives ($-1 equiv 11$, $-5 equiv 7$).

  The closure property is visible in the multiplication table modulo
  $12$ restricted to the reduced system:
  #tex-table(
    ($""$, [$1$], [$5$], [$7$], [$11$]),
    ([$1$], [$1$], [$5$], [$7$], [$11$]),
    ([$5$], [$5$], [$1$], [$11$], [$7$]),
    ([$7$], [$7$], [$11$], [$1$], [$5$]),
    ([$11$], [$11$], [$7$], [$5$], [$1$]),
  )
  Every product again lies in ${1, 5, 7, 11}$, and each element is
  its own inverse: the diagonal consists of ones, since
  $5^2 = 25 equiv 1$, $7^2 = 49 equiv 1$ and $11^2 = 121 equiv 1$
  modulo $12$. For a prime modulus this self-inverse behaviour never
  occurs (aside from the trivial $1$ and $-1$), as Wilson's theorem
  will confirm in Chapter 4.
] <ex:residue-systems>

#note[
  A residue class $[a]_m$ possesses a *multiplicative inverse* — an
  integer $x$ with $a x equiv 1$ (mod $m$) — if and only if
  $"gcd"(a, m) = 1$. Necessity is clear: any common divisor of $a$ and
  $m$ divides $a x$ and hence also $a x - 1$, forcing it to divide
  $1$. Sufficiency follows from Bézout's identity
  (#link(<thm:bezout>)[§1.5]): $a x + m y = 1$ reads, modulo $m$, as
  $a x equiv 1$. Thus the reduced system is exactly the set of
  invertible classes. §3.3 turns this existence statement into a
  computation, and Chapter 5 will study the *structure* of these
  invertible classes — how many elements of each possible order they
  contain — via primitive roots.
]

== Linear Congruences // 一次同余

We now solve equations in the arithmetic of congruences, beginning
with the simplest nontrivial type. A *linear congruence* in the
unknown $x$ has the form
$
  a x equiv b quad ("mod" m),
$
with $a, b in bb(Z)$ and modulus $m in bb(Z)^+$. Because congruence
is compatible with addition and multiplication (§3.1), the solution
set depends only on the residue classes of $a$ and $b$ modulo $m$:
either coefficient may be replaced by a congruent integer without
changing the solutions. Reading the definition literally, the problem
is that of finding all integers $x$ for which $m$ divides $a x - b$,
i.e. all solutions of the linear Diophantine equation
$a x + m y = b$ in two variables.

#definition(name: "Modular Inverse")[
  Let $m in bb(Z)^+$ and $"gcd"(a, m) = 1$. An *inverse of $a$ modulo
  $m$* is an integer $x$ such that
  $
    a x equiv 1 quad ("mod" m).
  $
  By the note closing §3.2 — Bézout's identity applied to the pair
  $a, m$ — such an $x$ exists exactly when $"gcd"(a, m) = 1$, and it
  is then unique modulo $m$. We write $a^(-1)$ for the unique inverse
  class, so that $a dot a^(-1) equiv 1$ (mod $m$).
] <def:modular-inverse>

The inverse is the key to the general equation: multiplying
$a x equiv b$ by $a^(-1)$ is the legitimate "division" in this
arithmetic. The full picture is described by the main theorem, whose
only obstruction is the common divisor of $a$ and $m$.

#theorem(name: "Solvability of Linear Congruences")[
  Let $m in bb(Z)^+$, $a, b in bb(Z)$, and $d = "gcd"(a, m)$. The
  congruence
  $
    a x equiv b quad ("mod" m)
  $
  has a solution if and only if $d | b$. If $d | b$, there are exactly
  $d$ solutions modulo $m$: dividing both sides and the modulus by
  $d$ gives the reduced congruence
  $
    (a\/d) x equiv b\/d quad ("mod" m\/d)
  $
  with $"gcd"(a\/d, m\/d) = 1$, which has a unique solution
  $x_0$ modulo $m\/d$; the solutions modulo $m$ are then
  $
    x_0, x_0 + m\/d, x_0 + 2 (m\/d), dots, x_0 + (d - 1) m\/d.
  $
] <thm:linear-congruence>

#proof[
  *If a solution exists, then $d | b$.* A solution $x$ of
  $a x equiv b$ (mod $m$) means $a x - b = m y$ for some integer $y$.
  Since $d$ divides both $a$ and $m$, it divides $a x - m y = b$.

  *Assume now $d | b$.* The divisibility condition $m | (a x - b)$ is
  equivalent to $(m\/d) | ((a\/d) x - b\/d)$, since $d$ can be divided
  out of all three of $a$, $b$ and $m$. The reduced congruence
  $
    (a\/d) x equiv b\/d quad ("mod" m\/d)
  $
  has $"gcd"(a\/d, m\/d) = 1$: dividing two integers by their gcd
  removes all common prime factors (unique factorization, §2.2).
  Hence $(a\/d)$ possesses an inverse modulo $m\/d$
  (#link(<def:modular-inverse>)[§3.3]) and the reduced congruence has
  the unique solution class
  $x_0 equiv (a\/d)^(-1) (b\/d)$ (mod $m\/d$).

  *Lifting.* Every solution modulo $m$ reduces to $x_0$ modulo
  $m\/d$, so it must be of the form $x_0 + k (m\/d)$. Among the $d$
  values $k = 0, 1, dots, d - 1$ the resulting classes modulo $m$ are
  distinct: two of them are congruent modulo $m$ only if
  $d | (k_1 - k_2)$, which forces $k_1 = k_2$. Each such class solves
  the original congruence, since the representative $x_0$ does and
  adding $m\/d$ preserves the value of $(a\/d) x$ modulo $m\/d$.
]

The theorem contains the coprime case as its most common special
form, worth stating separately.

#corollary(name: "Coprime Case: Unique Solution")[
  If $"gcd"(a, m) = 1$, the congruence $a x equiv b$ (mod $m$) has
  exactly one solution modulo $m$, namely
  $
    x equiv a^(-1) b quad ("mod" m).
  $
] <cor:linear-congruence-coprime>

Putting the pieces together gives a completely algorithmic procedure,
free of trial and error.

1. *Compute $d = "gcd"(a, m)$* by the Euclidean algorithm (§1.5).
2. *Test solvability.* If $d$ does not divide $b$, there is no
   solution. Otherwise divide $a$, $b$, $m$ by $d$, obtaining
   $a' x equiv b'$ (mod $m'$) with $"gcd"(a', m') = 1$.
3. *Invert.* Obtain the inverse of $a'$ modulo $m'$ from the Bézout
   combination produced by back-substitution in the Euclidean
   algorithm (§1.5), and set
   $x_0 equiv (a')^(-1) b'$ (mod $m'$).
4. *List the lifts.* If $d = 1$ the solution is the single class
   $x_0$ modulo $m$. If $d > 1$, the $d$ solutions modulo $m$ are
   $x_0 + k m'$ for $k = 0, 1, dots, d - 1$.

#example(name: "Several Solutions, and Inversion by Back-Substitution")[
  *Three solutions modulo $21$.* Solve $6 x equiv 15$ (mod $21$). Here
  $d = "gcd"(6, 21) = 3$, and $3 | 15$, so there are three classes.
  Dividing by $3$ gives $2 x equiv 5$ (mod $7$). The inverse of $2$
  modulo $7$ is $4$, since $2 dot 4 = 8 equiv 1$; hence
  $x_0 equiv 4 dot 5 = 20 equiv 6$ (mod $7$). Lifting by $m\/d = 7$:
  the solutions modulo $21$ are
  $
    x equiv 6, 13, 20 quad ("mod" 21),
  $
  and indeed $6 dot 6 = 36 equiv 15$, $6 dot 13 = 78 equiv 15$ and
  $6 dot 20 = 120 equiv 15$ modulo $21$.

  *Inversion by back-substitution.* Solve $14 x equiv 3$ (mod $31$).
  Since $"gcd"(14, 31) = 1$ there is a unique class. Run the Euclidean
  algorithm on $(31, 14)$:
  $
    31 = 2 dot 14 + 3, quad 14 = 4 dot 3 + 2, quad 3 = 1 dot 2 + 1,
  $
  and read it backwards:
  $
    1 = 3 - 1 dot 2 = 3 - (14 - 4 dot 3) = 5 dot 3 - 14
      = 5 (31 - 2 dot 14) - 14 = 5 dot 31 - 11 dot 14.
  $
  Thus $14 dot (-11) equiv 1$ (mod $31$), i.e.
  $14^(-1) equiv -11 equiv 20$ (mod $31$), and
  $
    x equiv 3 dot 20 = 60 equiv 29 quad ("mod" 31).
  $
  Check: $14 dot 29 = 406 = 13 dot 31 + 3$.
] <ex:linear-congruence>

The method of this section is the exact computational twin of §1.5's
Bézout identity: every linear congruence is reduced to one inverse,
and every inverse is produced by the Euclidean algorithm. The systems
of several congruences are the subject of the next section, where the
Chinese Remainder Theorem converts them into a single congruence with
composite modulus. When $b$ itself is a power or a product of
congruences, these tools will power the order computations of
Chapter 5.

== The Chinese Remainder Theorem // 中国剩余定理

Section 3.3 solved one linear congruence in one unknown. This section
solves *systems* of linear congruences in a single unknown,
$
  x equiv a_1 quad ("mod" m_1), quad dots, quad
  x equiv a_k quad ("mod" m_k),
$
with arbitrarily prescribed residues $a_i$. Nothing can be said in
this generality: a single solution would have to carry several
residues at once, and these may conflict. The classical answer — known
in China since the third century and published by Sun Zi in the
*Sunzi Suanjing* — is that, when the moduli are *pairwise coprime*,
any prescribed list of residues is realisable by exactly one class.
The Chinese Remainder Theorem (CRT) is the mathematical core of this
fact, and its proof gives the solution in closed form.

We isolate first the single divisibility fact that will enforce
uniqueness. It is the multi-factor version of the observation behind
§1.5's product identity: a common multiple of several pairwise coprime
integers is a multiple of their product.

#lemma(name: "Products of Pairwise Coprime Divisors")[
  Let $m_1, m_2, dots, m_k$ be positive integers with
  $"gcd"(m_i, m_j) = 1$ for all $i != j$, and put
  $M = m_1 m_2 dots m_k$. If $m_i | n$ for every $i = 1, dots, k$,
  then $M | n$.
] <lem:pairwise-coprime-product>

#proof[
  Use the exponent dictionary of §2.4. Fix a prime $p$. Because the
  $m_i$ are pairwise coprime, $p$ can occur in the prime factorization
  of *at most one* of them: were $p | m_i$ and $p | m_j$ with
  $i != j$, then $p$ would divide their gcd. Hence
  $v_p(M) = v_p(m_i)$ for the unique index $i$ with $p | m_i$ (if any),
  and $v_p(M) = 0$ otherwise. Since $m_i | n$,
  $v_p(m_i) <= v_p(n)$ by the exponent criterion of §2.4, and so
  $v_p(M) <= v_p(n)$ for every prime $p$. By the same criterion,
  $M | n$ (#link(<def:p-adic-valuation>)[§2.4]).
]

Now the main theorem. The construction is often attributed to Qin
Jiushao's day-and-astronomical calculations, and it is purely
algorithmic: solve each congruence "one at a time", using §3.3's
inverses, then add the pieces.

#theorem(name: "Chinese Remainder Theorem")[
  Let $m_1, dots, m_k$ be pairwise coprime positive integers and set
  $M = m_1 m_2 dots m_k$. For *any* integers $a_1, dots, a_k$, the
  system of congruences
  $
    x equiv a_i quad ("mod" m_i), quad i = 1, dots, k,
  $
  has a solution, and it is unique modulo $M$. A solution is obtained
  as follows. Put $M_i = M\/m_i$ for each $i$. Since
  $"gcd"(M_i, m_i) = 1$, let $y_i$ be the inverse of $M_i$ modulo
  $m_i$ (§3.3). Then
  $
    x_0 equiv sum_(i=1)^k a_i M_i y_i quad ("mod" M)
  $
  is the unique solution class.
] <thm:crt>

#proof[
  *Existence.* Fix an index $i$. For every $j != i$ the factor $m_i$
  appears in $M_j = M\/m_j$, so each term $a_j M_j y_j$ with $j != i$
  is divisible by $m_i$ and vanishes modulo $m_i$. Only the $i$-th
  term survives:
  $
    x_0 equiv a_i M_i y_i equiv a_i dot 1 equiv a_i quad ("mod" m_i),
  $
  because $y_i$ was chosen with $M_i y_i equiv 1$. As $i$ was
  arbitrary, $x_0$ satisfies every congruence of the system.

  *Uniqueness.* If $x$ and $x'$ both satisfy the system, then
  $m_i | (x - x')$ for every $i$. By
  #link(<lem:pairwise-coprime-product>)[the previous lemma], the
  product $M$ divides $x - x'$, i.e. $x equiv x'$ modulo $M$. The
  solution class is therefore unique.
]

#example(name: "The Classic Puzzle of Sun Zi")[
  The *Sunzi Suanjing* (third–fifth century) asks for the number that
  leaves remainder $2$ on division by $3$, remainder $3$ on division
  by $5$, and remainder $2$ on division by $7$ — "things whose number
  is unknown". Here the moduli $(3, 5, 7)$ are pairwise coprime and
  $M = 105$. The auxiliary quantities:
  - $M_1 = 35 equiv 2$ (mod $3$), whose inverse modulo $3$ is
    $y_1 = 2$ ($2 dot 2 = 4 equiv 1$);
  - $M_2 = 21 equiv 1$ (mod $5$), so $y_2 = 1$;
  - $M_3 = 15 equiv 1$ (mod $7$), so $y_3 = 1$.
  The CRT solution is
  $
    x_0 = 2 dot 35 dot 2 + 3 dot 21 dot 1 + 2 dot 15 dot 1
      = 140 + 63 + 30 = 233,
  $
  and reducing modulo $105$,
  $
    233 equiv 23 quad ("mod" 105),
  $
  the smallest positive answer. Check:
  $23 equiv 2$ (mod $3$), $23 equiv 3$ (mod $5$), $23 equiv 2$ (mod
  $7$). The same number was answered, independently, by Gauss in the
  *Disquisitiones*, where the modern form of the theorem appears.
] <ex:crt-sunzi>

The moduli in the theorem must be pairwise coprime; without this the
system may fail or admit several classes, as in the second example
below. Compatibility is governed by the following refinement, which
reduces any pair of congruences to a single one.

#note(title: "Non-Coprime Moduli")[
  The pair of congruences
  $
    x equiv a quad ("mod" m), quad x equiv b quad ("mod" n)
  $
  has a solution if and only if $a equiv b$ (mod $"gcd"(m, n)$). When
  this compatibility condition holds, the solution is unique modulo
  $"lcm"(m, n)$. Indeed, any solution satisfies both congruences
  modulo $d = "gcd"(m, n)$ (§3.1, transfer to a divisor), forcing
  $a equiv b$ modulo $d$; conversely, writing $x = a + m t$ and
  substituting into the second congruence turns the problem into the
  linear congruence $m t equiv b - a$ (mod $n$), which §3.3 solves
  (its consistency condition $d | (b - a)$ is exactly the one stated).
  A system of several congruences with arbitrary moduli is treated by
  merging pairs successively in this way.
]

#example(name: "Compatible and Incompatible Pairs")[
  *Compatible.* Solve
  $
    x equiv 7 quad ("mod" 12), quad x equiv 3 quad ("mod" 8).
  $
  The compatibility condition holds: $"gcd"(12, 8) = 4$ and
  $7 equiv 3$ (mod $4$). Write $x = 7 + 12 t$; the second congruence
  becomes $7 + 12 t equiv 3$ (mod $8$), i.e. $12 t equiv 4$ (mod
  $8$). Reducing coefficients, $4 t equiv 4$ (mod $8$), whose solution
  is $t equiv 1$ (mod $2$) — the reduction step of §3.3 with
  $d = 4$. Hence $t = 1 + 2 s$ and
  $
    x = 7 + 12 (1 + 2 s) = 19 + 24 s,
  $
  so $x equiv 19$ (mod $24$), the unique class modulo
  $"lcm"(12, 8) = 24$. Check: $19 equiv 7$ (mod $12$) and
  $19 equiv 3$ (mod $8$).

  *Incompatible.* The pair
  $
    x equiv 7 quad ("mod" 12), quad x equiv 5 quad ("mod" 8)
  $
  has no solution: reducing to the common divisor $4$ would force
  $x equiv 7 equiv 3$ (mod $4$) from the first congruence and
  $x equiv 5 equiv 1$ (mod $4$) from the second — a contradiction.
] <ex:crt-noncoprime>

#note[
  In ring-theoretic language the CRT says that the map
  $x -> ([x]_(m_1), dots, [x]_(m_k))$ is a bijection between the
  residue classes modulo $M$ and the $k$-tuples of residue classes
  modulo the $m_i$, preserving addition and multiplication component
  by component: an isomorphism of the rings of integers modulo $M$ and
  modulo $m_1, dots, m_k$. This is the viewpoint developed in the
  *Algèbre Abstraite* notebook (§9.4); here the elementary
  representative language of the construction above is sufficient.
  Structurally, the theorem is the *splitting engine* of modular
  arithmetic: any modulus $m$ factorizes into powers of distinct
  primes, and every question about arithmetic modulo $m$ — units,
  orders, power residues — can be answered prime power by prime power
  and then reassembled. This is exactly the strategy behind the
  structure theorems of Chapters 5 and 6, and behind the
  multiplicativity of Euler's function proved in the next section.
]

== Euler's φ Function // Euler φ 函数

The reduced residue systems of §3.2 have a size worth measuring. It
counts the residue classes that are invertible under multiplication,
and it turns out to be computable by an astonishingly simple product
formula once the two structural tools of this chapter — unique
factorization and the CRT — are brought to bear.

#definition(name: "Euler's Totient Function $phi$")[
  For $m in bb(Z)^+$, the *totient* (Euler's function) $phi(m)$ is the
  number of integers $k$ with $1 <= k <= m$ and $"gcd"(k, m) = 1$:
  #eq[
    $phi(m) = abs({k in bb(Z) : 1 <= k <= m, "gcd"(k, m) = 1})$,
  ] <eq:phi-def>
  Equivalently, by §3.2, $phi(m)$ is the size of the canonical reduced
  residue system modulo $m$: the number of invertible residue classes.
  In particular, $phi(1) = 1$.
] <def:phi-function>

At a prime power $p^alpha$, counting is immediate: among the integers
$1, dots, p^alpha$, exactly the multiples of $p$ are excluded, and
there are $p^(alpha-1)$ of them. Hence
$
  phi(p^alpha) = p^alpha - p^(alpha-1) = p^(alpha-1)(p - 1).
$
The general modulus now falls to the Chinese Remainder Theorem, which
was precisely the tool that reassembles prime powers into products.

#proposition(name: "Multiplicativity of Euler's Totient")[
  If $"gcd"(m, n) = 1$, then
  $
    phi(m n) = phi(m) phi(n).
  $
] <prop:phi-multiplicative>

#proof[
  An integer $x$ is coprime to the product $m n$ if and only if it is
  coprime to both $m$ and $n$: a prime divides $m n$ precisely when it
  divides one of the factors, so "sharing a prime with $m n$" is
  equivalent to "sharing a prime with $m$ or with $n$".

  By the CRT (#link(<thm:crt>)[§3.4]) the map
  $[x]_(m n) -> ([x]_m, [x]_n)$ is a bijection between the residue
  classes modulo $m n$ and the pairs of classes modulo $m$ and $n$.
  The observation above restricts this bijection: classes coprime to
  $m n$ correspond exactly to pairs $(u, v)$ with $u$ coprime to $m$
  and $v$ coprime to $n$. Counting both sides gives
  $phi(m n) = phi(m) phi(n)$, as claimed.
]

By repeated application (the prime powers of a factorization are
pairwise coprime) the two pieces combine into the classical closed
form.

#theorem(name: "Euler's Product Formula")[
  Let $n >= 2$ have prime factorization
  $n = p_1^(alpha_1) p_2^(alpha_2) dots p_r^(alpha_r)$. Then
  #eq[
    $phi(n) = n product_(p | n) (1 - 1\/p)$.
  ] <eq:phi-formula>
] <thm:phi-formula>

#proof[
  Applying multiplicativity across the prime powers gives
  $
    phi(n) = product_(i=1)^r phi(p_i^(alpha_i)),
  $
  and the prime-power count turns each factor into
  $
    phi(p_i^(alpha_i)) = p_i^(alpha_i) - p_i^(alpha_i - 1)
      = p_i^(alpha_i) (1 - 1\/p_i).
  $
  Multiplying over $i = 1, dots, r$ and using
  $n = product_(i=1)^r p_i^(alpha_i)$ yields the formula.
]

#example(name: "Totient Values")[
  *Small values.* The totients of $1, 2, dots, 12$ are
  $
    (phi(1), phi(2), dots, phi(12)) = (1, 1, 2, 2, 4, 2, 6, 4, 6, 4,
    10, 4),
  $
  with $phi(n) = n - 1$ at the primes $n = 2, 3, 5, 7, 11$ and
  strictly smaller values at the composites: $phi(4) = 2$, $phi(6) =
  2$, $phi(8) = 4$, $phi(9) = 6$, $phi(10) = 4$, $phi(12) = 4$. (The
  equality $phi(n) = n - 1$ characterizes the primes: every
  $k < n$ is then coprime to $n$, forcing $n$ to have no proper
  divisor.)

  *The formula in action.* Factorize $360 = 2^3 dot 3^2 dot 5$. The
  prime-power route gives
  $
    phi(360) = phi(8) phi(9) phi(5) = 4 dot 6 dot 4 = 96,
  $
  while the product formula reads
  $
    360 (1 - 1\/2)(1 - 1\/3)(1 - 1\/5)
      = 360 dot 1\/2 dot 2\/3 dot 4\/5 = 96.
  $
  The two computations agree — and either one is far simpler than
  listing the $96$ integers $1 <= k <= 360$ coprime to $360$.
] <ex:phi-values>

#note[
  Euler's totient is the size of the group of invertible classes, and
  it enters almost every later chapter: Chapter 4 proves Euler's
  theorem $a^(phi(m)) equiv 1$ (mod $m$), the exponent being
  $phi(m)$; Chapter 5 shows that $phi(phi(m))$ primitive roots exist
  for suitable moduli and measures the order of each unit; Chapter 7
  returns to multiplicativity, where $phi$ is absorbed into the
  general framework of *multiplicative functions* and Dirichlet
  convolution. The counting done here, via the CRT, is the prototype
  of that whole theory.
]

This closes Chapter 3: congruence language (§3.1), the residue
systems it carves out (§3.2), the resolution of linear congruences
(§3.3), the Chinese Remainder Theorem that splits composite moduli
(§3.4), and the totient that counts the invertible classes (§3.5).
Part II now possesses both a compact language and a splitting tool;
Chapter 4 harvests them into the three classical theorems of Fermat,
Euler and Wilson.

= Theorems of Fermat, Euler, and Wilson // Fermat–Euler–Wilson 定理

Chapter 3 turned divisibility into a language: residue classes, their
systems, and their invertible elements. This chapter spends that
language on the oldest computational problem of the subject, the
arithmetic of *high powers*. Given $a^n$ modulo a prime $p$, can the
exponent be shrunk? The three theorems of the title answer the
question in three voices. Fermat's little theorem (the claim dates
from a letter of Fermat written in 1640; Euler gave the first
published proof in 1736) fixes the period $p - 1$ of the powers of a
base not divisible by $p$. Euler's theorem (1763) transplants that
period to an arbitrary modulus $m$, where it becomes $phi(m)$. And
Wilson's theorem — announced without proof by Waring in 1770 on
behalf of John Wilson, and first proved by Lagrange in 1771 — records
a striking bookkeeping of the factorial $(p - 1)!$ that in turn
characterizes primes. All three rest on the same engine of Chapter 3:
invertible classes may be permuted and cancelled freely. The chapter
closes (§4.4) by converting the periodicity of powers into two
computing tools, modular exponentiation and primality testing.

== Fermat's Little Theorem // Fermat 小定理

Reduction by congruence makes multiplication easy, but powers remain
expensive: computing $3^100$ modulo a prime by repeated
multiplication costs one hundred steps. The discovery of this section
is that the powers of a fixed integer modulo a prime run in a short
*cycle* — once the cycle length is known, the exponent may be reduced
modulo it. The proof given here is the *binomial* one: it needs only
the inverse-solving machinery of §3.3 and a single observation about
the coefficients in the expansion of $(a + b)^p$. (The alternative
route through residue systems is saved for §4.2, where it will be run
at the general level of Euler's theorem.)

#lemma(name: "Prime Divisibility of Binomial Coefficients")[
  Let $p$ be a prime and let $1 <= k <= p - 1$. Then
  $p | binom(p, k)$.
] <lem:binom-prime>

#proof(name: "of the lemma")[
  The factorial identity
  $
    k binom(p, k) = p binom(p - 1, k - 1)
  $
  reduces to $k binom(p, k) equiv 0$ (mod $p$). Since
  $1 <= k <= p - 1$, we have $gcd(k, p) = 1$, so $k$ is invertible
  modulo $p$ (#link(<def:modular-inverse>)[§3.3]). Multiplying by the
  inverse of $k$ yields $binom(p, k) equiv 0$ (mod $p$), that is,
  $p | binom(p, k)$.
]

#property(name: "Freshman's Dream Modulo a Prime")[
  If $p$ is prime and $a, b in bb(Z)$, then
  $
    (a + b)^p equiv a^p + b^p quad ("mod" p).
  $
] <prop:freshmans-dream>

#proof(name: "of the property")[
  Expanding by the binomial theorem,
  $
    (a + b)^p = sum_(k = 0)^p binom(p, k) a^(p - k) b^k,
  $
  every middle term $binom(p, k) a^(p - k) b^k$ with
  $1 <= k <= p - 1$ vanishes modulo $p$ by #link(<lem:binom-prime>)[the
  lemma], and only the terms $k = 0$ and $k = p$ survive.
]

The joke in the name is that a novice's urge to "distribute" the
exponent, wrong in ordinary integer arithmetic, is correct here. Over
finite fields this map $x -> x^p$ becomes the *Frobenius
endomorphism*, a theme of abstract algebra that lies beyond this
notebook's scope.

#theorem(name: "Fermat's Little Theorem")[
  Let $p$ be a prime and let $a in bb(Z)$. If $p$ does not divide
  $a$, then
  #eq[
    $a^(p - 1) equiv 1 quad ("mod" p).$
  ] <eq:fermat-little>
  Equivalently, in the form that holds for *every* integer $a$,
  $a^p equiv a$ (mod $p$).
] <thm:fermat-little>

#proof(name: "of Fermat's little theorem")[
  We prove the universal form $a^p equiv a$ (mod $p$) and then derive
  the displayed identity from it.
  *Nonnegative bases.* Induct on $a >= 0$; the cases $a = 0, 1$ are
  clear. If $a^p equiv a$ (mod $p$), then by the freshman's dream
  (#link(<prop:freshmans-dream>)[§4.1]),
  $
    (a + 1)^p equiv a^p + 1 equiv a + 1 quad ("mod" p).
  $
  *Negative bases.* For an odd prime $p$ and $a >= 0$,
  $(-a)^p = -a^p equiv -a$ (mod $p$). The prime $p = 2$ needs no case
  split: $a^2 equiv a$ (mod $2$) for every integer $a$, since
  $a^2 - a = a(a - 1)$ is even.
  *First form.* If $p$ does not divide $a$, then $a$ is invertible
  modulo $p$ (#link(<def:modular-inverse>)[§3.3]); multiplying
  $a^p equiv a$ (mod $p$) by the inverse of $a$ gives
  $a^(p - 1) equiv 1$ (mod $p$).
]

#example(name: "The Power Cycle Modulo 13")[
  Fermat's little theorem asserts $2^12 equiv 1$ (mod $13$). Indeed
  $2^6 = 64 equiv 12$ (mod $13$), and squaring gives
  $2^12 equiv 144 equiv 1$ (mod $13$). To compute $2^90$ modulo $13$,
  reduce the exponent modulo the period $12$:
  $
    2^90 equiv (2^12)^7 dot 2^6 equiv 1 dot 64 equiv 12
    quad ("mod" 13).
  $
  Thus $13 | (2^90 - 12)$ — a verdict that naive exponentiation would
  need ninety multiplications to reach.

  The theorem also *manufactures inverses*: if $p$ does not divide
  $a$, then $a^(p - 1) equiv 1$ (mod $p$) shows that $a^(p - 2)$ is
  the inverse of $a$ modulo $p$. Modulo $7$, the inverse of $3$ is
  $3^5 = 243 equiv 5$ (mod $7$), and indeed $3 dot 5 = 15 equiv 1$
  (mod $7$).
] <ex:fermat-example>

#note[
  The binomial route is not the only one. Multiplying the nonzero
  residues $1, 2, ..., p - 1$ by $a$ permutes them — the multiples
  $a, 2 a, ..., (p - 1) a$ again form a complete residue system
  because $gcd(a, p) = 1$. Comparing the products of the two systems
  and cancelling the common factor $(p - 1)!$ gives the same theorem.
  This route is deferred because, with the factor $(p - 1)!$ replaced
  by the product of a general reduced residue system and the exponent
  $p - 1$ by $phi(m)$, it proves Euler's theorem *verbatim*; we run
  it once, at its full level, in §4.2.
]

== Euler's Theorem // Euler 定理

Fermat's little theorem regulates prime moduli. This section replaces
the prime $p$ by an arbitrary modulus $m$ and asks: after how many
steps do the powers of an invertible integer $a$ return to $1$?
Chapter 3 supplied every ingredient. Section 3.5 counted the
invertible classes modulo $m$ and named the count $phi(m)$
(#link(<def:phi-function>)[§3.5]); §3.2 observed that multiplication
by an invertible class keeps a reduced residue system closed and
pairwise distinct (#link(<prop:reduced-closed>)[§3.2]). Euler's
theorem is the statement that these two facts combine into a period
of length $phi(m)$.

#theorem(name: "Euler's Theorem")[
  Let $m >= 2$ and let $a in bb(Z)$ with $gcd(a, m) = 1$. Then
  #eq[
    $a^(phi(m)) equiv 1 quad ("mod" m).$
  ] <eq:euler-theorem>
] <thm:euler-theorem>

#proof(name: "of Euler's theorem")[
  Fix a reduced residue system $r_1, ..., r_(phi(m))$ modulo $m$, a
  list of representatives of the invertible classes
  (#link(<def:reduced-residue-system>)[§3.2]). Multiplying every entry
  by $a$ produces *another reduced residue system*:
  - each product $a r_i$ is again coprime to $m$, by the closure of
    the invertible classes (#link(<prop:reduced-closed>)[§3.2]);
  - the products are pairwise incongruent: if
    $a r_i equiv a r_j$ (mod $m$), then $m | a(r_i - r_j)$, and since
    $gcd(a, m) = 1$ the factor $a$ may be cancelled
    (#link(<def:modular-inverse>)[§3.3]), giving
    $r_i equiv r_j$ (mod $m$) and hence $i = j$.

  The two lists therefore represent the same $phi(m)$ classes, in a
  permuted order, and their products are congruent modulo $m$:
  $
    product_(i = 1)^(phi(m)) a r_i equiv
    product_(i = 1)^(phi(m)) r_i quad ("mod" m).
  $
  The left-hand product equals $a^(phi(m)) P$, where
  $P = product_(i = 1)^(phi(m)) r_i$. Each factor $r_i$ is invertible
  modulo $m$, so the product $P$ is invertible as well
  (#link(<prop:reduced-closed>)[§3.2]); multiplying both sides by the
  inverse of $P$ yields $a^(phi(m)) equiv 1$ (mod $m$).
]

This is the proof promised in the closing note of §4.1, now run at
full strength: the reduced residue system plays the role that
$1, 2, ..., p - 1$ played there, and $phi(m)$ replaces $p - 1$. For a
prime modulus, $phi(p) = p - 1$
(#link(<def:phi-function>)[§3.5]), so Euler's theorem contains
Fermat's little theorem as the special case $m = p$
(#link(<thm:fermat-little>)[§4.1]) — with the same proof structure,
permutation followed by cancellation.

#example(name: "Last Digits and Small Moduli")[
  Let $m = 10$ and $a = 7$. Here $phi(10) = 4$, so Euler's theorem
  promises $7^4 equiv 1$ (mod $10$): indeed $7^2 = 49 equiv 9$
  (mod $10$) and $9^2 = 81 equiv 1$ (mod $10$). The powers of $7$
  modulo $10$ cycle through
  $
    7, 9, 3, 1, 7, 9, 3, 1, ...
  $
  so the *last decimal digit* of $7^222$ is found by reducing the
  exponent modulo the period $4$: $222 = 55 dot 4 + 2$, and the second
  entry of the cycle is $9$. Hence $7^222 equiv 9$ (mod $10$).

  For $m = 15$ the theorem gives $2^8 equiv 1$ (mod $15$) — and indeed
  $2^8 = 256 = 17 dot 15 + 1$ — although no smaller positive power of
  $2$ is congruent to $1$ modulo $15$: the period guaranteed by Euler's
  theorem need not be *minimal*, only a divisor of $phi(m)$. Chapter 5
  isolates the minimal period (the *order* of $a$ modulo $m$) and shows
  that it always divides $phi(m)$.
] <ex:euler-example>

#note[
  Euler's theorem is the workhorse behind the computations of §4.4:
  an exponent may always be reduced modulo $phi(m)$ before a power is
  evaluated. It also carries a structural message that Chapter 5
  formalizes: the invertible classes modulo $m$ form an abelian group
  under multiplication of size $phi(m)$, and Euler's theorem is the
  statement that every element has order dividing the size of the
  group — the finite analogue of Lagrange's theorem of group theory.
  The power of the permutation argument is precisely that it never
  used anything beyond closure and cancellation.
]

== Wilson's Theorem // Wilson 定理

Fermat's and Euler's theorems regulate *powers*. Wilson's theorem
concerns instead the full factorial of the nonzero residues. For a
prime $p$ the numbers $1, 2, ..., p - 1$ are exactly the invertible
classes modulo $p$, and the theorem asserts that their product is as
far from $0$ as possible:

#theorem(name: "Wilson's Theorem")[
  If $p$ is prime, then
  #eq[
    $(p - 1)! equiv -1 quad ("mod" p).$
  ] <eq:wilson>
] <thm:wilson>

The surprise is that the factorial — a long, unstructured product —
collapses to a single value. The mechanism is *pairing by inverses*:
in the list $1, 2, ..., p - 1$, every element other than $1$ and
$p - 1$ multiplies with a distinct partner to give $1$. The only
obstruction to this pairing is an element equal to its own inverse,
and the next lemma says that, for a prime modulus, no such exotic
elements exist.

#lemma(name: "Self-Inverse Elements Modulo a Prime")[
  Let $p$ be prime and let $x in bb(Z)$. If $x^2 equiv 1$
  (mod $p$), then $x equiv plus.minus 1$ (mod $p$).
] <lem:square-roots-of-one>

#proof(name: "of the lemma")[
  The congruence reads $p | (x - 1)(x + 1)$. Since $p$ is prime,
  Euclid's lemma (#link(<thm:euclid-lemma>)[§2.1]) forces $p | x - 1$
  or $p | x + 1$, i.e. $x equiv 1$ or $x equiv -1$ (mod $p$).
]

#proof(name: "of Wilson's theorem")[
  The case $p = 2$ is immediate: $1! = 1 equiv -1$ (mod $2$), so
  assume $p$ is odd.
  *Pairing by inverses.* In the list $1, 2, ..., p - 1$ of invertible
  classes modulo $p$ (#link(<def:modular-inverse>)[§3.3]) every
  element $x$ has a unique inverse $x'$ with $x x' equiv 1$
  (mod $p$). By #link(<lem:square-roots-of-one>)[the lemma], an
  element coincides with its inverse only when $x equiv plus.minus 1$
  (mod $p$), i.e. only for $x = 1$ and $x = p - 1$; all remaining
  factors $2, ..., p - 2$ are therefore distinct from their inverses
  and split into disjoint pairs $x, x'$ whose product is congruent to
  $1$.
  *Collecting the product.* The factorial $(p - 1)!$ is the product of
  the unpaired factors $1$ and $p - 1 equiv -1$ (mod $p$) together
  with the pairs, each contributing $1$. Hence
  $
    (p - 1)! equiv 1 dot (p - 1) equiv -1 quad ("mod" p).
  $
]

The pairing argument explains *why* the answer is $-1$ rather than
any other residue: the factorial is the product of the only two
unpaired classes. Reversing the logic yields a primality test that
cannot be fooled:

#corollary(name: "Converse of Wilson's Theorem")[
  Let $n >= 2$. If $(n - 1)! equiv -1$ (mod $n$), then $n$ is prime.
] <cor:wilson-converse>

#proof(name: "of the corollary")[
  We argue by contraposition. If $n$ is composite, write $n = p k$
  with $p$ prime and $k >= 2$. Since $p(k - 1) = n - p >= 2$, we have
  $p <= n - 1$, so $p | (n - 1)!$. But the congruence
  $(n - 1)! equiv -1$ (mod $n$) would force $n | (n - 1)! + 1$ and
  hence $p | (n - 1)! + 1$; subtracting $p | (n - 1)!$ yields
  $p | 1$, a contradiction.
]

Together with Wilson's theorem itself this gives an exact primality
criterion: an integer $n >= 2$ is prime if and only if
$(n - 1)! equiv -1$ (mod $n$). The criterion is perfect but slow — it
requires $n - 1$ multiplications. Section 4.4 trades this certainty
for speed, after first building fast modular exponentiation.

#example(name: "Wilson's Theorem in Action")[
  *Confirming primes.* For $p = 5$,
  $4! = 24 = 25 - 1 equiv -1$ (mod $5$); for $p = 7$,
  $6! = 720 = 721 - 1 equiv -1$ (mod $7$); for $p = 11$,
  $10! = 3628800 = 329891 dot 11 - 1 equiv -1$ (mod $11$).
  *Rejecting composites.* The converse flips each check: for $n = 4$,
  $3! = 6 equiv 2$ (mod $4$) differs from $-1 equiv 3$ (mod $4$); for
  $n = 6$, $5! = 120 equiv 0$ (mod $6$); for $n = 9$, the factorial
  $8!$ contains the factors $3$ and $6$, so $9 | 8!$ and
  $8! equiv 0 != 8 equiv -1$ (mod $9$).
] <ex:wilson-example>

#note[
  *Half-factorial form.* Pairing the factors of $(p - 1)!$ as
  $k(p - k) equiv -k^2$ (mod $p$) for $k = 1, ..., (p - 1)\/2$ gives
  $
    (p - 1)! = product_(k = 1)^((p - 1)\/2) k(p - k)
    equiv (-1)^((p - 1)\/2) (((p - 1)\/2)!)^2 quad ("mod" p),
  $
  and Wilson's theorem converts this into
  $
    (((p - 1)\/2)!)^2 equiv (-1)^((p + 1)\/2) quad ("mod" p).
  $
  When $p equiv 1$ (mod $4$) the exponent $(p + 1)\/2$ is odd, so the
  congruence exhibits an *explicit square root of $-1$ modulo $p$*,
  namely $((p - 1)\/2)!$ — for $p = 5$, $2! = 2$ and
  $2^2 = 4 equiv -1$ (mod $5$). Chapter 6 returns to this construction
  when it counts the solutions of $x^2 equiv a$ (mod $p$).
]

== Applications: Modular Exponentiation and Primality Testing // 应用：模幂与素性检测

The theorems of this chapter have so far been *identities*. Their
practical currency, however, is *computation*. Euler's theorem shrinks
exponents: when $gcd(a, m) = 1$, the residue $a^b$ (mod $m$) depends
on the exponent $b$ only through its remainder modulo $phi(m)$. And
Fermat's little theorem, read backwards, turns the expensive question
"is $n$ prime?" into a fast — though fallible — congruence check. This
section builds the exponentiation routine that makes the reduction
cheap, then examines the resulting primality test and its two famous
liars, the pseudoprimes and the Carmichael numbers.

*Exponentiation by repeated squaring.* The naive evaluation of $a^b$
(mod $m$) costs $b - 1$ multiplications. Write the exponent in binary
as $b = sum_(i = 0)^k epsilon_i 2^i$ with $epsilon_i in {0, 1}$, so
that
$
  a^b = product_(epsilon_i = 1) a^(2^i).
$
The auxiliary powers $a^(2^i)$ are obtained from one another by
squaring, $a^(2^(i+1)) = (a^(2^i))^2$, and every operation is reduced
modulo $m$ immediately, keeping the numbers small. Since $k ~= log_2
b$, this takes $O(log b)$ modular multiplications instead of
$O(b)$. The savings compound with the theorems of this chapter, which
may reduce the exponent itself before any squaring begins.

#example(name: "Computing a High Power Modulo 7")[
  Fermat's little theorem (mod $7$, so $phi(7) = 6$) reduces the
  exponent first: $50 = 8 dot 6 + 2$, hence $2^50 equiv 2^2 = 4$
  (mod $7$). Alternatively, square away the binary expansion
  $50 = 32 + 16 + 2$:
  $
    2^1 equiv 2, 2^2 equiv 4, 2^4 equiv 2, 2^8 equiv 4,
    2^16 equiv 2, 2^32 equiv 4 quad ("mod" 7),
  $
  and multiplying the entries $i = 1, 4, 5$ selected by the bits of
  $50$ gives $4 dot 2 dot 4 = 32 equiv 4$ (mod $7$). Both roads agree;
  the first is shorter when a theorem pins the period, the second
  needs no theorem at all.
] <ex:powermod-example>

*Fermat's test.* Fermat's little theorem implies that every odd prime
$n$ satisfies $a^(n-1) equiv 1$ (mod $n$) for every base $a$ with
$gcd(a, n) = 1$. Contrapositively, if some base $a$ violates this
congruence, then $n$ is composite and $a$ is called a *witness* to the
compositeness of $n$; no factoring is needed. When the congruence
holds, $n$ merely *passes* the test for that base — it may still be
composite, and then it carries a special name.

#definition(name: "Pseudoprime to a Base")[
  A composite integer $n$ is a *pseudoprime to the base $a$* if
  $gcd(a, n) = 1$ and
  $
    a^(n-1) equiv 1 quad ("mod" n).
  $
  That is, $n$ deceives the Fermat test based on $a$: the test
  concludes "likely prime" although $n$ is composite.
] <def:pseudoprime>

The smallest pseudoprime to the base $2$ is $n = 341 = 11 dot 31$:
$2^10 = 1024 = 3 dot 341 + 1$, so $2^340 = (2^10)^34 equiv 1$
(mod $341$), while $341$ is plainly composite. A single random base
therefore certifies compositeness with high probability but proves
primality never; and some composite numbers defeat the test for
*every* base.

#definition(name: "Carmichael Number")[
  A composite integer $n$ is a *Carmichael number* if
  $a^(n-1) equiv 1$ (mod $n$) for *every* integer $a$ with
  $gcd(a, n) = 1$ — equivalently, $n$ is a pseudoprime to every base
  coprime to it. The smallest Carmichael number is $561 = 3 dot 11 dot
  17$.
] <def:carmichael-number>

#example(name: "Why 561 Is a Carmichael Number")[
  Let $a$ be coprime to $561$; then none of $3, 11, 17$ divides $a$.
  By Fermat's little theorem, $a^2 equiv 1$ (mod $3$),
  $a^10 equiv 1$ (mod $11$) and $a^16 equiv 1$ (mod $17$). The
  exponent $560 = n - 1$ is a multiple of each of $2, 10, 16$
  ($560 = 2 dot 280 = 10 dot 56 = 16 dot 35$), so raising the three
  congruences to suitable powers gives $a^560 equiv 1$ modulo each of
  $3, 11, 17$. The moduli are pairwise coprime, and by the product
  lemma of §3.4 (#link(<lem:pairwise-coprime-product>)[§3.4]) a number
  divisible by each of them is divisible by their product; hence
  $561 | (a^560 - 1)$, i.e. $a^560 equiv 1$ (mod $561$). Since $a$ was
  arbitrary, $561$ passes the Fermat test for every base.
] <ex:carmichael-example>

#note[
  The example exposes the exact weakness of Fermat's test: a
  Carmichael number satisfies $a^(n-1) equiv 1$ (mod $n$) for all
  bases, so no amount of rerunning the simple test catches it.
  Korselt's criterion (1899) characterizes these numbers: a composite
  $n$ is Carmichael if and only if it is squarefree and
  $p - 1 | n - 1$ for every prime $p | n$. For $561$, the three values
  $p - 1 = 2, 10, 16$ all divide $560$, as the example verified case
  by case. The remedy is to look for *nontrivial square roots of $1$*:
  if $a^2 equiv 1$ (mod $n$) yet $a$ is congruent to neither $1$ nor
  $-1$ (mod $n$), then $n$ cannot be prime — the only square roots of
  $1$ modulo a prime are $1$ and $-1$
  (#link(<lem:square-roots-of-one>)[§4.3]). The Miller–Rabin test
  mixes repeated squaring with this square-root check and forms the
  robust probabilistic test of §8.4; Chapter 8 revisits these ideas in
  detail. The Carmichael numbers themselves are known to be infinite
  (Alford–Granville–Pomerance, 1994).
]

This closes Chapter 4. The three classical theorems and their
applications gave the powers of an invertible class a *period* —
$p - 1$ for a prime modulus, and in general a divisor of $phi(m)$.
The next chapters refine this periodicity to its finest scale:
Chapter 5 studies the exact order of an element and the exponents that
generate the whole system of units, and Chapter 6 counts the solutions
of quadratic congruences such as $x^2 equiv -1$ (mod $p$) with the
tools glimpsed in §4.3.

= Primitive Roots and Discrete Logarithms // 原根与离散对数

Euler's theorem attached to every invertible class modulo $m$ a
*period*: the powers $a, a^2, a^3, ...$ return to $1$ by the exponent
$phi(m)$, and no structural information was lost because an exponent
may always be shrunk modulo $phi(m)$ before a power is evaluated.
The present chapter changes the point of view and interrogates the
period itself. *Which* divisors of $phi(m)$ actually occur as periods?
When does an element attain the full period $phi(m)$, so that its
powers exhaust the whole system of units? And once such a generator
has been fixed, what arithmetic does it unlock?

The answers form Gauss's theory of *primitive roots* and its
computational shadow, the *discrete logarithm*. Euler verified
empirically (1773) that prime moduli admit roots whose powers cover
all nonzero residues; Gauss proved the existence theorem in the
*Disquisitiones Arithmeticae* (1801) and went on to settle which
moduli have this property at all — exactly the numbers
$
  m = 1, 2, 4, p^alpha, 2 p^alpha
$
with $p$ an odd prime. Section 5.1 isolates the minimal period — the
*order* of an element — and proves the two structural facts that power
the rest of the chapter: orders divide $phi(m)$, and every least
common multiple of two orders is itself an order. Section 5.2 deploys
these tools to prove the existence theorems and the classification
above. Sections 5.3–5.4 turn the generator into a logarithm: once a
root $g$ is fixed, each unit class $a$ is a uniquely determined power
$g^k$, the exponent $k$ being the *index* of $a$. Multiplication
translates into addition of indices, and the power equation
$x^k equiv a$ — asking for $k$-th roots of $a$ — collapses into the
linear congruences solved in §3.3. The case $n = 2$ then hands the
subject to Chapter 6, which treats quadratic residues in full.

== The Order of an Element // 元素的阶

Fix $m >= 2$ and an integer $a$ coprime to $m$. Multiplication by $a$
is invertible modulo $m$ (§3.3), so the sequence
$1, a, a^2, a^3, ...$ can never reach $0$; Euler's theorem (§4.2)
guarantees that it reaches $1$ at the exponent $phi(m)$ and therefore
runs in a cycle whose length divides $phi(m)$. But as the example
after Euler's theorem showed ($2$ modulo $15$), the genuine cycle may
be shorter than the promised $phi(m)$, and may also be full. The exact
cycle length deserves its own name.

#definition(name: "Order of an Element Modulo m")[
  Let $m >= 2$ and let $a$ be an integer with $"gcd"(a, m) = 1$. The
  *order of $a$ modulo $m$*, written $"ord"_m(a)$, is the least
  positive integer $t$ such that
  $
    a^t equiv 1 quad ("mod" m).
  $
  Such a $t$ exists: Euler's theorem gives $a^(phi(m)) equiv 1$
  (mod $m$), and every nonempty set of positive integers has a least
  element.
] <def:order-of-element>

#proposition(name: "The Order Divides φ(m)")[
  Let $"gcd"(a, m) = 1$. Then
  $"ord"_m(a) | phi(m)$.
] <prop:order-divides-phi>

#proof(name: "of the proposition")[
  The single observation that makes order arguments mechanical is the
  following *minimality criterion*. Let $t = "ord"_m(a)$; if $a^n
  equiv 1$ (mod $m$) for some $n >= 0$, write $n = q t + r$ with
  $0 <= r < t$. Then
  $
    a^n = a^(r + q t) = a^r (a^t)^q equiv a^r dot 1 = a^r quad
    ("mod" m),
  $
  so $a^r equiv 1$ (mod $m$). By the minimality of $t$ the remainder
  $r$ must vanish; hence $t | n$. In words: *an exponent is a period
  of $a$ if and only if it is a multiple of the order.*
  Now take $n = phi(m)$. Euler's theorem gives $a^(phi(m)) equiv 1$
  (mod $m$), so the criterion forces $"ord"_m(a) | phi(m)$.
]

#proposition(name: "The Order of a Power")[
  Let $"gcd"(a, m) = 1$ and put $t = "ord"_m(a)$. For every integer
  $k >= 1$,
  $
    "ord"_m(a^k) = t / "gcd"(t, k).
  $
] <prop:order-power>

#proof(name: "of the proposition")[
  Write $d = "gcd"(t, k)$. The power $(a^k)^(t\/d) =
  (a^t)^(k\/d)$ is $equiv 1$ (mod $m$), so by the minimality criterion
  of §5.1 the order of $a^k$ divides $t\/d$.
  Conversely, let $u = "ord"_m(a^k)$; then $a^(k u) = (a^k)^u
  equiv 1$ (mod $m$), so the criterion applied to $a$ gives
  $t | k u$. Dividing by $d$,
  $
    t\/d | (k\/d) u,
  $
  and since $"gcd"(t\/d, k\/d) = 1$, Euclid's lemma forces
  $t\/d | u$. The two divisibilities leave $u = t\/d$.
]

#proposition(name: "Congruent Powers Coincide Exactly on Periods")[
  Let $"gcd"(a, m) = 1$ and let $t = "ord"_m(a)$. For any integers
  $r, s >= 0$,
  $
    a^r equiv a^s quad ("mod" m) <=> r equiv s quad ("mod" t).
  $
] <prop:order-periodicity>

#proof(name: "of the proposition")[
  By symmetry we may suppose $r >= s$. The class of $a^s$ is
  invertible modulo $m$ (§3.3), so multiplying a congruence by its
  inverse preserves equivalence:
  $
    a^r equiv a^s ("mod" m) <=> a^(r - s) equiv 1 ("mod" m)
    <=> t | (r - s),
  $
  the last step being the minimality criterion. But $t | (r - s)$ is
  exactly the assertion $r equiv s$ (mod $t$).
]

The proposition says that within the period the powers of $a$ never
repeat, and outside it they echo perfectly: $a$ sweeps out a cycle of
length $t$ and nothing else. This *uniqueness of exponents* is what
makes logarithms possible later in the chapter, and the criterion used
twice above is its engine. The last structural fact we need concerns
two elements at once.

#lemma(name: "Reaching the Least Common Multiple of Two Orders")[
  Let $"gcd"(a, m) = 1$ and $"gcd"(b, m) = 1$, with
  $r = "ord"_m(a)$ and $s = "ord"_m(b)$. Then there is an integer
  $c$, coprime to $m$, with
  $
    "ord"_m(c) = "lcm"(r, s).
  $
] <lem:order-lcm>

#proof(name: "of the lemma")[
  *Step 1: coprime orders.* Assume first that $"gcd"(r, s) = 1$ and
  show that $c = a b$ works. On one hand
  $
    (a b)^(r s) = (a^r)^s (b^s)^r equiv 1 dot 1 = 1 quad ("mod" m),
  $
  so $"ord"_m(a b) | r s$ by the minimality criterion. On the other
  hand, let $n = "ord"_m(a b)$. Raising $(a b)^n equiv 1$ (mod $m$) to
  the $s$-th power and using $b^s equiv 1$ gives $a^(n s) equiv 1$
  (mod $m$), hence $r | n s$; as $"gcd"(r, s) = 1$, Euclid's lemma
  yields $r | n$. The symmetric argument gives $s | n$, and the two
  coprime divisors multiply: $r s | n$. Together with $n | r s$ we
  obtain $n = r s = "lcm"(r, s)$.
  *Step 2: general orders.* Split the two orders prime power by prime
  power. For each prime $p$, let $p^alpha$ be the highest power of
  $p$ dividing $r$ and $p^beta$ the highest power dividing $s$. If
  $alpha >= beta$, keep $p^alpha$ inside $r_1$; if $beta > alpha$,
  keep $p^beta$ inside $s_1$. The leftovers $r_2 = r\/r_1$ and
  $s_2 = s\/s_1$ receive no prime power at all from the other order,
  so $r_1$ and $s_1$ are coprime and $r_1 s_1 = "lcm"(r, s)$. By the
  proposition on the order of a power,
  $
    "ord"_m(a^(r_2)) = r\/r_2 = r_1,
    quad
    "ord"_m(b^(s_2)) = s\/s_2 = s_1,
  $
  and the two orders are coprime. Step 1 applied to the two powers
  yields an element $c$ of order $r_1 s_1 = "lcm"(r, s)$.
]

This lemma is the hidden engine of the existence theorems: whenever
orders cannot be combined into one element, they cannot form a common
multiple, and a maximal order would force every other order to divide
it — the dichotomy §5.2 will exploit. First, a concrete tour of the
orders modulo a small prime.

#example(name: "Orders Modulo 7")[
  The nonzero classes modulo $7$ are $1, 2, 3, 4, 5, 6$, and
  $phi(7) = 6$. Iterating each element until it returns to $1$:
  #tex-table(
    ([$a$], [$1$], [$2$], [$3$], [$4$], [$5$], [$6$]),
    ([$"ord"_7(a)$], [$1$], [$3$], [$6$], [$3$], [$6$], [$2$]),
  )
  All six orders divide $6 = phi(7)$, as the proposition demands, but
  only $3$ and $5$ attain the full period $6$. For instance
  $3^2 = 9 equiv 2$, $3^3 equiv 6$, $3^4 equiv 4$, $3^5 equiv 5$ and
  $3^6 equiv 1$ (mod $7$), so the powers of $3$ visit every nonzero
  class before returning; the element $6 equiv -1$ is the extreme
  opposite case, bouncing between $6$ and $1$ with order $2$. Note
  also the "middle" order $3$, realized by $2$ and $4$: modulo $7$ the
  powers of $2$ run through $2, 4, 1$ and stop — a *proper* divisor of
  $phi(7)$, in contrast to the element $2$ modulo $15$ of the example
  in §4.2 (#link(<ex:euler-example>)[§4.2]), whose order $8$
  equals $phi(15)$ exactly.
] <ex:order-table>

#note[
  In the language of §4.2's remark after Euler's theorem, the
  invertible classes modulo $m$ form an abelian group of size
  $phi(m)$ under multiplication, and each order divides the group
  size — the finite echo of Lagrange's theorem. The classes of a fixed
  order $t$ form a *level*: the reduced residue system
  (#link(<def:reduced-residue-system>)[§3.2]) splits into the disjoint
  union of the levels $t | phi(m)$, each class sitting at exactly one
  level. The highest level, $t = phi(m)$, consists of the classes
  whose powers *generate* the whole system of units. Whether that
  level is inhabited is precisely the question of the next section.
]

== Existence of Primitive Roots // 原根的存在性

Section 5.1 closed with the highest order level, $t = phi(m)$, whose
elements generate the whole system of units. Such elements deserve a
name.

#definition(name: "Primitive Root")[
  Let $m >= 2$. An integer $g$ with $"gcd"(g, m) = 1$ is a *primitive
  root modulo $m$* if
  $"ord"_m(g) = phi(m)$.
  By the periodicity proposition of §5.1
  (#link(<prop:order-periodicity>)[§5.1]), its powers
  $g^0 = 1, g, g^2, ..., g^(phi(m) - 1)$ are then pairwise incongruent
  modulo $m$; there are $phi(m)$ of them, and they therefore form a
  reduced residue system (#link(<def:reduced-residue-system>)[§3.2]).
  In other words, every invertible class modulo $m$ is a power of $g$.
] <def:primitive-root>

Modulo $7$ the order table of §5.1 shows that $3$ and $5$ are
primitive roots, and every nonzero class is one of their powers
(for example $3^0 = 1, 3^1 = 3, 3^2 = 2, 3^3 = 6, 3^4 = 4, 3^5 = 5$
(mod $7$), reading the classes in the order visited by $3$). Two
facts about the collection of all roots follow immediately from the
machinery already built.

#proposition(name: "The Roots among the Powers of a Root")[
  Let $g$ be a primitive root modulo $m$, and let $k >= 1$. Then
  $g^k$ is a primitive root modulo $m$ if and only if
  $"gcd"(k, phi(m)) = 1$.
] <prop:primitive-root-power>

#proof(name: "of the proposition")[
  By the proposition on the order of a power
  (#link(<prop:order-power>)[§5.1]),
  $
    "ord"_m(g^k) = phi(m) / "gcd"(phi(m), k),
  $
  and this quotient equals $phi(m)$ exactly when the denominator is
  $1$.
]

#corollary(name: "Counting Primitive Roots")[
  If a primitive root exists modulo $m$, then there are exactly
  $phi(phi(m))$ incongruent primitive roots modulo $m$.
] <cor:primitive-root-count>

#proof(name: "of the corollary")[
  Since the powers of a primitive root $g$ represent every invertible
  class exactly once among $g^1, ..., g^(phi(m))$ — the exponents run
  through a full residue system modulo $phi(m)$, and $g^0 = g^(phi(m))$
  — every primitive root has the form $g^k$ for a unique $k in
  {1, ..., phi(m)}$. By the proposition such a power is a root exactly
  for the $k$ coprime to $phi(m)$, and there are $phi(phi(m))$ of
  them.
]

For $m = 7$ this predicts $phi(6) = 2$ primitive roots, matching the
pair ${3, 5}$ read off from the order table. The counting is settled;
the harder question is whether the top level is inhabited at all. We
answer it first for prime moduli, where the argument is short enough
to belong entirely to this chapter. Its engine is a fact about
polynomials that we have not needed before, and it is proved in two
lines.

#lemma(name: "Root Bound for Polynomial Congruences")[
  Let $p$ be a prime and let
  $f(x) = c_d x^d + c_(d-1) x^(d-1) + dots + c_0$ be a polynomial with
  integer coefficients and $d >= 1$, with $c_d != 0$ (mod $p$). The
  congruence
  $
    f(x) equiv 0 quad ("mod" p)
  $
  has at most $d$ incongruent solutions.
] <lem:poly-roots-bound>

#proof(name: "of the lemma")[
  Argue by induction on the degree $d$. For $d = 1$ the congruence
  $c_1 x equiv -c_0$ (mod $p$) has the single solution
  $x equiv -c_0 c_1^(-1)$ (mod $p$), because $c_1$ is nonzero modulo
  $p$ and hence invertible.
  Assume $d >= 2$ and that the claim holds for lower degrees. If
  $f(x) equiv 0$ (mod $p$) has no solution there is nothing to prove;
  otherwise choose a solution $a$. Divide $f$ by the monic linear
  polynomial $x - a$: long division over the integers gives
  $f(x) = (x - a) q(x) + f(a)$, where $q$ has integer coefficients,
  degree $d - 1$ and leading coefficient $c_d$. Since $f(a) equiv 0$
  (mod $p$),
  $
    f(x) equiv (x - a) q(x) quad ("mod" p).
  $
  Let $b$ be any further solution with $b != a$ (mod $p$). Then
  $(b - a) q(b) equiv 0$ (mod $p$); the factor $b - a$ is nonzero
  modulo $p$, hence invertible, and Euclid's lemma
  (#link(<thm:euclid-lemma>)[§2.1]) forces $q(b) equiv 0$ (mod $p$).
  So every solution other than $a$ is a root of $q$, which has at most
  $d - 1$ roots by the induction hypothesis; the bound $1 + (d - 1) =
  d$ follows.
]

The lemma applies to any polynomial that is not identically zero
modulo $p$, in particular to $x^l - 1$ for every $l$, whose roots are
exactly the classes of order dividing $l$. With one additional idea —
maximize the order — the existence theorem drops out.

#theorem(name: "Primitive Roots Modulo a Prime")[
  For every prime $p$ there exists a primitive root modulo $p$.
] <thm:primitive-root-prime>

#proof(name: "of the theorem")[
  Consider the orders of the $p - 1$ nonzero classes modulo $p$ and let
  $l$ be their maximum.
  *Step 1: $l <= p - 1$.* An element of order $t$ has $t$ pairwise
  incongruent powers $1, a, ..., a^(t-1)$ by the periodicity
  proposition, all nonzero, so $t <= p - 1$.
  *Step 2: every order divides $l$.* Let $a$ have order $t$. By the
  least common multiple lemma of §5.1 (#link(<lem:order-lcm>)[§5.1]),
  some element $c$ has order $"lcm"(t, l)$. This order cannot exceed
  the maximum $l$, so $"lcm"(t, l) = l$, which means $t | l$.
  *Step 3: conclude.* Every nonzero class $a$ has its order dividing
  $l$, hence $a^l equiv 1$ (mod $p$) by the minimality criterion of
  §5.1. The congruence $x^l equiv 1$ (mod $p$) therefore admits all
  $p - 1$ nonzero classes as solutions. The root bound forbids this
  when the degree is smaller: $l < p - 1$ would contradict the lemma,
  so $l >= p - 1$. Together with Step 1, $l = p - 1$, and any element
  of order $p - 1 = phi(p)$ is a primitive root.
]

The proof located an element of maximal order and *forced* it up to
length $p - 1$: because orders can be combined into least common
multiples, a maximal order must be a common multiple of all orders,
and the polynomial root bound then measures that the pool of nonzero
classes is exactly large enough. This cleanly sidesteps the finer
counting function $sum_(d | p - 1) phi(d) = p - 1$ that organizes
orders in another common proof; that identity belongs to the theory of
arithmetical functions in Chapter 7. What remains for prime moduli is
a bookkeeping of powers, which the next part of this section turns
into the existence theorems for prime powers and their doubles.

