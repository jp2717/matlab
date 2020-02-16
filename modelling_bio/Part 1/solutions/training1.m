% Training exercise 1
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

% It is generally a good idea to define constants (or parameters) at the
% beginning of your source file, and refer to them by their names
% afterwards.
k = 0.6;
boundaries = [0 10];
initial_value = 4;

% -------------------------------------------------------------------------
% Question 1
% Our goal is to numerically integrate dx/dt = -k*x.
% We start by writing a function which returns dx/dt for any value of x, 
% and any value of the parameter k. The function is defined in a separate 
% file named training1.numerical.m. Matlab's ode45 method is used to 
% numerically integrate differential equations of the type dx/dt = f(t,x). 

[T numerical_solution_values] = ode45(@training1numerical, boundaries, initial_value);

% You can also use an alternative solution where you pass k as a parameter 
% in the ode45 function. Then you should also modify the
% training1numerical.m file to accept k as parameter. 
% [T numerical_solution_values] = ode45(@(t,x) training1numerical(t,x,k), boundaries, initial_value);

% Now, T contains the successive integration times, and Y the values at
% these times. We can plot the solution :
figure('Name','Training exercise 1') 
subplot(3,1,1) % Divides the figure into 3 regions. 
plot(T,numerical_solution_values);
xlabel('Time')
ylabel('x')
legend('Numerical solution');
title('Question 1')

% -------------------------------------------------------------------------
% Question 2
% The analytical solution to this equation is given in the lecture notes:
% x = exp(-k*x);

% We can also find it using Matlab's dsolve method. t is implicitly taken
% as the independent variable.
analytical_solution = dsolve('Dx = -k*x','x(0)=initial_value');

% The analytical solution contains a symbolic representation of the solution.
% In order to find its numerical values (to plot it, for instance) we need
% to evaluate it on a set of points. We can use the points returned by
% ode45 to do this.
t = T;

% The eval function evaluates the symbolic expression given as its
% arguments on the points contained in t.
analytical_solution_values = eval(analytical_solution);

% And plot it ...
subplot(3,1,2)
title('Question 2')
plot(T, analytical_solution_values, 'r','LineWidth',2);
hold on
plot(T,numerical_solution_values,'b--','LineWidth',2)
xlabel('Time')
ylabel('x')
legend('Analytical solution', 'Numerical solution');
title('Question 2')

% We can calculate the mean square error easily and print it. Instead of
% using "display", we could also omit the ; at the end, but it triggers a
% warning.
mean_square_error = mean((numerical_solution_values-analytical_solution_values).^2);
display(mean_square_error); 

% -------------------------------------------------------------------------
% Question 3
% We calculate timesteps chosen by ode45  by substracting two consecutive
% elements of T.
timesteps = T(2:end) - T(1:end-1);

% ... and plot them as a function of T. Note that "timesteps" has one less
% element than T, hence the T(2:end).
subplot(3,1,3)
plot(T(2:end),timesteps, 'bx');
xlabel('Time')
ylabel('Timestep')
title('Question 3')



