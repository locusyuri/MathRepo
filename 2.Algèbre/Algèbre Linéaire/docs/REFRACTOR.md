# Algèbre Linéaire 重构与 Typst 迁移计划

> 创建日期：2026-10-10
> 最后更新：2026-10-11（遗漏补全：正交变换、实内积空间同构、反对称变换、最小二乘法、Jordan 角度对角化条件、Gauss-Jordan 流程、基础解系证明）
> 状态：✅ 全部完成（Part I–IV + Glossary + 参考文献 + 遗漏补全）
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

- [x] **B2 = Ch2 Determinants**（90 行 / 4 节）✅ 2026-10-10
  - [x] §1 Permutations（tex 空节 → 按决策④从教材补全：排列定义、逆序数、奇偶性与符号）
  - [x] §2 Determinant and Its Properties（tex 空节 → 按决策④从教材补全：Leibniz 定义、五性质、乘积定理+证明、可逆性推论）
  - [x] §3 Expanding by Rows (Columns)（tex 空节 → 按决策④从教材补全：余子式/代数余子式、Laplace 展开+证明、=== Cramer's Rule 定理+证明、=== Expanding by k Rows）
  - [x] §4 Special Determinants（tex 迁移：Vandermonde / Arrow / Two-Triangular 定义与值）
  - 备注：§1–§3 无 md 来源，内容取自三本教材标准内容；迁移踩坑记录：Typst 0.15 的 ∏ 写作 `product`（非 `prod`）、多字母标识符需引号（`"sgn"`/`"col"`）、双字母下标需 `_("ij")` 形式、Greek 字母 sigma/tau 为内置符号裸用即可
- [x] **B3 = Ch3 Matrices**（549 行 / 7 节，⚠ 含空节，拆为 3 个子批）
  - [x] B3a §1 Basic Operations + §2 Special Square Matrices（前半：对角/基本/三角/初等矩阵）✅ 2026-10-10
  - [x] B3b §2 Special Square Matrices（后半：对称/循环/幂零/满秩）+ §3 Inverse Matrix + §4 Block Matrix ✅ 2026-10-10
  - [x] B3c §5 Operations of Rank + §6 Low-Rank Corrections ✅ 2026-10-10
  - 备注：tex §1 的 Addition/Scalar Multiplication/Transpose/Multiplication 为空 leftbarTitle → 按教材补一句定义并升级为 ===；Determinant of a Product 与 Ch2 `<thm:det-product>` 重复，仅保留 k 矩阵推广（`<cor:det-product-multiple>`）并用 #link 回指；§3 逆矩阵 tex 全空 → 按教材补全（逆矩阵定义与运算性质、可逆性等价命题定理+证明、伴随矩阵与 adj 公式、求逆两法、广义逆定义）；§6 秩的运算 tex 脚注（维数公式细化 rank(A+B) 等式）内联为命题内文字；踩坑记录：\cong 在 Typst 0.15 无对应符号（矩阵等价改用 `equiv`）、`$LU$` 需引号、Cauchy-Binet 的 minors 记号用 `abs("A"(1, 2, ..., m; v_1, ..., v_m))` 表达；B3b 踩坑：\otimes/\oplus 在 Typst 0.15 无符号函数（Kronecker 积用 Unicode `⊗`，直和用 `⊕`，均实测可渲染）；Greek 字母是 Typst 内置符号（sigma/tau/lambda/alpha/beta 裸用即可，不要加引号——加引号反而渲染成文本字体）；`quad` 在数学模式不存在（用空格或分列公式）；rank 记号统一 `upright("rank")(A)`（与 Ch1 Notations 一致）
- [x] **B4 = Ch4 Linear Systems**（ch03 清洗后约 200 行 / 3 节）✅ 2026-10-10
  - [x] §1 Elimination Method（tex 空节 → 教材补全：线性方程组定义 + cases 系统、初等行变换、行阶梯形/行最简形定义、RREF 唯一性定理+sketch 证明；tex §2 Linear Space 整段留待 B5）
  - [x] §2 Rank of Vector Groups and Matrices（tex 迁移：极大无关组/向量组的秩五性质、矩阵的秩定义、行秩=列秩定理、初等变换不改变秩 + 求极大无关组方法；tex "of row vectors" 笔误修正为 column vectors）
  - [x] §3 Solution to Linear Systems（tex 迁移：基础解系定义+note、解空间维数 $n - rank(A)$、导出方程组与通解；tex 空 leftbarTitle "解的存在性判定" → 按决策④补 Rouché–Capelli 定理）
  - 备注：§2 使用 Ch5 的线性组合/线性相关概念，加 note 前向指引；augmented matrix 记号 $(A | b)$ 的竖线非绝对值，按规范保留
