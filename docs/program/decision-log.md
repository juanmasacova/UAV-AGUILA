# Decision log

Every decision that shapes the aircraft, with the evidence behind it. A trade study that only
records the winner is not much use six months later when someone asks why.

--8<-- "includes/decided.md"

---

## D1 — Configuration { #d1-configuration }

<span class="chip done">Closed</span> · **Tilt-wing bicopter.** Straight unswept wing rotating as
a unit, one motor per side.

A weighted four-way trade — quadplane, tilt-wing, tilt-rotor, tailsitter — scored the
**quadplane** highest at 4.70/5 against the tilt-wing's 2.55, on first-flight success
probability, autopilot maturity, printability and payload geometry.

**Decided against that recommendation, deliberately.** The reasoning:

- The tilt-wing carries no dead weight in cruise: the same two propellers do lift and thrust. A
  quadplane carries four lift rotors and their booms through the entire cruise.
- A working tilt-wing bicopter is a more interesting engineering artefact than a quadplane, which
  is a configuration seen constantly from student teams.

**What the decision costs**, recorded so it is not forgotten later: hover and wing-borne flight
can no longer be tested separately, transition risk rises, and the actuator count goes up. The
test programme is structured around this.

[Trade study →](../analysis/trade-study.md)

## D2 — Yaw effector { #d2-yaw-effector }

<span class="chip done">Closed</span> · **Differential nacelle tilt.**

A rigid two-motor tilt-wing has no yaw effector at all. Two candidates:

| Option | Cost | Verdict |
|---|---|---|
| Differential flaperon in the slipstream | Free — reuses existing servos | Rejected |
| Differential nacelle tilt | Two small servos | **Selected** |

Flaperon authority scales with slipstream dynamic pressure, so it collapses at low throttle —
the descent-and-land condition, where heading hold matters most. A control effector that is
weakest when most needed is not a control effector.

**The travel angle is not yet set** — that depends on geometry and mass, neither of which is
decided, and it must be confirmed by measurement on a thrust stand regardless.

[Control authority →](../analysis/control-authority.md)

## D3 — FPV video { #d3-fpv-video }

<span class="chip done">Closed</span> · **No onboard video in Block 1.**

The weight saving is the weaker argument. The stronger one: Part 107 requires visual line of
sight with the aircraft regardless, so onboard video adds nothing the mission needs. Debugging is
better served by the autopilot's dataflash log, which records attitude, airspeed, tilt angle and
every motor output many times a second.

**Telemetry is not included in this deletion.** A live ground-station link is required for
transition testing and for commanded abort.

## D4 — Propeller { #d4-propeller }

<span class="chip done">Closed</span> · **10 inch diameter, two blades.** Pitch window 10×5 to 10×6,
to be settled on the thrust stand.

An 8 inch propeller costs **25 % more power** than a 10 inch for identical thrust, in hover and
at full power alike. Power falls with the square root of disk area, so this is geometry and
cannot be tuned away. An 8 inch would also have to turn about 15,500 RPM to reach the required
thrust, which is near the ceiling of what an 8 inch propeller will do at all.

Two blades rather than three: momentum theory contains no blade count, only disk area, so a
three-blade of the same diameter has identical ideal power and loses about 6 % to extra profile
drag. Three blades only win when diameter is constrained, and no such constraint exists yet.

[Propulsion study →](../analysis/propulsion.md)

## D5 — Wing planform { #d4-wing-planform }

<span class="chip done">Closed</span> · **Straight, constant chord.** Sweep was raised and
withdrawn.

Sweep delays compressibility drag near Mach 0.7+. This aircraft will cruise around Mach 0.05, so
there is nothing to delay. It would have cost spanwise flow that worsens tip stall — the opposite
of what a tilt-wing needs — a pivot axis no longer lying cleanly spanwise, and a
centre-of-gravity relationship that moves with tilt angle.

---

## Open

Nothing below is decided. Each one is deliberately deferred until the analysis that should
inform it has actually been done.

| # | Decision | Blocked by |
|---|---|---|
| D6 | Maximum takeoff mass | Component selection and mass budget |
| D6 | Wing area, span, aspect ratio | MTOW and a chosen wing loading |
| D7 | Hover thrust-to-weight requirement | Should be set *before* sizing, not after |
| D8 | Airfoil | Operating Reynolds number, which needs the chord |
| D9 | Motor and battery selection (propeller closed in D4) | Mass budget |
| D10 | Wing tilt actuator type | Pivot load path |
| D11 | Autopilot board | Control allocation requirements |
| D12 | Budget ceiling | — |
| D13 | Timeline | — |
| D14 | CAD tool | — |
| D15 | Test site | Needed before first outdoor flight |
