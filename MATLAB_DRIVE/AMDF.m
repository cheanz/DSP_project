% Read the audio file
[signal, Fs] = audioread('si.wav');

% Convert stereo to mono if necessary
if size(signal, 2) > 1
    signal = mean(signal, 2);
end

% Frame parameters
frameSize = 1024; % Size of each frame in samples
frameOverlap = 512; % Overlap between frames in samples
minPitch = 20; % Minimum pitch frequency in Hz
maxPitch = 4200; % Maximum pitch frequency in Hz
maxLag = round(Fs / minPitch);

% Frame-based processing
numFrames = floor((length(signal) - frameOverlap) / (frameSize - frameOverlap));
pitch = zeros(numFrames, 1); % Vector to store pitch for each frame

for k = 1:numFrames
    % Extract the frame
    frameStart = (k-1) * (frameSize - frameOverlap) + 1;
    frameEnd = frameStart + frameSize - 1;
    frame = signal(frameStart:frameEnd);

    % Calculate AMDF for the frame
    amdf = zeros(maxLag, 1);
    for d = 1:maxLag-1
        delayedFrame = [zeros(d, 1); frame(1:end-d)];
        amdf(d) = mean(abs(frame(1:end-d) - delayedFrame(d+1:end)));
    end

    % Find the first minimum in the AMDF as the pitch period
    [~, dMin] = min(amdf);
    if dMin > 1
        pitchPeriod = dMin;
        pitchFrequency = Fs / pitchPeriod;
    else
        pitchFrequency = 0; % Indicates unvoiced or no pitch
    end

    % Store the pitch frequency
    pitch(k) = pitchFrequency;
end

% pitch contains the pitch frequency for each frame

% Time axis for the plot
frameDuration = frameSize / Fs;  % Duration of each frame in seconds
frameTime = ((1:numFrames) - 0.5) * frameDuration;  % Midpoint of each frame

% Plot the pitch
figure;
plot(frameTime, pitch);
xlabel('Time (seconds)');
ylabel('Pitch Frequency (Hz)');
title('Pitch Detection');
grid on;
