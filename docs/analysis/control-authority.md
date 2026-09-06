# Hover control authority

The constraint that decides whether this configuration flies at all. It is settled in principle
and open in magnitude.

## The problem

In hover the wing is vertical, both rotors thrust upward, and there is no airflow over the tail.
Every control moment must come from the two rotors. Define hover axes as $x$ = nose, $y$ = span,
$z$ = up.

| Axis | Effector | Wing tilt only | + differential nacelle tilt |
|---|---|:---:|:---:|
| Thrust ($z$) | Collective throttle | ✓ | ✓ |
| Roll ($x$) | Differential throttle | ✓ | ✓ |
| Pitch ($y$) | Collective tilt — **this is the wing tilt** | ✓ | ✓ |
| **Yaw ($z$)** | **Differential tilt** | **✗ missing** | ✓ |

Three of four axes come free. Collective wing tilt *is* the pitch effector. **Yaw is not
covered.** With both motors rigidly fixed to a single tilting wing, the only remaining yaw
effector is differential propeller torque, which is weak and directly opposes the differential
throttle needed for roll.

!!! danger "A missing control axis, not a tuning problem"
    A rigid two-motor tilt-wing cannot hold heading in hover. No amount of gain tuning fixes it.
    This is why the aircraft carries independently tilting nacelles.

**This argument depends on no dimensions.** It is true for any aircraft of this shape.

## Why not use the flaperons

Deflecting the flaperons differentially in the propeller slipstream costs nothing — the servos
are needed for wing-borne flight anyway. It was rejected because the authority scales with
slipstream dynamic pressure:

$$q_{\text{wash}} = \tfrac{1}{2}\rho w^2, \qquad w = \sqrt{\frac{T}{2\rho A}}$$

so it **collapses as throttle reduces** — precisely the descent-and-land condition where heading
hold matters most. A control effector that is weakest when it is most needed is not a control
effector. Flaperons are retained as augmentation.

## Magnitude — not yet determined

--8<-- "includes/control-authority.md"

The yaw couple from differential nacelle tilt is

$$M_z = 2 \, T_{\text{motor}} \sin(\delta) \, y_{\text{motor}}$$

which needs the aircraft mass, the motor spanwise station and the differential travel. None of
those is set.

## What has to be verified

Even once these are calculated, two of the inputs are weak:

- $I_{zz}$ will be a slender-body estimate until the aircraft exists. Measure it by bifilar
  pendulum after assembly.
- Motor thrust response is not instantaneous, and the tilt servos have finite rate. Static couple
  is an upper bound on what the controller can actually use.

**Both get measured on the thrust stand before any CAD is committed.**
