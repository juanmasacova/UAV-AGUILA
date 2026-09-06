# Configuration trade study

Run before the configuration was chosen. Kept in full because the decision that followed went
**against** its recommendation, and the record of that is more useful than the recommendation
itself.

## Candidates

**A — Quadplane.** Fixed wing, four dedicated lift motors on booms, one separate cruise motor.
Lift and cruise systems fully decoupled.

**B — Tilt-wing.** The entire wing rotates, carrying the propellers with it. No dedicated lift
motors.

**C — Tilt-rotor.** Wing fixed; motor nacelles rotate.

**D — Tailsitter.** The whole aircraft sits on its tail and pitches over into cruise. No tilting
parts at all.

## Weighted trade

| Criterion | Weight | A: Quadplane | B: Tilt-wing | C: Tilt-rotor | D: Tailsitter |
|---|---:|:---:|:---:|:---:|:---:|
| First-flight success probability (solo, first design) | 0.25 | 5 | 2 | 3 | 3 |
| Autopilot maturity for waypoint VTOL | 0.15 | 5 | 2 | 4 | 4 |
| Printability / structural feasibility in plastic | 0.15 | 5 | 2 | 3 | 4 |
| Payload bay and drop geometry | 0.15 | 5 | 3 | 4 | 2 |
| Cruise efficiency | 0.10 | 3 | 5 | 4 | 4 |
| Component availability from a consumer retailer | 0.10 | 5 | 3 | 4 | 4 |
| Build time and cost | 0.10 | 4 | 2 | 3 | 4 |
| **Weighted total (of 5)** | | **4.70** | **2.55** | **3.50** | **3.45** |

### Notes on the scoring

- **Autopilot support** exists for all four. The quadplane is by far the most flown; the
  tilt-wing is supported but with a small community, so debugging happens alone.
- **Cruise efficiency** is the quadplane's only real loss: four dead rotors and their booms are
  carried through the entire cruise.
- **Payload geometry** is where the tailsitter fails badly. It rests nose-up, so the payload bay
  is vertical on the ground, and precision hover over a drop point in wind is the thing
  tailsitters do worst.

## Recommendation

**Quadplane.** It won on every criterion determining whether a flying aircraft results, and lost
only on cruise efficiency.

The argument was not "quadplane is best" but what the quadplane buys: **it is the only
configuration where the VTOL system and the fixed-wing system can be tested separately.**

## What was decided

**Tilt-wing** — see [D1](../program/decision-log.md#d1-configuration).

The overrule was taken with the costs written down first: separable testing is lost, transition
risk rises, actuator count goes up, and the community to ask for help is small. In exchange the
aircraft carries no dead weight in cruise, and it is a substantially more interesting piece of
engineering.

!!! note "No numbers here"
    Earlier exploratory studies attached specific masses, spans and power figures to each
    configuration. Those were preliminary sizing produced to check that the configurations closed
    at all — **none of it was adopted**, and none of it appears on this page. The studies are
    kept under [Program → Studies](../program/studies/study-02-tiltwing.md), clearly labelled.

## Swept wing — considered, rejected

Raised briefly and withdrawn. Sweep delays compressibility drag near Mach 0.7+; this aircraft
will cruise around Mach 0.05. It would have cost spanwise flow that worsens tip stall — the
opposite of what a tilt-wing needs — a pivot axis no longer lying cleanly spanwise, and a
centre-of-gravity relationship that moves with tilt angle. CR-05 fixes the wing as straight.
