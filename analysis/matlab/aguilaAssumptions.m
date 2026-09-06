function A = aguilaAssumptions()
% =========================================================================
% Juan MS CV
% AGUILA - Sizing Study 01
% Every modelling coefficient used anywhere in the study, in one place.
% =========================================================================
%
% NOTHING in this file is a measurement. Every value is an engineering
% assumption with a stated basis. The point of collecting them here is that
% they can be challenged one at a time, and the sensitivity study in the main
% script shows which of them actually change the answer.
%
% Replace a value the moment you have real data for it.

    % --- Environment -----------------------------------------------------
    A.rho          = 1.225;    % air density at sea level                [kg/m^3]
    A.g            = 9.81;     % gravity                                 [m/s^2]
    A.nu           = 1.5e-5;   % kinematic viscosity of air              [m^2/s]

    % --- Structure -------------------------------------------------------
    % Wing areal density for a printed lightweight wing including skin, ribs,
    % spar and local motor reinforcement. Basis: published masses for LW-PLA
    % wings in the 1 m class, rounded up because a tilt wing carries the
    % motors and needs to be stiffer than a fixed one.
    A.kWing        = 1.05;     % wing mass per unit area                 [kg/m^2]
    A.kTail        = 0.18;     % tail mass as a fraction of wing mass    [-]
    A.mFuseBase    = 0.16;     % fuselage shell, gear, hardware          [kg]
    A.kFusePayload = 0.35;     % extra fuselage mass per kg of payload   [kg/kg]

    % Pivot: a fixed allowance for bearings and actuator, plus a term that
    % scales with wing root bending moment.
    A.mPivotBase   = 0.10;     % bearings, blocks, tilt actuator         [kg]
    A.kPivotMoment = 0.010;    % additional mass per N.m of root moment  [kg/(N.m)]

    % --- Propulsion ------------------------------------------------------
    % Motor mass scales close to linearly with maximum thrust across the
    % 2806 / 4008 / 5010 classes, at roughly 50-66 g per kg of thrust.
    A.kMotor       = 0.062;    % motor mass per kg of max thrust         [kg/kg]
    A.mMotorFixed  = 0.012;    % mount and fasteners, per motor          [kg]
    A.kEsc         = 0.0010;   % ESC mass per amp of rating              [kg/A]
    A.mEscFixed    = 0.006;    % connectors and wiring, per ESC          [kg]
    A.ampsPerKgT   = 10.0;     % current draw per kg of thrust at 6S     [A/kg]
    A.kProp        = 0.00035;  % prop mass coefficient, m = k*D_inch^1.6 [kg]

    % --- Avionics and actuation ------------------------------------------
    A.mAvionics    = 0.145;    % FC, GPS, RX, telemetry, Remote ID, wire [kg]
    A.mServo       = 0.014;    % per servo                               [kg]

    % --- Energy ----------------------------------------------------------
    A.eBattery     = 145.0;    % pack-level specific energy, LiPo        [Wh/kg]
    A.dod          = 0.80;     % usable depth of discharge               [-]
    A.figureOfMerit= 0.65;     % rotor hover efficiency                  [-]
    A.etaPropCruise= 0.62;     % cruise propulsive efficiency            [-]
    A.etaElectrical= 0.86;     % ESC and motor electrical efficiency     [-]

    % --- Aerodynamics ----------------------------------------------------
    A.clMax        = 1.20;     % achievable with a low-Re section + flap [-]
    A.oswald       = 0.80;     % span efficiency factor                  [-]
    A.cd0TwoRotor  = 0.042;    % parasite drag, 2 nacelles               [-]
    A.cd0FourRotor = 0.050;    % parasite drag, 4 nacelles               [-]

    % --- Payload ---------------------------------------------------------
    % 33 cl aluminium can, filled, plus an allowance for the release
    % mechanism. CONFIRM THE CAN ON A SCALE - it is the single most
    % influential number in the whole model (see the sensitivity study).
    A.payload      = 0.430;    % can plus release mechanism              [kg]

    % --- Manufacturing ---------------------------------------------------
    A.printSegment = 0.235;    % usable wing segment length on the A1    [m]
end
