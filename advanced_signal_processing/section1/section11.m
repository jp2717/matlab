%% Advanced Signal Processing %%

close all; clear all; clc;

%% 1.1 Statistical Elimination %%

% 1000-sample realisation of a stationary stochastic process
X = rand( [1000,1] );

figure(1); plot([1:1000]',X); xlabel('Sample number (n)'); ylabel('Amplitude(AU)');
title('Uniform Distribution Samples');

% TASK 1

%Analytically, as it is a uniform distribution from [0,1], the theorical
%mean at the centre due to symmetry, meaning the theoretical m = 0.5

% sample mean
m_hat = mean(X); %Relatively close to the theorical mean given 1000 samples

% TASK 2

% Analytically, as it is a uniform distribution from [0,1], the variance
% was calculated to be approx. 0.347

sigma_hat = std(X) %Varies by a similar quantity to the sample mean, very close to
%theorical value

% TASK 3
X_ten = rand( [1000,10] );

% Finding mean and stdev for 10 realisations
m_hat_ten = [];
sigma_hat_ten = [];
for i = 1:10
    
    m_hat_ten = [m_hat_ten mean(X_ten(:,i))];
    sigma_hat_ten = [sigma_hat_ten std(X_ten(:,i))];
    
    
end

% Plotting these estimates
realisations = [1:10];
figure(2);
hold on;
P1 = scatter(realisations, m_hat_ten);
plot(realisations, 0.5*ones(10),'-.*');
P2 = scatter(realisations, sigma_hat_ten);
plot(realisations, 0.289*ones(10),'-.*');
legend([P1, P2],'Sample mean','Sample standard deviation');
xlabel('Realisation Number(m)');
ylabel('Amplitude(AU)');
title('Variation of sample estimates');
hold off;
% Both seem relatively unbiased, as they all vary about the true
% (theoretical mean)


% TASK 4
bins = 1000;
figure(3);
hold on;
histogram(X,bins,'Normalization','pdf');  %normalised sample pdf
plot([0:1/bins:1],ones(bins+1)./range(X),'--'); %  theoretical pdf
title('Theoretical probability distribution vs histogram estimate');
ylabel('Probability Density'); xlabel('x[n]');
hold off

%As the number of samples in X increases, the pdf in the histogram
%converges to a uniform distribution


% TASK 5

clear all;

% 1000-sample realisation of a stationary stochastic process
X = randn( [1000,1] );

figure(4); plot([1:1000]',X); xlabel('Sample number (n)'); ylabel('Amplitude(AU)');
title('Normal Distribution Samples');

%Theoretical mean is m = 0
m_hat = mean(X) % sample mean

% Theoretical stdev = 1

sigma_hat = std(X) %Varies by a similar quantity to the sample mean, very close to
%theorical value
X_ten = randn( [1000,10] );

% Finding mean and stdev for 10 realisations
m_hat_ten = [];
sigma_hat_ten = [];
for i = 1:10
    
    m_hat_ten = [m_hat_ten mean(X_ten(:,i))];
    sigma_hat_ten = [sigma_hat_ten std(X_ten(:,i))];
    
    
end

% Plotting these estimates
realisations = [1:10];
figure(5);
hold on;
P1 = scatter(realisations, m_hat_ten);
plot(realisations, zeros(10),'-.*');
P2 = scatter(realisations, sigma_hat_ten);
plot(realisations, ones(10),'-.*');
legend([P1, P2],'Sample mean','Sample standard deviation');
xlabel('Realisation Number(m)');
ylabel('Amplitude(AU)');
title('Variation of sample estimates');
hold off;
% Both seem relatively unbiased, as they all vary about the true
% (theoretical mean)
figure(6);
hold on;
histogram(X,10,'Normalization','pdf'); %normalised sample pdf
plot([-4:0.008:4],normpdf([-4:0.008:4],0,1)); %  theoretical pdf
title('Theoretical probability distribution vs histogram estimate');
ylabel('Probability Density'); xlabel('x[n]');
hold off

%As the number of samples in X increases, the pdf in the histogram
%converges to a uniform distribution







