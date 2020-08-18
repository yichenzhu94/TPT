function [mu, Pu] = kalman_update(y, mpred, Ppred, A, B, Q, R)
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

  p = length(mpred);
  dim_state = size(A,1);
  dim_obs = size(B,1);
  S =  B*Ppred*B' + R;
  K =  Ppred*B'*inv(S);
  mu = mpred + K*(y'-B*mpred);
  Pu = (eye(p)-K*B)*Ppred;
end
