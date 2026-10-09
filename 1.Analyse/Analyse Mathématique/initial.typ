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
  Other notations include: $R[a, b]$ (dein.notg Riemann integrable functions on $[a, b]$),
  $B[a, b]$ (dein.notg bounded functions on $[a, b]$), etc.
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
= Limits of Sequences and Continuity of Real Number System // 序列极限与实数系连续性

== Convergent Sequences // 收敛序列

*Convergent Sequences:*

*Properties of Convergent Sequences:*

*Cauchy Proposition and Fitting Method:*

#proposition(name: "Cauchy's Proposition")[
  Let $lim_(n -> oo) x_n = l$. Then
  $
    lim_(n -> oo) (x_1 + x_2 + dots + x_n) / n = l.
  $
] <prop:cauchy-proposition>

#note[
  + In the proposition, $l$ can also be $+oo$ or $-oo$.
  + Let $lim_(n -> oo) x_n = l$. Then
    $
      lim_(n -> oo) (x_1 + x_2 + dots + x_n) / n
      = lim_(n -> oo) root(n, x_1 x_2 dots x_n)
      = lim_(n -> oo) n / (1 / x_1 + 1 / x_2 + dots + 1 / x_n)
      = l.
    $
]

This can be proved directly by #link(<thm:stolz-cesaro>)[the Stolz theorem];
on top of that, it can also be proved by the *fitting method*.

#note[
  To prove $lim_(n -> oo) x_n = A$, the key is to show that $abs(x_n - A)$ can be arbitrarily small.
  For this purpose, it is generally recommended to simplify the expression of $x_n$ as much as possible.
  However, in some cases, $A$ can also be transformed into a form similar to $x_n$.
  This method is called the *fitting method*.
  The core idea behind the method of fitting is to appropriately divide into units of $1$ for analysis.
]

== Indeterminate Form // 未定式

*Infinitely Large Quantities and Infinitesimal Quantities:*

*Indeterminate Forms:*

#theorem(name: "Stolz-Cesàro Theorem")[
  *Type $0 / 0$:* Let ${a_n}$ and ${b_n}$ be two infinitesimal sequences,
  where ${a_n}$ is also strictly monotonically decreasing. If
  $
    lim_(n -> oo) (b_(n + 1) - b_n) / (a_(n + 1) - a_n) = l quad (text("finite or ") plus.minus oo),
  $
  then
  $
    lim_(n -> oo) a_n / b_n = l.
  $

  *Type $text("*") / oo$:* Let ${a_n}$ be a strictly monotonically increasing sequence
  of divergent large quantities. If
  $
    lim_(n -> oo) (b_(n + 1) - b_n) / (a_(n + 1) - a_n) = l quad (text("finite or ") plus.minus oo),
  $
  then
  $
    lim_(n -> oo) a_n / b_n = l.
  $
] <thm:stolz-cesaro>

#note[
  + The inverse proposition of the Stolz theorem does not hold.
  + If $a_1$ is an undefined infinite quantity $oo$, the Stolz theorem does not hold.
]

#theorem(name: "Silverman-Toeplitz Theorem")[
  Let
  $
    mat(y_1; y_2; dots.v; y_n; dots.v)
    = mat(a_(11), 0, dots, 0; a_(21), a_(22), dots, 0; dots.v, dots.v, dots.down, dots.v; a_(n 1), a_(n 2), dots, a_(n n); dots.v, dots.v, , dots.v)
    mat(x_1; x_2; dots.v; x_n; dots.v),
  $
  where the infinite triangular matrix satisfies:
  + $forall j, lim_(n -> oo) a_(n j) = 0$ (every column sequence converges to $0$);
  + $sup_(i in bb(N)) sum_(j = 1)^i abs(a_(i j)) < oo$ (the absolute row sums are bounded).
  And $lim_(n -> oo) x_n = l$. We denote $y_n$ as the weighted sum sequence: $y_n = sum_(j = 1)^n a_(n j) x_j$.
  Then the following results hold:
  + If $l = 0$, then $lim_(n -> oo) y_n = 0$.
  + If $l != 0$ and $lim_(n -> oo) sum_(j = 1)^n a_(i j) = 1$, then $lim_(n -> oo) y_n = l$.
] <thm:silverman-toeplitz>

== Subsequences // 子列

*Subsequences:*

#definition(name: "Subsequence")[
  Let ${x_n}$ be a sequence and let $n_1 < n_2 < dots < n_k < n_(k + 1) < dots$
  be a strictly increasing sequence of positive integers.
  Then $x_(n_1), x_(n_2), dots$ also forms a sequence, called a *subsequence* of ${x_n}$,
  denoted ${x_(n_k)}$. Clearly $n_k >= k$ for $k in bb(N)$.
] <def:subsequence>

