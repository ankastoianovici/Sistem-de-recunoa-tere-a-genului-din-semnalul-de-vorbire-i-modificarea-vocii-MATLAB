close all;
clc;
%recorder object
recorder = audiorecorder(44100,24, 2);
%record 5 sec
disp('Record your voice 5 sec');
drawnow();
pause(1);
recordblocking(recorder, 5);
play(recorder)
data = getaudiodata(recorder);
filterrecord = eliminatenoise(data, 44100);
name = 'record';
form = '.wav';
i=i+1;
outputFile= sprintf('%s_%d%s', name, i, form);
audiowrite(outputFile,data,44100);
plot(data)
figure;
f=voiceFFT(data);

%Citirea fisierului audio
[y, fs] = audioread(outputFile);

% Parametri pentru analiza spectrului
windowSize = 1024;
overlap = 512;
y = y(:, 1);
% Calculul spectrului frecventelor
[S, F, T, P] = spectrogram(y, windowSize, overlap, windowSize, fs);

% Lista de frecvente aproximative ale notelor muzicale
noteFrecvente = [261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88];

% Identificarea caracteristicilor spectrale pentru fiecare nota
for i = 1:length(noteFrecvente)
    [~, index] = min(abs(F - noteFrecvente(i)));
    caracteristiciNota(i, :) = abs(P(index, :));
end

% Identificarea notei muzicale pentru fiecare moment in timp
[~, noteIndex] = max(caracteristiciNota);
noteMuzicale = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];
rezultat = noteMuzicale(noteIndex);

% Afisarea rezultatelor
disp(['Notele muzicale recunoscute: ', rezultat]);