# Design


!!! info "How this page fills in"
    Each subsystem row below gets replaced with real geometry as it is designed. The order is set by what gates what: the wing pivot first, then mass and size, then aerodynamics, then everything else.

!!! warning "Configuration only"
    The configuration is chosen. **The aircraft is not designed.** No dimension, mass, structure
    or component on this page is settled, and none is stated as if it were.

## Configuration

A **tilt-wing bicopter**. One motor per side, mounted on a straight wing that rotates as a unit
from horizontal (cruise) to near-vertical (hover). Each nacelle also tilts independently through
a small angle, which is what provides yaw in hover.

```
        ◄──────────── straight wing, tilts as a unit ────────────►

   ╔════════════════════════════╤═╤════════════════════════════╗
   ║          wing              │ │          wing              ║
   ╚═══════════════╤════════════╧═╧════════════╤═══════════════╝
                   │                           │
              ┌────┴────┐                 ┌────┴────┐
        M1 ═══╡ nacelle ╞═                ═╡ nacelle ╞═══ M2
              │  tilts  │                 │  tilts  │      ← differential = YAW
              └─────────┘                 └─────────┘
                        ┌─────────────────┐
                        │    FUSELAGE     │
                        │  payload · FC   │
                        └────────┬────────┘
                            ┌────┴────┐
                            │  tail   │   fixed — does not tilt
                            └─────────┘
```

## What the configuration fixes

| Aspect | Decision | Why |
|---|---|---|
| Rotor count | Two | Chosen for cruise efficiency — no dead weight |
| Wing | Tilts as a unit, straight, unswept | [D1](../program/decision-log.md#d1-configuration), [D4](../program/decision-log.md#d4-wing-planform) |
| Yaw effector | Differential nacelle tilt | [D2](../program/decision-log.md#d2-yaw-effector) — a rigid tilt-wing has no yaw at all |
| Tail | Fixed, does not tilt with the wing | It must provide pitch and yaw in wing-borne flight |
| Onboard video | None in Block 1 | [D3](../program/decision-log.md#d3-fpv-video) |

## What still has to be designed

Everything else. In rough order of what gates what:

1. **[Wing pivot load path](wing-pivot.md)** — first, because if it cannot be built nothing else
   matters
2. Mass budget and overall size
3. Airfoil and control surface sizing
4. Wing structure: spar, segmentation for the 256 mm build volume, joints
5. Nacelle tilt mechanism and its travel
6. Fuselage layout, payload bay and release mechanism
7. Landing gear and ground stance
8. Component selection

## Constraints that apply to all of it

- Every structural part must print inside **256 × 256 × 256 mm**
- Components from a consumer retailer, or already owned
- Takeoff and landing footprint within 1.5 m
- The existing 5-inch quadcopter is not a parts donor
- Printed plastic is weakest between layers — structural load goes through a spar or a metal
  fastener, never through printed threads or a layer line in tension
