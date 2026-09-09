#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Géométrie Analytique",
  author: "CatMono",
  date: datetime.today(),
)

#show: apply-style

// Custom multi-letter operators (not built into Typst math)
#let Pr = math.op("Pr")           // 投影算子 \mathrm{Pr}_{n_0}
#let xlongequal = math.op("=", limits: true)  // 带上下注释的可伸缩等号 \xlongequal{text}

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Géométrie Analytique",
  "CatMono",
  subtitle: "A notebook for analytic geometry",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v1.0",
  extra-info: "Without other remarks, this book is based on the $bb(R)^3$ space.",
)

#make-outline(depth: 2, title: "Contents")

// ==========================================================================
// Part I — Vector Algebra (向量代数)
// ==========================================================================
// 设计思路：建立解析几何的代数工具基础。坐标架给出空间的代数化描述，
// 向量的四种积（内积、外积、混合积、双重叉积）是后续一切图形方程的运算基础。
// Lagrange 恒等式与 Jacobi 恒等式作为向量恒等式的核心结果收束本章。

#part("Vector Algebra") // 向量代数

// --- Chapter 1: Coordinates and Vectors ---

= Coordinates and Vectors // 坐标与向量

== Coordinate Systems // 坐标系

#definition(name: "Coordinate Frame")[
  A fixed point $O$ in $bb(R)^3$ space,
  together with three non-coplanar ordered vectors $bold(e)_1$, $bold(e)_2$, $bold(e)_3$,
  is called a *coordinate frame* (or *reference frame*) in space,
  denoted by $"{" O ; bold(e)_1, bold(e)_2, bold(e)_3 "}"}$.
] <def:coordinate-frame>

#definition(name: "Cartesian Frame")[
  Within a coordinate frame $ "{" O ; bold(e)_1, bold(e)_2, bold(e)_3 "}" $:
  - If $bold(e)_1$, $bold(e)_2$, $bold(e)_3$ are unit vectors, the frame is called a *Cartesian frame*.
  - Furthermore, if $bold(e)_1 perp bold(e)_2$, $bold(e)_2 perp bold(e)_3$, $bold(e)_3 perp bold(e)_1$,
    the frame is called a *rectangular Cartesian frame* (or simply *rectangular frame*).
  - A coordinate frame that is not necessarily Cartesian is also called an *affine frame*.
] <def:cartesian-frame>

#definition(name: "Vector Coordinates")[
  Given a coordinate frame $ "{" O ; bold(e)_1, bold(e)_2, bold(e)_3 "}" $ and a vector $bold(v)$,
  since $bold(e)_1$, $bold(e)_2$, $bold(e)_3$ are non-coplanar (hence linearly independent),
  there exist unique scalars $v_1, v_2, v_3 in bb(R)$ such that
  $ bold(v) = v_1 bold(e)_1 + v_2 bold(e)_2 + v_3 bold(e)_3. $
  The ordered triple $(v_1, v_2, v_3)$ is called the *coordinates* of $bold(v)$ under this frame,
  denoted $bold(v) = (v_1, v_2, v_3)$.

  For a point $M$ in space, the coordinates of $bold(v) = arrow(O M)$ are called the *coordinates of $M$*,
  denoted $M(x, y, z)$ or $M = (x, y, z)$.
] <def:vector-coordinates>

#note[
  The concept of vector coordinates is a specialization of the basis representation in linear algebra
  (see the *Algèbre Linéaire* note, Chapter on Linear Spaces). Here we restrict to $bb(R)^3$ with a fixed frame.
]

#example(name: "Coordinates from three points")[
  Given three points $A(1, 0, 0)$, $B(0, 1, 0)$, $C(0, 0, 1)$, find the coordinates of the vector
  $bold(v) = arrow(A B) + arrow(B C)$ under the standard rectangular frame.
  <ex:coordinate-frame>

  #solution[
    Compute each segment:
    $ arrow(A B) = (0 - 1, 1 - 0, 0 - 0) = (-1, 1, 0), $
    $ arrow(B C) = (0 - 0, 0 - 1, 1 - 0) = (0, -1, 1). $
    Therefore,
    $ bold(v) = arrow(A B) + arrow(B C) = (-1 + 0, 1 - 1, 0 + 1) = (-1, 0, 1). $
  ]
]

== Products of Vectors // 向量的积

=== Inner Product (Dot Product) // 内积/点积

#definition(name: "Inner Product")[
  For two vectors $bold(a)$ and $bold(b)$, the *inner product* (or *dot product*) is defined as:
  $ bold(a) dot bold(b) = abs(bold(a)) abs(bold(b)) cos theta, $
  where $theta$ is the angle between the two vectors.
] <def:inner-product>

#property(name: "Geometric Meaning of Inner Product")[
  The inner product encodes both length and angle information:
  - *Length*: $abs(bold(a)) = sqrt(bold(a) dot bold(a))$.
  - *Angle*: $cos theta = (bold(a) dot bold(b)) / (abs(bold(a)) abs(bold(b)))$ for $bold(a), bold(b) != 0$.
  - *Perpendicularity*: $bold(a) perp bold(b) "iff" bold(a) dot bold(b) = 0$.
  - *Projection*: $Pr_bold(b) bold(a) = (bold(a) dot bold(b)) / abs(bold(b))$.
] <prop:inner-product-geometry>

#example(name: "Angle between two vectors")[
  Find the angle $theta$ between $bold(a) = (1, 2, 2)$ and $bold(b) = (2, 1, -2)$.
  <ex:inner-product-angle>

  #solution[
    Compute the inner product and lengths:
    $ bold(a) dot bold(b) = 1 dot 2 + 2 dot 1 + 2 dot (-2) = 2 + 2 - 4 = 0. $
    Since $bold(a) dot bold(b) = 0$, the vectors are perpendicular, i.e., $theta = pi / 2$.
  ]
]



=== Outer Product (Cross Product) // 外积/叉积

#definition(name: "Outer Product")[
  For two vectors $bold(a)$ and $bold(b)$, the *outer product* (or *cross product*) is defined as:
  $ bold(a) times bold(b) = abs(bold(a)) abs(bold(b)) sin theta #h(0.17em) bold(n), $
  where $theta$ is the angle between the two vectors, and $bold(n)$ is a unit vector perpendicular
  to both $bold(a)$ and $bold(b)$,
  following the right-hand rule, i.e., $bold(a), bold(b), bold(n)$ form a right-handed system
  (see @fig:right-hand-rule).
] <def:outer-product>

#figure(
  image("img/right-hand-rule.svg", width: 50%),
  caption: [Right-hand rule for the outer product.],
  placement: auto,
  supplement: [Fig.],
) <fig:right-hand-rule>

In Cartesian coordinates, if $bold(a) = (x_1, y_1, z_1)$ and $bold(b) = (x_2, y_2, z_2)$,
then
$ bold(a) times bold(b) =
  mat(delim: "|", bold(i), bold(j), bold(k); x_1, y_1, z_1; x_2, y_2, z_2) =
  (y_1 z_2 - z_1 y_2, z_1 x_2 - x_1 z_2, x_1 y_2 - y_1 x_2), $
where $bold(i)$, $bold(j)$, $bold(k)$ are the unit vectors along the $x$, $y$, and $z$ axes respectively.

#property(name: "Geometric Meaning of Outer Product")[
  The outer product encodes area and normal direction:
  - *Area*: $abs(bold(a) times bold(b)) = abs(bold(a)) abs(bold(b)) sin theta$
    equals the area of the parallelogram spanned by $bold(a)$ and $bold(b)$.
  - *Triangle area*: The area of the triangle with sides $bold(a), bold(b)$ is
    $1 / 2 abs(bold(a) times bold(b))$.
  - *Parallelism*: $bold(a) times bold(b) = 0 "iff" bold(a) #h(0.17em) "||" #h(0.17em) bold(b)$.
  - *Normal direction*: $bold(a) times bold(b) perp bold(a)$ and $bold(a) times bold(b) perp bold(b)$,
    used to construct normal vectors of planes (see Ch3 §3.1).
] <prop:outer-product-geometry>

