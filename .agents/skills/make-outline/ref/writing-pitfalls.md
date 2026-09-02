# 写作陷阱与常见问题

从 Analyse Complexe Ch2-9 的写作过程中提炼的常见陷阱，分为 Typst 语法陷阱、内容组织陷阱和工程陷阱三类。

---

## 1. Typst 语法陷阱

### 1.1 `sqrt` 二参形式

**错误**：`sqrt(n, x)` 或 `sqrt(n, abs(x))` — 函数参数内的 `|` 解析出错。

**正确**：使用 `root(n, x)` 代替。

```typst
// 错误
$sqrt(n, abs(c_n))$

// 正确
$root(n, abs(c_n))$
```

**规则**：n 次根号统一用 `root(n, x)`，不用 `sqrt(n, x)`。

### 1.2 `name:` 参数中的数学内容

模板的定理类组件支持 `name:` 参数，但含数学内容的 name 可能引发解析问题。

**安全做法**：name 中的数学用 `$...$` 包裹，避免裸数学模式。

```typst
// 安全
#theorem(name: "Taylor 展开 $f(z) = sum c_n (z - z_0)^n$")
```

### 1.3 多字母变量

Typst 数学模式默认将连续字母视为单个变量名。

```typst
// 错误：limsup 被当作一个变量
$limsup_(n->oo)$

// 正确：使用 Typst 内置函数
$limsup_(n -> oo)$
```

常见多字母函数：`limsup`, `liminf`, `gcd`, `lcm`, `det`, `dim`, `ker`, `hom`, `deg`, `arg`, `Re`, `Im`。

### 1.4 集合差集

```typst
// 错误
$f \setminus g$

// 正确
$f backslash g$
```

### 1.5 分数与括号

分数中的分子/分母如果是多项式，必须加括号：

```typst
// 错误：只包裹了第一项
$1 / 1 + z$

// 正确
$1 / (1 + z)$
```

### 1.6 标签位置

标签必须紧跟在组件调用之后，不能隔行：

```typst
// 正确
#definition
$lim_(n->oo) a_n = L$
<def:limit>

// 错误：标签与组件之间隔了其他内容
#definition
$lim_(n->oo) a_n = L$

some text
<def:limit>
```

### 1.7 交叉引用在 context 元素中

模板的定理类组件是 context 元素，内部不能使用 `@label` 引用语法。

```typst
// 错误：context 元素内不可用 @
#theorem
由 @thm:cif 可得...

// 正确：使用 #link
#theorem
由 #link(<thm:cif>) 可得...
```

### 1.8 希腊字母与符号映射

```typst
// 常见错误 → 正确写法
\epsilon  →  epsilon       (或 varepsilon)
\phi      →  phi           (或 varphi)
\sigma    →  sigma
\to       →  arrow.r       (或 ->)
\infty    →  oo
\subset   →  subset        (真子集: subset.neq 或 subsetn)
\subseteq →  subset.eq
\emptyset →  emptyset
```

---

## 2. 内容组织陷阱

### 2.1 组件类型误用

| 误用 | 正确 | 说明 |
|------|------|------|
| `#theorem` 包裹定义 | `#definition` | 定义不是定理 |
| `#definition` 包裹定理 | `#theorem` | 定理不是定义 |
| `#theorem` 包裹命题 | `#proposition` | 重要性低于定理的用 proposition |
| prose 内容用组件 | `#note` 或直接 prose | 非正式陈述不要用编号组件 |

### 2.2 定义臃肿（违反 SRP）

一个 `#definition` 不应包含多个独立概念。

```typst
// 错误：一个定义包含两个概念
#definition
*孤立奇点*：...
*主要部分*：...

// 正确：拆分为两个定义
#definition <def:isolated-singularity>
孤立奇点：...

#definition <def:principal-part>
主要部分：...
```

### 2.3 证明重复

同一事实在不同章节重复证明。

**解决**：在第一次出现时完整证明，后续引用。大纲阶段用承诺追踪标记。

### 2.4 标签命名冲突

新标签与已有标签同名但含义不同。

**预防**：规划阶段 Grep 验证标签唯一性。

### 2.5 逻辑漏洞

定理陈述在某种边界条件下前提为空，导致定理虽然"正确"但表述不自然。

> 例：原骨架"Uniqueness of Zeros"的表述在某条件下前提集合为空，
> 改为标准的恒等定理 + 唯一性推论。

### 2.6 符号混用

同一证明中积分变量与自由变量使用相同字母。

```typst
// 错误：z 同时是积分变量和自由变量
$f(z) = 1/(2 pi i) oint_(C) f(z) / (z - z_0) dz$

// 正确：用 ζ 区分积分变量
$f(z) = 1/(2 pi i) oint_(C) f(zeta) / (zeta - z) d zeta$
```

---

## 3. 工程陷阱

### 3.1 并行编辑竞态

同时对同一文件发起多个 Edit 调用时，格式化钩子（hook）可能在编辑之间运行，导致后续编辑基于过时内容而失败或被覆盖。

**预防**：
- 对同一文件的编辑**串行执行**，不要并行
- 如果必须批量替换（如将所有 `@ref` 改为 `#link`），使用 `allow_multiple: true` 的单次 Edit
- 编辑后检查实际文件状态，不要假设编辑成功

### 3.2 分批编译策略

- 每 1-2 节编译一次，比全文写完再编译更容易定位错误
- 编译命令：`typst compile "<subject>/initial.typ" "<subject>/initial.pdf" --root .`
- 以退出码 0 为完成标准

### 3.3 格式化钩子行为

项目的 pre-save hook 会自动格式化 Typst 代码，可能导致：
- 行尾注释被移入组件体内
- 空行被增删
- 缩进被调整

这些行为是**正常的**（功能无害），但会在 `git diff` 中产生额外变更。

### 3.4 图片占位工作流

1. 规划阶段确定图片清单
2. 写作时用 `0.Wiki/null.svg` 复制到 `img/xxx.svg` 占位
3. 编译通过后，统一输出图片提示词
4. 用户用 AI 生成图片后替换占位文件

### 3.5 大规模替换的安全做法

需要全文替换某种模式（如 `@label` → `#link(<label>)`）时：

1. 先用 Grep 统计匹配数量和位置
2. 用单次 `allow_multiple: true` 的 Edit 替换
3. 替换后重新 Grep 确认无残留
4. 编译验证

避免多次单独 Edit 同一文件的替换操作。
