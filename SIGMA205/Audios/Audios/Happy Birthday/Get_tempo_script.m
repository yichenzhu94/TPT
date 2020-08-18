close all
clear all
clc

[HB1 Fs] = audioread('Happy_birthday_Cata.wav');
HB1 = HB1(:,1);
[HB2 Fs] = audioread('Happy_birthday_Fan.wav');
HB2 = HB2(:,1);
[HB3 Fs] = audioread('Happy_birthday_Juan.wav');
HB3 = HB3(:,1);
[HB4 Fs] = audioread('Happy_birthday_Lina.wav');
HB4 = HB4(:,1);
[HB5 Fs] = audioread('Happy_birthday_Mariana.wav');
HB5 = HB5(:,1);
[HB6 Fs] = audioread('Happy_birthday_Raul.wav');
HB6 = HB6(:,1);
[HB7 Fs] = audioread('Happy_birthday_Santiago.wav');
HB7 = HB7(:,1);
[HB8 Fs] = audioread('Happy_birthday_Santy.wav');
HB8 = HB8(:,1);
[HB9 Fs] = audioread('Happy_birthday_Vane.wav');
HB9 = HB9(:,1);
[HB10 Fs] = audioread('Happy_birthday_David.wav');
HB10 = HB10(:,1);

Tempo1 = tempo2(HB1,Fs);
if Tempo1(3) > 0.5
    Tempo1 = Tempo1(1);
else
    Tempo1 = Tempo1(2);
end
Tempo2 = tempo2(HB2,Fs);
if Tempo2(3) > 0.5
    Tempo2 = Tempo2(1);
else
    Tempo2 = Tempo2(2);
end
Tempo3 = tempo2(HB3,Fs);
if Tempo3(3) > 0.5
    Tempo3 = Tempo3(1);
else
    Tempo3 = Tempo3(2);
end
Tempo4 = tempo2(HB4,Fs);
if Tempo4(3) > 0.5
    Tempo4 = Tempo4(1);
else
    Tempo4 = Tempo4(2);
end
Tempo5 = tempo2(HB5,Fs);
if Tempo5(3) > 0.5
    Tempo5 = Tempo5(1);
else
    Tempo5 = Tempo5(2);
end
Tempo6 = tempo2(HB6,Fs);
if Tempo6(3) > 0.5
    Tempo6 = Tempo6(1);
else
    Tempo6 = Tempo6(2);
end
Tempo7 = tempo2(HB7,Fs);
if Tempo7(3) > 0.5
    Tempo7 = Tempo7(1);
else
    Tempo7 = Tempo7(2);
end
Tempo8 = tempo2(HB8,Fs);
if Tempo8(3) > 0.5
    Tempo8 = Tempo8(1);
else
    Tempo8 = Tempo8(2);
end
Tempo9 = tempo2(HB9,Fs);
if Tempo9(3) > 0.5
    Tempo9 = Tempo9(1);
else
    Tempo9 = Tempo9(2);
end
Tempo10 = tempo2(HB10,Fs);
if Tempo10(3) > 0.5
    Tempo10 = Tempo10(1);
else
    Tempo10 = Tempo10(2);
end

Tempo = [Tempo1 Tempo2 Tempo3 Tempo4 Tempo5 Tempo6 Tempo7 Tempo8 Tempo9 Tempo10];
Tempo_m = mean(Tempo);