#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Mécanique Analytique", // 理论力学
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Mécanique Analytique",
  "Violet",
  subtitle: "A notebook for mechanics",
  institute: "Notiz Physique",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This is a notebook for mechanics.",
)

#make-outline(depth: 2, title: "Contents")

// --- Part I: Classical Mechanics Foundations (经典力学基础) ---
// 说明（2026-10-22）：原 Chapter 4「Elastic Waves in Solids」（应变/应力/泊松比/P-S 波/阻抗/反射）
//   已整体迁入 Optique 笔记 Ch 2.4 与 Ch 2.6；本章删除，此后 Chapter 5→4（Celestial）、6→5（Fluid）。

#part("Classical Mechanics Foundations") // 经典力学基础

// Chapter 1: Kinematics of Particles and Particle Systems (质点与质点系)
//   Section 1.1: Kinematic Attributes of Point Particles (质点的运动学属性)
//   Section 1.2: Rigid Body Kinematics: Translation and Rotation (刚体平动与转动)
//   Section 1.3: Correspondence between Linear and Angular Quantities (线量与角量的对应)
= Kinematics of Particles and Particle Systems // 质点与质点系
== Kinematic Attributes of Point Particles // 质点的运动学属性

Kinematics describes motion without asking what causes it.
For a point particle, the basic data are position, velocity, and acceleration as functions of time.

#definition(name: "Point Particle and Trajectory")[
  A point particle is modeled by its position vector

  $
    bold(r) = bold(r)(t) in bb(R)^3.
  $

  The geometric curve traced by $bold(r)(t)$ is the trajectory.
]

#definition(name: "Velocity and Acceleration")[
  The velocity and acceleration are

  $
    bold(v) = frac(dif bold(r), dif t), quad bold(a) = frac(dif bold(v), dif t) = frac(dif^2 bold(r), dif t^2).
  $

  Their magnitudes are the speed $|bold(v)|$ and acceleration magnitude $|bold(a)|$.
]

=== Cartesian Representation

In Cartesian coordinates,

$
  bold(r)(t) = x(t) bold(e_x) + y(t) bold(e_y) + z(t) bold(e_z),
$

so

$
  bold(v) = dot(x) bold(e_x) + dot(y) bold(e_y) + dot(z) bold(e_z),
  quad
  bold(a) = dot.double(x) bold(e_x) + dot.double(y) bold(e_y) + dot.double(z) bold(e_z).
$

Each coordinate evolves independently at the kinematic level.

=== Plane Polar Representation

For planar motion, let $(r, theta)$ be polar coordinates. Then

$
  bold(v) = dot(r) bold(e_r) + r dot(theta) bold(e_theta),
$

$
  bold(a) = (dot.double(r) - r dot(theta)^2) bold(e_r) + (r dot.double(theta) + 2 dot(r) dot(theta)) bold(e_theta).
$

#note[
  This decomposition is crucial later:
  radial and tangential components naturally match force decomposition in central-force problems.
]

=== Cylindrical Coordinates // 柱坐标

For three-dimensional motion with rotational symmetry about the $z$-axis, cylindrical coordinates $(rho, phi, z)$ are the natural choice. The unit vectors are $bold(e_rho)$, $bold(e_phi)$, $bold(e_z)$, with $bold(e_rho)$ and $bold(e_phi)$ rotating as the pointmoves.

$
  bold(r) = rho bold(e_rho) + z bold(e_z),
$

$
  bold(v) = dot(rho) bold(e_rho) + rho dot(phi) bold(e_phi) + dot(z) bold(e_z),
$

$
  bold(a) = (dot.double(rho) - rho dot(phi)^2) bold(e_rho)
          + (rho dot.double(phi) + 2 dot(rho) dot(phi)) bold(e_phi)
          + dot.double(z) bold(e_z).
$

#note[
  The radial terms $- rho dot(phi)^2$ (centripetal) and $2 dot(rho) dot(phi)$ (Coriolis) in the $phi$-component are kinematic — they arise purely from the geometry of the coordinate system, not from any physical force. These same terms will reappear in the rotating-frame dynamics of Chapter 2.
]

=== Spherical Coordinates // 球坐标

For central-force problems (e.g., planetary motion, Chapter 4), spherical coordinates $(r, theta, phi)$ are the most convenient. Here $r$ is the radial distance, $theta$ the polar angle from the $z$-axis, and $phi$ the azimuthal angle.

$
  bold(v) = dot(r) bold(e_r) + r dot(theta) bold(e_theta) + r sin theta dot(phi) bold(e_phi),
$

$
  bold(a) = (dot.double(r) - r dot(theta)^2 - r sin^2 theta dot(phi)^2) bold(e_r) + ...
$

#note[
  The full expression for acceleration in spherical coordinates is lengthy, but the radial component alone — which contains the centrifugal terms $- r dot(theta)^2 - r sin^2 theta dot(phi)^2$ — is often sufficient for deriving radial equations in central-force problems.
]

=== Arc-Length and Tangential-Normal Decomposition

Let $s$ be arc length along the trajectory and $rho$ the local radius of curvature. Then

$
  v = frac(dif s, dif t),
  quad
  bold(v) = v bold(hat(t)),
  quad
  bold(a) = dot(v) bold(hat(t)) + frac(v^2, rho) bold(hat(n)),
$

where $bold(hat(t))$ and $bold(hat(n))$ are unit tangent and principal normal vectors.

=== Frenet-Serret Frame // 弗莱纳-塞雷框架

The complete description of a space curve uses three orthonormal vectors — the *Frenet-Serret frame*.

#definition(name: "Frenet-Serret Frame")[
  For a smooth curve parametrised by arc length $s$, define:
  - *Unit tangent*: $bold(hat(t)) = dif bold(r) / dif s$,
  - *Principal normal*: $bold(hat(n)) = (dif bold(hat(t)) / dif s) / |dif bold(hat(t)) / dif s|$,
  - *Binormal*: $bold(hat(b)) = bold(hat(t)) times bold(hat(n))$.

  The three vectors satisfy the Frenet-Serret formulas:
  $
    frac(dif bold(hat(t)), dif s) = kappa bold(hat(n)), quad
    frac(dif bold(hat(n)), dif s) = - kappa bold(hat(t)) + tau bold(hat(b)), quad
    frac(dif bold(hat(b)), dif s) = - tau bold(hat(n)),
  $
  where $kappa = 1 / rho$ is the curvature and $tau$ is the torsion (rate of twisting out of the osculating plane).
]

#note[
  For planar motion, $tau = 0$ and $bold(hat(b))$ is constant. The acceleration decomposition $bold(a) = dot(v) bold(hat(t)) + v^2 / rho bold(hat(n))$ then follows directly from the first Frenet-Serret formula.
]

#proposition(name: "Uniform Circular Motion")[
  For motion on a circle of radius $R$ with constant angular speed $omega$,

  $
    |bold(v)| = R omega,
    quad
    |bold(a)| = R omega^2,
  $

  and acceleration points toward the center.
]

=== Relative Motion and Frame Shift (Galilean Form)

If two inertial frames differ by constant relative velocity $u$, then

$
  bold(r)' = bold(r) - bold(u) t - bold(r_0),
  quad
  bold(v)' = bold(v) - bold(u),
  quad
  bold(a)' = bold(a).
$

So acceleration is invariant under Galilean transformation, which prepares the ground for Newton's second law in the next chapter.

=== Kinematics of Particle Systems // 质点系的运动学

Real mechanical systems rarely consist of a single point particle. Multiple particles introduce new kinematic concepts — the centre of mass, relative coordinates, and degrees of freedom — that are essential for the later analysis of rigid bodies, celestial systems, and continua.

#definition(name: "Centre of Mass")[
  For a system of $N$ particles with masses $m_a$ and positions $bold(r)_a$, the *centre of mass* (CM) is:
  $
    bold(R)_"CM" = frac(1, M) sum_(a=1)^N m_a bold(r)_a, quad M = sum_(a=1)^N m_a.
  $
  The CM velocity and acceleration are the mass-weighted averages:
  $
    bold(V)_"CM" = frac(1, M) sum_(a=1)^N m_a bold(v)_a, quad
    bold(A)_"CM" = frac(1, M) sum_(a=1)^N m_a bold(a)_a.
  $
]

#definition(name: "Relative Coordinates")[
  The position of each particle can be decomposed into CM and relative parts:
  $
    bold(r)_a = bold(R)_"CM" + bold(r)'_a,
  $
  where $bold(r)'_a$ is the position relative to the CM. By construction,
  $
    sum_(a=1)^N m_a bold(r)'_a = bold(0), quad
    sum_(a=1)^N m_a bold(v)'_a = bold(0).
  $
]

#definition(name: "Degrees of Freedom")[
  The number of *degrees of freedom* (DOF) of a system is the minimum number of independent coordinates needed to specify its configuration:
  - Single free particle in space: $3$ DOF.
  - $N$ free particles: $3N$ DOF.
  - $N$ particles with $k$ independent holonomic constraints: $3N - k$ DOF.
]

#note[
  The CM decomposition is more than a kinematic convenience: it decouples the overall motion from the internal motion. This decoupling is the foundation of the two-body reduction in celestial mechanics (Chapter 4) and of rigid-body dynamics (next section), where the internal constraints determine the rotational degrees of freedom.
]

=== A Preview of Rotating Reference Frames // 转动参考系前瞻

The rigid-body kinematics that follows requires understanding how velocities transform between a fixed (inertial) frame and a rotating frame. This brief preview establishes the formula; the dynamical consequences will be explored in Chapter 2.

#proposition(name: "Velocity in a Rotating Frame")[
  Let a vector $bold(Q)$ be observed in an inertial frame $cal(F)$ and in a frame $cal(F')$ rotating with angular velocity $bold(omega)$ relative to $cal(F)$. The time derivatives are related by:
  $
    lr(frac(dif bold(Q), dif t))_cal(F) = lr(frac(dif bold(Q), dif t))_(cal(F)') + bold(omega) times bold(Q).
  $
  Applying this to the position vector $bold(r)$ gives the velocity transformation:
  $
    bold(v)_cal(F) = bold(v)_(cal(F)') + bold(omega) times bold(r).
  $
]

#note[
  The term $bold(omega) times bold(r)$ is the *transport velocity* — the apparent velocity due to the rotation of the frame itself. This formula is the kinematic foundation for the rigid-body velocity $bold(v) = bold(omega) times bold(r)$ derived in the next section.
]

== Rigid Body Kinematics: Translation and Rotation // 刚体平动与转动

A rigid body is a mechanical system whose internal distances remain constant during motion.
Its kinematics is therefore determined by the motion of one reference pointand by the body's orientation.

#definition(name: "Rigid Body Motion")[
  Let $bold(r_A)(t)$ and $bold(r_B)(t)$ be the positions of two points $A$ and $B$ of the same body.
  The rigid-body condition is

  $
    |bold(r_A) - bold(r_B)| = "const".
  $

  Equivalently, the distance between any two material points is preserved in time.
]

=== Translation of a Rigid Body

If every point of the body has the same velocity, the motion is a pure translation.
In that case, the velocity and acceleration of any point coincide with those of a chosen reference point.

#proposition(name: "Pure Translation")[
  Suppose the position of every point$P$ of the body can be written as

  $
    bold(r)_(P)(t) = bold(R)(t) + bold(r)_P^0,
  $

  where $bold(r)_P^0$ is fixed in the body frame.
  Then

  $
    bold(v)_P = dot bold(R), quad bold(a)_P = dot.double bold(R),
  $

  so all points share the same translational motion.
]

=== Rotation about a Fixed Point

If the body rotates around a fixed point$O$, then the position of each pointcan be described by a rotation matrix or, equivalently, by an angular velocity vector.

#definition(name: "Angular Velocity")[
  The angular velocity $bold(omega)$ is the vector whose direction is given by the right-hand rule and whose magnitude is the instantaneous rotation rate.
]

For a pointwith position vector $bold(r)$ measured from the rotation center, the velocity is


$
  bold(v) = bold(omega) times bold(r).
$

Differentiating once more gives the acceleration decomposition


$
  bold(a) = dot(bold(omega)) times bold(r) + bold(omega) times (bold(omega) times bold(r)).
$

The first term is tangential, and the second term is centripetal.

=== General Rigid-Body Motion

The most general rigid-body motion is the sum of a translation of a reference pointand a rotation about that point.

$
  bold(r)_(P)(t) = bold(R)(t) + cal(R)(t) bold(r)_P^0,
$

where $cal(R)(t)$ is a rotation operator.

#note[
  This decomposition is the kinematic backbone of rigid-body dynamics.
  Later, Lagrangian methods will convert it into equations of motion and conservation laws.
]

== Correspondence between Linear and Angular Quantities // 线量与角量的对应
<sec:linear-angular-correspondence>

Rigid-body rotation becomes especially transparent once we pair linear quantities with their angular analogues.
The main pointis that many formulas in translation and rotation have exactly the same algebraic structure.

