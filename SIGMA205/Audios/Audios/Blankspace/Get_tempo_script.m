close all
clear all
clc

[BS1 Fs] = audioread('Blankspace_Fan.wav');
[BS2 Fs] = audioread('Blankspace_Lina.wav');
BS2 = BS2(:,1);
[BS3 Fs] = audioread('Blankspace_Mariana.wav');
BS3 = BS3(:,1);
[BS4 Fs] = audioread('Blankspace_Vane.wav');
BS4 = BS4(:,1);


Tempo1 = tempo2(BS1,Fs);
if Tempo1(3) > 0.5
    Tempo1 = Tempo1(1);
else
    Tempo1 = Tempo1(2);
end
Tempo2 = tempo2(BS2,Fs);
if Tempo2(3) > 0.5
    Tempo2 = Tempo2(1);
else
    Tempo2 = Tempo2(2);
end
Tempo3 = tempo2(BS3,Fs);
if Tempo3(3) < 0.5
    Tempo3 = Tempo3(1);
else
    Tempo3 = Tempo3(2);
end
Tempo4 = tempo2(BS4,Fs);
if Tempo4(3) > 0.5
    Tempo4 = Tempo4(1);
else
    Tempo4 = Tempo4(2);
end

Tempo = [Tempo1 Tempo2 Tempo3 Tempo4];
Tempo_m = mean(Tempo);