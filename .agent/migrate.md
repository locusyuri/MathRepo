# LaTeX -> Typst 数学笔记迁移规范

## 0. 文档目标

本文件用于指导 AI 将本项目中的数学笔记从 LaTeX 迁移到 Typst，重点覆盖：

- 目录结构差异
- 主入口文件差异（`initial.tex` -> `initial.typ`）
- 单文件迁移为默认策略（`chapXX.tex` 内容并入 `initial.typ`）
- 数学、定理、图片、引用、参考文献语法差异
- 编译与验收流程

适用范围：

- 本仓库内所有数学笔记目录
- 任何遵循 `initial.tex` / `initial.typ` 入口模式的笔记项目

---

## 1. 迁移原则

1. 不直接删除旧 `.tex`，先并行保留，确保可回滚。
2. 先保证 `initial.typ` 可编译，再把内容按块并入主文件。
3. 每并入一个内容块（例如一个 section、一个定理组、一个图例组）就编译验证。
4. 图片统一优先走 `img/`；若历史文件在 `fig/`，保持相对路径可解析即可，但不要新增对 `fig/` 的依赖。
5. 迁移时优先保留原文逻辑顺序，不要为了“看起来更整齐”擅自重排论述结构。

---

## 2. 单文件迁移策略（AI 必须遵守）

### 2.1 主文件

- LaTeX 入口：`initial.tex`
- Typst 入口：`initial.typ`

Typst 主文件统一从项目模板引用模板：

```typst
#import "../../TypstTemplate/math-notes.typ": *
```

### 2.2 目录结构基线

以当前仓库的现有组织方式为准，每个数学笔记目录应尽量维持如下基线结构：

```text
Subject/
	initial.typ        # Typst 主入口，唯一推荐构建入口
	references.bib     # 参考文献
	img/               # 正式图片资源
	tmp/               # 临时输出、构建缓存
	initial.tex        # 旧版入口，保留为历史源文件
	fig/               # 旧版图片目录，仅用于兼容历史材料
	chapters/          # 旧章节目录，仅作为迁移来源，不作为 Typst 默认构建入口
```

目录规则：

1. `initial.typ` 是 Typst 构建的主入口，所有正文默认集中在这里。
2. `references.bib` 与主文件同级放置，不要再把文献拆到更深层目录。
3. `img/` 是正式图片目录；若旧资源还在 `fig/`，优先迁移到 `img/`，`fig/` 只作为历史兼容层。
4. `chapters/` 可以保留作迁移来源或草稿区，但不应再作为 Typst 的默认输入层。
5. `tmp/` 只放临时文件、编译产物或过渡缓存，不承载正文。
6. 不要在笔记根目录外再额外加一层 `src/`、`content/`、`docs/` 之类的包装目录，除非项目明确需要第二个源码根。
7. 小型笔记可以直接省略 `chapters/`，但不省略 `initial.typ`、`references.bib`、`img/`、`tmp/` 这些基础位置。

### 2.3 内容组织方式

默认不再拆分为多个 `chapters/*.typ` 文件，统一直接写在 `initial.typ` 中。若文档规模极大且确有维护必要，再考虑拆分，但必须先在迁移文档里明确说明理由。

推荐组织方式：

1. 用 `#part("...")` 做大分块。
2. 每个原 `\chapter{...}` 改写为一个一级标题 `= ...`。
3. 原 `\section{...}` / `\subsection{...}` 分别改为 `==` / `===`。
4. 不要因为“单文件”就丢掉原有层级，层级必须保留，只是文件数收敛。

即：保留逻辑层级，但文件层级收敛为单文件。

---

## 3. 主入口迁移步骤（initial.tex -> initial.typ）

按下面顺序迁移：

1. 引入模板与全局样式。
2. 迁移元数据（标题、作者、日期）。
3. 迁移封面与目录。
4. 迁移分 Part 结构。
5. 把原 `\chapter` / `\section` 内容按顺序并入主文件。
6. 启用 bibliography。

### 3.1 最小骨架模板

```typst
#import "../../TypstTemplate/math-notes.typ": *

#set document(
	title: "Document Title",
	author: "Violet",
	date: datetime.today(),
)

#show: apply-style

#make-cover(
	"Document Title",
	"Violet",
	subtitle: "A notebook for mathematics",
	institute: "Notiz Mathematiques",
	date: datetime.today().display(),
	version: "v0.2.0",
	extra-info: "This is a mathematics notebook.",
)

#make-outline(depth: 2, title: "Contents")

#part("Part Title")

= Chapter Title
== Section Title
Your migrated content here.

#bibliography("references.bib")
```