#example(name: "Area of a triangle")[
  Find the area of the triangle with vertices $A(1, 0, 0)$, $B(0, 1, 0)$, $C(0, 0, 1)$.
  <ex:outer-product-area>

  #solution[
    Let $bold(a) = arrow(A B) = (-1, 1, 0)$ and $bold(b) = arrow(A C) = (-1, 0, 1)$.
    Compute the outer product:
    $ bold(a) times bold(b) =
      (1 dot 1 - 0 dot 0, 0 dot (-1) - (-1) dot 1, (-1) dot 0 - 1 dot (-1))
      = (1, 1, 1). $
    The triangle area is
    $ 1 / 2 abs(bold(a) times bold(b)) = 1 / 2 sqrt(1^2 + 1^2 + 1^2) = sqrt(3) / 2. $
  ]
]




=== Mixed Product // 混合积

#definition(name: "Mixed Product")[
  For three vectors $bold(a)$, $bold(b)$, $bold(c)$, the *mixed product* is defined as:
  $ (bold(a), bold(b), bold(c)) = (bold(a) times bold(b)) dot bold(c), $
  also denoted as $(bold(a), bold(b), bold(c))$.
] <def:mixed-product>

#property(name: "Permutation Symmetry of Mixed Product")[
  Cyclic permutation of the three factors of mixed product does not change its value;
  swapping any two factors changes the sign:
  $ (bold(a), bold(b), bold(c)) = (bold(b), bold(c), bold(a))
    = (bold(c), bold(a), bold(b)) = -(bold(b), bold(a), bold(c))
    = -(bold(a), bold(c), bold(b)) = -(bold(c), bold(b), bold(a)). $
] <prop:mixed-product-permutation>

*Geometric meaning.* The absolute value of the mixed product represents the volume of the
parallelepiped formed by the three vectors (see @fig:mixed-product-volume).
In Cartesian coordinates, if $bold(a) = (x_1, y_1, z_1)$, $bold(b) = (x_2, y_2, z_2)$,
and $bold(c) = (x_3, y_3, z_3)$, then
$ (bold(a), bold(b), bold(c)) =
  mat(delim: "|", x_1, y_1, z_1; x_2, y_2, z_2; x_3, y_3, z_3). $
$bold(a)$, $bold(b)$, $bold(c)$ are coplanar if and only if $(bold(a), bold(b), bold(c)) = 0$.

#figure(
  image("img/mixed-product-volume.svg", width: 50%),
  caption: [Volume of the parallelepiped equals the absolute value of the mixed product.],
  placement: auto,
  supplement: [Fig.],
) <fig:mixed-product-volume>

#example(name: "Volume of a tetrahedron")[
  Find the volume of the tetrahedron with vertices
  $O(0, 0, 0)$, $A(1, 0, 0)$, $B(0, 1, 0)$, $C(0, 0, 1)$.
  <ex:mixed-product-volume>

  #solution[
    Let $bold(a) = arrow(O A) = (1, 0, 0)$,
    $bold(b) = arrow(O B) = (0, 1, 0)$,
    $bold(c) = arrow(O C) = (0, 0, 1)$.
    The mixed product is
    $ (bold(a), bold(b), bold(c)) =
      mat(delim: "|", 1, 0, 0; 0, 1, 0; 0, 0, 1) = 1. $
    The parallelepiped volume is $abs((bold(a), bold(b), bold(c))) = 1$.
    Since a tetrahedron is $1 / 6$ of the parallelepiped, the tetrahedron volume is
    $ V = 1 / 6 abs((bold(a), bold(b), bold(c))) = 1 / 6. $
  ]
]





=== Double Cross Product // 双重叉积

#definition(name: "Double Cross Product")[
  For three vectors $bold(a)$, $bold(b)$, $bold(c)$, the *double cross product* is defined as:
  $ bold(a) times (bold(b) times bold(c)). $
] <def:double-cross-product>

#property(name: "Double Cross Product Identity")[
  The double cross product satisfies the following identity:
  $ bold(a) times (bold(b) times bold(c)) = (bold(a) dot bold(c)) bold(b) - (bold(a) dot bold(b)) bold(c) $
  or
  $ (bold(a) times bold(b)) times bold(c) = (bold(c) dot bold(a)) bold(b) - (bold(c) dot bold(b)) bold(a). $
] <prop:double-cross-identity>

#theorem(name: "Lagrange Identity")[
  For any four vectors $bold(a)$, $bold(b)$, $bold(c)$, $bold(d)$, the following identity holds:
  $ (bold(a) times bold(b)) dot (bold(c) times bold(d)) =
    (bold(a) dot bold(c))(bold(b) dot bold(d)) - (bold(a) dot bold(d))(bold(b) dot bold(c))
    = mat(delim: "|", bold(a) dot bold(c), bold(a) dot bold(d); bold(b) dot bold(c), bold(b) dot bold(d)). $
  Specially, when $bold(a) = bold(c)$ and $bold(b) = bold(d)$, we have:
  $ abs(bold(a) times bold(b))^2 = abs(bold(a))^2 abs(bold(b))^2 - (bold(a) dot bold(b))^2. $
] <thm:lagrange-identity>

#theorem(name: "Jacobi Identity")[
  For any three vectors $bold(a)$, $bold(b)$, $bold(c)$, the following identity holds:
  $ bold(a) times (bold(b) times bold(c)) + bold(b) times (bold(c) times bold(a)) + bold(c) times (bold(a) times bold(b)) = 0. $
] <thm:jacobi-identity>


== Linear Independence and Geometric Applications // 线性无关与几何应用

#note[
  The abstract definition of linear independence, basis, and dimension of vector spaces
  is treated in the *Algèbre Linéaire* note (Chapter on Linear Spaces).
  Here we focus on the *geometric applications* specific to $bb(R)^3$:
  using linear (in)dependence to detect collinearity and coplanarity.
] <note:linear-independence-srp>

#property(name: "Collinearity Criterion")[
  Two vectors $bold(a), bold(b) in bb(R)^3$ (with $bold(b) != 0$) are collinear, i.e.,
  $bold(a) = lambda bold(b)$ for some $lambda in bb(R)$, if and only if
  $ bold(a) times bold(b) = 0. $
  Equivalently, in Cartesian coordinates, $bold(a) = (x_1, y_1, z_1)$ and $bold(b) = (x_2, y_2, z_2)$
  are collinear iff
  $ x_1 / x_2 = y_1 / y_2 = z_1 / z_2, $
  where a zero coordinate in $bold(b)$ requires the corresponding coordinate in $bold(a)$ to also be zero.
] <prop:collinearity-criterion>

#property(name: "Coplanarity Criterion")[
  Three vectors $bold(a), bold(b), bold(c) in bb(R)^3$ are coplanar, i.e., linearly dependent, if and only if
  $ (bold(a), bold(b), bold(c)) = 0, $
  i.e., their mixed product vanishes.
  In Cartesian coordinates, this is equivalent to
  $ mat(delim: "|", x_1, y_1, z_1; x_2, y_2, z_2; x_3, y_3, z_3) = 0. $
] <prop:coplanarity-criterion>

#note[
  The three vectors $bold(e)_1, bold(e)_2, bold(e)_3$ of any coordinate frame
  are non-coplanar, hence linearly independent, and form a basis of $bb(R)^3$.
  This is precisely why every vector admits unique coordinates under a given frame.
]

// ==========================================================================
// Part II — Linear Figures (一次图形)
// ==========================================================================
// 设计思路：处理由一次方程描述的图形——直线与平面。
// Ch2 先建立"图形与方程"的一般对应思想（轨迹、参数方程、常见曲线曲面），
// Ch3 集中处理平面与直线的各种方程形式、相对位置关系、以及束的概念。

#part("Linear Figures") // 一次图形

// --- Chapter 2: Locus and Equation ---

= Locus and Equation // 轨迹与方程

== Parametric Equations // 参数方程

== Common Curves and Surfaces // 常见曲线与曲面

// --- Chapter 3: Planes and Space Lines ---

= Planes and Space Lines // 平面与空间直线

== Equations of Planes // 平面方程

=== Point-Vector Form // 点向式

In space, fix a point $M_0 = (X_0, Y_0, Z_0)$ and two non-collinear vectors $bold(a) = (X_1, Y_1, Z_1)$
and $bold(b) = (X_2, Y_2, Z_2)$.
The equation of the plane passing through the point $M_0$ and
parallel to the vectors $bold(a)$ and $bold(b)$ is given by:
$ bold(r) = arrow(O M) + lambda bold(a) + mu bold(b), $
or in coordinate form:
$ cases(
  x = X_0 + lambda X_1 + mu X_2,
  y = Y_0 + lambda Y_1 + mu Y_2,
  z = Z_0 + lambda Z_1 + mu Z_2,
) $
where $lambda, mu in bb(R)$.

