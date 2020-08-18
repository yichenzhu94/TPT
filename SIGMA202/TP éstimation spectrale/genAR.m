function [X]=genAR(coeff,N,variance)

% function [X,phi] = genAR(p,n)
% X :   processus AR généré
% phi : coefficients (réels) de l'équation récurrente 
%       X(t) = phi(1)X(t-1)+...+phi(p)X(t-p) + Z(t);
%       Z(t) est un bruit blanc de variance 1.
% p :   ordre du filtre AR correspondant
% n :   nombre d'échantillons générés
p = length(coeff);
% on tire au hasard fix(p/2) racines complexes à l'intérieur du cercle unité
nrc = fix(p/2); % nbre de racines complexes
%rho = sqrt(rand(1,nrc)); % pour une repartition uniforme des poles
                         % dans le cercle
rho = .5+0.499*sqrt(rand(1,nrc)); % une alternative pour avoir des poles
                                 % pres du cercle unité
theta = 2*pi*rand;
zk = rho.*exp(1i*theta);

% calcul de la longueur du transitoire
zmax = zk(abs(zk)==max(abs(zk)));
rhomax = abs(zmax);
tau = -1/log(rhomax);
transitoire = round(5*tau); 

% génération du bruit blanc gaussien de variance 1
Z = variance*randn(1,N+transitoire); % n+transitoire pour une gestion des effets de bords

X = filter(1,coeff,Z);
X = X(transitoire+1:end);

end