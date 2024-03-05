function f = separatesounds(audio_in,audio_freq_samp1)
%ALLIGNING THE VALUES TO LENGTH OF AUDIO, AND DF IS THE MINIMUM FREQUENCY RANGE
length_audio = length(audio_in);
df = audio_freq_samp1/length_audio;
 
%CALCULATING FREQUENCY VALUES TO BE ASSIGNED ON THE X-AXIS OF THE GRAPH
frequency_audio = -audio_freq_samp1/2:df:audio_freq_samp1/2-df;
 
%BY APPLYING FOURIER TRANSFORM TO THE AUDIO FILE
FFT_audio_in = fftshift(fft(audio_in)/length(fft(audio_in)));
 
%NOW LETS SEPARATE THE VARIOUS COMPONENTS BY CUTTING IT IN FREQUENCY RANGE
lower_threshold = 150;
upper_threshold = 2500;
 
% WHEN THE VALUES IN THE ARRAY ARE IN THE FREQUENCY RANGE THEN WE HAVE 1 AT
% THAT INDEX AND O FOR OTHERS I.E; CREATING AN BOOLEAN INDEX ARRAY
 
val = abs(frequency_audio)<upper_threshold & abs(frequency_audio)>lower_threshold;
FFT_ins = FFT_audio_in(:,1);
FFT_voc = FFT_audio_in(:,1);
%BY THE LOGICAL ARRAY THE FOURIER IN FREQUENCY RANGE IS KEPT IN VOCALS;AND
%REST IN INSTRUMENTAL AND REST OF THE VALUES TO ZERO
FFT_ins(val) = 0;
FFT_voc(~val) = 0;
 
%NOW WE PERFORM THE INVERSE FOURIER TRANSFORM TO GET BACK THE SIGNAL
FFT_a = ifftshift(FFT_audio_in);
FFT_a11 = ifftshift(FFT_ins);
FFT_a31 = ifftshift(FFT_voc);
 
%CREATING THE TIME DOMAIN SIGNAL
s1 = ifft(FFT_a11*length(fft(audio_in)));  
s3 = ifft(FFT_a31*length(fft(audio_in)));
 
%WRITING THE FILE
audiowrite('audio/sound_background.wav',s1,audio_freq_samp1);
audiowrite('audio/sound_voice.wav',s3,audio_freq_samp1);

% Apply FastICA for source separation
numOfIC = 2;  % Number of independent components to extract
[S, A, W] = fastICA(audio_in', numOfIC);
voiceSignal = S(1, :)';
musicSignal = S(2, :)';
% Save the separated voices
audiowrite('audio/voice.wav', voiceSignal./max(abs(voiceSignal)), audio_freq_samp1);
audiowrite('audio/sound.wav', musicSignal./max(abs(musicSignal)), audio_freq_samp1);
end