Taking the dot product of both sides of the parametric vector equation with $bold(a) times bold(b)$,
we eliminate $lambda$ and $mu$ to obtain $(bold(r) - arrow(O M_0), bold(a), bold(b)) = 0$, that is,
#eq[
  mat(delim: "|", x - X_0, y - Y_0, z - Z_0; X_1, Y_1, Z_1; X_2, Y_2, Z_2) = 0.
] <eq:PlaneDeterminantForm>
All above forms are called the *point-vector form* of the plane equation.
#v(0.7cm)

Given three non-collinear points $M_1(X_1, Y_1, Z_1)$, $M_2(X_2, Y_2, Z_2)$ and $M_3(X_3, Y_3, Z_3)$,
the equation of the plane passing through these three points is given by:
$ bold(r) = arrow(O M_1) + lambda arrow(M_1 M_2) + mu arrow(M_1 M_3), $
or in coordinate form:
$ cases(
  x = X_1 + lambda (X_2 - X_1) + mu (X_3 - X_1),
  y = Y_1 + lambda (Y_2 - Y_1) + mu (Y_3 - Y_1),
  z = Z_1 + lambda (Z_2 - Z_1) + mu (Z_3 - Z_1),
) $
where $lambda, mu in bb(R)$.
And the determinant form is:
$ mat(delim: "|", x - X_1, y - Y_1, z - Z_1; X_2 - X_1, Y_2 - Y_1, Z_2 - Z_1; X_3 - X_1, Y_3 - Y_1, Z_3 - Z_1) = 0, $
or equivalently,
$ mat(delim: "|", x, y, z, 1; X_1, Y_1, Z_1, 1; X_2, Y_2, Z_2, 1; X_3, Y_3, Z_3, 1) = 0. $
All above forms are also called the *three-point form* of the plane equation.

If plane intersects the three coordinate axes at
$M_1(X_1, 0, 0)$, $M_2(0, Y_2, 0)$, $M_3(0, 0, Z_3)$ (where $X_1, Y_2, Z_3 != 0$),
then the equation of the plane can be expressed in the form:
$ x / X_1 + y / Y_2 + z / Z_3 = 1, $
which is called the *intercept form* of the plane equation.

=== General Form // 一般式

The general equation is obtained by expanding the determinant form of
the parametric equation @eq:PlaneDeterminantForm of a plane:
$ A x + B y + C z + D = 0, $
where
$ A = mat(delim: "|", Y_1, Z_1; Y_2, Z_2), quad
  B = mat(delim: "|", Z_1, X_1; Z_2, X_2), quad
  C = mat(delim: "|", X_1, Y_1; X_2, Y_2), quad
  D = -mat(delim: "|", X_0, Y_0, Z_0; X_1, Y_1, Z_1; X_2, Y_2, Z_2). $
Special cases include:

#theorem[
  Any plane in space can be represented by a linear equation in three variables $x$, $y$, and $z$,
  and conversely, every such equation represents a plane in space.
]

=== Point-Normal Form // 点法式

Given a point $M_0(X_0, Y_0, Z_0)$ on the plane and a normal vector $bold(n) = (A, B, C)$ of the plane,
the equation of the plane can be expressed as:
$ bold(n) dot (bold(r) - arrow(O M_0)) = 0, $
or in coordinate form:
$ A(x - X_0) + B(y - Y_0) + C(z - Z_0) = 0. $
If a perpendicular is drawn from the origin to the plane,
with the foot of the perpendicular being $M_0(X_0, Y_0, Z_0)$,
and the unit normal vector of the plane being $bold(n)_0 = (cos alpha, cos beta, cos gamma)$, then
$ bold(n) dot bold(r) - arrow(O M_0) = 0, $
or in coordinate form:
#eq[
  x cos alpha + y cos beta + z cos gamma - abs(arrow(O M_0)) = 0.
] <eq:PlanePointNormalUnitForm>

For the general equation of a plane,
it can be converted into the form @eq:PlanePointNormalUnitForm
by simply multiplying by a *normalization factor* $lambda$, where:
$ abs(lambda) = 1 / abs(bold(n)) = 1 / sqrt(A^2 + B^2 + C^2), $
and $lambda$ has the opposite sign as $D$.

== Linear Equations // 直线方程

=== Point-Vector Form // 点向式

Given a point $M_0(X_0, Y_0, Z_0)$ in space and a direction vector $bold(v) = (X, Y, Z)$ of the line,
then
$ bold(r) = arrow(O M_0) + lambda bold(v), $
and the parametric equations of the line can be expressed as:
$ cases(
  x = X_0 + lambda X,
  y = Y_0 + lambda Y,
  z = Z_0 + lambda Z,
) $
where $lambda in bb(R)$.
Eliminate the parameter $lambda$ to obtain the symmetric equation (standard equation):
#eq[
  (x - X_0) / X = (y - Y_0) / Y = (z - Z_0) / Z.
] <eq:LineSymmetricForm>

#v(0.7cm)
Given two points $M_1(X_1, Y_1, Z_1)$ and $M_2(X_2, Y_2, Z_2)$ in space,
the equation of the line passing through these two points is given by:
$ bold(r) = arrow(O M_1) + lambda arrow(M_1 M_2), $
or in coordinate form:
$ cases(
  x = X_1 + lambda (X_2 - X_1),
  y = Y_1 + lambda (Y_2 - Y_1),
  z = Z_1 + lambda (Z_2 - Z_1),
) $
It can also be expressed in symmetric form:
$ (x - X_1) / (X_2 - X_1) = (y - Y_1) / (Y_2 - Y_1) = (z - Z_1) / (Z_2 - Z_1). $

The coordinates of the direction vector of a line, $X, Y, Z$, or a set of numbers proportional to it,
$l, m, n$ ($l : m : n = X : Y : Z$), are called the *direction numbers* of the line.

=== General Form // 一般式

The intersection of two planes determines a line:
$ cases(
  A_1 x + B_1 y + C_1 z + D_1 = 0,
  A_2 x + B_2 y + C_2 z + D_2 = 0,
) $
where $A_1 : B_1 : C_1 != A_2 : B_2 : C_2$.

#theorem[
  Any line in space can be represented by a system of two linear equations in three variables $x$, $y$, and $z$,
  and conversely, every such system represents a line in space.
]

=== Projection Form // 投影式

In the symmetric equation @eq:LineSymmetricForm of a line,
$X$, $Y$, and $Z$ are not all zero.
Without loss of generality, let us assume $Z$ is not zero.
Then, we have:
$ cases(
  x = a z + c,
  y = b z + d,
) $
where $a = X / Z$, $b = Y / Z$, $c = X_0 - (X / Z) Z_0$, and $d = Y_0 - (Y / Z) Z_0$.
This form is called the *projection form* of the line equation.
This line can be regarded as the intersection line of the two planes represented by these two equations.
These planes are respectively parallel to the $y$-axis and $x$-axis,
and perpendicular to the $x O z$ and $y O z$ coordinate planes.


== Relative Positions of Points, Lines and Planes // 点线面相对位置

=== Points and Lines // 点与直线

There are only two possible relative positions between a point and a line:
the point is either on the line or it is not.
This can be determined by simply checking if the coordinates of the point satisfy the line's equation.

When the point $M_0(X_0, Y_0, Z_0)$ is not on the line
$ l: (x - X_1) / X = (y - Y_1) / Y = (z - Z_1) / Z, $
the distance from the point to the line is given by:
$ d = abs((arrow(M_1 M_0), bold(v))) / abs(bold(v)), $
where $arrow(M_1 M_0) = (X_0 - X_1, Y_0 - Y_1, Z_0 - Z_1)$,
$M_1(X_1, Y_1, Z_1)$ is a point on the line,
$bold(v)$ is the direction vector of the line.



=== Points and Planes // 点与平面

The relative position between a point and a plane
can be determined by checking if the coordinates of the point satisfy the plane's equation.
The distance is given below.

#definition(name: "Deviation")[
  From point $M_0 = (X_0, Y_0, Z_0)$,
  a perpendicular is drawn to the plane $A x + B y + C z + D = 0$ with the foot of the perpendicular being $Q$
  (see @fig:DeviationOfPointFromPlane).
  The projection of the vector $arrow(Q M_0)$ onto the unit normal vector $bold(n)_0$ of the plane
  is called the *deviation* of point $M_0$ from the plane,
  denoted as:
  $ delta = Pr_(bold(n)_0) arrow(Q M_0). $
]

