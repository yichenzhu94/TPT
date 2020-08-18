function [ SNR ] = SNRSB( L,waveletcoef,BT )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Calculer le niveau de décomposition
niveau_dcp = 9-L;
% Calculer le nombre de sous-bande
nb_sb = 3*niveau_dcp+1;
SNR = zeros(nb_sb,1);

for i = 1:nb_sb
    sb = getsb(waveletcoef,i,niveau_dcp);
    sbpow = sb.^2;
    B_sb = getsb(BT,i,niveau_dcp);
    SNR(i) = 10*log10(mean(sbpow(:))/var(B_sb(:)));
end

end