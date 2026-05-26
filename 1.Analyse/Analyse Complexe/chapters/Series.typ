#import "../../../TypstTemplate/math-notes.typ": *


= Power Series and Taylor Series // 幂级数和泰勒级数
== Complex Series // 复级数
// 实数级数中, 只依赖距离和完备性的结论都能直接推广到复数级数 (绝对值替换成模); 但依赖序结构和特殊交错形式的结论不能。复数引入模后，许多判别法变得更统一，但条件收敛行为更复杂。
In real analysis, only the results that depend on completeness and distance can be directly extended to complex analysis (absolute value replaced by modulus); but the results that depend on order structure and special interleaving form cannot. After introducing the modulus, many criteria become more uniform, but the conditions of convergent behavior become more complex.

// 下面我们复级数区别于实数级数的部分
In the following, we will focus on the parts where complex series differ from real series.

=== Rearrangement of Series // 级数的重排
// 对于实数级数，条件收敛的级数可通过重排收敛到任意实数。
// 对于复数级数，情况更复杂（因为条件收敛的实部和虚部各自可能条件收敛），但绝对收敛的复数级数可以任意重排而不改变和，这和实数完全一样。
For real series, conditionally convergent series can be rearranged to converge to any real number. 

For complex series, the situation is more complicated (because the real and imaginary parts of a conditionally convergent series may each be conditionally convergent), but absolutely convergent complex series can be rearranged arbitrarily without changing the sum, which is exactly the same as for real series.


=== Abel's Theorem for Power Series // 幂级数的阿贝尔定理


== Taylor Series 

#theorem(name: "Taylor's Theorem")[
Let $f(z)$ be holomorphic in region $D subset CC$ and $z_0 in D$. Then there exists the unique power series expansion of $f$ at $z_0$:
$
f(z) = sum_(n=0)^infinity c_n (z - z_0)^n,
$
where 
$
  c_n = 1/(2 pi "i") integral_(|z-z_0|=r) f(z)/(z-z_0)^(n+1) dif z = f^(n)(z_0)/n!,
$
and the radius of convergence of this power series is at least the distance from $z_0$ to the boundary of $D$.
]

== Isolation and Uniqueness of Zeros of Analytic Functions // 解析函数零点孤立性与唯一性
#definition(name: "m-th Order Zero")[ // m阶零点
Let $f(z)$ be analytic in region $D subset CC$ and $z_0 in D$. We say that $z_0$ is an $m$-th order zero of $f$ if 
$
f(z_0) = f'(z_0) = ... = f^(m-1)(z_0) = 0, quad f^(m)(z_0) != 0.
$
]

#theorem[
The point $z_0$ is an $m$-th order zero of the analytic function $f(z)$ that is not identically zero if and only if 
$
f(z) = (z - z_0)^m g(z),
$
where $g(z)$ is analytic in a neighborhood of $z_0$ and $g(z_0) != 0$.
]

#theorem(name: "Isolation of Zeros")[
Let $f(z)$ be an analytic function in region $D subset CC$ that is not identically zero. Then the zeros of $f$ are isolated, i.e., for each zero $z_0$ of $f$, there exists a neighborhood of $z_0$ that contains no other zeros of $f$.
]

#theorem(name: "Uniqueness of Zeros")[
Let $f_1(z), f_2(z)$ be analytic functions in region $D subset CC$ that are not identically zero.
There is a sequence ${z_n} (z!=z_0)$ that is converging to $z_0$ such that $f_1(z_n) = f_2(z_n) = 0$ for all $n$.
Then $f_1(z) equiv f_2(z)$ for all $z in D$.
]


#theorem(name: "Maximum Modulus Principle")[ // 最大模原理
Let $f(z)$ be a non-constant analytic function in a bounded region $D subset CC$ that is continuous on the closure of $D$. Then the maximum of $|f(z)|$ on the closure of $D$ is attained on the boundary of $D$.
]

= Laurent Series // 洛朗级数
== Laurent Series // 洛朗级数
Considering two series:
$
  c_0 + c_1 (z-z_0) + c_2 (z-z_0)^2 + ..., \
  c_{-1}/(z-z_0) + c_{-2}/(z-z_0)^2 + dots .
