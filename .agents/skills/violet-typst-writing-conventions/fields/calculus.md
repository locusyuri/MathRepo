# 微积分/分析（calculus.md）

写任何涉及**积分、导数、极限、微分、无穷、函数空间**的公式时加载本文件。

通用括号/下标/多字母规则见 [general.md](general.md)；收敛箭头见 [arrows.md](arrows.md)。

## 1. LaTeX → Typst 符号映射

| LaTeX | Typst | 用途 |
|-------|-------|------|
| `\int` | `integral` | 积分（**不是 `int`**） |
| `\iint` | `integral.double` | 二重积分 |
| `\iiint` | `integral.triple` | 三重积分 |
| `\oint` | `integral.cont` | 闭合环路线积分 |
| `\partial` | `partial` | 偏导 |
| `\mathrm{d}x` | `dif x` | 微分（正体 `dif`） |
| `\nabla` | `nabla` | 梯度/向量微分算子 |
| `\lim` | `lim` | 极限 |
| `\liminf` | `liminf` | 下极限 |
| `\limsup` | `limsup` | 上极限 |
| `\sup` | `sup` | 上确界 |
| `\inf` | `inf` | 下确界 |
| `\infty` | `oo` | 无穷 |

## 2. Unicode 数学符号转换（微积分部分）

**可以直接使用**：

| Unicode | 含义 | 示例 |
|---------|------|------|
| `∂` | **禁止**——渲染数学中一律用 `partial`（见下方规则 4） | — |
| `∫` | 建议 `integral` | — |

> `∞`（无穷）**必须**用 `oo`，写成 Unicode `∞` 不符合规范。

## 3. 微分符号：`dif` 而非 `(d ...) / (d ...)`

任何涉及微分的分数写法（如 `dy/dx`、`d²y/dx²`）都必须用 `dif`：

```typst
// ❌ 错误 — LaTeX 风格的 (d y) / (d x)
$#eq[$
  (d y) / (d x) = f(x, y),
$]$

// ✅ 正确 — dif
$dif y / dif x = f(x, y)$
$dif^n y / dif x^n$          // n 阶导数
$dif^2 p / dif y^2$          // 高阶微分
$dif bold(Y) / dif x$        // 向量值函数
$dif / dif x$                // 算子写法
```

## 4. 积分写法

### 4.1 `int` → `integral` 遗忘

LaTeX 习惯用 `\int`，Typst 必须写 `integral`。`int` 是未知变量，会报错。

```typst
// 错误
$int_0^1 f(x) dif x$

// 正确
$integral_0^1 f(x) dif x$

// 二重积分
$integral.double_S f dif S$

// 闭合曲面积分（无 oint 符号）
$integral_(partial V) bold(E) dot dif bold(S)$
```

### 4.2 积分记号惯例

```typst
// 基本积分
$integral_X f dif mu$

// 集合上的积分
$integral_A f dif mu$
$integral_(E_n) f dif mu$

// 集合描述作为积分下标（注意花括号）
$integral_({|f| > M}) |f| dif mu$
$integral_({x in X : f(x) >= epsilon}) f dif mu$

// 上确界/下确界带下标
$sup_(s <= f) integral_X s dif mu$
$liminf_(n->oo) integral_X f_n dif mu$
```

规则：
- 积分微元用正体：`$integral_X f dif mu$`
- 积分区域用下标：`$integral_A f dif mu$`、`$integral_(E_n) f dif mu$`
- 集合上的积分限制：`$integral_({|f| > M}) |f| dif mu$`（注意花括号内的集合描述）

## 5. 非标准符号的等价表达

| 意图 | LaTeX | Typst |
|------|-------|-------|
| 拉普拉斯算子 | `\laplacian V = 0` | `nabla^2 V = 0` |
| 闭合环路线积分 | `\oint_sigma bold(f) dot d bold(l)` | `integral.cont_sigma bold(f) dot d bold(l)` |
| 闭合曲面积分 | `\oint_sigma dif a` | `integral_(partial sigma) dif a` 或 `integral_sigma dif a` |

`\laplacian`、`\oint` 等非标准 LaTeX 宏在 Typst 中不存在，必须用等价表达。

## 6. 导数点记号

```typst
$dot(x)$           // x'
$dot.double(x)$    // x''
$dot.triple(x)$    // x'''
```

时间导数、一阶/二阶/三阶都用 `dot` / `dot.double` / `dot.triple`。

## 7. 函数空间记号（分析风格）

```typst
// L^p 空间（空格分隔参数）
$L^1 (X, mu)$

// 几乎处处
文本中写 `a.e.`，公式中写 `"a.e."`
```

## 8. 规则要点

1. **积分一律 `integral`**，`int` 不存在；多重积分用 `integral.double` / `integral.triple` / `integral.cont`。
2. **微分用正体 `dif`**，如 `dif x`、`dif mu`。
3. **无穷用 `oo`**，不是 `infty`、`infinity`、`∞`。
4. **偏导一律用 `partial`**，**禁止**在渲染数学中直接使用 Unicode `∂`；含下标的偏导整体按"先组内配对、再挂下标"写：`((partial U)/(partial T))_V`，见 [general.md §6.1](general.md)。
5. 拉普拉斯算子写 `nabla^2 V`，闭合积分写 `integral.cont` / `integral_(partial sigma)`，无 `oint` 符号。