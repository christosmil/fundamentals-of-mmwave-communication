function mustBePowerOf2(numbers)
% mustBePowerOf2(number) validates if a number is a power of 2.
%
% The function receives the following input arguments.
%   number      array of numbers to check
%
% The function throws an error if any number of the array is not a power of
% 2.

% Check if all inputs is power of 2.
numbers = double(numbers);
for iter=1:length(numbers) 
    if numbers(iter) < 1 || ...
            floor(log2(numbers(iter))) ~= log2(numbers(iter))
        error('Value must be a positive power of 2.');
    end
end

end