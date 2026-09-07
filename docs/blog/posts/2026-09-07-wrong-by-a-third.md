---
date: 2026-09-07
categories: [Propulsion, Method]
---

# I was wrong by a third, and the answer got better

My sizing model needed a number for how efficiently a rotor turns electricity into thrust. I
used **0.65**.

0.65 is a fine number — for a *propeller*. It is a typical figure of merit: how close the blades
get to the theoretical ideal. What it leaves out is the **motor and the ESC**, which between
them lose about another 30 %.

So my model was quietly assuming the electrical chain was free.

<!-- more -->

## How it surfaced

Not by re-reading the assumption. By trying to use it for something else.

Predicting real motor power meant checking the model against a real motor. Anchoring on a
published test point — 9450 propeller, 2312-class motor, 4S, about 700 g of thrust for about
110 W:

$$T = 0.700 \times 9.81 = 6.867\ \text{N} \qquad
A = \pi\left(\tfrac{9.4 \times 0.0254}{2}\right)^{2} = 0.04477\ \text{m}^2$$

$$P_{\text{ideal}} = \frac{17.995}{0.3312} = 54.33\ \text{W}
\qquad \eta = \frac{54.33}{110} = \mathbf{0.494}$$

Which decomposes as roughly 0.70 for the propeller × 0.70 for the motor and ESC. The missing
factor was precisely the chain I'd left out. Every hover power figure I had was **32 %
optimistic**.

## The part I didn't see coming

Fixing it made the case for the wing *stronger*, and at a **shorter** range.

<figure class="viz-fig" markdown="0">
<svg class="viz" viewBox="0 0 760 360" width="100%" role="img" aria-label="Mass advantage of the winged aircraft over a pure multirotor, against mission radius. Both curves rise from negative to positive. With the old optimistic hover efficiency the curve crosses zero at 2.6 kilometres; with the corrected efficiency it crosses at 1.9 kilometres and rises far more steeply."><g><line class="grid" x1="64" y1="297.9" x2="636" y2="297.9"/><text class="tick" x="54" y="301.9" text-anchor="end">-0.5</text><line class="zero-rule" x1="64" y1="247.6" x2="636" y2="247.6"/><text class="tick" x="54" y="251.6" text-anchor="end">+0</text><line class="grid" x1="64" y1="197.2" x2="636" y2="197.2"/><text class="tick" x="54" y="201.2" text-anchor="end">+0.5</text><line class="grid" x1="64" y1="146.9" x2="636" y2="146.9"/><text class="tick" x="54" y="150.9" text-anchor="end">+1</text><line class="grid" x1="64" y1="96.5" x2="636" y2="96.5"/><text class="tick" x="54" y="100.5" text-anchor="end">+1.5</text><line class="grid" x1="64" y1="46.1" x2="636" y2="46.1"/><text class="tick" x="54" y="50.1" text-anchor="end">+2</text><text class="tick" x="64.0" y="328" text-anchor="middle">0</text><text class="tick" x="168.0" y="328" text-anchor="middle">1</text><text class="tick" x="272.0" y="328" text-anchor="middle">2</text><text class="tick" x="376.0" y="328" text-anchor="middle">3</text><text class="tick" x="480.0" y="328" text-anchor="middle">4</text><text class="tick" x="584.0" y="328" text-anchor="middle">5</text></g><line class="cross-rule" x1="336.7" y1="247.6" x2="336.7" y2="30.0"/><text class="cross-label" x="343.7" y="39">was 2.6 km</text><circle class="dot-ring" cx="336.7" cy="247.6" r="7"/><circle class="dot" cx="336.7" cy="247.6" r="4.5"/><line class="cross-rule" x1="260.1" y1="247.6" x2="260.1" y2="47.0"/><text class="cross-label" x="267.1" y="56">now 1.9 km</text><circle class="dot-ring" cx="260.1" cy="247.6" r="7"/><circle class="dot" cx="260.1" cy="247.6" r="4.5"/><path class="s2 dashed" d="M 90.0 282.8 L 103.0 281.5 L 116.0 280.1 L 129.0 278.7 L 142.0 277.3 L 155.0 275.7 L 168.0 274.2 L 181.0 272.6 L 194.0 270.9 L 207.0 269.1 L 220.0 267.3 L 233.0 265.4 L 246.0 263.5 L 259.0 261.5 L 272.0 259.4 L 285.0 257.2 L 298.0 254.9 L 311.0 252.5 L 324.0 250.1 L 337.0 247.5 L 350.0 244.8 L 363.0 242.0 L 376.0 239.1 L 389.0 236.1 L 402.0 232.9 L 415.0 229.6 L 428.0 226.1 L 441.0 222.4 L 454.0 218.6 L 467.0 214.6 L 480.0 210.4 L 493.0 205.9 L 506.0 201.3 L 519.0 196.4 L 532.0 191.2 L 545.0 185.7 L 558.0 180.0 L 571.0 173.8 L 584.0 167.4 L 597.0 160.5 L 610.0 153.2 L 623.0 145.4 L 636.0 137.1" fill="none"/><path class="s1" d="M 90.0 282.2 L 103.0 280.3 L 116.0 278.2 L 129.0 276.1 L 142.0 273.8 L 155.0 271.5 L 168.0 269.0 L 181.0 266.4 L 194.0 263.7 L 207.0 260.8 L 220.0 257.8 L 233.0 254.7 L 246.0 251.4 L 259.0 247.9 L 272.0 244.2 L 285.0 240.3 L 298.0 236.2 L 311.0 231.8 L 324.0 227.2 L 337.0 222.3 L 350.0 217.1 L 363.0 211.5 L 376.0 205.6 L 389.0 199.3 L 402.0 192.6 L 415.0 185.3 L 428.0 177.5 L 441.0 169.2 L 454.0 160.1 L 467.0 150.4 L 480.0 139.7 L 493.0 128.2 L 506.0 115.6 L 519.0 101.7 L 532.0 86.5 L 545.0 69.7 L 558.0 51.0 L 571.0 30.1" fill="none"/><text class="lab s1t" x="646" y="95.5">Corrected</text><text class="labsub" x="646" y="110.5">eta 0.494</text><text class="lab s2t" x="646" y="201.2">Original</text><text class="labsub" x="646" y="216.2">eta 0.65</text><text class="axis" x="64" y="352">mission radius, one way [km]</text><text class="axis" x="12" y="16">mass saved by having a wing [kg]</text></svg>
<figcaption>Mass saved by having a wing, at each mission radius. Above zero the wing is worth
carrying.</figcaption>
</figure>

The reason is structural. **The multirotor hovers the entire mission. The winged aircraft
hovers for about a minute and cruises the rest.** So making hovering 32 % more expensive raises
the multirotor's whole energy bill, but only the small hover slice of the wing's. Break-even
moved from 2.6 km to 1.9 km, and the mass the wing saves at 4 km went from 0.37 kg to 1.07 kg.

## Two things I'm keeping

**Be precise about what an efficiency covers.** "Figure of merit" and "watts at the battery" are
different quantities that both get written as a number between 0 and 1. Confusing them is
silent — nothing errors, the model just returns confident nonsense.

**A conclusion that survives a wrong assumption was never resting on it.** My sizing study had a
sensitivity table that scored hover efficiency at a 3 % swing. It was right: the assumption was
off by a third and the candidate ranking did not move at all.

I trust that table more than any single number above it. It also says the can mass is a 28 %
swing — which is still sitting on my desk, unweighed.
