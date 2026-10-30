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

== Ideal Gas Equation of State // 理想气体状态方程
=== Thermodynamic System // 热力学系统
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
  under such a scaling. Volume $V$, amount of substance $nu$, internal
  energy $U$, entropy $S$ are extensive; pressure $p$, temperature
  $T$, density $rho$ are intensive. The quotient of two extensive
  quantities is intensive.
] <def:extensive-intensive>

#definition(name: "Equilibrium State and State Variables")[
  A thermodynamic system is in an *equilibrium state* if its measurable properties are independent of time and of the system's history.

  For a simple compressible system of fixed composition, the state is characterised by a small set of *state variables* — the pressure $p$, the volume $V$, and the temperature $T$.
] <def:equilibrium-state>

The *volume* $V$ is the space occupied by the gas; its SI unit is the cubic metre ($m^3$), with the litre ($1 L = 10^(-3) m^3$) as the common practical unit.

The *pressure* $p$ is the normal force exerted by the gas on unit area of the container wall. Microscopically, it is the macroscopic manifestation of the average impulse delivered by the countless random collisions of gas molecules with the wall, and it is therefore governed by both the frequency and the intensity of the molecular thermal motion. Its SI unit is the pascal ($"Pa"$); other units in use are $1 "cmHg" = 1.333 times 10^3 "Pa"$ (centimetres of mercury) and $1 "atm" = 76 "cmHg" = 1.013 times 10^5 "Pa"$ (standard atmosphere).

The *temperature* measures, microscopically, the intensity of the molecular thermal motion. That it is a meaningful state variable rests on an empirical regularity so basic that it was formalised last, after the first law, and therefore numbered zero.

#law(name: "Zeroth Law of Thermodynamics")[
  Two systems each in thermal equilibrium with a third are in thermal equilibrium with each other. Consequently, thermal equilibrium is an equivalence relation on the set of all systems, and to each equivalence class one may attach a number — the *temperature* — common to all its members.
] <def:zeroth-law>

The existence of the equivalence-class label is the *existence of temperature*; its numerical realisation is called a *temperature scale*: the Celsius scale uses $t$ in degrees Celsius (°C), the thermodynamic scale uses $T$ in kelvins (K), and the two are related by
$
  T = t + 273.15.
$

#definition(name: "Equation of State")[
  The *equation of state* is the functional relation among the state
  variables,
  $
    f(p, V, T) = 0,
  $
  expressing that only two of the three variables are independent for a
  simple system.
] <def:equation-of-state>

=== Ideal Gas
The *ideal gas* is the limiting case of a gas at low density, where
intermolecular forces and molecular volumes are negligible. Its
equation of state, established empirically by Boyle, Charles and
Avogadro, takes two equivalent forms. The *macroscopic (molar) form*,
suited to laboratory chemistry, reads
$
  p V = nu R T,
$
where $nu$ is the amount of substance (in moles) and
$R = 8.314 "J/(mol K)"$ is the gas constant. The *microscopic
(molecular) form*, suited to kinetic theory, reads
$
  p V = N k_B T,
$
where $N$ is the number of molecules and
$k_B = 1.38 times 10^(-23) "J/K"$ is the Boltzmann constant. The two
forms are linked by the conversion relations
$
  nu = N / N_A = m / M, quad M = m_0 N_A, quad k_B = R / N_A, quad k / m = R / M,
$
where $N_A = 6.022 times 10^23 "mol"^(-1)$ is the Avogadro constant,
standing for the number of molecules in one mole of any substance. The mass of a mole of any substance is called the molar mass, and it is denoted by the symbol $M$.

#law(name: "Dalton's Law of Partial Pressures")[
  In a mixture of non-reacting ideal gases at temperature $T$ in a volume
  $V$, each component behaves as if it occupied the container alone: its
  *partial pressure* is
  $
    p_i = nu_i R T / V,
  $
  and the total pressure is their sum,
  $
    p = sum_i p_i = (sum_i nu_i) R T / V.
  $
] <law:dalton-law>

Dalton's law carries the equation of state from pure gases to mixtures.
It holds exactly within the ideal-gas model — and fails just where the
ideal-gas law does, the corrections for real mixtures being carried, as
for pure gases, by virial coefficients.

The three families of curves $p V = "const"$ (isotherms),
$p = "const"$ (isobars) and $V = "const"$ (isochores) partition the
$p$-$V$ plane; see @fig:pv-isotherms.

#figure(
  image("img/pv-isotherms.svg", width: 72%),
  caption: [Isotherms in the $p$-$V$ plane: hyperbolic ideal-gas
    isotherms $p V = nu R T$ and van der Waals isotherms, the subcritical
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

== Microscopic Model: Pressure and Temperature // 微观模型：压强与温度

A thermodynamic volume of gas contains an immense number of molecules
(some $10^(19)$ per cubic centimetre at room conditions), each in
ceaseless free flight punctuated by brief collisions. The macroscopic
pressure $p$ is nothing but the time-averaged momentum flux that this
swarm delivers to a containing wall, and the temperature $T$ measures
the mean kinetic energy per molecule. Building this dictionary — from
molecular picture to thermodynamic variables — is the founding gesture
of kinetic theory.

#definition(name: "Ideal Gas Microscopic Model")[
  The kinetic-theory model of an ideal gas rests on two groups of assumptions.

  *Mechanical assumptions on individual molecules.*

  - molecules are point particles — their own volume is negligible compared with the volume they occupy;
  - except during the brief instants of collision, molecules exert no force on one another;
  - all collisions, both with the walls and between molecules, are perfectly elastic.

  *Statistical assumptions on the ensemble.*

  - the molecules are in perpetual random motion, their velocities changing from instant to instant through collisions;
  - *spatial homogeneity*: in equilibrium the molecules are distributed uniformly over the volume,
  $
    n = (dif N)/(dif V) = N / V;
  $
  - *isotropy of directions*: no direction is preferred,
  $
    chevron.l v_x chevron.r = chevron.l v_y chevron.r = chevron.l v_z chevron.r = 0, quad quad chevron.l v_x^2 chevron.r = chevron.l v_y^2 chevron.r = chevron.l v_z^2 chevron.r = 1/3 chevron.l v^2 chevron.r.
  $
] <def:ideal-gas-model>

#proposition(name: "Pressure Formula")[
  For a gas of number density $n = N / V$ and molecular mass $m$ in
  equilibrium, the pressure exerted on any wall is
  $
    p = 1/3 n m chevron.l v^2 chevron.r = 2/3 n overline(epsilon)_t,
  $
  where $chevron.l v^2 chevron.r$ is the mean squared molecular speed, and $overline(epsilon)_t = 1/2 m lr(⟨ v^2 ⟩)$ is the mean translational kinetic energy of a molecule.
] <prop:pressure-formula>

#proof[
  Take a wall perpendicular to the $x$-axis. In a time interval $dif
  t$, a molecule with velocity $bold(v) = (v_x, v_y, v_z)$ and $v_x > 0$
  lying within a distance $v_x dif t$ of the wall will strike it. With
  number density $n$, the number of such molecules per unit wall area
  and per unit velocity interval is $n f(v_x) dif v_x times v_x dif t$,
  where $f(v_x)$ is the marginal distribution of $v_x$. Each impact
  reverses the normal component, transferring momentum $2 m v_x$ to the
  wall. The pressure is the momentum transfer per unit area per unit
  time:
  $
    p = integral_0^infinity 2 m v_x dot n v_x f(v_x) dif v_x
    = n m integral_0^infinity v_x^2 f(v_x) dif v_x.
  $
  The integrand is even, so extending to $(-infinity, infinity)$ and
  invoking isotropy,
  $
    integral_0^infinity v_x^2 f(v_x) dif v_x
    = 1/2 lr(⟨ v_x^2 ⟩)
    = 1/2 dot lr(⟨ v^2 ⟩) / 3,
  $
  since the three Cartesian components contribute equally,
  $lr(⟨ v_x^2 ⟩) = lr(⟨ v_y^2 ⟩) = lr(⟨ v_z^2 ⟩) = lr(⟨ v^2 ⟩) / 3$.
  Hence $p = 1/3 n m lr(⟨ v^2 ⟩)$, or, in terms of the mean translational kinetic energy $overline(epsilon)_t = 1/2 m lr(⟨ v^2 ⟩)$, the compact form $p = 2/3 n overline(epsilon)_t$.
]

Dalton's law of #link(<law:dalton-law>)[partial pressures] is transparent
in this model: the wall receives momentum flux from each species
independently, so a mixture with number densities $n_i$ exerts
$
  p = sum_i 1/3 n_i m_i chevron.l v_i^2 chevron.r = sum_i p_i,
$
each species contributing its own share. Collisions between molecules of
different species exchange kinetic energy until, in equilibrium, all
species carry the same mean translational energy — the content of the
next proposition — which pins each partial pressure at $p_i = n_i k_B T$.

#proposition(name: "Microscopic Meaning of Temperature")[
  Comparing the form $p = 2/3 n overline(epsilon)_t$ with the ideal-gas
  equation of state $p V = N k_B T$, i.e. $p = n k_B T$, gives the
  identification
  $
    overline(epsilon)_t = 1/2 m lr(⟨ v^2 ⟩) = 3/2 k_B T.
  $
  The temperature of an ideal gas is, up to the constant $3/2 k_B$ per
  molecule, the mean translational kinetic energy per molecule.
] <prop:temperature-kinetic>

#proof[
  Equate the two expressions for the pressure,
  $
    2/3 n overline(epsilon)_t = n k_B T.
  $
  Cancelling $n$ yields
  $
    overline(epsilon)_t = 1/2 m lr(⟨ v^2 ⟩) = 3/2 k_B T.
  $
  This is the kinetic definition of temperature.
]

#corollary(name: "Root-Mean-Square Speed")[
  The root-mean-square molecular speed of an ideal gas at temperature $T$
  is
  $
    v_("rms") = sqrt(lr(⟨ v^2 ⟩)) = sqrt(3 k_B T / m),
  $
  scaling as $sqrt(T)$ and inversely with the square root of the
  molecular mass.
] <cor:rms-speed>

#example(name: "Partial pressures in a mixture")[
  A rigid vessel of volume $V = 0.02 "m"^3$ holds $nu_1 = 0.2 "mol"$ of
  oxygen mixed with $nu_2 = 0.3 "mol"$ of nitrogen; in thermal
  equilibrium the temperature is $T = 300 "K"$. Find the partial
  pressures $p_1$ and $p_2$, the total pressure, the mean translational
  kinetic energy of the molecules of each species, and the total
  translational kinetic energy of the gas.

  By #link(<law:dalton-law>)[Dalton's law] each component fills the
  vessel as if alone:
  $
    p_1 = nu_1 R T / V = 2.49 times 10^4 "Pa", quad
    p_2 = nu_2 R T / V = 3.74 times 10^4 "Pa",
  $
  and the total pressure is their sum — equivalently,
  $(nu_1 + nu_2) R T / V$:
  $
    p = p_1 + p_2 = 6.23 times 10^4 "Pa".
  $

  The mean translational kinetic energy is a property of the temperature
  alone, not of the species: by
  #link(<prop:temperature-kinetic>)[the microscopic meaning of
    temperature],
  $
    overline(epsilon)_(t,1) = overline(epsilon)_(t,2) = 3/2 k_B T
    = 6.21 times 10^(-21) "J".
  $
  Nitrogen molecules are lighter, so
  #link(<cor:rms-speed>)[their root-mean-square speed] is larger by the
  factor $sqrt(32/28) approx 1.07$ — yet they carry exactly the same
  mean translational energy.

  The total translational energy is the sum over all
  $(nu_1 + nu_2) N_A = 3.01 times 10^23$ molecules,
  $
    E_t = 3/2 (nu_1 + nu_2) R T = 1.87 times 10^3 "J",
  $
  split as $E_(t,1) = 3/2 nu_1 R T = 7.48 times 10^2 "J"$ for the oxygen
  and $E_(t,2) = 1.12 times 10^3 "J"$ for the nitrogen — each species
  taking a share proportional to its mole number. That every molecule,
  heavy or light, carries the same $3/2 k_B T$ of translational energy
  is a first taste of #link(<thm:equipartition>)[the equipartition
    theorem] of the next section.
] <ex:dalton-mixture>

== Degrees of Freedom and Equipartition // 自由度与能量均分

The pressure-temperature identification of §1.2 was derived without
any knowledge of the velocity distribution — only the mean square speed
mattered. A general principle is hiding behind that result: in thermal
equilibrium, energy is shared *equally* among every quadratic degree of
freedom. This is the *equipartition theorem*, the cornerstone of the
classical theory of heat capacities.

#definition(name: "Degrees of Freedom")[
  The number of *degrees of freedom* $f$ of a mechanical system is the
  number of independent coordinates required to specify its
  configuration. For molecules they fall into three classes:

  - *translational* — coordinates of the centre of mass;
  - *rotational* — angles specifying the orientation about the centre
    of mass;
  - *vibrational* — internal coordinates describing relative motion
    of atoms within the molecule.

  For the ideal-gas models used below:

  #tex-table(
    ("Molecule", "Translational", "Rotational", "Vibrational", [$f$]),
    ("monatomic", [$3$], [$0$], [$0$], [$3$]),
    ("linear, rigid", [$3$], [$2$], [$0$], [$5$]),
    ("linear, non-rigid", [$3$], [$2$], [$2$], [$7$]),
    ("non-linear, rigid", [$3$], [$3$], [$0$], [$6$]),
  )
] <def:degrees-of-freedom>

Two details of the table deserve comment. A *linear* molecule (monatomic aside) has only two rotational degrees of freedom, because rotation about the molecular axis carries no moment of inertia — the atoms lie on that axis — whereas a *non-linear* molecule has three. The vibrational entry counts quadratic terms rather than coordinates: each vibrational mode contributes one kinetic and one potential quadratic term, hence two degrees; for a non-rigid molecule of $N$ atoms there are $3 N - 6$ modes ($3 N - 5$ if linear), so that $f = 3 N$ in all.

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

#proof[
  The distribution over phase space in equilibrium is the
  Maxwell--Boltzmann density proportional to $exp(- E / (k_B T))$ — this
  law will be derived in §1.4 from Maxwell's symmetry argument, and more
  systematically from the canonical ensemble in Chapter 13; here we use
  it as the equilibrium weight for every quadratic coordinate. Then
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
]

#proposition(name: "Internal Energy of an Ideal Gas")[
  For a gas of $nu$ moles whose molecules have $f$ quadratic degrees of
  freedom, the equilibrium internal energy is
  $
    U = f/2 nu R T,
  $
  a linear function of temperature alone.
] <prop:ideal-gas-internal-energy>

#proof[
  By the equipartition theorem each quadratic degree contributes
  $1/2 k_B T$ per molecule. With $N = nu N_A$ molecules and $f$ degrees
  each, and using $k_B N_A = R$,
  $
    U = N dot f dot 1/2 k_B T = f/2 nu R T.
  $
  In particular $U = 3/2 nu R T$ for a monatomic gas, recovering the
  temperature identification of §1.2 summed over all molecules.
]

In general the internal energy of a gas collects both contributions,
$U(T, V) = U_k + U_p$: the kinetic part $U_k$ depends only on
temperature, while the potential part $U_p$ — the energy of the
intermolecular forces — depends on the mean molecular separation and
hence on the volume.

For an ideal gas, however, intermolecular forces are negligible by assumption, so $U_p = 0$ and the internal energy is
a single-valued function of temperature alone, $U = U(T)$ — which is
exactly why the formula above comes out independent of $V$. This is
the microscopic counterpart of #link(<prop:joule-law>)[Joule's law]
(Chapter 2), where the same statement is obtained purely
thermodynamically.

#caution(title: "Failure of equipartition")[
  The vibrational degrees of freedom counted in the table above are
  *frozen out* at room temperature: nitrogen behaves as a rigid
  diatomic gas ($f = 5$) under room conditions and does not activate
  its vibrational mode until far above $2000 "K"$. Worse still, the
  vibrational and rotational contributions of solids are missing
  entirely at low temperatures, and the classical prediction of the
  specific heat of a crystal — $3 R$ per mole at *all* temperatures
  (the Dulong--Petit law) — collapses below tens of kelvin. Classical
  statistical mechanics cannot explain these facts; the resolution is
  quantum mechanical, and is supplied by the Einstein and Debye models
  (Chapter 15) and by quantum statistics (Chapter 17).
] <caution:equipartition-failure>

== Maxwell-Boltzmann Velocity Distribution // 麦克斯韦-玻尔兹曼速度分布

=== Speed Distribution Function // 速率分布函数
In an equilibrium gas the molecular speeds take a whole range of
values, and collisions constantly redistribute them among the
molecules; yet at a fixed temperature the fraction of molecules found
in any given speed interval is perfectly stable. This statistical
regularity is directly accessible to experiment — Stern's
molecular-beam experiment and its refinements measure it — and it is
the starting point of the whole theory.

The experimentally tabulated quantity is the *speed distribution
function*. In a gas of $N$ molecules at equilibrium, let $dif N$ be
the number of molecules whose speeds lie in $[v, v + dif v]$; the
ratio $(dif N) / N$ is the fraction of molecules in that interval, and
$
  f(v) = lim_(Delta v -> 0) (Delta N) / (N Delta v) = (dif N)/(N dif v)
$
defines the *speed distribution function*.

In terms of $f(v)$, four counting statements follow at once:

- $N f(v) dif v$ is the number of molecules with speeds in
  $[v, v + dif v]$;
- $n f(v) dif v$ — with $n = N / V$ the number density — is the number
  of such molecules per unit volume;
- $integral_(v_1)^(v_2) N f(v) dif v$ and
  $integral_(v_1)^(v_2) n f(v) dif v$ extend the two counts to the
  finite interval $[v_1, v_2]$;
- dividing by $N$, the fraction of molecules with speeds in
  $[v_1, v_2]$ is $integral_(v_1)^(v_2) f(v) dif v$ — the area under
  the curve between $v_1$ and $v_2$.

The total area is one, $integral_0^infinity f(v) dif v = 1$: every
molecule has some speed.

At this stage $f(v)$ is a purely statistical notion; its explicit form
is derived below.

#figure(
  image("img/speed-distribution-experimental.svg", width: 58%),
  caption: [The speed distribution function $f(v)$ of nitrogen
    ($M = 28 "g/mol"$) at $T = 300 "K"$, as measured experimentally.
    The dark strip is the number $dif N = N f(v) dif v$ of molecules
    with speeds in $[v, v + dif v]$, and the shaded area is the
    fraction of molecules with speeds in $[v_1, v_2]$. The curve rises
    from the origin, peaks at the most probable speed $v_p approx 422
    "m/s"$, and decays along a long tail that approaches the $v$-axis
    asymptotically: very slow and very fast molecules are both rare.],
  placement: auto,
  supplement: [Fig.],
) <fig:speed-distribution-experimental>

=== Maxwell Velocity Distribution Function // 麦克斯韦速度分布函数
Maxwell derived the explicit form of the distribution in 1860, on the
basis of probability theory alone, before any direct measurement
existed. His argument concerns the *velocity* $bold(v) = (v_x, v_y,
  v_z)$ — a point in three-dimensional velocity space — and rests on two
symmetry assumptions: the gas selects no preferred direction, and the
three Cartesian components are statistically independent.

#theorem(name: "Maxwell Velocity Distribution")[
  In a gas at thermal equilibrium, the probability density of the
  velocity $bold(v)$ of a molecule of mass $m$ at temperature $T$ is
  $
    f(bold(v)) = (m / (2 pi k_B T))^(3/2) exp(- m v^2 / (2 k_B T)),
  $
  where $v^2 = v_x^2 + v_y^2 + v_z^2$.
] <thm:maxwell-velocity>

#proof(name: "Maxwell's argument")[
  Write the density as
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
  $u, w >= 0$; differentiating with respect to $u$ and $w$ separately
  yields $G'(u) = G'(w)$ for all $u, w$, so $G'$ is a constant $-alpha$
  and
  $
    g(v) = A exp(-alpha v^2).
  $
  Normalisation fixes $A = sqrt(alpha / pi)$ per component. The
  parameter $alpha$ is fixed below by the ideal-gas law to be
  $alpha = m / (2 k_B T)$.
]