=== Linear and Angular Pairing

For a pointat distance $rho$ from the axis of rotation,

$
  s = rho theta,
  quad
  v = rho omega,
  quad
  a_t = rho alpha,
  quad
  a_n = rho omega^2,
$

where $theta$ is the angular displacement, $omega = dot(theta)$ the angular velocity, and $alpha = dot(omega)$ the angular acceleration.

#tex-table(
  ([*Translational quantity*], [*Rotational analogue*]),
  ([$bold(r)$], [$theta$]),
  ([$bold(v) = dot(bold(r))$], [$omega = dot(theta)$]),
  ([$bold(a)$], [$alpha = dot(omega)$]),
  ([$bold(F)$], [$tau$]),
  ([$m$], [$I$]),
  ([$bold(p) = m bold(v)$], [$J = I omega$]),
  ([$bold(k) = frac(1,2) m |bold(v)|^2$], [$K = frac(1,2) I omega^2$]),
)

#proposition(name: "Translational-Rotational Correspondence")[
  For a rigid body rotating about a fixed axis, the following dictionary holds:

  $ 
    bold(v) <-> rho omega, quad
    bold(a) <-> rho alpha, quad
    bold(F) <-> tau, quad
    m <-> I.
  $

  Under this correspondence, the formulas for momentum, work, and kinetic energy take the same form in linear and angular variables.
]

=== Work and Kinetic Energy

The infinitesimal work done by a torque is

$
  dif W = tau dif theta,
$

just as the infinitesimal work done by a force is

$
  dif W = bold(F) dot dif bold(r).
$

Likewise, the rotational kinetic energy of a rigid body is

$
  K = frac(1,2) I omega^2,
$

which is formally identical to the translational expression $frac(1,2) m |bold(v)|^2$.

=== Why This Correspondence Matters

#note[
  This chapter is designed as a bridge.
  The next chapter will turn Newton's second law and the fixed-axis rotation law into the dynamical counterpart of the kinematic dictionary above.
]

// Chapter 2: Newton's Laws and Rigid Body Rotational Dynamics (牛顿运动定律与刚体转动定律)
//   Section 2.1: Newton's Three Laws (牛顿三大定律)
//   Section 2.2: Rigid Body Rotation about a Fixed Axis (刚体定轴转动定律)
= Newton's Laws and Rigid Body Rotational Dynamics // 牛顿运动定律与刚体转动定律

Chapter 1 established the *kinematic* language of motion: position, velocity, acceleration, and their angular counterparts. This chapter supplies the *dynamics* — the laws that relate motion to its causes. We first review Newton's three laws in their familiar translational form, then develop the parallel rotational laws for rigid bodies. The structural analogy between translation and rotation, already visible in the kinematics of #link(<sec:linear-angular-correspondence>)[*Linear-Angular Correspondence*], becomes deeper here: force ↔ torque, mass ↔ moment of inertia, and linear acceleration ↔ angular acceleration.

== Newton's Three Laws // 牛顿三大定律

Newton's laws form the foundation of classical mechanics. They summarise centuries of observation into three concise statements about how forces affect motion.

=== First Law: Inertia // 第一定律：惯性

#law(name: "Newton's First Law — Law of Inertia")[
  A body remains at rest or in uniform rectilinear motion unless acted upon by a net external force.

  Equivalently: in an inertial reference frame, $sum bold(F) = bold(0)$ implies $bold(a) = bold(0)$.
]

The first law defines what we mean by an *inertial frame*: a frame in which an isolated body moves with constant velocity. The Galilean transformation from Chapter 1 connects all such frames.

=== Second Law: Equation of Motion // 第二定律：运动方程

#law(name: "Newton's Second Law")[
  The net force on a body equals the time rate of change of its linear momentum:
  $
    sum bold(F) = frac(dif bold(p), dif t), quad bold(p) = m bold(v).
  $
  When the mass is constant, this reduces to the familiar form:
  $
    sum bold(F) = m bold(a).
  $
]

#definition(name: "Weight and Gravitational Mass")[
  Near the Earth's surface, the gravitational force (weight) is $bold(W) = m bold(g)$, where $g approx 9.81 "m/s"^2$ is the gravitational acceleration.
]

=== Third Law: Action and Reaction // 第三定律：作用与反作用

#law(name: "Newton's Third Law")[
  For every action (force applied by body $A$ on body $B$), there is an equal and opposite reaction (force applied by $B$ on $A$):
  $
    bold(F)_(A -> B) = - bold(F)_(B -> A).
  $
  These two forces act on *different* bodies and never cancel each other in a free-body diagram of a single body.
]

=== Force as a Vector and Superposition // 力的矢量性与叠加原理

#property(name: "Superposition of Forces")[
  Forces are vectors: they add componentwise. The net force on a particle is
  $
    bold(F)_"net" = sum_i bold(F)_i.
  $
  Newton's second law applies to $bold(F)_"net"$, not to individual forces separately.
]

#example(name: "Free-Body Analysis — Block on an Incline")[ // 斜面滑块分析
  A block of mass $m$ slides down a frictionless incline at angle $theta$.

  The forces are:
  - Weight $m g$ vertically downward,
  - Normal force $N$ perpendicular to the surface.

  Decomposing weight into components parallel and perpendicular to the incline:
  $
    F_parallel = m g sin theta, quad F_perp = - m g cos theta + N = 0.
  $
  Newton's second law along the incline gives:
  $
    m a = m g sin theta arrow a = g sin theta.
  $
]

=== The Road Ahead: Rotational Analogue // 前瞻：转动类比

Newton's laws have precise rotational counterparts, which we develop in the next section:

#tex-table(
  ("Quantity", "Translation", "Rotation"),
  ("Inertia", "Mass $m$", "Moment of inertia $I$"),
  ("Cause of acceleration", "Force $bold(F)$", "Torque $bold(tau)$"),
  ("Second law", "$sum bold(F) = m bold(a)$", "$sum bold(tau) = I bold(alpha)$"),
  ("Momentum", "$bold(p) = m bold(v)$", "$bold(L) = I bold(omega)$"),
  ("Work", "$W = integral bold(F) dot dif bold(r)$", "$W = integral tau dif theta$"),
  ("Kinetic energy", "$K = frac(1,2) m v^2$", "$K = frac(1,2) I omega^2$"),
)

#note[
  This correspondence is more than a mnemonic: it reflects the deep structural isomorphism between linear and angular dynamics, which will be explored systematically in Chapter 3.
]

== Rigid Body Rotation about a Fixed Axis // 刚体定轴转动

We now develop the rotational dynamics of a rigid body constrained to rotate about a fixed axis. The key quantities are *torque* (the rotational analogue of force) and *moment of inertia* (the rotational analogue of mass).

=== Torque // 力矩

#definition(name: "Torque")[
  The *torque* of a force $bold(F)$ applied at a pointwith position vector $bold(r)$ (measured from the axis or rotation centre) is:
  $
    bold(tau) = bold(r) times bold(F).
  $
  Its magnitude is $|bold(tau)| = r F sin theta = F d$, where $d = r sin theta$ is the *lever arm* (perpendicular distance from the axis to the line of action of the force). The SI unit is the newton-metre ($"N" dot "m"$).
]

For a rigid body rotating about a fixed axis, only the component of torque parallel to the axis contributes to the angular acceleration. The total torque about the axis is the sum of the torques from all external forces.

=== Moment of Inertia // 转动惯量

#definition(name: "Moment of Inertia")[
  For a system of $N$ pointmasses, the *moment of inertia* about a given axis is:
  $
    I = sum_(a=1)^N m_a r_(a_perp)^2,
  $
  where $r_(a_perp)$ is the perpendicular distance of $m_a$ from the axis.

  For a continuous rigid body with density $rho(bold(r))$:
  $
    I = integral_V r_perp^2 rho(bold(r)) dif V.
  $
]

#theorem(name: "Parallel Axis Theorem")[
  If $I_"CM"$ is the moment of inertia about an axis through the centre of mass, then the moment about a *parallel* axis at distance $d$ is:
  $
    I = I_"CM" + M d^2,
  $
  where $M$ is the total mass of the body.
]

#example(name: "Moments of Inertia of Common Bodies")[ // 常见刚体的转动惯量
  - *Thin hoop* (radius $R$, axis through centre, perpendicular to plane): $I = M R^2$.
  - *Solid disk* (radius $R$, same axis): $I = frac(1,2) M R^2$.
  - *Solid sphere* (radius $R$, axis through centre): $I = frac(2,5) M R^2$.
  - *Thin rod* (length $L$, axis through centre, perpendicular to rod): $I = frac(1,12) M L^2$.
  - *Thin rod* (axis through end): $I = frac(1,3) M L^2$ (by parallel axis theorem).
]

=== Rotational Form of Newton's Second Law // 转动形式的牛顿第二定律

#law(name: "Rotational Second Law")[
  The net torque on a rigid body rotating about a fixed axis equals the product of its moment of inertia and its angular acceleration:
  $
    sum tau_"ext" = I alpha.
  $
  This is the rotational counterpart of $sum F = m a$.
]

#proof[
  For a single particle of mass $m_a$ at distance $r_a$ from the axis, the tangential component of Newton's second law gives:
  $
    F_(a, t) = m_a a_(a, t) = m_a r_a alpha.
  $
  Multiplying by $r_a$ gives the torque contribution: $tau_a = F_(a, t) r_a = m_a r_a^2 alpha$.
  Summing over all particles: $sum tau_a = (sum m_a r_a^2) alpha = I alpha$.
]

=== Work and Power in Rotation // 转动中的功与功率

#property(name: "Rotational Work and Power")[
  The work done by a torque $tau$ through an angular displacement $dif theta$ is:
  $
    dif W = tau dif theta.
  $
  The power delivered by a torque is:
  $
    P = tau omega.
  $
  These are direct analogues of the translational formulas $dif W = F dif s$ and $P = F v$.
]

=== Applications // 应用

#example(name: "Compound Atwood Machine with Pulley")[ // 含滑轮的系统
  Consider a pulley of mass $M$, radius $R$, and moment of inertia $I = frac(1,2) M R^2$, with a mass $m$ hanging from a light string wrapped around the pulley.

  *Translational equation for the hanging mass:*
  $
    m g - T = m a,
  $
  where $T$ is the tension in the string and $a$ is the downward acceleration.

  *Rotational equation for the pulley:*
  $
    tau_"net" = T R = I alpha = I frac(a, R).
  $

  Solving simultaneously:
  $
    a = frac(m g, m + I / R^2)
      = frac(m g, m + M/2).
  $
  The tension is $T = m (g - a)$.

  This example shows how translation and rotation are coupled through the constraintegral$a = R alpha$.
]

#example(name: "Physical Pendulum")[ // 物理摆
  A rigid body of mass $M$ pivoted at a distance $d$ from its centre of mass. The torque due to gravity is $tau = - M g d sin theta$. The rotational second law gives:
  $
    I dot.double(theta) + M g d sin theta = 0.
  $
  For small angles ($sin theta approx theta$), this reduces to simple harmonic motion:
  $
    dot.double(theta) + omega_0^2 theta = 0, quad omega_0 = sqrt(frac(M g d, I)).
  $

  The period is $T = 2 pi / omega_0 = 2 pi sqrt(frac(I, M g d))$, which reduces to the simple pendulum result $T = 2 pi sqrt(L/g)$ when $I = M d^2$ (mass concentrated at distance $d$).
]

=== Summary of the Translational-Rotational Dictionary // 平动-转动词典总结

#note[
  The laws developed in this chapter complete the dynamical side of the correspondence started in Chapter 1:

  $
    bold(F) quad ↔ quad bold(tau), quad
    m quad ↔ quad I, quad
    bold(a) quad ↔ quad bold(alpha), quad
    bold(p) quad ↔ quad bold(L).
  $

  The next chapter (Momentum, Angular Momentum, and Energy) will expand this dictionary to include momentum, impulse, work, and energy, and will prove the structural *isomorphism* between the two sets of laws.
]

// Chapter 3: Momentum, Angular Momentum, and Energy (动量、角动量与功能原理)
//   Section 3.1: Linear Momentum and Impulse (线动量与冲量)
//   Section 3.2: Angular Momentum and Torque (角动量与力矩)
//   Section 3.3: Work-Energy Theorem and Energy Conservation (功能定理与能量守恒)
//   Section 3.4: Isomorphism between Translational and Rotational Structures (平动与转动的同构性)
//   Section 3.5: Potential Energy and Force Fields (势能与力场)
= Momentum, Angular Momentum, and Energy // 动量、角动量与功能原理

Chapter 2 established the dynamical laws for translation ($sum bold(F) = m bold(a)$) and rotation ($sum tau = I alpha$). This chapter develops the *integral* forms of these laws — momentum, impulse, angular momentum, work, and energy — which are often more powerful for solving problems than direct integration of the equations of motion. The crowning result is the *structural isomorphism* between translational and rotational mechanics: the two sets of laws are formally identical, differing only in the physical interpretation of the variables.

