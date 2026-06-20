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

// --- Part 0: Classical Mechanics Foundations (经典力学基础) ---
#part("Classical Mechanics Foundations") // 经典力学基础

// Chapter 1: Kinematics of Particles and Particle Systems (质点与质点系)
//   Section 1.1: Kinematic Attributes of PointParticles (质点的运动学属性)
//   Section 1.2: Rigid Body Kinematics: Translation and Rotation (刚体平动与转动)
//   Section 1.3: Correspondence between Linear and Angular Quantities (线量与角量的对应)
= Kinematics of Particles and Particle Systems // 质点与质点系
== Kinematic Attributes of PointParticles // 质点的运动学属性

Kinematics describes motion without asking what causes it.
For a pointparticle, the basic data are position, velocity, and acceleration as functions of time.

#definition(name: "PointParticle and Trajectory")[
  A pointparticle is modeled by its position vector

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

For central-force problems (e.g., planetary motion, Chapter 5), spherical coordinates $(r, theta, phi)$ are the most convenient. Here $r$ is the radial distance, $theta$ the polar angle from the $z$-axis, and $phi$ the azimuthal angle.

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

Real mechanical systems rarely consist of a single pointparticle. Multiple particles introduce new kinematic concepts — the centre of mass, relative coordinates, and degrees of freedom — that are essential for the later analysis of rigid bodies, celestial systems, and continua.

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
  The CM decomposition is more than a kinematic convenience: it decouples the overall motion from the internal motion. This decoupling is the foundation of the two-body reduction in celestial mechanics (Chapter 5) and of rigid-body dynamics (next section), where the internal constraints determine the rotational degrees of freedom.
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

If every pointof the body has the same velocity, the motion is a pure translation.
In that case, the velocity and acceleration of any pointcoincide with those of a chosen reference point.

#proposition(name: "Pure Translation")[
  Suppose the position of every point$P$ of the body can be written as

  $
    bold(r)_P(t) = bold(R)(t) + bold(r)_P^0,
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
  bold(r)_P(t) = bold(R)(t) + cal(R)(t) bold(r)_P^0,
$

where $cal(R)(t)$ is a rotation operator.

#note[
  This decomposition is the kinematic backbone of rigid-body dynamics.
  Later, Lagrangian methods will convert it into equations of motion and conservation laws.
]

== Correspondence between Linear and Angular Quantities // 线量与角量的对应

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

Chapter 1 established the *kinematic* language of motion: position, velocity, acceleration, and their angular counterparts. This chapter supplies the *dynamics* — the laws that relate motion to its causes. We first review Newton's three laws in their familiar translational form, then develop the parallel rotational laws for rigid bodies. The structural analogy between translation and rotation, already visible in the kinematics of §1.3, becomes deeper here: force ↔ torque, mass ↔ moment of inertia, and linear acceleration ↔ angular acceleration.

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
  Conservation of momentum is a consequence of *translational symmetry* of space (Noether's theorem, to be studied in Part II). If the laws of physics are the same at every pointin space, momentum must be conserved.
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
  The translational-rotational isomorphism is not just a pedagogical convenience. It reflects a deep fact about the structure of classical mechanics: both sets of equations arise from the same underlying variational principle (Hamilton's principle, Part I). When we later study Lagrangian mechanics, we will see that a single equation — the Euler-Lagrange equation — produces *both* the translational and rotational equations of motion, depending only on which generalized coordinates we choose.

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

  - For small energies, the quartic term is negligible and the motion is approximately simple harmonic (as in Chapter 4).
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

Central forces conserve angular momentum (since $bold(tau) = bold(r) times bold(F) = bold(0)$), and the motion is confined to a plane. These properties will be used extensively in Chapter 5 (Celestial Mechanics) and again in Part II (Lagrangian mechanics, central force applications).

#note[
  This chapter has established the three pillars of conservation — momentum, angular momentum, and energy — each linked to a fundamental symmetry of space and time. These conservation laws are not just convenient shortcuts; they are deeper than the equations of motion themselves. In Part II, Noether's theorem will reveal the direct connection: every continuous symmetry of the action implies a conserved quantity.
]

// Chapter 4: Oscillations and Waves (振动与波动)
//   Section 4.1: Simple Harmonic Motion (简谐运动)
//   Section 4.2: Damped and Driven Oscillations (阻尼与受驱振动)
//   Section 4.3: Wave Propagation (波动传播)
= Oscillations and Waves // 振动与波动

Oscillatory motion is ubiquitous in physics — from a swinging pendulum to vibrating molecules and electromagnetic waves. This chapter develops the fundamental concepts of simple harmonic motion, damped and driven oscillations, and wave propagation. These ideas will be revisited in Part II, where Lagrangian methods provide a systematic approach to small oscillations and normal modes.

== Simple Harmonic Motion // 简谐运动

=== Equation of Motion // 运动方程

The simplest oscillatory system is a mass $m$ attached to a spring of stiffness $k$. When displaced from equilibrium, Hooke's law gives $F = - k x$, and Newton's second law yields:

$
  m dot.double(x) + k x = 0.
$

This is the equation of *simple harmonic motion* (SHM). Dividing by $m$ and defining the *angular frequency* $omega_0 = sqrt(k / m)$:

#definition(name: "Simple Harmonic Motion")[
  The equation of SHM and its general solution:
  $
    dot.double(x) + omega_0^2 x = 0, quad x(t) = A cos(omega_0 t + phi),
  $
  where $A$ is the amplitude and $phi$ is the initial phase. The period and frequency are:
  $
    T = frac(2 pi, omega_0) = 2 pi sqrt(frac(m, k)), quad f = frac(1, T) = frac(omega_0, 2 pi).
  $
]

