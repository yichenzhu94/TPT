function [ S_DBRT ] = SURE( S_TO,niveau_dcp,qmf,variance )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

S = S_TO/variance;
coef_debruitage = HybridThresh(S(:)');
coef_debruitage = reshape(coef_debruitage, [512 512]);
coef_approx = getsb(S,1,niveau_dcp);

for i = 1:size(coef_approx,1);
    for j = 1:size(coef_approx,2);
        coef_debruitage(i,j) = coef_approx(i,j);
    end
end

S_DBRT = IWT2_PO(30*coef_debruitage,9-niveau_dcp,qmf);

end

