// 可测函数的定义：设 (X, 𝒮) 和 (Y, 𝒯) 为可测空间，若对于 𝒯 中每个集合 B，原像 f^(-1)(B) 都属于 𝒮，则称函数 f: X → Y 为 𝒮-𝒯 可测的

// 实值可测函数的特殊情况：当 Y = ℝ ̅ 且 𝒯 = ℬ(ℝ ̅) 为 ℝ 上的 Borel σ-代数时，若 f: X → ℝ 是 𝒮-ℬ(ℝ) 可测的，则称 f 为（实）可测函数
#import "../../../TypstTemplate/math-notes.typ": *

= Measurable Function
== Definition and Properties of Measurable Functions // 可测函数的定义和性质
#definition(name: "Measurable Function")[
    Let $(X, cal(S))$ and $(Y, cal(T))$ be measurable spaces. A function $f: X  -> Y$ is called *$cal(S)"-"cal(T)$ measurable* if for every set $B in cal(T)$, the preimage $f^(-1)(B) = {x in X : f(x) in B} in cal(S)$.
]
// 另一种定义中, f 定义在 X 的一个可测子集 E 上, 这本质上就是在子可测空间(E, cal(S)∣E​)上的全局可测函数, 因此两者是等价的.
In another definition, $f$ is defined on a measurable subset $E$ of $X$, then we can view $f$ as a globally measurable function on the subspace $(E, cal(S)|E)$, where $cal(S)|E = {A inter E : A in cal(S)}$ is the trace $sigma$-algebra on $E$. Thus, the two definitions are equivalent.


Specially, if $Y = overline(bb(R))$#footnote[Here, $overline(bb(R))$ denotes the extended real line] and $cal(T) = cal(B)(overline(bb(R)))$ is the Borel $sigma$-algebra on $bb(R)$, then a function $f: X  -> bb(R)$ is called *(real) measurable* if it is $cal(S)"-"cal(B)(bb(R))$ measurable.

// 下面给出可测函数的更常用的等价定义
Now we present some equivalent characterizations of measurable functions that are more commonly used.
#proposition(name: "Equivalent Characterizations of Measurable Functions")[
  Let $(X, cal(S))$ be a measurable space and $f: X  -> overline(bb(R))$ be a function. The following statements are equivalent:
  + $f$ is measurable.
  + For every $alpha in bb(R)$, the set ${x in X : f(x) > alpha} in cal(S)$.
  + For every $alpha in bb(R)$, the set ${x in X : f(x) >= alpha} in cal(S)$.
  + For every $alpha in bb(R)$, the set ${x in X : f(x) < alpha} in cal(S)$.
  + For every $alpha in bb(R)$, the set ${x in X : f(x) <= alpha} in cal(S)$.
]