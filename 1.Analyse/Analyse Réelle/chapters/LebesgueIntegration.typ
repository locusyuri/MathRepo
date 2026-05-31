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

== Vitali Coverings and the Vitali Lemma // Vitali 覆盖与 Vitali 引理

== Monotone Functions on Closed Intervals // 闭区间上的单调函数

== Functions of Bounded Variation and Absolute Continuity // 有界变差函数与绝对连续函数

== Absolute Continuity and the Newton-Leibniz Formula // 绝对连续性与 Newton-Leibniz 公式