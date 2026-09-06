---
title: Study 02 — tilt-wing
---

!!! warning "Exploratory study — not adopted, numbers not decided"
    Written to establish what the tilt-wing configuration *demands*, once that configuration was
    chosen. The **qualitative findings hold**: a rigid two-motor tilt-wing has no yaw effector,
    and the transition passes through a partly stalled wing.

    Every **number** in this document — span, mass, rotor size, battery, motor class — is
    preliminary sizing used to check that the configuration closes at all. **None of it is a
    design decision.** Sizing has not been done. See the [design point](../../analysis/sizing.md).

**Rev 0.2 — 6 September 2026**
Author: Juan Martínez · Status: **Draft for review** · Supersedes: Rev 0.1

> **Change summary from Rev 0.1**
> - **D1 decided by the customer: tilt-wing, two motors.** The quadplane baseline is withdrawn.
> - Configuration is now a **tilt-wing bicopter**: straight (unswept) wing that rotates as a
>   unit, one motor per side, plus differential nacelle tilt for yaw (§5.2 — this is not
>   optional, and the reason is a control-authority calculation, not a preference).
> - **FPV video deleted** from Block 1. Agreed, and there is a better argument for it than
>   weight — see §6.2.
> - Battery cut from 4500 mAh to **6S 3000 mAh** to break the mass spiral (§4.2).
> - Converged MTOW: **2.81 kg**, up from 2.31 kg nominal in Rev 0.1. §4.2 explains why.
> - Swept wing considered and rejected (§5.5).

---

## 0. How to read this document

Same as Rev 0.1: this is the top of the tree, everything downstream traces to §3, and
numbers here are preliminary sizing rather than design values.

One addition. Rev 0.1 recommended a quadplane and you chose a tilt-wing. **That decision is
recorded, not re-litigated** — §5 now analyses the aircraft you asked for rather than
arguing for a different one. What §5 does do is tell you exactly what the choice costs and
what it demands in return, because a trade study that only says "you were right" is worth
nothing to you and worth nothing on a CV.

**§10 holds the open decisions.** Read it first if short on time.

---

## 1. Program intent

*(Unchanged from Rev 0.1.)*

Design, analyse, build, and fly a VTOL-capable unmanned aircraft that carries a standard
33 cl beverage can to a GPS waypoint, releases it, and returns — executing the full
engineering cycle rather than assembling someone else's kit.

The secondary intent still matters as much: this is a **portfolio artefact**. The tilt-wing
choice raises the technical risk and it also raises the ceiling. A working tilt-wing
bicopter with a documented control-authority analysis behind it is a substantially more
interesting thing to put in front of an Airbus or Thales recruiter than a quadplane, which
is a configuration they have seen a hundred times from student teams.

### Success criteria for the MVP

Unchanged. In a single sortie, without intervention between arming and disarm:

1. Takes off vertically (or within a 1.5 m footprint),
2. Transitions to wing-borne flight,
3. Flies an uploaded waypoint mission of ≥ 500 m out,
4. Releases a full 33 cl can within 10 m of a commanded drop point,
5. Returns, transitions back, and lands within 3 m of the launch point.

---

## 2. Concept of operations

```
              wing 85°              wing 85°→10°          wing 10°
   ┌─── vertical climb ───┐    ┌─── transition ───┐   ┌── cruise ──┐
   │  props horizontal    │    │  SLOW, V ≤ 5 m/s │   │ props vert │
 LAUNCH ──────────────────┴────┴───────────────────┴───┴────────────► drop ──► RTL
        ≤1.5 m footprint       15–25 m AGL, 8–12 s      60–100 m AGL, 15 m/s
```

The single change to the ConOps versus Rev 0.1: **transition is now airspeed-limited, not
time-limited.** §5.3 shows why. The aircraft must hold below roughly 5 m/s while the wing
comes down from 85° to about 35°, then accelerate. It transitions on thrust, not on speed.
This is slower than a quadplane transition and it must be flown that way deliberately.

| Phase | Duration | Wing angle | Notes |
|---|---|---|---|
| Pre-flight | — | 85° | Can latched, CG verified, wing tilt swept through full range on the bench |
| Vertical climb | 8–12 s | 85° | To ≥ 20 m AGL |
| Transition out | 10–15 s | 85° → 10° | **Highest-risk phase.** V ≤ 5 m/s until wing < 35° |
| Outbound cruise | 60–120 s | ~2–5° | 15 m/s |
| Drop | ~15 s | 85° | Transition back to hover, hold, release, confirm |
| Return cruise | 60–120 s | ~2–5° | 370 g lighter — retrim |
| Transition in | 10–15 s | 10° → 85° | Second-highest-risk phase |
| Vertical land | 10–15 s | 85° | |

