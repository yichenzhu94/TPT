%% 
clear all
close all
clc
%% ex3

N=63;
f0=1/4;
f1=f0+1/N;
a0=1;
a1=10;
delta0=0; 
delta1=-0.05;
x=Synthesis(N, [delta0 delta1], [f0 f1], [a0 a1], [rand rand]);

%% ex3.1

close all
%without zero-padding
period=fftshift(abs((fft(real(x), N)))).^2/N;
%with zero-padding
period2=fftshift(abs((fft(real(x), 1024)))).^2/1024;

f1=-0.5:1/(length(period)-1):0.5;
f2=-0.5:1/(length(period2)-1):0.5;

figure(1)
plot(f1,period);
xlabel('f');
ylabel('|X(f)|');
grid on
title('Periodogramme')
hold on
plot(f2,period2,'r');
legend('without zero-padding', 'with zero-padding')

%% ex3.2.1.
%Application de la fonction ESPRIT

n=32; K=2;
[deltak fk]= ESPRIT(x, n, K);
[alpha amp phi]= LeastSquares(x, deltak, fk, N, K);
figure();
plot(amp);

%% ex3.2.2
%MUSIC
P=MUSIC(x, n, K);
figure();
surf(log(P));
%% ex4.1
%Application à des signaux de parole

[cloche fs]= audioread('ClocheA.WAV');
cloche2=cloche(10000:10000+1534);
N=length(cloche2); 
n=512; K=54;
l=2048;
period=(abs(fftshift(fft(real(cloche), l ))));

%df=fs/l ;
%f1=(1:l)*df;
f1=-0.5:1/(length(period)-1):0.5;
figure();
plot(f1,period);
xlabel('f'); ylabel('|X(f)|');
grid on;
title('Periodogramme Cloche A');
% ex4.2

[delta f]=ESPRIT(cloche2, n, K);
[alpha amp phi]= LeastSquares(cloche2, delta, f, N, K);

hold on;
%df=fs/length(amp) ;
%f2=(1: length(amp))*df;
stem(f, amp.*abs(1-exp(delta*N))./abs(1-exp(delta)) );
%stem(f, amp);
% ysint= Synthesis(0.5*length(cloche), delta, f, amp, phi);

soundsc(real(cloche(1:0.5*length(cloche)))/max(real(cloche(1:0.5*length(cloche)))), fs);
% sound(real(ysint) /max(real(ysint)),fs);
