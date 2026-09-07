#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Probabilités", // 概率论
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Probabilités", // 概率论
  "Violet",
  subtitle: "A notebook for probability",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This is a notebook for probability.",
)

#make-outline(depth: 2, title: "Contents")

#part("Fundamentals of Probability")
= Random Events and Probability // 随机事件与概率

== Random Events and Operations // 随机事件及其运算

Probability theory is the mathematical study of *random phenomena* —
experiments whose outcome cannot be predicted with certainty even when
repeated under identical conditions. A *random experiment* is characterized by
three features: it can be repeated under (at least conceptually) identical
conditions; the set of all possible outcomes is known in advance; and the
individual outcome of a single trial is not predictable.

#definition(name: "Sample Space")[
  The set of all possible outcomes of a random experiment is called its
  *sample space*, denoted $Omega$; each individual outcome $omega$ is a
  *sample point*.
] <def:sample-space>

#example[
  - Tossing a coin once: $Omega = {H, T}$.
  - Rolling a die: $Omega = {1, 2, 3, 4, 5, 6}$.
  - Recording the lifetime of a light bulb: $Omega = [0, infinity)$, an
    uncountable sample space.
] <ex:sample-spaces>

#definition(name: "Random Event")[
  A *random event* is a subset of the sample space $Omega$. An event $A$ *occurs* if the observed outcome $omega$ belongs to $A$.

  An event consisting of a single point is *elementary* (a *simple event*). The whole space $Omega$ is the *certain event* (always occurs) and the empty set is the *impossible event* (never occurs).
] <def:event>

Events are mathematical objects of exactly the same nature as sets, so the
set language developed in the Théorie des Ensembles note applies verbatim —
the only difference is vocabulary ("or" for union, "and" for intersection).

#definition(name: "Relations between Events")[
  Let $A, B$ be events in $Omega$.

  - $A$ *implies* $B$ (written $A subset.eq B$) if every outcome of $A$ is an
    outcome of $B$;
  - $A$ and $B$ are *equal* (written $A = B$) if $A subset.eq B$ and
    $B subset.eq A$;
  - $A$ and $B$ are *mutually exclusive* (disjoint) if $A inter B = emptyset$;
  - $A$ and $B$ are *complementary* (opposite) if $A inter B = emptyset$ and
    $A union B = Omega$; the complement of $A$ is written $overline(A)$.
] <def:event-relations>

#definition(name: "Operations on Events")[
  The operations on events are the set operations: $A union B$ ("$A$ or
  $B$"), $A inter B$ ("$A$ and $B$"), and the difference
  $
    A backslash B = A inter overline(B).
  $
  Unions and intersections extend to arbitrary families
  $union.big_(i) A_i$, $inter.big_(i) A_i$, and they obey the *De Morgan
  laws*
  $
    overline(A union B) = overline(A) inter overline(B),
    quad
    overline(A inter B) = overline(A) union overline(B).
  $
] <def:event-operations>

#example[
  Roll a die and let $A = {2, 4, 6}$ (even), $B = {1, 2, 3}$ (at most $3$).
  Then
  $
    A union B = {1, 2, 3, 4, 6},
    quad
    A inter B = {2},
    quad
    A backslash B = {4, 6},
    quad
    overline(A) = {1, 3, 5}.
  $
  The events $A$ and $overline(B) = {4, 5, 6}$ are not disjoint, since
  $A inter overline(B) = {4, 6} != emptyset$; likewise $A$ and $B$ share the
  point $2$.
  De Morgan's law checks: $overline(A union B) = {5} = overline(A) inter
  overline(B) = {1, 3, 5} inter {4, 5, 6} = {5}$.
] <ex:event-operations>

#figure(
  image("img/venn-operations.svg", width: 78%),
  caption: [Venn diagrams of the four basic operations on two events
    $A, B$: union $A union B$ (top left), intersection $A inter B$ (top
    right), difference $A backslash B$ (bottom left), and complement
    $overline(A)$ (bottom right).],
  placement: auto,
  supplement: [Fig.],
) <fig:venn-operations>

In finitely many-outcome experiments it is natural to allow *every* subset as
an event. For general sample spaces, however, one restricts attention to a
family closed under the operations above.

#definition(name: "Event Field")[
  A *field of events* (a $sigma$-field on $Omega$) is a family $cal(F)$ of subsets of $Omega$ such that
  - $Omega in cal(F)$;
  - $A in cal(F)$ implies $overline(A) in cal(F)$;
  - $A_1, A_2, dots in cal(F)$ implies $union.big_(n=1)^infinity A_n in cal(F)$.

  The pair $(Omega, cal(F))$ is called a *measurable space*, and the elements of
  $cal(F)$ are the *events*.
] <def:event-field>

#note[
  The systematic construction of $sigma$-fields belongs to measure theory and
  is developed in the Théorie des Ensembles note. Throughout this note the
  ambient $sigma$-field is tacitly fixed: $cal(F) = cal(P)(Omega)$ for finite or
  countable $Omega$, and the Borel $sigma$-field for $Omega = RR$.
]

Events describe *what can happen*; assigning numbers to events — measuring
"how likely" each one is — is the task of the next section, and a random
variable will then simply be a device that converts outcomes into numbers so
that distributions can be studied with the tools of analysis.

== Definitions of Probability // 概率的定义

Intuitively, the probability of an event is a number measuring the likelihood
of its occurrence. This intuition acquires mathematical meaning through an
axiom system; before stating it, we examine the empirical notion from which
it abstracts.

#property(name: "Frequencies and Their Stability")[
  Repeating an experiment $n$ times, let $n_A$ be the number of trials in
  which the event $A$ occurs. The ratio
  $
    f_(n)(A) = n_A / n
  $
  is the *frequency* of $A$. Frequencies satisfy $0 <= f_(n)(A) <= 1$,
  $f_(n)(Omega) = 1$, and $f_(n)(A union B) = f_(n)(A) + f_(n)(B)$ whenever
  $A inter B = emptyset$. Empirically, as $n$ grows, $f_(n)(A)$ *stabilizes*
  around a definite value — this stable limit is taken as the *frequency
  definition of probability*, a very intuitive interpretation that predates
  the axiomatic framework: the probability of $A$ is the limiting
  frequency $P(A) = lim_(n -> infinity) f_(n)(A)$.
] <prop:frequency-stability>

The stabilization of frequencies is itself a theorem, not an axiom — it is
Bernoulli's law of large numbers, proved in the Limit Theorems part. What the
axiomatic definition does is to fix the *idealized limit object* directly and
derive everything else from it.

#definition(name: "Axiomatic Definition of Probability")[
  Let $(Omega, cal(F))$ be a measurable space. A *probability measure* is a
  function $P: cal(F) -> [0, 1]$ such that

  - (non-negativity) $P(A) >= 0$ for all $A in cal(F)$;
  - (normalization) $P(Omega) = 1$;
  - (countable additivity) for every sequence of pairwise disjoint events
    $A_1, A_2, dots$,
    $
      P(union.big_(n=1)^infinity A_n) = sum_(n=1)^infinity P(A_n).
    $

  The triple $(Omega, cal(F), P)$ is a *probability space*.
] <def:probability-axioms>

#definition(name: "Classical Probability")[
  Let $Omega$ be finite and all its outcomes equally likely (the *classical
  model*). For $A subset.eq Omega$,
  $
    P(A) = abs(A) / abs(Omega)
    = ("favourable outcomes") / ("possible outcomes").
  $
] <def:classical-probability>

#example[
  An urn contains $N$ balls, $K$ of them red; $n$ balls are drawn. Let
  $A_(n, k)$ be the event "exactly $k$ red balls are drawn". According to the
  drawing protocol, the classical formula gives:

  - *without replacement, unordered* (hypergeometric model):
    $
      P(A_(n, k)) = binom(K, k) binom(N - K, n - k) / binom(N, n);
    $
  - *without replacement, ordered*: the count of ordered draws with $k$ red
    balls divided by $N^underline(n)$ gives the same value — the ordering
    cancels;
  - *with replacement, ordered* (binomial model):
    $
      P(A_(n, k)) = binom(n, k) (K \/ N)^k (1 - K \/ N)^(n - k);
    $
  - *with replacement, unordered*: a third value, rarely of practical
    interest, as physical drawing protocols are ordered.

  The lesson: the probability depends on the *physical protocol*, and the
  combinatorial bookkeeping must match it.
] <ex:balls-sampling>

#example(name: "Matching problem")[
  $n$ gentlemen check their hats; the hats are returned at
  random, one to each. What is the probability that *at least one* gentleman
  receives his own hat? Let $A_i$ be the event that gentleman $i$ gets his
  own hat. The event of interest is $union.big_(i=1)^n A_i$, and the
  inclusion–exclusion principle (proved in the Combinatoire note) with
  $abs(A_(i_1) inter dots inter A_(i_k)) = (n - k)!$ gives
  $
    P(union.big_(i=1)^n A_i)
    = sum_(k=1)^n (-1)^(k+1) binom(n, k) (n - k)! / n!
    = 1 - sum_(k=0)^n (-1)^k / k!
    -> 1 - 1 / e quad (n -> infinity),
  $
  where the last step uses the derangement count established in the
  Combinatoire note. The probability is already about $0.632$ for small
  $n$ and stays there.
] <ex:matching-problem>

#definition(name: "Geometric Probability")[
  Let $Omega subset.eq RR^d$ be a region of finite measure (length, area or
  volume) and suppose the outcome is "uniformly distributed" over $Omega$ in
  the sense that the probability of landing in a region depends only on its
  measure. For $A subset.eq Omega$,
  $
    P(A) = m(A) / m(Omega),
  $
  where $m$ is length, area or volume as appropriate.
] <def:geometric-probability>

#example(name: "Meeting problem")[
  Two friends agree to meet at a fixed spot between
  noon and $1$ pm; each arrives at a time uniformly distributed over the
  hour, independently of the other, and waits $15$ minutes before leaving.
  What is the probability that they meet? Model the two arrival times by a
  point $(x, y)$ of the square $[0, 1]^2$; they meet iff
  $abs(x - y) <= 1 \/ 4$ (see @fig:meeting-problem). The complementary
  region consists of two triangles of total area $(3 \/ 4)^2$, so
  $
    P("they meet") = 1 - (3 / 4)^2 = 7 / 16.
  $
] <ex:meeting-problem>

#figure(
  image("img/meeting-problem.svg", width: 62%),
  caption: [The meeting problem: the square $[0, 1]^2$ of arrival-time pairs;
    the shaded band $abs(x - y) <= 1 \/ 4$ is the meeting region, and the two
    unshaded right triangles form its complement.],
  placement: auto,
  supplement: [Fig.],
) <fig:meeting-problem>

#example(name: "Buffon's needle")[
  A floor is ruled with parallel lines at spacing $d$.
  A needle of length $ell < d$ is dropped at random. What is the probability
  that it crosses a line?

  Parameterise the needle's position by the distance $x$ from its midpoint
  to the nearest line ($x in [0, d\/2]$) and its angle $theta$ with the
  lines ($theta in [0, pi]$). The needle crosses a line iff
  $
    (ell / 2) sin theta >= x.
  $
  With uniform $x$ and $theta$ on $[0, d\/2] times [0, pi]$, the crossing
  region has area
  $
    integral_0^pi (ell / 2) sin theta dif theta = ell,
  $
  while the full rectangle has area $d\/2 dot pi$. Hence
  $
    P("cross") = (2 ell) / (d pi)
  $
  (see @fig:buffon-needle). Inverting this formula gives a celebrated
  experimental estimate of $pi$: drop the needle many times, count the
  fraction that cross, and set $pi approx (2 ell) / (d dot f_(n))$.
] <ex:buffon-needle>

#figure(
  image("img/buffon-needle.svg", width: 65%),
  caption: [Buffon's needle: parallel lines at spacing $d$, a needle of
    length $ell$ at angle $theta$ whose midpoint is at distance $x$ from the
    nearest line. The needle crosses iff $(ell\/2) sin theta >= x$; the shaded
    region in the $(theta, x)$-rectangle $[0, pi] times [0, d\/2]$ marks the
    crossing condition.],
  placement: auto,
  supplement: [Fig.],
) <fig:buffon-needle>

#example(name: "Bertrand's paradox")[
  Choose "a chord of a circle at random" and ask for
  the probability that it is longer than the side of the inscribed equilateral
  triangle. Three natural-sounding randomization mechanisms give three
  different answers (see @fig:bertrand-paradox):

  - *Random endpoints:* pick two points uniformly on the circumference;
    the chord exceeds the side iff the arc between them is more than
    $1\/3$ of the circle, giving $P = 1\/3$.
  - *Random radius + point:* pick a radius uniformly, then a point
    uniformly on it; the chord is perpendicular to that radius at the
    point, and exceeds the side iff the point lies inside the concentric
    disc of radius $r\/2$, giving $P = 1\/2$.
  - *Random midpoint:* pick the chord midpoint uniformly in the disc;
    the chord exceeds the side iff the midpoint lies inside the disc of
    radius $r\/2$ (the inscribed triangle's incircle), giving
    $P = (r\/2)^2 / r^2 = 1\/4$.

  The paradox does not reveal a contradiction in probability theory — it
  shows that "uniformly random" must specify *the mechanism generating
  the outcomes*, exactly as the urn example of
  #link(<ex:balls-sampling>)[the drawing protocols] warned. A geometric
  model is well-posed only once $Omega$ and its uniform measure are pinned
  down.
] <ex:bertrand-paradox>

#figure(
  image("img/bertrand-paradox.svg", width: 90%),
  caption: [Bertrand's paradox: three ways of choosing a "random chord" lead
    to three different probabilities ($1\/3$, $1\/2$, $1\/4$) that it exceeds
    the side of the inscribed equilateral triangle. Left: random endpoints on
    the circumference. Middle: random radius with a random point on it. Right:
    random midpoint in the disc. Each panel shows the favourable region (shaded)
    within the relevant sample space.],
  placement: auto,
  supplement: [Fig.],
) <fig:bertrand-paradox>

#note[
  (Subjective probability.) In situations with no repeatable experiment —
  e.g. "the candidate will win the election" — practitioners assign
  *degrees of belief* obeying the same axioms. This Bayesian viewpoint,
  axiomatized by de Finetti and Savage, will resurface when prior
  distributions are discussed; the present note works with the objective
  axiomatic framework of #link(<def:probability-axioms>)[Kolmogorov].
]

== Properties of Probability // 概率的性质

The axioms of #link(<def:probability-axioms>)[the definition] already contain
the whole theory of $P$; this section unwinds its first consequences.

#property(name: "Finite Additivity and Consequences")[
  Let $P$ be a probability measure.

  - $P(emptyset) = 0$;
  - finite additivity: for pairwise disjoint $A_1, dots, A_n$,
    $
      P(union.big_(i=1)^n A_i) = sum_(i=1)^n P(A_i);
    $
  - complement rule: $P(overline(A)) = 1 - P(A)$;
  - Boole's inequality (subadditivity): for any events $A_1, dots, A_n$,
    $
      P(union.big_(i=1)^n A_i) <= sum_(i=1)^n P(A_i).
    $
] <prop:probability-additivity>

#proof[
  Take $A_1 = Omega$ and $A_n = emptyset$ for $n >= 2$ in countable
  additivity: $1 = P(Omega) = P(Omega) + P(emptyset) + P(emptyset) + dots$,
  so $P(emptyset) = 0$. For finite additivity, extend a finite disjoint
  family by infinitely many copies of $emptyset$ and use countable
  additivity. The complement rule follows from disjointness of $A$ and
  $overline(A)$. For Boole's inequality, decompose $union A_i$ into
  pairwise disjoint pieces $B_i = A_i backslash (A_1 union dots union
    A_(i-1))$, note $B_i subset.eq A_i$, and apply finite additivity to the
  $B_i$ together with #link(<prop:probability-monotonicity>)[monotonicity].
]

#property(name: "Monotonicity and Difference")[
  If $A subset.eq B$ then
  $
    P(B backslash A) = P(B) - P(A),
    quad "hence"
    quad P(A) <= P(B).
  $
  In particular $P(A) <= 1$ for every event $A$.
] <prop:probability-monotonicity>

#property(name: "Addition Formula (Inclusion–Exclusion)")[
  For any two events,
  $
    P(A union B) = P(A) + P(B) - P(A inter B),
  $
  and for any three,
  $
    P(A union B union C)
    = P(A) + P(B) + P(C)
    - P(A inter B) - P(A inter C) - P(B inter C)
    + P(A inter B inter C).
  $

  More generally, for any $n$ events $A_1, dots, A_n$,
  $
    P(union.big_(i=1)^n A_i)
    = sum_(k=1)^n (-1)^(k+1) S_k,
    quad S_k = sum_(1 <= i_1 < dots < i_k <= n) P(A_(i_1) inter dots inter A_(i_k)).
  $
  This is precisely the *inclusion–exclusion principle* of combinatorics,
  transferred to the probabilistic setting: the alternating sum
  overcounts and undercounts intersections to recover the probability of
  the union.
] <prop:addition-formula>

#proof[
  Decompose $A union B$ into the disjoint union
  $A union B = A union (B backslash (A inter B))$ and apply
  #link(<prop:probability-additivity>)[finite additivity] together with
  #link(<prop:probability-monotonicity>)[the difference formula]. The
  three-event version follows by the same decomposition. The general
  $n$-event case is the inclusion–exclusion principle: prove it by
  induction on $n$, decomposing $A_1 union dots union A_n$ as
  $A_1 union (A_2 union dots union A_n)$ and applying the two-event
  formula; the alternating signs arise from the recursive subtraction of
  pairwise, triplewise, $dots$ intersections.
]

