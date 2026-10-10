#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Algèbre Linéaire", // 线性代数
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Algèbre Linéaire", // 线性代数
  "Violet",
  subtitle: "A notebook for linear algebra",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.1.0",
  extra-info: "This is a notebook for linear algebra.",
)

#make-outline(depth: 2, title: "Contents")

// 目录

// ==========================================================================
// Part I — Determinants, Matrices and Linear Systems (行列式、矩阵与线性方程组)
// ==========================================================================
// 设计思路：本 Part 建立线性代数的具体计算工具——行列式是矩阵可逆性的判据，
// 矩阵是线性映射的坐标表示，线性方程组是这三个工具的综合应用。
// 对应教材：丘维声 §1–3、谢启鸿 §1–3、王萼芳 §1–3。

#part("Determinants, Matrices and Linear Systems") // 行列式、矩阵与线性方程组

= Preliminaries // 预备知识

This chapter collects the notational conventions used throughout the notebook.
Set-theoretic and mapping basics are quoted from the Théorie des Ensembles note
rather than redefined here.

== Notations // 符号说明

The set of all $m times n$ matrices over the number field $P$ is denoted by $M_(m times n)(P)$ or $P^(m times n)$.
Similarly, the set of all linear mappings from $V$ to $V'$ over the field $F$
is represented by $upright("Hom")(V, V')$ or $upright("L")(V, V')$.
Furthermore, when considering the set of all linear transformations,
it is commonly denoted by $upright("Hom")(V)$, $upright("L")(V)$, or $upright("End")(V)$.

The rank of a matrix $A$ is denoted by $upright("rank")(A)$ or $r(A)$.
Two square matrices $A$ and $B$ are called *similar*, denoted $A ~ B$,
if there exists an invertible matrix $P$ such that $B = P^(-1) A P$.
The characteristic polynomial of $A$ is $f(lambda) = |lambda E - A|$,
and the minimal polynomial is the monic polynomial $m(lambda)$ of least degree
such that $m(A) = 0$.

= Determinants // 行列式

行列式是方阵的一个标量值，既是矩阵可逆性的判据，也是 Cramer 法则和特征值理论的基础。
本章从排列的逆序数出发定义行列式，逐步建立其性质、展开法则与特殊行列式的计算。

== Permutations // 排列

#definition(name: "Permutations of Order $n$")[
  A *permutation of order* $n$ is a bijection $sigma: {1, 2, ..., n} -> {1, 2, ..., n}$.
  The set of all permutations of order $n$ is denoted by $S_n$.
] <def:permutation>

#definition(name: "Inversion Number")[
  An *inversion* of a permutation $sigma$ is an ordered pair $(i, j)$ satisfying
  $1 <= i < j <= n$ and $sigma(i) > sigma(j)$. The number of inversions of $sigma$,
  denoted $tau(sigma)$, is called the *inversion number*.
] <def:inversion-number>

#definition(name: "Parity and Sign of a Permutation")[
  The permutation $sigma$ is called *even* if $tau(sigma)$ is even, and *odd* otherwise.
  Its *sign* (Leibniz symbol) is $"sgn"(sigma) = (-1)^(tau(sigma))$, which is $1$ for
  even permutations and $-1$ for odd ones.
] <def:sign-of-permutation>

#property(name: "Properties of Parity")[
  Let $sigma$ and $tau$ be permutations of order $n$.
  - *Transposition*: swapping two elements of a permutation changes its parity.
  - *Identity*: the identity permutation is even.
  - *Composition*: $"sgn"(sigma tau) = "sgn"(sigma) "sgn"(tau)$; in particular $"sgn"(sigma) = "sgn"(sigma^(-1))$.
  - *Decomposition*: every permutation is a product of transpositions, and its parity agrees with
    the parity of the number of transpositions used.
] <prop:parity-properties>

== Determinant and Its Properties // 行列式及其性质

#definition(name: "Determinant of Order $n$")[
  Let $A = (a_("ij"))$ be an $n times n$ matrix over the number field $P$.
  The *determinant* of $A$ is the scalar

  $
  abs(A) = sum_(sigma in S_n) "sgn"(sigma) product_(i=1)^n a_(i, sigma(i)).
  $
] <def:determinant>

#property(name: "Basic Properties of Determinants")[
  Let $A$ be an $n times n$ matrix.
  - *Transpose*: $abs(A^T) = abs(A)$.
  - *Row exchange*: interchanging two rows (or two columns) of $A$ changes the sign of $abs(A)$.
  - *Scalar multiplication*: multiplying one row of $A$ by a scalar $k$ multiplies $abs(A)$ by $k$.
  - *Row addition*: adding a scalar multiple of one row to another row leaves $abs(A)$ unchanged.
  - *Proportional rows*: if two rows (or two columns) of $A$ are proportional, then $abs(A) = 0$.
] <prop:determinant-properties>

#theorem(name: "Multiplicativity of Determinants")[
  If $A$ and $B$ are $n times n$ matrices over $P$, then

  $
  abs(A B) = abs(A) abs(B).
  $
] <thm:det-product>

#proof[
  Every elementary matrix $E$ satisfies $abs(E A) = abs(E) abs(A)$: this is immediate for
  the three types of elementary row operations, with $abs(E) = -1$, $k$, and $1$, respectively.
  If $A$ is invertible, then $A$ is a product of elementary matrices, and applying the previous
  step to $A = E_1 ... E_k$ against $I$ gives $abs(A) = abs(E_1) ... abs(E_k)$.
  Hence, for invertible $A$ and $B$, writing $B = F_1 ... F_m$ as a product of elementary
  matrices yields $abs(A B) = abs(A) abs(F_1) ... abs(F_m) = abs(A) abs(B)$.
  If one of $A$ and $B$ is singular, then $A B$ is singular as well, so both sides are zero.
]

#corollary(name: "Determinant and Invertibility")[
  An $n times n$ matrix $A$ is invertible if and only if $abs(A) != 0$.
] <cor:determinant-invertibility>

== Expanding by Rows and Columns // 按行（列）展开

#definition(name: "Minors and Cofactors")[
  The *minor* $M_("ij")$ of $A$ is the determinant of the $(n-1) times (n-1)$ matrix obtained
  from $A$ by deleting row $i$ and column $j$. The *cofactor* of entry $a_("ij")$ is
  $A_("ij") = (-1)^(i + j) M_("ij")$.
] <def:minor-and-cofactor>

