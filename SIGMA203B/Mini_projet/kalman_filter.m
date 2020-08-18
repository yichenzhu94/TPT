function [M, Parray] = kalman_filter(Y, m_0, P_0, A, B, Q, R)
 % Filtre de Kalman: 
 % Filtre sequentiellement les observations Y 
 % pour reconstruire le signal X
 %%%
 % ARGUMENTS: 
 % Y: les observations : une matrice T * q
 % m_0: vecteur colonne p * 1 : moyenne a priori de l'etat initial 
 % P_0: matrice p*p: variance a priori de l'instant initial
 % A, B: matrices definissant la dynamique de l'etat 
 % et le modele d'observation
 % Q, R: variances des bruits pour l'equation d'etat
 % et l'equation d'observation. 
 %%%
 % VALEUR:
 % M: Matrice T * p: les moyennes a posteriori
 % Parray:  Array de dimension p*p*T  les matrices de covariances 
 %          des lois de filtrages successives
  dim_state = size(A,1); %% dimension  des etats 
  dim_obs = size(B,1); %% dimension des  observations 
  T = size(Y,1); 

% initialisation 
  P = P_0; 
  m = m_0; 
  M = zeros(T,dim_state);
  Parray = zeros(dim_state,dim_state,T);
  for k = 1:T
    % prediction 
      [mpred, Ppred] = kalman_predict( m, P, A, Q );  
    % mise a jour 
      [mu, Pu] = kalman_update(Y(k,:), mpred, Ppred, A, B, Q, R);
    % reaffectation de l'etat courant 
      m = mu; 
      P = Pu;
    % stockage
      M(k,:) = mu';
      Parray(:,:,k) = P;
  end
end