== Linear Momentum and Impulse // 线动量与冲量

=== Linear Momentum // 线动量

#definition(name: "Linear Momentum")[
  The *linear momentum* of a particle of mass $m$ moving with velocity $bold(v)$ is:
  $
    bold(p) = m bold(v).
  $
  For a system of $N$ particles, the total momentum is:
  $
    bold(P) = sum_(a=1)^N m_a bold(v)_a = M bold(V)_"CM",
  $
  where $M$ is the total mass and $bold(V)_"CM"$ is the velocity of the centre of mass.
]

Newton's second law can be expressed directly in terms of momentum:

$
  sum bold(F) = frac(dif bold(p), dif t).
$

This form is more fundamental than $sum bold(F) = m bold(a)$ because it remains valid when mass changes (e.g., rockets, relativistic mechanics).

=== Impulse-Momentum Theorem // 冲量定理

#theorem(name: "Impulse-Momentum Theorem")[
  The *impulse* delivered by a net force over a time interval $[t_1, t_2]$ equals the change in momentum:
  $
    bold(J) = integral_(t_1)^(t_2) sum bold(F) dif t = bold(p)(t_2) - bold(p)(t_1).
  $
  For a constant force, $bold(J) = sum bold(F) Delta t$.
]

#example(name: "Collision of Two Particles")[ // 两粒子碰撞
  Two particles of masses $m_1$, $m_2$ interact during a collision. By Newton's third law, the forces they exert on each other are equal and opposite at every instant. Integrating over the collision time:
  $
    Delta bold(p)_1 = - Delta bold(p)_2.
  $
  Hence the *total* momentum of the system is conserved:
  $
    bold(P)_"initial" = bold(P)_"final".
  $
  This holds regardless of the detailed nature of the interaction force.
]

=== Conservation of Linear Momentum // 动量守恒定律

#law(name: "Conservation of Linear Momentum")[
  If the net external force on a system is zero, the total linear momentum is conserved:
  $
    sum bold(F)_"ext" = bold(0) quad arrow quad bold(P) = "const".
  $
]

This is one of the most powerful principles in mechanics. It follows directly from Newton's second law and third law, but it applies even when the internal forces are unknown (as in collisions and explosions).

#note[
  Conservation of momentum is a consequence of *translational symmetry* of space (Noether's theorem, to be studied in Part III). If the laws of physics are the same at every pointin space, momentum must be conserved.
]

== Angular Momentum and Torque // 角动量与力矩

=== Angular Momentum of a Particle // 质点的角动量

#definition(name: "Angular Momentum of a Particle")[
  The *angular momentum* of a particle with respect to a fixed point$O$ is:
  $
    bold(L) = bold(r) times bold(p) = m bold(r) times bold(v),
  $
  where $bold(r)$ is the position vector from $O$. The SI unit is $"kg" dot "m"^2 / "s"$.
]

Differentiating with respect to time gives the rotational analogue of $sum bold(F) = dif bold(p) / dif t$:

$
  frac(dif bold(L), dif t) = frac(dif, dif t)(bold(r) times bold(p)) = bold(v) times bold(p) + bold(r) times frac(dif bold(p), dif t) = bold(r) times sum bold(F) = sum bold(tau),
$

where $bold(tau) = bold(r) times bold(F)$ is the torque about $O$.

=== Angular Momentum of a System // 质点系的角动量

#definition(name: "Total Angular Momentum")[
  For a system of particles, the total angular momentum about a point$O$ is:
  $
    bold(L) = sum_a bold(r)_a times bold(p)_a.
  $
  The torque equation generalises to:
  $
    sum bold(tau)_"ext" = frac(dif bold(L), dif t),
  $
  where $sum bold(tau)_"ext"$ is the net external torque about $O$.
]

#theorem(name: "Angular Momentum about the Centre of Mass")[
  The total angular momentum can be decomposed into "spin" (about the CM) and "orbital" (of the CM):
  $
    bold(L) = bold(R)_"CM" times bold(P) + sum_a bold(r)'_a times bold(p)'_a.
  $
  Importantly, the torque equation $sum tau_"ext" = dif bold(L) / dif t$ holds even when $O$ is the centre of mass, regardless of whether the CM is accelerating.
]

=== Conservation of Angular Momentum // 角动量守恒定律

#law(name: "Conservation of Angular Momentum")[
  If the net external torque on a system is zero, the total angular momentum is conserved:
  $
    sum bold(tau)_"ext" = bold(0) quad arrow quad bold(L) = "const".
  $
]

#example(name: "Spinning Ice Skater")[ // 旋转冰舞者
  An ice skater spins with arms extended, then pulls her arms in. No external torque acts about the vertical axis (neglecting friction), so angular momentum is conserved:
  $
    I_1 omega_1 = I_2 omega_2.
  $
  Since pulling in the arms reduces the moment of inertia ($I_2 < I_1$), the angular velocity increases ($omega_2 > omega_1$). The rotational kinetic energy $K = frac(1,2) I omega^2$ increases — the skater does work to pull her arms inward against the centrifugal effect.
]

=== Parallel Structure of Momentum and Angular Momentum // 动量与角动量的平行结构

#tex-table(
  ("Quantity", "Translation", "Rotation"),
  ("Momentum", [$bold(p) = m bold(v)$], [$bold(L) = I bold(omega)$]),
  ("Newton's law", [$sum bold(F) = dif bold(p) / dif t$], [$sum bold(tau) = dif bold(L) / dif t$]),
  ("Impulse", [$bold(J) = integral sum bold(F) dif t$], [$bold(J)_"rot" = integral sum bold(tau) dif t$]),
  ("Conservation", [$sum bold(F)_"ext" = bold(0) arrow bold(P) = text("const")$], [$sum bold(tau)_"ext" = bold(0) arrow bold(L) = text("const")$]),
  ("CM decomposition", [$bold(P) = M bold(V)_"CM"$], [$bold(L) = bold(R)_"CM" times bold(P) + bold(L)_"spin"$]),
)

== Work-Energy Theorem and Energy Conservation // 功能定理与能量守恒

=== Work and Kinetic Energy // 功与动能

#definition(name: "Work Done by a Force")[
  The infinitesimal work done by a force $bold(F)$ over a displacement $dif bold(r)$ is:
  $
    dif W = bold(F) dot dif bold(r).
  $
  The total work along a path $C$ from $A$ to $B$ is:
  $
    W_(A -> B) = integral_C bold(F) dot dif bold(r).
  $
]

#theorem(name: "Work-Energy Theorem")[
  The net work done on a particle equals its change in kinetic energy:
  $
    W_"net" = Delta K = frac(1,2) m v_B^2 - frac(1,2) m v_A^2.
  $
]

#proof[
  $
    W_"net" = integral_C m bold(a) dot dif bold(r) = integral_(t_A)^(t_B) m frac(dif bold(v), dif t) dot bold(v) dif t
            = integral_(t_A)^(t_B) frac(dif, dif t) (frac(1,2) m v^2) dif t
            = frac(1,2) m v_B^2 - frac(1,2) m v_A^2.
  $
]

The rotational analogue is:

#theorem(name: "Rotational Work-Energy Theorem")[
  The net work done by torques equals the change in rotational kinetic energy:
  $
    W_"net" = integral tau dif theta = Delta K_"rot" = frac(1,2) I omega_B^2 - frac(1,2) I omega_A^2.
  $
]

=== Conservative Forces and Potential Energy // 保守力与势能

#definition(name: "Conservative Force")[
  A force $bold(F)$ is *conservative* if the work it does is independent of the path taken, depending only on the endpoints. Equivalently:
  - The circulation around any closed loop vanishes: $integral.cont bold(F) dot dif bold(r) = 0$.
  - The force can be expressed as the negative gradient of a scalar potential: $bold(F) = - nabla V$.
]

#property(name: "Conditions for a Conservative Force")[
  In three dimensions, a force is conservative iff:
  1. $nabla times bold(F) = bold(0)$ (the force is curl-free, or irrotational).
  2. The domain is simply connected (no holes that would allow a nonzero circulation).
]

#definition(name: "Potential Energy")[
  If $bold(F)$ is conservative, the *potential energy* $V$ at $bold(r)$ relative to a reference point $bold(r)_0$ is:
  $
    V(bold(r)) = - integral_(bold(r)_0)^(bold(r)) bold(F) dot dif bold(r)'.
  $
  The work-energy theorem then becomes:
  $
    Delta K + Delta V = 0 quad arrow quad E = K + V = text("constant").
  $
]

=== Conservation of Mechanical Energy // 机械能守恒

#law(name: "Conservation of Mechanical Energy")[
  For a system subject only to conservative forces, the total mechanical energy $E = K + V$ is conserved:
  $
    E = frac(1,2) m v^2 + V(bold(r)) = "const".
  $
  When non-conservative forces (e.g., friction) are present, the work done by those forces equals the change in total mechanical energy:
  $
    W_"nc" = Delta E.
  $
]

#example(name: "Energy Analysis of a Simple Pendulum")[ // 单摆的能量分析
  A simple pendulum of length $L$ and mass $m$ is released from rest at an angle $theta_0$. The forces are gravity (conservative) and tension (does no work, since it is always perpendicular to the velocity).

  *Energy conservation:*
  $
    E = frac(1,2) m (L dot(theta))^2 + m g L (1 - cos theta) = m g L (1 - cos theta_0).
  $

  The angular velocity at the bottom ($theta = 0$) is:
  $
    dot(theta)_"max" = sqrt(frac(2 g, L) (1 - cos theta_0)) = 2 sqrt(frac(g, L)) sin frac(theta_0, 2).
  $

  For small angles, $dot(theta)_"max" approx theta_0 sqrt(g / L)$, consistent with the simple harmonic result $omega = sqrt(g / L)$.
]

=== Power // 功率

#definition(name: "Power")[
  The *power* delivered by a force is the rate of doing work:
  $
    P = frac(dif W, dif t) = bold(F) dot bold(v).
  $
  For a torque: $P = tau omega$.
]

== Isomorphism between Translational and Rotational Structures // 平动与转动的同构性

This section formalises the structural parallel that has been developed throughout Chapters 1–3. The correspondence is not merely a collection of analogies — it is a genuine mathematical *isomorphism*: the equations of translational and rotational mechanics have identical algebraic forms.

=== The Isomorphism Table // 同构对照表

#tex-table(
  ([], [*Translation*], [*Rotation*]),
  ([Kinematic variables], [$bold(r), bold(v), bold(a)$], [$theta, omega, alpha$]),
  ([Inertia], [$m$], [$I$]),
  ([Cause], [$bold(F)$], [$bold(tau)$]),
  ([Newton / Euler law], [$sum bold(F) = m bold(a)$], [$sum bold(tau) = I alpha$]),
  ([Momentum], [$bold(p) = m bold(v)$], [$bold(L) = I bold(omega)$]),
  ([Impulse], [$bold(J) = integral sum bold(F) dif t$], [$bold(J)_"rot" = integral sum bold(tau) dif t$]),
  ([Newton's law (momentum form)], [$sum bold(F) = dif bold(p) / dif t$], [$sum bold(tau) = dif bold(L) / dif t$]),
  ([Kinetic energy], [$K = frac(1,2) m v^2$], [$K = frac(1,2) I omega^2$]),
  ([Work], [$W = integral bold(F) dot dif bold(r)$], [$W = integral tau dif theta$]),
  ([Power], [$P = bold(F) dot bold(v)$], [$P = tau omega$]),
  ([Conservation], [no net $bold(F)_"ext" arrow bold(p)$ const], [no net $bold(tau)_"ext" arrow bold(L)$ const]),
)

=== Why This Matters // 为什么这很重要

#note[
  The translational-rotational isomorphism is not just a pedagogical convenience. It reflects a deep fact about the structure of classical mechanics: both sets of equations arise from the same underlying variational principle (Hamilton's principle, Part II). When we later study Lagrangian mechanics, we will see that a single equation — the Euler-Lagrange equation — produces *both* the translational and rotational equations of motion, depending only on which generalized coordinates we choose.

  Moreover, this isomorphism extends beyond rigid-body mechanics. The same mathematical structures (configuration spaces, momenta, conjugate variables) reappear in field theory, quantum mechanics, and even statistical mechanics. Mastering the translational-rotational correspondence is the first step toward recognising these unifying patterns.
]

== Potential Energy and Force Fields // 势能与力场

=== One-Dimensional Systems // 一维系统

For a particle moving in one dimension under a conservative force $F(x) = - dif V / dif x$, the energy $E = frac(1,2) m dot(x)^2 + V(x)$ is conserved. This allows a complete qualitative analysis of the motion without solving the equation of motion.

#definition(name: "Effective Potential and Turning Points")[
  For a given energy $E$, the motion is confined to regions where $V(x) <= E$. The points where $V(x) = E$ are *turning points* — the particle stops and reverses direction.
]

