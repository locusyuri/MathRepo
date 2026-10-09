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

// --- Part I: 极限与连续性 ---
#part("Limits and Continuity") // 极限与连续
= Preliminaries // 预备知识

== Notations // 符号说明

For an interval $I$, an open interval $(a, b)$ and a closed interval $[a, b]$,
we denote $C(I)$, $C(a, b)$ and $C[a, b]$
as the set of continuous _univariate_ functions on $I$, $(a, b)$ and $[a, b]$ respectively.
Similarly, the following notations are used#footnote[
  Other notations include: $R[a, b]$ (denoting Riemann integrable functions on $[a, b]$),
  $B[a, b]$ (denoting bounded functions on $[a, b]$), etc.
]:

#tex-table(
  ([Notation], [Meaning]),
  ([$D(I)$], [Set of derivative (differential) functions on $I$]),
  ([$D(a, b)$], [Set of derivative (differential) functions on $(a, b)$]),
  ([$D[a, b]$], [Set of derivative (differential) functions on $[a, b]$]),
  ([$D^(k)(I)$], [Set of $k$-th order derivative (differential) functions on $I$]),
)

Let $U subset bb(R)^n$ be an open set, and $bold(f): U -> bb(R)^m$ be a $C^k$ mapping:

- $k = 0$: $bold(f)$ is a continuous mapping;
- $0 < k < +oo$: $f_i$ has continuous partial derivatives up to order $k$, $i = 1, 2, dots, m$;
- $k = +oo$: $f_i$ has continuous partial derivatives of all orders, $i = 1, 2, dots, m$;
- $k = omega$: $f_i$ is real analytic, i.e., in the neighborhood of any point
  $x^0 = (x_1^0, x_2^0, dots, x_n^0) in U$, $f_i$ can be expanded into a convergent
  ($n$-dimensional) power series, $i = 1, 2, dots, m$.

Let $C^(k)(U, bb(R)^m)$ denote the set of $C^k$ mappings from $U$ to $bb(R)^m$.

Sometimes, we use subscripts $i$ to denote the partial derivative with respect to the $i$-th variable,
for example, for the function $f(x^2 + y^2 + z^2, x y z)$, we write $f_2 := (partial f) / (partial (x y z))$,
and similarly for higher-order partial derivatives, e.g., $f_(12) := (partial^2 f(u, v)) / (partial v partial u)$.

== Trigonometric Formulas // 三角公式

*Product-to-Sum Formulas:*
$
  sin alpha cos beta & = 1 / 2 [sin(alpha + beta) + sin(alpha - beta)] \
  cos alpha sin beta & = 1 / 2 [sin(alpha + beta) - sin(alpha - beta)] \
  cos alpha cos beta & = 1 / 2 [cos(alpha + beta) + cos(alpha - beta)] \
  sin alpha sin beta & = -1 / 2 [cos(alpha + beta) - cos(alpha - beta)]
$

*Sum and Difference Formulas:*
$
  sin(alpha + beta) & = sin alpha cos beta + cos alpha sin beta \
  sin(alpha - beta) & = sin alpha cos beta - cos alpha sin beta \
  cos(alpha + beta) & = cos alpha cos beta - sin alpha sin beta \
  cos(alpha - beta) & = cos alpha cos beta + sin alpha sin beta
$

*Sum-to-Product Formulas:*
$
  sin alpha + sin beta & = 2 sin((alpha + beta) / 2) cos((alpha - beta) / 2) \
  sin alpha - sin beta & = 2 sin((alpha - beta) / 2) cos((alpha + beta) / 2) \
  cos alpha + cos beta & = 2 cos((alpha + beta) / 2) cos((alpha - beta) / 2) \
  cos alpha - cos beta & = -2 sin((alpha + beta) / 2) sin((alpha - beta) / 2)
$

*Double Angle Formulas:*
$
  sin 2 alpha & = 2 sin alpha cos alpha \
  cos 2 alpha & = cos^2 alpha - sin^2 alpha = 2 cos^2 alpha - 1 = 1 - 2 sin^2 alpha \
  tan 2 alpha & = (2 tan alpha) / (1 - tan^2 alpha)
$

*Half Angle Formulas:*
$
  sin(alpha / 2) & = plus.minus sqrt((1 - cos alpha) / 2) \
  cos(alpha / 2) & = plus.minus sqrt((1 + cos alpha) / 2) \
  tan(alpha / 2) & = (1 - cos alpha) / (sin alpha) = (sin alpha) / (1 + cos alpha)
