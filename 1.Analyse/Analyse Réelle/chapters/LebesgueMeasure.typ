#import "../../../TypstTemplate/math-notes.typ": *

= Lebesgue Measure
== $sigma$-Algebra and Measure // Sigma 代数和测度
#definition(name: "Algebra of Sets")[
  Let $S$ be a non-empty set. A non-empty collection $cal(S)$ of subsets of $S$ (i.e., $cal(S) subset scr(P)(S) $) is called an *algebra of sets* on $S$ if it satisfies the following properties:
    + $S subset cal(S)$;
    + If $A in cal(S)$, then $S backslash A in cal(S)$;
    + If $A_1, A_2, dots A_n in cal(S)$, then $union.big_(i=1)^n A_i in cal(S)$.
]
Obviously, an algebra of sets is closed under finite unions and finite intersections.

#definition(name: "Sigma-Algebra")[
  Let $S$ be a non-empty set. A non-empty collection $cal(S)$ of subsets of $S$ (i.e., $cal(S) subset scr(P)(S) $) is called a *$sigma$-algebra* on $S$ if it satisfies the following properties:
    + $S subset cal(S)$;
    + If $A in cal(S)$, then $S backslash A in cal(S)$;
    + If $A_1, A_2, dots in cal(S)$, then $union.big_(i=1)^infinity A_i in cal(S)$.
]
Obviously, a sigma-algebra is closed under countable unions, countable intersections, and complements.

#note[
    $sigma$-algebra is the $sigma$-completion of algebra of sets. It inherits all the properties of algebra.
    
    Additionally, it requires closure under countable union (and hence countable intersection), which is the core of handling limit processes in analysis (such as interchange of integration and limits).
]
#definition(name: "Borel Set")[
    The *Borel $sigma$-algebra* on Euclidean space $bb(R)^n$, denoted by $cal(B)(bb(R)^n)$, is the smallest $sigma$-algebra containing all open sets in $bb(R)^n$. Sets in $cal(B)(bb(R)^n)$ are called *Borel sets*.
    
    Similarly, for any topological space $(X, tau)$, the *Borel $sigma$-algebra* on $X$, denoted by $cal(B)(X)$, is the smallest $sigma$-algebra containing all open sets in $X$.
]

#definition(name: "Measurable Space")[
    A *measurable space* is a pair $(X, cal(S))$ where $X$ is a set and $cal(S)$ is a $sigma$-algebra on $X$. The elements of $cal(S)$ are called *measurable sets*.
]
#definition(name: "Measure")[
    Let $(X, cal(S))$ be a measurable space. A *measure* on $(X, cal(S))$ is a function $mu: cal(S)  -> [0, infinity]$ that satisfies the following properties:
    + $mu(A) >= 0, forall A in cal(S)$;
    + $mu(emptyset) = 0$;
    + If $A_1, A_2, dots in cal(S)$ are pairwise disjoint, then $mu(union.big_(i=1)^infinity A_i) = sum_(i=1)^infinity mu(A_i)$.
]

#property(name: "Properties of Measures")[
  + *Monotonicity*: If $A subset B$ and $A, B in cal(S)$, then $mu(A) <= mu(B)$.
  + *Subtractivity*: If $A subset B$ and $A, B in cal(S), mu(B) < infinity$, then $mu(B) - mu(A) = mu(B backslash A)$.
  + *Subadditivity*: $mu(union.big_(i=1)^infinity A_i) <= sum_(i=1)^infinity mu(A_i)$.
  + *Continuity from Below and Above*: If $A_1 subset A_2 subset dots$ and $A_i in cal(S)$, then $mu(union.big_(i=1)^infinity A_i) = lim_(i->infinity) mu(A_i)$, and vice versa.
]

// 测度分类
There are various types of measures, 
+ *Finite Measure*: A measure $mu$ is called finite if $mu(X) < infinity$.
+ *$sigma$-Finite Measure*: A measure $mu$ is called $sigma$-finite if there exists a sequence of measurable sets $A_1, A_2, dots in cal(S)$ such that $X = union.big_(i=1)^infinity A_i$ and $mu(A_i) < infinity$ for all $i$.
+ *Probability Measure*: A measure $mu$ is called a probability measure if $mu(X) = 1$.
+ *Complete Measure*: A measure $mu$ is called complete if every subset of a null set (i.e., a set $A$ with $mu(A) = 0$) is measurable and has measure zero.

== Lebesgue Measure // 勒贝格测度
#definition(name: "Lebesgue Outer Measure")[
The *Lebesgue outer measure* on $bb(R)^n$ is defined for any set $A subset bb(R)^n$ as
$
m^*(A) = inf{ sum_(i=1)^infinity |I_i| : A subset union.big_(i=1)^infinity I_i, I_i "is an interval in" bb(R)^n }.
$
where $|I_i|$ denotes the volume of the interval $I_i$.
]

#property(name: "Properties of Lebesgue Outer Measure")[
  + *Monotonicity*: If $A subset B$, then $m^*(A) <= m^*(B)$.
  + *Countable Subadditivity*: For any sequence of sets $A_1, A_2, dots$, we have $m^*(union.big_(i=1)^infinity A_i) <= sum_(i=1)^infinity m^*(A_i)$.
  + *Translation Invariance*: For any set $A$ and any vector $v in bb(R)^n$, we have $m^*(A + v) = m^*(A)$.
  + *Scaling Invariance*: For any set $A$ and any scalar $c > 0$, we have $m^*(c A) = c^n m^*(A)$.
  + *Interval Property*: For any interval $I$, we have $m^*(I) = |I|$.
]

