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

## 9. 强约束清单

1. 所有数学公式使用正确的 Typst 语法，不保留 LaTeX 宏
2. 多字母变量必须用引号包裹或空格分开
3. 下标前必须有主体
4. Display math 标点写在环境内部
5. 不改动模板公共接口名称
6. 保持与现有内容的风格一致性
7. 补全后确保文件可编译
8. 不删除或修改已有内容，除非明确要求
