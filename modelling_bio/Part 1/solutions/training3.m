function training3
clear all; clc; close all;

% Variable declarations
k =  3/16; 
h = 0.01; 
x0 = 6;
t = 0:h:10;
s =0.2;

% ---------------------------------------------------------------------------------------------
% 1. (a)
figure(1);
hold all
for i = 1:20               % Repeat 20 times
    [x,t] = g(x0,t,s,h,k); % Generate the trajectory.
    plot(t,x);             % Plot the trajectory.
    trajectories(i,:) = x; % Store the trajectory.
end
hold off
xlabel('Time'); ylabel('x'); title('1.(a)'); % Figure labelling.

% ---------------------------------------------------------------------------------------------
% 1. (b)

xmean = sum(trajectories)/length(trajectories(:,1));    % Compute the mean trajectory.
[x,~] = g(x0,t,0,h,k);            % Compute the deterministic trajectory (approximately).
MSE = sum((x-xmean).^2)/length(x) % Compute the mean squared error between the above two.

% ---------------------------------------------------------------------------------------------
% 2. (a)
% Variable declarations
clear all;
k =  3/16; 
h = 0.01; 
x0 = 0;
t = 0:h:200;                % lets say 200
s =0.1;

for i = 1:2000
    [x,~] = g(0,t,0.1,h,k); % Generate a single trajectory.
    xf(i) = x(length(x));   % Store final value (x(T)) of the trajectory.
end

figure(2);
hist(xf,40);   % Generate the histogram -- using 40 bins.
xlabel('x(T)'); ylabel('Frequency'); title('2. (a)--sigma = 0.1'); % Figure labelling.

mu_2a = mean(xf) % Estimate the mean using the sample mean--see, https://en.wikipedia.org/wiki/Sample_mean_and_sample_covariance.
standev_2a = std(xf) % Estimate the standard deviation using the sample standard deviation--https://en.wikipedia.org/wiki/Unbiased_estimation_of_standard_deviation#Background.
clear xf

% ---------------------------------------------------------------------------------------------
% 2. (a)
s =5; % change sigma to 5
for i = 1:2000
    [x,~] = g(0,t,s,h,k);
    xf(i) = x(length(x));
end

figure(3);
hist(xf,40);
xlabel('x(T)'); ylabel('Frequency'); title('2. (b)--sigma = 5'); % Figure labelling.

mu_2b = mean(xf)
standev_2b = std(xf)

% ---------------------------------------------------------------------------------------------
% 2. (c): The required means and standard deviations were already estimated above.
end

function [x,t] = g(x0,t,s,h,k)
    % x: array containing complete trajectory, 
    % t: array containing corresponding time points.
    % x0: Initial condition, t: time range, s: sigma.

    x = x0;                 % Starting point
    for i = 2:length(t)     % Calculate next point
        x(i) = x(i-1)- h *(k) * x(i-1)+ s * sqrt(h) * randn(1);
    end
end 