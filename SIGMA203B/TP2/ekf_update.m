function [mu, Pu] = ekf_update(y,mpred,Ppred,ypred,A,B,R)
 % Etape de mise a jour  dans le filtre de Kalman etendu: 
 % ARGUMENTS
 % mpred, Ppred: moyenne et variance de la loi predictive courante,
 % y: vecteur de taille q: nouvelle observation
 % ypred: l'observation predite: matrice colonne:  
 %  B: Matrice  q*p definissant la dynamique linearisee 
 %       de l'etat et du modele d'observation 
 %  R: Variance des bruits pour l'equation  d'observation.de taille q 
 % VALEUR: 
 % mu, Pu : moyenne et matrice de covariance de 
 %          la loi de filtrage apres l'etape de mise a jour  

  p = length(mpred);
  dim_state = size(A,1);
  dim_obs = size(B,1);
  S = B*Ppred*B' + R;
  K = Ppred*B'*inv(S);
  mu = mpred + K*(y'-ypred'); % !! difference avec kalman classique: ypred remplace B* xpred. 
  Pu = (eye(p)-K*B)*Ppred';

end