The only undetermined constant is $alpha$. Its value follows from the
pressure formula of §1.2, $p = 1/3 n m lr(⟨ v^2 ⟩)$, which combined
with the ideal-gas law $p = n k_B T$ gave
#link(<prop:temperature-kinetic>)[the mean translational kinetic
  energy] $1/2 m lr(⟨ v^2 ⟩) = 3/2 k_B T$; hence
$
  alpha = m / (2 k_B T).
$
Temperature thereby enters the Maxwell distribution as the mean kinetic
energy per molecule — announcing the equipartition theorem of §1.3.

The velocity distribution lives on three-dimensional velocity space;
the experimentally measured $f(v)$ is its marginal along the speed.
Integrating the velocity density over the spherical shell
$v < norm(bold(v)) < v + dif v$, of volume $4 pi v^2 dif v$, converts
one into the other.

#corollary(name: "Maxwell Speed Distribution")[
  The speed distribution function of a gas in equilibrium at
  temperature $T$ is
  $
    f(v) = 4 pi v^2 (m / (2 pi k_B T))^(3/2)
    exp(- m v^2 / (2 k_B T)),
  $
  normalised so that $integral_0^infinity f(v) dif v = 1$.
] <cor:maxwell-speed>

The shell factor $4 pi v^2$ reshapes the Gaussian of the velocity
distribution into a law with a rising front and a long tail. Because
the total area is fixed at $1$, the family of curves at different
temperatures cannot merely slide: as $T$ rises, the peak moves to
higher speeds and must simultaneously lower.

#figure(
  image("img/maxwell-temperature-family.svg", width: 66%),
  caption: [The Maxwell speed distribution of nitrogen at $T_1 = 300 "K"$, $T_2 = 600 "K"$ and $T_3 = 900 "K"$. The factor $v^2$ drives
    each curve up from the origin, the exponential tail decays towards
    the $v$-axis asymptotically, and the area under every curve is $1$.
    Raising $T$ shifts the most probable speed
    $v_p = sqrt(2 R T / M)$ — marked by the dotted lines — to the
    right while lowering the peak: slow molecules concentrate to the
    left of $v_p$, and the broadening tail carries the small fraction
    of fast molecules to higher speeds.],
  placement: auto,
  supplement: [Fig.],
) <fig:maxwell-temperature>

=== Characteristic Speeds // 三种统计速率
#theorem(name: "Characteristic Speeds")[
  Three speeds characterise the Maxwell distribution, each expressible
  through the molar mass $M$ as well as the molecular mass $m$:
  $
    v_p = sqrt(2 k_B T / m) = sqrt(2 R T / M), quad
    overline(v) = sqrt(8 k_B T / (pi m)) = sqrt(8 R T / (pi M)), quad
    v_("rms") = sqrt(3 k_B T / m) = sqrt(3 R T / M),
  $
  the *most probable*, *mean* and *root-mean-square* speeds, in the
  fixed ratio
  $
    v_p : overline(v) : v_("rms") = 1 : 1.128 : 1.225.
  $
] <thm:characteristic-speeds>

#proof[
  Throughout, write $alpha = m / (2 k_B T)$, so that $f(v) = 4 pi (alpha / pi)^(3/2) v^2 exp(-alpha v^2)$.

  *Most probable speed.* $v_p$ maximises $f(v)$; since the prefactor is constant, set
  $
    (dif)/(dif v) (v^2 exp(-alpha v^2)) = (2 v - 2 alpha v^3)
    exp(-alpha v^2) = 0,
  $
  giving $v_p^2 = 1 / alpha$, i.e. $v_p = sqrt(2 k_B T / m)$.

  *Mean speed.* The mean is the first moment of the distribution,
  $
    overline(v) = integral_0^infinity v f(v) dif v = 4 pi (alpha / pi)^(3/2) integral_0^infinity v^3 exp(-alpha v^2) dif v.
  $
  The substitution $u = alpha v^2$, for which
  $v dif v = (dif u) / (2 alpha)$, reduces the integral to the gamma
  function
  $
    integral_0^infinity v^3 exp(-alpha v^2) dif v
    = 1/(2 alpha^2) integral_0^infinity u exp(-u) dif u
    = 1/(2 alpha^2),
  $
  hence $overline(v) = 2 / sqrt(pi alpha) = sqrt(8 k_B T / (pi m))$.

  *Root-mean-square speed.* The mean square is the second moment,
  $
    lr(⟨ v^2 ⟩) = integral_0^infinity v^2 f(v) dif v
    = 4 pi (alpha / pi)^(3/2) integral_0^infinity v^4
    exp(-alpha v^2) dif v,
  $
  and the same substitution turns the remaining integral into
  $integral_0^infinity u^(3/2) exp(-u) dif u = Gamma(5/2) =
  3 sqrt(pi) / 4$, so $lr(⟨ v^2 ⟩) = 3 / (2 alpha) = 3 k_B T / m$ and
  $v_("rms") = sqrt(⟨ v^2 ⟩) = sqrt(3 k_B T / m)$.
]
The ordering follows from the ratios $overline(v) / v_p = 2 / sqrt(pi) approx 1.128$ and $v_("rms") / v_p = sqrt(3 / 2) approx 1.225$: the long tail drags the mean, and still more the root-mean-square speed, above the peak. The three speeds answer different questions — $v_("rms")$ enters the mean kinetic energy and the pressure, $overline(v)$ enters collision and effusion rates, and $v_p$ marks the peak of the distribution.

#note(title: "Mean speed over an interval")[
  The proof above averages $v$ over the whole range of speeds,
  $overline(v) = integral_0^infinity v f(v) dif v$. To average only
  over the molecules whose speeds lie in a finite interval $[v_1,
    v_2]$, restrict both integrals to that interval: the numerator
  $integral_(v_1)^(v_2) v f(v) dif v$ sums the speeds of the molecules
  inside it, and the denominator $integral_(v_1)^(v_2) f(v) dif v$ —
  the fraction of molecules in $[v_1, v_2]$ — restores the normalisation
  to that sub-population. The interval mean speed is therefore
  $
    overline(v)_([v_1, v_2]) =
    (integral_(v_1)^(v_2) v f(v) dif v) / (integral_(v_1)^(v_2) f(v) dif v).
  $
  Molecules outside $[v_1, v_2]$ contribute to neither integral.
] <note:mean-speed-interval>

#example(name: "Stern experiment, 1920")[
  Silver atoms evaporating from an oven pass
  through a slit into a rotating drum; the deposit on the inner wall is
  spread according to flight time, hence according to speed. The
  measured deposit profile matches $f(v)$, providing direct experimental
  confirmation of the Maxwell distribution.
] <ex:stern-experiment>

#note(title: "Probabilistic structure")[
  The velocity density factorises into three
  independent Gaussians; consequently $v^2$ is distributed as a sum of
  three squared centred Gaussians — a scaled chi-square distribution
  with three degrees of freedom, as studied in the Probabilités note.
  The speed distribution $f(v)$ is thus a scaled chi distribution, and
  the characteristic speeds of
  #link(<thm:characteristic-speeds>)[the preceding theorem] are its
  shape parameters in disguise.
] <note:mb-probability>

#example(name: "A simplified electron gas")[
  The conduction electrons of a metal move much like the molecules of a
  gas — an *electron gas*. In a crude model every speed stays below a
  maximum $v_F$, and the fraction of the $N$ electrons with speed in
  $[v, v + dif v]$ is
  $
    (dif N)/N = cases(A v^2 dif v & quad (0 < v < v_F), 0 & quad (v > v_F)),
  $
  a parabola switched off at $v_F$ (@fig:fermi-speed-distribution).
  Determine $A$ and the three characteristic speeds.

  #figure(
    image("img/fermi-speed-distribution.svg", width: 62%),
    caption: [The speed distribution $f(v) = A v^2$ of the model: it
      rises up to the Fermi speed $v_F$ and drops abruptly to zero
      there, with no high-speed tail at all.],
    placement: auto,
    supplement: [Fig.],
  ) <fig:fermi-speed-distribution>

  *Normalisation.* The total fraction must be one:
  $
    integral_0^infinity f(v) dif v = integral_0^(v_F) A v^2 dif v
    = A v_F^3/3 = 1, quad "hence" quad A = 3/v_F^3.
  $

  *Characteristic speeds.* Since $f(v) = 3 v^2/v_F^3$ *increases* all the
  way to the cutoff, its maximum lies at the edge of the allowed range:
  $
    v_p = v_F,
  $
  an interior peak being impossible — quite unlike
  #link(<thm:characteristic-speeds>)[the Maxwell case]. The mean and the
  mean square are the first two moments,
  $
    overline(v) = integral_0^(v_F) v dot 3 v^2/v_F^3 dif v = 3/4 v_F,
    quad
    lr(⟨v^2⟩) = integral_0^(v_F) v^2 dot 3 v^2/v_F^3 dif v = 3/5 v_F^2,
  $
  so
  $
    v_("rms") = sqrt(lr(⟨v^2⟩)) = sqrt(3/5) v_F approx 0.775 v_F.
  $
  The ratio is now $v_p : overline(v) : v_("rms") = 1 : 0.75 : 0.775$:
  with the tail amputated, all three speeds crowd just below the cutoff
  instead of straddling a peak.

  *A sub-population.* How fast are the *fast* electrons? Restrict to
  $[v_F/2, v_F]$, which holds the fraction
  $
    integral_(v_F/2)^(v_F) 3 v^2/v_F^3 dif v = 1 - 1/8 = 7/8
  $
  of them; #link(<note:mean-speed-interval>)[the interval-mean formula]
  then gives
  $
    overline(v)_([v_F/2, v_F])
    = (integral_(v_F/2)^(v_F) v^3 dif v) /
    (integral_(v_F/2)^(v_F) v^2 dif v)
    = (45/64)/(7/8) v_F = 45/56 v_F approx 0.804 v_F,
  $
  above the overall $3/4 v_F$: dropping the slowest eighth of the
  electrons raises the average, as it must.

  The mean kinetic energy follows at once,
  $
    lr(⟨E⟩) = 1/2 m lr(⟨v^2⟩) = 3/5 (1/2 m v_F^2) = 3/5 E_F,
  $
  the result that, at zero temperature, the electrons of a metal fill the
  Fermi sphere — the starting point of Chapter 18.
] <ex:fermi-electron-gas>

== Boltzmann Energy Distribution // 玻尔兹曼能量分布律

The Maxwell distribution depends on velocity through the combination
$m v^2 / 2$ — that is, through the *kinetic energy* $E_k$. This is no
accident: the equilibrium probability of a state depends on its total
energy, kinetic or otherwise, through the universal Boltzmann factor.
The resulting *Boltzmann distribution* is the cornerstone of
statistical mechanics.

=== Boltzmann Distribution // 玻尔兹曼分布
#theorem(name: "Boltzmann Distribution")[
  In thermal equilibrium at temperature $T$, the probability that a
  system occupies a state of energy $E$ is proportional to the
  *Boltzmann factor*
  $
    f(E) prop exp(- E / (k_B T)).
  $
  The constant $1 / (k_B T)$ is the *thermodynamic beta* $beta$.
] <thm:boltzmann-distribution>

#proof[
  In energy form, the Maxwell velocity distribution of §1.4 reads
  $
    dif N = N (m / (2 pi k_B T))^(3/2) exp(- epsilon_k / (k_B T))
    dif v_x dif v_y dif v_z,
  $
  a law over *velocity space* weighted by the kinetic energy alone.
  Now place the gas in a potential field $Phi(bold(r))$ and consider
  the joint event that a molecule has velocity in
  $dif v_x dif v_y dif v_z$ *and* position in $dif x dif y dif z$. The
  equilibrium weight is the total energy $epsilon_k + epsilon_p =
  1/2 m v^2 + Phi(bold(r))$, so the joint distribution over the
  six-dimensional velocity-plus-position space is
  $
    dif N = n_0 (m / (2 pi k_B T))^(3/2)
    exp(- (epsilon_k + epsilon_p) / (k_B T))
    dif v_x dif v_y dif v_z dif x dif y dif z,
  $
  where $n_0$ is the molecular number density at the zero of potential
  energy. Normalising the velocity part — integrating
  $dif v_x dif v_y dif v_z$ over all velocities, where the Maxwell
  factor contributes exactly $1$ — leaves the *position-space*
  distribution
  $
    dif N' = n_0 exp(- epsilon_p / (k_B T)) dif x dif y dif z,
  $
  whence the number density at position $bold(r)$ is
  $
    n = (dif N') / (dif x dif y dif z)
    = n_0 exp(- epsilon_p / (k_B T)).
  $
  Both spaces carry the same exponential energy weight: *velocity
  space* gives the Maxwell distribution of §1.4, *position space* the
  Boltzmann potential-energy distribution just derived. The
  generalisation of the energy weight to *any* system whose state has
  energy $E$ is a fundamental postulate of statistical mechanics — it
  will be derived from the microcanonical ensemble in Chapter 13 — and
  the Maxwell distribution is recovered as the special case of a free
  particle, $E = p^2 / (2 m)$ with no potential energy.
]

=== The Gas in a Gravitational Field // 重力场中的气体
In a gravitational field $g$ directed along $+z$, the potential energy
of a molecule of mass $m$ at altitude $z$ is $epsilon_p = m g z$, and
the position-space distribution specialises to the *molecular number
density formula* of the gravitational field
$
  n = n_0 exp(- m g z / (k_B T)) = n_0 exp(- M g z / (R T)),
$
with $n_0$ the number density at ground level ($z = 0$, the zero of
potential energy) and $M$ the molar mass — the *Boltzmann
potential-energy distribution* in the Earth's gravity.

#example(name: "Isothermal atmosphere")[
  The density formula combines with the ideal-gas law $p = n k_B T$ to
  give the *isothermal pressure formula*
  $
    p = p_0 exp(- m g z / (k_B T)) = p_0 exp(- M g z / (R T)),
  $
  where $p_0 = n_0 k_B T$ is the pressure at ground level: pressure
  falls by the same exponential law as density. Inverting it expresses
  the altitude through the pressure ratio,
  $
    z = (R T)/(M g) ln(p_0 / p),
  $
  the *barometric altimetry formula* — the working principle of the
  pressure altimeter.

  Defining the *scale height*
  $H = k_B T / (m g) = R T / (M g)$, both laws read
  $n = n_0 exp(- z / H)$ and $p = p_0 exp(- z / H)$. For the Earth's
  atmosphere ($T approx 280 "K"$, $M approx 29 "g/mol"$) one finds
  $H approx 8 "km"$ — density and pressure fall by a factor of
  $exp(1)$ every eight kilometres, in fair agreement with observation
  below about $20 "km"$, where temperature and composition are still
  roughly constant.
] <ex:barometric-formula>

#example(name: "Sedimentation equilibrium")[
  Colloidal particles of mass $m$ suspended in a fluid settle under
  gravity against thermal agitation. Their equilibrium density follows
  the same Boltzmann law,
  $
    n(h) = n_0 exp(- m_("eff") g h / (k_B T)),
  $
  with $m_("eff")$ the *buoyancy-corrected* mass. Jean Perrin's 1908
  measurement of the sedimentation profile of gamboge particles —
  counting them at several heights under a microscope — gave the first
  direct determination of $N_A$ (and hence of $k_B$), winning the
  Nobel Prize in 1926 and settling the long controversy over the
  reality of molecules.
] <ex:sedimentation>

== Van der Waals Equation // 范德瓦尔斯方程

The ideal-gas model of §1.1 neglects both the volume of the molecules
and the forces between them. At low density this is well justified, but
as density rises — high pressure, low temperature — both effects enter
and the isotherms depart from the hyperbola $p V = nu R T$. The
*van der Waals equation* is the simplest equation of state that
captures both corrections.

#definition(name: "Van der Waals Equation")[
  For one mole of gas, the van der Waals equation of state reads
  $
    (p + a / V_m^2)(V_m - b) = R T,
  $
  where $V_m = V / nu$ is the molar volume, $a$ corrects for the
  attractive intermolecular force and $b$ for the finite molecular
  volume. The parameters $a, b$ are characteristic of the gas.
] <def:vanderwaals-equation>

#proof(name: "Physical derivation")[
  Two corrections to the ideal-gas picture yield the equation.

  - *Volume correction.* The volume actually available to the centres of
    the molecules is the container volume $V$ minus the excluded volume
    $b$, where $b = 4 N_A times (4/3) pi r^3$ for hard-sphere molecules
    of radius $r$ (the centre of any molecule is excluded from a sphere
    of radius $2 r$ about every other centre; the factor $1/2$ avoids
    double counting). The free volume is thus $V - b$ per mole.
  - *Pressure correction.* A molecule in the interior of the gas feels
    attractions from its neighbours in every direction, which cancel;
    a molecule about to strike the wall feels attractions only from the
    half-space behind it, which decelerates it and reduces the pressure.
    The deficit — the *internal pressure* — scales as the square of the
    density, $p_"int" = a / V_m^2$, since both the flux of wall-striking
    molecules and the typical attractive force on each scale with
    density. The measured pressure is $p = p_"ideal" - p_"int"$, i.e.
    $p_"ideal" = p + a / V_m^2$.

  Substituting the corrected pressure and the free volume into the
  ideal-gas law $p_"ideal" V_"free" = R T$ gives the van der Waals
  equation.
]

At sufficiently low temperatures the van der Waals isotherm $p(V_m)$
acquires a region of positive slope — unphysical, since it signals
negative compressibility — and that region is bounded by the state at
which the isotherm flattens into an inflection.

#definition(name: "Critical Point")[
  The *critical point* of the van der Waals gas is the state at which its
  isotherm develops an inflection:
  $
    (dif p) / (dif V_m)_T = 0, quad (dif^2 p) / (dif V_m^2)_T = 0.
  $
] <def:vdw-critical>

#proposition(name: "Critical Constants")[
  At the critical point the van der Waals equation of state gives the
  critical constants
  $
    T_c = 8 a / (27 R b), quad V_c = 3 b, quad p_c = a / (27 b^2).
  $
] <prop:vdw-critical>

#proof(name: "of the critical constants")[
  Write the equation of state as
  $p = (R T)/(V_m - b) - a/(V_m^2)$.
  The two inflection conditions then read
  $
    - (R T)/(V_m - b)^2 + (2 a)/(V_m^3) = 0, quad
    (2 R T)/(V_m - b)^3 - (6 a)/(V_m^4) = 0.
  $
  Dividing the second by the first eliminates $T$ and gives
  $1/(V_m - b) = 3/(2 V_m)$, i.e. $V_m = 3 b$.
  Substituting back yields $T = 8 a / (27 R b)$, and then
  $p = a / (27 b^2)$.
]

Below $T_c$ the isotherms develop the characteristic loop that signals
the liquid--gas transition.

#note(title: "Maxwell construction")[
  The van der Waals loop below $T_c$ is
  unphysical — a real substance does not exhibit negative
  compressibility. Maxwell's *equal-area construction* replaces the
  loop by a horizontal segment at the coexistence pressure, the area
  under the loop above and below the segment being equal. The
  construction ensures the equality of the Gibbs free energies of the
  coexisting liquid and vapour phases, and will be analysed with the
  mean-field theory of Chapter 19.
] <note:maxwell-construction>

== Mean Free Path and Collision Frequency // 平均自由程与碰撞频率

The Maxwell distribution describes free flight; the picture is completed
by the collisions that randomise it. For a dilute gas, the collision
structure is captured by a single geometric quantity.

#definition(name: "Collision Cross-Section")[
  Model the molecules as hard spheres of diameter $d$. A collision occurs
  whenever two centres pass within a distance $d$; equivalently, each
  molecule sweeps out a *collision cross-section* $sigma = pi d^2$ on the
  cylinder of targets it can hit.
] <def:collision-cross-section>

#definition(name: "Collision Frequency and Mean Free Path")[
  The *collision frequency* $overline(Z)$ of a molecule is the average
  number of collisions it undergoes per unit time; its *mean free path*
  $
    lambda = overline(v) / overline(Z)
  $
  is the average distance travelled
  between successive collisions, with $overline(v)$ the mean speed.
] <def:mean-free-path>

#proposition(name: "Mean Free Path")[
  For a dilute gas of number density $n$, whose molecules present the
  cross-section $sigma$, the mean free path and the collision frequency
  are
  $
    lambda = 1 / (sqrt(2) n sigma), quad
    overline(Z) = sqrt(2) n sigma overline(v).
  $
] <prop:mean-free-path>

