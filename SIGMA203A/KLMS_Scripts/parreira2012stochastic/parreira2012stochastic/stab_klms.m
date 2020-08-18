%===============================================================================
% Tests for stability of the kernel LMS with Gaussian kernel
% contact: cedric.richard@unice.fr
% version: 7 november 2012
%
% This function implements the two tests for stability derived in
%
% C. Richard, and J.-C. M. Bermudez, "Closed-form conditions for convergence 
% of the Gaussian kernel-least-mean-square algorithm," Proc. Asilomar conference,
% 2012.
% 
% These two tests are the Gerschgorin disk test and the conjectured necessary
% and sufficient condition. 
%
%
% See also:
% W. D. Parreira, J.-C. M. Bermudez, C. Richard, and J.-Y. Tourneret, "Stochastic
% behavior analysis of the Gaussian kernel-least-mean-square algorithm,"
% IEEE Transactions on signal processing, 2012, vol. 60, n° 5, p. 2208-2222.
%
%
% function [eta_max]=stab_klms(M,q,xi,R);
%
% inputs of the function
% M     : filter length
% q     : size of the input vector u(n)
% xi    : Gaussian kernel bandwidth
% R     : Correlation matrix of u(n)
%
%
% output of the function
% eta_conj  : maximum stepsize provided by the conjectured necessary and sufficient
%             condition
% eta_ger   : maximum stepsize provided by the Gerschgorin disk test.
%             Note that eta_ger = 0 means that this test cannot provide a meaningful
%             bound because rmd < (M-1)rod. See the Asilomar'12 paper.
%===============================================================================


function [eta_conj,eta_ger]=stab_klms(M,q,xi,R);


%% Estimation of the statistical moments of the kernelized input sequence
[nu,r]=kerinp_moment(M,q,xi,R);


%% Conjectured necessary and sufficient condition of stability
fcon = @(eta)conjcond(eta,nu,r,M);
options = optimset('Algorithm','interior-point','Display','off');
eta_conj = fmincon(@(eta)(-eta),0,-1,0,[],[],[],[],fcon,options);


%% Gerschgorin disk approach
if ((M-1)*r(2) >= r(1)),
    eta_ger = 0;
else
    fcon1 = @(eta)gersch1(eta,nu,r,M);
    fcon2 = @(eta)gersch2(eta,nu,r,M);
    options = optimset('Algorithm','interior-point','Display','off');
    eta_ger1 = fmincon(@(eta)(-eta),eta_conj,-1,0,[],[],[],[],fcon1,options);
    eta_ger2 = fmincon(@(eta)(-eta),eta_conj,-1,0,[],[],[],[],fcon2,options);
    eta_ger = min(eta_ger1,eta_ger2);
end


