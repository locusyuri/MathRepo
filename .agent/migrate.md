# LaTeX -> Typst 迁移操作文档（Analyse Complexe / Analyse Réelle）

## 0. 文档目标

本文件用于指导 AI 按固定步骤将课程笔记从 LaTeX 迁移到 Typst，重点覆盖：

- 目录结构差异
- 主入口文件差异（`initial.tex` -> `initial.typ`）
- 单文件迁移（`chapXX.tex` 内容并入 `initial.typ`）
- 数学、定理、图片、引用、参考文献语法差异
- 编译与验收流程

适用目录：

- `1.Analyse/Analyse Complexe`
- `1.Analyse/Analyse Réelle`

---

## 1. 先理解当前项目状态（必须先做）

### 1.1 已观察到的真实结构

#### Analyse Complexe

- 已有：`initial.tex`、`initial.typ`、`references.bib`
- 资源目录：`img/` + `fig/`
- 章节目录 `chapters/` 内为混合状态：同时存在 `chap01.tex` 等 LaTeX 文件与 `ComplexNumber.typ`、`ComplexIntegral.typ` 等 Typst 文件

#### Analyse Réelle

- 已有：`initial.tex`、`initial.typ`、`references.bib`
- 资源目录：`img/`（当前未看到 `fig/`）
- 章节目录 `chapters/` 内为混合状态：同时存在 `chap01.tex` 与 `LebesgueMeasure.typ`、`LebesgueIntegration.typ`、`FunctionSpaces.typ`、`Differentiation.typ`

### 1.2 迁移原则

1. 不直接删除旧 `.tex`，先并行保留，确保可回滚。
2. 先保证 `initial.typ` 可编译，再把内容按块并入主文件。
3. 每并入一个内容块（例如一个 section 或一个 definition 组）就编译验证。
4. 图片统一优先走 `img/`；若历史文件在 `fig/`，保持相对路径可解析即可。

---

## 2. 单文件迁移策略（AI 必须遵守）

### 2.1 主文件

- LaTeX 入口：`initial.tex`
- Typst 入口：`initial.typ`

Typst 主文件统一从课程目录引用模板：

```typst
#import "../../TypstTemplate/math-notes.typ": *
```

### 2.2 内容组织方式（不再拆 Chapters 文件）
**优先不拆分文件, 如果文件太大之后会再拆分。**

迁移后不再要求把内容拆到 `chapters/*.typ`，统一直接写在 `initial.typ` 中。

推荐组织方式：

1. 用 `#part("...")` 做大分块。
2. 每个原 `chapXX.tex` 内容改写为一个一级标题 `= ...`。
3. 原 `section/subsection` 分别改为 `==` / `===`。

即：保留逻辑层级，但文件层级收敛为单文件。

---

## 3. 主入口迁移步骤（initial.tex -> initial.typ）

按下面顺序迁移：

1. 引入模板与全局样式。
2. 迁移元数据（标题、作者、日期）。
3. 迁移封面与目录。
4. 迁移分 Part 结构。
5. 把原 `chapters/chapXX.tex` 内容按顺序并入主文件。
6. 启用 bibliography。

### 3.1 最小骨架模板

```typst
#import "../../TypstTemplate/math-notes.typ": *

#set document(
	title: "Analyse Réelle",
	author: "Violet",
	date: datetime.today(),
)

#show: apply-style

#make-cover(
	"Analyse Réelle",
	"Violet",
	subtitle: "A notebook for real analysis",
	institute: "Notiz  Mathematiques",
	date: datetime.today().display(),
	version: "v0.2.0",
	extra-info: "This is a notebook for real analysis.",
)

#make-outline(depth: 2, title: "Contents")

#part("Measure Theory")

= Lebesgue Measure
== Outer Measure and Measurable Sets
Your migrated content here.

#bibliography("references.bib")
```

---

## 4. 内容块迁移步骤（chapXX.tex -> initial.typ）

对每个 `chapXX.tex` 严格执行以下流程：

