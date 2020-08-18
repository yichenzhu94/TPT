function [X,Y] = robot_grille_simul(T, L, walls, thetaState, thetaObs)
  %% ARGUMENTS
  %  T: nombre d'iterations 
  %  L: taille de la grille (0:L * 0:L, avec  murs en 0 et en L) 
  %  walls: matrice K * 4 : K : nombre de murs,
  %         colonnes: (abscisse 1, ordonnee 1, longueur, orientation)
  %         orientation = 1 pour horizontal, 0 pour vertical 
  %  thetastate:  parametre de la loi geometrique gouvernant 
  %               l' equation d'etat 
  %  thetaObs : idem poru l' equation observation
  %%%%%%%
  % Le robot choisit une des 4 directions au hasard, une longueur de
  % deplacement suivant une loi geometrique et se deplace du nombre de
  % case maximum dans ladite direction telle que sa trajectoire ne
  % rencontre aucun mur ni le bord de la grille; 
  % Observation : la position 'bruitee' d'une loi geometrique selon 
  % une des 4 directions.  Ne tient pas compte des limites du domaine
  %  ni des murs
  %%%%%%%
  %% VALEUR X, Y: matrices T* 2
  %       (abscisses et ordonnées des états et des observations)

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %Initialisation
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  [walls, x] = robot_grille_init(L, walls);
  X = zeros(1,2);
  %%%%%%%%%%%%%%%%%%%%%%%%% boucle 'temporelle' %%%%%%%%%%%
  for k = 1:T
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% evolution du robot
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    x = robot_grille_stateStep(x, walls, thetaState) ;
    X(k,:) = x ;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% observation 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*
    Sign = discrete_rnd( 2, [-1, 1], 1/2 * ones(1,2) ) ; 
    %% [-1 ou 1, -1 ou 1]
    noise= geornd(2, thetaObs) ;
    Y(k,:)= x + Sign .* noise ; 
  end
end
      

