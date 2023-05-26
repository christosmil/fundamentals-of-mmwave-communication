function maximum_ratio_beamforming(num_arrays, reference, rotation)
% maximum_ratio_beamforming(num_arrays, reference, rotation) calculates the
% angle of each antenna array to achieve constructive interference towards
% a target receiver location.
%
% The function receives the following inputs.
%   num_arrays  number of antenna arrays; log2(num_arrays) in Naturals Set
%   reference   reference antenna array; {1, 2, 3, 4}
%   rotation    rotation degree; [-360, 360]deg
%
% The function outputs the angles that each antenna array should be rotated
% to achieve the maximum ratio beamforming.
%
% Reference:
% https://www.youtube.com/watch?v=H7Vh-7kiejQ

% Validate arguments.
arguments
    num_arrays (1, 1) int16 {mustBePowerOf2(num_arrays)}
    reference (1, 1) int16 {mustBeInRange(reference, 1, num_arrays)}
    rotation (1, 1) double {mustBeInRange(rotation, -360, 360)}
end

% Fix calculations parameters.
NUM_CHANNELS = 64;
CHANNEL_DEGREE = 5.625;

% Calculate phase shift.
phase_shift = 180*sind(rotation);

% Calculate channels
channels = zeros(1, num_arrays);
for iter=1:num_arrays
    channels(1, iter) = mod((iter-1)*(phase_shift/CHANNEL_DEGREE), ...
        NUM_CHANNELS);
end

% Allocate channels to antenna arrays.
antennas_rotations = zeros(1, num_arrays);
for iter=1:num_arrays
    if iter == reference
        antennas_rotations(1, iter) = 0;
    else
        antennas_rotations(1, iter) = channels(1, ...
            mod((iter-reference), num_arrays) + 1);
    end
end

% Print the necessary phase for each antenna array.
for iter=1:num_arrays
    fprintf('CH%d: %2d (%3.f%c)\n', iter, antennas_rotations(iter), ...
        antennas_rotations(iter)*CHANNEL_DEGREE, char(176));
end

end