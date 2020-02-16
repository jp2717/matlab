%% ----- Training 2 ----- %%

clear all;
close all;
clc;

%Part 1

x0 = [ 5 ]; %initial condition
h = 0.01; %increment
k = 0.25; %parameter, where the x' = -kx

t = [0:h:10]';
t_second = [0:h * 0.1:10]';
x = euler_mine(h, k, x0)';

%Analytical Solution
syms x1(t1)
Dx1 = diff(x1);
x1 = dsolve(diff(x1) == -k * x1, x1(0) == x0);

%retrieving output matrix from expression
x1_out = zeros(1001, 1);

for i = 0:1000
    
    %attaining array representation of equation
    t1 = t(i+1, 1);
    x1_out(i+1, 1) = subs(x1);
    
end

%Doing the same for the larger array
x2_out = zeros(10001, 1);
for i = 0:10000
    
    %attaining array representation of equation
    t2 = t_second(i+1, 1);
    x2_out(i+1, 1) = subs(x1);
    
end


%Plotting solutions
figure(1); hold on;
plot(t, x, 'r'); title('Numerical Method Solution'); xlabel('t'); ylabel('x(t)');
plot(t, x1_out, 'k'); hold off;

mse_1 = sum((x-x1_out).^2)/length(x)

%Part 2

x2 = euler_mine(h * 0.1, k, x0)';
mse_2 = sum((x2-x2_out).^2)/length(x2)