#example(name: "Energy Diagram of a Quartic Oscillator")[ // 四次振子的能量图
  Consider the potential $V(x) = frac(1,2) k x^2 + frac(1,4) alpha x^4$ ($alpha > 0$).

  - For small energies, the quartic term is negligible and the motion is approximately simple harmonic (as in *Optique*, Part I, Chapter 1).
  - For large energies, the quartic term dominates, giving anharmonic oscillations with a frequency that increases with amplitude.
  - The turning points are found by solving $V(x) = E$, which generally requires a quartic equation but can be solved numerically or graphically.
]

=== Three-Dimensional Conservative Fields // 三维保守力场

#definition(name: "Force from Potential")[
  In three dimensions, a conservative force is the negative gradient of a scalar potential:
  $
    bold(F) = - nabla V = - (frac(partial V, partial x), frac(partial V, partial y), frac(partial V, partial z)).
  $
  In spherical coordinates (relevant for central forces):
  $
    bold(F) = - (frac(partial V, partial r) bold(e_r) + frac(1, r) frac(partial V, partial theta) bold(e_theta) + frac(1, r sin theta) frac(partial V, partial phi) bold(e_phi)).
  $
]

#property(name: "Properties of Conservative Fields")[
  - $nabla times bold(F) = bold(0)$ (the field is irrotational).
  - The work around any closed path is zero: $integral.cont bold(F) dot dif bold(r) = 0$.
  - The potential $V$ is defined up to an additive constant.
  - Equipotential surfaces ($V = text("const")$) are perpendicular to field lines.
]

=== Central Forces // 中心力

A particularly important class of conservative forces in mechanics is the *central force* — a force that depends only on the distance from a fixed pointand points radially:

$
  bold(F) = F(r) bold(e_r), quad F(r) = - frac(dif V(r), dif r).
$

Central forces conserve angular momentum (since $bold(tau) = bold(r) times bold(F) = bold(0)$), and the motion is confined to a plane. These properties will be used extensively in Chapter 4 (Celestial Mechanics) and again in Part III (Lagrangian mechanics, central force applications).

#note[
  This chapter has established the three pillars of conservation — momentum, angular momentum, and energy — each linked to a fundamental symmetry of space and time. These conservation laws are not just convenient shortcuts; they are deeper than the equations of motion themselves. In Part III, Noether's theorem will reveal the direct connection: every continuous symmetry of the action implies a conserved quantity.
]

// Chapter 4: Celestial Mechanics Foundations (天体力学基础)
//   Section 4.1: Kepler's Laws (开普勒定律)
//   Section 4.2: Orbit Classification (轨道分类)
//   Section 4.3: Two-Body Problem and Reduced Mass (二体问题与约化质量)
= Celestial Mechanics Foundations // 天体力学基础

Celestial mechanics studies the motion of astronomical bodies under gravitational forces. This brief chapter establishes the essential results — Kepler's laws, orbit classification, and the two-body reduction — that will be revisited in Part III from the Lagrangian perspective.

== Kepler's Laws // 开普勒定律

Based on Tycho Brahe's meticulous observations, Johannes Kepler formulated three empirical laws of planetary motion.

#law(name: "Kepler's Laws of Planetary Motion")[
  1. *Law of Ellipses:* Each planet moves in an ellipse with the Sun at one focus.
  2. *Law of Equal Areas:* The radius vector from the Sun to a planet sweeps out equal areas in equal times.
  3. *Law of Periods:* The square of the orbital period is proportional to the cube of the semi-major axis:
     $
       T^2 = frac(4 pi^2, G M) a^3,
     $
     where $a$ is the semi-major axis, $M$ is the solar mass, and $G$ is the gravitational constant.
]

The second law is a direct consequence of angular momentum conservation: for a central force, $bold(tau) = bold(r) times bold(F) = bold(0)$, so $bold(L) = m bold(r) times bold(v)$ is constant, implying the areal velocity $dif A / dif t = L / (2m)$ is constant.

== Orbit Classification // 轨道分类

The general solution of the two-body problem is a *conic section* (ellipse, parabola, hyperbola) with the centre of mass at one focus.

#definition(name: "Orbital Eccentricity")[
  The shape of an orbit is determined by its *eccentricity* $e$:
  $
    e = 0: quad text("circular"), quad
    0 < e < 1: quad text("elliptical"), quad
    e = 1: quad text("parabolic"), quad
    e > 1: quad text("hyperbolic").
  $
  The total energy determines the type:
  - $E < 0$: bound orbit (elliptical or circular),
  - $E = 0$: unbound, parabolic escape trajectory,
  - $E > 0$: unbound, hyperbolic flyby.
]

#note[
  The energy-orbit connection is profound: a bound system ($E < 0$) always follows a closed or quasi-periodic orbit, while an unbound system ($E >= 0$) escapes to infinity. This classification reappears in the effective potential analysis of central forces in Part III.
]

== Two-Body Problem and Reduced Mass // 二体问题与约化质量

The gravitational two-body problem — two masses $m_1$ and $m_2$ interacting via $F = G m_1 m_2 / r^2$ — can be reduced to an equivalent one-body problem.

#theorem(name: "Reduction to One-Body Problem")[
  The relative motion of two bodies under a mutual central force is equivalent to the motion of a single particle of *reduced mass*
  $
    mu = frac(m_1 m_2, m_1 + m_2)
  $
  about a fixed centre of force located at the centre of mass. The equation of motion for the relative coordinate $bold(r) = bold(r)_1 - bold(r)_2$ is:
  $
    mu dot.double(bold(r)) = - frac(G m_1 m_2, r^2) hat(bold(r)).
  $
]

#example(name: "Earth-Sun System")[ // 地日系统
  For the Earth-Sun system, $m_ "Sun" = 1.989 times 10^30 "kg"$, $m_ "Earth" = 5.972 times 10^24 "kg"$.
  The reduced mass is:
  $
    mu = frac(m_ "Sun" m_ "Earth", m_ "Sun" + m_ "Earth") approx m_ "Earth" (1 - frac(m_ "Earth", m_ "Sun")) approx 5.972 times 10^24 "kg",
  $
  which is essentially the Earth's mass because $m_ "Sun" >> m_ "Earth"$. The Sun is nearly stationary at the centre of mass, and the Earth's orbit is nearly Keplerian around it.
]

#note[
  The two-body reduction is the foundation of celestial mechanics. In Part III (Lagrangian mechanics), we will derive the same result from a Lagrangian with translational symmetry, and the conserved quantities (energy, angular momentum) will emerge directly from Noether's theorem.
]

// Chapter 5: Fluid Mechanics Foundations (流体力学基础)
//   Section 5.1: Continuum Hypothesis and Density Fields (连续体假设与密度场)
//   Section 5.2: Euler's Equations of Motion (欧拉运动方程)
//   Section 5.3: Bernoulli's Equation (伯努利方程)
= Fluid Mechanics Foundations // 流体力学基础

Fluid mechanics describes the motion of continuous deformable media — liquids and gases. This chapter provides the minimal foundation needed to appreciate the parallels between particle mechanics and continuum mechanics in later parts of the notes.

== Continuum Hypothesis and Density Fields // 连续体假设与密度场

#definition(name: "Continuum Hypothesis")[
  A fluid is modelled as a continuous medium, ignoring its molecular discreteness. The fundamental fields are:
  - *Mass density*: $rho(bold(r), t)$ (mass per unit volume),
  - *Velocity field*: $bold(v)(bold(r), t)$,
  - *Pressure field*: $p(bold(r), t)$.
]

The total mass in a volume $V$ is $M = integral_V rho dif V$. Mass conservation is expressed by the *continuity equation*:

$
  frac(partial rho, partial t) + nabla dot (rho bold(v)) = 0,
$

which states that the rate of change of mass in any volume equals the net flux of mass through its boundary.

== Euler's Equations of Motion // 欧拉运动方程

For an *inviscid* (frictionless) fluid, Newton's second law applied to a fluid element gives Euler's equation:

#law(name: "Euler's Equation for Inviscid Flow")[
  $
    rho frac(D bold(v), D t) = - nabla p + rho bold(g),
  $
  where $frac(D, D t) = frac(partial, partial t) + bold(v) dot nabla$ is the *material derivative* (the rate of change following a fluid element). In component form:
  $
    frac(partial bold(v), partial t) + (bold(v) dot nabla) bold(v) = - frac(1, rho) nabla p + bold(g).
  $
]

The term $(bold(v) dot nabla) bold(v)$ is the *convective acceleration* — it accounts for the fact that fluid particles move to regions of different velocity even in steady flow.

#note[
  Euler's equation is the fluid analogue of Newton's second law. In Part VI (Classical Field Theory), we will see how it emerges from a variational principle applied to a continuous medium.
]

== Bernoulli's Equation // 伯努利方程

For steady, incompressible ($rho = "const"$), inviscid flow along a streamline, Euler's equation integrates to Bernoulli's principle:

#law(name: "Bernoulli's Equation")[
  Along a streamline in steady, inviscid, incompressible flow:
  $
    p + frac(1,2) rho v^2 + rho g y = text("constant"),
  $
  where $p$ is the pressure, $frac(1,2) rho v^2$ is the dynamic pressure, and $rho g y$ is the gravitational potential energy density.
]

#example(name: "Venturi Effect and Airplane Wing")[ // 文丘里效应与机翼
  *Venturi tube:* When a fluid flows through a constricted pipe, the velocity increases and the pressure drops. This is the operating principle of carburetors and perfume atomisers.

  *Airplane wing:* The curved upper surface of an airfoil forces air to travel faster over the top than the bottom. By Bernoulli's equation, the faster flow above creates lower pressure, generating lift. (In reality, the full explanation also involves the angle of attack and circulation — a topic for advanced fluid dynamics.)
]

#note[
  Bernoulli's equation is a statement of energy conservation for fluid flow: the sum of pressure energy, kinetic energy density, and gravitational potential energy density is constant along a streamline. This is the fluid analogue of the mechanical energy conservation from Chapter 3.
]

This completes the Classical Mechanics Foundations part. The next part (Mathematical Foundations) introduces the variational calculus that underpins analytical mechanics. All the concepts developed here — conservation laws, oscillations, central forces, and continuum mechanics — will be revisited and deepened through the Lagrangian and Hamiltonian formalisms.

// =========================================================================
// --- Part II: Mathematical Foundations (数学基础) ---
// =========================================================================
// 设计思路：本 Part 是主线"经典力学 → 分析力学"的工具与公理阶段。
//   Part I 用 Newton 语言建立物理直觉；本 Part 切换到变分语言，先备齐数学工具
//   （变分法、广义坐标、约束与虚位移），再以 Hamilton 原理为公理起点，
//   为 Part III 把公理转化为 Lagrange 方程铺路。
//   职责边界：连续时间变分法归本笔记（Optimisation Convexe 已显式委托）；
//   分布论形式的基本引理见 PDE 笔记；无穷维/弱变分理论见 Analyse Fonctionnelle；
//   Legendre 变换与 Noether 定理分别推迟到 Hamiltonian Part 与 Lagrangian Part。
// 对应教材：Goldstein ch.1–2；Landau-Lifshitz 1–5；Arnold ch.1–3
// 编号说明：全笔记蓝图采用与 PDF 一致的编号——Part I–VI 对应渲染罗马数字，
//   章号全局连续（Part I = Ch 1–5，本 Part = Ch 6–8，Part III = Ch 9–11，依此类推）。

#part("Mathematical Foundations") // 数学基础

// Chapter 6: Variational Calculus (变分法)
//   Section 6.1: Variational Method and First Variation (变分法与第一变分)
//   Section 6.2: Euler-Lagrange Equation (欧拉-拉格朗日方程)
//   Section 6.3: Variational Problems with Constraints (带约束的变分问题)
= Variational Calculus  // 变分法

== Variational Method and First Variation // 变分法与第一变分

In analytical mechanics, we optimize objects whose input is a whole function (or path), not a finite-dimensional vector.
This leads naturally from ordinary calculus to variational calculus.

#definition(name: "Functional")[
  A *functional* is a map $J: cal(A) -> bb(R)$ from an admissible class $cal(A)$ of curves to the real numbers.
] <def:functional>

The central example is the integral functional

$
  J[q] = integral_a^b L(t, q, dot(q)) dif t,
$

where $L$ is a given smooth function of its three arguments and $q$ ranges over curves with fixed endpoints.
The goal is to find the curve $q$ that makes $J$ stationary.

#note(title: "Scope")[
  This chapter treats the classical, finite-dimensional variational calculus needed for mechanics.
  The functional-analytic direct method and weak formulations belong to Analyse Fonctionnelle; the distributional form of the fundamental lemma belongs to the PDE note.
]

