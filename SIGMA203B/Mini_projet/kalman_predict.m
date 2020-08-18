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
 dim_state = max(size(m));
 m = reshape(m, dim_state, 1);
 mpred = A*m;
 Ppred = A*P*A' + Q;
end      