$

*Power-Reducing Formulas:*
$
  sin^2 alpha & = (1 - cos 2 alpha) / 2 \
  cos^2 alpha & = (1 + cos 2 alpha) / 2
$

*Angle Decomposition Formulas:*
$
  sin^2 alpha - sin^2 beta & = sin(alpha + beta) sin(alpha - beta) \
  cos^2 alpha - sin^2 beta & = cos(alpha + beta) cos(alpha - beta)
$

#figure(
  image("img/triangle.png", width: 40%),
  caption: [The gray triangle of trigonometric functions.],
) <fig:trig-triangle>

#property(name: "Geometric Remarks")[
  - On the gray triangle (@fig:trig-triangle), the sum of the squares of the two numbers above
    is equal to the square of the number below, for instance, $tan^2 x + 1 = sec^2 x$.
  - The three trigonometric functions in the clockwise direction have the following properties:
    $tan x = (sin x) / (cos x)$, etc.
] <prop:trig-triangle-remarks>

#theorem(name: "Weierstrass Substitution (All-Powerful Formula)")[
  Let $t = tan(x / 2)$. Then:
  $
    sin x & = (2 t) / (1 + t^2) \
    cos x & = (1 - t^2) / (1 + t^2) \
    dif x & = 2 / (1 + t^2) dif t.
  $
] <thm:weierstrass-substitution>

== Common Inequalities // 常用不等式

Some common inequalities:
$
  x / (1 + x) < ln(1 + x) < x, quad x > 0;
$

#theorem(name: "Mean Value Inequalities")[
  For $n$ positive numbers $a_1, a_2, dots, a_n$,
  $
    (a_1 + a_2 + dots + a_n) / n >= root(n, a_1 a_2 dots a_n) >= n / (1 / a_1 + 1 / a_2 + dots + 1 / a_n),
  $
  that is, the arithmetic mean (Arithmetic) is not less than the geometric mean (Geometric),
  which is not less than the harmonic mean (Harmonic).
  Equality holds if and only if $a_1 = a_2 = dots = a_n$.
] <thm:mean-inequalities>

#proof[
  *First proof.* We show $(a_1 + a_2 + dots + a_n) / n >= root(n, a_1 a_2 dots a_n)$.
  The cases $n = 1, 2$ are clear; for $n = 2^k$ ($k in bb(N)^+$) the inequality follows from $(a + b) / 2 >= sqrt(a b)$.
  For $n != 2^k$, choose $l in bb(N)^+$ with $2^(l - 1) < n < 2^l$ and write $bar(a) = root(n, a_1 a_2 dots a_n)$.
  Adjoining $(2^l - n)$ copies of $bar(a)$ and applying the power-of-two case to these $2^l$ positive numbers gives
  $
    1 / 2^l [a_1 + a_2 + dots + a_n + (2^l - n) bar(a)] >= (a_1 a_2 dots a_n bar(a)^(2^l - n))^(1 / 2^l) = bar(a),
  $
  which rearranges to $(a_1 + a_2 + dots + a_n) / n >= root(n, a_1 a_2 dots a_n)$.
  Applying the same argument to $1 / a_1, 1 / a_2, dots, 1 / a_n$ yields
  $root(n, a_1 a_2 dots a_n) >= n / (1 / a_1 + 1 / a_2 + dots + 1 / a_n)$.
]

#proof[
  *Second proof (via #link(<thm:bernoulli>)[Bernoulli's inequality]).* Let
  $A_n = (a_1 + a_2 + dots + a_n) / n$ and $G_n = root(n, a_1 a_2 dots a_n)$.
  Clearly $A_n / A_(n - 1) - 1 > -1$, so Bernoulli's inequality gives
  $
    (1 + (A_n / A_(n - 1) - 1))^n >= 1 + n (A_n / A_(n - 1) - 1) = (n A_n - (n - 1) A_(n - 1)) / A_(n - 1) = a_n / A_(n - 1).
  $
  Multiplying by $A_(n - 1)^n$ and iterating,
  $
    A_n^n >= a_n A_(n - 1)^(n - 1) >= a_n a_(n - 1) A_(n - 2)^(n - 2) >= dots >= a_1 a_2 dots a_n,
  $
  hence $A_n >= G_n$. The harmonic mean part is obtained as in the first proof.
]

