# How to keep this updated

First-time setup is in **[START_HERE.md](START_HERE.md)**. This file is the everyday loop.

---

## The loop

1. Change something in the folder — edit a document, log a flight, add a photo
2. If you touched `analysis\aguila.py`, run `python analysis\make_tables.py`
3. Open **GitHub Desktop**. Your changes are listed on the left
4. Type a short summary of what changed, click **Commit to main**
5. Click **Push origin**

The site rebuilds itself in about 90 seconds. That's all of it.

### Writing a useful summary

The summary is the one-line note attached to that snapshot. In six months it's the only thing
telling you what you did and why.

Poor: `update`, `changes`, `stuff`

Useful:

- `Phase 4: measured wing panel masses, 18% over estimate`
- `Close D5: H743 selected, F405 flash too tight for bicopter build`
- `Flight 3: transition abort at 60 deg wing angle, log attached`
- `Fix wing pivot bearing spacing after test fit`

Anyone reading your repository — including a recruiter — sees this list. It's a record of how you
work, so it's worth ten seconds.

---

## Where each kind of update goes

| What happened | Edit this | Also do this |
|---|---|---|
| Decided a design parameter | `analysis\aguila.py` → `PARAMS` — change `None` to the value | Re-run `make_tables.py`; record the reasoning in `docs\program\decision-log.md` |
| Completed a design stage | `analysis\aguila.py` → `MILESTONES` — set `done: True` | Re-run `make_tables.py`; the progress bar advances |
| Made a decision | `docs\program\decision-log.md` | Move it out of the Open table at the bottom |
| Printed a part and weighed it | `docs\build\print-log.md` | Add the measured mass to `MASS_ITEMS` in `analysis\aguila.py` |
| Ran a bench test | `docs\test\flight-log.md` (Bench results) | Tick the requirement in `docs\requirements\index.md` if it passed |
| Flew | `docs\test\flight-log.md` | Put the log file in `firmware\logs\` |
| Set a requirement threshold | `docs\requirements\index.md` — move it from Pending to Established | Add the value to `PARAMS` |
| Ordered parts | `docs\procurement\index.md` | |
| Confirmed a regulatory item | `docs\requirements\regulatory.md` | |
| Took a photo | Drop it in `docs\assets\` | Reference it from the relevant page |
| Learned something that changed your mind | Add an entry to `docs\notes\things-learned.md` | Follow the format of entry 01: what you assumed, what is true, why, what it changed |
| Something you don't want public | Put it in `internal\` | That folder is never uploaded |

---

## The one rule

**Never publish a number that has not been calculated or measured.**

In `analysis/aguila.py`, an undecided parameter is `None`, and the site renders `None` as
*not yet determined*. Do not fill one in with a plausible guess to make a page look complete —
a blank is information, and a guess that later turns out wrong quietly poisons everything
downstream of it.

When you decide something, change one line:

```python
# analysis/aguila.py
PARAMS = {
    "S": 0.34,          # was None
    ...
}
```

Then:

```
python analysis\make_tables.py
```

Span, chord, wing loading, stall speed, Reynolds number and required thrust all appear at once,
consistently, wherever they are referenced. There is no second place where a stale value can
survive.

**The build enforces this.** Edit `aguila.py` without regenerating and the Actions tab goes red
with a message naming what to run.

---

## Advancing the progress bar

The stepper on the home page is generated from `MILESTONES` in `analysis/aguila.py`:

```python
{
    "id": "sizing",
    "label": "Preliminary sizing",
    "done": True,          # was False
    "note": "...",
},
```

Re-run `make_tables.py`, commit, push. The bar fills.

Flip a stage to `True` only when its work is genuinely finished. A progress bar that always reads
full tells a reader nothing, and the honesty of this one is most of its value.

---

## Recording a superseded study

Archived revisions are **not** edited retroactively. That's the point of having them — the record
of what you thought at the time is what makes the decision log worth reading.

Exploratory work that was not adopted goes in `docs\program\studies\` with a banner saying so
plainly, and gets added to `nav:` in `mkdocs.yml`.

Keep it. A study you ran and rejected is evidence you considered the alternative — but label it
clearly, so nobody mistakes its preliminary numbers for design decisions. Record what you decided
and **why** in `docs\program\decision-log.md`.

That last part is the one that matters. A trade study that only records the winner is worth much less
than one that records the argument.

---

## Adding photographs

Drop images in `docs\assets\` and reference them:

```markdown
![Wing panel 1 off the printer](../assets/wing-panel-1.jpg){ width="600" }
```

Keep them under about 1 MB each — resize before committing, since git keeps every version of
every file forever.

Photographs are what turn this from a document into evidence. A picture of a failed wing joint
next to the analysis that predicted it is worth a page of prose.

---

## If the build goes red

Check the **Actions** tab on GitHub and read the error.

**"includes/ is stale"** — run `python analysis\make_tables.py`, commit, push.

**"mkdocs build --strict failed"** — usually a link to a page that doesn't exist, or a page added
to `docs\` without being listed in `nav:` in `mkdocs.yml`. The error names the file.

To catch either before pushing:

```
python analysis\make_tables.py
mkdocs build --strict
```

---

## Quick reference

| I want to… | Do this |
|---|---|
| See my changes before publishing | `mkdocs serve`, open http://127.0.0.1:8000 |
| Regenerate the numbers and progress bar | `python analysis\make_tables.py` |
| Publish | GitHub Desktop → Commit → Push origin |
| Check the build | github.com/juanmasacova/AGUILA-UAV → Actions tab |
| View the site | juanmasacova.github.io/AGUILA-UAV |
| Keep something private | Put it in `internal\` |
| Undo something | Ask before running git commands — recovery is easy, but the commands that look right are often the destructive ones |
