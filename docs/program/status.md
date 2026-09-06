# Stages

The home-page progress bar is generated from this list. To advance a stage, set `done: True` for
it in `analysis/aguila.py` and re-run `analysis/make_tables.py`.

--8<-- "includes/milestones.md"

## Current stage — preliminary sizing

Everything downstream waits on this. The order matters:

1. **Select the components that dominate mass** — motors, battery — or bound them
2. **Close the mass budget**, which sets MTOW
3. **Size the wing** from MTOW and a chosen wing loading
4. **Check that hover thrust closes** at the chosen thrust-to-weight

That loop does not converge on the first pass. Two motors instead of four means each lifts more,
which pushes into a heavier motor class, which raises mass, which demands more thrust. Expect to
go round it several times — and expect the battery to be the lever that settles it.

## Rules that already apply

- Set requirement thresholds (thrust-to-weight, wing loading) **before** sizing, not after, so
  the sizing is checked against something rather than justified by it
- Weigh every printed part as it comes off the bed and put the measured value into
  `analysis/aguila.py` — do not batch this
- Never publish a number that has not been calculated or measured
