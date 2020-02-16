% Clear working space
clear all
close all
clc
 
% Load required signals
load('MUAPs.mat'); % Single motor unit action potentials (experimental)
load('NeuralDrive.mat'); % Discharge times of motor neurons (experimental)
load('Torque.mat'); % Experimental Torque
fsamp = 2048; % Sampling frequency of the recordings
 
%% PART 1: Reconstructing the EMG signal through convolution of discharge times by MUAPs
n_MUAPs = size(MUAPs,1); % Number of MUAPs
dur_MUAPs = size(MUAPs,2); % Duration of MUAPs
dur_MUAPseq = size(Real_firing(1,:),2); % Duration of the signal
time_ax=[1/fsamp:1/fsamp:dur_MUAPseq/fsamp]; % Time axis for the signal
 
% Plot MUAP trains
figure(1),
for jj = 1:n_MUAPs 
    conv_train = conv(MUAPs(jj,:),Real_firing(jj,:)); % Convolution (see slide 14-15 of Lecture 2)
    MUAP_Train(jj,:) = conv_train(floor(dur_MUAPs/2)+1:end-floor(dur_MUAPs/2)); % Cut transitory portion
    hold on, plot(time_ax,MUAP_Train(jj,:)/(max(MUAPs(:)) - min(MUAPs(:))) + (n_MUAPs - jj + 1)*1.25,'k');
end
title('Sequence of MUAPs for each motor unit')
xlabel('Time (s)')
ylabel ('MUAP trains')


MUAP_sel = 1; % Select one MUAP (1 to 15) for Fourier analysis
% Plot Fourier Transform of the discharge timings 
figure(2)
f_transf_Firings = fft(Real_firing(MUAP_sel,:));
freq_ax = [-pi+pi/dur_MUAPseq:2*pi/dur_MUAPseq:pi-pi/dur_MUAPseq];
plot(freq_ax,fftshift(abs(f_transf_Firings)));
xlabel('Discrete Angular Frequency')
title('Discrete time Fourier Transform of Motor Neuron Discharge Sequence')
ylabel('Magnitude of Fourier Transform (Arbitrary Units)')


 
% Plot Fourier Transform of the MUAP 
figure(3)
f_transf_MUAP = fft(MUAPs(MUAP_sel,:));
freq_ax = [-pi+pi/dur_MUAPs:2*pi/dur_MUAPs:pi-pi/dur_MUAPs];
plot(freq_ax,fftshift(abs(f_transf_MUAP)));
xlabel('Discrete Angular Frequency')
title('Discrete time Fourier Transform of Motor Unit Action Potential')
ylabel('Magnitude of Fourier Transform (Arbitrary Units)')
 
% Plot Fourier Transform of the MUAP train
figure(4)
f_transf_MUAP_Train = fft(MUAP_Train(MUAP_sel,:));
freq_ax = [-pi+pi/dur_MUAPseq:2*pi/dur_MUAPseq:pi-pi/dur_MUAPseq];
plot(freq_ax,fftshift(abs(f_transf_MUAP_Train)));
xlabel('Discrete Angular Frequency')
title('Discrete time Fourier Transform of Motor Unit Action Potential Train')
ylabel('Magnitude of Fourier Transform (Arbitrary Units)')
 
% Obtaining the EMG signal by summing all MUAP trains
recoEMG = sum(MUAP_Train,1);
figure(5), plot(1/fsamp:1/fsamp:length(recoEMG)/fsamp,recoEMG); 
title('Reconstructed EMG signal'), xlabel('Time (s)'); ylabel('EMG (Arbitrary Units)');
 
% Plot Fourier Transform of the EMG signal
figure(6)
f_transf_EMG = fft(recoEMG(MUAP_sel,:));
freq_ax = [-pi+pi/dur_MUAPseq:2*pi/dur_MUAPseq:pi-pi/dur_MUAPseq];
plot(freq_ax,fftshift(abs(f_transf_EMG)));
xlabel('Discrete Angular Frequency')
title('Discrete time Fourier Transform of the EMG Signal')
ylabel('Magnitude of Fourier Transform (Arbitrary Units)')
 
 
%% PART 2: Using a moving average on the rectified, reconstructed EMG signal to get an envelope
loop = 1;
MA_coef_num = 1000;
iterator = 1;
while loop == 1
    Rect_recoEMG = abs(recoEMG); % Rectify the EMG
    MA = ones(1,MA_coef_num)/MA_coef_num; % Impulse response of the moving average filter (see slide 30)

    % Plot the frequency response of the moving average filter (see slide 31).
    % NOTE: The absolute value of the frequency response is plotted in log
    % scale
%     figure(7+iterator)
%     freqz(MA);
    
    %xlabel('Time(ms)');
    figure (7+iterator)
    Rect_recoEMG = conv(Rect_recoEMG, MA);
    %plot(1/fsamp:1/fsamp:length(Rect_recoEMG)/fsamp,Rect_recoEMG);
    hold on;
    plot(1/fsamp:1/fsamp:length(Rect_recoEMG)/fsamp,Rect_recoEMG/max(Rect_recoEMG));
    plot(time_ax, torque/max(torque));
    hold off;
    str = sprintf('EMG Envelope: Length = %d', MA_coef_num);
    title(str), xlabel('Time (s)'); ylabel('EMG (Arbitrary Units)');
    axis([0 45 0 1]);
    
    if MA_coef_num == 1000
        MA_coef_num = 5000;
    elseif MA_coef_num == 5000
        MA_coef_num = 10000;
    else
        loop = 2;
    end
        
    iterator = iterator + 1;
end
% Compute the envelope of the EMG by filtering the rectified signal
%[Here calculate the envelope of the EMG signal]
 
% Plot the envelope of the signal together with torque
%[Here plot the EMG envelope with superimposed torque]