The content of the proposition is the factor $sqrt(2)$, which the proof
below traces to the motion of the targets.

#proof(name: "of the mean free path")[
  In a time $dif t$, a molecule moving with speed $v$ sweeps
  a cylinder of volume $sigma v dif t$ and collides with every other
  molecule whose centre lies inside it. With stationary targets the
  collision rate would be $n sigma v$, giving $lambda = 1/(n sigma)$. The
  targets are themselves moving: the relevant quantity is the *relative*
  speed, whose mean over two Maxwell-distributed velocities is
  $sqrt(2) overline(v)$ (the difference of two independent Gaussians is
  Gaussian, with doubled variance). Hence the collision frequency
  $
    overline(Z) = sqrt(2) n sigma overline(v), quad "so that" quad
    lambda = overline(v) / overline(Z) = 1 / (sqrt(2) n sigma).
  $
  The mean free path depends only on density and molecular size — at
  atmospheric conditions $lambda approx 70 "nm"$, some $200$ molecular
  diameters, which is why the dilute-gas picture is self-consistent.
]

#example(name: "Heated, then expanded")[
  A fixed amount of ideal gas first undergoes an isochoric process that
  raises its temperature to four times its initial value, then an
  isothermal expansion to three times its volume. By what factors do the
  mean free path and the mean collision frequency change?

  Only the number density $n$ enters
  #link(<prop:mean-free-path>)[the formulas] — together with the mean
  speed $overline(v) prop sqrt(T)$ in the collision frequency; the
  cross-section $sigma$ is fixed by the molecules themselves.

  - *Isochoric heating.* $n$ does not move, so neither does
    $lambda = 1/(sqrt(2) n sigma)$; but $overline(v)$ doubles, and with
    it $overline(Z) = sqrt(2) n sigma overline(v) -> 2 overline(Z)$.
  - *Isothermal expansion.* The volume triples, so $n -> n/3$: the free
    path lengthens, $lambda -> 3 lambda$, while the unchanged temperature
    leaves the pace of flight alone and
    $overline(Z) -> overline(Z)/3$.

  In total,
  $
    lambda -> 3 lambda, quad overline(Z) -> 2/3 overline(Z).
  $
  The two answers part company because they measure different things:
  the free path is the spacing of targets, blind to how fast the
  molecules fly, whereas the collision rate feels both the crowding and
  the pace.
] <ex:free-path-heating>

The *collision frequency* $overline(Z)$ will do little explicit work below, but
the mean free path $lambda$ and the mean speed $overline(v)$ are the
two ingredients from which all transport coefficients of §1.8 are
assembled.

== Transport Phenomena // 输运现象

A gas in which the local state varies from point to point does not stay
that way: molecules flying freely between collisions carry momentum,
energy and particles across any surface, smoothing out the inhomogeneity.
Three gradient-driven relaxation processes result, each governed by a
*transport coefficient*.

#tex-table(
  ("Phenomenon", "Graded quantity", "Flux law", "Coefficient"),
  ("Momentum transport (viscosity)", [flow velocity $u(z)$], [$Pi = -eta (dif u)/(dif z)$], [shear viscosity $eta$]),
  (
    "Energy transport (heat conduction)",
    [temperature $T(z)$],
    [$q = -kappa (dif T)/(dif z)$],
    [thermal conductivity $kappa$],
  ),
  ("Mass transport (diffusion)", [number density $n(z)$], [$J = -D (dif n)/(dif z)$], [diffusion coefficient $D$]),
)

Each law is written for transport along $z$; the flux $Pi$ carries
$z$-momentum across a plane, $q$ is the heat current and $J$ the particle
current. All three share the same kinetic origin — a molecule crossing
the plane travels, on average, one mean free path since its last
collision, and so deposits the local value of the transported property
one mean free path away.

#definition(name: "Transport Coefficients")[
  With the flux laws of the table above, the *shear viscosity* $eta$,
  the *thermal conductivity* $kappa$ and the *diffusion coefficient*
  $D$ characterise the response of the gas to velocity, temperature and
  density gradients respectively.
] <def:transport-coefficients>

#proposition(name: "Kinetic Estimates of Transport Coefficients")[
  In terms of the mean free path $lambda$, mean speed $overline(v)$,
  number density $n$ and molecular mass $m$,
  $
    eta = 1/3 rho overline(v) lambda, quad
    kappa = 1/3 n overline(v) lambda C_(V,m), quad
    D = 1/3 overline(v) lambda,
  $
  where $rho = n m$ is the mass density and $C_(V,m)$ the molar
  heat capacity at constant volume.
] <prop:kinetic-transport>

#proof(name: "one of three; the viscosity case")[
  Take the flow velocity
  $u(z)$ along $x$, sheared in $z$. Molecules cross a plane $z = "const"$
  from above and from below at rate $1/2 n overline(v)$ per unit area
  (the factor $1/3$ averaging over directions collapses into the isotropic
  crossing rate $1/4 n overline(v)$ per direction pair; the resulting
  prefactor is $1/3$ in the elementary estimate, higher-order treatments
  give $0.37$-odd). A molecule arriving from distance $lambda$ carries the
  $x$-momentum appropriate to its departure point, $m u(z - lambda)$ from
  below and $m u(z + lambda)$ from above. The net momentum flux in the
  $+z$ direction is
  $
    Pi = 1/2 n overline(v) [m u(z - lambda) - m u(z + lambda)]
    = - n m overline(v) lambda (dif u)/(dif z),
  $
  with the sign convention that positive $Pi$ transports $x$-momentum
  towards $+z$. Comparing with $Pi = -eta (dif u)/(dif z)$ yields
  $eta = rho overline(v) lambda / 3$. The conductivity follows by
  replacing the transported property by the mean energy $C_(V,m) T / N_A$
  per molecule, and the diffusivity by the particle property itself.

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
]

#note(title: "Status of the three estimates")[
  Only the viscosity case is derived above; conductivity and diffusivity
  follow by repeating the argument with the transported quantity changed,
  so all three share the same first-order prefactor $1/3$.
  The exact prefactors, and the precise range of validity of the
  estimates, come from the Boltzmann equation — the subject of Chapter 21.
] <note:transport-estimates>

#note(title: "Stochastic boundary")[
  The molecular-randomness picture of this
  section is the classical precursor of fluctuation phenomena: a
  suspended particle buffeted by molecular impacts performs Brownian
  motion, whose rigorous treatment — Langevin equations,
  Fokker--Planck equations, the fluctuation--dissipation theorem — is
  the subject of the Processus Stochastique note, and is touched upon
  again in Chapter 23 of this note.
] <note:transport-stochastic>

== Boltzmann H-Theorem and Irreversibility // 玻尔兹曼 H 定理与不可逆性

The microscopic laws of motion are invariant under time reversal; the
transport phenomena of §1.8 are not — viscosity dissipates, heat flows
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
  §1.4.
] <thm:h-theorem>

#proof(name: "sketch")[
  Each collision $bold(v), bold(v)_1 arrow.r
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
]

#caution(title: "Loschmidt and Zermelo paradoxes")[
  *Loschmidt's reversibility
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

#note(title: "Statistical interpretation")[
  The H function is, up to the constant
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

#definition(name: "Quasi-Static Process")[
  A *quasi-static process* is one that proceeds through a continuous
  sequence of equilibrium states — slower than the time the system
  needs to equilibrate internally, so that the state variables are
  well-defined at every instant.
] <def:quasi-static-process>

Every quasi-static process can be drawn as a curve in the state
diagram ($p$-$V$ plane for a simple fluid), which is the arena for the
work calculations of §2.3.

#definition(name: "Reversible Process")[
  A process is *reversible* if the system *and its surroundings* can be restored to their initial states with no other change anywhere in the universe; otherwise it is *irreversible*.

  A quasi-static process free of dissipative effects is reversible; conversely, a process that is not quasi-static, or involves dissipation, is irreversible.
] <def:reversible-process>

A quasi-static process need not be reversible — friction inside the
system spoils reversibility without destroying quasi-statics. The
common sources of irreversibility, to be quantified by the second law
(Chapter 3), are:

- *dissipation*: friction, viscosity, inelastic deformation, Joule heating;
- *heat flow across a finite temperature difference*;
- *unrestricted expansion*: free expansion, throttling;
- *mixing and diffusion* of distinct substances;
- *chemical reactions* (e.g. combustion) far from equilibrium.

The precise accounting of irreversibility is the business of the
second law and is developed in Chapter 3.

#note(title: "Axiomatics")[
  Callen reformulated classical thermodynamics as an
  axiomatic system: a handful of postulates on the existence of
  equilibrium states and on an extensive quantity — the entropy — that
  is maximised at equilibrium. Since the entropy is not yet available
  (it is the business of Chapter 3), we keep the present development
  law-by-law; the Callen postulates are stated and made rigorous by
  the microcanonical ensemble of Chapter 12, where the statistical
  origin of each postulate becomes visible.
] <note:callen-program>

== Zeroth Law and Temperature // 第零定律与温度

Chapter 1 attached a temperature to every equilibrium state through the
#link(<def:zeroth-law>)[zeroth law]. This section makes thermometry
precise: how a concrete body realises that assignment, and how the
ideal gas supplies a substance-independent scale.

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

#proposition(name: "Ideal Gas Temperature Scale")[
  Fix the volume of a gas thermometer and measure its pressure $p$. The
  temperature defined by
  $
    T(p) = 273.16 dot p / p_3 quad "K",
  $
  where $p_3$ is the pressure at the triple point of water, is
  independent of the gas used (in the dilute limit) and coincides with
  the absolute Kelvin scale.
] <prop:ideal-gas-scale>

#proof[
  For a fixed amount of gas at fixed volume,
  #link(<def:equation-of-state>)[the ideal gas law] gives $p = nu R T / V
  prop T$. The triple point of water — the unique state at which ice,
  liquid water and vapour coexist — is assigned $T_3 = 273.16 "K"$ by
  convention, so $T / T_3 = p / p_3$. That the ratio $p / p_3$, read off
  different dilute gases, converges to a common limit is the empirical
  content of the law; the deviations vanish as the gas charge is
  reduced, because all low-density gases approach the same ideal gas of
  Chapter 1.
]

#note(title: "The absolute scale")[
  The identification with the *absolute
  (Kelvin) scale* was just used ahead of its proof. Properly, the
  absolute scale is constructed from the Carnot cycle, which references
  no material substance at all; the equivalence of the Carnot and
  ideal-gas scales is proved in Chapter 3, once the second law is
  available. Until then, the ideal-gas scale of
  #link(<prop:ideal-gas-scale>)[the preceding proposition] serves as the
  definition of $T$.
] <note:kelvin-scale>

== Work and Heat in Thermodynamic Processes // 热力学过程中的功与热

Energy crosses the boundary of a closed system in exactly two forms:
work, which is energy transfer by macroscopically controlled means, and
heat, which is transfer exploiting a temperature difference. Neither is
a property of the state — they characterise the *process*.

#definition(name: "Work")[
  For a simple compressible system, the work done *by* the system on
  the environment during a quasi-static volume change is
  $
    delta W = p dif V,
  $
  the sign convention being that expansion ($dif V > 0$) does
  positive work on the environment. More generally, for a system with
  generalised force $Y$ and displacement $X$,
  $
    delta W = sum_i Y_i dif X_i,
  $
  covering, e.g., magnetic work $mu_0 H dif M$, elastic work $F dif L$
  and surface work $sigma dif A$.
] <def:work>

The $delta$ in $delta W$ — as opposed to the $dif$ in $dif V$ — signals
that work is *not* an exact differential: no state function $W$ exists
whose differential it would be.

#proposition(name: "Work as Area in the State Diagram")[
  For a quasi-static process taking the system along a curve $C$ in the
  $p$-$V$ plane, the work done by the system is
  $
    W = integral_C p dif V,
  $
  the area under the path. Work therefore depends on the path, not
  merely on the endpoints.
] <prop:work-path>

#example(name: "Path dependence")[
  Take an ideal gas from $(V_1, T)$ to $(V_2, T)$
  (with $V_2 > V_1$) along two quasi-static paths:

  - *direct isothermal expansion*: $W = nu R T ln(V_2 / V_1)$;
  - *two-step path*: isobaric expansion at $p_1$ from $V_1$ to $V_2$
    ($W' = p_1 (V_2 - V_1)$), then isochoric cooling back to $T$ (no
    work).

  At the shared final volume the isobar runs at pressure $p_1 > p_2$,
  so $W' = nu R T (V_2 - V_1) / V_1 > nu R T ln(V_2/V_1) = W$: the
  two-step path delivers more work, because it runs at a higher
  pressure throughout. Same endpoints, different work — the visual
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
    path, and the three shaded areas differ. Right: through the same
    state, the adiabat $p V^gamma = "const"$ ($gamma > 1$) is steeper
    than the isotherm $p V = "const"$; the adiabatic compression from 1
    to $2'$ therefore reaches a higher pressure than the isothermal
    compression to 2.],
  placement: auto,
  supplement: [Fig.],
) <fig:work-path>

#definition(name: "Heat")[
  Energy that crosses the boundary of a system by virtue of a
  temperature difference with the environment is *heat*, denoted $Q$
  (positive when absorbed by the system). Heat is energy *in transit*:
  a body does not *contain* heat, any more than it contains work.
] <def:heat>

The distinction from work is one of mechanism, not of substance: the
same energy transfer can be realised as work with a frictionless piston
or as heat with a thermostat, and mixtures of the two occur in general.

#caution(title: "Path functions")[
  Work and heat are *process quantities*: $delta W$
  and $delta Q$ are inexact differentials, and writing $dif W$ or
  speaking of "the heat contained in a body" is a category error that
  invalidates calculations. Only increments are defined, and the
  integrals $integral delta W$, $integral delta Q$ are path integrals
  to be evaluated along a specified curve. State quantities ($U$, $H$,
  and later $S$) differ precisely in having exact differentials.
] <caution:path-functions>

== First Law and Internal Energy // 第一定律与内能

#definition(name: "Internal Energy")[
  Every equilibrium state of a system admits a state quantity $U$, the
  *internal energy*, such that the energy the system receives in any
  process equals the increase of $U$ between the endpoint states.
] <def:internal-energy>
$U$ is extensive, and is defined up to an additive constant (only differences $Delta U$ are measurable).

The physical motivation is Joule's paddle-wheel experiment: stir an
insulated (adiabatic) vessel with a falling weight, and a given amount
of mechanical work always raises the state — measured by any thermometer
— identically, regardless of how the stirring is arranged. The
endpoints are characterised by a number $U$.

#law(name: "First Law of Thermodynamics")[
  For any process of a closed system,
  $
    Q = Delta U + W,
  $
  where $Q$ is the heat absorbed by the system, $Delta U$ the increase
  of its internal energy, and $W$ the work done *by* the system on the
  environment. For infinitesimal quasi-static processes of a simple
  compressible system,
  $
    delta Q = dif U + p dif V.
  $
] <law:first-law>

In words: the heat absorbed by a system divides into a rise of its
internal energy and work delivered to the outside — energy is
conserved once both transfer channels are counted. Every
perpetual-motion machine of the first kind — one producing work
from nothing — is ruled out.

#definition(name: "Heat Capacity")[
  Provided no phase change or chemical reaction occurs, the *heat
  capacity* of a system is the ratio of the heat $Q$ exchanged with
  the environment to the resulting temperature change $Delta T$,
  $
    C = Q / (Delta T) quad "or, in differential form," quad
    C = (delta Q)/(dif T),
  $
  measured in J/K.

  Heat capacity is extensive and depends on the
  constraint along which the heat is supplied. The *molar heat
  capacities* at constant volume and at constant pressure — the heat
  capacities of one mole, measured in J/(K mol) — are
  $
    C_(V, m) = ((partial Q)_V) / (nu dif T) =
    1 / nu ((partial U)/(partial T))_V, quad
    C_(p, m) = ((partial Q)_p) / (nu dif T) =
    1 / nu ((partial H)/(partial T))_p,
  $
  the second equality of each following from $delta Q = dif U$ at
  $dif V = 0$ and $delta Q = dif H$ at $dif p = 0$ (§2.5).
] <def:heat-capacities>

A related intensive quantity is the *specific heat* $c$ — the heat capacity per unit mass,
$
  c = C / m = Q/(m Delta T), quad "that is," quad
  Q = c m Delta T,
$
measured in J/(K kg); for a substance of molar mass $M$ it relates to the molar values by
$
  c_V = C_(V,m) / M, quad c_p = C_(p,m) / M.
$

The specific heats of common substances at room temperature and ambient pressure are tabulated below — the anomalously large value of water moderates coastal climates and makes it an efficient coolant.

#tex-table(
  ("Substance", "water", "ice", "dry air", "aluminium", "iron", "copper"),
  ([$c_p$ / (J/(K kg))], [4186], [2090], [1005], [900], [450], [385]),
)

For a dilute gas, the kinetic theory of Chapter 1 already computed the
internal energy $U = f/2 nu R T$ from #link(<thm:equipartition>)[the
  equipartition theorem]; #link(<prop:joule-law>)[Joule's law] below
turns it into a heat capacity, while §2.4 and §2.5 treat $C_(V,m)$ and
$C_(p,m)$ as thermodynamic quantities, defined for any substance.

#law(name: "Joule's Law: Internal Energy of an Ideal Gas")[
  The internal energy of an ideal gas depends on temperature alone:
  $
    U = U(T) quad "and hence" quad C_(V, m) = (dif u)/(dif T), quad
    u = U / nu,
  $
  with $u$ the molar internal energy.
] <prop:joule-law>

*Justification.* Experimentally, Joule's free-expansion measurement
(§2.5) found no temperature change when a dilute gas expanded into a
vacuum, suggesting $U$ is independent of $V$. Kinetically, the
internal energy is the sum of molecular kinetic energies,
$U = f/2 N k_B T$ by #link(<thm:equipartition>)[equipartition], with
no dependence on the intermolecular distance because an ideal gas has
no intermolecular potential energy at all. The full thermodynamic
identity $((partial U)/(partial V))_T = T ((partial p)/(partial T))_V - p$, from which
Joule's law follows in one line for an ideal gas, is derived with the
Maxwell relations in Chapter 6.

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

#theorem(name: "Mayer's Formula")[
  For any simple compressible system,
  $
    C_(p, m) - C_(V, m) = T V_m alpha^2 / kappa_T > 0,
  $
  where
  $
    alpha = 1/V ((partial V)/(partial T))_p quad "and" quad
    kappa_T = - 1/V ((partial V)/(partial p))_T
  $
  are the thermal expansion coefficient and the isothermal
  compressibility, and $V_m$ the molar volume. For an ideal gas the
  relation collapses to
  $
    C_(p, m) - C_(V, m) = R.
  $
] <thm:mayer-formula>

#proof[
  Write $u(T, v)$ for the molar internal energy and
  $C_(V, m) = ((partial u)/(partial T))_v$. Then for any quasi-static
  process per mole
  $
    delta q = dif u + p dif v
    = C_(V,m) dif T + [((partial u)/(partial v))_T + p] dif v.
  $
  At constant pressure, $dif v = ((partial v)/(partial T))_p dif T$, so
  $
    C_(p,m) = C_(V,m)
    + [((partial u)/(partial v))_T + p] ((partial v)/(partial T))_p.
  $
  The bracket is rewritten using the identity (proved in Chapter 6 with
  the Maxwell relations)
  $
    ((partial u)/(partial v))_T = T ((partial p)/(partial T))_v - p,
  $
  so the bracket becomes $T ((partial p)/(partial T))_v$. With the cyclic
  identity $((partial p)/(partial T))_v = alpha / kappa_T$ and
  $((partial v)/(partial T))_p = alpha v$,
  $
    C_(p,m) - C_(V,m) = T dot alpha / kappa_T dot alpha v
    = T v alpha^2 / kappa_T.
  $
  For the ideal gas, $p v = R T$ gives $alpha = 1/T$ and
  $kappa_T = 1/p$, hence $C_(p,m) - C_(V,m) = T v (1/T^2) p = R$.
]

The inequality $C_(p,m) > C_(V,m)$ has a direct reading: heating at constant
pressure must pay for the expansion work in addition to raising the
internal energy. The ratio $gamma = C_(p,m) / C_(V,m)$ governs the adiabatic
processes of §2.5.

