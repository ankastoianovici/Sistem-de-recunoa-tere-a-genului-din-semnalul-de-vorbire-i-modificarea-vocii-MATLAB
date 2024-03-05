clc;
close all;

[man, FS] = audioread('audio/female.wav'); % Read the audio sample
eliminatenoise(man,FS);
separatesounds(man, FS);
[y, Fs] = audioread('audio/sound_voice.wav');
y = y / max(abs(y));
spectrum = abs(fft(y));
vocalRange = [80, 300];
vocalIndices = find(Fs / 2 * linspace(0, 1, length(spectrum)/2 + 1) >= vocalRange(1) & Fs / 2 * linspace(0, 1, length(spectrum)/2 + 1) <= vocalRange(2));
vocalAmplitudes = spectrum(vocalIndices);
frame = 3500; % Set the frame rate
[b0, a0] = butter(4, [50/(Fs/2), 500/(Fs/2)]);

F0 = zeros(1, floor(length(y)/frame));
x_out = zeros(length(y), 1);
%Identify the frequency of each frame
for i = 1:length(y) / frame
    x = y(1 + (i - 1) * frame : i * frame);
    xin = abs(x);
    xin = filter(b0, a0, xin);
    xin = xin - mean(xin);
    R = xcorr(xin);
    [~, loc] = findpeaks(R(frame:end), 'NPeaks', 1,'MinPeakHeight', 0.1);
    
    % Asigură-te că loc(1) nu depășește lungimea vectorului R
    if ~isempty(loc) && loc(1) <= length(R)
        F0(i) = Fs / max(round(loc(1)), 1); % Evită împărțirea la zero
    else
        F0(i) = 0; % Poți trata acest caz într-un mod corespunzător
    end 
end
    Fx = mean(F0); % Take the mean of all the frequencies for each frame
% Display the output frequency
    fprintf('Estimated frequency is %3.2f Hz.\n',Fx);
    fprintf('Estimated frequency by the in-built function is %3.2f Hz.\n', mean(freq(y, Fs))); % Use the function freq to find the frequency% Display the final Gender
    fprintf('Vocal indices %3.2f.\n',mean(vocalIndices));
    fprintf('Vocal amplitudes %3.2f.\n', mean(vocalAmplitudes));
if Fx > 165 % set the threshold
    fprintf('Female Voice\n');
else
    fprintf('Male Voice\n');
end