=== Energy of the Simple Harmonic Oscillator // 简谐振子的能量

The total mechanical energy is conserved and oscillates between kinetic and potential forms:

$
  E = frac(1,2) m dot(x)^2 + frac(1,2) k x^2 = frac(1,2) k A^2.
$

#example(name: "Mass-Spring System")[ // 弹簧振子
  A mass $m = 0.5 "kg"$ on a spring of stiffness $k = 32 "N/m"$ is pulled $A = 0.1 "m"$ from equilibrium and released.

  Angular frequency: $omega_0 = sqrt(k / m) = sqrt(32 / 0.5) = 8 "rad/s"$.
  Period: $T = 2 pi / omega_0 = pi / 4 approx 0.785 "s"$.
  Maximum speed: $v_"max" = omega_0 A = 0.8 "m/s"$.
  Total energy: $E = frac(1,2) k A^2 = frac(1,2) times 32 times 0.1^2 = 0.16 "J"$.
]

=== The Simple Pendulum // 单摆

The simple pendulum (mass $m$, length $L$) obeys $dot.double(theta) + (g / L) sin theta = 0$. For small angles, $sin theta approx theta$, giving SHM:

$
  dot.double(theta) + omega_0^2 theta = 0, quad omega_0 = sqrt(frac(g, L)).
$

#note[
  The small-angle approximation $sin theta approx theta$ is the first term of the Taylor expansion. For larger amplitudes, corrections appear: the period becomes $T = 2 pi sqrt(L/g) (1 + theta_0^2 / 16 + ...)$, as derived from the energy integral in Chapter 3.
]

=== Relation to the Physical Pendulum // 与物理摆的联系

The physical pendulum (Chapter 2) has $omega_0 = sqrt(M g d / I)$. For a simple pendulum, $I = M L^2$ and $d = L$, recovering $omega_0 = sqrt(g / L)$. The SHM framework thus unifies all systems with a linear restoring torque.

== Damped and Driven Oscillations // 阻尼与受驱振动

=== Damped Harmonic Oscillator // 阻尼振子

Real oscillators experience energy loss due to friction or drag. For a velocity-dependent damping force $F_d = - b dot(x)$, the equation of motion becomes:

$
  m dot.double(x) + b dot(x) + k x = 0.
$

Dividing by $m$ and defining $beta = b / (2m)$ (damping coefficient) and $omega_0 = sqrt(k / m)$:

$
  dot.double(x) + 2 beta dot(x) + omega_0^2 x = 0.
$