Design mission ≈ 7 minutes. Battery sized for roughly 6× that (§4.3).

---

## 3. Requirements register

Verification: **A**nalysis · **I**nspection · **D**emonstration · **T**est.
Changes from Rev 0.1 marked **[CHANGED]** / **[NEW]** / **[DELETED]**.

### 3.1 Mission requirements

| ID | Requirement | Verif. |
|---|---|---|
| MR-01 | Carry one full 33 cl aluminium beverage can (370 g ± 20 g incl. contents) | I |
| MR-02 | Release the payload in flight on command, and confirm release to the operator | D |
| MR-03 | Take off and land within a 1.5 m diameter footprint from unprepared grass | D |
| MR-04 | Fly an operator-uploaded GPS waypoint mission without stick input | D |
| MR-05 | Design mission radius ≥ 500 m with ≥ 50 % energy reserve on landing | A, T |
| MR-06 | Return to launch autonomously on RC link loss, low battery, or operator command | T |

### 3.2 Constraint requirements

| ID | Requirement | Verif. |
|---|---|---|
| CR-01 | Every structural part printable on a Bambu Lab A1: **256 × 256 × 256 mm** | I |
| CR-02 | All components procurable from Amazon US, or from stock already owned | I |
| CR-03 | The existing 5-inch FPV quad shall not be disassembled | I |
| CR-04 **[CHANGED]** | Reuse the existing ELRS **transmitter**. Goggles reuse deferred to Block 2 — no FPV in Block 1 | I |
| CR-05 **[CHANGED]** | MTOW ≤ **3.0 kg** (was 3.0 kg; retained, but margin is now thin — see R1) | T |
| CR-06 | No part shall require a machine tool the workshop does not have | I |
| CR-07 **[NEW]** | Wing shall be **straight (unswept)**, constant or near-constant chord | I |

### 3.3 Derived requirements

| ID | Requirement | Derived from | Verif. |
|---|---|---|---|
| DR-01 | Hover thrust-to-weight ≥ 1.7 at MTOW | MR-03; wind margin | T |
| DR-02 | Wing loading ≤ 8.5 kg/m² at MTOW | Keeps stall ≤ 11 m/s | A |
| DR-03 | CG travel between can-loaded and can-released ≤ 5 % MAC | MR-02 | A, T |
| DR-04 | Payload release mechanically fail-safe: no release on power loss | Safety | T |
| DR-05 | Transportable in a car without disassembly beyond wing removal | Practicality | D |
| DR-06 | Every printed structural joint carries load through a CF spar or steel fastener — never printed threads, never a layer line in tension | PLA anisotropy | I, T |
| DR-07 | Airframe survives a 1.5 m drop test on the landing gear at MTOW | First landings | T |
| DR-08 | Carry an FAA-compliant Remote ID broadcast module | Regulatory | I |
| DR-09 **[NEW]** | **Yaw angular acceleration in hover ≥ 150 °/s² at MTOW** | §5.2 — the tilt-wing's binding control constraint | A, T |
| DR-10 **[NEW]** | Wing tilt actuator shall hold commanded angle against full aerodynamic and thrust load with the power removed (self-locking or geared non-backdrivable) | Loss of tilt authority in transition is unrecoverable | T |
| DR-11 **[NEW]** | Wing shall carry ≥ 3° geometric washout at the tip | Outer panel is unblown in transition (§5.3); washout makes it stall last | I |
| DR-12 **[NEW]** | All motor power and signal wiring crossing the wing pivot shall have a service loop rated for ≥ 5000 tilt cycles | The pivot is a moving electrical joint | T |
| DR-13 **[NEW]** | Transition shall be commanded only above 40 m AGL, with an abort-to-hover on a dedicated switch | R2 | D |

---

## 4. Preliminary sizing

### 4.1 Design point

| Parameter | Value |
|---|---|
| Configuration | Tilt-wing bicopter, straight wing, V-tail |
| MTOW (converged) | **2.81 kg** |
| Wing area S | 0.34 m² |
| Span b | 1428 mm (straight, AR 6.0) |
| Mean chord c | 238 mm |
| Wing loading | 8.3 kg/m² — meets DR-02 |
| Stall / cruise speed | 10.7 / 15.0 m/s |
| Rotors | 2 × 15 in, 6S |
| Thrust required | 2390 g per motor at T/W 1.7 |
| Battery | 6S 3000 mAh (67 Wh) |
| Motors at | y = ±380 mm |
| Wing tilt range | 0° to 85° |
| Nacelle differential | ±15° about the wing tilt axis |

