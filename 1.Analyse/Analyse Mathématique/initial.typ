#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Analyse Mathématique",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Analyse Mathématique", // 数学分析
  "Violet",
  subtitle: "A notebook for mathematical analysis",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.1.0",
  extra-info: "This is a notebook for mathematical analysis.",
)

#make-outline(depth: 2, title: "Contents")

= Preface // 前言

Version notes are in the table below.

#tex-table(
  ("Version", "Date", "Description"),
  ("0.1", "July, 2025", "Initial version"),
  ("1.0", "January, 2026", "Basic content completed, including chapters on limits and continuity, differentiation and integration (including multivariate), series, curve theory, line and surface integrals, and parameter-dependent integrals."),
)

#v(0.7cm)

For an interval $I$, an open interval $(a, b)$ and a closed interval $[a, b]$,
we denote $C(I)$, $C(a, b)$ and $C[a, b]$
as the set of continuous #underline[univariate] functions on $I$, $(a, b)$ and $[a, b]$ respectively.
Similarly, the following notations are used#footnote[
  Other notations include: $R[a, b]$ (denoting Riemann integrable functions on $[a, b]$),
  $B[a, b]$ (denoting bounded functions on $[a, b]$), etc.
]:

#tex-table(
  ("Notation", "Meaning"),
  ("$D(I)$", "Set of derivative (differential) functions on $I$"),
  ("$D(a, b)$", "Set of derivative (differential) functions on $(a, b)$"),
  ("$D[a, b]$", "Set of derivative (differential) functions on $[a, b]$"),
  ("$D^k(I)$", "Set of $k$-th order derivative (differential) functions on $I$"),
)

Let $U subset bb(R)^n$ be an open set, and $f: U -> bb(R)^m$ be a $C^k$ mapping:

- $k = 0$: $f$ is a continuous mapping;
- $0 < k < +infinity$: $f_i$ has continuous partial derivatives up to order $k$, $i = 1, 2, dots, m$;
- $k = +infinity$: $f_i$ has continuous partial derivatives of all orders, $i = 1, 2, dots, m$;
- $k = omega$: $f_i$ is really analytic, i.e., in the neighborhood of any point $x^0 = (x_1^0, x_2^0, dots, x_n^0) in U$,
  $f_i$ can be expanded into a convergent ($n$-dimensional) power series, $i = 1, 2, dots, m$.

Let $C^k(U, bb(R)^m)$ denote the set of $C^k$ mappings from $U$ to $bb(R)^m$.

Sometimes, we use subscripts $i$ to denote the partial derivative with respect to the $i$-th variable,
for example, for function $f(x^2 + y^2 + z^2, x y z)$, $f_2 := (partial f) / (partial (x y z))$,
and similarly for higher-order partial derivatives, e.g., $f_12 := (partial^2 f(u, v)) / (partial v partial u)$.

// --- Part I: 极限与连续性 ---
#part("Limits and Continuity") // 极限与连续
// B1: ch01 Preliminaries（预备知识）
// B2: ch02 Limits of Sequences and Continuity of Real Number System（序列极限与实数系连续性）
// B3: ch03 Limits and Continuity of Functions（函数的极限与连续性）

// --- Part II: 一元函数微积分 ---
#part("Single-variable Calculus") // 一元函数微积分
// B4: ch04 Differential（微分学）
// B5: ch05 Indefinite Integral（不定积分）
// B6: ch06 Definite Integral（定积分）
// B7: ch07 Improper Integral（反常积分）

// --- Part III: 无穷级数 ---
#part("Infinite Series") // 无穷级数
// B8: ch08 Numerical Series（数项级数）
// B9: ch09 Series of Functions（函数项级数）
// B10: ch10 Power Series（幂级数）

// --- Part IV: 多元微积分本体（决策③：ch11–13） ---
#part("Multivariable Calculus") // 多元微积分
// B11: ch11 Limits and Continuity in Euclidean Spaces（欧氏空间上的极限与连续性）
// B12: ch12 Multi-variable Differential Calculus（多元微分学）
// B13: ch13 Multiple Integrals（多重积分）

// --- Part V: 几何应用与高级积分（决策③：ch14–16） ---
#part("Calculus Applications in Several Variables") // 多元微积分的应用
// B14: ch14 Introduction to Curve and Surface Theory（曲线与曲面论导论，决策①改章名）
// B15: ch15 Line Integrals and Surface Integrals（曲线积分与曲面积分）
// B16: ch16 Integrals with Variable Parameters（变参积分）

// --- Appendix ---
#part("Appendix") // 附录

= Glossary // 术语表
// B17 收尾时用 violet-glossary-indexer 重建字母索引

#bibliography("references.bib")