The characteristic equation $r^2 + 2 beta r + omega_0^2 = 0$ has roots $r = - beta plus.minus sqrt(beta^2 - omega_0^2)$.

#definition(name: "Damping Regimes")[
  - *Underdamped* ($beta < omega_0$): $x(t) = e^(-beta t) [A cos(omega_1 t) + B sin(omega_1 t)]$, where $omega_1 = sqrt(omega_0^2 - beta^2)$. The amplitude decays exponentially with time constant $1 / beta$.
  - *Critically damped* ($beta = omega_0$): $x(t) = (A + B t) e^(-omega_0 t)$. The system returns to equilibrium fastest without oscillating.
  - *Overdamped* ($beta > omega_0$): $x(t) = A e^(-r_1 t) + B e^(-r_2 t)$, with $r_1, r_2 > 0$. The system returns slowly without oscillating.
]

=== Driven Oscillator and Resonance // 受驱振子与共振

When an external driving force $F(t) = F_0 cos(omega t)$ is applied:

$
  dot.double(x) + 2 beta dot(x) + omega_0^2 x = frac(F_0, m) cos(omega t).
$

The steady-state solution is $x(t) = A(omega) cos(omega t - delta)$, with:

$
  A(omega) = frac(F_0 / m, sqrt((omega_0^2 - omega^2)^2 + (2 beta omega)^2)), quad
  tan delta = frac(2 beta omega, omega_0^2 - omega^2).
$

#theorem(name: "Resonance")[
  The amplitude $A(omega)$ reaches a maximum at the *resonance frequency*:
  $
    omega_"res" = sqrt(omega_0^2 - 2 beta^2).
  $
  For weak damping ($beta << omega_0$), $omega_"res" approx omega_0$ and the peak amplitude is:
  $
    A_"max" approx frac(F_0, 2 m beta omega_0).
  $
  The width of the resonance curve (full width at half maximum) is $Delta omega approx 2 beta$, giving a quality factor $Q = omega_0 / (2 beta)$.
]

#note[
  Resonance is a crucial phenomenon across physics: it explains why a small force at the right frequency can produce large oscillations (e.g., pushing a child on a swing, tuning a radio receiver, or the Tacoma Narrows Bridge collapse).
]

== Wave Propagation // 波动传播

=== The Wave Equation // 波动方程

While oscillators describe the motion of individual particles, *waves* describe the propagation of disturbances through a continuous medium. The simplest is the one-dimensional wave equation:

#definition(name: "One-Dimensional Wave Equation")[
  The displacement $u(x, t)$ of a wave travelling along the $x$-axis satisfies:
  $
    frac(partial^2 u, partial t^2) = v^2 frac(partial^2 u, partial x^2),
  $
  where $v$ is the wave speed. For a wave on a string of tension $T$ and linear density $mu$:
  $
    v = sqrt(frac(T, mu)).
  $
]

=== Travelling Waves // 行波

#definition(name: "Travelling Wave Solution")[
  The wave equation admits travelling wave solutions of the form:
  $
    u(x, t) = f(x - v t) + g(x + v t),
  $
  where $f$ describes a wave travelling to the right and $g$ to the left. A *harmonic* travelling wave is:
  $
    u(x, t) = A cos(k x - omega t + phi),
  $
  where $k = 2 pi / lambda$ is the wavenumber, $lambda$ the wavelength, and $omega = v k$ the angular frequency.
]

=== Standing Waves // 驻波

When two identical waves travel in opposite directions, they interfere to form a *standing wave*:

$
  u(x, t) = 2 A cos(k x) cos(omega t).
$

The points where $cos(k x) = 0$ (nodes) are stationary; the points where $|cos(k x)| = 1$ (antinodes) oscillate with maximum amplitude.

#example(name: "Standing Waves on a String Fixed at Both Ends")[ // 两端固定弦的驻波
  For a string of length $L$ fixed at $x = 0$ and $x = L$, the boundary conditions $u(0, t) = u(L, t) = 0$ require $k L = n pi$, $n = 1, 2, 3, ...$.

  The *normal modes* are:
  $
    u_n(x, t) = A_n sin(frac(n pi x, L)) cos(omega_n t), quad omega_n = n omega_1, quad omega_1 = frac(pi v, L).
  $

  The fundamental frequency is $f_1 = omega_1 / (2 pi) = v / (2 L)$, and the higher harmonics are integer multiples: $f_n = n f_1$.
]

