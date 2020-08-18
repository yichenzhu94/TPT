% *************************************************************************
%
%                                Experiment 1
%
% Main file to run the first experiment on stability described in
%
% C. Richard, and J.-C. M. Bermudez, "Closed-form conditions for convergence 
% of the Gaussian kernel-least-mean-square algorithm," Proc. Asilomar conference,
% 2012.
%
% This experiment was firstly described in
%
% W. D. Parreira, J.-C. M. Bermudez, C. Richard, and J.-Y. Tourneret, "Stochastic
% behavior analysis of the Gaussian kernel-least-mean-square algorithm,"
% IEEE Transactions on signal processing, 2012, vol. 60, n° 5, p. 2208-2222.
%
% contact: cedric.richard@unice.fr
% version: 7 november 2012
% 
% *************************************************************************

clc
close all;
clear all;

%%

%----------------------------------------------
%
% Signal characteristics
%
%----------------------------------------------

% Input signal std, additive noise std
su = 0.15;
q = 1;
R = su^2;
sw = 1e-2;

% Dictionary length, kernel bandwidth
% Remark: to be modified to test the different parameter setups described
% in the two above-mentioned paper.
M = 17;
xi = 7.5e-3;


%%

%----------------------------------------------
%
% Part 1: Conditions for convergence
%
%----------------------------------------------

% Maximum step-sizes provided by the two approaches considered in Asiloma'12
[eta_conj,eta_ger] = stab_klms(M,q,xi,R);
disp(['Maximum step size (necessary & sufficient cond.): ',num2str(eta_conj)])
disp(['Maximum step size (Gerschgorin sufficient cond.): ',num2str(eta_ger)])

% Just for plot preparing. The following function estimates the largest
% eigenvalue of the matrix G as a function of the step-size. One is the
% bound provided by the Gerschgorin disk approach, the other is the
% conjectured largest one.
eta_min = 0;
eta_max = 1.25*eta_conj; 
[lambda_conj,lambda1_ger,lambda2_ger] = stab_klms_plot(M,q,xi,R,eta_max);

% Plots of the maximum admissible step sizes according to the two tests 
% Plots of the test values as a function of eta
d_eta = (eta_max-eta_min)/(length(lambda_conj)-1);
figure;
h=plot(eta_min:d_eta:eta_max,lambda_conj);hold on;
h=plot(eta_min:d_eta:eta_max,lambda1_ger);hold on;set(h,'color','r')
h=plot(eta_min:d_eta:eta_max,lambda2_ger);hold on;set(h,'color','g')
h=plot(eta_conj,1,'ro');set(h,'markerfacecolor','r')
text(1.05*eta_conj,0.99,num2str(eta_conj))
h=plot(eta_ger,1,'ro');set(h,'markerfacecolor','r')
text(1.05*eta_ger,0.99,num2str(eta_ger))
h=line([eta_min eta_max],[1 1]);set(h,'color','k')
xlabel('step-size \eta')
ylabel('\lambda_{max}')
legend(['Conjectured largest eigenvalue'],['Gerschgorin disk 1 limit'],['Gerschgorin disk 2 limit'])
grid
title('Largest eigenvalue of G (in absolute value)');

% Graph tuning
lambda_min = 0.98*min([lambda_conj lambda1_ger lambda2_ger]);
lambda_max = 1.02*max([lambda_conj lambda1_ger lambda2_ger]);
set(gca,'xlim',[eta_min eta_max])
set(gca,'ylim',[lambda_min lambda_max])




