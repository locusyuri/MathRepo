# Analyse Mathématique 重构与 Typst 迁移计划

> 创建日期：2026-10-09
> 最后更新：2026-10-10（B10 完成：ch10 Power Series 迁移收口，Part III 里程碑达成）
> 状态：✅ 计划已确认（3 项决策已定，见 §3.4）
> 技能依据：`violet-latex-to-typst`（迁移）、`violet-design-note`（目录体检）、`violet-make-outline`（补全大纲）、`violet-typst-writing-conventions`（写作规范）

---

## 1. 总览

| 项目 | 值 |
|------|-----|
| 源文件 | `initial.tex` + `chapters/chap01–chap16.tex`（约 4860 行，74 节，15 张图） |
| 内容回收源 | `docs/极限与连续.md`（约 1960 行）、`docs/微分与积分.md`（约 2400 行）、`docs/级数.md`（约 1300 行）——md 为 tex 之前的前身笔记，**部分内容 tex 未吸收**，对照清单见 §3.5 |
| 目标 | 单文件 `initial.typ`（仓库惯例，模板 `../../TypstTemplate/math-notes.typ`） |
| 迁移粒度 | **一节一节推进**，每 1–2 节编译一次（退出码 0 为通过） |
| 原始文件 | `.tex` 与 `.md` 全部保留作为存档，不删除 |
| 附带任务 | 迁移过程中并行修复 §3 中的目录结构问题，并按 §3.5 回收 md 独有内容 |

规模速查（行数 / 节数）：

```
ch01 109/3   ch02 139/5   ch03  49/6    ch04 345/7
ch05  81/1   ch06 444/7   ch07 192/4    ch08 293/7
ch09 258/3   ch10  64/3   ch11  26/1    ch12 1048/7  ← 最重
ch13 478/4   ch14 549/6   ch15 508/5    ch16 279/5
（ch17/ch18 为空文件且未被 \input，见 P2-4 清理项）
```

目标结构：**5 个内容 Part（原 4 个，按决策③拆分 Part IV/V）+ Appendix**，共 16 章。

---

## 2. 总体策略

**三阶段并行推进，以 Part 为里程碑：**

```
阶段 A：骨架搭建（B0 批）
  initial.typ 头部 + #part 分组 + references.bib + 目录
        ↓
阶段 B：分批迁移（B1–B16，按章顺序，逐节推进）
  每批 = 脚本预转换 → AI 手动精修 → 合并 → 编译 → 提交
  迁移时顺带做"低成本修复"（空节删除/改名、章名对齐）
        ↓
阶段 C：内容补全（随各章迁移完成后触发）
  P0 硬伤补全需先按 violet-make-outline 出大纲，经确认后写入
        ↓
收尾：附录 Glossary、死文件清理、全书终检
```

**批次划分原则**：单批 ≤ 300 行或 ≤ 7 节；超大章（ch04/ch06/ch12/ch13/ch14/ch15）拆为 2–3 个子批；每批完成后 git 提交（中文 Conventional Commits，只提交本任务改动）。

---

## 3. 目录合理性分析（体检结论）

### 3.1 合理之处（迁移时保持原样）

1. **主线清晰**：对象递进模式——一维（Part I–II）→ 无穷维工具（Part III 级数）→ 多维（Part IV），与主流数学分析教材依赖顺序一致。
2. **依赖顺序正确**：ch7 反常积分先于级数（判别法对照）；ch16 变参积分依赖 ch9 一致收敛，置于末尾收束正确；ch14 曲面论先于 ch15 线面积分，为 Stokes 公式备好几何工具。
3. **职责边界得当**：Fourier 级数归 Analyse Harmonique、Lebesgue 归 Analyse Réelle、Gamma/Beta 深入归 Analyse Complexe，本笔记均未重复混入。
4. **合理扩展**：ch3 Period Three Implies Chaos、ch8 Infinite Products / Special Series、ch12 隐函数定理与 Lagrange 乘子，均是有价值的聚合专题。

### 3.2 问题清单（含处理时机）

| 编号 | 级别 | 位置 | 问题 | 处理时机 |
|------|------|------|------|---------|
| P0-1 | 🔴 | ch11 | 章题含 "Limits" 但全章仅 1 节（Continuous Mappings），极限内容与 $\mathbb{R}^n$ 拓扑铺垫完全缺失，标题与内容不符 | B11 批迁移后，按 `violet-make-outline` 出大纲补全 |
| P0-2 | 🔴 | ch03 §2、§3 | Continuous Functions / Infinitesimal and Infinite Quantities 为空节；§4 中 Bolzano-Cauchy、零点定理为环境空壳 | B3 批迁移时处理：空壳补内容或合并节，内容可取自 md（§3.5 R3） |
| P0-3 | 🔴 | ch14 §Oriented Surface | 空节，且定向是 ch15 第二型曲面积分的必要前置，缺口向下游传导 | B14 批迁移后补全 |
| P0-4 | 🔴 | ch10 §1 | Power Series and Its Convergence Radius **为空节**（收敛半径、Abel 定理、幂级数性质全缺），md 有完整内容 | B10 批迁移时从 md 回收（§3.5 R7） |
| P0-5 | 🔴 | ch02 §2.3–2.4 | Subsequences 的上下极限、Completeness 的 Dedekind/确界/单调/Bolzano-Weierstrass/区间套/Heine-Borel 全为**空壳 leftbarTitle**（仅 Cauchy 完备性有内容），md 有完整证明与等价命题互证框架 | B2 批迁移时从 md 回收（§3.5 R2） |
| P1-1 | 🟠 | ch05 | 全章仅 1 节（换元+分部），与 ch4/ch6 的 7 节体量失衡；md 有"几类可积函数"（有理函数、三角有理式、无理函数积分） | B5 批迁移时从 md 回收扩充（§3.5 R5） |
| P1-2 | 🟠 | ch14 | 章题 "Introduction to Surface Theory" 但混入曲线内容（弧长、曲率），且 Preface 声称的 "curve theory" 无独立章；无 Frenet 标架 | ✅ 已决策：改章名为 "Introduction to Curve and Surface Theory"，B14 批执行 |
| P1-3 | 🟠 | ch14 §Bounded Variation | $BV[a,b]$ 为一元实函数/调和分析内容，置于曲面论章末逻辑脱节 | ✅ 已决策：原位保留作导论，加指向 Analyse Harmonique 的文字交叉引用，B14b 批执行 |
| P1-4 | 🟠 | ch01 §2 | Common Inequalities 仅 1 条不等式，md 有完整专题（平均值、Bernoulli、三角、Cauchy-Schwarz、Fan Ky 及例题） | B1 批迁移时从 md 回收（§3.5 R1） |
| P1-5 | 🟠 | ch08 §4、§7 | 绝对/条件收敛仅有定义（约 8 行），md 有正负导出级数、Riemann 重排定理、级数乘法；Special Series 缺超几何级数 | B8 批迁移时从 md 回收（§3.5 R6） |
| P1-6 | 🟠 | ch07 | 缺 Cauchy 主值（md 有定义与讨论），"其它问题"（md 反常积分末节）tex 未吸收 | B7 批迁移时从 md 回收（§3.5 R4） |
| P2-1 | 🟡 | 全书 | Part IV 过重（6 章）：ch11–13 为多元微积分本体，ch14–16 为几何应用+高级积分 | ✅ 已决策：拆出第五 Part，**B0 骨架时直接按 5 Part 创建**（省去后期重构） |
| P2-2 | 🟡 | 附录 | Glossary 仅 A–Q 且仅 1 条术语 | 收尾阶段用 `violet-glossary-indexer` 重建 |
| P2-3 | 🟡 | 全书 | `secnumdepth=2` 但全书无 `\subsection`，大章内部粒度偏粗 | 迁移时不引入 `===`，维持现状 |
| P2-4 | 🟡 | 章文件 | `chapters/chap17.tex`、`chap18.tex` 为空且未被引用 | 迁移收尾时删除（.tex 存档原则的例外，属死文件） |