### 4.2 The mass spiral, and how the battery breaks it

This is the most important thing that changed, and it is worth understanding rather than
just accepting the number.

Going from five motors to two means **each motor must lift 2.5× more**. That pushes you out
of the 2806 class (55 g, 1.2 kg thrust) and into the 4008/4014 class (~150 g, 2.4 kg
thrust). Heavier motors raise MTOW, which raises the thrust each must produce, which
demands a heavier motor. The design **spirals**.

Converged, holding everything else fixed:

| Battery | Energy | Converged MTOW | Motor mass ea. | Wing loading | Endurance |
|---|---:|---:|---:|---:|---:|
| 6S 4500 mAh | 100 Wh | 3072 g | 161 g | 9.0 kg/m² ❌ **fails DR-02** | 61 min |
| **6S 3000 mAh** | **67 Wh** | **2813 g** | **147 g** | **8.3 kg/m² ✓** | **43 min** |
| 6S 2200 mAh | 49 Wh | 2690 g | 140 g | 7.9 kg/m² ✓ | 32 min |

At 4500 mAh you carry roughly **250 g of energy you will never use** — endurance is ten
times the mission requirement — and that 250 g is what pushes the wing loading past DR-02
and the motors into the next size class. **6S 3000 mAh is the design point**: it breaks the
spiral, still leaves a 6× energy margin on a 7-minute mission, and keeps wing loading legal.

2200 mAh is tempting and I would not take it on a first build. The margin above the mission
is not for range, it is for the three landing attempts and the aborted transition.

### 4.3 Mass budget (high case = design case)

| Item | Mass |
|---|---:|
| Airframe: fuselage, tail, skins (LW-PLA) | 520 g |
| Wing structure + CF spar | 310 g |
| **Tilt mechanism: pivot, carry-through, actuator** | **200 g** |
| 2 × motor (4008/4014 class) | 295 g |
| 2 × ESC (40–50 A) + power wiring | 140 g |
| 2 × prop 15 in + adapters | 90 g |
| 2 × nacelle tilt servo (yaw) | 50 g |
| 4 × flight servo (flaperons, V-tail) | 70 g |
| Battery 6S 3000 mAh | 470 g |
| Avionics: FC, GPS, RX, telemetry, Remote ID | 150 g |
| Landing gear | 90 g |
| **Payload: can 370 g + carrier/servo 60 g** | **430 g** |
| **MTOW** | **2815 g** |
| Empty | 2385 g |

Versus Rev 0.1's quadplane at 2670 g high case, the tilt-wing is **+145 g** — after the
battery cut. Before the battery cut it was +460 g. The tilt mechanism (200 g) is a line
item the quadplane simply does not have.

**Payload fraction: 15 %.** State this honestly in the report.

### 4.4 Energy

6S 3000 mAh = 67 Wh, ~53 Wh usable at 80 % DoD.

| Item | Power | Energy |
|---|---:|---:|
| Hover + 2 transitions, ~50 s | 298 W | 4.1 Wh |
| Cruise (L/D ≈ 10.5, no booms, no dead rotors) | 76 W | — |
| **Endurance** | | **~43 min** |
| **Still-air range** | | **~39 km** |

Against MR-05's 1 km round trip this is a factor of ~40. Correct for a first aircraft.

Note the cruise number: **76 W versus 111 W for the Rev 0.1 quadplane**, a 32 % reduction.
This is the tilt-wing's genuine payoff. No booms, no dead rotors, clean wing.

### 4.5 Rotor sizing

| Prop | Disk area | Hover power | Slipstream w | Span washed |
|---|---:|---:|---:|---:|
| 12 in | 0.146 m² | 361 W | 8.7 m/s | 43 % |
| 13 in | 0.171 m² | 333 W | 8.0 m/s | 46 % |
| 14 in | 0.199 m² | 309 W | 7.4 m/s | 50 % |
| **15 in** | **0.228 m²** | **288 W** | **6.9 m/s** | **53 %** |
| 16 in | 0.259 m² | 270 W | 6.5 m/s | 57 % |

**Your intuition about hover efficiency was right.** Two 15 in rotors give 75 % more disk
area than four 8 in rotors, and hover on ~20 % less power. That is real and it is the main
physical argument for the two-motor layout.

There is a countervailing effect worth seeing: bigger rotors have *lower* disk loading, so
the slipstream is *slower*, so the wing gets *less* angle-of-attack protection during
transition (§5.3). 15 in sits at the knee. **Draw the nacelle so 14 in and 16 in both bolt
on, and settle it on the thrust stand in Phase 2.**

