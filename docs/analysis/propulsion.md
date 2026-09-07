# Propulsion

<span class="chip active">Study 02 complete</span> · Propeller diameter, blade count and pitch.
Motor selection still open.

Full study and code: `analysis/matlab/AguilaPropStudy02JMSCV.m`.

## The operating points

Everything below follows from three numbers. A propeller on this aircraft has to do
three quite different jobs.

| Operating point | Thrust per propeller | Airspeed |
|---|---:|---:|
| Hover | 865 g | 0 m/s |
| Maximum (thrust-to-weight 1.8) | 1557 g | 0 m/s |
| Cruise | 92 g | 17.1 m/s |

**Cruise thrust is only 11 % of hover thrust.** One fixed-pitch propeller is being asked to
cover a **9:1 thrust range** from a standstill up to 17 m/s. That single fact drives every
result on this page.

## Diameter: 8 inch against 10 inch

<figure class="viz-fig" markdown="0">
<svg class="viz" viewBox="0 0 760 340" width="100%" role="img" aria-label="thrust per propeller [g] against electrical power [W]"><g><line class="grid" x1="62" y1="290.0" x2="642" y2="290.0"/><text class="tick" x="52" y="294.0" text-anchor="end">0</text><line class="grid" x1="62" y1="236.8" x2="642" y2="236.8"/><text class="tick" x="52" y="240.8" text-anchor="end">100</text><line class="grid" x1="62" y1="183.6" x2="642" y2="183.6"/><text class="tick" x="52" y="187.6" text-anchor="end">200</text><line class="grid" x1="62" y1="130.4" x2="642" y2="130.4"/><text class="tick" x="52" y="134.4" text-anchor="end">300</text><line class="grid" x1="62" y1="77.2" x2="642" y2="77.2"/><text class="tick" x="52" y="81.2" text-anchor="end">400</text><line class="grid" x1="62" y1="24.0" x2="642" y2="24.0"/><text class="tick" x="52" y="28.0" text-anchor="end">500</text><text class="tick" x="62.0" y="310" text-anchor="middle">0</text><text class="tick" x="142.6" y="310" text-anchor="middle">250</text><text class="tick" x="223.1" y="310" text-anchor="middle">500</text><text class="tick" x="303.7" y="310" text-anchor="middle">750</text><text class="tick" x="384.2" y="310" text-anchor="middle">1000</text><text class="tick" x="464.8" y="310" text-anchor="middle">1250</text><text class="tick" x="545.3" y="310" text-anchor="middle">1500</text><text class="tick" x="625.9" y="310" text-anchor="middle">1750</text></g><line class="cross-rule" x1="340.7" y1="24" x2="340.7" y2="290"/><text class="cross-label" x="347.7" y="37">hover</text><line class="cross-rule" x1="563.7" y1="24" x2="563.7" y2="290"/><text class="cross-label" x="570.7" y="37">max</text><path class="s2" d="M 95.4 286.0 L 99.2 285.3 L 103.0 284.6 L 106.8 283.9 L 110.5 283.1 L 114.3 282.2 L 118.1 281.4 L 121.9 280.5 L 125.6 279.6 L 129.4 278.7 L 133.2 277.7 L 137.0 276.7 L 140.7 275.7 L 144.5 274.6 L 148.3 273.6 L 152.1 272.5 L 155.8 271.4 L 159.6 270.2 L 163.4 269.1 L 167.2 267.9 L 170.9 266.7 L 174.7 265.5 L 178.5 264.2 L 182.3 263.0 L 186.0 261.7 L 189.8 260.4 L 193.6 259.1 L 197.4 257.7 L 201.1 256.3 L 204.9 255.0 L 208.7 253.6 L 212.5 252.2 L 216.2 250.7 L 220.0 249.3 L 223.8 247.8 L 227.6 246.3 L 231.3 244.8 L 235.1 243.3 L 238.9 241.8 L 242.7 240.2 L 246.4 238.6 L 250.2 237.1 L 254.0 235.5 L 257.8 233.8 L 261.5 232.2 L 265.3 230.6 L 269.1 228.9 L 272.9 227.2 L 276.6 225.5 L 280.4 223.8 L 284.2 222.1 L 288.0 220.4 L 291.7 218.6 L 295.5 216.8 L 299.3 215.1 L 303.1 213.3 L 306.8 211.5 L 310.6 209.6 L 314.4 207.8 L 318.2 205.9 L 321.9 204.1 L 325.7 202.2 L 329.5 200.3 L 333.3 198.4 L 337.0 196.5 L 340.8 194.6 L 344.6 192.6 L 348.4 190.6 L 352.1 188.7 L 355.9 186.7 L 359.7 184.7 L 363.5 182.7 L 367.2 180.7 L 371.0 178.6 L 374.8 176.6 L 378.5 174.5 L 382.3 172.5 L 386.1 170.4 L 389.9 168.3 L 393.6 166.2 L 397.4 164.0 L 401.2 161.9 L 405.0 159.8 L 408.7 157.6 L 412.5 155.4 L 416.3 153.3 L 420.1 151.1 L 423.8 148.9 L 427.6 146.7 L 431.4 144.4 L 435.2 142.2 L 438.9 139.9 L 442.7 137.7 L 446.5 135.4 L 450.3 133.1 L 454.0 130.8 L 457.8 128.5 L 461.6 126.2 L 465.4 123.9 L 469.1 121.6 L 472.9 119.2 L 476.7 116.9 L 480.5 114.5 L 484.2 112.1 L 488.0 109.7 L 491.8 107.3 L 495.6 104.9 L 499.3 102.5 L 503.1 100.0 L 506.9 97.6 L 510.7 95.1 L 514.4 92.7 L 518.2 90.2 L 522.0 87.7 L 525.8 85.2 L 529.5 82.7 L 533.3 80.2 L 537.1 77.7 L 540.9 75.2 L 544.6 72.6 L 548.4 70.0 L 552.2 67.5 L 556.0 64.9 L 559.7 62.3 L 563.5 59.7 L 567.3 57.1 L 571.1 54.5 L 574.8 51.9 L 578.6 49.3 L 582.4 46.6 L 586.2 44.0 L 589.9 41.3 L 593.7 38.6 L 597.5 35.9 L 601.3 33.2 L 605.0 30.5 L 608.8 27.8 L 612.6 25.1 L 616.4 22.4 L 620.1 19.7 L 623.9 16.9" fill="none"/><path class="s1" d="M 95.4 286.8 L 99.2 286.3 L 103.0 285.7 L 106.8 285.1 L 110.5 284.5 L 114.3 283.8 L 118.1 283.1 L 121.9 282.4 L 125.6 281.7 L 129.4 280.9 L 133.2 280.1 L 137.0 279.4 L 140.7 278.5 L 144.5 277.7 L 148.3 276.9 L 152.1 276.0 L 155.8 275.1 L 159.6 274.2 L 163.4 273.3 L 167.2 272.3 L 170.9 271.3 L 174.7 270.4 L 178.5 269.4 L 182.3 268.4 L 186.0 267.3 L 189.8 266.3 L 193.6 265.2 L 197.4 264.2 L 201.1 263.1 L 204.9 262.0 L 208.7 260.9 L 212.5 259.7 L 216.2 258.6 L 220.0 257.4 L 223.8 256.2 L 227.6 255.1 L 231.3 253.9 L 235.1 252.6 L 238.9 251.4 L 242.7 250.2 L 246.4 248.9 L 250.2 247.6 L 254.0 246.4 L 257.8 245.1 L 261.5 243.8 L 265.3 242.5 L 269.1 241.1 L 272.9 239.8 L 276.6 238.4 L 280.4 237.1 L 284.2 235.7 L 288.0 234.3 L 291.7 232.9 L 295.5 231.5 L 299.3 230.0 L 303.1 228.6 L 306.8 227.2 L 310.6 225.7 L 314.4 224.2 L 318.2 222.8 L 321.9 221.3 L 325.7 219.8 L 329.5 218.2 L 333.3 216.7 L 337.0 215.2 L 340.8 213.6 L 344.6 212.1 L 348.4 210.5 L 352.1 208.9 L 355.9 207.4 L 359.7 205.8 L 363.5 204.2 L 367.2 202.5 L 371.0 200.9 L 374.8 199.3 L 378.5 197.6 L 382.3 196.0 L 386.1 194.3 L 389.9 192.6 L 393.6 190.9 L 397.4 189.2 L 401.2 187.5 L 405.0 185.8 L 408.7 184.1 L 412.5 182.4 L 416.3 180.6 L 420.1 178.9 L 423.8 177.1 L 427.6 175.3 L 431.4 173.5 L 435.2 171.8 L 438.9 170.0 L 442.7 168.2 L 446.5 166.3 L 450.3 164.5 L 454.0 162.7 L 457.8 160.8 L 461.6 159.0 L 465.4 157.1 L 469.1 155.2 L 472.9 153.4 L 476.7 151.5 L 480.5 149.6 L 484.2 147.7 L 488.0 145.8 L 491.8 143.9 L 495.6 141.9 L 499.3 140.0 L 503.1 138.0 L 506.9 136.1 L 510.7 134.1 L 514.4 132.1 L 518.2 130.2 L 522.0 128.2 L 525.8 126.2 L 529.5 124.2 L 533.3 122.2 L 537.1 120.1 L 540.9 118.1 L 544.6 116.1 L 548.4 114.0 L 552.2 112.0 L 556.0 109.9 L 559.7 107.9 L 563.5 105.8 L 567.3 103.7 L 571.1 101.6 L 574.8 99.5 L 578.6 97.4 L 582.4 95.3 L 586.2 93.2 L 589.9 91.0 L 593.7 88.9 L 597.5 86.8 L 601.3 84.6 L 605.0 82.4 L 608.8 80.3 L 612.6 78.1 L 616.4 75.9 L 620.1 73.7 L 623.9 71.5" fill="none"/><text class="lab s2t" x="652" y="79.7">8 inch</text><text class="labsub" x="652" y="94.7">+25% power</text><text class="lab s1t" x="652" y="128.1">10 inch</text><text class="labsub" x="652" y="143.1">the baseline</text><text class="axis" x="62" y="332">thrust per propeller [g]</text><text class="axis" x="12" y="16">electrical power [W]</text></svg>
<figcaption>Electrical power required for a given thrust, per propeller. Both curves bend
upward because power scales with thrust to the power of 1.5 — asking for twice the thrust
costs 2.8 times the power.</figcaption>
</figure>