- [x] ✅ Part I 里程碑：编译 + 提交（B2–B4 完成）

### Part II — Linear Spaces and Linear Mappings

- [x] **B5 = Ch5 Linear Spaces**（ch03 §2 + ch05 合并）✅ 2026-10-10
  - [x] §1 Linear Spaces and Their Bases（线性空间定义+8公理、例、线性组合/表示/等价、线性相关/无关、性质命题+证明、维数/基/坐标）
  - [x] §2 Subspaces（子空间定义+判定、Span、交与和、维数公式、直和定义+充要条件）
  - [x] §3 Isomorphisms（同构定义、同构定理+证明、有限维分类推论、性质）
  - [x] §4 Quotient Spaces（商空间定义、商空间维数定理+证明、诱导映射、第一同构定理）
  - [x] §5 Special Linear Spaces（交换空间 C(A) 定义+性质+例题，从 chap05.tex 迁移）
  - 备注：§1–§2 核心内容来自 chap03.tex §2 Linear Space + chap05.tex 合并；§3–§4 原 tex 为空节，按决策④从教材补全；§5 从 chap05.tex 迁移；踩坑记录：双字符下标需引号（a_("i1")）、langle/rangle 需引号、mat() 替代 pmatrix、\quad 在数学模式中不可用需用空格替代
- [x] **B6 = Ch6 Linear Mappings**（388 行 / 5 节）✅ 2026-10-10
  - [x] §1 Linear Mappings and Their Computation（线性映射定义、存在唯一性定理/线性延拓、加法/数乘/复合运算、代数定义）
  - [x] §2 Kernel and Image of Linear Mappings（核与像定义、秩-零度定理、余核、升链定义+性质）
  - [x] §3 Matrix Representation of Linear Mappings（矩阵表示定义、基变换与坐标变换、相似矩阵、例题）
  - [x] §4 Special Linear Transformations（常见变换、幂等变换与投影变换定义+命题、对合/可逆等价命题）
  - [x] §5 Linear Functions and Dual Spaces（线性函数、对偶空间、对偶基、维数定理+证明、双重对偶）
  - 备注：§1–§4 从 chap06.tex 迁移；§5 原 tex 为空节，按决策④从教材补全；踩坑记录：\quad 在数学模式中不可用需用空格替代、dots.d 应为 dots.down、subseteq 需加引号 "subseteq"、双字符下标需引号（delta_("ij")）
- [x] ✅ Part II 里程碑：编译 + 提交（B5–B6 完成）

### Part III — Structure Theory of Linear Operators

- [x] **B7 = Ch7 Diagonalization**（685 行 / 7 节，拆为 3 个子批）✅ 2026-10-10
  - [x] **B7a** §1 Similarity + §2 Eigenvectors and Eigenvalues ✅ 2026-10-10
  - [x] §1 Similarity of Matrices（相似定义、迹定义、迹运算性质、相似运算性质、相似不变量 note）
  - [x] §2 Eigenvectors and Eigenvalues（特征值/特征向量定义、矩阵函数特征值性质、特征多项式定义+性质、重数与特征子空间、Gerschgorin 圆盘定理两定理）
  - [x] **B7b** §3 Minimal Polynomial + §4 Space Decomposition ✅ 2026-10-10
  - [x] §3 Minimal Polynomial（零化多项式、极小多项式定义）
  - [x] §4 Space Decomposition（不变子空间定义+性质、一维不变子空间命题、块上三角/块对角表示定理、互素多项式核分解命题、Hamilton-Cayley 定理、根子空间定义+根空间分解定理）
  - [x] **B7c** §5 Diagonalization + §6 Diagonalization of Special Matrices + §7 Simultaneous Characteristics ✅ 2026-10-10
  - [x] §5 Diagonalization（特征向量线性无关引理、对角化等价条件定理）
  - [x] §6 Diagonalization of Special Matrices（可逆/幂等/幂零/对合/全1/循环移位/循环/三角矩阵的对角化性质）
  - [x] §7 Simultaneous Characteristics（特征空间互为不变子空间、公共特征向量、同时上三角化、同时对角化、多种情形推广）
  - 备注：§1–§7 从 chap07.tex 迁移；踩坑记录：双字符下标需引号（alpha_("i1"), alpha_("ij"), delta_("ij"), alpha_("ir"_i)）、langle/rangle 需引号、dots.d 应为 dots.down、\quad 在数学模式中不可用需用空格替代
