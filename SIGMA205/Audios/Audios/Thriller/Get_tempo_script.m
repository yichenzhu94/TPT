close all
clear all
clc

[T1 Fs] = audioread('Thriller_Cata.wav');
T1 = T1(:,1);
[T2 Fs] = audioread('Thriller_Fan.wav');
T2 = T2(:,1);
[T3 Fs] = audioread('Thriller_Juan.wav');
T3 = T3(:,1);
[T4 Fs] = audioread('Thriller_Lina.wav');
T4 = T4(:,1);
[T5 Fs] = audioread('Thriller_Mariana.wav');
T5 = T5(:,1);
[T6 Fs] = audioread('Thriller_Raul.wav');
T6 = T6(:,1);
[T7 Fs] = audioread('Thriller_Santiago.wav');
T7 = T7(:,1);
[T8 Fs] = audioread('Thriller_Santy.wav');
T8 = T8(:,1);
[T9 Fs] = audioread('Thriller_Vane.wav');
T9 = T9(:,1);
% [OM10 Fs] = audioread('Love_the_way_you_lie_David.wav');
% OM10 = OM10(:,1);
% [OM11 Fs] = audioread('Love_the_way_you_lie_Negro.wav');
% OM11 = OM11(:,1);

Tempo1 = tempo2(T1,Fs);
if Tempo1(3) > 0.5
    Tempo1 = Tempo1(1);
else
    Tempo1 = Tempo1(2);
end
Tempo2 = tempo2(T2,Fs);
if Tempo2(3) > 0.5
    Tempo2 = Tempo2(1);
else
    Tempo2 = Tempo2(2);
end
Tempo3 = tempo2(T3,Fs);
if Tempo3(3) > 0.5
    Tempo3 = Tempo3(1);
else
    Tempo3 = Tempo3(2);
end
Tempo4 = tempo2(T4,Fs);
if Tempo4(3) > 0.5
    Tempo4 = Tempo4(1);
else
    Tempo4 = Tempo4(2);
end
Tempo5 = tempo2(T5,Fs);
if Tempo5(3) > 0.5
    Tempo5 = Tempo5(1);
else
    Tempo5 = Tempo5(2);
end
Tempo6 = tempo2(T6,Fs);
if Tempo6(3) > 0.5
    Tempo6 = Tempo6(1);
else
    Tempo6 = Tempo6(2);
end
Tempo7 = tempo2(T7,Fs);
if Tempo7(3) > 0.5
    Tempo7 = Tempo7(1);
else
    Tempo7 = Tempo7(2);
end
Tempo8 = tempo2(T8,Fs);
if Tempo8(3) < 0.5
    Tempo8 = Tempo8(1);
else
    Tempo8 = Tempo8(2);
end
Tempo9 = tempo2(T9,Fs);
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