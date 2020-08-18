close all
clear all
clc

[FJ1 Fs] = audioread('Frere_Jacks_Cata.wav');
FJ1 = FJ1(:,1);
[FJ2 Fs] = audioread('Frere_Jacks_Fan.wav');
FJ2 = FJ2(:,1);
[FJ3 Fs] = audioread('Frere_Jacks_Juan.wav');
FJ3 = FJ3(:,1);
[FJ4 Fs] = audioread('Frere_Jacks_Lina.wav');
FJ4 = FJ4(:,1);
[FJ5 Fs] = audioread('Frere_Jacks_Mariana.wav');
FJ5 = FJ5(:,1);
[FJ6 Fs] = audioread('Frere_Jacks_Raul.wav');
FJ6 = FJ6(:,1);
[FJ7 Fs] = audioread('Frere_Jacks_Santiago.wav');
FJ7 = FJ7(:,1);
[FJ8 Fs] = audioread('Frere_Jacks_Santy.wav');
FJ8 = FJ8(:,1);
[FJ9 Fs] = audioread('Frere_Jacks_Vane.wav');
FJ9 = FJ9(:,1);

Tempo1 = tempo2(FJ1,Fs);
if Tempo1(3) > 0.5
    Tempo1 = Tempo1(1);
else
    Tempo1 = Tempo1(2);
end
Tempo2 = tempo2(FJ2,Fs);
if Tempo2(3) > 0.5
    Tempo2 = Tempo2(1);
else
    Tempo2 = Tempo2(2);
end
Tempo3 = tempo2(FJ3,Fs);
if Tempo3(3) > 0.5
    Tempo3 = Tempo3(1);
else
    Tempo3 = Tempo3(2);
end
Tempo4 = tempo2(FJ4,Fs);
if Tempo4(3) > 0.5
    Tempo4 = Tempo4(1);
else
    Tempo4 = Tempo4(2);
end
Tempo5 = tempo2(FJ5,Fs);
if Tempo5(3) > 0.5
    Tempo5 = Tempo5(1);
else
    Tempo5 = Tempo5(2);
end
Tempo6 = tempo2(FJ6,Fs);
if Tempo6(3) < 0.5
    Tempo6 = Tempo6(1);
else
    Tempo6 = Tempo6(2);
end
Tempo7 = tempo2(FJ7,Fs);
if Tempo7(3) > 0.5
    Tempo7 = Tempo7(1);
else
    Tempo7 = Tempo7(2);
end
Tempo8 = tempo2(FJ8,Fs);
if Tempo8(3) > 0.5
    Tempo8 = Tempo8(1);
else
    Tempo8 = Tempo8(2);
end
Tempo9 = tempo2(FJ9,Fs);
if Tempo9(3) < 0.5
    Tempo9 = Tempo9(1);
else
    Tempo9 = Tempo9(2);
end

Tempo = [Tempo1 Tempo2 Tempo3 Tempo4 Tempo5 Tempo6 Tempo7 Tempo8 Tempo9];
Tempo_m = mean(Tempo);