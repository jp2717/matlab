function [t_new,n_new] = updating(b_rate,f_rate,t_old,n_old)
%updating takes in the correct parameters and according to the distribution
%given by the input rates, computes the new population and the new time

%Total sum of transition rates out of the state
k_tot = b_rate + f_rate;

%sample a time increment from the exponential distribution with an 
%average of 1/rtot; add to old time.
t_new=exprnd(1/k_tot)+t_old; 
   
%Pick a destination with a probability determined by relative rates.
test=rand();


 % pick returning to the previous state if the random number is 
   %<back transition rate b_rate/total transition rate (b_rate + f_rate)
   %otherwise pick birth
   if(b_rate > test * k_tot)    
       n_new=n_old-1;
   else
       n_new=n_old+1;
   end
   
   %tnew and nnew are the new time and population and will be returned.
end

