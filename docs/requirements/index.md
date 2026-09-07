# Requirements register


!!! info "How this page fills in"
    Mission and constraint requirements are set. Derived thresholds fill in as each study closes — move a row from **Pending** to **Established** the moment a study gives it a number, and put that number in `analysis/aguila.py` at the same time.

Verification methods: **A**nalysis · **I**nspection · **D**emonstration · **T**est.

## Mission requirements

What the aircraft must do. These come from the mission and are settled.

| ID | Requirement | Verif. |
|---|---|---|
| MR-01 | Carry one full 33 cl aluminium beverage can | I |
| MR-02 | Release the payload in flight on command, and confirm release to the operator | D |
| MR-03 | Take off and land within a 1.5 m diameter footprint from unprepared grass | D |
| MR-04 | Fly an operator-uploaded GPS waypoint mission without stick input | D |
| MR-05 | Design mission radius ≥ 500 m with ≥ 50 % energy reserve on landing | A, T |
| MR-06 | Return to launch autonomously on link loss, low battery, or operator command | T |

## Constraint requirements

Bounds imposed from outside the design. Also settled.

| ID | Requirement | Verif. |
|---|---|---|
| CR-01 | Every structural part printable on a Bambu Lab A1: 256 × 256 × 256 mm | I |
| CR-02 | All components procurable from Amazon US, or already owned | I |
| CR-03 | The existing 5-inch FPV quad shall not be disassembled | I |
| CR-04 | No onboard video in Block 1; existing ELRS transmitter reused | I |
| CR-05 | Wing shall be straight (unswept), constant or near-constant chord | I |
| CR-06 | No part shall require a machine tool the workshop does not have | I |

## Derived requirements

Requirements that follow from analysis rather than from the mission. **A derived requirement with
no number attached is not yet a requirement** — it is a placeholder for one, and it is marked as
such.

### Established — the reasoning is complete

| ID | Requirement | Derived from | Verif. |
|---|---|---|---|
| DR-01 | The aircraft shall have a dedicated yaw effector in hover, independent of propeller torque | [Control authority](../analysis/control-authority.md) — a rigid two-motor tilt-wing has none | A, T |
| DR-02 | The wing tilt actuator shall hold its commanded angle with power removed | Loss of tilt authority in transition is unrecoverable | T |
| DR-03 | The wing shall carry geometric washout at the tip | [Transition envelope](../analysis/transition-envelope.md) — the unblown outer wing separates; washout makes it stall last | I |
| DR-04 | The airfoil shall exhibit a gentle, progressive stall | Large parts of the wing sit past stall during every transition | A |
| DR-05 | Payload release shall be mechanically fail-safe: no release on power loss | Safety | T |
| DR-06 | Structural load shall pass through a spar or metal fastener — never printed threads, never a layer line in tension | Printed plastic is anisotropic | I, T |
| DR-07 | Transition shall be commanded only at altitude, with abort-to-hover on a dedicated switch | Transition is the highest-risk phase | D |
| DR-08 | All wiring crossing the wing pivot shall have a cycle-rated service loop | The pivot is a moving electrical joint | T |
| DR-09 | The aircraft shall carry an FAA-compliant Remote ID broadcast module | [Regulatory](regulatory.md) | I |

### Pending — thresholds not yet set

These must be **chosen before sizing**, not derived from whatever the sizing produces. A
requirement written after the fact is not a requirement.

| ID | Requirement | Threshold | Set at |
|---|---|---|---|
| DR-10 | Minimum hover thrust-to-weight at MTOW | <span class="tbd">not yet determined</span> | Preliminary sizing |
| DR-11 | Maximum wing loading at MTOW | <span class="tbd">not yet determined</span> | Preliminary sizing |
| DR-12 | Minimum hover yaw angular acceleration | <span class="tbd">not yet determined</span> | Preliminary sizing |
| DR-13 | Maximum takeoff mass | <span class="tbd">not yet determined</span> | Preliminary sizing |
| DR-14 | Washout angle at the tip | <span class="tbd">not yet determined</span> | Aerodynamic design |
| DR-15 | Nacelle differential tilt travel | <span class="tbd">not yet determined</span> | Aerodynamic design |
| DR-16 | Maximum centre-of-gravity travel on payload release | <span class="tbd">not yet determined</span> | Structural design |
| DR-17 | Landing gear drop-test height and load | <span class="tbd">not yet determined</span> | Structural design |
