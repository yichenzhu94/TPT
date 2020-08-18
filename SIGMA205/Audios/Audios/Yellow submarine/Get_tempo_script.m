close all
clear all
clc

[YS1 Fs] = audioread('Yellow_submarine_Cata.wav');
YS1 = YS1(:,1);
[YS2 Fs] = audioread('Yellow_submarine_Fan.wav');
YS2 = YS2(:,1);
[YS3 Fs] = audioread('Yellow_submarine_Juan.wav');
YS3 = YS3(:,1);
[YS4 Fs] = audioread('Yellow_submarine_Lina.wav');
YS4 = YS4(:,1);
[YS5 Fs] = audioread('Yellow_submarine_Mariana.wav');
YS5 = YS5(:,1);
[YS6 Fs] = audioread('Yellow_submarine_Raul.wav');
YS6 = YS6(:,1);
[YS7 Fs] = audioread('Yellow_submarine_Santiago.wav');
YS7 = YS7(:,1);
[YS8 Fs] = audioread('Yellow_submarine_Santy.wav');
YS8 = YS8(:,1);
[YS9 Fs] = audioread('Yellow_submarine_Vane.wav');
YS9 = YS9(:,1);
% [OM10 Fs] = audioread('Love_the_way_you_lie_David.wav');
% OM10 = OM10(:,1);
% [OM11 Fs] = audioread('Love_the_way_you_lie_Negro.wav');
% OM11 = OM11(:,1);

Tempo1 = tempo2(YS1,Fs);
if Tempo1(3) > 0.5
    Tempo1 = Tempo1(1);
else
    Tempo1 = Tempo1(2);
end
Tempo2 = tempo2(YS2,Fs);
if Tempo2(3) > 0.5
    Tempo2 = Tempo2(1);
else
    Tempo2 = Tempo2(2);
end
Tempo3 = tempo2(YS3,Fs);
if Tempo3(3) > 0.5
    Tempo3 = Tempo3(1);
else
    Tempo3 = Tempo3(2);
end
Tempo4 = tempo2(YS4,Fs);
if Tempo4(3) < 0.5
    Tempo4 = Tempo4(1);
else
    Tempo4 = Tempo4(2);
end
Tempo5 = tempo2(YS5,Fs);
if Tempo5(3) < 0.5
    Tempo5 = Tempo5(1);
else
    Tempo5 = Tempo5(2);
end
Tempo6 = tempo2(YS6,Fs);
if Tempo6(3) > 0.5
    Tempo6 = Tempo6(1);
else
    Tempo6 = Tempo6(2);
end
Tempo7 = tempo2(YS7,Fs);
if Tempo7(3) < 0.5
    Tempo7 = Tempo7(1);
else
    Tempo7 = Tempo7(2);
end
Tempo8 = tempo2(YS8,Fs);
if Tempo8(3) < 0.5
    Tempo8 = Tempo8(1);
else
    Tempo8 = Tempo8(2);
end
Tempo9 = tempo2(YS9,Fs);
if Tempo9(3) < 0.5
    Tempo9 = Tempo9(1);
else
    Tempo9 = Tempo9(2);
end
% Tempo10 = tempo2(OM10,Fs);
% if Tempo10(3) > 0.5
%     Tempo10 = Tempo10(1);
% else
%     Tempo10 = Tempo10(2);
% end
% Tempo11 = tempo2(OM11,Fs);
% if Tempo11(3) > 0.5
%     Tempo11 = Tempo11(1);
% else
%     Tempo11 = Tempo11(2);
% end

Tempo = [Tempo1 Tempo2 Tempo3 Tempo4 Tempo5 Tempo6 Tempo7 Tempo8 Tempo9]; %Tempo10 Tempo11];
Tempo_m = mean(Tempo);