#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Électrodynamique",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Électrodynamique",
  "Violet",
  subtitle: "A notebook for electrodynamics",
  institute: "Notiz Physique",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This is a notebook for electrodynamics.",
)

#make-outline(depth: 2, title: "Contents")


#part("Mathematical Foundations") // 数学基础

= Vector Analysis and Field Theory // 矢量分析与场论

== Divergence and Curl // 散度与旋度
// 在物理中, 我们通常只考虑三维空间中的矢量场, 下面给出场的定义
In physics, we typically focus on vector fields in three-dimensional space $RR^3 subset Omega$. A *vector field* / *scalar field* assigns a vector/scalar to every point in space, and it can represent various physical quantities such as velocity, force, or electromagnetic fields/temperature, pressure, etc.

If a field does not explicitly depend on time, we call it a *static field*; otherwise, it is a *time-varying field*.

// 显然, 任何 Omega 上的三元函数都可以看作其上的一个标量场. 若其有连续偏导数, 则其梯度 xxx 为一个矢量场, 称之为一个梯度场.
Obviously, any scalar function $f(x, y, z)$ defined on $Omega$ can be considered a scalar field. If it has continuous partial derivatives, its gradient 
$
gradient f = bold("grad") f = ( (partial f)/(partial x), (partial f)/(partial y), (partial f)/(partial z) )
$ 
is a vector field, known as a *gradient field*.

Let
$
  bold(a) = P(x, y, z) bold(i) + Q(x, y, z) bold(j) + R(x, y, z) bold(k), quad (x, y, z) in Omega,
$
be a vector field defined on $Omega$ and $P, Q, R in C^1(Omega)$.


=== Flux and Divergence
// 为了判定场中的点是源还是汇, 以及源的强弱和汇的大小, 我们引入通量和散度.
To determine whether a point is a source or a sink, and to determine the strength and size of the source and sink, we introduce flux and divergence.

#definition(name: "Divergence")[
Let $harpoon(Sigma)$ be an oriented surface in $Omega$, then the *flux* of $bold(a)$ through $harpoon(Sigma)$ is defined as
$
  Phi = integral_harpoon(Sigma) bold(a) dot dif bold(Sigma) = integral_harpoon(Sigma) (P dif y dif z + Q dif z dif x + R dif x dif y) dif bold(Sigma).
$
Let $M$ be a point in $Omega$, then the *divergence* of $bold(a)$ at $M$ is defined as
$
  "div" bold(a)(M) = (partial P)/(partial x) (M) + (partial Q)/(partial y) (M) + (partial R)/(partial z) (M),
$
denoted as $div bold(a)$. 
]
If $"div" bold(a) > 0$, we say that $M$ is a *source* of the field; if $"div" bold(a) < 0$, we say that $M$ is a *sink* of the field; if $"div" bold(a) = 0$, we say that $M$ is a *saddle point* of the field; if $"div" bold(a) = 0$ for all points in $Omega$, we say that $bold(a)$ is a *solenoidal field*.

#theorem[
  The divergence of $bold(a)$ is the rate of change of the flux of $bold(a)$ regarding the volume of $harpoon(Sigma)$, i.e.,
$
  "div" bold(a)(M) = lim_(V -> 0)  (integral.double_Sigma bold(a) dot dif bold(Sigma)) / V.
$
]

// 向量线
Let $Gamma$ be a curve in $Omega$. If $bold(a)$ is a vector field defined on $Omega$, then the *vector line* of $bold(a)$ is defined as the curve $Gamma$ such that at every point on $Gamma$, the tangent vector of $Gamma$ is parallel to $bold(a)$. The electric field lines, magnetic field lines and electromagnetic field lines are all examples of vector lines.

=== Circulation and Curl // 环量与旋度
To determine whether a field is irrotational or solenoidal, we introduce circulation and curl.
#definition(name: "Curl")[
Let $harpoon(Gamma)$ be an oriented curve in $Omega$, then the *circulation* of $bold(a)$ through $harpoon(Gamma)$ is defined as

$

  Zeta = integral_harpoon(Gamma) bold(a) times dif bold(Gamma).

$

Let $M$ be a point in $Omega$, then the *curl* of $bold(a)$ at $M$ is defined as

$

  "curl" bold(a)(M) = ((partial R)/(partial y) - (partial Q)/(partial z)) (M) - ((partial P)/(partial x) - (partial R)/(partial z)) (M) + ((partial Q)/(partial x) - (partial P)/(partial y)) (M),

$

denoted as $"curl" bold(a)$ or $"rot" bold(a)$.
]

If $"curl" bold(a) = bold(0)$ for all points in $Omega$, we say that $bold(a)$ is an *irrotational field*; if $"curl" bold(a) = bold(0)$, we say that $bold(a)$ is a *solenoidal field*.

#theorem[
]

=== Hamilton's Operator // 哈密尔顿算子
The *Hamilton's operator* is defined as
$
  nabla = bold(i) (partial)/(partial x) + bold(j) (partial)/(partial y) + bold(k) (partial)/(partial z),
$
where $nabla$ is called the *del operator* or *nabla operator*.

With the Hamilton's operator, we can express the gradient, divergence and curl of a vector field in a compact form:
$
  gradient f = ((partial f)/(partial x), (partial f)/(partial y), (partial f)/(partial z)) = bold("grad") f,
$
$
  nabla dot f = (partial P)/(partial x) + (partial Q)/(partial y) + (partial R)/(partial z) = bold("div") bold(a),
$
$
  nabla times f = ((partial R)/(partial y) - (partial Q)/(partial z)) bold(i) - ((partial P)/(partial x) - (partial R)/(partial z)) bold(j) + ((partial Q)/(partial x) - (partial P)/(partial y)) bold(k) = bold("curl") a.
$
Obviously, we have the following identities:
$
  nabla dot nabla f = nabla dot (gradient f) = "div" (gradient f) = Delta f,
$
where $Delta f$ is the *Laplace operator*.
Functions satisfying the *Laplace equation*
$
Delta f = (partial^2 f)/(partial x^2) + (partial^2 f)/(partial y^2) + (partial^2 f)/(partial z^2) = 0.
$
are called *harmonic functions*.

== Conservative Fields and Potential Functions // 保守场与势函数
#definition(name: "Potential Function and Conservative Field")[ // 有势场与势函数
Let 
$
bold(a) = (P, Q, R), quad P, Q, R in C(Omega),
$ 
be a vector field defined on $Omega$.

If there exists a scalar field $U$ such that $bold(a) = gradient U$, then we say that $bold(a)$ is a *potential field* and $V=-U$ is the *potential function* of $bold(a)$.

In the filed $bold(a)$, if the curve integral is independent of the path, i.e., for any two curves $Gamma_1$ and $Gamma_2$ connecting the same two points in $Omega$, we have
$
  integral_harpoon(Gamma_1) bold(a) = integral_harpoon(Gamma_2) bold(a).
$
Then we say that $bold(a)$ is a *conservative field*.
]

#theorem[
Let 
$
bold(a) = (P, Q, R), quad P, Q, R in C^1(Omega),
$ 
be a vector field defined on simply connected region $Omega$.
The following statements are equivalent:
1. $bold(a)$ is a conservative field.
2. $bold(a)$ is a potential field.
3. $bold(a)$ is an irrotational field, i.e., $"curl" bold(a) = bold(0)$.
]


== Helmholtz Decomposition Theorem  // 亥姆霍兹分解定理

== Curvilinear Coordinates // 曲线坐标系

== Dirac Delta Function // 狄拉克δ函数

= Tensor Analysis // 张量分析
== Definition and Representation of Cartesian Tensors // 笛卡尔张量的定义与表示
== Tensor Algebraic Operations and Contraction // 张量代数运算与缩并
== Symmetric and Antisymmetric Tensors // 对称与反对称张量
== Principal Axis Transformation and Eigenvalues // 主轴变换与特征值
== Moment of Inertia Tensor and Stress Tensor // 惯性矩张量与应力张量
== Electromagnetic Field Tensors in Electrodynamics // 电动力学中的电磁场张量


#part("Electrostatics") // 静电学
= Electrostatic Field // 静电场
== Coulomb's Law // 库仑定律

The study of electrostatics originated from the ancient observation of amber attracting light objects when rubbed. In the 18th century, Charles-Augustin de Coulomb conducted a series of experiments using a torsion balance (扭秤) to measure the electrostatic force between charged spheres, leading to the formulation of the law that now bears his name.

// 电荷的基本性质：同号相斥、异号相吸
Electric charges exhibit two fundamental properties:
- Like charges repel each other; opposite charges attract each other.
- Charge is quantized in units of the elementary charge $e = 1.602176634 times 10^(-19) "C"$.
- The SI unit of electric charge is the *coulomb* (C).

=== Mathematical Formulation // 库仑定律的数学表述

#definition(name: "Coulomb's Law")[
  The *Coulomb's law* states that the electrostatic force $bold(F)$ between two point charges $q_1$ and $q_2$ separated by a distance $r$ in vacuum is given by
  $
    bold(F)_(12) = k frac(q_1 q_2, r^2) hat(r)_(12),
  $
  where $k$ is the Coulomb's constant, $hat(r)_(12)$ is the unit vector pointing from charge $q_2$ to $q_1$, and $bold(F)_(12)$ is the force exerted on $q_2$ by $q_1$.
]

In SI units, the Coulomb's constant is given by
$
k = 8.9875517873681764 times 10^9 "N" dot "m"^2 dot "C"^(-2).
$

For convenience, we often express Coulomb's constant in terms of the *permittivity of free space* $epsilon_0$:
$
k = frac(1, 4 pi epsilon_0),
$
where
$
epsilon_0 = 8.854187817 times 10^(-12) "C"^2 dot "N"^(-1) dot "m"^(-2).
$

#note[
  The inverse-square nature of Coulomb's law has been experimentally verified to high precision. The exponent $2$ is accurate to within $10^(-16)$, i.e., $F prop r^(-(2 plus.minus delta))$ with $delta << 1$. This remarkable precision has deep theoretical significance — any deviation from the exact inverse-square law would imply a nonzero photon mass.
]

#note[
  Coulomb's law bears a striking resemblance to Newton's law of universal gravitation: both are inverse-square central forces. However, there are crucial differences:
  - Gravitational forces are always attractive, while electrostatic forces can be attractive or repulsive.
  - The gravitational constant $G$ is independent of the medium, while the effective Coulomb constant depends on the permittivity of the surrounding medium.
  - The electrostatic force between two protons is about $10^36$ times stronger than the gravitational force between them.
]

=== Superposition Principle // 库仑力的叠加原理

#theorem(name: "Superposition Principle for Electrostatic Forces")[
  The total electrostatic force on a point charge $q_i$ due to a system of $N$ point charges $q_1, q_2, ..., q_N$ is the vector sum of the individual forces exerted by each charge:
  $
    bold(F)_i = sum_(j != i) frac(1, 4 pi epsilon_0) frac(q_i q_j, |bold(r)_i - bold(r)_j|^2) hat(bold(r))_(i j),
  $
  where $hat(bold(r))_(i j) = (bold(r)_i - bold(r)_j) / |bold(r)_i - bold(r)_j|$ is the unit vector pointing from $q_j$ to $q_i$.
]

#note[
  The superposition principle is an empirical fact, not a logical consequence of Coulomb's law alone. It states that the presence of other charges does not alter the pairwise interaction between any two charges. This principle is the foundation upon which all of electrostatics is built.
]

Coulomb's law holds profound significance in electrodynamics:

- It is the fundamental experimental law of electrostatics, analogous to Newton's law of universal gravitation in mechanics.
- It is strictly valid only for *stationary* point charges. For moving charges, magnetic forces and relativistic corrections must be considered.
- Together with the superposition principle, Coulomb's law provides a complete framework for calculating electrostatic forces in any configuration of point charges.
- The inverse-square form is intimately connected to Gauss's law and the divergence-free nature of the electric field in free space.

== Electric Field Intensity // 电场强度

=== From Force to Field // 场的引入：从力到场

The Coulomb's law describes electrostatic interaction in the language of *action at a distance* (超距作用). Faraday, however, introduced the concept of a *field* — the idea that a charge modifies the space around it, and this modified space exerts forces on other charges.

#definition(name: "Electric Field Intensity")[
  The *electric field intensity* $bold(E)$ at a point in space is defined as the force $bold(F)$ experienced by a positive test charge $q$ placed at that point, divided by the magnitude of the test charge:
  $
    bold(E) = bold(F) / q.
  $
  The limit $q -> 0$ is implicit, ensuring that the test charge does not disturb the original field configuration.
]

The SI unit of the electric field is newtons per coulomb ($"N/C"$), equivalently volts per meter ($"V/m"$).

=== Field of a Point Charge and Discrete Charge Systems // 点电荷与点电荷系的电场

From Coulomb's law, the electric field produced by a single point charge $q$ located at $bold(r)'$ is
$
  bold(E)(bold(r)) = frac(1, 4 pi epsilon_0) frac(q, |bold(r) - bold(r)'|^2) hat(bold(r) - bold(r)').
$

For a system of $N$ point charges, the total electric field at $bold(r)$ is the vector sum (superposition) of the fields due to each charge:
$
  bold(E)(bold(r)) = frac(1, 4 pi epsilon_0) sum_(i=1)^N frac(q_i, |bold(r) - bold(r)_i|^2) hat(bold(r) - bold(r)_i).
$

=== Continuous Charge Distributions // 连续分布电荷的电场

For a continuous charge distribution, the summation over discrete charges is replaced by integration. The charge distribution can be described by three types of density:

- *Volume charge density* $rho(bold(r)')$ (charge per unit volume)
- *Surface charge density* $sigma(bold(r)')$ (charge per unit area)
- *Linear charge density* $lambda(bold(r)')$ (charge per unit length)

The electric field is then given by:

#definition(name: "Electric Field of Continuous Distributions")[
  For a volume charge distribution $rho(bold(r)')$:
  $
    bold(E)(bold(r)) = frac(1, 4 pi epsilon_0) integral_V frac(rho(bold(r)'), |bold(r) - bold(r)'|^2) hat(bold(r) - bold(r)') dif V'.
  $

  For a surface charge distribution $sigma(bold(r)')$:
  $
    bold(E)(bold(r)) = frac(1, 4 pi epsilon_0) integral_S frac(sigma(bold(r)'), |bold(r) - bold(r)'|^2) hat(bold(r) - bold(r)') dif S'.
  $

  For a linear charge distribution $lambda(bold(r)')$:
  $
    bold(E)(bold(r)) = frac(1, 4 pi epsilon_0) integral_L frac(lambda(bold(r)'), |bold(r) - bold(r)'|^2) hat(bold(r) - bold(r)') dif l'.
  $
]

=== Electric Field Lines // 电力线的概念

#definition(name: "Electric Field Lines")[
  *Electric field lines* (or lines of force) are curves drawn in space such that the tangent at every point is parallel to the direction of $bold(E)$ at that point. The density of lines in a region is proportional to the magnitude of the electric field.
]

#property(name: "Properties of Electric Field Lines")[
  - They originate from positive charges and terminate on negative charges.
  - They never cross each other (the field is single-valued at each point).
  - The number of lines leaving a positive charge is proportional to the magnitude of the charge.
  - In regions where the field is strong, the lines are closely spaced; where the field is weak, the lines are sparse.
]

#note[
  The electric field $bold(E)$ is a *physical field* — it exists independently of whether a test charge is present to detect it. This is the fundamental shift from the action-at-a-distance viewpoint to the field viewpoint.
]

#note[
  The superposition principle for $bold(E)$ is a direct consequence of the linearity of Coulomb's law and the superposition of forces. The transition from discrete sums to continuous integrals is justified when the number of charges is large and individual discreteness is negligible at the macroscopic scale.
]

== Gauss's Law and Electric Flux // 高斯定律与电通量

=== Electric Flux // 电通量

#definition(name: "Electric Flux")[
  The *electric flux* $Phi_E$ through a surface $S$ is defined as the surface integral of the electric field over $S$:
  $
    Phi_E = integral_S bold(E) dot dif bold(S),
  $
  where $dif bold(S) = bold(n) dif S$ is the vector area element, with $bold(n)$ being the outward unit normal to the surface.
]

Physically, the electric flux measures the "flow" of the electric field through a surface — it is proportional to the number of field lines passing through that surface. For a closed surface, positive flux indicates a net outflow of field lines (a source), while negative flux indicates a net inflow (a sink).

#example[
  Consider a uniform electric field $bold(E) = E_0 bold(e)_z$ passing through a flat surface of area $A$ oriented at an angle $theta$ with respect to the field. The flux through the surface is:
  $
    Phi_E = integral_A bold(E) dot dif A = E_0 A cos theta.
  $
  The flux is maximal when the surface is perpendicular to the field ($theta = 0$) and zero when the surface is parallel to the field ($theta = pi/2$).
]

=== Gauss's Law // 高斯定律

#theorem(name: "Gauss's Law — Integral Form")[
  The total electric flux through any closed surface $S$ (also called a *Gaussian surface*) is proportional to the total charge enclosed within that surface:
  $
    integral_harpoon(S) bold(E) dot dif bold(S) = frac(Q_"enc", epsilon_0),
  $
  where $Q_"enc" = integral_V rho(bold(r)) dif V$ is the total charge inside the volume $V$ bounded by $S$, and $epsilon_0$ is the permittivity of free space.
]

This law is one of the four Maxwell's equations. It captures the fundamental fact that electric charges are the sources (and sinks) of the electric field — positive charges produce outward flux, negative charges produce inward flux.

By applying the divergence theorem to the integral form, we obtain the local (pointwise) counterpart:

#theorem(name: "Gauss's Law — Differential Form")[
  $
    nabla dot bold(E) = frac(rho, epsilon_0),
  $
  where $rho(bold(r))$ is the volume charge density at the point in question.
]

The differential form states that the divergence of the electric field at a point is directly proportional to the charge density at that point. This is the field-theoretic expression of the fact that charges are the sources of the electric field.

#note[
  The differential form $nabla dot bold(E) = rho / epsilon_0$ holds at every point in space where the electric field is continuously differentiable. At a point charge itself, the field is singular — the correct mathematical treatment uses the Dirac delta function:
  $
    nabla dot bold(E)(bold(r)) = frac(1, epsilon_0) sum_i q_i delta^3(bold(r) - bold(r)_i).
  $
]

=== Applications of Gauss's Law // 高斯定律的应用

While Coulomb's law is the fundamental force law, Gauss's law often provides a much simpler route to computing the electric field when the charge distribution possesses sufficient symmetry. The key is to choose a Gaussian surface over which $bold(E)$ is either constant or parallel to the surface normal.

#theorem(name: "Strategy for Applying Gauss's Law")[
  To compute $bold(E)$ using Gauss's law:
  1. Identify the symmetry of the charge distribution (spherical, cylindrical, or planar).
  2. Choose a Gaussian surface that respects this symmetry.
  3. Evaluate the flux integral $integral_S bold(E) dot dif bold(S)$ — by symmetry, $|bold(E)|$ is constant on the surface.
  4. Compute the enclosed charge $Q_"enc"$.
  5. Solve for $|bold(E)|$.
]

#example(name: "Spherical Symmetry — Point Charge")[
  For a point charge $q$ at the origin, choose a spherical Gaussian surface of radius $r$ concentric with the charge. By symmetry, $bold(E)$ is radial and has constant magnitude on the sphere:
  $
    integral_S bold(E) dot dif bold(S) = E(r) dot 4 pi r^2 = frac(q, epsilon_0).
  $
  Hence $E(r) = frac(1, 4 pi epsilon_0) frac(q, r^2)$, recovering Coulomb's law from Gauss's law.
]

#example(name: "Cylindrical Symmetry — Infinite Line Charge")[
  For an infinite line charge with uniform linear density $lambda$, choose a cylindrical Gaussian surface of radius $r$ and length $L$ coaxial with the line. The flux through the end caps is zero (field is parallel to them), and the lateral surface gives:
  $
    E(r) dot 2 pi r L = frac(lambda L, epsilon_0).
  $
  Hence $E(r) = frac(lambda, 2 pi epsilon_0 r)$.
]

#example(name: "Planar Symmetry — Infinite Plane")[
  For an infinite plane with uniform surface charge density $sigma$, choose a cylindrical "pillbox" Gaussian surface that pierces the plane. By symmetry the field is perpendicular to the plane and has equal magnitude on both sides:
  $
    E dot A + E dot A = frac(sigma A, epsilon_0),
  $
  giving $E = frac(sigma, 2 epsilon_0)$ (direction away from the plane for $sigma > 0$).
]

=== Relation to Coulomb's Law // 与库仑定律的关系

#note[
  Gauss's law and Coulomb's law are mathematically equivalent *in electrostatics*, provided the charge distribution is spherically symmetric. However, Gauss's law is the more fundamental of the two — it remains valid for time-varying fields where Coulomb's law no longer applies, and it constitutes one of the four Maxwell's equations. In fact, Coulomb's law can be derived from Gauss's law combined with the curl-free condition $nabla times bold(E) = bold(0)$ of electrostatics.
]

