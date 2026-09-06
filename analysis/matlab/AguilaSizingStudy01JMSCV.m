% =========================================================================
% Juan MS CV
% AGUILA - Sizing Study 01
% Compare five candidate configurations and establish which requirement
% thresholds are worth adopting, before any component is chosen.
% =========================================================================
%
% WHAT THIS SCRIPT DECIDES:  nothing.
% WHAT IT DOES:              shows what each candidate costs and buys, so
%                            the decision can be made on evidence.
%
% Every coefficient it relies on lives in aguilaAssumptions.m. None of them
% is a measurement. Section 6 shows which ones actually matter.
%
% Run:  >> AguilaSizingStudy01JMSCV
% =========================================================================

clear all; clc;

A = aguilaAssumptions();

% Design mission: out 500 m, hover to drop, return and land.
M.tHover  = 60.0;    % climb + 2 transitions + drop hover + descent   [s]
M.radius  = 500.0;   % one-way distance to the drop point             [m]
M.reserve = 0.50;    % energy held back on landing                    [-]

fprintf('=====================================================================\n');
fprintf(' AGUILA SIZING STUDY 01\n');
fprintf(' Mission: %.0f m out, hover drop, return. Hover allowance %.0f s.\n', ...
        M.radius, M.tHover);
fprintf(' Payload: %.0f g.  Energy reserve: %.0f %%.\n', A.payload*1000, M.reserve*100);
fprintf('=====================================================================\n');

%% 1 -- Size the five candidates ------------------------------------------
C = aguilaCandidates();
R = aguilaConverge(C(1), A, M);          % preallocate the struct array
for i = 2:numel(C)
    R(i) = aguilaConverge(C(i), A, M);
end
aguilaReport(C, R);

%% 2 -- Is the wing earning its mass? -------------------------------------
% Control case: the same mission flown by a pure multirotor, with no wing,
% no pivot, no tilt mechanism and no transition. If that comes out lighter,
% the wing is costing more than it saves at this mission length.

fprintf(' 2. IS THE WING EARNING ITS MASS?\n');
fprintf('-----------------------------------------------------------------------------------------------------\n');
fprintf('%10s %14s %20s %14s\n', 'radius [m]', 'winged [kg]', 'pure multirotor [kg]', 'wing costs');
radii = [250 500 1000 2000 4000 8000 16000];
for r = radii
    Mr = M; Mr.radius = r;
    cfgW = C(2);
    cfgM = C(2); cfgM.hasWing = false; cfgM.nRotors = 4;
    Rw = aguilaConverge(cfgW, A, Mr);
    Rm = aguilaConverge(cfgM, A, Mr);
    if isfinite(Rm.mass)
        fprintf('%10d %14.2f %20.2f %+13.2f\n', r, Rw.mass, Rm.mass, Rw.mass - Rm.mass);
    else
        fprintf('%10d %14.2f %20s %13s\n', r, Rw.mass, 'does not close', 'wing wins');
    end
end

% Bisect for the break-even radius.
lo = 500; hi = 40000;
for k = 1:40
    mid = (lo + hi) / 2;
    Mr = M; Mr.radius = mid;
    cfgM = C(2); cfgM.hasWing = false; cfgM.nRotors = 4;
    Rw = aguilaConverge(C(2), A, Mr);
    Rm = aguilaConverge(cfgM, A, Mr);
    if Rw.mass < Rm.mass
        hi = mid;
    else
        lo = mid;
    end
end
fprintf('\n  Break-even radius: %.1f km. The design mission is %.1f km.\n', ...
        hi/1000, M.radius/1000);

%% 3 -- Where does the energy actually go? --------------------------------
fprintf('\n 3. WHERE THE ENERGY GOES  (candidate B)\n');
fprintf('-----------------------------------------------------------------------------------------------------\n');
eHover  = R(2).pHover * M.tHover / 3600;
eCruise = R(2).energyWh - eHover;
fprintf('  hover  %4.0f s at %3.0f W  = %5.2f Wh  (%3.0f %%)\n', ...
        M.tHover, R(2).pHover, eHover, 100*eHover/R(2).energyWh);
