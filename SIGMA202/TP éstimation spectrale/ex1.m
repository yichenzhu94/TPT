close all;
clear all;

coeff = [1 0.5];
variance =0.1;
N = 1000;
X = genAR(coeff,N,variance);

%%
%1.2
% Standard
periodo = periodogram(X);

% Bartlett
L=100;
periodoBartlett = bartlett(X, L);
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
%%
%ex1.3
[coeffE,vvv]=lpc(X,length(coeff));
%error=mean((coeffE(2:end)-coeff).^2);
XE= genAR(coeffE,N,variance);
specE=abs((fft(autocorr(XE,N-1))));

figure(4);
plot(spec1(1:N/2+1)/max(spec1));
hold on;
plot(specE(1:N/2+1)/max(specE));

%%
%ex1.4
[voyelle,fs]=audioread('aeiou.wav');
voyelle=voyelle';
N=length(voyelle);
sound(voyelle,fs);
%standard
periodoV = periodogram(voyelle);
% Bartlett
periodoVBartlett = bartlett(voyelle,L);
n=length(periodoVBartlett);
%Welsh
periodoVWelsh = welsh(voyelle,L,alpha);

df=fs/N;
fN=(1:N)*df;
df=fs/n;
fn=(1:n)*df;

figure(6);
plot(fN(1:N/2), periodoV(1:N/2)/max(periodoV));
hold on;
plot(fn(1:n/2), periodoVBartlett(1:n/2)/max(periodoVBartlett));
hold on;
plot(fn(1:n/2), periodoVWelsh(1:n/2)/max(periodoVWelsh));