---
name: violet-typst-writing-conventions
description: 当编辑/创建 .typ 文件时，必须使用本技能以确保符合 Typst 语法规范（如 subset→subset.eq, \sigma→sigma, integral→integral 等）、符号映射规则、文档层级结构和写作风格约定。尤其适用于新增数学公式较多的笔记时。
user_invocable: false
---

> **符号与陷阱按家族拆分到 `fields/` 目录。** 主文件只保留通用硬规则与符号路由表。写某一科笔记前，按 [fields/README.md](fields/README.md) 的「科目 → 建议加载组合」加载对应 family 文件：
>
> - **始终加载** [fields/general.md](fields/general.md)（下标、多字母变量、分数、`abs()`、`cases()`、字体、LaTeX 残留扫描等一切通用硬规则）
> - 关系符号（`∈`、`subset`、`!=`、`<=`、`≈` 等）→ [fields/relations.md](fields/relations.md)
> - 箭头（`->`、`=>`、`\mapsto`、`xarrow` 等）→ [fields/arrows.md](fields/arrows.md)
> - 集合与逻辑（`union`、`inter`、`forall`、集合描述等）→ [fields/sets-logic.md](fields/sets-logic.md)
> - 微积分（`integral`、`partial`、`dif`、`oo`、`limsup` 等）→ [fields/calculus.md](fields/calculus.md)
> - 矩阵对象（`mat()`、行列式、范数、内积、`†⊕⊗⊥` 等）→ [fields/linear-algebra.md](fields/linear-algebra.md)

## 1. 文档结构

### 层级体系

| 语法 | 层级 | 含义 |
|------|------|------|
| `#part("...")` | Part | 大知识模块分组 |
| `= ...` | Chapter（一级标题） | 完整知识单元 |
| `== ...` | Section（二级标题） | 章内主要知识点 |
| `=== ...` | Subsection（三级标题） | 节内细分 |

### 标题规则

- 标题标记 `=` 后必须有空格：`= Title`（正确）vs `=Title`（错误）
- 不要跳级使用标题（如从 `=` 直接到 `===`）

---

## 2. 文本格式

| 效果 | 语法 |
|------|------|
| 加粗 | `*text*` |
| 斜体 | `_text_` |
| 行内代码 | `` `code` `` |
| 脚注 | `#footnote[...]` |
| 垂直间距 | `#v(1cm)` |
| 行内高亮 | `#highlight[text]` |

### 列表

- 无序列表：`- item`
- 有序列表：`1. item` / `2. item`
- 嵌套：使用缩进（Tab 或两空格）

---

## 3. 数学公式

### 基本用法

- 行内公式：`$ ... $`（与文本同行）
- 行间公式（display math）：`$ ... $`（单独成段，前后有空行或换行）

### 3.1 符号路由（负载哪个 family 文件）

写数学公式前，必须先加载 [fields/general.md](fields/general.md) 及本公式涉及家族的 field 文件：

| 你想写的符号 | 加载文件 |
|-------------|---------|
| 下标、多字母变量、分数、`abs()`、`root()`、`cases()`、`±`/`·`/`∘`、字体（`bb`/`cal`/`text`） | [fields/general.md](fields/general.md) |
| `∈` `⊂` `≠` `≤` `≥` `~` `≈` `≡` `∝` `<<` `>>` | [fields/relations.md](fields/relations.md) |
| `->` `=>` `<=>` `\|->` `↝` `xarrow` | [fields/arrows.md](fields/arrows.md) |
| `union` `inter` `emptyset` `forall` `exists` `and` `or`、集合描述 | [fields/sets-logic.md](fields/sets-logic.md) |
| `integral` `partial` `dif` `nabla` `oo` `limsup` `sup` `inf`、积分记号 | [fields/calculus.md](fields/calculus.md) |
| `mat()` 矩阵、行列式、范数 `\|\|`、内积、`†` `⊕` `⊗` `⊥` | [fields/linear-algebra.md](fields/linear-algebra.md) |

### 3.2 通用硬规则（主文件内摘要，详见 general.md）