The next theorem extends the addition pattern from finite unions to limits of
monotone sequences of events; it relies on the notion of limits of sequences
of sets from the Théorie des Ensembles note.

#theorem(name: "Continuity of Probability")[
  Let $(A_n)_(n >= 1)$ be a sequence of events.

  - If $A_1 subset.eq A_2 subset.eq dots$ is increasing, then
    $
      P(union.big_(n=1)^infinity A_n) = lim_(n -> infinity) P(A_n).
    $
  - If $A_1 supset.eq A_2 supset.eq dots$ is decreasing, then
    $
      P(inter.big_(n=1)^infinity A_n) = lim_(n -> infinity) P(A_n).
    $
] <thm:continuity-probability>

#proof[
  For the increasing case, set $A_0 = emptyset$ and decompose the union into
  the disjoint rings
  $B_n = A_n backslash A_(n - 1)$, so that
  $union.big_(n>=1) A_n = union.big_(n>=1) B_n$ with $B_i inter B_j =
  emptyset$ for $i != j$. Countable additivity and
  #link(<prop:probability-monotonicity>)[the difference formula] give
  $
    P(union.big_(n=1)^infinity A_n)
    = sum_(n=1)^infinity P(B_n)
    = lim_(N -> infinity) sum_(n=1)^N (P(A_n) - P(A_(n-1)))
    = lim_(N -> infinity) P(A_N),
  $
  the series telescoping. The decreasing case follows by taking complements:
  apply the increasing case to $overline(A_1) subset.eq overline(A_2) subset.eq
  dots$ and use the complement rule.
]

The continuity theorem reveals a fundamental equivalence: the
countable additivity axiom can be replaced by *finite additivity plus
lower continuity* — that is, the requirement that $P(A_n arrow.b A)$
implies $P(A_n) -> P(A)$.

#theorem(name: "Equivalence of Countable Additivity and Finite Additivity + Lower Continuity")[
  Let $P$ be a non-negative, normalized set function on
 $(Omega, cal(F))$. Then $P$ is countably additive if and only if $P$
  is finitely additive and *lower continuous*:
  $
    A_1 supset.eq A_2 supset.eq dots "with" inter.big_(n=1)^infinity A_n = emptyset
    quad arrow.r.double quad lim_(n -> infinity) P(A_n) = 0.
  $
] <thm:countable-additivity-equivalence>

#proof[
  ($arrow.r.double$) Countable additivity implies finite additivity
  (#link(<prop:probability-additivity>)[see above]) and, by the
  continuity theorem
  (#link(<thm:continuity-probability>)[continuity of probability]),
  lower continuity.

  ($arrow.l.double$) Given pairwise disjoint $A_1, A_2, dots$, set
  $B_n = union.big_(k=n)^infinity A_k$. Then $B_n arrow.b emptyset$
  and $union.big_(k=1)^infinity A_k = A_1 union B_2$. By finite
  additivity,
  $
    P(union.big_(k=1)^infinity A_k) = P(A_1) + P(B_2).
  $
  Iterating, $P(B_n) = sum_(k=n)^infinity P(A_k)$; lower continuity
  gives $P(B_n) -> 0$, so
  $
    P(union.big_(k=1)^infinity A_k)
    = sum_(k=1)^(n-1) P(A_k) + P(B_n)
    -> sum_(k=1)^infinity P(A_k).
  $
]

This equivalence is of more than theoretical interest: in many
constructions (e.g. extending a pre-measure from an algebra to a
$sigma$-field via Carathéodory's extension theorem), it is
finite additivity plus continuity that one verifies in practice.

Monotone limits prepare the language of "infinitely often", on which the
strong limit theorems of the Limit Theorems part rest.

#theorem(name: "Borel–Cantelli Lemmas")[
  Let $(A_n)_(n >= 1)$ be a sequence of events. The *upper limit*
  $lim"sup" A_n$ of the sequence is the event "$A_n$ infinitely often"
  ($A_n$ "i.o." for short):
  $
    lim"sup" A_n
    = inter.big_(N=1)^infinity union.big_(n=N)^infinity A_n.
  $

  - (First lemma) If $sum_(n=1)^infinity P(A_n) < infinity$, then
    $P(lim"sup" A_n) = 0$.
  - (Second lemma) If the $A_n$ are mutually independent and
    $sum_(n=1)^infinity P(A_n) = infinity$, then
    $P(lim"sup" A_n) = 1$.
] <thm:borel-cantelli>

#proof[
  (First lemma.) For every $N$,
  $lim"sup" A_n subset.eq union.big_(n=N)^infinity A_n$, so by
  #link(<prop:probability-additivity>)[Boole's inequality] (iterated)
  $
    P(lim"sup" A_n)
    <= sum_(n=N)^infinity P(A_n)
    -> 0 quad "as" N -> infinity,
  $
  since the tail of a convergent series tends to zero. (Second lemma:
  independence enters through a product inequality; its proof is deferred to
  the Limit Theorems part where independence in the limit sense has been
  developed.)
]

== Combinatorial Methods // 组合方法

In the classical model of #link(<def:classical-probability>)[the definition],
computing $P(A) = abs(A) \/ abs(Omega)$ is a *counting problem*. The tools —
permutations, combinations, and the addition and multiplication principles —
are developed once and for all in the Combinatoire note and are used here
without restatement; the examples below are chosen for their probabilistic
content.

#example[
  (Inclusion–exclusion in probability.) An integer is drawn uniformly at
  random from ${1, 2, dots, 1000}$. Let $D_2, D_3, D_5$ be the events that
  it is divisible by $2, 3, 5$ respectively. Then
  $P(D_2) = 1 \/ 2$, $P(D_3) = 1 \/ 3$, $P(D_5) = 1 \/ 5$, and
  $P(D_i inter D_j) = 1 \/ (i j)$ for distinct $i, j$, while
  $P(D_2 inter D_3 inter D_5) = 1 \/ 30$. By the inclusion–exclusion
  principle (the Combinatoire note again),
  $
    P(D_2 union D_3 union D_5)
    = 1/2 + 1/3 + 1/5 - 1/6 - 1/10 - 1/15 + 1/30
    = 11 / 15.
  $
] <ex:inclusion-exclusion-prob>

#example(name: "Pólya's urn")[
  An urn initially contains $a$ red and $b$ black balls. At
  each step one ball is drawn uniformly at random, its colour is noted, and
  it is returned together with $c$ additional balls of the *same colour*.
  Remarkably, the probability of drawing a red ball at step $k$ equals
  $a / (a + b)$ *for every* $k$: letting $X_(k-1)$ be the number of red
  balls drawn in the first $k - 1$ steps (and writing $E[X_(k-1)]$ for its
  average over the drawing protocols — the notion of expectation is made
  precise in the Numerical Characteristics part), the induction hypothesis
  $E[X_(k-1)] = (k - 1) a / (a + b)$ (trivial for $k = 1$) gives
  $
    P("red at step " k)
    = E[(a + c X_(k-1)) / (a + b + (k - 1) c)]
    = (a + c (k - 1) a / (a + b)) / (a + b + (k - 1) c)
    = a / (a + b).
  $
  The model produces reinforced randomness — early draws bias later ones —
  yet the marginal probability of each draw stays constant; this self-reinforcing
  structure reappears in Bayesian statistics as a predictive scheme.
] <ex:polya-urn>

= Conditional Probability and Independence // 条件概率与独立性

== Conditional Probability // 条件概率

New information changes probabilities. Knowing that event $B$ has occurred
restricts the sample space from $Omega$ to $B$, and the likelihood of $A$
must be re-evaluated *within this reduced space*.

#definition(name: "Conditional Probability")[
  Let $B in cal(F)$ with $P(B) > 0$. The *conditional probability* of $A$ given
  $B$ is
  $
    P(A | B) = (P(A inter B)) / (P(B)).
  $
] <def:conditional-probability>

#property(name: "Conditional Probability is a Probability")[
  For fixed $B$ with $P(B) > 0$, the map $A mapsto P(A | B)$ is a
  probability measure on $(Omega, cal(F))$: it is non-negative, satisfies
  $P(Omega | B) = 1$, and is countably additive.
] <prop:cond-prob-measure>

#proof[
  Non-negativity is clear since $P(A inter B) >= 0$. Normalization:
  $P(Omega | B) = P(B) / P(B) = 1$. Countable additivity: for pairwise
  disjoint $A_1, A_2, dots$, the sets $A_n inter B$ are pairwise disjoint as
  well, so countable additivity of $P$ gives
  $
    P(union.big_(n=1)^infinity A_n | B)
    = (P((union.big_(n=1)^infinity A_n) inter B)) / (P(B))
    = sum_(n=1)^infinity (P(A_n inter B)) / (P(B))
    = sum_(n=1)^infinity P(A_n | B).
  $
]

All properties proved in the preceding chapter therefore transfer verbatim
to $P(dot | B)$ — additivity, monotonicity, the addition formula,
continuity. Rewriting the definition as a product yields the workhorse of
sequential computations.

#property(name: "Multiplication Rule")[
  If $P(B) > 0$, then $P(A inter B) = P(B) P(A | B)$. More generally,
  for events $A_1, dots, A_n$ with $P(A_1 inter dots inter A_(n-1)) > 0$,
  $
    P(A_1 inter A_2 inter dots inter A_n)
    = P(A_1) P(A_2 | A_1) P(A_3 | A_1 inter A_2)
    dots P(A_n | A_1 inter dots inter A_(n-1)).
  $
] <prop:multiplication-rule>

#proof[
  The two-event case is the definition rearranged. The chain version
  follows by induction: multiply the definition of
  $P(A_n | A_1 inter dots inter A_(n-1))$ by
  $P(A_1 inter dots inter A_(n-1))$, which is positive by hypothesis, and
  apply the induction hypothesis to the product.
]

#example(name: "Drawing lots is fair")[
  $n$ people draw lots from a box containing one
  winning slip and $n - 1$ blanks, one after another without replacement.
  Intuition suggests — and suspicion doubts — that drawing early is
  advantageous. Let $W_i$ be the event that person $i$ wins. By
  #link(<prop:multiplication-rule>)[the multiplication rule], for person
  $k$ the preceding $k - 1$ draws must all miss:
  $
    P(W_k)
    = P(overline(W_1)) P(overline(W_2) | overline(W_1))
    dots P(W_k | overline(W_1) inter dots inter overline(W_(k-1)))
    = (n-1)/n dot (n-2)/(n-1) dots 1/(n-k+1)
    = 1 / n.
  $
  The probability of winning does not depend on the position: the protocol
  is fair.
] <ex:lottery-fairness>

== Total Probability and Bayes' Theorem // 全概率公式与 Bayes 公式

Conditional probabilities come with a dividend: the reduced space can be
*decomposed*, and probabilities reassembled from the pieces.

#definition(name: "Partition of the Sample Space")[
  Events $B_1, B_2, dots, B_n$ form a *partition* of $Omega$ if they are
  pairwise disjoint, have positive probability, and
  $
    B_1 union B_2 union dots union B_n = Omega.
  $
] <def:partition>

#theorem(name: "Law of Total Probability")[
  If $B_1, dots, B_n$ form a partition of $Omega$, then for any event $A$,
  $
    P(A) = sum_(i=1)^n P(B_i) P(A | B_i).
  $
] <thm:total-probability>

#proof[
  The sets $A inter B_i$ are pairwise disjoint and their union is
  $A inter (B_1 union dots union B_n) = A$. Countable additivity
  (#link(<prop:probability-additivity>)[finite additivity]) and the
  multiplication rule give the identity.
]

#theorem(name: "Bayes' Theorem")[
  If $B_1, dots, B_n$ form a partition of $Omega$ and $P(A) > 0$, then for
  each $j$,
  $
    P(B_j | A)
    = (P(B_j) P(A | B_j)) / (sum_(i=1)^n P(B_i) P(A | B_i)).
  $
] <thm:bayes>

#proof[
  By the definition of conditional probability,
  $P(B_j | A) = P(B_j inter A) / P(A)$; the numerator expands by the
  multiplication rule and the denominator is exactly the law of total
  probability.
]

#example(name: "Medical screening")[
  A disease affects $0.1%$ of a population. A test has
  sensitivity $P(+ | D) = 0.99$ (a sick person tests positive with
  probability $99%$) and specificity $P(- | overline(D)) = 0.99$ (a
  healthy person tests negative with probability $99%$). A randomly chosen
  person tests positive. How likely are they actually sick? The events
  $D$ (diseased) and $overline(D)$ partition $Omega$, and
  #link(<thm:bayes>)[Bayes' theorem] gives
  $
    P(D | +)
    = (P(D) P(+ | D)) / (P(D) P(+ | D) + P(overline(D)) P(+ | overline(D)))
    = (0.001 times 0.99) / (0.001 times 0.99 + 0.999 times 0.01)
    = 0.00099 / 0.01098
    approx 9%.
  $
  Despite a highly accurate test, fewer than one in ten positive results
  comes from a sick person — because the disease is rare, the false
  positives among the healthy many outnumber the true positives among the
  sick few (see @fig:bayes-tree).
] <ex:bayes-screening>

#figure(
  image("img/bayes-tree.svg", width: 70%),
  caption: [Tree diagram of the screening example: the first branching
    carries the prior probabilities $P(D) = 0.001$ and
    $P(overline(D)) = 0.999$; the second carries the conditional test
    probabilities. Leaves show the joint probabilities; the posterior
    $P(D | +)$ is the shaded leaf divided by the sum of the two
    "$+$" leaves.],
  placement: auto,
  supplement: [Fig.],
) <fig:bayes-tree>

#note[
  (Prior and posterior.) In the language of statistics, $P(D)$ is the
  *prior* probability — knowledge before the data — and $P(D | +)$ is
  the *posterior* probability — knowledge after observing the data. Bayes'
  theorem is precisely the rule for updating priors into posteriors; this
  reading will be formalized when Bayesian estimation is discussed in the
  Parametric Estimation part.
]

== Independence // 独立性

Conditioning on an event changes probabilities; the opposite situation —
information that changes *nothing* — deserves its own name.

#definition(name: "Independence of Two Events")[
  Events $A$ and $B$ are *independent* if
  $
    P(A inter B) = P(A) P(B).
  $
] <def:independence>

Note that the definition does not *require* $P(B) > 0$, but when it does
hold, independence is equivalent to $P(A | B) = P(A)$: knowing $B$
neither promotes nor suppresses $A$. The definition by the product formula
is preferred because it is symmetric in $A$ and $B$.

#caution[
  Independence and mutual exclusivity are unrelated — indeed incompatible in
  an interesting way. If $A$ and $B$ are *mutually exclusive* events with
  positive probability, then $P(A inter B) = 0 != P(A) P(B)$, so they are
  *dependent*: the occurrence of one *rules out* the other, which is
  information of the strongest kind. Independent events (with positive
  probabilities) always intersect.
] <caution:independence-vs-exclusion>

#property(name: "Closure Properties of Independence")[
  If $A$ and $B$ are independent, then so are $A$ and $overline(B)$,
  $overline(A)$ and $B$, and $overline(A)$ and $overline(B)$.
] <prop:independence-preserved>

#proof[
  It suffices to prove the first pairing; the rest follow by symmetrical
  arguments. Since $B = (A inter B) union (overline(A) inter B)$ is a
  disjoint decomposition,
  $
    P(overline(A) inter B)
    = P(B) - P(A inter B)
    = P(B) - P(A) P(B)
    = P(overline(A)) P(B),
  $
  using the complement rule of
  #link(<prop:probability-additivity>)[the basic properties].
]

For more than two events, pairwise conditions do not suffice.

#definition(name: "Mutual Independence")[
  Events $A_1, dots, A_n$ are *mutually independent* if for every choice of
  distinct indices $i_1, dots, i_k$ with $2 <= k <= n$,
  $
    P(A_(i_1) inter dots inter A_(i_k))
    = P(A_(i_1)) dots P(A_(i_k)).
  $
  An infinite family is mutually independent if every finite subfamily is.
] <def:mutual-independence>

#example(name: "Pairwise independence is not mutual independence")[
  Let
  $Omega = {1, 2, 3, 4}$ with all outcomes equally likely, and set
  $A = {1, 2}$, $B = {1, 3}$, $C = {1, 4}$. Then
  $P(A) = P(B) = P(C) = 1 \/ 2$ and $A inter B = A inter C = B inter C =
  {1}$, so every pair is independent. But
  $
    P(A inter B inter C) = P({1}) = 1 / 4
    != 1 / 8 = P(A) P(B) P(C),
  $
  so the three events are *not* mutually independent — the definition
  demands all subfamilies precisely to exclude such examples.
] <ex:pairwise-not-mutual>

#definition(name: "Independent Experiments")[
  Two random experiments are *independent* if every event determined by the
  first is independent of every event determined by the second. Formally,
  with the experiment encoded on a product space, the $sigma$-fields they
  generate are independent families. Iterating gives independence of any
  number of experiments.
] <def:independent-experiments>

The classical instance is repeated trials of the *same* experiment.

#definition(name: "Bernoulli Trials")[
  A sequence of $n$ trials constitutes *Bernoulli trials* (the $n$-fold
  Bernoulli scheme) if

  - each trial has exactly two outcomes, *success* ($S$) and *failure*
    ($F$);
  - the success probability is the same number $p in (0, 1)$ in every
    trial;
  - the trials are independent experiments.

  Writing $q = 1 - p$, the probability that exactly $k$ of the $n$ trials
  succeed is
  $
    P(X = k) = binom(n, k) p^k q^(n - k),
  $
  since the $binom(n, k)$ sequences with exactly $k$ successes are mutually
  exclusive, each having probability $p^k q^(n-k)$ by independence, and the
  count of such sequences is a binomial coefficient by the multiplication
  principle established in the Combinatoire note.
] <def:bernoulli-trials>

