%Second order ODE system. (Optional, if you have time)
clear all
close all

% Define parameters
param       = [0 0.03 7]; %Parameter eta vector
y0          = [2 10]; %Initial condition
opt = odeset('AbsTol',1e-6,'RelTol',1e-3,'MaxStep',0.5);

% Initialize variables for calling ODE solver
t       = 0:0.01:100;
y_vec   = zeros(size(t,2),3); % Initialize variables y and ydot vector
dy_vec  = zeros(size(t,2),3); % (for the three eta values)

% Call ODE solver for each of the 3 values of the parameter eta
for k = 1:3
[t,y] = ode45(@(t,x) odefunT5(t,x,param(k)), t, y0, opt);
% Store the output in the two vectors y and ydot
y_vec(:,k) = y(:,1);
dy_vec(:,k) = y(:,2);
end

% Plot overlaid trayectories y(t) as a function of time.
% for each parameter eta value.
figure1 = figure('Color',[1 1 1]);
plot(t,y_vec,'LineWidth',1.5);
xlabel('t','Interpreter','latex')
ylabel('y(t)','Interpreter','latex')
title('y(t) vs. t','Interpreter','latex')
legend1 = legend('$$\eta=0$$','$$\eta=0.003$$','$$\eta=7$$','Location','NorthEast');
set(legend1,'Interpreter','latex');
axis([0 100 -15 22]);

% Printing the figure in a pdf image file for future use.
W=20;
H=14;
set(gcf,'units','centimeters');
set(gcf,'papersize',[W H]);
set(gcf,'paperposition',[0,0,W,H]);
print -dpdf -painters -r300 'MiB_cw5_time_evolution.pdf'; %djpg

% Plot overlaid trayectories y(t) as a function of time.
% for each parameter eta value.
figure2 = figure('Color',[1 1 1]);
plot(y_vec,dy_vec,'LineWidth',1.5);
xlabel('$$y(t)$$','Interpreter','latex')
ylabel('$$\dot{y}(t)$$','Interpreter','latex')
legend1 = legend('$$\eta=0$$','$$\eta=0.003$$','$$\eta=7$$','Location','NorthEast');
title('Phase plane','Interpreter','latex')
set(legend1,'Interpreter','latex');

% Printing the figure in a png image file for future use.
W=20;
H=14;
set(gcf,'units','centimeters');
set(gcf,'papersize',[W H]);
set(gcf,'paperposition',[0,0,W,H]);
print -dpng -painters -r300 'MiB_cw5_phaseplane.png'; %djpg
