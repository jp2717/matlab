%% Gillipsie Sim: Written by yours truly %%

%This part of the code defines everything, 
%and sets the initial condition. 
close all; clear all;

T=10;%total time
t=0;%current time

n=0; %  Number of base pairs formed, starting at unbound

tracker=[t,n]; %array that will keep track of the population over time

%% This part of the code repeatedly calls a function that updates the 
%state and time using random variables

while t<T
    %Different rates depending on what state you are currently in
   if n == 0
       rtot = 
   end
    [t,n]=updating(lambda, mu, n,t);
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