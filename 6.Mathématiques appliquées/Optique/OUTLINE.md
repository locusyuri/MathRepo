# Optique — Part III Wave Optics (波动光学) 写作大纲

> 状态：大纲已定稿（2026-10-15），正文已按 2026-10-21 审查意见修订。决策记录：① 维持蓝图"理论框架先行"顺序（Born & Wolf 式）；
> ② Ch 11 傅里叶光学完整 5 节；③ 配图 8 张核心（A 级），B 级图不制作；
> ④ Ch 10 拆为 5 节（单缝 / 圆孔 / 光栅 / 分辨极限），Ch 12 与 Ch 13 互换，Part III 以"矢量性回归"收束；
> ⑤ Ch 8 改为"格林函数先于衍射积分"。
> 前置：Part I（Ch 1-4，振动与波动力学，2026-10-22 起并入分析力学的弹性波章并扩容至 943 行）、
> Part II（Ch 5-7 几何光学）已写入并编译通过。

## 零、Part 定位与核心洞察

- **定位**：波动光学是本笔记的**本体理论**，体量最大。以"Helmholtz 方程 + 格林函数"（Ch 8）为统一框架，
  依次展开干涉与相干（Ch 9）、衍射应用（Ch 10）、傅里叶光学（Ch 11）、偏振（Ch 12）、介质传播（Ch 13）。
- **核心洞察**：衍射积分的三个渐近层——格林函数精确解（Ch 8）→ 菲涅耳/夫琅禾费近似（Ch 10）→
  透镜实现的傅里叶变换（Ch 11）——是同一条数学链；干涉是其特例，分辨极限是必然推论，偏振是矢量性的回归。
- **实际规模**：932 行（Part III 正文），6 章 29 节，56 个标签，8 张配图。

## 一、章节结构与定位

| 章 | 标题 | 节数 | 角色 |
|---|---|---|---|
| Ch 8 | Scalar Diffraction Theory // 标量衍射理论 | 4 | 统一理论框架（格林函数先行，再推衍射积分） |
| Ch 9 | Interference and Coherence // 干涉与相干性 | 6 | 两束/多束叠加 → 统计相干 |
| Ch 10 | Diffraction: Approximations and Applications // 衍射：近似与应用 | 5 | 菲涅耳/夫琅禾费近似与应用 |
| Ch 11 | Fourier Optics // 傅里叶光学 | 5 | 透镜=光学傅里叶变换器，空间滤波系统 |
| Ch 12 | Propagation in Media // 介质中的传播 | 3 | 色散/吸收、因果性、散射 |
| Ch 13 | Polarization // 偏振 | 6 | 标量→矢量回归，琼斯/缪勒代数（Part III 收束） |

## 二、组件频率（全书实况，2026-10-21 统计）

| 组件 | 数量 |
|---|---|
| `#definition` | 82 |
| `#theorem` | 24（其中 18 条带 `#proof`） |
| `#law` | 6 |
| `#example` | 28 |
| `#figure` | 21（Part III 占 8 张） |
| `#note` | 63 |

## 三、标签系统（写作清单）

### Ch 8
- `def:scalar-field`（标量近似/边界条件，回链 `def:helmholtz`）
- `def:huygens-fresnel`（惠更斯-菲涅耳原理）
- `def:green-diffraction`（自由空间格林函数，8.3 先行，兑现 Ch 5.5 倏逝波）
- `thm:kirchhoff-integral`（基尔霍夫积分，格林第二恒等式证明）
- `thm:rayleigh-sommerfeld`（RS 积分，镜像格林函数证明）
- `eq:kirchhoff`、`eq:rs`、`eq:green-freespace`
- `fig:huygens-fresnel`（A 级）

### Ch 9
- `def:optical-path-difference`、`ex:young-fringes`（杨氏双缝）
- `def:fringe-visibility`（可见度）
- `ex:newton-rings`（薄膜/牛顿环）
- `thm:airy-function` + `eq:airy`（多光束级数求和）；`ex:fabry-perot-resolution`
- `def:coherence-time-length`、`def:spatial-coherence`（埋线 → Ch 17）
- `def:complex-coherence-degree` + `eq:coherence-length`
- `fig:young-double-slit`（A 级）