#figure(
  image("img/deviation.png", width: 80%),
  caption: [Deviation of a Point from a Plane.],
  placement: auto,
  supplement: [Fig.],
) <fig:DeviationOfPointFromPlane>

Obviously, the absolute value of the deviation is equal to the distance from the point to the plane.
The deviation can be calculated using the formula:
$ delta = bold(n)_0 dot arrow(O M_0) - abs(arrow(O P)) $
$ = X_0 cos alpha + Y_0 cos beta + Z_0 cos gamma - abs(arrow(O P)) $
$ = lambda (A X_0 + B Y_0 + C Z_0 + D) $
$ = plus.minus (A X_0 + B Y_0 + C Z_0 + D) / sqrt(A^2 + B^2 + C^2). $
For points on the same side of a plane, the deviation signs are the same;
for points on opposite sides, the signs are different;
if the deviation is $0$, the point lies on the plane.


=== Lines and Lines // 直线与直线

For two lines in space
$ l_1: (x - x_1) / X_1 = (y - y_1) / Y_1 = (z - z_1) / Z_1, $
$ l_2: (x - x_2) / X_2 = (y - y_2) / Y_2 = (z - z_2) / Z_2. $
Relative positions can be classified into four cases:
+ *Skew.* $ Delta = (bold(v)_1, bold(v)_2, arrow(A B)) =
  mat(delim: "|", x_2 - x_1, y_2 - y_1, z_2 - z_1; X_1, Y_1, Z_1; X_2, Y_2, Z_2) != 0, $
  where $bold(v)_1 = (X_1, Y_1, Z_1)$, $bold(v)_2 = (X_2, Y_2, Z_2)$,
  and $A(x_1, y_1, z_1)$, $B(x_2, y_2, z_2)$ are points on lines $l_1$ and $l_2$ respectively;
+ *Intersecting.* $Delta = 0$, $X_1 : Y_1 : Z_1 != X_2 : Y_2 : Z_2$;
+ *Parallel.* $X_1 : Y_1 : Z_1 = X_2 : Y_2 : Z_2 != (x_2 - x_1) : (y_2 - y_1) : (z_2 - z_1)$;
+ *Coincident.* $X_1 : Y_1 : Z_1 = X_2 : Y_2 : Z_2 = (x_2 - x_1) : (y_2 - y_1) : (z_2 - z_1)$.

#definition(name: "Common Perpendicular")[
  The line that is perpendicular and intersects two skew lines is called
  the *common perpendicular* of the two skew lines,
  and the length of the segment between the two points of intersection is called the length of the common perpendicular.
]

#figure(
  image("img/CommonPerp.png", width: 60%),
  caption: [Common Perpendicular of Two Skew Lines.],
  placement: auto,
  supplement: [Fig.],
) <fig:CommonPerpendicular>

The length of the common perpendicular between two skew lines is given by:
$ d = abs((arrow(M_1 M_2), bold(v)_1, bold(v)_2)) / abs(bold(v)_1 times bold(v)_2). $
The common perpendicular can be seen as the intersection of two planes:
$ pi_1: (bold(r) - arrow(O M_1), bold(v)_1, bold(v)_1 times bold(v)_2) = 0, $
$ pi_2: (bold(r) - arrow(O M_2), bold(v)_2, bold(v)_1 times bold(v)_2) = 0. $
Since the equation of the common perpendicular is:
$ cases(
  mat(delim: "|", x - x_1, y - y_1, z - z_1; X_1, Y_1, Z_1; X, Y, Z) = 0,
  mat(delim: "|", x - x_2, y - y_2, z - z_2; X_2, Y_2, Z_2; X, Y, Z) = 0,
) $
where $(X, Y, Z) = bold(v)_1 times bold(v)_2$.

#property[
  - The common perpendicular to two skew lines exists and is unique.
  - The length of the common perpendicular segment between two skew lines is the distance between them.
]


=== Lines and Planes // 直线与平面

#proposition[
  Let plane $pi: A x + B y + C z + D = 0$,
  and vector $bold(v) = (X, Y, Z)$.
  Then $bold(v)$ is parallel to the plane $pi$ if and only if
  $ A X + B Y + C Z = 0. $
]

The relative positions between a line
$ l: (x - x_0) / X = (y - y_0) / Y = (z - z_0) / Z $
and a plane
$ pi: A x + B y + C z + D = 0 $
can be classified into three cases:
+ *Intersecting.* $A X + B Y + C Z != 0$;
+ *Parallel.* $A X + B Y + C Z = 0$, $A x_0 + B y_0 + C z_0 + D != 0$;
+ *Coincident.* $A X + B Y + C Z = 0$, $A x_0 + B y_0 + C z_0 + D = 0$.

#note[
  In fact, combining the two equations, we have
  $ (A X + B Y + C Z) t = -(A x_0 + B y_0 + C z_0 + D). $
  When $A X + B Y + C Z != 0$, there is a unique solution, i.e., they intersect; \
  when $A X + B Y + C Z = 0$, $A x_0 + B y_0 + C z_0 + D != 0$, there is no solution, i.e., they are parallel; \
  when $A X + B Y + C Z = 0$, $A x_0 + B y_0 + C z_0 + D = 0$, there are infinitely many solutions, i.e., the line lies on the plane.
]

#definition(name: "Angle between a Line and a Plane")[
  The angle between a line and a plane is the acute angle formed by the line and its projection on the plane;
  when the line is perpendicular to the plane, it is perpendicular to all lines on the plane.
]

=== Planes and Planes // 平面与平面

The relative positions between two planes
$ pi_1: A_1 x + B_1 y + C_1 z + D_1 = 0, $
$ pi_2: A_2 x + B_2 y + C_2 z + D_2 = 0, $
can be classified into three cases:
+ *Intersecting.* $A_1 : B_1 : C_1 != A_2 : B_2 : C_2$;
+ *Parallel.* $A_1 / A_2 = B_1 / B_2 = C_1 / C_2 != D_1 / D_2$;
+ *Coincident.* $A_1 / A_2 = B_1 / B_2 = C_1 / C_2 = D_1 / D_2$.

In Cartesian coordinates, since their normal vectors are
$bold(n)_1 = (A_1, B_1, C_1)$ and $bold(n)_2 = (A_2, B_2, C_2)$,
the angle $theta$ between two planes is given by:
$ cos theta = (bold(n)_1 dot bold(n)_2) / (abs(bold(n)_1) abs(bold(n)_2))
  = (A_1 A_2 + B_1 B_2 + C_1 C_2) / (sqrt(A_1^2 + B_1^2 + C_1^2) sqrt(A_2^2 + B_2^2 + C_2^2)). $
Obviously, the necessary and sufficient condition for two planes to be perpendicular is:
$ A_1 A_2 + B_1 B_2 + C_1 C_2 = 0. $


== Pencil of Planes and Lines // 平面与直线的束

#definition(name: "Pencil of Planes")[
  The set of all planes in space that pass through the same straight line is called an *axial plane pencil*,
  and that straight line is called the axis of the pencil.
  The set of all planes in space that are parallel to the same plane is called a *parallel plane pencil*.
]

#theorem[
  For two planes
  $ pi_1: A_1 x + B_1 y + C_1 z + D_1 = 0, $
  $ pi_2: A_2 x + B_2 y + C_2 z + D_2 = 0, $
  + if $pi_1$ and $pi_2$ intersect in a line $l$,
    then the equation of the axial plane pencil with axis $l$ can be expressed as:
    $ lambda (A_1 x + B_1 y + C_1 z + D_1) + mu (A_2 x + B_2 y + C_2 z + D_2) = 0, $
    where $lambda, mu in bb(R)$ are not both zero.
  + if $pi_1$ and $pi_2$ are parallel, i.e., $A_1 : B_1 : C_1 = A_2 : B_2 : C_2$,
    then the equation of the parallel plane pencil parallel to $pi_1$ and $pi_2$ can be expressed as:
    $ lambda (A_1 x + B_1 y + C_1 z + D_1) + mu (A_2 x + B_2 y + C_2 z + D_2) = 0, $
    where $lambda, mu in bb(R)$ are not both zero
    and $-mu : lambda != A_1 : A_2 = B_1 : B_2 = C_1 : C_2$.
]