#theorem(name: "Laplace Expansion Theorem")[
  For every row $i$ and every column $j$ of $A$,

  $
  abs(A) = sum_(j=1)^n a_("ij") A_("ij"),
  $

  $
  abs(A) = sum_(i=1)^n a_("ij") A_("ij").
  $
] <thm:laplace-expansion>

#proof[
  We prove the expansion along row $i$; the column version follows from $abs(A^T) = abs(A)$.
  Grouping the Leibniz terms by $j = sigma(i)$ gives

  $
  abs(A) = sum_(j=1)^n a_("ij") sum_(sigma(i) = j) "sgn"(sigma) product_(k != i) a_(k, sigma(k)).
  $

  For a permutation $sigma$ with $sigma(i) = j$, removing the pair $(i, j)$ leaves a
  permutation $tau$ of the remaining indices, and $"sgn"(sigma) = (-1)^(i+j) "sgn"(tau)$.
  The inner sum therefore equals $(-1)^(i+j) M_("ij") = A_("ij")$.
]

=== Cramer's Rule // 克拉默法则

#theorem(name: "Cramer's Rule")[
  Let $A x = b$ be a linear system of $n$ equations in $n$ unknowns with $abs(A) != 0$,
  and let $A_(j)$ denote the matrix obtained from $A$ by replacing column $j$ with $b$.
  Then the unique solution is

  $
  x_j = abs(A_(j)) / abs(A), j = 1, 2, ..., n.
  $
] <thm:cramer-rule>

#proof[
  Since $b = sum_(k=1)^n x_k "col"_(k)(A)$, column $j$ of $A_(j)$ is $sum_(k=1)^n x_k "col"_(k)(A)$
  while the other columns coincide with those of $A$. Expanding $abs(A_(j))$ along column $j$
  and using the linearity of the determinant in that column,

  $
  abs(A_(j)) = sum_(k=1)^n x_k abs(A_(j, k)),
  $

  where $A_(j, k)$ is $A$ with column $j$ replaced by column $k$. For $k != j$ the matrix
  $A_(j, k)$ has two identical columns, hence determinant zero; for $k = j$ it is $A$.
  Thus $abs(A_(j)) = x_j abs(A)$.
]

=== Expanding by k Rows // 按 k 行展开

#property(name: "Laplace Expansion by k Rows")[
  Fix $k$ rows with indices $I = {i_1 < i_2 < ... < i_k}$. For a $k$-element subset
  $J = {j_1 < ... < j_k}$ of columns, write $M(I, J)$ for the $k$-th order minor on rows $I$
  and columns $J$, and $M^*(I, J)$ for the complementary minor on the remaining rows and columns.
  Then

  $
  abs(A) = sum_J (-1)^(i_1 + ... + i_k + j_1 + ... + j_k) M(I, J) M^*(I, J),
  $

  where the sum runs over all $k$-element subsets $J$ of ${1, 2, ..., n}$.
] <prop:laplace-expansion-by-k-rows>

== Special Determinants // 特殊行列式

#definition(name: "Vandermonde Determinant")[
  The *Vandermonde determinant* of order $n$ is defined as

  $
  V_(n) = abs(
    mat(
      (1, 1, 1, dots, 1),
      (x_1, x_2, x_3, dots, x_n),
      (x_1^2, x_2^2, x_3^2, dots, x_n^2),
      (dots.v, dots.v, dots.v, dots.down, dots.v),
      (x_1^(n-1), x_2^(n-1), x_3^(n-1), dots, x_n^(n-1)),
    )
  ),
  $

  where $x_1, x_2, ..., x_n$ are distinct variables.
] <def:vandermonde-determinant>

The value of the Vandermonde determinant is given by

$
V_(n) = product_(1 <= i < j <= n) (x_j - x_i).
$

#definition(name: "Arrow Determinant")[
  The *Arrow determinant* is defined as

  $
  A_(n) = abs(
    mat(
      (a_(11), a_(12), a_(13), dots, a_(1n)),
      (a_(21), a_(22), 0, dots, 0),
      (a_(31), 0, a_(33), dots, 0),
      (dots.v, dots.v, dots.v, dots.down, dots.v),
      (a_("n1"), 0, 0, dots, a_("nn")),
    )
  ).
  $

  Its value is given by

  $
  A_(n) = (a_(11) - sum_(k=2)^n (a_("1k") a_("k1"))/a_("kk")) product_(k=2)^n a_("kk").
  $
] <def:arrow-determinant>

From the first column sequentially, subtract $a_(21)/a_(22)$ times the second column, ...,
$a_("n1")/a_("nn")$ times the $n$-th column, so that the first column becomes

$
(a_(11) - sum_(k=2)^n (a_("1k") a_("k1"))/a_("kk"), 0, 0, dots, 0)^T.
$

Then expand along the first column.

#definition(name: "Two-Triangular Determinant")[
  If the entries of a determinant satisfy

  $
  a_("ij") = cases(a, i < j, x_i, i = j, b, i > j),
  $

  then $D_n$ is called a *two-triangular determinant*.
] <def:two-triangular-determinant>

The value of the two-triangular determinant is given by

$
abs(
  mat(
    (x_1, a, a, dots, a),
    (b, x_2, a, dots, a),
    (b, b, x_3, dots, a),
    (dots.v, dots.v, dots.v, dots.down, dots.v),
    (b, b, b, dots, x_n),
  )
)
=
cases(
  (x_1 + a sum_(k=2)^n (x_1 - a)/(x_k - a)) dot product_(k=2)^n (x_k - a), a = b,
  (x_n - b) D_(n-1) + product_(k=1)^(n-1) (x_k - a), a != b,
).
$

= Matrices // 矩阵

矩阵是线性映射的坐标表示，也是线性方程组的系数载体。
本章涵盖矩阵的基本运算、特殊方阵的性质、逆矩阵的求法、分块矩阵技巧以及秩的运算性质。

== Basic Operations // 基本运算

=== Addition // 加法

Two $m times n$ matrices $A = (a_("ij"))$ and $B = (b_("ij"))$ over $P$ can be added entry-wise: $A + B = (a_("ij") + b_("ij"))$, which is again an $m times n$ matrix.

=== Scalar Multiplication // 数乘

The *scalar product* of $A$ by a scalar $k$ in $P$ is $k A = (k a_("ij"))$, again an $m times n$ matrix.

=== Transpose // 转置

The *transpose* of an $m times n$ matrix $A = (a_("ij"))$ is the $n times m$ matrix $A^T = (a_("ji"))$, obtained by swapping rows and columns.

=== Matrix Multiplication // 矩阵乘法

The *product* of an $m times n$ matrix $A$ and an $n times p$ matrix $B$ is the $m times p$ matrix $A B = (c_("ij"))$ with

$
c_("ij") = sum_(k=1)^n a_("ik") b_("kj").
$

=== Determinants of Products // 行列式乘积公式

The determinant of a product equals the product of the determinants — see #link(<thm:det-product>)[Theorem]. By induction it extends to any number of matrices:

#corollary(name: "Product Formula for k Matrices")[
  For $n times n$ matrices $A_1, ..., A_k$ over $P$,

  $
  abs(A_1 ... A_k) = product_(i=1)^k abs(A_i).
  $
] <cor:det-product-multiple>

#theorem(name: "Cauchy-Binet Formula")[
  Let $A$ be an $m times n$ matrix and $B$ an $n times m$ matrix.
  - If $m > n$, then $abs(A B) = 0$.
  - If $m <= n$, then

  $
  abs(A B) = sum_(1 <= v_1 < ... < v_m <= n)
  abs(A(1, 2, ..., m; v_1, ..., v_m)) abs(B(v_1, ..., v_m; 1, 2, ..., m)),
  $

  where the sum runs over all strictly increasing index tuples, and $A(1, 2, ..., m; v_1, ..., v_m)$ denotes the minor of $A$ on rows $1, ..., m$ and columns $v_1, ..., v_m$.
] <thm:cauchy-binet-formula>

=== Matrix Equivalence // 矩阵等价

#definition(name: "Matrix Equivalence")[
  Two matrices $A$ and $B$ of the same size are called *equivalent*, denoted $A equiv B$,
  if they can be transformed into one another by a combination of elementary row and column
  operations.
] <def:matrix-equivalence>

#note[
  Two matrices are equivalent if and only if they have the same rank.
]

#definition(name: "Canonical Form of Matrix Equivalence")[
  Any $m times n$ matrix $A$ of rank $r$ is equivalent to the matrix

  $
  J_r = mat((I_r, O), (O, O)),
  $

  which is called the *canonical form* of matrix equivalence.
] <def:canonical-form-of-equivalence>

== Special Square Matrices // 特殊方阵

=== Diagonal Matrix // 对角矩阵

#definition(name: "Diagonal and Skew-Diagonal Matrices")[
  An $n times n$ matrix $A = (a_("ij"))$ is called a *diagonal matrix* if $a_("ij") = 0$
  for $i != j$, denoted

  $
  A = upright("diag")(a_(11), a_(22), ..., a_("nn")).
  $

  If $a_(i, n+1-i) = 0$ for all $i = 1, ..., n$, then $A$ is called a *skew-diagonal matrix*,
  denoted

  $
  A = upright("sdiag")(a_(1n), a_("2, n-1"), ..., a_("n1")).
  $
] <def:diagonal-matrix>

#property(name: "Properties of Diagonal Matrices")[
  - The sum, difference and product of two diagonal matrices of the same order are still diagonal.
  - Multiplying $A$ on the left (right) by a diagonal matrix multiplies the corresponding
    rows (columns) of $A$ by the diagonal entries.
  - $upright("diag")(a_1, ..., a_n)^(-1) = upright("diag")(1/a_1, ..., 1/a_n)$;
  - $upright("sdiag")(a_1, ..., a_n)^(-1) = upright("sdiag")(1/a_n, ..., 1/a_1)$;
  - $mat((A, O), (O, C))^(-1) = mat((A^(-1), O), (O, C^(-1)))$;
  - $mat((O, B), (D, O))^(-1) = mat((O, D^(-1)), (B^(-1), O))$.
] <prop:diagonal-matrix>

=== Fundamental Matrix // 基本矩阵

#definition(name: "Fundamental Matrix")[
  $E_("ij")$ is called a *fundamental matrix* if its entry in row $i$ and column $j$ is $1$
  and all other entries are $0$.
] <def:fundamental-matrix>

#property(name: "Properties of Fundamental Matrices")[
  - Multiplying $A$ on the left by $E_("ij")$ moves row $j$ of $A$ to row $i$, with all other
    entries zero; multiplying $A$ on the right by $E_("ij")$ moves column $i$ of $A$ to column
    $j$, with all other entries zero.
  - If $A$ commutes with all fundamental matrices, then $A$ is a scalar matrix.
] <prop:fundamental-matrix>

#note[
  The mnemonic is: *moves row*: $E_(i <- j) A$; *moves column*: $A E_(i -> j)$.
]

=== Triangular Matrix // 三角矩阵

#definition(name: "Upper and Lower Triangular Matrices")[
  An $n times n$ matrix $A = (a_("ij"))$ is called an *upper triangular matrix* if
  $a_("ij") = 0$ for $i > j$:

  $
  A = mat(
    (a_(11), a_(12), ..., a_(1n)),
    (0, a_(22), ..., a_(2n)),
    (dots.v, dots.v, dots.down, dots.v),
    (0, 0, ..., a_("nn")),
  )
  $

  Similarly, if $a_("ij") = 0$ for $i < j$, then $A$ is called a *lower triangular matrix*:

  $
  A = mat(
    (a_(11), 0, ..., 0),
    (a_(21), a_(22), ..., 0),
    (dots.v, dots.v, dots.down, dots.v),
    (a_("n1"), a_("n2"), ..., a_("nn")),
  )
  $
] <def:triangular-matrix>

#property(name: "Properties of Triangular Matrices")[
  - The sum, difference and product of two upper (lower) triangular matrices of the same order
    are still upper (lower) triangular.
  - Every square matrix $A$ can be expressed as the sum of an upper triangular matrix and a
    lower triangular matrix:
    $A = (A + A^T)/2 + (A - A^T)/2$.
  - *($"LU"$ Decomposition)* If all leading principal minors of a square matrix $A$ are non-zero,
    then $A$ can be uniquely decomposed as $A = L U$, where $L$ is a lower triangular matrix
    with all diagonal entries equal to $1$ and $U$ is an invertible upper triangular matrix.
    The converse is also true.
] <prop:triangular-matrix>

=== Elementary Matrix // 初等矩阵

#definition(name: "Elementary Matrix")[
  An *elementary matrix* is obtained by performing a single elementary row operation on the
  identity matrix $E$. There are three types (the same holds for column operations):
  - *Row swapping* $P(i, j)$: interchanges rows $i$ and $j$ of $E$.
  - *Row scaling* $P(i(c))$: multiplies row $i$ of $E$ by a non-zero scalar $c$.
  - *Row addition* $P(i, j(k))$: adds $k$ times row $j$ to row $i$ of $E$.
] <def:elementary-matrix>