### 4.6 Geometry

With motors at y = ±380 mm and 15 in props (381 mm dia.): inner tip 190 mm from centreline,
outer tip 570 mm against a 714 mm semi-span. Clears the fuselage, clears the tip. 16 in also
fits. Good.

**Ground clearance:** with the wing at cruise angle the props are near-vertical and need
≥ 190 mm below the thrust line. The aircraft only ever takes off and lands with the wing at
85° (props horizontal), so this is not a normal-operations case — but design for it anyway,
because a belly landing after an aborted transition is a case you will eventually fly.

### 4.7 Reynolds number and print segmentation

Unchanged from Rev 0.1: **Re ≈ 240 000**, firmly low-Re, needs a purpose-chosen section.

For the tilt-wing the airfoil requirement is stricter than for a fixed wing: it must have
**high C_L,max and a gentle, progressive stall**, because §5.3 shows large parts of the wing
will be past stall during every transition. A section with an abrupt leading-edge stall is
disqualified. Candidates: SD7037, SD7062, Clark Y, S1223 (highest lift, draggiest, most
pitching moment). Settle in Phase 1 with XFLR5 polars.

Segmentation: 714 mm semi-span → **3 printed segments per side at ~240 mm** over a
continuous CF spar. Unchanged.

---

## 5. Configuration analysis

Rev 0.1 §5 ran the four-way trade and you chose the tilt-wing. This section no longer argues
configuration. It establishes **what the tilt-wing requires to work**.

### 5.1 The configuration, precisely

A **tilt-wing bicopter**. One motor per side mounted on a straight wing that rotates as a
unit from 0° (cruise) to 85° (hover). The wing carries flaperons across most of the span. A
V-tail on a fixed tailboom provides pitch and yaw in wing-borne flight.

ArduPilot mapping: `Q_FRAME_CLASS = 10` (Bicopter), `Q_TILT_TYPE = 3` (BiCopter),
tilt via the `TiltMotorsFront` servo function, with `Q_TILT_WING_FLAP` to droop the flaps
with wing angle.

### 5.2 Hover control — the one thing that must be got right

In hover the wing is vertical, both rotors thrust upward, and the aircraft has no airflow
over its tail. Every control moment must come from the two rotors. Define hover axes as
x = nose, y = span, z = up.

| Axis | Effector | Wing tilt only | + differential nacelle tilt |
|---|---|:---:|:---:|
| Thrust (z) | Collective throttle | ✓ | ✓ |
| Roll (x) | Differential throttle | ✓ | ✓ |
| Pitch (y) | Collective tilt — **this is the wing tilt** | ✓ | ✓ |
| **Yaw (z)** | **Differential tilt** | **✗ MISSING** | ✓ |

Three of four axes come free. Collective wing tilt *is* the bicopter pitch effector, so
pitch is covered. **Yaw is not.** With both motors rigidly fixed to a single tilting wing,
the only yaw effector is differential propeller torque, which is weak and directly fights
the differential throttle you need for roll.

**A rigid two-motor tilt-wing cannot hold heading in hover.** This is not a tuning problem.

Two ways to fix it, and the numbers decide between them. At MTOW 2.81 kg, 15 in rotors,
motors at y = ±380 mm, estimated I_zz ≈ 0.52 kg·m²:

| Option | Extra hardware | Yaw couple | Angular accel. | Verdict |
|---|---|---:|---:|---|
| Differential flaperon in the slipstream | none — reuses flaperon servos | 0.61 N·m | **68 °/s²** | Fails DR-09 |
| **Differential nacelle tilt ±15°** | **2 small servos** | **2.65 N·m** | **294 °/s²** | **Passes** |
| Differential nacelle tilt ±20° | 2 small servos | 3.51 N·m | 389 °/s² | Passes |

Typical multirotor yaw authority is 100–300 °/s². The free option delivers 68 and — worse —
its authority scales with slipstream dynamic pressure, so it **collapses at low throttle**,
which is exactly the descent-and-land condition where you need heading hold most.

**Conclusion: fit two small differential-tilt servos on the nacelles.** They ride on the
tilting wing, so their axis is the same spanwise axis; ±15° of travel is enough. Use the
flaperons as augmentation, not as the primary yaw effector. This is DR-09.

That is three tilt actuators total: one strong central wing-tilt drive, two small nacelle
servos.

### 5.3 Transition — the envelope you must respect