### Ch 10
- `def:fresnel-approximation`、`def:fresnel-integral`（菲涅耳积分/波带片）
- `def:fraunhofer-approximation`（远场条件 z ≫ a²/λ）
- `thm:fraunhofer-single-slit` + `eq:fraunhofer-single-slit`（sinc²）
- `thm:airy-pattern` + `eq:airy-pattern`（贝塞尔积分）；`ex:airy-disc-diameter`
- `def:grating-equation`、`thm:grating-resolution` + `eq:grating`（λ/Δλ = mN）；`ex:grating-spectral-resolution`
- `def:rayleigh-criterion`、`def:abbe-limit`（兑现 Ch 7.3）
- `fig:fraunhofer-patterns`（A 级）、`fig:resolution-criterion`（A 级）

### Ch 11
- `thm:lens-fourier-transform` + `eq:lens-ft`（透镜相位因子 + 两次菲涅耳传播）
- `def:pupil-function`（光瞳）
- `ex:4f-spatial-filtering`（空间滤波）
- `def:psf-otf`、`def:coherent-transfer-function` + `eq:psf-otf`
- `def:holography`（全息，简要）
- `fig:lens-fourier`（A 级）

### Ch 12
- `def:lorentz-oscillator`、`def:complex-refractive-index` + `eq:lorentz-dielectric`（兑现 Ch 7.2）
- `thm:kramers-kronig` + `eq:kk`（因果性 + 上半平面解析性）
- `law:rayleigh-scattering` + `eq:rayleigh-cross-section`、`def:mie-scattering`、`ex:sky-color`
- `fig:dispersion-curves`、`fig:rayleigh-scattering`（A 级）

### Ch 13
- `def:polarization-state`（兑现 Ch 4.3 矢量性回归）
- `def:jones-vector`、`def:jones-matrix` + `eq:jones-propagation`
- `def:stokes-parameters`、`def:mueller-matrix` + `eq:stokes`
- `law:malus` + `eq:malus`
- `def:birefringence`、`def:wave-plate`、`ex:quarter-wave-plate`
- `def:brewster-angle`、`ex:brewster-reflection`
- `def:optical-activity`（简要，埋线 → Part IV Ch 15/16）
- `fig:polarization-ellipse`（A 级）

## 四、逻辑链路

```
Ch 4 亥姆霍兹+角谱 ──► Ch 8 格林函数→衍射积分 ──► Ch 9 干涉/相干 ──► Ch 10 菲涅耳/夫琅禾费
        ▲                                                          │
        └──────────── Ch 11 透镜=FT ◄───────── 夫琅禾费(孔径FT) ────┘
                                                                    │
                                                     Ch 12 介质传播（回指 Ch 3 色散/群速）
                                                                    │
                                                     Ch 13 偏振（矢量回归，收束 Part III）
                                                                    │
                                     Part IV：相干态/关联函数（Ch 17 兑现 Ch 9 埋线）
```

## 五、承诺追踪

| 类型 | 位置 | 内容 | 处理 |
|---|---|---|---|
| 兑现 | Ch 4 | 衍射积分 = 角谱的远场评估 | Ch 8.3 + Ch 8.4 |
| 兑现 | Ch 4.4 | 倏逝波区分重现于 Ch 10/11 | Ch 10.5 + Ch 11.4 |
| 兑现 | Ch 5.5 | 倏逝波全波描述回到 Part III | Ch 8.3 |
| 兑现 | Ch 7.2 | 色散 n(λ) 属于 Part III | Ch 12.1 |
| 兑现 | Ch 7.3 | 衍射极限在 Ch 10 发展 | Ch 10.5 |
| 兑现 | Ch 7.5 | 光纤模式属 Part III | Ch 8.3（圆柱对称 note） |
| 兑现 | Ch 4.3 | 矢量性在 Ch 13 回归 | Ch 13.1 |
| 埋下 | Ch 9.5 / 13.6 | 相干函数/偏振量子态 → Part IV | Ch 17 / Ch 15 |

## 六、证明策略

