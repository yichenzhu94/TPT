close all
clear all
clc

[LWYL1 Fs] = audioread('Love_the_way_you_lie_Cata.wav');
LWYL1 = LWYL1(:,1);
[LWYL2 Fs] = audioread('Love_the_way_you_lie_Fan.wav');
LWYL2 = LWYL2(:,1);
[LWYL3 Fs] = audioread('Love_the_way_you_lie_Juan.wav');
LWYL3 = LWYL3(:,1);
[LWYL4 Fs] = audioread('Love_the_way_you_lie_Lina.wav');
LWYL4 = LWYL4(:,1);
[LWYL5 Fs] = audioread('Love_the_way_you_lie_Mariana.wav');
LWYL5 = LWYL5(:,1);
[LWYL6 Fs] = audioread('Love_the_way_you_lie_Raul.wav');
LWYL6 = LWYL6(:,1);
[LWYL7 Fs] = audioread('Love_the_way_you_lie_Santiago.wav');
LWYL7 = LWYL7(:,1);
[LWYL8 Fs] = audioread('Love_the_way_you_lie_Santy.wav');
LWYL8 = LWYL8(:,1);
[LWYL9 Fs] = audioread('Love_the_way_you_lie_Vane.wav');
LWYL9 = LWYL9(:,1);
[LWYL10 Fs] = audioread('Love_the_way_you_lie_David.wav');
LWYL10 = LWYL10(:,1);
[LWYL11 Fs] = audioread('Love_the_way_you_lie_Negro.wav');
LWYL11 = LWYL11(:,1);

Tempo1 = tempo2(LWYL1,Fs);
if Tempo1(3) > 0.5
    Tempo1 = Tempo1(1);
else
    Tempo1 = Tempo1(2);
end
Tempo2 = tempo2(LWYL2,Fs);
if Tempo2(3) > 0.5
    Tempo2 = Tempo2(1);
else
    Tempo2 = Tempo2(2);
end
Tempo3 = tempo2(LWYL3,Fs);
if Tempo3(3) > 0.5
    Tempo3 = Tempo3(1);
else
    Tempo3 = Tempo3(2);
end
Tempo4 = tempo2(LWYL4,Fs);
if Tempo4(3) > 0.5
    Tempo4 = Tempo4(1);
else
    Tempo4 = Tempo4(2);
end
Tempo5 = tempo2(LWYL5,Fs);
if Tempo5(3) > 0.5
    Tempo5 = Tempo5(1);
else
    Tempo5 = Tempo5(2);
end
Tempo6 = tempo2(LWYL6,Fs);
if Tempo6(3) > 0.5
    Tempo6 = Tempo6(1);
else
    Tempo6 = Tempo6(2);
end
Tempo7 = tempo2(LWYL7,Fs);
if Tempo7(3) > 0.5
    Tempo7 = Tempo7(1);
else
    Tempo7 = Tempo7(2);
end
Tempo8 = tempo2(LWYL8,Fs);
if Tempo8(3) > 0.5
    Tempo8 = Tempo8(1);
else
    Tempo8 = Tempo8(2);
end
Tempo9 = tempo2(LWYL9,Fs);
if Tempo9(3) > 0.5
    Tempo9 = Tempo9(1);
else
    Tempo9 = Tempo9(2);
end
Tempo10 = tempo2(LWYL10,Fs);
if Tempo10(3) > 0.5
    Tempo10 = Tempo10(1);
else
    Tempo10 = Tempo10(2);
end
Tempo11 = tempo2(LWYL11,Fs);
if Tempo11(3) > 0.5
    Tempo11 = Tempo11(1);
else
    Tempo11 = Tempo11(2);
end

Tempo = [Tempo1 Tempo2 Tempo3 Tempo4 Tempo5 Tempo6 Tempo7 Tempo8 Tempo9 Tempo10 Tempo11];
Tempo_m = mean(Tempo);