% Exo 1 Q1 
close all
clear all
clc

u = 3;
N = 1000;

%% MC naif
sampleN = normrnd(0,1,1,N);
excess = sampleN >= u ;
estMean = cumsum(excess)./(1:N );
estVar = cumsum((excess - estMean).^2 )./ (1 : N).^2;
estSD = sqrt(estVar);
%%
figure(1)
hold on
plot(1:N, estMean, ...
    1:N ,  1 - normcdf(u,0,1) , ...
    1:N , estMean + 1.96 * estSD , 'linewidth', 2) 
legend('MC naif', 'vraie valeur', 'intervalle de confiance');
plot(1:N, estMean - 1.96 * estSD, 'color', 'r', 'linewidth', 2) ;
title('MC naif')
hold off

%% importance avec proposition exponentielle de moyenne lambda, 
% translatee de u

lambda = 2;
X  =  u + exprnd(lambda,[1 N]);
W =   %% idem
estim_Tau = %%% Completer
true_Tau = 1 - normcdf(u,0,1);
relativeError = (estim_Tau - true_Tau) / true_Tau;