#proposition(name: "Properties of Subsequences")[
  + If ${x_n}$ converges to $a$, then every subsequence of ${x_n}$ converges to $a$;
    the contrapositive is often used to prove divergence.
  + If both the odd subsequence and the even subsequence of ${x_n}$ converge to $a$,
    then ${x_n}$ converges to $a$.
  + If ${x_(2 k)}$, ${x_(2 k + 1)}$ and ${x_(3 k)}$ all converge, then ${x_n}$ converges.
] <prop:subsequence-properties>

#proof[
  + From $lim_(n -> oo) x_n = a$, for every $epsilon > 0$ there exists $N$
    with $abs(x_n - a) < epsilon$ for all $n > N$. Take $K = N$;
    for $k > K$ we have $n_k > k > K > N$, hence $abs(x_(n_k) - a) < epsilon$.
  + For every $epsilon_1 > 0$ there exists $N_1$ with $abs(x_(2 n + 1) - a) < epsilon_1$ for $n > N_1$;
    for every $epsilon_2 > 0$ there exists $N_2$ with $abs(x_(2 n) - a) < epsilon_2$ for $n > N_2$.
    Taking $N = max(2 N_1 + 1, 2 N_2)$, for $n > N$ we get
    $abs(x_n - a) < max(epsilon_1, epsilon_2)$, hence ${x_n}$ converges to $a$.
  + Let the limits of the three subsequences be $alpha, beta, gamma$ respectively.
    The subsequence ${x_(6 k - 3)}$ is contained in both ${x_(2 k + 1)}$ and ${x_(3 k)}$, so $alpha = gamma$;
    the subsequence ${x_(6 k)}$ is contained in both ${x_(2 k)}$ and ${x_(3 k)}$, so $beta = gamma$.
    Hence $alpha = beta$, and ${x_n}$ converges to the same limit by item 2.
]

*Upper Limits and Lower Limits:*

A limit of a convergent subsequence of ${x_n}$ is called a *limit point* (cluster point) of the sequence.

#definition(name: "Upper and Lower Limits (First Definition)")[
  Let ${x_n}$ be a sequence, and let $E$ be the set of limits of all its convergent subsequences
  in the extended real number system, i.e., $E = {x \| lim_(k -> oo) x_(n_k) = x}$.
  Clearly $E$ is nonempty (and bounded for a bounded sequence), so its supremum and infimum exist;
  write $H = sup E$ and $h = inf E$, called the *limit superior* and the *limit inferior* of ${x_n}$:
  $
    H = limsup_(n -> oo) x_n, quad h = liminf_(n -> oo) x_n.
  $
] <def:limsup-first>

#proposition(name: "Maximality of the Limit Superior and Inferior")[
  With the notation of #link(<def:limsup-first>)[the first definition], $H = max E$ and $h = min E$.
] <prop:limsup-maximal>

#proof[
  It suffices to show $H = sup E in E$; suppose instead $H in.not E$.
  *Step 1.* We first construct a strictly increasing sequence ${xi_k} subset E$ with $lim_(k -> oo) xi_k = H$.
  Since $H in.not E$, for every $epsilon > 0$ there exists $x in E$ with $H - epsilon < x < H$.
  Taking $epsilon_1 = 1$, there is $xi_1 in E$ with $H - 1 < xi_1 < H$.
  Taking $epsilon_2 = min(1 / 2, H - xi_1) > 0$, there is $xi_2 in E$ with $H - epsilon_2 < xi_2 < H$,
  where $xi_1 <= H - epsilon_2 < xi_2$. Iterating with $epsilon_k = min(1 / k, H - xi_(k - 1)) > 0$
  produces a strictly increasing sequence ${xi_k}$ in $E$ with $lim_(k -> oo) xi_k = H$.
  *Step 2.* Since each $xi_k$ is a cluster point of ${x_n}$, there exist indices $n_1 < n_2 < dots$
  with $xi_k - 1 / k < x_(n_k) < xi_k + 1 / k$ for every $k$.
  Letting $k -> oo$ gives $lim_(k -> oo) x_(n_k) = lim_(k -> oo) xi_k = H$, i.e., $H in E$,
  contradicting the assumption.
]

