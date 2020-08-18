function xnew = robot_grille_stateStep(x,walls, thetaState)
% ARGUMENTS 
% x : etat courant 
% walls: matrice K * 4
% thetaState: parametre de la loi geometrique de l'etat
% VALEUR 
% xnew: nouvelle position

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%% evolution du robot
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  nstate = 1; 
  direction = discrete_rnd(nstate, 1:4, 1/4 * ones(1,4));
  %direction : (1 2 3 4) <-> (gauche bas droite haut)

  step = geornd(nstate, thetaState);
  orient = mod(direction, 2); %% horizontal <-> 1, vertical <-> 0
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%% impact possible sur un mur perpendiculaire au deplacement
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  candidat_walls_indices = (walls(:,4) ~= orient ) .* ...
			   (walls(:,orient+1 ) <= x(orient+1)).* ...
			   ( (walls(:,orient+ 1 ) + walls(:,3 ) ) >= ...
			     x(orient + 1)) ;
  %% mur vertical / horizontal
  %% ordonnee/abscisse  basse inferieure a la  position 			     
  %% ordonnee/abscisse haute superieure a la position ;

  candidat_walls = walls(logical(candidat_walls_indices), :) ;

  %% 2 - orient =1 : horizontal ; 2-orient ==2 : vertical
  distance_walls = candidat_walls(:,2 - orient) - x(2 - orient) ;
      
  if( (direction ==3) || (direction ==4)) %% vers la droite ou le haut
    dmin_abs = min(distance_walls( distance_walls > 0 ) );
  %% (minimum absolute distance)
  else   %%vers la gauche ou le bas
    dmin_abs = min(- distance_walls( distance_walls < 0 ) );
  end
  is_impact =  ( step >= dmin_abs) ;
   
  if(is_impact)
    step = dmin_abs -1 ;
  end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%% impact possible  sur un mur parallele au deplacement
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  candidat_walls_indices = ...
  (walls(:,4) == orient ) .*   (walls(:,orient+1 ) == x(orient+1)) ;
  %% mur vertical / horizontal; orient = 0 pour vertical
  %% ordonnee/abscisse  egale  a la  position
  candidat_walls = walls(logical(candidat_walls_indices), :) ;

  if( (direction ==3) || (direction ==4)) %% vers la droite ou le haut
    %% 2 - orient =1 : horizontal ; 2-orient ==2 : vertical
    distance_walls = candidat_walls(:,2 - orient) - x(2 - orient) ;
    dmin_abs = min(distance_walls( distance_walls > 0 ) );
  else
    distance_walls = candidat_walls(:,2 - orient) + ...
		     candidat_walls(:,3) - x(2 - orient) ;
    dmin_abs = min(- distance_walls( distance_walls < 0 ) );
  end
  is_impact = (~isempty(dmin_abs) &&  step >= dmin_abs  );

    if(is_impact)
      step = dmin_abs -1 ;
    end
    
    negative_incr = (direction <= 2 ) ;
    xnew = x;
    xnew(2 - orient ) = x(2- orient) + (-1)^(negative_incr) * step ;
end
