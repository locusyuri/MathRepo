#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Thermodynamique",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Thermodynamique",
  "Violet",
  subtitle: "A notebook for thermodynamics and statistical mechanics",
  institute: "Notiz Physique",
  date: datetime.today().display(),
  version: "v0.1.0",
  extra-info: "This is a notebook for thermodynamics and statistical mechanics.",
)

#make-outline(depth: 2, title: "Contents")

#part("Kinetic Theory and Classical Thermodynamics")

= Kinetic Theory of Gases // 气体分子运动论

Kinetic theory explains the macroscopic behaviour of gases from the
molecular picture: a gas is a swarm of particles in ceaseless random
motion, and every thermodynamic quantity is a statistical average over
this motion. This chapter builds that dictionary — pressure as momentum
flux, temperature as mean kinetic energy — before the formal
thermodynamic framework of Chapters 2–4.

== Ideal Gas Law and Equation of State // 理想气体定律与状态方程

#definition(name: "Equilibrium State and State Variables")[
  A thermodynamic system is in an *equilibrium state* if its measurable
  properties are independent of time and of the system's history. For a
  simple compressible system of fixed composition, the state is
  characterised by a small set of *state variables* — the pressure $p$,
  the volume $V$, and the temperature $T$.
] <def:equilibrium-state>

#definition(name: "Equation of State")[
  The *equation of state* is the functional relation among the state
  variables,
  $
    f(p, V, T) = 0,
  $
  expressing that only two of the three variables are independent for a
  simple system.
] <def:equation-of-state>

The *ideal gas* is the limiting case of a gas at low density, where
intermolecular forces and molecular volumes are negligible. Its
equation of state, established empirically by Boyle, Charles and
Avogadro, is
$
  p V = n R T = N k_B T,
$
where $n$ is the amount of substance, $R = N_A k_B = 8.314 "J\/(mol K)"$
is the gas constant, and $k_B = 1.38 times 10^(-23) "J\/K"$ is the
Boltzmann constant. The three families of curves $p V = "const"$
(isotherms), $p = "const"$ (isobars) and $V = "const"$ (isochores)
partition the $p$-$V$ plane; see @fig:pv-isotherms.

#example[
  (Van der Waals equation.) The first systematic correction to the
  ideal gas accounts for the finite molecular volume $b$ and the
  attractive intermolecular forces, giving the *van der Waals equation*
  per mole,
  $
    (p + a / V_m^2)(V_m - b) = R T.
  $
  The parameter $a$ adds an internal pressure (cohesion) and $b$
  subtracts the excluded volume. Below the critical temperature
  $T_c = 8a / (27 R b)$ the isotherms develop a loop signalling the
  liquid--gas transition; the physical isotherm is recovered by the
  Maxwell equal-area construction, discussed with the mean field theory
  of Chapter 19.
] <ex:vanderwaals-isotherms>

#figure(
  image("img/pv-isotherms.svg", width: 72%),
  caption: [Isotherms in the $p$-$V$ plane: hyperbolic ideal-gas
    isotherms $p V = n R T$ and van der Waals isotherms, the subcritical
    one developing the characteristic loop that signals the liquid--gas
    transition below the critical temperature.],
  placement: auto,
  supplement: [Fig.],
) <fig:pv-isotherms>

More generally, any equation of state admits a low-density expansion,
the *virial expansion*
$
  (p V_m) / (R T) = 1 + B_2(T) / V_m + B_3(T) / V_m^2 + dots,
$
with temperature-dependent *virial coefficients* $B_2, B_3, dots$
encoding the intermolecular forces. The ideal gas corresponds to all
virial coefficients vanishing; their systematic computation from first
principles is carried out by the cluster expansion of Chapter 19.

== Maxwell-Boltzmann Velocity Distribution // 麦克斯韦-玻尔兹曼速度分布

In equilibrium the molecules of a gas are distributed over velocities
according to a law so universal that it has survived every subsequent
revolution in physics. Maxwell derived it in 1860 from two symmetry
assumptions alone.

#definition(name: "Maxwell Velocity Distribution")[
  In a gas at thermal equilibrium, the probability density of the
  velocity $bold(v) = (v_x, v_y, v_z)$ of a molecule of mass $m$ at
  temperature $T$ is
  $
    f(bold(v)) = (m / (2 pi k_B T))^(3/2) exp(- m v^2 / (2 k_B T)),
  $
  where $v^2 = v_x^2 + v_y^2 + v_z^2$.
] <def:maxwell-velocity>

*Derivation (Maxwell's argument).* Write the density as
$f(v_x, v_y, v_z)$ and impose two assumptions:

- *Isotropy*: the gas selects no preferred direction, so $f$ depends on
  the velocity only through its magnitude, $f = phi(v)$ with
  $v = sqrt(v_x^2 + v_y^2 + v_z^2)$;
- *Component independence*: the three Cartesian components are
  statistically independent, so
  $f(v_x, v_y, v_z) = g(v_x) g(v_y) g(v_z)$ for one and the same
  function $g$, by isotropy again.

Combining the two and setting $v_z = 0$,
$
  g(v_x) g(v_y) = phi(sqrt(v_x^2 + v_y^2)).
$
Taking logarithms with $G(u) = ln g(sqrt(u))$ and
$Phi(s) = ln phi(sqrt(s))$ gives $G(u) + G(w) = Phi(u + w)$ for all
$u, w >= 0$; ∂erentiating with respect to $u$ and $w$ separately
yields $G'(u) = G'(w)$ for all $u, w$, so $G'$ is a constant $-alpha$
and
$
  g(v) = A exp(-alpha v^2).
$
Normalisation fixes $A = sqrt(alpha / pi)$ per component. The parameter
$alpha$ is fixed by the pressure computation below to be
$alpha = m / (2 k_B T)$.

#property(name: "Pressure as Momentum Flux")[
  In a gas of number density $n$ whose velocities follow the Maxwell
  distribution, the pressure exerted on a container wall is
  $
    p = n m lr(⟨ v_x^2 ⟩) = 1/3 n m lr(⟨ v^2 ⟩).
  $
] <prop:kinetic-pressure>

*Derivation.* Molecules striking the wall transfer $2 m v_x$ of momentum,
the normal component being reversed. The flux of molecules arriving with
normal component in $(v_x, v_x + dif v_x)$, $v_x > 0$, is
$n v_x g(v_x) dif v_x$, so
$
  p = integral_0^infinity 2 m v_x dot n v_x g(v_x) dif v_x
  = n m integral_(-infinity)^infinity v_x^2 g(v_x) dif v_x
  = n m lr(⟨ v_x^2 ⟩).
$
Isotropy gives $lr(⟨ v_x^2 ⟩) = lr(⟨ v_y^2 ⟩) =
lr(⟨ v_z^2 ⟩) = lr(⟨ v^2 ⟩) / 3$. Comparing with the
ideal gas law $p = n k_B T$ forces
$
  1/3 m lr(⟨ v^2 ⟩) = k_B T, quad "i.e." quad
  1/2 m lr(⟨ v^2 ⟩) = 3/2 k_B T,
$
so $alpha = m / (2 k_B T)$. Temperature is thereby *identified* with the
mean kinetic energy per molecule — the dictionary entry announcing the
equipartition theorem of §1.4. The argument does not merely use the
ideal gas law; it *explains* it.

#definition(name: "Speed Distribution")[
  The probability density of the speed $v = norm(bold(v))$ follows by
  integrating the velocity density over the spherical shell
  $v < norm(bold(v)) < v + dif v$ of volume $4 pi v^2 dif v$:
  $
    F(v) = 4 pi v^2 (m / (2 pi k_B T))^(3/2)
    exp(- m v^2 / (2 k_B T)).
  $
] <def:speed-distribution>

The factor $4 pi v^2$ — the volume of the shell — reshapes the Gaussian
into a law with a rising front and a long tail.

#property(name: "Characteristic Speeds")[
  Three speeds characterise the Maxwell distribution:
  $
    v_p = sqrt(2 k_B T / m), quad
    overline(v) = sqrt(8 k_B T / (pi m)), quad
    v_("rms") = sqrt(3 k_B T / m),
  $
  the *most probable*, *mean* and *root-mean-square* speeds, in the
  fixed ratio
  $
    v_p : overline(v) : v_("rms") = 1 : 1.128 : 1.225.
  $
] <prop:characteristic-speeds>

*Derivation.* The most probable speed maximises $F$: setting
$dif (v^2 exp(-alpha v^2)) / dif v = 0$ gives $2/v - 2 alpha v = 0$,
hence $v_p = 1 / sqrt(alpha)$. The mean speed uses the integral
$integral_0^infinity v^3 exp(-alpha v^2) dif v = 1 / (2 alpha^2)$:
$
  overline(v) = 4 pi A^3 dot 1 / (2 alpha^2) = 2 / sqrt(pi alpha).
$
Finally $v_("rms")^2 = lr(⟨ v^2 ⟩) = 3 / (2 alpha)$ from the
pressure derivation above.

#figure(
  image("img/maxwell-speed-distribution.svg", width: 75%),
  caption: [Maxwell speed distribution $F(v)$ at three temperatures. The
    most probable speed $v_p$ (the peak), the mean speed $overline(v)$
    and the root-mean-square speed $v_("rms")$ all scale as $sqrt(T)$, and
    the distribution spreads towards higher speeds as $T$ rises.],
  placement: auto,
  supplement: [Fig.],
) <fig:maxwell-speed>

#example[
  (Stern experiment, 1920.) Silver atoms evaporating from an oven pass
  through a slit into a rotating drum; the deposit on the inner wall is
  spread according to flight time, hence according to speed. The
  measured deposit profile matches $F(v)$, providing direct experimental
  confirmation of the Maxwell distribution.
] <ex:stern-experiment>

#note[
  (Probabilistic structure.) The velocity density factorises into three
  independent Gaussians; consequently $v^2$ is distributed as a sum of
  three squared centred Gaussians — a scaled chi-square distribution
  with three degrees of freedom, as studied in the Probabilités note.
  The speed distribution $F(v)$ is thus a scaled chi distribution, and
  the characteristic speeds of
  #link(<prop:characteristic-speeds>)[the preceding property] are its
  shape parameters in disguise.
] <note:mb-probability>

== Mean Free Path and Collision Frequency // 平均自由程与碰撞频率

The Maxwell distribution describes free flight; the picture is completed
by the collisions that randomise it. For a dilute gas, the collision
structure is captured by a single geometric quantity.

#definition(name: "Collision Cross-Section")[
  Model the molecules as hard spheres of diameter $d$. A collision
  occurs whenever two centres pass within a distance $d$; equivalently,
  each molecule sweeps out a *collision cross-section*
  $
    sigma = pi d^2
  $
  on the cylinder of targets it can hit.
] <def:collision-cross-section>

#property(name: "Mean Free Path")[
  A molecule of a gas with number density $n$ travels, between
  successive collisions, an average distance
  $
    lambda = 1 / (sqrt(2) n sigma).
  $
] <prop:mean-free-path>

*Derivation.* In a time $dif t$, a molecule moving with speed $v$ sweeps
a cylinder of volume $sigma v dif t$ and collides with every other
molecule whose centre lies inside it. With stationary targets the
collision rate would be $n sigma v$, giving $lambda = 1/(n sigma)$. The
targets are themselves moving: the relevant quantity is the *relative*
speed, whose mean over two Maxwell-distributed velocities is
$sqrt(2) overline(v)$ (the ∂erence of two independent Gaussians is
Gaussian, with doubled variance). Hence the collision rate
$
  z = sqrt(2) n sigma overline(v), quad "so that" quad lambda =
  overline(v) / z = 1 / (sqrt(2) n sigma).
$
The mean free path depends only on density and molecular size — at
atmospheric conditions $lambda approx 70 "nm"$, some $200$ molecular
diameters, which is why the dilute-gas picture is self-consistent.

The *collision frequency* $z$ will do little explicit work below, but
the mean free path $lambda$ and the mean speed $overline(v)$ are the
two ingredients from which all transport coefficients of §1.5 are
assembled.

== Energy Equipartition Theorem // 能量均分定理

A classical system in thermal equilibrium shares its energy equally
among all quadratic degrees of freedom. The result underlies the
classical theory of heat capacities — and its dramatic failure at low
temperatures, which announced the quantum theory.

