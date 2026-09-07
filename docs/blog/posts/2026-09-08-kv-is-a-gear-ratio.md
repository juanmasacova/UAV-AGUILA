---
date: 2026-09-08
categories: [Propulsion, Method]
---

# Kv is a gear ratio, not an efficiency rating

I found a motor that cleared my thrust requirement with margin, weighed less than my budget
assumed, and used the batteries I already own. Then I nearly rejected it because its Kv was
900 and my spec said 560.

That instinct was wrong, and the reason is worth writing down.

<!-- more -->

## What I assumed

That a high-Kv motor spins fast and makes little torque, so pairing one with a big slow
propeller means fighting it — lots of current, lots of heat, poor efficiency. Low Kv for big
props, high Kv for small ones. That is the rule of thumb everyone repeats.

## What is actually true

Winding a motor for lower Kv means **more turns of thinner wire**. More turns means more
torque per amp, so you need less current. But thinner wire also means more resistance —
and resistance goes up as the *square* of the turns.

$$K_t = \frac{9.549}{K_v} \qquad I = \frac{T}{K_t} \propto K_v \qquad R \propto \frac{1}{K_v^2}$$

So copper loss is

$$P_{\text{cu}} = I^2 R \propto K_v^2 \times \frac{1}{K_v^2} = \text{constant}$$

The Kv cancels. Same motor, same torque, rewound for any Kv you like:

| Kv | Torque constant | Resistance | Current at hover | Copper loss |
|---:|---:|---:|---:|---:|
| 400 | 0.02387 N·m/A | 395 mΩ | 6.6 A | **17.0 W** |
| 500 | 0.01910 | 253 mΩ | 8.2 A | **17.0 W** |
| 700 | 0.01364 | 129 mΩ | 11.5 A | **17.0 W** |
| 900 | 0.01061 | 78 mΩ | 14.8 A | **17.0 W** |

Identical, every time.

## So what does set efficiency?

The **motor constant**:

$$K_m = \frac{K_t}{\sqrt{R}}$$

$K_m$ tells you how much torque you get per square root of watt lost, and it is a property of
how much **iron and copper is physically in the motor** — its size. Not its winding. Two
motors of the same size wound to different Kv have the same $K_m$.

If you want less loss for a given torque, the only answer is a bigger motor. Rewinding just
moves the same loss between volts and amps.

## What it changed

Kv stopped being an efficiency question for me and became a **matching** question: does this
motor reach the RPM I need, on the battery I have, without running out of throttle or hitting
its speed limit? That is all it decides. It is a gear ratio.

And I stopped comparing motors by Kv. The comparison that matters is $K_m$ against mass —
which, when I actually ran it, said the motor I nearly rejected was the right one anyway, just
not for the reasons I first gave.

The rule of thumb is not wrong exactly. Low-Kv motors *are* usually paired with big props. But
that is because of voltage matching, not efficiency — and I had cause and effect backwards.