| Propeller | Hover power | Power at max thrust | Hover efficiency | RPM at max |
|---|---:|---:|---:|---:|
| 8 in | 178 W | 433 W | 4.8 g/W | 15,500 |
| 9 in | 158 W | 381 W | 5.5 g/W | 12,200 |
| **10 in** | **142 W** | **346 W** | **6.0 g/W** | **9,900** |
| 11 in | 129 W | 312 W | 6.7 g/W | 8,200 |

**An 8 inch propeller costs 25 % more power than a 10 inch for exactly the same thrust.**
That holds in hover and at full power alike, and no amount of motor selection tunes it away —
it is geometry.

The reason sits in the momentum-theory equation:

$$P_{\text{ideal}} = \frac{T^{1.5}}{\sqrt{2\rho A_{\text{disk}}}}$$

Power falls with the **square root of disk area**. A 10 inch disk is 56 % larger than an 8 inch
one, so it produces the same thrust by moving more air more gently.

The RPM column matters too. To reach 1557 g, an 8 inch propeller has to turn about
**15,500 RPM** — racing-drone territory, and near the top of what an 8 inch propeller will do
at all. A 10 inch reaches the same thrust at 9,900 RPM.

<figure class="viz-fig" markdown="0">
<svg class="viz" viewBox="0 0 760 340" width="100%" role="img" aria-label="thrust per propeller [g] against hover efficiency [g/W]"><g><line class="grid" x1="62" y1="290.0" x2="642" y2="290.0"/><text class="tick" x="52" y="294.0" text-anchor="end">3</text><line class="grid" x1="62" y1="223.5" x2="642" y2="223.5"/><text class="tick" x="52" y="227.5" text-anchor="end">5</text><line class="grid" x1="62" y1="157.0" x2="642" y2="157.0"/><text class="tick" x="52" y="161.0" text-anchor="end">7</text><line class="grid" x1="62" y1="90.5" x2="642" y2="90.5"/><text class="tick" x="52" y="94.5" text-anchor="end">9</text><line class="grid" x1="62" y1="24.0" x2="642" y2="24.0"/><text class="tick" x="52" y="28.0" text-anchor="end">11</text><text class="tick" x="62.0" y="310" text-anchor="middle">0</text><text class="tick" x="142.6" y="310" text-anchor="middle">250</text><text class="tick" x="223.1" y="310" text-anchor="middle">500</text><text class="tick" x="303.7" y="310" text-anchor="middle">750</text><text class="tick" x="384.2" y="310" text-anchor="middle">1000</text><text class="tick" x="464.8" y="310" text-anchor="middle">1250</text><text class="tick" x="545.3" y="310" text-anchor="middle">1500</text><text class="tick" x="625.9" y="310" text-anchor="middle">1750</text></g><line class="cross-rule" x1="340.7" y1="24" x2="340.7" y2="290"/><text class="cross-label" x="347.7" y="37">hover</text><line class="cross-rule" x1="563.7" y1="24" x2="563.7" y2="290"/><text class="cross-label" x="570.7" y="37">max</text><path class="s2" d="M 95.4 -73.2 L 99.2 -49.1 L 103.0 -28.4 L 106.8 -10.4 L 110.5 5.5 L 114.3 19.6 L 118.1 32.3 L 121.9 43.7 L 125.6 54.1 L 129.4 63.7 L 133.2 72.4 L 137.0 80.5 L 140.7 88.0 L 144.5 95.0 L 148.3 101.5 L 152.1 107.6 L 155.8 113.4 L 159.6 118.8 L 163.4 123.8 L 167.2 128.7 L 170.9 133.2 L 174.7 137.6 L 178.5 141.7 L 182.3 145.6 L 186.0 149.3 L 189.8 152.9 L 193.6 156.3 L 197.4 159.6 L 201.1 162.8 L 204.9 165.8 L 208.7 168.7 L 212.5 171.5 L 216.2 174.2 L 220.0 176.7 L 223.8 179.2 L 227.6 181.7 L 231.3 184.0 L 235.1 186.2 L 238.9 188.4 L 242.7 190.5 L 246.4 192.6 L 250.2 194.6 L 254.0 196.5 L 257.8 198.4 L 261.5 200.2 L 265.3 202.0 L 269.1 203.7 L 272.9 205.4 L 276.6 207.0 L 280.4 208.6 L 284.2 210.1 L 288.0 211.6 L 291.7 213.1 L 295.5 214.5 L 299.3 215.9 L 303.1 217.3 L 306.8 218.6 L 310.6 219.9 L 314.4 221.2 L 318.2 222.5 L 321.9 223.7 L 325.7 224.9 L 329.5 226.0 L 333.3 227.2 L 337.0 228.3 L 340.8 229.4 L 344.6 230.5 L 348.4 231.5 L 352.1 232.6 L 355.9 233.6 L 359.7 234.6 L 363.5 235.5 L 367.2 236.5 L 371.0 237.4 L 374.8 238.4 L 378.5 239.3 L 382.3 240.1 L 386.1 241.0 L 389.9 241.9 L 393.6 242.7 L 397.4 243.6 L 401.2 244.4 L 405.0 245.2 L 408.7 246.0 L 412.5 246.7 L 416.3 247.5 L 420.1 248.3 L 423.8 249.0 L 427.6 249.7 L 431.4 250.4 L 435.2 251.1 L 438.9 251.8 L 442.7 252.5 L 446.5 253.2 L 450.3 253.9 L 454.0 254.5 L 457.8 255.2 L 461.6 255.8 L 465.4 256.4 L 469.1 257.1 L 472.9 257.7 L 476.7 258.3 L 480.5 258.9 L 484.2 259.4 L 488.0 260.0 L 491.8 260.6 L 495.6 261.2 L 499.3 261.7 L 503.1 262.3 L 506.9 262.8 L 510.7 263.3 L 514.4 263.9 L 518.2 264.4 L 522.0 264.9 L 525.8 265.4 L 529.5 265.9 L 533.3 266.4 L 537.1 266.9 L 540.9 267.4 L 544.6 267.9 L 548.4 268.3 L 552.2 268.8 L 556.0 269.3 L 559.7 269.7 L 563.5 270.2 L 567.3 270.6 L 571.1 271.1 L 574.8 271.5 L 578.6 271.9 L 582.4 272.4 L 586.2 272.8 L 589.9 273.2 L 593.7 273.6 L 597.5 274.0 L 601.3 274.5 L 605.0 274.9 L 608.8 275.2 L 612.6 275.6 L 616.4 276.0 L 620.1 276.4 L 623.9 276.8" fill="none"/><path class="s1" d="M 95.4 -189.0 L 99.2 -158.8 L 103.0 -133.0 L 106.8 -110.4 L 110.5 -90.6 L 114.3 -73.0 L 118.1 -57.1 L 121.9 -42.8 L 125.6 -29.8 L 129.4 -17.9 L 133.2 -6.9 L 137.0 3.2 L 140.7 12.6 L 144.5 21.3 L 148.3 29.5 L 152.1 37.1 L 155.8 44.3 L 159.6 51.0 L 163.4 57.4 L 167.2 63.4 L 170.9 69.1 L 174.7 74.5 L 178.5 79.7 L 182.3 84.6 L 186.0 89.2 L 189.8 93.7 L 193.6 98.0 L 197.4 102.1 L 201.1 106.0 L 204.9 109.8 L 208.7 113.4 L 212.5 116.9 L 216.2 120.3 L 220.0 123.5 L 223.8 126.6 L 227.6 129.6 L 231.3 132.6 L 235.1 135.4 L 238.9 138.1 L 242.7 140.7 L 246.4 143.3 L 250.2 145.8 L 254.0 148.2 L 257.8 150.5 L 261.5 152.8 L 265.3 155.0 L 269.1 157.2 L 272.9 159.3 L 276.6 161.3 L 280.4 163.3 L 284.2 165.2 L 288.0 167.1 L 291.7 168.9 L 295.5 170.7 L 299.3 172.5 L 303.1 174.2 L 306.8 175.9 L 310.6 177.5 L 314.4 179.1 L 318.2 180.6 L 321.9 182.2 L 325.7 183.6 L 329.5 185.1 L 333.3 186.5 L 337.0 187.9 L 340.8 189.3 L 344.6 190.7 L 348.4 192.0 L 352.1 193.3 L 355.9 194.5 L 359.7 195.8 L 363.5 197.0 L 367.2 198.2 L 371.0 199.4 L 374.8 200.5 L 378.5 201.6 L 382.3 202.7 L 386.1 203.8 L 389.9 204.9 L 393.6 206.0 L 397.4 207.0 L 401.2 208.0 L 405.0 209.0 L 408.7 210.0 L 412.5 211.0 L 416.3 211.9 L 420.1 212.9 L 423.8 213.8 L 427.6 214.7 L 431.4 215.6 L 435.2 216.5 L 438.9 217.4 L 442.7 218.2 L 446.5 219.1 L 450.3 219.9 L 454.0 220.7 L 457.8 221.5 L 461.6 222.3 L 465.4 223.1 L 469.1 223.9 L 472.9 224.6 L 476.7 225.4 L 480.5 226.1 L 484.2 226.9 L 488.0 227.6 L 491.8 228.3 L 495.6 229.0 L 499.3 229.7 L 503.1 230.4 L 506.9 231.1 L 510.7 231.7 L 514.4 232.4 L 518.2 233.1 L 522.0 233.7 L 525.8 234.3 L 529.5 235.0 L 533.3 235.6 L 537.1 236.2 L 540.9 236.8 L 544.6 237.4 L 548.4 238.0 L 552.2 238.6 L 556.0 239.2 L 559.7 239.7 L 563.5 240.3 L 567.3 240.9 L 571.1 241.4 L 574.8 242.0 L 578.6 242.5 L 582.4 243.0 L 586.2 243.6 L 589.9 244.1 L 593.7 244.6 L 597.5 245.1 L 601.3 245.6 L 605.0 246.1 L 608.8 246.6 L 612.6 247.1 L 616.4 247.6 L 620.1 248.1 L 623.9 248.6" fill="none"/><text class="lab s2t" x="652" y="233.4">8 inch</text><text class="labsub" x="652" y="248.4">4.9 g/W</text><text class="lab s1t" x="652" y="193.3">10 inch</text><text class="labsub" x="652" y="208.3">6.1 g/W</text><text class="axis" x="62" y="332">thrust per propeller [g]</text><text class="axis" x="12" y="16">hover efficiency [g/W]</text></svg>
<figcaption>The same physics expressed the way people shop for motors. Efficiency falls as
thrust rises, which is why an over-loaded propeller is doubly punished: it is working harder
<em>and</em> less efficiently.</figcaption>
</figure>