#theorem(name: "Equipartition Theorem")[
  Let the energy of a classical system be
  $
    E = sum_(i=1)^f alpha_i x_i^2 + tilde(E)(x_(f+1), dots, x_N),
  $
  where the coordinates $x_1, dots, x_f$ enter only quadratically and
  the remaining coordinates appear in $tilde(E)$ but not in the
  quadratic terms. In thermal equilibrium at temperature $T$,
  $
    lr(⟨ alpha_i x_i^2 ⟩) = 1/2 k_B T quad "for each" i = 1,
    dots, f.
  $
] <thm:equipartition>

*Derivation.* The distribution over phase space in equilibrium is the
Maxwell--Boltzmann density proportional to $exp(- E / (k_B T))$ (this
will be rederived systematically from the canonical ensemble in
Chapter 13; at the kinetic level it is the velocity law of §1.2 applied
to every quadratic coordinate). Then
$
  lr(⟨ alpha_i x_i^2 ⟩)
  = (integral alpha_i x_i^2 exp(-E/(k_B T)) dif Gamma) /
  (integral exp(-E/(k_B T)) dif Gamma).
$

Let $beta = 1/(k_B T)$. The Gaussian factorisation makes each quadratic
coordinate independent:
$
  lr(⟨ alpha_i x_i^2 ⟩) = (alpha_i integral x_i^2 exp(-beta alpha_i x_i^2) dif x_i) / (integral exp(-beta alpha_i x_i^2) dif x_i).
$
With the Gaussian integrals
$integral exp(-beta alpha x^2) dif x = sqrt(pi / (beta alpha))$ and
$integral x^2 exp(-beta alpha x^2) dif x = sqrt(pi) / (2 (beta alpha)^(3/2))$,
the ratio equals $1/(2 beta) = 1/2 k_B T$.

#example[
  (Heat capacities of dilute gases.) Each translational or rotational
  degree of freedom contributes $1/2 k_B T$ to the mean energy per
  molecule, so

  - *monatomic gas* ($f = 3$ translations): $lr(⟨ E ⟩) = 3/2 k_B T$
    per molecule and $C_V = 3/2 R$ per mole;
  - *rigid diatomic gas* ($f = 5$: three translations + two rotations,
    the axis along the bond carrying no moment of inertia):
    $C_V = 5/2 R$;
  - *diatomic gas with vibrational mode* ($f = 7$: adding one kinetic +
    one potential quadratic term): $C_V = 7/2 R$.

  These are precisely the classical values tabulated for gases such as
  helium ($C_V approx 3/2 R$), nitrogen at room temperature
  ($approx 5/2 R$), and chlorine at high temperature ($approx 7/2 R$).
] <ex:gas-heat-capacities>

#caution[
  (Failure of equipartition.) The vibrational contribution of the
  previous example is *frozen out* at room temperature: nitrogen does
  not reach $C_V = 7/2 R$ until far above $2000 "K"$. Worse still, the
  vibrational and rotational contributions of solids are missing
  entirely at low temperatures, and the classical prediction of the
  specific heat of a crystal — $3 R$ per mole at *all* temperatures
  (the Dulong--Petit law) — collapses below tens of kelvin. Classical
  statistical mechanics cannot explain these facts; the resolution is
  quantum mechanical, and is supplied by the Einstein and Debye models
  (Chapter 15) and by quantum statistics (Chapter 17).
] <caution:equipartition-failure>

== Transport Phenomena // 输运现象

A gas in which the local state varies from pintegral.cont to pintegral.cont does not stay
that way: molecules flying freely between collisions carry momentum,
energy and particles across any surface, smoothing out the inhomogeneity.
Three gradient-driven relaxation processes result, each governed by a
*transport coefficient*.

#table(
  columns: (auto, auto, auto, auto),
  align: (left, left, center, left),
  [Phenomenon], [Graded quantity], [Flux law], [Coefficient],
  [Momentum transport (viscosity)], [flow velocity $u(z)$], [$Pi = -eta dif u \/ dif z$], [shear viscosity $eta$],
  [Energy transport (heat conduction)],
  [temperature $T(z)$],
  [$q = -kappa dif T \/ dif z$],
  [thermal conductivity $kappa$],

  [Mass transport (∂usion)], [number density $n(z)$], [$J = -D dif n \/ dif z$], [∂usion coefficient $D$],
)

Each law is written for transport along $z$; the flux $Pi$ carries
$z$-momentum across a plane, $q$ is the heat current and $J$ the particle
current. All three share the same kinetic origin — a molecule crossing
the plane travels, on average, one mean free path since its last
collision, and so deposits the local value of the transported property
one mean free path away.

#definition(name: "Transport Coefficients")[
  With the flux laws of the table above, the *shear viscosity* $eta$,
  the *thermal conductivity* $kappa$ and the *∂usion coefficient*
  $D$ characterise the response of the gas to velocity, temperature and
  density gradients respectively.
] <def:transport-coefficients>

#property(name: "Kinetic Estimates of Transport Coefficients")[
  In terms of the mean free path $lambda$, mean speed $overline(v)$,
  number density $n$ and molecular mass $m$,
  $
    eta = 1/3 rho overline(v) lambda, quad
    kappa = 1/3 n overline(v) lambda c_V^("mol") , quad
    D = 1/3 overline(v) lambda,
  $
  where $rho = n m$ is the mass density and $c_V^("mol")$ the molar
  heat capacity at constant volume.
] <prop:kinetic-transport>

*Derivation (one of three; the viscosity case).* Take the flow velocity
$u(z)$ along $x$, sheared in $z$. Molecules cross a plane $z = "const"$
from above and from below at rate $1/2 n overline(v)$ per unit area
(the factor $1/3$ averaging over directions collapses into the isotropic
crossing rate $1/4 n overline(v)$ per direction pair; the resulting
prefactor is $1/3$ in the elementary estimate, higher-order treatments
give $0.37$-odd). A molecule arriving from distance $lambda$ carries the
$x$-momentum appropriate to its departure pintegral.cont, $m u(z - lambda)$ from
below and $m u(z + lambda)$ from above. The net momentum flux in the
$+z$ direction is
$
  Pi = 1/2 n overline(v) [m u(z - lambda) - m u(z + lambda)]
  = - n m overline(v) lambda dif u / dif z,
$
with the sign convention that positive $Pi$ transports $x$-momentum
towards $+z$. Comparing with $Pi = -eta dif u / dif z$ yields
$eta = rho overline(v) lambda / 3$. The conductivity follows by
replacing the transported property by the mean energy $c_V^("mol") T / N_A$
per molecule, and the ∂usivity by the particle property itself.

Three consequences are worth recording:

- *Independence of density.* $lambda = 1/(sqrt(2) n sigma)$ cancels the
  $n$ in $eta = 1/3 rho overline(v) lambda$: the viscosity of a dilute
  gas is independent of pressure — a striking 1860 prediction of
  Maxwell, confirmed by his own experiments.
- *Temperature dependence.* Since $overline(v) prop sqrt(T)$ and
  $lambda prop T$ at fixed pressure, $eta prop T^(1/2)$ and
  $kappa prop T^(1/2)$: gaseous viscosity *increases* with
  temperature, opposite to liquids — a fingerprint of transport by
  free flight rather than by intermolecular locking.
- *Self-consistency.* All three coefficients share the combination
  $overline(v) lambda$, of order the collision rate — and all three
  derivations use free flight over one $lambda$, valid only when
  $lambda$ is small compared with the macroscopic scale of the gradient.

#note[
  (Stochastic boundary.) The molecular-randomness picture of this
  section is the classical precursor of fluctuation phenomena: a
  suspended particle buffeted by molecular impacts performs Brownian
  motion, whose rigorous treatment — Langevin equations,
  Fokker--Planck equations, the fluctuation--dissipation theorem — is
  the subject of the Processus Stochastique note, and is touched upon
  again in Chapter 23 of this note.
] <note:transport-stochastic>

== Boltzmann H-Theorem and Irreversibility // 玻尔兹曼 H 定理与不可逆性

The microscopic laws of motion are invariant under time reversal; the
transport phenomena of §1.5 are not — viscosity dissipates, heat flows
from hot to cold, and never backwards. Boltzmann's H-theorem was the
first quantitative bridge across this gap.

#definition(name: "H Function")[
  For a gas with one-particle velocity distribution $f(bold(v), t)$,
  the *H function* is
  $
    H(t) = integral f(bold(v), t) ln f(bold(v), t) dif^3 v.
  $
  Up to constants, $H$ is the (negative) continuous entropy of the
  velocity distribution.
] <def:h-function>

#theorem(name: "Boltzmann H-Theorem")[
  For a dilute gas whose collisions conserve particle number, momentum
  and kinetic energy, and whose colliding pairs are statistically
  uncorrelated before impact (*molecular chaos*), the H function
  satisfies
  $
    (dif H) / (dif t) <= 0,
  $
  with equality if and only if $f$ is the Maxwell distribution of
  §1.2.
] <thm:h-theorem>

*Derivation (sketch).* Each collision $bold(v), bold(v)_1 arrow.r
bold(v)', bold(v)'_1$ changes $H$ by the amount contributed by the four
distribution values involved. Collecting the gain of the outgoing pair
and the loss of the incoming pair, summing over all collisions and
using the conservation laws, one obtains schematically
$
  (dif H) / (dif t) = 1/4 integral integral (f' f'_1 - f f_1)
  ln (f f_1 / (f' f'_1)) dif^3 v dif^3 v_1 quad <= 0,
$
because for positive numbers $x = f f_1$ and $y = f' f'_1$ the factor
$(y - x) ln(x / y)$ is never positive (the function $u ln u$ is
convex, or equivalently $ln u <= u - 1$). Equality forces
$f f_1 = f' f'_1$ in every collision — the incoming and outgoing
distributions agree, which is precisely the characterisation of the
Maxwell distribution. The full collision integral is set up and
analysed systematically in Chapter 21.

#caution[
  (Loschmidt and Zermelo paradoxes.) *Loschmidt's reversibility
  objection* (1876): since the microscopic dynamics is invariant under
  velocity reversal, every H-decreasing motion has an H-increasing
  twin — how can H-theorem hold? *Zermelo's recurrence objection*
  (1896): Poincaré recurrence returns a closed system arbitrarily close
  to its initial state, so $H$ must return to its initial value. Both
  objections are correct about the microscopic dynamics and both miss
  the statistical content of the theorem: the molecular-chaos
  assumption encodes a *probability* statement about initial
  conditions, and $dif H / (dif t) <= 0$ holds with overwhelming
  probability, not with certainty. Irreversibility is not a law of
  motion but a law of large numbers applied to motion — the Second Law
  of Chapter 3 in statistical costume.
] <caution:reversibility-paradoxes>

#note[
  (Statistical interpretation.) The H function is, up to the constant
  $-k_B N$, the Gibbs entropy of the one-particle distribution. The
  H-theorem thus gives the microscopic mechanism of entropy increase,
  and its equality condition — the Maxwell distribution — identifies
  the equilibrium state. Two caveats delimit its scope: the theorem
  addresses the approach to equilibrium, not the value of equilibrium
  entropy itself (Chapter 12); and the molecular-chaos assumption
  breaks the formal time-reversal symmetry of the underlying dynamics,
  which is exactly where the statistical arrow of time enters. The
  systematic Boltzmann-equation treatment, including the rigorous
  collision integral, is the subject of Chapter 21.
] <note:h-statistical>

= Zeroth and First Laws of Thermodynamics // 热力学第零与第一定律

The kinetic theory of Chapter 1 derived macroscopic quantities from
molecular motion. Classical thermodynamics takes the opposite route: it
organises the macroscopic regularities themselves into a logical
structure — four laws — from which measurable consequences follow
without any assumption about molecules. This chapter establishes the
temperature scale (zeroth law) and the balance sheet of energy (first
law).

== Thermodynamic Systems and State Variables // 热力学系统与状态变量

#definition(name: "Thermodynamic System")[
  A *thermodynamic system* is the macroscopic body singled out for
  study; everything outside is the *environment*, and the surface
  separating the two is the *boundary*. Systems are classified by what
  crosses the boundary:

  - an *isolated* system exchanges neither matter nor energy;
  - a *closed* system exchanges energy but not matter;
  - an *open* system exchanges both.
] <def:thermodynamic-system>