| 定理 | 策略 | 关键工具 |
|---|---|---|
| `thm:kirchhoff-integral` | 格林第二恒等式 + 自由空间格林函数 + Kirchhoff 边界条件 | `def:green-diffraction` |
| `thm:rayleigh-sommerfeld` | 镜像格林函数（偶/奇） | `def:green-diffraction` |
| `thm:airy-function` | N 束复振幅等比级数 → 取模平方 | `def:time-harmonic` |
| `thm:fraunhofer-single-slit` | 矩形孔径 FT → sinc² | `thm:rayleigh-sommerfeld` |
| `thm:airy-pattern` | 圆孔 FT：贝塞尔函数积分 | `def:fraunhofer-approximation` |
| `thm:grating-resolution` | 主极大 + 最近零（mN） | `thm:airy-function` |
| `thm:lens-fourier-transform` | 透镜相位因子 + 前后两次菲涅耳传播 | `def:fresnel-approximation` |
| `thm:kramers-kronig` | χ(ω) 上半平面解析 + 柯西主值 | Analyse Complexe |

## 七、编号公式

`eq:kirchhoff`、`eq:rs`、`eq:green-freespace`、`eq:airy`、`eq:coherence-length`、`eq:fraunhofer-single-slit`、
`eq:airy-pattern`、`eq:grating`、`eq:lens-ft`、`eq:psf-otf`、`eq:jones-propagation`、`eq:stokes`、`eq:malus`、
`eq:lorentz-dielectric`、`eq:kk`、`eq:rayleigh-cross-section` —— 共 16 个。

## 八、图片规划（8 张核心）

| 文件 | 标签 | 内容 | 优先级 |
|---|---|---|---|
| huygens-fresnel.svg | `fig:huygens-fresnel` | 次级子波包络构造新波前 | A |
| young-double-slit.svg | `fig:young-double-slit` | 双缝几何 + 条纹强度分布 | A |
| fraunhofer-patterns.svg | `fig:fraunhofer-patterns` | 单缝/双缝/圆孔花样并排 | A |
| resolution-criterion.svg | `fig:resolution-criterion` | 两艾里斑瑞利叠加三态 | A |
| lens-fourier.svg | `fig:lens-fourier` | 2f 系统傅里叶变换 | A |
| polarization-ellipse.svg | `fig:polarization-ellipse` | 偏振椭圆（相位差 0/π/2 演变） | A |
| dispersion-curves.svg | `fig:dispersion-curves` | 正常/反常色散 n(ω) | A |
| rayleigh-scattering.svg | `fig:rayleigh-scattering` | λ⁻⁴ 散射强度随波长变化 | A |

（B 级 fabry-perot、spatial-filtering、poincare-sphere 不制作。）

## 九、写作顺序

Ch 8 → 9 → 10 → 11 → 12（介质）→ 13（偏振）；章内"定义 → 定理 → 例题 → note"，每写完 1–2 节编译一次。
完成后：更新蓝图注释（Part III 设计思路 + Structure Note 标注"正文已写入"）→ 逐页 PDF 预览 → 提交。

---

# Optique — Part IV Quantum Optics (量子光学) 写作大纲

> 状态：大纲已定稿（2026-10-15）。决策记录：① Ch 15 场量子化取**单模完整推导 + 多模简述**（连续场
> 量子场论式推导不做，避免与 Mécanique quantique 重复）；② Ch 18.4 半经典激光理论**保留精简版**
> （速率方程 + 阈值条件，支撑 Ch 19.1 激光器）；③ 配图 **4 张 A 级核心图**，B 级不制作。
> 前置：Part I-III 全部写入并编译通过；Mécanique quantique（希尔伯特空间/算符/谐振子）提供形式体系
> （该笔记目前为空壳，故 Part IV 在 15.2 自足引入算符与对易子，不依赖其正文）。

## 零、Part 定位与核心洞察

- **定位**：整书主线最后一段"场的量子化"。旧量子论三实验（Ch 14）确立光的粒子性动机 →
  场的正则量子化（Ch 15）→ 量子态与相空间（Ch 16）→ 测量统计（Ch 17）→ 光与物质（Ch 18）→
  应用与前沿导论（Ch 19）。Ch 14 桥接章、Ch 19 导论章。
