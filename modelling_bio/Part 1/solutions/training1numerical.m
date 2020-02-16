function dxdt = training1numerical(t,x)
% Change to function dxdt = training1numerical(t,x,k) if you use the
% alternative solution where you pass k as a parameter
k = 0.6;
dxdt = - k * x;