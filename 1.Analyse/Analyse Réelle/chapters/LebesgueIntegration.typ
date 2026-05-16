#import "../../../TypstTemplate/math-notes.typ": *

= Lebesgue Integration
== Lebesgue Integration
=== Definition of the Lebesgue Integral // 勒贝格积分的定义

#definition(name: "Lebesgue Integral of Simple Functions")[ // 简单函数的 Lebesgue 积分
Let $(X, cal(F), mu)$ be a measure space and $s: X -> [0, infinity)$ a simple function.
$s(x)$ can be expressed as $s(x) = sum_{i=1}^n a_i chi_{A_i}(x)$, where $a_i >= 0$ and $A_i in cal(F)$ are disjoint measurable sets. The Lebesgue integral of $s$ with respect to $mu$ is defined as:
$
integral_X s dif mu = sum_{i=1}^n a_i mu(A_i)
$
]

=== Properties of the Lebesgue Integral // 勒贝格积分的性质

== Limit of Integral Sequences // 积分序列的极限

== Relation to Riemann Integral // 与黎曼积分的关系

== Product Measure and Fubini's Theorem// 乘积测度与Fubini定理

= Differential and Integral // 微分与积分