Rev 0.1 §5.2 established that a tilting wing spends most of its transition partly stalled.
Two motors makes this **slightly worse**, and the reason is counter-intuitive: larger rotors
have lower disk loading, so slipstream velocity drops from 9.0 m/s (4 × 8 in) to 6.9 m/s
(2 × 15 in). Less slipstream means less angle-of-attack relief. Washed span is similar,
53 % against 57 %.

Effective angle of attack on the wing, by tilt angle and airspeed:

| Wing tilt | V = 3 m/s | V = 6 m/s | V = 10 m/s |
|---:|:---|:---|:---|
| 80° | blown 22° — stalled | blown 36° — stalled | blown 49° — stalled |
| 60° | blown 17° — stalled | blown 28° — stalled | blown 36° — stalled |
| 45° | blown 13° — **inner wing attached** | blown 21° — stalled | blown 27° — stalled |
| 30° | blown 9° — **inner wing attached** | blown 14° — marginal | blown 18° — stalled |
| 20° | blown 6° — **attached** | blown 9° — **attached** | blown 12° — **attached** |
| 10° | blown 3° — **attached** | blown 5° — **attached** | blown 6° — **attached** |

Read the diagonal. **The safe corridor is low airspeed at high wing angle.** The transition
schedule is:

1. Hold V ≤ 4–5 m/s while the wing comes down from 85° to ~35°. The aircraft is
   thrust-borne here; the wing is along for the ride and partly stalled, which is acceptable
   as long as it is *symmetrically* stalled.
2. Below 35°, accelerate to cruise. The wing takes over progressively.

Mitigations, all of which go into the design now rather than later:

- **Washout, ≥ 3° at the tip (DR-11).** The outer 47 % of the wing is unblown. Washout makes
  the tips stall *last*, so the wing stalls from the root outward and you keep aileron
  authority longest. This is the single cheapest safety measure in the whole aircraft.
- **Large flaperons, drooped through transition.** `Q_TILT_WING_FLAP` exists for exactly
  this. Drooping the flaps effectively de-cambers the outer wing's demand and delays
  separation.
- **Gentle-stall airfoil** (§4.7).
- **Transition above 40 m AGL with an abort-to-hover switch (DR-13).** If the aircraft
  drops a wing, the recovery is to command the wing back to 85° and let the rotors carry it.

### 5.4 What the choice costs, stated plainly

Not to change your mind — to have it written down.

| | Quadplane (Rev 0.1) | Tilt-wing bicopter (Rev 0.2) |
|---|---|---|
| Cruise power | 111 W | **76 W (−32 %)** |
| Hover power | 362 W | **288 W (−20 %)** |
| MTOW | 2670 g | 2815 g (+145 g) |
| Endurance | 29 min | **43 min** |
| Actuators | 5 (4 flight + release) | **8** (4 flight + 3 tilt + release) |
| Motor failure in hover | Crash | Crash |
| **Can hover and fixed-wing be tested separately?** | **Yes** | **No** |
| ArduPilot community depth | Very large | Small |
| Transition risk | Moderate | **High** |

The last three rows are the real price. Losing separable testing is the big one: on a
quadplane you can prove hover with the pusher unplugged, then prove the wing with a hand
launch, then attempt transition. On a tilt-wing the wing, the pivot, the actuator, the
control allocation, and the transition schedule must all be right before the first landing.

§7 restructures the test programme around this. It is the main reason Phase 5 changed.

### 5.5 Swept wing — considered, rejected

Briefly raised and withdrawn, but worth one paragraph so the record is complete.

Sweep buys nothing here. Its purpose is delaying compressibility drag near Mach 0.7+; at
15 m/s (Mach 0.044) there is nothing to delay. What it *would* cost: spanwise flow that
makes tip stall worse — the opposite of what DR-11 is trying to achieve — a wing pivot that
no longer lies on a clean spanwise axis, and a CG/aerodynamic-centre relationship that moves
with tilt angle. A straight, constant-chord wing is also by far the easiest thing to
segment into 240 mm printed sections. **CR-07 fixes the wing as straight.**

---

## 6. Baseline architecture (Block 1)

### 6.1 Layout

