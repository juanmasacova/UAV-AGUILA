# Procurement

<span class="chip todo">Not started</span>


!!! info "How this page fills in"
    Each row fills in when that component is chosen and again when it arrives. Nothing is ordered before the mass budget closes.

!!! note "Deliberately empty"
    No component has been selected. Choosing hardware before the mass budget exists is how a
    design spirals — you pick a motor, discover the aircraft is heavier than the motor supports,
    and pick a bigger one, which makes it heavier again.

    Components get selected **after** preliminary sizing, and verified on a thrust stand before
    the CAD is committed.

## Bill of materials

| Qty | Item | Spec | Est. mass | Est. cost | Status |
|---:|---|---|---:|---:|---|
| 2 | Motor | **iFlight Helion 10 3110, 900 Kv** | 154 g | — | <span class="chip done">Selected</span> |
| 2 | ESC | 30–40 A continuous, 6S | — | — | <span class="chip active">Spec set</span> |
| 2 | Propeller | 10 in, 2-blade, 5 mm bore, pitch 10×5 to 10×6 | — | — | <span class="chip active">Spec set</span> |
| 1 | Battery | **6S LiPo**, capacity TBD | — | — | <span class="chip active">Chemistry set</span> |
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

## Selected components

### Motor — iFlight Helion 10 3110, 900 Kv <span class="chip done">Closed, D6</span>

| Specification | Value |
|---|---|
| Stator | 3110 (12N14P) |
| Kv | 900 |
| Mass | 77 g each, with wire |
| Shaft | 5 mm, 15 mm protrusion |
| Mounting | 19 × 19 mm, ⌀3 mm |
| Peak current | 65.5 A |
| Max power | 2144 W |
| Max input voltage | 33.6 V (8S) |
| Interphase resistance | 78 mΩ |
| Bearings | NSK ⌀11 × ⌀5 × 5 mm |

Predicted operating points on a 10 inch propeller at 6S — **project model, not manufacturer
data**:

| Point | Thrust per motor | RPM | Electrical power | Current |
|---|---:|---:|---:|---:|
| Cruise | 92 g at 17.1 m/s | ~6,200 | ~29 W | 1.3 A |
| Hover | 865 g | ~7,400 | ~151 W | 6.8 A |
| Max, T/W 1.8 | 1,557 g | ~9,900 | ~364 W | 16.4 A |
| Continuous ceiling | ~2,330 g | ~12,100 | ~666 W | 30 A |

See [D6](../program/decision-log.md#d6-motor) for the approval reasoning and the two
verification conditions attached to it.

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