1. **下标后紧接括号必须用 `{}` 包裹**：`mu_(X)(B)`，**绝对禁止** `mu_X(B)`。写完带下标+括号的公式必须用正则 `_([a-zA-Z])\(` 自查，命中数为 0 前不得提交。这是全仓库最高频错误（详见 general.md §3）。
2. **多字母变量**：正体用引号 `"ext"`，斜体用空格 `e x t`；相邻单字母间留空格 `$x y$`。
3. **分数/分子非单因子加括号**：`$(x + y) / 2$`；`abs(...)` 可作为整体因子。
4. **绝对值用 `abs(xxx)`**，不用 `|xxx|`；**行列式绝不能用 `abs()`**（用 `"det"(A)` 或 `mat(delim: "|", ...)`，见 linear-algebra.md）。
5. **`n` 次方根用 `root(n, x)`**，不用 `sqrt(x, n)` 二参形式。
6. **`text()` 必须用字符串**：`text("...")`。
7. **`cases()` 裸逗号是分行符**，值与条件用 `quad &` 对齐（详见 general.md §11）。
8. **标点写在数学环境内部**；display math 保持原样。
9. **`\left(`/`\right)` 不存在**；Typst 自动缩放，长竖线用 `lr(...)`。
10. **不保留 LaTeX 宏**：`int`→`integral`、`cdot`→`dot`、`times`→`times`、`sim`→`~`，`pm`→`±`。

### 3.3 LaTeX 宏残留扫描

编辑/迁移后扫描以下残留（详见 general.md §13）：`\$\`、`\bmod/\pmod/\mod`、`\pm`（应改 `±`）、`\cdot`、`\times`、`\circ`、`\int`。遇到 `unknown variable` 优先查多字母连写（`xy`）与宏残留（`cdot`/`int`/`infty`）。

> 行列式、矩阵、范数、`†⊕⊗⊥` 等写法**必须**查 linear-algebra.md，不要臆测。

---

## 4. 标签与交叉引用

### 标签命名规范

| 类型 | 前缀 | 示例 |
|------|------|------|
| 图片 | `fig:` | `<fig:example>` |
| 定理 | `thm:` | `<thm:mvt>` |
| 定义 | `def:` | `<def:continuous>` |
| 章节 | `sec:` | `<sec:intro>` |

### 引用方式

- 图片引用：`@fig:example`
- 自定义组件引用：`#link(<label>)[显示文本]`

> **注意**：`#theorem` / `#definition` / `#corollary` 等模板组件内部包裹了 `context`，
> 其标签**不能用 `@` 语法引用**（会报错 `cannot reference context`），
> 必须使用 `#link(<label>)[显示文本]`。

```typst
#definition(name: "Continuous Function")[
  A function $f: X -> Y$ is continuous if...
] <def:continuous>

Later, we refer to *#link(<def:continuous>)[Continuous Function]*.
```

**标签必须写在组件 body 闭合 `]` 之后**，不能夹在组件参数与 body 之间，否则报 `missing argument: body`：

```typst
// 错误 — 标签夹在组件参数与 body 之间
#definition(name: "Complex Function") <def:complex-function>[
  ...
]

// 正确 — 标签紧跟 body 闭合括号之后
#definition(name: "Complex Function")[
  ...
] <def:complex-function>
```

同理，编号公式的标签也写在 `#eq(...)` 的 body 之后：`#eq[$ ... $] <eq:label>`。

---

## 5. 图片

图片统一使用 **SVG**（矢量格式：缩放无损、体积小、线框类数学插图最清晰）。Typst 的 `image()` 原生支持 SVG；PNG/JPG 仍可用作后备（如只能获得位图来源时）。

```typst
#figure(
  image("img/example.svg", width: 60%),
  caption: [This is an example figure.],
  placement: auto,
  supplement: [Fig.]
) <fig:example>
```

- 图片文件放在 `img/` 目录下
- 使用相对路径引用
- SVG 注意事项：保持文件自包含（无外部引用）；Typst 通过 usvg 渲染，SVG 内的文本会被转为路径，不支持滤镜与动画

### 图片生成工作流（scripts + uv）

需要新图片时，不要让图片阻塞写作，按以下流程处理：