### Motor rating this implies

| | 8 in | 10 in |
|---|---:|---:|
| Power per motor at full thrust | 433 W | 346 W |
| Specify at least | 450 W | 350 W |
| Burst current, 6S | 19 A | 15 A |
| Hover current, 6S | 8 A | 6 A |
| Approximate Kv, 6S | 860 | 550 |
| Approximate Kv, 4S | 1300 | 830 |

**Decision: 10 inch, two blades.** Recorded in the [decision log](../program/decision-log.md).

**Decision rationale:** The only argument for 8 inch would be a geometric constraint, and the
fuselage is not designed yet, so no such constraint exists to justify a 25 % power penalty.

## Blade count

| | 2-blade | 3-blade | Change |
|---|---:|---:|---:|
| Power at max thrust | 343 W | 365 W | +6 % |
| RPM at max thrust | 9,900 | 8,370 | −15 % |
| Tip speed | 132 m/s | 111 m/s | −15 % |
| Hover efficiency | 6.0 g/W | 5.7 g/W | −6 % |

The interesting part is what momentum theory says here: **nothing**. The equation contains disk
area and no blade count at all. A three-blade propeller of the same diameter sweeps exactly the
same disk, so its *ideal* power is identical.

The entire difference is second-order — more blades means more blade area dragging through the
air, so a slightly lower figure of merit. About 6 %.

