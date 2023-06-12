function beam_gain_pattern()
% beam_gain_pattern() plots the theoretical beam's gain pattern for 1, 2,
% and 4 antenna arrays.
%
% Reference:
% https://www.youtube.com/watch?v=UbA4IbFXTSU

% Close all.
close all;

% Set plot parameters.
LINEWIDTH = 2;
LINESTYLE = ["-." "--" "-"];
FONTSIZE = 16;
FONTSIZE_TITLE = FONTSIZE + 8;
FONTSIZE_AXIS = FONTSIZE + 4;
FONTNAME = 'Times New Roman';

% Set calculations parameters.
NUM_ARRAYS = [1 2 4];
SAMPLING = 0.1;
PHI = [-90:SAMPLING:90];
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

% Plot theoretical gain in dB scale.
figure(Visible='on');
tiledlayout(2, 1);
nexttile;
polarplot(PHI, gains(1, :), LineWidth=LINEWIDTH, LineStyle=LINESTYLE(1));
hold on;
for iter=2:length(NUM_ARRAYS)
    polarplot(PHI, gains(iter, :), LineWidth=LINEWIDTH, ...
        LineStyle=LINESTYLE(iter));
end
hold off;

% Style the plot.
set(gca, FontSize=FONTSIZE, FontName=FONTNAME);
thetatickformat('degrees');
title('Theoretical Gain (dB Scale) for Different Arrays of Antennas', ...
    FontSize=FONTSIZE_TITLE, FontName=FONTNAME);
legend_str = '';
for iter=1:length(NUM_ARRAYS)
    legend_str = [legend_str; sprintf('%d array(s)', NUM_ARRAYS(iter))];
end
legend(legend_str, FontName=FONTNAME);
set(gca, ThetaZeroLocation='top', Thetalim=[-90 90], ...
    FontSize=FONTSIZE_AXIS, FontName=FONTNAME);

% Plot theoretical gain in linear scale.
nexttile;
polarplot(PHI, gains_linear(1, :), LineWidth=LINEWIDTH, ...
    LineStyle=LINESTYLE(1));
hold on;
for iter=2:length(NUM_ARRAYS)
    polarplot(PHI, gains_linear(iter, :), LineWidth=LINEWIDTH, ...
        LineStyle=LINESTYLE(iter));
end
hold off;

% Style the plot.
set(gca, FontSize=FONTSIZE, FontName=FONTNAME);
thetatickformat('degrees');
title('Theoretical Gain (Linear) for Different Arrays of Antennas', ...
    FontSize=FONTSIZE_TITLE, FontName=FONTNAME);
legend(legend_str, FontName=FONTNAME);
set(gca, ThetaZeroLocation='top', Thetalim=[-90 90], ...
    FontSize=FONTSIZE_AXIS, FontName=FONTNAME);

end