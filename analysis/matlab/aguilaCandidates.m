function C = aguilaCandidates()
% =========================================================================
% Juan MS CV
% AGUILA - Sizing Study 01
% The five candidate configurations put forward for comparison.
% =========================================================================
%
% All five hold thrust-to-weight and disk loading constant so that the
% comparison isolates the two variables actually being traded:
%
%     wing loading   - how small the wing is
%     rotor count    - two motors or four
%
% Thrust-to-weight and disk loading are swept separately in the main script,
% because sweeping them here as well would confound the comparison.

    baseThrustToWeight = 1.8;      % [-]
    baseDiskLoading    = 160.0;    % [N/m^2]

    names = {'A  Small wing, 2 rotors', ...
             'B  Medium wing, 2 rotors', ...
             'C  Large wing, 2 rotors', ...
             'D  Medium wing, 4 rotors', ...
             'E  Small wing, 4 rotors'};

    wingLoading = [12.0, 8.0, 5.5, 8.0, 12.0];   % kg/m^2
    nRotors     = [   2,   2,   2,   4,    4];   % -
    aspectRatio = [ 5.0, 6.0, 6.5, 6.0,  5.0];   % -

    intent = {'Smallest possible aircraft. Fast, compact, fewest print parts.', ...
              'Middle of the range. The default if nothing argues otherwise.', ...
              'Slowest and most forgiving in the air, largest to build and store.', ...
              'Four smaller rotors. Cheaper motors, much better transition blowing.', ...
              'Four rotors on the smallest airframe. Highest slipstream coverage.'};

    for i = 1:numel(names)
        C(i).name            = names{i};
        C(i).intent          = intent{i};
        C(i).wingLoading     = wingLoading(i);
        C(i).nRotors         = nRotors(i);
        C(i).aspectRatio     = aspectRatio(i);
        C(i).thrustToWeight  = baseThrustToWeight;
        C(i).diskLoading     = baseDiskLoading;
        C(i).hasWing         = true;
    end
end
