# AI 补全数学笔记内容指南

## 0. 文档目标

本文件用于指导 AI 衡全本项目中的数学/物理笔记内容，重点覆盖：

- 笔记结构与组织方式
- Typst 语法规范与常见陷阱
- 数学公式、定理、图表的正确写法
- 内容补全的原则与验收标准

适用范围：

- 本仓库内所有数学/物理笔记目录
- 任何遵循 `initial.typ` 入口模式的笔记项目

---

## 1. 内容补全原则

1. **保持一致性**：新内容必须与现有内容的风格、术语、符号系统保持一致。
2. **逻辑连贯**：补全的内容应自然衔接上下文，保持论证的完整性。
3. **层次分明**：严格遵守 Part / Chapter / Section 的层级结构。
4. **引用完整**：所有定理、定义、图表必须有清晰的标签和交叉引用。
5. **编译验证**：每次补全后必须确保文件可编译，不引入语法错误。

---

## 2. 笔记结构规范

### 2.1 主文件与目录结构

每个笔记目录应维持如下基线结构：

```text
Subject/
	initial.typ        # Typst 主入口，唯一推荐构建入口
	references.bib     # 参考文献
	img/               # 正式图片资源
	tmp/               # 临时输出、构建缓存
	initial.tex        # 旧版入口，保留为历史源文件（可选）
	fig/               # 旧版图片目录，仅用于兼容历史材料（可选）
	chapters/          # 旧章节目录，仅作为迁移来源（可选）
```

**核心规则**：

1. `initial.typ` 是 Typst 构建的主入口，所有正文默认集中在这里。
2. `references.bib` 与主文件同级放置。
3. `img/` 是正式图片目录。
4. 不要在笔记根目录外再额外加包装目录（如 `src/`、`content/` 等）。

### 2.2 内容组织方式

推荐组织方式：

1. 用 `#part("...")` 做大分块（对应 Part）。
2. 一级标题 `= ...` 对应 Chapter。
3. 二级标题 `== ...` 对应 Section。
4. 三级标题 `=== ...` 对应 Subsection。

**示例**：

```typst
#part("Classical Mechanics Foundations")

= Newton's Laws and Dynamics
== Newton's Three Laws

Content here...

== Rigid Body Rotation

Content here...
```

### 2.3 最小骨架模板

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
Your content here.

#bibliography("references.bib")
```

---

## 3. Typst 语法规范

### 3.1 结构与文本

- 一级标题：`= Title`
- 二级标题：`== Title`
- 三级标题：`=== Title`
- 加粗：`*text*`
- 斜体：`_text_`
- 垂直间距：`#v(1cm)`

**常见陷阱**：

1. 脚注必须使用 `#footnote[...]`，不能遗漏。
2. 保持原文的排版意图，不要擅自改动强调、标点或公式位置。

### 3.2 列表

- 有序列表：`1. ...` / `2. ...`
- 无序列表：`- ...`
- 嵌套列表使用缩进（Tab）

### 3.3 数学公式

**基本映射**：

- 行内公式：`$ ... $`
- 行间公式：`$ ... $`（单独成段）
- `\mathbb{R}` -> `bb(R)`
- `\mathcal{F}` -> `cal(F)`
- `\mathscr{M}` -> `scr(M)`
- `\to` -> `->`
- `\infty` -> `infinity`
- `\subseteq` -> `subset`
- `\cup` -> `union`
- `\cap` -> `inter`

**符号映射硬规则（必须优先遵守）**：

1. 不属于符号：`$in.not$`（不要写成 `$notin$`）
2. 对称差：`$plus.o$`
3. 子集：统一写作 `$subset$`
4. 箭头：
   - 右箭头：`$->$`
   - 双横箭头：`$<=>$`
   - 其他箭头按语义改写，不要保留 LaTeX 宏名
5. 逻辑运算：
   - `$and$`（合取/楔积）
   - `$or$`（析取）
   - `$not$`（否定）
6. 不等于：`$!= $`
7. 函数复合：`$compose$`
8. `$prec.eq$`

**常见陷阱（必须遵守）**：

1. **裸下标问题**：Typst 不支持 `$_x$`。
   - 下标符号 `_` 前必须有主体
   - 空主体下标：`$""_x$`

2. **多字母变量问题**：Typst 会将连续字母识别为关键字（如 `sin`、`limit`、`exp`），导致编译错误。
   - 正体多字母变量：用引号包裹，如 `$"ext"$`、`$"const"$`、`$"max"$`
   - 斜体多字母变量：用空格分开，如 `$e x t$`、`$m a x$`
   - 示例：`$bold(F)_i^("ext")$` 表示外力，`$"const"$` 表示常数

3. **标点位置**：独立数学公式的句号等标点要写在数学环境内部。

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

4. **display math**：如果原内容是 display math，不要擅自改写成行内数学。

符号参考：https://typst.app/docs/reference/symbols/sym/

### 3.4 定理类环境

项目模板 `math-notes.typ` 已提供组件，优先使用：

- `#theorem(name: "...")[ ... ]` - 定理
- `#definition(name: "...")[ ... ]` - 定义
- `#lemma[ ... ]` - 引理
- `#proposition[ ... ]` - 命题
- `#property[ ... ]` - 性质
- `#corollary[ ... ]` - 推论
- `#axiom[ ... ]` - 公理
- `#postulate[ ... ]` - 公设
- `#example[ ... ]` - 例
- `#note[ ... ]` - 注记
- `#caution(title: "...")[ ... ]` - 警告
- `#proof(name: "...")[ ... ]` - 证明
- `#solution(name: "...")[ ... ]` - 解答
- `#exercise(name: "...")[ ... ]` - 练习

