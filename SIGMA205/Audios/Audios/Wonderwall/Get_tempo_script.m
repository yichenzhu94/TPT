close all
clear all
clc

[W1 Fs] = audioread('Wonderwall_Cata.wav');
W1 = W1(:,1);
[W2 Fs] = audioread('Wonderwall_Fan.wav');
W2 = W2(:,1);
[W3 Fs] = audioread('Wonderwall_Juan.wav');
W3 = W3(:,1);
[W4 Fs] = audioread('Wonderwall_Lina.wav');
W4 = W4(:,1);
[W5 Fs] = audioread('Wonderwall_Mariana.wav');
W5 = W5(:,1);
[W6 Fs] = audioread('Wonderwall_Raul.wav');
W6 = W6(:,1);
[W7 Fs] = audioread('Wonderwall_Santiago.wav');
W7 = W7(:,1);
[W8 Fs] = audioread('Wonderwall_Vane.wav');
W8 = W8(:,1);
% [T9 Fs] = audioread('Thriller_Vane.wav');
% T9 = T9(:,1);
% [OM10 Fs] = audioread('Love_the_way_you_lie_David.wav');
% OM10 = OM10(:,1);
% [OM11 Fs] = audioread('Love_the_way_you_lie_Negro.wav');
% OM11 = OM11(:,1);

Tempo1 = tempo2(W1,Fs);
if Tempo1(3) > 0.5
    Tempo1 = Tempo1(1);
else
    Tempo1 = Tempo1(2);
end
Tempo2 = tempo2(W2,Fs);
if Tempo2(3) < 0.5
    Tempo2 = Tempo2(1);
else
    Tempo2 = Tempo2(2);
end
Tempo3 = tempo2(W3,Fs);
if Tempo3(3) > 0.5
    Tempo3 = Tempo3(1);
else
    Tempo3 = Tempo3(2);
end
Tempo4 = tempo2(W4,Fs);
if Tempo4(3) > 0.5
    Tempo4 = Tempo4(1);
else
    Tempo4 = Tempo4(2);
end
Tempo5 = tempo2(W5,Fs);
if Tempo5(3) > 0.5
    Tempo5 = Tempo5(1);
else
    Tempo5 = Tempo5(2);
end
Tempo6 = tempo2(W6,Fs);
if Tempo6(3) > 0.5
    Tempo6 = Tempo6(1);
else
    Tempo6 = Tempo6(2);
end
Tempo7 = tempo2(W7,Fs);
if Tempo7(3) > 0.5
    Tempo7 = Tempo7(1);
else
    Tempo7 = Tempo7(2);
end
Tempo8 = tempo2(W8,Fs);
if Tempo8(3) > 0.5
    Tempo8 = Tempo8(1);
else
    Tempo8 = Tempo8(2);
end
% Tempo9 = tempo2(T9,Fs);
% if Tempo9(3) < 0.5
%     Tempo9 = Tempo9(1);
% else
%     Tempo9 = Tempo9(2);
% end
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

Tempo = [Tempo1 Tempo2 Tempo3 Tempo4 Tempo5 Tempo6 Tempo7 Tempo8]; %Tempo9 Tempo10 Tempo11];
Tempo_m = mean(Tempo);