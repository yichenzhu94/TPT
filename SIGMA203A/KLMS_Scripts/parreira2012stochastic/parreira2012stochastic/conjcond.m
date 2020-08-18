%===============================================================================
% Cost function to evaluate the value of eta for which the maximum
% eigenvalue of G, in absolute value, becomes equal to 1. This maximum
% eigenvalue results from the conjecture described in the paper by C.
% Richard et al. @ Asilomar'12
%
% contact: cedric.richard@unice.fr
% version: 7 november 2012
%
%===============================================================================



function [c,ceq] = conjcond(eta,nu,r,M)


%% Calculation of the entries of the matrix G and of the matrix A
% As explained in the paper by C. Richard et al. @ Asilomar'12, matrix A has
% the same largest eigenvalue in absolute value as the matrix G involved in
% the stability of the KLMS filter
[Gent,A] = stab_entG(eta,nu,r,M);


%% Calculation of the largest eigenvalue of A (and G)
delta = (A(1,1)-A(2,2))^2+4*(M-1)*A(2,1)^2;
lambda_max = 0.5*(abs(A(1,1)+A(2,2))+sqrt(delta));


%% Calculation of the constraints for solving lambda_max = 1
c = lambda_max-1;
ceq = [];

