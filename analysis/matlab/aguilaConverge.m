function R = aguilaConverge(cfg, A, M)
% =========================================================================
% Juan MS CV
% AGUILA - Sizing Study 01
% Close the mass loop for one configuration and return the sized aircraft.
% =========================================================================
%
% WHY THIS HAS TO ITERATE
%   Aircraft mass depends on wing area, which depends on mass. It also
%   depends on motor mass, which depends on required thrust, which depends
%   on mass. The design is circular, so it is solved as a fixed point:
%   guess a mass, build the aircraft, weigh it, repeat until the guess and
%   the result agree.
%
%   If the loop diverges it means the configuration does not close - the
%   aircraft can never lift itself under these assumptions. That is a real
%   result, not a bug.
%
% INPUTS
%   cfg   .wingLoading     [kg/m^2]   how small the wing is
%         .thrustToWeight  [-]        hover thrust margin
%         .nRotors         [-]        2 or 4
%         .diskLoading     [N/m^2]    how small the rotors are
%         .aspectRatio     [-]        span^2 / area
%         .hasWing         [logical]  false runs the pure-multirotor case
%   A     assumptions from aguilaAssumptions
%   M     mission struct
%
% OUTPUT R, the converged aircraft.

    if ~isfield(cfg, 'hasWing'); cfg.hasWing = true; end

    mass      = 1.5;        % initial guess, kg
    relax     = 0.5;        % under-relaxation keeps the loop stable
    tolerance = 1e-7;
    maxIter   = 400;
    massLimit = 50.0;       % kg - beyond this the loop has clearly run away
    converged = false;
    diverged  = false;

    for iter = 1:maxIter
        % --- Geometry that follows from the current mass guess ------------
        if cfg.hasWing
            S    = mass / cfg.wingLoading;
            span = sqrt(cfg.aspectRatio * S);
        else
            S    = 0;
            span = 0;
        end
        W = mass * A.g;

        % --- Mission energy ----------------------------------------------
        E = aguilaMissionEnergy(mass, S, cfg.aspectRatio, cfg.nRotors, ...
                                cfg.diskLoading, cfg.hasWing, A, M);

        batteryWh = E.energyWh * (1 + M.reserve) / A.dod;
        mBattery  = batteryWh / A.eBattery;

        % --- Mass build-up ------------------------------------------------
        thrustPerMotor = mass * cfg.thrustToWeight / cfg.nRotors;   % kg

        mMotors = cfg.nRotors * (A.kMotor * thrustPerMotor + A.mMotorFixed);
        mEsc    = cfg.nRotors * (A.kEsc * thrustPerMotor * A.ampsPerKgT ...
                                 + A.mEscFixed);
        mProps  = cfg.nRotors * A.kProp * E.propDiam_in^1.6;
        mFuse   = A.mFuseBase + A.kFusePayload * A.payload;

        if cfg.hasWing
            mWing  = A.kWing * S;
            mTail  = A.kTail * mWing;
            rootMoment = W / 2 * span / 4;                 % N.m
            mPivot = A.mPivotBase + A.kPivotMoment * rootMoment;
            % 2 flaperons + 2 tail + one tilt servo per nacelle + release
            nServos = 2 + 2 + cfg.nRotors + 1;
        else
            mWing = 0; mTail = 0; mPivot = 0; rootMoment = 0;
            nServos = 1;                                   % release only
        end
        mServos = nServos * A.mServo;

        newMass = mWing + mTail + mFuse + mPivot + mMotors + mEsc + mProps ...
                  + mServos + A.mAvionics + mBattery + A.payload;

        if abs(newMass - mass) < tolerance
            mass = newMass;
            converged = true;
            break
        end
        mass = (1 - relax) * mass + relax * newMass;

        % A runaway loop is a real result: the aircraft cannot lift the
        % battery it needs to fly the mission. Report it rather than
        % returning a meaningless number.
        if mass > massLimit || ~isfinite(mass)
            diverged = true;
            break
        end
    end

    if diverged
        % Mark the configuration as impossible. Infinite mass makes it lose
        % every comparison automatically, which is the correct behaviour.
        R.converged = false;
        R.diverged  = true;
        R.mass      = Inf;
        return
    end

    % --- Pack the result ---------------------------------------------------
    R.converged      = converged;
    R.diverged       = false;
    R.iterations     = iter;
    R.mass           = mass;
    R.wingArea       = S;
    R.span           = span;
    if cfg.hasWing
        R.chord      = S / span;
        R.reynolds   = E.vCruise * R.chord / A.nu;
        R.wingSegments = ceil((span / 2) / A.printSegment);
        R.washedSpanFraction = cfg.nRotors * E.propDiam_in * 0.0254 / span;
    else
        R.chord = NaN; R.reynolds = NaN;
        R.wingSegments = 0; R.washedSpanFraction = NaN;
    end
    R.vStall         = E.vStall;
    R.vCruise        = E.vCruise;
    R.liftToDrag     = E.liftToDrag;
    R.propDiam_in    = E.propDiam_in;
    R.thrustPerMotor = mass * cfg.thrustToWeight / cfg.nRotors;
    R.pHover         = E.pHover;
    R.pCruise        = E.pCruise;
    R.energyWh       = E.energyWh;
    R.missionMinutes = (M.tHover + E.tCruise) / 60;

    R.mass_wing    = mWing;
    R.mass_tail    = mTail;
    R.mass_fuse    = mFuse;
    R.mass_pivot   = mPivot;
    R.mass_motors  = mMotors;
    R.mass_esc     = mEsc;
    R.mass_props   = mProps;
    R.mass_servos  = mServos;
    R.mass_battery = mBattery;
    R.mass_payload = A.payload;
    R.payloadFraction = A.payload / mass;
end
