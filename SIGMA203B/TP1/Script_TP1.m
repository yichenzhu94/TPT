close all
clear all
clc

x_0 = [1; 2; 3];
A = 0.1 * [1 , 1, 0 ;
           0 , 1 , 1 ;
           0 , 0 , 1 ];
B = [1, 0, 0;
0, 1, 1];
cholQ = [0.5, 0.5, 0.5
        0, 1, 1;
        0, 0, 1];
Q = cholQ*cholQ';
cholR = 0.5*[1, 1;
            0, 2];
R = cholR*cholR';

% une iteration dans le modele: lingauss_step
[x,y] = lingauss_step(x_0, A, B, Q, R );

%% Simu
sigma = 2; %%evol
tau = 5;  %% obs
x_0 = [1,2,-1];
T = 500;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A-2: parametres structurels
A = eye(3);
B = [1 0 0;
     0 1 0];
%Rotation
% thetaB = pi/3;
% psiB = pi/3;
% B =[1, 0, 0; 
%     0, 1, 0] * ...
%    [ 1,  0,  0 ;
%      0 , cos(thetaB), -sin(thetaB) ; 
%      0, sin(thetaB), cos(thetaB)] * ...
%    [   cos(psiB), 0 , -sin(psiB) ; 
%        0   ,      1 ,  0 ;
%        sin(psiB), 0, cos(psiB)];
Q = sigma^2 * eye(3);
R = tau^2 * eye(2);
[X, Y] = lingauss_simul(x_0, T, A, B, Q, R);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%B:  visualisation, eventuellement 'step by step'
close all;
figure(1)
hold on;
plot(X(:,1), X(:,2), 'b');
plot(Y(:,1), Y(:,2),'og');
legend('State', 'Observation')
title('Random walk observed with uncorrelated noise')
hold off; 

for i = 1:2
figure(i+1)
hold on;
plot(X(:,i), 'b');
plot(Y(:,i), 'og');
title(strcat('component', num2str(i) ));
legend('State', 'Observation');
hold off;
end

% figure(4)
% disp('<push any key to proceed to next time steps>');
% clc; 
% hold on;
% for k=1:T
%   if rem(k,10)==1
%      plot(X(1:k, 1), X(1:k,2), 'b') ;
%      plot(  Y(1:k, 1), Y(1:k, 2),'og');
%      drawnow; 
%      pause;
%    end 
% end
% hold off;

%% Filtre Kalman

m_0 = [0,0,0];
P_0 = 100 * eye(3);

% filtrage 
[M, Parray] = kalman_filter(Y, m_0, P_0, A, B, Q, R);
% Visualisation

close all;
for i = 1:3
  figure(i)
  hold on;
  plot(1:T, M(:,i), 'r');
  plot(1:T, X(:,i), 'b');
  sd  = reshape(sqrt(Parray(i,i,:) ), T,1);
  plot(1:T, M(:,i) + 1.96 * sd, 'y');
  if i <3
    plot(1:T, Y(:,i), 'g');
    legend('filtered', 'state', 'conf bands', 'observation')
  else
    legend('filtered', 'state', 'conf bands')
  end
  plot(1:T, M(:,i) - 1.96 * sd, 'y');
  title(strcat('component ', num2str(i)))
  hold off;
end 

figure(4)
hold on;
plot(M(:,1), M(:,2),'r');
plot(X(:,1), X(:,2), 'b');
plot(Y(:,1), Y(:,2), 'og');
title('trajectory of the two first components')
legend('filtered', 'state', 'observations')
hold off;

%% Application car tracking
h = 0.001;
sigma = 3000; %evolution
tau = 10; %% observation 
x_0 = [10,10,1,0.5];
T = 1000;
A = [1 0 h 0;
     0 1 0 h;
     1 0 0 0;
     0 1 0 0];
B = [1 0 0 0;
     0 1 0 0];
Q = sigma^2*[h^3/3 0 h^2/2 0;
             0 h^3/3 0 h^2/2;
             h^2/2 0 h 0;
             0 h^2/2 0 h];
R = tau^2*eye(2);

[X, Y] = lingauss_simul(x_0, T, A, B, Q, R);

% close all;
% figure(1)
% hold on;
% plot(X(:,1), X(:,2), 'b');
% plot(Y(:,1), Y(:,2),'og');
% legend('State', 'Observation')
% title('Random walk observed with uncorrelated noise')
% hold off;
% 
% for i = 1:2
% figure(i)
% hold on;
% plot(X(:,i), 'b');
% plot(Y(:,i), 'og');
% title(strcat('component', num2str(i)));
% legend('State', 'Observation');
% hold off;
% end

% figure(4)
% disp('<push any key to proceed to next time steps>');
% clc; 
% hold on;
% for k=1:T
%   if rem(k,10)==1
%      plot(X(1:k, 1), X(1:k,2), 'b') ;
%      plot(  Y(1:k, 1), Y(1:k, 2),'og');
%      drawnow; 
%      pause;
%    end
% end
% hold off;

m_0 = [0,0,0,0];
P_0 = 100 * eye(4);
[M, Parray] = kalman_filter(Y, m_0, P_0, A, B, Q, R);
% Visualisation
close all;
for i = 1:4
  figure(i)
  hold on;
  plot(1:T, M(:,i), 'r');
  plot(1:T, X(:,i), 'b');
  sd  = reshape(sqrt(Parray(i,i,:) ), T,1);
  plot(1:T, M(:,i) + 1.96 * sd, 'y');
  if i <3
    plot(1:T, Y(:,i), 'g');
    legend('filtered', 'state', 'conf bands', 'observation')
  else
    legend('filtered', 'state', 'conf bands')
  end
  plot(1:T, M(:,i) - 1.96 * sd, 'y');
  title(strcat('component ', num2str(i)))
  hold off;
end

figure
hold on;
plot(M(:,1), M(:,2),'r');
plot(X(:,1), X(:,2), 'b');
plot(Y(:,1), Y(:,2), 'og');
title('trajectory of the two first components')
legend('filtered', 'state', 'observations')
hold off;