1. **先写引用**：在 `.typ` 中直接写好 `#figure(image("./img/xxx.svg", ...))` 与 `<fig:xxx>` 标签，保持文档结构完整
2. **创建占位文件**：将仓库根目录的 `0.Wiki/null.svg`（空白占位图）复制到目标 `img/` 目录，并改名为实际图片名（如 `img/xxx.svg`）。占位图是有效 SVG，期间 `typst compile` 仍可通过
3. **写 Python 脚本**：在对应主题目录下新建 `scripts/<图片名>.py`（matplotlib，一图一脚本），脚本将 SVG 输出到主题目录的 `img/<图片名>.svg`，文件名与 `<fig:xxx>` 标签对应。结构与规范见 violet-make-outline 技能的 `ref/image-planning.md` §2
4. **生成图片**：在仓库根目录执行 `uv run "<subject>/scripts/<图片名>.py"`（依赖由仓库根 `pyproject.toml` 统一管理，已含 matplotlib）。生成 PNG 预览人工核验无重叠/越界后替换占位文件
5. **编译验证**：全部真实图片就位后，重新 `typst compile` 确认通过。注意 `img/` 已被 .gitignore 忽略，提交时只含脚本与 `.typ`，不含生成的图片

---

## 6. 表格

### 重要规则

表格单元格中如果包含数学公式，**必须使用中括号 `[...]` 包裹**，不能使用引号 `"..."`。

```typst
// 正确：数学公式用中括号
#tex-table(
  ("Translational", "Rotational"),
  ([Position $x$], [Angle $theta$]),
  ([Velocity $v = dot(x)$], [Angular velocity $omega = dot(theta)$]),
)

// 错误：引号内数学公式不会渲染
#tex-table(
  ("Translational", "Rotational"),
  ("Position $x$", "Angle $theta$"),
)
```

纯文本单元格可以使用引号。

---

## 7. 文献引用

- 正文引用：`@citation_key`
- 脚注：`#footnote[...]`
- 参考文献列表放在文件末尾：`#bibliography("references.bib")`

---

## 8. 公式编号

默认公式不编号。需要编号时使用模板提供的 `#eq()` 包装器：

```typst
#eq[$
  E = m c^2
$]
```

编号格式为 `(章号.公式序号)`，如 `(1.1)`。

> 收敛箭头（xarrow 包）、积分记号惯例等记号写法已移至 [fields/arrows.md](fields/arrows.md) §3 与 [fields/calculus.md](fields/calculus.md) §3.2。

---

## 9. 写作风格规范

### 内容职责原则（SRP）

每个笔记文件/章节只负责自己领域的内容，不重复其他笔记已有的定义和定理：

- **不要重复定义**：如果某个概念（如 Riemann 积分的定义）已在其他笔记中给出（如《Analyse Mathématique》），本笔记只需简要提及并引用，不要重新定义
- **不要重复定理**：如果某个定理（如 Lebesgue 判据）已在另一门课的笔记中证明过，这里只需陈述结论并注明出处，或用 `#note` 提示读者参阅
- **聚焦本章视角**：同一个定理在不同笔记中出现时，应从本章的视角重新阐述其意义，而非照搬原始证明
- **交叉引用优先**：用 `#link` 或正文说明指向已有内容，避免信息冗余

示例：在实分析笔记的"与 Riemann 积分的关系"一节中：
- ✗ 重新定义 Riemann 积分（数学分析笔记已有）
- ✗ 重新证明 Lebesgue 判据（数学分析笔记已有）
- ✓ 直接陈述 Lebesgue 判据的结论，注明"此定理的证明见数学分析笔记"
- ✓ 聚焦于 Riemann 可积与 Lebesgue 可积的关系、反常积分的对比等本章独有内容

### 语言与术语

- 正文使用英文，**正文中不得出现中文**（包括中文括号内的翻译、中文术语、中文解释）
- 中文仅能出现在 `//` 注释中：`== Section Title // 中文标题`
- **标题双语**：英文在前，中文注释在后，如 `= Lebesgue Measure // 勒贝格测度`（或括号形式 `// Lebesgue Measure (勒贝格测度)`）；章、节、组件标题同此规则
- 组件 `name` 参数使用英文
- 数学术语使用学科通用英文表述

