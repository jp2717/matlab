%% Gillipsie Sim: Written by yours truly %%

%This part of the code defines everything, 
%and sets the initial condition. 
close all; clear all;

T=10;%total time
t=0;%current time
n=2; %  Number of base pairs formed, starting at unbound

%Different rates
k_on = 0.1;
k_off = 1000;
k_unzip = 1000;
k_zip = 10000;

tracker=[t,n]; %array that will keep track of the population over time

%% This part of the code repeatedly calls a function that updates the 
%state and time using random variables

while t<T
    %Different rates depending on what state you are currently in
   if n == 0
       [t,n] = updating(0,k_on,t,n);
   elseif n == 1
       [t,n] = updating(k_off, k_zip, t, n);
   elseif n > 1 && n < 6
       [t,n] = updating(k_unzip, k_zip, t, n);
   elseif n == 6
       [t,n] = updating(k_unzip, 0, t, n);
   end
   
    tracker=[tracker; t,n]; %update array keeping track
end

%% 
%plot number of base pairs against time 
hold off
plot(tracker(:,1),tracker(:,2));xlabel('Time steps (t)'); ylabel('Number of base pairs (n)');
set(gca, 'FontSize', 20);

%Gillepsie estimation from trajectory of probability of being bound (take
%time taken for estimating probability
%Time differences must be found

bound_t = [];
all_t = [];
for i = length(tracker(:,1)):-1:1
    if i > 1
        all_t = [all_t (tracker(i,1)-tracker(i-1,1))];
    
        if tracker(i-1,2) == 0  %Time is shown one step after the current state
            bound_t = [bound_t 0];
        else 
            bound_t = [bound_t (tracker(i,1)-tracker(i-1,1))];
        
        end
    else
        all_t = [all_t tracker(1,1)];
        bound_t = [bound_t tracker(1,1)];
    end
        
end

gil_prob = sum(bound_t)/sum(all_t);

%Over ten different trajectories, the probability average is given below
gil_probs = mean([0.8674 0.8368 0.7481 0.6827 0.7487]);
gil_ratio = gil_probs/(1-gil_probs);

%Considering detailed balance and stationary distributions (all over state 0)
t_ratio = k_on/k_off *((k_zip/k_unzip) + (k_zip/k_unzip)^2 + (k_zip/k_unzip)^3 ...
    + (k_zip/k_unzip)^4 + (k_zip/k_unzip)^5);