== Electric Potential // 电势

=== Work, Energy, and the Electric Field // 功、能量与电场

In a conservative field, the work done by the field on a charge moving from point $A$ to point $B$ is independent of the path taken. This allows us to define a scalar *potential* function whose gradient gives the field.

#definition(name: "Electric Potential Difference")[
  The *electric potential difference* between two points $A$ and $B$ is defined as the negative of the line integral of the electric field from $A$ to $B$:
  $
    V(B) - V(A) = - integral_A^B bold(E) dot dif bold(l),
  $
  where $V$ is the electric potential. The SI unit of potential is the *volt* ($"V" = "J/C"$).
]

The potential difference $V(B) - V(A)$ represents the work per unit charge that must be done by an external agent to move a test charge from $A$ to $B$ against the electric field.

#note[
  The reference point (zero of potential) is arbitrary. In electrostatics, we conventionally set $V = 0$ at infinity, provided the charge distribution is localized. This gives the absolute potential at a point $P$ as:
  $
    V(P) = - integral_infinity^P bold(E) dot dif bold(l).
  $
]

=== Potential of a Point Charge and Superposition // 点电荷的电势与叠加

For a single point charge $q$ at the origin, the electric field is radial: $bold(E) = frac(1, 4 pi epsilon_0) frac(q, r^2) hat(bold(r))$. Choosing the radial path from infinity to $r$, we obtain:

#definition(name: "Potential of a Point Charge")[
  The electric potential at a distance $r$ from a point charge $q$ is
  $
    V(r) = frac(1, 4 pi epsilon_0) frac(q, r),
  $
  with the convention $V(infinity) = 0$.
]

For a system of point charges, the potential at a given point is the scalar sum of the potentials due to each charge — this is much easier than vector superposition of fields.

#theorem(name: "Superposition Principle for Potential")[
  For a system of $N$ point charges $q_i$ located at positions $bold(r)_i$:
  $
    V(bold(r)) = frac(1, 4 pi epsilon_0) sum_(i=1)^N frac(q_i, |bold(r) - bold(r)_i|).
  $
  For continuous distributions:
  $
    V(bold(r)) = frac(1, 4 pi epsilon_0) integral_V frac(rho(bold(r)'), |bold(r) - bold(r)'|) dif V',
  $
  with analogous expressions for surface and line distributions.
]

#note[
  The potential is a *scalar* field, making it significantly easier to compute than the vector field $bold(E)$. Once $V$ is known, the electric field can be recovered by differentiation: $bold(E) = - nabla V$. This is the standard strategy in electrostatics: first compute $V$ via scalar integration, then differentiate to obtain $bold(E)$.
]

=== Relationship Between Field and Potential // 场与势的关系

#property(name: "Fundamental Relations")[
  - The electric field is the negative gradient of the potential: $bold(E) = - nabla V$.
  - Componentwise: $E_x = -(partial V)/(partial x)$, $E_y = -(partial V)/(partial y)$, $E_z = -(partial V)/(partial z)$.
  - The curl-free condition: $nabla times bold(E) = bold(0)$ is automatically satisfied for any gradient field, reflecting the conservative nature of the electrostatic field.
]

#definition(name: "Equipotential Surfaces")[
  An *equipotential surface* is a surface on which the electric potential is constant. The electric field is everywhere perpendicular to equipotential surfaces, pointing in the direction of steepest potential decrease.
]

#example[
  For a point charge, the equipotential surfaces are concentric spheres. The field lines (radial lines) are orthogonal to these spheres at every point. This orthogonality is a general property: field lines and equipotential surfaces always intersect at right angles.
]

=== Potential Energy of Charge Systems // 电荷系统的势能

The potential energy of a charge configuration is the work required to assemble the charges from infinity to their final positions (assuming all charges start infinitely far apart).

#definition(name: "Electrostatic Potential Energy of Point Charges")[
  For a system of $N$ point charges $q_1, q_2, ..., q_N$, the total electrostatic potential energy is:
  $
    U = frac(1, 4 pi epsilon_0) sum_(i < j)^N frac(q_i q_j, |bold(r)_i - bold(r)_j|)
      = frac(1, 2) sum_(i=1)^N q_i V_i,
  $
  where $V_i = sum_(j != i) frac(1, 4 pi epsilon_0) frac(q_j, |bold(r)_i - bold(r)_j|)$ is the potential at the location of $q_i$ due to all other charges.
]

The factor $1/2$ in the second expression accounts for the double-counting of pairwise interactions in the sum over all charges. For a continuous charge distribution, the expression generalizes to:

$
  U = frac(1, 2) integral_V rho(bold(r)) V(bold(r)) dif V.
$

== Common Models: Field and Potential // 常见模型：场与势

This section serves as a quick-reference table of standard charge configurations in electrostatics with sufficient symmetry to be solved by Gauss's law or direct integration. Each entry specifies the coordinate system, symmetry type, and applicable method.

// ============================================================================
// Spherical Symmetry
// ============================================================================

=== Spherical Symmetry // 球对称模型

All spherically symmetric configurations share the property that the electric field is radial and depends only on the distance $r$ from the center: $bold(E)(bold(r)) = E(r) hat(bold(r))$. Gauss's law with a spherical Gaussian surface concentric with the charge distribution gives the solution.

#example(name: "Point Charge")[ // 点电荷
  A single point charge $q$ at the origin.
  $
    bold(E)(bold(r)) = frac(1, 4 pi epsilon_0) frac(q, r^2) hat(bold(r)),
    quad V(r) = frac(1, 4 pi epsilon_0) frac(q, r).
  $
  Reference: $V(infinity) = 0$. The field diverges as $r -> 0$.

  #figure(
    image("img/point_charge_field.png", width: 100%),
    caption: [Electric field of a point charge.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:point_charge_field>
]

#example(name: "Uniformly Charged Spherical Shell")[ // 均匀带电球面
  Radius $R$, total charge $Q$ uniformly distributed on the surface.
  $
    bold(E) = cases(
      frac(1, 4 pi epsilon_0) frac(Q, r^2) hat(bold(r)) & (r > R),
      bold(0) & (r < R),
    )
    quad
    V = cases(
      frac(1, 4 pi epsilon_0) frac(Q, r) & (r >= R),
      frac(1, 4 pi epsilon_0) frac(Q, R) & (r < R),
    )
  $
  The field inside is zero (Faraday cage principle); the interior is equipotential.

  #figure(
    image("img/charged_sphere.png", width: 100%),
    caption: [Electric field of a uniformly charged spherical shell.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:charged_sphere>
]

#example(name: "Uniformly Charged Solid Sphere")[ // 均匀带电球体
  Radius $R$, uniform volume charge density $rho = 3 Q / (4 pi R^3)$.
  $
    bold(E) = cases(
      frac(1, 4 pi epsilon_0) frac(Q, r^2) hat(bold(r)) & (r > R),
      frac(1, 4 pi epsilon_0) frac(Q r, R^3) hat(bold(r)) & (r < R),
    )
    quad
    V = cases(
      frac(1, 4 pi epsilon_0) frac(Q, r) & (r >= R),
      frac(1, 4 pi epsilon_0) frac(Q, 2 R) (3 - frac(r^2, R^2)) & (r < R),
    )
  $
  Inside the sphere the field grows linearly $E prop r$; at the center $V(0) = frac(3, 2) frac(1, 4 pi epsilon_0) frac(Q, R)$, the maximum potential.

  #figure(
    image("img/charged_solid_sphere.png", width: 100%),
    caption: [Electric field of a uniformly charged solid sphere.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:charged_solid_sphere>
]

#example(name: "Concentric Spherical Shells")[ // 同心球壳模型
  Two concentric spherical shells of radii $a$ and $b$ $(a < b)$, carrying charges $Q_a$ and $Q_b$ respectively.

  By superposition, the field in each region is the sum of contributions from both shells.
  $
    bold(E) = cases(
      frac(1, 4 pi epsilon_0) frac(Q_a + Q_b, r^2) hat(bold(r)) & (r > b),
      frac(1, 4 pi epsilon_0) frac(Q_a, r^2) hat(bold(r)) & (a < r < b),
      bold(0) & (r < a),
    )
    quad
    V = cases(
      frac(1, 4 pi epsilon_0) frac(Q_a + Q_b, r) & (r >= b),
      frac(1, 4 pi epsilon_0) (frac(Q_a, r) + frac(Q_b, b)) & (a <= r < b),
      frac(1, 4 pi epsilon_0) (frac(Q_a, a) + frac(Q_b, b)) & (r < a),
    )
  $
  The inner region ($r < a$) is always equipotential and field-free, regardless of $Q_a$ and $Q_b$.
  
  #figure(
    image("img/concentric_shells.png", width: 100%),
    caption: [Electric field of concentric spherical shells.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:concentric_shells>
]

#note[
  For any spherically symmetric charge distribution, the field at radius $r$ depends _only_ on the total charge enclosed within $r$:
  $
    bold(E)(r) = frac(1, 4 pi epsilon_0) frac(Q_"enc"(r), r^2) hat(bold(r)), quad
    Q_"enc"(r) = integral_0^r rho(r') 4 pi r'^2 dif r'.
  $
  This is a direct consequence of Gauss's law.
]

// ============================================================================
// Cylindrical Symmetry
// ============================================================================

=== Cylindrical Symmetry // 柱对称模型

Configurations invariant under translations along the $z$-axis and rotations about it. Use a coaxial cylindrical Gaussian surface of radius $rho$ and length $L$. The field is radial in cylindrical coordinates: $bold(E) = E(rho) hat(bold(rho))$.

#example(name: "Infinite Line Charge")[ // 无限长均匀带电直线
  Linear charge density $lambda$, along the $z$-axis.
  $
    bold(E)(rho) = frac(lambda, 2 pi epsilon_0 rho) hat(bold(rho)).
  $
  Potential cannot refer to $rho = infinity$ (the integral diverges). Choose a reference radius $rho_0$:
  $
    V(rho) = frac(lambda, 2 pi epsilon_0) ln frac(rho_0, rho).
  $

  #figure(
    image("img/infinite_line_charge.png", width: 100%),
    caption: [Electric field of an infinite line charge.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:infinite_line_charge>
]

#example(name: "Uniformly Charged Cylindrical Shell")[ // 均匀带电圆柱面
  Radius $R$, surface charge density $sigma$ (or linear charge density $lambda = 2 pi R sigma$), infinite along $z$.
  $
    bold(E) = cases(
      frac(lambda, 2 pi epsilon_0 rho) hat(bold(rho)) & (rho > R),
      bold(0) & (rho < R),
    )
    quad
    V = cases(
      frac(lambda, 2 pi epsilon_0) ln frac(rho_0, rho) & (rho >= R),
      frac(lambda, 2 pi epsilon_0) ln frac(rho_0, R) & (rho < R),
    )
  $
  Inside the shell the field is zero; the interior is equipotential.

  #figure(
    image("img/charged_cylindrical_shell.png", width: 100%),
    caption: [Electric field of a uniformly charged cylindrical shell.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:charged_cylindrical_shell>
]

#example(name: "Uniformly Charged Solid Cylinder")[ // 均匀带电圆柱体
  Radius $R$, uniform volume charge density $rho$ (or linear density $lambda = rho pi R^2$), infinite along $z$.
  $
    bold(E) = cases(
      frac(lambda, 2 pi epsilon_0 rho) hat(bold(rho)) & (rho > R),
      frac(rho, 2 epsilon_0) rho hat(bold(rho)) & (rho < R),
    )
  $
  Inside the cylinder the field grows linearly $E prop rho$; outside it matches the infinite line charge result.

  #figure(
    image("img/charged_solid_cylinder.png", width: 100%),
    caption: [Electric field of a uniformly charged solid cylinder.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:charged_solid_cylinder>
]

#note[
  For cylindrical symmetry, the field outside any rotationally symmetric infinite charge distribution depends only on the enclosed linear charge density $lambda$:
  $
    bold(E)(rho) = frac(lambda_"enc", 2 pi epsilon_0 rho) hat(bold(rho)), quad
    lambda_"enc" = integral_0^R rho(rho') 2 pi rho' dif rho'.
  $
]

// ============================================================================
// Axial (Rotational) Symmetry — Finite Distributions
// ============================================================================

=== Axial Symmetry: Finite Distributions // 轴对称模型：有限分布

These configurations have rotational symmetry about the $z$-axis but are finite in extent. Gauss's law is not directly applicable; the field is obtained by direct integration (superposition). Results are given on the symmetry axis.

#example(name: "Uniformly Charged Ring")[ // 均匀带电圆环
  Radius $R$, total charge $Q$, lying in the $"xy"$-plane centered at the origin.
  $
    bold(E)(z) = frac(1, 4 pi epsilon_0) frac(Q z, (z^2 + R^2)^(3/2)) hat(bold(z)),
    quad V(z) = frac(1, 4 pi epsilon_0) frac(Q, sqrt(z^2 + R^2)).
  $
  - $z >> R$ (far away): $bold(E) approx frac(1, 4 pi epsilon_0) frac(Q, z^2) hat(bold(z))$ — looks like a point charge.
  - At center $z=0$: $bold(E) = bold(0)$, $V(0) = frac(1, 4 pi epsilon_0) frac(Q, R)$.

  #figure(
    image("img/charged_ring.png", width: 100%),
    caption: [Electric field of a uniformly charged ring along its axis.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:charged_ring>
]

#example(name: "Uniformly Charged Disk")[ // 均匀带电圆盘
  Radius $R$, uniform surface charge density $sigma$, lying in the $"xy"$-plane. Obtained by integrating ring contributions radially.
  $
    bold(E)(z) = frac(sigma, 2 epsilon_0) (1 - frac(z, sqrt(z^2 + R^2))) hat(bold(z)).
  $
  - $R -> infinity$ (infinite plane): $bold(E) = frac(sigma, 2 epsilon_0) hat(bold(z))$ — uniform field!
  - $z >> R$: $bold(E) approx frac(1, 4 pi epsilon_0) frac(Q, z^2) hat(bold(z))$, where $Q = sigma pi R^2$.

  #figure(
    image("img/charged_disk.png", width: 100%),
    caption: [Electric field of a uniformly charged disk along its axis.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:charged_disk>
]

// ============================================================================
// Planar Symmetry
// ============================================================================

=== Planar Symmetry // 平面对称模型

Configurations invariant under translations parallel to the plane. The field is perpendicular to the plane. Use a cylindrical "pillbox" Gaussian surface that pierces the plane.

#example(name: "Infinite Charged Plane")[ // 无限大均匀带电平面
  Uniform surface charge density $sigma$.
  $
    bold(E) = frac(sigma, 2 epsilon_0) hat(bold(n)),
  $
  where $hat(bold(n))$ is the outward normal to the plane. The field is constant in magnitude and points away from the plane for $sigma > 0$, toward it for $sigma < 0$. Using $V=0$ at the plane:
  $
    V(z) = - frac(sigma, 2 epsilon_0) |z|.
  $

  #figure(
    image("img/charged_plane.png", width: 100%),
    caption: [Electric field of an infinite charged plane.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:infinite_plane>
]

#example(name: "Parallel-Plate Capacitor")[ // 平行板电容器
  Two infinite parallel planes with equal and opposite surface charge densities $plus.minus sigma$.
  $
    bold(E) = cases(
      frac(sigma, epsilon_0) hat(bold(n)) & (text("between the plates")),
      bold(0) & (text("outside")),
    )
  $
  The field exists only between the plates and is uniform. Potential difference across gap $d$:
  $
    Delta V = E d = frac(sigma d, epsilon_0),
    quad C = frac(Q, Delta V) = frac(epsilon_0 A, d).
  $
  This is the simplest model of a capacitor (neglecting fringe effects).

  #figure(
    image("img/parallel_plate_capacitor.png", width: 100%),
    caption: [Electric field of a parallel-plate capacitor.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:parallel_plate_capacitor>
]

// ============================================================================
// Electric Dipole
// ============================================================================

=== Electric Dipole // 电偶极子

#example(name: "Electric Dipole Field and Potential")[ // 电偶极子的场与势
  A pair $+q$ and $-q$ separated by displacement $bold(d)$, with dipole moment $bold(p) = q bold(d)$. In the far-field limit ($r >> d$), in spherical coordinates with $bold(p) = p hat(bold(z))$:
  $
    V(r, theta) = frac(1, 4 pi epsilon_0) frac(p cos theta, r^2),
    quad
    bold(E)(r, theta) = frac(1, 4 pi epsilon_0) frac(p, r^3) (2 cos theta hat(bold(r)) + sin theta hat(bold(theta))).
  $
  In Cartesian form:
  $
    bold(E)(bold(r)) = frac(1, 4 pi epsilon_0) frac(1, r^3) [3(bold(p) dot hat(bold(r))) hat(bold(r)) - bold(p)].
  $
  The field decays as $1/r^3$, faster than a point charge's $1/r^2$. The dipole serves as the fundamental building block for multipole expansions.

  #figure(
    image("img/electric_dipole.png", width: 100%),
    caption: [Electric field of an electric dipole.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:electric_dipole>
]

#note[
  *Quick-reference guide by symmetry type:*
  - *Spherical*: choose a spherical Gaussian surface concentric with the charge; $E$ is radial and constant on the surface.
  - *Cylindrical*: choose a coaxial cylindrical Gaussian surface; $E$ is radial and constant on the lateral surface; end caps contribute zero flux.
  - *Planar*: choose a cylindrical pillbox that crosses the plane; $E$ is perpendicular to the plane and constant on each end cap.
  - *Axial (finite)*: use direct integration (Coulomb's law) — Gauss's law alone is insufficient.
]

== Poisson's Equation and Laplace's Equation // 泊松方程与拉普拉斯方程

== Electrostatic Energy // 静电能 [→ Ch5]

// 静电能（静电能的一般表达式、能量密度）已在 Chapter 5 中结合电容器讨论。
// 参见 §5.5: Electrostatic Energy and Capacitors.

= Boundary Value Problems in Electrostatics // 静电学边值问题
== Uniqueness Theorems // 唯一性定理
== Method of Images // 镜像法
== Separation of Variables in Cartesian Coordinates // 直角坐标系分离变量法
== Separation of Variables in Spherical Coordinates // 球坐标系分离变量法
== Separation of Variables in Cylindrical Coordinates // 柱坐标系分离变量法
== Multipole Expansion // 多极展开

= Conductors and Dielectrics in Electrostatic Fields // 静电场中的导体与电介质

== Conductors in Electrostatic Fields // 静电场中的导体
// 静电平衡条件、电荷分布、静电屏蔽、导体存在时静电场的分析与计算

A *conductor* contains free charges (electrons in metals, ions in electrolytes) that can move freely under the influence of an electric field. In electrostatics, we consider the equilibrium state after all charges have stopped moving.

=== Conditions for Electrostatic Equilibrium // 静电平衡条件

#definition(name: "Electrostatic Equilibrium")[
  A conductor is in *electrostatic equilibrium* when there is no net motion of charge within it. Under this condition, the electric field inside the conductor must be zero everywhere:
  $
    bold(E)_"inside" = bold(0).
  $
  If $bold(E) != bold(0)$ inside, free charges would accelerate until they rearrange to cancel the field.
]

#property(name: "Properties of a Conductor in Equilibrium")[
  Let a conductor occupy region $Omega$ with boundary $partial Omega$. In electrostatic equilibrium:
  1. $bold(E) = bold(0)$ inside $Omega$.
  2. The interior is equipotential: $V = "const"$ throughout $Omega$.
  3. Any net charge resides entirely on the surface $partial Omega$; the volume charge density $rho = 0$ inside $Omega$.
  4. The electric field just outside the surface is perpendicular to the surface and satisfies
     $
       E_("just outside") = frac(sigma, epsilon_0) hat(bold(n)),
     $
     where $sigma$ is the surface charge density and $hat(bold(n))$ is the outward unit normal.
  5. The surface is an equipotential; field lines meet it at right angles.
]

#proof[
  *1-2.* $bold(E) = bold(0)$ follows from equilibrium. Since $nabla V = -bold(E)$, the potential is constant inside. The conductor's surface is therefore equipotential.

  *3.* Apply Gauss's law in differential form: $rho = epsilon_0 nabla dot bold(E)$. Inside $Omega$, $bold(E) = bold(0)$ implies $rho = 0$. Any net charge must reside on the surface as $sigma$ (charge per unit area).

  *4.* Apply Gauss's law to a Gaussian pillbox straddling the surface. The flat face inside the conductor sees $bold(E) = bold(0)$; the flat face outside sees the normal component $E_perp$. The side surface contribution vanishes in the limit of zero height. If $sigma$ is the enclosed surface charge, then
  $
    E_perp A = frac(sigma A, epsilon_0) arrow E_perp = frac(sigma, epsilon_0).
  $
  The tangential component is zero because the surface is equipotential: $E_("tan") = - (partial V)/(partial t) = 0$.
  This yields $bold(E)_"outside" = (sigma / epsilon_0) hat(bold(n))$, where $hat(bold(n))$ points outward.
]

