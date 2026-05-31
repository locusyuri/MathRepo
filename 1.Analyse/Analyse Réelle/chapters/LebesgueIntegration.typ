#import "../../../TypstTemplate/math-notes.typ": *

= Lebesgue Integration
== Lebesgue Integration
=== Definition of the Lebesgue Integral // 勒贝格积分的定义

#definition(name: "Lebesgue Integral of Simple Functions")[ // 简单函数的 Lebesgue 积分
Let $(X, cal(S), mu)$ be a measure space and $s: X -> [0, infinity)$ a simple function.
$s(x)$ can be expressed as $s(x) = sum_{i=1}^n a_i chi_{A_i}(x)$, where $a_i >= 0$ and $A_i in cal(S)$ are disjoint measurable sets. The Lebesgue integral of $s$ with respect to $mu$ is defined as:
$
integral_X s dif mu = sum_(i=1)^n a_i mu(A_i).
$
]

#definition(name: "Lebesgue Integral of Non-Negative Functions")[ // 非负函数的 Lebesgue 积分
Let $(X, cal(S), mu)$ be a measure space and $f: X -> [0, infinity)$ a non-negative measurable function. The Lebesgue integral of $f$ with respect to $mu$ is defined as:
$
integral_X f dif mu = sup_(s <= f) integral_X s dif mu,
$
where the supremum is taken over all simple functions $s$ such that $s(x) <= f(x)$ for all $x in X$.
]

#definition(name: "Lebesgue Integral of Real-Valued Functions")[ //实值函数的 Lebesgue 积分
Let $(X, cal(S), mu)$ be a measure space and $f: X -> RR$ a real-valued measurable function. We can decompose $f$ into its positive and negative parts:
$
f^+(x) = max{f(x), 0}, f^-(x) = max{-f(x), 0}.
$
Then $f(x) = f^+(x) - f^-(x)$ and both $f^+$ and $f^-$ are non-negative measurable functions. The Lebesgue integral of $f$ with respect to $mu$ is defined as:
$
integral_X f dif mu = integral_X f^+ dif mu - integral_X f^- dif mu.
$
]



=== Properties of the Lebesgue Integral // 勒贝格积分的性质

== Limit of Integral Sequences // 积分序列的极限

=== Monotone Convergence Theorem // 单调收敛定理

#theorem(name: "Monotone Convergence Theorem (Levi)")[
  Let $(X, cal(S), mu)$ be a measure space and $f_n: X -> [0, infinity]$ be a sequence of non-negative measurable functions such that $f_n (x) <= f_(n+1) (x)$ for all $x in X$ and all $n in bb(N)$. Let $f(x) = lim_(n->infinity) f_n (x)$. Then
  $
  lim_(n->infinity) integral_X f_n dif mu = integral_X f dif mu.
  $
]

#proof[
  Since $f_n <= f_(n+1) <= f$ for all $n$, by monotonicity of the integral we have $integral_X f_n dif mu <= integral_X f dif mu$, so $lim_(n->infinity) integral_X f_n dif mu <= integral_X f dif mu$.

  For the reverse inequality, let $s$ be any simple function with $0 <= s <= f$, and let $alpha in (0, 1)$. Define $E_n = {x in X : f_n (x) >= alpha s(x)}$. Then $E_n$ is an increasing sequence of measurable sets with $union.big_(n=1)^infinity E_n = X$.

  We have
  $
  integral_X f_n dif mu >= integral_(E_n) f_n dif mu >= alpha integral_(E_n) s dif mu.
  $

  Since $s$ is a simple function, say $s = sum_(i=1)^k c_i chi_(A_i)$, we have $integral_(E_n) s dif mu = sum_(i=1)^k c_i mu(A_i inter E_n)$. By continuity of measure from below, $mu(A_i inter E_n) -> mu(A_i)$ as $n -> infinity$. Therefore
  $
  lim_(n->infinity) integral_X f_n dif mu >= alpha integral_X s dif mu.
  $

  Letting $alpha -> 1$ gives $lim_(n->infinity) integral_X f_n dif mu >= integral_X s dif mu$. Taking the supremum over all such $s$ yields $lim_(n->infinity) integral_X f_n dif mu >= integral_X f dif mu$.
]

#corollary(name: "Series and Integral Interchange")[
  Let $(X, cal(S), mu)$ be a measure space and $f_n: X -> [0, infinity]$ be a sequence of non-negative measurable functions. Then
  $
  integral_X sum_(n=1)^infinity f_n dif mu = sum_(n=1)^infinity integral_X f_n dif mu.
  $
]

#proof[
  Apply the Monotone Convergence Theorem to the partial sums $S_N = sum_(n=1)^N f_n$, which form a non-negative increasing sequence converging pointwise to $sum_(n=1)^infinity f_n$.
]

#example[
  The monotonicity condition cannot be dropped. Consider $f_n = chi_([n, n+1])$ on $(bb(R), cal(L), m)$. Then $f_n -> 0$ pointwise, but $integral_bb(R) f_n dif m = 1$ for all $n$, so $lim integral f_n = 1 != 0 = integral lim f_n$.
]

