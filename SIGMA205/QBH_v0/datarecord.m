clear all;
close all;
clc

fs = 44100; 
duration = 10;

r = audiorecorder(fs,16,1);
fprintf('Press any key to start %g seconds of recording...\n',duration);
pause;
fprintf('Recording...\n');
record(r)
pause(duration);
stop(r)
fprintf('Finished recording.\n');
fprintf('Press any key to save the recording...\n');
pause;
y = getaudiodata(r, 'double');
audiowrite('test.wav', y, fs); 