**示例**：

```typst
#theorem(name: "Mean Value Theorem")[
  Let $f$ be continuous on $[a, b]$ and differentiable on $(a, b)$.
  Then there exists $c in (a, b)$ such that

  $
    f'(c) = frac(f(b) - f(a), b - a).
  $
]

#proof[
  Apply Rolle's theorem to $g(x) = f(x) - frac(f(b)-f(a), b-a)(x-a)$.
]
```

### 3.5 图片、标签、交叉引用

**图片**：

```typst
#figure(
	image("img/example.png", width: 60%),
	caption: [This is an example figure.],
	placement: auto,
	supplement: [Fig.]
) <fig:example>
```

**引用**：

- 图片引用：`@fig:example`
- 自定义组件引用：使用 `#link(<label>)[文本]`

```typst
#definition(name: "Continuous Function")[
  A function $f: X -> Y$ is continuous if...
] <def:continuous>

Later, we refer to *#link(<def:continuous>)[Continuous Function]*.
```

**标签命名规范**：

- 图片：`fig:`
- 定理：`thm:`
- 定义：`def:`
- 章节：`sec:`

### 3.6 表格

项目模板提供了 `#tex-table()` 和 `#plain-table()` 组件用于创建表格。

**重要规则**：表格单元格中如果包含数学公式，必须使用中括号 `[...]` 包裹，不能使用引号 `"..."`。
- 使用引号会导致数学公式无法正确渲染
- 使用中括号可以正确渲染数学公式

**正确示例**：

```typst
#tex-table(
  ("Translational", "Rotational"),
  ([Position $x$], [Angle $theta$]),
  ([Velocity $v = dot(x)$], [Angular velocity $omega = dot(theta)$]),
  ([Mass $m$], [Moment of inertia $I$]),
)
```

**错误示例**：

```typst
#tex-table(
  ("Translational", "Rotational"),
  ("Position $x$", "Angle $theta$"),  // 错误：数学公式不会渲染
  ("Velocity $v = dot(x)$", "Angular velocity $omega = dot(theta)$"),
)
```

**纯文本表格**：如果单元格只包含纯文本（无数学公式），可以使用引号：

```typst
#plain-table(
  ("Symbol", "Meaning", "Example"),
  ("$forall$", "for all", "$forall x in A$"),
  ("$exists$", "there exists", "$exists n in NN$"),
)
```

### 3.7 文献与引用

- 主文件尾部：`#bibliography("references.bib")`
- 正文引用：`@citation_key`
- 脚注：`#footnote[...]`

---

## 4. 内容补全流程

### 4.1 补全步骤

1. **理解上下文**：阅读目标章节前后的内容，理解知识脉络。
2. **确定范围**：明确需要补全的具体内容（定理、证明、例题等）。
3. **查阅参考**：如有需要，查阅相关教材或参考资料。
4. **编写内容**：按照 Typst 语法规范编写内容。
5. **验证编译**：确保文件可编译，无语法错误。
6. **检查引用**：确保所有标签和交叉引用正确。

### 4.2 衡全原则

1. **完整性**：补全的内容应形成完整的知识单元。
2. **准确性**：数学内容必须准确无误，证明逻辑严密。
3. **可读性**：表述清晰，符号统一，层次分明。
4. **一致性**：与现有内容的风格、术语保持一致。

### 4.3 常见补全场景

**场景1：补全定理陈述**

```typst
#theorem(name: "Theorem Name")[
  Precise statement of the theorem.

  $
    mathematical_expression.
  $
]
```

**场景2：补全证明**

```typst
#proof[
  Step 1: Setup and notation.

  Step 2: Main argument.

  Step 3: Conclusion.
]
```

**场景3：补全定义**

```typst
#definition(name: "Definition Name")[
  A _term_ is defined as...

  $
    formal_definition.
  $
]
```

**场景4：补全例题**

```typst
#example[
  Consider...

  $
    setup.
  $

  Then...

  $
    conclusion.
  $
]
```

---

## 5. AI 执行时的强约束清单

AI 在补全内容时必须满足：

1. 不改动 `TypstTemplate/math-notes.typ` 的公共接口名称。
2. 保持与现有内容的风格一致性。
3. 所有数学公式使用正确的 Typst 语法。
4. 多字母变量必须用引号包裹或空格分开。
5. 所有定理、定义、图表必须有清晰的标签。
6. 标签命名统一使用前缀：`fig:`、`thm:`、`def:`、`sec:`。
7. 补全后必须确保文件可编译。
8. 不删除或修改已有内容，除非明确要求。

---

## 6. 验收标准

满足以下条件才算完成：

1. `initial.typ` 可成功编译输出 PDF。
2. 目录能显示 Part / Chapter / Section 层级。
3. 所有交叉引用（图、节、文献）无缺失。
4. 新内容与现有内容风格一致。
5. 数学公式无语法错误。
6. 定理、定义等环境使用正确。

---

## 7. LaTex 迁移事项
以下为一些 LaTex 与 Typst 的组件、语法对应关系: