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

#definition(name: "Linear Space over Field $F$")[
  Let $V$ be a non-empty set and $F$ a field. If two operations (binary mappings) are defined
  on $V$:
  - *Vector addition*: for any $alpha, beta in V$, there exists $gamma in V$ such that
    $gamma = alpha + beta$.
  - *Scalar multiplication*: for any $alpha in V$ and $c in F$, there exists $gamma in V$
    such that $gamma = c dot alpha$.

  and the following axioms hold (for any $alpha, beta, gamma in V$ and $k, l in F$):
  - *A1. Commutativity of Addition*: $alpha + beta = beta + alpha$.
  - *A2. Associativity of Addition*: $(alpha + beta) + gamma = alpha + (beta + gamma)$.
  - *A3. Existence of Additive Identity*: there exists $0 in V$ such that
    $alpha + 0 = 0 + alpha = alpha$.
  - *A4. Existence of Additive Inverse*: there exists $-alpha in V$ such that
    $alpha + (-alpha) = (-alpha) + alpha = 0$.
  - *M1. Compatibility of Scalar Multiplication with Field Multiplication*:
    $k(l alpha) = (k l) alpha$.
  - *M2. Identity Element of Scalar Multiplication*: $1 dot alpha = alpha$, where $1$ is the
    multiplicative identity in $F$.
  - *D1. Distributivity over Vector Addition*: $k(alpha + beta) = k alpha + k beta$.
  - *D2. Distributivity over Field Addition*: $(k + l) alpha = k alpha + l alpha$.

  Then $V$ is called a *linear space* (or *vector space*) over the field $F$.
] <def:linear-space>

#note[
  In the definition, *A1 (commutativity of addition)* can be derived from the other axioms,
  so it is not strictly necessary to include it as an axiom.
]

Examples of linear spaces:

- The univariate polynomials $P[x]$ over the number field $P$, with the usual polynomial
  addition and scalar multiplication, form a linear space over $P$; restricting to polynomials
  of degree less than $n$ together with the zero polynomial gives $P[x]_n$, also a linear
  space over $P$.
- The positive reals $bb(R)^+$ with $a ⊕ b = a b$ and $k ∘ a = a^k$ forms a linear space
  over $bb(R)$.
- The set of all real-valued functions, with function addition and scalar multiplication,
  forms a linear space over $bb(R)$.
- The field $P$ itself, under its own addition and multiplication, forms a linear space
  over itself.
- The set $P^n$ of all ordered $n$-tuples of elements of $P$, with the usual vector addition
  and scalar multiplication, forms a linear space over $P$.

In this section we primarily work with spaces of $n$-dimensional vectors over $bb(R)$; all
elements of a linear space can be called vectors, and the definitions and properties of
vectors in $bb(R)^n$ generalize to any linear space.

=== Linear Combination and Dependence // 线性组合与线性相关

#definition(name: "Linear Combination")[
  Let $V$ be a linear space over $F$ and $alpha_1, ..., alpha_n in V$. For any scalars
  $k_1, ..., k_n in F$, the vector $beta = k_1 alpha_1 + ... + k_n alpha_n$ is called a
  *linear combination* of $alpha_1, ..., alpha_n$ (we also say $beta$ is linearly expressed
  by them), and the $k_i$ are called the *coefficients* of the linear combination.
] <def:linear-combination>

#definition(name: "Linear Representation and Equivalence")[
  If every vector $alpha_i$ ($i = 1, ..., t$) of the vector group $alpha_1, ..., alpha_t$
  can be linearly expressed by the vector group $beta_1, ..., beta_s$, then
  $alpha_1, ..., alpha_t$ is said to be linearly expressed by $beta_1, ..., beta_s$.
  If two vector groups can be linearly expressed by each other, they are called *equivalent*.
] <def:linear-representation>

#note[
  Linear representation identifies redundant equations in a linear system: if one equation can
  be linearly expressed by the other equations, its row in the matrix reduces to a zero row
  under elementary transformations. If two vector groups are equivalent, their corresponding
  linear systems are equivalent.
]

#definition(name: "Linear Dependence and Independence")[
  A vector group $alpha_1, ..., alpha_t$ ($t >= 2$) is *linearly dependent* if one of its
  vectors can be linearly expressed by the others. Equivalently, the group is linearly
  dependent if there exist scalars $k_1, ..., k_t in F$, not all zero, such that
  $k_1 alpha_1 + ... + k_t alpha_t = 0$.

  Conversely, $alpha_1, ..., alpha_t$ ($t >= 1$) is *linearly independent* if
  $k_1 alpha_1 + ... + k_t alpha_t = 0$ implies $k_1 = ... = k_t = 0$.
] <def:linear-dependence-and-independence>

#note[
  If a subset of a vector group is linearly dependent, the whole group is linearly dependent;
  if the group is linearly independent, any non-empty subset is linearly independent
  (*partial dependence implies overall dependence; overall independence implies partial
  independence*). In particular, a linearly independent group cannot contain two proportional
  vectors.
]

#proposition(name: "Properties of Linear Independence")[
  - Let $alpha_i = (a_("i1"), ..., a_("in"))$, $i = 1, ..., s$. The group is linearly dependent
    if and only if the homogeneous system $x_1 alpha_1 + ... + x_s alpha_s = 0$ (entrywise,
    a system of $n$ equations in $s$ unknowns) has a non-zero solution.
  - Adding one component to each vector of a linearly independent group preserves independence.
  - *Steinitz Replacement Principle*: if $alpha_1, ..., alpha_r$ can be linearly expressed
    by $beta_1, ..., beta_s$, then:
    - if $r > s$, the group $alpha_1, ..., alpha_r$ is linearly dependent;
    - if $alpha_1, ..., alpha_r$ is linearly independent, then $r <= s$, and replacing the
      first $r$ vectors of $beta_1, ..., beta_s$ by $alpha_1, ..., alpha_r$ gives a vector
      group equivalent to $beta_1, ..., beta_s$.
  - Any $n + 1$ vectors of dimension $n$ are linearly dependent.
  - Two equivalent linearly independent vector groups contain the same number of vectors.
  - If $alpha_1, ..., alpha_r$ is linearly independent and $beta$ is another vector, then
    either $beta$ can be uniquely linearly expressed by $alpha_1, ..., alpha_r$, or
    $alpha_1, ..., alpha_r, beta$ is linearly independent.
  - If $beta$ can be linearly expressed by $alpha_1, ..., alpha_r$, then
    $alpha_1, ..., alpha_r$ is linearly independent if and only if the expression of $beta$
    is unique.
] <prop:properties-of-linear-independence>

#proof[
  *Item 1.* This is exactly the equivalent definition of dependence, written entrywise.

  *Item 2.* A nontrivial relation among the enlarged vectors would restrict to one among the
  original vectors.

  *Item 3.* Write $alpha_i = sum_(j=1)^s c_("ij") beta_j$. For $r > s$, the $s$ equations
  $sum_(i=1)^r c_("ij") x_i = 0$ ($j = 1, ..., s$) have a non-zero solution $x$, and
  $sum_(i=1)^r x_i alpha_i = sum_(j=1)^s (sum_(i=1)^r c_("ij") x_i) beta_j = 0$, so the group
  is dependent. For the replacement claim, exchange the $alpha$'s into the $beta$-list from
  $alpha_r$ down to $alpha_1$: when processing $alpha_i$, its expression in the current list
  must involve some remaining $beta$, otherwise $alpha_i$ would lie in the span of the
  already-placed $alpha$'s, contradicting independence; replacing that $beta$ by $alpha_i$
  preserves the span. The resulting group is equivalent to $beta_1, ..., beta_s$.

  *Item 4.* Apply item 1 to the $n$-dimensional vectors: the homogeneous system of $n$
  equations in $n + 1$ unknowns always has a non-zero solution.

  *Item 5.* Each direction follows from item 3: an independent group expressible by another
  group cannot contain more vectors than the latter.

  *Item 6.* If $alpha_1, ..., alpha_r, beta$ is linearly independent, the conclusion is
  immediate. Otherwise they are dependent: there exist scalars $k_1, ..., k_r, k$, not all
  zero, with $k_1 alpha_1 + ... + k_r alpha_r + k beta = 0$. If $k = 0$, then
  $sum_(i=1)^r k_i alpha_i = 0$ with not all $k_i$ zero, contradicting the independence of
  the $alpha$'s; hence $k != 0$ and $beta = -sum_(i=1)^r (k_i/k) alpha_i$. If $beta$ had
  another expression $sum_(i=1)^r l_i alpha_i$, subtracting gives
  $sum_(i=1)^r (l_i + k_i/k) alpha_i = 0$, hence $l_i = -k_i/k$ for all $i$, so the
  expression is unique.

  *Item 7.* If $alpha_1, ..., alpha_r$ is dependent, a nontrivial relation
  $sum_(i=1)^r k_i alpha_i = 0$ gives another expression
  $beta = sum_(i=1)^r (c_i + t k_i) alpha_i$ for any $t$, so uniqueness fails. Conversely,
  item 6 shows that independence forces uniqueness.
]

=== Dimension, Basis, Coordinates // 维数、基与坐标

#definition(name: "Dimension")[
  If a linear space $V$ over $F$ contains $n$ linearly independent vectors but any
  $n + 1$ vectors are linearly dependent, then $V$ is called an *$n$-dimensional linear space*,
  written $"dim"(V) = n$. If $V$ contains arbitrarily many linearly independent vectors, it
  is called an *infinite-dimensional linear space*.
] <def:dimension>

#definition(name: "Basis and Coordinates")[
  In an $n$-dimensional linear space $V$, $n$ linearly independent vectors $alpha_1, ...,
  alpha_n$ form a *basis* of $V$. Any vector $alpha in V$ can be uniquely expressed as a
  linear combination of the basis vectors,
  $alpha = k_1 alpha_1 + ... + k_n alpha_n$, and the $k_i in F$ are called the *coordinates*
  of $alpha$ with respect to the basis.
] <def:basis-and-coordinates>

The definition immediately gives the following criterion: if $V$ contains $n$ linearly
independent vectors and every vector of $V$ can be expressed as a linear combination of them,
then these vectors form a basis and $V$ is $n$-dimensional.

== Subspaces // 子空间

#definition(name: "Linear Subspace")[
  Let $V$ be a linear space over $F$ and $W subset V$ a non-empty subset. If $W$ is itself a
  linear space under the same addition and scalar multiplication as $V$, then $W$ is called
  a *linear subspace* of $V$. The zero subspace and $V$ itself are called *trivial subspaces*.
] <def:linear-subspace>

#property(name: "Subspace Criterion")[
  A non-empty subset $W$ of $V$ is a linear subspace if and only if:
  - $alpha + beta in W$ for all $alpha, beta in W$;
  - $k alpha in W$ for all $alpha in W$ and $k in F$.
] <prop:subspace-criterion>

#definition(name: "Span of Vectors")[
  Let $V$ be a linear space over $F$ and $alpha_1, ..., alpha_s in V$. The set of all their
  linear combinations

  $
  W = {k_1 alpha_1 + ... + k_s alpha_s : k_1, ..., k_s in F},
  $

  is called the *span* of $alpha_1, ..., alpha_s$, denoted
  $upright("span")({alpha_1, ..., alpha_s})$ or $"langle"(alpha_1, ..., alpha_s)"rangle"$
  (sometimes $L(alpha_1, ..., alpha_s)$ is also used).
] <def:span-of-vectors>

=== Intersection and Sum // 交与和

#definition(name: "Intersection and Sum of Subspaces")[
  Let $V_1, V_2 subset V$ be two subspaces of $V$. Their *intersection* is
  $V_1 inter V_2 = {alpha : alpha in V_1 text("and") alpha in V_2}$, and their *sum* is
  $V_1 + V_2 = {alpha_1 + alpha_2 : alpha_1 in V_1, alpha_2 in V_2}$.
] <def:intersection-and-sum>

Both the intersection and the sum of two subspaces are again subspaces of $V$, and
$V_1 + V_2$ is the smallest subspace of $V$ containing both $V_1$ and $V_2$.

#proposition(name: "Span of a Union")[
  $"langle"(alpha_1, ..., alpha_s)"rangle" + "langle"(beta_1, ..., beta_t)"rangle" =
  "langle"(alpha_1, ..., alpha_s, beta_1, ..., beta_t)"rangle"$.
] <prop:span-of-union>

#theorem(name: "Dimension Formula")[
  Let $V$ be a finite-dimensional linear space over $F$ and $V_1, V_2 subset V$ two subspaces
  of $V$. Then

  $
  "dim"(V_1) + "dim"(V_2) = "dim"(V_1 + V_2) + "dim"(V_1 inter V_2).
  $
] <thm:dimension-formula>

=== Direct Sum // 直和

#definition(name: "Direct Sum of Subspaces")[
  Let $V_1, V_2 subset V$ be two subspaces of $V$. If every vector $alpha in V_1 + V_2$ can
  be uniquely expressed as $alpha = alpha_1 + alpha_2$ with $alpha_1 in V_1$ and
  $alpha_2 in V_2$, then $V_1 + V_2$ is called the *direct sum* of $V_1$ and $V_2$,
  denoted $V_1 ⊕ V_2$.
] <def:direct-sum>

#proposition(name: "Conditions for a Direct Sum")[
  The following conditions are equivalent to $V_1 + V_2$ being a direct sum:
  - the zero vector can be expressed only as $0 = 0 + 0$;
  - $V_1 inter V_2 = {0}$;
  - $"dim"(V_1 + V_2) = "dim"(V_1) + "dim"(V_2)$, or equivalently $"dim"(V_1 inter V_2) = 0$;
  - the union of any basis of $V_1$ and any basis of $V_2$ forms a basis of $V_1 + V_2$.
] <prop:direct-sum-conditions>

== Isomorphisms // 同构

#definition(name: "Isomorphism of Linear Spaces")[
  Let $V$ and $V'$ be two linear spaces over the field $F$.
  A bijection $sigma: V -> V'$ is called an *isomorphism* if for all
  $alpha, beta in V$ and $k in F$:
  - $sigma(alpha + beta) = sigma(alpha) + sigma(beta)$;
  - $sigma(k alpha) = k sigma(alpha)$.
  If such an isomorphism exists, $V$ and $V'$ are called *isomorphic*,
  denoted $V ≈ V'$.
] <def:isomorphism>

#theorem(name: "Isomorphism Theorem")[
  Two finite-dimensional linear spaces over the same field $F$ are isomorphic
  if and only if they have the same dimension.
] <thm:isomorphism-theorem>

#corollary(name: "Classification of Finite-Dimensional Spaces")[
  Every $n$-dimensional linear space over $F$ is isomorphic to $F^n$.
  Hence, finite-dimensional linear spaces over $F$ are classified up to
  isomorphism by their dimension.
] <cor:classification-of-finite-dim-spaces>

#proof[
  *Necessity.* An isomorphism maps a basis of $V$ to a basis of $V'$,
  so the dimensions coincide.

  *Sufficiency.* Let $dim(V) = dim(V') = n$, and let
  $alpha_1, ..., alpha_n$ and $beta_1, ..., beta_n$ be bases of $V$ and $V'$
  respectively. The map $sigma(sum_(i=1)^n k_i alpha_i) = sum_(i=1)^n k_i beta_i$
  is a linear bijection, hence an isomorphism.
]

#proposition(name: "Properties of Isomorphisms")[
  - An isomorphism maps the zero vector to the zero vector.
  - An isomorphism maps linearly independent vector groups to linearly independent ones.
  - The inverse of an isomorphism is again an isomorphism.
  - Isomorphism is an equivalence relation on the class of linear spaces.
] <prop:isomorphism-properties>

== Quotient Spaces // 商空间

#definition(name: "Cosets and Quotient Space")[
  Let $V$ be a linear space over $F$ and $W subset V$ a subspace.
  Define an equivalence relation on $V$ by
  $alpha ∼ beta$ if and only if $alpha - beta in W$.
  The equivalence class $[alpha] = alpha + W = {alpha + gamma : gamma in W}$
  is called a *coset* of $W$ in $V$. The set of all cosets, denoted
  $V / W$, with the operations

  $
  [alpha] + [beta] = [alpha + beta],   k [alpha] = [k alpha],
  $

  forms a linear space over $F$, called the *quotient space* of $V$ by $W$.
] <def:quotient-space>

#theorem(name: "Dimension of Quotient Space")[
  Let $V$ be a finite-dimensional linear space and $W subset V$ a subspace. Then

  $
  "dim"(V / W) = "dim"(V) - "dim"(W).
  $
] <thm:quotient-dimension>

#proof[
  Extend a basis $w_1, ..., w_r$ of $W$ to a basis $w_1, ..., w_r, v_1, ..., v_k$
  of $V$. Then the cosets $[v_1], ..., [v_k]$ form a basis of $V / W$,
  so $"dim"(V / W) = k = "dim"(V) - r = "dim"(V) - "dim"(W)$.
]

#definition(name: "Induced Mapping")[
  Let $sigma: V -> V'$ be a linear mapping with kernel $W = ker(sigma)$.
  The map $bar(sigma): V / W -> "im"(sigma)$ defined by
  $bar(sigma)([alpha]) = sigma(alpha)$ is a well-defined linear isomorphism,
  called the *induced mapping* of $sigma$.
] <def:induced-mapping>

#theorem(name: "First Isomorphism Theorem")[
  Let $sigma: V -> V'$ be a linear mapping. Then

  $
  V / ker(sigma) ≈ "im"(sigma).
  $
] <thm:first-isomorphism-theorem>

== Special Linear Spaces // 特殊线性空间

=== Commutative Spaces // 交换空间

#definition(name: "Commutative Space $C(A)$")[
  Let $A$ be an $n$-order matrix over the number field $P$. The set of all
  matrices satisfying $A X = X A$ is a subspace of $M_(n times n)(P)$,
  denoted $C(A)$ and called the *commutative space* of $A$.
] <def:commutative-space>

#property(name: "Properties of $C(A)$")[
  For any $n$-order matrices $A, B$ over $P$, if $A$ is similar to $B$
  ($A ~ B$), then $C(A)$ is isomorphic to $C(B)$ ($C(A) ≈ C(B)$),
  and furthermore $"dim"(C(A)) = "dim"(C(B))$.
] <prop:commutative-space-properties>

#example[
  Find the dimension and a basis of $C(A)$ where:

  (i) $A$ is a $3$-order matrix over the number field $P$ with three distinct
  eigenvalues.

  (ii) $A = mat( (1, 0, 4), (0, 1, 2), (0, 1, 2) )$.
]

= Linear Mappings // 线性映射

线性映射是保持线性结构的空间之间的映射，是矩阵与空间之间的桥梁。
本章讨论线性映射的定义、运算、核与像、矩阵表示以及特殊线性变换。

== Linear Mappings and Their Computation // 线性映射及其运算

#definition(name: "Linear Mapping")[
  Let $V$ and $V'$ be linear spaces over the field $F$. A mapping
  $A: V -> V'$ is called a *linear mapping* if for all $alpha, beta in V$ and
  $k in F$:

  $
  A(alpha + beta) = A(alpha) + A(beta),   A(k alpha) = k A(alpha).
  $

  If $V = V'$, then $A$ is called a *linear transformation* of $V$.
  The linear mapping from $V$ over $F$ to $F$ itself is called a *linear function* on $V$.
] <def:linear-mapping>

#note[
  The field $F$ naturally constitutes a one-dimensional linear space over itself,
  so a linear function is a special case of a linear mapping.
]

=== Existence and Uniqueness (Linear Extension Theorem) // 存在唯一性定理

#theorem(name: "Existence and Uniqueness of Linear Mappings")[
  Let $V$ and $V'$ be linear spaces over $F$, and let
  ${epsilon_1, ..., epsilon_n}$ be a basis of $V$. For any set of vectors
  ${alpha_1, ..., alpha_n} subset V'$, there exists a unique linear mapping

  $
  A: V -> V',   alpha = sum_(i=1)^n x_i epsilon_i ↝ A(alpha) = sum_(i=1)^n x_i alpha_i
  $

  such that $A(epsilon_i) = alpha_i$ for $i = 1, ..., n$.
] <thm:linear-extension>

=== Operations of Linear Mappings // 线性映射的运算

*Addition.* For $A, B in upright("Hom")(V, V')$, the sum $A + B$ is defined by
$(A + B)(alpha) = A(alpha) + B(alpha)$ for all $alpha in V$, and satisfies
commutativity, associativity, existence of additive identity (zero map), and
existence of additive inverse.

*Scalar multiplication.* For $k in F$ and $A in upright("Hom")(V, V')$, the
scalar product $k A$ is defined by $(k A)(alpha) = k A(alpha)$, and satisfies
the unit identity, associativity of scalars, and both distributive properties.

*Composition.* For $A in upright("Hom")(V', W)$ and $B in upright("Hom")(U, V')$,
the composition $A B$ is defined by $(A B)(alpha) = A(B(alpha))$, and satisfies
associativity, left/right distributivity, and non-commutativity in general.
The identity transformation $E$ satisfies $E A = A E = A$ for all
$A in upright("Hom")(V)$.

The collection $upright("Hom")(V, V')$ of all linear mappings from $V$ to $V'$
forms a linear space over $F$. The collection $upright("End")(V)$ of all linear
transformations on $V$ forms a unital ring, called the *endomorphism ring* of $V$.

#definition(name: "Algebra over a Field")[
  Let $V$ be a linear space over $F$ equipped with an additional binary operation
  $dot: V × V -> V$. Then $V$ is called an *algebra over $F$* if for all
  $alpha, beta, gamma in V$ and $k, l in F$:
  - *Right distributivity*: $(alpha + beta) dot gamma = alpha dot gamma + beta dot gamma$;
  - *Left distributivity*: $gamma dot (alpha + beta) = gamma dot alpha + gamma dot beta$;
  - *Compatibility with scalar multiplication*: $(k alpha) dot (l beta) = (k l)(alpha dot beta)$.
] <def:algebra-over-field>

#note[
  The left and right distributivity conditions can be combined into a single condition:
  $V$ forms a unital ring under the addition and scalar multiplication.
  It is evident that $upright("End")(V)$ is an algebra over $F$.
]

== Kernel and Image of Linear Mappings // 线性映射的核与像

#definition(name: "Kernel and Image")[
  Let $V$ and $V'$ be linear spaces over $F$, and $A: V -> V'$ a linear mapping.
  The *kernel* of $A$ is

  $
  "ker"(A) = {alpha : alpha in V, A(alpha) = 0},
  $

  and the *image* of $A$ is

  $
  "im"(A) = {beta : beta = A(alpha), alpha in V, beta in V'},
  $

  also denoted $A^(-1)(0)$ and $A(V)$ respectively.
  The rank of $"im"(A)$ is called the *rank* of $A$;
  the dimension of $"ker"(A)$ is called the *nullity* of $A$.
] <def:kernel-and-image>

#theorem(name: "Rank-Nullity Theorem")[
  Let $V$ and $V'$ be finite-dimensional linear spaces over $F$, and
  $A: V -> V'$ a linear mapping. Then

  $
  "dim"("ker"(A)) + "dim"("im"(A)) = "dim"(V).
  $
] <thm:rank-nullity>

#definition(name: "Cokernel")[
  Let $V$ and $V'$ be linear spaces over $F$, and $A: V -> V'$ a linear mapping.
  The *cokernel* of $A$ is the quotient space

  $
  "coker"(A) = V' / "im"(A).
  $
] <def:cokernel>

=== Ascending Chain of Subspaces // 子空间升链

#definition(name: "Ascending Chain of Subspaces")[
  Let $V$ be a finite-dimensional linear space over $F$, and
  $A in upright("End")(V)$. For $k = 1, 2, 3, ...$, define

  $
  V_k = "ker"(A^k) = {alpha in V : A^k(alpha) = 0},
  $

  then the sequence of subspaces

  $
  V_1 ⊆ V_2 ⊆ ... ⊆ V_k ⊆ ...
  $

  is called the *ascending chain of subspaces* induced by $A$.
] <def:ascending-chain>

#property(name: "Properties of the Ascending Chain")[
  - The dimensions are non-decreasing: $"dim"(V_1) <= "dim"(V_2) <= ...$.
  - Since $V$ is finite-dimensional, there exists a positive integer $k_0$ such that
    $"dim"(V_(k_0)) = "dim"(V_(k_0 + 1)) = ...$, and for all $k >= k_0$,
    $V_k = V_(k_0)$ — the ascending chain stabilizes at $V_(k_0)$.
  - This $k_0$ is a stability index for the corresponding linear operator
    (for example, an upper bound on the degree of its annihilating polynomial or
    a restriction on the size of its Jordan blocks).
] <prop:ascending-chain-properties>

#note[
  In some cases, the stability index $k_0$ can be equal to $"dim"(V)$.
  For instance, when $A$ is nilpotent or all eigenvalues of $A$ are zero.
]

== Matrix Representation of Linear Mappings // 线性映射的矩阵表示

Let $V$ and $V'$ be finite-dimensional linear spaces over $F$ with
$"dim"(V) = n$ and $"dim"(V') = m$, and let $A: V -> V'$ be a linear mapping.
Let ${epsilon_1, ..., epsilon_n}$ be a basis of $V$ and
${eta_1, ..., eta_m}$ a basis of $V'$.
Then the image of each basis vector of $V$ under $A$ can be expressed in terms
of the basis vectors of $V'$:

$
A(epsilon_i) = sum_(j=1)^m a_("ji") eta_j,   i = 1, ..., n.
$

This can be written in matrix form as

$
A(epsilon_1, ..., epsilon_n) = (A epsilon_1, ..., A epsilon_n) =
(eta_1, ..., eta_m) A,
$

where

$
A = (a_("ij"))_(m times n) =
mat(
  (a_("11"), a_("12"), ..., a_("1n")),
  (a_("21"), a_("22"), ..., a_("2n")),
  (dots.v, dots.v, dots.down, dots.v),
  (a_("m1"), a_("m2"), ..., a_("mn")),
).
$

The matrix $A$ is called the *matrix representation* of the linear mapping $A$
under the given bases.

#example[
  Let $A, B in M_(s times n)(F)$. Prove that homogeneous linear systems
  $A X = 0$ and $B X = 0$ have the same solution space if and only if there
  exists an invertible matrix $P in M_(s times s)(F)$ such that $B = P A$.
]

=== Base Change and Coordinate Change // 基变换与坐标变换

Let $B = {epsilon_1, ..., epsilon_n}$ and $B' = {epsilon'_1, ..., epsilon'_n}$ be two
bases of $V$, and let $S$ be the *transition matrix* (change-of-basis matrix) from
$B'$ to $B$, i.e.

