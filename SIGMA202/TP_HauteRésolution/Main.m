close all;
clear all;
clc

%% Synthèse 

N = 63;
delta = [0 -0.05];
f = [1/4 1/4+1/N];
a = [1 10];
phi = [rand rand];
x = Synthesis(N,delta,f,a,phi);

%% Tracer les périodogramme avec fft avec et sans zéro padding
periodo1 = (fftshift(abs(fft(real(x),N))).^2)/N;
periodo2 = (fftshift(abs(fft(real(x),1024)))).^2/1024;
f1 = -0.5:1/(length(periodo1)-1):0.5;
f2 = -0.5:1/(length(periodo2)-1):0.5;

figure
plot(f1,periodo1/max(periodo1));
hold on
plot(f2,periodo2/max(periodo2));

%% ESPRIT
n = 32;
K = 2;
[delta,f] = ESPRIT(x,n,K);
[a_estime,phi_estime] = LeastSquares(x,delta,f);
figure
subplot(211)
plot(a_estime);
subplot(212)
plot(phi_estime);

%% MUSIC

MUSIC(x,n,K);

%% Application

resolu = 1024;
[s,Fs] =  audioread('ClocheA.wav');
periodo_cloche = (fftshift(abs(fft(real(s),resolu))).^2)/resolu;
fperiodo = -0.5:1/(length(periodo_cloche)-1):0.5;
figure
plot(fperiodo,periodo_cloche);

%% Haute résolution

K = 54;
n = 512;
l = 2*n;
N = n + l -1;
s2 = s(10000:10000+8000);

[delta,f]=ESPRIT(s2, n, K);
[a,phi]= LeastSquares(s2, delta, f);

figure
stem(f,a);

s_reconstruit = Synthesis(length(s), delta, f, a, phi);
figure
subplot(211)
plot(s);
subplot(212)
plot(real(s_reconstruit));

soundsc(real(s), Fs);
pause(length(s)/Fs)
soundsc(real(s_reconstruit),Fs);
