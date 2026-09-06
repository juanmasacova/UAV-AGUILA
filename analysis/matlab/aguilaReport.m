function aguilaReport(C, R)
% =========================================================================
% Juan MS CV
% AGUILA - Sizing Study 01
% Print the candidate comparison table and the mass breakdown.
% =========================================================================

    fprintf('\n');
    fprintf('=====================================================================================================\n');
    fprintf(' CANDIDATE COMPARISON      (thrust-to-weight %.1f, disk loading %.0f N/m^2 held constant)\n', ...
            C(1).thrustToWeight, C(1).diskLoading);
    fprintf('=====================================================================================================\n');
    fprintf('%-27s %7s %8s %8s %8s %7s %9s %6s %7s\n', ...
            'candidate', 'MTOW', 'span', 'Vstall', 'Vcruise', 'prop', 'T/motor', 'segs', 'blown');
    fprintf('%-27s %7s %8s %8s %8s %7s %9s %6s %7s\n', ...
            '', '[kg]', '[mm]', '[m/s]', '[m/s]', '[in]', '[kg]', '[-]', '[%]');
    fprintf('-----------------------------------------------------------------------------------------------------\n');
    for i = 1:numel(R)
        fprintf('%-27s %7.2f %8.0f %8.1f %8.1f %7.1f %9.2f %6d %6.0f%%\n', ...
                C(i).name, R(i).mass, R(i).span*1000, R(i).vStall, R(i).vCruise, ...
                R(i).propDiam_in, R(i).thrustPerMotor, R(i).wingSegments, ...
                R(i).washedSpanFraction*100);
    end

    fprintf('\n');
    fprintf(' MASS BREAKDOWN [g]\n');
    fprintf('-----------------------------------------------------------------------------------------------------\n');
    fprintf('%-27s %7s %7s %7s %8s %7s %8s %9s\n', ...
            'candidate', 'wing', 'tail', 'pivot', 'motors', 'batt', 'payload', 'payload %');
    for i = 1:numel(R)
        fprintf('%-27s %7.0f %7.0f %7.0f %8.0f %7.0f %8.0f %8.0f%%\n', ...
                C(i).name, R(i).mass_wing*1000, R(i).mass_tail*1000, ...
                R(i).mass_pivot*1000, R(i).mass_motors*1000, ...
                R(i).mass_battery*1000, R(i).mass_payload*1000, ...
                R(i).payloadFraction*100);
    end

    fprintf('\n');
    fprintf(' FLIGHT PHYSICS\n');
    fprintf('-----------------------------------------------------------------------------------------------------\n');
    fprintf('%-27s %8s %9s %9s %9s %11s %10s\n', ...
            'candidate', 'L/D', 'hover W', 'cruise W', 'energy', 'Reynolds', 'mission');
    fprintf('%-27s %8s %9s %9s %9s %11s %10s\n', ...
            '', '[-]', '[W]', '[W]', '[Wh]', '[-]', '[min]');
    for i = 1:numel(R)
        fprintf('%-27s %8.1f %9.0f %9.0f %9.1f %11.0f %10.1f\n', ...
                C(i).name, R(i).liftToDrag, R(i).pHover, R(i).pCruise, ...
                R(i).energyWh, R(i).reynolds, R(i).missionMinutes);
    end
    fprintf('\n');
end
