%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% Kalman Etendu: TP 2  Sigma 204 %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% Car Tracking capteurs angulaires %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CODE CHUNKS
%% DO NOT RUN 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Exercice 1 : simulation et reconstruction de la trajectoire
%%%              à partir d'angles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%
%% 1.1 Simulation
%%%%%%%%%%%%%%%%%
    function [X,Y]= voiture_angle_simul(z_0, v_0, L, T, sigma, tau, h)
% Voiture brownienne avec observation des angles seulement: 
% Etat: X = (Z_1, Z_2, V_1, V_2) (position vitesse : 4 dimensions)
% Observation: On observe l'angle de la direction de la voiture depuis 2 capteurs 
% sur l'axe (0y), le premier en (0,0), le second en (0,L). 
% La voiture s'arrete lorsque son abscisse atteint 0 (crash). 
% ARGUMENTS
 % z_0: vecteur de taille 2; position initiale (premier element strictement positif
 % v_0: vecteur de taille 2, vitesse initiale. 
 % L:  position du deuxieme capteur sur l'axe vertical
 % T: horizon temporel: nombre d'iterations. 
 % sigma, tau: parametres d'ecart type pour les  bruits de 
 %             l'equation d'etat et  de  l'equation d'observation. 
 % h : pas de discretisation temporelle 
 % %
 % VALEUR: 
 % X: une matrice de taille (T,4) 
 % Y : une matrice de taille (T,2)

  A = [ 1, 0, h, 0 ;
        0, 1, 0, h ; 
        0, 0, 1, 0 ;
        0, 0, 0, 1 ] ;


  Q = sigma^2 *  [ h^3/3 , 0    , h^2/2 , 0     ;
                    0,      h^3/3, 0     , h^2/2 ; 
                    h^2/2,   0   ,  h    ,   0   ;
                    0     , h^2/2     , 0     , h ] ;

  R = tau^2 * eye(2);
  X = zeros(0, 4);
  Y = zeros(0,2);
  x = [z_0, v_0];
  for i=1:T
    x = %% Completer 
    if x(1)<0
      break;
    end
    X = [X;x];
    y_mean =  %% completer 
    y =  %% completer (simuler une loi normale multivariee)
    Y = [Y;y];
  end
end


%%%%%%%%%%%%%%%%%%%%%%
%%% 1.2 reconstruction 
%%%%%%%%%%%%%%%%%%%%%%

T = 3000;
L = 100; 
h = 0.01; %% pas  
sigma = 0.5 %% sd acceleration
tau = 0.1  %% sd observation 
z_0 = [50,5];
v_0 = [0.5,0.5];
[X, Y] = voiture_angle_simul(z_0, v_0, L, T, sigma, tau, h);

R_obs =  %% Completer 
Z1_obs =  %% completer 
Z2_obs = %% completer 
Z_obs = [Z1_obs, Z2_obs]; 

close all
figure(1)
hold on;
plot(Z_obs(:,1), Z_obs(:,2), 'og');
plot(X(:,1), X(:,2), 'b');
legend( 'true state', 'observations');
title('trajectory (Z1,Z2) reconstructed from angular measures (theta1,theta2)')
hold off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Exercice 2 : filtrage par EKF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%
%% 2.3 mise à jour
%%%%%%%%%%%%%%%%%%

function [mu, Pu] = ekf_update(y,  mpred, Ppred, ypred,  A, B, R)
 % Etape de mise a jour  dans le filtre de Kalman etendu: 
 % ARGUMENTS
 % mpred, Ppred: moyenne et variance de la loi predictive courante,
 % y: vecteur de taille q: nouvelle observation
 % ypred: l'observation predite: matrice colonne:  
 %  B: Matrice  q*p definissant la dynamique linearisee 
 %       de l'etat et du modele d'observation 
 %  R: Variance des bruits pour l'equation  d'observation.de taille  q 
 % VALEUR: 
 % mu, Pu : moyenne et matrice de covariance  de 
 %          la loi de filtrage apres l'etape de mise a jour  

  dim_state = size(A,1);
  dim_obs = size(B,1);
  S =  %% completer 
  K =  %% Completer (Gain de Kalman)
  mu =  %% completer 
%% !!  difference avec kalman classique: ypred remplace B* xpred. 
  Pu = %% 
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2.4 fonction principale: Filtre de kalman étendu (EKF).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
  function [M, Parray] = ekf_voiture(Y, m_0, P_0, L, sigma,  tau, h)
 % Filtre de Kalman pour la voiture a capteurs directionnels
 % Filtre sequentiellement les observations Y 
 % pour reconstruire le signal X
 %%%
 % ARGUMENTS: 
 % Y: les observations : une matrice T * 2
 % m_0: vecteur colonne 2 * 1 : moyenne a priori de l'etat initial 
 % P_0: matrice 2*2: variance a priori de l'instant initial
 % L : ecartement des deux capteurs sur l'axe 0y
 % sigma, tau: bruits sur l'etat et l'observation (cf pendule_step.m)
 % h: pas de discretisation 
 %%%
 % VALEUR:
 % M: Matrice T * 4: les moyennes a posteriori
 % Parray:  Array de dimension 4*4*T  les matrices de covariances 
 %          des lois de filtrages successives
  dim_state = 4;
  dim_obs = 2;
  T = size(Y,1);
  A = [ 1, 0, h, 0 ;
	0, 1, 0, h ; 
	0, 0, 1, 0 ;
	0, 0, 0, 1 ] ;

  Q = sigma^2 *  [ h^3/3 , 0    , h^2/2 , 0     ;
		   0,      h^3/3, 0     , h^2/2 ; 
		   h^2/2,   0   ,  h    ,   0   ;
		   0     , h^2/2     , 0     , h ] ;

  R = tau^2 * eye(dim_obs);
  P = P_0; m = reshape(m_0,dim_state,1) ;
  M = zeros(T,dim_state);
  Parray = zeros(dim_state,dim_state, T);
  for k=1:T
    %%%%%%%%%%%%%%%%%%
    %% prediction : comme dans   Kalman (equation  lineaire)
    %%%%%%%%%%%%%%%%%%
    mpred =  %% completer 
    Ppred =  %% completer 
    %%%%%%%%%%%%%%%%%%%
    %% mise a jour
    %%%%%%%%%%%%%%%%%%%
    %% Differentielle de g au point mpred
    r1 = mpred(1)^2 + mpred(2)^2;
    r2 = mpred(1)^2 + ( mpred(2) - L)^2;
    B = %% completer 
    ypred = %% completer 
    [mu, Pu] = ekf_update(Y(k,:),  mpred , Ppred, ypred, A, ...
			  B, R);
    %% reaffectation de l'etat courant
    m = mu; P = Pu;
	     %% stockage
    M(k,: ) = mu';
    Parray(:,:,k) = P;	  
  end
end

%%%%%%%%%%%%%%%%%%%%%
%%% 2.5 Visualisation 
%%%%%%%%%%%%%%%%%%%%%

% Priors sur l'etat initial 
m_0 = [60,60,0,0];
P_0 = 100 * eye(4);

% filtrage 
[M, Parray] = ekf_voiture(Y, m_0, P_0, L, sigma, tau, h=0.01);

R_obs =  %% completer comme dans l'exercice 1 
Z1_obs = %% completer comme dans l'exercice 1 
Z2_obs = %% completer comme dans l'exercice 1 
Z_obs = [Z1_obs, Z2_obs]; 

close all
figure(2)
hold on;
plot(M(:,1), M(:,2),'r');
plot(X(:,1), X(:,2), 'b');
plot(Z_obs(:,1), Z_obs(:,2), 'og');
legend('filtered', 'true state', 'observations');
title('trajectory (Z1,Z2) reconstructed from angular measures
(theta1,theta2) and from  the kalman filter')
hold off;

