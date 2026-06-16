---
name: template-usage
description: 本技能文件规定了 `TypstTemplate/math-notes.typ` 模板的使用方式和所有可用组件。
user_invocable: false
---


## 1. 模板导入与初始化

每个笔记的 `initial.typ` 必须按以下顺序初始化：

```typst
#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Document Title",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style
```

- 导入路径根据笔记目录深度调整（通常为 `../../TypstTemplate/math-notes.typ`）
- `apply-style` 必须在 `#show:` 中调用，它设置页面、字体、页眉页脚和标题样式

---

## 2. 封面 `#make-cover`

```typst
#make-cover(
  "Document Title",       // 必填：主标题
  "Author Name",          // 必填：作者
  subtitle: "...",        // 可选：副标题
  institute: "...",       // 可选：单位
  date: datetime.today().display(),  // 可选：日期
  version: "v0.2.0",     // 可选：版本号
  extra-info: "...",      // 可选：底部补充说明
)
```

### 项目惯例

- 作者统一为 `"Violet"`
- 单位统一为 `"Notiz Mathematiques"`
- 版本号格式 `"v0.x.0"`
- `extra-info` 通常为一句话描述笔记内容

---

## 3. 目录 `#make-outline`

```typst
#make-outline(depth: 2, title: "Contents")
```

- `depth`：目录显示深度（1 = 仅 Chapter，2 = Chapter + Section，3 = 含 Subsection）
- `title`：目录页标题，默认 `"Contents"`
- 目录自动识别 Part 分组并以高亮条显示

---

## 4. Part 分组 `#part`

```typst
#part("Part Title")
```

- 生成独立的 Part 页面（罗马数字编号 + 标题）
- 用于将章节分组为大知识模块
- Part 后紧跟 Chapter（一级标题 `=`）

---

## 5. 章节文件组织

所有内容直接写在 `initial.typ` 中。不再使用 `chapters/` 目录的 `#include` 分文件模式。

---

## 6. 定理类组件（Major Components）

所有定理类组件自动编号，格式为 `章号.序号`（如 `1.3`）。每个 Chapter 开始时计数器重置。

### 定理族（红色系 ♥）

```typst
#theorem(name: "Theorem Name")[
  Statement of the theorem.
]

#corollary(name: "...")[...]

#lemma(name: "...")[...]
```

### 定义族（绿色系 ♣）

```typst
#definition(name: "Definition Name")[
  A _term_ is defined as...
]

#property(name: "...")[...]
```

### 命题族（蓝色系 ♠）

```typst
#proposition(name: "...")[...]

#example(name: "...")[...]
```

### 公理族（紫色系 ♦）

```typst
#axiom(name: "...")[...]

#postulate(name: "...")[...]
```

### 参数说明

- `name`：可选，显示在标签旁的名称（如定理名）
- `body`：组件正文，用 `[...]` 包裹

---

## 7. 次要组件（Minor Components）

### 证明与解答（不编号）

```typst
#proof(name: "for the Mean Value Theorem")[
  Proof steps...
]

#solution(name: "quadratic minimization")[
  Solution steps...
]
```

- `proof` 结尾显示实心方框 ■
- `solution` 结尾显示空心方框 □

### 练习

```typst
#exercise(name: "Warm-up")[
  Exercise statement...
]
```

---

## 8. 注释组件

### Note（信息提示）

```typst
#note[
  Commentary or reminder text.
]
```

### Caution（警告提示）

```typst
#caution(title: "Custom Title")[
  Warning text.
]
```

### 自定义配色 Note

```typst
#note(
  title: "Custom Title",
  icon: [\*],
  bg: rgb("#EEF7FF"),
  border: rgb("#9CC6EB"),
  accent: rgb("#2F6EA5"),
)[
  Custom styled note content.
]
```

可覆盖参数：`kind`（`"note"` 或 `"caution"`）、`title`、`icon`、`bg`、`border`、`accent`

---

## 9. 表格组件

### `#tex-table`（学术风格，仅横线）

```typst
#tex-table(
  ("Header 1", "Header 2", "Header 3"),  // 表头行
  ([Cell $a$], [Cell $b$], [Cell $c$]),   // 数据行（含数学用中括号）
  ("Pure text", "Pure text", "Pure text"), // 纯文本行可用引号
)
```

### `#plain-table`（网格风格，完整表线）

```typst
#plain-table(
  ("Symbol", "Meaning", "Example"),
  ("$forall$", "for all", $forall x in A$),
)
```

### 关键规则

- 含数学公式的单元格 → 用 `[...]`
- 纯文本单元格 → 可用 `"..."`

---

## 10. 公式编号 `#eq`

```typst
#eq[$
  integral_0^infinity f(x) dif x = 1.
$]
```

- 编号格式：`(章号.公式序号)`
- 默认公式不编号，仅需要引用时使用 `#eq`

---

## 11. 行内高亮 `#highlight`

```typst
This is #highlight[important text] in a sentence.
```

---

## 12. 文件结构模板

### 完整的 `initial.typ` 骨架

```typst
#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Subject Name",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

#make-cover(
  "Subject Name",
  "Violet",
  subtitle: "A notebook for [topic]",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This is a notebook for [topic].",
)

#make-outline(depth: 2, title: "Contents")

#part("Part Title")

= Chapter Title
== Section Title

Content here.

#bibliography("references.bib")
```

---

## 13. 目录结构

每个笔记目录应维持：

```
Subject/
  initial.typ        # 主入口（唯一构建入口，所有内容写在此文件）
  references.bib     # 参考文献
  img/               # 图片资源
  tmp/               # 构建输出
```

---

## 14. 颜色系统（仅供参考，不要修改）

模板内置颜色变量，组件自动使用对应配色：

| 组件族 | 边框色 | 花色 |
|--------|--------|------|
| Theorem / Corollary / Lemma | 红色 `#C95A5A` | ♥ |
| Definition / Property | 绿色 `#4FA36A` | ♣ |
| Proposition / Example | 蓝色 `#4E77B7` | ♠ |
| Axiom / Postulate | 紫色 `#9B65C9` | ♦ |
| Note | 灰蓝 `#96A2B6` | — |
| Caution | 浅红 `#E39A9A` | — |

---

## 15. 单文件模式说明

当前项目统一使用单文件模式：所有内容直接写在 `initial.typ` 中。不再使用 `chapters/*.typ` 分文件方式。

如需导入外部包（如 `xarrow`），在 `initial.typ` 开头导入：

```typst
#import "../../TypstTemplate/math-notes.typ": *
#import "@preview/xarrow:0.4.0": xarrow
```

### 常用外部包

| 包名 | 用途 | 示例 |
|------|------|------|
| `@preview/xarrow:0.4.0` | 带标注的箭头 | `$f_n xarrow("a.e.") f$`、`$f_n xarrow(mu) f$` |

---

## 16. 禁止事项

1. **不要修改** `TypstTemplate/math-notes.typ` 的公共接口
2. **不要** 在笔记目录外创建包装目录（如 `src/`、`content/`）
3. **不要** 手动设置页面尺寸或页眉页脚（由 `apply-style` 统一管理）
4. **不要** 手动管理定理编号（由计数器自动处理）
5. **不要** 使用 `#outline()` 内置目录（使用 `#make-outline()` 代替）
6. **不要** 在 `initial.typ` 中重复章节文件已有的内容
