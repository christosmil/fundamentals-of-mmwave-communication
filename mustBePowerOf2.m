function mustBePowerOf2(numbers)
% mustBePowerOf2(numbers) validates if all the numbers of an array are a
% power of 2.
%
% The function receives the following input arguments.
%   numbers     array of numbers to check
%
% The function throws an error if any number of the array is not a power of
% 2.

% Check if all inputs is power of 2.
numbers = double(numbers);
for iter=1:length(numbers) 
    if sum(bitget(numbers(iter), 1:64))
        error('Value must be a positive power of 2.');
    end
end

end