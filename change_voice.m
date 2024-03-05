
% Properties
file_ = ''; % Variable to store the file name
flag = 0;   % Variable for a specific behavior, initialized with 0
path = '';  % Variable to store the file path
aud_file = []; % Variable to store audio data
aud_fs = 0; % Audio data sampling frequency, initialized with 0

[file, p] = uigetfile({'*.mp3;*.wav', 'Audio Files (*.mp3, *.wav)'}, 'Select an audio file');

if ischar(file) && (endsWith(file, '.mp3') || endsWith(file, '.wav'))
    flag = 1;
    disp('File Uploaded!!');
    path = p;
    s = fullfile(p, file);
    disp(['File Name: ' file]);
    file_ = s;


    % Read the audio file based on the file extension
    if endsWith(file, '.mp3')
        [aud_file, aud_fs] = audioread(file_, 'native');
    elseif endsWith(file, '.wav')
        [aud_file, aud_fs] = audioread(file_);
    end
    
    % Ajustarea frecventei fundamentale pentru a face vocea pitigaiata
    pitchFactor = 1.5; % Mărește frecvența fundamentală pentru a face vocea pitigaiata
    outputAudio = interp1(1:length(aud_file), aud_file, linspace(1, length(aud_file), round(length(aud_file) / pitchFactor)), 'spline');
   
    outputAudio1= flipud(aud_file);

    echo_IR = zeros(1, round(aud_fs * 0.5));  % Impulsul de răspuns la impuls are o durată de 0.5 secunde
    echo_IR(1) = 1;  % Impuls la început
    
    % Ajustarea factorului de atenuare pentru ecou
    attenuationFactor = 0.5;
    
    % Crearea unui semnal cu ecou prin convoluție
    echoSignal = conv(aud_file(:), echo_IR, 'same') * attenuationFactor;
    
    % Adăugarea semnalului cu ecou la sunetul original
    outputAudio2 = aud_file(:) + echoSignal;
    
    % Normalizarea amplitudinii pentru a evita clipping-ul
    outputAudio2 = outputAudio2 / max(abs(outputAudio2));

    j=0;
    fc = 2500;  % Cut-off frequency in Hz
    order = 4;  % Filter order
    [b, a] = butter(order, fc/(aud_fs/2), 'low');  % Design the filter
    outputAudio3 = filter(b, a, aud_file);  % Apply the filter

    % Afișarea sunetului după ajustarea tonalității
    figure;
    subplot(5, 1, 1);
    plot(aud_file);
    title('Original Voice');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
    
    subplot(5, 1, 2);
    plot(outputAudio);
    title('Funny Voice');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;

    subplot(5,1,3);
    plot(outputAudio1);
    title('Reverse');
    xlabel('Time');
    ylabel('Amplitude')
    grid on;

    subplot(5,1,4);
    plot(outputAudio2);
    title('Echo');
    xlabel('Time');
    ylabel('Amplitude')
    grid on;

    subplot(5,1,5);
    plot(outputAudio3);
    title('Eliminate noise');
    xlabel('Time');
    ylabel('Amplitude')
    grid on;

    % Redare sunet 
    sound(aud_file, aud_fs);
    pause(5);
    clear sound;
    sound(outputAudio, aud_fs);
    pause(5)
    clear sound;
    sound(outputAudio1, aud_fs);
    pause(5)
    clear sound
    sound(outputAudio2, aud_fs);
    pause(5)
    clear sound
    sound(outputAudio3, aud_fs);
    pause(5)
    clear sound
else
    % Display an error message if an incorrect file is selected
    fprintf('Incorrect File Format. Please select a .mp3 or .wav file.');
end