#proposition(name: "Epsilon-Characterization of the Limit Superior")[
  Let ${x_n}$ be a bounded sequence. Then:
  + $H = limsup_(n -> oo) x_n$ if and only if for every $epsilon > 0$:
    (i) there exists $N in bb(N)^+$ with $x_n < H + epsilon$ for all $n > N$;
    (ii) infinitely many terms of ${x_n}$ satisfy $x_n > H - epsilon$.
  + $h = liminf_(n -> oo) x_n$ if and only if for every $epsilon > 0$:
    (i) there exists $N in bb(N)^+$ with $x_n > h - epsilon$ for all $n > N$;
    (ii) infinitely many terms of ${x_n}$ satisfy $x_n < h + epsilon$.
] <prop:limsup-epsilon>

#proof[
  We prove item 1; item 2 is symmetric.
  ($=>$) Since $H$ is the largest cluster point of ${x_n}$, for every $epsilon > 0$
  the interval $[H + epsilon, +oo)$ contains at most finitely many terms of ${x_n}$.
  Let $n_0$ be the largest index among these finitely many terms; taking $N = n_0$
  gives $x_n < H + epsilon$ for all $n > N$, which is (i).
  Since $H$ is a cluster point of ${x_n}$, infinitely many terms lie in the $epsilon$-neighborhood of $H$,
  and these satisfy $x_n > H - epsilon$, which is (ii).
  ($<=$) By (i), $limsup_(n -> oo) x_n <= H + epsilon$ for every $epsilon > 0$,
  hence $limsup_(n -> oo) x_n <= H$.
  By (ii), $limsup_(n -> oo) x_n >= H - epsilon$ for every $epsilon > 0$,
  hence $limsup_(n -> oo) x_n >= H$.
  Therefore $limsup_(n -> oo) x_n = H$.
]

#theorem(name: "Convergence Criterion via Upper and Lower Limits")[
  A bounded sequence ${x_n}$ converges if and only if
  $
    limsup_(n -> oo) x_n = liminf_(n -> oo) x_n.
  $
] <thm:bounded-convergence-limsup>

#definition(name: "Upper and Lower Limits (Second Definition)")[
  Let ${x_n}$ be a bounded sequence and set
  $
    b_n = sup_(k >= n) x_k, quad a_n = inf_(k >= n) x_k.
  $
  Then ${a_n}$ is increasing and bounded above, and ${b_n}$ is decreasing and bounded below,
  so both converge. Define
  $
    H = lim_(n -> oo) b_n = lim_(n -> oo) sup_(k >= n) x_k, quad
    h = lim_(n -> oo) a_n = lim_(n -> oo) inf_(k >= n) x_k.
  $
] <def:limsup-second>

#theorem(name: "Equivalence of the Two Definitions")[
  With the notation of #link(<def:limsup-second>)[the second definition],
  $H$ is the largest cluster point of ${x_n}$ and $h$ is the smallest one,
  i.e., the two definitions of #link(<def:limsup-first>)[the upper and lower limits] agree: $H = max E$, $h = min E$.
] <thm:limsup-equivalence>

#proof[
  *Step 1.* Let $xi$ be any cluster point of ${x_n}$ (finite, $+oo$ or $-oo$). We show $h <= xi <= H$.
  Let $lim_(k -> oo) x_(n_k) = xi$. For every $k$ we have $a_(n_k) <= x_(n_k) <= b_(n_k)$;
  letting $k -> oo$ yields $h <= xi <= H$.
  *Step 2.* We construct subsequences with limits $H$ and $h$; consider $H$.
  - If $H$ is finite, take $epsilon_k = 1 / k$ for $k = 1, 2, dots$.
    From $b_1 = sup_(i >= 1) x_i$ choose $n_1$ with $b_1 - 1 < x_(n_1) <= b_1$;
    from $b_(n_1) = sup_(i > n_1) x_i$ choose $n_2 > n_1$ with $b_(n_1) - 1 / 2 < x_(n_2) <= b_(n_1)$, and so on:
    from $b_(n_k) = sup_(i > n_k) x_i$ choose $n_(k + 1) > n_k$ with $b_(n_k) - 1 / (k + 1) < x_(n_(k + 1)) <= b_(n_k)$.
    Letting $k -> oo$ gives $lim_(k -> oo) x_(n_k) = lim_(k -> oo) b_(n_k) = lim_(n -> oo) b_n = H$.
  - If $H = +oo$ (i.e., ${x_n}$ is unbounded above), one can similarly select a subsequence
    diverging to $+oo$; the case $H = -oo$ has been handled by the convergence of ${b_n}$.
  The construction for $h$ is entirely analogous. Hence $H = max E$ and $h = min E$.
]

