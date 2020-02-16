function [tnew, nnew]= update_time_and_pop(lambda_in, mu_in, n_old,t_old)
   
    %first, work out the total rate
   %This is easy because the population can only increase or decrease by 1.
   rtot= mu_in*n_old+lambda_in*n_old;
   
   %sample a time increment from the exponential distribution with an 
   %average of 1/rtot; add to old time.
   tnew=exprnd(1/rtot)+t_old; 
   
   %Pick a destination with a probability determined by relative rates.
   test=rand();
   
   % pick death if the random number is 
   %<death transition rate (mu*n)/total transition rate (mu*n+lambda*n)
   %otherwise pick birth
   if(mu_in*n_old >test*rtot)    
       nnew=n_old-1;
   else
       nnew=n_old+1;
   end
   
   %tnew and nnew are the new time and population and will be returned.
end