A third blade does not give 50 % more thrust either. The blades interfere with each other, so
the thrust coefficient rises by roughly 1.4×. The propeller reaches the same thrust about 15 %
slower, which is exactly why three-blade propellers are quieter and smoother.

**Choose three blades when diameter is the binding constraint** — when geometry will not allow
a larger two-blade. Then the extra blade buys thrust that is otherwise unavailable, and the 6 %
is worth paying. Also choose three if vibration becomes a problem, since lower RPM and better
balance matter on an airframe carrying an autopilot and a tilting wing.

**Otherwise choose two.** Given a free choice of diameter, a slightly larger two-blade beats a
three-blade every time.

## Pitch

Pitch is how far the propeller would screw itself forward in one turn if the air were solid.
Air slips, so usable airspeed is roughly 85 % of pitch speed — but pitch still sets a hard
ceiling on how fast the propeller can push.

| Propeller | Pitch / diameter | Max airspeed | Reaches 17.1 m/s cruise? | Hover efficiency |
|---|---:|---:|---|---:|
| 10 × 3.5 | 0.35 | 12.5 m/s | **No** | 6.0 g/W |
| 10 × 4.5 | 0.45 | 16.0 m/s | **No** | 6.0 g/W |
| **10 × 5** | **0.50** | **17.8 m/s** | **Yes** | **6.0 g/W** |
| **10 × 6** | **0.60** | **21.4 m/s** | **Yes** | **5.9 g/W** |
| 10 × 7 | 0.70 | 24.9 m/s | Yes | 5.7 g/W |
| 10 × 8 | 0.80 | 28.5 m/s | Yes | 5.6 g/W |