// ==========================================================================
// Part III — Quadratic Figures (二次图形)
// ==========================================================================
// 设计思路：处理由二次方程描述的图形——曲面与圆锥曲线。
// Ch4 按生成方式分类曲面（柱/锥/旋转），Ch5 按标准方程分类二次曲面
// （椭球/双曲/抛物/直纹），Ch6 处理平面上的圆锥曲线。
// 两种分类视角互补：生成方式揭示曲面的构造来源，标准方程揭示曲面的几何特征。

#part("Quadratic Figures") // 二次图形

// --- Chapter 4: Common Surfaces ---

= Common Surfaces // 常见曲面

== Cylinder Surfaces // 柱面

#definition(name: "Cylinder Surface")[
  In space, the surface generated by a family of parallel lines,
  which are parallel to a fixed direction (the direction of the cylinder $bold(s) = (X : Y : Z)$)
  and intersect a fixed curve (the directrix $Gamma: cases(F_1(x, y, z) = 0, F_2(x, y, z) = 0)$),
  is called a *cylinder*.
]

Cylinder can be expressed as:
$ {x, y, z | F(x, y, z) = 0} $
$ = union.big_(x_1, y_1, z_1) in Gamma {x, y, z | (x - x_1) / X = (y - y_1) / Y = (z - z_1) / Z} $
$ xlongequal^(text("directrix ") Gamma: bold(r)(u) = (x(u), y(u), z(u)))
  {bold(r) | bold(r) = bold(r)(u) + v bold(s), quad u, v in bb(R)} $
$ xlongequal^(text("parametric form"))
  {x, y, z | cases(
    x = x(u) + v X,
    y = y(u) + v Y,
    z = z(u) + v Z,
  ) quad u, v in bb(R)}. $

To solve the equation of a cylinder,
$ cases(
  (x - x_1) / X = (y - y_1) / Y = (z - z_1) / Z,
  F_1(x_1, y_1, z_1) = 0,
  F_2(x_1, y_1, z_1) = 0,
) $

#v(0.7cm)
Some special cases of cylinders (see @fig:CylinderSurface):
+ *Elliptical Cylinder.* $x^2 / a^2 + y^2 / b^2 = 1$
+ *Hyperbolic Cylinder.* $x^2 / a^2 - y^2 / b^2 = 1$
+ *Parabolic Cylinder.* $y^2 = 2 p x$

Their equations are all quadratic, so they are collectively called *quadratic cylinders*.

#figure(
  image("img/Cylinder.png", width: 80%),
  caption: [Cylinder Surface.],
  placement: auto,
  supplement: [Fig.],
) <fig:CylinderSurface>

When a plane intersects a elliptical cylinder to form an ellipse (or a circle), the following rules apply:
+ The center of the resulting ellipse lies on the axis of the cylindrical surface.
+ $b = R$, meaning the length of the semi-minor axis of the ellipse is equal to the radius of the cylindrical surface.
+ $sin theta = R / a$, where $a$ represents the length of the semi-major axis of the ellipse,
  and $theta$ represents the angle between the axis of the cylinder and the plane.


#v(0.7cm)

#theorem[
  In a spatial Cartesian coordinate system (as well as in an affine coordinate system),
  a surface represented by a ternary equation containing only two variables (coordinates)
  is a cylinder whose generatrices are parallel to the coordinate axis corresponding to the missing variable (coordinate).
]

#example[

]

#note[
  Two methods to prove that an equation is a cylindrical surface:
  + Rewrite as a product equation using determinants and linear systems.
  + Take the directrix, set the direction, solve, and compare.
]

== Cone Surfaces // 锥面

#definition(name: "Cone Surface")[
  In space, the surface generated by a family of lines passing through a fixed point
  (the vertex $A: bold(r)_0 = (x_0, y_0, z_0)$)
  and intersecting a fixed curve
  (the directrix $Gamma: cases(F_1(x, y, z) = 0, F_2(x, y, z) = 0)$),
  is called a *cone*.
]

Cone can be expressed as:
$ {x, y, z | F(x, y, z) = 0} $
$ = union.big_(x_1, y_1, z_1) in Gamma {x, y, z | (x - x_0) / (x_1 - x_0) = (y - y_0) / (y_1 - y_0) = (z - z_0) / (z_1 - z_0)} $
$ xlongequal^(text("directrix ") Gamma: bold(r)(u) = (x(u), y(u), z(u)))
  {bold(r) | bold(r) = bold(r)_0 + v (bold(r)(u) - bold(r)_0), quad u, v in bb(R)} $
$ xlongequal^(text("parametric form"))
  {x, y, z | cases(
    x = x_0 + v (x(u) - x_0),
    y = y_0 + v (y(u) - y_0),
    z = z_0 + v (z(u) - z_0),
  ) quad u, v in bb(R)}. $

To solve the equation of a cone,
$ cases(
  (x - x_0) / (x_1 - x_0) = (y - y_0) / (y_1 - y_0) = (z - z_0) / (z_1 - z_0),
  F_1(x_1, y_1, z_1) = 0,
  F_2(x_1, y_1, z_1) = 0,
) $

#v(0.7cm)

#theorem[
  A homogeneous equation in $x, y, z$ always represents a cone with its vertex at the origin.
  That is, a homogeneous equation in $x - x_0$, $y - y_0$, $z - z_0$ always represents a cone
  with its vertex at $(x_0, y_0, z_0)$.
]


== Surfaces of Revolution // 旋转曲面

#definition(name: "Surface of Revolution")[
  In space, the surface generated by rotating a curve
  (the generatrix $Gamma: cases(F_1(x, y, z) = 0, F_2(x, y, z) = 0)$)
  around a fixed straight line
  (the axis of revolution $l: (x - x_0) / X = (y - y_0) / Y = (z - z_0) / Z$)
  is called a *surface of revolution*.

  Any point $M_1(x_1, y_1, z_1)$ on the generatrix $Gamma$ of a surface of revolution
  generates a circle upon rotation, which is called a *parallel*;
  the intersection of the surface with each half-plane bounded by $l$ is called a *meridian*.
]

Surface of revolution can be expressed as:
$ {x, y, z | F(x, y, z) = 0} $
$ = union.big_(x_1, y_1, z_1) in Gamma
  {x, y, z | cases(
    X(x - x_1) + Y(y - y_1) + Z(z - z_1) = 0,
    (x - x_0)^2 + (y - y_0)^2 + (z - z_0)^2 = (x_1 - x_0)^2 + (y_1 - y_0)^2 + (z_1 - z_0)^2,
  )} $

Taking the plane of the directrix as the coordinate plane and the axis of rotation as the coordinate axis,
the equation of the surface of revolution assumes a special form (see @fig:SurfaceOfRevolution).

#figure(
  image("img/Revolution.png", width: 40%),
  caption: [Surface of Revolution.],
  placement: auto,
  supplement: [Fig.],
) <fig:SurfaceOfRevolution>

As shown in the figure, the generatrix is
$ Gamma: cases(
  F(y, z) = 0,
  x = 0,
) $
The equation obtained by rotating around the $y$-axis is
$ F(y, plus.minus sqrt(x^2 + z^2)) = 0. $
Similarly, the equation obtained by rotating around the $z$-axis is
$ F(plus.minus sqrt(x^2 + y^2), z) = 0. $
That is: retain the coordinate that shares the name with the axis of rotation,
and express the other coordinate in the equation as the square root of the sum of the squares of the other two coordinates.
Based on this pattern of the equation for a surface of revolution,
it is also possible to determine in reverse whether an equation represents a surface of revolution.

#v(0.7cm)
Some special cases of surfaces of revolution:

*Rotate ellipse*
$ Gamma: cases(
  x^2 / a^2 + y^2 / b^2 = 1, quad (a > b),
  z = 0,
) $
- around $x$-axis (long axis): $x^2 / a^2 + y^2 / b^2 + z^2 / b^2 = 1$ (prolate spheroid)
- around $y$-axis (short axis): $x^2 / a^2 + y^2 / b^2 + z^2 / a^2 = 1$ (oblate spheroid)

(see @fig:Ellipsoids).

#figure(
  image("img/ellipse.png", width: 60%),
  caption: [Ellipsoids.],
  placement: auto,
  supplement: [Fig.],
) <fig:Ellipsoids>