fprintf('  cruise %4.0f m at %3.0f W  = %5.2f Wh  (%3.0f %%)\n', ...
        2*M.radius, R(2).pCruise, eCruise, 100*eCruise/R(2).energyWh);
fprintf('  battery needed, with reserve: %.0f g = %.0f %% of MTOW\n', ...
        R(2).mass_battery*1000, 100*R(2).mass_battery/R(2).mass);

%% 4 -- Sweep: what does thrust-to-weight cost? ---------------------------
fprintf('\n 4. SWEEP - THRUST-TO-WEIGHT  (candidate B geometry)\n');
fprintf('-----------------------------------------------------------------------------------------------------\n');
fprintf('%8s %10s %10s %12s %10s\n', 'T/W', 'MTOW [kg]', 'span [mm]', 'T/motor [kg]', 'hover [W]');
twList = [1.4 1.6 1.8 2.0 2.2 2.5];
twMass = zeros(size(twList));
for i = 1:numel(twList)
    cfg = C(2); cfg.thrustToWeight = twList(i);
    Rt = aguilaConverge(cfg, A, M);
    twMass(i) = Rt.mass;
    fprintf('%8.1f %10.2f %10.0f %12.2f %10.0f\n', ...
            twList(i), Rt.mass, Rt.span*1000, Rt.thrustPerMotor, Rt.pHover);
end

%% 5 -- Sweep: what does rotor size cost? ---------------------------------
fprintf('\n 5. SWEEP - DISK LOADING  (candidate B, T/W %.1f)\n', C(2).thrustToWeight);
fprintf('-----------------------------------------------------------------------------------------------------\n');
fprintf('%14s %10s %10s %12s %10s\n', 'disk [N/m^2]', 'prop [in]', 'MTOW [kg]', 'hover [W]', 'blown [%]');
dlList = [100 130 160 200 250 320];
for dl = dlList
    cfg = C(2); cfg.diskLoading = dl;
    Rd = aguilaConverge(cfg, A, M);
    fprintf('%14.0f %10.1f %10.2f %12.0f %9.0f%%\n', ...
            dl, Rd.propDiam_in, Rd.mass, Rd.pHover, Rd.washedSpanFraction*100);
end

%% 6 -- Sensitivity: which assumptions actually matter? -------------------
% A conclusion that survives a +/-30 % error in an assumption is safe to act
% on. One that does not is a conclusion about the assumption, not about the
% aircraft.

fprintf('\n 6. SENSITIVITY  (+/- 30 %% on each assumption, candidate B)\n');
fprintf('-----------------------------------------------------------------------------------------------------\n');
fprintf('%-32s %12s %12s %12s\n', 'assumption', '-30%', '+30%', 'swing');
baseMass = R(2).mass;
fields = {'kWing', 'kPivotMoment', 'kMotor', 'eBattery', 'payload', 'figureOfMerit'};
labels = {'wing areal density', 'pivot mass scaling', 'motor mass per kg thrust', ...
          'battery specific energy', 'payload mass', 'rotor figure of merit'};
for i = 1:numel(fields)
    lowA  = A; lowA.(fields{i})  = A.(fields{i}) * 0.7;
    highA = A; highA.(fields{i}) = A.(fields{i}) * 1.3;
    Rlow  = aguilaConverge(C(2), lowA,  M);
    Rhigh = aguilaConverge(C(2), highA, M);
    mLow  = Rlow.mass;
    mHigh = Rhigh.mass;
    fprintf('%-32s %10.2f kg %10.2f kg %10.0f %%\n', ...
            labels{i}, mLow, mHigh, 100*abs(mHigh-mLow)/baseMass);
end

fprintf('\n=====================================================================\n');
fprintf(' Study complete. Nothing above is a decision.\n');
fprintf(' Read section 6 first: it tells you which of these numbers to trust.\n');
fprintf('=====================================================================\n\n');
