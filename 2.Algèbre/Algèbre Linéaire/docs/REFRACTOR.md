# Algèbre Linéaire 重构与 Typst 迁移计划

> 创建日期：2026-10-10
> 最后更新：2026-10-10（B0 骨架完成：Preliminaries 章 + Notations + bibliography，编译通过）
> 状态：✅ B0 骨架完成，待开始 Part I 迁移（B2 = Determinants）
> **项目约定：每次完成批次后自动 git 提交（中文 Conventional Commits），无需用户手动确认。**
> 技能依据：`violet-design-note`（目录体检与结构设计）、`violet-latex-to-typst`（迁移）、`violet-make-outline`（补全大纲）、`violet-typst-writing-conventions`（写作规范）
> 参考文档：[`1.Analyse/Analyse Mathématique/docs/REFRACTOR.md`](../../1.Analyse/Analyse%20Mathématique/docs/REFRACTOR.md)

---

## 1. 总览

| 项目 | 值 |
|------|-----|
| 源文件 | `initial.tex` + `chapters/chap01–chap10.tex`（约 3272 行，约 60 节，0 张图） |
| 目标 | 单文件 `initial.typ`（仓库惯例，模板 `../../TypstTemplate/math-notes.typ`） |
| 迁移粒度 | **一节一节推进**，每 1–2 节编译一次（退出码 0 为通过） |
| 原始文件 | `.tex` 全部保留作为存档，不删除 |
| 附带任务 | 迁移过程中并行修复 §3.2 中的目录结构问题 |

规模速查（行数 / 节数 / leftbarTitle 数）：

```
ch01  1/0/0   ← 空章
ch02  90/4/3  Determinants
ch03 448/5/8  System of Linear Equations ← 混入线性空间理论
ch04 549/7/18 Matrices ← 章过重
ch05 101/10/5 Linear Spaces ← 与 ch03 §2 重叠
ch06 388/5/7  Linear Mappings
ch07 685/11/17 Diagonalization ← 全书最重
ch08 382/5/8  Jordan Forms
ch09  69/3/0  Quadratic Forms ← 章过轻
ch10 568/8/10 Inner Product Spaces
```

目标结构：**4 个内容 Part + Appendix**，共 10 章。

---

## 2. 总体策略

**三阶段并行推进，以 Part 为里程碑：**

```
阶段 A：骨架搭建（B0 批）
  initial.typ 头部 + #part 分组 + references.bib + 目录
         ↓
阶段 B：分批迁移（B1–B9，按章顺序，逐节推进）
  每批 = 脚本预转换 → AI 手动精修 → 合并 → 编译 → 提交
  迁移时顺带做"低成本修复"（空节删除/改名、章名对齐）
         ↓
阶段 C：内容补全（随各章迁移完成后触发）
  P0 硬伤补全需先按 violet-make-outline 出大纲，经确认后写入
         ↓
收尾：附录 Glossary、死文件清理、全书终检
```

**批次划分原则**：单批 ≤ 350 行或 ≤ 7 节；超大章（ch04/ch07/ch10）拆为 2–3 个子批；每批完成后 git 提交（中文 Conventional Commits，只提交本任务改动）。

---

## 3. 目录合理性分析（体检结论）

### 3.1 合理之处（迁移时保持原样）

1. **主线方向正确**：从具体计算（行列式→矩阵→线性方程组）到抽象结构（线性空间→线性映射）再到结构理论（对角化→Jordan标准型）最后到几何结构（二次型→内积空间），与主流高等代数教材的依赖顺序一致。
2. **依赖顺序基本正确**：ch02 行列式先于 ch03 线性方程组（Cramer 法则依赖行列式）；ch06 线性映射先于 ch07 对角化（特征值理论需要映射框架）；ch07 对角化先于 ch08 Jordan 标准型（Jordan 是 diagonalization 的自然推广）。
3. **教材覆盖完整**：10 章覆盖了丘维声《高等代数》、谢启鸿《高等代数学》、王萼芳《高等代数》三本教材的全部知识点。
4. **二次型与内积空间的先后顺序合理**：二次型（ch09）在欧几里得空间（ch10）之前，符合"先代数后几何"的教学顺序——二次型的正交变换标准形依赖 ch10 的内积理论，但二次型本身的矩阵表示和合同变换不依赖内积。

### 3.2 问题清单（含处理时机）

