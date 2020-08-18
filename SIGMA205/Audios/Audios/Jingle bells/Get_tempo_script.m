close all
clear all
clc

[JB1 Fs] = audioread('Jingle_bells_Cata.wav');
JB1 = JB1(:,1);
[JB2 Fs] = audioread('Jingle_bells_Fan.wav');
JB2 = JB2(:,1);
[JB3 Fs] = audioread('Jingle_bells_Juan.wav');
JB3 = JB3(:,1);
[JB4 Fs] = audioread('Jingle_bells_Lina.wav');
JB4 = JB4(:,1);
[JB5 Fs] = audioread('Jingle_bells_mariana.wav');
JB5 = JB5(:,1);
[JB6 Fs] = audioread('Jingle_bells_Raul.wav');
JB6 = JB6(:,1);
[JB7 Fs] = audioread('Jingle_bells_Santiago.wav');
JB7 = JB7(:,1);
[JB8 Fs] = audioread('Jingle_bells_Santy.wav');
JB8 = JB8(:,1);
[JB9 Fs] = audioread('Jingle_bells_Vane.wav');
JB9 = JB9(:,1);
[JB10 Fs] = audioread('Jingle_bells_David.wav');
JB10 = JB10(:,1);
[JB11 Fs] = audioread('Jingle_bells_Negro.wav');
JB11 = JB11(:,1);

Tempo1 = tempo2(JB1,Fs);
if Tempo1(3) > 0.5
    Tempo1 = Tempo1(1);
else
    Tempo1 = Tempo1(2);
end
Tempo2 = tempo2(JB2,Fs);
if Tempo2(3) > 0.5
    Tempo2 = Tempo2(1);
else
    Tempo2 = Tempo2(2);
end
Tempo3 = tempo2(JB3,Fs);
if Tempo3(3) > 0.5
    Tempo3 = Tempo3(1);
else
    Tempo3 = Tempo3(2);
end
Tempo4 = tempo2(JB4,Fs);
if Tempo4(3) > 0.5
    Tempo4 = Tempo4(1);
else
    Tempo4 = Tempo4(2);
end
Tempo5 = tempo2(JB5,Fs);
if Tempo5(3) > 0.5
    Tempo5 = Tempo5(1);
else
    Tempo5 = Tempo5(2);
end
Tempo6 = tempo2(JB6,Fs);
if Tempo6(3) < 0.5
    Tempo6 = Tempo6(1);
else
    Tempo6 = Tempo6(2);
end
Tempo7 = tempo2(JB7,Fs);
if Tempo7(3) > 0.5
    Tempo7 = Tempo7(1);
else
    Tempo7 = Tempo7(2);
end
Tempo8 = tempo2(JB8,Fs);
if Tempo8(3) > 0.5
    Tempo8 = Tempo8(1);
else
    Tempo8 = Tempo8(2);
end
Tempo9 = tempo2(JB9,Fs);
if Tempo9(3) > 0.5
    Tempo9 = Tempo9(1);
else
    Tempo9 = Tempo9(2);
end
Tempo10 = tempo2(JB10,Fs);
if Tempo10(3) > 0.5
    Tempo10 = Tempo10(1);
else
    Tempo10 = Tempo10(2);
end
Tempo11 = tempo2(JB11,Fs);
if Tempo11(3) > 0.5
    Tempo11 = Tempo11(1);
else
    Tempo11 = Tempo11(2);
end

Tempo = [Tempo1 Tempo2 Tempo3 Tempo4 Tempo5 Tempo6 Tempo7 Tempo8 Tempo9 Tempo10 Tempo11];
Tempo_m = mean(Tempo);