- **核心洞察**：经典波动光学（Part III）量子化后成为自洽图像——每个场模是一个谐振子（Ch 15）；
  相干态是量子场中最接近经典波的状态（Ch 16）；一阶关联是干涉、二阶关联是强度统计，g⁽²⁾ 区分
  经典光与量子光（Ch 17）；自发辐射不是原子的内禀过程而是真空场的受激发射（Ch 18）。
- **实际规模**：656 行，6 章 24 节，4 张配图（`planck-spectrum`、`wigner-function`、`hbt-experiment`、`rabi-oscillation`）。

## 一、章节结构与定位

| 章 | 标题 | 节数 | 角色 |
|---|---|---|---|
| Ch 14 | Old Quantum Theory of Light // 光的旧量子论 | 4 | 桥接章：粒子性动机 |
| Ch 15 | Quantization of the EM Field // 电磁场量子化 | 4 | 核心第一章：场=谐振子集合 |
| Ch 16 | Coherent and Squeezed States // 相干态与压缩态 | 4 | 量子态工具箱（连接经典波） |
| Ch 17 | Photon Statistics and Correlation Functions // 光子统计与关联函数 | 4 | 测量统计（兑现 Ch 9.6 承诺） |
| Ch 18 | Light-Matter Interaction // 光与物质相互作用 | 4 | Rabi/自发辐射/JC/激光速率方程 |
| Ch 19 | Applications and Frontiers // 应用与前沿 | 4 | 导论章：激光/QKD/纠缠/SPDC |

## 二、组件频率预估

| 组件 | 实况 |
|---|---|
| `#definition` | 24 |
| `#theorem` | 10（5 条带证明） |
| `#law` | 1（光电效应） |
| `#example` | 9 |
| `#figure` | 4 |
| `#note` | 20 |

## 三、标签系统（写作清单）

- **Ch 14**：`def:planck-law` `thm:planck-derivation` `law:photoelectric` `thm:compton-shift` `def:photon-momentum` `ex:photoelectric-cutoff` `ex:compton-scattering` `fig:planck-spectrum`
- **Ch 15**：`def:field-mode` `thm:field-quantization` `def:number-operator` `def:fock-state` `prop:number-state-properties` `def:zero-point-energy` `ex:single-mode-energy`
- **Ch 16**：`def:coherent-state` `thm:coherent-state-properties` `def:squeezed-state` `def:quadrature-operators` `prop:squeezed-uncertainty` `def:wigner-function` `ex:squeezed-vacuum` `fig:wigner-function`
- **Ch 17**：`def:photon-number-distribution` `thm:thermal-statistics` `def:first-order-correlation` `def:second-order-correlation` `prop:g2-values` `thm:hbt-thermal` `def:antibunching` `def:single-photon-source` `ex:single-photon-source-example` `fig:hbt-experiment`
- **Ch 18**：`def:two-level-atom` `thm:rabi-oscillation` `thm:wigner-weisskopf` `def:jaynes-cummings-hamiltonian` `thm:jc-dynamics` `def:laser-rate-equations` `ex:rabi-flopping` `fig:rabi-oscillation`
- **Ch 19**：`def:laser-principle` `def:qkd` `def:entangled-photon-pair` `thm:bell-inequality` `def:spdc` `ex:bb84-protocol` `ex:bell-test`

（命名已与现有 84 个标签核对无冲突。）

## 四、逻辑链路

- **向上**：Ch 14 无前置（桥接）；Ch 15 用 `@thm:helmholtz`/Part I 谐振子（Ch 1.2）与
  Mécanique quantique 算符；Ch 16 用 Ch 15 Fock 态；Ch 17 回链 `@def:complex-coherence-degree`（Ch 9.6）；
  Ch 18 用 Ch 17 统计与 Mécanique quantique 二能级；Ch 19 用 Ch 9.4（FP 腔）、Ch 7.1（稳定性）、Ch 17/18。
- **横向**：15→16→17 为"态 → 相空间 → 测量"推进；18 独立于 16/17 但用 15；19 汇聚全部。
- **向下**：Ch 15 真空涨落 → Casimir 效应（远期，Mécanique quantique 边缘）；Ch 19 量子信息
  （QKD/纠缠）标注"深入参见后续"。