| 编号 | 级别 | 位置 | 问题 | 处理时机 |
|------|------|------|------|---------|
| P0-1 | 🔴 | ch03 §2 | "Linear Space"一节（约 300 行）包含线性空间定义、线性相关/无关、基与维数——这是线性空间理论的核心内容，却埋在"线性方程组"章内，标题与内容严重不符 | B3 批迁移前：整节移入新 Ch4 (Linear Spaces) |
| P0-2 | 🔴 | ch01 | Preliminaries 全空（仅 1 行 `\chapter{Preliminaries}`），无任何内容 | B0 骨架时处理：删除空章，内容下沉为 Ch1 的 Notations 节 |
| P0-3 | 🔴 | ch05 vs ch03 §2 | ch05 "Linear Spaces"与 ch03 §2 "Linear Space"严重重叠：ch03 §2 已定义线性空间、线性无关、基、维数、子空间、秩，ch05 本应深化却大量空节（§3 Isomorphisms、§4 Quotient Spaces 均空） | 迁移前合并：ch03 §2 + ch05 → 新 Ch4 |
| P1-1 | 🟠 | 全书 | 无 Part 分组：10 章扁平排列，无法体现"计算→抽象→结构→几何"的主线递进 | B0 骨架时直接按 4 Part 创建 |
| P1-2 | 🟠 | ch03 §1 | "Elimination Method"为空节（仅 `\section` 标题，无内容） | B3 批迁移时补全或合并 |
| P1-3 | 🟠 | ch04 | 7 节、549 行，涵盖基本运算/特殊方阵/逆矩阵/分块矩阵/矩阵函数/秩运算/低秩修正——一章承担太多，且 §3 Inverse Matrix、§5 Matrix Functions 均为空 | B2 批迁移时拆分 subsection 或补充 |
| P1-4 | 🟠 | ch07 | 7 节、685 行，全书最重；§7 "Simultaneous Characteristics"有 5 个空 leftbarTitle | B6 批迁移时逐节处理 |
| P1-5 | 🟠 | ch09 | 仅 69 行、3 节，§2 "Canonical Forms"为空——与 ch10（568 行）体量失衡 | B8 批迁移时从教材/参考书补全 |
| P2-1 | 🟡 | 全书 | 大量空 leftbarTitle（ch03 8个、ch04 18个、ch07 17个、ch10 10个），迁移时需逐批判断"补内容"还是"删空壳" | 随各批迁移处理 |
| P2-2 | 🟡 | 全书 | `secnumdepth=2` 但无 `\subsection`，大章内部粒度偏粗 | 迁移时不引入 `===`（与 Analyse Mathématique REFRACTOR §3.2 P2-3 一致），仅对确实需要细分的大节引入 |

### 3.3 职责边界表（迁移时校验，不得越界）

| 内容 | 归属 | 本笔记处理方式 |
|------|------|---------------|
| 集合论/映射/等价关系基础 | Théorie des Ensembles | 不重复，Preliminaries 中仅给记号表 |
| 多项式理论（因式分解、根与系数关系等） | Algèbre Abstraite | 不展开，仅在需要时引用（如特征多项式、极小多项式、Cayley-Hamilton 定理） |
| 矩阵分析（矩阵级数、矩阵微分、矩阵函数深入） | 后续应用笔记 | 本笔记仅给矩阵函数的定义级概念（ch04 §5 空节，迁移时给最低限度定义） |
| Hilbert 空间（无穷维完备内积空间） | Analyse Fonctionnelle | 有限维 Euclidean/Unitary 空间归本笔记；无穷维归泛函 |
| 模论（一般环上的模） | Algèbre Abstraite | 不涉及 |
| 张量积与外代数 | Algèbre Abstraite | 不涉及 |

### 3.4 目标目录结构（4 Part / 9 Chapter）

主线叙事：**具体计算 → 抽象结构 → 算子结构理论 → 几何结构**

```
Part I  行列式、矩阵与线性方程组（具体计算工具）
  ↓ 行列式→矩阵→用矩阵秩刻画线性方程组解结构
Part II 线性空间与线性映射（抽象结构）
  ↓ 向量空间→映射→矩阵表示建立"空间↔矩阵"桥梁
Part III 线性算子的结构理论（对角化与Jordan标准型）
  ↓ 相似不变量→特征值→空间分解→标准型
Part IV 二次型与内积空间（几何结构）
    二次型→内积→正交变换→酉变换
```

