# 第 1 章「The Quantum Hypothesis // 能量子假说与玻尔模型」写作大纲

> 状态：正文已按本大纲写入 `6.Mathématiques appliquées/Mécanique quantique/initial.typ`（2026-11-23）。
> 四张配图已由同目录 `scripts/` 下的脚本生成（`blackbody-spectrum.svg`、`blackbody-classical.svg`、`photoelectric.svg`、`bohr-levels.svg`），脚本只输出 SVG，不生成 PNG。
> 任务类型：**A 类新章规划**（全书第一章，正文尚无任何内容）。
> 教材基线：李艳华、王新顺《大学物理教程（下册）》第 2 版，第 21.1 节（@li2026）。

## 零、章节定位与核心洞察

**章节定位**：全书开篇。把「经典物理为什么无法描述微观世界」讲成一条完整论证：黑体谱的紫外灾难 → 能量只能取分立值 → 光本身也是量子 → 原子能级只能分立 → 但 Bohr 的半经典图像无法自洽，必须换成波动方程。本章不解决任何量子力学计算问题，它的产出是**三个待解释的实验事实**（分立能级、波粒二象性、不确定关系中的前两个），供 Ch 2–Ch 5 逐一回答。

**核心洞察**：**旧量子论的每一次成功都来自「给经典理论强行加一条量子化条件」，而不是来自新的力学**。Planck 加 $E = n h nu$，Einstein 把量子推广到辐射场，Bohr 再加 $L = n planck$。三个假设各自有效却互不统属，且对氦原子立刻失效——这正是 Ch 2 物质波与 Ch 5 Schrödinger 方程的动机来源。

**规模**：正文约 600 行，3 节，约 30 个新标签（含 8 个编号公式），4 张图。

**与既有笔记的边界（SRP）**：

| 已有内容 | 位置 | 本章处理方式 |
|---|---|---|
| Planck 定律的推导（腔模计数 + 玻色统计） | `Thermodynamique` §17.1–17.2 | 只引用结论与两个经典极限，**不重推** |
| 黑体谱多温度曲线 | `Optique` §14.1（`fig:planck-spectrum`） | **不重复配图**；正文指向该图 |
| 光电效应装置细节与截止电压实验 | `Optique` §14.2（`law:photoelectric`, `ex:photoelectric-cutoff`） | 本章保留教材口径的四条实验规律 + 光电方程，装置细节指向 Optique |
| Compton 散射的四动量守恒推导 | `Optique` §14.3（`thm:compton-shift`） | 只给位移公式与物理结论，推导指向 Optique |
| 光子气体的统计力学（Stefan–Boltzmann、Wien、Rayleigh–Jeans 极限） | `Thermodynamique` §17.2 | 三个经验定律在本章以 `#law` 形式陈述，量级估计留在 Thermodynamique |
| 氢原子的严格解、$n^2$ 简并 | 本笔记 Ch 9（未写） | 本章只给 Bohr 结果并埋下「Ch 9 严格重现」的承诺 |
| 角动量的正确量子化 $l(l+1)planck^2$ | 本笔记 Ch 8（未写） | 本章只给 $L = n planck$，并注明其局限 |

## 一、结构方案

| 节 | 标题 | 预估行数 | 说明 |
|---|---|---|---|
| 章首 | Part I 导言 | ~30 | 「经典失效 → 量子化条件 → 需要新力学」三段式导航；声明全书约定 |
| §1.1 | Blackbody Radiation and Planck's Quantum Hypothesis // 黑体辐射与普朗克能量子假说 | ~130 | 黑体定义 + 三条经验定律 + 紫外灾难 + Planck 假设 + 两个极限 + 量级估计 |
| §1.2 | The Photoelectric Effect and Light Quanta // 光电效应与光量子 | ~120 | 四条实验规律 + 经典困难 + Einstein 假设 + 光电方程 + 测定 $h$ + Compton 与光子动量 |
| §1.3 | Atomic Spectra and Bohr's Model // 原子光谱与玻尔氢原子理论 | ~230 | 光谱系 + Rutherford 困难 + 三条假设 + 半径/能级/Rydberg 常数三条结论 + Franck–Hertz + 对应原理 + 旧量子论局限 |

