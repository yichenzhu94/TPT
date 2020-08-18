function T = detectpitch(X,minT,maxT)

% function T = detectpitch(X);
% T: p�riode estim�e, 0 si non vois�
% X: signal analys�
% minT: p�riode minimale
% maxT: p�riode maximale
% d�tecte le pitch � l'aide de l'estimation
% biais�e de l'autocov.
    
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
    