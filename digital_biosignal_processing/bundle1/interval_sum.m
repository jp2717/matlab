function sum = interval_sum(array,lower, upper)
%interval_sum sums over the array of a chosen interval
%
%Takes as input the input array to be summed, and the lower and upper
%bounds from which the sum is computed
sum = 0;
for i = lower:upper
    sum = sum + array(i);
end

end