#note[
  It can be proven that $P(i, j)$ can be implemented by a sequence of $P(i(c))$ and
  $P(i, j(k))$ operations.
]

=== Symmetric Matrix // 对称矩阵

#definition(name: "Symmetric and Skew-Symmetric Matrices")[
  An $n times n$ matrix $A = (a_("ij"))$ is called a *symmetric matrix* if
  $a_("ij") = a_("ji")$ for all $i, j = 1, ..., n$, or equivalently $A = A^T$.
  Similarly, if $A = -A^T$, then $A$ is called a *skew-symmetric matrix*.
] <def:symmetric-matrix>

#property(name: "Properties of Symmetric Matrices")[
  - The linear combination of two symmetric (skew-symmetric) matrices of the same order is
    still a symmetric (skew-symmetric) matrix.
  - Every square matrix $A$ can be expressed as the sum of a symmetric matrix and a
    skew-symmetric matrix: $A = (A + A^T)/2 + (A - A^T)/2$.
  - The determinant of an odd-order skew-symmetric matrix is zero; the rank of a
    skew-symmetric matrix is even.
] <prop:symmetric-matrix>

=== Circulant Matrix // 循环矩阵

Let

$
C = mat(
  (0, 1, 0, 0, ..., 0),
  (0, 0, 1, 0, ..., 0),
  (dots.v, dots.v, dots.v, dots.v, dots.down, dots.v),
  (0, 0, 0, 0, ..., 1),
  (1, 0, 0, 0, ..., 0),
)
$,

which is called a *cyclic shift matrix*.

The matrix $C$ performs specific cyclic operations when multiplied by another matrix:

- *Left multiplication*: $C A$ cyclically shifts the rows of $A$ upwards by one position;
  the first row of $A$ moves to the last row.
- *Right multiplication*: $A C$ cyclically shifts the columns of $A$ to the right by one
  position; the last column of $A$ moves to the first column.

#definition(name: "Circulant Matrix")[
  A matrix $A$ is called a *circulant matrix* if it can be expressed as

  $
  A = mat(
    (a_0, a_1, a_2, ..., a_(n-1)),
    (a_(n-1), a_0, a_1, ..., a_(n-2)),
    (a_(n-2), a_(n-1), a_0, ..., a_(n-3)),
    (dots.v, dots.v, dots.v, dots.down, dots.v),
    (a_1, a_2, a_3, ..., a_0),
  ),
  $

  where each row is obtained by cyclically shifting the elements of the first row one position
  to the right. It can also be expressed as

  $
  A = a_0 E + a_1 C + ... + a_(n-1) C^(n-1) = sum_(i=0)^(n-1) a_i C^i,
  $

  where $E$ is the identity matrix and $C$ is the cyclic shift matrix.
] <def:circulant-matrix>

=== Nilpotent Matrix // 幂零矩阵

#definition(name: "Nilpotent Matrix")[
  A square matrix $A$ is called a *nilpotent matrix* if there exists $l in bb(N)^(+)$ such
  that $A^l = O$, where $O$ is the zero matrix. The smallest such $l$ is called the *nilpotent
  index* of $A$.
] <def:nilpotent-matrix>

#proposition(name: "Nilpotency of Triangular Matrices")[
  - A triangular matrix is nilpotent if and only if all its diagonal entries are zero.
  - If an $n$-order triangular matrix is nilpotent, then its nilpotent index $l$ must satisfy
    $l <= n$.
] <prop:nilpotent-triangular-matrix>

Some special nilpotent matrices:

$
A_n = mat(
  (0, 1, 0, ..., 0),
  (0, 0, 1, ..., 0),
  (dots.v, dots.v, dots.v, dots.down, dots.v),
  (0, 0, 0, ..., 1),
  (0, 0, 0, ..., 0),
)
$

is a nilpotent matrix with nilpotent index $n$.

=== Full Row Rank Matrix // 满秩矩阵

#definition(name: "Full Row Rank and Full Column Rank Matrices")[
  A matrix $A$ is called a *full row rank matrix* if its row vectors are linearly independent.
  Similarly, if its column vectors are linearly independent, then $A$ is called a *full column
  rank matrix*.
] <def:full-row-rank-matrix>

#property(name: "Properties of Full Row Rank Matrices")[
  - An $A_{m times n}$ is a full row rank matrix if and only if there exists an invertible
    matrix $Q_{n times n}$ such that $A = mat((E_m, O)) Q$.
  - An $A_{m times n}$ is a full column rank matrix if and only if there exists an invertible
    matrix $P_{m times m}$ such that $A = P mat((E_n), (O))$.
] <prop:full-row-rank-matrix>

== Inverse Matrix // 逆矩阵

=== Inverse Matrix and Its Operations // 逆矩阵及其运算

#definition(name: "Inverse Matrix")[
  Let $A$ be an $n times n$ matrix over $P$. If there exists an $n times n$ matrix $B$ such
  that $A B = B A = E$, then $A$ is called *invertible* (or *non-singular*), and $B$ is called
  the *inverse matrix* of $A$, denoted $A^(-1)$. A matrix that is not invertible is called
  *singular*.
] <def:inverse-matrix>

#property(name: "Operations of Inverse Matrices")[
  - $(A^(-1))^(-1) = A$.
  - $(lambda A)^(-1) = (1/lambda) A^(-1)$ for a non-zero scalar $lambda$ in $P$.
  - $(A^T)^(-1) = (A^(-1))^T$.
  - $(A B)^(-1) = B^(-1) A^(-1)$, and more generally $(A_1 ... A_k)^(-1) = A_k^(-1) ... A_1^(-1)$.
] <prop:operations-of-inverse>

=== Equivalent Propositions and Method of Inversion // 等价命题与求逆方法

#theorem(name: "Equivalent Propositions of Invertibility")[
  For an $n times n$ matrix $A$ over $P$, the following statements are equivalent:
  - $A$ is invertible;
  - $A$ is equivalent to the identity matrix $E$;
  - $A$ is a product of elementary matrices;
  - the homogeneous system $A x = 0$ has only the zero solution;
  - the row vectors (and the column vectors) of $A$ are linearly independent.
] <thm:invertibility-equivalent-propositions>