#corollary(name: "Heat Capacity of an Ideal Gas")[
  Combining #link(<prop:joule-law>)[Joule's law] with the equipartition
  internal energy $U = f/2 nu R T$ of
  #link(<prop:ideal-gas-internal-energy>)[Chapter 1] gives
  $C_(V,m) = f/2 R$; together with
  #link(<thm:mayer-formula>)[Mayer's formula], the molar heat
  capacities of an ideal gas of $f$ degrees of freedom are
  $
    C_(V,m) = f/2 R, quad C_(p,m) = C_(V,m) + R = (f/2 + 1) R, quad
    gamma = C_(p,m) / C_(V,m) = (f + 2) / f.
  $
] <cor:ideal-gas-heat-capacity>

#example(name: "Heat capacities of dilute gases")[
  Each translational or rotational degree of freedom contributes
  $1/2 k_B T$ to the mean energy per molecule, so

  - *monatomic gas* ($f = 3$ translations): $lr(⟨ E ⟩) = 3/2 k_B T$
    per molecule and $C_(V,m) = 3/2 R$;
  - *rigid diatomic gas* ($f = 5$: three translations + two rotations,
    the axis along the bond carrying no moment of inertia):
    $C_(V,m) = 5/2 R$;
  - *diatomic gas with vibrational mode* ($f = 7$: adding one kinetic +
    one potential quadratic term): $C_(V,m) = 7/2 R$.

  These are precisely the classical values tabulated for gases such as
  helium ($C_(V,m) approx 3/2 R$), nitrogen at room temperature
  ($approx 5/2 R$), and chlorine at high temperature ($approx 7/2 R$).
  The vibrational value, however, is reached only at high temperature —
  the freezing-out phenomenon anticipated in
  #link(<caution:equipartition-failure>)[Chapter 1].
] <ex:gas-heat-capacities>

== Common Thermodynamic Processes // 常见热力学过程

A constraint that pins one state quantity — the volume, the pressure, the temperature, or the heat exchange — reduces the first law to a complete energy accounting. The standard quasi-static processes of an ideal gas worked out below are the building blocks from which the cycles of §2.6 and the engines of Chapter 3 are assembled.

#tex-table(
  ("Process", "Constraint", [$W$], [$Q$], [$Delta U$]),
  ([isochoric], [$V = "const"$], [$0$], [$nu C_(V,m) Delta T$], [$nu C_(V,m) Delta T$]),
  ([isobaric], [$p = "const"$], [$p Delta V = nu R Delta T$], [$nu C_(p,m) Delta T$], [$nu C_(V,m) Delta T$]),
  ([isothermal], [$T = "const"$], [$nu R T ln(V_2 / V_1)$], [$nu R T ln(V_2 / V_1)$], [$0$]),
  (
    [reversible adiabatic],
    [$Q = 0$],
    [$-nu C_(V,m) Delta T = (p_1 V_1 - p_2 V_2)/ (gamma - 1)$],
    [$0$],
    [$nu C_(V,m) Delta T = - (p_1 V_1 - p_2 V_2)/ (gamma - 1)$],
  ),
  ([free expansion], ["into vacuum"], [$0$], [$0$], [$0$]),
)

#note[
  A shortcut valid across *all* the processes of this section: by
  #link(<prop:joule-law>)[Joule's law] the internal energy of an ideal
  gas is a function of temperature alone, so
  $
    Delta U = nu C_(V,m) Delta T
  $
  holds whatever the path — isochoric, isobaric, isothermal, adiabatic,
  or free expansion alike. What distinguishes the processes is only how
  $W$ and $Q$ are realized; $Delta U$ depends on the endpoints
  $T_1$, $T_2$ alone.
]

=== The Isochoric Process // 等容过程

With $dif V = 0$ no volume work is done, $W = 0$, and the first law equates heat with the internal-energy increase:
$
  Q = Delta U = nu C_(V,m) (T_2 - T_1).
$
On the $p$-$V$ diagram the isochore is a vertical segment enclosing no area — heating at fixed volume simply raises the pressure, and every joule absorbed goes into the random motion of the molecules.

=== The Isobaric Process // 等压过程

At fixed pressure the work is $W = p (V_2 - V_1) = nu R (T_2 - T_1)$, and the heat absorbed equals the increase of #link(<def:enthalpy>)[the enthalpy]:
$
  Q = Delta H = nu C_(p,m) (T_2 - T_1).
$
That $Q$ exceeds $Delta U$ exactly by the expansion work $nu R (T_2 - T_1)$ is the process-level reading of #link(<thm:mayer-formula>)[Mayer's formula].

=== The Isothermal Process // 等温过程

Couple the gas to a thermostat and let it expand slowly enough that $T$ stays uniform; by #link(<prop:joule-law>)[Joule's law] $Delta U = 0$, and heat and work balance exactly:
$
  Q = W = nu R T ln(V_2 / V_1).
$
The conversion of heat into work is complete but not repeatable: the gas ends at a larger volume, and only a cycle — in which the leftover change is undone — can deliver work steadily. Making this observation precise is the seed of the second law (Chapter 3).

=== The Reversible Adiabatic Process // 绝热可逆过程

#proposition(name: "Quasi-Static Adiabatic Process")[
  A quasi-static adiabatic process ($delta Q = 0$) of an ideal gas with
  constant heat capacities obeys
  $
    p V^gamma = "const", quad T V^(gamma - 1) = "const", quad
    T^gamma p^(1 - gamma) = "const",
  $
  where $gamma = C_(p,m) / C_(V,m) > 1$. These three relations are
  *Poisson's equations* of the adiabatic process.
] <prop:adiabatic-process>

#proof[
  The first law with $delta Q = 0$ gives
  $nu C_(V,m) dif T = - p dif V$. Substituting $p = nu R T / V$ and
  dividing by $nu T$,
  $
    C_(V,m) (dif T) / T = - R (dif V) / V
    quad "with" quad R = C_(p,m) - C_(V,m) = (gamma - 1) C_(V,m),
  $
  so $(dif T) / T = -(gamma - 1)(dif V) / V$, which integrates to
  $T V^(gamma - 1) = "const"$; eliminating $T$ with the equation of state
  gives the $p V^gamma$ and $T^gamma p^(1-gamma)$ forms.
]

These are also called *Poisson's law*; the name has nothing to do with
the Poisson equation $nabla^2 phi = -rho/epsilon_0$ of electrostatics —
the same mathematician, a different subject.

On the $p$-$V$ diagram the adiabat through a point is *steeper* than
the isotherm through the same point, since
$((partial p)/(partial V))_("adiabatic") = gamma ((partial p)/(partial V))_T$
and $gamma > 1$: expansion cools the gas, so its pressure falls faster
than isothermally — see @fig:work-path, right panel; the slope computed
for #link(<def:polytropic-process>)[the polytropic family] below makes
the factor $gamma$ explicit. Correspondingly, adiabatic compression to a
given volume attains a higher pressure and a higher temperature than
isothermal compression.

=== Free Expansion // 自由膨胀

#example(name: "Adiabatic free expansion")[
  An ideal gas initially at $(T_1, V_1)$
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

=== The Polytropic Process // 多方过程

The four processes above are the canonical members of a one-parameter family.

#definition(name: "Polytropic Process")[
  A quasi-static process of an ideal gas in which pressure and volume satisfy
  $
    p V^n = "const", quad T V^(n - 1) = "const", quad
    T^n p^(1 - n) = "const",
  $
  for a constant exponent $n$ — three equivalent forms, related through the
  equation of state — is called a *polytropic process*.
] <def:polytropic-process>

The exponent $n$ recovers the canonical processes as special cases:

+ $n = 0$: $p V^0 = p = "const"$ — the *isobaric* process;
+ $n = 1$: $p V = "const"$, which for an ideal gas ($p V = nu R T$) means $T = "const"$ — the *isothermal* process;
+ $n = gamma$: precisely the #link(<prop:adiabatic-process>)[*reversible adiabatic*] process;
+ $n -> oo$: the constraint forces $V$ to stay constant — the *isochoric* process.

Intermediate exponents describe unregulated processes — heat is exchanged, but neither $T$ nor $p$ is pinned — as @fig:polytropic-family shows.

#figure(
  image("img/polytropic-family.svg", width: 72%),
  caption: [The polytropic family $p V^n = "const"$ through a common
    state: as $n$ grows from $0$ to $oo$ the curve steepens from the
    isobar through the isotherm ($n = 1$), the adiabat ($n = gamma$),
    and beyond to the vertical isochore.],
  placement: auto,
  supplement: [Fig.],
) <fig:polytropic-family>

The slope of each member follows by differentiating $p V^n = "const"$:
$
  (dif p)/(dif V) = -n p/V,
$
so at a common state the family is ordered by $n$ — horizontal for the
isobar ($n = 0$), $-p/V$ for the isotherm ($n = 1$), $-gamma p/V$ for the
adiabat ($n = gamma$), vertical as $n -> oo$. Since $gamma > 1$, the
adiabat through a point is *steeper* than the isotherm through the same
point by exactly the factor $gamma$: expansion cools the gas, so its
pressure falls faster than at constant temperature, and adiabatic
compression climbs more steeply than isothermal compression.

#proposition(name: "Work and Heat of a Polytropic Process")[
  Along a polytropic process with $n != 1$ taking the gas from $(p_1, V_1)$ to $(p_2, V_2)$, the work done by the gas and the molar heat capacity of the process are
  $
    W = (p_1 V_1 - p_2 V_2) / (n - 1), quad
    C_(n, m) = C_(V,m) + R / (1 - n).
  $
] <prop:polytropic-process>

The special cases are consistent:

+ $n = 0$: $C_(0,m) = C_(V,m) + R = C_(p,m)$ — the isobaric value;
+ $n = 1$: $C_(n,m) -> oo$ — a finite heat absorbed at constant temperature;
+ $n = gamma$: $C_(gamma,m) = C_(V,m) - R/(gamma - 1) = 0$ — the adiabat, which exchanges no heat at all;
+ $n -> oo$: $C_(n,m) -> C_(V,m)$ — the isochore.

#proof[
  Write $p = K V^(-n)$; integrating, $W = K (V_2^(1-n) - V_1^(1-n)) / (1-n) = (p_2 V_2 - p_1 V_1) / (1-n)$. For the heat capacity, logarithmic differentiation of $p v^n = "const"$ (per mole) gives $v dif p = - n p dif v$, while the equation of state yields $p dif v + v dif p = R dif T$; eliminating $dif p$ gives $p dif v = R dif T / (1 - n)$. Substituting into $delta q = C_(V,m) dif T + p dif v$ produces $delta q = [C_(V,m) + R / (1-n)] dif T$, which is the claimed $C_(n,m)$.
]

== Throttling, Cycles and the Carnot Cycle // 节流、循环过程与卡诺循环

=== Throttling and the Joule-Thomson Effect // 节流与焦耳-汤姆逊效应

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
    mu_("JT") = ((partial T)/(partial p))_H.
  $
] <def:jt-coefficient>

#proof[
  Treat $h = h(T, p)$ for the molar enthalpy ($h = H / nu$): at
  constant $h$,
  $
    0 = ((partial h)/(partial T))_p dif T
    + ((partial h)/(partial p))_T dif p
    quad "so" quad
    mu_("JT") = - ((partial h)/(partial p))_T / C_(p,m).
  $
  With $h = u + p v$ and the identity
  $((partial u)/(partial p))_T = - T ((partial v)/(partial T))_p - p ((partial v)/(partial p))_T$ (Chapter 6),
  $
    mu_("JT") = 1/C_(p,m) [T ((partial v)/(partial T))_p - v]
    = v / C_(p,m) (T alpha - 1).
  $
]

#example(name: "Cooling by throttling")[
  For an ideal gas, $alpha = 1/T$, so
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

#note(title: "Liquefaction")[
  The throttling cooler is the core of gas liquefaction
  technology, and its efficiency analysis couples to the phase
  behaviour of real gases. The inversion curve, the liquefaction
  cycle, and the critical-point physics behind them are treated in
  Chapter 20 on phase transitions.
] <note:jt-liquefaction>

The two irreversible expansions met so far —
#link(<ex:free-expansion>)[adiabatic free expansion] and
#link(<def:jt-coefficient>)[throttling] — are both adiabatic, yet they
conserve different quantities; the table keeps them apart.

#tex-table(
  ("Item", "Adiabatic free expansion", "Throttling (Joule--Thomson)"),
  ([Heat], [$Q = 0$], [$Q = 0$]),
  ([Work], [Expansion into vacuum: $W = 0$], [Pressure on both sides: $W != 0$ is exchanged]),
  ([Conserved quantity], [Internal energy, $U = "const"$], [Enthalpy, $H = "const"$]),
  ([Ideal-gas temperature], [Unchanged], [Unchanged]),
  ([Real-gas temperature], [May rise or fall, the intermolecular potential dominating], [Fixed by the sign of $mu_("JT")$]),
  ([Typical setting], [A partition removed, the gas diffusing into vacuum], [Refrigeration, gas liquefaction]),
  ([Reversible adiabatic formulas], [Not applicable: irreversible], [Not applicable: irreversible]),
)

The last row is the one to remember: being adiabatic does not entitle a
process to #link(<prop:adiabatic-process>)[Poisson's equations] — those
describe a *quasi-static* adiabat, and neither free expansion nor
throttling is quasi-static.

=== Cyclic Processes // 循环过程

A process that returns the system to its initial state is called a *cyclic process*. Since $U$ is a state quantity, $Delta U = 0$ over *any* cycle — quasi-static or not — and the first law collapses to $W = Q$: the net work delivered equals the net heat absorbed, drawn from some reservoirs and dumped into others. Only when every leg of the cycle is quasi-static does the state of the system trace a closed curve in the $p$-$V$ plane; that picture, and the area it encloses, is what the proposition below quantifies.

#proposition(name: "Net Work as Enclosed Area")[
  For a quasi-static cycle the net work per cycle equals the area enclosed by the closed curve in the $p$-$V$ plane,
  $
    W = integral.cont p dif V,
  $
  positive for a clockwise traversal (an engine) and negative for an anticlockwise one (a refrigerator or heat pump).
] <prop:cycle-area>

#definition(name: "Thermal Reservoir and Heat Engine")[
  A *thermal reservoir* is an idealised body of fixed temperature whose
  state is unaltered by exchanging any finite amount of heat.

  A *heat engine* is a cyclic device that absorbs heat $Q_h$ from a hot reservoir at $T_h$, rejects heat $Q_c$ to a cold reservoir at $T_c < T_h$, and delivers net work $W = Q_h - Q_c$ per cycle; a *refrigerator* (or heat pump) is the same device run backwards.
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

#definition(name: "Efficiency and Coefficients of Performance")[
  A heat engine absorbs $Q_h$ and delivers work $W = Q_h - Q_c$ per cycle, whose purpose is to *deliver work*:
  $
    eta = W / Q_h = 1 - Q_c / Q_h.
  $
  A refrigerator pumps $Q_c$ out of the cold space at a work cost $W = Q_h - Q_c$, whose purpose is to *remove heat from the cold space*:
  $
    "COP"_R = Q_c / W;
  $
  a heat pump delivers $Q_h$ into the warm space; its purpose is to *deliver heat into the warm space*, so
  $
    "COP"_"HP" = Q_h / W.
  $
  (COP can exceed 1; efficiency cannot.)
] <def:efficiency-cop>

#note[
  Throughout, the subscripts label the reservoirs: $Q_h$ is the heat
  drawn from the *hot* reservoir (temperature $T_h$) and $Q_c$ the heat
  rejected to the *cold* one (temperature $T_c$).
]

#example(name: "A mixed-gas cycle")[
  A system consists of $nu_1 = 2 "mol"$ of a monatomic ideal gas mixed
  with $nu_2 = 2 "mol"$ of a rigid diatomic ideal gas, and runs the
  reversible cycle $a -> b -> c -> d -> a$ in which $a -> b$ and
  $c -> d$ are isobaric while $b -> c$ and $d -> a$ are adiabatic, with
  $T_a = 300 "K"$, $T_b = 900 "K"$, $T_c = 450 "K"$, $T_d = 150 "K"$.
  Find the heat and work of each leg and the efficiency of the cycle,
  the cycle being the one drawn in @fig:mixed-gas-cycle.

  #figure(
    image("img/mixed-gas-cycle.svg", width: 82%),
    caption: [The cycle of the mixed gas in the $p$-$V$ plane: isobaric
      expansion $a -> b$ ($300 -> 900 "K"$, absorbing $Q_(a b)$),
      adiabatic expansion $b -> c$ ($900 -> 450 "K"$), isobaric
      compression $c -> d$ ($450 -> 150 "K"$, rejecting $Q_(c d)$), and
      adiabatic compression $d -> a$ — all with $gamma = 3/2$. The
      shaded area is the net work $W = 3600 R$.],
    placement: auto,
    supplement: [Fig.],
  ) <fig:mixed-gas-cycle>

  *Heat capacities of the mixture.* Internal energies of ideal gases
  simply add, so by #link(<thm:equipartition>)[equipartition]
  $C_(V,m)^((1)) = 3/2 R$ and $C_(V,m)^((2)) = 5/2 R$, and
  $
    C_(V,m) = (nu_1 C_(V,m)^((1)) + nu_2 C_(V,m)^((2))) / (nu_1 + nu_2)
    = (3R + 5R) / 4 = 2R, quad C_(p,m) = C_(V,m) + R = 3R,
  $
  the last step being #link(<thm:mayer-formula>)[Mayer's relation], which
  survives for the mixture because, by
  #link(<law:dalton-law>)[Dalton's law], it too obeys
  $p V = (nu_1 + nu_2) R T$. Hence for the $nu = 4 "mol"$ of gas
  $nu C_(V,m) = 8R$ and $nu C_(p,m) = 12R$, and $gamma = 3/2$ — with
  which the four temperatures are consistent: the isobars fix
  $V_b / V_a = T_b / T_a = 3$ and $V_d / V_c = T_d / T_c = 1/3$, and the
  adiabatic relations close the loop,
  $V_c / V_b = (T_b / T_c)^2 = 4$, $V_d / V_a = (T_a / T_d)^2 = 4$.

  *The four legs.* With $R = 8.31 "J" dot "mol"^(-1) "K"^(-1)$:

  + $a -> b$ (isobaric heating):
    $Q_(a b) = nu C_(p,m) (T_b - T_a) = 7200 R approx 5.98 times 10^4
    "J"$, of which $W_(a b) = nu R (T_b - T_a) = 2400 R$ is work and the
    rest raises $U$;
  + $b -> c$ (adiabatic expansion): $Q = 0$ and
    $W_(b c) = -nu C_(V,m) (T_c - T_b) = 3600 R$;
  + $c -> d$ (isobaric cooling):
    $Q_(c d) = nu C_(p,m) (T_d - T_c) = -3600 R$, with
    $W_(c d) = nu R (T_d - T_c) = -1200 R$;
  + $d -> a$ (adiabatic compression):
    $W_(d a) = -nu C_(V,m) (T_a - T_d) = -1200 R$.

  The net work is $W = 3600 R approx 2.99 times 10^4 "J"$, equal to the
  net heat $Q_(a b) + Q_(c d)$, as the first law demands of a cycle.
  Only the isobar $a -> b$ absorbs heat, so
  $
    eta = W / Q_(a b) = (3600 R) / (7200 R) = 1/2,
  $
  well below #link(<prop:carnot-efficiency>)[the Carnot value]
  $eta_C = 1 - T_d / T_b = 5/6$ between the extreme temperatures of the
  cycle.

  *Mixtures in general.* For any mixture of ideal gases,
  $
    C_(V,m) = (sum_i nu_i C_(V,m)^((i))) / (sum_i nu_i), quad
    C_(p,m) = C_(V,m) + R,
  $
  because $U = sum_i nu_i C_(V,m)^((i)) T$ and
  $H = sum_i nu_i C_(p,m)^((i)) T$ are additive, while the mixture as a
  whole obeys $p V = nu R T$ with $nu = sum_i nu_i$. The ratio
  $gamma = C_(p,m) / C_(V,m)$ of the mixture then enters its adiabatic
  relations exactly as for a single gas.
] <ex:mixed-gas-cycle>

=== The Carnot Cycle // 卡诺循环

The Carnot cycle is the most efficient cycle conceivable between two reservoirs; its efficiency can be computed from the first law alone.