#theorem(name: "Arithmetic of Upper and Lower Limits")[
  Let ${x_n}$ and ${y_n}$ be two sequences.
  - *Addition:*
    + $limsup_(n -> oo) (x_n + y_n) <= limsup_(n -> oo) x_n + limsup_(n -> oo) y_n$,
      $liminf_(n -> oo) (x_n + y_n) >= liminf_(n -> oo) x_n + liminf_(n -> oo) y_n$.
    + If $lim_(n -> oo) x_n$ exists, then
      $limsup_(n -> oo) (x_n + y_n) = lim_(n -> oo) x_n + limsup_(n -> oo) y_n$,
      $liminf_(n -> oo) (x_n + y_n) = lim_(n -> oo) x_n + liminf_(n -> oo) y_n$.
      (The right-hand sides must not be indeterminate, e.g., $(+oo) + (-oo)$.)
  - *Multiplication:*
    + If $x_n >= 0$ and $y_n >= 0$, then
      $limsup_(n -> oo) (x_n y_n) <= limsup_(n -> oo) x_n dot limsup_(n -> oo) y_n$,
      $liminf_(n -> oo) (x_n y_n) >= liminf_(n -> oo) x_n dot liminf_(n -> oo) y_n$.
    + If $lim_(n -> oo) x_n = x$ with $0 < x < +oo$, then
      $limsup_(n -> oo) (x_n y_n) = lim_(n -> oo) x_n dot limsup_(n -> oo) y_n$,
      $liminf_(n -> oo) (x_n y_n) = lim_(n -> oo) x_n dot liminf_(n -> oo) y_n$.
] <thm:limsup-arithmetic>

== Completeness of the Real Numbers // 实数系的完备性

*Dedekind Completeness:*

#definition(name: "Dedekind Cut")[
  Let $bb(A)$ and $bb(B)$ be two nonempty sets of rational numbers such that
  $bb(Q) = bb(A) union bb(B)$ and $a < b$ for all $a in bb(A)$, $b in bb(B)$;
  then $bb(A)$ and $bb(B)$ are said to form a *cut* of $bb(Q)$, denoted $bb(A) | bb(B)$.
  For any cut $bb(A) | bb(B)$ of $bb(Q)$, exactly one of the following four cases holds:
  (i) $bb(A)$ has a largest element and $bb(B)$ has no smallest;
  (ii) $bb(A)$ has no largest element and $bb(B)$ has a smallest;
  (iii) $bb(A)$ has no largest element and $bb(B)$ has no smallest;
  (iv) $bb(A)$ has a largest element and $bb(B)$ has a smallest.
  Case (iv) is impossible.
  If case (iii) occurs, the cut $bb(A) | bb(B)$ is said to define an *irrational number* $c$,
  with $a < c < b$ for all $a in bb(A)$, $b in bb(B)$.
  The set consisting of all rationals together with all irrational numbers defined in (iii)
  is called the set of real numbers, denoted $bb(R)$.
  Similarly, two nonempty sets of real numbers $tilde(bb(A))$ and $tilde(bb(B))$
  with $tilde(bb(A)) union tilde(bb(B)) = bb(R)$ and $a < b$ for all $a in tilde(bb(A))$, $b in tilde(bb(B))$
  are said to form a *cut* of $bb(R)$, denoted $tilde(bb(A)) | tilde(bb(B))$.
] <def:dedekind-cut>

#theorem(name: "Dedekind's Theorem")[
  Let $tilde(bb(A)) | tilde(bb(B))$ be a cut of the real number set $bb(R)$.
  Then either $tilde(bb(A))$ has a largest element, or $tilde(bb(B))$ has a smallest element.
] <thm:dedekind>

#proof[
  Let $bb(A)$ and $bb(B)$ be the sets of rational numbers in $tilde(bb(A))$ and $tilde(bb(B))$, respectively;
  they form a cut $bb(A) | bb(B)$ of $bb(Q)$, which falls into one of the cases (i)--(iii)
  of #link(<def:dedekind-cut>)[the definition of a Dedekind cut].
  *Case (i).* Let $a_0$ be the largest element of $bb(A)$. Then $a_0$ is also the largest element of $tilde(bb(A))$:
  if some $tilde(a) in tilde(bb(A))$ satisfied $a_0 < tilde(a)$, by the density of the rationals
  there would exist a rational $a$ with $a_0 < a < tilde(a)$, contradicting the maximality of $a_0$ in $bb(A)$.
  Moreover $tilde(bb(B))$ has no smallest element: for any $tilde(b) in tilde(bb(B))$,
  since $a_0 < tilde(b)$ there exists a rational $b$ with $a_0 < b < tilde(b)$,
  and then $b in bb(B) subset tilde(bb(B))$ with $b < tilde(b)$.
  *Case (ii).* Symmetric to case (i).
  *Case (iii).* Let $c$ be the irrational number determined by the cut, with $a < c < b$
  for all $a in bb(A)$, $b in bb(B)$. Since $c in bb(R) = tilde(bb(A)) union tilde(bb(B))$,
  either $c in tilde(bb(A))$ or $c in tilde(bb(B))$.
  If $c in tilde(bb(A))$, then $c$ must be the largest element of $tilde(bb(A))$:
  otherwise some $tilde(a) in tilde(bb(A))$ with $c < tilde(a)$ would again produce a rational number in $(c, tilde(a))$,
  contradicting the definition of $c$; similarly, $c in tilde(bb(B))$ forces $c$ to be the smallest element of $tilde(bb(B))$.
]