#example(name: "At least one success")[
  In $n$ Bernoulli trials with success probability
  $p$, the probability of *at least one* success is
  $
    P("at least one" S) = 1 - P("all" F) = 1 - q^n.
  $
  For $p = 1 \/ 100$ and $n = 100$ this is $1 - (0.99)^100 approx 0.634$:
  an event with per-trial probability $1%$ occurs within 100 trials more
  often than not. The comforting thought that "a $1%$ accident needs ages
  to happen" is a statistical fallacy.
] <ex:bernoulli-at-least-one>

The count $X$ of successes in Bernoulli trials inherits a life of its own —
its distribution, the *binomial distribution*, opens the catalogue of the
next chapter.

#part("Random Variables and Distributions")
= Univariate Random Variables and Distributions // 一维随机变量及其分布

== Random Variables and Their Distributions // 随机变量及其分布

Events describe *what can happen*; the next step is to attach *numbers* to
outcomes, so that the tools of analysis — limits, integrals, Taylor
expansions — become available. A random variable is the bridge from the
sample space to the real line.

#definition(name: "Random Variable")[
  A *random variable* on a probability space $(Omega, cal(F), P)$ is a function
  $X: Omega -> RR$ that is *measurable*: for every $x in RR$, the set
  ${omega in Omega : X(omega) <= x}$ belongs to the event field $cal(F)$.
] <def:random-variable>

The measurability condition guarantees that questions like "$X <= x$?" are
*events* — they can be assigned probabilities. Once $X$ is fixed, its
probabilistic profile is completely determined by a single real-valued
function.

#definition(name: "Cumulative Distribution Function")[
  The *cumulative distribution function* (CDF) of a random variable $X$ is
  $
    F(x) = P(X <= x), quad x in RR.
  $
] <def:cdf>

#property(name: "Properties of the CDF")[
  Let $F$ be a CDF. Then:

  - (monotonicity) $F$ is non-decreasing: $x_1 <= x_2 arrow.r.double F(x_1) <= F(x_2)$;
  - (limits) $lim_(x -> -infinity) F(x) = 0$ and $lim_(x -> +infinity) F(x) = 1$;
  - (right-continuity) $F$ is right-continuous: $F(x) = F(x^+)$;
  - (range) $0 <= F(x) <= 1$, and $P(a < X <= b) = F(b) - F(a)$.
] <prop:cdf-properties>

#proof[
  Monotonicity follows from ${X <= x_2} = {X <= x_1} union {x_1 < X <= x_2}$
  and #link(<prop:probability-monotonicity>)[monotonicity of $P$]. The
  limits follow from #link(<thm:continuity-probability>)[continuity of
    probability]: ${X <= x} arrow.t Omega$ as $x -> +infinity$ gives
  $F(x) -> P(Omega) = 1$, and ${X <= x} arrow.b emptyset$ as
  $x -> -infinity$ gives $F(x) -> 0$. Right-continuity uses the decreasing
  case applied to ${X <= x + 1\/n} arrow.b {X <= x}$. Finally,
  $P(a < X <= b) = P(X <= b) - P(X <= a) = F(b) - F(a)$ by the difference
  formula.
]

Two structural types of random variable dominate the theory.

#definition(name: "Discrete Random Variable")[
  A random variable $X$ is *discrete* if it takes values in a finite or
  countable set ${x_1, x_2, dots}$. Its *probability mass function* (PMF) is
  $
    p(x_i) = P(X = x_i), quad sum_(i) p(x_i) = 1.
  $
  The CDF is a step function: $F(x) = sum_(x_i <= x) p(x_i)$.
] <def:discrete-rv>

#definition(name: "Continuous Random Variable")[
  A random variable $X$ is *continuous* if there exists a non-negative
  integrable function $f$ such that
  $
    F(x) = integral_(-infinity)^x f(t) dif t, quad x in RR.
  $
  The function $f$ is the *probability density function* (PDF); at points
  of continuity of $f$, $F'(x) = f(x)$.
] <def:continuous-rv>

#property(name: "Properties of the PDF")[
  Let $f$ be a PDF. Then:

  - (non-negativity) $f(x) >= 0$ for all $x$;
  - (normalization) $integral_(-infinity)^infinity f(x) dif x = 1$;
  - (interval probabilities) for $a < b$,
    $P(a < X <= b) = integral_a^b f(x) dif x$;
  - (point probabilities) $P(X = a) = 0$ for every single point $a$.
] <prop:pdf-properties>

#proof[
  Non-negativity and normalization follow from $F$ being non-decreasing
  with $lim F = 1$. The interval formula follows from additivity of the
  integral: $F(b) - F(a) = integral_a^b f(x) dif x$. For point
  probabilities, $P(X = a) = F(a) - F(a^-) = 0$ since $F$ is continuous
  for a continuous variable.
]

#note[
  Not every random variable is purely discrete or purely continuous:
  *mixed* types exist, with a CDF that has both smooth stretches and jump
  discontinuities (e.g. the waiting time at a traffic light with a positive
  probability of zero wait). The theory is developed for the two pure types
  and extended to mixed cases by decomposition.
]

#figure(
  image("img/cdf-types.svg", width: 90%),
  caption: [Three types of cumulative distribution functions: a discrete
    step CDF (left), a continuous smooth CDF (centre), and a mixed CDF
    combining a jump with a smooth section (right).],
  placement: auto,
  supplement: [Fig.],
) <fig:cdf-types>

== Common Discrete Distributions // 常用离散分布

The Bernoulli scheme of #link(<def:bernoulli-trials>)[the preceding chapter]
produces the first and most important discrete distribution family.

#definition(name: "Bernoulli Distribution")[
  A random variable $X$ has the *Bernoulli distribution* with parameter
  $p in [0, 1]$, written $X ~ "Ber"(p)$, if $P(X = 1) = p$ and
  $P(X = 0) = 1 - p = q$. It models a single Bernoulli trial.
] <def:bernoulli-dist>

#definition(name: "Binomial Distribution")[
  The number $X$ of successes in $n$ independent Bernoulli trials with
  success probability $p$ has the *binomial distribution*
  $
    P(X = k) = binom(n, k) p^k q^(n-k), quad k = 0, 1, dots, n,
  $
  written $X ~ B(n, p)$ — the formula already established in
  #link(<def:bernoulli-trials>)[the Bernoulli definition].
] <def:binomial-dist>

#property(name: "Most Probable Value of the Binomial")[
  The most probable value (mode) of $X ~ B(n, p)$ is the greatest integer
  $k$ not exceeding $(n + 1) p$, provided this number is at least $0$ and
  at most $n$. When $(n + 1) p$ is itself an integer, there are two adjacent
  modes: $k = (n + 1) p - 1$ and $k = (n + 1) p$.
] <prop:binomial-mode>

#proof[
  The ratio of consecutive probabilities is
  $
    P(X = k+1) / P(X = k) = (n - k) / (k + 1) dot p / q.
  $
  This ratio exceeds $1$ iff $k < (n + 1) p - 1$, equals $1$ iff
  $k = (n + 1) p - 1$, and is below $1$ iff $k > (n + 1) p - 1$. The
  probabilities increase up to the threshold and decrease thereafter.
]

#definition(name: "Poisson Distribution")[
  A random variable $X$ has the *Poisson distribution* with parameter
  $lambda > 0$, written $X ~ "Pois"(lambda)$, if
  $
    P(X = k) = (lambda^k e^(-lambda)) / k!, quad k = 0, 1, 2, dots
  $
] <def:poisson-dist>

The Poisson distribution arises as the limit of binomial distributions with
vanishing success probability — the *law of rare events*.

#theorem(name: "Poisson Limit Theorem")[
  Let $X_n ~ B(n, p_n)$ with $n p_n -> lambda > 0$ as $n -> infinity$. Then
  for every fixed $k >= 0$,
  $
    P(X_n = k) -> (lambda^k e^(-lambda)) / k!.
  $
] <thm:poisson-limit>

#proof[
  Set $lambda_n = n p_n -> lambda$. The binomial probability is
  $
    P(X_n = k)
    = binom(n, k) (lambda_n / n)^k (1 - lambda_n / n)^(n - k).
  $
  For fixed $k$, $binom(n, k) = n (n-1) dots (n-k+1) / k!$ behaves as
  $n^k / k!$ for large $n$; the factor $(lambda_n / n)^k$ contributes
  $lambda_n^k / n^k$; and
  $
    (1 - lambda_n / n)^(n - k)
    = (1 - lambda_n / n)^n (1 - lambda_n / n)^(-k)
    -> e^(-lambda) dot 1.
  $
  Multiplying the three limits recovers $(lambda^k e^(-lambda)) / k!$.
]

#definition(name: "Hypergeometric Distribution")[
  An urn contains $N$ balls, $K$ of them red; $n$ are drawn without
  replacement. The number $X$ of red balls drawn has the *hypergeometric
  distribution*,
  $
    P(X = k) = (binom(K, k) binom(N - K, n - k)) / binom(N, n),
  $
  for $max(0, n + K - N) <= k <= min(K, n)$, written $X ~ "Hyp"(N, K, n)$
  — the classical formula of #link(<ex:balls-sampling>)[the sampling
    example].
] <def:hypergeometric-dist>

#definition(name: "Geometric Distribution")[
  In a sequence of independent Bernoulli trials, the number $X$ of trials
  up to and including the first success has the *geometric distribution*
  $
    P(X = k) = q^(k-1) p, quad k = 1, 2, 3, dots
  $
  written $X ~ "Geo"(p)$.
] <def:geometric-dist>

#property(name: "Memorylessness of the Geometric")[
  The geometric distribution is *memoryless*: for $m, n >= 1$,
  $
    P(X > m + n | X > m) = P(X > n).
  $
  It is the unique discrete distribution on ${1, 2, dots}$ with this
  property.
] <prop:geometric-memoryless>

#proof[
  Since $P(X > n) = sum_(k=n+1)^infinity q^(k-1) p = q^n$,
  $
    P(X > m + n | X > m)
    = P(X > m + n) / P(X > m)
    = q^(m+n) / q^m = q^n = P(X > n).
  $
  For uniqueness: if a distribution on ${1, 2, dots}$ is memoryless, its
  survival function $overline(F)(n) = P(X > n)$ satisfies the multiplicative
  equation $overline(F)(m + n) = overline(F)(m) overline(F)(n)$; the only
  non-trivial solution on $ZZ_{>= 0}$ is $overline(F)(n) = q^n$.
]

#definition(name: "Negative Binomial Distribution")[
  The number $X$ of trials up to and including the $r$-th success in
  independent Bernoulli trials has the *negative binomial distribution*
  $
    P(X = k) = binom(k - 1, r - 1) p^r q^(k - r), quad k = r, r + 1, dots
  $
  written $X ~ "NB"(r, p)$. For $r = 1$ this reduces to the geometric
  distribution.
] <def:negative-binomial-dist>

#note[
  (Distribution genealogy.) The six discrete distributions above are
  organized by two axes: *what is counted* — success count (binomial,
  Poisson), failure count (negative binomial, geometric), or drawn count
  (hypergeometric); and *the sampling protocol* — with replacement
  (binomial family) or without (hypergeometric). The Poisson distribution
  approximates the binomial when $n$ is large and $p$ small
  (#link(<thm:poisson-limit>)[Poisson limit theorem]); the hypergeometric
  approaches the binomial when $N -> infinity$ with $K / N -> p$, since
  drawing without replacement then becomes practically drawing with
  replacement.
]

== Common Continuous Distributions // 常用连续分布

The discrete families of the preceding section are models for counting;
the continuous families below are models for measuring — time, length,
concentration, error.

#definition(name: "Uniform Distribution")[
  A random variable $X$ has the *uniform distribution* on $[a, b]$, written
  $X ~ U(a, b)$, if its density is
  $
    f(x) = 1 / (b - a), quad a <= x <= b,
  $
  and zero elsewhere. The CDF is $F(x) = (x - a) / (b - a)$ on $[a, b]$.
] <def:uniform-dist>

#definition(name: "Exponential Distribution")[
  A random variable $X$ has the *exponential distribution* with rate
  $lambda > 0$, written $X ~ "Exp"(lambda)$, if
  $
    f(x) = lambda e^(-lambda x), quad x >= 0.
  $
  The CDF is $F(x) = 1 - e^(-lambda x)$ for $x >= 0$.
] <def:exponential-dist>

#property(name: "Memorylessness of the Exponential")[
  The exponential distribution is *memoryless*: for $s, t >= 0$,
  $
    P(X > s + t | X > s) = P(X > t).
  $
  It is the unique continuous distribution on $[0, infinity)$ with this
  property.
] <prop:exponential-memoryless>

#proof[
  Since $P(X > t) = e^(-lambda t)$,
  $
    P(X > s + t | X > s)
    = P(X > s + t) / P(X > s)
    = e^(-lambda(s+t)) / e^(-lambda s)
    = e^(-lambda t) = P(X > t).
  $
  The uniqueness argument parallels the geometric case: the survival function
  $overline(F)(t) = P(X > t)$ satisfies $overline(F)(s + t) =
  overline(F)(s) overline(F)(t)$, whose only non-trivial right-continuous
  solution is $overline(F)(t) = e^(-lambda t)$.
]

#definition(name: "Normal Distribution")[
  A random variable $X$ has the *normal distribution* with mean $mu in RR$
  and variance $sigma^2 > 0$, written $X ~ N(mu, sigma^2)$, if
  $
    f(x) = 1 / (sigma sqrt(2 pi)) exp(-(x - mu)^2 / (2 sigma^2)), quad x in RR.
  $
  The case $mu = 0$, $sigma = 1$ is the *standard normal* distribution,
  with density $phi(x)$ and CDF $Phi(x)$.
] <def:normal-dist>

Every normal variable standardizes: if $X ~ N(mu, sigma^2)$ then
$Z = (X - mu) / sigma ~ N(0, 1)$, and $F_(X)(x) = Phi((x - mu) / sigma)$.
Tables of $Phi$ (in the Appendix) thus serve all parameter values.

#property(name: "Three-Sigma Rule")[
  For $X ~ N(mu, sigma^2)$,
  $
    P(abs(X - mu) < sigma) approx 0.6827, quad
    P(abs(X - mu) < 2 sigma) approx 0.9545, quad
    P(abs(X - mu) < 3 sigma) approx 0.9973.
  $
  In practice, nearly all normal mass lies within three standard deviations
  of the mean.
] <prop:normal-3sigma>

#figure(
  image("img/normal-curves.svg", width: 80%),
  caption: [Normal density curves: the standard $N(0, 1)$ bell (solid),
    a wider $N(0, 2^2)$ (dashed), and a shifted $N(1, 1)$ (dotted),
    illustrating the roles of $sigma$ (width) and $mu$ (location). Shaded
    band marks the $3 sigma$ interval for $N(0,1)$.],
  placement: auto,
  supplement: [Fig.],
) <fig:normal-curves>

#definition(name: "Gamma Distribution")[
  A random variable $X$ has the *Gamma distribution* with shape $alpha > 0$
  and rate $lambda > 0$, written $X ~ "Ga"(alpha, lambda)$, if
  $
    f(x) = (lambda^alpha) / ("Gamma"(alpha)) x^(alpha - 1) e^(-lambda x), quad x >= 0,
  $
  where $"Gamma"(alpha) = integral_0^infinity t^(alpha - 1) e^(-t) dif t$
  is the Gamma function.
] <def:gamma-dist>

#definition(name: "Beta Distribution")[
  A random variable $X$ has the *Beta distribution* with parameters
  $a > 0$, $b > 0$, written $X ~ "Be"(a, b)$, if
  $
    f(x) = 1 / ("B"(a, b)) x^(a - 1) (1 - x)^(b - 1), quad 0 < x < 1,
  $
  where $"B"(a, b) = ("Gamma"(a) "Gamma"(b)) / "Gamma"(a + b)$.
] <def:beta-dist>

#definition(name: "Kernel of a Distribution")[
  The *kernel* of a density $f(x; theta)$ is the part of $f$ that depends on
  $x$, stripped of the normalizing constant. Formally, if
  $
    f(x; theta) = c(theta) dot k(x; theta),
  $
  then $k(x; theta)$ is the *kernel*. Two densities with the same kernel
  (for fixed $theta$) differ only by a constant and are thus identical
  after normalization.
] <def:kernel>

For example, the kernel of $N(mu, 1)$ is $exp(-(x - mu)^2 / 2)$ — the
factor $1 / sqrt(2 pi)$ is a normalizing constant independent of $mu$;
for $N(mu, sigma^2)$ with $sigma$ known, the kernel is
$exp(-(x - mu)^2 / (2 sigma^2))$, which as a function of $mu$ is itself
proportional to a normal density. This observation — "the kernel as a
function of the parameter" — is the seed of maximum likelihood estimation
and conjugate Bayesian analysis.

#note[
  (Distribution relationships.) The continuous families are tightly connected:
  $U(0, 1) = "Be"(1, 1)$; $"Exp"(lambda) = "Ga"(1, lambda)$; the sum of
  $n$ independent $"Exp"(lambda)$ variables is $"Ga"(n, lambda)$; if
  $X ~ "Ga"(a, lambda)$ and $Y ~ "Ga"(b, lambda)$ independently, then
  $X / (X + Y) ~ "Be"(a, b)$ — a Gamma-to-Beta transformation that
  generalizes the ratio of two independent chi-squared variables. The
  normal distribution connects to the Gamma family through $X^2$ for
  $X ~ N(0, 1)$, which is $"Ga"(1\/2, 1\/2)$ — the chi-squared distribution
  with one degree of freedom, to be met again in the sampling distributions
  chapter.
]