#definition(name: "Extensive and Intensive Quantities")[
  A state quantity is *extensive* if it doubles when two copies of the
  system are combined into one, and *intensive* if it is unchanged
  under such a scaling. Volume $V$, amount of substance $n$, internal
  energy $U$, entropy $S$ are extensive; pressure $p$, temperature
  $T$, density $rho$ are intensive. The quotient of two extensive
  quantities is intensive.
] <def:extensive-intensive>

The equilibrium states in which the laws operate were characterised in
#link(<def:equilibrium-state>)[Chapter 1]: state variables that are
independent of time and history.

#definition(name: "Quasi-Static Process")[
  A *quasi-static process* is one that proceeds through a continuous
  sequence of equilibrium states — slower than the time the system
  needs to equilibrate internally, so that the state variables are
  well-defined at every instant.
] <def:quasi-static-process>

Every quasi-static process can be drawn as a curve in the state
diagram ($p$-$V$ plane for a simple fluid), which is the arena for the
work calculations of §2.3. A quasi-static process need not be
*reversible* (friction inside the system spoils reversibility without
destroying quasi-statics); the precise notion of reversibility belongs
to the second law and is developed in Chapter 3.

#note[
  (Axiomatics.) Callen reformulated classical thermodynamics as an
  axiomatic system: a handful of postulates on the existence of
  equilibrium states and on an extensive quantity — the entropy — that
  is maximised at equilibrium. Since the entropy is not yet available
  (it is the business of Chapter 3), we keep the present development
  law-by-law; the Callen postulates are stated and made rigorous by
  the microcanonical ensemble of Chapter 12, where the statistical
  origin of each postulate becomes visible.
] <note:callen-program>

== Zeroth Law and Temperature // 第零定律与温度

That "temperature" is a meaningful state variable rests on an empirical
regularity so basic it was formalised last, after the first law, and
therefore numbered zero.

#definition(name: "Zeroth Law")[
  Two systems each in thermal equilibrium with a third are in thermal
  equilibrium with each other. Consequently, thermal equilibrium is an
  equivalence relation on the set of all systems, and to each
  equivalence class one may attach a number — the *temperature* —
  common to all its members.
] <def:zeroth-law>

The existence of an equivalence class label is the *existence of
temperature*; the choice of labelling scheme is a *temperature scale*.

#definition(name: "Empirical Temperature")[
  A *thermometer* is a small test body with one conveniently measurable
  state quantity — the *thermometric parameter* $theta$ (mercury column
  height, electrical resistance, gas pressure) — fixed while all its
  other state variables are held fixed. The value of $theta$ at thermal
  equilibrium with a system defines the *empirical temperature* of that
  system on the chosen scale.
] <def:empirical-temperature>

Different thermometers need not agree in detail — each defines its own
empirical scale. The universal choice uses the ideal gas, whose
equation of state (Chapter 1) supplies a system-independent standard.

#property(name: "Ideal Gas Temperature Scale")[
  Fix the volume of a gas thermometer and measure its pressure $p$. The
  temperature defined by
  $
    T(p) = 273.16 dot p / p_3 quad "K",
  $
  where $p_3$ is the pressure at the triple pintegral.cont of water, is
  independent of the gas used (in the dilute limit) and coincides with
  the absolute Kelvin scale.
] <prop:ideal-gas-scale>

*Derivation.* For a fixed amount of gas at fixed volume,
#link(<def:equation-of-state>)[the ideal gas law] gives $p = n R T / V
prop T$. The triple pintegral.cont of water — the unique state at which ice,
liquid water and vapour coexist — is assigned $T_3 = 273.16 "K"$ by
convention, so $T / T_3 = p / p_3$. That the ratio $p / p_3$, read off
∂erent dilute gases, converges to a common limit is the empirical
content of the law; the deviations vanish as the gas charge is
reduced, because all low-density gases approach the same ideal gas of
Chapter 1.

#note[
  (The absolute scale.) The identification with the *absolute
  (Kelvin) scale* was just used ahead of its proof. Properly, the
  absolute scale is constructed from the Carnot cycle, which references
  no material substance at all; the equivalence of the Carnot and
  ideal-gas scales is proved in Chapter 3, once the second law is
  available. Until then, the ideal-gas scale of
  #link(<prop:ideal-gas-scale>)[the preceding property] serves as the
  definition of $T$.
] <note:kelvin-scale>

== Work and Heat in Thermodynamic Processes // 热力学过程中的功与热

Energy crosses the boundary of a closed system in exactly two forms:
work, which is energy transfer by macroscopically controlled means, and
heat, which is transfer exploiting a temperature ∂erence. Neither is
a property of the state — they characterise the *process*.

#definition(name: "Work")[
  For a simple compressible system, the work done *on* the system by
  the environment during a quasi-static volume change is
  $
    delta W = - p dif V,
  $
  the sign convention being that compression ($dif V < 0$) does
  positive work on the system. More generally, for a system with
  generalised force $Y$ and displacement $X$,
  $
    delta W = sum_i Y_i dif X_i,
  $
  covering, e.g., magnetic work $mu_0 H dif M$, elastic work $F dif L$
  and surface work $sigma dif A$.
] <def:work>

The $delta$ in $delta W$ — as opposed to the $dif$ in $dif V$ — signals
that work is *not* an exact ∂erential: no state function $W$ exists
whose ∂erential it would be.

#property(name: "Work as Area in the State Diagram")[
  For a quasi-static process taking the system along a curve $C$ in the
  $p$-$V$ plane, the work done *by* the system is
  $
    W_("by") = integral_C p dif V,
  $
  the area under the path. Work therefore depends on the path, not
  merely on the endpintegral.conts.
] <prop:work-path>

#example[
  (Path dependence.) Take an ideal gas from $(V_1, T)$ to $(V_2, T)$
  (with $V_2 > V_1$) along two quasi-static paths:

  - *direct isothermal expansion*: $W = n R T ln(V_2 / V_1)$;
  - *two-step path*: isobaric expansion at $p_1$ from $V_1$ to $V_2$
    ($W' = p_1 (V_2 - V_1)$), then isochoric cooling back to $T$ (no
    work).

  At the shared final volume the isobar runs at pressure $p_1 > p_2$,
  so $W' = n R T (V_2 - V_1) / V_1 > n R T ln(V_2/V_1) = W$: the
  two-step path delivers more work, because it runs at a higher
  pressure throughout. Same endpintegral.conts, ∂erent work — the visual
  statement of @fig:work-path.
] <ex:path-dependence>

#figure(
  grid(
    columns: 2,
    column-gutter: 6%,
    image("img/work-path-left.svg", width: 100%), image("img/work-path-right.svg", width: 100%),
  ),
  caption: [Left: three quasi-static paths from state 1 to state 2 in
    the $p$-$V$ plane; the work done by the gas is the area under the
    path, and the three shaded areas ∂er. Right: through the same
    state, the adiabat $p V^gamma = "const"$ ($gamma > 1$) is steeper
    than the isotherm $p V = "const"$; the adiabatic compression from 1
    to $2'$ therefore reaches a higher pressure than the isothermal
    compression to 2.],
  placement: auto,
  supplement: [Fig.],
) <fig:work-path>

#definition(name: "Heat")[
  Energy that crosses the boundary of a system by virtue of a
  temperature ∂erence with the environment is *heat*, denoted $Q$
  (positive when absorbed by the system). Heat is energy *in transit*:
  a body does not *contain* heat, any more than it contains work.
] <def:heat>

The distinction from work is one of mechanism, not of substance: the
same energy transfer can be realised as work with a frictionless piston
or as heat with a thermostat, and mixtures of the two occur in general.

#caution[
  (Path functions.) Work and heat are *process quantities*: $delta W$
  and $delta Q$ are inexact ∂erentials, and writing $dif W$ or
  speaking of "the heat contained in a body" is a category error that
  invalidates calculations. Only increments are defined, and the
  integrals $integral delta W$, $integral delta Q$ are path integrals
  to be evaluated along a specified curve. State quantities ($U$, $H$,
  and later $S$) ∂er precisely in having exact ∂erentials.
] <caution:path-functions>

== First Law and Internal Energy // 第一定律与内能

#definition(name: "Internal Energy")[
  Every equilibrium state of a system admits a state quantity $U$, the
  *internal energy*, such that the energy the system receives in any
  process equals the increase of $U$ between the endpintegral.cont states. $U$
  is extensive, and is defined up to an additive constant (only
  ∂erences $Delta U$ are measurable).
] <def:internal-energy>

The physical motivation is Joule's paddle-wheel experiment: stir an
insulated (adiabatic) vessel with a falling weight, and a given amount
of mechanical work always raises the state — measured by any thermometer
— identically, regardless of how the stirring is arranged. The
endpintegral.conts are characterised by a number $U$.

#theorem(name: "First Law of Thermodynamics")[
  For any process of a closed system,
  $
    Delta U = Q + W,
  $
  where $Q$ is the heat absorbed and $W$ the work done *on* the system
  (equivalently, $Delta U = Q - W_("by")$). For infinitesimal
  quasi-static processes of a simple compressible system,
  $
    dif U = delta Q - p dif V.
  $
] <thm:first-law>

In words: energy is conserved once both transfer channels are counted;
$U$ is the bookkeeping quantity whose increases balance the net inflow.
Every perpetual-motion machine of the first kind — one producing work
from nothing — is ruled out.

#definition(name: "Heat Capacities")[
  The *heat capacities* measure the heat required per unit temperature
  change along a specified path:
  $
    C_V = (∂ Q)_V / (dif T) = (∂ U / ∂ T)_V, quad
    C_p = (∂ Q)_p / (dif T) = (∂ H / ∂ T)_p,
  $
  the second equality of each defining the constant-volume and
  constant-pressure heat capacities through the state functions $U$ and
  $H$ of §2.5. They are extensive; per unit amount of substance they
  become the molar quantities $c_V$, $c_p$.
] <def:heat-capacities>

For a dilute gas, the kinetic theory of Chapter 1 already computed
$C_V = f/2 R$ from #link(<thm:equipartition>)[the equipartition
  theorem]; §2.4 and §2.5 treat $C_V$ and $C_p$ as thermodynamic
quantities, defined for any substance.

#property(name: "Joule's Law: Internal Energy of an Ideal Gas")[
  The internal energy of an ideal gas depends on temperature alone:
  $
    U = U(T) quad "and hence" quad C_V = (dif U) / (dif T).
  $
] <prop:joule-law>

*Justification.* Experimentally, Joule's free-expansion measurement
(§2.6) found no temperature change when a dilute gas expanded into a
vacuum, suggesting $U$ is independent of $V$. Kinetically, the
internal energy is the sum of molecular kinetic energies,
$U = f/2 N k_B T$ by #link(<thm:equipartition>)[equipartition], with
no dependence on the intermolecular distance because an ideal gas has
no intermolecular potential energy at all. The full thermodynamic
identity $(∂ U / ∂ V)_T = T (∂ p / ∂ T)_V - p$, from which
Joule's law follows in one line for an ideal gas, is derived with the
Maxwell relations in Chapter 4.

== Enthalpy and the Heat Capacity Relation // 焓与热容关系

#definition(name: "Enthalpy")[
  The *enthalpy* of a system is the state function
  $
    H = U + p V.
  $
  For a quasi-static isobaric process, $dif H = delta Q$, i.e. the heat
  absorbed equals the enthalpy increase:
  $
    dif H = dif U + p dif V + V dif p = delta Q + V dif p = delta Q
    quad "at" dif p = 0.
  $
  $H$ is extensive and is the natural energy bookkeeping for processes
  at fixed ambient pressure — the laboratory condition.
] <def:enthalpy>

The term $p V$ is the *flow work* an element of fluid must expend to
push its way into (or that is done on it by fluid behind it in) a
pipeline; this is why enthalpy, not internal energy, is the conserved
per-mass quantity in steady-flow devices, and it is the quantity whose
changes measure reaction heats in chemistry.

#property(name: "The Relation between C_p and C_V")[
  For any simple compressible system,
  $
    C_p - C_V = T V alpha^2 / kappa_T > 0,
  $
  where
  $
    alpha = 1/V (partial V / partial T)_p quad "and" quad
    kappa_T = - 1/V (partial V / partial p)_T
  $
  are the thermal expansion coefficient and the isothermal
  compressibility. For an ideal gas the relation collapses to
  $
    C_p - C_V = n R.
  $
] <prop:cp-cv>

