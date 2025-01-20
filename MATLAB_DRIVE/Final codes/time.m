[audioData, fs] = audioread('sky.flac');
frameSize = 0.3; % 0.3 seconds
frameSamples = round(frameSize * fs);
window = hamming(frameSamples);
windowsize=size(window);
for i = 1:length(audioData)/frameSamples
    frame = audioData((i-1)*frameSamples+1 : i*frameSamples);
    frame = frame .* window';

    % Autocorrelation
    autocorr = xcorr(frame);
    % Find the peak in the autocorrelation that corresponds to the pitch period
    % ...
    % Ignore half (the negative lags) and the zero-lag peak
    halfwayPoint = ceil(length(autocorr)/2);
    autocorr = autocorr(halfwayPoint:end);
    
    % Find peaks
    [peaks, lagIndices] = findpeaks(autocorr);
    
    % Find the first significant peak
    % This might involve setting a threshold or simply taking the first peak
    firstPeakLag = lagIndices(1);
    
    % Calculate the pitch period
    pitchPeriod = firstPeakLag;
    
    % Convert period to frequency
    pitchFrequency = fs / pitchPeriod;
    disp(['Fundamental Frequency: ' num2str(pitchFrequency) ' Hz']);
end

