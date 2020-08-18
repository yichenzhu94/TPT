function [newWalls, x] = robot_grille_init(L, walls) 
%ARGUMENTS : cf robot_grille_simul. 
%VALEUR: 
% newWalls : murs augmentes incluant les frontieres de la grille 
% x : position initiale 
  
%% tirer uniformement la position initiale, en dehors des murs
  on_a_wall = true;
  while on_a_wall
    x = discrete_rnd(2, 1:(L-1) , 1/(L-1) * ones(1,L-1) );
    on_a_wall_vect = (x(1) >= walls(:,1)).* (x(1) <= walls(:,1) + walls(:,3) ) .* ...
		     (x(2) == walls(:, 2) ) .* (walls(:,4) ==1) ;  %% mur horizontal
    on_a_wall_vect = on_a_wall_vect + ...
		      (x(2) >= walls(:,2) ) .* (x(2) <= walls(:,2) + walls(:,3) ) .* ...
		      (x(1) == walls(:,1)) .* (walls(:,4) ==0)  ;
		      %% mur vertical
    on_a_wall = any(on_a_wall_vect) ;
  end
  %% ajout des murs frontiere de la grille 
  newWalls = [walls ; [0,0,L, 1 ;
		       0,0,L,0;
		       0, L, L, 1;
		       L,0, L, 0]];
end