*Derivation.* Start from $U = U(T, V)$ and
$C_V = (partial U / partial T)_V$. Then for any quasi-static process
$
  delta Q = dif U + p dif V
  = C_V dif T + [(partial U / partial V)_T + p] dif V.
$
At constant pressure, $dif V = (partial V / partial T)_p dif T$, so
$
  C_p = C_V + [(partial U / partial V)_T + p] (partial V / partial T)_p.
$
The bracket is rewritten using the identity (proved in Chapter 4 with
the Maxwell relations)
$
  (partial U / partial V)_T = T (partial p / partial T)_V - p,
$
so the bracket becomes $T (partial p / partial T)_V$. With the cyclic
identity $(partial p / partial T)_V = alpha / kappa_T$ and
$(partial V / partial T)_p = alpha V$,
$
  C_p - C_V = T dot alpha / kappa_T dot alpha V = T V alpha^2 / kappa_T.
$
For the ideal gas, $p = n R T / V$ gives $alpha = 1/T$ and
$kappa_T = 1/p$, hence $C_p - C_V = T V (1/T^2) p = n R$.

The inequality $C_p > C_V$ has a direct reading: heating at constant
pressure must pay for the expansion work in addition to raising the
internal energy. The ratio $gamma = C_p / C_V$ governs the adiabatic
processes of §2.6.

== Applications: Free Expansion, Adiabatic Process and Throttling // 应用：自由膨胀、绝热过程与节流

#example[
  (Adiabatic free expansion.) An ideal gas initially at $(T_1, V_1)$
  expands into a vacuum inside an insulated vessel, reaching volume
  $V_2$. No work is done ($dif V$ of the *system* is unresisted; the
  process is not quasi-static, but $W = 0$ regardless), and no heat
  flows ($Q = 0$ by insulation). The first law gives
  $
    Delta U = 0 quad "and hence" quad T_2 = T_1
  $
  by #link(<prop:joule-law>)[Joule's law]. The free expansion is
  *irreversible* — a fact invisible to the first law, whose explanation
  requires the entropy of Chapter 3. (For a real gas the temperature
  changes slightly: the fingerprint of intermolecular forces.)
] <ex:free-expansion>

#property(name: "Quasi-Static Adiabatic Process")[
  A quasi-static adiabatic process ($delta Q = 0$) of an ideal gas with
  constant heat capacities obeys
  $
    p V^gamma = "const", quad T V^(gamma - 1) = "const", quad
    T^gamma p^(1 - gamma) = "const",
  $
  where $gamma = C_p / C_V > 1$.
] <prop:adiabatic-process>

*Derivation.* The first law with $delta Q = 0$ gives
$C_V dif T = - p dif V$. Substituting $p = n R T / V$ and dividing by
$T$,
$
  C_V (dif T) / T = - n R (dif V) / V
  quad "with" quad n R = C_p - C_V = (gamma - 1) C_V,
$
so $(dif T) / T = -(gamma - 1)(dif V) / V$, which integrates to
$T V^(gamma - 1) = "const"$; eliminating $T$ with the equation of state
gives the $p V^gamma$ and $T^gamma p^(1-gamma)$ forms.

On the $p$-$V$ diagram the adiabat through a pintegral.cont is *steeper* than
the isotherm through the same pintegral.cont, since
$(partial p / partial V)_("adiabatic") = gamma (partial p / partial V)_T$
and $gamma > 1$: expansion cools the gas, so its pressure falls faster
than isothermally — see @fig:work-path, right panel. Correspondingly,
adiabatic compression to a given volume attains a higher pressure and a
higher temperature than isothermal compression.

#definition(name: "Joule-Thomson (Throttle) Coefficient")[
  In a *throttling process*, a fluid is pushed steadily through a
  porous plug or fine valve; for each element of fluid the process is
  adiabatic, and steady-flow bookkeeping shows it is *isenthalpic*:
  $
    H_1 = H_2.
  $
  The temperature response is quantified by the *Joule-Thomson
  coefficient*
  $
    mu_("JT") = (partial T / partial p)_H.
  $
] <def:jt-coefficient>

*Derivation.* Treat $H = H(T, p)$: at constant $H$,
$
  0 = (partial H / partial T)_p dif T + (partial H / partial p)_T dif p
  quad "so" quad
  mu_("JT") = - (partial H / partial p)_T / C_p.
$
With $H = U + p V$ and the identity
$(partial U / partial p)_T = - T (partial V / partial T)_p - p (partial V / partial p)_T$ (Chapter 4),
$
  mu_("JT") = 1/C_p [T (partial V / partial T)_p - V] = V / C_p (T alpha - 1).
$

#example[
  (Cooling by throttling.) For an ideal gas, $alpha = 1/T$, so
  $mu_("JT") = 0$: throttling changes no temperature, consistent with
  the absence of intermolecular energy. For real gases, at moderate
  temperatures $T alpha > 1$ and $mu_("JT") > 0$: expansion (pressure
  drop) *cools* the gas — nitrogen and oxygen cool at room temperature,
  which is the operating principle of the Linde liquefaction cycle;
  hydrogen and helium have $mu_("JT") < 0$ at room temperature and
  must be pre-cooled below their inversion temperature first. The
  inversion curve in the $T$-$p$ plane, separating the cooling and
  heating regions, is a van der Waals prediction revisited in
  Chapter 20.
] <ex:throttling>

#note[
  (Liquefaction.) The throttling cooler is the core of gas liquefaction
  technology, and its efficiency analysis couples to the phase
  behaviour of real gases. The inversion curve, the liquefaction
  cycle, and the critical-pintegral.cont physics behind them are treated in
  Chapter 20 on phase transitions.
] <note:jt-liquefaction>

= Second Law of Thermodynamics // 热力学第二定律

The first law forbids energy non-conservation; it says nothing about
*direction*. Yet nature is full of one-way streets: heat flows hot to
cold and never back, gases expand freely but never recompress,
frictional heat never re-concentrates. The second law selects, among
all first-law-compliant processes, those actually allowed — and
thereby produces the entropy, the quantity that grades the direction.

== Clausius and Kelvin-Planck Statements // 克劳修斯与开尔文-普朗克表述

#definition(name: "Thermal Reservoir and Heat Engine")[
  A *thermal reservoir* is an idealised body of fixed temperature whose
  state is unaltered by exchanging any finite amount of heat. A *heat
  engine* is a cyclic device that absorbs heat $Q_h$ from a hot
  reservoir at $T_h$, rejects heat $Q_c$ to a cold reservoir at
  $T_c < T_h$, and delivers net work $W = Q_h - Q_c$ per cycle;
  a *refrigerator* (or heat pump) is the same device run backwards.
] <def:heat-engine>

#figure(
  image("img/reservoir-schematic.svg", width: 88%),
  caption: [Left: a heat engine absorbing $Q_h$ from the hot reservoir,
    delivering work $W$ and rejecting $Q_c$ to the cold reservoir. Right:
    the same device run as a refrigerator, consuming work $W$ to pump
    heat $Q_c$ from the cold to the hot reservoir.],
  placement: auto,
  supplement: [Fig.],
) <fig:reservoir-schematic>

Experience: no cyclic device absorbs heat from a single reservoir and
converts it entirely into work, however ingeniously designed. This
regularity is elevated to a law in two equivalent formulations.

#theorem(name: "Kelvin-Planck Statement")[
  No process is possible whose sole result is the complete conversion
  of heat, extracted from a single thermal reservoir, into work.
] <thm:kelvin-planck>

#caution[
  (Perpetual motion of the second kind.) An engine violating
  #link(<thm:kelvin-planck>)[the Kelvin-Planck statement] would be a
  *perpetual motion machine of the second
  kind*: it respects energy conservation (extracting heat from the
  ocean would power a ship forever) yet is impossible. The first law
  rules out machines of the first kind; the second law is genuinely new
  physics. Isothermal expansion of an ideal gas does convert heat to
  work completely — but it is not cyclic: the gas ends up at larger
  volume, and the *sole* result clause forbids exactly such leftover
  changes.
] <caution:perpetual-motion-ii>

#theorem(name: "Clausius Statement")[
  No process is possible whose sole result is the transfer of heat
  from a colder body to a hotter body.
] <thm:clausius-statement>

Note that a refrigerator *does* pump heat from cold to hot — but only
at the cost of work input, so the *sole* result clause is not violated.
The two statements look different; they are the same law.

#theorem(name: "Equivalence of the Two Statements")[
  The Kelvin-Planck statement and the Clausius statement are
  equivalent: a device violating one can be combined with ordinary
  devices to violate the other.
] <thm:statement-equivalence>

*Proof.* ($"KP" ==>$ $"C"$) Suppose a device $X$ violates the Clausius
statement: it transfers $Q$ from the cold to the hot reservoir with no
other effect. Couple it to an ordinary heat engine $E$ that absorbs
$Q_h$ from the hot reservoir, rejects exactly $Q$ to the cold one, and
delivers $W = Q_h - Q$. The composite takes $Q_h - Q$ as heat from the
single hot reservoir and delivers the same work, violating the
Kelvin-Planck statement.

($"C" ==>$ $"KP"$) Symmetrically, suppose a device $X$ violates
Kelvin-Planck: it absorbs $Q_h$ from the hot reservoir and converts it
entirely into work $W$. Run $W$ into an ordinary refrigerator $R$
pumping $Q_c$ from the cold reservoir and dumping $Q_c + W$ into the
hot one. The composite transfers $Q_c$ from cold to hot with no other
effect — violating the Clausius statement. ⊙

== Carnot's Theorem // 卡诺定理

#definition(name: "Carnot Cycle")[
  The *Carnot cycle* is the reversible cycle of an ideal gas consisting
  of four quasi-static legs:
  $
    a -> b quad "isothermal expansion at" T_h,
  $
  absorbing $Q_h = n R T_h ln(V_b / V_a)$ from the hot reservoir;
  $
    b -> c quad "adiabatic expansion," T_h -> T_c;
  $
  $
    c -> d quad "isothermal compression at" T_c,
  $
  rejecting $Q_c = n R T_c ln(V_c / V_d)$ to the cold reservoir;
  $
    d -> a quad "adiabatic compression," T_c -> T_h,
  $
  closing the cycle.
] <def:carnot-cycle>

#property(name: "Carnot Efficiency")[
  The efficiency of a Carnot engine depends only on the two reservoir
  temperatures:
  $
    eta_C = 1 - T_c / T_h.
  $
] <prop:carnot-efficiency>

*Derivation.* Work and heat per cycle: $W = Q_h - Q_c$ with
$Q_h, Q_c$ as above. The two adiabatic legs of
#link(<prop:adiabatic-process>)[the quasi-static adiabatic relation]
give $T_h V_b^(gamma-1) = T_c V_c^(gamma-1)$ and
$T_c V_d^(gamma-1) = T_h V_a^(gamma-1)$; dividing,
$
  (V_b / V_a)^(gamma - 1) = (V_c / V_d)^(gamma - 1)
  quad "hence" quad V_b / V_a = V_c / V_d.
$
Therefore
$
  eta_C = 1 - Q_c / Q_h
  = 1 - (T_c ln(V_c/V_d)) / (T_h ln(V_b/V_a))
  = 1 - T_c / T_h.
$

#theorem(name: "Carnot's Theorem")[
  All reversible engines operating between the same two reservoirs
  have the same efficiency $eta_C = 1 - T_c \/ T_h$; every irreversible
  engine operating between them has strictly smaller efficiency.
] <thm:carnot-theorem>

