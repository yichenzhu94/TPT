%===============================================================================
% Cost function to evaluate the possible intersection between the
% Gerschgorin disk/interval no.2 and the stability limit lambda = 1
%
% contact: cedric.richard@unice.fr
% version: 7 november 2012
%
%===============================================================================


function [c,ceq] = gersch2(eta,nu,r,M)



G1 = (0.5*(1-2*eta*r(1)+2*eta^2*nu(3)));
G2 = (eta^2*nu(4));
G3 = (eta^2*nu(2)-eta*r(2));
G4 = (0.5*(2*eta^2*nu(4)-eta*r(2)));
G5 = (eta^2*nu(5));
G6 = (1-2*eta*r(1)+eta^2*nu(1));
G7 = (eta^2*nu(3));

c = 2*G1+(M-2)*G2+2*abs(G3)+4*(M-2)*abs(G4)+(M-2)*(M-3)*G5-1;
ceq = [];