#definition(name: "Admissible Variation")[
  Let $q$ be an admissible curve with fixed endpoints $q(a)=q_a$, $q(b)=q_b$.
  A variation of $q$ is a family

  $
    q_(epsilon)(t) = q(t) + epsilon eta(t),
  $

  where $eta(a)=eta(b)=0$ and $eta$ is sufficiently smooth.
] <def:admissible-variation>

=== First Variation

#definition(name: "First Variation")[
  The first variation of $J$ at $q$ along $eta$ is

  $
    delta J[q; eta] = lr(frac(dif, dif epsilon) J[q + epsilon eta]|)_(epsilon=0).
  $

  A curve $q$ is called *stationary* if $delta J[q; eta] = 0$ for every admissible $eta$.
] <def:first-variation>

For the integral functional, direct differentiation gives

$
  delta J[q; eta] = integral_a^b ( frac(partial L, partial q) eta + frac(partial L, partial dot(q)) dot(eta) ) dif t.
$

Integration by parts moves the derivative off $eta$ and produces a boundary term:

$
  delta J[q; eta] = lr(frac(partial L, partial dot(q)) eta|)_a^b + integral_a^b ( frac(partial L, partial q) - frac(dif, dif t) frac(partial L, partial dot(q)) ) eta(t) dif t.
$

For endpoint-fixed variations $eta(a)=eta(b)=0$, so the boundary term vanishes and only the integral remains.

#note(title: "What comes next")[
  The integrand is a fixed function multiplied by the arbitrary test function $eta$.
  Extracting a pointwise differential equation from this integral identity requires the fundamental lemma of variational calculus, stated in the next section.
]

This variational viewpoint is the direct bridge to Hamilton's principle and the full Lagrangian formalism.

== Euler-Lagrange Equation // 欧拉-拉格朗日方程

The Euler-Lagrange equation is the local differential form of stationarity for the action functional.
It turns a global variational statement into equations of motion.

=== Fundamental Lemma of Variational Calculus // 变分法基本引理

#lemma(name: "Fundamental Lemma (du Bois-Reymond, classical form)")[
  Let $f$ be continuous on $[a, b]$.
  If

  $
    integral_a^b f(t) eta(t) dif t = 0
  $

  for every smooth $eta$ with $eta(a)=eta(b)=0$, then $f(t) = 0$ for all $t in [a, b]$.
] <lem:fundamental-lemma>

#proof(name: "of the fundamental lemma")[
  Suppose $f(t_0) != 0$ for some interior point $t_0$; without loss of generality $f(t_0) > 0$.
  By continuity, $f > 0$ on a small interval around $t_0$.
  Choose a smooth bump $eta >= 0$ supported in that interval with $eta(t_0) > 0$.
  Then $integral_a^b f eta dif t > 0$, contradicting the hypothesis.
  Hence $f$ vanishes on the interior, and by continuity on all of $[a, b]$.
]

#note(title: "Distributional version")[
  When $f$ is only locally integrable, the same conclusion holds almost everywhere; that is the du Bois-Reymond lemma used in weak formulations and distribution theory, treated in the PDE note.
  The classical continuous form above suffices for the smooth Lagrangians of mechanics.
]

=== Single-Coordinate Equation // 单坐标方程

#definition(name: "Euler-Lagrange Equation (Single Coordinate)")[
  For

  $
    J[q] = integral_a^b L(t, q, dot(q)) dif t,
  $

  with fixed endpoints $q(a), q(b)$, a stationary curve satisfies

  $
    frac(partial L, partial q) - frac(dif, dif t) frac(partial L, partial dot(q)) = 0.
  $
] <def:euler-lagrange>

#theorem(name: "Stationarity Criterion")[
  If $q$ is stationary for $J$ under all endpoint-fixed variations, then $q$ satisfies the Euler-Lagrange equation.
] <thm:stationarity-criterion>

#proof(name: "of the stationarity criterion")[
  By the integration-by-parts identity of *Variational Method and First Variation*, stationarity gives

  $
    integral_a^b ( frac(partial L, partial q) - frac(dif, dif t) frac(partial L, partial dot(q)) ) eta(t) dif t = 0
  $

  for every admissible $eta$.
  The coefficient of $eta$ is continuous, so the #link(<lem:fundamental-lemma>)[fundamental lemma] forces it to vanish identically.
]

=== Multi-Coordinate Form // 多坐标形式

#theorem(name: "Euler-Lagrange System")[
  For coordinates $q_1, dots, q_n$ and

  $
    S[q] = integral_(t_0)^(t_1) L(t, q_1, dots, q_n, dot(q)_1, dots, dot(q)_n) dif t,
  $

  stationarity under endpoint-fixed variations implies, for each $i=1,dots,n$,

  $
    frac(dif, dif t) frac(partial L, partial dot(q)_i) - frac(partial L, partial q_i) = 0.
  $
] <thm:euler-lagrange-system>

#proof(name: "of the Euler-Lagrange system")[
  Vary each coordinate independently: take $eta_i$ arbitrary and $eta_j = 0$ for $j != i$.
  The single-coordinate argument applies to each $i$ in turn.
]

#note(title: "Terminology")[
  The independent coordinates $q_i$ are the generalized coordinates formalized in *Degrees of Freedom and Generalized Coordinates*.
  Here they are simply any set of independent parameters describing the configuration.
]

=== Natural Boundary Conditions (Free Endpoints) // 自然边界条件（自由端点）

#note(title: "Free endpoints")[
  If an endpoint is free, the boundary term does not automatically vanish.
  One then obtains a natural boundary condition, typically $frac(partial L, partial dot(q)) = 0$ at that free endpoint (or its constrained variant).
]

=== First Integrals and Cyclic Coordinates // 第一积分与循环坐标

A first integral is a quantity conserved along every solution of the Euler-Lagrange equation.
Two structural features of $L$ produce first integrals immediately.

#proposition(name: "Cyclic Coordinate")[
  If $frac(partial L, partial q_k) = 0$, then

  $
    frac(dif, dif t) frac(partial L, partial dot(q)_k) = 0,
  $

  so the conjugate momentum $p_k = frac(partial L, partial dot(q)_k)$ is conserved.
] <prop:cyclic-coordinate>

#proposition(name: "Beltrami Identity (Autonomous Case)")[
  If $L$ has no explicit $t$-dependence, then the energy function

  $
    E = sum_i dot(q)_i frac(partial L, partial dot(q)_i) - L
  $

  is constant along solutions.
  For a single coordinate this is the Beltrami identity $L - dot(q) frac(partial L, partial dot(q)) = "const"$.
] <prop:beltrami>

#proof(name: "of the Beltrami identity")[
  Differentiate $E$ and expand $dif L / dif t$ by the chain rule:

  $
    frac(dif E, dif t) = sum_i dot(q)_i ( frac(dif, dif t) frac(partial L, partial dot(q)_i) - frac(partial L, partial q_i) ) - frac(partial L, partial t).
  $

  The sum vanishes by the Euler-Lagrange system, leaving $dif E / dif t = - partial L / partial t$.
  Autonomy gives $partial L / partial t = 0$, hence $E$ is constant.
]

#note(title: "Physical interpretation")[
  These are the mathematical first integrals of the Euler-Lagrange equation.
  Their physical meaning as conservation laws, and their origin in symmetry via Noether's theorem, are developed in *Conservation Laws in Lagrangian Mechanics*.
]

=== Examples // 例子

#example(name: "Shortest curve in the plane")[
  Consider

  $
    J[y] = integral_(x_0)^(x_1) sqrt(1 + (y')^2) dif x
  $

  with fixed endpoints $y(x_0)=y_0$, $y(x_1)=y_1$.
  Here $L(y, y') = sqrt(1 + (y')^2)$ does not depend explicitly on $y$, so the cyclic-coordinate first integral gives $frac(partial L, partial y')$ constant.
  Hence $y' = C$ and the stationary curve is a line segment.
]

#example(name: "Particle in a potential field")[
  Let

  $
    L(q, dot(q)) = frac(1,2) m dot(q)^2 - V(q).
  $

  Then $frac(partial L, partial dot(q)) = m dot(q)$ and $frac(partial L, partial q) = -frac(dif V, dif q)$.
  The Euler-Lagrange equation becomes

  $
    m frac(dif^2 q, dif t^2) + frac(dif V, dif q) = 0,
  $

  i.e. Newton's equation $m dot.double(q) = -frac(dif V, dif q)$.
  This is the mathematical verification that the variational formalism reproduces Newtonian mechanics; the physical callback is revisited in *Lagrange's Equations of the Second Kind*.
]

#example(name: "Brachistochrone")[
  A bead slides without friction under gravity from one point to a lower one.
  Taking $y$ positive downward, the descent time is

  $
    T[y] = integral_(x_0)^(x_1) sqrt(frac(1 + (y')^2, 2 g y)) dif x.
  $

  The integrand $L(y, y')$ has no explicit $x$-dependence, so the Beltrami identity applies:

  $
    L - y' frac(partial L, partial y') = "const".
  $

  Substituting $L$ and simplifying yields $y (1 + (y')^2) = 2 a$ for a constant $a$.
  The solution is a cycloid,

  $
    x = a (theta - sin theta), quad y = a (1 - cos theta),
  $

  the curve of fastest descent.
  This example shows the power of the first integral: it reduces a second-order Euler-Lagrange equation to a first-order relation that can be integrated directly.
]

This section provides the variational core used in the next chapters on Lagrange's equations, constraints, and Hamiltonian reformulation.


== Variational Problems with Constraints // 带约束的变分问题

Stationarity is often sought not over all curves but over curves satisfying a constraint.
Two kinds of constraint appear in mechanics, and both are handled by Lagrange multipliers.

- *Integral (isoperimetric) constraints*: a global condition such as fixed length or fixed area, written as an integral equal to a constant.
- *Pointwise (holonomic) constraints*: a relation $f(q, t) = 0$ imposed at every instant, restricting the configuration itself.

=== Isoperimetric Problems // 等周问题

#definition(name: "Isoperimetric Problem")[
  An *isoperimetric problem* seeks a stationary curve of $J[q] = integral_a^b L(t, q, dot(q)) dif t$ among endpoint-fixed curves satisfying

  $
    integral_a^b g(t, q, dot(q)) dif t = K,
  $

  where $K$ is a prescribed constant.
] <def:isoperimetric>

#theorem(name: "Multiplier Rule for Integral Constraints")[
  Let $q$ be a stationary curve of the isoperimetric problem, and assume the constraint is non-degenerate at $q$.
  Then there exists a constant $lambda$ such that $q$ satisfies the Euler-Lagrange equation of the augmented integrand $L + lambda g$:

  $
    frac(dif, dif t) frac(partial (L + lambda g), partial dot(q)) - frac(partial (L + lambda g), partial q) = 0.
  $
] <thm:isoperimetric-multiplier>

#proof(name: "sketch")[
  Introduce a two-parameter family $q + epsilon eta + epsilon' zeta$, where $zeta$ is chosen so that the constraint can be maintained by adjusting $epsilon'$ as a function of $epsilon$.
  Stationarity of $J$ under all constraint-preserving variations then forces the first variation of $J$ to be proportional to the first variation of the constraint functional.
  The proportionality constant is $lambda$, and the #link(<lem:fundamental-lemma>)[fundamental lemma] converts the resulting integral identity into the augmented Euler-Lagrange equation.
]

#note(title: "Rigor")[
  The non-degeneracy hypothesis and the existence of $lambda$ are instances of the Lagrange multiplier theorem; their functional-analytic justification belongs to Analyse Fonctionnelle and optimization theory.
  The formal derivation above is the form used in mechanics.
]

=== Pointwise Holonomic Constraints // 逐点完整约束

#theorem(name: "Multiplier Form for Holonomic Constraints")[
  Let $q$ be stationary for $J[q] = integral_a^b L(t, q, dot(q)) dif t$ subject to pointwise constraints

  $
    f_(alpha)(q, t) = 0, quad alpha = 1, dots, m,
  $

  with fixed endpoints and independent constraint gradients.
  Then there exist multiplier functions $lambda_(alpha)(t)$ such that, for each coordinate $q_i$,

  $
    frac(dif, dif t) frac(partial L, partial dot(q)_i) - frac(partial L, partial q_i) = sum_(alpha=1)^m lambda_(alpha) frac(partial f_(alpha), partial q_i).
  $
] <thm:holonomic-multiplier>

#proof(name: "sketch")[
  Augment the integrand to $L + sum_(alpha=1)^m lambda_(alpha)(t) f_(alpha)(q, t)$.
  Because the constraints hold at every instant, the multipliers are functions of $t$ rather than constants.
  The constraints involve no velocities, so $partial f_(alpha) / partial dot(q)_i = 0$; applying the Euler-Lagrange system to the augmented integrand gives the stated form.
]

The multiplier functions $lambda_(alpha)(t)$ are not arbitrary: they are determined together with $q$ by the equations of motion and the constraints.
In mechanics they encode the constraint reaction forces, as developed in *Lagrange's Equations with Constraints* and *Lagrange Multipliers in Mechanics*.

