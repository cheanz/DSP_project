% Define a signal of length N
N = 64;
signal = randn(1, N);

% Apply Hamming window
hamming_window = hamming(N);
signal_windowed = signal .* hamming_window;

% Compute the FFT
fft_result = fft(signal_windowed);

% Check the length of the FFT result
length(fft_result)