#import "../../../TypstTemplate/math-notes.typ": *

= Complex Integral // 复积分

== Complex Integral // 复积分
#definition(name: "Complex Integral")[
    Let $C: z=z(t), t in [alpha, beta]$ be an oriented curve in the complex plane starting at $a=z(alpha)$ and ending at $b=z(beta)$ and let $f(z)$ be a complex-valued function defined on $C$.
    
    From $a$ to $b$, take partitions of $C$ into $n$ segments by points $z_0=a, z_1, z_2, dots, z_n=b$.
    Then on each segment $z_(k-1)z_k$, take a point $xi_k$ and form the sum
    $
        sum_(k=1)^n f(xi_k)Delta z_(k), quad Delta z_(k) = z_k - z_(k-1).
    $   
    If the limit of the above sum exists as the maximum length of the segments tends to zero, then we call it the *complex integral* of $f$ along $C$, denoted by
    $
        integral_C f(z) "d"z.
    $
]

#property[
- *Linearity*: If $f$ and $g$ are integrable on $C$ and $alpha, beta in bb(C)$, then
$
    integral_C (alpha f(z) + beta g(z)) "d"z = alpha integral_C f(z) "d"z + beta integral_C g(z) "d"z.
$
- *Additivity*: If $C$ is the union of two oriented curves $C_1$ and $C_2$ such that the end point of $C_1$ is the starting point of $C_2$, then
$
    integral_C f(z) "d"z = integral_(C_1) f(z) "d"z + integral_(C_2) f(z) "d"z.
$
- *Reversal*: If $-C$ is the curve $C$ with the opposite orientation, then
$
    integral_(-C) f(z) "d"z = - integral_C f(z) "d"z.
$
- *Estimation*: If $f$ is integrable on $C$, let $L$ be the length of $C$ and $M = max_(z in C) |f(z)|$, then
$
    |integral_C f(z) "d"z| <= M L.
$
]

#theorem[
  If $f(z) = u(x, y) + "i" v(x, y)$ is continuous on $C$, then $f$ is integrable on $C$ and
$
    integral_C f(z) "d"z = integral_C u "d"x - integral_C v "d"y + "i" (integral_C v "d"x + integral_C u "d"y).
$
]

#proposition(name: "Some Common Integrals")[
- Let $C$ be any curve connecting $a$ and $b$, then
$
    integral_C "d"z = b - a.
$
- Let $C$ be any curve connecting $a$ and $b$, then
$
    integral_C z "d"z = frac{b^2 - a^2}{2}.
$
- Let $C$ be a circle centered at the origin with radius $r$ and let $n in bb(C)$, then
$
    integral_C 1/(z-a)^n "d"z = cases(
        0 & n != -1,
        2 pi"i" & n = -1
    )
$
]

== Cauchy-Goursat Theorem // 柯西-古尔萨定理

#theorem(name: "Cauchy-Goursat Theorem")[
    If $f(z)$ is analytic in a simply connected domain $D$ and $C$ is a closed curve in $D$, then
    $
        integral_C f(z) "d"z = 0.
    $
]

== Cauchy Integral Formula // 柯西积分公式
#theorem(name: "Cauchy Integral Formula")[
    If $f(z)$ is analytic in a simply connected domain $D$ and $C$ is a closed curve in $D$ that encloses a point $z_0$, then
    $
        f(z_0) = 1/(2 pi"i") integral_C f(z)/(z - z_0) "d"z.
    $
]