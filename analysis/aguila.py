"""
UAV AGUILA - design state and analysis functions.

This module holds everything the project currently KNOWS, and nothing it does not.

Two rules govern this file:

  1. A parameter is `None` until it has been decided or measured. Never a
     placeholder, never a plausible guess. The published site renders `None`
     as "not yet determined", so an empty design reads as an empty design.

  2. Every number published on the documentation site is generated from here.
     Set a value, run `make_tables.py`, and every table and the progress bar
     on the home page update together.

The analysis functions below are complete and correct. They simply return None
when their inputs are not yet known. The method exists before the numbers do -
that is the point.

Juan Martinez - UAV AGUILA
"""

import math

# ----------------------------------------------------------------------------
# Physical constants
# ----------------------------------------------------------------------------
RHO = 1.225          # air density at sea level, kg/m^3
G = 9.81             # gravity, m/s^2
NU = 1.5e-5          # kinematic viscosity of air, m^2/s
IN2M = 0.0254        # inches to metres


# ----------------------------------------------------------------------------
# DECIDED - things that are actually settled
# ----------------------------------------------------------------------------
#: Each entry is a real decision with a real basis. Nothing goes here that has
#: not been chosen deliberately and recorded in docs/program/decision-log.md.
DECIDED = {
    "mission": "Carry one 33 cl beverage can to a GPS waypoint, release it, return",
    "vtol": "Required. Takeoff and landing footprint within 1.5 m",
    "configuration": "Tilt-wing bicopter - straight wing rotating as a unit, one motor per side",
    "wing_planform": "Straight (unswept), constant or near-constant chord",
    "autonomy": "Waypoint autonomy - operator uploads a mission, aircraft flies it",
    "yaw_effector": "Differential nacelle tilt (see control-authority analysis)",
    "manufacture": "Every structural part printable on a Bambu Lab A1, 256 mm cube",
    "sourcing": "Components orderable from Amazon US, or already owned",
    "propeller": "10 inch, two blades - see the propulsion study",
    "motor": "iFlight Helion 10 / XING2 3110, 900 Kv, 77 g - 2 off",
    "battery_chemistry": "6S LiPo - packs already owned",
    "fpv": "No onboard video in Block 1",
    "donor_policy": "The existing 5-inch FPV quad is not disassembled",
}

#: Payload is the one hard physical number the mission gives us for free.
PAYLOAD = {
    "can_full_g": 370,      # 33 cl aluminium can, filled. To be confirmed on a scale.
    "carrier_g": None,      # release mechanism - not designed yet
}


# ----------------------------------------------------------------------------
# PARAMETERS - None until decided or measured
# ----------------------------------------------------------------------------
#: Set a value here only when it comes from an analysis you have run or a
#: measurement you have taken. Everything downstream updates automatically.
PARAMS = {
    # --- Geometry ---
    "S":            None,   # wing area, m^2
    "AR":           None,   # aspect ratio
    "y_motor":      None,   # motor spanwise station, m
    "prop_in":      10,     # DECIDED: 10 inch (Propulsion Study 02)
    "n_rotors":     2,      # DECIDED: two motors
    "tilt_diff_deg": None,  # nacelle differential travel for yaw, deg

    # --- Mass ---
    "MTOW":         None,   # kg

    # --- Aerodynamics ---
    "CL_max":       None,   # depends on airfoil - not selected
    "LD_cruise":    None,   # depends on configuration detail - not estimated
    "V_cruise":     None,   # m/s

    # --- Propulsion / energy ---
    "figure_of_merit": None,
    "eta_prop":        None,
    "eta_elec":        None,
    "batt_cells":      6,      # DECIDED: 6S, packs already owned
    "batt_mAh":        None,
    "batt_dod":        None,

    # --- Requirement thresholds (provisional until sizing) ---
    "TW_min":        None,  # hover thrust-to-weight floor
    "WL_max":        None,  # wing loading ceiling, kg/m^2
    "yaw_accel_min": None,  # hover yaw authority floor, deg/s^2
}


def known(*names):
    """True only if every named parameter has a value."""
    return all(PARAMS.get(n) is not None for n in names)


