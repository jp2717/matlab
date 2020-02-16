function filtered_signal = freq_filter(signal,freq_axis_Hz,lower,upper)
%freq_filter takes in a signal and filters it

%copying original signal in order to edit it 
filtered_signal = signal;
t = freq_axis_Hz(2)-freq_axis_Hz(1); %The same as the sampling period
for i = 1:length(signal)
    
    if (freq_axis_Hz(i) <= lower) || (freq_axis_Hz(i) >= upper)
        filtered_signal(i) = 0;
    end
    
end

end

