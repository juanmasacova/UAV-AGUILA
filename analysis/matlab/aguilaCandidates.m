function C = aguilaCandidates()
% =========================================================================
% Juan MS CV
% AGUILA - Sizing Study 01
% The five candidate wing sizes put forward for comparison.
% =========================================================================
%
% The configuration is already decided: two rotors, tilt-wing, straight
% wing. What is NOT decided is how big the wing should be. That is what
% these five candidates ask.
%
% Two variables are being traded, and the set is arranged so each can be
% read cleanly on its own:
%
%   A, B, C  share an aspect ratio and vary WING LOADING.
%            Wing loading is how much weight each square metre of wing
%            carries. High wing loading = small wing = fast aircraft.
%
%   B, D, E  share a wing loading and vary ASPECT RATIO.
%            Aspect ratio is span^2 / area. For a FIXED wing area, a low
%            aspect ratio gives a short stubby wing and a high one gives a
%            long slender wing. Same area, different shape.
%
% Everything else is held constant so the comparison is not confounded.
% Thrust-to-weight and rotor size are swept separately in the main script.

    baseThrustToWeight = 1.8;      % [-]
    baseDiskLoading    = 160.0;    % [N/m^2]
    nRotors            = 2;        % DECIDED: one motor per side

    names = {'A  Moderate wing', ...
             'B  Small wing', ...
             'C  Very small wing', ...
             'D  Short span (stubby)', ...
             'E  Long span (slender)'};

    wingLoading = [10.0, 13.0, 16.0, 13.0, 13.0];   % kg/m^2
    aspectRatio = [ 6.0,  6.0,  6.0,  4.5,  7.5];   % -

    intent = { ...
      'Biggest wing of the five. Slowest and most forgiving, largest to store.', ...
      'Middle of the small-wing range. The reference the others are judged against.', ...
      'Smallest wing. Fastest, lightest, least material - but fast is a real cost.', ...
      'Same wing area as B, packed into the shortest possible span.', ...
      'Same wing area as B, stretched into the most efficient span.'};

    for i = 1:numel(names)
        C(i).name           = names{i};
        C(i).intent         = intent{i};
        C(i).wingLoading    = wingLoading(i);
        C(i).aspectRatio    = aspectRatio(i);
        C(i).nRotors        = nRotors;
        C(i).thrustToWeight = baseThrustToWeight;
        C(i).diskLoading    = baseDiskLoading;
        C(i).hasWing        = true;
    end
end