#definition(name: "Carnot Cycle")[
  The *Carnot cycle* is the reversible cycle of an ideal gas consisting
  of four quasi-static legs:
  $
    a -> b quad "isothermal expansion at" T_h,
  $
  absorbing $Q_h = nu R T_h ln(V_b / V_a)$ from the hot reservoir;
  $
    b -> c quad "adiabatic expansion," T_h -> T_c;
  $
  $
    c -> d quad "isothermal compression at" T_c,
  $
  rejecting $Q_c = nu R T_c ln(V_c / V_d)$ to the cold reservoir;
  $
    d -> a quad "adiabatic compression," T_c -> T_h,
  $
  closing the cycle.
  #figure(
    image("img/carnot-cycle.svg", width: 85%),
    caption: [The Carnot cycle in the $p$-$V$ plane: isothermal expansion
      $a -> b$ at $T_h$ (absorbing $Q_h$), adiabatic expansion $b -> c$
      to $T_c$, isothermal compression $c -> d$ (rejecting $Q_c$), and
      adiabatic compression $d -> a$. The enclosed area is the net work
      per cycle.],
    placement: auto,
    supplement: [Fig.],
  ) <fig:carnot-cycle>
] <def:carnot-cycle>

#proposition(name: "Carnot Efficiency")[
  The efficiency of a Carnot engine depends only on the two reservoir
  temperatures:
  $
    eta_C = 1 - T_c / T_h.
  $
] <prop:carnot-efficiency>

#proof[
  Work and heat per cycle: $W = Q_h - Q_c$ with
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
]



The derivation used nothing but the first law and the adiabatic relation.
That no engine between the same reservoirs can beat $eta_C$ is a statement of the second law, proved as #link(<thm:carnot-theorem>)[Carnot's theorem] in Chapter 3.

= Second Law of Thermodynamics // 热力学第二定律

The first law forbids energy non-conservation; it says nothing about
*direction*. Yet nature is full of one-way streets: heat flows hot to
cold and never back, gases expand freely but never recompress,
frictional heat never re-concentrates. The second law selects, among
all first-law-compliant processes, those actually allowed — and
thereby produces the entropy, the quantity that grades the direction.

== Clausius and Kelvin-Planck Statements // 克劳修斯与开尔文-普朗克表述

The cast is the one assembled in *Throttling, Cycles and the Carnot
Cycle* — thermal reservoirs at fixed temperatures, and cyclic devices
shuttling heat between them
(#link(<def:heat-engine>)[thermal reservoirs and heat engines],
@fig:reservoir-schematic).

Experience: no cyclic device absorbs heat from a single reservoir and
converts it entirely into work, however ingeniously designed.
This regularity is elevated to a law in two equivalent formulations.

#law(name: "Kelvin-Planck Statement")[
  No process is possible whose sole result is the complete conversion
  of heat, extracted from a single thermal reservoir, into work.
] <law:kelvin-planck>

#caution(title: "Perpetual motion of the second kind")[
  An engine violating
  #link(<law:kelvin-planck>)[the Kelvin-Planck statement] would be a
  *perpetual motion machine of the second
  kind*: it respects energy conservation (extracting heat from the
  ocean would power a ship forever) yet is impossible. The first law
  rules out machines of the first kind; the second law is genuinely new
  physics. Isothermal expansion of an ideal gas does convert heat to
  work completely — but it is not cyclic: the gas ends up at larger
  volume, and the *sole* result clause forbids exactly such leftover
  changes.
] <caution:perpetual-motion-ii>

#law(name: "Clausius Statement")[
  No process is possible whose sole result is the transfer of heat
  from a colder body to a hotter body.
] <law:clausius-statement>

Note that a refrigerator *does* pump heat from cold to hot — but only
at the cost of work input, so the *sole* result clause is not violated.
The two statements look different; they are the same law.

#theorem(name: "Equivalence of the Two Statements")[
  The Kelvin-Planck statement and the Clausius statement are
  equivalent: a device violating one can be combined with ordinary
  devices to violate the other.
] <thm:statement-equivalence>

#proof(name: "of the equivalence")[
  (*KP* $=>$ *C*) Suppose a device $X$ violates the Clausius
  statement: it transfers $Q$ from the cold to the hot reservoir with no
  other effect. Couple it to an ordinary heat engine $E$ that absorbs
  $Q_h$ from the hot reservoir, rejects exactly $Q$ to the cold one, and
  delivers $W = Q_h - Q$. The composite takes $Q_h - Q$ as heat from the
  single hot reservoir and delivers the same work, violating the
  Kelvin-Planck statement.

  (*C* $=>$ *KP*) Symmetrically, suppose a device $X$ violates
  Kelvin-Planck: it absorbs $Q_h$ from the hot reservoir and converts it
  entirely into work $W$. Run $W$ into an ordinary refrigerator $R$
  pumping $Q_c$ from the cold reservoir and dumping $Q_c + W$ into the
  hot one. The composite transfers $Q_c$ from cold to hot with no other
  effect — violating the Clausius statement.
]

== Carnot's Theorem // 卡诺定理

The Carnot cycle was defined, and its efficiency
$eta_C = 1 - T_c / T_h$ computed, in *Throttling, Cycles and the Carnot
Cycle* from the first law alone.
What the second law contributes is universality: no engine operating
between the same two reservoirs, however ingenious its design, can
exceed the Carnot efficiency.

#theorem(name: "Carnot's Theorem")[
  + All reversible engines operating between the same two reservoirs have the same efficiency $eta_C = 1 - T_c / T_h$;
  + every irreversible engine operating between them has strictly smaller efficiency.
] <thm:carnot-theorem>

#proof(name: "of Carnot's theorem")[
  Let $I$ be any engine between the reservoirs, and $R$ a
  Carnot (reversible) engine run *backwards* as a refrigerator, sized so
  that it absorbs exactly the heat $Q_c$ that $I$ rejects. The composite
  $I R$ then delivers work
  $
    W = Q_h - Q_c - (Q_h' - Q_c) = Q_h - Q_h',
  $
  takes no net heat from the cold reservoir, and extracts net heat
  $Q_h - Q_h'$ from the hot one.

  Both engines reject the same $Q_c$ to the cold reservoir, so
  $eta = 1 - Q_c / Q_h$ turns $eta_I > eta_R$ into
  $Q_c / Q_h < Q_c / Q_h'$, i.e. $Q_h > Q_h'$: the composite then
  delivers $W = Q_h - Q_h' > 0$ while drawing heat from the single hot
  reservoir only — a sole-result work producer, violating
  #link(<law:kelvin-planck>)[Kelvin-Planck]. Hence $eta_I <= eta_R$.

  The strict inequality for an irreversible $I$ is *not* reached by this
  coupling, nor by "running $I$ backwards" — an irreversible engine
  admits no reverse operation. It follows instead from the strict
  #link(<prop:clausius-inequality>)[Clausius inequality], as shown in
  *Entropy and the Clausius Inequality*.
]

Conversely, #link(<thm:carnot-theorem>)[Carnot's theorem] delivers the
#link(<law:kelvin-planck>)[Kelvin-Planck statement].
An engine violating Kelvin-Planck rejects no heat at all, so its
efficiency is $eta = 1 > 1 - T_c / T_h$ for any $T_c > 0$ — above the
Carnot bound.
The bound and the Kelvin-Planck statement are therefore equivalent, and
so is the #link(<law:clausius-statement>)[Clausius statement], by
#link(<thm:statement-equivalence>)[the equivalence of the two
  statements].

Carnot's theorem caps every real engine: no cleverness of design beats
$1 - T_c / T_h$ — the only levers are the reservoir temperatures, and
#link(<caution:perpetual-motion-ii>)[perpetual motion of the second kind]
stays out of reach.
What remains is to convert this cap into a state function, which is the
business of *Entropy and the Clausius Inequality*.

== Entropy and the Clausius Inequality // 熵与克劳修斯不等式

#theorem(name: "Clausius Inequality")[
  For any cyclic process of a closed system,
  $
    integral.cont (delta Q) / T <= 0,
  $
  where $delta Q$ is the heat absorbed by the system at each stage and
  $T$ is the temperature *at the boundary* where the heat is exchanged.
  Equality holds if and only if the cycle is reversible.
] <prop:clausius-inequality>

#proof(name: "of the Clausius inequality")[
  Decompose an arbitrary cycle into a fine mesh: each elementary strip
  exchanges heat $delta Q_i$ with a reservoir at the boundary temperature
  $T_i$.
  By #link(<thm:carnot-theorem>)[Carnot's theorem], a reversible engine
  working between $T_i$ and a reference temperature $T_0$ — chosen below
  every $T_i$ — satisfies $delta W_i = delta Q_i (1 - T_0 / T_i)$, and
  the actual strip delivers at most this work:
  $delta Q_i (1 - T_0 / T_i) >= delta W_i$.

  Summing over the whole cycle and using
  $sum delta W_i = integral.cont delta Q$ (net heat equals net work over
  a cycle),
  $
    integral.cont delta Q - T_0 integral.cont (delta Q) / T >= integral.cont delta Q
    quad "hence" quad integral.cont (delta Q) / T <= 0.
  $
  Equality holds exactly when every elementary engine is reversible,
  i.e. the cycle is reversible; for an irreversible cycle the inequality
  is strict.
]

The strict form of #link(<thm:carnot-theorem>)[Carnot's theorem] is now a
one-line consequence.
A cycle working between reservoirs at $T_h$ and $T_c$ absorbs $Q_h$ at
$T_h$ and $-Q_c$ at $T_c$, so strictness reads
$Q_h / T_h - Q_c / T_c < 0$ for an irreversible cycle; with
$eta = 1 - Q_c / Q_h$ this is exactly $eta < 1 - T_c / T_h$.

#definition(name: "Entropy")[
  The *entropy* of a system is the state function $S$, defined up to an
  additive constant, whose change between two nearby equilibrium states
  is
  $
    dif S = (delta Q_("rev")) / T,
  $
  the heat absorbed in a *reversible* path divided by the common
  temperature. For a finite reversible path from $A$ to $B$,
  $
    Delta S = S_B - S_A = integral_A^B (delta Q_("rev")) / T.
  $
] <def:entropy>

That $S$ exists — that the integral is path-independent — follows from
the equality case of #link(<prop:clausius-inequality>)[the Clausius
  inequality], and is the content of
#link(<prop:entropy-state-function>)[the next proposition].

#proposition(name: "Entropy Is a State Function")[
  For any reversible cycle,
  $
    integral.cont (delta Q_("rev")) / T = 0.
  $
  Consequently $integral_A^B (delta Q_("rev")) / T$ along reversible
  paths depends only on the endpoints, and $S$ is well-defined as a state
  quantity.
] <prop:entropy-state-function>

#proof(name: "of the state-function property")[
  Every reversible cycle satisfies the Clausius inequality with
  equality.
  Given any two states $A, B$, the integral along a reversible path is
  therefore independent of which reversible path is chosen — for two such
  paths form a reversible cycle.
]

The entropy of an irreversible process is *not* obtained by integrating
$(delta Q)/T$ along that process; one integrates along any *reversible*
path connecting the same endpoints, as in
#link(<def:entropy>)[the definition] — the distinction is the subject of
#link(<caution:heat-vs-entropy>)[the caution below].

#proposition(name: "Entropy of an Ideal Gas")[
  The entropy change of a closed ideal gas of constant molar heat
  capacities between two states, evaluated along a *reversible* path, is
  $
    Delta S = nu C_(V,m) ln(T_2 / T_1) + nu R ln(V_2 / V_1),
  $
  or equivalently, with pressure in place of volume,
  $
    Delta S = nu C_(p,m) ln(T_2 / T_1) - nu R ln(p_2 / p_1).
  $
] <prop:entropy-ideal-gas>

#proof(name: "of the ideal-gas entropy")[
  For a reversible change of $nu$ moles,
  $
    delta Q = dif U + p dif V
    = nu C_(V,m) dif T + nu R T (dif V) / V,
  $
  by #link(<prop:joule-law>)[Joule's law], so
  $
    dif S = (delta Q)/T
    = nu C_(V,m) (dif T)/T + nu R (dif V)/V,
  $
  and integrating from state $1$ to state $2$ gives the volume form.

  For the pressure form write $V = nu R T / p$, so that
  $dif V / V = dif T / T - dif p / p$:
  $
    dif S = nu (C_(V,m) + R) (dif T)/T - nu R (dif p)/p
    = nu C_(p,m) (dif T)/T - nu R (dif p)/p,
  $
  where #link(<thm:mayer-formula>)[Mayer's formula] supplies
  $C_(p,m) - C_(V,m) = R$ for the ideal gas.
]

The two forms are one and the same statement, related by the equation of
state; either may be kept as the master formula.
Both are *universal* — they hold along any reversible path whatsoever —
and, because $S$ is a state function, the value they return depends on
the endpoints alone.
The path an irreversible process actually follows therefore never enters
the computation.

Each standard process of *Common Thermodynamic Processes* pins one state
variable, so one term of the master formula drops out:

#tex-table(
  ("Process", "Constraint", [$Delta S$]),
  ([isochoric], [$V = "const"$], [$nu C_(V,m) ln(T_2 / T_1)$]),
  ([isobaric], [$p = "const"$], [$nu C_(p,m) ln(T_2 / T_1)$]),
  ([isothermal], [$T = "const"$], [$nu R ln(V_2 / V_1) = -nu R ln(p_2 / p_1)$]),
  ([reversible adiabatic], [$Q = 0$], [$0$]),
)

The last row is the entropy face of
#link(<prop:adiabatic-process>)[the reversible adiabatic relation].
Setting $Delta S = 0$ gives
$C_(V,m) ln(T_2 / T_1) + R ln(V_2 / V_1) = 0$, which with
$gamma - 1 = R / C_(V,m)$ is exactly $T V^(gamma - 1) = "const"$.

#caution(title: "$(delta Q)/T$ versus $dif S$: reversibility required")[
  Only on a reversible path is $delta Q = T dif S$.
  Along an irreversible path the absorbed heat is smaller than
  $integral T dif S$ (for the same endpoints), and writing
  $dif S = (delta Q)/T$ for an irreversible step silently shrinks the
  entropy.

  The same restriction governs every row of the table above: the
  isochoric, isobaric, isothermal and adiabatic formulas describe
  *reversible* processes, and none of them may be applied to the actual
  run of an irreversible one.

  What replaces the actual process is a path the gas never followed: one
  *invents* a reversible path between the same endpoints and integrates
  along it, precisely because $S$ is a state function.
  Free expansion is the model case — sudden and irreversible, its entropy
  change is computed on an isothermal path, in
  #link(<ex:free-expansion-adiabatic>)[the second example below].
] <caution:heat-vs-entropy>

#example(name: "Entropy across phase transitions")[
  Take $m = 30 "g"$ of ice at $-40$ °C, i.e. $T_0 = 233.15 "K"$, and let
  it become steam at $100$ °C, i.e. $T_1 = 373.15 "K"$, all at one
  atmosphere.
  Say the ice is dropped into a hot oven: the actual process is violent
  and irreversible, and $integral (delta Q)/T$ along it is meaningless.

  The way out is the one the caution above prescribes — invent a
  *reversible* path between the same endpoints and traverse it infinitely
  slowly.
  Heat the ice to $273.15 "K"$, melt it there, heat the water to
  $373.15 "K"$, vaporise it there.
  Every stage exchanges heat with a reservoir whose temperature differs
  from the body's by an infinitesimal, so $dif S = (delta Q_("rev")) / T$
  applies stage by stage.
  A phase transition needs a stage of its own, because the body then
  absorbs latent heat at a *fixed* temperature.

  With $c_"ice" = 2.1$ and $c_"water" = 4.2$ (in
  $"J" "g"^(-1) "K"^(-1)$), and latent heats $lambda = 334$ and
  $L = 2260$ (in $"J"/"g"$),

  #tex-table(
    ("Stage", "Reversible step", [$Delta S$], [value / ($"J/K"$)]),
    ([1], [ice heats $233.15 -> 273.15 "K"$], [$m c_"ice" ln(273.15/233.15)$], [9.98]),
    ([2], [ice melts at $273.15 "K"$], [$m lambda / 273.15$], [36.68]),
    ([3], [water heats $273.15 -> 373.15 "K"$], [$m c_"water" ln(373.15/273.15)$], [39.31]),
    ([4], [water vaporises at $373.15 "K"$], [$m L / 373.15$], [181.70]),
  )

  and the four contributions add to
  $Delta S = 267.7 "J/K" approx 2.7 times 10^2 "J/K"$.

  Two working rules follow.
  A heating stage obeys $delta Q_("rev") = m c dif T$ at constant
  pressure, hence $Delta S = m c ln(T_2 / T_1)$ with $c$ the specific
  heat of that phase.
  A phase transition contributes $m lambda / T_"tr"$ instead — no
  logarithm, because the whole latent heat crosses the boundary at a
  single temperature.
  Splitting the path at every transition is therefore the rule, not a
  technicality.

  The first law would report only the total heat, $Q = 92.9 "kJ"$, which
  is *not* the entropy change.
  Had the oven been held at $473.15 "K"$, its entropy would fall by
  $Q / 473.15 "K" approx 196 "J/K"$, leaving
  $Delta S_("universe") approx +71 "J/K" > 0$: the irreversibility of the
  actual process, now visible in numbers.
] <ex:phase-transition-entropy>

#example(name: "Adiabatic free expansion")[
  Let $nu$ moles of ideal gas occupy $V_1$ at temperature $T$; the tap to
  an evacuated vessel is opened and the gas fills $V_2 > V_1$, thermally
  insulated throughout.
  No work is done — the expansion is unresisted, $W = 0$ — and no heat
  crosses the wall, $Q = 0$.
  Hence $Delta U = 0$, and by #link(<prop:joule-law>)[Joule's law] the
  temperature is unchanged: the final state is $(V_2, T)$.

  The step is adiabatic, yet it is *not* the reversible adiabatic process
  of the table above, and $Delta S$ is *not* zero.
  Compute it on the fictitious reversible path between the same
  endpoints, here the isothermal one, with the $(T, V)$ form of
  #link(<prop:entropy-ideal-gas>)[the ideal-gas entropy]:
  $
    Delta S = nu R ln(V_2 / V_1) > 0.
  $

  The contrast with the reversible adiabat is the point of the example.
  From the same initial state $(V_1, T)$, a *reversible* adiabatic
  expansion to the same volume $V_2$ ends at
  $
    T' = T (V_1 / V_2)^(gamma - 1) < T,
  $
  and has $Delta S = 0$: the gas pays for its lost heat by doing work and
  cools down.
  Free expansion pays nothing and gets nothing back — both $Q$ and $W$
  vanish — so the gas arrives at $V_2$ with its temperature intact, and
  with entropy produced along the way.

  "Adiabatic" fixes $Q = 0$; only "reversible adiabatic" fixes
  $Delta S = 0$.
] <ex:free-expansion-adiabatic>

== The Microscopic Meaning of Entropy // 熵的微观意义

The second law so far is a set of macroscopic prohibitions.
This section opens the box and looks at the molecules: the three
signature irreversibilities of nature all push a system of many molecules
from ordered towards disordered motion, and the quantity that measures
this disorder turns out to be nothing other than the entropy itself.

=== From Order to Disorder // 从有序到无序

Three everyday irreversibilities make the pattern visible:

- *work-heat conversion*: work can be converted completely into heat — rub your hands and they warm up — but heat can never be converted completely into work in a cycle, as #link(<law:kelvin-planck>)[the Kelvin-Planck statement] forbids;
- *heat conduction*: heat flows spontaneously from hot to cold and never back of its own accord;
- *free expansion*: a gas released into vacuum expands spontaneously and never recompresses itself.

In each case the reverse process is not forbidden by energy conservation — the first law would happily allow it — yet it never happens.
What the three share is the fate of the molecules: motion initially concentrated (a falling weight, a hot body, a gas confined to one corner) spreads out over many molecules moving incoherently.
Natural processes always proceed in the direction that carries the motion of large numbers of molecules from *order* towards *disorder*.