- [x] **B8 = Ch8 Jordan Canonical Form**（382 行 / 5 节）✅ 2026-10-10
  - [x] §1 Polynomial Matrices（多项式矩阵定义、可逆性 caution、等价多项式矩阵、Smith 标准型）
  - [x] §2 Invariant Divisors and Rational Canonical Form（行列式因子、不变因子、伴随矩阵、Frobenius 标准型、循环子空间定义+性质+命题+几何解释）
  - [x] §3 Elementary Divisors and Jordan Canonical Form（初等因子定义、幂零 Jordan 形式引理、Jordan 标准型存在性定理+几何解释）
  - [x] §4 Finding Jordan Canonical Form and Transition Matrices（求标准型与过渡矩阵的方法说明）
  - [x] §5 Complete Set of Invariant Quantities for Matrix Similarity（完全相似不变量定理+note）
  - 备注：§1–§5 从 chap08.tex 迁移；踩坑记录：双字符下标需引号（p_("i1"), k_("ij"), p_("is"_i)）、langle/rangle/bigoplus 需引号、\quad 在数学模式中不可用需移除、批量替换 langle/rangle 破坏了已有引号需修复双重引号
- [x] ✅ Part III 里程碑：编译 + 提交（B7–B8 完成）

### Part IV — Quadratic Forms and Inner Product Spaces

- [x] **B9 = Ch9 Quadratic Forms**（69 行 / 3 节）✅ 2026-10-10
  - [x] §1 Quadratic Forms and Their Standard Forms（二次型定义、矩阵表示、对称矩阵 note、合同变换、配方法与初等变换法 note）
  - [x] §2 Canonical Forms（复二次型规范形、实二次型惯性定理+note、符号差）
  - [x] §3 Definite Quadratic Forms（正定定义、半正定/负定/不定定义、正定充要条件定理）
  - 备注：§1+§3 从 chap09.tex 迁移；§2 原 tex 为空节，按决策④从教材补全
- [x] **B10 = Ch10 Inner Product Spaces**（568 行 / 8 节，拆为 2 个子批）✅ 2026-10-10
  - [x] B10a §1 Bilinear Forms + §2 Real Inner Product Spaces + §3 Metric Matrices and Orthonormal Bases
  - [x] B10b §4 Orthogonal Completion + §5 Orthogonal and Symmetric Transformations + §6 Unitary Spaces + §7 Symplectic Spaces
  - 备注：§1–§7 从 chap10.tex 迁移；§4–§5 含例题解答（对称矩阵特征向量+全1矩阵特征值）；踩坑记录：||...|| 范数记号在 Typst 中需用 "lVert"/"rVert"、conjugate 需加引号、\quad 在数学模式中不可用、langle/rangle 需引号
- [x] ✅ Part IV 里程碑：编译 + 提交（B9–B10 完成）

### 收尾

- [x] Glossary 重建（用 `violet-glossary-indexer`）✅ 2026-10-10
- [x] 全书终检：编译通过（exit 0）、TODO 计数 0、168 个唯一标签完整 ✅ 2026-10-10
- [ ] 死文件清理（`tmp/` 目录的旧 PDF 可删除；`chapters/` 目录按 REFRACTOR §1 约定保留作为存档）

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

---

## 6. 遗漏内容分析（对照 docs/线性代数.md）

> 分析日期：2026-10-11
> 参考文档：[`线性代数.md`](./线性代数.md)（3710 行，41 个 `##`/`###` 标题）
> 对照目标：`initial.typ`（3089 行，5 Part / 10 章 + Glossary）

### 6.1 结构性遗漏（参考文档有独立章节，Typst 笔记完全缺失）