### 3.3 职责边界表（迁移时校验，不得越界）

| 内容 | 归属 | 本笔记处理方式 |
|------|------|---------------|
| Fourier 级数 | Analyse Harmonique | 不迁入，仅文字提及（ch14 已有伏笔） |
| Lebesgue 测度/积分、$L^p$ | Analyse Réelle | 不迁入 |
| Gamma/Beta 函数深入 | Analyse Complexe | 仅保留 ch16 Euler 积分的最低限度表述 |
| 偏微分方程应用 | EDP 笔记 | 不迁入 |
| 集合论/映射基础 | Théorie des Ensembles | 不迁入 |

### 3.4 决策记录（2026-10-09 用户已确认）

- **①（P1-2）曲线论归位** → **改章名合并**：ch14 改为 "Introduction to Curve and Surface Theory (曲线与曲面论导论)"，改动最小。
- **②（P1-3）有界变差去留** → **保留 + 交叉引用**：原位保留作导论，加指向 Analyse Harmonique 的文字交叉引用。
- **③（P2-1）Part IV 拆分** → **拆出第五 Part**：Part IV = 多元微积分本体（ch11–13），Part V = 几何应用与高级积分（ch14–16）。B0 骨架直接按 5 Part 创建。

### 3.5 md 前身笔记对照与内容回收清单

> 三份 md 是改用 tex 之前的原始笔记，tex 未完全吸收其内容。迁移时**以 tex 为主线**，
> 遇到下表条目时回到 md 取材，转换为 Typst 组件后并入对应批次。
> md 使用中文正文 + 外链图片（aliyuncs OSS），回收时须翻译为英文正文（中文仅留 `//` 注释），
> 外链图片不可用，需要的按项目图片工作流用 Python 脚本重新生成，或以文字/公式替代。

| 编号 | md 来源 | md 内容（含大致行号） | tex 现状 | 回收目标批次 |
|------|---------|----------------------|---------|-------------|
| R1 | 极限与连续.md L78–260 | 不等式专题：平均值不等式、Bernoulli、三角不等式、Cauchy-Schwarz、Fan Ky 及例题证明 | ch01 §2 仅 1 条 ln 不等式（P1-4） | B1（ch01） |
| R2 | 极限与连续.md L579–1120 | 收敛准则与实数连续性：上下极限、单调有界、闭区间套、**凝聚原理**、Cauchy 收敛原理、Dedekind 分割、确界原理、**有限覆盖原理**、连续性⇔完备性等价互证框架 | ch02 大量空壳 leftbarTitle（P0-5）；凝聚原理 tex 未见 | B2（ch02） |
| R3 | 极限与连续.md L1126–1860 | 函数极限与连续性：单侧/广义极限、无穷小（含**等价无穷小替换规则与注意事项**）、闭区间连续函数定理、一致连续专题（Lipschitz、开区间端点判别、$[a,+\infty)$ 判别法、反例集） | ch03 §2/§3 空节、§4 空壳（P0-2）；一致连续 tex 有基础版 | B3（ch03） |
| R4 | 微分与积分.md L2143–2400 | 反常积分：**Cauchy 主值**定义与讨论、"其它问题"小节 | ch07 未吸收（P1-6） | B7（ch07） |
| R5 | 微分与积分.md L1089–1195 | 不定积分扩充：基本积分表、**几类可积函数**（有理函数、三角有理式、无理函数积分） | ch05 仅换元+分部（P1-1） | B5（ch05） |
| R6 | 级数.md L307–508 | 绝对收敛扩展：正负导出级数、**Riemann 重排定理**、级数乘法；特殊级数含**超几何级数** | ch08 §4 仅定义、§7 缺超几何（P1-5） | B8（ch08） |
| R7 | 级数.md L985–1141 | 幂级数：收敛半径求法、**Abel 定理**、幂级数的分析性质 | ch10 §1 空节（P0-4） | B10（ch10） |
| R8 | 级数.md L509–980 | 函数项级数：准一致收敛、Dini 定理、一致收敛充要条件、Abel-Dirichlet 一致收敛版 | ch09 已有大部分（准一致收敛、Dini 均在），**仅作校对参考，无必迁项** | B9（ch09）校对 |
| R9 | 微分与积分.md L16–1087 | 微分主体：导数运算、中值定理、凸性、L'Hôpital、Taylor | ch04 已完整吸收，**无必迁项** | B4（ch04）校对 |

**回收原则**：
1. tex 已有更完整表述的，以 tex 为准，不重复迁入；
2. md 独有内容（R1–R7 标注"缺/空/仅"者）迁移时**必须**回收，勾选对应批次时一并勾选；
3. md 例题若质量高且 tex 无对应，可作为 `#example` 补入；拿不准的先列入批次 TODO 请用户裁决；
4. md 中与 §3.3 职责边界冲突的内容（如有 Fourier 相关）不迁入——已扫描，三份 md 未发现 Fourier 专章，边界干净。

---

## 4. 迁移批次与进度追踪

> 勾选规则：节级完成（迁移+编译通过）勾节；整批完成（编译+提交）勾批。
> 批次内小批（如 B12a/B12b）全部完成才算整批完成。

### 阶段 A

- [x] **B0 骨架**：`initial.typ` 头部（import/set document/make-cover/make-outline）+ **5 个内容 `#part` + 1 个 Appendix `#part`**（按 §3.4 决策③：Part IV = ch11–13，Part V = ch14–16）+ Preface（含记号表）+ `references.bib`（从 `thebibliography` 提取 9 条）+ `#bibliography`。编译通过后提交。（✅ 2026-10-09，`254df63`）
  - ⚠️ 后续修订（2026-10-09 用户决策）：**取消独立 Preface 章**，其中 "For an interval" 起的记号内容（去版本表）于 B1 下沉为 Preliminaries 第一章的 "Notations" 符号说明节。

### Part I — Limits and Continuity

- [x] **B1 = ch01 Preliminaries**（109 行 / 3 节）（✅ 2026-10-09）
  - [x] §1.0 Notations（符号说明：由原 Preface "For an interval" 起的内容下沉而来，去掉版本表，表格单元格改 `[...]` 形式；删除 Preface 章）
  - [x] §1.1 Trigonometric Formulas（7 组公式 align + triangle.png figure + Geometric Remarks property + Weierstrass Substitution theorem）
  - [x] §1.2 Common Inequalities（🔧 P1-4/R1 ✅：从 md L78–262 回收不等式专题——平均值不等式（两证明）、Newton 二项式引理、Bernoulli 不等式 + 3 推论、三角不等式、Cauchy-Schwarz（含向量/积分形式）、Carlson、Lagrange 恒等式、Fan Ky + A-G 极限形式 note + 3 个例题；中文正文已译为英文；修正 md 笔误：`(1+x)^n < e^k < (1+k/n)^(n+k)`、Fan Ky 左侧补 `^n`、Lagrange 恒等式去 abs）
  - [x] §1.3 Factorial Power（升/降阶乘 definition，`<def:factorial-power>`）
