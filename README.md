[Homepage]() | [Github](https://github.com/locusyuri/MathRepo) | [Download]() | 

![License](https://img.shields.io/github/license/locusyuri/MathRepo) ![Repo Size](https://img.shields.io/github/repo-size/locusyuri/MathRepo) ![Commit Activity](https://img.shields.io/github/commit-activity/w/locusyuri/MathRepo) ![Last Commit](https://img.shields.io/github/last-commit/locusyuri/MathRepo) ![Issues](https://img.shields.io/github/issues/locusyuri/MathRepo)  ![Stargazers](https://img.shields.io/github/stars/locusyuri/MathRepo?style=social) ![Forks](https://img.shields.io/github/forks/locusyuri/MathRepo?style=social) ![Watchers](https://img.shields.io/github/watchers/locusyuri/MathRepo?style=social) ![Language](https://img.shields.io/github/languages/top/locusyuri/MathRepo) ![Top Language](https://img.shields.io/github/languages/count/locusyuri/MathRepo)



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
- **Bounded Variation (有界变差)** | Analyse Mathématique
## C
- **Continuation (延拓)** | Théorie des Ensembles
## D
## E
## F
## G
## H
- **Hilbert Space (希尔伯特空间)** |
- **Homogeneous Function (齐次函数)** | Équation Différentielle Ordinaire

## I
## J
## K
## L

- **Linear Space (线性空间)** | Algèbre Linéaire

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

Copyright © 2026 Cat Mono. All rights reserved.