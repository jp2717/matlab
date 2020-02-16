% Fifth Tutorial
clear all; close all; clc;
 
load 'emg'; % Load the EMG signal
fs = 1600; % Sampling frequency
L = length(emg); % Duration of the signal in samples
time_ax=[0:1/fs:(L-1)/fs]; % Time axis of the signal in seconds
 
figure(1); plot(time_ax, emg); xlabel('Time(ms)'); ylabel('EMG Signal Amplitude (mV)'); title('Original EMG Signal');

fc = 2; % Filter cut-off frequency in (Hz)
wc = 2*fc/fs*pi; % Normalized cut-off frequency
 
% Generate Sinc function with a given sampling rate
t = -floor(L):floor(L); % Form the time axis of the Sinc function (theoretically it can be infinetly long)
sinc_func=wc*sinc((2*fc/fs)*t);
 
figure(2); plot(t, sinc_func);
title('Sinc function');
xlabel('n');
ylabel('AU');
 
f_snc=fftshift(fft(sinc_func)); % Find the DFT of the sinc function 
f_ax =(-pi+pi/length(sinc_func):2*pi/length(sinc_func):pi-pi/length(sinc_func))./pi; % Frequency axis for the DFT of sinc function
 
figure(3); plot(f_ax,abs(f_snc));
title('Magnitude of discrete time Fourier transform of the Sinc');
xlabel('Frequency (rad)')
ylabel('AU');
 
% Create the FIR filter by truncating the very long sinc function and by using
% one of the following windows: hanning; rectwin;
FIR_duration=100;
truncation_section=floor(length(sinc_func)/2-FIR_duration/2):floor(length(sinc_func)/2+FIR_duration/2);
fir_filt = sinc_func(truncation_section).*rectwin(length(truncation_section))';
fir_filt2 = sinc_func(truncation_section).*hanning(length(truncation_section))';    %using hanning window
 
figure(4);freqz(fir_filt);
 
% Create moving avarege filter with the length of MA_coef_num
MA_coef_num = 100;
MA = (1/MA_coef_num) * ones(1, MA_coef_num + 1);    %Adding one because length does not start at 0
figure(5);freqz(MA); 

% Filter the rectified EMG using FIR filter
env_FIR = conv(emg, fir_filt);
L = length(env_FIR); % Duration of the filtered signal in samples
time_ax=[0:1/fs:(L-1)/fs]; % Time axis of the filtered signal in seconds
 
% Filter the rectified EMG using moving average filter
env_MA = conv(emg, MA);

%Plotting the filtered envelopes (FIR with rectwin)
figure(6); plot(time_ax, env_FIR); xlabel('Time(ms)'); ylabel('EMG Signal Amplitude(mV)'); title('FIR Filtered Signal (Rectangular)');
figure(7); plot(time_ax, env_MA); xlabel('Time(ms)'); ylabel('EMG Signal Amplitude(mV)'); title('MA Filtered Signal');

%Plotting envelope filtered by FIR with hanning
env_FIR2 = conv(emg, fir_filt2);
figure(8); plot(time_ax, env_FIR2); xlabel('Time(ms)'); ylabel('EMG Signal Amplitude(mV)'); title('FIR Filtered Signal (Hanning)');

%Plotting frequency responses of each filter

%Axis
filter_duration=size(MA,2); % Duration of the ECG signal in samples
f_ax=[-pi+pi/filter_duration:2*pi/filter_duration:pi-pi/filter_duration];

%Frequency responses
MAf = fftshift(fft(MA));
FIRf = fftshift(fft(fir_filt));
FIR2f = fftshift(fft(fir_filt2));

%Plotting in Fourier domain
figure(9); plot(f_ax, abs(MAf)); xlabel('Frequency(rad)'); ylabel('Amplitude(AU)'); title('Magnitude of DFT of MA filtered signal');
figure(10); plot(f_ax, abs(FIRf)); xlabel('Frequency(rad)'); ylabel('Amplitude(AU)'); title('Magnitude of DFT of FIR(rect) filtered signal');
figure(11); plot(f_ax, abs(FIR2f)); xlabel('Frequency(rad)'); ylabel('Amplitude(AU)'); title('Magnitude of DFT of FIR(han) filtered signal');