### 排版与可读性

以下三条为强约束，写任何笔记时都要遵守（用户明确要求的写作习惯）：

1. **一整句话占一行**。每个句子（或每个子句级单位）独占一行，不要在一行里连写多句话。原因：Typst 编辑器对 `.typ` 文件不会自动换行，长行会横向溢出、难以阅读；每句一行让 diff、跳转、引用行号都更清晰。同一句内折行（如一个长段落跨多行）要避免——一行一个语义单元。
2. **勤分段**。逻辑上能独立成段的内容就另起一段（空一行分隔），不要在段落间把不同论点揉在一起。一段只讲一件事：陈述、理由、推论、示例各占独立段落。
3. **善于使用结构化组件**。凡是"并列条目、分类、流程步骤、对比、映射关系"等有结构的内容，优先用列表（`-` / `1.`）、表格（`#tex-table`）、组件（`#note` / `#caution`）等结构化形式表达，而不是写成一大段连续文字。判据：能拆成条目就不用流水句；能对照就不用排比句。

示例（推荐写法）：

```typst
Symmetry shortcuts. Before any computation, check the following three devices.

- *Odd/even symmetry.* If $D$ is symmetric about the $y$-axis and $f$ is odd in $x$, then $integral.double_D f = 0$.
- *Cyclic symmetry.* If $D$ is symmetric about the line $y = x$, then $integral.double_D f(x, y) = integral.double_D f(y, x)$.
- *Centroid formula.* For a region $D$ with area $S_D$, $integral.double_D x = bar(x) S_D$.
```

而不是把三条对称性技巧揉成一个长段落。

### 证明写作

- 证明步骤之间用空行分隔，保持逻辑段落清晰
- 长证明使用 `*Step N*:` 标记关键步骤
- 证明结束由 `#proof` 组件自动添加 ■ 符号，不需要手动写 QED

### 内容组织模式

典型的定理/定律展开模式（按需选用）：

```
#theorem / #law(name: "...")[...]
#proof[...]
#corollary[...]          // 直接推论
#example[...]            // 说明性例子或反例
#note[...]               // 对比、适用条件说明
```

- 物理定律用 `#law`，数学定理用 `#theorem`
- `#proof` 可用于两者之后

### 组件块内容约束（definition / example）

**`#definition` 块内只放准确定义**，不得混入解释、理由、例子、直观说明或"为什么这样要求"。所有补充说明一律移出定义块，写成紧随其后的普通段落：

```typst
// 错误 — 定义块内夹带大量解释
#definition(name: "General and Special Linear Groups")[
  Let $F$ be a field. The *general linear group* $"GL"_(n)(F)$ is the
  set of invertible $n times n$ matrices over $F$ under matrix
  multiplication: the product of invertible matrices is invertible, matrix
  multiplication is associative, the identity matrix $I$ is neutral, and
  every invertible matrix has its inverse — the axioms are exactly linear
  algebra. ...
] <def:general-linear-group>

// 正确 — 定义块只留纯定义，解释放块外
#definition(name: "General and Special Linear Groups")[
  Let $F$ be a field. The *general linear group* $"GL"_(n)(F)$ is the set
  of invertible $n times n$ matrices over $F$ under matrix multiplication.
] <def:general-linear-group>

$"GL"_(n)(F)$ is indeed a group: the four axioms are exactly the defining
properties of an invertible matrix ...（理由、例子、非可交换说明等都放这里）
```

凡是"这道公理在说什么""为什么这样建""这个结构把哪些公理用上了"一类的话，都不属于定义本身，应放在定义块之后的正文中。

**`#example` 的标题用 `name:` 参数**，写在方块标题位置，**不要**在正文第一行写 `(Title.)` 前缀：

```typst
// 错误 — 标题写在正文里
#example[
  (The quaternion group.) Let $Q_8 = ...$
]

// 正确 — 标题进 name 字段，正文只留内容（除非该例确实没有标题）
#example(name: "The quaternion group.")[
  Let $Q_8 = ...$
]
```

标题含数学符号（如 `Cosets in $S_3$`、`Groups of order $p q$`）时直接在 `name` 字符串里写 `$...$`，模板会自动渲染。只有真正没有标题的 example 才省略 `name:`。

