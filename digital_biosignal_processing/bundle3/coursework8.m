% Eighth tutorial.
close all; clear all; clc;
 
load('spike_neural8.mat') % Load the neural_sig signal
L = length(neural_sig); % Duration of the signal in samples
fs = 10240; % Sample frequency in Hz
WinSize = [0.2:0.1:2]; % Window size in seconds 
WinSize = round(WinSize.*fs); % Window size in samples
 
f_ax = (-pi:2*pi/fs:pi-2*pi/fs)./(2*pi).*fs; % Frequency axis in Hz
variance_periodogram_estimate = []; %initialises the variance container

for uu = 1 : length(WinSize)
    
    % Estimate of the periodogram
    window = rectwin(WinSize(uu))';
    for n = 1:35 %For each window length, estimate the periodogram for the first 35 signal segments
        wind_signal=neural_sig((n-1)*WinSize(uu)+(1:WinSize(uu))).*window;
        Segm_spect{uu}(n,:) = fftshift(abs(fft(wind_signal,fs)).^2)./WinSize(uu);
    end    
    
    %Variance of the periodogram estimate for each window size
    variance_periodogram_estimate = [variance_periodogram_estimate var(Segm_spect{uu})'];   %adds new variance on next collumn
 
end


% [Here please complete with instructions for plotting the mean periodogram for rectangular window sizes of 0.2 s, 0.5 s, and 2 s] 
mean_periodogram = zeros(3,10240);
mean_periodogram(1,:) = mean(Segm_spect{1}); %0.2
mean_periodogram(2,:) = mean(Segm_spect{4});  %0.5
mean_periodogram(3,:) = mean(Segm_spect{end});   %2

figure(1); plot(f_ax, mean_periodogram(1,:), 'b');
xlabel('Frequency (Hz)'); ylabel('AU'); title('Mean periodogram for 0.2s window length');

figure(2); plot(f_ax, mean_periodogram(2,:), 'r');
xlabel('Frequency (Hz)'); ylabel('AU'); title('Mean periodogram for 0.5s window length');

hold on;
figure(3); plot(f_ax, mean_periodogram(3,:), 'g');
xlabel('Frequency (Hz)'); ylabel('AU'); title('Mean periodogram for 2s window length');
hold off;


% legend('0.2s Window Length', '0.5s Window Length', '2s Window Length');
% hold off;

% [Here please complete with instructions for computing the bias for rectangular window sizes of 0.2 s, 0.5 s, and 2 s] 
within_range = 0;
small_peak = max(mean_periodogram(1,:));   %0.2
medium_peak = max(mean_periodogram(2,:));  %0.5
high_peak = max(mean_periodogram(3,:));    %2
areas = zeros(1,3);
%%Computing areas to calculate bias(frequency range from 51250 to )
for i = 1:10240
    
   if round(f_ax(i)) == -5   %%starts 'integrating' over psd
       within_range = 1;
   end
   
   if within_range == 1
       areas(1) = areas(1) + mean_periodogram(1,i);
       areas(2) = areas(2) + mean_periodogram(2,i);
       areas(3) = areas(3) + mean_periodogram(3,i);
   end
   
   if round(f_ax(i)) == 5    %finished computing area so loop can be stopped
       break;
   end

end

small_bias = areas(1)/small_peak  %0.2
medium_bias = areas(2)/medium_peak  %0.5
high_bias = areas(3)/high_peak  %2


%%Variance of the estimator as a function of window length for different
%%windows

%rectangular window

figure(4); boxplot(variance_periodogram_estimate,'labels',{'0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9',...
    '1.0','1.1','1.2','1.3','1.4','1.5','1.6','1.7','1.8','1.9','2.0'})
xlabel('Window Duration(s)')
ylabel('Variance (AU)')
title('Variance of periodogram estimate as a function of window duration (rectangular window)');
%%Just change it at the


% [Here please complete with instructions for  plotting variance of estimation of the periodogram as a function of the window size, for rectangular, Hanning, and Hamming windows] 
% %Variance of estimation of periodogram as a function of window size for rectangular window
% figure; boxplot(Please fill)
% xlabel(Please fill)
% ylabel(Please fill)
% title(Please fill)
% 
% %hanning window
% Please fill
% 
% %hamming window
% Please fill
