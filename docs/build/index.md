# Build

<span class="chip todo">Not started</span>

Nothing is designed yet, so nothing is built. This section fills in from the manufacture stage.

## What will be recorded here

- **Measured part masses** as each print comes off the bed. These go straight into `MASS_ITEMS`
  in `analysis/aguila.py`, replacing estimates, and the design re-converges.
- **Print settings** that worked and that did not — material, orientation, wall count, infill
- **Assembly notes**, especially anywhere the CAD was wrong
- **Failures**, with photographs

## Rules already fixed

- Every structural part prints inside **256 × 256 × 256 mm** (CR-01)
- Structural load goes through a spar or a metal fastener, never printed threads, never a layer
  line in tension (DR-06)
- Weigh every part as it comes off the bed and record it **immediately** — the value of a live
  mass budget is early warning, and batching it at the end destroys that

## Material strategy — not decided

Printed plastic choice depends on where load and heat concentrate, which depends on the
structural design. Considerations already known:

- Mass is likely to be the binding constraint, which favours a lightweight filament for skins
- The pivot and any highly loaded fitting need stiffness and heat resistance that a lightweight
  filament will not give
- Standard PLA softens around 55–60 °C, which a dark airframe on hot asphalt in Charlotte will
  reach
