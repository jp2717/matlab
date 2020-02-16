%% --Modelling Section 1: Task 1--%%

clear all;
clc;

%% Part 1:

T = [0 0.5 10/11 0 0; ...       % Transition Matrix
    0.5 0 0 0 0; ...
    0.5 0 0 0 0; ...
    0 0.5 0 1 0; ...
    0 0 1/11 0 1];

init = [1 0 0 0 0]';        % Initial condition starting at state E for sure

correct_probs = 0;

%% Calculating the time evolution of the distribution

for i = 1:1000
    
    init = T*init;
    correct_probs = [correct_probs init(4)];
    
end

%plotting the evolution
t = [0:1000];
figure(1);plot(t,correct_probs);


%% Part 2:

p = [];

for i = 1:1000      % changing transition matrix
            
    T = [0 0.5 (i/(i+1)) 0 0; ...       % Transition Matrix
    0.5 0 0 0 0; ...
    0.5 0 0 0 0; ...
    0 0.5 0 1 0; ...
    0 0 (1/(i+1)) 0 1];

    init = [1 0 0 0 0]';

    for j = 1:1000    % Evolving probability matrix
        init = T*init;
        
    end
    p = [p init(4)];
    
end

%Plotting answer
figure(2);plot(log([1:1000]), log(p)); xlabel('Ratio of substrate koff to incorrect koff'); ylabel('Fraction of correctly incorporated substrates');