=== Charge Distribution on Conductors // 导体上的电荷分布

The surface charge density $sigma$ is *not* uniform in general. It depends on the shape of the conductor, with higher concentrations at sharp points (large curvature).

#property(name: "Charge Distribution on a Conducting Sphere")[
  For an isolated conducting sphere of radius $R$ carrying total charge $Q$:
  $
    sigma = frac(Q, 4 pi R^2)
    quad ("uniform due to spherical symmetry"),
    bold(E)_"outside" = frac(1, 4 pi epsilon_0) frac(Q, r^2) hat(bold(r)),
    V = frac(1, 4 pi epsilon_0) frac(Q, R) quad ("for $r <= R$").
  $
]

#property(name: "Charge Concentration at Sharp Points")[
  For two connected conductors (same potential), the surface charge density is inversely proportional to the local radius of curvature $R_c$:
  $
    sigma approx frac("const", R_c).
  $
  Consequently, pointed regions ($R_c$ small) have high $sigma$, producing strong local fields that can ionise the surrounding air — the principle behind lightning rods and corona discharge.
]

=== Electrostatic Shielding (Faraday Cage) // 静电屏蔽

#theorem(name: "Faraday Cage Effect")[
  A hollow conductor (a cavity inside a conductor) shields its interior from external electrostatic fields. If there are no charges inside the cavity, the field in the cavity is zero regardless of the external field.
]

#proof[
  Consider a conductor with a cavity. Since the conductor is equipotential, the entire boundary of the cavity is at the same potential. Laplace's equation $nabla^2 V = 0$ holds inside the cavity (no charges there). The uniqueness theorem states that if $V$ is constant on the boundary, the only solution inside is $V = "const"$, giving $bold(E) = - nabla V = bold(0)$.
]

#example(name: "Point Charge Near a Grounded Conducting Sphere")[
  A point charge $q$ placed at distance $a > R$ from the centre of a grounded ($V = 0$) conducting sphere of radius $R$. The sphere acquires an induced surface charge distribution whose total is $-q R / a$.

  This problem is solved by the *method of images* (Chapter 4, §4.2): a fictitious image charge $q' = -q R / a$ placed inside the sphere at distance $b = R^2 / a$ from the centre ensures $V = 0$ on the spherical surface.
]

#caution[
  The shielding is *perfect* only for static fields. Time-varying fields can penetrate a conductor to a depth determined by the skin depth $delta = sqrt(2 / (mu sigma omega))$, which is the basis for shielding enclosures in RF engineering.
]

=== Conductors in Capacitor Configurations // 导体与电容器

#property(name: "Parallel-Plate Capacitor")[
  Two parallel conducting plates of area $A$ separated by distance $d << sqrt(A)$, carrying charges $+Q$ and $-Q$.

  Neglecting fringe effects, the field is uniform between the plates and zero outside:
  $
    bold(E) = frac(sigma, epsilon_0) hat(bold(n)) = frac(Q, epsilon_0 A) hat(bold(n)),
    quad V = E d = frac(Q d, epsilon_0 A),
    quad C = frac(Q, V) = frac(epsilon_0 A, d).
  $
]

#note[
  The parallel-plate capacitor is the simplest example of how a conductor geometry determines capacitance. More complex geometries (coaxial cylinders, concentric spheres) also follow $C = Q / V$ and are tabulated in // Common Models.
]

=== Analysis Strategy with Conductors // 导体存在时的分析策略

When solving electrostatic problems involving conductors:

#property(name: "General Approach")[
  1. Identify all conductors and their potentials (or total charges).
  2. Inside each conductor: $bold(E) = bold(0)$, $V = "const"$.
  3. On each conductor surface: $bold(E)_"outside" = (sigma / epsilon_0) hat(bold(n))$, tangential component zero.
  4. Total charge on each conductor: $Q = integral_sigma dif a$.
  5. In the volume between conductors: solve Laplace's equation $nabla^2 V = 0$ with boundary conditions $V = V_i$ on each conductor surface.
  6. Once $V$ is known, obtain $bold(E) = - nabla V$ and $sigma = epsilon_0 E_n$.
]

== Polarization and Bound Charges // 极化与束缚电荷
// 电极化强度、束缚电荷密度、电介质的极化机制

Electric dielectrics are insulating materials that respond to an external electric field by developing an internal polarization. Unlike conductors, they contain no free charges, but their bound charges can shift slightly, creating microscopic dipoles.

=== Polarization Vector // 电极化强度

#definition(name: "Polarization Vector")[
  The *polarization vector* $bold(P)$ is defined as the electric dipole moment per unit volume:
  $
    bold(P)(bold(r)) = lim_(Delta V -> 0) (sum_i bold(p)_i) / Delta V,
  $
  where $bold(p)_i$ is the dipole moment of the $i$-th molecule within volume $Delta V$.
  In a linear, isotropic dielectric, polarization is proportional to the electric field:
  $
    bold(P) = epsilon_0 chi_e bold(E),
  $
  where $chi_e$ is the *electric susceptibility*, a dimensionless material constant.
]

#property(name: "Dielectric Constant")[
  The *relative permittivity* is defined as $epsilon_r = 1 + chi_e$.
  The absolute permittivity is $epsilon = epsilon_0 epsilon_r = epsilon_0 (1 + chi_e)$.
  For vacuum: $chi_e = 0$, $epsilon_r = 1$. For typical dielectrics: $1 < epsilon_r <= 100$.
]

=== Bound Charge Densities // 束缚电荷密度

When a dielectric is polarized, the displacement of bound charges produces effective charge distributions. These are called *bound charges*, as opposed to *free charges* that can move freely through a conductor.

#theorem(name: "Bound Volume Charge Density")[
  The bound volume charge density is the negative divergence of the polarization:
  $
    rho_b = - nabla dot bold(P).
  $
]

#proof[
  Consider a small volume $Delta V$ containing polarized molecules. Each molecule has a dipole moment $bold(p) = q bold(d)$. When the polarization $bold(P)$ is non-uniform, more dipole "heads" (positive ends) enter the volume than leave through the opposite face, or vice versa. The net bound charge within $Delta V$ equals the negative of the net dipole flux out of the surface:
  $
    Delta Q_b = - integral_(partial Delta V) bold(P) dot hat(bold(n)) dif a = - integral_(Delta V) (nabla dot bold(P)) dif V,
  $
  where the divergence theorem is applied. Thus $rho_b = Delta Q_b / Delta V = - nabla dot bold(P)$.
]

#theorem(name: "Bound Surface Charge Density")[
  At the interface between a dielectric and vacuum (or another medium), the bound surface charge density is:
  $
    sigma_b = bold(P) dot hat(bold(n)),
  $
  where $hat(bold(n))$ is the outward unit normal from the dielectric.
]

#proof[
  At the dielectric surface, the polarization causes positive bound charges to accumulate on one side and negative bound charges on the other. The surface density equals the component of $bold(P)$ normal to the surface — the projection of the dipole moment per unit area onto the surface normal.
]

#note[
  *Key insight:* The total bound charge in any closed system is zero:
  $
    Q_b = integral_V rho_b dif V + integral_S sigma_b dif a
        = integral_V (-nabla dot bold(P)) dif V + integral_S bold(P) dot hat(bold(n)) dif a
        = 0,
  $
  by the divergence theorem. Bound charges are merely a redistribution of the dielectric's internal charges — no net charge is created.
]

=== Polarization Mechanisms in Dielectrics // 电介质的极化机制

Different dielectric materials respond to an external field through different microscopic mechanisms:

#property(name: "Electronic Polarization")[ // 电子极化
  In atoms and nonpolar molecules, the external field displaces the electron cloud relative to the nucleus, creating an induced dipole. This mechanism is present in all materials, extremely fast (~$10^{-15}$ s), and essentially temperature-independent. Typical contribution: $chi_e approx 0.01 - 1$.
]

#property(name: "Ionic Polarization")[ // 离子极化
  In ionic crystals (e.g., NaCl), the external field displaces positive and negative ions in opposite directions, increasing the dipole moment of each ion pair. Slower than electronic polarization (~$10^{-13}$ s) and moderately temperature-dependent. Typical contribution: $chi_e approx 1 - 10$.
]

#property(name: "Orientational (Dipolar) Polarization")[ // 取向极化
  In polar molecules (e.g., H₂O, NH₃) that possess a permanent dipole moment, the external field tends to align these dipoles against thermal agitation. This is the strongest mechanism but also the slowest (~$10^{-10}$ s) and strongly temperature-dependent (following the Langevin function). Typical contribution: $chi_e$ can exceed $10$.
]

#property(name: "Interfacial (Space-Charge) Polarization")[ // 界面极化
  In heterogeneous materials (composites, polycrystalline solids), free charges accumulate at interfaces between different phases, creating macroscopic dipoles. This is the slowest mechanism (~seconds to hours) and dominates at low frequencies.
]

#caution[
  The total susceptibility is the sum of all contributions: $chi_e = chi_e^("elec") + chi_e^("ion") + chi_e^("orient") + chi_e^("inter")$.
  At optical frequencies, only electronic polarization can respond — this is why $epsilon_r$ at optical frequencies equals the square of the refractive index: $n^2 = epsilon_r^("optical")$.
]

=== Polarized Dielectric Sphere in a Uniform Field // 均匀场中的极化介质球

#proposition(name: "Uniformly Polarized Sphere")[
  A sphere of radius $R$ with uniform polarization $bold(P) = P hat(bold(z))$ produces:
  - Inside ($r < R$): a uniform depolarization field $bold(E)^("in") = - P / (3 epsilon_0) hat(bold(z))$.
  - Outside ($r > R$): the field of a pure dipole with moment $bold(p) = (4/3) pi R^3 bold(P)$.
  - Bound surface charge: $sigma_b = bold(P) dot hat(bold(n)) = P cos theta$.
]

#proof[
  For uniform $bold(P)$, the bound volume charge $rho_b = -nabla dot bold(P) = 0$. Only the surface bound charge $sigma_b = P cos theta$ exists.

  The potential outside is that of a dipole at the origin:
  $
    V_text("out")(r, theta) = frac(1, 4 pi epsilon_0) frac(p cos theta, r^2), quad p = (4/3) pi R^3 P.
  $

  Inside, the potential must satisfy Laplace's equation and match the boundary condition at $r = R$. The unique solution is:
  $
    V_text("in")(r, theta) = frac(P, 3 epsilon_0) r cos theta = frac(P, 3 epsilon_0) z.
  $

  Hence $bold(E)^("in") = -nabla V_text("in") = - P / (3 epsilon_0) hat(bold(z))$, a uniform field opposing the polarization (the *depolarization field*).
]

#note[
  This result is fundamental: the field inside a uniformly polarized sphere is uniform and opposite to the polarization. For a dielectric sphere placed in a *uniform external field* $bold(E)_0$, the total internal field is also uniform:
  $
    bold(E)^("in") = frac(3, epsilon_r + 2) bold(E)_0,
    quad
    bold(P) = 3 epsilon_0 frac(epsilon_r - 1, epsilon_r + 2) bold(E)_0.
  $
  This is obtained by combining the external field with the depolarization field from the induced polarization.
]

== Electric Displacement and Gauss's Law for D // 电位移矢量与D的高斯定理
// 电位移矢量定义、D的高斯定理、线性电介质

== Boundary Conditions at Interfaces // 介质界面边界条件
// 电场与电位移矢量的边界条件、导体-介质界面

== Electrostatic Energy and Capacitors // 静电能与电容器
// 静电能的一般表达式、电容器储能、能量密度、自能与相互作用能

The energy required to assemble a charge distribution from infinity is stored as electrostatic energy. For discrete point charges, this was given by $U = frac(1, 2) sum_i q_i V_i$ (Section // 势与电势). We now extend this to continuous distributions and express the energy in terms of the electric field.

=== Work to Assemble Point Charges // 组装点电荷的功

#proposition(name: "Work to Assemble Point Charges")[
  The work done to bring $N$ point charges $q_1, ..., q_N$ from infinity to their final positions $bold(r)_1, ..., bold(r)_N$ is independent of the order of assembly. Starting with the first charge (zero work), bringing the second charge $q_2$ into the field of $q_1$ requires work
  $
    W_2 = q_2 V_1(bold(r)_2) = frac(1, 4 pi epsilon_0) frac(q_1 q_2, |bold(r)_1 - bold(r)_2|).
  $
  Bringing the third charge $q_3$ into the combined field of $q_1$ and $q_2$ gives
  $
    W_3 = q_3 [V_1(bold(r)_3) + V_2(bold(r)_3)] = frac(1, 4 pi epsilon_0) (frac(q_1 q_3, |bold(r)_1 - bold(r)_3|) + frac(q_2 q_3, |bold(r)_2 - bold(r)_3|)).
  $
  Summing all contributions, each pair $(i, j)$ appears exactly once, yielding the total electrostatic energy
  $
    U = frac(1, 4 pi epsilon_0) sum_(i < j) frac(q_i q_j, |bold(r)_i - bold(r)_j|)
      = frac(1, 2) sum_(i=1)^N q_i V_i,
  $
  consistent with the earlier definition. The factor $1/2$ compensates for double-counting each pair when summing over all $i$.
]

=== Continuous Distributions and Field Energy // 连续分布与场能量

#proposition(name: "Energy of a Continuous Charge Distribution")[
  For a continuous charge distribution with density $rho(bold(r))$, the electrostatic energy generalizes to
  $
    U = frac(1, 2) integral rho(bold(r)) V(bold(r)) dif tau.
  $
  Using Gauss's law in differential form $rho = epsilon_0 nabla dot bold(E)$, this can be rewritten in terms of the field alone:
  $
    U = frac(epsilon_0, 2) integral (nabla dot bold(E)) V dif tau.
  $
  Integrate by parts using the vector identity $V (nabla dot bold(E)) = nabla dot (V bold(E)) - bold(E) dot nabla V$:
  $
    U = frac(epsilon_0, 2) [ integral_(partial V) V bold(E) dot dif bold(a) - integral bold(E) dot underbrace((nabla V), -bold(E)) dif tau ].
  $
  Extend the integration volume to all space. The surface integral vanishes because for a localized distribution $V approx 1/r$ and $bold(E) approx 1/r^2$, so $V bold(E) approx 1/r^3$ while the surface area grows as $r^2$, giving $V bold(E) dot d bold(a) approx 1/r arrow 0$ as $r arrow infinity$. Using $nabla V = -bold(E)$, we obtain
  $
    U = frac(epsilon_0, 2) integral_("all space") E^2 dif tau.
  $
  This form reveals that electrostatic energy is stored in the electric field itself, not merely in the charges.
]

#property(name: "Electrostatic Energy Density")[
  The integrand of the field-energy expression defines the *electrostatic energy density*
  $
    u(bold(r)) = frac(1, 2) epsilon_0 |bold(E)(bold(r))|^2.
  $
  The total energy is $U = integral u(bold(r)) dif tau$. This is a local quantity: each point in space carries energy proportional to the square of the field strength there, regardless of whether charges are present at that point.
]

=== Energy in Capacitors // 电容器的储能

#property(name: "Energy Stored in a Capacitor")[
  For a capacitor with capacitance $C$, storing charge $Q$ and potential difference $V$, the electrostatic energy is
  $
    U = frac(Q^2, 2C) = frac(1, 2) C V^2.
  $
  This follows from $U = frac(1, 2) integral rho V dif tau$: for two conductors carrying $+Q$ and $-Q$ at potentials $V_+$ and $V_-$,
  $
    U = frac(1, 2) (Q V_+ + (-Q) V_-) = frac(1, 2) Q (V_+ - V_-) = frac(1, 2) Q V.
  $
  Substituting $Q = C V$ gives the familiar forms. As a consistency check, for a parallel-plate capacitor ($C = epsilon_0 A / d$, $E = V/d$), the field-energy approach gives
  $
    U = frac(epsilon_0, 2) integral E^2 dif tau = frac(epsilon_0, 2) E^2 (A d) = frac(1, 2) epsilon_0 A d (frac(V, d))^2 = frac(1, 2) C V^2,
  $
  confirming that both interpretations agree.
]

=== Self-Energy and Interaction Energy // 自能与相互作用能

The expression $U = frac(epsilon_0, 2) integral E^2 dif tau$ integrates over all space and includes the energy of the field produced by every charge, including the field *of a point charge itself*. For a single point charge $q$, the field is $E = q/(4 pi epsilon_0 r^2)$, and
$
  U_(text("self")) = frac(epsilon_0, 2) integral_0^oo (frac(q, 4 pi epsilon_0 r^2))^2 4 pi r^2 dif r
    = frac(q^2, 8 pi epsilon_0) integral_0^oo frac(1, r^2) dif r arrow infinity.
$
This *self-energy divergence* is a fundamental limitation of classical electrodynamics: the energy of a point charge is infinite. In practice, only *changes* in energy (differences between configurations) are physically meaningful for point charges, and these are finite because the divergent self-energy contributions cancel.

For a system of multiple charges, we may decompose
$
  U = sum_i U_(text("self"))^(i) + sum_(i < j) U_(text("int"))^(i j),
$
where $U_(text("int"))^(i j) = frac(1, 4 pi epsilon_0) frac(q_i q_j, |bold(r)_i - bold(r)_j|)$ is the finite interaction energy between distinct charges. The total energy in $U = frac(1, 2) sum_i q_i V_i$ automatically excludes self-energy because $V_i$ is the potential due to *all other* charges only.

#example(name: "Energy of a Uniformly Charged Solid Sphere")[
  A sphere of radius $R$ carries uniform volume charge density $rho$ (total charge $Q = 4 pi R^3 rho / 3$). Compute its electrostatic energy by two methods.

  *Method 1 — field integral*: Using the field from // Common Models: $bold(E) = frac(Q, 4 pi epsilon_0) frac(r, R^3) hat(bold(r))$ for $r < R$ and $bold(E) = frac(Q, 4 pi epsilon_0) frac(1, r^2) hat(bold(r))$ for $r >= R$,
  $
    U = frac(epsilon_0, 2) integral_0^R (frac(Q r, 4 pi epsilon_0 R^3))^2 4 pi r^2 dif r
      + frac(epsilon_0, 2) integral_R^oo (frac(Q, 4 pi epsilon_0 r^2))^2 4 pi r^2 dif r
    = frac(3 Q^2, 20 pi epsilon_0 R).
  $

  *Method 2 — charge-potential integral*: Using $V(r) = frac(Q, 8 pi epsilon_0 R) (3 - frac(r^2, R^2))$ for $r < R$,
  $
    U = frac(1, 2) integral_0^R rho V(r) 4 pi r^2 dif r
    = frac(1, 2) rho integral_0^R frac(Q, 8 pi epsilon_0 R) (3 - frac(r^2, R^2)) 4 pi r^2 dif r
    = frac(3 Q^2, 20 pi epsilon_0 R),
  $
  confirming consistency.
]

#note[
  *Key takeaways:*
  - Electrostatic energy can be computed either from the charge distribution ($frac(1, 2) integral rho V dif tau$) or from the field ($frac(epsilon_0, 2) integral E^2 dif tau$).
  - The field-energy expression generalizes to all space, showing energy is localized in the field.
  - For point charges, the self-energy diverges; physically relevant quantities involve energy *differences* (interaction energies).
  - Capacitor energy provides a direct link between circuit concepts and field theory.
]


#part("Magnetostatics") // 静磁学
= Magnetostatic Field // 静磁场

// 恒定电流（电流密度、连续性方程、欧姆定律、电动势）
== Steady Currents and Ohm's Law // 恒定电流与欧姆定律

Steady currents are the "source" of magnetostatic fields — just as stationary electric charges are the source of electrostatic fields. This section establishes the fundamental concepts of current, charge conservation, and conduction, which provide the foundation for all subsequent magnetic field calculations.

=== Electric Current and Current Density // 电流与电流密度

#definition(name: "Electric Current")[
  *Electric current* is the rate of flow of electric charge through a surface. If a net charge $dif Q$ passes through a surface $S$ in time $dif t$, the current is
  $
    I = frac(dif Q, dif t).
  $
  The SI unit of current is the *ampere* (A): $1 "A" = 1 "C/s"$.
]

The macroscopic current $I$ does not contain directional information at every point. For a complete description of charge flow, we introduce the vector current density.

#definition(name: "Current Density")[
  The *current density* $bold(J)$ is a vector field whose direction is the direction of net charge flow and whose magnitude is the current per unit area perpendicular to the flow:
  $
    bold(J) = n q bold(v),
  $
  where $n$ is the number density of charge carriers, $q$ is the charge per carrier, and $bold(v)$ is the average drift velocity. The current through a surface $S$ is the flux of $bold(J)$:
  $
    I = integral_S bold(J) dot dif bold(S).
  $
]


Just as charge distributions can be volumetric, surface, or linear, current distributions are classified analogously:

