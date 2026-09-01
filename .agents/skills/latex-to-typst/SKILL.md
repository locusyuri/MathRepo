---
name: latex-to-typst
description: 将 MathRepo 中的 LaTeX (elegantbook) 笔记迁移到 Typst 格式。提供完整的组件映射、符号映射、环境转换规则和自动化脚本。适用于批量迁移 LaTeX 笔记到 Typst 单文件格式。
user_invocable: false
---

# LaTeX to Typst 迁移指南

本技能指导 AI 将 MathRepo 中的 LaTeX 笔记（使用 elegantbook 文档类）迁移为 Typst 格式。
迁移参考模板：`1.Analyse/Analyse Complexe/initial.typ`（唯一完整迁移的复分析笔记）。

## 1. 迁移工作流

```
Step 1: 读取 LaTeX 源文件（initial.tex + chapters/chapNN.tex）
  ↓
Step 2: 创建 Typst 骨架（initial.typ）
  ↓
Step 3: 对每个 chapter 文件运行迁移脚本（预处理）
  ↓
Step 4: AI 手动处理脚本无法覆盖的结构转换
  ↓
Step 5: 合并所有章节到 initial.typ（单文件模式）
  ↓
Step 6: 编译验证（typst compile）
  ↓
Step 7: 修复编译错误
```

### Step 1: 读取源文件

- 读取 `initial.tex` 了解整体结构（`\part`、`\input` 列表、附录、参考文献）
- 逐个读取 `chapters/chapNN.tex`，了解每章内容

### Step 2: 创建 Typst 骨架

```typst
#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "笔记标题",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

#make-cover(
  "笔记标题",
  "Violet",
  subtitle: "...",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.1.0",
  extra-info: "...",
)

#make-outline(depth: 2, title: "Contents")

// 如有自定义多字母运算符，在文件顶部定义：
// #let Arg = math.op("Arg")
// #let Ln = math.op("Ln")

// === 正文 ===

#part("Part I Title")
// ... 各章内容 ...

#bibliography("references.bib")
```

### Step 3: 运行迁移脚本

```bash
# 完整转换（预览模式，不写入文件）
bun .agents/skills/latex-to-typst/scripts/migrate.js chapters/chap01.tex /tmp/chap01_draft.typ --dry-run

# 完整转换（写入文件）
bun .agents/skills/latex-to-typst/scripts/migrate.js chapters/chap01.tex /tmp/chap01_draft.typ

# 仅转换结构（标题、环境、列表、图片、标签），跳过符号替换
bun .agents/skills/latex-to-typst/scripts/migrate.js chapters/chap01.tex /tmp/chap01_draft.typ --env-only

# 跳过符号替换（当符号需要手动调整时）
bun .agents/skills/latex-to-typst/scripts/migrate.js chapters/chap01.tex /tmp/chap01_draft.typ --no-symbols
```

### Step 4: AI 手动处理

脚本无法完美处理的内容，需要 AI 手动调整：

1. **嵌套环境**：`description` 环境内嵌套 `enumerate` 等复杂嵌套
2. **复杂表格**：`tabular` 环境需要手动转为 `#tex-table(...)`
3. **多行公式对齐**：`align*` 中的 `&` 对齐符号需要删除，改用 Typst 的 `align` 环境
4. **交叉引用语义**：检查 `@label` 引用是否正确
5. **中文注释**：在标题后添加 `// 中文翻译` 注释
6. **自定义运算符**：如 `\mathrm{Arg}` 等需要在文件顶部用 `#let` 定义
7. **分数简化**：脚本生成的 `(\1) / (\2)` 可能需要在简单情况下去掉括号
8. **绝对值**：检查 `|...|` 是否需要改为 `abs(...)`

### Step 5: 合并到单文件

将所有 chapter 内容按顺序合并到 `initial.typ`，删除 `\input{}` 命令。

### Step 6: 编译验证

```bash
typst compile "Subject/initial.typ" "Subject/initial.pdf" --root .
```

### Step 7: 修复错误

常见编译错误及修复：
- `unknown variable: X` → 检查 Typst 符号名（参考 typst-writing-conventions 技能）
- `unexpected token` → 检查数学模式语法
- `missing argument: body` → 检查组件标签位置（标签必须在 `]` 之后）

---

## 2. 组件映射表

### 2.1 文档结构

| LaTeX | Typst | 说明 |
|-------|-------|------|
| `\part{X}` | `#part("X")` | 大模块分组 |
| `\chapter{X}` | `= X` | 一级标题 |
| `\section{X}` | `== X` | 二级标题 |
| `\subsection{X}` | `=== X` | 三级标题 |
| `\subsubsection{X}` | `==== X` | 四级标题 |
| `\paragraph{X}` | `*X*` | 段落标题 |
| `\begin{leftbarTitle}{X}...\end{leftbarTitle}` | `=== X` | **小标题，不是组件** |
| `\input{chapters/chapNN.tex}` | 直接合并内容 | 单文件模式 |
| `\frontmatter / \mainmatter / \appendix` | 不需要 | Typst 自动处理 |

