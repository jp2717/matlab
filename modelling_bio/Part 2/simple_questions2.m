%% MiB Chapter 2 practice questions

%% Question 2.1
% T = [0 0.5 0.8; 0.3 0.5 0; 0.7 0 0.2];  %transition matrix
% p1 = [0.4040 0.2425,0.3535]';   %If initial conditions are the same as the stationary distribution then it will remain there!
% 
% pn1 = zeros(100,3);
% for i = 1:100
%     %updating matrices
%     p1 = T*p1;
%     pn1(i,:) = p1;
%     
% end
% 
% hold on;
% figure(1);
% plot([1:100],pn1(:,1));    %Quite productive
% plot([1:100],pn1(:,2));    % Unproductive
% plot([1:100],pn1(:,3));    % Very productive
% legend('Q','U','V');
% hold off;

T = [0.5 0.05 0.09; 0.05 0.9 0.01; 0.45 0.05 0.9];  %transition matrix
p1 = [1 0 0]';   %If initial conditions are the same as the stationary distribution then it will remain there!
pn1 = prob_evolution(T,p1,100); % customized evolution function

hold on;
figure(1);
plot([1:100],pn1(:,1));    %Quite productive
plot([1:100],pn1(:,2));    % Unproductive
plot([1:100],pn1(:,3));    % Very productive
legend('E','L','R');
hold off;

% Generating a single sample trajectory
%varying between states 1,2,3
i = 2;
steps = 10000;    %number of desired steps
possible_next_states = [];  % To track where trajectory can go
trajectory_tracker = 2;
for j = 1:steps
    for n = 1:length(T)
        if(T(n,i) >0)
            possible_next_states = [possible_next_states; n, T(n,i)];   %Identifying where trajectory can go
        end
    end
    r = rand(); %randomly generated number(0-1)
    m = 0;
    
    for n = 1:length(possible_next_states)
        m = m + possible_next_states(n,2);
        if (m >= r)
            i = n;
            trajectory_tracker = [trajectory_tracker i];
            break;
        end
            
    end
    possible_next_states = [];  %resetting next possible states
    
end

figure(2); plot([1:steps],trajectory_tracker(1:steps)); xlabel('Number of steps');
ylabel('State'); axis([0 11 0 6]);