# ----------------------------------------------------------------------------
# MILESTONES - drives the progress bar on the home page
# ----------------------------------------------------------------------------
#: `short` is the label on the home-page progress bar (kept brief so the steps do not
#: collide); `label` is the full name used in the stage table; `note` is the exit criteria.
#: Flip `done` to True only when a stage's work is genuinely finished. A progress bar that
#: always reads full is worth nothing.
MILESTONES = [
    {
        "id": "mission",
        "short": "Mission",
        "label": "Mission defined",
        "done": True,
        "note": "Payload, VTOL, waypoint autonomy, manufacturing and sourcing constraints all set.",
    },
    {
        "id": "configuration",
        "short": "Config",
        "label": "Configuration chosen",
        "done": True,
        "note": "Tilt-wing bicopter, straight wing, two motors. Trade study run and overruled deliberately.",
    },
    {
        "id": "sizing",
        "short": "Sizing",
        "label": "Preliminary sizing",
        "done": False,
        "note": "Mass budget, wing area, span, power. Nothing about the aircraft's size is decided yet.",
    },
    {
        "id": "aero",
        "short": "Aero",
        "label": "Aerodynamic design",
        "done": False,
        "note": "Airfoil selection at the operating Reynolds number, control surface sizing, washout.",
    },
    {
        "id": "structure",
        "short": "Structure",
        "label": "Structural design",
        "done": False,
        "note": "Wing pivot load path first - it gates everything else. Then spar, segmentation, joints.",
    },
    {
        "id": "components",
        "short": "Parts",
        "label": "Components selected",
        "done": False,
        "note": "Motors, propellers, battery, autopilot. Verified on a thrust stand, not from listings.",
    },
    {
        "id": "cad",
        "short": "CAD",
        "label": "CAD complete",
        "done": False,
        "note": "Every part modelled and confirmed to fit the 256 mm build volume.",
    },
    {
        "id": "built",
        "short": "Built",
        "label": "Built",
        "done": False,
        "note": "Printed, assembled, wired, balanced. Measured masses replace every estimate.",
    },
    {
        "id": "flown",
        "short": "Flown",
        "label": "Flown",
        "done": False,
        "note": "Hover, transition, then the full waypoint-and-drop mission.",
    },
]


def progress():
    """Return (completed, total, percent)."""
    total = len(MILESTONES)
    done = sum(1 for m in MILESTONES if m["done"])
    return done, total, round(done / total * 100)


# ----------------------------------------------------------------------------
# Geometry
# ----------------------------------------------------------------------------
def span():
    """Wing span, m. Requires S and AR."""
    if not known("S", "AR"):
        return None
    return math.sqrt(PARAMS["AR"] * PARAMS["S"])


def chord():
    """Mean aerodynamic chord, m."""
    b = span()
    return None if b is None else PARAMS["S"] / b


def disk_area(prop_in=None, n=None):
    """Total rotor disk area, m^2."""
    prop_in = PARAMS["prop_in"] if prop_in is None else prop_in
    n = PARAMS["n_rotors"] if n is None else n
    if prop_in is None or n is None:
        return None
    return n * math.pi * (prop_in * IN2M / 2) ** 2


def reynolds():
    """Chord Reynolds number at cruise."""
    c = chord()
    if c is None or PARAMS["V_cruise"] is None:
        return None
    return PARAMS["V_cruise"] * c / NU


# ----------------------------------------------------------------------------
# Aerodynamics
# ----------------------------------------------------------------------------
def wing_loading(m=None):
    """Wing loading, kg/m^2."""
    m = PARAMS["MTOW"] if m is None else m
    if m is None or PARAMS["S"] is None:
        return None
    return m / PARAMS["S"]


def stall_speed(m=None):
    """Stall speed, m/s."""
    m = PARAMS["MTOW"] if m is None else m
    if m is None or not known("S", "CL_max"):
        return None
    return math.sqrt(2 * m * G / (RHO * PARAMS["S"] * PARAMS["CL_max"]))


def cruise_power(m=None):
    """Electrical power required in cruise, W."""
    m = PARAMS["MTOW"] if m is None else m
    if m is None or not known("V_cruise", "LD_cruise", "eta_prop", "eta_elec"):
        return None
    P_aero = (m * G / PARAMS["LD_cruise"]) * PARAMS["V_cruise"]
    return P_aero / (PARAMS["eta_prop"] * PARAMS["eta_elec"])


# ----------------------------------------------------------------------------
# Rotor / hover
# ----------------------------------------------------------------------------
def induced_velocity(m=None, prop_in=None, n=None):
    """Rotor slipstream velocity at hover thrust, m/s (momentum theory).

    Governs how much of the wing stays attached during a tilt-wing transition.
    Larger rotors give LOWER induced velocity - efficient in hover, worse in
    transition. That tension is real regardless of what size is eventually chosen.
    """
    m = PARAMS["MTOW"] if m is None else m
    A = disk_area(prop_in, n)
    if m is None or A is None:
        return None
    return math.sqrt(m * G / (2 * RHO * A))


