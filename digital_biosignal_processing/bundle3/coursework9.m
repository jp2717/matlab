% Ninth tutorial.
close all; clear all; clc
 
load('spike_neural9.mat') % Load the neural_sig signal
fs = 10240; % Sample frequency in Hz
WinSize = [0.09:0.01:0.25]; % Window size in seconds 
WinSize = round(WinSize.*fs); % Window size in samples
OverlapValues = [0 0.50];
 

Bias_Estimate_Rectangular = zeros(length(WinSize),length(OverlapValues));
Bias_Estimate_Hanning = zeros(length(WinSize),length(OverlapValues));
Var_Estimate_Rectangular = zeros(length(WinSize),length(OverlapValues));
Var_Estimate_Hanning = zeros(length(WinSize),length(OverlapValues));
 
counter = 0;

for uu = 1 : length(WinSize)
    
    overlap_count=1;
    for Overlap=OverlapValues % size of overlap in percents of window size
        %Rectangular window type
        [periodogram,var_estimate,bias] = welch_periodogram(neural_sig, WinSize(uu), Overlap, 'rect', fs );
        Bias_Estimate_Rectangular(uu,overlap_count) = bias;
        Var_Estimate_Rectangular(uu,overlap_count) = median(var_estimate);
        %Hanning window type
        [periodogram,var_estimate,bias] = welch_periodogram(neural_sig, WinSize(uu), Overlap, 'hann', fs );
        Bias_Estimate_Hanning(uu,overlap_count) = bias;
        Var_Estimate_Hanning(uu,overlap_count) = median(var_estimate);
        
        overlap_count = overlap_count + 1;
    end
 
    counter = counter + 1
    
end

