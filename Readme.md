[Homepage]() | [Github](https://github.com/locusyuri/Mathematics) | [Download]() | 

![License](https://img.shields.io/github/license/locusyuri/Mathematics) ![Repo Size](https://img.shields.io/github/repo-size/locusyuri/Mathematics) ![Commit Activity](https://img.shields.io/github/commit-activity/w/locusyuri/Mathematics)

------

# Structure | 目錄結構
This is a repository for mathematical notes. The directory structure is as follows
(folders with ~~strike through~~ are under construction):

## 1.Analyse | 分析學
- [Analyse de Fourier | 傅立葉分析](./1.Analyse/Analyse%20de%20Fourier/tmp/initial.pdf)
- [Analyse Mathématique | 數學分析](./1.Analyse/Analyse%20Mathématique/tmp/initial.pdf)
- [Équation Différentielle Ordinaire | 常微分方程](./1.Analyse/Équation%20Différentielle%20Ordinaire/tmp/initial.pdf)


## 2.Algèbre | 代數學
- [Algèbre Abstraite | 抽象代數](./2.Algèbre/Algèbre%20Abstraite/tmp/initial.pdf)
- [Algèbre Linéaire | 線性代數](./2.Algèbre/Algèbre%20Linéaire/tmp/initial.pdf)
- [Polynôme | 多項式](./2.Algèbre/Polynôme/tmp/initial.pdf)



## 3.Géométrie | 幾何學
- [Géométrie Analytique | 解析幾何](./3.Géométrie/Géométrie%20Analytique/tmp/initial.pdf)
- ~~[Topologie Algébrique  | 代數拓撲]()~~
- [Topologie Générale | 點集拓撲](./3.Géométrie/Topologie%20Générale/tmp/initial.pdf)

## 4.Mathématiques discrètes | 離散數學
- [Combinatoire | 組合數學](./4.Mathématiques%20discrètes/Combinatoire/tmp/initial.pdf)
- [Logique Mathématique | 數理邏輯](./4.Mathématiques%20discrètes/Logique%20Mathématique/tmp/initial.pdf)
- [Théorie des Ensembles | 集合論](./4.Mathématiques%20discrètes/Théorie%20des%20Ensembles/tmp/initial.pdf)
- [Théorie des Graphes | 圖論](./4.Mathématiques%20discrètes/Théorie%20des%20Graphes/tmp/initial.pdf)
- [Théorie des Nombres | 數論](./4.Mathématiques%20discrètes/Théorie%20des%20Nombres/tmp/initial.pdf)

## 5.Mathématiques appliquées | 應用數學
- [Latex | Latex 教程](./5.Mathématiques%20appliquées/Latex/tmp/initial.pdf)
- [Théorie des Champs | 場論](./5.Mathématiques%20appliquées/Théorie%20des%20Champs/tmp/initial.pdf)


---
# Term Index | 術語索引
## A

## B
## C
## D
## E
## F
## G
## H
- Homogeneous Function (齊次函數) | Équation Différentielle Ordinaire - Section 2.3: Homogeneous Equations

## I
## J
## K
## L

- Linear Space (線性空間) | Algèbre Linéaire - Section 3.2: Linear Space

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
[`elegantbook` 原項目地址](https://github.com/ElegantLaTeX/ElegantBook)


------
# Font Setting | 字體設置
字體修改如下，請確保本機含有如下字體：
```tex
\ifdefstring{\ELEGANT@lang}{en}{
  \RequirePackage{fontspec} % 字體設置
  ...
  ...
  ...
  % 自定義標題字體
  \newfontfamily\titlefont{Merriweather}
  % 環境字體定義
  \newfontfamily\theoremfont{GaramondPremrPro-Disp}      % 定理
  \newfontfamily\definitionfont{GaramondPremrPro-Disp}   % 定義
  \newfontfamily\propositionfont{GaramondPremrPro-Disp}   % 命題
  \newfontfamily\examplefont{Bembo}       % 例子
  %\newfontfamily\exercisefont{\ttfamily}     % 練習
  %\newfontfamily\prooffont{\sffamily}        % 證明
  %\newfontfamily\remarkfont{方正宋刻本秀楷简体}        % 註釋
  \newfontfamily\remarkfont{NeutraTextTF-Book}        % 註釋
  \newfontfamily\cursivetitle{Monotype Corsiva} % 花體標題
}{\relax}
```
> 注意：若使用的 Tex 發行版為 Tex Live，請在 `...\texlive\2025\texmf-dist\fonts` 目錄下（對應格式）放入相應字體。

-------


