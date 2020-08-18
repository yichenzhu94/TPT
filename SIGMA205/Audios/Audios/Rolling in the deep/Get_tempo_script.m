close all
clear all
clc

[RD1 Fs] = audioread('Rolling_in_the_deep_Cata.wav');
RD1 = RD1(:,1);
[RD2 Fs] = audioread('Rolling_in_the_deep_Fan.wav');
RD2 = RD2(:,1);
[RD3 Fs] = audioread('Rolling_in_the_deep_Juan.wav');
RD3 = RD3(:,1);
[RD4 Fs] = audioread('Rolling_in_the_deep_Lina.wav');
RD4 = RD4(:,1);
[RD5 Fs] = audioread('Rolling_in_the_deep_Mariana.wav');
RD5 = RD5(:,1);
[RD6 Fs] = audioread('Rolling_in_the_deep_Raul.wav');
RD6 = RD6(:,1);
[RD7 Fs] = audioread('Rolling_in_the_deep_Santiago.wav');
RD7 = RD7(:,1);
[RD8 Fs] = audioread('Rolling_in_the_deep_Santy.wav');
RD8 = RD8(:,1);
[RD9 Fs] = audioread('Rolling_in_the_deep_Vane.wav');
RD9 = RD9(:,1);
% [OM10 Fs] = audioread('Love_the_way_you_lie_David.wav');
% OM10 = OM10(:,1);
% [OM11 Fs] = audioread('Love_the_way_you_lie_Negro.wav');
% OM11 = OM11(:,1);

Tempo1 = tempo2(RD1,Fs);
if Tempo1(3) < 0.5
    Tempo1 = Tempo1(1);
else
    Tempo1 = Tempo1(2);
end
Tempo2 = tempo2(RD2,Fs);
if Tempo2(3) > 0.5
    Tempo2 = Tempo2(1);
else
    Tempo2 = Tempo2(2);
end
Tempo3 = tempo2(RD3,Fs);
if Tempo3(3) > 0.5
    Tempo3 = Tempo3(1);
else
    Tempo3 = Tempo3(2);
end
Tempo4 = tempo2(RD4,Fs);
if Tempo4(3) < 0.5
    Tempo4 = Tempo4(1);
else
    Tempo4 = Tempo4(2);
end
Tempo5 = tempo2(RD5,Fs);
if Tempo5(3) > 0.5
    Tempo5 = Tempo5(1);
else
    Tempo5 = Tempo5(2);
end
Tempo6 = tempo2(RD6,Fs);
if Tempo6(3) < 0.5
    Tempo6 = Tempo6(1);
else
    Tempo6 = Tempo6(2);
end
Tempo7 = tempo2(RD7,Fs);
if Tempo7(3) > 0.5
    Tempo7 = Tempo7(1);
else
    Tempo7 = Tempo7(2);
end
Tempo8 = tempo2(RD8,Fs);
if Tempo8(3) > 0.5
    Tempo8 = Tempo8(1);
else
    Tempo8 = Tempo8(2);
end
Tempo9 = tempo2(RD9,Fs);
if Tempo9(3) > 0.5
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