```
                     ◄────────── 1428 mm straight wing ──────────►
                              (tilts 0° cruise → 85° hover)

   ╔═══════╤═══════════╤═══════════╤═╤═══════════╤═══════════╤═══════╗
   ║  tip  │  panel 2  │  panel 1  │ │  panel 1  │  panel 2  │  tip  ║  3 segments/side
   ╚═══════╧═══════╤═══╧═══════════╧═╧═══════════╧═══╤═══════╧═══════╝  over one CF spar
                   │                                 │
              ┌────┴────┐      ┌───────────┐    ┌────┴────┐
        M1 ═══╡ nacelle ╞══    │  WING     │  ══╡ nacelle ╞═══ M2      2 × 15" rotors
              │  ±15°   │      │  PIVOT    │    │  ±15°   │            at y = ±380 mm
              └─────────┘      │  + drive  │    └─────────┘            ±15° differential
                               └─────┬─────┘                            = YAW (DR-09)
                     ┌───────────────┴───────────────┐
                     │  FUSELAGE  ▣ can  ▣ 6S  ▣ FC  │
                     └───────────────┬───────────────┘
                                ┌────┴────┐
                                │ V-tail  │   fixed — does NOT tilt
                                └─────────┘
```

### 6.2 Subsystems

| Subsystem | Baseline | Note |
|---|---|---|
| Configuration | Tilt-wing bicopter | `Q_FRAME_CLASS=10`, `Q_TILT_TYPE=3` |
| Wing | Straight, constant chord, 3 printed segments/side, continuous CF spar, ≥3° washout | Airfoil TBD (§4.7) |
| **Wing tilt drive** | Geared, **non-backdrivable** actuator on the spar centreline | DR-10 — the single most critical mechanism |
| **Nacelle tilt** | 2 × small servo, ±15°, riding on the wing | DR-09 — yaw |
| Tail | V-tail on a fixed boom | Fixed: it must not tilt with the wing |
| Structure | LW-PLA skins, PLA-CF or PETG for the pivot and fittings, CF tube spar | Pivot area is **not** printed in plain PLA |
| Propulsion | 2 × 4008/4014-class, 15 in prop, 6S, ~2.4 kg thrust each | 14/16 in bolt-on compatible |
| ESC | 2 × 40–50 A, 6S | |
| Autopilot | ArduPlane 4.x, **H743-class recommended** | Bicopter + tilt allocation — do not fight F405 flash limits here |
| Navigation | M10 GPS + compass on a mast | |
| RC link | ELRS 2.4 GHz — **new receiver**, existing transmitter | CR-03 |
| Telemetry | 915 MHz link to Mission Planner | Non-negotiable for tilt-wing tuning |
| **FPV video** | **Deleted from Block 1** | See below |
| Payload release | Servo-actuated over-centre latch, fail-safe closed | DR-04 |
| Battery | 6S 3000 mAh LiPo | §4.2 |
| Regulatory | Remote ID broadcast module | DR-08 |

**On deleting FPV.** You are right to cut it, and the argument is stronger than the 50 g.
Under Part 107 you must maintain **visual line of sight** with the aircraft anyway, so a
camera adds nothing the mission actually requires. The debugging job it might have done is
better done by the **ArduPilot dataflash log**, which records attitude, airspeed, tilt
angle, and every motor output at 50 Hz — far more useful for diagnosing a transition upset
than a video of the ground rotating. Keep the goggles for Block 2.

**One thing the deletion must not take with it: telemetry.** A live 915 MHz link to Mission
Planner is not FPV and it is not optional on this configuration. You need to see attitude
and tilt angle in real time during transition testing, and you need the ability to command
abort from the ground station.

### 6.3 The wing pivot

Worth calling out separately, because it is the part most likely to end the program.

It must simultaneously: carry full wing bending moment across the fuselage, rotate through
85° under load, hold position with power removed (DR-10), and pass all motor power and
signal wiring across a moving joint (DR-12).

Design direction: **do not make the pivot out of printed plastic.** The bending load should
pass through a continuous carbon spar that runs through the fuselage in aluminium or steel
bearing blocks, with the printed structure locating things rather than carrying them. The
tilt drive acts on a lever arm on that spar, not on the printed wing.

This part gets designed first in Phase 1, before the airfoil, because if it cannot be built
the aircraft cannot be built.

---

## 7. Build plan — restructured for the tilt-wing

Rev 0.1's Phase 5/6 split (hover alone, then fixed-wing alone) **is not available on this
configuration**. The test programme is restructured to buy back as much of that risk
reduction as possible on the ground.

