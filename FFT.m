% Step 1: Record a piece of music in piano
% Assuming you have already recorded a piece of music in piano and saved it as 'piano.wav'

% Step 2: Use FFT to analyze the frequency spectrum characteristics of the music audio

% Read the audio file
[y, fs] = audioread('piano.wav');

% Step 2: Perform Fast Fourier Transform (FFT)
% Calculate the FFT of the audio signal
N = length(y);
frequencies = (0:N-1) * fs / N;
Y = fft(y);

% Step 3: Calculate the magnitude and normalize
Y_magnitude = abs(Y) / N;



% Step 4: Plot the frequency spectrum

% Create a larger figure for the plot
figure('Position', [100, 100, 1000, 600]); % [x, y, width, height] 
plot(frequencies, 10*log10(Y_magnitude));
title('Frequency Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;

% Step 5: Zoom in on a specific frequency range if needed
% xlim([0, 5000]); % Set your desired frequency range

% Step 6: Display the plot
pause;

% Step 7: You can further analyze the spectrum or extract specific features as needed