# Analysis

Every figure on these pages is generated from the design state in `analysis/aguila.py`. A
parameter that has not been decided renders as *not yet determined*, never as a placeholder.

- **[Sizing](sizing.md)** — the design point, mostly empty, and the method that will fill it
- **[Configuration trade study](trade-study.md)** — the four-way trade, and why it was overruled
- **[Hover control authority](control-authority.md)** — the missing yaw axis
- **[Transition envelope](transition-envelope.md)** — the partly stalled wing

## What is already true, and what waits on sizing

The two findings on control authority and transition are **structural**: they follow from the
shape of the aircraft, not from its dimensions, so they hold whatever it turns out to weigh. They
already constrain the design.

Everything numerical — span, mass, power, endurance — waits on preliminary sizing, which has not
been done.

## Reproducing any of it

```bash
pip install -r requirements.txt
python analysis/make_tables.py      # regenerate every published table
mkdocs serve                        # view at http://127.0.0.1:8000
```

`analysis/aguila.py` holds the design state and the physics. It has no dependencies beyond the
standard library, so it reads as documentation in its own right.
