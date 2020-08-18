%===============================================================================
% Calculation of the correlation matrix (main-diagonal rmd and off-diagonal
% rod entries) of the kernelized input, and of its fourth-order moments nu.
%
% See the notations in:
%
% W. D. Parreira, J.-C. M. Bermudez, C. Richard, and J.-Y. Tourneret, "Stochastic
% behavior analysis of the Gaussian kernel-least-mean-square algorithm,"
% IEEE Transactions on signal processing, 2012, vol. 60, n° 5, p.
% 2208-2222.
%
% contact: cedric.richard@unice.fr
% version: 7 november 2012
%
%===============================================================================


function [nu,r]=kerinp_moment(M,q,xi,R)


%% Estimation of the statistical moments of the kernelized input sequence

R2 = [R zeros(q) ; zeros(q) R];
R3 = [R zeros(q) zeros(q) ; zeros(q) R zeros(q) ; zeros(q) zeros(q) R];
R4 = [R zeros(q) zeros(q) zeros(q) ; zeros(q) R zeros(q) zeros(q) ; zeros(q) zeros(q) R zeros(q) ; zeros(q) zeros(q) zeros(q) R];
R5 = [R zeros(q) zeros(q) zeros(q) zeros(q) ; zeros(q) R zeros(q) zeros(q) zeros(q) ; zeros(q) zeros(q) R zeros(q) zeros(q) ; zeros(q) zeros(q) zeros(q) R zeros(q) ; zeros(q) zeros(q) zeros(q) zeros(q) R];

Q2  = [1*eye(q) -1*eye(q) ; -1*eye(q) 1*eye(q)];
Q3  = [2*eye(q) -1*eye(q) -1*eye(q) ; -1*eye(q) 1*eye(q) zeros(q) ; -1*eye(q) zeros(q) 1*eye(q)];
Q3p = [4*eye(q) -3*eye(q) -1*eye(q) ; -3*eye(q) 3*eye(q) zeros(q) ; -1*eye(q) zeros(q) 1*eye(q)];
Q4 = [4*eye(q) -2*eye(q) -1*eye(q) -1*eye(q) ; -2*eye(q) 2*eye(q) zeros(q) zeros(q) ; -1*eye(q) zeros(q) 1*eye(q) zeros(q) ; -1*eye(q) zeros(q) zeros(q) 1*eye(q)];
Q5 = [4*eye(q) -1*eye(q) -1*eye(q) -1*eye(q) -1*eye(q) ; -1*eye(q) 1*eye(q) zeros(q) zeros(q) zeros(q) ; -1*eye(q) zeros(q) 1*eye(q) zeros(q) zeros(q) ; -1*eye(q) zeros(q) zeros(q) 1*eye(q) zeros(q) ; -1*eye(q) zeros(q) zeros(q) zeros(q) 1*eye(q)];    

rmd = 1/sqrt(det(eye(2*q)+2*Q2*R2/xi^2));
rod = 1/sqrt(det(eye(3*q)+Q3*R3/xi^2));
r = [rmd rod];

nu1 = 1/sqrt(det(eye(2*q)+4*Q2*R2/xi^2));
nu2 = 1/sqrt(det(eye(3*q)+Q3p*R3/xi^2));
nu3 = 1/sqrt(det(eye(3*q)+2*Q3*R3/xi^2));
nu4 = 1/sqrt(det(eye(4*q)+Q4*R4/xi^2));
nu5 = 1/sqrt(det(eye(5*q)+Q5*R5/xi^2));
nu = [nu1 nu2 nu3 nu4 nu5];