$
(epsilon'_1, ..., epsilon'_n) = (epsilon_1, ..., epsilon_n) S.
$

If $alpha = sum_(i=1)^n x_i epsilon_i = sum_(i=1)^n x'_i epsilon'_i$, then the coordinate
vectors satisfy $x = S x'$, where $x = (x_1, ..., x_n)^T$ and $x' = (x'_1, ..., x'_n)^T$.
This is the *coordinate transformation formula*.

If $A$ has matrix representation $A$ under bases $B, B'$ of $V, V'$, and $B$ is changed
to $B_1 = B P$ and $B'$ to $B'_1 = B' Q$, then the new matrix representation is

$
A' = Q^(-1) A P.
$

In particular, if $V = V'$ and the same basis change $P$ is applied to both, then

$
A' = P^(-1) A P,
$

i.e. $A$ and $A'$ are *similar* matrices.

== Special Linear Transformations // 特殊线性变换

=== Common Linear Transformations // 常见线性变换

- *Identity transformation* $E$: $E(alpha) = alpha$ for all $alpha in V$.
- *Zero transformation* $O$: $O(alpha) = 0$ for all $alpha in V$.
- *Scalar transformation* $K$: $K(alpha) = k alpha$ for fixed $k in F$.
  When $k = 1$, it is the identity; when $k = 0$, it is the zero transformation.
- *Rotation transformation*: rotating a plane counterclockwise by an angle $theta$
  around the origin defines a linear transformation $P_(theta)$ on the 2D space.
  Similarly, rotating around a fixed axis in 3D space also defines a linear transformation.

=== Idempotent and Projection Transformations // 幂等变换与投影变换

#definition(name: "Idempotent Transformation")[
  A linear transformation $A$ on $V$ is called an *idempotent transformation* if
  $A^2 = A$.
] <def:idempotent-transformation>

Two linear transformations $A$ and $B$ on $V$ are called *orthogonal* if
$A B = B A = O$.

#definition(name: "Projection Transformation")[
  Let $V$ be a linear space over $F$, and let $U, W "subseteq" V$ be subspaces with
  $V = U ⊕ W$. For all $alpha in V$, there exist unique $alpha_1 in U$ and
  $alpha_2 in W$ such that $alpha = alpha_1 + alpha_2$.
  The map

  $
  P_U: V -> V,   alpha ↝ alpha_1
  $

  is called the *projection* onto $U$ along $W$, which is a linear transformation on $V$.
] <def:projection-transformation>

$P_U$ satisfies and uniquely satisfies:

$
P_U(alpha) = cases(
  alpha, & alpha in U,
  0, & alpha in W,
).
$

#proposition(name: "Projection and Idempotent")[
  Let $V$ be a linear space over $F$.
  - Let $U, W "subseteq" V$ with $V = U ⊕ W$. Then the projections $P_U$ and $P_W$
    are orthogonal idempotent transformations with $P_U + P_W = E$.
  - Let $A, B in upright("End")(V)$ be orthogonal idempotent transformations with
    $A + B = E$. Then $V = "im"(A) ⊕ "im"(B)$.
] <prop:projection-and-idempotent>

#proposition(name: "Idempotent and Involutional Characterization")[
  Let $V$ be a linear space over $F$, and $A in upright("End")(V)$.
  - $A$ is idempotent if and only if
    $upright("rank")(A) + upright("rank")(E - A) = "dim"(V)$.
  - $A$ is involutional ($A^2 = E$) if and only if
    $upright("rank")(A) + upright("rank")(E - A) = "dim"(V)$.
] <prop:idempotent-involutional-characterization>

#proposition(name: "Equivalent Conditions for Invertibility")[
  Let $V$ be a linear space over $F$, and $A in upright("End")(V)$.
  The following are equivalent:
  - $A$ is invertible;
  - if ${epsilon_1, ..., epsilon_n}$ is a basis of $V$, then
    $A epsilon_1, ..., A epsilon_n$ is also a basis of $V$;
  - if $alpha != 0$, then $A alpha != 0$;
  - if $V = V_1 ⊕ V_2$, then $V = A V_1 ⊕ A V_2$.
] <prop:invertibility-conditions>

== Linear Functions and Dual Spaces // 线性函数与对偶空间

#definition(name: "Linear Function")[
  A linear mapping from $V$ over $F$ to $F$ itself is called a *linear function*
  (or *linear functional*) on $V$. The set of all linear functions on $V$ is
  denoted $V^*$.
] <def:linear-function>

#definition(name: "Dual Space")[
  The set $V^* = upright("Hom")(V, F)$ of all linear functions on $V$, with the
  usual addition and scalar multiplication of mappings, forms a linear space over $F$,
  called the *dual space* of $V$.
] <def:dual-space>

#theorem(name: "Dimension of the Dual Space")[
  Let $V$ be an $n$-dimensional linear space over $F$. Then $V^*$ is also
  $n$-dimensional.
] <thm:dual-space-dimension>

#proof[
  Let ${epsilon_1, ..., epsilon_n}$ be a basis of $V$. Define linear functions
  $epsilon_i^*$ by $epsilon_i^*(epsilon_j) = delta_("ij")$ (Kronecker delta).
  Then ${epsilon_1^*, ..., epsilon_n^*}$ is a basis of $V^*$, called the *dual basis*
  corresponding to ${epsilon_1, ..., epsilon_n}$.
]

#definition(name: "Dual Basis")[
  The basis ${epsilon_1^*, ..., epsilon_n^*}$ of $V^*$ satisfying
  $epsilon_i^*(epsilon_j) = delta_("ij")$ is called the *dual basis* corresponding
  to the basis ${epsilon_1, ..., epsilon_n}$ of $V$.
] <def:dual-basis>

#property(name: "Double Dual")[
  The map $phi: V -> V^(*)$ defined by $phi(alpha)(f) = f(alpha)$ for all
  $f in V^*$ is an isomorphism. Thus $V ≈ V^(*)$ when $V$ is finite-dimensional.
] <prop:double-dual>

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

#definition(name: "Similar Matrices")[
  Let $A, B in F^(n times n)$ be two square matrices over the field $F$.
  If there exists an invertible matrix $P in F^(n times n)$ such that

  $
  B = P^(-1) A P,
  $

  then $A$ is said to be *similar* to $B$, denoted $A ~ B$, and $B$ is called a
  *similarity transformation* of $A$.
] <def:similar-matrices>

#definition(name: "Trace")[
  Let $A = (a_("ij"))_(n times n) in F^(n times n)$. The sum of the diagonal elements:

  $
  "tr"(A) = a_("11") + a_("22") + ... + a_("nn"),
  $

  is called the *trace* of $A$.
] <def:trace>

Similarity is an equivalence relation on the set of square matrices of the same order
(reflexive, symmetric, and transitive).

