function [periodogram,var_estimate,bias] = welch_periodogram(Data, WindowSize, Overlap, WindowType, fs )
   % Estimate of the periodogram
    L = length(Data); % Duration of the signal in samples
    f_ax = (-pi:2*pi/fs:pi-2*pi/fs)./(2*pi).*fs; % Frequency axis in Hz
 
    if strcmp(WindowType,'rect')
        window = rectwin(WindowSize)';
    elseif strcmp(WindowType,'hann')
        window = hanning(WindowSize)';
    end
    
    n=1;
    while max(round((n-1)*WindowSize*(1-Overlap))+(1:WindowSize))<L
        wind_signal=Data(round((n-1)*WindowSize*(1-Overlap)) + (1:WindowSize)).*window;
        Segm_spect(n,:) = fftshift(abs(fft(wind_signal,fs)).^2)./WindowSize;
        n=n+1;
    end    
    
    periodogram = mean(Segm_spect);
    var_estimate = var(Segm_spect);
    %%Computing areas to calculate bias(frequency range from 51250 to )
    area = 0;
    within_range = 0;
    first_half = [];

area = 0;
within_range = 0;
for i = 1:length(f_ax)
    
   if round(f_ax(i)) == -5   %%starts 'integrating' over psd
       within_range = 1;
   end
   
   if within_range == 1
       area = area + periodogram(i);
   end
   
   if round(f_ax(i)) == 5    %finished computing area so loop can be stopped
       break;
   end

end

    bias = area/max(periodogram);
    
     %figure; plot(f_ax,periodogram); 
end

