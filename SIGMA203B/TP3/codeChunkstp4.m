
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% TP4 sigma204 echantillonnage d'importance %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Anne Sabourin    %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Exo 1 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exo 1 Q1 
u = 4 ; 
N = 2*10^4

%% MC naif
sampleN = normrnd(0,1, 1,N) ;
excess = sampleN >= u ;
estMean = cumsum(excess) ./ (1:N ) ;
estVar = cumsum( (excess - estMean).^2 )./ (1 : N ).^2 ;
estSD = sqrt(estVar) ;
%%
figure(1)
hold on
plot(1:N, estMean, ...
    1:N ,  1 - normcdf(u,0,1) , ...
    1:N , estMean + 1.96 * estSD , 'linewidth', 2) 
legend('MC naif', 'vraie valeur', 'intervalle de confiance');
plot(1:N, estMean - 1.96 * estSD, 'color', 'r', 'linewidth', 2) ;
title('MC naif')
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Exo 1  : Q2
%% importance avec proposition exponentielle de moyenne lambda,
%% translatee de u
lambda = 2 ;
X  =  %% COMPLETER pour obtenir un echantillon de dimension (1,N); 
W =   %% idem 
estim_Tau = %%% Completer 
true_Tau = 1 - normcdf(u,0,1)
relativeError = (estim_Tau - true_Tau) / true_Tau    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Exo 1  : Q3
estim_Tau = %%% Completer 
true_Tau = 1 - normcdf(u,0,1)
relativeError = (estim_Tau - true_Tau) / true_Tau    


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Exo 2  :
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Exo 2  : Q2
 
close all
%% vrais parametres
a0 = 3
b0 = 8
% echantillon de donnees sous le vrai parametre
n = 100
Y = betarnd(a0,b0, 1,n) ;
%prior uniforme sur [0,lambda]
lambda = 10
%% echantillon X (matrice N *2)  generes en prenant comme loi de 
%% de proposition,  le prior lui-meme, i.e. uniforme sur [0,lambda]. 
N = 10 *10^3
X = lambda * rand(N, 2);

%% Calcul du logarithme des poids d'importance 
logW = zeros(1,N);
for i = 1:n
  logW =logW +  %%% COMPLETER. utiliser la fonction betapdf
end
logW = logW - max(logW) ;
W = exp(logW) ;
W = W / sum(W) ;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Exo 2  : Q3
%% Moyenne a posteriori estimee 
est_PostMean_a = cumsum(W .* X(:,1)' )./ cumsum(W);
est_PostMean_b = cumsum(W .* X(:,2)' ) ./ cumsum(W);

% Quantiles a posteriori: calcules en 100 points seulement 
% ( pour gagner du temps )
Qnstep = 100 ;
v = 1:N ; 
nmin  = min(v(cumsum(W)>0.01))
timeInd = floor(linspace(nmin,N, Qnstep));
PosteriorQuantile_a = zeros(2,Qnstep);
PosteriorQuantile_b = zeros(2,Qnstep);

for k = 1:Qnstep
    PosteriorQuantile_a(:,k) = discrete_inv([0.25, 0.75], ...
					    X(1: timeInd(k), 1 )' ,...
					    W(1 : timeInd(k) ));
    PosteriorQuantile_b(:,k) = discrete_inv([0.25, 0.75], ...
					    X(1: timeInd(k) , 2)' , ...
					    W(1 : timeInd(k) ));
end

%%
figure(4)
hold on; 
line(1:N, a0 * ones(1,N), 'color','b')
line(1:N, est_PostMean_a, 'color','r');
line(timeInd, PosteriorQuantile_a(1,:), 'color','y');
line(timeInd, PosteriorQuantile_a(2,:), 'color','y');
legend('vrai parametre', 'esperance a posteriori', ...
       'quantile a posteriori')
   s = [ 'Premier parametre: esperance a posteriori et quantiles ' ...
'par Ech. I auto-normalise'];
title(s)
hold off
%%
figure(5)
hold on; 
line(1:N, b0*ones(1,N), 'color','b')
line(1:N, est_PostMean_b, 'color','r');
line(timeInd, PosteriorQuantile_b(1,:), 'color','y');
line(timeInd, PosteriorQuantile_b(2,:), 'color','y');
legend('vrai parametre', 'esperance a posteriori', ...
       'quantile a posteriori')
   s = ['Second parametre: esperance a posteriori et quantiles  par Ech. I auto-normalise' ];
title(s)
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Exo 2  : Q4

% Nombre d'echantillons a generer
N_hist = 1e+5; 

for i = 1:2 % un echantillon par parametre de la loi beta
  if i==1   truePar = a0 ;   else  truePar = b0 ;  end
  % Generation de l echantillon 
  Z = discrete_rnd(N_hist, X(:,i), W) ; 
  % construction de l histogramme normalise, de sorte a approcher
  % une densite de probabilite
  nbin = floor(N_hist^(1/3));
  bin_vec = linspace(min(Z), max(Z), nbin+1) ;   
  space_int = (max(Z) -  min(Z)) /nbin ; 
  hh =  hist(Z, bin_vec) /(N_hist * space_int ) ; 
  
  % affichage  de l'histogramme 
  figure(i+5);
  hold on
  bar(bin_vec, hh)
  postMean = sum(W .* X(:,i)') ;
  line([postMean,postMean], [0,1], 'color', 'red','linewidth', 5);
  line([truePar,truePar], [0,1], 'color', 'blue', 'linewidth', 5); 
  title(strcat('parametre ',  num2str(i), ' : histogramme et  moyenne'))
  legend('loi a posteriori', 'esperance a posteriori', 'vrai parametre')
  hold off 
end
