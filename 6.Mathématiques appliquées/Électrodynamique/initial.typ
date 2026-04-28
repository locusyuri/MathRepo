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

#definition(name: "Coulomb's Law")[
The *Coulomb's law* states that the electrostatic force $bold(F)$ between two point charges $q_1$ and $q_2$ separated by a distance $r$ in vacuum is given by
$  
bold(F) = k (q_1 q_2) / r^2 hat(r),
$
where $k$ is the Coulomb's constant, $hat(r)$ is the unit vector pointing from one charge to the other.
]

In SI units, the Coulomb's constant is given by $k = 8.9875517873681764 times 10^9 "N" dot "m"^2 dot "C"^(-2)$.
For convenience, we often use the permittivity of free space $epsilon_0$ to express Coulomb's constant as 
$
k = 1 / (4 pi epsilon_0),
$ 
where $epsilon_0 = 8.854187817 times 10^(-12) "C"^2 dot "N"^(-1) dot "m"^(-2)$.

== Electric Field Intensity // 电场强度
#definition(name: "Electric Field Intensity")[
The *electric field intensity* $bold(E)$ at a point in space is defined as the force $bold(F)$ experienced by a positive test charge $q$ placed at that point, divided by the magnitude of the test charge, i.e.,
$  
bold(E) = bold(F) / q.
$
]


== Gauss's Law and Electric Flux // 高斯定律与电通量

== Electric Potential // 电势

== Poisson's Equation and Laplace's Equation // 泊松方程与拉普拉斯方程

== Electrostatic Energy // 静电能

= Boundary Value Problems in Electrostatics // 静电学边值问题
== Uniqueness Theorems // 唯一性定理
== Method of Images // 镜像法
== Separation of Variables in Cartesian Coordinates // 直角坐标系分离变量法
== Separation of Variables in Spherical Coordinates // 球坐标系分离变量法
== Separation of Variables in Cylindrical Coordinates // 柱坐标系分离变量法
== Multipole Expansion // 多极展开
= Electrostatics in Matter // 介质中的静电学
== Polarization and Bound Charges // 极化与束缚电荷
== Electric Displacement // 电位移矢量
== Linear Dielectrics // 线性电介质
== Boundary Conditions at Dielectric Interfaces // 电介质界面边界条件
== Energy in Dielectric Systems // 电介质系统中的能量


#part("Magnetostatics") // 静磁学
#part("Electromagnetic Induction and Time-Varying Fields") // 电磁感应与时变场
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
//   Section 3.6: Electrostatic Energy (静电能)

// Chapter 4: Boundary Value Problems in Electrostatics (静电学边值问题)
//   Section 4.1: Uniqueness Theorems (唯一性定理)
//   Section 4.2: Method of Images (镜像法)
//   Section 4.3: Separation of Variables in Cartesian Coordinates (直角坐标系分离变量法)
//   Section 4.4: Separation of Variables in Spherical Coordinates (球坐标系分离变量法)
//   Section 4.5: Separation of Variables in Cylindrical Coordinates (柱坐标系分离变量法)
//   Section 4.6: Multipole Expansion (多极展开)

// Chapter 5: Electrostatics in Matter (介质中的静电学)
//   Section 5.1: Polarization and Bound Charges (极化与束缚电荷)
//   Section 5.2: Electric Displacement (电位移矢量)
//   Section 5.3: Linear Dielectrics (线性电介质)
//   Section 5.4: Boundary Conditions at Dielectric Interfaces (电介质界面边界条件)
//   Section 5.5: Energy in Dielectric Systems (电介质系统中的能量)

// --- Part III: Magnetostatics (静磁学) ---

// Chapter 6: Magnetostatic Field (静磁场)
//   Section 6.1: Biot–Savart Law (毕奥–萨伐尔定律)
//   Section 6.2: Ampère's Law (安培定律)
//   Section 6.3: Magnetic Vector Potential (磁矢势)
//   Section 6.4: Magnetic Force and Torque (磁力与力矩)
//   Section 6.5: Magnetostatic Energy (静磁能)

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