=== Fatou's Lemma // Fatou 引理

#theorem(name: "Fatou's Lemma")[
  Let $(X, cal(S), mu)$ be a measure space and $f_n: X -> [0, infinity]$ be a sequence of non-negative measurable functions. Then
  $
  integral_X liminf_(n->infinity) f_n dif mu <= liminf_(n->infinity) integral_X f_n dif mu.
  $
]

#proof[
  Define $g_n (x) = inf_(k >= n) f_k (x)$. Then $g_n$ is non-negative, measurable, and $g_n <= g_(n+1)$ for all $n$. Moreover, $lim_(n->infinity) g_n (x) = liminf_(n->infinity) f_n (x)$.

  Since $g_n <= f_k$ for all $k >= n$, we have $integral_X g_n dif mu <= integral_X f_k dif mu$ for all $k >= n$, hence $integral_X g_n dif mu <= inf_(k >= n) integral_X f_k dif mu$.

  By the Monotone Convergence Theorem applied to the increasing sequence $(g_n)$:
  $
  integral_X liminf_(n->infinity) f_n dif mu = lim_(n->infinity) integral_X g_n dif mu <= lim_(n->infinity) inf_(k >= n) integral_X f_k dif mu = liminf_(n->infinity) integral_X f_n dif mu.
  $
]

#corollary(name: "Reverse Fatou's Lemma")[
  Let $(X, cal(S), mu)$ be a measure space and $f_n: X -> [0, infinity]$ be a sequence of measurable functions. If there exists an integrable function $g$ such that $f_n <= g$ a.e. for all $n$, then
  $
  limsup_(n->infinity) integral_X f_n dif mu <= integral_X limsup_(n->infinity) f_n dif mu.
  $
]

#example[
  Strict inequality can occur in Fatou's Lemma. Consider $f_n = n chi_([0, 1\/n])$ on $(bb(R), cal(L), m)$. Then $f_n -> 0$ a.e., so $integral liminf f_n = 0$, but $integral f_n = 1$ for all $n$, so $liminf integral f_n = 1 > 0$.
]

=== Lebesgue Dominated Convergence Theorem // 勒贝格控制收敛定理

#theorem(name: "Lebesgue Dominated Convergence Theorem")[
  Let $(X, cal(S), mu)$ be a measure space and $f_n: X -> overline(bb(R))$ be a sequence of measurable functions such that $f_n (x) -> f(x)$ a.e. If there exists an integrable function $g in L^1 (X, mu)$ such that $|f_n (x)| <= g(x)$ a.e. for all $n$, then $f in L^1 (X, mu)$ and
  $
  lim_(n->infinity) integral_X f_n dif mu = integral_X f dif mu.
  $
  Equivalently, $lim_(n->infinity) integral_X |f_n - f| dif mu = 0$.
]

#proof[
  Since $|f_n| <= g$ a.e. and $f_n -> f$ a.e., we have $|f| <= g$ a.e., so $f in L^1 (X, mu)$.

  Consider the non-negative functions $g + f_n >= 0$ and $g - f_n >= 0$. Applying Fatou's Lemma to each:

  For $g + f_n$:
  $
  integral_X (g + f) dif mu <= liminf_(n->infinity) integral_X (g + f_n) dif mu = integral_X g dif mu + liminf_(n->infinity) integral_X f_n dif mu.
  $
  This gives $integral_X f dif mu <= liminf_(n->infinity) integral_X f_n dif mu$.

  For $g - f_n$:
  $
  integral_X (g - f) dif mu <= liminf_(n->infinity) integral_X (g - f_n) dif mu = integral_X g dif mu - limsup_(n->infinity) integral_X f_n dif mu.
  $
  This gives $limsup_(n->infinity) integral_X f_n dif mu <= integral_X f dif mu$.

  Combining: $integral_X f dif mu <= liminf integral_X f_n dif mu <= limsup integral_X f_n dif mu <= integral_X f dif mu$.
]

#corollary(name: "Bounded Convergence Theorem")[
  Let $(X, cal(S), mu)$ be a finite measure space (i.e., $mu(X) < infinity$) and $f_n: X -> overline(bb(R))$ be a sequence of measurable functions such that $f_n (x) -> f(x)$ a.e. If there exists a constant $M > 0$ such that $|f_n (x)| <= M$ a.e. for all $n$, then
  $
  lim_(n->infinity) integral_X f_n dif mu = integral_X f dif mu.
  $
]

#proof[
  Take $g equiv M$. Since $mu(X) < infinity$, we have $g in L^1 (X, mu)$. The result follows directly from the Lebesgue Dominated Convergence Theorem.
]

#corollary(name: "Differentiation under the Integral Sign")[
  Let $(X, cal(S), mu)$ be a measure space, $I subset bb(R)$ an open interval, and $f: X times I -> bb(R)$ a function such that:
  + For each $t in I$, the function $x |-> f(x, t)$ is integrable.
  + For a.e. $x in X$, the partial derivative $partial / (partial t) f(x, t)$ exists for all $t in I$.
  + There exists $g in L^1 (X, mu)$ such that $|partial / (partial t) f(x, t)| <= g(x)$ for a.e. $x$ and all $t in I$.
  Then $F(t) = integral_X f(x, t) dif mu(x)$ is differentiable on $I$ and
  $
  F'(t) = integral_X frac(partial, partial t) f(x, t) dif mu(x).
  $
]

