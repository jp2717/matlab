%%Sampling testing for theory conceptualization

t = [-100:0.01:100];
fs = 100;
delta = [];

%Initialising the delta train
for i = 1:length(t)
    if rem(i,1000) == 0
        delta = [delta 1];
    else
        delta = [delta 0];
    end
end

%Plotting time-domain delta train
figure(1); plot(t, delta); xlabel('time(s)'); ylabel('delta train');
title('Time-Domain Delta Train');

%Calculating the discrete fourier transform of the delta train 
delta_dft = abs(fft(delta));
f_ax = [-100:100];
figure(2); plot(t, delta_dft);
