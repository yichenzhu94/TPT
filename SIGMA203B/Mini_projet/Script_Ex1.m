close all
clear all
clc

%% Data generation

T = 16000;
S = 100*eye(2);
Q = 0.001*eye(2);
R = 10;
omega = 0.2;
gamma = 0.0001;
x_0 = mvnrnd(zeros(2,1),S);

A = [cos(omega) -sin(omega);
     sin(omega) cos(omega)];
A = exp(-gamma)*A;
B = sqrt(2)*[1 0];

[X, Y] = lingauss_simul(x_0, T, A, B, Q, R);
figure(1)
hold on
plot(Y)
plot(X(:,1))
hold off

%% Denoising

m_0 = [0 0];
P_0 = 100*eye(2);
[M, Parray] = kalman_filter(Y, m_0, P_0, A, B, Q, R);

for i = 2:3
figure(i)
hold on;
plot(1:T, M(:,i-1), 'r');
plot(1:T, X(:,i-1), 'b');
% sd = reshape(sqrt(Parray(i,i,:) ), T,1);
% plot(1:T, M(:,i) + 1.96 * sd, 'y');
% if i < 2
% plot(1:T, Y(:,i), 'g');
% legend('filtered', 'state', 'conf bands', 'observation')
% else
% legend('filtered', 'state', 'conf bands')
% end
% plot(1:T, M(:,i) - 1.96 * sd, 'y');
title(strcat('component ', num2str(i-1)))
hold off;
end

figure(4)
hold on
plot(M(:,1),M(:,2));
plot(X(:,1),X(:,2));
hold off

%% Restoration

Y(4800:11200) = 0;
B = ones(T,1)*(sqrt(2)*[1 0]);
B(4800:11200,:) = 0;
%[M, Parray] = kalman_filter(Y, m_0, P_0, A, B, Q, R);
m = m_0';
P = P_0;

for k = 1:T
    % prediction 
      [mpred, Ppred] = kalman_predict( m, P, A, Q );
    % mise a jour 
%       S =  B(k)*Ppred*B(k)' + R;
%       K =  Ppred*B(k)'*inv(S);
%       mu = mpred + K*(Y(k)-B(k,:)*mpred);
%       Pu = (eye(2)-K*B(k))*Ppred;
      [mu, Pu] = kalman_update(Y(k), mpred, Ppred, A, B(k,:), Q, R);
    % reaffectation de l'etat courant 
      m = mu; 
      P = Pu;
    % stockage
      M(k,:) = mu';
      Parray(:,:,k) = P;
end
 
figure()
hold on
plot(X(:,1))
plot(M(:,1))
hold off
    