*Rotate hyperbola*
$ Gamma: cases(
  y^2 / b^2 - z^2 / c^2 = 1, quad (b > c),
  x = 0,
) $
- around $y$-axis (real axis): $y^2 / b^2 - x^2 / c^2 - z^2 / b^2 = 1$
  (two-sheet hyperboloid)
- around $z$-axis (unreal axis): $x^2 / b^2 + y^2 / b^2 - z^2 / c^2 = 1$
  (one-sheet hyperboloid)

(see @fig:Hyperboloids).

#figure(
  image("img/hyperbola.png", width: 60%),
  caption: [Hyperboloids.],
  placement: auto,
  supplement: [Fig.],
) <fig:Hyperboloids>

*Rotate parabola*
$ Gamma: cases(
  y^2 = 2 p z,
  x = 0,
) $
around $z$-axis (axis of symmetry): $x^2 + y^2 = 2 p z$ (paraboloid)
(see @fig:paraboloid).

#figure(
  image("img/parabola.png", width: 20%),
  caption: [Paraboloid.],
  placement: auto,
  supplement: [Fig.],
) <fig:paraboloid>

*Rotate circle*
$ Gamma: cases(
  (y - b)^2 + z^2 = a^2 quad (b > a > 0),
  x = 0,
) $
around $z$-axis: $(x^2 + y^2 + z^2 + b^2 - a^2)^2 = 4 b^2 (x^2 + y^2)$ (torus)
(see @fig:torus).

#figure(
  image("img/circle.png", width: 50%),
  caption: [Torus.],
  placement: auto,
  supplement: [Fig.],
) <fig:torus>



// --- Chapter 5: Quadric Surfaces ---

= Quadric Surfaces // 二次曲面

== Ellipsoids // 椭球面

In space rectangular Cartesian coordinates,
the surface represented by the equation
$ x^2 / a^2 + y^2 / b^2 + z^2 / c^2 = 1 quad (a, b, c > 0) $
is called an ellipsoid or an ellipsoidal surface,
and the equation is called the standard equation.

The parametric equations of the ellipsoid are:
$ cases(
  x = a cos theta cos psi,
  y = b cos theta sin psi,
  z = c sin theta,
) quad -pi / 2 <= theta <= pi / 2, quad 0 <= psi <= 2 pi. $

Any ellipsoid with two equal axes is necessarily a spheroid,
and an ellipsoid with three equal axes is a sphere.

The surface can be studied by *the method of parallel sections*, i.e.,
by using the cross-sections of parallel planes to study the shape of the surface.

Use a set of parallel planes $z = h$ to section the ellipsoid (@fig:Ellipsoid1), i.e.,
$ {x, y, z | F(x, y, z) = 0} =
  union.big_(-h <= z <= h) {x, y | x^2 / a^2 + y^2 / b^2 = 1 - h^2 / c^2}. $
Obviously, when $abs(h) = c$, the section is a point;
when $abs(h) < c$, the section is an ellipse.
The other two methods of sectioning are similar.

#figure(
  image("img/Ellipsoid.png", width: 50%),
  caption: [Ellipsoid.],
  placement: auto,
  supplement: [Fig.],
) <fig:Ellipsoid1>

== Hyperboloids // 双曲面

In space rectangular Cartesian coordinates,
the surface represented by the equation
$ x^2 / a^2 + y^2 / b^2 - z^2 / c^2 = 1 quad (a, b, c > 0) $
is called a one-sheet hyperboloid.

#set enum(numbering: "i.")
+ Use a set of parallel planes $z = h$ to section the one-sheet hyperboloid (@fig:OneSheetHyperboloid), i.e.,
  $ {x, y, z | F(x, y, z) = 0} =
    union.big_(-oo < z < oo) {x, y | x^2 / a^2 + y^2 / b^2 = 1 + h^2 / c^2}. $
  The section is always an ellipse.

  #figure(
    image("img/one-sheet-hyperboloid1.png", width: 20%),
    caption: [One-sheet hyperboloid.],
    placement: auto,
    supplement: [Fig.],
  ) <fig:OneSheetHyperboloid>

+ Use a set of parallel planes $y = h$ to section the one-sheet hyperboloid (@fig:OneSheetHyperboloid2),
  the section is
  $ cases(
    x^2 / a^2 + z^2 / c^2 = 1 - h^2 / b^2,
    y = h,
  ) $
  When $abs(h) < b$, the section is a hyperbola; \
  when $abs(h) = b$, the section is two parallel lines, i.e.,
  $ cases(
    x / a plus.minus z / c = 0,
    y = b,
  ) $
  or
  $ cases(
    x / a plus.minus z / c = 0,
    y = -b,
  ) $
  when $abs(h) > b$, the section is a hyperbola.

  #figure(
    image("img/one-sheet-hyperboloid2.png", width: 50%),
    caption: [One-sheet hyperboloid.],
    placement: auto,
    supplement: [Fig.],
  ) <fig:OneSheetHyperboloid2>

#set enum(numbering: "1.")

In space rectangular Cartesian coordinates,
the surface represented by the equation
$ x^2 / a^2 + y^2 / b^2 - z^2 / c^2 = -1 quad (a, b, c > 0) $
is called a two-sheet hyperboloid.

#v(0.7cm)
Use a set of parallel planes $z = h$ ($abs(h) >= c$) to section the two-sheet hyperboloid (@fig:TwoSheetHyperboloid),
the section is
$ cases(
  x^2 / a^2 + y^2 / b^2 = 1 + h^2 / c^2,
  z = h,
) $
When $abs(h) > c$, the section is an ellipse; \
when $abs(h) = c$, the section is a point.

#figure(
  image("img/two-sheet-hyperbloid.png", width: 20%),
  caption: [Two-sheet hyperboloid.],
  placement: auto,
  supplement: [Fig.],
) <fig:TwoSheetHyperboloid>

== Paraboloids // 抛物面

In space rectangular Cartesian coordinates,
the surface represented by the equation
$ x^2 / a^2 + y^2 / b^2 = 2 z quad (a, b > 0) $
is called an elliptic paraboloid.

#set enum(numbering: "i.")
+ Use a set of parallel planes $z = h$ ($h >= 0$) to section the elliptic paraboloid.
  When $h > 0$, the section is an ellipse; \
  when $h = 0$, the section is a point.
+ Use a set of parallel planes $y = h$ to section the elliptic paraboloid (@fig:EllipticParaboloid),
  the section is a parabola, whose equation is
  $ cases(
    x^2 = 2 a^2 (z - h / (2 b^2)),
    y = h,
  ) $

  #figure(
    image("img/elliptic-paraboloid.png", width: 30%),
    caption: [Elliptic paraboloid.],
    placement: auto,
    supplement: [Fig.],
  ) <fig:EllipticParaboloid>

#set enum(numbering: "1.")

#v(0.7cm)
In space rectangular Cartesian coordinates,
the surface represented by the equation
$ x^2 / a^2 - y^2 / b^2 = 2 z quad (a, b > 0) $
is called a hyperbolic paraboloid, or a saddle surface.

+ Use a set of parallel planes $z = h$ to section the hyperbolic paraboloid (@fig:HyperbolicParaboloid1).
  When $h != 0$, the section is a hyperbola
  $ cases(
    x^2 / (2 a^2 h) - y^2 / (2 b^2 h) = 1,
    z = h,
  ) $
  and if $h > 0$, the real axis of hyperbola is parallel to the $x$-axis;
  if $h < 0$, the real axis of hyperbola is parallel to the $y$-axis; \
  when $h = 0$, the section is two lines intersecting at the origin, i.e.,
  $ cases(
    x / a plus.minus y / b = 0,
    z = 0,
  ) $

  #figure(
    image("img/hyperbolic-paraboloid1.png", width: 30%),
    caption: [Hyperbolic paraboloid.],
    placement: auto,
    supplement: [Fig.],
  ) <fig:HyperbolicParaboloid1>

+ Use a set of parallel planes $y = h$ to section the hyperbolic paraboloid (@fig:HyperbolicParaboloid2),
  the section is a parabola, whose equation is
  $ cases(
    x^2 = 2 a^2 (z + h / (2 b^2)),
    y = h,
  ) $

  #figure(
    image("img/hyperbolic-paraboloid2.png", width: 30%),
    caption: [Hyperbolic paraboloid section.],
    placement: auto,
    supplement: [Fig.],
  ) <fig:HyperbolicParaboloid2>