**组织主线**：**现象（黑体谱）→ 最小假设（能量量子）→ 假设的推广（光量子）→ 假设的系统化（Bohr 三假设）→ 系统化的失败（局限）**。每一节都比上一节多加一条量子化条件，同时又暴露出上一节假设的不自洽，最终把读者逼到「必须有波动方程」这一步。

**节序决策**：教材顺序（21.1.1 → 21.1.2 → 21.1.3）保留不动。这三种历史顺序本身就是「量子化条件逐步加码」的逻辑，重排反而会破坏本章的叙事张力。

## 二、组件频率预估

| 组件类型 | 数量 | 标签清单 |
|---|---|---|
| `#definition` | 1 | `<def:blackbody>` |
| `#law` | 4 | `<law:kirchhoff>`, `<law:stefan-boltzmann>`, `<law:wien-displacement>`, `<law:photoelectric-effect>` |
| `#postulate` | 3 | `<post:planck-quantum>`, `<post:einstein-photon>`, `<post:bohr>` |
| `#theorem` | 3 | `<thm:compton-shift>`, `<thm:bohr-energy>`, `<thm:rydberg-constant>` |
| `#proposition` | 1 | `<prop:bohr-correspondence>` |
| `#example` | 5 | `<ex:planck-limits>`, `<ex:quantum-of-action>`, `<ex:millikan-h>`, `<ex:compton-mo>`, `<ex:hydrogen-ionization>` |
| `#caution` | 3 | 紫外灾难 / Rutherford 悖论 / 旧量子论局限（后两个带标签） |
| `#note` | ~8 | 跨笔记引用、前瞻承诺，无标签 |
| `#figure` | 4 | `<fig:blackbody-spectrum>`, `<fig:blackbody-classical>`（A 级）, `<fig:photoelectric>`（A 级，双面板）, `<fig:bohr-levels>`（A 级） |
| 编号公式 | 8 | 见 §七 |

三类「历史假设」统一用 `#postulate` 而非 `#theorem`，因为它们在本笔记的体系里**不被证明**，只被后续章节取代或被严格化。

## 三、各节知识点、组件与标签

### 章首导言（无编号，~30 行）

- 说明本章只提问题、不给方法；列出三个待解释事实（分立能级、波粒二象性、量子化条件的来源）。
- 说明阅读约定：本章 $h$ 与 $planck = h / (2 pi)$ 同时出现，Bohr 假设用 $planck$，光子能量用 $h nu$。
- `#note`：全章推导一律取 SI + 国际单位制数值，量级估计保留两位有效数字。

### §1.1 Blackbody Radiation and Planck's Quantum Hypothesis

| 内容 | 组件/标签 | 备注 |
|---|---|---|
| 热辐射、单色辐出度 $M_lambda$、吸收比、黑体模型 | `#definition` `<def:blackbody>` | 全书复用；后接「黑体即理想吸收体 = 理想发射体」的一句话论证 |
| 基尔霍夫辐射定律 | `#law` `<law:kirchhoff>` | 一句话结论；说明它只约束「发射/吸收比」而不给谱形 |
| Stefan–Boltzmann 定律 $M = sigma T^4$ | `#law` `<law:stefan-boltzmann>` | 回链 Thermodynamique §17.2；只陈述，不推导 |
| Wien 位移定律 $lambda_"max" T = b$ | `#law` `<law:wien-displacement>` | 同上；给出 $b = 2.898 times 10^(-3) "m" dot "K"$ |
| Rayleigh–Jeans 公式与紫外灾难 | `#caution` + `<eq:rayleigh-jeans>` | 经典失败的定量形式：$M_lambda prop T / lambda^4$；配 `#note` 说明「经典理论在长波端正确、短波端发散」 |
| Planck 能量子假设 | `#postulate` `<post:planck-quantum>` | 振子能量 $E = n h nu$；强调「能量交换以 $h nu$ 为单元」而非「能量连续」 |
| Planck 公式 | `<eq:planck-law>` | 编号公式；推导见 Optique §14.1 / Thermodynamique §17.1，本章只验证极限 |
| 两个经典极限 | `#example` `<ex:planck-limits>` | $h nu >> k T$ → Wien 公式；$h nu << k T$ → Rayleigh–Jeans；说明「经典理论是量子理论的低温/长波极限」 |
| 量子化的量级判据 | `#example` `<ex:quantum-of-action>` | 可见光 $h nu approx 2 "eV"$ vs 室温 $k T approx 0.026 "eV"$；解释宏观振子为何看不出分立 |

