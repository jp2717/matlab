% I'm only going to do ten dice rolls, so only need to consider p up to 60
%First define the 61x61 stochastic matrix. There is a 1/6 probability of hopping
%to any of the six numbers immediately above your current score in each
%step. Below I create T by filling in the 6 diagonals immediately below the
%main diagonal of the matrix with 1/6, one by one.
v=ones(60,1);
v=(1/6)*v;
T=diag(v,-1);
v(1)=[];
T=T+diag(v,-2);
v(1)=[];
T=T+diag(v,-3);
v(1)=[];
T=T+diag(v,-4);
v(1)=[];
T=T+diag(v,-5);
v(1)=[];
T=T+diag(v,-6);

%define and initialize the p vector. Note that p(n) actually corresponds to
%the probability of score n-1, since the game starts from 0 but Matlab
%indexing from 1.
p=zeros(61,1);
state_vector=zeros(61,1); % define a vector to carry the actual score corresponding to each state (ie., index-1).
for i=1:61
    state_vector(i)=i-1;
end
p(1)=1;
bar(state_vector,p,0.6); %plot the current state
xlabel('score');
ylabel('p(score)');
set(gca,'fontsize',20)
hold on
pause(5); %pause so it can be seen
for n=1:10
    p=T*p;  %update the state
    bar(state_vector,p,0.6); %plot the current state
    pause(4); %pause so plot can be seen
end
hold off

%% Now I will generate 50 random trajectories
rng(0,'twister'); %seed random number generator
t_vector=zeros(11,1); % define a vector to carry the actual time corresponding to each state (ie., index-1).
for i=1:11
    t_vector(i)=i-1;
end

state=zeros(11,1); 
    for i=2:11
        state(i)=state(i-1)+randi([1 6]); %add arandom dice roll to the total
    end
    plot(t_vector, state); %plot sample trajectory
    xlabel('rolls');
    ylabel('score');
      set(gca,'fontsize',20)
    pause(6);
    hold on
    
for i=1:49 % loop over 100 trajectories
    state=zeros(11,1); 
    for i=2:11
        state(i)=state(i-1)+randi([1 6]); %add arandom dice roll to the total
    end
    plot(t_vector, state); %plot sample trajectory
    pause(1);
end
hold off