1. 读取一个 `.tex` 源章节。
2. 在 `initial.typ` 中创建对应一级标题 `= ...`。
3. 先迁移标题层级（chapter/section/subsection）。
4. 再迁移正文、列表、公式。
5. 再迁移定理类环境。
6. 再迁移图片、标签、交叉引用。
7. 最后迁移参考文献引用。
8. 编译通过后继续并入下一个 `chapXX.tex`。

---

## 5. LaTeX -> Typst 语法映射表（核心）

## 5.1 结构与文本

- `\chapter{Title}` -> `= Title`
- `\section{Title}` -> `== Title`
- `\subsection{Title}` -> `=== Title`
- `\textbf{abc}` -> `*abc*`
- `\emph{abc}` -> `_abc_`（或保留 `*abc*` 作为统一强调）
- `\vspace{0.7cm}` -> `#v(0.7cm)`

迁移时常见坑（必须遵守）：

1. LaTeX 中使用 `\textbf{...}` 的内容，Typst 中必须保留为加粗 `*...*`，不允许丢失强调语义。
2. 脚注不能漏迁移：`\footnote{...}` 必须改写为 `#footnote[...]`。

示例：

```typst
This is an important statement*#footnote[Brief justification or source note.]*
```

## 5.2 列表

- `\begin{enumerate} ... \end{enumerate}` -> `1. ...` / `2. ...`
- `\begin{itemize} ... \end{itemize}` -> `- ...`
- `\begin{description}` -> 推荐改写成普通列表或小标题 + 列表

## 5.3 数学公式

- 行内：`\( ... \)` -> `$ ... $`
- 行间：`\[ ... \]` -> `$ ... $`（单独成段）
- `\mathbb{R}` -> `bb(R)`
- `\mathcal{F}` -> `cal(F)`
- `\mathscr{M}` -> `scr(M)`
- `\to` -> `->`
- `\infty` -> `infinity`
- `\subseteq` -> `subset`
- `\cup` -> `union`
- `\cap` -> `inter`

说明：Typst 数学语法不是 LaTeX 逐字兼容，必须按 Typst 关键字重写，不要机械替换。

迁移时常见坑（必须遵守）：

1. Typst 不支持裸下标写法 `$_x$`。
	 下标符号 `_` 前必须有主体；如果确实需要“空主体下标”，统一写成：`$""_x$`。

2. 独立数学公式的句号等标点要写在数学环境内部，不要写在公式外。

错误示例：

```typst
$
	G(a_n; x) = sum_(n=0)^infinity a_n x^n
$.
```

正确示例：

```typst
$
	G(a_n; x) = sum_(n=0)^infinity a_n x^n.
$
```

## 5.4 定理类环境

项目模板 `math-notes.typ` 已提供组件，优先使用：

- `\begin{theorem} ...` -> `#theorem[ ... ]`
- `\begin{definition} ...` -> `#definition(name: "...")[ ... ]`
- `\begin{lemma} ...` -> `#lemma[ ... ]`
- `\begin{proposition} ...` -> `#proposition[ ... ]`
- `\begin{property} ...` -> `#property[ ... ]`
- `\begin{remark} ...` -> `#note[ ... ]`
- `\begin{caution} ...` -> `#caution[ ... ]`
- `\begin{proof} ...` -> `#proof[ ... ]`

`leftbarTitle` 这类 LaTeX 自定义环境建议迁移为：Typst 三级标题。

## 5.5 图片、标签、交叉引用

LaTeX：

```tex
\begin{figure}[h]
	\centering
	\includegraphics[width=0.25\textwidth]{img/a.png}
	\caption{...}
	\label{fig:demo}
\end{figure}
```

Typst：

```typst
#figure(
	image("img/a.png", width: 25%),
	caption: [...],
	placement: auto,
	supplement: [Fig.]
) <fig:demo>
```

引用：

- LaTeX `\ref{fig:demo}` -> Typst `@fig:demo`

自定义组件（尤其 definition/theorem）引用规则：