### §1.2 The Photoelectric Effect and Light Quanta

| 内容 | 组件/标签 | 备注 |
|---|---|---|
| 光电效应的四条实验规律 | `#law` `<law:photoelectric-effect>` | ① 存在截止电压 ② 截止电压随频率线性变化、与光强无关 ③ 存在红限频率 ④ 响应时间 $< 10^(-9) "s"$；装置细节指向 Optique §14.2 |
| 经典波动理论的三处失效 | `#caution`（无标签） | 逐条对位：能量积累需要时间、光强应决定初动能、任何频率都应能打出电子 |
| Einstein 光量子假设 | `#postulate` `<post:einstein-photon>` | 光的能量本身量子化（不只是吸收/发射过程）；回链 `@post:planck-quantum` |
| 光电方程 | `<eq:photoelectric>` | $h nu = W + E_k$；编号，后续 §1.2 与 Ch 21 引用 |
| 截止电压与频率的线性关系 | `<eq:stopping-potential>` | 由 `@eq:photoelectric` 直接得 $e U_0 = h nu - W$ |
| 测定 Planck 常数 | `#example` `<ex:millikan-h>` | 斜率法：$h = e dot (Delta U_0)/(Delta nu)$；数值 $6.63 times 10^(-34) "J" dot "s"$ |
| 光子动量与 Compton 位移 | `#note` + `<eq:compton-shift>` | 结论式 $Delta lambda = (h/(m_e c))(1 - cos theta)$；推导与实验见 Optique §14.3 |
| 光的波粒二象性小结 | `#note` | 埋下 Ch 2：若光兼具波粒，实物粒子是否亦然？ |

### §1.3 Atomic Spectra and Bohr's Model

| 内容 | 组件/标签 | 备注 |
|---|---|---|
| 氢原子光谱系与 Rydberg 公式 | `<eq:rydberg>` | Lyman/Balmer/Paschen 三系波长表（小表）；组合原理一句说明；$R_infinity = 1.097 times 10^7 "m"^(-1)$ |
| Rutherford 核式模型的两个困难 | `#caution` `<caution:rutherford-paradox>` | ① 加速电子辐射能量 → 坠核（$10^(-10) "s"$ 量级）② 连续辐射谱与分立线谱矛盾 |
| Bohr 三条假设 | `#postulate` `<post:bohr>` | 定态假设 + 频率条件 $h nu = E_(n_2) - E_(n_1)$ + 角动量量子化 $L = n planck$；逐条标注「哪一条是新的量子化条件」 |
| 轨道半径与速度 | `<eq:bohr-radius>` | 由 Coulomb 力 = 向心力 + `@post:bohr` 第三条得 $r_n = n^2 a_0$，$a_0 = 0.529 Å$ |
| 能级公式 | `#theorem` `<thm:bohr-energy>` | 结论 $E_n = -13.6 "eV"/n^2$；证明见 §六 |
| Rydberg 常数 | `#theorem` `<thm:rydberg-constant>` | 由 `@thm:bohr-energy` + 频率条件推出 `@eq:rydberg`，并给出 $R$ 的理论表达式与实验值比较 |
| 电离能与基态能量 | `#example` `<ex:hydrogen-ionization>` | 13.6 eV；与 $k T$（室温 0.026 eV）对比说明原子为何稳定 |
| 能级与跃迁图 | `#figure` `<fig:bohr-levels>` | A 级核心图，见 §八 |
| Franck–Hertz 实验 | `#note` | 用「4.9 eV 间隔的电流峰」验证分立能级；不配图（C 级） |
| 对应原理 | `#proposition` `<prop:bohr-correspondence>` | $n >> 1$、$Delta n = 1$ 时量子跃迁频率 → 经典轨道频率；证明见 §六 |
| 旧量子论的局限 | `#caution` `<caution:old-quantum-limits>` | ① 半经典混合图像（轨道 + 量子条件）逻辑不自洽 ② 无法处理氦（两电子）③ 无法解释谱线强度与选择定则 ④ 角动量量子化形式错误（应为 $l(l+1)planck^2$）；收尾一句「所以需要波动方程」→ Ch 2 |

