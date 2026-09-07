# Program

Everything about the aircraft lives under this tab: what has been decided, what has been
calculated, what still has to be built and tested. It fills in as the project produces
answers, and it stays empty where it has not.

--8<-- "includes/progress-bar.md"

## The sections

Each one has a job and a trigger — the thing that has to happen before it can be filled in.

| Section | What goes in it | Fills in when | State |
|---|---|---|---|
| **[Stages](status.md)** | The phase board behind the bar above | A stage's exit criteria are met | <span class="chip active">Live</span> |
| **[Decision log](decision-log.md)** | Every decision, with the evidence and what it cost | A choice is made | <span class="chip active">5 closed</span> |
| **[Requirements](../requirements/index.md)** | What the aircraft must do, and the thresholds it is held to | Mission requirements now; derived thresholds at sizing | <span class="chip active">Partly set</span> |
| **[Regulatory](../requirements/regulatory.md)** | Registration, certification, Remote ID, airspace | Each item is confirmed at faa.gov | <span class="chip todo">Open</span> |
| **[Design](../design/index.md)** | Configuration and layout as chosen | A subsystem is designed | <span class="chip active">Config only</span> |
| **[Wing pivot](../design/wing-pivot.md)** | The mechanism that gates the build | Load path is worked out | <span class="chip todo">Not started</span> |
| **[Analysis](../analysis/index.md)** | Every study, with the code that produced it | A study is run | <span class="chip active">2 studies</span> |
| **[Build](../build/index.md)** | Print settings, assembly notes, what broke | Parts come off the printer | <span class="chip todo">Not started</span> |
| **[Print log](../build/print-log.md)** | Measured mass of every part, against estimate | Each print finishes | <span class="chip todo">Not started</span> |
| **[Test](../test/index.md)** | The test programme and its rules | Bench testing begins | <span class="chip todo">Not started</span> |
| **[Flight log](../test/flight-log.md)** | One row per powered test, failures included | Anything spins up | <span class="chip todo">Not started</span> |
| **[Procurement](../procurement/index.md)** | Bill of materials, prices, what arrived | Components are chosen | <span class="chip todo">Blocked on sizing</span> |

## Program intent

Design, analyse, build and fly a VTOL-capable unmanned aircraft that carries a standard
beverage can to a GPS waypoint, releases it, and returns — running the full engineering cycle
rather than assembling someone else's kit.

## MVP success criteria

In a single sortie, without intervention between arming and disarm:

1. Takes off vertically, or within a 1.5 m footprint
2. Transitions to wing-borne flight
3. Flies an uploaded waypoint mission
4. Releases the payload within 5 m of a commanded drop point
5. Returns, transitions back, and lands within 2 m of the launch point

## What is settled so far

--8<-- "includes/decided.md"

## The rule this record runs on

**No number is published until it has been calculated or measured.** Where a page shows
*not yet determined*, that is the true state of the project.

Every figure here is generated from a single design state in `analysis/aguila.py`, and
continuous integration fails the build if the published tables disagree with the code. The
site cannot drift away from the analysis.