由于自定义组件无法稳定使用 `@def:...` 直接显示引用文本，统一改为 `#link` 方式：

```typst
*#link(<def:jordan_curve>)[Jordan Curve and Simple Closed Curve]*
```

配套写法：在定义处保留 label，例如：

```typst
#definition(name: "Jordan Curve and Simple Closed Curve")[
  ...
] <def:jordan_curve>
```

路径规则：

- 单文件写在主目录 `initial.typ` 时，图片通常用 `img/...`
- 若素材在 `fig/`，使用 `fig/...`  (不推荐使用这个目录，推荐迁移到 `img/`)

## 5.6 文献与引用

- LaTeX 手写 `thebibliography` 建议迁移到 `references.bib`
- Typst 主文件尾部使用：`#bibliography("references.bib")`
- 正文引用：`\cite{zhou2016}` -> `@zhou2016`
- 脚注引用或说明：`\footnote{...}` -> `#footnote[...]`

---

## 6. 基于两门课程的执行顺序建议

### 6.1 Analyse Réelle（建议先迁移）

原因：章节结构更规整，已有 Typst 样例覆盖测度与积分。

执行顺序：

1. 确认 `initial.typ` 是唯一迁移目标文件。
2. 将 `chap01.tex` 内容并入 `initial.typ` 对应标题块。
3. 继续并入 `chap02.tex` 等后续章节。
4. 检查所有 `@key` 是否存在于 `references.bib`。
5. 全文编译并修复数学语法错误。

### 6.2 Analyse Complexe

执行顺序：

1. 在 `initial.typ` 中先搭好 `#part(...)` 主结构。
2. 将 `chap01.tex`、`chap02.tex`、`chap03.tex` 内容依次并入主文件。
3. 检查图片路径在 `img/` 或 `fig/` 下是否存在。
4. 再扩展后续章节并补齐 glossary 与参考文献。

---

## 7. AI 执行时的强约束清单

AI 在自动迁移时必须满足：

1. 不改动 `TypstTemplate/math-notes.typ` 的公共接口名称。
2. 不删除任何原始 `.tex` 文件。
3. 每并入一个内容块就进行一次编译验证。
4. 发现未知 LaTeX 宏时：保留原意并改写为 Typst 可读写法，不允许直接丢弃内容。
5. 所有图片引用必须在磁盘存在；不存在时在文档中明确标记 TODO。
6. 标签命名统一使用前缀：`fig:`、`thm:`、`def:`、`sec:`。
7. 迁移内容全部放在 `initial.typ`，不再依赖 `#include chapters/*.typ`。
8. 对于自定义组件 label 的引用，统一使用 `#link(<label>)[文本]`。
9. 所有 `\footnote{...}` 必须迁移为 `#footnote[...]`，不得遗漏。

---

## 8. 迁移完成的验收标准

满足以下条件才算完成：

1. `initial.typ` 可成功编译输出 PDF。
2. 目录能显示 Part / Chapter / Section 层级。
3. 所有交叉引用（图、节、文献）无缺失。
4. 内容已全部并入 `initial.typ`（不再依赖章节拆分文件）。
5. 样式统一使用模板组件（theorem/definition/note/caution 等）。
6. 对应课程目录下不再依赖 `initial.tex` 才能生成主文档。

---

## 9. 推荐的 AI 执行提示词（可直接复用）

```text
请按 .agent/migrate.md 的步骤迁移 1.Analyse/Analyse Réelle。
要求：
1) 内容全部写在 initial.typ，不拆分 chapters/*.typ；
2) 每迁移一个内容块就完成一次编译验证；
3) 自定义组件引用使用 #link(<label>)[文本]，例如 #link(<def:jordan_curve>)[Jordan Curve and Simple Closed Curve]；
4) 不删除任何 tex 文件；
5) 若遇到 LaTeX 宏不兼容，给出等价 Typst 改写并在文件中保留语义；
6) 输出本次改动文件列表与未完成 TODO。
```

