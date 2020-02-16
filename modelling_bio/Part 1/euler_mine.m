function x_out = euler_mine(h, k, x_in)
%Applies the Euler Numerical Method for this specific function
   
    l = length(x_in);
    next = x_in(l) * (1 - k*h);
    if length(x_in) <= 11000
        x_temp = [x_in; next];
        x_out = euler_mine(h, k, x_temp);
    end
    
    
end