=== Superposition Principle // 叠加原理

#property(name: "Superposition for Waves")[
  The wave equation is *linear*: if $u_1$ and $u_2$ are solutions, then $u_1 + u_2$ is also a solution. This allows complex wave patterns to be built from simple harmonic components (Fourier analysis).
]

#note[
  *Connection to later topics:*
  - The normal modes of a string are the first example of a discrete eigenvalue problem. In Part II (Lagrangian mechanics, Ch6), we will generalise this to coupled oscillators and normal mode analysis using matrix methods.
  - The wave equation generalises to two and three dimensions in fluid mechanics and electromagnetism. The same mathematics — separation of variables, boundary conditions, eigenfrequencies — reappears in quantum mechanics and electrodynamics.
]

// Chapter 5: Celestial Mechanics Foundations (天体力学基础)
//   Section 5.1: Kepler's Laws (开普勒定律)
//   Section 5.2: Orbit Classification (轨道分类)
//   Section 5.3: Two-Body Problem and Reduced Mass (二体问题与约化质量)
= Celestial Mechanics Foundations // 天体力学基础

Celestial mechanics studies the motion of astronomical bodies under gravitational forces. This brief chapter establishes the essential results — Kepler's laws, orbit classification, and the two-body reduction — that will be revisited in Part II from the Lagrangian perspective.

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
  The energy-orbit connection is profound: a bound system ($E < 0$) always follows a closed or quasi-periodic orbit, while an unbound system ($E >= 0$) escapes to infinity. This classification reappears in the effective potential analysis of central forces in Part II.
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
  The two-body reduction is the foundation of celestial mechanics. In Part II (Lagrangian mechanics), we will derive the same result from a Lagrangian with translational symmetry, and the conserved quantities (energy, angular momentum) will emerge directly from Noether's theorem.
]

// Chapter 6: Fluid Mechanics Foundations (流体力学基础)
//   Section 6.1: Continuum Hypothesis and Density Fields (连续体假设与密度场)
//   Section 6.2: Euler's Equations of Motion (欧拉运动方程)
//   Section 6.3: Bernoulli's Equation (伯努利方程)
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
  Euler's equation is the fluid analogue of Newton's second law. In Part V (Classical Field Theory), we will see how it emerges from a variational principle applied to a continuous medium.
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
// --- Part I: Mathematical Foundations (数学基础) ---
// =========================================================================
#part("Mathematical Foundations") // 数学基础

// Chapter 1: Variational Calculus (数学准备：变分法)
//   Section 1.1: Functionals and Variations (泛函与变分)
//   Section 1.2: Derivation of Euler-Lagrange Equations (欧拉-拉格朗日方程的推导)
//   Section 1.3: Variational Problems with Constraints (带约束的变分问题)
= Variational Calculus  // 变分法
== Hamilton's Principle // 哈密顿原理

In this notebook, we take Hamilton's principle as the foundational axiom-like starting pointof analytical mechanics.

Before stating the principle, we fix the basic objects:

- A configuration curve $q: [t_0, t_1] -> Q$ in configuration space $Q$.
- A Lagrangian $L(t, q, dot(q))$.
- An action functional

$
  S[q] = integral_(t_0)^(t_1) L(t, q, dot(q)) dif t.
$

Here, a *functional* means a map from a function space to real numbers, e.g. $S: cal(A) -> bb(R)$ on an admissible curve class $cal(A)$.

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
]

Equivalently, with a variation family

$
  q_epsilon(t) = q(t) + epsilon eta(t), quad eta(t_0)=eta(t_1)=0,
$

the first-order term in $S[q_epsilon] - S[q]$ vanishes at $epsilon = 0$.

#note[
  In rigorous mathematical language, this is a *stationary* principle, not necessarily a strict minimum principle.
  The phrase "least action" is historical; "stationary action" is usually the precise formulation.
]

