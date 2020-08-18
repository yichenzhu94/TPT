function T = detectpitch(X,minT,maxT)

% function T = detectpitch(X);
% T: période estimée, 0 si non voisé
% X: signal analysé
% minT: période minimale
% maxT: période maximale
% détecte le pitch à l'aide de l'estimation
% biaisée de l'autocov.
    
    n = length(X);
    gamma = acovb(X);
    gamma = gamma/gamma(1);
    ind = find(gamma == max(gamma(minT:end)));
    T = ind-1;
    seuil = .5;
   
    if gamma(ind)*n/(n-T) < seuil || T > maxT
        T = 0;
    end
end
    