## 四、逻辑链路图

**向上依赖**（外部笔记，非本文件标签）
```
Optique §14.1  def:planck-law / fig:planck-spectrum ──► §1.1 eq:planck-law（只引用，不重推）
Thermodynamique §17.1–17.2  光子气体 + 模式密度 ──► §1.1 三条经验定律的统计来源
Optique §14.2  law:photoelectric ──► §1.2 law:photoelectric-effect（取教材口径）
Optique §14.3  thm:compton-shift ──► §1.2 eq:compton-shift（只引用结论）
```

**横向链路**
```
§1.1 def:blackbody ─► law:kirchhoff ─► law:stefan-boltzmann ─► law:wien-displacement
                                          │
                     eq:rayleigh-jeans ───┴──► caution（紫外灾难）──► post:planck-quantum
                                                                          │
                                                        eq:planck-law ─► ex:planck-limits
                                                                     └─► ex:quantum-of-action
§1.2 law:photoelectric-effect ─► caution（经典失效）──► post:einstein-photon
        └─► eq:photoelectric ─► eq:stopping-potential ─► ex:millikan-h
        └─► eq:compton-shift（光子动量，旁支）
§1.3 eq:rydberg ─► caution:rutherford-paradox ─► post:bohr
                                                    ├─► eq:bohr-radius ─► thm:bohr-energy
                                                    │                        ├─► thm:rydberg-constant（回到 eq:rydberg）
                                                    │                        └─► ex:hydrogen-ionization
                                                    └─► prop:bohr-correspondence ─► caution:old-quantum-limits
```

**向下兑现**
```
post:planck-quantum ──► Ch 7 §7.3 谐振子 E_n = (n + 1/2)planck omega（对比 nh nu，零点能是差异）
post:bohr 的角动量条件 ──► Ch 8 §8.3 L^2 本征值 l(l+1)planck^2（纠正 n planck）
thm:bohr-energy ──► Ch 9 §9.3 氢原子严格解（重现 -13.6 eV/n^2 并给出 n^2 简并）
post:einstein-photon + eq:compton-shift ──► Ch 14 §14.5 Einstein 系数、Ch 21 激光
post:bohr 的「定态」──► Ch 4 §4.4 定态与时间演化、Ch 5 §5.1 定态方程
caution:old-quantum-limits ──► Ch 2 §2.1 de Broglie 物质波
```

## 五、承诺追踪

