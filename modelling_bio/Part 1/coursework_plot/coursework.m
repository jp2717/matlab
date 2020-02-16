%%-----Modelling in Biology Coursework Plots-----%%

clear all; clc;

t = [0 20];
z0 = 1;
figure(1); hold on;
%Looping over various initial conditions (NOW OVER GAMMA INSTEAD TO FIND
%MAX)
for gamma = 0:0.1:1
    
    [t z] = ode45(@(t,z) z * (1 - gamma - z) , [0 20], z0); %Solving ODE
    plot(t, z*gamma);                   %Plotting solution
    
end
xlabel('tau'); ylabel('gamma*z'); title('gamma*z as gamma varies (0 to 1)'); hold off;
clear t; clear z;

%New gamma parameter value
gamma = 1.2;
figure(2); hold on;
%Looping over various initial conditions
for z0 = 0:0.1:1
    
    [t z] = ode45(@(t,z) z * (1 - gamma - z) , [0 20], z0); %Solving ODE
    plot(t, z);                   %Plotting solution
    
end
xlabel('tau'); ylabel('z'); title('ODE solution for gamma = 1.2'); hold off;