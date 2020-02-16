function x_out = euler_stoc(h, k, x_in, sigma, t_max)
%Applies the Euler Numerical Method for this specific function
% It also assumes it starts from t = 0
  
    l = length(x_in);
    next = x_in(l) * (1 - k*h) + sigma*(h^0.5)*randn(1);
    
    if length(x_in) <= ((t_max)/h)
    
        x_temp = [x_in; next];
        x_out = euler_stoc(h, k, x_temp, sigma, t_max);
        
    else
        
        x_out = x_in;
        
    end
    
    
end