# Test

<span class="chip todo">Not started</span>

Nothing built, nothing flown. This section fills in from the component-selection stage onward.

## Why the test programme is unusual

A quadplane can be tested in two independent halves: prove hover with the cruise motor
unplugged, prove the wing with a hand launch and the lift rotors idle, then attempt transition
with both already trusted.

**A tilt-wing cannot be split that way.** The wing, the pivot, the actuator, the control
allocation and the transition schedule must all be right before the first landing. That is a
direct cost of the [configuration decision](../program/decision-log.md#d1-configuration), and
the test programme is structured to buy it back on the ground:

| Stage | Test | Purpose |
|---|---|---|
| Components | Thrust stand | Verify thrust and yaw couple by **measurement**, not from product listings |
| Build | Pivot cycle sweep; joint to destruction; drop test | Confirm the structure before it flies |
| Build | Simulation | Get the control allocation and tilt schedule wrong somewhere cheap |
| Flight | Tethered hover | Confirm all four axes, especially heading hold on descent |
| Flight | Free hover | Spot landings |
| Flight | Transition | At altitude, with abort armed |
| Flight | Mission | Waypoints, then payload drop |

Simulation and a tether are the substitute for what a quadplane gives for free.

## Standing rules

- Transition only at altitude, over open ground, with abort-to-hover on a dedicated switch
- Telemetry link live for every powered test; the ground station must be able to command abort
- Dataflash log retained from every flight, successful or not. The log is the primary diagnostic
  instrument on this aircraft
- **Log the failures.** A test programme with no recorded failures has not been run honestly
