# Optique — Part III Wave Optics (波动光学) 写作大纲

> 状态：大纲已定稿（2026-10-15）。决策记录：① 维持蓝图"理论框架先行"顺序（Born & Wolf 式）；
> ② Ch 11 傅里叶光学完整 5 节；③ 配图 8 张核心（A 级），B 级图不制作。
> 前置：Part I（Ch 1-4 时谐场/亥姆霍兹/角谱）、Part II（Ch 5-7 几何光学）已写入并编译通过。

## 零、Part 定位与核心洞察

- **定位**：波动光学是本笔记的**本体理论**，体量最大。以"Helmholtz 方程 + 格林函数"（Ch 8）为统一框架，
  依次展开干涉与相干（Ch 9）、衍射应用（Ch 10）、傅里叶光学（Ch 11）、偏振（Ch 12）、介质传播（Ch 13）。
- **核心洞察**：衍射积分的三个渐近层——格林函数精确解（Ch 8）→ 菲涅耳/夫琅禾费近似（Ch 10）→
  透镜实现的傅里叶变换（Ch 11）——是同一条数学链；干涉是其特例，分辨极限是必然推论，偏振是矢量性的回归。
- **预估规模**：~1900–2200 行，6 章 28 节，约 66 个新标签，8 张配图。

## 一、章节结构与定位

| 章 | 标题 | 节数 | 角色 |
|---|---|---|---|
| Ch 8 | Scalar Diffraction Theory // 标量衍射理论 | 4 | 统一理论框架（格林函数求解 Helmholtz 边值） |
| Ch 9 | Interference and Coherence // 干涉与相干性 | 6 | 两束/多束叠加 → 统计相干 |
| Ch 10 | Diffraction // 衍射 | 4 | 衍射积分的菲涅耳/夫琅禾费近似与应用 |
| Ch 11 | Fourier Optics // 傅里叶光学 | 5 | 透镜=光学傅里叶变换器，空间滤波系统 |
| Ch 12 | Polarization // 偏振 | 6 | 标量→矢量回归，琼斯/缪勒代数 |
| Ch 13 | Propagation in Media // 介质中的传播 | 3+可选 | 色散/吸收、因果性、散射 |

## 二、组件频率预估

| 组件 | 数量 |
|---|---|
| `#definition` | 27 |
| `#theorem` | 8 |
| `#law` | 2 |
| `#example` | 10 |
| `#figure` | 8 |
| `#note` | ~14 |

## 三、标签系统（写作清单）

### Ch 8
- `def:scalar-field`（标量近似/边界条件，回链 `@def:helmholtz`）
- `def:huygens-fresnel`（惠更斯-菲涅耳原理）
- `thm:kirchhoff-integral`（基尔霍夫积分，格林第二恒等式证明）
- `thm:rayleigh-sommerfeld`（RS 积分，镜像格林函数证明）
- `def:green-diffraction`（自由空间格林函数，兑现 Ch 5.5 倏逝波）
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
- `def:polarization-state`（兑现 Ch 4.3 矢量性回归）
- `def:jones-vector`、`def:jones-matrix` + `eq:jones-propagation`
- `def:stokes-parameters`、`def:mueller-matrix` + `eq:stokes`
- `law:malus` + `eq:malus`
- `def:birefringence`、`def:wave-plate`、`ex:quarter-wave-plate`
- `def:brewster-angle`、`ex:brewster-reflection`
- `def:optical-activity`（简要，埋线 → Part IV Ch 15/16）
- `fig:polarization-ellipse`（A 级）

### Ch 13
- `def:lorentz-oscillator`、`def:complex-refractive-index` + `eq:lorentz-dielectric`（兑现 Ch 7.2）
- `thm:kramers-kronig` + `eq:kk`（因果性 + 上半平面解析性；超重则降级 note）
- `law:rayleigh-scattering` + `eq:rayleigh-cross-section`、`def:mie-scattering`、`ex:sky-color`
- `fig:dispersion-curves`（A 级）

## 四、逻辑链路

```
Ch 4 亥姆霍兹+角谱 ──► Ch 8 格林函数衍射积分 ──► Ch 9 干涉/相干 ──► Ch 10 菲涅耳/夫琅禾费
        ▲                                                          │
        └──────────── Ch 11 透镜=FT ◄───────── 夫琅禾费(孔径FT) ────┘
        │                                            │
        └──── Ch 12 偏振（矢量回归）        Ch 13 介质传播（回指 Ch 3 色散/群速）
        │                                            │
        └──── Part IV：相干态/关联函数（Ch 17 兑现 Ch 9 埋线）
```

## 五、承诺追踪

| 类型 | 位置 | 内容 | 处理 |
|---|---|---|---|
| 兑现 | Ch 4 | 衍射积分 = 角谱的远场评估 | Ch 8.4 |
| 兑现 | Ch 4.4 | 倏逝波区分重现于 Ch 10/11 | Ch 10.4 + Ch 11.4 |
| 兑现 | Ch 5.5 | 倏逝波全波描述回到 Part III | Ch 8.4 |
| 兑现 | Ch 7.2 | 色散 n(λ) 属于 Part III | Ch 13.1 |
| 兑现 | Ch 7.3 | 衍射极限在 Ch 10 发展 | Ch 10.4 |
| 兑现 | Ch 7.5 | 光纤模式属 Part III | Ch 8（圆柱对称 Helmholtz note） |
| 兑现 | Ch 4.3 | 矢量性在 Ch 12 回归 | Ch 12.1 |
| 埋下 | Ch 9.5 / 12.6 | 相干函数/偏振量子态 → Part IV | Ch 17 / Ch 15 |

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

（第 8 张由 Ch 9/10 写作时按需补定；B 级 fabry-perot、spatial-filtering、poincare-sphere、rayleigh-scattering 不制作。）

## 九、写作顺序

Ch 8 → 9 → 10 → 11 → 12 → 13；章内"定义 → 定理 → 例题 → note"，每写完 1–2 节编译一次。
完成后：更新蓝图注释（Part III 设计思路 + Structure Note 标注"正文已写入"）→ 逐页 PDF 预览 → 提交。
