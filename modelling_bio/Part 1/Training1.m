%%-----Training 1------%%

%Part 1
clear all;
close all;
clc;
x0 = 4; %initial condition
k = 0.6;    %parameter
[t x] = ode45('ode45_ode', [0 10], x0);
figure(1),hold on;
plot(t, x, 'k'); title('Solution to ODE');

%Part 2
syms x1(t1)
Dx1 = diff(x1);
x1 = dsolve(diff(x1) == -k * x1, x1(0) == x0)

%retrieving output matrix from expression
x1_out = zeros(45, 1);
factor = (10/45);

for i = 0:44
    
    %attaining array representation of equation
    t1 = t(i+1, 1);
    x1_out(i+1, 1) = subs(x1);
    
end
plot(t, x1_out, 'r');
hold off;

%Mean Squared Error
mse = sum((x-x1_out).^2)/45;

%Part 3

t_real = [0:10/44:10]';
figure(2), plot(t_real, t);