$
The first one is a power series, which stands for an analytic function $f_1(z)$ in a convergent disk $|z-z_0| < R (0<R<=infinity)$.
As for the second one, let $zeta = 1/(z-z_0)$, then it becomes a power series in $zeta$:
$
  c_{-1} zeta + c_{-2} zeta^2 + dots,
$
which stands for an analytic function $f_2(zeta)$ in a convergent disk $|zeta| < 1/r (0< 1/r <= infinity)$.
That is, the second series stands for an analytic function $f_2(z)$ in the region $|z-z_0| > r (0<r<=infinity)$.
If there exists a non-empty annulus $r < |z-z_0| < R$, then the sum of the two series, called a two-sided power series, denoted as



#eq[
  $
  sum_(n=-infinity)^infinity c_n (z-z_0)^n.
  $
] <two-sided-power-series>

#property[
  Let the convergent disk of series @two-sided-power-series be
  $
    H: r < |z-z_0| < R (0<=r<R<=infinity).
  $
  Then:
  + @two-sided-power-series absolutely converges and internally closed uniformly converges to $f(z) = f_1(z) + f_2(z)$ in $H$.
  + $f(z)$ is analytic in $H$ .
  + $f(z) = sum_(n=-infinity)^infinity c_n (z-z_0)^n$ in H can be termwise differentiated $p$ times.  // 函数在 H 内可以逐项求导 p 次
  + $f(z)$ can be integrated along any path in $H$, and the integral equals the sum of the integrals of the terms.
]

#theorem(name: "Laurent's Theorem")[
Let $f(z)$ is analytic in the annulus $H: r < |z-z_0| < R (0<=r<R<=infinity)$.
Then $f(z)$ can be represented as a two-sided power series:
$
  f(z) = sum_(n=-infinity)^infinity c_n (z-z_0)^n,
$
where
$
  c_n = 1/(2 pi"i") integral_(|z-z_0|=rho) f(z)/(z-z_0)^(n+1) dif z, quad r < rho < R, n = 0, plus.minus 1, plus.minus 2, ...
$
]

== Classification of Singularities // 奇点的分类
#theorem(name: "Isolated Singularities")[
Let $f(z)$ be an analytic function in the punctured disk $0 < |z-z_0| < R (0<R<=infinity)$.
Then $z_0$ is called an isolated singularity of $f$.
]

If $z_0$ is an isolated singularity of $f$, then $f(z)$ can be represented as a Laurent series in the annulus $0 < |z-z_0| < R$.
There are two common methods to expand $f(z)$ into a Laurent series:
+ Method 1: Directly compute the coefficients $c_n$ using the integral formula.
+ Method 2: According to the uniqueness of the series composed of positive and negative power terms, use algebraic calculations, variable substitution, and Taylor expansion to obtain the Laurent series expansion. // 根据正负幂项组成的级数的唯一性, 使用代数计算、变量代换，并利用泰勒展开去求得洛朗展开式。

Let the Laurent series expansion of $f(z)$ at $z_0$ be
$
  f(z) = sum_(n=-infinity)^infinity c_n (z-z_0)^n.
$
Then we called non-minus power terms $c_n (z-z_0)^n$ the regular part of $f(z)$ at $z_0$, and the minus power terms $c_(-n) (z-z_0)^(-n)$ the principal part of $f(z)$ at $z_0$. Then we can classify the isolated singularity $z_0$ of $f(z)$ as follows:
+ If the principal part of $f(z)$ at $z_0$ is identically zero, i.e., $c_n = 0$ for all $n < 0$, then $z_0$ is called a removable singularity of $f(z)$.
+ If the principal part of $f(z)$ at $z_0$ has only finitely many non-zero terms, i.e., there exists a positive integer $m$ such that $c_n = 0$ for all $n < -m$, then $z_0$ is called a pole of order $m$ of $f(z)$.
+ If the principal part of $f(z)$ at $z_0$ has infinitely many non-zero terms, i.e., $c_n != 0$ for infinitely many negative integers $n$, then $z_0$ is called an essential singularity of $f(z)$.

= Residue Theory // 留数理论