== Variational Method and First Variation // 变分法与第一变分

In analytical mechanics, we optimize objects whose input is a whole function (or path), not a finite-dimensional vector.
This leads naturally from ordinary calculus to variational calculus.

#note[
  The functional setup has already been introduced in the previous section.
  Here we focus only on the variational procedure and its differential consequences.
]

#definition(name: "Admissible Variation")[
  Let $q$ be an admissible curve with fixed endpoints $q(a)=q_a$, $q(b)=q_b$.
  A variation of $q$ is a family

  $
    q_epsilon(t) = q(t) + epsilon eta(t),
  $

  where $eta(a)=eta(b)=0$ and $eta$ is sufficiently smooth.
]

=== First Variation

#definition(name: "First Variation")[
  The first variation of $J$ at $q$ along $eta$ is

  $
    delta J[q; eta] = lr(frac(dif, dif epsilon) J[q + epsilon eta]|)_(epsilon=0).
  $

  A curve $q$ is called *stationary* if $delta J[q; eta] = 0$ for every admissible $eta$.
]

For

$
  J[q] = integral_a^b L(t, q, dot(q)) dif t,
$

direct differentiation gives

$
  delta J[q; eta] = integral_a^b ( frac(partial L, partial q) eta + frac(partial L, partial dot(q)) dot(eta) ) dif t.
$

After integration by parts and using $eta(a)=eta(b)=0$,

$
  delta J[q; eta] = integral_a^b ( frac(partial L, partial q) - frac(dif, dif t) frac(partial L, partial dot(q)) ) eta(t) dif t.
$

#theorem(name: "Stationarity Criterion")[
  If $q$ is stationary for all endpoint-fixed variations, then

  $
    frac(partial L, partial q) - frac(dif, dif t) frac(partial L, partial dot(q)) = 0,
  $

  which is the Euler-Lagrange equation.
]

=== Simple Example: Shortest Curve in the Plane

#example[
  Consider

  $
    J[y] = integral_(x_0)^(x_1) sqrt(1 + (y')^2) dif x
  $

  with fixed endpoints $y(x_0)=y_0$, $y(x_1)=y_1$.
  Here $L(y, y') = sqrt(1 + (y')^2)$ does not depend explicitly on $y$, so

  $
    frac(dif, dif x) frac(partial L, partial y') = 0
  $

  implies $frac(partial L, partial y')$ is constant, hence $y' = C$.
  Therefore the stationary curve is a line segment.
]

This variational viewpointis the direct bridge to Hamilton's principle and the full Lagrangian formalism.

== Euler-Lagrange Equation // 欧拉-拉格朗日方程

The Euler-Lagrange equation is the local differential form of stationarity for the action functional.
It turns a global variational statement into equations of motion.

#definition(name: "Euler-Lagrange Equation (Single Coordinate)")[
  For

  $
    J[q] = integral_a^b L(t, q, dot(q)) dif t,
  $

  with fixed endpoints $q(a), q(b)$, a stationary curve satisfies

  $
    frac(partial L, partial q) - frac(dif, dif t) frac(partial L, partial dot(q)) = 0.
  $
]

=== Derivation from First Variation

Starting from

$
  delta J[q; eta] = integral_a^b ( frac(partial L, partial q) eta + frac(partial L, partial dot(q)) dot(eta) ) dif t,
$

integration by parts gives

$
  delta J[q; eta] = lr(frac(partial L, partial dot(q)) eta|)_a^b + integral_a^b ( frac(partial L, partial q) - frac(dif, dif t) frac(partial L, partial dot(q)) ) eta dif t.
$

Because endpoint-fixed variations satisfy $eta(a)=eta(b)=0$, the boundary term vanishes.
By the fundamental lemma of variational calculus, the integrand must be zero, yielding the Euler-Lagrange equation.

=== Multi-Coordinate Form

#theorem(name: "Euler-Lagrange System")[
  For generalized coordinates $q_1, dots, q_n$ and

  $
    S[q] = integral_(t_0)^(t_1) L(t, q_1, dots, q_n, dot(q)_1, dots, dot(q)_n) dif t,
  $

  stationarity under endpoint-fixed variations implies, for each $i=1,dots,n$,

  $
    frac(dif, dif t) frac(partial L, partial dot(q)_i) - frac(partial L, partial q_i) = 0.
  $
]

