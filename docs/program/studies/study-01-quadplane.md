---
title: Study 01 — quadplane
---

!!! warning "Exploratory study — not adopted, numbers not decided"
    An early configuration study that recommended a **quadplane**. The recommendation was
    overruled — see [D1](../decision-log.md#d1-configuration). Every dimension, mass and
    component in this document is **preliminary sizing produced to compare configurations**,
    not a design decision. None of it has been adopted.

    Kept because the comparison is the useful part. Read it for the argument, not the numbers.

**Rev 0.1 — 6 September 2026**
Author: Juan Martínez · Status: **Draft for review** · Supersedes: none

---

## 0. How to read this document

This is the top of the document tree for AGUILA. Everything downstream — CAD, firmware,
test cards, the bill of materials — traces back to the requirements in §3. When a
requirement changes here, the change propagates down; nothing downstream gets to invent
its own requirement.

Numbers in this revision are **preliminary sizing**, not design values. They exist to
size the aircraft, choose a configuration, and expose the risks early. They will be
replaced by analysis and then by measurement. Anywhere a number is a guess, it is
labelled as one.

**What still needs your decision** is collected in §10. Read that first if you are short
on time.

---

## 1. Program intent

Design, analyse, build, and fly a VTOL-capable unmanned aircraft that carries a standard
33 cl beverage can to a GPS waypoint, releases it, and returns — executing the full
engineering cycle rather than assembling someone else's kit.

The secondary intent matters as much as the primary: this is a **portfolio artefact**.
The requirements register, the trade study, the analysis, and the flight-test data are
the deliverables an Airbus or Thales recruiter can actually evaluate. A flying aircraft
with no paper trail proves less than a well-documented program with one hard-won flight.

### Success criteria for the MVP

The MVP is achieved when the aircraft, in a single sortie and without human intervention
between arming and disarm:

1. Takes off vertically (or within a 1.5 m footprint),
2. Transitions to wing-borne flight,
3. Flies an uploaded waypoint mission of ≥ 500 m out,
4. Releases a full 33 cl can within 10 m of a commanded drop point,
5. Returns, transitions back, and lands within 3 m of the launch point.

Anything beyond that — precision drop, autonomous landing on a marker, second payload —
is out of scope for the MVP and belongs in a later block.

---

## 2. Concept of operations

```
   ┌── vertical climb ──┐                                              ┌── descent ──┐
   │   (≤1.5 m footprint)                                              │             │
   │        ▲                                                          ▼             │
 LAUNCH ────┘   transition ──► CRUISE ──► loiter/drop ──► CRUISE ──► transition ── LAND
            15–25 m AGL       60–100 m AGL    30 m AGL      60–100 m AGL      15–25 m AGL
              ~5–8 s            ~15 m/s      hover 10 s       ~15 m/s           ~5–8 s
```

| Phase | Duration | Mode | Notes |
|---|---|---|---|
| Pre-flight | — | Disarmed | Can loaded and latched, CG verified with payload aboard |
| Vertical climb | 8–12 s | QSTABILIZE / QLOITER | To ≥15 m AGL before transition |
| Transition out | 5–8 s | Auto | Highest-risk phase of the whole mission |
| Outbound cruise | 60–120 s | AUTO waypoints | 15 m/s nominal |
| Drop | ~10 s | QLOITER hold | Hover, verify position, release, confirm mass change |
| Return cruise | 60–120 s | AUTO / RTL | Aircraft is now 370 g lighter — CG shifts, retrim |
| Transition in | 5–8 s | Auto | Second-highest-risk phase |
| Vertical land | 10–15 s | QLAND | |

**Design mission total: ~6 minutes.** Battery is sized in §4 for roughly 3× that, because
the first twenty flights will be spent hovering, aborting, and re-approaching rather than
flying the clean profile.

---

## 3. Requirements register

Verification methods: **A**nalysis · **I**nspection · **D**emonstration · **T**est.

### 3.1 Mission requirements

| ID | Requirement | Rationale | Verif. |
|---|---|---|---|
| MR-01 | Carry one full 33 cl aluminium beverage can (370 g ± 20 g incl. contents) | Stated payload | I |
| MR-02 | Release the payload in flight on command, and confirm release to the operator | Delivery mission | D |
| MR-03 | Take off and land within a 1.5 m diameter footprint from unprepared grass | Stated; relaxes pure-vertical constraint | D |
| MR-04 | Fly an operator-uploaded GPS waypoint mission without stick input | Stated autonomy level | D |
| MR-05 | Design mission radius ≥ 500 m with ≥ 50 % energy reserve on landing | MVP success criterion + margin | A, T |
| MR-06 | Return to launch autonomously on RC link loss, low battery, or operator command | Safety | T |

### 3.2 Constraint requirements

| ID | Requirement | Rationale | Verif. |
|---|---|---|---|
| CR-01 | Every structural part printable on a Bambu Lab A1: **256 × 256 × 256 mm** | Stated manufacturing constraint | I |
| CR-02 | All components procurable from Amazon US, or from stock already owned | Stated sourcing constraint | I |
| CR-03 | The existing 5-inch FPV quad shall not be disassembled | Stated | I |
| CR-04 | Reuse the existing ELRS transmitter and Walksnail goggles | Stated | I |
| CR-05 | MTOW ≤ 3.0 kg | Sizing limit; see §4 mass-growth risk | T |
| CR-06 | No part shall require a machine tool the workshop does not have | Buildability | I |

### 3.3 Derived requirements *(mine, not yours — challenge any of these)*

| ID | Requirement | Derived from | Verif. |
|---|---|---|---|
| DR-01 | Hover thrust-to-weight ≥ 1.7 at MTOW | MR-03; control authority in wind | T |
| DR-02 | Wing loading ≤ 8.5 kg/m² at MTOW | Keeps stall ≤ 11 m/s → survivable landings | A |
| DR-03 | CG travel between can-loaded and can-released ≤ 5 % MAC | MR-02 without retrim divergence | A, T |
| DR-04 | Payload release shall be mechanically fail-safe: no release on power loss | Safety | T |
| DR-05 | Aircraft shall be transportable in a car without disassembly beyond wing removal | Field testing practicality | D |
| DR-06 | Every printed structural joint shall carry load through a CF spar or steel fastener, never through printed threads or a printed layer line in tension | PLA layer adhesion is the weak axis | I, T |
| DR-07 | Airframe shall survive a 1.5 m drop test on the landing gear at MTOW | First landings will be hard | T |
| DR-08 | Carry an FAA-compliant Remote ID broadcast module | Regulatory — see §9 | I |

---

## 4. Preliminary sizing

### 4.1 Mass budget

Sized three ways so the design has an explicit pessimistic case. **The high column is the
design case** — printed airframes come out heavier than estimated essentially always.

| Item | Low | Nominal | High |
|---|---:|---:|---:|
| Airframe (LW-PLA + CF spars + hardware) | 550 g | 700 g | 850 g |
| Lift propulsion (4× motor + ESC + prop) | 280 g | 340 g | 400 g |
| Cruise propulsion (1× motor + ESC + prop) | 90 g | 110 g | 140 g |
| Battery (4S ≈ 5000 mAh LiPo) | 440 g | 500 g | 560 g |
| Avionics (FC, GPS, RX, VTX, camera, wiring) | 140 g | 170 g | 210 g |
| Servos (4 flight + 1 release) | 50 g | 60 g | 80 g |
| Payload (can 370 g + carrier/servo 60 g) | 430 g | 430 g | 430 g |
| **MTOW** | **1.98 kg** | **2.31 kg** | **2.67 kg** |
| Empty (payload removed) | 1.55 kg | 1.88 kg | 2.24 kg |

**Design MTOW = 2.67 kg (5.9 lb).** Note the payload is only **16 %** of MTOW. That ratio
is the honest cost of a first VTOL design in printed plastic, and it is worth stating in
the report rather than hiding.

### 4.2 Wing

| Parameter | Value | Basis |
|---|---|---|
| Wing area S | 0.34 m² | Sized to keep stall ≤ 11 m/s at 2.67 kg with C_L,max ≈ 1.1 |
| Aspect ratio | 6.0 | Compromise: efficiency vs. root bending in printed structure |
| Span b | 1428 mm | √(AR·S) |
| Mean chord c | 238 mm | S/b |
| Wing loading | 7.9 kg/m² (77 N/m², 25.7 oz/ft²) | Within DR-02 |
| Stall speed | 10.7 m/s (38 km/h) | |
| Cruise (1.4 V_s) | 15.0 m/s | |
| Approach (1.3 V_s) | 13.9 m/s | |
| Reynolds no. at cruise | ≈ 238 000 | **Low-Re regime — see §4.5** |

### 4.3 VTOL thrust

| T/W | Total thrust required | Per motor (4 lift rotors) |
|---:|---:|---:|
| 1.6 | 4270 g | 1070 g |
| 1.8 | 4810 g | 1200 g |
| **2.0** | **5340 g** | **1335 g** |

DR-01 sets the floor at 1.7. Target motor class: **~1200–1400 g static thrust each on 4S**,
which is a 2806/2807-size motor on an 8–9 inch prop, or a 2207 on 8 inch running hot.

Disk loading matters more than most first-time builders expect:

| Prop | Disk area (4 rotors) | Disk loading | Est. hover power (all 4, FM ≈ 0.65) |
|---|---:|---:|---:|
| 7 in | 0.099 m² | 264 N/m² | ~420 W |
| **8 in** | **0.130 m²** | **202 N/m²** | **~366 W** |
| 9 in | 0.164 m² | 160 N/m² | ~325 W |
| 10 in | 0.203 m² | 129 N/m² | ~293 W |

Bigger props hover on less power, always. The constraint is geometric: at 1428 mm span,
9 inch props on four booms fit; 10 inch starts fighting the fuselage and the tail. **Baseline
8 inch, with the boom geometry drawn so 9 inch is a bolt-on change.**

### 4.4 Energy

4S 5000 mAh LiPo = 74 Wh, of which ~59 Wh is usable (80 % DoD, LiPo cycle life).

| Item | Energy |
|---|---:|
| Hover + 2 transitions, 45 s total at ~560 W | 7.0 Wh |
| Remaining for cruise | 52 Wh |
| Cruise at ~102 W (quadplane, L/D ≈ 7) | **31 min → ~28 km still-air** |
| Cruise at ~160 W (pessimistic) | 20 min → ~18 km |

Against MR-05 (500 m radius, 1 km round trip) this is a factor of ~20 in reserve. That is
correct for a first aircraft: the margin is not there for range, it is there to absorb
being wrong about drag, being wrong about hover power, and needing three landing attempts.

### 4.5 Two things the sizing exposes early

**Reynolds number ≈ 240 000.** This is squarely low-Re. A scaled-down full-size airfoil
(NACA 2412 and friends) performs badly here — laminar separation bubbles, poor C_L,max,
high drag. The wing needs a section designed for this regime: **SD7037, S1223 (high lift,
draggy), Clark Y, or AG-series**. This must be settled before any CAD, because the airfoil
sets the spar depth, which sets the whole wing structure.

**Print segmentation.** At 1428 mm span, each half-wing is 714 mm:

| Segment length | Segments per side | Total wing parts |
|---|---:|---:|
| 230 mm | 4 | 8 (+ tips, + joiners) |
| 240–250 mm | 3 | 6 (+ tips, + joiners) |

Every joint is a potential failure point and a mass penalty. Design for **3 segments per
side at ~240 mm**, joined over a continuous carbon spar (DR-06). Printing parts on the
diagonal of the bed buys 362 mm for angled components such as the tail booms.

---

## 5. Configuration trade study

Four candidates, including the tilt-wing you asked to see evaluated.

### 5.1 Candidates

**A — Quadplane (4 lift rotors + 1 pusher).** Fixed wing, four dedicated lift motors on
booms, one separate cruise motor. Lift and cruise systems fully decoupled.

**B — Tilt-wing.** The entire wing rotates, carrying the propellers with it. Vertical at
takeoff, horizontal in cruise. No dedicated lift motors.

**C — Tilt-rotor.** Wing fixed; motor nacelles rotate. Typically the two front rotors tilt
and become cruise thrust, with two fixed rear lift rotors.

**D — Tailsitter.** The whole aircraft sits on its tail, takes off vertically, and pitches
over into cruise. No tilting parts at all.

### 5.2 The tilt-wing problem, quantified

This deserves its own analysis rather than a hand-wave, because it is the reason tilt-wings
are rare despite being the most elegant option on paper.

During transition the wing is tilted at angle θ to the airframe while the aircraft moves
forward at V. The wing's angle of attack relative to the freestream is essentially θ — far
past stall for most of the transition. The propeller slipstream rescues part of the wing by
adding axial velocity through it. Using momentum theory, four 8 inch rotors at hover thrust
produce an induced velocity of **w ≈ 9.1 m/s**.

But four 8 inch props across a 1428 mm span only wash **57 % of the wing**. The remaining
**43 % sees clean air at the full geometric angle of attack.**

| Wing tilt | Airspeed | AoA, unblown wing | AoA, blown wing | State |
|---:|---:|---:|---:|---|
| 75° | 8 m/s | 75° | 35° | Fully stalled |
| 60° | 8 m/s | 60° | 28° | Fully stalled |
| 45° | 4 m/s | 45° | 13° | Blown section attached only |
| 45° | 8 m/s | 45° | 21° | Fully stalled |
| 30° | 8 m/s | 30° | 14° | Marginal |
| 15° | 8 m/s | 15° | 7° | Attached |
| 15° | 12 m/s | 15° | 9° | Attached |

Read the middle of that table: **through most of the transition envelope, roughly half the
wing is stalled.** The aircraft is flying on thrust and on the blown inner wing, and the
outer panels — where the ailerons are — are producing separated flow and unreliable roll
control. This is exactly what killed the transition handling of the Canadair CL-84 and
Vought XC-142 in the 1960s, and it is not a problem that gets easier at model scale.

It is solvable. The solutions are full-span blowing (more, smaller props), large
Fowler-type flaps deployed through the transition, or a very slow transition at near-zero
airspeed. Each adds mechanism, mass, and tuning. **None of them is a good first project.**

The structural problem is equally real: the wing pivot must carry full wing bending moment
through a rotating joint, and all motor power and signal wiring must pass through it.
In printed PLA on an A1, that pivot is the hardest single part in the entire program.

### 5.3 Weighted trade

| Criterion | Weight | A: Quadplane | B: Tilt-wing | C: Tilt-rotor | D: Tailsitter |
|---|---:|:---:|:---:|:---:|:---:|
| First-flight success probability (solo, first design) | 0.25 | 5 | 2 | 3 | 3 |
| ArduPilot maturity + waypoint-VTOL depth | 0.15 | 5 | 2 | 4 | 4 |
| Printability on A1 / PLA structural feasibility | 0.15 | 5 | 2 | 3 | 4 |
| Payload bay + drop geometry | 0.15 | 5 | 3 | 4 | 2 |
| Cruise efficiency / range | 0.10 | 3 | 5 | 4 | 4 |
| Amazon parts availability | 0.10 | 5 | 3 | 4 | 4 |
| Build time + cost | 0.10 | 4 | 2 | 3 | 4 |
| **Weighted total (of 5)** | | **4.70** | **2.55** | **3.50** | **3.45** |

Supporting notes on the scoring:

- **ArduPilot support** exists for all four. Quadplane is by far the most flown; tilt-wing
  is supported (`Q_TILT_TYPE`, the `TiltMotorsFront` servo function, `Q_TILT_WING_FLAP`)
  but with a small community, so debugging happens alone.
- **Cruise efficiency** is the quadplane's only real loss. Four dead rotors and their booms
  cost roughly 25 % of cruise power: L/D ≈ 7 versus ≈ 9.5 for a clean wing, which is
  ~31 min endurance versus ~42 min. Against MR-05 that difference is irrelevant.
- **Payload geometry** is where the tailsitter fails badly. It rests nose-up, so the can
  bay is vertical on the ground, and precision hover over a drop point in wind is the thing
  tailsitters do worst.

### 5.4 Recommendation

**Block 1: quadplane.** It wins on every criterion that determines whether you get a flying
aircraft, and loses only on the one that does not matter at 500 m range.

The important point is not "quadplane is best" — it is **what the quadplane buys you**. It
is the only configuration where the VTOL system and the fixed-wing system can be tested
separately. You can tune hover with the wing bolted on and the pusher unplugged, prove the
airframe flies with a hand launch and the lift rotors idle, and only then attempt a
transition. Every tilting configuration forces you to get the wing, the mechanism, the
transition logic, and the tune all correct before the first landing.

The interesting configurations are not abandoned. Design the boom-to-wing interface as a
**bolted cassette** from the start, and Block 2 converts the front two booms to tilting
nacelles — a tilt-rotor — reusing the same wing, fuselage, and payload bay. That is a
genuine second design cycle with a real trade study behind it, and it makes a far better
portfolio story than a tilt-wing that never transitioned.

> **This is a recommendation, not a decision.** If the tilt-wing is the thing you actually
> want to build, say so and we will build it — but we will do it with eyes open about §5.2
> and budget the schedule accordingly.

---

## 6. Baseline architecture (Block 1)

```
                          1428 mm span
   ┌────────┬───────────────┬─────────┬───────────────┬────────┐
   │  tip   │   panel 3     │ panel 2 │   panel 1     │  root  │   ← 3 printed segments/side
   └────────┴──────┬────────┴────┬────┴──────┬────────┴────────┘      over a continuous CF spar
                   │             │           │
              ┌────┴────┐   ┌────┴────┐  ┌───┴─────┐
        M1 ───┤ boom L  │   │ FUSELAGE│  │ boom R  ├─── M2      ← 4 lift rotors, X layout
        M3 ───┤         │   │  ▣ can  │  │         ├─── M4         8 in props, 4S
              └─────────┘   │  ▣ batt │  └─────────┘
                            │  ▣ FC   │
                            └────┬────┘
                                 │  M5 pusher ──►                 ← cruise motor, aft
                            ┌────┴────┐
                            │ V-tail  │                           ← ruddervators, 2 servos
                            └─────────┘
```

| Subsystem | Baseline | Note |
|---|---|---|
| Configuration | Quadplane, X lift layout + aft pusher | `Q_FRAME_CLASS=1`, `Q_FRAME_TYPE=1` |
| Wing | 3 printed segments per side, continuous CF spar | Airfoil TBD — §10 |
| Tail | V-tail on twin booms, or conventional on a single boom | Trade in Rev 0.2 |
| Structure | LW-PLA foaming filament for skins, PETG/PLA-CF for load fittings, CF tube spars and booms | |
| Lift propulsion | 4× ~2806 on 8 in, 4S, ~1200 g each | 30–40 A ESCs |
| Cruise propulsion | 1× 2207-class pusher, folding prop | Folding prop is not optional — a fixed pusher hits the ground on VTOL landing |
| Autopilot | ArduPlane 4.x on an F405-WING-class board | **Flash size risk — see §8** |
| Navigation | M10/M9 GPS + compass on a mast, clear of power wiring | |
| RC link | ELRS 2.4 GHz — **new receiver**, existing transmitter | CR-03 |
| Telemetry | ELRS backhaul, or a dedicated 915 MHz link to Mission Planner | Needed for waypoint work |
| Video | Walksnail VTX + camera — **new air unit**, existing goggles | CR-03/CR-04 |
| Payload release | Servo-actuated over-centre latch, fail-safe closed | DR-04 |
| Battery | 4S 5000 mAh LiPo, XT60/XT90 | Position sets CG trim |
| Regulatory | Remote ID broadcast module | DR-08 |

### On reusing the ELRS receiver

You said you'd reuse the receiver but not disassemble the 5-inch. Those conflict — the
receiver is soldered into that quad. An ELRS receiver is a ~$15–20 part. **Buy a new one.**
The transmitter and the goggles are the things worth reusing, and both reuse cleanly. Same
logic for the Walksnail air unit: goggles are reused, the VTX/camera is bought new.

---

## 7. Build plan — phase gates

Each gate is a stop. Nothing proceeds until its exit criteria are met and written down.

| Phase | Work | Exit criteria |
|---|---|---|
| **0 — Definition** | This document, agreed | §10 closed; requirements frozen at Rev 1.0 |
| **1 — Preliminary design** | Airfoil selection, structural layout, CG diagram, mass properties, BOM | CG envelope closed with and without payload; BOM priced |
| **2 — Procurement + bench** | Order parts; bench-test one motor/prop/ESC on a thrust stand | **Measured** thrust ≥ DR-01 at MTOW; measured masses replace §4.1 estimates |
| **3 — Detail design + CAD** | Full parametric CAD, segmented for CR-01, print stress orientation per DR-06 | All parts fit 256³; spar loads analysed |
| **4 — Manufacture** | Print, assemble, wire, balance | Actual mass ≤ 2.67 kg; CG on datum; DR-07 drop test passed |
| **5 — Hover only** | Wing on, pusher unplugged, tethered then free hover | Stable QLOITER, 2 min hover, no overheating |
| **6 — Fixed-wing only** | Lift rotors disabled, hand launch or high-speed pass | Trimmed flight, control authority confirmed, stall speed measured |
| **7 — Transition** | Forward transition at altitude, over open ground, with an abort plan | Both transitions repeatable 5× |
| **8 — Mission** | Waypoints, then payload drop | MVP success criteria in §1 met |

**Phases 5 and 6 must happen before phase 7.** This ordering is the single largest risk
reduction available, and it is the reason the quadplane was selected.

---

## 8. Risk register

| # | Risk | L | I | Mitigation |
|---|---|:-:|:-:|---|
| R1 | **Mass growth.** Printed airframes routinely land 20–30 % over estimate. At 3.2 kg the T/W falls below 1.5 and the aircraft becomes unflyable in wind. | H | H | Design case is already the high column. Weigh every part as it comes off the printer and track against §4.1. Hard stop at CR-05; if exceeded, cut battery to 4000 mAh before touching structure. |
| R2 | **Transition upset.** Highest-risk phase; loss of control here usually destroys the airframe. | M | H | Transition at ≥60 m AGL over open ground, with QSTABILIZE on a switch as abort. Simulate in SITL first. |
| R3 | **F405 flash limit.** ArduPlane on F405-class boards is tight on flash; some quadplane features get trimmed from the build. | M | M | Verify the specific board's ArduPlane firmware includes full quadplane + mission support **before ordering**. If not, move to an H743-class board — it is the single upgrade most worth the money. |
| R4 | **PLA + sun.** PLA softens around 55–60 °C. A dark airframe on hot asphalt in Charlotte will reach that. | H | M | Light colours; PETG or ASA for anything highly loaded; never leave the aircraft in a closed car. |
| R5 | **Layer-line failure in the spar joints.** PLA is weak between layers; a wing joint loaded in tension across layers fails suddenly. | M | H | DR-06: all structural load through CF spar or steel fastener. Test one wing joint to destruction in phase 4. |
| R6 | **CG shift on release.** 370 g leaving the aircraft mid-flight shifts CG and retrims it. | H | M | DR-03: design the bay so the payload CG sits at the aircraft CG. Verify by analysis in phase 1 and by a ground swing test in phase 4. |
| R7 | **Amazon component quality.** Listings change, specs are unreliable, motor Kv is sometimes simply wrong. | M | M | Bench-verify in phase 2 before committing to CAD. Order spare motors and props — you will break props. |
| R8 | **Regulatory non-compliance.** Registration, TRUST, Remote ID, and payload-drop rules all apply. | M | H | Close §9 before the first outdoor flight. |
| R9 | **Scope growth.** "While I'm at it, let me add a camera gimbal / drop mechanism v2 / second payload." | H | M | Requirements freeze at Rev 1.0. New ideas go in a Block 2 list, not into Block 1. |

---

## 9. Regulatory — resolve before first outdoor flight

At ~2.7 kg this aircraft is over the 250 g threshold, so it is not exempt from registration.
The items to confirm directly with the FAA — **do not take this section as authoritative**:

- **Aircraft registration** with the FAA.
- **TRUST** certificate (recreational) or **Part 107** remote pilot certificate. Part 107 is
  worth having regardless; it is also a genuine line on an aerospace CV.
- **Remote ID.** Broadcast Remote ID is mandatory. A homebuilt aircraft has no built-in
  module, so it needs a **broadcast module** — or the flight must happen inside an
  FAA-recognised identification area (FRIA). Budget for the module.
- **Dropping objects.** Part 107 permits releasing an object from a small UAS provided it
  does not create an undue hazard. Plan the drop zone accordingly: your own site, no people,
  no property, no roads.
- **Airspace.** Check the class and any LAANC requirement for your test site near Charlotte.
- **Site.** A large open field with a clear 100 m radius. UNC Charlotte may have an
  arrangement for student projects worth asking about.

**Action: confirm each of these at faa.gov and record the answers in
`01_Requirements/regulatory.md` before phase 5.**

---

## 10. Open decisions — I need these from you

| # | Decision | Options | My recommendation |
|---|---|---|---|
| D1 | **Configuration.** Accept the quadplane for Block 1? | Quadplane / tilt-rotor / tilt-wing | **Quadplane**, with a tilt-rotor Block 2 designed into the boom interface from day one |
| D2 | **Budget ceiling.** Drives motor and autopilot class. | ~$250 lean / ~$400 comfortable / ~$600 no-compromise | Tell me the number; $400 is where the H743 autopilot becomes easy to justify |
| D3 | **Timeline.** When does this need to fly? | Semester / by winter break / by spring | Airbus and Thales summer applications close in autumn — a flying aircraft by **December** is the target that matters |
| D4 | **CAD tool.** | Fusion 360 / SolidWorks / Onshape | Whichever you already know. If it is a tie, **Fusion 360** — best 3D-print workflow and free for personal use |
| D5 | **Autopilot board.** | F405-WING class (~$45) / H743 class (~$110) | Resolve R3 first. If the F405 build is feature-complete for quadplane missions, start there |
| D6 | **Filament strategy.** | All PLA / LW-PLA skins + PLA-CF fittings / PETG structure | **LW-PLA skins + PLA-CF or PETG fittings.** Mass is the binding constraint (R1) |
| D7 | **Test site.** | — | Needed before phase 5. Identify it early; it constrains the schedule more than people expect |

---

## 11. Next step

On your answer to **D1**, the next work package is **Phase 1 preliminary design**:

1. Airfoil selection with a real low-Re comparison (XFOIL/XFLR5 polars at Re ≈ 240 000)
2. CG diagram, loaded and released, against the neutral point
3. Structural layout: spar sizing, segment joints, boom attachment
4. Priced bill of materials against D2

Delivered one step at a time, as usual.

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
| 0.1 | 2026-09-06 | Initial MVP definition. Requirements from kickoff interview. Sizing and trade study preliminary. |

## Appendix C — References

- ArduPilot, *QuadPlane Frame Setup* — https://ardupilot.org/plane/docs/quadplane-frame-setup.html
- ArduPilot, *Tilt Rotor Planes* (incl. tilt-wing support) — https://ardupilot.org/plane/docs/guide-tilt-rotor.html
- ArduPilot, *Tailsitter Planes* — https://ardupilot.org/plane/docs/guide-tailsitter.html
- Bambu Lab, *A1 Technical Specifications* — https://bambulab.com/en/a1/tech-specs
- Bambu Lab Wiki, *Print volume limitations* — https://wiki.bambulab.com/en/knowledge-sharing/print-volume-limitations
