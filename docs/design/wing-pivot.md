# Wing pivot

!!! danger "Designed first — it gates the program"
    Before the airfoil, before the mass budget. If the pivot cannot be built, the aircraft cannot
    be built, and that is worth knowing in week one rather than month three.

## What it has to do simultaneously

1. Carry full wing bending moment across the fuselage
2. Rotate through roughly 85° under load
3. Hold commanded position with power removed
4. Pass all motor power and signal wiring across a moving joint

Any one of these is straightforward. Together, in printed plastic, they are the hardest problem
in the project.

## Design direction

**The pivot should not be made of printed plastic.**

The bending load wants to pass through a continuous spar running through the fuselage in metal
bearing blocks, with the printed structure locating components rather than carrying them. The
tilt drive acts on a lever arm clamped to that spar, not on the printed wing.

Printed plastic is weakest between layers, and a rotating joint loads its housing in exactly the
direction the layer lines cannot take.

## Actuator — not selected

The requirement that matters: **it must hold its commanded angle with power removed.** Losing
tilt authority mid-transition is unrecoverable, so a mechanism that back-drives under
aerodynamic load is disqualified regardless of how well it performs otherwise.

A worm gear satisfies this inherently, at the cost of speed — which may not matter across a
ten-second transition. That is a candidate, not a decision.

## Wiring

Two motors' worth of power plus signal crosses this joint on every flight and every bench test.
A wiring failure mid-transition kills a motor, and with only two motors that is unrecoverable.

Direction: silicone-insulated wire, strain relief on both sides so the service loop flexes rather
than the terminations, routed on the pivot axis where possible so it twists rather than bends.

**Cycle-tested with the pivot, not assumed.**

## Verification planned

| Test | Criterion |
|---|---|
| Static bending to design load | No permanent deformation at 1.5× the design wing load |
| Cycle sweep | No play developed, no wiring damage, actuator holds position |
| Power-off hold | Commanded angle held under full static thrust load, unpowered |

Load figures are blank because the aircraft's mass is not determined.
