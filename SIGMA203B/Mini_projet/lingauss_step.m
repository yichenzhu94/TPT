function [x, y] = lingauss_step(x_current,A,B,Q,R)
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
 % p = length(x_current);
  
  dim_state = max(size(x_current));
  dim_obs = size(B,1);
  x_current = reshape(x_current, dim_state, 1);
% e = sqrt(Q)*randn(p,1); 
% ita = sqrt(R)*rand(q,1); Cela ne marche pas parce que cela ne change pas
% avec le temps
  e = mvnrnd(zeros(size(x_current)),Q);
  eta = mvnrnd(zeros(1,dim_obs),R);
  x = A*x_current + e';
  y = B*x + eta';
  x = reshape(x,dim_state,1);
  y  = reshape(y,dim_obs,1);
end