== Distributions of Functions of Random Variables // 随机变量函数的分布

Given the distribution of $X$, what is the distribution of $Y = g(X)$? The
answer depends on the type of $X$ and the nature of $g$.

For a *discrete* $X$, the method is direct: enumerate the values of $Y$ and
collect the probabilities of the pre-images.

#example[
  Let $X$ take $-1, 0, 1$ each with probability $1\/3$, and set $Y = X^2$.
  Then $Y$ takes values $0$ and $1$, with
  $
    P(Y = 0) = P(X = 0) = 1/3, quad
    P(Y = 1) = P(X = -1) + P(X = 1) = 2/3.
  $
] <ex:discrete-transform>

For a *continuous* $X$, the distribution can be recovered from its CDF:
the *distribution function method* — compute $F_(Y)(y) = P(g(X) <= y)$,
then differentiate.

#example[
  Let $X ~ U(0, 1)$ and $Y = X^2$. For $0 <= y <= 1$,
  $
    F_(Y)(y) = P(X^2 <= y) = P(X <= sqrt(y)) = sqrt(y),
  $
  so $f_(Y)(y) = d\/(d y) sqrt(y) = 1 / (2 sqrt(y))$ for $0 < y < 1$. This
  is the $"Be"(1\/2, 1)$ density, the square of a uniform variable being a
  special case of the Beta-Gamma connection noted above.
] <ex:cdf-method>

When $g$ is monotone, a direct formula avoids the detour through the CDF.

#theorem(name: "Monotone Transform Formula")[
  Let $X$ be a continuous random variable with density $f_X$, and let
  $g$ be strictly monotone and differentiable on the range of $X$. Set
  $Y = g(X)$ and let $h = g^(-1)$ be the inverse function. Then $Y$ has
  density
  $
    f_(Y)(y) = f_(X)(h(y)) dot abs(h'(y)),
  $
  for $y$ in the range of $g$.
] <thm:monotone-transform>

#proof[
  Suppose $g$ is strictly increasing (the decreasing case is symmetric).
  Then $g^(-1)$ is also increasing, so
  $
    F_(Y)(y) = P(g(X) <= y) = P(X <= h(y)) = F_(X)(h(y)).
  $
  Differentiating by the chain rule gives
  $f_(Y)(y) = f_(X)(h(y)) h'(y)$; since $h$ is increasing, $h'(y) >= 0$ and
  $h'(y) = abs(h'(y))$. If $g$ is strictly decreasing, then
  $
    F_(Y)(y) = P(g(X) <= y) = P(X >= h(y)) = 1 - F_(X)(h(y)),
  $
  and differentiating gives $f_(Y)(y) = -f_(X)(h(y)) h'(y)$; since $h$ is now
  decreasing, $h'(y) <= 0$ and $-h'(y) = abs(h'(y))$. The two cases unify
  in the stated formula.
]

#example(name: "Linear transform")[
  Let $X ~ N(mu, sigma^2)$ and $Y = a X + b$ with
  $a != 0$. Then $h(y) = (y - b) / a$ and $h'(y) = 1 / a$, so
  $
    f_(Y)(y)
    = f_(X)((y - b) / a) dot abs(1 / a)
    = 1 / (abs(a) sigma sqrt(2 pi)) exp(-(y - a mu - b)^2 / (2 a^2 sigma^2)).
  $
  This is $N(a mu + b, a^2 sigma^2)$: linear transforms of normals are
  normal, with scale and location transformed accordingly. In particular,
  $Z = (X - mu) / sigma ~ N(0, 1)$ — the standardization used throughout
  normal calculations.
] <ex:linear-transform>

The monotone transform formula extends to several variables via the
multidimensional Jacobian — a tool to be developed in the next chapter,
where multivariate distributions and the change-of-variables technique for
joint densities take centre stage.

= Multivariate Random Variables and Distributions // 多维随机变量及其分布

== Joint Distributions // 联合分布

A single random variable tracks one quantity; real experiments often
produce several numbers at once — the height and weight of a randomly chosen
person, the coordinates of a random point, the lifetimes of two components
in the same system. The theory extends from one variable to many by
*packaging* them into a single random vector.

#definition(name: "Random Vector")[
  A *$n$-dimensional random vector* is a measurable function
  $bold(X) = (X_1, X_2, dots, X_n): Omega -> RR^n$, i.e. each component
  $X_i$ is a random variable on the same probability space.
] <def:multivariate-rv>

The joint behaviour of the components is captured by a multivariate
distribution function, exactly as a single variable was captured by its CDF.

#definition(name: "Joint Cumulative Distribution Function")[
  The *joint CDF* of a random vector $bold(X) = (X_1, dots, X_n)$ is
  $
    F(bold(x)) = P(X_1 <= x_1, X_2 <= x_2, dots, X_n <= x_n).
  $
  For $n = 2$ we write $F(x, y) = P(X <= x, Y <= y)$.
] <def:joint-cdf>

#property(name: "Properties of the Joint CDF")[
  Let $F(x, y)$ be a bivariate CDF.

  - $F$ is non-decreasing and right-continuous in each argument;
  - $F(-infinity, y) = F(x, -infinity) = 0$ and $F(+infinity, +infinity) = 1$;
  - (rectangle formula) for $a_1 < b_1$, $a_2 < b_2$,
    $
      P(a_1 < X <= b_1, a_2 < Y <= b_2)
      = F(b_1, b_2) - F(a_1, b_2) - F(b_1, a_2) + F(a_1, a_2).
    $
] <prop:joint-cdf-properties>

#proof[
  The rectangle ${a_1 < X <= b_1, a_2 < Y <= b_2}$ equals ${X <= b_1, Y
    <= b_2}$ with the two strips ${X <= a_1, Y <= b_2}$ and ${X <= b_1, Y
    <= a_2}$ removed, and the corner ${X <= a_1, Y <= a_2}$ (subtracted
  twice) added back. Applying
  #link(<prop:probability-additivity>)[finite additivity] with this
  inclusion–exclusion pattern gives the rectangle formula. The limits and
  monotonicity are #link(<thm:continuity-probability>)[continuity]
  arguments as in the univariate case.
]

As in one dimension, two structural types carry most of the theory.

#definition(name: "Joint Probability Mass Function")[
  Discrete random variables $X_1, dots, X_n$ have a *joint PMF*
  $
    p(x_1, dots, x_n) = P(X_1 = x_1, dots, X_n = x_n),
  $
  with $sum p(x_1, dots, x_n) = 1$. The joint CDF is a multivariate step
  function: $F(bold(x)) = sum_(x_i <= x_i "for all" i) p(bold(x))$.
] <def:joint-pmf>

#definition(name: "Joint Probability Density Function")[
  Continuous random variables $X_1, dots, X_n$ have a *joint PDF* $f$ if
  $
    F(bold(x)) = integral_(-infinity)^(x_1) dots integral_(-infinity)^(x_n) f(t_1, dots, t_n) dif t_n dots dif t_1.
  $
] <def:joint-pdf>

#property(name: "Properties of the Joint PDF")[
  - (non-negativity) $f(x_1, dots, x_n) >= 0$;
  - (normalization) $integral_(RR^n) f(bold(x)) dif bold(x) = 1$;
  - (region probabilities) for a region $D subset.eq RR^n$,
    $P(bold(X) in D) = integral_D f(bold(x)) dif bold(x)$.
] <prop:joint-pdf-properties>

#definition(name: "Multivariate Uniform Distribution")[
  A random vector $bold(X)$ is *uniformly distributed* on a region
  $D subset.eq RR^n$ of finite volume $m(D) > 0$ if
  $
    f(bold(x)) = 1 / m(D), quad bold(x) in D,
  $
  and zero elsewhere. When $D$ is a rectangle $[a_1, b_1] times dots times
  [a_n, b_n]$, the components are independent uniform variables — a fact to
  be revisited when independence is defined.
] <def:multivariate-uniform>

#figure(
  image("img/joint-density.svg", width: 75%),
  caption: [A bivariate joint density $f(x, y)$ visualised by contour lines
    in the $(x, y)$ plane; the marginal densities $f_(X)(x)$ and $f_(Y)(y)$
    appear as projections on the side panels.],
  placement: auto,
  supplement: [Fig.],
) <fig:joint-density>

== Marginal Distributions and Independence // 边缘分布与独立性

Given the joint distribution of $(X, Y)$, the distribution of each component
alone — the *marginal* — is recovered by summing (discrete) or integrating
(continuous) over the other variable. The marginals are projections of the
joint.

#definition(name: "Marginal Distribution")[
  The *marginal PMF* of $X$ from a joint PMF $p(x, y)$ is
  $
    p_(X)(x) = sum_y p(x, y).
  $
  The *marginal PDF* of $X$ from a joint PDF $f(x, y)$ is
  $
    f_(X)(x) = integral_(-infinity)^infinity f(x, y) dif y.
  $
  The marginal CDF is $F_(X)(x) = lim_(y -> +infinity) F(x, y)$.
] <def:marginal-distribution>

#property(name: "Marginal Formulas")[
  Marginals are bona fide PMFs/PDFs: they are non-negative and sum/integrate
  to $1$. For a bivariate continuous vector,
  $
    P(a < X <= b) = integral_a^b f_(X)(x) dif x
    = integral_a^b (integral_(-infinity)^infinity f(x, y) dif y) dif x.
  $
  Symmetric formulas hold for the marginal of $Y$.
] <prop:marginal-formulas>

Marginals tell each variable's story separately; the joint tells how they
interact. When the interaction vanishes — when the joint factors — the
variables are *independent*.

#definition(name: "Independence of Random Variables")[
  Random variables $X_1, dots, X_n$ are *independent* if their joint CDF
  factors into the product of the marginal CDFs:
  $
    F(x_1, dots, x_n) = product_(i=1)^n F_(X_i)(x_i).
  $
  Equivalently (when densities/masses exist), the joint PMF/PDF factors:
  $
    f(x_1, dots, x_n) = product_(i=1)^n f_(X_i)(x_i).
  $
] <def:rv-independence>

This is the random-variable instantiation of
#link(<def:mutual-independence>)[mutual independence of events]: the
$sigma$-fields generated by each $X_i$ are independent families.

#property(name: "Independence Criterion")[
  Independent random variables satisfy:

  - $P(X in A, Y in B) = P(X in A) P(Y in B)$ for all Borel sets $A, B$;
  - if $g$ and $h$ are measurable functions, $g(X)$ and $h(Y)$ are
    independent;
  - the joint CDF determines the joint distribution *and* the marginals, but
    the converse requires independence: the marginals alone do *not*
    determine the joint.
] <prop:independence-criterion>

#note[
  Independence of random variables is stronger than *uncorrelatedness*: two
  variables can be uncorrelated (a condition involving expectations, to be
  defined in the Numerical Characteristics chapter) yet dependent. The
  distinction is central to the covariance theory developed there.
]

== Distributions of Functions of Random Variables // 随机变量函数的分布

Given the joint distribution of several random variables, the distribution of
a function of them — a sum, a product, a maximum — is the natural next
question. The methods extend the univariate tools of
#link(<thm:monotone-transform>)[the monotone transform] to higher
dimensions.

For a *discrete* vector, the method is direct enumeration.

#example[
  Let $(X, Y)$ have joint PMF $p(i, j) = 1\/36$ on ${1, dots, 6}^2$ (two fair
  dice), and set $Z = X + Y$. Then $Z$ takes values $2, 3, dots, 12$ with
  $
    P(Z = k) = sum_(i+j=k) p(i, j).
  $
  For instance $P(Z = 7) = 6\/36 = 1\/6$ and $P(Z = 2) = P(Z = 12) = 1\/36$.
] <ex:discrete-sum>

For *extreme values* of independent variables, simple product formulas
apply.

#property(name: "Distributions of Maxima and Minima")[
  Let $X_1, dots, X_n$ be independent with CDFs $F_1, dots, F_n$.

  - (maximum) $M_n = max(X_1, dots, X_n)$ has CDF
    $
      F_(M_n)(z) = product_(i=1)^n F_(i)(z).
    $
  - (minimum) $N_n = min(X_1, dots, X_n)$ has CDF
    $
      F_(N_n)(z) = 1 - product_(i=1)^n (1 - F_(i)(z)).
    $
  If the $X_i$ are identically distributed with CDF $F$, then
  $F_(M_n) = F^n$ and $F_(N_n) = 1 - (1 - F)^n$.
] <prop:extreme-distributions>

#proof[
  $max(X_i) <= z$ iff $X_i <= z$ for every $i$; independence gives the
  product. Similarly, $min(X_i) <= z$ iff at least one $X_i <= z$, i.e. the
  complement of "$X_i > z$ for all $i$".
]

For *sums* of independent continuous variables, the integral form is the
*convolution*.

#theorem(name: "Convolution Formula")[
  Let $X$ and $Y$ be independent continuous random variables with densities
  $f_X$ and $f_Y$. The density of $Z = X + Y$ is the *convolution*
  $
    f_(Z)(z) = integral_(-infinity)^infinity f_(X)(x) f_(Y)(z - x) dif x.
  $
] <thm:convolution>

#proof[
  Condition on $X$:
  $
    F_(Z)(z) = P(X + Y <= z) = integral_(-infinity)^infinity P(Y <= z - x) f_(X)(x) dif x = integral_(-infinity)^infinity F_(Y)(z - x) f_(X)(x) dif x.
  $
  Differentiating in $z$ (under the integral, justified by dominated
  convergence) gives $f_(Z)(z) = integral f_(Y)(z - x) f_(X)(x) dif x$.
]

#example(name: "Sum of exponentials is Gamma")[
  Let $X_1, dots, X_n$ be i.i.d.
  $"Exp"(lambda)$. We prove by induction that $S_n = X_1 + dots + X_n ~
  "Ga"(n, lambda)$. The base case $n = 1$ is $"Exp"(lambda) = "Ga"(1,
    lambda)$. For the inductive step, assume $S_n ~ "Ga"(n, lambda)$ and
  apply #link(<thm:convolution>)[the convolution] to $S_(n+1) = S_n +
  X_(n+1)$:
  $
    f_(S_(n+1))(s)
    = integral_0^s (lambda^n / "Gamma"(n)) t^(n-1) e^(-lambda t) dot lambda e^(-lambda(s - t)) dif t
    = (lambda^(n+1) e^(-lambda s)) / "Gamma"(n) integral_0^s t^(n-1) dif t
    = (lambda^(n+1) s^n e^(-lambda s)) / "Gamma"(n+1),
  $
  which is the $"Ga"(n+1, lambda)$ density — using $"Gamma"(n+1) = n dot
  "Gamma"(n)$. This confirms the Gamma-to-Exponential connection noted in
  #link(<def:gamma-dist>)[the Gamma definition].
] <ex:exp-sum-gamma>

For *general transformations* of a continuous random vector, the univariate
monotone transform generalises to a multidimensional change of variables.

#theorem(name: "Multivariate Change of Variables")[
  Let $bold(X) = (X_1, dots, X_n)$ be a continuous random vector with joint
  density $f_(bold X)$. Let $bold(g): A -> B$ be a one-to-one differentiable
  map from an open set $A subset.eq RR^n$ containing the range of $bold(X)$
  onto $B$, with inverse $bold(h) = bold(g)^(-1)$. Then $bold(Y) =
  bold(g)(bold(X))$ has joint density
  $
    f_(bold Y)(bold(y)) = f_(bold X)(bold(h)(bold(y))) dot abs(J(bold(y))),
  $
  where $J$ is the determinant of the matrix $(partial h_i / partial y_j)_(i,j)$
  — the Jacobian determinant of the inverse map.
] <thm:jacobian-transform>

#proof[
  For a region $D subset.eq B$,
  $
    P(bold(Y) in D) = P(bold(X) in bold(h)(D)) = integral_(bold(h)(D)) f_(bold X)(bold(x)) dif bold(x).
  $
  The multivariate change-of-variables theorem from calculus replaces
  $dif bold(x)$ by $abs(J(bold(y))) dif bold(y)$ and the domain by $D$:
  $
    P(bold(Y) in D) = integral_D f_(bold X)(bold(h)(bold(y))) abs(J(bold(y))) dif bold(y).
  $
  Comparing with $P(bold(Y) in D) = integral_D f_(bold Y)(bold(y)) dif bold(y)$
  for every $D$ identifies the integrand.
]

This is the $n$-dimensional generalisation of
#link(<thm:monotone-transform>)[the monotone transform]; the factor
$abs(h'(y))$ is replaced by $abs(J)$, the absolute Jacobian determinant.

== Conditional Distributions // 条件分布

Conditional probability restricts the sample space; conditional
distributions restrict one variable to a fixed value and examine the
distribution of the other.

#definition(name: "Conditional PMF")[
  For discrete $X, Y$ with joint PMF $p(x, y)$ and $p_(X)(x) > 0$, the
  *conditional PMF* of $Y$ given $X = x$ is
  $
    p_(Y|X)(y|x) = (p(x, y)) / p_(X)(x).
  $
] <def:conditional-pmf>

#definition(name: "Conditional PDF")[
  For continuous $X, Y$ with joint PDF $f(x, y)$ and $f_(X)(x) > 0$, the
  *conditional PDF* of $Y$ given $X = x$ is
  $
    f_(Y|X)(y|x) = (f(x, y)) / f_(X)(x).
  $
] <def:conditional-pdf>