### 2.2 定理类环境 → Typst 组件

| LaTeX 环境 | Typst 组件 | 颜色 |
|-----------|-----------|------|
| `\begin{theorem}[Name]...\end{theorem}` | `#theorem(name: "Name")[...]` | 红 ♥ |
| `\begin{corollary}[Name]...\end{corollary}` | `#corollary(name: "Name")[...]` | 红 ♥ |
| `\begin{lemma}[Name]...\end{lemma}` | `#lemma(name: "Name")[...]` | 红 ♥ |
| `\begin{definition}{Name}...\end{definition}` | `#definition(name: "Name")[...]` | 绿 ♣ |
| `\begin{property}{Name}...\end{property}` | `#property(name: "Name")[...]` | 绿 ♣ |
| `\begin{proposition}[Name]...\end{proposition}` | `#proposition(name: "Name")[...]` | 蓝 ♠ |
| `\begin{example}[Name]...\end{example}` | `#example(name: "Name")[...]` | 蓝 ♠ |
| `\begin{axiom}[Name]...\end{axiom}` | `#axiom(name: "Name")[...]` | 紫 ♦ |
| `\begin{postulate}[Name]...\end{postulate}` | `#postulate(name: "Name")[...]` | 紫 ♦ |
| `\begin{exercise}[Name]...\end{exercise}` | `#exercise(name: "Name")[...]` | 蓝 ♠ |
| `\begin{remark}...\end{remark}` | `#note[...]` | 注释 |
| `\begin{note}...\end{note}` | `#note[...]` | 注释 |
| `\begin{caution}...\end{caution}` | `#caution[...]` | 警告 |

**名称参数格式**：
- elegantbook 用 `{Name}` 或 `[Name]` 传参 → Typst 统一用 `name: "Name"`
- 无名称时省略 `name:` 参数：`#theorem[...]`

### 2.3 证明/解答环境

| LaTeX | Typst |
|-------|-------|
| `\begin{proof}...\end{proof}` | `#proof[...]` |
| `\begin{solution}...\end{solution}` | `#solution[...]` |

- 删除证明末尾的 `\qed` 或 `\qedsymbol`（`#proof` 自动添加 ■）

### 2.4 列表环境

| LaTeX | Typst |
|-------|-------|
| `\begin{enumerate}\item X\end{enumerate}` | `1. X` |
| `\begin{itemize}\item X\end{itemize}` | `- X` |
| `\begin{description}\item[Title] Content\end{description}` | `1. *Title.* Content` |

- `description` 环境通常出现在 `definition` 内部，转为编号列表 + 粗体标签

### 2.5 数学环境

| LaTeX | Typst |
|-------|-------|
| `\[ ... \]` | `$ ... $`（display math） |
| `\( ... \)` | `$...$`（inline math） |
| `\begin{equation} ... \end{equation}` | `$ ... $` |
| `\begin{align*} ... \end{align*}` | `$ ... $`（删除 `\\` 和 `&`） |
| `\begin{gather*} ... \end{gather*}` | 多个 `$ ... $`（按 `\\` 拆分） |
| `\begin{align} ... \end{align}` | `$ ... $`（删除 `\\` 和 `&`） |

**注意**：`align*` 中的 `\\`（换行）和 `&`（对齐）在 Typst 中需要特殊处理：
- 简单情况：拆分为多个 display math
- 需要对齐：使用 Typst 的 `align` 函数

### 2.6 图片环境

```latex
% LaTeX
\begin{figure}[h]
    \centering
    \includegraphics[width=0.25\textwidth]{img/example.png}
    \caption{Example figure.}
    \label{fig:example}
\end{figure}
```

```typst
// Typst
#figure(
  image("img/example.png", width: 25%),
  caption: [Example figure.],
  placement: auto,
  supplement: [Fig.],
) <fig:example>
```

### 2.7 标签与引用

| LaTeX | Typst |
|-------|-------|
| `\label{fig:example}` | `<fig:example>` |
| `\label{thm:name}` | `<thm:name>` |
| `\label{def:name}` | `<def:name>` |
| `\ref{fig:example}` | `@fig:example` |
| `\ref{thm:name}` | `@thm:name` |
| `\eqref{name}` | `@eq:name` |

**重要**：模板组件（`#theorem`、`#definition` 等）内部的标签不能用 `@` 引用，
必须用 `#link(<label>)[显示文本]`。

