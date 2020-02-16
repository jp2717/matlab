function x_out = euler_mine(h, k, x_in)
%Applies the Euler Numerical Method for this specific function
   
    l = length(x_in);
    x_temp = x_in;
    x_temp(l + 1) = x_temp(l) * (1 - k*h);
   
    if l < (10/h)+1
        x_out = euler_mine(h, k, x_temp);
    else
        x_out = x_in;
    end
    
end