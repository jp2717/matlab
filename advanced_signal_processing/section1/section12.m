%% Advanced Signal Processing %%

close all; clear all; clc;

%% 1.2 Stochastic Process %%

% M is the number of realisations and N is the measure of time intervals

% TASK 1

% M = 100, N = 100. The following are MxN matrices
v1 = rp1(100,100);
v2 = rp2(100,100);
v3 = rp3(100,100);

%Loop to calculate ensemble mean and standard deviation for the above
%matrices
e_mean = zeros(100,3);
e_stdev = zeros(100,3);

for i = 1:100 
    e_mean(i,:) = [mean(v1(:,i)) mean(v2(:,i)) mean(v3(:,i))];
    e_stdev(i,:) = [std(v1(:,i)) std(v2(:,i)) std(v3(:,i))];
end
%time average of each
t_mean = [mean(e_mean(:,1)) mean(e_mean(:,2)) mean(e_mean(:,3))]
t_stdev = [mean(e_stdev(:,1)) mean(e_stdev(:,2)) mean(e_stdev(:,3))]

%Plotting results
figure(1); hold on; %mean
plot([1:100],e_mean(:,1));
plot([1:100],e_mean(:,2));
plot([1:100],e_mean(:,3));
legend('Signal 1','Signal 2','Signal 3');
xlabel('Time(N)'); ylabel('Ensemble Mean (AU)'); title('Ensemble Mean of Stochastic Processes');
hold off;

figure(2); hold on; %standard deviation
plot([1:100],e_stdev(:,1));
plot([1:100],e_stdev(:,2));
plot([1:100],e_stdev(:,3));
legend('Signal 1','Signal 2','Signal 3');
xlabel('Time(N)'); ylabel('Ensemble Standard Deviation (AU)'); title('Ensemble Standard Deviation of Stochastic Processes');
hold off;

%Despite some noise, all processes beside the first stochastic process seem
%to be approximately stationary


%Task 2

clear all;
% realisations(M) = 4, time steps(N) = 1000
v1 = rp1(4,1000);
v2 = rp2(4,1000);
v3 = rp3(4,1000);

%Loop to calculate ensemble mean and standard deviation for the above
%matrices
e_mean = zeros(1000,3);
e_stdev = zeros(1000,3);

for i = 1:1000
    e_mean(i,:) = [mean(v1(:,i)) mean(v2(:,i)) mean(v3(:,i))];
    e_stdev(i,:) = [std(v1(:,i)) std(v2(:,i)) std(v3(:,i))];
end

%Plotting results
figure(3); hold on; %mean
plot([1:1000],e_mean(:,1));
plot([1:1000],e_mean(:,2));
plot([1:1000],e_mean(:,3));
legend('Mean 1','Mean 2','Mean 3');
xlabel('Time(N)'); ylabel('Ensemble Mean (AU)'); title('Ensemble Mean of Stochastic Processes');
hold off;

figure(4); hold on; %standard deviation
plot([1:1000],e_stdev(:,1));
plot([1:1000],e_stdev(:,2));
plot([1:1000],e_stdev(:,3));
legend('Standard deviation 1','Standard deviation 2','Standard deviation 3');
xlabel('Time(N)'); ylabel('Ensemble Standard Deviation (AU)'); title('Ensemble Standard Deviation of Stochastic Processes');
hold off;

% Similar to the ensemble averages of the first section, the ensemble
% averages are constant over time, implying ergodicity for all but the first
% process
%figure(5); histogram(,100);