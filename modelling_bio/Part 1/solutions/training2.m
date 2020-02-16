%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Modelling in Biology MATLAB Training excercise 2
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Excercise 1: Euler's Method. k=0.25, h=0.01, x(0)=5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Parameters:
k=0.25;
h1=0.01;

%Define time span [0,10] with time step h1
t1=[0:h1:10]; 

%initial condition:
xE1(1)=5;

%Euler's Method implementation:

for i=1:length(t1)-1 
    xE1(i+1)=xE1(i)+h1*(-k*xE1(i));  %will calculate xE1(2:lenght(t1))
end

%Analitical solution
xA1=xE1(1)*exp(-k*t1);  %analitical solutionv h=0.01

%Mean Squared Error
MSE1=mean((xE1-xA1).^2)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Excercise 2: Euler's Method. k=0.25, h=0.001, x(0)=5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Euler Method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Parameters:

k=0.25;
h2=0.001;


%Define time span [0,10] with time step h2
t2=[0:h2:10]; 

%initial condition:

xE2(1)=5;

for i=1:length(t2)-1  %index must be integer
    xE2(i+1)=xE2(i)+h2*(-k*xE2(i));  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Analitical solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xA2=xE2(1)*exp(-k*t2);  %analitical solution h=0.01

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mean Squared Error
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MSE2=mean((xE2-xA2).^2)




