% Third tutorial
clear all
close all
clc
 
% Signal loading
load('EEG.mat');
 
% Sampling frequency
fsamp = 512;
 
% Select duration to analyze
Duration = 15; % Duration in seconds (max 15 seconds)
Duration = round(Duration*fsamp);
EEG = EEG(1:Duration); 
 
% Signal duration in samples
L = length(EEG);
 
% Plot the EEG signal

% L-1 because it starts at 0divided by frequency so that each time interval is one sampling period
time_ax = [0:L-1]./fsamp; 
figure(1)
plot(time_ax, EEG);
xlabel('Time (s)')
title(['EEG signal'])
ylabel('Amplitude EEG (Arbitrary Units)')
 
% Compute DFT of the two channels
X1 = fft( EEG - mean(EEG) );
 
% Compute PSD (power spectral density) of the two channels and adjust
% frequency axis according to Matlab notation
PSD1 = fftshift(abs(X1).^2)/L;
 
% Build the frequency axis in radiants
freq_a_rad = [-pi+pi/L:2*pi/L:pi-pi/L];
% Convert the frequency axis in Hz
freq_a_Hz = freq_a_rad./(2*pi).*fsamp;
 
% Plot the PSD of the two channels with frequencies in radiants and Hz
figure(2), subplot(2,1,1), plot(freq_a_rad,PSD1);
xlabel('Frequency (radians)')
title('Power Spectral Density of EEG')
ylabel('PSD (Arbitrary Units)')

figure(2), subplot(2,1,2), plot(freq_a_Hz,PSD1);
xlabel('Frequency (Hz)')
title('Power Spectral Density of EEG')
ylabel('PSD (Arbitrary Units)')
 
%% Compute the percentage of power in different subbands
%[Here please complete with instructions for computing the relative power in the frequency bands.]

%only positive frequencies
PSD_pos = freq_filter(PSD1,freq_a_Hz, 0, max(freq_a_Hz));

% %initialising frequency signals of each wave type

PSD_delta = freq_filter(PSD1,freq_a_Hz, 0.5, 4);
PSD_theta= freq_filter(PSD1,freq_a_Hz, 4, 8);
PSD_alpha= freq_filter(PSD1,freq_a_Hz, 8, 13);
PSD_beta= freq_filter(PSD1,freq_a_Hz, 13, 30);
PSD_gamma = freq_filter(PSD1,freq_a_Hz, 30, 42);

delta = 100*sum(PSD_delta)/sum(PSD_pos)
theta = 100*sum(PSD_theta)/sum(PSD_pos)
alpha = 100*sum(PSD_alpha)/sum(PSD_pos)
beta = 100*sum(PSD_beta)/sum(PSD_pos)
gamma = 100*sum(PSD_gamma)/sum(PSD_pos)