#property(name: "Arithmetic Properties of Trace")[
  For any $A, B in F^(n times n)$ and $k in F$:
  - $"tr"(A + B) = "tr"(A) + "tr"(B)$;
  - $"tr"(k A) = k "tr"(A)$;
  - $"tr"(A B) = "tr"(B A)$.
] <prop:trace-arithmetic>

#note[
  From the third property, the trace of an $n times n$ matrix is a commutative quantity
  extracted from the non-commutativity of matrix multiplication.
]

#property(name: "Arithmetic Properties of Similarity")[
  If $B_1 = P^(-1) A_1 P$ and $B_2 = P^(-1) A_2 P$, then:
  - $B_1 + B_2 = P^(-1)(A_1 + A_2) P$;
  - $B_1 B_2 = P^(-1)(A_1 A_2) P$;
  - $B_1^k = P^(-1) A_1^k P$ for $k = 1, 2, ...$ (similarity invariance of matrix powers).
] <prop:similarity-arithmetic>

#note[
  The similarity invariance of powers yields important applications:
  - *Eigenvalue invariance*: if $A ~ B$, the eigenvalues of $A^k$ and $B^k$ coincide.
  - *Diagonalization simplifies powers*: if $A = P^(-1) D P$ with $D$ diagonal,
    then $A^k = P^(-1) D^k P$.
  - *Jordan form for non-diagonalizable matrices*: $A^k = P^(-1) J^k P$ where $J$ is
    the Jordan form, and $J^k$ can be computed block by block.
  - *Matrix functions*: if $B = P^(-1) A P$, then $exp(B) = P^(-1) exp(A) P$.
]

#note[
  In summary, the *determinant*, *rank*, and *trace* of a matrix are invariants
  under similarity, collectively called *similarity invariants*.
  The *characteristic polynomial*, *eigenvalues*, and *eigenvectors*
  (discussed in the next section) are also similarity invariants.
]

== Eigenvectors and Eigenvalues // 特征向量与特征值

#definition(name: "Eigenvalues and Eigenvectors")[
  Let $V$ be a linear space over $F$ and $A in upright("End")(V)$.
  A non-zero vector $xi in V$ is called an *eigenvector* of $A$ if there exists
  a scalar $lambda in F$ such that

  $
  A(xi) = lambda xi.
  $

  The scalar $lambda$ is called the *eigenvalue* corresponding to $xi$.

  From the matrix perspective, let $A in F^(n times n)$. A non-zero vector
  $x in F^n$ is an *eigenvector* of $A$ if $A x = lambda x$ for some $lambda in F$.
] <def:eigenvector-eigenvalue>

#property(name: "Eigenvalues of Matrix Functions")[
  If $lambda$ is an eigenvalue of $A$ with eigenvector $xi$, then for matrix functions
  of $A$ (the eigenvector $xi$ remains the same):
  - $A + k E$: eigenvalue is $lambda + k$;
  - $k A$: eigenvalue is $k lambda$;
  - $A^m$ ($m in N^*$): eigenvalue is $lambda^m$;
  - $A^(-1)$: eigenvalue is $1/lambda$;
  - $f(A)$ where $f(x)$ is a polynomial: eigenvalue is $f(lambda)$.
] <prop:eigenvalues-of-matrix-functions>

#definition(name: "Eigenpolynomial")[
  The polynomial

  $
  f(lambda) = abs(lambda E - A) = det(lambda E - A)
  $

  is called the *eigenpolynomial* (or *characteristic polynomial*) of $A$,
  where $A = (a_("ij"))_(n times n)$ and $E$ is the identity matrix.
] <def:eigenpolynomial>

#note[
  For example, in $P[x]_n$ ($n > 1$), the eigenpolynomial of the derivation
  operator $D$ is $f(lambda) = lambda^n$.
]

The roots of the eigenpolynomial $abs(lambda E - A)$ are the eigenvalues of $A$;
the non-zero solutions of $(lambda_0 E - A) x = 0$ are the eigenvectors
corresponding to $lambda_0$. The eigenpolynomial, eigenvalues, and eigenvectors
are invariant under similarity.

#proposition(name: "Properties of the Eigenpolynomial")[
  Let $A in F^(n times n)$ with eigenpolynomial $f(lambda) = abs(lambda E - A)$.
  Then $f(lambda)$ is a monic polynomial of degree $n$:

  $
  f(lambda) = lambda^n - "tr"(A) lambda^(n-1) + ... + (-1)^n abs(A),
  $

  where the coefficient of $lambda^(n-k)$ ($1 <= k < n$) is $(-1)^k$ times
  the sum of all $k$-order principal minors of $A$.
] <prop:eigenpolynomial-properties>

#note[
  Combining with Viète's formulas:
  - The sum of eigenvalues (counting multiplicities) equals $"tr"(A)$.
  - The product of eigenvalues (counting multiplicities) equals $abs(A)$.
]

=== Multiplicity and Eigenspaces // 重数与特征子空间

#definition(name: "Eigenspace")[
  For an eigenvalue $lambda$ of $A$, the set of all eigenvectors corresponding to
  $lambda$ along with the zero vector:

  $
  V_lambda = {alpha : alpha in V, A(alpha) = lambda alpha} =
  "ker"(A - lambda E),
  $

  is called the *eigenspace* corresponding to $lambda$, denoted $E_lambda$.
  It is a subspace of $V$ and the solution space of $(lambda E - A) X = 0$.
] <def:eigenspace>

#definition(name: "Geometric and Algebraic Multiplicity")[
  For an eigenvalue $lambda$ of $A$:
  - The dimension of the eigenspace $V_lambda = "ker"(A - lambda E)$ is called the
    *geometric multiplicity* of $lambda$.
  - The multiplicity of $lambda$ as a root of the eigenpolynomial $f(lambda)$ is called
    the *algebraic multiplicity* of $lambda$.
] <def:multiplicity>

#property(name: "Multiplicity Bounds")[
  For an eigenvalue $lambda$ of $A$, let $g(lambda)$ and $a(lambda)$ be the geometric
  and algebraic multiplicities respectively. Then

  $
  1 <= g(lambda) <= a(lambda) <= n.
  $
] <prop:multiplicity-bounds>

=== Estimation of Eigenvalues // 特征值的估计

#theorem(name: "Gerschgorin Disks First Theorem")[
  Let $A = (a_("ij"))_(n times n)$ be a square matrix over the complex field $C$.
  Then all eigenvalues of $A$ lie within the disks

  $
  abs(z - a_("ii")) <= R_i,   1 <= i <= n,
  $

  where $R_i = abs(a_("i1")) + ... + abs(a_(i,i-1)) + abs(a_(i,i+1)) + ... + abs(a_("in"))$.
] <thm:gerschgorin-1>