#lemma(name: "Newton's Binomial Theorem")[
  For real numbers $x, y$ and a nonnegative integer $n$:
  $
    (x + y)^n = sum_(k = 0)^n binom(n, k) x^(n - k) y^k.
  $
] <lem:newton-binomial>

#theorem(name: "Bernoulli's Inequality")[
  For every real $x > -1$ and integer $n >= 1$,
  $
    (1 + x)^n >= 1 + n x,
  $
  with equality if and only if $n = 1$ or $x = 0$.
  For $0 < n < 1$ the inequality reverses: $(1 + x)^n <= 1 + n x$.
] <thm:bernoulli>

#proof[
  The cases $n = 1$ and $x = 0$ are trivial. For $n > 1$ and $x > 0$, by #link(<lem:newton-binomial>)[Newton's binomial theorem],
  $(1 + x)^n = 1 + n x + binom(n, 2) x^2 + dots > 1 + n x$.
  For $-1 < x < 0$,
  $
    (1 + x)^n - 1 = x [1 + (1 + x) + (1 + x)^2 + dots + (1 + x)^(n - 1)] > n x,
  $
  since the bracketed sum is less than $n$ while $x < 0$.
]

#corollary(name: "Consequences of Bernoulli's Inequality")[
  + Let $A > 0$ and $A + B > 0$. For $n in bb(N)^+$,
    $(A + B)^n >= A^n + n A^(n - 1) B$, with equality if and only if $B = 0$.
  + For $x >= 0$ and $n in bb(N)^+$,
    $(1 + x)^n >= 1 + (n (n - 1)) / 2 x^2$.
  + If $a_i > -1$ ($i = 1, 2, dots, n$) and the $a_i$ are of the same sign, then
    $product_(i = 1)^n (1 + a_i) >= 1 + sum_(i = 1)^n a_i$.
] <cor:bernoulli-consequences>

#proof[
  + Substitute $x = B / A$ in #link(<thm:bernoulli>)[Bernoulli's inequality].
  + Expand $(1 + x)^n$ by #link(<lem:newton-binomial>)[Newton's binomial theorem] and keep the first three terms.
  + We argue by induction on $n$. The case $n = 1$ is clear. Assume the claim for $n = k$;
    for $n = k + 1$ suppose without loss of generality $a_i > 0$ (the other sign is similar). Then
    $
      product_(i = 1)^(k + 1) (1 + a_i) & = (1 + a_(k + 1)) product_(i = 1)^k (1 + a_i) \
                                        & = (1 + a_(k + 1)) (1 + sum_(i = 1)^k a_i) \
                                        & = 1 + sum_(i = 1)^(k + 1) a_i.
    $
]

#theorem(name: "Triangle Inequality")[
  For all $a, b in bb(R)$,
  $
    abs(abs(a) - abs(b)) <= abs(a + b) <= abs(a) + abs(b).
  $
] <thm:triangle-inequality>

#proof[
  For all $a, b in bb(R)$ we have $-abs(a) abs(b) <= a b <= abs(a) abs(b)$, hence
  $
    abs(a)^2 - 2 abs(a) abs(b) + abs(b)^2 <= a^2 + 2 a b + b^2 <= abs(a)^2 + 2 abs(a) abs(b) + abs(b)^2.
  $
  The left-hand side is $(abs(a) - abs(b))^2$ and the right-hand side is $(abs(a) + abs(b))^2$;
  taking square roots gives the claim.
]

#theorem(name: "Cauchy-Schwarz Inequality")[
  For real numbers $a_1, a_2, dots, a_n$ and $b_1, b_2, dots, b_n$,
  $
    (sum_(i = 1)^n a_i b_i)^2 <= (sum_(i = 1)^n a_i^2)(sum_(i = 1)^n b_i^2),
  $
  with equality if and only if the ratios $a_i / b_i$ are all equal,
  or one of the two sequences vanishes identically.
] <thm:cauchy-schwarz>

#proof[
  Introduce a parameter $lambda$ and consider the nonnegative quadratic form
  $
    0 <= sum_(i = 1)^n (lambda a_i + b_i)^2 = lambda^2 sum_(i = 1)^n a_i^2 - 2 lambda sum_(i = 1)^n a_i b_i + sum_(i = 1)^n b_i^2.
  $
  If $a_1 = a_2 = dots = a_n = 0$ the claim is clear; otherwise the coefficient of $lambda^2$ is nonzero,
  so the discriminant of this quadratic in $lambda$ is nonpositive, i.e.,
  $(sum_(i = 1)^n a_i b_i)^2 <= (sum_(i = 1)^n a_i^2)(sum_(i = 1)^n b_i^2)$.
]

