function xdot = ode_fun4(t, x)
%Sets ups desired function to be solved by the ode45 function

%Setting the desired parameters
alpha = 1; beta = 1; gamma = 0.3; 

%Setting ODEs, where x = x1 and y = x2
xdot(1)= (alpha / (1 + (x(2)^4) ) ) - ( gamma * x(1) );
xdot(2) = (beta / (1 + (x(1)^4) ) ) - ( gamma * x(2) );

%Transposing matrix to return a collumn matrix
xdot = xdot';

end

