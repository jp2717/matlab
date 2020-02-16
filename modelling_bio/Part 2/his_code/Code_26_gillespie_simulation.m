%% code to simulate a birth-death process. 
%This part of the code defines everything, 
%and sets the initial condition. 
close all; clear all;

T=10;%total time
t=0;%current time

n=20;%initial population

lambda =0.42; %birth rate
mu=0.38; %death rate

tracker=[t,n]; %array that will keep track of the population over time

%% This part of the code repeatedly calls a function that updates the 
%state and time using random variables

while t<T
    %pass the current state of the system (and underlying parameters)
    %to a function that samples an update
    [t,n]=update_time_and_pop(lambda, mu, n,t);
    tracker=[tracker; t,n]; %update array keeping track
    if n==0
        %handle the condition of the population going to zero.
        break;
    end
end
%% 
%plot population against time 
hold off
plot(tracker(:,1),tracker(:,2)); 
set(gca, 'FontSize', 20);