#note[
  *Comparison of MCT and LDCT*:
  - MCT requires monotonicity but no dominating function; it applies only to non-negative functions.
  - LDCT requires a dominating function but no monotonicity; it applies to general integrable functions.
  - Fatou's Lemma is the weakest in hypotheses but gives only an inequality.
]

=== Uniform Integrability and Vitali Convergence // 一致可积与 Vitali 收敛定理

// 一致可积与等度绝对连续是 Vitali 收敛定理的核心概念
We now introduce two closely related concepts that generalize the domination condition in LDCT.

#definition(name: "Uniform Integrability")[
  Let $(X, cal(S), mu)$ be a measure space. A family of measurable functions ${f_i}_(i in I)$ is called *uniformly integrable* if
  $
  lim_(M -> infinity) sup_(i in I) integral_({|f_i| > M}) |f_i| dif mu = 0.
  $
]

#definition(name: "Equi-absolute Continuity of Integrals")[
  Let $(X, cal(S), mu)$ be a measure space. A family of integrable functions ${f_i}_(i in I)$ is said to have *equi-absolutely continuous integrals* (or to be *equi-integrable*) if for every $epsilon > 0$, there exists $delta > 0$ such that for every measurable set $A$ with $mu(A) < delta$,
  $
  sup_(i in I) integral_A |f_i| dif mu < epsilon.
  $
]

#note[
  *Comparison of the two concepts*:
  - *Uniform integrability* controls the "tail" at large values: the integral over the set where $|f_i|$ is large becomes uniformly small.
  - *Equi-absolute continuity* controls the integral over "small sets": the integral over any set of small measure is uniformly small.
  - On a finite measure space, the two concepts are closely related but not identical without an additional boundedness condition.
]

#proposition(name: "Equivalence on Finite Measure Spaces")[
  Let $(X, cal(S), mu)$ be a finite measure space and ${f_n}$ a sequence of integrable functions. Then the following are equivalent:
  + ${f_n}$ is uniformly integrable.
  + ${f_n}$ has equi-absolutely continuous integrals and $sup_n integral_X |f_n| dif mu < infinity$.
]

#proof[
  $(1) => (2)$: Suppose ${f_n}$ is uniformly integrable. For any $epsilon > 0$, choose $M$ such that $sup_n integral_({|f_n| > M}) |f_n| dif mu < epsilon / 2$. Then for any measurable set $A$ with $mu(A) < delta := epsilon / (2 M)$:
  $
  integral_A |f_n| dif mu = integral_(A inter {|f_n| <= M}) |f_n| dif mu + integral_(A inter {|f_n| > M}) |f_n| dif mu <= M mu(A) + epsilon / 2 < epsilon.
  $
  Also, $integral_X |f_n| dif mu <= M mu(X) + sup_n integral_({|f_n| > M}) |f_n| dif mu < infinity$.

  $(2) => (1)$: Suppose ${f_n}$ has equi-absolutely continuous integrals and $C := sup_n integral_X |f_n| dif mu < infinity$. By Chebyshev's inequality, $mu({|f_n| > M}) <= C / M$. For any $epsilon > 0$, choose $delta$ from equi-absolute continuity, then choose $M$ large enough so that $C / M < delta$. Then $mu({|f_n| > M}) < delta$, hence $sup_n integral_({|f_n| > M}) |f_n| dif mu < epsilon$.
]

#example[
  *Uniform integrability does not imply uniform boundedness*: On $([0,1], cal(L), m)$, let $f_n = n chi_([0, 1\/n^2])$. Then $integral |f_n| = 1 / n -> 0$ and ${f_n}$ is uniformly integrable (since $integral_({f_n > M}) f_n dif m -> 0$ uniformly), but $sup_x |f_n (x)| = n -> infinity$.
]

#example[
  *LDCT implies uniform integrability*: If $|f_n| <= g in L^1$ for all $n$, then ${f_n}$ is uniformly integrable. Indeed, $integral_({|f_n| > M}) |f_n| dif mu <= integral_({g > M}) g dif mu -> 0$ as $M -> infinity$, independent of $n$.
]

#v(0.5em)
// Vitali 收敛定理是 LDCT 的真正推广
The Vitali Convergence Theorem generalizes LDCT by replacing the single dominating function with the weaker condition of uniform integrability.

#theorem(name: "Vitali Convergence Theorem")[
  Let $(X, cal(S), mu)$ be a finite measure space and $f_n: X -> overline(bb(R))$ be a sequence of integrable functions. Suppose:
  + $f_n (x) -> f(x)$ in measure (or a.e.).
  + ${f_n}$ is uniformly integrable.
  Then $f in L^1 (X, mu)$ and
  $
  lim_(n->infinity) integral_X |f_n - f| dif mu = 0.
  $
  In particular, $lim_(n->infinity) integral_X f_n dif mu = integral_X f dif mu$.
]