| Phase | Work | Exit criteria |
|---|---|---|
| **0 — Definition** | This document, agreed | §10 closed; requirements frozen at Rev 1.0 |
| **1 — Preliminary design** | **Wing pivot concept first.** Then airfoil, structural layout, CG diagram, mass properties | Pivot buildable and DR-10 satisfied; CG closed loaded and empty; BOM priced |
| **2 — Bench** | Thrust-stand one motor/prop/ESC. Measure thrust, current, and **yaw couple from ±15° nacelle tilt** | DR-01 met; **DR-09 met by measurement, not calculation** |
| **3 — Detail design + CAD** | Full parametric CAD, segmented for CR-01, print orientation per DR-06 | All parts fit 256³; pivot loads analysed |
| **4 — Manufacture** | Print, assemble, wire, balance | Mass ≤ 3.0 kg; CG on datum; DR-07 passed; tilt swept 500 cycles on the bench |
| **5 — SITL** **[NEW]** | Fly the whole mission in ArduPilot SITL with your frame parameters. Tune the transition schedule in simulation | Full mission flown in sim, including a transition abort |
| **6 — Tethered hover** **[NEW]** | Hover on a tether at ~1 m. Verify all four axes, especially heading hold in a descent | 2 min stable hover, heading held ±5°, no yaw drift at low throttle |
| **7 — Free hover** | Untethered hover, translation, spot landings | 10 spot landings inside 1.5 m |
| **8 — Transition** | Forward transition at ≥ 40 m AGL over open ground, abort switch armed | Both transitions repeatable 5× |
| **9 — Mission** | Waypoints, then payload drop | §1 success criteria met |

Phases 5 and 6 are new and they are the substitute for what the quadplane gave you for
free. **SITL is not optional on this configuration.** Getting the control allocation and
tilt schedule wrong is cheap in simulation and expensive in the field.

---

## 8. Risk register

| # | Risk | L | I | Mitigation |
|---|---|:-:|:-:|---|
| R1 | **Mass growth.** Margin to CR-05 is now only 185 g, versus 330 g in Rev 0.1. | H | H | Weigh every printed part against §4.3 as it comes off the bed. First lever if exceeded: battery to 2200 mAh (−110 g, still 32 min). Do not cut structure. |
| R2 | **Transition upset.** Higher than Rev 0.1: partly-stalled wing, no separable test, small community. | **H** | H | DR-11 washout, DR-13 altitude + abort switch, Phase 5 SITL, Phase 6 tether. Transition slowly per §5.3. |
| R3 | **Yaw authority short of DR-09.** Estimate is 294 °/s² against a 150 requirement — comfortable, but I_zz is an estimate. | M | H | **Measure it on the thrust stand in Phase 2.** If short: increase differential to ±20° (389 °/s²), or move motors outboard. |
| R4 | **Wing pivot failure.** Structural failure or loss of tilt authority in transition is unrecoverable. | M | **H** | §6.3: load through a metal-bearinged CF spar, not printed plastic. DR-10 non-backdrivable drive. 500-cycle bench test in Phase 4. |
| R5 | **Wiring fatigue at the pivot.** A moving electrical joint that fails mid-transition kills a motor. | M | H | DR-12 service loop, silicone wire, strain relief both sides, cycle-tested with the pivot. |
| R6 | **Single-motor failure = loss of aircraft.** Two motors means zero hover redundancy. | L | **H** | Matched motors and ESCs from one batch. Bench-run both to temperature before install. Accept the residual risk; fly over open ground only. |
| R7 | **Big-motor sourcing.** 4008/4014-class motors and 15 in props have thinner Amazon selection and less reliable published thrust data. | M | M | Verify on the thrust stand in Phase 2 *before* committing CAD. Order spares. |
| R8 | **PLA + sun.** PLA softens at 55–60 °C; a dark airframe on Charlotte asphalt reaches it. | H | M | Light colours; PETG/ASA for the pivot and any loaded fitting; never leave it in a closed car. |
| R9 | **Layer-line failure at joints.** | M | H | DR-06. Destructive test one wing joint in Phase 4. |
| R10 | **CG shift on release.** 370 g leaving mid-flight. | H | M | DR-03: payload CG coincident with aircraft CG. Verify by swing test in Phase 4. |
| R11 | **Regulatory non-compliance.** | M | H | Close §9 before the first outdoor flight. |
| R12 | **Scope growth.** | H | M | Freeze at Rev 1.0. New ideas go to a Block 2 list. |

---

## 9. Regulatory — resolve before first outdoor flight

*(Unchanged from Rev 0.1. Confirm all of this at faa.gov — do not treat this section as
authoritative.)*

At ~2.8 kg the aircraft is well over the 250 g threshold.

- **Aircraft registration** with the FAA.
- **TRUST** certificate (recreational) or **Part 107** remote pilot certificate. Part 107 is
  worth having regardless, and it is a real line on an aerospace CV.
- **Remote ID.** Broadcast Remote ID is mandatory. A homebuilt needs a **broadcast module**,
  or the flight must happen inside an FAA-recognised identification area (FRIA).
