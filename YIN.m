% Read the audio file
[signal, Fs] = audioread('si.wav');

% Convert stereo to mono if necessary
if size(signal, 2) > 1
    signal = mean(signal, 2); % Averaging the two channels
end

% Frame parameters
frameSize = 1024; % Size of each frame in samples
frameOverlap = 512; % Overlap between frames in samples
minFrequency = 50; % Minimum expected frequency
maxLag = floor(Fs / minFrequency);
threshold = 0.1; % Threshold for choosing pitch

numFrames = floor((length(signal) - frameOverlap) / (frameSize - frameOverlap));
pitch = zeros(numFrames, 1); % Vector to store pitch for each frame

for k = 1:numFrames
    frameStart = (k-1) * (frameSize - frameOverlap) + 1;
    frameEnd = frameStart + frameSize - 1;
    frame = signal(frameStart:frameEnd);

    % Step 1: Difference function
    difference = zeros(maxLag, 1);
    for tau = 1:maxLag
        for j = 1:maxLag
            difference(tau) = difference(tau) + (frame(j) - frame(j + tau))^2;
        end
    end

    % Step 2: Cumulative mean normalized difference function
    d_prime = zeros(maxLag, 1);
    d_prime(1) = 1;
    for tau = 2:maxLag
        d_prime(tau) = difference(tau) / ((1/tau) * sum(difference(1:tau)));
    end

    % Step 3: Absolute threshold
    tau_estimate = -1;
    for tau = 2:maxLag
        if d_prime(tau) < threshold
            tau_estimate = tau;
            break;
        end
    end

    % Step 4: Parabolic interpolation
    if tau_estimate > 0
        alpha = d_prime(tau_estimate - 1);
        beta = d_prime(tau_estimate);
        gamma = d_prime(tau_estimate + 1);
        improvement = 0.5 * (alpha - gamma) / (alpha - 2 * beta + gamma);
        tau_estimate = tau_estimate + improvement;
    end

    % Convert lag to frequency
    if tau_estimate > 0
        pitchFrequency = Fs / tau_estimate;
    else
        pitchFrequency = 0; % Indicates unvoiced or no pitch
    end

    pitch(k) = pitchFrequency;
end

% Plot the pitch
frameDuration = frameSize / Fs;
frameTime = ((1:numFrames) - 0.5) * frameDuration;
figure;
plot(frameTime, pitch);
xlabel('Time (seconds)');
ylabel('Pitch Frequency (Hz)');
title('Pitch Detection using YIN');
grid on;