#proof[
  We show $integral_X |f_n - f| dif mu -> 0$. Fix $epsilon > 0$.

  *Step 1*: By uniform integrability, choose $M > 0$ such that $sup_n integral_({|f_n| > M}) |f_n| dif mu < epsilon / 4$.

  *Step 2*: By equi-absolute continuity (which follows from uniform integrability on a finite measure space), choose $delta > 0$ such that $mu(A) < delta$ implies $sup_n integral_A |f_n| dif mu < epsilon / 4$.

  *Step 3*: Since $f_n -> f$ in measure, by Egorov's theorem there exists a set $E$ with $mu(X backslash E) < delta$ such that $f_n -> f$ uniformly on $E$. Choose $N$ such that for $n >= N$, $|f_n (x) - f(x)| < epsilon / (2 mu(X))$ for all $x in E$.

  *Step 4*: For $n >= N$:
  $
  integral_X |f_n - f| dif mu = integral_E |f_n - f| dif mu + integral_(X backslash E) |f_n - f| dif mu.
  $
  The first term is bounded by $epsilon / 2$. For the second term, by Fatou's lemma applied to $|f|$ and the equi-absolute continuity:
  $
  integral_(X backslash E) |f_n - f| dif mu <= integral_(X backslash E) |f_n| dif mu + integral_(X backslash E) |f| dif mu < epsilon / 4 + epsilon / 4 = epsilon / 2.
  $
  Hence $integral_X |f_n - f| dif mu < epsilon$.
]

#note[
  *Vitali vs. LDCT*: The Vitali Convergence Theorem is strictly more general than LDCT on finite measure spaces. The condition $|f_n| <= g in L^1$ implies uniform integrability, but uniform integrability does not require a single dominating function. This is particularly useful in probability theory and in situations where the "envelope" of the sequence is not integrable but the sequence still has controlled tails.
]

#example[
  *Vitali applies but LDCT does not*: On $([0,1], cal(L), m)$, let $f_n = n^(1\/2) chi_([0, 1\/n])$. Then $f_n -> 0$ a.e. and $integral |f_n| = n^(-1\/2) -> 0$. The family ${f_n}$ is uniformly integrable (since $integral_({f_n > M}) f_n dif m <= n^(-1\/2) -> 0$), so Vitali's theorem applies. However, there is no single integrable function $g$ dominating all $f_n$, since $sup_n f_n (x) = infinity$ on a set of positive measure near $0$.
]

== Relation to Riemann Integral // 与黎曼积分的关系

// 本节聚焦于 Riemann 积分与 Lebesgue 积分的关系，不重复 Riemann 积分的定义（见数学分析笔记）。
This section focuses on the relationship between the Riemann integral and the Lebesgue integral. We assume familiarity with the Riemann integral as defined via Darboux upper and lower sums on bounded closed intervals.

=== Riemann Integrability Implies Lebesgue Integrability // Riemann 可积蕴含 Lebesgue 可积

#theorem(name: "Riemann Integrable Implies Lebesgue Integrable")[
  Let $f: [a, b] -> bb(R)$ be a bounded function. If $f$ is Riemann integrable on $[a, b]$, then $f$ is Lebesgue integrable on $[a, b]$, and the two integrals coincide:
  $
  (R) integral_a^b f(x) dif x = (L) integral_([a,b]) f dif m.
  $
]

#proof[
  Let $P_n = {a = x_0 < x_1 < dots < x_(k_n) = b}$ be a sequence of partitions with mesh $|P_n| -> 0$. Define the lower and upper step functions:
  $
  l_n (x) = inf_(x in [x_(i-1), x_i]) f(x), quad u_n (x) = sup_(x in [x_(i-1), x_i]) f(x)
  $
  on each subinterval $(x_(i-1), x_i)$.

  Then $l_n$ and $u_n$ are measurable simple functions satisfying $l_n <= f <= u_n$ a.e. By refining partitions, we may assume $l_n <= l_(n+1)$ and $u_n >= u_(n+1)$.

  Let $l = lim_(n->infinity) l_n$ and $u = lim_(n->infinity) u_n$. By the Monotone Convergence Theorem:
  $
  integral_([a,b]) l dif m = lim_(n->infinity) integral_([a,b]) l_n dif m = lim_(n->infinity) L(f, P_n) = (R) integral_a^b f dif x,
  $
  and similarly $integral_([a,b]) u dif m = (R) integral_a^b f dif x$.

  Since $l <= f <= u$ a.e. and $integral l = integral u$, we conclude $f = l = u$ a.e., hence $f$ is measurable and Lebesgue integrable with $integral_([a,b]) f dif m = (R) integral_a^b f dif x$.
]

#note[
  The converse is false: a Lebesgue integrable function need not be Riemann integrable. The Dirichlet function $chi_(bb(Q) inter [0,1])$ is Lebesgue integrable (with integral $0$) but not Riemann integrable.
]

=== Lebesgue's Criterion // Lebesgue 判据

// Lebesgue 判据的完整证明见数学分析笔记，这里仅陈述结论并从测度论视角解读。
The following characterization of Riemann integrability is proved in classical analysis (see the Analyse Mathématique notes). We state it here for reference and interpret it from the measure-theoretic viewpoint.

