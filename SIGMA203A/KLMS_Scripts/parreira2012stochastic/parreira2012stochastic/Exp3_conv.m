% *************************************************************************
%
%                                Experiment 3
%
% Main file to run the third experiment on convergence analysis of the
% Gaussian kernel-LMS algorithm described in
%
% W. D. Parreira, J.-C. M. Bermudez, C. Richard, and J.-Y. Tourneret, "Stochastic
% behavior analysis of the Gaussian kernel-least-mean-square algorithm,"
% IEEE Transactions on signal processing, 2012, vol. 60, n° 5, p. 2208-2222.
%
% Note that Part 1 of this program is an additional part dedicated to conditions for
% convergence of the KLMS algorithm. The interested reader may refer to
% the following paper, available on the personnal webpage of C. Richard
%
% C. Richard, and J.-C. M. Bermudez, "Closed-form conditions for convergence 
% of the Gaussian kernel-least-mean-square algorithm," Proc. Asilomar conference,
% 2012.
%
% Remark: Part 1 requires the Matlab optimization tollbox. If you do not
% have it, just comment Part 1 in the program
%
%
% contact: cedric.richard@unice.fr ; wdparreira@gmail.com
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
su = sqrt(0.0625);
rho = 0.5;
q = 2;
R = su^2 * [1 rho ; rho 1];
sw = 1e-3;

% Dictionary length, kernel bandwidth
M = 11;
xi = 0.15;


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



%%

%----------------------------------------------
%
% Part 2: Monte-Carlo simulations
%
%----------------------------------------------


% Filter step size
eta = 0.147;

% Number of realizations
rlz = 100;

% Signal length
N = 1000;

% Initializations of variables
Ee2 = zeros(1,N);
Ed2 = 0;
Ekd = 0;
Eyn = zeros(N+1,1);

% Calculation of the moments of the kernelized input
[nu,r] = kerinp_moment(M,q,xi,R);
rmd = r(1);
rod = r(2);
Rkk = (rmd-rod)*eye(M)+rod*ones(M); 


% Loop over Monte Carlo simulations
sb=waitbar(0,'Learning curve calculation under progress');
for ind = 1:rlz
    
    % Dictionary design: here it is designed offline as one wants to
    % clearly set its lentgh to M. We thus pre-generate M independent input data
    for k = 1:M,
        Dic(1,k) = su*randn;
        Dic(2,k) = rho*Dic(1,k) + sqrt(1-rho^2)*su*randn;
    end
    
    % Initializations of the variables of the filter
    % Note that v0 is used to initialize the convergence analysis in order
    % that the model of convergence matches the Monte-Carlo simulations
    e = zeros(1,N);   
    v0 = 1:M;
    alpha = v0'/sqrt(trace(Rkk*(v0'*v0)));
    
    % Initializations of the input and output signals
    un = zeros(2,N);
    yn = zeros(1,N);
    dn = zeros(1,N);
    
    % Loop for signal filtering
    for n = 3:N
        
        % Signal generation
        un(1,n) = su*randn;
        un(2,n) = rho*un(1,n) + sqrt(1-rho^2)*su*randn;
        yn(n) = un(1,n) + 0.5*un(2,n) - 0.2*yn(n-1) + 0.35*yn(n-2);
        if yn(n)>=0
            dn(n) = yn(n)/(3*sqrt(0.1 + 0.9*(yn(n)^2)));
        else
            dn(n) = -(yn(n)^2)*(1 - exp(0.7*yn(n)))/3;
        end
        d(n) = dn(n) + sw*randn;
               
        % Computation of the Gram input vector
        %Dic = [Dic(:,1:M-1) un(n)];
        K = gram('gauss',un(:,n)',Dic',xi)';
        
        % Filter coefficient update      
        e(n) = d(n) - alpha'*K; 
        alpha = alpha + eta*e(n)*K;
        
        % Dictionary update
        Dic = [un(:,n) Dic(:,1:M-1)];
        
        % Simulation result saving (I)
        Ekd = Ekd + K*d(n);
        Ed2 = Ed2 + d(n)^2;
        
    end
    
    % Simulation result saving (II)
    waitbar(ind/rlz,sb)
    Ee2 = Ee2 + e.^2;
    
end
close(sb)

% Normalization
Ee2 = Ee2/rlz;
Ekd = Ekd/(rlz*(N-2));
Ed2 = Ed2/(rlz*(N-2));


% Plot: Evolution of the MSE
% (Commented because also plots below, with convergence analysis)
% figure
% plot(1:N,10*log10(Ee2(1:N)),'b');
% title('Monte Carlo Simulation ');
% xlabel('iteration')
% ylabel('MSE (dB)')
% ylim([-25 0])
% grid
% hold on



%%

%----------------------------------------------
%
% Part 3: Convergence analysis
%
%----------------------------------------------


% Convergence analysis of the KLMS
G = stab_matG(eta,nu,r,M);
[alpha0,Jmin,Jms,Jmsinf] = converg_klms(G,Rkk,Ekd,Ed2,v0,eta,N);
Jexinf = Jmsinf - Jmin;
Jex = Jms - Jmin;

% Plot 1: model and Monte-Carlo simulations
figure
plot(1:N,10*log10(Ee2(1:N)),'b',1:N,10*log10(Jms),'r',1:N,10*log10(Jmsinf*ones(1,N)),'r--');
legend(['MSE (Monte Carlo)'],['MSE (Theory)'],['steady-state MSE (Theory)'])
xlabel('iterations')
ylabel('MSE (dB)')
grid

% Plot 2: Model
figure
plot(1:N,10*log10(Jmin*ones(1,N)),'g',1:N,10*log10(Jms(1:N)),'r',1:N,10*log10(Jex(1:N)),'k',1:N,10*log10(Jmsinf*ones(1,N)),'r--',1:N,10*log10(Jexinf*ones(1,N)),'k--' )
xlabel('iterations')
ylabel('MSE (dB)')
legend(['Minimum MSE'],['MSE'],['Excess MSE'],['steady-state MSE'],['steady-state Excess MSE'])
grid



