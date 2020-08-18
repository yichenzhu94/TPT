function [ S_DBRT ] = Seuillage_dur( S_TO,niveau_dcp,qmf,variance )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

k = 9*(1-4^(-niveau_dcp));
seuil = variance*sqrt(2*log(k));
coef_debruitage = HardThresh(S_TO, seuil);
coef_approx = getsb(S_TO, 1, niveau_dcp);

for i = 1:size(coef_approx,1);
    for j = 1:size(coef_approx,2);
        coef_debruitage(i,j) = coef_approx(i,j);
    end
end

S_DBRT = IWT2_PO(coef_debruitage,9-niveau_dcp,qmf);

end