=== Natural Boundary Conditions (Free Endpoints)

#note[
  If an endpointis free, the boundary term does not automatically vanish.
  One then obtains a natural boundary condition, typically
  $frac(partial L, partial dot(q)) = 0$ at that free endpoint(or its constrained variant).
]

=== First Integrals and Cyclic Coordinates

#proposition(name: "Cyclic Coordinate")[
  If $frac(partial L, partial q_k) = 0$, then

  $
    frac(dif, dif t) frac(partial L, partial dot(q)_k) = 0,
  $

  so the conjugate momentum
  $
    p_k = frac(partial L, partial dot(q)_k)
  $
  is conserved.
]

#proposition(name: "Energy Integral (Autonomous Case)")[
  If $L$ has no explicit $t$-dependence, then

  $
    E = sum_i dot(q)_i frac(partial L, partial dot(q)_i) - L
  $

  is constant along solutions.
]

=== Example: Particle in a Potential

#example[
  Let

  $
    L(q, dot(q)) = frac(1,2) m dot(q)^2 - V(q).
  $

  Then
  $
    frac(partial L, partial dot(q)) = m dot(q),
  $
  and
  $
    frac(partial L, partial q) = -frac(dif V, dif q).
  $

  The Euler-Lagrange equation becomes

  $
    m frac(dif^2 q, dif t^2) + frac(dif V, dif q) = 0,
  $

  i.e. Newton's equation $m dot.double(q) = -frac(dif V, dif q)$.
]

This section provides the variational core used in the next chapters on Lagrange's equations, constraints, and Hamiltonian reformulation.
// Chapter 2: Description of Mechanical Systems (力学系统的完整描述)
//   Section 2.1: Degrees of Freedom and Generalized Coordinates (自由度与广义坐标)
//   Section 2.2: Classification of Constraints (约束的分类)
//   Section 2.3: Real Displacements and Virtual Displacements (实位移与虚位移)
//   Section 2.4: D'Alembert's Principle and Virtual Work (达朗贝尔原理与虚功原理) [← Retrospective to Part 0 Ch. 2]
= Generalized Coordinates and Constraints // 广义坐标与约束


// Chapter 3: Axiom: Hamilton's Principle (公理：哈密顿原理 - 最小作用量原理)
//   Section 3.1: Definition of Action Functional (作用量泛函的定义)
//   Section 3.2: Axiomatic Statement (公理陈述)
//   Section 3.3: Additivity and Gauge Invariance of Lagrangian (拉格朗日量的可加性与不唯一性)
= Axiom: Hamilton's Principle // 公理：哈密顿原理

// =========================================================================
// --- Part II: Lagrangian Mechanics (拉格朗日力学) ---
// =========================================================================
// Theme: Retrospective derivation showing how Lagrangian methods recover classical results
#part("Lagrangian Mechanics") // 拉格朗日力学

// Chapter 4: Lagrange's Equations (拉格朗日方程)
//   Section 4.1: Lagrangian Function (拉格朗日函数) [← Based on Part 0 Ch. 3.5: Potential Energy]
//   Section 4.2: Derivation from Hamilton's Principle (从哈密顿原理推导)
//   Section 4.3: Lagrange's Equations of the Second Kind (第二类拉格朗日方程) [← Recovers Part 0 Ch. 2.1]
//   Section 4.4: Generalized Forces (广义力)
//   Section 4.5: Lagrange's Equations with Constraints (带约束的拉格朗日方程) [← Generalizes Part 0 Ch. 2.2]
//   Section 4.6: Lagrange Multipliers in Mechanics (力学中的拉格朗日乘子)
= Lagrange's Equations // 拉格朗日方程

In this chapter, the variational principle from the previous section is converted into differential equations for motion.
The key idea is that the actual trajectory is a stationary curve of the action, and the equations of motion are the corresponding Euler-Lagrange equations in generalized coordinates.

