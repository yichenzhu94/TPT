close all;
clear all;

N=1000;
fs=4000;%Hz
K=2;
amp0=1;
phi=0;
tt=N/fs; %(s)
t=0:(tt/1000):tt;
t=t(2:end);
sigma=0.1;

f(1)=500;
f(2)=1000;
%amp=amp0*0.01*(1:K).^2;
amp=amp0*ones(1,K);
composant=zeros(K,N);

for i=1:K
    composant(i,:)=amp(i)*sin(2*pi*f(i)*t+phi);
end
noise=sigma*randn(1,N);
s=sum(composant)+noise;

SNR=10*log10(power(sum(composant),2)/power(noise,2))

figure(1);
plot(t,s);
%%
% Standard
periodo = periodogram(s);

% Bartlett
L=10;
periodoBartlett = bartlett(s, L);
n=length(periodoBartlett);

%Welsh
alpha=0.5;
periodoWelsh = welsh(s,L,alpha);

df=fs/N;
fN=(1:N)*df;
figure(2);
plot(fN(1:N/2), periodo(1:N/2));

df=fs/n;
fn=(1:n)*df;
figure(3);
plot(fn(1:n/2), periodoBartlett(1:n/2));

figure(4);
plot(fn(1:n/2), periodoWelsh(1:n/2));
%%
%lpc
variance=0.1;
coeffE=lpc(s,4);
sE= genAR(coeffE,N,variance);

% Standard
periodoLPC = periodogram(sE);

% Bartlett
periodoBartlettLPC = bartlett(sE, L);

%Welsh
periodoWelshLPC = welsh(sE,L,alpha);

figure(5);
plot(fN(1:N/2), periodo(1:N/2)/max(periodo));
hold on;
plot(fN(1:N/2), periodoLPC(1:N/2)/max(periodoLPC));

figure(6);
plot(fn(1:n/2), periodoBartlett(1:n/2)/max(periodoBartlett));
hold on;
plot(fn(1:n/2), periodoBartlettLPC(1:n/2)/max(periodoBartlettLPC));

figure(7);
plot(fn(1:n/2), periodoWelsh(1:n/2)/max(periodoWelsh));
hold on;
plot(fn(1:n/2), periodoWelshLPC(1:n/2)/max(periodoWelshLPC));
%%
%capon
specCapon=capon(s,100,N);
df=fs/N;
fn=(1:N)*df;
figure(8);
plot(fN(1:N/2), periodo(1:N/2)/max(periodo));
hold on;
plot(fN(1:N/2), periodoLPC(1:N/2)/max(periodoLPC));
hold on;
plot(fN(1:N/2), specCapon(1:N/2)/max(specCapon));