#corollary(name: "Vector and Integral Forms of Cauchy-Schwarz")[
  - *Vector form:* for $bold(a) = (a_1, a_2, dots, a_n)$ and $bold(b) = (b_1, b_2, dots, b_n)$,
    $abs(bold(a)) abs(bold(b)) >= abs(bold(a) dot bold(b))$.
  - *Integral form:* $(integral f(x) g(x) dif x)^2 <= (integral f(x)^2 dif x)(integral g(x)^2 dif x)$.
] <cor:cauchy-schwarz-forms>

#theorem(name: "Carlson's Inequality")[
  For positive numbers,
  $
    (x_1 + y_1 + dots)(x_2 + y_2 + dots) dots (x_n + y_n + dots) >= [(product_(i = 1)^n x_i)^(1 / n) + (product_(i = 1)^n y_i)^(1 / n) + dots]^n,
  $
  equivalently,
  $
    (x_1^n + y_1^n + dots)(x_2^n + y_2^n + dots) dots (x_n^n + y_n^n + dots) >= (product_(i = 1)^n x_i + product_(i = 1)^n y_i + dots)^n.
  $
] <thm:carlson>

#theorem(name: "Lagrange's Identity")[
  $
    sum_(i = 1)^n a_i^2 sum_(i = 1)^n b_i^2 - (sum_(i = 1)^n a_i b_i)^2
    = 1 / 2 sum_(k = 1)^n sum_(i = 1)^n (a_k b_i - a_i b_k)^2.
  $
] <thm:lagrange-identity>

#theorem(name: "Fan Ky Inequality")[
  Let $0 < x_i <= 1 / 2$ for $i = 1, 2, dots, n$. Then
  $
    (product_(i = 1)^n x_i) / ((sum_(i = 1)^n x_i)^n) <= (product_(i = 1)^n (1 - x_i)) / ((sum_(i = 1)^n (1 - x_i))^n).
  $
] <thm:fan-ky>

#proof[
  *Step 1 ($n = 2$).* For $x_1 != x_2$ a direct computation gives
  $
    (x_1 x_2) / ((1 - x_1)(1 - x_2)) - ((x_1 + x_2) / ((1 - x_1) + (1 - x_2)))^2
    = ((x_1 - x_2)^2 (x_1 + x_2 - 1)) / (2 (1 - x_1)(1 - x_2)(2 - x_1 - x_2)) < 0, quad (1)
  $
  because $x_1 + x_2 <= 1$; for $x_1 = x_2$ the inequality follows by a limit argument. Hence
  $
    (x_1 x_2) / ((1 - x_1)(1 - x_2)) <= ((x_1 + x_2) / ((1 - x_1) + (1 - x_2)))^2.
  $

  *Step 2 ($n = 2^m$).* Pairing the $2^m$ numbers, applying (1) to each pair and iterating $m$ times yields
  $
    (product_(i = 1)^(2^m) x_i) / (product_(i = 1)^(2^m) (1 - x_i)) <= ((sum_(i = 1)^(2^m) x_i) / (sum_(i = 1)^(2^m) (1 - x_i)))^(2^m).
  $

  *Step 3 (reverse induction).* Suppose the inequality holds for some $n >= 2$ and let
  $A = (x_1 + dots + x_(n - 1)) / (n - 1)$. Applying it to the $n$ numbers $x_1, dots, x_(n - 1), A$
  and simplifying gives the inequality for the $n - 1$ numbers $x_1, dots, x_(n - 1)$.
  Together with Step 2 this proves the theorem for all $n$.
]

#note[
  The arithmetic-geometric mean inequality can be viewed as the limiting form of the Fan Ky inequality:
  applying #link(<thm:fan-ky>)[the Fan Ky inequality] to the $n$ numbers $x_1 / a, dots, x_n / a$, where $a in bb(R)^+$ and $0 < x_i < a / 2$,
  and letting $a -> +oo$ recovers #link(<thm:mean-inequalities>)[the mean value inequalities].
]

#example(name: "A Logarithmic Inequality")[
  Let $k in bb(N)^+$. Prove that
  $
    k / (n + k) < ln(1 + k / n) < k / n.
  $
] <ex:log-inequality>

