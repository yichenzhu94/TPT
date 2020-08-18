clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parametres modifiables   
%%%%%%%%%%%%%%%%%%%%%%%%%%%
T = 200 ; %%horizon de temps
stepPlot = 10; %%, nombre de visualisations, 
L =  20;  %%  taille de la grille 
walls = [5, 10, 10, 1 ; 
         10, 3, 4, 0 ;
         3, 13, 4, 0 ;
         15, 13, 4, 0]; %% murs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% parametres des lois geometriques des  bruits (entre 0 et 1)
thetaState = 0.4;
thetaObs = 0.3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if mod(T, stepPlot)~=0
  error(['total time T  not  divisible by the specified',...
	 'number of plots stepPlot'])
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generer (X,Y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[X,Y] = robot_grille_simul(T, L, walls, thetaState, thetaObs) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Affichage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
figure(1)
hold on ;
robot_grille_plot(L,walls, thetaObs);
plot(X(1,1), X(1,2), '*', 'color', 'b', 'markersize',5)
plot(Y(1,1), Y(1,2), '*', 'color', 'g', 'markersize',5)
timeLag = T / stepPlot ;
disp(['Let us see how the robot moves around (true state: blue)', ...
      'and how the observations look like (green)'])
for j = 0:(stepPlot-1)
  inds = (j * timeLag +(j==0 )) : ((j+1) * timeLag);
  hState= plot(X(inds,1), X(inds,2), 'o', 'color', 'b', ...
	       'markersize', 8);
  hObs = plot(Y(inds,1), Y(inds,2), '*', 'color', 'g', ...
	      'markersize', 8);
  hStateLine = plot(X(inds,1), X(inds,2),  'color', 'b');
  if j==0
    hleg= legend([hState, hObs,hStateLine], ...
		 'true state', 	 'observations',   'recent trajectory');
  else 
    hleg = legend([ hObs,hStateLine], ...
		  'observations',  'recent trajectory');
  end
  disp('press any key')
  pause()
  delete(hleg)
  delete(hObs)
  delete(hStateLine)
end
hObs = plot(Y(:,1), Y(:,2), '*', 'color', 'g', 'markersize', 8);
hStateLine = plot(X(:,1), X(:,2),  'color', 'b');
legend([ hObs,hStateLine], ...
       'observations',  'true trajectory')
hold off;


%% 2. 1. bis:  script de test pour le filtre
%%% simulation de la trajectoire
%%% Parametres de la simulation
T = 200 ; % horizon de temps
stepPlot = 10; %  nombre de visualisations, 
L = 20;  % taille de la grille 
walls = [ 5,10, 10, 1 ; 
          10, 3, 4, 0 ;
          3, 13, 4, 0;
          15, 13, 4, 0]; % murs

thetaState = 0.6;
thetaObs = 0.4;

%%% parametres du filtrage
Np =10;  % nombres de particules 
stepPlot = 10;

if mod(T, stepPlot )~=0
  error(['total time T not  divisible by the specified',...
	 'number of plots stepPlot'])
end
%%% Simulation 
[X,Y] = robot_grille_simul(T, L, walls, thetaState, thetaObs) ;

%%% 2 -  Filtrage 
[Xp, W] = particle_robot_grille (Y, L,  walls, ...,
                          thetaState, thetaObs, Np ,2);
                      
%% 2.2 Estimateurs de la position 'moyenne' E(X|y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Mp = zeros(T,2);
for k = 1:T
    Mp(k,:) = %% COMPLETER 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% 2.3 affichage
figure(2) 
hold on ; 
robot_grille_plot(L,walls, thetaObs);
plot(X(1,1), X(1,2), '*', 'color', 'b', 'markersize',5)
plot(Y(1,1), Y(1,2), '*', 'color', 'g', 'markersize',5)
timeLag = T / stepPlot ; 
for j = 0:(stepPlot-1)
  lastIndex =   (j+1) * timeLag;
  inds = (j * timeLag +(j==0 )) : lastIndex ;
  
  hState= plot(X(inds,1), X(inds,2), 'o', 'color', 'b', 'markersize', 8);
  hObs = plot(Y(inds,1), Y(inds,2), '*', 'color', 'g', 'markersize', 8);
  hStateLine = plot(X(inds,1), X(inds,2),  'color', 'b');
  hMeanFilter = plot(Mp(inds,1), Mp(inds,2), 'color', 'r');
  hparticle = plot(Xp(:,1,lastIndex) , Xp(:,2,lastIndex), ...
      '*', 'color', 'r', 'markersize', 15) ;
  hlastState = plot(X(lastIndex,1) , X(lastIndex,2), ...
      '*', 'color', 'b', 'markersize', 15) ;
  
  disp('press any key')
  pause()  
  
  delete(hMeanFilter)
  delete(hparticle)
  delete(hlastState)
end
hold off
figure(3)
hold on; 
robot_grille_plot(L,walls, thetaObs);
indplot = floor(linspace(1,T,T/2));

hStateLine = plot(X(indplot,1), X(indplot,2),  'color', 'b');
hMeanFilter = plot(Mp(indplot,1), Mp(indplot,2), 'color', 'r');
hold off;
