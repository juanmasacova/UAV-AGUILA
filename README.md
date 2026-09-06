# UAV AGUILA

A 3D-printed tilt-wing VTOL, designed from scratch to carry a 33 cl can to a GPS waypoint, drop
it, and return.

One person, one full engineering cycle. This repository is the working record — and it fills in
as the work is done, not before.

**📖 [Documentation site](https://juanmasacova.github.io/AGUILA-UAV/)**

*Setting this up for the first time? See [START_HERE.md](START_HERE.md).*

---

## Status

**2 of 9 stages complete.** Mission and configuration are settled. Nothing about the aircraft's
size, mass, structure or hardware has been decided yet.

| | |
|---|---|
| Configuration | Tilt-wing bicopter — straight wing rotating as a unit, one motor per side |
| Payload | One 33 cl can |
| Autonomy | Waypoint |
| Manufacture | Every structural part prints inside a 256 mm cube |
| Size, mass, hardware | Not yet determined |

---

## The rule this repository runs on

**No number is published until it has been calculated or measured.**

Every figure on the site is generated from a single design state in `analysis/aguila.py`. A
parameter that has not been decided is `None`, and `None` renders as *not yet determined* — never
as a plausible placeholder. Continuous integration fails the build if the published tables
disagree with the code.

The consequence is that the site is currently, and correctly, mostly empty. An engineering record
showing confident numbers before the analysis exists is worse than one showing blanks, because
you cannot tell which of its numbers to trust.

```bash
pip install -r requirements.txt
python analysis/make_tables.py    # regenerate every published table and the progress bar
mkdocs serve                      # preview at http://127.0.0.1:8000
```

---

## What is already known

Two findings came out of the configuration work. Both are **structural** — they follow from the
shape of the aircraft rather than its dimensions, so they hold whatever it turns out to weigh.

**[A rigid two-motor tilt-wing has no yaw control.](https://juanmasacova.github.io/AGUILA-UAV/analysis/control-authority/)**
Thrust, roll and pitch come free — collective wing tilt *is* the pitch effector. Yaw does not
exist. The only remaining effector is differential propeller torque, which is weak and fights the
differential throttle needed for roll. This is a missing control axis, not a tuning problem, and
it is why the aircraft carries independently tilting nacelles.

**[The transition passes through a partly stalled wing.](https://juanmasacova.github.io/AGUILA-UAV/analysis/transition-envelope/)**
While the wing rotates, its angle of attack is essentially the tilt angle — far past stall for
most of the rotation. Slipstream rescues the immersed part; the rest separates. How much is
rescued depends on rotor size and mass, neither chosen — but the mechanism already demands
washout, a gentle-stall airfoil, and a slow transition.

---

## Repository layout

```
analysis/           Design state and analysis code — the source of every published number
  aguila.py         Parameters (None until decided), milestones, physics. Standard library only.
  make_tables.py    Regenerates every table and the home-page progress bar
docs/               Documentation site source (MkDocs Material)
includes/           Auto-generated fragments — do not edit by hand
cad/                CAD models and exports
firmware/           Autopilot parameters and logs
internal/           Private working notes (gitignored, never published)
.github/workflows/  CI: regenerate, verify, build, deploy
```

---

## Licence

Documentation and analysis: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
Code: MIT.

Juan Martínez — mechanical engineering, UNC Charlotte.
