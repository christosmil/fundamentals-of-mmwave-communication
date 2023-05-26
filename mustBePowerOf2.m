function mustBePowerOf2(number)
% mustBePowerOf2(number) validates if a number is a power of 2.
%
% The function receives the following input arguments.
%   number      the number to check
%
% The function throws an error if the number is not a power of 2.

% Check if input is power of 2.
number = double(number);
if number < 2 || floor(log2(number)) ~= log2(number)
    error('Value must be a positive power of 2.');
end

end