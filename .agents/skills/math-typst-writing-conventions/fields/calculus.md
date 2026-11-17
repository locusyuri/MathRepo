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

## 3. 微分符号：`dif` 而非 `d`，且分数分子分母非单因子时必须加括号

任何涉及微分的分数写法（如 `dy/dx`、`d²y/dx²`）都必须用 `dif` 作为微分符号，且分子/分母是多字符结构（`dif y`、`dif x` 等）时必须各自加括号——见 [general.md §6.1](general.md)：

```typst
// ❌ 错误 — LaTeX 风格的 (d y) / (d x)
$#eq[$
  (d y) / (d x) = f(x, y),
$]$

// ❌ 错误 — dif y 不是单因子，不加括号会被 / 拆坏
$dif y / dif x = f(x, y)$
$dif^n y / dif x^n$

// ✅ 正确 — dif 正体 + 分子分母各自加括号
$(dif y) / (dif x) = f(x, y)$
$(dif^n y) / (dif x^n)$          // n 阶导数
$(dif^2 p) / (dif y^2)$          // 高阶微分
$(dif bold(Y)) / (dif x)$        // 向量值函数
$(dif) / (dif x)$                // 算子写法（纯算子也要加括号）
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
6. **导数记号分两种数学模式统一**（行内下标、行间分式），见下方 §9。

## 9. 导数记号两模式：行内下标、行间分式（2026-10-19 用户定稿）

Typst 与 LaTeX 一样有两种数学模式。**同一导数在两种模式下采用不同的统一记法**，全库一致执行：

### 9.1 行内（inline）：一律用下标形式，禁止 `partial_t u`

```typst
// ❌ 错误 — 行内使用算子形式
$partial_t u$
$partial_t phi(x, x)$
$partial_x F (u)$

// ✅ 正确 — 行内一律下标形式
$u_t$
$phi_t (x, x)$      // 注意：下标后紧接括号必须空一格，防止吞括号
$F (u)_x$           // 复合函数的导数也用下标
$(M_u)_t$           // 带下标的主体整体加括号再挂导数下标
$(u_epsilon)_t$
$u_(t t)$           // 二阶导
```

要点：
- 简单主体直接加导数下标：`u_t`、`v_x`、`w_s`、`E_t`、`rho'_t`；
- 主体本身带下标（`M_u`、`u_1`、`u_epsilon`、`w_i`）或为函数包装（`tilde(u)`、`bold(v)`）时，先保证主体完整再挂导数下标；
- **新下标后若紧跟 `(`，必须补一个空格**（`phi_t (x, x)`），否则括号被吞进下标（见 [general.md §3.2](general.md)）。

### 9.2 行间（display）：一律用分式形式，禁止 `partial_t (...)`

```typst
// ❌ 错误 — 行间使用算子下标形式
$partial_t u - Delta u = f$
$partial_t (t M_phi) = ...$
$u_t - a^2 Delta u = f$          // display 内也禁止下标简写

// ✅ 正确 — 行间一律分式（实际书写时置于独立的 display 块内）
$(partial u)/(partial t) - Delta u = f$
$(partial)/(partial t) (t M_phi (dot, x)) = ...$   // 纯算子作用于长表达式时，算子用分式
$(partial^2 u)/(partial t^2) - a^2 Delta u = f$
$(partial^2 u)/(partial x partial t)$              // 混合偏导
$(partial u_(n+1))/(partial t)$                    // 下标是迭代指标时随分子整体入分式
```

要点：
- 分式的分子/分母各为多字符整体，必须加括号（见 [general.md §6.1](general.md)）；
- display 内既有的下标简写（`u_t`、`u_(t t)`）同样要转为分式；
- **裸算子记法保留例外**：`partial_t - Delta_x`、`partial_t + Delta` 这类**未作用于具体函数的算子表达式**（热算子、波动算子）以及 Laplacian 算子定义 `sum_i partial_(x_i)^2`，保留 `partial_t` 算子形式，不强行转分式。

### 9.3 判定流程

写完或修改含导数的公式后自查两问：

1. 这段数学是行内还是行间？（`$` 独立成行/`#eq[$` 开头 = display；嵌在文字行内 = inline）
2. display 中的导数是否全部为分式？inline 中的导数是否全部为下标？裸算子（± Delta 组合、算子定义）除外。