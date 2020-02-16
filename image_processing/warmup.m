%%%-- Warm-up --%%%

%% Question 1 %%
v_even = [32:2:74];

%% Question 2 %%
x = [1 7 2 3];
x1 = x + 15;    %a
x2 = x + 2*[0 1 0 1]; %b
x3 = x.^(0.5);  %c
x4 = x.^(3);    %d

%% Question 3 %%
v1 = [3 2 6 8]';    %'x'
v2 = [4 1 3 5]';    %'y'

v3 = v2 + sum(v1);  %a
v4 = v1.^v2;        %b
v5 = v2./v1;        %c
v6 = v1.*v2;        %d
v7 = sum(v6);       %e
v8 = v1'*v2 - v7;        %f just some good old-fashioned matrix multiplication

%% Question 4 %%
p1 = 2/2*3;  %a
p2 = 6 - 2/5 + 7^2 - 1; %b
p3 = 3^2/4; %c
p4 = 3^2^2; %d
p5 = 2 + round(6/9 + 3*2)/2 - 3;    %e
p6 = 2 + floor(6/9 + 3*2)/2 - 3;     %f
p7 = 2 + ceil(6/9 + 3*2)/2 - 3;        %g

%% Question 5 %%
t1 = [2:2:20];
t2 = [10:-2:-4];
t3 = ones(1,20)./[1:20];
t4 = [0:19]./[1:20];

%% Question 6 %%
answer = sum(((ones(1, 100).*(-1)).^[2:101])./[1:2:199]);

%% Question 7 %%    examples of struct actions
K=struct('FirstName','Brad','Surname','Pitt','Age',40);
disp(K)
K.Age = K.Age + 1;
disp(K)

%% Question 8 %% You can make arrays of different structs (must have similar fields)
K.FirstName;

L=struct('FirstName','Angelina','Surname','Jolie','Age',28);
disp(L);
Contacts(1) = K;
Contacts(2) = L;

%% Question 9 %% Functions I know how to make

%% Question 10 %%
clear all;
x = zeros(16);      %%16 x 16 array
[M,N] = size(x);
n_dimensions = ndims(x);        %%number of array dimensions

%% Question 11 %% Logical operations revised

%% Question 12 %%
 clear all; % This clears all variables
 X = magic(5);
 Y = X > 5




