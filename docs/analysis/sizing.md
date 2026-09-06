# Sizing

!!! warning "Not started"
    Nothing about the aircraft's size or mass has been determined. This page shows the design
    point as it currently stands — mostly blank — and the method that will fill it.

## Design point

--8<-- "includes/design-point.md"

## Mass budget

--8<-- "includes/mass-budget.md"

---

## The method

### 1. Set the requirement thresholds first

Hover thrust-to-weight and maximum wing loading get chosen **before** sizing, not after. If they
are set afterwards they stop being requirements and become justifications for whatever the design
happened to produce.

- **Thrust-to-weight** governs control authority and wind margin in hover
- **Wing loading** governs stall speed, and therefore how survivable a bad landing is

### 2. Bound the mass

Structure, propulsion, battery, avionics, payload. Only the payload is currently known: a filled
33 cl can. Everything else needs either a component selection or a structural estimate.

The honest way to do this is three columns — optimistic, expected, pessimistic — and to **size to
the pessimistic one**. Printed airframes finish heavier than estimated essentially always.

### 3. Size the wing

Wing area follows from mass and the chosen wing loading. Span and chord follow from area and a
chosen aspect ratio. Aspect ratio is a compromise: higher is aerodynamically better and
structurally worse, and on a tilt-wing the root bending moment passes through a rotating joint.

### 4. Check that hover closes

Required thrust per motor is mass × thrust-to-weight ÷ 2. With only two rotors that number is
large, and it is the step most likely to fail.

### 5. Expect to go round again

Two motors instead of four means each must lift roughly twice as much, which pushes into a
heavier motor class, which raises mass, which demands more thrust. **The loop does not converge
on the first pass.** Anticipate two or three iterations, and expect the battery to be the lever
that finally settles it — energy is the easiest mass to trade because it is the one most often
carried in excess.

---

## Constraints already fixed

These bound the sizing before it starts.

| Constraint | Consequence |
|---|---|
| Every structural part prints inside a 256 mm cube | The wing must be segmented over a continuous spar. Segment count follows from span |
| Two rotors only | Thrust per motor is high, pushing motor mass up |
| Payload is a filled 33 cl can | A fixed ~370 g that cannot be traded away |
| Takeoff footprint ≤ 1.5 m | Bounds rotor diameter and stance |
| Components from a consumer retailer | Narrows the motor and propeller field, especially at larger sizes |