#note(title: "Bridge to mechanics")[
  This section is the mathematical foundation for the constrained Lagrange equations of the Lagrangian Part.
  The integral-constraint multiplier is a constant; the pointwise-constraint multiplier is a function of time.
  Both reduce a constrained variational problem to an unconstrained one for an augmented Lagrangian.
]

=== Example: The Catenary // 例子：悬链线

#example(name: "Hanging chain (catenary)")[
  A uniform flexible chain of fixed length hangs in equilibrium between two points.
  Its shape minimizes the gravitational potential energy subject to the length constraint.
  With $y$ the height and $s$ the arc length, the problem is

  $
    "minimize" integral y sqrt(1 + (y')^2) dif x quad "subject to" integral sqrt(1 + (y')^2) dif x = ell.
  $

  This is isoperimetric with $L = y sqrt(1 + (y')^2)$ and $g = sqrt(1 + (y')^2)$.
  The augmented integrand is $F = (y + lambda) sqrt(1 + (y')^2)$.
  Since $F$ has no explicit $x$-dependence, the Beltrami identity gives

  $
    F - y' frac(partial F, partial y') = frac(y + lambda, sqrt(1 + (y')^2)) = a,
  $

  a constant.
  Solving this first-order equation yields the catenary

  $
    y = a cosh(frac(x - b, a)) - lambda,
  $

  where $a, b, lambda$ are fixed by the endpoints and the length $ell$.
  The multiplier $lambda$ shifts the curve vertically and is determined by the constraint.
]



// Chapter 7: Description of Mechanical Systems (力学系统的完整描述)
//   Section 7.1: Degrees of Freedom and Generalized Coordinates (自由度与广义坐标)
//   Section 7.2: Classification of Constraints (约束的分类)
//   Section 7.3: Real Displacements and Virtual Displacements (实位移与虚位移)
//   Section 7.4: D'Alembert's Principle and Virtual Work (达朗贝尔原理与虚功原理) [← Retrospective to Part I Ch. 2]
= Description of Mechanical Systems // 力学系统的完整描述

Before we can apply Hamilton's principle, we must describe the system we are studying. This chapter introduces the concepts that bridge the physical system to its mathematical representation: generalized coordinates, constraints, virtual displacements, and D'Alembert's principle.

== Degrees of Freedom and Generalized Coordinates // 自由度与广义坐标

The first step in any Lagrangian analysis is to choose a set of independent coordinates that fully describe the configuration of the system.

#definition(name: "Generalized Coordinates")[
  A set of $n$ independent parameters $q_1, q_2, ..., q_n$ that uniquely specify the configuration of a mechanical system are called *generalized coordinates*. The number $n$ is the number of *degrees of freedom*.

  For an unconstrained system of $N$ particles in 3D space: $n = 3N$.
  For a system with $k$ independent holonomic constraints: $n = 3N - k$.
]

The generalised coordinates need not be Cartesian — they can be angles, distances, or any other convenient parameters. The choice of coordinates is the most important skill in Lagrangian mechanics.

== Classification of Constraints // 约束的分类

#definition(name: "Holonomic and Nonholonomic Constraints")[
  A constraint is *holonomic* if it can be written as an equation relating coordinates (and possibly time):
  $
    f(q_1, ..., q_n, t) = 0.
  $
  Constraints that cannot be written in this form (e.g., inequalities or velocity-dependent relations) are *nonholonomic*.

  Holonomic constraints reduce the number of independent coordinates; nonholonomic constraints reduce the number of accessible velocities but not the configuration dimension.
]

Examples of holonomic constraints: a bead on a wire ($f = 0$ fixes the position to a curve), a rigid body ($|r_i - r_j| = text("const")$ for all pairs).
Examples of nonholonomic constraints: a rolling wheel without slipping (velocity-dependent), a particle confined to a region ($x > 0$).

== Real Displacements and Virtual Displacements // 实位移与虚位移

#definition(name: "Virtual Displacement")[
  A *virtual displacement* $delta q_i$ is an infinitesimal change in the coordinates that is *consistent with the constraints at a fixed instant of time* — it does not violate the constraints and does not involve time evolution.

  This contrasts with a *real displacement* $dif q_i$, which occurs over an infinitesimal time interval $dif t$ and respects both the constraints and the equations of motion.
]

The key difference: a virtual displacement is a *comparison* between two neighbouring paths at the same instant, while a real displacement is the actual motion along a single path over time.

== D'Alembert's Principle and Virtual Work // 达朗贝尔原理与虚功原理

#definition(name: "Virtual Work")[
  The *virtual work* done by a force $bold(F)_a$ acting on particle $a$ under a virtual displacement $delta bold(r)_a$ is:
  $
    delta W = sum_a bold(F)_a dot delta bold(r)_a.
  $
  For a system in equilibrium, $delta W = 0$ for all virtual displacements (the *principle of virtual work*).
]

#law(name: "D'Alembert's Principle")[
  For a system in motion, the sum of the applied forces and the *inertial forces* vanishes for any virtual displacement:
  $
    sum_a (bold(F)_a - m_a bold(a)_a) dot delta bold(r)_a = 0.
  $
]

D'Alembert's principle transforms dynamics into a form of statics by including the inertial term $-m bold(a)$.
In the next chapter we show that, for holonomic systems whose applied forces derive from a potential, this principle is equivalent to Hamilton's principle of stationary action; together they lead to Lagrange's equations.

#note(title: "The logical chain")[
  The chain is taking shape: generalized coordinates → constraints → virtual displacements → D'Alembert's principle → (next chapter) Hamilton's principle → Lagrange's equations.
  Each step translates the Newtonian picture into a more abstract but more powerful language; the chain closes in the Lagrangian Part.
]

// Chapter 8: Axiom: Hamilton's Principle (公理：哈密顿原理 - 最小作用量原理)
//   Section 8.1: Definition of Action Functional (作用量泛函的定义)
//   Section 8.2: Axiomatic Statement (公理陈述)
//   Section 8.3: Additivity and Gauge Invariance of Lagrangian (拉格朗日量的可加性与不唯一性)
= Axiom: Hamilton's Principle // 公理：哈密顿原理

In this notebook, we take Hamilton's principle as the foundational axiom-like starting point of analytical mechanics.

== Definition of Action Functional // 作用量泛函的定义

Before stating the principle, we fix the basic objects:

- A configuration curve $q: [t_0, t_1] -> Q$ in configuration space $Q$.
- A Lagrangian $L(t, q, dot(q))$.
- An action functional

$
  S[q] = integral_(t_0)^(t_1) L(t, q, dot(q)) dif t.
$

Here a *functional* means a map from a function space to real numbers, e.g. $S: cal(A) -> bb(R)$ on an admissible curve class $cal(A)$, as in #link(<def:functional>)[Functional].

== Axiomatic Statement // 公理陈述

#axiom(name: "Hamilton's Principle (Stationary Action)")[
  Among all admissible curves with fixed endpoints,

  $
    q(t_0) = q_0, quad q(t_1) = q_1,
  $

  the physical trajectory $q$ is characterized by the stationarity condition

  $
    delta S[q; eta] = 0
  $

  for all endpoint-fixed admissible variations.
] <ax:hamilton>

Equivalently, with a variation family

$
  q_(epsilon)(t) = q(t) + epsilon eta(t), quad eta(t_0)=eta(t_1)=0,
$

the first-order term in $S[q_epsilon] - S[q]$ vanishes at $epsilon = 0$.

#note(title: "Stationary, not minimal")[
  In rigorous mathematical language, this is a *stationary* principle, not necessarily a strict minimum principle.
  The phrase "least action" is historical; "stationary action" is the precise formulation.
  A necessary condition for a minimum is the non-negativity of the second variation, which leads to the Legendre condition $frac(partial^2 L, partial dot(q)^2) >= 0$; this sufficiency question lies beyond the present axiom.
]

#caution(title: "Scope of the axiom")[
  The axiom in this simple form applies under two hypotheses:

  - *Holonomic constraints.* The constraints are expressible as $f_(alpha)(q, t) = 0$, so admissible variations are tangent to the constraint submanifold and the #link(<thm:holonomic-multiplier>)[multiplier form for holonomic constraints] applies.
  - *Monogenic forces.* The applied forces derive from a potential, so a Lagrangian $L = T - V$ (or a generalized potential) exists.

  For *nonholonomic* constraints, such as rolling without slipping, stationarity of $S$ among constraint-satisfying curves gives *vakonomic* dynamics, which differs from the physical motion.
  The correct equations for nonholonomic systems come from D'Alembert's principle, not from naive stationary action.
  Non-potential forces such as friction require the generalized-force extension of the Lagrangian Part.
]

=== Equivalence with D'Alembert's Principle // 与达朗贝尔原理的等价性

#proposition(name: "Equivalence of D'Alembert and Hamilton")[
  For a holonomic system whose applied forces derive from a potential $V(q, t)$, D'Alembert's principle is equivalent to Hamilton's principle with $L = T - V$.
] <prop:dalembert-hamilton>

#proof(name: "of the equivalence")[
  *Step 1: virtual displacements.* Holonomic constraints give $delta bold(r)_a = sum_i frac(partial bold(r)_a, partial q_i) delta q_i$ with independent $delta q_i$.

  *Step 2: applied forces.* Monogenic forces give $sum_a bold(F)_a dot delta bold(r)_a = - sum_i frac(partial V, partial q_i) delta q_i$.

  *Step 3: inertial term.* With $T = frac(1,2) sum_a m_a abs(dot(bold(r))_a)^2$, the standard kinetic-energy identity gives

  $
    sum_a m_a bold(a)_a dot delta bold(r)_a = sum_i ( frac(dif, dif t) frac(partial T, partial dot(q)_i) - frac(partial T, partial q_i) ) delta q_i.
  $

  *Step 4: combine.* D'Alembert's principle becomes

  $
    sum_i ( frac(dif, dif t) frac(partial T, partial dot(q)_i) - frac(partial T, partial q_i) + frac(partial V, partial q_i) ) delta q_i = 0.
  $

  Independence of the $delta q_i$ and $L = T - V$ yield the Euler-Lagrange system.

  *Step 5: integrate in time.* Multiplying by $dif t$, integrating from $t_0$ to $t_1$, and integrating by parts with $delta q_(i)(t_0) = delta q_(i)(t_1) = 0$ gives $delta S = 0$.
  Every step reverses, so Hamilton's principle implies D'Alembert's principle as well.
]

== Additivity and Gauge Invariance of Lagrangian // 拉格朗日量的可加性与不唯一性

#property(name: "Additivity and Gauge Invariance")[
  - *Additivity.* For non-interacting subsystems with Lagrangians $L_1, dots, L_k$, the total Lagrangian is $L = sum_(j=1)^k L_j$; interactions contribute an additional term $L_("int")$.
  - *Gauge invariance.* If $L' = L + frac(dif F, dif t)$ for a function $F(q, t)$, then $L'$ and $L$ produce the same equations of motion, because the action changes only by boundary terms.
] <prop:lagrangian-structure>

The boundary-term formula for gauge invariance is

$
  S'[q] = S[q] + F(q(t_1), t_1) - F(q(t_0), t_0),
$

so the stationarity condition is unchanged.

Additivity justifies building the Lagrangian of a many-particle system from single-particle kinetic and potential energies.
The action is additive, $S = sum_j S_j$, and for non-interacting subsystems stationarity of $S$ decouples into stationarity of each $S_j$.

Gauge freedom allows us to simplify Lagrangians by adding total time derivatives without affecting the physics.
It is the variational counterpart of the freedom to shift the potential energy by a constant.

// =========================================================================
// --- Part III: Lagrangian Mechanics (拉格朗日力学) ---
// =========================================================================
// Theme: Retrospective derivation showing how Lagrangian methods recover classical results
#part("Lagrangian Mechanics") // 拉格朗日力学

// Chapter 9: Lagrange's Equations (拉格朗日方程)
//   Section 9.1: Lagrangian Function (拉格朗日函数) [← Based on Part I Ch. 3.5: Potential Energy]
//   Section 9.2: Derivation from Hamilton's Principle (从哈密顿原理推导)
//   Section 9.3: Lagrange's Equations of the Second Kind (第二类拉格朗日方程) [← Recovers Part I Ch. 2.1]
//   Section 9.4: Generalized Forces (广义力)
//   Section 9.5: Lagrange's Equations with Constraints (带约束的拉格朗日方程) [← Generalizes Part I Ch. 2.2; math basis: Ch. 6.3]
//   Section 9.6: Lagrange Multipliers in Mechanics (力学中的拉格朗日乘子) [← math basis: Ch. 6.3]
= Lagrange's Equations // 拉格朗日方程

In this chapter, the variational principle from the previous section is converted into differential equations for motion.
The key idea is that the actual trajectory is a stationary curve of the action, and the equations of motion are the corresponding Euler-Lagrange equations in generalized coordinates.

