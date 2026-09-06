# UAV AGUILA

**A 3D-printed tilt-wing VTOL, designed from scratch to carry a can of soda to a GPS waypoint,
drop it, and come home.**

One person, one full engineering cycle: requirements, trade studies, analysis, CAD, manufacture,
flight test. This site is the working record — it fills in as the work is done, not before.

--8<-- "includes/progress-bar.md"

!!! info "Where the project actually is"
    The mission and the configuration are settled. **Nothing about the aircraft's size, mass,
    structure or hardware has been decided yet** — that work starts now, and this site stays
    empty in those places until it is done.

---

## What is decided

Each of these is a real decision with reasoning recorded in the
[decision log](program/decision-log.md).

--8<-- "includes/decided.md"

---

## What is not decided

--8<-- "includes/open-questions.md"

---

## What we know so far

Two findings came out of the configuration work. Both are **structural** — they follow from the
shape of the aircraft rather than from any number, so they hold whatever the aircraft turns out
to weigh.

### A rigid two-motor tilt-wing has no yaw control

With both motors bolted to a single tilting wing, three of the four hover axes come free:
collective throttle gives thrust, differential throttle gives roll, and collective wing tilt *is*
the pitch effector. **Yaw does not exist.** The only remaining effector is differential propeller
torque, which is weak and directly fights the differential throttle needed for roll.

This is a missing control axis, not a tuning problem, and it is why the aircraft carries
independently tilting nacelles rather than a single rigid wing-tilt mechanism.

[The full argument →](analysis/control-authority.md)

### The transition passes through a partly stalled wing

While the wing rotates from vertical to horizontal, its angle of attack relative to the oncoming
air is essentially the tilt angle — far past stall for most of the rotation. Propeller slipstream
rescues the immersed part of the wing; the rest separates.

How much is rescued depends on rotor size and aircraft mass, neither of which is chosen. But the
mechanism is certain, and it already constrains the design: the wing needs washout, a
gentle-stall airfoil, and a slow low-airspeed transition.

[The full argument →](analysis/transition-envelope.md)

---

## Design point

--8<-- "includes/design-point.md"

---

## How this site works

Every number published here is generated from a single design state in
[`analysis/aguila.py`](https://github.com/juanmasacova/AGUILA-UAV/blob/main/analysis/aguila.py).
A parameter that has not been decided is `None`, and `None` renders as *not yet determined* — never
as a plausible-looking placeholder.

Set a value, run one script, and every affected figure updates together: change the wing area and
span, chord, wing loading, stall speed, Reynolds number and required thrust all move with it. The
build fails if the published tables disagree with the code, so the documentation cannot drift away
from the analysis.

The progress bar at the top is driven by the same file. It fills as stages are genuinely
completed.

---

## Where the work lives

| Section | What is in it |
|---|---|
| [Program](program/index.md) | Stage board, decision log, exploratory studies |
| [Requirements](requirements/index.md) | The requirements register and regulatory obligations |
| [Design](design/index.md) | Configuration as chosen, and what still has to be designed |
| [Analysis](analysis/index.md) | Method and findings — with the numbers blank until they exist |
| [Build](build/index.md) | Print log and measured masses |
| [Test](test/index.md) | Bench results and flight logs |
| [Procurement](procurement/index.md) | Bill of materials |

---

## Honest scope

This is a first solo aircraft design. The previous build was a five-inch FPV quadcopter assembled
from instructions. Nothing here has flown, and most of it has not yet been designed.

The site is deliberately empty in the places where the work has not been done. An engineering
record that shows plausible numbers before the analysis exists is worse than one that shows
blanks, because you cannot tell which of its numbers to trust.
