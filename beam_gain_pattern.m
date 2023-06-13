function beam_gain_pattern()
% beam_gain_pattern() plots the theoretical beams' gain pattern for 1, 2,
% and 4 antenna arrays.
%
% Reference:
% https://www.youtube.com/watch?v=UbA4IbFXTSU

% Close all.
close all;

% Set plot parameters.
LINEWIDTH = 2;
LINESTYLES = ["-." "--" "-"];
FONTSIZE = 16;
FONTSIZE_TITLE = FONTSIZE + 8;
FONTSIZE_AXIS = FONTSIZE + 4;
FONTNAME = 'Times New Roman';

% Set calculations parameters.
NUM_ARRAYS = [1 2 4];
SAMPLING = 0.1;
PHI = -90:SAMPLING:90;
PHI = deg2rad(PHI);

% Calculate gain.
gains = zeros(length(NUM_ARRAYS), length(PHI));
for iter1=1:length(NUM_ARRAYS)
    for iter2=1:length(PHI)
        gains(iter1, iter2) = 4*cos(PHI(iter2))*(1/NUM_ARRAYS(iter1))*...
            (sin((NUM_ARRAYS(iter1)*pi/2)*sin(PHI(iter2)))^2)/...
            (sin((pi/2)*sin(PHI(iter2)))^2);
    end
end
gains_linear = db2pow(gains);

% Plot the results.
figure(Visible='on');
tiledlayout(2, 1);

% Plot theoretical gain in dB scale.
nexttile;
helper_beam_gain_pattern_plot(PHI, gains, NUM_ARRAYS, LINEWIDTH, ...
    LINESTYLES, FONTSIZE, FONTNAME, FONTSIZE_TITLE, FONTSIZE_AXIS, ...
    'Logarithmic Scale')

% Plot theoretical gain in linear scale.
nexttile;
helper_beam_gain_pattern_plot(PHI, gains_linear, NUM_ARRAYS, LINEWIDTH, ...
    LINESTYLES, FONTSIZE, FONTNAME, FONTSIZE_TITLE, FONTSIZE_AXIS, ...
    'Linear Scale')

% Style the figure.
sgtitle('Theoretical Gain for Different Arrays of Antennas', ...
    FontSize=FONTSIZE_TITLE, FontName=FONTNAME, FontWeight='bold');

end