#theorem(name: "Lebesgue's Criterion for Riemann Integrability")[
  Let $f: [a, b] -> bb(R)$ be a bounded function, and let $D_f = {x in [a, b] : f "is discontinuous at" x}$ denote the set of discontinuity points of $f$. Then
  $
  f "is Riemann integrable on" [a, b] <==> m(D_f) = 0.
  $
]

#note[
  From the measure-theoretic perspective, this criterion says: a bounded measurable function on $[a, b]$ is Riemann integrable if and only if it is "almost continuous" (continuous except on a null set). This explains why the Lebesgue integral is strictly more general — it can integrate any bounded measurable function, regardless of the size of its discontinuity set.
]

#example[
  *Thomae's function* (the Riemann function) $f: [0,1] -> bb(R)$ defined by $f(p\/q) = 1\/q$ for $p\/q$ in lowest terms and $f(x) = 0$ for $x in.not bb(Q)$. Its discontinuity set is $D_f = bb(Q) inter [0,1]$, which is countable and hence has measure zero. By Lebesgue's criterion, $f$ is Riemann integrable.
]

#example[
  *Dirichlet's function* $chi_(bb(Q) inter [0,1])$ is discontinuous everywhere, so $D_f = [0,1]$ and $m(D_f) = 1 != 0$. Hence it is not Riemann integrable. However, since $bb(Q) inter [0,1]$ is a null set, $chi_(bb(Q) inter [0,1]) = 0$ a.e., so it is Lebesgue integrable with $(L) integral_([0,1]) chi_(bb(Q)) dif m = 0$.
]

=== Improper Riemann Integrals // 反常 Riemann 积分

// 反常积分与 Lebesgue 积分的关系更为微妙：绝对收敛时一致，条件收敛时不一致。
The relationship between improper Riemann integrals and Lebesgue integrals is more subtle. The key distinction is that the Lebesgue integral requires absolute integrability.

#theorem(name: "Absolutely Convergent Improper Integrals")[
  Let $f: [a, infinity) -> bb(R)$ be locally Riemann integrable (i.e., Riemann integrable on every $[a, b]$). If the improper integral converges absolutely:
  $
  (R) integral_a^infinity |f(x)| dif x < infinity,
  $
  then $f in L^1 ([a, infinity), m)$ and
  $
  (L) integral_([a, infinity)) f dif m = lim_(b -> infinity) (R) integral_a^b f(x) dif x.
  $
]

#proof[
  For each $n in bb(N)$, define $f_n = f dot chi_([a, a+n])$. Then $f_n$ is Riemann integrable on $[a, a+n]$, hence Lebesgue integrable, and $|f_n| <= |f|$ with $f_n -> f$ pointwise.

  Since $(R) integral_a^infinity |f| dif x < infinity$, the function $|f|$ is Lebesgue integrable (by the same argument applied to $|f_n| arrow.t |f|$ and MCT). By the Dominated Convergence Theorem applied to $f_n$ with dominating function $|f| in L^1$:
  $
  (L) integral_([a,infinity)) f dif m = lim_(n->infinity) integral_([a, a+n]) f dif m = lim_(n->infinity) (R) integral_a^(a+n) f(x) dif x.
  $
]

#caution(title: "Conditional Convergence")[
  If the improper Riemann integral converges only conditionally (not absolutely), then $f in.not L^1$ and the Lebesgue integral does not exist. The Lebesgue integral is inherently an "absolute" integral.
]

#example[
  The function $f(x) = (sin x) / x$ on $[1, infinity)$ satisfies:
  $
  (R) integral_1^infinity frac(sin x, x) dif x "converges" quad "but" quad (R) integral_1^infinity frac(|sin x|, x) dif x = infinity.
  $
  Therefore $(sin x) / x in.not L^1 ([1, infinity))$, and the Lebesgue integral $(L) integral_([1,infinity)) (sin x) / x dif m$ does not exist. The improper Riemann integral captures a cancellation phenomenon that the Lebesgue integral cannot express.
]

=== Comparison Summary // 对比总结

#tex-table(
  ("Aspect", "Riemann Integral", "Lebesgue Integral"),
  ("Domain", "Bounded closed intervals", "General measure spaces"),
  ("Integrand", "Bounded functions", [Measurable; $f in L^1$ suffices]),
  ("Limit interchange", "Requires uniform convergence", "MCT, Fatou, DCT, Vitali"),
  ([Completeness of $L^1$], "No", "Yes"),
  ("Conditional convergence", "Allowed (improper)", "Not allowed (absolute only)"),
  ("Discontinuities", [Riemann integrable $<=>$ $m(D_f) = 0$], "Any measurable function"),
)

#note[
  In summary, the Lebesgue integral strictly generalizes the Riemann integral for bounded functions on bounded intervals. Its main advantages are: (1) much more powerful limit-interchange theorems, (2) completeness of $L^p$ spaces, and (3) applicability to general measure spaces. The price paid is the loss of conditional convergence — the Lebesgue integral is fundamentally an absolute integral.
]