- [x] **B2 = ch02 Limits of Sequences**（139 行 / 5 节）（✅ 2026-10-09）
  - [x] §2.1 Convergent Sequences（Cauchy 命题 + 均值链 note + 拟合法 remark→note；空壳标题保留为粗体段落标签）
  - [x] §2.2 Indeterminate Form（Stolz-Cesàro 定理两型 + Silverman-Toeplitz 定理，矩阵用 `mat()` 迁移）
  - [x] §2.3 Subsequences（🔧 P0-5/R2 ✅：从 md L579–697 回收——子列定义与三性质及证明、上下极限第一定义（聚点集 E 的 sup/inf）+ H=max E 证明、ε 刻画定理及证明、有界收敛充要条件（H=h）、第二定义（尾项 sup/inf）+ 两定义等价定理及证明、上下极限运算（加法/乘法，md 乘法 2) 笔误 `x_n+y_n` 已修正为 `x_n y_n`；运算定理 md 无证明，保持无证明）
  - [x] §2.4 Completeness（🔧 P0-5/R2 ✅：从 md L701–1119 回收——Dedekind 分割定义+定理+证明（md `A∩B` 笔误已修正为 `A∪B`）、确界定义+存在原理+证明、Archimedean 性质+证明（补 `x>0` 条件）、单调有界原理+证明、Bolzano-Weierstrass+二分法证明+无界情形 note、闭区间套定义+定理+证明、Cauchy 列定义+收敛准则（tex 已有）补证明+错误命题 caution+完备性定义、开覆盖+Heine-Borel 定理（md 无证明）、等价定理链 note + 三个代表性互证命题（区间套⇒确界、Cauchy⇒单调有界、Cauchy⇒区间套）；未引入 `===`，空壳 leftbarTitle 一律保留为粗体段落标签）
  - [x] §2.5 Iterative Sequences（Banach 不动点定理 + 收敛速度估计；对 `def:Lipschitz Continuity` 的引用暂用文字提及，B3 迁移 ch03 后可改为 `#link(<def:lipschitz-continuity>)`）
- [x] **B3 = ch03 Limits and Continuity of Functions**（49 行 / 6 节，⚠ 含 P0-2）（✅ 2026-10-09）
  - [x] §3.1 Limits of Functions（函数极限定义、单侧极限、广义极限两张 tex-table、极限性质+证明、增长速度比较（补全证明）、两个重要极限（补 sin x/x 夹逼证明）、Viète 公式（修正 md 第三因子漏 ½ 笔误）、Heine 定理+证明、弱 Heine+note+证明、函数版 Cauchy 准则+证明）
  - [x] §3.2 Continuous Functions（🔧 P0-2 ✅：从 md R3 回收——点连续/振动度/区间连续定义、间断点三分类+note、Riemann 函数、单调函数间断点、反函数存在与连续（Step 1/2 证明）、复合连续、初等函数连续性、开集逆像、稠密集相等（供 §3.6 引用）、最小正周期）
  - [x] §3.3 Infinitesimal and Infinite Quantities（🔧 P0-2 ✅：从 md R3 回收——无穷小定义与比较（o/O/同阶/等价，`tilde.op`）、o 运算法则、常见等价无穷小表（note title）、无穷大量比较、等价替换定理（md 无证明，已补全三元乘积分解证明）+两条注意事项 caution+Taylor 视角 note+素数定理 note）
  - [x] §3.4 Continuous Functions on Closed Intervals（🔧 P0-2 ✅：空壳定理全部从 md R3 补陈述/证明——有界性（二分+区间套 / B-W 双证明）、最值、零点（上确界法/二分法双证明）、介值；一致连续专题：一致连续定义+反例 note、序列判别定理、Lipschitz 定义（`<def:lipschitz-continuity>`，ch02 引用已改为 #link）、Cantor 定理、开区间端点延拓推论、[a,+∞) 判别法+错误证明 caution、反例集（有界开区间、导数判别（修正 md「一致收敛」笔误）、周期函数、Cauchy 映射））
  - [x] §3.5 Period Three Implies Chaos（tex 完全为空 → 从 md L1864–1905 补：一维迭代动力系统定义、Fixed-Point/Subinterval/Cyclic 三个覆盖引理（md Lemma-1 标题「扩张映射」与内容不符，改名）、Li-Yorke 第一/第二定理（limsup/liminf）、Li-Yorke 混沌定义；md 均无证明，保持原状；外链图片跳过）
  - [x] §3.6 Functional Equations（tex 完全为空 → 从 md L1907–2005 补：经典函数方程一览（修正 md sin/cos 配对反了：f=cos ax, g=sin ax）、Cauchy 方程完整证明（引用 ex:continuous-agree-dense）、d'Alembert 方程证明（修正 md f²(c/2) 记号与 θ/2^n→c/2^n 笔误）、指数/对数方程代入化归证明）
- [ ] ✅ Part I 里程碑：编译 + 提交

### Part II — Single-variable Calculus

- [x] **B4a = ch04 §1–4**（tex 约 190 行，回收后约 690 行）：Differential and Derivative / Higher-Order Derivatives / Differential Mean Value Theorems / Theorems about Derivatives（✅ 2026-10-09）
  - 🔧 R9 校对结论：tex 远非"基本完整"——md L16–613 有大量未吸收内容，已全部回收：
    - §4.1：微分定义（线性主部）、导数定义、可微⇔可导定理+证明、无穷小增量公式 note、Weierstrass 函数 note、单侧导数定义+caution（f'_+(x₀) 与 f'(x₀⁺) 之辨）、差商例题（lim(f(2x)−f(x))/x=A ⟹ f'(0)=A）、一阶微分形式不变性、隐函数求导例题（双解法）、参数方程求导
    - §4.2：n 阶可导定义、二阶微分无形式不变性 note、平坦函数 e^(−1/x²) 例题+归纳证明、光滑衔接函数例题（g(x)/(g(x)+g(1−x))）
    - §4.3：极值点 note（sin(1/x)、Riemann 函数）、Fermat/Rolle（最值法）/Lagrange（辅助函数+行列式）/Cauchy 证明、有限增量公式 note、Cauchy 参数形式 note、例题 4 个（有界性传递、行列式恒等式、二阶中值关系、微分不等式逼零）
    - §4.4：Darboux 升级为介值完整版+证明、导数极限定理证明、推论"导函数只可能有第二类间断点"+证明、x²sin(1/x) 例题、常函数导数例题（含有限例外点版本）
  - 修正 md 笔误 6 处（已迁入部分）：参数方程条件 φ(t)≠0 → φ'(t)≠0；Lagrange 行列式证明中 Δ'(x) 表达错误 → 改用展开式 (b−a)f'(x)−(f(b)−f(a))；有限增量公式 θ∈(a,b) → θ∈(0,1)；行列式例题证明 f'(ξ)x−f(ξ) → ξf'(ξ)−f(ξ)（并理顺首行负号）；二阶中值例题条件 D⁽²⁾₍₀,₁₎ → D⁽²⁾₍ₐ,ᵦ₎；Darboux 证明保号性 (F(x)−F(b))/(x−b)>0 → <0
  - 未迁例题 3 个，用户裁决（2026-10-10）：Legendre 多项式与待定系数法**已补入**，Cauchy 中值变形**放弃**（md 证明不完整）。补入时另修正 md 笔误 3 处：$P_2$ 系数 (3x²−2)/2 → (3x²−1)/2；待定系数法陈述定义域 [0,1] → [−1,1]；其证明中 F'(x) 表达式含多余的 −f(0) 项（已按 b=0 重写）
  - 未迁定理笔误备忘：md L119 积函数求导法则陈述第二个 `=` 应为 `+`；md L289 Leibniz 归纳证明末行漏升 m+1（tex/Typst 侧均无此证明，不受影响）
