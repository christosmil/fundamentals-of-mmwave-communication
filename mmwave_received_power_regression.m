function mmwave_received_power_regression()
% mmwave_received_power_regression() plots the measurements of a mmWave
% experiment at 26.5GHz and performs curve fitting on the measured values.
% The fitted line's parameters are provided.
% 
% Reference:
% https://www.youtube.com/watch?v=H7Vh-7kiejQ

% Close all.
close all;

% Fix plot parameters.
COLOR_MEASUREMENTS = '#1234ab';
LINEWIDTH = 2;
COLOR = '#ab1234';
MARKER = '+';
MARKERSIZE = 6;
FONTSIZE = 16;
FONTSIZE_TITLE = FONTSIZE + 8;
FONTSIZE_AXIS = FONTSIZE + 4;
FONTNAME = 'Times New Roman';

% Fix calculations parameters.
distances = [30, 40, 50, 60];
log_rx_powers = [-15.5, -19.5, -20.5, -21.5];
A = 18.7;
PLE = 1.95;

% Calculate hard-coded regression.
regression = 10*log10(A) - PLE*10*log10(distances);

% Calculate and print residuals.
residuals = sum((log_rx_powers-10*log10(A) - PLE*10*log10(distances)).^2);
disp(residuals);

% Plot results.
figure(Visible='on');
scatter(distances, log_rx_powers, MarkerFaceColor=COLOR_MEASUREMENTS);
hold on;
plot(distances, regression, LineWidth=LINEWIDTH, Color=COLOR, ...
    Marker=MARKER, MarkerSize=MARKERSIZE);
hold off;

% Style the plot.
set(gca, FontName=FONTNAME, FontSize=FONTSIZE);
grid on;
title('mmWave Received Power at 26.5GHz', FontSize=FONTSIZE_TITLE, ...
    Interpreter='latex');
xlabel('Distance (cm)', FontSize=FONTSIZE_AXIS, Interpreter='latex');
ylabel('Received Power (dBm)', FontSize=FONTSIZE_AXIS, ...
    Interpreter='latex');
legend_string = {...
    sprintf('Measurements'), ...
    sprintf('Curve Fitting $\\frac{%.1f}{d^{%.2f}}$', A, PLE), ...
};
legend(legend_string, Interpreter='latex', location='northeast');

end