== Lagrangian Function // 拉格朗日函数

The starting pointof analytical mechanics is the *Lagrangian function*.

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
  q(t) = (q_1(t), dots, q_n(t)).
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

Assume that the configuration curve is varied as

$
  q_i,epsilon(t) = q_i(t) + epsilon eta_i(t), quad eta_i(t_0)=eta_i(t_1)=0.
$

The stationarity condition from Hamilton's principle gives

$
  delta S[q; eta] = 0.
$

Because the endpoints are fixed, the first variation is computed by differentiating the action with respect to $epsilon$ and evaluating at $epsilon=0$:

$
  delta S[q; eta] = integral_(t_0)^(t_1) sum_(i=1)^n ( frac(partial L, partial q_i) eta_i + frac(partial L, partial dot(q)_i) dot(eta)_i ) dif t.
$

Integrating by parts in each term containing $dot(eta)_i$ yields

$
  delta S[q; eta] = integral_(t_0)^(t_1) sum_(i=1)^n ( frac(partial L, partial q_i) - frac(dif, dif t) frac(partial L, partial dot(q)_i) ) eta_i dif t.
$

Since the variations $eta_i$ are arbitrary in the interior of the interval, the fundamental lemma implies that each coefficient must vanish.

== Lagrange's Equations of the Second Kind // 第二类拉格朗日方程=== Generalized Forces // 广义力

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
  f_alpha(q_1, dots, q_n, t) = 0, quad alpha = 1, dots, m,
$

the configuration space is reduced to an admissible submanifold of the full coordinate space.
If the constraints are holonomic, one can either solve them explicitly or introduce multipliers.

#theorem(name: "Constrained Lagrange Equations")[
  For holonomic constraints $f_alpha(q, t)=0$, the equations of motion can be written in the multiplier form

  $
    frac(dif, dif t) frac(partial L, partial dot(q)_i) - frac(partial L, partial q_i) = sum_(alpha=1)^m lambda_alpha frac(partial f_alpha, partial q_i),
  $

  together with the constraintegralequations

  $
    f_alpha(q, t) = 0, quad alpha = 1, dots, m.
  $
]

The multipliers $lambda_alpha$ encode the constraintegralreaction forces.
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

// Chapter 5: Conservation Laws in Lagrangian Mechanics (拉格朗日力学中的守恒律)
//   Section 5.1: Cyclic Coordinates and Generalized Momenta (循环坐标与广义动量)
//   Section 5.2: Energy Conservation (能量守恒) [← Time symmetry → Retrospective to Part 0 Ch. 3.3]
//   Section 5.3: Noether's Theorem (诺特定理)
//   Section 5.4: Momentum Conservation and Translational Symmetry (动量守恒与平移对称性) [← Retrospective to Part 0 Ch. 3.1]
//   Section 5.5: Angular Momentum Conservation and Rotational Symmetry (角动量守恒与旋转对称性) [← Retrospective to Part 0 Ch. 3.2]

= Conservation Laws in Lagrangian Mechanics // 拉格朗日力学中的守恒律

Conservation laws are the symmetry side of the Lagrangian formalism.
Once the equations of motion have been derived, one can often read off conserved quantities directly from the structure of the Lagrangian.

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

// Chapter 6: Applications of Lagrangian Mechanics (拉格朗日力学的应用)
//   Section 6.1: Rigid Body Dynamics (刚体动力学) [← Recovers Part 0 Ch. 2.2 via Lagrangian]
//   Section 6.2: Central Force Motion (中心力运动) [← Connects to Part 0 Ch. 5]
//   Section 6.3: Small Oscillations (小振动) [← Generalizes Part 0 Ch. 4]
//   Section 6.4: Normal Modes and Eigenfrequencies (简正模与本征频率)
//   Section 6.5: Coupled Oscillators (耦合振子)
= Applications of Lagrangian Mechanics // 拉格朗日力学的应用

// =========================================================================
// --- Part III: Hamiltonian Mechanics (哈密顿力学) ---
// =========================================================================
#part("Hamiltonian Mechanics") // 哈密顿力学

