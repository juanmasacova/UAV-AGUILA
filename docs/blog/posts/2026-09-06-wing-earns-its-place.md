---
date: 2026-09-06
categories: [Sizing]
---

# A wing has to earn its place

I assumed a fixed wing was just the better way to build a delivery aircraft. Wings make
lift efficiently, multirotors brute-force it, so adding a wing felt like a free upgrade.

It is not free. It is a loan.

<!-- more -->

The wing, the tilt pivot, the actuator and the tail are mass the aircraft carries on every
flight — 200 metres or 20 kilometres, the bill is the same. What it pays back is lower power
in cruise, and that only accumulates *while you are cruising*.

So there is a distance below which the wing loses.

<figure class="viz-fig" markdown="0">
<svg class="viz" viewBox="0 0 760 380" width="100%" role="img"
     aria-label="Takeoff mass against mission radius. The winged aircraft rises gently from 1.58 to 1.86 kilograms across 0 to 7 kilometres. The pure multirotor starts lighter at 1.23 kilograms but rises steeply and passes the winged aircraft at 2.6 kilometres, reaching 4 kilograms by 6.5 kilometres.">
  <g class="grid-group"><line class="grid" x1="58" y1="328.0" x2="628" y2="328.0"/><text class="tick" x="48" y="332.0" text-anchor="end">1</text><line class="grid" x1="58" y1="227.3" x2="628" y2="227.3"/><text class="tick" x="48" y="231.3" text-anchor="end">2</text><line class="grid" x1="58" y1="126.7" x2="628" y2="126.7"/><text class="tick" x="48" y="130.7" text-anchor="end">3</text><line class="grid" x1="58" y1="26.0" x2="628" y2="26.0"/><text class="tick" x="48" y="30.0" text-anchor="end">4</text><text class="tick" x="58.0" y="348" text-anchor="middle">0</text><text class="tick" x="139.4" y="348" text-anchor="middle">1</text><text class="tick" x="220.9" y="348" text-anchor="middle">2</text><text class="tick" x="302.3" y="348" text-anchor="middle">3</text><text class="tick" x="383.7" y="348" text-anchor="middle">4</text><text class="tick" x="465.1" y="348" text-anchor="middle">5</text><text class="tick" x="546.6" y="348" text-anchor="middle">6</text><text class="tick" x="628.0" y="348" text-anchor="middle">7</text></g>

  <line class="cross-rule" x1="271.5" y1="26" x2="271.5" y2="328"/>
  <text class="cross-label" x="279.5" y="39">break-even 2.6 km</text>

  <path class="s2" d="M 78.4 305.0 L 98.7 301.5 L 119.1 297.9 L 139.4 294.0 L 159.8 289.9 L 180.1 285.5 L 200.5 280.9 L 220.9 275.9 L 241.2 270.6 L 261.6 264.9 L 281.9 258.8 L 302.3 252.3 L 322.6 245.2 L 343.0 237.5 L 363.4 229.1 L 383.7 220.0 L 404.1 210.0 L 424.4 199.0 L 444.8 186.8 L 465.1 173.3 L 485.5 158.2 L 505.9 141.1 L 526.2 121.8 L 546.6 99.8 L 566.9 74.4 L 587.3 44.7" fill="none"/>
  <path class="s1" d="M 78.4 269.8 L 98.7 269.0 L 119.1 268.2 L 139.4 267.4 L 159.8 266.6 L 180.1 265.8 L 200.5 265.0 L 220.9 264.1 L 241.2 263.3 L 261.6 262.4 L 281.9 261.6 L 302.3 260.7 L 322.6 259.8 L 343.0 259.0 L 363.4 258.1 L 383.7 257.2 L 404.1 256.2 L 424.4 255.3 L 444.8 254.4 L 465.1 253.4 L 485.5 252.5 L 505.9 251.5 L 526.2 250.6 L 546.6 249.6 L 566.9 248.6 L 587.3 247.6 L 607.6 246.6 L 628.0 245.5" fill="none"/>

  <circle class="dot-ring" cx="271.5" cy="262.4" r="7"/>
  <circle class="dot" cx="271.5" cy="262.4" r="4.5"/>

  <text class="lab s1t" x="638" y="245.2">Tilt-wing</text>
  <text class="labsub" x="638" y="260.2">barely grows</text>

  <text class="lab s2t" x="638" y="130.7">Multirotor</text>
  <text class="labsub" x="638" y="145.7">runs away</text>

  <text class="axis" x="58" y="372">mission radius, one way [km]</text>
  <text class="axis" x="12" y="16">takeoff mass [kg]</text>
</svg>
<figcaption>Takeoff mass against mission radius, same payload, same mission profile.</figcaption>
</figure>

The multirotor curve is the interesting one. It has to hover the whole way, so its energy
grows with distance. More energy, bigger battery. But a bigger battery is more mass to hover,
which needs more energy again. That loop stays polite for a while and then stops being polite —
past about 8 km it does not converge at all. The aircraft simply cannot lift the battery it
would need.

That is not the model failing. That is why long-range quadcopters do not exist.

The winged aircraft has the same loop, but its cruise power is several times lower, so the
feedback is weak and the curve stays nearly flat.

## What I did about it

My original spec was a 500 m mission. At that range the analysis said the wing was costing me
about 0.3 kg for nothing — I'd have built a tilt-wing objectively worse than the quadcopter I
already know how to build.

So I changed **the mission, not the aircraft**. Design radius is now 4 km, past the crossover.
Early flight testing still happens close in, because that is easier and safer — but testing
close is a test plan, not a design case.

The lesson I'm taking: before adding something to a design, work out what the mission would
have to look like for that thing to pay for itself. Then check whether your actual mission
looks like that.
