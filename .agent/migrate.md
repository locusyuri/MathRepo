# LaTeX -> Typst 迁移操作文档（Analyse Complexe / Analyse Réelle）

## 0. 文档目标

本文件用于指导 AI 按固定步骤将课程笔记从 LaTeX 迁移到 Typst，重点覆盖：

- 目录结构差异
- 主入口文件差异（`initial.tex` -> `initial.typ`）
- 章节文件迁移（`chapXX.tex` -> `*.typ`）
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
2. 先保证 `initial.typ` 可编译，再逐章替换。
3. 每迁移 1 个章节立即编译验证，不一次性大改。
4. 图片统一优先走 `img/`；若历史文件在 `fig/`，保持相对路径可解析即可。

---

## 2. 目录与文件命名策略（AI 必须遵守）

### 2.1 主文件

- LaTeX 入口：`initial.tex`
- Typst 入口：`initial.typ`

Typst 主文件统一从课程目录引用模板：

```typst
#import "../../TypstTemplate/math-notes.typ": *
```

### 2.2 章节文件命名

建议把 `chap01.tex` 这类编号文件迁移为语义化名称，例如：

- `chap01.tex` -> `LebesgueMeasure.typ`
- `chap02.tex` -> `LebesgueIntegration.typ`
- `chap01.tex` -> `ComplexNumber.typ`

如果暂时无法判断语义，允许先用过渡名：`chap01.typ`，后续再重命名。

### 2.3 章节引用方式

- LaTeX：`\input{chapters/chap01.tex}`
- Typst：`#include "chapters/ComplexNumber.typ"`

只会编译被 `#include` 引用的章节。

---

## 3. 主入口迁移步骤（initial.tex -> initial.typ）

按下面顺序迁移：

1. 引入模板与全局样式。
2. 迁移元数据（标题、作者、日期）。
3. 迁移封面与目录。
4. 迁移分 Part 结构。
5. 替换章节输入为 `#include`。
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
#include "chapters/LebesgueMeasure.typ"

#bibliography("references.bib")
```

---

## 4. 章节迁移步骤（chapXX.tex -> *.typ）

对每个章节严格执行以下流程：

1. 读取一个 `.tex` 源章节。
2. 在 `chapters/` 新建对应 `.typ` 文件。
3. 先迁移标题层级（chapter/section/subsection）。
4. 再迁移正文、列表、公式。
5. 再迁移定理类环境。
6. 再迁移图片、标签、交叉引用。
7. 最后迁移参考文献引用。
8. 编译通过后再把 `initial.typ` 的 include 指向新文件。

---

## 5. LaTeX -> Typst 语法映射表（核心）

## 5.1 结构与文本

- `\chapter{Title}` -> `= Title`
- `\section{Title}` -> `== Title`
- `\subsection{Title}` -> `=== Title`
- `\textbf{abc}` -> `*abc*`
- `\emph{abc}` -> `_abc_`（或保留 `*abc*` 作为统一强调）
- `\vspace{0.7cm}` -> `#v(0.7cm)`

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
	image("../img/a.png", width: 25%),
	caption: [...],
	placement: auto,
	supplement: [Fig.]
) <fig:demo>
```

引用：

- LaTeX `\ref{fig:demo}` -> Typst `@fig:demo`

路径规则：

- 章节文件位于 `chapters/` 下时，引用图片通常用 `../img/...`
- 若素材在 `fig/`，使用 `../fig/...`（注意，Typst 不再使用 fig 目录）

## 5.6 文献与引用

- LaTeX 手写 `thebibliography` 建议迁移到 `references.bib`
- Typst 主文件尾部使用：`#bibliography("references.bib")`
- 正文引用：`\cite{zhou2016}` -> `@zhou2016`

---

## 6. 基于两门课程的执行顺序建议

### 6.1 Analyse Réelle（建议先迁移）

原因：章节结构更规整，已有 Typst 样例覆盖测度与积分。

执行顺序：

1. 确认 `initial.typ` 已仅包含 `.typ` 章节。
2. 将 `chap01.tex` 内容合并/迁移到 `LebesgueMeasure.typ`。
3. 检查所有 `@key` 是否存在于 `references.bib`。
4. 全文编译并修复数学语法错误。

### 6.2 Analyse Complexe

执行顺序：

1. 先稳定 `ComplexNumber.typ`、`ComplexFunction.typ`、`ComplexIntegral.typ`。
2. 将 `chap01.tex`、`chap02.tex`、`chap03.tex` 中未迁移内容补齐到对应 `.typ`。
3. 检查图片路径在 `../img/` 或 `../fig/` 下是否存在。
4. 再扩展后续章节并加入 `#part(...)` 结构。

---

## 7. AI 执行时的强约束清单

AI 在自动迁移时必须满足：

1. 不改动 `TypstTemplate/math-notes.typ` 的公共接口名称。
2. 不删除任何原始 `.tex` 文件。
3. 每迁移一个章节就进行一次编译验证。
4. 发现未知 LaTeX 宏时：保留原意并改写为 Typst 可读写法，不允许直接丢弃内容。
5. 所有图片引用必须在磁盘存在；不存在时在文档中明确标记 TODO。
6. 标签命名统一使用前缀：`fig:`、`thm:`、`def:`、`sec:`。
7. 在主文件中只 include 已迁移且可编译的章节。

---

## 8. 迁移完成的验收标准

满足以下条件才算完成：

1. `initial.typ` 可成功编译输出 PDF。
2. 目录能显示 Part / Chapter / Section 层级。
3. 所有交叉引用（图、节、文献）无缺失。
4. 所有 include 的章节均为 `.typ`。
5. 样式统一使用模板组件（theorem/definition/note/caution 等）。
6. 对应课程目录下不再依赖 `initial.tex` 才能生成主文档。

---

## 9. 推荐的 AI 执行提示词（可直接复用）

```text
请按 .agent/migrate.md 的步骤迁移 1.Analyse/Analyse Réelle。
要求：
1) 仅迁移一个章节并完成一次编译验证；
2) 不删除任何 tex 文件；
3) 若遇到 LaTeX 宏不兼容，给出等价 Typst 改写并在文件中保留语义；
4) 输出本次改动文件列表与未完成 TODO。
```