## 五、承诺追踪

| 类型 | 位置 | 内容 | 处理 |
|---|---|---|---|
| 兑现 | Ch 9.6 | HBT/二阶关联 → Ch 17 | 17.3/17.2 |
| 兑现 | Ch 9.4 | Fabry-Perot → Ch 19 激光腔 | 19.1 |
| 兑现 | Ch 7.1 | 稳定性判据 → Ch 19 谐振腔 | 19.1 |
| 兑现 | Ch 13.1 | Poincaré 球 → 光子偏振 Bloch 球 | Ch 15/16 |
| 兑现 | Ch 13.6 | 光子螺旋度 → Part IV | Ch 15/17 |
| 埋下 | Ch 17.4 | 单光子源 → SPDC | Ch 19.4 |
| 埋下 | Ch 15.4 | 真空涨落 → Casimir | 远期 note |

## 六、证明策略

| 定理 | 策略 | 关键工具 |
|---|---|---|
| `thm:planck-derivation` | 腔模计数 + 玻色统计（简述，非完整统计力学） | `@def:field-mode` 前置直觉 |
| `thm:compton-shift` | 四动量守恒（相对论能量-动量） | 光子动量 |
| `thm:field-quantization` | 模式展开 → 哈密顿 → 对易子 → 升降算符（单模完整） | 谐振子（Part I / 量力） |
| `thm:coherent-state-properties` | BCH 公式展开位移算符 → 泊松分布 | `@def:coherent-state` |
| `thm:thermal-statistics` | 热态=相干态混合（P 表示）→ 玻色-爱因斯坦 | 相空间方法 |
| `thm:hbt-thermal` | g⁽²⁾(0)=2 由热态二阶矩计算 | `@def:second-order-correlation` |
| `thm:rabi-oscillation` | Schrödinger 方程 + RWA → sin²(Ωt/2) | 二能级哈密顿 |
| `thm:wigner-weisskopf` | 耦合连续态 → 指数衰减 Γ（费米黄金规则） | 微扰论 |
| `thm:jc-dynamics` | 对角化 JC 哈密顿 → 真空 Rabi 分裂（简述） | `def:jaynes-cummings-hamiltonian` |
| `thm:bell-inequality` | CHSH 不等式陈述（不证明，导论） | 纠缠态 |

## 七、公式编号规划

- `eq:planck-law`（14.1）、`eq:compton-shift`（14.3）
- `eq:field-hamiltonian`（15.1）、`eq:field-commutator`（15.2）、`eq:fock-basis`（15.3）
- `eq:coherent-expansion`（16.1）、`eq:squeezed-operator`（16.2）、`eq:wigner-def`（16.4）
- `eq:thermal-distribution`（17.1）、`eq:g2-def`（17.2）、`eq:g2-values`（17.2）
- `eq:rabi-frequency`（18.1）、`eq:decay-rate`（18.2）、`eq:jc-hamiltonian`（18.3）
- `eq:bell-inequality`（19.3）

## 八、图片规划（4 张 A 级）

| 文件 | 标签 | 内容 | 优先级 |
|---|---|---|---|
| planck-spectrum.svg | `fig:planck-spectrum` | 黑体谱多温度曲线 + 经典极限（瑞利-金斯）标注 | A |
| wigner-function.svg | `fig:wigner-function` | 相干态（高斯）vs Fock 态（负值）相空间密度 | A |
| hbt-experiment.svg | `fig:hbt-experiment` | 分束器+双探测器+符合计数装置示意与 g⁽²⁾(τ) 聚束曲线 | A |
| rabi-oscillation.svg | `fig:rabi-oscillation` | 共振/失谐 Rabi 振荡 P_e(t) 曲线 | A |

（B 级 fock-distribution、squeezed-ellipse、qkd-scheme 明确不制作。）

## 九、写作顺序

Ch 14 → 15 → 16 → 17 → 18 → 19；章内"定义 → 定理 → 证明 → 例题 → note"，每写完 1–2 节编译一次。
完成后：更新蓝图注释（Part IV 设计思路 + Structure Note 标注"正文已写入"）→ 逐页 PDF 预览 → smart-commit 中文提交。