- [x] **B4b = ch04 §5–7**（tex 约 155 行，回收后约 690 行）：Taylor Theorem / Properties of Functions / Applications（✅ 2026-10-10）
  - 🔧 R9 校对结论：「tex 已基本完整」假设不成立——md L614–1087 有大量 tex 未吸收内容，已全部回收：
    - §4.5：L'Hôpital 法则定理（0/0 与 ∞/∞ 两情形）+ 双 Case 证明（延拓+Cauchy / ε 论证）+ caution（去心邻域要求、f'/g' 不存在与 f/g 极限无关）+ 例题（lim[f(x)+f'(x)]=A ⟹ f→A, f'→0）+ note（1/q 型推广用 e^(qx)）；Taylor-Peano 定理+note（n 阶导数在一点的含义）+证明（L'Hôpital 反复+导数定义收尾）、Taylor-Lagrange 定理+note（n=0 退化）+证明（固定 x 对 r_n 与 (t−x₀)^(n+1) 反复 Cauchy n+1 次——md 原证明将取极限与中值混淆，已重写为标准链）+ 例题（待定常数法 f(b)=f(a)+f'((a+b)/2)(b−a)+f'''(c)/24·(b−a)³）；Maclaurin 引理（泰勒多项式导数性质）+ 6 个常用展开（e^x、ln(1+x)、sin、cos、arctan、arcsin）+ (1+x)^α + 4 个特例 + note（常用公式的 Lagrange 余项，含 α=±1 得 1/(1±x) 完整余项）；Euler 数与 Bernoulli 数定义、∑1/n^(2k) 与 Basel note、tan x 展开
    - §4.6：凸函数定义+ConvexFunction.png 图+拐点引入、等价表征定理（4 条件：弦不等式/Jensen 加权/n 点平均/切线below 图；2⟺3、连续时 123、可导时全部）+ 三步证明（2^k 倍增+向下归纳 / 连续性+有理数逼近 / 引用导数判据）、Jensen 不等式+归纳证明（补全——tex/md 均无完整证明；md 的 Taylor 法证明作为 f∈D⁽²⁾ 时 note 保留）、导数判据定理（单调性 f'≥0 ⟺ 增、凸性 f' 增 ⟺ 凸）+双向证明+note（严格性、有限例外点、x³）、拐点定理（两侧变号 ⟺ 拐点；拐点 ⟹ f''(x₀)=0）+note（f'' 不存在的点也要考察）、驻点定义+三分类 terms、渐近线定义（距离刻画；水平/斜/垂直三型+存在充要条件）
    - §4.7：极值点必在驻点与不可导点之中、极值三判据（第一/第二/第三）+第三判据证明（Peano 展开）+note（第二判据为第三判据 n=1 特例，需 f'' 连续）、界的估计 note（由 f、f'' 界估 f'）+ 3 例题（|f'|≤2A+B/2、Landau 不等式 M₁²≤2M₀M₂、φ'' 有界+φ 有极限 ⟹ φ'→0）
  - 修正 tex/md 笔误 12 处：tex L245 二项式展开求和上限 α → n；tex L297 tan x 展开系数公式整体错误 → `(-4)^n(1-4^n)B_(2n)/((2n)!) x^(2n-1)`（n=1,2,3 验证；md 同式 n 应从 1 起）；md L791 L'Hôpital 证明分母 g(x₀) → g(x)；md L796 「整数 δ」→ δ∈(0,ρ)；md L915 Maclaurin 余项 θ∈(0,1) 错位（未迁，tex 无此内容）；md L934 1/(1−x) 余项 (1+θx)^(n+1) → (1−θx)^(n+1)；md L1009–1010 极值判据两处均标 (i) → (i)(ii)；md L1014 第三判据展开 (x−x₀)^n → (x−x₀)^(n+1)（并补全 n 为奇数的情形）；md L1027 |f'| 例题结论定义域 [a,b] → [0,1]（与陈述一致）；md L1042 Landau 例题 M₂ 未定义 → 补 M₂ = sup|f''|；md L1053 Landau 结论 √(2M₁M₂) → √(2M₀M₂)；md L1082 斜渐近线第二极限方向 +∞ → −∞
  - 放弃项：md L818–834 例题（f''' 极限与 f 极限链，证明多处混乱）；md L837–846 例题（Rolle 应用，与 L'Hôpital 无关且 B4a 已有同类）；md L963–975 Hölder/Minkowski（仅陈述无证明）；md 求极限/近似计算小节（空）；md Euler/Bernoulli 数递推式（tex 已覆盖定义与主要值）；md sin/cos 的 Lagrange 余项（指标混乱不冒险迁入）
- [x] **B5 = ch05 Indefinite Integral**（tex 85 行 / 1 节，⚠ P1-1；回收后约 320 行，扩为 5 节）（✅ 2026-10-10）
  - 🔧 P1-1/R5 ✅：按"评估扩为多节"决策，ch05 由 1 节扩为 5 节：
    - Antiderivatives and Indefinite Integrals（新增，md L1091–1098）：原函数/不定积分定义 `<def:indefinite-integral>`、原函数仅差常数说明、线性性命题 `<prop:linearity-integrals>` + 证明（含 k₁=k₂=0 时右端理解为 C）
    - Basic Integration Formulas（leftbarTitle 升级）：tex 基本积分表 25 条迁移为 tex-table，从 md 积分表补入 ∫ln x dx 与 ∫dx/(x²−a²)；√(a²±x²) 结果由例题给出避免重复
    - Two Common Integration Methods（tex 主体+md 回收）：补全 Substitution Method 空壳定义（第一换元/凑微分 + 第二换元/逆代换，md L1102–1103）`<def:substitution-method>`、分部积分定义 `<def:integration-by-parts>`（tex 已有）、"反对幂三指"选择原则 note、常用代换 terms（三角/无理/倒代换，tex 已有）、例题 5 个：tan 与 sec（`<ex:tangent-secant-integrals>`）、√(a²−x²)（`<ex:sqrt-a2-minus-x2>`）、√(x²+a²)（`<ex:sqrt-x2-plus-a2>`）、I_n 递推（`<ex:recurrence-in>`）、1/(1+x⁴) 配对法（`<ex:pairing-fourth-degree>`），均出自 md eg，补 x=0 处 arctan 跳跃的区间说明
    - Integration of Rational Functions（新增，md L1164–1178）：部分分式分解与两类基本积分定理 `<thm:rational-integration>`（Type 2 补配方与拆分说明，链接 I_n 递推例题）、Chebyshev 定理 `<thm:chebyshev>`（二项微分式三情形，按标准表述写为当且仅当）
    - Integration of Trigonometric Rational Functions（新增，md L1181–1185）：万能代换定理 `<thm:universal-substitution>` + 双角公式证明
  - 修正 md 笔误 4 处：L1142 1/(1+x⁴) 最终结果缺 ln 系数 1/(4√2)（按 ½[(M−N)+(M+N)] 重算）；L1171 Type 2 分母漏 ^r 上标；L1184 万能代换 cos t → cos x；L1135 递推推导排版混乱（误写 I_n = (1/a²)I_n，正确恒等式为 a²/(x²+a²)ⁿ = 1/(x²+a²)ⁿ⁻¹ − x²/(x²+a²)ⁿ）
  - 放弃项：md L1187–1188 Poisson 积分例题（仅题目无解答）；md L1192"无理函数积分的例子"（空节，其内容已由常用代换 terms 覆盖）
  - 新环境符号坑：arccot 非预定义 → 表内改用 `"arccot"` 字符串形式
- [x] **B6a = ch06 §1–4**（tex 约 300 行，回收后约 1230 行）：Riemann Integral / Integrability Criteria / Properties / Fundamental Theorem of Calculus（✅ 2026-10-10）
  - md 校对回收（md L1195–2143 比 tex 全得多，按 R9 模式补全）：
    - §1：Darboux 定理完整证明（md 独有）、可积函数基本事实+有界性证明、Dirichlet note；Riemann-Stieltjes 积分定义
    - §2：三充要条件+完整证明 `<thm:integrability-criteria>`、可积技巧 note（Riemann 函数 `<ex:riemann-function-integrable>`、逐点为零例题 `<ex:pointwise-vanishing>`）、振荡 4 引理+证明 `<lem:oscillation-lemmas>`、Lebesgue 定理+双向证明 `<thm:lebesgue>`
    - §3：性质 5 条+完整证明 `<prop:riemann-integral-properties>`、正积分例题 `<ex:positive-integral-subinterval>`、第一/第二积分中值定理+Abel 变换证明 `<thm:integral-mean-value>`、复合函数可积性+双证明+三反例 note `<prop:composite-integrability>`、平移连续例题 `<ex:translation-continuity>`
    - §4：变限积分定义+性质 4 条+证明 `<def:variable-limit-integrals>`/`<prop:variable-limit-integrals>`、Riemann 函数无原函数 note、积分上限函数 note、例题 3 个（可积不连续但有原函数 `<ex:antiderivative-of-discontinuous>`、导函数不可积 `<ex:nonintegrable-derivative>`、Volterra note）、N-L 公式+广义形式+证明 `<thm:newton-leibniz>`、差商极限例题 `<ex:difference-quotient-limit>`、导函数可积充要条件 `<ex:derivative-integrability>`、"Common Questions" 空壳升级为 === 小节+A/B/C/D 分类导览 note
  - 修正 tex/md 笔误（B6a 累计）：tex §3 性质第 5 条 "[a,b] and [c,d]" → [a,c] 与 [c,b]（tex+md 同笔误）；md L1456 t_{s_n} → t_{k_n}；L1473 零测集覆盖多余逗号；L1489 Σ₂Δx₂ → Σ₂Δxᵢ；L1552–1553 区间套长度记号混乱（按递推形式重写）；L1643 Abel 变换 g(x_{i+1})−g(x_i) → g(x_{i-1})−g(x_i)；L1649 末项 mg(a) → Mg(a)；Darboux 定理/第三充要条件证明 M=m 时 δ 分母为零 → 补 M>m 假设；平移连续例题条件不足 → 修正为 f ∈ R[a−h₀, b+h₀]（中间估计不精确已按正确计算重写）；md Lebesgue 法证明 D_{g∘f} ⊂ _f → ⊂ D_f；md L1799 导函数公式 2x sin(1/x)−(2/x²)cos(1/x²) → 2x sin(1/x²)−(2/x)cos(1/x²)
  - 放弃项：导函数可积充要条件 md Proof 1（m ≤ F′ ≤ M 只给全区间控制，论证错误，只收 Proof 2）；md 连续点稠密例题、Bonnet 公式应用 4 小题、平移连续 Proof 2（空）、A2/B1/B2/C1/D2/D5 例题（证明均为图片）；md L1870–1875 Riemann 引理（tex 无对应，涉及周期函数平均，暂缓）
  - B5 遗漏修复：ch05 补一级章标题 `= Indefinite Integral`；本地遗留修复：§2 的 13 处 `omega_f(` 下标违规 → `omega_f (`、§3 反例 cases 分支内 `\` 换行告警 → `"otherwise"`
  - 新符号坑：`setminus`/`conv`/`empty` 均为非法符号 → `\`/`inter`/`emptyset`；`bigl(/bigr)` 是 LaTeX 残留 → 普通括号自动调整；cases 分支内 `\` 被解析为换行 → 避免在分支内使用集合差
- [x] **B6b = ch06 §5–7**（约 144 行，迁移后约 350 行）：Calculation / Integral Inequalities / Applications（✅ 2026-10-10）
  - §5 Calculation：定积分换元定理 `<thm:definite-substitution>`+严格单增推论 `<cor:monotone-substitution>`、定积分分部定理 `<thm:definite-integration-by-parts>`+证明（广义 N-L）、对称性命题（3 条）`<prop:integral-symmetry>`、周期性命题 `<prop:integral-periodicity>`（以上 tex 均无，从 md L1982–2005 回收）；Wallis 例题 `<ex:wallis>`+md 递推证明+2 条 note（I(m,n) 归纳说明）、Simpson 万能公式 `<ex:simpson-formula>`（md 独有，无证明保持原样）、计算例题组 `<ex:integral-computations>`（md eg.1 的 1)2)3)5) 四题+解+caution）
  - §6 Integral Inequalities：六大不等式（Hadamard/Schwarz/Hölder/Young/Minkowski/Chebyshev 含离散形式）`<thm:integral-inequalities>`；Hölder 完整证明（md 独有文字证明，归一化 φ/ψ+初等 Young）；凸性积分不等式例题+完整证明（换序积分）`<ex:convex-integral-inequality>`
  - §7 Applications：弧长定义 `<def:arc-length>`+可求长充分条件定理 `<thm:rectifiable-condition>`（md 独有，无证明保持原样）；极坐标公式表（6 行 4 列）用 `#tex-table` + 8.5pt 字号包裹（auto 列宽下长公式溢出重叠，缩小字号后整表一页）
  - 修正 md 笔误 4 处：递推证明 π/1 → π/2；归纳 note "β π/2" 缺等号；5) 题分式 sin x/cos x 颠倒（应为 cos x/sin x，与后续步骤自洽）；2) 题补 1/(2√2) 系数（md 漏写 √2）
  - 放弃项：md eg.1 第 4) 题 ∫₀¹ ln x/(1−x²) dx（解仅为外链图片，且属反常积分主题，留待 B7 处理）；正交函数列例题（md eg.4，属 Fourier 正交系概念，受 §3.3 职责边界约束不迁入）；Schwarz/Young 不等式证明（md 仅为图片）；曲率小节（md 空节）；极坐标图片（外链失效）
  - 渲染坑：`#tex-table` 固定 auto 列宽不支持传参，宽表格需用 `#text(size: ...)` 包裹缩字号；`|_a^b` 求值记号、`!!` 双阶乘、`lr(\{...\})`、`norm()` 均渲染正常
- [x] **B7 = ch07 Improper Integral**（192 行 / 4 节，迁移后约 600 行）（✅ 2026-10-10，`006149d`）
  - [x] §7.1 Infinite and Defective Integrals（无穷积分 `<def:infinite-integral>` / 瑕积分 `<def:defective-integral>` 定义 + 3 条 note（性质保持 / N-L 公式与换元分部对反常积分的适用警示 / 乘积可积性，修正 md「乘积可加性」笔误）+ p 积分例题 `<ex:p-integrals>`+解；🔧 P1-6 ✅：Cauchy 主值 `<def:cauchy-principal-value>` 从 md L2171–2173 回收，`upright("cpv")` 记号）
  - [x] §7.2 Convergence Tests（绝对/条件收敛定义 `<def:abs-cond-convergence-integral>`；=== Infinite Integrals：Cauchy 准则 `<thm:cauchy-criterion-infinite-integral>`+证明、绝对⇒收敛推论 `<cor:absolute-implies-convergence>`、比较判别法 4 型 `<thm:comparison-tests-infinite-integral>`（修正 tex 笔误：极限形式/p 积分比较的范围、`f(x) ≤ K/x^p`）、Abel-Dirichlet `<thm:abel-dirichlet-infinite-integral>`（Abel 完整证明；Dirichlet md 仅"与 Abel 类似"，已补全证明并引用 `<thm:integral-mean-value>` Bonnet 公式）；=== Defective Integrals：Cauchy 准则 `<thm:cauchy-criterion-defective-integral>`（修正 md `(b-a)^p`→`(b-x)^p`、积分上限笔误）、p 积分比较 `<thm:comparison-tests-defective-integral>`、Abel-Dirichlet `<thm:abel-dirichlet-defective-integral>`；=== Examples：敛散性例题 `<ex:improper-convergence>` 4 题完整解（修正 md 3 处笔误：1) 题 p≥2 应为发散非条件收敛、1.2) 题 `9<p≤1`→`0<p≤1`、2.1) 题 q∈(p,1)→q∈(1,p)）+ 和差收敛 note + 对数积分 exercise `<ex:logarithmic-integral>`（B6b 遗留项，仅陈述））
  - [x] §7.3 Special Integrals（=== Definite：Dirichlet 核 `<ex:dirichlet-kernel>`+telescoping 解（修正 md `lim D_n=(2n+1)/2` 笔误为 `2n+1`）、Fejér `<ex:fejer-integral>` md 无证明保持原样；=== Improper：Euler `<ex:euler-integral>`+解、Froullani `<ex:froullani-integral>`、Dirichlet 积分 `<ex:dirichlet-integral>`+完整证明（Riemann-Lebesgue 引理以内联括号陈述，引理未迁入不编造来源）、Euler-Poisson/Poisson 仅陈述、特殊振荡积分 `<ex:special-oscillatory-integral>`+xsinx.png `<fig:special-integral-graph>`、Gamma 离散形式 `<ex:gamma-discrete>`+归纳解（修正 md `I_n n!`→`I_n = n!`，归纳步补漏 n 因子））
  - [x] §7.4 Common Questions（=== Square Integrable：定义 `<def:square-integrable>` + rela.png `<fig:integrability-relationships>` + 关系命题 `<prop:square-integrable-relations>`+反例证明（吸收 tex `|f|⇏f²` 空壳）；=== Behaviour at Infinity：收敛 ⇏ f(+∞)=0 与 limsup=+∞ 讨论、Vanishing at Infinity `<prop:vanishing-at-infinity>` md 无证明仅陈述、一致连续判据 `<thm:uniform-continuity-vanishing>`+双证明（修正 md Proof 1 同号论证笔误为与 ε₀/2 矛盾）、练习例题 `<ex:infinity-exercises>`）
  - 放弃项：md eg.1 的 3) 题 ∫₀^{+∞} x^{1-p}/|x-1|^{p+q} dx（无解答）；md eg.3（f,f′ 可积⇒lim f=0）与 eg.4（单调⇒xf(x)→0 等）证明为图片，仅迁陈述入 `<ex:infinity-exercises>`
  - 渲染坑：`upright(cpv)` 多字母裸标识符被解析为变量 → 必须加引号 `upright("cpv")`；`#link(<label>)` 裸用报 "missing argument: body" → 必须带 body 文字；`limsup`/`plus.minus`/`|_eta^(1/e)` 求值记号均正常
- [x] ✅ Part II 里程碑：编译 + 提交（✅ 2026-10-10，ch01–ch07 即 Part I–II 全部完成）

### Part III — Infinite Series

- [x] **B8a = ch08 §1–4**（迁移后约 460 行）：Convergence / Positive Term / General Term / Absolute and Conditional（✅ 2026-10-10，`15d75fa`）
  - §1 Convergence：tex 空节，从 md L14–30 回收级数定义 `<def:numerical-series>` + 4 条基本性质 `<prop:series-basic-properties>`
  - §2 Positive Term：正项级数定义 + note + 比较判别法 `<thm:comparison-test-series>`（含极限形式）；=== Cauchy and d'Alembert Tests `<thm:cauchy-dalembert-tests>`（limsup 链完整证明）+ 强弱 note；=== Raabe, Bertrand and Gauss Tests：`<thm:raabe-bertrand-tests>`（Raabe 证明 `#proof(name: "of the Raabe test")` + Bertrand 精细化 note + 判别法源流 note）、`<thm:gauss-test>`、`<thm:generalized-gauss-test>`（tex 大 theorem 按证明关联性拆分）；=== Integral Test `<thm:cauchy-integral-test-series>`+证明；=== Cauchy Condensation Test `<thm:cauchy-condensation>`+证明
  - §3 General Term：=== Cauchy Criterion `<thm:cauchy-criterion-series>`；=== Alternating Series `<def:alternative-series>`/`<thm:leibniz-test>`（p 奇偶分类证明）；=== Abel-Dirichlet：`<thm:abel-transform>`+AbelTransform.jpg（180° 旋转保留）+证明、`<lem:abel-lemma>`+证明、`<thm:abel-dirichlet-series>`（3Mε/6Mε 证明）、`<ex:ad-test-application>`+solution
  - §4 Absolute and Conditional：定义 `<def:abs-cond-convergence-series>`+note；正负导出级数 `<def:positive-derived-series>`/`<prop:derived-series-properties>`+证明；更序 `<def:rearranged-series>`/`<thm:commutative-absolute-series>`+证明、Riemann 重排 `<thm:riemann-rearrangement>`+证明；级数乘法 `<def:series-product>`（mat() 矩阵 + Cauchy 乘积 + 正方形排列）/`<thm:absolute-convergence-product>` 仅陈述
  - 🔧 P1-5/R6 ✅：§4 从 md L307–508 回收正负导出级数、更序/重排、级数乘法（tex 仅 8 行定义）
  - 数学修正：Bertrand 判别法补漏 "- 1"（tex/md 同源笔误，∑1/(n ln n) 验证发散性）；d'Alembert 极限形式统一为 r < 1（tex 原写 r∈(0,1) 与 Cauchy 形式不一致）；md 三处笔误（L352 x_n'^- 下标、L359 ∑x_n^- = +∞、L365–367 摆动论证）；tex Abel 变换 L215 符号错误（`+ ∑(a_(k+1)-a_k)B_k` → 负号，用 md 版）
  - 数学验证：Gauß 判别法 δ=1 "失效"表述正确（∑1/(n ln n (ln ln n)^β) β>1 收敛与 β≤1 发散均满足 δ_n→1），未改动
  - 放弃项：Sapagof/Kummer 判别法（md L188–202，证明为图片）；md eg.1 积分判别法应用题、三级数题 2)3)、交错级数例题（证明均为图片）；md eg.1 1) ∑1/(ln n)^(ln n) 有完整证明但超出 R6 区段未迁
  - 渲染坑：`sqrt(x, n)` 非法（sqrt 仅单参数，报 unexpected argument），n 次根必须用 `root(x, n)`（本批 8 处）；模板无 `#remark` 组件，判别法源流用 `#note(title: "Genealogy of the Tests")` 呈现
- [x] **B8b = ch08 §5–7**（迁移后约 150 行）：Convergence Speed / Infinite Products / Special Series（✅ 2026-10-10，`835503c`，ch08 全章收口）
  - §5 Comparison of Convergence Speed：收敛快慢定义 + Du Bois-Reymond 定理 `<thm:du-bois-reymond-theorem>` + Abel 定理 `<thm:abel-divergence-speed>` + note；**数学修正**：tex Abel 定理分式颠倒（a_n/b_n → b_n/a_n，与 md L409 及"不存在发散最慢级数"语义一致），note 补全为收敛/发散双向表述；两定理均无证明（md Du Bois-Reymond 证明为图片；Abel 证明仅一行引 Sapagof 判别法——B8a 已放弃，**待用户裁决是否补证**）
  - §6 Infinite Products：tex 空壳 leftbarTitle "Infinite Products" 升级 `===` 小节，从 md L424–445 回收——无穷乘积定义 `<def:infinite-product>`、收敛充要条件 `<thm:infinite-product-criterion>`（补 p_n > 0 正性条件）、推论 1/2 `<cor:infinite-product-first>`/`<cor:infinite-product-second>`（推论 1 修正条件 a_n < 0 → -1 < a_n < 0）、绝对收敛定义 `<def:abs-convergence-infinite-product>` + 三命题等价 `<prop:abs-convergence-product-equivalences>`（md 均无证明，保持）；=== Two Formulas：Wallis 公式 `<thm:wallis-formula>` + note（指向 ch06 `#link(<ex:wallis>)` 点火公式递推证明）、Stirling 公式 `<thm:stirling-formula>`（**弃 tex 乘积展开式**——1/288n² 符号错误且 Bernoulli 通项下标混乱，改用 md L461 对数形式 + tex 简化形式；精确形式余项用 c_n 记号避免与对数形式 θ_n 同块冲突）
  - §7 Special Series：5 类常用级数（几何/telescoping/p-级数/q-级数/广义 q-级数）；🔧 R6 ✅：超几何级数 `<def:hypergeometric-series>` 从 md L493–505 回收——₂F₁ 定义（前置下标 `attach(F, bl: 2, t: 1)`，升阶乘 `x^overline(n)` 与 ch01 `<def:factorial-power>` 一致）+ 收敛性分类 + 判别法来源 note（d'Alembert + Raabe，t_n/t_(n+1) 展开验证 c - a - b + 1）+ 3 个表示例
  - 修正 tex 笔误：q-级数求和下限 n=1 → n=2（ln 1 = 0 使通项无定义）
  - 渲染坑：Typst 不支持裸前置下标 `$_2 F_1$`（报 unexpected underscore），须用 `attach(F, bl: 2, t: 1)` 函数形式
- [x] **B9 = ch09 Series of Functions**（258 行 / 3 节，单节体量大逐节推进）
  - [x] §9.1 Pointwise and Uniform Convergence（三 leftbarTitle 升级 `===` 小节；函数项级数/点态收敛/一致收敛/准一致收敛 4 定义 + Cauchy 准则 + 充要条件两刻画 + 连续/可积/可导三性质）
  - [x] §9.2 Uniform Convergence Tests（Weierstrass M-test、Abel-Dirichlet 一致版、Dini 定理 + Arzelà-Borel note，tex 空 `\ref{thm:}` 已去除改文字提及）
  - [x] §9.3 Special Cases：**空节删除**（tex L301 与 md L974–984 双空壳，仅 3 个无内容标题，不编造内容）
  - [x] 🔧 R8 校对 ✅：与 md L509–980 对照查漏——回收 4 类内容：①点态收敛缺陷 4 个完整反例 `<ex:pointwise-counterexamples>`（x^n 间断、sin(nx)/√n 逐项求导失效、Dirichlet 函数不可积、nx(1-x²)ⁿ 逐项积分失效）；②充要条件定理完整双刻画证明（修正 md L604「点态收敛」笔误为一致收敛）；③Dini 定理双证明（反证法 + 有限覆盖法）；④放弃项：Cauchy 准则证明（md 仅一行"与数列类似"）、例题 eg.1–6（证明多为外链图片；eg.4 六小题一致连续性讨论与 eg.6 Abel+Dirichlet 连环例质量高但超出 R8 定位，**待用户裁决是否补入**）
  - 渲染坑：双箭头 ⇉ 须用 `arrows.rr^(D)`（`arrow.rr` 报 unknown symbol modifier）；下标后紧接括号 `_n(` 批量修复为 `_(n)(`（含大写 `_N(`，Group-Object 大小写不敏感曾漏检）
- [x] **B10 = ch10 Power Series**（64 行 / 3 节）
  - [x] §10.1 Power Series and Its Convergence Radius：**P0-4 空节回收完成**（md L986–1140）——幂级数定义 `<def:power-series>`、Cauchy-Hadamard 定理 `<thm:cauchy-hadamard>`、d'Alembert 半径公式 `<thm:dalembert-radius>` + 缺项 note、和/逐项积/Cauchy 乘积半径估计 `<prop:power-series-algebra>`（md 2) 处 `x_n` 笔误修正为 `x^n`）、Abel 第一定理 `<thm:abel-first-theorem>`、Abel 第二定理 `<thm:abel-second-theorem>`（内闭一致收敛）+ 端点单侧连续推论 `<cor:abel-endpoint-continuity>`、Tauber 定理 `<thm:tauber-theorem>`（两版本，Item 1 完整证明迁移，引用 `#link(<thm:stolz-cesaro>)`）、和函数分析性质 `<thm:power-series-properties>`（连续/逐项求导/逐项积分 + 收敛域扩大缩小 caution）、逐项运算求和 4 小题完整例题 `<ex:power-series-sums>`（arctan 展开、x/(1-x)²、Σ(2n+1)/3ⁿ=2——md 末尾 `(1/3)^3` 笔误修正为 `(1/3)^n`、Σ(n²+1)/(2ⁿn!)）
  - [x] §10.2 Expanding Functions into Power Series：tex 2 定义保留（`<def:smooth-function>`、`<def:real-analytic-function>`）+ md 回收——Taylor 级数定义 `<def:taylor-series>`（含 Maclaurin）、展开唯一性 `<thm:uniqueness-power-series-expansion>`、光滑→解析三问 note、三反例 `<ex:smooth-not-analytic>`（CE1 逐区间缩放构造：一点 C^oo 而任何邻域内非 C^oo；CE2 Σsin2ⁿx/n! 完整两步证明：形式 Taylor 级数除中心处处发散；CE3 e^(-1/x)：Taylor 级数收敛于 0 而非 f）、幂级数皆 Taylor 级数 `<thm:power-series-are-taylor-series>`、可展开充要条件（R_n→0）`<thm:taylor-expandable-necessary-sufficient>`、两充分条件 `<thm:taylor-expandable-sufficient>`、积分型/Cauchy 型余项 `<thm:taylor-cauchy-remainder>`、常用 Maclaurin 级数表（10 条，Euler 数 E_(2n) / Bernoulli 数 B_(2n)）
  - [x] §10.3 Smooth Appropriation of Functions：**节名修正为 "Smooth Approximation of Functions"**（tex "Appropriation" 为用词错误）；4 定理（连续逼近可积 `<thm:continuous-approximates-integrable>`、光滑逼近连续 `<thm:smooth-approximates-continuous>`、Weierstrass 第一/第二逼近定理）+ R7 回收 2 完整例题：阶梯/连续函数上下包夹 `<ex:step-continuous-approximation>`、四类函数逐级逼近 `<ex:successive-approximation>`
  - 渲染坑：文本模式裸数学符号（`overline(S)`、`min_(...){...}`、`max{...}`）须包裹 `$...$` 并用 `lr({…})` 显示花括号；cases 分支内区间 `(0, +oo)` 等含逗号时用 `comma`
- [x] ✅ Part III 里程碑：编译 + 提交（ch07–ch10 全部迁入，Part III 级数篇收口）

### Part IV — Multivariable Calculus

- [ ] **B11 = ch11 Euclidean Spaces**（26 行 / 1 节，⚠ P0-1）
  - [ ] §11.1 Continuous Mappings（按现状迁移）
  - [ ] 🔧 P0-1 补全：`violet-make-outline` 出大纲（$\mathbb{R}^n$ 拓扑 / 多元极限 / 连续函数性质）→ 确认 → 写入
- [ ] **B12a = ch12 §1–3**（约 440 行）：Directional Derivatives / Higher-Order Partial Derivatives / Differential of Vector-Valued Functions
- [ ] **B12b = ch12 §4–5**（约 250 行）：Chain Rule / Mean Value Theorem and Taylor's Formula
- [ ] **B12c = ch12 §6**（约 370 行）：Implicit Function Theorem（长证明，单独成批）
- [ ] **B12d = ch12 §7**（约 300 行）：Extremum of Multi-variable Functions（含 Lagrange 乘子）
- [ ] **B13a = ch13 §1–2**（约 270 行）：Multiple Integrals on Bounded Closed Regions / Properties
- [ ] **B13b = ch13 §3–4**（约 200 行）：Calculation / Improper Multiple Integrals
- [ ] ✅ Part IV 里程碑：编译 + 提交

### Part V — Calculus Applications in Several Variables（几何应用与高级积分，决策③新增）

- [ ] **B14a = ch14 §1–3**（约 400 行）：Parameterization / Tangent and Normal Space / Intrinsic Geometry（含弧长）
  - [ ] 🔧 P1-2 执行：章名改为 "Introduction to Curve and Surface Theory"，Preface 中 "curve theory" 表述对齐
- [ ] **B14b = ch14 §4–6**（约 150 行）：Extrinsic Geometry / Oriented Surface（⚠ P0-3 空节）/ Bounded Variation
  - [ ] 🔧 P0-3 补全：Oriented Surface 大纲 → 确认 → 写入
  - [ ] 🔧 P1-3 执行：BV 节保留原位，加指向 Analyse Harmonique 的文字交叉引用
- [ ] **B15a = ch15 §1–3**（约 310 行）：Scalar Field 积分 / Differential Form / Vector Field 积分
- [ ] **B15b = ch15 §4–5**（约 200 行）：Stokes' Formula（含 Green/Gauß）/ Closed and Exact Forms
- [ ] **B16 = ch16 Variable Parameters**（279 行 / 5 节）
  - [ ] §16.1 Definite Integrals with Variable Parameters
  - [ ] §16.2 Elliptic Integrals
  - [ ] §16.3 Improper Integrals with Variable Parameters
  - [ ] §16.4 Analysis Properties of Uniform Convergence
  - [ ] §16.5 Euler Integrals
- [ ] ✅ Part V 里程碑：编译 + 提交

### 收尾

- [ ] **B17 附录**：Glossary 重建（`violet-glossary-indexer`）、参考文献终检、P2 决策项执行
- [ ] 删除死文件 `chap17.tex`/`chap18.tex`（P2-4）
- [ ] 全书终检：迁移检查清单（§6）逐项过 + 全量编译 + 提交

---

## 5. 单批标准流程

```bash
# 1. 脚本预转换（输出到 tmp/ 草稿，不直接写 initial.typ）
bun .agents/skills/violet-latex-to-typst/scripts/migrate.js \
  "1.Analyse/Analyse Mathématique/chapters/chapNN.tex" \
  "1.Analyse/Analyse Mathématique/tmp/chapNN_draft.typ"

# 2. AI 手动精修（逐节）：嵌套环境 / tabular→#tex-table / align 对齐 /
#    标签语义 / 双语标题注释 / 自定义运算符

# 3. 按 initial.tex 中的顺序并入 initial.typ 对应 #part 分组

# 4. 编译验证（每 1–2 节一次）
typst compile "1.Analyse/Analyse Mathématique/initial.typ" \
  "1.Analyse/Analyse Mathématique/initial.pdf" --root .

# 5. 批次完成 → git 提交（中文 Conventional Commits，仅本任务文件）
```

手动精修重点（脚本覆盖不了的）：
1. `tabular` → `#tex-table(...)`（ch01 三角公式表、Preface 记号表）
2. `align*` 的 `&`/`\\` → 多个 `$ ... $` 或 Typst align
3. 标题后补 `// 中文翻译`；**正文禁止中文**
4. 组件内标签引用用 `#link(<label>)[...]`，不直接 `@`
5. 绝对值 `abs(...)`、分数非单因子加括号、**下标后紧接括号必须 `{}` 包裹**（`mu_(X)(B)`，正则 `_([a-zA-Z])\(` 自查为 0 才算完）
6. 图片保持 `img/` 目录，`#figure(image("img/...", width: ...), ...) <fig:xxx>`
7. `\underline{...}` → **斜体** `_..._`（不用 `#underline`；用户钦定，2026-10-09）
8. 多行对齐公式统一为用户钦定样式：`& = `（等号两侧各一空格）+ 行尾 `\` 续行（最后一行不加 `\`），块内各行不额外填充对齐空格，如
   ```typst
   $
     sin alpha cos beta & = 1 / 2 [sin(alpha + beta) + sin(alpha - beta)] \
     cos alpha sin beta & = 1 / 2 [sin(alpha + beta) - sin(alpha - beta)]
   $
   ```

md 回收流程（批次含 🔧 R 任务时追加执行）：
1. 按 §3.5 表定位 md 行号范围，用 `Read(offset/limit)` 读取；
2. **中文正文 → 翻译为英文**，md 内的 `$...$` LaTeX 公式 → Typst 语法；
3. 外链图片一律不迁：可用文字/公式表达的替代，必须配图的走 Python 脚本生成到 `img/`；
4. 套用对应组件（`#definition`/`#theorem`/`#example`…）并加标签；
5. 与 tex 已有内容比对，重复的舍弃，只补 tex 缺失部分。

---

## 6. 迁移检查清单（每批自检）

- [ ] 标题层级正确（`=`/`==`），无 LaTeX 宏残留
- [ ] 定理类环境 → 对应组件（theorem 红 / definition 绿 / proposition·example 蓝 / axiom 紫）
- [ ] `<label>` 与 `@label` 转换完整，组件内标签改用 `#link`
- [ ] 数学符号全 Typst 语法（`integral`、`bb(R)`、`dif x`、`abs()`…）
- [ ] 双语标题：英文在前，中文仅在 `//` 注释
- [ ] 图片路径有效、`<fig:>` 标签齐全
- [ ] SRP 边界未越界（对照 §3.3 表）
- [ ] 编译退出码 0
- [ ] 下标括号正则自查 `_([a-zA-Z])\(` 命中为 0

---

## 7. 强约束

1. 不删除原始 `.tex` 与三份 `.md`（仅 P2-4 死文件例外）
2. 不改动 `TypstTemplate/math-notes.typ` 公共接口
3. 正文不允许中文（中文仅限 `//` 注释与本计划文档）
4. 遵循 `violet-typst-writing-conventions`（含编辑一致性与编译验证，§9.7/§9.8）/ `violet-template-usage` 两技能
5. 一节一节推进，小步编译，**不做大批量盲转**
6. P0 内容补全必须先 `violet-make-outline` 出大纲、经确认后写入，不凭空造内容
7. 每批完成自动 git 提交（中文 Conventional Commits，只提交本任务改动）
