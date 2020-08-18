function [Xp, W] = particle_robot_grille(Y,L, walls, ...,
        thetaState, thetaObs, Np , resample)
%ARGUMENTS: 
% Y, L, walls, thetaState, thetaObs:  comme dans  robot_grille_simul; 
% Np : nombre de particules 
%VALUE : 
%  Xp : tableau de taille  (Np, 2,  T) (with T = size(Y,1) ), particules 
%  W : tableau de taille  (Np, T),  poids.

%%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%%
  T = size(Y,1) ;  %% horizon de temps
  Xp = zeros(Np,2, T) ; %% tableau pour stocker les particules 
  W = zeros(T, Np) ;  %% tableau pour stocker les poids 
  particles = zeros(Np,2) ;%% etat courant des particules
  logweights = zeros(1,Np) ; %% vecteur du logarithme des poids
% Creation du jeu de particules 
  for i = 1:Np
    [newwalls, x] = robot_grille_init(L, walls);
    particles(i,:) = x;
  end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algorithme de filtrage: 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  for k=1:T
      for i = 1:Np
	% Faire evoluer les particules selon le modele
        particles(i,:) = robot_grille_stateStep(x(i,:),newwalls,thetaState); % completer 

	% Mise a jour des poids (non normalises) 
         loi_y_x = geopdf(abs(Y(i,1)),thetaObs)*geopdf(Y,thetaObs);
         logweights(i) = logweights(i) + log(loi_y_x); %%
      end
      % normalisation des poids (cf echantillonnage d'importance)
      w =  %% COMPLETER

      % reechantillonnage a intervalles de temps reguliers 
      % de longeur 'resample'
      if mod(k,resample) == 0
      % COMPLETER
	particles = ;  %%
	w = ; %%
      end
      Xp(:,:,k) = particles; 
      W(k,:)  = w'; 
  end
end