---

## 4. 内容块迁移步骤（按原文结构并入 initial.typ）

对每个原始 LaTeX 内容块严格执行以下流程：

1. 读取一个 `.tex` 源章节。
2. 在 `initial.typ` 中创建对应一级标题 `= ...`。
3. 先迁移标题层级（chapter/section/subsection）。
4. 再迁移正文、列表、公式。
5. 再迁移定理类环境。
6. 再迁移图片、标签、交叉引用。
7. 再迁移脚注、参考文献与特殊说明。
8. 编译通过后继续并入下一个内容块。

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
3. 迁移时优先忠实保留原文的排版意图，不要为了“更 Typst”而改动原文强调、标点或公式位置。

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
- 行间：`\[ ... \]` -> `$ ... $`（单独成段；不要把行间公式压成行内）
- `\mathbb{R}` -> `bb(R)`
- `\mathcal{F}` -> `cal(F)`
- `\mathscr{M}` -> `scr(M)`
- `\to` -> `->`
- `\infty` -> `infinity`
- `\subseteq` -> `subset`
- `\cup` -> `union`
- `\cap` -> `inter`

说明：Typst 数学语法不是 LaTeX 逐字兼容，必须按 Typst 关键字重写，不要机械替换。

符号映射硬规则（必须优先遵守）：

1. 不属于符号统一写作 `$in.not$`，不要写成 LaTeX 的 `$notin$` 或 `$not\\in$`。
2. 对称差等符号统一写作 `$plus.o$`。
3. 所有 `subset` / `subseteq` 统一写作 `$subset$`。
4. 所有箭头相关写法都改成 Typst 的直观语法：
	- 右箭头：`$->$`
	- 左右双横箭头：`$<=>$`
	- 其他同类箭头，例如 `to`、`implies`、`Rightarrow`、`Leftrightarrow`，都要按语义改写为对应的直观箭头，不要保留 LaTeX 宏名。
5. `wedge` / `land`（楔积、合取等）统一写作 `$and$`；`lor` / `vee`（析取等）统一写作 `$or$`；`neg` 统一写作 `$not$`。
6. 不等于统一写作 `$!= $`。
7. 函数复合 `circ` 统一写作 `$compose$`。
8. `preceq` 统一写作 `$prec.eq$`。

如果遇到不确定的符号，优先查阅 Typst 符号参考：
https://typst.app/docs/reference/symbols/sym/

迁移时常见坑（必须遵守）：

1. Typst 不支持裸下标写法 `$_x$`。
	 下标符号 `_` 前必须有主体；如果确实需要“空主体下标”，统一写成：`$""_x$`。

2. 独立数学公式的句号等标点要写在数学环境内部，不要写在公式外。
3. 如果原 LaTeX 使用的是 display math，就不要擅自改写成普通文本或行内数学。
4. 遇到集合、关系、逻辑符号时，先按上述硬规则替换，再考虑局部上下文。

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

## 6. AI 执行时的强约束清单

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

## 7. 迁移完成的验收标准

满足以下条件才算完成：

1. `initial.typ` 可成功编译输出 PDF。
2. 目录能显示 Part / Chapter / Section 层级。
3. 所有交叉引用（图、节、文献）无缺失。
4. 内容已全部并入 `initial.typ`（不再依赖章节拆分文件）。
5. 样式统一使用模板组件（theorem/definition/note/caution 等）。
6. 对应课程目录下不再依赖 `initial.tex` 才能生成主文档。

---

## 8. 推荐的 AI 执行提示词（可直接复用）

```text
请按 .agent/migrate.md 的步骤迁移本项目中的某个数学笔记。
要求：
1) 内容全部写在 initial.typ，不拆分 chapters/*.typ；
2) 每迁移一个内容块就完成一次编译验证；
3) 自定义组件引用使用 #link(<label>)[文本]，例如 #link(<def:jordan_curve>)[Jordan Curve and Simple Closed Curve]；
4) 不删除任何 tex 文件；
5) 若遇到 LaTeX 宏不兼容，给出等价 Typst 改写并在文件中保留语义；
6) 输出本次改动文件列表与未完成 TODO。
```

