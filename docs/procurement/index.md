# Procurement

<span class="chip todo">Not started</span>

!!! note "Deliberately empty"
    No component has been selected. Choosing hardware before the mass budget exists is how a
    design spirals — you pick a motor, discover the aircraft is heavier than the motor supports,
    and pick a bigger one, which makes it heavier again.

    Components get selected **after** preliminary sizing, and verified on a thrust stand before
    the CAD is committed.

## Bill of materials

| Qty | Item | Spec | Est. mass | Est. cost | Status |
|---:|---|---|---:|---:|---|
| 2 | Motor | <span class="tbd">not yet determined</span> | — | — | <span class="chip todo">Blocked on sizing</span> |
| 2 | ESC | <span class="tbd">not yet determined</span> | — | — | <span class="chip todo">Blocked on sizing</span> |
| 2 | Propeller | <span class="tbd">not yet determined</span> | — | — | <span class="chip todo">Blocked on sizing</span> |
| 1 | Battery | <span class="tbd">not yet determined</span> | — | — | <span class="chip todo">Blocked on sizing</span> |
| 1 | Flight controller | <span class="tbd">not yet determined</span> | — | — | <span class="chip todo">Blocked on control allocation</span> |
| 1 | GPS + compass | <span class="tbd">not yet determined</span> | — | — | <span class="chip todo">Not specified</span> |
| 1 | RC receiver | ELRS, to match the existing transmitter | — | — | <span class="chip todo">Not specified</span> |
| 1 | Telemetry radio | Ground-station link — required, see [Test](../test/index.md) | — | — | <span class="chip todo">Not specified</span> |
| 1 | Remote ID module | FAA broadcast module (DR-09) | — | — | <span class="chip todo">Not specified</span> |
| 1 | Wing tilt actuator | Must hold position unpowered (DR-02) | — | — | <span class="chip todo">Blocked on pivot design</span> |
| 2 | Nacelle tilt servo | Travel per DR-15 | — | — | <span class="chip todo">Blocked on sizing</span> |
| — | Flight servos | Count depends on control surface layout | — | — | <span class="chip todo">Blocked on aero design</span> |
| — | Spar and structural stock | <span class="tbd">not yet determined</span> | — | — | <span class="chip todo">Blocked on structure</span> |
| — | Filament | <span class="tbd">not yet determined</span> | — | — | <span class="chip todo">Blocked on structure</span> |

**Budget ceiling: <span class="tbd">not yet determined</span>** (D12).

## Already owned — not to be purchased

| Item | Note |
|---|---|
| ELRS transmitter | Reused |
| Walksnail goggles | No air unit in Block 1 — see [D3](../program/decision-log.md#d3-fpv-video) |
| Bambu Lab A1 | 256 mm build volume — CR-01 |

!!! warning "The 5-inch quad is not a parts donor"
    CR-03. Its ELRS receiver is soldered in, and a new one is inexpensive. Reusing it would mean
    disassembling an aircraft that is meant to stay flyable.

## Known sourcing risk

Larger motors and propellers have a thinner consumer-retail selection than 5-inch FPV parts, and
published thrust figures are frequently optimistic or simply wrong. **Verify on a thrust stand
before committing CAD.** Order spare propellers — they break.