*Least Upper Bound Property:*

#definition(name: "Supremum and Infimum")[
  Let $S$ be a set of real numbers. A number $beta$ is called the *supremum* (least upper bound) of $S$,
  written $beta = sup S$, if:
  (1) $beta$ is an upper bound of $S$: $x <= beta$ for all $x in S$;
  (2) no number smaller than $beta$ is an upper bound of $S$:
  for every $epsilon > 0$ there exists $x in S$ with $x > beta - epsilon$.
  The *infimum* (greatest lower bound) $inf S$ is defined similarly.
] <def:sup-inf>

#theorem(name: "Principle of Existence of Suprema")[
  Every nonempty set of real numbers that is bounded above (below) has a supremum (infimum).
] <thm:supremum-existence>

#proof[
  Let $S$ be a nonempty set of real numbers bounded above, and let
  $tilde(bb(B)) = {y \| y >= t" for all "t in S}$ be the set of upper bounds of $S$, with $tilde(bb(A))$ its complement.
  Then $tilde(bb(A)) | tilde(bb(B))$ is a cut of $bb(R)$, so by #link(<thm:dedekind>)[Dedekind's theorem]
  either $tilde(bb(A))$ has a largest element or $tilde(bb(B))$ has a smallest one.
  For any $x in tilde(bb(A))$, $x$ is not an upper bound of $S$, so there exists $t in S$ with $x < t$.
  Then $x^* = (x + t) / 2$ satisfies $x < x^* < t$, and $x^* < t$ shows that $x^*$ is still not an upper bound of $S$,
  i.e., $x^* in tilde(bb(A))$; since $x < x^*$, $x$ is not the largest element of $tilde(bb(A))$.
  Hence $tilde(bb(A))$ has no largest element, so $tilde(bb(B))$ has a smallest element,
  which is precisely the supremum of $S$.
]

#theorem(name: "Archimedean Property")[
  For all $x, y in bb(R)$ with $x > 0$, there exists $n in bb(N)^+$ such that $n x > y$.
] <thm:archimedean>

#proof[
  Suppose not; then $n x <= y$ for all $n in bb(N)^+$, i.e., $y$ is an upper bound of the set
  $A = {n x \| n in bb(N)^+}$. By #link(<thm:supremum-existence>)[the principle of existence of suprema],
  $A$ has a supremum $alpha$. Then $alpha - x$ is not an upper bound of $A$,
  so there exists $m in bb(N)^+$ with $m x > alpha - x$, i.e., $alpha < (m + 1) x$;
  but $(m + 1) x in A$, a contradiction.
]

*Monotone Convergence Theorem:*

#theorem(name: "Monotone Convergence Theorem")[
  A monotone bounded sequence of real numbers converges.
] <thm:monotone-convergence>

#proof[
  Suppose ${x_n}$ is increasing and bounded above. By #link(<thm:supremum-existence>)[the principle of existence of suprema],
  the set formed by ${x_n}$ has a supremum $beta$ satisfying:
  (1) $x_n <= beta$ for all $n in bb(N)^+$;
  (2) for every $epsilon > 0$ there exists $x_(n_0)$ with $x_(n_0) > beta - epsilon$.
  Taking $N = n_0$, for all $n > N$ we have
  $beta - epsilon < x_(n_0) <= x_n <= beta$, i.e., $abs(x_n - beta) < epsilon$.
  Hence $lim_(n -> oo) x_n = beta$. The decreasing case is symmetric.
]

*Bolzano-Weierstrass Theorem:*

#theorem(name: "Bolzano-Weierstrass Theorem")[
  Every bounded sequence of real numbers has a convergent subsequence.
  Equivalently, every bounded infinite set of real numbers has at least one cluster point
  (sequential compactness on a closed interval $[a, b]$).
] <thm:bolzano-weierstrass>