Each is now accounted for: free expansion macroscopically
(#link(<ex:free-expansion-adiabatic>)[above]) and by counting microstates
(below); heat conduction and dissipation in the examples that follow.

=== Thermodynamic Probability // 热力学概率

"Disorder" must be made countable.
Distinguish the two levels of description: a *microstate* specifies the position and velocity of every molecule, while a *macrostate* specifies only coarse quantities — the pressure, the temperature, and how the molecules are distributed.
Many microstates typically correspond to one macrostate, and their number is the
#link(<def:thermodynamic-probability>)[thermodynamic probability] $Omega$ of that macrostate.

#definition(name: "Thermodynamic Probability")[
  The *thermodynamic probability* of a macrostate is the number $Omega$ of microstates (microscopic configurations) compatible with it.
] <def:thermodynamic-probability>

#example(name: "Four Molecules in a Two-Compartment Box")[
  Divide an isolated box into left and right halves and place $N = 4$
  distinguishable molecules $a, b, c, d$ inside.
  A microstate assigns each molecule to a side; a macrostate only counts
  them: $k$ molecules on the left and $4 - k$ on the right.
  There are $2^4 = 16$ microstates in all, distributed among the five
  macrostates as

  #tex-table(
    ([macrostate], [$k = 0$], [$k = 1$], [$k = 2$], [$k = 3$], [$k = 4$]),
    ([microstates $Omega$], [$1$], [$4$], [$6$], [$4$], [$1$]),
  )

  The counts are the binomial coefficients $binom(4, k)$ — one row of
  Pascal's triangle.
] <ex:four-molecule-model>

#note(title: "Equal a priori probabilities")[
  The dynamical input of the whole construction is a single assumption:
  for an isolated system in equilibrium, all microstates occur with equal
  probability.
  It is the statistical counterpart of "no position in the box is
  special".
] <note:equal-a-priori>

With equal weights, the probability of finding the macrostate with $k$
molecules on the left is
$P(k) = Omega / 2^4 = binom(4, k) / 16$, giving
$1/16, 4/16, 6/16, 4/16, 1/16$ across the five macrostates.
The equilibrium macrostate — here $k = 2$, where the gas fills both
halves uniformly — is the one with the *largest* $Omega$, exactly as
#link(<ex:four-molecule-model>)[the four-molecule model] displays.
As $N$ grows to macroscopic values $N ~ 10^23$ the maximum sharpens so
much that fluctuations away from uniformity become unobservably rare.

The conclusion is general: $Omega$ measures the *disorder* of molecular motion, and the equilibrium state is the most disordered one.

=== Boltzmann Entropy // 玻尔兹曼熵

The logarithm is not an ansatz but a necessity.
For two *independent* systems the compatible microstates multiply,
$Omega_12 = Omega_1 Omega_2$, while entropy as an extensive quantity must
add, $S_12 = S_1 + S_2$; only the logarithm turns products into sums, so
$S prop ln Omega$ up to one universal constant.
The #link(<def:boltzmann-entropy>)[Boltzmann entropy]
$S = k_B ln Omega$ declares that constant to be the $k_B$ of
$R = N_A k_B$; that the two agree is the content of the next theorem.

#definition(name: "Boltzmann Entropy")[
  For a macrostate of an isolated system, let $Omega$ be the number of
  microstates (microscopic configurations) compatible with it. The
  *Boltzmann entropy* of the macrostate is
  $
    S = k_B ln Omega,
  $
  where $k_B = R / N_A$ is the Boltzmann constant of Chapter 1.
] <def:boltzmann-entropy>

#theorem(name: "Identification with the Clausius Entropy")[
  For a dilute gas, the Boltzmann entropy reproduces the
  thermodynamic entropy of #link(<def:entropy>)[the Clausius
    definition]: in a quasi-static isothermal expansion from $V_1$ to
  $V_2$,
  $
    Delta S = k_B ln (Omega_2 / Omega_1)
    = N k_B ln (V_2 / V_1)
    = nu R ln (V_2 / V_1),
  $
  which equals $Q_"rev" / T$.
] <thm:boltzmann-identification>

#proof(name: "of the identification")[
  At fixed temperature the momentum part of the phase-space volume is
  unaffected by a change of volume, and each of the $N$ molecules is
  free to roam the whole container, so the number of microstates
  compatible with a macrostate at volume $V$ scales as
  $Omega prop V^N$; hence
  $
    Delta S = k_B ln (Omega_2 / Omega_1)
    = N k_B ln (V_2 / V_1)
    = nu N_A k_B ln (V_2 / V_1)
    = nu R ln (V_2 / V_1).
  $
  On the thermodynamic side, the quasi-static isothermal expansion of an
  ideal gas absorbs $Q_"rev" = W = nu R T ln (V_2 / V_1)$
  (*Common Thermodynamic Processes*), so the Clausius definition gives
  $Delta S = Q_"rev" / T = nu R ln (V_2 / V_1)$.
  The two agree identically, and the proportionality constant of
  $S prop ln Omega$ is thereby fixed as $k_B$.
]

#note(title: "Heuristic standing of the counting")[
  The argument above presumes a fixed-temperature count of microstates,
  i.e. the canonical ensemble, which is constructed only in Chapter 12.
  What is settled here is the proportionality $S prop ln Omega$ together
  with its constant; the rigorous identification of the two entropies is
  the bridge built there.
]

This dovetails with the kinetic theory of Chapter 1: Boltzmann's
$H$-function decreases monotonically under collisions, and
#link(<note:h-statistical>)[its statistical interpretation] as a negative
logarithm of molecular disorder prefigures exactly the construction
above.

The identification of
#link(<thm:boltzmann-identification>)[Boltzmann and Clausius entropy]
extends far beyond this example — to the entropy of mixing, to the
equilibration of heat flow, and to the whole ensemble programme of
Chapters 11--15 — and it is this agreement that makes $k_B$ the exchange
rate between information and heat.

=== The Entropy Increase Principle // 熵增原理

Which processes actually realise $Delta S > 0$?
By #link(<def:reversible-process>)[the criterion of a reversible
  process], exactly the irreversible ones — and the microscopic picture now
makes the principle quantitative.

#law(name: "Principle of Entropy Increase")[
  For any process of an isolated system,
  $
    Delta S >= 0 quad "with equality iff the process is reversible."
  $
  Equivalently, for any process whatsoever,
  $
    Delta S_("system") + Delta S_("environment") >= 0.
  $
] <law:entropy-increase>

#proof(name: "of the entropy increase")[
  Take an irreversible process carrying an isolated system from
  $A$ to $B$; the Clausius inequality applied to the cycle formed by the
  actual process and an arbitrary reversible return path $B -> A$ gives
  $
    integral_A^B (delta Q) / T + integral_B^A (delta Q_("rev")) / T <= 0,
  $
  and the first integral vanishes ($delta Q = 0$ in isolation), so
  $Delta S = S_B - S_A >= 0$, strict for the irreversible process.
  For a non-isolated system, enlarge the boundary: system plus
  environment is isolated, and their entropy sum obeys the same
  inequality — the caveat of
  #link(<caution:entropy-nonisolated>)[non-isolated systems] makes this
  explicit.
]

Microscopically, the principle is a statement about probability.
Under #link(<note:equal-a-priori>)[equal a priori probabilities] an
isolated system wanders through its microstates with equal weights, so
macrostates with larger $Omega$ are visited overwhelmingly more often: a
system found in a macrostate of small $Omega$ drifts, with overwhelming
probability, towards one with larger $Omega$.

In Boltzmann's language the entropy change of any spontaneous process
reads $Delta S = k_B ln (Omega_2 / Omega_1) >= 0$ — *irreversibility is
the drift towards the probable*, and a reversible process is one that
leaves $Omega$ unchanged.
This is the microscopic reading of the three phenomena with which this
section opened.

#example(name: "Free expansion, counted")[
  The free expansion of #link(<ex:free-expansion-adiabatic>)[the previous
    section] arrived at $Delta S = nu R ln(V_2/V_1)$ along a fictitious
  reversible path.
  Counting microstates reaches the same number.
  At fixed temperature the momentum part of phase space does not change,
  and each molecule may roam the whole container, so $Omega prop V^N$: the
  macrostate at $V_2$ carries $(V_2/V_1)^N$ times the microstates of the
  one at $V_1$, and
  $
    Delta S = k_B ln(Omega_2 / Omega_1)
    = N k_B ln(V_2 / V_1) = nu R ln(V_2 / V_1),
  $
  as #link(<thm:boltzmann-identification>)[the identification theorem]
  requires.

  The gas is not forbidden to run backwards; it is that the original
  macrostate occupies a fraction $(V_1/V_2)^N$ of all microstates —
  unobservably small for macroscopic $N$.
  The entropy increase is that improbability, and it fulfils the
  promissory note of
  #link(<ex:free-expansion>)[the free-expansion example].
] <ex:free-expansion-entropy>

#note(title: "Gibbs paradox")[
  The counting $Omega prop V^N$ behind
  #link(<ex:free-expansion-entropy>)[that example] is one step short of
  a paradox.
  Take two samples of the *same* gas, each of amount $nu$ and volume
  $V$, at the same temperature, and remove the wall between them: the
  gas then occupies $2V$, and the same reasoning gives
  $Delta S = 2 nu R ln 2 > 0$ — entropy has been created by doing
  nothing at all.

  The bookkeeping betrays the same fault. Since
  $S = k_B ln Omega$ grows like $N k_B ln V$, merging the two samples
  (doubling both $N$ and $V$) yields
  $S = 2 S_0 + 2 nu R ln 2$: the entropy of the union exceeds the sum of
  the parts, and $S$ is not extensive.

  Both symptoms vanish once identical molecules are treated as
  *indistinguishable*: their permutations are not distinct microstates,
  so the count carries a factor $1\/(N!)$ and
  $S = k_B ln(Omega\/(N!))$ becomes extensive — the Sackur--Tetrode
  entropy of a monatomic gas.
  Mixing two *identical* gases then produces no entropy, while
  #link(<ex:mixing-dissipation>)[mixing distinct ones] still does, for
  those are genuinely different arrangements.
  Gibbs found the rule long before quantum mechanics explained it:
  indistinguishability is a quantum property, and the classical count is
  its shadow in the limit $h -> 0$; the systematic account belongs to
  the microcanonical ensemble of Chapter 12.
] <note:gibbs-paradox>

#example(name: "Heat conduction")[
  Heat $Q$ flows directly from a body at $T_h$ to a
  body at $T_c < T_h$. Each body changes at fixed temperature, so
  $
    Delta S = Q / T_c - Q / T_h = Q (1/T_c - 1/T_h) > 0:
  $
  conduction across a finite temperature difference generates entropy
  — precisely why it is irreversible, and why reversible heat exchange
  requires reservoirs differing infinitesimally.
] <ex:heat-transfer-entropy>

#example(name: "A cascade of reservoirs")[
  A body of constant heat capacity $C$, initially at $T_i$, is to be
  brought to $T_f > T_i$. Its own entropy change is
  $
    Delta S_"body" = integral_(T_i)^(T_f) C/T dif T = C ln(T_f/T_i)
  $
  along *any* route — entropy is a state function — so reversibility
  hinges entirely on what the environment does.

  + *One reservoir at $T_f$.* The body absorbs $Q = C (T_f - T_i)$ from a
    reservoir held at $T_f$, whose entropy therefore drops by $Q/T_f$:
    $
      Delta S_1 = C [ln(T_f/T_i) - 1 + T_i/T_f] >= 0,
    $
    with equality only for $T_i = T_f$. Heat crossing a finite
    temperature difference has produced entropy: the process is
    irreversible.

  + *One intermediate reservoir at $T_1$, $T_i < T_1 < T_f$.* The body is
    heated from $T_i$ to $T_1$ by a reservoir at $T_1$, then from $T_1$ to
    $T_f$ by the reservoir at $T_f$. Only the environmental term moves,
    $
      Delta S_2 = C ln(T_f/T_i)
      - C (T_1 - T_i)/T_1 - C (T_f - T_1)/T_f,
    $
    and
    $
      Delta S_1 - Delta S_2
      = C (T_1 - T_i) (1/T_1 - 1/T_f) > 0.
    $
    Splitting the jump in two has reduced the entropy produced without
    removing it.

  With $n$ reservoirs at $T_k = T_i (T_f/T_i)^(k/n)$ — equally spaced in
  $ln T$ — every step meets the same ratio
  $T_(k-1)/T_k = r := (T_i/T_f)^(1/n)$, and the same accounting gives
  $
    Delta S_n = C [ln(T_f/T_i) - n (1 - r)] = n C (r - 1 - ln r),
  $
  so $n = 1$ is the first question above and $n = 2$, with
  $T_1 = sqrt(T_i T_f)$, the second. Writing $a = ln(T_f/T_i)$ and
  $r = e^(-a/n)$,
  $
    Delta S_n = n C (e^(-a/n) - 1 + a/n) approx C a^2/(2 n) -> 0
    quad (n -> infinity).
  $
  Infinitely many reservoirs make each transfer occur across an
  infinitesimal $dif T$: the body then follows a
  #link(<def:reversible-process>)[reversible] path, and
  #link(<law:entropy-increase>)[the principle of entropy increase] is
  saturated. Irreversibility is thus a matter of degree, with reversible
  processes as the limit that finite cascades approach but never attain.
] <ex:reservoir-cascade>

#example(name: "Mixing and dissipation")[
  Two ideal gases at the same temperature and pressure, in volumes $V_1$
  and $V_2$, are put into communication and mix.
  Each behaves as if it expanded into the whole volume at fixed
  temperature, so with mole fractions $x_i = nu_i / (nu_1 + nu_2)$,
  $
    Delta S = -nu R (x_1 ln x_1 + x_2 ln x_2) > 0.
  $
  Dissipation is the same story in mechanical dress: work $W_"diss"$
  spent on friction ends as heat at temperature $T$, creating entropy
  $Delta S = W_"diss" / T$.
  The first law sees nothing in either process — energy is conserved
  throughout — yet both are forbidden in reverse by
  #link(<law:entropy-increase>)[the principle of entropy increase].
  Chemical reactions belong to the same family, their entropy accounting
  being the affair of Chapter 7.
] <ex:mixing-dissipation>

#caution(title: "Entropy of non-isolated systems")[
  The entropy of a *system* may decrease: a refrigerator pumps heat out
  of its cold box, freezing water crystallises, living organisms build
  order — each at the price of exporting more entropy to the environment.
  #link(<law:entropy-increase>)[The principle of entropy increase] constrains
  only the *total*:
  $Delta S_("system") + Delta S_("environment") >= 0$ holds without
  exception.
] <caution:entropy-nonisolated>

The examples of this section, together with the processes of
*Common Thermodynamic Processes*, form a catalogue worth keeping at
hand: for each familiar process, the sign of the entropy change of the
*system*.

#tex-table(
  ("Process", "$Delta S$ of the system", "Comment"),
  ([Mixing two different ideal gases at fixed $T$, $p$], [$-nu R sum_i x_i ln x_i$], [$> 0$; for identical gases $0$]),
  ([Adiabatic free expansion of an ideal gas], [$nu R ln(V_2/V_1)$], [$> 0$; adiabatic yet not isentropic]),
  ([Throttling of an ideal gas], [$nu R ln(p_1/p_2)$], [$> 0$ although $T$ does not change]),
  ([Heat conduction across a finite $dif T$], [$Q (1/T_c - 1/T_h)$], [$> 0$; a finite gap always costs entropy]),
  ([Melting or boiling at fixed $T$], [$L/T$], [$> 0$; latent heat $L$ absorbed]),
  ([Heating at fixed $V$ or $p$], [$nu C ln(T_2/T_1)$], [$> 0$]),
  ([Friction and viscous dissipation], [$W_"diss"/T$], [$> 0$; work degraded into heat]),
  ([Cooling at fixed $V$ or $p$], [$nu C ln(T_2/T_1)$], [$< 0$; entropy exported]),
  ([Isothermal compression of an ideal gas], [$nu R ln(V_2/V_1)$], [$< 0$; the heat released carries the entropy away]),
  ([Condensation or freezing at fixed $T$], [$-L/T$], [$< 0$; latent heat $L$ released]),
  ([Reversible adiabatic process], [$0$], [quasi-static and dissipation-free; #link(<prop:adiabatic-process>)[Poisson's equations] apply]),
  ([Any complete cycle], [$0$], [entropy is a state function]),
)

#caution(title: "Adiabatic, isothermal, isentropic")[
  Three adjectives that are routinely confused.

  - *Adiabatic is not isentropic.* Free expansion and throttling of an
    ideal gas both have $Q = 0$ and both raise $S$; only a *reversible*
    adiabatic process is isentropic.
  - *Isothermal is not isentropic.* Compressing an ideal gas at fixed
    $T$ lowers its entropy, the heat released carrying the difference
    into the surroundings.
  - *Fixed temperature is not fixed entropy.* Throttling an ideal gas
    leaves $T$ untouched and still creates entropy.

  What the second law forbids is a decrease of the *total*, not of the
  system: every entry with $Delta S < 0$ above is paid for by a larger
  increase outside the system.
]

== Thermodynamic Temperature Scale // 热力学温标

The efficiency bound $eta_C = 1 - T_c / T_h$ rests on the temperatures
of the reservoirs — but which temperature?
The ideal-gas scale of
#link(<prop:ideal-gas-scale>)[the ideal-gas temperature scale] referenced
a particular substance.
Carnot's theorem offers something better: a temperature scale defined by
the second law itself, independent of any material.

#theorem(name: "Universality of the Heat Ratio")[
  For reversible engines operating between two reservoirs, the ratio of
  the exchanged heats depends only on the two reservoirs:
  $
    Q_h / Q_c = f(theta_h, theta_c),
  $
  where $theta$ denotes any empirical temperatures.
] <thm:heat-ratio>

#proof(name: "of the heat-ratio universality")[
  Let two reversible engines $R_1$ (between $theta_1, theta_2$) and $R_2$
  (between $theta_2, theta_3$) be coupled, with $R_2$ consuming exactly
  what $R_1$ rejects at $theta_2$.
  The composite is a reversible engine between $theta_1$ and $theta_3$, so
  $
    f(theta_1, theta_3) = f(theta_1, theta_2) dot f(theta_2, theta_3).
  $
  Fix an arbitrary reference $theta_0$; the identity
  $f(theta_1, theta_0) = f(theta_1, theta_2) dot f(theta_2, theta_0)$
  then forces $f(theta_1, theta_2) = phi(theta_1) / phi(theta_2)$ with
  $phi(theta) := f(theta, theta_0)$, a single function, positive because
  engines exchange positive heats.
  Choosing $T := c dot phi(theta)$, with $c$ fixed by convention, gives
  $Q_h / Q_c = T_h / T_c$.
]

That $f$ is system-independent licenses a *new* temperature: the
*absolute temperature* $T$ is defined — up to the multiplicative
constant $c$ — as the quantity satisfying
$
  Q_h / Q_c = T_h / T_c
$
for every reversible engine between the reservoirs.

The reference constant is fixed by assigning $T = 273.16 "K"$ to the
triple point of water — the same convention as the gas scale.
(Since the 2019 SI revision the kelvin is defined by fixing $k_B$
instead, and the triple point has become a measured quantity; the
construction above is how the scale was established historically.)

#proposition(name: "Equivalence of the Carnot and Ideal-Gas Scales")[
  The absolute temperature of
  #link(<thm:heat-ratio>)[the universal heat ratio] coincides with
  the ideal-gas temperature of
  #link(<prop:ideal-gas-scale>)[the ideal-gas scale].
] <prop:scales-equivalence>

#proof(name: "of the scale equivalence")[
  Compute the Carnot cycle of
  #link(<def:carnot-cycle>)[the Carnot cycle] using the *gas* scale
  $theta$ throughout the equation of state $p V = nu R theta$: the
  derivation of #link(<prop:carnot-efficiency>)[the Carnot efficiency]
  never used any property of $T$ beyond the equation of state, and it
  produced
  $
    Q_h / Q_c = theta_h / theta_c.
  $
  Thus the gas scale satisfies the defining relation of the absolute
  scale; both scales fix the same value at the triple point of water, so
  they are identical.
]

This closes the account opened in
#link(<note:kelvin-scale>)[the note on the absolute scale]: temperature
now rests on the second law alone, and every thermometer — gas,
resistance, or otherwise — measures the same $T$.
The #link(<ex:engine-numerical>)[numerical work-out] puts the scale to
use.

== Heat Engines and Refrigeration Cycles // 热机与制冷循环

The
#link(<def:efficiency-cop>)[efficiency and coefficients of performance]
were defined in *Throttling, Cycles and the Carnot Cycle*; combined with
#link(<thm:carnot-theorem>)[Carnot's theorem] they become absolute bounds
on any cyclic device operating between two reservoirs.

