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

=== Convergent Sequences // 收敛序列

#definition(name: "Convergent Sequence")[
  A sequence ${x_n}$ in a metric space $X$ is said to be *convergent* if there exists $a in X$
  with the following property: for every $epsilon > 0$ there exists $N in bb(N)^+$
  such that $d(x_n, a) < epsilon$ for all $n > N$.
  In this case ${x_n}$ is said to converge to $a$, written $lim_(n -> oo) x_n = a$;
  otherwise it is said to be *divergent*.
] <def:convergent-sequence>

#note[
  + In the definition, both "$n > N$" and "$d(x_n, a) < epsilon$" may be replaced by "$>=$",
    and the definition remains correct.
  + $lim_(n -> oo) a_n = A$ if and only if, for every $epsilon > 0$,
    there are only finitely many terms outside the interval $(A - epsilon, A + epsilon)$.
]

#note[
  $lim_(n -> oo) x_n = 0$ if and only if $lim_(n -> oo) abs(x_n) = 0$;
  however, for $a != 0$, $lim_(n -> oo) x_n = a$ does not imply $lim_(n -> oo) abs(x_n) = a$.
]

#definition(name: "Bounded Sequence")[
  A sequence ${x_n}$ that has both an upper bound and a lower bound is called a *bounded sequence*;
  equivalently, there exists $X in bb(R)^+$ such that $abs(x_n) <= X$ for $n = 1, 2, 3, dots$.
] <def:bounded-sequence>

=== Properties of Convergent Sequences // 收敛序列的性质

#proposition(name: "Properties of Convergent Sequences")[
  + *Uniqueness:* the limit of a convergent sequence is unique.
  + *Boundedness:* a convergent sequence is necessarily bounded.
  + *Order preservation:* let ${x_n}$ and ${y_n}$ both converge with
    $lim_(n -> oo) x_n = a$, $lim_(n -> oo) y_n = b$, and $a < b$;
    then there exists $N in bb(N)^+$ such that $x_n < y_n$ for all $n > N$. In particular:
    - if $lim_(n -> oo) y_n = b > 0$, then there exists $N in bb(N)^+$
      with $y_n > b / 2 > 0$ for all $n > N$;
    - if $lim_(n -> oo) x_n = a$, $lim_(n -> oo) y_n = b$, and $x_n < y_n$ for all $n > N$,
      then $a <= b$.
  + *Squeeze:* if $x_n <= y_n <= z_n$ for all $n > N_0$ and $lim_(n -> oo) x_n = lim_(n -> oo) z_n = a$,
    then $lim_(n -> oo) y_n = a$.
  + *Arithmetic operations:* let $lim_(n -> oo) x_n = a$ and $lim_(n -> oo) y_n = b$. Then:
    - $lim_(n -> oo) (alpha x_n + beta y_n) = alpha a + beta b$ for constants $alpha, beta$;
    - $lim_(n -> oo) (x_n y_n) = a b$;
    - $lim_(n -> oo) x_n / y_n = a / b$ for $b != 0$;
    - if $a >= 0$ and $x_n >= 0$, then $lim_(n -> oo) sqrt(x_n) = sqrt(a)$.
] <prop:convergent-sequence-properties>

#caution[
  The limits must exist before the arithmetic rules can be applied.
  The rules extend to finitely many sequences, but not to infinitely many:
  for instance, $lim_(n -> oo) underbrace(1 / n + 1 / n + dots + 1 / n, n "terms") = 1$ rather than $0$.
]

#proof[
  + Let ${x_n}$ have limits $a$ and $b$. For every $epsilon > 0$ there exist $N_1, N_2$
    with $abs(x_n - a) < epsilon / 2$ for $n > N_1$ and $abs(x_n - b) < epsilon / 2$ for $n > N_2$.
    Taking $N = max(N_1, N_2)$, for $n > N$ we have
    $abs(a - b) = abs(a - x_n + x_n - b) <= abs(x_n - a) + abs(x_n - b) < epsilon$.
    Since $epsilon$ is arbitrarily close to $0$, $a = b$.
  + Let ${x_n}$ converge to $a$. Taking $epsilon = 1$, there exists $N$
    with $abs(x_n - a) < 1$ for $n > N$, i.e., $a - 1 < x_n < a + 1$.
    Taking $M = max(abs(x_1), abs(x_2), dots, abs(x_N), abs(a) + 1)$,
    we have $abs(x_n) <= M$ for all $n$.
  + Taking $epsilon = (b - a) / 2 > 0$, by $lim_(n -> oo) x_n = a$ there exists $N_1$
    with $x_n < (a + b) / 2$ for $n > N_1$; similarly there exists $N_2$
    with $y_n > (a + b) / 2$ for $n > N_2$.
    Taking $N = max(N_1, N_2)$, for $n > N$ we have $x_n < (a + b) / 2 < y_n$.
    - It suffices to apply the order-preservation property to the constant sequence $x_n = b / 2$.
    - The strict inequality may be lost in the limit: for example, $a_n = 1 / (4 n)$ and $b_n = 1 / (2 n)$
      satisfy $a_n < b_n$ for all $n >= 1$, yet $lim_(n -> oo) a_n = lim_(n -> oo) b_n = 0$.
  + For every $epsilon > 0$, since $lim_(n -> oo) x_n = a$ there exists $N_1$
    with $a - epsilon < x_n$ for $n > N_1$;
    since $lim_(n -> oo) z_n = a$ there exists $N_2$ with $z_n <= a + epsilon$ for $n > N_2$.
    Taking $N = max(N_0, N_1, N_2)$, for $n > N$ we have
    $a - epsilon < x_n <= y_n <= z_n <= a + epsilon$, i.e., $abs(y_n - a) < epsilon$.
  + Since $lim_(n -> oo) x_n = a$, there exists $X > 0$ with $abs(x_n) < X$ for all $n$,
    and for every $epsilon > 0$ there exists $N_1$ with $abs(x_n - a) < epsilon$ for $n > N_1$;
    likewise there exists $N_2$ with $abs(y_n - b) < epsilon$ for $n > N_2$.
    Taking $N = max(N_1, N_2)$, for $n > N$ we have
    $
      abs(alpha x_n + beta y_n - (alpha a + beta b)) & <= abs(alpha) abs(x_n - a) + abs(beta) abs(y_n - b) \
                                                     & < (abs(alpha) + abs(beta)) epsilon,
    $
    and
    $
      abs(x_n y_n - a b) = abs(x_n (y_n - b) + b (x_n - a)) < (X + abs(b)) epsilon,
    $
    so items 1 and 2 hold.
    For item 3, by the corollary of the order-preservation property there exists $N_0$
    with $abs(y_n) > abs(b) / 2$ for $n > N_0$; taking $N = max(N_0, N_1, N_2)$, for $n > N$ we have
    $
      abs(x_n / y_n - a / b)
      = abs(b (x_n - a) - a (y_n - b)) / abs(y_n b)
      < (2 (abs(a) + abs(b))) / abs(b)^2 epsilon.
    $
    For item 4, it suffices to note
    $abs(sqrt(x_n) - sqrt(a)) <= sqrt(abs(x_n - a)) < sqrt(epsilon)$.
]

=== Cauchy Proposition and Fitting Method // 柯西命题与拟合法

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

=== Infinitely Large Quantities and Infinitesimal Quantities // 无穷大量与无穷小量

#definition(name: "Infinitesimal Quantity")[
  A sequence converging to $0$ is called an *infinitesimal quantity*.
] <def:infinitesimal-quantity>

#definition(name: "Infinite Quantity")[
  A sequence ${x_n}$ is called an *infinite quantity* if for any given $G > 0$,
  there exists $N in bb(N)^+$ such that $abs(x_n) > G$ for all $n > N$,
  written $lim_(n -> oo) x_n = oo$.
  If an infinite quantity ${x_n}$ is positive (negative) from some term on,
  it is called a positive (negative) infinite quantity, written $lim_(n -> oo) x_n = plus.minus oo$;
  they are collectively called infinite quantities of fixed sign.
] <def:infinite-quantity>

#theorem(name: "Theorems on Infinite and Infinitesimal Quantities")[
  + Let $x_n != 0$. Then ${x_n}$ is an infinite quantity
    if and only if ${1 / x_n}$ is an infinitesimal quantity.
  + Let ${x_n}$ be an infinite quantity and $lim_(n -> oo) y_n = b != 0$.
    Then both ${x_n y_n}$ and ${x_n / y_n}$ are infinite quantities.
  + Let ${x_n}$ be an infinite quantity and $abs(y_n) >= delta > 0$ for all $n >= N_0$.
    Then ${x_n y_n}$ is an infinite quantity.
] <thm:infinite-infinitesimal-quantity>

#proof[
  + ($=>$) Let ${x_n}$ be an infinite quantity. For every $epsilon > 0$, take $G = 1 / epsilon > 0$;
    there exists $N$ with $abs(x_n) > G = 1 / epsilon$ for $n > N$, hence $abs(1 / x_n) < epsilon$.
    ($<=$) Let ${1 / x_n}$ be an infinitesimal quantity. For every $G > 0$, take $epsilon = 1 / G > 0$;
    there exists $N$ with $abs(1 / x_n) < 1 / G = epsilon$ for $n > N$, hence $abs(x_n) > G$,
    i.e., ${x_n}$ is an infinite quantity.
  + The proofs of items 2 and 3 are easy and omitted.
]

=== Indeterminate Forms // 未定式

#definition(name: "Indeterminate Form")[
  Using $+oo$, $-oo$, $oo$ and $0$ to denote positive infinite quantities, negative infinite quantities,
  infinite quantities of indefinite sign, and infinitesimal quantities, respectively,
  the limits of the types $oo plus.minus oo$, $0 dot oo$, $0 / 0$ and $oo / oo$, and so on,
  have indeterminate outcomes; limits of such types are called *indeterminate forms*.
] <def:indeterminate-form>

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

=== Subsequences // 子列

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

=== Upper Limits and Lower Limits // 上极限与下极限

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

=== Dedekind Completeness // 戴德金完备性

#definition(name: "Dedekind Cut")[
  Let $bb(A)$ and $bb(B)$ be two nonempty sets of rational numbers such that
  $bb(Q) = bb(A) union bb(B)$ and $a < b$ for all $a in bb(A)$, $b in bb(B)$;
  then $bb(A)$ and $bb(B)$ are said to form a *cut* of $bb(Q)$, denoted $bb(A) | bb(B)$.

  For any cut $bb(A) | bb(B)$ of $bb(Q)$, exactly one of the following four cases holds:
  + $bb(A)$ has a largest element and $bb(B)$ has no smallest;
  + $bb(A)$ has no largest element and $bb(B)$ has a smallest;
  + $bb(A)$ has no largest element and $bb(B)$ has no smallest;
  + $bb(A)$ has a largest element and $bb(B)$ has a smallest.

  Case 4 is impossible. If case 3 occurs, the cut $bb(A) | bb(B)$ is said to define an
  *irrational number* $c$, with $a < c < b$ for all $a in bb(A)$, $b in bb(B)$.

  The set consisting of all rationals together with all irrational numbers defined in case 3
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
  they form a cut $bb(A) | bb(B)$ of $bb(Q)$, which falls into one of the cases 1--3
  of #link(<def:dedekind-cut>)[the definition of a Dedekind cut].

  *Case 1.* Let $a_0$ be the largest element of $bb(A)$. Then $a_0$ is also the largest element of $tilde(bb(A))$:
  if some $tilde(a) in tilde(bb(A))$ satisfied $a_0 < tilde(a)$, by the density of the rationals
  there would exist a rational $a$ with $a_0 < a < tilde(a)$, contradicting the maximality of $a_0$ in $bb(A)$.
  Moreover $tilde(bb(B))$ has no smallest element: for any $tilde(b) in tilde(bb(B))$,
  since $a_0 < tilde(b)$ there exists a rational $b$ with $a_0 < b < tilde(b)$,
  and then $b in bb(B) subset tilde(bb(B))$ with $b < tilde(b)$.

  *Case 2.* Symmetric to case 1.

  *Case 3.* Let $c$ be the irrational number determined by the cut, with $a < c < b$
  for all $a in bb(A)$, $b in bb(B)$. Since $c in bb(R) = tilde(bb(A)) union tilde(bb(B))$,
  either $c in tilde(bb(A))$ or $c in tilde(bb(B))$.
  If $c in tilde(bb(A))$, then $c$ must be the largest element of $tilde(bb(A))$:
  otherwise some $tilde(a) in tilde(bb(A))$ with $c < tilde(a)$ would again produce a rational number in $(c, tilde(a))$,
  contradicting the definition of $c$; similarly, $c in tilde(bb(B))$ forces $c$ to be the smallest element of $tilde(bb(B))$.
]

=== Least Upper Bound Property // 确界原理

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

=== Monotone Convergence Theorem // 单调有界原理

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

=== Bolzano-Weierstrass Theorem // 列紧性

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

=== Nested Interval Theorem // 闭区间套定理

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

=== Cauchy Completeness // 柯西完备性

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

=== Heine-Borel Theorem // 有限覆盖定理

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

=== Equivalence of the Completeness Theorems // 完备性定理的等价性

#theorem(name: "Equivalence of the Completeness Theorems")[
  The following theorems are mutually equivalent:
  + #link(<thm:dedekind>)[Dedekind's theorem];
  + #link(<thm:supremum-existence>)[the principle of existence of suprema];
  + #link(<thm:monotone-convergence>)[the monotone convergence theorem];
  + #link(<thm:nested-interval>)[the nested interval theorem];
  + #link(<thm:bolzano-weierstrass>)[the Bolzano-Weierstrass theorem];
  + #link(<thm:heine-borel>)[the Heine-Borel finite covering theorem];
  + #link(<thm:cauchy-criterion>)[the Cauchy convergence criterion].
] <thm:completeness-equivalence>

The Cauchy convergence criterion expresses the *completeness* of the real numbers,
while the principle of existence of suprema (Dedekind's theorem) expresses their *continuity*;
the mutual derivability of these theorems shows that
*the continuity of the real numbers is equivalent to their completeness*.

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
  see #link(<def:lipschitz-continuity>)[Lipschitz Continuity]) $f$ on an interval $I$
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
= Limits and Continuity of Functions // 函数的极限与连续性

== Limits of Functions // 函数的极限

=== Definition of Limit // 极限的定义

#definition(name: "Limit of a Function")[
  Let $f$ be defined on a deleted neighborhood $accent(U, circle)(x_0, rho) subset D_f$ of $x_0$,
  where $rho > 0$. If there exists a real number $A$ such that for every $epsilon > 0$
  there exists $delta > 0$ with
  $
    abs(f(x) - A) < epsilon quad quad "whenever" quad quad 0 < abs(x - x_0) < delta,
  $
  then $A$ is called the *limit* of $f$ at $x_0$, written $lim_(x -> x_0) f(x) = A$.
  If no such $A$ exists, the limit of $f$ at $x_0$ is said not to exist.
] <def:limit-of-function>

#note[
  The condition is $0 < abs(x - x_0) < delta$ rather than $0 <= abs(x - x_0) < delta$
  because $f$ need not be defined at $x_0$ itself.
]

#definition(name: "One-Sided Limits")[
  Let $f$ be defined on $(x_0 - rho, x_0)$ with $rho > 0$. If there exists $B in bb(R)$
  such that for every $epsilon > 0$ there exists $delta > 0$ with $abs(f(x) - B) < epsilon$
  whenever $-delta < x - x_0 < 0$, then $B$ is called the *left limit* of $f$ at $x_0$,
  written $lim_(x -> x_0^-) f(x) = f(x_0^-) = B$.
  The *right limit* $f(x_0^+)$ is defined analogously.
] <def:one-sided-limit>

#note[
  Uniqueness, order preservation and the arithmetic rules remain valid for one-sided limits.
  Clearly, $lim_(x -> x_0) f(x)$ exists if and only if both one-sided limits
  $f(x_0^-)$ and $f(x_0^+)$ exist and are equal.
]

#definition(name: "Extended Limits")[
  The definition of a limit extends to four kinds of behavior of the function value
  and six kinds of behavior of the independent variable. Each notion of limit is obtained
  by choosing one row from each of the two tables below, with the quantifier structure
  "for every $epsilon > 0$ (respectively $G > 0$), there exists $delta > 0$
  (respectively $X > 0$), such that for all $x$ satisfying the left condition,
  the right condition holds."

  #tex-table(
    ([As $x -> dots$], [The condition on $x$]),
    ([$x -> x_0$], [$0 < abs(x - x_0) < delta$]),
    ([$x -> x_0^+$], [$0 < x - x_0 < delta$]),
    ([$x -> x_0^-$], [$-delta < x - x_0 < 0$]),
    ([$x -> oo$], [$abs(x) > X$]),
    ([$x -> +oo$], [$x > X$]),
    ([$x -> -oo$], [$x < -X$]),
  )

  #tex-table(
    ([As $f(x) -> dots$], [The condition on $f(x)$]),
    ([a finite $A$], [$abs(f(x) - A) < epsilon$]),
    ([$oo$], [$abs(f(x)) > G$]),
    ([$+oo$], [$f(x) > G$]),
    ([$-oo$], [$f(x) < -G$]),
  )
] <def:extended-limit>

#proposition(name: "Properties of Function Limits")[
  Let $lim_(x -> x_0) f(x) = A$.
  + *Uniqueness:* if also $lim_(x -> x_0) f(x) = B$, then $A = B$.
  + *Order preservation:* if $lim_(x -> x_0) g(x) = B$ with $A > B$, then there exists
    $delta > 0$ such that $f(x) > g(x)$ whenever $0 < abs(x - x_0) < delta$. In particular:
    - if $A != 0$, then there exists $delta > 0$ with $abs(f(x)) > abs(A) / 2$
      whenever $0 < abs(x - x_0) < delta$;
    - if $lim_(x -> x_0) g(x) = B$ and $g(x) <= f(x)$ for all $x$ with $0 < abs(x - x_0) < r$,
      then $B <= A$.
  + *Local boundedness:* there exists $delta > 0$ such that $f$ is bounded on
    $accent(U, circle)(x_0, delta)$.
  + *Squeeze:* if $g(x) <= f(x) <= h(x)$ for all $x$ with $0 < abs(x - x_0) < r$ and
    $lim_(x -> x_0) g(x) = lim_(x -> x_0) h(x) = A$, then $lim_(x -> x_0) f(x) = A$.
  + *Arithmetic operations:* if $lim_(x -> x_0) g(x) = B$, then
    $lim_(x -> x_0) (alpha f(x) + beta g(x)) = alpha A + beta B$ for constants $alpha, beta$,
    $lim_(x -> x_0) (f(x) g(x)) = A B$, and $lim_(x -> x_0) f(x) / g(x) = A / B$ for $B != 0$.
] <prop:limit-of-function-properties>

#proof[
  The proofs follow the pattern of #link(<prop:convergent-sequence-properties>)[those for sequences];
  we only indicate the arguments for the first two items.
  + For every $epsilon > 0$ there exist $delta_1, delta_2 > 0$ with $abs(f(x) - A) < epsilon / 2$
    for $0 < abs(x - x_0) < delta_1$ and $abs(f(x) - B) < epsilon / 2$
    for $0 < abs(x - x_0) < delta_2$. Taking $delta = min(delta_1, delta_2)$, the triangle
    inequality gives $abs(A - B) < epsilon$ for all admissible $x$; since $epsilon$ is arbitrary,
    $A = B$.
  + Take $epsilon = (A - B) / 2 > 0$; then $f(x) > (A + B) / 2 > g(x)$ in some deleted
    neighborhood of $x_0$.
    - Since $abs(abs(f(x)) - abs(A)) <= abs(f(x) - A)$, we have $lim_(x -> x_0) abs(f(x)) = abs(A)$;
      applying order preservation to the constant $abs(A) / 2$ yields the claim.
    - Suppose $B > A$. By order preservation there exists $delta > 0$ with $g(x) > f(x)$
      whenever $0 < abs(x - x_0) < delta$. Taking $eta = min(delta, r)$, on the punctured
      neighborhood of radius $eta$ we get both $g(x) <= f(x)$ and $g(x) > f(x)$, a contradiction.
]

#example[
  Let $lim_(x -> a) f(x) = A$ with $a >= 0$. Show that $lim_(x -> sqrt(a)) f(x^2) = A$.
] <ex:limit-composition-square>

#proof[
  For every $epsilon > 0$ there exists $delta_1 > 0$ such that $abs(f(x) - A) < epsilon$
  whenever $0 < abs(x - a) < delta_1$. Take $delta = min(1, delta_1 / (1 + 2 sqrt(a)))$.
  When $0 < abs(x - sqrt(a)) < delta$ we have $0 < abs(x + sqrt(a)) < 1 + 2 sqrt(a)$, hence
  $
    0 < abs(x^2 - a) = abs(x - sqrt(a)) abs(x + sqrt(a)) < delta_1,
  $
  and therefore $abs(f(x^2) - A) < epsilon$.
]

#example(name: "Comparison of Growth Rates")[
  As $x -> +oo$,
  $
    x^x >> floor(x)! >> a^x >> x^alpha >> ln^k x quad quad quad (a > 1, alpha > 0, k > 0),
  $
  that is, the quotient of each pair of adjacent quantities tends to $0$ in the indicated order.
] <ex:growth-comparison>

#proof[
  + $lim_(x -> +oo) floor(x)! / x^x = 0$: let $n = floor(x)$. At least $floor(n / 2)$ of the
    factors $1, 2, dots, n$ do not exceed $x / 2$, while every factor is at most $x$, so
    $
      n! <= (x / 2)^(floor(n / 2)) dot x^(n - floor(n / 2)),
    $
    hence $n! / x^n <= 2^(-floor(n / 2)) -> 0$ as $x -> +oo$.
  + $lim_(x -> +oo) a^x / floor(x)! = 0$: keeping only the factors larger than $n / 2$ gives
    $n! >= (n / 2)^(n / 2)$ for $n >= 2$, hence with $n = floor(x)$,
    $
      a^x / n! <= a^(x + 1) (2 / n)^(n / 2) <= a (a^4 dot 4 / x)^(x / 4),
    $
    which is at most $a (1 / 2)^(x / 4) -> 0$ once $x >= 8 a^4$.
  + $lim_(x -> +oo) x^alpha / a^x = 0$: for $n = floor(x)$ we have
    $0 < x^alpha / a^x <= (n + 1)^alpha / a^n = a t_(n + 1)$ where $t_n = n^alpha / a^n$.
    The quotient $t_(n + 1) / t_n = (1 + 1 / n)^alpha / a$ decreases to $1 / a < 1$,
    so $t_(n + 1) < t_n$ for all sufficiently large $n$; being eventually decreasing and bounded
    below, ${t_n}$ converges, and passing to the limit in
    $t_(n + 1) = t_n dot (1 + 1 / n)^alpha / a$ yields $l = l / a$, i.e., $l = 0$.
    Hence $x^alpha / a^x -> 0$.
  + $lim_(x -> +oo) ln^k x / x^alpha = 0$: substituting $t = ln x$, the quotient becomes
    $t^k / e^(alpha t) = t^k / (e^alpha)^t -> 0$ by the previous item applied with $a = e^alpha > 1$.
]

#example(name: "Two Important Limits")[
  $
    lim_(x -> oo) (1 + 1 / x)^x = e quad quad "and" quad quad lim_(x -> 0) sin x / x = 1.
  $
] <ex:two-important-limits>

#proof[
  + First let $x -> +oo$. For $x >= 1$, writing $n = floor(x)$,
    $
      (1 + 1 / (n + 1))^n < (1 + 1 / x)^x < (1 + 1 / n)^(n + 1).
    $
    As $x -> +oo$ we have $n -> oo$, and both bounds tend to $e$
    (recall $lim_(n -> oo) (1 + 1 / n)^n = e$), so the squeeze for function limits gives
    $lim_(x -> +oo) (1 + 1 / x)^x = e$.
    For $x -> -oo$, substitute $y = -x$:
    $
      lim_(x -> -oo) (1 + 1 / x)^x
      = lim_(y -> +oo) (1 - 1 / y)^(-y)
      = lim_(y -> +oo) (1 + 1 / (y - 1))^(y - 1) (1 + 1 / (y - 1))
      = e.
    $
  + Since $sin x / x$ is an even function, it suffices to consider $x -> 0^+$.
    For $0 < x < pi / 2$, comparing the areas of the triangle $O A B$, the circular sector
    and the triangle spanned by the tangent line in the unit circle gives
    $sin x < x < tan x$; dividing by $sin x > 0$ yields $cos x < sin x / x < 1$.
    Since $0 < 1 - cos x = 2 sin^2(x / 2) <= x^2 / 2 -> 0$, we have $cos x -> 1$ as $x -> 0^+$,
    and the squeeze gives $lim_(x -> 0^+) sin x / x = 1$.
]

#example(name: "Viète's Formula")[
  Compute $lim_(n -> oo) product_(k = 1)^n cos(x / 2^k)$ and deduce Viète's formula
  $
    2 / pi
    = sqrt(1 / 2) sqrt(1 / 2 + 1 / 2 sqrt(1 / 2))
    sqrt(1 / 2 + 1 / 2 sqrt(1 / 2 + 1 / 2 sqrt(1 / 2))) dots.h.c
  $
] <ex:viete-formula>

#proof[
  Multiplying and dividing by $sin(x / 2^n)$ and iterating the double-angle formula,
  $
    product_(k = 1)^n cos(x / 2^k)
    = (cos(x / 2) cos(x / 2^2) dots cos(x / 2^n) sin(x / 2^n)) / sin(x / 2^n)
    = sin x / (2^n sin(x / 2^n)).
  $
  Since $lim_(t -> 0) sin t / t = 1$, with $t = x / 2^n -> 0$ we obtain
  $lim_(n -> oo) 2^n sin(x / 2^n) = x$, hence the product tends to $sin x / x$.
  Taking $x = pi / 2$, the limit equals $2 / pi$.
  On the other hand, iterating $cos theta = sqrt(1 / 2 + 1 / 2 cos 2 theta)$ with $x = pi / 2$ gives
  $cos(x / 2) = sqrt(1 / 2)$,
  $cos(x / 4) = sqrt(1 / 2 + 1 / 2 sqrt(1 / 2))$, and so on, so the infinite product collapses
  to Viète's formula.
]

=== Limits of Functions and Sequences // 函数极限与数列极限

#theorem(name: "Heine's Theorem")[
  Let $f$ be a function defined on a deleted neighborhood $accent(U, circle)(x_0)$ of $x_0$.
  The following two statements are equivalent:
  + $lim_(x -> x_0) f(x) = A$.
  + For any sequence ${x_n} subset accent(U, circle)(x_0)$ with $lim_(n -> oo) x_n = x_0$,
    the sequence ${f(x_n)}$ satisfies $lim_(n -> oo) f(x_n) = A$.
] <thm:heine-theorem>

#proof[
  + ($=>$) Since $lim_(x -> x_0) f(x) = A$, for every $epsilon > 0$ there exists $delta > 0$
    such that $abs(f(x) - A) < epsilon$ whenever $0 < abs(x - x_0) < delta$.
    Since $lim_(n -> oo) x_n = x_0$ with $x_n != x_0$, for this $delta$ there exists $N$
    such that $0 < abs(x_n - x_0) < delta$ for all $n > N$.
    Hence $abs(f(x_n) - A) < epsilon$ for $n > N$, i.e., $lim_(n -> oo) f(x_n) = A$.
  + ($<=$) Suppose $f$ does not tend to $A$ at $x_0$: there exist $epsilon_0 > 0$ and,
    for every $delta > 0$, some $x$ with $0 < abs(x - x_0) < delta$ but $abs(f(x) - A) >= epsilon_0$.
    Taking $delta_k = 1 / k$, we obtain inductively points $x_k$ with
    $0 < abs(x_k - x_0) < 1 / k$ and $abs(f(x_k) - A) >= epsilon_0$.
    Then $x_n != x_0$, $lim_(n -> oo) x_n = x_0$, yet ${f(x_n)}$ cannot converge to $A$,
    contradicting the hypothesis.
]

#theorem(name: "Weak Heine Theorem")[
  $lim_(x -> x_0) f(x)$ exists if and only if for any sequence
  ${x_n} subset accent(U, circle)(x_0)$ with $lim_(n -> oo) x_n = x_0$,
  the sequence ${f(x_n)}$ converges.
] <thm:weak-heine-theorem>

#note[
  The weak Heine theorem does not require the sequences ${f(x_n)}$
  to converge to the same number.
]

#proof[
  By #link(<thm:heine-theorem>)[Heine's theorem] it suffices to show the necessity.
  Suppose, to the contrary, that there exist two sequences ${x_n'}$ and ${x_n''}$ in
  $accent(U, circle)(x_0)$ with $x_n' != x_0$, $x_n'' != x_0$,
  $lim_(n -> oo) x_n' = lim_(n -> oo) x_n'' = x_0$, but
  $lim_(n -> oo) f(x_n') != lim_(n -> oo) f(x_n'')$ (one of them may fail to converge).
  Interleave them into ${x_n}$ by $x_(2n - 1) = x_n'$ and $x_(2n) = x_n''$.
  Then $x_n != x_0$ and $lim_(n -> oo) x_n = x_0$, but ${f(x_n)}$ has two subsequences
  with different limits, hence diverges -- a contradiction.
]

#theorem(name: "Cauchy Convergence Criterion for Functions")[
  The limit $lim_(x -> +oo) f(x)$ exists and is finite if and only if
  for every $epsilon > 0$ there exists $X > 0$ such that
  $abs(f(x') - f(x'')) < epsilon$ for all $x', x'' > X$.
] <thm:cauchy-criterion-function>

#proof[
  + ($=>$) Let $lim_(x -> +oo) f(x) = A$. For every $epsilon > 0$ there exists $X > 0$
    with $abs(f(x') - A) < epsilon / 2$ and $abs(f(x'') - A) < epsilon / 2$ for all $x', x'' > X$;
    hence $abs(f(x') - f(x'')) <= abs(f(x') - A) + abs(f(x'') - A) < epsilon$.
  + ($<=$) For every $epsilon > 0$ choose $X > 0$ as in the criterion.
    Pick any sequence ${x_n}$ with $x_n -> +oo$; then there exists $N$ such that
    $x_n, x_m > X$, hence $abs(f(x_n) - f(x_m)) < epsilon$, for all $m, n > N$.
    Thus ${f(x_n)}$ is a Cauchy sequence and converges by
    #link(<thm:cauchy-criterion>)[the Cauchy convergence criterion for sequences].
    If ${y_n}$ is another sequence with $y_n -> +oo$, the interleaved sequence
    $x_1, y_1, x_2, y_2, dots$ also tends to $+oo$, so ${f(x_n)}$ and ${f(y_n)}$
    must have the same limit. By #link(<thm:heine-theorem>)[Heine's theorem],
    $lim_(x -> +oo) f(x)$ exists and is finite.
]

#note[
  Heine's theorem and the Cauchy convergence criterion take different forms for different
  extended limits, but the content is always the same.
]

== Continuous Functions // 连续函数

=== Continuity at a Point // 一点连续

#definition(name: "Continuity at a Point")[
  Let $f$ be defined in a neighborhood $U(x_0)$ of $x_0$. If
  $lim_(x -> x_0) f(x) = f(x_0)$, i.e., for every $epsilon > 0$ there exists $delta > 0$
  such that $abs(f(x) - f(x_0)) < epsilon$ for all $x$ with $abs(x - x_0) < delta$,
  then $f$ is said to be *continuous at* $x_0$, and $x_0$ is called a *continuity point*
  of $f$. Equivalently, writing $Delta x = x - x_0$ and
  $Delta y = f(x_0 + Delta x) - f(x_0)$, continuity at $x_0$ means $lim_(Delta x -> 0) Delta y = 0$.
] <def:continuity-at-point>

#caution[
  Unlike the limit, continuity at $x_0$ presupposes that $f$ is defined at $x_0$
  (indeed in a whole neighborhood of $x_0$).
]

#note[
  Continuity realizes the interchange of the limit and the function symbol:
  $lim_(x -> x_0) f(x) = f(lim_(x -> x_0) x) = f(x_0)$.
  In essence, continuity at $x_0$ says that the *limit value equals the function value*.
]

#definition(name: "Oscillation")[
  For $delta > 0$, the *oscillation* of $f$ on the neighborhood $U(a, delta)$ is
  $
    omega_(f)(a, delta) = sup_(x in U(a, delta)) f(x) - inf_(x in U(a, delta)) f(x),
  $
  and $omega_(f)(a) = lim_(delta -> 0^+) omega_(f)(a, delta)$ is called
  the *oscillation of $f$ at the point $a$*.
] <def:oscillation>

#proposition[
  The function $f$ is continuous at $a$ if and only if $omega_(f)(a) = 0$.
] <prop:oscillation-continuity>

#proof[
  If $f$ is continuous at $a$, then for every $epsilon > 0$ there exists $delta > 0$ with
  $abs(f(x) - f(a)) < epsilon$ on $U(a, delta)$, hence
  $f(a) - epsilon < f(x) < f(a) + epsilon$ and $omega_(f)(a, delta) <= 2 epsilon$;
  letting $delta -> 0^+$ and then $epsilon -> 0^+$ gives $omega_(f)(a) = 0$.
  Conversely, if $omega_(f)(a) = 0$, then for every $epsilon > 0$ there exists $delta > 0$
  with $omega_(f)(a, delta) < epsilon$; for $x in U(a, delta)$,
  $f(x) - f(a) <= sup f - inf f < epsilon$, i.e., $abs(f(x) - f(a)) < epsilon$,
  so $f$ is continuous at $a$.
]

=== Continuity on an Interval // 区间上的连续性

#definition(name: "Continuity on an Interval")[
  + $f$ is *continuous on the open interval* $(a, b)$ if it is continuous at every point
    of $(a, b)$.
  + $f$ is *left-continuous* (*right-continuous*) at $x_0$ if
    $lim_(x -> x_0^-) f(x) = f(x_0)$ (respectively $lim_(x -> x_0^+) f(x) = f(x_0)$).
  + $f$ is *continuous on the closed interval* $[a, b]$ if it is continuous on $(a, b)$,
    right-continuous at the left endpoint $a$, and left-continuous at the right endpoint $b$.
  + $f$ is *continuous on an interval* $I$ if it is continuous at every point of $I$,
    with one-sided continuity required at endpoints contained in $I$; equivalently, for every
    $x_0 in I$ and $epsilon > 0$ there exists $delta > 0$ such that
    $abs(f(x) - f(x_0)) < epsilon$ for all $x in I$ with $abs(x - x_0) < delta$.
] <def:continuity-on-interval>

#note[
  $f$ is continuous at $x_0$ if and only if it is both left- and right-continuous there.
  However, the existence of both one-sided limits does not imply the existence of the limit:
  continuity compares each one-sided limit with the function value,
  which already forces the two one-sided limits to agree.
]

=== Discontinuity Points // 间断点

#definition(name: "Discontinuity Points")[
  If $f$ is not continuous at $x_0$, then $f$ is said to be *discontinuous* at $x_0$,
  and $x_0$ is called a *discontinuity point* of $f$. Discontinuity points are divided
  into three classes:
  + *First kind:* both one-sided limits $f(x_0^-)$ and $f(x_0^+)$ exist but are unequal.
    Such a point is also called a *jump point*, and the difference $f(x_0^+) - f(x_0^-)$
    is called the *jump* of $f$ at $x_0$.
  + *Second kind:* at least one of the one-sided limits does not exist.
  + *Third kind:* both one-sided limits exist and are equal, but are different from
    $f(x_0)$, or $f$ is not defined at $x_0$.
] <def:discontinuity-point>

#note[
  A third-kind discontinuity can be turned into a continuity point by redefining the function
  value there; such points are therefore also called *removable*.
  For example, $x_0 = 0$ is a first-kind discontinuity of $f(x) = "sgn"(x)$ with jump $2$,
  while $f(x) = x sin(1 / x)$, undefined at $0$, has both one-sided limits equal to $0$,
  so $0$ is a removable discontinuity.
  Many textbooks group the first and third kinds together as discontinuities of the first kind
  (both one-sided limits exist) and call the second kind discontinuities of the second kind.
]

#example(name: "The Riemann Function")[
  Define
  $
    R(x) = cases(
      1 / p\, & x = q / p "," quad p, q "coprime integers with" p > 0, q != 0 comma
      1\, & x = 0 comma
      0\, & x "irrational".
    )
  $
  Show that $lim_(x -> x_0) R(x) = 0$ at every point $x_0$; in other words,
  every irrational point is a continuity point of $R$, and every rational point
  is a third-kind discontinuity.
] <ex:riemann-function>

#proof[
  Since $R$ is periodic with period $1$, it suffices to work on $[0, 1]$.
  For each positive integer $k$ there are only finitely many rationals in $[0, 1]$
  whose denominator does not exceed $k$.
  Let $x_0 in [0, 1]$ and $epsilon > 0$ be given; set $k = floor(1 / epsilon)$ and let
  $r_1, r_2, dots, r_n$ be the rationals in $[0, 1]$ with denominator at most $k$.
  Take $delta = min_(1 <= i <= n, r_i != x_0) abs(r_i - x_0)$, which is positive.
  For $x in [0, 1]$ with $0 < abs(x - x_0) < delta$: if $x$ is irrational then $R(x) = 0$;
  if $x = q / p$ is rational, its denominator satisfies $p > k$, hence
  $R(x) = 1 / p <= 1 / (k + 1) < epsilon$.
  In both cases $abs(R(x) - 0) < epsilon$, so $lim_(x -> x_0) R(x) = 0$.
]

#example(name: "Discontinuities of Monotone Functions")[
  The discontinuities of a monotone function on an interval $(a, b)$ are all of the first kind,
  and there are at most countably many of them.
] <ex:monotone-discontinuities>

#proof[
  Assume $f$ is increasing; since $f$ is defined everywhere, it suffices to show that
  both one-sided limits exist at every point.
  Let $x_0 in (a, b)$. The set ${f(x) | x in (a, x_0)}$ is bounded above, so it has a supremum
  $alpha = sup_(x in (a, x_0)) f(x)$, and $f(x) <= alpha$ for all $x < x_0$.
  By the definition of the supremum, for every $epsilon > 0$ there exists
  $x' in (a, x_0)$ with $f(x') > alpha - epsilon$. Taking $delta = x_0 - x' > 0$,
  for $-delta < x - x_0 < 0$ we have $x' < x < x_0$, hence
  $
    -epsilon < f(x') - alpha <= f(x) - alpha <= 0.
  $
  This proves $lim_(x -> x_0^-) f(x) = alpha$; similarly
  $lim_(x -> x_0^+) f(x) = beta$ with $beta = inf_(x in (x_0, b)) f(x)$, and
  $f(x_0^-) <= f(x_0) <= f(x_0^+)$. This is the *one-sided limit theorem for monotone functions*.

  Now suppose $f$ has infinitely many discontinuities.
  If $x_0$ is a discontinuity, then $f(x_0^-) < f(x_0^+)$, and the open interval
  $(f(x_0^-), f(x_0^+))$ is called the *jump interval* of $x_0$.
  We claim that the jump intervals of distinct discontinuities are pairwise disjoint.
  Let $x_1 > x_0$ be another discontinuity and pick $x, x'$ with $x_0 < x < x' < x_1$;
  monotonicity gives $f(x) <= f(x')$.
  Fixing $x'$ and letting $x -> x_0^+$, the one-sided limit theorem and the comparison
  of limits give $f(x_0^+) <= f(x')$; then letting $x' -> x_1^-$ gives
  $f(x_0^+) <= f(x_1^-)$.
  Therefore
  $
    f(x_0^-) <= f(x_0^+) <= f(x_1^-) <= f(x_1^+),
  $
  so $(f(x_0^-), f(x_0^+)) and (f(x_1^-), f(x_1^+))$ are disjoint.
  Each jump interval contains a rational number, and disjoint intervals contain distinct
  rationals; since $bb(Q)$ is countable, the set of discontinuities is at most countable.
]

#example[
  Study the continuity of $f(x) = lim_(n -> oo) (x^n - 1) / (x^n + 1)$.
] <ex:limit-piecewise>

#solution[
  For $abs(x) < 1$, $x^n -> 0$, so $f(x) = -1$; for $abs(x) > 1$, $x^n -> oo$, so $f(x) = 1$;
  $f(1) = 0$; and the limit diverges at $x = -1$, where $f$ is undefined. Hence
  $
    f(x) = cases(
      -1\, & abs(x) < 1 comma
             0\, & x = 1 comma
                   1\, & abs(x) > 1.
    )
  $
  On $(-oo, -1)$, $(-1, 1)$ and $(1, +oo)$ the function is constant, hence continuous.
  At $x = 1$ the one-sided limits are $-1$ and $1$, and at $x = -1$ they are $1$ and $-1$;
  both points are first-kind (jump) discontinuities.
]

=== Arithmetic of Continuous Functions // 连续函数的四则运算

#theorem(name: "Arithmetic of Continuous Functions")[
  Let $lim_(x -> x_0) f(x) = f(x_0)$ and $lim_(x -> x_0) g(x) = g(x_0)$. Then:
  + $lim_(x -> x_0) (alpha f(x) + beta g(x)) = alpha f(x_0) + beta g(x_0)$
    for constants $alpha, beta$;
  + $lim_(x -> x_0) f(x) g(x) = f(x_0) g(x_0)$;
  + $lim_(x -> x_0) f(x) / g(x) = f(x_0) / g(x_0)$ for $g(x_0) != 0$.
] <thm:arithmetic-continuous>

This is an immediate consequence of the arithmetic of function limits
(#link(<prop:limit-of-function-properties>)[item 5]).

=== Inverse, Composite and Elementary Functions // 反函数、复合函数与初等函数

#theorem(name: "Existence of Inverse Functions")[
  If $y = f(x)$, $x in D_f$, is strictly increasing (strictly decreasing), then it admits
  an inverse function $x = f^(-1)(y)$, $y in R_f$, which is also strictly increasing
  (strictly decreasing).
] <thm:inverse-function-existence>

#proof[
  Assume $y = f(x)$ is strictly increasing. For $x', x'' in D_f$ with $y' = f(x')$ and
  $y'' = f(x'')$, monotonicity gives $x' < x'' ==> y' < y''$, so distinct points have
  distinct images; this guarantees the uniqueness of the preimage, hence the inverse
  $x = f^(-1)(y)$, $y in R_f$, exists. For $y' < y''$ the preimages satisfy $x' < x''$
  (otherwise $x' >= x''$ would force $y' >= y''$), so $f^(-1)$ is strictly increasing.
]

#theorem(name: "Continuity of Inverse Functions")[
  If $y = f(x)$ is continuous and strictly increasing on the closed interval $[a, b]$ with
  $f(a) = alpha$ and $f(b) = beta$, then its inverse $x = f^(-1)(y)$ is continuous and
  strictly increasing on $[alpha, beta]$.
] <thm:inverse-function-continuity>

#proof[
  *Step 1: the range is $f([a, b]) = [alpha, beta]$.*
  Monotonicity gives $f([a, b]) subset [alpha, beta]$. Conversely, let $gamma in (alpha, beta)$
  and set $S = {x | x in (a, b), f(x) < gamma}$. By continuity of $f$ at $a$, the set $S$
  is nonempty, and it is bounded above by $b$; hence $xi_0 = sup S$ exists and lies in $(a, b)$.
  Since $f$ is strictly increasing, $f(x) < gamma$ for $x < xi_0$ and $f(x) > gamma$ for
  $x > xi_0$. By the one-sided limit theorem for monotone functions
  (#link(<ex:monotone-discontinuities>)[the first part of the example on monotone functions]),
  $f(xi_0^-) <= gamma <= f(xi_0^+)$, and continuity of $f$ at $xi_0$ yields
  $f(xi_0) = f(xi_0^-) = f(xi_0^+) = gamma$.
  Hence $gamma in f([a, b])$, and together with $f(a) = alpha$, $f(b) = beta$ we conclude
  $f([a, b]) = [alpha, beta]$. By #link(<thm:inverse-function-existence>)[the existence theorem],
  $f^(-1)$ exists and is strictly increasing on $[alpha, beta]$.

  *Step 2: continuity of $f^(-1)$ on $(alpha, beta)$.*
  Let $y_0 in (alpha, beta)$ and $f^(-1)(y_0) = x_0 in (a, b)$. For every $epsilon > 0$
  (taken small enough that $[x_0 - epsilon, x_0 + epsilon] subset (a, b)$), set
  $y_1 = f(x_0 - epsilon)$ and $y_2 = f(x_0 + epsilon)$, and take
  $delta = min(y_0 - y_1, y_2 - y_0) > 0$.
  Whenever $abs(y - y_0) < delta$, strict monotonicity gives
  $x_0 - epsilon < f^(-1)(y) < x_0 + epsilon$, i.e., $abs(f^(-1)(y) - f^(-1)(y_0)) < epsilon$.
  At the endpoints it suffices to prove right-continuity at $alpha$ and left-continuity
  at $beta$, which is analogous.
]

#theorem(name: "Continuity of Composite Functions")[
  If $u = g(x)$ is continuous at $x_0$ with $g(x_0) = u_0$, and $y = f(u)$ is continuous
  at $u_0$, then the composite $y = f(g(x))$ is continuous at $x_0$.
] <thm:composite-continuity>

#proof[
  For every $epsilon > 0$ there exists $eta > 0$ such that $abs(f(u) - f(u_0)) < epsilon$
  whenever $abs(u - u_0) < eta$. For this $eta > 0$, since $lim_(x -> x_0) g(x) = g(x_0) = u_0$,
  there exists $delta > 0$ such that $abs(g(x) - u_0) < eta$ whenever $abs(x - x_0) < delta$.
  Therefore $abs(f(g(x)) - f(g(x_0))) < epsilon$ whenever $abs(x - x_0) < delta$.
]

#example(name: "Continuity of the Exponential Function")[
  The exponential function $f(x) = a^x$ with $a > 0$, $a != 1$ is continuous on $(-oo, +oo)$.
] <ex:exponential-continuous>

#proof[
  Fix $x_0 in (-oo, +oo)$. Since $a^x - a^(x_0) = a^(x_0) (a^(x - x_0) - 1)$,
  it suffices to prove $lim_(t -> 0) a^t = 1$.
  + As $t -> 0^+$: if $a > 1$, then for $t in (0, 1)$,
    $
      1 < a^t <= a^(1 / floor(1 / t)),
    $
    and since $lim_(n -> oo) root(n, a) = 1$, the squeeze gives $lim_(t -> 0^+) a^t = 1$.
    If $0 < a < 1$, then by the arithmetic of limits,
    $lim_(t -> 0^+) a^t = 1 / lim_(t -> 0^+) (1 / a)^t = 1$.
  + As $t -> 0^-$: substitute $u = -t$ to get
    $lim_(t -> 0^-) a^t = lim_(u -> 0^+) 1 / a^u = 1$.

  Combining the two one-sided limits gives $lim_(t -> 0) a^t = 1$, hence $f$ is continuous
  at every $x_0$.
]

#example(name: "Continuity of Power Functions")[
  For every real $alpha$, the power function $f(x) = x^alpha$ is continuous on $(0, +oo)$.
] <ex:power-continuous>

#proof[
  Since $f(x) = x^alpha = e^(alpha ln x)$ for $x in (0, +oo)$, the claim follows from
  the continuity of $e^x$ and $ln x$ together with
  #link(<thm:composite-continuity>)[the continuity of composite functions].
  (The continuity of $ln x$ on $(0, +oo)$ follows from
  #link(<thm:inverse-function-continuity>)[the inverse function continuity theorem]
  applied to $e^x$.)
]

#theorem(name: "Continuity of Elementary Functions")[
  Every elementary function is continuous on its defining intervals.
] <thm:elementary-continuous>

#note[
  Trigonometric and exponential functions are continuous by their definitions and
  #link(<ex:exponential-continuous>)[the example above]; inverse trigonometric and
  logarithmic functions are continuous by
  #link(<thm:inverse-function-continuity>)[the inverse function continuity theorem];
  power functions are continuous by #link(<ex:power-continuous>)[composition];
  and the arithmetic operations preserve continuity by
  #link(<thm:arithmetic-continuous>)[the arithmetic theorem].
]

#caution[
  The restriction to defining *intervals* excludes degenerate domains consisting of isolated
  points: for example, $f(x) = sqrt(x) + sqrt(-x)$ has domain ${0}$, where the notion of
  continuity at $0$ is not applicable, since $f$ is not defined in any neighborhood of $0$.
]

=== Topological Characterization and Density Arguments // 拓扑刻画与稠密性论证

#example(name: "Continuity via Inverse Images of Open Sets")[
  Let $f$ be defined on the real axis $X = bb(R)$. Then $f$ is continuous on $bb(R)$
  if and only if the inverse image of every open set is open, i.e., for every open set $O$
  in the $y$-axis, the set $f^(-1)(O) = {x | f(x) in O}$ is open in $bb(R)$.
] <ex:continuous-open-preimage>

#proof[
  + ($=>$) It suffices to show that for every $x_0 in f^(-1)(O)$ there exists $delta > 0$
    with $(x_0 - delta, x_0 + delta) subset f^(-1)(O)$.
    Since $x_0 in f^(-1)(O)$, we have $y_0 = f(x_0) in O$; as $O$ is open, there exists
    $epsilon > 0$ with $(y_0 - epsilon, y_0 + epsilon) subset O$.
    By continuity of $f$ at $x_0$ there exists $delta > 0$ such that
    $f((x_0 - delta, x_0 + delta)) subset (y_0 - epsilon, y_0 + epsilon) subset O$.
    Hence $(x_0 - delta, x_0 + delta) subset f^(-1)(O)$, so $f^(-1)(O)$ is open.
  + ($<=$) Fix $x_0 in bb(R)$, $y_0 = f(x_0)$, and let $epsilon > 0$.
    By hypothesis, $f^(-1)((y_0 - epsilon, y_0 + epsilon))$ is open and contains $x_0$;
    hence there exists $delta > 0$ with
    $(x_0 - delta, x_0 + delta) subset f^(-1)((y_0 - epsilon, y_0 + epsilon))$, i.e.,
    $
      f((x_0 - delta, x_0 + delta)) subset (f(x_0) - epsilon, f(x_0) + epsilon),
    $
    which is precisely the continuity of $f$ at $x_0$.
]

#note[
  This example builds a bridge between analysis and topology:
  continuity is characterized purely by the behavior of inverse images of open sets,
  with no reference to $epsilon$-$delta$ quantifiers.
]

#example(name: "Functions Agreeing on a Dense Set")[
  If $f$ and $g$ are continuous on $(-oo, +oo)$ and $f(x) = g(x)$ at every rational point,
  then $f(x) equiv g(x)$ on $bb(R)$.
] <ex:continuous-agree-dense>

#proof[
  It suffices to show $f(x) = g(x)$ at every irrational point $x$.
  Choose a sequence of rationals ${r_n}$ converging to $x$, for instance the decimal
  truncations
  $
    r_n = (floor(10^n x)) / 10^n = (10^n x - theta_(x, n)) / 10^n, quad quad 0 <= theta_(x, n) < 1,
  $
  which satisfy $r_n -> x$. Since $f(r_n) = g(r_n)$ for all $n$, continuity gives
  $
    f(x) = lim_(n -> oo) f(r_n) = lim_(n -> oo) g(r_n) = g(x).
  $
]

#example(name: "Existence of the Minimal Positive Period")[
  A nonconstant continuous periodic function on $bb(R)$ has a minimal positive period.
] <ex:minimal-period>

#proof[
  + The set of positive periods of $f$ is bounded below by $0$, so by the completeness of
    $bb(R)$ its infimum $T_0 = inf {T > 0 | T "is a period"}$ exists with $T_0 >= 0$.
  + $T_0$ is a period: by the definition of the infimum there exist positive periods $T_n$
    with $T_n -> T_0$. For every $x in bb(R)$, continuity gives
    $
      f(x + T_0) = f(x + lim_(n -> oo) T_n) = lim_(n -> oo) f(x + T_n) = f(x),
    $
    so $T_0$ is a period of $f$.
  + $T_0 > 0$: suppose $T_0 = 0$; then $T_n -> 0$, so the integer multiples of the periods
    of $f$ are dense in $bb(R)$. For any $x in bb(R)$ there exists a sequence of such
    multiples ${x_n}$ with $x_n -> x$, and each $x_n$ is an integer multiple of a period,
    so $f(x_n) = f(0)$. Hence
    $
      f(x) = f(lim_(n -> oo) x_n) = lim_(n -> oo) f(x_n) = f(0),
    $
    i.e., $f(x) equiv f(0)$, contradicting that $f$ is nonconstant. Therefore $T_0 > 0$.
]

== Infinitesimal and Infinite Quantities // 无穷大量与无穷小量

=== Infinitesimal Quantities and Their Comparison // 无穷小量及其比较

#definition(name: "Infinitesimal Function")[
  If $lim_(x -> x_0) f(x) = 0$, then $f$ is called an *infinitesimal quantity* as $x -> x_0$,
  denoted $f(x) = o(1) quad (x -> x_0)$.
] <def:infinitesimal-function>

#note[
  An infinitesimal quantity is a variable tending to $0$; the point $x -> x_0$
  may be replaced by any of the other five approaches in #link(<def:extended-limit>)[the table]
  (including $x -> oo$).
]

#definition(name: "Comparison of Infinitesimals")[
  Let $u(x)$ and $v(x)$ be two infinitesimal quantities as $x -> x_0$; compare the limit
  of $u(x) / v(x)$:
  + If $lim_(x -> x_0) u(x) / v(x) = 0$, then $u(x)$ tends to $0$ faster than $v(x)$;
    $u$ is said to be an *infinitesimal of higher order* than $v$, or $v$ one of
    *lower order* than $u$, written
    $
      u(x) = o(v(x)) quad quad (x -> x_0).
    $
  + If there exists $A > 0$ such that $abs(u(x) / v(x)) <= A$ in some deleted neighborhood
    of $x_0$, then $u(x) / v(x)$ is said to be a *bounded quantity*, written
    $u(x) = O(v(x)) quad (x -> x_0)$. If moreover there exists $a > 0$ with
    $a <= abs(u(x) / v(x)) <= A$ in some deleted neighborhood, then $u$ and $v$ are said to be
    *infinitesimals of the same order*. Clearly, if $lim_(x -> x_0) u(x) / v(x) = c != 0$,
    then $u$ and $v$ are of the same order.
  + If $lim_(x -> x_0) u(x) / v(x) = 1$, then $u$ and $v$ are said to be
    *equivalent infinitesimals*, written
    $
      u(x) tilde.op v(x) quad quad (x -> x_0),
    $
    which can also be written as $u(x) = v(x) + o(v(x)) quad (x -> x_0)$.
] <def:comparison-infinitesimals>

#caution[
  Strictly speaking, $u(x) = o(v(x))$ means $u(x) in o(v(x))$, where $o(v(x))$ is the
  *set* of functions that are infinitesimals of higher order than $v(x)$;
  therefore the reversed writing $o(v(x)) = u(x)$ is meaningless.
]

#proposition(name: "Rules for the $o$ Notation")[
  As $x -> 0$, for $m > 0$ and $n > 0$ the following rules hold:
  + *Absorption under addition:* $o(x^m) plus.minus o(x^n) = o(x^(min(m, n)))$;
  + *Accumulation under multiplication:*
    $x^m o(x^n) = o(x^(m + n))$ and $o(x^m) o(x^n) = o(x^(m + n))$;
  + *Invariance under constants:* $k o(x^n) = o(x^n)$ and
    $o(k x^n) = o(x^n)$ for $k != 0$ (where $k$ may be replaced by any bounded function);
  + *Composition:* $o(x + o(x)) = o(x)$ and $o(o(x)) = o(x)$.
] <prop:o-operations>

#note(title: "Common Equivalent Infinitesimals")[
  As $x -> 0$:
  $
    sin x tilde.op x, quad tan x tilde.op x, quad arcsin x tilde.op x, quad
    arctan x tilde.op x, quad 1 - cos x tilde.op 1 / 2 x^2, \
    tan x - x tilde.op 1 / 3 x^3, quad x - sin x tilde.op 1 / 6 x^3, quad
    tan x - sin x tilde.op 1 / 2 x^3, quad arcsin x - x tilde.op 1 / 6 x^3, quad
    x - arctan x tilde.op 1 / 3 x^3, \
    e^x - 1 tilde.op x, quad a^x - 1 tilde.op x ln a, quad ln(1 + x) tilde.op x, quad
    log_a (1 + x) tilde.op x / ln a, quad (1 + x)^alpha - 1 tilde.op alpha x, \
    x - ln(1 + x) tilde.op 1 / 2 x^2, quad ln(x + sqrt(1 + x^2)) tilde.op x.
  $
  Here $x$ may be replaced throughout by any function tending to $0$.
]

=== Infinite Quantities and Their Comparison // 无穷大量及其比较

#definition(name: "Infinite Function")[
  If $lim_(x -> x_0) f(x) = oo$ (or $plus.minus oo$), then $f$ is called an
  *infinite quantity* as $x -> x_0$.
] <def:infinite-function>

#definition(name: "Comparison of Infinite Quantities")[
  Let $u(x)$ and $v(x)$ be two infinite quantities as $x -> x_0$; compare the limit
  of $u(x) / v(x)$:
  + If $lim_(x -> x_0) u(x) / v(x) = oo$, then $u(x)$ tends to infinity faster than $v(x)$;
    $u$ is said to be an *infinite quantity of higher order* than $v$, or $v$ one of
    *lower order* than $u$.
  + If there exists $A > 0$ such that $abs(u(x) / v(x)) <= A$ in some deleted neighborhood
    of $x_0$, then $u(x) / v(x)$ is a *bounded quantity*, written
    $u(x) = O(v(x)) quad (x -> x_0)$. If moreover there exists $a > 0$ with
    $a <= abs(u(x) / v(x)) <= A$ in some deleted neighborhood, then $u$ and $v$ are said to be
    *infinite quantities of the same order*. Clearly, if $lim_(x -> x_0) u(x) / v(x) = c != 0$,
    then $u$ and $v$ are of the same order.
  + If $lim_(x -> x_0) u(x) / v(x) = 1$, then $u$ and $v$ are said to be
    *equivalent infinite quantities*, written $u(x) tilde.op v(x) quad (x -> x_0)$.
] <def:comparison-infinite>

=== The Equivalence Replacement Principle // 等价量替换原理

#theorem(name: "Equivalence Replacement Principle")[
  + *Product replacement:* let $alpha(x)$, $beta(x)$, $beta'(x)$ be defined in a deleted
    neighborhood of $x_0$ with $beta(x) tilde.op beta'(x) quad (x -> x_0)$. Then:
    - if $lim_(x -> x_0) alpha(x) beta(x) = A$, then $lim_(x -> x_0) alpha(x) beta'(x) = A$;
    - if $lim_(x -> x_0) alpha(x) / beta(x) = A$, then $lim_(x -> x_0) alpha(x) / beta'(x) = A$.
  + *Sum and difference replacement:* let $alpha$, $alpha'$, $beta$, $beta'$ be defined in a
    deleted neighborhood of $x_0$ with $alpha tilde.op alpha'$, $beta tilde.op beta'$
    $(x -> x_0)$ and $lim_(x -> x_0) alpha'(x) / beta'(x) = c$ with $c != 1$. If
    $lim_(x -> x_0) (alpha(x) - beta(x)) = A$, then
    $lim_(x -> x_0) (alpha'(x) - beta'(x)) = A$.
] <thm:equivalence-replacement>

#proof[
  For the product replacement,
  $lim_(x -> x_0) alpha beta' = lim (alpha beta) dot (beta' / beta) = A dot 1 = A$ and
  $lim_(x -> x_0) alpha / beta' = lim alpha / beta dot beta / beta' = A dot 1 = A$
  by the arithmetic of limits.

  For the sum and difference replacement, the hypotheses give
  $lim_(x -> x_0) alpha / beta = lim (alpha / alpha') dot (alpha' / beta') dot (beta' / beta) = 1 dot c dot 1 = c$.
  Since $alpha' - beta' = beta' (alpha' / beta' - 1)$ and $alpha - beta = beta (alpha / beta - 1)$,
  we have
  $
    (alpha' - beta') / (alpha - beta)
    = beta' / beta dot (alpha' / beta' - 1) / (alpha / beta - 1)
    -> 1 dot (c - 1) / (c - 1)
    = 1,
  $
  where $c != 1$ guarantees that the denominator does not vanish in the limit. Hence
  $alpha' - beta' tilde.op alpha - beta$, and
  $lim (alpha' - beta') = lim (alpha' - beta') / (alpha - beta) dot (alpha - beta) = 1 dot A = A$.
]

#caution(title: "Precautions for Equivalence Replacement")[
  + The quantities being replaced must be infinitesimal quantities
    (tending to $0$ in the limit at hand).
  + *The replacement must be applied to the whole expression, not to a part of it.*
    When computing $lim f(x) plus.minus g(x)$, if both limits exist they may be computed
    separately and added; but if one of them fails to exist, the replacement
    must be applied to the whole expression at once.
]

#note[
  Equivalence replacement is essentially the approximation of the limit by the first term
  of the Taylor expansion: every problem solvable by equivalent replacement is solvable
  by Taylor's formula, but not conversely. Products and quotients are always safe, because
  the first Taylor term (the equivalent infinitesimal) survives the multiplication;
  sums and differences may cancel the first terms, in which case higher-order terms are
  needed and the replacement fails. This is exactly what the sum and difference replacement
  covers: if $lim alpha / beta = c != 1$ (the first Taylor terms do not coincide), then
  $alpha - beta tilde.op alpha' - beta'$; if $c != -1$ (the first terms are not opposite),
  then $alpha + beta tilde.op alpha' + beta'$.
]

#note[
  Letting $pi(x)$ denote the number of primes not exceeding $x$, the prime number theorem
  states that
  $
    pi(x) tilde.op x / ln x quad quad (x -> +oo).
  $
]

== Continuous Functions on Closed Intervals // 闭区间上的连续函数

=== Concerning Theorems // 相关定理

Throughout this section, $f in C[a, b]$ denotes a function continuous on $[a, b]$
in the notation introduced in the Notations section.

#theorem(name: "Boundedness Theorem")[
  If $f in C[a, b]$, then $f$ is bounded on $[a, b]$.
] <thm:boundedness-closed>

#proof[
  *First proof (bisection and nested intervals).*
  Suppose $f$ is unbounded on $[a, b]$. Bisect $[a, b]$; at least one of the two halves
  is a closed interval on which $f$ is unbounded -- select one such half and iterate.
  This produces a sequence of nested closed intervals $[a_n, b_n]$ with
  $b_n - a_n = (b - a) / 2^n -> 0$, on each of which $f$ is unbounded.
  By #link(<thm:nested-interval>)[the nested interval theorem], there exists a unique
  $xi$ belonging to all the $[a_n, b_n]$, with
  $lim_(n -> oo) a_n = lim_(n -> oo) b_n = xi$.
  Since $f$ is continuous at $xi$, there exist $delta > 0$ and $M > 0$ with
  $abs(f(x)) <= M$ for all $x in U(xi, delta) inter [a, b]$.
  For all sufficiently large $n$ we have $[a_n, b_n] subset U(xi, delta) inter [a, b]$,
  so $f$ is bounded on these $[a_n, b_n]$ -- a contradiction.

  *Second proof (via the Bolzano-Weierstrass theorem).*
  Suppose $f in C[a, b]$ is unbounded. Then for every $G > 0$ there exists
  $x in [a, b]$ with $abs(f(x)) > G$; taking $G_n = n$ produces a sequence ${x_n}$
  with $abs(f(x_n)) > n$, i.e., $f(x_n) -> oo$.
  By #link(<thm:bolzano-weierstrass>)[the Bolzano-Weierstrass theorem], some subsequence
  ${x_(n_(k))}$ converges: $lim_(k -> oo) x_(n_(k)) = xi in [a, b]$.
  By continuity, $lim_(k -> oo) f(x_(n_(k))) = f(xi)$, which contradicts
  $abs(f(x_(n_(k)))) > n_k -> oo$.
]

#theorem(name: "Extreme Value Theorem")[
  If $f in C[a, b]$, then $f$ attains its maximum and minimum values on $[a, b]$: there exist
  $xi, eta in [a, b]$ such that $f(xi) <= f(x) <= f(eta)$ for all $x in [a, b]$.
] <thm:extreme-value>

#proof[
  By #link(<thm:boundedness-closed>)[the boundedness theorem], the range
  $R_f = {f(x) | x in [a, b]}$ is bounded, so $alpha = inf R_f$ and $beta = sup R_f$ exist.
  It suffices to show that some $xi in [a, b]$ satisfies $f(xi) = alpha$; the case of $beta$
  is analogous.
  For every $x in [a, b]$ we have $f(x) >= alpha$, and for every $epsilon > 0$ there exists
  $x in [a, b]$ with $f(x) < alpha + epsilon$. Taking $epsilon_n = 1 / n$ produces a sequence
  ${x_n} subset [a, b]$ with $alpha <= f(x_n) < alpha + 1 / n$.
  By #link(<thm:bolzano-weierstrass>)[the Bolzano-Weierstrass theorem], some subsequence
  ${x_(n_(k))}$ converges to some $xi in [a, b]$. By continuity of $f$ at $xi$ and the squeeze,
  $
    f(xi) = lim_(k -> oo) f(x_(n_(k))) = f(lim_(k -> oo) x_(n_(k))) = alpha.
  $
]

#theorem(name: "Zero Point Existence Theorem")[
  If $f in C[a, b]$ and $f(a) f(b) < 0$, then there exists $xi in (a, b)$
  with $f(xi) = 0$.
] <thm:zero-point-existence>

#proof[
  *First proof (supremum of the negative set).*
  Assume $f(a) < 0 < f(b)$ and set $V = {x | f(x) < 0, x in [a, b]}$, which is nonempty
  and bounded above; let $xi = sup V$. We show $xi in (a, b)$ and $f(xi) = 0$.
  By continuity and the sign of $f$ at the endpoints, there exist $delta_1, delta_2 > 0$
  with $f(x) < 0$ for all $x in [a, a + delta_1]$ and $f(x) > 0$ for all
  $x in [b - delta_2, b]$. Hence $a + delta_1 <= xi <= b - delta_2$, so $xi in (a, b)$.
  Take $x_n in V$ with $x_n -> xi$; since $f(x_n) < 0$, continuity gives
  $f(xi) = lim_(n -> oo) f(x_n) <= 0$.
  If $f(xi) < 0$, then by continuity there exists $delta > 0$ with $f(x) < 0$ on $U(xi, delta)$,
  contradicting $xi = sup V$. Hence $f(xi) = 0$.

  *Second proof (bisection).*
  Set $a_1 = a$, $b_1 = b$. Whenever $f((a_k + b_k) / 2) = 0$ we are done; otherwise, if
  $f((a_k + b_k) / 2) < 0$ set $a_(k + 1) = (a_k + b_k) / 2$, $b_(k + 1) = b_k$, while if
  $f((a_k + b_k) / 2) > 0$ set $a_(k + 1) = a_k$, $b_(k + 1) = (a_k + b_k) / 2$.
  If the process never hits a zero, it produces a nested sequence $[a_n, b_n]$ with
  $f(a_n) < 0 < f(b_n)$. By #link(<thm:nested-interval>)[the nested interval theorem],
  there exists $xi$ with $xi = lim_(n -> oo) a_n = lim_(n -> oo) b_n$, and by continuity,
  $
    f(xi) = lim_(n -> oo) f(a_n) <= 0, quad quad f(xi) = lim_(n -> oo) f(b_n) >= 0,
  $
  hence $f(xi) = 0$.
]

#theorem(name: "Intermediate Value Theorem")[
  If $f in C[a, b]$, then $f$ attains every value between its minimum
  $m = min_(x in [a, b]) f(x)$ and its maximum $M = max_(x in [a, b]) f(x)$.
] <thm:intermediate-value>

#proof[
  By #link(<thm:extreme-value>)[the extreme value theorem], there exist $xi, eta in [a, b]$
  with $f(xi) = m$ and $f(eta) = M$; assume $xi < eta$ (the case $xi > eta$ is symmetric,
  and $xi = eta$ means $f$ is constant). Let $C$ be any value with $m < C < M$ and set
  $phi(x) = f(x) - C$, which is continuous on $[a, b]$ with $phi(xi) < 0 < phi(eta)$.
  By #link(<thm:zero-point-existence>)[the zero point existence theorem], there exists
  $zeta in (xi, eta)$ with $phi(zeta) = 0$, i.e., $f(zeta) = C$.
]

#example(name: "Fixed Points of Continuous Self-Maps")[
  If $f in C[a, b]$ and $f([a, b]) subset [a, b]$, then there exists $xi in [a, b]$
  with $f(xi) = xi$; such a point is called a *fixed point* of $f$.
] <ex:fixed-point-interval>

#proof[
  We show that $g(x) = f(x) - x$ has a zero. Since $f([a, b]) subset [a, b]$, we have
  $g(a) = f(a) - a >= 0$ and $g(b) = f(b) - b <= 0$.
  If $g(a) = 0$ or $g(b) = 0$ we are done; otherwise $g(a) > 0 > g(b)$ and the claim follows
  from #link(<thm:zero-point-existence>)[the zero point existence theorem].
]

#note[
  Compare with #link(<thm:banach-fixed-point>)[the Banach fixed-point theorem]:
  there, contractivity was used to *construct* the fixed point by iteration, while here
  mere continuity already guarantees existence.
]

=== Uniform Continuity and Lipschitz Continuity // 一致连续与 Lipschitz 连续

#definition(name: "Uniform Continuity")[
  Let $f$ be defined on an interval $I$. If for every $epsilon > 0$ there exists
  $delta > 0$ such that
  $
    abs(f(x') - f(x'')) < epsilon quad quad "whenever" quad quad x', x'' in I, abs(x' - x'') < delta,
  $
  then $f$ is said to be *uniformly continuous* on $I$.
] <def:uniform-continuity>

#note[
  In ordinary continuity the $delta$ depends on both $epsilon$ and the point $x_0$;
  in uniform continuity $delta$ depends only on $epsilon$ and works for all points
  simultaneously. Clearly, uniform continuity on $I$ implies continuity on $I$,
  but the converse fails; geometrically, uniform continuity means that the graph is
  "not steep without bound" over the whole interval. Counterexamples:
  $f(x) = x^2$ is continuous but not uniformly continuous on $bb(R)$, since
  $abs((x + h)^2 - x^2) = abs(2 x h + h^2)$ grows without bound as $x -> oo$
  for fixed $h$; whereas $f(x) = sqrt(x)$ is uniformly continuous on $(0, 1)$
  (extend it continuously to $[0, 1]$ and apply
  #link(<thm:cantor-theorem>)[Cantor's theorem]) yet satisfies no Lipschitz condition,
  since $abs(sqrt(x) - sqrt(y)) / abs(x - y) -> oo$ as $x, y -> 0^+$.
]

#theorem(name: "Uniform Continuity Theorem")[
  Let $f$ be defined on an interval $I$. Then $f$ is uniformly continuous on $I$ if and only
  if for any two sequences ${x_n'}$, ${x_n''}$ with $x_n', x_n'' in I$ satisfying
  $lim_(n -> oo) (x_n' - x_n'') = 0$, we have
  $lim_(n -> oo) (f(x_n') - f(x_n'')) = 0$.
] <thm:uniform-continuity-criterion>

#proof[
  + ($=>$) Let $f$ be uniformly continuous on $I$. For every $epsilon > 0$ choose $delta > 0$
    as in #link(<def:uniform-continuity>)[the definition]. For any sequences
    ${x_n'}$, ${x_n''}$ in $I$ with $x_n' - x_n'' -> 0$, there exists $N$ such that
    $abs(x_n' - x_n'') < delta$ for $n > N$, hence $abs(f(x_n') - f(x_n'')) < epsilon$
    for $n > N$, i.e., $f(x_n') - f(x_n'') -> 0$.
  + ($<=$) Suppose $f$ is not uniformly continuous on $I$: there exist $epsilon_0 > 0$ and,
    for every $delta > 0$, points $x', x'' in I$ with $abs(x' - x'') < delta$ but
    $abs(f(x') - f(x'')) >= epsilon_0$.
    Taking $delta_n = 1 / n$ produces sequences ${x_n'}$, ${x_n''}$ in $I$ with
    $abs(x_n' - x_n'') < 1 / n$ but $abs(f(x_n') - f(x_n'')) >= epsilon_0$.
    Then $x_n' - x_n'' -> 0$ while $f(x_n') - f(x_n'')$ cannot converge to $0$,
    contradicting the hypothesis.
]

#definition(name: "Lipschitz Continuity")[
  If there exists a constant $L > 0$ such that for any $x_1, x_2 in I$,
  $
    abs(f(x_1) - f(x_2)) <= L abs(x_1 - x_2),
  $
  then $f$ is called *Lipschitz continuous* on $I$, and $f$ is said to satisfy
  the *Lipschitz condition* on $I$. In particular, if $L < 1$, then $f$ is called
  a *contraction mapping* on $I$.
] <def:lipschitz-continuity>

#note[
  + If $f$ is Lipschitz continuous on $I$, then $f$ is uniformly continuous on $I$:
    for every $epsilon > 0$, simply take $delta = epsilon / L$.
  + If $f$ is uniformly continuous on $I$, then $f$ is continuous on $I$.
  + Neither converse holds; see the counterexamples following
    #link(<def:uniform-continuity>)[the definition of uniform continuity]
    ($x^2$ on $bb(R)$) and above ($sqrt(x)$ on $(0, 1)$).
  + If $f in D_I$ with $abs(f'(x)) <= M$ on $I$, then $f$ is Lipschitz continuous with
    constant $M$ (by the mean value theorem), hence uniformly continuous; see also
    #link(<ex:derivative-criterion>)[the derivative criterion below].
]

#theorem(name: "Cantor's Theorem")[
  If $f in C[a, b]$, then $f$ is uniformly continuous on $[a, b]$.
] <thm:cantor-theorem>

#proof[
  Suppose $f$ is not uniformly continuous on $[a, b]$: there exist $epsilon_0 > 0$ and,
  for every $delta > 0$, points $x', x'' in [a, b]$ with $abs(x' - x'') < delta$ but
  $abs(f(x') - f(x'')) >= epsilon_0$. Taking $delta_n = 1 / n$ produces sequences
  ${x_n'}$, ${x_n''}$ in $[a, b]$ with $abs(x_n' - x_n'') < 1 / n$ and
  $abs(f(x_n') - f(x_n'')) >= epsilon_0$.
  Since ${x_n'}$ is bounded, #link(<thm:bolzano-weierstrass>)[the Bolzano-Weierstrass theorem]
  provides a convergent subsequence: $lim_(k -> oo) x'_(n_(k)) = xi in [a, b]$.
  For the subsequence ${x_n''}$ with the same indices we have
  $
    lim_(k -> oo) x''_(n_(k)) = lim_(k -> oo) (x'_(n_(k)) + (x''_(n_(k)) - x'_(n_(k)))) = xi,
  $
  since $abs(x''_(n_(k)) - x'_(n_(k))) < 1 / n_k -> 0$.
  By continuity of $f$ at $xi$,
  $lim_(k -> oo) f(x'_(n_(k))) = lim_(k -> oo) f(x''_(n_(k))) = f(xi)$,
  hence $f(x'_(n_(k))) - f(x''_(n_(k))) -> 0$, contradicting
  $abs(f(x'_(n_(k))) - f(x''_(n_(k)))) >= epsilon_0$.
]

#corollary(name: "Extension to the Endpoints of an Open Interval")[
  Let $f$ be continuous on a finite open interval $(a, b)$. Then $f$ is uniformly continuous
  on $(a, b)$ if and only if both one-sided limits $f(a^+)$ and $f(b^-)$ exist.
] <cor:boundary-extension>

#proof[
  + ($<=$) Define
    $
      g(x) = cases(
        f(a^+) comma & x = a,
        f(x) comma & a < x < b,
        f(b^-) comma & x = b,
      )
    $
    The existence of the one-sided limits makes $g$ continuous on the closed interval
    $[a, b]$, so $g$ is uniformly continuous on $[a, b]$ by
    #link(<thm:cantor-theorem>)[Cantor's theorem]; restricting the domain preserves
    uniform continuity, so $f = bar(g)$ is uniformly continuous on $(a, b)$.
  + ($=>$) For every $epsilon > 0$ choose $delta > 0$ such that
    $abs(f(x') - f(x'')) < epsilon$ for all $x', x'' in (a, b)$ with $abs(x' - x'') < delta$.
    Pick any sequence ${x_n} subset (a, b)$ with $x_n -> a$; being convergent, ${x_n}$
    is a Cauchy sequence, so there exists $N$ with $abs(x_n - x_m) < delta$, hence
    $abs(f(x_n) - f(x_m)) < epsilon$, for all $m, n > N$.
    Thus ${f(x_n)}$ is a Cauchy sequence and converges; by
    #link(<thm:heine-theorem>)[Heine's theorem], $f(a^+) = lim_(x -> a^+) f(x)$ exists.
    The existence of $f(b^-)$ is proved analogously.
]

#proposition(name: "Approximation Problem")[
  Let $phi$ be uniformly continuous on $[a, +oo)$ and let $f$ be continuous on $[a, +oo)$
  with $lim_(x -> +oo) (f(x) - phi(x)) = 0$. Then $f$ is uniformly continuous on $[a, +oo)$.
] <prop:approximation-problem>

#example(name: "A Criterion on $[a, +oo)$")[
  If $f in C[a, +oo)$ and $lim_(x -> +oo) f(x) = A$ is finite, then $f$ is uniformly
  continuous on $[a, +oo)$.
] <ex:uniform-continuous-halfline>

#proof[
  By the Cauchy criterion for functions (#link(<thm:cauchy-criterion-function>)[function version]),
  for every $epsilon > 0$ there exists $X > 0$ such that $abs(f(x') - f(x'')) < epsilon$
  for all $x', x'' > X$ in $[a, +oo)$.
  Since $f$ is continuous on the compact interval $[a, X + 1]$, it is uniformly continuous
  there by #link(<thm:cantor-theorem>)[Cantor's theorem]: there exists $delta_0 > 0$ such that
  $abs(f(x_1) - f(x_2)) < epsilon$ for all $x_1, x_2 in [a, X + 1]$ with
  $abs(x_2 - x_1) < delta_0$.
  Set $delta = min(delta_0, 1)$. For any $x_1, x_2$ with $abs(x_1 - x_2) < delta$,
  there are three cases:
  + $x_1, x_2 in [X, +oo)$: the first estimate gives $abs(f(x_1) - f(x_2)) < epsilon$;
  + $x_1 in [X, +oo)$ and $x_2 in [a, X]$ (or vice versa): since $abs(x_1 - x_2) < delta <= 1$,
    both points lie in $[a, X + 1]$, so the second estimate applies;
  + $x_1, x_2 in [a, X]$: again the second estimate applies.

  In all cases $abs(f(x_1) - f(x_2)) < epsilon$, so $f$ is uniformly continuous on
  $[a, +oo)$.
]

#caution(title: "A Wrong Proof")[
  A tempting but *wrong* argument runs as follows:
  + by the Cauchy criterion, for every $epsilon > 0$ there exists $X > 0$ with
    $abs(f(x') - f(x'')) < epsilon$ for $x', x'' > X$; by the arbitrariness of $epsilon$,
    $f$ is uniformly continuous on $[X, +oo)$;
  + by Cantor's theorem, $f$ is uniformly continuous on $[a, X + 1]$;
  + hence $f$ is uniformly continuous on $[a, +oo)$.

  The error is in the first step: the $X$ provided by the Cauchy criterion *depends on*
  $epsilon$, so as $epsilon$ varies, $X$ moves; the fixed-interval conclusion
  "$f$ is uniformly continuous on $[X, +oo)$" cannot be drawn.
  The correct proof above fixes a single $X + 1$ and glues the two pieces together
  with the overlap of width $1$.
]

#example(name: "Boundedness on an Open Interval")[
  If $f$ is uniformly continuous on $(a, b)$, then $f$ is bounded on $(a, b)$.
] <ex:bounded-open-interval>

#proof[
  Take $epsilon = 1$ in the definition of uniform continuity: there exists $delta > 0$
  such that $abs(f(x_1) - f(x_2)) < 1$ for all $x_1, x_2 in (a, b)$ with
  $abs(x_1 - x_2) < delta$.
  Choose $n in bb(N)^+$ with $(b - a) / n < delta$ and subdivide $(a, b)$ into $n$ equal
  parts with division points $x_k = a + k (b - a) / n$, $k = 0, 1, dots, n$.
  For every $x in (a, b)$ there exists $k$ with $x_k <= x <= x_(k + 1)$, so
  $
    abs(x - (x_k + x_(k + 1)) / 2) <= x_(k + 1) - x_k < delta,
  $
  and hence
  $
    abs(f(x)) <= abs(f(x) - f((x_k + x_(k + 1)) / 2)) + abs(f((x_k + x_(k + 1)) / 2))
    <= 1 + max_(0 <= k <= n - 1) abs(f((x_k + x_(k + 1)) / 2)),
  $
  which is a finite bound.
]

#example(name: "The Derivative Criterion")[
  Let $f in C[0, +oo)$, let $f$ be differentiable on $(0, +oo)$, and suppose
  $lim_(x -> +oo) abs(f'(x)) = A$. Then $f$ is uniformly continuous on $[0, +oo)$
  if and only if $A$ is finite.
] <ex:derivative-criterion>

#proof[
  + $A$ finite: since $lim_(x -> +oo) abs(f'(x)) = A$, there exists $N > 0$ with
    $abs(f'(x)) < A + 1$ for all $x > N$.
    By the Lagrange mean value theorem, for $x_1 > x_2 > N$ there exists
    $xi in (x_2, x_1)$ with $f(x_1) - f(x_2) = f'(xi) (x_1 - x_2)$, hence
    $abs(f(x_1) - f(x_2)) < (A + 1) abs(x_1 - x_2)$:
    $f$ satisfies the Lipschitz condition on $[N, +oo)$ and is uniformly continuous there.
    On $[0, N + 1]$, $f$ is uniformly continuous by #link(<thm:cantor-theorem>)[Cantor's theorem];
    as in #link(<ex:uniform-continuous-halfline>)[the previous example], the two pieces glue
    together, so $f$ is uniformly continuous on $[0, +oo)$.
  + $A$ infinite: since $lim_(x -> +oo) abs(f'(x)) = +oo$, for every $G > 0$ there exists
    $X > 0$ with $abs(f'(x)) > G$ for all $x > X$.
    Fix $epsilon_0 = 1$. For any $delta > 0$, choose $G > 1 / delta$ and set
    $x' = 2 X$, $x'' = 2 X + 1 / G$; then $x', x'' > X$ and
    $abs(x' - x'') = 1 / G < delta$, while the mean value theorem gives some
    $xi$ between $x'$ and $x''$ with
    $
      abs(f(x') - f(x'')) = abs(f'(xi)) abs(x' - x'') > G dot 1 / G = 1 = epsilon_0.
    $
    Hence $f$ is not uniformly continuous on $[0, +oo)$.
]

#note[
  This provides a convenient test: for $f in D_I$, boundedness of $f'$ on $I$
  implies uniform continuity of $f$ on $I$; and if $abs(f'(x)) -> +oo$ at infinity,
  uniform continuity fails.
]

#example(name: "Periodic Functions Are Uniformly Continuous")[
  A continuous periodic function on $bb(R)$ is uniformly continuous on $bb(R)$.
] <ex:uniform-continuous-periodic>

#proof[
  Let $T$ be a period of $f$. By #link(<thm:cantor-theorem>)[Cantor's theorem] applied on
  $[-T, 2 T]$, for every $epsilon > 0$ there exists $delta_1 > 0$ such that
  $abs(f(x') - f(x'')) < epsilon$ for all $x', x'' in [-T, 2 T]$ with
  $abs(x' - x'') < delta_1$.
  Given $x', x'' in bb(R)$ with $abs(x' - x'') < delta_1$, shift $x'$ by an integer multiple
  of $T$ into $[0, T]$; then both shifted points lie in $[-T, 2 T]$ and their distance is
  unchanged, while periodicity leaves $f$ unchanged. Hence
  $d = min(delta_1, T)$ works globally.
]

#example(name: "Images of Cauchy Sequences")[
  Let $I$ be a finite interval and let $f$ be defined on $I$. Then $f$ is uniformly
  continuous on $I$ if and only if $f$ maps every Cauchy sequence in $I$ to a Cauchy sequence.
] <ex:cauchy-mapping>

#proof[
  + ($=>$) For every $epsilon > 0$ choose $delta > 0$ as in the definition of uniform
    continuity. If ${x_n} subset I$ is a Cauchy sequence, there exists $N$ with
    $abs(x_m - x_n) < delta$ for all $m, n > N$; hence $abs(f(x_m) - f(x_n)) < epsilon$
    for all $m, n > N$, so ${f(x_n)}$ is a Cauchy sequence.
  + ($<=$) Suppose $f$ is not uniformly continuous on $I$: there exist $epsilon_0 > 0$ and
    sequences with $abs(x_n - x_n') < 1 / n$ but $abs(f(x_n) - f(x_n')) >= epsilon_0$.
    Since $I$ is finite, #link(<thm:bolzano-weierstrass>)[the Bolzano-Weierstrass theorem]
    gives a convergent subsequence $x_(n_(k)) -> eta$ with the same-index subsequence
    satisfying $x'_(n_(k)) -> eta$ as well.
    The interleaved sequence $x_(n_(1)), x'_(n_(1)), x_(n_(2)), x'_(n_(2)), dots$ converges
    (both strands converge to $eta$), hence is a Cauchy sequence; but its image under $f$
    contains pairs with $abs(f(x_(n_(k))) - f(x'_(n_(k)))) >= epsilon_0$,
    so the image is not a Cauchy sequence -- a contradiction.
]

#note[
  The finiteness of $I$ is used only in the sufficiency; for infinite intervals
  the necessity still holds.
]

== Period Three Implies Chaos // 周期三蕴含混沌

// §3.5：tex 中完全为空，内容取自 md L1864–1905（周期三蕴含混沌）；
// 外链图片不可用，跳过；各引理与定理 md 均未给出证明，保持原状

=== One-Dimensional Iterative Dynamical Systems // 一维迭代动力系统

#definition(name: "One-Dimensional Iterative Dynamical System")[
  A recurrence $x_(n+1) = f(x_n) quad (n in bb(N)_+)$ is called a
  *one-dimensional iterative dynamical system* (or *one-dimensional discrete
  dynamical system*) in the theory of dynamical systems. Starting from an
  initial value $x_0$, iteration generates a sequence ${x_n}_(n >= 0)$, called
  the *orbit* determined by $x_0$. If for some orbit ${x_n}$ there exists a
  positive integer $p$ such that $x_(n+p) = x_n$ for all $n >= 0$, the orbit is
  called a *periodic orbit* with period $p$, and its points are called
  *periodic points*. The smallest such $p$ is the *minimal period* of the orbit.
  A periodic orbit of period $1$ is called a *fixed point*.
] <def:one-dimensional-iteration>

=== The Li-Yorke Theorems // Li-Yorke 定理

#note[
  Throughout this subsection, $f^n$ denotes the $n$-fold iterate of $f$:
  $
    f^n(x) = underbrace(f(f(dots f(x) dots)), [n "folds"]).
  $
]

#lemma(name: "Fixed-Point Lemma")[
  Let $I$ be a bounded closed interval and $f in C(I)$. If $f(I) supset I$,
  then $f$ has a fixed point in $I$.
] <lem:cover-fixed-point>

#lemma(name: "Subinterval Covering Lemma")[
  Let $I, J$ be two bounded closed intervals and $f in C(I)$. If $f(I) supset J$,
  then there exists a closed subinterval $I' subset I$ such that $f(I') = J$.
] <lem:cover-subinterval>

#lemma(name: "Cyclic Covering Lemma")[
  Let $f$ be a continuous function defined on bounded closed intervals
  $I_0, I_1, dots, I_(n-1)$ satisfying
  $
    f(I_0) supset I_1, quad f(I_1) supset I_2, quad dots, quad
    f(I_(n-2)) supset I_(n-1), quad f(I_(n-1)) supset I_0.
  $
  Then there exists a point $x_0$ such that $f^n(x_0) = x_0$ and
  $f^i(x_0) in I_i$ for $i = 1, 2, dots, n-1$.
] <lem:cover-cyclic>

#theorem(name: "The First Li-Yorke Theorem")[
  Let $I$ be an interval, $f in C(I)$ with $f(I) subset I$. Suppose there exist
  points $a, b, c, d in I$ such that
  $
    f(a) = b, quad f(b) = c, quad f(c) = d, quad quad
    d <= a < b < c quad "or" quad d >= a > b > c.
  $
  Then $f$ admits periodic orbits with minimal period $p$ for every positive
  integer $p$.
] <thm:li-yorke-first>

#theorem(name: "The Second Li-Yorke Theorem")[
  Let $I$ be an interval, $f in C(I)$ with $f(I) subset I$. Then there exists an
  uncountable set $S$ in the interval $I$ such that for any two points
  $x, y in S$ with $x != y$, the orbits ${f^n(x)}$ and ${f^n(y)}$ generated by
  iteration have the following properties:
  + $limsup_(n -> oo) abs(f^n(x) - f^n(y)) > 0$;
  + $liminf_(n -> oo) abs(f^n(x) - f^n(y)) = 0$;
  + $limsup_(n -> oo) abs(f^n(x) - f^n(p)) > 0$, where $p$ is any periodic point
    of $f$.
] <thm:li-yorke-second>

#definition(name: "Li-Yorke Chaos")[
  Let $f$ be defined on an interval $I$ with $f(I) subset I$. If the following
  conditions hold:
  + The minimal periods of the periodic points of $f$ are unbounded;
  + There exists an uncountable subset $S$ of $I$ such that for any two points
    $x, y in S$ with $x != y$,
    $
      limsup_(n -> oo) abs(f^n(x) - f^n(y)) > 0, quad quad
      liminf_(n -> oo) abs(f^n(x) - f^n(y)) = 0;
    $
  then the dynamical system generated by iteration of $f$ is called *chaotic*.
] <def:li-yorke-chaos>

== Functional Equations // 函数方程

// §3.6：tex 中完全为空，内容取自 md L1907–2005（函数方程）

=== Classical Functional Equations // 经典函数方程

#proposition(name: "Classical Functional Equations")[
  The following elementary functions give the canonical solutions of several
  classical functional equations:
  + $f(x) = a x$ satisfies
    $
      f(x + y) = f(x) + f(y) quad quad (forall x, y in bb(R));
    $
  + $f(x) = a^x quad (a > 0)$ satisfies
    $
      f(x + y) = f(x) dot f(y) quad quad (forall x, y in bb(R));
    $
  + $f(x) = log_a x quad (a > 0)$ satisfies
    $
      f(x y) = f(x) + f(y) quad quad (forall x, y > 0);
    $
  + $f(x) = x^a$ satisfies
    $
      f(x y) = f(x) dot f(y) quad quad (forall x, y > 0);
    $
  + $f(x) = cos a x$ and $g(x) = cosh a x$ satisfy
    $
      f(x + y) + f(x - y) = 2 f(x) dot f(y) quad quad (forall x, y in bb(R));
    $
  + $f(x) = cos a x$ and $g(x) = sin a x$ satisfy the system of functional
    equations
    $
      cases(
        f(x + y) = f(x) f(y) - g(x) g(y) comma
        g(x + y) = f(x) g(y) + f(y) g(x),
      ) quad quad (forall x, y in bb(R)).
    $
] <prop:classic-functional-equations>

=== The Cauchy Equation // Cauchy 方程

#example(name: "The Cauchy Equation")[
  The unique solution of the functional equation
  $
    f(x + y) = f(x) + f(y) quad quad (forall x, y in bb(R))
  $
  that is continuous at $x = 0$ is $f(x) = a x$, where $a$ is a constant.
] <ex:cauchy-equation>

#proof[
  *Step 1: Homogeneity, $f(c x) = c f(x)$ for all $c in bb(R)$.*

  + ($n in bb(N)$) We prove $f(n x) = n f(x)$ by induction. For $n = 2$,
    $f(2 x) = f(x + x) = f(x) + f(x)$ holds. Assume $f((n-1) x) = (n-1) f(x)$;
    then $f(n x) = f((n-1) x + x) = (n-1) f(x) + f(x) = n f(x)$.
  + ($r in bb(Q)^+$) Setting $y = n x$ gives $f(y) = n f(y / n)$, i.e.,
    $f(y / n) = f(y) / n$. Combining this with the previous item yields
    $f(m / n dot y) = m / n dot f(y)$ for all $m, n in bb(N)$, hence
    $f(r x) = r f(x)$ for all $r in bb(Q)^+$.
  + ($r in bb(Q)$) From $f(x) = f(0 + x) = f(0) + f(x)$ we get $f(0) = 0$;
    hence $f(x) + f(-x) = f(0) = 0$, i.e., $f(x) = -f(-x)$. Applying the
    previous item with $x = m / n dot y$ gives
    $f(- m / n dot y) = -f(m / n dot y) = - m / n dot f(y)$, hence
    $f(r x) = r f(x)$ for all $r in bb(Q)$.
  + (Continuity everywhere) For any $x_0 in bb(R)$, write $x = x_0 + Delta x$;
    since $f$ is continuous at $0$ and $f(0) = 0$,
    $
      lim_(x -> x_0) f(x) & = lim_(Delta x -> 0) f(x_0 + Delta x) \
                          & = lim_(Delta x -> 0) [f(x_0) + f(Delta x)] \
                          & = f(x_0) + lim_(Delta x -> 0) f(Delta x) \
                          & = f(x_0),
    $
    so $f$ is continuous at every point of $bb(R)$.
  + ($c in bb(R)$) The two continuous functions $c arrow.r f(c x)$ and
    $c arrow.r c f(x)$ agree at every rational $c$ by the first three items; by
    #link(<ex:continuous-agree-dense>)[the density argument] they agree for all
    $c in bb(R)$, i.e., $f(c x) = c f(x)$.

  *Step 2: Conclusion.* Taking $c = x$ and $x = 1$ in Step 1 gives
  $f(x) = f(1 dot x) = x f(1)$; setting $a = f(1)$ yields $f(x) = a x$.
]

=== The d'Alembert Equation // d'Alembert 方程

#example(name: "The d'Alembert Equation")[
  The continuous solutions of
  $
    f(x + y) + f(x - y) = 2 f(x) dot f(y) quad quad (forall x, y in bb(R))
  $
  that are not identically zero on the real axis $bb(R)$ are $f(x) = cos a x$
  or $f(x) = cosh a x$, where $a$ is a constant.
] <ex:dalembert-equation>

#note[
  Indeed, $cos x = (e^(i x) + e^(-i x)) / 2$ and
  $cosh x = (e^x + e^(-x)) / 2$: the trigonometric and hyperbolic families are
  the two faces of one and the same functional equation.
]

#proof[
  *Step 1: $f(0) = 1$ and $f$ is even.* Setting $y = 0$ in the equation gives
  $2 f(x) = 2 f(x) f(0)$; since $f != 0$ identically, this forces $f(0) = 1$.
  Setting $x = 0$ gives $f(y) + f(-y) = 2 f(y)$, i.e., $f$ is even.

  *Step 2: Construction of the parameter.* Since $f(0) = 1$ and $f$ is
  continuous, by the local sign-preserving property there exists $c > 0$ such
  that $f(x) > 0$ for all $x in [0, c]$. Two cases:

  (a) If $f(c) <= 1$: since $0 < f(c) <= 1$ and $cos$ maps $[0, pi / 2]$
  bijectively onto $[0, 1]$, there exists $theta in [0, pi / 2]$ with
  $f(c) = cos theta$. Rewrite the equation as
  $f(x + y) = 2 f(x) f(y) - f(x - y)$. Setting $x = y = c$ gives
  $
    f(2 c) = 2 f(c)^2 - f(0) = 2 cos^2 theta - 1 = cos 2 theta.
  $
  We now prove $f(n c) = cos n theta$ by strong induction. The cases
  $n = 1, 2$ have just been established. Assume
  $f((n-2) c) = cos (n-2) theta$ and $f((n-1) c) = cos (n-1) theta$; setting
  $x = (n-1) c$, $y = c$ gives
  $
    f(n c) = 2 cos (n-1)theta cos theta - cos (n-2)theta = cos n theta.
  $
  Hence
  $
    f(n c) = cos n theta quad quad forall n in bb(N). quad quad (1)
  $
  Setting $x = y = c / 2$ gives
  $f(c / 2)^2 = 1 / 2 (cos theta + 1) = cos^2 (theta / 2)$; since
  $c / 2 in [0, c]$, we have $f(c / 2) > 0$, so $f(c / 2) = cos (theta / 2)$.
  By induction, if $f(c / 2^(n-1)) = cos (theta / 2^(n-1))$, setting
  $x = y = c / 2^n$ gives
  $
    f(c / 2^n)^2 = 1 / 2 (cos (theta / 2^(n-1)) + 1) = cos^2 (theta / 2^n),
  $
  and again $f(c / 2^n) > 0$, so
  $
    f(c / 2^n) = cos (theta / 2^n). quad quad (2)
  $
  Combining (1) and (2), $f(m / 2^n dot c) = cos (m / 2^n dot theta)$ for all
  $m, n$. Since the set ${p / q | p, q in bb(N)_+}$ is dense in the positive
  real axis, for every $x > 0$ there exist numbers $x_i$ of the form
  $m / 2^n$ with $x_i -> x$; then $f(x_i c) = cos (x_i theta)$, and by
  continuity $f(x c) = lim_(i -> oo) f(x_i c) = cos (theta x)$. Since $f$ is
  even and $f(0) = 1$, this holds for all $x in bb(R)$. Substituting $x c = y$
  and writing $a = theta / c$ yields $f(y) = cos a y$.

  (b) If $f(c) > 1$: the argument is entirely similar, with $cosh$ in place of
  $cos$ (since $cosh$ maps $[0, +oo)$ bijectively onto $[1, +oo)$, there exists
  $theta >= 0$ with $f(c) = cosh theta$, and every identity above survives with
  $cosh$ substituting for $cos$).
]

=== Equations Reducible by Substitution // 可代入化归的方程

#note[
  The following two problems are solved by the substitution method: a suitable
  change of variables reduces them to the results already proved above.
]

#example(name: "The Exponential Equation")[
  The unique continuous solution of
  $
    f(x + y) = f(x) dot f(y) quad quad (forall x, y in bb(R))
  $
  that is not identically zero on the real axis $bb(R)$ is $f(x) = a^x$, where
  $a > 0$ is a constant.
] <ex:exponential-equation>

#proof[
  *Step 1: Positivity, $f(x) > 0$.* Since $f$ is not identically zero, there exists
  $x_0 in bb(R)$ with $f(x_0) != 0$. Setting $y = x_0 - x$ in the equation
  gives $f(x) dot f(x_0 - x) = f(x_0) != 0$, hence $f(x) != 0$ for all $x$.
  Furthermore,
  $
    f(x) = f(x / 2 + x / 2) = f(x / 2)^2 > 0.
  $

  *Step 2: Substitution.* If $f(1) = 1$, then $f(x) = f(x / 2)^2 equiv 1 = 1^x$
  and we are done; otherwise set $F(x) = log_a f(x)$ with $a = f(1) > 0$,
  $a != 1$. Then $F$ is continuous and satisfies
  $F(x + y) = F(x) + F(y)$ for all $x, y in bb(R)$. By
  #link(<ex:cauchy-equation>)[the Cauchy equation], $F(x) = a_1 x$; but
  $F(1) = log_a a = 1$, so $a_1 = F(1) = 1$, i.e., $F(x) = x$. Therefore
  $f(x) = a^(F(x)) = a^x$ with $a = f(1) > 0$.
]

#example(name: "The Logarithmic Equation")[
  The unique continuous solution of
  $
    f(x y) = f(x) + f(y) quad quad (forall x, y > 0)
  $
  that is not identically zero on $(0, +oo)$ is $f(x) = b log_a x$, where
  $a > 0$ and $b$ are constants.
] <ex:logarithmic-equation>

#proof[
  Fix any $a > 1$ and set $g(x) = f(a^x)$. Then $g$ is continuous on $bb(R)$
  and
  $
    g(x + y) & = f(a^(x + y)) \
             & = f(a^x dot a^y) \
             & = f(a^x) + f(a^y) \
             & = g(x) + g(y),
  $
  so by #link(<ex:cauchy-equation>)[the Cauchy equation] $g(x) = b x$ for some
  constant $b$. For $x > 0$, writing $x = a^(log_a x)$ gives
  $
    f(x) = f(a^(log_a x)) = g(log_a x) = b log_a x.
  $
]

// --- Part II: 一元函数微积分 ---
#part("Single-variable Calculus") // 一元函数微积分
= Differential // 微分学

== Differential and Derivative // 微分与导数

=== Differentiability and the Derivative // 可微性与导数

#definition(name: "Differential")[
  Let $y = f(x)$ and $x_0$ be a point of its domain. If there exists a number
  $g(x_0)$, depending only on $x_0$ and not on $Delta x$, such that
  $
    Delta y = g(x_0) Delta x + o(Delta x) quad quad (Delta x -> 0),
  $
  where $g(x_0) Delta x$ is called the *linear principal part* of $Delta y$,
  then $f$ is said to be *differentiable* at $x_0$, and $g(x_0) Delta x$ is
  called the *differential* of $f$ at $x_0$. If $f$ is differentiable at every
  point of an interval, it is said to be differentiable on that interval.

  When $Delta x -> 0$, the increment $Delta x$ of the independent variable is
  written $(dif) x$, and the linear principal part $g(x) Delta x$ of $Delta y$
  is written $(dif) y$; hence
  $
    (dif) y = g(x) (dif) x.
  $
] <def:differential>

#note[
  Differentiability at an endpoint of a closed interval is understood via
  one-sided derivatives. Geometrically, $(dif) y$ is the increment of the
  ordinate of the tangent line at the point. Clearly $g(x_0)$ is the limit of
  the ratio $Delta y / Delta x$ as $Delta x -> 0$.
]

#note[
  Differentiability implies continuity, but not conversely: the Weierstrass
  function $W(x) = sum_(n = 0)^oo a^n cos(b^n pi x)$ with $a in (0, 1)$ and
  $b = 2k + 1$ $(k in NN)$ is continuous everywhere and differentiable
  nowhere.
]

#definition(name: "Derivative")[
  Let $y = f(x)$ and $x_0$ be a point of its domain. If the limit
  $
    lim_(Delta x -> 0) (Delta y) / (Delta x)
    = lim_(Delta x -> 0) (f(x_0 + Delta x) - f(x_0)) / (Delta x)
  $
  exists, then $f$ is said to be *derivable* at $x_0$, and the limit is called
  the *derivative* of $f$ at $x_0$, denoted $f'(x_0)$ (also $y'(x_0)$,
  $((dif f) / (dif x))|_(x = x_0)$). Equivalently,
  $
    f'(x_0) = lim_(x -> x_0) (f(x) - f(x_0)) / (x - x_0).
  $
] <def:derivative>

#theorem(name: "Equivalence of Differentiability and Derivability")[
  A function $y = f(x)$ is differentiable at a point $x$ if and only if it is
  derivable at $x$. For functions of one variable, differentiability and
  derivability at a point are equivalent notions.
] <thm:differentiability-derivability>

#proof[
  ($=>$) Assume $Delta y = g(x_0) Delta x + o(Delta x)$. Dividing by
  $Delta x != 0$ gives $(Delta y) / (Delta x) = g(x_0) + o(Delta x) / Delta x$,
  so the limit of $(Delta y) / (Delta x)$ exists and equals $g(x_0)$.

  ($<=$) Assume $lim_(Delta x -> 0) (Delta y) / (Delta x) = f'(x_0)$, i.e.,
  $(Delta y) / (Delta x) = f'(x_0) + o(1)$; hence
  $Delta y = f'(x_0) Delta x + o(1) Delta x$ with $o(1) Delta x = o(Delta x)$.
]

#note[
  The expansion $Delta y = f'(x_0) Delta x + o(Delta x)$ $(Delta x -> 0)$ is
  called the *infinitesimal increment formula*. It uses the equivalent
  description of a limit
  $lim_(x -> x_0) f(x) = A <=> f(x) = A + o(1)$ as $x -> x_0$.
]

#definition(name: "One-Sided Derivatives")[
  The *left derivative* and *right derivative* of $f$ at $x_0$ are
  $
    f'_- (x_0) & = lim_(x -> x_0^-) (f(x) - f(x_0)) / (x - x_0), \
    f'_+ (x_0) & = lim_(x -> x_0^+) (f(x) - f(x_0)) / (x - x_0).
  $
  The function $f$ is derivable at $x_0$ if and only if both one-sided
  derivatives exist and are equal.
] <def:one-sided-derivatives>

#caution[
  Distinguish $f'_+ (x_0)$, the right derivative of $f$ at $x_0$, from
  $f'(x_0^+)$, the limit of the derivative function $f'$ at $x_0$. The two
  notions are unrelated in general.
]

#example(name: "A Difference Quotient Criterion")[
  Let $f$ be continuous at $x = 0$ and suppose
  $lim_(x -> 0) (f(2 x) - f(x)) / x = A$. Then $f'(0)$ exists and
  $f'(0) = A$.
] <ex:difference-quotient-criterion>

#proof[
  We must show $lim_(x -> 0) (f(x) - f(0)) / x = A$. By hypothesis, for any
  $epsilon > 0$ there is $delta > 0$ such that for all $|x| < delta$,
  $A - epsilon / 2 < (f(2 x) - f(x)) / x < A + epsilon / 2$. Substituting
  $x / 2^(k - 1)$ for $x$ $(k in NN)$ keeps the estimate valid, so
  $
    (A - epsilon / 2) / 2^k < (f(x / 2^(k - 1)) - f(x / 2^k)) / x
    < (A + epsilon / 2) / 2^k.
  $
  Summing over $k = 1, dots, n$ and using
  $sum_(k = 1)^n [f(x / 2^(k - 1)) - f(x / 2^k)] = f(x) - f(x / 2^n)$ together
  with $sum_(k = 1)^n 1 / 2^k = 1 - 1 / 2^n$ yields
  $
    (1 - 1 / 2^n)(A - epsilon / 2) < (f(x) - f(x / 2^n)) / x
    < (1 - 1 / 2^n)(A + epsilon / 2).
  $
  Letting $n -> oo$: since $x / 2^n -> 0$ and $f$ is continuous at $0$,
  $f(x / 2^n) -> f(0)$, whence
  $|(f(x) - f(0)) / x - A| <= epsilon / 2 < epsilon$. Therefore $f'(0) = A$.
]

=== Basic Differential Rules and Formulas // 基本求导与微分法则

#tex-table(
  ([], [Derivative Rules], [Differential Rules]),
  ([Linear Combination], [$(c_1 f + c_2 g)' = c_1 f' + c_2 g'$], [$(dif)(c_1 f + c_2 g) = c_1 (dif) f + c_2 (dif) g$]),
  ([Product Rule], [$(f g)' = f' g + f g'$], [$(dif)(f g) = g (dif) f + f (dif) g$]),
  ([Quotient Rule], [$(f / g)' = (f' g - f g') / g^2$], [$(dif)(f / g) = (g (dif) f - f (dif) g) / g^2$]),
  ([Inverse Function], [$[f^(-1)]'(y) = 1 / f'(x)$], [$(dif) x = (dif) y / f'(x) = [f^(-1)]'(y) (dif) y$]),
  ([Chain Rule], [$[f(g(x))]' = f'(u) g'(x) quad (u = g(x))$], [$(dif)[f(g(x))] = f'(u) g'(x) (dif) x$]),
)

#tex-table(
  ([Derivative], [Differential]),
  ([$(C)' = 0$], [$(dif)(C) = 0 dot (dif) x = 0$]),
  ([*Elementary functions*], []),
  ([$(x^alpha)' = alpha x^(alpha - 1)$], [$(dif)(x^alpha) = alpha x^(alpha - 1) (dif) x$]),
  ([$(sin x)' = cos x$], [$(dif)(sin x) = cos x (dif) x$]),
  ([$(cos x)' = -sin x$], [$(dif)(cos x) = -sin x (dif) x$]),
  ([$(tan x)' = sec^2 x$], [$(dif)(tan x) = sec^2 x (dif) x$]),
  ([$(cot x)' = -csc^2 x$], [$(dif)(cot x) = -csc^2 x (dif) x$]),
  ([$(sec x)' = tan x sec x$], [$(dif)(sec x) = tan x sec x (dif) x$]),
  ([$(csc x)' = -cot x csc x$], [$(dif)(csc x) = -cot x csc x (dif) x$]),
  ([*Inverse trigonometric functions*], []),
  ([$(arcsin x)' = 1 / sqrt(1 - x^2)$], [$(dif)(arcsin x) = (dif) x / sqrt(1 - x^2)$]),
  ([$(arccos x)' = -1 / sqrt(1 - x^2)$], [$(dif)(arccos x) = -(dif) x / sqrt(1 - x^2)$]),
  ([$(arctan x)' = 1 / (1 + x^2)$], [$(dif)(arctan x) = (dif) x / (1 + x^2)$]),
  ([ $("arccot" x)' = -1 / (1 + x^2)$], [$(dif)("arccot" x) = -(dif) x / (1 + x^2)$]),
  ([*Exponential and logarithmic functions*], []),
  ([$(a^x)' = ln a dot a^x, quad (e^x)' = e^x$], [$(dif)(a^x) = ln a dot a^x (dif) x, quad (dif)(e^x) = e^x (dif) x$]),
  (
    [$(log_a x)' = 1 / (x ln a), quad (ln x)' = 1 / x$],
    [$(dif)(log_a x) = (dif) x / (x ln a), quad (dif)(ln x) = (dif) x / x$],
  ),
  ([*Hyperbolic functions*], []),
  ([$("sh" x)' = "ch" x$], [$(dif)("sh" x) = "ch" x (dif) x$]),
  ([$("ch" x)' = "sh" x$], [$(dif)("ch" x) = "sh" x (dif) x$]),
  ([$("th" x)' = "sech"^2 x$], [$(dif)("th" x) = "sech"^2 x (dif) x$]),
  ([$("cth" x)' = -"csch"^2 x$], [$(dif)("cth" x) = -"csch"^2 x (dif) x$]),
  ([*Inverse hyperbolic functions*], []),
  ([$("arcsh" x)' = 1 / sqrt(1 + x^2)$], [$(dif)("arcsh" x) = (dif) x / sqrt(1 + x^2)$]),
  ([$("arcch" x)' = 1 / sqrt(x^2 - 1)$], [$(dif)("arcch" x) = (dif) x / sqrt(x^2 - 1)$]),
  ([$("arcth" x)' = ("arccth" x)' = 1 / (1 - x^2)$], [$(dif)("arcth" x) = (dif)("arccth" x) = (dif) x / (1 - x^2)$]),
  ([*A useful special case*], []),
  (
    [$[ln(x + sqrt(x^2 + a^2))]' = 1 / sqrt(x^2 + a^2)$],
    [$(dif)[ln(x + sqrt(x^2 + a^2))] = (dif) x / sqrt(x^2 + a^2)$],
  ),
)

=== Invariance of the Form of Differentials and Parametric Differentiation // 一阶微分形式不变性与参数方程求导

#theorem(name: "Invariance of the Form of the First-Order Differential")[
  Since $dif[f(u)] = f'(u) (dif) u$ holds whether $u$ is the independent
  variable or an intermediate variable, the differential of $y = f(u)$ has one
  and the same form in both cases. This property is called the *invariance of
  the form of the first-order differential*.
] <thm:invariance-of-differential>

#example(name: "Implicit Differentiation")[
  Find the derivative of the implicit function $y = y(x)$ determined by
  $sin y^2 = cos sqrt(x)$.
] <ex:implicit-differentiation>

#proof[
  *Method 1: differentiate both sides with respect to $x$.*
  $
    cos y^2 dot 2 y y' = -sin sqrt(x) dot 1 / (2 sqrt(x)),
  $
  so
  $
    y' = - sin sqrt(x) / (4 sqrt(x) y cos y^2).
  $

  *Method 2: take differentials of both sides.* By
  #link(<thm:invariance-of-differential>)[the invariance of the form of the
    first-order differential],
  $
    cos y^2 (dif)(y^2) = -sin sqrt(x) (dif)(sqrt(x)),
  $
  that is, $2 y cos y^2 (dif) y = -sin sqrt(x) dot (dif) x / (2 sqrt(x))$.
  Dividing by $(dif) x$ gives the same result
  $(dif y) / (dif x) = -sin sqrt(x) / (4 sqrt(x) y cos y^2)$.
]

#theorem(name: "Differentiation of Parametric Equations")[
  Let $x$ and $y$ be determined by the parametric equations
  $x = phi(t)$, $y = psi(t)$, $alpha <= t <= beta$, where $phi$ and $psi$ are
  differentiable and $phi'(t) != 0$. Then
  $
    (dif y) / (dif x) = (dif y) / (dif t) dot (dif t) / (dif x) = (psi'(t)) / (phi'(t)).
  $
  This may also be viewed as the quotient of the differentials
  $dif y = psi'(t) (dif) t$ and $dif x = phi'(t) (dif) t$.
] <thm:parametric-differentiation>

== Higher-Order Derivatives // 高阶导数

#definition(name: "Derivatives of Higher Order")[
  Let $y = f(x)$. If the $(n - 1)$-st derivative $f^((n - 1))(x)$ is still a
  derivable function, its derivative $f^((n))(x)$ is called the *$n$-th
  derivative* of $f$, and $f$ is said to be $n$ times derivable. Clearly, if
  the $n$-th derivative exists, then all derivatives of order below $n$ exist.
] <def:higher-order-derivative>

Some useful formulas of higher-order derivatives:
$
          (a^x)^((n)) & = (ln a)^n a^x \
  (sin alpha x)^((n)) & = alpha^n sin(alpha x + (n pi) / 2) \
  (cos alpha x)^((n)) & = alpha^n cos(alpha x + (n pi) / 2) \
         (ln x)^((n)) & = (-1)^(n - 1) (n - 1)! / x^n \
      (x^alpha)^((n)) & = alpha (alpha - 1) dots (alpha - n + 1) x^(alpha - n),
$

In order to obtain the higher-order derivatives of a linear combination and a
product of two or more functions, we need the following theorems.

#theorem(name: "Linear Operation of Higher-Order Derivatives")[
  If $f, g in D^((n))(I)$, then for any constants $c_1, c_2 in bb(R)$,
  $
    (c_1 f + c_2 g)^((n)) = c_1 f^((n)) + c_2 g^((n)).
  $
] <thm:linear-operation-higher-order>

#theorem(name: "Leibniz's Formula")[
  If $f, g in D^((n))(I)$, then
  $
    (f g)^((n)) = sum_(k = 0)^n binom(n, k) f^((k)) g^((n - k)).
  $
] <thm:leibniz-formula>

#caution[
  Note the distinction:
  - $dif x^2$ represents the square of the differential of the independent
    variable, i.e., $(dif x)^2$;
  - $dif^2 x$ represents the second differential of the independent variable,
    $dif(dif x)$;
  - $dif(x^2)$ represents the differential of $x^2$, which is $2 x (dif) x$.
]

#note[
  In general $(dif)^n y = f^((n))(x) (dif) x^n$. The invariance of form holds
  only for *first-order* differentials: in fact, if $u$ is an intermediate
  variable, then $(dif)^2 y = f''(u) (dif) u^2 + f'(u) (dif)^2 u$, and the
  extra term $f'(u) (dif)^2 u$ breaks the invariance.
]

#example(name: "A Flat Function")[
  Let
  $
    f(x) = cases(e^(-1 / x^2) & x != 0 comma, 0 & x = 0).
  $
  Then $f^((n))(0) = 0$ for all $n in NN^+$.
] <ex:flat-function>

#proof[
  We argue by induction on $n$. First,
  $
    f'(0) = lim_(x -> 0) (e^(-1 / x^2) - 0) / (x - 0) = lim_(x -> 0) (1\/x) / e^(1\/x^2) = lim_(y -> oo) y / e^(y^2) = 0,
  $
  by the substitution $y = 1 / x$. Assume $f^((n - 1))(0) = 0$. By Leibniz's
  formula, for $x != 0$,
  $
    f^((n - 1))(x) = p(1\/x) e^(-1 / x^2),
  $
  where $p(1\/x)$ denotes some polynomial in $1 / x$. Therefore
  $
    f^((n))(0) = lim_(x -> 0) (p(1\/x) e^(-1 / x^2) - 0) / (x - 0) = lim_(y -> oo) (y p(y)) / e^(y^2) = 0,
  $
  since the exponential dominates any polynomial.
]

#note[
  The graph of $f$ is extremely flat near $x = 0$: this function shows that a
  non-constant function may have all derivatives of every order vanish at a
  point.
]

#example(name: "A Smooth Bridge between Two Constants")[
  Extend the constant function $u(x) equiv 0$ on $(-oo, 0]$ and the constant
  function $v(x) equiv 1$ on $[1, +oo)$ to an infinitely differentiable
  function on $(-oo, +oo)$ with values in $[0, 1]$.
] <ex:smooth-bridge>

#proof[
  Set
  $
    g(x) = cases(0 & x <= 0 comma, e^(-1 / x^2) & x > 0),
  $
  which is infinitely differentiable by #link(<ex:flat-function>)[the flat
    function above]. Then
  $
    f(x) = g(x) / (g(x) + g(1 - x))
  $
  meets the requirements: for $x <= 0$ we have $f(x) = 0$; for $x >= 1$ we have
  $f(x) = 1$; and for $0 < x < 1$ both $g(x)$ and $g(1 - x)$ are positive, so
  $0 < f(x) < 1$. The denominator never vanishes, and $f$ is infinitely
  differentiable as a quotient of infinitely differentiable functions.
]

== Differential Mean Value Theorems // 微分中值定理

#definition(name: "Argmax and Argmin")[
  Let $f$ be defined on $(a, b)$ and $x_0 in (a, b)$. If there exists a
  neighbourhood $U(x_0, delta) subset (a, b)$ on which $f(x) <= f(x_0)$, then
  $x_0$ is called an argument of the maximum point of $f$, and $f(x_0)$ is
  referred to as the corresponding argument of the maximum (abbreviated
  $"argmax"$).

  The definition of the argmin is analogous.
] <def:argmax-argmin>

#note[
  A function may have infinitely many extremum points in an interval, e.g.,
  $f(x) = sin(1\/x)$ on $(0, 1)$. The definition of an extremum point involves
  neither continuity nor derivability: on $(0, 1)$ every rational point of the
  Riemann function is a maximum point and every irrational point a minimum
  point, by the same argument as the one showing that the Riemann function has
  limit $0$ at every point.
]

#lemma(name: "Fermat's Lemma")[
  If $f$ is differentiable at a local extremum point $x_0$, then $f'(x_0) = 0$.
] <lem:fermat>

#proof[
  Suppose $x_0$ is a local maximum point (the minimum case is analogous). By
  definition there is $U(x_0, delta)$ with $f(x) <= f(x_0)$ on it. Then for
  $x < x_0$ the difference quotient satisfies
  $(f(x) - f(x_0)) / (x - x_0) >= 0$, while for $x > x_0$ it satisfies
  $(f(x) - f(x_0)) / (x - x_0) <= 0$. Since $f$ is derivable at $x_0$,
  $f'(x_0) = f'_- (x_0) >= 0$ and $f'(x_0) = f'_+ (x_0) <= 0$, whence
  $f'(x_0) = 0$.
]

#theorem(name: "Rolle's Theorem")[
  If $f in C[a, b]$, $f in D(a, b)$ and $f(a) = f(b)$, then there exists
  $xi in (a, b)$ such that $f'(xi) = 0$.

  #underline[*Enhanced version:*] if $f in D(a, b)$ on a finite or infinite
  interval $(a, b)$, and $lim_(x -> a^+) f(x) = lim_(x -> b^-) f(x)$, then
  there exists $xi in (a, b)$ such that $f'(xi) = 0$.
] <thm:rolle>

#proof[
  By the extreme value theorem there exist $xi, eta in [a, b]$ with
  $f(xi) = M$ and $f(eta) = m$, where $M$ and $m$ are the maximum and minimum
  of $f$ on $[a, b]$. If $M = m$, then $f$ is constant and every point of
  $(a, b)$ serves as $xi$. If $M > m$, then at least one of $M$, $m$ differs
  from $f(a) = f(b)$; say $M = f(xi) > f(a) = f(b)$. Then $xi in (a, b)$ is a
  local maximum point, and Fermat's lemma gives $f'(xi) = 0$.
]

#theorem(name: "Lagrange's Mean Value Theorem")[
  If $f in C[a, b]$ and $f in D(a, b)$, then there exists $xi in (a, b)$ such
  that
  $
    f'(xi) = (f(b) - f(a)) / (b - a).
  $
] <thm:lagrange-mvt>

#proof[
  *Auxiliary function.* Let
  $phi(x) = f(x) - f(a) - (f(b) - f(a)) / (b - a) dot (x - a)$. Then
  $phi in C[a, b]$, $phi in D(a, b)$, and $phi(a) = phi(b) = 0$. By Rolle's
  theorem there exists $xi in (a, b)$ with $phi'(xi) = 0$, i.e.,
  $f'(xi) = (f(b) - f(a)) / (b - a)$.
]

#proof[
  *Determinant form.* The auxiliary function may also be written as
  $
    Delta(x) = mat(b - a, x - a; f(b) - f(a), f(x) - f(a)),
  $
  twice the signed area of the triangle through $(a, f(a))$, $(b, f(b))$ and
  $(x, f(x))$. One checks $Delta(a) = Delta(b) = 0$, so Rolle's theorem yields
  $xi in (a, b)$ with $Delta'(xi) = 0$. Since
  $Delta'(x) = (b - a) f'(x) - (f(b) - f(a))$, the conclusion follows.
]

#note[
  The conclusion of Lagrange's theorem is usually called the *Lagrange
  formula*. Its equivalent forms, collectively known as the *finite increment
  formula*, are
  $
    f(b) - f(a) = f'(xi) (b - a) = f'(a + theta (b - a)) (b - a), quad theta in (0, 1),
  $
  or, increment-wise, $Delta y = f'(x + theta Delta x) Delta x$ with
  $theta in (0, 1)$.
]

#theorem(name: "Cauchy's Mean Value Theorem")[
  If $f, g in C[a, b]$, $f, g in D(a, b)$ and $g'(x) != 0$ for all $x in (a, b)$,
  then there exists $xi in (a, b)$ such that
  $
    (f'(xi)) / (g'(xi)) = (f(b) - f(a)) / (g(b) - g(a)).
  $
] <thm:cauchy-mvt>

#proof[
  First $g(b) != g(a)$; otherwise Rolle's theorem would give some
  $x in (a, b)$ with $g'(x) = 0$. Let
  $
    F(x) = f(x) - f(a) - (f(b) - f(a)) / (g(b) - g(a)) dot (g(x) - g(a)).
  $
  Then $F(a) = F(b) = 0$, and Rolle's theorem provides $xi in (a, b)$ with
  $F'(xi) = 0$, i.e.,
  $
    f'(xi) = (f(b) - f(a)) / (g(b) - g(a)) dot g'(xi),
  $
  which is the assertion after division by $g'(xi) != 0$.
]

#note[
  Cauchy's mean value theorem can be read as the parametric form of Lagrange's
  mean value theorem applied to the curve $(g(x), f(x))$.
]

#note[
  The following types of problems commonly appear in proofs related to
  intermediate values in differential calculus:
  + Prove the existence of a point $xi$ such that $F(xi, f(xi), f'(xi)) = 0$.
    Problems of this type are generally solved by constructing an auxiliary
    function and applying Rolle's theorem. The commonly used auxiliary
    functions include:

    #tex-table(
      ([Target equation], [Auxiliary function]),
      ([$xi f'(xi) + f(xi) = 0$], [$x f(x)$]),
      ([$xi f'(xi) + n f(xi) = 0$], [$x^n f(x)$]),
      ([$xi f'(xi) - f(xi) = 0$], [$f(x) / x$]),
      ([$f'(xi) + lambda f(xi) = 0$], [$e^(lambda x) f(x)$]),
      ([$f'(xi) + f(xi) = 0$], [$e^x f(x)$]),
      ([$f'(xi) - f(xi) = 0$], [$e^(-x) f(x)$]),
    )

  + Prove the existence of two points $xi, eta$ (i.e., two intermediate values)
    such that $F(xi, f(xi), f'(xi), eta, f(eta), f'(eta)) = 0$. These problems
    can be divided into the following categories:

    #terms(
      terms.item(
        [$xi != eta$],
        [Problems of this type usually occur on one and the same
          interval $[a, b]$, and employ theorems of *double* differentiation
          intermediate values such as the Lagrange mean value theorem or Cauchy's
          mean value theorem. The specific choice of auxiliary functions often
          includes terms like $xi$ and other variables determined after
          *decomposition*.],
      ),
      terms.item(
        [$xi = eta$],
        [Such problems cannot occur within one and the same interval
          $[a, b]$. They use double differentiation mean value theorems by
          *splitting* $[a, b]$ into two intervals $[a, c]$ and $[c, b]$, and
          applying the Lagrange mean value theorem separately to each interval.
          Here, the *selection* of $xi$ and $eta$ is key.],
      ),
    )

  + As a rule, when the conditions of a theorem involve additional constraints
    about *higher-order* derivatives, it is necessary to use Taylor's
    intermediate value theorem.
]

#example(name: "Boundedness from a Bounded Derivative")[
  Let $f in C[1, +oo)$, $f in D(1, +oo)$, and suppose $e^(-x^2) f'(x)$ is
  bounded on $(1, +oo)$. Then $x e^(-x^2) f(x)$ is also bounded on
  $(1, +oo)$.
] <ex:boundedness-mvt>

#proof[
  Write $|e^(-x^2) f'(x)| <= M$ on $(1, +oo)$. We first bound $e^(-x^2) f(x)$.
  For $x > 1$, applying Cauchy's mean value theorem to $f$ and $e^(x^2)$ on
  $[1, x]$ gives a point $xi in (1, x)$ with
  $
    abs(f(x) / e^(x^2)) <= (abs(f(x) - f(1))) / (e^(x^2) - e) + abs(f(1)) / e
    = abs(f'(xi)) / (2 xi e^(xi^2)) + abs(f(1)) / e
    <= M / 2 + abs(f(1)) / e.
  $
  Now apply Cauchy's mean value theorem to $x f(x)$ and $e^(x^2)$ on $[1, x]$:
  $
    abs(x f(x)) / e^(x^2) <= (abs(x f(x) - f(1))) / (e^(x^2) - e) + abs(f(1)) / e
    = abs(xi f'(xi) + f(xi)) / (2 xi e^(xi^2)) + abs(f(1)) / e.
  $
  Since $xi > 1$,
  $
    abs(xi f'(xi) + f(xi)) / (2 xi e^(xi^2))
    <= abs(f'(xi)) / (2 e^(xi^2)) + abs(f(xi)) / (2 e^(xi^2))
    <= M / 2 + 1 / 2 (M / 2 + abs(f(1)) / e),
  $
  using the bound on $e^(-xi^2) f(xi)$ obtained in the first step. Hence
  $abs(x f(x)) / e^(x^2) <= 3 M / 4 + 3 abs(f(1)) / (2 e)$, i.e.,
  $x e^(-x^2) f(x)$ is bounded.
]

#example(name: "A Determinant Identity via Cauchy")[
  Let $f in C[a, b] inter D(a, b)$ with $a b > 0$. Show that there exists
  $xi in (a, b)$ such that
  $
    1 / (b - a) mat(a, b; f(a), f(b)) = xi f'(xi) - f(xi).
  $
] <ex:determinant-identity>

#proof[
  Since $a b > 0$, the functions $phi(x) = f(x) / x$ and $psi(x) = 1 / x$ are
  continuous on $[a, b]$ and differentiable on $(a, b)$, with
  $psi'(x) = -1 / x^2 != 0$. By Cauchy's mean value theorem there exists
  $xi in (a, b)$ such that
  $
    (f(b) / b - f(a) / a) / (1 / b - 1 / a)
    = (phi'(xi)) / (psi'(xi))
    = ((xi f'(xi) - f(xi)) / xi^2) / (-1 / xi^2)
    = f(xi) - xi f'(xi).
  $
  The left-hand side equals $(a f(b) - b f(a)) / (a - b)$, so after moving the
  sign,
  $
    1 / (b - a) mat(a, b; f(a), f(b)) = xi f'(xi) - f(xi).
  $
]

#example(name: "A Second-Order Mean Value Relation")[
  Let $f in C[a, b] inter D^((2))((a, b))$. Show that there exists $eta in (a, b)$
  such that
  $
    f(b) + f(a) - 2 f((a + b) / 2) = ((b - a) / 2)^2 f''(eta).
  $
] <ex:second-order-mvt>

#proof[
  Set $g(x) = f(x) - f(x - (b - a) / 2)$, defined for
  $x in [(a + b) / 2, b]$. Then
  $g((a + b) / 2) = f((a + b) / 2) - f(a)$ and
  $g(b) = f(b) - f((a + b) / 2)$. Applying Lagrange's mean value theorem to
  $g$ on $[(a + b) / 2, b]$ yields a point $xi in ((a + b) / 2, b)$ with
  $
    f(b) - 2 f((a + b) / 2) + f(a)
    = g(b) - g((a + b) / 2)
    = g'(xi) dot (b - a) / 2
    = [f'(xi) - f'(xi - (b - a) / 2)] dot (b - a) / 2.
  $
  Since $xi - (b - a) / 2 > a$, applying Lagrange's mean value theorem once
  more to $f'$ on $[xi - (b - a) / 2, xi]$ gives $eta in (a, b)$ with
  $f'(xi) - f'(xi - (b - a) / 2) = f''(eta) dot (b - a) / 2$, which completes
  the proof.
]

#example(name: "A Differential Inequality Forces Zero")[
  Let $f in D[0, +oo)$ with $f(0) = 0$, and suppose there exists $A > 0$ such
  that $|f'(x)| <= A |f(x)|$ for all $x in [0, +oo)$. Then $f(x) equiv 0$ for
  $x >= 0$.
] <ex:differential-inequality-zero>

#proof[
  *Step 1: $f$ vanishes on $[0, 1 / (2 A)]$.* Since $|f|$ is continuous, it
  attains a maximum $M$ at some $x_1 in [0, 1 / (2 A)]$. By Lagrange's mean
  value theorem there is $xi in (0, x_1)$ with
  $
    M = |f(x_1)| = |f(0) + f'(xi) x_1| = |f'(xi)| x_1 <= A |f(xi)| x_1
    <= A M dot 1 / (2 A) = M / 2.
  $
  Hence $M = 0$ and $f equiv 0$ on $[0, 1 / (2 A)]$.

  *Step 2: induction.* Suppose $f equiv 0$ on $[0, i / (2 A)]$. Repeating the
  argument of Step 1 on the interval $[i / (2 A), (i + 1) / (2 A)]$—now using
  $f(i / (2 A)) = 0$ as the base point—shows $f equiv 0$ there as well. By
  induction $f(x) equiv 0$ for all $x >= 0$.
]

#example(name: "Roots of the Legendre Polynomials")[
  The $n$-th Legendre polynomial is defined by
  $
    P_n (x) = 1 / (2^n n!) dot (dif^n) / (dif x^n) (x^2 - 1)^n quad (n = 0, 1, 2, dots).
  $
  Show that $P_n$ has exactly $n$ distinct real roots, all lying in $(-1, 1)$.
] <ex:legendre-roots>

#proof[
  Write $q_(2 n - m)(x) = (dif^m) / (dif x^m) (x^2 - 1)^n$ for the polynomial
  of degree $2 n - m$. By Leibniz's formula applied to
  $(x^2 - 1)^n = (x - 1)^n (x + 1)^n$, every term of $q_(2 n - m)$ contains the
  factors $(x - 1)$ and $(x + 1)$ whenever $m < n$; hence each
  $q_(2 n - m)$ ($m = 0, 1, dots, n - 1$) has the roots $plus.minus 1$.

  For $m = 0$, $q_(2 n) = (x^2 - 1)^n$ has exactly the two simple roots
  $plus.minus 1$. By Rolle's theorem $q'_(2 n)$ has a root $x_(11) in (-1, 1)$;
  applying Rolle's theorem again, $q'_(2 n - 1)$ has at least one root in each
  of $(-1, x_(11))$ and $(x_(11), 1)$, say $x_(21)$ and $x_(22)$. Induction on
  $m$ then shows that $q_(2 n - m)$ has at least $m + 2$ distinct roots in
  $[-1, 1]$:
  $
    -1, x_(m 1), x_(m 2), dots, x_(m m), 1 quad (m = 0, 1, dots, n - 1).
  $
  Taking $m = n - 1$, the polynomial $q_(n + 1)$ has at least $n + 1$ distinct
  roots in $[-1, 1]$. One further application of Rolle's theorem shows that
  $q_n = q'_(n + 1)$ has at least $n$ distinct roots in $(-1, 1)$. Since $q_n$
  has degree $n$, the fundamental theorem of algebra bounds its number of
  roots by $n$, so $q_n$---and hence $P_n$---has exactly $n$ distinct real
  roots, all of them in $(-1, 1)$.
]

The first few Legendre polynomials are
$
  P_0 (x) = 1, quad P_1 (x) = x, quad P_2 (x) = (3 x^2 - 1) / 2, quad
  P_3 (x) = (5 x^3 - 3 x) / 2.
$

#example(name: "Undetermined Coefficients and a Prescribed Third Derivative")[
  Let $f in C^((3))[-1, 1]$ with $f(-1) = 0$, $f(1) = 1$, and $f'(0) = 0$.
  Show that there exists $xi in (-1, 1)$ such that $f'''(xi) = 3$.
] <ex:undetermined-coefficients>

#proof[
  *Undetermined coefficients.* Set
  $
    F(x) = f(x) - 1 / 2 x^3 + a x^2 + b x + c,
  $
  so that $f'''(xi) = 3$ is equivalent to $F'''(xi) = 0$. It suffices to choose
  $a$, $b$, $c$ so that $F$ has enough zeros. Taking $c = -f(0)$ gives
  $F(0) = 0$; taking $a = f(0) - 1 / 2$ and $b = 0$ gives
  $
    F(1) = 1 - 1 / 2 + a + b + c = 0, quad F(-1) = 0 + 1 / 2 + a - b + c = 0.
  $
  Thus $F$ vanishes at the three distinct points $-1, 0, 1$. By Rolle's
  theorem there exist $eta_1 in (-1, 0)$ and $eta_2 in (0, 1)$ with
  $F'(eta_1) = F'(eta_2) = 0$. Moreover
  $
    F'(x) = f'(x) - 3 / 2 x^2 + 2 (f(0) - 1 / 2) x,
  $
  so $F'(0) = f'(0) = 0$, which gives $F'$ three distinct zeros
  $eta_1 < 0 < eta_2$. Rolle's theorem applied twice more yields two distinct
  zeros $zeta_1 in (eta_1, 0)$ and $zeta_2 in (0, eta_2)$ of $F''$, and finally
  a zero $xi in (zeta_1, zeta_2) subset (-1, 1)$ of $F'''$, i.e.,
  $f'''(xi) = 3$.
]

== Theorems about Derivatives // 关于导数的定理

#theorem(name: "Darboux's Intermediate Value Theorem for Derivatives")[
  If $f in D[a, b]$, then $f'$ has the intermediate value property: for every
  real number $k$ between $f'_+ (a)$ and $f'_- (b)$, there exists at least one
  $xi in [a, b]$ such that $f'(xi) = k$. In particular, if
  $f'_+ (a) dot f'_- (b) < 0$, then there exists $xi in (a, b)$ with
  $f'(xi) = 0$.
] <thm:darboux>

#proof[
  Let $F(x) = f(x) - k x$. Then $F in D[a, b]$ and
  $F'_+ (a) F'_- (b) <= 0$, since $k$ lies between $f'_+ (a)$ and $f'_- (b)$.

  If $F'_+ (a) F'_- (b) = 0$, then $F'_+ (a) = 0$ or $F'_- (b) = 0$, and we may
  take $xi = a$ or $xi = b$.

  If $F'_+ (a) F'_- (b) < 0$, suppose for instance $F'_+ (a) > 0$ and
  $F'_- (b) < 0$. By the sign-preserving property of limits there is
  $delta_1 > 0$ with $(F(x) - F(a)) / (x - a) > 0$, i.e., $F(x) > F(a)$, for
  $x in (a, a + delta_1)$; likewise there is $delta_2 > 0$ with
  $(F(x) - F(b)) / (x - b) < 0$, i.e., $F(x) > F(b)$, for
  $x in (b - delta_2, b)$. In particular $xi != a, b$. Since $F$ is continuous
  on $[a, b]$, it attains its maximum at some $xi in (a, b)$, and Fermat's
  lemma gives $F'(xi) = 0$, i.e., $f'(xi) = k$.
]

#theorem(name: "Theorem on the Limit of Derivatives")[
  If $f in C(U(x_0))$ and $f in D(accent(U, circle)(x_0))$, and
  $lim_(x -> x_0) f'(x) = A$, then $f$ is differentiable at $x_0$ and
  $f'(x_0) = A$.
] <thm:limit-of-derivative>

#proof[
  For $x in accent(U, circle)(x_0)$, Lagrange's mean value theorem applied on
  the interval between $x_0$ and $x$ provides a point $xi$ between $x_0$ and
  $x$ such that
  $
    (f(x) - f(x_0)) / (x - x_0) = f'(xi).
  $
  As $x -> x_0$, the point $xi$ is squeezed to $x_0$, so
  $
    f'(x_0) = lim_(x -> x_0) (f(x) - f(x_0)) / (x - x_0) = lim_(xi -> x_0) f'(xi) = A.
  $
]

#corollary(name: "Derivatives Have No Discontinuities of the First Kind")[
  If $f in D(a, b)$, then its derivative $f'$ can only have discontinuities of
  the second kind.
] <cor:derivative-second-kind>

#proof[
  Suppose $x_0 in (a, b)$ is a discontinuity of $f'$ which is not of the second
  kind; then the one-sided limits $f'(x_0^-)$ and $f'(x_0^+)$ exist and are
  finite. Since $f$ is continuous at $x_0$, the theorem on the limit of
  derivatives (applied one-sidedly) gives
  $
    f'(x_0^-) = f'_- (x_0), quad f'(x_0^+) = f'_+ (x_0),
  $
  while derivability of $f$ at $x_0$ gives
  $f'_- (x_0) = f'_+ (x_0) = f'(x_0)$. Hence $f'(x_0^-) = f'(x_0^+) = f'(x_0)$,
  i.e., $f'$ is continuous at $x_0$—a contradiction.
]

#example(name: "A Derivative with a Second-Kind Discontinuity")[
  For
  $
    f(x) = cases(x^2 sin(1\/x) & x != 0 comma, 0 & x = 0),
  $
  the derivative is
  $
    f'(x) = cases(2 x sin(1\/x) - cos(1\/x) & x != 0 comma, 0 & x = 0).
  $
  The limit $lim_(x -> 0) f'(x)$ does not exist, so $x = 0$ is a discontinuity
  of the second kind of $f'$.
] <ex:derivative-second-kind-discontinuity>

#example(name: "Constant Functions from Vanishing Derivatives")[
  (1) If $f in D(a, b)$ and $f'(x) equiv 0$ on $(a, b)$, then $f$ is constant
  on $(a, b)$.

  (2) If $f, g in C(I)$ and $f'(x) = g'(x)$ except at finitely many points,
  then $f(x) = g(x) + C$ on $I$ for some constant $C$.
] <ex:vanishing-derivative-constant>

#proof[
  (1) For any two points $x_1 < x_2$ in $(a, b)$, Lagrange's mean value theorem
  gives $f(x_2) - f(x_1) = f'(xi) (x_2 - x_1) = 0$, so $f$ takes the same value
  at any two points.

  (2) Let $F = f - g$, and let $x_1 < x_2 < dots < x_n$ be the (at most
  finitely many) points where possibly $F' != 0$. These points split $I$ into
  finitely many subintervals on each of which $F' equiv 0$, so by (1) $F$ is
  constant on each of them. Since $F$ is continuous on $I$, the constants agree
  across the junction points, and $F$ is constant on all of $I$.
]

#note[
  In fact, the hypothesis $lim_(x -> x_0) f'(x) = A$ already shows that
  $f in D(accent(U, circle)(x_0))$. The mnemonic for this theorem is:
  continuity + existence of the limit of the derivative $=>$ the derivative at
  the point exists and equals $A$.
]

== Taylor Theorem // 泰勒定理

=== L'Hôpital's Rule // 洛必达法则

#theorem(name: "L'Hôpital's Rule")[
  Let $f, g$ be differentiable on $(a, a + d]$ with $g'(x) != 0$ there, and
  suppose that $lim_(x -> a^+) f(x) = lim_(x -> a^+) g(x) = 0$, or that
  $lim_(x -> a^+) g(x) = oo$. If $lim_(x -> a^+) (f'(x)) / (g'(x))$ exists
  (finite or infinite), then
  $
    lim_(x -> a^+) (f(x)) / (g(x)) = lim_(x -> a^+) (f'(x)) / (g'(x)).
  $
] <thm:lhopital>

#caution[
  The rule requires $f$ and $g$ to be defined on a (one-sided) punctured
  neighborhood of the point in question. Moreover, the non-existence of
  $lim_(x -> a^+) (f'(x)) / (g'(x))$ says nothing about whether
  $lim_(x -> a^+) (f(x)) / (g(x))$ exists—it only means that the rule cannot
  be applied.
]

#proof[
  *Case 1: $f -> 0$ and $g -> 0$.* Extend $f$ and $g$ by
  $bar(f)(x) = cases(0 & x = a comma, f(x) & x > a)$ and likewise for
  $bar(g)$. Then $bar(f), bar(g) in C[a, a + d]$ and both are differentiable on
  $(a, a + d)$. For $x > a$, Cauchy's mean value theorem provides a point
  $xi in (a, x)$ with
  $
    (f(x)) / (g(x)) = (bar(f)(x) - bar(f)(a)) / (bar(g)(x) - bar(g)(a)) = (f'(xi)) / (g'(xi)).
  $
  As $x -> a^+$ we have $xi -> a^+$, so the right-hand side tends to
  $lim_(x -> a^+) (f'(x)) / (g'(x))$, which proves the claim.

  *Case 2: $g -> oo$.* Fix $x_0 in (a, a + d]$. For $x != x_0$,
  $
    (f(x)) / (g(x))
    = (f(x) - f(x_0)) / (g(x)) + (f(x_0)) / (g(x))
    = [1 - (g(x_0)) / (g(x))] dot (f(x) - f(x_0)) / (g(x) - g(x_0)) + (f(x_0)) / (g(x)).
  $
  Let $A = lim_(x -> a^+) (f'(x)) / (g'(x))$. Given $epsilon > 0$, choose
  $rho > 0$ such that $abs((f'(t)) / (g'(t)) - A) < epsilon$ whenever
  $0 < t - a < rho$, and set $x_0 = a + rho$. By Cauchy's mean value theorem,
  for every $x in (a, x_0)$ there is $xi in (x, x_0)$ with
  $(f(x) - f(x_0)) / (g(x) - g(x_0)) = (f'(xi)) / (g'(xi))$, hence
  $abs((f(x) - f(x_0)) / (g(x) - g(x_0)) - A) < epsilon$. Since
  $g(x) -> oo$ as $x -> a^+$, replacing $rho$ by some $delta in (0, rho)$
  ensures that for $0 < x - a < delta$,
  $abs(1 - (g(x_0)) / (g(x))) < 2$ and $abs((f(x_0)) / (g(x))) < epsilon$.
  Combining the estimates,
  $
    abs((f(x)) / (g(x)) - A) <= abs(1 - (g(x_0)) / (g(x))) dot abs((f(x) - f(x_0)) / (g(x) - g(x_0)) - A) + abs((f(x_0)) / (g(x))) < 3 epsilon,
  $
  which completes the proof.
]

#example(name: "A Limit from the Sum of a Function and Its Derivative")[
  Let $f in D(bb(R))$. If $lim_(x -> +oo) [f(x) + f'(x)] = A$, then
  $lim_(x -> +oo) f(x) = A$ and $lim_(x -> +oo) f'(x) = 0$.
] <ex:sum-function-derivative-limit>

#proof[
  Since $e^x -> oo$ as $x -> +oo$, L'Hôpital's rule (in the
  $oo \/ oo$ form) gives
  $
    lim_(x -> +oo) f(x)
    = lim_(x -> +oo) (e^x f(x)) / (e^x)
    = lim_(x -> +oo) (e^x f(x) + e^x f'(x)) / (e^x)
    = lim_(x -> +oo) [f(x) + f'(x)] = A.
  $
  Consequently
  $lim_(x -> +oo) f'(x) = lim_(x -> +oo) [f(x) + f'(x)] - lim_(x -> +oo) f(x) = A - A = 0$.
]

#note[
  More generally, if $lim_(x -> +oo) [f(x) + 1 / q f'(x)] = A$ for some
  $q > 0$, the same argument with $e^(q x)$ in place of $e^x$ yields
  $lim_(x -> +oo) f(x) = A$.
]

=== Taylor Formula // 泰勒公式

#theorem(name: "Taylor's Formula with Peano Remainder")[
  Let $f$ have an $n$-th derivative at $x_0$. Then there is a neighborhood of
  $x_0$ on which
  $
    f(x) = p_n (x) + r_n (x),
  $
  where
  $
    p_n (x) = f(x_0) + f'(x_0)(x - x_0) + (f''(x_0)) / (2!) (x - x_0)^2 + dots + (f^((n))(x_0)) / (n!) (x - x_0)^n
  $
  is the $n$-th Taylor polynomial of $f$ at $x_0$, and
  $r_n (x) = o((x - x_0)^n)$ as $x -> x_0$ is called the Peano remainder.
] <thm:taylor-peano>

#note[
  The hypothesis that $f^((n))(x_0)$ exists guarantees that $f$ is defined in
  some neighborhood of $x_0$ and that all derivatives $f^((k))$ with
  $k <= n - 1$ exist in that neighborhood; only $f^((n))$ is required at the
  single point $x_0$.
]

#proof[
  Set $r_n (x) = f(x) - sum_(k = 0)^n (f^((k))(x_0)) / (k!) (x - x_0)^k$; it
  suffices to show $r_n (x) = o((x - x_0)^n)$. Clearly
  $r_n (x_0) = r'_n (x_0) = dots = r_n^((n - 1))(x_0) = 0$. Applying
  L'Hôpital's rule repeatedly, each quotient satisfying the $0 \/ 0$
  hypothesis,
  $
    lim_(x -> x_0) (r_n (x)) / ((x - x_0)^n)
    = lim_(x -> x_0) (r'_n (x)) / (n (x - x_0)^(n - 1))
    = dots = lim_(x -> x_0) (r_n^((n - 1))(x)) / (n (n - 1) dots 2 (x - x_0)).
  $
  Since $r_n^((n - 1))(x) = f^((n - 1))(x) - f^((n - 1))(x_0) - f^((n))(x_0)(x - x_0)$,
  the last limit can be rewritten—without L'Hôpital, since $f^((n))$ may
  exist only at $x_0$—as
  $
    1 / n! lim_(x -> x_0) [(f^((n - 1))(x) - f^((n - 1))(x_0)) / (x - x_0) - f^((n))(x_0)]
    = 1 / n! [f^((n))(x_0) - f^((n))(x_0)] = 0,
  $
  where the final step uses the definition of $f^((n))(x_0)$.
]

#theorem(name: "Taylor's Formula with Lagrange Remainder")[
  Let $f^((n))$ be continuous on $[a, b]$ and differentiable on $(a, b)$.
  Then for any $x_0, x in [a, b]$,
  $
    f(x) = p_n (x) + r_n (x), quad
    r_n (x) = (f^((n + 1))(xi)) / ((n + 1)!) (x - x_0)^(n + 1),
  $
  where $p_n$ is the $n$-th Taylor polynomial of $f$ at $x_0$ and $xi$ lies
  strictly between $x_0$ and $x$.
] <thm:taylor-lagrange>

#note[
  For $n = 0$ this reduces to $f(x) = f(x_0) + f'(xi)(x - x_0)$, i.e., to
  Lagrange's mean value theorem.
]

#proof[
  Fix $x in [a, b]$ with $x != x_0$ and write $g(t) = (t - x_0)^(n + 1)$.
  The remainder $r_n (t) = f(t) - p_n (t)$ satisfies
  $r_n (x_0) = r'_n (x_0) = dots = r_n^((n))(x_0) = 0$, and likewise
  $g(x_0) = g'(x_0) = dots = g^((n))(x_0) = 0$. Applying Cauchy's mean value
  theorem $n + 1$ times,
  $
    (r_n (x)) / (g(x))
    = (r'_n (xi_1)) / ((n + 1)(xi_1 - x_0)^n)
    = (r''_n (xi_2)) / ((n + 1) n (xi_2 - x_0)^(n - 1))
    = dots = (r_n^((n))(xi_n)) / ((n + 1)! (xi_n - x_0))
    = (r_n^((n + 1))(xi)) / ((n + 1)!),
  $
  where each $xi_j$ lies strictly between its predecessor and $x$, so
  $x_0 < xi_n < xi < x$ (the order reverses if $x < x_0$). Since
  $r_n^((n + 1))(t) = f^((n + 1))(t)$ and $g(x) = (x - x_0)^(n + 1)$, this is
  the asserted formula.
]

#example(name: "A Third-Derivative Mean Value Formula")[
  Let $f in D^((3))[a, b]$. Show that there exists $c in (a, b)$ such that
  $
    f(b) = f(a) + f'((a + b) / 2)(b - a) + 1 / 24 f'''(c) (b - a)^3.
  $
] <ex:third-derivative-midpoint>

#proof[
  *Undetermined constant.* Let $k$ be the constant for which
  $
    f(b) = f(a) + f'((a + b) / 2)(b - a) + 1 / 24 k (b - a)^3;
  $
  it suffices to find $c in (a, b)$ with $f'''(c) = k$. Define
  $
    g(x) = f(x) - f(a) - f'((a + x) / 2)(x - a) + 1 / 24 k (x - a)^3,
  $
  so that $g(a) = g(b) = 0$. By Rolle's theorem there is $xi in (a, b)$ with
  $
    0 = g'(xi)
    = f'(xi) - f'((a + xi) / 2) - f''((a + xi) / 2) (xi - a) / 2 + 1 / 8 k (xi - a)^2.
  $
  On the other hand, expanding $f'(xi)$ about the midpoint $(a + xi) / 2$ by
  Taylor's formula with Lagrange remainder (second order) gives
  $
    f'(xi) = f'((a + xi) / 2) + f''((a + xi) / 2) (xi - a) / 2 + 1 / 2 f'''(c) ((xi - a) / 2)^2
  $
  for some $c$ between $(a + xi) / 2$ and $xi$. Substituting this into the
  equation above yields $0 = (xi - a)^2 / 8 dot [k - f'''(c)]$, hence
  $f'''(c) = k$.
]

=== Maclaurin Formula // 麦克劳林公式

Taylor's formula at $x_0 = 0$ is called the *Maclaurin formula*.

#lemma(name: "Derivative of the Taylor Polynomial")[
  If $f$ has $n + 2$ derivatives in some neighborhood of $x_0$, then the
  derivative of its $(n + 1)$-th degree Taylor polynomial is exactly the
  $n$-th degree Taylor polynomial of $f'$.
] <lem:taylor-polynomial-derivative>

Some common Maclaurin formulas are as follows:
$
  e^x = 1 + x / 1! + x^2 / 2! + x^3 / 3! + dots + x^n / n! + o(x^n), \
  ln(1 + x) = x - x^2 / 2 + x^3 / 3 - dots + (-1)^(n - 1) x^n / n + o(x^n), \
  sin x = x - x^3 / 3! + x^5 / 5! - dots + (-1)^(n - 1) (x^(2 n - 1)) / ((2 n - 1)!) + o(x^(2 n)), \
  cos x = 1 - x^2 / 2! + x^4 / 4! - dots + (-1)^n (x^(2 n)) / ((2 n)!) + o(x^(2 n + 1)), \
  arctan x = x - x^3 / 3 + x^5 / 5 - dots + (-1)^(n - 1) (x^(2 n - 1)) / (2 n - 1) + o(x^(2 n)), \
  arcsin x = x + 1 / 2 dot x^3 / 3 + (1 dot 3) / (2 dot 4) dot x^5 / 5 + dots + ((2 n - 1)!!) / ((2 n)!!) dot x^(2 n + 1) / (2 n + 1) + o(x^(2 n + 2)).
$

Specially,
$
  (1 + x)^alpha = sum_(k = 0)^n binom(alpha, k) x^k + o(x^n),
$
- if $alpha = n in bb(N)^+$, this is Newton's binomial formula
  $(1 + x)^n = 1 + binom(n, 1) x + binom(n, 2) x^2 + dots + binom(n, n) x^n$;
- if $alpha = 1 / 2$, then $(1 + x)^(1 / 2) = 1 + 1 / 2 x - 1 / 8 x^2 + dots$;
- if $alpha = -1$, then $(1 + x)^(-1) = 1 - x + x^2 - x^3 + dots$;
- if $alpha = -1 / 2$, then $(1 + x)^(-1 / 2) = 1 - 1 / 2 x + 3 / 8 x^2 - dots$.

#note(title: "Lagrange Remainders of the Common Formulas")[
  The same formulas with Lagrange remainder $r_n =
  (f^((n + 1))(theta x)) / ((n + 1)!) x^(n + 1)$, $theta in (0, 1)$, read:
  $
    e^x = sum_(k = 0)^n x^k / k! + (e^(theta x)) / ((n + 1)!) x^(n + 1),
  $
  $
    (1 + x)^alpha = sum_(k = 0)^n binom(alpha, k) x^k + binom(alpha, n + 1) x^(n + 1) (1 + theta x)^(alpha - n - 1).
  $
  In particular, for $alpha = plus.minus 1$,
  $
    1 / (1 + x) = 1 - x + x^2 - x^3 + dots + (-1)^n x^n + (-1)^(n + 1) x^(n + 1) / (1 + theta x)^(n + 2),
  $
  $
    1 / (1 - x) = 1 + x + x^2 + dots + x^n + x^(n + 1) / (1 - theta x)^(n + 2).
  $
]

=== Euler and Bernoulli Numbers // 欧拉数与伯努利数

#definition(name: "Euler Numbers")[
  The Euler numbers $E_n$ are defined by the Taylor series expansion of the
  hyperbolic secant function:
  $
    "sech" x = 2 / (e^x + e^(-x)) = sum_(n = 0)^oo E_n x^n / n!.
  $
  The odd-indexed Euler numbers are all zero, and the even-indexed ones have
  alternating signs. Some values are:
  $
    E_0 = 1, quad E_2 = -1, quad E_4 = 5, quad E_6 = -61, quad E_8 = 1385.
  $
] <def:euler-numbers>

#definition(name: "Bernoulli Numbers")[
  The Bernoulli numbers $B_n$ are defined by the Taylor series expansion of
  the function $x / (e^x - 1)$:
  $
    x / (e^x - 1) = sum_(n = 0)^oo B_n x^n / n!.
  $
  Some values are:
  $
    B_0 = 1, quad B_2 = 1 / 6, quad B_4 = -1 / 30, quad B_6 = 1 / 42, quad B_8 = -1 / 30.
  $
  Notably, all odd-indexed Bernoulli numbers except $B_1 = -1 / 2$ are zero.
] <def:bernoulli-numbers>

#note[
  Euler and Bernoulli numbers are widely used in number theory, combinatorics,
  and numerical analysis. For example, in the infinite series
  $
    sum_(n = 1)^oo 1 / n^(2 k) = (-1)^(k - 1) ((2 pi)^(2 k)) / (2 (2 k)!) B_(2 k), quad k in bb(N)^+,
  $
  the case $k = 1$ gives the famous Basel problem result
  $sum_(n = 1)^oo 1 / n^2 = pi^2 / 6$.
]

With the help of the Bernoulli numbers,
$
  tan x = sum_(n = 1)^oo ((-4)^n (1 - 4^n) B_(2 n)) / ((2 n)!) x^(2 n - 1)
  = x + x^3 / 3 + 2 / 15 x^5 + dots.
$

== Properties of Functions // 函数的性质

=== Monotonicity and Convexity // 单调性与凸性

#definition(name: "Convex Function")[
  A function $f$ is called *convex* on an interval $I$ if for any
  $x_1, x_2 in I$ and $t in [0, 1]$, the following inequality holds:
  $
    f(t x_1 + (1 - t) x_2) <= t f(x_1) + (1 - t) f(x_2).
  $
  If the inequality is strict for $x_1 != x_2$ and $t in (0, 1)$, then $f$ is
  called *strictly convex* on $I$. Conversely, if the inequality is reversed,
  then $f$ is called *concave* (or *concave down*) on $I$.
] <def:convex-function>

A related concept is that of *inflection points*: a point on the graph of a
function at which the concavity changes.

#figure(
  image("img/ConvexFunction.png", width: 80%),
  caption: [A convex function: the chord between any two points of the graph lies above the graph.],
) <fig:convex-function>

#theorem(name: "Equivalent Definitions of Convexity")[
  Besides the defining chord inequality, a function $f$ on an interval $I$ is
  convex under each of the following conditions:
  + *Jensen definition:* $f((x_1 + x_2) / 2) <= (f(x_1) + f(x_2)) / 2$ for
    all $x_1, x_2 in I$;
  + $f((x_1 + x_2 + dots + x_n) / n) <= (f(x_1) + f(x_2) + dots + f(x_n)) / n$
    for all $x_1, dots, x_n in I$;
  + the tangent line at every point of the graph lies below the graph.

  Statements (2) and (3) are equivalent. When $f$ is continuous, statements
  (1), (2), and (3) are equivalent. When $f$ is differentiable, all four
  statements are equivalent.
] <thm:equivalent-convexity>

#proof[
  *Step 1: (2) $<=>$ (3).* That (3) implies (2) is the case $n = 2$. For the
  converse, first prove (3) for $n = 2^k$ by repeated halving:
  $
    f((x_1 + dots + x_(2^k)) / 2^k)
    = f(((x_1 + dots + x_(2^(k - 1))) / 2^(k - 1) + (x_(2^(k - 1) + 1) + dots + x_(2^k)) / 2^(k - 1)) / 2)
    <= 1 / 2 [f((x_1 + dots + x_(2^(k - 1))) / 2^(k - 1)) + f((x_(2^(k - 1) + 1) + dots + x_(2^k)) / 2^(k - 1))]
    <= (f(x_1) + dots + f(x_(2^k))) / 2^k,
  $
  so (3) holds for every $n = 2^k$. Then proceed by downward induction:
  assuming (3) for $n + 1$, set $A = (x_1 + dots + x_k) / k$, so that
  $A = (x_1 + dots + x_k + A) / (k + 1)$; applying (3) with $n + 1$ points
  $x_1, dots, x_k, A$ gives
  $
    f(A) <= (f(x_1) + dots + f(x_k) + f(A)) / (k + 1),
  $
  and after multiplying by $k + 1$, subtracting $f(A)$, and dividing by $k$,
  $
    f((x_1 + dots + x_k) / k) <= (f(x_1) + dots + f(x_k)) / k,
  $
  which is (3) for $n = k$.

  *Step 2: (1) $<=>$ (2) when $f$ is continuous.* That (1) implies (2) is
  the case $t = 1 / 2$. For the converse, combine (2) and (3) into the
  $n$-point Jensen inequality
  $f((x_1 + dots + x_n) / n) <= (f(x_1) + dots + f(x_n)) / n$. For a rational
  weight $t = m / n in (0, 1)$,
  $
    f(t x_1 + (1 - t) x_2)
    = f((m x_1 + (n - m) x_2) / n)
    <= (m f(x_1) + (n - m) f(x_2)) / n
    = t f(x_1) + (1 - t) f(x_2).
  $
  For an irrational $t in (0, 1)$, choose rational $t_j in (0, 1)$ with
  $t_j -> t$; by continuity of $f$,
  $
    f(t x_1 + (1 - t) x_2)
    = f(lim_(j -> oo) [t_j x_1 + (1 - t_j) x_2])
    = lim_(j -> oo) f(t_j x_1 + (1 - t_j) x_2)
    <= t f(x_1) + (1 - t) f(x_2),
  $
  which is (1).

  *Step 3: (4).* In the differentiable case, the equivalence of (4) with (1)
  follows from
  #link(<thm:derivative-criteria-monotonicity-convexity>)[the derivative criteria theorem] below, whose sufficiency
  proof shows that an increasing derivative forces every tangent line to lie
  below the graph, i.e., convexity.
]

#theorem(name: "Jensen's Inequality")[
  If $f$ is convex on an interval $I$, then for any
  $x_1, x_2, dots, x_n in I$ and any $t_1, t_2, dots, t_n > 0$ with
  $t_1 + t_2 + dots + t_n = 1$,
  $
    f(t_1 x_1 + t_2 x_2 + dots + t_n x_n) <= t_1 f(x_1) + t_2 f(x_2) + dots + t_n f(x_n).
  $
  Specially, when $t_1 = t_2 = dots = t_n = 1 / n$, it reduces to statement
  (3) of #link(<thm:equivalent-convexity>)[the theorem on equivalent characterizations of convexity]. The reversed inequality holds for
  concave functions.
] <thm:jensen>

#proof[
  Induction on $n$. The case $n = 1$ is trivial, and $n = 2$ is exactly the
  definition of convexity. Suppose the inequality holds for $n - 1$, and let
  $x_1, dots, x_n in I$ with weights $t_1, dots, t_n > 0$,
  $sum_(i = 1)^n t_i = 1$. Set
  $
    mu = t_n, quad bar(x) = (sum_(i = 1)^(n - 1) t_i x_i) / (1 - mu),
  $
  so that $sum_(i = 1)^(n - 1) t_i / (1 - mu) = 1$ and
  $sum_(i = 1)^n t_i x_i = (1 - mu) bar(x) + mu x_n$. By convexity,
  $
    f(sum_(i = 1)^n t_i x_i) <= (1 - mu) f(bar(x)) + mu f(x_n),
  $
  and the induction hypothesis applied with weights $t_i / (1 - mu)$ gives
  $f(bar(x)) <= sum_(i = 1)^(n - 1) t_i f(x_i) / (1 - mu)$. Combining the two
  estimates yields the assertion.
]

#note(title: "A Taylor Proof When $f in D^((2))(I)$")[
  Let $bar(x) = sum_(i = 1)^n t_i x_i$. Taylor's formula with Lagrange
  remainder at $bar(x)$ gives, for each $i$,
  $
    f(x_i) = f(bar(x)) + f'(bar(x))(x_i - bar(x)) + 1 / 2 f''(xi_i)(x_i - bar(x))^2,
  $
  with $xi_i$ between $x_i$ and $bar(x)$. Multiplying by $t_i$ and summing,
  the linear terms cancel since $sum_(i = 1)^n t_i (x_i - bar(x)) = 0$, and
  the quadratic terms are non-negative, whence Jensen's inequality.
]

Next, we present derivative-based criteria for monotonicity and convexity:

#theorem(name: "Derivative Criteria for Monotonicity and Convexity")[
  + If $f in D(I)$, then $f$ is increasing (decreasing) on $I$ if and only if
    $f'(x) >= 0$ ($f'(x) <= 0$) for all $x in I$.
  + If $f in D^((2))(I)$, then $f$ is convex (concave) on $I$ if and only if
    $f''(x) >= 0$ ($f''(x) <= 0$) for all $x in I$.
] <thm:derivative-criteria-monotonicity-convexity>

#proof[
  (1) *Sufficiency.* For $x_1 < x_2$ in $I$, Lagrange's mean value theorem
  gives $f(x_2) - f(x_1) = f'(xi)(x_2 - x_1)$ with $xi in (x_1, x_2)$. If
  $f' >= 0$ on $I$, then $f(x_2) - f(x_1) >= 0$; if $f' > 0$ except possibly
  at finitely many points, the difference is even $> 0$, giving strict
  monotonicity. *Necessity.* If $f$ is increasing, then for
  $x, x_0 in I$ with $x != x_0$ the difference quotient
  $(f(x_0) - f(x)) / (x_0 - x) >= 0$; letting $x_0 -> x$ yields
  $f'(x) >= 0$ on $I$.

  (2) *Sufficiency.* Since $f'' >= 0$, the function $f'$ is increasing on
  $I$. Let $x_1 < x_2$ in $I$ and $x_0 = lambda x_1 + (1 - lambda) x_2$ with
  $lambda in (0, 1)$, so that $x_1 < x_0 < x_2$. By Lagrange's mean value
  theorem on $[x_1, x_0]$ and $[x_0, x_2]$, there exist $eta_1 in (x_1, x_0)$
  and $eta_2 in (x_0, x_2)$ with
  $
    f(x_1) - f(x_0) = f'(eta_1)(x_1 - x_0), quad
    f(x_2) - f(x_0) = f'(eta_2)(x_2 - x_0).
  $
  Since $f'$ is increasing, $f'(eta_1) <= f'(x_0) <= f'(eta_2)$; as
  $x_1 - x_0 < 0 < x_2 - x_0$, this gives
  $
    f(x_1) >= f(x_0) + f'(x_0)(x_1 - x_0), quad
    f(x_2) >= f(x_0) + f'(x_0)(x_2 - x_0).
  $
  Multiplying these by $lambda$ and $1 - lambda$ respectively and adding, the
  linear terms cancel because
  $lambda (x_1 - x_0) + (1 - lambda)(x_2 - x_0) = 0$, whence
  $lambda f(x_1) + (1 - lambda) f(x_2) >= f(x_0) = f(lambda x_1 + (1 - lambda) x_2)$:
  $f$ is convex. *Necessity.* By convexity, for $x in I$ and
  $Delta x > 0$ with $x plus.minus Delta x in I$,
  $
    (f(x + Delta x) + f(x - Delta x)) / 2 >= f(x),
  $
  i.e., $f(x + Delta x) - f(x) >= f(x) - f(x - Delta x)$. For $x_1 < x_2$ in
  $I$ put $Delta x_n = (x_2 - x_1) / n$ and iterate:
  $
    f(x_2) - f(x_2 - Delta x_n)
    >= f(x_2 - Delta x_n) - f(x_2 - 2 Delta x_n)
    >= dots >= f(x_1 + Delta x_n) - f(x_1),
  $
  hence
  $
    (f(x_2) - f(x_2 - Delta x_n)) / (Delta x_n) >= (f(x_1 + Delta x_n) - f(x_1)) / (Delta x_n).
  $
  Letting $n -> oo$ gives $f'(x_2) >= f'(x_1)$, so $f'$ is increasing and
  therefore $f'' >= 0$ on $I$.
]

#note[
  If $f'(x) > 0$ ($f''(x) > 0$) for all $x in I$, then $f$ is strictly
  increasing (strictly convex) on $I$. Even though the condition weakens to
  holding except at finitely many points, the conclusion of strict
  monotonicity (convexity) still holds. For example, $f(x) = x^3$ is strictly
  increasing on $bb(R)$ despite $f'(0) = 0$.
]

#theorem(name: "Inflection Points")[
  Let $f$ be twice differentiable on $(x_0 - delta, x_0) union (x_0, x_0 + delta)$.
  If $f''$ has opposite signs on $(x_0 - delta, x_0)$ and
  $(x_0, x_0 + delta)$, then $(x_0, f(x_0))$ is an inflection point of the
  curve $y = f(x)$; if the signs agree, it is not. Conversely, if $f$ is
  twice differentiable on $(x_0 - delta, x_0 + delta)$ and $(x_0, f(x_0))$ is
  an inflection point, then $f''(x_0) = 0$.
] <thm:inflection-points>

#note[
  When searching for inflection points, one must consider not only the points
  where $f''(x) = 0$ but also the points where $f''$ does not exist.
]

=== Argmax and Argmin // 最大值点与最小值点

#definition(name: "Stationary Point")[
  Stationary points are points where the first derivative of a function is
  *zero or non-existent*.
] <def:stationary-point>

Stationary points can be classified into three types:

#terms(
  terms.item([Argmax and argmin points], [Points where the function attains its local maximum or minimum values.]),
  terms.item([Inflection points], [Points where the function changes concavity.]),
  terms.item([Trivial points], [Points that are neither local maxima nor local minima.]),
)

=== Asymptote // 渐近线

#definition(name: "Asymptotes of a Curve")[
  If the distance from the point $(x, f(x))$ of the curve $y = f(x)$ to the
  line $y = a x + b$ tends to $0$ as $x -> +oo$ (or $x -> -oo$), then
  $y = a x + b$ is called an asymptote of the curve: a *horizontal asymptote*
  when $a = 0$, and an *oblique asymptote* otherwise.

  The line $y = a x + b$ is an asymptote of the curve $y = f(x)$ if and only
  if $lim_(x -> plus.minus oo) [f(x) - (a x + b)] = 0$ (the limit being taken
  in the direction under consideration), in which case
  $
    a = lim_(x -> plus.minus oo) (f(x)) / x, quad b = lim_(x -> plus.minus oo) [f(x) - a x].
  $
  If the relation holds as $x -> oo$ in both directions at once, the same
  line is asymptotic to the curve in both directions.

  Besides, if $lim_(x -> a^+) f(x) = plus.minus oo$ or
  $lim_(x -> a^-) f(x) = plus.minus oo$, then the vertical line $x = a$ is
  called a *vertical asymptote* of the curve.
] <def:asymptote>

== Applications // 应用

The criteria for extreme points and the boundedness estimates below are the
standard tools for analysing the local and global behaviour of functions.

=== Extreme Value Tests // 极值点判定

All extreme points of a function must lie among the points where
$f'(x) = 0$ (the stationary points) and the points where $f'$ does not exist.

#theorem(name: "Criteria for Extreme Points")[
  Let $f$ be defined in a neighborhood of $x_0$ and continuous at $x_0$.

  *First criterion.* Suppose $f in D((x_0 - delta, x_0) union (x_0, x_0 + delta))$
  for some $delta > 0$:
  - if $f' >= 0$ on $(x_0 - delta, x_0)$ and $f' <= 0$ on
    $(x_0, x_0 + delta)$, then $x_0$ is a local maximum point;
  - if $f' <= 0$ on $(x_0 - delta, x_0)$ and $f' >= 0$ on
    $(x_0, x_0 + delta)$, then $x_0$ is a local minimum point;
  - if $f'$ has the same sign on both sides, then $x_0$ is not an extreme
    point.

  *Second criterion.* Suppose $f'(x_0) = 0$ and $f''(x_0)$ exists:
  - if $f''(x_0) < 0$, then $x_0$ is a local maximum point;
  - if $f''(x_0) > 0$, then $x_0$ is a local minimum point;
  - if $f''(x_0) = 0$, the criterion is inconclusive.

  *Third criterion.* Suppose $f$ has $n + 1$ continuous derivatives in a
  neighborhood of $x_0$ and
  $f'(x_0) = f''(x_0) = dots = f^((n))(x_0) = 0$ with
  $f^((n + 1))(x_0) != 0$:
  - if $n$ is even, then $x_0$ is not an extreme point;
  - if $n$ is odd, then $x_0$ is a strict extreme point: a strict local
    minimum when $f^((n + 1))(x_0) > 0$, and a strict local maximum when
    $f^((n + 1))(x_0) < 0$.
] <thm:extreme-point-criteria>

#note[
  When $f''$ is continuous at $x_0$, the second criterion is the third
  criterion with $n = 1$.
]

#proof[
  We prove the third criterion. Taylor's formula with Peano remainder at
  $x_0$ gives
  $
    f(x) = f(x_0) + (f^((n + 1))(x_0)) / ((n + 1)!) (x - x_0)^(n + 1) + o((x - x_0)^(n + 1)),
  $
  hence
  $
    f(x) - f(x_0) = [(f^((n + 1))(x_0)) / ((n + 1)!) + (o((x - x_0)^(n + 1))) / ((x - x_0)^(n + 1))] (x - x_0)^(n + 1).
  $
  The bracket tends to $(f^((n + 1))(x_0)) / ((n + 1)!)$ as $x -> x_0$, so on
  a sufficiently small neighborhood it has the sign of
  $f^((n + 1))(x_0)$. If $n$ is even, then $n + 1$ is odd, so
  $(x - x_0)^(n + 1)$ changes sign across $x_0$ and so does
  $f(x) - f(x_0)$: the point $x_0$ is not an extreme point. If $n$ is odd,
  then $(x - x_0)^(n + 1) > 0$ on a punctured neighborhood, so
  $f(x) - f(x_0)$ keeps the sign of $f^((n + 1))(x_0)$ throughout: a strict
  local minimum when $f^((n + 1))(x_0) > 0$ and a strict local maximum when
  $f^((n + 1))(x_0) < 0$.
]

=== Estimates of Bounds // 界的估计

#note[
  A typical problem of this type is to bound $f'$ using bounds for $f$ and
  $f''$.
]

#example(name: "Bounding the Derivative on [0, 1]")[
  Let $f in D^((2))[0, 1]$ with $|f(x)| <= A$ and $|f''(x)| <= B$ on $[0, 1]$.
  Show that $|f'(x)| <= 2 A + 1 / 2 B$ for all $x in [0, 1]$.
] <ex:bound-derivative-0-1>

#proof[
  Fix $c in [0, 1]$. Taylor's formula with Lagrange remainder (first order)
  at $c$ gives, for $x in [0, 1]$,
  $
    f(x) = f(c) + f'(c)(x - c) + 1 / 2 f''(xi)(x - c)^2,
  $
  with $xi$ between $x$ and $c$. In particular,
  $
    f(0) = f(c) - f'(c) c + 1 / 2 f''(xi_1) c^2, quad
    f(1) = f(c) + f'(c)(1 - c) + 1 / 2 f''(xi_2)(1 - c)^2
  $
  with $xi_1, xi_2 in [0, 1]$. Subtracting the first identity from the
  second,
  $
    f'(c) = f(1) - f(0) - 1 / 2 [f''(xi_2)(1 - c)^2 - f''(xi_1) c^2],
  $
  hence, since $(1 - c)^2 + c^2 <= 1 - c + c = 1$,
  $
    |f'(c)| <= |f(1)| + |f(0)| + 1 / 2 [|f''(xi_2)| (1 - c)^2 + |f''(xi_1)| c^2] <= 2 A + 1 / 2 B.
  $
  Since $c$ was arbitrary, the claim follows.
]

#example(name: "A Landau-Type Inequality")[
  Let $f in D^((2))(-oo, +oo)$ with $M_0 = sup_(x in bb(R)) |f(x)| < +oo$ and
  $M_2 = sup_(x in bb(R)) |f''(x)| < +oo$. Then
  $M_1 = sup_(x in bb(R)) |f'(x)| < +oo$ and $M_1^2 <= 2 M_0 M_2$.
] <ex:landau-inequality>

#proof[
  Taylor's formula with Lagrange remainder gives, for $h > 0$,
  $
    f(x + h) = f(x) + f'(x) h + 1 / 2 f''(xi) h^2, quad
    f(x - h) = f(x) - f'(x) h + 1 / 2 f''(eta) h^2,
  $
  with $xi$ between $x$ and $x + h$, and $eta$ between $x$ and $x - h$.
  Subtracting and rearranging,
  $
    2 f'(x) h = f(x + h) - f(x - h) - 1 / 2 [f''(xi) - f''(eta)] h^2,
  $
  hence
  $
    2 |f'(x)| h <= 2 M_0 + h^2 M_2, quad "i.e." quad |f'(x)| <= M_0 / h + h M_2 / 2 quad "for every" h > 0.
  $
  If $M_0 = 0$ then $f equiv 0$ and hence $f' equiv 0$; if $M_2 = 0$, letting
  $h -> oo$ in the estimate forces $f' equiv 0$. In both cases the claim is
  trivial. Otherwise choose $h = sqrt(2 M_0 / M_2)$, which minimizes the
  right-hand side, to obtain $|f'(x)| <= sqrt(2 M_0 M_2)$ for every $x$;
  taking the supremum over $x$ yields $M_1 <= sqrt(2 M_0 M_2)$, i.e.,
  $M_1^2 <= 2 M_0 M_2$.
]

#example(name: "The Derivative Vanishes at Infinity")[
  Let $phi in D^((2))[0, +oo)$. If $lim_(x -> +oo) phi(x)$ exists and
  $phi''$ is bounded on $[0, +oo)$, then $lim_(x -> +oo) phi'(x) = 0$.
] <ex:derivative-vanishes-infinity>

#proof[
  Write $A = lim_(x -> +oo) phi(x)$ and let $M > 0$ with
  $|phi''(x)| <= M$. For $h > 0$,
  $
    phi(x + h) = phi(x) + phi'(x) h + 1 / 2 phi''(xi) h^2,
  $
  so
  $
    |phi'(x)| <= 1 / h [|phi(x + h) - A| + |A - phi(x)|] + 1 / 2 M h.
  $
  Given $epsilon > 0$, first choose $h > 0$ so small that
  $M h / 2 < epsilon / 2$; fixing this $h$, choose $X > 0$ so large that
  $1 / h [|phi(x + h) - A| + |A - phi(x)|] < epsilon / 2$ for all
  $x > X$. Then $|phi'(x)| < epsilon$ for all $x > X$, which proves the
  claim.
]

// B5: ch05 Indefinite Integral（不定积分）——P1-1/R5：扩为 5 节

= Indefinite Integral // 不定积分

== Antiderivatives and Indefinite Integrals // 原函数与不定积分

The differential calculus asks: given a function, find its derivative. The
theory of the indefinite integral asks the inverse question: given the
derivative, recover the original function.

#definition(name: "Antiderivative and Indefinite Integral")[
  Let $f$ be defined on an interval $I$. If there exists a function $F$ such
  that
  $ F'(x) = f(x) quad "or equivalently" quad dif F(x) = f(x) dif x $
  for all $x in I$, then $F$ is called an *antiderivative* of $f$ on $I$. The
  totality of all antiderivatives of $f$ is called the *indefinite integral*
  of $f$, denoted by
  $ integral f(x) dif x, $
  where $integral$ is the integral sign, $f(x)$ is the integrand, and $x$ is
  the variable of integration.
] <def:indefinite-integral>

If $F$ is one antiderivative of $f$ on $I$, then so is $F + C$ for any
constant $C$; conversely, any two antiderivatives of $f$ differ only by a
constant on $I$, since a function with vanishing derivative on an interval is
constant. Hence the indefinite integral is the whole family
$ integral f(x) dif x = F(x) + C, $
and in each formula below the constant $C$ denotes an arbitrary constant that
may differ from line to line.

#proposition(name: "Linearity of the Indefinite Integral")[
  If $f$ and $g$ have antiderivatives on $I$, then for any constants
  $k_1, k_2$, the function $k_1 f + k_2 g$ also has an antiderivative on $I$,
  and
  $ integral [k_1 f(x) + k_2 g(x)] dif x = k_1 integral f(x) dif x + k_2 integral g(x) dif x. $
] <prop:linearity-integrals>

#proof[
  Differentiating the right-hand side gives $k_1 f(x) + k_2 g(x)$, so it is
  an antiderivative of $k_1 f + k_2 g$. The identity should be understood as
  saying that the two sides represent the same *family* of functions: the two
  arbitrary constants on the right coalesce into a single one. In particular,
  when $k_1 = k_2 = 0$, the right-hand side is understood as the constant
  $C$.
]

== Basic Integration Formulas // 基本积分公式

The following table collects the antiderivatives that occur most frequently;
they should be memorized. Here and below $a$ denotes a positive constant with
$a != 1$, and $C$ is an arbitrary constant.

#tex-table(
  ([Integral], [Result]),
  ([$integral a dif x$], [$a x + C$]),
  ([$integral x^n dif x$], [$(x^(n + 1)) / (n + 1) + C$ #h(1fr) ($n != -1$)]),
  ([$integral (dif x) / x$], [$ln abs(x) + C$]),
  ([$integral e^x dif x$], [$e^x + C$]),
  ([$integral a^x dif x$], [$(a^x) / (ln a) + C$]),
  ([$integral ln x dif x$], [$x ln x - x + C$]),
  ([$integral sin x dif x$], [$-cos x + C$]),
  ([$integral cos x dif x$], [$sin x + C$]),
  ([$integral tan x dif x$], [$-ln abs(cos x) + C$]),
  ([$integral cot x dif x$], [$ln abs(sin x) + C$]),
  ([$integral sec x dif x$], [$ln abs(sec x + tan x) + C$]),
  ([$integral csc x dif x$], [$ln abs(csc x - cot x) + C$]),
  ([$integral sec x tan x dif x$], [$sec x + C$]),
  ([$integral csc x cot x dif x$], [$-csc x + C$]),
  ([$integral sec^2 x dif x$], [$tan x + C$]),
  ([$integral csc^2 x dif x$], [$-cot x + C$]),
  ([$integral (dif x) / sqrt(a^2 - x^2)$], [$arcsin(x / a) + C$]),
  ([$integral (-dif x) / sqrt(a^2 - x^2)$], [$arccos(x / a) + C$]),
  ([$integral (dif x) / (a^2 + x^2)$], [$(1 / a) arctan(x / a) + C$]),
  ([$integral (-dif x) / (a^2 + x^2)$], [$(1 / a) "arccot"(x / a) + C$]),
  ([$integral (dif x) / (x^2 - a^2)$], [$(1 / (2 a)) ln abs((x - a) / (x + a)) + C$]),
  ([$integral (dif x) / sqrt(x^2 + a^2)$], [$ln abs(x + sqrt(x^2 + a^2)) + C$]),
  ([$integral (dif x) / sqrt(x^2 - a^2)$], [$ln abs(x + sqrt(x^2 - a^2)) + C$ #h(1fr) ($x > a$ or $x < -a$)]),
  ([$integral sinh x dif x$], [$cosh x + C$]),
  ([$integral cosh x dif x$], [$sinh x + C$]),
)

Each entry is verified directly by differentiation.

== Two Common Integration Methods // 两种常用积分法

#definition(name: "Substitution Method")[
  *First substitution (differential assembling).* If
  $integral f(u) dif u = F(u) + C$ and $u = u(x)$ is differentiable, then
  $ integral f(u(x)) u'(x) dif x = F(u(x)) + C. $

  *Second substitution (inverse substitution).* If $integral f(x) dif x$
  exists, $x = x(t)$ is differentiable and admits an inverse $t = t(x)$, and
  $ integral f(x(t)) x'(t) dif t = F(t) + C, $
  then
  $ integral f(x) dif x = F(t(x)) + C. $
] <def:substitution-method>

#definition(name: "Integration by Parts")[
  Let $u(x)$ and $v(x)$ be differentiable, and suppose that at least one of
  $u(x) v'(x)$ and $u'(x) v(x)$ has an antiderivative. Then
  $ integral u(x) v'(x) dif x = u(x) v(x) - integral v(x) u'(x) dif x, $
  or, written with differentials,
  $ integral u dif v = u v - integral v dif u. $
] <def:integration-by-parts>

#note[
  In applying integration by parts, the classical mnemonic ranks the function
  types as *inverse trigonometric -- logarithmic -- power -- trigonometric --
  exponential*: a function standing later in this list is preferentially
  taken together with $dif x$ to play the role of $dif v$.
]

Some common substitutions are as follows:

#terms(
  terms.item(
    [Trigonometric substitution],
    [When restoring variables, auxiliary right triangles are often utilized.
      - $sqrt(a^2 - x^2)$: take $x = a sin t$ or $x = a cos t$;
      - $sqrt(a^2 + x^2)$: take $x = a tan t$ or $x = a sinh t$;
      - $sqrt(x^2 - a^2)$: take $x = a sec t$ or $x = a cosh t$.
    ],
  ),
  terms.item(
    [Irrational substitution],
    [If the integrand contains $root(x, n)$, use the substitution
      $t = root(x, n)$; if it contains
      $root((alpha x + beta) / (gamma x + delta), n)$, use
      $t = root((alpha x + beta) / (gamma x + delta), n)$.],
  ),
  terms.item(
    [Reciprocal substitution],
    [If the degree of the numerator in $x$ is lower than that of the
      denominator, use the substitution $x = 1 / t$ to reduce the degree.],
  ),
)

#example(name: "Elementary Trigonometric Integrals")[
  Compute $integral tan x dif x$ and $integral sec x dif x$.
] <ex:tangent-secant-integrals>

#proof[
  Assemble the differential of the denominator:
  $ integral tan x dif x = integral (sin x)/(cos x) dif x = - integral ((cos x)')/(cos x) dif x = - ln abs(cos x) + C. $
  For the secant, multiply numerator and denominator by $cos x$, substitute
  $u = sin x$, and split $1 / (1 - u^2)$ into partial fractions
  $1 / (1 - u^2) = 1 / 2 (1 / (1 - u) + 1 / (1 + u))$:
  $
    integral (dif x)/(cos x)
    = integral (cos x dif x)/(cos^2 x)
    = integral ((sin x)')/(1 - sin^2 x) dif x
    = 1 / 2 ln ((1 + sin x)/(1 - sin x)) + C
    = ln abs((1 + sin x)/(cos x)) + C
    = ln abs(sec x + tan x) + C.
  $
]

#example(name: "A Quadratic Radical by Sine Substitution")[
  Compute $integral sqrt(a^2 - x^2) dif x$.
] <ex:sqrt-a2-minus-x2>

#proof[
  Take $x = a sin t$ with $t in (-pi/2, pi/2)$, so that
  $dif x = a cos t dif t$ and $sqrt(a^2 - x^2) = a cos t$. Then
  $
    integral sqrt(a^2 - x^2) dif x
    = a^2 integral cos^2 t dif t
    = a^2 / 2 integral (1 + cos 2t) dif t
    = a^2 / 2 (t + (sin 2t) / 2) + C.
  $
  Restoring $t = arcsin(x / a)$ and
  $sin 2t = 2 sin t cos t = (2 x sqrt(a^2 - x^2)) / a^2$ gives
  $ integral sqrt(a^2 - x^2) dif x = x / 2 sqrt(a^2 - x^2) + a^2 / 2 arcsin(x / a) + C. $
]

#example(name: "A Quadratic Radical Solved by Parts")[
  Compute $integral sqrt(x^2 + a^2) dif x$; the integral of
  $sqrt(x^2 - a^2)$ is handled analogously.
] <ex:sqrt-x2-plus-a2>

#proof[
  Integrate by parts with $u = sqrt(x^2 + a^2)$, $dif v = dif x$:
  $
    integral sqrt(x^2 + a^2) dif x
    = x sqrt(x^2 + a^2) - integral (x^2 dif x)/(sqrt(x^2 + a^2))
    = x sqrt(x^2 + a^2) - integral ((x^2 + a^2) - a^2)/(sqrt(x^2 + a^2)) dif x
  $
  $
    = x sqrt(x^2 + a^2) - integral sqrt(x^2 + a^2) dif x + a^2 integral (dif x)/(sqrt(x^2 + a^2)).
  $
  The unknown integral reappears on the right, so solving for it as an
  equation and using the table entry
  $integral (dif x)/(sqrt(x^2 + a^2)) = ln abs(x + sqrt(x^2 + a^2))$ yields
  $ integral sqrt(x^2 + a^2) dif x = 1 / 2 (x sqrt(x^2 + a^2) + a^2 ln abs(x + sqrt(x^2 + a^2))) + C. $
]

#example(name: "A Recurrence from Integration by Parts")[
  Let $I_n = integral (dif x) / (x^2 + a^2)^n$ with $n >= 1$. Then
  $
    I_1 = 1 / a arctan(x / a) + C, quad
    I_n = (2n - 3) / (2 a^2 (n - 1)) I_(n - 1) + x / (2 a^2 (n - 1) (x^2 + a^2)^(n - 1)) quad (n >= 2).
  $
] <ex:recurrence-in>

#proof[
  The case $n = 1$ is a table entry. For $n >= 2$, write
  $a^2 = (x^2 + a^2) - x^2$:
  $
    a^2 I_n
    = integral ((x^2 + a^2) - x^2)/(x^2 + a^2)^n dif x
    = I_(n - 1) - integral (x^2 dif x)/(x^2 + a^2)^n.
  $
  For the last integral, integrate by parts with $u = x$ and
  $dif v = x (dif x) / (x^2 + a^2)^n$, for which
  $v = - 1 / (2 (n - 1) (x^2 + a^2)^(n - 1))$:
  $
    integral (x^2 dif x)/(x^2 + a^2)^n
    = - x / (2 (n - 1) (x^2 + a^2)^(n - 1)) + 1 / (2 (n - 1)) I_(n - 1).
  $
  Substituting back and dividing by $a^2$ gives the recurrence.
]

#example(name: "A Quartic Denominator by Pairing")[
  Compute $integral (dif x) / (1 + x^4)$.
] <ex:pairing-fourth-degree>

#proof[
  Pair the integral with $N(x) = integral (x^2 dif x) / (1 + x^4)$ and divide
  numerators and denominators by $x^2$. For the difference,
  $
    M(x) - N(x)
    = integral (1 - x^2)/(1 + x^4) dif x
    = - integral (1 - 1 / x^2)/(x^2 + 1 / x^2) dif x
    = - integral (dif (x + 1 / x)) / ((x + 1 / x)^2 - 2)
  $
  $
    = - 1 / (2 sqrt(2)) ln ((x^2 - sqrt(2) x + 1)/(x^2 + sqrt(2) x + 1)) + C_1,
  $
  where $dif (x + 1 / x) = (1 - 1 / x^2) dif x$ was used. For the sum,
  $
    M(x) + N(x)
    = integral (1 + x^2)/(1 + x^4) dif x
    = integral (1 + 1 / x^2)/(x^2 + 1 / x^2) dif x
    = integral (dif (x - 1 / x)) / ((x - 1 / x)^2 + 2)
    = 1 / sqrt(2) arctan((x^2 - 1) / (sqrt(2) x)) + C_2.
  $
  Solving this linear system for
  $M(x) = integral (dif x) / (1 + x^4)$:
  $
    integral (dif x) / (1 + x^4)
    = 1 / (4 sqrt(2)) ln ((x^2 + sqrt(2) x + 1)/(x^2 - sqrt(2) x + 1))
    + 1 / (2 sqrt(2)) arctan((x^2 - 1) / (sqrt(2) x)) + C.
  $
  The formula holds on $(0, +oo)$ and on $(-oo, 0)$ separately, with the
  constant adjusted on each interval, since the arctangent term jumps at
  $x = 0$.
]

== Integration of Rational Functions // 有理函数的积分

A *rational function* is a quotient of two polynomials. By polynomial
division, every rational function is the sum of a polynomial and a *proper*
rational fraction (one whose numerator has smaller degree than its
denominator). Polynomials integrate term by term, so it suffices to integrate
proper fractions.

#theorem(name: "Integration of Rational Functions")[
  Let $p / q$ be a proper rational fraction with real coefficients, and let
  the denominator factor over $bb(R)$ as
  $ q(x) = product_(k = 1)^i (x - alpha_k)^(m_k) dot product_(k = 1)^j (x^2 + 2 xi_k x + eta_k^2)^(n_k), $
  where the quadratic factors are irreducible ($eta_k^2 > xi_k^2$) and
  pairwise coprime. Then $p / q$ admits a unique decomposition into partial
  fractions
  $
    p(x) / q(x)
    = sum_(k = 1)^i sum_(r = 1)^(m_k) lambda_(k r) / (x - alpha_k)^r
    + sum_(k = 1)^j sum_(r = 1)^(n_k) (mu_(k r) x + nu_(k r)) / (x^2 + 2 xi_k x + eta_k^2)^r
  $
  with real constants. Consequently, the integration of any rational function
  reduces to two types only:
  $
    integral (dif x) / (x - alpha)^n = cases(
      ln abs(x - alpha) + C comma & n = 1,
      - 1 / ((n - 1) (x - alpha)^(n - 1)) + C comma & n >= 2,
    )
  $
  and
  $ integral (mu x + nu) / (x^2 + 2 xi x + eta^2)^r dif x. $
  The latter is reduced, by completing the square
  $x^2 + 2 xi x + eta^2 = (x + xi)^2 + (eta^2 - xi^2)$ and splitting
  $mu x + nu = mu (x + xi) + (nu - mu xi)$, to linear terms integrated
  directly and to the power recursion of
  #link(<ex:recurrence-in>)[the recurrence example].
] <thm:rational-integration>

#theorem(name: "Chebyshev's Theorem")[
  The integral of the *binomial differential*
  $ integral x^m (a + b x^n)^p dif x quad (m, n, p in bb(Q)) $
  can be reduced to the integral of a rational function --- that is, computed
  in elementary terms --- if and only if one of the following holds:
  + $p in bb(Z)$: substitute $x = t^N$, where $N$ is the common denominator
    of the fractions $m$ and $n$;
  + $(m + 1) / n in bb(Z)$: substitute $a + b x^n = t^N$, where $N$ is the
    denominator of the fraction $p$;
  + $(m + 1) / n + p in bb(Z)$: substitute $a x^(-n) + b = t^N$, where $N$ is
    the denominator of the fraction $p$.
] <thm:chebyshev>

== Integration of Trigonometric Rational Functions // 三角有理函数的积分

A *trigonometric rational function* is a quotient of polynomials in $sin x$
and $cos x$, written $R(sin x, cos x)$.

#theorem(name: "Universal Substitution")[
  For any rational function $R$, the substitution $t = tan(x / 2)$
  rationalizes the integrand:
  $
    sin x = (2 t)/(1 + t^2), quad
    cos x = (1 - t^2)/(1 + t^2), quad
    dif x = (2 dif t)/(1 + t^2),
  $
  so that
  $
    integral R(sin x, cos x) dif x
    = integral R((2 t)/(1 + t^2), (1 - t^2)/(1 + t^2)) (2 dif t)/(1 + t^2),
  $
  which is the integral of a rational function of $t$.
] <thm:universal-substitution>

#proof[
  These identities are the double-angle formulas rewritten: with
  $t = tan(x / 2)$ one has
  $sin x = (2 tan(x / 2)) / (1 + tan^2(x / 2))$ and
  $cos x = (1 - tan^2(x / 2)) / (1 + tan^2(x / 2))$; differentiating
  $x = 2 arctan t$ gives $dif x = (2 dif t) / (1 + t^2)$.
]
= Definite Integral // 定积分

== Riemann Integral // Riemann积分

The definite integral is motivated by the computation of areas of curved
regions: partition the domain, sum the areas of approximating rectangles, and
take a limit as the partition is refined.

#definition(name: "Riemann Integral")[
  Let $f(x)$ be a bounded function defined on $[a, b]$. Take any set of
  division points $\{x_i\}_(i=0)^n$ on $[a, b]$ to form a partition
  $P: a = x_0 < x_1 < dots.c < x_n = b$, and choose arbitrary points
  $xi_i in [x_(i-1), x_i]$. Denote the length of the sub-interval
  $[x_(i-1), x_i]$ as $Delta x_i = x_i - x_(i-1)$, and let
  $lambda = max_(1 <= i <= n) (Delta x_i)$. If the limit
  $ lim_(lambda -> 0) sum_(i=1)^n f(xi_i) Delta x_i $
  exists, and its value is independent of the partition $P$ and of the choice
  of the points $xi_i$, then $f(x)$ is said to be *Riemann integrable* on
  $[a, b]$.

  The summation
  $ S_n = sum_(i=1)^n f(xi_i) Delta x_i $
  is called the *Riemann sum*, and its limit $I$ is called the *definite
  integral* of $f(x)$ on $[a, b]$, denoted by
  $ I = integral_a^b f(x) dif x, $
  where $a$ and $b$ are called the lower and upper limits of the definite
  integral, respectively.

  Alternatively, the definition can be expressed as:
  $
    exists I, forall epsilon > 0, exists delta > 0, "s.t." forall P
    (lambda = max_(1 <= i <= n) (Delta x_i) < delta), forall \{xi_i\}:
    abs(sum_(i=1)^n f(xi_i) Delta x_i - I) < epsilon.
  $
] <def:riemann-integral>

#note[
  The construction of the Riemann integral follows the scheme
  partition $->$ intermediate points $->$ summation $->$ take the limit.
]

#proposition(name: "Basic Facts on Integrable Functions")[
  Let $f$ be Riemann integrable on $[a, b]$.
  1. *Uniqueness*: the limit of the Riemann sums is unique.
  2. *Boundedness*: $f$ is bounded on $[a, b]$.
] <prop:integrable-basic-facts>

#proof[
  1. If both $I_1$ and $I_2$ were limits of the Riemann sums, then for any
    partition fine enough the same Riemann sum $S_n$ would satisfy both
    $|S_n - I_1| < epsilon / 2$ and $|S_n - I_2| < epsilon / 2$, whence
    $|I_1 - I_2| < epsilon$ for all $epsilon > 0$, i.e. $I_1 = I_2$. This is
    the same argument as for the uniqueness of limits of sequences.
  2. Suppose, for contradiction, that $f$ is unbounded on $[a, b]$. Take
    $epsilon = 1$ in the definition: there is $delta > 0$ such that for every
    partition $P$ with $lambda < delta$ and every choice of intermediate
    points,
    $ |I| - 1 < abs(sum_(i=1)^n f(xi_i) Delta x_i) < |I| + 1. $
    Fix such a partition and suppose $f$ is unbounded on the first
    sub-interval $[x_0, x_1]$ (the argument is identical for any other one).
    Then $xi_1 in [x_0, x_1]$ can be chosen so that
    $ |f(xi_1) Delta x_1| > |I| + abs(sum_(j=2)^n f(xi_j) Delta x_j) + 1. $
    Writing $I_1 = abs(sum_(j=2)^n f(xi_j) Delta x_j)$ for brevity, we get
    $
      |I| + 1 > abs(sum_(j=1)^n f(xi_j) Delta x_j)
      >= |f(xi_1) Delta x_1| - I_1 > |I| + I_1 + 1 - I_1 = |I| + 1,
    $
    a contradiction.
]

#note[
  Bounded functions need not be Riemann integrable: the Dirichlet function
  $cases(D_1(x) = 1 &, x in QQ comma, D_1(x) = 0 &, x "irrational" comma)$
  is bounded but not integrable, since every Riemann sum equals either $1$
  or $0$ depending on the choice of intermediate points.
]

=== Darboux Sums // Darboux和

#definition(name: "Darboux Sums")[
  Let the supremum and infimum of $f(x)$ on $[a, b]$ be $M$ and $m$,
  respectively, so that clearly $m <= f(x) <= M$. Let the supremum and
  infimum of $f(x)$ on $[x_(i-1), x_i]$ be $M_i$ and $m_i$
  ($i = 1, 2, dots.c, n$), respectively, i.e.
  $
    M_i = sup \{f(x) | x in [x_(i-1), x_i]\}, quad
    m_i = inf \{f(x) | x in [x_(i-1), x_i]\}.
  $

  After fixing the partition $P$, define the sums
  $
    overline(S)(P) = sum_(i=1)^n M_i Delta x_i, quad
    underline(S)(P) = sum_(i=1)^n m_i Delta x_i,
  $
  which are called the *Darboux upper sum* and the *Darboux lower sum*
  corresponding to the partition $P$, respectively.
] <def:darboux-sums>

#proposition(name: "Properties of Darboux Sums")[
  1. $underline(S)(P) <= sum_(i=1)^n f(xi_i) Delta x_i <= overline(S)(P)$.
  2. If a new partition is formed by adding division points to the original
    one, then the upper sum does not increase and the lower sum does not
    decrease.
  3. Let $bold(overline(S))$ denote the set of Darboux upper sums and
    $bold(underline(S))$ the set of Darboux lower sums. For any
    $overline(S)(P_1) in bold(overline(S))$,
    $underline(S)(P_2) in bold(underline(S))$, it always holds that
    $ m(b - a) <= underline(S)(P_2) <= overline(S)(P_1) <= M(b - a). $
  4. Let $L = inf \{overline(S)(P) | overline(S)(P) in bold(overline(S))\}$ and
    $l = sup \{underline(S)(P) | underline(S)(P) in bold(underline(S))\}$,
    which are called the *upper integral* and the *lower integral*,
    respectively. It always holds that $l <= L$.
  5. (*Darboux's theorem*) For any $f in B[a, b]$ it always holds that
    $
      lim_(lambda -> 0) overline(S)(P) = L, quad
      lim_(lambda -> 0) underline(S)(P) = l.
    $
] <prop:darboux-sums>

#proof[
  Statement (1) is immediate from the definition, and (4) follows from (3)
  upon taking infimum and supremum.

  *Proof of (2).* Let $P$ be a partition with division points
  $\{x_i\}_(i=1)^n$, and let $P'$ be obtained from $P$ by inserting a single
  new point $x' in (x_(i-1), x_i)$. Let $M'_i, M''_i$ be the suprema of $f$
  on $[x_(i-1), x']$ and $[x', x_i]$ respectively; then clearly
  $M'_i <= M_i$ and $M''_i <= M_i$, whence
  $ M'_i (x' - x_(i-1)) + M''_i (x_i - x') <= M_i (x' - x_(i-1)) + M_i (x_i - x') = M_i (x_i - x_(i-1)). $
  All other terms of $overline(S)(P')$ coincide with those of
  $overline(S)(P)$, so $overline(S)(P') <= overline(S)(P)$; the statement for
  lower sums is analogous. Repeated insertion yields the general claim.

  *Proof of (3).* Any partition of $[a, b]$ can be viewed as arising from the
  trivial partition $a = x_0 < x_1 = b$ by inserting division points, so by
  (2) we get $m(b - a) <= underline(S)(P_2)$ and
  $overline(S)(P_1) <= M(b - a)$. For the middle inequality: if $P_1 = P_2$
  it holds with equality; otherwise, let $P$ be the common refinement of
  $P_1$ and $P_2$; by (2),
  $ underline(S)(P_2) <= underline(S)(P) <= overline(S)(P) <= overline(S)(P_1). $

  *Proof of (5).* We prove the statement for upper sums; the lower case is
  analogous. Suppose first $M > m$ (for $M = m$ the function is constant and
  all sums equal $M(b-a)$).
  + Since $L$ is the infimum of $bold(overline(S))$, for any $epsilon > 0$
    there exists $overline(S)(P') in bold(overline(S))$ with
    $L <= overline(S)(P') < L + epsilon / 2$, where
    $P': a = x'_0 < x'_1 < dots.c < x'_p = b$.
  + Take
    $
      delta = min \{Delta x'_1, Delta x'_2, dots.c, Delta x'_p,
      epsilon / (2(p-1)(M-m))\}.
    $
  + Let $P: a = x_0 < x_1 < dots.c < x_n = b$ be any partition with
    $lambda = max_(1 <= i <= n) (Delta x_i) < delta$.
  + Insert the points $\{x'_j\}_(j=0)^p$ into $\{x_i\}_(i=1)^n$ (i.e. merge
    $P'$ into $P$) to form a new partition $P^*$. Since $P^*$ refines both
    $P$ and $P'$, statement (2) gives
    $overline(S)(P^*) <= overline(S)(P)$ and $overline(S)(P^*) <= overline(S)(P')$.
    Classify the intervals of $P$ into two types:
    - $(x_(i-1), x_i)$ contains none of the inserted points: the
      corresponding terms of $overline(S)(P)$ and $overline(S)(P^*)$ are then
      both $M_i Delta x_i$;
    - $(x_(i-1), x_i)$ contains an inserted point: there are at most $p - 1$
      such intervals, since only $x'_1, dots.c, x'_(p-1)$ can lie in the
      interior. Moreover, since $Delta x_i < delta <= Delta x'_j$ for all
      $i, j$, each of these intervals contains exactly one inserted point
      $x'_j$: two of them, say $x'_j, x'_(j+1)$, would force
      $Delta x_i > x'_(j+1) - x'_j = Delta x'_(j+1) >= delta$, a
      contradiction. For such an interval the difference of the
      corresponding terms is at most
      $
        M_i (x_i - x_(i-1)) - [M'_i (x'_j - x_(i-1)) + M''_i (x_i - x'_j)]
        <= (M - m) (x_i - x_(i-1)) < (M - m) delta,
      $
      where $M'_i, M''_i$ are the suprema of $f$ on the two sub-intervals cut
      out by $x'_j$.
    Summing over the intervals of the second type,
    $ overline(S)(P) - overline(S)(P^*) < (p - 1)(M - m) delta <= epsilon / 2. $
    Therefore
    $
      0 <= overline(S)(P) - L = [overline(S)(P) - overline(S)(P^*)]
      + [overline(S)(P^*) - overline(S)(P')] + [overline(S)(P') - L]
      < epsilon / 2 + 0 + epsilon / 2 = epsilon.
    $
    This proves $lim_(lambda -> 0) overline(S)(P) = L$.
]

=== The Riemann-Stieltjes Integral // Riemann-Stieltjes积分

#definition(name: "Riemann-Stieltjes Integral")[
  Let $alpha$ be a bounded, monotonically increasing function on $[a, b]$.
  For every partition $P$ of $[a, b]$, let
  $Delta alpha_i = alpha(x_i) - alpha(x_(i-1))$ (clearly $Delta alpha_i >= 0$).
  For a bounded real function $f(x)$ on $[a, b]$, define the Stieltjes upper
  and lower sums
  $
    overline(S)(P, alpha) = sum_(i=1)^n M_i Delta alpha_i, quad
    underline(S)(P, alpha) = sum_(i=1)^n m_i Delta alpha_i,
  $
  and the upper and lower integrals
  $
    L = inf \{overline(S)(P, alpha) | overline(S)(P, alpha) in bold(overline(S))\},
    quad
    l = sup \{underline(S)(P, alpha) | underline(S)(P, alpha) in bold(underline(S))\},
  $
  where $bold(overline(S))$ and $bold(underline(S))$ are the sets of
  Stieltjes upper and lower sums, respectively. If $L = l$, then
  $ integral_a^b f(x) dif alpha(x) = L = l, $
  and $f(x)$ is said to be *Riemann-Stieltjes integrable* on $[a, b]$ with
  respect to $alpha$, or simply Stieltjes integrable.
] <def:riemann-stieltjes-integral>

When $alpha(x) = x$, this reduces to the Riemann integral. However, in
general $alpha(x)$ need not even be continuous. The properties of Darboux
sums carry over verbatim to Stieltjes sums.

== Integrability Criteria // 可积性判据

#theorem(name: "Integrability Criteria")[
  A bounded function $f(x)$ is Riemann integrable on $[a, b]$ if and only if
  one of the following equivalent conditions holds.

  1. *First criterion (equality of upper and lower integrals)*: with the
    notation of #link(<prop:darboux-sums>)[Darboux sums],
    $
      forall P (lambda = max_(1 <= i <= n) (Delta x_i) < delta):
      lim_(lambda -> 0) overline(S)(P) = L = l
      = lim_(lambda -> 0) underline(S)(P).
    $
  2. *Second criterion (vanishing of the oscillation sum)*: letting
    $omega_i = M_i - m_i$ denote the oscillation of $f(x)$ on
    $[x_(i-1), x_i]$, the sum of oscillations tends to zero:
    $
      lim_(lambda -> 0) sum_(i=1)^n omega_i Delta x_i = 0
      quad (lambda = max_(1 <= i <= n) (Delta x_i)).
    $
    - *Corollary 1*: continuous functions on closed intervals are
      integrable.
    - *Corollary 2*: monotonic functions on closed intervals are
      integrable.
  3. *Third criterion (small oscillation partition)*: for every
    $epsilon > 0$ there exists a partition $P$ such that
    $ sum_(i=1)^n omega_i Delta x_i < epsilon. $
    - *Corollary 1*: the total length of the sub-intervals on which the
      oscillation cannot be made arbitrarily small can be made arbitrarily
      small, i.e. for all $epsilon, eta > 0$ there exists $P$ such that
      $ sum_(omega_i >= eta) Delta x_i < epsilon. $
    - *Corollary 2*: bounded functions with only finitely many
      discontinuities on a closed interval are integrable.
] <thm:integrability-criteria>

#proof[
  *First criterion.* ($==>=$) By the definition of Darboux sums, for every
  partition $P$,
  $ underline(S)(P) <= sum_(i=1)^n f(xi_i) Delta x_i <= overline(S)(P). $
  If $lim_(lambda -> 0) overline(S)(P) = lim_(lambda -> 0) underline(S)(P) = I$,
  then taking the limit squeezes the Riemann sum to $I$, so $f$ is integrable
  with integral $I$. ($==>=$) Suppose $f$ is integrable with integral $I$.
  Given $epsilon > 0$, take $delta > 0$ as in the definition and fix a
  partition $P$ with $lambda < delta$. Since $M_i$ is the supremum of $f$ on
  $[x_(i-1), x_i]$, we may choose $xi_i$ with
  $0 <= M_i - f(xi_i) < epsilon / (2(b-a))$; then
  $|sum_(i=1)^n f(xi_i) Delta x_i - I| < epsilon / 2$. Moreover,
  $
    |overline(S)(P) - sum_(i=1)^n f(xi_i) Delta x_i|
    = sum_(i=1)^n [M_i - f(xi_i)] Delta x_i
    < epsilon / (2(b-a)) dot (b-a) = epsilon / 2.
  $
  Hence
  $|overline(S)(P) - I| <= |sum f(xi_i) Delta x_i - I| + |overline(S)(P) - sum f(xi_i) Delta x_i| < epsilon$,
  i.e. $lim_(lambda -> 0) overline(S)(P) = I$; the lower sum is treated
  identically.

  *Second criterion.* By the first criterion it suffices to observe that
  $
    sum_(i=1)^n omega_i Delta x_i
    = sum_(i=1)^n (M_i - m_i) Delta x_i
    = overline(S)(P) - underline(S)(P)
    -> limits L - l.
  $
  The limit vanishes exactly when $L = l$.

  *Corollary 1 (continuity).* A continuous function on $[a, b]$ is uniformly
  continuous (Cantor's theorem, #link(<thm:cantor-theorem>)[Cantor]). Given
  $epsilon > 0$, choose $delta > 0$ with $|f(x) - f(y)| < epsilon / (b-a)$
  whenever $|x - y| < delta$; for any partition with $lambda < delta$ we have
  $omega_i < epsilon / (b - a)$, whence
  $sum omega_i Delta x_i < epsilon$.

  *Corollary 2 (monotonicity).* Suppose $f$ is increasing (the other case is
  analogous); then $omega_i = f(x_i) - f(x_(i-1))$ and
  $
    sum_(i=1)^n omega_i Delta x_i <= lambda sum_(i=1)^n omega_i
    = lambda [f(b) - f(a)],
  $
  since every $Delta x_i <= lambda$. Taking
  $lambda < epsilon / (f(b) - f(a))$ makes the sum $< epsilon$. (If
  $f(b) = f(a)$ then $f$ is constant and the claim is trivial.)

  *Third criterion.* ($==>$) This is immediate from the second criterion.
  ($<==$) Suppose that for some partition
  $P': a = x'_0 < dots.c < x'_p = b$ we have
  $overline(S)(P') - underline(S)(P') < epsilon / 3$. Take
  $
    delta = min \{Delta x'_1, dots.c, Delta x'_p,
    epsilon / (3(p-1)(M-m))\}
  $
  (as in Darboux's theorem we may assume $M > m$). Let
  $P: a = x_0 < dots.c < x_n = b$ be any partition with $lambda < delta$, and
  let $P^*$ be the common refinement of $P$ and $P'$. Repeating the estimates
  from the proof of Darboux's theorem, the terms of
  $overline(S)(P) - overline(S)(P^*)$ and of
  $underline(S)(P^*) - underline(S)(P)$ coming from intervals containing an
  inserted point add up to less than $epsilon / 3$ each, while refinement
  never increases upper sums nor decreases lower sums, so
  $
    overline(S)(P^*) - overline(S)(P') <= 0, quad
    underline(S)(P') - underline(S)(P^*) <= 0.
  $
  Therefore
  $
    0 <= overline(S)(P) - underline(S)(P)
    = [overline(S)(P) - overline(S)(P^*)] + [overline(S)(P^*) - overline(S)(P')]
    + [overline(S)(P') - underline(S)(P')] + [underline(S)(P') - underline(S)(P^*)]
    + [underline(S)(P^*) - underline(S)(P)]
    < epsilon / 3 + 0 + epsilon / 3 + 0 + epsilon / 3 = epsilon.
  $
  Since $sum omega_i Delta x_i = overline(S)(P) - underline(S)(P)$, the second
  criterion yields integrability.

  *Corollary 1 (small total length of large oscillation).* Assume
  $m <= f <= M$ (the case $M = m$ being trivial). ($<==$) For
  $epsilon > 0$ set $epsilon' = epsilon / (2(M - m))$ and
  $eta = epsilon / (2(b - a))$. By hypothesis there is $P$ with
  $sum_(omega_i >= eta) Delta x_i < epsilon'$, and then
  $
    sum_(i=1)^n omega_i Delta x_i
    = sum_(omega_i >= eta) omega_i Delta x_i + sum_(omega_i < eta) omega_i Delta x_i
    <= (M - m) sum_(omega_i >= eta) Delta x_i + eta sum_(omega_i < eta) Delta x_i
    < (M - m) epsilon' + eta (b - a) < epsilon.
  $
  By the third criterion $f$ is integrable. ($==>$) By the third criterion,
  for all $epsilon, eta > 0$ there is $P$ with
  $sum omega_i Delta x_i < epsilon eta$. Then
  $
    eta sum_(omega_i >= eta) Delta x_i
    <= sum_(omega_i >= eta) omega_i Delta x_i
    <= sum_(i=1)^n omega_i Delta x_i < epsilon eta,
  $
  hence $sum_(omega_i >= eta) Delta x_i < epsilon$.

  *Corollary 2 (finitely many discontinuities).* Let
  $x_1 < dots.c < x_k$ be the discontinuity points of $f$ and let
  $omega = M - m$ be the oscillation of $f$ on $[a, b]$; if $omega = 0$ then
  $f$ is constant and integrable, so assume $omega > 0$. Given $epsilon > 0$,
  take the $x_j$ as division points of a partition and enclose each $x_j$ in
  an open interval, the total length of all these intervals being
  $< epsilon / (2 omega)$. Refine the partition so that every sub-interval
  meeting one of these neighborhoods lies inside it; the total length of the
  sub-intervals of this first class is then $< epsilon / (2 omega)$, and on
  them $omega_i <= omega$. On every remaining (closed) sub-interval $f$ is
  continuous, and there are finitely many of them, so $f$ is uniformly
  continuous on their union: after further refinement,
  $omega_i < epsilon / (2(b - a))$ there. Splitting the oscillation sum,
  $
    sum_(i=1)^n omega_i Delta x_i
    <= omega dot epsilon / (2 omega) + epsilon / (2(b-a)) dot (b - a)
    = epsilon,
  $
  and the third criterion gives integrability.
]

#note(title: "Techniques for Proving Integrability")[
  1. If $sum_(i=1)^n omega_i$ is bounded, use
    $sum_(i=1)^n omega_i Delta x_i <= (b - a) sum_(i=1)^n omega_i$ (as in
    the proof of integrability of monotone functions);
  2. Prove $omega_i < epsilon$ for every $i$, whence
    $sum omega_i Delta x_i < epsilon sum Delta x_i = epsilon (b - a)$;
  3. Split the oscillation sum
    $sum omega_i Delta x_i = sum' omega_i Delta x_i + sum'' omega_i Delta x_i$,
    where $omega_i < epsilon / (b - a)$ in the first sum, while the total
    length of the sub-intervals entering the second sum is
    $< epsilon / Omega$, with $Omega$ the oscillation of $f$ on the whole
    interval;
  4. If $omega_i^f <= omega_i^g$ on each sub-interval (the oscillations of
    $f$ and $g$), integrability of $g$ implies integrability of $f$ (e.g.
    of $|f|$ from that of $f$).
]

#example(name: "The Riemann Function is Integrable")[
  Prove that the Riemann function
  $ R(x) = cases(1/q &, x = p/q "in lowest terms" comma, 0 &, x "irrational" comma) $
  is Riemann integrable on $[0, 1]$.
] <ex:riemann-function-integrable>

#proof[
  Given $epsilon > 0$, the condition $R(x) = 1/q >= epsilon / 2$ forces
  $q <= 2 / epsilon$, so only finitely many points of $[0, 1]$ satisfy
  $R(x) > epsilon / 2$; call them $x_1, dots.c, x_k$. Take
  $delta = epsilon / (4k)$ and a partition $P$ with $lambda < delta$. Split
  the oscillation sum $sum omega_i Delta x_i = sum' omega_i Delta x_i + sum'' omega_i Delta x_i$,
  where $sum'$ runs over the sub-intervals containing one of the points
  $x_1, dots.c, x_k$ and $sum''$ over the rest. On the sub-intervals counted
  by $sum'$ we have $omega_i <= 1$, and there are at most $2k$ of them, so
  $sum' omega_i Delta x_i <= 2k lambda < epsilon / 2$. On the remaining
  sub-intervals every point satisfies $R(x) < epsilon / 2$, so
  $omega_i <= epsilon / 2$ and
  $sum'' omega_i Delta x_i <= (epsilon / 2) sum'' Delta x_i <= epsilon / 2$.
  Hence $sum omega_i Delta x_i < epsilon$, and the third criterion gives
  integrability.
]

#example(name: "Pointwise Vanishing Implies Zero Integral")[
  Suppose that at every point of $[a, b]$ the function $f$ has limit $0$.
  Prove that $f in R[a, b]$ and $integral_a^b f(x) dif x = 0$.
] <ex:pointwise-vanishing>

#proof[
  Fix $x_0 in [a, b]$. Since $lim_(x -> x_0) f(x) = 0$, for every
  $epsilon_1 > 0$ there is $delta_(x_0) > 0$ such that
  $|f(x)| < epsilon_1$ for all $x in accent(U, circle)(x_0, delta_(x_0))$.
  The open family $union_(x_0 in [a,b]) U(x_0, delta_(x_0))$ covers $[a, b]$,
  so by the Heine-Borel theorem it admits a finite subcover; consequently,
  outside a finite set $x_1, dots.c, x_r$ we have $|f(x)| < epsilon_1$
  throughout $[a, b]$.

  Now let $epsilon > 0$, take $epsilon_1 = epsilon / (4(b-a))$, and choose
  $M > max\{f(x_1), dots.c, f(x_r), epsilon_1\}$ so large that
  $|f(x)| <= M$ on all of $[a, b]$. Take a partition $P$ for which the total
  length of the sub-intervals containing some exceptional point
  $x_1, dots.c, x_r$ is $< epsilon / (4M)$ — possible since there are only
  finitely many of them — and split
  $sum omega_i Delta x_i = sum' omega_i Delta x_i + sum'' omega_i Delta x_i$
  accordingly. On the first class $omega_i <= 2M$, so
  $sum' omega_i Delta x_i <= 2M dot epsilon / (4M) = epsilon / 2$; on the
  second class $omega_i <= 2 epsilon_1$, so
  $sum'' omega_i Delta x_i <= 2 epsilon_1 (b - a) = epsilon / 2$. Hence
  $sum omega_i Delta x_i <= epsilon$ for arbitrarily small $epsilon$, which
  proves integrability.

  Finally, for any $epsilon > 0$ only finitely many points satisfy
  $|f(x)| >= epsilon$; choosing all intermediate points outside this finite
  set gives $|sum f(xi_i) Delta x_i| < epsilon (b - a)$, hence
  $lim_(lambda -> 0) sum_(i=1)^n f(xi_i) Delta x_i = 0$ and
  $integral_a^b f(x) dif x = 0$.
]

=== Lebesgue's Theorem // Lebesgue定理

#definition(name: "Null Set")[
  A set $E subset RR$ is called a *null set* (or a set of measure zero) if
  for any $epsilon > 0$ there exists a countable collection of open intervals
  $\{I_n | n in NN^*\}$ such that
  $ E subset union_(i=1)^oo I_n quad "and" quad sum_(i=1)^oo abs(I_n) < epsilon, $
  where $abs(I_n)$ denotes the length of $I_n$.
] <def:null-set>

If some property holds for all $x in A$ except for a null set $E subset A$,
we say that the property holds *almost everywhere* on $A$.

#proposition(name: "Properties of Null Sets")[
  1. Every at most countable set is a null set.
  2. A countable union of null sets is again a null set.
  3. Any subset of a null set is a null set.
] <prop:null-sets>

#lemma(name: "Oscillation Lemmas")[
  Let $f$ be bounded on $[a, b]$.
  1. With $omega$ the oscillation of $f$ on $[a, b]$,
    $ omega = sup \{f(y_1) - f(y_0) | y_0, y_1 in [a, b]\}. $
  2. $f(x)$ is continuous at a point $x_0$ if and only if the oscillation of
    $f$ at $x_0$ is zero, i.e. $omega_f (x_0) = 0$.
  3. Let $D(f)$ be the set of discontinuities of $f$ on $[a, b]$. For
    $delta > 0$, denote $D_delta = \{x in [a, b] | omega_f (x) >= delta\}$.
    Then
    $ D(f) = union_(n=1)^oo D_(1\/n). $
  4. If there exists a sequence of open intervals $(alpha_j, beta_j)$
    ($j = 1, 2, dots.c$) such that
    $D(f) subset union_(j=1)^oo (alpha_j, beta_j)$, and if
    $K = [a, b] \ union_(j=1)^oo (alpha_j, beta_j)$, then:
    $
      forall epsilon > 0, exists delta > 0, "s.t." forall x in K, y in [a, b]
      (|x - y| < delta): abs(f(x) - f(y)) < epsilon.
    $
] <lem:oscillation-lemmas>

Recall that for $x in [a, b]$ we write $omega_f (x, delta)$ for the
oscillation of $f$ on $U(x, delta) inter [a, b]$ and
$omega_f (x) = inf_(delta > 0) omega_f (x, delta)$ for the oscillation of $f$
at $x$; statement 2 above says that continuity at $x$ is equivalent to
$omega_f (x) = 0$.

#proof[
  *Lemma 1.* Let $M, m$ be the supremum and infimum of $f$ on $[a, b]$, so
  $omega = M - m$ by definition. For any $y_1, y_2 in [a, b]$ we have
  $m <= f(y_i) <= M$, hence
  $|f(y_1) - f(y_2)| <= M - m = omega$. Conversely, for any $epsilon > 0$
  there exist $y_1, y_2$ with $f(y_1) > M - epsilon / 2$ and
  $f(y_2) < m + epsilon / 2$, so
  $|f(y_1) - f(y_2)| >= f(y_1) - f(y_2) > M - m - epsilon = omega - epsilon$.
  Combining both estimates gives the claimed identity.

  *Lemma 2.* ($==>$) If $f$ is continuous at $x$, then for every
  $epsilon > 0$ there is $delta > 0$ with $|f(y) - f(x)| < epsilon / 2$ for
  all $y in U(x, delta)$; hence for $y_1, y_2 in U(x, delta)$,
  $ |f(y_1) - f(y_2)| <= |f(y_1) - f(x)| + |f(x) - f(y_2)| < epsilon, $
  so $omega_f (x, delta) <= epsilon$. Letting $delta -> 0^+$ gives
  $0 <= omega_f (x) <= epsilon$, and since $epsilon$ is arbitrary,
  $omega_f (x) = 0$. ($<==$) If $omega_f (x) = 0$, then for every
  $epsilon > 0$ there is $delta > 0$ with $omega_f (x, delta) < epsilon$;
  hence $|f(x) - f(y)| <= omega_f (x, delta) < epsilon$ for all
  $y in U(x, delta)$, which is continuity at $x$.

  *Lemma 3.* By Lemma 2 every point of $D_(1\/n)$ is a discontinuity point,
  so $union_(n=1)^oo D_(1\/n) subset D(f)$. Conversely, take $x in D(f)$;
  then $omega_f (x) > 0$, and choosing $m$ large enough that
  $omega_f (x) >= 1\/m$ gives $x in D_(1\/m)$. Hence
  $D(f) subset union_(n=1)^oo D_(1\/n)$.

  *Lemma 4.* Suppose the claim fails. Then there exist $epsilon_0 > 0$, a
  sequence $delta_n = 1\/n$, and points $s_n in K$, $t_n in [a, b]$ with
  $|s_n - t_n| < 1\/n$ but $|f(s_n) - f(t_n)| >= epsilon_0$. Since
  $\{s_n\} subset K subset [a, b]$, the Bolzano-Weierstrass theorem yields a
  subsequence $\{s_(k_n)\}$ converging to some $s^*$. Clearly $s^* in K$ (as
  $K$ is closed) and
  $
    |t_(k_n) - s^*| <= |t_(k_n) - s_(k_n)| + |s_(k_n) - s^*|
    < 1\/k_n + |s_(k_n) - s^*| -> 0,
  $
  so $t_(k_n) -> s^*$ as well. But $s^* in K$ is a continuity point of $f$,
  so letting $n -> oo$ in $|f(s_(k_n)) - f(t_(k_n))| >= epsilon_0$ gives
  $0 = |f(s^*) - f(s^*)| >= epsilon_0$, a contradiction.
]

#theorem(name: "Lebesgue's Theorem")[
  Let $f in B[a, b]$. Then $f$ is Riemann integrable on $[a, b]$ if and only
  if $f$ is continuous almost everywhere on $[a, b]$.
] <thm:lebesgue>

#proof[
  ($==>$) It suffices to show that $D_delta$ is a null set for every
  $delta > 0$; then each $D_(1\/n)$ is null and, by Lemma 3 and the
  countability of null unions, so is $D(f)$. Fix $delta > 0$. By
  integrability, for every $epsilon > 0$ there is a partition
  $P: a = x_0 < x_1 < dots.c < x_m = b$ with
  $sum_(i=1)^m omega_i Delta x_i < delta epsilon / 2$. If
  $x in D_delta$ is not one of the division points, then
  $x in (x_(i-1), x_i)$ for some $i$, and there is $r > 0$ with
  $(x - r, x + r) subset (x_(i-1), x_i)$; hence the oscillation of $f$ on
  $[x_(i-1), x_i]$ satisfies $omega_i >= omega_f (x) >= delta$. Writing
  $sum'$ for the sub-sum over the $i$ with $D_delta inter (x_(i-1), x_i) != emptyset$,
  we get
  $
    delta epsilon / 2 > sum_(i=1)^m omega_i Delta x_i >= sum' omega_i Delta x_i
    >= delta sum' Delta x_i, quad "whence" quad sum' Delta x_i < epsilon / 2.
  $
  Consequently
  $ D_delta subset (union' (x_(i-1), x_i)) union \{x_0, x_1, dots.c, x_m\}, $
  and covering each division point $x_j$ by an interval of length
  $epsilon / (2(m+1))$ gives a countable cover of $D_delta$ with total length
  $
    sum' Delta x_i + (m+1) epsilon / (2(m+1)) < epsilon / 2 + epsilon / 2
    = epsilon.
  $
  Hence $D_delta$ is a null set.

  ($<==$) Suppose $D(f)$ is a null set, and let $omega$ be the oscillation
  of $f$ on $[a, b]$ (the case $omega = 0$ is trivial). For every
  $epsilon > 0$ there is a family of open intervals
  $\{(alpha_i, beta_i) | i = 1, 2, dots.c\}$ covering $D(f)$ with
  $ sum_(i=1)^oo (beta_i - alpha_i) < epsilon / (2 omega). $
  Set $K = [a, b] \ union_(i=1)^oo (alpha_i, beta_i)$. By Lemma 4
  there is $delta > 0$ such that $|x - y| < delta$ with $x in K$ and
  $y in [a, b]$ implies $|f(x) - f(y)| < epsilon / (4(b - a))$. Take a
  partition $P: a = x_0 < x_1 < dots.c < x_n = b$ with
  $lambda = max_(1 <= i <= n) (Delta x_i) < delta$, and split
  $sum omega_i Delta x_i = sum_1 omega_i Delta x_i + sum_2 omega_i Delta x_i$,
  where $sum_1$ runs over the $i$ with $K inter (x_(i-1), x_i) != emptyset$ and
  $sum_2$ over the rest.
  + For $sum_1$: pick $y_i in K inter (x_(i-1), x_i)$; then for
    $z_1, z_2 in [x_(i-1), x_i]$,
    $
      |f(z_1) - f(z_2)| <= |f(z_1) - f(y_i)| + |f(z_2) - f(y_i)|
      < 2 dot epsilon / (4(b-a)) = epsilon / (2(b-a)),
    $
    so $omega_i <= epsilon / (2(b-a))$ and
    $sum_1 omega_i Delta x_i < epsilon / (2(b-a)) (b-a) = epsilon / 2$.
  + For $sum_2$: since $omega_i <= omega$, we have
    $sum_2 omega_i Delta x_i <= omega sum_2 Delta x_i$. If
    $x in (x_(i-1), x_i)$ meets no point of $K$, then the whole interval lies
    in $union (alpha_i, beta_i)$, so
    $sum_2 Delta x_i <= sum_(i=1)^oo (beta_i - alpha_i) < epsilon / (2 omega)$,
    and hence $sum_2 omega_i Delta x_i <= epsilon / 2$.
  Combining both estimates, $sum_(i=1)^n omega_i Delta x_i < epsilon$ for
  arbitrarily small $epsilon$, so $f$ is integrable by the third criterion.
]

== Properties of Definite Integrals // 定积分的性质

#proposition(name: "Properties of Riemann Integrals")[
  1. *Linearity*: if $f, g in R[a, b]$ and $k_1, k_2$ are constants, then
    $k_1 f + k_2 g in R[a, b]$ and
    $
      integral_a^b [k_1 f(x) + k_2 g(x)] dif x
      = k_1 integral_a^b f(x) dif x + k_2 integral_a^b g(x) dif x.
    $
  2. *Integrability of products*: if $f, g in R[a, b]$, then $f g in R[a, b]$.
    In general, however,
    $
      integral_a^b f(x) g(x) dif x
      != (integral_a^b f(x) dif x)(integral_a^b g(x) dif x).
    $
  3. *Monotonicity*: if $f, g in R[a, b]$ and $f(x) >= g(x)$ (respectively
    $f(x) > g(x)$) on $[a, b]$, then
    $
      integral_a^b f(x) dif x >= integral_a^b g(x) dif x
      quad (integral_a^b f(x) dif x > integral_a^b g(x) dif x).
    $
    - *Corollary 1*: if $f in C[a, b]$ with $f >= 0$ and $f$ not identically
      zero, then $integral_a^b f(x) dif x > 0$;
    - *Corollary 2*: if $f in R[a, b]$ with $f > 0$, then
      $integral_a^b f(x) dif x > 0$.
  4. *Integrability of the absolute value*: if $f in R[a, b]$, then
    $|f| in R[a, b]$ and
    $ abs(integral_a^b f(x) dif x) <= integral_a^b abs(f(x)) dif x; $
    the converse of this property is false.
  5. *Additivity over intervals*: if $f in R[a, b]$, then for every
    $c in [a, b]$, $f$ is integrable on $[a, c]$ and on $[c, b]$;
    conversely, if $f in R[a, c]$ and $f in R[c, b]$, then $f in R[a, b]$
    and
    $
      integral_a^b f(x) dif x = integral_a^c f(x) dif x
      + integral_c^b f(x) dif x.
    $
] <prop:riemann-integral-properties>

#proof[
  *Linearity.* For every partition and every choice of intermediate points,
  $
    sum_(i=1)^n [k_1 f(xi_i) + k_2 g(xi_i)] Delta x_i
    = k_1 sum_(i=1)^n f(xi_i) Delta x_i + k_2 sum_(i=1)^n g(xi_i) Delta x_i.
  $
  Letting $lambda -> 0$ and using the integrability of $f$ and $g$ yields
  the claim.

  *Integrability of products.* Since $f, g in R[a, b]$, both are bounded:
  $abs(f), |g| <= M$ on $[a, b]$. For any two points $hat(x), tilde(x)$ of
  $[x_(i-1), x_i]$,
  $
    |f(hat(x)) g(hat(x)) - f(tilde(x)) g(tilde(x))|
    <= |f(hat(x)) - f(tilde(x))| dot |g(hat(x))|
    + |f(tilde(x))| dot |g(hat(x)) - g(tilde(x))|
    <= M [|f(hat(x)) - f(tilde(x))| + |g(hat(x)) - g(tilde(x))|].
  $
  If $omega_i$ is the oscillation of $f g$ on $[x_(i-1), x_i]$ and
  $omega'_i, omega''_i$ those of $f$ and $g$, this reads
  $omega_i <= M(omega'_i + omega''_i)$, whence
  $
    0 <= sum_(i=1)^n omega_i Delta x_i
    <= M (sum_(i=1)^n omega'_i Delta x_i + sum_(i=1)^n omega''_i Delta x_i)
    -> 0 quad "as" quad lambda -> 0
  $
  by the second criterion.

  *Monotonicity ($>=$).* It suffices to show $integral_a^b f >= 0$ for
  $f >= 0$: every Riemann sum of a non-negative function is non-negative,
  and the inequality survives the limit.

  *Monotonicity ($>$).* By the preceding part $integral_a^b f >= 0$; it
  remains to exclude $integral_a^b f = 0$. Suppose it vanished. Then the
  Darboux upper sums satisfy $lim_(lambda -> 0) sum_(i=1)^n M_i Delta x_i = 0$,
  i.e. for every $epsilon > 0$ there is $delta > 0$ with
  $sum_(i=1)^n M_i Delta x_i < (b - a) epsilon$ for every partition with
  $lambda < delta$; hence at least one sub-interval $[x_(i-1), x_i]$ carries
  $0 <= M_i < epsilon$, and by additivity $integral_c^d f = 0$ for every
  $[c, d] subset [x_(i-1), x_i]$. Inductively we construct closed intervals
  $[a_1, b_1] supset [a_2, b_2] supset dots.c$ with $b_n - a_n < 1\/n$ and
  $0 <= f <= 1\/n$ on $[a_n, b_n]$: at the $n$-th step apply the argument
  above to $[a_(n-1), b_(n-1)]$ with $epsilon_n = 1\/n$ and $delta < 1\/n$.
  The nested interval theorem yields a unique $xi$ in all of them, and
  $0 <= f(xi) <= 1\/n$ for every $n$ forces $f(xi) = 0$, contradicting
  $f > 0$.

  *Corollary 1.* Take $x_0$ with $f(x_0) > 0$. By continuity there is
  $[alpha, beta]$ with $x_0 in [alpha, beta] subset [a, b]$ on which
  $f(x) >= f(x_0) / 2$. By additivity and monotonicity,
  $
    integral_a^b f(x) dif x >= integral_alpha^beta f(x) dif x
    >= integral_alpha^beta f(x_0)/2 dif x = f(x_0)/2 (beta - alpha) > 0.
  $

  *Corollary 2.* Every Riemann sum is positive, so $integral_a^b f >= 0$.
  Suppose $integral_a^b f = 0$; then $lim_(lambda -> 0) sum_(i=1)^n M_i Delta x_i = 0$
  for the Darboux upper sums, so for every $epsilon_1 > 0$ there is a
  partition with $sum_(i=1)^n M_i Delta x_i < epsilon_1 (b - a)$, which
  forces $M_i < epsilon_1$ for at least one sub-interval $[a_1, b_1]$ —
  otherwise every term would satisfy $M_i Delta x_i >= epsilon_1 Delta x_i$
  and the sum would be $>= epsilon_1 (b - a)$. Repeating the argument inside
  $[a_1, b_1]$ produces nested intervals $[a_n, b_n]$ with
  $sup_(a_n <= x <= b_n) f <= epsilon_n$ and $epsilon_n -> 0$; by the nested
  interval theorem some $xi$ belongs to all of them, and
  $0 <= f(xi) <= epsilon_n$ for all $n$ gives $f(xi) = 0$, contradicting
  $f > 0$.

  *Integrability of $|f|$.* For any two points,
  $||f(hat(x))| - |f(tilde(x))|| <= |f(hat(x)) - f(tilde(x))|$, so the
  argument of the product case gives $|f| in R[a, b]$. Since
  $-|f| <= f <= |f|$, monotonicity yields
  $-integral_a^b |f| <= integral_a^b f <= integral_a^b |f|$, i.e.
  $abs(integral_a^b f) <= integral_a^b |f|$.

  *Additivity over intervals.* Let $f in R[a, b]$ and $c in [a, b]$. By the
  third criterion there is a partition of $[a, b]$ with
  $sum omega_i Delta x_i < epsilon$; inserting $c$ as an additional division
  point (upper sums do not increase, lower sums do not decrease) we may
  assume $c$ is one of them. Splitting the oscillation sum over $[a, c]$ and
  over $[c, b]$ shows that each part is $< epsilon$, so $f$ is integrable on
  both. The converse is proved by taking the common refinement of partitions
  of $[a, c]$ and $[c, b]$. When all three integrals exist, the additivity
  of Riemann sums passes to the limit and gives the identity.
]

#example(name: "A Positive Integral Forces a Positive Lower Bound")[
  Let $f in R[a, b]$ with $I = integral_a^b f(x) dif x > 0$. Prove that
  there exist $[c, d] subset [a, b]$ and $mu > 0$ such that
  $f(x) >= mu$ on $[c, d]$.
] <ex:positive-integral-subinterval>

#proof[
  By the order-preserving property of limits, there is a partition
  $P: a = x_0 < x_1 < dots.c < x_n = b$ such that for every choice of
  intermediate points $sum_(i=1)^n f(xi_i) Delta x_i > I / 2 > 0$. For this
  fixed partition, taking the infimum over all choices of the $xi_i$ on each
  sub-interval gives
  $sum_(i=1)^n m_i Delta x_i >= I / 2 > 0$, where $m_i$ is the infimum of
  $f$ on $[x_(i-1), x_i]$. Hence at least one term satisfies
  $m_k Delta x_k > 0$, i.e. $m_k > 0$. Taking $mu = m_k$ and
  $[c, d] = [x_(k-1), x_k]$ completes the proof.
]

#theorem(name: "Integral Mean Value Theorems")[
  *First integral mean value theorem.* Let $f, g in R[a, b]$ with $g(x)$ of
  constant sign on $[a, b]$. Then there exists $eta in [m, M]$ such that
  $ integral_a^b f(x) g(x) dif x = eta integral_a^b g(x) dif x, $
  where $m, M$ denote the infimum and supremum of $f$ on $[a, b]$,
  respectively. In particular, if $f in C[a, b]$, then there exists
  $xi in [a, b]$ with
  $ integral_a^b f(x) g(x) dif x = f(xi) integral_a^b g(x) dif x. $
  - *Corollary*: if $f in C[a, b]$, then $xi$ may be chosen in $(a, b)$.

  *Second integral mean value theorem (Bonnet's formula).* Let
  $f in R[a, b]$.
  - If $g$ is decreasing and $g >= 0$ on $[a, b]$, then there exists
    $xi in [a, b]$ with
    $ integral_a^b f(x) g(x) dif x = g(a) integral_a^xi f(x) dif x. $
  - If $g$ is increasing and $g >= 0$ on $[a, b]$, then there exists
    $eta in [a, b]$ with
    $ integral_a^b f(x) g(x) dif x = g(b) integral_eta^b f(x) dif x. $

  In general, if $g$ is monotonic on $[a, b]$, then there exists
  $xi in [a, b]$ with
  $
    integral_a^b f(x) g(x) dif x
    = g(a) integral_a^xi f(x) dif x + g(b) integral_xi^b f(x) dif x.
  $
] <thm:integral-mean-value>

#proof[
  *First mean value theorem.* Since $g$ does not change sign, suppose
  $g >= 0$ (the other case is analogous). Then
  $m g(x) <= f(x) g(x) <= M g(x)$, and monotonicity gives
  $
    m integral_a^b g(x) dif x <= integral_a^b f(x) g(x) dif x
    <= M integral_a^b g(x) dif x.
  $
  If $integral_a^b g > 0$, take $eta = integral_a^b f g / integral_a^b g in
  [m, M]$; if $integral_a^b g = 0$ the inequality forces
  $integral_a^b f g = 0$ as well and any $eta in [m, M]$ will do. When
  $f in C[a, b]$, the intermediate value theorem provides $xi in [a, b]$
  with $f(xi) = eta$.

  *Corollary ($xi in (a, b)$).* Three situations are trivial:
  + $integral_a^b g = 0$: then $integral_a^b f g = f(xi) integral_a^b g = 0$
    for every $xi$, so any point of $(a, b)$ works;
  + $M = m$: then $f$ is constant and again any $xi$ works;
  + $eta in (m, M)$: the intermediate value theorem directly gives
    $xi in (a, b)$ with $f(xi) = eta$.
  Otherwise assume $g >= 0$, so that $integral_a^b g > 0$, and suppose
  $eta = m$ (the case $eta = M$ is analogous). By
  #link(<ex:positive-integral-subinterval>)[the auxiliary example] applied
  to $g$, there exist $[c, d] subset [a, b]$ and $mu > 0$ with
  $g >= mu$ on $[c, d]$. Both $f - m$ and $g$ are non-negative, and
  $eta = m$ means $integral_a^b (f - m) g = 0$; hence
  $
    0 = integral_a^b (f(x) - m) g(x) dif x
    >= integral_c^d (f(x) - m) g(x) dif x
    >= mu integral_c^d (f(x) - m) dif x >= 0.
  $
  Therefore $integral_c^d (f - m) dif x = 0$ with $f - m in C[c, d]$,
  $f - m >= 0$, so $f equiv m$ on $[c, d]$ (Corollary 1 of monotonicity).
  Any point of $(c, d) subset (a, b)$ is then a valid choice of $xi$.

  *Second mean value theorem (decreasing case).* Let
  $P: a = x_0 < x_1 < dots.c < x_n = b$ be a partition and write
  $
    integral_a^b f(x) g(x) dif x
    = sum_(i=0)^(n-1) integral_(x_i)^(x_(i+1)) f(x) g(x) dif x
    = sum_(i=0)^(n-1) integral_(x_i)^(x_(i+1)) f(x) [g(x) - g(x_i)] dif x
    + sum_(i=0)^(n-1) integral_(x_i)^(x_(i+1)) f(x) g(x_i) dif x
    = I_1 + I_2.
  $
  Since $f in R[a, b]$, it is bounded: $|f| <= L$. Since $g$ is decreasing
  and $g >= 0$, we have $0 <= g(x_i) - g(x_(i+1))$ for every $i$ and
  $sum_(i=0)^(n-1) omega_i^g = g(a) - g(b) =: R$ where $omega_i^g$ denotes
  the oscillation of $g$ on $[x_i, x_(i+1)]$. With
  $lambda = max_i Delta x_i$,
  $
    |I_1| <= sum_(i=0)^(n-1) integral_(x_i)^(x_(i+1)) |f(x)| |g(x) - g(x_i)| dif x
    <= L sum_(i=0)^(n-1) omega_i^g Delta x_i <= L R lambda -> 0.
  $
  Now set $F(x) = integral_a^x f(t) dif t$, so that
  $integral_(x_i)^(x_(i+1)) f dif x = F(x_(i+1)) - F(x_i)$ and
  $F(x_0) = F(a) = 0$. An Abel transform (summation by parts) gives
  $
    I_2 = sum_(i=0)^(n-1) g(x_i) [F(x_(i+1)) - F(x_i)]
    = sum_(i=1)^(n-1) F(x_i) [g(x_(i-1)) - g(x_i)] + F(x_n) g(x_(n-1)).
  $
  Since $g$ is decreasing, $g(x_(i-1)) - g(x_i) >= 0$, and since
  $g >= 0$ we may bound the last term by $F(x_n) g(x_(n-1)) <= M g(x_(n-1))$
  where $m, M$ are bounds for $F$ on $[a, b]$ (which exists and is
  continuous, hence bounded). Summing the inequalities
  $m [g(x_(i-1)) - g(x_i)] <= F(x_i) [g(x_(i-1)) - g(x_i)] <= M [g(x_(i-1)) - g(x_i)]$
  over $i = 1, dots.c, n-1$ and appending the last term,
  $ m g(a) <= I_2 <= M g(a), quad "i.e." quad m <= I_2 / g(a) <= M $
  (if $g(a) = 0$ then $g equiv 0$ and the claim is trivial). Letting
  $lambda -> 0$ in $I = I_1 + I_2$ with $|I_1| -> 0$ yields
  $m g(a) <= I <= M g(a)$, and by the intermediate value theorem applied to
  the continuous function $F$, there exists $xi in [a, b]$ with
  $F(xi) = integral_a^xi f dif x = I / g(a)$. Multiplying by $g(a)$ gives
  $I = g(a) integral_a^xi f(x) dif x$.

  The increasing case is symmetric, and the general form follows by applying
  the decreasing case to $tilde(g)(x) = g(x) - g(b) >= 0$ (when $g$ is
  decreasing) or $tilde(g)(x) = g(x) - g(a) >= 0$ (when $g$ is increasing)
  and expanding.
]

#note[
  Concerning the first integral mean value theorem:
  - If $f in C[a, b]$ is replaced by $f in R[a, b]$, the conclusion with a
    value $f(xi)$ fails;
  - If $f in R[a, b]$ and $integral f(x) dif x$ exists (i.e. $f$ has an
    antiderivative), the conclusion holds.
]

=== Integrability of Composite Functions // 复合函数的可积性

#proposition(name: "Integrability of Composite Functions")[
  - *Outer continuous, inner integrable*: if $f in R[a, b]$ with
    $A <= f(x) <= B$ and $g in C[A, B]$, then the composite
    $g(f(x)) in R[a, b]$.
  - *Outer integrable, inner continuous*: the composite need not be
    integrable.
  - *Both inner and outer integrable*: the composite need not be integrable;
    in fact, even when both inner and outer functions are non-integrable,
    the composite may still be integrable.
] <prop:composite-integrability>

#proof[
  We prove the first statement. Since $g in C[A, B]$, it is bounded, say
  $|g| <= M$, and uniformly continuous: for every $epsilon > 0$ there is
  $delta > 0$ with
  $|g(u') - g(u'')| < epsilon / (2(b-a))$ whenever $u', u'' in [A, B]$,
  $|u' - u''| < delta$. Since $f in R[a, b]$, the third criterion (in the
  form of its Corollary 1) provides a partition $P$ with
  $sum_(omega_i (f) >= delta) Delta x_i < epsilon / (4M)$. Splitting the
  oscillation sum of $g dot f$,
  $
    sum_(i=1)^n omega_i (g dot f) Delta x_i
    = sum_(omega_i (f) < delta) omega_i (g dot f) Delta x_i
    + sum_(omega_i (f) >= delta) omega_i (g dot f) Delta x_i.
  $
  On sub-intervals with $omega_i (f) < delta$ the oscillation of $f$ is
  below $delta$, so $omega_i (g dot f) < epsilon / (2(b-a))$; on the
  remaining ones $omega_i (g dot f) <= 2M$. Therefore
  $
    sum_(i=1)^n omega_i (g dot f) Delta x_i
    < epsilon/(2(b-a)) (b-a) + 2M dot epsilon/(4M) = epsilon,
  $
  and the third criterion gives $g dot f in R[a, b]$.

  Alternatively, by Lebesgue's theorem: since $g$ is continuous, every
  discontinuity of $g dot f$ is a discontinuity of $f$, so
  $D(g dot f) subset D(f)$; the latter is a null set by integrability of
  $f$, hence so is the former, and $g dot f$ is integrable.
]

#note(title: "Counterexamples to the Remaining Cases")[
  - *Outer integrable, inner continuous*: let $A subset [0, 1]$ be a Cantor
    set of positive measure with adjacent intervals $(a_i, b_i)$. Define
    $
      f(x) = cases(0 &, 0 <= x < 1 comma, 1 &, x = 1 comma) quad quad
      g(x) = cases(
        1 &, x in A comma,
        1 - 1/2 (b_i - a_i) + abs(x - 1/2 (a_i + b_i)) &, x in (a_i, b_i) comma
      )
    $
    extending $g$ by continuity onto $A$ (it satisfies a Lipschitz
    condition). Then $f in R[0, 1]$ and $g in C[0, 1]$, yet
    $f(g(x)) = cases(1 &, x in A comma, 0 &, "otherwise" comma)$ is
    discontinuous at every point of $A$, and since $m(A) > 0$ the composite
    is not integrable.
  - *Both integrable, composite not*: on $[0, 1]$ take the Riemann function
    $f$ and $g(y) = cases(1 &, 0 < y <= 1 comma, 0 &, y = 0 comma)$; both
    are integrable, but $g(f(x))$ equals the Dirichlet function, which is
    not integrable.
  - *Both non-integrable, composite integrable*: for two Dirichlet
    functions $f, g$, the composite $g(f(x)) equiv 0$ is integrable.
]

#example(name: "Continuity of the Integral under Translations")[
  Let $f in R[a - h_0, b + h_0]$ for some $h_0 > 0$. Prove that
  $ lim_(h -> 0) integral_a^b abs(f(x + h) - f(x)) dif x = 0. $
] <ex:translation-continuity>

#proof[
  Since $f$ is integrable on a larger interval, it is bounded there: say
  $|f| <= M$ on $[a - h_0, b + h_0]$. Given $epsilon > 0$, split $[a, b]$
  into $n$ equal sub-intervals of length $Delta x = (b-a)/n$ with $n$ so
  large that $Delta x < min(h_0, epsilon / (8M))$ and
  $sum_(i=1)^n omega_i Delta x < epsilon / 6$, which is possible by the
  second criterion. Denote by $omega_0$ and $omega_(n+1)$ the oscillations
  of $f$ on $[a - Delta x, a]$ and $[b, b + Delta x]$; both are at most
  $2M$. Since
  $
    integral_a^b abs(f(x+h) - f(x)) dif x
    = sum_(i=1)^n integral_(x_(i-1))^(x_i) abs(f(x+h) - f(x)) dif x,
  $
  and for $x in [x_(i-1), x_i]$ with $|h| < Delta x$ the point $x + h$ lies
  in $[x_(i-2), x_(i+1)]$, we have
  $abs(f(x+h) - f(x)) <= omega_(i-1) + omega_i + omega_(i+1)$, where
  $x_(-1) = a - Delta x$ and $x_(n+1) = b + Delta x$. Hence
  $
    integral_a^b abs(f(x+h) - f(x)) dif x
    <= sum_(i=1)^n [integral_(x_(i-1))^(x_i) abs(f(x+h) - f(x_(i))) dif x
      + integral_(x_(i-1))^(x_i) abs(f(x_i) - f(x)) dif x]
    <= Delta x sum_(i=1)^n (omega_(i-1) + omega_i + omega_(i+1))
    + Delta x sum_(i=1)^n omega_i
    <= 4 sum_(i=1)^n omega_i Delta x + (omega_0 + omega_(n+1)) Delta x
    < 4 dot epsilon/6 + 4M dot epsilon/(8M) < epsilon.
  $
  This proves the claim.
]

== Fundamental Theorem of Calculus // 微积分基本定理

=== Newton-Leibniz Formula // Newton-Leibniz公式

Having established the integrability theory, we now turn to the bridge
between differential and integral calculus.

#definition(name: "Variable Limit Integrals")[
  Let $f(x) in R[a, b]$. Define
  $
    F(x) = integral_a^x f(t) dif t quad quad "and" quad quad
    F(x) = integral_x^b f(t) dif t,
  $
  which are referred to as the *variable upper limit integral* and the
  *variable lower limit integral*, respectively.
] <def:variable-limit-integrals>

#proposition(name: "Properties of Variable Limit Integrals")[
  1. *Continuity of the primitive*: $F in C[a, b]$. In fact the variable
    upper limit integral satisfies a Lipschitz condition on $[a, b]$ and is
    therefore uniformly continuous on the closed interval.
  2. (*Fundamental theorem of calculus*) Let $x_0 in [a, b]$ be a point at
    which $f(x)$ is continuous. Then
    $ F'(x_0) = f(x_0). $
  3. (*Existence of primitives*) If $f in C[a, b]$, then $F in D[a, b]$ and
    $F'(x) = f(x)$.
  4. *Rule of derivation*: if
    $F(x) = integral_(u(x))^(v(x)) f(t) dif t$ with $u, v$ differentiable,
    then
    $ F'(x) = f(v(x)) v'(x) - f(u(x)) u'(x). $
    In fact, this formula is the simplified version of *Leibniz's rule*.
] <prop:variable-limit-integrals>

#proof[
  1. By additivity over intervals, for $x, x + Delta x in [a, b]$,
    $
      F(x + Delta x) - F(x) = integral_x^(x + Delta x) f(t) dif t,
    $
    so, with $M, m$ the supremum and infimum of $f$ on $[a, b]$,
    $abs(F(x + Delta x) - F(x)) <= max(abs(m), M) abs(Delta x)$: the
    variable upper limit integral satisfies a Lipschitz condition, hence is
    continuous (in fact uniformly continuous) on $[a, b]$.
  2. By statement 1, $F(x_0 + h) - F(x_0) = integral_(x_0)^(x_0 + h) f(t) dif t$,
    so for $h != 0$,
    $
      (F(x_0 + h) - F(x_0)) / h - f(x_0)
      = 1/h integral_(x_0)^(x_0 + h) [f(t) - f(x_0)] dif t.
    $
    Since $f$ is continuous at $x_0$, for every $epsilon > 0$ there exists
    $delta > 0$ such that $|f(t) - f(x_0)| < epsilon$ whenever
    $|t - x_0| < delta$. For $0 < abs(h) < delta$ every $t$ between $x_0$
    and $x_0 + h$ satisfies $|t - x_0| <= abs(h) < delta$, hence
    $
      abs((F(x_0 + h) - F(x_0)) / h - f(x_0))
      <= 1/(abs(h)) integral_(x_0)^(x_0 + h) abs(f(t) - f(x_0)) dif t
      <= 1/(abs(h)) dot epsilon abs(h) = epsilon,
    $
    i.e. $F'(x_0) = lim_(h -> 0) (F(x_0 + h) - F(x_0)) / h = f(x_0)$.
  3. Immediate from statement 2: a function continuous on $[a, b]$ is
    continuous at every point, so $F' = f$ holds at every point of
    $[a, b]$.
  4. Fix $c in [a, b]$ and write
    $ F(x) = integral_c^(v(x)) f(t) dif t - integral_c^(u(x)) f(t) dif t. $
    At every point $x$ where $f$ is continuous at $u(x)$ and $v(x)$, the
    chain rule together with statement 2 makes the derivative of the first
    term equal to $f(v(x)) v'(x)$ and that of the second equal to
    $f(u(x)) u'(x)$; subtracting yields the rule. In particular the rule
    holds throughout when $f in C[a, b]$.
]

#note[
  Differentiation lowers the smoothness of a function (a primitive is
  differentiable, yet its derivative may have discontinuities of the second
  kind), whereas integration improves smoothness.
]

#note(title: "The Riemann Function has no Primitive")[
  The variable upper limit integral of the Riemann function is identically
  zero, hence is not a primitive of it. Indeed, every discontinuity of the
  Riemann function is removable, while a function possessing a primitive has
  the intermediate value property (Darboux property), and a function with
  the Darboux property cannot have removable or jump discontinuities.
  Therefore the Riemann function has no primitive.
]

#note[
  If an integrable function possesses a primitive, then every primitive
  differs from the variable upper limit integral only by a constant: the
  difference of the two is continuous by statement 1 and has zero
  derivative at every continuity point of $f$, and the continuity points
  form a dense set.
]

#example(name: "Integrable and Discontinuous, yet with a Primitive")[
  On $[-1, 1]$ let
  $
    f(x) = cases(sin(1/x) &, x != 0 comma, 0 &, x = 0 comma) quad quad
    g(x) = cases(x^2 cos(1/x) &, x != 0 comma, 0 &, x = 0 comma) quad quad
    phi(x) = cases(2x cos(1/x) &, x != 0 comma, 0 &, x = 0 comma).
  $
  Although $f$ has a discontinuity at $x = 0$, it possesses the primitive
  $ F(x) = g(x) - integral_0^x phi(t) dif t. $
] <ex:antiderivative-of-discontinuous>

#proof[
  For $x != 0$ we have $g'(x) = 2x cos(1/x) + sin(1/x) = phi(x) + f(x)$,
  hence $F'(x) = g'(x) - phi(x) = f(x)$. At the origin, $F(0) = 0$ and, as
  $h -> 0$,
  $
    abs(g(h) / h) = abs(h cos(1/h)) -> 0, quad
    abs(1/h integral_0^h phi(t) dif t)
    <= 1/(abs(h)) integral_0^(abs(h)) 2t dif t = abs(h) -> 0,
  $
  so $F'(0) = lim_(h -> 0) F(h) / h = 0 = f(0)$. Thus $F' = f$ on all of
  $[-1, 1]$ even though $f$ is discontinuous (of oscillation type) at the
  origin; $f$ is nevertheless integrable there, having only one
  discontinuity.
]

#example(name: "A Derivative that is Not Integrable")[
  Let
  $
    f(x) = cases(x^2 sin(1/x^2) &, x != 0 comma, 0 &, x = 0 comma) quad
    "on" quad [-1, 1].
  $
  Then $f$ has a finite derivative at every point of $[-1, 1]$, namely
  $
    f'(x) = cases(
      2x sin(1/x^2) - (2/x) cos(1/x^2) &, x != 0 comma,
      0 &, x = 0 comma
    ),
  $
  yet $f'$ is unbounded on $[-1, 1]$, and hence not Riemann integrable
  there.
] <ex:nonintegrable-derivative>

#proof[
  For $x != 0$ the chain rule gives
  $f'(x) = 2x sin(1/x^2) - (2/x) cos(1/x^2)$, and
  $f'(0) = lim_(h -> 0) (h^2 sin(1/h^2)) / h = lim_(h -> 0) h sin(1/h^2) = 0$.
  Take $x_k = 1 / sqrt(2k pi)$, so that $1/(x_k^2) = 2k pi$ and
  $cos(1/x_k^2) = 1$; then
  $ f'(x_k) = 2x_k sin(2k pi) - 2/x_k = -2 sqrt(2k pi) -> -oo quad (k -> oo), $
  so $f'$ is unbounded, and an unbounded function is never Riemann
  integrable.
]

#note[
  *A bounded function with a primitive that is not integrable.* Volterra
  constructed a differentiable function whose derivative is bounded but not
  Riemann integrable: the derivative is discontinuous on a set of positive
  measure (a "fat" Cantor set), cf. Lebesgue's theorem. Together with the
  two examples above this shows that integrability of a function and the
  existence of a primitive imply neither the one nor the other.
]

#theorem(name: "Newton-Leibniz Formula")[
  Let $f in C[a, b]$ and let $F(x)$ be a primitive of $f$ on $[a, b]$. Then
  $ integral_a^b f(x) dif x = F(b) - F(a). $

  *Generalized Newton-Leibniz formula.* Let $f in R[a, b]$, $F in C[a, b]$,
  and let $F'(x) = f(x)$ hold except at finitely many points. Then again
  $ integral_a^b f(x) dif x = F(b) - F(a). $
] <thm:newton-leibniz>

#proof[
  For the first statement: the variable upper limit integral and $F$ are
  both primitives of $f$ (the former by statement 3 of
  #link(<prop:variable-limit-integrals>)[the properties of variable limit
    integrals]), so they differ by a constant:
  $integral_a^x f(t) dif t = F(x) + C$. Setting $x = a$ yields
  $C = -F(a)$; setting $x = b$ then gives
  $integral_a^b f(x) dif x = F(b) - F(a)$.

  For the generalized statement: take a partition
  $P: a = x_0 < x_1 < dots.c < x_n = b$ whose division points contain the
  finitely many points where $F'(x) != f(x)$. On each closed interval
  $[x_(i-1), x_i]$ the function $F$ is continuous, and on the open interval
  it is differentiable with $F' = f$ there; by Lagrange's mean value
  theorem there exists $xi_i in (x_(i-1), x_i)$ such that
  $ F(x_i) - F(x_(i-1)) = F'(xi_i)(x_i - x_(i-1)) = f(xi_i) Delta x_i. $
  Summation over $i$ gives
  $F(b) - F(a) = sum_(i=1)^n f(xi_i) Delta x_i$. Letting
  $lambda = max_(1 <= i <= n) (Delta x_i) -> 0$, the Riemann sums converge
  to the integral, whence $integral_a^b f(x) dif x = F(b) - F(a)$.
]

#example(name: "Limit of a Difference Quotient of Integrals")[
  Let $f in R[A, B]$, and let $a, b in (A, B)$ be two continuity points of
  $f$. Prove that
  $ lim_(h -> 0) integral_a^b (f(x + h) - f(x)) / h dif x = f(b) - f(a). $
] <ex:difference-quotient-limit>

#proof[
  For $|h|$ small enough $[a + h, b + h] subset (A, B)$, so $f$ is
  integrable on $[a + h, b + h]$ by additivity over intervals. Substituting
  $u = x + h$ in the first integral,
  $
    integral_a^b (f(x + h) - f(x)) / h dif x
    = 1/h (integral_(a + h)^(b + h) f(u) dif u - integral_a^b f(x) dif x).
  $
  Additivity over intervals rewrites the bracket as
  $
    integral_b^(b + h) f(x) dif x - integral_a^(a + h) f(x) dif x.
  $
  Since $a$ and $b$ are continuity points of $f$, statement 2 of
  #link(<prop:variable-limit-integrals>)[the fundamental theorem of
    calculus] gives
  $lim_(h -> 0) 1/h integral_a^(a + h) f(x) dif x = f(a)$ and
  $lim_(h -> 0) 1/h integral_b^(b + h) f(x) dif x = f(b)$ (the same
  two-sided limit for $h < 0$), whence
  $lim_(h -> 0) integral_a^b (f(x + h) - f(x)) / h dif x = f(b) - f(a)$.
]

#example(name: "Integrability Criterion for Derivatives")[
  Let $F'(x)$ exist at every point of $[a, b]$. Then
  $ F' in R[a, b] <=> exists g in R[a, b]: F(x) - F(a) = integral_a^x g(t) dif t. $
] <ex:derivative-integrability>

#proof[
  (*Necessity.*) If $F' in R[a, b]$, take $g = F'$. For any partition
  $a = x_0 < x_1 < dots.c < x_n = x$ of $[a, x]$, Lagrange's mean value
  theorem provides $xi_i in (x_(i-1), x_i)$ with
  $F(x_i) - F(x_(i-1)) = F'(xi_i) Delta x_i$, so
  $F(x) - F(a) = sum_(i=1)^n F'(xi_i) Delta x_i$ is a Riemann sum of $F'$;
  since $F'$ is integrable, letting the mesh tend to zero yields
  $F(x) - F(a) = integral_a^x F'(t) dif t$.

  (*Sufficiency.*) Suppose $g in R[a, b]$ with
  $F(x) - F(a) = integral_a^x g(t) dif t$. Take a partition
  $P: a = x_0 < x_1 < dots.c < x_n = b$ and denote
  $m_i^g = inf \{g(x) | x in [x_(i-1), x_i]\}$,
  $M_i^g = sup \{g(x) | x in [x_(i-1), x_i]\}$, and
  $omega_i^g = M_i^g - m_i^g$. For $x, x + Delta x in [x_(i-1), x_i]$ with
  $Delta x != 0$,
  $
    (F(x + Delta x) - F(x)) / (Delta x)
    = 1/(Delta x) integral_x^(x + Delta x) g(t) dif t,
  $
  and since $m_i^g <= g(x) <= M_i^g$ on this sub-interval,
  $m_i^g <= (F(x + Delta x) - F(x)) / (Delta x) <= M_i^g$. Letting
  $Delta x -> 0$ yields $m_i^g <= F'(x) <= M_i^g$ for every
  $x in [x_(i-1), x_i]$. Hence the oscillation of $F'$ on
  $[x_(i-1), x_i]$ satisfies
  $omega_i^(F') <= M_i^g - m_i^g = omega_i^g$, and therefore
  $
    0 <= sum_(i=1)^n omega_i^(F') Delta x_i <= sum_(i=1)^n omega_i^g Delta x_i.
  $
  Since $g in R[a, b]$, the right-hand side can be made smaller than
  $epsilon$ for a suitable partition by the third criterion, and the same
  partition makes the left-hand side smaller than $epsilon$; by the third
  criterion again, $F' in R[a, b]$.
]

=== Common Questions concerning Integrals // 关于积分的常见问题

#note[
  Problems concerning integrals fall into the following categories.
  - *A. Estimation of integral values*
    - A1: estimating the value of an integral by means of Darboux sums;
    - A2: estimates via transformations and their applications (variable
      substitution, integration by parts, squeezing the integrand or the
      interval of integration, differential mean value theorems, Taylor
      formula).
  - *B. Integral inequalities*
    - B1: proving integral inequalities by differential methods;
    - B2: proving integral inequalities via inequalities between the
      integrands;
    - B3: integrating an inequality (variable limit integrals).
  - *C. Miscellaneous*
    - C1: comprehensive problems;
    - C2: solving functional equations by means of integrals;
    - C3: integral properties of convex functions.
  - *D. Technical tricks*
    - D1: monotonicity;
    - D2: symmetry;
    - D3: differentiating so as to obtain a differential equation;
    - D4: extremal principle;
    - D5: zeros of the integrand;
    - D6: logarithmic derivatives.
]

== Calculation of Definite Integrals // 定积分的计算

The two fundamental tools for computing definite integrals are inherited
directly from the indefinite integral.

#theorem(name: "Substitution in Definite Integrals")[
  Let $f in C[a, b]$, and let $x = phi(t)$ satisfy $phi' in R[alpha, beta]$,
  $phi([alpha, beta]) subset [a, b]$, $phi(alpha) = a$, $phi(beta) = b$. Then
  $ integral_a^b f(x) dif x = integral_alpha^beta f(phi(t)) phi'(t) dif t. $
] <thm:definite-substitution>

#corollary(name: "Monotone Substitution")[
  If $f in R[a, b]$ (instead of $f in C[a, b]$), the conclusion still holds
  provided $phi$ is strictly increasing on $[alpha, beta]$ with
  $phi(alpha) = a$ and $phi(beta) = b$.
] <cor:monotone-substitution>

#theorem(name: "Integration by Parts for Definite Integrals")[
  Let $u'(x), v'(x) in R[a, b]$. Then
  $ integral_a^b u(x) dif v(x) = (u(x) v(x)) |_a^b - integral_a^b v(x) dif u(x). $
] <thm:definite-integration-by-parts>

#proof[
  Since $u$ and $v$ are differentiable on $[a, b]$, the product rule gives
  $(u v)' = u' v + u v'$ at every point. Moreover $u, v in C[a, b]$, so the
  products $u' v$ and $u v'$ are integrable (one factor continuous, the other
  integrable), whence $(u v)' in R[a, b]$ with $u v$ as an antiderivative.
  By the #link(<thm:newton-leibniz>)[generalized Newton-Leibniz formula],
  $ integral_a^b (u'(x) v(x) + u(x) v'(x)) dif x = u(b) v(b) - u(a) v(a), $
  which is exactly the asserted identity after rearrangement.
]

#proposition(name: "Symmetry of Definite Integrals")[
  Let $f in R[0, a]$.
  + *Even reflection:* if $f(x) = f(a - x)$ for all $x in [0, a]$, then
    $ integral_0^a f(x) dif x = 2 integral_0^(a/2) f(x) dif x. $
  + *Odd reflection:* if $f(x) = -f(a - x)$ for all $x in [0, a]$, then
    $ integral_0^a f(x) dif x = 0. $
  + If $f(x) + f(a - x) = g(x)$, then
    $ integral_0^a f(x) dif x = integral_0^(a/2) g(x) dif x; $
    indeed, $f(x) + f(a - x)$ is always even with respect to the point
    $x = a/2$.
] <prop:integral-symmetry>

#proposition(name: "Periodicity of Definite Integrals")[
  Let $f$ be an integrable periodic function with period $T$. Then for every
  $a$,
  $ integral_a^(a + T) f(x) dif x = integral_0^T f(x) dif x. $
] <prop:integral-periodicity>

#example(name: "Wallis Formula")[
  Prove the recursion formula (Wallis formula) by the method of recursion:
  $
    integral_0^(pi/2) sin^n x dif x
    = integral_0^(pi/2) cos^n x dif x
    = cases((n - 1)!! / n!! dot pi / 2 & "if" n "is even", (n - 1)!! / n!! & "if" n "is odd")
  $
] <ex:wallis>

#solution[
  The equality of the two integrals follows from the substitution
  $t = pi/2 - x$. Integration by parts yields
  $
    I_n & = integral_0^(pi/2) sin^(n - 1) x dif (-cos x) \
        & = (-sin^(n - 1) x cos x) |_0^(pi/2) + integral_0^(pi/2) cos x dif (sin^(n - 1) x) \
        & = (n - 1) integral_0^(pi/2) sin^(n - 2) x cos^2 x dif x \
        & = (n - 1) I_(n - 2) - (n - 1) I_n,
  $
  whence $I_n = (n - 1) / n I_(n - 2)$ for $n >= 2$, and therefore
  $
    I_n = cases((n - 1)!! / n!! & "if" n = 2k + 1, (n - 1)!! / n!! dot pi / 2 & "if" n = 2k) quad (k in bb(N)).
  $
]

#note[
  The first formula gives rise to the Wallis product.
]

#note[
  For integrals of the form $integral_alpha^beta sin^m x cos^n x dif x$: when
  one of $m, n$ is odd, the value can be obtained directly by substitution;
  when both are even, one generally has to lower the powers to $1$ by
  trigonometric identities first. However, when $alpha = 0$ and $beta = pi/2$,
  the recursion above applies as soon as one of $m, n$ is even.
]

#example(name: "Simpson's Rule")[
  // 万能公式
  If $p(x)$ is a polynomial of degree at most $3$, then
  $ integral_a^b p(x) dif x = 1/6 (p(a) + 4 p((a + b) / 2) + p(b)) (b - a). $
] <ex:simpson-formula>

#example(name: "A Collection of Computations")[
  Evaluate:
  + $I = integral_0^1 (ln(1 + x)) / (1 + x^2) dif x$;
  + $integral_0^(pi/2) (sin^2 x) / (sin x + cos x) dif x$;
  + $integral_0^2 ((x - 1)^2 + 1) / ((x - 1)^2 + x^2 (x - 2)^2) dif x$;
  + $integral_0^(pi/2) sin x ln(sin x) dif x$.
] <ex:integral-computations>

#solution[
  + Substitute $x = tan t$:
    $
      I & = integral_0^(pi/4) ln(1 + tan t) dif t
          = integral_0^(pi/4) ln((sin t + cos t) / cos t) dif t \
        & = integral_0^(pi/4) ln((sqrt(2) cos(pi/4 - t)) / cos t) dif t \
        & = integral_0^(pi/4) ln sqrt(2) dif t
          + integral_0^(pi/4) ln cos(pi/4 - t) dif t
          - integral_0^(pi/4) ln cos t dif t.
    $
    Moreover, by the substitution $u = pi/4 - t$,
    $integral_0^(pi/4) ln cos(pi/4 - t) dif t = integral_0^(pi/4) ln cos u dif u$.
    The last two integrals cancel, and therefore
    $I = integral_0^(pi/4) ln sqrt(2) dif t = pi/8 ln 2$.
  + By the substitution $x = pi/2 - t$ the integral equals
    $integral_0^(pi/2) (cos^2 x) / (sin x + cos x) dif x$. Hence
    $
      integral_0^(pi/2) (sin^2 x) / (sin x + cos x) dif x
      & = 1/2 integral_0^(pi/2) (sin^2 x + cos^2 x) / (sin x + cos x) dif x \
      & = 1/2 integral_0^(pi/2) (dif x) / (sin x + cos x) \
      & = 1/(2 sqrt(2)) integral_0^(pi/2) (dif x) / (sin(x + pi/4))
      = ln(1 + sqrt(2)) / sqrt(2),
    $
    the last step using
    $integral_(pi/4)^((3 pi)/4) (dif u) / (sin u) = ln tan((3 pi)/8) - ln tan(pi/8) = 2 ln(1 + sqrt(2))$
    under the substitution $u = x + pi/4$.
  + Let $f(x) = ((x - 1)^2 + 1) / ((x - 1)^2 + x^2 (x - 2)^2)$. Then
    $
      F_1 (x) = cases(arctan((x (x - 2)) / (x - 1)) & "if" x in [0, 1), pi/2 & "if" x = 1)
    $
    is an antiderivative of $f$ on $[0, 1]$, and
    $
      F_2 (x) = cases(arctan((x (x - 2)) / (x - 1)) & "if" x in (1, 2], -pi/2 & "if" x = 1)
    $
    is an antiderivative of $f$ on $[1, 2]$. By additivity over sub-intervals
    and the #link(<thm:newton-leibniz>)[Newton-Leibniz formula] on each piece,
    $
      integral_0^2 f(x) dif x = F_1 (x) |_0^1 + F_2 (x) |_1^2 = pi.
    $
  + Since $sin x ln(sin x) = O(1)$ as $x -> 0^+$, the integral is a proper
    one. Integration by parts gives
    $
      I & = integral_0^(pi/2) ln(sin x) dif (1 - cos x) \
        & = (1 - cos x) ln(sin x) |_0^(pi/2) - integral_0^(pi/2) (1 - cos x) dif (ln(sin x)) \
        & = -integral_0^(pi/2) (1 - cos x) (cos x) / sin x dif x \
        & = -integral_0^(pi/2) (sin x cos x) / (1 + cos x) dif x \
        & = integral_0^(pi/2) (-sin x + sin x / (1 + cos x)) dif x \
        & = (cos x - ln(1 + cos x)) |_0^(pi/2) \
        & = ln 2 - 1.
    $
]

#caution[
  In item 3 one must not regard $arctan((x (x - 2)) / (x - 1))$ as an
  antiderivative on $[0, 2]$ and apply the Newton-Leibniz formula directly:
  it has a discontinuity at $x = 1$ inside $[0, 2]$, so it cannot be an
  antiderivative there. One should split the integral over $[0, 1]$ and
  $[1, 2]$ by additivity and apply the Newton-Leibniz formula to each piece.
  Cauchy gave a similar example:
  $integral_0^((3 pi)/4) (sin x) / (1 + cos^2 x) dif x$.
]

== Integral Inequalities // 积分不等式

#theorem(name: "Integral Inequalities")[
  + *Hadamard inequality.* Let $f$ be convex on $(a, b)$. Then for every pair
    $x_1, x_2 in (a, b)$ with $x_1 < x_2$,
    $
      f((x_1 + x_2) / 2) <= 1/(x_2 - x_1) integral_(x_1)^(x_2) f(t) dif t
      <= (f(x_1) + f(x_2)) / 2.
    $
  + *Schwarz inequality.* Let $f, g in R[a, b]$. Then
    $
      (integral_a^b f(x) g(x) dif x)^2
      <= integral_a^b f^2 (x) dif x dot integral_a^b g^2 (x) dif x.
    $
  + *Hölder inequality.* Let $f, g in R[a, b]$, and let $p, q$ be conjugate
    exponents, i.e. $p > 0$, $q > 0$, $1/p + 1/q = 1$. Then
    $
      integral_a^b abs(f(x) g(x)) dif x
      <= (integral_a^b abs(f(x))^p dif x)^(1/p)
      (integral_a^b abs(g(x))^q dif x)^(1/q).
    $
  + *Young inequality.* Let $y = f(x) in C[0, +oo)$ be strictly increasing
    with $f(0) = 0$, and denote its inverse function by $x = f^(-1) (y)$. Then
    $
      integral_0^a f(x) dif x + integral_0^b f^(-1) (y) dif y >= a b
      quad (a > 0, b > 0).
    $
  + *Minkowski inequality.* Let $f, g in R[a, b]$. Then
    $
      lr(\{integral_a^b (f(x) + g(x))^2 dif x\})^(1/2)
      <= lr(\{integral_a^b f^2 (x) dif x\})^(1/2)
      + lr(\{integral_a^b g^2 (x) dif x\})^(1/2).
    $
  + *Chebyshev inequality.* Call $f, g$ *similarly ordered* if
    $forall x_1, x_2: (f(x_1) - f(x_2))(g(x_1) - g(x_2)) >= 0$. Then
    $
      integral_a^b f(x) dif x dot integral_a^b g(x) dif x
      <= (b - a) integral_a^b f(x) g(x) dif x.
    $

    *Discrete form.* Let the sequences $\{a_n\}$ and $\{b_n\}$ be similarly
    ordered, i.e. $forall i, j: (a_i - a_j)(b_i - b_j) >= 0$. Then
    $
      (sum_(i=1)^n a_i)(sum_(i=1)^n b_i) <= n sum_(i=1)^n a_i b_i.
    $
    If the sequences are oppositely ordered, the inequality reverses.
] <thm:integral-inequalities>

#proof[
  We prove the Hölder inequality. If $f equiv 0$ or $g equiv 0$, the
  inequality is trivial; otherwise set
  $
    phi(x) = abs(f(x)) / (integral_a^b abs(f(x))^p dif x)^(1/p), quad
    psi(x) = abs(g(x)) / (integral_a^b abs(g(x))^q dif x)^(1/q), quad x in [a, b].
  $
  By the positivity part of the
  #link(<prop:riemann-integral-properties>)[properties of the Riemann
    integral], $integral_a^b abs(f(x))^p dif x > 0$ and
  $integral_a^b abs(g(x))^q dif x > 0$. The elementary Hölder inequality
  $a b <= a^p / p + b^q / q$ gives
  $phi(x) psi(x) <= phi(x)^p / p + psi(x)^q / q$, i.e.
  $
    (abs(f(x) g(x))) / ((integral_a^b abs(f(x))^p dif x)^(1/p) (integral_a^b abs(g(x))^q dif x)^(1/q))
    <= (abs(f(x))^p) / (p integral_a^b abs(f(x))^p dif x)
    + (abs(g(x))^q) / (q integral_a^b abs(g(x))^q dif x),
    quad x in [a, b].
  $
  Integrating both sides over $[a, b]$ and using the linearity of the
  integral,
  $
    (integral_a^b abs(f(x) g(x)) dif x) / ((integral_a^b abs(f(x))^p dif x)^(1/p) (integral_a^b abs(g(x))^q dif x)^(1/q))
    <= 1/p + 1/q = 1.
  $
  Multiplying both sides by
  $(integral_a^b abs(f(x))^p dif x)^(1/p) (integral_a^b abs(g(x))^q dif x)^(1/q)$
  yields the claim.
]

#example(name: "An Integral Inequality for Convex Functions")[
  Let $f(t)$ be convex on $[0, 1]$. Prove that
  $
    integral_0^1 t (1 - t) f(t) dif t
    <= 1/3 integral_0^1 (t^3 + (1 - t)^3) f(t) dif t.
  $
] <ex:convex-integral-inequality>

#proof[
  Since $f$ is convex on $[0, 1]$, for any $t in (0, 1)$ and $x in [0, 1]$ we
  have the convex combination
  $ t = (1 - t)(t x) + t (1 - x + t x), $
  whence
  $ f(t) <= (1 - t) f(t x) + t f(1 - x + t x). $
  Integrating both sides with respect to $x$ from $0$ to $1$ and evaluating
  the two integrals by the substitutions $u = t x$ and $u = 1 - (1 - t) x$,
  respectively, we get
  $
    f(t) <= (1 - t) integral_0^1 f(t x) dif x + t integral_0^1 f(1 - x + t x) dif x
    = (1 - t)/t integral_0^t f(x) dif x + t/(1 - t) integral_t^1 f(x) dif x.
  $
  Multiplying both sides by $t (1 - t)$ and integrating with respect to $t$
  from $0$ to $1$, we have
  $
    integral_0^1 t (1 - t) f(t) dif t
    <= integral_0^1 (1 - t)^2 [integral_0^t f(x) dif x] dif t
    + integral_0^1 t^2 [integral_t^1 f(x) dif x] dif t.
  $
  Changing the order of integration on the right-hand side,
  $
    integral_0^1 (1 - t)^2 [integral_0^t f(x) dif x] dif t
    = integral_0^1 f(x) [integral_x^1 (1 - t)^2 dif t] dif x
    = 1/3 integral_0^1 (1 - x)^3 f(x) dif x,
  $
  and similarly
  $integral_0^1 t^2 [integral_t^1 f(x) dif x] dif t = 1/3 integral_0^1 x^3 f(x) dif x$.
  Thus the desired inequality is proven.
]

== Applications of Definite Integrals // 定积分的应用

=== Arc Length // 弧长

#definition(name: "Arc Length")[
  Let $C$ be a curve in $bb(R)^2$ with endpoints $A$ and $B$. Take division
  points $A = P_0, P_1, dots.c, P_n = B$ successively from $A$ to $B$ along
  $C$; they form a partition $T$ of the curve. Joining each pair of adjacent
  points by a segment produces the $n$ chords $P_(i-1) P_i$
  ($i = 1, 2, dots, n$), which together constitute an inscribed polygonal
  line of $C$. Set
  $
    norm(T) = max_(1 <= i <= n) abs(P_(i-1) P_i), quad
    s_T = sum_(i=1)^n abs(P_(i-1) P_i),
  $
  the length of the longest chord and the total length of the polygonal line,
  respectively. If $lim_(norm(T) -> 0) s_T = s$ exists, i.e.
  $ forall epsilon > 0, exists delta > 0, forall norm(T) < delta: abs(s_T - s) < epsilon, $
  then $C$ is called *rectifiable*, and the limit $s$ is called the
  *arc length* of $C$.
] <def:arc-length>

#theorem(name: "A Sufficient Condition for Rectifiability")[
  Let a curve $C$ in $bb(R)^2$ be given by parametric equations
  $(x, y) = (x(t), y(t))$, $t in [alpha, beta]$, and suppose that $C$ is a
  $C^1$ regular curve, i.e. $x(t)$ and $y(t)$ are continuously differentiable
  with $x'^2 (t) + y'^2 (t) != 0$ (a point satisfying this condition is
  called a regular point). Then $C$ is rectifiable, and its arc length is
  $ s = integral_alpha^beta sqrt(x'^2 (t) + y'^2 (t)) dif t. $
] <thm:rectifiable-condition>

=== Polar Coordinate System // 极坐标系

#text(size: 8.5pt)[#tex-table(
  ([Category], [Explicit Cartesian Equation], [Parametric Cartesian Equation], [Polar Equation]),
  (
    [Equation],
    [$y = f(x), x in [a, b]$],
    [$x = x(t), y = y(t), t in [T_1, T_2]$],
    [$r = r(theta), theta in [alpha, beta]$],
  ),
  (
    [Area of a plane region],
    [$integral_a^b f(x) dif x$],
    [$integral_(T_1)^(T_2) abs(y(t) x'(t)) dif t$],
    [$1/2 integral_alpha^beta r^2 (theta) dif theta$],
  ),
  (
    [Infinitesimal arc length],
    [$dif l = sqrt(1 + [f'(x)]^2) dif x$],
    [$dif l = sqrt([x'(t)]^2 + [y'(t)]^2) dif t$],
    [$dif l = sqrt(r^2 (theta) + r'^2 (theta)) dif theta$],
  ),
  (
    [Curve length],
    [$integral_a^b sqrt(1 + [f'(x)]^2) dif x$],
    [$integral_(T_1)^(T_2) sqrt([x'(t)]^2 + [y'(t)]^2) dif t$],
    [$integral_alpha^beta sqrt(r^2 (theta) + r'^2 (theta)) dif theta$],
  ),
  (
    [Volume of a solid of revolution],
    [$pi integral_a^b [f(x)]^2 dif x$],
    [$pi integral_(T_1)^(T_2) y^2 (t) x'(t) dif t$],
    [$2/3 pi integral_alpha^beta r^3 (theta) sin theta dif theta$],
  ),
  (
    [Surface area of a solid of revolution],
    [$2 pi integral_a^b f(x) sqrt(1 + [f'(x)]^2) dif x$],
    [$2 pi integral_(T_1)^(T_2) y(t) sqrt([x'(t)]^2 + [y'(t)]^2) dif t$],
    [$2 pi integral_alpha^beta r(theta) sin theta sqrt(r^2 (theta) + r'^2 (theta)) dif theta$],
  ),
)] // 曲率小节：md 为空节，不迁

// B7: ch07 Improper Integral（反常积分）
= Improper Integral // 反常积分

The Riemann integral presupposes a bounded integrand on a finite interval.
Relaxing either requirement leads to improper integrals: the infinite
integrals over unbounded intervals and the defective integrals of unbounded
functions. Throughout this chapter, "integrable" refers to this improper
sense unless stated otherwise.

== Infinite and Defective Integrals // 无穷积分与瑕积分

#definition(name: "Infinite Integral")[
  Let $f(x)$ be defined on $[a, +oo)$ and Riemann integrable on every finite
  subinterval $[a, A] subset [a, +oo)$. If the limit
  $ lim_(A -> +oo) integral_a^A f(x) dif x $
  exists, then the improper integral $integral_a^(+oo) f(x) dif x$ is said to
  *converge* (or $f(x)$ is said to be *integrable* on $[a, +oo)$), and its
  value is
  $ integral_a^(+oo) f(x) dif x = lim_(A -> +oo) integral_a^A f(x) dif x; $
  otherwise the integral is said to *diverge*.
] <def:infinite-integral>

#note[
  The integral $integral_(-oo)^(+oo) f(x) dif x$ converges only when both
  $integral_a^(+oo) f(x) dif x$ and $integral_(-oo)^a f(x) dif x$ converge.
]

#definition(name: "Defective Integral")[
  Let $f(x)$ be unbounded in the left neighbourhood of $x = b$. If for every
  $eta in (0, b - a)$ the function $f(x)$ is bounded and Riemann integrable
  on $[a, b - eta]$, and the limit
  $ lim_(eta -> 0^+) integral_a^(b - eta) f(x) dif x $
  exists, then the improper integral $integral_a^b f(x) dif x$ is said to
  *converge* (or the unbounded function $f(x)$ is said to be *integrable* on
  $[a, b]$), with
  $ integral_a^b f(x) dif x = lim_(eta -> 0^+) integral_a^(b - eta) f(x) dif x; $
  otherwise the integral is said to *diverge*.
] <def:defective-integral>

#note[
  Infinite integrals and defective integrals can often be converted into one
  another, e.g. by a substitution such as $x = 1/t$.
]

#note[
  For improper integrals, linearity, order-preservation and additivity over
  intervals still hold; however, two (improperly) integrable functions need
  not have an integrable product.
]

#example(name: "p-Integrals")[
  For the infinite integral
  $ integral_1^(+oo) (dif x) / x^p $
  the integral converges to $1/(p - 1)$ when $p > 1$ and diverges when
  $p <= 1$. For the defective integral
  $ integral_0^1 (dif x) / x^p $
  the integral converges to $1/(1 - p)$ when $p < 1$ and diverges when
  $p >= 1$.
] <ex:p-integrals>

#solution[
  For $p != 1$,
  $ integral_1^A (dif x) / x^p = (A^(1 - p) - 1) / (1 - p) $
  has a finite limit as $A -> +oo$ exactly when $1 - p < 0$; for $p = 1$ the
  integral equals $ln A -> +oo$. Similarly,
  $ integral_eta^1 (dif x) / x^p = (1 - eta^(1 - p)) / (1 - p) $
  has a finite limit as $eta -> 0^+$ exactly when $1 - p > 0$; for $p = 1$ it
  equals $-ln eta -> +oo$.
]

#definition(name: "Cauchy Principal Value")[
  If the limit
  $ lim_(A -> +oo) integral_(-A)^A f(x) dif x = lim_(A -> +oo) (F(A) - F(-A)) $
  converges, its value is called the *Cauchy principal value* of
  $integral_(-oo)^(+oo) f(x) dif x$, denoted by
  $ (upright("cpv")) integral_(-oo)^(+oo) f(x) dif x. $
  When $integral_(-oo)^(+oo) f(x) dif x$ converges, it equals its Cauchy
  principal value; however, a divergent integral may still possess a Cauchy
  principal value.
] <def:cauchy-principal-value>

== Convergence Tests for Improper Integrals // 反常积分审敛法

#definition(name: "Absolute and Conditional Convergence")[
  Let $f(x) in R[a, A] subset [a, +oo)$, and suppose
  $integral_a^(+oo) abs(f(x)) dif x$ converges. Then
  $integral_a^(+oo) f(x) dif x$ is said to be *absolutely convergent* (or
  $f(x)$ is *absolutely integrable* on $[a, +oo)$).

  If $integral_a^(+oo) f(x) dif x$ converges but is not absolutely
  convergent, then $integral_a^(+oo) f(x) dif x$ is said to be *conditionally
  convergent*.
] <def:abs-cond-convergence-integral>

=== Infinite Integrals // 无穷积分

#theorem(name: "Cauchy Convergence Criterion for Infinite Integrals")[
  The necessary and sufficient condition for the convergence of the infinite
  integral $integral_a^(+oo) f(x) dif x$ is
  $
    forall epsilon > 0, exists A_0 > max\{a, 0\}, forall A', A'' > A_0:
    abs(integral_(A')^(A'') f(x) dif x) < epsilon.
  $
] <thm:cauchy-criterion-infinite-integral>

#proof[
  Set $F(A) = integral_a^A f(x) dif x$. By
  #link(<def:infinite-integral>)[definition], the improper integral converges
  if and only if $lim_(A -> +oo) F(A)$ exists and is finite. By the Cauchy
  criterion for function limits, this holds if and only if for every
  $epsilon > 0$ there is $A_0 > max\{a, 0\}$ such that for all
  $A', A'' > A_0$,
  $ abs(F(A') - F(A'')) = abs(integral_(A')^(A'') f(x) dif x) < epsilon, $
  which is precisely the asserted condition.
]

#corollary(name: "Absolute Convergence Implies Convergence")[
  If $integral_a^(+oo) abs(f(x)) dif x$ converges, then so does
  $integral_a^(+oo) f(x) dif x$.
] <cor:absolute-implies-convergence>

#proof[
  For $A', A'' > A_0$,
  $ abs(integral_(A')^(A'') f(x) dif x) <= integral_(A')^(A'') abs(f(x)) dif x < epsilon, $
  so #link(<thm:cauchy-criterion-infinite-integral>)[the Cauchy criterion]
  applies to $f$ itself.
]

#theorem(name: "Comparison Tests for Infinite Integrals")[
  + *Comparison test.* Let $f(x), g(x)$ be defined on $[a, +oo)$ with
    $0 <= f(x) <= K g(x)$ for a constant $K > 0$. Then
    (i) if $integral_a^(+oo) g(x) dif x$ converges, so does
    $integral_a^(+oo) f(x) dif x$;
    (ii) if $integral_a^(+oo) f(x) dif x$ diverges, so does
    $integral_a^(+oo) g(x) dif x$.
  + *Limit form.* Let $f(x), g(x) > 0$ on $[a, +oo)$ and
    $lim_(x -> +oo) f(x) / g(x) = l$. Then
    (i) if $0 <= l < +oo$ and $integral_a^(+oo) g(x) dif x$ converges, so
    does $integral_a^(+oo) f(x) dif x$;
    (ii) if $0 < l <= +oo$ and $integral_a^(+oo) g(x) dif x$ diverges, so
    does $integral_a^(+oo) f(x) dif x$.
    In particular, for $0 < l < +oo$ the two integrals converge or diverge
    simultaneously.
  + *Comparison with p-integrals.* Let $f(x) >= 0$ on
    $[a, +oo) subset (0, +oo)$.
    (i) if $f(x) <= K / x^p$ and $p > 1$, then $integral_a^(+oo) f(x) dif x$
    converges;
    (ii) if $f(x) >= K / x^p$ and $p <= 1$, then $integral_a^(+oo) f(x) dif x$
    diverges.
  + *Limit form with p-integrals.* Let $f(x) >= 0$ on
    $[a, +oo) subset (0, +oo)$ and $lim_(x -> +oo) x^p f(x) = l$. Then
    (i) if $0 <= l < +oo$ and $p > 1$, then $integral_a^(+oo) f(x) dif x$
    converges;
    (ii) if $0 < l <= +oo$ and $p <= 1$, then $integral_a^(+oo) f(x) dif x$
    diverges.
] <thm:comparison-tests-infinite-integral>

#theorem(name: "Abel-Dirichlet Test")[
  The infinite integral $integral_a^(+oo) f(x) g(x) dif x$ converges if
  either of the following two conditions is satisfied:
  - *Abel*: $integral_a^(+oo) f(x) dif x$ converges, and $g(x)$ is monotonic
    and bounded on $[a, +oo)$.
  - *Dirichlet*: $F(A) = integral_a^A f(x) dif x$ is bounded on $[a, +oo)$,
    $g(x)$ is monotonic on $[a, +oo)$, and $lim_(x -> +oo) g(x) = 0$.
] <thm:abel-dirichlet-infinite-integral>

#proof[
  *Abel.* Suppose $abs(g(x)) <= M$ for all $x in [a, +oo)$. Since
  $integral_a^(+oo) f(x) dif x$ converges,
  #link(<thm:cauchy-criterion-infinite-integral>)[the Cauchy criterion]
  provides $A_0 > max\{a, 0\}$ such that for all $A'' > A' > A_0$,
  $ abs(integral_(A')^(A'') f(x) dif x) < epsilon / (2 M). $
  By the general form of the second integral mean value theorem
  (#link(<thm:integral-mean-value>)[Bonnet's formula]), there exists
  $xi in [A', A'']$ with
  $
    integral_(A')^(A'') f(x) g(x) dif x
    = g(A') integral_(A')^(xi) f(x) dif x + g(A'') integral_(xi)^(A'') f(x) dif x,
  $
  hence
  $
    abs(integral_(A')^(A'') f(x) g(x) dif x) & <= abs(g(A')) abs(integral_(A')^(xi) f(x) dif x)
                                               + abs(g(A'')) abs(integral_(xi)^(A'') f(x) dif x) \
                                             & < M dot epsilon / (2 M) + M dot epsilon / (2 M) = epsilon.
  $
  By the Cauchy criterion, $integral_a^(+oo) f(x) g(x) dif x$ converges.

  *Dirichlet.* Since $F(A)$ is bounded, writing
  $M = sup_(A >= a) abs(F(A))$ gives
  $abs(integral_u^v f(x) dif x) = abs(F(v) - F(u)) <= 2 M$ for all
  $v > u >= a$. As $g(x) -> 0$, for every $epsilon > 0$ there is $A_0$ such
  that $abs(g(x)) < epsilon / (4 M)$ for all $x > A_0$. For $A'' > A' > A_0$,
  Bonnet's formula again yields $xi in [A', A'']$ with
  $
    abs(integral_(A')^(A'') f(x) g(x) dif x) & <= abs(g(A')) abs(integral_(A')^(xi) f(x) dif x)
                                               + abs(g(A'')) abs(integral_(xi)^(A'') f(x) dif x) \
                                             & < epsilon / (4 M) dot 2 M + epsilon / (4 M) dot 2 M = epsilon,
  $
  and the Cauchy criterion concludes the proof.
]

=== Defective Integrals // 瑕积分

#theorem(name: "Cauchy Convergence Criterion for Defective Integrals")[
  The defective integral $integral_a^b f(x) dif x$ (singularity at the upper
  limit $b$) converges if and only if
  $
    forall epsilon > 0, exists delta > 0, forall eta', eta'' in (0, delta):
    abs(integral_(b - eta')^(b - eta'') f(x) dif x) < epsilon.
  $
] <thm:cauchy-criterion-defective-integral>

#theorem(name: "Comparison with p-Integrals for Defective Integrals")[
  Let $f(x) >= 0$ on $[a, b)$, and suppose that on some left neighbourhood
  $[b - eta_0, b)$ of $b$ there is a constant $K > 0$ such that:
  + *Comparison.* (i) if $f(x) <= K / (b - x)^p$ and $p < 1$, then
    $integral_a^b f(x) dif x$ converges; (ii) if $f(x) >= K / (b - x)^p$ and
    $p >= 1$, then $integral_a^b f(x) dif x$ diverges.
  + *Limit form.* If $lim_(x -> b^-) (b - x)^p f(x) = l$, then
    (i) $0 <= l < +oo$ and $p < 1$ imply convergence;
    (ii) $0 < l <= +oo$ and $p >= 1$ imply divergence.
] <thm:comparison-tests-defective-integral>

#theorem(name: "Abel-Dirichlet Test for Defective Integrals")[
  The defective integral $integral_a^b f(x) g(x) dif x$ (singularity at the
  upper limit $b$) converges if either of the following two conditions is
  satisfied:
  - *Abel*: $integral_a^b f(x) dif x$ converges, and $g(x)$ is monotonic and
    bounded on $[a, b)$.
  - *Dirichlet*: $F(eta) = integral_a^(b - eta) f(x) dif x$ is bounded on
    $(0, b - a]$, $g(x)$ is monotonic on $[a, b)$, and
    $lim_(x -> b^-) g(x) = 0$.
] <thm:abel-dirichlet-defective-integral>

=== Examples // 例题

#example(name: "Convergence and Divergence Discussions")[
  Discuss the convergence of the following improper integrals:
  $
    & (1) quad integral_0^(+oo) sin x / x^p dif x quad (p > 0), \
    & (2) quad integral_0^(+oo) sin x / (x^p + sin x) dif x, \
    & (3) quad integral_0^(1/e) (dif x) / (x^p ln x) quad (p > 0), \
    & (4) quad integral_0^1 sin(1/x) / x^p dif x quad (p < 2).
  $
] <ex:improper-convergence>

#solution[
  *1).* First let $0 < p <= 1$. Since
  $sin x / x^p = x^(1 - p) dot sin x / x$ has a finite limit at $x = 0^+$
  (namely 0 for $p < 1$ and 1 for $p = 1$), $x = 0$ is not a singular point.
  On $[1, +oo)$ the factor $1/x^p$ decreases to 0 while
  $abs(integral_1^A sin x dif x) <= 2$ is bounded, so
  $integral_1^(+oo) sin x / x^p dif x$ converges by
  #link(<thm:abel-dirichlet-infinite-integral>)[Dirichlet's test]. It does
  not converge absolutely: on $[1, +oo)$,
  $ abs(sin x / x^p) >= sin^2 x / x^p = 1 / (2 x^p) - cos 2 x / (2 x^p), $
  where $integral_1^(+oo) cos 2 x / (2 x^p) dif x$ converges (Dirichlet's
  test again) while $integral_1^(+oo) 1/(2 x^p) dif x$ diverges for
  $p <= 1$; hence $integral_1^(+oo) sin^2 x / x^p dif x$ diverges, and the
  comparison test forces $integral_1^(+oo) abs(sin x / x^p) dif x$ to diverge
  too. The original integral is therefore conditionally convergent for
  $0 < p <= 1$.

  Now let $p > 1$, so that $x = 0$ is a singular point. Split the integral at
  $x = 1$:
  $ I_1 = integral_0^1 sin x / x^p dif x, quad I_2 = integral_1^(+oo) sin x / x^p dif x. $
  For $I_2$, $abs(sin x / x^p) <= 1/x^p$ with $p > 1$, so $I_2$ converges
  absolutely. For $I_1$, $sin x / x^p tilde.op x^(1 - p)$ as $x -> 0^+$, so
  by the limit-form comparison with p-integrals $I_1$ converges (the
  integrand being of constant sign near 0, this is absolute convergence)
  precisely when $1 - p > -1$, i.e. $p < 2$, and diverges to $+oo$ when
  $p >= 2$. In summary, the integral is conditionally convergent for
  $0 < p <= 1$, absolutely convergent for $1 < p < 2$, and divergent for
  $p >= 2$.

  *2).* For $p > 0$ the integrand stays bounded near $x = 0^+$ (it tends to 0
  for $p < 1$, to $1/2$ for $p = 1$ and to 1 for $p > 1$), so only
  $integral_1^(+oo)$ needs discussion. The identity
  $ sin x / (x^p + sin x) = sin x / x^p - sin^2 x / (x^p (x^p + sin x)) $
  follows by direct combination. The first term on the right converges
  conditionally for $0 < p <= 1$ and absolutely for $p > 1$ (item 1). For the
  second term, whose integrand is non-negative on $[1, +oo)$:
  - if $0 < p <= 1/2$, then since $x^p + 1 <= 2 x^p$ for $x >= 1$,
    $ sin^2 x / (x^p (x^p + sin x)) >= sin^2 x / (x^p (x^p + 1)) >= sin^2 x / (2 x^(2p)), $
    and $integral_1^(+oo) sin^2 x / x^(2p) dif x$ diverges for $2p <= 1$
    (write $sin^2 x = (1 - cos 2 x)/2$: the $cos$ term converges by
    Dirichlet's test while $integral_1^(+oo) dif x / x^(2p)$ diverges);
    hence the second integral diverges, and so does the original one;
  - if $p > 1/2$, then for $x$ large enough (say $x >= 2^(1/p)$, so that
    $x^p - 1 > 0$),
    $ 0 <= sin^2 x / (x^p (x^p + sin x)) <= 1 / (x^p (x^p - 1)) tilde.op 1 / x^(2p) quad (x -> +oo), $
    and $2p > 1$ makes the right-hand side integrable; hence the second
    integral converges, and the original integral converges exactly as the
    first term does.
  In summary, the integral diverges for $0 < p <= 1/2$, converges
  conditionally for $1/2 < p <= 1$, and converges absolutely for $p > 1$.

  *3).* On $(0, 1/e]$ we have $ln x <= -1$, so $x = 0$ is the only singular
  point.
  - If $0 < p < 1$, take $q = (1 + p)/2 in (p, 1)$. Then
    $ lim_(x -> 0^+) (1/(x^p abs(ln x))) / (1/x^q) = lim_(x -> 0^+) x^(q - p) / abs(ln x) = 0, $
    and $integral_0^(1/e) dif x / x^q$ converges since $q < 1$; by the
    limit-form comparison (#link(<thm:comparison-tests-defective-integral>)[defective version]) the original integral converges.
  - If $p > 1$, take $q = (1 + p)/2 in (1, p)$. Then the same limit equals
    $+oo$, while $integral_0^(1/e) dif x / x^q$ diverges since $q > 1$; by
    the limit form (case $l = +oo$) the original integral diverges.
  - If $p = 1$, then for every $eta in (0, 1/e)$,
    $ integral_eta^(1/e) (dif x) / (x ln x) = ln abs(ln x) |_eta^(1/e) = -ln(- ln eta) -> -oo quad (eta -> 0^+), $
    so the integral diverges.
  In summary, the integral converges for $0 < p < 1$ and diverges for
  $p >= 1$.

  *4).* Substitute $t = 1/x$:
  $ integral_0^1 sin(1/x) / x^p dif x = integral_1^(+oo) t^(p - 2) sin t dif t. $
  Since $t^(p - 2) = 1/t^(2 - p)$ decreases to 0 (here $p < 2$) and
  $abs(integral_1^A sin t dif t) <= 2$,
  #link(<thm:abel-dirichlet-infinite-integral>)[Dirichlet's test] shows that
  the integral converges. For absolute convergence: if $p < 1$, then
  $abs(sin(1/x) / x^p) <= 1/x^p$ and $integral_0^1 dif x / x^p$ converges, so
  the integral is absolutely convergent. If $1 <= p < 2$, then on $(0, 1]$
  $ abs(sin(1/x) / x^p) >= sin^2(1/x) / x^p = 1 / (2 x^p) - cos(2/x) / (2 x^p), $
  where
  $integral_0^1 cos(2/x) / x^p dif x = integral_1^(+oo) cos 2 t dot t^(p - 2) dif t$
  converges by Dirichlet's test while $integral_0^1 dif x / (2 x^p)$ diverges
  for $p >= 1$; hence the integral is only conditionally convergent.
  In summary, the integral is absolutely convergent for $p < 1$ and
  conditionally convergent for $1 <= p < 2$.
]

#note(title: "Sums and Differences of Improper Integrals")[
  + absolutely convergent $plus.minus$ absolutely convergent = absolutely
    convergent;
  + absolutely convergent $plus.minus$ conditionally convergent =
    conditionally convergent;
  + if one summand diverges, the sum diverges unless an exact cancellation
    occurs.
]

#example(name: "An Exercise on the Logarithmic Integral")[
  Show that the improper integral
  $ integral_0^1 ln x / (1 - x^2) dif x $
  converges, and compute its value.
] <ex:logarithmic-integral>

== Special Integrals // 特殊积分

=== Definite Integrals // 特殊定积分

#example(name: "The Dirichlet Kernel")[
  Show that for every $n in bb(N)$,
  $ integral_0^pi sin((n + 1/2) x) / sin(x/2) dif x = pi. $
  The integrand $D_n (x) = sin((n + 1/2) x) / sin(x/2)$ is called the
  *Dirichlet kernel*.
] <ex:dirichlet-kernel>

#solution[
  Since $lim_(x -> 0) D_n (x) = 2 n + 1$ is finite, the integrand extends
  continuously to $[0, pi]$ and the integral is proper. The identity
  $ 2 sin(x/2) (1/2 + sum_(k=1)^n cos k x) = sin((n + 1/2) x) $
  follows by telescoping, since
  $2 sin(x/2) cos k x = sin((k + 1/2) x) - sin((k - 1/2) x)$. Hence
  $ 1/2 D_n (x) = 1/2 + sum_(k=1)^n cos k x, $
  and integrating term by term over $[0, pi]$ — each term satisfies
  $integral_0^pi cos k x dif x = (sin(k pi))/k = 0$ — yields
  $ integral_0^pi D_n (x) dif x = 2 (1/2 dot pi) = pi. $
]

#example(name: "The Fejér Integral")[
  For every $n in bb(N)$,
  $ integral_0^pi ((sin(n x/2)) / (sin(x/2)))^2 dif x = n pi. $
] <ex:fejer-integral>

=== Improper Integrals // 特殊反常积分

#example(name: "The Euler Integral")[
  Show that
  $ I = integral_0^(pi/2) ln sin x dif x = -pi/2 ln 2. $
] <ex:euler-integral>

#solution[
  The integral converges: near $x = 0$, $ln sin x tilde.op ln x$ and
  $integral_0^epsilon abs(ln x) dif x$ converges. The substitution $x = 2 t$
  gives
  $
    I & = 2 integral_0^(pi/4) ln sin 2 t dif t
        = 2 integral_0^(pi/4) ln(2 sin t cos t) dif t \
      & = pi/2 ln 2 + 2 integral_0^(pi/4) ln sin t dif t
        + 2 integral_0^(pi/4) ln cos t dif t.
  $
  The substitution $t = pi/2 - u$ transforms the last integral into
  $2 integral_(pi/4)^(pi/2) ln sin t dif t$. Therefore
  $
    I = pi/2 ln 2 + 2 (integral_0^(pi/4) + integral_(pi/4)^(pi/2)) ln sin t dif t
    = pi/2 ln 2 + 2 I,
  $
  and solving for $I$ yields $I = -pi/2 ln 2$.
]

#example(name: "The Froullani Integral")[
  Let $f(x)$ be continuous on $(0, +oo)$ with both limits $f(0)$ and
  $f(+oo)$ existing (finite), and let $a, b > 0$. Then the integral
  $ integral_0^(+oo) (f(a x) - f(b x)) / x dif x $
  converges and equals $[f(0) - f(+oo)] ln(b/a)$.
] <ex:froullani-integral>

#example(name: "The Dirichlet Integral")[
  Show that
  $ integral_0^(+oo) sin x / x dif x = pi/2. $
] <ex:dirichlet-integral>

#solution[
  The integral converges conditionally by
  #link(<thm:abel-dirichlet-infinite-integral>)[Dirichlet's test], since
  $1/x -> 0$ monotonically and $abs(integral_0^A sin x dif x) <= 2$.
  By #link(<ex:dirichlet-kernel>)[the Dirichlet kernel integral],
  $ integral_0^pi sin((n + 1/2) x) / (2 sin(x/2)) dif x = pi/2 quad (n in bb(N)). $
  Compare $1/x$ with $1/(2 sin(x/2))$: the difference
  $ f(x) = 1/x - 1/(2 sin(x/2)) = O(x) quad (x -> 0) $
  — indeed $2 sin(x/2) - x = O(x^3)$ — so $f$ extends continuously to
  $[0, pi]$ with $f(0) = 0$. By the Riemann-Lebesgue lemma (if
  $h in R[0, pi]$, then
  $lim_(lambda -> +oo) integral_0^pi h(x) sin(lambda x) dif x = 0$),
  $ lim_(n -> oo) integral_0^pi f(x) sin((n + 1/2) x) dif x = 0. $
  Consequently,
  $
    lim_(n -> oo) integral_0^pi sin((n + 1/2) x) / x dif x
    & = lim_(n -> oo) integral_0^pi sin((n + 1/2) x) / (2 sin(x/2)) dif x \
    & = pi/2.
  $
  On the other hand, the substitution $t = (n + 1/2) x$ gives
  $ integral_0^pi sin((n + 1/2) x) / x dif x = integral_0^((n + 1/2) pi) sin t / t dif t. $
  Letting $n -> oo$ and using the convergence of
  $integral_0^(+oo) sin t / t dif t$, we conclude
  $integral_0^(+oo) sin t / t dif t = pi/2$.
]

#example(name: "The Euler-Poisson Integral")[
  $ integral_0^(+oo) e^(-x^2) dif x = sqrt(pi) / 2. $
] <ex:euler-poisson-integral>

#example(name: "The Poisson Integral")[
  For $0 < r < 1$, the *Poisson integral* is
  $ integral_(-pi)^pi (1 - r^2) / (1 - 2 r cos x + r^2) dif x. $
] <ex:poisson-integral>

#example(name: "A Special Oscillatory Integral")[
  For $a > b > 0$ with $b$ even, consider
  $ integral_0^(+oo) (dif x) / (1 + x^a sin^b x). $
  The case $a = 6, b = 2$ is depicted in
  #link(<fig:special-integral-graph>)[the figure below].
] <ex:special-oscillatory-integral>

#figure(
  image("img/xsinx.png", width: 80%),
  caption: [Graph of $y = 1 / (1 + x^6 sin^2 x)$.],
) <fig:special-integral-graph>

#example(name: "Discrete Form of the Gamma Function")[
  For every non-negative integer $n$, show that
  $ I_n = integral_0^(+oo) e^(-x) x^n dif x = n!. $
] <ex:gamma-discrete>

#solution[
  For $n = 0$, $I_0 = integral_0^(+oo) e^(-x) dif x = 1$ directly from the
  definition. For $n >= 1$, integration by parts gives
  $ I_n = (-e^(-x) x^n) |_0^(+oo) + n integral_0^(+oo) e^(-x) x^(n - 1) dif x = n I_(n - 1), $
  since $x^n e^(-x) -> 0$ as $x -> +oo$ and the lower limit contributes 0.
  Induction yields $I_n = n!$ for all $n$.
]

== Common Questions // 常见问题

=== Square Integrable // 平方可积

#definition(name: "Square Integrable Function")[
  If $f(x) in R[a, +oo)$ and
  $ integral_a^(+oo) f^2 (x) dif x $
  converges, then $f(x)$ is called a *square integrable function* on
  $[a, +oo)$. For defective integrals the definition is similar.
] <def:square-integrable>

For one-variable functions, the relationships among the integrability of
$f(x)$, $abs(f(x))$ and $f^2 (x)$ are depicted in
#link(<fig:integrability-relationships>)[the diagram below] and made precise
by the following proposition.

#figure(
  image("img/rela.png", width: 90%),
  caption: [Relationships among integrability, absolute integrability, and square integrability.],
) <fig:integrability-relationships>

#proposition(name: "Relations among Integrability, Absolute Integrability and Square Integrability")[
  + Integrability and square integrability imply neither the other.
  + For infinite integrals, square integrability and absolute integrability
    imply neither the other.
  + For defective integrals, square integrability implies absolute
    integrability, but not conversely.
] <prop:square-integrable-relations>

#proof[
  + *Integrable but not square integrable.* For the infinite integral take
    $f(x) = n^2$ on $[n, n + 1/n^4)$ and $f(x) = 0$ on
    $[n + 1/n^4, n + 1)$ for $n = 1, 2, dots.c$. Then
    $
      integral_1^(+oo) f(x) dif x = sum_(n=1)^oo n^2 dot 1/n^4 = sum_(n=1)^oo 1/n^2 < +oo,
      quad integral_1^(+oo) f^2 (x) dif x = sum_(n=1)^oo n^4 dot 1/n^4 = sum_(n=1)^oo 1 = +oo.
    $
    For the defective integral take $f(x) = 1/sqrt(x)$ on $(0, 1]$:
    $integral_0^1 f(x) dif x = 2 < +oo$ but
    $integral_0^1 f^2 (x) dif x = integral_0^1 dif x / x = +oo$.
  + *Square integrable but not integrable.* Take $f(x) = 1/x$ on $(1, +oo)$:
    $integral_1^(+oo) dif x / x^2$ converges while
    $integral_1^(+oo) dif x / x$ diverges.
  + *Square integrable but not absolutely integrable (infinite case).* Take
    $f(x) = sin x / x$ on $(1, +oo)$: the integral converges conditionally
    (item 1 of #link(<ex:improper-convergence>)[the example above]), yet
    $integral_1^(+oo) sin^2 x / x dif x$ diverges by the same computation.
  + *Absolutely integrable but not square integrable.* Take $f(x) = n$ on
    $union_(n=2)^oo [n, n + 1/n^3]$ and $f(x) = 0$ elsewhere. Then
    $integral_1^(+oo) abs(f(x)) dif x = sum_(n=2)^oo n dot 1/n^3 = sum_(n=2)^oo 1/n^2 < +oo$
    while
    $integral_1^(+oo) f^2 (x) dif x = sum_(n=2)^oo n^2 dot 1/n^3 = sum_(n=2)^oo 1/n = +oo$.
    A smooth alternative on $(0, +oo)$ is $f(x) = x / (1 + x^6 sin^2 x)$.
  + *Square integrable implies absolutely integrable (defective case).*
    Since $abs(f(x)) <= (1 + f^2 (x)) / 2$ and the interval $[a, b]$ is
    finite,
    $ integral_a^b abs(f(x)) dif x <= (b - a)/2 + 1/2 integral_a^b f^2 (x) dif x < +oo. $
    (On an infinite interval this argument breaks down — the constant $1$ is
    no longer integrable — which is exactly why item 2 above is possible.)
    The converse fails: $f(x) = 1/sqrt(x)$ on $(0, 1]$ is absolutely
    integrable but not square integrable, as computed above.
]

=== Behaviour of the Integrand at Infinity // 无穷远处的性质

Convergence of an improper integral does not force the integrand to vanish at
infinity. For the convergent integral
$ integral_0^(+oo) (dif x) / (1 + x^6 sin^2 x) $
whose integrand is depicted in
#link(<fig:special-integral-graph>)[the figure of the previous section], the
integrand satisfies $f(k pi) = 1$ for every $k in bb(N)$, so $f(+oo)$ does
not exist — in particular it is not $0$. Even unbounded oscillation is
possible: the integrand $f(x) = x / (1 + x^6 sin^2 x)$ again yields a
convergent integral (one estimates the contribution of the $k$-th period as
$O(1/k^2)$), yet $f(k pi) = k pi -> +oo$, so
$limsup_(x -> +oo) f(x) = +oo$.

#proposition(name: "Vanishing at Infinity")[
  Let $integral_a^(+oo) f(x) dif x$ converge. If $lim_(x -> +oo) f(x)$ exists
  (as a finite number), then it must be equal to $0$.
] <prop:vanishing-at-infinity>

#theorem(name: "Uniform Continuity Criterion")[
  Let $integral_a^(+oo) f(x) dif x$ converge, and let $f(x)$ be uniformly
  continuous on $[a, +oo)$. Then $lim_(x -> +oo) f(x) = 0$.
] <thm:uniform-continuity-vanishing>

#proof[
  *First proof (by contradiction).* Suppose $f(x)$ does not tend to $0$:
  there exists $epsilon_0 > 0$ such that for every $A > 0$ some $x_1 > A$
  satisfies $abs(f(x_1)) > epsilon_0$. By uniform continuity there is
  $delta > 0$ such that $abs(x' - x'') < delta$ implies
  $abs(f(x') - f(x'')) < epsilon_0 / 2$. By the Cauchy criterion with
  $epsilon = epsilon_0 delta / 2$ there is $A_0 > max\{a, 0\}$ such that
  $abs(integral_(A')^(A'') f(x) dif x) < epsilon_0 delta / 2$ for all
  $A'' > A' > A_0$; in the negation above take $A = A_0$, obtaining
  $x_1 > A_0$. Then for every $x in [x_1, x_1 + delta]$,
  $ abs(f(x)) >= abs(f(x_1)) - abs(f(x) - f(x_1)) > epsilon_0 / 2, $
  and $f(x)$ has the same sign as $f(x_1)$: otherwise
  $abs(f(x) - f(x_1)) >= abs(f(x_1)) > epsilon_0 > epsilon_0 / 2$, contrary
  to the choice of $delta$. Without loss of generality assume $f > 0$ on
  $[x_1, x_1 + delta]$; then
  $ abs(integral_(x_1)^(x_1 + delta) f(x) dif x) >= epsilon_0 / 2 dot delta, $
  contradicting the Cauchy criterion with $A' = x_1$ and $A'' = x_1 + delta$.
  Hence $lim_(x -> +oo) f(x) = 0$.

  *Second proof (via the first mean value theorem).* Fix $epsilon > 0$. By
  uniform continuity there is $delta > 0$ such that
  $abs(f(x') - f(x'')) < epsilon$ whenever $abs(x' - x'') < delta$. By
  convergence and the Cauchy criterion there is $A_0 >= a$ such that for all
  $A'' > A > A_0$,
  $ abs(integral_A^(A'') f(x) dif x) < (epsilon delta) / 2. $
  Take $A'' = A + delta/2$: since $f$ is continuous (uniform continuity
  implies continuity), #link(<thm:integral-mean-value>)[the first integral
    mean value theorem] provides $xi in (A, A + delta/2)$ with
  $ abs(integral_A^(A + delta/2) f(x) dif x) = abs(f(xi)) dot delta/2, $
  whence $abs(f(xi)) < epsilon$. Since $abs(A - xi) < delta/2 < delta$,
  $ abs(f(A)) <= abs(f(A) - f(xi)) + abs(f(xi)) < 2 epsilon. $
  As $epsilon > 0$ was arbitrary, $lim_(x -> +oo) f(x) = 0$.
]

#example(name: "Further Behaviour at Infinity")[
  Prove the following statements.
  + If $integral_a^(+oo) f(x) dif x$ and $integral_a^(+oo) f'(x) dif x$ both
    converge and $f$ is continuously differentiable, then
    $lim_(x -> +oo) f(x) = 0$.
  + If $integral_a^(+oo) f(x) dif x$ converges and $f$ is monotone decreasing
    on $[a, +oo)$, then $lim_(x -> +oo) x f(x) = 0$.
  + If $integral_a^(+oo) f(x) dif x$ converges and $x f(x)$ is monotone
    decreasing on $[a, +oo)$, then $lim_(x -> +oo) x f(x) ln x = 0$.
] <ex:infinity-exercises>

// ✅ Part II 里程碑：ch01–ch07 全部迁移完成（B1–B7）

// --- Part III: 无穷级数 ---
#part("Infinite Series") // 无穷级数
// B8: ch08 Numerical Series（数项级数）
= Numerical Series // 数项级数

== Convergence of Numerical Series // 数项级数的收敛性

// §1 tex 为空节，从 md L14–30 回收级数基本概念

#definition(name: "Numerical Series and Its Convergence")[
  Let $x_1, x_2, dots, x_n, dots$ be a countable family of real numbers. The formal sum
  $
    x_1 + x_2 + dots.c + x_n + dots.c
  $
  is called a *numerical series*, denoted by $sum_(n=1)^oo x_n$, where $x_n$ is called the general term of the series.

  Let $S_n = sum_(k=1)^n x_k$. The sequence $(S_n)$ is called the *sequence of partial sums* of the series. If $(S_n)$ converges to a finite number $S$, then the series $sum_(n=1)^oo x_n$ is said to *converge*, and $S$ is called its *sum*, written $S = sum_(n=1)^oo x_n$. If $(S_n)$ diverges, then the series is said to *diverge*.
] <def:numerical-series>

#proposition(name: "Basic Properties of Convergent Series")[
  + *Necessary condition.* If $sum_(n=1)^oo x_n$ converges, then $lim_(n -> oo) x_n = 0$.
  + *Linearity.* If $sum_(n=1)^oo a_n$ and $sum_(n=1)^oo b_n$ both converge and $c in bb(R)$, then $sum_(n=1)^oo c a_n$ and $sum_(n=1)^oo (a_n plus.minus b_n)$ also converge, with
    $
      sum_(n=1)^oo c a_n = c sum_(n=1)^oo a_n, quad quad sum_(n=1)^oo (a_n plus.minus b_n) = sum_(n=1)^oo a_n plus.minus sum_(n=1)^oo b_n.
    $
  + *Finitely many terms.* Deleting or appending finitely many terms does not affect the convergence or divergence of a series.
  + *Associativity.* If $sum_(n=1)^oo x_n$ converges and its terms are grouped into brackets without changing their order, the resulting series
    $
      (x_1 + dots.c + x_(n_1)) + (x_(n_1 + 1) + dots.c + x_(n_2)) + dots.c
    $
    also converges and has the same sum. Conversely, if a bracketed series converges and within each bracket the terms have one and the same sign, then the original series also converges and has the same sum.
] <prop:series-basic-properties>

== Positive Term Series and Its Convergence Tests // 正项级数及其判别法

#definition(name: "Positive Term Series")[
  If all terms of the series $sum_(n=1)^oo x_n$ are non-negative real numbers, i.e., $x_n >= 0$ (respectively $x_n > 0$) for $n = 1, 2, dots$, then the series is called a *positive term series* (respectively a *strictly positive term series*).
] <def:positive-term-series>

#note[
  A positive term series converges if and only if the sequence of its partial sums is bounded. If the partial sums are unbounded, the series must diverge to $+oo$.
]

=== Comparison Tests // 比较判别法

#theorem(name: "Comparison Test")[
  Let $sum_(n=1)^oo a_n$ and $sum_(n=1)^oo b_n$ be positive term series.
  + *Basic form.* If there exists $N in bb(N)$ such that $a_n <= b_n$ for all $n > N$, then:
    + if $sum_(n=1)^oo b_n$ converges, then $sum_(n=1)^oo a_n$ also converges;
    + if $sum_(n=1)^oo a_n$ diverges, then $sum_(n=1)^oo b_n$ also diverges.
  + *Limit form.* Suppose
    $
      lim_(n -> oo) a_n / b_n = l quad quad ("allowing" \, l = +oo).
    $
    Then:
    + if $0 < l < +oo$, the two series converge or diverge simultaneously;
    + if $l = 0$ and $sum_(n=1)^oo b_n$ converges, then $sum_(n=1)^oo a_n$ also converges;
    + if $l = +oo$ and $sum_(n=1)^oo b_n$ diverges, then $sum_(n=1)^oo a_n$ also diverges.
] <thm:comparison-test-series>

=== Cauchy and d'Alembert Tests // Cauchy 判别法与 d'Alembert 判别法

#theorem(name: "Cauchy Test and d'Alembert Test")[
  + *Cauchy test (root test).* Let $sum_(n=1)^oo a_n$ be a positive term series.
    + If there exist $q in [0, 1)$ and $N in bb(N)$ such that $root(a_n, n) <= q < 1$ for all $n >= N$, then the series converges.
    + If $root(a_n, n) >= 1$ for infinitely many $n$, then the series diverges.
    + *Limit form.* If $limsup_(n -> +oo) root(a_n, n) = r$, then the series converges when $0 <= r < 1$ and diverges when $r > 1$; the test fails when $r = 1$.
  + *d'Alembert test (ratio test).* Let $sum_(n=1)^oo a_n$ be a strictly positive term series.
    + If there exist $q in [0, 1)$ and $N in bb(N)$ such that $a_(n+1) / a_n <= q < 1$ for all $n >= N$, then the series converges.
    + If $a_(n+1) / a_n >= 1$ for all $n >= N$, then the series diverges.
    + *Limit form.* The series converges if $limsup_(n -> +oo) a_(n+1) / a_n = r < 1$ and diverges if $liminf_(n -> +oo) a_(n+1) / a_n = r' > 1$; the test fails when $r = 1$ or $r' = 1$.
] <thm:cauchy-dalembert-tests>

#note[
  Theoretically the Cauchy test is stronger than the d'Alembert test, but the latter is sometimes more convenient to apply.
]

#proof[
  *Cauchy test.* If $root(a_n, n) <= q < 1$ for $n >= N$, then $a_n <= q^n$ for $n >= N$, and the series converges by comparison with the geometric series $sum_(n=1)^oo q^n$. If $root(a_n, n) >= 1$ for infinitely many $n$, then $a_n >= 1$ for infinitely many $n$, so $(a_n)$ does not tend to zero and the series diverges.

  For the limit form, let $r = limsup_(n -> +oo) root(a_n, n)$. If $r < 1$, choose $q$ with $r < q < 1$; by the property of the limit superior there exists $N$ such that $root(a_n, n) < q$ for all $n > N$, which reduces to the basic case. If $r > 1$, then $root(a_n, n) > 1$ for infinitely many $n$, which reduces to the second case. When $r = 1$ the test fails: $sum_(n=1)^oo 1 / n^2$ converges and $sum_(n=1)^oo 1 / n$ diverges, yet both have $r = 1$.

  *d'Alembert test.* The basic forms follow directly: if $a_(n+1) / a_n <= q < 1$ for $n >= N$, then $a_n <= a_N q^(n - N)$ for $n >= N$, and comparison with the geometric series yields convergence; if $a_(n+1) / a_n >= 1$ for $n >= N$, then $(a_n)$ is non-decreasing from index $N$ on with $a_n >= a_N > 0$, so $(a_n)$ does not tend to zero.

  For the limit form it suffices to establish the chain
  $
    liminf_(n -> +oo) a_(n+1) / a_n <= liminf_(n -> +oo) root(a_n, n) <= limsup_(n -> +oo) root(a_n, n) <= limsup_(n -> +oo) a_(n+1) / a_n:
  $
  the middle inequality is trivial, and the right inequality combined with the Cauchy limit form proves convergence whenever $limsup a_(n+1) / a_n < 1$. To prove the right inequality, set $bar(r) = limsup_(n -> +oo) a_(n+1) / a_n$. For every $epsilon > 0$ there exists $N$ such that $a_(n+1) / a_n < bar(r) + epsilon$ for all $n > N$. Iterating gives
  $
    a_n < (bar(r) + epsilon)^(n - N - 1) dot a_(N+1) quad quad (n > N + 1),
  $
  hence
  $
    limsup_(n -> +oo) root(a_n, n) <= limsup_(n -> +oo) root((bar(r) + epsilon)^(n - N - 1) a_(N+1), n) = bar(r) + epsilon.
  $
  Letting $epsilon -> 0^+$ completes the proof. For divergence, if $r' = liminf a_(n+1) / a_n > 1$, then $limsup root(a_n, n) >= liminf root(a_n, n) >= r' > 1$, and the Cauchy test yields divergence.
]

=== Raabe, Bertrand and Gauss Tests // Raabe、Bertrand 与 Gauss 判别法

#theorem(name: "Raabe and Bertrand Tests")[
  Let $sum_(n=1)^oo a_n$ be a strictly positive term series.
  + *Raabe test.*
    + If there exist $r > 1$ and $N_0 in bb(N)$ such that $n (a_n / a_(n+1) - 1) >= r$ for all $n > N_0$, then the series converges.
    + If there exists $N_0 in bb(N)$ such that $n (a_n / a_(n+1) - 1) <= 1$ for all $n > N_0$, then the series diverges.
    + *Limit form.* The series converges if $liminf_(n -> +oo) n (a_n / a_(n+1) - 1) = l > 1$, and diverges if $limsup_(n -> +oo) n (a_n / a_(n+1) - 1) = l' < 1$; the test fails when $l = 1$ or $l' = 1$.
  + *Bertrand test.* The series converges if
    $
      liminf_(n -> +oo) ln n [n (a_n / a_(n+1) - 1) - 1] = l > 1,
    $
    and diverges if $limsup_(n -> +oo) ln n [n (a_n / a_(n+1) - 1) - 1] = l' < 1$; the test fails when $l = 1$ or $l' = 1$.
] <thm:raabe-bertrand-tests>

#theorem(name: "Gauss Test")[
  Let $sum_(n=1)^oo a_n$ be a strictly positive term series, and suppose
  $
    a_n / a_(n+1) = 1 + 1/n + delta / (n ln n) + o(1 / (n ln n)) quad quad (n -> +oo).
  $
  Then the series converges when $delta > 1$, diverges when $delta < 1$, and the test fails when $delta = 1$.
] <thm:gauss-test>

#theorem(name: "Generalized Gauss Test")[
  Let $sum_(n=1)^oo a_n$ be a strictly positive term series, and suppose
  $
    a_n / a_(n+1) = 1 + 1/n + delta_n / (n ln n) + o(1 / (n ln n)) quad quad (n -> +oo),
  $
  where $lim_(n -> oo) delta_n = delta in bb(R)$. Then the series converges when $delta > 1$, diverges when $delta < 1$, and the test fails when $delta = 1$.
] <thm:generalized-gauss-test>

#proof(name: "of the Raabe test")[
  It suffices to prove the basic forms; the limit form follows by inserting any number strictly between $1$ and the corresponding limit inferior (resp. limit superior).

  *Convergence.* Assume $n (a_n / a_(n+1) - 1) >= r$ for $n > N_0$ with $r > 1$, and pick $alpha in (1, r)$. Since
  $
    lim_(n -> oo) ((1 + 1/n)^alpha - 1) / (1/n) = lim_(x -> 0) ((1 + x)^alpha - 1) / x = alpha < r,
  $
  for all sufficiently large $n$ we have $(1 + 1/n)^alpha < 1 + r / n$. Hence for $n > max{N_0, N}$,
  $
    a_n / a_(n+1) >= 1 + r / n > (1 + 1/n)^alpha = (n+1)^alpha / n^alpha,
  $
  i.e., $n^alpha a_n > (n+1)^alpha a_(n+1)$. Thus $(n^alpha a_n)$ is eventually decreasing and positive, hence bounded above: there exists $M > 0$ with $a_n <= M / n^alpha$ for all large $n$. Since $alpha > 1$, the series $sum_(n=1)^oo M / n^alpha$ converges, and the comparison test yields the convergence of $sum_(n=1)^oo a_n$.

  *Divergence.* Assume $n (a_n / a_(n+1) - 1) <= 1$ for $n > N_0$. Then $a_n / a_(n+1) <= 1 + 1/n = (n+1) / n$, i.e., $n a_n <= (n+1) a_(n+1)$: the sequence $(n a_n)_(n > N_0)$ is non-decreasing, so $n a_n >= N_0 a_(N_0) > 0$ and therefore
  $
    a_n >= N_0 a_(N_0) / n quad quad (n > N_0).
  $
  Since the harmonic series diverges, the comparison test yields the divergence of $sum_(n=1)^oo a_n$.
]

#note(title: "Refinements of the Bertrand Test")[
  Considering series such as
  $
    sum_(n=3)^oo 1 / (n ln n (ln ln n)^p), quad quad sum_(n=9)^oo 1 / (n ln n ln ln n (ln ln n)^p), quad quad dots.c,
  $
  one obtains ever finer tests of the same flavor, which are collectively known as the Bertrand tests.
]

#note(title: "Genealogy of the Tests")[
  All the criteria above are derived from the comparison test:
  - comparing positive term series with the geometric series yields the Cauchy test and the d'Alembert test;
  - comparing with the slower-converging series $sum_(n=1)^oo 1 / n^alpha$ ($alpha > 1$) yields the Raabe test;
  - comparing with the even slower-converging series $sum_(n=1)^oo 1 / (n ln^alpha n)$ ($alpha > 1$) yields the Gauss test.

  In general, the slower the convergence of the series used for comparison, the sharper the derived criterion.
]

=== Integral Test // 积分判别法

#theorem(name: "Cauchy Integral Test")[
  Let $f$ be defined on $[a, +oo)$ with $f(x) >= 0$, and Riemann integrable on every finite interval $[a, A]$. Let $(a_n)$ be a monotonically increasing sequence with
  $
    a = a_1 < a_2 < dots.c < a_n < dots.c,
  $
  and set $u_n = integral_(a_n)^(a_(n+1)) f(x) dif x$. Then the improper integral $integral_a^(+oo) f(x) dif x$ and the positive term series $sum_(n=1)^oo u_n$ converge or diverge to $+oo$ simultaneously, and moreover
  $
    integral_a^(+oo) f(x) dif x = sum_(n=1)^oo u_n = sum_(n=1)^oo integral_(a_n)^(a_(n+1)) f(x) dif x.
  $
] <thm:cauchy-integral-test-series>

#proof[
  Let $(S_n)$ be the sequence of partial sums of $sum_(n=1)^oo u_n$. For every $A > a$ there exists $n in bb(N)$ with $a_n <= A < a_(n+1)$, whence
  $
    S_(n-1) <= integral_a^A f(x) dif x <= S_n.
  $
  If $(S_n)$ is bounded, i.e., $sum_(n=1)^oo u_n$ converges, then $A mapsto integral_a^A f(x) dif x$ is increasing and bounded above, so the improper integral converges and, by the squeeze theorem, shares the limit of $(S_n)$.
  If $(S_n)$ is unbounded, i.e., $sum_(n=1)^oo u_n$ diverges to $+oo$, then $integral_a^A f(x) dif x >= S_(n-1) -> +oo$ as $A -> +oo$. This proves the equivalence and the identity $integral_a^(+oo) f(x) dif x = sum_(n=1)^oo u_n$.

  In particular, when $f$ is monotonically decreasing take $a_n = n$. For $n >= N = floor(a) + 1$ one has
  $
    f(n+1) <= u_n = integral_n^(n+1) f(x) dif x <= f(n),
  $
  so by the comparison test $sum_(n=1)^oo f(n)$ and $sum_(n=1)^oo u_n$ share the same convergence behavior.
]

=== Cauchy Condensation Test // Cauchy 凝聚判别法

#theorem(name: "Cauchy Condensation Test")[
  Let $(a_n)$ be a monotonically decreasing sequence of positive numbers. Then the positive term series $sum_(n=1)^oo a_n$ converges if and only if the condensed series
  $
    sum_(n=0)^oo 2^n a_(2^n) = a_1 + 2 a_2 + 4 a_4 + dots.c + 2^n a_(2^n) + dots.c
  $
  converges.
] <thm:cauchy-condensation>

#proof[
  Grouping the terms of a positive term series into brackets does not affect its convergence. Since $(a_n)$ is decreasing,
  $
    sum_(n=1)^oo a_n & = a_1 + (a_2 + a_3) + (a_4 + dots.c + a_7) + dots.c \
                     & <= a_1 + 2 a_2 + 4 a_4 + dots.c = sum_(n=0)^oo 2^n a_(2^n),
  $
  while
  $
    sum_(n=1)^oo a_n & = a_1 + a_2 + (a_3 + a_4) + (a_5 + dots.c + a_8) + dots.c \
                     & >= a_1 + a_2 + 2 a_4 + 4 a_8 + dots.c = a_1 + 1/2 sum_(n=1)^oo 2^n a_(2^n).
  $
  Hence each of the two series controls the other up to a constant factor, and they converge or diverge simultaneously.
]

== General Term Series and Its Convergence Tests // 一般项级数及其判别法

=== Cauchy Convergence Criterion // 级数的 Cauchy 收敛准则

#theorem(name: "Cauchy Convergence Criterion for Series")[
  The necessary and sufficient condition for the convergence of the series $sum_(n=1)^oo x_n$ is:
  $
    forall epsilon > 0, exists N in bb(N), forall m > n > N:
    |x_(n+1) + x_(n+2) + dots.c + x_m| = |sum_(k=n+1)^m x_k| < epsilon.
  $
] <thm:cauchy-criterion-series>

=== Alternating Series and the Leibniz Test // 交错级数与 Leibniz 判别法

#definition(name: "Alternating Series and Leibniz Series")[
  A series of the form
  $
    sum_(n=1)^oo x_n = sum_(n=1)^oo (-1)^(n-1) u_n quad quad (u_n > 0)
  $
  is called an *alternating series*. If moreover $(u_n)$ is monotonically decreasing and $lim_(n -> oo) u_n = 0$, then the series is called a *Leibniz series*.
] <def:alternative-series>

#theorem(name: "Leibniz Test")[
  Every Leibniz series converges.
] <thm:leibniz-test>

#proof[
  We verify the Cauchy criterion. For $p in bb(N)^+$,
  $
    |x_(n+1) + x_(n+2) + dots.c + x_(n+p)| = |u_(n+1) - u_(n+2) + u_(n+3) - dots.c + (-1)^(p+1) u_(n+p)|.
  $
  If $p$ is odd, this quantity equals
  $
    (u_(n+1) - u_(n+2)) + (u_(n+3) - u_(n+4)) + dots.c + (u_(n+p-2) - u_(n+p-1)) + u_(n+p) > 0,
  $
  and also $u_(n+1) - (u_(n+2) - u_(n+3)) - dots.c - (u_(n+p-1) - u_(n+p)) <= u_(n+1)$. If $p$ is even, it equals
  $
    (u_(n+1) - u_(n+2)) + dots.c + (u_(n+p-1) - u_(n+p)) >= 0,
  $
  and also $u_(n+1) - (u_(n+2) - u_(n+3)) - dots.c - u_(n+p) < u_(n+1)$. In both cases the monotonicity of $(u_n)$ is used, and
  $
    |x_(n+1) + x_(n+2) + dots.c + x_(n+p)| <= u_(n+1)
  $
  holds for all $p in bb(N)^+$. Since $u_n -> 0$, for every $epsilon > 0$ there exists $N$ such that $u_(n+1) < epsilon$ for all $n > N$; hence $|sum_(k=n+1)^(n+p) x_k| < epsilon$ for all $p$, and the Cauchy criterion yields convergence.
]

=== Abel Transform and the Abel-Dirichlet Tests // Abel 变换与 Abel-Dirichlet 判别法

#theorem(name: "Abel Transform (Discrete Integration by Parts / Summation by Parts)")[
  Let $(a_n)$ and $(b_n)$ be two sequences, and set $B_k = sum_(i=1)^k b_i$. Then for any $p in bb(N)^+$,
  $
    sum_(k=1)^p a_k b_k = a_p B_p - sum_(k=1)^(p-1) (a_(k+1) - a_k) B_k.
  $
] <thm:abel-transform>

#align(center, rotate(-180deg, image("img/AbelTransform.jpg", width: 50%)))

#proof[
  Since $b_k = B_k - B_(k-1)$ (with the convention $B_0 = 0$),
  $
    sum_(k=1)^p a_k b_k & = a_1 B_1 + sum_(k=2)^p a_k (B_k - B_(k-1)) \
                        & = a_1 B_1 + sum_(k=2)^p a_k B_k - sum_(k=2)^p a_k B_(k-1) \
                        & = sum_(k=1)^(p-1) a_k B_k - sum_(k=1)^(p-1) a_(k+1) B_k + a_p B_p \
                        & = a_p B_p - sum_(k=1)^(p-1) (a_(k+1) - a_k) B_k.
  $
]

#lemma(name: "Abel Lemma (Discrete Second Integral Mean Value Theorem)")[
  Let $(a_n)$, $(b_n)$ be two sequences such that $(a_n)$ is monotonic and $(B_k) = (sum_(i=1)^k b_i)$ is bounded, say $|B_k| <= M$. Then for any $p in bb(N)^+$,
  $
    |sum_(k=1)^p a_k b_k| <= M (|a_1| + 2 |a_p|).
  $
] <lem:abel-lemma>

#proof[
  By the Abel transform,
  $
    |sum_(k=1)^p a_k b_k| <= |a_p B_p| + sum_(k=1)^(p-1) |a_(k+1) - a_k| dot |B_k| <= M (|a_p| + sum_(k=1)^(p-1) |a_(k+1) - a_k|).
  $
  Since $(a_n)$ is monotonic, the differences $a_(k+1) - a_k$ all have the same sign, so
  $
    sum_(k=1)^(p-1) |a_(k+1) - a_k| = |sum_(k=1)^(p-1) (a_(k+1) - a_k)| = |a_p - a_1|.
  $
  Combining the two estimates,
  $
    |sum_(k=1)^p a_k b_k| <= M (|a_p| + |a_p - a_1|) <= M (|a_1| + 2 |a_p|).
  $
]

#theorem(name: "Abel-Dirichlet Test")[
  The series $sum_(n=1)^oo a_n b_n$ converges provided one of the following two conditions is satisfied:
  + *Abel.* $(a_n)$ is a bounded monotonic sequence and $sum_(n=1)^oo b_n$ converges.
  + *Dirichlet.* $(a_n)$ is a monotonic sequence with $lim_(n -> oo) a_n = 0$, and the partial sums $B_n = sum_(k=1)^n b_k$ are bounded.
] <thm:abel-dirichlet-series>

#proof[
  + *Abel.* Let $|a_n| <= M$. Since $sum_(n=1)^oo b_n$ converges, for every $epsilon > 0$ there exists $N$ such that $|sum_(k=n+1)^(n+p) b_k| < epsilon$ for all $n > N$ and all $p in bb(N)^+$. Applying the Abel lemma to the tails, whose $b$-partial sums are bounded by $epsilon$,
    $
      |sum_(k=n+1)^(n+p) a_k b_k| < epsilon (|a_(n+1)| + 2 |a_(n+p)|) <= 3 M epsilon.
    $
  + *Dirichlet.* Since $a_n -> 0$, for every $epsilon > 0$ there exists $N$ with $|a_n| < epsilon$ for all $n > N$. Let $|sum_(i=1)^n b_i| <= M$ for all $n$, and put $B'_k = sum_(i=n+1)^(n+k) b_i$ ($k = 1, dots, p$). Then
    $
      |B'_k| = |sum_(i=1)^(n+k) b_i - sum_(i=1)^n b_i| <= 2 M,
    $
    and the Abel lemma gives
    $
      |sum_(k=n+1)^(n+p) a_k b_k| < 2 M (|a_(n+1)| + 2 |a_(n+p)|) <= 6 M epsilon.
    $
  In both cases the Cauchy convergence criterion for series yields the convergence of $sum_(n=1)^oo a_n b_n$.
]

#example(name: "Convergence of $sum_(n=1)^oo a_n sin n x$")[
  Let $(a_n)$ be monotonic with $lim_(n -> oo) a_n = 0$. Show that the series $sum_(n=1)^oo a_n sin n x$ converges for every real number $x$.
] <ex:ad-test-application>

#solution[
  If $x = 2 k pi$ for some $k in bb(Z)$, every term vanishes and the series converges trivially. Assume $x$ is not an integral multiple of $2 pi$. Telescoping gives, for all $n in bb(N)^+$,
  $
    2 sin(x/2) dot sum_(k=1)^n sin k x = cos(x/2) - cos((2n+1) x / 2),
  $
  hence $|sum_(k=1)^n sin k x| <= 1 / |sin(x/2)|$ for all $n$: the partial sums of $(sin n x)$ are bounded. By the Dirichlet test (applied with $b_n = sin n x$), the series converges.
]

== Absolute and Conditional Convergence // 绝对收敛与条件收敛

#definition(name: "Absolute and Conditional Convergence of Series")[
  If the series $sum_(n=1)^oo |x_n|$ converges, then the series $sum_(n=1)^oo x_n$ is said to be *absolutely convergent*.

  If the series $sum_(n=1)^oo x_n$ converges but is not absolutely convergent, then $sum_(n=1)^oo x_n$ is said to be *conditionally convergent*.
] <def:abs-cond-convergence-series>

#note[
  Absolute convergence implies convergence: by the triangle inequality, $|sum_(k=n+1)^m x_k| <= sum_(k=n+1)^m |x_k|$, so the Cauchy criterion transfers from $sum |x_n|$ to $sum x_n$. Consequently, for a conditionally convergent series one always has $sum_(n=1)^oo |x_n| = +oo$.
]

=== Positive and Negative Derived Series // 正负导出级数

#definition(name: "Positive and Negative Derived Series")[
  For a series $sum_(n=1)^oo a_n$, the *positive derived series* $sum_(n=1)^oo a_n^+$ and the *negative derived series* $sum_(n=1)^oo a_n^-$ are defined by
  $
    a_n^+ = (|a_n| + a_n) / 2 = cases(a_n comma & a_n > 0, 0 comma & a_n <= 0), quad quad a_n^- = (|a_n| - a_n) / 2 = cases(-a_n comma & a_n < 0, 0 comma & a_n >= 0):
  $
  $a_n^+$ collects the positive terms of $(a_n)$, while $a_n^-$ collects the absolute values of the negative terms.
] <def:positive-derived-series>

#proposition(name: "Properties of the Derived Series")[
  The decompositions
  $
    sum_(n=1)^oo x_n = sum_(n=1)^oo x_n^+ - sum_(n=1)^oo x_n^-, quad quad sum_(n=1)^oo |x_n| = sum_(n=1)^oo x_n^+ + sum_(n=1)^oo x_n^-
  $
  hold in the extended sense (the two sides are simultaneously finite or $+oo$). Moreover:
  + If $sum_(n=1)^oo x_n$ converges absolutely, then both $sum_(n=1)^oo x_n^+$ and $sum_(n=1)^oo x_n^-$ converge.
  + If $sum_(n=1)^oo x_n$ converges conditionally, then both $sum_(n=1)^oo x_n^+$ and $sum_(n=1)^oo x_n^-$ diverge to $+oo$.
] <prop:derived-series-properties>

#proof[
  For the first assertion, note that $0 <= x_n^+ <= |x_n|$ and $0 <= x_n^- <= |x_n|$; since $sum_(n=1)^oo |x_n|$ converges, both derived series converge by the comparison test.

  For the second assertion, suppose $sum_(n=1)^oo x_n$ converges conditionally and assume, for contradiction, that $sum_(n=1)^oo x_n^+$ converges. Then from $sum x_n^- = sum x_n^+ - sum x_n$ the series $sum_(n=1)^oo x_n^-$ would converge as well, whence $sum_(n=1)^oo |x_n| = sum x_n^+ + sum x_n^-$ would converge, contradicting the hypothesis. Hence $sum_(n=1)^oo x_n^+ = +oo$, and the same argument shows $sum_(n=1)^oo x_n^- = +oo$.
]

=== Rearrangements of Series // 级数的更序与重排

#definition(name: "Rearranged Series")[
  Let $sum_(n=1)^oo a_n$ be a series and let $phi: bb(N)^+ -> bb(N)^+$ be a bijection. The series $sum_(n=1)^oo a_(phi(n))$ is called a *rearrangement* of $sum_(n=1)^oo a_n$, denoted by $sum_(n=1)^oo a_n'$.
] <def:rearranged-series>

#theorem(name: "Commutativity for Absolutely Convergent Series")[
  If $sum_(n=1)^oo x_n$ converges absolutely, then every rearrangement $sum_(n=1)^oo x_n'$ also converges absolutely and has the same sum:
  $
    sum_(n=1)^oo x_n' = sum_(n=1)^oo x_n.
  $
] <thm:commutative-absolute-series>

#proof[
  + First suppose $sum_(n=1)^oo x_n$ is a positive term series. For every $n$, the partial sum $sum_(k=1)^n x_k'$ consists of terms drawn from $(x_k)$, so
    $
      sum_(k=1)^n x_k' <= sum_(k=1)^oo x_k,
    $
    which shows that $sum x_n'$ converges with $sum x_n' <= sum x_n$. Conversely, $sum_(n=1)^oo x_n$ is itself a rearrangement of $sum_(n=1)^oo x_n'$, so $sum x_n <= sum x_n'$. Therefore the two sums coincide.
  + Now suppose $sum_(n=1)^oo x_n$ is an absolutely convergent series with terms of arbitrary sign. Then $sum x_n^+$ and $sum x_n^-$ converge, with
    $
      sum x_n = sum x_n^+ - sum x_n^-, quad quad sum |x_n| = sum x_n^+ + sum x_n^-.
    $
    For the rearrangement, form $sum x_n'^+$ and $sum x_n'^-$; since $x_n'^+ = x_(phi(n))^+$ and $x_n'^- = x_(phi(n))^-$, these are rearrangements of $sum x_n^+$ and $sum x_n^-$ respectively. By the positive term case,
    $
      sum x_n'^+ = sum x_n^+, quad quad sum x_n'^- = sum x_n^-.
    $
    Hence $sum_(n=1)^oo |x_n'| = sum x_n'^+ + sum x_n'^- = sum x_n^+ + sum x_n^- < +oo$, so $sum x_n'$ converges absolutely, and
    $
      sum_(n=1)^oo x_n' = sum x_n'^+ - sum x_n'^- = sum x_n^+ - sum x_n^- = sum_(n=1)^oo x_n.
    $
]

#theorem(name: "Riemann Rearrangement Theorem")[
  Let $sum_(n=1)^oo x_n$ be conditionally convergent. Then for every $a$ with $-oo <= a <= +oo$ there exists a rearrangement $sum_(n=1)^oo x_n'$ of $sum_(n=1)^oo x_n$ such that
  $
    sum_(n=1)^oo x_n' = a.
  $
] <thm:riemann-rearrangement>

#proof[
  By #link(<prop:derived-series-properties>)[the properties of the derived series], conditional convergence yields
  $
    sum_(n=1)^oo x_n^+ = sum_(n=1)^oo x_n^- = +oo, quad quad lim_(n -> oo) x_n^+ = lim_(n -> oo) x_n^- = 0.
  $

  *The case of finite $a$.* Add the positive terms $x_1^+, x_2^+, dots$ in their original order until the running sum first exceeds $a$: there is a smallest $n_1$ with $x_1^+ + dots.c + x_(n_1)^+ > a$. Then subtract the absolute values of the negative terms $x_1^-, x_2^-, dots$ in their original order until the sum first drops below $a$: there is a smallest $m_1$ with
  $
    x_1^+ + dots.c + x_(n_1)^+ - x_1^- - dots.c - x_(m_1)^- < a.
  $
  Continuing in the same way produces indices $n_1 < n_2 < dots.c$ and $m_1 < m_2 < dots.c$ such that after the $k$-th round the partial sum lies between $a - x_(m_k)^-$ and $a + x_(n_k)^+$. The resulting series is a rearrangement of $sum_(n=1)^oo x_n$ whose partial sums oscillate around $a$ with amplitude $max{x_(n_k)^+, x_(m_k)^-} -> 0$ as $k -> oo$; hence its sum equals $a$.

  *The cases $a = plus.minus oo$.* The construction is analogous: for $a = +oo$ one inserts blocks of positive terms large enough to push the partial sums to $+oo$, adding negative terms only to keep the process running; the case $a = -oo$ is symmetric.
]

=== Products of Series // 级数的乘法

#definition(name: "Products of Series")[
  Given two series $sum_(n=1)^oo a_n$ and $sum_(n=1)^oo b_n$, arrange all products $a_i b_j$ ($i, j = 1, 2, dots$) into the infinite matrix
  $
    mat(a_1 b_1, a_1 b_2, a_1 b_3, dots.c; a_2 b_1, a_2 b_2, a_2 b_3, dots.c; a_3 b_1, a_3 b_2, a_3 b_3, dots.c; dots.v, dots.v, dots.v, dots.v).
  $
  Since a series is not invariant under rearrangement of its terms, the sum depends on the order in which the products are added. Two classical arrangements are:
  + *Diagonal arrangement (Cauchy product).* Set $c_n = sum_(i+j=n+1) a_i b_j$, i.e., $c_1 = a_1 b_1$, $c_2 = a_1 b_2 + a_2 b_1$, and so on. The series $sum_(n=1)^oo c_n$ is called the *Cauchy product* of the two series. Convergence of $sum_(n=1)^oo a_n$ and $sum_(n=1)^oo b_n$ alone does not guarantee convergence of the Cauchy product.
  + *Square arrangement.* Set
    $
      d_n = a_1 b_n + dots.c + a_n b_n + a_n b_(n-1) + dots.c + a_n b_1 = (sum_(i=1)^n a_i) b_n + a_n (sum_(j=1)^(n-1) b_j).
    $
    Whenever $sum_(n=1)^oo a_n$ and $sum_(n=1)^oo b_n$ converge, the series $sum_(n=1)^oo d_n$ converges and
    $
      sum_(n=1)^oo d_n = (sum_(n=1)^oo a_n)(sum_(n=1)^oo b_n).
    $
] <def:series-product>

#theorem(name: "Product of Absolutely Convergent Series")[
  If $sum_(n=1)^oo a_n$ and $sum_(n=1)^oo b_n$ are both absolutely convergent, then the series obtained by arranging the products $a_i b_j$ ($i, j = 1, 2, dots$) in any order is absolutely convergent, and its sum equals
  $
    (sum_(n=1)^oo a_n)(sum_(n=1)^oo b_n).
  $
] <thm:absolute-convergence-product>

== Comparison of Convergence Speed of Series // 级数收敛速度的比较

The series $sum_(n=1)^oo a_n$ is said to converge /faster/ than the series $sum_(n=1)^oo b_n$ if
$
  lim_(n -> oo) a_n / b_n = 0.
$

#theorem(name: "Du Bois-Reymond Theorem")[
  For a given convergent positive term series $sum_(n=1)^oo a_n$, there always exists a convergent strictly positive term series $sum_(n=1)^oo b_n$ such that
  $
    lim_(n -> oo) a_n / b_n = 0.
  $
] <thm:du-bois-reymond-theorem>

#theorem(name: "Abel Theorem")[
  For a given divergent positive term series $sum_(n=1)^oo a_n$, there always exists a divergent positive term series $sum_(n=1)^oo b_n$ such that
  $
    lim_(n -> oo) b_n / a_n = 0.
  $
] <thm:abel-divergence-speed>

#note[
  The above two theorems imply that neither the slowest converging nor the slowest diverging positive term series exists.
]

== Infinite Products // 无穷乘积

=== Infinite Products // 无穷乘积（tex 空壳 leftbarTitle 升级；定义与收敛判别从 md 回收）

#definition(name: "Infinite Product")[
  Let $p_1, p_2, dots, p_n, dots$ ($p_n != 0$) be a countable sequence of real numbers. The product
  $
    p_1 dot p_2 dots.c p_n dots.c
  $
  is called an /infinite product/, denoted by $product_(n=1)^oo p_n$, and $p_n$ is called the general term of the product.

  Let $P_n = product_(k=1)^n p_k$; the sequence $(P_n)$ is called the sequence of partial products. If $(P_n)$ converges to a non-zero finite number $P$, then the infinite product is said to converge, and $P$ is called its product, written $product_(n=1)^oo p_n = P$. If $(P_n)$ diverges or converges to $0$, then the infinite product is said to diverge.
] <def:infinite-product>

#theorem(name: "Criterion for Convergence of Infinite Products")[
  Let $p_n > 0$ for all $n$. Then the infinite product $product_(n=1)^oo p_n$ converges if and only if the series $sum_(n=1)^oo ln p_n$ converges.
] <thm:infinite-product-criterion>

#corollary(name: "First-Order Criterion")[
  Let $a_n > 0$ or $-1 < a_n < 0$ for all $n$. Then the infinite product $product_(n=1)^oo (1 + a_n)$ converges if and only if the series $sum_(n=1)^oo a_n$ converges.
] <cor:infinite-product-first>

#corollary(name: "Second-Order Criterion")[
  Let $a_n > -1$ for all $n$, and suppose $sum_(n=1)^oo a_n$ converges. Then the infinite product $product_(n=1)^oo (1 + a_n)$ converges if and only if the series $sum_(n=1)^oo a_n^2$ converges.
] <cor:infinite-product-second>

#definition(name: "Absolute Convergence of Infinite Products")[
  When the series $sum_(n=1)^oo ln p_n$ converges absolutely, the infinite product $product_(n=1)^oo p_n$ is said to converge absolutely.
] <def:abs-convergence-infinite-product>

#proposition(name: "Equivalences for Absolute Convergence")[
  Let $a_n > -1$ ($n = 1, 2, dots$). Then the following three statements are equivalent:
  + the infinite product $product_(n=1)^oo (1 + a_n)$ converges absolutely;
  + the infinite product $product_(n=1)^oo (1 + abs(a_n))$ converges;
  + the series $sum_(n=1)^oo abs(a_n)$ converges.
] <prop:abs-convergence-product-equivalences>

=== Two Formulas // 两个重要公式

#theorem(name: "Wallis Formula")[
  $
    lim_(n -> oo) 1 / (2n + 1) ((2n)!! / (2n - 1)!!)^2 = pi / 2.
  $
  Equivalently, as $n -> +oo$,
  $
    (2n)!! / (2n - 1)!! tilde.op sqrt(pi n), quad quad (n!)^2 2^(2n) / (2n)! tilde.op sqrt(pi n).
  $
] <thm:wallis-formula>

#note[
  The proof is based on the recurrence of the Wallis integral $I_n = integral_0^(pi/2) sin^n x dif x$, established in #link(<ex:wallis>)[the example on the definite integral].
]

#theorem(name: "Stirling Formula")[
  For every $m in bb(N)$, as $n -> +oo$,
  $
    ln n! = ln sqrt(2 pi) + (n + 1/2) ln n - n + sum_(k=1)^m B_(2k) / (2k(2k - 1) n^(2k - 1)) + theta_n dot B_(2m + 2) / ((2m + 1)(2m + 2) n^(2m + 1)), quad quad 0 < theta_n < 1,
  $
  where $B_(2k)$ denote the Bernoulli numbers. In particular, the simplified form reads
  $
    n! tilde.op sqrt(2 pi n) (n / e)^n quad quad (n -> +oo),
  $
  and more precisely,
  $
    n! = sqrt(2 pi n) (n / e)^n e^(c_n), quad quad 1 / (12n + 1) < c_n < 1 / (12n).
  $
] <thm:stirling-formula>

== Special Series // 特殊级数

*Geometric series.*
$
  sum_(n=0)^oo q^n = 1 / (1 - q),
$
which converges when $abs(q) < 1$ and diverges otherwise.

*Telescoping series.*
$
  sum_(n=1)^oo (a_n - a_(n+1)) = a_1 - lim_(n -> oo) a_(n+1),
$
which converges when $lim_(n -> oo) a_n$ exists and diverges otherwise.

*$p$-series (hyperharmonic series).*
$
  sum_(n=1)^oo 1 / n^p
$
converges when $p > 1$ and diverges otherwise.

*$q$-series.*
$
  sum_(n=2)^oo 1 / (n ln^q n)
$
converges when $q > 1$ and diverges otherwise.

*Generalized $q$-series.*
$
  sum_(n=3)^oo 1 / (n ln n (ln ln n) dots.c (ln^((k-1)) n)(ln^((k)) n)^q),
$
where $ln^((k)) n$ denotes the $k$-th iterated logarithm, converges when $q > 1$ and diverges otherwise.

In mathematics, the Gauss hypergeometric function (or ordinary hypergeometric function) $attach(F, bl: 2, t: 1)(a, b; c; x)$ is a function defined by the hypergeometric series; many special functions arise as its special cases or limits, and the solutions of all second-order linear ordinary differential equations with three regular singular points can be expressed in terms of hypergeometric functions.

#definition(name: "Hypergeometric Series")[
  For $a, b, c > 0$ and $x >= 0$, the /hypergeometric series/ is
  $
    attach(F, bl: 2, t: 1)(a, b; c; x) = sum_(n=0)^oo (a^overline(n) b^overline(n)) / (c^overline(n)) dot x^n / n!,
  $
  where $x^overline(n)$ denotes the rising factorial.
] <def:hypergeometric-series>

The series converges when $0 <= x < 1$ and diverges when $x > 1$; when $x = 1$, it converges if $c > a + b$ and diverges if $c <= a + b$.

#note[
  The classification follows from the d'Alembert test when $x != 1$, since the ratio of consecutive terms tends to $x$; for $x = 1$ it follows from the Raabe test, since
  $
    t_n / t_(n+1) = ((n + c)(n + 1)) / ((n + a)(n + b)) = 1 + (c - a - b + 1) / n + O(1/n^2),
  $
  so the quantity $n (t_n / t_(n+1) - 1) -> c - a - b + 1$ exceeds $1$ exactly when $c > a + b$.
]

Many ordinary functions can be represented by hypergeometric series:
$
  ln(1 + x) = x dot attach(F, bl: 2, t: 1)(1, 1; 2; -x), quad quad (1 - x)^(-a) = attach(F, bl: 2, t: 1)(a, 1; 1; x), quad quad arcsin x = x dot attach(F, bl: 2, t: 1)(1/2, 1/2; 3/2; x^2).
$

= Series of Functions // 函数项级数

== Pointwise and Uniform Convergence // 点态收敛与一致收敛

=== Pointwise Convergence // 点态收敛

#definition(name: "Function Term Series")[
  Let $u_(n)(x)$ ($n = 1, 2, 3, dots$) be a sequence of functions with a common domain $E$. The sum of these infinitely many functions
  $
    sum_(n=1)^oo u_(n)(x)
  $
  is called a /function term series/.

  For any fixed point $x_0 in E$, if the numerical series $sum_(n=1)^oo u_(n)(x_0)$ converges, then the function term series is said to converge at $x_0$, or equivalently, $x_0$ is called a /convergence point/ of $sum_(n=1)^oo u_(n)(x)$. The set of all convergence points is called the /domain of convergence/ of $sum_(n=1)^oo u_(n)(x)$.
] <def:function-term-series>

#definition(name: "Pointwise Convergence")[
  Let the domain of convergence of the function term series $sum_(n=1)^oo u_(n)(x)$ be $D subset.eq E$. Then the series defines a function $S(x)$ on $D$, where
  $
    S(x) = sum_(n=1)^oo u_(n)(x), quad quad x in D.
  $
  The function $S(x)$ is called the /sum function/ of the series, and the series is said to /converge pointwise/ to $S(x)$ on $D$.
] <def:pointwise-convergence>

Define the /partial sum function/ of the series as
$
  S_(n)(x) = sum_(k=1)^n u_(k)(x).
$
It is evident that the set of all $x$ for which $(S_(n)(x))$ converges is precisely $D$, and on $D$ we have
$
  S(x) = lim_(n -> oo) S_(n)(x) = lim_(n -> oo) sum_(k=1)^n u_(k)(x).
$
Conversely, given a sequence of functions $(S_(n)(x))$ ($x in E$), the definitions
$
  u_1(x) = S_1(x), quad quad u_(n+1)(x) = S_(n+1)(x) - S_(n)(x) quad quad (n = 1, 2, dots)
$
recover the corresponding function term series. Thus the convergence behavior of a function term series and that of the corresponding sequence of partial sum functions are essentially the same.

However, pointwise convergence has certain limitations.

*Continuity.* The sum of finitely many continuous functions satisfies additive continuity:
$
  lim_(x -> x_0) [u_1(x) + dots.c + u_(n)(x)] = lim_(x -> x_0) u_1(x) + dots.c + lim_(x -> x_0) u_(n)(x).
$
If this property could be extended to infinitely many functions — that is, if $u_(n)(x)$ is continuous on $D$, then the sum function $S(x) = sum_(n=1)^oo u_(n)(x)$ would also be continuous on $D$, with
$
  lim_(x -> x_0) sum_(n=1)^oo u_(n)(x) = sum_(n=1)^oo lim_(x -> x_0) u_(n)(x),
$
meaning that /the limit operation and infinite summation can be interchanged/ (the series can be evaluated termwise) — then, for the sequence of partial sums, the limit function $S(x) = lim_(n -> oo) S_(n)(x)$ would be continuous on $D$ and the two limit operations could be interchanged:
$
  lim_(x -> x_0) lim_(n -> oo) S_(n)(x) = lim_(n -> oo) lim_(x -> x_0) S_(n)(x).
$
Unfortunately, under pointwise convergence this property does /not/ hold.

*Derivability.* The sum of finitely many differentiable functions satisfies additive differentiability:
$
  [u_1(x) + dots.c + u_(n)(x)]' = u_1'(x) + dots.c + u_n'(x).
$
If this property could be extended to infinitely many functions — that is, if $u_(n)(x)$ is differentiable on $D$, then the sum function would also be differentiable on $D$, with
$
  [sum_(n=1)^oo u_(n)(x)]' = sum_(n=1)^oo u_n'(x),
$
meaning that /the differentiation operation and infinite summation can be interchanged/ (the series can be differentiated termwise) — then, for the sequence of partial sums, the limit function would be differentiable on $D$ and the two operations could be interchanged:
$
  [lim_(n -> oo) S_(n)(x)]' = lim_(n -> oo) S_n'(x).
$
Unfortunately, under pointwise convergence this property does /not/ hold.

*Integrability.* The sum of finitely many integrable functions satisfies additive integrability:
$
  integral_a^b [u_1(x) + dots.c + u_(n)(x)] dif x = integral_a^b u_1(x) dif x + dots.c + integral_a^b u_(n)(x) dif x.
$
If this property could be extended to infinitely many functions — that is, if $u_(n)(x)$ is integrable on $[a, b] subset.eq D$, then the sum function would also be integrable on $[a, b]$, with
$
  integral_a^b sum_(n=1)^oo u_(n)(x) dif x = sum_(n=1)^oo integral_a^b u_(n)(x) dif x,
$
meaning that /the integration operation and infinite summation can be interchanged/ (the series can be integrated termwise) — then, for the sequence of partial sums, the limit function would be integrable on $[a, b]$ and the two operations could be interchanged:
$
  integral_a^b lim_(n -> oo) S_(n)(x) dif x = lim_(n -> oo) integral_a^b S_(n)(x) dif x.
$
Unfortunately, under pointwise convergence this property does /not/ hold.

#example(name: "Counter-Examples for Pointwise Convergence")[
  *Discontinuity of the sum function.* Let $S_(n)(x) = x^n$ on the interval $-1 < x <= 1$. Then $(S_(n)(x))$ converges to
  $
    S(x) = cases(0 quad quad (-1 < x < 1), 1 quad quad (x = 1)),
  $
  and each $S_(n)(x)$ is continuous, but the limit function $S(x)$ is discontinuous (hence not differentiable) at $x = 1$.

  *Failure of termwise differentiation.* Let $S_(n)(x) = sin(n x) / sqrt(n)$ on $(-oo, +oo)$. Then $(S_n)$ converges to $S(x) = 0$, so $S'(x) = 0$. But $S_n'(x) = sqrt(n) cos(n x)$ does not converge to $S'(x) = 0$.

  *Non-integrability of the sum function.* Let
  $
    S_(n)(x) = cases(1 quad quad (x dot n! in bb(Z)), 0 quad quad (x dot n! in.not bb(Z))) quad quad x in [0, 1].
  $
  For every $n$, $S_(n)(x)$ is bounded on $[0, 1]$ and has at most finitely many discontinuities (at the points $x = k / n!$), so $S_(n)(x) in R[0, 1]$. However, for irrational $x$ we have $S_(n)(x) = 0$ for all $n$, while for $x = q \/ p in bb(Q)$ ($p in bb(N)^+$, $q in bb(N)$, $q <= p$) we have $S_(n)(x) = 1$ for all $n >= p$. Hence the limit function $S(x)$ is the Dirichlet function, which is not Riemann integrable on $[0, 1]$.

  *Failure of termwise integration.* Let $S_(n)(x) = n x (1 - x^2)^n$ on $[0, 1]$. Then $(S_(n)(x))$ converges to $S(x) = 0$, and $S_(n)(x), S(x) in R[0, 1]$ for every $n$. But
  $
    integral_0^1 S_(n)(x) dif x = n / (2(n + 1)) -> 1 != integral_0^1 S(x) dif x = 0 quad quad (n -> oo).
  $
] <ex:pointwise-counterexamples>

=== Uniform Convergence // 一致收敛

#definition(name: "Uniform Convergence")[
  Let $(S_(n)(x))$ ($x in D$) be a sequence of functions. If
  $
    forall epsilon > 0, exists N(epsilon) in bb(N)^+, forall n > N(epsilon): abs(S_(n)(x) - S(x)) < epsilon quad quad (forall x in D),
  $
  then $(S_n)$ is said to /converge uniformly/ to $S(x)$ on $D$, denoted by
  $
    S_(n)(x) arrows.rr^(D) S(x).
  $
  If the partial sum sequence of the function term series $sum_(n=1)^oo u_(n)(x)$ ($x in D$) converges uniformly to $S(x)$ on $D$, then the series is said to converge uniformly to $S(x)$ on $D$.
] <def:uniform-convergence>

Obviously, if the partial sum sequence of $sum_(n=1)^oo u_(n)(x)$ satisfies $S_(n)(x) arrows.rr^(D) S(x)$, then $u_(n)(x) arrows.rr^(D) 0$.

#theorem(name: "Cauchy Criterion for Uniform Convergence")[
  The necessary and sufficient condition for the sequence of functions $(S_(n)(x))$ to converge uniformly on $D$ is
  $
    forall epsilon > 0, exists N in bb(N)^+, forall m > n > N: abs(S_(m)(x) - S_(n)(x)) < epsilon quad quad (forall x in D).
  $
  Correspondingly, the necessary and sufficient condition for the function term series $sum_(n=1)^oo u_(n)(x)$ to converge uniformly on $D$ is
  $
    forall epsilon > 0, exists N in bb(N)^+, forall m > n > N: abs(sum_(i=n+1)^m u_(i)(x)) < epsilon quad quad (forall x in D).
  $
] <thm:cauchy-criterion-uniform-convergence>

#theorem(name: "Necessary and Sufficient Conditions for Uniform Convergence")[
  Let $(S_(n)(x))$ converge pointwise to $S(x)$ on $D$. Then $S_(n)(x) arrows.rr^(D) S(x)$ if and only if:
  + $lim_(n -> oo) d(S_n, S) = lim_(n -> oo) sup_(x in D) abs(S_(n)(x) - S(x)) = 0$;
  + for any sequence $(x_n)$ with $x_n in D$, it holds that
    $
      lim_(n -> oo) (S_(n)(x_n) - S(x_n)) = 0.
    $
] <thm:ns-conditions-uniform-convergence>

#proof[
  *Item 1.* Suppose first that $S_(n)(x) arrows.rr^(D) S(x)$. Then for every $epsilon > 0$ there exists $N$ such that $abs(S_(n)(x) - S(x)) < epsilon / 2$ for all $n > N$ and all $x in D$, whence $d(S_n, S) <= epsilon / 2 < epsilon$ for all $n > N$, i.e. $lim_(n -> oo) d(S_n, S) = 0$. Conversely, if $lim_(n -> oo) d(S_n, S) = 0$, then for every $epsilon > 0$ there exists $N$ such that $d(S_n, S) < epsilon$ for all $n > N$, which means $abs(S_(n)(x) - S(x)) < epsilon$ for all $x in D$, i.e. $S_(n)(x) arrows.rr^(D) S(x)$.

  *Item 2.* If $S_(n)(x) arrows.rr^(D) S(x)$, then $d(S_n, S) -> 0$ ($n -> oo$), and for any sequence $(x_n)$ with $x_n in D$,
  $
    abs(S_(n)(x_n) - S(x_n)) <= d(S_n, S) -> 0 quad quad (n -> oo).
  $
  Conversely, suppose $S_n$ does /not/ converge uniformly to $S$ on $D$: there exists $epsilon_0 > 0$ such that for every $N$ there exist $n > N$ and $x in D$ with $abs(S_(n)(x) - S(x)) >= epsilon_0$. Taking $N_1 = 1$ yields $n_1 > N_1$ and $x_(n_1) in D$ with $abs(S_(n_1)(x_(n_1)) - S(x_(n_1))) >= epsilon_0$; taking $N_2 = n_1$ yields $n_2 > n_1$ and $x_(n_2)$ with the same property; and so on. For the remaining indices choose $x_m in D$ arbitrarily. The resulting sequence $(x_n)$ in $D$ has a subsequence $(x_(n_k))$ with $abs(S_(n_k)(x_(n_k)) - S(x_(n_k))) >= epsilon_0$, so $lim_(n -> oo) (S_(n)(x_n) - S(x_n)) = 0$ is impossible — a contradiction.
]

With the concept of uniform convergence, the flaws of pointwise convergence can be remedied, and the following properties can be established.

#proposition(name: "Continuity under Uniform Convergence")[
  Let $f_(n)(x) arrows.rr^(I subset.eq bb(R)) f(x)$. If $f_(n)(x)$ is continuous at $x_0 in I$ for every $n$, then $f(x)$ is also continuous at $x_0$. In particular, if $f_(n)(x) in C(I)$, then $f(x) in C(I)$.

  *Termwise limit.* If $sum_(n=1)^oo u_(n)(x) arrows.rr^(I subset.eq bb(R)) S(x)$ and $u_(n)(x) in C(I)$, then the sum function $S(x) in C(I)$.
] <prop:continuity-uniform-convergence>

#proposition(name: "Integrability under Uniform Convergence")[
  Let $f_(n)(x) arrows.rr^([a, b]) f(x)$. If $f_(n)(x) in R[a, b]$, then $f(x) in R[a, b]$, and
  $
    lim_(n -> oo) integral_a^b f_(n)(x) dif x = integral_a^b lim_(n -> oo) f_(n)(x) dif x = integral_a^b f(x) dif x.
  $

  *Termwise integration.* If $sum_(n=1)^oo u_(n)(x) arrows.rr^([a, b]) S(x)$ and $u_(n)(x) in R[a, b]$, then $S(x) in R[a, b]$.
] <prop:integrability-uniform-convergence>

#proposition(name: "Differentiability under Uniform Convergence")[
  Let $f_n'(x) arrows.rr^([a, b]) sigma(x)$. If there exists $x_0 in [a, b]$ such that $lim_(n -> oo) f_(n)(x_0) = a$, then there exists a function $f$ such that $f_(n)(x) arrows.rr^([a, b]) f(x)$ and $f'(x) = sigma(x)$.

  *Termwise differentiation.* If $sum_(n=1)^oo u_n'(x) arrows.rr^([a, b]) sigma(x)$ and there exists $x_0 in [a, b]$ such that $sum_(n=1)^oo u_(n)(x_0)$ converges to $a$, then there exists a function $S$ such that $sum_(n=1)^oo u_(n)(x) arrows.rr^([a, b]) S(x)$ and $S'(x) = sigma(x)$.

  *Corollary.* If we add the condition $f_n'(x) in C[a, b]$, the conclusion still holds and the proof becomes simpler.
] <prop:differentiability-uniform-convergence>

#note[
  Since continuity and differentiability are both local properties, it suffices to have uniform convergence internally closed on $(a, b)$ to ensure that $f(x)$ is continuous or differentiable.
]

=== Quasi-Uniform Convergence // 准一致收敛

#definition(name: "Quasi-Uniform Convergence")[
  The sequence of functions $(S_(n)(x))$ is said to converge /quasi-uniformly/ on the interval $[a, b]$ if it converges pointwise to $S(x)$ on $[a, b]$ and
  $
    forall epsilon > 0, forall N in bb(N)^+, exists N_0 > N "s.t." forall x in [a, b], exists n_x in [N, N_0] (n_x in bb(N)^+): abs(S_(n_x)(x) - S(x)) < epsilon.
  $
] <def:quasi-uniform-convergence>

== Uniform Convergence Tests // 一致收敛判别法

=== Weierstrass Test (M-Test) // Weierstrass 判别法（M-判别法）

#theorem(name: "Weierstrass Test (M-Test)")[
  If there exists a convergent positive term series $sum_(n=1)^oo a_n$ such that
  $
    abs(u_(n)(x)) <= a_n, quad quad forall x in E, n = 1, 2, 3, dots,
  $
  then the function term series $sum_(n=1)^oo u_(n)(x)$ converges uniformly on $E$. The positive term series $sum_(n=1)^oo a_n$ is called a /majorant series/ of $sum_(n=1)^oo u_(n)(x)$.

  If the convergent positive term series $sum_(n=1)^oo a_n$ is replaced by a uniformly convergent series of functions $sum_(n=1)^oo a_(n)(x)$, the conclusion still holds.
] <thm:weierstrass-m-test>

=== Abel-Dirichlet Test // Abel-Dirichlet 判别法

#theorem(name: "Abel-Dirichlet Test")[
  If the series of functions $sum_(n=1)^oo a_(n)(x) b_(n)(x)$ ($x in E$) satisfies at least one of the following two conditions, then it converges uniformly on $E$:
  + *Abel.* The sequence $(a_(n)(x_0))$ is monotonic for every $x_0 in E$, the sequence of functions $(a_(n)(x))$ is uniformly bounded on $E$, and the series $sum_(n=1)^oo b_(n)(x)$ converges uniformly on $E$.
  + *Dirichlet.* The sequence $(a_(n)(x_0))$ is monotonic for every $x_0 in E$ and $a_(n)(x) -> 0$ uniformly on $E$, while the partial sums $B_(n)(x) = sum_(k=1)^n b_(k)(x)$ are uniformly bounded on $E$.
] <thm:abel-dirichlet-uniform>

=== Dini Theorem // Dini 定理

#theorem(name: "Dini Theorem")[
  Let the sequence of functions $(S_(n)(x))$ converge pointwise to $S(x)$ on the closed interval $[a, b]$. If
  + $S_(n)(x) in C[a, b]$ ($n = 1, 2, 3, dots$);
  + $S(x) in C[a, b]$;
  + the sequence $(S_(n)(x_0))$ is monotonic for every $x_0 in [a, b]$,

  then $S_(n)(x) arrows.rr^([a, b]) S(x)$.
] <thm:dini-theorem>

#proof(name: "of the Dini theorem (by contradiction)")[
  Suppose, for contradiction, that $S_(n)(x)$ does not converge uniformly to $S(x)$ on $[a, b]$: there exists $epsilon_0 > 0$ such that for every $N$ there exist $n > N$ and $x in [a, b]$ with $abs(S_(n)(x) - S(x)) >= epsilon_0$. Taking successively $N = 1, n_1, n_2, dots$ produces indices $n_1 < n_2 < dots.c$ and points $x_1, x_2, dots.c in [a, b]$ with
  $
    abs(S_(n_k)(x_k) - S(x_k)) >= epsilon_0 quad quad (k = 1, 2, dots).
  $
  By the Bolzano-Weierstrass theorem the sequence $(x_k)$ has a convergent subsequence; without loss of generality let $x_k -> xi in [a, b]$. By pointwise convergence there exists $N$ with $abs(S_(N)(xi) - S(xi)) < epsilon_0 / 2$. Since $S_(n)(x), S(x) in C[a, b]$, the function $S_(N)(x) - S(x)$ is continuous at $xi$, so there exists $K$ such that
  $
    abs(S_(N)(x_k) - S(x_k)) < epsilon_0 quad quad (k > K).
  $
  By monotonicity of $(S_(n)(x_0))$ for every $x_0$, when $n > N$ and $k > K$,
  $
    abs(S_(n)(x_k) - S(x_k)) <= abs(S_(N)(x_k) - S(x_k)) < epsilon_0.
  $
  Since $n_k -> oo$, for $k$ large enough both $k > K$ and $n_k > N$ hold, whence $abs(S_(n_k)(x_k) - S(x_k)) < epsilon_0$ — contradicting the construction.
]

#proof(name: "of the Dini theorem (finite cover)")[
  Let $r_(n)(x) = S(x) - S_(n)(x)$. Since $(S_(n)(x_0))$ is monotonic for every $x_0 in [a, b]$, assume without loss of generality that it is increasing; then $r_(n)(x) >= 0$, $r_(n)(x) -> 0$ pointwise, and $r_(n+1)(x) <= r_(n)(x)$ on $[a, b]$. Fix $epsilon > 0$ and let $E_n$ denote the set of points $x in [a, b]$ with $r_(n)(x) < epsilon$. Each $E_n$ is open in $[a, b]$ since $r_n$ is continuous, the sets are increasing ($E_n subset.eq E_(n+1)$), and $union_(n=1)^oo E_n = [a, b]$ by pointwise convergence. By the Heine-Borel theorem, finitely many of them cover $[a, b]$; since the sets are increasing, $E_(n_1) subset.eq dots.c subset.eq E_(n_p)$ and $union_(j=1)^p E_(n_j) = [a, b]$ for some indices $n_1 < dots.c < n_p$. Let $N = n_p$. Then for every $n > N$ and every $x in [a, b]$, we have $x in E_(n_j) subset.eq E_N subset.eq E_n$ for some $j$, i.e. $r_(n)(x) < epsilon$. Since $epsilon > 0$ was arbitrary, $S_(n)(x) arrows.rr^([a, b]) S(x)$.
]

#note[
  Removing the condition of monotonicity, the Arzelà-Borel theorem becomes a result of quasi-uniform convergence.
]

= Power Series // 幂级数

== Power Series and Its Convergence Radius

=== Definition and Convergence Radius // 幂级数与收敛半径

#definition(name: "Power Series")[
  A /power series/ is a function term series of the form
  $
    sum_(n=0)^oo a_n (x - x_0)^n = a_0 + a_1 (x - x_0) + dots.c + a_n (x - x_0)^n + dots.c quad quad (a_n in bb(R)),
  $
  For convenience one usually takes $x_0 = 0$ and studies only series of the form
  $
    sum_(n=0)^oo a_n x^n = a_0 + a_1 x + dots.c + a_n x^n + dots.c,
  $
  since the general case reduces to this one by the substitution $y = x - x_0$.
] <def:power-series>

#theorem(name: "Cauchy-Hadamard Theorem")[
  For the power series $sum_(n=0)^oo a_n x^n$, let
  $
    A = limsup_(n -> +oo) root(n, abs(a_n)),
  $
  and define the /radius of convergence/ $R$ by
  $
    R = cases(+oo quad quad (A = 0), 1/A quad quad (A in (0 comma +oo)), 0 quad quad (A = +oo)).
  $
  Then the power series converges absolutely when $abs(x) < R$, diverges when $abs(x) > R$, and the behaviour at the endpoints $x = plus.minus R$ must be examined separately.
] <thm:cauchy-hadamard>

#theorem(name: "d'Alembert's Formula for the Radius")[
  If for the power series $sum_(n=0)^oo a_n x^n$ with $a_n != 0$ the limit
  $
    lim_(n -> oo) abs(a_(n+1) / a_n) = A
  $
  exists, then the radius of convergence is $R = 1 / A$.
] <thm:dalembert-radius>

#note[
  d'Alembert's formula cannot be applied directly to power series with missing terms (those with some $a_n = 0$), since the ratio $a_(n+1) \/ a_n$ is then undefined for infinitely many indices; the Cauchy-Hadamard theorem, however, still applies.
]

#proposition(name: "Operations on Power Series and the Radius")[
  Let $sum_(n=0)^oo a_n x^n$ and $sum_(n=0)^oo b_n x^n$ be power series with radii of convergence $R_1$ and $R_2$ respectively. Then:
  + the sum $sum_(n=0)^oo (a_n + b_n) x^n$ has radius of convergence $R >= min(R_1, R_2)$;
  + the termwise product $sum_(n=0)^oo a_n b_n x^n$ has radius of convergence $R >= R_1 R_2$;
  + the Cauchy product $(sum_(n=0)^oo a_n x^n) (sum_(n=0)^oo b_n x^n)$ has radius of convergence $R >= min(R_1, R_2)$.
] <prop:power-series-algebra>

=== Abel's Theorems // Abel 定理

#theorem(name: "Abel's First Theorem")[
  If the power series $sum_(n=0)^oo a_n x^n$ converges at a point $x = x_0 != 0$, then it converges absolutely on the whole interval $abs(x) < abs(x_0)$. If it diverges at $x = x_1$, then it diverges at every point with $abs(x) > abs(x_1)$.
] <thm:abel-first-theorem>

#theorem(name: "Abel's Second Theorem")[
  Let the power series $sum_(n=0)^oo a_n x^n$ have radius of convergence $R$. Then:
  + the series converges uniformly on $(-R, R)$ inner-closed, i.e. uniformly on every compact subinterval of $(-R, R)$;
  + if the series converges at $x = R$ (respectively at $x = -R$), then it converges uniformly on every closed interval $[a, R] subset.eq (-R, R]$ (respectively $[-R, a] subset.eq [-R, R)$);
  + in other words, the power series converges uniformly on every closed interval contained in its domain of convergence.
] <thm:abel-second-theorem>

#corollary[
  Let the power series $sum_(n=0)^oo a_n x^n$ have radius of convergence $R$. If the series converges at $x = R$ (respectively at $x = -R$), then its sum function $S(x)$ is left-continuous at $x = R$ (respectively right-continuous at $x = -R$).
] <cor:abel-endpoint-continuity>

If suitable conditions are imposed on the coefficients $a_n$, the converse of Abel's second theorem holds:

#theorem(name: "Tauber's Theorem")[
  Let $sum_(n=0)^oo a_n x^n$ be a power series with radius of convergence $1$, and suppose $lim_(x -> 1^(-)) sum_(n=0)^oo a_n x^n = A in bb(R)$. Then:
  + if $lim_(n -> oo) n a_n = 0$, then $sum_(n=0)^oo a_n = A$;
  + if $a_n >= 0$ ($n = 0, 1, 2, dots$), then $sum_(n=0)^oo a_n = A$.
] <thm:tauber-theorem>

#proof(name: "of Item 1")[
  From $lim_(n -> oo) n a_n = 0$ we get, writing $b_n = n abs(a_n)$, that $lim_(n -> oo) b_n = 0$; by #link(<thm:stolz-cesaro>)[the Stolz-Cesàro theorem],
  $
    lim_(n -> oo) (b_1 + b_2 + dots.c + b_n) / n = lim_(n -> oo) (sum_(k=0)^n k abs(a_k)) / n = 0.
  $
  Since $lim_(x -> 1^(-)) sum_(n=0)^oo a_n x^n = A in bb(R)$, we also have
  $
    lim_(n -> oo) abs(sum_(k=0)^oo a_k (1 - 1/n)^k - A) = 0.
  $
  Hence for every $epsilon > 0$ there exists $N$ such that for all $n > N$,
  $
    0 <= (sum_(k=0)^n k abs(a_k)) / n < epsilon / 3, quad quad k abs(a_k) < epsilon / 3 quad (k > N), quad quad abs(sum_(k=0)^oo a_k (1 - 1/n)^k - A) < epsilon / 3.
  $
  Writing $x = 1 - 1/n$ and splitting $sum_(k=0)^n a_k - A$ into three parts,
  $
    abs(sum_(k=0)^n a_k - A) <= abs(sum_(k=0)^n a_k (1 - x^k)) + abs(sum_(k=n+1)^oo a_k x^k) + abs(sum_(k=0)^oo a_k x^k - A).
  $
  For the first term, since $1 - x^k = (1 - x)(1 + x + x^2 + dots.c + x^(k-1))$,
  $
    abs(sum_(k=0)^n a_k (1 - x^k)) = abs(sum_(k=1)^n a_k (1 - x)(1 + x + dots.c + x^(k-1))) <= sum_(k=1)^n abs(a_k) (1 - x) k = (sum_(k=1)^n k abs(a_k)) / n < epsilon / 3.
  $
  For the second term, using $k abs(a_k) < epsilon / 3$ for $k > N$,
  $
    abs(sum_(k=n+1)^oo a_k x^k) <= 1 / n sum_(k=n+1)^oo k abs(a_k) x^k < epsilon / (3n) sum_(k=n+1)^oo x^k <= epsilon / (3n) dot 1 / (1 - x) = epsilon / (3n dot 1/n) < epsilon / 3,
  $
  where the last step uses $x = 1 - 1/n$. The third term satisfies $abs(sum_(k=0)^oo a_k x^k - A) < epsilon / 3$ by construction. Combining the three estimates yields $abs(sum_(k=0)^n a_k - A) < epsilon$, i.e. $sum_(n=0)^oo a_n = A$.
]

=== Analytic Properties of the Sum Function // 和函数的分析性质

#theorem(name: "Properties of the Sum Function")[
  Let the power series $sum_(n=0)^oo a_n x^n$ have radius of convergence $R$ and sum function $S(x)$. Then:
  + $S(x) in C(-R, R)$;
  + $S(x)$ is differentiable on $(-R, R)$ and the series may be differentiated termwise:
    $
      S'(x) = (sum_(n=0)^oo a_n x^n)' = sum_(n=0)^oo n a_n x^(n-1),
    $
    and the differentiated series still has radius of convergence $R$;
  + $S(x) in C^oo(-R, R)$, and termwise differentiation of any order is allowed with the radius of convergence unchanged;
  + for every $x in (-R, R)$ the series may be integrated termwise:
    $
      integral_0^x S(t) dif t = integral_0^x (sum_(n=0)^oo a_n t^n) dif t = sum_(n=0)^oo a_n / (n + 1) x^(n+1),
    $
    and the integrated series still has radius of convergence $R$.
] <thm:power-series-properties>

#caution[
  Although the radius of convergence is unchanged, the domain of convergence may enlarge after termwise integration and may shrink after termwise differentiation.
]

#example(name: "Computing Sums via Termwise Operations")[
  *1.* Show that for $x in (-1, 1)$,
  $
    sum_(n=1)^oo (-1)^n / (2n - 1) x^(2n-1) = x - 1/3 x^3 + 1/5 x^5 - dots.c = arctan x.
  $
  For every $x in (-1, 1)$ there exists $delta > 0$ with $x in [-1 + delta, 1 - delta]$. For the series $sum_(n=1)^oo (-1)^(n-1) x^(2n-2)$ the partial sums are $S_(n)(x) = (1 - (-x^2)^n) / (1 + x^2)$, so $S_(n)(x) -> S(x) = 1 / (1 + x^2)$ on $[-1 + delta, 1 - delta]$. Since $d(S_(n), S) = abs(-(-x^2)^n / (1 + x^2)) -> 0$ ($n -> oo$), we have $S_(n)(x) arrows.rr^([-1 + delta, 1 - delta]) S(x)$. By termwise integration,
  $
    integral_0^x sum_(n=1)^oo (-1)^(n-1) t^(2n-2) dif t = sum_(n=1)^oo (-1)^n / (2n - 1) x^(2n-1) = integral_0^x (dif t) / (1 + t^2) = arctan x, quad quad x in (-1, 1).
  $
  #note[
    Here the domain of convergence of $sum_(n=1)^oo (-1)^(n-1) x^(2n-2)$ is $(-1, 1)$, but after termwise integration the series $sum_(n=1)^oo (-1)^n \/ (2n - 1) x^(2n-1)$ converges on $[-1, 1]$.
  ]

  *2.* Show that for $x in (-1, 1)$, $sum_(n=1)^oo n x^n = x / (1 - x)^2$. Since $sum_(n=0)^oo x^n -> 1 / (1 - x)$ on $(-1, 1)$, termwise differentiation gives $sum_(n=1)^oo n x^(n-1)$; moreover, for every $0 < rho < 1$ and $x in [-rho, rho]$ we have $abs(n x^(n-1)) <= n rho^(n-1)$, and since $limsup_(n -> +oo) root(n, n rho^(n-1)) <= rho < 1$ the series $sum_(n=1)^oo n rho^(n-1)$ converges, so by #link(<thm:weierstrass-m-test>)[Weierstrass' test] the series $sum_(n=1)^oo n x^(n-1)$ converges uniformly on $[-rho, rho]$, i.e. inner-closed uniformly on $(-1, 1)$. By termwise differentiation,
  $
    (dif)/(dif x) sum_(n=1)^oo x^n = sum_(n=1)^oo n x^(n-1) = (dif)/(dif x) 1 / (1 - x) = 1 / (1 - x)^2,
  $
  and multiplying both sides by $x$ gives $sum_(n=1)^oo n x^n = x / (1 - x)^2$.

  *3.* Compute $sum_(n=1)^oo (2n + 1) / 3^n$. Consider $sum_(n=0)^oo x^n = 1 / (1 - x)$ on $(-1, 1)$; differentiating termwise and multiplying by $x$ gives $sum_(n=1)^oo n x^n = x / (1 - x)^2$. Setting $x = 1/3$ yields $sum_(n=1)^oo (1/3)^n = 1/2$ and $sum_(n=1)^oo n (1/3)^n = 3/4$. Hence
  $
    sum_(n=1)^oo (2n + 1) / 3^n = 2 sum_(n=1)^oo n (1/3)^n + sum_(n=1)^oo (1/3)^n = 2 dot 3/4 + 1/2 = 2.
  $

  *4.* Compute the sum function of $sum_(n=0)^oo (n^2 + 1) / (2^n n!) x^n$. Split
  $
    sum_(n=0)^oo (n^2 + 1) / (2^n n!) x^n = sum_(n=1)^oo n / (2^n (n-1)!) x^n + sum_(n=1)^oo 1 / (2^n n!) x^n,
  $
  and all three series have convergence domain $(-oo, +oo)$. First, $sum_(n=1)^oo 1 / (2^n n!) x^n = sum_(n=1)^oo 1/(n!) (x/2)^n = e^(x/2) - 1$. Next let $S(x) = sum_(n=1)^oo n / ((n-1)!) x^(n-1)$; by termwise integration,
  $
    integral_0^x S(t) dif t = sum_(n=1)^oo 1 / ((n-1)!) x^n = sum_(n=0)^oo 1/(n!) x^(n+1) = x e^x,
  $
  so differentiating both sides gives $S(x) = e^x (1 + x)$. Therefore
  $
    sum_(n=1)^oo n / (2^n (n-1)!) x^n = x/2 sum_(n=1)^oo n / ((n-1)!) (x/2)^(n-1) = x/2 S(x/2) = x/2 (1 + x/2) e^(x/2),
  $
  and consequently
  $
    sum_(n=0)^oo (n^2 + 1) / (2^n n!) x^n = e^(x/2) (1 + x/2 + x^2/4).
  $
] <ex:power-series-sums>

== Expanding Functions into Power Series

#definition(name: "Smooth Function")[
  Let $f(x)$ be a function defined on an interval $I$. If $f(x)$ is continuous, then $f(x)$ is called a $C^0$ function on $I$; if $f(x)$ has a continuous derivative of order $n$ ($n >= 1$), then $f(x)$ is called a $C^n$ function on $I$; if for any $n in bb(N)$, $f(x)$ has a continuous $n$-th derivative, then $f(x)$ is called a $C^oo$ function on $I$, also known as a /smooth function/.
] <def:smooth-function>

#definition(name: "(Real) Analytic Function")[
  Let $f(x)$ be a function defined on an interval $I$. If for any point $x_0 in I$ there exists a power series expansion of $f(x)$ at $x_0$,
  $
    f(x) = sum_(n=0)^oo a_n (x - x_0)^n
  $
  that converges to $f(x)$ in some neighborhood of $x_0$, then $f(x)$ is called a /(real) analytic function/ on $I$.

  Or equivalently, $f(x)$ is analytic on $I$ if for any point $x_0 in I$, the Taylor series of $f(x)$ at $x_0$ converges pointwise to $f(x)$ in some neighborhood of $x_0$, that is,
  $
    T(x) = sum_(n=0)^oo (f^((n))(x_0)) / (n!) (x - x_0)^n -> f(x).
  $
  The set of all real analytic functions on $I$ is usually denoted by $C^omega(I)$.
] <def:real-analytic-function>

#definition(name: "Taylor Series")[
  Suppose $f(x)$ has derivatives of all orders at $x_0$. Then from $f(x)$ one can form the formal power series
  $
    sum_(n=0)^oo (f^((n))(x_0)) / (n!) (x - x_0)^n,
  $
  called the /Taylor series/ of $f(x)$ at $x_0$, written
  $
    f(x) tilde.op sum_(n=0)^oo (f^((n))(x_0)) / (n!) (x - x_0)^n.
  $
  In particular, when $x_0 = 0$, the series $sum_(n=0)^oo (f^((n))(0)) / (n!) x^n$ is also called the /Maclaurin series/ of $f(x)$.
] <def:taylor-series>

#theorem(name: "Uniqueness of Power Series Expansion")[
  If $f(x)$ can be expanded on some neighborhood $U(x_0)$ as a power series $sum_(n=0)^oo a_n (x - x_0)^n$, then this expansion is unique, and it is precisely the Taylor series of $f(x)$ at $x_0$.

  One says that $f(x)$ is /Taylor expandable/ on $U(x_0)$ if
  $
    f(x) = sum_(n=0)^oo (f^((n))(x_0)) / (n!) (x - x_0)^n, quad quad x in U(x_0).
  $
] <thm:uniqueness-power-series-expansion>

#note[
  Passing from smooth functions to analytic functions, the following three questions arise for a function $f(x)$ that is infinitely differentiable at $x_0$:
  + Does there exist a neighborhood $U(x_0)$ on which $f(x)$ is infinitely differentiable?
  + Does the formal Taylor series written down from $f(x)$ necessarily have a positive radius of convergence?
  + If the Taylor series of $f(x)$ at $x_0$ has a positive radius of convergence, is the sum function of the series on its domain of convergence equal to $f(x)$?

  The answer to all three questions is /no/; see #link(<ex:smooth-not-analytic>)[the counter-examples below].
]

#example(name: "Smooth but Not Analytic")[
  *Counter-example 1 (failure of Item 1: $C^oo$ at a point but in no neighborhood).* For every natural number $k$, construct a function $h_k$ that is $C^k$-smooth but not $C^(k+1)$-smooth: start from a function that is continuous everywhere but nowhere differentiable (such as the Weierstrass function $f(x) = sum_(n=0)^oo a^n cos(b^n pi x)$ with $0 < a < 1$, $b$ a positive odd number and $a b > 1 + (3 pi) / 2$) and integrate it $k$ times; each integration raises the order of smoothness by one, while the original non-differentiability is preserved in a higher derivative.

  Introduce a smooth function $g_k$ matching the derivatives of $h_k$ up to order $k$ at $plus.minus 1$: $g_k^((i))(plus.minus 1) = h_k^((i))(plus.minus 1)$ ($i = 0, 1, 2, dots, k$). Then $f_k = h_k - g_k$ satisfies $f_k^((i))(plus.minus 1) = 0$ ($i = 0, 1, 2, dots, k$), vanishes outside $[-1, 1]$, and is $C^k$ but not $C^(k+1)$ on $[-1, 1]$.

  On each interval $(1/(n+1), 1/n)$, place a width-scaled copy $tilde(f)_n$ of $f_n$, so that it is $C^n$ but not $C^(n+1)$ on that interval and vanishes outside it; then scale its height so that $abs(tilde(f)_n^((i))) <= e^(-(n+1)^2)$ for $i = 0, 1, 2, dots, n$ (this is possible because these derivatives are bounded). Define
  $
    f(x) = cases(tilde(f)_n quad quad (x in (1/(n+1), 1/n)), f(-x) quad quad (x < 0), 0 quad quad (x = 0)).
  $
  Near the origin the derivatives of $f$ decay faster than any polynomial or exponential (similar to the classical smooth transition function $e^(-1/x^2)$), and induction shows $f^((k))(0) = 0$ for all $k >= 0$, so $f$ is infinitely differentiable at $x = 0$. However, every neighborhood $(-epsilon, epsilon)$ of the origin contains infinitely many subintervals $(1/(k+1), 1/k)$, on which $f$ is $C^k$-smooth but not $C^(k+1)$-smooth. Hence, no matter how small the neighborhood, $f$ cannot be a $C^oo$ function on it.

  *Counter-example 2 (failure of Item 2: formal Taylor series divergent except at the center).* Let
  $
    f(x) = sum_(n=0)^oo (sin 2^n x) / (n!).
  $
  *Step 1: $f$ is $C^oo$.* By induction,
  $
    u_n^((k))(x) = ((sin 2^n x) / (n!))^((k)) = (2^n)^k sin(2^n x + (k pi) / 2) / (n!),
  $
  so $abs(u_n^((k))(x)) <= (2^n)^k / (n!) = (2^k)^n / (n!)$. Since $(2^k)^(n+1) / ((n+1)!) dot (n!) / (2^k)^n = (2^k) / (n+1) -> 0$ ($n -> +oo$), the series $sum_(n=0)^oo (2^k)^n / (n!)$ converges (to $e^(2^k)$), and by #link(<thm:weierstrass-m-test>)[Weierstrass' test] the series $sum_(n=0)^oo u_n^((k))(x)$ converges uniformly on $(-oo, +oo)$ for every $k$. Hence
  $
    f^((k))(x) = (sum_(n=0)^oo u_(n)(x))^((k)) = sum_(n=0)^oo u_n^((k))(x) = sum_(n=0)^oo ((2^n)^k sin(2^n x + (k pi) / 2)) / (n!),
  $
  i.e. $f(x)$ has derivatives of all orders on $(-oo, +oo)$, so $f$ is a $C^oo$ function.

  *Step 2: the formal Taylor series of $f$ at $0$ diverges for every $x != 0$.* Setting $x = 0$ in the formula above,
  $
    f^((k))(0) = cases(sum_(n=0)^oo (-1)^l (2^(2l+1))^n / (n!) quad quad (k = 2l + 1), 0 quad quad (k = 2l)) = cases((-1)^l e^(2^(2l+1)) quad quad (k = 2l + 1), 0 quad quad (k = 2l)).
  $
  Therefore the Taylor series of $f(x)$ at $x_0 = 0$ can be written as
  $
    sum_(k=0)^oo (f^((k))(0)) / (k!) x^k = sum_(l=0)^oo (-1)^l e^(2^(2l+1)) / ((2l+1)!) x^(2l+1).
  $
  For its terms $a_l = (-1)^l e^(2^(2l+1)) x^(2l+1) / ((2l+1)!)$, d'Alembert's ratio test gives
  $
    lim_(l -> oo) abs(a_(l+1) / a_l) = lim_(l -> oo) (e^(3 dot 2^(2l+1)) x^2) / ((2l+2)(2l+3)) = cases(+oo quad quad (x != 0), 0 quad quad (x = 0)),
  $
  so the series diverges for every $x != 0$.

  *Counter-example 3 (failure of Item 3: Taylor series convergent, but not to $f$).* Let
  $
    f(x) = cases(e^(-1/x) quad quad (x > 0), 0 quad quad (x <= 0)).
  $
  Then $f(x)$ is a $C^oo$ function, and $f^((n))(0) = 0$ for all $n = 0, 1, 2, dots$, i.e. all derivatives of $f(x)$ vanish at $x = 0$. Its Taylor series $sum_(n=0)^oo (f^((n))(0)) / (n!) x^n = sum_(n=0)^oo 0 / (n!) x^n$ therefore converges to $0$, not to $f(x)$ itself.
] <ex:smooth-not-analytic>

#theorem[
  Every power series is a Taylor series: if $f(x) = sum_(n=0)^oo a_n (x - x_0)^n$ holds on some neighborhood of $x_0$, then $a_n = f^((n))(x_0) / (n!)$ for all $n$.
] <thm:power-series-are-taylor-series>

#theorem(name: "A Necessary and Sufficient Condition for Taylor Expansion")[
  Let $f(x) in C^oo$ on $U(x_0)$. Then $f(x)$ is Taylor expandable on $U(x_0)$ if and only if, writing
  $
    f(x) = sum_(k=0)^n (f^((k))(x_0)) / (k!) (x - x_0)^k + R_(n)(x),
  $
  one has $lim_(n -> oo) R_(n)(x) = 0$.
] <thm:taylor-expandable-necessary-sufficient>

#theorem(name: "Sufficient Conditions for Taylor Expansion")[
  Let $f(x) in C^oo$ on $U(x_0)$. Each of the following conditions is sufficient for $f(x)$ to be Taylor expandable on $U(x_0)$:
  + there exist $C, R > 0$ such that $abs(f^((k))(x)) <= C dot (k!) / R^k$ for all $k$ and all $x in U(x_0)$;
  + there exist $M > 0$ and $N$ such that $abs(f^((n))(x)) < M$ for all $n > N$ and all $x in U(x_0)$.
] <thm:taylor-expandable-sufficient>

#theorem(name: "Taylor Formula with Integral (Cauchy) Remainder")[
  Let $f(x)$ have derivatives up to order $n$ at $x_0$. Then there exists a neighborhood of $x_0$ such that for every point $x$ in it,
  $
    f(x) = p_(n)(x) + r_(n)(x),
  $
  where
  $
    p_(n)(x) = f(x_0) + f'(x_0)(x - x_0) + (f''(x_0)) / (2!) (x - x_0)^2 + dots.c + (f^((n))(x_0)) / (n!) (x - x_0)^n
  $
  is the $n$-th Taylor polynomial of $f(x)$, and
  $
    r_(n)(x) = 1 / (n!) integral_(x_0)^x f^((n+1))(t) (x - t)^n dif t
  $
  is the /integral form of the remainder/. Applying the first mean value theorem for integrals,
  $
    r_(n)(x) = 1 / (n!) f^((n+1))(xi) (x - xi)^n (x - x_0),
  $
  where $xi$ lies between $x$ and $x_0$; the resulting expression is called the /Cauchy form of the remainder/.
] <thm:taylor-cauchy-remainder>

=== Common Maclaurin Series // 常用 Maclaurin 级数

$
  e^x = sum_(n=0)^oo x^n / (n!) = 1 + x + x^2 / (2!) + dots.c, quad quad x in (-oo, +oo), \
  ln(1 + x) = sum_(n=1)^oo (-1)^(n-1) x^n / n = x - x^2 / 2 + x^3 / 3 - dots.c, quad quad x in (-1, 1], \
  sin x = sum_(n=0)^oo (-1)^n x^(2n+1) / ((2n+1)!) = x - x^3 / (3!) + x^5 / (5!) - dots.c, quad quad x in (-oo, +oo), \
  cos x = sum_(n=0)^oo (-1)^n x^(2n) / ((2n)!) = x - x^2 / (2!) + x^4 / (4!) - dots.c, quad quad x in (-oo, +oo), \
  1 / (1 - x) = sum_(n=0)^oo x^n = 1 + x + x^2 + dots.c, quad quad x in (-1, 1), \
  (1 + x)^alpha = sum_(n=0)^oo binom(alpha, n) x^n = 1 + alpha x + (alpha (alpha - 1)) / 2 x^2 + dots.c, quad quad cases(x in (-1, 1) quad (alpha <= -1), x in (-1, 1] quad (-1 < alpha < 0), x in [-1, 1] quad (alpha > 0)), \
  arctan x = sum_(n=0)^oo (-1)^n x^(2n+1) / (2n + 1) = x - x^3 / 3 + x^5 / 5 - dots.c, quad quad x in [-1, 1], \
  arcsin x = sum_(n=0)^oo ((2n)!) / (4^n (n!)^2 (2n + 1)) x^(2n+1) = x + 1/6 x^3 + 3/40 x^5 + 5/112 x^7 + 35/1152 x^9 + dots.c, quad quad x in (-1, 1), \
  sec x = sum_(n=0)^oo (-1)^n (E_(2n)) / ((2n)!) x^(2n) = 1 + 1/2 x^2 + 5/24 x^4 + 61/720 x^6 + dots.c, \
  tan x = sum_(n=0)^oo (B_(2n) (-4)^n (1 - 4^n)) / ((2n)!) x^(2n-1) = x + 1/3 x^3 + 2/15 x^5 + dots.c,
$
where $E_(2n)$ denote the Euler numbers and $B_(2n)$ the Bernoulli numbers.

== Smooth Approximation of Functions

We first approximate Riemann integrable functions by continuous functions, and continuous functions by smooth functions, respectively.

#theorem[
  Let $f(x) in R[a, b]$. For any $epsilon > 0$, there exists a function $g(x) in C[a, b]$ such that
  $
    integral_a^b abs(f(x) - g(x)) dif x < epsilon.
  $
] <thm:continuous-approximates-integrable>

#theorem[
  Let $f(x) in C[a, b]$. For any $epsilon > 0$, there exists a function $g(x) in C^oo[a, b]$ such that
  $
    abs(f(x) - g(x)) < epsilon, quad quad forall x in [a, b].
  $
] <thm:smooth-approximates-continuous>

On this basis, the Weierstrass approximation theorems are stated as follows:

#theorem(name: "Weierstrass First Approximation Theorem")[
  Let $f(x) in C[a, b]$. For any $epsilon > 0$, there exists a polynomial $P(x)$ such that
  $
    abs(f(x) - P(x)) < epsilon, quad quad forall x in [a, b].
  $
] <thm:weierstrass-first-approximation>

#theorem(name: "Weierstrass Second Approximation Theorem")[
  Let $f(x)$ be a continuous function with period $2 pi$. For any $epsilon > 0$, there exists a trigonometric polynomial
  $
    T_(n)(x) = A_0 / 2 + sum_(k=1)^n A_k cos(k x) + B_k sin(k x)
  $
  such that
  $
    T_(n)(x) arrows.rr f(x).
  $
] <thm:weierstrass-second-approximation>

#example(name: "Approximation by Step and Continuous Functions")[
  A function $p: [a, b] -> bb(R)$ is called a /step function/ on $[a, b]$ if there exists a partition $a = x_0 < x_1 < dots.c < x_n = b$ such that $p$ is constant on each open subinterval $(x_(i-1), x_i)$, $i = 1, 2, dots, n$. Let $f(x)$ be Riemann integrable on $[a, b]$. Show that:

  *1.* For every $epsilon > 0$ there exist step functions $p, q$ on $[a, b]$ with $p <= f <= q$ on $[a, b]$ and
  $
    integral_a^b [q(x) - p(x)] dif x < epsilon.
  $
  *2.* For every $epsilon > 0$ there exist $p, q in C[a, b]$ with $p(x) <= f(x) <= q(x)$ ($x in [a, b]$) and
  $
    integral_a^b [q(x) - p(x)] dif x < epsilon.
  $

  *Proof of Item 1.* Since $f(x) in R[a, b]$, for every $epsilon > 0$ there exists a partition $P$ with $sum_(i=1)^n omega_i Delta x_i < epsilon$, where $omega_i$ is the oscillation of $f$ on the $i$-th subinterval. Take $q(x)$ and $p(x)$ to be the supremum and infimum of $f$ on each subinterval, respectively; then $p <= f <= q$ and the integral inequality holds.

  *Proof of Item 2.* Since $f(x) in R[a, b]$, for every $epsilon > 0$ there exists a partition $P$ ($a = x_0 < x_1 < dots.c < x_n = b$) with $sum_(i=1)^n omega_i Delta x_i < epsilon$, i.e. $overline(S)(P) - underline(S)(P) < epsilon$, and there exists $M > 0$ with $abs(f(x)) <= M$. Choose $delta < min_(1 <= i <= n) lr({Delta x_i / 2})$ with $4 M delta (n - 1) < epsilon / 2$.

  On each closed subinterval $[x_(i-1) + delta, x_i - delta]$, set $q(x) = M_i$ and $p(x) = m_i$ (the supremum and infimum of $f$ there). In the neighborhood $[x_i - delta, x_i + delta]$ of each partition point, let $q(x)$ pass linearly from $M_i$ to $M_(i+1)$, ensuring $q(x) >= max lr({M_i, M_(i+1)}) >= f(x)$ throughout the transition region, and construct $p(x)$ analogously. The continuous functions $q(x)$ and $p(x)$ then satisfy
  $
    integral_a^b q(x) dif x <= overline(S)(P) + epsilon / 2, quad quad integral_a^b p(x) dif x >= underline(S)(P) - epsilon / 2,
  $
  and the conclusion follows.
] <ex:step-continuous-approximation>

#example(name: "Approximation by Successively Better Classes of Functions")[
  Let $f(x) in R[a, b]$. Show that for every $epsilon > 0$ there exists a function $g$ with
  $
    integral_a^b abs(f(x) - g(x)) dif x < epsilon,
  $
  where $g$ is respectively: *1.* a step function; *2.* a piecewise linear (polygonal) function; *3.* a continuous function; *4.* a continuously differentiable function.

  *Proof of Item 1.* Since $f(x) in R[a, b]$, for every $epsilon > 0$ there exists a partition $P$ with $sum_(i=1)^n omega_i Delta x_i < epsilon$. Set $g(x) = f(x_i)$ for $x in (x_(i-1), x_i)$; the values at the partition points may be chosen arbitrarily.

  *Proof of Items 2 and 3.* A polygonal function is in particular continuous. For every $epsilon > 0$, divide $[a, b]$ into $n$ equal parts, let $x_i = a + (b - a) / n dot i$ ($i = 0, 1, dots, n$), and choose $n$ so large that $sum_(i=1)^n omega_i Delta x_i < epsilon$. Let $y = f_(n)(x)$ be the polygonal line joining the points $(x_i, f(x_i))$. For any $x in [x_(i-1), x_i]$,
  $
    abs(f_(n)(x) - f(x)) = abs((x_i - x) / (x_i - x_(i-1)) [f(x_(i-1)) - f(x)] + (x - x_(i-1)) / (x_i - x_(i-1)) [f(x_i) - f(x)]) <= (x_i - x) / (x_i - x_(i-1)) omega_i + (x - x_(i-1)) / (x_i - x_(i-1)) omega_i = omega_i.
  $
  Hence
  $
    integral_a^b abs(f_(n)(x) - f(x)) dif x = sum_(i=1)^n integral_(x_(i-1))^(x_i) abs(f_(n)(x) - f(x)) dif x <= sum_(i=1)^n omega_i Delta x_i < epsilon.
  $

  *Proof of Item 4.* A Riemann integrable function can be approximated by a continuous function, and by #link(<thm:weierstrass-first-approximation>)[the Weierstrass first approximation theorem] a continuous function can be approximated by a polynomial (in particular a continuously differentiable function); combining the two gives the result.
] <ex:successive-approximation>

// --- Part IV: 多元微积分本体（决策③：ch11–13） ---
#part("Multivariable Calculus") // 多元微积分
// B11: ch11 Limits and Continuity in Euclidean Spaces（欧氏空间上的极限与连续性）
= Limits and Continuity in Euclidean Spaces // 欧氏空间上的极限与连续性

== Continuous Mappings

// 注：tex 中 "Continuous Mappings on Compact Sets" 为空壳标题（无内容来源），
// 紧集上连续映射的性质属 P0-1 补全范围，待大纲确认后重建。

=== Continuous Mappings on Connected Sets // 连通集上的连续映射

#definition(name: "Connected Set")[
  Let $S$ be a set of points in $bb(R)^n$. If a continuous mapping
  $
    gamma: [0, 1] -> bb(R)^n
  $
  satisfies that the range $gamma([0, 1])$ lies entirely within $S$, we call $gamma$ a /path/ in $S$, where $gamma(0)$ and $gamma(1)$ are referred to as the starting point and ending point of the path, respectively.

  If for any two points $bold(x), bold(y) in S$ there exists a path in $S$ with $bold(x)$ as the starting point and $bold(y)$ as the ending point, then $S$ is called /path-connected/, or equivalently, $S$ is called a /connected set/.

  A connected open set is called an /(open) region/. The closure of an (open) region is referred to as a /closed region/.
] <def:connected-set>

#note[
  Intuitively, this means that any two points in $S$ can be connected by a curve lying entirely within $S$. Clearly, a connected subset of $bb(R)$ is an interval, and a connected subset of $bb(R)$ is compact if and only if it is a closed interval.
]
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
