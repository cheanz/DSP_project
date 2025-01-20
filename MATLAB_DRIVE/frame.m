[signal, fs] = audioread('si.wav'); % Replace 'filename.wav' with your audio file
disp(['Sample Rate: ', num2str(fs), ' Hz']);
startTime = 0.1;
endTime = 0.5;
threshold=50;
t1 = startTime * fs;  % Start time in samples
t2 = endTime * fs;    % End time in samples
segment = signal(t1:t2);
m = length(segment);
windowedSegment = segment .* hamming(m);
length(windowedSegment)
fftSegment = fft(windowedSegment);
size(fftSegment)
% % fftSegment=fft(segment);
% f = (0:m-1)*(fs/m);   % Frequency range
% magnitude = abs(fftSegment);
% size(magnitude)
% whos magnitude
% [pks, locs] = findpeaks(magnitude, 'MINPEAKHEIGHT', threshold); % Set an appropriate threshold
% fundamentalFreq = f(locs(1));% Assuming the first peak is the fundamental frequency
% length(f)
% length(magnitude)
% plot(f, magnitude);
% hold on;
% plot(f(locs), pks, 'r*'); % Mark the peaks
% xlabel('Frequency (Hz)');
% ylabel('Magnitude');
% title('Frequency Spectrum');
% hold off;