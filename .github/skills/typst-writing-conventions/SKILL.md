---
name: typst-writing-conventions
description: 本技能文件规定了在本项目中使用 Typst 编写数学/物理笔记时必须遵守的语法规范和最佳实践。
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
| `\infty` | `infinity` |
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

### 硬规则（必须遵守）

1. **不属于符号**：写 `$in.not$`，不要写 `$notin$`
2. **子集**：统一写 `$subset$`
3. **箭头**：`$->$`、`$<=>$`，不保留 LaTeX 宏名
4. **不等于**：`$!=$`（注意空格：`$!= $` 或 `$a != b$`）
5. **函数复合**：`$compose$`
6. **微分符号**：使用正体 `dif x`、`dif t`
7. **导数点记号**：`dot(x)`、`dot.double(x)`、`dot.triple(x)`

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
  G(a_n; x) = sum_(n=0)^infinity a_n x^n
$.

// 正确
$
  G(a_n; x) = sum_(n=0)^infinity a_n x^n.
$
```

#### Display math 保持原样

如果原内容是 display math，不要擅自改写成行内数学。

#### 括号自动缩放

Typst 自动缩放普通括号，通常不需要 LaTeX 的 `\left`/`\right`。需要长竖线时使用 `lr(...)`。

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
$liminf_(n->infinity) integral_X f_n dif mu$
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

- 正文使用英文，中文翻译以 `//` 注释形式附在标题后：`== Section Title // 中文标题`
- 定理、定义等组件的 `name` 参数使用英文
- 数学术语使用学科通用英文表述

### 证明写作

- 证明步骤之间用空行分隔，保持逻辑段落清晰
- 长证明使用 `*Step N*:` 标记关键步骤
- 证明结束由 `#proof` 组件自动添加 ■ 符号，不需要手动写 QED

### 内容组织模式

典型的定理展开模式（按需选用）：

```
#theorem(name: "...")[...]
#proof[...]
#corollary[...]          // 直接推论
#example[...]            // 说明性例子或反例
#note[...]               // 与其他定理的对比、适用场景说明
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
8. 不删除或修改已有内容，除非明确要求
9. 章节文件（`chapters/*.typ`）开头需要 `#import` 模板（因为它们可能被独立引用）
10. 正文中的过渡段落（连接定理之间的逻辑）直接写为普通文本，不使用组件包裹