#property(name: "Properties of Conditional Distributions")[
  - For fixed $x$ with $f_(X)(x) > 0$, $f_(Y|X)(dot|x)$ is a bona fide PDF:
    non-negative and integrating to $1$ over $y$;
  - (multiplication rule) $f(x, y) = f_(X)(x) f_(Y|X)(y|x) = f_(Y)(y) f_(X|Y)(x|y)$;
  - (total density) $f_(Y)(y) = integral_(-infinity)^infinity f_(Y|X)(y|x) f_(X)(x) dif x$
    — the density analogue of
    #link(<thm:total-probability>)[the law of total probability];
  - if $X$ and $Y$ are independent, $f_(Y|X)(y|x) = f_(Y)(y)$ — conditioning
    changes nothing.
] <prop:conditional-dist-properties>

#note[
  The *conditional expectation* $E[Y|X]$ — the mean of the conditional
  distribution — and the *law of total expectation*
  $E[Y] = E[E[Y|X]]$ require the notion of expectation, which is developed
  in the Numerical Characteristics chapter. There, the conditional
  framework set up here will yield the tower property and the analysis of
  variance via conditional variances.
]

= Characterization and Classification of Distributions // 分布的特征与分类

The distributions of Chapters 3 and 4 — normal, Gamma, Beta, Poisson,
binomial — look different on the surface, yet most of them share a hidden
algebraic skeleton: the *exponential family*. Recognising a distribution as
a member of this family immediately yields its sufficient statistic, its
moment-generating structure, and its conjugate prior — three pillars of
modern statistical inference. This chapter assembles that skeleton and then
turns to the multivariate normal, the canonical distribution of multivariate
statistics.

== Exponential Family // 指数族

#definition(name: "Exponential Family")[
  A family of densities $f(x; theta)$ with parameter $theta in Theta
  subset.eq RR^k$ belongs to the *exponential family* if it can be written
  in the *canonical form*
  $
    f(x; theta) = h(x) exp(eta(theta) dot T(x) - A(theta)),
  $
  where:

  - $h(x) >= 0$ is the *base measure*, independent of $theta$;
  - $eta(theta) in RR^k$ is the *natural parameter*;
  - $T(x) in RR^k$ is the *natural statistic* (a vector of the same
    dimension as $eta$);
  - $A(theta)$ is the *log-partition function* (or cumulant generating
    function), ensuring normalisation.

  The inner product $eta dot T = sum_(i=1)^k eta_i T_i$ couples parameter
  to data.
] <def:exponential-family>

The key structural constraint is that the support ${{x : f(x; theta) > 0}}$ must not depend on $theta$; the parameter enters only
through the exponential factor.

#property(name: "Classical Distributions in the Exponential Family")[
  Each of the following admits the canonical form; the table lists the
  ingredients.

  | Distribution | $eta$ | $T(x)$ | $A(theta)$ | $h(x)$ |
  |---|---|---|---|---|
  | $"Pois"(lambda)$ | $ln lambda$ | $x$ | $lambda$ | $1 / x!$ |
  | $"Ber"(p)$ | $ln(p / (1-p))$ | $x$ | $-ln(1-p)$ | $1$ |
  | $B(n, p)$ | $ln(p / (1-p))$ | $x$ | $-n ln(1-p)$ | $binom(n, x)$ |
  | $"Exp"(lambda)$ | $-lambda$ | $x$ | $-ln lambda$ | $1$ |
  | $"Ga"(alpha, lambda)$ | $(-lambda, alpha)$ | $(x, ln x)$ | $ln "Gamma"(alpha) - alpha ln lambda$ | $1 / x$ |
  | $N(mu, sigma^2)$ ($sigma$ known) | $mu / sigma^2$ | $x$ | $mu^2 / (2 sigma^2) + ln sigma$ | $exp(-x^2 / (2 sigma^2)) / sqrt(2 pi)$ |
  | $"Be"(a, b)$ | $(a-1, b-1)$ | $(ln x, ln(1-x))$ | $ln "B"(a, b)$ | $1$ |
] <prop:exp-family-members>

The verification is mechanical: rewrite each density by collecting the
$theta$-dependent parts into $exp(eta dot T)$ and moving the
$theta$-independent remainder into $h(x)$. For instance, the Poisson density
$
  f(k; lambda) = (lambda^k exp(-lambda)) / k! = (1 / k!) exp(k ln lambda - lambda)
$
has $eta = ln lambda$, $T(k) = k$, $A = lambda$, $h = 1 / k!$.

#note[
  (A notable exception.) The uniform distribution $U(0, theta)$ does *not*
  belong to the exponential family, because its support $[0, theta]$
  depends on $theta$. The support-independence requirement is not a
  technicality: it is what makes the factorisation theorem and conjugate
  Bayesian analysis work.
]

#definition(name: "Natural Parameter Space")[
  The *natural parameter space* is the set of $eta$ for which the density is
  normalisable:
  $
    H = {eta in RR^k : integral h(x) exp(eta dot T(x)) dif x < infinity}.
  $
  The family is *regular* if $H$ is an open set; *full* if $H$ is the
  maximal set. The log-partition function is
  $
    A(theta) = ln integral h(x) exp(eta(theta) dot T(x)) dif x.
  $
] <def:natural-parameter-space>

#property(name: "Derivative of the Log-Partition Function")[
  Under regularity conditions,
  $
    (dif A) / (dif eta) = E[T(X)], quad (dif^2 A) / (dif eta^2) = "Var"(T(X)).
  $
  Thus the cumulant generating function $A$ encodes the mean and variance of
  the natural statistic.
] <prop:cgf-derivative>

The proof requires interchange of differentiation and integration, which
the regularity of the natural parameter space guarantees. The notation
$E[T(X)]$ and $"Var"(T(X))$ — expectation and variance — is made precise in
the Numerical Characteristics chapter; the point here is that the moments
of the sufficient statistic are read off from the derivatives of $A$.

#note[
  (Sufficient statistic preview.) The canonical form $f(x; theta) = h(x)
  exp(eta dot T(x) - A)$ depends on the data only through $T(x)$. This
  means $T(X_1, dots, X_n) = sum_i T(X_i)$ is a *sufficient statistic* for
  $theta$ — it captures all the information the sample contains about the
  parameter. The formal proof uses the factorisation theorem, developed in
  the Sufficient Statistics chapter. The exponential family is the natural
  habitat of sufficiency.
]

== Multivariate Normal Distribution // 多元正态分布

The univariate normal of #link(<def:normal-dist>)[Chapter 3] extends to
vectors, and its geometry — ellipsoidal contours, linear closure,
independence through zero covariance — makes it the workhorse of multivariate
statistics.

#definition(name: "Multivariate Normal Distribution")[
  A random vector $bold(X) = (X_1, dots, X_n)$ has the *$n$-variate normal
  distribution* with mean vector $bold(mu) in RR^n$ and covariance matrix
  $Sigma$ (a symmetric positive-definite $n times n$ matrix), written
  $bold(X) ~ N_(n)(bold(mu), Sigma)$, if its joint density is
  $
    f(bold(x)) = 1 / ((2 pi)^(n\/2) sqrt(abs(Sigma))) exp(-1\/2 (bold(x) - bold(mu))^T Sigma^(-1) (bold(x) - bold(mu))).
  $
  The quadratic form $(bold(x) - bold(mu))^T Sigma^(-1) (bold(x) - bold(mu))$
  is the *Mahalanobis distance* from $bold(x)$ to $bold(mu)$.
] <def:multivariate-normal>

The covariance matrix $Sigma = (sigma_(i j))$ where $sigma_(i j) =
"Cov"(X_i, X_j)$ encodes the pairwise covariances; its diagonal entries are
the variances $sigma_(i i) = "Var"(X_i)$. These notions are formalised in
the Numerical Characteristics chapter, but the multivariate normal can be
understood geometrically through its density now: level sets are
ellipsoids centred at $bold(mu)$, with axes determined by the eigenvectors
and eigenvalues of $Sigma$.

For $n = 2$ and $Sigma = [[sigma_1^2, rho sigma_1 sigma_2], [rho sigma_1
    sigma_2, sigma_2^2]]$, the contours are ellipses tilted by the correlation
$rho$ — the picture of #link(<fig:joint-density>)[the joint density figure].

#property(name: "Linear Transformations")[
  If $bold(X) ~ N_(n)(bold(mu), Sigma)$ and $bold(Y) = bold(A) bold(X) +
  bold(b)$ where $bold(A)$ is an $m times n$ matrix and $bold(b) in RR^m$,
  then $bold(Y) ~ N_(m)(bold(A) bold(mu) + bold(b), bold(A) Sigma bold(A)^T)$.
  In particular, any linear combination of jointly normal variables is
  normal — the *closure under linear transformation*.
] <prop:mv-normal-linear>

The proof is a direct application of
#link(<thm:jacobian-transform>)[the multivariate change of variables] with
$bold(g)(bold(x)) = bold(A) bold(x) + bold(b)$, whose Jacobian is
$abs(bold(A))$.

#property(name: "Marginal Distributions")[
  Any subvector of a multivariate normal is itself multivariate normal. If
  $bold(X) = (bold(X)_1, bold(X)_2)$ is partitioned with
  $bold(mu) = (bold(mu)_1, bold(mu)_2)$ and
  $
    Sigma = [[Sigma_(11), Sigma_(12)], [Sigma_(21), Sigma_(22)]],
  $
  then $bold(X)_1 ~ N(bold(mu)_1, Sigma_(11))$ and $bold(X)_2 ~
  N(bold(mu)_2, Sigma_(22))$.
] <prop:mv-normal-marginal>

#property(name: "Independence and Zero Covariance")[
  For a multivariate normal, two subvectors $bold(X)_1$ and $bold(X)_2$ are
  *independent* if and only if $"Cov"(bold(X)_1, bold(X)_2) = bold(0)$, i.e.
  $Sigma_(12) = bold(0)$.

  This is a *special* property of the normal: for general distributions,
  zero covariance (uncorrelatedness) is necessary but not sufficient for
  independence (see the note in
  #link(<prop:independence-criterion>)[the independence criterion]). For the
  normal, the density factorises iff $Sigma_(12) = bold(0)$, because the
  cross term in the exponent vanishes.
] <prop:mv-normal-independence>

#property(name: "Conditional Distributions")[
  Given $bold(X)_2 = bold(x)_2$, the conditional distribution of
  $bold(X)_1$ is normal:
  $
    bold(X)_1 | bold(X)_2 = bold(x)_2 ~ N(bold(mu)_(1|2), Sigma_(1|2)),
  $
  with
  $
    bold(mu)_(1|2) = bold(mu)_1 + Sigma_(12) Sigma_(22)^(-1) (bold(x)_2 - bold(mu)_2),
    quad
    Sigma_(1|2) = Sigma_(11) - Sigma_(12) Sigma_(22)^(-1) Sigma_(21).
  $
  The conditional mean is a linear function of $bold(x)_2$ — the *linear
  regression* of $bold(X)_1$ on $bold(X)_2$; the conditional covariance is
  independent of $bold(x)_2$ — the regression is *homoscedastic*.
] <prop:mv-normal-conditional>

These four properties — linear closure, normal marginals, the
equivalence of independence with zero covariance, and normal conditionals —
make the multivariate normal the structural backbone of classical
multivariate analysis, to which the sampling distribution and regression
chapters will return repeatedly.

#part("Numerical Characteristics and Generating Tools")
= Numerical Characteristics // 数字特征

A distribution is fully described by its CDF or density, but a few numbers
— the mean, the variance, the correlation — capture its essential features
and enable comparisons. These *numerical characteristics* are the
quantities that statistics estimates and probability theory bounds.

== Mathematical Expectation // 数学期望

#definition(name: "Expectation of a Discrete Random Variable")[
  Let $X$ be discrete with PMF $p(x)$. If $sum_x abs(x) p(x) < infinity$,
  the *expectation* (or *mean*) of $X$ is
  $
    E[X] = sum_x x p(x).
  $
  If the series is not absolutely convergent, the expectation does not
  exist.
] <def:expectation-discrete>

#definition(name: "Expectation of a Continuous Random Variable")[
  Let $X$ be continuous with PDF $f(x)$. If $integral_(-infinity)^infinity
  abs(x) f(x) dif x < infinity$, the *expectation* of $X$ is
  $
    E[X] = integral_(-infinity)^infinity x f(x) dif x.
  $
] <def:expectation-continuous>

The absolute-convergence requirement is essential: conditionally convergent
series depend on summation order, which has no probabilistic meaning.

#property(name: "Linearity of Expectation")[
  For any random variables $X, Y$ with finite expectations and constants
  $a, b in RR$,
  $
    E[a X + b Y] = a E[X] + b E[Y].
  $
  Linearity holds *without* any independence assumption — this is what
  makes expectation so powerful.
] <prop:expectation-linearity>

#theorem(name: "LOTUS (Law of the Unconscious Statistician)")[
  Let $X$ have PMF $p(x)$ (or PDF $f(x)$) and let $g: RR -> RR$ be
  measurable. Then
  $
    E[g(X)] = sum_x g(x) p(x) quad ("or" quad integral_(-infinity)^infinity g(x) f(x) dif x).
  $
  No intermediate step of deriving the distribution of $Y = g(X)$ is needed
  — the expectation of $g(X)$ is computed directly from the distribution of
  $X$.
] <thm:lotus>

#definition(name: "Conditional Expectation")[
  Given #link(<def:conditional-pmf>)[the conditional PMF/PDF] of $Y$ given
  $X = x$, the *conditional expectation* is
  $
    E[Y|X=x] = sum_y y p_(Y|X)(y|x) quad ("discrete"), quad integral_(-infinity)^infinity y f_(Y|X)(y|x) dif y quad ("continuous").
  $
  As a function of $x$, this defines a random variable $E[Y|X]$ — the
  *regression function* of $Y$ on $X$.
] <def:conditional-expectation>

#theorem(name: "Law of Total Expectation (Tower Property)")[
  If $E[abs(Y)] < infinity$, then
  $
    E[Y] = E[E[Y|X]].
  $
] <thm:total-expectation>

#proof[
  (Continuous case.) Using
  #link(<prop:conditional-dist-properties>)[the total density formula]
  $f_(Y)(y) = integral f_(Y|X)(y|x) f_(X)(x) dif x$:
  $
    E[E[Y|X]] = integral E[Y|X=x] f_(X)(x) dif x = integral (integral y f_(Y|X)(y|x) dif y) f_(X)(x) dif x = integral y (integral f_(Y|X)(y|x) f_(X)(x) dif x) dif y = integral y f_(Y)(y) dif y = E[Y].
  $
  The discrete case replaces integrals by sums.
]

#property(name: "Conditional Variance Decomposition")[
  $
    "Var"(Y) = E["Var"(Y|X)] + "Var"(E[Y|X]).
  $
  The total variance decomposes into the *expected conditional variance*
  (within-group scatter) and the *variance of the conditional mean*
  (between-group scatter).
] <prop:variance-decomposition>

#proof[
  $E["Var"(Y|X)] = E[E[Y^2|X] - (E[Y|X])^2] = E[Y^2] - E[(E[Y|X])^2]$
  and $"Var"(E[Y|X]) = E[(E[Y|X])^2] - (E[E[Y|X]])^2 = E[(E[Y|X])^2] -
  (E[Y])^2$. Adding: $E[Y^2] - (E[Y])^2 = "Var"(Y)$.
]

#property(name: "Markov's Inequality")[
  If $X >= 0$ a.s. and $a > 0$, then
  $
    P(X >= a) <= (E[X]) / a.
  $
] <prop:markov-inequality>

#proof[
  $E[X] = integral_0^infinity x f(x) dif x >= integral_a^infinity x f(x) dif x
  >= a integral_a^infinity f(x) dif x = a P(X >= a)$.
]

#example[
  Common expectations (verified by direct computation or LOTUS):

  | Distribution | $E[X]$ |
  |---|---|
  | $"Ber"(p)$ | $p$ |
  | $B(n, p)$ | $n p$ |
  | $"Pois"(lambda)$ | $lambda$ |
  | $"Geom"(p)$ | $(1-p) / p$ |
  | $U(a, b)$ | $(a+b) / 2$ |
  | $"Exp"(lambda)$ | $1 / lambda$ |
  | $N(mu, sigma^2)$ | $mu$ |
  | $"Ga"(alpha, lambda)$ | $alpha / lambda$ |
  | $"Be"(a, b)$ | $a / (a+b)$ |

  For instance, $E["Exp"(lambda)] = integral_0^infinity x lambda exp(
    -lambda
    x
  ) dif x = 1 / lambda$ by integration by parts.
] <ex:common-expectations>

== Variance and Standard Deviation // 方差与标准差

#definition(name: "Variance")[
  The *variance* of $X$ with finite $E[X^2]$ is
  $
    "Var"(X) = E[(X - E[X])^2] = E[X^2] - (E[X])^2,
  $
  and the *standard deviation* is $sigma = sqrt("Var"(X))$.
] <def:variance>

The computational form $E[X^2] - (E[X])^2$ follows from
#link(<prop:expectation-linearity>)[linearity]: expand $E[(X - mu)^2] =
E[X^2] - 2 mu E[X] + mu^2 = E[X^2] - mu^2$.

#property(name: "Properties of Variance")[
  - $"Var"(a X + b) = a^2 "Var"(X)$ — shift does not affect spread;
  - if $X_1, dots, X_n$ are pairwise independent, $"Var"(sum X_i) = sum
    "Var"(X_i)$;
  - $"Var"(X) >= 0$, with equality iff $X = E[X]$ a.s.;
  - $"Var"(X) < infinity$ iff $E[X^2] < infinity$.
] <prop:variance-properties>