- *Volume current density* $bold(J)$ ($"A/m"^2$): $bold(K)$ for bulk flow,
- *Surface current density* $bold(K)$ (A/m): current per unit width on a thin sheet,
- *Line current* $I$ (A): current confined to a thin wire, treated as a filament.

The total current from a line current is simply $I$, from a surface current is $I = integral_L bold(K) dot (hat(bold(n)) times d bold(l))$, and from a volume current is $I = integral_S bold(J) dot dif bold(S)$.


#note[
  In magnetostatics we require that all currents be *steady* — the charge density at every point is constant in time ($partial rho / partial t = 0$). This condition ensures that the magnetic field produced by the currents is static.
]

=== Continuity Equation and Kirchhoff's Current Law // 连续性方程与基尔霍夫电流定律

Charge is a conserved quantity: it can neither be created nor destroyed. This fundamental principle leads to a differential relation between the current density and the charge density.

#theorem(name: "Continuity Equation")[
  The conservation of electric charge is expressed locally by the *continuity equation*:
  $
    partial overline(rho) / partial t + nabla dot bold(J) = 0.
  $
  In integral form: the net current flowing out of a closed surface equals the rate of decrease of charge inside the volume:
  $
    integral_S bold(J) dot dif bold(S) = - frac(d, d t) integral_V rho dif V.
  $
]

#proof[
  Consider a volume $V$ enclosed by a surface $S$. The total charge inside $V$ is $Q = integral_V rho dif V$. The current flowing out of $V$ through $S$ is $I = integral_S bold(J) dot dif bold(S)$. Charge conservation requires that the outflow current equals the rate of decrease of charge inside:
  $
    integral_S bold(J) dot dif bold(S) = - frac(dif Q, dif t) = - integral_V (partial rho / partial t) dif V.
  $
  Applying the divergence theorem to the left side: $integral_V (nabla dot bold(J)) dif V = - integral_V (partial rho / partial t) dif V$. Since this holds for any volume, the integrands must be equal pointwise, giving $nabla dot bold(J) + partial rho / partial t = 0$.
]

Under steady-state (magnetostatic) conditions, all charge densities are constant in time, so $partial rho / partial t = 0$. The continuity equation then reduces to:

#corollary(name: "Kirchhoff's Current Law")[
  For steady currents: $nabla dot bold(J) = 0$.

  In integral form: for any closed surface $S$,
  $
    integral_S bold(J) dot dif bold(S) = 0.
  $

  This is the *Kirchhoff's Current Law (KCL)*, also called the *node rule*: the algebraic sum of currents entering any node (junction) is zero:
  $
    sum_i I_i = 0,
  $
  taking currents entering the node as positive and those leaving as negative.
]

#note[
  KCL is not an independent law — it is a direct consequence of charge conservation under the steady-state assumption. It is one of the two fundamental laws of circuit analysis (the other being KVL, introduced below).
]

=== Ohm's Law and Conductivity // 欧姆定律与电导率

#law(name: "Ohm's Law (Local Form)")[
  For a wide class of materials (known as *Ohmic conductors*), the current density is proportional to the electric field within the conductor:
  $
    bold(J) = sigma bold(E),
  $
  where $sigma$ is the *electrical conductivity* of the material, measured in siemens per metre ($"S/m"$). The reciprocal quantity $rho = 1 / sigma$ is the *resistivity*, measured in ohm-metres ($Omega dot "m"$).
]

#law(name: "Macroscopic Ohm's Law")[
  For a uniform wire of length $L$, cross-sectional area $A$, and conductivity $sigma$, the current $I = J A$ and the potential difference $V = E L$ across its ends satisfy the familiar form:
  $
    V = I R, quad R = frac(L, sigma A) = rho frac(L, A),
  $
  where $R$ is the *resistance* measured in ohms ($Omega$). The SI unit of resistance is $1 Omega = 1 "V/A"$.
]

#h(2em)
// 给出欧姆定律的微观解释，连接电导率与载流子密度和迁移率
Here we provide a microscopic interpretation of Ohm's law, connecting the macroscopic conductivity to the underlying charge carrier dynamics in a conductor.

In a metal, conduction electrons drift under an applied electric field. The drift velocity is proportional to the field:
$
  bold(v)_d = - mu_e bold(E),
$
where $mu_e$ is the *electron mobility*. The current density is then
$
  bold(J) = - n e bold(v)_d = n e mu_e bold(E),
$
so the conductivity is $sigma = n e mu_e$. This relation connects macroscopic conductivity to microscopic parameters (carrier density and mobility).

*Temperature dependence of resistivity.* In metals, resistivity decreases as temperature is lowered, since phonon scattering is suppressed. At sufficiently low temperatures, certain materials undergo a *superconducting transition*: resistivity drops to zero below a *critical temperature* $T_"c"$, discovered by Onnes in 1911 ($T_"c" approx 4.2 "K"$ in mercury). 

#note[
  Not all conductors obey Ohm's law. Semiconductors, ionic solutions, and plasmas may exhibit nonlinear $J$-$E$ relations. In anisotropic media (e.g., certain crystals), conductivity is a tensor: $J_i = sigma_(i j) E_j$.
]

== Electromotive Force // 电动势
=== Electromotive Force and Power Sources // 电动势与电源

An electrostatic field $bold(E)$ alone cannot sustain a steady current in a closed circuit, since $integral bold(E) dot d bold(l) = 0$ along any closed path. To maintain a steady current, a *source* of energy is needed to drive charges "uphill" against the electrostatic field. This driving mechanism is characterized by the *electromotive force*.

#definition(name: "Electromotive Force")[
  The *electromotive force (EMF)* $cal(E)$ of a source is the line integral of the net driving force per unit charge, $bold(f)$, around the circuit:
  $
    cal(E) = integral.cont bold(f) dot d bold(l).
  $
  For a source acting solely within a limited region (e.g., a battery), the EMF is concentrated across its terminals:
  $
    cal(E) = integral_"inside source" bold(f) dot d bold(l).
  $
  The SI unit of EMF is the volt (V). Despite the name, EMF is not a force but a potential difference (an energy per unit charge).
]

#h(2em)The most common sources of EMF include:

#tex-table(
  ("Source", "Mechanism", [Driving force $bold(f)$]),
  ("Chemical battery", "Electrochemical reactions", "Chemical force"),
  ("Thermocouple", "Temperature gradient", "Thermal diffusion"),
  ("Photovoltaic cell", "Light absorption", "Internal field at junction"),
  ([Generator (motional EMF)], [Conductor moving through $bold(B)$], [$bold(v) times bold(B)$ (see Ch. 8)]),
)

#h(2em)A real battery is modelled as an ideal EMF $cal(E)$ in series with an *internal resistance* $r$:

- *Discharging* (source supplies current to external circuit):
  $
    V = cal(E) - I r,
  $
  where $V$ is the terminal voltage across the battery. The current through the external load $R$ is $I = cal(E) / (R + r)$.

- *Charging* (external source forces current into the battery):
  $
    V = cal(E) + I r.
  $
  Electrical energy is converted into chemical energy (recharging).

- *Open circuit* ($I = 0$): $V = cal(E)$.
- *Short circuit* ($R = 0$): $I_"sc" = cal(E) / r$, terminal voltage drops to zero.


#note[
  The distinction between charging and discharging is crucial: the terminal voltage is *lower* than the EMF during discharge and *higher* during charge. This behaviour is central to understanding battery-operated circuits.
]

=== Kirchhoff's Voltage Law // 基尔霍夫电压定律

In electrostatics, the conservative nature of the electric field implies that the potential difference around any closed loop is zero. In a circuit containing sources of EMF, this principle generalises to account for the driving forces within sources.

#law(name: "Kirchhoff's Voltage Law")[
  The algebraic sum of all potential differences (voltage drops and rises) around any closed loop in a circuit is zero:
  $
    sum_i V_i = 0.
  $

  Equivalently, in a loop containing resistors and EMF sources:
  $
    sum_i I_i R_i = sum_j cal(E)_j.
  $
  Voltage drops across resistors ($I R$) are taken as positive when traversed in the direction of the current; EMFs are taken as positive when traversed from the negative to the positive terminal.
]

#proof[
  Starting from the conservative nature of the electrostatic field, $integral.cont bold(E) dot d bold(l) = 0$ around any closed path. However, inside a source, the total field that drives current is $bold(E)_"total" = bold(E) + bold(f)$, where $bold(f)$ is the non-electrostatic force per unit charge (e.g., chemical force in a battery). The line integral around the complete circuit gives:
  $
    0 = integral.cont bold(E) dot d bold(l) = integral.cont (bold(E)_"total" - bold(f)) dot d bold(l) = - integral.cont bold(f) dot d bold(l) + integral.cont bold(J)/sigma dot d bold(l) = - sum cal(E) + sum I R.
  $
  Rearranging gives $sum I R = sum cal(E)$, which is KVL.
]

#note[
  KVL together with KCL form the complete set of circuit equations. They are purely topological (independent of the specific components) and hold for any lumped-element circuit under the quasi-static approximation.
]

=== Joule Heating and Power Dissipation // 焦耳热与能量耗散
If the voltage across a circuit is $U$, when a charge $q$ passes through, the work done by the electric field on the charge is $W = q U = I U t$. The work done by the electric field per unit time is called electric power $P = W/t = I U$.

When current flows through a conductor, the electric field does work on the moving charges. This work is converted into thermal energy through collisions with the lattice — a phenomenon known as *Joule heating* or *ohmic heating*.

#law(name: "Joule Heating and Power Dissipation")[
  The power dissipated per unit volume (power density) in a conductor is:
  $
    p = bold(J) dot bold(E) = sigma E^2 = frac(J^2, sigma).
  $

  For a uniform wire carrying current $I$ with potential difference $V$ across its ends:
  $
    P = I V = I^2 R = frac(V^2, R),
  $
  where $P$ is the total power dissipated in the wire, measured in watts (W).
]

#proof[
  Consider a small volume $d tau$ containing charge $rho d tau$ moving at drift velocity $bold(v)$. The force on this charge is $rho d tau bold(E)$, and the work done per unit time (power) is $bold(F) dot bold(v) = rho bold(v) d tau dot bold(E) = bold(J) d tau dot bold(E)$. Hence $p = bold(J) dot bold(E)$. Using Ohm's law $bold(J) = sigma bold(E)$, we obtain $p = sigma E^2 = J^2/sigma$.
]

#note[
  Joule heating is *irreversible* — electrical energy is converted into heat, which cannot be fully converted back. This contrasts with the reversible energy storage in electric and magnetic fields (electrostatic energy $frac(1,2) epsilon_0 E^2$ and magnetostatic energy $frac(1,2) mu_0 B^2$), which will be discussed in subsequent sections.
]

#note[
  *Key takeaways for magnetostatics:*
  - The steady current density $bold(J)$ (with $nabla dot bold(J) = 0$) is the source term for the magnetic field.
  - Ohm's law $bold(J) = sigma bold(E)$ provides the constitutive relation linking $bold(J)$ to the electric field.
  - EMF sources are essential for sustaining steady currents; real sources have internal resistance.
  - KCL and KVL are the two fundamental circuit laws, both derivable from the field equations under steady-state conditions.
  - Joule heating represents the inevitable energy loss in conducting materials.
]
// 洛伦兹力、磁感应强度的定义、比奥-萨伐尔定律及其应用
== Lorentz Force and Biot-Savart Law // 洛伦兹力与比奥-萨伐尔定律

Having established the source of magnetostatic fields in section §6.1 (steady currents), we now turn to the field itself. This section introduces the magnetic field $bold(B)$ through its defining force law and the integral law that allows us to compute $bold(B)$ from a given current distribution. The structure parallels §3.2 (Electric Field Intensity) in electrostatics.

=== Lorentz Force and the Magnetic Field // 洛伦兹力与磁场

Just as the electric field $bold(E)$ was defined via the force on a stationary test charge, the magnetic field $bold(B)$ is defined via the force on a moving charge. Unlike electrostatic forces, magnetic forces depend on the velocity of the test charge and are always perpendicular to it.

#law(name: "Lorentz Force")[
  The total electromagnetic force on a point charge $q$ moving with velocity $bold(v)$ in an electric field $bold(E)$ and magnetic field $bold(B)$ is:
  $
    bold(F) = q (bold(E) + bold(v) times bold(B)).
  $
  The term $bold(F)_m = q bold(v) times bold(B)$ is the *magnetic Lorentz force*. In magnetostatics (where $bold(E) = bold(0)$), this reduces to:
  $
    bold(F) = q bold(v) times bold(B).
  $
]

From the Lorentz force law, we can define the magnetic field $bold(B)$ operationally: for a known test charge $q$ and a measured force at a given velocity, $bold(B)$ is the unique vector satisfying $bold(F)_m = q bold(v) times bold(B)$.

#definition(name: "Magnetic Field Intensity")[
  The *magnetic flux density* $bold(B)$ is defined by the magnetic force on a moving charge:
  $
    |bold(B)| = frac(F_m, q v sin theta),
  $
  where $theta$ is the angle between $bold(v)$ and $bold(B)$. The direction of $bold(B)$ is perpendicular to both $bold(v)$ and $bold(F)_m$, following the right-hand rule.

  The SI unit of $bold(B)$ is the *tesla* (T):
  $
    1 "T" = 1 frac("N", "A" dot "m") = 1 frac("kg", "s"^2 dot "A").
  $
  An alternative unit is the *gauss* (G): $1 "G" = 10^(-4) "T"$.
]

#note[
  The magnetic force $q bold(v) times bold(B)$ is always perpendicular to the velocity $bold(v)$, so it does zero work on the particle:
  $
    frac(dif W, dif t) = bold(F)_m dot bold(v) = q (bold(v) times bold(B)) dot bold(v) = 0.
  $
  A magnetic field cannot change the speed (kinetic energy) of a charged particle — it can only change its direction of motion. This distinguishes magnetic forces from electric forces, which can do work and change the particle's energy.
]

#note[
  The Lorentz force law is the operational definition of $bold(B)$ in the same way that $bold(F) = q bold(E)$ defines $bold(E)$. Together with Coulomb's law, it forms the complete description of how electromagnetic fields exert forces on charges — a fact that will be unified when we study the electromagnetic field tensor in §1.6.
]

=== Biot-Savart Law // 比奥-萨伐尔定律

The Lorentz force tells us what $bold(B)$ does to a moving charge; we now need to know how $bold(B)$ is produced by currents. The fundamental law was discovered experimentally by Jean-Baptiste Biot and Félix Savart in 1820. It plays the same role in magnetostatics as Coulomb's law does in electrostatics: it gives the magnetic field produced by a known current distribution.

#law(name: "Biot-Savart Law")[
  The magnetic field at a point $bold(r)$ due to a steady line current $I$ flowing along a curve $L$ is:
  $
    bold(B)(bold(r)) = frac(mu_0, 4 pi) integral_L frac(I d bold(l)' times (bold(r) - bold(r)'), |bold(r) - bold(r)'|^3) = frac(mu_0, 4 pi) integral_L frac(I d bold(l)' times hat(bold(R)), R^2),
  $
  where $d bold(l)'$ is a differential element along the wire in the direction of the current, $bold(R) = bold(r) - bold(r)'$ is the vector from the source point $bold(r)'$ to the field point $bold(r)$, and $mu_0$ is the *permeability of free space*:
  $
    mu_0 = 4 pi times 10^(-7) "N" / "A"^2.
  $
]

The Biot-Savart law obeys the superposition principle: the total field from multiple current elements is the vector sum of the individual contributions.

#law(name: "Biot-Savart Law — Continuous Distributions")[
  For a volume current density $bold(J)$:
  $
    bold(B)(bold(r)) = frac(mu_0, 4 pi) integral_V frac(bold(J)(bold(r)') times hat(bold(R)), R^2) dif V'.
  $
  For a surface current density $bold(K)$:
  $
    bold(B)(bold(r)) = frac(mu_0, 4 pi) integral_S frac(bold(K)(bold(r)') times hat(bold(R)), R^2) dif S'.
  $
]

#note[
  The Biot-Savart law is a *volume law*: every current element contributes to the field at every point in space. In contrast, Ampère's law (to be introduced in §6.3) is a *boundary law* that is much more powerful when the current distribution has sufficient symmetry. This parallels the relationship between Coulomb's law and Gauss's law in electrostatics.
]

=== Magnetic Field Lines // 磁感线

#definition(name: "Magnetic Field Lines")[
  *Magnetic field lines* are curves drawn in space such that the tangent at every point is parallel to the direction of $bold(B)$ at that point. The density of lines in a region is proportional to the magnitude of the magnetic field.
]

#property(name: "Properties of Magnetic Field Lines")[
  - They form closed loops — they have no beginning and no end.
  - They never cross each other.
  - Unlike electric field lines (which originate and terminate on charges), magnetic field lines are continuous: every line that enters a region must also leave it.
  - The direction of the field at a point is given by the right-hand rule with respect to the current that produces it.
]

#note[
  The fact that magnetic field lines form closed loops is the geometric expression of $nabla dot bold(B) = 0$ — the absence of magnetic monopoles. This is one of the four Maxwell's equations and distinguishes magnetism from electrostatics, where $nabla dot bold(E) = rho / epsilon_0$ implies field lines begin and end on charges.
]

#note[
  *Key takeaways for magnetostatics:*
  - The Lorentz force $q bold(v) times bold(B)$ defines the magnetic field $bold(B)$ operationally.
  - The Biot-Savart law gives the integral relation between a steady current and the magnetic field it produces — the magnetostatic counterpart of Coulomb's law.
  - Magnetic field lines are closed, reflecting $nabla dot bold(B) = 0$ and the absence of magnetic monopoles.
  - The permeability $mu_0$ plays the same role in magnetostatics as $epsilon_0$ does in electrostatics.
]

// 安培环路定理（积分与微分形式）、磁场高斯定理、磁通量；对比静电学微分方程
== Ampère's Law and Gauss's Law for Magnetism // 安培环路定理与磁场高斯定理

In section §6.2, the Biot-Savart law gave us the fundamental integral relation between steady currents and the magnetic field they produce — the magnetostatic counterpart of Coulomb's law. We now turn to the two field equations that govern the _global_ structure of $bold(B)$: Gauss's law for magnetism and Ampère's circuital law. Just as Gauss's law for $bold(E)$ (§3.3) exploits symmetry to simplify electrostatic calculations, Ampère's law provides an elegant route to $bold(B)$ when the current distribution possesses sufficient symmetry. Together, these two laws form the magnetostatic pair among Maxwell's four equations.

=== Magnetic Flux // 磁通量

#definition(name: "Magnetic Flux")[
  The *magnetic flux* $Phi_B$ through a surface $S$ is defined as the surface integral of the magnetic field over $S$:
  $
    Phi_B = integral_S bold(B) dot dif bold(S),
  $
  where $dif bold(S) = hat(bold(n)) dif S$ is the vector area element, with $hat(bold(n))$ being the unit normal to the surface. For a closed surface, the flux is denoted:
  $
    Phi_B = integral_harpoon(S) bold(B) dot dif bold(S).
  $

  The SI unit of magnetic flux is the *weber* (Wb):
  $
    1 "Wb" = 1 "T" dot "m"^2 = 1 "V" dot "s".
  $
]

Physically, the magnetic flux measures the "flow" of the magnetic field through a surface — it is proportional to the number of field lines passing through that surface. Unlike electric flux, the magnetic flux through any _closed_ surface is always zero — a fundamental fact that will be formalised in the next subsection.

#example[
  Consider a uniform magnetic field $bold(B) = B_0 hat(bold(z))$ passing through a flat surface of area $A$ oriented at an angle $theta$ with respect to the field. The flux through the surface is:
  $
    Phi_B = integral_A bold(B) dot dif bold(S) = B_0 A cos theta.
  $
  The flux is maximal when the surface is perpendicular to the field ($theta = 0$) and zero when the surface is parallel to the field ($theta = pi/2$). This mirrors the electric flux example from §3.3.
]

=== Gauss's Law for Magnetism // 磁场高斯定理

#law(name: "Gauss's Law for Magnetism — Integral Form")[
  The net magnetic flux through any closed surface $S$ is identically zero:
  $
    integral_harpoon(S) bold(B) dot dif bold(S) = 0.
  $
]

This law expresses the experimental fact that *magnetic monopoles do not exist*. Every magnetic field line that enters a closed surface must also leave it. Contrast this with Gauss's law for $bold(E)$ (§3.3), where the flux is proportional to the enclosed charge:
$
  integral_harpoon(S) bold(E) dot dif bold(S) = frac(Q_"enc", epsilon_0).
$
The right-hand side being zero means there are no "magnetic charges" to serve as sources or sinks of the magnetic field.

By applying the divergence theorem to the integral form, we obtain the local (pointwise) counterpart:

#law(name: "Gauss's Law for Magnetism — Differential Form")[
  $
    nabla dot bold(B) = 0.
  $
]

The divergence theorem gives $integral_V (nabla dot bold(B)) dif V = 0$ for any volume $V$. Since this holds for every volume, the integrand must vanish pointwise.