#theorem(name: "Gerschgorin Disks Second Theorem")[
  If the $n$ Gerschgorin disks of $A$ form $k$ connected regions, and one connected
  region contains $k$ Gerschgorin disks, then there are exactly $k$ eigenvalues
  (counting multiplicities) in this connected region.
] <thm:gerschgorin-2>

== Minimal Polynomial // 极小多项式

#definition(name: "Annihilating and Minimal Polynomial")[
  Let $V$ be a linear space over $F$ and $A in upright("End")(V)$.
  A polynomial $f(lambda)$ is called an *annihilating polynomial* of $A$ if
  $f(A) = 0$.

  The monic polynomial $m(lambda)$ of least degree such that $m(A) = 0$ is called
  the *minimal polynomial* of $A$.
  The same definition applies to a square matrix $A in F^(n times n)$.
] <def:minimal-polynomial>

== Space Decomposition // 空间分解

Studying linear transformations through invariant subspaces is a commonly used method,
as it reduces problems on the whole space to problems on lower-dimensional subspaces.

=== Invariant Subspace // 不变子空间

#definition(name: "Invariant Subspace")[
  Let $V$ be a linear space over $F$ and $A in upright("End")(V)$.
  A subspace $W subset V$ is called an *invariant subspace* of $V$ under $A$ if
  $A(alpha) subset W$ for all $alpha in W$, also called an *$A$-subspace*.
] <def:invariant-subspace>

#note[
  The kernel and image of $A$, as well as eigenspaces (including generalized eigenspaces)
  and cyclic subspaces, are all invariant subspaces of $V$ under $A$.
]

#property(name: "Properties of Invariant Subspaces")[
  - The zero subspace ${0}$ and the entire space $V$ are invariant under any $A$
    (trivial invariant subspaces).
  - If $A, B in upright("End")(V)$ commute ($A B = B A$), then
    $"ker"(A)$, $"im"(A)$, and eigenspaces of $A$ are invariant under $B$.
  - Any subspace of a scalar transformation is an invariant subspace.
  - The intersection and sum of any two invariant subspaces are also invariant subspaces.
] <prop:invariant-subspace-properties>

#proposition(name: "One-Dimensional Invariant Subspace")[
  Let $W = "langle"(xi)"rangle"$ ($xi != 0$). Then $W$ is an $A$-subspace if and only if
  $xi$ is an eigenvector of $A$.
] <prop:one-dim-invariant-subspace>

#theorem(name: "Block Triangular and Block Diagonal Representation")[
  Let $V$ be an $n$-dimensional linear space over $F$ and $A in upright("End")(V)$.

  - Let $W$ be a nontrivial $A$-subspace. Take a basis ${epsilon_1, ..., epsilon_r}$
    of $W$ and extend it to a basis ${epsilon_1, ..., epsilon_n}$ of $V$.
    Then the matrix representation of $A$ takes the block upper triangular form
    $mat((A, B), (O, C))$, where $A$ represents $A|_W$ and $C$ represents the induced
    transformation on $V/W$. The characteristic polynomial factorizes as
    $f(lambda) = f_1(lambda) f_2(lambda)$.

  - If the matrix representation of $A$ takes the block diagonal form
    $mat((A_1, O, ..., O), (O, A_2, ..., O), (dots.v, dots.v, dots.down, dots.v), (O, O, ..., A_s))$
    under some basis, then $V$ decomposes as a direct sum
    $V = W_1 ⊕ W_2 ⊕ ... ⊕ W_s$ of nontrivial $A$-subspaces.
] <thm:block-decomposition>

#proposition(name: "Kernel Decomposition by Coprime Polynomials")[
  Let $V$ be a linear space over $F$ and $A in upright("End")(V)$.
  On $F[x]$, if $f(x) = f_1(x) f_2(x) ... f_s(x)$ where $f_i(x)$ are pairwise coprime,
  then

  $
  "ker"(f(A)) = "ker"(f_1(A)) ⊕ "ker"(f_2(A)) ⊕ ... ⊕ "ker"(f_s(A)).
  $
] <prop:kernel-decomposition-coprime>

=== Hamilton-Cayley Theorem // Hamilton-Cayley 定理

#theorem(name: "Hamilton-Cayley Theorem")[
  Let $V$ be an $n$-dimensional linear space over $F$ and $A in upright("End")(V)$.
  Let $A$ be the matrix representation of $A$ under some basis, and let
  $f(lambda) = abs(lambda E - A)$ be the characteristic polynomial. Then

  $
  f(A) = 0.
  $
] <thm:hamilton-cayley>

#note[
  The Hamilton-Cayley theorem states that the characteristic polynomial of a linear
  transformation annihilates the transformation itself. The characteristic polynomial is
  a special annihilating polynomial — one of the highest degree ones — and it is divisible
  by the minimal polynomial of $A$.
]

#definition(name: "Root Subspaces")[
  For an eigenvalue $lambda$ of $A$, the set

  $
  V_lambda^(r) = "ker"((A - lambda E)^r) =
  {alpha : alpha in V, (A - lambda E)^r(alpha) = 0},
  $

  is called the *root subspace* (or *generalized eigenspace*) of order $r$
  corresponding to $lambda$.
] <def:root-subspace>

#note[
  Here $r$ has two equivalent definitions: (1) the smallest positive integer such that
  $(A - lambda E)^r(alpha) = 0$; (2) the algebraic multiplicity of $lambda$.
  The minimal such $r$ is precisely the algebraic multiplicity.
]

#theorem(name: "Root Space Decomposition Theorem")[
  Let $V$ be an $n$-dimensional linear space over $F$ and $A in upright("End")(V)$.
  If the characteristic polynomial of $A$ factors into linear factors over $F$:

  $
  f(lambda) = (lambda - lambda_1)^(r_1) (lambda - lambda_2)^(r_2) ... (lambda - lambda_k)^(r_k),
  $

  then $V$ decomposes as a direct sum of root subspaces:

  $
  V = V_(lambda_1)^(r_1) ⊕ V_(lambda_2)^(r_2) ⊕ ... ⊕ V_(lambda_k)^(r_k).
  $
] <thm:root-space-decomposition>

== Diagonalization // 对角化

#lemma(name: "Linear Independence of Eigenvectors")[
  Eigenvectors corresponding to distinct eigenvalues are linearly independent.
  Furthermore, if $A$ on $V$ has $k$ distinct eigenvalues $lambda_1, ..., lambda_k$,
  and $alpha_("i1"), ..., alpha_("ir"_i)$ are the corresponding linearly independent eigenvectors
  of $lambda_i$, then the set ${alpha_("ij") : i = 1, ..., k, j = 1, ..., r_i}$ is linearly independent.
] <lem:eigenvector-independence>

