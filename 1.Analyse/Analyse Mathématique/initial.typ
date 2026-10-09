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

// B4b: ch04 §5–7（Taylor Theorem / Properties of Functions / Applications）

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
