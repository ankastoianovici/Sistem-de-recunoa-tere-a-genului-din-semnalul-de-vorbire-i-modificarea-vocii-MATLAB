function filteredSignal = eliminatenoise(file,fs)
fc = 2500;  % Cut-off frequency in Hz
order = 4;  % Filter order
[b, a] = butter(order, fc/(fs/2), 'low');  % Design the filter
filteredSignal = filter(b, a, file);  % Apply the filter
end