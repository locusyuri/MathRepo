---
name: typst-edit-consistency
description: 在编辑 Typst 数学笔记时，保持符号、风格、格式完全一致的原则
user_invocable: false
---

# Typst 编辑一致性技能

## 核心原则：风格不变、符号不变

当用户要求修改 Typst 数学笔记内容时，必须严格遵守以下原则：

### 1. 符号一致性（最高优先级）

**规则**：文档中已有的符号体系必须完全保留，不得更改。

**案例分析**：在 `Analyse Réelle/initial.typ` 中，用户原有内容使用：
- 全集：`$S$`
- 集类：`$cal(S)$`
- 集合元素：`$A, B, A_i$`

这些符号在文档后续内容中广泛使用（如 `Measurable Space` 使用 `(X, cal(S))`，`Measure` 使用 `cal(S)` 等）。

**错误示范**：
```typst
// ❌ 错误：将 S 改为 X，将 cal(S) 改为 cal(R)，将 A 改为 E
Let $X$ be a non-empty set. A non-empty collection $cal(R)$ of subsets of $X$...
for any $E_1, E_2 in cal(R)$...
```

**正确做法**：
```typst
// ✅ 正确：完全保留原有符号
Let $S$ be a non-empty set. A non-empty collection $cal(S)$ of subsets of $S$...
for any $A, B in cal(S)$...
```

### 2. 格式风格一致性

**规则**：保留原有的排版格式和写作风格。

**需要保留的元素**：
- 列表格式：`+` 开头的列表项
- 注释风格：`//` 开头的中文注释
- 句式结构：`Obviously, ...` 的总结句式
- 缩进风格：与原文档一致的缩进
- 标点符号：中英文标点的使用习惯

**案例分析**：
```typst
// 原有风格
#definition(name: "Algebra of Sets")[
  Let $S$ be a non-empty set. A non-empty collection $cal(S)$ of subsets of $S$...
    + $S subset cal(S)$;
    + If $A in cal(S)$, then $S backslash A in cal(S)$;
]
Obviously, an algebra of sets is closed under finite unions and finite intersections.
```

### 3. 内容扩展而非重写

**规则**：用户要求修改时，通常是在原有基础上扩展或修正，而不是完全重写。

**正确做法**：
- 保留原有定义的核心结构
- 在适当位置插入新内容
- 保持术语的一致性
- 不改变用户已经写好的部分

### 4. 上下文检查

**规则**：编辑前必须检查文档的上下文，确保符号与后续内容兼容。

**检查清单**：
1. 搜索文档中该符号的所有使用位置
2. 确认符号在后续定义、定理中的引用
3. 检查是否有交叉引用依赖该符号
4. 确保修改不会破坏文档的逻辑连贯性

### 5. 用户意图理解

**规则**：仔细阅读用户的修改要求，理解其真实意图。

**案例分析**：
- 用户说"把这里修改为'环与代数''sigma环与sigma代数'"——意思是扩展定义，不是重写
- 用户说"语言风格、符号等等不要大改"——明确要求保持原有风格
- 用户说"模仿现在的风格"——要求学习现有文档的写作模式

### 6. 错误纠正

**当发现错误时**：
1. 立即承认错误，不辩解
2. 分析错误原因（符号变更、风格不一致等）
3. 用正确的方式修正
4. 将教训记录到本技能中

---

## 调用方式

本技能由 AI 助手在编辑 Typst 文件时自动遵循，不需要用户显式触发。

## 相关技能

- `typst-compile`：编译验证 Typst 文件
- `typst-writing-conventions`：Typst 写作规范
- `code-reviewer`：跨文件代码审查