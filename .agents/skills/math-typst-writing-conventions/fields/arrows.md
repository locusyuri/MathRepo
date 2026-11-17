# 箭头（arrows.md）

写任何涉及**映射、极限趋向、逻辑蕴含、收敛**的箭头符号时加载本文件。

LaTeX 宏名在 Typst 数学模式中不存在，**一律不用 `\to`、`\rightarrow`、`\Rightarrow` 等**。行内占位、字体等通用规则见 [general.md](general.md)。

## 1. LaTeX → Typst 符号映射

| LaTeX | Typst | 用途 |
|-------|-------|------|
| `\to` / `\rightarrow` | `->` | 函数映射 / 趋向 |
| `\leftarrow` | `<-` | 反向 |
| `\leftrightarrow` | `<->` | 双向 |
| `\mapsto` | `\|->` | 元素映射（x 映到 f(x)） |
| `\Rightarrow` / `\implies` | `=>` | 蕴含 |
| `\Leftrightarrow` / `\iff` | `<=>` | 等价 |
| `\uparrow` | `arrow.t` | 上箭头 |
| `\downarrow` | `arrow.b` | 下箭头 |
| `⟵`/`⟶`（长箭头） | 用 `arrow.l` / `arrow.r`，或复合 | 长映射 |

## 2. Unicode 数学符号转换（箭头部分）

| Unicode | Typst | 正确示例 | 错误示例 |
|---------|-------|----------|----------|
| `→` | `->` | $x -> y$ | $x → y$ |
| `←` | `<-` | $x <- y$ | $x ← y$ |
| `⇒` | `=>` | $P => Q$ | $P ⇒ Q$ |
| `⇔` | `<=>` | $P <=> Q$ | $P ⇔ Q$ |
| `↦` | `\|->` | $x \|-> f(x)$ | $x ↦ f(x)$ |

**可以直接使用**：

| Unicode | 含义 | 示例 |
|---------|------|------|
| `↝` | 映射箭头（关系式 map） | $alpha ↝ beta$ |

## 3. 收敛箭头（xarrow 包）

分析笔记中带标注的收敛箭头使用 `@preview/xarrow:0.4.0` 包：

```typst
#import "@preview/xarrow:0.4.0": xarrow

// 几乎处处收敛
$f_n xarrow("a.e.") f$

// 依测度收敛
$f_n xarrow(mu) f$

// 几乎一致收敛
$f_n xarrow("a.u.") f$

// L^p 范数收敛
$f_n xarrow(L^p) f$
```

首次编译可能需下载 `@preview/xarrow` 包，稍慢。

## 4. 示例

```typst
// 函数映射
$f : X -> Y$
$x |-> f(x)$

// 逻辑蕴含与等价
$P => Q$
$P <=> Q$

// 趋向无穷（oo 见 calculus.md）
$x -> oo$

// 同构箭头（线性代数，见 linear-algebra.md 配合）
$V approx V'$
```

## 5. 规则要点

1. **箭头一律用 `->`/`=>`/`<=>`/`\|->` 等 Typst 语法**，不保留 LaTeX 宏名，也不用 Unicode `→⇒⇔`。
2. **`\mapsto` 对应 `\|->`**（注意反斜杠转义竖线）。
3. **带标注收敛箭头用 `xarrow`**，见 §3。
4. `↝`（映射箭头）可直接用 Unicode。