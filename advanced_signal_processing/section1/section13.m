%% Advanced Signal Processing %%

close all; clear all; clc;

%% 1.3 Estimation of Probability Distributions %%

%% TASK 1 %% 

% Testing my pdf function

v = randn(1,1000);
hold on;
figure(1);pdf(v,20); plot([-4:0.008:4],normpdf([-4:0.008:4],0,1),'r','--');   %Works relatively well
hold off

%% TASK 2 %%
v3 = rp3(1,10000);

figure(2);
bins = 20;
subplot(1,2,1)
pdf(v3,bins);
subplot(1,2,2)
range = [-1:0.01:2];
distance = max(range) - min(range);
plot(range,ones(length(range))/distance,'r'); title('True PDF'); axis([-1 2 0 0.4]);

%As the number of samples increases, the histogram converges more closely
%to the original pdf


%% TASK 3: Dealing with a non-stationary signal%%

non_stat_signal = [zeros(1,500) ones(1,500)] + randn(1,1000);
figure(3); pdf(non_stat_signal,20);

v2 = rp2(1000,1000);
figure(4); pdf(v2,20);