| 编号 | 参考文档位置 | 遗漏内容 | 建议处理 |
|------|-------------|---------|---------|
| S1 | L3432–3445 | **实内积空间的同构**：保距同构（isometry）定义 + 同构本质特征定理（两个 Euclid 空间同构 ⟺ 维数相同） | 在 Inner Product Spaces 章新增 `=== Isomorphism of Real Inner Product Spaces` |
| S2 | L3540–3596 | **正交变换**：定义（保持内积的满射）、性质（线性、单射、逆与乘积、四个等价条件）、行列式 ±1、第一类/第二类正交变换、实正交阵正交对角化定理（含旋转块标准型） | 在现有 "Orthogonal Transformations and Symmetric Transformations" section 前补 `=== Orthogonal Transformations` |
| S3 | L3665–3679 | **反对称变换**（skew-symmetric transformation）：定义、性质（线性、$(\mathcal{A}\alpha,\alpha)=0$、$\mathcal{A}\pm\mathcal{I}$ 可逆）、斜对称阵正交对角化定理 | 新增 `=== Skew-Symmetric Transformations` |
| S4 | L3468–3538 | **最小二乘法**：垂线段最短定理、最佳逼近元定义、最小二乘问题定义、正规方程 $(A^TA)x=A^T\beta$ | 在 Orthogonal Completion and Orthogonal Projection section 下补 `=== Least Squares Method` |
| S5 | L3706–3710 | **参考资料**：4 本教材的完整引用信息 | 确认 `references.bib` 已收录；在文末补充 `#bibliography` |

### 6.2 内容性遗漏（章节存在但内容不完整）

| 编号 | Typst 位置 | 遗漏内容 | 严重度 |
|------|-----------|---------|--------|
| C1 | § Diagonalization (L2077) | 可对角化充要条件缺少 **Jordan 标准形角度**：Jordan 块均一阶、初等因子均一次、不变因子无重根（参考 L2877–2882） | 🟠 |
| C2 | § Orthogonal Completion (L2727) | 正交补性质缺少：**包含关系性质** $V_1 \subset V_2 \Rightarrow V_1^\perp \supset V_2^\perp$（参考 L3466） | 🟡 |
| C3 | § Orthogonal Completion (L2727) | 正交补性质缺少：**等价定义** $V_1 \perp V_2$ 且 $V_1 + V_2 = V$（参考 L3461） | 🟡 |
| C4 | § Existence of Solutions (L963) | 缺少 **Gauss-Jordan 算法流程图**（三种解的情况判定）和齐次方程组推论 $r < n \Rightarrow$ 非零解（参考 L392–413） | 🟡 |
| C5 | § Homogeneous Systems (L972) | 基础解系定理缺少**完整证明**（参考 L677–697，Typst 仅有定义和 note） | 🟡 |
| C6 | § Real Inner Product Spaces (L2608) | 缺少 **Euclid 空间的同构** 定理（参考 L3443–3444） | 🔴（与 S1 相关） |
| C7 | § Orthogonal Transformations (L2754) | 现有 section 标题含 "Orthogonal Transformations" 但**实际只定义了 Symmetric Transformation**，完全没有讨论正交变换本身 | 🔴 |

### 6.3 Typst 笔记超出参考文档的内容

| 内容 | Typst 位置 | 说明 |
|------|-----------|------|
| Low-Rank Corrections (Sherman-Morrison, Woodbury) | § Matrices (L753) | 参考文档无 |
| Special Linear Spaces (Commutative spaces) | § Linear Spaces (L1370) | 参考文档无 |
| Simultaneous Characteristics | § Diagonalization (L2182) | 参考文档无 |
| Ascending Chain of Subspaces | § Linear Mappings (L1516) | 参考文档无 |
| Gerschgorin Disk Theorem | § Diagonalization (L1904) | 参考文档无 |
| Geometric Interpretation (Rational Canonical Form) | § Jordan (L2345) | 参考文档无 |
| Complete Set of Invariant Quantities | § Jordan (L2453) | 参考文档有类似内容但组织不同 |
| Symplectic Spaces（有完整内容） | § Inner Product Spaces (L2846) | 参考文档辛空间为空节（L3700–3703） |
| Unitary Spaces and Normal Transformations（有完整内容） | § Inner Product Spaces (L2786) | 参考文档酉空间与酉变换为空节（L3697–3699） |

### 6.4 章节映射对照表

