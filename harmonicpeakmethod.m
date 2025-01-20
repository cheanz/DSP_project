% Read the audio file
[y, fs] = audioread('piano.wav');

% Step 2: Perform Fast Fourier Transform (FFT)
% Calculate the FFT of the audio signal
N = length(y);
frequencies = (0:N-1) * fs / N;
Y = fft(y);

% Step 3: Calculate the magnitude and normalize
magnitude = abs(Y) / N;

findpeaks(magnitude, frequencies);
[pks, locs] = findpeaks(magnitude, frequencies);
% Identify fundamental frequency
fundamentalFreq = locs(1);

% Identify harmonics (this is a simplistic approach; in practice, you may need
% to consider more factors such as peak width, distance, etc.)
harmonics = locs(locs > fundamentalFreq & locs < fundamentalFreq*maxHarmonic);
% Plot the magnitude spectrum with identified peaks
figure;
plot(frequencies, magnitude);
hold on;
plot(locs, pks, 'r*', 'MarkerSize', 10); % Mark the peaks
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Spectrum with Harmonic Peaks');
grid on;