== Product Measure and Fubini's Theorem// 乘积测度与Fubini定理

= Differential and Integral // 微分与积分
== Jump Functions and Dini Derivatives // 跳跃函数与 Dini 导数

// 导语：当导数尚未存在时，如何用更弱的局部斜率信息描述函数行为
// 本节是后面单调函数、Vitali 引理、绝对连续性的准备。

The theory of differentiation relies, at its core, on understanding how a function behaves locally. When a function is differentiable at a point, its derivative provides complete first-order local information. But what happens when the derivative does not exist? The following concepts — jump functions and Dini derivatives — offer two complementary ways to describe local behavior in the absence of full differentiability. They serve as foundational tools for the study of monotone functions, the Vitali covering lemma, and absolute continuity in the subsequent sections.

=== Jump Functions // 跳跃函数

// 跳跃函数是最简单的局部非光滑模型，代表"有断裂但仍可控"的行为

Jump functions are the simplest type of function that exhibits controlled discontinuities. A function is said to have a *jump* at a point if its left and right limits exist but differ.

#definition(name: "Jump Function (Saltus Function)")[
  A function $f: [a, b] -> bb(R)$ is called a *jump function* (or *saltus function*) if it is right-continuous with left limits (a *cadlag* function) and its discontinuities are all jump discontinuities. For each $x in [a, b]$, define the *jump size* at $x$ as
  $
  j_f (x) = f(x^+) - f(x^-),
  $
  where $f(x^+) = lim_(h -> 0^+) f(x + h)$ and $f(x^-) = lim_(h -> 0^+) f(x - h)$ (with the convention $f(a^-) = f(a)$ and $f(b^+) = f(b)$). The function $f$ is continuous at $x$ if and only if $j_f (x) = 0$.
]

#example[
  The *Heaviside step function*
  $
  H(x) = cases(0 & "if" x < 0, 1 & "if" x >= 0)
  $
  has a single jump at $x = 0$ with jump size $j_H(0) = 1$. It is the prototypical example of a jump function: piecewise constant, with one point of discontinuity where the function jumps from one value to another.
]

#note[
  Jump functions are intimately connected to two important classes of functions:
  - *Monotone functions*: Every monotone function on $[a, b]$ has at most countably many jump discontinuities. The sum of its jump sizes is bounded by $|f(b) - f(a)|$.
  - *Functions of bounded variation (BV)*: Every BV function can be decomposed uniquely as the sum of an absolutely continuous part, a jump part (a pure jump function), and a singular part (the Lebesgue decomposition of the distributional derivative).
]

=== Dini Derivatives // Dini 导数

// Dini 导数的四个版本：上下左右

When a function is not differentiable at a point, we can still extract useful local slope information by considering the limsup and liminf of difference quotients. The four *Dini derivatives* capture exactly this information.

#definition(name: "Dini Derivatives")[
  Let $f: [a, b] -> bb(R)$ be a function. For $x in (a, b)$, define the four Dini derivatives:

  *Upper right Dini derivative:*
  $ D^+ f(x) = limsup_(h -> 0^+) (f(x + h) - f(x)) / h, $

  *Lower right Dini derivative:*
  $ D_+ f(x) = liminf_(h -> 0^+) (f(x + h) - f(x)) / h, $

  *Upper left Dini derivative:*
  $ D^- f(x) = limsup_(h -> 0^-) (f(x + h) - f(x)) / h, $

  *Lower left Dini derivative:*
  $ D_- f(x) = liminf_(h -> 0^-) (f(x + h) - f(x)) / h, $

  where $h -> 0^-$ means $h$ approaches $0$ from below. For convenience, we also write $overline(D) f(x) = D^+ f(x)$ and $underline(D) f(x) = D_+ f(x)$ for the upper and lower derivatives (right-sided).
]

#note[
  *Relationship with the ordinary derivative*:
  - If $f$ is differentiable at $x$, then all four Dini derivatives coincide with $f'(x)$:
    $ D^+ f(x) = D_+ f(x) = D^- f(x) = D_- f(x) = f'(x). $
  - Conversely, if all four Dini derivatives exist and are equal (as finite numbers), then $f$ is differentiable at $x$ with that common value.
  - The key advantage of Dini derivatives is that they *always exist* (as extended real numbers) for any function, whereas the ordinary derivative may not.
]

#example[
  Consider $f(x) = |x| sin(1 / x)$ for $x != 0$ and $f(0) = 0$. This function is not differentiable at $x = 0$ because the difference quotient $(f(h) - f(0)) / h = |h| sin(1 / h) / h = "sgn"(h) sin(1 / h)$ oscillates between $-1$ and $1$ as $h -> 0$. However, the Dini derivatives at $0$ exist:
  $
  D^+ f(0) = 1, quad D_+ f(0) = -1, quad D^- f(0) = 1, quad D_- f(0) = -1.
  $
  The Dini derivatives capture the extremal slopes of the oscillations even though the ordinary derivative does not exist.
]

=== Local Behavior via Dini Derivatives // Dini 导数的局部性质

// 过渡：Dini 导数是分析单调性、局部 Lipschitz 性和可微性的工具

