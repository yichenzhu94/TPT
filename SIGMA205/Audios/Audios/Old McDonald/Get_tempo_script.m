close all
clear all
clc

[OM1 Fs] = audioread('Old_McDonald_Cata1.wav');
OM1 = OM1(:,1);
[OM2 Fs] = audioread('Old_McDonald_Fan.wav');
OM2 = OM2(:,1);
[OM3 Fs] = audioread('Old_McDonald_Juan.wav');
OM3 = OM3(:,1);
[OM4 Fs] = audioread('Old_McDonald_Lina.wav');
OM4 = OM4(:,1);
[OM5 Fs] = audioread('Old_McDonald_Mariana.wav');
OM5 = OM5(:,1);
[OM6 Fs] = audioread('Old_McDonald_Raul.wav');
OM6 = OM6(:,1);
[OM7 Fs] = audioread('Old_McDonald_Santiago.wav');
OM7 = OM7(:,1);
[OM8 Fs] = audioread('Old_McDonald_Santy.wav');
OM8 = OM8(:,1);
[OM9 Fs] = audioread('Old_McDonald_Vane.wav');
OM9 = OM9(:,1);
% [OM10 Fs] = audioread('Love_the_way_you_lie_David.wav');
% OM10 = OM10(:,1);
% [OM11 Fs] = audioread('Love_the_way_you_lie_Negro.wav');
% OM11 = OM11(:,1);

Tempo1 = tempo2(OM1,Fs);
if Tempo1(3) > 0.5
    Tempo1 = Tempo1(1);
else
    Tempo1 = Tempo1(2);
end
Tempo2 = tempo2(OM2,Fs);
if Tempo2(3) > 0.5
    Tempo2 = Tempo2(1);
else
    Tempo2 = Tempo2(2);
end
Tempo3 = tempo2(OM3,Fs);
if Tempo3(3) > 0.5
    Tempo3 = Tempo3(1);
else
    Tempo3 = Tempo3(2);
end
Tempo4 = tempo2(OM4,Fs);
if Tempo4(3) > 0.5
    Tempo4 = Tempo4(1);
else
    Tempo4 = Tempo4(2);
end
Tempo5 = tempo2(OM5,Fs);
if Tempo5(3) > 0.5
    Tempo5 = Tempo5(1);
else
    Tempo5 = Tempo5(2);
end
Tempo6 = tempo2(OM6,Fs);
if Tempo6(3) < 0.5
    Tempo6 = Tempo6(1);
else
    Tempo6 = Tempo6(2);
end
Tempo7 = tempo2(OM7,Fs);
if Tempo7(3) > 0.5
    Tempo7 = Tempo7(1);
else
    Tempo7 = Tempo7(2);
end
Tempo8 = tempo2(OM8,Fs);
if Tempo8(3) > 0.5
    Tempo8 = Tempo8(1);
else
    Tempo8 = Tempo8(2);
end
Tempo9 = tempo2(OM9,Fs);
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