- **Dropping objects.** Part 107 permits releasing an object from a small UAS provided it
  does not create an undue hazard. Plan the drop zone accordingly.
- **Airspace.** Check class and LAANC requirement for your test site near Charlotte.
- **Site.** Large open field, clear 100 m radius. Worth asking whether UNC Charlotte has an
  arrangement for student projects.

**Action: confirm each and record in `01_Requirements/regulatory.md` before Phase 6.**

---

## 10. Open decisions

| # | Decision | Options | My recommendation |
|---|---|---|---|
| D1 | ~~Configuration~~ | — | **CLOSED — tilt-wing bicopter, straight wing.** Customer decision, Rev 0.2 |
| D2 | **Budget ceiling.** Now higher than Rev 0.1: big motors and 6S push it up. | ~$350 lean / ~$500 comfortable | Realistically **$450–550** for this configuration |
| D3 | **Timeline.** | Semester / winter break / spring | Airbus and Thales summer applications close in autumn. A flying aircraft by **December** is the target that matters — and the tilt-wing makes that tighter than Rev 0.1 did |
| D4 | **CAD tool.** | Fusion 360 / SolidWorks / Onshape | Whichever you know. Tie-break: **Fusion 360** |
| D5 **[CHANGED]** | **Autopilot board.** | F405-WING (~$45) / **H743 (~$110)** | **H743.** Bicopter + tilt allocation + full mission support is not where you want to be fighting F405 flash limits. This is the upgrade most worth the money now |
| D6 | **Filament strategy.** | — | **LW-PLA skins, PLA-CF or PETG for the pivot and all loaded fittings.** Not negotiable at the pivot |
| D7 | **Test site.** | — | Needed before Phase 6. Identify early |
| D8 **[NEW]** | **Wing tilt actuator.** | High-torque digital servo + lever / worm-gear drive / linear actuator | **Worm gear** — inherently non-backdrivable, satisfies DR-10 for free. Costs speed, which does not matter over a 10 s transition |
| D9 **[NEW]** | **Tail configuration.** | V-tail / conventional / inverted-V | **V-tail** — fewer servos, better ground clearance, cleaner boom junction. Worth confirming in Phase 1 |

---

## 11. Next step

On D2, D3, D5 and D8, the next work package is **Phase 1 preliminary design**, and for this
configuration it starts in a different place than Rev 0.1 did:

1. **Wing pivot concept and load path** — first, because it gates everything (§6.3)
2. Airfoil selection: XFLR5 polars at Re ≈ 240 000, screened for **gentle stall** as much as for L/D
3. CG diagram loaded and released, against the neutral point, at both wing tilt extremes
4. Priced BOM against D2

Delivered one step at a time.

---

## Appendix A — Document tree

```
AGUILA/
├── 00_Program/          this document, schedule, decision log
├── 01_Requirements/     requirements register, regulatory
├── 02_Design/           configuration, layout drawings
├── 03_Analysis/         aero, structures, mass properties, energy
├── 04_CAD/              parametric models
├── 05_Print/            sliced profiles, print logs, part masses
├── 06_Firmware/         ArduPilot parameters, SITL configs
├── 07_Test/             test cards, flight logs, results
└── 08_Procurement/      BOM, orders, bench-test data
```

## Appendix B — Revision history

| Rev | Date | Change |
|---|---|---|
| 0.1 | 2026-09-06 | Initial MVP definition. Quadplane baseline recommended. |
| 0.2 | 2026-09-06 | Configuration changed to tilt-wing bicopter by customer decision. FPV deleted from Block 1. Battery reduced to 6S 3000 mAh to break the mass spiral. DR-09 to DR-13 added. Test programme restructured around loss of separable hover/fixed-wing testing. Swept wing considered and rejected (CR-07). |

## Appendix C — References

- ArduPilot, *Tilt Rotor Planes* (tilt-wing support, `Q_TILT_TYPE`, `Q_TILT_WING_FLAP`) — https://ardupilot.org/plane/docs/guide-tilt-rotor.html
- ArduPilot, *QuadPlane Frame Setup* (`Q_FRAME_CLASS` incl. Bicopter) — https://ardupilot.org/plane/docs/quadplane-frame-setup.html
- ArduPilot, *Tailsitter Planes* — https://ardupilot.org/plane/docs/guide-tailsitter.html
- Bambu Lab, *A1 Technical Specifications* — https://bambulab.com/en/a1/tech-specs
- Bambu Lab Wiki, *Print volume limitations* — https://wiki.bambulab.com/en/knowledge-sharing/print-volume-limitations
