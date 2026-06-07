---
name: typst-writing-conventions
description: 当编辑/创建 .typ 文件时，必须使用本技能以确保符合 Typst 语法规范（如 subset→subset.eq, \sigma→sigma, integral→integral 等）、符号映射规则、文档层级结构和写作风格约定。尤其适用于新增数学公式较多的笔记时。
user_invocable: false
---


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

### 符号映射（LaTeX → Typst）

| LaTeX | Typst |
|-------|-------|
| `\mathbb{R}` | `bb(R)` |
| `\mathcal{F}` | `cal(F)` |
| `\mathscr{M}` | `scr(M)` |
| `\to`, `\rightarrow` | `->` |
| `\Rightarrow` | `=>` |
| `\Leftrightarrow` | `<=>` |
| `\infty` | `oo` |
| `\subseteq` | `subset` |
| `\cup` | `union` |
| `\cap` | `inter` |
| `\notin` | `in.not` |
| `\neq` | `!=` |
| `\land` | `and` |
| `\lor` | `or` |
| `\lnot` | `not` |
| `\circ`（复合） | `compose` |
| `\preceq` | `prec.eq` |
| `\oplus`（对称差） | `plus.o` |
| `\forall` | `forall` |
| `\exists` | `exists` |
| `\partial` | `partial` |
| `\mathrm{d}x` | `dif x` |
| `\liminf` | `liminf` |
| `\limsup` | `limsup` |
| `\sup` | `sup` |
| `\inf` | `inf` |
| `\overline{X}` | `overline(X)` |
| `\chi_A`（特征函数） | `chi_A` |
| `\backslash` | `backslash` |
| `\int` | `integral` |
| `\iint`, `\iiint` | `integral.double`, `integral.triple` |
| `\oint` | `integral.cont`（闭合环路线积分） |
| `\cdot` | `dot` |
| `\sim` | `~` 或 `approx` |
| `\text{...}` | `text("...")`（**必须用字符串引号**） |
| `\left(`, `\right)` | 无对应命令，Typst 自动缩放括号 |
| `\left[`, `\right]` | 无对应命令，Typst 自动缩放方括号 |

### 硬规则（必须遵守）

1. **不属于符号**：写 `$in.not$`，不要写 `$notin$`
2. **子集**：统一写 `$subset$`
3. **箭头**：`$->$`、`$<=>$`，不保留 LaTeX 宏名
4. **不等于**：`$!=$`（注意空格：`$!= $` 或 `$a != b$`）
5. **函数复合**：`$compose$`
6. **微分符号**：使用正体 `dif x`、`dif t`
7. **导数点记号**：`dot(x)`、`dot.double(x)`、`dot.triple(x)`
8. **积分号**：用 `integral`，不是 `int`。二重/三重：`integral.double`、`integral.triple`
9. **`text()` 必须用字符串参数**：写 `text("something")`，不是 `text(something)`
10. **点乘**：写 `a dot b`，不用 `a cdot b`（`cdot` 不存在）
11. **`\left(`/`\right)` 不存在**：Typst 自动缩放括号，不需要 `\left`/`\right`

### 常见陷阱

#### 裸下标问题

Typst 不支持 `$_x$`，下标 `_` 前必须有主体。

```typst
// 错误
$_x$

// 正确：空主体下标
$""_x$
```

#### 多字母变量问题

Typst 将连续字母识别为内置函数名（如 `sin`、`exp`），导致编译错误。

```typst
// 正体多字母变量：用引号包裹
$"ext"$, $"const"$, $"max"$

// 斜体多字母变量：用空格分开
$e x t$

// 示例
$bold(F)_i^("ext")$  // 外力
```

#### 标点位置

独立数学公式的句号等标点必须写在数学环境内部：

```typst
// 错误
$
  G(a_n; x) = sum_(n=0)^oo a_n x^n
$.

// 正确
$
  G(a_n; x) = sum_(n=0)^oo a_n x^n.
$
```

#### Display math 保持原样

如果原内容是 display math，不要擅自改写成行内数学。

#### 括号自动缩放

Typst 自动缩放普通括号，通常不需要 LaTeX 的 `\left`/`\right`。需要长竖线时使用 `lr(...)`。

#### `int` → `integral` 遗忘

LaTeX 习惯用 `\int`，Typst 必须写 `integral`。`int` 是未知变量，会报错。

```typst
// 错误
$int_0^1 f(x) dif x$

// 正确
$integral_0^1 f(x) dif x$

// 二重积分
$integral.double_S f dif S$

// 闭合曲面积分（无 oint 符号）
$integral_(partial V) bold(E) dot dif bold(S)$
```

#### `text()` 字符串参数

Typst 的 `text()` 函数必须传入字符串，未加引号的参数会被当作变量：

```typst
// 错误 — "self" 被当作变量名
$U_(text(self))$

// 正确
$U_(text("self"))$
```

#### `sim`/`cdot` 等 LaTeX 宏不存在

Typst 数学模式不识别 `\sim`、`\cdot` 等 LaTeX 宏名。使用原生操作符：

| 意图 | 错误写法 | 正确写法 |
|------|---------|---------|
| 约等于/相似 | `$a sim b$` | `$a ~ b$` 或 `$a approx b$` |
| 点乘 | `$a cdot b$` | `$a dot b$` |
| 趋向 | `$x to oo$` | `$x arrow oo$` 或 `$x -> oo$` |