#proof[
  If $A$ is invertible, then $abs(A) != 0$ by #link(<cor:determinant-invertibility>)[Corollary],
  so row reduction of $A$ ends at $E$ rather than at a singular matrix; hence $A$ is equivalent
  to $E$, and $A = E_1 ... E_k$ is the product of the corresponding elementary matrices.
  Conversely, every elementary matrix is invertible, so a product of elementary matrices is
  invertible, and if $A equiv E$ then $A = P E Q$ with $P$ and $Q$ products of elementary
  matrices, hence $A$ is invertible.
  Finally, $A x = 0$ has only the zero solution iff the columns of $A$ are linearly independent
  iff $abs(A) != 0$, which is equivalent to invertibility by
  #link(<cor:determinant-invertibility>)[Corollary].
]

#definition(name: "Adjugate Matrix")[
  Let $A$ be an $n times n$ matrix with cofactors $A_("ij")$. The *adjugate* of $A$ is the
  matrix $"adj"(A) = (A_("ji"))$, the transpose of the cofactor matrix.
] <def:adjugate-matrix>

#theorem(name: "Inverse via Adjugate")[
  For an invertible $n times n$ matrix $A$,

  $
  A "adj"(A) = "adj"(A) A = abs(A) E,
  $

  and therefore

  $
  A^(-1) = "adj"(A) / abs(A).
  $
] <thm:inverse-via-adjugate>

#proof[
  The $(i, j)$-entry of $A "adj"(A)$ is $sum_(k=1)^n a_("ik") A_("jk")$: it equals $abs(A)$
  when $i = j$ by the Laplace expansion, and $0$ when $i != j$, since it is the expansion of a
  determinant whose $j$-th row has been replaced by the $i$-th row, hence has two equal rows.
]

#property(name: "Methods of Finding the Inverse")[
  - *Adjugate method*: $A^(-1) = "adj"(A) / abs(A)$, given by #link(<thm:inverse-via-adjugate>)[Theorem].
  - *Elementary row operation method*: apply the same elementary row operations to the augmented
    matrix $mat((A, E))$ until the left half becomes $E$; the right half is then $A^(-1)$. If
    $A$ cannot be reduced to $E$, then $A$ is singular.
]

=== Generalized Inverse // 广义逆

#definition(name: "Generalized Inverse")[
  Let $A$ be an $m times n$ matrix. An $n times m$ matrix $X$ satisfying $A X A = A$ is called
  a *generalized inverse* of $A$.
] <def:generalized-inverse>

#note[
  The generalized inverse reduces to the usual inverse when $A$ is invertible. Among all
  generalized inverses, the Moore-Penrose inverse is the uniquely defined one satisfying
  additional symmetry conditions.
]

== Block Matrix // 分块矩阵

=== Kronecker Product // Kronecker 积

#definition(name: "Kronecker Product")[
  Let $A = (a_("ij"))$ be an $m times n$ matrix and $B = (b_("ij"))$ a $p times q$ matrix.
  The *Kronecker product* of $A$ and $B$, denoted $A ⊗ B$, is the block matrix

  $
  A ⊗ B = mat(
    (a_(11) B, a_(12) B, ..., a_(1n) B),
    (a_(21) B, a_(22) B, ..., a_(2n) B),
    (dots.v, dots.v, dots.down, dots.v),
    (a_("m1") B, a_("m2") B, ..., a_("mn") B),
  )
  $

  of size $m p times n q$.
] <def:kronecker-product>

=== Determinant Reduction Formula // 行列式降阶公式

#theorem(name: "Determinant Reduction Formula")[
  Let $A$ be $m times m$, $B$ be $m times n$, $C$ be $n times m$, and $D$ be $n times n$.
  Then:
  - If $A$ is invertible, then

    $
    abs(mat((A, B), (C, D))) = abs(A) abs(D - C A^(-1) B).
    $

  - If $D$ is invertible, then

    $
    abs(mat((A, B), (C, D))) = abs(D) abs(A - B D^(-1) C).
    $

  - If both $A$ and $D$ are invertible, then

    $
    abs(D) abs(A - B D^(-1) C) = abs(A) abs(D - C A^(-1) B).
    $
] <thm:determinant-reduction-formula>

#note[
  The mnemonic is: for $abs(mat((A, B), (C, D)))$, if $A$ is invertible, one factor is
  $abs(A)$ and the other factor is $D$ minus the product of the other three terms arranged
  *clockwise*, where the middle one is the inverse matrix.
]

== Operations of Rank // 秩的运算

#proposition(name: "Operations of Rank")[
  The matrices $A$ and $B$ below need not be square; they only need to be compatible for
  multiplication or addition.
  - *1. Addition*:

    $
    abs(upright("rank")(A) - upright("rank")(B)) <= upright("rank")(A + B) <=
    upright("rank")(A) + upright("rank")(B).
    $

    On the basis of the dimension formula,
    $upright("rank")(A + B) = upright("rank")(A) + upright("rank")(B) -
    "dim"(R(A) inter R(B))$, where $R(A)$ and $R(B)$ are the column spaces of $A$ and $B$.
  - *2. Multiplication*: $upright("rank")(A B) <= upright("rank")(A)$ and
    $upright("rank")(A B) <= upright("rank")(B)$.
  - *2.1 Sylvester's Inequality*: for $A_{s times n}$ and $B_{n times m}$,
    $upright("rank")(A B) >= upright("rank")(A) + upright("rank")(B) - n$.
    In particular, if $A B = O$, then $upright("rank")(A) + upright("rank")(B) <= n$.
  - *2.2 Frobenius Inequality*:
    $upright("rank")(A B C) >= upright("rank")(A B) + upright("rank")(B C) -
    upright("rank")(B)$.
  - *3. Transpose*:
    $upright("rank")(A A^T) = upright("rank")(A^T A) = upright("rank")(A) =
    upright("rank")(A^T)$.
  - *4. Inverse*: if $A$ is invertible, then $upright("rank")(A) = upright("rank")(A^(-1)) = n$.
  - *5. Block Matrix*:
    $upright("rank")(mat((A, O), (O, D))) = upright("rank")(A) + upright("rank")(D)$.
] <prop:operations-of-rank>

== Low-Rank Corrections // 低秩修正

Since all the row and column vectors of a rank-$1$ matrix are linearly dependent, it can be
expressed as the outer product of two non-zero vectors; in other words, a rank-$1$ matrix can
be written as $alpha beta^T$, where $alpha$ and $beta$ are non-zero column vectors.