== Lagrangian Function // 拉格朗日函数

The starting point of analytical mechanics is the *Lagrangian function*.

#definition(name: "Lagrangian")[
  For a system with generalized coordinates $q_1, dots, q_n$ and velocities $dot(q)_1, dots, dot(q)_n$, the Lagrangian is a function

  $
    L = L(t, q_1, dots, q_n, dot(q)_1, dots, dot(q)_n).
  $

  In classical mechanics, one often has

  $
    L = T - V,
  $

  where $T$ is the kinetic energy and $V$ is the potential energy.
]

The Lagrangian is not uniquely determined by the physical system: adding a total time derivative of a function of coordinates and time does not change the equations of motion.

#note[
  The choice of generalized coordinates is often more important than the explicit coordinate formula.
  A well-chosen coordinate system can simplify constraints, symmetries, and the kinetic energy simultaneously.
]

=== Generalized Coordinates and the Action

Let the configuration of a system be described by a curve

$
  q(t) = (q_(1)(t), dots, q_(n)(t)).
$

The action functional is then

$
  S[q] = integral_(t_0)^(t_1) L(t, q_1, dots, q_n, dot(q)_1, dots, dot(q)_n) dif t.
$

This is the object whose stationarity is prescribed by Hamilton's principle.

=== Example: Free Particle and Particle in a Potential

#example[
  For a free particle of mass $m$ in Euclidean space,

  $
    L = frac(1,2) m dot(r)^2.
  $

  If the particle moves under a potential $V(r)$, then

  $
    L = frac(1,2) m dot(r)^2 - V(r).
  $

  The corresponding equations of motion will be derived below.
]

== Derivation from Hamilton's Principle // 从哈密顿原理推导

Hamilton's principle prescribes that the physical trajectory makes the action stationary.
The mathematical content of this prescription is already established: by the #link(<thm:euler-lagrange-system>)[Euler-Lagrange System], stationarity of

$
  S[q] = integral_(t_0)^(t_1) L(t, q_1, dots, q_n, dot(q)_1, dots, dot(q)_n) dif t
$

under endpoint-fixed variations is equivalent to

$
  frac(dif, dif t) frac(partial L, partial dot(q)_i) - frac(partial L, partial q_i) = 0, quad i = 1, dots, n.
$

No new computation is needed here.
The variational machinery of the Mathematical Foundations Part converts the axiom directly into these equations of motion.
The physical input is the choice of Lagrangian $L = T - V$ for the system at hand, justified by the #link(<prop:dalembert-hamilton>)[equivalence with D'Alembert's principle].

== Lagrange's Equations of the Second Kind // 第二类拉格朗日方程

=== Generalized Forces // 广义力

#theorem(name: "Lagrange's Equations")[
In the presence of non-potential external forces, the Lagrangian description is augmented by *generalized forces*.
For a virtual displacement $eta = (eta_1, dots, eta_n)$, the virtual work is written as

$
  delta W = sum_(i=1)^n Q_i eta_i,
$

where $Q_i$ is the generalized force corresponding to $q_i$.
If the system consists of particles with position vectors $r_a$, then the generalized force can be expressed schematically as

$
  Q_i = sum_a F_a dot frac(partial r_a, partial q_i),
$

where $F_a$ is the applied force on the $a$-th particle.
]

#note[
  Generalized forces package all nonconservative effects into the same coordinate system as the Lagrangian.
  This is especially useful for friction-like forces, driving forces, and constrained mechanical systems.
]

=== Lagrange's Equations with Constraints // 带约束的拉格朗日方程

When the coordinates are constrained by relations

$
  f_(alpha)(q_1, dots, q_n, t) = 0, quad alpha = 1, dots, m,
$

the configuration space is reduced to an admissible submanifold of the full coordinate space.
If the constraints are holonomic, one can either solve them explicitly or introduce multipliers.

#theorem(name: "Constrained Lagrange Equations")[
  For holonomic constraints $f_(alpha)(q, t)=0$, the equations of motion can be written in the multiplier form

  $
    frac(dif, dif t) frac(partial L, partial dot(q)_i) - frac(partial L, partial q_i) = sum_(alpha=1)^m lambda_alpha frac(partial f_alpha, partial q_i),
  $

  together with the constraint equations

  $
    f_(alpha)(q, t) = 0, quad alpha = 1, dots, m.
  $
]

The multipliers $lambda_alpha$ encode the constraint reaction forces.
They eliminate the need to solve the constraints explicitly before writing the equations of motion.

=== Lagrange Multipliers in Mechanics // 力学中的拉格朗日乘子

#example[
  Consider a particle constrained to move on a circle of radius $a$ in the plane.
  With Cartesian coordinates $(x,y)$ and constraint

  $
    x^2 + y^2 - a^2 = 0,
  $

  the multiplier formulation gives

  $
    m frac(dif^2 x, dif t^2) = lambda x, quad m frac(dif^2 y, dif t^2) = lambda y.
  $

  The multiplier $lambda$ is determined together with the constraint, and it represents the radial reaction force that keeps the particle on the circle.
]

=== Chapter Summary

The logic of this chapter is now complete:

1. Hamilton's principle gives the variational starting point.
2. The action is written in terms of a Lagrangian on generalized coordinates.
3. The stationarity condition yields the Euler-Lagrange equations.
4. Generalized forces and constraints extend the formalism to realistic mechanical systems.

This prepares the way for conservation laws in the next chapter.

  $
    frac(dif, dif t) frac(partial L, partial dot(q)_i) - frac(partial L, partial q_i) = 0,
  $

  for $i = 1, dots, n$.


These are the *Lagrange equations of the second kind*.
They are equivalent to Newton's equations, but they are often much easier to use in curvilinear coordinates or under constraints.

#note[
  The second-kind equations are coordinate-invariant in the sense that they retain their form under a change of generalized coordinates.
  This is one of the main reasons they are preferred in analytical mechanics.
]

=== One-Dimensional Check

If $L(q, dot(q)) = frac(1,2) m dot(q)^2 - V(q)$, then

$
  frac(partial L, partial dot(q)) = m dot(q), quad frac(partial L, partial q) = -frac(dif V, dif q).
$

Hence the Euler-Lagrange equation becomes

$
  m frac(dif^2 q, dif t^2) + frac(dif V, dif q) = 0,
$

which is exactly Newton's law in one dimension.
This is the physical callback to the mathematical verification in *Particle in a potential field*: the same computation now reads as the recovery of Newtonian mechanics from the variational axiom.

// Chapter 10: Conservation Laws in Lagrangian Mechanics (拉格朗日力学中的守恒律)
//   Section 10.1: Cyclic Coordinates and Generalized Momenta (循环坐标与广义动量) [← deepens Ch. 6.2 first integrals]
//   Section 10.2: Energy Conservation (能量守恒) [← Time symmetry → Retrospective to Part I Ch. 3.3; deepens Ch. 6.2 Beltrami]
//   Section 10.3: Noether's Theorem (诺特定理)
//   Section 10.4: Momentum Conservation and Translational Symmetry (动量守恒与平移对称性) [← Retrospective to Part I Ch. 3.1]
//   Section 10.5: Angular Momentum Conservation and Rotational Symmetry (角动量守恒与旋转对称性) [← Retrospective to Part I Ch. 3.2]

= Conservation Laws in Lagrangian Mechanics // 拉格朗日力学中的守恒律

Conservation laws are the symmetry side of the Lagrangian formalism.
Once the equations of motion have been derived, one can often read off conserved quantities directly from the structure of the Lagrangian.

#note(title: "From first integrals to conservation laws")[
  The cyclic-coordinate and Beltrami first integrals were established mathematically in *First Integrals and Cyclic Coordinates*.
  This chapter reinterprets them physically as conservation laws and traces their origin to symmetry via Noether's theorem — the retrospective deepening of those mathematical facts.
]

== Cyclic Coordinates and Generalized Momenta // 循环坐标与广义动量

If a generalized coordinate does not appear explicitly in the Lagrangian, it is called a *cyclic coordinate* or *ignorable coordinate*.

#definition(name: "Generalized Momentum")[
  For each generalized coordinate $q_i$, the corresponding generalized momentum is

  $
    p_i = frac(partial L, partial dot(q)_i).
  $
]

#proposition(name: "Cyclic Coordinate and Conservation")[
  If $frac(partial L, partial q_k) = 0$, then the Euler-Lagrange equation gives

  $
    frac(dif, dif t) p_k = 0,
  $

  so the conjugate momentum $p_k$ is conserved.
]

This is the simplest and most useful conservation mechanism in Lagrangian mechanics.
Many symmetries become conservation laws precisely because some coordinate is absent from the Lagrangian.

=== Example: Translational Symmetry

#example[
  If a system is invariant under translation in the coordinate $x$, then the Lagrangian does not depend on $x$ explicitly.
  Consequently the momentum

  $
    p_x = frac(partial L, partial dot(x))
  $

  is conserved.

  In ordinary mechanics this is the familiar conservation of linear momentum.
]

== Energy Conservation // 能量守恒

The energy integral is another fundamental conserved quantity.
It is associated with time-translation invariance of the Lagrangian.

#definition(name: "Energy Function")[
  For a Lagrangian $L(t, q_1, dots, q_n, dot(q)_1, dots, dot(q)_n)$, define the energy function

  $
    E = sum_(i=1)^n dot(q)_i frac(partial L, partial dot(q)_i) - L.
  $
]

#theorem(name: "Energy Conservation")[
  If the Lagrangian has no explicit time dependence, that is, $frac(partial L, partial t) = 0$, then the energy function is conserved:

  $
    frac(dif E, dif t) = 0.
  $
]

The proof is a direct calculation using the Euler-Lagrange equations.
Differentiating $E$ with respect to time and substituting the equations of motion shows that all terms cancel except $-frac(partial L, partial t)$.

#note[
  In many mechanical systems, the energy function coincides with the total mechanical energy $T+V$.
  This is true whenever the Lagrangian has the standard form $L=T-V$ with $T$ quadratic in velocities and $V$ independent of velocities.
]

=== Example: Conservative Particle System

#example[
  For

  $
    L = frac(1,2) m dot(q)^2 - V(q),
  $

  the energy is

  $
    E = frac(1,2) m dot(q)^2 + V(q),
  $

  which is the usual total energy.
]

== Noether's Theorem // 诺特定理

The most systematic way to understand conservation laws is through symmetries.
Noether's theorem states that continuous symmetries of the action produce conserved quantities.

#theorem(name: "Noether's Theorem (Mechanical Form)")[
  If the action is invariant under a one-parameter family of continuous transformations of the generalized coordinates and time, then there exists a conserved quantity along every solution of the Euler-Lagrange equations.
]

In practical mechanics, the important cases are:

- time translation, giving energy conservation;
- spatial translation, giving linear momentum conservation;
- rotational symmetry, giving angular momentum conservation.

#note[
  In a full field-theoretic treatment, Noether's theorem becomes even more powerful.
  Here we use only the finite-dimensional mechanical version.
]

== Momentum Conservation and Translational Symmetry // 动量守恒与平移对称性

For a system invariant under translations in space, the corresponding generalized momentum is conserved.
In Cartesian coordinates, this is the familiar conservation of linear momentum.

#proposition(name: "Linear Momentum Conservation")[
  If the Lagrangian is invariant under a spatial translation generated by a coordinate shift $x -> x + epsilon$, then the conjugate momentum to that coordinate is conserved.
]

For a system of particles with total Lagrangian depending only on relative positions, the center-of-mass motion decouples from the internal motion.
This explains why translation invariance often leads to a simple first integral for the center of mass.

=== Example: Center-of-Mass Motion

#example[
  Let a closed system of particles be described by a translation-invariant Lagrangian.
  Then the total momentum

  $
    P = sum_a m_a dot(r)_a
  $

  is conserved.
  Consequently the center of mass moves with constant velocity.
]

== Angular Momentum Conservation and Rotational Symmetry // 角动量守恒与旋转对称性

Rotational symmetry produces angular momentum conservation.
If the Lagrangian is invariant under infinitesimal rotations, then the associated Noether quantity is the angular momentum.

#definition(name: "Angular Momentum")[
  For a particle with position vector $r$ and momentum $p$, the angular momentum is

  $
    J = r times p.
  $

  For a system of particles, one sums over all particles.
]

#proposition(name: "Angular Momentum Conservation")[
  If the Lagrangian is invariant under rotations, then the total angular momentum is conserved.
]

The key hypothesis is rotational invariance of the Lagrangian, typically meaning that $L$ depends only on rotationally invariant combinations such as distances and scalar products.

=== Example: Central Force Motion

#example[
  For a particle moving under a central potential $V(r)$,

  $
    L = frac(1,2) m dot(r)^2 - V(|r|),
  $

  the Lagrangian is rotationally invariant.
  Therefore the angular momentum vector is conserved, and the motion takes place in a fixed plane.
]

