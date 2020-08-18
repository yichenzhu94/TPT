close all;
clear all;

coeffAR = [0.1 0.2];
coeffMA = [0.1 0.2];
variance = 0.1;
N = 1000;
X = genARMA(coeffAR,coeffMA,N,variance)';

%%
% Standard
periodo = periodogram(X);

% Bartlett
L=100;
periodoBartlett = bartlett(X,L);
n=length(periodoBartlett);

%Welsh
alpha=0.5;
periodoWelsh = welsh(X,L,alpha);

autoc1=autocorr(X,N-1);
spec1=abs((fft(autoc1)));
autoc2=autocorr(X,n-1);
spec2=abs((fft(autoc2)));

biaisS=mean(periodo)-mean(spec1);
biaisB=mean(periodoBartlett)-mean(spec1);
biaisW=mean(periodoWelsh)-mean(spec1);
varS=var(periodo);
varB=var(periodoBartlett);
varW=var(periodoWelsh);

figure(1);
plot(periodo(1:N/2+1)/max(periodo));
hold on;
plot(spec1(1:N/2+1)/max(spec1));
figure(2);
plot(periodoBartlett(1:n/2+1)/max(periodoBartlett));
hold on;
plot(spec2(1:n/2+1)/max(spec2));
figure(3);
plot(periodoWelsh(1:n/2+1)/max(periodoWelsh));
hold on;
plot(spec2(1:n/2+1)/max(spec2));

%% Durbin
p = length(coeffAR);
q = length(coeffMA);
DSP_durbin = durbin(X,p,q);

v = length(DSP_durbin);
figure(4)
plot(DSP_durbin(1:v/2+1)/max(DSP_durbin));
hold on;
plot(spec1(1:N/2+1)/max(spec1));

%% Application audio
[signal,fs]=audioread('an_in_on.wav');
signal=signal';
N=length(signal);
sound(signal,fs);
%standard
periodoS = periodogram(signal);
% Bartlett
periodoSBartlett = bartlett(signal,L);
n=length(periodoSBartlett);
% Welsh
periodoSWelsh = welsh(signal,L,alpha);
% Durbin
periodoSDurbin = durbin(signal,p,q);

df=fs/N;
fN=(1:N)*df;
df=fs/n;
fn=(1:n)*df;

figure(5);
plot(fN(1:N/2), periodoS(1:N/2)/max(periodoS));
hold on;
plot(fn(1:n/2), periodoSBartlett(1:n/2)/max(periodoSBartlett));
hold on;
plot(fn(1:n/2), periodoSDurbin(1:n/2)/max(periodoSDurbin));
hold on;
plot(fn(1:n/2), periodoSWelsh(1:n/2)/max(periodoSWelsh));