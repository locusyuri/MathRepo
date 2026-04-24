[Homepage]() | [Github](https://github.com/locusyuri/Mathematics) | [Download]() | 

![License](https://img.shields.io/github/license/locusyuri/Mathematics) ![Repo Size](https://img.shields.io/github/repo-size/locusyuri/Mathematics) ![Commit Activity](https://img.shields.io/github/commit-activity/w/locusyuri/Mathematics)

------

# Structure | 目录结构
This repository collects bilingual mathematics notes organized by subject. The list below reflects the current folder tree; folders shown with ~~strike through~~ are still under construction.

## 1.Analyse | 分析学
- [Analyse Complexe | 复分析](./1.Analyse/Analyse%20Complexe/initial.pdf)
- [Analyse Harmonique | 调和分析](./1.Analyse/Analyse%20Harmonique/tmp/initial.pdf)
- [Analyse Fonctionnelle | 泛函分析](./1.Analyse/Analyse%20Fonctionnelle/initial.pdf)
- [Analyse Mathématique | 数学分析](./1.Analyse/Analyse%20Mathématique/tmp/initial.pdf)
- [Analyse Réelle | 实分析](./1.Analyse/Analyse%20Réelle/initial.pdf)
- [Équation Différentielle Ordinaire | 常微分方程](./1.Analyse/Équation%20Différentielle%20Ordinaire/tmp/initial.pdf)
- [Équations aux Dérivées Partielles | 偏微分方程](./1.Analyse/Équations%20aux%20Dérivées%20Partielles/initial.pdf)


## 2.Algèbre | 代数学
- [Algèbre Abstraite | 抽象代数](./2.Algèbre/Algèbre%20Abstraite/tmp/initial.pdf)
- [Algèbre Linéaire | 线性代数](./2.Algèbre/Algèbre%20Linéaire/tmp/initial.pdf)
- [Polynôme | 多项式](./2.Algèbre/Polynôme/tmp/initial.pdf)
- [Théorie des Nombres | 数论](./2.Algèbre/Théorie%20des%20Nombres/tmp/initial.pdf)


## 3.Géométrie | 几何学
- [Géométrie Analytique | 解析几何](./3.Géométrie/Géométrie%20Analytique/tmp/initial.pdf)
- [Topologie Algébrique  | 代数拓扑](./3.Géométrie/Topologie%20Algébrique/initial.pdf)
- [Topologie Générale | 点集拓扑](./3.Géométrie/Topologie%20Générale/tmp/initial.pdf)

## 4.Mathématiques discrètes | 离散数学
- [Combinatoire | 组合数学](./4.Mathématiques%20discrètes/Combinatoire/tmp/initial.pdf)
- [Logique Mathématique | 数理逻辑](./4.Mathématiques%20discrètes/Logique%20Mathématique/tmp/initial.pdf)
- [Théorie des Ensembles | 集合论](./4.Mathématiques%20discrètes/Théorie%20des%20Ensembles/initial.pdf)
- [Théorie des Graphes | 图论](./4.Mathématiques%20discrètes/Théorie%20des%20Graphes/tmp/initial.pdf)

## 5.Statistiques | 统计学
- [Probabilités | 机率论](./5.Statistiques/Probabilités/tmp/initial.pdf)
- [Processus Stochastique | 随机过程](./5.Statistiques/Processus%20Stochastique/tmp/initial.pdf)
- [Statistiques Mathématiques | 数理统计](./5.Statistiques/Statistiques%20Mathématiques/tmp/initial.pdf)


## 6.Mathématiques appliquées | 应用数学
- [Électrodynamique | 电动力学](./6.Mathématiques%20appliquées/Électrodynamique/initial.pdf)
- [Latex | Latex 教程](./6.Mathématiques%20appliquées/Latex/tmp/initial.pdf)
- [Mécanique analytique | 分析力学](./6.Mathématiques%20appliquées/Mécanique%20analytique/initial.pdf)
- [Mécanique quantique | 量子力学](./6.Mathématiques%20appliquées/Mécanique%20quantique/initial.pdf)


---
# Term Index | 术语索引
## A

## B
- **Banach Space (巴拿赫空间)** | 
- **Bounded Variation (有界变差)** | Analyse Mathématique - Section 14.6: Bounded Variation Functions
## C
- **Continuation (延拓)** | Théorie des Ensembles
## D
## E
## F
## G
## H
- **Hilbert Space (希尔伯特空间)** |
- **Homogeneous Function (齐次函数)** | Équation Différentielle Ordinaire - Section 2.3: Homogeneous Equations

## I
## J
## K
## L

- **Linear Space (线性空间)** | Algèbre Linéaire - Section 3.2: Linear Space

## M
## N
## O
## P
## Q
## R
## S
## T
## U
## V
## W
## X
## Y
## Z

---
# Notations
[🌐`elegantbook` 原项目地址](https://github.com/ElegantLaTeX/ElegantBook)


------
# Font Setting | 字体设置
字体修改如下，请确保本机含有如下字体：
```tex
\ifdefstring{\ELEGANT@lang}{en}{
  \RequirePackage{fontspec} % 字体设置
  ...
  ...
  ...
  % 自定义标题字体
  \newfontfamily\titlefont{Merriweather}
  % 环境字体定义
  \newfontfamily\theoremfont{GaramondPremrPro-Disp}      % 定理
  \newfontfamily\definitionfont{GaramondPremrPro-Disp}   % 定义
  \newfontfamily\propositionfont{GaramondPremrPro-Disp}   % 命题
  \newfontfamily\examplefont{Bembo}       % 例子
  %\newfontfamily\exercisefont{\ttfamily}     % 练习
  %\newfontfamily\prooffont{\sffamily}        % 证明
  %\newfontfamily\remarkfont{方正宋刻本秀楷简体}        % 注释
  \newfontfamily\remarkfont{NeutraTextTF-Book}        % 注释
  \newfontfamily\cursivetitle{Monotype Corsiva} % 花体标题
}{\relax}
```
> 注意：若使用的 Tex 发行版为 Tex Live，请在 `...\texlive\2025\texmf-dist\fonts` 目录下（对应格式）放入相应字体。

------
# Refactor Log | Typst 重构日志

该章节用于记录从 LaTeX/elegantbook 迁移到 Typst 的过程、关键决策与当前状态，便于后续维护与回溯。

## 2026-04-10 | 初始化迁移阶段

### 目标
- 将现有数学笔记模板逐步从 LaTeX 重构到 Typst。
- 保留 elegantbook 的视觉语言，同时降低模板维护成本。
- 将模板能力拆分为可复用函数，支持后续扩展。

### 迁移范围（已落地）
- 封面、页眉、页脚基础版式。
- Part / Chapter / Section / Paragraph 标题样式。
- 目录生成器与层级条目样式。
- theorem-like 主要组件（Theorem / Definition / Proposition 等）。
- 次要组件（Proof / Solution / Exercise）。
- 注释体系（Note / Caution）及配色覆盖参数。
- 表格工具（`tex-table`、`plain-table`、`fancy-divider`）。
- 行内高亮工具（`highlight`）。

### 关键实现文件
- `TypstTemplate/math-notes.typ`：模板核心样式与组件函数。
- `TypstTemplate/initial.typ`：完整英文示例文档（展示各类组件）。
- `TypstTemplate/references.bib`：示例参考文献数据库。

### 设计决策（摘要）
- 组件字体、字号、配色统一提取为公共变量，降低全局调参成本。
- theorem-like 组件使用“章号.序号”编号方案（如 1.1）。
- Note 与 Caution 从主组件体系中独立，采用更轻量的注释风格。
- Proof/Solution 保留视觉识别（标题图标 + 结尾方框），正文回归常规可读字体。

### 已知说明
- 迁移过程中优先保证示例可编译与样式一致性。
- 旧 LaTeX 配置保留为历史参考，不再作为主维护入口。

### 下一步计划
- 增加更多章节模板片段（例如习题解答页、总结页）。
- 逐步补全术语索引与跨章节引用示例。
- 补充更系统的模板使用文档与最小调用清单。

-------
Copyright © 2026 Cat Mono. All rights reserved.