// Chapter 7: Hamilton's Equations (哈密顿方程)
//   Section 7.1: Legendre Transformation (勒让德变换)
//   Section 7.2: Hamiltonian Function (哈密顿函数)
//   Section 7.3: Canonical Equations of Motion (正则运动方程)
//   Section 7.4: Hamiltonian for Common Systems (常见系统的哈密顿量)
//   Section 7.5: Phase Space and Phase Portraits (相空间与相图)

// Chapter 8: Canonical Transformations (正则变换)
//   Section 8.1: Generating Functions (生成函数)
//   Section 8.2: Types of Generating Functions (生成函数的类型)
//   Section 8.3: Conditions for Canonical Transformations (正则变换的条件)
//   Section 8.4: Poisson Brackets (泊松括号)
//   Section 8.5: Invariants under Canonical Transformations (正则变换下的不变量)
//   Section 8.6: Symplectic Structure (辛结构)

// Chapter 9: Hamilton-Jacobi Theory (哈密顿-雅可比理论)
//   Section 9.1: Hamilton-Jacobi Equation (哈密顿-雅可比方程)
//   Section 9.2: Separation of Variables (分离变量法)
//   Section 9.3: Action-Angle Variables (作用量-角变量)
//   Section 9.4: Complete Integrals and Characteristics (完全积分与特征线)
//   Section 9.5: Applications to Central Force Problems (在中心力问题中的应用)

// =========================================================================
// --- Part IV: Advanced Topics (进阶主题) ---
// =========================================================================
#part("Advanced Topics") // 进阶主题

// Chapter 10: Liouville's Theorem and Statistical Mechanics (刘维尔定理与统计力学)
//   Section 10.1: Liouville's Theorem (刘维尔定理)
//   Section 10.2: Phase Space Volume Conservation (相空间体积守恒)
//   Section 10.3: Ergodicity and Mixing (遍历性与混合)
//   Section 10.4: Poincaré Recurrence Theorem (庞加莱回归定理)

// Chapter 11: Perturbation Theory (微扰理论)
//   Section 11.1: Time-independent Perturbation Theory (不含时微扰理论)
//   Section 11.2: Time-dependent Perturbation Theory (含时微扰理论)
//   Section 11.3: Adiabatic Invariants (绝热不变量)
//   Section 11.4: Canonical Perturbation Theory (正则微扰理论)

// Chapter 12: Integrable Systems (可积系统)
//   Section 12.1: Complete Integrability (完全可积性)
//   Section 12.2: Lax Pairs (Lax对)
//   Section 12.3: Inverse Scattering Method (逆散射方法)
//   Section 12.4: Examples of Integrable Systems (可积系统示例)

// Chapter 13: Stability and Chaos (稳定性与混沌)
//   Section 13.1: Linear Stability Analysis (线性稳定性分析)
//   Section 13.2: Lyapunov Exponents (李雅普诺夫指数)
//   Section 13.3: Poincaré Sections (庞加莱截面)
//   Section 13.4: Bifurcations (分岔)
//   Section 13.5: Routes to Chaos (通向混沌的道路)



// =========================================================================
// --- Part V: Relativistic and Field Extensions (相对论与场的推广) ---
// =========================================================================
#part("Relativistic and Field Extensions") // 相对论与场的推广

// Chapter 14: Relativistic Mechanics (相对论力学)
//   Section 14.1: Relativistic Lagrangian (相对论拉格朗日量)
//   Section 14.2: Relativistic Hamiltonian (相对论哈密顿量)
//   Section 14.3: Electromagnetic Interactions (电磁相互作用)
//   Section 14.4: Covariant Formulation (协变形式)

// Chapter 15: Classical Field Theory (经典场论)
//   Section 15.1: Lagrangian Density (拉格朗日密度)
//   Section 15.2: Field Equations from Variational Principle (从变分原理推导场方程)
//   Section 15.3: Noether's Theorem for Fields (场的诺特定理)
//   Section 15.4: Stress-Energy Tensor (应力-能量张量)
//   Section 15.5: Examples: Scalar and Electromagnetic Fields (示例：标量场与电磁场)