Based on the decomposition $A = alpha beta^T$, the rank-$1$ matrix has the following simplified
calculation rules:

#property(name: "Calculation Rules for Rank-1 Matrices")[
  - *Exponentiation*: for any positive integer $k >= 1$,
    $A^k = (beta^T alpha)^(k-1) dot A$, where $beta^T alpha$ is a scalar (the inner product
    of the vectors).
  - *Rank Transmission*: if $B$ is any matrix, then $upright("rank")(A B) <= 1$ and
    $upright("rank")(B A) <= 1$; multiplying a rank-$1$ matrix by arbitrary matrices yields
    rank not exceeding $1$.
] <prop:rank-one-matrix>

#theorem(name: "Sherman-Morrison Formula")[
  If $A$ in $bb(R)^(n times n)$ is invertible and $alpha, beta$ in $bb(R)^n$ are column
  vectors, then $A + alpha beta^T$ is invertible if and only if $1 + beta^T A^(-1) alpha != 0$.
  In this case, the inverse of $A + alpha beta^T$ is

  $
  (A + alpha beta^T)^(-1) = A^(-1) -
  (A^(-1) alpha beta^T A^(-1)) / (1 + beta^T A^(-1) alpha).
  $

  Here $alpha beta^T$ is the outer product of $alpha$ and $beta$.
] <thm:sherman-morrison>

#note[
  Combining the properties of determinants, we obtain the determinant version of the
  Sherman-Morrison formula, known as the *matrix determinant lemma*:

  $
  abs(A + alpha beta^T) = abs(A) (1 + beta^T A^(-1) alpha).
  $

  The theorem can also be stated in terms of the adjugate of $A$ as

  $
  abs(A + u v^T) = abs(A) + v^T "adj"(A) u,
  $

  in which case it applies whether or not $A$ is invertible.
]

#theorem(name: "Woodbury Matrix Identity")[
  If $A$ in $bb(R)^(n times n)$ and $C$ in $bb(R)^(k times k)$ are invertible and
  $U, V$ in $bb(R)^(n times k)$, then $A + U C V^T$ is invertible if and only if
  $C^(-1) + V^T A^(-1) U$ is invertible. In this case, the inverse of $A + U C V^T$ is

  $
  (A + U C V^T)^(-1) = A^(-1) - A^(-1) U (C^(-1) + V^T A^(-1) U)^(-1) V^T A^(-1).
  $
] <thm:woodbury-identity>

Without loss of generality, let $A = E_n$ and $C = E_k$. Then the Woodbury identity simplifies
to

$
(E_n + U V^T)^(-1) = E_n - U (E_k + V^T U)^(-1) V^T.
$

This form is particularly useful in applications involving low-rank updates to identity matrices.

= Linear Systems // 线性方程组

线性方程组是线性代数最直接的应用对象。
本章用矩阵的初等变换和秩理论刻画线性方程组解的存在性与结构。

== Elimination Method // 消元法

#definition(name: "System of Linear Equations")[
  A *system of linear equations* is a collection of one or more linear equations involving the
  same set of variables. For example, a system of $m$ linear equations in $n$ variables can be
  written as

  $
  cases(
    a_(11) x_1 + a_(12) x_2 + ... + a_(1n) x_n = b_1,
    a_(21) x_1 + a_(22) x_2 + ... + a_(2n) x_n = b_2,
    dots.v,
    a_("m1") x_1 + a_("m2") x_2 + ... + a_("mn") x_n = b_m,
  )
  $

  where $x_1, ..., x_n$ are the variables, $a_("ij")$ are the coefficients, and $b_i$ are the
  constants. A *solution* is an ordered set of values for the variables satisfying all equations
  simultaneously; two systems with the same solution set are called *equivalent systems*.
] <def:system-of-linear-equations>

A linear system can be solved by *elimination*: applying elementary row operations to the
augmented matrix of the system, so that the coefficient part becomes triangular, and then
solving by back-substitution. *Gauss-Jordan elimination* continues until the reduced row
echelon form is reached.

#definition(name: "Row Echelon Form")[
  A matrix is in *row echelon form* if every zero row lies below all non-zero rows and the
  leading entry of each non-zero row lies to the right of that of the row above. It is in
  *reduced row echelon form* if, in addition, every leading entry is $1$ and the only non-zero
  entry in its column.
] <def:row-echelon-form>

#theorem(name: "Uniqueness of Reduced Row Echelon Form")[
  Every matrix is row-equivalent to a unique matrix in reduced row echelon form.
] <thm:uniqueness-of-rref>

#proof[
  The row operations preserve the solution set of every linear system, and the reduction to
  reduced row echelon form is a deterministic procedure: the pivot positions are fixed by the
  row space of the matrix, each pivot is normalized to $1$, and the entries above it are
  eliminated. Hence the result is unique.
]

== Rank of Vector Groups and Matrices // 向量组与矩阵的秩

#note[
  The notions of linear combination, linear representation and linear (in)dependence used in
  this section are defined in Chapter 5 (Linear Spaces).
]

=== Maximal Independent Group // 极大线性无关组

#definition(name: "Maximal Linearly Independent Group")[
  A subset of a vector group is called a *maximal linearly independent group* if it is linearly
  independent and adding any vector of the vector group makes the enlarged subset linearly
  dependent.
] <def:maximal-independent-group>

#property(name: "Properties of Maximal Independent Groups")[
  - The maximal linearly independent group is not unique; any maximal linearly independent group
    is equivalent to the original vector group.
  - All maximal linearly independent groups of a vector group contain the same number of vectors.
]

#definition(name: "Rank of Vector Groups")[
  The number of vectors contained in a maximal linearly independent group of a vector group is
  called the *rank* of the vector group.
] <def:rank-of-vector-groups>

#property(name: "Properties of the Rank of Vector Groups")[
  - A vector group is linearly independent if and only if its rank equals the number of vectors
    it contains.
  - Equivalent vector groups have the same rank, but vector groups with the same rank are not
    necessarily equivalent.
  - If the rank of a vector group is $r$, then any $r$ linearly independent vectors of the group
    form a maximal linearly independent group.
  - A vector group of non-zero vectors always has a maximal linearly independent group, and any
    linearly independent subset can be extended to one.
  - If vector group (I) can be linearly expressed by vector group (II), then the rank of (I)
    does not exceed the rank of (II).
]

=== Rank of Matrices // 矩阵的秩

