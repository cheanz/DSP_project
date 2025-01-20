[audioData, sampleRate] = audioread('piano.wav');
fftResult = fft(audioData);

% Calculate the frequency axis
frequencies = (0:N-1) * (sampleRate / N);

% Define the frequency range you want to display
minFrequency = 20;  % Minimum frequency in Hz
maxFrequency = 4200;  % Maximum frequency in Hz

% Find the indices corresponding to the desired frequency range
minIndex = find(frequencies >= minFrequency, 1);
maxIndex = find(frequencies <= maxFrequency, 1, 'last');

time=6;
index=round(time*sampleRate);
segment1 = audioData(index:index+63);

hamming_window = hamming(63);
windowed_segment=segment1.*hamming_window;
segmentfftResult=fft(windowed_segment);
N=length(segmentfftResult)

% Define parameters for peak detection
threshold = 1;  % Adjust this threshold as needed
min_peak_distance = 2;  % Minimum distance between peaks (in frequency bins)
% size(fftResult)
% whos fftResult
% Find the peaks in the magnitude spectrum
findpeaks(abs(segmentfftResult(1:64)), 'MinPeakHeight', threshold, 'MinPeakDistance', min_peak_distance);
[mag_peaks, peak_indices] = findpeaks(abs(segmentfftResult(1:64)), 'MinPeakHeight', threshold, 'MinPeakDistance', min_peak_distance);


% Calculate the corresponding frequencies of the valid peaks
peak_frequencies = frequencies(peak_indices);

% Display the detected harmonic frequencies and magnitudes
disp('Detected Harmonic Peaks:');
disp('Frequency (Hz)   Magnitude');
disp(peak_frequencies);


% Step 2: Downsample the Spectrum
% Let's do 3 stages of downsampling for HPS
downsampleFactors = [1, 2]; % Downsampling factors
hpsSpectrum = abs(segmentfftResult(1:N/2)); % Initial HPS spectrum (half because of symmetry)
length(hpsSpectrum)
for factor = downsampleFactors
    downsampledSpectrum = abs(segmentfftResult(1:factor:N/2));
    size(downsampledSpectrum)
    hpsSpectrum = hpsSpectrum .* interp1(1:length(downsampledSpectrum), downsampledSpectrum, 1:1/factor:length(downsampledSpectrum), 'linear', 'extrap');
end

% Step 3: Compute the Harmonic Product Spectrum
% Already done in the loop above

% Step 4: Find the Peak (Fundamental Frequency)
frequencyVector = (0:N-1)*(sampleRate/N); % Frequency vector
[~, peakIndex] = max(hpsSpectrum);
fundamentalFreq = frequencyVector(peakIndex);

% Output the fundamental frequency
fprintf('The fundamental frequency is: %f Hz\n', fundamentalFreq);