#definition(name: "Carathéodory Measurable Condition")[ // Carathéodory 可测性条件
A set $E subset bb(R)^n$ is called *Lebesgue measurable* if for every set $A subset bb(R)^n$, we have
$
m^*(A) = m^*(A inter E) + m^*(A inter E^("c")).
$
]

#proposition[
+ Borel sets are Lebesgue measurable, i.e., $cal(B)(bb(R)^n) subset cal(L)(bb(R)^n)$.
+ Null sets (i.e., sets with Lebesgue outer measure zero) are Lebesgue measurable, and any subset of a null set is also Lebesgue measurable.
]


#theorem[
  // 可测集族为 sigma-代数, 且m^*|cal(L)(bb(R)^n)是一个测度
  The collection of Lebesgue measurable sets $cal(L)(bb(R)^n)$ forms a $sigma$-algebra, and the restriction of the Lebesgue outer measure $m^*$ to $cal(L)(bb(R)^n)$ is a measure.
]


// 之后我们得到勒贝格测度的最终定义: 将勒贝格外测度限制在勒贝格可测集上，即 $m(A) = m^*(A)$ for all $A in cal(L)(bb(R)^n)$.
Thus, the *Lebesgue measure* on $bb(R)^n$ is defined as the restriction of the Lebesgue outer measure to the $sigma$-algebra of Lebesgue measurable sets, i.e., for any $A in cal(L)(bb(R)^n)$, we have
$
m(A) = m^*(A).
$

#definition(name: "Measure Space")[
  A *measure space* is a triple $(X, cal(S), mu)$ where $(X, cal(S))$ is a measurable space and $mu$ is a measure on $(X, cal(S))$.
]
#note[
  // 可测空间与测度空间的区别
  A measurable space consists of a set and a sigma-algebra, which defines the collection of measurable sets. #highlight[A measure space adds a measure function] that assigns a non-negative extended real number to each measurable set, quantifying its "size" in some sense.
]

#definition(name: "Lebesgue Measure Space")[
  $(bb(R)^n, cal(L)(bb(R)^n), m)$ is a $sigma$-finite, complete measure space, called the *Lebesgue measure space*.
]



== Non-Measurable Sets // 非可测集

== Other Views to introduce the Lebesgue Measure // 其他引入 Lebesgue 测度的视角

=== The Original Definition// 原始定义

#definition(name: "Measure of Bounded Open and Closed Sets")[
  For any non-empty bounded open set $G subset bb(R)$, we define its measure as
  $
  m(G) = sum_k (beta_k - alpha_k),
  $
  where $(alpha_k, beta_k)$ are the construction intervals of $G$ (i.e., $G = union.big_k (alpha_k, beta_k)$ is the representation of $G$ as a countable union of disjoint open intervals).

  For any bounded closed set $F subset bb(R)$, take any open interval $(a, b) supset F$ and let $G = (a, b) backslash F$ be the complement of $F$ in $(a, b)$. Then we define the measure of $F$ as
  $
  m(F) = m((a, b)) - m(G) = (b - a) - m(G).
  $ 
]

#definition(name: "Inner and Outer Measures")[
  For any set $E subset bb(R)$, we define its *inner measure* as
  $
  m_*(E) = sup{ m(F) : F subset E, F "is a bounded closed set" },
  $
  and its *outer measure* as
  $
  m^*(E) = inf{ m(G) : G supset E, G "is a bounded open set" }.
  $

  If $m_*(E) = m^*(E)$, then we say that $E$ is *Lebesgue measurable* and define its measure as $m(E) = m_*(E) = m^*(E)$.
]










// 可测函数的定义：设 (X, 𝒮) 和 (Y, 𝒯) 为可测空间，若对于 𝒯 中每个集合 B，原像 f^(-1)(B) 都属于 𝒮，则称函数 f: X → Y 为 𝒮-𝒯 可测的

// 实值可测函数的特殊情况：当 Y = ℝ ̅ 且 𝒯 = ℬ(ℝ ̅) 为 ℝ 上的 Borel σ-代数时，若 f: X → ℝ 是 𝒮-ℬ(ℝ) 可测的，则称 f 为（实）可测函数

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


#definition(name: "Simple Function")[
    A *simple function* is a measurable function that takes only a finite number of distinct values. Formally, a function $s: X  -> overline(bb(R))$ is simple if there exist distinct real numbers $a_1, a_2, dots, a_n$ and *disjoint* measurable sets $A_1, A_2, dots, A_n in cal(S)$ such that
    $
    s(x) = sum_(i=1)^n a_i chi_(A_i)(x),
    $
    where $A_1 union A_2 union dots union A_n = X$ and $chi_(A_i)$ is the indicator function of the set $A_i$.
]

#note[
// 一些教材中的定义仅要求值域为有限集合, 不要求定义域的分割集合是可测的, 但这会带来一些麻烦, 因此我们更常用上面这个定义.
Some textbooks define a simple function as a function that takes only a finite number of distinct values, without requiring the partition sets to be measurable. However, this can lead to trouble, as we prefer to define the partition sets to be measurable.
]

#property(name: "Properties of Simple Functions")[
+ Simple functions are measurable.
// 简单函数的和、差、积、商（分母不为零）、数乘仍然是简单函数
+ The sum, difference, product, and quotient (where the denominator is nonzero) of simple functions are still simple functions.

]