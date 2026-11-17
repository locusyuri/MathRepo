# 逻辑链路图模式

逻辑链路图是大纲的核心部分，展示知识点之间的依赖关系。本文件提供格式规范和实际示例。

---

## 1. 三类依赖

每章的逻辑链路必须标注三类依赖：

| 类型 | 含义 | 箭头方向 |
|------|------|---------|
| **向上** | 本章依赖前置章节的定义/定理 | 前置章节 → 本章 |
| **横向** | 本章各节之间的依赖 | §X.1 → §X.2 → ... |
| **向下** | 本章埋下的伏笔在后续章节兑现 | 本章 → 后续章节 |

## 2. 标注规范

- 所有引用必须使用**具体标签名**（如 `@thm:cif`），不要只写"Ch5 的定理"
- 承诺兑现用行号标注（如 `L536`），便于精确定位
- 向下链路标注消费方章节和标签

## 3. ASCII 图格式

### 3.1 向上依赖（列表式）

```
向上依赖:
  Ch2 @def:analytic/@eq:power-series-def ── L536/538 承诺"§7.2/§7.3 证明"
  Ch2 @def:exp-function (exp 已用 ratio test)
  Ch5 @thm:cif-derivatives ──► Taylor 系数公式
  Ch6 @thm:weierstrass + @cor:term-by-term ──► 逐项求导合法性
  Ch6 @ex:geometric-series ──► 幂级数原型
```

要点：
- 每行一个前置依赖
- `──►` 表示"被本章某处消费"
- 行号引用用 `L###` 格式

### 3.2 横向链路（流程图式）

```
横向链路:
  §7.1 复级数收敛(模) ──► 绝对收敛/重排 ──► §7.2 幂级数
                                              │ Cauchy-Hadamard (用 ratio/root)
                                              ▼
                                    Abel 定理: 内闭一致收敛
                                              │
                                    thm:power-series-diff (Weierstrass)
                                              │
              ┌───────────────────────────────┴───────────────┐
              ▼                                               ▼
   [兑现 analytic ⇒ holomorphic]                    §7.3 lem:geometric-kernel
   cor:power-coefficients                            (几何级数 + CIF)
   (c_n = f^(n)(z0)/n!)                                      │
              │                                    Taylor 定理 @thm:taylor
              └──────────────────────┬────────────────────────┘
                                     ▼
                     [兑现 holomorphic ⇒ analytic]
                     cor:holo-implies-analytic ── @thm:holo-equiv-analytic 闭环
```

要点：
- 用 `│` `▼` `┌` `└` `┴` 画分支
- 方括号 `[兑现 xxx]` 标注承诺兑现点
- 标签名直接写在组件旁边

### 3.3 向下依赖（列表式）

```
向下兑现:
  Ch8 Laurent: 幂级数内闭一致收敛 + 逐项积分 ──► 双边级数性质 (L1895-1905)
  Ch9 留数: Laurent 逐项积分 ──► Res(f, z0) = c_-1 (thm:residue-theorem 证明)
  Ch10 解析延拓 (L2157): 恒等定理 ──► 延拓唯一性
  Ch 整函数与亚纯函数 (L2169): Taylor 展开 + 孤立奇点分类基础
```

要点：
- 每行一个后续消费方
- 标注消费方将如何使用本章成果
- 如有行号引用，标注具体位置

---

## 4. 承诺追踪模式

### 4.1 埋下承诺

在前章写入时，某处需要但当前未证明的内容：

```
#note
注意：此处使用的"幂级数可逐项求导"将在 §7.2 中严格证明（@thm:power-series-diff）。
```

在大纲中记录：
```
| 埋下 | L536 | "§7.2 证明" — 幂级数逐项求导 | Ch7 §7.2 写入时兑现 |
```

### 4.2 兑现承诺

在后章写入时，兑现前章埋下的承诺：

```
// 兑现 Ch2 L536 的承诺：analytic ⇒ holomorphic
#theorem<cor:holo-implies-analytic>
...
```

在大纲中记录：
```
| 兑现 | Ch2 L536 | "§7.2/§7.3 证明" | 本节 <thm:xxx> 的证明 |
```

### 4.3 闭环标注

当一个等价性的两个方向都证明完毕，标注"闭环"：

```
cor:holo-implies-analytic ── @thm:holo-equiv-analytic 闭环
```

---

## 5. 常见模式

### 5.1 引理→定理→推论链

```
lem:geometric-kernel (核展开)
       │
       ▼
thm:taylor (Taylor 定理, 用 CIF + 引理)
       │
       ▼
cor:holo-implies-analytic (holo ⟺ analytic 闭环)
```

### 5.2 对偶结构

```
零点理论 (§7.4)                    奇点理论 (§8.3)
─────────────                    ─────────────
def:mth-order-zero    ◄──对偶──►  def:singularity-types
thm:zero-factorization ◄──对偶──►  thm:pole-criterion
thm:zeros-isolated    ◄──对偶──►  thm:removable-criterion
```

### 5.3 方法复用链

```
Ch4 幂积分 ∮(z-a)^(-n) 仅 n=1 非零 (@prop:common-integrals)
       │
       ├──► Ch8 Laurent 系数公式 (c_-1 的特殊地位)
       │         │
       │         └──► Ch9 留数 = c_-1 (@def:residue)
       │                    │
       │                    └──► Ch9 留数定理 (@thm:residue-theorem)
       │
       └──► Ch9 环绕数 Ind=1/0 (@def:winding-number)
```

### 5.4 多对一汇聚

多个前置知识汇聚到一个核心定理：

```
Ch5 @thm:cif          ──┐
Ch6 @thm:weierstrass   ──┤
Ch6 @cor:term-by-term  ──┼──► Ch7 thm:power-series-diff
Ch7 @lem:geom-kernel   ──┘        (逐项求导/积分)
```

---

## 6. 检查要点

- [ ] 向上依赖中每个标签都已在前章建立（Grep 验证）
- [ ] 横向链路无循环依赖
- [ ] 向下依赖中的行号引用准确
- [ ] 所有"兑现"标记都有对应的"埋下"标记
- [ ] 闭环标注的两个方向确实都已证明
