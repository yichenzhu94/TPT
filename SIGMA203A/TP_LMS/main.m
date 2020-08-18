%% Test LMS
close all
clear all
clc

n = 10000;
Y = randn(1,n);
H = [1 0.3 -0.2 0.1 0.05];
X = filter(H,1,Y);
S = randn(1,n);

[S_est, EQM] = LMS(n,50,X,Y,S);

figure
plot(10*log10(EQM));


%% Test NLMS
close all
clear all
clc

n = 3000;
Y = randn(1,n);
H = [1 0.3 -0.2 0.1 0.05];
X = filter(H,1,Y);
S = randn(1,n);

[S_est2,EQM2] = NLMS(n,50,X,Y,S);

figure
plot(10*log10(EQM2));

%% Application
close all
clear all
clc

load('les2voies.mat')
Fs = 14400;
Y = yn_HP';
Z = zn_somme';
n = length(Z);
p = 60;

[X_est] = remove_echo(n,p,Z,Y);
S_est = Z - X_est';

% soundsc(Z,Fs)
% pause(8)
% soundsc(S_est,Fs)
% pause(8)
% soundsc(X_est,Fs)

figure
subplot(211)
plot(Z);
subplot(212)
plot(S_est);
