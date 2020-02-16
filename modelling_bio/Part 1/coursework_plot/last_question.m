%%----- Modelling in Biology Final Question ------%%
clear all; clc;

%Part 1

x0 = [1 2];     %Initial condition

%Returns appropriately sized solution, with x(1) being x(t) and x(2) being
%y(t)

b_matrix = [0:0.1:20];
y = zeros(201, 2);
acc1 = 0;
acc2 = 0;

%plotting bifurcation diagram varying b
for i = 1:201
    b = b_matrix(i);
    [t x] = ode45(@(t, x) odefun_cw(t,x, b), [0:1:20], x0);
    
    for j = 1:20
        acc1 = acc1 + x(length(x)-j, 1);
        acc2 = acc2 + x(length(x) - j, 2);
    end
    
    y(i, 1) = acc1/20;
    y(i, 2) = acc2/20;
    
    acc1 = 0;
    acc2 = 0;
    
end 

plot3(b_matrix', y(:,1), y(:,2));
axis equal
xlabel('b')
ylabel('x1')
zlabel('x2')

% figure(1); hold on;
% plot(t, x(:,1)); plot(t, x(:,2));
% title('states over time'); xlabel('Time'); ylabel('AU');
% hold off;

% 
% plot3(t, x(:,1), x(:,2)); 
% axis equal
% xlabel('t')
% ylabel('x1')
% zlabel('x2')
% 
% figure(3);
% plot(x(:,1), x(:,2)); xlabel('x1'); ylabel('x2');

