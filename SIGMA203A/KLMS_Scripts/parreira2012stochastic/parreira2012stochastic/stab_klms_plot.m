%===============================================================================
% Extra functions for prepapring plots. It estimates the largest
% eigenvalue (bound) of the matrix G as a function of the step-size. One is the
% bound provided by the Gerschgorin disk approach, the other is the
% conjectured largest eigenvalue of G (in absolute value).
%
% contact: cedric.richard@unice.fr
% version: 7 november 2012
%
%===============================================================================


function [lambda_conj,lambda1_ger,lambda2_ger] = stab_klms_plot(M,q,xi,R,eta_max)


% Estimation of the moments of the kernelized input
[nu,r]=kerinp_moment(M,q,xi,R);

% Loop for calculating plot values
eta_min = 0;
d_eta = (eta_max-eta_min)/1000;
ind = 0;

for eta = eta_min:d_eta:eta_max,
    
    % Loop index
    ind = ind + 1;

    % Calculation of the entries of the matrix G and of the matrix A
    [Gent,A] = stab_entG(eta,nu,r,M);

    % Value of the conjectured necessary and sufficient test as a function of
    % the step size eta
    delta = (A(1,1)-A(2,2))^2+4*(M-1)*A(2,1)^2;
    lambda_conj(ind) = 0.5*(A(1,1)+A(2,2)+sqrt(delta));

    % Values of the the extrema of the Gerschgorin disks as a function of
    % the step size eta
    lambda1_ger(ind) = Gent(6)+(M-1)*Gent(7)+2*(M-1)*abs(Gent(3))+(M-1)*(M-2)*Gent(2);
    lambda2_ger(ind) = 2*Gent(1)+(M-2)*Gent(2)+2*abs(Gent(3))+4*(M-2)*abs(Gent(4))+(M-2)*(M-3)*Gent(5);
    
    % Value of the largest eigenvalue of G in absolute value
    % Commented because too time-consuming. Uncomment to check it is equal
    % to the conjectured largest eigenvalue!
    % G = stab_matG(eta,nu,r,M);
    % [U,V] = eig(G);
    % eigmax(ind) = max(abs(diag(V)));
    
end


% % Plots of the test values as a function of eta
% figure(1);
% clf
% h=plot(eta_min:d_eta:eta_max,lambda_conj);hold on;
% h=plot(eta_min:d_eta:eta_max,lambda1_ger);hold on;set(h,'color','r')
% h=plot(eta_min:d_eta:eta_max,lambda2_ger);hold on;set(h,'color','g')
% h=plot(eta_min:d_eta:eta_max,eigmax);hold on;set(h,'color','c','linestyle','-.')
% title('');
% 
% % Graph tuning
% set(gca,'ylim',[lambda_min lambda_max])
% 

