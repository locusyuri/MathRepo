# 关系符号（relations.md）

写任何涉及**等号、属于、包含、不等、比较、等价、同构**的公式前加载本文件。

本文件只覆盖"关系符号"的映射与写法；字体的引号/空格规则见 [general.md](general.md §4)，指标与其他家族的边界见 [README.md](README.md)。

## 1. LaTeX → Typst 符号映射

| LaTeX | Typst | 备注 |
|-------|-------|------|
| `\in` | `in` | 属于 |
| `\notin` | `in.not` | 不属于（**不是 `notin`**） |
| `\subset` | `subset` | 真子集 |
| `\subseteq` | `subset.eq` | 子集 |
| `\supset` | `supset` | 真超集 |
| `\supseteq` | `supset.eq` | 超集 |
| `\neq` | `!=` | 不等于（注意空格：`$a != b$`） |
| `\leq` | `<=` | 小于等于 |
| `\geq` | `>=` | 大于等于 |
| `\sim` | `~` | 相似 |
| `\approx` | `approx` | 约等于 |
| `\equiv` | `equiv` | 恒等/同余 |
| `\propto` | `prop` | 正比于 |
| `\preceq` | `prec.eq` | 前序偏序 |
| `\ll` | `<<` | 远小于 |
| `\gg` | `>>` | 远大于 |
| `\prec` | `prec` | 严格前序 |
| `\nleq / \ngeq` | `<=.not / >=.not` | 不小于/不大于（查阅官网确认） |

## 2. Unicode 数学符号转换（关系部分）

**必须转换**，写成 Unicode 会渲染异常或不符合仓库规范：

| Unicode | Typst 函数 | 正确示例 | 错误示例 |
|---------|-----------|----------|----------|
| `⊂` | `subset` | $A subset B$ | $A ⊂ B$ |
| `⊃` | `supset` | $A supset B$ | $A ⊃ B$ |
| `⊆` | `subset.eq` | $A subset.eq B$ | $A ⊆ B$ |
| `≠` | `!=` | $a != b$ | $a ≠ b$ |
| `≤` | `<=` | $a <= b$ | $a ≤ b$ |
| `≥` | `>=` | $a >= b$ | $a ≥ b$ |
| `∈` | `in` | $x in X$ | $x ∈ X$ |
| `∉` | `in.not` | $x in.not X$ | $x ∉ X$ |

**可以直接使用**（Typst 数学模式原生支持，渲染正确）：

| Unicode | 含义 | 示例 |
|---------|------|------|
| `≈` | 同构/等价 | $V ≈ V'$ |

`≅`（同构）等罕见关系符号查阅官网确认可用名称：https://typst.app/docs/reference/symbols/sym/

## 3. 示例

```typst
// 属于与不属于
$x in X$
$x in.not X$          // 不是 notin

// 子集连锁（统一 subset / subset.eq）
$A subset B subset.eq C$

// 不等式
$a != b$，$a <= b$，$a >= b$

// 等价 / 相似 / 约等于
$f equiv g$           // 恒等
$a ~ b$               // 相似
$x approx y$          // 约等于

// 正比于
$F prop m a$
```

## 4. 规则要点

1. **属于/不属于**：`in` / `in.not`；`notin` 不存在。
2. **子集**：统一 `subset`（真）与 `subset.eq`（含等）；不要写 Unicode。
3. **不等于**：`!=`；注意与相邻字符间留空格 `$a != b$`。
4. **`\ll`/`\gg`**：Typst 数学模式不识别这两个宏名，用 `<<` / `>>`。
5. **同构/等价**：`≈` 可直接用（Typst 原生支持），也可用 `approx`。