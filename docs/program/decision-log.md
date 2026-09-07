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

## D6 — Motor { #d6-motor }

<span class="chip done">Closed</span> · **iFlight Helion 10 3110, 900 Kv, two off**, on 6S.
Selected against a compared alternative, not approved in isolation.

### How this decision was reached

It was nearly taken badly. The motor was first assessed on its own — it cleared the thrust
requirement, so it was approved. That is not a decision, it is a single-option review, and it
was reopened before anything was ordered.

Re-examining it produced two corrections to the reasoning and one genuinely useful result.

### Correction 1 — "900 Kv is too high" was wrong

The propulsion study called for ~560 Kv; this motor is 900. That looked like a mismatch. It is
not, and the reason is worth keeping:

Winding for lower Kv means more turns of thinner wire, so **resistance rises as $1/K_v^2$**
while the current needed for a given torque falls as $K_v$. Copper loss $I^2R$ is therefore
**independent of $K_v$**:

| Kv | Kt (N·m/A) | R (mΩ) | Current at hover torque | Copper loss |
|---:|---:|---:|---:|---:|
| 400 | 0.02387 | 395 | 6.6 A | **17.0 W** |
| 500 | 0.01910 | 253 | 8.2 A | **17.0 W** |
| 700 | 0.01364 | 129 | 11.5 A | **17.0 W** |
| 900 | 0.01061 | 78 | 14.8 A | **17.0 W** |

Kv only decides what *voltage* is needed to reach a given RPM. What sets efficiency is the
motor constant $K_m = K_t/\sqrt{R}$, which is a property of the motor's **size**, not its
winding. Written up at greater length in
[Kv is a gear ratio, not an efficiency rating](../blog/posts/2026-09-08-kv-is-a-gear-ratio.md).

### Correction 2 — "cruise at 1.4 % of rated power" was overstated

The 2144 W figure is a 65 A burst rating no one operates at continuously. Comparing a real
operating point against it exaggerates the concern. The meaningful comparison is $K_m$, below.

### The comparison

The credible alternative with **published thrust data** is the T-Motor MN3110, which exists in
three Kv variants:

| Motor | Kv | R | Mass | $K_m$ | Copper loss in hover | Rated power | Thrust data |
|---|---:|---:|---:|---:|---:|---:|---|
| **iFlight Helion 3110** | 900 | 78 mΩ | **77 g** | 0.0380 | 17.0 W | 2144 W peak | none published |
| T-Motor MN3110 | 780 | 71 mΩ | 100 g | **0.0459** | **11.6 W** | 481 W (180 s) | full table |
| T-Motor MN3110 | 700 | 92 mΩ | 99 g | 0.0450 | 12.1 W | 466 W (180 s) | full table |
| T-Motor MN3110 | 470 | 135 mΩ | 98 g | 0.0553 | 8.0 W | 330 W (180 s) | full table |

**The MN3110 is the more efficient motor.** Its higher $K_m$ saves about 10.7 W of copper loss
across both motors in hover. Over a 60 s hover that is 0.18 Wh — worth about **2.3 g of
battery**. The motors themselves are **46 g heavier**. Net penalty: **+44 g** to carry a motor
that is better on paper.

### What actually decided it

Power headroom. Each motor must deliver **343 W** at T/W 1.8:

| Motor | Rated | Headroom | Verdict |
|---|---:|---:|---|
| Helion 3110 | 2144 W peak | 6.3× | Comfortable |
| MN3110 KV780 | 481 W / 180 s | 1.4× | Marginal — and that is a 3-minute rating, not continuous |
| MN3110 KV700 | 466 W / 180 s | 1.4× | Marginal |
| MN3110 KV470 | 330 W / 180 s | 1.0× | Cannot do it |

A 1.4× margin against a **180-second** rating is not enough for an aircraft with **two motors
and no redundancy**, where losing one is unrecoverable. The KV470 cannot reach the required
RPM on 6S at all.

So the Helion wins on the two things that bind this design — **mass and thermal margin** —
while giving up efficiency that turns out to be worth 2 g.

### The useful result

Checking the model against T-Motor's measured 10-inch data closed the biggest worry about the
Helion, which was that no thrust table exists for it:

| Measured thrust | Measured power | Model prediction | Error |
|---:|---:|---:|---:|
| 530 g | 71.0 W | 68 W | −4 % |
| 660 g | 100.6 W | 95 W | −6 % |
| 850 g | 136.2 W | 138 W | **+2 %** |
| 980 g | 162.8 W | 171 W | +5 % |

The efficiency model was calibrated on a *9450 propeller and a 2312-class motor*. It reproduces
a **different manufacturer's measured 10-inch data** to within a few percent. That is
independent confirmation of the 0.494 calibration, and it means the predicted Helion operating
points are trustworthy even without a manufacturer table.

### Predicted operating points

| Point | Thrust per motor | RPM | Electrical power | Current, 6S |
|---|---:|---:|---:|---:|
| Cruise | 92 g at 17.1 m/s | ~6,200 | ~29 W | 1.3 A |
| Hover | 865 g | ~7,400 | ~151 W | 6.8 A |
| Max, T/W 1.8 | 1,557 g | ~9,900 | ~343 W | 15.5 A |
| Continuous ceiling | ~2,330 g | ~12,100 | ~666 W | 30 A |

### Conditions

1. **Bench test before committing to CAD.** The propeller model is now validated; what remains
   unverified is this specific motor's $K_m$ and its thermal behaviour at sustained hover.
   Measure a cruise-representative point too — low torque at 5,000–7,000 RPM.
2. **Size the ESC for actual draw, not the motor's rating.** Peak demand is about 16 A;
   a 30–40 A 6S ESC is right. Specifying to 65 A buys mass for current that never flows.

!!! note "Scope of the comparison"
    This weighed the Helion against the T-Motor MN3110 family — the most credible alternative
    in the class, and the one that publishes full test data. It is not an exhaustive survey of
    every 10-inch 6S motor on the market. If a lighter motor with $K_m$ above 0.038 and more
    than 2× power headroom turns up, it would beat this choice.

[Propulsion study →](../analysis/propulsion.md)

## D7 — Battery chemistry and cell count { #d7-battery }

<span class="chip done">Closed</span> · **6S LiPo**, using packs already owned.

6S over 4S draws about a third less current for the same power — 16 A rather than 23 A at
T/W 1.8 — which means thinner wiring, cooler ESCs and lower resistive loss. The deciding
factor was simpler: the packs and the charger already exist, and the chosen motor is a 6S part.

Capacity is **not** decided. It follows from the mass budget once the cruise efficiency
question in D6 is measured.

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
| D9 | Battery capacity (motor closed in D6, chemistry in D7) | Cruise efficiency measurement |
| D10 | Wing tilt actuator type | Pivot load path |
| D11 | Autopilot board | Control allocation requirements |
| D12 | Budget ceiling | — |
| D13 | Timeline | — |
| D14 | CAD tool | — |
| D15 | Test site | Needed before first outdoor flight |