#### Part I — Determinants, Matrices and Linear Systems (行列式、矩阵与线性方程组)

| 章 | 标题 | 来源 | 节 |
|----|------|------|-----|
| Ch1 | Preliminaries (预备知识) | 原 Preface 记号内容 | §1 Notations |
| Ch2 | Determinants (行列式) | 原 ch02 | §1 Permutations / §2 Determinant and Its Properties / §3 Expanding by Rows (Columns) (含 === Cramer's Rule) / §4 Special Determinants (Vandermonde, Arrow, Two-Triangular) |
| Ch3 | Matrices (矩阵) | 原 ch04 | §1 Basic Operations (含 === Determinants of Products / === Matrix Equivalence) / §2 Special Square Matrices (含 === Diagonal / === Triangular / === Symmetric / === Circulant / === Nilpotent 等) / §3 Inverse Matrix / §4 Block Matrix (含 === Kronecker Product / === Determinant Reduction Formula) / §5 Operations of Rank / §6 Low-Rank Corrections (Sherman-Morrison, Woodbury) |
| Ch4 | Linear Systems (线性方程组) | 原 ch03 清洗（移除 §2 Linear Space） | §1 Elimination Method / §2 Rank of Vector Groups and Matrices (含 === Maximal Independent Group / === Rank of Matrices) / §3 Solution to Linear Systems (含 === Homogeneous / === Nonhomogeneous) |

#### Part II — Linear Spaces and Linear Mappings (线性空间与线性映射)

| 章 | 标题 | 来源 | 节 |
|----|------|------|-----|
| Ch5 | Linear Spaces (线性空间) | 原 ch03 §2 + ch05 合并 | §1 Linear Spaces and Their Bases (含 === Definition and Examples / === Linear Dependence and Independence / === Dimension, Basis, Coordinates) / §2 Subspaces (含 === Intersection and Sum / === Direct Sum) / §3 Isomorphisms / §4 Quotient Spaces / §5 Special Linear Spaces |
| Ch6 | Linear Mappings (线性映射) | 原 ch06 | §1 Linear Mappings and Their Computation (含 === Definition / === Existence and Uniqueness / === Operations) / §2 Kernel and Image (含 === Rank-Nullity / === Cokernel / === Ascending Chain) / §3 Matrix Representation / §4 Special Linear Transformations (含 === Idempotent / === Projection) / §5 Linear Functions and Dual Spaces |

#### Part III — Structure Theory of Linear Operators (线性算子的结构理论)

| 章 | 标题 | 来源 | 节 |
|----|------|------|-----|
| Ch7 | Diagonalization (对角化) | 原 ch07 | §1 Similarity of Matrices / §2 Eigenvectors and Eigenvalues (含 === Eigenpolynomial / === Multiplicity and Eigenspaces / === Gerschgorin Disks) / §3 Minimal Polynomial / §4 Space Decomposition (含 === Invariant Subspace / === Root Subspaces) / §5 Diagonalization / §6 Diagonalization of Special Matrices / §7 Simultaneous Characteristics |
| Ch8 | Jordan Canonical Form (Jordan标准型) | 原 ch08 | §1 Polynomial Matrices (含 === Smith Normal Form) / §2 Invariant Divisors and Rational Canonical Form (含 === Companion Matrix / === Cyclic Subspace) / §3 Elementary Divisors and Jordan Canonical Form / §4 Finding Jordan Form and Transition Matrices / §5 Complete Set of Invariant Quantities |

#### Part IV — Quadratic Forms and Inner Product Spaces (二次型与内积空间)

| 章 | 标题 | 来源 | 节 |
|----|------|------|-----|
| Ch9 | Quadratic Forms (二次型) | 原 ch09 | §1 Quadratic Forms and Their Standard Forms / §2 Canonical Forms / §3 Definite Quadratic Forms |
| Ch10 | Inner Product Spaces (内积空间) | 原 ch10 | §1 Bilinear Forms / §2 Real Inner Product Spaces (含 === Norm / === Cauchy-Schwarz / === Orthogonality) / §3 Metric Matrices and Orthonormal Bases (含 === Gram-Schmidt) / §4 Orthogonal Completion and Projection / §5 Orthogonal and Symmetric Transformations / §6 Unitary Spaces and Normal Transformations (含 === Unitary / === Hermitian) / §7 Symplectic Spaces |

### 3.5 关键调整说明

1. **ch03 §2 "Linear Space"→ Ch4 Linear Spaces**：将线性空间定义、线性相关/无关、基与维数从"线性方程组"章中提取出来，与原 ch05 合并为完整的 Linear Spaces 章。Ch3 (Linear Systems) 保留消元法、矩阵秩、解结构——这三项不依赖线性空间的抽象框架，仅依赖矩阵的初等变换和行列式。

2. **ch01 Preliminaries → 恢复为独立章**：原决策为删除空章、记号下沉为 Ch1 Notations。经用户反馈调整为：恢复 Preliminaries 为独立 Ch1，Notations 作为其唯一节。参考 Analyse Mathématique B0 批决策的后续修订（"取消独立 Preface 章"）不同——本笔记采用 Preliminaries 独立章模式，更符合原教材结构。

3. **原 10 章 → 新 10 章**：ch01 Preliminaries 恢复为独立章（含 Notations），ch03 §2 被移出（并入 Ch5），其余按 Part 重组为 10 章。Part I 含 4 章（Preliminaries + Determinants + Matrices + Linear Systems），Part II–IV 各含 2 章。

4. **空节处理原则**（参考 REFRACTOR.md §3.2）：迁移时按"空壳→补内容 or 删空壳"逐批判断。具体规则：
   - 空 `\section`（仅标题无内容）：迁移时判断——有教材/参考书可取材的补内容，无来源的删空壳并留 `//` 注释标记。
   - 空 `leftbarTitle`（仅小节标题无内容）：升级为 `===` 或保留为粗体段落标签，取决于后续是否有内容填充。
   - 空 `proof` 环境：按"空壳原则不编造"处理（与 Analyse Mathématique 一致）。

### 3.6 决策记录

> 以下 4 项决策已于 2026-10-10 用户确认。

- **①（P0-1/P0-3）线性空间内容迁移** → ✅ 已确认：ch03 §2 + ch05 → 新 Ch4 Linear Spaces。
- **②（P0-2）Preliminaries 处理** → ✅ 已确认（2026-10-10 用户反馈调整）：**恢复为独立 Ch1 Preliminaries**，Notations 作为其唯一节。原决策为删除空章、记号下沉，经用户反馈改为恢复独立章。
- **③（P1-1）Part 分组** → ✅ 已确认：4 Part 10 章，按主线叙事自然划分。
- **④（P2-1）空节处理** → ✅ 已确认：逐批判断，迁移时按"有来源补内容、无来源删空壳"处理。

---

## 4. 迁移批次与进度追踪

> 勾选规则：节级完成（迁移+编译通过）勾节；整批完成（编译+提交）勾批。
> 批次内小批（如 B2a/B2b）全部完成才算整批完成。

### 阶段 A

- [x] **B0 骨架**：`initial.typ` 头部（import/set document/make-cover/make-outline）+ **4 个内容 `#part` + 1 个 Appendix `#part`** + Ch1 Preliminaries（Notations 节，从原 Preface 回收记号内容）+ `references.bib`（6 条）+ `#bibliography`。编译通过后提交。（✅ 2026-10-10）
- [x] **B1 = Ch1 Preliminaries**（记号内容从原 Preface 回收）✅ 已在 B0 中一并完成
  - [x] §1 Notations（记号表：矩阵/映射记号、相似、特征多项式、极小多项式）

### Part I — Determinants, Matrices and Linear Systems

- [ ] **B2 = Ch2 Determinants**（90 行 / 4 节）
  - [ ] §1 Permutations
  - [ ] §2 Determinant and Its Properties
  - [ ] §3 Expanding by Rows (Columns)（含 === Cramer's Rule / === Expanding by k Rows）
  - [ ] §4 Special Determinants（Vandermonde, Arrow, Two-Triangular）
- [ ] **B3 = Ch3 Matrices**（549 行 / 7 节，⚠ 含空节，拆为 2–3 个子批）
  - [ ] B3a §1 Basic Operations + §2 Special Square Matrices（前半）
  - [ ] B3b §2 Special Square Matrices（后半）+ §3 Inverse Matrix + §4 Block Matrix
  - [ ] B3c §5 Operations of Rank + §6 Low-Rank Corrections
- [ ] **B4 = Ch4 Linear Systems**（ch03 清洗后约 200 行 / 3 节，⚠ 移除 §2 Linear Space）
  - [ ] §1 Elimination Method
  - [ ] §2 Rank of Vector Groups and Matrices
  - [ ] §3 Solution to Linear Systems
- [ ] ✅ Part I 里程碑：编译 + 提交

### Part II — Linear Spaces and Linear Mappings

- [ ] **B5 = Ch5 Linear Spaces**（ch03 §2 + ch05 合并，约 400 行 / 5 节，⚠ 含空节）
  - [ ] §1 Linear Spaces and Their Bases
  - [ ] §2 Subspaces
  - [ ] §3 Isomorphisms
  - [ ] §4 Quotient Spaces
  - [ ] §5 Special Linear Spaces
- [ ] **B6 = Ch6 Linear Mappings**（388 行 / 5 节）
  - [ ] §1 Linear Mappings and Their Computation
  - [ ] §2 Kernel and Image of Linear Mappings
  - [ ] §3 Matrix Representation of Linear Mappings
  - [ ] §4 Special Linear Transformations
  - [ ] §5 Linear Functions and Dual Spaces
- [ ] ✅ Part II 里程碑：编译 + 提交

### Part III — Structure Theory of Linear Operators

- [ ] **B7 = Ch7 Diagonalization**（685 行 / 7 节，⚠ 全书最重，拆为 3 个子批）
  - [ ] B7a §1 Similarity + §2 Eigenvectors and Eigenvalues
  - [ ] B7b §3 Minimal Polynomial + §4 Space Decomposition
  - [ ] B7c §5 Diagonalization + §6 Diagonalization of Special Matrices + §7 Simultaneous Characteristics
- [ ] **B8 = Ch8 Jordan Canonical Form**（382 行 / 5 节）
  - [ ] §1 Polynomial Matrices
  - [ ] §2 Invariant Divisors and Rational Canonical Form
  - [ ] §3 Elementary Divisors and Jordan Canonical Form
  - [ ] §4 Finding Jordan Form and Transition Matrices
  - [ ] §5 Complete Set of Invariant Quantities
- [ ] ✅ Part III 里程碑：编译 + 提交

### Part IV — Quadratic Forms and Inner Product Spaces

- [ ] **B9 = Ch9 Quadratic Forms**（69 行 / 3 节，⚠ 含空节）
  - [ ] §1 Quadratic Forms and Their Standard Forms
  - [ ] §2 Canonical Forms
  - [ ] §3 Definite Quadratic Forms
- [ ] **B10 = Ch10 Inner Product Spaces**（568 行 / 8 节，拆为 2 个子批）
  - [ ] B10a §1 Bilinear Forms + §2 Real Inner Product Spaces + §3 Metric Matrices and Orthonormal Bases
  - [ ] B10b §4 Orthogonal Completion + §5 Orthogonal and Symmetric Transformations + §6 Unitary Spaces + §7 Symplectic Spaces
- [ ] ✅ Part IV 里程碑：编译 + 提交

### 收尾

- [ ] Glossary 重建（用 `violet-glossary-indexer`）
- [ ] 死文件清理（`chapters/` 目录、`tmp/` 目录）
- [ ] 全书终检（编译 + 三正则命中 0 + 标签完整性）

---

## 5. 教材覆盖度映射

| 教材（丘维声/谢启鸿/王萼芳） | 知识点 | 本笔记位置 |
|-----|--------|-----------|
| 预备知识 | 数域、多项式、集合映射 | Ch1 Notations（迁移时从 Preface 回收） |
| 行列式 | 排列、性质、展开、特殊行列式 | Ch2 §1–4 |
| 线性方程组 | 消元、秩、解结构 | Ch4 §1–3 |
| 矩阵 | 运算、特殊矩阵、逆、分块、秩 | Ch3 §1–6 |
| 线性空间 | 定义、基、子空间、同构、商空间 | Ch5 §1–5 |
| 线性变换 | 定义、核像、矩阵表示、特殊变换 | Ch6 §1–5 |
| λ-矩阵与Jordan | 多项式矩阵、不变因子、初等因子 | Ch8 §1–3 |
| 二次型 | 标准形、规范形、正定 | Ch9 §1–3 |
| 欧几里得空间 | 内积、标准正交基、正交变换 | Ch10 §1–7 |

教材覆盖结论：三本教材全部知识点均已覆盖，无遗漏。
