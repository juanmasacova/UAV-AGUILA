# Transition envelope

The highest-risk phase of the mission, and the reason tilt-wings are rare despite being the most
elegant configuration on paper.

## The mechanism

While the wing rotates from vertical to horizontal, the aircraft is moving forward. The wing's
angle of attack relative to the oncoming air is essentially its tilt angle $\theta$ — far past
stall for most of the rotation.

Propeller slipstream rescues the immersed part of the wing by adding axial velocity through it,
reducing the effective angle to

$$\alpha_{\text{blown}} = \arctan\!\left(\frac{V\sin\theta}{V\cos\theta + w}\right),
\qquad w = \sqrt{\frac{T}{2\rho A}}$$

The wing outside the slipstream gets no such relief.

## The part that needs no decisions

--8<-- "includes/transition-envelope.md"

The unblown wing sits at the geometric angle whatever the aircraft weighs. **Through most of the
transition, any part of the wing not immersed in slipstream is separated.** That is already
certain.

## The part that waits on sizing

How much of the wing is rescued depends on two things that are not decided:

| Unknown | Effect |
|---|---|
| Rotor diameter | Sets both the slipstream velocity and how much span is immersed |
| Aircraft mass | Sets the thrust, and therefore the slipstream velocity |

There is a real tension here worth knowing about before choosing a rotor. **Larger rotors hover
more efficiently but blow the wing more gently** — lower disk loading means lower slipstream
velocity, so less angle-of-attack relief exactly where it is needed. The efficient choice for
hover is the worse choice for transition. That trade gets resolved at sizing, on a thrust stand.

## What it already constrains

Three design requirements follow from the mechanism alone, so they are set now rather than later:

- **Washout at the tip.** Part of the wing will be unblown and separated. Washout makes the tips
  stall *last*, so the wing stalls root-outward and roll authority survives longest. The cheapest
  safety measure available.
- **A gentle-stall airfoil.** A section with abrupt leading-edge separation is disqualified,
  whatever its lift-to-drag ratio.
- **A slow, low-airspeed transition, at altitude, with an abort-to-hover switch.** The aircraft
  transitions on thrust, not on speed. If it drops a wing, recovery is to command the wing back
  to vertical and let the rotors carry it.

## Historical note

This failure mode is not scale-dependent and it is not new. The Canadair CL-84 and the Vought
XC-142 both suffered transition handling problems traced to unblown outer wing panels separating
asymmetrically. The production fixes were full-span blowing and large Fowler flaps — both of which
add mechanism, mass and tuning.