### 组件选择指南

> 组件的 API、参数（`name:`/`body`）与编号规则见 `violet-template-usage` §6–§7；本节只规定**何时用/不用**与内容约束。

组件不能滥用。参考项目现有内容的分工：

| 组件 | 用途 | 何时使用 | 何时不用 |
|------|------|---------|---------|
| `#definition` | 定义核心概念 | 引入新术语/新量时（电场强度、电流密度、通量） | 仅仅是列举属性或计算步骤时不用 |
| `#law` | 物理定律（实验或简单推理得出） | 库仑定律、欧姆定律、焦耳定律、基尔霍夫定律、安培定律 | 纯数学定理不用 |
| `#theorem` | 数学定理或推论（经严格证明的命题） | 唯一性定理、叠加原理、矢势的泊松方程 | 物理定律不用 |
| `#property` | 一组相关性质的枚举 | 只有**确实在列举一组属性**时用（如"电力线的性质"） | 单一公式、单一解释、计算过程不用 |
| `#example` | 带计算的工作示例 | 演示定律的应用、对称性计算 | 纯文字说明不用 |
| `#note` | 补充说明、对比、洞察 | 概念对比、适用条件、与其他定理的关系 | 核心内容不应放进 note |
| `#proof` | 定理或定律的推导证明 | 紧跟在 `#theorem` / `#law` 之后 | 没有明确陈述时不用单独使用 |
| `#caution` | 易错点或警告 | 需要强调不能忽略的条件 | 日常说明不用 |

**两个常见误区：**
- 不要把 `#property` 当作"包装任何非定理内容"的万能工具 — 很多内容直接写成普通段落即可
- 不是每个概念都需要用组件包裹：SI 单位说明、常数值、过渡段、列表列举等，直接写纯文本

参考写法对比：

```typst
// ✓ 正确：核心定义用 #definition
#definition(name: "Current Density")[
  The *current density* $bold(J)$ is defined as $bold(J) = n q bold(v)$.
]

// ✓ 正确：过渡段直接写纯文本
The SI unit of the electric field is newtons per coulomb ($"N/C"$).

// ✓ 正确：分类列举直接写列表（不用 #property）
- *Volume current density* $bold(J)$
- *Surface current density* $bold(K)$
- *Line current* $I$

// ✓ 正确：property 只用于确实在列举属性时
#property(name: "Properties of Electric Field Lines")[
  - They originate from positive charges and terminate on negative charges.
  - They never cross each other.
]

// ✗ 错误：将 #property 当作通用包装器
#property(name: "Joule Heating")[  // ← 不应使用 property
  The power density is $p = bold(J) dot bold(E)$.
]
// 应改为：
#law(name: "Joule Heating")[  // ← 物理定律用 law
  The power density is $p = bold(J) dot bold(E)$.
]
// 或者直接写纯文本段落：
The power dissipated per unit volume is $p = bold(J) dot bold(E)$.
```

### 注释的使用场景

- `#note`：概念对比、适用条件说明、与其他定理的关系
- `#caution`：容易出错的地方、条件不能省略的警告
- `#example`：反例（说明条件不可去掉）、典型应用

> 集合描述、`L^p` 空间等记号写法已移至 [fields/sets-logic.md](fields/sets-logic.md) §3 与 [fields/calculus.md](fields/calculus.md) §6。

---

## 9.7 编辑既有内容：一致性原则

编辑既有 Typst 笔记时，除语法规范外还必须遵守以下一致性原则：

### 符号一致性（最高优先级）

文档中已有的符号体系必须完全保留，不得更改。案例：`Analyse Réelle/initial.typ` 中全集 `$S$`、集类 `$cal(S)$`、元素 `$A, B, A_i$` 在全文广泛使用——不得改写为 `$X$`/`$cal(R)$`/`$E$`。编辑前先搜索该符号的全部使用位置，确认交叉引用依赖后再动手。

### 格式风格一致性

保留原有的排版格式与写作习惯：`+` 列表、`//` 中文注释、`Obviously, ...` 句式、缩进与标点。

### 扩展而非重写