#note[
  The condition $nabla dot bold(B) = 0$ means $bold(B)$ is a *solenoidal field* (as defined in §1.1). The magnetic field lines are always closed loops — they have neither beginning nor end. This was already anticipated by the properties of magnetic field lines in §6.2. If magnetic monopoles were ever discovered, this equation would become $nabla dot bold(B) = rho_m$ (where $rho_m$ is the magnetic charge density), restoring the symmetry with electrostatics.
]

=== Ampère's Circuital Law // 安培环路定理

Before stating the law, we define the enclosed current. For a surface $S$ bounded by a closed curve $C$:

#definition(name: "Enclosed Current")[
  The *enclosed current* $I_"enc"$ is the net current passing through any surface $S$ bounded by the closed contour $C$:
  $
    I_"enc" = integral_S bold(J) dot dif bold(S).
  $
  By the continuity equation for steady currents (§6.1, $nabla dot bold(J) = 0$), the result is independent of the choice of surface $S$, provided it is bounded by the same contour $C$.
]

#law(name: "Ampère's Circuital Law — Integral Form")[
  The circulation of the magnetic field $bold(B)$ around any closed contour $C$ (the *Amperian loop*) is proportional to the net current enclosed by $C$:
  $
    integral.cont_C bold(B) dot dif bold(l) = mu_0 I_"enc",
  $
  where $dif bold(l)$ is the line element along $C$ in the direction of integration, and $mu_0$ is the permeability of free space. The direction convention follows the right-hand rule: curl the fingers of the right hand along the direction of integration; the thumb gives the positive direction for enclosed current.
]

The left-hand side is the *circulation* of $bold(B)$ around $C$ (as defined in §1.1). Unlike the electrostatic field, whose circulation vanishes ($integral.cont bold(E) dot dif bold(l) = 0$), the magnetic field generally has nonzero circulation proportional to the enclosed current. This is the magnetostatic analogue of Gauss's law for $bold(E)$: a powerful integral relation connecting the field to its source.

#h(2em)By applying Stokes' theorem, we obtain the differential form:

#theorem(name: "Ampère's Law — Differential Form")[
  $
    nabla times bold(B) = mu_0 bold(J).
  $
]

#proof[
  Stokes' theorem states that for any vector field $bold(F)$ and any surface $S$ bounded by a closed contour $C$:
  $
    integral.cont_C bold(F) dot dif bold(l) = integral_S (nabla times bold(F)) dot dif bold(S).
  $

  Applying this to the left-hand side of Ampère's law:
  $
    integral.cont_C bold(B) dot dif bold(l) = integral_S (nabla times bold(B)) dot dif bold(S).
  $

  The right-hand side is:
  $
    mu_0 I_"enc" = mu_0 integral_S bold(J) dot dif bold(S).
  $

  Equating the two:
  $
    integral_S (nabla times bold(B) - mu_0 bold(J)) dot dif bold(S) = 0.
  $

  Since this holds for _any_ surface $S$, the integrand must vanish pointwise:
  $
    nabla times bold(B) = mu_0 bold(J).
  $
]

#note[
  The differential form $nabla times bold(B) = mu_0 bold(J)$ tells us that the curl of the magnetic field at a point is proportional to the current density at that point. Where no current flows ($bold(J) = bold(0)$), the magnetic field is irrotational ($nabla times bold(B) = bold(0)$), though it may still be nonzero (as the field outside a wire demonstrates). This is the magnetostatic counterpart of the electrostatic condition $nabla times bold(E) = bold(0)$.
]

=== Applications of Ampère's Law // 安培环路定理的应用

While the Biot-Savart law is the fundamental force law for magnetic fields, Ampère's law often provides a much simpler route to computing $bold(B)$ when the current distribution possesses sufficient symmetry. The key is to choose an Amperian loop over which $bold(B)$ is either constant or perpendicular to the path.

#theorem(name: "Strategy for Applying Ampère's Law")[
  To compute $bold(B)$ using Ampère's law:
  1. Identify the symmetry of the current distribution (cylindrical, solenoidal, or toroidal).
  2. Choose an Amperian loop $C$ that respects this symmetry, such that $bold(B)$ is constant in magnitude and either parallel or perpendicular to $dif bold(l)$ along each segment.
  3. Evaluate the circulation $integral.cont bold(B) dot dif bold(l)$ — by symmetry, $|bold(B)|$ factors out of the integral.
  4. Compute the enclosed current $I_"enc"$.
  5. Solve for $|bold(B)|$.
]

#example(name: "Infinite Straight Wire — Cylindrical Symmetry")[ // 无限长直导线
  An infinite straight wire carrying steady current $I$ along the $z$-axis. By cylindrical symmetry, $bold(B) = B(rho) hat(bold(phi))$. Choose a circular Amperian loop of radius $rho$ centred on the wire:
  $
    integral.cont bold(B) dot dif bold(l) = B(rho) dot 2 pi rho = mu_0 I.
  $
  Hence:
  $
    bold(B) = frac(mu_0 I, 2 pi rho) hat(bold(phi)).
  $
  This is the magnetostatic counterpart of the infinite line charge result $E = lambda / (2 pi epsilon_0 rho)$ from §3.3. The field decays as $1/rho$ and circles the wire according to the right-hand rule.
]

#example(name: "Infinite Solenoid")[ // 无限长螺线管
  An infinite solenoid with $n$ turns per unit length carrying current $I$. By symmetry, $bold(B) = B hat(bold(z))$ inside and $bold(B) = bold(0)$ outside. Choose a rectangular Amperian loop with one side of length $L$ inside and one side outside the solenoid, parallel to the axis:
  $
    B L = mu_0 (n L) I.
  $
  Hence:
  $
    bold(B) = mu_0 n I hat(bold(z)) quad text("inside").
  $
  The field inside an infinite solenoid is *uniform* — the magnetic analogue of the uniform field between infinite parallel plates in electrostatics. Outside the solenoid, $bold(B) = bold(0)$.
]

#example(name: "Toroid")[ // 环形螺线管（螺绕环）
  A toroid with $N$ total turns carrying current $I$. Choose a circular Amperian loop of radius $r$ concentric with the toroid axis:
  $
    B(r) dot 2 pi r = mu_0 N I.
  $
  Hence:
  $
    bold(B) = frac(mu_0 N I, 2 pi r) hat(bold(phi)) quad text("inside the toroid"),
  $
  and $bold(B) = bold(0)$ outside. Unlike the solenoid, the field inside a toroid is not uniform — it varies as $1/r$. For a toroid of large radius $R$ with $r approx R$, the field is approximately uniform: $B approx mu_0 N I / (2 pi R) = mu_0 n I$, recovering the solenoid result.
]

=== Electrostatic vs Magnetostatic Field Equations // 静电场与静磁场方程对比

We have now assembled the complete set of field equations for electrostatics and magnetostatics. Let us collect them and examine the structural parallels and differences.

#tex-table(
  ("Equation", "Electrostatics", "Magnetostatics", "Physical meaning"),
  ("Divergence", [$nabla dot bold(E) = rho / epsilon_0$], [$nabla dot bold(B) = 0$], "Sources of the field"),
  ("Curl", [$nabla times bold(E) = bold(0)$], [$nabla times bold(B) = mu_0 bold(J)$], "Circulation of the field"),
  ([Gauss-type (integral)], [$integral_harpoon(S) bold(E) dot dif bold(S) = Q_"enc" / epsilon_0$], [$integral_harpoon(S) bold(B) dot dif bold(S) = 0$], "Flux law"),
  ([Circulation (integral)], [$integral.cont bold(E) dot dif bold(l) = 0$], [$integral.cont bold(B) dot dif bold(l) = mu_0 I_"enc"$], "Ampère / electrostatic law"),
)

#h(2em)The structural parallels and asymmetries are striking:

- The electrostatic field is *irrotational* ($nabla times bold(E) = bold(0)$) and has *sources* (charges, $nabla dot bold(E) = rho / epsilon_0$). It can be derived from a scalar potential: $bold(E) = - nabla V$.
- The magnetostatic field is *solenoidal* ($nabla dot bold(B) = 0$) and has *circulation* (currents, $nabla times bold(B) = mu_0 bold(J)$). It cannot be described by a scalar potential in regions with current; instead, a *vector potential* $bold(A)$ will be introduced in §6.4 such that $bold(B) = nabla times bold(A)$.
- The asymmetry between the two sets reflects the absence of magnetic monopoles. If magnetic monopoles existed (with density $rho_m$ and current $bold(J)_m$), the equations would become fully symmetric.
- The constants $epsilon_0$ and $mu_0$ play dual roles, linked by $c^2 = 1 / (mu_0 epsilon_0)$.

#note[
  In time-varying electrodynamics, two of these equations will be modified. Faraday's law will give $nabla times bold(E) = - (partial bold(B)) / (partial t)$, and Maxwell's displacement current will add a term $mu_0 epsilon_0 (partial bold(E)) / (partial t)$ to the Ampère–Maxwell equation. These modifications couple $bold(E)$ and $bold(B)$ together and give rise to electromagnetic waves. But for static situations, the four equations above are complete and decoupled.
]

#note[
  *Key takeaways for Ampère's law and Gauss's law for magnetism:*
  - Gauss's law for magnetism ($nabla dot bold(B) = 0$) expresses the absence of magnetic monopoles: magnetic field lines are always closed loops.
  - Ampère's circuital law ($integral.cont bold(B) dot dif bold(l) = mu_0 I_"enc"$) relates the circulation of $bold(B)$ to the enclosed current — the magnetostatic counterpart of Gauss's law for $bold(E)$.
  - The differential form $nabla times bold(B) = mu_0 bold(J)$ follows from Ampère's law via Stokes' theorem and shows that currents are the sources of the curl of $bold(B)$.
  - The four static equations ($nabla dot bold(E) = rho / epsilon_0$, $nabla times bold(E) = bold(0)$, $nabla dot bold(B) = 0$, $nabla times bold(B) = mu_0 bold(J)$) mirror each other, with the asymmetry reflecting the nonexistence of magnetic monopoles.
  - Ampère's law is powerful for computing $bold(B)$ in symmetric geometries (infinite wires, solenoids, toroids), just as Gauss's law simplifies $bold(E)$ calculations for symmetric charge distributions.
]

// 磁矢势、库仑规范、矢势的泊松方程、磁通量与矢势环量的关系
== Magnetic Vector Potential and Flux // 磁矢势与磁通量

In the preceding section (§6.3), we established the complete set of magnetostatic field equations:
$
  nabla dot bold(B) = 0, quad nabla times bold(B) = mu_0 bold(J).
$

The divergence-free condition $nabla dot bold(B) = 0$ tells us that the magnetic field is *solenoidal* — its field lines form closed loops without sources or sinks. By the Helmholtz decomposition theorem (§1.5), any solenoidal vector field can be expressed as the curl of some vector field. This leads us to introduce the *magnetic vector potential* $bold(A)$ — a construction that parallels the scalar potential $V$ for the electrostatic field, but adapted to the distinct topological nature of the magnetic field.

Just as $bold(E) = - nabla V$ automatically satisfies $nabla times bold(E) = bold(0)$ in electrostatics, the vector potential will allow us to satisfy $nabla dot bold(B) = 0$ identically in magnetostatics.

=== Definition of the Magnetic Vector Potential // 磁矢势的定义

#definition(name: "Magnetic Vector Potential")[
  The *magnetic vector potential* $bold(A)$ is a vector field defined such that
  $
    bold(B) = nabla times bold(A).
  $
  The SI unit of $bold(A)$ is the weber per meter ($"Wb/m"$), equivalently $"N/A"$ or $"T" dot "m"$.
]

#property[
  - The defining relation $bold(B) = nabla times bold(A)$ automatically guarantees $nabla dot bold(B) = 0$ (since the divergence of a curl is identically zero).
  - Conversely, the Helmholtz decomposition theorem guarantees that *any* solenoidal field in a simply connected region can be represented as the curl of some vector potential.
]

The analogy with electrostatics is illuminating:

#tex-table(
  ("", "Electrostatics", "Magnetostatics"),
  ("Field equation", [$nabla times bold(E) = bold(0)$], [$nabla dot bold(B) = 0$]),
  ("Condition", "Irrotational (curl-free)", "Solenoidal (divergence-free)"),
  ("Potential", [$bold(E) = - nabla V$], [$bold(B) = nabla times bold(A)$]),
  ("Nature", "Scalar potential $V$", "Vector potential $bold(A)$"),
  ("Fixing condition", "Reference point $V(infinity) = 0$", "Gauge fixing (e.g., $nabla dot bold(A) = 0$)"),
)

#note[
  The magnetic vector potential $bold(A)$ is *not uniquely defined*. If $bold(A)$ is a valid vector potential, then $bold(A)' = bold(A) + nabla chi$ (where $chi$ is any scalar function) produces the same magnetic field:
  $
    nabla times bold(A)' = nabla times bold(A) + nabla times (nabla chi) = nabla times bold(A) = bold(B),
  $
  since the curl of a gradient is identically zero. This freedom to add a gradient without changing the physical field $bold(B)$ is called *gauge invariance*, and the transformation $bold(A) -> bold(A) + nabla chi$ is a *gauge transformation*. To obtain a unique $bold(A)$, we must impose an additional condition — a *gauge fixing* condition.
]

#note[
  Compare this with the scalar potential in electrostatics: $V$ is also ambiguous up to an additive constant ($V' = V + C$). There, the gauge freedom is one-dimensional (a constant shift); here, the freedom is infinite-dimensional (any scalar function $chi$). The fixing condition $V(infinity) = 0$ in electrostatics is analogous to imposing a gauge condition on $bold(A)$.
]

=== Coulomb Gauge // 库仑规范

Among the many possible gauge choices, the *Coulomb gauge* (also called the *transverse gauge*) is the simplest and most natural for magnetostatics.

#definition(name: "Coulomb Gauge")[
  The *Coulomb gauge* imposes the condition
  $
    nabla dot bold(A) = 0.
  $
  This fixes the longitudinal (divergence) part of $bold(A)$, leaving only the transverse (curl) degrees of freedom.
]

#property(name: "Properties of the Coulomb Gauge")[
  - The Coulomb gauge is the magnetostatic analogue of the scalar potential condition $nabla dot bold(E) = rho / epsilon_0$ — it removes the gauge freedom by setting the divergence of $bold(A)$ to zero.
  - In the Coulomb gauge, $bold(A)$ is a *transverse field*: its Fourier components are perpendicular to the wave vector.
  - For static fields, the Coulomb gauge is always attainable: given any $bold(A)$ with nonzero divergence, we can perform a gauge transformation $bold(A) -> bold(A) + nabla chi$ where $chi$ satisfies the Poisson equation $nabla^2 chi = - nabla dot bold(A)$, thereby enforcing $nabla dot bold(A)' = 0$.
]

#note[
  In time-varying electrodynamics (§13.3), the Coulomb gauge gives $nabla^2 V = - rho / epsilon_0$ (instantaneous scalar potential) and $nabla^2 bold(A) - (1/c^2) (partial^2 bold(A)) / (partial t^2) = - mu_0 bold(J) + (1/c^2) nabla (partial V) / (partial t)$. The scalar potential in this gauge is the "instantaneous" Coulomb potential — hence the name. But for *static* fields, the Coulomb gauge simply reduces to $nabla dot bold(A) = 0$ as given above.
]

=== Poisson's Equation for the Vector Potential // 矢势的泊松方程

With the Coulomb gauge condition $nabla dot bold(A) = 0$, we can derive a differential equation for $bold(A)$ from Ampère's law.

#theorem(name: "Vector Poisson's Equation in the Coulomb Gauge")[
  In the Coulomb gauge, the magnetic vector potential satisfies the *vector Poisson equation*
  $
    nabla^2 bold(A) = - mu_0 bold(J),
  $
  where $nabla^2 = nabla dot nabla$ is the Laplacian operator applied componentwise:
  $
    nabla^2 A_x = - mu_0 J_x, quad
    nabla^2 A_y = - mu_0 J_y, quad
    nabla^2 A_z = - mu_0 J_z.
  $
]

#proof[
  Starting from Ampère's law and the definition of $bold(A)$:
  $
    nabla times bold(B) = mu_0 bold(J) quad (nabla times (nabla times bold(A))) = mu_0 bold(J).
  $

  Using the vector identity $nabla times (nabla times bold(A)) = nabla (nabla dot bold(A)) - nabla^2 bold(A)$:
  $
    nabla (nabla dot bold(A)) - nabla^2 bold(A) = mu_0 bold(J).
  $

  Imposing the Coulomb gauge $nabla dot bold(A) = 0$, the first term vanishes, yielding the vector Poisson equation:
  $
    nabla^2 bold(A) = - mu_0 bold(J).
  $
]

This is one of the most beautiful results of magnetostatics: in the Coulomb gauge, each Cartesian component of $bold(A)$ satisfies a scalar Poisson equation of exactly the same form as the electrostatic Poisson equation $nabla^2 V = - rho / epsilon_0$. The source term for $A_i$ is $mu_0 J_i$, mirroring the source term $rho / epsilon_0$ for $V$.

#solution(name: "Integral Solution for the Vector Potential")[
  By analogy with the scalar Poisson equation, the solution for each component is:
  $
    A_i(bold(r)) = frac(mu_0, 4 pi) integral_V frac(J_i(bold(r)'), |bold(r) - bold(r)'|) dif V',
  $
  or, in full vector form:
  $
    bold(A)(bold(r)) = frac(mu_0, 4 pi) integral_V frac(bold(J)(bold(r)'), |bold(r) - bold(r)'|) dif V'.
  $

  For a surface current density $bold(K)$:
  $
    bold(A)(bold(r)) = frac(mu_0, 4 pi) integral_S frac(bold(K)(bold(r)'), |bold(r) - bold(r)'|) dif S'.
  $

  For a line current $I$ along a curve $C'$:
  $
    bold(A)(bold(r)) = frac(mu_0, 4 pi) integral_C' frac(I, |bold(r) - bold(r)'|) dif bold(l)'.
  $
]

#proof[
  The scalar Poisson equation $nabla^2 phi = - f$ has the well-known solution $phi(bold(r)) = frac(1, 4 pi) integral f(bold(r)') / |bold(r) - bold(r)'| dif V'$. Applying this componentwise to $nabla^2 A_i = - mu_0 J_i$ yields the integral form above. One can verify directly that this $bold(A)$ satisfies $nabla dot bold(A) = 0$ for static currents satisfying $nabla dot bold(J) = 0$, confirming consistency with the Coulomb gauge.
]

#note[
  *Parallel between electrostatic scalar potential and magnetostatic vector potential:*

  #tex-table(
    ("Quantity", "Electrostatics", "Magnetostatics"),
    ("Field equation", [$nabla^2 V = - rho / epsilon_0$], [$nabla^2 bold(A) = - mu_0 bold(J)$]),
    ("Source", "Charge density $rho$", "Current density $bold(J)$"),
    ("Solution", [$V = frac(1, 4 pi epsilon_0) integral frac(rho, R) dif V'$], [$bold(A) = frac(mu_0, 4 pi) integral frac(bold(J), R) dif V'$]),
    ("Recovery of field", [$bold(E) = - nabla V$], [$bold(B) = nabla times bold(A)$]),
    ("Constant", [$1 / (4 pi epsilon_0)$], [$mu_0 / (4 pi)$]),
  )

  The structural symmetry between these two sets of equations reflects the deep unity of electromagnetism. The different constants ($1 / epsilon_0$ vs $mu_0$) mirror the roles of $bold(E)$ and $bold(B)$ as sources of flux and circulation respectively.
]

=== Magnetic Flux and Circulation of the Vector Potential // 磁通量与矢势环量

The magnetic vector potential is not merely a mathematical convenience — it has a direct physical relation to magnetic flux, mediated by the geometry of the field.

#theorem(name: "Flux-Circulation Relation")[
  The magnetic flux $Phi_B$ through any open surface $S$ is equal to the circulation of the vector potential $bold(A)$ around the closed boundary $C = partial S$ of that surface:
  $
    Phi_B = integral_S bold(B) dot dif bold(S) = integral.cont_C bold(A) dot dif bold(l).
  $
]

#proof[
  By definition, $bold(B) = nabla times bold(A)$. Substituting into the flux integral:
  $
    Phi_B = integral_S bold(B) dot dif bold(S) = integral_S (nabla times bold(A)) dot dif bold(S).
  $

  Applying Stokes' theorem, which converts a surface integral of $nabla times bold(A)$ into a line integral of $bold(A)$ around the boundary:
  $
    integral_S (nabla times bold(A)) dot dif bold(S) = integral.cont_C bold(A) dot dif bold(l).
  $

  Hence $Phi_B = integral.cont_C bold(A) dot dif bold(l)$.
]

