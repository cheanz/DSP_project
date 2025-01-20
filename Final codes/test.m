% Read the WAV file
[audioData, sampleRate] = audioread('sky.flac');

% Display the sample rate
disp(['Sample Rate: ', num2str(sampleRate), ' Hz']);

duration=length(audioData) / sampleRate;

% Create a time vector
time = linspace(0, duration, length(audioData));


% Create a larger figure for the plot
figure('Position', [100, 100, 800, 400]); % [x, y, width, height]

% Create a plot of the audio signal
plot(time, audioData);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Audio Signal');
grid on;

% Perform FFT
fftResult = fft(audioData);

% Calculate the frequency axis
N = length(audioData);
frequencies = (0:N-1) * (sampleRate / N);


% Define the frequency range you want to display
minFrequency = 20;  % Minimum frequency in Hz
maxFrequency = 4200;  % Maximum frequency in Hz

% Find the indices corresponding to the desired frequency range
minIndex = find(frequencies >= minFrequency, 1);
maxIndex = find(frequencies <= maxFrequency, 1, 'last');

% Plot the magnitude spectrum within the specified frequency range
figure;
plot(frequencies(minIndex:maxIndex), abs(fftResult(minIndex:maxIndex)));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum (20 Hz to 4200 Hz)');
grid on;

% % Optionally, you can set the y-axis limits if needed:
% % ylim([min_magnitude, max_magnitude]);
% 
% 
% % Assuming you have already performed the FFT and have 'frequencies' and 'fftResult' available
% 
% % Define parameters for peak detection
% threshold = 100;  % Adjust this threshold as needed
% min_peak_distance = 50;  % Minimum distance between peaks (in frequency bins)
% size(fftResult)
% whos fftResult
% % Find the peaks in the magnitude spectrum
% findpeaks(abs(fftResult(minIndex:maxIndex)), 'MinPeakHeight', threshold, 'MinPeakDistance', min_peak_distance);
% [mag_peaks, peak_indices] = findpeaks(abs(fftResult(minIndex:maxIndex)), 'MinPeakHeight', threshold, 'MinPeakDistance', min_peak_distance);
% 
% 
% % Calculate the corresponding frequencies of the valid peaks
% peak_frequencies = frequencies(peak_indices);
% 
% % Display the detected harmonic frequencies and magnitudes
% disp('Detected Harmonic Peaks:');
% disp('Frequency (Hz)   Magnitude');
% disp(peak_frequencies);
% 
% 
% % Step 2: Downsample the Spectrum
% % Let's do 3 stages of downsampling for HPS
% downsampleFactors = [1, 2, 3]; % Downsampling factors
% hpsSpectrum = abs(fftResult(1:N/2+1)); % Initial HPS spectrum (half because of symmetry)
% length(hpsSpectrum)
% for factor = downsampleFactors
%     downsampledSpectrum = abs(fftResult(1:factor:N/2+1));
%     size(downsampledSpectrum)
%     hpsSpectrum = hpsSpectrum .* interp1(1:length(downsampledSpectrum), downsampledSpectrum, 1:1/factor:length(downsampledSpectrum), 'linear', 'extrap');
% end
% 
% % Step 3: Compute the Harmonic Product Spectrum
% % Already done in the loop above
% 
% % Step 4: Find the Peak (Fundamental Frequency)
% frequencyVector = (0:N-1)*(sampleRate/N); % Frequency vector
% [~, peakIndex] = max(hpsSpectrum);
% fundamentalFreq = frequencyVector(peakIndex);
% 
% % Output the fundamental frequency
% fprintf('The fundamental frequency is: %f Hz\n', fundamentalFreq);