### 2.8 字体命令

| LaTeX（文本模式） | Typst |
|------------------|-------|
| `\textbf{X}` | `*X*` |
| `\textit{X}` | `_X_` |
| `\emph{X}` | `_X_` |
| `\textrm{X}` | `rm("X")` |
| `\text{X}`（数学模式中） | `text("X")` |

| LaTeX（数学模式） | Typst |
|------------------|-------|
| `\mathbb{R}` | `bb(R)` |
| `\mathcal{F}` | `cal(F)` |
| `\mathscr{M}` | `scr(M)` |
| `\mathfrak{g}` | `frak(g)` |
| `\mathrm{d}x` | `dif x` |
| `\mathrm{Re}` | `Re` |

### 2.9 间距与杂项

| LaTeX | Typst |
|-------|-------|
| `\vspace{0.7cm}` | `#v(0.7cm)` |
| `\noindent` | （删除） |
| `\centering` | （删除，Typst figure 默认居中） |
| `\bigskip / \medskip / \smallskip` | 空行 |

---

## 3. 符号映射

完整映射参考 `typst-writing-conventions` 技能。脚本自动处理以下类别：

### 3.1 集合与逻辑

| LaTeX | Typst |
|-------|-------|
| `\infty` | `oo` |
| `\varnothing` | `emptyset` |
| `\cup` | `union` |
| `\cap` | `inter` |
| `\subset` | `subset` |
| `\subseteq` | `subset.eq` |
| `\setminus` | `backslash` |
| `\in` | `in` |
| `\notin` | `in.not` |
| `\forall` | `forall` |
| `\exists` | `exists` |
| `\land` | `and` |
| `\lor` | `or` |
| `\lnot` / `\neg` | `not` |

### 3.2 关系

| LaTeX | Typst |
|-------|-------|
| `\neq` | `!=` |
| `\leq` | `<=` |
| `\geq` | `>=` |
| `\approx` | `approx` |
| `\equiv` | `equiv` |
| `\sim` | `~` |
| `\propto` | `prop` |

### 3.3 箭头

| LaTeX | Typst |
|-------|-------|
| `\to` / `\rightarrow` | `->` |
| `\mapsto` | `\|->` |
| `\Rightarrow` / `\implies` | `=>` |
| `\Leftrightarrow` / `\iff` | `<=>` |
| `\leftarrow` | `<-` |

### 3.4 运算

| LaTeX | Typst |
|-------|-------|
| `\cdot` | `dot` |
| `\times` | `times` |
| `\pm` | `plus.minus` |
| `\circ` | `compose` |
| `\oplus` | `plus.o` |

### 3.5 积分与求和

| LaTeX | Typst |
|-------|-------|
| `\sum` | `sum` |
| `\prod` | `product` |
| `\int` | `integral` |
| `\iint` | `integral.double` |
| `\iiint` | `integral.triple` |
| `\oint` | `integral.cont` |

### 3.6 希腊字母

所有希腊字母直接使用英文名称：`\alpha` → `alpha`、`\beta` → `beta`、...、`\Omega` → `Omega`。

变体：`\varepsilon` → `epsilon`、`\varphi` → `phi`、`\vartheta` → `theta`。

### 3.7 修饰符

| LaTeX | Typst |
|-------|-------|
| `\overline{X}` / `\bar{X}` | `overline(X)` |
| `\hat{X}` | `hat(X)` |
| `\tilde{X}` | `tilde(X)` |
| `\vec{X}` | `arrow(X)` |
| `\dot{X}` | `dot(X)` |
| `\sqrt{X}` | `sqrt(X)` |
| `\frac{A}{B}` | `(A) / (B)` |

---

## 4. 脚本使用指南

### 4.1 脚本路径

```
.agents/skills/latex-to-typst/scripts/migrate.js
```

### 4.2 运行模式

| 模式 | 命令 | 用途 |
|------|------|------|
| 完整转换 | `bun migrate.js in.tex out.typ` | 所有转换 |
| 预览 | `bun migrate.js in.tex out.typ --dry-run` | 输出到 stdout |
| 仅结构 | `bun migrate.js in.tex out.typ --env-only` | 标题+环境+列表+图片+标签 |
| 无符号 | `bun migrate.js in.tex out.typ --no-symbols` | 跳过符号替换 |

### 4.3 脚本自动处理的内容

