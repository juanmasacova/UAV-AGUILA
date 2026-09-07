function P = aguilaPropModel(thrustN, diameterIn, A, nBlades, pitchIn)
% =========================================================================
% Juan MS CV
% AGUILA - Propulsion Study 02
% What one propeller costs, in watts, to produce a given thrust.
% =========================================================================
%
% THE PHYSICS, IN ONE LINE
%   A propeller makes thrust by throwing air downward. Momentum theory says
%   the ideal power to do that is
%
%       P_ideal = T^1.5 / sqrt(2 * rho * A_disk)
%
%   Two consequences drive every result in this study:
%
%   1. Power grows with thrust to the POWER OF 1.5, not linearly. Asking a
%      propeller for twice the thrust costs 2^1.5 = 2.83 times the power.
%
%   2. Power falls with the SQUARE ROOT of disk area. A bigger propeller is
%      always cheaper for the same thrust - no exception, and no diminishing
%      return until geometry stops you.
%
%   Note what is ABSENT from that equation: blade count and pitch. Momentum
%   theory only sees the disk. Blades and pitch enter as second-order
%   corrections to the figure of merit, handled below.
%
% INPUTS
%   thrustN      thrust demanded from ONE propeller                   [N]
%   diameterIn   propeller diameter                                   [in]
%   A            assumptions struct from aguilaAssumptions
%   nBlades      optional, default 2
%   pitchIn      optional propeller pitch [in]. Supply it to get the
%                maximum airspeed the propeller can push against and the
%                hover penalty that pitch costs.
%
% OUTPUT P, a struct:
%   powerW        electrical power required                           [W]
%   powerIdealW   ideal aerodynamic power                             [W]
%   diskArea      area swept                                          [m^2]
%   diskLoading   thrust per unit disk area                           [N/m^2]
%   efficiency    hover efficiency                                    [g/W]
%   rpm           rotational speed needed                             [rev/min]
%   tipSpeed      propeller tip speed                                 [m/s]
%   maxAirspeed   fastest the propeller can push (pitch given)        [m/s]

    if nargin < 4 || isempty(nBlades); nBlades = 2;   end
    if nargin < 5;                     pitchIn = [];  end

    diamM = diameterIn * 0.0254;
    P.diskArea    = pi * (diamM / 2)^2;
    P.diskLoading = thrustN / P.diskArea;
    P.powerIdealW = thrustN^1.5 / sqrt(2 * A.rho * P.diskArea);

    % --- Blade-count correction -------------------------------------------
    % More blades means more blade area in the flow, so more profile drag and
    % a lower figure of merit. Adding a third blade does NOT add 50 % more
    % thrust either - the blades interfere - so the thrust coefficient rises
    % by roughly 1.4x, not 1.5x.
    if nBlades == 2
        bladeEff = 1.00;   ctScale = 1.00;
    elseif nBlades == 3
        bladeEff = 0.94;   ctScale = 1.40;
    else
        bladeEff = 0.94 - 0.05 * (nBlades - 3);
        ctScale  = 1.40 + 0.30 * (nBlades - 3);
    end

    % --- Pitch correction ---------------------------------------------------
    % A coarse blade sits at a higher angle of attack when the aircraft is
    % standing still, so it is closer to stalling and hovers less
    % efficiently. Below a pitch-to-diameter ratio of about 0.5 there is no
    % meaningful penalty.
    pitchEff = 1.0;
    if ~isempty(pitchIn)
        pitchToDiam = pitchIn / diameterIn;
        if pitchToDiam > 0.5
            pitchEff = max(0.75, 1 - 0.25 * (pitchToDiam - 0.5));
        end
    end

    P.powerW     = P.powerIdealW / (A.figureOfMerit * bladeEff * pitchEff);
    P.efficiency = (thrustN / A.g * 1000) / P.powerW;

    % --- Rotational speed ---------------------------------------------------
    revPerSec  = sqrt(thrustN / (A.propCt * ctScale * A.rho * diamM^4));
    P.rpm      = revPerSec * 60;
    P.tipSpeed = pi * diamM * revPerSec;

    % --- How fast can it push? ----------------------------------------------
    % Pitch is the distance the propeller would advance in one turn through a
    % solid. Real air slips, so usable airspeed is roughly 85 % of pitch
    % speed. Below that the propeller simply cannot reach the airspeed.
    if ~isempty(pitchIn)
        P.maxAirspeed = pitchIn * 0.0254 * revPerSec * A.rpmUnderLoad;
        P.pitchToDiam = pitchIn / diameterIn;
    else
        P.maxAirspeed = NaN;
        P.pitchToDiam = NaN;
    end
end
