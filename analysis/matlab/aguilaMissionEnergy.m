function E = aguilaMissionEnergy(mass, S, AR, nRotors, diskLoading, hasWing, A, M)
% =========================================================================
% Juan MS CV
% AGUILA - Sizing Study 01
% Energy and power required to fly the design mission, for a given aircraft.
% =========================================================================
%
% INPUTS
%   mass        aircraft mass                                    [kg]
%   S           wing area (ignored when hasWing is false)        [m^2]
%   AR          aspect ratio                                     [-]
%   nRotors     number of lift rotors                            [-]
%   diskLoading hover disk loading                               [N/m^2]
%   hasWing     true for the winged aircraft, false for a pure
%               multirotor flown as a control case
%   A           assumptions struct from aguilaAssumptions
%   M           mission struct (tHover [s], radius [m], reserve [-])
%
% OUTPUT E, a struct containing:
%   energyWh    total mission energy at the battery terminals    [Wh]
%   pHover      electrical power in hover                        [W]
%   pCruise     electrical power in cruise                       [W]
%   vCruise     cruise speed flown                               [m/s]
%   vStall      stall speed                                      [m/s]
%   liftToDrag  cruise lift-to-drag ratio                        [-]
%   propDiam_in rotor diameter                                   [in]
%   tCruise     time spent in wing-borne flight                  [s]

    W       = mass * A.g;
    diskA   = W / diskLoading;                       % total disk area, m^2
    diamM   = 2 * sqrt(diskA / nRotors / pi);        % per-rotor diameter, m

    % --- Hover: momentum theory corrected by a figure of merit -----------
    E.pHover = W^1.5 / sqrt(2 * A.rho * diskA) / A.figureOfMerit;

    if hasWing
        % --- Drag polar --------------------------------------------------
        if nRotors == 2
            cd0 = A.cd0TwoRotor;
        else
            cd0 = A.cd0FourRotor;
        end
        kInduced = 1 / (pi * AR * A.oswald);

        E.vStall = sqrt(2 * W / (A.rho * S * A.clMax));

        % Minimum-drag speed. Flying slower than 1.3*Vstall is not sensible
        % for a first aircraft, so that is the floor.
        vMinDrag = sqrt(2 * W / (A.rho * S) * sqrt(kInduced / cd0));
        E.vCruise = max(vMinDrag, 1.30 * E.vStall);

        cl = 2 * W / (A.rho * E.vCruise^2 * S);
        cd = cd0 + kInduced * cl^2;
        E.liftToDrag = cl / cd;

        E.pCruise = (W / E.liftToDrag) * E.vCruise ...
                    / (A.etaPropCruise * A.etaElectrical);
        E.tCruise = 2 * M.radius / E.vCruise;

        E.energyWh = (E.pHover * M.tHover + E.pCruise * E.tCruise) / 3600;
    else
        % Control case: no wing, so the whole mission is flown in hover.
        E.vStall     = NaN;
        E.vCruise    = 10.0;                   % translational speed, m/s
        E.liftToDrag = NaN;
        E.pCruise    = E.pHover;
        E.tCruise    = 2 * M.radius / E.vCruise;
        E.energyWh   = E.pHover * (M.tHover + E.tCruise) / 3600;
    end

    E.propDiam_in = diamM / 0.0254;
end