Below 10 × 5 the propeller **physically cannot reach cruise speed** — the blades run out of bite
and start windmilling. That is not an efficiency argument; the aircraft cannot fly the mission.

Above 10 × 6, a coarse blade sits at a steep angle when the aircraft is standing still, close to
stalled, and hovers worse — buying top speed that has no use.

**The window is 10 × 5 to 10 × 6, and it is narrow.**

## Why this is the hard part of a two-motor tilt-wing

A quadplane sidesteps all of this. It carries separate lift propellers and a separate cruise
propeller, each optimised for one job — low pitch for the lift rotors, high pitch for the pusher.

This aircraft has two propellers that do both jobs. That is the price of the configuration, and
it is why the pitch window above is so tight. It is also why variable-pitch and folding
propellers exist, though both are far too complex for a first build.

## The model, checked against measured data

The efficiency model here was calibrated on a single anchor point — a 9450 propeller on a
2312-class motor. One anchor is thin, so it was checked against T-Motor's published test data
for an MN3110 turning a **10-inch propeller**, a different manufacturer and a different motor:

| Measured thrust | Measured power | Model prediction | Error |
|---:|---:|---:|---:|
| 530 g | 71.0 W | 68 W | −4 % |
| 660 g | 100.6 W | 95 W | −6 % |
| 850 g | 136.2 W | 138 W | **+2 %** |
| 980 g | 162.8 W | 171 W | +5 % |

