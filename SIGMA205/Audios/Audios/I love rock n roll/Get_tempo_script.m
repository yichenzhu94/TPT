close all
clear all
clc

[LR1 Fs] = audioread('I_love_rocknroll_Cata.wav');
LR1 = LR1(:,1);
[LR2 Fs] = audioread('I_love_rocknroll_Fan.wav');
LR2 = LR2(:,1);
[LR3 Fs] = audioread('I_love_rocknroll_Juan.wav');
LR3 = LR3(:,1);
[LR4 Fs] = audioread('I_love_rocknroll_Lina.wav');
LR4 = LR4(:,1);
[LR5 Fs] = audioread('I_love_rocknroll_Mariana.wav');
LR5 = LR5(:,1);
[LR6 Fs] = audioread('I_love_rocknroll_Raul.wav');
LR6 = LR6(:,1);
[LR7 Fs] = audioread('I_love_rocknroll_Santiago.wav');
LR7 = LR7(:,1);
[LR8 Fs] = audioread('I_love_rocknroll_Santy.wav');
LR8 = LR8(:,1);
[LR9 Fs] = audioread('I_love_rocknroll_Vane.wav');
LR9 = LR9(:,1);
[LR10 Fs] = audioread('I_love_rocknroll_David.wav');
LR10 = LR10(:,1);

Tempo1 = tempo2(LR1,Fs);
if Tempo1(3) < 0.5
    Tempo1 = Tempo1(1);
else
    Tempo1 = Tempo1(2);
end
Tempo2 = tempo2(LR2,Fs);
if Tempo2(3) < 0.5
    Tempo2 = Tempo2(1);
else
    Tempo2 = Tempo2(2);
end
Tempo3 = tempo2(LR3,Fs);
if Tempo3(3) > 0.5
    Tempo3 = Tempo3(1);
else
    Tempo3 = Tempo3(2);
end
Tempo4 = tempo2(LR4,Fs);
if Tempo4(3) < 0.5
    Tempo4 = Tempo4(1);
else
    Tempo4 = Tempo4(2);
end
Tempo5 = tempo2(LR5,Fs);
if Tempo5(3) > 0.5
    Tempo5 = Tempo5(1);
else
    Tempo5 = Tempo5(2);
end
Tempo6 = tempo2(LR6,Fs);
if Tempo6(3) > 0.5
    Tempo6 = Tempo6(1);
else
    Tempo6 = Tempo6(2);
end
Tempo7 = tempo2(LR7,Fs);
if Tempo7(3) < 0.5
    Tempo7 = Tempo7(1);
else
    Tempo7 = Tempo7(2);
end
Tempo8 = tempo2(LR8,Fs);
if Tempo8(3) < 0.5
    Tempo8 = Tempo8(1);
else
    Tempo8 = Tempo8(2);
end
Tempo9 = tempo2(LR9,Fs);
if Tempo9(3) > 0.5
    Tempo9 = Tempo9(1);
else
    Tempo9 = Tempo9(2);
end
Tempo10 = tempo2(LR10,Fs);
if Tempo10(3) < 0.5
    Tempo10 = Tempo10(1);
else
    Tempo10 = Tempo10(2);
end

Tempo = [Tempo1 Tempo2 Tempo3 Tempo4 Tempo5 Tempo6 Tempo7 Tempo8 Tempo9 Tempo10];
Tempo_m = mean(Tempo);