%% Algorithme RLS

close all
clear all
clc

% Initialisation
[x,Fs] = audioread('voyo.wav');
p = 20;
theta = zeros(p,1);
delta = 0.0001;
Q = (1/delta)*eye(p);
lambda = 0.9;
size = length(x);
J_theta = 0;

% Algorithme RLS
for i = p+1 : size
    
    y = x(i-p:i-1);
    k = ((1/lambda)*Q*y)/(1+(1/lambda)*y'*Q*y);
    e(i-p) = x(i) - y'*theta;
    theta = theta + k*e(i-p);
    Q = (1/lambda)*Q - (1/lambda)*k*y'*Q;
    J_theta = J_theta + (lambda^(size-i))*e(i-p);

end

% Visualisation de résultat
figure
subplot(211)
plot(x)
subplot(212)
plot(e)
soundsc(x,Fs);
pause(3);
soundsc(e,Fs);

%% Recherche de la fréquence de pitch

%spectrogramme
figure
plot(e);
spectro(e,Fs,4096*2,20e-2,10e-2);

%périodogramme
P = periodogram(e);
f = 0:length(P)/2-1;
figure
plot(f,P(length(P)/2+1:end));

%autocorrélation
figure
plot(autocorr(e,length(e)-1));