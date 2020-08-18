%===============================================================================
% Calculation of the entries of the matrix G and of the matrix A, which has
% the same largest eigenvalue (in absolute value) as G. Use the function
% stab_matG to construct the matrix G if required, for instance to
% calculate its eigenvalues (which is time-consuming...)
%
% contact: cedric.richard@unice.fr
% version: 7 november 2012
%
%===============================================================================


function [G,A] = stab_entG(eta,nu,r,M)


%% Calculation of the different entries involved in the definition of the matrix G
% which is required for characterizing the stability of the Gaussian KLMS filter
% Remark: only the entries are calculated, and not the full matrix G
% because it is huge, even though it contains only 7 distinct entries
rmd = r(1);
rod = r(2);
G(1) = 0.5*(1-2*eta*rmd+2*eta^2*nu(3));
G(2) = eta^2*nu(4);
G(3) = eta^2*nu(2)-eta*rod;
G(4) = 0.5*(2*eta^2*nu(4)-eta*rod);
G(5) = eta^2*nu(5);
G(6) = 1-2*eta*rmd+eta^2*nu(1);
G(7) = eta^2*nu(3);


%% Calculation of the entries of the matrix A
% As explained in the paper by C. Richard et al. @ Asilomar'12, matrix A has
% the same largest eigenvalue in absolute value as G

A(1,1) = G(6)+(M-1)*G(7);
A(1,2) = (M-1)*(M-2)*G(2)+2*(M-1)*G(3);
A(2,1) = (M-2)*G(2)+2*G(3);
A(2,2) = 2*G(1)+4*(M-2)*G(4)+(M-2)*(M-3)*G(5);