#proposition(name: "Carnot Bounds")[
  Any engine between reservoirs at $T_h, T_c$ satisfies
  $
    eta <= 1 - T_c / T_h, quad
    "COP"_R <= T_c / (T_h - T_c), quad
    "COP"_"HP" <= T_h / (T_h - T_c),
  $
  with equality exactly for reversible (Carnot) devices.
] <prop:carnot-bounds>

#proof(name: "of the Carnot bounds")[
  The efficiency bound is
  #link(<thm:carnot-theorem>)[Carnot's theorem] itself. For a
  refrigerator, suppose the bound were violated,
  $"COP"_R > T_c / (T_h - T_c)$, and drive the refrigerator with a
  Carnot engine between the same reservoirs, sized to deliver the work
  $W$ it consumes — the engine absorbs $Q_h' = W / eta_C$ and, being
  reversible, rejects exactly $W T_c / (T_h - T_c)$ to the cold
  reservoir, strictly less than the $Q_c = W dot "COP"_R$ the
  refrigerator extracts. The composite transfers
  $Q_c - W T_c / (T_h - T_c) > 0$ from cold to hot with no other
  effect — violating #link(<law:clausius-statement>)[the Clausius
    statement]. The heat-pump bound follows from
  $"COP"_"HP" = "COP"_R + 1$.
]

#example(name: "Numerical work-out")[
  A Carnot engine operates between $T_h = 600
  "K"$ and $T_c = 300 "K"$ with $Q_h = 1000 "J"$ per cycle:
  $
    eta_C = 1 - 300 / 600 = 0.5, quad W = 500 "J", quad Q_c = 500 "J".
  $
  By #link(<prop:carnot-bounds>)[the Carnot bounds], a real engine
  between the same reservoirs at $eta = 0.35$ wastes part of the Carnot
  potential to friction and finite-rate heat exchange.
  The same temperature gap run as a Carnot refrigerator gives
  $
    "COP"_R = T_c / (T_h - T_c) = 1, quad
    W = 500 "J" quad "to extract" quad Q_c = 500 "J".
  $
  Note how the numbers expose the asymmetry the definitions encode: the
  same reservoir pair yields $eta < 1$ but $"COP"_R$ of order
  $T_c / (T_h - T_c)$, which can far exceed 1 for narrow gaps — the
  reason refrigeration is cheap and engine power is not.
] <ex:engine-numerical>

#example(name: "Maximum work from two finite bodies")[
  Two identical bodies of heat capacity $C$, at temperatures
  $T_1 > T_2$, serve as the hot and the cold reservoir of an engine.
  As the engine works the first cools and the second warms; after a
  finite number of cycles both reach a common temperature $T_f$.
  What is the largest work the engine can deliver?

  The first law fixes the work once $T_f$ is chosen, the engine itself
  returning to its initial state after every cycle:
  $
    W = -[C (T_f - T_1) + C (T_f - T_2)] = C (T_1 + T_2 - 2 T_f),
  $
  so the work is largest when $T_f$ is smallest. The second law, applied
  to the isolated pair of bodies, bounds $T_f$ from below:
  $
    Delta S = C ln(T_f / T_1) + C ln(T_f / T_2)
    = 2 C ln (T_f / sqrt(T_1 T_2)) >= 0,
  $
  with equality exactly when the engine is reversible. Hence
  $T_f >= sqrt(T_1 T_2)$, and
  $
    W_max = C (T_1 + T_2 - 2 sqrt(T_1 T_2))
    = C (sqrt(T_1) - sqrt(T_2))^2,
  $
  reached by a reversible engine running on infinitesimal temperature
  differences — the engine counterpart of
  #link(<ex:reservoir-cascade>)[the cascade of reservoirs], and the case
  of equality in #link(<prop:carnot-bounds>)[the Carnot bounds].
  Left in direct thermal contact instead, the bodies settle at
  $T_f = (T_1 + T_2)/2$, deliver no work, and produce the entropy
  $
    Delta S = 2 C ln ((T_1 + T_2)/(2 sqrt(T_1 T_2))) > 0.
  $

  The answer is quadratic in the gap: for $T_(1,2) = T plus.minus delta/2$,
  $W_max approx C delta^2/(4 T)$, negligible beside the heat $C delta$
  exchanged — a reversible engine between nearly equal temperatures
  extracts nearly nothing, which is the Carnot bound read differentially.
] <ex:engine-finite-bodies>

#example(name: "A power-heating unit")[
  A heating plant couples a reversible engine to a reversible heat pump,
  as in @fig:power-heating-unit. The engine draws $Q_1$ from the boiler
  at $t_1 = 210 degree "C"$ ($T_1 = 483 "K"$) and rejects $Q_2$ into the
  heating water at $t_2 = 60 degree "C"$ ($T_2 = 333 "K"$); the work $A$
  it delivers drives a heat pump that extracts $Q_3$ from a pond at
  $t_3 = 15 degree "C"$ ($T_3 = 288 "K"$) and delivers $Q_2'$ — also into
  the heating water, which thus serves as the engine's cold reservoir as
  well. How much heat $Q = Q_2 + Q_2'$ does the water receive per
  kilogram of coal, of combustion value $H = 2.09 times 10^7 "J"$?

  Both machines are reversible, so the equalities behind
  #link(<prop:carnot-bounds>)[the Carnot bounds] hold. For the engine,
  $
    Q_2 = Q_1 T_2/T_1, quad A = Q_1 (1 - T_2/T_1),
  $
  and the heat pump, running between $T_3$ and $T_2$, delivers per unit
  of work the heat-pump coefficient of
  #link(<def:efficiency-cop>)[the definition],
  $
    "COP"_"HP" = T_2/(T_2 - T_3),
  $
  so that
  $
    Q_2' = A T_2/(T_2 - T_3)
    = Q_1 (1 - T_2/T_1) T_2/(T_2 - T_3).
  $
  Hence
  $
    Q = Q_2 + Q_2' = Q_1 (T_2 (T_1 - T_3))/(T_1 (T_2 - T_3)),
  $
  and with $Q_1 = H$,
  $
    Q = 2.09 times 10^7 "J" times (333 times 195)/(483 times 45)
    approx 6.24 times 10^7 "J"
  $
  per kilogram of coal.
  #figure(
    image("img/power-heating-unit.svg", width: 60%),
    caption: [The power-heating unit: a reversible engine between the
      boiler $T_1$ and the heating water $T_2$ delivers its work $A$ to a
      reversible heat pump between the pond $T_3$ and the same water.
      The water receives $Q = Q_2 + Q_2'$.],
    placement: auto,
    supplement: [Fig.],
  ) <fig:power-heating-unit>

  The factor $2.99$ deserves a second look. The engine alone converts
  only $eta = 1 - T_2/T_1 approx 0.31$ of the coal's heat into work,
  rejecting $Q_2 approx 1.44 times 10^7 "J"$ to the water directly. The
  work then buys, at $"COP"_"HP" = T_2/(T_2 - T_3) = 333/45 = 7.4$, the
  further $Q_2' approx 4.80 times 10^7 "J"$, of which
  $Q_3 approx 4.15 times 10^7 "J"$ is pumped up from the pond. Energy
  conservation is honoured — $Q = Q_1 + Q_3$, as a short check
  confirms — yet more than twice the coal's energy reaches the water:
  the heat pump harvests the difference from the environment. Heat is
  cheap; work is not, and the unit spends its work where it buys most.
] <ex:power-heating>

The Carnot bound is the engineering face of the second law: efficiency is
bought with temperature, not with mechanical ingenuity.

Two questions are left open, and each opens a door.
What the second law fixes is the *change* of entropy; the value of $S$ at
the lower boundary is still free — the business of the third law.
And every inequality derived here is stated for a *cycle*: the
thermodynamic potentials of Chapter 6 — the Helmholtz and Gibbs free
energies — will carry the same accounting to non-cyclic processes.

= Third Law of Thermodynamics // 热力学第三定律

The zeroth, first and second laws each introduced a state quantity —
temperature, internal energy, entropy — defined up to a constant. For
temperature the constant was fixed by convention (the triple point of
water); for internal energy it is genuinely undeterminable. The third
law addresses entropy at its lower boundary: it fixes $S(0)$
absolutely, and in doing so it decrees the death of classical physics
at low temperature.

== Nernst Heat Theorem // 能斯特热定理

#theorem(name: "Nernst Heat Theorem")[
  For any isothermal process $A -> B$ involving only condensed systems
  (liquids and solids) in internal equilibrium,
  $
    lim_(T -> 0) Delta S = lim_(T -> 0) [S_(B)(T) - S_(A)(T)] = 0.
  $
] <thm:nernst-heat-theorem>

#proof[
  Between two states connected by an isothermal step at $T$,
  compute the entropy difference by integrating along any reversible
  paths joining each state to a common low-temperature reference:
  $
    Delta S(T)
    = Delta S(T_0) + integral_(T_0)^T (C_(A)(T') - C_(B)(T')) / T' dif T'.
  $
  Now let $T_0 -> 0$. If both heat capacities remained finite as $T' ->
  0$, the integral would diverge logarithmically and $|Delta S| -> oo$ —
  absurd, since entropy differences between equilibrium states are
  finite. Consistency demands the integral converge as the lower limit
  recedes, which for arbitrary pairs of states is possible only if
  $
    lim_(T -> 0) [C_(A)(T) - C_(B)(T)] = 0
    quad "and, in the strengthened form below," quad
    lim_(T -> 0) C(T) = 0.
  $
  Under these conditions every isothermal entropy change vanishes at the
  origin: all condensed systems share one entropy at $T = 0$.
]

#corollary(name: "Heat Capacities Vanish at Zero Temperature")[
  The Nernst theorem implies that the heat capacities of condensed
  systems vanish in the zero-temperature limit,
  $
    lim_(T -> 0) C_(V,m) = lim_(T -> 0) C_(p,m) = 0.
  $
] <prop:low-t-heat-capacity>

Were $C$ finite at $T = 0$, two systems differing in composition would
accumulate an infinite entropy difference — violating the theorem.
Experimentally the vanishing is universal and *quantitative*: lattice
heat capacities fall as $T^3$ (Debye's law) and conduction electrons
contribute a linear term $gamma T$, both far below the constant value
the classical equipartition of
#link(<thm:equipartition>)[Chapter 1] demands. The macroscopic third
law and the microscopic failure of
#link(<caution:equipartition-failure>)[classical equipartition] are two
faces of the same quantum reality — resolved by the quantum statistics
of Chapters 16 and 17.

#caution(title: "Classical ideal gases violate the third law")[
  The classical ideal
  gas has $C_(V,m) = f/2 R$ right down to $T = 0$ and an entropy of the
  Sackur-Tetrode form that diverges as $T -> 0$: classical statistical
  mechanics contradicts the third law outright. No paradox arises —
  the classical description itself fails long before, when the thermal
  wavelength exceeds the interparticle spacing and quantum degeneracy
  sets in (Chapters 15-16). The third law is a theorem about nature,
  and classical physics is the approximation that fails.
] <caution:classical-gas-violates>

== Planck Formulation and Absolute Entropy // 普朗克表述与绝对熵

Nernst's theorem fixes entropy *differences* at $T = 0$ but not their
common value. Planck supplied the normalisation.

#law(name: "Planck Formulation")[
  For a perfect crystalline substance,
  $
    lim_(T -> 0) S = 0,
  $
  the entropy at absolute zero being zero regardless of all other
  state variables. Hence the entropy is an *absolute* quantity, free
  of additive constants.
] <law:planck-formulation>

The contrast with internal energy is instructive: $U$ retains an
undeterminable additive constant because only its *changes* enter the
first law. Entropy loses its constant because the third law pins the
reference — thermodynamics' only absolute energy-like scale.

#definition(name: "Absolute Entropy")[
  The entropy of a substance at temperature $T$ is computed from
  calorimetric data alone:
  $
    S(T) = integral_0^T (C_(p,m)(T')) / T' dif T'
    + sum_("transitions") (L_i) / T_i,
  $
  where each transition (crystal structure change, melting, vaporisation)
  at temperature $T_i$ with latent heat $L_i$ contributes its entropy
  jump, and $S(0) = 0$.
] <def:absolute-entropy>

The integral converges at the origin because $C_(p,m) -> 0$ — precisely
the content of #link(<prop:low-t-heat-capacity>)[the low-temperature
  theorem]; a classical gas with constant $C_(p,m)$ would yield a divergent
absolute entropy.

#note(title: "Standard entropies")[
  Tables of chemical thermodynamics list the
  *standard entropy* $S degree(298.15 "K")$ of each species — the
  absolute entropy at $298.15 "K"$ in its standard state, obtained from
  the formula above with calorimetric $C_(p,m)$ and latent heats. Reaction
  entropies follow by summation over species, without any reference
  state ambiguity. This unambiguous bookkeeping is what makes the
  equilibrium constants of Chapter 8 computable from data tables.
] <note:standard-entropy>

== Unattainability of Absolute Zero // 绝对零度不可达性

#law(name: "Unattainability of Absolute Zero")[
  No finite sequence of processes can bring any system to
  $
    T = 0.
  $
] <law:unattainability>

#proof(name: "sketch")[
  Any cooling operation reduces to two ingredients on the
  $T$-$S$ diagram: an *isothermal* leg (in contact with a colder stage,
  reducing entropy) and an *adiabatic* leg (reducing temperature at fixed
  entropy). By #link(<def:absolute-entropy>)[the absolute entropy
    formula], a system with any fixed entropy $S > S(0)$ sits at $T > 0$:
  $
    S - S(0) = integral_0^T (C_(p,m)(T')) / T' dif T' > 0
    quad "for" T > 0 quad ("since" C_(p,m) > 0).
  $
  An adiabatic leg preserves $S$, so to land on $T = 0$ it must preserve
  $S = S(0)$ — but every reachable state above zero temperature has
  $S > S(0)$, and the entropy can be driven down only by isothermal
  steps whose endpoints still obey $S(T) > S(0)$. Each cycle approaches
  $T = 0$ asymptotically without reaching it; infinitely many steps
  would be required.
]

The argument is the standard heuristic one — it assumes cooling cycles
built from isothermal and adiabatic legs and $C_(p,m) > 0$ throughout —
and its status among the formulations of the third law is discussed in
the literature; we adopt it as the operational reading of the law.

#example(name: "Adiabatic demagnetization")[
  The workhorse of microkelvin physics
  realises the two-leg pattern with a paramagnetic salt. The spin
  degrees of freedom contribute an entropy $S(B, T)$ that decreases
  with field $B$ (a field aligns the moments, ordering the system) and
  increases with $T$. The cycle:

  - *isothermal magnetization* at $T_1$: switch on $B$ from 0 to
    $B_1$; the spins' entropy drops and heat $T_1 Delta S < 0$ flows
    out to the bath;
  - *adiabatic demagnetization*: thermally isolate, switch $B$ back to
    0; the spins' entropy wants to rise, but $S$ is frozen — so the
    *lattice* temperature falls to $T_2 < < T_1$ to compensate, the
    spin system absorbing entropy from the lattice.

  Temperatures of a few millikelvin are reachable; the same
  isothermal-then-adiabatic rhythm underlies dilution refrigeration,
  which sustains continuous cooling near $10 "mK"$. The method is the
  magnetic analogue of the gas adiabats of
  #link(<prop:adiabatic-process>)[Chapter 2], with spin order playing
  the role of volume. See @fig:demag-ts.
] <ex:adiabatic-demagnetization>

#figure(
  image("img/demag-ts.svg", width: 74%),
  caption: [Adiabatic demagnetization in the $T$-$S$ plane. Two entropy
    curves $S(T, B)$ are shown: $B = 0$ (upper) and $B = B_1$ (lower),
    both terminating on the same axis value $S(0)$ as $T -> 0$
    (Nernst's theorem). Step 1: isothermal magnetization at $T_1$
    (horizontal arrow, entropy expelled as heat). Step 2: adiabatic
    demagnetization (vertical arrow at constant $S$), landing at
    $T_2 < < T_1$. Repeating the cycle walks the temperature down —
    approaching, never reaching, $T = 0$.],
  placement: auto,
  supplement: [Fig.],
) <fig:demag-ts>

== Residual Entropy // 残余熵

#definition(name: "Residual Entropy")[
  A substance has *residual entropy* if its molar entropy approaches a
  positive limit as $T -> 0$:
  $
    S(0) = k_B ln W_0 > 0,
  $
  where $W_0$ is the degeneracy of the zero-temperature macrostate —
  the number of distinguishable ground-state configurations the
  substance can freeze into.
] <def:residual-entropy>

Residual entropy arises when the energy landscape has many minima of
equal energy separated by barriers so high that the system cannot
equilibrate on experimental timescales: the molecular orientations are
frozen randomly at the ordering temperature and remain disordered all
the way down.

#example(name: "Carbon monoxide crystal")[
  The CO molecule is nearly cylindrically
  symmetric — C and O ends differ in energy only marginally — so as
  the crystal forms, each molecule adopts one of two orientations
  essentially at random, and reorientation freezes out at low $T$. For
  $N$ molecules the ground-state degeneracy is $W_0 = 2^N$, giving
  $
    S(0) = N k_B ln 2 = R ln 2 approx 5.8 "J/(mol K)",
  $
  in fair agreement with the calorimetric deficit of about
  $5.8 "J/(mol K)"$ observed when the third-law entropy is compared
  with the statistical-mechanical value.
] <ex:co-crystal>

#example(name: "Ice")[
  Water ice obeys Pauling's *ice rules*: each oxygen is surrounded by
  four hydrogens, two near (covalent) and two far (hydrogen bonds), and
  each bond carries exactly one proton. Pauling counted the
  configurations: per molecule of $N$ molecules the number of
  admissible proton arrangements is $W_0 approx (3/2)^N$, so
  $
    S(0) = R ln(3/2) approx 3.4 "J/(mol K)",
  $
  matching the measured residual entropy of ice, about
  $3.4 "J/(mol K)"$ — one of the great back-of-envelope successes.
] <ex:ice-pauling>

#note(title: "Reconciling with Planck")[
  Residual entropy does not contradict
  #link(<law:planck-formulation>)[Planck's formulation] — it exposes
  the load-bearing role of the qualifier *perfect crystal*. A frozen-in
  configurational disorder is not the unique ground state, so the
  substance never occupies the perfectly ordered state the theorem
  assumes; thermodynamic measurements probe the frozen ensemble. The
  counting $S = k_B ln W_0$ is
  #link(<def:boltzmann-entropy>)[Boltzmann's formula] doing real
  thermodynamic work; its derivation from first principles is the
  business of Chapter 12.
] <note:third-law-statistical>

== Negative Temperatures // 负温度

The third law closed the thermodynamic scale at $T = 0^+$. Remarkably,
the entropy-energy relation opens a *second* branch on the far side of
infinite temperature.

#definition(name: "Negative Temperature")[
  The thermodynamic temperature is defined by
  $
    1/T = ((partial S)/(partial E))_("V, N").
  $
  A system whose entropy $S(E)$ *decreases* with energy — possible
  only when the energy spectrum is bounded from above — has
  $((partial S)/(partial E)) < 0$ at high energies and therefore
  $T < 0$: a *negative temperature*.
] <def:negative-temperature>

For ordinary systems $S(E)$ increases without bound (the spectrum is
unbounded above), $((partial S)/(partial E)) > 0$ always, and $T > 0$
throughout. Negative temperature requires a *population inversion*:
more of the system at high energies than at moderate ones.

#example(name: "Spin-$1/2$ paramagnet")[
  Take $N$ spins of moment $mu$ in a field
  $B$, energies $E = mu B (N_arrow.b - N_arrow.t)$ ranging from
  $-N mu B$ (all up) to $+N mu B$ (all down). The number of states
  with $N_arrow.t$ spins up is binomial, $W = "binom"(N, N_arrow.t)$,
  and
  $
    S(E) = k_B ln "binom"(N, (E + N mu B) / (2 mu B))
  $
  rises from $0$ at $E = -N mu B$, peaks at $E = 0$ (half up, half
  down: maximal disorder), and falls back to $0$ at $E = +N mu B$ —
  see @fig:negative-t. Reading $T$ off the slope $1/T = ((partial S)/(partial E))$:

  - $E = -N mu B$: slope $+oo$, $T = 0^+$ (all up — cold end);
  - $E = 0$: slope $0$, $T = +- oo$ (the same state from both sides!);
  - $E = +N mu B$: slope $-oo$, $T = 0^-$ (all down — hotter than
    anything).

  The branch $E > 0$ is populated by reversing the field faster than
  the spins can follow (or, in the laboratory, by a radio-frequency
  pulse): more spins sit in the higher-energy orientation than the
  lower — the population inversion of every laser.
] <ex:spin-system>

