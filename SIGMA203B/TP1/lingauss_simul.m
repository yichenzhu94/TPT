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
  x = x_0;

  for i = 1:T
    [X(i,:),Y(i,:)] = lingauss_step(x,A,B,Q,R);
     x = X(i,:);
  end
 
end     
