[Homepage]() | [Github](https://github.com/locusyuri/Mathematics) | [Download]() | 

![License](https://img.shields.io/github/license/locusyuri/Mathematics) ![Repo Size](https://img.shields.io/github/repo-size/locusyuri/Mathematics) ![Commit Activity](https://img.shields.io/github/commit-activity/w/locusyuri/Mathematics)

------

# Structure
This is a repository for mathematical notes. The directory structure is as follows:

## 0.Mathématiques fondamentales
- [Logique Mathématique | 數理邏輯](./0.Mathématiques%20fondamentales/Logique%20Mathématique/tmp/initial.pdf)

## 1.Analyse
- [Analyse Mathématique | 數學分析](./1.Analyse/Analyse%20Mathématique/tmp/initial.pdf)
- [Analyse de Fourier | 傅立葉分析](./1.Analyse/Analyse%20de%20Fourier/tmp/initial.pdf)
- [Équation Différentielle Ordinaire | 常微分方程](./1.Analyse/Équation%20Différentielle%20Ordinaire/tmp/initial.pdf)

## 2.Algèbre
- [Algèbre Linéaire | 線性代數](./2.Algèbre/Algèbre%20Linéaire/tmp/initial.pdf)
- [Polynôme | 多項式](./2.Algèbre/Polynôme/tmp/initial.pdf)


## 3.Géométrie
- [Géométrie Analytique | 解析幾何](./3.Géométrie/Géométrie%20Analytique/tmp/initial.pdf)


## 4.Mathématiques appliquées
- [Latex | Latex 教程](./4.Mathématiques%20appliquées/Latex/tmp/initial.pdf)

---
# Notations
[`elegantbook` 原项目地址](https://github.com/ElegantLaTeX/ElegantBook)


------
# 修改说明
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

-------