Dini derivatives serve as a versatile tool for extracting local information about a function's behavior without requiring full differentiability. The following observations illustrate their role:

#note[
  - *Monotonicity*: A function $f$ is non-decreasing on $[a, b]$ if and only if $D_+ f(x) >= 0$ for all $x in (a, b)$. Similarly, $f$ is non-increasing if and only if $D^+ f(x) <= 0$ for all $x$.
  
  - *Local Lipschitz property*: If all four Dini derivatives are uniformly bounded on $[a, b]$, then $f$ is Lipschitz continuous on $[a, b]$.
  
  - *Differentiability a.e.*: For monotone functions, the Dini derivatives satisfy $D^+ f(x) = D_- f(x)$ a.e. and $D_+ f(x) = D^- f(x)$ a.e. This symmetry is the first step toward proving that monotone functions are differentiable almost everywhere — a result that will be established through the Vitali covering lemma in the next section.
]

These properties highlight the central role of Dini derivatives: they provide a way to reason about differentiability and growth without assuming the derivative exists. The challenge, however, is that Dini derivatives are only pointwise quantities — to translate their local information into global (or almost everywhere) conclusions, we need a covering argument. This is precisely where the Vitali covering lemma comes in.

#v(0.5em)
// 过渡段：Dini 导数解决"局部斜率怎么看"，Vitali 覆盖解决"如何把局部信息提升成几乎处处结论"
Dini derivatives tell us how to measure local slopes; the Vitali covering lemma tells us how to lift these local measurements to almost-everywhere conclusions. Together, they form the backbone of the classical theory of differentiation. We now turn to the Vitali covering lemma and its applications.

== Vitali Coverings and the Vitali Lemma // Vitali 覆盖与 Vitali 引理

// Motivation: 为什么需要覆盖引理
// Dini 导数只提供逐点信息，要得到几乎处处结论，需要一种把"任意小区间"的局部信息
// 汇集为全局信息的技术手段。

Dini derivatives give us pointwise information about a function's local slope, but converting this into almost-everywhere conclusions requires a covering argument. The prototypical scenario is this: let $f$ be an increasing function on $[a, b]$, and suppose at each point $x$ in a set $E$ we know $D^+ f(x) > t$. We would like to bound $|f(b) - f(a)|$ from below by $t dot m(E)$. To do this, for each $x in E$ we pick a small interval $[x, x + h]$ (or $[x - h, x]$) where the difference quotient $(f(x + h) - f(x))/h$ exceeds $t$, then select a disjoint subfamily of these intervals and sum their lengths. The Vitali covering lemma turns this intuition into a rigorous tool.

#note[
  *Why a covering lemma?* Three key observations:
  - We need a family of arbitrarily small intervals covering *every* point of $E$ (a *Vitali covering*).
  - From this family we must extract a disjoint subcollection whose total length approximates the measure of $E$.
  - This same pattern — cover, extract, estimate — recurs throughout real analysis: Lebesgue density theorem, a.e. differentiability, differentiation of integrals.
]

=== Vitali Coverings // Vitali 覆盖

#definition(name: "Vitali Covering")[
  Let $E subset bb(R)$ and let $cal(V)$ be a collection of closed intervals in $bb(R)$. We say that $cal(V)$ is a *Vitali covering* of $E$ if for every $x in E$ and every $epsilon > 0$, there exists $I in cal(V)$ such that $x in I$ and $|I| < epsilon$.
  In other words, the collection $cal(V)$ contains intervals of arbitrarily small length that contain $x$.
]

#example[
  Consider $E = [0, 1]$ and let $cal(V) = {(x - delta, x + delta) : x in [0, 1], delta > 0}$. This is a Vitali covering of $[0, 1]$: every point $x$ is contained in intervals of every positive length.
]

#example[
  Let $cal(V) = {[k 2^(-n), (k+1) 2^(-n)] : n in bb(N), 0 <= k < 2^n}$ be the family of all dyadic intervals. Then $cal(V)$ is *not* a Vitali covering of $[0, 1]$. Although the intervals become arbitrarily small, at the point $x = 1/3$ (which has a non-terminating binary expansion) there is no dyadic interval that contains $1/3$ as an interior point — the dyadic grid does not align with every point.
]

=== Vitali Covering Lemma // Vitali 覆盖引理

// Vitali 覆盖引理是本节的核心理论工具
// 采用"二合一"版本：先给出可数/有限版本，再给出有限近似版本

#theorem(name: "Vitali Covering Lemma")[
  Let $E subset bb(R)$ with $m^*(E) < infinity$ and let $cal(V)$ be a Vitali covering of $E$. Then there exists a finite or countable disjoint subcollection ${I_k} subset.eq cal(V)$ such that

  $
  m^*(E backslash union.big_k I_k) = 0.
  $

  Equivalently, for every $epsilon > 0$, there exists a *finite* disjoint subcollection ${I_1, ..., I_N} subset.eq cal(V)$ satisfying

  $
  m^*(E backslash union.big_(k=1)^N I_k) < epsilon.
  $
]

