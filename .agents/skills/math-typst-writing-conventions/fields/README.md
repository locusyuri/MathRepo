# fields/ — 写作规范分领域索引

主文件 `SKILL.md` 只保留**通用硬规则**，领域特定的符号/记号/陷阱按"符号家族"拆分到本目录，各文件按需加载。

## 为什么按符号家族分，而不是按学科

Typst 的符号错误是**跨学科**的：`≠ → !=` 在分析、代数、逻辑里都一样。若按数学领域分文件（analysis/algebra/geometry），写一类符号时往往要翻多个文件；按符号家族分，写哪一类符号就加载哪一个文件，命中直接。

唯一例外是**对象级构造**（如 `mat()`/行列式）：它们不是单个符号的映射，而是多字符语法，按对象归入 `linear-algebra.md`。

## 划分原则

1. **按符号家族分**：一个文件 = 一组"书写时常连用、映射规则同源"的符号。
2. **一符号一居所**：每个符号只进一个文件，归属由其**最常出现的书写语境**决定。例如 `∈` 属于集合论，但书写时是关系，入 `relations.md`。
3. **语法型构造单列**：不映射到单一符号的写法（`mat()`、行列式、范数）按对象归入 `linear-algebra.md` —— 这是唯一例外。
4. **通用硬规则不分流**：多字母变量、分数括号、下标吞括号、`abs()`、标点、`cases()` 留在 `general.md`，因为任何领域都会犯。
5. **交叉符号引用不复制**：规则本体只写一遍，他处引用（如 `calculus.md` 引用范数写法）。

## 文件与符号路由

| 文件 | 覆盖的符号/记号 | 典型场景 |
|------|---------------|----------|
| [general.md](general.md) | 通用硬规则：下标、多字母变量、分数括号、`abs()`、`root()`、标点、`cases()`、字体命令、常用运算符（`dot`/`times`/`compose`/`±`）、LaTeX 残留扫描 | 一切数学笔记的基座，**始终加载** |
| [relations.md](relations.md) | 关系符号：`=`、`∈`（`in`）、子集（`subset`）、`!=`、`<=`、`>=`、`~`/`approx`、`equiv`、`prop`、`prec.eq`、`<<`/`>>`、`≈` | 等式/不等式/包含/等价比较 |
| [arrows.md](arrows.md) | 箭头：`->`、`<-`、`<->`、`=>`、`<=>`、`\|->`、`↝`、`xarrow` 收敛箭头 | 映射/极限/收敛 |
| [sets-logic.md](sets-logic.md) | 集合与逻辑：`union`、`inter`、`setminus`、`emptyset`、集合描述 `${x in X : P(x)}`、`forall`、`exists`、`and`、`or`、`not`、`chi_A` | 集合运算、量词、命题 |
| [calculus.md](calculus.md) | 微积分/分析：`integral` 家族、`partial`、`dif`、`nabla`、导数点 `dot(x)`、`lim`/`limsup`/`liminf`/`sup`/`inf`、`oo`、积分记号惯例、`L^p` 等函数空间记号 | 积分/导数/极限 |
| [linear-algebra.md](linear-algebra.md) | 矩阵对象：`mat()`、行列式 `"det"(A)`、范数 `\|\|...\|\|`、内积 `(·,·)`、`†`、`⊕`、`⊗`、`⊥` | 矩阵/向量空间/张量 |

① `geometry`/`statistics`/`applied` 未建文件——等对应科目开始迁移、出现新的符号家族时再建。

## 科目 → 建议加载组合

写某一科笔记前，从下表中取"始终加载 `general.md` + 该科涉及的 family 文件"：

| 科目 | 追加加载 |
|------|---------|
| 线性代数 / 抽象代数 | `linear-algebra.md`、`relations.md`、`arrows.md`、`sets-logic.md` |
| (数学)分析 / 实分析 / 复分析 / 泛函 / 方程 | `calculus.md`、`relations.md`、`arrows.md`、`sets-logic.md` |
| 几何 / 拓扑 | `relations.md`、`sets-logic.md`、`arrows.md`、`calculus.md` |
| 离散数学 / 逻辑 / 集合论 / 组合 / 图论 | `sets-logic.md`、`arrows.md`、`relations.md` |
| 概率 / 随机过程 | `calculus.md`、`relations.md`（期望/概率记号待建 `probability.md`） |

## 如何新增/修改

- 新增符号：先查它属于哪个 family，写入对应文件，并在上表同步。
- 新增 family：当一批符号"书写时常连用且不属于现有 family"时新建文件，在 README 索引表补一行，并说明它与相邻文件的边界。
- 修改后编译验证对应 `initial.typ`，退出码 0 才算完成。