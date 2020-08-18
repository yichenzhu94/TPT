%===============================================================================
%
%                                Example 1
% 
% W. Gao, J. Chen, C. Richard, J. Huang and R. Flamary, "Kernel LMS with 
% forward-backward splitting for dicitonary learning", in Proc. IEEE ICASSP, May. 2013.
%
% contact: cedric.richard@unice.fr; gao_wei@mail.nwpu.edu.cn
% version: 26 March 2013
% 
%===============================================================================

clear all; clc; close all;

%% Initialization of basic parameters

Ndata = 2e4; %the data length
Nexp = 20; %200 the number of Monte Carlo test

ker = 'rbf';
xi = 0.1;


%% Initialization

mse_krls_cs = zeros(1,Ndata);
mse_klms_cs = zeros(1,Ndata);
mse_klms_csl1 = zeros(1,Ndata);
mse_klms_csal1 = zeros(1,Ndata);

mean_evolution_krls_cs = 0;
mean_evolution_klms_cs = 0;
mean_evolution_klms_csl1 = 0;
mean_evolution_klms_csal1 = 0;


%% loops

for n = 1 : Nexp
    disp('-----------------------------------------------------------------')
    disp(['Example 1 in paper for ICASSP 2013 - Monte Carlo test no. ',num2str(n)])
    %----------------------------------------------------------------------
    %% generate input signal
    [v,d,dref] = richardbench(Ndata); 
    %----------------------------------------------------------------------
    %% KRLS-CS
    threshold_krls = 0.2;
    tic;[e_krls,sv,nb,evolution_krls] = krls_cs(v,d,threshold_krls,ker,xi);toc;
    mse_krls_cs = mse_krls_cs + (dref - d + e_krls).^2/Nexp;%EMSE
    mean_evolution_krls_cs = mean_evolution_krls_cs + evolution_krls/Nexp;
    
    %% KLMS-CS
    threshold_klms_cs = 0.2;
    eta_klms_cs = 0.01;%
    tic;[e_klms_cs,sv,nb,evolution_kapa] = klms_cs(v,d,eta_klms_cs,threshold_klms_cs,ker,xi);toc;
    mse_klms_cs = mse_klms_cs + (dref - d + e_klms_cs).^2/Nexp;%EMSE
    mean_evolution_klms_cs = mean_evolution_klms_cs + evolution_kapa/Nexp;
    
    %% KLMS-CSL1 
    threshold_klms_csl1 = 0.2;
    threshold_CSL1 = 5e-3;%
    eta_klms_csl1 = 0.01;
    tic;[e_klms_csl1,sv,nb,evolution_kapa_CL1] = klms_csl1(v,d,eta_klms_csl1,threshold_klms_csl1,threshold_CSL1,ker,xi);toc;
    mse_klms_csl1 = mse_klms_csl1 + (dref - d + e_klms_csl1).^2/Nexp;%EMSE
    mean_evolution_klms_csl1 = mean_evolution_klms_csl1 + evolution_kapa_CL1/Nexp;
    
    %% KLMS-CSAL1
    threshold_klms_csal1 = 0.2;
    threshold_CSAL1 = 4e-4;%
    eta_klms_csal1 = 0.01;
    tic;[e_klms_csal1,sv,nb,evolution_kapa_CSAL1] = klms_csal1(v,d,eta_klms_csal1,threshold_klms_csal1,threshold_CSAL1,ker,xi);toc;
    mse_klms_csal1 = mse_klms_csal1 + (dref - d + e_klms_csal1).^2/Nexp;%
    mean_evolution_klms_csal1 = mean_evolution_klms_csal1 + evolution_kapa_CSAL1/Nexp;
    
end

%% smoothing
K = 100;
mse_krls_cs_smooth = filter(ones(K,1)/K,1,mse_krls_cs); 
mse_klms_cs_smooth = filter(ones(K,1)/K,1,mse_klms_cs);
mse_klms_csl1_smooth = filter(ones(K,1)/K,1,mse_klms_csl1); 
mse_klms_csal1_smooth = filter(ones(K,1)/K,1,mse_klms_csal1); 
    
%% plot
figure
subplot(211)
hold on
plot(10*log10(mse_krls_cs_smooth),'-m','LineWidth',2); 
plot(10*log10(mse_klms_cs_smooth),'-.b','LineWidth',2); 
plot(10*log10(mse_klms_csl1_smooth),'--r','LineWidth',2); 
plot(10*log10(mse_klms_csal1_smooth),':g','LineWidth',2);
hold off
legend('KRLS-CS','KLMS-CS','KLMS-CSL1','KLMS-CSAL1');
title('(a)')
xlabel('Iteration');ylabel('10*log10(MSE) dB')
axes_handle = get(gcf,'CurrentAxes');
set(axes_handle,'YGrid','on');
axis([1 Ndata -15 0])

subplot(212)
hold on
plot(mean_evolution_krls_cs,'-m','LineWidth',2);
plot(mean_evolution_klms_cs,'-.b','LineWidth',2);
plot(mean_evolution_klms_csl1,'--r','LineWidth',2);
plot(mean_evolution_klms_csal1,':g','LineWidth',2);
hold off
title('(b)')
xlabel('Iteration');
axes_handle = get(gcf,'CurrentAxes');
set(axes_handle,'YGrid','on');