1. **LaTeX 注释**：删除 `%` 注释行
2. **章节标题**：`\chapter` → `=`，`\section` → `==` 等
3. **leftbarTitle**：转为 `==` 小标题
4. **定理类环境**：所有 theorem-like 环境 → Typst 组件
5. **证明/解答**：`proof`/`solution` 环境 → `#proof`/`#solution`
6. **列表**：`enumerate`/`itemize`/`description` → Typst 列表
7. **数学环境**：`align*`/`gather*`/`\[...\]`/`\(...\)` → `$ ... $`
8. **图片**：`figure` 环境 → `#figure(...)`
9. **标签/引用**：`\label` → `<>`，`\ref` → `@`
10. **字体命令**：`\textbf` → `*...*`，`\mathbb` → `bb()` 等
11. **数学符号**：所有希腊字母、关系符、集合符、箭头等
12. **间距命令**：`\vspace` → `#v()`
13. **杂项命令**：`\noindent`、`\centering` 等删除

### 4.4 脚本不处理的内容（需 AI 手动）

1. **嵌套复杂环境**：多层嵌套的 list/theorem
2. **tabular 表格**：需要手动转为 `#tex-table(...)`
3. **align 对齐**：`&` 对齐符需要删除或转为 Typst align 语法
4. **自定义宏**：`\newcommand` 定义的宏需要手动转换
5. **BibTeX**：`\begin{thebibliography}` → `#bibliography("references.bib")`
6. **Preamble**：`\documentclass`、`\usepackage` 等需要手动转为 Typst 头部
7. **中文翻译注释**：需要在标题后手动添加 `// 中文翻译`

---

## 5. 手动转换模式

### 5.1 Preamble → Typst 头部

```latex
% LaTeX preamble
\documentclass[11pt]{../../TexTemplate/elegantbook}
\title{Title}
\author{Author}
\date{Date}
\usepackage{amsmath}
% ...
```

```typst
// Typst 头部
#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Title",
  author: "Author",
  date: datetime.today(),
)

#show: apply-style
```

### 5.2 参考文献

```latex
\begin{thebibliography}{99}
\bibitem{key} Author. \emph{Title}. Publisher, Year.
\end{thebibliography}
```

→ 提取到 `references.bib` 文件，在 initial.typ 末尾写：
```typst
#bibliography("references.bib")
```

### 5.3 自定义运算符

如果 LaTeX 中使用了 `\mathrm{Arg}`、`\mathrm{Ln}` 等多字母运算符，
需要在 Typst 文件顶部定义：

```typst
#let Arg = math.op("Arg")
#let Ln = math.op("Ln")
#let Re = math.op("Re")
#let Im = math.op("Im")
```

### 5.4 description 环境内的定义

```latex
\begin{definition}{Title}
    \begin{description}
        \item[Part 1] Content 1
        \item[Part 2] Content 2
    \end{description}
\end{definition}
```

→

```typst
#definition(name: "Title")[
  1. *Part 1.* Content 1

  2. *Part 2.* Content 2
]
```

### 5.5 多文件合并

LaTeX 使用 `\input{chapters/chap01.tex}` 引用子文件，Typst 使用单文件模式：
- 将每个 chapter 的内容直接写入 `initial.typ`
- 保持 `\part` 分组
- 按原始顺序排列

---

## 6. 迁移检查清单

每个章节迁移完成后逐项检查：

- [ ] 所有章节标题正确转换（`=`, `==`, `===`）
- [ ] 所有定理类环境转为对应 Typst 组件
- [ ] 所有数学符号使用 Typst 语法（无 LaTeX 宏残留）
- [ ] 所有 `\label` 转为 `<label>`，`\ref` 转为 `@label`
- [ ] 所有图片使用 `#figure(image(...))` 格式
- [ ] 标题后有中文翻译注释（`// 中文翻译`）
- [ ] 正文无中文（中文仅出现在 `//` 注释中）
- [ ] 多字母变量用引号包裹（如 `"i"`, `"ext"`）
- [ ] 积分使用 `integral` 而非 `int`
- [ ] 微分使用 `dif x` 正体
- [ ] 绝对值使用 `abs(...)` 而非 `|...|`
- [ ] 分数分子/分母非单因子时已加括号
- [ ] 编译通过（`typst compile` 退出码 0）
- [ ] 与已有笔记的 SRP 边界一致（不重复其他笔记已有的定义/定理）

---

## 7. 强约束

1. **不删除原始 LaTeX 文件**（保留 `.tex` 作为存档）
2. **不改动模板公共接口**（`TypstTemplate/math-notes.typ`）
3. **正文中不得出现中文**（中文仅限 `//` 注释）
4. **遵循 typst-writing-conventions 技能的所有规则**
5. **遵循 template-usage 技能的组件使用规范**
6. **遵循 typst-edit-consistency 技能的一致性原则**
7. **遵循 typst-compile 技能的编译验证流程**
8. **SRP 原则**：不重复其他笔记已有的定义或定理，使用交叉引用
9. **编译验证**：每次修改后必须编译验证
