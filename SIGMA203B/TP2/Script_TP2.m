%%%%%%%%%%%%%%%%%%%%%%
%%% 1.2 reconstruction 
%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc

T = 3000;
L = 100;
h = 0.01; %% pas
sigma = 0.5; %% sd acceleration
tau = 0.01;  %% sd observation 
z_0 = [50,5];
v_0 = [0.5,0.5];
[X,Y] = voiture_angle_simul(z_0,v_0,L,T,sigma,tau,h);

R_obs = L*(cos(Y(:,2))./sin(Y(:,1)-Y(:,2)));
Z1_obs = R_obs.*cos(Y(:,1));
Z2_obs = R_obs.*sin(Y(:,1));
Z_obs = [Z1_obs, Z2_obs];

close all
figure(1)
hold on;
plot(Z_obs(:,1), Z_obs(:,2), 'og');
plot(X(:,1), X(:,2),'b');
legend( 'true state', 'observations');
title('trajectory (Z1,Z2) reconstructed from angular measures (theta1,theta2)')
hold off;

%%
%%%%%%%%%%%%%%%%%%%%%
%%% 2.5 Visualisation 
%%%%%%%%%%%%%%%%%%%%%

% Priors sur l'etat initial 
m_0 = [60,60,0,0];
P_0 = 100 * eye(4);
h=0.01;

% filtrage 
[M, Parray] = ekf_voiture(Y, m_0, P_0, L, sigma, tau, h);

R_obs = L*(cos(Y(:,2))./sin(Y(:,1)-Y(:,2)));
Z1_obs = R_obs.*cos(Y(:,1));
Z2_obs = R_obs.*sin(Y(:,1));
Z_obs = [Z1_obs, Z2_obs];

close all
figure(2)
hold on;
plot(M(:,1), M(:,2),'r');
plot(X(:,1), X(:,2), 'b');
plot(Z_obs(:,1), Z_obs(:,2), 'og');
legend('filtered', 'true state', 'observations');
title('trajectory (Z1,Z2) reconstructed from angular measures(theta1,theta2) and from  the kalman filter')
hold off;