#note[
  This relation is gauge-invariant: the left-hand side $Phi_B$ is a physical observable, independent of the choice of gauge. The right-hand side must therefore also be gauge-invariant. Indeed, under a gauge transformation $bold(A) -> bold(A) + nabla chi$:
  $
    integral.cont_C (bold(A) + nabla chi) dot dif bold(l) = integral.cont_C bold(A) dot dif bold(l) + integral.cont_C nabla chi dot dif bold(l) = integral.cont_C bold(A) dot dif bold(l),
  $
  since $integral.cont_C nabla chi dot dif bold(l) = 0$ for any single-valued $chi$ (the line integral of a gradient around a closed loop vanishes). The flux-circulation relation is thus consistent with gauge invariance.
]

The flux-circulation relation provides an alternative way to compute magnetic flux without integrating $bold(B)$ directly. It also reveals that $bold(A)$ plays a fundamental role in quantum mechanics: the Aharonov-Bohm effect demonstrates that $bold(A)$ affects the quantum phase of a charged particle even in regions where $bold(B) = 0$, highlighting that the vector potential is more than a mathematical auxiliary.

#example(name: "Uniform Magnetic Field — Two Gauges")[
  Consider a uniform magnetic field $bold(B) = B_0 hat(bold(z))$. We construct two different vector potentials that both satisfy $nabla times bold(A) = bold(B)$, illustrating the gauge freedom.

  *Gauge choice 1* (symmetric gauge): $bold(A)_1 = frac(1, 2) B_0 (-y, x, 0)$.
  $
    nabla times bold(A)_1 = frac(1, 2) B_0 [ (partial_x (x) - partial_y (-y)) hat(bold(z)) ] = B_0 hat(bold(z)) = bold(B),
  $
  and $nabla dot bold(A)_1 = 0$ (Coulomb gauge).

  *Gauge choice 2* (Landau gauge): $bold(A)_2 = B_0 (-y, 0, 0)$.
  $
    nabla times bold(A)_2 = B_0 [ (partial_x (0) - partial_y (-y)) hat(bold(z)) ] = B_0 hat(bold(z)) = bold(B),
  $
  but $nabla dot bold(A)_2 = 0$ as well (also Coulomb gauge). The gauge transformation linking them is $bold(A)_1 - bold(A)_2 = nabla( - B_0 x y / 2)$.

  Both give the same magnetic flux through any surface: for a rectangle of area $L_x L_y$ in the $"xy"$-plane, $Phi_B = B_0 L_x L_y$, and using either gauge:
  $
    integral.cont_C bold(A)_1 dot dif bold(l) = integral.cont_C bold(A)_2 dot dif bold(l) = B_0 L_x L_y = Phi_B.
  $
]

#example(name: "Flux Through a Loop via the Vector Potential")[
  A circular loop of radius $R$ lies in the $"xy"$-plane, centered at the origin. A magnetic field $bold(B) = B_0 (1 - rho / R) hat(bold(z))$ (decreasing linearly with radius) penetrates the loop. Compute the flux directly and via $bold(A)$.

  *Direct flux calculation:*
  $
    Phi_B = integral_S bold(B) dot dif bold(S) = integral_0^R B_0 (1 - rho / R) 2 pi rho dif rho = 2 pi B_0 integral_0^R (rho - rho^2 / R) dif rho = frac(pi B_0 R^2, 3).
  $

  *Via $bold(A)$:* By symmetry, $bold(A) = A_phi(rho) hat(bold(phi))$. From $bold(B) = nabla times bold(A)$ in cylindrical coordinates:
  $
    B_z = frac(1, rho) (partial (rho A_phi)) / (partial rho) = B_0 (1 - rho / R).
  $
  Integrating: $rho A_phi = B_0 integral (rho - rho^2 / R) dif rho = B_0 (rho^2 / 2 - rho^3 / (3 R))$, so
  $
    A_phi(rho) = B_0 (rho / 2 - rho^2 / (3 R)).
  $
  The circulation around the rim ($rho = R$) gives:
  $
    integral.cont bold(A) dot dif bold(l) = 2 pi R A_phi(R) = 2 pi R B_0 (R / 2 - R^2 / (3 R)) = 2 pi R B_0 frac(R, 6) = frac(pi B_0 R^2, 3),
  $
  matching the direct calculation.
]

#note[
  *Key takeaways for the magnetic vector potential:*
  - $bold(A)$ is defined by $bold(B) = nabla times bold(A)$, automatically satisfying $nabla dot bold(B) = 0$.
  - $bold(A)$ is not unique: gauge transformations $bold(A) -> bold(A) + nabla chi$ leave $bold(B)$ unchanged.
  - The Coulomb gauge $nabla dot bold(A) = 0$ simplifies the field equations and yields the vector Poisson equation $nabla^2 bold(A) = - mu_0 bold(J)$.
  - The integral solution $bold(A)(bold(r)) = frac(mu_0, 4 pi) integral bold(J)(bold(r)') / |bold(r) - bold(r)'| dif V'$ mirrors the electrostatic potential formula.
  - The magnetic flux through a surface equals the circulation of $bold(A)$ around its boundary: $Phi_B = integral.cont_C bold(A) dot dif bold(l)$ — a gauge-invariant relation that directly links the vector potential to a physical observable.
  - These results are the magnetostatic foundation upon which the time-dependent treatment of potentials will build in Chapter 13.
]

// 常见模型：无限长直导线、有限长直导线、圆环轴线、螺线管、均匀载流圆柱体
== Common Models in Magnetostatics // 常见模型：载流导体的磁场

This section serves as a quick-reference table of standard current configurations in magnetostatics, organized by symmetry type. Each entry specifies the applicable method (Ampère's circuital law or Biot-Savart law) and gives the magnetic field $bold(B)$, the vector potential $bold(A)$ (in the Coulomb gauge), and key limiting behaviors.

// ============================================================================
// Cylindrical Symmetry
// ============================================================================

=== Cylindrical Symmetry // 柱对称模型

Configurations invariant under translations along the $z$-axis and rotations about it. Use a coaxial circular Amperian loop of radius $rho$ and length $L$. The field is azimuthal: $bold(B) = B(rho) hat(bold(phi))$ in cylindrical coordinates $(rho, phi, z)$.

#example(name: "Infinite Straight Wire")[ // 无限长直导线
  A steady current $I$ flows along the $z$-axis. (§6.3 gives the full Ampère derivation.)
  $
    bold(B)(rho) = frac(mu_0 I, 2 pi rho) hat(bold(phi)), quad
    bold(A)(rho) = frac(mu_0 I, 2 pi) ln frac(rho_0, rho) hat(bold(z)),
  $
  where $rho_0$ is an arbitrary reference radius (the vector potential diverges at infinity, mirroring the infinite line charge in electrostatics). The magnetic flux through a rectangular strip of length $L$ extending from $rho = a$ to $rho = b$ is:
  $
    Phi_B = integral_a^b bold(B) dot (L dif rho hat(bold(phi))) = frac(mu_0 I L, 2 pi) ln frac(b, a).
  $

  #figure(
    image("img/infinite_wire_magnetic_field.png", width: 100%),
    caption: [Magnetic field of an infinite straight wire.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:infinite_wire_magnetic_field>
]

#example(name: "Uniformly Conducting Solid Cylinder")[ // 均匀载流圆柱体
  Radius $R$, uniform current density $bold(J) = J hat(bold(z))$ (total current $I = J pi R^2$), infinite along $z$.
  $
    bold(B) = cases(
      frac(mu_0 I, 2 pi rho) hat(bold(phi)) & (rho > R),
      frac(mu_0 J rho, 2) hat(bold(phi)) & (rho < R),
    )
    quad
    bold(A) = cases(
      frac(mu_0 I, 2 pi) ln frac(rho_0, rho) hat(bold(z)) & (rho >= R),
      frac(mu_0 J, 4) (R^2 - rho^2) hat(bold(z)) & (rho < R),
    )
  $
  Inside the cylinder the field grows linearly: $B(rho) prop rho$; outside it is identical to an infinite line wire carrying the same total current $I$.

  #figure(
    image("img/solid_cylinder_magnetic_field.png", width: 100%),
    caption: [Magnetic field of a uniformly conducting solid cylinder.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:solid_cylinder_magnetic_field>
]

#example(name: "Coaxial Cable")[ // 同轴电缆
  An inner solid conductor of radius $a$ carrying current $I$ outward, and an outer conducting shell of inner radius $b$ and outer radius $c$ carrying current $I$ return. Assume uniform current densities in both conductors.
  $
    bold(B) = cases(
      frac(mu_0 I, 2 pi a^2) rho hat(bold(phi)) & (0 < rho < a),
      frac(mu_0 I, 2 pi rho) hat(bold(phi)) & (a < rho < b),
      frac(mu_0 I, 2 pi rho) frac(c^2 - rho^2, c^2 - b^2) hat(bold(phi)) & (b < rho < c),
      bold(0) & (rho > c),
    )
  $
  The field is confined entirely to the region $rho < c$: the currents in the inner and outer conductors cancel for $rho > c$, making the coaxial cable a *shielded* transmission line. This is the magnetic analogue of the parallel-plate capacitor — charge (or current) confinement leads to field confinement.
]

// ============================================================================
// Solenoidal Configurations
// ============================================================================

=== Solenoidal Configurations // 螺线管类模型

Configurations based on helical or toroidal windings. The field is predominantly axial (solenoid) or azimuthal (toroid), and Ampère's law with a suitably chosen rectangular or circular Amperian loop gives the solution.

#example(name: "Infinite Solenoid")[ // 无限长螺线管
  $n$ turns per unit length, each carrying current $I$. (§6.3 gives the full Ampère derivation.)
  $
    bold(B) = cases(
      mu_0 n I hat(bold(z)) & (text("inside")),
      bold(0) & (text("outside")),
    )
    quad
    bold(A) = frac(mu_0 n I rho, 2) hat(bold(phi)) quad (text("inside")),
  $
  where $rho$ is the radial distance from the solenoid axis. The interior field is *uniform* — the magnetic analogue of the uniform field between parallel capacitor plates. Outside, both $bold(B) = bold(0)$ and $bold(A)$ is constant (can be taken as zero after a gauge transformation). The magnetic flux through a single turn is $Phi_B = mu_0 n I pi R^2$, where $R$ is the solenoid radius.

  For a *finite* solenoid of length $L$, the on-axis field at the centre is:
  $
    B_z(0) = mu_0 n I frac(L, sqrt(L^2 + 4 R^2)),
  $
  approaching $mu_0 n I$ as $L >> R$. At the end of a long solenoid, $B_z approx mu_0 n I / 2$.
]

#example(name: "Toroid")[ // 环形螺线管（螺绕环）
  $N$ total turns wound around a torus of mean radius $R$, each carrying current $I$. (§6.3 gives the derivation.)
  $
    bold(B)(r) = cases(
      frac(mu_0 N I, 2 pi r) hat(bold(phi)) & (text("inside")),
      bold(0) & (text("outside")),
    )
  $
  The field is *non-uniform* inside: $B prop 1/r$. For a toroid of large radius ($R >>$ cross-sectional radius $a$), the field is approximately uniform: $B approx mu_0 n I$ with $n = N / (2 pi R)$.

  The vector potential outside a toroid cannot be globally defined in the Coulomb gauge due to the nontrivial topology — a manifestation of the Aharonov-Bohm effect.
]

// ============================================================================
// Axial Symmetry — Finite Distributions (Biot-Savart)
// ============================================================================

=== Axial Symmetry: Finite Current Distributions // 轴对称有限电流分布

These configurations have rotational symmetry about the $z$-axis but are finite in extent. Ampère's law alone is insufficient; the field is obtained by direct integration of the Biot-Savart law. Results are simplest on the symmetry axis.

#example(name: "Finite Straight Wire")[ // 有限长直导线
  A straight wire segment of length $L$, carrying current $I$, lying along the $z$-axis from $z = -L/2$ to $z = L/2$. By the Biot-Savart law, the magnetic field at a distance $rho$ from the wire, in the plane perpendicular to its midpoint, is:
  $
    bold(B)(rho) = frac(mu_0 I, 4 pi rho) (sin theta_2 - sin theta_1) hat(bold(phi)),
  $
  where $theta_1$ and $theta_2$ are the angles subtended by the wire endpoints relative to the observation point:
  $
    sin theta_2 = frac(L/2, sqrt(rho^2 + (L/2)^2)), quad
    sin theta_1 = - frac(L/2, sqrt(rho^2 + (L/2)^2)).
  $
  Hence:
  $
    B(rho) = frac(mu_0 I L, 4 pi rho sqrt(rho^2 + (L/2)^2)).
  $
  - For $L -> infinity$: $B = mu_0 I / (2 pi rho)$, recovering the infinite wire result.
  - For $rho << L$ (near the wire, away from ends): $B approx mu_0 I / (2 pi rho)$.
  - For $rho >> L$ (far field): $B approx mu_0 I L / (4 pi rho^2)$ — the field of a current element.
]

#example(name: "Circular Current Loop — On Axis")[ // 载流圆环轴线磁场
  A circular loop of radius $R$ carrying steady current $I$, lying in the $"xy"$-plane centered at the origin. By the Biot-Savart law, the field on the $z$-axis is:
  $
    bold(B)(z) = frac(mu_0 I R^2, 2 (R^2 + z^2)^(3/2)) hat(bold(z)).
  $
  The vector potential (in Coulomb gauge) on the axis is zero by symmetry; off-axis it requires elliptic integrals. In the far-field limit ($|z| >> R$):
  $
    bold(B)(z) approx frac(mu_0, 2 pi) frac(m, |z|^3) hat(bold(z)),
    quad m = I pi R^2 = I A,
  $
  where $m$ is the *magnetic dipole moment* of the loop (see the Magnetic Dipole subsection below). The field decays as $1/|z|^3$, characteristic of a dipole.

  - At the centre ($z = 0$): $B(0) = mu_0 I / (2 R)$.
  - For $N$ closely spaced turns (a coil): $B(z) = mu_0 N I R^2 / (2 (R^2 + z^2)^(3/2))$.

  #figure(
    image("img/magnetic_field_loop.png", width: 35%),
    caption: [Magnetic field of a circular current loop.],
    placement: auto,
    supplement: [Fig.]
  ) <fig:magnetic_field_loop>
]
// ============================================================================
// Magnetic Dipole
// ============================================================================

=== Magnetic Dipole // 磁偶极子

Just as the electric dipole is the fundamental building block for multipole expansions of the electrostatic field, the *magnetic dipole* plays the same role in magnetostatics. While a magnetic monopole does not exist, a magnetic dipole can be realized physically as a small current loop or as a bar magnet.

#definition(name: "Magnetic Dipole Moment")[
  For a planar current loop of area $A$ carrying current $I$, the *magnetic dipole moment* is:
  $
    bold(m) = I bold(A),
  $
  where $bold(A) = A hat(bold(n))$ is the vector area, with $hat(bold(n))$ oriented by the right-hand rule (fingers along current, thumb gives $hat(bold(n))$). The SI unit is $"A" dot "m"^2$.

  For a general current distribution $bold(J)(bold(r))$, the magnetic dipole moment is:
  $
    bold(m) = frac(1, 2) integral_V bold(r) times bold(J)(bold(r)) dif V.
  $
]

#example(name: "Magnetic Dipole Field")[ // 磁偶极子的磁场
  In the far-field limit ($r >>$ loop radius $R$), the magnetic field of a dipole $bold(m) = m hat(bold(z))$ in spherical coordinates is:
  $
    bold(B)(r, theta) = frac(mu_0, 4 pi) frac(m, r^3) (2 cos theta hat(bold(r)) + sin theta hat(bold(theta))).
  $
  In Cartesian form:
  $
    bold(B)(bold(r)) = frac(mu_0, 4 pi) frac(1, r^3) [3(bold(m) dot hat(bold(r))) hat(bold(r)) - bold(m)].
  $

  The vector potential of a magnetic dipole is:
  $
    bold(A)(bold(r)) = frac(mu_0, 4 pi) frac(bold(m) times hat(bold(r)), r^2).
  $

  - The field decays as $1/r^3$, exactly like the electric dipole field in electrostatics.
  - The magnetic field lines form closed loops, exiting the north pole (方向沿 $bold(m)$) and entering the south pole.
  - For a circular loop of radius $R$, the far-field expression matches the on-axis result from the previous example when $|z| >> R$.
]

#example(name: "Force and Torque on a Magnetic Dipole")[ // 磁偶极子受力和力矩
  A magnetic dipole $bold(m)$ placed in an external magnetic field $bold(B)_"ext"$ experiences:
  - *Torque* (tending to align the dipole with the field):
    $
      bold(tau) = bold(m) times bold(B)_"ext".
    $
  - *Force* (in a non-uniform field):
    $
      bold(F) = nabla (bold(m) dot bold(B)_"ext").
    $
  - *Potential energy*:
    $
      U = - bold(m) dot bold(B)_"ext".
    $

  These relations are directly analogous to those for an electric dipole $bold(p)$ in an external electric field $bold(E)$ (§3.5), with $bold(p) -> bold(m)$ and $bold(E) -> bold(B)$.
]

#note[
  *Quick-reference guide by symmetry type:*
  - *Cylindrical (infinite)*: choose a coaxial circular Amperian loop; $bold(B) = B(rho) hat(bold(phi))$ is azimuthal and constant on the loop. Includes straight wires and coaxial cables.
  - *Solenoidal*: choose a rectangular Amperian loop with one side inside and one outside; $B$ is axial and uniform inside. Includes solenoids and toroids.
  - *Finite axial*: use the Biot-Savart law directly; closed-form results exist only on the symmetry axis. Includes finite wires and circular loops.
  - *Dipole far field*: $bold(B) prop 1/r^3$, given by $bold(B)(r) = (mu_0 / 4 pi) [3(bold(m) dot hat(bold(r))) hat(bold(r)) - bold(m)] / r^3$.
]

// 回旋运动、螺旋运动、E×B 漂移、磁镜效应；霍尔效应（霍尔电压、霍尔系数、载流子类型判定）
== Motion of Charged Particles in Magnetic Fields // 带电粒子在磁场中的运动

// 安培力、平行载流导线相互作用、载流线圈力矩与磁偶极矩、静磁能（场能表达式）
== Magnetic Forces on Currents and Energy // 磁场对电流的作用与磁能

#part("Electromagnetic Induction and Time-Varying Fields") // 电磁感应与时变场

= Electromagnetic Induction // 电磁感应

== Faraday's Law of Induction // 法拉第电磁感应定律

Of the four Maxwell equations, Faraday's law is perhaps the most directly tied to practical technology — it is the operating principle behind electrical generators, transformers, and inductive sensors. Its discovery by Michael Faraday in 1831 marked the culmination of a decade-long search for the relationship between electricity and magnetism.

Faraday's key insight was that a *changing* magnetic field can produce an electric current, a phenomenon he called *electromagnetic induction* (电磁感应). This was revolutionary: previously, scientists had only observed that steady currents produce steady magnetic fields (Oersted, Ampère). Faraday showed the converse effect — magnetism can produce electricity, but only if the magnetic field is *changing* in time.

=== Experimental Foundation // 实验基础

Faraday's original experiments can be reproduced with a simple setup: a coil of wire connected to a sensitive galvanometer, and a bar magnet. The galvanometer deflects only when the magnet is *moving* relative to the coil — that is, when the magnetic flux through the coil is changing. A steady magnet produces no current, no matter how strong it is.

The quantity that determines the induced electromotive force (EMF) is the *magnetic flux* through the loop (defined in §6.3):

$
  Phi_B = integral_S bold(B) dot dif bold(S).
$

The experimental results can be summarised by two key observations:

1. An EMF is induced in a loop whenever the magnetic flux through the loop changes with time.
2. The magnitude of the induced EMF is proportional to the rate of change of the flux.

=== Faraday's Law — Integral Form // 法拉第定律——积分形式

#law(name: "Faraday's Law of Induction — Integral Form")[
  The electromotive force $cal(E)$ induced around a closed loop $C$ (the boundary of an open surface $S$) is equal to the negative rate of change of the magnetic flux through that surface:
  $
    cal(E) = integral.cont_C bold(E) dot dif bold(l) = - frac(dif, dif t) integral_S bold(B) dot dif bold(S) = - frac(dif Phi_B, dif t).
  $
  Here $cal(E)$ is the induced EMF, defined as the line integral of the total electric field $bold(E)$ around the loop. The SI unit of EMF is the volt ($"V"$).
]

#law(name: "Lenz's Law")[
  The negative sign in Faraday's law embodies *Lenz's law*: the induced EMF always acts in such a direction as to *oppose* the change that produced it.
  
  In other words, the induced current creates a magnetic field that tries to cancel the change in the external flux:
  - If $Phi_B$ is increasing, the induced current produces a field opposite to the external field.
  - If $Phi_B$ is decreasing, the induced current produces a field in the same direction as the external field.
]

#note[
  Lenz's law is not an independent law but a physical interpretation of the minus sign. It guarantees energy conservation: if the induced EMF *aided* the change, we would obtain a runaway positive feedback loop, violating conservation of energy.
]