#solution[
  By the AM-GM inequality applied to the $n + 1$ numbers $1, 1 + k / n, dots, 1 + k / n$,
  $
    (1 + k / n)^n < ((1 + n (1 + k / n)) / (n + 1))^(n + 1) = (1 + k / (n + 1))^(n + 1),
  $
  and similarly $(n / (n + k))^(n + k) < ((n + 1) / (n + 1 + k))^(n + k + 1)$,
  so $(1 + k / n)^(n + k)$ is decreasing in $n$.
  Since $lim_(n -> oo) (1 + k / n)^n = e^k$, we obtain $(1 + k / n)^n < e^k < (1 + k / n)^(n + k)$.
  Taking natural logarithms gives $k / (n + k) < ln(1 + k / n) < k / n$.
]

#example(name: "Bounds for the Factorial")[
  Prove that
  $
    ((n + 1) / e)^n < n! < e ((n + 1) / e)^(n + 1).
  $
] <ex:factorial-bounds>

#solution[
  From $(1 + 1 / n)^n < e < (1 + 1 / n)^(n + 1)$, taking $n = 1, 2, dots, n$ gives
  $(2 / 1)^1 < e < (2 / 1)^2$, $(3 / 2)^2 < e < (3 / 2)^3$, $dots$, $((n + 1) / n)^n < e < ((n + 1) / n)^(n + 1)$.
  Multiplying all these inequalities,
  $
    ((n + 1)^n) / n! < e^n < ((n + 1)^(n + 1)) / n!,
  $
  which rearranges to $((n + 1) / e)^n < n! < e ((n + 1) / e)^(n + 1)$.
]

#example(name: "Bounds for a Power Sum")[
  Let $S_n = 1 + 2^2 + 3^3 + dots + n^n$, where $n in bb(N)^+$. Show that for $n >= 2$,
  $
    n^n (1 + 1 / (4 (n - 1))) <= S_n <= n^n (1 + 2 / (e (n - 1))).
  $
] <ex:power-sum-bounds>

#solution[
  The case $n = 2$ is immediate. Let $u_n = n^n$ and $v_n = (1 - 1 / n)^n$.
  Then $u_(n - 1) / u_n = ((n - 1) / n)^n dot 1 / (n - 1) = v_n / (n - 1)$.
  The sequence $v_n$ is increasing with limit $e^(-1)$, and $v_2 = 1 / 4 < v_n < e^(-1)$ for $n >= 3$.

  For the upper bound, $S_(n - 1) = u_1 + u_2 + dots + u_(n - 1) < (n - 1) u_(n - 1) = (n - 1)^n < n^n = u_n$,
  so $S_n < 2 u_n$. Moreover $S_(n - 1) < 2 u_(n - 1) = 2 u_n dot v_n / (n - 1) < 2 u_n / (e (n - 1))$, hence
  $
    S_n = S_(n - 1) + u_n < u_n (1 + 2 / (e (n - 1))).
  $

  For the lower bound, since $v_n > v_2 = 1 / 4$ we have $u_(n - 1) = u_n dot v_n / (n - 1) > u_n / (4 (n - 1))$,
  whence for $n >= 3$,
  $
    S_n = S_(n - 2) + u_(n - 1) + u_n > u_(n - 1) + u_n > u_n (1 + 1 / (4 (n - 1))).
  $

  Combining the two estimates gives the claim.
]

== Factorial Power // 阶乘幂

#definition(name: "Rising and Falling Factorials")[
  Rising factorials and falling factorials can be expressed in multiple notations.

  The Pochhammer symbol, introduced by Leo August Pochhammer, is one of the commonly used notations,
  represented as $x^((n))$ or $(x)_n$.

  Ronald Graham, Donald Ervin Knuth, and Oren Patashnik introduced the symbols
  $x^(overline(n))$ and $x^(underline(n))$ in their book _Concrete Mathematics_.

  *Definitions:*
  - *Rising factorial:*
    $
      x^overline(n) = x (x + 1) (x + 2) dots (x + n - 1) = ((x + n - 1)!) / ((x - 1)!).
    $
  - *Falling factorial:*
    $
      x^underline(n) = x (x - 1) (x - 2) dots (x - n + 1) = (x!) / ((x - n)!).
    $

  *Relationships:*
  - Relationship between rising and falling factorials:
    $
      x^overline(n) = (x + n - 1)^underline(n).
    $
  - Relationship with factorial:
    $
      1^overline(n) = n^underline(n) = n!.
    $
] <def:factorial-power>

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

#bibliography("references.bib", title: "References // 参考文献", full: true)