| 类型 | 位置 | 内容 | 处理 |
|---|---|---|---|
| 兑现（对外） | `Optique` 蓝图职责边界 | 「光的量子性 → Optique」 | 本章 §1.1–1.2 只引用不推导，**不越界** |
| 兑现（对内） | 本章 `#note`（§1.1） | 「Planck 公式的统计推导见 Thermodynamique §17.1」 | 只给结论，不补推导 |
| 埋下 | §1.3 `#note` | 「Bohr 能级将由 Ch 9 严格重现」 | Ch 9 §9.3 写入时兑现 |
| 埋下 | §1.3 `#note` | 「角动量量子化的正确形式见 Ch 8 §8.3」 | Ch 8 §8.3 写入时兑现 |
| 埋下 | §1.2 `#note` | 「实物粒子是否也具波动性？」 | Ch 2 §2.1 开头作为引子兑现 |
| 埋下 | §1.3 `#caution` | 「需要波动方程」 | Ch 2 末与 Ch 5 §5.1 兑现 |
| 闭环 | — | 本章无闭环任务 | — |

## 六、证明策略表

| 定理/命题 | 证明策略 | 关键工具 |
|---|---|---|
| `<thm:compton-shift>` | 能量守恒 + 两个方向的动量守恒 → 消去电子角度与速度 → 换成波长 | `@eq:photon-momentum`、Lorentz 因子 $gamma$ |
| `<thm:bohr-energy>` | Coulomb 力提供向心力 + 角动量量子化 $m v r = n planck$ → 解出 $v_n$、$r_n$ → 能量 $E = T + V$ 化到 `@eq:bohr-radius` | `@post:bohr`、`@eq:bohr-radius` |
| `<thm:rydberg-constant>` | 频率条件 $h c / lambda = E_(n_2) - E_(n_1)$ 代入 `@thm:bohr-energy` → 与 `@eq:rydberg` 比对系数 → 得 $R = m_e e^4 / (8 epsilon_0^2 h^3 c)$，代入数值 $1.097 times 10^7 "m"^(-1)$ | `@thm:bohr-energy`、`@eq:rydberg` |
| `<prop:bohr-correspondence>` | 取 $n >> 1$、$Delta n = 1$：$nu = (E_(n+1) - E_n)/h approx (1/h) dif E/(dif n)$；经典频率 $nu_"cl" = v_n / (2 pi r_n)$；两式化简相等 | `@thm:bohr-energy`、`@eq:bohr-radius` |

`<post:planck-quantum>`、`<post:einstein-photon>`、`<post:bohr>` 用的是「假设」框，不配证明；三条假设的**后果**才是定理。

## 七、公式编号规划

| 标签 | 公式 | 说明 |
|---|---|---|
| `<eq:rayleigh-jeans>` | $M_lambda = 2 pi c k T / lambda^4$ | 经典失败的标准形式，后文对比 Planck 公式 |
| `<eq:planck-law>` | $M_lambda = (2 pi h c^2)/(lambda^5) dot 1/(e^(h c \/ (lambda k T)) - 1)$ | 全书引用一次的基准式；推导指向 Optique |
| `<eq:photoelectric>` | $h nu = W + E_k$ | 光电方程，§1.2 与 Ch 21 引用 |
| `<eq:stopping-potential>` | $e U_0 = h nu - W$ | 线性关系的来源 |
| `<eq:compton-shift>` | $Delta lambda = (h/(m_e c))(1 - cos theta)$ | 只给结论式 |
| `<eq:rydberg>` | $1/lambda = R (1/n_1^2 - 1/n_2^2)$ | 经验公式，作为 `@thm:rydberg-constant` 的比对目标 |
| `<eq:bohr-radius>` | $r_n = n^2 a_0$，$a_0 = (4 pi epsilon_0 planck^2)/(m_e e^2)$ | Bohr 半径，Ch 9 复用作长度尺度 |
| `<eq:bohr-energy>` | $E_n = - (m_e e^4)/(8 epsilon_0^2 h^2) dot 1/n^2$ | 能级公式 |

其余公式（Stefan–Boltzmann、Wien、光速关系等）用行内数学，不编号。

## 八、图片规划