#theorem(name: "Equivalent Conditions for Diagonalization")[
  Let $V$ be an $n$-dimensional linear space over $F$ and $A in upright("End")(V)$.
  The following are equivalent:
  - $A$ is diagonalizable (there exists a basis of $V$ such that the matrix representation
    of $A$ is diagonal);
  - There are $n$ linearly independent eigenvectors of $A$;
  - For each eigenvalue of $A$, the geometric multiplicity equals the algebraic multiplicity;
  - $V = V_(lambda_1) ⊕ V_(lambda_2) ⊕ ... ⊕ V_(lambda_k)$, where $lambda_1, ..., lambda_k$
    are the distinct eigenvalues of $A$;
  - The minimal polynomial of $A$ has no repeated roots, i.e. it factors into distinct
    linear factors over $F$: $m(lambda) = (lambda - lambda_1)(lambda - lambda_2)...(lambda - lambda_k)$.
] <thm:diagonalization-conditions>

== Diagonalization of Special Matrices // 特殊矩阵的对角化

#note[
  Let $V$ be a linear space over $F$ (possibly infinite-dimensional) and
  $A in upright("End")(V)$, with matrix representation $A$.
  Some properties below require $V$ to be finite-dimensional or $F$ to be a number field
  ($bb(R)$ or $bb(C)$). The constraint on $F$ can sometimes be relaxed to
  "the characteristic of $F$ is not $2$".
]

=== Invertible Matrix // 可逆矩阵

- $0$ is not an eigenvalue of $A$ (and conversely).
- If $lambda$ is an eigenvalue of $A$, then $1/lambda$ is an eigenvalue of $A^(-1)$,
  and the eigenvector $xi$ of $A$ is also an eigenvector of $A^(-1)$.
- (When $F$ is a number field) If $A$ is diagonalizable, then $A^(-1)$ is also diagonalizable.

=== Idempotent Matrix // 幂等矩阵

Let $A$ be idempotent, i.e. $A^2 = A$.
- Any eigenvalue of $A$ is either $0$ or $1$.
- ($V$ finite-dimensional) $A$ is diagonalizable and
  $V = E_1 ⊕ E_0 = "ker"(A - E) ⊕ "ker"(A) = "im"(A) ⊕ "ker"(A)$.
- (When $F$ is a number field and $V$ finite-dimensional) The rank equals the trace:
  $upright("rank")(A) = "tr"(A)$.

=== Nilpotent Matrix // 幂零矩阵

Let $A$ be nilpotent, i.e. $A^k = 0$ for some positive integer $k$
(the smallest such $k$ is the *index of nilpotency*).
- All eigenvalues of $A$ are $0$.
- ($V$ finite-dimensional) $A$ is diagonalizable if and only if $A = 0$, i.e. $k = 1$.

=== Involution Matrix // 对合矩阵

Let $V$ be finite-dimensional, $F$ a number field, and $A$ an involution matrix,
i.e. $A^2 = E$. In geometry, an involution corresponds to a reflection or symmetry,
since $A^2 = E$ implies $A = A^(-1)$.
- All eigenvalues of $A$ are either $1$ or $-1$.
- $A$ is diagonalizable and $V = E_1 ⊕ E_(-1) = "ker"(A - E) ⊕ "ker"(A + E)$.

=== All-Ones Matrix // 全 1 矩阵

Let $F = bb(Q)$ and $A$ be the all-ones matrix. Denote
$1_n = (1, 1, ..., 1)^T$ (column vector of $n$ ones).
- All eigenvalues are $n$ (algebraic multiplicity $1$) or $0$ (algebraic multiplicity $n - 1$).
- The eigenvectors for $n$ are ${k 1_n : k in bb(Q), k != 0}$; the eigenvectors for $0$ are
  linear combinations of $eta_1, ..., eta_(n-1)$ where $eta_i$ has $1$ in position $1$,
  $-1$ in position $i+1$, and $0$ elsewhere.
- $A$ is diagonalizable.

#note[
  Note that $(1/n) A$ is an idempotent orthonormal projection matrix.
]

=== Cyclic Shift Matrix // 循环移位矩阵

Let $F = bb(C)$ and $A$ be the cyclic shift matrix (ones on the superdiagonal
and in position $(n, 1)$, zeros elsewhere). All properties are closely related to
the discrete Fourier transform (DFT) and roots of unity.
- The eigenvalues are the $n$-th roots of unity $omega^(k) = exp(2 pi i k / n)$
  for $k = 0, 1, ..., n - 1$.
- The eigenvector for $omega^(k)$ is $xi^(k) = (1, omega^(k), (omega^(k))^2, ..., (omega^(k))^(n-1))^T$.
- $A$ is diagonalizable, and can be unitarily diagonalized.

=== Circulant Matrix // 循环矩阵

Let $F = bb(C)$ and $A$ be a circulant matrix, i.e.
$A = a_0 E + a_1 C + a_2 C^2 + ... + a_(n-1) C^(n-1)$ where $C$ is the cyclic shift matrix.
- The eigenvalues are $lambda_k = f(omega^(k))$ where $f(x) = a_0 + a_1 x + ... + a_(n-1) x^(n-1)$.
- Circulant matrices share the same eigenvectors as the cyclic shift matrix.
- $A$ is diagonalizable, and can be unitarily diagonalized by the same DFT matrix.

#note[
  The eigenvalues of a circulant matrix are the discrete Fourier transform of its first row.
]

=== Triangular Matrix // 三角矩阵

Let $F$ be a number field and $A$ an upper triangular matrix.
- The eigenvalues of $A$ are the diagonal entries $a_("ii")$.
- If all diagonal entries are distinct, $A$ is diagonalizable. If there are repeated
  diagonal entries, $A$ may or may not be diagonalizable.
- If all diagonal entries are equal and there exists a non-zero entry above the diagonal,
  then $A$ is not diagonalizable.

== Simultaneous Characteristics Induced by Commutativity // 交换性诱导的同时性质

In this section we explore properties of matrices and linear transformations under
similarity relations induced by commutativity of multiplication. We call these
*simultaneous characteristics*.

=== Eigenspaces are Mutually Invariant Subspaces // 特征空间互为不变子空间

If $A$ and $B$ commute ($A B = B A$), then for any eigenvalue $lambda$ of $A$,
the eigenspace $V_lambda$ of $A$ is an invariant subspace of $B$.

=== Shared Eigenvectors // 公共特征向量

If $A$ and $B$ are diagonalizable and commute, then they share a common basis of
eigenvectors.

=== Simultaneous Upper Triangularization // 同时上三角化

Any commuting family of matrices over $bb(C)$ can be simultaneously upper triangularized.

=== Simultaneous Diagonalization // 同时对角化

Two diagonalizable linear transformations $A$ and $B$ can be simultaneously diagonalized
if and only if they commute ($A B = B A$).

=== Generalization in Multiple Cases // 多种情形的推广

The simultaneous diagonalization result extends to commuting families of normal matrices
(over $bb(C)$) and symmetric matrices (over $bb(R)$).

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
