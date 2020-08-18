
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Exercice 1

function [x, y] = lingauss_step(x_current,  A, B, Q, R)
 % Genere (X_{k+1}, Y_{k+1}) dans 
 % le modele lineaire gaussien. 
 % ARGUMENTS:
 % A, B: matrices definissant la dynamique de l'etat et 
 %       le modele d'observation (de tailles resp. (p,p) et (q,p)) 
 % Q, R: variances des bruits pour l'equation d'etat et 
 %       l'equation d'observation. 
 % x_current: vecteur  de taille p
 % %
 % VALEUR: 
 % x: un vecteur colonne (dimensions (p,1))
 % y : un vecteur colonne (dimensions (q,1)  
  dim_state = max(size(x_current));
  dim_obs = size(B,1) ;
  x_current = reshape(x_current, dim_state, 1);
 %
 % completer le code 
 %
  y  = reshape(y , dim_obs,1);
end
%%%%%%%%%%%%%%%%%%%
function [X, Y] = lingauss_simul(x_0, T, A, B, Q, R)
 % Genere le processus ((X_{k}, Y_{k}), k = 1:T) 
 % dans le modele lineaire gaussien
 % ARGUMENTS: 
 % A, B: Matrices   definissant la dynamique de l'etat et 
 %       le modele d'observation (de tailles resp. (p,p) et (q,p))   
 % Q, R: Variances des bruits pour l'equation d'etat et 
 %       l'equation d'observation.
 % x_0:  Etat initial
 % T  :  nombre d'iterations
 % %
 % VALEUR:
 % X: une matrice de taille (T,p) 
 % Y : une matrice de taille (T,q)
 % N.B:  p et q sont determines par les arguments passes A et B.

  dim_state = size(A,1);
  dim_obs = size(B,1);
  X = zeros(T,dim_state);
  Y = zeros(T,dim_obs);
  x  = x_0;

  for i = 1:T
   %
   % Completez le code : utilisez la fonction 
   % lingauss_step de la  question precedente
   %
  end
 
end     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%A:  Simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A-1 parametres \'a modifier 
sigma = 10;
tau = 40;
x_0 = [1,2,-1];
T = 500;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A-2: parametres structurels
A = eye(3);
B = %% Completer
Q = sigma^2 * %% Completer 
R = tau^2 * %% Completer 
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
title(strcat('component  ', num2str(i) ));
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
%      pause ;
%    end 
% end
% hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%  Exercice 2 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [mpred, Ppred] = kalman_predict(  m, P, A, Q )
 % effectue l'etape de prevision dans le filtre de Kalman. 
 % Calcule la loi de prediction  [X_{k+1} | Y_{1:k}] 
 % ARGUMENTS: 
 % m, P: moyenne et variance de la loi de filtrage courante
 %       vecteur et matrice de taille p 
 % A : matrice p*p definissant la dynamique de l'etat 
 % Q : variance des bruits (matrice p*p) pour l'equation d'etat
 % VALEUR: 
 % mpred:  vecteur colonne p * 1: moyenne de la loi de prediction. 
 % Ppred:  matrice p*p: covariance de la loi de prediction. 
 dim_state = max(size(m)) ;
 m = reshape(m, dim_state, 1) ;
 mpred =  %% Completer  
 Ppred =  %% Completer 
end      

%%%%%%%%%%%%%%%%%%%%%%%%%%

function [mu, Pu] = kalman_update(y,  mpred, Ppred, A, B,  Q, R)
 % Etape de mise a jour  dans le filtre de Kalman: 
 % ARGUMENTS
 % mpred, Ppred: moyenne et variance de la loi predictive courante,
 %               valeur renvoyee par 'kalman_predict'
 % y: vecteur de taille q: nouvelle observation
 % A, B: Matrices p*p et q*p definissant la dynamique de l'etat 
 %       et le modele d'observation 
 % Q, R: Variances des bruits pour l'equation d'etat 
 %       et l'equation d'observation.de taille p et q 
 % VALEUR: 
 % mu, Pu : moyenne et matrice de covariance  de 
 %          la loi de filtrage apres l'etape de mise a jour  

  dim_state = size(A,1);
  dim_obs = size(B,1);
  S =  %% Completer 
  K =  %% Gain de Kalman (Completer)
  mu = %% Completer 
  Pu = %% Completer 
end

%%%%%%%%%%%%%%%%%%%%%%%%%

function [M, Parray] = kalman_filter(Y, m_0, P_0, A, B,  Q, R)
 % Filtre de Kalman: 
 % Filtre sequentiellement les observations Y 
 % pour reconstruire le signal X
 %%%
 % ARGUMENTS: 
 % Y: les observations : une matrice T * q
 % m_0: vecteur colonne p * 1 : moyenne a priori de l'etat initial 
 % P_0: matrice p*p: variance a priori de l'instant initial
 % A, B: matrices definissant la dynamique de l'etat 
 %      et le modele d'observation 
 % Q, R: variances des bruits pour l'equation d'etat 
 %       et l'equation d'observation. 
 %%%
 % VALEUR:
 % M: Matrice T * p: les moyennes a posteriori
 % Parray:  Array de dimension p*p*T  les matrices de covariances 
 %          des lois de filtrages successives
  dim_state = size(A,1); %% dimension  des etats 
  dim_obs = size(B,1); %% dimension des  observations 
  T = size(Y,1); 

%% initialisation 
  P = P_0; m = m_0 ; 
  M = zeros(T,dim_state);
  Parray = zeros(dim_state,dim_state, T);
  for k=1:T
    %% prediction 
          % Completer 
    %% mise a jour 
          % Completer 
    %% reaffectation de l'etat courant 
      m = mu; P = Pu;    
    %% stockage
      M(k,: ) = mu';
      Parray(:,:,k) = P;
  end
end    

%%%%%%%%%%%%%%%
%% TEST
%%%%%%%%%%%%%%%
  % Priors sur l'etat initial 
m_0 = [0,0,0];
P_0 = 100 * eye(3);

% filtrage 
[M, Parray] = kalman_filter(Y, m_0, P_0, A, B,  Q, R);
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

%%%%%%%%%%%%%%
%%  Rotation
thetaB = pi/3 
psiB = pi/3;
B =[1, 0, 0; 
    0, 1, 0] * ...
   [ 1,  0,  0 ;
     0 , cos(thetaB), -sin(thetaB) ; 
     0, sin(thetaB), cos(thetaB)] * ...
   [   cos(psiB), 0 , -sin(psiB) ; 
       0   ,      1 ,  0 ;
       sin(psiB), 0, cos(psiB)]    

