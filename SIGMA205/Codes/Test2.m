close all
clear all
clc

% [BG1 Fs]= audioread('Barbie_girl_David.wav');
% BG1= BG1(:,1);
% 
% [BG2 Fs]= audioread('Barbie_girl_Juan.wav');
% BG2= BG2(:,1);
% 
% [BG3 Fs]= audioread('Barbie_girl_Lina.wav');
% BG3= BG3(:,1);
% 
% [BG4 Fs]= audioread('Barbie_girl_Mariana2.wav');
% BG4= BG4(:,1);
% 
% [BG5 Fs]= audioread('Barbie_girl_Raul.wav');
% BG5= BG5(:,1);

[BG6 Fs]= audioread('Barbie_girl_Santiago.wav');
BG6= BG6(:,1);

% [BG7 Fs]= audioread('Barbie_girl_Vane.wav');
% BG7= BG7(:,1);

% L = 128;
% w = rectwin(L);
% r = L/4;
% seuil= 0.5*max(BG6);
% Y = zeros(length(BG6),1);
% 
% for i = 1: length(BG6)
%     deb = (i-1)*r +1;
%     fin = deb + L -1;
%     fprintf('Iteration %d\n',i);
%     [M,I] = max(BG6(deb:fin).*w);
%     if M >= seuil && Y(deb+I-1) ~= 1
%         Y(deb+I) = 1;
%     elseif Y(deb+I-1) == 1
%         Y(deb+I) = 0;
%     end
% end
% 
% figure
% subplot(211)
% plot(BG6)
% subplot(212)
% plot(Y)


seuil = 0.15*max(BG6);

for i = 1:length(BG6)
    if abs(BG6(i)) < seuil
        y(i) = 0;
    else
        y(i) = BG6(i);
    end
end

N = 2000;
k = 1;

for i = N+1:length(BG6)
    aux = y(i-N:i)==zeros(size(y(i-N:i)));
    if  sum(aux) == N && y(i)~=0
        
        position(k)=i;
        k = k+1;
        
    end
        
end

Z = zeros(size(BG6));
Z(position) = 1;

figure
hold on 
plot(BG6);
plot(Z);
hold off