#proof[
  Let ${x_n}$ be bounded, so that $a_1 <= x_n <= b_1$ for all $n = 1, 2, 3, dots$.
  Bisect $[a_1, b_1]$ into $[a_1, (a_1 + b_1) / 2]$ and $[(a_1 + b_1) / 2, b_1]$;
  at least one of them contains infinitely many terms of ${x_n}$; call it $[a_2, b_2]$.
  Repeating this construction yields a nested sequence of closed intervals ${[a_k, b_k]}$,
  each containing infinitely many terms of ${x_n}$. By #link(<thm:nested-interval>)[the nested interval theorem],
  there exists $xi in bb(R)$ with $xi = lim_(k -> oo) a_k = lim_(k -> oo) b_k$.
  Now choose $x_(n_1)$ among the terms lying in $[a_1, b_1]$;
  since $[a_2, b_2]$ contains infinitely many terms, choose one with index $n_2 > n_1$, and so on.
  This produces a subsequence with $a_k <= x_(n_k) <= b_k$ for every $k$,
  and the squeeze theorem gives $lim_(k -> oo) x_(n_k) = xi$.
]

#note[
  If ${x_n}$ is unbounded, then there exists a subsequence ${x_(n_k)}$ with
  $lim_(k -> oo) x_(n_k) = oo$: since ${x_n}$ is unbounded, for every $M > 0$
  there are infinitely many terms with $abs(x_n) > M$;
  picking one for $M = 1, 2, 3, dots$ in turn yields a subsequence diverging to infinity.
]

*Nested Interval Theorem:*

#definition(name: "Nested Closed Intervals")[
  A sequence of closed intervals ${[a_n, b_n]}$ is called a *nested sequence of closed intervals* if:
  (1) $[a_(n + 1), b_(n + 1)] subset [a_n, b_n]$ for $n = 1, 2, 3, dots$;
  (2) $lim_(n -> oo) (b_n - a_n) = 0$.
] <def:nested-intervals>

#theorem(name: "Nested Interval Theorem")[
  If ${[a_n, b_n]}$ is a nested sequence of closed intervals, then there exists a unique real number $xi$
  belonging to all of the intervals $[a_n, b_n]$, and
  $
    xi = lim_(n -> oo) a_n = lim_(n -> oo) b_n.
  $
] <thm:nested-interval>

#proof[
  Since $a_1 <= a_2 <= dots <= a_(n - 1) <= a_n <= b_n <= dots <= b_(n - 1) <= b_1$,
  the sequence ${a_n}$ is increasing and bounded above, and ${b_n}$ is decreasing and bounded below,
  so both converge by #link(<thm:monotone-convergence>)[the monotone convergence theorem].
  Let $lim_(n -> oo) a_n = xi$; then
  $
    lim_(n -> oo) b_n = lim_(n -> oo) (b_n - a_n) + lim_(n -> oo) a_n = xi,
  $
  and $a_n <= xi <= b_n$ for all $n$, i.e., $xi$ belongs to every closed interval.
  If some $xi'$ also belonged to every $[a_n, b_n]$, then by the squeeze theorem
  $xi' = lim_(n -> oo) a_n = lim_(n -> oo) b_n = xi$, proving uniqueness.
]

*Cauchy Completeness:*

#definition(name: "Cauchy Sequence")[
  A sequence ${x_n}$ is called a *Cauchy sequence* if for any $epsilon > 0$,
  there exists a positive integer $N$ such that when $m, n > N$,
  $
    abs(x_n - x_m) < epsilon.
  $
] <def:cauchy-sequence>

#theorem(name: "Cauchy Convergence Criterion for Sequences")[
  A sequence ${x_n}$ converges if and only if it is a Cauchy sequence.
] <thm:cauchy-criterion>

#proof[
  We prove the criterion in $bb(R)$.
  *Necessity.* Let ${x_n}$ converge to $a$. For every $epsilon > 0$ there exists $N in bb(N)$
  such that for $n > N$, $abs(x_n - a) < epsilon$. Hence for $m, n > N$,
  $
    abs(x_m - x_n) <= abs(x_m - a) + abs(x_n - a) < 2 epsilon.
  $
  *Sufficiency.* First, a Cauchy sequence is bounded: taking $epsilon_0 = 1$,
  there exists $N_0$ with $abs(x_n - x_(N_0 + 1)) < 1$ for all $n > N_0$.
  Let $M = max(abs(x_1), abs(x_2), dots, abs(x_(N_0 + 1))) + 1$; then $abs(x_n) < M$ for all $n$.
  By #link(<thm:bolzano-weierstrass>)[the Bolzano-Weierstrass theorem], ${x_n}$ has a convergent subsequence
  ${x_(n_k)}$ with $lim_(k -> oo) x_(n_k) = xi$.
  Furthermore, for every $epsilon > 0$ there exists $N in bb(N)$ such that $abs(x_n - x_m) < epsilon$
  for $m, n > N$; taking $m = n_k$ with $k$ large enough that $n_k > N$ and letting $k -> oo$
  gives $abs(x_n - xi) <= epsilon$. Hence $lim_(n -> oo) x_n = xi$.
]