*Proof.* Let $I$ be any engine between the reservoirs, and $R$ a
Carnot (reversible) engine run *backwards* as a refrigerator, sized so
that it absorbs exactly the heat $Q_c$ that $I$ rejects. The composite
$I R$ then delivers work
$
  W = Q_h - Q_c - (Q_h' - Q_c) = Q_h - Q_h',
$
takes no net heat from the cold reservoir, and extracts net heat
$Q_h - Q_h'$ from the hot one. If $eta_I > eta_R$, then
$Q_h' / Q_c > Q_h / Q_c$, i.e. $Q_h' > Q_h$: the composite would be a
sole-result work producer from one reservoir — violating
#link(<thm:kelvin-planck>)[Kelvin-Planck]. Hence
$eta_I <= eta_R$. If $I$ is irreversible, running a *reversible* $R$
forward and $I$ backward in the same coupling (now with roles swapped)
yields the strict inequality $eta_I < eta_R$; equality would make the
composite reversible, forcing $I$ itself reversible. ⊙

#figure(
  image("img/carnot-cycle.svg", width: 78%),
  caption: [The Carnot cycle in the $p$-$V$ plane: isothermal expansion
    $a -> b$ at $T_h$ (absorbing $Q_h$), adiabatic expansion $b -> c$
    to $T_c$, isothermal compression $c -> d$ (rejecting $Q_c$), and
    adiabatic compression $d -> a$. The enclosed area is the net work
    per cycle.],
  placement: auto,
  supplement: [Fig.],
) <fig:carnot-cycle>

Carnot's theorem caps every real engine: no cleverness of design beats
$1 - T_c / T_h$ — the only levers are the reservoir temperatures. What
remains is to convert this cap into a state function, which is the
business of §3.3.

== Entropy and the Clausius Inequality // 熵与克劳修斯不等式

#property(name: "Clausius Inequality")[
  For any cyclic process of a closed system,
  $
    integral.cont (delta Q) / T <= 0,
  $
  where $delta Q$ is the heat absorbed by the system at each stage and
  $T$ is the temperature *at the boundary* where the heat is exchanged.
  Equality holds if and only if the cycle is reversible.
] <prop:clausius-inequality>

*Proof.* Decompose an arbitrary cycle into a fine mesh: each elementary
strip exchanges heat $delta Q_i$ with reservoirs whose temperatures
match the boundary temperature $T_i$. By
#link(<thm:carnot-theorem>)[Carnot's theorem], a reversible engine
working between $T_i$ and a reference temperature $T_0$ satisfies
$delta W_i = delta Q_i (1 - T_0 / T_i)$, while the actual strip
delivers at most this work: $delta Q_i (1 - T_0 / T_i) >= delta W_i$.
Summing over the whole cycle and using $sum delta W_i = integral.cont delta Q$
(gross heat minus gross work balance of the cycle),
$
  integral.cont delta Q - T_0 integral.cont (delta Q) / T >= integral.cont delta Q
  quad "hence" quad integral.cont (delta Q) / T <= 0.
$
Equality holds exactly when every elementary engine is reversible,
i.e. the cycle is reversible; for an irreversible cycle the inequality
is strict. ⊙

#definition(name: "Entropy")[
  The *entropy* of a system is the state function $S$ whose change
  between two nearby equilibrium states is
  $
    dif S = (delta Q_("rev")) / T,
  $
  the heat absorbed in a *reversible* path divided by the common
  temperature. For a finite reversible path,
  $
    Delta S = integral^(("rev")) (delta Q) / T.
  $
] <def:entropy>

That $S$ exists — that the integral is path-independent — follows from
the equality case of #link(<prop:clausius-inequality>)[the Clausius
  inequality]:

#property(name: "Entropy Is a State Function")[
  For any reversible cycle, $integral.cont_("rev") (delta Q) / T = 0$.
  Consequently $integral (delta Q) / T$ along reversible paths depends
  only on the endpintegral.conts, and $S$ is well-defined as a state quantity.
] <prop:entropy-state-function>

*Proof.* Every reversible cycle satisfies the Clausius inequality with
equality. Given any two states $A, B$, the integral along a reversible
path is therefore independent of which reversible path is chosen — for
two such paths form a reversible cycle. ⊙

The entropy of an irreversible process is *not* obtained by
integrating $delta Q / T$ along that process; one integrates along any
*reversible* path connecting the same endpintegral.conts.

#example[
  (Entropy of an ideal gas.) For a reversible change of $n$ moles,
  $delta Q = dif U + p dif V = C_V dif T + n R T (dif V) / V$, so
  $
    dif S = C_V (dif T) / T + n R (dif V) / V,
  $
  and integrating,
  $
    Delta S = C_V ln(T_2 / T_1) + n R ln(V_2 / V_1).
  $
  Between any two states this formula holds — including for
  irreversible changes between them, since only the endpintegral.conts enter.
] <ex:entropy-ideal-gas>

#caution[
  ($delta Q \/ T$ versus $dif S$.) Only on a reversible path is
  $delta Q = T dif S$. Along an irreversible path the absorbed heat is
  smaller than $integral T dif S$ (for the same endpintegral.conts), and writing
  $dif S = delta Q \/ T$ for an irreversible step silently shrinks the
  entropy. The safe route is always: compute $Delta S$ on a reversible
  path between the endpintegral.conts, regardless of how the actual process
  ran.
] <caution:heat-vs-entropy>

== Entropy and Irreversibility // 熵与不可逆性

#note[
  (Reversibility, formally.) A process is *reversible* if the system
  and the environment can be restored to their initial states with no
  other change. This was anticipated in
  #link(<def:quasi-static-process>)[Chapter 2]: quasi-statics plus the
  absence of dissipative effects (friction, unhindered heat flow
  across finite temperature differences, free expansion) is the
  practical recipe for reversibility. Every irreversibility mechanism
  generates entropy, as the theorem below makes quantitative.
] <note:reversibility-defined>

#theorem(name: "Principle of Entropy Increase")[
  For any process of an isolated system,
  $
    Delta S >= 0 quad "with equality iff the process is reversible."
  $
  Equivalently, for any process whatsoever,
  $
    Delta S_("system") + Delta S_("environment") >= 0.
  $
] <thm:entropy-increase>

*Proof.* Take an irreversible process carrying an isolated system from
$A$ to $B$; the Clausius inequality applied to the cycle formed by the
actual process and an arbitrary reversible return path $B -> A$ gives
$
  integral_A^B (delta Q) / T + integral_B^A (delta Q_("rev")) / T <= 0,
$
and the first integral vanishes ($delta Q = 0$ in isolation), so
$Delta S = S_B - S_A >= 0$, strict for the irreversible process. For a
non-isolated system, enlarge the boundary: system plus environment is
isolated, and their entropy sum obeys the same inequality. ⊙

#example[
  (Free expansion, explained.) An ideal gas doubling its volume in
  adiabatic free expansion (§2.6: $W = Q = 0$, $Delta U = 0$, hence
  $T$ unchanged) has entropy change — computed on the reversible
  isothermal path between the same endpintegral.conts —
  $
    Delta S = n R ln(V_2 / V_1) = n R ln 2 > 0.
  $
  The first law saw nothing ($Delta U = 0$); the entropy increase
  declares the process irreversible and predicts it never runs
  backwards. This fulfils the promissory note of
  #link(<ex:free-expansion>)[the free-expansion example].
] <ex:free-expansion-entropy>

#example[
  (Heat conduction.) Heat $Q$ flows directly from a body at $T_h$ to a
  body at $T_c < T_h$. Each body changes at fixed temperature, so
  $
    Delta S = Q / T_c - Q / T_h = Q (1/T_c - 1/T_h) > 0:
  $
  conduction across a finite temperature difference generates entropy
  — precisely why it is irreversible, and why reversible heat exchange
  requires reservoirs differing infinitesimally.
] <ex:heat-transfer-entropy>

#caution[
  (Entropy of non-isolated systems.) The entropy of a *system* may
  decrease: a refrigerator pumps heat out of its cold box, freezing
  water crystallises, living organisms build order — each at the price
  of exporting more entropy to the environment. The principle
  constrains only the *total*: $Delta S_("system") + Delta S_("environment") >= 0$
  holds without exception.
] <caution:entropy-nonisolated>

#note[
  (Statistical meaning.) The molecular origin of entropy was
  anticipated by the kinetic theory of Chapter 1: Boltzmann's
  $H$-function decreases monotonically in collisions, and
  #link(<note:h-statistical>)[its interpretation] as a negative
  logarithm of molecular disorder prefigures the identity
  $
    S = k_B ln W,
  $
  where $W$ counts the microscopic configurations compatible with the
  macrostate. Free expansion then increases entropy because more
  microstates fit the larger volume; the second law becomes a
  probability statement. The rigorous construction — microstates,
  ensembles, and the derivation of all thermodynamic potentials — is
  the programme of Part III (Chapters 12-13).
] <note:statistical-meaning>

== Thermodynamic Temperature Scale // 热力学温标

The efficiency bound $eta_C = 1 - T_c \/ T_h$ rests on the temperatures
of the reservoirs — but which temperature? The ideal-gas scale of
#link(<prop:ideal-gas-scale>)[§2.2] referenced a particular substance.
Carnot's theorem offers something better: a temperature scale defined
by the second law itself, independent of any material.

#theorem(name: "Absolute (Kelvin) Temperature Scale")[
  For reversible engines operating between two reservoirs, the ratio
  of the exchanged heats depends only on the reservoirs:
  $
    Q_h / Q_c = f(theta_h, theta_c),
  $
  where $theta$ denotes any empirical temperatures. This allows the
  *absolute temperature* $T$ to be defined — up to a multiplicative
  constant — as the unique quantity satisfying
  $
    Q_h / Q_c = T_h / T_c
  $
  for every reversible engine between the reservoirs.
] <thm:absolute-scale>

*Derivation.* Let two reversible engines $R_1$ (between $theta_1,
theta_2$) and $R_2$ (between $theta_2, theta_3$) be coupled, with
$R_2$ consuming exactly what $R_1$ rejects at $theta_2$. The composite
is a reversible engine between $theta_1$ and $theta_3$, so
$
  f(theta_1, theta_3) = f(theta_1, theta_2) dot f(theta_2, theta_3).
$
With $theta_3$ fixed as a reference, the left side is independent of
$theta_2$; hence $f(theta_1, theta_2)$ must factor as
$phi(theta_1) / phi(theta_2)$ for a single function $phi$. Choosing
$T := c dot phi(theta)$ (constant fixed by convention) gives
$Q_h / Q_c = T_h / T_c$. ⊙

The reference constant is fixed by assigning $T = 273.16 "K"$ to the
triple point of water — the same convention as the gas scale.

#property(name: "Equivalence of the Carnot and Ideal-Gas Scales")[
  The absolute temperature of #link(<thm:absolute-scale>)[the Carnot
    definition] coincides with the ideal-gas temperature of
  #link(<prop:ideal-gas-scale>)[§2.2].
] <prop:scales-equivalence>

*Proof.* Compute the Carnot cycle of #link(<def:carnot-cycle>)[§3.2]
using the *gas* scale $theta$ throughout the equation of state
$p V = n R theta$: the derivation of
#link(<prop:carnot-efficiency>)[the Carnot efficiency] never used any
property of $T$ beyond the equation of state, and it produced
$
  Q_h / Q_c = theta_h / theta_c.
$
Thus the gas scale satisfies the defining relation of the absolute
scale; both scales fix the same value at the triple point of water, so
they are identical. ⊙

This closes the account opened in #link(<note:kelvin-scale>)[§2.2]:
temperature now rests on the second law alone, and every thermometer —
gas, resistance, or otherwise — measures the same $T$.

== Heat Engines and Refrigeration Cycles // 热机与制冷循环

#definition(name: "Efficiency and Coefficients of Performance")[
  For a heat engine absorbing $Q_h$ and delivering $W = Q_h - Q_c$ per
  cycle, the *efficiency* is
  $
    eta = W / Q_h.
  $
  For a refrigerator pumping $Q_c$ out of the cold space at a work
  cost $W = Q_h - Q_c$, the *coefficient of performance* is
  $
    "COP"_R = Q_c / W;
  $
  for a heat pump delivering $Q_h$ into the warm space,
  $
    "COP"_"HP" = Q_h / W.
  $
  (COP can exceed 1; efficiency cannot.)
] <def:efficiency-cop>

#property(name: "Carnot Bounds")[
  Any engine between reservoirs at $T_h, T_c$ satisfies
  $
    eta <= 1 - T_c / T_h, quad
    "COP"_R <= T_c / (T_h - T_c), quad
    "COP"_"HP" <= T_h / (T_h - T_c),
  $
  with equality exactly for reversible (Carnot) devices.
] <prop:carnot-bounds>