#definition(name: "Rank of Matrices")[
  The *row rank* of a matrix is the rank of its row vectors; the *column rank* is the rank of
  its column vectors. The *rank* of a matrix is defined as the highest order of its non-zero
  minors.
] <def:rank-of-matrices>

#theorem(name: "Row Rank Equals Column Rank")[
  The row rank and the column rank of any matrix are equal.
] <thm:row-rank-equals-column-rank>

#property(name: "Properties of Matrix Rank")[
  - Elementary row and column transformations do not change the rank of a matrix.
  - The rank of a matrix equals the number of non-zero rows in its row (column) echelon form.
  - Elementary row (column) operations do not alter the linear relations among the column (row)
    vectors.
  - For a square matrix $(a_("ij"))$ of order $n$, its row vectors (or column vectors) are
    linearly independent if and only if $abs(A) != 0$.
]

The third property gives a method for finding a maximal linearly independent group of the row
(or column) vectors of a matrix; take the column vectors as an example:

1. Transform the matrix into its row echelon form (REF) or reduced row echelon form (RREF)
   using elementary row operations. For example, for the matrix $(alpha_1, alpha_2, alpha_3,
   alpha_4, alpha_5)$, its REF is shown below:

   $
   mat(
     (a_(11), a_(12), 0, 0, 0),
     (0, 0, a_(23), 0, 0),
     (0, 0, 0, 0, a_(35)),
   )
   $

2. Identify the leading entries (pivots) of the rows. The columns containing these pivots
   correspond to a maximal linearly independent group of the column vectors. In the example,
   $alpha_1, alpha_3, alpha_5$ form a maximal linearly independent group.

== Solution to Linear Systems // 线性方程组的解

=== Existence of Solutions // 解的存在性判定

#theorem(name: "Existence of Solutions")[
  A linear system $A x = b$ is solvable if and only if the rank of the coefficient matrix $A$
  equals the rank of the augmented matrix $(A | b)$. If both ranks equal $r$, then the system
  has a unique solution when $r = n$, and infinitely many solutions with $n - r$ free variables
  when $r < n$.
] <thm:existence-of-solutions>

=== Homogeneous Systems // 齐次方程组

For a homogeneous system of linear equations, it is evident that the linear combination of
solutions is still a solution to the system. Thus the concept of a *fundamental system of
solutions* is introduced.

#definition(name: "Fundamental System of Solutions")[
  For the homogeneous system $A x = O$, that is

  $
  cases(
    a_(11) x_1 + a_(12) x_2 + ... + a_(1n) x_n = 0,
    a_(21) x_1 + a_(22) x_2 + ... + a_(2n) x_n = 0,
    dots.v,
    a_("s1") x_1 + a_("s2") x_2 + ... + a_("sn") x_n = 0,
  )
  $

  a set of solutions $eta_1, ..., eta_t$ is called a *fundamental system of solutions* if:
  - any solution of the system can be expressed as a linear combination of
    $eta_1, ..., eta_t$;
  - $eta_1, ..., eta_t$ are linearly independent.
] <def:fundamental-system-of-solutions>

#note[
  This definition mirrors that of the maximal linearly independent group of a vector group: the
  fundamental solution set is a maximal linearly independent group of the solution vector group,
  so the number of solutions it contains equals the rank of that group.
]

All solutions of the homogeneous system $A x = O$ form a linear space, called the *solution
space*, whose basis is any fundamental system of solutions. The dimension of the solution space
is $n - upright("rank")(A)$, where $n$ is the number of variables. Thus a fundamental system of
solutions contains exactly $n - upright("rank")(A)$ solutions.

=== Nonhomogeneous Systems // 非齐次方程组

The homogeneous system $A x = O$ is called the *derived system* of the nonhomogeneous system
$A x = b$.

#property(name: "Structure of Solutions")[
  - The difference between two solutions of $A x = b$ is a solution of its derived system
    $A x = O$.
  - The sum of a solution of $A x = b$ and a solution of $A x = O$ is still a solution of
    $A x = b$.
]

If $gamma_0$ is a particular solution of $A x = b$, then any solution $gamma$ of $A x = b$ can
be expressed as

$
gamma = gamma_0 + eta,
$

where $eta$ is a solution of $A x = O$. Thus, when $eta$ takes all the solutions of the derived
system, the above formula gives all the solutions of $A x = b$.

// ==========================================================================
// Part II — Linear Spaces and Linear Mappings (线性空间与线性映射)
// ==========================================================================
// 设计思路：本 Part 从具体计算上升到抽象结构——线性空间定义了向量及其运算的公理框架，
// 线性映射刻画了空间之间的结构保持关系，矩阵表示建立了"空间↔矩阵"的桥梁。
// 对应教材：丘维声 §4–5、谢启鸿 §4–5、王萼芳 §4–5。

#part("Linear Spaces and Linear Mappings") // 线性空间与线性映射

= Linear Spaces // 线性空间

线性空间是线性代数的抽象基础——将所有具有加法和数乘结构的集合统一到一个公理框架下。
本章建立线性空间的定义、基与维数理论，并讨论子空间的结构性质。

== Linear Spaces and Their Bases // 线性空间与基

// TODO: 线性空间定义与公理、线性组合与线性表示、线性相关与线性无关、极大无关组、
//       维数、基与坐标、Steinitz 替换定理

== Subspaces // 子空间

// TODO: 子空间定义与判定、交与和、维数公式、直和（定义与充要条件）

== Isomorphisms // 同构

// TODO: 同构映射、同构定理、有限维空间的同构分类

== Quotient Spaces // 商空间

// TODO: 商空间定义、商空间的维数、线性映射的诱导映射

== Special Linear Spaces // 特殊线性空间

// TODO: 交换空间 C(A)、其他由矩阵方程定义的子空间

= Linear Mappings // 线性映射

线性映射是保持线性结构的空间之间的映射，是矩阵与空间之间的桥梁。
本章讨论线性映射的定义、运算、核与像、矩阵表示以及特殊线性变换。

== Linear Mappings and Their Computation // 线性映射及其运算

// TODO: 线性映射定义、存在唯一性定理（线性延拓）、加法与数乘、复合（线性变换的代数结构）、代数

== Kernel and Image of Linear Mappings // 线性映射的核与像

// TODO: 核与像、秩-零度定理、余核、升链

== Matrix Representation of Linear Mappings // 线性映射的矩阵表示

// TODO: 矩阵表示的定义、基变换与坐标变换、相似矩阵

== Special Linear Transformations // 特殊线性变换

