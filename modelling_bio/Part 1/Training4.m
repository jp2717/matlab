%%----- Training 4 ------%%

clear all; clc;

%Part 1

x0 = [1 2];     %Initial condition

%Returns appropriately sized solution, with x(1) being x(t) and x(2) being
%y(t)

[t x] = ode45('ode_fun4', [0:0.01:200], x0);

figure(1); hold on;
plot(t, x(:,1)); plot(t, x(:,2));
title('Concentration Over Time'); xlabel('Time'); ylabel('Concentration');
hold off;

%Part 2

%Computed nullclines when the respective xdot(i) are 0:

%Setting the desired parameters
alpha = 1; beta = 1; gamma = 0.3; 

%First Nullcline
yp1 = [0:0.01:10];
xp1 = alpha./gamma./(1 + yp1.^4);

%Second Nullcline
xp2 = [0:0.01:10];
yp2 = beta./gamma./(1 + xp2.^4);

figure(2); hold on;
plot(xp1,yp1,'r','linewidth',2),
plot(xp2,yp2,'b','linewidth',2);
plot(x(:,1),x(:,2),'k')
plot(x(1,1),x(1,2),'ko')
hold off;

%Part 3

clear t; clear x; clear x0;

%New initial conditions
x0 = [2 1];

[t x] = ode45('ode_fun4', [0:0.01:200], x0);

figure(3); hold on;
plot(xp1,yp1,'r','linewidth',2);
plot(xp2,yp2,'b','linewidth',2);
plot(x(:,1),x(:,2),'k');
plot(x(1,1),x(1,2),'ko');
hold off;


%Part 4

figure(4);
hold on;
time_matrix = zeros(20001, 20);   %contains all solutions
x_matrix = zeros(20001, 20, 2); 
plot(xp1,yp1,'linewidth',2);
plot(xp2,yp2,'linewidth',2);
for i = 1:20
    x0 = 5*abs([ randn(1) randn(1)]);
    [time_matrix(:, i) x_matrix(:, i, :)] = ode45('ode_fun4', [0:0.01:200], x0);
    plot(x_matrix(:, i, 1),x_matrix(:, i, 2), 'k');
    plot(x_matrix(1, i, 1),x_matrix(1, i, 2), 'ko');
end
hold off;


%Part 5

%Setting the desired parameters
alpha = 0.4; beta = 1;

%First Nullcline
yp1 = [0:0.01:10];
xp1 = alpha./gamma./(1 + yp1.^4);

%Second Nullcline
xp2 = [0:0.01:10];
yp2 = beta./gamma./(1 + xp2.^4);

clear x_matrix; clear t_matrix;
figure(5);
hold on;
time_matrix = zeros(20001, 20);   %contains all solutions
x_matrix = zeros(20001, 20, 2); 
plot(xp1,yp1,'linewidth',2);
plot(xp2,yp2,'linewidth',2);
for i = 1:20
    x0 = 5*abs([ randn(1) randn(1)]);
    [time_matrix(:, i) x_matrix(:, i, :)] = ode45('ode_fun4', [0:0.01:200], x0);
    plot(x_matrix(:, i, 1),x_matrix(:, i, 2), 'k');
    plot(x_matrix(1, i, 1),x_matrix(1, i, 2), 'ko');
end
hold off;