== Ruled Surfaces // 直纹面

#definition(name: "Ruled Surface")[
  In space, the surface generated by a family of straight lines is called a *ruled surface*,
  such a family of straight lines is called a family of *straight generatrices* of the surface.
]

#proposition[
  + One-sheet hyperboloid and hyperbolic paraboloid are ruled surfaces.
  + For any point on a one-sheet hyperboloid or hyperbolic paraboloid,
    there is exactly one straight line from each of the two families of straight generatrices
    that passes through the point.
  + Any two straight generatrices from different families on a hyperboloid of one sheet must be coplanar,
    while any two straight generatrices from different families on a hyperbolic paraboloid must intersect.
  + Any two straight generatrices of the same family on a one-sheet hyperboloid or a hyperbolic paraboloid
    are always skew lines,
    and all straight generatrices of the same family on a hyperbolic paraboloid are parallel to the same plane.
]

#figure(
  image("img/ruled-surface1.png", width: 50%),
  caption: [One-sheet hyperboloid.],
  placement: auto,
  supplement: [Fig.],
) <fig:RuledSurface1>

#figure(
  image("img/ruled-surface2.png", width: 50%),
  caption: [Hyperbolic paraboloid.],
  placement: auto,
  supplement: [Fig.],
) <fig:RuledSurface2>


// --- Chapter 6: Conic Sections ---

= Conic Sections // 圆锥曲线

== General Equation of Conic Sections // 圆锥曲线的一般方程

#definition(name: "Conic Section")[
  A *conic section* (or *conic*) is a curve in $bb(R)^2$ described by a general
  quadratic equation in two variables:
  $ a_(11) x^2 + 2 a_(12) x y + a_(22) y^2 + 2 a_1 x + 2 a_2 y + a_0 = 0, $
  where $a_(11), a_(22), a_(12)$ are not all zero.
  The set of all conic sections is called *quadric curves*.
] <def:conic-section>

The equation above can be written in matrix form as
#eq[
  bold(x)^T A bold(x) + 2 bold(b)^T bold(x) + a_0 = 0,
] <eq:conic-general>
where
$ A = mat(a_(11), a_(12); a_(12), a_(22)), quad
  bold(b) = mat(a_1; a_2), quad
  bold(x) = mat(x; y). $

#note[
  The matrix $A$ is a real symmetric $2 times 2$ matrix, hence orthogonally diagonalizable.
  This fact underlies the simplification method of §6.4 and is treated in the *Algèbre Linéaire* note
  (chapter on quadratic forms and spectral theorem).
]

#theorem(name: "Dandelin's Theorem")[
  The intersection of a right circular cone with a plane that does not pass through the vertex
  is a conic section. Specifically:
  - If the plane intersects only one nappe and is not parallel to a generator, the curve is an *ellipse*
    (a *circle* when the plane is perpendicular to the axis).
  - If the plane is parallel to exactly one generator, the curve is a *parabola*.
  - If the plane intersects both nappes, the curve is a *hyperbola*.
] <thm:dandelin>

#proof[
  The proof uses *Dandelin spheres*: spheres inscribed in the cone and tangent to the cutting plane.
  The tangent point of a Dandelin sphere with the plane is a *focus* of the conic;
  the intersection of the cone's base plane with the cutting plane is the corresponding *directrix*.
  One shows that the ratio of distances from any point on the curve to the focus and to the directrix
  is constant (the *eccentricity* $e$), which recovers the focus-directrix definition of conics.
  The three cases (ellipse, parabola, hyperbola) correspond to $e < 1$, $e = 1$, $e > 1$ respectively.
  The full geometric argument is omitted here.
]

#figure(
  image("img/ConicRelation.png", width: 80%),
  caption: [Five types of conic sections: circle, ellipse, parabola, hyperbola, and degenerate cases.],
  placement: auto,
  supplement: [Fig.],
) <fig:conic-relation>

== Standard Forms of Conic Sections // 圆锥曲线的标准方程

Using the focus-directrix definition, or equivalently via the matrix diagonalization of
@eq:conic-general, every non-degenerate conic section can be reduced to one of three
standard forms under a suitable rotation and translation of the coordinate axes.
The three standard forms correspond to ellipses, hyperbolas, and parabolas.

#figure(
  image("img/conic-standard-forms.svg", width: 80%),
  caption: [Standard forms of the three non-degenerate conic sections: ellipse, hyperbola, and parabola.],
  placement: auto,
  supplement: [Fig.],
) <fig:standard-forms>

=== Ellipse // 椭圆

#definition(name: "Ellipse")[
  An *ellipse* with semi-major axis $a$ and semi-minor axis $b$ ($a > b > 0$)
  is the locus of points $(x, y)$ satisfying the *standard equation*:
  #eq[
    x^2 / a^2 + y^2 / b^2 = 1.
  ] <eq:ellipse-standard>

  The ellipse has:
  - *Center*: the origin $O$.
  - *Foci*: $F_(plus.minus 1) = (plus.minus c, 0)$, where $c = sqrt(a^2 - b^2)$.
  - *Eccentricity*: $e = c / a$ with $0 < e < 1$.
  - *Directrices*: $x = plus.minus a^2 / c = plus.minus a / e$.
] <def:ellipse>

#property(name: "Properties of the Ellipse")[
  For the ellipse @eq:ellipse-standard:
  - The sum of distances from any point on the ellipse to the two foci is constant: $|P F_1| + |P F_2| = 2a$.
  - The vertices are at $(plus.minus a, 0)$ and $(0, plus.minus b)$.
  - When $a = b$, the ellipse degenerates into a circle of radius $a$.
] <prop:ellipse-standard>

#example(name: "Standard form of an ellipse")[
  Identify the type, center, foci, and eccentricity of the curve $4 x^2 + 9 y^2 - 36 = 0$.
  <ex:ellipse-standard>

  #solution[
    Divide both sides by $36$:
    $ x^2 / 9 + y^2 / 4 = 1, $
    which matches @eq:ellipse-standard with $a = 3$, $b = 2$.
    The curve is an ellipse centered at the origin with
    $c = sqrt(9 - 4) = sqrt(5)$,
    foci $F_(plus.minus 1) = (plus.minus sqrt(5), 0)$,
    and eccentricity $e = sqrt(5) / 3$.
  ]
]

=== Hyperbola // 双曲线

#definition(name: "Hyperbola")[
  A *hyperbola* with semi-transverse axis $a > 0$ and semi-conjugate axis $b > 0$
  is the locus of points $(x, y)$ satisfying the *standard equation*:
  #eq[
    x^2 / a^2 - y^2 / b^2 = 1.
  ] <eq:hyperbola-standard>

  The hyperbola has:
  - *Center*: the origin $O$.
  - *Foci*: $F_(plus.minus 1) = (plus.minus c, 0)$, where $c = sqrt(a^2 + b^2)$.
  - *Eccentricity*: $e = c / a > 1$.
  - *Asymptotes*: the two lines $y = plus.minus (b / a) x$.
  - *Directrices*: $x = plus.minus a^2 / c = plus.minus a / e$.
] <def:hyperbola>

#property(name: "Properties of the Hyperbola")[
  For the hyperbola @eq:hyperbola-standard:
  - The difference of distances from any point on the hyperbola to the two foci is constant:
    $abs(|P F_1| - |P F_2|) = 2a$.
  - The vertices are at $(plus.minus a, 0)$.
  - The hyperbola has two branches, each approaching the asymptotes $y = plus.minus (b / a) x$ as $x -> plus.minus infinity$.
] <prop:hyperbola-standard>

#example(name: "Asymptotes of a hyperbola")[
  Find the asymptotes and foci of the hyperbola $9 x^2 - 16 y^2 = 144$.
  <ex:hyperbola-asymptote>

  #solution[
    Divide by $144$:
    $ x^2 / 16 - y^2 / 9 = 1, $
    so $a = 4$, $b = 3$. The asymptotes are $y = plus.minus (3 / 4) x$.
    The foci are at $c = sqrt(16 + 9) = 5$, i.e., $F_(plus.minus 1) = (plus.minus 5, 0)$.
  ]
]

=== Parabola // 抛物线