| 参考文档章节 | 参考文档行号 | Typst 对应位置 | 状态 |
|-------------|-------------|---------------|------|
| 排列 | L4 | § Permutations (L66) | ✅ |
| 行列式及其性质 | L33 | § Determinant and Its Properties (L94) | ✅ |
| 行列式按一行(列)展开 | L157 | § Expanding by Rows and Columns (L136) | ✅ |
| Cramer法则 | L201 | === Cramer's Rule (L169) | ✅ |
| 行列式按k行(列)展开 | L220 | === Expanding by k Rows (L195) | ✅ |
| 特殊行列式 | L240 | § Special Determinants (L210) | ✅ |
| 用消元法研究线性方程组 | L338 | § Elimination Method (L838) | ✅ |
| 向量代数 | L435 | § Linear Spaces and Their Bases (L1045) | ✅（内容分散到 Ch5） |
| 用矩阵研究线性方程组 | L524 | § Rank of Vector Groups + § Solution to Linear Systems | ✅ |
| 基本运算 | L769 | § Basic Operations (L303) | ✅ |
| 特殊矩阵 | L952 | § Special Square Matrices (L378) | ✅ |
| 特殊运算 | L1076 | 分散在 Inverse Matrix + Block Matrix + Operations of Rank | ✅ |
| 数域P上的线性空间 | L1320 | § Linear Spaces and Their Bases (L1045) | ✅ |
| 子空间 | L1474 | § Subspaces (L1215) | ✅ |
| 同构 | L1671 | § Isomorphisms (L1284) | ✅ |
| 商空间 | L1758 | § Quotient Spaces (L1324) | ✅ |
| 线性映射及其计算 | L1762 | § Linear Mappings and Their Computation (L1402) | ✅ |
| 线性映射的核与像 | L1947 | § Kernel and Image (L1472) | ✅ |
| 线性映射的矩阵表示 | L2098 | § Matrix Representation (L1550) | ✅ |
| 线性函数与对偶空间 | L2253 | § Linear Functions and Dual Spaces (L1690) | ✅ |
| 矩阵的相似 | L2268 | § Similarity of Matrices (L1743) | ✅ |
| 特征向量与对角化 | L2294 | § Eigenvectors and Eigenvalues (L1806) | ✅ |
| 空间分解与对角化 | L2563 | § Space Decomposition (L1945) | ✅ |
| 最小多项式与对角化 | L2763 | § Minimal Polynomial (L1933) | ✅ |
| 多项式矩阵 | L2781 | § Polynomial Matrices (L2220) | ✅ |
| 不变因子 | L2819 | === Invariant Divisors (L2283) | ✅ |
| 有理标准型 | L2838 | === Rational Canonical Form (L2308) | ✅ |
| 初等因子 | L2852 | § Elementary Divisors and Jordan Canonical Form (L2385) | ✅ |
| Jordan标准形 | L2864 | § Finding Jordan Canonical Form (L2434) + § Complete Set of Invariant Quantities (L2453) | ✅ |
| 二次型及其标准型 | L2896 | § Quadratic Forms and Their Standard Forms (L2485) | ✅ |
| 规范型 | L3045 | § Canonical Forms (L2518) | ✅ |
| 正定二次型 | L3110 | § Definite Quadratic Forms (L2552) | ✅ |
| 双线性函数 | L3295 | § Bilinear Forms (L2589) | ✅ |
| 实内积空间 | L3307 | § Real Inner Product Spaces (L2608) | ✅ |
| 度量矩阵与标准正交基 | L3352 | § Metric Matrices and Orthonormal Bases (L2649) | ✅ |
| **实内积空间的同构** | **L3432** | § Isomorphism of Real Inner Product Spaces (L2715) | ✅ **已补全** |
| 正交补与正交投影 | L3446 | § Orthogonal Completion and Orthogonal Projection (L2715) | ✅ **已补全（含最小二乘法）** |
| 正交变换与对称变换 | L3539 | § Orthogonal Transformations and Symmetric Transformations (L2754) | ✅ **已补全（含正交变换+反对称变换）** |
| **反对称变换** | **L3665** | === Skew-Symmetric Transformations | ✅ **已补全** |
| 酉空间与酉变换 | L3697 | § Unitary Spaces and Normal Transformations (L2786) | ✅（Typst 内容更丰富） |
| 辛空间 | L3700 | § Symplectic Spaces (L2846) | ✅（Typst 内容更丰富） |
| 参考资料 | L3706 | #bibliography("references.bib") (L3238) | ✅ **已确认** |

### 6.5 优先级建议

| 优先级 | 编号 | 理由 |
|--------|------|------|
| P0 🔴 | S2, C7 | 现有 section 标题承诺覆盖正交变换但实际缺失，影响章节完整性 |
| P1 🟠 | S1, S3, C1 | 独立章节缺失或重要定理角度不全 |
| P2 🟡 | S4, C2, C3, C4, C5 | 重要但非核心；可在后续批次中补全 |
| P3 🟢 | S5 | 确认 references.bib 已收录即可 |
