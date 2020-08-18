%===============================================================================
% Convergence behavior analysis of the Gaussian kernel-LMS algorithm
% contact: cedric.richard@unice.fr ; wdparreira@gmail.com
% version: 7 november 2012
%
% This function the model of convergence derived in
%
% W. D. Parreira, J.-C. M. Bermudez, C. Richard, and J.-Y. Tourneret, "Stochastic
% behavior analysis of the Gaussian kernel-least-mean-square algorithm,"
% IEEE Transactions on signal processing, 2012, vol. 60, n° 5, p. 2208-2222.
%
%
% function [alpha_opt,Jmin,Jms,Jmsinf] = converg_klms(G,Rkk,Ekd,Ed2,v0,eta,N)
%
% inputs of the function
% G     : G matrix in Parreira et al., 2012 ; see equation (51)
% Rkk   : Correlaton matrix of the kernelized input
% Ekd   : Intercorrelation vector between kernelized input and output
% Ed2   : Instantaneous energy of the desired output
% v0    : Initial value for the error vector (must match Monte Carlo sim)
% eta   : step-size
% N     : Number of iterations
%
%
% output of the function
% alpha_opt : Wiener solution
% Jmin      : Minimum mean-square error
% Jms       : Mean-square error as a function of the time index n
% Jmsinf    : Steady-state mean-square error
%===============================================================================


function [alpha_opt,Jmin,Jms,Jmsinf] = converg_klms(G,Rkk,Ekd,Ed2,v0,eta,N)



% Initializations
M = size(Rkk,1);


%----------------------------------------------------------------------
% Wiener solution
%----------------------------------------------------------------------

alpha_opt = Rkk\Ekd;
Jmin = Ed2-Ekd'*alpha_opt;


%----------------------------------------------------------------------
% Model for MSE behavior using lexicographic representations of
% correlation matrices. See equation (51) in the above-mentioned paper.
%----------------------------------------------------------------------

% Initializations: note that v must be initialized as in Monte-Carlo simulations
% in order that the model and simulations can match.
Cv = (v0'*v0)/trace(Rkk*(v0'*v0));

% Recursion based on lexicographic representations of Rkk and Cv
rkk = reshape(Rkk,M^2,1);
for n = 1:N,
    Jex(n)=trace(Rkk*Cv);
    Jms(n) = Jmin+Jex(n);  
    cv = reshape(Cv,M^2,1);
    cv = G*cv + eta^2*Jmin*rkk;
    Cv = reshape(cv,M,M);
end

% Steady-state MSE and EMSE
cvinf = eta^2*Jmin*inv(eye(M^2)-G)*rkk;
Cvinf = reshape(cvinf,M,M);
Jexinf = trace(Rkk*Cvinf);
Jmsinf = Jmin+Jexinf;