用户要求修改时通常是扩展或修正，不是重写：保留原有定义的核心结构，在适当位置插入新内容，不改动已写好的部分。

### 上下文检查清单

1. 搜索文档中该符号的所有使用位置
2. 确认符号在后续定义、定理中的引用
3. 检查是否有交叉引用依赖该符号
4. 确保修改不破坏文档的逻辑连贯性

### 用户意图理解

- "把这里修改为'环与代数'…"——扩展定义，不是重写
- "语言风格、符号等等不要大改"——保持原有风格
- "模仿现在的风格"——学习现有文档的写作模式

### 错误纠正

发现错误时：立即承认不辩解 → 分析原因（符号变更、风格不一致）→ 正确修正 → 将教训记录到本技能。

> 下标吞括号规则见 general.md §3 三维基准小节，此处不重复——任何编辑任务写完带下标+括号的公式必须执行该正则自查，命中数为 0 前禁止声明完成。

---

## 9.8 编译验证

每次修改 `.typ` 文件后必须编译验证。

### 编译命令

```bash
typst compile "<path-to-initial.typ>" "<output-pdf-path>" --root .
```

- `--root .` 必须指定（模板在仓库根 `TypstTemplate/` 下，需允许跨目录访问）
- 工作目录必须是仓库根目录
- 始终编译 `initial.typ` 主入口（单文件原则，不再使用 `chapters/` 分文件模式）

### 输出路径规则

PDF 输出到 `initial.typ` 同级目录，文件名 `initial.pdf`：

```
Subject/
  initial.typ      ← 编译入口
  initial.pdf      ← 输出 PDF（同级）
  references.bib
  img/
```

**不要将 PDF 输出到 `tmp/` 目录**（旧约定已废弃）。

### 编译示例

```bash
# 在仓库根目录执行
typst compile "1.Analyse/Analyse Réelle/initial.typ" "1.Analyse/Analyse Réelle/initial.pdf" --root .
typst compile "1.Analyse/Analyse Complexe/initial.typ" "1.Analyse/Analyse Complexe/initial.pdf" --root .
```

### 常见编译错误

| 错误信息 | 原因 | 解决方案 |
|----------|------|----------|
| `cannot read file outside of project root` | 缺少 `--root .` | 添加 `--root .` 参数 |
| `unknown variable` | 多字母变量未加引号 | 用 `"var"` 包裹或空格分开 |
| `expected expression` | 裸下标 `$_x$` | 改为 `$""_x$` |
| `unexpected token` | 语法错误（括号不匹配等） | 检查 `[...]` 和 `(...)` 配对 |
| `file not found` | `#import` 路径错误 | 检查相对路径层级 |
| `failed to write PDF file` | 输出目录不存在 | 确保输出路径的目录已创建 |

### 编译验证流程

1. 修改 `.typ` 文件 → 2. 执行 `typst compile` → 3. exit code 0 即通过 → 4. 失败则按错误信息修复后重编

注意事项：首次编译可能需下载外部包（如 `@preview/xarrow`）稍慢；输出为 PDF，无需构建系统。

---

## 10. 强约束清单

1. 所有数学公式使用正确的 Typst 语法，不保留 LaTeX 宏
2. 多字母变量必须用引号包裹或空格分开
3. 下标前必须有主体；下标后紧跟括号必须用 `{}` 包裹（`_([a-zA-Z])\(` 自查）
4. Display math 标点写在环境内部
5. 不改动模板公共接口名称
6. 保持与现有内容的风格一致性
7. 补全后确保文件可编译（使用 `typst compile` 验证）
8. **正文中不得出现中文**（中文仅限 `//` 注释和 `== Title // 中文标题` 格式）
9. 不删除或修改已有内容，除非明确要求
10. **修改保持局部化**：只动当前 subject 的 `initial.typ`（及其 `scripts/`、`img/` 资源），不改其他笔记、不改模板公共接口
11. 正文中的过渡段落（连接定理之间的逻辑）直接写为普通文本，不使用组件包裹
12. 行列式用 `"det"(A)` / `mat(delim: "|", ...)`，**禁止用 `abs()` 表示行列式**（详见 general.md §7 与 linear-algebra.md §2）