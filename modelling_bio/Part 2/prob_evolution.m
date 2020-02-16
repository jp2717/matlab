function p_evolution = prob_evolution(T,p_init,time)
%prob_evolution(T,p_init,time)
%   Takes as an input a transition matrix, an initial probability
%   distribution and the amount of steps takes in a time
%   evolution. It outputs the probability evolution over time of size
%   timex1
    pn1 = zeros(time,length(T));
    for i = 1:time
        %updating matrices
        p_init = T*p_init;
        p_evolution(i,:) = p_init;
   
    end
end