#theorem(name: "Chebyshev's Inequality")[
  If $"Var"(X) < infinity$, then for any $k > 0$,
  $
    P(abs(X - E[X]) >= k) <= ("Var"(X)) / k^2.
  $
  Equivalently, $P(abs(X - mu) >= k sigma) <= 1 / k^2$.
] <thm:chebyshev-inequality>

#proof[
  Apply #link(<prop:markov-inequality>)[Markov's inequality] to the
  non-negative random variable $(X - mu)^2$ with $a = k^2$:
  $
    P(abs(X - mu) >= k) = P((X - mu)^2 >= k^2) <= (E[(X - mu)^2]) / k^2 = ("Var"(X)) / k^2.
  $
]

Chebyshev's inequality is universal — it uses only the mean and variance,
not the full distribution. It is the bridge from finite moments to limit
theorems: the Weak Law of Large Numbers (Part IV) is a direct corollary.

#note[
  (Exponential family callback.) The
  #link(<prop:cgf-derivative>)[log-partition derivative property] states
  $A'' = "Var"(T(X))$. This is a special case of the general principle that
  the variance of a natural statistic is the second derivative of $A$ — a
  fact that connects the algebraic structure of the exponential family
  directly to the numerical characteristics developed here.
]

== Covariance and Correlation // 协方差与相关系数

#definition(name: "Covariance")[
  For random variables $X, Y$ with finite second moments, the *covariance*
  is
  $
    "Cov"(X, Y) = E[(X - E[X])(Y - E[Y])] = E[X Y] - E[X] E[Y].
  $
] <def:covariance>

#definition(name: "Correlation Coefficient")[
  The *Pearson correlation coefficient* is the normalised covariance
  $
    rho_(X Y) = ("Cov"(X, Y)) / (sigma_X sigma_Y),
  $
  provided $sigma_X, sigma_Y > 0$. It satisfies $-1 <= rho <= 1$, with
  $rho = plus.minus 1$ iff $Y = a X + b$ a.s. for some $a != 0$.
] <def:correlation-coefficient>

#property(name: "Uncorrelatedness vs Independence")[
  - If $X$ and $Y$ are independent, then $"Cov"(X, Y) = 0$ (they are
    *uncorrelated*).
  - The converse is false in general: zero covariance does not imply
    independence.
  - (Normal case.) For jointly normal variables, uncorrelatedness and
    independence are *equivalent* — see
    #link(<prop:mv-normal-independence>)[the multivariate normal
      independence property].
  - $"Cov"(X, Y) = 0$ is equivalent to $E[X Y] = E[X] E[Y]$ and to
    $"Var"(X + Y) = "Var"(X) + "Var"(Y)$.
] <prop:uncorrelated-vs-independent>

#example(name: "Uncorrelated but dependent")[
  Let $X ~ U(-1, 1)$ and $Y = X^2$. Then
  $"Cov"(X, Y) = E[X^3] - E[X] E[X^2] = 0 - 0 = 0$ (since $E[X^3] = 0$ by
  symmetry), yet $Y$ is a deterministic function of $X$ — far from
  independent.
]

#definition(name: "Mean Vector and Covariance Matrix")[
  For a random vector $bold(X) = (X_1, dots, X_n)$:
  - the *mean vector* is $bold(mu) = E[bold(X)] = (E[X_1], dots,
      E[X_n])^T$;
  - the *covariance matrix* is the $n times n$ matrix $Sigma$ with entries
    $
      Sigma_(i j) = "Cov"(X_i, X_j), quad i, j = 1, dots, n,
    $
    with $Sigma_(i i) = "Var"(X_i)$ on the diagonal.

  $Sigma$ is symmetric and positive semi-definite. This is the object
  appearing in the
  #link(<def:multivariate-normal>)[multivariate normal density]: the
  abstract $Sigma$ of Chapter 5 is now grounded in the concrete notion of
  covariance.
] <def:mean-vector-covariance-matrix>

== Other Characterization Numbers // 其他特征数

#definition(name: "Moments and Central Moments")[
  The *$k$-th moment* of $X$ is $mu_k = E[X^k]$, and the *$k$-th central
  moment* is
  $
    mu_k' = E[(X - mu)^k],
  $
  provided the expectations exist. The variance is the second central
  moment: $"Var"(X) = mu_2'$.
] <def:moments>

#definition(name: "Coefficient of Variation")[
  The *coefficient of variation* is the dimensionless ratio
  $
    "CV" = sigma / mu,
  $
  measuring relative dispersion. It is meaningful when $X > 0$ (e.g.
  lifetimes, incomes).
] <def:coefficient-of-variation>

#definition(name: "Quantiles and Median")[
  For $0 < p < 1$, the *$p$-th quantile* is
  $
    x_p = inf {x : F(x) >= p}.
  $
  The *median* is $x_(1\/2)$, the *quartiles* are $x_(1\/4)$ and
  $x_(3\/4)$. The *interquartile range* $x_(3\/4) - x_(1\/4)$ is a
  robust measure of spread.
] <def:quantiles>

#definition(name: "Skewness")[
  The *skewness* (coefficient of skewness) is
  $
    gamma_1 = (mu_3') / sigma^3 = (E[(X - mu)^3]) / sigma^3.
  $
  It measures asymmetry: $gamma_1 > 0$ (right-skewed), $gamma_1 < 0$
  (left-skewed), $gamma_1 = 0$ (symmetric).
] <def:skewness>

#definition(name: "Kurtosis")[
  The *kurtosis* (excess kurtosis) is
  $
    gamma_2 = (mu_4') / sigma^4 - 3 = (E[(X - mu)^4]) / sigma^4 - 3.
  $
  The subtraction of $3$ makes the normal distribution the reference:
  $gamma_2 = 0$ (*mesokurtic*), $gamma_2 > 0$ (*leptokurtic* — heavier
  tails), $gamma_2 < 0$ (*platykurtic* — lighter tails).
] <def:kurtosis>

#figure(
  image("img/skewness-kurtosis.svg", width: 90%),
  caption: [Left: positive skewness (right tail heavy) versus negative
    skewness (left tail heavy), with a symmetric density for reference.
    Right: leptokurtic (peaked, heavy tails) versus platykurtic (flat,
    light tails) densities, with the normal (mesokurtic) in between.],
  placement: auto,
  supplement: [Fig.],
) <fig:skewness-kurtosis>

The mean, variance, skewness, and kurtosis are the first four standardised
moments — together they sketch the shape of a distribution: location,
scale, asymmetry, and tail weight. Higher moments and the moment
generating function, which encodes *all* moments in a single function, are
the subject of the next chapter.

= Generating Functions and Transform Methods // 生成函数与变换方法

A single function — the moment generating function, the characteristic
function, or the probability generating function — can encode *all* the
moments, *all* the distributional information, and *all* the
independence structure of a random variable. These transforms turn
hard problems (sums of independent variables, convergence in
distribution) into routine algebra (products, limits of functions).

== Moment Generating Functions // 矩母函数

#definition(name: "Moment Generating Function")[
  The *moment generating function* (MGF) of $X$ is
  $
    M_(X)(t) = E[exp(t X)],
  $
  defined for all $t$ where the expectation is finite. The domain of $M_X$
  is the set $D = {t in RR : E[exp(t X)] < infinity}$, which always
  contains $t = 0$.
] <def:mgf>

The name is justified by the following property — the MGF generates all
moments by differentiation, fulfilling the promise of
#link(<def:moments>)[the moments definition].

#property(name: "Moments from the MGF")[
  If $M_X$ is finite in an open interval containing $t = 0$, then the
  $k$-th moment of $X$ is
  $
    E[X^k] = M_X^(k)(0) = (dif^k M_X) / (dif t^k) upright("at") t = 0.
  $
  This follows from differentiating under the expectation:
  $(dif^k) / (dif t^k) exp(t X) = X^k exp(t X)$, evaluated at $t = 0$.
] <prop:mgf-moments>

#property(name: "Properties of the MGF")[
  - (linearity) $M_(a X + b)(t) = exp(b t) M_(X)(a t)$;
  - (independent sum) if $X$ and $Y$ are independent, $M_(X+Y)(t) = M_(X)(t)
    M_(Y)(t)$ — the MGF of a sum is the product of the MGFs;
  - (identification) $M_X = M_Y$ (on a common domain) implies $X$
    and $Y$ have the same distribution.
] <prop:mgf-properties>

#theorem(name: "Uniqueness Theorem")[
  If $M_(X)(t)$ exists and is finite in an open interval $(-h, h)$ around
  $0$, and if $M_X = M_Y$ on this interval, then $X$ and $Y$ have the
  same distribution.
] <thm:mgf-uniqueness>

The proof relies on the uniqueness of the Laplace transform: if two
integrable functions have the same transform on a strip, they are equal
almost everywhere. This is the analytic counterpart of the
probabilistic statement that the MGF determines the distribution.

#example[
  Common MGFs (computed from the definition via LOTUS):

  | Distribution | $M_(X)(t)$ | Domain |
  |---|---|---|
  | $"Ber"(p)$ | $1 - p + p exp(t)$ | $RR$ |
  | $B(n, p)$ | $(1 - p + p exp(t))^n$ | $RR$ |
  | $"Pois"(lambda)$ | $exp(lambda (exp(t) - 1))$ | $RR$ |
  | $"Exp"(lambda)$ | $lambda / (lambda - t)$ | $t < lambda$ |
  | $"Ga"(alpha, lambda)$ | $(lambda / (lambda - t))^alpha$ | $t < lambda$ |
  | $N(mu, sigma^2)$ | $exp(mu t + sigma^2 t^2 / 2)$ | $RR$ |

  For the normal: $M_(X)(t) = E[exp(t(mu + sigma Z))] = exp(mu t)
  E[exp(sigma t Z)]$ where $Z ~ N(0,1)$; expanding $exp(sigma t Z)$ in
  a power series and using $E[Z^(2k)] = (2k-1) "!!"$ recovers $exp(
    sigma^2
    t^2 / 2
  )$.
] <ex:common-mgf>

#caution[
  (MGF may not exist.) For the Cauchy distribution, $E[exp(t X)] =
  infinity$ for every $t != 0$ — the integral diverges. The MGF fails to
  exist outside $t = 0$, so it cannot be used to identify the
  distribution or compute moments. This motivates the *characteristic
  function*, which always exists.
] <caution:mgf-nonexistence>

== Characteristic Functions // 特征函数

#definition(name: "Characteristic Function")[
  The *characteristic function* (CF) of $X$ is
  $
    phi_(X)(t) = E[exp(i t X)],
  $
  defined for *all* $t in RR$.
] <def:cf>

The CF always exists because $abs(exp(i t X)) = 1$, so $E[abs(
    exp(
      i t
      X
    )
  )] = 1 < infinity$. This is the key advantage over the MGF.

#property(name: "Basic Properties of the CF")[
  - $phi_(X)(0) = 1$;
  - $abs(phi_(X)(t)) <= 1$ for all $t$;
  - (conjugate symmetry) $phi_(X)(-t) = overline(phi_(X)(t))$;
  - (uniform continuity) $phi_X$ is uniformly continuous on $RR$;
  - (linearity) $phi_(a X + b)(t) = exp(i b t) phi_(X)(a t)$;
  - (independent sum) if $X$ and $Y$ are independent, $phi_(X+Y)(t) = phi_(X)(t)
    phi_(Y)(t)$.
] <prop:cf-properties>

#property(name: "Moments and the CF")[
  If $E[abs(X)^k] < infinity$, then
  $
    E[X^k] = i^(-k) phi_X^(k)(0) = i^(-k) (dif^k phi_X) / (dif t^k) upright("at") t = 0.
  $
] <prop:cf-moments>

This mirrors #link(<prop:mgf-moments>)[the MGF moment formula], but with
$i^k$ in the denominator. The CF plays the same role as the MGF for
moment extraction, with the crucial advantage of universal existence.

#theorem(name: "Inversion Formula")[
  If $phi_X$ is integrable ($integral_(-infinity)^infinity abs(phi_(X)(t))
  dif t < infinity$), then $X$ has a continuous density $f$ given by
  $
    f(x) = 1 / (2 pi) integral_(-infinity)^infinity exp(-i t x) phi_(X)(t) dif t.
  $
  In general, $F(b) - F(a) = lim_(T -> infinity) 1/(2 pi) integral_(-T)^T (exp(-i t a) - exp(-i t b)) / (i t) phi_(X)(t) dif t$.
] <thm:inversion-formula>

The proof is a Fourier inversion argument; the full development of the
Fourier analysis tools required is deferred to the Processus Stochastique
note. The essential idea: the CF is the Fourier transform of the
distribution, and the inversion formula is the inverse Fourier transform.

#theorem(name: "Lévy's Continuity Theorem")[
  Let $X_1, X_2, dots$ and $X$ be random variables with CFs $phi_n$ and
  $phi$. Then
  $
    X_n arrow.r^d X quad "iff" quad phi_(n)(t) -> phi(t) "for all" t in RR.
  $
  Moreover, if $phi_n -> phi$ pointwise and $phi$ is continuous at $0$,
  then $phi$ is a CF and $X_n arrow.r^d X$.
] <thm:continuity-theorem>

The proof strategy has two directions:

- ($arrow.r.double$) Convergence in distribution implies pointwise
  convergence of CFs by the definition of $arrow.r^d$ (the
  bounded continuous function $exp(i t dot)$ has the right limit).

- ($arrow.l.double$) This is the hard direction. The key steps are:
  1. (truncation) Show tightness of ${X_n}$ from the convergence $phi_n
    -> phi$ and continuity at $0$;
  2. (subsequence) Extract a weakly convergent subsequence by Prohorov's
  theorem;
  3. (identification) The limit has CF $phi$, hence (by uniqueness) is
  $X$.

This theorem is the *master tool* for proving limit theorems. The
Central Limit Theorem (Part IV) reduces to showing $phi_(S_n / sqrt(n))
(t) -> exp(-t^2 / 2)$ — a routine computation with independent-sum CFs.

#note[
  (Fourier analysis boundary.) The CF is the Fourier transform of the
  distribution measure, and the inversion formula is the inverse
  transform. The full theory — $L^1$ and $L^2$ inversion, Plancherel's
  theorem, distributional Fourier transforms — is developed in the
  Analyse Harmonique note. Here we use the CF as a probabilistic tool;
  the Fourier-analytic proofs of the inversion and continuity theorems
  are recalled as needed.
] <note:fourier-boundary>

== Probability Generating Functions // 概率生成函数

#definition(name: "Probability Generating Function")[
  For a random variable $X$ taking non-negative integer values with PMF
  $p_k = P(X = k)$, the *probability generating function* (PGF) is
  $
    G_(X)(s) = E[s^X] = sum_(k=0)^infinity p_k s^k, quad abs(s) <= 1.
  $
] <def:pgf>

The PGF is, in form, an ordinary generating function (OGF) applied to the
sequence ${p_k}$. The Combinatoire note develops OGFs as a tool for
solving recurrences and counting problems; here the coefficients are
probabilities, and the focus is on extracting moments, handling sums of
independent variables, and analysing compound distributions.

#property(name: "Properties of the PGF")[
  - (normalisation) $G_(X)(1) = 1$;
  - (factorial moments) $G_X^(k)(1) = E[X(X-1)dots(X-k+1)]$, the $k$-th
    factorial moment; in particular $G_X'(1) = E[X]$ and
    $G_X''(1) = E[X(X-1)] = E[X^2] - E[X]$;
  - (independent sum) if $X$ and $Y$ are independent,
    $G_(X+Y)(s) = G_(X)(s) G_(Y)(s)$;
  - (uniqueness) $G_X$ determines the distribution:
    $p_k = G_X^(k)(0) / k!$.
] <prop:pgf-properties>

#property(name: "Compound Distribution (Random Sum)")[
  Let $X_1, X_2, dots$ be i.i.d. with PGF $G_X$, and let $N$ be a
  non-negative integer-valued random variable independent of the $X_i$,
  with PGF $G_N$. The *random sum* $S_N = sum_(i=1)^N X_i$ has PGF
  $
    G_(S_N)(s) = G_(N)(G_(X)(s)).
  $
] <prop:pgf-compound>

#proof[
  Condition on $N = n$: $G_(S_N)(s) = E[s^(X_1 + dots + X_n)] = G_(X)(s)^n$
  by independence. Averaging over $N$:
  $
    G_(S_N)(s) = sum_(n=0)^infinity P(N=n) G_(X)(s)^n = G_(N)(G_(X)(s)).
  $
]

#example(name: "Compound Poisson")[
  If $N ~ "Pois"(lambda)$ and $X_i ~ "Pois"(mu)$,
  then $S_N ~ "Pois"(lambda mu)$. Indeed
  $
    G_(S_N)(s) = G_(N)(G_(X)(s)) = exp(lambda (G_(X)(s) - 1)) = exp(lambda (exp(mu(s - 1)) - 1)) = exp(lambda mu (s - 1)),
  $
  which is the PGF of $"Pois"(lambda mu)$. The Poisson distribution is
  *closed under compounding* — a property central to the compound Poisson
  process in the Stochastic Processes chapter.
] <ex:compound-poisson>