#proof[
  *Step 1: Restrict to a bounded open set.*
  Since $m^*(E) < infinity$, there exists an open set $U$ such that $E subset U$ and $m(U) < infinity$. Discard all intervals of $cal(V)$ that are not contained in $U$; the remaining collection, call it $cal(V)_0$, is still a Vitali covering of $E$ (for each $x in E$, take an interval small enough to lie inside $U$).

  *Step 2: Greedy selection.*
  Define a size function on intervals: $r(I) = |I|$. Let $I_1 in cal(V)_0$ be any interval such that $r(I_1) > 1/2 sup{r(I) : I in cal(V)_0}$.

  Having chosen $I_1, ..., I_n$, let
  $
  cal(V)_n = {I in cal(V)_0 : I inter (union.big_(k=1)^n I_k) = emptyset}.
  $
  If $cal(V)_n != emptyset$, choose $I_(n+1) in cal(V)_n$ such that
  $
  r(I_(n+1)) > 1/2 sup{r(I) : I in cal(V)_n}.
  $
  If $cal(V)_n = emptyset$ for some $n$, then every point of $E$ lies in some $I_k$ ($k <= n$) and the lemma is proved. Otherwise we obtain an infinite sequence of disjoint intervals ${I_k}$.

  *Step 3: The total length is finite.*
  Since all intervals are disjoint and contained in $U$, we have
  $
  sum_(k=1)^infinity |I_k| <= m(U) < infinity.
  $
  In particular, $|I_k| -> 0$ as $k -> infinity$ and the tail sums $sum_(k=N+1)^infinity |I_k| -> 0$.

  *Step 4: The dilation trick.*
  For each chosen interval $I_k$, let $J_k$ be the closed interval concentric with $I_k$ but with five times the length: $|J_k| = 5 |I_k|$. We claim that
  $
  E backslash union.big_(k=1)^infinity I_k subset union.big_(k=1)^infinity J_k.
  $

  To see this, take any $x in E backslash union.big_k I_k$. Since $cal(V)_0$ is a Vitali covering, there exists $I in cal(V)_0$ such that $x in I$. Because $x$ does not belong to any $I_k$, the interval $I$ must intersect at least one selected $I_k$ (otherwise it would have been eligible for selection at every step, contradicting the greedy maximality). Let $N$ be the smallest index such that $I inter I_N != emptyset$.

  *Why $N$ is the first intersecting index:* By the greedy selection rule, when $I_N$ was chosen, we had $r(I_N) > 1/2 sup{r(J) : J in cal(V)_(N-1)}$. Since $I in cal(V)_(N-1)$ (it does not intersect $I_1, ..., I_(N-1)$ by minimality of $N$), we have $r(I) <= 2 r(I_N)$.

  Now compare the positions of $I$ and $I_N$. Since they intersect and $|I| <= 2 |I_N|$, a simple geometric argument shows that $I subset J_N$ (the 5-times concentric dilation of $I_N$). Hence $x in J_N$, establishing the claim.

  *Step 5: Measure estimate.*
  For any $N$,
  $
  m^*(E backslash union.big_(k=1)^N I_k) <= sum_(k=N+1)^infinity |J_k| = 5 sum_(k=N+1)^infinity |I_k|.
  $
  Since the tail sum tends to $0$, letting $N -> infinity$ gives $m^*(E backslash union.big_k I_k) = 0$ (the infinite version). For the finite version, given $epsilon > 0$, choose $N$ large enough so that $5 sum_(k=N+1)^infinity |I_k| < epsilon$; then ${I_1, ..., I_N}$ is the desired finite subcollection.
]

#note[
  *The key idea*: The greedy selection ensures that each chosen interval $I_k$ is "large" relative to every unchosen interval near it. Passing over an interval means it must be "close" to some previously chosen one, and the 5-times dilation captures all such overlooked intervals. The disjointness of the chosen intervals keeps their total measure under control, so the measure of what is missed by the first $N$ intervals shrinks to zero.
]

=== Forward-Looking Remarks // 前瞻

#note[
  The Vitali Covering Lemma is the engine behind three fundamental results that follow:
  - *Lebesgue Density Theorem*: Almost every point of a measurable set is a density point.
  - *Differentiability of Monotone Functions*: A monotone function on $[a, b]$ is differentiable a.e. — proved by applying Vitali to the sets where the Dini derivatives differ.
  - *Lebesgue Differentiation Theorem*: For $f in L^1_("loc")(bb(R))$,
    $lim_(r -> 0) 1/(2 r) integral_(x-r)^(x+r) f(t) dif t = f(x)$ for a.e. $x$.

  In this chapter, we will primarily use it to establish the a.e. differentiability of monotone functions, from which the remaining theory (BV decomposition, Newton-Leibniz formula) follows.
]

#v(0.5em)
With the Vitali covering lemma in hand, we can now return to the question left open in the previous section: are monotone functions differentiable almost everywhere? The answer is yes, and the lemma provides the precise covering argument needed.

== Monotone Functions on Closed Intervals // 闭区间上的单调函数

== Functions of Bounded Variation and Absolute Continuity // 有界变差函数与绝对连续函数

== Absolute Continuity and the Newton-Leibniz Formula // 绝对连续性与 Newton-Leibniz 公式