Agreement to within a few percent across the range that matters. The measured efficiency at
850 g is **6.24 g/W** against a predicted 6.1 g/W.

That same data also confirms the diameter finding empirically. From T-Motor's own tables, the
same motor at similar thrust: **6.0–6.6 g/W on a 10-inch propeller, 8.7–14.1 g/W on a
15-inch**. Bigger disk, less power — measured, not modelled.

## A correction to Study 01

Building this model required calibrating hover efficiency against published motor test data.
Study 01 had assumed a combined figure of 0.65; the calibrated value is **0.494** — Study 01 was
optimistic by 32 %. The full derivation, and the reason the correction made the wing *more*
worth carrying, is written up as [Things learned 03](../blog/index.md).

The correction was applied and every conclusion re-checked:

| | Study 01 | Corrected |
|---|---:|---:|
| Takeoff mass | 1.70 kg | 1.73 kg |
| Battery | 140 g | 157 g |
| Hover power | 208 W | 280 W |
| Candidate ranking | C, E, B, D, A | **unchanged** |
| Wing break-even radius | 2.6 km | **1.9 km** |

Nothing changed that matters. The candidate ranking is identical, and the break-even radius
actually *improved* — hovering became more expensive, which penalises a pure multirotor more
than it penalises a wing.

This is worth recording plainly: an assumption was wrong by a third, and the decisions built on
it survived. That is what the sensitivity analysis in Study 01 predicted would happen, since
hover efficiency scored only a 3 % swing.

## Still open

| Question | Blocked by |
|---|---|
| Exact motor | Thrust stand. Published figures are routinely optimistic |
| Battery voltage | 4S or 6S changes Kv, not power — decide alongside the ESC |
| Diameter ceiling | Fuselage and landing-gear geometry, not yet designed |
| Final pitch | Thrust-stand comparison of 10 × 5 against 10 × 6 |

!!! warning "Calibrated, not measured"
    The efficiency model is anchored to published motor test data, not to this aircraft. Every
    number here must be confirmed on a thrust stand before any motor is bought in quantity —
    that is already the exit criterion for the components stage.
