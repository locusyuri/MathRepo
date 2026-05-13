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

==  // 解析函数零点孤立性



= Laurent Series // 洛朗级数

= Residue Theory // 留数理论