#example(name: "Rectangular Loop in a Time-Varying Magnetic Field")[
  A rectangular loop of width $w$ and height $h$ lies in the $"xy"$-plane. A uniform but time-dependent magnetic field $bold(B)(t) = B_0 sin(omega t) hat(bold(z))$ penetrates the loop.

  The magnetic flux through the loop is:
  $
    Phi_B(t) = integral_S bold(B) dot dif bold(S) = B_0 sin(omega t) w h.
  $

  By Faraday's law, the induced EMF is:
  $
    cal(E)(t) = - frac(dif Phi_B, dif t) = - omega B_0 w h cos(omega t).
  $

  The induced electric field circulates around the loop. By symmetry, it is constant in magnitude along each side and tangential to the loop. For a circular loop of radius $R$, we can find $bold(E)$ directly: by symmetry $bold(E) = E(t) hat(bold(phi))$, and
  $
    cal(E) = integral.cont bold(E) dot dif bold(l) = 2 pi R E(t) = - pi R^2 frac(dif B, dif t),
  $
  giving $E(t) = - frac(R, 2) frac(dif B, dif t)$.
]

=== Faraday's Law — Differential Form // 法拉第定律——微分形式

The integral form describes the EMF around a finite loop. To obtain a local (pointwise) relation, we apply Stokes' theorem to the left-hand side:

$
  integral.cont_C bold(E) dot dif bold(l) = integral_S (nabla times bold(E)) dot dif bold(S).
$

Faraday's law then becomes:

$
  integral_S (nabla times bold(E)) dot dif bold(S) = - frac(dif, dif t) integral_S bold(B) dot dif bold(S).
$

For a stationary surface $S$ (the loop does not deform or move), the time derivative can be taken inside the integral:

$
  integral_S (nabla times bold(E)) dot dif bold(S) = - integral_S (partial bold(B) / partial t) dot dif bold(S).
$

Since this holds for *any* surface $S$, the integrands must be equal pointwise:

#law(name: "Faraday's Law — Differential Form")[
  $
    nabla times bold(E) = - frac(partial bold(B), partial t).
  $
]

#note[
  The differential form $nabla times bold(E) = - partial bold(B) / partial t$ tells us that a time-varying magnetic field generates a *rotational* (curl) electric field. This is the first modification to the static equations: in electrostatics we had $nabla times bold(E) = bold(0)$; in electrodynamics, the curl of $bold(E)$ is proportional to the rate of change of $bold(B)$.

  Compare:
  $
    text("Electrostatics"): quad nabla times bold(E) = bold(0),
    quad
    text("Electrodynamics"): quad nabla times bold(E) = - frac(partial bold(B), partial t).
  $
]

#property(name: "Key Properties of the Induced Electric Field")[
  - The induced electric field is *non-conservative*: its circulation around a closed loop is nonzero when $dif Phi_B / dif t != 0$.
  - Unlike the electrostatic field, the induced field cannot be derived from a scalar potential $V$ alone (since $nabla times bold(E) != 0$). In time-varying situations, the full electric field is given by $bold(E) = - nabla V - partial bold(A) / partial t$, where $bold(A)$ is the vector potential (§6.4).
  - The induced electric field lines are *closed loops* (they have no sources or sinks), as $nabla dot bold(E) = rho / epsilon_0$ still holds — the divergence of $bold(E)$ is determined only by charge density.
  - Faraday's law applies regardless of whether a physical conducting loop is present: a time-varying magnetic field produces an electric field in *empty space* as well.
]

#note[
  *Summary of Faraday's Law:*
  - Integral form: $cal(E) = - dif Phi_B / dif t$ — a changing magnetic flux induces an EMF around any closed loop.
  - Lenz's law: the induced EMF opposes the change that produced it (energy conservation).
  - Differential form: $nabla times bold(E) = - partial bold(B) / partial t$ — a time-varying magnetic field is a source of curl for the electric field.
  - This is the first dynamical coupling between $bold(E)$ and $bold(B)$ in Maxwell's equations. The second coupling (how a time-varying $bold(E)$ produces $bold(B)$) will be introduced in §9.1 through the displacement current.
  - The total electric field in electrodynamics is the sum of a conservative part (from charges) and a solenoidal part (from time-varying magnetic fields).
]

== Motional EMF and Induced Electric Field // 动生电动势与感应电场
// === Motional EMF（动生电动势）
// 导体在静磁场中运动产生的电动势：cal(E)_motional = ∮(v×B)·dl
// 物理图像：洛伦兹力对自由电荷做功分离电荷（注意：总功率为零的悖论与分析）
// 经典例子：滑动导轨（Hall bar）—— 电动势、电流、安培力、功率守恒
// === Induced Electric Field（感应电场）
// 时变磁场在自由空间产生的感应电场（即使没有导体存在）
// 感应电场的非保守性：∮ E·dl = -dΦ_B/dt ≠ 0，不能定义标势
// 感应电场线的闭合性（无源场）：∇·E_induced = 0
// 与静电场的统一：总电场 E = E_static + E_induced——E_static 由电荷产生，E_induced 由时变磁场产生
// 应用示例：变压器（互感基本原理）、电子感应加速器（betatron 原理）
// Note：两种电动势的对比表——产生机制、物理来源、适用范围

The EMF in Faraday's law, $cal(E) = - dif Phi_B / dif t$, can arise through two physically distinct mechanisms: (1) the *motional EMF* produced when a conductor moves through a magnetic field, and (2) the *induced electric field* generated by a time-varying magnetic field, independent of any motion. Although these mechanisms differ fundamentally in their microscopic origin, both are captured by the same flux rule — a remarkable unification that underscores the power of the field-theoretic viewpoint.

=== Motional EMF // 动生电动势

When a conductor moves through a static magnetic field, the free charges inside the conductor experience the magnetic Lorentz force:

$
  bold(F) = q (bold(v) times bold(B)).
$

This force pushes charges along the conductor, separating positive and negative charges until the resulting electrostatic field balances the magnetic force. The *motional EMF* is defined as the line integral of the effective force per unit charge along the conductor:

#definition(name: "Motional EMF")[
  For a conductor moving with velocity $bold(v)$ in a magnetic field $bold(B)$, the motional EMF along a curve $C$ is:
  $
    cal(E)_"mot" = integral.cont_C (bold(v) times bold(B)) dot dif bold(l).
  $
  This is equivalent to the rate at which the conductor "cuts" magnetic field lines.
]

#example(name: "Sliding Bar on U-Shaped Rails")[ // 滑动导轨
  Consider a U-shaped conducting rail with a movable bar of length $L$ sliding frictionlessly to the right at constant velocity $bold(v) = v hat(bold(x))$. A uniform magnetic field $bold(B) = B hat(bold(z))$ points out of the page. A resistor $R$ is connected across the rails.

  *EMF:* The motional EMF is generated in the moving bar. For the bar, $bold(v) times bold(B) = v B hat(bold(y))$, directed along the bar from bottom to top. The EMF is:
  $
    cal(E) = integral_0^L (v B) dif y = v B L.
  $
  By Lenz's law, the induced current flows clockwise (opposing the increase in flux).

  *Current:* $I = cal(E) / R = v B L / R$, flowing clockwise through the circuit.

  *Magnetic force on the bar:* The current-carrying bar in the magnetic field experiences $bold(F)_B = I bold(L) times bold(B) = I L B (- hat(bold(x)))$ — a force to the left, opposing the motion. Magnitude: $F_B = I L B = (v B^2 L^2) / R$.

  *Power balance:* 
  - Power input (external agent pulling the bar): $P_"in" = F_("ext") v = F_B v = (v^2 B^2 L^2) / R$.
  - Power dissipated (Joule heating in resistor): $P_R = I^2 R = (v^2 B^2 L^2) / R$.
  - $P_"in" = P_R$ — mechanical work is converted entirely into electrical energy, demonstrating conservation of energy.

  This example resolves the apparent paradox that magnetic forces do no work (since $bold(F)_B perp bold(v)$). The magnetic force *transfers* mechanical energy from the external agent to electrical energy, acting as a mediator rather than a source of work.
]

#note[
  The motional EMF arises purely from the Lorentz force in a moving conductor — no time-varying magnetic field is required. In the rest frame of the bar, the magnetic field $bold(B)$ transforms (relativistically) into an electric field $bold(E)' = bold(v) times bold(B)$, which is the source of the EMF in that frame. This relativistic perspective unifies motional EMF with the induced electric field (next subsection) under the umbrella of electromagnetic field transformations (to be explored in §17.3).
]

=== Induced Electric Field // 感应电场

Faraday's law reveals a profound fact: even in the absence of any conductor or material medium, a time-varying magnetic field produces an electric field in free space. This *induced electric field* exists independently of whether a wire is present to detect it.

#definition(name: "Induced Electric Field")[
  The *induced electric field* $bold(E)_"ind"$ is the electric field generated by a time-varying magnetic field, satisfying:
  $
    nabla times bold(E)_"ind" = - frac(partial bold(B), partial t), quad nabla dot bold(E)_"ind" = 0.
  $
  Unlike the electrostatic field, the induced electric field is *non-conservative* and its field lines form *closed loops*.
]

#property(name: "Properties of the Induced Electric Field")[
  - *Non-conservative:* $integral.cont_C bold(E)_"ind" dot dif bold(l) = - dif Phi_B / dif t != 0$ — the circulation is nonzero whenever the magnetic flux changes.
  - *Solenoidal:* $nabla dot bold(E)_"ind" = 0$ — the induced field has no sources or sinks; its field lines are closed loops.
  - *No scalar potential:* Because $nabla times bold(E)_"ind" != 0$, it cannot be expressed as the gradient of a scalar function. In time-varying situations, the full electric field is expressed using both scalar and vector potentials:
    $
      bold(E) = - nabla V - frac(partial bold(A), partial t),
    $
    where $- nabla V$ is the conservative part (from charges) and $- partial bold(A) / partial t$ is the solenoidal part (from changing magnetic fields). This extends the electrostatic relation $bold(E) = - nabla V$.
]

#example(name: "Transformer — The Betatron Principle")[ // 变压器与电子感应加速器
  *Transformer principle:* Two coils wound around a common ferromagnetic core. When the current in the primary coil changes, the magnetic flux through the secondary coil changes, inducing an EMF:
  $
    cal(E)_2 = - M frac(dif I_1, dif t),
  $
  where $M$ is the mutual inductance (to be studied in §8.3). This is the operating principle of every electrical transformer.

  *Betatron (electron induction accelerator):* An electron accelerator that uses a time-varying magnetic field to accelerate electrons in a circular orbit. A changing magnetic field $B(t)$ (directed perpendicular to the orbit plane) generates an azimuthal induced electric field:
  $
    E_phi = - frac(R, 2) frac(dif B_"avg", dif t),
  $
  where $B_"avg"$ is the average magnetic field inside the orbit. The electron gains energy from the work done by $E_phi$ each revolution. The stable orbit condition requires the field at the orbit $B_"orb"$ to satisfy $B_"orb" = B_"avg" / 2$ (the *betatron condition*).

  The betatron beautifully demonstrates that the induced electric field is a real physical field — it exerts forces and does work on charged particles even in vacuum, without any conductor present.
]

=== Unification: The Total Electric Field // 统一：总电场

The key conceptual advance of electrodynamics over electrostatics is that the electric field now has *two independent sources*:

$
  bold(E) = bold(E)_"static" + bold(E)_"ind",
$

where $bold(E)_"static"$ is produced by electric charges ($nabla dot bold(E)_"static" = rho / epsilon_0$, $nabla times bold(E)_"static" = bold(0)$) and $bold(E)_"ind"$ is produced by time-varying magnetic fields ($nabla dot bold(E)_"ind" = 0$, $nabla times bold(E)_"ind" = - partial bold(B) / partial t$).

#note[
  *Comparison of motional EMF and induced electric field:*

  #tex-table(
    ("Property", "Motional EMF", "Induced Electric Field"),
    ("Source", "Motion of conductor through $bold(B)$", "Time-varying $bold(B)$ in free space"),
    ("Microscopic origin", "Lorentz force $bold(F) = q (bold(v) times bold(B))$", "Faraday's law $nabla times bold(E) = - partial bold(B) / partial t$"),
    ("Requires conductor?", "Yes (charge carriers must move)", "No (exists in vacuum)"),
    ("cal(E) formula", "$cal(E) = integral.cont (bold(v) times bold(B)) dot dif bold(l)$", "$cal(E) = - dif / dif t integral_S bold(B) dot dif bold(S)$"),
    ("Frame dependence", "Exists in lab frame; transforms to $bold(E)$ in moving frame", "Lorentz-invariant (frame-independent flux change)"),
    ("Applicable where", "Generators, sliding contacts", "Transformers, betatrons, eddy currents"),
  )

  Despite their different microscopic origins, both mechanisms are quantitatively captured by the single equation $cal(E) = - dif Phi_B / dif t$ — the flux rule. This unification is one of the greatest triumphs of Faraday's experimental insight and Maxwell's mathematical formulation.
]

== Inductance // 电感
// 自感现象：回路中电流变化产生的自感电动势 cal(E)_L = -L dI/dt
// 自感系数 L = NΦ/I 的定义，与回路几何形状的关系
// 自感计算示例：长直螺线管、同轴电缆（单位长度）
// 互感现象：回路1的电流变化在回路2中产生互感电动势 cal(E)_2 = -M dI_1/dt
// 互感系数 M 的互易性：M_12 = M_21（Neumann 公式的对称性证明）
// Neumann 公式：M = (μ₀/4π) ∮∮ (dl₁·dl₂)/r
// RL 电路暂态过程：电流增长与衰减的时间常数 τ = L/R
// 耦合系数 k = M/√(L₁L₂)（0 ≤ k ≤ 1）
// Note：电感是电路中"磁场惯性"的量度——类比质量在力学中的作用

When a circuit carries a time-varying current, the changing magnetic flux through the circuit itself (or through a nearby circuit) induces an EMF that opposes the change. This phenomenon — *inductance* — is the magnetic analogue of inertia in mechanics: just as mass opposes changes in velocity, inductance opposes changes in current.

=== Self-Inductance // 自感

#definition(name: "Self-Inductance")[
  For a circuit carrying current $I$, the *self-inductance* $L$ is defined as the ratio of the total magnetic flux linkage $N Phi_B$ (where $N$ is the number of turns and $Phi_B$ is the flux through each turn) to the current:
  $
    L = frac(N Phi_B, I).
  $
  The SI unit of inductance is the *henry* ($"H"$), where $1 "H" = 1 "Wb" / "A" = 1 "V" dot "s" / "A"$.

  When the current changes, the induced EMF (by Faraday's law) is:
  $
    cal(E)_L = - frac(d (N Phi_B), d t) = - L frac(dif I, dif t).
  $
]

#property(name: "Properties of Self-Inductance")[
  - Inductance depends only on the geometry of the circuit (shape, size, number of turns) and the magnetic properties of the surrounding medium.
  - For a circuit in a linear medium (constant $mu$), $L$ is independent of the current $I$.
  - The EMF $cal(E)_L = - L dif I / dif t$ always opposes the change in current (Lenz's law): if $I$ is increasing, $cal(E)_L$ is negative (opposing the increase); if $I$ is decreasing, $cal(E)_L$ is positive (opposing the decrease).
]

#example(name: "Self-Inductance of a Long Solenoid")[ // 长直螺线管的自感
  A long solenoid of length $l$, cross-sectional area $A = pi R^2$, and $n$ turns per unit length (total $N = n l$ turns). From §6.5, the interior magnetic field is uniform: $B = mu_0 n I$.

  The flux through a single turn: $Phi_B = B A = mu_0 n I pi R^2$.
  The total flux linkage: $N Phi_B = (n l) (mu_0 n I pi R^2) = mu_0 n^2 I pi R^2 l$.

  Hence:
  $
    L = frac(N Phi_B, I) = mu_0 n^2 pi R^2 l = mu_0 n^2 V,
  $
  where $V = pi R^2 l$ is the volume of the solenoid.

  Key observation: $L$ is proportional to $n^2$ (doubling the turns quadruples the inductance) and to the volume, consistent with the magnetic energy interpretation (§8.4).
]

#example(name: "Self-Inductance of a Coaxial Cable (per unit length)")[ // 同轴电缆自感
  A coaxial cable consists of an inner solid conductor of radius $a$ and an outer conducting shell of radius $b$ ($b > a$). For a length $l$ carrying current $I$ with return path through the outer shell, the magnetic field exists only in the region $a < rho < b$ (neglecting internal flux in the conductors):
  $
    B(rho) = frac(mu_0 I, 2 pi rho), quad a < rho < b.
  $

  The magnetic flux through a rectangular strip of length $l$ and width $(b-a)$ between the conductors is:
  $
    Phi_B = integral_a^b B(rho) l dif rho = frac(mu_0 I l, 2 pi) ln frac(b, a).
  $

  The self-inductance per unit length is:
  $
    frac(L, l) = frac(mu_0, 2 pi) ln frac(b, a).
  $

  For typical cables with $b/a approx 2$-$10$, $L/l approx 0.1$-$0.5$ $"mu H/m"$.
]

=== Mutual Inductance // 互感

#definition(name: "Mutual Inductance")[
  Consider two circuits $C_1$ and $C_2$. When a time-varying current $I_1$ in circuit $C_1$ produces a magnetic flux $Phi_(2←1)$ through circuit $C_2$, the *mutual inductance* $M_21$ is defined as:
  $
    M_21 = frac(N_2 Phi_(2←1), I_1),
  $
  where $N_2$ is the number of turns of circuit $C_2$. The EMF induced in circuit $C_2$ due to $I_1$ is:
  $
    cal(E)_2 = - M_21 frac(dif I_1, dif t).
  $
  Similarly, $cal(E)_1 = - M_12 frac(dif I_2, dif t)$ for the effect of $C_2$ on $C_1$.
]

#theorem(name: "Reciprocity of Mutual Inductance")[
  The mutual inductance coefficients are symmetric:
  $
    M_12 = M_21 = M.
  $
  This reciprocity is a consequence of the symmetry of the Neumann formula and, more fundamentally, of the linearity and self-adjointness of the magnetostatic field equations.
]

For two circuits of arbitrary shape, the mutual inductance can be expressed in terms of a double line integral:

#theorem(name: "Neumann's Formula")[
  The mutual inductance between two closed circuits $C_1$ and $C_2$ is given by:
  $
    M = frac(mu_0, 4 pi) integral.cont_(C_1) integral.cont_(C_2) frac(dif bold(l)_1 dot dif bold(l)_2, |bold(r)_1 - bold(r)_2|).
  $
]

#proof[
  The magnetic vector potential produced by circuit $C_1$ at a point on $C_2$ is (from §6.4):
  $
    bold(A)_1(bold(r)_2) = frac(mu_0 I_1, 4 pi) integral.cont_(C_1) frac(dif bold(l)_1, |bold(r)_2 - bold(r)_1|).
  $

  The flux through $C_2$ is $Phi_(2←1) = integral.cont_(C_2) bold(A)_1 dot dif bold(l)_2$. Substituting:
  $
    Phi_(2←1) = frac(mu_0 I_1, 4 pi) integral.cont_(C_2) integral.cont_(C_1) frac(dif bold(l)_1 dot dif bold(l)_2, |bold(r)_2 - bold(r)_1|).
  $

  Since $M = Phi_(2←1) / I_1$, and $|bold(r)_2 - bold(r)_1| = |bold(r)_1 - bold(r)_2|$, we obtain Neumann's formula. The symmetry under exchange of indices $(1, 2)$ is manifest, proving $M_12 = M_21$.
]

#definition(name: "Coupling Coefficient")[
  For two circuits with self-inductances $L_1$ and $L_2$ and mutual inductance $M$, the *coupling coefficient* $k$ is defined as:
  $
    k = frac(M, sqrt(L_1 L_2)), quad 0 <= k <= 1.
  $
  - $k = 0$: no coupling (circuits are far apart or orthogonal).
  - $k = 1$: perfect coupling (all flux from one circuit links the other, e.g., an ideal transformer with a common core).
  - $0 < k < 1$: partial coupling (flux leakage between circuits).
]

=== RL Circuit Transient // RL 电路暂态过程

#example(name: "RL Circuit — Current Growth and Decay")[ // RL 电路的电流增长与衰减
  Consider a series $R L$ circuit (a resistor $R$ and an inductor $L$ connected to a voltage source $V_0$ through a switch).

  *Current growth ($t > 0$, switch closed at $t = 0$):* By Kirchhoff's voltage law:
  $
    V_0 - L frac(dif I, dif t) - I R = 0.
  $
  This first-order differential equation has the solution:
  $
    I(t) = frac(V_0, R) (1 - e^(-t / tau)), quad tau = frac(L, R).
  $
  The current approaches the steady-state value $V_0 / R$ exponentially with time constant $tau = L / R$.

  *Current decay ($t > 0$, source shorted after steady state):* With $V_0 = 0$:
  $
    I(t) = frac(V_0, R) e^(-t / tau),
  $
  where $tau = L / R$ is the same time constant.

  *Physical interpretation:* The time constant $tau = L / R$ describes how quickly the circuit responds to changes. A larger $L$ means more "magnetic inertia" — the current takes longer to change. A larger $R$ means faster dissipation, hence a shorter time constant.
]