#example[
  Common PGFs:

  | Distribution | $G_(X)(s)$ |
  |---|---|
  | $"Ber"(p)$ | $1 - p + p s$ |
  | $B(n, p)$ | $(1 - p + p s)^n$ |
  | $"Geom"(p)$ | $(p s) / (1 - (1-p) s)$ |
  | $"Pois"(lambda)$ | $exp(lambda (s - 1))$ |

  These are verified by direct summation. For instance, the Poisson PGF:
  $sum_(k=0)^infinity (lambda^k exp(-lambda)) / k! s^k = exp(-lambda)
  sum (lambda s)^k / k! = exp(lambda(s - 1))$.
] <ex:common-pgf>

The three transforms — MGF, CF, PGF — each encode the full distribution
in a single analytic function. The CF, with its universal existence and
the Lévy continuity theorem, is the master tool for the limit theorems
of Part IV.

#part("Limit Theorems")
= LLN and CLT // 大数定律与中心极限定理

The limit theorems — Laws of Large Numbers and the Central Limit Theorem
— are the culmination of the probability-theoretic framework built in
Parts I–III. They answer two fundamental questions:

- *Does the sample average stabilise?* The LLN says yes: $overline(X)_n -> mu$
  (almost surely, or in probability).
- *How fast does it stabilise?* The CLT says: the fluctuation
  $sqrt(n)(overline(X)_n - mu)$ converges *in distribution* to a normal law.

== Concepts of Convergence // 收敛概念

#definition(name: "Convergence in Probability")[
  $X_n$ converges *in probability* to $X$, written $X_n arrow.r^P X$,
  if for every $epsilon > 0$,
  $
    P(abs(X_n - X) > epsilon) -> 0 quad "as" n -> infinity.
  $
] <def:convergence-probability>

#definition(name: "Convergence in Distribution")[
  $X_n$ converges *in distribution* (or *weakly*) to $X$, written
  $X_n arrow.r^d X$, if $F_(n)(x) -> F(x)$ at every continuity point $x$
  of $F$. Equivalently (by #link(<thm:continuity-theorem>)[Lévy's
    continuity theorem]), $phi_(n)(t) -> phi(t)$ for all $t in RR$.
] <def:convergence-distribution>

#definition(name: "Almost Sure Convergence")[
  $X_n$ converges *almost surely* (a.s.) to $X$, written
  $X_n arrow.r^(a.s.) X$, if
  $
    P(lim_(n->infinity) X_n = X) = 1.
  $
  That is, $X_(n)(omega) -> X(omega)$ for all $omega$ outside a null set.
] <def:convergence-as>

#definition(name: "Convergence in L^p")[
  $X_n$ converges *in $L^p$* to $X$, written $X_n arrow.r^(L^p) X$, if
  $E[abs(X_n - X)^p] -> 0$ (assuming $X_n, X in L^p$).
] <def:convergence-lp>

#theorem(name: "Hierarchy of Convergence Modes")[
  - (a.s. $arrow.r.double$ P) $X_n arrow.r^(a.s.) X$ implies $X_n
    arrow.r^P X$;
  - ($L^p$ $arrow.r.double$ P) $X_n arrow.r^(L^p) X$ implies $X_n
    arrow.r^P X$;
  - (P $arrow.r.double$ d) $X_n arrow.r^P X$ implies $X_n arrow.r^d X$;
  - Neither a.s. nor $L^p$ implies the other.
] <thm:convergence-relations>

#proof[
  (a.s. $arrow.r.double$ P) If $X_n -> X$ a.s., then for any $epsilon > 0$,
  ${abs(X_n - X) > epsilon}$ occurs only finitely often (outside a null
  set). By #link(<thm:borel-cantelli>)[the first Borel-Cantelli lemma],
  $P(abs(X_n - X) > epsilon) -> 0$.

  ($L^p$ $arrow.r.double$ P) By #link(<prop:markov-inequality>)[Markov's
    inequality], $P(abs(X_n - X) > epsilon) <= E[abs(X_n - X)^p] / epsilon^p
  -> 0$.

  (P $arrow.r.double$ d) If $X_n arrow.r^P X$, then at any continuity
  point $x$ of $F$, split $F_(n)(x)$ using $abs(X_n - X) > epsilon$ and
  bound each piece to get $F_(n)(x) -> F(x)$.
]

== Laws of Large Numbers // 大数定律

#theorem(name: "Bernoulli WLLN")[
  Let $X_1, X_2, dots$ be i.i.d. $"Ber"(p)$ random variables and
  $overline(X)_n = (1/n) sum_(i=1)^n X_i$. Then for every $epsilon > 0$,
  $
    P(abs(overline(X)_n - p) > epsilon) -> 0.
  $
] <thm:bernoulli-wlln>

#proof[
  Since $E[overline(X)_n] = p$ and $"Var"(overline(X)_n) = p(1-p)/n$, #link(<thm:chebyshev-inequality>)[Chebyshev's inequality] gives
  $
    P(abs(overline(X)_n - p) > epsilon) <= p(1-p) / (n epsilon^2) -> 0.
  $
  This fulfils the promise of #link(<prop:frequency-stability>)[frequency
    stability]: the relative frequency $overline(X)_n$ converges to the theoretical
  probability $p$.
]

#theorem(name: "Chebyshev WLLN")[
  Let $X_1, X_2, dots$ be independent (not necessarily identically
  distributed) with $E[X_i] = mu_i$ and $"Var"(X_i) <= C$ for all $i$.
  Then $overline(X)_n - overline(mu)_n arrow.r^P 0$, where $overline(mu)_n = (1/n) sum mu_i$.
] <thm:chebyshev-wlln>

#theorem(name: "Khinchin WLLN")[
  Let $X_1, X_2, dots$ be i.i.d. with $E[abs(X_1)] < infinity$ and
  $E[X_1] = mu$. Then $overline(X)_n arrow.r^P mu$.
] <thm:khinchin-wlln>

#proof[
  (via characteristic functions.) Let $phi$ be the CF of $X_1$. The CF of
  $overline(X)_n$ is $phi_(overline(X)_n)(t) = [phi(t/n)]^n$. Since $E[abs(X_1)] < infinity$,
  $phi$ is differentiable at $0$ with $phi'(0) = i mu$, so
  $
    phi(t/n) = 1 + i mu t / n + o(1/n), quad [phi(t/n)]^n -> exp(i mu t).
  $
  The right side is the CF of the constant $mu$. By #link(<thm:continuity-theorem>)[Lévy's continuity theorem],
  $overline(X)_n arrow.r^d mu$, which implies $overline(X)_n arrow.r^P mu$.
]

#theorem(name: "Kolmogorov SLLN")[
  Let $X_1, X_2, dots$ be i.i.d. with $E[abs(X_1)] < infinity$ and
  $E[X_1] = mu$. Then
  $
    overline(X)_n arrow.r^(a.s.) mu.
  $
] <thm:kolmogorov-slln>

The proof requires deeper machinery than the weak law. The key tool is
*Kolmogorov's inequality* — a maximal version of Chebyshev's inequality
controlling $max_(k<=n) abs(S_k - k mu)$. Combined with the
*Borel-Cantelli second lemma* (which states: if $A_n$ are independent
and $sum P(A_n) = infinity$, then $A_n$ occur infinitely often), one
shows that the event ${abs(overline(X)_n - mu) > epsilon quad "i.o."}$ has
probability $0$ for every $epsilon > 0$, yielding a.s. convergence.

This fulfils the promise of #link(<thm:borel-cantelli>)[the Borel-Cantelli
  lemmas]: the second lemma, whose proof was deferred from Part I, is
central to the SLLN.

== Central Limit Theorem // 中心极限定理

#theorem(name: "Lindeberg-Lévy CLT")[
  Let $X_1, X_2, dots$ be i.i.d. with $E[X_1] = mu$ and
  $0 < "Var"(X_1) = sigma^2 < infinity$. Then
  $
    sqrt(n) (overline(X)_n - mu) arrow.r^d N(0, sigma^2).
  $
] <thm:clt>

#proof[
  (via characteristic functions.) We fulfil the promise of
  #link(<thm:continuity-theorem>)[Lévy's continuity theorem]: the CLT
  reduces to showing $phi_(sqrt(n)(overline(X)_n - mu))(t) ->
  exp(-sigma^2 t^2 / 2)$.

  Let $Z_i = (X_i - mu) / sigma$, so $E[Z_1] = 0$, $"Var"(Z_1) = 1$.
  Then $sqrt(n)(overline(X)_n - mu) / sigma = (1/sqrt(n)) sum Z_i$,
  whose CF is $[phi_(Z)(t/sqrt(n))]^n$. Since $E[Z_1^2] = 1$, the CF
  has the expansion (by #link(<prop:cf-moments>)[the CF moment formula]):
  $
    phi_(Z)(t/sqrt(n)) = 1 - t^2/(2n) + o(1/n).
  $
  Hence
  $
    [phi_(Z)(t/sqrt(n))]^n = [1 - t^2/(2n) + o(1/n)]^n -> exp(-t^2/2),
  $
  which is the CF of $N(0,1)$. By #link(<thm:continuity-theorem>)[the
    continuity theorem], $sqrt(n)(overline(X)_n - mu) / sigma arrow.r^d
  N(0,1)$, i.e. $sqrt(n)(overline(X)_n - mu) arrow.r^d N(0, sigma^2)$.
]

#corollary(name: "De Moivre-Laplace CLT")[
  If $X_n ~ B(n, p)$, then for large $n$,
  $
    (X_n - n p) / sqrt(n p (1-p)) approx N(0, 1).
  $
] <cor:demoivre-laplace>

This is the CLT applied to Bernoulli trials: $X_n = sum_(i=1)^n X_i$ with
$X_i ~ "Ber"(p)$, $mu = p$, $sigma^2 = p(1-p)$. The De Moivre-Laplace
theorem predates the general CLT by two centuries.

#property(name: "Lindeberg-Lyapunov CLT (Independent, Non-Identically Distributed)")[
  Let $X_1, X_2, dots$ be independent with $E[X_k] = mu_k$,
  $"Var"(X_k) = sigma_k^2$, $s_n^2 = sum_(k=1)^n sigma_k^2$. If the
  *Lindeberg condition* holds —
  $
    (1 / s_n^2) sum_(k=1)^n E[(X_k - mu_k)^2 dot 1_{abs(X_k - mu_k) > epsilon s_n}] -> 0 quad "for all" epsilon > 0 —
  $
  then $S_n / s_n arrow.r^d N(0,1)$, where $S_n = sum_(k=1)^n (X_k - mu_k)$.
] <prop:lindeberg-condition>

The Lindeberg condition ensures that no single $X_k$ dominates the sum.
A simpler but stronger sufficient condition is the *Lyapunov condition*:
$sum E[abs(X_k - mu_k)^(2+delta)] / s_n^(2+delta) -> 0$ for some
$delta > 0$. The proof uses the same CF strategy as the i.i.d. case,
but the Taylor expansion must control each term individually.

#example(name: "Normal approximation to the binomial")[
  A factory produces items with
  defect rate $p = 0.05$. In a batch of $n = 1000$, what is
  $P(X >= 60)$ for $X ~ B(1000, 0.05)$?

  By De Moivre-Laplace, $(X - 50) / sqrt(47.5) approx N(0,1)$, so
  $
    P(X >= 60) approx. P(N(0,1) >= (59.5 - 50)/sqrt(47.5)) approx. P(Z >= 1.378) approx. 0.084.
  $
  The continuity correction ($59.5$ instead of $60$) improves the
  approximation.
] <ex:normal-approximation>

#example(name: "CLT for sample means")[
  If $X_1, dots, X_n$ is a random sample from
  any distribution with mean $mu$ and variance $sigma^2$, then for large
  $n$ the sample mean $overline(X)_n$ is approximately normal:
  $
    overline(X)_n approx N(mu, sigma^2 / n).
  $
  This is the foundation of statistical inference: even when the
  population distribution is unknown, the sample mean has a
  well-characterised *asymptotic* distribution. The Delta method extends
  this to smooth functions of $overline(X)_n$.
] <ex:clt-application>

== Delta Method // Delta 方法

