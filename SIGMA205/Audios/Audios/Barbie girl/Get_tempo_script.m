close all
clear all
clc

[BG1 Fs] = audioread('Barbie_girl_David.wav');
BG1 = BG1(:,1);
[BG2 Fs] = audioread('Barbie_girl_Fan.wav');
[BG3 Fs] = audioread('Barbie_girl_Juan.wav');
BG3 = BG3(:,1);
[BG4 Fs] = audioread('Barbie_girl_Lina.wav');
BG4 = BG4(:,1);
[BG5 Fs] = audioread('Barbie_girl_Mariana2.wav');
BG5 = BG5(:,1);
[BG6 Fs] = audioread('Barbie_girl_Raul.wav');
BG6 = BG6(:,1);
[BG7 Fs] = audioread('Barbie_girl_Santiago.wav');
[BG8 Fs] = audioread('Barbie_girl_Vane.wav');
BG8 = BG8(:,1);

Tempo1 = tempo2(BG1,Fs);
if Tempo1(3) > 0.5
    Tempo1 = Tempo1(1);
else
    Tempo1 = Tempo1(2);
end
Tempo2 = tempo2(BG2,Fs);
if Tempo2(3) > 0.5
    Tempo2 = Tempo2(1);
else
    Tempo2 = Tempo2(2);
end
Tempo3 = tempo2(BG3,Fs);
if Tempo3(3) > 0.5
    Tempo3 = Tempo3(1);
else
    Tempo3 = Tempo3(2);
end
Tempo4 = tempo2(BG4,Fs);
if Tempo4(3) > 0.5
    Tempo4 = Tempo4(1);
else
    Tempo4 = Tempo4(2);
end
Tempo5 = tempo2(BG5,Fs);
if Tempo5(3) > 0.5
    Tempo5 = Tempo5(1);
else
    Tempo5 = Tempo5(2);
end
Tempo6 = tempo2(BG6,Fs);
if Tempo6(3) > 0.5
    Tempo6 = Tempo6(1);
else
    Tempo6 = Tempo6(2);
end
Tempo7 = tempo2(BG7,Fs);
if Tempo7(3) > 0.5
    Tempo7 = Tempo7(1);
else
    Tempo7 = Tempo7(2);
end
Tempo8 = tempo2(BG8,Fs);
if Tempo8(3) > 0.5
    Tempo8 = Tempo8(1);
else
    Tempo8 = Tempo8(2);
end

Tempo = [Tempo1 Tempo2 Tempo3 Tempo4 Tempo5 Tempo6 Tempo7 Tempo8];
Tempo_m = mean(Tempo);