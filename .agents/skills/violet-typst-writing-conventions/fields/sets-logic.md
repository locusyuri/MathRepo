# 集合与逻辑（sets-logic.md）

写任何涉及**集合运算、量词、命题逻辑、集合构建**的公式时加载本文件。

属于/包含等**关系符号**（`in`、`subset` 等）见 [relations.md](relations.md)；箭头与量词搭配见 [arrows.md](arrows.md)。

## 1. LaTeX → Typst 符号映射

| LaTeX | Typst | 用途 |
|-------|-------|------|
| `\cup` | `union` | 并集 |
| `\cap` | `inter` | 交集 |
| `\setminus` | `backslash` | 差集 |
| `\varnothing` | `emptyset` | 空集 |
| `\forall` | `forall` | 全称量词 |
| `\exists` | `exists` | 存在量词 |
| `\nexists` | `exists.not` | 不存在 |
| `\land` | `and` | 逻辑与 |
| `\lor` | `or` | 逻辑或 |
| `\lnot` / `\neg` | `not` | 逻辑非 |
| `\chi_A` | `chi_A` | 指示/特征函数 |

## 2. Unicode 数学符号转换（集合逻辑部分）

**必须转换**：

| Unicode | Typst 函数 | 正确示例 | 错误示例 |
|---------|-----------|----------|----------|
| `∩` | `inter` | $A inter B$ | $A ∩ B$ |
| `∪` | `union` | $A union B$ | $A ∪ B$ |
| `∀` | `forall` | $forall x in X$ | $∀ x in X$ |
| `∃` | `exists` | $exists x$ | $∃ x$ |
| `∅` | `emptyset` | $emptyset$ | $∅$ |
| `∨` | `or` | $P or Q$ | $P ∨ Q$ |
| `∧` | `and` | $P and Q$ | $P ∧ Q$ |
| `¬` | `not` | $not P$ | $¬ P$ |

> 属于 `∈` / 子集 `⊂` 等关系符号见 relations.md，不在本文件。

## 3. 集合构造（描述法）

集合描述用冒号 `:`（**不用竖线**），且 `in` 里的冒号前后留空格：

```typst
// 正确 — 用冒号
${x in X : P(x)}$

// 竖线 / 反斜杠竖线是集合构建分隔符的写法，保留原样
${(x, y) \| x, y in bb(R)}$

// 错误 — 用竖线分隔
${x in X | P(x)}$
```

> 集合描述的竖线 `\|` 是保留的（见 general.md §7 非绝对值竖线）。只有"作为运算符/对象"的竖线才需要转换。

## 4. 指示/特征函数

```typst
$chi_A(x)$         // A 的指示函数
$chi_(A)(x)$       // 归一化写法（下标后用括号，见 general.md §3）
```

> `chi` 是单个字母变量，`A` 作为下标。若后接参数括号，下标需 `{}` 包裹（general.md §3）。

## 5. Unicode 汇总表（本文件全部）

| Unicode | 转换 | 含义 |
|---------|------|------|
| `∩` | `inter` | 交集 |
| `∪` | `union` | 并集 |
| `∅` | `emptyset` | 空集 |
| `∀` | `forall` | 全称 |
| `∃` | `exists` | 存在 |
| `∨` | `or` | 或 |
| `∧` | `and` | 与 |
| `¬` | `not` | 非 |