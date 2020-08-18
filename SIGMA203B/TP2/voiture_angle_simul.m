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


  Q = sigma^2 *  [ h^3/3 , 0    , h^2/2  ,  0     ;
                    0,     h^3/3,   0    , h^2/2 ; 
                    h^2/2,   0   ,  h    ,   0   ;
                    0    , h^2/2   , 0   ,  h ] ;

  R = tau^2 * eye(2);
  X = zeros(0,4);
  Y = zeros(0,2);
  x = [z_0, v_0];
  
  for i=1:T
    e = mvnrnd(zeros(size(x)),Q);
    ita = mvnrnd(zeros(1,size(Y,2)),R);  
    x = (A*x' + e')';
    if x(1)<0
      break;
    end
    X = [X;x];
    y_mean = [atan(X(i,2)/X(i,1)),atan((X(i,2)-L)/X(i,1))];
    y = y_mean + ita;
    Y = [Y;y];
  end
end