#caution[
  The proposition "$lim_(n -> oo) a_n = a$ if and only if $lim_(n -> oo) abs(a_(n + p) - a_p) = 0$
  for any natural number $p$" is wrong: the condition must hold *simultaneously* for all $p in bb(N)$,
  whereas the leading $forall epsilon > 0$ in the definition means "for each given ...".
]

#definition(name: "Completeness")[
  A set $E$ is called *complete* if $E$ is a closed set and every point of $E$ is a limit point of $E$,
  i.e., $E = overline(E)$, which is equivalent to: Cauchy sequences in $E$ are exactly the
  convergent sequences in $E$.
] <def:completeness>

*Heine-Borel Theorem:*

#definition(name: "Open Cover")[
  Let $[a, b] subset union_(alpha) cal(O)_alpha$, where each $cal(O)_alpha$ is an open set.
  Then ${cal(O)_alpha}$ is called an *open cover* of $[a, b]$.
] <def:open-cover>

#theorem(name: "Heine-Borel Finite Covering Theorem")[
  If ${cal(O)_alpha}$ is an open cover of $[a, b]$, then there exists a finite subcollection
  ${cal(O)_1, cal(O)_2, dots, cal(O)_n}$ of ${cal(O)_alpha}$ that still covers $[a, b]$,
  i.e., $[a, b] subset union_(i = 1)^n cal(O)_i$.
  In brief: every open cover of $[a, b]$ admits a finite subcover.
] <thm:heine-borel>

*Equivalence of the Completeness Theorems:*

#theorem(name: "Equivalence of the Completeness Theorems")[
  The following theorems are mutually equivalent: #link(<thm:dedekind>)[Dedekind's theorem],
  #link(<thm:supremum-existence>)[the principle of existence of suprema],
  #link(<thm:monotone-convergence>)[the monotone convergence theorem],
  #link(<thm:nested-interval>)[the nested interval theorem],
  #link(<thm:bolzano-weierstrass>)[the Bolzano-Weierstrass theorem],
  #link(<thm:heine-borel>)[the Heine-Borel finite covering theorem],
  and #link(<thm:cauchy-criterion>)[the Cauchy convergence criterion].
  The Cauchy convergence criterion expresses the *completeness* of the real numbers,
  while the principle of existence of suprema (Dedekind's theorem) expresses their *continuity*;
  the mutual derivability of these theorems shows that
  *the continuity of the real numbers is equivalent to their completeness*.
] <thm:completeness-equivalence>

#note[
  The dependency structure is:
  Dedekind's theorem $->$ the principle of existence of suprema $->$ the monotone convergence theorem
  $->$ the nested interval theorem $->$ the Bolzano-Weierstrass theorem $->$ the Cauchy convergence criterion.
  Each theorem can also be used as the starting point to derive the others,
  so any one of them may be taken as the foundation of the real number system.
  Several implications have already been established above:
  suprema $=>$ monotone convergence (its proof), monotone convergence $=>$ nested intervals (its proof),
  nested intervals $=>$ Bolzano-Weierstrass (its proof),
  and Bolzano-Weierstrass $=>$ Cauchy (the sufficiency part of its proof).
  Below we record three more representative derivations.
]

#proposition(name: "Nested Intervals Imply the Existence of Suprema")[
  #link(<thm:nested-interval>)[The nested interval theorem] implies
  #link(<thm:supremum-existence>)[the principle of existence of suprema].
] <prop:nested-implies-suprema>