*Derivation.* The efficiency bound is
#link(<thm:carnot-theorem>)[Carnot's theorem] itself. For a
refrigerator, run the same accounting in reverse: a refrigerator with
$"COP"_R > T_c / (T_h - T_c)$, driven by a Carnot engine of efficiency
$eta_C$ fed by the same heat $Q_h' = W$, would form a composite
transferring heat from cold to hot with no other effect — violating
#link(<thm:clausius-statement>)[the Clausius statement]. The heat-pump
bound follows from $"COP"_"HP" = "COP"_R + 1$. ⊙

#example[
  (Numerical work-out.) A Carnot engine operates between $T_h = 600
  "K"$ and $T_c = 300 "K"$ with $Q_h = 1000 "J"$ per cycle:
  $
    eta_C = 1 - 300 / 600 = 0.5, quad W = 500 "J", quad Q_c = 500 "J".
  $
  A real engine between the same reservoirs at $eta = 0.35$ wastes
  part of the Carnot potential to friction and finite-rate heat
  exchange. The same temperature gap run as a Carnot refrigerator
  gives
  $
    "COP"_R = T_c / (T_h - T_c) = 1, quad
    W = 500 "J" quad "to extract" quad Q_c = 500 "J".
  $
  Note how the numbers expose the asymmetry the definitions encode:
  the same reservoir pair yields $eta < 1$ but $"COP"_R$ of order
  $T_c / (T_h - T_c)$, which can far exceed 1 for narrow gaps — the
  reason refrigeration is cheap and engine power is not.
] <ex:engine-numerical>

The Carnot bound is the engineering face of the second law: efficiency
is bought with temperature, not with mechanical ingenuity. The
thermodynamic potentials of Chapter 4 — free energy and free enthalpy —
will carry the same accounting to non-cyclic processes.

// ==========================================================================
// Thermodynamique (热力学与统计力学) — Table of Contents
// ==========================================================================
//
// 主线叙事: "宏观经验 → 热力学框架 → 统计力学桥梁 → 量子统计 → 相互作用与非平衡"
//
// 从气体分子运动论的直观图像出发，建立热力学三大定律的宏观经验框架；
// 通过热力学势与勒让德变换构建完整的数学结构；然后搭建从微观到宏观
// 的桥梁——系综理论；引入量子统计处理全同粒子系统；最终推广到相互作用
// 系统（相变）和非平衡过程（输运与耗散）。
//
// 参考教材:
//   - Callen, H.B. "Thermodynamics and an Introduction to Thermostatistics" (2nd ed.)
//   - Landau & Lifshitz, "Statistical Physics" (Course of Theoretical Physics Vol.5)
//   - Pathria & Beale, "Statistical Mechanics" (3rd ed.)
//   - Reif, F. "Fundamentals of Statistical and Thermal Physics"
//
// 职责边界:
//   - 变分法、哈密顿原理、泊松括号、辛结构 → Mécanique analytique
//   - 相空间、刘维尔定理、遍历性 → Mécanique analytique (Part III-IV)
//     本笔记 Ch 11 简要回顾 + 交叉引用，自包含推导
//   - 相对论运动学（洛伦兹变换等）→ Électrodynamique (Part VII)
//     本笔记 Ch 5 直接使用结果，不重新推导
//   - 黑体辐射（经典电磁推导）→ Électrodynamique
//     本笔记从统计力学角度推导（Planck 定律）
//   - 布朗运动、朗之万方程的深入处理 → Processus Stochastique
//     本笔记 Ch 23 简要引入 + 交叉引用
//
// ==========================================================================
// --- Part I: Kinetic Theory and Classical Thermodynamics ---
// --- (气体动力学理论与经典热力学) ---
// ==========================================================================
//
// 设计思路: 从微观模型（气体分子运动论）和宏观经验（热力学定律）两条线索
// 并行出发，建立热力学的基本概念框架。末尾引入相对论热力学作为经典框架
// 的自然延伸，为后续统计力学做铺垫。
// 对应教材: Callen Ch 1; Reif Ch 1-5; Landau §7-16

// --- Chapter 1: Kinetic Theory of Gases (气体分子运动论) ---

//   Section 1.1: Ideal Gas Law and Equation of State (理想气体定律与状态方程)
//     - 状态变量 (p, V, T) 与状态方程的概念
//     - 理想气体状态方程 pV = nRT
//     - 常见状态方程: van der Waals, Dieterici, 维里展开简介
//     - 等温线、等压线、等容线与 PV 图

//   Section 1.2: Maxwell-Boltzmann Velocity Distribution (麦克斯韦-玻尔兹曼速度分布)
//     - 速度分布函数的推导（各向同性 + 分量独立性）
//     - 最概然速率、平均速率、方均根速率
//     - 能量分布与速率分布
//     - 实验验证: Stern 实验

//   Section 1.3: Mean Free Path and Collision Frequency (平均自由程与碰撞频率)
//     - 分子碰撞截面
//     - 平均自由程的推导
//     - 碰撞频率与碰撞数

//   Section 1.4: Energy Equipartition Theorem (能量均分定理)
//     - 自由度与二次型能量
//     - 均分定理的表述与推导
//     - 对理想气体热容的应用
//     - 均分定理的局限性

//   Section 1.5: Transport Phenomena (输运现象：粘滞、热传导、扩散)
//     - 粘滞现象与粘滞系数
//     - 热传导与热导率
//     - 扩散现象与扩散系数
//     - 输运系数的动力学理论推导

//   Section 1.6: Boltzmann H-Theorem and Irreversibility (玻尔兹曼 H 定理与不可逆性)
//     - H 函数的定义
//     - H 定理的推导
//     - 可逆性佯谬 (Loschmidt) 与回归性佯谬 (Zermelo)
//     - H 定理的统计诠释

// --- Chapter 2: Zeroth and First Laws of Thermodynamics (热力学第零与第一定律) ---

//   Section 2.1: Thermodynamic Systems and State Variables (热力学系统与状态变量)
//     - 系统、环境、边界
//     - 广延量与强度量
//     - 平衡态与准静态过程
//     - 热力学公理化基础 (Callen 公设)

//   Section 2.2: Zeroth Law and Temperature (第零定律与温度)
//     - 热平衡的传递性
//     - 经验温度的定义
//     - 理想气体温标
//     - 绝对温标 (开尔文)

//   Section 2.3: Work and Heat in Thermodynamic Processes (热力学过程中的功与热)
//     - 体积功与一般功的形式
//     - 热量的定义
//     - 准静态过程中的功与热
//     - 热与功的路径依赖性

//   Section 2.4: First Law: Internal Energy (第一定律：内能)
//     - 第一定律的表述
//     - 内能作为状态函数
//     - 热容: C_V 与 C_p
//     - 绝热过程

//   Section 2.5: Heat Capacity and Enthalpy (热容与焓)
//     - 定容热容与定压热容的关系
//     - 焓的定义与物理意义
//     - 焦耳-汤姆孙效应

//   Section 2.6: Applications (应用：绝热过程与节流过程)
//     - 理想气体的绝热自由膨胀
//     - 理想气体的准静态绝热过程
//     - 节流过程与焦耳-汤姆孙系数

// --- Chapter 3: Second Law of Thermodynamics (热力学第二定律) ---

//   Section 3.1: Clausius and Kelvin-Planck Statements (克劳修斯与开尔文-普朗克表述)
//     - 两种经典表述
//     - 两种表述的等价性证明

//   Section 3.2: Carnot's Theorem (卡诺定理)
//     - 卡诺循环
//     - 卡诺定理的表述与证明
//     - 卡诺效率

//   Section 3.3: Entropy and the Clausius Inequality (熵与克劳修斯不等式)
//     - 克劳修斯不等式 ∮ δQ/T ≤ 0
//     - 熵的定义: dS = δQ_rev / T
//     - 熵是状态函数的证明
//     - 熵的计算方法

//   Section 3.4: Entropy and Irreversibility (熵与不可逆性)
//     - 熵增原理
//     - 不可逆过程中的熵变计算
//     - 热力学第二定律的统计意义概述

//   Section 3.5: Thermodynamic Temperature Scale (热力学温标)
//     - 基于卡诺循环的绝对温标
//     - 与理想气体温标的等价性

//   Section 3.6: Heat Engines and Refrigeration Cycles (热机与制冷循环)
//     - 热机效率
//     - 制冷系数与热泵系数
//     - 典型循环: Otto, Diesel, Brayton

// --- Chapter 4: Third Law of Thermodynamics (热力学第三定律) ---

//   Section 4.1: Nernst Heat Theorem (能斯特热定理)
//     - 能斯特定理的表述
//     - 低温极限下热容的行为

//   Section 4.2: Planck Formulation and Absolute Entropy (普朗克表述与绝对熵)
//     - S → 0 当 T → 0
//     - 绝对熵的计算
//     - 标准熵与热力学数据表

//   Section 4.3: Unattainability of Absolute Zero (绝对零度不可达性)
//     - 不可达性原理
//     - 绝热去磁制冷

//   Section 4.4: Low-Temperature Phenomena and Residual Entropy (低温现象与残余熵)
//     - 残余熵的来源 (构型无序)
//     - CO 冰、冰的残余熵

//   Section 4.5: Negative Temperatures (负温度)
//     - 自旋系统的负温度
//     - 负温度比无限高温更"热"
//     - 负温度系统的存在条件

// --- Chapter 5: Relativistic Thermodynamics (相对论热力学) ---

//   Section 5.1: Thermodynamics of the Relativistic Ideal Gas (相对论理想气体的热力学)
//     - 相对论能量-动量关系
//     - 极端相对论与极端非相对论极限
//     - 相对论理想气体的状态方程

//   Section 5.2: Relativistic Energy-Momentum and Thermal Equilibrium (相对论能量-动量与热平衡)
//     - 相对论框架下的温度变换问题
//     - Jüttner 分布

//   Section 5.3: Photon Gas and Ultra-Relativistic Limit (光子气体与极端相对论极限)
//     - 光子气体的热力学
//     - 辐射压与辐射能密度
//     - Stefan-Boltzmann 定律的初步推导

//   Section 5.4: Thermodynamic Laws in Covariant Form (热力学定律的协变形式)
//     - 四维热力学流
//     - 协变形式的热力学第一定律
//
// ==========================================================================
// --- Part II: Thermodynamic Formalism (热力学形式理论) ---
// ==========================================================================
//
// 设计思路: 在 Part I 建立的热力学定律基础上，发展完整的热力学数学框架。
// 核心工具是热力学势（通过勒让德变换相互关联）和麦克斯韦关系。然后应用
// 于相平衡、化学平衡、稳定性分析和热力学几何。
// 对应教材: Callen Ch 2-9, 11-12; Reif Ch 6-8; Landau §16-27

// --- Chapter 6: Thermodynamic Potentials and Maxwell Relations (热力学势与麦克斯韦关系) ---

//   Section 6.1: Internal Energy as Fundamental Relation (作为基本关系的内能)
//     - 基本方程: U(S, V, N)
//     - 内能的全微分与热力学恒等式
//     - 基本方程的齐次性

//   Section 6.2: Enthalpy, Helmholtz Free Energy, Gibbs Free Energy (焓、亥姆霍兹自由能、吉布斯自由能)
//     - 焓: H(S, p)
//     - 亥姆霍兹自由能: F(T, V)
//     - 吉布斯自由能: G(T, p)
//     - 各热力学势的物理意义与适用条件

//   Section 6.3: Maxwell Relations (麦克斯韦关系)
//     - 四组麦克斯韦关系的推导
//     - 麦克斯韦关系在热力学计算中的应用
//     - 用可测量表示不可测量

//   Section 6.4: Legendre Transformations (勒让德变换)
//     - 勒让德变换的数学定义
//     - 热力学势作为勒让德变换的层级结构
//     - 变换的几何意义

//   Section 6.5: Thermodynamic Identities and Calculation Strategies (热力学恒等式与计算策略)
//     - 常用热力学恒等式汇总
//     - 热力学计算的系统方法 (Jacobian 方法)
//     - α, κ_T, C_p - C_V 关系

// --- Chapter 7: Multi-Component Systems and Phase Equilibrium (多组分系统与相平衡) ---

//   Section 7.1: Chemical Potential (化学势)
//     - 化学势的多种定义与等价性
//     - 化学势的物理意义
//     - 理想气体的化学势

