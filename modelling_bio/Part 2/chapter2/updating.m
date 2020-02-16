function [t_new,n_new] = updating(b_rate,f_rate,t_old,n_old)
%updating takes in the correct parameters and according to the distribution
%given by the input rates, computes the new population and the new time

%Total sum of transition rates out of the state
k_tot = b_rate + f_rate;

%sample a time increment from the exponential distribution with an 
%average of 1/rtot; add to old time.
tnew=exprnd(1/rtot)+t_old; 
   
%Pick a destination with a probability determined by relative rates.
test=rand();


outputArg1 = inputArg1;
outputArg2 = inputArg2;
end