#figure(
  image("img/negative-t.svg", width: 74%),
  caption: [Entropy versus energy for the spin-$1/2$ paramagnet. The
    curve $S(E)$ is symmetric about $E = 0$, where it peaks
    ($S = k_B N ln 2$). The local slope is $1 / T$: infinite positive
    temperature at the cold end $E = -N mu B$ where the slope is
    steepest, $T = +- oo$ at the peak, and negative temperatures on
    the descending branch, tending to $0^-$ at $E = +N mu B$. The
    negative branch is *hotter* than every positive temperature.],
  placement: auto,
  supplement: [Fig.],
) <fig:negative-t>

#proposition(name: "Negative Temperatures Are Hotter Than Infinity")[
  If two systems at $T_1 < 0$ and $T_2 > 0$ exchange energy, heat
  flows from the negative-temperature system to the positive one:
  in the ordering
  $
    +0 < T_2 < +oo < -oo < T_1 < -0,
  $
  negative temperatures lie *above* $+oo$ on the hotness scale.
] <prop:hotter-than-infinity>

#proof[
  When the negative-temperature system loses a small energy
  $delta E > 0$ to the positive-temperature one, its entropy change is
  $((partial S_1)/(partial E))(-delta E) = (-delta E)/T_1 > 0$ (since
  $T_1 < 0$), while the receiver gains $(delta E)/T_2 > 0$. The total
  entropy increases — the process runs forward by
  #link(<law:entropy-increase>)[the entropy increase principle]. The
  reverse flow would decrease total entropy and does not occur.
]

#caution(title: "Existence conditions")[
  Negative temperatures require three things
  at once: a spectrum *bounded above* (otherwise $S(E)$ never turns
  over), internal equilibration among the high-energy degrees of
  freedom (the inverted population must be a genuine thermal state,
  with its own well-defined temperature), and isolation from ordinary
  matter (contact with any positive-temperature reservoir would
  immediately dump the excess energy). Nuclear spin systems fulfil all
  three — Purcell and Pound inverted LiF nuclear spins in 1951,
  the first negative-temperature state. Kinetic degrees of freedom,
  whose spectra are unbounded, can never go negative: a gas of
  negative temperature is a contradiction in terms.
] <caution:negative-t-conditions>

The microcanonical definition $1/T = ((partial S)/(partial E))$ used here
will be rebuilt from the counting of microstates in
Chapter 12 — where negative temperatures reappear as a corollary of
Boltzmann's formula, and the hotness scale of
#link(<prop:hotter-than-infinity>)[this section] becomes a theorem
about the geometry of $S(E)$.

= Relativistic Thermodynamics // 相对论热力学

Special relativity revises the bookkeeping of energy and momentum;
thermodynamics, built on those books, must follow. This chapter
examines what survives unchanged (the laws, the temperature of
equilibrium) and what bends (dispersion, pressure ratios, adiabatic
exponents) — ending with the photon gas, where the ultra-relativistic
limit is not an approximation but an exact state of affairs, and with
the covariant formulation that closes Part I.

== Thermodynamics of the Relativistic Ideal Gas // 相对论理想气体的热力学

#definition(name: "Relativistic Dispersion")[
  A relativistic particle of mass $m$ and momentum $p$ has energy
  $
    E(p) = sqrt(p^2 c^2 + m^2 c^4),
  $
  with the two universal limits
  $
    E approx m c^2 + p^2 / (2m) quad ("non-relativistic," p < < m c)
  $
  and
  $
    E approx p c quad ("ultra-relativistic," p >> m c "or" m = 0).
  $
] <def:relativistic-dispersion>

#figure(
  image("img/relativistic-dispersion.svg", width: 76%),
  caption: [The dispersion relation $E(p)$ (blue) with its two limits:
    near the origin the parabola $m c^2 + p^2 / 2m$ (grey, dashed) —
    kinetic energy quadratic in momentum as in Chapter 1; at large
    momentum the line $E = p c$ (orange, dashed) — mass becomes
    irrelevant. The crossover scale is $p = m c$.],
  placement: auto,
  supplement: [Fig.],
) <fig:relativistic-dispersion>

#proposition(name: "Pressure of a Relativistic Gas")[
  For an isotropic gas of particles with arbitrary dispersion, the
  pressure is the momentum flux
  $
    p = n ⟨p dot v⟩ / 3,
  $
  where $n$ is the number density. Consequently
  $
    p = 2/3 u_"kin" quad ("non-relativistic"),
    quad quad p = 1/3 u quad ("ultra-relativistic"),
  $
  with $u_"kin"$ the kinetic energy density and $u$ the total energy
  density (including rest energy).
] <prop:ultrarelativistic-pressure>

#proof[
  Particles striking a wall element $dif A$ in time $dif t$
  transfer normal momentum $p cos theta$; the flux of particles at angle
  $theta$ carries the factor $v cos theta$, so integrating over the
  isotropic solid angle gives $p = n < p v cos^2 theta >$ averaged over
  directions, i.e. $p = n < p v > / 3$ since $< cos^2 theta > = 1/3$.
  This is the relativistic completion of
  #link(<prop:pressure-formula>)[the kinetic-theory derivation]. Now
  insert the dispersion: non-relativistically, $p v = p^2 / m = 2
  E_"kin"$, while ultra-relativistically, $p v = p c = E$.
]

The pressure-energy ratio $p = u / 3$ — one half of the
non-relativistic value — is the fingerprint of the ultra-relativistic
regime, and it reappears below as the equation of state of radiation.

#example(name: "Adiabats and heat capacities across the crossover")[
  For a classical
  ideal gas the equation of state $p V = nu R T$ holds in both regimes,
  while the energy density is regime-dependent. Ultra-relativistically
  $U = 3 p V = 3 nu R T$, so
  $
    C_(V,m) = 3 R, quad C_(p,m) = 4 R, quad
    gamma = C_(p,m) / C_(V,m) = 4/3,
  $
  and quasi-static adiabats satisfy $p V^(4/3) = "const"$ — repeating
  the derivation of #link(<prop:adiabatic-process>)[Chapter 2] with
  the new $C_(V,m)$. Compare the non-relativistic monatomic values
  $C_(V,m) = 3 R / 2$, $gamma = 5/3$. The generalized equipartition
  $< p dot v > = 3 k_B T$ (the relativistic form of
  #link(<thm:equipartition>)[the equipartition theorem]) accommodates
  both: each degree contributes $< p dot v > / 2$-type bookkeeping
  through the velocity rather than momentum. As a gas is heated
  through $k_B T ~ m c^2$, its adiabats stiffen from $gamma = 5/3$
  towards $gamma = 4/3$.
] <ex:relativistic-adiabats>

== Relativistic Energy-Momentum and Thermal Equilibrium // 相对论能量-动量与热平衡

The relativistic generalisation of the Maxwell distribution is the
*Jüttner distribution*: in momentum space,
$
  f(p) = 1/Z exp(-E(p) / (k_B T)),
  quad E(p) = sqrt(p^2 c^2 + m^2 c^4),
$
with the same $T$ and $k_B$ as in the non-relativistic theory. In the
limit $p < < m c$ the factor $e^(-m c^2 / k_B T)$ is absorbed into the
normalisation and $f(p) -> e^(-p^2 / 2 m k_B T)$ — exactly the
Maxwell momentum distribution underlying
#link(<thm:maxwell-velocity>)[Chapter 1's velocity distribution].

#note(title: "Derivation deferred")[
  The Jüttner distribution is the $beta = 1/k_B
  T$ member of the canonical family; its derivation from
  maximum-entropy over relativistic phase space belongs to statistical
  mechanics and is given in Chapter 14, together with the subtleties
  (measure choice, reference frame) that sparked a long literature.
  Here we take it as the postulated equilibrium weight and examine its
  consequences.
] <note:juttner-preview>

#proposition(name: "Temperature Invariance at Equilibrium")[
  If two bodies in relative motion are in thermal equilibrium with
  each other, then their proper (rest-frame) temperatures are equal.
  Equilibrium is thus characterised by a Lorentz-invariant statement
  about the comoving temperature, and heat flow is absent exactly when
  the comoving temperatures agree.
] <prop:temperature-invariance>

#proof[
  The zeroth law (#link(<def:zeroth-law>)[Chapter 1])
  defines temperature through the transitivity of mutual equilibrium,
  and the principle of relativity demands that equilibrium be an
  observer-independent state of affairs — whether two bodies exchange
  net heat cannot depend on who watches. The only frame-independent
  temperature attached to each body is its comoving one; equilibrium
  therefore equates comoving temperatures.
]

#note(title: "Does a moving body run hot?")[
  If one insists on asking for the
  temperature a moving body "appears" to have, the literature splits:
  the Ott proposal reads energy transformation as $T' = gamma T$
  (moving hotter), Planck-Einstein argued $T' = T / gamma$ (moving
  colder), and Landsberg concludes $T' = T$ (invariant) — consistent
  with the equilibrium argument above. The modern resolution: the
  question is protocol-dependent, because temperature is defined
  operationally for a body at rest with its thermometer; a comoving
  thermometer always reads $T$. Throughout this note, $T$ means the
  comoving temperature.
] <note:temperature-transformation>

== Photon Gas and Ultra-Relativistic Limit // 光子气体与极端相对论极限

#definition(name: "Photon Gas")[
  A *photon gas* is the equilibrium electromagnetic radiation confined
  in a cavity, treated as a gas of massless particles: each photon has
  dispersion $E = p c$ exactly, moves at $c$, and — crucially —
  photons are created and absorbed by the cavity walls, so their
  number is *not* conserved. The equilibrium state is characterised by
  temperature alone.
] <def:photon-gas>

Number non-conservation will later be expressed as vanishing chemical
potential $mu = 0$ (Chapter 14); thermodynamically, it means the
energy density $u$ can be a function of $T$ alone — no second density
to keep fixed.

#corollary(name: "Radiation Pressure")[
  The pressure of equilibrium radiation is one third of its energy
  density:
  $
    p = u / 3.
  $
] <prop:radiation-pressure>

#proof[
  Directly the ultra-relativistic limit of
  #link(<prop:ultrarelativistic-pressure>)[the relativistic pressure
    formula], with $E = p c$ holding exactly for every photon.
]

#law(name: "Stefan-Boltzmann Law")[
  The energy density of equilibrium radiation is a universal function
  of temperature alone, quartic in $T$:
  $
    u = a T^4,
  $
  with $a$ a universal constant. The emissive power of a black surface
  is $j = sigma T^4$ with $sigma = a c / 4$.
] <law:stefan-boltzmann>

#proof(name: "Boltzmann 1884, purely thermodynamic")[
  Let radiation be
  the working substance of a reversible engine between $T$ and
  $T - dif T$. Its state is fixed by $T$ and $V$; energy $U = u(T) V$,
  pressure $p = u / 3$.

  - *Isothermal expansion* at $T$, volume $dif V$: heat absorbed
    $
      delta Q = dif U + p dif V = u dif V + u/3 dif V = 4/3 u dif V.
    $
  - *Quasi-static adiabats*: $dif S = 0$ gives, from $dif Q = 0$,
    $V dif u + 4/3 u dif V = 0$, i.e. $T V^(1/3) = "const"$ (using
    $p = u/3$ and the final result $u prop T^4$ consistency —
    equivalently derived directly from $dif S = (V/T) dif u + (4u / 3T) dif V = 0$).
  - *Isothermal compression* at $T - dif T$ releases
    $delta Q' = 4/3 u(T - dif T) dif V'$; the adiabatic relations give
    $dif V' = dif V dot (T / (T - dif T))^3$.

  Carnot's efficiency
  (#link(<prop:carnot-efficiency>)[Chapter 2]) demands
  $delta Q' / delta Q = (T - dif T) / T$:
  $
    (u(T - dif T)) / u(T) dot (T / (T - dif T))^3 = (T - dif T) / T,
  $
  so
  $
    u(T - dif T) = u(T) (1 - (dif T)/T)^4
    quad ==> quad (dif u)/u = 4 (dif T)/T
    quad ==> quad u = a T^4.
  $
  The exponent 4 is not put in by hand — it is forced by the radiation
  pressure $p = u/3$, i.e. by the ultra-relativistic dispersion.
]

The full spectral distribution (Planck's law) and the numerical value
of $a$ require quantum statistics — the ultraviolet catastrophe that
launched quantum theory is previewed in
#link(<caution:equipartition-failure>)[Chapter 1] and resolved in
Chapter 15.

#example(name: "Surface temperature of the Sun")[
  The solar constant — the radiant
  flux at the Earth's orbit — is $S = 1361 "W/m"^2$. A black surface
  at temperature $T$ emits $j = sigma T^4$ per unit area with
  $sigma = 5.67 times 10^(-8) "W" "m"^(-2) "K"^(-4)$. Balancing the
  solar luminosity:
  $
    4 pi R_sun^2 sigma T^4 = 4 pi d^2 S
    quad ==> quad
    T = (S d^2 / (sigma R_sun^2))^(1/4),
  $
  with $R_sun = 6.96 times 10^8 "m"$ and $d = 1.496 times 10^11 "m"$:
  $
    T = (1361 dot (1.496 times 10^11)^2 / (5.67 times 10^(-8) dot (6.96 times 10^8)^2))^(1/4)
    approx 5.77 times 10^3 "K",
  $
  the accepted solar surface temperature. A table of constants, the
  second law, and $p = u/3$ have measured a star. The same balance
  applied to the Earth's cross-section gives the mean surface
  temperature $~ 278 "K"$ before atmospheric corrections.
] <ex:solar-temperature>

== Thermodynamic Laws in Covariant Form // 热力学定律的协变形式

We close Part I by writing the first law in the language spacetime
demands. Only the minimal toolkit is assembled here — four-vectors,
the metric $eta = mat(+, 0, 0, 0; 0, -, 0, 0; 0, 0, -, 0; 0, 0, 0, -)$
with signature $(+, -, -, -)$, four
velocity $u^mu = (dif x^mu)/(dif tau)$ normalised by $u^mu u_mu = c^2$,
and the convention that Greek indices run over spacetime.

#definition(name: "Energy-Momentum Tensor of a Perfect Fluid")[
  A perfect fluid with comoving energy density $rho$ (including rest
  energy) and pressure $p$, moving with four-velocity $u^mu$, has
  energy-momentum tensor
  $
    T^(mu nu) = ((rho + p) / c^2) u^mu u^nu - p eta^(mu nu).
  $
  In the rest frame, $T^(00) = rho$ (energy density) and
  $T^(i i) = p$ (pressure): the tensor packages both quantities that
  #link(<prop:ultrarelativistic-pressure>)[Chapter 1's kinetic
    argument] identified as momentum flux.
] <def:energy-momentum-tensor>

#law(name: "Conservation Law")[
  In the absence of external forces,
  $
    partial_mu T^(mu nu) = 0,
  $
  four equations: $nu = 0$ is the local energy conservation, $nu = i$
  the relativistic Euler equations for momentum. In the
  non-relativistic, low-velocity limit these reduce to the
  hydrodynamic balance laws — the continuum completion of the kinetic
  picture of Chapter 1.
] <prop:tensor-conservation>

#definition(name: "Inverse Temperature Vector")[
  The *inverse temperature four-vector* of a fluid element is
  $
    beta^mu = u^mu / T,
  $
  whose comoving component is $beta^mu = (c / T, 0, 0, 0)$ at rest.
  It packages "temperature divided by the time direction" so that
  entropy bookkeeping becomes frame-independent.
] <def:inverse-temperature-vector>

#law(name: "Covariant First Law")[
  For an infinitesimal reversible change of a fluid element,
  $
    dif S = beta_mu dif P^mu + p / T dif V,
  $
  where $dif P^mu$ is the change of its total four-momentum. In the
  comoving frame, $dif P^mu = (dif U / c, 0, 0, 0)$ and
  $beta_mu dif P^mu = dif U / T$, recovering
  $dif S = (dif U + p dif V) / T$ — the first law of
  #link(<law:first-law>)[Chapter 2] together with the entropy of
  #link(<def:entropy>)[Chapter 3].
] <law:covariant-first-law>

This is the Israel form of the first law. The derivation — and the
full covariant theory of dissipative fluids, where heat conduction
and viscosity entangle with relativity — belongs to relativistic
hydrodynamics, beyond this note's scope.

#note(title: "Boundary of this chapter")[
  Everything above the hydrodynamic
  frontier is macroscopic thermodynamics: laws, equilibrium, and
  kinematics. What relativity forbids is not more laws but simpler
  bookkeeping; what it cannot supply is the *values* — the equation
  of state, the constant $a$, the Jüttner normalisation all wait for
  counting. That counting is Part III's business: microstates
  (Chapter 12), the Boltzmann distribution (Chapter 14), and quantum
  statistics (Chapters 16-17). Part II, to which we now turn, builds
  the formal machinery — thermodynamic potentials and Maxwell
  relations — that makes those connections computable.
] <note:covariant-boundary>

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

//   Section 2.4: First Law: Internal Energy (第一定律与内能)
//     - 第一定律的表述 (Q = ΔU + W)
//     - 内能作为状态函数
//     - 热容: C_(V,m) 与 C_(p,m)，比热容
//     - Joule 定律
//     - Mayer 公式

//   Section 2.5: Common Thermodynamic Processes (常见热力学过程)
//     - 等容、等压、等温过程
//     - 绝热可逆过程
//     - 绝热自由膨胀
//     - 多方过程及其与四个特殊过程的统一

//   Section 2.6: Throttling, Cycles and the Carnot Cycle (节流、循环过程与卡诺循环)
//     - 节流过程与焦耳-汤姆孙系数
//     - 循环过程
//     - 热机、制冷机与热泵：效率与制冷系数
//     - 卡诺循环与卡诺效率

// --- Chapter 3: Second Law of Thermodynamics (热力学第二定律) ---

//   Section 3.1: Clausius and Kelvin-Planck Statements (克劳修斯与开尔文-普朗克表述)
//     - 两种经典表述
//     - 两种表述的等价性证明

//   Section 3.2: Carnot's Theorem (卡诺定理)
//     - 卡诺定理的表述与证明（卡诺循环见 Throttling, Cycles and the Carnot Cycle）
//     - 卡诺定理与第二定律的等价性

//   Section 3.3: Entropy and the Clausius Inequality (熵与克劳修斯不等式)
//     - 克劳修斯不等式 ∮ δQ/T ≤ 0
//     - 熵的定义: dS = δQ_rev / T
//     - 熵是状态函数的证明
//     - 熵的计算方法

//   Section 3.4: The Microscopic Meaning of Entropy (熵的微观意义)
//     - 从有序到无序：功热转换、热传导、绝热自由膨胀三现象
//     - 热力学概率 Ω（四分子模型、等概率假设）
//     - 玻尔兹曼熵及其与 Clausius 熵的一致性
//     - 熵增原理及其微观意义
//     - 不可逆过程中的熵变计算

//   Section 3.5: Thermodynamic Temperature Scale (热力学温标)
//     - 基于卡诺循环的绝对温标
//     - 与理想气体温标的等价性

//   Section 3.6: Heat Engines and Refrigeration Cycles (热机与制冷循环)
//     - Carnot bounds: η、COP_R、COP_HP 的上界
//     - 数值算例

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
//     - α, κ_T, C_(p,m) - C_(V,m) 关系

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
//     - 热稳定性: C_(V,m) > 0
//     - 力学稳定性: (∂p/∂V)_T < 0（注释，非渲染内容）
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

//   Section 13.6: Classical Limit and Equipartitionu Revisited (经典极限与均分定理再探)
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

//   Section 16.4: Classical Limit: Maxwell-Boltzmannu Recovery (经典极限：回到麦克斯韦-玻尔兹曼分布)
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

//   Section 22.1: Entropy Productionu Rate (熵产率)
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

#bibliography("references.bib", title: "References", full: true)

// 目录