#theorem(name: "Delta Method (First Order)")[
  Let $X_1, X_2, dots$ be i.i.d. with $E[X_1] = mu$ and
  $"Var"(X_1) = sigma^2 < infinity$. If $g$ is differentiable at $mu$
  with $g'(mu) != 0$, then
  $
    sqrt(n) (g(overline(X)_n) - g(mu)) arrow.r^d N(0, [g'(mu)]^2 sigma^2).
  $
] <thm:delta-method>

#proof[
  By #link(<thm:clt>)[the CLT], $sqrt(n)(overline(X)_n - mu)
  arrow.r^d N(0, sigma^2)$. A first-order Taylor expansion gives
  $
    g(overline(X)_n) = g(mu) + g'(mu)(overline(X)_n - mu) + o_(p)(overline(X)_n - mu).
  $
  Multiplying by $sqrt(n)$ and using Slutsky's theorem (if $Y_n arrow.r^d
  Y$ and $Z_n arrow.r^P c$, then $Z_n Y_n arrow.r^d c Y$):
  $
    sqrt(n)(g(overline(X)_n) - g(mu)) = g'(mu) dot sqrt(n)(overline(X)_n - mu) + o_(p)(1) arrow.r^d g'(mu) dot N(0, sigma^2) = N(0, [g'(mu)]^2 sigma^2).
  $
]

#example[
  Let $X_1, dots, X_n$ be i.i.d. $"Exp"(lambda)$, so $mu = 1/lambda$,
  $sigma^2 = 1/lambda^2$. To estimate $g(mu) = 1/mu = lambda$ via
  $g(overline(X)_n) = 1/overline(X)_n$, note $g'(mu) = -1/mu^2 =
  -lambda^2$, so $[g'(mu)]^2 sigma^2 = lambda^4 dot 1/lambda^2 =
  lambda^2$. The Delta method gives
  $
    sqrt(n) (1/overline(X)_n - lambda) arrow.r^d N(0, lambda^2).
  $
  This previews Part VI: the maximum likelihood estimator of $lambda$
  is $1/overline(X)_n$, and the Delta method establishes its asymptotic
  normality.
] <ex:delta-method-application>

The limit theorems of this chapter are the pillars of statistical
inference. Part V applies them to sampling distributions; Part VI uses
the CLT and Delta method to establish the asymptotic properties of
estimators.

// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
//
// 教材基准：茆诗松《概率论与数理统计教程》全部知识点
// 补充内容：指数族、Basu 定理、Delta 方法、多元正态、多元线性回归、
//           双因素方差分析、核密度估计、随机过程初步等
//
// 主线：概率论（公理→随机变量→极限定理）
//       → 数理统计（抽样→估计→检验→回归）
//       → 应用拓展
//
// 职责边界：
//   - 测度论 / σ-代数构造 → Théorie des Ensembles
//   - Lebesgue 积分理论  → Analyse Réelle
//   - Fourier 分析工具    → Processus Stochastique
//   - 随机过程深入理论    → Processus Stochastique
//
// ==========================================================================


// ==========================================================================
// Part I — 概率论基础 (Fundamentals of Probability)
// ==========================================================================
// 设计思路：从随机现象的数学建模出发，建立 Kolmogorov 公理框架，
// 再发展条件概率与独立性理论。这是整个概率论的地基。
// 对应教材：第一章 §1.1–§1.5

// --- Chapter 1: 随机事件与概率 (Random Events and Probability) ---

//   Section 1.1: 随机事件及其运算 (Random Events and Operations)
//     - 随机现象与随机试验
//     - 样本空间 (Sample Space)
//     - 随机事件与事件域 (Event Space / σ-field of Events)
//     - 事件间的关系（包含、相等、互斥、对立）
//     - 事件间的运算（并、交、差、De Morgan 律）
//     - 随机变量的直观引入

//   Section 1.2: 概率的定义 (Definitions of Probability)
//     - 概率的公理化定义 (Kolmogorov Axioms)
//     - 频率方法与频率的稳定性
//     - 古典概型 (Classical Probability)
//     - 几何概型 (Geometric Probability)
//     - 主观概率 (Subjective Probability)
//     - 注：σ-代数的深入构造参见 Théorie des Ensembles

//   Section 1.3: 概率的性质 (Properties of Probability)
//     - 概率的可加性 (Additivity)
//     - 概率的单调性 (Monotonicity)
//     - 加法公式 (Addition Formula)
//     - 概率的连续性 (Continuity of Probability)
//     - Borel-Cantelli 引理

//   Section 1.4: 组合方法 (Combinatorial Methods)
//     - 排列与组合公式
//     - 计数原理与经典概率计算
//     - 容斥原理
//     - 经典模型：配对问题、Polya 罐子模型


// --- Chapter 2: 条件概率与独立性 (Conditional Probability and Independence) ---

//   Section 2.1: 条件概率 (Conditional Probability)
//     - 条件概率的定义
//     - 乘法公式 (Multiplication Rule)

//   Section 2.2: 全概率公式与 Bayes 公式 (Total Probability and Bayes' Theorem)
//     - 样本空间的划分
//     - 全概率公式
//     - Bayes 公式及其统计诠释

//   Section 2.3: 独立性 (Independence)
//     - 两个事件的独立性
//     - 多个事件的相互独立性
//     - 试验的独立性
//     - 独立试验与 Bernoulli 概型


// ==========================================================================
// Part II — 随机变量及其分布 (Random Variables and Distributions)
// ==========================================================================
// 设计思路：从一维到多维，从分布函数到具体分布族，再到随机变量函数的分布。
// 建立完整的分布理论，为后续数字特征和统计推断提供对象。
// 对应教材：第二章 §2.1–§2.7 + 第三章 §3.1–§3.5

// --- Chapter 3: 一维随机变量及其分布 (Univariate Random Variables and Distributions) ---

//   Section 3.1: 随机变量及其分布 (Random Variables and Their Distributions)
//     - 随机变量的概念
//     - 分布函数 (CDF)：定义与基本性质
//     - 离散型随机变量与分布列 (PMF)
//     - 连续型随机变量与密度函数 (PDF)

//   Section 3.2: 常用离散分布 (Common Discrete Distributions)
//     - Bernoulli 分布
//     - 二项分布 (Binomial)
//     - Poisson 分布
//     - 超几何分布 (Hypergeometric)
//     - 几何分布与负二项分布 (Geometric & Negative Binomial)
//     - 各分布的背景模型与相互关系

//   Section 3.3: 常用连续分布 (Common Continuous Distributions)
//     - 正态分布 (Normal)
//     - 均匀分布 (Uniform)
//     - 指数分布 (Exponential)
//     - Gamma 分布
//     - Beta 分布
//     - 连续分布的核 (Kernel of a Distribution)
//     - 各分布的性质与相互关系

//   Section 3.4: 随机变量函数的分布 (Distributions of Functions of RVs)
//     - 离散型随机变量函数的分布
//     - 连续型随机变量函数的分布


// --- Chapter 4: 多维随机变量及其分布 (Multivariate Random Variables and Distributions) ---

//   Section 4.1: 联合分布 (Joint Distributions)
//     - 多维随机变量
//     - 联合分布函数
//     - 联合分布列 / 联合密度函数
//     - 常用多维分布（多元均匀分布、多元正态分布等）

//   Section 4.2: 边缘分布与独立性 (Marginal Distributions and Independence)
//     - 边缘分布函数
//     - 边缘分布列 / 边缘密度函数
//     - 随机变量间的独立性

//   Section 4.3: 随机变量函数的分布 (Distributions of Functions of RVs)
//     - 多维离散随机变量函数的分布
//     - 最大值与最小值的分布
//     - 卷积公式 (Convolution Formula)
//     - 变量变换法 (Jacobian Method)

//   Section 4.4: 条件分布与条件期望 (Conditional Distributions and Expectation)
//     - 条件分布
//     - 条件数学期望
//     - 全期望公式与全方差公式


// --- Chapter 5: 分布的特征与分类 (Characterization and Classification of Distributions) ---
// 设计思路：补充教材之外的结构性内容——指数族是连接经典分布与现代统计推断的桥梁，
// 多元正态是多元统计的基础。

//   Section 5.1: 指数族 (Exponential Family)
//     - 自然参数与充分统计量的联系
//     - 自然参数空间

//   Section 5.2: 多元正态分布 (Multivariate Normal Distribution)
//     - 定义与性质
//     - 线性变换下的不变性


// ==========================================================================
// Part III — 数字特征与生成工具 (Numerical Characteristics and Generating Tools)
// ==========================================================================
// 设计思路：用数字特征刻画分布，用生成函数提供统一分析工具。
// 特征函数在 Part IV 的极限定理中扮演关键角色（证明 CLT）。
// 对应教材：§2.2–§2.3（期望/方差/不等式）、§2.7（其他特征数）、
//           §3.4（协方差/相关系数）、§4.2（特征函数）

// --- Chapter 6: 数字特征 (Numerical Characteristics) ---

//   Section 6.1: 数学期望 (Mathematical Expectation)
//     - 定义（离散 / 连续）
//     - 性质与运算规则
//     - 马尔可夫不等式 (Markov's Inequality)

//   Section 6.2: 方差与标准差 (Variance and Standard Deviation)
//     - 定义与性质
//     - 切比雪夫不等式 (Chebyshev's Inequality)

//   Section 6.3: 协方差与相关系数 (Covariance and Correlation)
//     - 协方差的定义与性质
//     - 相关系数；不相关与独立的关系
//     - 随机向量的期望向量与协方差矩阵

//   Section 6.4: 分布的其他特征数 (Other Characterization Numbers)
//     - k 阶矩与中心矩
//     - 变异系数 (Coefficient of Variation)
//     - 分位数与中位数 (Quantiles and Median)
//     - 偏度系数 (Skewness)
//     - 峰度系数 (Kurtosis)


// --- Chapter 7: 生成函数与变换方法 (Generating Functions and Transform Methods) ---

//   Section 7.1: 矩母函数 (Moment Generating Functions)
//     - 定义与性质
//     - 唯一性定理

//   Section 7.2: 特征函数 (Characteristic Functions)
//     - 定义与基本性质
//     - 反转公式
//     - 连续性定理
//     - 注：Fourier 分析工具详见 Processus Stochastique

//   Section 7.3: 概率生成函数 (Probability Generating Functions)
//     - 离散情形
//     - 复合分布的应用


// ==========================================================================
// Part IV — 极限定理 (Limit Theorems)
// ==========================================================================
// 设计思路：概率论的理论高峰——从收敛模式到大数定律和中心极限定理，
// 为统计推断的渐近理论提供保证。特征函数在此部分用于证明 CLT。
// 对应教材：第四章 §4.1–§4.4

// --- Chapter 8: 大数定律与中心极限定理 (LLN and CLT) ---

//   Section 8.1: 收敛概念 (Concepts of Convergence)
//     - 依概率收敛
//     - 依分布收敛 / 弱收敛
//     - 几乎必然收敛
//     - L^p 收敛
//     - 各收敛模式之间的关系

//   Section 8.2: 大数定律 (Laws of Large Numbers)
//     - Bernoulli 大数定律
//     - Chebyshev 大数定律
//     - Khinchin 大数定律
//     - Kolmogorov 强大数定律

//   Section 8.3: 中心极限定理 (Central Limit Theorem)
//     - 独立同分布情形 (Lindeberg-Lévy CLT)
//     - 二项分布的正态近似 (De Moivre-Laplace)
//     - 独立不同分布情形 (Lindeberg / Lyapunov 条件)
//     - CLT 的应用与近似计算

//   Section 8.4: Delta 方法 (Delta Method)
//     - 一阶 Delta 方法
//     - 在统计量渐近分布中的应用


// ==========================================================================
// Part V — 数理统计基础 (Fundamentals of Mathematical Statistics)
// ==========================================================================
// 设计思路：从概率论过渡到数理统计——数据如何产生（抽样）、
// 如何压缩信息（充分统计量）。这是从"已知模型推数据"到"从数据推模型"的转折。
// 对应教材：第五章 §5.1–§5.5

// --- Chapter 9: 抽样与经验分布 (Sampling and Empirical Distributions) ---

//   Section 9.1: 总体与样本 (Population and Samples)
//     - 总体与个体
//     - 样本与统计量
//     - 经验分布函数 (Empirical Distribution Function)
//     - Glivenko-Cantelli 定理

//   Section 9.2: 样本矩与抽样分布 (Sample Moments and Sampling Distributions)
//     - 统计量与抽样分布的概念
//     - 样本均值及其抽样分布
//     - 样本方差与样本标准差
//     - 样本矩及其函数
//     - 蒙特卡罗方法 (Monte Carlo Methods)

//   Section 9.3: 次序统计量 (Order Statistics)
//     - 次序统计量的概念
//     - 单个次序统计量的分布
//     - 多个次序统计量及其函数的分布
//     - 样本中位数与样本分位数
//     - 五数概括 (Five-Number Summary) 与箱线图 (Box Plot)

//   Section 9.4: 三大抽样分布 (Three Major Sampling Distributions)
//     - χ² 分布 (Chi-Squared)：定义、性质、分位数
//     - t 分布 (Student's t)：定义、性质、分位数
//     - F 分布 (Fisher's F)：定义、性质、分位数

//   Section 9.5: 正态总体下的抽样分布 (Sampling Distributions under Normality)
//     - X̄ 与 S² 的独立性
//     - 基于正态总体的经典抽样分布结论


// --- Chapter 10: 充分统计量 (Sufficient Statistics) ---

//   Section 10.1: 充分性的概念 (Concept of Sufficiency)

//   Section 10.2: 因子分解定理 (Factorization Theorem)

//   Section 10.3: 完备统计量 (Complete Statistics)
//     - 完备性定义
//     - Bahadur 定理

//   Section 10.4: Ancillary 统计量与 Basu 定理 (Ancillary Statistics and Basu's Theorem)


// ==========================================================================
// Part VI — 参数估计 (Parametric Estimation)
// ==========================================================================
// 设计思路：点估计的方法→评价→改进→区间估计，构成参数估计的完整链条。
// EM 算法和 MLE 渐近正态性是现代计算与理论的重要补充。
// 对应教材：第六章 §6.1–§6.6

// --- Chapter 11: 点估计方法 (Methods of Point Estimation) ---

//   Section 11.1: 矩估计法 (Method of Moments)
//     - 替换原理
//     - 概率函数已知时的矩估计

//   Section 11.2: 极大似然估计法 (Maximum Likelihood Estimation)
//     - 似然函数与 MLE
//     - EM 算法 (EM Algorithm)
//     - MLE 的渐近正态性 (Asymptotic Normality)
//     - MLE 的不变性原理

//   Section 11.3: 最小二乘法 (Least Squares Method)

//   Section 11.4: Bayes 估计 (Bayesian Estimation)
//     - 统计推断的贝叶斯范式
//     - 先验分布的选择与共轭先验族
//     - 后验分布的密度函数形式


// --- Chapter 12: 估计的评价与改进 (Evaluation and Improvement of Estimators) ---

//   Section 12.1: 无偏性 (Unbiasedness)

//   Section 12.2: 有效性与 Cramér-Rao 不等式 (Efficiency and Cramér-Rao Inequality)
//     - Fisher 信息量
//     - Cramér-Rao 下界的推导与等号成立条件

//   Section 12.3: 一致性 / 相合性 (Consistency)
//     - 弱一致性与强一致性
//     - 矩估计与 MLE 的相合性

//   Section 12.4: 均方误差 (Mean Squared Error)

//   Section 12.5: 一致最小方差无偏估计 (UMVUE)
//     - 充分性原则
//     - Rao-Blackwell 定理
//     - Lehmann-Scheffé 定理（基于完备充分统计量）


// --- Chapter 13: 区间估计 (Interval Estimation) ---

//   Section 13.1: 置信区间的概念 (Concept of Confidence Intervals)
//     - 置信水平与频率诠释
//     - 枢轴量法 (Pivotal Quantity Method)

//   Section 13.2: 单个正态总体参数的置信区间 (CIs for Single Normal Population)
//     - μ 的置信区间（σ 已知 / σ 未知）
//     - σ² 的置信区间

//   Section 13.3: 两个正态总体参数的置信区间 (CIs for Two Normal Populations)
//     - μ₁ - μ₂ 的置信区间（含配对样本）
//     - σ₁² / σ₂² 的置信区间

//   Section 13.4: 大样本置信区间 (Large-Sample CIs)

//   Section 13.5: 样本量的确定 (Sample Size Determination)


// ==========================================================================
// Part VII — 假设检验 (Hypothesis Testing)
// ==========================================================================
// 设计思路：从基本思想到具体检验，再到拟合优度与非参数方法。
// 假设检验与置信区间的对偶性是重要的统一视角。
// 对应教材：第七章 §7.1–§7.6

// --- Chapter 14: 假设检验的理论与方法 (Theory and Methods of Hypothesis Testing) ---

//   Section 14.1: 假设检验的基本概念 (Basic Concepts)
//     - 假设检验问题与基本步骤
//     - 第一类错误与第二类错误
//     - P 值 (P-value)

//   Section 14.2: Neyman-Pearson 范式 (Neyman-Pearson Paradigm)
//     - 功效函数 (Power Function)
//     - Neyman-Pearson 引理

//   Section 14.3: 似然比检验 (Likelihood Ratio Tests)
//     - 广义似然比检验的思想

//   Section 14.4: 正态总体参数的假设检验 (Tests for Normal Population Parameters)
//     - 单个正态总体均值的检验（Z 检验、t 检验）
//     - 两个正态总体均值差的检验（含成对数据检验）
//     - 正态总体方差的检验（χ² 检验、F 检验）

//   Section 14.5: 假设检验与置信区间的对偶性 (Duality of Tests and CIs)

//   Section 14.6: 其他分布参数的假设检验 (Tests for Other Distribution Parameters)
//     - 指数分布参数的检验
//     - 比率 p 的检验
//     - 大样本检验


// --- Chapter 15: 拟合检验与非参数检验 (Goodness-of-Fit and Nonparametric Tests) ---

//   Section 15.1: 正态性检验 (Normality Tests)
//     - 正态概率纸 (Normal Probability Paper)
//     - W 检验 (Shapiro-Wilk Test)
//     - EP 检验 (Epstein Test)

//   Section 15.2: χ² 拟合优度与独立性检验 (Chi-Squared Tests)
//     - 分类数据的 χ² 拟合优度检验
//     - 分布的 χ² 拟合优度检验
//     - 列联表的独立性检验

//   Section 15.3: 方差齐性检验 (Tests for Homogeneity of Variances)
//     - Hartley 检验
//     - Bartlett 检验
//     - 修正的 Bartlett 检验

//   Section 15.4: 非参数检验 (Nonparametric Tests)
//     - 游程检验 (Runs Test)
//     - 符号检验 (Sign Test)
//     - Wilcoxon 秩和检验 (Wilcoxon Rank-Sum Test)
//     - Mann-Whitney U 检验


// ==========================================================================
// Part VIII — 方差分析与回归分析 (ANOVA and Regression Analysis)
// ==========================================================================
// 设计思路：统计推断在组间比较与变量关系建模中的核心应用。
// 方差分析本质上是线性模型的特例，两者统一于最小二乘框架。
// 对应教材：第八章 §8.1–§8.5

// --- Chapter 16: 方差分析 (Analysis of Variance) ---

//   Section 16.1: 单因素方差分析 (One-Way ANOVA)
//     - 统计模型
//     - 平方和分解
//     - F 检验
//     - 参数估计
//     - 重复数不等的情形

//   Section 16.2: 多重比较 (Multiple Comparisons)
//     - 水平均值差的置信区间
//     - 重复数相等时的 T 法 (Tukey HSD)
//     - 重复数不等时的 S 法 (Scheffé)

//   Section 16.3: 方差齐性检验 (Tests for Homogeneity of Variances)
//     - Hartley 检验、Bartlett 检验
//     - 与 §15.3 的联系与区别

//   Section 16.4: 双因素方差分析 (Two-Way ANOVA)
//     - 无交互作用模型
//     - 有交互作用模型


// --- Chapter 17: 回归分析 (Regression Analysis) ---

//   Section 17.1: 一元线性回归 (Simple Linear Regression)
//     - 变量间的两类关系
//     - 回归模型与最小二乘估计
//     - 回归方程的显著性检验
//     - 估计与预测

//   Section 17.2: 一元非线性回归 (Simple Nonlinear Regression)
//     - 确定可能的函数形式
//     - 参数估计（线性化方法）
//     - 曲线回归方程的比较

//   Section 17.3: 多元线性回归 (Multiple Linear Regression)
//     - 矩阵表示
//     - 参数估计与统计推断

//   Section 17.4: 回归诊断 (Regression Diagnostics)
//     - 拟合优度 R²
//     - 残差分析


// ==========================================================================
// Part IX — 拓展专题 (Advanced Topics)
// ==========================================================================
// 设计思路：从独立随机变量到相依随机过程的自然延伸，
// 为后续深入学习 Processus Stochastique 搭建桥梁。
// 本部分仅作导论，深入理论参见 Processus Stochastique 笔记。

// --- Chapter 18: 随机过程初步 (Introduction to Stochastic Processes) ---

//   Section 18.1: 随机过程的定义与分类 (Definition and Classification)
//     - 有限维分布；平稳性；独立增量

//   Section 18.2: 离散时间 Markov 链 (Discrete-Time Markov Chains)
//     - 转移概率矩阵；状态分类；平稳分布

//   Section 18.3: Poisson 过程 (Poisson Processes)
//     - 定义与性质；到达时间间隔

//   Section 18.4: 连续时间 Markov 链初步 (Introduction to CTMCs)

//   Section 18.5: Brown 运动初步 (Introduction to Brownian Motion)


// ==========================================================================
// Appendix
// ==========================================================================
// 设计思路：统计分布表供查表使用（对应教材附表），
// Glossary 按字母顺序索引所有定义标签，与仓库其他笔记格式一致。

// --- 统计分布表 (Statistical Distribution Tables) ---
//   - Poisson 分布函数表
//   - 标准正态分布函数表
//   - χ² 分布分位数表
//   - t 分布分位数表
//   - F 分布分位数表
//   - 正态性检验统计量 W 的系数与分位数表
//   - 非参数检验临界值表（游程、Wilcoxon 等）

// --- Glossary ---


// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循"概率论 → 数理统计 → 应用拓展"的三段式主线，共 9 Part、18 Chapter。
//
// Part I–IV（概率论，Ch 1–8）：从公理化的概率空间出发，经随机变量与分布
// （一维→多维）、数字特征与生成函数，到极限定理——构成概率论的完整理论框架。
//
// Part V（过渡，Ch 9–10）：抽样分布与充分统计量是连接概率论与统计推断的桥梁，
// 从"已知模型推数据"转向"从数据推模型"。
//
// Part VI–VIII（数理统计，Ch 11–17）：参数估计（方法→评价→改进→区间）→
// 假设检验（理论→具体检验→拟合/非参数）→ 方差分析与回归分析。
//
// Part IX（拓展，Ch 18）：随机过程初步作为概率论的自然延伸，
// 为后续 Processus Stochastique 笔记做铺垫。
//
// 教材覆盖：茆诗松《概率论与数理统计教程》全部 8 章知识点均已覆盖。
// ==========================================================================


#bibliography("references.bib")

// 目录

