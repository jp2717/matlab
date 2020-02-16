%%----- Training 5 -----%%

%Part 1a
clear all; clc; close all;


%Initialise constants
k = 3/16; h = 0.01; x0 = 6; sigma = 0.2;
t = [0:h:10];

x = zeros(1001, 20);    %initialises x vector with zeros so that values can be assigned

%Creating 20 random functions and plotting them, while storing the data in
%one multidimensional array 

figure(1); hold on;
for i = 1:20
    
    x(:, i) = euler_stoc(h, k, x0, sigma, 10);
    plot(t, x(:, i));
    
end

title('Stochastic Curve Plots'); xlabel('Time(s)'); ylabel('x(t)');
hold off;


%Part 1b

%deterministic solution
x_det = euler_stoc(h, k, x0, 0, 10);

%Mean value from stochastic solutions
x_mean = zeros(1001, 1);
x_holder = 0;

for i = 1:1001
    
    for j = 1:20
        
        x_holder = x_holder + x(i, j);  %summing of arrays to compute mean
    
    end
    
    x_mean(i, 1) = x_holder/20;
    x_holder = 0;
    
end

mse1 = sum((x_mean-x_det).^2)/length(x_det);



%Part 2a

clear all; clc; close all;
% initialising new variables
x0 = 0; sigma = 0.1; h = 0.01; t = [0:h:100]; k = 3/16;
x = euler_stoc(h, k, x0, sigma, 100);
%figure(2); plot(t, x);

histogram(x);   % Plotting first histogram
mean1 = mean(x)
st1 = std(x)
%Creating second histogram content

x1 = euler_stoc(h, k, x0, 5, 100);
mean2  = mean(x1)
histogram(x1);
st2 = std(x1)

