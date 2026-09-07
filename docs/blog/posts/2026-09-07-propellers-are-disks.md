---
date: 2026-09-07
categories: [Propulsion]
---

# Propellers are disks, not blades

I thought a three-blade propeller was basically a stronger two-blade. More blades, more blade
area, more thrust — and proportionally more power to drive them.

Then I actually looked at the equation for how much power a rotor needs. There is no blade
count in it. Anywhere.

<!-- more -->

$$P_{\text{ideal}} = \frac{T^{1.5}}{\sqrt{2\rho A_{\text{disk}}}}$$

The only geometry that appears is $A_{\text{disk}}$ — the area the propeller sweeps. A
three-blade of the same diameter sweeps *exactly the same disk*, so its ideal power is
**identical**. Momentum theory treats a rotor as a disk that throws air downward, and it
genuinely does not care how many blades did the throwing.

The real differences are all small change:

| | 2-blade | 3-blade |
|---|---:|---:|
| Power at max thrust | 343 W | 365 W (+6 %) |
| RPM at max thrust | 9,900 | 8,370 (−15 %) |
| Hover efficiency | 6.1 g/W | 5.7 g/W (−6 %) |

The 6 % is profile drag — more blade area dragging through the air. And a third blade does
*not* give you 50 % more thrust; the blades interfere, so the thrust coefficient rises about
1.4×. Which is exactly why three-blades run slower, quieter and smoother.

## The shift in how I think about it

I had been picturing propellers as *blades*. The right picture is a **disk**, and the blades
are just the mechanism that happens to sweep it.

Once you see it that way the design rule is obvious: **maximise disk area first, worry about
everything else second.** Same principle explains the other result from the same study — a
10 inch propeller beats an 8 inch by 25 % on power for identical thrust.

Three blades only win when diameter is the binding constraint. Given a free choice, a slightly
bigger two-blade wins every time.
