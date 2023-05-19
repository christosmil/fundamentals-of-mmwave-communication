function interference_constructive_destructive()
% interference_constructive_destructive() showcases the effect of two
% signals interfering in phase and out of phase. It plots the effects of
% different phases to the received signal power.
%
% Reference:
% https://www.youtube.com/watch?v=hxkojUEKAR0

% Close all.
close all;

% Set plot parameters.
LINEWIDTH = 2;
MARKERCOLOR = '#ab1234';
FONTSIZE = 16;
FONTSIZE_TITLE = FONTSIZE + 8;
FONTSIZE_AXIS = FONTSIZE + 4;
FONTNAME = 'Times New Roman';

% Set amplitude of original signals in mW.
AMPLITUDE = 0.0109;

% Set phase shift.
SAMPLING = 5;
THETAS = [0:SAMPLING:360];

% Set receiver sensitivity.
SENSITIVITY = zeros(1, length(THETAS));
SENSITIVITY(1, :) = -36.88;

% Set theoretical received power.
rx_powers = AMPLITUDE*(2*cosd(THETAS/2)).^2;
rx_powers_log = 10*log10(rx_powers);

% Plot theoretical received power.
figure(Visible='on');
plot(THETAS, rx_powers_log, LineWidth=LINEWIDTH, Marker='*');

% Plot receiver sensitivity.
hold on;
plot(THETAS, SENSITIVITY, LineWidth=LINEWIDTH, LineStyle='-.');

% Highligth 90deg and 270deg.
scatter(90, rx_powers_log(90/SAMPLING + 1), 75, ...
    MarkerEdgeColor=MARKERCOLOR, MarkerFaceColor=MARKERCOLOR);
text(90 + 1, rx_powers_log(90/SAMPLING + 1) + 1, '2x drop (-3dB)', ...
    FontSize=FONTSIZE, FontName=FONTNAME);
scatter(270, rx_powers_log(270/SAMPLING + 1), 75, ...
    MarkerEdgeColor=MARKERCOLOR, MarkerFaceColor=MARKERCOLOR);
text(270 - 1, rx_powers_log(270/SAMPLING + 1) - 1, '2x drop (-3dB)', ...
    FontSize=FONTSIZE, FontName=FONTNAME);
hold off;

% Style the plot.
grid on;
set(gca, FontSize=FONTSIZE, FontName=FONTNAME);
title('Received Power With Respect to Phase Shift Between Two Signals', ...
    Interpreter='latex', FontSize=FONTSIZE_TITLE);
xlabel('Phase Shift (deg)', Interpreter='latex', FontSize=FONTSIZE_AXIS);
ylabel('$P_{Rx}$ (dBm)', Interpreter='latex', FontSize=FONTSIZE_AXIS);
legend('Received Power', 'Receiver Sensitivity', Interpreter='latex');
xlim([-0.1, 360.1]);
ylim([-40, -10]);

end