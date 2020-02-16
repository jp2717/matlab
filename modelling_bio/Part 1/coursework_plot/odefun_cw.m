function xdot = odefun_cw(t,x,b)
%Function used to model last part of modelling in biology coursework
%   This will solve a non-linear 2nd order differential

a = 2;

xdot(1)= a + (x(1)*x(1))*x(2) - (b + 1)*x(1);
xdot(2) = b*x(1) - (x(1)*x(1)*x(2));

%Transposing matrix to return a collumn matrix
xdot = xdot';
end