//   Section 7.2: Gibbs-Duhem Equation (吉布斯-杜安方程)
//     - Gibbs-Duhem 方程的推导
//     - 强度量之间的约束关系
//     - 对混合物化学势的约束

//   Section 7.3: Phase Equilibrium Conditions (相平衡条件)
//     - 相平衡的热力学条件
//     - 多相平衡的一般理论

//   Section 7.4: Clausius-Clapeyron Equation (克劳修斯-克拉珀龙方程)
//     - 单组分两相平衡的 Clausius-Clapeyron 方程
//     - 固-液、液-气、固-气相变的应用

//   Section 7.5: Gibbs Phase Rule (吉布斯相律)
//     - 相律 F = C - P + 2 的推导
//     - 单元系、二元系的相图分析

//   Section 7.6: Phase Diagrams: First and Second Order Phase Transitions (相图：一级与二级相变)
//     - 一级相变的特征: 潜热、体积突变
//     - 二级（连续）相变: Ehrenfest 方程
//     - 典型相图: 水、CO₂

// --- Chapter 8: Chemical Thermodynamics (化学热力学) ---

//   Section 8.1: Reaction Equilibrium and Affinity (反应平衡与亲和势)
//     - 化学反应进度
//     - 亲和势的定义
//     - 化学平衡条件

//   Section 8.2: Law of Mass Action (质量作用定律)
//     - 质量作用定律的推导
//     - 平衡常数的热力学表达

//   Section 8.3: Equilibrium Constants (平衡常数)
//     - 标准平衡常数 K°
//     - van 't Hoff 方程
//     - 温度、压力对平衡的影响

//   Section 8.4: Le Chatelier's Principle (勒夏特列原理)
//     - 原理的表述
//     - 浓度、温度、压力变化的响应

//   Section 8.5: Electrochemistry: Nernst Equation (电化学：能斯特方程)
//     - 电化学势
//     - Nernst 方程的推导
//     - 电动势与 Gibbs 自由能

// --- Chapter 9: Stability and Fluctuations (稳定性与涨落) ---

//   Section 9.1: Intrinsic Stability Conditions (内禀稳定性条件)
//     - 熵的极大值原理与稳定性
//     - 热稳定性: C_V > 0
//     - 力学稳定性: (∂p/∂V)_T < 0
//     - 稳定性条件的矩阵形式

//   Section 9.2: Le Chatelier-Braun Principle (勒夏特列-布朗原理)
//     - 原理的严格表述
//     - 与稳定性条件的联系

//   Section 9.3: Metastability and Supercooling (亚稳态与过冷)
//     - 亚稳态的热力学描述
//     - 过冷液体、过热液体
//     - 旋节线 (spinodal) 与双节线 (binodal)

//   Section 9.4: Thermodynamic Fluctuation Theory (热力学涨落理论)
//     - Einstein 涨落公式
//     - 能量、体积、粒子数的涨落
//     - 涨落与响应函数的关系

//   Section 9.5: Correlation Functions and Susceptibilities (关联函数与响应函数)
//     - 静态关联函数
//     - 涨落-耗散关系的热力学形式
//     - 压缩率与密度涨落

// --- Chapter 10: Geometric Formulation of Thermodynamics (热力学几何表述) ---

//   Section 10.1: Thermodynamic State Space as Contact Manifold (热力学状态空间作为接触流形)
//     - 热力学相空间的接触结构
//     - 平衡态子流形

//   Section 10.2: Ruppeiner Geometry and Thermodynamic Curvature (鲁普赖纳几何与热力学曲率)
//     - Ruppeiner 度规: 基于熵的涨落
//     - 热力学曲率的物理意义
//     - 曲率与关联长度的关系

//   Section 10.3: Weinhold Metric (温霍尔德度规)
//     - Weinhold 度规的定义
//     - 与 Ruppeiner 度规的关系 (共形变换)

//   Section 10.4: Geometric Interpretation of Phase Transitions (相变的几何解释)
//     - 曲率发散与临界点
//     - 理想气体的曲率
//     - 几何方法的优势与局限
//
// ==========================================================================
// --- Part III: Foundations of Statistical Mechanics (统计力学基础) ---
// ==========================================================================
//
// 设计思路: 搭建从微观到宏观的桥梁。从相空间与刘维尔定理出发（交叉引用
// 分析力学），建立系综理论的核心框架：微正则 → 正则 → 大正则三大系综。
// 每个系综都完整推导配分函数与热力学量的对应关系，然后通过经典应用验证理论。
// 对应教材: Callen Ch 13-16; Pathria Ch 3-5; Reif Ch 9-10; Landau §28-38
// 交叉引用: Mécanique analytique Part III-IV (哈密顿力学、刘维尔定理)

// --- Chapter 11: Phase Space and Liouville's Theorem (相空间与刘维尔定理) ---

//   Section 11.1: Microstate and Macrostate (微观态与宏观态)
//     - 微观态的完整描述
//     - 宏观态与微观态的关系
//     - 粗粒化的概念

//   Section 11.2: Phase Space and Liouville's Theorem (相空间与刘维尔定理)
//     - Γ 空间与 μ 空间
//     - 刘维尔定理的表述与证明
//     - 交叉引用: Mécanique analytique Part IV Ch 10
//     - 相空间体积与状态计数

//   Section 11.3: Ergodic Hypothesis (遍历假设)
//     - 遍历假设的表述
//     - 时间平均与系综平均的等价性
//     - 遍历假设的局限与反例
//     - 交叉引用: Mécanique analytique Part IV Ch 10

//   Section 11.4: Postulates of Statistical Mechanics (统计力学的基本假设)
//     - 等先验概率假设
//     - 统计力学的基本公设
//     - 从微观到宏观的映射规则

//   Section 11.5: Number of Microstates and Entropy (微观态数与熵)
//     - 微观态数的计算
//     - Boltzmann 熵: S = k_B ln Ω
//     - Gibbs 熵公式

// --- Chapter 12: Microcanonical Ensemble (微正则系综) ---

//   Section 12.1: Isolated Systems and Equal a Priori Probability (孤立系统与等先验概率)
//     - 孤立系统的约束条件
//     - 等先验概率原理
//     - 微正则系综的密度矩阵

//   Section 12.2: Density of States and Phase Space Volume (态密度与相空间体积)
//     - 态密度 g(E) 的定义与计算
//     - 相空间体积的半经典计算
//     - 全同粒子修正: 1/N! 因子

//   Section 12.3: Entropy from Microcanonical Partition Function (从微正则配分函数计算熵)
//     - 微正则配分函数 Ω(E, V, N)
//     - 熵的显式计算
//     - 温度、压强的统计定义

//   Section 12.4: Temperature and Thermal Equilibrium (温度与热平衡)
//     - 温度的统计定义: 1/T = (∂S/∂E)
//     - 热平衡条件与热流方向
//     - 热力学第零定律的统计基础

//   Section 12.5: Application: Ideal Gas Revisited (应用：理想气体再探)
//     - 从微正则系综推导理想气体状态方程
//     - Sackur-Tetrode 方程
//     - 与动力学理论结果的比较

// --- Chapter 13: Canonical Ensemble (正则系综) ---

//   Section 13.1: System in Thermal Contact with Reservoir (与热库接触的系统)
//     - 系统+热库的复合孤立系统
//     - 正则分布的推导
//     - 玻尔兹曼因子 e^{-βE}

//   Section 13.2: Partition Function and Boltzmann Factor (配分函数与玻尔兹曼因子)
//     - 正则配分函数 Z(T, V, N)
//     - Z 的物理意义
//     - 可分离系统的配分函数

//   Section 13.3: Thermodynamic Quantities from Z (从配分函数 Z 计算热力学量)
//     - 内能: U = -∂ ln Z / ∂β
//     - 自由能: F = -k_B T ln Z
//     - 熵、压强、热容的统计表达

//   Section 13.4: Connection to Helmholtz Free Energy (与亥姆霍兹自由能的联系)
//     - F = U - TS 的统计推导
//     - 正则系综与亥姆霍兹自由能的一一对应
//     - 最大项方法的合理性

//   Section 13.5: Energy Fluctuations (能量涨落)
//     - 能量涨落与热容的关系
//     - 相对涨落的量级: ~1/√N
//     - 涨落在热力学极限下的行为

//   Section 13.6: Classical Limit and Equipartition Revisited (经典极限与均分定理再探)
//     - 经典配分函数的相空间积分形式
//     - 均分定理的统计推导
//     - 经典极限的适用条件

// --- Chapter 14: Grand Canonical Ensemble (大正则系综) ---

//   Section 14.1: Open Systems and Particle Exchange (开放系统与粒子交换)
//     - 系统与粒子库的接触
//     - 大正则分布的推导

//   Section 14.2: Grand Partition Function (大配分函数)
//     - 大配分函数 Ξ(T, V, μ)
//     - 逸度 z = e^{βμ}
//     - Ξ 与微观态求和

//   Section 14.3: Grand Potential and Thermodynamic Relations (巨势与热力学关系)
//     - 巨势: Φ_G = -k_B T ln Ξ
//     - Φ_G = -pV 的证明
//     - 平均粒子数与热力学量的计算

//   Section 14.4: Particle Number Fluctuations (粒子数涨落)
//     - 粒子数涨落与等温压缩率的关系
//     - 热力学极限下涨落的消失

//   Section 14.5: Applications to Adsorption and Surface Phenomena (在吸附与表面现象中的应用)
//     - 晶格气体模型
//     - Langmuir 吸附等温线
//     - 表面吸附的统计力学处理

// --- Chapter 15: Classical Applications (经典应用) ---

//   Section 15.1: Ideal Gas: Full Thermodynamic Description (理想气体：完整热力学描述)
//     - 从正则系综完整推导理想气体热力学
//     - 单原子、双原子、多原子气体的配分函数
//     - 平动、转动、振动自由度的贡献

//   Section 15.2: Paramagnetism: Curie Law (顺磁性：居里定律)
//     - 经典顺磁性的统计模型
//     - 朗之万函数
//     - 居里定律的推导

//   Section 15.3: Einstein and Debye Models of Solid Heat Capacity (固体热容：爱因斯坦与德拜模型)
//     - Einstein 模型: 独立谐振子
//     - Debye 模型: 连续弹性介质
//     - 低温 T³ 定律

//   Section 15.4: Barometric Formula and Atmospheric Physics (气压公式与大气物理)
//     - 重力场中的粒子分布
//     - 气压公式的统计推导
//     - 大气标高

//   Section 15.5: Diatomic Gas: Rotational and Vibrational Contributions (双原子气体：转动与振动贡献)
//     - 刚性转子配分函数
//     - 谐振子配分函数
//     - 特征温度: Θ_rot, Θ_vib
//     - 热容随温度的变化
//
// ==========================================================================
// --- Part IV: Quantum Statistics (量子统计) ---
// ==========================================================================
//
// 设计思路: 引入量子力学的全同粒子概念，推导玻色-爱因斯坦和费米-狄拉克
// 两大量子统计分布。然后系统展开其应用：光子气体（黑体辐射）、声子
// （固体热容的量子理论）、电子气体（金属与白矮星）、玻色-爱因斯坦凝聚。
// 这是从经典统计到量子世界的核心跃迁。
// 对应教材: Callen Ch 15-17, 21; Pathria Ch 7-11; Landau §54-64

// --- Chapter 16: Foundations of Quantum Statistics (量子统计基础) ---

//   Section 16.1: Indistinguishability and Quantum States (全同性与量子态)
//     - 全同粒子的不可区分性
//     - 对称态与反对称态
//     - 玻色子与费米子

//   Section 16.2: Bose-Einstein Distribution (玻色-爱因斯坦分布)
//     - 大正则系综推导 BE 分布
//     - 平均占据数: 1/(e^{β(ε-μ)} - 1)
//     - 化学势的约束: μ < ε₀

//   Section 16.3: Fermi-Dirac Distribution (费米-狄拉克分布)
//     - 大正则系综推导 FD 分布
//     - 平均占据数: 1/(e^{β(ε-μ)} + 1)
//     - Pauli 不相容原理的统计表达

