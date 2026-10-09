# Analyse Mathématique 重构与 Typst 迁移计划

> 创建日期：2026-10-09
> 最后更新：2026-10-09（新增 §3.5 md 前身笔记对照与内容回收清单）
> 状态：✅ 计划已确认（3 项决策已定，见 §3.4）
> 技能依据：`latex-to-typst`（迁移）、`design-note`（目录体检）、`make-outline`（补全大纲）、`typst-writing-conventions`（写作规范）

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
  P0 硬伤补全需先按 make-outline 出大纲，经确认后写入
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
| P0-1 | 🔴 | ch11 | 章题含 "Limits" 但全章仅 1 节（Continuous Mappings），极限内容与 $\mathbb{R}^n$ 拓扑铺垫完全缺失，标题与内容不符 | B11 批迁移后，按 `make-outline` 出大纲补全 |
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
| P2-2 | 🟡 | 附录 | Glossary 仅 A–Q 且仅 1 条术语 | 收尾阶段用 `glossary-indexer` 重建 |
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

- [ ] **B0 骨架**：`initial.typ` 头部（import/set document/make-cover/make-outline）+ **5 个内容 `#part` + 1 个 Appendix `#part`**（按 §3.4 决策③：Part IV = ch11–13，Part V = ch14–16）+ Preface（含记号表）+ `references.bib`（从 `thebibliography` 提取 9 条）+ `#bibliography`。编译通过后提交。

### Part I — Limits and Continuity

- [ ] **B1 = ch01 Preliminaries**（109 行 / 3 节）
  - [ ] §1.1 Trigonometric Formulas（表格 → `#tex-table`）
  - [ ] §1.2 Common Inequalities（🔧 P1-4/R1：从 md 回收不等式专题）
  - [ ] §1.3 Factorial Power
- [ ] **B2 = ch02 Limits of Sequences**（139 行 / 5 节）
  - [ ] §2.1 Convergent Sequences
  - [ ] §2.2 Indeterminate Form
  - [ ] §2.3 Subsequences（🔧 P0-5：上下极限空壳从 md R2 回收）
  - [ ] §2.4 Completeness of The Real Numbers（🔧 P0-5：空壳 leftbarTitle 从 md R2 回收，含凝聚原理/有限覆盖）
  - [ ] §2.5 Iterative Sequences
- [ ] **B3 = ch03 Limits and Continuity of Functions**（49 行 / 6 节，⚠ 含 P0-2）
  - [ ] §3.1 Limits of Functions
  - [ ] §3.2 Continuous Functions（空节 → 从 md R3 补内容或合并）
  - [ ] §3.3 Infinitesimal and Infinite Quantities（空节 → 从 md R3 补：等价无穷小替换）
  - [ ] §3.4 Continuous Functions on Closed Intervals（空壳定理 → 从 md R3 补陈述/证明，含一致连续专题）
  - [ ] §3.5 Period Three Implies Chaos
  - [ ] §3.6 Functional Equations
- [ ] ✅ Part I 里程碑：编译 + 提交

### Part II — Single-variable Calculus

- [ ] **B4a = ch04 §1–4**（约 190 行）：Differential and Derivative / Higher-Order Derivatives / Differential Mean Value Theorems / Theorems about Derivatives
- [ ] **B4b = ch04 §5–7**（约 155 行）：Taylor Theorem / Properties of Functions / Applications
  - [ ] 🔧 R9 校对：与 md L16–1087 对照查漏（tex 已基本完整）
- [ ] **B5 = ch05 Indefinite Integral**（81 行 / 1 节，⚠ P1-1）
  - [ ] §5.1 Two Common Integration Methods
  - [ ] 🔧 P1-1/R5：从 md 回收"几类可积函数"（有理函数、三角有理式、无理函数积分），评估扩为多节
- [ ] **B6a = ch06 §1–4**（约 300 行）：Riemann Integral / Integrability Criteria / Properties / Fundamental Theorem of Calculus
- [ ] **B6b = ch06 §5–7**（约 144 行）：Calculation / Integral Inequalities / Applications
- [ ] **B7 = ch07 Improper Integral**（192 行 / 4 节）
  - [ ] §7.1 Infinite and Defective Integrals
  - [ ] §7.2 Convergence Tests
  - [ ] §7.3 Special Integrals
  - [ ] §7.4 Common Questions
  - [ ] 🔧 P1-6/R4：从 md 回收 Cauchy 主值与"其它问题"
- [ ] ✅ Part II 里程碑：编译 + 提交

### Part III — Infinite Series

- [ ] **B8a = ch08 §1–4**（约 250 行）：Convergence / Positive Term / General Term / Absolute and Conditional
  - [ ] 🔧 P1-5/R6：§4 从 md 回收正负导出级数、Riemann 重排定理、级数乘法
- [ ] **B8b = ch08 §5–7**（约 43 行）：Convergence Speed / Infinite Products / Special Series
  - [ ] 🔧 R6：Special Series 补超几何级数
- [ ] **B9 = ch09 Series of Functions**（258 行 / 3 节，单节体量大逐节推进）
  - [ ] §9.1 Pointwise and Uniform Convergence
  - [ ] §9.2 Uniform Convergence Tests
  - [ ] §9.3 Special Cases
  - [ ] 🔧 R8 校对：与 md L509–980 对照查漏（tex 已有准一致收敛、Dini）
- [ ] **B10 = ch10 Power Series**（64 行 / 3 节）
  - [ ] §10.1 Power Series and Its Convergence Radius（⚠ P0-4 空节 → 从 md R7 回收：收敛半径、Abel 定理、分析性质）
  - [ ] §10.2 Expanding Functions into Power Series
  - [ ] §10.3 Smooth Appropriation of Functions
- [ ] ✅ Part III 里程碑：编译 + 提交

### Part IV — Multivariable Calculus

- [ ] **B11 = ch11 Euclidean Spaces**（26 行 / 1 节，⚠ P0-1）
  - [ ] §11.1 Continuous Mappings（按现状迁移）
  - [ ] 🔧 P0-1 补全：`make-outline` 出大纲（$\mathbb{R}^n$ 拓扑 / 多元极限 / 连续函数性质）→ 确认 → 写入
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

- [ ] **B17 附录**：Glossary 重建（`glossary-indexer`）、参考文献终检、P2 决策项执行
- [ ] 删除死文件 `chap17.tex`/`chap18.tex`（P2-4）
- [ ] 全书终检：迁移检查清单（§6）逐项过 + 全量编译 + 提交

---

## 5. 单批标准流程

```bash
# 1. 脚本预转换（输出到 tmp/ 草稿，不直接写 initial.typ）
bun .agents/skills/latex-to-typst/scripts/migrate.js \
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
4. 遵循 `typst-writing-conventions` / `template-usage` / `typst-edit-consistency` / `typst-compile` 四技能
5. 一节一节推进，小步编译，**不做大批量盲转**
6. P0 内容补全必须先 `make-outline` 出大纲、经确认后写入，不凭空造内容
7. 每批完成自动 git 提交（中文 Conventional Commits，只提交本任务改动）
