close all
clear all
fclose('all')
load('Signals_EMG.mat'); % Loading the recorded EMGs (two channels)
n_step = 100; % Number of steps in the loop for optimal alignment
stepCount = 0.2; % Size of the step of non-integer delay applied to one of the signals for alignment
ied=24; % Interelectrode distance of the recordings in mm
Fs = 2048; % Recording sampling frequency
Ts = 1/Fs; % Sampling interval
 
% Downsampling by an integer
M = 1; % Downsampling factor
channel1 = channel1(1:M:end); % Downsampling first channel
channel2 = channel2(1:M:end); % Downsampling second channel
Fs=Fs/M;
Ts=Ts*M;
% End downsampling
 
timeAxis=[1:length(channel1)].*Ts.*1000; % Definition of time axis in ms
freqAxis=fftshift([-0.5:1/(length(channel1)):0.5-1/(length(channel1))]); % Definition of discrete frequency axis
 
figure(1);plot(timeAxis,channel1,'k');hold on; plot(timeAxis,channel2-1000,'k'); % Plot of the two recordings after down-sampling
xlabel('Time (ms)')
ylabel('Signals (AU)')
 
channel1_ft = fft(channel1); % Fourier transform of the first channel
 
figure(2)
for uu = 1 : n_step
    channel1_dt = (channel1_ft).*exp(-i*2*pi*stepCount*uu*freqAxis); % complex exponential multiplication (delay in frequency domain)
    channel1_dt = real(ifft((channel1_dt))); % inverse transform to go back to the time domain 
    plot(timeAxis,channel1_dt,'r'); % Plot of the time-shifted signal
    hold on
    plot(timeAxis,channel2,'k');
    uu;
    MSE_vect(uu)= sum((channel1_dt - channel2).^ 2)./sum(channel2.^ 2).*100; % normalized mean square error between aligned signals
    delay(uu) = stepCount*uu; % Imposed delay in samples
end;
hold off
xlabel('Time (ms)')
ylabel('Signal amplitude (AU)')
 
% Identification of the optimal delay (minimum mean square error)
[MSEopt, optDelay] = min(MSE_vect);

% Plot of optimal alignment
% Part 1
channel1_opt = (channel1_ft).*exp(-i*2*pi*delay(optDelay)*freqAxis); % complex exponential multiplication (delay in frequency domain)
channel1_opt = real(ifft((channel1_opt))); % inverse transform to go back to the time domain
figure(3); plot(timeAxis,channel1_opt,'k'); hold on; plot(timeAxis,channel2,'r');
xlabel('Time (ms)')
ylabel('Signal amplitude (AU)')

%Part 2

delay_m = double.empty;
MSE_m = double.empty;

%initialising channel arrays
channel11 = channel1;
channel12 = channel1(1:2:end);
channel14 = channel1(1:4:end);
channel18 = channel1(1:8:end);

channel21 = channel2;
channel22 = channel2(1:2:end);
channel24 = channel2(1:4:end);
channel28 = channel2(1:8:end);

%M = 1
M=1;
while M<=8
    %resetting all variables to be used
    clear channel1_dt2; clear channel1; clear channel2;
    clear delay2; clear MSE_vect2; clear channel1_ft; clear freqAxis;
    clear MSE_opt; clear optDelay;
    
    switch M
        case 1
            channel1 = channel11; channel2 = channel21;
        case 2
            channel1 = channel12; channel2 = channel22;
        case 4
            channel1 = channel14; channel2 = channel24;
        case 8
            channel1 = channel18; channel2 = channel28;
    end;
    %i = log ( 2 * M ) / log (2);    %linear iterator in comparison to exponential
    
    Fs1 = Fs / M; Ts1 = Ts * M;
    channel1_ft = fft(channel1);
    freqAxis=fftshift([-0.5:1/(length(channel1)):0.5-1/(length(channel1))]);
    
    
    %inner loop
    for uu = 1 : n_step
        channel1_dt2 = (channel1_ft).*exp(-i*2*pi*stepCount*uu*freqAxis); 
        channel1_dt2 = real(ifft((channel1_dt2)));
        MSE_vect2(uu)= sum((channel1_dt2 - (channel2)).^ 2)./sum((channel2).^ 2).*100;
        delay2(uu) = stepCount*uu; 
    end;
    
    %plot(delay2*1000*Ts, MSE_vect2);
    delay_m = [delay_m; delay2];     %matrix where each row represents one value of M respectively
    MSE_m = [MSE_m; MSE_vect2];
    
    fprintf('The value of M is %d \n', M);
    [MSEopt, optDelay] = min(MSE_vect2);
    delay2(optDelay)*Ts1*1000
    ied/(delay2(optDelay)*Ts1*1000)
    MSEopt

M = M * 2;
end

%Plotting final curve
figure(4); hold on;
plot(delay_m(1, :)*1000*(Ts), MSE_m(1, :)); plot(delay_m(2, :)*1000*(Ts*2), MSE_m(2, :));
plot(delay_m(3, :)*1000*(Ts*4), MSE_m(3, :)); plot(delay_m(4,1:55)*1000*Ts*8, MSE_m(4, 1:55));
hold off;

xlabel('Delay(ms)'); ylabel('Estimated Error (%)');
title('The effect changing the delay on the estimated error for different downsampling factors');
legend({'M = 1', 'M = 2', 'M = 4', 'M = 8'},'Location','southeast')


% Delay and conduction velocity estimate
% fprintf('The optimal delay is %2.2f ms \n',delay(optDelay)*Ts*1000);
% fprintf('The estimated conduction velocity is %2.2f m/s \n',ied/(delay(optDelay)*Ts*1000));
% fprintf('Optimal MSE between signals: %2.2f %%\n',MSEopt);
