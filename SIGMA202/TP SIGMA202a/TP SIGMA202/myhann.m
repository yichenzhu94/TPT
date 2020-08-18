function w = myhann(M,flag)

% function w = myhann(M,flag)
% M: longueur de la fenêtre
% flag: 'sym' (defaut) ou 'periodic'
% fenêtre de Hann symétrique
% ou périodique

if nargin <2; flag='sym';end

if strcmp(flag,'periodic')
    om=2*pi/M;
    l=(0:M-1)';
    w= 0.5 - 0.5*cos(l*om);
else
    om = 2*pi/(M+1);
    l=(1:M)';
    w = 0.5-0.5*cos(l*om);
end

end