| # | 文件名 | 标签 | 内容 | 布局 | 优先级 |
|---|--------|------|------|------|--------|
| 1 | `blackbody-spectrum.svg` | `<fig:blackbody-spectrum>` | 1100 / 1300 / 1500 / 1700 K 四条 $M_lambda(lambda)$ 曲线（教材图 21-2），标出最高温曲线的 $lambda_m$ | 单面板 | **A 核心** |
| 2 | `blackbody-classical.svg` | `<fig:blackbody-classical>` | $T = 1646$ K：Planck（实线）、Wien（点划线）、Rayleigh–Jeans（虚线）与实验点（空心圆）对比（教材图 21-3） | 单面板 | **A 核心** |
| 3 | `photoelectric.svg` | `<fig:photoelectric>` | 双面板：(a) $I$–$U$ 曲线，同频双强度共用 $-U_0$，另加高频曲线；(b) $U_0$–$nu$ 直线，Cs/Na/Ca 三种金属共用斜率 $h/e$，标出红限 $nu_0 = W/h$（教材图 21-5、21-6） | 左右双面板 | **A 核心** |
| 4 | `bohr-levels.svg` | `<fig:bohr-levels>` | 氢原子能级 $n = 1..4$，Lyman / Balmer / Paschen 三组跃迁箭头与波长标注 | 单面板 | **A 核心** |

不画的图：

- 光电效应实验装置图（教材图 21-4）—— 文字可交代，装置细节不进入论证（C 级）。
- Franck–Hertz 曲线 —— 单个 I–V 峰列，文字可交代（C 级）。

绘图约定：脚本只写 SVG（`fig.savefig(OUT, format="svg")`），不生成 PNG。

## 九、参考资料对照

| 教材位置 | 教材内容 | 本章位置 | 差异与理由 |
|---|---|---|---|
| 21.1.1 | 黑体辐射、Planck 能量子假设 | §1.1 | 谱形推导指向 Optique/Thermodynamique；本章保留三条经验定律与紫外灾难的定量形式 |
| 21.1.2 | 光电效应、Einstein 光量子理论 | §1.2 | 保留教材四条实验规律与光电方程；补 Millikan 斜率法与 Compton 位移（教材放在本节末尾） |
| 21.1.3 | Bohr 氢原子理论 | §1.3 | 结构基本一致；补 Rutherford 悖论作为动机、补对应原理的定量证明、补旧量子论的四条局限（教材隐含未列） |

参考教材选择依据（用于后续章节的表述与习题口径）：@griffiths2018（Ch 1 的历史导言结构）、@eisberg1985（光谱与 Bohr 模型的实验细节）、@cohen1977（Bohr 对应原理的处理）。

## 十、写作顺序建议

1. 章首导言 + §1.1（`def:blackbody`、三条 `#law`、`#postulate` 首次使用、两个 `#example`）→ 编译验证
2. §1.2（`law:photoelectric-effect`、`#caution`、`#postulate`、两式 + `#example`）→ 编译验证
3. §1.3 上半（`eq:rydberg`、`#caution:rutherford-paradox`、`#postulate:bohr`、`eq:bohr-radius`）→ 编译验证
4. §1.3 下半（`thm:bohr-energy` + `thm:rydberg-constant` + `prop:bohr-correspondence` + `caution:old-quantum-limits`）→ 编译验证
5. 补两张图：`wiki/assets/null.svg` 占位 → `scripts/bohr-levels.py`、`scripts/photoelectric-iv.py` → `uv run` 生成 SVG → 编译验证

## 十一、需确认的决策点

1. **§1.1–§1.2 的深度**：A. 只给结论 + 交叉引用（推荐，与 Optique 不重复）；B. 自足完整推导（会与 Optique §14.1–14.3 大段重复）。
2. **三个 `#postulate` 是否分列**：A. Planck / Einstein / Bohr 各自独立（推荐，历史层次即教学层次）；B. 合并为一个「旧量子论假设」。
3. **配图数量**：A. 2 张（能级图 A 级 + 光电 I–U 曲线 B 级，推荐）；B. 仅 1 张能级图。