#definition(name: "Parabola")[
  A *parabola* with focal parameter $p > 0$ is the locus of points $(x, y)$ satisfying
  the *standard equation*:
  #eq[
    y^2 = 2 p x.
  ] <eq:parabola-standard>

  The parabola has:
  - *Vertex*: the origin $O$.
  - *Focus*: $F = (p / 2, 0)$.
  - *Directrix*: $x = -p / 2$.
  - *Eccentricity*: $e = 1$.
  - *Axis of symmetry*: the $x$-axis.
] <def:parabola>

#property(name: "Properties of the Parabola")[
  For the parabola @eq:parabola-standard:
  - The distance from any point on the parabola to the focus equals its distance to the directrix.
  - The parabola opens to the right (for $p > 0$) or to the left (for $p < 0$).
  - Other standard orientations: $x^2 = 2 p y$ (axis along $y$-axis, focus at $(0, p/2)$).
] <prop:parabola-standard>

#note[
  The three conic types are unified by the *focus-directrix definition*:
  the locus of points where the ratio of distances to a focus and a directrix
  equals a constant $e$ (the eccentricity):
  - $0 < e < 1$: ellipse
  - $e = 1$: parabola
  - $e > 1$: hyperbola
]

== Conic Sections and Lines // 圆锥曲线与直线

=== Intersection // 相交

#property(name: "Line-Conic Intersection")[
  To find the intersection of a line
  $ x = x_0 + t l, quad y = y_0 + t m quad (t in bb(R)) $
  with a conic @eq:conic-general, substitute the parametric equations into the conic equation
  and obtain a quadratic in $t$:
  $ a_t t^2 + b_t t + c_t = 0. $
  The discriminant $Delta = b_t^2 - 4 a_t c_t$ determines the number of intersection points:
  - $Delta > 0$: two distinct intersection points (secant line);
  - $Delta = 0$: one intersection point of multiplicity two (tangent line);
  - $Delta < 0$: no real intersection points (exterior line).
] <prop:line-intersection>

=== Tangent Lines // 切线

#definition(name: "Tangent Line")[
  A line $ell$ is a *tangent line* to a conic at a point $P_0$ on the conic
  if $ell$ intersects the conic at $P_0$ with multiplicity two (i.e., $Delta = 0$).
] <def:tangent-line>

#theorem(name: "Tangent Line Equation")[
  Let $P_0(x_0, y_0)$ be a point on a conic. The *tangent line* to the conic at $P_0$
  is obtained from the conic equation by the *substitution rule*:
  - Replace $x^2 -> x x_0$, $y^2 -> y y_0$, $x y -> (x y_0 + y x_0) / 2$,
    $x -> (x + x_0) / 2$, $y -> (y + y_0) / 2$.
] <thm:tangent-condition>

#proof[
  The substitution rule follows from the fact that the tangent is the *polar line* of $P_0$ with respect to the conic.
  Algebraically, translating the origin to $P_0$ via $x = x_0 + u$, $y = y_0 + v$ and expanding the conic equation,
  the linear terms vanish because $P_0$ lies on the conic;
  the remaining linear approximation $alpha u + beta v = 0$ gives the tangent direction.
  Re-substituting $u = x - x_0$, $v = y - y_0$ yields the substitution rule.
]

#example(name: "Tangent to an ellipse")[
  Find the tangent line to the ellipse $x^2 / 4 + y^2 / 9 = 1$ at $P_0(1, 3 sqrt(3) / 2)$.
  <ex:tangent-line>

  #solution[
    Apply the substitution rule to $x^2 / 4 + y^2 / 9 = 1$ at $P_0(1, 3 sqrt(3) / 2)$:
    $ (x dot 1) / 4 + (y dot (3 sqrt(3) / 2)) / 9 = 1, $
    i.e.,
    $ x / 4 + (sqrt(3) y) / 6 = 1. $
    Multiplying by $12$: $3 x + 2 sqrt(3) y - 12 = 0$.
  ]
]

#figure(
  image("img/tangent-construction.svg", width: 50%),
  caption: [Tangent line to an ellipse at a point $P_0$.],
  placement: auto,
  supplement: [Fig.],
) <fig:tangent-construction>

== Simplification of Conic Equations // 圆锥曲线方程的化简

A general conic @eq:conic-general can be simplified through a *coordinate transformation*
consisting of a *rotation* (to eliminate the cross term $x y$) followed by a *translation*
(to eliminate the linear terms). The result is one of the standard forms of §6.2.

=== Rotation: Eliminating the Cross Term // 旋转变换：消交叉项

Under a rotation of the coordinate axes by angle $theta$,
$ x = x' cos theta - y' sin theta, quad y = x' sin theta + y' cos theta, $
the cross term $2 a_(12) x y$ is eliminated when
$ cot 2 theta = (a_(11) - a_(22)) / (2 a_(12)). $
After rotation, the equation becomes
$ a'_(11) (x')^2 + a'_(22) (y')^2 + 2 a'_1 x' + 2 a'_2 y' + a_0 = 0, $
with no $x' y'$ term.

#note[
  The rotation angle $theta$ is determined by the eigenvalues of the matrix $A$;
  the new coefficients $a'_(11), a'_(22)$ are precisely these eigenvalues.
  This is the geometric content of the spectral theorem for symmetric matrices
  (see *Algèbre Linéaire*, chapter on the spectral theorem).
]

=== Translation: Eliminating Linear Terms // 平移变换：消一次项

After rotation, if $a'_(11) a'_(22) != 0$ (the central conic case), a translation
$ x' = x'' + h, quad y' = y'' + k $
eliminates the linear terms, yielding
$ a'_(11) (x'')^2 + a'_(22) (y'')^2 + f = 0. $
If one of $a'_(11), a'_(22)$ is zero (the parabolic case), a single translation
eliminates one linear term and reduces the other, yielding $a (y'')^2 + 2 p x'' = 0$.

=== Invariant Method // 不变量判别法

#definition(name: "Orthogonal Invariants")[
  The following three quantities are invariant under rotations and translations
  of the coordinate system, and are called the *orthogonal invariants* of the conic:
  $ I_1 = a_(11) + a_(22), quad I_2 = mat(delim: "|", a_(11), a_(12); a_(12), a_(22)), quad
    I_3 = mat(delim: "|", a_(11), a_(12), a_1; a_(12), a_(22), a_2; a_1, a_2, a_0). $
] <def:invariants>

#theorem(name: "Classification by Invariants")[
  The type of a non-degenerate conic @eq:conic-general is determined by the signs of
  $I_2$ and $I_3$:
  #table(
    columns: (auto, auto, auto, 1fr),
    align: (center, center, center, left),
    table.header[*$I_2$*][*$I_3$*][*Type*][*Standard form*],
    [$> 0$], [$!= 0$], [Ellipse], [$x^2 / a^2 + y^2 / b^2 = 1$],
    [$< 0$], [$!= 0$], [Hyperbola], [$x^2 / a^2 - y^2 / b^2 = 1$],
    [$= 0$], [$!= 0$], [Parabola], [$y^2 = 2 p x$],
  )
  When $I_3 = 0$ the conic degenerates into a point, a pair of lines, or the empty set.
] <thm:classification-by-invariants>

#example(name: "Simplifying a conic equation")[
  Identify the type and simplify the equation
  $ 5 x^2 - 6 x y + 5 y^2 + 22 x - 22 y + 28 = 0. $
  <ex:simplification>

  #solution[
    Read off the coefficients: $a_(11) = 5$, $a_(12) = -3$, $a_(22) = 5$,
    $a_1 = 11$, $a_2 = -11$, $a_0 = 28$.

    Compute the invariants:
    $ I_1 = 5 + 5 = 10, $
    $ I_2 = mat(delim: "|", 5, -3; -3, 5) = 25 - 9 = 16 > 0, $
    $ I_3 = mat(delim: "|", 5, -3, 11; -3, 5, -11; 11, -11, 28) = 5(140 - 121) + 3(-84 + 121) + 11(33 - 55) = 95 - 141 - 242 = -288 != 0. $

    Since $I_2 > 0$ and $I_3 != 0$, the conic is an *ellipse*.

    The rotation angle satisfies $cot 2 theta = (5 - 5) / (2 dot (-3)) = 0$,
    so $2 theta = pi / 2$, $theta = pi / 4$.
    After the rotation $x = (x' - y') / sqrt(2)$, $y = (x' + y') / sqrt(2)$
    and a subsequent translation, the equation reduces to
    $ (x')^2 / 4 + (y')^2 / 36 = 1. $
  ]
]

#bibliography("references.bib")