#### `ll`, `gg` 等比较符号不存在

Typst 数学模式不识别 `\ll`、`\gg` 等 LaTeX 宏名。使用原生比较操作符：

| 意图 | 错误写法 | 正确写法 |
|------|---------|---------|
| 远小于 | `$d \ll \sqrt(A)$` | `$d << \sqrt(A)$` |
| 远大于 | `$a \gg b$` | `$a >> b$` |

#### `laplacian`, `oint` 等非标准符号不存在

Typst 数学模式不识别 `\laplacian`、`\oint` 等 LaTeX 宏名。使用等价表达：

| 意图 | 错误写法 | 正确写法 |
|------|---------|---------|
| 拉普拉斯算子 | `$\laplacian V = 0$` | `$nabla^2 V = 0$` |
  | 闭合环路线积分 | `$\oint_sigma bold(f) dot d bold(l)$` | `$integral.cont_sigma bold(f) dot d bold(l)$` |
  | 闭合曲面积分 | `$\oint_sigma dif a$` | `$integral_(partial sigma) dif a$` 或 `$integral_sigma dif a$` |

#### `const` 等多字母标识符未加引号

在数学模式中使用 `text()` 包裹的文本参数必须加引号，否则被当作未定义变量：

| 意图 | 错误写法 | 正确写法 |
|------|---------|---------|
| 常数符号 | `$sigma approx frac(const, R_c)$` | `$sigma approx frac("const", R_c)$` |
| 文本标签 | `$V_(text(self))$` | `$V_(text("self"))$` |

#### 未知符号查阅官网

遇到不确定的数学符号时，查阅 Typst 官方符号文档：
https://typst.app/docs/reference/symbols/sym/

常见需要查阅的情况：
- `\laplacian` 等非标准 LaTeX 宏 — Typst 不支持，需用等价表达
- `\ll`、`\gg`、`\lll` 等罕见比较符号 — 可用 `<<`、`>>`、`<<<` 替代
- `\hbar`、`\ell` 等物理/数学特殊符号 — 查阅官网确认可用名称

#### `infty` → `oo`

无限大符号是 `oo`（两个字母 o），不是 `infty` 也不是 `infinity`：

```typst
// 错误
$n -> infinity$

// 正确
$n -> oo$
```

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

```typst
#definition(name: "Continuous Function")[
  A function $f: X -> Y$ is continuous if...
] <def:continuous>

Later, we refer to *#link(<def:continuous>)[Continuous Function]*.
```

---

## 5. 图片

```typst
#figure(
  image("img/example.png", width: 60%),
  caption: [This is an example figure.],
  placement: auto,
  supplement: [Fig.]
) <fig:example>
```

- 图片文件放在 `img/` 目录下
- 使用相对路径引用

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

---

## 8.5 收敛箭头（xarrow 包）

使用 `@preview/xarrow:0.4.0` 包实现带标注的收敛箭头：

```typst
#import "@preview/xarrow:0.4.0": xarrow

// 几乎处处收敛
$f_n xarrow("a.e.") f$

// 依测度收敛
$f_n xarrow(mu) f$

// 几乎一致收敛
$f_n xarrow("a.u.") f$

// L^p 范数收敛
$f_n xarrow(L^p) f$
```

---

## 8.6 积分记号惯例

```typst
// 基本积分
$integral_X f dif mu$

// 集合上的积分
$integral_A f dif mu$
$integral_(E_n) f dif mu$

// 集合描述作为积分下标（注意花括号）
$integral_({|f| > M}) |f| dif mu$
$integral_({x in X : f(x) >= epsilon}) f dif mu$

// 上确界/下确界带下标
$sup_(s <= f) integral_X s dif mu$
$liminf_(n->oo) integral_X f_n dif mu$
```

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
- 组件 `name` 参数使用英文
- 数学术语使用学科通用英文表述

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

### 组件选择指南

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

### 集合与函数空间记号

- 集合描述：`${x in X : P(x)}$`（使用冒号 `:` 而非竖线）
- $L^p$ 空间：`$L^1 (X, mu)$`（空格分隔参数）
- 特征函数/指示函数：`$chi_A$` 或 `$chi_(A)$`
- 几乎处处：正文中写 `a.e.`，公式中写 `"a.e."`

### 积分记号

- 积分微元使用正体：`$integral_X f dif mu$`
- 积分区域用下标：`$integral_A f dif mu$`、`$integral_(E_n) f dif mu$`
- 集合上的积分限制：`$integral_({|f| > M}) |f| dif mu$`（注意花括号内的集合描述）

---

## 10. 强约束清单

1. 所有数学公式使用正确的 Typst 语法，不保留 LaTeX 宏
2. 多字母变量必须用引号包裹或空格分开
3. 下标前必须有主体
4. Display math 标点写在环境内部
5. 不改动模板公共接口名称
6. 保持与现有内容的风格一致性
7. 补全后确保文件可编译（使用 `typst compile` 验证）
8. **正文中不得出现中文**（中文仅限 `//` 注释和 `== Title // 中文标题` 格式）
9. 不删除或修改已有内容，除非明确要求
10. 正文中的过渡段落（连接定理之间的逻辑）直接写为普通文本，不使用组件包裹
