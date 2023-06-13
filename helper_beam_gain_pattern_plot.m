function helper_beam_gain_pattern_plot(phis, gains, num_arrays, ...
    linewidth, linestyles, fontsize, fontname, fontsize_title, ...
    fontsize_axis, subplot_title)
% helper_beam_gain_pattern_plot(phis, gains, num_arrays, linewidth,
% linestyle, fontsize, fontname, fontsize_title, fontsize_axis) plots each
% subplot for the beam_gain_pattern() function.
%
% The function receives the following input arguments.
%   phis            an array of phi angle values
%   gains           an array of gains that corresponds to each phi value
%   num_arrays      the number of antenna arrays
%   linewidth       the width of the line in the subplot
%   linestyles      an array of styles for the lines in the subplot
%   fontsize        the general fontsize used in the subplot
%   fontname        the general fontname used in the subplot
%   fontsize_title  the fontsize used in the subplot title
%   fontsize_axis   the fontsize used in the subplot axis
%   subplot_title   the title of the subplot
%
% Reference:
% https://www.youtube.com/watch?v=UbA4IbFXTSU

% Validate input arguments.
arguments
    phis double {mustBeInRange(phis, -360, 360)}
    gains double
    num_arrays int16 {mustBePowerOf2(num_arrays)}
    linewidth (1, 1) int16 {mustBePositive(linewidth)}
    linestyles string {mustBeMember(linestyles, ...
        ["-", ":", "-.", "--", "none"])}
    fontsize (1, 1) int16 {mustBePositive(fontsize)}
    fontname (1, 1) string
    fontsize_title (1, 1) int16 {mustBePositive(fontsize_title)}
    fontsize_axis (1, 1) int16 {mustBePositive(fontsize_axis)}
    subplot_title (1, 1) string
end

% Make the subplot.
polarplot(phis, gains(1, :), LineWidth=linewidth, LineStyle=linestyles(1));
hold on;
for iter=2:length(num_arrays)
    polarplot(phis, gains(iter, :), LineWidth=linewidth, ...
        LineStyle=linestyles(iter));
end
hold off;

% Style the subplot.
set(gca, FontSize=fontsize, FontName=fontname);
thetatickformat('degrees');
title(subplot_title, FontSize=fontsize_title, FontWeight='normal');
legend_str = '';
for iter=1:length(num_arrays)
    legend_str = [legend_str; sprintf('%d array(s)', num_arrays(iter))];
end
legend(legend_str);
set(gca, ThetaZeroLocation='top', Thetalim=[-90 90], ...
    FontSize=fontsize_axis);
end