#note[
  *Inductance as magnetic inertia:* In mechanics, mass $m$ opposes changes in velocity ($F = m a = m dif v / dif t$). In circuits, inductance $L$ opposes changes in current ($cal(E)_L = - L dif I / dif t$). This analogy is exact for the $R L$ circuit, where the time constant $tau = L / R$ mirrors the mechanical timescale $tau = m / gamma$ for a mass subject to viscous damping.
]

== Magnetic Energy in Circuits // 电路中的磁能
// 电感储能：建立电流过程中电源做的功 → U = ½LI²
// 互感储能：两个耦合回路的磁能 U = ½L₁I₁² + ½L₂I₂² + MI₁I₂
// 磁能密度的场表达式：从 U = ½LI² 推广到 u_B = B²/(2μ₀)
// 任意电流分布的总磁能：U = ½∫ A·J dV = ∫ (B²/2μ₀) dV
// 两种磁能表达式的等价性证明（注意：与静电能 U = ½∫ ρV dV = ∫ (ε₀E²/2) dV 的类比）
// Note：磁能密度 u_B 与电能密度 u_E = ε₀E²/2 的结构对称性——为 §9.5 Poynting 定理铺垫

Just as a capacitor stores energy in the electric field, an inductor stores energy in the magnetic field. This energy is released when the current decreases, supplying power to the circuit.

=== Energy Stored in a Single Inductor // 单电感储能

To establish a current $I$ through an inductor $L$, the external source must do work against the induced EMF. The instantaneous power supplied to the inductor is:
$
  P = - cal(E)_L I = L frac(dif I, dif t) I.
$

The total work done to raise the current from $0$ to $I$ is stored as magnetic energy:
#theorem(name: "Magnetic Energy of a Single Inductor")[
  $
    U_B = integral_0^t P dif t' = integral_0^I L I' dif I' = frac(1, 2) L I^2.
  $
]

=== Energy of Coupled Circuits // 耦合回路的磁能

For two coupled circuits, the total magnetic energy includes contributions from both self-inductances and their mutual interaction:

#theorem(name: "Magnetic Energy of Two Coupled Circuits")[
  $
    U_B = frac(1, 2) L_1 I_1^2 + frac(1, 2) L_2 I_2^2 + M I_1 I_2.
  $
  The cross-term $M I_1 I_2$ can be positive or negative depending on the relative direction of the currents (flux aiding or opposing).
]

#proof[
  For two circuits with currents $I_1$ and $I_2$, the total flux through circuit 1 is $Phi_1 = L_1 I_1 + M I_2$, and through circuit 2 is $Phi_2 = L_2 I_2 + M I_1$. The work done to establish the currents from zero to their final values is:
  $
    U_B = integral_0^(I_1, I_2) (I_1 dif Phi_1 + I_2 dif Phi_2) = frac(1, 2) L_1 I_1^2 + frac(1, 2) L_2 I_2^2 + M I_1 I_2.
  $
]

This generalises to a system of $N$ circuits:
$
  U_B = frac(1, 2) sum_(i=1)^N sum_(j=1)^N L_(i j) I_i I_j,
$
where $L_(i i) = L_i$ are the self-inductances and $L_(i j) = M_(i j)$ for $i != j$ are the mutual inductances.

=== Magnetic Energy Density // 磁能密度

The circuit expression $U_B = frac(1, 2) L I^2$ can be recast as a volume integral over the magnetic field, revealing the local energy density. Using the solenoid example ($L = mu_0 n^2 V$, $B = mu_0 n I$):

$
  U_B = frac(1, 2) (mu_0 n^2 V) I^2 = frac(1, 2) frac(B^2, mu_0) V.
$

Since the field is uniform inside the solenoid, the energy density is:

#definition(name: "Magnetic Energy Density")[
  The energy stored in a magnetic field per unit volume is:
  $
    u_B = frac(B^2, 2 mu_0) quad text("in vacuum").
  $
  In a linear magnetic medium ($bold(B) = mu bold(H)$):
  $
    u_B = frac(1, 2) bold(H) dot bold(B) = frac(B^2, 2 mu).
  $
]

=== General Expression: A·J Form // 一般形式：A·J 表达

The total magnetic energy of any current distribution can also be expressed in terms of the vector potential and the current density.

#theorem(name: "Magnetic Energy — A·J Form")[
  The total magnetic energy of a system of steady currents is:
  $
    U_B = frac(1, 2) integral_V bold(A) dot bold(J) dif V.
  $
]

#proof[
  Using $bold(B) = nabla times bold(A)$ and Ampère's law $nabla times bold(H) = bold(J)$:
  $
    U_B = integral_V frac(1, 2) bold(H) dot bold(B) dif V
        = frac(1, 2) integral_V bold(H) dot (nabla times bold(A)) dif V.
  $
  Using the identity $nabla dot (bold(A) times bold(H)) = bold(H) dot (nabla times bold(A)) - bold(A) dot (nabla times bold(H))$:
  $
    bold(H) dot (nabla times bold(A)) = bold(A) dot (nabla times bold(H)) + nabla dot (bold(A) times bold(H)).
  $
  Substituting $nabla times bold(H) = bold(J)$:
  $
    U_B = frac(1, 2) integral_V bold(A) dot bold(J) dif V + frac(1, 2) integral_V nabla dot (bold(A) times bold(H)) dif V.
  $
  The second term becomes a surface integral $frac(1, 2) integral_S (bold(A) times bold(H)) dot dif bold(S)$. For a localized current distribution, this vanishes as the surface is taken to infinity (fields decay sufficiently fast). Hence:
  $
    U_B = frac(1, 2) integral_V bold(A) dot bold(J) dif V.
  $
]

#note[
  *Comparison of electrostatic and magnetostatic energy expressions:*

  #tex-table(
    ("Quantity", "Electrostatics", "Magnetostatics"),
    ("Source", "Charge density $rho$", "Current density $bold(J)$"),
    ("Potential", "Scalar potential $V$", "Vector potential $bold(A)$"),
    ("Circuit form", "$U_E = frac(1, 2) C V^2$", "$U_B = frac(1, 2) L I^2$"),
    ("Charge/current form", "$U_E = frac(1, 2) integral rho V dif V$", "$U_B = frac(1, 2) integral bold(A) dot bold(J) dif V$"),
    ("Field energy density", "$u_E = frac(epsilon_0, 2) E^2 = frac(1, 2) bold(E) dot bold(D)$", "$u_B = frac(1, 2 mu_0) B^2 = frac(1, 2) bold(H) dot bold(B)$"),
  )

  The structural symmetry between these expressions reflects the deep duality between electric and magnetic phenomena. In time-varying situations (§9.5), these two energy densities combine to give the total electromagnetic energy density $u = u_E + u_B$, which evolves according to Poynting's theorem.
]

= Maxwell's Equations // 麦克斯韦方程组

== Displacement Current and Ampère–Maxwell Law // 位移电流与安培–麦克斯韦定律
// Ampère 定律在时变情形下的失效：对充电电容器取不同曲面得到矛盾结果
// 问题的根源：电流连续性方程 ∂ρ/∂t + ∇·J = 0 在时变情形下 ∇·J ≠ 0
// Maxwell 的修正：引入位移电流 J_D = ε₀ ∂E/∂t（或更一般 Ḋ）
// 物理直觉：变化的电场等价于一种电流——电容器极板间的电场变化产生"虚拟电流"
// 完整 Ampère–Maxwell 定律：
// 积分形式 ∮ B·dl = μ₀I_enc + μ₀ε₀ ∫ (∂E/∂t)·dS
// 微分形式 ∇×B = μ₀J + μ₀ε₀ ∂E/∂t
// 位移电流的物理本质：不是真正的电荷运动，而是电场的时间变化率
// 位移电流在介质中的推广：J_D = ∂D/∂t（包括了极化电流 ∂P/∂t）
// Note：位移电流是 Maxwell 方程组得以自洽的关键，也是电磁波存在的理论基础

== Maxwell's Equations in Vacuum // 真空中的麦克斯韦方程组
// 四个方程的完整表述（真空、无源情形——既无自由电荷也无传导电流）
// Maxwell's Equations in Vacuum（源区：有 ρ 和 J 的一般形式）
// ∇·E = ρ/ε₀, ∇·B = 0, ∇×E = -∂B/∂t, ∇×B = μ₀J + μ₀ε₀ ∂E/∂t
// 积分-微分对照表（四大方程并排对比）
// 对称性分析：如果存在磁单极 ρ_m 和 J_m，则方程组完全对称
// The displacement current is Maxwell's greatest contribution 在自由空间 ∇×B = μ₀ε₀ ∂E/∂t
// 自由度分析：6 个场分量（E_x, E_y, E_z, B_x, B_y, B_z），2 个约束方程（散度），2 个演化方程（旋度）→ 4 个自由度（2 个横波偏振态）
// 从 Maxwell 方程组推导真空电磁波波动方程（仅推导预告 §10）
// 真空中光速 c = 1/√(μ₀ε₀)——力学常数与电磁常数的统一
// Note：Maxwell 方程组是经典电动力学的最高总结——统一了电学、磁学和光学

== Maxwell's Equations in Matter // 介质中的麦克斯韦方程组
// 极化和磁化引入束缚电荷 ρ_b = -∇·P 和束缚电流 J_b = ∇×M + ∂P/∂t
// 辅助场 D 和 H 的定义：D = ε₀E + P, H = B/μ₀ - M
// 宏观 Maxwell 方程组（仅含自由电荷和自由电流）：
// ∇·D = ρ_f, ∇·B = 0, ∇×E = -∂B/∂t, ∇×H = J_f + ∂D/∂t
// 本构关系：线性各向同性介质 D = εE, B = μH, J = σE
// ε = ε₀ε_r, μ = μ₀μ_r, σ 的物理意义
// 色散与频率依赖的预告：ε(ω)、μ(ω)——为 §11 色散关系铺垫
// Note：宏观 Maxwell 方程组的适用范围——平均场近似，忽略微观涨落

== Boundary Conditions for Electromagnetic Fields // 电磁场边界条件
// 从积分形式的 Maxwell 方程组推导四个场量的边界条件
// 法向分量：D_⊥ 的跃变（自由面电荷密度）= σ_f；B_⊥ 连续
// 切向分量：E_∥ 连续；H_∥ 的跃变（自由面电流密度）= K_f × n̂
// 完整边界条件汇总表
// // 特殊情形——理想导体内部 E = B = 0，边界条件简化为：
// // n̂ × E = 0（切向电场为零），n̂·B = 0（法向磁场为零）
// // 理想导体表面存在自由面电流 K_f = n̂ × H 和自由面电荷 σ_f = n̂·D
// 应用预览：§11 反射折射、§12 波导模式
// Note：边界条件是求解边值问题的关键——连接不同介质区域的 Maxwell 方程组

== Conservation of Energy: Poynting's Theorem // 能量守恒：坡印廷定理
// 从 Maxwell 方程组出发推导坡印廷定理（能量守恒定律的场形式）
// 推导：E·(∇×H) - H·(∇×E) = E·J_f + E·∂D/∂t + H·∂B/∂t
// 利用矢量恒等式 ∇·(E×H) = H·(∇×E) - E·(∇×H)
// 得到 -∂u/∂t = ∇·S + J_f·E（其中 u = ½(E·D + B·H), S = E×H）
// 积分形式：-dU/dt = ∮ S·dA + ∫ J_f·E dV
// Poynting 矢量 S = E×H 的物理意义：电磁场能量流密度（单位时间通过单位面积的能量）
// 电磁场能量密度 u = ½(ε₀E² + B²/μ₀)（真空情形）
// Poynting 定理的物理诠释：某体积内电磁能量的减少 = 流出该体积的能流 + 对电荷做功消耗的功率
// 经典示例：直流电阻直导线的能量从外部电磁场流入（Poynting 矢量指向导线内部）
// Note：Poynting 定理是 §14 辐射能流和天线理论基础

#part("Electromagnetic Waves") // 电磁波
#part("Potentials and Radiation") // 势与辐射
#part("Special Relativity and Electrodynamics") // 狭义相对论与电动力学




// 目录
// ==============================================================================
// Electrodynamics (电动力学) — Table of Contents
// ==============================================================================

// --- Part I: Mathematical Foundations (数学基础) ---

// Chapter 1: Vector Analysis and Field Theory (矢量分析与场论)
//   Section 1.2: Divergence and Curl (散度与旋度)
//   Section 1.4: Conservative Fields and Potential Functions (保守场与势函数)
//   Section 1.5: Helmholtz Decomposition Theorem (亥姆霍兹分解定理)
//   Section 1.6: Curvilinear Coordinates (曲线坐标系)
//   Section 1.7: Dirac Delta Function (狄拉克δ函数)

// Chapter 2: Tensor Analysis (张量分析)
//   Section 2.1: Definition and Representation of Cartesian Tensors (笛卡尔张量的定义与表示)
//   Section 2.2: Tensor Algebraic Operations and Contraction (张量代数运算与缩并)
//   Section 2.3: Symmetric and Antisymmetric Tensors (对称与反对称张量)
//   Section 2.4: Principal Axis Transformation and Eigenvalues (主轴变换与特征值)
//   Section 2.5: Moment of Inertia Tensor and Stress Tensor (惯性矩张量与应力张量)
//   Section 2.6: Electromagnetic Field Tensors in Electrodynamics (电动力学中的电磁场张量)

// --- Part II: Electrostatics (静电学) ---

// Chapter 3: Electrostatic Field (静电场)
//   Section 3.1: Coulomb's Law (库仑定律)
//   Section 3.2: Electric Field Intensity (电场强度)
//   Section 3.3: Gauss's Law and Electric Flux (高斯定律与电通量)
//   Section 3.4: Electric Potential (电势)
//   Section 3.5: Poisson's Equation and Laplace's Equation (泊松方程与拉普拉斯方程)

// Chapter 4: Boundary Value Problems in Electrostatics (静电学边值问题)
//   Section 4.1: Uniqueness Theorems (唯一性定理)
//   Section 4.2: Method of Images (镜像法)
//   Section 4.3: Separation of Variables in Cartesian Coordinates (直角坐标系分离变量法)
//   Section 4.4: Separation of Variables in Spherical Coordinates (球坐标系分离变量法)
//   Section 4.5: Separation of Variables in Cylindrical Coordinates (柱坐标系分离变量法)
//   Section 4.6: Multipole Expansion (多极展开)

// Chapter 5: Conductors and Dielectrics in Electrostatic Fields (静电场中的导体与电介质)
//   Section 5.1: Conductors in Electrostatic Fields (静电场中的导体)
//   Section 5.2: Polarization and Bound Charges (极化与束缚电荷)
//   Section 5.3: Electric Displacement and Gauss's Law for D (电位移矢量与D的高斯定理)
//   Section 5.4: Boundary Conditions at Interfaces (介质界面边界条件)
//   Section 5.5: Electrostatic Energy and Capacitors (静电能与电容器)

// --- Part III: Magnetostatics (静磁学) ---

// Chapter 6: Magnetostatic Field (静磁场)
//   Section 6.1: Steady Currents and Ohm's Law (恒定电流与欧姆定律)
//   Section 6.2: Lorentz Force and Biot-Savart Law (洛伦兹力与比奥-萨伐尔定律)
//   Section 6.3: Ampère's Law and Gauss's Law for Magnetism (安培环路定理与磁场高斯定理)
//   Section 6.4: Magnetic Vector Potential and Flux (磁矢势与磁通量)
//   Section 6.5: Common Models in Magnetostatics (常见模型：载流导体的磁场)
//   Section 6.6: Motion of Charged Particles in Magnetic Fields (带电粒子在磁场中的运动)
//   Section 6.7: Magnetic Forces on Currents and Energy (磁场对电流的作用与磁能)

// Chapter 7: Magnetostatics in Matter (介质中的静磁学)
//   Section 7.1: Magnetization and Bound Currents (磁化与束缚电流)
//   Section 7.2: Magnetic Field Intensity (磁场强度)
//   Section 7.3: Linear and Nonlinear Magnetic Materials (线性与非线性磁介质)
//   Section 7.4: Boundary Conditions at Magnetic Interfaces (磁介质界面边界条件)

// --- Part IV: Electromagnetic Induction and Time-Varying Fields (电磁感应与时变场) ---

// Chapter 8: Electromagnetic Induction (电磁感应)
//   Section 8.1: Faraday's Law of Induction (法拉第电磁感应定律)
//   Section 8.2: Motional EMF and Induced Electric Field (动生电动势与感应电场)
//   Section 8.3: Inductance (电感)
//   Section 8.4: Magnetic Energy in Circuits (电路中的磁能)

// Chapter 9: Maxwell's Equations (麦克斯韦方程组)
//   Section 9.1: Displacement Current and Ampère–Maxwell Law (位移电流与安培–麦克斯韦定律)
//   Section 9.2: Maxwell's Equations in Vacuum (真空中的麦克斯韦方程组)
//   Section 9.3: Maxwell's Equations in Matter (介质中的麦克斯韦方程组)
//   Section 9.4: Boundary Conditions for Electromagnetic Fields (电磁场边界条件)
//   Section 9.5: Conservation of Energy: Poynting's Theorem (能量守恒：坡印廷定理)

// --- Part V: Electromagnetic Waves (电磁波) ---

// Chapter 10: Electromagnetic Waves in Vacuum (真空中的电磁波)
//   Section 10.1: Wave Equation from Maxwell's Equations (由麦克斯韦方程组导出波动方程)
//   Section 10.2: Plane Wave Solutions (平面波解)
//   Section 10.3: Polarization of Electromagnetic Waves (电磁波的偏振)
//   Section 10.4: Energy and Momentum of Electromagnetic Waves (电磁波的能量与动量)

// Chapter 11: Electromagnetic Waves in Media (介质中的电磁波)
//   Section 11.1: Wave Equation in Linear Media (线性介质中的波动方程)
//   Section 11.2: Reflection and Refraction at Interfaces (界面上的反射与折射)
//   Section 11.3: Fresnel Equations (菲涅尔公式)
//   Section 11.4: Dispersion Relations (色散关系)
//   Section 11.5: Absorption and Complex Refractive Index (吸收与复折射率)

// Chapter 12: Waveguides and Cavities (波导与谐振腔)
//   Section 12.1: Waveguides: TE and TM Modes (波导：TE模与TM模)
//   Section 12.2: Rectangular Waveguide (矩形波导)
//   Section 12.3: Resonant Cavities (谐振腔)

// --- Part VI: Potentials and Radiation (势与辐射) ---

// Chapter 13: Electromagnetic Potentials (电磁势)
//   Section 13.1: Scalar and Vector Potentials (标势与矢势)
//   Section 13.2: Gauge Transformations (规范变换)
//   Section 13.3: Coulomb Gauge and Lorenz Gauge (库仑规范与洛伦兹规范)
//   Section 13.4: Retarded Potentials (推迟势)

// Chapter 14: Radiation (辐射)
//   Section 14.1: Radiation from Point Charges (点电荷的辐射)
//   Section 14.2: Electric Dipole Radiation (电偶极辐射)
//   Section 14.3: Magnetic Dipole Radiation (磁偶极辐射)
//   Section 14.4: Electric Quadrupole Radiation (电四极辐射)
//   Section 14.5: Larmor Formula (拉莫尔公式)
//   Section 14.6: Radiation Reaction (辐射反作用)

// Chapter 15: Scattering and Diffraction (散射与衍射)
//   Section 15.1: Thomson Scattering (汤姆孙散射)
//   Section 15.2: Rayleigh Scattering (瑞利散射)
//   Section 15.3: Diffraction: Kirchhoff's Theory (衍射：基尔霍夫理论)

// --- Part VII: Special Relativity and Electrodynamics (狭义相对论与电动力学) ---

// Chapter 16: Special Relativity (狭义相对论)
//   Section 16.1: Lorentz Transformations (洛伦兹变换)
//   Section 16.2: Four-Vectors and Minkowski Spacetime (四维矢量与闵可夫斯基时空)
//   Section 16.3: Relativistic Kinematics (相对论运动学)
//   Section 16.4: Relativistic Dynamics (相对论动力学)

// Chapter 17: Relativistic Electrodynamics (相对论电动力学)
//   Section 17.1: Electromagnetic Field Tensor (电磁场张量)
//   Section 17.2: Covariant Form of Maxwell's Equations (麦克斯韦方程组的协变形式)
//   Section 17.3: Lorentz Transformation of Fields (电磁场的洛伦兹变换)
//   Section 17.4: Relativistic Lagrangian and Hamiltonian (相对论拉格朗日量与哈密顿量)
//   Section 17.5: Invariants of the Electromagnetic Field (电磁场的不变量)