#proof[
  Let $S$ be a nonempty set of real numbers bounded above, and let $T$ be the set of upper bounds of $S$.
  It suffices to show that $T$ has a smallest element, i.e., that $S$ has a supremum.
  Pick $a_1 in.not T$ and $b_1 in T$; clearly $a_1 < b_1$. Write $m_n = (a_n + b_n) / 2$ and set
  $[a_(n + 1), b_(n + 1)] = [a_n, m_n]$ if $m_n in T$, and $[a_(n + 1), b_(n + 1)] = [m_n, b_n]$ otherwise.
  This produces a nested sequence of closed intervals ${[a_n, b_n]}$
  with $a_n in.not T$ and $b_n in T$ for all $n = 1, 2, 3, dots$.
  By #link(<thm:nested-interval>)[the nested interval theorem], there exists a unique real number $xi$
  belonging to all the intervals, with $xi = lim_(n -> oo) a_n = lim_(n -> oo) b_n$.
  It remains to show that $xi$ is the smallest element of $T$, i.e., the supremum of $S$.
  If $xi in.not T$, i.e., $xi$ is not an upper bound of $S$, then there exists $x in S$ with $xi < x$;
  since $lim_(n -> oo) b_n = xi$, for $n$ large enough we have $b_n < x$, contradicting $b_n in T$. Hence $xi in T$.
  If some $eta in T$ satisfied $eta < xi$, then since $lim_(n -> oo) a_n = xi$,
  for $n$ large enough we have $eta < a_n$; since $a_n in.not T$,
  there exists $y in S$ with $y > a_n > eta$, contradicting $eta in T$.
  Therefore $xi = sup S$.
]

#proposition(name: "Cauchy Criterion Implies the Monotone Convergence Theorem")[
  #link(<thm:cauchy-criterion>)[The Cauchy convergence criterion] implies
  #link(<thm:monotone-convergence>)[the monotone convergence theorem].
] <prop:cauchy-implies-monotone>

#proof[
  Suppose the increasing bounded sequence ${x_n}$ did not converge.
  Then ${x_n}$ is not a Cauchy sequence: there exist $epsilon_0 > 0$ and indices $m > n > N$
  (for every $N$) with $x_m - x_n >= epsilon_0$.
  Set $N_1 = 1$: there exist $m_1 > m_0 >= N_1$ with $x_(m_1) - x_(m_0) >= epsilon_0$.
  Set $N_2 = m_1$: there exist $m_2 > m_1$ with $x_(m_2) - x_(m_1) >= epsilon_0$, and so on:
  setting $N_k = m_(k - 1)$, there exist $m_k > m_(k - 1)$ with $x_(m_k) - x_(m_(k - 1)) >= epsilon_0$.
  Summing up, $x_(m_k) - x_(m_0) >= k epsilon_0 -> +oo$ as $k -> oo$,
  contradicting the boundedness of ${x_n}$.
]

#proposition(name: "Cauchy Criterion Implies the Nested Interval Theorem")[
  #link(<thm:cauchy-criterion>)[The Cauchy convergence criterion] implies
  #link(<thm:nested-interval>)[the nested interval theorem].
] <prop:cauchy-implies-nested>

#proof[
  Let ${[a_n, b_n]}$ be a nested sequence of closed intervals.
  For $m > n$ we have $0 <= a_m - a_n < b_n - a_n -> 0$ as $n -> oo$,
  so ${a_n}$ is a Cauchy sequence and converges to some $xi$; then
  $
    lim_(n -> oo) b_n = lim_(n -> oo) (b_n - a_n) + lim_(n -> oo) a_n = xi.
  $
  Since ${a_n}$ is increasing and ${b_n}$ is decreasing,
  $xi$ is the unique real number belonging to all the intervals $[a_n, b_n]$.
]

== Iterative Sequences // 迭代序列

Formally, $x_0$ is a *fixed point* of the function $f$ if $f(x_0) = x_0$.

#theorem(name: "Banach Fixed-Point Theorem (Contraction Mapping Theorem)")[
  A contraction mapping (i.e., Lipschitz continuous with constant $L < 1$;
  see the section _Uniform Continuity and Lipschitz Continuity_) $f$ on an interval $I$
  admits a unique fixed point $x^* in I$.
  Furthermore, $x^*$ can be found as follows:
  start with an arbitrary point $x_0 in I$ and define the iterative sequence
  $x_(n + 1) = f(x_n)$ for $n = 0, 1, 2, dots$.
  Then $lim_(n -> oo) x_n = x^*$.
] <thm:banach-fixed-point>

#note[
  The following inequalities are equivalent and describe the speed of convergence:
  $
          abs(x_n - x^*) & <= L^n / (1 - L) abs(x_1 - x_0) \
    abs(x_(n + 1) - x^*) & <= L / (1 - L) abs(x_(n + 1) - x_n) \
    abs(x_(n + 1) - x^*) & <= L abs(x_n - x^*).
  $
  Any such value of $L < 1$ is a Lipschitz constant for $f$,
  and the smallest one is sometimes called *the best Lipschitz constant*.
]

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

#bibliography("references.bib", title: "References", full: true)