// TODO: 常见线性变换、幂等变换与投影变换、对合变换、可逆变换的等价命题

== Linear Functions and Dual Spaces // 线性函数与对偶空间

// TODO: 线性函数、对偶空间、对偶基

// ==========================================================================
// Part III — Structure Theory of Linear Operators (线性算子的结构理论)
// ==========================================================================
// 设计思路：本 Part 研究线性算子的结构——通过相似变换寻找最简矩阵表示。
// 对角化是理想情形（矩阵相似于对角矩阵），Jordan 标准型是普适情形（任意矩阵相似于 Jordan 块直和）。
// 对应教材：丘维声 §6–7、谢启鸿 §6–7、王萼芳 §6–7。

#part("Structure Theory of Linear Operators") // 线性算子的结构理论

= Diagonalization // 对角化

对角化是线性算子结构理论的第一步——寻找一组基使线性算子的矩阵表示最简化。
本章讨论相似关系、特征值与特征向量、极小多项式、空间分解以及对角化的充要条件。

== Similarity of Matrices // 矩阵的相似

// TODO: 相似矩阵定义、相似不变量（行列式、秩、迹、特征多项式）、相似变换的应用

== Eigenvectors and Eigenvalues // 特征向量与特征值

// TODO: 特征值与特征向量定义、特征多项式、特征值的性质（和=迹、积=行列式）、
//       几何重数与代数重数、特征子空间、Gerschgorin 圆盘定理

== Minimal Polynomial // 极小多项式

// TODO: 零化多项式、极小多项式定义与性质、Cayley-Hamilton 定理

== Space Decomposition // 空间分解

// TODO: 不变子空间、块上三角与块对角、根子空间、根空间分解定理

== Diagonalization // 对角化

// TODO: 对角化的等价条件（n 个线性无关特征向量 / 几何重数=代数重数 / 直和分解 / 极小多项式无重根）

== Diagonalization of Special Matrices // 特殊矩阵的对角化

// TODO: 可逆矩阵、幂等矩阵、幂零矩阵、对合矩阵、全 1 矩阵、循环移位矩阵、循环矩阵、三角矩阵的对角化

== Simultaneous Characteristics Induced by Commutativity // 交换性诱导的同时性质

// TODO: 特征空间互为不变子空间、公共特征向量、同时上三角化、同时对角化

= Jordan Canonical Form // Jordan 标准型

Jordan 标准型是线性算子结构理论的普适结果——任意方阵相似于 Jordan 块的直和。
本章通过多项式矩阵的 Smith 标准型建立不变因子与初等因子理论，最终导出 Jordan 标准型的存在性与计算方法。

== Polynomial Matrices // 多项式矩阵

// TODO: 多项式矩阵定义、可逆性（行列式为非零常数）、Smith 标准型

== Invariant Divisors and Rational Canonical Form // 不变因子与有理标准型

// TODO: 行列式因子、不变因子、Frobenius 伴随矩阵、有理标准型（Frobenius 标准型）、循环子空间的几何解释

== Elementary Divisors and Jordan Canonical Form // 初等因子与 Jordan 标准型

// TODO: 初等因子定义、Jordan 块、Jordan 标准型存在性定理、几何解释

== Finding Jordan Canonical Form and Transition Matrices // Jordan 标准型与过渡矩阵的求法

// TODO: 求 Jordan 标准型的方法、求过渡矩阵的方法

== Complete Set of Invariant Quantities for Matrix Similarity // 矩阵相似的完全相似不变量

// TODO: 不变因子组 / 初等因子组作为相似关系的完全不变量

// ==========================================================================
// Part IV — Quadratic Forms and Inner Product Spaces (二次型与内积空间)
// ==========================================================================
// 设计思路：本 Part 将线性代数的结构理论推广到几何场景——二次型是多元函数泰勒展开的二次项，
// 内积空间为向量引入角度与长度概念。两者通过正交变换与合同变换相联系。
// 对应教材：丘维声 §8–9、谢启鸿 §8–9、王萼芳 §8–9。

#part("Quadratic Forms and Inner Product Spaces") // 二次型与内积空间

= Quadratic Forms // 二次型

二次型是多元函数的二次齐次多项式，在优化、几何和物理中有广泛应用。
本章讨论二次型的矩阵表示、合同变换下的标准形与规范形，以及正定二次型的判定。

== Quadratic Forms and Their Standard Forms // 二次型及其标准形

// TODO: 二次型定义、矩阵表示（对称矩阵）、合同变换、配方法、初等变换法

== Canonical Forms // 规范形

// TODO: 复二次型的规范形、实二次型的规范形（惯性定理）、惯性指数

== Definite Quadratic Forms // 正定二次型

// TODO: 正定/半正定/负定/不定二次型定义、正定的充要条件（特征值 / 合同于单位阵 / 顺序主子式 > 0）

= Inner Product Spaces // 内积空间

内积空间为向量引入了长度与角度概念，是 Euclidean 几何的代数推广。
本章涵盖双线性型、实内积空间、标准正交基、正交补与投影、正交变换与对称变换，以及酉空间与正规变换。

== Bilinear Forms // 双线性型

// TODO: 双线性型定义、双线性型的矩阵表示、对称双线性型与二次型的关系

== Real Inner Product Spaces // 实内积空间

// TODO: 内积定义与公理、范数、Cauchy-Schwarz 不等式、距离、角度、正交性、Euclidean 空间

== Metric Matrices and Orthonormal Bases // 度量矩阵与标准正交基

// TODO: Gram 矩阵、标准正交基、正交矩阵、Gram-Schmidt 正交化

== Orthogonal Completion and Orthogonal Projection // 正交补与正交投影

// TODO: 正交补定义与性质、最小二乘法、最佳逼近元、正交投影

== Orthogonal Transformations and Symmetric Transformations // 正交变换与对称变换

// TODO: 正交变换定义与性质、对称变换定义、对称变换的正交对角化

== Unitary Spaces and Normal Transformations // 酉空间与正规变换

// TODO: 复内积空间、酉矩阵、Hermitian 变换、正规变换与正规矩阵的对角化

== Symplectic Spaces // 辛空间

// TODO: 辛内积定义、辛空间的基本性质

// ==========================================================================
// Appendix (附录)
// ==========================================================================

#part("Appendix") // 附录

= Glossary // 术语表

// TODO: 迁移完成后用 violet-glossary-indexer 自动生成

#pagebreak()

#bibliography("references.bib", title: "References", full: true)
