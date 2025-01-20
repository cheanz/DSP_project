% Read or generate your signal
% For example, a 440 Hz sine wave
[signal, Fs] = audioread('sky.flac');
disp(['Sample Rate: ', num2str(Fs), ' Hz']);

noise = randn(size(signal)) * 0.01; % Adjust 0.01 to change noise level

% Add noise to music
music_with_noise = signal + noise;

signal = music_with_noise;

% % Write to a new audio file
% audiowrite('music_with_noise.wav', music_with_noise, Fs);

% t = 0:1/Fs:1; % Time vector

% Assuming 'signal' is a stereo audio signal with size Nx2
leftChannel = signal(:, 1);
rightChannel = signal(:, 2);

% % Option 1: Mix down to mono
% monoSignal = mean(signal, 2); % Averaging the two channels

% Option 2: Choose one channel (e.g., left)
selectedChannel = leftChannel;
signal=selectedChannel(42000:45000);

% Apply a window function (e.g., Hann window)
window = hann(length(signal));
windowsize = size(window)
signalsize = size(signal)
signal = signal' .* window';

% Compute the FFT
N = length(signal);
signallength = length(signal)
fftSignal = fft(signal, N);
magnitude = abs(fftSignal);

% HPS
numHarmonics = 5; % Number of harmonics to consider
hps = magnitude(1:N/2+1);
for h = 2:numHarmonics
    temp = downsample(magnitude, h);
    templength = length(temp)
    hps(1:length(temp)) = hps(1:length(temp)) .* temp;
end

% Find the peak
[~, idx] = max(hps);
fundamentalFreq = (idx-1) * Fs / N;

% Display the fundamental frequency
disp(['Fundamental Frequency: ' num2str(fundamentalFreq) ' Hz']);