=== Example: Rigid Body Symmetry

#example[
  In rigid body dynamics, rotational symmetry leads to conservation laws for angular momentum components in appropriate frames.
  This is one of the reasons the Lagrangian formulation is so effective for systems with symmetry.
]

=== Chapter Summary

This chapter shows how symmetries of the Lagrangian produce conserved quantities:

1. Cyclic coordinates produce conserved conjugate momenta.
2. Time translation invariance produces energy conservation.
3. Noether's theorem packages these results into one symmetry principle.
4. Spatial translations and rotations yield momentum and angular momentum conservation.

These conservation laws will be used repeatedly in the applications chapter.

// Chapter 11: Applications of Lagrangian Mechanics (拉格朗日力学的应用)
//   Section 11.1: Rigid Body Dynamics (刚体动力学) [← Recovers Part I Ch. 2.2 via Lagrangian]
//   Section 11.2: Central Force Motion (中心力运动) [← Connects to Part I Ch. 4]
//   Section 11.3: Small Oscillations (小振动) [← Generalizes Optique Part I Ch. 1]
//   Section 11.4: Normal Modes and Eigenfrequencies (简正模与本征频率)
//   Section 11.5: Coupled Oscillators (耦合振子)
= Applications of Lagrangian Mechanics // 拉格朗日力学的应用

This chapter demonstrates the power of the Lagrangian formalism by applying it to three classic problems: rigid body dynamics, central force motion, and small oscillations. In each case, the Lagrangian approach reproduces the results of Part I with greater elegance and generality, while also extending them to situations that would be cumbersome to handle with Newtonian methods.

== Rigid Body Dynamics via Lagrangian // 刚体动力学的拉格朗日方法

The Lagrangian formalism provides a natural framework for rigid body dynamics. By choosing appropriate generalized coordinates (e.g., Euler angles), the kinetic and potential energies are expressed directly, and Lagrange's equations yield the equations of motion without the need to analyse constraint forces.

=== Kinetic Energy of a Rigid Body // 刚体的动能

For a rigid body rotating about a fixed axis with moment of inertia $I$ and angular velocity $omega = dot(theta)$:

$
  T = frac(1,2) I omega^2.
$

The Lagrangian is $L = T - V$, and Lagrange's equation $frac(dif, dif t) frac(partial L, partial dot(theta)) - frac(partial L, partial theta) = 0$ gives:

$
  I dot.double(theta) + frac(partial V, partial theta) = 0,
$

which is precisely the rotational second law $I alpha = tau$ from Part I Ch 2, where $tau = - partial V / partial theta$ is the torque derived from potential.

#example(name: "Physical Pendulum Revisited")[ // 物理摆的拉格朗日分析
  A rigid body pivoted at a distance $d$ from its CM. Using $theta$ as the generalized coordinate:
  $
    T = frac(1,2) I dot(theta)^2, quad V = M g d (1 - cos theta),
  $
  $
    L = frac(1,2) I dot(theta)^2 - M g d (1 - cos theta).
  $

  Lagrange's equation yields $I dot.double(theta) + M g d sin theta = 0$, recovering the physical pendulum result from Part I Ch 2.
]

== Central Force Motion // 中心力运动

The two-body central force problem (Part I Ch 4) finds a particularly elegant solution in the Lagrangian framework.

=== Lagrangian in Plane Polar Coordinates // 平面极坐标下的拉格朗日量

For a reduced mass $mu$ moving in a central potential $V(r)$, we use plane polar coordinates $(r, theta)$:

$
  L = frac(1,2) mu (dot(r)^2 + r^2 dot(theta)^2) - V(r).
$

Note that $theta$ is a *cyclic coordinate*: $partial L / partial theta = 0$, so the conjugate momentum is conserved:

$
  p_theta = frac(partial L, partial dot(theta)) = mu r^2 dot(theta) = L_z = text("constant").
$

This is the conservation of angular momentum, directly recovered from the cyclic coordinate without invoking torques.

=== Radial Equation and Effective Potential // 径向方程与有效势

The $r$-equation follows from the Euler-Lagrange equation for $r$:

$
  mu dot.double(r) - mu r dot(theta)^2 + frac(dif V, dif r) = 0.
$

Using $dot(theta) = L_z / (mu r^2)$ to eliminate $dot(theta)$:

$
  mu dot.double(r) = - frac(dif V_("eff"), dif r), quad
  V_("eff")(r) = V(r) + frac(L_z^2, 2 mu r^2).
$

#note[
  The centrifugal term $L_z^2 / (2 mu r^2)$ arises naturally from the kinetic energy in polar coordinates — no physical force is involved. This effective potential analysis was anticipated in Part I Ch 4 (orbit classification) and will be used to derive Kepler's laws from the Lagrangian in the exercises.
]

== Small Oscillations // 小振动

The small oscillation problem — one of the most important applications of Lagrangian mechanics — generalises the simple harmonic oscillator of Optique Part I to multiple degrees of freedom.

=== One Degree of Freedom // 单自由度

Near a stable equilibrium $q_0$, the Lagrangian can be expanded to second order:

$
  L approx frac(1,2) m dot(q)^2 - frac(1,2) k (q - q_0)^2,
$

where $k = V''(q_0)$. Lagrange's equation gives $m dot.double(q) + k (q - q_0) = 0$, i.e., SHM with $omega_0 = sqrt(k / m)$. This recovers the simple harmonic oscillator from Optique Part I Ch 1.

=== Multiple Degrees of Freedom // 多自由度

#theorem(name: "Small Oscillations — General Formulation")[
  For a system of $n$ degrees of freedom near stable equilibrium, the Lagrangian is:
  $
    L = frac(1,2) sum_(i,j) M_(i j) dot(q)_i dot(q)_j - frac(1,2) sum_(i,j) K_(i j) q_i q_j,
  $
  where $M_(i j)$ is the mass (inertia) matrix and $K_(i j)$ is the stiffness matrix. The equations of motion are:
  $
    sum_j M_(i j) dot.double(q)_j + sum_j K_(i j) q_j = 0, quad i = 1, dots, n.
  $
]

== Normal Modes and Eigenfrequencies // 简正模与本征频率

The coupled equations from the previous section can be decoupled by solving an eigenvalue problem.

#theorem(name: "Normal Mode Analysis")[
  Assume a solution $q_(j)(t) = A_j e^(i omega t)$. Substituting into the equations of motion gives the generalised eigenvalue problem:
  $
    sum_j (K_(i j) - omega^2 M_(i j)) A_j = 0.
  $
  The eigenfrequencies $omega_alpha$ satisfy $det(K - omega^2 M) = 0$, and the eigenvectors define the *normal mode coordinates* $Q_alpha$ in which the system decouples into independent harmonic oscillators:
  $
    L = frac(1,2) sum_(alpha=1)^n (dot(Q)_alpha^2 - omega_alpha^2 Q_alpha^2).
  $
]

#example(name: "Two Coupled Masses")[ // 两耦合振子
  Two identical masses $m$ connected by three springs of stiffness $k$ between fixed walls. The Lagrangian is:
  $
    L = frac(1,2) m (dot(x)_1^2 + dot(x)_2^2) - frac(1,2) k (x_1^2 + (x_2 - x_1)^2 + x_2^2).
  $

  The mass and stiffness matrices are:
  $
    M = mat(m, 0; 0, m), quad
    K = mat(2k, -k; -k, 2k).
  $

  Solving $det(K - omega^2 M) = 0$ gives:
  $
    omega_1^2 = frac(k, m) quad (text("in-phase mode")), quad
    omega_2^2 = frac(3k, m) quad (text("out-of-phase mode")).
  $

  The normal coordinates are $Q_1 = (x_1 + x_2) / sqrt(2)$ and $Q_2 = (x_1 - x_2) / sqrt(2)$.
]

== Coupled Oscillators // 耦合振子

The normal mode analysis extends naturally to systems with $N$ coupled oscillators, forming the foundation for understanding waves in discrete and continuous media.

#note[
  *Connection to earlier and later topics:*
  - The two-mass system above is the simplest nontrivial example of mode splitting. With $N$ coupled masses, one obtains $N$ normal modes whose frequencies approach a continuous spectrum as $N -> infinity$ — the transition from discrete oscillators to a continuous wave (Optique, standing waves on a string).
  - The eigenvalue problem $det(K - omega^2 M) = 0$ reappears in quantum mechanics (vibrational spectra of molecules) and in structural engineering (modal analysis of buildings and bridges).
  - In the limit of $N -> infinity$, the normal mode frequencies form a dispersion relation $omega(k)$, connecting to the wave propagation discussed in Optique.
]

// =========================================================================
// --- Part IV: Hamiltonian Mechanics (哈密顿力学) ---
// =========================================================================
#part("Hamiltonian Mechanics") // 哈密顿力学

// Chapter 12: Hamilton's Equations (哈密顿方程)
//   Section 12.1: Legendre Transformation (勒让德变换)
//   Section 12.2: Hamiltonian Function (哈密顿函数)
//   Section 12.3: Canonical Equations of Motion (正则运动方程)
//   Section 12.4: Hamiltonian for Common Systems (常见系统的哈密顿量)
//   Section 12.5: Phase Space and Phase Portraits (相空间与相图)

// Chapter 13: Canonical Transformations (正则变换)
//   Section 13.1: Generating Functions (生成函数)
//   Section 13.2: Types of Generating Functions (生成函数的类型)
//   Section 13.3: Conditions for Canonical Transformations (正则变换的条件)
//   Section 13.4: Poisson Brackets (泊松括号)
//   Section 13.5: Invariants under Canonical Transformations (正则变换下的不变量)
//   Section 13.6: Symplectic Structure (辛结构)

// Chapter 14: Hamilton-Jacobi Theory (哈密顿-雅可比理论)
//   Section 14.1: Hamilton-Jacobi Equation (哈密顿-雅可比方程)
//   Section 14.2: Separation of Variables (分离变量法)
//   Section 14.3: Action-Angle Variables (作用量-角变量)
//   Section 14.4: Complete Integrals and Characteristics (完全积分与特征线)
//   Section 14.5: Applications to Central Force Problems (在中心力问题中的应用)

// =========================================================================
// --- Part V: Advanced Topics (进阶主题) ---
// =========================================================================
#part("Advanced Topics") // 进阶主题

// Chapter 15: Liouville's Theorem and Statistical Mechanics (刘维尔定理与统计力学)
//   Section 15.1: Liouville's Theorem (刘维尔定理)
//   Section 15.2: Phase Space Volume Conservation (相空间体积守恒)
//   Section 15.3: Ergodicity and Mixing (遍历性与混合)
//   Section 15.4: Poincaré Recurrence Theorem (庞加莱回归定理)

// Chapter 16: Perturbation Theory (微扰理论)
//   Section 16.1: Time-independent Perturbation Theory (不含时微扰理论)
//   Section 16.2: Time-dependent Perturbation Theory (含时微扰理论)
//   Section 16.3: Adiabatic Invariants (绝热不变量)
//   Section 16.4: Canonical Perturbation Theory (正则微扰理论)

// Chapter 17: Integrable Systems (可积系统)
//   Section 17.1: Complete Integrability (完全可积性)
//   Section 17.2: Lax Pairs (Lax对)
//   Section 17.3: Inverse Scattering Method (逆散射方法)
//   Section 17.4: Examples of Integrable Systems (可积系统示例)

// Chapter 18: Stability and Chaos (稳定性与混沌)
//   Section 18.1: Linear Stability Analysis (线性稳定性分析)
//   Section 18.2: Lyapunov Exponents (李雅普诺夫指数)
//   Section 18.3: Poincaré Sections (庞加莱截面)
//   Section 18.4: Bifurcations (分岔)
//   Section 18.5: Routes to Chaos (通向混沌的道路)



// =========================================================================
// --- Part VI: Relativistic and Field Extensions (相对论与场的推广) ---
// =========================================================================
#part("Relativistic and Field Extensions") // 相对论与场的推广

// Chapter 19: Relativistic Mechanics (相对论力学)
//   Section 19.1: Relativistic Lagrangian (相对论拉格朗日量)
//   Section 19.2: Relativistic Hamiltonian (相对论哈密顿量)
//   Section 19.3: Electromagnetic Interactions (电磁相互作用)
//   Section 19.4: Covariant Formulation (协变形式)

// Chapter 20: Classical Field Theory (经典场论)
//   Section 20.1: Lagrangian Density (拉格朗日密度)
//   Section 20.2: Field Equations from Variational Principle (从变分原理推导场方程)
//   Section 20.3: Noether's Theorem for Fields (场的诺特定理)
//   Section 20.4: Stress-Energy Tensor (应力-能量张量)
//   Section 20.5: Examples: Scalar and Electromagnetic Fields (示例：标量场与电磁场)

// ==========================================================================
// References (参考文献)
// ==========================================================================
#bibliography("references.bib", title: "References", full: true)
