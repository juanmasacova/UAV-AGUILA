function aguilaExplain(heading, lines)
% =========================================================================
% Juan MS CV
% AGUILA - Sizing Study 01
% Print an indented explanation block under a results table.
% =========================================================================
%
% A table of numbers with no explanation is not a study, it is a data dump.
% Every table this program prints is followed by one of these blocks saying
% what the numbers mean and what decision they feed.

    fprintf('\n   %s\n', upper(heading));
    for i = 1:numel(lines)
        fprintf('     %s\n', lines{i});
    end
end