def hover_power(m=None, prop_in=None, n=None):
    """Electrical power to hover, W."""
    m = PARAMS["MTOW"] if m is None else m
    A = disk_area(prop_in, n)
    if m is None or A is None or PARAMS["figure_of_merit"] is None:
        return None
    P_ideal = (m * G) ** 1.5 / math.sqrt(2 * RHO * A)
    return P_ideal / PARAMS["figure_of_merit"]


def washed_span_fraction(prop_in=None, n=None):
    """Fraction of the span immersed in propeller slipstream."""
    prop_in = PARAMS["prop_in"] if prop_in is None else prop_in
    n = PARAMS["n_rotors"] if n is None else n
    b = span()
    if prop_in is None or n is None or b is None:
        return None
    return n * prop_in * IN2M / b


def thrust_per_motor_g(m=None):
    """Required static thrust per motor, grams."""
    m = PARAMS["MTOW"] if m is None else m
    if m is None or PARAMS["TW_min"] is None:
        return None
    return m * PARAMS["TW_min"] * 1000 / PARAMS["n_rotors"]


# ----------------------------------------------------------------------------
# Transition
# ----------------------------------------------------------------------------
def effective_aoa(tilt_deg, V, w=None):
    """Wing angle of attack during transition, degrees.

    Pass `w` explicitly to explore the envelope before the aircraft is sized.
    With w=0 this returns the geometric (unblown) angle, which is simply the
    tilt angle - that part needs no design decisions at all.
    """
    if w is None:
        w = induced_velocity()
        if w is None:
            return None
    th = math.radians(tilt_deg)
    return math.degrees(math.atan2(V * math.sin(th), V * math.cos(th) + w))


# ----------------------------------------------------------------------------
# Hover control authority
# ----------------------------------------------------------------------------
def yaw_inertia(m=None):
    """Estimated yaw moment of inertia in hover, kg.m^2.

    Slender-body estimate. Replace with a measured bifilar-pendulum value once
    the aircraft exists - this is the weakest input in the whole DR-09 chain.
    """
    m = PARAMS["MTOW"] if m is None else m
    b = span()
    if m is None or b is None:
        return None
    return m * (b / 2) ** 2 / 3 + 0.05


def yaw_couple_nacelle_tilt(m=None, diff_deg=None, y=None):
    """Yaw couple from differential nacelle tilt, N.m."""
    m = PARAMS["MTOW"] if m is None else m
    diff_deg = PARAMS["tilt_diff_deg"] if diff_deg is None else diff_deg
    y = PARAMS["y_motor"] if y is None else y
    if m is None or diff_deg is None or y is None:
        return None
    T_per_motor = m * G / PARAMS["n_rotors"]
    return 2 * T_per_motor * math.sin(math.radians(diff_deg)) * y


def yaw_accel_deg_s2(couple, m=None):
    """Convert a yaw couple to angular acceleration, deg/s^2."""
    I = yaw_inertia(m)
    if couple is None or I is None:
        return None
    return couple / I * 180 / math.pi


# ----------------------------------------------------------------------------
# Energy
# ----------------------------------------------------------------------------
def battery_Wh():
    """Nominal battery energy, Wh."""
    if not known("batt_cells", "batt_mAh"):
        return None
    return PARAMS["batt_cells"] * 3.7 * PARAMS["batt_mAh"] / 1000


def usable_Wh():
    """Usable battery energy at the design depth of discharge, Wh."""
    E = battery_Wh()
    if E is None or PARAMS["batt_dod"] is None:
        return None
    return E * PARAMS["batt_dod"]


def endurance_min(hover_s=50):
    """Cruise endurance after a hover/transition allowance, minutes."""
    E, Ph, Pc = usable_Wh(), hover_power(), cruise_power()
    if None in (E, Ph, Pc):
        return None
    return (E - Ph * hover_s / 3600) / Pc * 60


def range_km(hover_s=50):
    """Still-air range, km."""
    t = endurance_min(hover_s)
    if t is None or PARAMS["V_cruise"] is None:
        return None
    return t * 60 * PARAMS["V_cruise"] / 1000


# ----------------------------------------------------------------------------
# Mass model
# ----------------------------------------------------------------------------
#: Add an entry only when you have a real basis for it - a measured part, a
#: catalogue mass for a component you have actually selected, or an analysis
#: you have run. An empty mass budget is an honest mass budget.
MASS_ITEMS = {
    # First real component mass in the budget. Manufacturer figure, 77 g each
    # including wire, from the iFlight and GetFPV specification pages. To be
    # confirmed on a scale when they arrive.
    "2x motor, iFlight Helion 10 3110 900 Kv": 0.154,
}


def mass_total():
    """Sum of the mass budget, kg, or None if it is empty."""
    return sum(MASS_ITEMS.values()) if MASS_ITEMS else None