//   Section 16.4: Classical Limit: Maxwell-Boltzmann Recovery (经典极限：回到麦克斯韦-玻尔兹曼分布)
//     - 高温低密度极限
//     - 简并条件与热德布罗意波长
//     - 量子到经典的过渡

//   Section 16.5: Density Matrix Formulation (密度矩阵表述)
//     - 量子密度矩阵
//     - 纯态与混合态
//     - 量子统计的密度矩阵方法

// --- Chapter 17: Bose-Einstein Statistics and Applications (玻色-爱因斯坦统计与应用) ---

//   Section 17.1: Photon Gas and Planck's Law (光子气体与普朗克定律)
//     - 光子作为零化学势玻色子
//     - Planck 辐射公式的推导
//     - 模式密度的计算

//   Section 17.2: Black-Body Radiation (黑体辐射：Stefan-Boltzmann 与 Wien 定律)
//     - Stefan-Boltzmann 定律
//     - Wien 位移定律
//     - Rayleigh-Jeans 极限与紫外灾难

//   Section 17.3: Phonons and Quantum Theory of Heat (声子与热的量子理论)
//     - 晶格振动的量子化: 声子
//     - Debye 模型的统计力学推导
//     - 低温热容的 T³ 定律

//   Section 17.4: Bose-Einstein Condensation (玻色-爱因斯坦凝聚)
//     - 无相互作用玻色气体的 BEC
//     - 临界温度 T_c 的推导
//     - 凝聚体的热力学性质

//   Section 17.5: Superfluidity of Helium-4 (氦-4 的超流性)
//     - 液氦的 λ 相变
//     - 双流体模型
//     - 超流性的定性解释

// --- Chapter 18: Fermi-Dirac Statistics and Applications (费米-狄拉克统计与应用) ---

//   Section 18.1: Ideal Fermi Gas at Zero Temperature (零温理想费米气体)
//     - T = 0 时的费米分布
//     - 费米面与费米球

//   Section 18.2: Fermi Energy and Density of States (费米能与态密度)
//     - 费米能量 ε_F 的计算
//     - 态密度的表达式
//     - 低温展开: Sommerfeld 展开

//   Section 18.3: Electronic Heat Capacity of Metals (金属电子热容)
//     - 金属中自由电子气的热容
//     - 线性项: C_el = γT
//     - 与晶格热容的比较

//   Section 18.4: Pauli Paramagnetism (泡利顺磁性)
//     - 外磁场中的费米气体
//     - 泡利顺磁磁化率
//     - 与经典顺磁性的对比

//   Section 18.5: Degenerate Fermi Gas: White Dwarfs and Neutron Stars (简并费米气体：白矮星与中子星)
//     - 白矮星的电子简并压
//     - Chandrasekhar 质量极限
//     - 中子星的简并中子压
//
// ==========================================================================
// --- Part V: Interacting Systems and Phase Transitions ---
// --- (相互作用系统与相变) ---
// ==========================================================================
//
// 设计思路: 从理想气体推广到有相互作用的真实系统。用集团展开和位力系数
// 处理弱非理想性，用平均场理论处理相变。然后深入临界现象——标度律、
// 普适性、重整化群的基本思想。
// 对应教材: Callen Ch 7-9, 11-12; Pathria Ch 12-16; Landau §41-53, §135-141

// --- Chapter 19: Interacting Particle Systems (相互作用粒子系统) ---

//   Section 19.1: Configuration Integral and Partition Function (位形积分与配分函数)
//     - 位形积分 Q_N
//     - 配分函数中动能与势能的分离
//     - Mayer f 函数

//   Section 19.2: Cluster Expansion (集团展开)
//     - Mayer 集团展开方法
//     - 不可约集团积分
//     - 配分函数的集团展开

//   Section 19.3: Virial Expansion and Virial Coefficients (位力展开与位力系数)
//     - 位力状态方程: pV/NkT = 1 + B₂(T)/V + ...
//     - 第二、第三位力系数
//     - 位力系数与分子间势的关系

//   Section 19.4: Mean Field Theory (平均场理论)
//     - 平均场近似的基本思想
//     - Bragg-Williams 近似
//     - 平均场方程的求解

//   Section 19.5: Van der Waals Equation of State (范德瓦尔斯状态方程)
//     - 从分子间力推导 van der Waals 方程
//     - 等温线与 Maxwell 构造
//     - 对应态原理

// --- Chapter 20: Phase Transitions and Critical Phenomena (相变与临界现象) ---

//   Section 20.1: Classification of Phase Transitions (相变的分类)
//     - Ehrenfest 分类
//     - 现代分类: 一级 vs 连续相变
//     - 序参量的概念

//   Section 20.2: Critical Exponents (临界指数)
//     - 临界指数 α, β, γ, δ, ν, η 的定义
//     - 实验测量值
//     - 平均场预言 vs 实验值

//   Section 20.3: Scaling Laws and Universality (标度律与普适性)
//     - 标度假设
//     - Rushbrooke, Griffiths, Widom 标度律
//     - 普适性: 临界指数仅依赖于维度和对称性

//   Section 20.4: Ising Model (伊辛模型：精确解与平均场解)
//     - Ising 模型的定义
//     - 一维精确解 (转移矩阵法)
//     - 二维 Onsager 解简介
//     - 平均场解

//   Section 20.5: Landau Theory of Phase Transitions (朗道相变理论)
//     - 朗道自由能展开
//     - 临界指数的朗道预言
//     - 朗道理论的适用范围

//   Section 20.6: Renormalization Group: Basic Ideas (重整化群：基本思想)
//     - Kadanoff 标度变换
//     - Wilson 重整化群的基本步骤
//     - 不动点与普适性
//     - 临界指数的重整化群计算概述
//
// ==========================================================================
// --- Part VI: Non-Equilibrium Statistical Mechanics ---
// --- (非平衡统计力学) ---
// ==========================================================================
//
// 设计思路: 从平衡态推广到非平衡过程。以玻尔兹曼输运方程为微观基础，
// 建立线性不可逆热力学的一般框架（昂萨格倒易关系），最后以涨落-耗散
// 定理和随机过程收尾，连接统计力学与随机过程笔记。
// 对应教材: Callen Ch 10, 19-20; Reif Ch 15-17; Pathria Ch 16
// 交叉引用: Processus Stochastique（布朗运动与朗之万方程的深入处理）

// --- Chapter 21: Boltzmann Transport Equation (玻尔兹曼输运方程) ---

//   Section 21.1: Distribution Function and Phase Space Density (分布函数与相空间密度)
//     - 单粒子分布函数 f(r, v, t)
//     - 分布函数的物理意义
//     - 宏观量作为分布函数的矩

//   Section 21.2: Derivation of the Boltzmann Equation (玻尔兹曼方程的推导)
//     - 漂移项、外力项、碰撞项
//     - 分子混沌假设 (Stosszahlansatz)
//     - 玻尔兹曼方程的完整形式

//   Section 21.3: Relaxation Time Approximation (弛豫时间近似)
//     - BGK 模型
//     - 弛豫时间的物理意义
//     - 稳态解的求解方法

//   Section 21.4: H-Theorem Revisited (H 定理再探)
//     - 从玻尔兹曼方程推导 H 定理
//     - 平衡分布的唯一性
//     - 局部平衡假设

//   Section 21.5: Transport Coefficients from Kinetic Theory (从动力学理论计算输运系数)
//     - 粘滞系数的推导
//     - 热导率的推导
//     - 电导率 (Drude 模型)
//     - Wiedemann-Franz 定律

// --- Chapter 22: Linear Irreversible Thermodynamics (线性不可逆热力学) ---

//   Section 22.1: Entropy Production Rate (熵产率)
//     - 局部平衡假设
//     - 熵平衡方程
//     - 熵产率的非负性

//   Section 22.2: Thermodynamic Forces and Fluxes (热力学力与流)
//     - 热力学力 X_i 的定义
//     - 热力学位流 J_i 的定义
//     - 熵产率: σ = Σ J_i X_i ≥ 0

//   Section 22.3: Onsager Reciprocal Relations (昂萨格倒易关系)
//     - 线性唯象关系: J_i = Σ L_{ij} X_j
//     - Onsager 倒易关系: L_{ij} = L_{ji}
//     - 微观可逆性的宏观体现
//     - Curie 对称性原理

//   Section 22.4: Applications: Thermoelectric Effects (应用：热电效应)
//     - Seebeck 效应
//     - Peltier 效应
//     - Thomson 效应
//     - Onsager 关系在热电现象中的应用

//   Section 22.5: Prigogine's Theorem of Minimum Entropy Production (普里高金最小熵产率定理)
//     - 最小熵产率原理的表述
//     - 适用条件与限制
//     - 与平衡态的类比

// --- Chapter 23: Fluctuations and Stochastic Processes (涨落与随机过程) ---

//   Section 23.1: Fluctuation-Dissipation Theorem (涨落-耗散定理)
//     - 涨落与耗散的深刻联系
//     - Nyquist 定理 (热噪声)
//     - 一般形式的涨落-耗散定理

//   Section 23.2: Langevin Equation (朗之万方程)
//     - 朗之万方程的建立
//     - 随机力与摩擦力的关系
//     - 速度自关联函数
//     - 交叉引用: Processus Stochastique

//   Section 23.3: Fokker-Planck Equation (福克-普朗克方程)
//     - 从朗之万方程到 Fokker-Planck 方程
//     - Kramers-Moyal 展开
//     - Fokker-Planck 方程的稳态解

//   Section 23.4: Brownian Motion (布朗运动)
//     - Einstein 的布朗运动理论
//     - 扩散系数与迁移率的关系
//     - 均方位移: ⟨x²⟩ = 2Dt
//     - Perrin 实验验证

//   Section 23.5: Kubo Formula and Linear Response Theory (久保公式与线性响应理论)
//     - 线性响应的一般理论
//     - Kubo 公式: 响应函数与关联函数
//     - Green-Kubo 关系式
//     - 电导率的 Green-Kubo 表达


// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
//
// 本笔记遵循"宏观经验 → 形式理论 → 统计桥梁 → 量子统计 → 相互作用 → 非平衡"
// 六段式主线，共 6 Part、23 Chapter。
//
// Part I (Ch 1-5): 气体动力学理论与经典热力学——从分子运动论和热力学三定律
// 建立宏观框架，以相对论热力学收尾。
//
// Part II (Ch 6-10): 热力学形式理论——热力学势、相平衡、化学热力学、稳定性
// 分析、热力学几何表述。
//
// Part III (Ch 11-15): 统计力学基础——系综理论的核心框架 (微正则、正则、大正则)
// 及经典应用。
//
// Part IV (Ch 16-18): 量子统计——全同粒子统计分布 (BE, FD) 及其在天体物理、
// 凝聚态中的应用。
//
// Part V (Ch 19-20): 相互作用系统与相变——从集团展开到临界现象与重整化群。
//
// Part VI (Ch 21-23): 非平衡统计力学——玻尔兹曼输运方程、线性不可逆热力学、
// 涨落-耗散理论。
//
// 教材覆盖: Callen 全部 21 章知识点均已覆盖，并有适当扩展（热力学几何、
// 重整化群初步、输运方程等）。
//
// 关键设计决策:
// 1. 气体动力学理论独立成章 (Ch 1): Callen 几乎不处理动力学理论，但从教学
//    角度，麦克斯韦分布和输运现象是统计力学的必要直觉准备。
// 2. 负温度放在第三定律章节 (§4.5): 负温度本质上是熵概念的推论 (S(E) 的
//    非单调性)，逻辑上紧承第三定律，而非如 Callen 作为独立补充章节。
// 3. 热力学几何独立成节 (Ch 10): 这是 Callen 和多数标准教材不涉及的现代内容。
//    加入理由: (a) 连接微分几何工具，(b) Ruppeiner 曲率与相变有深刻联系，
//    (c) 为热力学提供现代视角。
// 4. 重整化群初步纳入 (§20.6): 虽然属于高级话题，但作为"基本思想"介绍是
//    合理的，因为它是理解临界现象普适性的关键。
// 5. Part VI 非平衡部分: 从 Callen 的 Ch 10 (涨落) 和 Ch 19-20 (不可逆热力学)
//    扩展为完整的 3 章，覆盖输运方程、不可逆热力学、涨落-耗散理论。
// ==========================================================================

#bibliography("references.bib")

// 目录
